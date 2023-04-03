Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F676D4E7E
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCQ5k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjDCQ5h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 12:57:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E697326B6;
        Mon,  3 Apr 2023 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680541055; x=1712077055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7UYdKObsD+8SbBqsCmRC+KpRgQ2bEtZdumWSJIQRY/Y=;
  b=MAWc0OejJudj61NVoWMPX3ZSqbNfMNd07XoeblgTiEF+AwUqspOp9ahR
   ZMpgdhgeYyhSLbSvfFo0z5e3BKa3Tdli1nJtnCnzPeJGTqiRbAjaCGE2U
   le1HI39ENyhdamJ8ZezeCaAbum1lTb5/sXRzR/Yh/6hMmOPNiEbWoa6AW
   RSZ+dA9XwdBcqxNApQKd3ytQfWq8dKcxWgj6OdVx6fLm7/hvhuF92+sH3
   OV7i96b4mshrgO8YtZZoaQAGosAyHSL1Co4ouenpFg8XUxtSV+Y9J3unI
   trWgbRSNJl0EBtIy9UeKdwx4S9dbTnW9aIrVcsgkGhGXD8oTlVY69fw9L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428244434"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="428244434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 09:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663271365"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="663271365"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.181.144]) ([10.213.181.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 09:57:34 -0700
Message-ID: <cea7d7ff-bf03-eb7d-a836-b51b9addef5b@intel.com>
Date:   Mon, 3 Apr 2023 09:57:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/6] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        dmaengine@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-2-baolu.lu@linux.intel.com>
 <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/2/23 10:49 PM, Baolu Lu wrote:
> On 3/24/23 8:02 PM, Lu Baolu wrote:
>> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
>> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
>> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
>> driver.
>>
>> At present, missing IOPF enabling/disabling doesn't cause any real issue,
>> because the IOMMU driver places the IOPF enabling/disabling in the path
>> of SVA feature handling. But this may change.
>>
>> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
>> Reviewed-by: Fenghua Yu<fenghua.yu@intel.com>
>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> 
> Hi Dave and Fenghua,
> 
> The following iommu patches depends on this one. Can I route it to
> Linus through the iommu tree?

Hi Baolu, you'll need an ack from Vinod, who is the dmaengine subsystem 
maintainer. I have no objections.


> 
> Best regards,
> baolu
