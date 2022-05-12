Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A152532C
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbiELRFZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356824AbiELRFY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 13:05:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07114269EE4;
        Thu, 12 May 2022 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652375122; x=1683911122;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6xFxG7MLoudi9o64Lr4POIQA3LoUtodJPfElK3mM7f0=;
  b=mFy0kQCYN9R4A9RXFXzact5Pzvtnzdrld6Av2LQAItp1TJf0qNMjvetP
   9DLjb+ZKKEUWxjt0UHSOkfjXCmaOp0ZvJNX0PwBCt1iYWtdi1rbaNz1dD
   VDB2XnDkRbL5xezV9LxxGDuwxdJ558UJPgjHvKQxf9dVxv9f/Fh7PV24J
   QbHQzvRDbtuzL/L+25ucaOne7AJGsVoHXpGrrQzHvi4A0fTVzqN8qlGjJ
   HVCwLKOHNTGSMOkhlGS6+k7Si8XVZGGZXk/0R7OlIDv5gBFSo2ZJHcUdi
   9iXaFGJfSTNp3AwQdFJbaouCWK0LXHlZQglS08v4IotYBl0TSkGaLLPOc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269741443"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="269741443"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:03:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="521038993"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.68.97]) ([10.212.68.97])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:03:48 -0700
Message-ID: <d1017a7a-4f3d-4218-13da-71f89cf81c81@intel.com>
Date:   Thu, 12 May 2022 10:03:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dmaengine: ti: Fix refcount leak in
 ti_dra7_xbar_route_allocate
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512051815.11946-1-linmq006@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220512051815.11946-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/11/2022 10:18 PM, Miaoqian Lin wrote:
> 1. of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> 2. of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not needed anymore.
>
> Add put_device() and of_node_put() in some error paths to fix.
Sounds like you need 2 patches for this? One just for the put_device() 
and the other for the of_node_put()?
>
> Fixes: ec9bfa1e1a79 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
> Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/dma/ti/dma-crossbar.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index 71d24fc07c00..f744ddbbbad7 100644
> --- a/drivers/dma/ti/dma-crossbar.c
> +++ b/drivers/dma/ti/dma-crossbar.c
> @@ -245,6 +245,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>   	if (dma_spec->args[0] >= xbar->xbar_requests) {
>   		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
>   			dma_spec->args[0]);
> +		put_device(&pdev->dev);
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> @@ -252,12 +253,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>   	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>   	if (!dma_spec->np) {
>   		dev_err(&pdev->dev, "Can't get DMA master\n");
> +		put_device(&pdev->dev);
>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	map = kzalloc(sizeof(*map), GFP_KERNEL);
>   	if (!map) {
>   		of_node_put(dma_spec->np);
> +		put_device(&pdev->dev);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> @@ -268,6 +271,8 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>   		mutex_unlock(&xbar->mutex);
>   		dev_err(&pdev->dev, "Run out of free DMA requests\n");
>   		kfree(map);
> +		of_node_put(dma_spec->np);
> +		put_device(&pdev->dev);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   	set_bit(map->xbar_out, xbar->dma_inuse);
