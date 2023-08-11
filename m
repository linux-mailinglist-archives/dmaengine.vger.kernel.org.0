Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85AD779261
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHKPFq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHKPFq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 11:05:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841392;
        Fri, 11 Aug 2023 08:05:45 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso33434701fa.1;
        Fri, 11 Aug 2023 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691766344; x=1692371144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZoMW6+8stHgDctizPcyNfxHPwewP2eRkfb7q++g4D0=;
        b=EUeoGyX98jF4cvj/6/GMoY1333qFduNybKnaCYByQGGA9+3GAGxg8/CkaEOS+HIqQv
         uTnGVHYHd/aZixXkgj15b7L/V+nu3Qx5DjplfdnzajWWE024I2VoABPMD4iJwwq6wI54
         ASCZ1yA+sgkjmoFI/E4BCScXlR4Votx72x3sbIQJ4Vp5wxMVPDXBOqCfW/jdbujH2Lic
         G7s0j41peqR0ozqr1CsccFY5YByWiWiOtv96j8Psu42ghSMQqayJOk3QMvnmzVADAuT/
         w0MyyE9aLvbDev2z0qeGqyv+hTPhkfW4a8/nOvU8oTS7Ounj85RiPF3FucOHyjwdGGx9
         2tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766344; x=1692371144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZoMW6+8stHgDctizPcyNfxHPwewP2eRkfb7q++g4D0=;
        b=ACZNMe9beTgQrr8I5pDAChqZhwIrGc83MfN7fGrqUWep+BHGTjWbVE6QevCwhgSnr6
         wgdGwpnTDygyOaOVWEChxy0LcOrRRxzd042FaQgKz8klt8S0oCURgg3kTn+mCSeMVLwx
         McJ5XGfytn0YYzQ0PCCZrFhY90akGN0wvEcI+1r0uJ2lzZJMCCaFWzptJn+YUgL5IvQ6
         1qrRDHMytHZlrusfTX2WgrZivMSHkDHcgwDwv9TY63lX+QtWAOwmK9xvAgCwRLvvSp/O
         XAA479bbnDpUhXFGQoA4nftgA6eJC2KvpwUHe2EoFIFd3wl5uur6t7W30EYqKye7gQpP
         0rcQ==
X-Gm-Message-State: AOJu0YxABIpLUTCp5cBC5z4gAnTt7++vP5oh26zGkbb9ADn6fdnc0bI2
        v0nqAQwm2i1NctpIjCR0lZcgE7KucwRq6A==
X-Google-Smtp-Source: AGHT+IElTv40XFb2YVoF+wbOX9yz3VzSsk2o9Wk276+ad07U2SjtbCN/UAS8AeX738FeNKYxGPVN4Q==
X-Received: by 2002:a2e:87cc:0:b0:2b5:80e0:f18e with SMTP id v12-20020a2e87cc000000b002b580e0f18emr1976674ljj.3.1691766343555;
        Fri, 11 Aug 2023 08:05:43 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id j21-20020a2e8015000000b002b83dbc71c9sm910495ljg.54.2023.08.11.08.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:05:43 -0700 (PDT)
Message-ID: <5b0b1366-0a77-4e27-8b9c-b5ec26817550@gmail.com>
Date:   Fri, 11 Aug 2023 18:07:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] dmaengine: ti: k3-udma: Remove unused declarations
To:     Yue Haibing <yuehaibing@huawei.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811123209.45800-1-yuehaibing@huawei.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230811123209.45800-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/08/2023 15:32, Yue Haibing wrote:
> Commit d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
> declared but never implemented these.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/dma/ti/k3-udma.h         | 1 -
>   include/linux/dma/k3-udma-glue.h | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index d349c6d482ae..9062a237cd16 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -131,7 +131,6 @@ int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
>   struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property);
>   struct device *xudma_get_device(struct udma_dev *ud);
>   struct k3_ringacc *xudma_get_ringacc(struct udma_dev *ud);
> -void xudma_dev_put(struct udma_dev *ud);
>   u32 xudma_dev_get_psil_base(struct udma_dev *ud);
>   struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud);
>   
> diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
> index e443be4d3b4b..57d6e7e1e091 100644
> --- a/include/linux/dma/k3-udma-glue.h
> +++ b/include/linux/dma/k3-udma-glue.h
> @@ -126,8 +126,6 @@ u32 k3_udma_glue_rx_flow_get_fdq_id(struct k3_udma_glue_rx_channel *rx_chn,
>   u32 k3_udma_glue_rx_get_flow_id_base(struct k3_udma_glue_rx_channel *rx_chn);
>   int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
>   			    u32 flow_num);
> -void k3_udma_glue_rx_put_irq(struct k3_udma_glue_rx_channel *rx_chn,
> -			     u32 flow_num);
>   void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
>   		u32 flow_num, void *data,
>   		void (*cleanup)(void *data, dma_addr_t desc_dma),

-- 
Péter
