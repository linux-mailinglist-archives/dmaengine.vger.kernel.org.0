Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F223186F5
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBKJUT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:20:19 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34204 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhBKJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CE67D40173;
        Thu, 11 Feb 2021 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034790; bh=WnHPY+sRUSSJJQq7Jc0VtKP64lY4iaChTFLji7S/MT0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=jquiJ2wIl9uIDg/KODiRJ7Ts2W8oRgwgg0q9e/RrtsygIJInLJfRkpKgWrT3gJ11C
         fiFbzvnlY9Uf1FGe/hogA+CRxdKS4jcj/m7EAS46dABwCTq9wWO/M8iTcUwlmRJ4x4
         fhus7YJvnmJzHjH/KfVNaQqMg6SxpO//zzF3oAOQJcouQ7KaXVF6k64Pswav3OVvSD
         fG4CDjNCW+30ZhCCTu/4skRlTouRRXHBqsM3+y8FzaevEvW9OwzVjXe7UM/a9s0NVU
         OISRrGLIgiB1eKcfRZFmKptjbyhYxMPPIH0ouixuxHqVscAp5pZSprKXAd/iR4LVpw
         umD38hcQbIVkA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A36E1A0066;
        Thu, 11 Feb 2021 09:13:08 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 14/15] dmaengine: dw-edma: Revert fix scatter-gather address calculation
Date:   Thu, 11 Feb 2021 10:12:47 +0100
Message-Id: <d936e828ff186d7f4cb6a75ca7a38a91a1f4fd46.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reverting the applied patch because it caused a regression on
ARC700 platform (32 bits).

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

