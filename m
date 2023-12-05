Return-Path: <dmaengine+bounces-390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D758060C6
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 22:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7CC1F21641
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15356E2AD;
	Tue,  5 Dec 2023 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2VbCR0X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55DA5;
	Tue,  5 Dec 2023 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811578; x=1733347578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOJKKwBDyPTvOhkSfKzfKhw74WOFaAM0dGsOitiUkxI=;
  b=I2VbCR0XapuLrgTrF9vfCFcYUqU9bi1mOdN312awnDNwqESNRShDoRAC
   DOtLnyY2w2/83T9AuuPDkTlDFZItXCc+nmYpLf/C/ng7sCQd8ZHav64bl
   x3zUdrS3JxiSI+P270ZhWJgEjX2PxODn06cJuuNRFcVlARIWLGp8qRjjc
   62Tk4OKOQy5RXKl9XKOnP7e4MSwm3UqyiQzevwnYgoRdTtNeBbDoy8k7r
   Eub+yJsV+tlrBc78l5kIu/N7KxIxnMT8KuR+QtelgyDS5Q7mH7VyhbBW4
   Qpcj2fMlwRDdCq/dpOJsN6uzWoKD600WZDChMVTEkR49DNe2SLbXYSttP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396751714"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="396751714"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="19102743"
Received: from jsamonte-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.71.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:26:16 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	vinodh.gopal@intel.com,
	giovanni.cabiddu@intel.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v12 14/14] dmaengine: idxd: Add support for device/wq defaults
Date: Tue,  5 Dec 2023 15:25:30 -0600
Message-Id: <20231205212530.285671-15-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a load_device_defaults() function pointer to struct
idxd_driver_data, which if defined, will be called when an idxd device
is probed and will allow the idxd device to be configured with default
values.

The load_device_defaults() function is passed an idxd device to work
with to set specific device attributes.

Also add a load_device_defaults() implementation IAA devices; future
patches would add default functions for other device types such as
DSA.

The way idxd device probing works, if the device configuration is
valid at that point e.g. at least one workqueue and engine is properly
configured then the device will be enabled and ready to go.

The IAA implementation, idxd_load_iaa_device_defaults(), configures a
single workqueue (wq0) for each device with the following default
values:

      mode     	        "dedicated"
      threshold		0
      size		Total WQ Size from WQCAP
      priority		10
      type		IDXD_WQT_KERNEL
      group		0
      name              "iaa_crypto"
      driver_name       "crypto"

Note that this now adds another configuration step for any users that
want to configure their own devices/workqueus with something different
in that they'll first need to disable (in the case of IAA) wq0 and the
device itself before they can set their own attributes and re-enable,
since they've been already been auto-enabled.  Note also that in order
for the new configuration to be applied to the deflate-iaa crypto
algorithm the iaa_crypto module needs to unregister the old version,
which is accomplished by removing the iaa_crypto module, and
re-registering it with the new configuration by reinserting the
iaa_crypto module.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/Makefile   |  2 +-
 drivers/dma/idxd/defaults.c | 53 +++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h     |  4 +++
 drivers/dma/idxd/init.c     |  7 +++++
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/idxd/defaults.c

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index c5e679070e46..2b4a0d406e1e 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
 idxd_bus-y := bus.o
 
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
-idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
+idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o defaults.o
 
 idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
 
diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
new file mode 100644
index 000000000000..c607ae8dd12c
--- /dev/null
+++ b/drivers/dma/idxd/defaults.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation. All rights rsvd. */
+#include <linux/kernel.h>
+#include "idxd.h"
+
+int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct idxd_group *group;
+	struct idxd_wq *wq;
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return 0;
+
+	wq = idxd->wqs[0];
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	/* set mode to "dedicated" */
+	set_bit(WQ_FLAG_DEDICATED, &wq->flags);
+	wq->threshold = 0;
+
+	/* only setting up 1 wq, so give it all the wq space */
+	wq->size = idxd->max_wq_size;
+
+	/* set priority to 10 */
+	wq->priority = 10;
+
+	/* set type to "kernel" */
+	wq->type = IDXD_WQT_KERNEL;
+
+	/* set wq group to 0 */
+	group = idxd->groups[0];
+	wq->group = group;
+	group->num_wqs++;
+
+	/* set name to "iaa_crypto" */
+	memset(wq->name, 0, WQ_NAME_SIZE + 1);
+	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
+
+	/* set driver_name to "crypto" */
+	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
+	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
+
+	engine = idxd->engines[0];
+
+	/* set engine group to 0 */
+	engine->group = idxd->groups[0];
+	engine->group->num_engines++;
+
+	return 0;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 62ea21b25906..47de3f93ff1e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -277,6 +277,8 @@ struct idxd_dma_dev {
 	struct dma_device dma;
 };
 
+typedef int (*load_device_defaults_fn_t) (struct idxd_device *idxd);
+
 struct idxd_driver_data {
 	const char *name_prefix;
 	enum idxd_type type;
@@ -286,6 +288,7 @@ struct idxd_driver_data {
 	int evl_cr_off;
 	int cr_status_off;
 	int cr_result_off;
+	load_device_defaults_fn_t load_device_defaults;
 };
 
 struct idxd_evl {
@@ -730,6 +733,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
 bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
 void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
+int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
 
 /* device interrupt control */
 irqreturn_t idxd_misc_thread(int vec, void *data);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 0eb1c827a215..14df1f1347a8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -59,6 +59,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
 		.cr_status_off = offsetof(struct iax_completion_record, status),
 		.cr_result_off = offsetof(struct iax_completion_record, error_code),
+		.load_device_defaults = idxd_load_iaa_device_defaults,
 	},
 };
 
@@ -745,6 +746,12 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
+	if (data->load_device_defaults) {
+		rc = data->load_device_defaults(idxd);
+		if (rc)
+			dev_warn(dev, "IDXD loading device defaults failed\n");
+	}
+
 	rc = idxd_register_devices(idxd);
 	if (rc) {
 		dev_err(dev, "IDXD sysfs setup failed\n");
-- 
2.34.1


