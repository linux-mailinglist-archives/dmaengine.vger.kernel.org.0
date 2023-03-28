Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110156CB5B0
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjC1E4S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 00:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjC1E4Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 00:56:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCF212B;
        Mon, 27 Mar 2023 21:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679979341; x=1711515341;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7t8HEByj4cLff00VoXO0IFf+83/zzmjcbsLyOg5ScbM=;
  b=XN2VXZJFAePHX7YebbfYjoTX+kLRf4P0FUSVTOmZpUAFWwJZ4jb34Za6
   4qljPxDHIAvAMvR5hhmYexHlBlE+Z6AdkpltEyiQelBwlgL2mJvZZ/pzF
   34EWyPCJAIuHtCkP0xukolj3kvGyz6mZi2/fr5UBNhIgq7fdJuMngX/+5
   I8/36hy189nxlRGu0NK5epa9WNiU0tnSb+dhNJkaFGHmsZ8yKgXyHl+OA
   4BSYN/FsJL0H5gL51zalouY3UWwWf/1Y02GL4/bskbgYhSa6PoGtKEHq6
   8U2JTY16td1BmpGT+JSmVqrWp1JNJ7i7Ex0BlB55hcz2BEFmZMNoE9tC9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337974778"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="337974778"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 21:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="1013395525"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="1013395525"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2023 21:54:57 -0700
Message-ID: <8839763d-8a40-caad-4048-0d335fb3beb9@linux.intel.com>
Date:   Tue, 28 Mar 2023 12:55:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 1/8] iommu/vt-d: Use non-privileged mode for all PASIDs
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-2-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/28/23 7:21 AM, Jacob Pan wrote:
> Supervisor Request Enable (SRE) bit in a PASID entry is for permission
> checking on DMA requests. When SRE = 0, DMA with supervisor privilege
> will be blocked. However, for in-kernel DMA this is not necessary in that
> we are targeting kernel memory anyway. There's no need to differentiate
> user and kernel for in-kernel DMA.
> 
> Let's use non-privileged (user) permission for all PASIDs used in kernel,
> it will be consistent with DMA without PASID (RID_PASID) as well.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
