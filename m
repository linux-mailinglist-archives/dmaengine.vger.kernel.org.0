Return-Path: <dmaengine+bounces-823-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24083C4BA
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858C428D10F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D296E2B0;
	Thu, 25 Jan 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVJA1mvh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153586DCED;
	Thu, 25 Jan 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193128; cv=none; b=lB2X54qCIgYpCQHO/3yBc5NY4fH7m91PL9eJhOHEmWROfHQe9FIvyc846vTJW41TojolOakvUrCXXtLl3zx1lkLn0yYBU7T6jLj+K/IAxfOdjyYzbb4SK36AVCPnJ7TC5MaarqMcjnIT1uzFh6WS1D70NF4/9tNbQVLV5K3r8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193128; c=relaxed/simple;
	bh=SJIO9VIDAxEd2fRuCQOCXVo5yJC9Bfk6F7wNGJj+PcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m35dzHgDrTiUYk05YYh0WSInXKZbCjQNQPgUuEwJ5qc2dgEmjHBUykIkAz+pMH3U3wyaasE01DQT0KMxWTmHORYrsiiqQZpx39duXx57NcmmX2E9Y12hwaCNm9aN9ihOMyXLDg9gxhB8Nf9I2pRUD7/taKIqQIjF8UA2pmDaHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVJA1mvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96214C433A6;
	Thu, 25 Jan 2024 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193127;
	bh=SJIO9VIDAxEd2fRuCQOCXVo5yJC9Bfk6F7wNGJj+PcI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=YVJA1mvh6RwBjLGjd1sfDBtmLYMeZk2Vb1Vxa9VgXpAdZSTyvCqebluNvJMNpga2H
	 zIqQVyYC/2Itq6ME2zUndhbGU4wwQMJnTve1RG55b1fQ/wcezBKtWxmpEWMVKaRfPN
	 VRi3BhTaZ65e1dTFRmPd9YdQ+AOzFYFMs0Aq/ftOmbbA6XWBUf17nr8Begw8wZ+jjY
	 SK8tNApqDdTp/yh4/WxDr7l2WFY1/iBN3tKF1fuJAize0s0umkXhfRxinfpn7d4l8t
	 9uNdR4vKJYZc9dL1X4CLmwfwL2Vl/NzNUFqD4CjjJ4/+K6Pal52rpWZtW4O4SsQSe1
	 Lk+cu6IQtoPvQ==
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce942efda5so5115017a12.2;
        Thu, 25 Jan 2024 06:32:07 -0800 (PST)
X-Gm-Message-State: AOJu0YxHg+LyqLWzNAkbQzwQjk7TNIq1TH6Q/rkXiFbdc4GIE1t0uqX+
	zIypEnfEKefWCKh0NZThdzffx6D1fH1wXw92aBSW6tz6tmocsyvmjhs/MNNawcfKkgfZ23kfjXD
	0wNI79b4GsRoOOqznQI0TksZo5tY=
X-Google-Smtp-Source: AGHT+IHrAfERyC/G24kGm+lJuLa6CaK8isz0YBY43lr4aF2Wssm2223XiVCbwz+daaJHCxHYabrneXLR5cWNqYl33Sk=
X-Received: by 2002:a17:90a:cc0e:b0:28d:bd5f:1e5 with SMTP id
 b14-20020a17090acc0e00b0028dbd5f01e5mr711022pju.44.1706193127134; Thu, 25 Jan
 2024 06:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122170518.3090814-1-wens@kernel.org> <20240122170518.3090814-5-wens@kernel.org>
 <20240122-resemble-nearness-60dafde2e25d@spud>
In-Reply-To: <20240122-resemble-nearness-60dafde2e25d@spud>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 25 Jan 2024 22:31:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v65hGBVyhnok79fn9bgdXXeLHVZ0uUobqxaVU75Lh5-BCg@mail.gmail.com>
Message-ID: <CAGb2v65hGBVyhnok79fn9bgdXXeLHVZ0uUobqxaVU75Lh5-BCg@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatible for H616
To: Conor Dooley <conor@kernel.org>
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

On Tue, Jan 23, 2024 at 2:18=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Jan 23, 2024 at 01:05:15AM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The DMA controllers found on the H616 and H618 are the same as the one
> > found on the H6. The only difference is the DMA endpoint (DRQ) layout.
> >
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
>
> Instead of introducing this complexity, could you instead use "contains"
> here? Unless I am missing soemthing, you can achieve the same thing here
> with:
> |if:
> |  properties:
> |    compatible:
> |      constains:
> |        enum:
> |          - allwinner,sun20i-d1-dma
> |          - allwinner,sun50i-a100-dma
> |          - allwinner,sun50i-h6-dma

Thank you for the reminder. I had a vague impression that something
simpler worked, but couldn't remember what exactly.

ChenYu

