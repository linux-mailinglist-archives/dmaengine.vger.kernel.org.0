Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94EF77B4AB
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjHNIwD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHNIvc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 04:51:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E496BF
        for <dmaengine@vger.kernel.org>; Mon, 14 Aug 2023 01:51:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-986d8332f50so546276366b.0
        for <dmaengine@vger.kernel.org>; Mon, 14 Aug 2023 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692003090; x=1692607890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gM6rcXv3qh9ZZg6fLTgga1lm0ti4rVMB4jfXIK5a0o=;
        b=O8NThQtXSHshTGb9RevvjrXxImoLpRFRZuWqmRD4DnBhEIdq9jbnJa483QrL7v3VZR
         0uPAIYZJ+4At8VCcvjJlPZnoMYB5PauOJhlkocbdNmXhXCi8AlkS9dI0b2dE5D9puya3
         01eIsFEk8zwHAGToXMqd/epwA6Byge7Sd0068EVlXh6VIf+7aCA4Mome2qx9Da7Zju/q
         3ioUdEzvkxSDdhSDQiQIlwTTf/ckJJYCSbWHEnYREPcmmFDqam5KnlnbTBigKwOBfdwh
         9NVEBDSLH2ff+15g4+86LSH/7ZU5vA3K9kFYplEdyFGU5IEE0a6t837g86xZ9igcGytH
         fKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692003090; x=1692607890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gM6rcXv3qh9ZZg6fLTgga1lm0ti4rVMB4jfXIK5a0o=;
        b=REW7qCdViVDzuFH+Pu6P1MmAfW1VtKg9qrkhflsVVTFau1tO0d/cZfgqwPd7/LVyVb
         uRfKPC0A77j35qTRV1Gng9UBzYRM06DEziG+elclsAMT5skoxe9BwR5hCYtr4e5QinDS
         4XTTNhw7WEwetylVUS/sTE6n2sa5B3v3VOqUtcHwT+PcvGHM8ZsnoZH+A9V+V8Ua0e2L
         K8uzE+3ESHObPmIY6ZAMDYZiu7D2BTS7BnzwYd9f3wn+w/5yz/PqcxTHth4RwhUYEOLM
         JOYBDxA2MrZ28b+8FlYiY+RuVtffbFfl8ijXaWOR7HaAGftSJJCCpuPC2cR1DC+HrRR/
         V+xQ==
X-Gm-Message-State: AOJu0YypiZqOojxc7et0EAo6sttOioMiMxUghk419BFzLQWDeOKLJK8o
        sQJE9m7273vGrzGcISEJEX65pg==
X-Google-Smtp-Source: AGHT+IG1MMAJeaupxrQM9SWatk4LMg3tfHwszdj17vADSwjQuyoDKKejrXrJ3BdLwwEG0VPLLlyh4w==
X-Received: by 2002:a17:906:53:b0:98c:e72c:6b83 with SMTP id 19-20020a170906005300b0098ce72c6b83mr6828070ejg.45.1692003089777;
        Mon, 14 Aug 2023 01:51:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709060e0700b0099ccee57ac2sm5457845eji.194.2023.08.14.01.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:51:29 -0700 (PDT)
Message-ID: <2a4751d4-2955-b4d7-f16b-7a3a90fbab3a@linaro.org>
Date:   Mon, 14 Aug 2023 10:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] dt-bindings: dma: hisi: Add bindings for Hisi Ascend
 sdma
Content-Language: en-US
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     xuqiang36@huawei.com
References: <20230811034822.107229-1-guomengqi3@huawei.com>
 <20230811034822.107229-3-guomengqi3@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230811034822.107229-3-guomengqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11/08/2023 05:48, Guo Mengqi wrote:
> Add device-tree binding documentation for the Hisi Ascend sdma
> controller.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  .../bindings/dma/hisi,ascend-sdma.yaml        | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> new file mode 100644
> index 000000000000..beb2b3597f4d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/hisi,ascend-sdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HISI Ascend System DMA (SDMA) controller
> +
> +description: |
> +  The Ascend SDMA controller is used for transferring data

What is Ascend? SoC? Family? Model?

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
> +    const: hisilicon,sdma

Way too generic compatible. It must be *model specific*.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      Clients specify a single cell with channel number.
> +
> +  ascend_sdma_channel_map:

Missing vendor prefix, no underscores in property names, missing type/$ref.


I doubt this was ever tested.

> +    description: |
> +      bitmap, each bit stands for a channel that is allowed to
> +      use by this system. Maximum 32 bits.
> +    maximum: 0xffffffff
> +
> +  ascend_sdma_channel_iomem_size:
> +    description: |
> +      depends on different platforms to be released. There are

Ah, so compatible is not specific enough? No, please make compatibles
specific and drop this property.

> +      currently two possible values. A default value is used if
> +      the property is not set.
> +      - enum:
> +        - 0x400
> +        - 0x1000
> +
> +  iommus:
> +    maxItems: 1
> +
> +  pasid-num-bits:
> +    description: |
> +      sdma utilizes iommu sva feature to transfer user space data.
> +      It act as a basic dma controller if not bound to user space.
> +    const: 0x10
> +
> +  dma-coherent: true
> +
> +  dma-can-stall: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - ascend_sdma_channel_map
> +  - '#dma-cells'
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sdma: dma-controller@880E0000 {

Use lowercase hex and drop unused label.

> +      compatible = "hisilicon,sdma";
> +        reg = <0x880e0000 0x10000>;

Broken indentation.




Best regards,
Krzysztof

