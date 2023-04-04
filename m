Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448E6D6DFB
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjDDUZ2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDDUZ1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 16:25:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1840DA;
        Tue,  4 Apr 2023 13:25:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y7so2789532ljp.2;
        Tue, 04 Apr 2023 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdVOp6TEByE8UdEBDElxuueJryeVxuFj0izGH8bI5FA=;
        b=n7Q2hcHCwV4xAu2Lcc78aU9/xze2He3D+4lqnC/fW2KzdbtoTLraGZCtIoWoHmvG3t
         KRVmSnvhQ75kiFk5dzfbp+OxvwNcFDPoiVR06Nt4QYWWSsHouvFO632CawAUWQ+MCOl/
         Fsxh6OPWhC43BAAwpyEs/RZ52t1iTb8I9cASVKWXHdAMMGoIU+s4xUTT0aYwlEwGo3TH
         xi09+fl6rAQ60yeaTPpmfSu2b9cRxZ1D/rtEllp84EuBg2/6Vqp40E/2kyJseMpk9/kI
         +8RgV6l0Fe7LBVNS8f+1Mo9yqzIqzkQUFr1eZDUpXgHZ+dz6Bh+PHmn1MkNKYSzZNEif
         Jl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdVOp6TEByE8UdEBDElxuueJryeVxuFj0izGH8bI5FA=;
        b=QKrMXP5jQwa3gmCdWI4DWf47+f5rYRW5GRUnC542C6tkwIP+Xf/TFnrUKUc0f/IheU
         OeHGdCpkt8/0T6mguvGpg5pSUj1dF/qL77Aj9CYvNvNoz6LwXOASd3ej6JMh0XQ1yWN9
         ZE4B9da51A3tGqmICuGUdgTPIVgVm1rNyeKB48UHRhSbzJFKqkwn6GmHRfvj7RWe45TL
         91isKrWHJnZSDcwir96u/oYsU0XYPnCXJLjVITYiajoghlDuXuiDdt/RMkiv7xL0vbde
         3hscb4XyPX5fZ99LfrcOOlVETF0qem5cXAI68PmxfVcXxshc2tjzYZcTdJIsjeyWNTa5
         yffw==
X-Gm-Message-State: AAQBX9dCGSYvdcL5HOGiVN3FXeutTUctxOaECHQy32e4oYNpb9Lb0Yd0
        XJCMp4XPU3Kaq2ZcHQ49jKU=
X-Google-Smtp-Source: AKy350bj97qXyxlY2qv2yQiwmY+JCZKB58aYdzAoiWzCGtsioxV5O3hQ+aoqjKdG5eVSAwJpAZ/jkQ==
X-Received: by 2002:a2e:240b:0:b0:29a:eee6:f79d with SMTP id k11-20020a2e240b000000b0029aeee6f79dmr1065387ljk.22.1680639924098;
        Tue, 04 Apr 2023 13:25:24 -0700 (PDT)
Received: from [10.0.0.100] (host-213-145-197-218.kaisa-laajakaista.fi. [213.145.197.218])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b002935005f782sm1594292ljl.57.2023.04.04.13.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 13:25:23 -0700 (PDT)
Message-ID: <62a281bd-9d75-4a7a-e937-a6669bd570f3@gmail.com>
Date:   Tue, 4 Apr 2023 23:25:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dt-bindings: dma: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230331182141.1900348-1-robh@kernel.org>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230331182141.1900348-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 31/03/2023 21:21, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/dma/ti/k3-udma.yaml           | 2 +-

for the k3-udma:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

>   .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml     | 2 +-
>   .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml       | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> index 97f6ae9b1236..22f6c5e2f7f4 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> @@ -43,7 +43,7 @@ description: |
>     configuration of the legacy peripheral.
>   
>   allOf:
> -  - $ref: "../dma-controller.yaml#"
> +  - $ref: ../dma-controller.yaml#
>     - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>   
>   properties:
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> index c0a1408b12ec..23ada8f87526 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> @@ -15,7 +15,7 @@ maintainers:
>     - Michael Tretter <m.tretter@pengutronix.de>
>   
>   allOf:
> -  - $ref: "../dma-controller.yaml#"
> +  - $ref: ../dma-controller.yaml#
>   
>   properties:
>     "#dma-cells":
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> index 825294e3f0e8..d6cbd95ec26d 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> @@ -16,7 +16,7 @@ maintainers:
>     - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>   
>   allOf:
> -  - $ref: "../dma-controller.yaml#"
> +  - $ref: ../dma-controller.yaml#
>   
>   properties:
>     "#dma-cells":

-- 
Péter
