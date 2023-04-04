Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4A6D6DF2
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjDDUXu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDDUXt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 16:23:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10699170F;
        Tue,  4 Apr 2023 13:23:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h25so43886128lfv.6;
        Tue, 04 Apr 2023 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639826;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONIO3Xsuk99m4ItJo+QZlE9pAbS3SFz60UJpwbYuv9E=;
        b=mSTY3ui2/XkY66nn3lsJA4XtF/pkhNouxlbyFrAfnyVZCmF1GBJaJjiu8Cz8tyONub
         WjsZwnSQgM0nu8CT/Hqxpcfo1r42e4a0HkM0FoLcfyc67zlKjjZF0Th0l/E0dIY+rCPN
         RCh8W586RZqOqv/lvKZ6PbT5D/IWRq8JLVQbbzxAJY003Fhz7jaZAkzuGkCLBeIKIPgC
         5lncCs5/C0hbhIBucR897F00ENvVCvVgIG0TevuS3urFrrQbV7WNPnbqtV0OIksK94lG
         GJXmQZI4usxYzCBOIcKGSbI7D66/TDxAnk8B92XB8xoAhHgkhIJo3Hw4/yorHy+6YbSN
         qEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639826;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONIO3Xsuk99m4ItJo+QZlE9pAbS3SFz60UJpwbYuv9E=;
        b=W535UQKffCjNkiHcgD+pK3/IKdGsAGyh3A+6jZUd9vRIT+DMuHGxxeRq+yqAcZ758d
         jzNTfcQ9W/motTRR7kGZBzTaGnjlBdUbQ0Ipd21twJa67YAMbjXmS+Z8pZbzRw34+f0D
         /xj9XK0wT7Px3nms1Xw5yyPnVTUSx92QxAx+p8CukaQKtPqL/xLyI1EZ0cOag6OvbeSg
         KZCaYGPb7zv7VJwUJlPwQMSCCwk8dfYkf0SuHndPQU5g5ckX+kZSpVWThT4zLckSeaHj
         5zry/3N53eBsL7i0nEjJN9pZ4bA5cO1+BK9R1guEHdjhmdgNahxXmmk6BAQCl8u7/M7j
         UPGg==
X-Gm-Message-State: AAQBX9e8BrovK9JOUi/eouGZ6o6gEe3XBkXKVAqmCBG6mFfiwkD0Pmls
        lmD6/eswJOgKrSanSwtjT6k=
X-Google-Smtp-Source: AKy350ZjzzZ4kQzUPxGwuZCjm8SnY7zm1ZuBhGYkgelG4LR/U4faIN60oqv7OF89rqNiASa+nGZqoQ==
X-Received: by 2002:ac2:511e:0:b0:4e8:893f:8079 with SMTP id q30-20020ac2511e000000b004e8893f8079mr989905lfb.64.1680639826138;
        Tue, 04 Apr 2023 13:23:46 -0700 (PDT)
Received: from [10.0.0.100] (host-213-145-197-218.kaisa-laajakaista.fi. [213.145.197.218])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004d3d43c7569sm2473072lfc.3.2023.04.04.13.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 13:23:45 -0700 (PDT)
Message-ID: <c3c6c922-4ab0-eef6-be87-fe5c015b2440@gmail.com>
Date:   Tue, 4 Apr 2023 23:23:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com
References: <20230404081158.1266530-1-s-vadapalli@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: do not create glue dma
 devices for udma channels
