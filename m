Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6210731F005
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhBRTjl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:41 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33138 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233356AbhBRTFk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 587EF402DC;
        Thu, 18 Feb 2021 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675063; bh=Wqkey4yiMdoTXEqnEcqr//kxJiJDGniz0Wv7vpWtnp0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ECvWui8nqqcgZu4BCLzmGSu3o9nhTupqfMNsyhJ0glwDVc6GtynR+d/XZGj9JxEDX
         Ke/08FfWUElg4fFFxfNtqruOLopDF7stEVvGoynsEDq1c/dXaSPP+GOsFP70iH4qQM
         J3GXUdrPrz9a5MIvSpK6y9R6u5z9B0LMeU2DsIKlgBPEZ6UTRjdr17t36ImgtYKUNT
         +l/faNE+esnwGOSVvhyi4zmko7mt5cfPFh5JfnMKn/EwLOi6CWrFX7Q/42iA5egb3C
         xP6XZbJfvZcD4lQc0u2wiijjERJzZIIWPvaylDpxTJU3dMSDvU4o7RwrlpSbsDLO+F
         K63QS9Zer1+Cw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 31FD3A0063;
        Thu, 18 Feb 2021 19:04:22 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 07/15] dmaengine: dw-edma: Improve number of channels check
Date:   Thu, 18 Feb 2021 20:04:01 +0100
Message-Id: <cfb2b0a4f97ae9dc83ebe5ea59d6a51d69ea3654.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
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
index 1227a3e..cc39107 100644
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

