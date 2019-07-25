Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7C75A4A
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 00:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGYWEN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 18:04:13 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47800 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfGYWEM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 18:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564092249; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9K+p4ps8kGRsYEca4QYoqSsXEaivylCMYTGrgOWaFMk=;
        b=b5dRGS7g+ru5IRIs2Dzgj85hl3eWxlYyOgzRUrJeigW4jQyWrwnbC79rIQz9/RQkFPcXvJ
        iLs0vqZf0yWchT77tiBXWEec6Ck1PMKUC0FtnQ7yTueVeL5nLM5eZNXlUDpUW8yuuFFkEU
        DqbEXyVnc4v6Rq0m3Bpkj2zfUKaEq70=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
Date:   Thu, 25 Jul 2019 18:02:14 -0400
Message-Id: <20190725220215.460-11-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It has been replaced with the ingenic-iio driver for the ADC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/mfd/Kconfig      |   9 --
 drivers/mfd/Makefile     |   1 -
 drivers/mfd/jz4740-adc.c | 324 ---------------------------------------
 3 files changed, 334 deletions(-)
 delete mode 100644 drivers/mfd/jz4740-adc.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f129f9678940..4a07afe50b35 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -649,15 +649,6 @@ config MFD_JANZ_CMODIO
 	  host many different types of MODULbus daughterboards, including
 	  CAN and GPIO controllers.
 
-config MFD_JZ4740_ADC
-	bool "Janz JZ4740 ADC core"
-	select MFD_CORE
-	select GENERIC_IRQ_CHIP
-	depends on MACH_JZ4740
-	help
-	  Say yes here if you want support for the ADC unit in the JZ4740 SoC.
-	  This driver is necessary for jz4740-battery and jz4740-hwmon driver.
-
 config MFD_KEMPLD
 	tristate "Kontron module PLD device"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f026ada68f6a..446d5df7cacb 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -191,7 +191,6 @@ obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
 obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
 obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
 obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
-obj-$(CONFIG_MFD_JZ4740_ADC)	+= jz4740-adc.o
 obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
 obj-$(CONFIG_MFD_VX855)		+= vx855.o
 obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
