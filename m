Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F2246DA69
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 18:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhLHR4r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 12:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhLHR4n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Dec 2021 12:56:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3652C061746;
        Wed,  8 Dec 2021 09:53:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638985988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VE0nNlLZyDP2MmX/vYQZeWgKNo5Uy6Cr5E5oEyE//0=;
        b=yVnW54g9mJPoCSUF2QVZDU2f/xrPC/IYtzosNqipMCrUE3ublT0WkCXcFyPVrEXNiDojbG
        WW1CUtpK3VyoAq9fSgOMsdsrptfY0amXBwna/GvfaJqkTvsyAVL5hI1SpplK1OmRnxMVrX
        L5hSSsO8qCmLbj+GpNXsAcp58GYvqbj2Cej56RVnAFHSASUWcdaICSkYgNnc4MXsVS22aL
        8yNx41somh4ngRIGaL6Bs8mvddn976wAff7JClugcbIPHTmhPJafFg/+oWVQNEXsavVz8Q
        ECHb4fzOEv458qXYE4Q7kYbod/VikxJKFLy0KA5gkzv0UDl1V1bDcOOf7ps2JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638985988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VE0nNlLZyDP2MmX/vYQZeWgKNo5Uy6Cr5E5oEyE//0=;
        b=tcPpBzNArpjTicF6DwnR6v7vnK+DexgwPINycnkhbizry34b4Yd5f7r99TAQsJpmyDoy7E
        NsIoYzOvgoObEZDg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
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
Subject: Re: [patch V2 20/36] x86/pci/XEN: Use device MSI properties
In-Reply-To: <20211208155314.GX6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.742297272@linutronix.de>
 <20211208155314.GX6385@nvidia.com>
Date:   Wed, 08 Dec 2021 18:53:07 +0100
Message-ID: <877dcf0yrg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 08 2021 at 11:53, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 11:39:28PM +0100, Thomas Gleixner wrote:
>>  static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
>>  {
>> -	struct msi_desc *msidesc = first_pci_msi_entry(dev);
>> -
>> -	if (msidesc->pci.msi_attrib.is_msix)
>> +	if (msi_device_has_property(&dev->dev, MSI_PROP_PCI_MSIX))
>>  		xen_pci_frontend_disable_msix(dev);
>>  	else
>>  		xen_pci_frontend_disable_msi(dev);
>
> Same remark as for power, we have a pci_dev, so can it be
> dev->msix_enabled?

Yes, let me rework that.
