Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2553982B
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347840AbiEaUkf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347839AbiEaUk2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 16:40:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB4DE8B;
        Tue, 31 May 2022 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654029619; x=1685565619;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVNourZTR1Kt6OmuqtuVyyuHWlgFnrM3yUwYczvadfk=;
  b=NlOqj7F3y/QumbRlfvfPrKlgTbn18skdpOkC6pfc4XYVUc/R+g2QEIac
   gSLIePI74Tz5d8id/GiQFi3+eG1+OKEhX0MfVBy+IEyvaW2WW7WGG1Hid
   L5pf2pEUEtXDSBC9U02fN+P8vvzdl0tovDmLtMrhUcqzYCloNzYqe3NSZ
   MQVR9GHgrG6mmcgrdBZYjoWCtrnqRP+sbH43WPnwI8G7/00JdCwoiCHrY
   lUXSnAMB4i+HKFav2RLG8b91S+gU87SxxZZNJlvLuKEs+0YoIVrMtTFFg
   iETbEHNGHxtHN+TjIgsHC9aMdfEUOj31YsD8oDINt8DmRBEiRdXSvPBJB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257449622"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="257449622"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 13:40:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="612003367"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 13:40:17 -0700
Date:   Tue, 31 May 2022 13:44:14 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220531134414.37a62c88@jacob-builder>
In-Reply-To: <20220531190550.GK1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
        <20220524135034.GU1343366@nvidia.com>
        <20220524081727.19c2dd6d@jacob-builder>
        <20220530122247.GY1343366@nvidia.com>
        <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
        <20220531102955.6618b540@jacob-builder>
        <20220531190550.GK1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 31 May 2022 16:05:50 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 31, 2022 at 10:29:55AM -0700, Jacob Pan wrote:
> 
> > The reason why I store PASID at IOMMU domain is for IOTLB flush within
> > the domain. Device driver is not aware of domain level IOTLB flush. We
> > also have iova_cookie for each domain which essentially is for
> > RIDPASID.  
> 
> You need to make the PASID stuff work generically.
> 
> The domain needs to hold a list of all the places it needs to flush
> and that list needs to be maintained during attach/detach.
> 
> A single PASID on the domain is obviously never going to work
> generically.
> 
I agree, I did it this way really meant to be part of iommu_domain's
iommu_dma_cookie, not meant to be global. But for the lack of common
storage between identity domain and dma domain, I put it here as global.

Then should we also extract RIDPASID to become part of the generic API?
i.e. set pasid, flush IOTLB etc. Right? RIDPASID is not in group's
pasid_array today.

Thanks,

Jacob