deleted file mode 100644
index 082f16917519..000000000000
--- a/drivers/mfd/jz4740-adc.c
+++ /dev/null
@@ -1,324 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- * JZ4740 SoC ADC driver
- *
- * This driver synchronizes access to the JZ4740 ADC core between the
- * JZ4740 battery and hwmon drivers.
- */
-
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-
-#include <linux/clk.h>
-#include <linux/mfd/core.h>
-
-#include <linux/jz4740-adc.h>
-
-
-#define JZ_REG_ADC_ENABLE	0x00
-#define JZ_REG_ADC_CFG		0x04
-#define JZ_REG_ADC_CTRL		0x08
-#define JZ_REG_ADC_STATUS	0x0c
-
-#define JZ_REG_ADC_TOUCHSCREEN_BASE	0x10
-#define JZ_REG_ADC_BATTERY_BASE	0x1c
-#define JZ_REG_ADC_HWMON_BASE	0x20
-
-#define JZ_ADC_ENABLE_TOUCH	BIT(2)
-#define JZ_ADC_ENABLE_BATTERY	BIT(1)
-#define JZ_ADC_ENABLE_ADCIN	BIT(0)
-
-enum {
-	JZ_ADC_IRQ_ADCIN = 0,
-	JZ_ADC_IRQ_BATTERY,
-	JZ_ADC_IRQ_TOUCH,
-	JZ_ADC_IRQ_PENUP,
-	JZ_ADC_IRQ_PENDOWN,
-};
-
-struct jz4740_adc {
-	struct resource *mem;
-	void __iomem *base;
-
-	int irq;
-	struct irq_chip_generic *gc;
-
-	struct clk *clk;
-	atomic_t clk_ref;
-
-	spinlock_t lock;
-};
-
-static void jz4740_adc_irq_demux(struct irq_desc *desc)
-{
-	struct irq_chip_generic *gc = irq_desc_get_handler_data(desc);
-	uint8_t status;
-	unsigned int i;
-
-	status = readb(gc->reg_base + JZ_REG_ADC_STATUS);
-
-	for (i = 0; i < 5; ++i) {
-		if (status & BIT(i))
-			generic_handle_irq(gc->irq_base + i);
-	}
-}
-
-
-/* Refcounting for the ADC clock is done in here instead of in the clock
- * framework, because it is the only clock which is shared between multiple
- * devices and thus is the only clock which needs refcounting */
-static inline void jz4740_adc_clk_enable(struct jz4740_adc *adc)
-{
-	if (atomic_inc_return(&adc->clk_ref) == 1)
-		clk_prepare_enable(adc->clk);
-}
-
-static inline void jz4740_adc_clk_disable(struct jz4740_adc *adc)
-{
-	if (atomic_dec_return(&adc->clk_ref) == 0)
-		clk_disable_unprepare(adc->clk);
-}
-
-static inline void jz4740_adc_set_enabled(struct jz4740_adc *adc, int engine,
-	bool enabled)
-{
-	unsigned long flags;
-	uint8_t val;
-
-	spin_lock_irqsave(&adc->lock, flags);
-
-	val = readb(adc->base + JZ_REG_ADC_ENABLE);
-	if (enabled)
-		val |= BIT(engine);
-	else
-		val &= ~BIT(engine);
-	writeb(val, adc->base + JZ_REG_ADC_ENABLE);
-
-	spin_unlock_irqrestore(&adc->lock, flags);
-}
-
-static int jz4740_adc_cell_enable(struct platform_device *pdev)
-{
-	struct jz4740_adc *adc = dev_get_drvdata(pdev->dev.parent);
-
-	jz4740_adc_clk_enable(adc);
-	jz4740_adc_set_enabled(adc, pdev->id, true);
-
-	return 0;
-}
-
-static int jz4740_adc_cell_disable(struct platform_device *pdev)
-{
-	struct jz4740_adc *adc = dev_get_drvdata(pdev->dev.parent);
-
-	jz4740_adc_set_enabled(adc, pdev->id, false);
-	jz4740_adc_clk_disable(adc);
-
-	return 0;
-}
-
-int jz4740_adc_set_config(struct device *dev, uint32_t mask, uint32_t val)
-{
-	struct jz4740_adc *adc = dev_get_drvdata(dev);
-	unsigned long flags;
-	uint32_t cfg;
-
-	if (!adc)
-		return -ENODEV;
-
-	spin_lock_irqsave(&adc->lock, flags);
-
-	cfg = readl(adc->base + JZ_REG_ADC_CFG);
-
-	cfg &= ~mask;
-	cfg |= val;
-
-	writel(cfg, adc->base + JZ_REG_ADC_CFG);
-
-	spin_unlock_irqrestore(&adc->lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(jz4740_adc_set_config);
-
-static struct resource jz4740_hwmon_resources[] = {
-	{
-		.start = JZ_ADC_IRQ_ADCIN,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start	= JZ_REG_ADC_HWMON_BASE,
-		.end	= JZ_REG_ADC_HWMON_BASE + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource jz4740_battery_resources[] = {
-	{
-		.start = JZ_ADC_IRQ_BATTERY,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start	= JZ_REG_ADC_BATTERY_BASE,
-		.end	= JZ_REG_ADC_BATTERY_BASE + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static const struct mfd_cell jz4740_adc_cells[] = {
-	{
-		.id = 0,
-		.name = "jz4740-hwmon",
-		.num_resources = ARRAY_SIZE(jz4740_hwmon_resources),
-		.resources = jz4740_hwmon_resources,
-
-		.enable = jz4740_adc_cell_enable,
-		.disable = jz4740_adc_cell_disable,
-	},
-	{
-		.id = 1,
-		.name = "jz4740-battery",
-		.num_resources = ARRAY_SIZE(jz4740_battery_resources),
-		.resources = jz4740_battery_resources,
-
-		.enable = jz4740_adc_cell_enable,
-		.disable = jz4740_adc_cell_disable,
-	},
-};
-
-static int jz4740_adc_probe(struct platform_device *pdev)
-{
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-	struct jz4740_adc *adc;
-	struct resource *mem_base;
-	int ret;
-	int irq_base;
-
-	adc = devm_kzalloc(&pdev->dev, sizeof(*adc), GFP_KERNEL);
-	if (!adc)
-		return -ENOMEM;
-
-	adc->irq = platform_get_irq(pdev, 0);
-	if (adc->irq < 0) {
-		ret = adc->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
-		return ret;
-	}
-
-	irq_base = platform_get_irq(pdev, 1);
-	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to get irq base: %d\n", irq_base);
-		return irq_base;
-	}
-
-	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_base) {
-		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
-		return -ENOENT;
-	}
-
-	/* Only request the shared registers for the MFD driver */
-	adc->mem = request_mem_region(mem_base->start, JZ_REG_ADC_STATUS,
-					pdev->name);
-	if (!adc->mem) {
-		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
-		return -EBUSY;
-	}
-
-	adc->base = ioremap_nocache(adc->mem->start, resource_size(adc->mem));
-	if (!adc->base) {
-		ret = -EBUSY;
-		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
-		goto err_release_mem_region;
-	}
-
-	adc->clk = clk_get(&pdev->dev, "adc");
-	if (IS_ERR(adc->clk)) {
-		ret = PTR_ERR(adc->clk);
-		dev_err(&pdev->dev, "Failed to get clock: %d\n", ret);
-		goto err_iounmap;
-	}
-
-	spin_lock_init(&adc->lock);
-	atomic_set(&adc->clk_ref, 0);
-
-	platform_set_drvdata(pdev, adc);
-
-	gc = irq_alloc_generic_chip("INTC", 1, irq_base, adc->base,
-		handle_level_irq);
-
-	ct = gc->chip_types;
-	ct->regs.mask = JZ_REG_ADC_CTRL;
-	ct->regs.ack = JZ_REG_ADC_STATUS;
-	ct->chip.irq_mask = irq_gc_mask_set_bit;
-	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
-	ct->chip.irq_ack = irq_gc_ack_set_bit;
-
-	irq_setup_generic_chip(gc, IRQ_MSK(5), IRQ_GC_INIT_MASK_CACHE, 0,
-				IRQ_NOPROBE | IRQ_LEVEL);
-
-	adc->gc = gc;
-
-	irq_set_chained_handler_and_data(adc->irq, jz4740_adc_irq_demux, gc);
-
-	writeb(0x00, adc->base + JZ_REG_ADC_ENABLE);
-	writeb(0xff, adc->base + JZ_REG_ADC_CTRL);
-
-	ret = mfd_add_devices(&pdev->dev, 0, jz4740_adc_cells,
-			      ARRAY_SIZE(jz4740_adc_cells), mem_base,
-			      irq_base, NULL);
-	if (ret < 0)
-		goto err_clk_put;
-
-	return 0;
-
-err_clk_put:
-	clk_put(adc->clk);
-err_iounmap:
-	iounmap(adc->base);
-err_release_mem_region:
-	release_mem_region(adc->mem->start, resource_size(adc->mem));
-	return ret;
-}
-
-static int jz4740_adc_remove(struct platform_device *pdev)
-{
-	struct jz4740_adc *adc = platform_get_drvdata(pdev);
-
-	mfd_remove_devices(&pdev->dev);
-
-	irq_remove_generic_chip(adc->gc, IRQ_MSK(5), IRQ_NOPROBE | IRQ_LEVEL, 0);
-	kfree(adc->gc);
-	irq_set_chained_handler_and_data(adc->irq, NULL, NULL);
-
-	iounmap(adc->base);
-	release_mem_region(adc->mem->start, resource_size(adc->mem));
-
-	clk_put(adc->clk);
-
-	return 0;
-}
-
-static struct platform_driver jz4740_adc_driver = {
-	.probe	= jz4740_adc_probe,
-	.remove = jz4740_adc_remove,
-	.driver = {
-		.name = "jz4740-adc",
-	},
-};
-
-module_platform_driver(jz4740_adc_driver);
-
-MODULE_DESCRIPTION("JZ4740 SoC ADC driver");
-MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:jz4740-adc");
-- 
2.21.0.593.g511ec345e18

