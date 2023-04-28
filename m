Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F706F1BF4
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjD1Pwa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjD1Pw2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 11:52:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6535B4212;
        Fri, 28 Apr 2023 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682697147; x=1714233147;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VSoxdyPY93P2BuKRz02q7jUM3wZLua7CfSmMyaDnso=;
  b=NVULFCiFLXzYaJGPiMN9AeHl67w4PShs1P7rCRtR21Myn8LnRslarZwF
   Ebyd1GFFXze066IHy03ueUVFaBOvoSMlathxTUuoorDVIVqEwZDDUSKlB
   SAXBvxO5VdF/jBQt3O61pV302XHfTyPMK2AmwLI9ZEL0QJZgn74mStjim
   E7zzHtrdlZ2mqRBld4aANDDL1lmgzcIttzhY23XraXrbeRQSGtH7fAD/I
   SrA5dZef7SjJZU7CKtLBPWML/zfRnBN6CS92WXxx9Y24yPP0skA/Nk+Fv
   37TBkBHprzsOqjMpm2gVVJ4AQNgg3WsMgm6TS+my2+OTa0DMEH5z+Omva
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="332100069"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="332100069"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="645184066"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="645184066"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:52:26 -0700
Date:   Fri, 28 Apr 2023 08:56:45 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 2/7] iommu/sva: Explicitly exclude RID_PASID from SVA
Message-ID: <20230428085645.0310c4ca@jacob-builder>
In-Reply-To: <BN9PR11MB52760C0384F37927AEAB0C1C8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-3-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52760C0384F37927AEAB0C1C8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Fri, 28 Apr 2023 09:40:12 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, April 28, 2023 1:50 AM
> > 
> > SVA PASID allocation is hardcoded to start from 1 because 0 is used for
> > RID_PASID, let's make it explicit to avoid the potential conflicts.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu-sva.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c434b95dc8eb..ac7c93bacb5c 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -66,7 +66,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm
> >  		return ERR_PTR(-EOPNOTSUPP);
> > 
> >  	/* Allocate mm->pasid if necessary. */
> > -	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> > +	ret = iommu_sva_alloc_pasid(mm, IOMMU_DEF_RID_PASID + 1,
> > max_pasids - 1);  
> 
> To be future proof it's probably cleaner to define a
> IOMMU_MAX_RSVD_PASID in case there may be more reserved
> pasids in future usages?
 much better, will do.

Thanks,

Jacob
