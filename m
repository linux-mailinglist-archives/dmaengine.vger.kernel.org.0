Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1019846ACB2
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376387AbhLFWn6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358810AbhLFWnA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A67C061D60;
        Mon,  6 Dec 2021 14:39:20 -0800 (PST)
Message-ID: <20211206210438.419160862@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6EMMNpvyXK75OtHIkqDafkCPKjNT6UjlrUiD6k/V/Kc=;
        b=0z7xCFi/09vRAK0bIazveOxr26GEWEhb+vcWJ0gZbQWEK9Ut/y/r+UU+n0jUtmeUItwok2
        8FGGX6iEwPWPmXC7rY85oXM/8XjhvYhQBAU6xhDN+C37borrNOsEF/j7UqnXLTFNeUNTkt
        wyXImnXaXo+0rFOvuURNfN7ZrCjN8kQgxK22dXadc61KJppUMDy/vuERX2stUTH5IjcgIY
        CzU1zkIlt6lry0dLrmsxP7YvsBZpF36Mc12I5C8ZBcy7YVV2297T1073OywWAyXuFM/6ai
        gp5HPFQAv6ZxL3YvA54sazPuaneFlKhqRxiEyprKK+dRLFS/Hssu2vV315XiOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6EMMNpvyXK75OtHIkqDafkCPKjNT6UjlrUiD6k/V/Kc=;
        b=TGcSLRy94hDV8xdvp8TAIgWTSEQtpXZHPDCy7tgDaxex0jesp8aPKSls8gX7M0+StNJMfG
        II3wNxwVIbxub4Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V2 14/36] platform-msi: Use msi_desc::msi_index
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:18 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Cc: dmaengine@vger.kernel.org
---
 drivers/base/platform-msi.c                 |   10 +++++-----
 drivers/dma/qcom/hidma.c                    |    4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    4 ++--
 drivers/mailbox/bcm-flexrm-mailbox.c        |    4 ++--
 include/linux/msi.h                         |   10 ----------
 5 files changed, 11 insertions(+), 21 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -40,7 +40,7 @@ static irq_hw_number_t platform_msi_calc
 {
 	u32 devid = desc->dev->msi.data->platform_data->devid;
 
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
+	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
 }
 
 static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
@@ -112,8 +112,8 @@ static void platform_msi_free_descs(stru
 	struct msi_desc *desc, *tmp;
 
 	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		if (desc->platform.msi_index >= base &&
-		    desc->platform.msi_index < (base + nvec)) {
+		if (desc->msi_index >= base &&
+		    desc->msi_index < (base + nvec)) {
 			list_del(&desc->list);
 			free_msi_entry(desc);
 		}
@@ -129,7 +129,7 @@ static int platform_msi_alloc_descs_with
 	if (!list_empty(dev_to_msi_list(dev))) {
 		desc = list_last_entry(dev_to_msi_list(dev),
 				       struct msi_desc, list);
-		base = desc->platform.msi_index + 1;
+		base = desc->msi_index + 1;
 	}
 
 	for (i = 0; i < nvec; i++) {
@@ -137,7 +137,7 @@ static int platform_msi_alloc_descs_with
 		if (!desc)
 			break;
 
-		desc->platform.msi_index = base + i;
+		desc->msi_index = base + i;
 		desc->irq = virq ? virq + i : 0;
 
 		list_add_tail(&desc->list, dev_to_msi_list(dev));
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -666,7 +666,7 @@ static void hidma_write_msi_msg(struct m
 	struct device *dev = msi_desc_to_dev(desc);
 	struct hidma_dev *dmadev = dev_get_drvdata(dev);
 
-	if (!desc->platform.msi_index) {
+	if (!desc->msi_index) {
 		writel(msg->address_lo, dmadev->dev_evca + 0x118);
 		writel(msg->address_hi, dmadev->dev_evca + 0x11C);
 		writel(msg->data, dmadev->dev_evca + 0x120);
@@ -702,7 +702,7 @@ static int hidma_request_msi(struct hidm
 		return rc;
 
 	for_each_msi_entry(desc, &pdev->dev) {
-		if (!desc->platform.msi_index)
+		if (!desc->msi_index)
 			dmadev->msi_virqbase = desc->irq;
 
 		rc = devm_request_irq(&pdev->dev, desc->irq,
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3142,7 +3142,7 @@ static void arm_smmu_write_msi_msg(struc
 	phys_addr_t doorbell;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
-	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
+	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
@@ -3183,7 +3183,7 @@ static void arm_smmu_setup_msis(struct a
 	}
 
 	for_each_msi_entry(desc, dev) {
-		switch (desc->platform.msi_index) {
+		switch (desc->msi_index) {
 		case EVTQ_MSI_INDEX:
 			smmu->evtq.q.irq = desc->irq;
 			break;
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1484,7 +1484,7 @@ static void flexrm_mbox_msi_write(struct
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct flexrm_mbox *mbox = dev_get_drvdata(dev);
-	struct flexrm_ring *ring = &mbox->rings[desc->platform.msi_index];
+	struct flexrm_ring *ring = &mbox->rings[desc->msi_index];
 
 	/* Configure per-Ring MSI registers */
 	writel_relaxed(msg->address_lo, ring->regs + RING_MSI_ADDR_LS);
@@ -1609,7 +1609,7 @@ static int flexrm_mbox_probe(struct plat
 
 	/* Save alloced IRQ numbers for each ring */
 	for_each_msi_entry(desc, dev) {
-		ring = &mbox->rings[desc->platform.msi_index];
+		ring = &mbox->rings[desc->msi_index];
 		ring->irq = desc->irq;
 	}
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -106,14 +106,6 @@ struct pci_msi_desc {
 };
 
 /**
- * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor for multi MSI
- */
-struct platform_msi_desc {
-	u16				msi_index;
-};
-
-/**
  * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
  * @msi_index:		The index of the MSI descriptor
  */
@@ -144,7 +136,6 @@ struct ti_sci_inta_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
@@ -166,7 +157,6 @@ struct msi_desc {
 	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
-		struct platform_msi_desc	platform;
 		struct fsl_mc_msi_desc		fsl_mc;
 		struct ti_sci_inta_msi_desc	inta;
 	};

