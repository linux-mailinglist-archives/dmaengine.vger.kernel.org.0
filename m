Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966D96F7067
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjEDRER (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEDREP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 13:04:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2E535AE
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 10:04:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so1145274a12.1
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683219852; x=1685811852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlRk1RCeKU7o3gs8w9KIlX6up9OV2t4PRbCSyTcr+6o=;
        b=OdOnw/9rrisJ4kZZyA1yqfRJn9iJ6lIRfQL0QjO85+SIHsSigEj2aa8z2izyQHBn9M
         RW/g2MTkt5L/Kr3Q+cVgkxsFl0Jm6LP5swk4tHtqClMn7H7rJf1ywAOvbixBFl4PI/Wz
         fgq/VwyxMfaXunFE+yXZI49L0+EpVCIynbFIVIZxFuXXx79bMObNZ3emC+5acTdWKSRh
         D0cZw8Cx+MgLJxreej+W72jEzTpZYrBXyLNj1i91Lxcr2NwMA8EcN+5ww4Ypfz6eCDuZ
         gX9nvtG5+auPWp+92IIlB+5hIuVEoQR3IYQAztyjPmnkBMYFNDrT41URMYs9uuCNjWxD
         8vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219852; x=1685811852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlRk1RCeKU7o3gs8w9KIlX6up9OV2t4PRbCSyTcr+6o=;
        b=IE3UaGy8+CuBNfSyg3mAIKK2tAZy9S03nvwjSwUHHwV95NIxT9eOUWd0ogxQdtx2vp
         0lEUlY9TBR8ruNi9BJBe6JhPjxbiSU2SyUcoPuBe5sEAhE7QulkSsWKrcIaiKwqOMVAJ
         uEIoCVBknMcBvxzJ4e3Qpx4PLJC67+uB54v4b8N8e45uc5rPEZzh2QDydGAFVL/ZHGzj
         Z5/FNhVewXE6MMf/W/ymrDvwNJTTFOEhYCtvf0kV25mX5g5Q2vUxaESNwtmMaJjlPLDN
         JNLEsOEc6sqDCS4LifesIBVSSzR2yAM00igWVS19CU0tqnJXzToLnhTJ97xCXhE4/O93
         Lhlw==
X-Gm-Message-State: AC+VfDxTpuIfQQQrGZqLxLHU30L0tG4ao3agHj/LbRWg0DcAT+hlIz6t
        NnLsxL0GDgQqYwAnM3qyhlUcAg==
X-Google-Smtp-Source: ACHHUZ4yw01j72V7v00qdVG/i73OsQ/JtKCOYW5DeoWzDcJ2LoqAxwuyyDltufUE0IdLZz20m8aA7g==
X-Received: by 2002:aa7:d14b:0:b0:50b:c164:526c with SMTP id r11-20020aa7d14b000000b0050bc164526cmr2610944edo.13.1683219852591;
        Thu, 04 May 2023 10:04:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bdb9:99c4:33a5:6114? ([2a02:810d:15c0:828:bdb9:99c4:33a5:6114])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7db47000000b0050bcbb5708asm2082323edt.35.2023.05.04.10.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:04:12 -0700 (PDT)
Message-ID: <6bce9c65-12f3-0128-91d0-142f0b5a791e@linaro.org>
Date:   Thu, 4 May 2023 19:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, j-choudhary@ti.com, u-kumar1@ti.com,
        vigneshr@ti.com
References: <20230503065303.16674-1-vaishnav.a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230503065303.16674-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03/05/2023 08:53, Vaishnav Achath wrote:
> Add bindings for J721S2 BCDMA instance dedicated for Camera
> Serial Interface. Unlike AM62A CSI BCDMA, this instance has RX
> and TX channels but lacks block copy channels.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index beecfe7a1732..5ca9581a66f4 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -33,6 +33,7 @@ properties:
>      enum:
>        - ti,am62a-dmss-bcdma-csirx
>        - ti,am64-dmss-bcdma
> +      - ti,j721s2-dmss-bcdma-csi
>  
>    reg:
>      minItems: 3
> @@ -150,7 +151,27 @@ allOf:
>  
>        required:
>          - power-domains
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,j721s2-dmss-bcdma-csi
> +    then:
> +      properties:
> +        ti,sci-rm-range-bchan: false
> +
> +        reg:
> +          maxItems: 4
>  
> +        reg-names:
> +          items:
> +            - const: gcfg
> +            - const: rchanrt
> +            - const: tchanrt
> +            - const: ringrt
> +
> +      required:
> +        - ti,sci-rm-range-tchan
>      else:
>        properties:


You now require 5 reg items on ti,am62a-dmss-bcdma-csirx. I don't think
you tested your DTS against this change. Rework the else: so it will
match specific variant (if:).

Best regards,
Krzysztof

