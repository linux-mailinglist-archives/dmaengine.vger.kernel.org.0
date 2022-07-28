Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4EB5847D8
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 23:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiG1Vun (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiG1Vul (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 17:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF01F629;
        Thu, 28 Jul 2022 14:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 903A361AC7;
        Thu, 28 Jul 2022 21:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1600C433D6;
        Thu, 28 Jul 2022 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659045040;
        bh=TIOCNvw+17eRmNBfMFABH6VkBMWnuv6D1qn6yCQMJrw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YBHZYgsKrAuDGDNxgcUIVjuVNislrbcEKsfe/xHrKkvXsKbsnBm0l7C12G3Oa27q8
         PlIDnNyVuOSJwbT5Tji2DrzAkwZrc7HNnhNGn3hnDQppcEIXDFS18u0aW3hlVT4faS
         BixsHF3y5wiguEnyPr1Qjeqob4YsQfoQoYjcA2YwSE8Sfoo06FHJFVTEi068Uyen5r
         ziANQly7ihmRuTQObzk0XUjy4fvNHaykq0bFtfMvNNtVcLhN69mrWl30UFI35gbBpY
         ObP2ygENYWaoQHDMCJyzZisRqkcfs++QU6Eod7c+qpNHrwaLu8Ia2lE3tqMKI4vDs3
         PF1oFXvnSirvw==
Received: by mail-vk1-f178.google.com with SMTP id b2so1445361vkg.2;
        Thu, 28 Jul 2022 14:50:39 -0700 (PDT)
X-Gm-Message-State: AJIora8ApiSScivdsEJbgBiWjU+0/Fs9/d2CT7dRLiFUy++vjgroT6VL
        gdJq8V5oKVIc5X+7Y95wsABumUYdWAZp4x76HQ==
X-Google-Smtp-Source: AGRyM1ummHcv4YmBzQF2UjMZlRgMn8EgYxyFbY/AxWBSezepPmZZ6gULxdnDc+jSowPTBq4nLYPRsyqBX5nG9adIf9Q=
X-Received: by 2002:ac5:c916:0:b0:376:f130:808f with SMTP id
 t22-20020ac5c916000000b00376f130808fmr245211vkl.19.1659045038884; Thu, 28 Jul
 2022 14:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220728185512.1270964-1-robh@kernel.org>
In-Reply-To: <20220728185512.1270964-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Jul 2022 15:50:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGmL7BTibEJM0NWRmazOJBsNDLAWFtvth=oBOQQmn_VQ@mail.gmail.com>
Message-ID: <CAL_JsqKGmL7BTibEJM0NWRmazOJBsNDLAWFtvth=oBOQQmn_VQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: arm,pl330: Add missing 'iommus' property
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 28, 2022 at 12:55 PM Rob Herring <robh@kernel.org> wrote:
>
> The pl330 can be behind an IOMMU which is the case for Arm Juno board.
> Add the 'iommus' property allowing for 1 IOMMU per channel.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> index 2bec69b308f8..b9c4bee178ae 100644
> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> @@ -55,6 +55,11 @@ properties:
>
>    dma-coherent: true
>
> +  iommus:
> +    minItems: 1
> +    maxItems: 8

Off by 1. Juno has 9 entries. I think it's 8 entries for write the
read side has 1 entry. The TRM isn't too clear.

Rob

> +    description: Up to 1 IOMMU per DMA channel
> +
>    power-domains:
>      maxItems: 1
>
> --
> 2.34.1
>
