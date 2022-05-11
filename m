Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86359523AFD
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345208AbiEKQ6c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiEKQ6b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 12:58:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB6713C377;
        Wed, 11 May 2022 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652288310; x=1683824310;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+SbLcoPf9zuYRgUS6mcapuzb8rI2aXPD90HpmL4jgs=;
  b=Zs6M85aKbq3gRwBYFFZcQp+0/T4/FCaZ/zPEZ39so5DS6eD6ddLyzP13
   fOVwnu6Cb8XWBPQm5Jyc2tI0tIhMSqRvbNRwTK1AC8mwugVCyv23xkco/
   DP5grrASN0f1DXpIXlXfFVD7K0Uxh23Z/OphJX3U0ZSkb1M1P0J8tmbCQ
   mcsO0SDmwnP4/CSKoND+e9aJQLyXr3izE8kmHFx7IVQiS9einbwGQMrbJ
   DzE+KRmSZG/ij2RZtdcwZTMbn2RzAF0pDMWTdZiyhLkYOk0YoEpT038oW
   TrniUmwIiTx/2maTjg7ndeam3DvEjxqnfqWatop3azIvR9FACNSQ4XjXy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269887278"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269887278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:58:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="520594260"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:58:29 -0700
Date:   Wed, 11 May 2022 10:02:16 -0700
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
Message-ID: <20220511100216.7615e288@jacob-builder>
In-Reply-To: <20220511161237.GB49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
        <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
        <20220510232121.GP49344@nvidia.com>
        <20220510172309.3c4e7512@jacob-builder>
        <20220511115427.GU49344@nvidia.com>
        <20220511082958.79d5d8ee@jacob-builder>
        <20220511161237.GB49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Wed, 11 May 2022 13:12:37 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 11, 2022 at 08:35:18AM -0700, Jacob Pan wrote:
> 
> > > Huh? The intel driver shares the same ops between UNMANAGED and DMA -
> > > and in general I do not think we should be putting special knowledge
> > > about the DMA domains in the drivers. Drivers should continue to treat
> > > them identically to UNMANAGED.
> > >   
> > OK, other than SVA domain, the rest domain types share the same default
> > ops. I agree that the default ops should be the same for UNMANAGED,
> > IDENTITY, and DMA domain types. Minor detail is that we need to treat
> > IDENTITY domain slightly different when it comes down to PASID entry
> > programming.  
> 
> I would be happy if IDENTITY had its own ops, if that makes sense
> 
I have tried to have its own ops but there are complications around
checking if a domain has ops. It would be a logic thing to clean up next.

> > If not global, perhaps we could have a list of pasids (e.g. xarray)
> > attached to the device_domain_info. The TLB flush logic would just go
> > through the list w/o caring what the PASIDs are for. Does it make sense
> > to you?  
> 
> Sort of, but we shouldn't duplicate xarrays - the group already has
> this xarray - need to find some way to allow access to it from the
> driver.
> 
I am not following,  here are the PASIDs for devTLB flush which is per
device. Why group?
We could retrieve PASIDs from the device PASID table but xa would be more
efficient.

> > > > Are you suggesting the dma-iommu API should be called
> > > > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?    
> > > 
> > > No that API is Ok - the driver ops API should be 'set' not
> > > attach/detach 
> > Sounds good, this operation has little in common with
> > domain_ops.dev_attach_pasid() used by SVA domain. So I will add a new
> > domain_ops.dev_set_pasid()  
> 
> What? No, their should only be one operation, 'dev_set_pasid' and it
> is exactly the same as the SVA operation. It configures things so that
> any existing translation on the PASID is removed and the PASID
> translates according to the given domain.
> 
> SVA given domain or UNMANAGED given domain doesn't matter to the
> higher level code. The driver should implement per-domain ops as
> required to get the different behaviors.
Perhaps some code to clarify, we have
sva_domain_ops.dev_attach_pasid() = intel_svm_attach_dev_pasid;
default_domain_ops.dev_attach_pasid() = intel_iommu_attach_dev_pasid;

Consolidate pasid programming into dev_set_pasid() then called by both
intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?


Thanks,

Jacob
