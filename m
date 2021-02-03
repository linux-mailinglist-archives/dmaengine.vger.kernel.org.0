Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9327E30E199
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 18:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBCR6c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 12:58:32 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49774 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232384AbhBCR6Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:58:25 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 53E7140216;
        Wed,  3 Feb 2021 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612375042; bh=26bcMb1hhhSb/6zwC97LYr49GH4oBhX47qSAAxTu+pw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MsSNNGyvL/xoKGLoZZMK1PVXdwFPgy2gPRZOBdWa9az9c4rRJgJaMSnTHjeziil3i
         KloscSscoFhCP+OzYqP8VFFMYk7SetcK89QzQ3Uz5A4aFK+M6yaSznbbYLRr7KINOj
         3U3X0FAaj46zabByvjSqZ1cyPVC68ea+Ao/t9vdiD/boSNPq1kLz5dNPIc/1wKhdXn
         ifNbc2h8twUFpe59xPxXTIrsW+tm9Uqm9eOulVhJWoUFvTph+YebbWA/G1Z7HyWVYA
         AZurKju84uVkfwXqvcAAJplkbmQ1VHDKeB/Ig1ftemurELYBeQzSoFrh0X487BZiDl
         8IRH2ndl3NPdw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2FDF4A005F;
        Wed,  3 Feb 2021 17:57:21 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 07/15] dmaengine: dw-edma: Improve number of channels check
Date:   Wed,  3 Feb 2021 18:56:59 +0100
Message-Id: <c70f23ba8cb76facbb620bbad2814b29209db6b9.1612374941.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
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

