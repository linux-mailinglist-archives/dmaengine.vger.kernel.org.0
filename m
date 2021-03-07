Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74132FEA1
	for <lists+dmaengine@lfdr.de>; Sun,  7 Mar 2021 05:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCGEHZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Mar 2021 23:07:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:33374 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCGEHI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 6 Mar 2021 23:07:08 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 672213F5;
        Sun,  7 Mar 2021 05:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615090025;
        bh=w1OG/ETIzAQ6bB7Dn+DCMdfkPhQRBsNRWVNAckwVagA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPueyWGH103uncoydLtU4CRuQU7urP6ecYL/dql5TFvnMbAyXSSIzTgpUHq62b5Jt
         pSAeQlyZ+u/6XUTBxIZK9TwMNuTBoNTMUtQPAoGAFbs2BXDwDlX64LOy5A39SLhPOA
         RMB44aoBA+pOBgE7t1Wbr1FbNUbJrGYma92payQg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rohit Visavalia <RVISAVAL@xilinx.com>
Subject: [PATCH 1/2] dmaengine: xilinx: dpdma: Fix descriptor issuing on video group
Date:   Sun,  7 Mar 2021 06:06:28 +0200
Message-Id: <20210307040629.29308-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210307040629.29308-1-laurent.pinchart@ideasonboard.com>
References: <20210307040629.29308-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When multiple channels are part of a video group, the transfer is
triggered only when all channels in the group are ready. The logic to do
so is incorrect, as it causes the descriptors for all channels but the
last one in a group to not being pushed to the hardware. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 55df63dead8d..d504112c609e 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -839,6 +839,7 @@ static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan *chan)
 	struct xilinx_dpdma_tx_desc *desc;
 	struct virt_dma_desc *vdesc;
 	u32 reg, channels;
+	bool first_frame;
 
 	lockdep_assert_held(&chan->lock);
 
@@ -852,14 +853,6 @@ static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan *chan)
 		chan->running = true;
 	}
 
-	if (chan->video_group)
-		channels = xilinx_dpdma_chan_video_group_ready(chan);
-	else
-		channels = BIT(chan->id);
-
-	if (!channels)
-		return;
-
 	vdesc = vchan_next_desc(&chan->vchan);
 	if (!vdesc)
 		return;
@@ -884,13 +877,26 @@ static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan *chan)
 			    FIELD_PREP(XILINX_DPDMA_CH_DESC_START_ADDRE_MASK,
 				       upper_32_bits(sw_desc->dma_addr)));
 
-	if (chan->first_frame)
+	first_frame = chan->first_frame;
+	chan->first_frame = false;
+
+	if (chan->video_group) {
+		channels = xilinx_dpdma_chan_video_group_ready(chan);
+		/*
+		 * Trigger the transfer only when all channels in the group are
+		 * ready.
+		 */
+		if (!channels)
+			return;
+	} else {
+		channels = BIT(chan->id);
+	}
+
+	if (first_frame)
 		reg = XILINX_DPDMA_GBL_TRIG_MASK(channels);
 	else
 		reg = XILINX_DPDMA_GBL_RETRIG_MASK(channels);
 
-	chan->first_frame = false;
-
 	dpdma_write(xdev->reg, XILINX_DPDMA_GBL, reg);
 }
 
-- 
Regards,

Laurent Pinchart

