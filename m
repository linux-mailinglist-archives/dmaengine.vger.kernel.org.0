Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE383186F2
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBKJTz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:19:55 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56802 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhBKJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 77427C00B9;
        Thu, 11 Feb 2021 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034782; bh=26bcMb1hhhSb/6zwC97LYr49GH4oBhX47qSAAxTu+pw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PTNGelFpNYZ4sbeR708rKzOS4ZBFKvoPfix0Af1TdKs+Wl0MB3FXUawvcM2FzitMG
         +Koo8eCIRB/qnsWqFn0+jBH+vHWWm6XRd3PXMj6wSAG/18O+h03rFZ6giOYEXeYOV1
         Jv5iVRSdY7rrQL6mK73EbWg0gDkqYXFaTSEi97n+q/GE3ltoW36Xpt965RZLPktyCw
         O7eSVt+4Y1tz9dthjkhlopOJPQ+isLwY/hc307Z3LusBu5rJ6jKGylmhw/pIXW+7pj
         5QBJN87lFF3p38F0g2BUoqCFZekKIzpqpLYDXxo9GD0P3zgq6GPL2bJSmIDtUaTWi7
         9YzcGjT9E/C0Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3E644A005D;
        Thu, 11 Feb 2021 09:13:01 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 07/15] dmaengine: dw-edma: Improve number of channels check
Date:   Thu, 11 Feb 2021 10:12:40 +0100
Message-Id: <1a42fc97b18012925454013a64b901e06683c77b.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
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

