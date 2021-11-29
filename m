Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C94615AA
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 14:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhK2NEG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 08:04:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbhK2NCG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Nov 2021 08:02:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638190727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3FciFdKO2khQ7f3Cmj7EZjTaeR+RNoaHikUdH9wKA4=;
        b=n/cJ6xXeDR0gfPdjD4YQQT6Q6+jc5VrNxxb/wMO1CCL68nw2ivWvCi9Oc5jRQP1vmykI2L
        wpM4ivbSXnNWtwWg2OMXcPoZHzFO/AGGAjG93eYJmpri4EZB5NYcUKVTUA6tLcXbKQxiVf
        PgtATQCKLuF+FaTJEgRWVfVNRjp4fW0VBSqZRDYs1JIvyPxR2VSAtYwkT2Ktl7we2swKMa
        g5AVSA4LFn5citpFX56X18aS9mj7c9i9SbNhRQePzqQeBXdCP73LY2CoabUjdXkXf4G7SV
        XE6SiQ1P1OMABrt6rekZNAKLNNTpwhPlI8WmKH8Vf+HIO7MpEkvLG1D22S5tnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638190727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3FciFdKO2khQ7f3Cmj7EZjTaeR+RNoaHikUdH9wKA4=;
        b=uzqwAVQ3mlWAmoUWkKfqvuEYkEasky/aV9Ezf1NXjZIqVG+VhtAHegMwxJu+JHXrQe2PJm
        sxMNfZT3wK1xjhCg==
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
In-Reply-To: <87lf17dsyp.ffs@tglx>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck> <87lf17dsyp.ffs@tglx>
Date:   Mon, 29 Nov 2021 13:58:46 +0100
Message-ID: <87ilwbdsop.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 29 2021 at 13:52, Thomas Gleixner wrote:
> On Mon, Nov 29 2021 at 10:55, Will Deacon wrote:
>> On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
>>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>>
>> Prviously, if retrieval of the MSI failed then we'd fall back to wired
>> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
>> we make the assignments to smmu->*irq here conditional on the MSI being
>> valid, please?
>
> So the wired irq number is in ->irq already and MSI does an override
> if available. Not really obvious...

But, this happens right after:

     ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);

So if that succeeded then the descriptors exist and have interrupts
assigned.

Thanks,

        tglx



