Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F931A3D4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBLRj0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:26 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42862 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231638AbhBLRjH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:07 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 21FB740C78;
        Fri, 12 Feb 2021 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151487; bh=RCnDpO53Bb/0HVUjN9B8wC3VPb4hWflIDzyjkR3OoEo=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TxD9ua2FQ0rWusjhPrPEgECQe7nq83EWuLsmhbaeCCg81YSFJfvaY8hd/QS34jpZM
         21uuoP8ybFyb6Snk79xfr2wSUmiT+X8OMs9Ngi1oS+Vy3u0V65ocZnPYdV6FULimuH
         bvzip6b5n34GpjoNB8yFTRCSGeKxQtDIyjo5nKkK7qSqI+803wXwX2PEEain2UF5On
         VUeepaec6oQd79y8qASOcw1fjh0aXFFTf1unyzAa9dDmuATr5zGCh63+kdyEc87JXX
         9AiHeZoUb0t3HjDVT9g5g0KLqfsTniM6Mq7ejd1kPVthhzCXgiWcX1SC9RRci4euAL
         B9mMc/UzSR/Ag==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E40D2A005C;
        Fri, 12 Feb 2021 17:38:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 10/15] dmaengine: dw-edma: Change linked list and data blocks offset and sizes
Date:   Fri, 12 Feb 2021 18:37:45 +0100
Message-Id: <caf16e8aa489482278a5f487f0cce95f1579ff4f.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Changes the linked list and data blocks offset and sizes to follow the
recommendation given by the hardware team for the IPK solution.

Although the previous data blocks offset and sizes are still valid and
functional, using them that might present some issues related to the IPK
solution, since this solution is based on FPGA and might be subjected to
timmings constrains.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 4e404f9..502de71 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -59,29 +59,29 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.rg.sz				= 0x00002000,	/*  8 Kbytes */
 	/* eDMA memory linked list location */
 	.ll_wr = {
-		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00000000, 0x00200000)
-		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00200000, 0x00200000)
+		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00000000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00200000, 0x00000800)
 	},
 	.ll_rd = {
-		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00400000, 0x00200000)
-		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00600000, 0x00200000)
+		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00400000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00600000, 0x00000800)
 	},
 	/* eDMA memory data location */
 	.dt_wr = {
-		/* Channel 0 - BAR 2, offset 8 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x00800000, 0x00e00000)
-		/* Channel 1 - BAR 2, offset 22 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x01600000, 0x00e00000)
+		/* Channel 0 - BAR 2, offset 8 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00800000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 9 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00900000, 0x00000800)
 	},
 	.dt_rd = {
-		/* Channel 0 - BAR 2, offset 36 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x02400000, 0x00e00000)
-		/* Channel 1 - BAR 2, offset 50 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x03200000, 0x00e00000)
+		/* Channel 0 - BAR 2, offset 10 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00a00000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 11 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00b00000, 0x00000800)
 	},
 	/* Other */
 	.mf				= EDMA_MF_EDMA_UNROLL,
-- 
2.7.4

