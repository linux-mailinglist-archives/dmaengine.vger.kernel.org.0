Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F57361662
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhDOXh6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:37:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:43133 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237957AbhDOXh6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:37:58 -0400
IronPort-SDR: cKrBB9ejhUMKvrCgt0ZUeDmMma1Mn47sCLayutGpLVhJmrxShazv4Dxn+yu7dfH8ko3cUl7BvF
 OlURyQa7IjOA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="175070273"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="175070273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:34 -0700
IronPort-SDR: uG/mob0fE94w0UwAU95cb9h3IVBcIn/uNwoHkJnI827e9+/WGoHlcpXoI6DAVJ10wOi5LcoKwo
 60phVWEj0GxA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="601295854"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:33 -0700
Subject: [PATCH v10 05/11] dmaengine: idxd: fix idxd conf_dev 'struct device'
 lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:33 -0700
Message-ID: <161852985319.2203940.4650791514462735368.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The devm managed lifetime is incompatible with 'struct device' objects that
resides in idxd context. This is one of the series that clean up the idxd
driver 'struct device' lifetime. Fix idxd->conf_dev 'struct device'
lifetime. Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE.
Add release functions in order to free the allocated memory at the
appropriate time.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |   36 +++++++++++-------
 drivers/dma/idxd/init.c  |   56 ++++++++++++++++++++--------
 drivers/dma/idxd/sysfs.c |   92 +++++++++++++++++-----------------------------
 3 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 401b035e42b1..bb3a580732af 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -8,6 +8,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/wait.h>
 #include <linux/cdev.h>
+#include <linux/idr.h>
 #include "registers.h"
 
 #define IDXD_DRIVER_VERSION	"1.00"
@@ -255,6 +256,23 @@ extern struct bus_type dsa_bus_type;
 extern struct bus_type iax_bus_type;
 
 extern bool support_enqcmd;
