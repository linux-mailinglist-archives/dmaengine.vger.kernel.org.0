Return-Path: <dmaengine+bounces-826-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495E083C71D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F380728F50D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCCE745FA;
	Thu, 25 Jan 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgRkhNAK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBC745F0;
	Thu, 25 Jan 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197542; cv=none; b=fnLPjUXl8njtE8D5shq6wgZehl/SF0LIycSEakcBilYNqYnaaW7ohG61JdsbbJ8DUWTJjxvG2buqwDm/QaGvkwWgjypoGiCQiKAuxG2fS5ehO55doL35Odw/YTHsFphIEn8QiEcCF7+bEDrcBfeAYW07CXitBqaodKRkhw8S4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197542; c=relaxed/simple;
	bh=LSd+p9tqQe9xvQ1Ck8fwwM0f59A6GB2VqQdcIDtb1Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/hdSPR5ZmAwtUzLq5voaiA3wZpjQRINZ1Y3hOS85FDlHz/AtjSq+EkipTqZHVU4lqDCDSmj9vZfV0urBynAvsXmR/ufBoX09jGHah9F7BrXRHTicuup4kUijUydWZLjY3Ham0P6+ADiTwzFhS2B9MTPyS6MNi8azAtzN4Dnzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgRkhNAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20E3C43609;
	Thu, 25 Jan 2024 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706197541;
	bh=LSd+p9tqQe9xvQ1Ck8fwwM0f59A6GB2VqQdcIDtb1Ro=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=BgRkhNAKYFlwMND1yFknrfT0HtJYdi9oC6rkMg48B0VjthqMcgypt5Ky3bcgESdqh
	 DWc3wb38X3OSDRlolG2YN1qdJvEejGkv1QrkBq7S61HqZ4Pky01kKskpk1BJ5otP70
	 94nsWXGUn02RMSU2RWK6ThV/mLnziZtPyJtX+K84jxEqTD+/u77igSNiXzzgDhlGjd
	 70U/Xo08VlWOaa9ZKhrMbaqtX9UpFUpcgYgtg8f7H+20FUtMqZ/yTz6qJg15Xxej7O
	 z2xwp4eFVJ7WBM2Z8iX7mMrHE2jid9wznrc2Ein4gmi7/EaYF/bc4mEsoim9lbEZZl
	 n+jZvZYnOwUyA==
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3884129a12.2;
        Thu, 25 Jan 2024 07:45:41 -0800 (PST)
X-Gm-Message-State: AOJu0Yz5HErKUbrEKk4by9ixmD2KvqFzuIar86/F5Kc9H5hE3oJXfoIl
	pjEHL0ExtRq2VzqAxxFOfZOCaITtNOaLQBNfVkGCWyv4psbvtn9YCsTA1u1BUgf66KYdvCSN2eH
	vx1kngwP/upzhHuHSvr5pCT2jv9I=
X-Google-Smtp-Source: AGHT+IEDkFC2HvIRERexWpUkVEZ2RLrKEk1HlzpxIR1iwtBWwHcQLFIsNry8fLlluicNYpj+4ciYmw8MPcuj72MuR/g=
X-Received: by 2002:a05:6a20:432b:b0:19a:fa18:c306 with SMTP id
 h43-20020a056a20432b00b0019afa18c306mr1213214pzk.6.1706197541181; Thu, 25 Jan
 2024 07:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122170518.3090814-1-wens@kernel.org> <20240122170518.3090814-5-wens@kernel.org>
 <20240123004010.59cac5ad@minigeek.lan> <CAGb2v66UmLuWyLvvULZeW6MKFauM-xAMPAO9W_TPAByXYqKCBg@mail.gmail.com>
 <20240125150942.2535a228@donnerap.manchester.arm.com>
In-Reply-To: <20240125150942.2535a228@donnerap.manchester.arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 25 Jan 2024 23:45:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v650reNd9n-epiCYs6dkbvaG9xARbyP6Rn9eDAKc-sS6+Q@mail.gmail.com>
Message-ID: <CAGb2v650reNd9n-epiCYs6dkbvaG9xARbyP6Rn9eDAKc-sS6+Q@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 11:09=E2=80=AFPM Andre Przywara <andre.przywara@arm=
.com> wrote:
>
> On Thu, 25 Jan 2024 22:37:34 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> > On Tue, Jan 23, 2024 at 8:41=E2=80=AFAM Andre Przywara <andre.przywara@=
arm.com> wrote:
> > >
> > > On Tue, 23 Jan 2024 01:05:15 +0800
> > > Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > > From: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > The DMA controllers found on the H616 and H618 are the same as the =
one
> > > > found on the H6. The only difference is the DMA endpoint (DRQ) layo=
ut.
> > >
> > > That does not seem to be entirely true: The H616 encodes the two lowe=
st
> > > bits in DMA_DESC_ADDR_REG differently: on the H6 they must be 0 (word
> > > aligned), on the H616 these contain bits [33:32] of the address of th=
e
> > > DMA descriptor. The manual doesn't describe the descriptor format in
> > > much detail, but ec31c5c59492 suggests that those two bits are put in
> > > the "para" word of the descriptor.
> >
> > Good catch. So, same as the A100 I believe?
>
> Yes, that's what I got as well.
>
> > > The good thing it that this encoding is backwards compatible, so I
> > > think the fallback string still holds: Any driver just implementing t=
he
> > > H6 encoding would be able to drive the H616.
> > >
> > > I think the A100 was mis-described, as mentioned here:
> > > https://lore.kernel.org/linux-arm-kernel/29e575b6-14cb-73f1-512d-9f0f=
934490ea@arm.com/
> > > I think we should:
> > > - make the A100 use: "allwinner,sun50i-a100-dma", "sun50i-h6-dma"
> > > - make the H616 use: "allwinner,sun50i-h616-dma", "allwinner,sun50i-a=
100-dma", "sun50i-h6-dma"
> > >
> > > Does that make sense?
> >
> > I wouldn't call that exactly backward compatible. Say the driver forgot=
 to
> > clear the two bits. It would work fine on the H6, but the accessed addr=
ess
> > could be way off on the A100 and H616.
>
> I don't know the exact boundaries of "compatible" here, but the H6 manual
> pretty clearly states "The descriptor address must be word-aligned."
> But since the A100 compatible is known and supported for a while, that
> doesn't really matter, practically speaking, I guess.

I'd say that makes the descriptor address register backward compatible,

> One could check how the H6 DMA controller reacts to those bits not being
> 0, not sure if I find the time, though.

but no idea about the parameter field in the descriptor. So for now I
think we should just be cautious. Since as you mentioned the A100 is alread=
y
supported and listed separately, lets just keep that for now.

ChenYu

[...]

