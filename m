Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0186045F9C2
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbhK0B2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbhK0B0I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:08 -0500
Message-ID: <20211126230525.491832071@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iaLCpiERLpuGITLjESnXqZksSqXjgw+jF1i/FwPrQ3E=;
        b=kcYlvqdpt98wpVF7Qtbik8L8AOo4OCpitlj1WpYPqo+Y9mz1x78EEZ7He5pgLtuIigvALI
        1dcsghFKKbeeT47ziXOMVbVmaZLeN9gxU/gLWyLmtASdizLv2Vf78BctOMNAcw34ZDaqnh
        jmRNIzKC2YJqCujCBWAfzByFHacrIt1LGoOuUf7nvj6OJ0w7PyF0+3oEpfin8Fl9Xa6SHV
        dFrc/ZZehVhKNVpTk0XwhxCb/eniIRQ0MiRQ360AATCENk+dCdG9gEUdJqegeVSPISnY0G
        POzb0yLiNCnw68Rs+ZdweMmS3jxNp9s/h0lDFU4ZlXkx9kl+FGiEHnZwcGoM8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iaLCpiERLpuGITLjESnXqZksSqXjgw+jF1i/FwPrQ3E=;
        b=CrtKgt88PsrcMd/EsUX+7UmHHwT9hagSD+g8Cz/HvkmLqq7Na4BfCjXff36gzHt+V+48cV
        uGMotbLDIzOQRSDw==
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
Subject: [patch 26/37] PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:48 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Provide a domain info flag which makes the core code check for a contiguous
MSI-X index on allocation. That's simpler than checking it at some other
domain callback in architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -378,6 +378,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
 	/* Populate sysfs on alloc() and destroy it on free() */
 	MSI_FLAG_DEV_SYSFS		= (1 << 7),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,

