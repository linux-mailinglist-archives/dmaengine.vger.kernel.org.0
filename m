Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A293A9920
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 13:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFPL0B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 07:26:01 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:42767 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhFPL0A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 07:26:00 -0400
Received: by mail-vk1-f179.google.com with SMTP id h19so518017vkh.9;
        Wed, 16 Jun 2021 04:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6H8HV+yYhiLsWFPQ5hwiLvy4OeY2nGRpVbPhHAp1d4=;
        b=QkgPDPAWfJBtPcDQ51rc8Fgvvdpopcf0qqjr7CAZlfF5hSSqmLH7mqLobYihhaQKQi
         rVMH70WacFiNFy4Qc4uCa4PcMHHGfsNyr4EImcaVwhm3vkwsnJcKZfixMl44PQsI82fn
         E46WiAFSjd9Cby86wd0YnOqJypu/hlGQllgauW5agWsGzUUrIzo9Mp883YP50SueBXDb
         PML3aHf4Gskfc9cMuSYsMpscGd1a8Q4i1CiwdZhvsvUmb7J8Gp4VSHiWr4/bezvQfz1s
         s+IGfiJegttNeAMXoLCygXXXPJpmDZSaDjzwX8w2lAcgezCsOrjuSadEkRO84tNtCS0T
         FPrg==
X-Gm-Message-State: AOAM533Q+qpsg0KX+BzaXhXgg5GSS63sU/+QxaXSuHOyvJavyqc4y/Ql
        GyK0krhKoDvcE9289EDYW6SLyeVY8pMYzqqSadHezt+PvO431Q==
X-Google-Smtp-Source: ABdhPJwSsL8YKYrgfHKJtseJ19eNaOuHoZ5jqt+V+bBfwBHIYIq5pKsF8b01uY61RMq9Ogy7RyvwhieCJWY/1iaN9ho=
X-Received: by 2002:a1f:d8c3:: with SMTP id p186mr8535926vkg.1.1623842632721;
 Wed, 16 Jun 2021 04:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210616105557.9321-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210616105557.9321-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Jun 2021 13:23:41 +0200
Message-ID: <CAMuHMdUHiO1VP0jC5RJ6Mc1uk28bURy0tgbM4Myzp+jS87E-TQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: dma: Document RZ/G2L bindings
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Wed, Jun 16, 2021 at 1:14 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document RZ/G2L DMAC bindings.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in
> next 5.14-rc1 release.
>
> v1->v2:
>   * Made interrupt names in defined order
>   * Removed src address and channel configuration from dma-cells.
>   * Changed the compatibele string to "renesas,r9a07g044-dmac".

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml

> +  interrupt-names:
> +    items:
> +      - const: ch0
> +      - const: ch1
> +      - const: ch2
> +      - const: ch3
> +      - const: ch4
> +      - const: ch5
> +      - const: ch6
> +      - const: ch7
> +      - const: ch8
> +      - const: ch9
> +      - const: ch10
> +      - const: ch11
> +      - const: ch12
> +      - const: ch13
> +      - const: ch14
> +      - const: ch15
> +      - const: error

You may want to put the "error" interrupt first, like renesas,rcar-dmac.yaml
does, to make life easier when the next SoC reuses this block, but
with a different number of channels.

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
