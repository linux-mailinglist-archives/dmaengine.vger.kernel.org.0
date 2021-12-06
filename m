Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04F46ACC5
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358585AbhLFWoN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358621AbhLFWnG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:06 -0500
Message-ID: <20211206210438.967630948@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=d9Kmjjh/l2UsbXBaFOpNStl1Xv+nLaUCFqLfxPXo1aU=;
        b=I////PKLH9o1EDmwZHCLir1VYzr7pMRrvKfwrj6/sS1RC/sdwMyhGsRmFNUzSjZKOgIMpc
        VuDsl2yS6Ws4hfoyOmeknB/JxMlXVeaa0NqZ95AAgghhBhdjN4FlW0c1g+csVgtA3fWrV2
        0z0AJ2MhOcSyN1lh/bEWW2f4/Fnzp7391CjPfdN7QKcJV8re5bwovln9v5A9x5IVqN9dZu
        +KxgCyciGG6WjKS91laJQv0xqwFi/Vzr/5mDWBV7Szozjeo04YI0ztWH5F/WSflOvd1MN5
        Qh8s2JiJi8LtYXIr6WLsuyGc4NOos6lvsJnEJd/u4laPT49BgQpCcWza6iNv+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=d9Kmjjh/l2UsbXBaFOpNStl1Xv+nLaUCFqLfxPXo1aU=;
        b=ko5ujZLeGAKWmq36MQLxqwIEfx3oa0Eho33ca+wdmkjf4VHoT4ARnE0v9JtdIIR3XsdSb+
        xkZQTZQMwaNiZQCA==
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
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V2 24/36] powerpc/pseries/msi: Use MSI device properties
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:34 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/powerpc/platforms/pseries/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -447,9 +447,9 @@ static int rtas_prepare_msi_irqs(struct
 static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev,
 				   int nvec, msi_alloc_info_t *arg)
 {
+	bool is_msix = msi_device_has_property(dev, MSI_PROP_PCI_MSIX);
+	int type = is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-	int type = desc->pci.msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }

