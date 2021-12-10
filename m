Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48108470D3E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbhLJWWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbhLJWWh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:37 -0500
Message-ID: <20211210221813.867985931@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Y82OSyHV4tCeBzBC1rgQ8/N8FaTKISWwv/0ho8RVhuc=;
        b=2lSBrqL7tZdnQovckLcRFs+zUPITNEnJXtT+2t/rF3/6USo+oM3rVzWI5tmzBuF8v+fTql
        Y/WOe+crXeCISzmidHrjHzy1/dM/bLhEGF6X78s2KO5zgtoADPazF6hbJHmZc83RIDEZ+U
        S3NcKAlmaR7iXrlw0Wyt7MQ+5GzK/qAHQuSapmDPvqVfsc0Ygv0gok/KxyDWalxpEjwiij
        lOyBs1cQWG/UTyGJS+ODHvhGY9UGVMnlFBi1jRxRIBXX9aHbQyi5XmvGDAjr3NZ0MZ2nHe
        FZdyKYem/VTlhxHFL6icdY/Lr7wgeJS28HmRZY5DnE4kXSdKV/5/4F5fOjnGqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Y82OSyHV4tCeBzBC1rgQ8/N8FaTKISWwv/0ho8RVhuc=;
        b=AmDRzUTHc7jg0q3On78/vfF7TTqillkRcjofWpZD4PcjdOpOL/P4qxmwngleQjhYBtmCNP
        dxdvwJMQPD35dMCw==
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
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [patch V3 11/35] bus: fsl-mc-msi: Allocate MSI device data on first use
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:00 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allocate the MSI device data on first invocation of the allocation function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -253,6 +253,14 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	struct irq_domain *msi_domain;
 	int error;
 
+	msi_domain = dev_get_msi_domain(dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	error = msi_setup_device_data(dev);
+	if (error)
+		return error;
+
 	if (!list_empty(dev_to_msi_list(dev)))
 		return -EINVAL;
 
@@ -260,12 +268,6 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	if (error < 0)
 		return error;
 
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain) {
-		error = -EINVAL;
-		goto cleanup_msi_descs;
-	}
-
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback

