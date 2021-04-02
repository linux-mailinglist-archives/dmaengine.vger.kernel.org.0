Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1335300A
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDBT6A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:58:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:26793 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhDBT57 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:59 -0400
IronPort-SDR: fAzbRENq51fkfR0VygRgOKFchs/oN8BsmOR67r8UWnhsl8mFJvhTK/KwCw2U2511m52CmE6JII
 eXLdv3eM4n5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="277720086"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="277720086"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:58 -0700
IronPort-SDR: Zsrb2rqfzAIrweYqFjt2oRiEZfBMrZP+tT16pqA52GL55oPRdlo3BF1UI3uEQP5ECdtDDK/0RP
 d1fqL31S3ong==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="456546325"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:57 -0700
Subject: [PATCH v9 11/11] dmaengine: idxd: remove detection of device type
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:56 -0700
Message-ID: <161739347672.2945060.13854255339674044108.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move all static data type for per device type to an idxd_driver_data data
structure. The data can be attached to the pci_device_id and provided by
the pci probe function. This removes a lot of unnecessary type detection
and setup code.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c   |   11 +++-----
 drivers/dma/idxd/device.c |   16 +++--------
 drivers/dma/idxd/idxd.h   |   13 ++++++---
 drivers/dma/idxd/init.c   |   65 +++++++++++++++++----------------------------
 drivers/dma/idxd/submit.c |    2 +
 drivers/dma/idxd/sysfs.c  |   16 ++---------
 6 files changed, 48 insertions(+), 75 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 2d976905b2a3..302cba5ff779 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -45,7 +45,7 @@ static void idxd_cdev_dev_release(struct device *dev)
 	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_wq *wq = idxd_cdev->wq;
 
-	cdev_ctx = &ictx[wq->idxd->type];
+	cdev_ctx = &ictx[wq->idxd->data->type];
 	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
@@ -239,7 +239,7 @@ static const struct file_operations idxd_cdev_fops = {
 
 int idxd_cdev_get_major(struct idxd_device *idxd)
 {
-	return MAJOR(ictx[idxd->type].devt);
+	return MAJOR(ictx[idxd->data->type].devt);
 }
 
 int idxd_wq_add_cdev(struct idxd_wq *wq)
@@ -258,7 +258,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	idxd_cdev->wq = wq;
 	cdev = &idxd_cdev->cdev;
 	dev = &idxd_cdev->dev;
-	cdev_ctx = &ictx[wq->idxd->type];
+	cdev_ctx = &ictx[wq->idxd->data->type];
 	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
 		kfree(idxd_cdev);
@@ -272,8 +272,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	dev->type = &idxd_cdev_device_type;
 	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
 
-	rc = dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
-			  idxd->id, wq->id);
+	rc = dev_set_name(dev, "%s/wq%u.%u", idxd->data->name_prefix, idxd->id, wq->id);
 	if (rc < 0)
 		goto err;
 
@@ -298,7 +297,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 	struct idxd_cdev *idxd_cdev;
 	struct idxd_cdev_context *cdev_ctx;
 
-	cdev_ctx = &ictx[wq->idxd->type];
+	cdev_ctx = &ictx[wq->idxd->data->type];
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, &idxd_cdev->dev);
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 1e5380b2a88c..b8939e7eccfb 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -144,14 +144,8 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	if (rc < 0)
 		return rc;
 
