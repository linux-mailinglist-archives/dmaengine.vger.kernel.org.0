Return-Path: <dmaengine+bounces-6707-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC6EB9D74F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 07:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6134F4A767B
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 05:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5122D7A5;
	Thu, 25 Sep 2025 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="r+gJW21t";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="7H/Wq/K/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194F6FC3;
	Thu, 25 Sep 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778292; cv=none; b=TOTHfl2/nFYKGdnXOqYbByctOboTy+YSXAiKU2T9k2KNrHzbgpNx5WamTRz1aT+iQCDd9oMeCTevWB51Qq7Dm10FT6UvpDD67PgUAP40eJECkrB2NIYJ1FMWLrFaw+dB83gdZwFaS9vNs50MOHwvgDlEN8Exm+VjHsuLQdf6cb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778292; c=relaxed/simple;
	bh=MuMIWBOOKsTqjpiSXFq9YXCQld8+ryrFY/LjXvw78nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeIqFS3bJWhzMywAUa2lTIuYbPzU1gD601BlbXQfwfyKAynRbVgrY/cpzJSpn6Z0vCAAGrLHNUrBETVEej6gIHwuv/EOwucyiw60xYKi2QamTs7sxpoD3UKhTwg8VDamr3ZmI3/2p6VxVZPH4IH3KM5jJhsYXMHgBk4+GoJhZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=r+gJW21t; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=7H/Wq/K/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758778235; bh=15jVDoRkTQI4moI14kL6/Hu
	HLvXXwZlH8CR70zusrGk=; b=r+gJW21tDHRnMFA6wikCcWjX1XVKMP+yliQIoP/+sFDwQcjEc+
	c17V+Ls0IvmmBwvXnSn1HooMulkAFfDl5D3q2oAmS8jaN+HsOsMJUaXzFy2NKXL7dVBawT6redO
	qazX5po5MKIGokKocr27/3LBlKGKiZzbf+IFjjYB1/2759M06356juEJC4zJil6SeIWgeV4WkP2
	LFqGk/CERuHyjtHIVLdsuSTuYPyjh05MRy82E3Aqedd9MhvObD6/d7QjqaSuOjlxie/p+XVO30A
	28hLM6fFESkdGY40N0+/rJU06NTKjOQg9MVXxFN1/EdRDz2+RnBvQ9MXTqD2xhakqOg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758778235; bh=15jVDoRkTQI4moI14kL6/Hu
	HLvXXwZlH8CR70zusrGk=; b=7H/Wq/K/fqu/IRvYGMkd8GhMTFzBbVCPVCga+abr+ROdi4TkbN
	FFw1WO2QYYzw7U9buFGAZExo7VPOfP3/bHDQ==;
Date: Thu, 25 Sep 2025 12:30:26 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 00/10] RDA8810PL SD/MMC support
Message-ID: <hrgwhmzmu5wpggk7aatuaxc5bnxmjvs4jthxicxekniux5jlbm@lre4gzt75wea>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com>
 <2wwi3ktbcuyp7y7mqplndvawagae5hdhcx3hn375kycoqtows6@xcww2237rxpe>
 <CAMRc=MdhQMR=-ayz+GfigUMVy+j1QNO3LguMoZYa5_+Es3E5Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdhQMR=-ayz+GfigUMVy+j1QNO3LguMoZYa5_+Es3E5Ow@mail.gmail.com>

On Tue, Sep 23, 2025 at 09:48:41AM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 23, 2025 at 5:45 AM Dang Huynh <dang.huynh@mainlining.org> wrote:
> >
> > On Mon, Sep 22, 2025 at 04:17:05PM +0200, Bartosz Golaszewski wrote:
> > > On Thu, Sep 18, 2025 at 8:49 PM Dang Huynh via B4 Relay
> > > <devnull+dang.huynh.mainlining.org@kernel.org> wrote:
> > > >
> > > > This patch series aims to add SDMMC driver and various drivers required
> > > > for SDMMC controller to function.
> > > >
> > > > This also fixed a bug where all the GPIO switched from INPUT to OUTPUT
> > > > after the GPIO driver probed or by reading the GPIO debugfs.
> > > >
> > > > This patch series is a split from [1] to ease the maintainers.
> > > >
> > >
> > > This is still targeting at least 4 subsystems and isn't making the
> > > merging any easier. Are there any build-time dependencies here? If
> > > not, then split it further into small chunks targeting individual
> > > subsystems and the relevant ARM SoC tree.
> > The MMC driver depends on both the clock and the DMA driver.
> >
> 
> But is the dependency a build-time one or does the MMC DT node
> reference clocks and the DMA engine by phandle? I assume it's the
> latter in which case it's fine for them to go into next separately.
Yeah, it's the latter. I'll submit a v3 in the future.
> 
> Bart

