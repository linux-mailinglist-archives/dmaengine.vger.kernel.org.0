Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FE462FCC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Nov 2021 10:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhK3Jjh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Nov 2021 04:39:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57616 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbhK3Jjh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Nov 2021 04:39:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B7B2B817CB;
        Tue, 30 Nov 2021 09:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B953BC53FC1;
        Tue, 30 Nov 2021 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638264975;
        bh=W1GU/Y+dYM9mor9VhMfyacGdkrH60iHzxrMl5d0x7r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0r5AYfW3e1qmmKXMhnPGFNda+jCz4x32KqmgoGbi/4llhlf6BrLG4Dh11TrqOIeu
         6t7GoYuyjI9rTSprKBeCATI3H8ZBljyKTSGOSCnipoGRBXubK/230YXB3/xb4gFMhK
         cetZdMeS2NJYt7HNccWctY4u4f1mgnZpNgCtZJRGxDgqEEEw7kR57CR0PfP0Ionr1G
         xPTqMjy/MGJ4yEDXMUL6xcvp5DKu/6CmLLEBvKhEmLc8LWxQafHEWBJGhbDleY8T/g
         YOwIzg7OkJlOKz2t3lQsamPaqomT2NSf9Bp1mKf8Gg28o2SHvwcvRn0rzb0pd0NzYi
         nyH+dmToW47RQ==
Date:   Tue, 30 Nov 2021 09:36:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>,
        x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Message-ID: <20211130093607.GA23941@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
 <87czmjdnw9.ffs@tglx>
 <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 29, 2021 at 02:54:18PM +0000, Robin Murphy wrote:
> On 2021-11-29 14:42, Thomas Gleixner wrote:
> > On Mon, Nov 29 2021 at 13:13, Robin Murphy wrote:
> > > On 2021-11-29 10:55, Will Deacon wrote:
> > > > > -	}
> > > > > +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
> > > > > +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> > > > > +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> > > > 
> > > > Prviously, if retrieval of the MSI failed then we'd fall back to wired
> > > > interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
> > > > we make the assignments to smmu->*irq here conditional on the MSI being
> > > > valid, please?
> > > 
> > > I was just looking at that too, but reached the conclusion that it's
> > > probably OK, since consumption of this value later is gated on
> > > ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value
> > > in the absence of PRI should make no practical difference.
> > 
> > It's actually 0 when the vector cannot be found.
> 
> Oh, -1 for my reading comprehension but +1 for my confidence in the patch
> then :)
> 
> I'll let Will have the final say over how cautious we really want to be
> here, but as far as I'm concerned it's a welcome cleanup as-is. Ditto for
> patch #32 based on the same reasoning, although I don't have a suitable test
> platform on-hand to sanity-check that one.

If, as it appears, msi_get_virq() isn't going to fail meaningfully after
we've successfully called platform_msi_domain_alloc_irqs() then it sounds
like the patch is fine. Just wanted to check though, as Spring cleaning at
the end of November raised an eyebrow over here :)

Will
