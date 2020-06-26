Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFE920B7DC
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 20:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgFZSNB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 14:13:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:18953 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgFZSNB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 26 Jun 2020 14:13:01 -0400
IronPort-SDR: E2KWhEoFRYnZjwLKvmyq6xf1CbDKMosbzaC4UenZPnbVkkorg+8uegweO2+Yqly+4mE+fFdxTf
 qcOTZHInNPGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="144513621"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="144513621"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:12:57 -0700
IronPort-SDR: hAXmvbsfB4BgqQqVwwWgiw/nJqHrjna1mWWqSOZm/yzmAY1aSMJLWvwptswcMZBB4OXymKPFsa
 5hw1LBbq8dsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="311470526"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2020 11:12:56 -0700
Subject: [PATCH] dmaengine: idxd: move idxd interrupt handling to mask
 instead of ignore
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Ashok Raj <ashok.raj@intel.com>, dmaengine@vger.kernel.org
Date:   Fri, 26 Jun 2020 11:12:56 -0700
Message-ID: <159319517621.70410.11816465052708900506.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Switch driver to use MSIX mask and unmask instead of the ignore bit.
When ignore bit is cleared, we must issue an MMIO read to ensure writes
have all arrived and check and process any additional completions. The
ignore bit does not queue up any pending MSIX interrupts. The mask bit
however does. Use API call from interrupt subsystem to mask MSIX
interrupt since the hardware does not have convenient mask bit register.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   53 +++++++++------------------------------------
 drivers/dma/idxd/idxd.h   |    4 ++-
 drivers/dma/idxd/irq.c    |    2 --
 3 files changed, 13 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 1d8d64508a28..26e9a51de94e 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -6,6 +6,8 @@
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmaengine.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
 #include <uapi/linux/idxd.h>
 #include "../dmaengine.h"
 #include "idxd.h"
@@ -15,61 +17,28 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 			  u32 *status);
 
 /* Interrupt control bits */
-int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
+void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
 {
-	struct pci_dev *pdev = idxd->pdev;
-	int msixcnt = pci_msix_vec_count(pdev);
-	union msix_perm perm;
-	u32 offset;
-
-	if (vec_id < 0 || vec_id >= msixcnt)
-		return -EINVAL;
-
-	offset = idxd->msix_perm_offset + vec_id * 8;
-	perm.bits = ioread32(idxd->reg_base + offset);
-	perm.ignore = 1;
-	iowrite32(perm.bits, idxd->reg_base + offset);
+	struct irq_data *data = irq_get_irq_data(idxd->msix_entries[vec_id].vector);
 
-	return 0;
+	pci_msi_mask_irq(data);
 }
 
 void idxd_mask_msix_vectors(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
 	int msixcnt = pci_msix_vec_count(pdev);
-	int i, rc;
+	int i;
 
-	for (i = 0; i < msixcnt; i++) {
-		rc = idxd_mask_msix_vector(idxd, i);
-		if (rc < 0)
-			dev_warn(&pdev->dev,
-				 "Failed disabling msix vec %d\n", i);
-	}
+	for (i = 0; i < msixcnt; i++)
+		idxd_mask_msix_vector(idxd, i);
 }
 
-int idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id)
+void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id)
 {
-	struct pci_dev *pdev = idxd->pdev;
-	int msixcnt = pci_msix_vec_count(pdev);
-	union msix_perm perm;
-	u32 offset;
-
-	if (vec_id < 0 || vec_id >= msixcnt)
-		return -EINVAL;
-
-	offset = idxd->msix_perm_offset + vec_id * 8;
-	perm.bits = ioread32(idxd->reg_base + offset);
-	perm.ignore = 0;
-	iowrite32(perm.bits, idxd->reg_base + offset);
+	struct irq_data *data = irq_get_irq_data(idxd->msix_entries[vec_id].vector);
 
-	/*
-	 * A readback from the device ensures that any previously generated
-	 * completion record writes are visible to software based on PCI
-	 * ordering rules.
-	 */
-	perm.bits = ioread32(idxd->reg_base + offset);
-
-	return 0;
+	pci_msi_unmask_irq(data);
 }
 
 void idxd_unmask_error_interrupts(struct idxd_device *idxd)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 83214e902dd2..5f50bb830ca4 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -273,8 +273,8 @@ irqreturn_t idxd_wq_thread(int irq, void *data);
 void idxd_mask_error_interrupts(struct idxd_device *idxd);
 void idxd_unmask_error_interrupts(struct idxd_device *idxd);
 void idxd_mask_msix_vectors(struct idxd_device *idxd);
-int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
-int idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
+void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
+void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
 void idxd_device_init_reset(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 6052765ca3c8..f3c1d9ae8b56 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -260,8 +260,6 @@ irqreturn_t idxd_wq_thread(int irq, void *data)
 
 	processed = idxd_desc_process(irq_entry);
 	idxd_unmask_msix_vector(irq_entry->idxd, irq_entry->id);
-	/* catch anything unprocessed after unmasking */
-	processed += idxd_desc_process(irq_entry);
 
 	if (processed == 0)
 		return IRQ_NONE;

