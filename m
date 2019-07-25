Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72775A41
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 00:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfGYWD4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 18:03:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47668 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfGYWDz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 18:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564092232; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kG6c+dBRiU4IJzRctsHNtNGVstZsDkLBqJmKFpZWVI0=;
        b=xcMZ3vr4Og+UnYIZ1sEBJx/H1fnovdEY/lRPE0PuLHULu7DSMdgpUbpVjOouSrigzrK+Kx
        Lfhj0/gWQTmEIHn3jhBz2kis/+ZQjpgPFdA+4jvTSAII8sJgXAXHQ88ufYRZVW8mxJLHUd
        UCkCwPvRq++kaQ5o1OwNHNV+iBy3504=
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
Subject: [PATCH 08/11] power/supply: Drop obsolete JZ4740 driver
Date:   Thu, 25 Jul 2019 18:02:12 -0400
Message-Id: <20190725220215.460-9-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It has been replaced with the more mature ingenic-battery driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/power/supply/Kconfig          |  11 -
 drivers/power/supply/Makefile         |   1 -
 drivers/power/supply/jz4740-battery.c | 421 --------------------------
 3 files changed, 433 deletions(-)
 delete mode 100644 drivers/power/supply/jz4740-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 5d91b5160b41..6ba602ed7979 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -417,17 +417,6 @@ config CHARGER_PCF50633
 	help
 	 Say Y to include support for NXP PCF50633 Main Battery Charger.
 
-config BATTERY_JZ4740
-	tristate "Ingenic JZ4740 battery"
-	depends on MACH_JZ4740
-	depends on MFD_JZ4740_ADC
-	help
-	  Say Y to enable support for the battery on Ingenic JZ4740 based
-	  boards.
-
-	  This driver can be build as a module. If so, the module will be
-	  called jz4740-battery.
-
 config BATTERY_RX51
 	tristate "Nokia RX-51 (N900) battery driver"
 	depends on TWL4030_MADC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 96c2b74b36bf..6c7da920ea83 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
-obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
 obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
