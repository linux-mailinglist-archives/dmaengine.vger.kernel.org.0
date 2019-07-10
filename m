Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480816477E
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2019 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGJNs7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jul 2019 09:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfGJNs7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Jul 2019 09:48:59 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA482086D;
        Wed, 10 Jul 2019 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562766538;
        bh=u+h9L2PkMGszB6CZLiEEQigUEngQOBljD1CgcZzVQs8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lZ4A3uCdSkp29Q/gAuH6R2uj6rbrd53DWPa4VlstJqQldNKxgTjsLASLg+tfjB+hg
         NNi6IR+fLrGr3J0vl6OWLzR8CFyoUz93EuC0buH4M99Yywpe7IF47tdardJkbkPqvI
         /S7S4Rn2gJbCmsj+gUCx3VhOBuKiXlUikMMoIjYE=
Received: by mail-qk1-f180.google.com with SMTP id g18so1915014qkl.3;
        Wed, 10 Jul 2019 06:48:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVOMA4uI29oStj4HfAxQZvNlH/8NeoJWVDEWQUj7ftqxsc9NqOY
        5yNPQu599Qqonw1QxjgVJrNDpqsqavPLoJ0QkA==
X-Google-Smtp-Source: APXvYqzLjS4ENFrvg6Ny01xGrcyKKx0P85tzVM/HZcRb+gBjeV+mgbMRCgrB0/kR689V7NgUiJbGMqBd++/xEeWl0uU=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr23970720qke.223.1562766537777;
 Wed, 10 Jul 2019 06:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
 <20190613005237.1996-1-jassisinghbrar@gmail.com> <20190709143437.GA30850@bogus>
 <CABb+yY3OsAh3xgX8_vvA7A7mU+FkEj__BQs9CxMvf=eYxRYXyw@mail.gmail.com>
In-Reply-To: <CABb+yY3OsAh3xgX8_vvA7A7mU+FkEj__BQs9CxMvf=eYxRYXyw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Jul 2019 07:48:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKB2tw8NFYgO09RHvYBKJ8uVCktYH36wiPWi0wvH758Eg@mail.gmail.com>
Message-ID: <CAL_JsqKB2tw8NFYgO09RHvYBKJ8uVCktYH36wiPWi0wvH758Eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 9, 2019 at 10:12 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Tue, Jul 9, 2019 at 9:34 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jun 12, 2019 at 07:52:37PM -0500, jassisinghbrar@gmail.com wrote:
> > > From: Jassi Brar <jaswinder.singh@linaro.org>
> > >
> > > Document the devicetree bindings for Socionext Milbeaut HDMAC
> > > controller. Controller has upto 8 floating channels, that need
> > > a predefined slave-id to work from a set of slaves.
> > >
> > > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > > ---
> > >  .../bindings/dma/milbeaut-m10v-hdmac.txt           | 54 +++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > > new file mode 100644
> > > index 000000000000..a104fcb9e73d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > > @@ -0,0 +1,51 @@
> > > +* Milbeaut AHB DMA Controller
> > > +
> > > +Milbeaut AHB DMA controller has transfer capability bellow.
> > > + - memory to memory transfer
> > > + - device to memory transfer
> > > + - memory to device transfer
> > > +
> > > +Required property:
> > > +- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
> > > +- reg:              Should contain DMA registers location and length.
> > > +- interrupts:       Should contain all of the per-channel DMA interrupts.
> >
> > How many?
> >
> Each channel has an IRQ line. And the number of channels is
> configurable. So instead of having some explicit property like
> 'dma-channels', we infer that from the number of irqs registered.

Yes, I get that. There's still a range that's valid and you need to
define those constraints. If there's a variable number of channels,
then that implies different SoCs which should also mean different
compatible strings.

Rob
