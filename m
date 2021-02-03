Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6231130E56E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhBCWAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:00:18 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60284 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232664AbhBCV71 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 16:59:27 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 061EC404A0;
        Wed,  3 Feb 2021 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389507; bh=WnHPY+sRUSSJJQq7Jc0VtKP64lY4iaChTFLji7S/MT0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gpkrBn8fEoMQJYGKJysQvgf2NYWEEA+GFnepWAuRg8hjx21g5RPxScAm0eCxLBi0/
         rVPBpR6EnIKdG7NGYzIvorm8UrLUpVrd4cbxxuEZZQjQiz4e1PpSLt1cBllDkk/7Hj
         eAt+zJPiWn+H/sY5LDlUfm9rBe7FdH9h6eczTHi55jnbC9WjlGU48tf0bVWQWVOyOm
         hT1nJ7DrUL95y7E7B9x+lFfXZVALe7OTfG48OwEbOwRukeZS/vpdQBa4QkEcAOh2+s
         p3RtHSDB/nYKqWLbLBxXGSPMhbFS3tZonBDjbKzCzBvVzZ0Zz+f1EIg3SkHZYU+iW8
         0qYe7seAs9GZA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id D164BA0249;
        Wed,  3 Feb 2021 21:58:25 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 14/15] dmaengine: dw-edma: Revert fix scatter-gather address calculation
Date:   Wed,  3 Feb 2021 22:58:05 +0100
Message-Id: <d936e828ff186d7f4cb6a75ca7a38a91a1f4fd46.1612389406.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
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

