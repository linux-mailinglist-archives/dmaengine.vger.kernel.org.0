Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5105BB07E
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIPPqL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIPPqK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 11:46:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59AA7647E;
        Fri, 16 Sep 2022 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343169; x=1694879169;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=D3l66SxyUdvDZAIU+8Ob0WwZcK5UxA8UNUD0uX4GNLg=;
  b=DDA5TLibNIvbrn7IFySQE8omBhRE//fg3AWmuYEczXkm54esrj+W/WzP
   6Vd7je+yLHNBIyPpY/4oj0XD83WBH5YR8vUl8dTQrL8c23gK+UVpyCy+W
   bAQ/+ZuopQen8FMJTawXQG3CnFk9dnd8MccFBID5Z2IN4XAaLJYMa+q7h
   U7ntpAkv0b08jZBIft0Ox/wvyintH8N2hc3B/dC2FUungM2Sq78yporpY
   JXImvicUdSt7iGjZ8jEWBHoqQALPGQPR6tCMGZba318ye6hbLsp98ehsl
   XuMagdAz/7OusJ7RNu5M+aHYAUNn4ZMDzPiP/JyFhoxEApq1U9cRV4Ccr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279399977"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="279399977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743378184"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.64.121]) ([10.212.64.121])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:46:08 -0700
Message-ID: <262e809d-21e8-99ee-2245-5c28fa98afe1@intel.com>
Date:   Fri, 16 Sep 2022 08:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
Content-Language: en-US
To:     Koba Ko <koba.ko@canonical.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220830093207.951704-1-koba.ko@canonical.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220830093207.951704-1-koba.ko@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/30/2022 2:32 AM, Koba Ko wrote:
> If the passed client_count is 0,
> it would be incremented by balance_ref_count first
> then increment one more.
> This would cause client_count to 2.
>
> cat /sys/class/dma/dma0chan*/in_use
> 2
> 2
> 2
>
> Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/dmaengine.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2cfa8458b51be..78f8a9f3ad825 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
>   	/* The channel is already in use, update client count */
>   	if (chan->client_count) {
>   		__module_get(owner);
> -		goto out;
> +		chan->client_count++;
> +		return 0;
>   	}
>   
>   	if (!try_module_get(owner))
> @@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
>   			goto err_out;
>   	}
>   
> +	chan->client_count++;
> +
>   	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
>   		balance_ref_count(chan);
>   
> -out:
> -	chan->client_count++;
>   	return 0;
>   
>   err_out:
