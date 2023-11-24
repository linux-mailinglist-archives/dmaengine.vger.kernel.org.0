Return-Path: <dmaengine+bounces-236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C377F7A09
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F8A280E58
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F282E831;
	Fri, 24 Nov 2023 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="fJhNRi7E"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63261718;
	Fri, 24 Nov 2023 09:05:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 0A87C2CE00BE;
	Fri, 24 Nov 2023 18:05:30 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qFpIe5Q3Kcxm; Fri, 24 Nov 2023 18:05:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 875312CE00BF;
	Fri, 24 Nov 2023 18:05:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 875312CE00BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700845525;
	bh=bEGIIU6XFTjGhVc6C6IiQ8qSXjZ6VNmdwsVWm1Cgupw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=fJhNRi7EAZoPx7k8fZ+iijb8z4IV+km4hBo6mMA6DZ/0tI6N3rGFuiQuwd8NSm4t0
	 QAe3eDXU2xwQDbBr5b0FS2fosXkujRMqytK1Q00GliuzV5Dv8YOnjB/kbsyp1aHbcF
	 VvJ3za4OfNWylmqsESLdESJ1qR1Hn8JwO270+XNtGQr+pTdS7r/WbWkkYedRWu/RoJ
	 IRzG+3Oi92QT0hBsx5dOIZ+/5Me0CtcCALB8TE65NmOV0q/imcxXHXVp3k0yrku6Pc
	 mlYtDMHy0DRLzKx1L7wHp+rrmh8dyDChsTB8MtQKy+Cl8dKmysB9D/+q7iAD9WIwgA
	 p8Lwy92C7Otuw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BdYI3ict_4H3; Fri, 24 Nov 2023 18:05:25 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 402ED2CE00BE;
	Fri, 24 Nov 2023 18:05:25 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH v2 1/5] dmaengine: xilinx: xdma: Add transfer termination callbacks
Date: Fri, 24 Nov 2023 18:05:17 +0100
Message-Id: <20231124170517.130994-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122220921.117428-2-jankul@alatek.krakow.pl>
References: <20231122220921.117428-2-jankul@alatek.krakow.pl>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The xdma driver currently doesn't implement proper transfer termination
callbacks. Therefore, there is no way to gracefully terminate the
on-going DMA transactions. That is particularly useful for cyclic DMA
transfers. Implement these callbacks.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h |  1 +
 drivers/dma/xilinx/xdma.c      | 60 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index e641a5083e14..1f17ce165f92 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -76,6 +76,7 @@ struct xdma_hw_desc {
 #define XDMA_CHAN_CONTROL_W1S		0x8
 #define XDMA_CHAN_CONTROL_W1C		0xc
 #define XDMA_CHAN_STATUS		0x40
+#define XDMA_CHAN_STATUS_RC		0x44
 #define XDMA_CHAN_COMPLETED_DESC	0x48
 #define XDMA_CHAN_ALIGNMENTS		0x4c
 #define XDMA_CHAN_INTR_ENABLE		0x90
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 84a88029226f..013fd79d65b2 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -632,6 +632,64 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr=
_t address,
 	return NULL;
 }
=20
+/**
+ * xdma_terminate_all - Halt the DMA channel
+ * @chan: DMA channel
+ */
+static int xdma_terminate_all(struct dma_chan *chan)
+{
+	int ret;
+	u32 val;
+	unsigned long flags;
+	struct xdma_chan *xchan =3D to_xdma_chan(chan);
+	struct xdma_device *xdev =3D xchan->xdev_hdl;
+	struct virt_dma_desc *vd;
+	LIST_HEAD(head);
+
+	/* Clear the RUN bit to stop the transfer */
+	ret =3D regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
+							CHAN_CTRL_RUN_STOP);
+	if (ret)
+		return ret;
+
+	/* Clear the channel status register */
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val=
);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&xchan->vchan.lock, flags);
+
+	/* Don't care if there were no descriptors issued */
+	vd =3D vchan_next_desc(&xchan->vchan);
+	if (vd) {
+		/*
+		 * No need to delete the vd from the vc.desc_issued list,
+		 * every desc list is going to be spliced into vc.desc_terminated
+		 * and initialized anyway.
+		 */
+		vchan_cookie_complete(vd);
+		vchan_terminate_vdesc(vd);
+	}
+	vchan_get_all_descriptors(&xchan->vchan, &head);
+	list_splice_tail(&head, &xchan->vchan.desc_terminated);
+
+	xchan->busy =3D false;
+	spin_unlock_irqrestore(&xchan->vchan.lock, flags);
+
+	return 0;
+}
+
+/**
+ * xdma_synchronize - Synchronize current execution context to the DMA c=
hannel
+ * @chan: DMA channel
+ */
+static void xdma_synchronize(struct dma_chan *chan)
+{
+	struct xdma_chan *xchan =3D to_xdma_chan(chan);
+
+	vchan_synchronize(&xchan->vchan);
+}
+
 /**
  * xdma_device_config - Configure the DMA channel
  * @chan: DMA channel
@@ -1093,6 +1151,8 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->dma_dev.filter.mapcnt =3D pdata->device_map_cnt;
 	xdev->dma_dev.filter.fn =3D xdma_filter_fn;
 	xdev->dma_dev.device_prep_dma_cyclic =3D xdma_prep_dma_cyclic;
+	xdev->dma_dev.device_terminate_all =3D xdma_terminate_all;
+	xdev->dma_dev.device_synchronize =3D xdma_synchronize;
=20
 	ret =3D dma_async_device_register(&xdev->dma_dev);
 	if (ret) {
--=20
2.34.1


