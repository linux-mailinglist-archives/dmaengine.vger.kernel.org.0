Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393D45FE7A
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 13:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbhK0MWX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 07:22:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33728 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350336AbhK0MUW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 Nov 2021 07:20:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81FB5B81B05;
        Sat, 27 Nov 2021 12:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB7C53FAD;
        Sat, 27 Nov 2021 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638015426;
        bh=M6KvGcYrDtqG4OBO1gHapd1tDJsuhzzacZxeaaXXH6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=doyQfESCcBzpnRFpLoKwXz+i4FTuaUYgFKnb7y/BPmpr5XafmAT6LvSwSB1VQqFTV
         jQ1NPvskhZ74XU97cJlDOyNb/rTXfh5nE5F2zaiQ90FTxBTrQfn5W/LTsdTMn0Wq0q
         NaCTokaE44OOwbXoUtzd8OESp8iL9ekPzopagvxM=
Date:   Sat, 27 Nov 2021 13:17:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <YaIhv0Cparn92Lz3@kroah.com>
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126224100.303046749@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27, 2021 at 02:20:06AM +0100, Thomas Gleixner wrote:
> This is the second part of [PCI]MSI refactoring which aims to provide the
> ability of expanding MSI-X vectors after enabling MSI-X.
> 
> The first part of this work can be found here:
> 
>     https://lore.kernel.org/r/20211126222700.862407977@linutronix.de
> 
> This second part has the following important changes:
> 
>    1) Cleanup of the MSI related data in struct device
> 
>       struct device contains at the moment various MSI related parts. Some
>       of them (the irq domain pointer) cannot be moved out, but the rest
>       can be allocated on first use. This is in preparation of adding more
>       per device MSI data later on.
> 
>    2) Consolidation of sysfs handling
> 
>       As a first step this moves the sysfs pointer from struct msi_desc
>       into the new per device MSI data structure where it belongs.
> 
>       Later changes will cleanup this code further, but that's not possible
>       at this point.
> 
>    3) Store per device properties in the per device MSI data to avoid
>       looking up MSI descriptors and analysing their data. Cleanup all
>       related use cases.
> 
>    4) Provide a function to retrieve the Linux interrupt number for a given
>       MSI index similar to pci_irq_vector() and cleanup all open coded
>       variants.
> 
> This second series is based on:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-1
> 
> and also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-2
> 

Instead of responding to each individual patch, I've read them all,
thanks for the cleanups, look good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
