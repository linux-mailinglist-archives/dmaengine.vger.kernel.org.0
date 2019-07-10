Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250D563FCF
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2019 06:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfGJEMP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jul 2019 00:12:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37317 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJEMP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Jul 2019 00:12:15 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so1775379iog.4;
        Tue, 09 Jul 2019 21:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Mtj1V+09V4lY2C/WpTtWjJWOvRdHsrfxKP5HUgF3Mw=;
        b=Er83EjvRJBQgeZLZLNGHJ/CIJ3vFfD2b44UXb9NJhum0QdBtKCUFxG0HoR3ONVkgQr
         o0xtIwaDaN0tSl+1OGHaci0d6tKYunpmoPln67v2glTbuS5CSUdXTa8xze14By08wGhJ
         bnFbwyg1k2PhbXe0djOJmsDtY3LdvNtwjKTrbPiHCZrB+/GEsN5F2cseK/B+iQPFWgp4
         8aC8paqLYpkbbfpBuPq3IgyZDy0jlhnYJrWVc/4I9/jUAFt8B/TF67q3NMTifsw9cR0k
         edGv+eaK5sywQoqE1FsB2w1F+jWKQPgaYi8IzrYgBQF21mb60gjkzmvG2hcoMO1gVhLq
         T2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Mtj1V+09V4lY2C/WpTtWjJWOvRdHsrfxKP5HUgF3Mw=;
        b=YfZWWWiYHYSfH6GCkZYIxl2X72F5nYqi8y9IQuPCBTwbru/NczvY5S0uu9LFdPdgDe
         Up36MFa/JTE4f9R6vAyS0ytyJab60ahv1a24NeJaQoROuI5pSi3DxUUC4ihng3Jpfatd
         WGNZTPU07NMA2KPQxdMbC9la7M2meTMubcWRpcwJVG7lRLxrT6qIYplbuLpq2edxqeZK
         4i7/B3XSGDAlK6TWCQmAYiBcn1lIij85W+zByLvZjFfpW/dTdyiXjqOSPXRA0TyBB9Rn
         R8NmlWN0Grjq3W01+OGGX8NWfhbGna8D6Lperv3KW7OWJdEcoOnQVy/HyKTW1ouUMLXb
         1JLw==
X-Gm-Message-State: APjAAAW+RHvRi+sE68ksciB+SzShV4PXXTbDIhKm7EtlLd+3CnUb/D/0
        hk8F5HYdrI6FHvLe69L5dAJuMJNPqu15UAc+4kA=
X-Google-Smtp-Source: APXvYqyrY3pgnVJVoKBZLLrB+4OJFeIjwcN5V+rh111wh3J7yNqwK0JY5nwgq4JIQX+Ci9Ss4o59aShURyDdZ3NjNHU=
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr30451959ion.239.1562731934157;
 Tue, 09 Jul 2019 21:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
 <20190613005237.1996-1-jassisinghbrar@gmail.com> <20190709143437.GA30850@bogus>
In-Reply-To: <20190709143437.GA30850@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 9 Jul 2019 23:12:03 -0500
Message-ID: <CABb+yY3OsAh3xgX8_vvA7A7mU+FkEj__BQs9CxMvf=eYxRYXyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vkoul@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        orito.takao@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        kasai.kazuhiro@socionext.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 9, 2019 at 9:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 12, 2019 at 07:52:37PM -0500, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Document the devicetree bindings for Socionext Milbeaut HDMAC
> > controller. Controller has upto 8 floating channels, that need
> > a predefined slave-id to work from a set of slaves.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  .../bindings/dma/milbeaut-m10v-hdmac.txt           | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > new file mode 100644
> > index 000000000000..a104fcb9e73d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > @@ -0,0 +1,51 @@
> > +* Milbeaut AHB DMA Controller
> > +
> > +Milbeaut AHB DMA controller has transfer capability bellow.
> > + - memory to memory transfer
> > + - device to memory transfer
> > + - memory to device transfer
> > +
> > +Required property:
> > +- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
> > +- reg:              Should contain DMA registers location and length.
> > +- interrupts:       Should contain all of the per-channel DMA interrupts.
>
> How many?
>
Each channel has an IRQ line. And the number of channels is
configurable. So instead of having some explicit property like
'dma-channels', we infer that from the number of irqs registered.

> > +- #dma-cells:       Should be 1. Specify the ID of the slave.
> > +- clocks:           Phandle to the clock used by the HDMAC module.
> > +
> > +
> > +Example:
> > +
> > +     hdmac1: hdmac@1e110000 {
>
> dma-controller@...
>
OK

> > +             compatible = "socionext,milbeaut-m10v-hdmac";
> > +             reg = <0x1e110000 0x10000>;
> > +             interrupts = <0 132 4>,
> > +                          <0 133 4>,
> > +                          <0 134 4>,
> > +                          <0 135 4>,
> > +                          <0 136 4>,
> > +                          <0 137 4>,
> > +                          <0 138 4>,
> > +                          <0 139 4>;
> > +             #dma-cells = <1>;
> > +             clocks = <&dummy_clk>;
> > +     };
> > +
> > +* DMA client
> > +
> > +Clients have to specify the DMA requests with phandles in a list.
>
> Nothing specific to this binding here and the client side is already
> documented, so drop this section.
>
OK.

Thanks
