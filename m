Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3900E6D52DB
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjDCUvB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 16:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjDCUu7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 16:50:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B862270C;
        Mon,  3 Apr 2023 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680555059; x=1712091059;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCUoLVw47iTtBsFQi2zXYE8LF9BtmZtRq5ow7vbWoH0=;
  b=hWHpnHv8sFvoRLgwtZcZNd2aI10pVnQOp6A6xAfB/2CWEuDbvp1hFrYc
   wiyy+2w/AG/Kb8tuGHJB52reOe7ozy3O6/Z3zJOS683t/w8rS7pzhTfCm
   gxPqb4Cc8MFHeDdFQQLnYu3NoVs2ZwIaXPJnaf/L2cmhpenZ4507qZQTe
   fmw4Cvbov0197IebBdCCVHmF9XDNfSb7hv8cGKSKGdIdugiJ8KgzNC6BM
   Vp47TQEKQk81+K71exCyVvaQF8DNUSlNzSvTbYXhdmebDB/MywNbcV9RV
   tro7WWZLIMwaOX1V8IMzMgGRMlHqsBmDvyh3UDssgI0x3WGtSdazB6K4V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="321672228"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="321672228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688633632"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="688633632"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:50:58 -0700
Date:   Mon, 3 Apr 2023 13:55:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/7] iommu/sva: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230403135504.2bd89822@jacob-builder>
In-Reply-To: <81fddd3e-bf6c-966a-b44b-b8a7c9c00591@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
        <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
        <81fddd3e-bf6c-966a-b44b-b8a7c9c00591@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Sat, 1 Apr 2023 21:28:02 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/4/1 7:11, Jacob Pan wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 54f535ff9868..f70478a11a5f 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -1187,6 +1187,9 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm);
> >   void iommu_sva_unbind_device(struct iommu_sva *handle);
> >   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> > +ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max);
> > +void iommu_free_global_pasid(ioasid_t pasid);
> > +
> >   #else
> >   static inline struct iommu_sva *
> >   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> > @@ -1202,6 +1205,13 @@ static inline u32 iommu_sva_get_pasid(struct
> > iommu_sva *handle) {
> >   	return IOMMU_PASID_INVALID;
> >   }
> > +
> > +static inline ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t
> > max) +{
> > +	return IOMMU_PASID_INVALID;
> > +}
> > +
> > +static inline void iommu_free_global_pasid(ioasid_t pasid) {}
> >   static inline void mm_pasid_init(struct mm_struct *mm) {}
> >   static inline void mm_pasid_drop(struct mm_struct *mm) {}
> >   #endif /* CONFIG_IOMMU_SVA */  
> 
> I don't think the function prototypes of
> iommu_[alloc|free]_global_pasid() should be impacted by
> CONFIG_IOMMU_SVA. Or I may overlooked something?
you're right, the scope is beyond SVA now. It should be under
CONFIG_IOMMU_API, i think.

Thanks,

Jacob
