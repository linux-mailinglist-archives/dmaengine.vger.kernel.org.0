Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6BB5191FF
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiECXEt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiECXED (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 720D663FD
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:25 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 315FAC07;
        Wed,  4 May 2022 01:52:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 315FAC07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618326;
        bh=Tnv3c0nlZBq31YnMEiCDH/uw1APag3tDvsgntFMphxU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Wu0khgAC0R09ZRZcfxfLWiroxK0t5i8LunwONqTx3z36tE6xLNT7QxLoV5SK2srmJ
         1YnPqxQRoNE9WE8srBiTXA2RcX/lm0p7/VqoH3z1qZBZm/CUEvQHSIahXV9I0cgZ6u
         sXp34VRVr3fiNSBw3Ksvx1kSH8GqNQxYlEw6u7LQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 19/26] dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
Date:   Wed, 4 May 2022 01:50:57 +0300
Message-ID: <20220503225104.12108-20-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since all DW eDMA read and write channels are now installed in a framework
of a single DMA-engine device, we can freely move all the DW eDMA-specific
DebugFS nodes into a ready-to-use DMA-engine DebugFS subdirectory. It's
created during the DMA-device registration and can be found in the
dma_device.dbg_dev_root field.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c       |  3 ---
 drivers/dma/dw-edma/dw-edma-core.h       |  3 ---
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  5 -----
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  1 -
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 16 ++++------------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  5 -----
 6 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f5124e7b50cf..7ba3b60c960c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1050,9 +1050,6 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 		list_del(&chan->vc.chan.device_node);
 	}
 
-	/* Turn debugfs off */
-	dw_edma_v0_core_debugfs_off(dw);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b576a8fff45a..e3ad3e372b55 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -111,9 +111,6 @@ struct dw_edma {
 	raw_spinlock_t			lock;		/* Only for legacy */
 
 	struct dw_edma_chip             *chip;
-#ifdef CONFIG_DEBUG_FS
-	struct dentry			*debugfs;
-#endif /* CONFIG_DEBUG_FS */
 };
 
 struct dw_edma_sg {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 2d3f74ccc340..e6d611176891 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -511,8 +511,3 @@ void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
 	dw_edma_v0_debugfs_on(dw);
 }
-
-void dw_edma_v0_core_debugfs_off(struct dw_edma *dw)
-{
-	dw_edma_v0_debugfs_off(dw);
-}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index 75aec6d31b21..ab96a1f48080 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -23,6 +23,5 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
 void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
-void dw_edma_v0_core_debugfs_off(struct dw_edma *dw);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index e6cf608d121b..d12c607433bf 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -268,7 +268,7 @@ static void dw_edma_debugfs_regs(struct dw_edma *dw)
 	struct dentry *regs_dent;
 	int nr_entries;
 
-	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
+	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dent);
@@ -282,17 +282,9 @@ void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 	if (!debugfs_initialized())
 		return;
 
-	dw->debugfs = debugfs_create_dir(dw->name, NULL);
-
-	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
-	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
-	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
+	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
+	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
+	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs(dw);
 }
-
-void dw_edma_v0_debugfs_off(struct dw_edma *dw)
-{
-	debugfs_remove_recursive(dw->debugfs);
-	dw->debugfs = NULL;
-}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index 3391b86edf5a..fb3342d97d6d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -13,15 +13,10 @@
 
 #ifdef CONFIG_DEBUG_FS
 void dw_edma_v0_debugfs_on(struct dw_edma *dw);
-void dw_edma_v0_debugfs_off(struct dw_edma *dw);
 #else
 static inline void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 {
 }
-
-static inline void dw_edma_v0_debugfs_off(struct dw_edma *dw)
-{
-}
 #endif /* CONFIG_DEBUG_FS */
 
 #endif /* _DW_EDMA_V0_DEBUG_FS_H */
-- 
2.35.1

