Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71B4A513A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357985AbiAaVQo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 16:16:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiAaVQn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 16:16:43 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643663802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tU8NK9NTEirj5O/+bd9d0PukMKUVqECyFzPD3aLKDXk=;
        b=KmPtM4XylI1QpBV825qhL/YVm9F73QsW9H0dQ5UPcPGil3mXgUuoX3HprH/+a3ZG/ShNJr
        BjlGsc1ndAOmgHyQvIvZUOUD6HLDHOBCi/Ji6X9uEEf7jDK1BzH1apOdzDHBzBMfjkAtXZ
        8BD8lWMmiKDXbdlCTK3THWqdS9xoq1KFr2G35OtVX67EMI6vGc6c9cosnIZIpe5sYh+au2
        PL1LZWmdvONdEfE18CsyjWjHM6gOUgcS0xyBIooTsaH48TF002qdkFf00iF1dJ2JVj/0SI
        eh6W7ozcJJE4CPYA3I/LgUWnchhhUB5lvUTPvZV1OWQ8MM0o/wu35qDKV5db6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643663802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tU8NK9NTEirj5O/+bd9d0PukMKUVqECyFzPD3aLKDXk=;
        b=+0otG72AhE6uKJBBtoOAEgmDIjBRXfGv02FMllL7V8PEVFVne4ebGZPaDcAGYon+0st4ER
        /th5pds4YqGCrMCA==
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        iommu@lists.linux-foundation.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cedric Le Goater <clg@kaod.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Megha Dey <megha.dey@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Tero Kristo <kristo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Marc Zygnier <maz@kernel.org>,
        dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <c78df469-1a9f-5778-24d1-8f08a6bf5bcc@roeck-us.net>
References: <87mtjc2lhe.ffs@tglx>
 <c78df469-1a9f-5778-24d1-8f08a6bf5bcc@roeck-us.net>
Date:   Mon, 31 Jan 2022 22:16:41 +0100
Message-ID: <87ee4n38sm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Guenter,

On Mon, Jan 31 2022 at 07:21, Guenter Roeck wrote:
> Sure. Please see http://server.roeck-us.net/qemu/x86/.
> The logs are generated with with v5.16.4.

thanks for providing the data. It definitely helped me to leave the
state of not seeing the wood for the trees. Fix below.

Thanks,

        tglx
---
Subject: PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 31 Jan 2022 22:02:46 +0100

The recent overhaul of pci_irq_get_affinity() introduced a regression when
pci_irq_get_affinity() is called for an MSI-X interrupt which was not
allocated with affinity descriptor information.

The original code just returned a NULL pointer in that case, but the rework
added a WARN_ON() under the assumption that the corresponding WARN_ON() in
the MSI case can be applied to MSI-X as well.

In fact the MSI warning in the original code does not make sense either
because it's legitimate to invoke pci_irq_get_affinity() for a MSI
interrupt which was not allocated with affinity descriptor information.

Remove it and just return NULL as the original code did.

Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1111,7 +1111,8 @@ const struct cpumask *pci_irq_get_affini
 	if (!desc)
 		return cpu_possible_mask;
 
-	if (WARN_ON_ONCE(!desc->affinity))
+	/* MSI[X] interrupts can be allocated without affinity descriptor */
+	if (!desc->affinity)
 		return NULL;
 
 	/*
