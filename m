Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172E6AD9CE
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 10:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCGJD6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCGJD5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 04:03:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3F32531
        for <dmaengine@vger.kernel.org>; Tue,  7 Mar 2023 01:03:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so49266992edb.12
        for <dmaengine@vger.kernel.org>; Tue, 07 Mar 2023 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678179834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKx0mOkpRvRnCD/ymFwDwCwKvrzXqmFUgh9qzSW4PII=;
        b=nlg42fRs9OuoIq2xD+xUEYMEZSBK+LODPpSyr7N/ri7VyhxSZQ3xCqI0BoOFn5eTEl
         RuxaQv0qgZoAHX38sXj/b83UiUbDXYkKFpZo2eJZwJ3UjFeYuG6ziSALDog48COpvZ+w
         QJ8AdYBf6c23YgJ8LJDCqKoMDQcuTkprPZavXtf+vsTRIN/qhP2mEPQtMsPvZFFIHpCI
         Ug5xQ3ekBUF3Q9vjsx76uCOYoWzre5Tr2v/9Pe/rkHSQgXnrjTLah301lJvPcaope+ye
         Vtq/aefqJd1wJ6p+Vfeb/ZcaZ3/01p1QXEcrSECX7wtj9MbdTRsr33gEo0LhN0A5RDuO
         V+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKx0mOkpRvRnCD/ymFwDwCwKvrzXqmFUgh9qzSW4PII=;
        b=BtEwtVwPRg2hcwyMXB2EVU3KSqQYQIs36QEF/FepKZVoteJ2cwvlTSYjPxGt0xar7R
         db1L/LeuU/e+u+d5Ft+TlxIGZoNTRfu6xy+xgKw7+25RAGpKyhdF1fjDC+O6AXJuJR97
         pupiRrAzXNpbePCZQj8VH9XYZf2Oj+oVH6DSgLGtRzz7CKw8HXsGnV3VHdhs72E1RmSK
         FhNJtJduUHwK6bMv9UGrd+hh3JRzzEiuSOHaJMl5JlWnG3pjokSg3ZUJrzBRsjcAyd0w
         pzUP0exLuRjdbRJkpDyqYJWMJ7BLG3t/gQaF+XrTD5ojmhbGB+WYxYjY5OwYLn4FeDP4
         qGiQ==
X-Gm-Message-State: AO0yUKUqDmmpfNRJHZfwNRCMaXTHjpPtwNNvaPcf/6N3swPFE+V/ChQA
        +kHX+SKAsy32oYNjb/0CPSbc1Q==
X-Google-Smtp-Source: AK7set/bUqwAq/6asQNaUsbcnghCIXoZCJWabHy9kZ1G907/38X/E3IF17xsoo9IDiWsPXCP2TfTrA==
X-Received: by 2002:a17:906:4783:b0:878:4497:380e with SMTP id cw3-20020a170906478300b008784497380emr17334260ejc.4.1678179834212;
        Tue, 07 Mar 2023 01:03:54 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id uk19-20020a170907ca1300b008cecb8f374asm5741155ejc.0.2023.03.07.01.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:03:53 -0800 (PST)
Message-ID: <b2b36909-b0b1-7507-3145-141eb5ec0f3f@linaro.org>
Date:   Tue, 7 Mar 2023 10:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain
 resets items for JH7110 dma
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230306140430.28951-1-walker.chen@starfivetech.com>
 <20230306140430.28951-2-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306140430.28951-2-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/03/2023 15:04, Walker Chen wrote:
> The DMA controller needs two reset items to work properly on JH7110 SoC,
> so there is need to constrain the items' value to 2, other platforms
> have 1 reset item at most.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index ad107a4d3b33..d8b5439f215c 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -12,14 +12,12 @@ maintainers:
>  description:
>    Synopsys DesignWare AXI DMA Controller DT Binding
>  
> -allOf:
> -  - $ref: "dma-controller.yaml#"
> -
>  properties:
>    compatible:
>      enum:
>        - snps,axi-dma-1.01a
>        - intel,kmb-axi-dma
> +      - starfive,jh7110-axi-dma
>  
>    reg:
>      minItems: 1
> @@ -58,7 +56,8 @@ properties:
>      maximum: 8
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    snps,dma-masters:
>      description: |
> @@ -109,6 +108,23 @@ required:
>    - snps,priority
>    - snps,block-size
>  
> +allOf:
> +  - $ref: "dma-controller.yaml#"

Rebase your patches on something recent... I would argue that it should
be based on maintainer's (or linux-next) tree, but that would be too
good to be true.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - starfive,jh7110-axi-dma
> +    then:
> +      properties:
> +        resets:
> +          minItems: 2

What are the items expected here?

> +    else:
> +      properties:
> +        resets:

Best regards,
Krzysztof

