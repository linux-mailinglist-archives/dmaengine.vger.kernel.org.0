Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE96C2A49
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 07:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCUGQO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 02:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCUGQN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 02:16:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DDF7EE6;
        Mon, 20 Mar 2023 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679379372; x=1710915372;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IfVWlROUvFTg3fbNGSjW4+BuBAC1kv1Hcw4K8n9PyBc=;
  b=StXiblce0dRu4LioTmcpAUUGVgnsxPakZjTEddHrbAyNmFNo9ftrMVtP
   evhWGtaQEr3g+4b0Lk8HW6k3HFsfmbWiFOCPVdrSPeO1ios5R6r5KMvFF
   DzHZnPfBCqSScsesCoC0hFjC956TObOHNbqIYC5D627FrK2cisLEayJWU
   raR9gWGbVb/fOSRaPMdExjFbfa8cZc3PmDcROzAKcGoyi58pJgI/cVyeB
   hyg2HOIq9m0HlMETr10CK9EltHMchIA08nI40aW/uGxRs5/nwWHbDNZ21
   T8proY9FwOH9r5Yc6cI4+tyfWZ9rcqS2EWSTgT4FOu2zdH/6UJT7W/z/G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318509560"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="318509560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="805198423"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="805198423"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2023 23:16:05 -0700
Message-ID: <00ee54f0-52c9-8f35-fdc4-aa3c3cd9e755@linux.intel.com>
Date:   Tue, 21 Mar 2023 14:14:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v7 4/7] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
 <20230320185910.2643260-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230320185910.2643260-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/21/23 2:59 AM, Jacob Pan wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
> 
> Future work would be to allow drivers using the SVA APIs to reserve global
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
