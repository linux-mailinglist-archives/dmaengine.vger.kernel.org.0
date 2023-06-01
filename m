Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3096719F8C
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFAORI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjFAORF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:17:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCD1A7;
        Thu,  1 Jun 2023 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685628997; x=1717164997;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dmxt7GbDDPw22imss1naePSr6AzopnGgF10hBW/BGlI=;
  b=WlRop9uZg47WE190TonV+RQ4Ko+/0uedbE+r5kCOH4lpejWA3pdpPNiv
   LhzJ9K7aIONnxIZ4eMPbpSBLXOZPV4f2T93zyTV7/Huzit3ClVQ0dOLoD
   H4/4ofMpIQEuvZ7YesKSLKPMeWQRx8tRozS4loUcuV/vmflhLUy9Oz1kw
   5WfutHN6Ahuk9gKLrAoOEJv8PkxTNBc2GXgZ7dD42XlNB+2dSNT+HvJaZ
   su2GEZBrteSa9bHhex3wMR6Wf1G3GFRpRSgg8UGSG/epFCVxKsG91Ekvv
   JacYfwQVXTmKPfvEsG1xoRHB0L8qEtHiwgXLcxXHSgCxTuqU3sK3gD8fe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335918810"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335918810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701557600"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="701557600"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:16:35 -0700
Date:   Thu, 1 Jun 2023 07:21:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 1/4] iommu: Generalize PASID 0 for normal DMA w/o
 PASID
Message-ID: <20230601072111.29a4e5c9@jacob-builder>
In-Reply-To: <20230601092634.GA3059361@myrica>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
        <20230523173451.2932113-2-jacob.jun.pan@linux.intel.com>
        <20230601092634.GA3059361@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jean-Philippe,

On Thu, 1 Jun 2023 10:26:34 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> On Tue, May 23, 2023 at 10:34:48AM -0700, Jacob Pan wrote:
> > PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> > provides finer grained isolation than requester ID (RID).
> > 
> > For each device/RID, 0 is a special PASID for the normal DMA (no
> > PASID). This is universal across all architectures that supports PASID,
> > therefore warranted to be reserved globally and declared in the common
> > header. Consequently, we can avoid the conflict between different PASID
> > use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> > 
> > This paved away for device drivers to choose global PASID policy while
> > continue doing normal DMA.
> > 
> > Noting that VT-d could support none-zero RID/NO_PASID, but currently not
> > used.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v7:
> >    - renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
> > v6:
> >    - let SMMU code use the common RID_PASID macro
> > ---
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++++----
> >  drivers/iommu/intel/iommu.c                   | 24 +++++++++----------
> >  drivers/iommu/intel/pasid.c                   |  2 +-
> >  drivers/iommu/intel/pasid.h                   |  1 -
> >  include/linux/iommu.h                         |  1 +
> >  6 files changed, 20 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c index
> > a5a63b1c947e..5e6b39881c04 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c @@ -80,7 +80,7 @@
> > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> >  	 * be some overlap between use of both ASIDs, until we
> > invalidate the
> >  	 * TLB.
> >  	 */
> > -	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> > +	arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, cd);
> >  
> >  	/* Invalidate TLB entries previously associated with that
> > context */ arm_smmu_tlb_inv_asid(smmu, asid);
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> > 3fd83fb75722..6d64c8fc923f 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -1053,7 +1053,7 @@ int
> > arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> > /*
> >  	 * This function handles the following cases:
> >  	 *
> > -	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> > +	 * (1) Install primary CD, for normal DMA traffic (SSID =
> > IOMMU_NO_PASID = 0).
> >  	 * (2) Install a secondary CD, for SID+SSID traffic.
> >  	 * (3) Update ASID of a CD. Atomically write the first 64 bits
> > of the
> >  	 *     CD, then invalidate the old entry and mappings.
> > @@ -1869,7 +1869,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> >  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> >  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> >  	}
> > -	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> > +	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
> >  }
> >  
> >  static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> > @@ -1957,7 +1957,7 @@ static void
> > arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
> >  	 * Unfortunately, this can't be leaf-only since we may have
> >  	 * zapped an entire table.
> >  	 */
> > -	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
> > +	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova,
> > size); }
> >  
> >  void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int
> > asid, @@ -2131,7 +2131,7 @@ static int
> > arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
> >  	 * the master has been added to the devices list for this
> > domain.
> >  	 * This isn't an issue because the STE hasn't been installed
> > yet. */
> > -	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> > +	ret = arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID,
> > &cfg->cd); if (ret)
> >  		goto out_free_cd_tables;
> >  
> > @@ -2317,7 +2317,7 @@ static void arm_smmu_enable_ats(struct
> > arm_smmu_master *master) pdev = to_pci_dev(master->dev);
> >  
> >  	atomic_inc(&smmu_domain->nr_ats_masters);
> > -	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> > +	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
> >  	if (pci_enable_ats(pdev, stu))
> >  		dev_err(master->dev, "Failed to enable ATS (STU
> > %zu)\n", stu); }  
> 
> Thanks, I think this makes the code clearer. For consistency you could
> also add these:
> 
> ---
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> 6d64c8fc923fc..c977106357961 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -1601,7 +1601,7 @@
> static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
> 
>  	sid = FIELD_GET(PRIQ_0_SID, evt[0]);
>  	ssv = FIELD_GET(PRIQ_0_SSID_V, evt[0]);
> -	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : 0;
> +	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
>  	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
>  	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> 
> @@ -1742,7 +1742,7 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long
> iova, size_t size, */
>  	*cmd = (struct arm_smmu_cmdq_ent) {
>  		.opcode			= CMDQ_OP_ATC_INV,
> -		.substream_valid	= !!ssid,
> +		.substream_valid	= (ssid != IOMMU_NO_PASID),
>  		.atc.ssid		= ssid,
>  	};
> 
> @@ -1789,7 +1789,7 @@ static int arm_smmu_atc_inv_master(struct
> arm_smmu_master *master) struct arm_smmu_cmdq_ent cmd;
>  	struct arm_smmu_cmdq_batch cmds;
> 
> -	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
> +	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
> 
>  	cmds.num = 0;
>  	for (i = 0; i < master->num_streams; i++) {
> ---
> 
> With that, for SMMU:
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Will do!

Thanks,

Jacob
