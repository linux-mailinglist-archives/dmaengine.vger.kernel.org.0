Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7787E52DEE4
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiESVCD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244987AbiESVCB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 17:02:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B0DFF51;
        Thu, 19 May 2022 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652994119; x=1684530119;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYCIsdHXjqyWWTpU5Mo1OkWS4PvlHDtGprxIbJ0rp/g=;
  b=aUdrFfvwBJ5SODNa+wJ5PQq1p6yyMjfZGSg6+0FGjrdGm2I7kHAI84Ub
   0K3GMwyxTapONwsjK+NYIOHsySDVWe5ImnQQZEMpkiNtwLooL3Gok5bAt
   BaSivZ60wirEG5cdWVF7tySDwphVZktYt/tsVBXFmoV/ebFntC+3SRhNH
   OS9bZ0scEEjTYManyXwnwhD93hdK26Qko1ReyGpnZkWZlZdRrMJfG+ZtH
   wX0UGgjf0UADtgEw/6wuWoJ184GX4x2U8InODUFSbGPetl5KtbMzNg9YB
   Ect3JrPMNRFtHwBS14Pn6H00EvwTMuJpcK+OMOlSzI10D9NWOdj+b/I0/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252894617"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="252894617"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:01:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743129020"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:01:53 -0700
Date:   Thu, 19 May 2022 14:05:43 -0700
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
Message-ID: <20220519140543.1b43ef85@jacob-builder>
In-Reply-To: <20220518185205.GT1343366@nvidia.com>
References: <20220510232121.GP49344@nvidia.com>
        <20220510172309.3c4e7512@jacob-builder>
        <20220511115427.GU49344@nvidia.com>
        <20220511082958.79d5d8ee@jacob-builder>
        <20220511161237.GB49344@nvidia.com>
        <20220511100216.7615e288@jacob-builder>
        <20220511170025.GF49344@nvidia.com>
        <20220511102521.6b7c578c@jacob-builder>
        <20220511182908.GK49344@nvidia.com>
        <20220518114204.4d251b41@jacob-builder>
        <20220518185205.GT1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Wed, 18 May 2022 15:52:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 18, 2022 at 11:42:04AM -0700, Jacob Pan wrote:
> 
> > > Yes.. It seems inefficient to iterate over that xarray multiple times
> > > on the flush hot path, but maybe there is little choice. Try to use
> > > use the xas iterators under the xa_lock spinlock..
> > >   
> > xas_for_each takes a max range, here we don't really have one. So I
> > posted v4 w/o using the xas advanced API. Please let me know if you have
> > suggestions.  
> 
> You are supposed to use ULONG_MAX in cases like that.
> 
got it.
> > xa_for_each takes RCU read lock, it should be fast for tlb flush,
> > right? The worst case maybe over flush when we have stale data but
> > should be very rare.  
> 
> Not really, xa_for_each walks the tree for every iteration, it is
> slower than a linked list walk in any cases where the xarray is
> multi-node. xas_for_each is able to retain a pointer where it is in
> the tree so each iteration is usually just a pointer increment.
> 
Thanks for explaining, yeah if we have to iterate multiple times
xas_for_each() is better.

> The downside is you cannot sleep while doing xas_for_each
> 
will do under RCU read lock

> > > The challenge will be accessing the group xa in the first place, but
> > > maybe the core code can gain a function call to return a pointer to
> > > that XA or something..  
>  
> > I added a helper function to find the matching DMA API PASID in v4.  
> 
> Again, why are we focused on DMA API? Nothing you build here should be
> DMA API beyond the fact that the iommu_domain being attached is the
> default domain.
The helper is not DMA API specific. Just a domain-PASID look up. Sorry for
the confusion.

Thanks,

Jacob
