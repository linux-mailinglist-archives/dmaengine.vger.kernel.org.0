Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291FD38B328
	for <lists+dmaengine@lfdr.de>; Thu, 20 May 2021 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhETP0b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 11:26:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55452 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhETPZx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 11:25:53 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8790E2B;
        Thu, 20 May 2021 17:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621524268;
        bh=WJt9uLnd9ahdsuddT0v6yu32+aM2ZZNh5lobu5CEs8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqpqAHl7iBqh9PT5igEKqx9bjuaHuLgu2pM5aEcGK8KqheE7VphQYVwgiKXwKnDa+
         JRQn2wDZ9gkeyV+WH6Zriz+hCyFKdg72OoBfRfd64Mv0nnhjqOjTZ2in/LVXe7HtrX
         l9EcYfsMDnYfXoZpY4TAZCpGWV5H5rDXmHjop1gE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jianqiang Chen <jianqian@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] dmaengine: xilinx: dpdma: Limit descriptor IDs to 16 bits
Date:   Thu, 20 May 2021 18:24:20 +0300
Message-Id: <20210520152420.23986-5-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
References: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While the descriptor ID is stored in a 32-bit field in the hardware
descriptor, only 16 bits are used by the hardware and are reported
through the XILINX_DPDMA_CH_DESC_ID register. Failure to handle the
wrap-around results in a descriptor ID mismatch after 65536 frames. Fix
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 5834f8614a58..6a8bb977fc7a 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -113,6 +113,7 @@
 #define XILINX_DPDMA_CH_VDO				0x020
 #define XILINX_DPDMA_CH_PYLD_SZ				0x024
 #define XILINX_DPDMA_CH_DESC_ID				0x028
+#define XILINX_DPDMA_CH_DESC_ID_MASK			GENMASK(15, 0)
 
 /* DPDMA descriptor fields */
 #define XILINX_DPDMA_DESC_CONTROL_PREEMBLE		0xa5
@@ -867,7 +868,8 @@ static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan *chan)
 	 * will be used, but it should be enough.
 	 */
 	list_for_each_entry(sw_desc, &desc->descriptors, node)
-		sw_desc->hw.desc_id = desc->vdesc.tx.cookie;
+		sw_desc->hw.desc_id = desc->vdesc.tx.cookie
+				    & XILINX_DPDMA_CH_DESC_ID_MASK;
 
 	sw_desc = list_first_entry(&desc->descriptors,
 				   struct xilinx_dpdma_sw_desc, node);
@@ -1090,7 +1092,8 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 	if (!chan->running || !pending)
 		goto out;
 
-	desc_id = dpdma_read(chan->reg, XILINX_DPDMA_CH_DESC_ID);
+	desc_id = dpdma_read(chan->reg, XILINX_DPDMA_CH_DESC_ID)
+		& XILINX_DPDMA_CH_DESC_ID_MASK;
 
 	/* If the retrigger raced with vsync, retry at the next frame. */
 	sw_desc = list_first_entry(&pending->descriptors,
-- 
Regards,

Laurent Pinchart