+extern struct device_type dsa_device_type;
+extern struct device_type iax_device_type;
+
+static inline bool is_dsa_dev(struct device *dev)
+{
+	return dev->type == &dsa_device_type;
+}
+
+static inline bool is_iax_dev(struct device *dev)
+{
+	return dev->type == &iax_device_type;
+}
+
+static inline bool is_idxd_dev(struct device *dev)
+{
+	return is_dsa_dev(dev) || is_iax_dev(dev);
+}
 
 static inline bool wq_dedicated(struct idxd_wq *wq)
 {
@@ -292,18 +310,6 @@ static inline int idxd_get_wq_portal_full_offset(int wq_id,
 	return ((wq_id * 4) << PAGE_SHIFT) + idxd_get_wq_portal_offset(prot);
 }
 
-static inline void idxd_set_type(struct idxd_device *idxd)
-{
-	struct pci_dev *pdev = idxd->pdev;
-
-	if (pdev->device == PCI_DEVICE_ID_INTEL_DSA_SPR0)
-		idxd->type = IDXD_TYPE_DSA;
-	else if (pdev->device == PCI_DEVICE_ID_INTEL_IAX_SPR0)
-		idxd->type = IDXD_TYPE_IAX;
-	else
-		idxd->type = IDXD_TYPE_UNKNOWN;
-}
-
 static inline void idxd_wq_get(struct idxd_wq *wq)
 {
 	wq->client_count++;
@@ -319,14 +325,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+struct ida *idxd_ida(struct idxd_device *idxd);
 const char *idxd_get_dev_name(struct idxd_device *idxd);
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
-int idxd_setup_sysfs(struct idxd_device *idxd);
-void idxd_cleanup_sysfs(struct idxd_device *idxd);
+int idxd_register_devices(struct idxd_device *idxd);
+void idxd_unregister_devices(struct idxd_device *idxd);
 int idxd_register_driver(void);
 void idxd_unregister_driver(void);
 struct bus_type *idxd_get_bus_type(struct idxd_device *idxd);
+struct device_type *idxd_get_device_type(struct idxd_device *idxd);
 
 /* device interrupt control */
 void idxd_msix_perm_setup(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a4f0489515b4..17d3b36610a9 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -51,6 +51,11 @@ static char *idxd_name[] = {
 	"iax"
 };
 
+struct ida *idxd_ida(struct idxd_device *idxd)
+{
+	return &idxd_idas[idxd->type];
+}
+
 const char *idxd_get_dev_name(struct idxd_device *idxd)
 {
 	return idxd_name[idxd->type];
@@ -81,9 +86,8 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	 * We implement 1 completion list per MSI-X entry except for
 	 * entry 0, which is for errors and others.
 	 */
-	idxd->irq_entries = devm_kcalloc(dev, msixcnt,
-					 sizeof(struct idxd_irq_entry),
-					 GFP_KERNEL);
+	idxd->irq_entries = kcalloc_node(msixcnt, sizeof(struct idxd_irq_entry),
+					 GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->irq_entries) {
 		rc = -ENOMEM;
 		goto err_irq_entries;
@@ -262,16 +266,44 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	}
 }
 
+static inline void idxd_set_type(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+
+	if (pdev->device == PCI_DEVICE_ID_INTEL_DSA_SPR0)
+		idxd->type = IDXD_TYPE_DSA;
+	else if (pdev->device == PCI_DEVICE_ID_INTEL_IAX_SPR0)
+		idxd->type = IDXD_TYPE_IAX;
+	else
+		idxd->type = IDXD_TYPE_UNKNOWN;
+}
+
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
+	int rc;
 
-	idxd = devm_kzalloc(dev, sizeof(struct idxd_device), GFP_KERNEL);
+	idxd = kzalloc_node(sizeof(*idxd), GFP_KERNEL, dev_to_node(dev));
 	if (!idxd)
 		return NULL;
 
 	idxd->pdev = pdev;
+	idxd_set_type(idxd);
+	idxd->id = ida_alloc(idxd_ida(idxd), GFP_KERNEL);
+	if (idxd->id < 0)
+		return NULL;
+
+	device_initialize(&idxd->conf_dev);
+	idxd->conf_dev.parent = dev;
+	idxd->conf_dev.bus = idxd_get_bus_type(idxd);
+	idxd->conf_dev.type = idxd_get_device_type(idxd);
+	rc = dev_set_name(&idxd->conf_dev, "%s%d", idxd_get_dev_name(idxd), idxd->id);
+	if (rc < 0) {
+		put_device(&idxd->conf_dev);
+		return NULL;
+	}
+
 	spin_lock_init(&idxd->dev_lock);
 
 	return idxd;
@@ -347,20 +379,11 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	dev_dbg(dev, "IDXD interrupt setup complete.\n");
 
-	idxd->id = ida_alloc(&idxd_idas[idxd->type], GFP_KERNEL);
-	if (idxd->id < 0) {
-		rc = -ENOMEM;
-		goto err_ida_fail;
-	}
-
 	idxd->major = idxd_cdev_get_major(idxd);
 
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
- err_ida_fail:
-	idxd_mask_error_interrupts(idxd);
-	idxd_mask_msix_vectors(idxd);
  err_setup:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
@@ -412,7 +435,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		goto err;
 
-	idxd_set_type(idxd);
 
 	idxd_type_init(idxd);
 
@@ -427,7 +449,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
-	rc = idxd_setup_sysfs(idxd);
+	rc = idxd_register_devices(idxd);
 	if (rc) {
 		dev_err(dev, "IDXD sysfs setup failed\n");
 		goto err;
@@ -443,6 +465,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
+	put_device(&idxd->conf_dev);
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
@@ -511,11 +534,10 @@ static void idxd_remove(struct pci_dev *pdev)
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
-	idxd_cleanup_sysfs(idxd);
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	ida_free(&idxd_idas[idxd->type], idxd->id);
+	idxd_unregister_devices(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 18bf4d148989..36193e555e36 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -16,51 +16,26 @@ static char *idxd_wq_type_names[] = {
 	[IDXD_WQT_USER]		= "user",
 };
 
-static void idxd_conf_device_release(struct device *dev)
+static void idxd_conf_sub_device_release(struct device *dev)
 {
 	dev_dbg(dev, "%s for %s\n", __func__, dev_name(dev));
 }
 
 static struct device_type idxd_group_device_type = {
 	.name = "group",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_sub_device_release,
 };
 
 static struct device_type idxd_wq_device_type = {
 	.name = "wq",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_sub_device_release,
 };
 
 static struct device_type idxd_engine_device_type = {
 	.name = "engine",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_sub_device_release,
 };
 
-static struct device_type dsa_device_type = {
-	.name = "dsa",
-	.release = idxd_conf_device_release,
-};
-
-static struct device_type iax_device_type = {
-	.name = "iax",
-	.release = idxd_conf_device_release,
-};
-
-static inline bool is_dsa_dev(struct device *dev)
-{
-	return dev ? dev->type == &dsa_device_type : false;
-}
-
-static inline bool is_iax_dev(struct device *dev)
-{
-	return dev ? dev->type == &iax_device_type : false;
-}
-
-static inline bool is_idxd_dev(struct device *dev)
-{
-	return is_dsa_dev(dev) || is_iax_dev(dev);
-}
-
 static inline bool is_idxd_wq_dev(struct device *dev)
 {
 	return dev ? dev->type == &idxd_wq_device_type : false;
@@ -405,7 +380,7 @@ struct bus_type *idxd_get_bus_type(struct idxd_device *idxd)
 	return idxd_bus_types[idxd->type];
 }
 
-static struct device_type *idxd_get_device_type(struct idxd_device *idxd)
+struct device_type *idxd_get_device_type(struct idxd_device *idxd)
 {
 	if (idxd->type == IDXD_TYPE_DSA)
 		return &dsa_device_type;
@@ -1644,6 +1619,30 @@ static const struct attribute_group *idxd_attribute_groups[] = {
 	NULL,
 };
 
+static void idxd_conf_device_release(struct device *dev)
+{
+	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
+
+	kfree(idxd->groups);
+	kfree(idxd->wqs);
+	kfree(idxd->engines);
+	kfree(idxd->irq_entries);
+	ida_free(idxd_ida(idxd), idxd->id);
+	kfree(idxd);
+}
+
+struct device_type dsa_device_type = {
+	.name = "dsa",
+	.release = idxd_conf_device_release,
+	.groups = idxd_attribute_groups,
+};
+
+struct device_type iax_device_type = {
+	.name = "iax",
+	.release = idxd_conf_device_release,
+	.groups = idxd_attribute_groups,
+};
+
 static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -1745,39 +1744,14 @@ static int idxd_setup_wq_sysfs(struct idxd_device *idxd)
 	return rc;
 }
 
-static int idxd_setup_device_sysfs(struct idxd_device *idxd)
+int idxd_register_devices(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	int rc;
-	char devname[IDXD_NAME_SIZE];
 
-	sprintf(devname, "%s%d", idxd_get_dev_name(idxd), idxd->id);
-	idxd->conf_dev.parent = dev;
-	dev_set_name(&idxd->conf_dev, "%s", devname);
-	idxd->conf_dev.bus = idxd_get_bus_type(idxd);
-	idxd->conf_dev.groups = idxd_attribute_groups;
-	idxd->conf_dev.type = idxd_get_device_type(idxd);
-
-	dev_dbg(dev, "IDXD device register: %s\n", dev_name(&idxd->conf_dev));
-	rc = device_register(&idxd->conf_dev);
-	if (rc < 0) {
-		put_device(&idxd->conf_dev);
-		return rc;
-	}
-
-	return 0;
-}
-
-int idxd_setup_sysfs(struct idxd_device *idxd)
-{
-	struct device *dev = &idxd->pdev->dev;
-	int rc;
-
-	rc = idxd_setup_device_sysfs(idxd);
-	if (rc < 0) {
-		dev_dbg(dev, "Device sysfs registering failed: %d\n", rc);
+	rc = device_add(&idxd->conf_dev);
+	if (rc < 0)
 		return rc;
-	}
 
 	rc = idxd_setup_wq_sysfs(idxd);
 	if (rc < 0) {
@@ -1803,7 +1777,7 @@ int idxd_setup_sysfs(struct idxd_device *idxd)
 	return 0;
 }
 
-void idxd_cleanup_sysfs(struct idxd_device *idxd)
+void idxd_unregister_devices(struct idxd_device *idxd)
 {
 	int i;
 


