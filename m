Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27B38B326
	for <lists+dmaengine@lfdr.de>; Thu, 20 May 2021 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhETP03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhETPZw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 11:25:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6007AC06138F
        for <dmaengine@vger.kernel.org>; Thu, 20 May 2021 08:24:30 -0700 (PDT)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 553A2E0C;
        Thu, 20 May 2021 17:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621524267;
        bh=MPyQ+vVZp1sQ3qtNieVc8s7/Xsyl8i4v0/UXQm+IvIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGOUGGA21/1rv5wxW6yBhBppnaVa6KmxExVQ4kEV99ghDgvbyADmETmRitlEx+HQ6
         A0+JyMEGGHC+qTaFXJn453jpeqAjHFhZGIfKg8c/prDEb6sJVqU4k5Jnvf2P0qCRpj
         LMZ/XF2q8uNg+lUSrUPvsR04rFHpiud03+PdLrIw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jianqiang Chen <jianqian@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] dmaengine: xilinx: dpdma: Print debug message when losing vsync race
Date:   Thu, 20 May 2021 18:24:19 +0300
Message-Id: <20210520152420.23986-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
References: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The hardware retrigger is inherently racy with the vsync interrupt. This
isn't an issue as the hardware provides a way to detect a race loss and
handle it correctly. When debugging issues related to this, it's useful
to get a notification of the race loss. Add a debug message to do so.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index ea56c3b35782..5834f8614a58 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1095,8 +1095,12 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 	/* If the retrigger raced with vsync, retry at the next frame. */
 	sw_desc = list_first_entry(&pending->descriptors,
 				   struct xilinx_dpdma_sw_desc, node);
-	if (sw_desc->hw.desc_id != desc_id)
+	if (sw_desc->hw.desc_id != desc_id) {
+		dev_dbg(chan->xdev->dev,
+			"chan%u: vsync race lost (%u != %u), retrying\n",
+			chan->id, sw_desc->hw.desc_id, desc_id);
 		goto out;
+	}
 
 	/*
 	 * Complete the active descriptor, if any, promote the pending
-- 
Regards,

Laurent Pinchart

