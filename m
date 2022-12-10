Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F12648D9A
	for <lists+dmaengine@lfdr.de>; Sat, 10 Dec 2022 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLJIjO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Dec 2022 03:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJIjN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Dec 2022 03:39:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078A14D0D;
        Sat, 10 Dec 2022 00:39:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p8so10566200lfu.11;
        Sat, 10 Dec 2022 00:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aHH58yQuIbSHmYAQ1AHYeHZf/2Y0s0sE0Lw4IvH97U=;
        b=M7pyqRbl5ISPaKVWwsRmXcJ0YkPlIPy1oV47etPXIwCTW+xwzVOUwervIX0yWegIkH
         irTgs/GSKvile5dNk+KqYQ4qV+1HKL56XVegIBkkkz2sAipKpuyR92s2cqOz2Q7N8nRn
         JlYJzoSp4tM4OFxLifPxc3SWoTjmJBAAP8s3uESq/GUjfLFhaRK/+FbPH2zge38FjAQp
         iLq/+XyWU7FDWFqHaxwWF+j3312IQWEIQ5ghaP/7rvet/4PCGNbAObIZ81/prG/674FJ
         xW7obF/fxGJ7Gzid7tQj3qau9AAgp5n28BPzzcF+SO7tBLFYjEb957G7XGVPSxqN0OUF
         c6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aHH58yQuIbSHmYAQ1AHYeHZf/2Y0s0sE0Lw4IvH97U=;
        b=QPyLO6vE6fJVrw3Z7oaadTUle+nQ12dLj6K4kkoi4Avjg6C8Y0X//2iOuHcmB8cHjw
         2pm+a4nrVS+eCRMZdSLUU8rVa7GNx2rk5YpdRjzo0bODYMWusyeZAZS/KCORy+4Qv8TI
         0EjEsiVvjrmFEEVVf1LIKPdtIuH1Jrmq6pTsGlCFpNhicLyJpz0vgOiNZBCk/vSKUvml
         7VRAVKKdtQC4AYlaxCqdITE/EGiPxilWMOEtaorASFYoPMZnK+/wF52CR6bpeAuF9f6I
         mIMISbmGzvv63KDOuMrShweJfEWkjekWjCR/Yblp9aVEq0sgqriXEullc+qwvzb36eF4
         jR5g==
X-Gm-Message-State: ANoB5pmRq4sWWBj1Xn/nVllaUbERdINxDeHxtufLahYDYyb6OuUmLHCI
        pOSN5b6wDIg9v8ALImGXNzI8BmKoxo5j9Q==
X-Google-Smtp-Source: AA0mqf7zFIBp75PTRHHeP9PG5gyWkyZwE4eywEF6VVLvyGtixy2TAZLDH56h2buBf45VG7bloeSqRA==
X-Received: by 2002:a05:6512:3091:b0:4b5:a65d:9b7c with SMTP id z17-20020a056512309100b004b5a65d9b7cmr2355482lfd.21.1670661550097;
        Sat, 10 Dec 2022 00:39:10 -0800 (PST)
Received: from [10.0.0.42] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id u13-20020a05651220cd00b004a91d1b3070sm628423lfr.308.2022.12.10.00.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 00:39:09 -0800 (PST)
Message-ID: <46e1321e-ff27-7b95-6f93-975d08802626@gmail.com>
Date:   Sat, 10 Dec 2022 10:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-6-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 5/5] dmaengine: ti: k3-udma: Add support for BCDMA CSI RX
In-Reply-To: <20221206043554.1521522-6-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/6/22 06:35, Vignesh Raghavendra wrote:
> BCDMA CSI RX present on AM62Ax SoC is a dedicated DMA for servicing
> Camera Serial Interface (CSI) IP. Add support for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 19fce52a9b53..a8b497ed3f30 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -135,6 +135,7 @@ struct udma_match_data {
>  	u32 flags;
>  	u32 statictr_z_mask;
>  	u8 burst_size[3];
> +	struct udma_soc_data *soc_data;
>  };
>  
>  struct udma_soc_data {
> @@ -4295,6 +4296,25 @@ static struct udma_match_data j721e_mcu_data = {
>  	},
>  };
>  
> +static struct udma_soc_data am62a_dmss_csi_soc_data = {
> +	.oes = {
> +		.bcdma_rchan_data = 0xe00,
> +		.bcdma_rchan_ring = 0x1000,
> +	},
> +};
> +
> +static struct udma_match_data am62a_bcdma_csirx_data = {
> +	.type = DMA_TYPE_BCDMA,
> +	.psil_base = 0x3100,
> +	.enable_memcpy_support = false,
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		0, /* No H Channels */
> +		0, /* No UH Channels */
> +	},
> +	.soc_data = &am62a_dmss_csi_soc_data,
> +};
> +
>  static struct udma_match_data am64_bcdma_data = {
>  	.type = DMA_TYPE_BCDMA,
>  	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
> @@ -4344,6 +4364,10 @@ static const struct of_device_id udma_of_match[] = {
>  		.compatible = "ti,am64-dmss-pktdma",
>  		.data = &am64_pktdma_data,
>  	},
> +	{
> +		.compatible = "ti,am62a-dmss-bcdma-csirx",
> +		.data = &am62a_bcdma_csirx_data,
> +	},
>  	{ /* Sentinel */ },
>  };
>  
> @@ -5272,12 +5296,15 @@ static int udma_probe(struct platform_device *pdev)
>  	}
>  	ud->match_data = match->data;
>  
> -	soc = soc_device_match(k3_soc_devices);
> -	if (!soc) {
> -		dev_err(dev, "No compatible SoC found\n");
> -		return -ENODEV;
> +	ud->soc_data = ud->match_data->soc_data;
> +	if (!ud->soc_data) {
> +		soc = soc_device_match(k3_soc_devices);
> +		if (!soc) {
> +			dev_err(dev, "No compatible SoC found\n");
> +			return -ENODEV;
> +		}
> +		ud->soc_data = soc->data;
>  	}
> -	ud->soc_data = soc->data;

Right, the original design was based on the promise that a DMSS will
contain maximum 1 BCDMA and/or 1 PKTDMA, looks like now a DMSS have 2
BCDMAs?

The only possible issue I can see is that if in future SoCs the Output
Event Offsets got shuffled for the BCDMAs, but then a new compatible for
each SoC might just work.

Nice solution with minimal change! ;)

>  
>  	ret = udma_get_mmrs(pdev, ud);
>  	if (ret)

-- 
Péter
