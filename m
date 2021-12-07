Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12BD46BD65
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhLGOVk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 09:21:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41244 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhLGOVk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 09:21:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 566AFCE1AB3;
        Tue,  7 Dec 2021 14:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC76C341C5;
        Tue,  7 Dec 2021 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638886686;
        bh=1chlDx3iIHLkU8O/4MF4tixPugbIgeHoET/PZmxRlCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U8eq9OK6ookKoEdM8US+bMmhjjBIeBKaG08316vwnUsYIx1KTmHBQmIra0IsvXU7E
         bZoC/hvP7Btb13n7VFCdBExxWzoCt7dD1MIG2wpWPtk1Hy9/M3TWPzbOd2C2otw1/4
         UPRN5Z+kaA90E4cQhV5ZdWnMn3yIWx7xwLjIcY6b3N4foEcx+0Gq5lQQVSDWvwxXg1
         hdONry5oEDjXNIo/KD/O3NeOmOBV3+iTKQypMgZhs2Fbgyb3WlCBSt1y5ogUlHj8iN
         n+YnqtzinROisJA4YcbOdpgZRGPaTG12oANjMU4Qf9oLbBRi/CqDNrj34M+yIwVg7D
         2alBIYJg/L70g==
Received: by mail-ed1-f44.google.com with SMTP id g14so56959651edb.8;
        Tue, 07 Dec 2021 06:18:06 -0800 (PST)
X-Gm-Message-State: AOAM530e1aSQGQ8a2PPlHkJEBZ60kPt0IZoD463lZjfZ8vEbFTv/Vexw
        APD8NUzvou0yE9yNF4DkzjCn86SL9jmNnyQ+Xg==
X-Google-Smtp-Source: ABdhPJyTgmbH9yu5bvdESYeVKS5w5HdszrdhnlBeddmJ5KKCuYkIuj/4w0Tdr+EVYOMNuLHtyqZYJSIruTjMk9MHMq8=
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr9462522edc.197.1638886684437;
 Tue, 07 Dec 2021 06:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20211206174226.2298135-1-robh@kernel.org> <Ya8eC9UkwMZaNozs@orome.fritz.box>
In-Reply-To: <Ya8eC9UkwMZaNozs@orome.fritz.box>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Dec 2021 08:17:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCwXqyijyavk8oKx3CG2KTb=8p+5kbCJiMe4mMt9DhSQ@mail.gmail.com>
Message-ID: <CAL_JsqJCwXqyijyavk8oKx3CG2KTb=8p+5kbCJiMe4mMt9DhSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: ti: Add missing ti,k3-sci-common.yaml reference
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 7, 2021 at 2:40 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 06, 2021 at 11:42:26AM -0600, Rob Herring wrote:
> > The TI k3-bcdma and k3-pktdma both use 'ti,sci' and 'ti,sci-dev-id'
> > properties defined in ti,k3-sci-common.yaml. When 'unevaluatedProperties'
> > support is enabled, a the follow warning is generated:
>
> s/a the following/the following/
>
> Otherwise looks good:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Thanks.

>
> One question below...
>
> >
> > Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml: dma-controller@485c0100: Unevaluated properties are not allowed ('ti,sci', 'ti,sci-dev-id' were unexpected)
> > Documentation/devicetree/bindings/dma/ti/k3-pktdma.example.dt.yaml: dma-controller@485c0000: Unevaluated properties are not allowed ('ti,sci', 'ti,sci-dev-id' were unexpected)
> >
> > Add a reference to ti,k3-sci-common.yaml to fix this.
> >
> > Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml  | 1 +
> >  Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> > index df29d59d13a8..08627d91e607 100644
> > --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> > @@ -30,6 +30,7 @@ description: |
> >
> >  allOf:
> >    - $ref: /schemas/dma/dma-controller.yaml#
> > +  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>
> Out of curiosity: is the # at the end necessary, or do you just use it
> as a convention?

It is at least convention. The jsonschema module doesn't require it,
but not sure what the spec says.

> I've seen a mix of both and there also seems to be a
> healthy mix of quoted and unquoted paths. Do we want to settle on one
> going forward or do we not care enough?

I don't really want to dictate one way if it can't automatically be
checked. The '#' could be checked easily, but quoting is harder. There
is some tool support for checking quotes actually, but you have to
enable the yaml round trip loader which is noticeably slower. yamllint
might be the better place to add it though getting yaml quoting rules
right in the general case is a bit harder. Also, to enforce it, I have
to first go fix all the existing cases.

Rob
