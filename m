Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72066AA2F5
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjCCVwb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjCCVvn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:51:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC165449;
        Fri,  3 Mar 2023 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677880048; x=1709416048;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kj65eZ6x1XaMxzFMjvimVXP1TU9dIZpyh6Wk8sLAlnk=;
  b=n/2TUIYNbv0IsFT7hK71sydMcakD4tcjml8BTP1xeveswn48Jv09HE6f
   5k+GGKV7RG22OZK/JY1ozTsW3gxpXRAddxlJNxgheoGgOKlb7Smtw+Z0E
   FUXfLbiG6/wVt7hpvOmR8lWVG43FqwSkx0AZ71bR0kZB8dwvvwyNORlOB
   e9aDdwjgCXYzYxn9lwezxtpGdXHkQ+eq1tPo9zuJOgNe9plwlcAZJffwH
   9cJPGDW2K6pYJCUQZj5bSILw8KJP8OZqx4ygb9oRFYWRQxoAT3SaE5vVZ
   McRc6axBh9XCjdE4kE/dkFwwrQ8Es1Ga3Hz4AU2n7a0VvPAvCWHX53RYH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="337481927"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="337481927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="668795971"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="668795971"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:44:03 -0800
Date:   Fri, 3 Mar 2023 13:47:53 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <20230303134753.660d0755@jacob-builder>
In-Reply-To: <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> > Global PASID allocation is under IOMMU SVA code since it is the primary
> > use case.  However, some architecture such as VT-d, global PASIDs are
> > necessary for its internal use of DMA API with PASID.  
> 
> No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
> device requirement.
I meant VT-d based platforms, it is kind of intertwined in that ENQCMDS
does not restrict RIDPASID!=DMA PASID, vt-d does. Without this
restriction, there wouldn't be a need for this patch. Let me reword.
> > 
> > This patch introduces SVA APIs to reserve and release global PASIDs.
> > 
> > Link: https://lore.kernel.org/all/20230301235646.2692846-4-
> > jacob.jun.pan@linux.intel.com/
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu-sva.c | 25 +++++++++++++++++++++++++
> >  include/linux/iommu.h     | 14 ++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 8c92a145e15d..cfdeafde88a9 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -149,6 +149,31 @@ u32 iommu_sva_get_pasid(struct iommu_sva
> > *handle)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> > 
> > +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> > +{
> > +	int ret;
> > +
> > +	if (min == IOMMU_PASID_INVALID || max ==
> > IOMMU_PASID_INVALID ||
> > +	    min == 0 || max < min)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < 0)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
> > +  
> 
> I'm not sure it's the right way. It's not related to SVA.
> 
> We should move iommu_global_pasid_ida to iomm.c and then have
> another interface for allocation.
> 
> Above is pretty generic so probably a general one like:
> 
> 	ioasid_t iommu_allocate_global_pasid(struct device *dev)
> 
> internally it can use [1, dev->iommu->max_pasids] as min/max instead
> of passed in from the caller.
sounds good to me, will do.


Thanks,

Jacob
