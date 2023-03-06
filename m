Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A36ACD26
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCFSx2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCFSwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:52:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318E65115;
        Mon,  6 Mar 2023 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128768; x=1709664768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KqSKXDDfqjmEx9XDqpAUTxuP4dSo8DvMvYWaPrJ7Sw0=;
  b=P9C4bzTXEPb1SuhiS4ReK1mBMLH71IvJJnN1pFsOFcdosIrEV4ATLikg
   JQoVqL9rnHcFc1tguxCt3Mh2sm1uT+kpwj59vAKBmdVeJACXl93O7s0+F
   OAA/+NTXv4gjFERJ0sC0D8/NbNK9oa9L3xRkzK/8DH1fZaYfN4sTTboA9
   A5VJfnsWGViz43SOzJlXZJkaTrrff9u9mA6+kLQrK48IKZXb21qQGfxi5
   sRoISVy3FSMRWWqIfA6kqoBAHGNZiWRWiGQ62zVYNy/uwcA3t+kBN7N4C
   4wyhJD2O87Jic4xfOsd6ZpbYXTrm5EJ2uL+3rAK676bU4wbI4Y8r99S+o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227734"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255815"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255815"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:46 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 07/16] dmaengine: idxd: add callback support for iaa crypto
Date:   Mon,  6 Mar 2023 12:52:17 -0600
Message-Id: <20230306185226.26483-8-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
---
 drivers/dma/idxd/device.c |  2 +-
 drivers/dma/idxd/dma.c    |  3 +-
 drivers/dma/idxd/idxd.h   | 62 ++++++++++++++++++++++++++++++++-------
 drivers/dma/idxd/irq.c    | 12 ++++----
 drivers/dma/idxd/submit.c |  6 ++--
 5 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 7837d0a56314..636451249046 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1190,7 +1190,7 @@ static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
 		tx = &desc->txd;
 		tx->callback = NULL;
 		tx->callback_result = NULL;
-		idxd_dma_complete_txd(desc, ctype, true);
+		idxd_dma_complete_txd(desc, ctype, true, NULL, NULL);
 	}
 }
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 8bb7e7ff8d6a..9a12b02b0549 100644
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
@@ -358,6 +358,7 @@ static enum idxd_dev_type dev_types[] = {
 struct idxd_device_driver idxd_dmaengine_drv = {
 	.probe = idxd_dmaengine_drv_probe,
 	.remove = idxd_dmaengine_drv_remove,
+	.desc_complete = idxd_dma_complete_txd,
 	.name = "dmaengine",
 	.type = dev_types,
 };
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index e55213b5153e..9b8d7043e79c 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -13,6 +13,7 @@
 #include <linux/ioasid.h>
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
+#include <linux/crypto.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 
@@ -56,11 +57,23 @@ enum idxd_type {
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
 
@@ -164,12 +177,6 @@ enum idxd_op_type {
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
@@ -322,6 +329,14 @@ struct idxd_device {
 	unsigned long *opcap_bmap;
 };
 
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
@@ -334,7 +349,10 @@ struct idxd_desc {
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
@@ -360,6 +378,15 @@ enum idxd_completion_status {
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
@@ -602,6 +629,24 @@ void idxd_driver_unregister(struct idxd_device_driver *idxd_drv);
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
@@ -658,15 +703,12 @@ int idxd_wq_request_irq(struct idxd_wq *wq);
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
-void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
 
 /* dmaengine */
 int idxd_register_dma_device(struct idxd_device *idxd);
 void idxd_unregister_dma_device(struct idxd_device *idxd);
 void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
-void idxd_dma_complete_txd(struct idxd_desc *desc,
-			   enum idxd_complete_type comp_type, bool free_desc);
 
 /* cdev */
 int idxd_cdev_register(void);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index aa314ebec587..3f89236c97c1 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -121,7 +121,7 @@ static void idxd_abort_invalid_int_handle_descs(struct idxd_irq_entry *ie)
 
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del(&d->list);
-		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true);
+		idxd_desc_complete(d, IDXD_COMPLETE_ABORT, true);
 	}
 }
 
@@ -376,7 +376,7 @@ static void idxd_int_handle_resubmit_work(struct work_struct *work)
 		 */
 		if (rc != -EAGAIN) {
 			desc->completion->status = IDXD_COMP_DESC_ABORT;
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, false);
+			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, false);
 		}
 		idxd_free_desc(wq, desc);
 	}
@@ -417,11 +417,11 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
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
@@ -460,11 +460,11 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
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
index 9d9ec0b76ccd..7ab37c349b2f 100644
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

