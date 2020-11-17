Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D162B7047
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgKQUjT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 15:39:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:48530 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgKQUjT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Nov 2020 15:39:19 -0500
IronPort-SDR: k0/zEK40QmYHTWU48l//2QdsEGou/ZKAdBb6ynnu44tzVOT6jIqxpyJPW8O6XcypIHNg9J55nn
 HTOlAemIm8GQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158780230"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158780230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:39:16 -0800
IronPort-SDR: IaT4gzhWzbn4UZxwxwh+exCFrQ78wT6O+HOx7QnYxstdCut0haLkyF91Hl0CKHOiLhlRG2F1nC
 BrnScXb17dvw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544201953"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:39:15 -0800
Subject: [PATCH] dmaengine: idxd: add IAX configuration support in the IDXD
 driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com
Date:   Tue, 17 Nov 2020 13:39:14 -0700
Message-ID: <160564555488.1834439.4261958859935360473.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support to allow configuration of Intel Analytics Accelerator (IAX) in
addition to the Intel Data Streaming Accelerator (DSA). The IAX hardware
has the same configuration interface as DSA. The main difference
is the type of operations it performs. We can support the DSA and
IAX devices on the same driver with some tweaks.

IAX has a 64B completion record that needs to be 64B aligned, as opposed to
a 32B completion record that is 32B aligned for DSA. IAX also does not
support token management.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c      |    1 +
 drivers/dma/idxd/device.c    |   37 +++++++++++++++-----
 drivers/dma/idxd/idxd.h      |   24 +++++++++++--
 drivers/dma/idxd/init.c      |   14 +++++++
 drivers/dma/idxd/registers.h |    1 +
 drivers/dma/idxd/submit.c    |    2 +
 drivers/dma/idxd/sysfs.c     |   46 +++++++++++++++++++++++-
 include/uapi/linux/idxd.h    |   79 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 187 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 010b820d8f74..0db9b82ed8cf 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -28,6 +28,7 @@ struct idxd_cdev_context {
  */
 static struct idxd_cdev_context ictx[IDXD_TYPE_MAX] = {
 	{ .name = "dsa" },
+	{ .name = "iax" }
 };
 
 struct idxd_user_context {
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b75f9a09666e..47ff8e387172 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -131,6 +131,8 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
 	int rc, num_descs, i;
+	int align;
+	u64 tmp;
 
 	if (wq->type != IDXD_WQT_KERNEL)
 		return 0;
@@ -142,14 +144,27 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	if (rc < 0)
 		return rc;
 
-	wq->compls_size = num_descs * sizeof(struct dsa_completion_record);
-	wq->compls = dma_alloc_coherent(dev, wq->compls_size,
-					&wq->compls_addr, GFP_KERNEL);
-	if (!wq->compls) {
+	if (idxd->type == IDXD_TYPE_DSA)
+		align = 32;
+	else if (idxd->type == IDXD_TYPE_IAX)
+		align = 64;
+	else
+		return -ENODEV;
+
+	wq->compls_size = num_descs * idxd->compl_size + align;
+	wq->compls_raw = dma_alloc_coherent(dev, wq->compls_size,
+					    &wq->compls_addr_raw, GFP_KERNEL);
+	if (!wq->compls_raw) {
 		rc = -ENOMEM;
 		goto fail_alloc_compls;
 	}
 
+	/* Adjust alignment */
+	wq->compls_addr = (wq->compls_addr_raw + (align - 1)) & ~(align - 1);
+	tmp = (u64)wq->compls_raw;
+	tmp = (tmp + (align - 1)) & ~(align - 1);
+	wq->compls = (struct dsa_completion_record *)tmp;
+
 	rc = alloc_descs(wq, num_descs);
 	if (rc < 0)
 		goto fail_alloc_descs;
@@ -163,9 +178,11 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 		struct idxd_desc *desc = wq->descs[i];
 
 		desc->hw = wq->hw_descs[i];
-		desc->completion = &wq->compls[i];
-		desc->compl_dma  = wq->compls_addr +
-			sizeof(struct dsa_completion_record) * i;
+		if (idxd->type == IDXD_TYPE_DSA)
+			desc->completion = &wq->compls[i];
+		else if (idxd->type == IDXD_TYPE_IAX)
+			desc->iax_completion = &wq->iax_compls[i];
+		desc->compl_dma = wq->compls_addr + idxd->compl_size * i;
 		desc->id = i;
 		desc->wq = wq;
 		desc->cpu = -1;
@@ -178,7 +195,8 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
  fail_sbitmap_init:
 	free_descs(wq);
  fail_alloc_descs:
-	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
+	dma_free_coherent(dev, wq->compls_size, wq->compls_raw,
+			  wq->compls_addr_raw);
  fail_alloc_compls:
 	free_hw_descs(wq);
 	return rc;
@@ -193,7 +211,8 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 
 	free_hw_descs(wq);
 	free_descs(wq);
-	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
+	dma_free_coherent(dev, wq->compls_size, wq->compls_raw,
+			  wq->compls_addr_raw);
 	sbitmap_queue_free(&wq->sbq);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 149934f8d097..5a50e91c71bf 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -20,7 +20,8 @@ extern struct kmem_cache *idxd_desc_pool;
 enum idxd_type {
 	IDXD_TYPE_UNKNOWN = -1,
 	IDXD_TYPE_DSA = 0,
-	IDXD_TYPE_MAX
+	IDXD_TYPE_IAX,
+	IDXD_TYPE_MAX,
 };
 
 #define IDXD_NAME_SIZE		128
@@ -114,8 +115,13 @@ struct idxd_wq {
 	u32 vec_ptr;		/* interrupt steering */
 	struct dsa_hw_desc **hw_descs;
 	int num_descs;
-	struct dsa_completion_record *compls;
+	union {
+		struct dsa_completion_record *compls;
+		struct iax_completion_record *iax_compls;
+	};
+	void *compls_raw;
 	dma_addr_t compls_addr;
+	dma_addr_t compls_addr_raw;
 	int compls_size;
 	struct idxd_desc **descs;
 	struct sbitmap_queue sbq;
@@ -196,6 +202,7 @@ struct idxd_device {
 	int token_limit;
 	int nr_tokens;		/* non-reserved tokens */
 	unsigned int wqcfg_size;
+	int compl_size;
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
@@ -210,9 +217,15 @@ struct idxd_device {
 
 /* IDXD software descriptor */
 struct idxd_desc {
-	struct dsa_hw_desc *hw;
+	union {
+		struct dsa_hw_desc *hw;
+		struct iax_hw_desc *iax_hw;
+	};
 	dma_addr_t desc_dma;
-	struct dsa_completion_record *completion;
+	union {
+		struct dsa_completion_record *completion;
+		struct iax_completion_record *iax_completion;
+	};
 	dma_addr_t compl_dma;
 	struct dma_async_tx_descriptor txd;
 	struct llist_node llnode;
@@ -226,6 +239,7 @@ struct idxd_desc {
 #define confdev_to_wq(dev) container_of(dev, struct idxd_wq, conf_dev)
 
 extern struct bus_type dsa_bus_type;
+extern struct bus_type iax_bus_type;
 
 extern bool support_enqcmd;
 
@@ -271,6 +285,8 @@ static inline void idxd_set_type(struct idxd_device *idxd)
 
 	if (pdev->device == PCI_DEVICE_ID_INTEL_DSA_SPR0)
 		idxd->type = IDXD_TYPE_DSA;
+	else if (pdev->device == PCI_DEVICE_ID_INTEL_IAX_SPR0)
+		idxd->type = IDXD_TYPE_IAX;
 	else
 		idxd->type = IDXD_TYPE_UNKNOWN;
 }
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 45b0eac640c3..2c051e07c34c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -36,12 +36,16 @@ static struct mutex idxd_idr_lock;
 static struct pci_device_id idxd_pci_tbl[] = {
 	/* DSA ver 1.0 platforms */
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_DSA_SPR0) },
+
+	/* IAX ver 1.0 platforms */
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IAX_SPR0) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
 
 static char *idxd_name[] = {
 	"dsa",
+	"iax"
 };
 
 const char *idxd_get_dev_name(struct idxd_device *idxd)
@@ -377,6 +381,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_type_init(struct idxd_device *idxd)
+{
+	if (idxd->type == IDXD_TYPE_DSA)
+		idxd->compl_size = sizeof(struct dsa_completion_record);
+	else if (idxd->type == IDXD_TYPE_IAX)
+		idxd->compl_size = sizeof(struct iax_completion_record);
+}
+
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -412,6 +424,8 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	idxd_set_type(idxd);
 
+	idxd_type_init(idxd);
+
 	dev_dbg(dev, "Set PCI master\n");
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, idxd);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 0cdc5405bc53..23c41fe52215 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -5,6 +5,7 @@
 
 /* PCI Config */
 #define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
+#define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
 
 #define IDXD_MMIO_BAR		0
 #define IDXD_WQ_BAR		2
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index efca5d8468a6..0ff64eeb84be 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -15,7 +15,7 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 
 	desc = wq->descs[idx];
 	memset(desc->hw, 0, sizeof(struct dsa_hw_desc));
-	memset(desc->completion, 0, sizeof(struct dsa_completion_record));
+	memset(desc->completion, 0, idxd->compl_size);
 	desc->cpu = cpu;
 
 	if (device_pasid_enabled(idxd))
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3af83f1fd36e..266423a2cabc 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -41,14 +41,24 @@ static struct device_type dsa_device_type = {
 	.release = idxd_conf_device_release,
 };
 
+static struct device_type iax_device_type = {
+	.name = "iax",
+	.release = idxd_conf_device_release,
+};
+
 static inline bool is_dsa_dev(struct device *dev)
 {
 	return dev ? dev->type == &dsa_device_type : false;
 }
 
+static inline bool is_iax_dev(struct device *dev)
+{
+	return dev ? dev->type == &iax_device_type : false;
+}
+
 static inline bool is_idxd_dev(struct device *dev)
 {
-	return is_dsa_dev(dev);
+	return is_dsa_dev(dev) || is_iax_dev(dev);
 }
 
 static inline bool is_idxd_wq_dev(struct device *dev)
@@ -359,8 +369,17 @@ struct bus_type dsa_bus_type = {
 	.shutdown = idxd_config_bus_shutdown,
 };
 
+struct bus_type iax_bus_type = {
+	.name = "iax",
+	.match = idxd_config_bus_match,
+	.probe = idxd_config_bus_probe,
+	.remove = idxd_config_bus_remove,
+	.shutdown = idxd_config_bus_shutdown,
+};
+
 static struct bus_type *idxd_bus_types[] = {
-	&dsa_bus_type
+	&dsa_bus_type,
+	&iax_bus_type
 };
 
 static struct idxd_device_driver dsa_drv = {
@@ -372,8 +391,18 @@ static struct idxd_device_driver dsa_drv = {
 	},
 };
 
+static struct idxd_device_driver iax_drv = {
+	.drv = {
+		.name = "iax",
+		.bus = &iax_bus_type,
+		.owner = THIS_MODULE,
+		.mod_name = KBUILD_MODNAME,
+	},
+};
+
 static struct idxd_device_driver *idxd_drvs[] = {
-	&dsa_drv
+	&dsa_drv,
+	&iax_drv
 };
 
 struct bus_type *idxd_get_bus_type(struct idxd_device *idxd)
@@ -385,6 +414,8 @@ static struct device_type *idxd_get_device_type(struct idxd_device *idxd)
 {
 	if (idxd->type == IDXD_TYPE_DSA)
 		return &dsa_device_type;
+	else if (idxd->type == IDXD_TYPE_IAX)
+		return &iax_device_type;
 	else
 		return NULL;
 }
@@ -525,6 +556,9 @@ static ssize_t group_tokens_reserved_store(struct device *dev,
 	if (rc < 0)
 		return -EINVAL;
 
+	if (idxd->type == IDXD_TYPE_IAX)
+		return -EOPNOTSUPP;
+
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 
@@ -570,6 +604,9 @@ static ssize_t group_tokens_allowed_store(struct device *dev,
 	if (rc < 0)
 		return -EINVAL;
 
+	if (idxd->type == IDXD_TYPE_IAX)
+		return -EOPNOTSUPP;
+
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 
@@ -612,6 +649,9 @@ static ssize_t group_use_token_limit_store(struct device *dev,
 	if (rc < 0)
 		return -EINVAL;
 
+	if (idxd->type == IDXD_TYPE_IAX)
+		return -EOPNOTSUPP;
+
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index fdcdfe414223..236d437947bc 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -26,6 +26,9 @@
 #define IDXD_OP_FLAG_DRDBK	0x4000
 #define IDXD_OP_FLAG_DSTS	0x8000
 
+/* IAX */
+#define IDXD_OP_FLAG_RD_SRC2_AECS	0x010000
+
 /* Opcode */
 enum dsa_opcode {
 	DSA_OPCODE_NOOP = 0,
@@ -47,6 +50,14 @@ enum dsa_opcode {
 	DSA_OPCODE_CFLUSH = 0x20,
 };
 
+enum iax_opcode {
+	IAX_OPCODE_NOOP = 0,
+	IAX_OPCODE_DRAIN = 2,
+	IAX_OPCODE_MEMMOVE,
+	IAX_OPCODE_DECOMPRESS = 0x42,
+	IAX_OPCODE_COMPRESS,
+};
+
 /* Completion record status */
 enum dsa_completion_status {
 	DSA_COMP_NONE = 0,
@@ -80,6 +91,33 @@ enum dsa_completion_status {
 	DSA_COMP_TRANSLATION_FAIL,
 };
 
+enum iax_completion_status {
+	IAX_COMP_NONE = 0,
+	IAX_COMP_SUCCESS,
+	IAX_COMP_PAGE_FAULT_IR = 0x04,
+	IAX_COMP_OUTBUF_OVERFLOW,
+	IAX_COMP_BAD_OPCODE = 0x10,
+	IAX_COMP_INVALID_FLAGS,
+	IAX_COMP_NOZERO_RESERVE,
+	IAX_COMP_INVALID_SIZE,
+	IAX_COMP_OVERLAP_BUFFERS = 0x16,
+	IAX_COMP_INT_HANDLE_INVAL = 0x19,
+	IAX_COMP_CRA_XLAT,
+	IAX_COMP_CRA_ALIGN,
+	IAX_COMP_ADDR_ALIGN,
+	IAX_COMP_PRIV_BAD,
+	IAX_COMP_TRAFFIC_CLASS_CONF,
+	IAX_COMP_PFAULT_RDBA,
+	IAX_COMP_HW_ERR1,
+	IAX_COMP_HW_ERR_DRB,
+	IAX_COMP_TRANSLATION_FAIL,
+	IAX_COMP_PRS_TIMEOUT,
+	IAX_COMP_WATCHDOG,
+	IAX_COMP_INVALID_COMP_FLAG = 0x30,
+	IAX_COMP_INVALID_FILTER_FLAG,
+	IAX_COMP_INVALID_NUM_ELEMS = 0x33,
+};
+
 #define DSA_COMP_STATUS_MASK		0x7f
 #define DSA_COMP_STATUS_WRITE		0x80
 
@@ -163,6 +201,28 @@ struct dsa_hw_desc {
 	};
 } __attribute__((packed));
 
+struct iax_hw_desc {
+	uint32_t        pasid:20;
+	uint32_t        rsvd:11;
+	uint32_t        priv:1;
+	uint32_t        flags:24;
+	uint32_t        opcode:8;
+	uint64_t        completion_addr;
+	uint64_t        src1_addr;
+	uint64_t        dst_addr;
+	uint32_t        src1_size;
+	uint16_t        int_handle;
+	union {
+		uint16_t        compr_flags;
+		uint16_t        decompr_flags;
+	};
+	uint64_t        src2_addr;
+	uint32_t        max_dst_size;
+	uint32_t        src2_size;
+	uint32_t	filter_flags;
+	uint32_t	num_inputs;
+} __attribute__((packed));
+
 struct dsa_raw_desc {
 	uint64_t	field[8];
 } __attribute__((packed));
@@ -223,4 +283,23 @@ struct dsa_raw_completion_record {
 	uint64_t	field[4];
 } __attribute__((packed));
 
+struct iax_completion_record {
+	volatile uint8_t        status;
+	uint8_t                 error_code;
+	uint16_t                rsvd;
+	uint32_t                bytes_completed;
+	uint64_t                fault_addr;
+	uint32_t                invalid_flags;
+	uint32_t                rsvd2;
+	uint32_t                output_size;
+	uint8_t                 output_bits;
+	uint8_t                 rsvd3;
+	uint16_t                rsvd4;
+	uint64_t                rsvd5[4];
+} __attribute__((packed));
+
+struct iax_raw_completion_record {
+	uint64_t	field[8];
+} __attribute__((packed));
+
 #endif


