Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC4B80FD
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfISSnR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 14:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388882AbfISSnR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Sep 2019 14:43:17 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B229207FC;
        Thu, 19 Sep 2019 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568918595;
        bh=glOb8s+1ryg5HNxT7Y4/e5hT0T+6wfRsV2Bzu3qQtPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQeaODO9r7UEduye62Nwuxq/KXSRsnWU0sDeTKNIw+qnkGrG4m/YTdOl/c1kGiQbD
         1NQ+K06ho/A5qPryH8kpCXMK/Hh59JJXTTj52/3afcOPhlgZokibHVX1Jn3XllJUME
         3MTTtvPvvJg7TZzTdwqYBwvFpMFMdw/J+xS8tgLE=
Received: by mail-qt1-f180.google.com with SMTP id c21so5493023qtj.12;
        Thu, 19 Sep 2019 11:43:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVA1whCCk18VjZF+9djs03Yww9ER564AvTFIsn9hw9olj/UXeKo
        qapIwgueKUklzH9o6C0sBDlPSKo1cJMWONMCkQ==
X-Google-Smtp-Source: APXvYqzYRjSHeCplQvU/HgHTr+JQ7fo3IMGXguIVIbJ4HeWjQJF0dBTtYzJPaRGSQESSfpc0180ARBKYP51e00zy3x0=
X-Received: by 2002:ac8:75c7:: with SMTP id z7mr4916939qtq.136.1568918594807;
 Thu, 19 Sep 2019 11:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190919072756.1973-1-green.wan@sifive.com>
In-Reply-To: <20190919072756.1973-1-green.wan@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Sep 2019 13:43:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWV=V8ja1b4GoQRg+SxVx4cSYStV47jQE6WDz5ZU=NEw@mail.gmail.com>
Message-ID: <CAL_JsqLWV=V8ja1b4GoQRg+SxVx4cSYStV47jQE6WDz5ZU=NEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: sf-pdma: add bindins for
 SiFive PDMA
To:     Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 19, 2019 at 2:28 AM Green Wan <green.wan@sifive.com> wrote:
>
> Add DT bindings document for Platform DMA(PDMA) driver of board,
> HiFive Unleashed Rev A00.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> new file mode 100644
> index 000000000000..b5423f1cfcaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -0,0 +1,63 @@
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
> +
> +  interrupt-parent:
> +    description:
> +      Interrupt parent must correspond to the name PLIC interrupt
> +      controller, i.e. "plic0"
> +    maxItems: 1

This fails 'make dt_binding_check'. You shouldn't have
'interrupt-parent' here anyways.

> +
> +  '#dma-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-parent

It is valid for interrupt-parent to be in a parent node too, so
required is wrong.

> +  - interrupts
> +  - '#dma-cells'
> +
> +examples:
> +  - |
> +    dma@3000000 {
> +      compatible = "sifive,fu540-c000-pdma";
> +      reg = <0x0 0x3000000 0x0 0x8000>;
> +      interrupt-parent = <&plic0>;
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
