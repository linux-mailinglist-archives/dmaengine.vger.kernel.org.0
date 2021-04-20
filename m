Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25DA365FB1
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 20:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhDTSrY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 14:47:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:11525 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhDTSrY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:24 -0400
IronPort-SDR: 3JoIEazp7ASIOP91FUSuS8vJb1MYES7qmDBbt/pMfCpOcs/GbipzOPDPzLSwLApNmMUWAdtqqO
 4asoZIPcm7nw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175672931"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="175672931"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:52 -0700
IronPort-SDR: rUqPNEafHW4I6kHfBvfG7faeN2Q6gNhslXeAoUnsWeQxElBFSx/S0TXDgmWlPXOqwOWiSUnVJm
 /CjcrsEmbjpA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="384173250"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:52 -0700
Subject: [PATCH 6/6] dmaengine: idxd: support reporting of halt interrupt
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:46:51 -0700
Message-ID: <161894441167.3202472.9485946398140619501.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
References: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/init.c      |   12 ++++++++++++
 drivers/dma/idxd/irq.c       |    2 ++
 drivers/dma/idxd/registers.h |    3 ++-
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 54d5afec81cf..3934e660d951 100644
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
 
@@ -312,6 +314,19 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq)
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
+		struct idxd_wq *wq = idxd->wqs[i];
+
+		if (wq->portal)
+			idxd_wq_unmap_portal(wq);
+	}
 }
 
 int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c1d4a1976206..d7185c6bfade 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -371,6 +371,7 @@ int idxd_register_devices(struct idxd_device *idxd);
 void idxd_unregister_devices(struct idxd_device *idxd);
 int idxd_register_driver(void);
 void idxd_unregister_driver(void);
+void idxd_wqs_quiesce(struct idxd_device *idxd);
 
 /* device interrupt control */
 void idxd_msix_perm_setup(struct idxd_device *idxd);
@@ -400,6 +401,7 @@ int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
 				   enum idxd_interrupt_type irq_type);
 
 /* work queue control */
+void idxd_wqs_unmap_portal(struct idxd_device *idxd);
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
 void idxd_wq_free_resources(struct idxd_wq *wq);
 int idxd_wq_enable(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index eb0b3a00a2d7..e6bfd55e421b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -647,6 +647,18 @@ static void idxd_flush_work_list(struct idxd_irq_entry *ie)
 	}
 }
 
+void idxd_wqs_quiesce(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		if (wq->state == IDXD_WQ_ENABLED && wq->type == IDXD_WQT_KERNEL)
+			idxd_wq_quiesce(wq);
+	}
+}
+
 static void idxd_release_int_handles(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index fc0781e3f36d..43eea5c9cbd4 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -202,6 +202,8 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
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


