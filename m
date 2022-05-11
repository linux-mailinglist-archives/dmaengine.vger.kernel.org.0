Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2288523B64
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbiEKRVl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345453AbiEKRVi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 13:21:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFDD20CA6A;
        Wed, 11 May 2022 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652289696; x=1683825696;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qy7t1Ypki7j0iCcWaRmk0ORRY2L4RZAMrStqlHAMWPM=;
  b=JZrxJKtUf3/f9ogFmZ8/3Xplvg6R7xVTjm1JSrqMyiJTB6c5rsvdxfX+
   ZAhR+lfN0o7LGyQFnnvPd3fkMpEsItTDUar7PGCVp0BTH1blTfj6Kb2SH
   1QphgxhhlNKTRR2M5np2MoIBAaAyB7tlawIQqTK1UaQ8hagqeGdRPcV24
   +ev2PTftH+6vLi+AgqpssadXZFg5SkVgIX0fzG6h+wtE5yw4x0jABzkHM
   5TAgwJiTrhBDc2A5Mvyr838LBvqupOAoWGwPOkXRAVh6cOibxoTcuSonV
   mD4pDJbEAA1wa2C61OTWakwT57goDRxPYPuulO0rnJcjmmAQ907kgOXCm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249658522"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="249658522"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:21:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="553414882"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:21:35 -0700
Date:   Wed, 11 May 2022 10:25:21 -0700
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
Message-ID: <20220511102521.6b7c578c@jacob-builder>
In-Reply-To: <20220511170025.GF49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
        <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
        <20220510232121.GP49344@nvidia.com>
        <20220510172309.3c4e7512@jacob-builder>
        <20220511115427.GU49344@nvidia.com>
        <20220511082958.79d5d8ee@jacob-builder>
        <20220511161237.GB49344@nvidia.com>
        <20220511100216.7615e288@jacob-builder>
        <20220511170025.GF49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Wed, 11 May 2022 14:00:25 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:
> > > > If not global, perhaps we could have a list of pasids (e.g. xarray)
> > > > attached to the device_domain_info. The TLB flush logic would just
> > > > go through the list w/o caring what the PASIDs are for. Does it
> > > > make sense to you?    
> > > 
> > > Sort of, but we shouldn't duplicate xarrays - the group already has
> > > this xarray - need to find some way to allow access to it from the
> > > driver.
> > >   
> > I am not following,  here are the PASIDs for devTLB flush which is per
> > device. Why group?  
> 
> Because group is where the core code stores it.
I see, with singleton group. I guess I can let dma-iommu code call

iommu_attach_dma_pasid {
	iommu_attach_device_pasid();
Then the PASID will be stored in the group xa.
The flush code can retrieve PASIDs from device_domain_info.device -> group
-> pasid_array.
Thanks for pointing it out, I missed the new pasid_array.
> 
> > We could retrieve PASIDs from the device PASID table but xa would be
> > more efficient.
> >   
> > > > > > Are you suggesting the dma-iommu API should be called
> > > > > > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?      
> > > > > 
> > > > > No that API is Ok - the driver ops API should be 'set' not
> > > > > attach/detach   
> > > > Sounds good, this operation has little in common with
> > > > domain_ops.dev_attach_pasid() used by SVA domain. So I will add a
> > > > new domain_ops.dev_set_pasid()    
> > > 
> > > What? No, their should only be one operation, 'dev_set_pasid' and it
> > > is exactly the same as the SVA operation. It configures things so that
> > > any existing translation on the PASID is removed and the PASID
> > > translates according to the given domain.
> > > 
> > > SVA given domain or UNMANAGED given domain doesn't matter to the
> > > higher level code. The driver should implement per-domain ops as
> > > required to get the different behaviors.  
> > Perhaps some code to clarify, we have
> > sva_domain_ops.dev_attach_pasid() = intel_svm_attach_dev_pasid;
> > default_domain_ops.dev_attach_pasid() = intel_iommu_attach_dev_pasid;  
> 
> Yes, keep that structure
>  
> > Consolidate pasid programming into dev_set_pasid() then called by both
> > intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?
> >  
> 
> I was only suggesting that really dev_attach_pasid() op is misnamed,
> it should be called set_dev_pasid() and act like a set, not a paired
> attach/detach - same as the non-PASID ops.
> 
Got it. Perhaps another patch to rename, Baolu?


Thanks,

Jacob
