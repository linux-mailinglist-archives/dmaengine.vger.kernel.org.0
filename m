Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7873A664A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhFNMOT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 08:14:19 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:36692 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhFNMOQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Jun 2021 08:14:16 -0400
Received: by mail-ua1-f46.google.com with SMTP id p9so5365140uar.3;
        Mon, 14 Jun 2021 05:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4Iq/knWjwzfpXwSZUSxpj5Oaukze11zDNFuFkO7hjQ=;
        b=TJpszwR/z+45Holrbe/dC2LYm9BY8V3ITyx9+ImfyzPjfx53V88MiqvX23zJJWlNBP
         F3scIHAPe8P+nFgHeFd88Ox5cnLCMrDfXV9jxLM2u8+HlpfcpA6E9a6HgqbP64jqBFV/
         3ONZg/XMPVFdfoJ/01S/IDKpVb/YYEx3t69N6QtT0JEE6PB0QuVeszDrwleZZNm76SFr
         KYCnryfHCkoSZBTNDzvUtIimtIGlOIphXEr3qcHP1YFZo/35qXcnB1qaAGVvla6f0N11
         D+LXrOovqNbH3BEK0/pY51bGG30uia3I/LMJixf6XDaEReyq6oKejqqwM0Pz4qBgnwrb
         U7BQ==
X-Gm-Message-State: AOAM531HcKp9UyqRIPpoIPyECD9cTIEtb4UR3vMl7OWeyAdp0bFLFnMG
        CvsDcrsS8PlpRTbCh9okIdXup62AKs35cxpcYXiT8PyPYKoMDg==
X-Google-Smtp-Source: ABdhPJwnqsYX7iRpE8vBsuVNoKR7cr27Qc4NXONjjirn5j/sIGqnyTffGa9LUYBOK7WFZgySMZinzkEHhTMc7zoiwEk=
X-Received: by 2002:ab0:63d9:: with SMTP id i25mr11354554uap.106.1623672724647;
 Mon, 14 Jun 2021 05:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com> <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Jun 2021 14:11:53 +0200
Message-ID: <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Fri, Jun 11, 2021 at 1:36 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document RZ/G2L DMAC bindings.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/renesas,rz-dmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L DMA Controller
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}

Please use "renesas,r9a07g044-dmac".

> +      - const: renesas,rz-dmac

Does this need many changes for RZ/A1H and RZ/A2M?

> +  renesas,rz-dmac-slavecfg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      DMA configuration for a slave channel. Each channel must have an array of
> +      3 items as below.
> +      first item in the array is MID+RID

Already in dmas.

> +      second item in the array is slave src or dst address

As pointed out by Rob, already known by the slave driver.

> +      third item in the array is channel configuration value.

What exactly is this?
Does the R-Car DMAC have this too? If yes, how does its driver handle it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
