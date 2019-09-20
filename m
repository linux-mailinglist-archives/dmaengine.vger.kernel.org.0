Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB9B8E31
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2019 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437968AbfITKBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Sep 2019 06:01:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39118 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437988AbfITKBs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Sep 2019 06:01:48 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so14842179ioc.6
        for <dmaengine@vger.kernel.org>; Fri, 20 Sep 2019 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g994BJg/jPAigCOVsri275vhxV1YMwyqa+ZWpEcSJHY=;
        b=iFc44JyzXlsEdJ8ZGOrWgpTK0QF37LYXPDpneIFX6jIh3j9MM3sAu1JGGTadYRKuwW
         CGl0Fmrl34Sy+7DxuUlu82SW2IVLCHpQOmoeAApYxtgGdXZ4U4i504sEJ9qWkIE2mR0k
         gWIeJskW/cZLd2m2sNLkxAFFne9NpN8DuiK+ZshTWQJboqhi3fk5xYVnFyDkbDoGmDam
         5xiLOm5+J+eEPhm2b+N/5/2Xo/v4KTqIeYmEtXWgDctdq8wzZvJ/nzPPedZwHZKdqTOZ
         vrp0QrFtQntkesy5Rp7I1O5fqPAz5BGq6ELB/cOVvXCoOkAZYUNmwlxjXXRnSLmzsb8Y
         /3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g994BJg/jPAigCOVsri275vhxV1YMwyqa+ZWpEcSJHY=;
        b=M3dxmpW/bMJ5D+usTEO3m4bwXWYm9aVo1IZVjwTkluBDxS0dh+3ukl5pXsebL1nrTd
         qgXMNEOxxE/af1deeBvAI5HhNuvW6WbctZzAPF8RO5UBrEtvEdC52Qnb155UZY27jZx1
         h5an9wFIa8tdgfW1ZorW2KMRafHkerXN7EbDXexY8qzAuGTR9OsEDifb8oXZ624c6a45
         MdeUnAZev9WS1ZWQI9OlylsMEAVecUDQ+UOgOwkqoBr0tVW5dm+/lmJN661yVpioqnjN
         2ndDUXZxuetiW/luB2rKixBRwaWTngCzWi9lA9tofuQDUn2gRPmMX64iFmOoHhZWC/iB
         8AMA==
X-Gm-Message-State: APjAAAWDssGKpEUIIkGy1sAPe9HyDcWtvGTfOYRkSHxPA3qIbDiz6QL4
        tN7LUnSkEbbE4xaVM12yjCjPIOKwmZFAoH6YMHiVZw==
X-Google-Smtp-Source: APXvYqxfUxvLHOR+Wn2vv6/tsz0PWRvLzPL3QAajZParvvSIWZcYkRXLxLuyaEQmx0JgaIHOXcW/CUZEbaflcc7pARM=
X-Received: by 2002:a6b:e719:: with SMTP id b25mr11639828ioh.100.1568973705798;
 Fri, 20 Sep 2019 03:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190920090033.19438-1-green.wan@sifive.com>
In-Reply-To: <20190920090033.19438-1-green.wan@sifive.com>
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
Date:   Fri, 20 Sep 2019 15:31:35 +0530
Message-ID: <CAN8ut8Lfo3zm2mjoiH3o4FSTkHexagwUFT=V3MpgcE=arm5c4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: sf-pdma: add bindins for
 SiFive PDMA
To:     Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 20, 2019 at 2:30 PM Green Wan <green.wan@sifive.com> wrote:
>
> Add DT bindings document for Platform DMA(PDMA) driver of board,
> HiFive Unleashed Rev A00.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> new file mode 100644
> index 000000000000..3ed015f2b83a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/sifive,fu540-c000-pdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Unleashed Rev C000 Platform DMA
> +
> +maintainers:
> +  - Green Wan <green.wan@sifive.com>
> +  - Palmer Debbelt <palmer@sifive.com>
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +
> +description: |
> +  Platform DMA is a DMA engine of SiFive Unleashed. It supports 4
> +  channels. Each channel has 2 interrupts. One is for DMA done and
> +  the other is for DME error.
> +
> +  In different SoC, DMA could be attached to different IRQ line.
> +  DT file need to be changed to meet the difference. For technical
> +  doc,
> +
> +  https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,fu540-c000-pdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 8
> +    maxItems: 8

"make dt_binding_check" should give you the error that interrupts is too short.

When you say minItems: 8 then interrupts property should be like this:
interrupts = <23>, <24>,  <25>,  <26>,  <27>,  <28>,  <29>,  <30>;

So,  remove the minItems: 8 and change maxItems: 1 for interrupts =
<23 24 25 26 27 28 29 30>;

> +
> +  '#dma-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#dma-cells'
> +
> +examples:
> +  - |
> +    dma@3000000 {
> +      compatible = "sifive,fu540-c000-pdma";
> +      reg = <0x0 0x3000000 0x0 0x8000>;
> +      interrupts = <23 24 25 26 27 28 29 30>;
> +      #dma-cells = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49f75d1b7b51..d0caa09a479e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14591,6 +14591,11 @@ F:     drivers/media/usb/siano/
>  F:     drivers/media/usb/siano/
>  F:     drivers/media/mmc/siano/
>
> +SIFIVE PDMA DRIVER
> +M:     Green Wan <green.wan@sifive.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +
>  SIFIVE DRIVERS
>  M:     Palmer Dabbelt <palmer@sifive.com>
>  M:     Paul Walmsley <paul.walmsley@sifive.com>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-hackers" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-hackers+unsubscribe@sifive.com.
> To view this discussion on the web visit https://groups.google.com/a/sifive.com/d/msgid/linux-hackers/20190920090033.19438-1-green.wan%40sifive.com.
