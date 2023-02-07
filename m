Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E568E264
	for <lists+dmaengine@lfdr.de>; Tue,  7 Feb 2023 21:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBGU6H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Feb 2023 15:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBGU6G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Feb 2023 15:58:06 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02AD14499;
        Tue,  7 Feb 2023 12:58:01 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-16a8d511ce0so2119238fac.1;
        Tue, 07 Feb 2023 12:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqtKI6VvbLeNL2RUrUWXNfeUaIXVwWm1vJplGrZvFTs=;
        b=nNvYs5h8RHHeXNfSnkhQlVV1j4DVRxdqpwN2kL6I1Ep53955tdj00uk6KcXiS52OIP
         sIt9b4B5fK6RVgjlqF5emm5setn5WTccPK27YPzOSw0CHzsjdPtTp6NmCvae6hZQAkAl
         Ag9Wk7L2lJuH7dm3SOhFCIdXUWifjE3HBavzoKLNbVsyusfZXw94onO20hg02YtGhG7F
         x/LX1eW2wpaDMeSwEKua9Mv6M1fQNQ5e+fe7iGa5+bZPXKE884rBR66riysm+9fcrtjB
         cuEcomsEMU6e21TsYZeSVNzoVfjc+TYMdsNdS8Q+Es96fSj5liaLzbcvcDxhr8C6XNLF
         sWww==
X-Gm-Message-State: AO0yUKWpDOYJvCq4fjdCplncDdNK7pFxeW7+n2tYk35SNPk3AwUr/snY
        eK17twfE1xkUKg6xcOkYext5kdnjgA==
X-Google-Smtp-Source: AK7set9bFssBm+5bRaiQQaqfvXv/9qHnz1QnYd/r18TnCsF10XdNoZ3shz76XhSe7GxcLpeT/Kg5Gw==
X-Received: by 2002:a05:6870:ec91:b0:16a:2a6d:9e40 with SMTP id eo17-20020a056870ec9100b0016a2a6d9e40mr2489358oab.29.1675803481127;
        Tue, 07 Feb 2023 12:58:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b9-20020a9d6b89000000b0068bcef4f543sm7025713otq.21.2023.02.07.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:58:00 -0800 (PST)
Received: (nullmailer pid 4142751 invoked by uid 1000);
        Tue, 07 Feb 2023 20:58:00 -0000
Date:   Tue, 7 Feb 2023 14:58:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: dma: snps,dw-axi-dmac: Update resets
 and add snps,num-hs-if
Message-ID: <20230207205800.GA4140140-robh@kernel.org>
References: <20230206113811.23133-1-walker.chen@starfivetech.com>
 <20230206113811.23133-2-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206113811.23133-2-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 06, 2023 at 07:38:09PM +0800, Walker Chen wrote:
> Add two reset items and properties 'snps,num-hs-if'.
> The DMA controller needs to be reset before being used in JH7110 SoC.
> Another difference from the original version is that the hardware
> handshake number of DMA can be up to 56 while the number in original
> version is less than 16, and different registers are selected according
> to this.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml          | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 67aa7bb6d36a..1a8d8c20e254 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -9,6 +9,7 @@ title: Synopsys DesignWare AXI DMA Controller
>  maintainers:
>    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>    - Jee Heng Sia <jee.heng.sia@intel.com>
> +  - Walker Chen <walker.chen@starfivetech.com>
>  
>  description:
>    Synopsys DesignWare AXI DMA Controller DT Binding
> @@ -21,6 +22,7 @@ properties:
>      enum:
>        - snps,axi-dma-1.01a
>        - intel,kmb-axi-dma
> +      - starfive,axi-dma

This should be SoC specific.

>  
>    reg:
>      minItems: 1
> @@ -59,7 +61,12 @@ properties:
>      maximum: 8
>  
>    resets:
> -    maxItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: axi-rst
> +      - const: ahb-rst

'-rst' is redundant.

>  
>    snps,dma-masters:
>      description: |
> @@ -74,6 +81,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2, 3, 4, 5, 6]
>  
> +  snps,num-hs-if:
> +    description: |
> +      The number of hardware handshake. If it is more than 16,
> +      CHx_CFG2 is used to configure the DMA transfer instead of CHx_CFG.

Can't you infer this from the compatible string?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 256
> +
>    snps,priority:
>      description: |
>        Channel priority specifier associated with the DMA channels.
> -- 
> 2.17.1
> 
