Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4043872A098
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFIQtG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFIQtC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 12:49:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D57C30C1
        for <dmaengine@vger.kernel.org>; Fri,  9 Jun 2023 09:49:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9768fd99c0cso662162166b.0
        for <dmaengine@vger.kernel.org>; Fri, 09 Jun 2023 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686329340; x=1688921340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSvYel0oSeG4uzRcYI5j4gpx20764e2Nwh+/Z/Nnl1A=;
        b=GqaA6BXrI4NSSBQiawEV3px6ukzbXAokvUgPsE170MIYdj5lW9YzBNK3Iud1KmB+3j
         YcZ5ydWfizNk4R2X/+4Q/VDf5hidvFJullxNHwG95VYPHSCNDOxXEJPPg/JDF7ReICGe
         Aha1LH9bxO1FXE9PcpqAWCkxy3D+7eqTRe3HXJaki1cwz0lhHw3imgeln+EGCEx02B7Z
         VAUSPuqmk3cwHTa3LFfKywNX2hRq/ORwgaEtnJXOWp77y1vfcFx+kScZw1/7jb+iwp0l
         8H7irS+fJbyEWhl3B0ZAAwiqcWkImoUBLlOBAns4YCilxJMkTiPl1hk0GnrFYtl1C4sv
         0svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329340; x=1688921340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSvYel0oSeG4uzRcYI5j4gpx20764e2Nwh+/Z/Nnl1A=;
        b=Er0DsEJjYHxEmb+RnqEQsiClnjp09mZPY9PTr4dCnjc2cJhqtsUA6lYF47wtMhBr4Z
         MxCE4w6J7AwoELclr9AXT8j/N7nIA3PxiF2Q6MowCx/WwjDlmJf6H6o7YhcYtcmAewdz
         46DUsSeSl1J0u8ppviFUcSJ1Z303vTbkC6A4AKGuWdrhDhLi2JS/XboPfYM5Q6AKWyGz
         I+SpKCSm5gH19pBmr0oYyeVzuhmlXUDtHMDPVLerleokaeNKpXwpzxuBuDjJjXJCGnK7
         3kv0vZMA0zAMy46vtQY1V/NCwEfmW1rj5FsoAazczoxgwcnbZmpR24VztORkK+wEcFNe
         BBhg==
X-Gm-Message-State: AC+VfDz4qhWyN6B3UDlkcaEtxr+ZYL6BYM2gkySgSeTaI7PBU5rt+132
        Ni8F8fB5wfAUacKF8+qGRUJNbA==
X-Google-Smtp-Source: ACHHUZ6fNIBlf5NkJCpoQyReFyo7EbA99Bdav938siA0HlK0sEn9NZuqD/s/Grj6odVySPMsl3BE6g==
X-Received: by 2002:a17:907:7291:b0:973:7096:60c2 with SMTP id dt17-20020a170907729100b00973709660c2mr2663964ejc.20.1686329339740;
        Fri, 09 Jun 2023 09:48:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id sd2-20020a170906ce2200b009749b769c95sm1480759ejb.158.2023.06.09.09.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:48:59 -0700 (PDT)
Message-ID: <68bb3816-d707-3a21-59a2-8785dce7210a@linaro.org>
Date:   Fri, 9 Jun 2023 18:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: dmaengine: Add Loongson LS2X
 APB DMA controller
Content-Language: en-US
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
References: <cover.1686192243.git.zhoubinbin@loongson.cn>
 <bb2d5985a3d9fd8e7ccbe2794842d93a8978d8a6.1686192243.git.zhoubinbin@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bb2d5985a3d9fd8e7ccbe2794842d93a8978d8a6.1686192243.git.zhoubinbin@loongson.cn>
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

On 08/06/2023 04:55, Binbin Zhou wrote:
> Add Loongson LS2X APB DMA controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls2k1000-apbdma
> +      - items:
> +          - const: loongson,ls2k0500-apbdma
> +          - const: loongson,ls2k1000-apbdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    const: 1

If it is const, why do you need it?

Best regards,
Krzysztof

