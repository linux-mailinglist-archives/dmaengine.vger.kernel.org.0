Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E7461657
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 14:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhK2Nat (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 08:30:49 -0500
Received: from foss.arm.com ([217.140.110.172]:39378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377674AbhK2N2s (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Nov 2021 08:28:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BD01042;
        Mon, 29 Nov 2021 05:25:30 -0800 (PST)
Received: from [10.57.34.182] (unknown [10.57.34.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C04B3F766;
        Mon, 29 Nov 2021 05:25:27 -0800 (PST)
Message-ID: <98dfa822-218b-6ad9-4fd0-56a8e5d2bd02@arm.com>
Date:   Mon, 29 Nov 2021 13:25:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
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
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211126230525.885757679@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-11-27 01:22, Thomas Gleixner wrote:
> Let the core code fiddle with the MSI descriptor retrieval.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
>   1 file changed, 3 insertions(+), 16 deletions(-)
> 
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
>   
>   static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   {
> -	struct msi_desc *desc;
>   	int ret, nvec = ARM_SMMU_MAX_MSIS;
>   	struct device *dev = smmu->dev;
>   
> @@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
>   		return;
>   	}
>   
> -	for_each_msi_entry(desc, dev) {
> -		switch (desc->msi_index) {
> -		case EVTQ_MSI_INDEX:
> -			smmu->evtq.q.irq = desc->irq;
> -			break;
> -		case GERROR_MSI_INDEX:
> -			smmu->gerr_irq = desc->irq;
> -			break;
> -		case PRIQ_MSI_INDEX:
> -			smmu->priq.q.irq = desc->irq;
> -			break;
> -		default:	/* Unknown */
> -			continue;
> -		}
> -	}
> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);

FWIW I've just quickly booted the msi-v1-part-2 branch on a platform 
with MSIs but no PRI such that this now sets priq.q.irq to an error 
value, and as I predicted it's still happy.

Tested-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

>   	/* Add callback to free MSIs on teardown */
>   	devm_add_action(dev, arm_smmu_free_msis, dev);
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
