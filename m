Return-Path: <dmaengine+bounces-254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F97FAB5D
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 21:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82ABB21261
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655A3EA8D;
	Mon, 27 Nov 2023 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxtXSlmj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F9172E;
	Mon, 27 Nov 2023 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701116843; x=1732652843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+16TGDFbGczjwVEHR20VFjlDoX6KPg2OQQUQCG8p4LE=;
  b=hxtXSlmjSfGw+ByU6McAELQhtuUreeb0gOmorwMDWpoDekdesAmt90pi
   Huzux8kXAuuoTrXk9n+CAC3UHFze4ol0CAfpDuwCP52mutrpD9omuuT6f
   92Sqa9NY0G2NtjOpYGYdxqv0FrhlzbpszkUzTEzbh0rgy8y5XAEb8jLzu
   X88WSkegZVfxmv3WDUpPB1TuDfgN58wmywp3YpFURDWN86YLo0Vt6Vu0Z
   DjaqfB7Qw3d1HZ2cYzhLtaVI5OpqevmWk0ycRhISYma9zAFcKIH+rJR5p
   bmxbr8ueqodXvPVni5XSysyXGNhZbDU7PYK6ozeuG1Us5cs5iDFIi56dK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457115525"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457115525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16394539"
Received: from rpkulapa-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.213.183.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:22 -0800
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
Subject: [PATCH v10 06/14] dmaengine: idxd: add callback support for iaa crypto
Date: Mon, 27 Nov 2023 14:26:56 -0600
Message-Id: <20231127202704.1263376-7-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a lightweight callback interface to allow idxd sub-drivers to
be notified when work sent to idxd wqs has completed.

For a sub-driver to be notified of work completion, it needs to:

  - Set the descriptor's 'Request Completion Interrupt'
    (IDXD_OP_FLAG_RCI)

  - Set the sub-driver desc_complete() callback when registering the
    sub-driver e.g.:

      struct idxd_device_driver my_drv = {
            .probe = my_probe,
            .desc_complete = my_complete,
      }

  - Set the sub-driver-specific context in the sub-driver's descriptor
    e.g:

      idxd_desc->crypto.req = req;
      idxd_desc->crypto.tfm = tfm;
      idxd_desc->crypto.src_addr = src_addr;
      idxd_desc->crypto.dst_addr = dst_addr;

When the work completes and the completion irq fires, idxd will invoke
the desc_complete() callback with pointers to the descriptor, context,
and completion_type.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/device.c |  2 +-
 drivers/dma/idxd/dma.c    |  3 +-
 drivers/dma/idxd/idxd.h   | 62 ++++++++++++++++++++++++++++++++-------
 drivers/dma/idxd/irq.c    | 12 ++++----
 drivers/dma/idxd/submit.c |  6 ++--
 5 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index e6176de0e12b..f43d81128b96 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1271,7 +1271,7 @@ static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
 		tx = &desc->txd;
 		tx->callback = NULL;
 		tx->callback_result = NULL;