-	if (idxd->type == IDXD_TYPE_DSA)
-		align = 32;
-	else if (idxd->type == IDXD_TYPE_IAX)
-		align = 64;
-	else
-		return -ENODEV;
-
-	wq->compls_size = num_descs * idxd->compl_size + align;
+	align = idxd->data->align;
+	wq->compls_size = num_descs * idxd->data->compl_size + align;
 	wq->compls_raw = dma_alloc_coherent(dev, wq->compls_size,
 					    &wq->compls_addr_raw, GFP_KERNEL);
 	if (!wq->compls_raw) {
@@ -178,11 +172,11 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 		struct idxd_desc *desc = wq->descs[i];
 
 		desc->hw = wq->hw_descs[i];
-		if (idxd->type == IDXD_TYPE_DSA)
+		if (idxd->data->type == IDXD_TYPE_DSA)
 			desc->completion = &wq->compls[i];
-		else if (idxd->type == IDXD_TYPE_IAX)
+		else if (idxd->data->type == IDXD_TYPE_IAX)
 			desc->iax_completion = &wq->iax_compls[i];
-		desc->compl_dma = wq->compls_addr + idxd->compl_size * i;
+		desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;
 		desc->id = i;
 		desc->wq = wq;
 		desc->cpu = -1;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 25b6b88f312f..eee94121991e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -178,9 +178,17 @@ struct idxd_dma_dev {
 	struct dma_device dma;
 };
 
-struct idxd_device {
+struct idxd_driver_data {
+	const char *name_prefix;
 	enum idxd_type type;
+	struct device_type *dev_type;
+	int compl_size;
+	int align;
+};
+
+struct idxd_device {
 	struct device conf_dev;
+	struct idxd_driver_data *data;
 	struct list_head list;
 	struct idxd_hw hw;
 	enum idxd_device_state state;
@@ -218,7 +226,6 @@ struct idxd_device {
 	int token_limit;
 	int nr_tokens;		/* non-reserved tokens */
 	unsigned int wqcfg_size;
-	int compl_size;
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
@@ -347,14 +354,12 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
-const char *idxd_get_dev_name(struct idxd_device *idxd);
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
 void idxd_unregister_devices(struct idxd_device *idxd);
 int idxd_register_driver(void);
 void idxd_unregister_driver(void);
-struct device_type *idxd_get_device_type(struct idxd_device *idxd);
 
 /* device interrupt control */
 irqreturn_t idxd_irq_handler(int vec, void *data);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 69f9fe0d2812..8c732d184a90 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -35,26 +35,33 @@ MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
 bool support_enqcmd;
 DEFINE_IDA(idxd_ida);
 
+static struct idxd_driver_data idxd_driver_data[] = {
+	[IDXD_TYPE_DSA] = {
+		.name_prefix = "dsa",
+		.type = IDXD_TYPE_DSA,
+		.compl_size = sizeof(struct dsa_completion_record),
+		.align = 32,
+		.dev_type = &dsa_device_type,
+	},
+	[IDXD_TYPE_IAX] = {
+		.name_prefix = "iax",
+		.type = IDXD_TYPE_IAX,
+		.compl_size = sizeof(struct iax_completion_record),
+		.align = 64,
+		.dev_type = &iax_device_type,
+	},
+};
+
 static struct pci_device_id idxd_pci_tbl[] = {
 	/* DSA ver 1.0 platforms */
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_DSA_SPR0) },
+	{ PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
 
 	/* IAX ver 1.0 platforms */
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IAX_SPR0) },
+	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
 
-static char *idxd_name[] = {
-	"dsa",
-	"iax"
-};
-
-const char *idxd_get_dev_name(struct idxd_device *idxd)
-{
-	return idxd_name[idxd->type];
-}
-
 static int idxd_setup_interrupts(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -387,19 +394,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	}
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
-static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
+static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
@@ -410,7 +405,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 		return NULL;
 
 	idxd->pdev = pdev;
-	idxd_set_type(idxd);
+	idxd->data = data;
 	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
 	if (idxd->id < 0)
 		return NULL;
@@ -418,8 +413,8 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 	device_initialize(&idxd->conf_dev);
 	idxd->conf_dev.parent = dev;
 	idxd->conf_dev.bus = &dsa_bus_type;
-	idxd->conf_dev.type = idxd_get_device_type(idxd);
-	rc = dev_set_name(&idxd->conf_dev, "%s%d", idxd_get_dev_name(idxd), idxd->id);
+	idxd->conf_dev.type = idxd->data->dev_type;
+	rc = dev_set_name(&idxd->conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
 	if (rc < 0) {
 		put_device(&idxd->conf_dev);
 		return NULL;
@@ -511,18 +506,11 @@ static int idxd_probe(struct idxd_device *idxd)
 	return rc;
 }
 
-static void idxd_type_init(struct idxd_device *idxd)
-{
-	if (idxd->type == IDXD_TYPE_DSA)
-		idxd->compl_size = sizeof(struct dsa_completion_record);
-	else if (idxd->type == IDXD_TYPE_IAX)
-		idxd->compl_size = sizeof(struct iax_completion_record);
-}
-
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
+	struct idxd_driver_data *data = (struct idxd_driver_data *)id->driver_data;
 	int rc;
 
 	rc = pci_enable_device(pdev);
@@ -530,7 +518,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	dev_dbg(dev, "Alloc IDXD context\n");
-	idxd = idxd_alloc(pdev);
+	idxd = idxd_alloc(pdev, data);
 	if (!idxd) {
 		rc = -ENOMEM;
 		goto err_idxd_alloc;
@@ -556,9 +544,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		goto err;
 
-
-	idxd_type_init(idxd);
-
 	dev_dbg(dev, "Set PCI master\n");
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, idxd);
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index a7a61bcc17d5..dfc8900d5de3 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -15,7 +15,7 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 
 	desc = wq->descs[idx];
 	memset(desc->hw, 0, sizeof(struct dsa_hw_desc));
-	memset(desc->completion, 0, idxd->compl_size);
+	memset(desc->completion, 0, idxd->data->compl_size);
 	desc->cpu = cpu;
 
 	if (device_pasid_enabled(idxd))
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 5a87b9f9c06b..6d38bf9034e6 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -315,16 +315,6 @@ static struct idxd_device_driver dsa_drv = {
 	},
 };
 
-struct device_type *idxd_get_device_type(struct idxd_device *idxd)
-{
-	if (idxd->type == IDXD_TYPE_DSA)
-		return &dsa_device_type;
-	else if (idxd->type == IDXD_TYPE_IAX)
-		return &iax_device_type;
-	else
-		return NULL;
-}
-
 /* IDXD generic driver setup */
 int idxd_register_driver(void)
 {
@@ -458,7 +448,7 @@ static ssize_t group_tokens_reserved_store(struct device *dev,
 	if (rc < 0)
 		return -EINVAL;
 
-	if (idxd->type == IDXD_TYPE_IAX)
+	if (idxd->data->type == IDXD_TYPE_IAX)
 		return -EOPNOTSUPP;
 
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
@@ -506,7 +496,7 @@ static ssize_t group_tokens_allowed_store(struct device *dev,
 	if (rc < 0)
 		return -EINVAL;
 
-	if (idxd->type == IDXD_TYPE_IAX)
+	if (idxd->data->type == IDXD_TYPE_IAX)
 		return -EOPNOTSUPP;
 
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
@@ -551,7 +541,7 @@ static ssize_t group_use_token_limit_store(struct device *dev,
 	if (rc < 0)
 		return -EINVAL;
 
-	if (idxd->type == IDXD_TYPE_IAX)
+	if (idxd->data->type == IDXD_TYPE_IAX)
 		return -EOPNOTSUPP;
 
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))


