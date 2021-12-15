Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334C9475E72
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbhLORTw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 12:19:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbhLORTv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 12:19:51 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639588790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dWZtEdF7LamMiNHDQtUJa+ux0BuM6MSUIqH9b+Hvyo=;
        b=wYhmWV2tAzCQfd9US7tK/sDWCnBbJEkh0toY9VDuwtDZ0a56PMo8BoccPtbLPELWo9I28H
        HKc2neisW5z7nVF58H33hQ6I3JpDjp7x8Kvp/cCgjUvnYD8QdYGH61A1BeXSEXOYr4fYH5
        DLBlYKQg7bDxik0O85eEeU6t0YgTJ460cdP5T6mA0DAEz4t2jvbnSoMRyHmCdRIsX+WU5+
        q/5iZYQod3bSNBGwjqvNjip+w8Kzgei0iFMPfqmZqeU25htKL5R6ykYiRwqQfnG6lFz+mQ
        r3FvWyI39vnZ4v4UgiVkKOdpkffYfcVyqNIiIF+3PGfZRf0ksOR9s1/A7ZSHGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639588790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dWZtEdF7LamMiNHDQtUJa+ux0BuM6MSUIqH9b+Hvyo=;
        b=lk+vW3OXeYaf8seyWIaOrmuYBvQZ09fZDnlpC9df3JMNaqJ74ZUxSByXPFwmhYxR0MLbL9
        iLeRWTRdVJiovHBA==
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
Subject: [patch V4 09-02/35] PCI/MSI: Allocate MSI device data on first use
In-Reply-To: <87tuf9rdoj.ffs@tglx>
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.740644351@linutronix.de> <87tuf9rdoj.ffs@tglx>
Date:   Wed, 15 Dec 2021 18:19:49 +0100
Message-ID: <87r1adrdje.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate MSI device data on first use, i.e. when a PCI driver invokes one
of the PCI/MSI enablement functions.

Add a wrapper function to ensure that the ordering vs. pcim_msi_release()
is correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Adopted to ensure devres ordering
---
 drivers/pci/msi/msi.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -366,6 +366,19 @@ static int pcim_setup_msi_release(struct
 	return ret;
 }
 
+/*
+ * Ordering vs. devres: msi device data has to be installed first so that
+ * pcim_msi_release() is invoked before it on device release.
+ */
+static int pci_setup_msi_context(struct pci_dev *dev)
+{
+	int ret = msi_setup_device_data(&dev->dev);
+
+	if (!ret)
+		ret = pcim_setup_msi_release(dev);
+	return ret;
+}
+
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -909,7 +922,7 @@ static int __pci_enable_msi_range(struct
 	if (nvec > maxvec)
 		nvec = maxvec;
 
-	rc = pcim_setup_msi_release(dev);
+	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
@@ -956,7 +969,7 @@ static int __pci_enable_msix_range(struc
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
-	rc = pcim_setup_msi_release(dev);
+	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
