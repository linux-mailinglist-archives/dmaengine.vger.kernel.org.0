Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936B1346808
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 19:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhCWSqo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 14:46:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:37124 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhCWSqU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Mar 2021 14:46:20 -0400
IronPort-SDR: aqh8fsKA4pFPlm/OLZjws8H5Td1cXfJ4J/rtBsgkxvSqdXhl2KIl9i6pBY0A/0rUjuEOk7fPxA
 +Ghld/3Pz6qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="210632019"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="210632019"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:46:19 -0700
IronPort-SDR: LYYcsRvCI7axhTjD1dJG+kxAvC0zU48IX0LyJQlP8lEHiC7qGmXDjHpkLMpTmVI13x2CE1kM3g
 wTZq/giH9krQ==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="408453737"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:46:17 -0700
Subject: [PATCH] dmaengine: idxd: support reporting of halt interrupt
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 23 Mar 2021 11:46:17 -0700
Message-ID: <161652517756.2028441.16745666668367749220.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Unmask the halt error interrupt so it gets reported to the interrupt
handler. When halt state interrupt is received, quiesce the kernel
WQs and unmap the portals to stop submission.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |   15 +++++++++++++++
 drivers/dma/idxd/idxd.h      |    2 ++
 drivers/dma/idxd/init.c      |    2 +-
 drivers/dma/idxd/irq.c       |    2 ++
 drivers/dma/idxd/registers.h |    3 ++-
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 205156afeb54..0f9159dec47c 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -47,6 +47,7 @@ void idxd_unmask_error_interrupts(struct idxd_device *idxd)
 
 	genctrl.bits = ioread32(idxd->reg_base + IDXD_GENCTRL_OFFSET);
 	genctrl.softerr_int_en = 1;
+	genctrl.halt_int_en = 1;
 	iowrite32(genctrl.bits, idxd->reg_base + IDXD_GENCTRL_OFFSET);
 }
 
@@ -56,6 +57,7 @@ void idxd_mask_error_interrupts(struct idxd_device *idxd)
 
 	genctrl.bits = ioread32(idxd->reg_base + IDXD_GENCTRL_OFFSET);
 	genctrl.softerr_int_en = 0;
+	genctrl.halt_int_en = 0;
 	iowrite32(genctrl.bits, idxd->reg_base + IDXD_GENCTRL_OFFSET);
 }
 
@@ -304,6 +306,19 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq)
 	struct device *dev = &wq->idxd->pdev->dev;
 
 	devm_iounmap(dev, wq->portal);
+	wq->portal = NULL;
+}
+
+void idxd_wqs_unmap_portal(struct idxd_device *idxd)
+{
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		if (wq->portal)
+			idxd_wq_unmap_portal(wq);
+	}
 }
 
 int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index a9386a66ab72..18ddad0ec454 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -325,6 +325,7 @@ void idxd_cleanup_sysfs(struct idxd_device *idxd);
 int idxd_register_driver(void);
 void idxd_unregister_driver(void);
 struct bus_type *idxd_get_bus_type(struct idxd_device *idxd);
+void idxd_wqs_quiesce(struct idxd_device *idxd);
 
 /* device interrupt control */
 irqreturn_t idxd_irq_handler(int vec, void *data);
@@ -352,6 +353,7 @@ int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
 				   enum idxd_interrupt_type irq_type);
 
 /* work queue control */
+void idxd_wqs_unmap_portal(struct idxd_device *idxd);
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
 void idxd_wq_free_resources(struct idxd_wq *wq);
 int idxd_wq_enable(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 083facb301b8..eb884c9a3c6a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -532,7 +532,7 @@ static void idxd_flush_work_list(struct idxd_irq_entry *ie)
 	}
 }
 
-static void idxd_wqs_quiesce(struct idxd_device *idxd)
+void idxd_wqs_quiesce(struct idxd_device *idxd)
 {
 	struct idxd_wq *wq;
 	int i;
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index a60ca11a5784..5347dc4714dd 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -200,6 +200,8 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			queue_work(idxd->wq, &idxd->work);
 		} else {
 			spin_lock_bh(&idxd->dev_lock);
+			idxd_wqs_quiesce(idxd);
+			idxd_wqs_unmap_portal(idxd);
 			idxd_device_wqs_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,
 				"idxd halted, need %s.\n",
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 5cbf368c7367..6c11375cc56a 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -120,7 +120,8 @@ union gencfg_reg {
 union genctrl_reg {
 	struct {
 		u32 softerr_int_en:1;
-		u32 rsvd:31;
+		u32 halt_int_en:1;
+		u32 rsvd:30;
 	};
 	u32 bits;
 } __packed;


