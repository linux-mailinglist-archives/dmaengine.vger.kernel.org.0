Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F8470D12
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbhLJWWm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344684AbhLJWWZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:25 -0500
Message-ID: <20211210221813.372357371@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jxff/xJv3Qst4ZB5tRChjTLXCWZK8WA2PIPQRiU/rvY=;
        b=0nUrI//widUx8A75bvq7IZvZU0OgOd7DLmm1Zp2ltSlJUJ9r/TrE9oF6ObjsG/CcBOkiYi
        qXw9+h4dQG4uyEMuyKeiBlxL4kElXM0TpMwsf3wmE81Z2stJW+ptloJgs/g6qP6M8dR2QU
        njRyGX3+6rX5xnHULZR7tzFqLrE14gpMsFum/pVWgPlIZ+TpaG54gue+YwCmJ2mvy52BBv
        eJfY6AUb8aIr3HCk56T6i2B/ksAdJHhdmvylSbmQ1UvjRhp/j3IltXf1nTsUbtPgTPyfJ7
        dTv1xOVMJ9eZrRTBBhQoxRXkLcJLQxyY0zHx9KeMYtAVYinBZUzQopdXWot8gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jxff/xJv3Qst4ZB5tRChjTLXCWZK8WA2PIPQRiU/rvY=;
        b=vv6Me8N9GQvFvm+KtHhMWgm41j6C3fva9jay/jD8ClFpKD7/3pJq+KAqrq6JZCZO9BTGwf
        CoMF7Kja5mNu2oDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
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
Subject: [patch V3 03/35] x86/apic/msi: Use PCI device MSI property
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:18:47 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Use pci_dev->msix_enabled - Jason
---
 arch/x86/kernel/apic/msi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -160,11 +160,8 @@ static struct irq_chip pci_msi_controlle
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-
 	init_irq_alloc_info(arg, NULL);
-	if (desc->pci.msi_attrib.is_msix) {
+	if (to_pci_dev(dev)->msix_enabled) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;

