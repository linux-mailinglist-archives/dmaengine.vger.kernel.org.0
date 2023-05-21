Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0787D70ACA7
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjEUG3y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 02:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEUG3w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 02:29:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EB124;
        Sat, 20 May 2023 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684650591; x=1716186591;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Q8Gd2GY1jd4ghoLFlo6kfcmDpadDjTFnWDXPbpPLBI=;
  b=TGy1hh7l3OsXa5UlQRnWfmOmOAP3nnwkehywJL809CgeHaFiXuYSpfK/
   W5N1EGt/J+VZ4VMO7qcRGnMySuEks774ya2LgWKO1BxO4R17g9d1crE5E
   JWLVb3cbxnRNGZVpQ/96IyBBNbCnYmEyDbyRTGnIoDhKsonkd7hx7RE0F
   j6VXPwfYAO2HnHe1xtdeoCaYrzM8FbvM0jxRz1YL9zreSe9M3hoPyCw1h
   peMIgpu6HfHfpYPa9z7du56dDsuhsZ+BNudR/9DgdllV/WTc799gUvq6K
   KK3kyDihVqZi5b5Fts770JbZ0+hBbSh5qcVbqzoCPtadRRZJ3Pov5ydts
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="439030608"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="439030608"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2023 23:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="697256587"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="697256587"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2023 23:29:46 -0700
Message-ID: <175e0393-735f-3dde-b086-fb5bc514ddee@linux.intel.com>
Date:   Sun, 21 May 2023 14:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230519203223.2777255-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/20/23 4:32 AM, Jacob Pan wrote:
> Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> API. Now that we have the support for attaching PASID to the device's
> default domain and the ability to reserve global PASIDs from SVA APIs,
> we can re-enable the kernel work queues and use them under DMA API.
> 
> We also use non-privileged access for in-kernel DMA to be consistent
> with the IOMMU settings. Consequently, interrupt for user privilege is
> enabled for work completion IRQs.
> 
> Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu<fenghua.yu@intel.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
