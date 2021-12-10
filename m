Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508FE470D1C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbhLJWWq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbhLJWW3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62527C061746;
        Fri, 10 Dec 2021 14:18:51 -0800 (PST)
Message-ID: <20211210221813.434156196@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VrU+cUwVNt/tRlW4lw+bzWjrRhpWxr0n5kAnta20rq4=;
        b=pE4rQ2ru1rC+MOxwgCFck9hIsKI0LjZICNGNwEw8ze9/meweY1qANt4dgwIHKfQOPC1beg
        yPBns7caG7PjSlQkEoMvTCi/DDid/5ijo+pcU/3ZLIE1LS+qQRJIeuxZj2Mi/GYsUgFxDG
        UfE4buF12pfMJCkH4E7kXOGXF3Tdxoadhmimlb4Oqaa6At4sxsqGTcRd4XwvSUVolW7xT/
        BZ6l4WzdOdHBFzRU8fuHCGeKVTvU3fpMB68bg/XbArySIyUaHyjLg/eiywsouAZhDcRfnk
        7ETqReSwtzm9CpcynGCRQWFvda5xRxitOgtngCsHnX2u5kMmZ6hOfaZO1ylegg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VrU+cUwVNt/tRlW4lw+bzWjrRhpWxr0n5kAnta20rq4=;
        b=4a4+C7WhuYdeuyTtWKdNyTdvLDhhfziSubOZ+5mUXlzgk+OuqIM6rjcLPfL3/GtWFOnIFc
        gcXKQZiyuUQutAAA==
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
Subject: [patch V3 04/35] genirq/msi: Use PCI device property
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:18:49 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

to determine whether this is MSI or MSIX instead of consulting MSI
descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Use PCI device property - Jason
---
 kernel/irq/msi.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -77,21 +77,8 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct msi_desc *entry;
-	bool is_msix = false;
-	unsigned long irq;
-	int retval;
-
-	retval = kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry = irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	if (dev_is_pci(dev))
-		is_msix = entry->pci.msi_attrib.is_msix;
+	/* MSI vs. MSIX is per device not per interrupt */
+	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
 
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }

