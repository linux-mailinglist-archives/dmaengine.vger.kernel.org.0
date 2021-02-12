Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A744531A3DE
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhBLRjq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:46 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43172 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231663AbhBLRjL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:11 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AE9EBC044D;
        Fri, 12 Feb 2021 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151491; bh=cza72HJzMmdde9eBnfdx6GNNXx+ocQY5qXVbCIPgzVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Q1xygNgOLsFp9aUtT6MT6yZc5n/X4KLcoK6TOn9yGG5/4ulqc1Fl+qkNCaq3Fkuf9
         /G0EAPyMEcaihaFUedtFhUSGPscXyzGDe15KnFEzZa7iR/+CWdgp3DDfdC/ZBIpvc6
         S2/4/rjh5XO6LVkJy169AEn1KEFFU4FDw4EiyLlfHpjHJQTiBcZt8CdR+Wvenmq+Fl
         22EQcejztw6djxHP2ftLBG3fe4d6LphUNToiE3dn2JSD7ctxQdM195jBZOWG8jvAYX
         n81OECEaSmSFm5vBUvkyPOhXY5G7XASX2w8lLzQhvfY0l0UVgZs8UivzTsusZqGlYA
         N9gSBG84NnK8A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7F6E8A005E;
        Fri, 12 Feb 2021 17:38:10 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 14/15] dmaengine: dw-edma: Revert fix scatter-gather address calculation
Date:   Fri, 12 Feb 2021 18:37:49 +0100
Message-Id: <b490c360149e53dd4c64c7cd53784c0e631f136e.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reverting the applied patch because it caused a regression on
ARC700 platform (32 bits).

Fixes: 05655541c950 ("dmaengine: dw-edma: Fix scatter-gather address calculation")
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index a299eed..c198451 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -429,7 +429,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
 			} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
-				burst->dar = dst_addr;
+				src_addr += sg_dma_len(sg);
+				burst->dar = sg_dma_address(sg);
 				/* Unlike the typical assumption by other
 				 * drivers/IPs the peripheral memory isn't
 				 * a FIFO memory, in this case, it's a
@@ -443,7 +444,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->sar = xfer->xfer.cyclic.paddr;
 			} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
-				burst->sar = src_addr;
+				dst_addr += sg_dma_len(sg);
+				burst->sar = sg_dma_address(sg);
 				/* Unlike the typical assumption by other
 				 * drivers/IPs the peripheral memory isn't
 				 * a FIFO memory, in this case, it's a
@@ -455,8 +457,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		}
 
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
-			src_addr += sg_dma_len(sg);
-			dst_addr += sg_dma_len(sg);
 			sg = sg_next(sg);
 		} else if (xfer->type == EDMA_XFER_INTERLEAVED &&
 			   xfer->xfer.il->frame_size > 0) {
-- 
2.7.4

