Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8770E04F
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjEWPVz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjEWPVw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 11:21:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B30FA;
        Tue, 23 May 2023 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684855310; x=1716391310;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZESLGiStlp+snnZO6mgcThSkiz1+FlRkX0Y1V4e3SE=;
  b=jESjFSSPx+8+8j5Xhi+bu2/IIbbn6XUjx/+sm/7mBocX7VIjBMOpxkm4
   xkuDnSwOj1mAi/C+RjTkHZbKaEGNGtj/nd+YxFG3R9BOBMvSj0xqWkzP/
   niDM08MD772j8toc1x0P+BoL1IfS1rBtqUszuxQ5gyeNL0Hhx5u8a1Zzq
   Vsk5keIUSAQ5YBDKPX2MuYh75PR8MmG6r032bGge71ew2QIJyFA2Dfp+o
   GICdYXTZkvD4YnXt7C4uFteFenRVCStw2rMoMhURLNAZ/5Wvi/BuBNb4N
   eqAkKBnYNJJcxh6iX4OofskIgddTjr6W6lM9kpXCC4Hnnsuameo9tv58z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="353295747"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="353295747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 08:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950584434"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="950584434"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 08:21:49 -0700
Date:   Tue, 23 May 2023 08:26:21 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 1/4] iommu: Generalize default PCIe requester ID
 PASID
Message-ID: <20230523082621.51f103cc@jacob-builder>
In-Reply-To: <20230523144733.GA4137946@myrica>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
        <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>
        <20230523144733.GA4137946@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jean,

On Tue, 23 May 2023 15:47:33 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> On Fri, May 19, 2023 at 01:32:20PM -0700, Jacob Pan wrote:
> > PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> > provides finer grained isolation than requester ID (RID).
> > 
> > For each RID, 0 is as a special PASID for the legacy DMA (without
> > PASID), thus RID_PASID. This is universal across all architectures,
> > therefore warranted to be declared in the common header.
> > Noting that VT-d could support none-zero RID_PASID, but currently not
> > used.
> > 
> > By having a common RID_PASID, we can avoid conflicts between different
> > use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
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
> > a5a63b1c947e..160b31e6239d 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c @@ -80,7 +80,7 @@
> > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> >  	 * be some overlap between use of both ASIDs, until we
> > invalidate the
> >  	 * TLB.
> >  	 */
> > -	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> > +	arm_smmu_write_ctx_desc(smmu_domain, IOMMU_DEF_RID_PASID, cd);
> >  
> 
> I agree with reserving 0 globally for non-PASID DMA, but could we call
> this something more generic, like IOMMU_NO_PASID?  The term "RID_PASID" is
> specific to VT-d and "RID" to PCI, so it looks confusing here (this driver
> also supports non-PCI). "NO_PASID" would be clearer to someone just trying
> to follow this driver code.
> 
Sounds good, it is for DMA w/o PASID.


Thanks,

Jacob
