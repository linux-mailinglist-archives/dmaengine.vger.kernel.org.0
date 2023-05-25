Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5960B710FF2
	for <lists+dmaengine@lfdr.de>; Thu, 25 May 2023 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjEYPug (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 May 2023 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjEYPu0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 May 2023 11:50:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920AB6;
        Thu, 25 May 2023 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685029816; x=1716565816;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=emj39pN1Kh0TKycX7k6GT4QnYMEV4/dD9je4KRuZQhU=;
  b=HKY/xP4VV5ZPrgdQJ8Q8w7ZOuAMoqUyraIj/g818+3UcTubLbTX76Fq1
   e1XyGK3HKXLF9r3AyrlM6M5rt3GcHIU+BILkiuKd4FS40xK78vnrHMZ9f
   7OA6jDi4OLouOO/WqAap82ANR49JNz7DkuYXErS1003YmsSq/vgdey0Sg
   y/RaswgxcXAL3BLp532E54vq1fUEsBqHaLyrHnSnvyss38uCzVK9gPQYd
   XLqEUWyBZeRz1NhURD9uGfKOkTDbCvqxI47z5VXARPhBGfE6YHiy7z7z/
   cuq2oKBdacYnDio00xSWJafw29TXvoTvfwJviXBugCEf0CL8531OlQFiX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333547642"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="333547642"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 08:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682371590"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="682371590"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 08:50:15 -0700
Date:   Thu, 25 May 2023 08:54:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
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
Subject: Re: [PATCH v7 2/4] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230525085448.40194a42@jacob-builder>
In-Reply-To: <BN9PR11MB5276F7D03C5595F03A9A14858C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
        <20230523173451.2932113-3-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276F7D03C5595F03A9A14858C469@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Thu, 25 May 2023 06:27:40 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, May 24, 2023 1:35 AM
> > 
> >  /* Allocate a PASID for the mm within range (inclusive) */
> > -static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min,
> > ioasid_t max)
> > +static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device
> > *dev) {
> > +	ioasid_t pasid;
> >  	int ret = 0;
> > 
> > -	if (min == IOMMU_PASID_INVALID ||
> > -	    max == IOMMU_PASID_INVALID ||
> > -	    min == 0 || max < min)
> > -		return -EINVAL;
> > -
> >  	if (!arch_pgtable_dma_compat(mm))
> >  		return -EBUSY;
> > 
> >  	mutex_lock(&iommu_sva_lock);
> >  	/* Is a PASID already associated with this mm? */
> >  	if (mm_valid_pasid(mm)) {
> > -		if (mm->pasid < min || mm->pasid > max)
> > +		if (mm->pasid > dev->iommu->max_pasids)  
> 
> ">" should be ">="  
right, will do

> > +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > +{
> > +	int ret;
> > +	ioasid_t max;
> > +
> > +	max = dev->iommu->max_pasids;
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida,
> > IOMMU_FIRST_GLOBAL_PASID, max, GFP_KERNEL);  
> 
> max is inclusive. Here should minus one.
yeah, should be -1

> otherwise looks good to me,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>


Thanks,

Jacob
