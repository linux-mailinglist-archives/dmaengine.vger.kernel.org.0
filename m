Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E480932FEA0
	for <lists+dmaengine@lfdr.de>; Sun,  7 Mar 2021 05:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhCGEHZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Mar 2021 23:07:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:33384 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhCGEHJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 6 Mar 2021 23:07:09 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3CA6E70;
        Sun,  7 Mar 2021 05:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615090028;
        bh=y+jkPV1NC6KjMIukqojOkEVOMFibg3FcbMZJOGL8khc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XP8NYXq+uevazy6WihbWz7u1oqin15nOxhupJnF9tExpvV834QCO4IhtoxZ7P6rAh
         sGp7gPDtDnXLEGXD+kG5dgSREhwl9pxQFXN0DmtZWS5XElvsxZyC3UOFsHrB/qgD80
         4LnQXtIRuMCmrJDVL57an4M6GMDYMmuaikuakwC8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rohit Visavalia <RVISAVAL@xilinx.com>
Subject: [PATCH 2/2] dmaengine: xilinx: dpdma: Fix race condition in done IRQ
Date:   Sun,  7 Mar 2021 06:06:29 +0200
Message-Id: <20210307040629.29308-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210307040629.29308-1-laurent.pinchart@ideasonboard.com>
References: <20210307040629.29308-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The active descriptor pointer is accessed from different contexts,
including different interrupt handlers, and its access must be protected
by the channel's lock. This wasn't done in the done IRQ handler. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index d504112c609e..70b29bd079c9 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1048,13 +1048,14 @@ static int xilinx_dpdma_chan_stop(struct xilinx_dpdma_chan *chan)
  */
 static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 {
-	struct xilinx_dpdma_tx_desc *active = chan->desc.active;
+	struct xilinx_dpdma_tx_desc *active;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
 	xilinx_dpdma_debugfs_desc_done_irq(chan);
 
+	active = chan->desc.active;
 	if (active)
 		vchan_cyclic_callback(&active->vdesc);
 	else
-- 
Regards,

Laurent Pinchart

