Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E952EEDA
	for <lists+dmaengine@lfdr.de>; Fri, 20 May 2022 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbiETPPL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 May 2022 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiETPPK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 May 2022 11:15:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1644F17066D;
        Fri, 20 May 2022 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653059709; x=1684595709;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+n6IA7s8ZdVDI7H47AGS442JizFaVM8WMDKQdIxObGU=;
  b=UTBNM0gsxjH3bQus2dPK18ohjxYbovLwf6a5Dh7L9nebkbB3ersWrRgc
   NVS8Gp/INY2OFFtl9eG26y2fF1V4JRChGb3i+WQOgxfPLBWqTOmlv+WQG
   tjZGc6eohTBs5qRVUepA8dGn+2G/CFv+WzBT3j0ez2oKKvNgw3lbOt85u
   87jXRd9UsJLEwpASTrGgFdbhRV4F88fgDisHXTtZAIA0Lo1O6+4vs+lNe
   Ts66Tw6Qs1kD9H1lcmAPvHvPG6MZZHNNcxF1gpwuYDaHHMNQ6Yj3MY8Xf
   8Yx6tqcoj1CGHgi3ks9qUTN+b1OXVKEm+S9F88s2kSVz4EYFcVXBIOgQq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="254689233"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="254689233"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:15:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="899363103"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:15:07 -0700
Date:   Fri, 20 May 2022 08:18:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from
 domain
Message-ID: <20220520081858.486602d7@jacob-builder>
In-Reply-To: <YoXoTFeSdnBILj/2@infradead.org>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
        <YoXoTFeSdnBILj/2@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Christoph,

On Wed, 18 May 2022 23:48:44 -0700, Christoph Hellwig <hch@infradead.org>
wrote:

> On Wed, May 18, 2022 at 11:21:16AM -0700, Jacob Pan wrote:
> > +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> > iommu_domain *domain)  
> 
> Overly long line here.
will fix,

Thanks,

Jacob
