Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE81470D85
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbhLJWYN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:24:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50696 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344792AbhLJWW4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:56 -0500
Message-ID: <20211210221814.602911509@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b+8XtuxyybZ0KA3VgHyfihDMNTV0zUMbTk9/Irfc6hY=;
        b=gtlARjzibFYuz9U6kOioIdZU3H2gGpSp0kPlWLZ+kd24cAed+DeClKuntlG4JsCk8zY07y
        q4OBakPfcKBb37uTsVpdl+kZVXjGOM+WiX4QdL4/u+lA1Y9y4dKrhkgw6Uh/7GO9oYoIeQ
        hBP/MraULd3ZVo1Z1K+epp4dalnjedctH041vEGdy4nfhXCKfiR+ROymaThUnkMKuz3NNm
        +JxVPoN3XjujZ5ewmGt2GsfcPEocK7u3J2vLaJA/0r9VgzNM5Jdeq19scuH1VS8ZuEjJ+m
        oWuWlGsHLJmOx4SsTtznS8VRLvxx0mMiiyfP6T1q4JfNvKbl2zPiXclTsVXprA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b+8XtuxyybZ0KA3VgHyfihDMNTV0zUMbTk9/Irfc6hY=;
        b=KjbXc7grgijN+0eh8P50UqVENbOnRsxgSHL8UOCByDa/XkHCvECRNHYwFOKg0KvZdAMfCs
        a3nFb07yNOEsfEDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V3 23/35] PCI/MSI: Use msi_desc::msi_index
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:18 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The usage of msi_desc::pci::entry_nr is confusing at best. It's the index
into the MSI[X] descriptor table.

Use msi_desc::msi_index which is shared between all MSI incarnations
instead of having a PCI specific storage for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---
 arch/powerpc/platforms/pseries/msi.c |    4 ++--
 arch/x86/pci/xen.c                   |    2 +-
 drivers/pci/msi/irqdomain.c          |    2 +-
 drivers/pci/msi/msi.c                |   20 ++++++++------------
 drivers/pci/xen-pcifront.c           |    2 +-
 include/linux/msi.h                  |    2 --
 6 files changed, 13 insertions(+), 19 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -332,7 +332,7 @@ static int check_msix_entries(struct pci
 
 	expected = 0;
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->pci.msi_attrib.entry_nr != expected) {
+		if (entry->msi_index != expected) {
 			pr_debug("rtas_msi: bad MSI-X entries.\n");
 			return -EINVAL;
 		}
@@ -579,7 +579,7 @@ static int pseries_irq_domain_alloc(stru
 	int hwirq;
 	int i, ret;
 
-	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->pci.msi_attrib.entry_nr);
+	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_index);
 	if (hwirq < 0) {
 		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
 		return hwirq;
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -306,7 +306,7 @@ static int xen_initdom_setup_msi_irqs(st
 				return -EINVAL;
 
 			map_irq.table_base = pci_resource_start(dev, bir);
-			map_irq.entry_nr = msidesc->pci.msi_attrib.entry_nr;
+			map_irq.entry_nr = msidesc->msi_index;
 		}
 
 		ret = -EINVAL;
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -57,7 +57,7 @@ static irq_hw_number_t pci_msi_domain_ca
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
 
-	return (irq_hw_number_t)desc->pci.msi_attrib.entry_nr |
+	return (irq_hw_number_t)desc->msi_index |
 		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -44,7 +44,7 @@ static inline void pci_msi_unmask(struct
 
 static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
-	return desc->pci.mask_base + desc->pci.msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
 }
 
 /*
@@ -356,13 +356,10 @@ msi_setup_entry(struct pci_dev *dev, int
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
 
-	entry->pci.msi_attrib.is_msix	= 0;
-	entry->pci.msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->pci.msi_attrib.is_virtual    = 0;
-	entry->pci.msi_attrib.entry_nr	= 0;
+	entry->pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
 	entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
 					  !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->pci.msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
+	entry->pci.msi_attrib.default_irq = dev->irq;
 	entry->pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 
@@ -504,12 +501,11 @@ static int msix_setup_entries(struct pci
 		entry->pci.msi_attrib.is_64	= 1;
 
 		if (entries)
-			entry->pci.msi_attrib.entry_nr = entries[i].entry;
+			entry->msi_index = entries[i].entry;
 		else
-			entry->pci.msi_attrib.entry_nr = i;
+			entry->msi_index = i;
 
-		entry->pci.msi_attrib.is_virtual =
-			entry->pci.msi_attrib.entry_nr >= vec_count;
+		entry->pci.msi_attrib.is_virtual = entry->msi_index >= vec_count;
 
 		entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
 						  !entry->pci.msi_attrib.is_virtual;
@@ -1045,7 +1041,7 @@ int pci_irq_vector(struct pci_dev *dev,
 		struct msi_desc *entry;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (entry->pci.msi_attrib.entry_nr == nr)
+			if (entry->msi_index == nr)
 				return entry->irq;
 		}
 		WARN_ON_ONCE(1);
@@ -1084,7 +1080,7 @@ const struct cpumask *pci_irq_get_affini
 		struct msi_desc *entry;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (entry->pci.msi_attrib.entry_nr == nr)
+			if (entry->msi_index == nr)
 				return &entry->affinity->mask;
 		}
 		WARN_ON_ONCE(1);
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -263,7 +263,7 @@ static int pci_frontend_enable_msix(stru
 
 	i = 0;
 	for_each_pci_msi_entry(entry, dev) {
-		op.msix_entries[i].entry = entry->pci.msi_attrib.entry_nr;
+		op.msix_entries[i].entry = entry->msi_index;
 		/* Vector is useless at this point. */
 		op.msix_entries[i].vector = -1;
 		i++;
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -80,7 +80,6 @@ typedef void (*irq_write_msi_msg_t)(stru
  * @multi_cap:	[PCI MSI/X] log2 num of messages supported
  * @can_mask:	[PCI MSI/X] Masking supported?
  * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
- * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
  * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
@@ -97,7 +96,6 @@ struct pci_msi_desc {
 		u8	can_mask	: 1;
 		u8	is_64		: 1;
 		u8	is_virtual	: 1;
-		u16	entry_nr;
 		unsigned default_irq;
 	} msi_attrib;
 	union {

