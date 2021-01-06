Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDC2EC718
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jan 2021 00:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbhAFXyl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jan 2021 18:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbhAFXyl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Jan 2021 18:54:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 438EE2333C;
        Wed,  6 Jan 2021 23:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609977240;
        bh=KccsynjnFEJcrmwhf1b16TrZXgLFZesL4NPRSueUY1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O2Ctx+s/gNPzfxDa6pUH5emHrwTQaey2rpG/bApQcfaeCZglbryJfn/DohlvW0nUP
         ks+CvxCNnJRnQfy1QICe+Y/6UfBNdT7Fie4mU6hkxCc/qY6KmEvsjE/egeqs4GV+y1
         TW4FPA4nNMCMblnS6eOGf3yVexLzvV+1VHE+P/5WESFRYSwOPYyEdD4j3tBfw5xqxA
         7vQXvaCaynNadGEw+FJn10Dl6UTHcWFFh0UYHsJ4LKoK6EOh3BwO8FAbRzaSr9OFo3
         q+w0B08DB3B2O57YrN4skC7MHmVbtwCkc0B0Hqwa7sjwiFudRDfmnjHa2/qSUl0KdQ
         8u/WZFhIkL+DQ==
Received: by mail-qv1-f50.google.com with SMTP id et9so2051251qvb.10;
        Wed, 06 Jan 2021 15:54:00 -0800 (PST)
X-Gm-Message-State: AOAM5338/GZ24IlaWuV3bwXs7xC2q/Ww61cWqD1yqUjQiVA2TahcCtGK
        iCNIfgQO3xyRoNRoFT2rPD781bqyhkbR0jdRUw==
X-Google-Smtp-Source: ABdhPJzZl3aU05D6dlvbXZTfnBuEeO/OPJggOMbq92bGAhrV+nuJsZ/bCmxU3BveNk7VWisYeznWdqpE7BUkNfpW7nU=
X-Received: by 2002:ad4:4a72:: with SMTP id cn18mr6116796qvb.50.1609977239399;
 Wed, 06 Jan 2021 15:53:59 -0800 (PST)
MIME-Version: 1.0
References: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
 <1608715847-28956-2-git-send-email-EastL.Lee@mediatek.com>
 <20210103165842.GA4024251@robh.at.kernel.org> <1609925140.5373.5.camel@mtkswgap22>
In-Reply-To: <1609925140.5373.5.camel@mtkswgap22>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Jan 2021 16:53:46 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLjgJUNJiE8uri9MKqTdik=7BBGP9bZSkD1mF+Sk3YfmQ@mail.gmail.com>
Message-ID: <CAL_JsqLjgJUNJiE8uri9MKqTdik=7BBGP9bZSkD1mF+Sk3YfmQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
To:     EastL <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 6, 2021 at 2:25 AM EastL <EastL.Lee@mediatek.com> wrote:
>
> On Sun, 2021-01-03 at 09:58 -0700, Rob Herring wrote:
> > On Wed, Dec 23, 2020 at 05:30:44PM +0800, EastL Lee wrote:
> > > Document the devicetree bindings for MediaTek Command-Queue DMA controller
> > > which could be found on MT6779 SoC or other similar Mediatek SoCs.
> > >
> > > Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 104 +++++++++++++++++++++
> >
> > Use compatible string for filename:
> OK
> >
> > mediatek,cqdma.yaml
> >
> > >  1 file changed, 104 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> > > new file mode 100644
> > > index 0000000..a76a263
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> > > @@ -0,0 +1,104 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/mtk-cqdma.yaml#
> >
> > Don't forget to update this.
> OK
> >
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek Command-Queue DMA controller Device Tree Binding
> > > +
> > > +maintainers:
> > > +  - EastL Lee <EastL.Lee@mediatek.com>
> > > +
> > > +description:
> > > +  MediaTek Command-Queue DMA controller (CQDMA) on Mediatek SoC
> > > +  is dedicated to memory-to-memory transfer through queue based
> > > +  descriptor management.
> > > +
> > > +allOf:
> > > +  - $ref: "dma-controller.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - mediatek,mt6765-cqdma
> > > +          - mediatek,mt6779-cqdma
> > > +      - const: mediatek,cqdma
> > > +
> > > +  reg:
> > > +    minItems: 1
> > > +    maxItems: 5
> > > +    description:
> > > +        A base address of MediaTek Command-Queue DMA controller,
> > > +        a channel will have a set of base address.
> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 5
> > > +    description:
> > > +        A interrupt number of MediaTek Command-Queue DMA controller,
> > > +        one interrupt number per dma-channels.
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: cqdma
> > > +
> > > +  dma-channel-mask:
> > > +    description:
> > > +       For DMA capability, We will know the addressing capability of
> > > +       MediaTek Command-Queue DMA controller through dma-channel-mask.
> > > +      minimum: 1
> > > +      maximum: 63
> >
> > Indentation is wrong here so this has no effect.
> I'll fix it
> >
> > A mask of 63 is 6 channels...
> In my opinion, kernel dma mask if for 32/64 bit capability...
> If I don't set dma mask I will get fail on DMATEST.

As in the kernel's 'dma_mask'? That's something entirely different.
The driver should set the mask to the max the device supports.
Typically this is a 32-bit or 64-bit mask. The default is 32-bit. If
the SoC has limitations in its buses, then you need to use
'dma-ranges' in DT which will in turn set the bus_dma_limit.

For the above, the purpose is if you have sparsely allocated DMA channels.

Rob
