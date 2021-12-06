Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2846AC76
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358007AbhLFWmf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:42:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357827AbhLFWmc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:42:32 -0500
Message-ID: <20211206210437.821900680@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0YY6FKU+qkJtNIjBHFuT3gGg88xsiW4iB6UKl0AmwtI=;
        b=gtLyx1uI4U5VlfG4MyQBVx6ekZVpiz/hJtSDGpgc8fcJ7gILFMYCCiR3EJjX0IZuhmYVAb
        BmqVgvOEI/y3Ed/3/UBUV5K5RTOB3ECpcaneiJcP0rxT9MeNN5rIyUEo1Pv3PtSgLgUYNU
        dnq47rZGpN2i2WVB6wI9J/C4sxH5DafOFwNhkSyVSLCKzFcjVLCFGVYCd9f3Fs7jeRn/uZ
        aVr2TQH5m9zO7I0AdAJWxXmpqPbrRxHd0TfUKtx3xuAHbr+qFO44ASkG7T7Sr3YEDi7Tfx
        kuTvLv6LTfhAjG2IhnSIRqieTkKEzepT2+1+TsS9Tt+jmrn09EVsc/uIx7spEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0YY6FKU+qkJtNIjBHFuT3gGg88xsiW4iB6UKl0AmwtI=;
        b=PDX2NcH6oMutIhm4blppHnJIu3p645PCE5S/fYPtzhtyjwQnto1muPhBbSVhrwl/rgluuU
        I6amPjh+RiNE+XDw==
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
Subject: [patch V2 03/36] PCI/MSI: Allocate MSI device data on first use
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:00 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate MSI device data on first use, i.e. when a PCI driver invokes one
of the PCI/MSI enablement functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

