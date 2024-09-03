Return-Path: <dmaengine+bounces-3066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3A96A589
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 19:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19351C22F7C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796AB18E047;
	Tue,  3 Sep 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3MeMPe0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88718DF6F;
	Tue,  3 Sep 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385053; cv=none; b=ZkOKPClDk9XmHP5yjHbLNLuzt5lxOAjAenHFK2BGrM0bsoohYb+NGhqcqC3u8DZB1ieM7zny0iRhGrBOkb0Q2LP/hP8ztbUJ10QvC37SzYUsxWyS/lUoVH1DaSQsOxiO2qW00X8znQruOIq73MfpIKLaI3a8/rKQIHHTA9Gb9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385053; c=relaxed/simple;
	bh=2CVHYfdgtOiESD8/PN0ayDvmP0DM1kmIwyeaSIOT2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBWvCc8lY9SDFXm0faQIqkKAT+d88n+UyAW5mMVtGAeuZN4maxvatMvLkQN+WSvM+8M6wltQ+7xUJpWeXzxr3YaejrFDwOVAdbqbWp9W2NkrvLfnmWeP2RE/W2u3jrUebso163TAZB7hmo9SKX31xdWCv6N4Hfk/OrLB1Xkvf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3MeMPe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4756C4CECB;
	Tue,  3 Sep 2024 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725385052;
	bh=2CVHYfdgtOiESD8/PN0ayDvmP0DM1kmIwyeaSIOT2y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3MeMPe0w6Q5TmPDiXPV0sEKlakwxaik9LnhXC6sYUEp06zJNyhIWdGSpg3HfXIcV
	 iWGuVYpDP6AKptNG28oO1+5ya5jK8/vgm9CC9NIVlwjISWJ/UzRoYLNkceoL/ooMaX
	 VP6/xE45qv/YmrZjhce0TcY8VUWgnBclJ7cEHTH2Il6RT4l4u3XwFdYUDPi8N58XDF
	 uWP2Fpx3WQiMWO31RI8VjrEmVL3rPm2hno4P5iUIF7gS1tHsa1ALwpLssV+n2UTKqs
	 Vgf1WU1TOuedjl01CkaoCYu8AWccvpDCbLfT2YrLgDaf0gNw+pQCd9W2aPFf+mToo0
	 JY/OZxd5OXnfg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3f163e379so3904121fa.3;
        Tue, 03 Sep 2024 10:37:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjtB6ZmCOn/xYfSsFLyEeLDFHIc6b/KPFaQ9y3s7F+NQnGNvvhkSqzzlRkKDjVQOaOL2FZ8zK9mhY=@vger.kernel.org, AJvYcCXI1yQalRf71wXEP5oSgCGnl8S/gWDL6Cf08LnuEL9ohHUOq+eaxZl1Kkx9UWlWJ3b2b8c+MjCtGuvsHzyf@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBlcH5zdRnJept0Alaao/950vzJGPVBPfl/lWGvBMaS3FvQE6
	0n829XAxFGuSH3scUqWo8D5H8I+JBHnKtc7D8QwdXtVYwNZVlBCSFvPjj54PANvddWJsmTz7D6o
	mkjodXfUYzZ7XpRehlyB8e848Bw==
X-Google-Smtp-Source: AGHT+IEG5oVBhJ5WOhP1fkpH72d8RukknWumt2LliB4SbsjhdYyygnBiw5ZNqRm4aklMuYNu/EdKm+9aSuChtE9MRp8=
X-Received: by 2002:a2e:b894:0:b0:2ef:2422:dc21 with SMTP id
 38308e7fff4ca-2f6108adeecmr164621441fa.43.1725385050907; Tue, 03 Sep 2024
 10:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628152022.274405-1-piotr.wojtaszczyk@timesys.com>
In-Reply-To: <20240628152022.274405-1-piotr.wojtaszczyk@timesys.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 12:37:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2kqCZr5Gs0sOtbuyOfBD7G5g6hES6mzhr+_7JEEjagg@mail.gmail.com>
Message-ID: <CAL_JsqL2kqCZr5Gs0sOtbuyOfBD7G5g6hES6mzhr+_7JEEjagg@mail.gmail.com>
Subject: Re: [Patch v6] dmaengine: Add dma router for pl08x in LPC32XX SoC
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Russell King <linux@armlinux.org.uk>, Vladimir Zapolskiy <vz@mleia.com>, Vinod Koul <vkoul@kernel.org>, 
	"J.M.B. Downing" <jonathan.downing@nautel.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:20=E2=80=AFAM Piotr Wojtaszczyk
<piotr.wojtaszczyk@timesys.com> wrote:
>
> LPC32XX connects few of its peripherals to pl08x DMA thru a multiplexer,
> this driver allows to route a signal request line thru the multiplexer fo=
r
> given peripheral.
>
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
>  MAINTAINERS                   |   1 +
>  arch/arm/mach-lpc32xx/Kconfig |   1 +
>  drivers/dma/Kconfig           |   9 ++
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/lpc32xx-dmamux.c  | 195 ++++++++++++++++++++++++++++++++++
>  5 files changed, 207 insertions(+)
>  create mode 100644 drivers/dma/lpc32xx-dmamux.c

What happened to the rest of this series? Specifically, where is the
DT binding for "nxp,lpc3220-dmamux"[1]? Now it is undocumented.

Rob

[1] https://lore.kernel.org/all/20240627150046.258795-3-piotr.wojtaszczyk@t=
imesys.com/

