Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10B475FAD
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhLORqi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 12:46:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56360 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhLORqg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 12:46:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236BD619FE;
        Wed, 15 Dec 2021 17:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC38C36AE0;
        Wed, 15 Dec 2021 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639590395;
        bh=8eon80aBZeFq23Odf9TNhXLZ0kuufkyxyEQ2UyQvkqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkCoNkhqYhaWsFSTKJpb77W8nbK6xBhgXx04HDrtcU3wqKWjQXiGzgyhrmLZyIcpi
         MQjyZk+Z77/94x42VRHSfHDxYxwbhzyU1x8FRVQnYWLIzTIG39Is2wA6fDhqQ2fpqP
         n5B4SefG3RtkmGRq+Q9AMgbeRnK4rPW85FgQYoxs=
Date:   Wed, 15 Dec 2021 18:46:33 +0100
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
        Cedric Le Goater <clg@kaod.org>,
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
Subject: Re: [patch V4 09-01/35] PCI/MSI: Decouple MSI[-X] disable from
 pcim_release()
Message-ID: <Ybop+ZdUQSqGkOxe@kroah.com>
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.740644351@linutronix.de>
 <87tuf9rdoj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuf9rdoj.ffs@tglx>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 15, 2021 at 06:16:44PM +0100, Thomas Gleixner wrote:
> The MSI core will introduce runtime allocation of MSI related data. This
> data will be devres managed and has to be set up before enabling
> PCI/MSI[-X]. This would introduce an ordering issue vs. pcim_release().
> 
> The setup order is:
> 
>    pcim_enable_device()
> 	devres_alloc(pcim_release...);
> 	...
> 	pci_irq_alloc()
> 	  msi_setup_device_data()
> 	     devres_alloc(msi_device_data_release, ...)
> 
> and once the device is released these release functions are invoked in the
> opposite order:
> 
>     msi_device_data_release()
>     ...
>     pcim_release()
>        pci_disable_msi[x]()
> 
> which is obviously wrong, because pci_disable_msi[x]() requires the MSI
> data to be available to tear down the MSI[-X] interrupts.
> 
> Remove the MSI[-X] teardown from pcim_release() and add an explicit action
> to be installed on the attempt of enabling PCI/MSI[-X].
> 
> This allows the MSI core data allocation to be ordered correctly in a
> subsequent step.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V4: New patch


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
