Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1656AB65C7
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfIROVk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 10:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfIROVk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Sep 2019 10:21:40 -0400
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC762067B;
        Wed, 18 Sep 2019 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568816498;
        bh=wXgtDQ2Bk9vjBzgeHu+dOpDd3lEyXdo3Em4I00Qq0go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GD8v6IR4n4ZFgYbHm4vs9fdVL0NBUorWvqvJHWa6MP0LPCqjmy/PtK6aRVG5s2IqP
         GYXzm9YSypo9MsFMZfRbqMm38/8YmfgHGKiuzKo5iqlZV6wgW0sZ0dsm8lGJBWEamP
         rjAfeX4yXPpsQjqB4lUUpEJvtiPfe9EBUsi7diQg=
Received: by mail-yw1-f51.google.com with SMTP id j128so11153ywf.0;
        Wed, 18 Sep 2019 07:21:38 -0700 (PDT)
X-Gm-Message-State: APjAAAVEMhh0WkQjAtmwE3Eb/AI8yqm8p/GbO3inhJlmddEZM9fL0gwf
        +Kc3ou6/fdeCj5xTEZXhZL0ZVAMd9gVrIOPPIA==
X-Google-Smtp-Source: APXvYqzliDG2Xy58F978kJGtp6vQ1A2AyEZNr8e3uVSmktEs+lZEJgI2FWH3qKtnlcumLLeZFhha8AUbhOFoHfMVSDo=
X-Received: by 2002:a81:9182:: with SMTP id i124mr3466623ywg.279.1568816497852;
 Wed, 18 Sep 2019 07:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190910114559.22810-1-peter.ujfalusi@ti.com> <20190910114559.22810-2-peter.ujfalusi@ti.com>
 <20190918132835.GA4527@bogus> <d76ffc38-8e68-656a-325b-37de9b01e015@ti.com>
In-Reply-To: <d76ffc38-8e68-656a-325b-37de9b01e015@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Sep 2019 09:21:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJn4dmnjU=7kVgiosAU=o+fSJNH6578D92fGbdOR8Zfw@mail.gmail.com>
Message-ID: <CAL_JsqLJn4dmnjU=7kVgiosAU=o+fSJNH6578D92fGbdOR8Zfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: dma-common: Change
 dma-channel-mask to uint32-array
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 18, 2019 at 9:04 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrot=
e:
>
>
>
> On 18/09/2019 16.28, Rob Herring wrote:
> > On Tue, Sep 10, 2019 at 02:45:57PM +0300, Peter Ujfalusi wrote:
> >> Make the dma-channel-mask to be usable for controllers with more than =
32
> >> channels.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/dma/dma-common.yaml | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/D=
ocumentation/devicetree/bindings/dma/dma-common.yaml
> >> index ed0a49a6f020..41460946be64 100644
> >> --- a/Documentation/devicetree/bindings/dma/dma-common.yaml
> >> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
> >> @@ -25,11 +25,19 @@ properties:
> >>        Used to provide DMA controller specific information.
> >>
> >>    dma-channel-mask:
> >> -    $ref: /schemas/types.yaml#definitions/uint32
> >>      description:
> >>        Bitmask of available DMA channels in ascending order that are
> >>        not reserved by firmware and are available to the
> >>        kernel. i.e. first channel corresponds to LSB.
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +        items:
> >> +          minItems =3D 1
> >
> > '=3D'? Just making up the syntax?
>
> Opps, sorry.
>
> >
> >> +          maxItems =3D 255 # Should be enough
> >> +          - description: Mask of channels 0-31
> >> +          - description: Mask of channels 32-63
> >
> > You are mixing a schema and list here...
>
> Should I extend the description with something like this:
> "The first item in the array is for channels 0-31, the second is for
> channels 32-63, etc."
>
> To make sure that it is used in a correct and consistent manner.

Sure.

>
> >> +          ...
> >
> > That's end of doc marker in YAML...
>
> I believe I need some reading to do for YAML..
>
> >
> >> +          - description: Mask of chnanels X-(X+31)
> >
> > Obviously, this was not validated with 'make dt_binding_check'.
> make dt_bindings_check
> make: *** No rule to make target 'dt_bindings_check'.  Stop.

Read Documentation/devicetree/writing-schema.md (or .rst in next).

Either your config doesn't have DTC enabled or you don't have
dt-schema installed.

>
> > What you  want is:
> >
> >     allOf:
> >       - $ref: /schemas/types.yaml#/definitions/uint32-array
> >       - minItems: 1
> >         maxItems: 255 # Should be enough
>
> OK and thanks for the comments.
>
> - P=C3=A9ter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