-		idxd_dma_complete_txd(desc, ctype, true);
+		idxd_dma_complete_txd(desc, ctype, true, NULL, NULL);
 	}
 }
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index e7043e235408..cd835eabd31b 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -22,7 +22,7 @@ static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
 
 void idxd_dma_complete_txd(struct idxd_desc *desc,
 			   enum idxd_complete_type comp_type,
-			   bool free_desc)
+			   bool free_desc, void *ctx, u32 *status)
 {
 	struct idxd_device *idxd = desc->wq->idxd;
 	struct dma_async_tx_descriptor *tx;
@@ -359,6 +359,7 @@ static enum idxd_dev_type dev_types[] = {
 struct idxd_device_driver idxd_dmaengine_drv = {
 	.probe = idxd_dmaengine_drv_probe,
 	.remove = idxd_dmaengine_drv_remove,
+	.desc_complete = idxd_dma_complete_txd,
 	.name = "dmaengine",
 	.type = dev_types,
 };
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 4b67181f4396..62ea21b25906 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -13,6 +13,7 @@
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
 #include <linux/iommu.h>
+#include <linux/crypto.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 
@@ -57,11 +58,23 @@ enum idxd_type {
 #define IDXD_ENQCMDS_RETRIES		32
 #define IDXD_ENQCMDS_MAX_RETRIES	64
 
+enum idxd_complete_type {
+	IDXD_COMPLETE_NORMAL = 0,
+	IDXD_COMPLETE_ABORT,
+	IDXD_COMPLETE_DEV_FAIL,
+};
+
+struct idxd_desc;
+
 struct idxd_device_driver {
 	const char *name;
 	enum idxd_dev_type *type;
 	int (*probe)(struct idxd_dev *idxd_dev);
 	void (*remove)(struct idxd_dev *idxd_dev);
+	void (*desc_complete)(struct idxd_desc *desc,
+			      enum idxd_complete_type comp_type,
+			      bool free_desc,
+			      void *ctx, u32 *status);
 	struct device_driver drv;
 };
 
@@ -174,12 +187,6 @@ enum idxd_op_type {
 	IDXD_OP_NONBLOCK = 1,
 };
 
-enum idxd_complete_type {
-	IDXD_COMPLETE_NORMAL = 0,
-	IDXD_COMPLETE_ABORT,
-	IDXD_COMPLETE_DEV_FAIL,
-};
-
 struct idxd_dma_chan {
 	struct dma_chan chan;
 	struct idxd_wq *wq;
@@ -378,6 +385,14 @@ static inline unsigned int evl_size(struct idxd_device *idxd)
 	return idxd->evl->size * evl_ent_size(idxd);
 }
 
+struct crypto_ctx {
+	struct acomp_req *req;
+	struct crypto_tfm *tfm;
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
+	bool compress;
+};
+
 /* IDXD software descriptor */
 struct idxd_desc {
 	union {
@@ -390,7 +405,10 @@ struct idxd_desc {
 		struct iax_completion_record *iax_completion;
 	};
 	dma_addr_t compl_dma;
-	struct dma_async_tx_descriptor txd;
+	union {
+		struct dma_async_tx_descriptor txd;
+		struct crypto_ctx crypto;
+	};
 	struct llist_node llnode;
 	struct list_head list;
 	int id;
@@ -417,6 +435,15 @@ enum idxd_completion_status {
 #define idxd_dev_to_idxd(idxd_dev) container_of(idxd_dev, struct idxd_device, idxd_dev)
 #define idxd_dev_to_wq(idxd_dev) container_of(idxd_dev, struct idxd_wq, idxd_dev)
 
+static inline struct idxd_device_driver *wq_to_idxd_drv(struct idxd_wq *wq)
+{
+	struct device *dev = wq_confdev(wq);
+	struct idxd_device_driver *idxd_drv =
+		container_of(dev->driver, struct idxd_device_driver, drv);
+
+	return idxd_drv;
+}
+
 static inline struct idxd_device *confdev_to_idxd(struct device *dev)
 {
 	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
@@ -678,6 +705,24 @@ void idxd_driver_unregister(struct idxd_device_driver *idxd_drv);
 #define module_idxd_driver(__idxd_driver) \
 	module_driver(__idxd_driver, idxd_driver_register, idxd_driver_unregister)
 
+void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
+void idxd_dma_complete_txd(struct idxd_desc *desc,
+			   enum idxd_complete_type comp_type,
+			   bool free_desc, void *ctx, u32 *status);
+
+static inline void idxd_desc_complete(struct idxd_desc *desc,
+				      enum idxd_complete_type comp_type,
+				      bool free_desc)
+{
+	struct idxd_device_driver *drv;
+	u32 status;
+
+	drv = wq_to_idxd_drv(desc->wq);
+	if (drv->desc_complete)
+		drv->desc_complete(desc, comp_type, free_desc,
+				   &desc->txd, &status);
+}
+
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
@@ -731,14 +776,11 @@ int idxd_wq_request_irq(struct idxd_wq *wq);
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
-void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
 
 /* dmaengine */
 int idxd_register_dma_device(struct idxd_device *idxd);
 void idxd_unregister_dma_device(struct idxd_device *idxd);
-void idxd_dma_complete_txd(struct idxd_desc *desc,
-			   enum idxd_complete_type comp_type, bool free_desc);
 
 /* cdev */
 int idxd_cdev_register(void);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 2183d7f9cdbd..c8a0aa874b11 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -123,7 +123,7 @@ static void idxd_abort_invalid_int_handle_descs(struct idxd_irq_entry *ie)
 
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del(&d->list);
-		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true);
+		idxd_desc_complete(d, IDXD_COMPLETE_ABORT, true);
 	}
 }
 
@@ -534,7 +534,7 @@ static void idxd_int_handle_resubmit_work(struct work_struct *work)
 		 */
 		if (rc != -EAGAIN) {
 			desc->completion->status = IDXD_COMP_DESC_ABORT;
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, false);
+			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, false);
 		}
 		idxd_free_desc(wq, desc);
 	}
@@ -575,11 +575,11 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 			 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 			 */
 			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
-				idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
+				idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
 				continue;
 			}
 
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
+			idxd_desc_complete(desc, IDXD_COMPLETE_NORMAL, true);
 		} else {
 			spin_lock(&irq_entry->list_lock);
 			list_add_tail(&desc->list,
@@ -618,11 +618,11 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 		 */
 		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
+			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
 			continue;
 		}
 
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
+		idxd_desc_complete(desc, IDXD_COMPLETE_NORMAL, true);
 	}
 }
 
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 5e651e216094..f927743a5ba2 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -127,7 +127,8 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	spin_unlock(&ie->list_lock);
 
 	if (found)
-		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
+		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false,
+				      NULL, NULL);
 
 	/*
 	 * completing the descriptor will return desc to allocator and
@@ -137,7 +138,8 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	 */
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del_init(&d->list);
-		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true);
+		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true,
+				      NULL, NULL);
 	}
 }
 
-- 
2.34.1


