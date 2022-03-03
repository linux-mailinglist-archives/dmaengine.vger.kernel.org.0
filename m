Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A464CB9D9
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiCCJIJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 04:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiCCJII (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 04:08:08 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51617776E;
        Thu,  3 Mar 2022 01:07:23 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id j12so2326384vkr.0;
        Thu, 03 Mar 2022 01:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvhjvqX/ORl1h+Ros5nFxo3M1sWx2Alkxm/DTftA/zE=;
        b=XryT5S3Cg1yUzAxrhRbrNE1STE7TlgYBZFF1myYQRL/J82m4rwIAsLMN4/JyfzYAt7
         SsYNa7VABueGVVgZ1XqMzx7xZxTe5Q6cDU2FdrtHsEBXiwLQd6Z5xE+fEhCjq4jBUPIn
         U9LbyNLcxyNdoEDPhmzmiGRxZ3bkP9fP1fUfYgAS84uq+VwFt3KCOb0kpjDt0ZKBCNjY
         B+d+gZis2UzDq1ckYoEZB+ZA8NUY6U9d8iQn28W4YFPgJdPFt0YB1q/l5CpHctSTd+q6
         goE8bczuCH0DhkBoqoWM0x0iDWyAs1Wsq+jvju3TUMe/nxPiD0iHjuLMWDhAmKHwoYMJ
         zU+Q==
X-Gm-Message-State: AOAM530qsLAidFI2kDjpvr5mqQ7SD6V63+Q5v0Gv8b7D8flTgP2euSdY
        TpzPcNK8Jxsm6TFacBKqulmgoPq71OOcLA==
X-Google-Smtp-Source: ABdhPJwDYcMmuj0GNWeKWZlx/qSTPZqWH2z+Ty/grFnZGez2KUBatwKTCwtOCzkFfE0WA5zkoh5S8Q==
X-Received: by 2002:a05:6122:e47:b0:321:73dd:d8cd with SMTP id bj7-20020a0561220e4700b0032173ddd8cdmr15100111vkb.37.1646298442561;
        Thu, 03 Mar 2022 01:07:22 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id q131-20020a1f2a89000000b003209a39cc60sm239518vkq.5.2022.03.03.01.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 01:07:22 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id g21so4767774vsp.6;
        Thu, 03 Mar 2022 01:07:22 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr14185854vsl.68.1646298441808; Thu, 03
 Mar 2022 01:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20220303090158.30834-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220303090158.30834-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Mar 2022 10:07:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUXXkoeAU7as+-t5AkWv4Y6ZW15wwDSozOeH+gZetD1YA@mail.gmail.com>
Message-ID: <CAMuHMdUXXkoeAU7as+-t5AkWv4Y6ZW15wwDSozOeH+gZetD1YA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Update compatible string for
 RZ/G2UL SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Thu, Mar 3, 2022 at 10:02 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Both RZ/G2UL and RZ/Five SoC's have SoC ID starting with R9A07G043.
> To distinguish between them update the compatible string to
> "renesas,r9a07g043u-dmac" for RZ/G2UL SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -16,9 +16,9 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - renesas,r9a07g043-dmac # RZ/G2UL
> -          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> -          - renesas,r9a07g054-dmac # RZ/V2L
> +          - renesas,r9a07g043u-dmac # RZ/G2UL

Is this really needed? As far as we know, RZ/Five and RZ/G2UL
do use the same I/O blocks?

> +          - renesas,r9a07g044-dmac  # RZ/G2{L,LC}
> +          - renesas,r9a07g054-dmac  # RZ/V2L
>        - const: renesas,rz-dmac
>
>    reg:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
