Return-Path: <dmaengine+bounces-326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3A7FED98
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 12:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D31C20DD1
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A14CB32;
	Thu, 30 Nov 2023 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TSGUGq39"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286ED7F
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 03:13:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 450DCE000C;
	Thu, 30 Nov 2023 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701342799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0ykNUJ2kFDm3k5yqNT/ynxXgE8XMTUj76b31z5S5mM=;
	b=TSGUGq39CatfWi5MY3kNjIq9/5S2nf0uMAT4QwvhkTggVZrUy9d3GTNtEFUE/wCAbCKKDD
	fJAD1Vkmsybk75OQ8QxzazEBSNUxI9Z19icWP2+1OSiNMzsWKfW6tHpDoKon8Xk1iGApcx
	a0GRzO33LgP/irW1OAs5mVFolVAxIksI7uw68ISNXZhSuHgWqAW0xRAcKP0gZ8cabiqvMf
	H+7ujWJQ3yrXdqOzXLPS/Z68Gr4n5Vu97rTUEtE9kN/TbXs5IUv2rUfxxizUbtfJpo4V2v
	lbxvpwHZN9/CieALiHBEfoznebfLrqJreY1GovqRMD55OulcA2Ra/QLRla0mVg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michal Simek <monstr@monstr.eu>,
	dmaengine@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks
Date: Thu, 30 Nov 2023 12:13:15 +0100
Message-Id: <20231130111315.729430-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130111315.729430-1-miquel.raynal@bootlin.com>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

The driver is capable of starting scatter-gather transfers and needs to
wait until their end. It is also capable of starting cyclic transfers
and will only be "reset" next time the channel will be reused. In
practice most of the time we hear no audio glitch because the sound card
stops the flow on its side so the DMA transfers are just
discarded. There are however some cases (when playing a bit with a
number of frames and with a discontinuous sound file) when the sound
card seems to be slightly too slow at stopping the flow, leading to a
glitch that can be heard.

In all cases, we need to earn better control of the DMA engine and
adding proper ->device_terminate_all() and ->device_synchronize()
callbacks feels totally relevant. With these two callbacks, no glitch
can be heard anymore.

Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfers")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

This was only tested with cyclic transfers.
---
 drivers/dma/xilinx/xdma.c | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index e931ff42209c..290bb5d2d1e2 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -371,6 +371,31 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
 		return ret;
 
 	xchan->busy = true;
+
+	return 0;
+}
+
+/**
+ * xdma_xfer_stop - Stop DMA transfer
+ * @xchan: DMA channel pointer
+ */
+static int xdma_xfer_stop(struct xdma_chan *xchan)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&xchan->vchan);
+	struct xdma_device *xdev = xchan->xdev_hdl;
+	int ret;
+
+	if (!vd || !xchan->busy)
+		return -EINVAL;
+
+	/* clear run stop bit to prevent any further auto-triggering */
+	ret = regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
+			   CHAN_CTRL_RUN_STOP);
+	if (ret)
+		return ret;
+
+	xchan->busy = false;
+
 	return 0;
 }
 
@@ -475,6 +500,47 @@ static void xdma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
 }
 
+/**
+ * xdma_terminate_all - Terminate all transactions
+ * @chan: DMA channel pointer
+ */
+static int xdma_terminate_all(struct dma_chan *chan)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_desc *desc = NULL;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
+	xdma_xfer_stop(xdma_chan);
+
+	vd = vchan_next_desc(&xdma_chan->vchan);
+	if (vd)
+		desc = to_xdma_desc(vd);
+	if (desc) {
+		dma_cookie_complete(&desc->vdesc.tx);
+		vchan_terminate_vdesc(&desc->vdesc);
+	}
+
+	vchan_get_all_descriptors(&xdma_chan->vchan, &head);
+	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
+	vchan_dma_desc_free_list(&xdma_chan->vchan, &head);
+
+	return 0;
+}
+
+/**
+ * xdma_synchronize - Synchronize terminated transactions
+ * @chan: DMA channel pointer
+ */
+static void xdma_synchronize(struct dma_chan *chan)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+
+	vchan_synchronize(&xdma_chan->vchan);
+}
+
 /**
  * xdma_prep_device_sg - prepare a descriptor for a DMA transaction
  * @chan: DMA channel pointer
@@ -1088,6 +1154,8 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->dma_dev.device_prep_slave_sg = xdma_prep_device_sg;
 	xdev->dma_dev.device_config = xdma_device_config;
 	xdev->dma_dev.device_issue_pending = xdma_issue_pending;
+	xdev->dma_dev.device_terminate_all = xdma_terminate_all;
+	xdev->dma_dev.device_synchronize = xdma_synchronize;
 	xdev->dma_dev.filter.map = pdata->device_map;
 	xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
 	xdev->dma_dev.filter.fn = xdma_filter_fn;
-- 
2.34.1


