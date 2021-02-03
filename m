Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CE30E1A8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhBCR67 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 12:58:59 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49800 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232459AbhBCR6a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:58:30 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 81A5E40390;
        Wed,  3 Feb 2021 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612375049; bh=WnHPY+sRUSSJJQq7Jc0VtKP64lY4iaChTFLji7S/MT0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TpsQ3cZM02NiaYX+qVVQg+sldMIfDxbsoDq+TqK63r3FSoFj3lgR3z1NqKkgUVsmk
         Jb0xomAuZeQAlLoWXPZK3lZyeYcbiYGcM19VtY08dfHaLduqLKDljp+zOIEKe//jrz
         2YB9sil1B/QMxXDvsicrMSIOdgHjcmZIKpcaZrFS5urMFfE6eZQaRgzKPUdcahIpPW
         ZX7SLqGnl2e6ABLUknmIbSH0cL3VN+NF0O6T7zOHx+0GEu5NPQRCrSG+M0OVftx9NT
         /kVzQNZjdKepc823TYwIFC8Y2yrUhDLpjamFO3eZUpfjMki4AFISRcd73WVllhg9Jv
         bF7577MNSLjEw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5A383A0062;
        Wed,  3 Feb 2021 17:57:28 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 14/15] dmaengine: dw-edma: Revert fix scatter-gather address calculation
Date:   Wed,  3 Feb 2021 18:57:06 +0100
Message-Id: <0565242fb693184b84ef6bb707a0710a13a892bb.1612374941.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
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

