Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43CF31F008
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhBRTjq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:46 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37740 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233714AbhBRTFl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:41 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E202AC0092;
        Thu, 18 Feb 2021 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675066; bh=N+Lz5QIiPGKub9w9KfJ/nARsC4nZVqpX3hhzmAFKL6c=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=M4PbkZgQvxo5Ce2EyXvv6FX6GjaPOCWnyjZAEYD7/UTjRvvAr4NGpn3V9tO7nNYSd
         KlGtev7WFGGu7m8rgYljQAzs776EZ8jrFVF2kyUmDng+OLGanpP6IcZzf+FjULGHca
         aOi0TKldpIdUaghqBnsDrUtNemp/3tMY9ZF8IKvyq9LHjnXb+urVwsgQpbWmneAenB
         KAm2/XsxbCIV9VooJ/1HMakJAtnp6VvIM0yB3IFuZGOe6KnA3/e8hgHr8mgMhAreyz
         H8YaW7YnTTidGTvaecxRx8kVK2c6Y12ZrHY7fR3IL1QwahjU3V91j6gqLEfW/RzFah
         fIzUifcVNsIRw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A7A0FA0063;
        Thu, 18 Feb 2021 19:04:24 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 10/15] dmaengine: dw-edma: Change linked list and data blocks offset and sizes
Date:   Thu, 18 Feb 2021 20:04:04 +0100
Message-Id: <f682e7f7f06dc6b2efdd431481d6fb4d762c2c05.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
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
index 1055fdb..fa66e03 100644
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

