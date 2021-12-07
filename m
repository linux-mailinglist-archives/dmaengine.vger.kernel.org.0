Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61C46C611
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 22:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhLGVJL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 16:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhLGVI6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 16:08:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7366C061574;
        Tue,  7 Dec 2021 13:05:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 212DACE1E74;
        Tue,  7 Dec 2021 21:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C0FC341C3;
        Tue,  7 Dec 2021 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911124;
        bh=SSlqi2avER7Dt/gWeQCpUUK2WPs6V3REpcTbyOpLSVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CQtpmV/VopSugovJYtB6rKgOASfGm+plq9ohd+c4gicwGabcfRU6ytOddQjW3Ve3g
         tNsgaOjeq555aKWCr9jX9ODfSAmC5gTVJ3vse/nmE/bt6EDI8IgNQkIg/STXmf+7zE
         U64SEr9asqbhWIQiNhiBgpiH/BRtSY7WmUh34L91oWrRiTQR4AmZqrtRLVMJBHFyQ9
         UasPXsz2PYCPtfItiij1woyf8fHZ+e13Xx+SVxc9GVYIn8V5Hs0PkqB4OagIliTaI+
         V7FpgXy1X/0HnHOAWVtqEJ1pP+FwItrm6eFFL4yJzWnlD+4qQ//Q8RNQddmclqTqgt
         UL3+7UtH4ejJw==
Date:   Tue, 7 Dec 2021 15:05:22 -0600
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
Subject: Re: [patch V2 25/36] PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
Message-ID: <20211207210522.GA77919@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210439.021277807@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:36PM +0100, Thomas Gleixner wrote:
> Provide a domain info flag which makes the core code check for a contiguous
> MSI-X index on allocation. That's simpler than checking it at some other
> domain callback in architecture code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   16 ++++++++++++++--
>  include/linux/msi.h         |    2 ++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -89,9 +89,21 @@ static int pci_msi_domain_check_cap(stru
>  	if (pci_msi_desc_is_multi_msi(desc) &&
>  	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
>  		return 1;
> -	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
> -		return -ENOTSUPP;
>  
> +	if (desc->pci.msi_attrib.is_msix) {
> +		if (!(info->flags & MSI_FLAG_PCI_MSIX))
> +			return -ENOTSUPP;
> +
> +		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
> +			unsigned int idx = 0;
> +
> +			/* Check for gaps in the entry indices */
> +			for_each_msi_entry(desc, dev) {
> +				if (desc->msi_index != idx++)
> +					return -ENOTSUPP;
> +			}
> +		}
> +	}
>  	return 0;
>  }
>  
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -376,6 +376,8 @@ enum {
>  	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
>  	/* Populate sysfs on alloc() and destroy it on free() */
>  	MSI_FLAG_DEV_SYSFS		= (1 << 7),
> +	/* MSI-X entries must be contiguous */
> +	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
>  };
>  
>  int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
> 
