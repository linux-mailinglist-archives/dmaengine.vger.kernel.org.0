Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9937C597327
	for <lists+dmaengine@lfdr.de>; Wed, 17 Aug 2022 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiHQPcC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Aug 2022 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiHQPb7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Aug 2022 11:31:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C539F0E5
        for <dmaengine@vger.kernel.org>; Wed, 17 Aug 2022 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660750312; x=1692286312;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PVBDiy05s1bN8yIdYqgEPr7UOoRYx3786Qajxlk/WK8=;
  b=IzuOwP6434i/bIm4pMscRrl++C2Z9EciUps46FHniu0VnZramO4kF8vd
   /NaB0PTbQmgKp5PddsjlIMIAF/e9jWlaTWrUeWFeJPHRN5r6zpRxmYXnQ
   7BefBDD495sVpOUlOfI8EiYPiqI+TM/+jVFRLYWi2GLha04etcz5XM7xn
   Fc8ALEOx874/mAAhsXNl3UbaJ07b6jU2SlwXYjs98a/2RsBpEr4vkREal
   keOEdECXxnj7p0n9vkzLxMpCpVhtNUiWKdYgQY1IFcMQ1ncpdRTKr/EZm
   xGQ/d8xPoeBInkpYdGXkaIlz8VQhIcbWSfn0OnLyrCmM6j/FIketjKAaK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="272290173"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="272290173"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 08:27:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="640496038"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.169.70]) ([10.213.169.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 08:27:22 -0700
Message-ID: <13e34bba-18ea-f0df-aa19-b3e6d55fefcc@intel.com>
Date:   Wed, 17 Aug 2022 08:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: Question about DMA devices and md raid
Content-Language: en-US
To:     Don.Brace@microchip.com, dmaengine@vger.kernel.org
References: <CY4PR11MB12387FCD3E0D939CBC89E2E0E16A9@CY4PR11MB1238.namprd11.prod.outlook.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CY4PR11MB12387FCD3E0D939CBC89E2E0E16A9@CY4PR11MB1238.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/17/2022 8:14 AM, Don.Brace@microchip.com wrote:
> I have created an md raid6 device and added crypto.
>
> I have also enabled the ioat driver. (ioatdma)

Don, I've answer your question previously [1]. The ioatdma driver no 
longer supports XOR/PQ offload so you are not going to get that support. 
And also the Cascade Lake platform you are using does not officially 
support that in hardware either. If you really want to try it, you'll 
need to find a pre-Skylake Xeon machine and run it on a 4.x kernel.

[1]: 
https://lore.kernel.org/dmaengine/725501fb-f559-2825-1533-4aca8177d87d@intel.com/


>
> The flow seems to be md/raid5:async_xor_offs() -> crypto/async_tx/async_xor.c:async_xor_off()
>
> Here it attempts to obtain a dma_chan and dma device, but they are always NULL.
>
> Some added debug messages.
>              async_xor_offs: async_xor - Starting called async_tx_find_channel chan=0000000000000000 device=0000000000000000
>
> So, can the md driver utilize a DMA engine? I believe the answer is yes, but I am missing some setup steps?
>
> I can get the dmatest driver to interface successfully.
>
> I may not know enough about how this works to ask proper questions...
>
> Thanks,
> Don Brace
