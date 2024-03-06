Return-Path: <dmaengine+bounces-1278-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8287417D
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 21:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687551F25D20
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A414265;
	Wed,  6 Mar 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8/ws5qM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E9175B7;
	Wed,  6 Mar 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757639; cv=none; b=F8c+7fgCuE8qLFrY/e7WqWzNJnSKJ5197MZZqLx9f9lA5gMQk3RzdTK/wmGURVzMD7eQvaMgq2jhG28QFzHtwrvkuU1ROdc/DUOR6VLFy0hOgiG0rSykEh3R/dyhSUbjtSE5OTnlGZVV/WTuAtW5ktODdUu5WyR+TGfXuPK4Go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757639; c=relaxed/simple;
	bh=sswSikc9379ND8q2IbxyQfnO0n1h0QcZWhVJ5y3cvaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmCmm5ZPp05VsJ8IYQhXhyrwMvvKjkX0OA5SlztUfZ0+scG4vKNcxlNC4wivGDt0sPTElG2ufnb/EjeepICzekyqLm5LhvKxXIDR5u2iSNrNwceI525mCx0a6y6Lph4pYXKDvu/XVNxDTwg+hhtMXFdi7rp6mKBGQHBiXXNYuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8/ws5qM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8170AC43390;
	Wed,  6 Mar 2024 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709757638;
	bh=sswSikc9379ND8q2IbxyQfnO0n1h0QcZWhVJ5y3cvaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T8/ws5qMT2ZeTSc51b1Eib/zZP0Bic95ObfOLhmnFI6WWEkBsyEl8vGvsLXcfyAKo
	 eXOSRIunkpWWaW13DDe+UuAfMmdbbMhe3bXf355jRYlAu+9T2GL4TfXSQIB5H+MIts
	 cY7T0qhxeeu88XgXRTGgW8DV8nvGQKu0/t1SoWJZenI1I5imZpyKQpurVBR6tTR/eq
	 Aa2xSbiYR3EfIt1RPVDci+rUsIwoyuofq8zXyd5zv8kq16/cioamSKHrtUSzGaYBqT
	 qISnREjX/vWwbF7CkvbsqrnJzQOfg0VptWhIBORmtijTeo9YqXhEdryLecBqroaD0e
	 IjELyvAiHZOlQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d26227d508so724531fa.2;
        Wed, 06 Mar 2024 12:40:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTrubUlMl8+4Xy57LcTOHtvWrLa7p1K/wWdiBLitBirO6NUKYslyz6+yCY9a0myeLIlnl7MsiaDDatEczBBVStvP0mKOkae4GizfzqG35xaH6QANTA6KesS1ZHS8hm7vtUQFut5gtzhF3MgYki3WEmD6TLUGDuNtY+PA3I/+I4nhwsIg==
X-Gm-Message-State: AOJu0YymRRr7Kuimx0M6EF1tbMIXzAdurJ4vTt/LbETW7TVG4pLBmAQN
	QVVJW0gHC9anRtHsX+kdmhZqwGXmS2Eg3lEhe6Ckt2lFt41J6DgnMbZ2SXjm/JlpOk4D4M6vEie
	gnAZ+HGRdbofW1Cy7JcVn0wepQw==
X-Google-Smtp-Source: AGHT+IH8UTdel4s/VRNesdS4qceNJhsOkk+LDnUl/yDAojAV9TkPDtsy3/Q6DOzm2AeEjlXIQ6cPB2Jm2nQ7JJv7G7M=
X-Received: by 2002:a2e:7c17:0:b0:2d2:ca54:707b with SMTP id
 x23-20020a2e7c17000000b002d2ca54707bmr83492ljc.38.1709757636588; Wed, 06 Mar
 2024 12:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com> <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
 <20240304164423.GA626742-robh@kernel.org> <ZeZZyTU8FWACW9aj@lizhi-Precision-Tower-5810>
In-Reply-To: <ZeZZyTU8FWACW9aj@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Mar 2024 14:40:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
Message-ID: <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, imx@lists.linux.dev, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Joy Zou <joy.zou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:31=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Mar 04, 2024 at 10:44:23AM -0600, Rob Herring wrote:
> > On Thu, Feb 29, 2024 at 03:58:10PM -0500, Frank Li wrote:
> > > From: Joy Zou <joy.zou@nxp.com>
> > >
> > > Introduce the compatible string 'fsl,imx8ulp-edma' to enable support =
for
> > > the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.M=
X8ULP
> > > eDMA architecture features one clock for each DMA channel and an addi=
tional
> > > clock for the core controller. Given a maximum of 32 DMA channels, th=
e
> > > maximum clock number consequently increases to 33.
> > >
> > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++=
++++++++--
> > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Do=
cumentation/devicetree/bindings/dma/fsl,edma.yaml
> > > index aa51d278cb67b..55cce79c759f8 100644
> > > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > @@ -23,6 +23,7 @@ properties:
> > >            - fsl,imx7ulp-edma
> > >            - fsl,imx8qm-adma
> > >            - fsl,imx8qm-edma
> > > +          - fsl,imx8ulp-edma
> > >            - fsl,imx93-edma3
> > >            - fsl,imx93-edma4
> > >            - fsl,imx95-edma5
> > > @@ -53,11 +54,11 @@ properties:
> > >
> > >    clocks:
> > >      minItems: 1
> > > -    maxItems: 2
> > > +    maxItems: 33
> > >
> > >    clock-names:
> > >      minItems: 1
> > > -    maxItems: 2
> > > +    maxItems: 33
> > >
> > >    big-endian:
> > >      description: |
> > > @@ -108,6 +109,7 @@ allOf:
> > >        properties:
> > >          clocks:
> > >            minItems: 2
> > > +          maxItems: 2
> > >          clock-names:
> > >            items:
> > >              - const: dmamux0
> > > @@ -136,6 +138,7 @@ allOf:
> > >        properties:
> > >          clock:
> > >            minItems: 2
> > > +          maxItems: 2
> > >          clock-names:
> > >            items:
> > >              - const: dma
> > > @@ -151,6 +154,25 @@ allOf:
> > >          dma-channels:
> > >            const: 32
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: fsl,imx8ulp-edma
> > > +    then:
> > > +      properties:
> > > +        clock:
> >
> > clocks
> >
> > > +          maxItems: 33
> >
> > That is already the max. I think you want 'minItems: 33' here.
> >
> > > +        clock-names:
> > > +          items:
> > > +            - const: dma
> > > +            - pattern: "^CH[0-31]-clk$"
> >
> > '-clk' is redundant. [0-31] is not how you do a range of numbers with
> > regex.
> >
> > This doesn't cover clocks 3-33. Not a great way to express in
> > json-schema, but this should do it:
> >
> > allOf:
> >   - items:
> >       - const: dma
> >   - items:
> >       oneOf:
> >         - const: dma
> >         - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$"
>
> I understand pattern is wrong. But I don't understand why need 'allOf'.

The first 'items' says the 1st entry must be 'dma'. (It might need a
'maxItems: 33' too now that I look at it.) The 2nd 'items' says all
entries must be either 'dma' or the CHn pattern.

> 8ulp need clock 'dma" and "ch*". I think
>
> items:
>     - const: dma
>     - pattern: "^CH[0-31]-clk$"
>
> should be enough.

If it was, then I would not have said anything. If you don't believe
me see if this passes validation:

clock-names =3D "dma", "CH0", "foobar";

> If you means put on top allOf, other platform use clock name such as
> 'dmamux0'.

What? It's under an if/then schema.

Rob

