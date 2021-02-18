Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141F231F011
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhBRTj6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:58 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37754 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233718AbhBRTFl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:41 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9D54BC009B;
        Thu, 18 Feb 2021 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675067; bh=8RxnKbwEyJxEXSCstQw23PoxXUfTY99H0E63SYLYusc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=aFGBu42mtzwjx2Y0Mv3f+65XuDOhmXLyrAbVqpPdvi2OoRw6julW1+b4rtUh42Lh8
         sda/XPqyNVSGffH//XZzf8nLWiD8+YPkWOLh1Y9ZHoztjaei3KENmYZ80ve/58rITH
         vCVLTzIz9FQvb6vrLeXo98XOe/pP9MBVWEVKkIWYwuM4OfYCJZsuHU7CBL4DYTtqO9
         U4CUIfHgGXREtBqmJ8b8NTkefq2vZQeTBhCizbvmonlK/MpJSRJ3zXv2wNn9x6tp4+
         g/c4rojoj04Rw9vqOC6MftmLSOihb++y6Wo5jzGV/cn1uWYpynGRVTsjQsxW9y+0wN
         H+qa1ZwGWN7rw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 408E0A005D;
        Thu, 18 Feb 2021 19:04:26 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 11/15] dmaengine: dw-edma: Move struct dentry variable from static definition into dw_edma struct
Date:   Thu, 18 Feb 2021 20:04:05 +0100
Message-Id: <07c1167b671e7b175700e2e7061cf0b3dd8c6adb.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move struct dentry variable from static definition (dw-edma-v0-debugfs.c)
into dw_edma struct (dw-edma-core.h)

Also the variable was renamed from base_dir to debugfs.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c       |  2 +-
 drivers/dma/dw-edma/dw-edma-core.h       |  3 +++
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  4 ++--
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 22 +++++++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  4 ++--
 6 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 552b5f9..bc94c8d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1003,7 +1003,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	dma_async_device_unregister(&dw->rd_edma);
 
 	/* Turn debugfs off */
-	dw_edma_v0_core_debugfs_off();
+	dw_edma_v0_core_debugfs_off(chip);
 
 	return 0;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index cba5436..60316d4 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -137,6 +137,9 @@ struct dw_edma {
 	const struct dw_edma_core_ops	*ops;
 
 	raw_spinlock_t			lock;		/* Only for legacy */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry			*debugfs;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 struct dw_edma_sg {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 5b0541a..329fc2e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -506,7 +506,7 @@ void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
 	dw_edma_v0_debugfs_on(chip);
 }
 
-void dw_edma_v0_core_debugfs_off(void)
+void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip)
 {
-	dw_edma_v0_debugfs_off();
+	dw_edma_v0_debugfs_off(chip);
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index abae152..2afa626 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -23,6 +23,6 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
 void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_core_debugfs_off(void);
+void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 157dfc2..4b3bcff 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -38,7 +38,6 @@
 #define CHANNEL_STR				"channel"
 #define REGISTERS_STR				"registers"
 
-static struct dentry				*base_dir;
 static struct dw_edma				*dw;
 static struct dw_edma_v0_regs			__iomem *regs;
 
@@ -272,7 +271,7 @@ static void dw_edma_debugfs_regs(void)
 	struct dentry *regs_dir;
 	int nr_entries;
 
-	regs_dir = debugfs_create_dir(REGISTERS_STR, base_dir);
+	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
 	if (!regs_dir)
 		return;
 
@@ -293,18 +292,23 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!regs)
 		return;
 
-	base_dir = debugfs_create_dir(dw->name, NULL);
-	if (!base_dir)
+	dw->debugfs = debugfs_create_dir(dw->name, NULL);
+	if (!dw->debugfs)
 		return;
 
-	debugfs_create_u32("mf", 0444, base_dir, &dw->mf);
-	debugfs_create_u16("wr_ch_cnt", 0444, base_dir, &dw->wr_ch_cnt);
-	debugfs_create_u16("rd_ch_cnt", 0444, base_dir, &dw->rd_ch_cnt);
+	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
+	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
+	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs();
 }
 
-void dw_edma_v0_debugfs_off(void)
+void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
 {
-	debugfs_remove_recursive(base_dir);
+	dw = chip->dw;
+	if (!dw)
+		return;
+
+	debugfs_remove_recursive(dw->debugfs);
+	dw->debugfs = NULL;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index 5450a0a..d0ff25a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -13,13 +13,13 @@
 
 #ifdef CONFIG_DEBUG_FS
 void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_debugfs_off(void);
+void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip);
 #else
 static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 {
 }
 
-static inline void dw_edma_v0_debugfs_off(void)
+static inline void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
 {
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.7.4

