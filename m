Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8E607BA5
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJUP6U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Oct 2022 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJUP5x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Oct 2022 11:57:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89E27E2F0;
        Fri, 21 Oct 2022 08:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D77AFB82C9D;
        Fri, 21 Oct 2022 15:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EC6C433C1;
        Fri, 21 Oct 2022 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367864;
        bh=uRhTubaMPy1QnYuX7qPtmgOomefbSd6elASyZXYtb6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5Vft1lYSZtszgLPCy6EaLP76hZowv6UDFWcxtqHVA6tLGcuxunn6Q6I2D9oZPyUP
         rqG8hN4A1iNPen6/m7QXlozh8klUqQhXm1YFiMKaf7BThATVnmIm+FLJxC0ytmhsbU
         FUF6Ddh8gF/jlRNsJ3JkwhBz2lVDTTcAeus2kg4wCNTjgD4iD5y1XOK/cUjfkN3pOp
         jNrakjRzInepx1xyw+peJ8IfsDpo8TCl6OQ0NkAFI2WIql81OcqittKlqipFfcZGsL
         v2UYArrs5PzenjbJqkbbOOe6TAM1xjcd+xpUVHoywx79KX46FMujuyHT99W2MGyjxM
         AyipKyrrqDJVA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        dmaengine@vger.kernel.org
Subject: [PATCH 09/11] ARM: mmp: remove custom sram code
Date:   Fri, 21 Oct 2022 17:49:39 +0200
Message-Id: <20221021155000.4108406-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The MMP_SRAM code is no longer used by the tdma driver because
the Kconfig symbol is not selected, so remove it along with its
former callsite.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/Makefile                 |   1 -
 arch/arm/mach-mmp/mmp2.h                   |  13 --
 arch/arm/mach-mmp/sram.c                   | 167 ---------------------
 drivers/dma/mmp_tdma.c                     |   7 +-
 include/linux/platform_data/dma-mmp_tdma.h |  36 -----
 5 files changed, 2 insertions(+), 222 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/sram.c
 delete mode 100644 include/linux/platform_data/dma-mmp_tdma.h

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 65cc9b691983..cd874c5a6cb8 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -8,7 +8,6 @@ obj-y				+= common.o devices.o time.o
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+= mmp2.o
-obj-$(CONFIG_MMP_SRAM)		+= sram.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index 7f80b90248fb..5c80836aea76 100644
--- a/arch/arm/mach-mmp/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -10,7 +10,6 @@ extern void mmp2_clear_pmic_int(void);
 
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
-#include <linux/platform_data/dma-mmp_tdma.h>
 #include <linux/irqchip/mmp.h>
 
 #include "devices.h"
@@ -29,8 +28,6 @@ extern struct mmp_device_desc mmp2_device_sdh0;
 extern struct mmp_device_desc mmp2_device_sdh1;
 extern struct mmp_device_desc mmp2_device_sdh2;
 extern struct mmp_device_desc mmp2_device_sdh3;
-extern struct mmp_device_desc mmp2_device_asram;
-extern struct mmp_device_desc mmp2_device_isram;
 
 extern struct platform_device mmp2_device_gpio;
 
@@ -90,15 +87,5 @@ static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
 	return mmp_register_device(d, data, sizeof(*data));
 }
 
-static inline int mmp2_add_asram(struct sram_platdata *data)
-{
-	return mmp_register_device(&mmp2_device_asram, data, sizeof(*data));
-}
-
-static inline int mmp2_add_isram(struct sram_platdata *data)
-{
-	return mmp_register_device(&mmp2_device_isram, data, sizeof(*data));
-}
-
 #endif /* __ASM_MACH_MMP2_H */
 
diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
deleted file mode 100644
index ecc46c31004f..000000000000
--- a/arch/arm/mach-mmp/sram.c
+++ /dev/null
@@ -1,167 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-mmp/sram.c
- *
- *  based on mach-davinci/sram.c - DaVinci simple SRAM allocator
- *
- *  Copyright (c) 2011 Marvell Semiconductors Inc.
- *  All Rights Reserved
- *
- *  Add for mmp sram support - Leo Yan <leoy@marvell.com>
- */
-
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/genalloc.h>
-
-#include <linux/platform_data/dma-mmp_tdma.h>
-
-struct sram_bank_info {
-	char *pool_name;
-	struct gen_pool *gpool;
-	int granularity;
-
-	phys_addr_t sram_phys;
-	void __iomem *sram_virt;
-	u32 sram_size;
-
-	struct list_head node;
-};
-
-static DEFINE_MUTEX(sram_lock);
-static LIST_HEAD(sram_bank_list);
-
-struct gen_pool *sram_get_gpool(char *pool_name)
-{
-	struct sram_bank_info *info = NULL;
-
-	if (!pool_name)
-		return NULL;
-
-	mutex_lock(&sram_lock);
-
-	list_for_each_entry(info, &sram_bank_list, node)
-		if (!strcmp(pool_name, info->pool_name))
-			break;
-
-	mutex_unlock(&sram_lock);
-
-	if (&info->node == &sram_bank_list)
-		return NULL;
-
-	return info->gpool;
-}
-EXPORT_SYMBOL(sram_get_gpool);
-
-static int sram_probe(struct platform_device *pdev)
-{
-	struct sram_platdata *pdata = pdev->dev.platform_data;
-	struct sram_bank_info *info;
-	struct resource *res;
-	int ret = 0;
-
-	if (!pdata || !pdata->pool_name)
-		return -ENODEV;
-
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, info);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	if (!resource_size(res))
-		return 0;
-
-	info->sram_phys   = (phys_addr_t)res->start;
-	info->sram_size   = resource_size(res);
-	info->sram_virt   = ioremap(info->sram_phys, info->sram_size);
-	info->pool_name	  = kstrdup(pdata->pool_name, GFP_KERNEL);
-	info->granularity = pdata->granularity;
-
-	info->gpool = gen_pool_create(ilog2(info->granularity), -1);
-	if (!info->gpool) {
-		dev_err(&pdev->dev, "create pool failed\n");
-		ret = -ENOMEM;
-		goto create_pool_err;
-	}
-
-	ret = gen_pool_add_virt(info->gpool, (unsigned long)info->sram_virt,
-				info->sram_phys, info->sram_size, -1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "add new chunk failed\n");
-		ret = -ENOMEM;
-		goto add_chunk_err;
-	}
-
-	mutex_lock(&sram_lock);
-	list_add(&info->node, &sram_bank_list);
-	mutex_unlock(&sram_lock);
-
-	dev_info(&pdev->dev, "initialized\n");
-	return 0;
-
-add_chunk_err:
-	gen_pool_destroy(info->gpool);
-create_pool_err:
-	iounmap(info->sram_virt);
-	kfree(info->pool_name);
-out:
-	kfree(info);
-	return ret;
-}
-
-static int sram_remove(struct platform_device *pdev)
-{
-	struct sram_bank_info *info;
-
-	info = platform_get_drvdata(pdev);
-
-	if (info->sram_size) {
-		mutex_lock(&sram_lock);
-		list_del(&info->node);
-		mutex_unlock(&sram_lock);
-
-		gen_pool_destroy(info->gpool);
-		iounmap(info->sram_virt);
-		kfree(info->pool_name);
-	}
-
-	kfree(info);
-
-	return 0;
-}
-
-static const struct platform_device_id sram_id_table[] = {
-	{ "asram", MMP_ASRAM },
-	{ "isram", MMP_ISRAM },
-	{ }
-};
-
-static struct platform_driver sram_driver = {
-	.probe		= sram_probe,
-	.remove		= sram_remove,
-	.driver		= {
-		.name	= "mmp-sram",
-	},
-	.id_table	= sram_id_table,
-};
-
-static int __init sram_init(void)
-{
-	return platform_driver_register(&sram_driver);
-}
-core_initcall(sram_init);
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a262e0eb4cc9..d83e608dca05 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -15,7 +15,7 @@
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
-#include <linux/platform_data/dma-mmp_tdma.h>
+#include <linux/genalloc.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 
@@ -670,10 +670,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&tdev->device.channels);
 
-	if (pdev->dev.of_node)
-		pool = of_gen_pool_get(pdev->dev.of_node, "asram", 0);
-	else
-		pool = sram_get_gpool("asram");
+	pool = of_gen_pool_get(pdev->dev.of_node, "asram", 0);
 	if (!pool) {
 		dev_err(&pdev->dev, "asram pool not available\n");
 		return -ENOMEM;
diff --git a/include/linux/platform_data/dma-mmp_tdma.h b/include/linux/platform_data/dma-mmp_tdma.h
deleted file mode 100644
index 8bec5484dc86..000000000000
--- a/include/linux/platform_data/dma-mmp_tdma.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  SRAM Memory Management
- *
- *  Copyright (c) 2011 Marvell Semiconductors Inc.
- */
-
-#ifndef __DMA_MMP_TDMA_H
-#define __DMA_MMP_TDMA_H
-
-#include <linux/genalloc.h>
-
-/* ARBITRARY:  SRAM allocations are multiples of this 2^N size */
-#define SRAM_GRANULARITY	512
-
-enum sram_type {
-	MMP_SRAM_UNDEFINED = 0,
-	MMP_ASRAM,
-	MMP_ISRAM,
-};
-
-struct sram_platdata {
-	char *pool_name;
-	int granularity;
-};
-
-#ifdef CONFIG_MMP_SRAM
-extern struct gen_pool *sram_get_gpool(char *pool_name);
-#else
-static inline struct gen_pool *sram_get_gpool(char *pool_name)
-{
-	return NULL;
-}
-#endif
-
-#endif /* __DMA_MMP_TDMA_H */
-- 
2.29.2

