Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFCB086E
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2019 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfILFrm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Sep 2019 01:47:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36835 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILFrl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Sep 2019 01:47:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id j191so2286602pgd.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Sep 2019 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FH3mQ5WAiHQBqx7gMhW2IlaC7Eov6CFwaWdgd/wFtP0=;
        b=PYvX2Jjybf3jSculUvceSAy/P291IbUmtLltNSdFEVC5AYj8qeTuf0g8XKlMS2wcFI
         JtcmmkEyaOZvDhY5hJ9Mw5GYsAJjxQl7ktGVSZTDMr9d4jmDAXazAxnXDXMarAsnfNfU
         so7YUkqKuZ0GXE6lw8rxrW+vkoVyLDMFian057P0TYQ7iw+OBfmkhofNnApRI98Yuz5T
         HnVGGeArV8Z9PyZO4jnyFyG2xQmbHAa88kLYXZL/HD7WidVbCdAk4SCcmp+UKgcZo1Gs
         oilRMXiMwKRfzwrpQmqKvuHqV+otT1JA37Dt2gNR6PLb4u1gK6m7hyOF1TlIVKp7v528
         Wk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FH3mQ5WAiHQBqx7gMhW2IlaC7Eov6CFwaWdgd/wFtP0=;
        b=kPFBcUcqaQ3UQ4p/p577D4Xq1fVQjMLqWbkm4qf70uxioArFrrOQkYJ4A3MpO5jqkU
         8GuQGwdg/mbmdUBX8GUp0BaxQgi4AhhuO8iyfFWBmbA6WhXK4HBXWkhF2d/gFQpzhS61
         xFbW9BSm8JjQ/s8PmgatYhSRmLvIglGiwvJ3aUMXcjBL9TbG1W94YXuo7tOZR2ZH1Bu/
         0bKGC8cmiJy+4kVomgknRrhMLJK8OmxsIoUi8HwB1Cm/5pJStCYhg8xzSqG4YPxWKCaV
         FO5Slu3TOmytVRB/B5kRAkA1IyN/tv2UEMYmg1fME7ztPE9FDiir9VzPl96nbMVLYd98
         bzVQ==
X-Gm-Message-State: APjAAAVhnt+PwlpVu9ZIVfTfxINlCfN8QcnOQpvn0W7OeP6AIK5nc2QA
        m6lYwGhu7gfIJ8D4DqsvFCIlZw==
X-Google-Smtp-Source: APXvYqzawCx7eqyzXmhV+Jo2ika+EmyDdJc35lAYkargw+zex++LvLDrzPw5U8tDy+o77DlgsHOQ0g==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr35715713pgv.71.1568267259688;
        Wed, 11 Sep 2019 22:47:39 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t14sm13228602pgb.33.2019.09.11.22.47.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 22:47:38 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com, baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Fix the link-list pointer register configuration issue
Date:   Thu, 12 Sep 2019 13:47:18 +0800
Message-Id: <eadfe9295499efa003e1c344e67e2890f9d1d780.1568267061.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Zhenfang Wang <zhenfang.wang@unisoc.com>

We will set the link-list pointer register point to next link-list
configuration's physical address, which can load DMA configuration
from the link-list node automatically.

But the link-list node's physical address can be larger than 32bits,
and now Spreadtrum DMA driver only supports 32bits physical address,
which may cause loading a incorrect DMA configuration when starting
the link-list transfer mode. According to the DMA datasheet, we can
use SRC_BLK_STEP register (bit28 - bit31) to save the high bits of the
link-list node's physical address to fix this issue.

Fixes: 4ac695464763 ("dmaengine: sprd: Support DMA link-list mode")
Signed-off-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 525dc73..a4a91f2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -134,6 +134,10 @@
 #define SPRD_DMA_SRC_TRSF_STEP_OFFSET	0
 #define SPRD_DMA_TRSF_STEP_MASK		GENMASK(15, 0)
 
+/* SPRD DMA_SRC_BLK_STEP register definition */
+#define SPRD_DMA_LLIST_HIGH_MASK	GENMASK(31, 28)
+#define SPRD_DMA_LLIST_HIGH_SHIFT	28
+
 /* define DMA channel mode & trigger mode mask */
 #define SPRD_DMA_CHN_MODE_MASK		GENMASK(7, 0)
 #define SPRD_DMA_TRG_MODE_MASK		GENMASK(7, 0)
@@ -717,6 +721,7 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	u32 int_mode = flags & SPRD_DMA_INT_MASK;
 	int src_datawidth, dst_datawidth, src_step, dst_step;
 	u32 temp, fix_mode = 0, fix_en = 0;
+	phys_addr_t llist_ptr;
 
 	if (dir == DMA_MEM_TO_DEV) {
 		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
@@ -814,13 +819,16 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 		 * Set the link-list pointer point to next link-list
 		 * configuration's physical address.
 		 */
-		hw->llist_ptr = schan->linklist.phy_addr + temp;
+		llist_ptr = schan->linklist.phy_addr + temp;
+		hw->llist_ptr = lower_32_bits(llist_ptr);
+		hw->src_blk_step = (upper_32_bits(llist_ptr) << SPRD_DMA_LLIST_HIGH_SHIFT) &
+			SPRD_DMA_LLIST_HIGH_MASK;
 	} else {
 		hw->llist_ptr = 0;
+		hw->src_blk_step = 0;
 	}
 
 	hw->frg_step = 0;
-	hw->src_blk_step = 0;
 	hw->des_blk_step = 0;
 	return 0;
 }
-- 
1.7.9.5

