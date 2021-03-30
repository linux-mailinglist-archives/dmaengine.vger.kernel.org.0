Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDE34ED1D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhC3QFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 12:05:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:2604 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231928AbhC3QFV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Mar 2021 12:05:21 -0400
IronPort-SDR: 4ZtCD2rwaNCVA0YoOClamqIaZ9y6spldNQcvaTuCFMKYcwGogW/XNw06zRYA6qtOvJafyX01w1
 /RXUMXcxYNqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179338252"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179338252"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 09:05:18 -0700
IronPort-SDR: DVGtRPaN9ETArW4C0/T/tA9GKqtY6BSo1LWZBFiECcgEkGp7Ca0qR5hI5F/Up0gI7CD2HHhFpf
 5TSE4MIORYlA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="376886416"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.11]) ([10.209.140.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 09:05:16 -0700
Subject: Re: [PATCH] dma: Fix a double free in dma_async_device_register
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210330090149.13476-1-lyl2019@mail.ustc.edu.cn>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f4ce9e2a-6bb9-d3ae-3583-2d29e09aa3a3@intel.com>
Date:   Tue, 30 Mar 2021 09:05:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330090149.13476-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/30/2021 2:01 AM, Lv Yunlong wrote:
> In the first list_for_each_entry() macro of dma_async_device_register,
> it gets the chan from list and calls __dma_async_device_channel_register
> (..,chan). We can see that chan->local is allocated by alloc_percpu() and
> it is freed chan->local by free_percpu(chan->local) when
> __dma_async_device_channel_register() failed.
>
> But after __dma_async_device_channel_register() failed, the caller will
> goto err_out and freed the chan->local in the second time by free_percpu().
>
> The cause of this problem is forget to set chan->local to NULL when
> chan->local was freed in __dma_async_device_channel_register(). My
> patch sets chan->local to NULL when the callee failed to avoid double free.

Thanks for the fix. I think it would make sense to set it to NULL in 
__dma_async_device_channel_register() cleanup path after it calls 
free_percpu(chan->local) right? That would address any other instances 
of this issue happening else where.


>
> Fixes: d2fb0a0438384 ("dmaengine: break out channel registration")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/dma/dmaengine.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index fe6a460c4373..fef64b198c95 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1249,8 +1249,10 @@ int dma_async_device_register(struct dma_device *device)
>   	/* represent channels in sysfs. Probably want devs too */
>   	list_for_each_entry(chan, &device->channels, device_node) {
>   		rc = __dma_async_device_channel_register(device, chan);
> -		if (rc < 0)
> +		if (rc < 0) {
> +			chan->local = NULL;
>   			goto err_out;
> +		}
>   	}
>   
>   	mutex_lock(&dma_list_mutex);
