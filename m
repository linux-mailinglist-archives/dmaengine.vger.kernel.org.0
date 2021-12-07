Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479A46C618
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbhLGVJY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 16:09:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39516 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbhLGVJU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 16:09:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 242EECE1E70;
        Tue,  7 Dec 2021 21:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E534FC341C1;
        Tue,  7 Dec 2021 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911146;
        bh=emmb3xsy+H3LBfwGrcgXTk/PL3JNw+p8ei444INyEeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tUHMVIuvSKD4KpV71T2u3HTnNeDdjH94nw6ue1OFelE7L1C2fPpkpG+VJS6EQ7RbL
         DE4nTrcL4DzJJW3p9KkxJ90aY6WFOuJBcNOz8jNU3ACfHQRdCHhgymSV73nOEduwEV
         6C7Yc+PJ57lEXe3kC7Fnk7gDayIipgMIIFTSVZY22xFXTXz0GcB0An+vkRX1XJHFeD
         76cd+8jimETlvZcjXu7IptnZ7ZJ5TZKmn3H2yllAjGpq1LNMQk63AsB8yMhOvkaWG7
         8Ad9xB75VRw/OAC03WjVlipOwF+92OCz7KOMco287/fqEZgDdhOY94sgRr2WDdSvK3
         r75m+DCO8+wLg==
Date:   Tue, 7 Dec 2021 15:05:44 -0600
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
Subject: Re: [patch V2 28/36] PCI/MSI: Use __msi_get_virq() in
 pci_get_vector()
Message-ID: <20211207210544.GA77966@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210439.181331216@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:41PM +0100, Thomas Gleixner wrote:
> Use msi_get_vector() and handle the return value to be compatible.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V2: Handle the INTx case directly instead of trying to be overly smart - Marc
> ---
>  drivers/pci/msi/msi.c |   25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1032,28 +1032,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
>   */
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  {
> -	if (dev->msix_enabled) {
> -		struct msi_desc *entry;
> +	unsigned int irq;
>  
> -		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->msi_index == nr)
> -				return entry->irq;
> -		}
> -		WARN_ON_ONCE(1);
> -		return -EINVAL;
> -	}
> +	if (!dev->msi_enabled && !dev->msix_enabled)
> +		return !nr ? dev->irq : -EINVAL;
>  
> -	if (dev->msi_enabled) {
> -		struct msi_desc *entry = first_pci_msi_entry(dev);
> -
> -		if (WARN_ON_ONCE(nr >= entry->nvec_used))
> -			return -EINVAL;
> -	} else {
> -		if (WARN_ON_ONCE(nr > 0))
> -			return -EINVAL;
> -	}
> -
> -	return dev->irq + nr;
> +	irq = msi_get_virq(&dev->dev, nr);
> +	return irq ? irq : -EINVAL;
>  }
>  EXPORT_SYMBOL(pci_irq_vector);
>  
> 
