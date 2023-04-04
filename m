Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2F6D57EA
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 07:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjDDFTA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 01:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDDFS7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 01:18:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178E1BF3;
        Mon,  3 Apr 2023 22:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680585539; x=1712121539;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6gSgt1TtaxCXHALsYW5lDdEPQQMuML7hRMzWJG2ZTDA=;
  b=fPbmwM5QHlsDPuZqJkijeCCDTwi7Ah4kWBwET7AxpC3d4osMQ36BDDrs
   FgdfFeLULbkbZx+3oNFslTa1Ap0SnmliM8RKuwlIpz3/4yLIggIOAne1U
   AjyMJzJsGV/T4Z4tSBGfiViD6yb6MeSx8NmmonxzWmmioeNViqtE4AD5o
   s5/1pHittLPULf4ux69kjk+XeWKhg4atTMV2bVvp8agVD8n4uPMMMou9D
   NHv6TgqzM+AkF7xxX8R+61/KjdnNAOWzzdcynrKYem5oJ2RoTZ225He7k
   O97CKZzpiC3t/1NrAvbcM0j5jBxVtEdKKDPxxnS+JOTW0jm9uG/AkTAT0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342115125"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="342115125"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 22:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="829838790"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="829838790"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2023 22:18:55 -0700
Message-ID: <fa434d32-994f-7c72-6d69-8630d6d2033f@linux.intel.com>
Date:   Tue, 4 Apr 2023 13:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux.dev,
        dmaengine@vger.kernel.org
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-2-baolu.lu@linux.intel.com>
 <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
 <cea7d7ff-bf03-eb7d-a836-b51b9addef5b@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <cea7d7ff-bf03-eb7d-a836-b51b9addef5b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/4/23 12:57 AM, Dave Jiang wrote:
> On 4/2/23 10:49 PM, Baolu Lu wrote:
>> On 3/24/23 8:02 PM, Lu Baolu wrote:
>>> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
>>> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
>>> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in 
>>> this
>>> driver.
>>>
>>> At present, missing IOPF enabling/disabling doesn't cause any real 
>>> issue,
>>> because the IOMMU driver places the IOPF enabling/disabling in the path
>>> of SVA feature handling. But this may change.
>>>
>>> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
>>> Reviewed-by: Fenghua Yu<fenghua.yu@intel.com>
>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>
>> Hi Dave and Fenghua,
>>
>> The following iommu patches depends on this one. Can I route it to
>> Linus through the iommu tree?
> 
> Hi Baolu, you'll need an ack from Vinod, who is the dmaengine subsystem 
> maintainer. I have no objections.

Hi Vinod,

Does this work work for you?

Best regards,
baolu
