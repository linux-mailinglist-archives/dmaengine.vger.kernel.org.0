Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58F3461A2B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 15:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347124AbhK2Orf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 09:47:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378796AbhK2Opf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Nov 2021 09:45:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638196934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CT0v0AI6Phc8QVXrts/Xgc4HRVQEDE2q+21sbaFe3Ag=;
        b=FLmFznUrsgGdCbkY18htm7AVhrJXD8U/COCS8SobY/Fs5q0hzBOjNa5VOMzAo8uh3ixtor
        Si29Nben+KPEqz1+N0yD6PS3qluBIuq3elGrNncT23ydzQDK2l9SnDPo2CnUq8qH8j8MZ6
        vdvCp+IY+fkqSwwbS7Vke5ucVqUPyZqIAnlw2remRg1r2/dstE2w/iGMIhhlHtUzXuGfyg
        PeIFtoJzVGaUJsD95eDn+sZvgevfzRe7bt6oelu5NOVNC0Y5uWJCfO8sg7SGeqm/QUZ5F8
        9idHosPV4IKLQIULp5+Ee114KeQfrHkYLH1gL8+nGq99mmniKOQJkHCZ2aVDWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638196934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CT0v0AI6Phc8QVXrts/Xgc4HRVQEDE2q+21sbaFe3Ag=;
        b=1lha+hOs5XE61wIA5Q6/xFS1hVtMHYwWSYlH+AylgvE8sxOiU/hMvfsbJ4+lxuc4mz54M/
        UkoehTAc13TFlPDw==
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
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
In-Reply-To: <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
Date:   Mon, 29 Nov 2021 15:42:14 +0100
Message-ID: <87czmjdnw9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 29 2021 at 13:13, Robin Murphy wrote:
> On 2021-11-29 10:55, Will Deacon wrote:
>>> -	}
>>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>> 
>> Prviously, if retrieval of the MSI failed then we'd fall back to wired
>> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
>> we make the assignments to smmu->*irq here conditional on the MSI being
>> valid, please?
>
> I was just looking at that too, but reached the conclusion that it's 
> probably OK, since consumption of this value later is gated on 
> ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value 
> in the absence of PRI should make no practical difference.

It's actually 0 when the vector cannot be found.

> If we don't have MSIs at all, we'd presumably still fail earlier
> either at the dev->msi_domain check or upon trying to allocate the
> vectors, so we'll still fall back to any previously-set wired values
> before getting here.  The only remaining case is if we've
> *successfully* allocated the expected number of vectors yet are then
> somehow unable to retrieve one or more of them - presumably the system
> has to be massively borked for that to happen, at which point do we
> really want to bother trying to reason about anything?

Probably not. At that point something is going to explode sooner than
later in colorful ways.

Thanks,

        tglx
