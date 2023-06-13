Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE172E128
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjFMLUs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 07:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbjFMLTu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 07:19:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32891BD5
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 04:19:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9768fd99c0cso1325323966b.0
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686655167; x=1689247167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtzyg81yCu4VXwW413lxgy6B2wG9SaGkM8lh+1KCu1g=;
        b=LYbOWDJUSS7DIRw9J0C8Id2sSIgH9M1zm2KSPI7CbOTgx2VSIGhUWnN0rZbuVXiGc3
         Rbxy7IGgE36jaklExufVW9DNVTJrSbUiNWgBeAZ/hmIhLrPCV1FbyNZo4BwdRlo73CL9
         qPd+b4nA7Uqp4mNrk5ttZ9ZIy9VtvsKdcnpUrF8BrJ+ior9hzUADrMi/khEzwfNJgBBB
         3J3aCRqAmCfHJEUQTgo35GLSrY2DAVgxAkIBeSLAyhb1JMDKYQtJkHNSTPnerU0/5Ut0
         15Y3W9kYyyBmpkkigX9U2BqLDgVW7ZQtql+TjHZKmKVe5WZNSgoS6jFsrAavv1NznRie
         Fb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686655167; x=1689247167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtzyg81yCu4VXwW413lxgy6B2wG9SaGkM8lh+1KCu1g=;
        b=FEb7rt8ttTy+wPRSR/QMaIP7UdmYsqViVqjBBz7xOoPt2MENfrPKXXMbQJaoCdts3Z
         VJYqll26J3eewLqLpoy3L2mz9HSnA0AVO3KhnVkhlJLEQkuGb77vRzfCB5yE4OnUrXNr
         L8VJOhy6KcZPP8VsoGF5sHDqpyjYrY9ppd4IFthE2V6B07i/vYlkfvCimv06VfyCmaap
         ZCTcN/OUxj/6WD9Y38gqAHMHO3s2OPc1x2ZNpJguWxfui+MyTfvVGELo4Yeo+csXZJM8
         H3jukCfCsdrVqMU5hP5qQgNMe2FMLz7PRbHca5PFB5bhVvzTvQCGMJ9M1gqFN7Rvbh8A
         U9xw==
X-Gm-Message-State: AC+VfDy4u03OdnxtRZWx+PomAB+4fNg/0LPyKKDRms3Sa7MOqJfAxx6o
        YBV7kRRQ0VQxXWrsrhhKkAIq6Q==
X-Google-Smtp-Source: ACHHUZ7V9uuUJDuQkeE0U0VIpQbamKxyYvpkZgeq1/iDcr16b5+vIJ7b1fWzeTaXfAfKzGUoiNz/fw==
X-Received: by 2002:a17:906:5d09:b0:978:af9d:c004 with SMTP id g9-20020a1709065d0900b00978af9dc004mr11055545ejt.4.1686655167482;
        Tue, 13 Jun 2023 04:19:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906494d00b0097461fecc91sm6493922ejt.81.2023.06.13.04.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:19:27 -0700 (PDT)
Message-ID: <7574a6fe-ddf1-1500-ba04-5a1df6845b6a@linaro.org>
Date:   Tue, 13 Jun 2023 13:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
 <20230612203418.2017769-13-Frank.Li@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612203418.2017769-13-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/06/2023 22:34, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..14cea8a3f442 100644
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
>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
> @@ -101,6 +105,26 @@ allOf:
>          reg:
>            maxItems: 2
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:

This is just enum.

> +              - const: fsl,imx8qm-edma
> +              - const: fsl,imx8qm-adma

Keep entries ordered alphabetically. In compatible list as well.

> +              - const: fsl,imx93-edma3
> +              - const: fsl,imx93-edma4
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        interrupts:
> +          minItems: 1
> +          maxItems: 64
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 64

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

interrupts can be max 17, so just test it and you will see errors.

Why names are not listed? If you accept names like "candy" or
"elephant", then why having the names in the first place?

And what about clocks?

Best regards,
Krzysztof

