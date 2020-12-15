Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06E22DB2A3
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgLORcE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 12:32:04 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46062 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731296AbgLORbt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 12:31:49 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3BEC8C04D9;
        Tue, 15 Dec 2020 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053448; bh=WnHPY+sRUSSJJQq7Jc0VtKP64lY4iaChTFLji7S/MT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Tw7puXCYNl+bk6YvaewpFS6pQVFi1Qw5ZiCtKQA4QrNAEQzF/f55ioOwaT5QkU132
         3zj/KzuxeQY3C5y44F4k6FUqu4vuCjZCNqeAxJucM82PqiK+FRxJ4Tz11p/qgY6DFd
         bKpet08cZL71sYA+umBoFQQz0dIk2tQqiLLhi++Mp4WiDUEoF5+GOy8SV5uioDx45m
         zGhIcDfbJc/kG/0Mjsv/oTO7PbwORB2zmQF6jbQngl9dlnkm+rEMY3nBzMCo5bq7zk
         FRPPtSCflOjxHU9unimmhY74ctJN0cKKQP9RWTSKd/macPZikj3HvFVTKTw46e89bB
         OFMnZOqu7XBVw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id CFE07A005C;
        Tue, 15 Dec 2020 17:30:46 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] dmaengine: dw-edma: Revert fix scatter-gather address calculation
Date:   Tue, 15 Dec 2020 18:30:23 +0100
Message-Id: <4ef952dc04b2831f82b63ec8becd7b04a93a84ca.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
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

