Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41B6B52E7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 22:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjCJVcr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Mar 2023 16:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCJVcq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Mar 2023 16:32:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3DBCC15;
        Fri, 10 Mar 2023 13:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678483964; x=1710019964;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehc2G1Khk+7j9DBXV2qWdm7ZCJBZCQ3dNkGTzQyl2kg=;
  b=AmW5umhUJfOQkJlVzyAIttVnBXuw6fbnNoCDidMa3JT90D5xd1DGfNcC
   1hEV7tHLpO+sxsNZAIR0q+dqiDkvl7cKSNVbwD4ERwb7C8GLct2i9n5dn
   VJT1nnIzhrpyY//aMQ8fKsY3sTloiQz0N9ZfiaoErtKyg/ARcr4o7xcfh
   owT7VR0pqZnfijCCS8lHJIeO7eQfYKHXuusLPOgk4+jBodEK2AM2i9mpV
   NNUTooMLGhmLudzjBZjjWRZCe3FSzWRXa3IRFo0fYIcHJJpsbjnJfGxlG
   5Wn0FRn1vVjq9ygg4dXUuUQdTFsIhuHmo6OqxNP5uI+fQrAbmOMwa9ibO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335530957"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="335530957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="766977604"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="766977604"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:32:35 -0800
Date:   Fri, 10 Mar 2023 13:36:28 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <20230310133628.290c0efa@jacob-builder>
In-Reply-To: <30923327-6c08-f0c1-1b52-c1d818f3a3a2@arm.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
        <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
        <30923327-6c08-f0c1-1b52-c1d818f3a3a2@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On Fri, 10 Mar 2023 20:00:52 +0000, Robin Murphy <robin.murphy@arm.com>
wrote:

> On 2023-03-09 22:21, Jacob Pan wrote:
> > Preparing to remove IOASID infrastructure, PASID management will be
> > under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
> > of iommu.h to prevent circular inclusion.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v5:
> > 	- move definition of helpers to iommu code to be consistent with
> > 	  declarations. (Kevin)
> > 	- fix patch partitioning bug (Baolu)
> > v4:
> > 	- delete and open code mm_set_pasid
> > 	- keep mm_init_pasid() as inline for fork performance
> > ---
> >   drivers/iommu/iommu-sva.c    | 10 +++++++++-
> >   include/linux/ioasid.h       |  2 +-
> >   include/linux/iommu-helper.h | 12 ++++++++++++  
> 
> Eww, can we not? iommu-helper is very much just parts of a specific type 
> of bitmap-based IOVA allocator used by some crusty old arch-specific 
> IOMMU code and SWIOTLB. It is unrelated to the iommu.h IOMMU API, and 
> dragging that stuff into modern SVA-related matters seems bizarrely 
> inappropriate. Could we just move the mm_pasid stuff into ioasid.h here, 
> then maybe rename it to iommu-sva.h at the end if eradicating the old 
> name really matters?
thanks for explaining the history behind iommu-helper.h, having a new
include/linux/iommu-sva.h would probably be cleaner.

my original intent for using iommu-helper.h was to avoid problems by mm.h
#include iommu.h. So I just needed a separate small header. let me do
without iommu-helper.h.

Thanks,

Jacob