In-Reply-To: <20230404081158.1266530-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 04/04/2023 11:11, Siddharth Vadapalli wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> In case K3 DMA glue layer is using UDMA channels (AM65/J721E/J7200) it
> doesn't need to create own DMA devices per RX/TX channels as they are never
> used and just waste resources. The UDMA based platforms are coherent and
> UDMA device iteslf is used for DMA memory management.
> 
> Hence, update K3 DMA glue layer to create K3 DMA glue DMA devices per RX/TX
> channels only in case of PKTDMA (AM64) where coherency configurable per DMA
> channel.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   drivers/dma/ti/k3-udma-glue.c | 70 +++++++++++++++++------------------
>   1 file changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index 789193ed0386..b0c9572b0d02 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -293,19 +293,18 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>   	}
>   	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
>   
> -	tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
> -	tx_chn->common.chan_dev.parent = xudma_get_device(tx_chn->common.udmax);
> -	dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
> -		     tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
> -	ret = device_register(&tx_chn->common.chan_dev);
> -	if (ret) {
> -		dev_err(dev, "Channel Device registration failed %d\n", ret);
> -		put_device(&tx_chn->common.chan_dev);
> -		tx_chn->common.chan_dev.parent = NULL;
> -		goto err;
> -	}
> -
>   	if (xudma_is_pktdma(tx_chn->common.udmax)) {

it might be possible to narrow it down to include a test for atype_asel 
14 or 15, but then I would move that test to a helper (passing common as 
parameter) and re-use it in other places to avoid getting out o sync 
overtime.
Might not worth the effort, just an observation.

> +		tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
> +		tx_chn->common.chan_dev.parent = xudma_get_device(tx_chn->common.udmax);
> +		dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
> +			     tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
> +		ret = device_register(&tx_chn->common.chan_dev);
> +		if (ret) {
> +			dev_err(dev, "Channel Device registration failed %d\n", ret);

my guess is that the put_device() is still needed, no?

> +			tx_chn->common.chan_dev.parent = NULL;
> +			goto err;
> +		}
> +
>   		/* prepare the channel device as coherent */
>   		tx_chn->common.chan_dev.dma_coherent = true;
>   		dma_coerce_mask_and_coherent(&tx_chn->common.chan_dev,
> @@ -912,19 +911,18 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
>   	}
>   	rx_chn->udma_rchan_id = xudma_rchan_get_id(rx_chn->udma_rchanx);
>   
> -	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
> -	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
> -	dev_set_name(&rx_chn->common.chan_dev, "rchan%d-0x%04x",
> -		     rx_chn->udma_rchan_id, rx_chn->common.src_thread);
> -	ret = device_register(&rx_chn->common.chan_dev);
> -	if (ret) {
> -		dev_err(dev, "Channel Device registration failed %d\n", ret);
> -		put_device(&rx_chn->common.chan_dev);
> -		rx_chn->common.chan_dev.parent = NULL;
> -		goto err;
> -	}
> -
>   	if (xudma_is_pktdma(rx_chn->common.udmax)) {
> +		rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
> +		rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
> +		dev_set_name(&rx_chn->common.chan_dev, "rchan%d-0x%04x",
> +			     rx_chn->udma_rchan_id, rx_chn->common.src_thread);
> +		ret = device_register(&rx_chn->common.chan_dev);
> +		if (ret) {
> +			dev_err(dev, "Channel Device registration failed %d\n", ret);
> +			rx_chn->common.chan_dev.parent = NULL;
> +			goto err;
> +		}
> +
>   		/* prepare the channel device as coherent */
>   		rx_chn->common.chan_dev.dma_coherent = true;
>   		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
> @@ -1044,19 +1042,19 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
>   		goto err;
>   	}
>   
> -	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
> -	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
> -	dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
> -		     rx_chn->common.src_thread);
> -	ret = device_register(&rx_chn->common.chan_dev);
> -	if (ret) {
> -		dev_err(dev, "Channel Device registration failed %d\n", ret);
> -		put_device(&rx_chn->common.chan_dev);
> -		rx_chn->common.chan_dev.parent = NULL;
> -		goto err;
> -	}
> -
>   	if (xudma_is_pktdma(rx_chn->common.udmax)) {
> +		rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
> +		rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
> +		dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
> +			     rx_chn->common.src_thread);
> +
> +		ret = device_register(&rx_chn->common.chan_dev);
> +		if (ret) {
> +			dev_err(dev, "Channel Device registration failed %d\n", ret);
> +			rx_chn->common.chan_dev.parent = NULL;
> +			goto err;
> +		}
> +
>   		/* prepare the channel device as coherent */
>   		rx_chn->common.chan_dev.dma_coherent = true;
>   		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,

-- 
Péter
