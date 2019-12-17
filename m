Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96A7121F8B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfLQAUI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:20:08 -0500
Received: from muru.com ([72.249.23.125]:48796 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLQAUI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:08 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CD5E0810D;
        Tue, 17 Dec 2019 00:20:45 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 13/14] ARM: OMAP2+: Drop legacy init for sdma
Date:   Mon, 16 Dec 2019 16:19:24 -0800
Message-Id: <20191217001925.44558-14-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We can now drop legacy init for sdma as we pass the quirks in auxdata to
the dmaengine driver.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c         |  91 +---------------
 arch/arm/mach-omap2/omap_device.c | 170 ------------------------------
 arch/arm/mach-omap2/omap_device.h |   4 -
 3 files changed, 1 insertion(+), 264 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -30,10 +30,6 @@
 #include <linux/omap-dma.h>
 
 #include "soc.h"
-#include "omap_hwmod.h"
-#include "omap_device.h"
-
-static enum omap_reg_offsets dma_common_ch_end;
 
 static const struct omap_dma_reg reg_map[] = {
 	[REVISION]	= { 0x0000, 0x00, OMAP_DMA_REG_32BIT },
@@ -81,42 +77,6 @@ static const struct omap_dma_reg reg_map[] = {
 	[CCDN]		= { 0x00d8, 0x60, OMAP_DMA_REG_32BIT },
 };
 
-static void __iomem *dma_base;
-static inline void dma_write(u32 val, int reg, int lch)
-{
-	void __iomem *addr = dma_base;
-
-	addr += reg_map[reg].offset;
-	addr += reg_map[reg].stride * lch;
-
-	writel_relaxed(val, addr);
-}
-
-static inline u32 dma_read(int reg, int lch)
-{
-	void __iomem *addr = dma_base;
-
-	addr += reg_map[reg].offset;
-	addr += reg_map[reg].stride * lch;
-
-	return readl_relaxed(addr);
-}
-
-static void omap2_clear_dma(int lch)
-{
-	int i;
-
-	for (i = CSDP; i <= dma_common_ch_end; i += 1)
-		dma_write(0, i, lch);
-}
-
-static void omap2_show_dma_caps(void)
-{
-	u8 revision = dma_read(REVISION, 0) & 0xff;
-	printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
-				revision >> 4, revision & 0xf);
-}
-
 static unsigned configure_dma_errata(void)
 {
 	unsigned errata = 0;
@@ -221,25 +181,11 @@ struct omap_system_dma_plat_info dma_plat_info = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x60,
 	.dma_attr	= &dma_attr,
-	.show_dma_caps	= omap2_show_dma_caps,
-	.clear_dma	= omap2_clear_dma,
-	.dma_write	= dma_write,
-	.dma_read	= dma_read,
-};
-
-static struct platform_device_info omap_dma_dev_info __initdata = {
-	.name = "omap-dma-engine",
-	.id = -1,
-	.dma_mask = DMA_BIT_MASK(32),
 };
 
 /* One time initializations */
-static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
+static int __init omap2_system_dma_init(void)
 {
-	struct platform_device			*pdev;
-	struct resource				*mem;
-	char					*name = "omap_dma_system";
-
 	dma_plat_info.errata = configure_dma_errata();
 
 	if (soc_is_omap24xx()) {
@@ -254,41 +200,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	if (soc_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
 		dma_attr.dev_caps |= HS_CHANNELS_RESERVED;
 
-	pdev = omap_device_build(name, 0, oh, &dma_plat_info,
-				 sizeof(dma_plat_info));
-	if (IS_ERR(pdev)) {
-		pr_err("%s: Can't build omap_device for %s:%s.\n",
-			__func__, name, oh->name);
-		return PTR_ERR(pdev);
-	}
-
-	omap_dma_dev_info.res = pdev->resource;
-	omap_dma_dev_info.num_res = pdev->num_resources;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
-		return -EINVAL;
-	}
-
-	dma_base = ioremap(mem->start, resource_size(mem));
-	if (!dma_base) {
-		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
-		return -ENOMEM;
-	}
-
-	/* Check the capabilities register for descriptor loading feature */
-	if (soc_is_omap24xx() || soc_is_omap34xx() || soc_is_am35xx())
-		dma_common_ch_end = CCFN;
-	else
-		dma_common_ch_end = CCDN;
-
 	return 0;
 }
-
-static int __init omap2_system_dma_init(void)
-{
-	return omap_hwmod_for_each_by_class("dma",
-			omap2_system_dma_init_dev, NULL);
-}
 omap_arch_initcall(omap2_system_dma_init);
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -373,176 +373,6 @@ void omap_device_delete(struct omap_device *od)
 	kfree(od);
 }
 
