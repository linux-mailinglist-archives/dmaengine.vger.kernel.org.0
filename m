Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701B6470D3B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbhLJWWv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344697AbhLJWWh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:37 -0500
Message-ID: <20211210221813.740644351@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lone/RHMXjlrVHw4SO3cyBPgNXO7SR/kjpngIvo8KXc=;
        b=pLlvWRgJJR/FozuPSZc/p3nSaSDVV9NbBY8rkEojQLKfzboZJPgEZ0QGJxryfOxb5vJXjW
        eBBPB65jIQk9+B1THMlYp0yGqF4rL2yHG62KFDRr14BUWKIF7M20mar760FwMkfrQzvRuP
        frt5N2PJ/xGqaTeQW8wTK+U8KkAFAKd4htcwQHlE2SrL5D3xqkdUSaNO3M42Mz14vtKiDQ
        1TvZXJXtRgeoEBKeHM0ubuCWIcCUGNAV2hTbvSlYDalKpRKK8q1fk2cI4lSaaA29ziMele
        UAn5OHfmJCIJKFGNS3y69IG1bpP8yT509O8M0KnFnRnGtN/0Sp9b4mWVngiMzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lone/RHMXjlrVHw4SO3cyBPgNXO7SR/kjpngIvo8KXc=;
        b=fGZcqe6WqEa09T04QnEG0wFvQt+EXzqvmqvVYXhxq4JPl8Xl8WUjUPXH0+2Own5rPSRrGs
        rNikqidmCczP5lBg==
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
Subject: [patch V3 09/35] PCI/MSI: Allocate MSI device data on first use
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:18:57 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allocate MSI device data on first use, i.e. when a PCI driver invokes one
of the PCI/MSI enablement functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/msi.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -900,10 +900,12 @@ static int __pci_enable_msi_range(struct
 /* deprecated, don't use */
 int pci_enable_msi(struct pci_dev *dev)
 {
-	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
-	if (rc < 0)
-		return rc;
-	return 0;
+	int rc = msi_setup_device_data(&dev->dev);
+
+	if (!rc)
+		rc = __pci_enable_msi_range(dev, 1, 1, NULL);
+
+	return rc < 0 ? rc : 0;
 }
 EXPORT_SYMBOL(pci_enable_msi);
 
@@ -958,7 +960,11 @@ static int __pci_enable_msix_range(struc
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
+	int ret = msi_setup_device_data(&dev->dev);
+
+	if (!ret)
+		ret = __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
+	return ret;
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
@@ -985,8 +991,12 @@ int pci_alloc_irq_vectors_affinity(struc
 				   struct irq_affinity *affd)
 {
 	struct irq_affinity msi_default_affd = {0};
+	int ret = msi_setup_device_data(&dev->dev);
 	int nvecs = -ENOSPC;
 
+	if (ret)
+		return ret;
+
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
 			affd = &msi_default_affd;

