Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD2650467
	for <lists+dmaengine@lfdr.de>; Sun, 18 Dec 2022 19:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLRSqc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Dec 2022 13:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRSqb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Dec 2022 13:46:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23822737
        for <dmaengine@vger.kernel.org>; Sun, 18 Dec 2022 10:46:29 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f16so7095052ljc.8
        for <dmaengine@vger.kernel.org>; Sun, 18 Dec 2022 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvafVT7bzqLSaMJQVa90FsYGeGOXWDvs6W/HEGR+fbQ=;
        b=zcaHQsR5ve7lGd/uLYjvoDAsCf10WyMagJ8CCphvy76T9DCcxPwGVVvHlNaZUTT5/A
         5S3fIp9rNWagGQEm2fhosyQHO9xSFyc5CoqEhSyE8DGSd7QdC59jiS1a/+G5bSdxGsDZ
         iYHcGKABuuVnk9ZUPERihhgYrYGXAypF8z+am19HJsCryehb2gZcfH2n8G9txQIk3vF7
         bnSD+JWHN8oT6VN/jv+KOXt+HytVvK46NYIJ4gRIA2msM/MjchNhZ4lx6nZNmmpsvlf3
         Zfc2CMIQpdbA0kpHJoTLUwtMd3v50CkQ1goHs0zFmS9wH1VDUOJACEGg9S/IkrhfGReM
         F1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvafVT7bzqLSaMJQVa90FsYGeGOXWDvs6W/HEGR+fbQ=;
        b=Bn3AODesmiqBqmxm1ZBQh46DRLHbUR2XdQLAnIRmldraQu4RUFu+LNSJlxtRmllzdM
         DUDbKk4MkOX/34x7Zccvx5aopTpsLRWH2hy2sSnpZXp5tolNwf2cen6IqxBDiio7njrl
         sOZhbjLrc0FXj/o4cfbwU/LZ2JBbnpNN5dC0a/qVlvrVgVmnWQsbxQ4tYh5RHNGqbxFR
         kYme6Ud/8cAJz3nt/Taq1IQTRYxJ6FOhnQqh/tXMtuThIf8uoTc46qXyiyOj4/IN29eY
         z1XeS7OocBd11FcRpzrBNyR7v4I/lKPJ322lNBg/ecMxLCy8SkxKdf/dQcQNxVxjnMOi
         qjOA==
X-Gm-Message-State: AFqh2kp2bX/rDrFIoHxdH794S7YmPiLXgtYYFM3AtZ9noteD3SJiCgs/
        NEEkEDy1/vitm/NuoYQh7cD9Nw==
X-Google-Smtp-Source: AMrXdXvahmz0XgV17v+KLVhrIdi95MLfM36IPB6RL/Rqst5Az4SXyFjQkMMapAmvV5Y0nWFi14K1XA==
X-Received: by 2002:a05:651c:1c4:b0:27f:2aac:c4 with SMTP id d4-20020a05651c01c400b0027f2aac00c4mr4767233ljn.34.1671389187823;
        Sun, 18 Dec 2022 10:46:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05651c231a00b0027a2a26a655sm606764ljb.8.2022.12.18.10.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Dec 2022 10:46:27 -0800 (PST)
Message-ID: <a5bb28a7-c7d3-be98-9621-996d38656d98@linaro.org>
Date:   Sun, 18 Dec 2022 19:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221217010724.632088-1-marex@denx.de>
 <b74776b4-0885-f519-8ef7-e01048a8be15@linaro.org>
 <ba05612d-fd3b-3e49-4ada-21f3b3c74e23@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba05612d-fd3b-3e49-4ada-21f3b3c74e23@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/12/2022 00:12, Marek Vasut wrote:
> On 12/17/22 12:05, Krzysztof Kozlowski wrote:
> 
> [...]
> 
>>> +allOf:
>>> +  - $ref: dma-controller.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          not:
>>
>> I think "not:" goes just after "if:". Please double check that it's correct.
>>
>> Anyway it is easier to have this without negation and you already
>> enumerate all variants (here and below).
> 
> About this part, I don't think that works. See this:
> 
> $ git grep -A 15 'imx2[38]-dma-apb[hx]' arch/ | grep 
> '\(imx2[38]-dma-apb[hx]\|dma-channels\)'
> arch/arm/boot/dts/imx23.dtsi: compatible = "fsl,imx23-dma-apbh";
> arch/arm/boot/dts/imx23.dtsi- dma-channels = <8>;
> arch/arm/boot/dts/imx23.dtsi: compatible = "fsl,imx23-dma-apbx";
> arch/arm/boot/dts/imx23.dtsi- dma-channels = <16>;
> arch/arm/boot/dts/imx28.dtsi: compatible = "fsl,imx28-dma-apbh";
> arch/arm/boot/dts/imx28.dtsi- dma-channels = <16>;
> arch/arm/boot/dts/imx28.dtsi: compatible = "fsl,imx28-dma-apbx";
> arch/arm/boot/dts/imx28.dtsi- dma-channels = <16>;
> arch/arm/boot/dts/imx6qdl.dtsi: compatible = "fsl,imx6q-dma-apbh", 
> "fsl,imx28-dma-apbh";
> arch/arm/boot/dts/imx6qdl.dtsi- dma-channels = <4>;
> arch/arm/boot/dts/imx6sx.dtsi: compatible = "fsl,imx6sx-dma-apbh", 
> "fsl,imx28-dma-apbh";
> arch/arm/boot/dts/imx6sx.dtsi- dma-channels = <4>;
> arch/arm/boot/dts/imx6ul.dtsi: compatible = "fsl,imx6q-dma-apbh", 
> "fsl,imx28-dma-apbh";
> arch/arm/boot/dts/imx6ul.dtsi- dma-channels = <4>;
> arch/arm/boot/dts/imx7s.dtsi: compatible = "fsl,imx7d-dma-apbh", 
> "fsl,imx28-dma-apbh";
> arch/arm/boot/dts/imx7s.dtsi- dma-channels = <4>;
> arch/arm64/boot/dts/freescale/imx8mm.dtsi: compatible = 
> "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
> arch/arm64/boot/dts/freescale/imx8mm.dtsi- dma-channels = <4>;
> arch/arm64/boot/dts/freescale/imx8mn.dtsi: compatible = 
> "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
> arch/arm64/boot/dts/freescale/imx8mn.dtsi- dma-channels = <4>;
> 
> So I think what we have to do to validate that, is, say
> 
> default: 4
> 
> if does not match on 6q/6sx/7d/23-apbx/28-abbh/28-apbx then 8
> 
> if does not match on 6q/6sx/7d/23-apbh then 16
> 
> But if there is a better way to validate the above, please do tell.

Then your existing if:then: is also not correct because you require for
fsl,imx28-dma-apbh (as it is not in second if:then:) const:16. Just
don't require it.

Best regards,
Krzysztof

