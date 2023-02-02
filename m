Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8218D6887B4
	for <lists+dmaengine@lfdr.de>; Thu,  2 Feb 2023 20:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBBToS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Feb 2023 14:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBToQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Feb 2023 14:44:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F9E3A5;
        Thu,  2 Feb 2023 11:44:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h24so4564837lfv.6;
        Thu, 02 Feb 2023 11:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rd7kT/8tJcFEXchoRyQMnasMBTHYEkNO+aCP72ohTdQ=;
        b=RF0WK8SpEC+vqYABtaQMiRUaOoW3slBnOWi0J/jNWhbr0nbE3n9EUmobrXNtUoTebq
         XAhQJOVnMq0I0s0D4aWnGH3W995PNGmGg8tuA9ta3zPYV3/kbxseSbdWHfdwix4W928+
         Cb84Un1O6Zt4rChCPjiiHSLPy3kf5FtqLNzbWRvJYRJFaP7q8HazqNZRYBTl030EFdkZ
         YWI1W+00ZEsjM32Pk6pVdeWHzybKU0pgXymeEnqPksYArrhGaxMpAaMSk+Vf/2F8rVDE
         tFa1V5OCv35xFXSjqogD96Ghdj85ItCtUoJKsztmru0qA3/UDHEaick1Q8S07ejjyOJF
         IPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd7kT/8tJcFEXchoRyQMnasMBTHYEkNO+aCP72ohTdQ=;
        b=r3qOG/ftSzqE5ud4pns7FRdg6X6XKr8AhXlWfyrDRyn+GC0gDa+BRvEeoRAMbEhiQ5
         ODAN4j4yOQn3zSo0l6jbzJHXlBOfUjQafqZUt2fgIFolzXaNa0ijJdwCVfv6SPgGoADr
         3rzbGmX/t9pt18CMj7SD3EbRKDWLsMyvHsF2HiYDQO0MTFDMgPGSrSp6wDCEGq5nhec6
         X4PlxFRVlSOb6pH/rjdGwBx93uCxDtp1zFhs/vM8nF21ZETopsSXQuNsmaXwov/NeOTR
         v3rltUUoAMT4yVbZHKYaVeDPPwW/j2/gNokq59lSTMeEOfw2szEoUHk4MX45xrk0szrS
         FtCw==
X-Gm-Message-State: AO0yUKU6N8B3RTsway7nz8rvQC6ANVNxXxjOKEmXTd5gmhPeT5/OYEe9
        dV7wI8iTibhSCZm7b7+AK4k=
X-Google-Smtp-Source: AK7set/i5qFQMeHr8m6as7nzFHFJ0I2T9wnYlyJfxm3tDEiP6zZ2ZCF+JP8mzIHANAGBMc9l+So33g==
X-Received: by 2002:ac2:510a:0:b0:4d0:1f8b:b1bd with SMTP id q10-20020ac2510a000000b004d01f8bb1bdmr1941719lfb.32.1675367053145;
        Thu, 02 Feb 2023 11:44:13 -0800 (PST)
Received: from [10.0.0.100] (host-213-145-197-218.kaisa-laajakaista.fi. [213.145.197.218])
        by smtp.gmail.com with ESMTPSA id s26-20020a19771a000000b004d57fc74f2csm26484lfc.266.2023.02.02.11.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:44:12 -0800 (PST)
Message-ID: <df621345-1afd-1e0a-bd28-b5bd3e483e6d@gmail.com>
Date:   Thu, 2 Feb 2023 21:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: ti,k3: Use common ti,k3-sci-common.yaml
 schema
To:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230125221339.3057322-1-robh@kernel.org>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230125221339.3057322-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 26/01/2023 00:13, Rob Herring wrote:
> Instead of redefining the 'ti,sci' and 'ti,sci-dev-id' properties multiple
> times, reference the common schema where they are defined. Most cases
> using these properties already do this, just udma and ringacc need to be
> fixed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/dma/ti/k3-udma.yaml         |  9 +--------
>   .../devicetree/bindings/soc/ti/k3-ringacc.yaml      | 13 ++++---------
>   2 files changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> index 7ff428ad3aae..97f6ae9b1236 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> @@ -44,6 +44,7 @@ description: |
>   
>   allOf:
>     - $ref: "../dma-controller.yaml#"
> +  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>   
>   properties:
>     "#dma-cells":
> @@ -78,14 +79,6 @@ properties:
>   
>     msi-parent: true
>   
> -  ti,sci:
> -    description: phandle to TI-SCI compatible System controller node
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -
> -  ti,sci-dev-id:
> -    description: TI-SCI device id of UDMAP
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -
>     ti,ringacc:
>       description: phandle to the ring accelerator node
>       $ref: /schemas/types.yaml#/definitions/phandle
> diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
> index ddea3d41971d..22cf9002fee7 100644
> --- a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
> @@ -25,6 +25,9 @@ description: |
>     The Ring Accelerator is a hardware module that is responsible for accelerating
>     management of the packet queues. The K3 SoCs can have more than one RA instances
>   
> +allOf:
> +  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
>   properties:
>     compatible:
>       items:
> @@ -54,14 +57,6 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       description: TI-SCI RM subtype for GP ring range
>   
> -  ti,sci:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    description: phandle on TI-SCI compatible System controller node
> -
> -  ti,sci-dev-id:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: TI-SCI device id of the ring accelerator
> -
>   required:
>     - compatible
>     - reg
> @@ -72,7 +67,7 @@ required:
>     - ti,sci
>     - ti,sci-dev-id
>   
> -additionalProperties: false
> +unevaluatedProperties: false
>   
>   examples:
>     - |

-- 
Péter
