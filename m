Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD73445F9FC
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbhK0B3N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:29:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbhK0B1L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:27:11 -0500
Message-ID: <20211126230524.112845775@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PN3ExRN1k42hfHq1uj98iHzkfSIuhUpOYD8o8PLDemE=;
        b=CP7AHsOeiCofaClIDYfrrlr4ZTfikHYL6L+ePsfOVaLzvytVt8rxY5MS2fPxkXF0pCPMSg
        BnYJd1fFxGCEvG6PkcG0aaC/fFYhs2iDYr85FcfFnW8XtwWWEERMEXzDiBETVkF5AZ/U16
        3JVuF9tMf0N4ygmYCI2PA1ziqVEG6BzwXOYPkHIQuZSHwFxnwhVgL1RmeMnS4FT+Pe5XXU
        zaI0cY/XgwfdI5/QOvFWZctgE+QQxxMB6QQ0b5xbpqwpYQyf5V88D826ehqDVfoPAZOMm9
        Oz2XWg7JmLe9HitCjTM7NdSqn03HqCSv02KSGxQ5w3MtFO0vccWWmdMKJepS7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PN3ExRN1k42hfHq1uj98iHzkfSIuhUpOYD8o8PLDemE=;
        b=MYTkd4TwNrAcWOX8VX/1sMslLnKJgzGhqYjt4CXqo1X6rPga6taXu0j+zxWW/MnHG6jTAA
        P7EBHuieujIYm2Ag==
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
Subject: [patch 03/37] PCI/MSI: Allocate MSI device data on first use
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:22 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate MSI device data on first use, i.e. when a PCI driver invokes one
of the PCI/MSI enablement functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -889,10 +889,12 @@ static int __pci_enable_msi_range(struct
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
 
@@ -947,7 +949,11 @@ static int __pci_enable_msix_range(struc
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
 
@@ -974,8 +980,12 @@ int pci_alloc_irq_vectors_affinity(struc
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

