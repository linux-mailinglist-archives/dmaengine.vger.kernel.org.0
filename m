Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817435EAF3A
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIZSIm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIZSIF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:08:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCC286F2;
        Mon, 26 Sep 2022 10:53:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j16so12110996lfg.1;
        Mon, 26 Sep 2022 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rx6S5GyWtbkwCUObHi8ZQPV3HDLXobFD9FeixNTjARs=;
        b=RP7MljUqd6fIy+V/RnOUO3fvJqC/3zA3HusG/tXyxZrcOkyHiD29FwhIf+sj/ACjqj
         m+gZrYUtY94qH+qtWZCwxfloVWFS4Pm6NewC2VvM9HjW3+DSAt53PRzJXh7+M37fsM54
         BJ+kDjLpBLUtt0Xk4byXuP3hFAg2G48PYFGlPOrWfO/tibkGldSghS/cDn8/3D/lj0sR
         mASdUerplEAgtbur6Ki6WkrQp87tWp+2K9k0v2HXd7iSXQnu0JHg4xK335h8Oo4Zho2I
         QgHqAFWh55DxI8GpmG6D0ETpzt7F1p5J2bN98yEOf0gw/pX9UMirzIJ4WLysIv8yPV6h
         zlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rx6S5GyWtbkwCUObHi8ZQPV3HDLXobFD9FeixNTjARs=;
        b=Z5Vbbnk4kPQVc//dAkJIvH54q/rIJ5TC9wZrQkYxrN3hhSSV6l/1ZWZ2WbBz7AKb/X
         M5r63e1OYWyuimPIy80Nhnb0hMNr8OTSyXP39wZkibIvka4FP7c8wRgDLKmwEHBIaTm6
         UQfQ2qrFW7WdEKWD0oE5WxuuRlkVQqUbV7A7IAYQC3E4bOPTDTXQVi0qAOX/dRclVqbN
         K7D+0LTUBE+lELMQDN+Xa6JTpAq7B64Iw/URLbAKeqnJlWYxSyaFtJVPV/fD/MlrMiLm
         i1qPhJU6XNhHS2UK3bZjtiMzsl834Aiw10UUFHAjfxFIj3DFL/sc+W0vMvwUL3Hbg5y3
         xOCA==
X-Gm-Message-State: ACrzQf3imfU0+jht6Af2qVx7AEwYtOz4Ke8FlmPEs9lqruvH+dIbj9Am
        NG8QyP3NOTTiFO3ycXl8pmUafpiXy7+HsQ==
X-Google-Smtp-Source: AMsMyM5VUVQj2tG4gnCtQ4VVMjtILE21s2WA3/NIKBjH/aY4X02nRiyExJvXYCeaATSfZVMDufke/w==
X-Received: by 2002:a05:6512:b86:b0:498:fe61:d2a8 with SMTP id b6-20020a0565120b8600b00498fe61d2a8mr9580909lfv.437.1664214808794;
        Mon, 26 Sep 2022 10:53:28 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id 8-20020a2e0508000000b00268cfcf841asm2437609ljf.56.2022.09.26.10.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:53:28 -0700 (PDT)
Message-ID: <d5acf81b-cdeb-2686-927b-4cae4b32cea9@gmail.com>
Date:   Mon, 26 Sep 2022 21:02:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] Documentation: devicetree: dma: update the comments
Content-Language: en-US
To:     Deming Wang <wangdeming@inspur.com>, vkoul@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220920020721.2190-1-wangdeming@inspur.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220920020721.2190-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/20/22 05:07, Deming Wang wrote:
> remove the double word to.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> index b849a1ed389d..47e477cce6d2 100644
> --- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> @@ -4,7 +4,7 @@ Required properties:
>  - compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
>  		"ti,am335x-edma-crossbar" for AM335x and AM437x
>  - reg:		Memory map for accessing module
> -- #dma-cells:	Should be set to to match with the DMA controller's dma-cells
> +- #dma-cells:	Should be set to match with the DMA controller's dma-cells
>  		for ti,dra7-dma-crossbar and <3> for ti,am335x-edma-crossbar.
>  - dma-requests:	Number of DMA requests the crossbar can receive
>  - dma-masters:	phandle pointing to the DMA controller

-- 
Péter
