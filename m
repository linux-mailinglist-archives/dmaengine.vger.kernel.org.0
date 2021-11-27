Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFA45FA00
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346943AbhK0B3O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:29:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347012AbhK0B1M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:27:12 -0500
Message-ID: <20211126230524.173951799@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KQEQh1eEOaSazo6Y93s5vbUnfdxHtVwCI6okaSxjU/U=;
        b=HaW+RKZ7US4Uu1k70IERdgewYgAMO/snn0yfQAQKJQDV4+qotinJnq7cCON8tEPAT7rdOB
        r70bHhrvTkbQmARtu72DrjfgKSBgj93XYilRpVJ0089gw260ZqWj0PiinAug3WaymX0MEE
        7sp5xkGEXGeP+gsxDW7PesVsFgMjZEw9q0NaYuwiDC1UFt6w9303srXzckGNXJqZGQoY5a
        PkfsnMrcCVDQMENutonhoy9fnwGZHuWYwB/emrBw7crNcLZlLAW8PEiqA1hYJWyx0W7hgz
        chYnaHaj57PvEU1llnXC1JG85C6WnKrW1waddqqyiuJ9onsjL6OGWwGEioK6Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KQEQh1eEOaSazo6Y93s5vbUnfdxHtVwCI6okaSxjU/U=;
        b=uvgZMbPuMeAAMoTatuwmExeWKcPlhOOIOhWbhLCB5AC9TFeOxtcdjgKAjMAphx/pwRm93S
        DArVVtnf9TF/OxAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 04/37] PCI/MSI: Use lock from msi_device_data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:23 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove the register lock from struct device and use the one in
struct msi_device_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/core.c    |    1 -
 drivers/pci/msi/msi.c  |    2 +-
 include/linux/device.h |    2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2875,7 +2875,6 @@ void device_initialize(struct device *de
 	device_pm_init(dev);
 	set_dev_node(dev, NUMA_NO_NODE);
 #ifdef CONFIG_GENERIC_MSI_IRQ
-	raw_spin_lock_init(&dev->msi_lock);
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -18,7 +18,7 @@ int pci_msi_ignore_mask;
 
 static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	raw_spinlock_t *lock = &desc->dev->msi_lock;
+	raw_spinlock_t *lock = &desc->dev->msi.data->lock;
 	unsigned long flags;
 
 	if (!desc->pci.msi_attrib.can_mask)
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -422,7 +422,6 @@ struct dev_msi_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
- * @msi_lock:	Lock to protect MSI mask cache and mask register
  * @msi_list:	Hosts MSI descriptors
  * @numa_node:	NUMA node this device is close to.
  * @dma_ops:    DMA mapping operations for this device.
@@ -520,7 +519,6 @@ struct device {
 #endif
 	struct dev_msi_info	msi;
 #ifdef CONFIG_GENERIC_MSI_IRQ
-	raw_spinlock_t		msi_lock;
 	struct list_head	msi_list;
 #endif
 #ifdef CONFIG_DMA_OPS

