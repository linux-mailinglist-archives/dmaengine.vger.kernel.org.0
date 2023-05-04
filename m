Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DEC6F6EA8
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjEDPJE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjEDPI6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 11:08:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2746A5
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 08:08:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f4b911570so96693066b.0
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683212920; x=1685804920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIp4DKXxo+zp8Ph9xjPC7rzrFgpP5SUcYok+aLyEVyM=;
        b=g8Li0JxC53ab/FftbLLHq7tOR2Yyc3MYuJ3XUkhUcQx9NIqH5S1oRJO/xMMoE0KULf
         Lo50THCw6Tib59Q7CkXm4JONVy5uYQMLNs3hjVrLsRFSYozCTsTL0pFjsNENKC0/3zRJ
         JFbt7pRugIPXSLPsoNHYTC7Z57GY7yidDzSVDCjhJK4DcT7ksZ8ue3m8sGcqUZi5uQb+
         ZyadixZCBF6WKZMfI1p0X5X4JvhPlU7iLj96PRaKLWa26Z/UUWzyt/+3x8BXayyC7nql
         3PAtceS+CTjMYvI5bES8OWHrT6b0/Kiv95KL1S+auLxnuCsdVF/6heAIlyleRLvG+/b4
         nuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212920; x=1685804920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIp4DKXxo+zp8Ph9xjPC7rzrFgpP5SUcYok+aLyEVyM=;
        b=GgbDYuoViJaXVv4VrqlOAGnH3IX6WG7eeYiU6ViCyOTXdbSxAoOgcRE5wYYGt2xbA6
         1Wk/iwV5PD5viL6PraQrF+r3vH+tA9qr2/0MOaxC35Ml8UtchxHSWkdpzISJAw+eJv7K
         p2htOFCd4DSR7sZA4t0gMBmOQkFKobV6cmEc/Gm2I9tZPNbHIVyDdnXGFOVYwQ2t7uiq
         59DG3icFREb6bDNds72PuPPHP3q8FMlxFyF8Ol1PCpLw4kV4lY8cwDxdgqDmUlaYMvdj
         tvaRD/XhvlCavE3nukYTtrr6jIs4dGd9MClaZCLrauJQwMpy77buUYFVtXjL2aPvFvNa
         XbGA==
X-Gm-Message-State: AC+VfDzfUiwgGapO5Vd8wnrDL1AiS5UfV/lxan7gQ8SXat3SBj4uy6tj
        S5cSRG7iYNWY3B05B7/xEezFkg==
X-Google-Smtp-Source: ACHHUZ6/tidMBBOHdOPNqdgzWoQ8Y6QV5hHtyArlFHEFdIvczhELlOjj2No5eq1nQaZjwcXCvQvqFQ==
X-Received: by 2002:a17:907:a426:b0:94a:9c9e:6885 with SMTP id sg38-20020a170907a42600b0094a9c9e6885mr7259100ejc.58.1683212920481;
        Thu, 04 May 2023 08:08:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id cw5-20020a170906478500b0095728d6f3b6sm17176152ejc.125.2023.05.04.08.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:08:40 -0700 (PDT)
Message-ID: <78616bc1-8d9e-4a1c-70d6-ad62c2cfa8a8@linaro.org>
Date:   Thu, 4 May 2023 17:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 7/7] dt-bindings: dmaengine: pl330: Add new quirks
Content-Language: en-US
To:     Joy Chakraborty <joychakr@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com
References: <20230504145737.286444-1-joychakr@google.com>
 <20230504145737.286444-8-joychakr@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504145737.286444-8-joychakr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04/05/2023 16:57, Joy Chakraborty wrote:
> Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsize"
> and "arm,pl330-periph-single-dregs"

This we can see from the diff. You need to answer why?

> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> index 4a3dd6f5309b..0499a7fba88d 100644
> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> @@ -53,6 +53,14 @@ properties:
>      type: boolean
>      description: quirk for performing burst transfer only
>  
> +  arm,pl330-optimize-dev2mem-axsize:
> +    type: boolean
> +    description: quirk for optimizing AxSize used between dev<->mem

This tells me nothing... Neither what it is about nor why this is
property of a board or PL330 hardware implementation. Please describe
hardware, not drivers.

> +
> +  arm,pl330-periph-single-dregs:
> +    type: boolean
> +    description: quirk for using dma-singles for peripherals in _dregs()

Same concerns.


Best regards,
Krzysztof

