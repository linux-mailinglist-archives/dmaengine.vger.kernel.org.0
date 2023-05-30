Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376571611A
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjE3NIz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjE3NIy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 09:08:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B0A1
        for <dmaengine@vger.kernel.org>; Tue, 30 May 2023 06:08:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso8613898a12.0
        for <dmaengine@vger.kernel.org>; Tue, 30 May 2023 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452130; x=1688044130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZXIY4rtAXwpW+oWkjV46RQdYU5hKm1yGrqNPmpHKfU=;
        b=wEi+COhB4saE6t3QX0aBzZRVTpQ7odjIOZ2E4o7tTiZl8AnovhqRf7Bodd0DYdqUIw
         3dbjTQa6AJYb8q6GdY7xBc4lmTXn9ivsYko6Z48h96ql6mvKhHdDuExxPgKJ/D9g9xw4
         uxr+SinEI0jqUKRfePH5ukhM/HkBzMk6BfN2S4rtvBv4Pvp7bXxqx+WgBlKTU8ZU8V9g
         5SsksCPlm6QBoyHDHok8s/Occz5ETdfedATS1HqQIHw4M5QgjmL3RGk6CtzENlKtAc7A
         z55iGBXDsKcrzb5QbuAlCN89iZDnLPTdi/PUgvEQhUGH7OXFKR4ImPvovl9fVz3h+sFe
         XHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452130; x=1688044130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZXIY4rtAXwpW+oWkjV46RQdYU5hKm1yGrqNPmpHKfU=;
        b=Vv8qxCc2x7gvee4z4xxXoFfh7xOBDG9JjDxDfygZ5tHGk9WdZoIM3iEM8iElyyYnCc
         IHBBqAbTHY8r2RLYeGAoyMBANhx1VBeAY8gePH57QktG0XWi9b+8fwzuca57RhbnO2Uh
         s7OBl2xhEVA/Um3bqUxd1Od92UPTsrdrkzqFRNDkQXi4YGfzIQZusOVc73Nho/NvhVzR
         5OZcpUo0pn+cVH+H5QLJWSMl0O/LFJtNzbaLg9X+Sgjw3Af6NzLBMtsqBiuHY0Q0T+7+
         prOc/2dxbMBHSMAgoHVouncbWtRu973ltqosAHXUjZL+TGFmZCe2buy/erFeN8P0jsKr
         RaHA==
X-Gm-Message-State: AC+VfDy34zs2Twlt0Iqvk078APEAjGO/f5UW7AjvakpVLZe/fZR3LbAd
        GF1F0vdptUI8W1uvWBB17xhxeQ==
X-Google-Smtp-Source: ACHHUZ4RM/uBVqPWi+sisdgqZOaN+mYhKX2B80COqCOcYP5pLPymJxYK4pUbM9xiPei6arPXAmPDqA==
X-Received: by 2002:a17:907:7da0:b0:96f:b40a:c85f with SMTP id oz32-20020a1709077da000b0096fb40ac85fmr10368239ejc.23.1685452130647;
        Tue, 30 May 2023 06:08:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0096f7e6d0063sm7309682ejb.75.2023.05.30.06.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:08:50 -0700 (PDT)
Message-ID: <65e7b6df-b83b-2d7c-5093-f5822050827a@linaro.org>
Date:   Tue, 30 May 2023 15:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-13-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230529200453.1423796-13-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29/05/2023 22:04, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..eed12687b0c9 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,6 +21,10 @@ properties:
>        - enum:
>            - fsl,vf610-edma
>            - fsl,imx7ulp-edma
> +          - fsl,imx8qm-edma
> +          - fsl,imx8qm-adma
> +          - fsl,imx93-edma3
> +          - fsl,imx93-edma4

What are these last two? What is "3" and "4"?

>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
> @@ -101,6 +105,22 @@ allOf:
>          reg:
>            maxItems: 2
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: fsl,imx8qm-edma
> +              - const: fsl,imx8qm-adma
> +              - const: fsl,imx93-edma3
> +              - const: fsl,imx93-edma4
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        interrupts:
> +          maxItems: 64

That's odd. What about the names? What about minItems? Anyway, this
wasn't tested - you will have failures with dtbs_check.



Best regards,
Krzysztof

