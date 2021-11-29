Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD4461A71
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbhK2O7q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 09:59:46 -0500
Received: from foss.arm.com ([217.140.110.172]:41692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346090AbhK2O5q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Nov 2021 09:57:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F18AD1042;
        Mon, 29 Nov 2021 06:54:25 -0800 (PST)
Received: from [10.57.34.182] (unknown [10.57.34.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D1C3F766;
        Mon, 29 Nov 2021 06:54:21 -0800 (PST)
Message-ID: <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
Date:   Mon, 29 Nov 2021 14:54:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com> <87czmjdnw9.ffs@tglx>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87czmjdnw9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-11-29 14:42, Thomas Gleixner wrote:
> On Mon, Nov 29 2021 at 13:13, Robin Murphy wrote:
>> On 2021-11-29 10:55, Will Deacon wrote:
>>>> -	}
>>>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>>>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>>>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>>>
>>> Prviously, if retrieval of the MSI failed then we'd fall back to wired
>>> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
>>> we make the assignments to smmu->*irq here conditional on the MSI being
>>> valid, please?
>>
>> I was just looking at that too, but reached the conclusion that it's
>> probably OK, since consumption of this value later is gated on
>> ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value
>> in the absence of PRI should make no practical difference.
> 
> It's actually 0 when the vector cannot be found.

Oh, -1 for my reading comprehension but +1 for my confidence in the 
patch then :)

I'll let Will have the final say over how cautious we really want to be 
here, but as far as I'm concerned it's a welcome cleanup as-is. Ditto 
for patch #32 based on the same reasoning, although I don't have a 
suitable test platform on-hand to sanity-check that one.

Cheers,
Robin.

>> If we don't have MSIs at all, we'd presumably still fail earlier
>> either at the dev->msi_domain check or upon trying to allocate the
>> vectors, so we'll still fall back to any previously-set wired values
>> before getting here.  The only remaining case is if we've
>> *successfully* allocated the expected number of vectors yet are then
>> somehow unable to retrieve one or more of them - presumably the system
>> has to be massively borked for that to happen, at which point do we
>> really want to bother trying to reason about anything?
> 
> Probably not. At that point something is going to explode sooner than
> later in colorful ways.
> 
> Thanks,
> 
>          tglx
> 
