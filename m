Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D58BD150
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632842AbfIXSNQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409758AbfIXSNP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:13:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71267ABBD;
        Tue, 24 Sep 2019 18:13:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     mbrugger@suse.com, robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        freedreno@lists.freedesktop.org
Subject: [PATCH 11/11] of: simplify of_dma_config()'s arguments
Date:   Tue, 24 Sep 2019 20:12:42 +0200
Message-Id: <20190924181244.7159-12-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The widespread use case for of_dma_config() highlights a redundant
argument. Most callers provide both 'dev' and 'dev->of_node'. The rest
of users use it to copy some device's  DMA configuration into a device
not represented in DT.

In order to simplify the common use case, and make code a little more
explicit, create of_dma_config_copy() which will take another device's
DT node as an argument and simplify of_dma_config() by removing one of
it's redundant arguments.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

 drivers/base/platform.c                      |  2 +-
 drivers/bcma/main.c                          |  2 +-
 drivers/dma/qcom/hidma_mgmt.c                |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c        |  2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c        |  2 +-
 drivers/gpu/drm/xen/xen_drm_front.c          |  2 +-
 drivers/gpu/host1x/bus.c                     |  2 +-
 drivers/media/platform/qcom/venus/firmware.c |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c     |  2 +-
 drivers/of/device.c                          | 30 ++++++++++++++++++--
 drivers/xen/gntdev.c                         |  2 +-
 include/linux/of_device.h                    | 12 ++++++--
 13 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b6c6c7d97d5b..4e252028aee9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1221,7 +1221,7 @@ int platform_dma_configure(struct device *dev)
 	int ret = 0;
 
 	if (dev->of_node) {
-		ret = of_dma_configure(dev, dev->of_node, true);
+		ret = of_dma_configure(dev, true);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		ret = acpi_dma_configure(dev, attr);
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 6535614a7dc1..4c7e8b35525c 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -207,7 +207,7 @@ static void bcma_of_fill_device(struct device *parent,
 
 	core->irq = bcma_of_get_irq(parent, core, 0);
 
-	of_dma_configure(&core->dev, node, false);
+	of_dma_configure(&core->dev, false);
 }
 
 unsigned int bcma_core_irq(struct bcma_device *core, int num)
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 806ca02c52d7..4ea901537902 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -388,7 +388,7 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 			goto out;
 		}
 		new_pdev->dev.of_node = child;
-		of_dma_configure(&new_pdev->dev, child, true);
+		of_dma_configure(&new_pdev->dev, true);
 		/*
 		 * It is assumed that calling of_msi_configure is safe on
 		 * platforms with or without MSI support.
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 1f9c01be40d7..1375f41593ef 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -706,7 +706,7 @@ static int __init etnaviv_init(void)
 		 * device as the GPU we found. This assumes that all Vivante
 		 * GPUs in the system share the same DMA constraints.
 		 */
-		of_dma_configure(&pdev->dev, np, true);
+		of_dma_configure_copy(&pdev->dev, np, true);
 
 		ret = platform_device_add(pdev);
 		if (ret) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 85f14feafdec..825fcdc72bd9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1268,7 +1268,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	gmu->dev = &pdev->dev;
 
-	of_dma_configure(gmu->dev, node, true);
+	of_dma_configure(gmu->dev, true);
 
 	/* Fow now, don't do anything fancy until we get our feet under us */
 	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 4e29f4fe4a05..97dd5d31e38d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -802,7 +802,7 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 		 * for us, and DRM doesn't do per-device allocation either, so
 		 * we would need to fix DRM first...
 		 */
-		ret = of_dma_configure(drm->dev, dev->of_node, true);
+		ret = of_dma_configure_copy(drm->dev, dev->of_node, true);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index ba1828acd8c9..fa0bfd6517fa 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -726,7 +726,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	 * node to set default DMA ops.
 	 */
 	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	ret = of_dma_configure(dev, NULL, true);
