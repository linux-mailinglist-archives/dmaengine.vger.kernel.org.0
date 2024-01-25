Return-Path: <dmaengine+bounces-824-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D743A83C4EC
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 15:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A191C21D07
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72946E2BD;
	Thu, 25 Jan 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyNb4R1O"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603E4F218;
	Thu, 25 Jan 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193466; cv=none; b=cTZ1LdjFUY1UN5xMuYvM7Nreg6giyucRWWrpriYFIRmuAVbVcBFYeDVOXsonQQ2Hsnp2aB8HCKeTOI3cg6Shph/tcJNHrWfkaxbMpJ5w5FMqQS+YkSdQIBTv7ZAFMt8T7lbGQyQ5u/MOW1fu5bQzQW5qgSMhQ+mEX6A3Lv7aW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193466; c=relaxed/simple;
	bh=YAJ84nFqDAAULU1LrFi+Bod6RZHD93P1gKfDzYnewtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfhRTvw59D5I/VM4DJ/fngE9qlABrRwm4z1jF0iSv6Xgv/4uY2VVSpgOi9227W932u0yevgoSmQWW71k6UpLf6OuVxoi5ycaYrPkH3Nfpo7Fj3UlGgrn3lvqTnrcm+8g+/uKu7TdIjw2DpwFRojsQ3uZ0W/XxLou6mtT85KOmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyNb4R1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BA8C43390;
	Thu, 25 Jan 2024 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193466;
	bh=YAJ84nFqDAAULU1LrFi+Bod6RZHD93P1gKfDzYnewtE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=AyNb4R1Ox5Sv2XDBewRnHPFjArH3pt/MhCM8kNlYk9WkiHcEteOyf0pd2LTXukMPx
	 rYrcrzhgbjYoAeElb3dPQHnCbRmPRmpWVx+sz4KgHLcN/bc0R+Y8kNBIXrvnvFcPNF
	 +qVAsIFvC8zTMU+dl7NNYyjepXSp14gk+vDTuipT51iBWRsihoZacfckqZm8mSCzvn
	 dWQ9BDdLV2mOX0SmDkF37brPI4Qwn6AMiHaJkqOrYrnc5ab/ve0FHrULTNMndADKUJ
	 nfdVSrh0fBPJkTJIhd91uYfy92B9KYbpt5rM3OSG7OpF91X8Ti+iXgBjAhbl/g/g4p
	 R0fq1xCMR5s9A==
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so3625355a12.0;
        Thu, 25 Jan 2024 06:37:46 -0800 (PST)
X-Gm-Message-State: AOJu0YxBPzsFVTo3TvPt3TO5Fzv9hwGWkBBwFlP42cgTVO6Ok2A5K1Lh
	SHeftDQDCZKwI7uPngltTtXuxaVdVW9Jy0gY9hscZSU5AKPwCKwADuXCmgDzlqqrhqtCj+FRp+y
	ATkbFJUj9eKxZo3sXKiAkrIYh6Eg=
X-Google-Smtp-Source: AGHT+IHMDXu5vLiZaszPKiS42W06RUB1yoz7PCt7rek3lH97h03j66qsoEA9gOP8ssrxNd6PSDM1IsM6gy8Gek1sVvc=
X-Received: by 2002:a17:90b:b85:b0:28c:a9d0:33ff with SMTP id
 bd5-20020a17090b0b8500b0028ca9d033ffmr645889pjb.62.1706193465678; Thu, 25 Jan
 2024 06:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122170518.3090814-1-wens@kernel.org> <20240122170518.3090814-5-wens@kernel.org>
 <20240123004010.59cac5ad@minigeek.lan>
In-Reply-To: <20240123004010.59cac5ad@minigeek.lan>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 25 Jan 2024 22:37:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v66UmLuWyLvvULZeW6MKFauM-xAMPAO9W_TPAByXYqKCBg@mail.gmail.com>
Message-ID: <CAGb2v66UmLuWyLvvULZeW6MKFauM-xAMPAO9W_TPAByXYqKCBg@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatible for H616
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:41=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Tue, 23 Jan 2024 01:05:15 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The DMA controllers found on the H616 and H618 are the same as the one
> > found on the H6. The only difference is the DMA endpoint (DRQ) layout.
>
> That does not seem to be entirely true: The H616 encodes the two lowest
> bits in DMA_DESC_ADDR_REG differently: on the H6 they must be 0 (word
> aligned), on the H616 these contain bits [33:32] of the address of the
> DMA descriptor. The manual doesn't describe the descriptor format in
> much detail, but ec31c5c59492 suggests that those two bits are put in
> the "para" word of the descriptor.

Good catch. So, same as the A100 I believe?

> The good thing it that this encoding is backwards compatible, so I
> think the fallback string still holds: Any driver just implementing the
> H6 encoding would be able to drive the H616.
>
> I think the A100 was mis-described, as mentioned here:
> https://lore.kernel.org/linux-arm-kernel/29e575b6-14cb-73f1-512d-9f0f9344=
90ea@arm.com/
> I think we should:
> - make the A100 use: "allwinner,sun50i-a100-dma", "sun50i-h6-dma"
> - make the H616 use: "allwinner,sun50i-h616-dma", "allwinner,sun50i-a100-=
dma", "sun50i-h6-dma"
>
> Does that make sense?

I wouldn't call that exactly backward compatible. Say the driver forgot to
clear the two bits. It would work fine on the H6, but the accessed address
could be way off on the A100 and H616.


ChenYu

> Cheers,
> Andre
>
> > Since the number of channels and endpoints are described with additiona=
l
> > generic properties, just add a new H616-specific compatible string and
> > fallback to the H6 one.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  .../bindings/dma/allwinner,sun50i-a64-dma.yaml    | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64=
-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.=
yaml
> > index ec2d7a789ffe..e5693be378bd 100644
> > --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.ya=
ml
> > +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.ya=
ml
> > @@ -28,6 +28,9 @@ properties:
> >        - items:
> >            - const: allwinner,sun8i-r40-dma
> >            - const: allwinner,sun50i-a64-dma
> > +      - items:
> > +          - const: allwinner,sun50i-h616-dma
> > +          - const: allwinner,sun50i-h6-dma
> >
> >    reg:
> >      maxItems: 1
> > @@ -59,10 +62,14 @@ required:
> >  if:
> >    properties:
> >      compatible:
> > -      enum:
> > -        - allwinner,sun20i-d1-dma
> > -        - allwinner,sun50i-a100-dma
> > -        - allwinner,sun50i-h6-dma
> > +      oneOf:
> > +        - enum:
> > +            - allwinner,sun20i-d1-dma
> > +            - allwinner,sun50i-a100-dma
> > +            - allwinner,sun50i-h6-dma
> > +        - items:
> > +            - const: allwinner,sun50i-h616-dma
> > +            - const: allwinner,sun50i-h6-dma
> >
> >  then:
> >    properties:
>

