Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84556BAA0F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 08:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCOHx7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Mar 2023 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCOHxo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Mar 2023 03:53:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDAA3CE2B
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 00:53:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so71822657edb.12
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CCMcoXvLkpis235GxP783kPe2pJ/VsfubOnVO3b3CA=;
        b=rbvocE5SvjoBL0CvzN7gMp0FSpwRJPKqFdC9mlCqvIQIbUKt3gNUPDJUIHUvRW0rdL
         WShbM+PL8rM1tsbGGHTHPQy/f/+Oo8Rcqv9UUA4PeLHes6clbHt/EiwBMXKnw0WCIBN8
         tdYktv+3Rrz8DnSJ1G8uJNk46XIKn2FpuJGqMTW8MwOMTgl4yNhjVyZJm2RjSaXLXZam
         R3e1s+wgEvzf5XklopYavWEotDN/7W1T4n8tI/t2lIofgCIeG+hTxmH/llz+S6//TaNl
         jmqO772ZJ5DaOcb6Bk6iU1k73UAB+d/puPHjrgRlusB+VmMq2KQ8bogI9Vzh6VAQKNhh
         2zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CCMcoXvLkpis235GxP783kPe2pJ/VsfubOnVO3b3CA=;
        b=h6Ozae7UsCu3JrHjYM43ku7YmJsRehfqJPLsdoHRF4FCo10PxLW6a+eag23eX+CAkh
         aB17rrDbF1wjkBiF6iJ6MsWuVJahqvMjsJGqx3vy4rgbp1ku/nDXwP5NPqq+hcgBQxmC
         QzntYEnKHKowtFCjy8716eh4T9B0u/4+wMoyvy/MtgfROh08/bNVKUd9aYhzW5Egb7Bz
         VY4kCxqsnN6P0i8+NWfRB1UrwV0GOlLdyuABamjBl9akztiqcoTryxelAEc1vrTHRDyY
         igHqTV3/R76fE+zi73Y4QmL/TwnJURE2Kq7t/Xzhfdv6B4/hVXmlCV/mbiWyQxZMNmyP
         vClg==
X-Gm-Message-State: AO0yUKX2ACugdd23dRzR9U+TDyQlD20d1z0Muj0nahASZDU4HnGWWcCh
        ZULyQ6x6T/QBp6ieCqlvgcyIMw==
X-Google-Smtp-Source: AK7set/4v4RRpToR1aRHQI+AjoXhbCoezqdXuQossTWmooKSQsFDXaSaGfC3DjHWuCMd0SKLbuffcg==
X-Received: by 2002:a17:906:f904:b0:8b1:2614:edfe with SMTP id lc4-20020a170906f90400b008b12614edfemr1222997ejb.9.1678866797767;
        Wed, 15 Mar 2023 00:53:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906138d00b008b1fc59a22esm2144975ejc.65.2023.03.15.00.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:53:17 -0700 (PDT)
Message-ID: <89bb07be-e11d-e248-8798-08b8531e68c7@linaro.org>
Date:   Wed, 15 Mar 2023 08:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: dma: rz-dmac: Document clock-names and
 reset-names
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20230315064726.22739-1-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315064726.22739-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/03/2023 07:47, Biju Das wrote:
> Document clock-names and reset-names properties as we have multiple
> clocks and resets.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/dma/renesas,rz-dmac.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index f638d3934e71..c284abc6784a 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -54,6 +54,11 @@ properties:
>        - description: DMA main clock
>        - description: DMA register access clock
>  
> +  clock-names:
> +    items:
> +      - const: main
> +      - const: register
> +
>    '#dma-cells':
>      const: 1
>      description:
> @@ -77,16 +82,23 @@ properties:
>        - description: Reset for DMA ARESETN reset terminal
>        - description: Reset for DMA RST_ASYNC reset terminal
>  
> +  reset-names:
> +    items:
> +      - const: arst
> +      - const: rst_async
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - interrupt-names
>    - clocks
> +  - clock-names
>    - '#dma-cells'
>    - dma-channels
>    - power-domains
>    - resets
> +  - reset-names

The clock and reset entries are ordered anyway, so requiring '-names' is
not really necessary.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

