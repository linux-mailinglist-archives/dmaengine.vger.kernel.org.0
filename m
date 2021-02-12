Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D006531A3D0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhBLRjV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43134 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231604AbhBLRjF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:05 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 21CC6C044A;
        Fri, 12 Feb 2021 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151484; bh=26bcMb1hhhSb/6zwC97LYr49GH4oBhX47qSAAxTu+pw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hL2UsWJqkV8Pv6eFFwp3WHjfPx/7/1tBUWIgHMxx6faYcP/QSqsrJqxxiZsfLZXbJ
         +stIFaPunK+Lhbc8OkRFPkFculVmSk0SATSbFK8JG8TiN3w01R5g5phsW0m9RcdsiT
         jr0nJegN44I9b+dc0FpCvEA73yGqAm8CXBmK3tV3Wiex507/XDcy4AU2jCG4tGDJ7s
         tBw1mn3rRM0+KdY1MpciG8KCVAgmLVU6WG1sczqVhNLDpZH1nPg29qTMYaZ4IA9Zw/
         S2kKIM88z+tF11cO2JWK4Q5ZrfzwmH+7qzJ+PbNsHxidspVfftJCeCj/WY+NqJk1g5
         dMLmD+qjABxaQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E77A5A005D;
        Fri, 12 Feb 2021 17:38:02 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 07/15] dmaengine: dw-edma: Improve number of channels check
Date:   Fri, 12 Feb 2021 18:37:42 +0100
Message-Id: <325ba441d82f249a135d42f3c3b898dfe3e7df04.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
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

