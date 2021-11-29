Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F8461423
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhK2Lvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 06:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346264AbhK2Ltj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Nov 2021 06:49:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949FAC0698D4;
        Mon, 29 Nov 2021 02:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9AE6128E;
        Mon, 29 Nov 2021 10:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A396C53FAD;
        Mon, 29 Nov 2021 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638183315;
        bh=QhZNG7zEJdkQvS0LEX52li9AXzufJrQFobG0M6duX3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=In+AkzkxuwyvtyrVSnDdHfnln0ej7MVCOlSJ0dRt2ZWpilriGh6TuxtTbIvPZpGRc
         3raF7kENSA7Iqg9d3lIFa1Tycva8OdSns9kjZGzFU/i0aJcBpVAWsw03om+s4qnUOM
         fw8I9XrPtQ3Rho8qt5voFvB4S6aarTonmWrXmIFAJNjWosRUJn049/OYsViwr62iQF
         gEyUDXXP/57E3hImuxQespEfMMrhMyK1bU1TI2fcChiOBzoxZ2prSilIA/X8hL/HV2
         gt/PtTjrEAm0TvcLCwOpO2++IoNJLFndUJeT7h1TLYmVmW3HVey3dfUX8+sE/bT/k6
         GGQZi90ZDL7Yg==
Date:   Mon, 29 Nov 2021 10:55:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20211129105506.GA22761@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126230525.885757679@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Thomas,

On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
> Let the core code fiddle with the MSI descriptor retrieval.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
>  
>  static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  {
> -	struct msi_desc *desc;
>  	int ret, nvec = ARM_SMMU_MAX_MSIS;
>  	struct device *dev = smmu->dev;
>  
> @@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
>  		return;
>  	}
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

Prviously, if retrieval of the MSI failed then we'd fall back to wired
interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
we make the assignments to smmu->*irq here conditional on the MSI being
valid, please?

Cheers,

Will
