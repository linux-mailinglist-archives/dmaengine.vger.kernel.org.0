Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769552375A
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbiEKPbh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEKPbg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 11:31:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060B53E29;
        Wed, 11 May 2022 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652283095; x=1683819095;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ndczgwyznivdqv1iFCHWhopQvKb+2Iqd5Yk+4O3ea9c=;
  b=aUKdevAP1zBomDOXOkOhphGq5H4HUjh0MTWzI5wobT7G81nxLe+8P5KA
   mslzsR3lcxHFNhOmHPLYc6+TNFqkdUX+k+hhVH9wd4ItfNpjEdYq/AhtY
   tXDFNRkCqgcKhdBokaki0CSHyF2cIIdm3V0UI2g+qKy4yRvq6p0yL/V/D
   BV/NL3DUqVJon9ayqBRl5B9CEgbQ6ca/eyXkFx/YJ8lSS8FJeulqtITwc
   dYDyNvyIQ33oPQlrKNfzLCpa6ktzfHf2jA7z9CrbwWlAL0GnHApex/f/V
   nvdOSr6Y4oZCZE3fAmpCqR+qVAOymvA8e5mZH7LLUEau6dv4ieW0Mhmv4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330330913"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="330330913"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:31:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="895392286"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:31:32 -0700
Date:   Wed, 11 May 2022 08:35:18 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511082958.79d5d8ee@jacob-builder>
In-Reply-To: <20220511115427.GU49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Wed, 11 May 2022 08:54:27 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 10, 2022 at 05:23:09PM -0700, Jacob Pan wrote:
> 
> > > > diff --git a/include/linux/intel-iommu.h
> > > > b/include/linux/intel-iommu.h index 5af24befc9f1..55845a8c4f4d
> > > > 100644 +++ b/include/linux/intel-iommu.h
> > > > @@ -627,6 +627,7 @@ struct device_domain_info {
> > > >  	struct intel_iommu *iommu; /* IOMMU used by this device */
> > > >  	struct dmar_domain *domain; /* pointer to domain */
> > > >  	struct pasid_table *pasid_table; /* pasid table */
> > > > +	ioasid_t pasid; /* DMA request with PASID */    
> > > 
> > > And this seems wrong - the DMA API is not the only user of
> > > attach_dev_pasid, so there should not be any global pasid for the
> > > device.
> > >   
> > True but the attach_dev_pasid() op is domain type specific. i.e. DMA API
> > has its own attach_dev_pasid which is different than sva domain
> > attach_dev_pasid().  
> 
> Huh? The intel driver shares the same ops between UNMANAGED and DMA -
> and in general I do not think we should be putting special knowledge
> about the DMA domains in the drivers. Drivers should continue to treat
> them identically to UNMANAGED.
> 
OK, other than SVA domain, the rest domain types share the same default ops.
I agree that the default ops should be the same for UNMANAGED, IDENTITY, and
DMA domain types. Minor detail is that we need to treat IDENTITY domain
slightly different when it comes down to PASID entry programming.

If not global, perhaps we could have a list of pasids (e.g. xarray) attached
to the device_domain_info. The TLB flush logic would just go through the
list w/o caring what the PASIDs are for. Does it make sense to you?

> > device_domain_info is only used by DMA API.  
> 
> Huh?
My mistake, i meant the device_domain_info.pasid is only used by DMA API

>  
> > > I suspect this should be a counter of # of pasid domains attached so
> > > that the special flush logic triggers
> > >   
> > This field is only used for devTLB, so it is per domain-device. struct
> > device_domain_info is allocated per device-domain as well. Sorry, I
> > might have totally missed your point.  
> 
> You can't store a single pasid in the driver like this, since the only
> thing it does is trigger the flush logic just count how many pasids
> are used by the device-domain and trigger pasid flush if any pasids
> are attached
> 
Got it, will put the pasids in an xa as described above.

> > > And rely on the core code to worry about assigning only one domain per
> > > pasid - this should really be a 'set' function.  
> >
> > Yes, in this set the core code (in dma-iommu.c) only assign one PASID
> > per DMA domain type.
> > 
> > Are you suggesting the dma-iommu API should be called
> > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?  
> 
> No that API is Ok - the driver ops API should be 'set' not attach/detach
> 
Sounds good, this operation has little in common with
domain_ops.dev_attach_pasid() used by SVA domain. So I will add a new
domain_ops.dev_set_pasid()


Thanks,

Jacob
