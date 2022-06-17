Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8645B54EF7B
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jun 2022 05:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiFQCsl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 22:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQCsk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 22:48:40 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521464D0B
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 19:48:39 -0700 (PDT)
Received: from [192.168.0.109] (unknown [123.112.64.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1DA2C41624;
        Fri, 17 Jun 2022 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655434118;
        bh=HTqXHz6GkB+YtCHIR+HMjRtZVlZiBa7737VLdNNigwU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Lmm24YBJwdRqwFXm0v5id3bTYuI/JNQXbLjbfCn903uG+CFM/AteWg7NSUDbzZD4P
         XBdhTcF30dHdbUH51S+mRZtdzVTuvk/n4uxVA2+AeEcOWtlb9AjZMg67Uo/u58FrLl
         SzwNYVagV8IqeAFIXW66tHSHSkfcbKhYx+lfhDXljZq2W9E2pdI5fIdM+69UDULJiy
         17qGADDjmkwqt1a5jTfKXH/XMox/2Ex5PwG9KCj5RitnqxlL5SbodoS5MjMZq2aPyY
         WYwjuuUOZl/4Zn+ZibuJPQlVqEXecvs/2FZy99B/uje9ruqIDOJmE7dx9umm+j3C7K
         TQ/pMH2zWMUpQ==
Message-ID: <48b9ef4e-fba1-58b0-d022-f52aa5993eab@canonical.com>
Date:   Fri, 17 Jun 2022 10:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: imx-sdma: Setting DMA_PRIVATE capability
 during the probe
Content-Language: en-US
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     s.hauer@pengutronix.de, shawnguo@kernel.org, hui.wang@canonical.com
References: <20220524074933.38413-1-hui.wang@canonical.com>
From:   Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20220524074933.38413-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sorry, re-send the mail since the previous one contains the 
html-subparts, it is banned by dmaengine mailist.


Hi vkoul, hauer and shawnguo,

Could you take a look at this patch and the problem the patch plans to fix?

It is easy to reproduce the problem on i.mx platforms, just enabling the 
IMX_SDMA, ASYNC_CORE and ASYNC_TX_DMA as below:

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_RAID456=y

CONFIG_IMX_SDMA=y

CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

And this is the .config of the kernel which could reproduce the problem:

https://pastebin.ubuntu.com/p/5Pb3JzrWJZ/


And this is the dmesg of v5.19-rc2 on an i.mx6 platform, we could see 
audio driver fails because of dma allocation:

https://pastebin.ubuntu.com/p/rz7jsXgyJJ/

[    5.779584] fsl-ssi-dai 202c000.ssi: Missing dma channel for stream: 0
[    5.779601] fsl-ssi-dai 202c000.ssi: ASoC: error at 
snd_soc_pcm_component_new on 202c000.ssi: -22
[    5.779616] fsl-asoc-card sound-nau8822: ASoC: can't create pcm HiFi :-22
[    5.784479] fsl-asoc-card sound-nau8822: error -EINVAL: 
snd_soc_register_card failed
[    5.784501] fsl-asoc-card: probe of sound-nau8822 failed with error -22

And this problem also could be reproduced on i.mx8 platforms, If needing 
me to provide log for i.mx8, let me know.

Thanks,

On 5/24/22 15:49, Hui Wang wrote:
> We have an imx6sx EVB, the audio driver fails to get a valid dma chan
> and the audio can't work at all on this board, below is the error log:
>   fsl-ssi-dai 202c000.ssi: Missing dma channel for stream: 0
>   202c000.ssi-nau8822-hifi: ASoC: pcm constructor failed: -22
>   asoc-simple-card sound: ASoC: can't create pcm 202c000.ssi-nau8822-hifi :-22
>
> Then I checked the usage_count of each dma chan through sysfs, all
> channels are occupied as below:
> ubuntu@ubuntu:cd /sys/devices/platform/soc/2000000.bus/20ec000.sdma/dma
> ubuntu@ubuntu:find . -iname in_use | xargs cat
> 2
> 2
> 2
> ...
>
> Through debugging, we found the root cause, the
> crypo/async_tx/async_tx.c calls the dmaengine_get() ahead of
> registration of dma_device from imx-sdma.c. In the dmaengine_get(), the
> dmaengine_ref_count will be increased, then in the
> dma_async_device_register(), the client_count of each chan will be
> increased.
>
> To fix this issue, we could set DMA_PRIVATE to the dma_deivce before
> registration.
>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   drivers/dma/imx-sdma.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 95367a8a81a5..aabe8a8069fb 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2201,6 +2201,7 @@ static int sdma_probe(struct platform_device *pdev)
>   	for (i = 0; i < sizeof(*sdma->script_addrs) / sizeof(s32); i++)
>   		saddr_arr[i] = -EINVAL;
>   
> +	dma_cap_set(DMA_PRIVATE, sdma->dma_device.cap_mask);
>   	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
>   	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
>   	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
