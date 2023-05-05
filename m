Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABCF6F82F2
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEEM3t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEEM3m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 08:29:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA21AEFA
        for <dmaengine@vger.kernel.org>; Fri,  5 May 2023 05:29:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso2547978a12.2
        for <dmaengine@vger.kernel.org>; Fri, 05 May 2023 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683289777; x=1685881777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIKISSzfdlI1q4U757s3CoigWtnnUtW1Xxi1EanSmc4=;
        b=MrJuf3qSJo92sF0EwJuzNv8WL5nZqDwlkTbaOtvmuzhEyy1l4pQ5+8wJeHW1NMRE+B
         Nyfu960Fi4NR/Qc/Y2B+gn6tm5Gulw6qvU61/39CLzheXx640v06+p6uuXLHaA7Niyyz
         LiaTF/Xa7Na03IQ5kR3m67S67fB+pAMRia/aZN3BgdhE6o02sD0bzCrbBVBq+LIgBXTv
         WwpJXAZ0eSKLE1RnT9QFR4tBQVrq7r2eVOzElfHm7jV+F47L0L4GKaOEMcwDIB0SN0A2
         WIflK5LDrQilre4BfBT1TprIhhedPY7sCuPu3fadR2rsDvZ6v0nN8qt2SKysMWJPQMS4
         BbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683289777; x=1685881777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIKISSzfdlI1q4U757s3CoigWtnnUtW1Xxi1EanSmc4=;
        b=Voyc6DHxl/6lClwpMbDT340zdjySXq5c8oR8I4szWt5vo4O4IS8iMb5bYg9wA5vjGc
         l5lrJsa0NzHoNcyoDHpc2IaBT7cmHCaAg5C/OP1pfB9IdAye0QolGRm+s3f2l+THaR8V
         jph0NkaEFYuT0yoOTti1o8mtE2kDrxwc5JGK4KpufA1derVg6jzL5aSyzA6L/xx41Q1O
         7sXh7/JrmBfw0tlebksavZodATtIeegzBXs7WvriApk3vkJPWXqxo0n7SsJRMMF6RwXi
         0hRqB6jTQdeXJcJX54Z9sAXwtvfdsHCIJvYgz+Pg480GvbI3ZfqZtNTed7emvH3iVBO2
         fenw==
X-Gm-Message-State: AC+VfDyy+yDHBMfdXXnyNXYjebChKN5tyjKudMqj/gsT51NwzvyuM32e
        zdzXYrnGF3lAD8v+1ZTpkdv9zQ==
X-Google-Smtp-Source: ACHHUZ6sKHjXQ9Dv+rDF+/NQoBmAoITLy9ioiWiI4EQ9RZr5CdEXfUxGDaPpZreTPP38cOCP9tJsSQ==
X-Received: by 2002:a17:907:3e27:b0:962:9ffa:be22 with SMTP id hp39-20020a1709073e2700b009629ffabe22mr1190688ejc.7.1683289777117;
        Fri, 05 May 2023 05:29:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906470d00b00965c076133esm867276ejq.176.2023.05.05.05.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:29:36 -0700 (PDT)
Message-ID: <8a9cd96c-ea07-2ea4-579a-d62a4671941a@linaro.org>
Date:   Fri, 5 May 2023 14:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>,
        krzysztof.kozlowski+dt@linaro.org, peter.ujfalusi@gmail.com,
        robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        j-choudhary@ti.com, linux-kernel@vger.kernel.org, u-kumar1@ti.com,
        vigneshr@ti.com
References: <20230505082602.31783-1-vaishnav.a@ti.com>
 <20230505082602.31783-2-vaishnav.a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505082602.31783-2-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/05/2023 10:26, Vaishnav Achath wrote:
> Add bindings for J721S2 BCDMA instance dedicated for Camera
> Serial Interface. Unlike AM62A CSI BCDMA, this instance has RX
> and TX channels but lacks block copy channels.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V1->V2:
>      * Move J721S2 BCDMA entry to else condition to avoid failure
>      with AM62A BCDMA.
> 
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 54 +++++++++++++------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index beecfe7a1732..54d4b8e0c8ce 100644
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
> @@ -152,21 +153,44 @@ allOf:
>          - power-domains
>  
>      else:
> -      properties:
> -        reg:
> -          minItems: 5
> -
> -        reg-names:
> -          items:
> -            - const: gcfg
> -            - const: bchanrt
> -            - const: rchanrt
> -            - const: tchanrt
> -            - const: ringrt
> -
> -      required:
> -        - ti,sci-rm-range-bchan
> -        - ti,sci-rm-range-tchan
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: ti,j721s2-dmss-bcdma-csi
> +      then:
> +        properties:
> +          ti,sci-rm-range-bchan: false
> +
> +          reg:
> +            maxItems: 4
> +
> +          reg-names:
> +            items:
> +              - const: gcfg
> +              - const: rchanrt
> +              - const: tchanrt
> +              - const: ringrt
> +
> +        required:
> +          - ti,sci-rm-range-tchan
> +
> +      else:

Avoid if:else:if:else and alike. I asked to add one more if covering
this case.

Best regards,
Krzysztof

