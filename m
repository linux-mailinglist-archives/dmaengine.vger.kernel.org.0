Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D510532D09
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiEXPNg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbiEXPNf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:13:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189868AE48;
        Tue, 24 May 2022 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653405215; x=1684941215;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tk27iwpVLwZhrAdYRAP9PXSjtSwimSeDsovqZPPM1B0=;
  b=L6HbKekScTgGHuCNnisNh58guVMP+bOQgs52UBY7ucjDS97M+A46Zwkg
   R8aIolMyGd5k9UV5xuDRGIqhCQWisyIQrM+D1BO7Z7OzzFjDXlAG/MpiZ
   JhZpALRFSqs7EfULAx0smGLnBZ2sdRxWLZ8a2oyuBkmhGih2C2KcSm2e4
   WgZNinVlUcRghPfwIhFMlthweWZ120SEDaXrM7eKUUo14AfQwFbu3Rj+g
   uachqsJ5ErIiYDukg7wnr72bBUsBIV414IUjTnSr5+ajWbt1C3O6aIM1A
   THj8WOPMH3TZDfJikCQ/5qp5TbLyjdpON1DkV9i09N3iStGBDTHmnvKt1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="298878888"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="298878888"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 08:13:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="572702343"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 08:13:34 -0700
Date:   Tue, 24 May 2022 08:17:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220524081727.19c2dd6d@jacob-builder>
In-Reply-To: <20220524135034.GU1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
        <20220524135034.GU1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 24 May 2022 10:50:34 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 18, 2022 at 11:21:15AM -0700, Jacob Pan wrote:
> > DMA requests tagged with PASID can target individual IOMMU domains.
> > Introduce a domain-wide PASID for DMA API, it will be used on the same
> > mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> > identity domain.  
> 
> Huh? I can't understand what this is trying to say or why this patch
> makes sense.
> 
> We really should not have pasid's like this attached to the domains..
> 
This is the same "DMA API global PASID" you reviewed in v3, I just
singled it out as a standalone patch and renamed it. Here is your previous
review comment.

> +++ b/include/linux/iommu.h
> @@ -105,6 +105,8 @@ struct iommu_domain {
>  	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>  						      void *data);
>  	void *fault_data;
> +	ioasid_t pasid;		/* Used for DMA requests with PASID */
> +	atomic_t pasid_users;  

These are poorly named, this is really the DMA API global PASID and
shouldn't be used for other things.



Perhaps I misunderstood, do you mind explaining more?


Thanks,

Jacob
