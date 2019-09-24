Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97492BD164
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505098AbfIXSNO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505076AbfIXSNH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:13:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67856AC93;
        Tue, 24 Sep 2019 18:13:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     mbrugger@suse.com, robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 10/11] of: device: introduce of_dma_configure_parent()
Date:   Tue, 24 Sep 2019 20:12:41 +0200
Message-Id: <20190924181244.7159-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Devices not represented in DT, placed behind a bus that autodetects
them, pass of_dma_configure() their bus' DT node. This misses that bus'
'dma-ranges' property as the function's implementation expects the DT
node to be one of a device.

Create of_dma_configure_parent() which takes the given DT node as the
device's underlying bus and parses it accordingly.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/bus/fsl-mc/fsl-mc-bus.c |  2 +-
 drivers/gpu/host1x/bus.c        |  2 +-
 drivers/of/device.c             | 30 ++++++++++++++++++++++++++++--
 drivers/pci/pci-driver.c        |  3 ++-
 include/linux/of_device.h       | 13 ++++++++++---
 5 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5c9bf2e06552..217e64119497 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -134,7 +134,7 @@ static int fsl_mc_dma_configure(struct device *dev)
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
-	return of_dma_configure(dev, dma_dev->of_node, 0);
+	return of_dma_configure_parent(dev, dma_dev->of_node, false);
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 742aa9ff21b8..2fdc04383a60 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -442,7 +442,7 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
+	of_dma_configure_parent(&device->dev, host1x->dev->of_node, true);
 
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, SZ_4M);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 018c52688546..1d0b1127d05e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -83,6 +83,31 @@ int of_device_add(struct platform_device *ofdev)
  * accordingly.
  */
 int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
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
+EXPORT_SYMBOL_GPL(of_dma_configure);
+
+/**
+ * of_dma_configure_parent - Setup DMA configuration based on a parent bus'
+ *			     DT node
+ * @dev:	Device to apply DMA configuration
+ * @parent:	Parent bus device node
+ * @force_dma:  Whether device is to be set up by of_dma_configure() even if
+ *		DMA capability is not explicitly described by firmware.
+ *
+ * Try to get devices's DMA configuration from parent bus' DT and update it
+ * accordingly.
+ */
+int of_dma_configure_parent(struct device *dev, struct device_node *parent,
+			    bool force_dma)
 {
 	u64 dma_addr, paddr, size = 0;
 	int ret;
@@ -91,8 +116,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	const struct iommu_ops *iommu;
 	u64 mask;
 
-	ret = of_dma_get_range(__of_get_dma_parent(np), &dma_addr,
-			       &paddr, &size);
+	dev_dbg(dev, "starting at %pOF\n", parent);
+
+	ret = of_dma_get_range(parent, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		/*
 		 * For legacy reasons, we have to assume some devices need
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a8124e47bf6e..25073d68a0f6 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1628,7 +1628,8 @@ static int pci_dma_configure(struct device *dev)
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
 	    bridge->parent->of_node) {
-		ret = of_dma_configure(dev, bridge->parent->of_node, true);
+		ret = of_dma_configure_parent(dev, bridge->parent->of_node,
+					      true);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..8f319b8c9deb 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,9 +55,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-int of_dma_configure(struct device *dev,
-		     struct device_node *np,
-		     bool force_dma);
+int of_dma_configure(struct device *dev, struct devce_node *np, bool force_dma);
+int of_dma_configure_parent(struct device *dev, struct device_node *parent,
+			    bool force_dma);
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -112,6 +112,13 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return 0;
 }
+
+static inline int of_dma_configure_parent(struct device *dev,
+					  struct device_node *parent,
+					  bool force_dma)
+{
+	return 0;
+}
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
2.23.0

