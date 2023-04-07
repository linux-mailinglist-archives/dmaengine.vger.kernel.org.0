Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFB6DB53C
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDGUbc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDGUba (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40147EFB;
        Fri,  7 Apr 2023 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899488; x=1712435488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ngXrO0o6AXmdYyVosETmc1YGosElXndGhHoo8prr9z0=;
  b=Vg6pWWBLzdnaR6nemk9uPdw7loUbFGW1Q1ocOLwVnCvmaHOxopymmYVq
   J7eLlPwk3Kvi36HvzHN9OKqzjbgNeEU+mZVzGfTqo3H+ynR5SX8xIAsxr
   eIXMrSSftxPyCBiip7cWN3XTMvaVgVlJtpe+eY9/TVQoA63zwyvb0BTyf
   jCgI8zWKUCygSUsAMAZLAE1Tde65k8xXkruoxWF2naLpJFaxbpfnQUgJ0
   BSFV+qpzI/U5O3lhA0EIwpa7QMUYO77ABtuZO+Q8Hu+ovctIvg/QWkHpx
   sAJvMXPknWHBDPovZAOJuFRxKByvnKvhM9XkBO74wrPCpV6DywnfpvSbk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196858"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196858"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125876"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125876"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 05/16] dmanegine: idxd: add debugfs for event log dump
Date:   Fri,  7 Apr 2023 13:31:32 -0700
Message-Id: <20230407203143.2189681-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add debugfs entry to dump the content of the event log for debugging. The
function will dump all non-zero entries in the event log. It will note
which entries are processed and which entries are still pending processing
at the time of the dump. The entries may not always be in chronological
order due to the log is a circular buffer.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/Makefile  |   2 +-
 drivers/dma/idxd/debugfs.c | 138 +++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h    |   9 +++
 drivers/dma/idxd/init.c    |  12 ++++
 include/uapi/linux/idxd.h  |   6 +-
 5 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 drivers/dma/idxd/debugfs.c

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index a1e9f2b3a37c..dc096839ac63 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,7 +1,7 @@
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
-idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
+idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
 
 idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
 
diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
new file mode 100644
index 000000000000..9cfbd9b14c4c
--- /dev/null
+++ b/drivers/dma/idxd/debugfs.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/debugfs.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <uapi/linux/idxd.h>
+#include "idxd.h"
+#include "registers.h"
+
+static struct dentry *idxd_debugfs_dir;
+
+static void dump_event_entry(struct idxd_device *idxd, struct seq_file *s,
+			     u16 index, int *count, bool processed)
+{
+	struct idxd_evl *evl = idxd->evl;
+	struct dsa_evl_entry *entry;
+	struct dsa_completion_record *cr;
+	u64 *raw;
+	int i;
+	int evl_strides = evl_ent_size(idxd) / sizeof(u64);
+
+	entry = (struct dsa_evl_entry *)evl->log + index;
+
+	if (!entry->e.desc_valid)
+		return;
+
+	seq_printf(s, "Event Log entry %d (real index %u) processed: %u\n",
+		   *count, index, processed);
+
+	seq_printf(s, "desc valid %u wq idx valid %u\n"
+		   "batch %u fault rw %u priv %u error 0x%x\n"
+		   "wq idx %u op %#x pasid %u batch idx %u\n"
+		   "fault addr %#llx\n",
+		   entry->e.desc_valid, entry->e.wq_idx_valid,
+		   entry->e.batch, entry->e.fault_rw, entry->e.priv,
+		   entry->e.error, entry->e.wq_idx, entry->e.operation,
+		   entry->e.pasid, entry->e.batch_idx, entry->e.fault_addr);
+
+	cr = &entry->cr;
+	seq_printf(s, "status %#x result %#x fault_info %#x bytes_completed %u\n"
+		   "fault addr %#llx inv flags %#x\n\n",
+		   cr->status, cr->result, cr->fault_info, cr->bytes_completed,
+		   cr->fault_addr, cr->invalid_flags);
+
+	raw = (u64 *)entry;
+
+	for (i = 0; i < evl_strides; i++)
+		seq_printf(s, "entry[%d] = %#llx\n", i, raw[i]);
+
+	seq_puts(s, "\n");
+	*count += 1;
+}
+
+static int debugfs_evl_show(struct seq_file *s, void *d)
+{
+	struct idxd_device *idxd = s->private;
+	struct idxd_evl *evl = idxd->evl;
+	union evl_status_reg evl_status;
+	u16 h, t, evl_size, i;
+	int count = 0;
+	bool processed = true;
+
+	if (!evl || !evl->log)
+		return 0;
+
+	spin_lock(&evl->lock);
+
+	h = evl->head;
+	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
+	t = evl_status.tail;
+	evl_size = evl->size;
+
+	seq_printf(s, "Event Log head %u tail %u interrupt pending %u\n\n",
+		   evl_status.head, evl_status.tail, evl_status.int_pending);
+
+	i = t;
+	while (1) {
+		i = (i + 1) % evl_size;
+		if (i == t)
+			break;
+
+		if (processed && i == h)
+			processed = false;
+		dump_event_entry(idxd, s, i, &count, processed);
+	}
+
+	spin_unlock(&evl->lock);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(debugfs_evl);
+
+int idxd_device_init_debugfs(struct idxd_device *idxd)
+{
+	if (IS_ERR_OR_NULL(idxd_debugfs_dir))
+		return 0;
+
+	idxd->dbgfs_dir = debugfs_create_dir(dev_name(idxd_confdev(idxd)), idxd_debugfs_dir);
+	if (IS_ERR(idxd->dbgfs_dir))
+		return PTR_ERR(idxd->dbgfs_dir);
+
+	if (idxd->evl) {
+		idxd->dbgfs_evl_file = debugfs_create_file("event_log", 0400,
+							   idxd->dbgfs_dir, idxd,
+							   &debugfs_evl_fops);
+		if (IS_ERR(idxd->dbgfs_evl_file)) {
+			debugfs_remove_recursive(idxd->dbgfs_dir);
+			idxd->dbgfs_dir = NULL;
+			return PTR_ERR(idxd->dbgfs_evl_file);
+		}
+	}
+
+	return 0;
+}
+
+void idxd_device_remove_debugfs(struct idxd_device *idxd)
+{
+	debugfs_remove_recursive(idxd->dbgfs_dir);
+}
+
+int idxd_init_debugfs(void)
+{
+	if (!debugfs_initialized())
+		return 0;
+
+	idxd_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (IS_ERR(idxd_debugfs_dir))
+		return  PTR_ERR(idxd_debugfs_dir);
+	return 0;
+}
+
+void idxd_remove_debugfs(void)
+{
+	debugfs_remove_recursive(idxd_debugfs_dir);
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c74681f02b18..b923b90b7299 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -330,6 +330,9 @@ struct idxd_device {
 
 	unsigned long *opcap_bmap;
 	struct idxd_evl *evl;
+
+	struct dentry *dbgfs_dir;
+	struct dentry *dbgfs_evl_file;
 };
 
 static inline unsigned int evl_ent_size(struct idxd_device *idxd)
@@ -704,4 +707,10 @@ static inline void perfmon_init(void) {}
 static inline void perfmon_exit(void) {}
 #endif
 
+/* debugfs */
+int idxd_device_init_debugfs(struct idxd_device *idxd);
+void idxd_device_remove_debugfs(struct idxd_device *idxd);
+int idxd_init_debugfs(void);
+void idxd_remove_debugfs(void);
+
 #endif
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2ffeb2f3a2c8..d19bc6389221 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -670,6 +670,10 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_dev_register;
 	}
 
+	rc = idxd_device_init_debugfs(idxd);
+	if (rc)
+		dev_warn(dev, "IDXD debugfs failed to setup\n");
+
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
@@ -732,6 +736,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
+	idxd_device_remove_debugfs(idxd);
 
 	irq_entry = idxd_get_ie(idxd, 0);
 	free_irq(irq_entry->vector, irq_entry);
@@ -789,6 +794,10 @@ static int __init idxd_init_module(void)
 	if (err)
 		goto err_cdev_register;
 
+	err = idxd_init_debugfs();
+	if (err)
+		goto err_debugfs;
+
 	err = pci_register_driver(&idxd_pci_driver);
 	if (err)
 		goto err_pci_register;
@@ -796,6 +805,8 @@ static int __init idxd_init_module(void)
 	return 0;
 
 err_pci_register:
+	idxd_remove_debugfs();
+err_debugfs:
 	idxd_cdev_remove();
 err_cdev_register:
 	idxd_driver_unregister(&idxd_user_drv);
@@ -816,5 +827,6 @@ static void __exit idxd_exit_module(void)
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	perfmon_exit();
+	idxd_remove_debugfs();
 }
 module_exit(idxd_exit_module);
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 1b33834336ab..9f66a40287b7 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -286,7 +286,8 @@ struct dsa_completion_record {
 		uint8_t		result;
 		uint8_t		dif_status;
 	};
-	uint16_t		rsvd;
+	uint8_t			fault_info;
+	uint8_t			rsvd;
 	uint32_t		bytes_completed;
 	uint64_t		fault_addr;
 	union {
@@ -335,7 +336,8 @@ struct dsa_raw_completion_record {
 struct iax_completion_record {
 	volatile uint8_t        status;
 	uint8_t                 error_code;
-	uint16_t                rsvd;
+	uint8_t			fault_info;
+	uint8_t			rsvd;
 	uint32_t                bytes_completed;
 	uint64_t                fault_addr;
 	uint32_t                invalid_flags;
-- 
2.37.1

