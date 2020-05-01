Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC491C0F79
	for <lists+dmaengine@lfdr.de>; Fri,  1 May 2020 10:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEAI2G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 May 2020 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAI2F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 May 2020 04:28:05 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D38C035494;
        Fri,  1 May 2020 01:28:05 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t199so2139724oif.7;
        Fri, 01 May 2020 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIaRGYpAPupU8ap77mm0+hl9zSz1kLjaWyzfce1Qs3Y=;
        b=kitVDdx/L3DP0PkMGe4nbAT/OeUb9rxLisr3H1naWl4uvidfeWv+LsXSQEgmmyc0X/
         iLi76W4bs3UsILqhkHUgncUHqEUqeBZ807rF4XZtjj2UQ67sZ4mxfq8Rz5lTBq2RNN+v
         9/S7EJEZh7aqpKGRbqGY8MNKVZ1kFzS8Qyhlb5ZJs4YPTpvsgZQEVgDc8FP/aj/kr24B
         mD/lDEQb5IO+ZfE5flM5Fs50UniK7R/Y60Rs+7W7iMXftdnv38rWWXkWJdLnEIk81P8R
         YBN1wqcVZHOU0FJbuDxdB/nALwtchR1n48YTjEaft/fGl60RWwSo7g9wzWS58jpzwAKS
         vXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIaRGYpAPupU8ap77mm0+hl9zSz1kLjaWyzfce1Qs3Y=;
        b=t7QM5ea78ctrTVc+To8N6dmev14LODMKeYrjA8lT9sGR0t/p1KeQdjMiWzsvjq1P7f
         iqgpZhx8EwXkdoA6ljxWXeKCpBV1mZMKc800laWio8XpNC23FtdOt0R3oMZPZSVxGoqV
         Ml5wAm5LJIkxtnxMWMLfO2kpuELD1KavEP2zrPMws4K23IUJV/EOeJxtZhOKksEzPqiS
         3lHTfI5bw0B7wkJ2/il+L+eOsO7gSxLrgj4jAT2FWUZl3vCUdQ+5GdQTpeX7+TFizTfv
         JobuwdBZbKboUsy5JYU81p1GK7OTle6b4TYbdO27V/IHxv3P+gwFy1NSi4c4su5u7Kmp
         cKEA==
X-Gm-Message-State: AGi0PubLcHCx9uT6L7kkjRMOvX/UpQgQ5RQvqObpoCY0t+fkrn6U8CLb
        H46LWnsSN8N6ugroEQ80TkzRA3QWKyFNSQN8AdA=
X-Google-Smtp-Source: APiQypK7F/qXasasin7MAQYiif3YYm7Zv+A3AA59LZg9zaayKtl+Wh4ZN+37kvvRqqUEkgvPlkOR6eZ2Unj/057MAYA=
X-Received: by 2002:a05:6808:5c5:: with SMTP id d5mr2347754oij.8.1588321684000;
 Fri, 01 May 2020 01:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 May 2020 09:27:37 +0100
Message-ID: <CA+V-a8sudn9kNs0QKQP9L_GL2wo1mifjRLcbA6sYjryD9cfZMw@mail.gmail.com>
Subject: Re: [PATCH 00/18] Add R8A7742/RZG1H board support
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On Wed, Apr 29, 2020 at 10:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch set adds initial board support for R8A7742 SoC,
> enabling R8A7742 arch in defconfigs with initial dtsi.
>
> Cheers,
> --Prabhakar
>
> Lad Prabhakar (18):
>   soc: renesas: Add Renesas R8A7742 config option
>   ARM: shmobile: defconfig: Enable r8a7742 SoC
>   ARM: multi_v7_defconfig: Enable r8a7742 SoC
>   ARM: debug-ll: Add support for r8a7742
>   dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
>   pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
>   ARM: dts: r8a7742: Initial SoC device tree
>   dt-bindings: irqchip: renesas-irqc: Document r8a7742 bindings
>   ARM: dts: r8a7742: Add IRQC support
>   dt-bindings: rcar-dmac: Document r8a7742 support
>   ARM: dts: r8a7742: Add SYS-DMAC support
>   dt-bindings: serial: renesas,scif: Document r8a7742 bindings
>   dt-bindings: serial: renesas,scifa: Document r8a7742 bindings
>   dt-bindings: serial: renesas,scifb: Document r8a7742 bindings
>   dt-bindings: serial: renesas,hscif: Document r8a7742 bindings
>   ARM: dts: r8a7742: Add [H]SCIF{A|B} support
>   dt-bindings: gpio: rcar: Add r8a7742 (RZ/G1H) support
>   ARM: dts: r8a7742: Add GPIO support
>
Thank you for the review.

For v2 ill post patches from 6-18 fixing your review comments and
including the Acks, as patches 1-5 have been queued.

Cheers,
--Prabhakar

>  .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
>  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
>  .../interrupt-controller/renesas,irqc.yaml         |   1 +
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   1 +
>  .../devicetree/bindings/serial/renesas,hscif.yaml  |   1 +
>  .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
>  .../devicetree/bindings/serial/renesas,scifa.yaml  |   1 +
>  .../devicetree/bindings/serial/renesas,scifb.yaml  |   1 +
>  arch/arm/Kconfig.debug                             |  10 +
>  arch/arm/boot/dts/r8a7742.dtsi                     | 939 +++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm/configs/shmobile_defconfig                |   1 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |   4 +
>  drivers/pinctrl/sh-pfc/Makefile                    |   1 +
>  drivers/pinctrl/sh-pfc/core.c                      |   6 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |  24 +
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |   1 +
>  drivers/soc/renesas/Kconfig                        |   7 +
>  18 files changed, 1002 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7742.dtsi
>
> --
> 2.7.4
>
