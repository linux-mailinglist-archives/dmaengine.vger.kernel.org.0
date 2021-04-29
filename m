Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBF36EDEE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhD2QNr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 12:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhD2QNq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 12:13:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C38F1613C2;
        Thu, 29 Apr 2021 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619712780;
        bh=CeU1zHS8DwjOrjo2ckGZGFL1lDq+9OkSGhxgiVtgB8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EDjSoeJwA/9e1f1XCfg6WIMQ8fbdLHXcp+t+1neXQ8FORsNw2DkKqoljg+4ftqezr
         lSlK7UlkQcRafEaHKQs+xzEnqXAJAnb4zdj0G0OgJmTSRxgEMMEPMjP/09oRxLIr6u
         wJW6y+QkHJIKK+sTiOnoQybC1AIyXsFAFW9jNjL923pK+vnuWB6rXMjvGtj0hFWKoZ
         hTCUZ3T/KYe5FaXZAvbk5OVbCWLDrowPRNbDN37K1ME2tjF5YWLWU42qMtOiStgW/h
         Ck4r6Td5hSYuPEEliyImVyVD9zYMUDYZ5k6T/HElD4gQcrRbWP5gfPITQuv2MF3aqu
         c7QZq10ym06nQ==
Received: by mail-ed1-f42.google.com with SMTP id s15so79295452edd.4;
        Thu, 29 Apr 2021 09:12:59 -0700 (PDT)
X-Gm-Message-State: AOAM533lA9zxlX4wv1JPyEJWRuKDGUJGmYKIYJs5w+kj7kBcvV/cADW1
        jTjPiKbBvIPy2SvtGNunoX7cUOuDMyN/b500LA==
X-Google-Smtp-Source: ABdhPJyrThtSbOXd6GBoD9oPLfIbPZGQWpMuyy/fKwK5NVHtm3TmAdITYovf24U5Vzo46Oww75+6zcsClC5louU78xE=
X-Received: by 2002:a05:6402:1e4:: with SMTP id i4mr432230edy.62.1619712777963;
 Thu, 29 Apr 2021 09:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210428055750.683963-1-clabbe@baylibre.com> <1619648109.771241.4061028.nullmailer@robh.at.kernel.org>
 <YIrJTycPqfP0UnEz@Red>
