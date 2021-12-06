Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DE46ACAB
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358919AbhLFWnz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358948AbhLFWnD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1829EC0698CA;
        Mon,  6 Dec 2021 14:39:30 -0800 (PST)
Message-ID: <20211206210438.742297272@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W2lCRcP9RIug8p7Jz6C0/K2R924e9P+4OVHLDtbDEY4=;
        b=NAItHuLmL2ZcCfnzc7fXrckrfGRBHJLTQ6z+8GQi+pDtw3TJzWlrZdzM68dhy4eE1OUrN4
        WQpDNI30CiepjXFq3GVRqOgL6lbHugqbiK1cgKeYZQQlmp0QNv6K3/G1f9qICr1H7udj02
        IL3YCTHnXu0Nc9n7X5/vnjZpUzoBt0BVJmug9p6XoFHASymZZCX8NBeLxW7a+KomP2zscN
        Yw4oyjCuV9LJAUYax/vCmkxmlobmILYr9Kaz4DUGkfdOhTY2fy7moleVn4aZ55FimhJjry
        KhYtaopElknezT4DQ1+BGYb8QpKLSmpd8RvSeJ/uyfPSLa3v/+iGr3ib39VvMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W2lCRcP9RIug8p7Jz6C0/K2R924e9P+4OVHLDtbDEY4=;
        b=1Bo7ypMWpOuT+BmW7TSVzw6bj18E4LKNZBSZWEJqZFWNgSmXB22SiYHDMtnKsfQTyHA/Yy
        OLurUGAL5gX1tZAQ==
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
Subject: [patch V2 20/36] x86/pci/XEN: Use device MSI properties
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:28 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/x86/pci/xen.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -399,9 +399,7 @@ static void xen_teardown_msi_irqs(struct
 
 static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
 {
-	struct msi_desc *msidesc = first_pci_msi_entry(dev);
-
-	if (msidesc->pci.msi_attrib.is_msix)
+	if (msi_device_has_property(&dev->dev, MSI_PROP_PCI_MSIX))
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
@@ -417,7 +415,7 @@ static int xen_msi_domain_alloc_irqs(str
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return -EINVAL;
 
-	if (first_msi_entry(dev)->pci.msi_attrib.is_msix)
+	if (msi_device_has_property(dev, MSI_PROP_PCI_MSIX))
 		type = PCI_CAP_ID_MSIX;
 	else
 		type = PCI_CAP_ID_MSI;

