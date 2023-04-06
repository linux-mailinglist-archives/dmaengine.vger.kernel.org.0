Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F156D96FA
	for <lists+dmaengine@lfdr.de>; Thu,  6 Apr 2023 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjDFMYC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Apr 2023 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDFMYB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Apr 2023 08:24:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBA6EB6;
        Thu,  6 Apr 2023 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680783840; x=1712319840;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6+2sIEevEKNZMYLg0cPtMs/Yvde/43gIMbaSm6f5SwM=;
  b=GVm1JjjsJ1oKFl2VrMvAr1I40uXeM8eHpLbiVeUR8qHZx9ZV9RRthv2u
   /jzsdf0yda8Jbv1IdG4mPRslck+aJUgXgmipOZ3slYL/yF6EfuU+RRmB1
   q+UN6Mx4gkSIz3Yvp3uzo1d8rUrH0SzNCJhGtdY+z21HF3ljZmBLtJqr1
   PbCFaJ/bGx2MxjNz2GQoehCAl9dgu7jPAqGOGahjd9OVQuZ7aosFh5lyx
   W74Lfm9u0e8ea3qJkDoDIZbc+ahnC3thSUimq7MPJkG5fWs55ecHG1YAS
   iE895m7DR11irCd1GP/g8PEKsBAgszfpf+1bDoptZ8VV41qtGAo2RwhRd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405508410"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="405508410"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="830719341"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="830719341"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.177]) ([10.255.31.177])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:23:55 -0700
Message-ID: <448c24d8-60d2-3881-171c-863b240ebdf1@linux.intel.com>
Date:   Thu, 6 Apr 2023 20:23:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 0/7] Re-enable IDXD kernel workqueue under DMA API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jacob,

On 2023/4/1 7:11, Jacob Pan wrote:
> Jacob Pan (7):
>    iommu/vt-d: Use non-privileged mode for all PASIDs
>    iommu/vt-d: Remove PASID supervisor request support

Above two patches are vt-d cleanups after

942fd5435dcc iommu: Remove SVM_FLAG_SUPERVISOR_MODE support

I will queue them as vt-d updates for v6.4 if no objection.

Best regards,
baolu
