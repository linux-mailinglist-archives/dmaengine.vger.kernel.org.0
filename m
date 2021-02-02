Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3C30BE9B
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhBBMqf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:46:35 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56122 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhBBMly (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:41:54 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E6889C00B9;
        Tue,  2 Feb 2021 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612269654; bh=26bcMb1hhhSb/6zwC97LYr49GH4oBhX47qSAAxTu+pw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GjhGm88GM6mqrJMkA0Y+ywVA1p248HNrq/7yH7qnM54QfXUUFWtsVrDNfnHPB+lbj
         Ks5KgvgqwFXNyafJeEPpDQgWp+Ty+C63WdbiH37bSrOxBe4grUdehQw4pb3eGHZJ7L
         so7xFv42Wyjxz1an247V7WrgYjecggbctAkQXooIjBd3me68pGgNSjE7azJ5rdBJCC
         jL6DZqpTr7x+OtA5XQskocGLEt7dNrCsvxyiBaPFDQz1OtlddwJAKAGkNw7IuY9tdf
         XIxE8LJDY3iGQt1wB67ptKQBoRAAWJ7xfJkoPF0aOPJ8C/lyHUsMzQE/JZB7/sDs1l
         Y6o/s4mElHrkg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id ADD47A024B;
        Tue,  2 Feb 2021 12:40:52 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 07/15] dmaengine: dw-edma: Improve number of channels check
Date:   Tue,  2 Feb 2021 13:40:21 +0100
Message-Id: <235c630e318a52af5b36e01deacf720e2e4f1b57.1612269537.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It was added some extra checks to ensure that the driver doesn't try to
use more DMA channels than actually are available in hardware.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 21 +++++++++------------
 drivers/dma/dw-edma/dw-edma-core.h |  2 ++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0fe3835..5495cf7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -914,19 +914,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	if (!dw->wr_ch_cnt) {
-		/* Find out how many write channels are supported by hardware */
-		dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
-		if (!dw->wr_ch_cnt)
-			return -EINVAL;
-	}
+	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
+			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
+	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	if (!dw->rd_ch_cnt) {
-		/* Find out how many read channels are supported by hardware */
-		dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
-		if (!dw->rd_ch_cnt)
-			return -EINVAL;
-	}
+	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
+			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
+	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+
+	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
+		return -EINVAL;
 
 	dev_vdbg(dev, "Channels:\twrite=%d, read=%d\n",
 		 dw->wr_ch_cnt, dw->rd_ch_cnt);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index f72ebaa..650b1c7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -15,6 +15,8 @@
 #include "../virt-dma.h"
 
 #define EDMA_LL_SZ					24
+#define EDMA_MAX_WR_CH					8
+#define EDMA_MAX_RD_CH					8
 
 enum dw_edma_dir {
 	EDMA_DIR_WRITE = 0,
-- 
2.7.4

