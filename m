Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A478682E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbjHXHP6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbjHXHP5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 03:15:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15273E4B
        for <dmaengine@vger.kernel.org>; Thu, 24 Aug 2023 00:15:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so856305466b.0
        for <dmaengine@vger.kernel.org>; Thu, 24 Aug 2023 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692861353; x=1693466153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MgLATBYJzz7m+lw2uYv1KHF9JGwpz8b2a+H6baqeGgg=;
        b=FcS0oOd6aB0ImZi68UnNSZl+uztMLQO+hKR5O5gmerz1xHTVNkNEqEY2XtSws7CXCn
         pxscU0RkTra7sIvakFf6UmdJ1hjsmTFLw0TADvPbWzJ24lgmZuceFWkgpPk/gh0D5Dvf
         Tw5yE8gWjRqrpUpk8ds/Kxr5MGZB82o7YpJdI+mNrbyHX4o1JD70Bps+qgIZoyWUcGGu
         Drtv0/Ud8sd3wOSEwrguknfyHl+coRy2dP5HFUpHEeRzx9ZFvt9gldvMG+IfTTSZ2Qt9
         Ft/0TUWH6LXjHCPZGQVJMjlpeGBNNLKYW8Og5Zxtp9zDCRmGg2wFn3ThwrHbMzpy4UWv
         b0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692861353; x=1693466153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgLATBYJzz7m+lw2uYv1KHF9JGwpz8b2a+H6baqeGgg=;
        b=ldl56xNh4YkuxCWCj73TUe3ZLTdh+atDIl9Co5Qrk89ScX6bT5ooMZS7Ly3S59KKhk
         thy0cVUKtYMqDcZbCd2Sw4HsTK5T/uIyacUXJNJwm6/o5RjG6YUzHiPRGiN3A8Dr6K/U
         SuU52HGa8It8d5s41DhP4yIpYH4IMl1b/iknAs87E8nn5MDYIzu1WWq5HpqaMjY5U7Se
         23ZQCNDr7DqnD/TwiTNVTEQHPWY3vZaJCmCySKSqPeqaVi815D+SDevG46X4Ce5QMmUE
         efdsUO7bvWHbyTzf2zQi3mfzAZzhdcHFyS/6fuA9pOCc44uqJ2rutyzY3bwv4HSWkCO2
         8+/g==
X-Gm-Message-State: AOJu0YxHXdJkEivlj6Z8Iz1XwFWVpksfehTcQil7KWf4RgJDvgWoXgV+
        0mKm2hs2/ahi/i5fd0BaFiAgBQ==
X-Google-Smtp-Source: AGHT+IERlDVVWHhshVztkfejQKy+zATfjV9rmg6d5qwDMRx+kT7ZhgVa2HTV0j0RMbXHGk/Q6a2F3w==
X-Received: by 2002:a17:906:1ba1:b0:987:4e89:577f with SMTP id r1-20020a1709061ba100b009874e89577fmr11005277ejg.24.1692861353577;
        Thu, 24 Aug 2023 00:15:53 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm10683298ejb.92.2023.08.24.00.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:15:53 -0700 (PDT)
Message-ID: <b3a6c920-9de5-2788-61ff-beaa60a7a942@linaro.org>
Date:   Thu, 24 Aug 2023 09:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: hisi: Add bindings for Hisi
 Ascend sdma
Content-Language: en-US
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     xuqiang36@huawei.com, chenweilong@huawei.com
References: <20230824040007.1476-1-guomengqi3@huawei.com>
 <20230824040007.1476-3-guomengqi3@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824040007.1476-3-guomengqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24/08/2023 06:00, Guo Mengqi wrote:
> Add device-tree binding documentation for the Hisi Ascend sdma
> controller.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  .../bindings/dma/hisi,ascend-sdma.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml

Filename matching compatible, so hisilicon,ascend-sdma.yaml. hisi, is a
deprecated prefix, so don't use it.


> 
> diff --git a/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> new file mode 100644
> index 000000000000..87b6132c1b4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/hisi,ascend-sdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HISI Ascend System DMA (SDMA) controller

What is HISI? HiSilicon?

> +
> +description: |
> +  The Ascend SDMA controller is used for transferring data
> +  in system memory. It utilizes IOMMU SVA feature and accepts
> +  virtual address from user process.
> +
> +maintainers:
> +  - Guo Mengqi <guomengqi3@huawei.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,ascend310-sdma
> +      - hisilicon,ascend910-sdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      Clients specify a single cell with channel number.
> +
> +  hisilicon,ascend-sdma-channel-map:
> +    description: |
> +      bitmap, each bit stands for a channel that is allowed to
> +      use by this system. Maximum 64 bits.
> +    $ref: /schemas/types.yaml#/definitions/uint64

Why some channels would not be allowed to be used on some board with
ascend310? Who decides on this?

> +
> +  iommus:
> +    maxItems: 1
> +
> +  pasid-num-bits:
> +    description: |
> +      sdma utilizes iommu sva feature to transfer user space data.
> +      It acts as a basic dma controller if not bound to user space.
> +    const: 0x10


Best regards,
Krzysztof

