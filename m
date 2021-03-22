Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207534530D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCVXcJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:32:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:15037 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhCVXbn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:31:43 -0400
IronPort-SDR: ZMHlfU5qFLr1WFvIvtnnjCFmzLeWY55PpaeupkCAyimV7wsoPi4kvBmWvPq/9R6OPp3crl0hqj
 CPlb0CNy0acQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210442896"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210442896"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:39 -0700
IronPort-SDR: HNe9frucBQDr3Dm1Se15j3zf147p883K16ONojuNvorbf/shLUeuz1q+z9oB2eX5EWA42FwV+n
 oZWaZ7jqMdqQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414700269"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:38 -0700
Subject: [PATCH v7 4/8] dmaengine: idxd: fix idxd conf_dev 'struct device'
 lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, jgg@nvidia.com, dan.j.williams@intel.com
Date:   Mon, 22 Mar 2021 16:31:37 -0700
Message-ID: <161645589786.2002542.14985591762162555739.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/idxd.h  |   21 ++++++++++++-
 drivers/dma/idxd/init.c  |   22 ++++++++++----
 drivers/dma/idxd/sysfs.c |   72 +++++++++++++++++++++++-----------------------
 3 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 3409a84b8674..f3893a07f6d5 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -255,6 +255,23 @@ extern struct bus_type dsa_bus_type;
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
@@ -322,8 +339,8 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
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
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 080d31bf5b33..158f9e0158a3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -83,9 +83,8 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
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
@@ -144,6 +143,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
  err_misc_irq:
 	/* Disable error interrupt generation */
 	idxd_mask_error_interrupts(idxd);
+	kfree(idxd->irq_entries);
  err_irq_entries:
 	pci_free_irq_vectors(pdev);
 	dev_err(dev, "No usable interrupts\n");
@@ -276,7 +276,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
 
-	idxd = devm_kzalloc(dev, sizeof(struct idxd_device), GFP_KERNEL);
+	idxd = kzalloc_node(sizeof(*idxd), GFP_KERNEL, dev_to_node(dev));
 	if (!idxd)
 		return NULL;
 
@@ -320,6 +320,11 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
 	idxd->sva = NULL;
 }
 
+static void idxd_free(struct idxd_device *idxd)
+{
+	kfree(idxd);
+}
+
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -438,7 +443,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
-	rc = idxd_setup_sysfs(idxd);
+	rc = idxd_register_devices(idxd);
 	if (rc) {
 		dev_err(dev, "IDXD sysfs setup failed\n");
 		goto err;
@@ -454,6 +459,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
+	idxd_free(idxd);
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
@@ -519,15 +525,17 @@ static void idxd_shutdown(struct pci_dev *pdev)
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	int id = idxd->id;
+	enum idxd_type type = idxd->type;
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
-	idxd_cleanup_sysfs(idxd);
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	mutex_lock(&idxd_idr_lock);
-	idr_remove(&idxd_idrs[idxd->type], idxd->id);
+	idr_remove(&idxd_idrs[type], id);
 	mutex_unlock(&idxd_idr_lock);
+	idxd_unregister_devices(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 4dbb03c545e4..55a92dfe0fad 100644
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
-};
-
-static struct device_type dsa_device_type = {
-	.name = "dsa",
-	.release = idxd_conf_device_release,
-};
-
-static struct device_type iax_device_type = {
-	.name = "iax",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_sub_device_release,
 };
 
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
@@ -1643,6 +1618,29 @@ static const struct attribute_group *idxd_attribute_groups[] = {
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
@@ -1748,17 +1746,19 @@ static int idxd_setup_device_sysfs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	int rc;
-	char devname[IDXD_NAME_SIZE];
 
-	sprintf(devname, "%s%d", idxd_get_dev_name(idxd), idxd->id);
+	device_initialize(&idxd->conf_dev);
 	idxd->conf_dev.parent = dev;
-	dev_set_name(&idxd->conf_dev, "%s", devname);
 	idxd->conf_dev.bus = idxd_get_bus_type(idxd);
-	idxd->conf_dev.groups = idxd_attribute_groups;
 	idxd->conf_dev.type = idxd_get_device_type(idxd);
+	rc = dev_set_name(&idxd->conf_dev, "%s%d", idxd_get_dev_name(idxd), idxd->id);
+	if (rc < 0) {
+		put_device(&idxd->conf_dev);
+		return rc;
+	}
 
 	dev_dbg(dev, "IDXD device register: %s\n", dev_name(&idxd->conf_dev));
-	rc = device_register(&idxd->conf_dev);
+	rc = device_add(&idxd->conf_dev);
 	if (rc < 0) {
 		put_device(&idxd->conf_dev);
 		return rc;
@@ -1767,7 +1767,7 @@ static int idxd_setup_device_sysfs(struct idxd_device *idxd)
 	return 0;
 }
 
-int idxd_setup_sysfs(struct idxd_device *idxd)
+int idxd_register_devices(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	int rc;
@@ -1802,7 +1802,7 @@ int idxd_setup_sysfs(struct idxd_device *idxd)
 	return 0;
 }
 
-void idxd_cleanup_sysfs(struct idxd_device *idxd)
+void idxd_unregister_devices(struct idxd_device *idxd)
 {
 	int i;
 