+	ret = of_dma_configure(dev, true);
 	if (ret < 0) {
 		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
 		return ret;
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 2fdc04383a60..4eb531906e4a 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -337,7 +337,7 @@ static int host1x_device_uevent(struct device *dev,
 
 static int host1x_dma_configure(struct device *dev)
 {
-	return of_dma_configure(dev, dev->of_node, true);
+	return of_dma_configure(dev, true);
 }
 
 static const struct dev_pm_ops host1x_device_pm_ops = {
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index d3d1748a7ef6..82f433218d99 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -238,7 +238,7 @@ int venus_firmware_init(struct venus_core *core)
 
 	pdev->dev.of_node = np;
 
-	ret = of_dma_configure(&pdev->dev, np, true);
+	ret = of_dma_configure(&pdev->dev, true);
 	if (ret) {
 		dev_err(core->dev, "dma configure fail\n");
 		goto err_unregister;
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index b776f83e395e..ad33e7a655aa 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1095,7 +1095,7 @@ static struct device *s5p_mfc_alloc_memdev(struct device *dev,
 	 * to be treated as valid DMA masters we need a bit of a hack to force
 	 * them to inherit the MFC node's DMA configuration.
 	 */
-	of_dma_configure(child, dev->of_node, true);
+	of_dma_configure_copy(child, dev->of_node, true);
 
 	if (device_add(child) == 0) {
 		ret = of_reserved_mem_device_init_by_idx(child, dev->of_node,
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1d0b1127d05e..66726a2499d3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -75,19 +75,18 @@ int of_device_add(struct platform_device *ofdev)
 /**
  * of_dma_configure - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
- * @np:		Pointer to OF node having DMA configuration
  * @force_dma:  Whether device is to be set up by of_dma_configure() even if
  *		DMA capability is not explicitly described by firmware.
  *
  * Try to get devices's DMA configuration from DT and update it
  * accordingly.
  */
-int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
+int of_dma_configure(struct device *dev, bool force_dma)
 {
 	struct device_node *dma_parent;
 	int ret;
 
-	dma_parent = __of_get_dma_parent(np);
+	dma_parent = __of_get_dma_parent(dev->of_node);
 	ret = of_dma_configure_parent(dev, dma_parent, force_dma);
 	of_node_put(dma_parent);
 
@@ -95,6 +94,31 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
+/**
+ * of_dma_configure_copy - Setup DMA configuration based on another device's DT
+ *			   node
+ * @dev:	Device to apply DMA configuration
+ * @np:		Device node to copy the configuration from
+ * @force_dma:  Whether device is to be set up by of_dma_configure() even if
+ *		DMA capability is not explicitly described by firmware.
+ *
+ * Try to get devices's DMA configuration from DT and update it
+ * accordingly.
+ */
+int of_dma_configure_copy(struct device *dev, struct device_node *np,
+			  bool force_dma)
+{
+	struct device_node *dma_parent;
+	int ret;
+
+	dma_parent = __of_get_dma_parent(np);
+	ret = of_dma_configure_parent(dev, dma_parent, force_dma);
+	of_node_put(dma_parent);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_dma_configure_copy);
+
 /**
  * of_dma_configure_parent - Setup DMA configuration based on a parent bus'
  *			     DT node
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index a446a7221e13..115e39f9f67a 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -632,7 +632,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	 * Fix this by calling of_dma_configure() with a NULL node to set
 	 * default DMA ops.
 	 */
-	of_dma_configure(priv->dma_dev, NULL, true);
+	of_dma_configure(priv->dma_dev, true);
 #endif
 	pr_debug("priv %p\n", priv);
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8f319b8c9deb..b05a86fd35a4 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-int of_dma_configure(struct device *dev, struct devce_node *np, bool force_dma);
+int of_dma_configure(struct device *dev, bool force_dma);
+int of_dma_configure_copy(struct device *dev, struct device_node *np,
+			  bool force_dma);
 int of_dma_configure_parent(struct device *dev, struct device_node *parent,
 			    bool force_dma);
 #else /* CONFIG_OF */
@@ -107,12 +109,18 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 }
 
 static inline int of_dma_configure(struct device *dev,
-				   struct device_node *np,
 				   bool force_dma)
 {
 	return 0;
 }
 
+static inline int of_dma_configure_copy(struct device *dev,
+					struct device_node *np,
+					bool force_dma)
+{
+	return 0;
+}
+
 static inline int of_dma_configure_parent(struct device *dev,
 					  struct device_node *parent,
 					  bool force_dma)
-- 
2.23.0