-/**
- * omap_device_copy_resources - Add legacy IO and IRQ resources
- * @oh: interconnect target module
- * @pdev: platform device to copy resources to
- *
- * We still have legacy DMA and smartreflex needing resources.
- * Let's populate what they need until we can eventually just
- * remove this function. Note that there should be no need to
- * call this from omap_device_build_from_dt(), nor should there
- * be any need to call it for other devices.
- */
-static int
-omap_device_copy_resources(struct omap_hwmod *oh,
-			   struct platform_device *pdev)
-{
-	struct device_node *np, *child;
-	struct property *prop;
-	struct resource *res;
-	const char *name;
-	int error, irq = 0;
-
-	if (!oh || !oh->od || !oh->od->pdev)
-		return -EINVAL;
-
-	np = oh->od->pdev->dev.of_node;
-	if (!np) {
-		error = -ENODEV;
-		goto error;
-	}
-
-	res = kcalloc(2, sizeof(*res), GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	/* Do we have a dts range for the interconnect target module? */
-	error = omap_hwmod_parse_module_range(oh, np, res);
-
-	/* No ranges, rely on device reg entry */
-	if (error)
-		error = of_address_to_resource(np, 0, res);
-	if (error)
-		goto free;
-
-	/* SmartReflex needs first IO resource name to be "mpu" */
-	res[0].name = "mpu";
-
-	/*
-	 * We may have a configured "ti,sysc" interconnect target with a
-	 * dts child with the interrupt. If so use the first child's
-	 * first interrupt for "ti-hwmods" legacy support.
-	 */
-	of_property_for_each_string(np, "compatible", prop, name)
-		if (!strncmp("ti,sysc-", name, 8))
-			break;
-
-	child = of_get_next_available_child(np, NULL);
-
-	if (name)
-		irq = irq_of_parse_and_map(child, 0);
-	if (!irq)
-		irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		error = -EINVAL;
-		goto free;
-	}
-
-	/* Legacy DMA code needs interrupt name to be "0" */
-	res[1].start = irq;
-	res[1].end = irq;
-	res[1].flags = IORESOURCE_IRQ;
-	res[1].name = "0";
-
-	error = platform_device_add_resources(pdev, res, 2);
-
-free:
-	kfree(res);
-
-error:
-	WARN(error, "%s: %s device %s failed: %i\n",
-	     __func__, oh->name, dev_name(&pdev->dev),
-	     error);
-
-	return error;
-}
-
-/**
- * omap_device_build - build and register an omap_device with one omap_hwmod
- * @pdev_name: name of the platform_device driver to use
- * @pdev_id: this platform_device's connection ID
- * @oh: ptr to the single omap_hwmod that backs this omap_device
- * @pdata: platform_data ptr to associate with the platform_device
- * @pdata_len: amount of memory pointed to by @pdata
- *
- * Convenience function for building and registering a single
- * omap_device record, which in turn builds and registers a
- * platform_device record.  See omap_device_build_ss() for more
- * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
- * passes along the return value of omap_device_build_ss().
- */
-struct platform_device __init *omap_device_build(const char *pdev_name,
-						 int pdev_id,
-						 struct omap_hwmod *oh,
-						 void *pdata, int pdata_len)
-{
-	int ret = -ENOMEM;
-	struct platform_device *pdev;
-	struct omap_device *od;
-
-	if (!oh || !pdev_name)
-		return ERR_PTR(-EINVAL);
-
-	if (!pdata && pdata_len > 0)
-		return ERR_PTR(-EINVAL);
-
-	if (strncmp(oh->name, "smartreflex", 11) &&
-	    strncmp(oh->name, "dma", 3)) {
-		pr_warn("%s need to update %s to probe with dt\na",
-			__func__, pdev_name);
-		ret = -ENODEV;
-		goto odbs_exit;
-	}
-
-	pdev = platform_device_alloc(pdev_name, pdev_id);
-	if (!pdev) {
-		ret = -ENOMEM;
-		goto odbs_exit;
-	}
-
-	/* Set the dev_name early to allow dev_xxx in omap_device_alloc */
-	if (pdev->id != -1)
-		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
-	else
-		dev_set_name(&pdev->dev, "%s", pdev->name);
-
-	/*
-	 * Must be called before omap_device_alloc() as oh->od
-	 * only contains the currently registered omap_device
-	 * and will get overwritten by omap_device_alloc().
-	 */
-	ret = omap_device_copy_resources(oh, pdev);
-	if (ret)
-		goto odbs_exit1;
-
-	od = omap_device_alloc(pdev, &oh, 1);
-	if (IS_ERR(od)) {
-		ret = PTR_ERR(od);
-		goto odbs_exit1;
-	}
-
-	ret = platform_device_add_data(pdev, pdata, pdata_len);
-	if (ret)
-		goto odbs_exit2;
-
-	ret = omap_device_register(pdev);
-	if (ret)
-		goto odbs_exit2;
-
-	return pdev;
-
-odbs_exit2:
-	omap_device_delete(od);
-odbs_exit1:
-	platform_device_put(pdev);
-odbs_exit:
-
-	pr_err("omap_device: %s: build failed (%d)\n", pdev_name, ret);
-
-	return ERR_PTR(ret);
-}
-
 #ifdef CONFIG_PM
 static int _od_runtime_suspend(struct device *dev)
 {
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -68,10 +68,6 @@ int omap_device_idle(struct platform_device *pdev);
 
 /* Core code interface */
 
-struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
-					  struct omap_hwmod *oh, void *pdata,
-					  int pdata_len);
-
 struct omap_device *omap_device_alloc(struct platform_device *pdev,
 				      struct omap_hwmod **ohs, int oh_cnt);
 void omap_device_delete(struct omap_device *od);
-- 
2.24.1
