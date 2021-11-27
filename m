Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CDE45F976
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhK0B1G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:27:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344825AbhK0BZE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:25:04 -0500
Message-ID: <20211126230525.137299282@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZWaHMo5/cxTSb8aCm3CN77ES3jPYHd9BeCyQKbhAf1Q=;
        b=UggVVv3f7QCjME5pjLx9J0hsxvfwEK88RAs5+In+TDQQ49/kKJE/4UBeSm9ZmjOA3ObLqP
        RsQuoCiENoW9YWD6uVKBIaFEfiXZtiUA08HDqEG1GpZjdIXrtx2v7bjgs5y6sTpxr2DQVA
        /dKkq3qcWWn1VZjG9liURMDeIHNbl/xUG3O/brsKYly5bzbVoe+4DfLAT2w+cOXQs188b9
        U3cNtwx6+wWxxHiA4/bh4AnrsFJmkU3lZlUxoJ+pijTSavjP+DhwwYBqOLB/XscIqzEUw0
        Ovy3cNm8ATuXUVs96hhg2BgomxXlWEh+swP3glYt48WR6vFYpyUno12lQdyhAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZWaHMo5/cxTSb8aCm3CN77ES3jPYHd9BeCyQKbhAf1Q=;
        b=KjHrEnrG0fpDzTmWoCzq7Si7jPR+/lr5hq4rxoNYcQ2Ul/fX9e3zQDEhrh98Csz5sTQmgO
        gbeMniPwqgDOT0Dg==
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
Subject: [patch 20/37] PCI/MSI: Store properties in device::msi::data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:39 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Store the properties which are interesting for various places so the MSI
descriptor fiddling can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -244,6 +244,8 @@ static void free_msi_irqs(struct pci_dev
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;
 	}
+
+	dev->dev.msi.data->properties = 0;
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -372,6 +374,9 @@ msi_setup_entry(struct pci_dev *dev, int
 	if (entry->pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
 
+	dev->dev.msi.data->properties = MSI_PROP_PCI_MSI;
+	if (entry->pci.msi_attrib.is_64)
+		dev->dev.msi.data->properties |= MSI_PROP_64BIT;
 out:
 	kfree(masks);
 	return entry;
@@ -514,6 +519,7 @@ static int msix_setup_entries(struct pci
 		if (masks)
 			curmsk++;
 	}
+	dev->dev.msi.data->properties = MSI_PROP_PCI_MSIX | MSI_PROP_64BIT;
 	ret = 0;
 out:
 	kfree(masks);

