Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A242152DE13
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiESUGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbiESUGu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 16:06:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84ED6AA4C;
        Thu, 19 May 2022 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652990807; x=1684526807;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=em9680kU19oyJd12oVrtmjdy90mEXzPAGRZB1JnG5kg=;
  b=asTpI3wMXdy2fG138KEElUkwgqtdm7b1DCC0cS/o7i1i03e4Ol/mH+7O
   AMu7u9p0hmq3HMxhB9vJdLAgLa6JS5ScErvMY0jzpOIKUDcChycdGgbtj
   zuJY008ZLRt8Fsa9Rdohe2Fa5/jZxrW5MmFv160YWPqgOGyG5qPrfJsQq
   5lv5Hxz8pp/ftCVffyQjeTYNgYxzg0luI9WYxjV2nJSsGmhKxHYzqZ0F3
   1+1yBvnepytim5de3PdDhnC56PgHYmsAOvdy986ySdc3e+QOetN5o05a3
   s2K4KFo3ZFbG5ETyHK0hMyYQbnYmmBqzaU/kMku3uraBkG6a5kpGq5WBu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="358768710"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="358768710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:06:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="557094209"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:06:47 -0700
Date:   Thu, 19 May 2022 13:10:37 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from
 domain
Message-ID: <20220519131037.08d7590f@jacob-builder>
In-Reply-To: <41c717e3-2965-67ac-9140-72f4b071cd9a@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
        <41c717e3-2965-67ac-9140-72f4b071cd9a@linux.intel.com>
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

Hi Baolu,

On Thu, 19 May 2022 14:41:06 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> > IOMMU group maintains a PASID array which stores the associated IOMMU
> > domains. This patch introduces a helper function to do domain to PASID
> > look up. It will be used by TLB flush and device-PASID attach
> > verification.  
> 
> Do you really need this?
> 
> The IOMMU driver has maintained a device tracking list for each domain.
> It has been used for cache invalidation when unmap() is called against
> dma domain.
Yes, I am aware of the device list. In v3, I stored DMA API PASID in device
list of device_domain_info. Since we already have a pasid_array, Jason
suggested to share the storage with the code. This helper is needed to
reverse look up the DMA PASID based on the domain attached.
Discussions here:
https://lore.kernel.org/lkml/20220511170025.GF49344@nvidia.com/t/#mf7cb7d54d89e6e732a020dc22435260da0a49580

Thanks,

Jacob
