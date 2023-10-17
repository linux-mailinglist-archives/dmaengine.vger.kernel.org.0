Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB57CCAAF
	for <lists+dmaengine@lfdr.de>; Tue, 17 Oct 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbjJQSdc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Oct 2023 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbjJQSdc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Oct 2023 14:33:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C919F
        for <dmaengine@vger.kernel.org>; Tue, 17 Oct 2023 11:33:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-777506c6109so282209185a.3
        for <dmaengine@vger.kernel.org>; Tue, 17 Oct 2023 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1697567609; x=1698172409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcBNvDPm+5lurRZbHk0V2IeK1x1A6vL27sfb3JeZGgA=;
        b=htptCsKqExIqBn7UboDsXmhXZjDi4kbkTB8Mqkbk3HHeEgQPSdrql5rBR0n35IkrbH
         tYuouYgaaeRI5i5oi1iocSykHEXE04BX2zcOG2frTPHEIkwtCUGQEd85JiXwiFyQlhov
         IldEqSGJBtcT/FNWhsab59VzV8/R2r9zzaqyuP7ZkmbTbCWMuOUwKsx9pXDFb8l8YwKi
         183gLWSFCuiYhtUeS++gmuPRJsbcmxskQY8S7l7ohGaWlPkWB+oxw68oTiKg3QoF2akf
         LdIFpBml7LINw1SCFmBcgs/l53eZ3wEaybuMd2HaaVNBMVO0ZmfchK8+ZUProIUaQrCI
         v3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567609; x=1698172409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcBNvDPm+5lurRZbHk0V2IeK1x1A6vL27sfb3JeZGgA=;
        b=hh6AXOaYqdehshUn6IwkF40qlqgukzGZzBLbijmD2EhO4pS2NJNzZU23y+FwMdh0u8
         viLMPIThl1CDMo+8pnfY4lewiLc4BTcCTdmKBtjBaFuBZpSUN9Bf7MEjsGzWbeNKOXcE
         AdIP4sMJ1/Un+d1dqgwSAzBpo0c27Q0JpwCHSC6gA7MTJaqigO5l/svQajp//PfO9wzH
         +ZMW15GA70D4JBO6iXx0ScflCgjnXA3aYXzo5hUZm4AIJbYpyABcoeRq+FBEg/7RSExv
         c7hhCK5Pprqiysd/myB2LjVs5pzbcsS57Zu9VcBGmyz+tkJIH9Vb8rrO0qY1ylqKjqaK
         RVcA==
X-Gm-Message-State: AOJu0Yz928fc1JvmywAJGR/90qyyY2e9IlB15NQoual2S/80L9lQy5KM
        14Q4m5f4HVjzxHlOID3MAFCGkQ==
X-Google-Smtp-Source: AGHT+IEhq81kqSuzy5uDqP7PO49OdWiRqBLX172oxXpXHG/RYxZodn51GvnKH+ECpR7nbBAhO+94Bg==
X-Received: by 2002:a05:620a:1229:b0:76d:ada0:4c0 with SMTP id v9-20020a05620a122900b0076dada004c0mr2765787qkj.76.1697567608779;
        Tue, 17 Oct 2023 11:33:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:95cc:ccc5:95bc:7d2c? ([2600:1700:2000:b002:95cc:ccc5:95bc:7d2c])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a12f600b00765aa3ffa07sm866623qkl.98.2023.10.17.11.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:33:28 -0700 (PDT)
Message-ID: <e5d2e96b-9b16-4aaf-9291-76d1d2222c44@sifive.com>
Date:   Tue, 17 Oct 2023 13:33:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dmaengine: sf-pdma: Support
 of_dma_controller_register()
Content-Language: en-US
To:     shravan chippa <shravan.chippa@microchip.com>,
        green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-2-shravan.chippa@microchip.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231003042215.142678-2-shravan.chippa@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 2023-10-02 11:22 PM, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Update sf-pdma driver to adopt generic DMA device tree bindings.
> It calls of_dma_controller_register() with sf-pdma specific
> of_dma_xlate to get the generic DMA device tree helper support
> and the DMA clients can look up the sf-pdma controller using
> standard APIs.
> 
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 44 +++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index d1c6956af452..06a0912a12a1 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_dma.h>
>  #include <linux/slab.h>
>  
>  #include "sf-pdma.h"
> @@ -490,6 +491,33 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>  	}
>  }
>  
> +static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct sf_pdma *pdma = ofdma->of_dma_data;
> +	struct device *dev = pdma->dma_dev.dev;
> +	struct sf_pdma_chan  *chan;
> +	struct dma_chan *c;
> +	u32 channel_id;
> +
> +	if (dma_spec->args_count != 1) {
> +		dev_err(dev, "Bad number of cells\n");
> +		return NULL;
> +	}
> +
> +	channel_id = dma_spec->args[0];
> +
> +	chan = &pdma->chans[channel_id];
> +
> +	c = dma_get_slave_channel(&chan->vchan.chan);

This does not look right to me. All of the channels in the controller are
identical and support arbitrary addresses, so there is no need to use a specific
physical channel. And unless Microchip has added something on top, the only way
to trigger a transfer is through the MMIO interface, so there is no request ID
to differentiate virtual channels either.

So it seems to me that #dma-cells should really be 0, and this function should
just call dma_get_any_slave_channel().

Regards,
Samuel

> +	if (!c) {
> +		dev_err(dev, "No more channels available\n");
> +		return NULL;
> +	}
> +
> +	return c;
> +}
> +
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
>  	struct sf_pdma *pdma;
> @@ -563,7 +591,20 @@ static int sf_pdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 sf_pdma_of_xlate, pdma);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Can't register SiFive Platform OF_DMA. (%d)\n", ret);
> +		goto err_unregister;
> +	}
> +
>  	return 0;
> +
> +err_unregister:
> +	dma_async_device_unregister(&pdma->dma_dev);
> +
> +	return ret;
>  }
>  
>  static int sf_pdma_remove(struct platform_device *pdev)
> @@ -583,6 +624,9 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  		tasklet_kill(&ch->err_tasklet);
>  	}
>  
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
> +
>  	dma_async_device_unregister(&pdma->dma_dev);
>  
>  	return 0;

