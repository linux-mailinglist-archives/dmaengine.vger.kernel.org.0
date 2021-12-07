Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36046C605
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhLGVIk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 16:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbhLGVIj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 16:08:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5ADC061574;
        Tue,  7 Dec 2021 13:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F5A3CE1E6D;
        Tue,  7 Dec 2021 21:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4744FC341C1;
        Tue,  7 Dec 2021 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911104;
        bh=B1uq1LxQ+zV7OmdTOwCRtNnO2jvBQqZ4s4dpqK7FSx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FtAnSeLche3tDfxYR56d58ANFwkYFafEMJxsxNrKfqKSblB85o+rbHYZ0oIIlySDv
         tsgfTCkxzfo51fNQXVhI9AfB029y60Tf37iykBBNUPrO9avyXhGWg3TNkVZDa3+bLl
         MKDQoxA+9Eb/eCVob/myMBPCDOUC7Lks1kDQXL/5zr8Jhktfir9G8Gj5qdNVWJyvmY
         nSUYSnGBdz6NxEsdbnDrce0qOvuWXhcMslMcv0JD/Q3qxC0C9Ez3+52Iiaa26ekY+F
         2GXwtyHKPUf3jS2KFP70m0i6puvts4TC/fan1RswEtNWghn5k8zw3s0sx0LXHK3Kax
         bg5UGKj2mjoaA==
Date:   Tue, 7 Dec 2021 15:05:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>,
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
Subject: Re: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
Message-ID: <20211207210503.GA77830@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210438.688216619@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:26PM +0100, Thomas Gleixner wrote:
> Store the properties which are interesting for various places so the MSI
> descriptor fiddling can be removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V2: Use the setter function
> ---
>  drivers/pci/msi/msi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -244,6 +244,8 @@ static void free_msi_irqs(struct pci_dev
>  		iounmap(dev->msix_base);
>  		dev->msix_base = NULL;
>  	}
> +
> +	msi_device_set_properties(&dev->dev, 0);
>  }
>  
>  static void pci_intx_for_msi(struct pci_dev *dev, int enable)
> @@ -341,6 +343,7 @@ msi_setup_entry(struct pci_dev *dev, int
>  {
>  	struct irq_affinity_desc *masks = NULL;
>  	struct msi_desc *entry;
> +	unsigned long prop;
>  	u16 control;
>  
>  	if (affd)
> @@ -372,6 +375,10 @@ msi_setup_entry(struct pci_dev *dev, int
>  	if (entry->pci.msi_attrib.can_mask)
>  		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
>  
> +	prop = MSI_PROP_PCI_MSI;
> +	if (entry->pci.msi_attrib.is_64)
> +		prop |= MSI_PROP_64BIT;
> +	msi_device_set_properties(&dev->dev, prop);
>  out:
>  	kfree(masks);
>  	return entry;
> @@ -514,6 +521,7 @@ static int msix_setup_entries(struct pci
>  		if (masks)
>  			curmsk++;
>  	}
> +	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
>  	ret = 0;
>  out:
>  	kfree(masks);
> 
