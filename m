Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9946AA14E
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCCVgX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCCVgW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:36:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979B6233F;
        Fri,  3 Mar 2023 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879381; x=1709415381;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1OKCAy9ob19J/BmWrfVVQDL23h90LsZl9wS/K15VWWs=;
  b=beAtohhfu4nJ8VwtTFDin/0hCpBYw2R7dWQQjcoO+gFw/wKtyMUPw9sO
   lCM5oupURpGBe909BkNMyhRZUK13GTK24ffRgUjS0/INu1So9JBfRexDo
   v9oLOqhOWE6a6D/o5+WqDeKksGtF31Bfo8UqjTXf1+D+CdKjfwaUhvtW4
   YjipPrTNA3G2wnPBgDNmvjSiJ2NxKZnUqL7U09T3IOtReO4L7rREUssj4
   hXJSM26tCDTCEMexb9nsUbFBagNqMCW/QC41yvuLXaGgSVDhANkGPhriE
   nMccaaydzruFsxrPXg2aAFJdRorhZY/putnIadwj7x59hJkKIxprLFWEB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="336682317"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="336682317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="739651237"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="739651237"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:36:20 -0800
Date:   Fri, 3 Mar 2023 13:40:09 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu/vt-d: Use non-privileged mode for all PASIDs
Message-ID: <20230303134009.189d792f@jacob-builder>
In-Reply-To: <0afa8e6e-1676-d6a5-d679-173351fe439c@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-3-jacob.jun.pan@linux.intel.com>
        <0afa8e6e-1676-d6a5-d679-173351fe439c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Thu, 2 Mar 2023 22:11:36 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/3/2 8:59, Jacob Pan wrote:
> > For in-kernel DMA, use non-privileged access for all PASIDs to be
> > consistent with RID_PASID.
> > There's no need to differentiate user and kernel for in-kernel DMA. >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index a0cb3bc851ac..9e3c056e392d 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2334,8 +2334,6 @@ static int domain_setup_first_level(struct
> > intel_iommu *iommu, if (level != 4 && level != 5)
> >   		return -EINVAL;
> >   
> > -	if (pasid != PASID_RID2PASID)
> > -		flags |= PASID_FLAG_SUPERVISOR_MODE;  
> 
> With above removed, PASID_FLAG_SUPERVISOR_MODE is not used anywhere?
> Perhaps you can cleanup it to avoid dead code?
good point, we could remove pasid_set_sre() related code for FL,SL, and PT.

Thanks,

Jacob
