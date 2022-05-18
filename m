Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CE52C27B
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiERSj7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbiERSj6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:39:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B641DB588;
        Wed, 18 May 2022 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652899197; x=1684435197;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/oKhYTcnY4myTpFoegzGHopmAVVEEzgyLwyapl7tQQ=;
  b=gjifRWwVI7atM6NqpjKQjmIIKSpRRAvJjla4cCLFkc5/c5LeqQwiOPmq
   KraYXLAeeWMDecMyFyPbwEQmu6QVzhfBD4Hd4SB08h24jDQYLaRJLuxx7
   pjF7eRU/yHmf59EaRXYMnU/rPUSBRa4MX9HccnwP6e0fyZfpvttn1MxNX
   wsT4o+PKpfOs/kDGJwK7KvG9kE3pe3tj9IL21ilIWyXUDj82f3hAkVyOv
   FoLIc49hjSoHw+0zgbbwnHXDI2/dseCwKpZMheoqbvy+0sSrLVbq4Q7Jd
   aoB2iW2VBrHyQVI1D40EAELe/wapHYj7LJYfbfUmg35oiJeXyUNI+eKym
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="269425271"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="269425271"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:38:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="569686074"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:38:14 -0700
Date:   Wed, 18 May 2022 11:42:04 -0700
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
Message-ID: <20220518114204.4d251b41@jacob-builder>
In-Reply-To: <20220511182908.GK49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
        <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
        <20220510232121.GP49344@nvidia.com>
        <20220510172309.3c4e7512@jacob-builder>
        <20220511115427.GU49344@nvidia.com>
        <20220511082958.79d5d8ee@jacob-builder>
        <20220511161237.GB49344@nvidia.com>
        <20220511100216.7615e288@jacob-builder>
        <20220511170025.GF49344@nvidia.com>
        <20220511102521.6b7c578c@jacob-builder>
        <20220511182908.GK49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Wed, 11 May 2022 15:29:08 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 11, 2022 at 10:25:21AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 11 May 2022 14:00:25 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:  
> > > > > > If not global, perhaps we could have a list of pasids (e.g.
> > > > > > xarray) attached to the device_domain_info. The TLB flush logic
> > > > > > would just go through the list w/o caring what the PASIDs are
> > > > > > for. Does it make sense to you?      
> > > > > 
> > > > > Sort of, but we shouldn't duplicate xarrays - the group already
> > > > > has this xarray - need to find some way to allow access to it
> > > > > from the driver.
> > > > >     
> > > > I am not following,  here are the PASIDs for devTLB flush which is
> > > > per device. Why group?    
> > > 
> > > Because group is where the core code stores it.  
> > I see, with singleton group. I guess I can let dma-iommu code call
> > 
> > iommu_attach_dma_pasid {
> > 	iommu_attach_device_pasid();
> > Then the PASID will be stored in the group xa.  
> 
> Yes, again, the dma-iommu should not be any different from the normal
> unmanaged path. At this point there is no longer any difference, we
> should not invent new ones.
> 
> > The flush code can retrieve PASIDs from device_domain_info.device ->
> > group -> pasid_array.  Thanks for pointing it out, I missed the new
> > pasid_array.  
> 
> Yes.. It seems inefficient to iterate over that xarray multiple times
> on the flush hot path, but maybe there is little choice. Try to use
> use the xas iterators under the xa_lock spinlock..
> 
xas_for_each takes a max range, here we don't really have one. So I posted
v4 w/o using the xas advanced API. Please let me know if you have
suggestions.
xa_for_each takes RCU read lock, it should be fast for tlb flush, right? The
worst case maybe over flush when we have stale data but should be very rare.

> The challenge will be accessing the group xa in the first place, but
> maybe the core code can gain a function call to return a pointer to
> that XA or something..
> 
I added a helper function to find the matching DMA API PASID in v4.


Thanks,

Jacob
