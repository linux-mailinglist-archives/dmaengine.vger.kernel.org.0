Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53BE46344C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Nov 2021 13:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbhK3MeO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Nov 2021 07:34:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhK3MeO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Nov 2021 07:34:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638275453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoxU22IJJPvJRa8OS7V+vWzcBzYBFKmJ+AzUDqGDJ0c=;
        b=By9F2CxzS/o9ToFNEiRxLUVS4AyQNuM7azBeEiD814EleLq+hJGIFbr5Pb7s+yxDcghQJZ
        bz+QmgZkMouYYFY+n8NIMmEVrzBGnKypYEtqksbB0LcQcsXrqkseVFUPXnb/sd5ZkkeCjp
        Pnu87QVrfqY+aPFRcb2JbkA20ryw2kwZX8Zt58hXMuKopfKcpJeEcYrsQaBCBid5TfxvzR
        pg01jc6fTOy30S6/4paKJbL3nUdr+wHzyl4B2pcoryuGOAyzDqtURCC8EFqCHDYt+1EdmP
        Tn7K/VVDH3bM9b/JWsuJU4BSSPJHX1HAmQQ17NBsztNZhn1jdrGHUG7vESjD7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638275453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoxU22IJJPvJRa8OS7V+vWzcBzYBFKmJ+AzUDqGDJ0c=;
        b=b3LRCCrahGv4zVsp1t2g38jgPS8/TbYK4NCKubQCW9LmpN8f4nz/THoNrepB7KLN6Bne8n
        caFNq7QymQ+tnnDg==
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
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
In-Reply-To: <20211130093607.GA23941@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com> <87czmjdnw9.ffs@tglx>
 <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
 <20211130093607.GA23941@willie-the-truck>
Date:   Tue, 30 Nov 2021 13:30:53 +0100
Message-ID: <878rx5ddvm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 30 2021 at 09:36, Will Deacon wrote:
> On Mon, Nov 29, 2021 at 02:54:18PM +0000, Robin Murphy wrote:
>> On 2021-11-29 14:42, Thomas Gleixner wrote:
>> > It's actually 0 when the vector cannot be found.
>> 
>> Oh, -1 for my reading comprehension but +1 for my confidence in the patch
>> then :)
>> 
>> I'll let Will have the final say over how cautious we really want to be
>> here, but as far as I'm concerned it's a welcome cleanup as-is. Ditto for
>> patch #32 based on the same reasoning, although I don't have a suitable test
>> platform on-hand to sanity-check that one.
>
> If, as it appears, msi_get_virq() isn't going to fail meaningfully after
> we've successfully called platform_msi_domain_alloc_irqs() then it sounds
> like the patch is fine. Just wanted to check though, as Spring cleaning at
> the end of November raised an eyebrow over here :)

Fair enough. Next time I'll name it 'Cleaning the Augean stables' when
it's the wrong season.

Thanks,

        tglx

