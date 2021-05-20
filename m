Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A338B327
	for <lists+dmaengine@lfdr.de>; Thu, 20 May 2021 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhETP0a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 11:26:30 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55444 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbhETPZw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 11:25:52 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4DB8DEE;
        Thu, 20 May 2021 17:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621524267;
        bh=xYjj+txXnFrRcpyv9oqbDrdONQMheeJuEAqdZHA11eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wE+w9qdhyizefZJyQ94OkRRfEjeYd2XlWxARXtpxutbyDk4FcVMZrINvtW91MQ6DU
         iUJzGJYyhFhf19vXstGisvOaC3OrJ+5kmXilkIrFa3RsYL8UOzBGEv2qaGbBIsu3Tn
         y9pn9m/WTf9UkFkwdjlCz+42HkzZC37pknIiWiI4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jianqiang Chen <jianqian@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] dmaengine: xilinx: dpdma: Print channel number in kernel log messages
Date:   Thu, 20 May 2021 18:24:18 +0300
Message-Id: <20210520152420.23986-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
References: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To ease debugging, add the channel number to all kernel log messages
related to a particular channel.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 32 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 70b29bd079c9..ea56c3b35782 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -702,8 +702,9 @@ xilinx_dpdma_chan_prep_interleaved_dma(struct xilinx_dpdma_chan *chan,
 	size_t stride = hsize + xt->sgl[0].icg;
 
 	if (!IS_ALIGNED(xt->src_start, XILINX_DPDMA_ALIGN_BYTES)) {
-		dev_err(chan->xdev->dev, "buffer should be aligned at %d B\n",
-			XILINX_DPDMA_ALIGN_BYTES);
+		dev_err(chan->xdev->dev,
+			"chan%u: buffer should be aligned at %d B\n",
+			chan->id, XILINX_DPDMA_ALIGN_BYTES);
 		return NULL;
 	}
 
@@ -934,7 +935,9 @@ static int xilinx_dpdma_chan_notify_no_ostand(struct xilinx_dpdma_chan *chan)
 
 	cnt = xilinx_dpdma_chan_ostand(chan);
 	if (cnt) {
-		dev_dbg(chan->xdev->dev, "%d outstanding transactions\n", cnt);
+		dev_dbg(chan->xdev->dev,
+			"chan%u: %d outstanding transactions\n",
+			chan->id, cnt);
 		return -EWOULDBLOCK;
 	}
 
@@ -970,8 +973,8 @@ static int xilinx_dpdma_chan_wait_no_ostand(struct xilinx_dpdma_chan *chan)
 		return 0;
 	}
 
-	dev_err(chan->xdev->dev, "not ready to stop: %d trans\n",
-		xilinx_dpdma_chan_ostand(chan));
+	dev_err(chan->xdev->dev, "chan%u: not ready to stop: %d trans\n",
+		chan->id, xilinx_dpdma_chan_ostand(chan));
 
 	if (ret == 0)
 		return -ETIMEDOUT;
@@ -1005,8 +1008,8 @@ static int xilinx_dpdma_chan_poll_no_ostand(struct xilinx_dpdma_chan *chan)
 		return 0;
 	}
 
-	dev_err(chan->xdev->dev, "not ready to stop: %d trans\n",
-		xilinx_dpdma_chan_ostand(chan));
+	dev_err(chan->xdev->dev, "chan%u: not ready to stop: %d trans\n",
+		chan->id, xilinx_dpdma_chan_ostand(chan));
 
 	return -ETIMEDOUT;
 }
@@ -1060,7 +1063,8 @@ static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 		vchan_cyclic_callback(&active->vdesc);
 	else
 		dev_warn(chan->xdev->dev,
-			 "DONE IRQ with no active descriptor!\n");
+			 "chan%u: DONE IRQ with no active descriptor!\n",
+			 chan->id);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
@@ -1148,10 +1152,12 @@ static void xilinx_dpdma_chan_handle_err(struct xilinx_dpdma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	dev_dbg(xdev->dev, "cur desc addr = 0x%04x%08x\n",
+	dev_dbg(xdev->dev, "chan%u: cur desc addr = 0x%04x%08x\n",
+		chan->id,
 		dpdma_read(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDRE),
 		dpdma_read(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDR));
-	dev_dbg(xdev->dev, "cur payload addr = 0x%04x%08x\n",
+	dev_dbg(xdev->dev, "chan%u: cur payload addr = 0x%04x%08x\n",
+		chan->id,
 		dpdma_read(chan->reg, XILINX_DPDMA_CH_PYLD_CUR_ADDRE),
 		dpdma_read(chan->reg, XILINX_DPDMA_CH_PYLD_CUR_ADDR));
 
@@ -1167,7 +1173,8 @@ static void xilinx_dpdma_chan_handle_err(struct xilinx_dpdma_chan *chan)
 	xilinx_dpdma_chan_dump_tx_desc(chan, active);
 
 	if (active->error)
-		dev_dbg(xdev->dev, "repeated error on desc\n");
+		dev_dbg(xdev->dev, "chan%u: repeated error on desc\n",
+			chan->id);
 
 	/* Reschedule if there's no new descriptor */
 	if (!chan->desc.pending &&
@@ -1232,7 +1239,8 @@ static int xilinx_dpdma_alloc_chan_resources(struct dma_chan *dchan)
 					  align, 0);
 	if (!chan->desc_pool) {
 		dev_err(chan->xdev->dev,
-			"failed to allocate a descriptor pool\n");
+			"chan%u: failed to allocate a descriptor pool\n",
+			chan->id);
 		return -ENOMEM;
 	}
 
-- 
Regards,

Laurent Pinchart

