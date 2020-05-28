Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA01E662D
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgE1PdT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 11:33:19 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:33014 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404218AbgE1PdS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 11:33:18 -0400
Received: by mail-oo1-f66.google.com with SMTP id q6so5822386oot.0;
        Thu, 28 May 2020 08:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwvPrfZ8wSg4ph9zMdOEHVQNrGJxP0cUS3oI9/YOGpQ=;
        b=QpwqjFTsadK3mu7urI3IfM1rL6tr9ztPKMnoyrW7GQqMX5igix/k9dhHLHJKlX+QoI
         XBBoQSXFkwTM3UbSizQhWIndyeBKKk/1TjOK5wgzYCqYOVL9Mh3Hf5vqvbsiZcAKVH2U
         i5m4Z3iR7AAXWrMp+pTab7419V0Yf8Moo3G3dM5JSTJDjNasCsFH2Q3N8y3VTXDLUbiQ
         VYms1wPIp8aymnP4bneBUlrU0U+vp+MmMoXqlUbAC/pP6SHCNNIsiyHkdOUiHAMNpetR
         FGIubYztWG5GSahTJrFvbyq56zPluCH5YtmAS7fEUpHNBoZaJtYtifg6rs4WO4OcCgeO
         sX1Q==
X-Gm-Message-State: AOAM533NAu2ppUzQserN6stdvj2DRLSH+vNElmo1XKqd42FoWSzqxH4S
        7I4AxZXGoUxOohLtIwrdZYqsYFguYz4bSXbIuko=
X-Google-Smtp-Source: ABdhPJzYnIPD026r8y0hPgfUlAn0bDcx+vTjLCisCeIZ4o+tCY/6uQdRsn4J2v/VaqLjNOwZ97xJOv6mtqydzoFJdxQ=
X-Received: by 2002:a4a:e0d1:: with SMTP id e17mr2914462oot.1.1590679997128;
 Thu, 28 May 2020 08:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200528142139.GA28290@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200528142139.GA28290@e121166-lin.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 May 2020 17:33:06 +0200
Message-ID: <CAMuHMdVNi2dwrbsX9Zbxo3GGaGZ6EwtsVhFFORNTYkcGfynkQQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] R8A7742 add support for HSUSB and USB2.0/3.0
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lorenzo,

On Thu, May 28, 2020 at 4:21 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Sun, May 24, 2020 at 10:37:49PM +0100, Lad Prabhakar wrote:
> > This patch series adds support for HSUSB, USB2.0 and USB3.0 to
> > R8A7742 SoC DT.
> >
> > This patch series applies on-top of [1].
> >
> > [1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=288491
>
> I think Geert will pull this series, so I'd drop it from the PCI
> patchwork unless there is a reason I should not, please let me know.

I'll take the DTS patches only.

You may want to take 2/8, or leave it to Rob.

> > Lad Prabhakar (8):
> >   dt-bindings: phy: rcar-gen2: Add r8a7742 support
> >   dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
> >   dt-bindings: usb: renesas,usbhs: Add support for r8a7742
> >   dt-bindings: dmaengine: renesas,usb-dmac: Add binding for r8a7742
> >   dt-bindings: usb: usb-xhci: Document r8a7742 support
> >   ARM: dts: r8a7742: Add USB 2.0 host support
> >   ARM: dts: r8a7742: Add USB-DMAC and HSUSB device nodes
> >   ARM: dts: r8a7742: Add xhci support
> >
> >  .../devicetree/bindings/dma/renesas,usb-dmac.yaml  |   1 +
> >  .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   3 +-
> >  .../devicetree/bindings/phy/rcar-gen2-phy.txt      |   3 +-
> >  .../devicetree/bindings/usb/renesas,usbhs.yaml     |   1 +
> >  Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
> >  arch/arm/boot/dts/r8a7742.dtsi                     | 173 +++++++++++++++++++++
> >  6 files changed, 180 insertions(+), 2 deletions(-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
