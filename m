Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F530BE93
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhBBMpv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:45:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44074 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhBBMl5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:41:57 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ED36E401F6;
        Tue,  2 Feb 2021 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612269657; bh=Q8p1awFRWvZQwAEJydjROiaIceJgT6c3cpPWic23uwQ=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SKRUwjZib6AE8nJ5NFI4yNTZGGpv7IqVWgt03IV3BdpCav6vc5C6A4pRDKKuJnJcg
         C/8xueBh2l39/tAmhxhZBYqTaDixjwqxvvSNRjZbLjrb//1ryhT5MvSEZBE1jza42e
         gBeX7rxaO1WD7ydCV5sTibhVoydY5l6t+U6w+BXUKXUIwmcZWtC96gr3s05yLEQ7CV
         6LjDUlX7zuHxMVvRMqBSxQMrWKcYWPlhW0erTVu8fqVG+NlrSIJyOnSV+arHTnXjDl
         /53TlxbdRCbhg/IhM58wLydszNTjNi4aGXamDZBarUlVUnNgv/zBV2NXntPrenzVjC
         s1n1ttAy5Ri6A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B4290A0249;
        Tue,  2 Feb 2021 12:40:55 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 10/15] dmaengine: dw-edma: Change linked list and data blocks offset and sizes
Date:   Tue,  2 Feb 2021 13:40:24 +0100
Message-Id: <b9a77ab9d807a3472b38b15d73f79b16fdac989d.1612269537.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
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
index a0fa809..686b4ff 100644
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

