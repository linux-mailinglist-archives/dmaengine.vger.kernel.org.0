Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771471FC18
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjFBIbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjFBIam (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 04:30:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B8DE69
        for <dmaengine@vger.kernel.org>; Fri,  2 Jun 2023 01:30:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso274172166b.0
        for <dmaengine@vger.kernel.org>; Fri, 02 Jun 2023 01:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685694631; x=1688286631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQvGXlwYNpxP39XECJwe50ki1FF0UNPSrkXWOJanzg8=;
        b=BUnvkl3KlatnpU1gmpZ3HNiuhKYdSs+i3mQbPebe6QLJ/z7MTmpoiFIjDcBlPJXW4a
         y0FS0rseiOdMQG+INQOrBnmuyZ0sVw9t48m8r+gyBoiC0nNLfRP8ki9r6k53gWSWSAOU
         prfoYKiITXP/BaAaQw6vGm+m2730Aueg9EQV/7UrT4Xdo7DlJYJOyAhn8Wp6+Yeq+xFV
         cqkqnkbF6IBz8oRw7NLESinrxI4Y2JxkLKALvQM0LQ7/MQ1r50x2oF1yKC2uHKrxZd9j
         syExMZXuvjPAzw8O9UJSyhjCmR7OVgQCTxPnYBrppBy03s+3084YHcN4gqbcC6/YBNsY
         4qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685694631; x=1688286631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQvGXlwYNpxP39XECJwe50ki1FF0UNPSrkXWOJanzg8=;
        b=eZIXuj8lXD50zNnL0+7Vdu2EweNX4v0psfMuw9/wpwSsPSoyO+hN/DPzpm/ISi30Cy
         IKxqRFL/E+OqCAbY35M5t6fhl83MViYtnb3Vrye19bxetgn/5qLRa+PdPjtqGrJhQ676
         C2fKQBXxVe7LXwNH/U75tDxk33dmC1YkhGe4a8ruk1iysJSYpjj56PxNn0YPp80il1fb
         05dqx2NqgCIVoewvyg/OOG47MlQoxWmHj3ap70Esglrvlj7h5Nqi5SmJvexKgUgqwamy
         b86q+H0+gcsX0alIYvxrequpYL5JMVtZbk5ZiHHb4CLicINQGDdV4qhWpGQRg140reWe
         WeqA==
X-Gm-Message-State: AC+VfDwHH30fc+vorooZRQNun7cGvUDreLqXyusCBPD413B+KQVkvZ4x
        G9xpYBktWYvsflRWirgRFh/YOA==
X-Google-Smtp-Source: ACHHUZ7G8yszVNtZpSBhnnN/hj7bHiQZkmDIzbik6j2BM2kED4cdcCCx3gP0fzidUz7EKpGwUrviEw==
X-Received: by 2002:a17:907:9628:b0:973:ad8f:ef9b with SMTP id gb40-20020a170907962800b00973ad8fef9bmr11796271ejc.5.1685694631401;
        Fri, 02 Jun 2023 01:30:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b27-20020a1709062b5b00b0097381fe7aaasm466761ejg.180.2023.06.02.01.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:30:30 -0700 (PDT)
Message-ID: <9c7b30d7-c9b5-3006-5e1a-fa05ebbd7df9@linaro.org>
Date:   Fri, 2 Jun 2023 10:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
 <20230601144107.1636833-13-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601144107.1636833-13-Frank.Li@nxp.com>
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

On 01/06/2023 16:41, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..ec0fe8735ec7 100644
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
> @@ -49,6 +53,10 @@ properties:
>    clock-names:
>      maxItems: 2
>  
> +  fsl,channel-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description: A bitmask lets you skip certain channel.

There is already a property for this - included in your binding:
dma-channel-mask. Use this one.

Best regards,
Krzysztof

