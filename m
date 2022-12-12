Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1005F649E4E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 12:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiLLL7N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Dec 2022 06:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiLLL7M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Dec 2022 06:59:12 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA6538A1
        for <dmaengine@vger.kernel.org>; Mon, 12 Dec 2022 03:59:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 1so18149088lfz.4
        for <dmaengine@vger.kernel.org>; Mon, 12 Dec 2022 03:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OocQB+h2q+22nRgnDeUo9frDZ1zMkR0ipc4/j+5KB2A=;
        b=ulry1sXZp3UYv6fUDKNKVXilEqOFiM8HnkzKoAeQM4C7DsAAtgqSrJ5qvYT3B5/5rr
         5MziqwzvA2tqHvlMgLUoWxCHWiVuGTkxqmF5ZdbaP9uaNuzlITQlTQej/RJMPIWN9cuM
         9Wn0A0MX/DzHhkw3PQw1WLhrbac4LVS1Z8MNlAygT7GsY9TLJYnMpNb5ZOv1EmiJUGZ3
         8tOl4VRXQntDCO7cK9u3HK5I52p80whKvU5Va58A8GIFz4wd26zoWJ5QcUfQCBKlQl6f
         N9XPIgrLk63Szpl7vMlXbMTOF/KyuNOPJ9P/ANM9h44yilWdCuEgtha6Ehy4WGI1NwBI
         nv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OocQB+h2q+22nRgnDeUo9frDZ1zMkR0ipc4/j+5KB2A=;
        b=V67cGCsRjpoHHfX6GE07eIPySm+NUx56vh/iVcew02v0RKaf2sVu9bzirisd5Sl2yL
         1fxCY+wrevzxcvy63OyOWOA6zHhNZaCqKXjW3tsEY0j9XavEZVfK6vctbw0y8v9FftSZ
         wKK0tdfqwWjI4r3aL2+DAepohttG6HsvB9IT7QYruwWo4AMqnW5bzFOf2Mao/dDW/RL6
         rMx1hXIYHSsmktsQjJRS/nKkUTr7Kmnw53BzHZOyug35d7ufC4kyq8cphRTmB1AIfgbY
         17UlR1tk4l43GBUBkgInXqQa2udlB19Rk0XHP/RKPoFrK3h4r2WJGMrkNvO8C927DwgC
         Fx/g==
X-Gm-Message-State: ANoB5pnyEzr3Cm1NUlJf/IMRIHvHbLgOsGGUisUd8moxfSxbhyo15gAk
        wbZcpBdKaRnnfdsV4asHQRsUIP6NDI/Cfwccl2Y=
X-Google-Smtp-Source: AA0mqf5L7ma7d20AlI9QeaId/PqEI63KNChtzwSNwaGI/E7gv0HX0tZHbWZ8TmukWu9LsvOYi2f4JQ==
X-Received: by 2002:a05:6512:31cc:b0:4a4:68b7:d652 with SMTP id j12-20020a05651231cc00b004a468b7d652mr5753836lfe.57.1670846348771;
        Mon, 12 Dec 2022 03:59:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05651c169700b0027b477e5bdesm702189ljb.19.2022.12.12.03.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 03:59:08 -0800 (PST)
Message-ID: <636b6f17-c1b7-6868-306c-7f160e324ee2@linaro.org>
Date:   Mon, 12 Dec 2022 12:59:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for
 BCDMA CSI RX
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221212105416.3628442-1-vigneshr@ti.com>
 <20221212105416.3628442-2-vigneshr@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221212105416.3628442-2-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/12/2022 11:54, Vignesh Raghavendra wrote:
> AM62A SoC has a dedicated BCDMA that serves Camera Serial Interface
> (CSI) IP. Add new compatible for the same. Unlike system
> BCDMA, this instance only has RX DMA channels and lack TX or block copy
> channel. Thus make those properties optional. Additionally CSI RX has
> independent power domain, add the binding for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> v2:
> reorder compatibles alphabetically
> Fix reg defintion to min 3 and max 5
> Keep top level constraints as is  and further restrict
> variants within "if-else" blocks
> 
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 67 ++++++++++++++-----
>  1 file changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index 08627d91e607..86e8bebce3f2 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -28,13 +28,15 @@ description: |
>    PDMAs can be configured via BCDMA split channel's peer registers to match with
>    the configuration of the legacy peripheral.
>  
> -allOf:
> -  - $ref: /schemas/dma/dma-controller.yaml#
> -  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> -
>  properties:
>    compatible:
> -    const: ti,am64-dmss-bcdma
> +    enum:
> +      - ti,am62a-dmss-bcdma-csirx
> +      - ti,am64-dmss-bcdma
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 5
>  
>    "#dma-cells":
>      const: 3
> @@ -65,19 +67,13 @@ properties:
>  
>        cell 3: ASEL value for the channel
>  
> -  reg:
> -    maxItems: 5
> -
> -  reg-names:
> -    items:

reg-names with min/max items should also stay.

> -      - const: gcfg
> -      - const: bchanrt
> -      - const: rchanrt
> -      - const: tchanrt
> -      - const: ringrt
> -
>    msi-parent: true
>  
> +  power-domains:
> +    description:
> +      Power domain if available
> +    maxItems: 1
> +
>    ti,asel:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: ASEL value for non slave channels
> @@ -123,10 +119,45 @@ required:
>    - msi-parent
>    - ti,sci
>    - ti,sci-dev-id
> -  - ti,sci-rm-range-bchan
> -  - ti,sci-rm-range-tchan
>    - ti,sci-rm-range-rchan
>  
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,am62a-dmss-bcdma-csirx
> +    then:
> +      properties:
> +        ti,sci-rm-range-bchan: false
> +        ti,sci-rm-range-tchan: false
> +

missing constraints for reg

> +        reg-names:
> +          items:
> +            - const: gcfg
> +            - const: rchanrt
> +            - const: ringrt
> +
> +      required:
> +        - power-domains
> +
> +    else:
> +      properties:

missing constraints for reg

> +        reg-names:
> +          items:
> +            - const: gcfg
> +            - const: bchanrt
> +            - const: rchanrt
> +            - const: tchanrt
> +            - const: ringrt
> +
> +      required:
> +        - ti,sci-rm-range-bchan
> +        - ti,sci-rm-range-tchan
> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

