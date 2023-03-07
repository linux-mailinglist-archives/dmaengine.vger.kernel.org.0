Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7246AF662
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCGUG3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 15:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjCGUG0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 15:06:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1A984E9;
        Tue,  7 Mar 2023 12:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678219585; x=1709755585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UjOcAJtcLYXXcUW2esKHdyganREeE61Jvwu1wapxcVA=;
  b=hmW2rmxvFoLeLkthgtNKizIrvhc/xjE4IXSjdFvoc1BTyjjzrpQD1wr8
   dY6aQNZc6MSCESe6j04DIX8vfgxuf4hCPbwA2UsFCSIM0xRq6lEsOSH0y
   ZPY2SXbzPY0hZIKPSsNQNUIaSeu0Yk0MSq71JXQgvd4IpkhjQh/uDhnR8
   F0U4OTrvHog/VAiGoF1jh15vh7xK2/VhbFB8yZJZzAa+jHJN3jXzmUmTZ
   w9bILnYuGYn/5BdTi6w2Uc/KAWMMYojjB+mTVu3qebfney8DniGjXfdKu
   lG3+Jg+AlRNvWl0U8AXcoAhnNgpF8NyRY8SZyOODY7NiQgP0pmiVIJsnB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334673516"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334673516"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679081551"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="679081551"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.116.173]) ([10.212.116.173])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:06:24 -0800
Message-ID: <985a0816-43ee-4e41-88f9-2ce51979aa89@intel.com>
Date:   Tue, 7 Mar 2023 13:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] dmaengine: idxd: Remove unnecessary aer.h include
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
References: <20230307192655.874008-1-helgaas@kernel.org>
 <20230307192655.874008-3-helgaas@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230307192655.874008-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/7/23 12:26 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/aer.h> is unused, so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/init.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 640d3048368e..a85efcda7095 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -9,7 +9,6 @@
>   #include <linux/delay.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/workqueue.h>
> -#include <linux/aer.h>
>   #include <linux/fs.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/device.h>