diff --git a/drivers/power/supply/jz4740-battery.c b/drivers/power/supply/jz4740-battery.c
deleted file mode 100644
index 6366bd61ea9f..000000000000
--- a/drivers/power/supply/jz4740-battery.c
+++ /dev/null
@@ -1,421 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Battery measurement code for Ingenic JZ SOC.
- *
- * Copyright (C) 2009 Jiejing Zhang <kzjeef@gmail.com>
- * Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *
- * based on tosa_battery.c
- *
- * Copyright (C) 2008 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/mfd/core.h>
-#include <linux/power_supply.h>
-
-#include <linux/power/jz4740-battery.h>
-#include <linux/jz4740-adc.h>
-
-struct jz_battery {
-	struct jz_battery_platform_data *pdata;
-	struct platform_device *pdev;
-
-	void __iomem *base;
-
-	int irq;
-	int charge_irq;
-
-	const struct mfd_cell *cell;
-
-	int status;
-	long voltage;
-
-	struct completion read_completion;
-
-	struct power_supply *battery;
-	struct power_supply_desc battery_desc;
-	struct delayed_work work;
-
-	struct mutex lock;
-};
-
-static inline struct jz_battery *psy_to_jz_battery(struct power_supply *psy)
-{
-	return power_supply_get_drvdata(psy);
-}
-
-static irqreturn_t jz_battery_irq_handler(int irq, void *devid)
-{
-	struct jz_battery *battery = devid;
-
-	complete(&battery->read_completion);
-	return IRQ_HANDLED;
-}
-
-static long jz_battery_read_voltage(struct jz_battery *battery)
-{
-	long t;
-	unsigned long val;
-	long voltage;
-
-	mutex_lock(&battery->lock);
-
-	reinit_completion(&battery->read_completion);
-
-	enable_irq(battery->irq);
-	battery->cell->enable(battery->pdev);
-
-	t = wait_for_completion_interruptible_timeout(&battery->read_completion,
-		HZ);
-
-	if (t > 0) {
-		val = readw(battery->base) & 0xfff;
-
-		if (battery->pdata->info.voltage_max_design <= 2500000)
-			val = (val * 78125UL) >> 7UL;
-		else
-			val = ((val * 924375UL) >> 9UL) + 33000;
-		voltage = (long)val;
-	} else {
-		voltage = t ? t : -ETIMEDOUT;
-	}
-
-	battery->cell->disable(battery->pdev);
-	disable_irq(battery->irq);
-
-	mutex_unlock(&battery->lock);
-
-	return voltage;
-}
-
-static int jz_battery_get_capacity(struct power_supply *psy)
-{
-	struct jz_battery *jz_battery = psy_to_jz_battery(psy);
-	struct power_supply_info *info = &jz_battery->pdata->info;
-	long voltage;
-	int ret;
-	int voltage_span;
-
-	voltage = jz_battery_read_voltage(jz_battery);
-
-	if (voltage < 0)
-		return voltage;
-
-	voltage_span = info->voltage_max_design - info->voltage_min_design;
-	ret = ((voltage - info->voltage_min_design) * 100) / voltage_span;
-
-	if (ret > 100)
-		ret = 100;
-	else if (ret < 0)
-		ret = 0;
-
-	return ret;
-}
-
-static int jz_battery_get_property(struct power_supply *psy,
-	enum power_supply_property psp, union power_supply_propval *val)
-{
-	struct jz_battery *jz_battery = psy_to_jz_battery(psy);
-	struct power_supply_info *info = &jz_battery->pdata->info;
-	long voltage;
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = jz_battery->status;
-		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = jz_battery->pdata->info.technology;
-		break;
-	case POWER_SUPPLY_PROP_HEALTH:
-		voltage = jz_battery_read_voltage(jz_battery);
-		if (voltage < info->voltage_min_design)
-			val->intval = POWER_SUPPLY_HEALTH_DEAD;
-		else
-			val->intval = POWER_SUPPLY_HEALTH_GOOD;
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = jz_battery_get_capacity(psy);
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = jz_battery_read_voltage(jz_battery);
-		if (val->intval < 0)
-			return val->intval;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		val->intval = info->voltage_max_design;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		val->intval = info->voltage_min_design;
-		break;
-	case POWER_SUPPLY_PROP_PRESENT:
-		val->intval = 1;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static void jz_battery_external_power_changed(struct power_supply *psy)
-{
-	struct jz_battery *jz_battery = psy_to_jz_battery(psy);
-
-	mod_delayed_work(system_wq, &jz_battery->work, 0);
-}
-
-static irqreturn_t jz_battery_charge_irq(int irq, void *data)
-{
-	struct jz_battery *jz_battery = data;
-
-	mod_delayed_work(system_wq, &jz_battery->work, 0);
-
-	return IRQ_HANDLED;
-}
-
-static void jz_battery_update(struct jz_battery *jz_battery)
-{
-	int status;
-	long voltage;
-	bool has_changed = false;
-	int is_charging;
-
-	if (gpio_is_valid(jz_battery->pdata->gpio_charge)) {
-		is_charging = gpio_get_value(jz_battery->pdata->gpio_charge);
-		is_charging ^= jz_battery->pdata->gpio_charge_active_low;
-		if (is_charging)
-			status = POWER_SUPPLY_STATUS_CHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-		if (status != jz_battery->status) {
-			jz_battery->status = status;
-			has_changed = true;
-		}
-	}
-
-	voltage = jz_battery_read_voltage(jz_battery);
-	if (voltage >= 0 && abs(voltage - jz_battery->voltage) > 50000) {
-		jz_battery->voltage = voltage;
-		has_changed = true;
-	}
-
-	if (has_changed)
-		power_supply_changed(jz_battery->battery);
-}
-
-static enum power_supply_property jz_battery_properties[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
-	POWER_SUPPLY_PROP_PRESENT,
-};
-
-static void jz_battery_work(struct work_struct *work)
-{
-	/* Too small interval will increase system workload */
-	const int interval = HZ * 30;
-	struct jz_battery *jz_battery = container_of(work, struct jz_battery,
-					    work.work);
-
-	jz_battery_update(jz_battery);
-	schedule_delayed_work(&jz_battery->work, interval);
-}
-
-static int jz_battery_probe(struct platform_device *pdev)
-{
-	int ret = 0;
-	struct jz_battery_platform_data *pdata = pdev->dev.parent->platform_data;
-	struct power_supply_config psy_cfg = {};
-	struct jz_battery *jz_battery;
-	struct power_supply_desc *battery_desc;
-	struct resource *mem;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform_data supplied\n");
-		return -ENXIO;
-	}
-
-	jz_battery = devm_kzalloc(&pdev->dev, sizeof(*jz_battery), GFP_KERNEL);
-	if (!jz_battery) {
-		dev_err(&pdev->dev, "Failed to allocate driver structure\n");
-		return -ENOMEM;
-	}
-
-	jz_battery->cell = mfd_get_cell(pdev);
-
-	jz_battery->irq = platform_get_irq(pdev, 0);
-	if (jz_battery->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
-		return jz_battery->irq;
-	}
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	jz_battery->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(jz_battery->base))
-		return PTR_ERR(jz_battery->base);
-
-	battery_desc = &jz_battery->battery_desc;
-	battery_desc->name = pdata->info.name;
-	battery_desc->type = POWER_SUPPLY_TYPE_BATTERY;
-	battery_desc->properties	= jz_battery_properties;
-	battery_desc->num_properties	= ARRAY_SIZE(jz_battery_properties);
-	battery_desc->get_property	= jz_battery_get_property;
-	battery_desc->external_power_changed =
-					jz_battery_external_power_changed;
-	battery_desc->use_for_apm	= 1;
-
-	psy_cfg.drv_data = jz_battery;
-
-	jz_battery->pdata = pdata;
-	jz_battery->pdev = pdev;
-
-	init_completion(&jz_battery->read_completion);
-	mutex_init(&jz_battery->lock);
-
-	INIT_DELAYED_WORK(&jz_battery->work, jz_battery_work);
-
-	ret = request_irq(jz_battery->irq, jz_battery_irq_handler, 0, pdev->name,
-			jz_battery);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq %d\n", ret);
-		return ret;
-	}
-	disable_irq(jz_battery->irq);
-
-	if (gpio_is_valid(pdata->gpio_charge)) {
-		ret = gpio_request(pdata->gpio_charge, dev_name(&pdev->dev));
-		if (ret) {
-			dev_err(&pdev->dev, "charger state gpio request failed.\n");
-			goto err_free_irq;
-		}
-		ret = gpio_direction_input(pdata->gpio_charge);
-		if (ret) {
-			dev_err(&pdev->dev, "charger state gpio set direction failed.\n");
-			goto err_free_gpio;
-		}
-
-		jz_battery->charge_irq = gpio_to_irq(pdata->gpio_charge);
-
-		if (jz_battery->charge_irq >= 0) {
-			ret = request_irq(jz_battery->charge_irq,
-				    jz_battery_charge_irq,
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				    dev_name(&pdev->dev), jz_battery);
-			if (ret) {
-				dev_err(&pdev->dev, "Failed to request charge irq: %d\n", ret);
-				goto err_free_gpio;
-			}
-		}
-	} else {
-		jz_battery->charge_irq = -1;
-	}
-
-	if (jz_battery->pdata->info.voltage_max_design <= 2500000)
-		jz4740_adc_set_config(pdev->dev.parent, JZ_ADC_CONFIG_BAT_MB,
-			JZ_ADC_CONFIG_BAT_MB);
-	else
-		jz4740_adc_set_config(pdev->dev.parent, JZ_ADC_CONFIG_BAT_MB, 0);
-
-	jz_battery->battery = power_supply_register(&pdev->dev, battery_desc,
-							&psy_cfg);
-	if (IS_ERR(jz_battery->battery)) {
-		dev_err(&pdev->dev, "power supply battery register failed.\n");
-		ret = PTR_ERR(jz_battery->battery);
-		goto err_free_charge_irq;
-	}
-
-	platform_set_drvdata(pdev, jz_battery);
-	schedule_delayed_work(&jz_battery->work, 0);
-
-	return 0;
-
-err_free_charge_irq:
-	if (jz_battery->charge_irq >= 0)
-		free_irq(jz_battery->charge_irq, jz_battery);
-err_free_gpio:
-	if (gpio_is_valid(pdata->gpio_charge))
-		gpio_free(jz_battery->pdata->gpio_charge);
-err_free_irq:
-	free_irq(jz_battery->irq, jz_battery);
-	return ret;
-}
-
-static int jz_battery_remove(struct platform_device *pdev)
-{
-	struct jz_battery *jz_battery = platform_get_drvdata(pdev);
-
-	cancel_delayed_work_sync(&jz_battery->work);
-
-	if (gpio_is_valid(jz_battery->pdata->gpio_charge)) {
-		if (jz_battery->charge_irq >= 0)
-			free_irq(jz_battery->charge_irq, jz_battery);
-		gpio_free(jz_battery->pdata->gpio_charge);
-	}
-
-	power_supply_unregister(jz_battery->battery);
-
-	free_irq(jz_battery->irq, jz_battery);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int jz_battery_suspend(struct device *dev)
-{
-	struct jz_battery *jz_battery = dev_get_drvdata(dev);
-
-	cancel_delayed_work_sync(&jz_battery->work);
-	jz_battery->status = POWER_SUPPLY_STATUS_UNKNOWN;
-
-	return 0;
-}
-
-static int jz_battery_resume(struct device *dev)
-{
-	struct jz_battery *jz_battery = dev_get_drvdata(dev);
-
-	schedule_delayed_work(&jz_battery->work, 0);
-
-	return 0;
-}
-
-static const struct dev_pm_ops jz_battery_pm_ops = {
-	.suspend	= jz_battery_suspend,
-	.resume		= jz_battery_resume,
-};
-
-#define JZ_BATTERY_PM_OPS (&jz_battery_pm_ops)
-#else
-#define JZ_BATTERY_PM_OPS NULL
-#endif
-
-static struct platform_driver jz_battery_driver = {
-	.probe		= jz_battery_probe,
-	.remove		= jz_battery_remove,
-	.driver = {
-		.name = "jz4740-battery",
-		.pm = JZ_BATTERY_PM_OPS,
-	},
-};
-
-module_platform_driver(jz_battery_driver);
-
-MODULE_ALIAS("platform:jz4740-battery");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("JZ4740 SoC battery driver");
-- 
2.21.0.593.g511ec345e18

