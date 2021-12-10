Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C3A470D82
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbhLJWYH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:24:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344684AbhLJWW5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:57 -0500
Message-ID: <20211210221814.662401116@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=B95vILF4f96+HtIHGYc7a4tJjZ074d989NcBwfF9o/k=;
        b=fIOwaXb6T7YmYbzCNcuFWouRC2zGGXVRlsUgpqqFOIV0PyrJoOnT+aoyDMVKNK2A6krAZI
        XSQeEqbaRaAtK4VvrlqFro0SB1vhErnfxWhzQgwr+qsDk36wQ+eFWHO7jp23E3M3puDi35
        953o11ODU0TeOVEvTYbYoheZAqmksy26rdvmfI7PBx5P15pbca7UNafWBkDO+hECvHFdj9
        Yev9a5GN8EarusWwFqVi4o0AwKm0r+2eGINSSeQt7Q5FKkUK03tvPM0NomazmAYBA/cAga
        y3ObQUixyXi6+XAFUJSYrz1VSQAlbkSi94tipek580Cs/VN2H2S5HEWAnMSsvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=B95vILF4f96+HtIHGYc7a4tJjZ074d989NcBwfF9o/k=;
        b=Te6lNiwtavfKOApR2IhAxEwWLE9W8Bb3G/p8b6YTrFg+8nzwR06UFSXrmPjpS92tCkMg5/
        Nkw6+1agFZw6IeBg==
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
Subject: [patch V3 24/35] PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:20 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide a domain info flag which makes the core code check for a contiguous
MSI-X index on allocation. That's simpler than checking it at some other
domain callback in architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---
 drivers/pci/msi/irqdomain.c |   16 ++++++++++++++--
 include/linux/msi.h         |    2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -89,9 +89,21 @@ static int pci_msi_domain_check_cap(stru
 	if (pci_msi_desc_is_multi_msi(desc) &&
 	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
 		return 1;
-	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
-		return -ENOTSUPP;
 
+	if (desc->pci.msi_attrib.is_msix) {
+		if (!(info->flags & MSI_FLAG_PCI_MSIX))
+			return -ENOTSUPP;
+
+		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
+			unsigned int idx = 0;
+
+			/* Check for gaps in the entry indices */
+			for_each_msi_entry(desc, dev) {
+				if (desc->msi_index != idx++)
+					return -ENOTSUPP;
+			}
+		}
+	}
 	return 0;
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -361,6 +361,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
 	/* Populate sysfs on alloc() and destroy it on free() */
 	MSI_FLAG_DEV_SYSFS		= (1 << 7),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,

