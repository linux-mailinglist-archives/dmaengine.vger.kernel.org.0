Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429369F11F
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 10:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjBVJRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Feb 2023 04:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBVJRi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Feb 2023 04:17:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C636FEA
        for <dmaengine@vger.kernel.org>; Wed, 22 Feb 2023 01:17:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f13so27016852edz.6
        for <dmaengine@vger.kernel.org>; Wed, 22 Feb 2023 01:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYNjYpqa0bbdp+1kEQD5S997SVtcSN1lChO27iPiDpw=;
        b=TtNO99vDyF+FOnem7oAHDn6G30PaKs+x4inAVoGOhs7iEdKofnLJfFq/AkS8dPiEwx
         /PkhPY4UXDKdVYirGGfovlv5KC+4uNDt8VlWMt8t28weTC2EwAACd1RRywYBV+dIEM6n
         9ZzSCRJsx+pZfNOh1Q9JysagGFcfD619jHXGFC6gPZU6+udyEAM+vA45x74asaho3lRy
         20tcPipMSNmQ9b6PftCcoMC9rqL5/JMAuffUr2g3l2URHjozHwBM+NcqlP1f6zNHOEXr
         TUZGXy+2yhIR8C3ryg3A/WVW3XEIyCeUKxhLqQ62iKpRdLBLOgNkcF9L4ZOjmUE3aZjm
         NcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYNjYpqa0bbdp+1kEQD5S997SVtcSN1lChO27iPiDpw=;
        b=6OKrEcM4n7XXA+xNliSUCtMAYx8SK/mFhTkpyncedK7vgDqj0OknCu3jBtIOAcnEx3
         /HANS8suQPRcYYqbkEQuUNEoeRD9Pk+7z4HAVllwVLnEsxfgAI2w/FLSTGPvICv07Ufc
         Aqqe3VPNlEx1r6BJnoask9gvxVI1bdMOr5QPKm9sbV26iL63/rpAPKsCsrH/KQ1K/oie
         fQJb15zK7Jbl8cfILaVD0tLNxlwrMkI/vy/l1OR23rWYcQLT3EZ3nUn4TvPlwLVSxhV8
         SvNT0WMCs0wJEB3smhHacx2IQDG5HVVmC4qUGhAnr1BNUSqrfyI92EKcy6cdEHX4BSNe
         YQKw==
X-Gm-Message-State: AO0yUKURwsjtVSjdyo4qR7myEQQVpkDhv3gvWpUINpJfjGiLbFXIPoh1
        v5APtqgPy/pNhX/HI0t18iEllA==
X-Google-Smtp-Source: AK7set+CzHz42sMYy4A1TLOMRmQ4V5WpNodweBdRk+BFWC+9HSDi+OuobpSTPV5LkXlKNQH7omU9/g==
X-Received: by 2002:a05:6402:1850:b0:4ac:c5c1:e1ed with SMTP id v16-20020a056402185000b004acc5c1e1edmr8412849edy.12.1677057455723;
        Wed, 22 Feb 2023 01:17:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g16-20020a50d0d0000000b004ad1d3cf195sm3031904edf.95.2023.02.22.01.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 01:17:35 -0800 (PST)
Message-ID: <1467f7c5-07eb-97db-c6f2-573a4208cc28@linaro.org>
Date:   Wed, 22 Feb 2023 10:17:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add reset
 items
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230221140424.719-1-walker.chen@starfivetech.com>
 <20230221140424.719-2-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221140424.719-2-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21/02/2023 15:04, Walker Chen wrote:
> This DMA controller needs to be reset before being used on JH7110 SoC,
> so add reset items to support this chip.

There is reset already. The DMA controller is reset already. Your commit
msg and commit subject do not match commit at all.

> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml         | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index ad107a4d3b33..c2247c65a22f 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -20,6 +20,7 @@ properties:
>      enum:
>        - snps,axi-dma-1.01a
>        - intel,kmb-axi-dma
> +      - starfive,jh7110-axi-dma
>  
>    reg:
>      minItems: 1
> @@ -58,7 +59,12 @@ properties:
>      maximum: 8
>  
>    resets:
> -    maxItems: 1
> +    maxItems: 2

This breaks ABI and all other users. Test your changes before sending.

Best regards,
Krzysztof

