Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF14F35CB40
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbhDLQYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 12:24:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:35393 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243483AbhDLQXr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 12:23:47 -0400
IronPort-SDR: HDG26slXhDUSD6Z/0vlTlSwPqEckr1YaB/u2kevZ5KsiMQUPmz7g0+JTbYbaMDqv+ZZOf0eUFE
 cFE7Y7X2gi3w==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255553596"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="255553596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 09:23:28 -0700
IronPort-SDR: Y7R/Kc2l0X1WdTXkzeM4NxxgqwIjqMisquMRle9f66kmggsjeMJcT6MGPgXSRZpC/TqSV+uJNH
 lokRUdXTC8Iw==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="460226548"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 09:23:27 -0700
Subject: [PATCH v2] dmaengine: idxd: clear MSIX permission entry on shutdown
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 12 Apr 2021 09:23:27 -0700
Message-ID: <161824457969.882533.6020239898682672311.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add disabling/clearing of MSIX permission entries on device shutdown to
mirror the enabling of the MSIX entries on probe. Current code left the
MSIX enabled and the pasid entries still programmed at device shutdown.

Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- Rebased against latest dmaegine/fixes

 drivers/dma/idxd/device.c |   30 ++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    2 ++
 drivers/dma/idxd/init.c   |   11 ++---------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 0375d9459e74..31c819544a22 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -580,6 +580,36 @@ void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid)
 }
 
 /* Device configuration bits */
+void idxd_msix_perm_setup(struct idxd_device *idxd)
+{
+	union msix_perm mperm;
+	int i, msixcnt;
+
+	msixcnt = pci_msix_vec_count(idxd->pdev);
+	if (msixcnt < 0)
+		return;
+
+	mperm.bits = 0;
+	mperm.pasid = idxd->pasid;
+	mperm.pasid_en = device_pasid_enabled(idxd);
+	for (i = 1; i < msixcnt; i++)
+		iowrite32(mperm.bits, idxd->reg_base + idxd->msix_perm_offset + i * 8);
+}
+
+void idxd_msix_perm_clear(struct idxd_device *idxd)
+{
+	union msix_perm mperm;
+	int i, msixcnt;
+
+	msixcnt = pci_msix_vec_count(idxd->pdev);
+	if (msixcnt < 0)
+		return;
+
+	mperm.bits = 0;
+	for (i = 1; i < msixcnt; i++)
+		iowrite32(mperm.bits, idxd->reg_base + idxd->msix_perm_offset + i * 8);
+}
+
 static void idxd_group_config_write(struct idxd_group *group)
 {
 	struct idxd_device *idxd = group->idxd;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 730745d331e3..76014c14f473 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -316,6 +316,8 @@ void idxd_unregister_driver(void);
 struct bus_type *idxd_get_bus_type(struct idxd_device *idxd);
 
 /* device interrupt control */
+void idxd_msix_perm_setup(struct idxd_device *idxd);
+void idxd_msix_perm_clear(struct idxd_device *idxd);
 irqreturn_t idxd_irq_handler(int vec, void *data);
 irqreturn_t idxd_misc_thread(int vec, void *data);
 irqreturn_t idxd_wq_thread(int irq, void *data);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 085a0c3b62c6..6584b0ec07d5 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -65,7 +65,6 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	struct idxd_irq_entry *irq_entry;
 	int i, msixcnt;
 	int rc = 0;
-	union msix_perm mperm;
 
 	msixcnt = pci_msix_vec_count(pdev);
 	if (msixcnt < 0) {
@@ -144,14 +143,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	}
 
 	idxd_unmask_error_interrupts(idxd);
-
-	/* Setup MSIX permission table */
-	mperm.bits = 0;
-	mperm.pasid = idxd->pasid;
-	mperm.pasid_en = device_pasid_enabled(idxd);
-	for (i = 1; i < msixcnt; i++)
-		iowrite32(mperm.bits, idxd->reg_base + idxd->msix_perm_offset + i * 8);
-
+	idxd_msix_perm_setup(idxd);
 	return 0;
 
  err_no_irq:
@@ -510,6 +502,7 @@ static void idxd_shutdown(struct pci_dev *pdev)
 		idxd_flush_work_list(irq_entry);
 	}
 
+	idxd_msix_perm_clear(idxd);
 	destroy_workqueue(idxd->wq);
 }
 


