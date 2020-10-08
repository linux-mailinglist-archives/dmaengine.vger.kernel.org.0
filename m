Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6885287C45
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 21:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgJHTQA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 15:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgJHTP7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Oct 2020 15:15:59 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5397121789;
        Thu,  8 Oct 2020 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602184558;
        bh=VG9NJtGD0MJxDwq5ZtXgpvCKEMD4VJh0wRib10rKuNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rESrq1PokkafTsfbUWJb7IMjDXZ0uIPoXf0bU1kU/SxPRmf3Mx+4vdeKcKwpA26kP
         CeGBBUnvCaGWf1s+jlMczL3iVZx4vVY0XtWmgafwj84ZMNs9nOI6nQ22/UnCj11kYP
         WhEhzD2ura/vORCbHsVuzrkuJi7jkWm64Rme6TA0=
Received: by mail-oi1-f171.google.com with SMTP id 16so7473623oix.9;
        Thu, 08 Oct 2020 12:15:58 -0700 (PDT)
X-Gm-Message-State: AOAM531qXa1MfEskESYa+XOYo3FVjpRgNtilsngBwnbjmE8zPg6tyacs
        T67VVdrrrRfg1YHDB+hRAfg6rU3TT37KBHOC/A==
X-Google-Smtp-Source: ABdhPJx9mwBGCS5pg5vdbXELgG+z/CjSjP8/1RkXvGfiZcZ9cqHR2t/HzXodxvJsAbiYVlOJ3SXm2cJhKjn6TIasIZk=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr202300oia.147.1602184557422;
 Thu, 08 Oct 2020 12:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200930091412.8020-1-peter.ujfalusi@ti.com> <20200930091412.8020-10-peter.ujfalusi@ti.com>
 <20201006192909.GA2679155@bogus> <bc054ef7-dcd7-dde2-13f8-4900a33b1377@ti.com>
 <20201007154635.GA273523@bogus> <d5746fca-bbdd-0fd1-cbcb-21b6269c39ac@ti.com>
In-Reply-To: <d5746fca-bbdd-0fd1-cbcb-21b6269c39ac@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Oct 2020 14:15:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJnk=ycRurUTBwWgX1+vOq_MZuevegvK2MwGJHkHW50mg@mail.gmail.com>
Message-ID: <CAL_JsqJnk=ycRurUTBwWgX1+vOq_MZuevegvK2MwGJHkHW50mg@mail.gmail.com>
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh R <vigneshr@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tero Kristo <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 8, 2020 at 3:40 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
>
>
> On 07/10/2020 18.46, Rob Herring wrote:
> > On Wed, Oct 07, 2020 at 12:09:06PM +0300, Peter Ujfalusi wrote:
> >>
> >>
> >> On 06/10/2020 22.29, Rob Herring wrote:
> >>> On Wed, Sep 30, 2020 at 12:14:03PM +0300, Peter Ujfalusi wrote:
> >>>> New binding document for
> >>>> Texas Instruments K3 Block Copy DMA (BCDMA).
> >>>>
> >>>> BCDMA is introduced as part of AM64.
> >>>>
> >>
> >> ...
> >>
> >>>
> >>>> +  ti,sci:
> >>>> +    description: phandle to TI-SCI compatible System controller node
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/phandle
> >>>> +
> >>>> +  ti,sci-dev-id:
> >>>> +    description: TI-SCI device id of BCDMA
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >>>
> >>> We have a common definition for these.
> >>
> >> Yes, in arm/keystone/ti,k3-sci-common.yaml, but I could not get to use
> >> that as reference.
> >>
> >> I can not list it under the topmost allOf and drop the ti,sci and
> >> ti,sci-dev-id like this:
> >>
> >> allOf:
> >>   - $ref: /schemas/dma/dma-controller.yaml#
> >>   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> >>
> >> It results:
> >>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> >>   DTEX    Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dts
> >>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> >>   DTC     Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
> >>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
> >> Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml:
> >> dma-controller@485c0100: 'ti,sci', 'ti,sci-dev-id' do not match any of
> >> the regexes: 'pinctrl-[0-9]+'
> >>         From schema: Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> >>
> >> If I remove the "additionalProperties: false" from the schema file, then
> >> it compiles fine.
> >
> > Yeah, you have to do 'unevaluatedProperties: false' which doesn't
> > actually do anything yet, but can 'see' into $ref's.
>
> I see, but even if I add the unevaluatedProperties: false I will have
> the same error as long as I have additionalProperties: false

Yes. I meant unevaluatedProperties instead of additionalProperties.

> If I remove the additionalProperties then it makes no difference if I
> have the unevaluatedProperties: false or I don't.

Not yet, but it will soon. Once I have the tree in a consistent state
in 5.10-rc1, there will be a meta-schema to check all this (which is
one of those must always be present).

Though, as of now 'unevaluatedProperties' doesn't do anything because
the underlying json-schema tool doesn't yet support it.

> >>>> +  ti,sci-rm-range-bchan:
> >>>> +    description: |
> >>>> +      Array of BCDMA block-copy channel resource subtypes for resource
> >>>> +      allocation for this host
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>> +    minItems: 1
> >>>> +    # Should be enough
> >>>> +    maxItems: 255
> >>>
> >>> Are there constraints for the individual elements?
> >>
> >> In practice the subtype ID is 6bits number.
> >> Should I add limits to individual elements?
> >
> > Yes:
> >
> > items:
> >   maximum: 0x3f
>
> Right, I can just omit the minimum.
>
> It would be nice if I could use definitions for these ranges to avoid
> duplicated lines by adding
>
> definitions:
>   ti,rm-range:
>     $ref: /schemas/types.yaml#/definitions/uint32-array
>     minItems: 1
>     # Should be enough
>     maxItems: 255
>     items:
>       minimum: 0
>       maximum: 0x3f
>
> to schemas/arm/keystone/ti,k3-sci-common.yaml
>
> and only have:
>
>   ti,sci-rm-range-bchan:
>     $ref:
> /schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range
>     description: |
>       Array of BCDMA block-copy channel resource subtypes for resource
>       allocation for this host

Just do:

patternProperties:
  "^ti,sci-rm-range-[btr]chan$":
    ...

If this is common for other bindings, then you can put it in
ti,k3-sci-common.yaml.

> but it results:
> Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
> properties:ti,sci-rm-range-bchan: {'$ref':
> '/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range',
> 'description': 'Array of BCDMA block-copy channel resource subtypes for
> resource\nallocation for this host\n'} is not valid under any of the
> given schemas (Possible causes of the failure):
>         Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
> properties:ti,sci-rm-range-bchan: 'not' is a required property
>         Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
> properties:ti,sci-rm-range-bchan:$ref:
> '/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range'
> does not match 'types.yaml#[/]{0,1}definitions/.*'

We probably should allow for using 'definitions' which is pretty
common json-schema practice, but don't primarily in order to keep
folks within the lines. Things are optimized for not knowing
json-schema and trying to minimize errors I have to check for.
Supporting it would complicate the meta-schema and the tools' fixup
code. So far, the need for it has been pretty infrequent.

Rob
