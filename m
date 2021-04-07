Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD235754E
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 21:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349024AbhDGT6y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 15:58:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:44530 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhDGT6y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 15:58:54 -0400
IronPort-SDR: rBSR6tQALJ5bdTYZrYDrTYt7y9ZykHnbH6NhjXW+hR/9WGvYVOs2DInJXs7haoBA44reRHmKua
 kdLrM8tPwWxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="172860654"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="172860654"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:58:44 -0700
IronPort-SDR: wsch5dV7mJXYFVVLDG3c72xk982CQtVTudJNAqUgnQNNZwTyxvS3JfHQg22jAwsRFSWH8EuqU7
 TSqxHxR8CmEw==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="379954936"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:58:43 -0700
Subject: [PATCH] dmaengine: idxd: clear MSIX permission entry on shutdown
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 07 Apr 2021 12:58:42 -0700
Message-ID: <161782552272.107458.7071922172526550640.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/device.c |   30 ++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    2 ++
 drivers/dma/idxd/init.c   |   11 ++---------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index eb313e0e0e9b..ade57272d0e5 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -575,6 +575,36 @@ void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid)
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
index 21aa6e2017c8..4b5ec2a61a15 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -362,6 +362,8 @@ int idxd_register_driver(void);
 void idxd_unregister_driver(void);
 
 /* device interrupt control */
+void idxd_msix_perm_setup(struct idxd_device *idxd);
+void idxd_msix_perm_clear(struct idxd_device *idxd);
 irqreturn_t idxd_irq_handler(int vec, void *data);
 irqreturn_t idxd_misc_thread(int vec, void *data);
 irqreturn_t idxd_wq_thread(int irq, void *data);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 8c732d184a90..2e3295a055c1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -69,7 +69,6 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	struct idxd_irq_entry *irq_entry;
 	int i, msixcnt;
 	int rc = 0;
-	union msix_perm mperm;
 
 	msixcnt = pci_msix_vec_count(pdev);
 	if (msixcnt < 0) {
@@ -130,14 +129,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
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
 
  err_wq_irqs:
@@ -629,6 +621,7 @@ static void idxd_shutdown(struct pci_dev *pdev)
 	}
 
 	pci_free_irq_vectors(pdev);
+	idxd_msix_perm_clear(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);