In-Reply-To: <YIrJTycPqfP0UnEz@Red>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Apr 2021 11:12:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJab4wmfDSyz-uQpp24Qcus8j=Vks8Yfk472rgXyd5U6g@mail.gmail.com>
Message-ID: <CAL_JsqJab4wmfDSyz-uQpp24Qcus8j=Vks8Yfk472rgXyd5U6g@mail.gmail.com>
Subject: Re: [PATCH RFC] dt-bindings: dma: convert arm-pl08x to yaml
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Vinod <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 29, 2021 at 9:57 AM LABBE Corentin <clabbe@baylibre.com> wrote:
>
> Le Wed, Apr 28, 2021 at 05:15:09PM -0500, Rob Herring a =C3=A9crit :
> > On Wed, 28 Apr 2021 05:57:50 +0000, Corentin Labbe wrote:
> > > Converts dma/arm-pl08x.txt to yaml.
> > > In the process, I add an example for the faraday variant.
> > >
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
> > >  .../devicetree/bindings/dma/arm-pl08x.yaml    | 127 ++++++++++++++++=
++
> > >  2 files changed, 127 insertions(+), 59 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.t=
xt
> > >  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.y=
aml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:19:9: [warning] =
wrong indentation: expected 10 but found 8 (indentation)
> > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:22:9: [warning] =
wrong indentation: expected 10 but found 8 (indentation)
> > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:25:9: [warning] =
wrong indentation: expected 10 but found 8 (indentation)
> > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:66:9: [warning] =
wrong indentation: expected 6 but found 8 (indentation)
> > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:78:9: [warning] =
wrong indentation: expected 6 but found 8 (indentation)
> >
>
> Hello
>
> I have installed yamllint, so this kind of error should no happen again
>
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a requ=
ired property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: $nodename:0: 'watchdog=
@66090000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: compatible: 'oneOf' co=
nditional failed, one must be fixed:
> >       ['arm,sp805', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clocks: [[4294967295],=
 [4294967295]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names:0: 'apb_pc=
lk' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: ['wdog_cl=
k', 'apb_pclk'] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: Additiona=
l items are not allowed ('apb_pclk' was unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/wa=
tchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a requ=
ired property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/spi-pl022.example.dt.yaml: spi@e0100000: $nodename:0: 'spi@e0100000' does=
 not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/spi-pl022.example.dt.yaml: spi@e0100000: compatible: 'oneOf' conditional =
failed, one must be fixed:
> >       ['arm,pl022', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/spi-pl022.example.dt.yaml: spi@e0100000: 'clocks' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/spi-pl022.example.dt.yaml: spi@e0100000: 'clock-names' is a required prop=
erty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required pro=
perty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: $nodename:0: 'serial@80120000'=
 does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: compatible: 'oneOf' conditiona=
l failed, one must be fixed:
> >       ['arm,pl011', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: clocks: [[4294967295], [429496=
7295]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: clock-names:0: 'apb_pclk' was =
expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: clock-names: ['uartclk', 'apb_=
pclk'] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: clock-names: Additional items =
are not allowed ('apb_pclk' was unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/se=
rial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required pro=
perty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required p=
roperty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20020000: $nodename:0: 'cti@20020000' =
does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20020000: compatible: 'oneOf' conditio=
nal failed, one must be fixed:
> >       ['arm,coresight-cti', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required p=
roperty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20020000: 'oneOf' conditional failed, =
one must be fixed:
> >       'interrupts' is a required property
> >       'interrupts-extended' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required pro=
perty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@859000: $nodename:0: 'cti@859000' does=
 not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@859000: compatible: 'oneOf' conditiona=
l failed, one must be fixed:
> >       ['arm,coresight-cti-v8-arch', 'arm,coresight-cti', 'arm,primecell=
'] is too long
> >       Additional items are not allowed ('arm,primecell' was unexpected)
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       'arm,primecell' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required pro=
perty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@859000: 'oneOf' conditional failed, on=
e must be fixed:
> >       'interrupts' is a required property
> >       'interrupts-extended' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required pro=
perty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@858000: $nodename:0: 'cti@858000' does=
 not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@858000: compatible: 'oneOf' conditiona=
l failed, one must be fixed:
> >       ['arm,coresight-cti', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required pro=
perty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@858000: 'oneOf' conditional failed, on=
e must be fixed:
> >       'interrupts' is a required property
> >       'interrupts-extended' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required p=
roperty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20110000: $nodename:0: 'cti@20110000' =
does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20110000: compatible: 'oneOf' conditio=
nal failed, one must be fixed:
> >       ['arm,coresight-cti', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required p=
roperty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/coresight-cti.example.dt.yaml: cti@20110000: 'oneOf' conditional failed, =
one must be fixed:
> >       'interrupts' is a required property
> >       'interrupts-extended' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: $nodename:0: 'mmc@5000' does not mat=
ch '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: compatible: 'oneOf' conditional fail=
ed, one must be fixed:
> >       ['arm,pl180', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: clocks: [[4294967295], [4294967295]]=
 is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: clock-names:0: 'apb_pclk' was expect=
ed
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: ['mclk', 'apb_pclk'] is=
 too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: Additional items are no=
t allowed ('apb_pclk' was unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: $nodename:0: 'mmc@80126000' does=
 not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: compatible: 'oneOf' conditional =
failed, one must be fixed:
> >       ['arm,pl18x', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: clocks: [[4294967295, 1, 5], [42=
94967295, 1, 5]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names:0: 'apb_pclk' was ex=
pected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: ['sdi', 'apb_pclk']=
 is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: Additional items ar=
e not allowed ('apb_pclk' was unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: $nodename:0: 'mmc@101f6000' does=
 not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: compatible: 'oneOf' conditional =
failed, one must be fixed:
> >       ['arm,pl18x', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: clocks: [[4294967295], [42949672=
95]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names:0: 'apb_pclk' was ex=
pected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: ['mclk', 'apb_pclk'=
] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: Additional items ar=
e not allowed ('apb_pclk' was unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@52007000: $nodename:0: 'mmc@52007000' does=
 not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@52007000: compatible: 'oneOf' conditional =
failed, one must be fixed:
> >       ['arm,pl18x', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required prope=
rty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required p=
roperty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: $nodename:0: 'timer@fc800000=
' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: compatible: 'oneOf' conditio=
nal failed, one must be fixed:
> >       ['arm,sp804', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: interrupts: [[0, 0, 4], [0, =
1, 4]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: clocks: [[4294967295], [4294=
967295], [4294967295]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names:0: 'apb_pclk' wa=
s expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: ['timer1', 'tim=
er2', 'apb_pclk'] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: Additional item=
s are not allowed ('timer2', 'apb_pclk' were unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ti=
mer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required p=
roperty
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required=
 property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f=
0000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' condit=
ional failed, one must be fixed:
> >       ['arm,mhu', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: interrupts: [[0, 36, 4], [=
0, 35, 4], [0, 37, 4]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required=
 property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required=
 property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: $nodename:0: 'mailbox@2b2f=
0000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: compatible: 'oneOf' condit=
ional failed, one must be fixed:
> >       ['arm,mhu-doorbell', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: interrupts: [[0, 36, 4], [=
0, 35, 4], [0, 37, 4]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required=
 property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a requir=
ed property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b=
1f0000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' cond=
itional failed, one must be fixed:
> >       ['arm,mhuv2-tx', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a requir=
ed property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a requir=
ed property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: $nodename:0: 'mailbox@2b=
1f1000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: compatible: 'oneOf' cond=
itional failed, one must be fixed:
> >       ['arm,mhuv2-rx', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ma=
ilbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a requir=
ed property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bu=
s/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a re=
quired property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bu=
s/arm,integrator-ap-lm.example.dt.yaml: serial@100000: $nodename:0: 'serial=
@100000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bu=
s/arm,integrator-ap-lm.example.dt.yaml: serial@100000: compatible: 'oneOf' =
conditional failed, one must be fixed:
> >       ['arm,pl011', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bu=
s/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clocks' is a requir=
ed property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bu=
s/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clock-names' is a r=
equired property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bu=
s/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a re=
quired property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is=
 a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: $nodename:0: 'm=
mc@80118000' does not match '^dma-controller(@.*)?$'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: compatible: 'on=
eOf' conditional failed, one must be fixed:
> >       ['arm,pl18x', 'arm,primecell'] is too short
> >       'arm,pl080' was expected
> >       'arm,pl081' was expected
> >       'faraday,ftdma020' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clocks: [[42949=
67295, 0], [4294967295, 1]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names:0: =
'apb_pclk' was expected
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: ['=
mclk', 'apb_pclk'] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: Ad=
ditional items are not allowed ('apb_pclk' was unexpected)
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ne=
t/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is=
 a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/dma/arm-pl08x.yaml
> > Error: Documentation/devicetree/bindings/dma/arm-pl08x.example.dts:56.2=
7-28 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindin=
gs/dma/arm-pl08x.example.dt.yaml] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1414: dt_binding_check] Error 2
> >
>
> Most of thoses error came from the fact the compatible end with "arm,prim=
ecell".
> So it try to match against the wrong dt-binding.
>
> Does there is any correct way to limit/prevent this ?

You need a custom 'select' schema. Look at the 'select' schema for
other users of "arm,primecell".

Rob
