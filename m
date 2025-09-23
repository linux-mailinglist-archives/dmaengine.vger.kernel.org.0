Return-Path: <dmaengine+bounces-6692-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D607B94D99
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10F63A6CBD
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338CD3164C2;
	Tue, 23 Sep 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Eznf5cwO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597A548EE
	for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613736; cv=none; b=Ls2TyBCQKtymJD/8PsVV5jwxPPdJ/04j5HM1KbO5pXYZcexmUnkOmF9na3dqA288u7kQ+6yX/JjMNxeOZwIaZU3cT1K/RcKkp2n/a7V7u6jeyPVF9++SCIc8/gMeuvQUCaCf+Bczsow39thMCnFM8c/9BOAO8WJo6/jlLf2JDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613736; c=relaxed/simple;
	bh=AJaxzkgGMS2WBlrlop8PHPlSP36j70ySVSvjHs1aEs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeXuYnk2aS4idxrlBYLHLyCOAWY/JPNaC/omlKeMl4Ok/sgPeQZOakTzbMz79r2JY8Fy/a3B2Uads98LFv4Wv47s9NQUOWx/Gtp3gIRiQ6np8pD3b26WpOLZncphbrzRiznd2+SuurbrpbQMBEEDkabyyJ5I9Bz5ApR2xZtqLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Eznf5cwO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so2670006e87.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758613733; x=1759218533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJaxzkgGMS2WBlrlop8PHPlSP36j70ySVSvjHs1aEs4=;
        b=Eznf5cwOZ88V2MaKv6rCtt4MAxUW5dduUvOhPTHPEjhrlHMPdtFYL4g4qYiFPuFWR6
         yRDDhVGIZ6DAt/SLexaLsJ/KzyndNLZjcqXhu4E2VfIOM+HoLI+eheKVIE1NGXowZAk1
         yA14gM8ifFev7H/ctGl7NvU+O35jBj0uPidDyla1urUOMuP1VUnC4mYP/kDzVshUgnVy
         5HpRSv7cAmu0dNByp8t0STC4EtGaMvBVJ3rzsrwYRC7PgGZmil1bFZeL5Mq8k6NBoj3S
         5/T71ntfl4kZ5JIOnCaaRgMy4+X+mUCOuT9otCord4WGZj3z/5owucBaHuWvnfO7zr90
         r5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613733; x=1759218533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJaxzkgGMS2WBlrlop8PHPlSP36j70ySVSvjHs1aEs4=;
        b=CAr7nDMQWfgPWqb8pZj/1SjwbLdLBpPh/vL7Ii2eJJ+wBdf0P3tLzoezXlVT4WX8SF
         CFIjwxyQXOmMb/qK68McdxxmTgFQtFVTRbvxXCWQ9W3uaqY64EQmguWvpPZR6QZbcqnV
         qKn6c7hQhncPHFlu78KQ1UmgeIfLkJdonhDI14aYW2LDcAysPhi8YLFRreq1eZBD3YdV
         MZ0//U8fa3uPvbFdM/RHWANLqZ/b/yqNyKI/T8tZzvgyymNMvzGofL5S2TgwofYR93ze
         6XSwQngmBJXFCIv76kquViDu2rE16Hh8Nh1uT6f4dRS/daJ5Wj9aI1aZtjBY/KTNuYNK
         g1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWc9eyhzfUs+eMVXIiZg9JmF/4eI598gKcUXjIZayD/zqeLpu+qg/9fYdKKiodH/tzfl6ruZv7yHGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypd7rp4t2HAWUv0poDWKFQA0UXqlih1weDm0N8nKuabp4S//xJ
	4rZyoMSxzstzwH3miYWDNBvhOXg7DN5hl4WoEYXguE9FwMVshNgXNuP9FJ0et1OkEGiKi3I2tPE
	Z8MWzlFw1ddvzzour91cD338Yl7SNswRaWU8FShDBfA==
X-Gm-Gg: ASbGnctxC3dchji5JmAHIYYh7R7d/U/xzsAqmyzjvQ6AJcpE0FloCCsHahHj0WQk3iV
	/EscmJ3wUHW7zCcSe1geEb5hYIAEcnMSuotNeLg9jVwl/02kJa8ZeURm/PZjWKOTWMVU/PnqAlH
	V6iEjD7kCvtdcRLiviCr6Hgi6pX6g+Njy/Xl5BVVXx39KnIv8/PAnvwSnvpB/SG3cZxcn0LnJH1
	0e01fpf4u4t08/nszhmPbQpq6n6FpXORpVZqQCQbD7kcX4X
X-Google-Smtp-Source: AGHT+IFXCbUC7OKlJXhiIcyp3/0pEbhIPcVmkwcaoRpLoXztj3Zx0ZDwfLpI5huj43NEMpkp0HP1DS+xrpQFvaRxUT4=
X-Received: by 2002:a05:6512:b19:b0:578:cee7:7aa9 with SMTP id
 2adb3069b0e04-580734f07d9mr498868e87.48.1758613732567; Tue, 23 Sep 2025
 00:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com> <2wwi3ktbcuyp7y7mqplndvawagae5hdhcx3hn375kycoqtows6@xcww2237rxpe>
In-Reply-To: <2wwi3ktbcuyp7y7mqplndvawagae5hdhcx3hn375kycoqtows6@xcww2237rxpe>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 23 Sep 2025 09:48:41 +0200
X-Gm-Features: AS18NWDP_wgtg5ZAo1aJS0Vwp6mqsgj6RBa2BQg1A6VrGdFXcg4GLeRrQ88qOWM
Message-ID: <CAMRc=MdhQMR=-ayz+GfigUMVy+j1QNO3LguMoZYa5_+Es3E5Ow@mail.gmail.com>
Subject: Re: [PATCH 00/10] RDA8810PL SD/MMC support
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:45=E2=80=AFAM Dang Huynh <dang.huynh@mainlining.o=
rg> wrote:
>
> On Mon, Sep 22, 2025 at 04:17:05PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
> > <devnull+dang.huynh.mainlining.org@kernel.org> wrote:
> > >
> > > This patch series aims to add SDMMC driver and various drivers requir=
ed
> > > for SDMMC controller to function.
> > >
> > > This also fixed a bug where all the GPIO switched from INPUT to OUTPU=
T
> > > after the GPIO driver probed or by reading the GPIO debugfs.
> > >
> > > This patch series is a split from [1] to ease the maintainers.
> > >
> >
> > This is still targeting at least 4 subsystems and isn't making the
> > merging any easier. Are there any build-time dependencies here? If
> > not, then split it further into small chunks targeting individual
> > subsystems and the relevant ARM SoC tree.
> The MMC driver depends on both the clock and the DMA driver.
>

But is the dependency a build-time one or does the MMC DT node
reference clocks and the DMA engine by phandle? I assume it's the
latter in which case it's fine for them to go into next separately.

Bart

