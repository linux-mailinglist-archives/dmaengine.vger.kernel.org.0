Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C179E369
	for <lists+dmaengine@lfdr.de>; Wed, 13 Sep 2023 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbjIMJUn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Sep 2023 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIMJUm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Sep 2023 05:20:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA21F1993
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 02:20:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502e0b7875dso299629e87.0
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694596836; x=1695201636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBGdzxR9ocL4b+5O1mrX3Hu9m0lqE8hXttq1KoCZLnc=;
        b=QXpEZG5/ueXFBiYrXeQy4Jxuz7G2GyQpWKaJZSf3bZbxVHw9/JAbWFqRHW/IhXpbyA
         uCu6DoH1bd6P7vq8sVNDK6piFU7SJv0VIPkKordoYN7tQJWSLa9NqQYOQ1GwZTA8C+w8
         ucZGI7fT3Hj3/jgvh6BuCKncFGfzaEccS6L7+vfkVhRqn4aX79sau4gFIvHaQAHdn3aE
         +cIr92Mkbcv8y4dC+8O7hc4XxfWbvwI9/YAGRQyrXyxSuZjrXhHBuHKPjW0Ir3xRkwpR
         9lMVn3XuGvPPULUXYuBBI/DsAyEOIxnWGnkeIhDuypIxRscMVCk7NM9kMKhR3QOUDZFb
         q09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596836; x=1695201636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBGdzxR9ocL4b+5O1mrX3Hu9m0lqE8hXttq1KoCZLnc=;
        b=SYoc7mN/65jx9PInDOt6ACKsK9WnmikjszGJuWUlbceX7m4tJUa0vDqDzaTAbTvbhS
         vhhW+VEj6oNQy73w4vR8o3kePfLMV6xA19Yia0GJuOAO+TVgOoz9v/EJvRNoOL+ihRuM
         lOIpMPtdAeMAvQ7YOH1Srn9WDXC7NTVLcvyj6K7vtWoHuD7K4uKL5JOIkH2jVtF0O0E7
         vfEH3oouCoaSSOaHUJzlGPr0bJqFWoakcaQ9fkhg5zJcaoXwJBrn5hIzY/ZF8NRWlF/o
         bHQZhxkQ4i+fMlb0RiMljohWHc9d2PpjcKm/7bFNMqmm5yltjwrxnhr2qn9fE93e6fT4
         P3SQ==
X-Gm-Message-State: AOJu0YxhXeepr4K9aObEqjr1XhqT+H+MiotWzohWE/b5HYiL8aYriIt+
        4wDS4UWP0TR78+wUnpJj2z8h/w==
X-Google-Smtp-Source: AGHT+IFdbVrtKvqtfbdZXSnIdT83CYsRHZlhQPIYwLWUoZBuwzgCqFYEv+FrNDKPcT1Mp+jjsvoqQg==
X-Received: by 2002:a05:651c:104b:b0:2bc:d94f:ad04 with SMTP id x11-20020a05651c104b00b002bcd94fad04mr1742390ljm.13.1694596836120;
        Wed, 13 Sep 2023 02:20:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id oy26-20020a170907105a00b0099d45ed589csm8073164ejb.125.2023.09.13.02.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 02:20:34 -0700 (PDT)
Message-ID: <8eff1f20-1cfc-7097-da26-97daaae5e8ca@linaro.org>
Date:   Wed, 13 Sep 2023 11:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/2] dt-bindings: dma: HiSilicon: Add bindings for
 HiSilicon Ascend sdma
Content-Language: en-US
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     xuqiang36@huawei.com, chenweilong@huawei.com
References: <20230913082825.3180-1-guomengqi3@huawei.com>
 <20230913082825.3180-3-guomengqi3@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913082825.3180-3-guomengqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13/09/2023 10:28, Guo Mengqi wrote:
> Add device-tree binding documentation for sdma hardware on
> HiSilicon Ascend SoC families.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---

> +  dma-channel-mask:
> +    minItems: 1
> +    maxItems: 2

Why 2? Care to bring any example? Where is your DTS?

> +  iommus:
> +    maxItems: 1
> +
> +  pasid-num-bits:
> +    description: |
> +      This tells smmu that this device supports iommu-sva feature.
> +      This determines the maximum number of digits in the pasid.
> +    maximum: 0x10
> +
> +  dma-coherent: true
> +
> +  dma-can-stall: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - dma-channel-mask
> +  - '#dma-cells'
> +  - iommus
> +  - pasid-num-bits
> +  - dma-can-stall

I am not sure if requiring dma-can-stall is correct here. To my
understanding this is in general optional property.

Best regards,
Krzysztof

