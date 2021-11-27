Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89BA45FB7F
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhK0Bxx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhK0Bvx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:51:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57313C07E5E4;
        Fri, 26 Nov 2021 17:25:42 -0800 (PST)
Message-ID: <20211126230525.197675096@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NeV9ZGHBl4mFlIql3fyxuMisNGkK+XSuThKmqvqjQGM=;
        b=hsuhEFrYb43Iubtxj3Grl7x3h4HHXSbkTJ7Wyjmct4XsaWaCG97Zt0ym/l1UbK1ZMjmvtR
        o7rKIXs8jRhoKgJrULGUGOND28kI6LTQumtOO5093BW37WCkJfqeGw3AouA+ST1BiiSLXS
        MocbcmU1wlMkyF6+nuwd74NW1yMtuuOLLtq3bBAyYsW1k8BNIQ5t2zWCAN/NobFwvJbsDQ
        YLKu4/dxcAiAaHh3tFIdbO1Vy3Wag+YXUm15xkA+USxGkWhd2rR/QOIVjoBDGWwC4UHQot
        fquLSoQkrLO6fcq+GmLU4aKK40umKr1K/fUHSRdATKc/pd96BnPEwWMrB7ZScw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NeV9ZGHBl4mFlIql3fyxuMisNGkK+XSuThKmqvqjQGM=;
        b=baZF/vP1BvWHNL96TVwdguIiQnAcN5ifaY2PRBojw6k9mwyGOID8bKdiNiKeK4v482Sn0q
        +rCZsYO0FauzSKCg==
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
Subject: [patch 21/37] x86/pci/XEN: Use device MSI properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:50 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

