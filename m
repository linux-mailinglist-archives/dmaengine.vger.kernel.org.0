Return-Path: <dmaengine+bounces-6674-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380CB919FB
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBB316F561
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192FE1E834E;
	Mon, 22 Sep 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FJtRL/ii"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE171DD0C7
	for <dmaengine@vger.kernel.org>; Mon, 22 Sep 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550643; cv=none; b=gDwivJOM3TPUtTTZFn3N0tFTSzg9LSxJsyVKeO7XrBtuk0JfEWe5xU+3eIVKjdiox8xucedgbt5uwi1ufLBFf33G7WJZYPzec5vFehas6lzZgwHNeMDo/uBUuATEjC9fESWVc3Bh63DqpeAb+kVey0+xgfBNt0pbIr9qqX3d4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550643; c=relaxed/simple;
	bh=fWzzdjlL6Qeihn+o/itxjEqN74qvQQO38r2QqurBj94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSiadhx5UzgW413bh99l61BnhtA1lgaiN/hdxMRiCsCA4lXJeY7j3LpW/Prwq44nFnyt0YVWdUkfu8oHQFqlQE6b4Qi2PBuZ5YQGgRqKfDeCwhL1IsIbZBwZxmm0oCcRgy6wcxYbWRIEnToPIyQXTGt8ChR+wUbt2OcQdWGudRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FJtRL/ii; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso14311131fa.0
        for <dmaengine@vger.kernel.org>; Mon, 22 Sep 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758550638; x=1759155438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D42mDx7XES4dJT5DCpqob2SIIqhWq10lpNC2IIru3f8=;
        b=FJtRL/iilefnLtGJ8RHt8JgsdkR9Bwv5jp5h9u6hOudyZ6LPBr9JRFkLYvaXS5n/Pj
         3eN6Slc2BXlzCDaaPKfYUf5kPD8EA8rodgkufNy8SWMmZi14ttFzIAHz7CnvDpQbeG9P
         CltohY2KfFtz68kLonVt6XNO6gjd8lrIw9B9vlGk4wwxZvnWInWWjtBaC40wPJK9CDOh
         QnNLP1EwDbHlXAfEEI8M6895VghrF9762JOwmVEvQqjx+nH9TOnut8S28f/AwfvZjytS
         2Wn1dHe5v0Lq10jRdpBiKL4t3iN1tecmmm8LUqjTucWDL/g9rbqyOm3rXyuCvHdO41fa
         xh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550638; x=1759155438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D42mDx7XES4dJT5DCpqob2SIIqhWq10lpNC2IIru3f8=;
        b=QIAtU8QSRL3O6fGXiQE8Ig87PVU/ZHk/LAVPDh8iw08p+EJ3erVlcbm+kXrfJGZuxn
         otq5QfQpVZW6GPcRIktjHna1FAnTx+gpsUXAWs2guKb9BGrr6E6bUXET4lFeQVv2Ww+K
         2A9arW63/OOAcp18yAGjPi97xoF4e0V3qpRKJr4N+zjCx6UB6KUKuovM/7UlZ4PBX4j0
         x8oOnP2/SEBeVCWyKfV7CGzDHt2iDA/gbR1SrkrQBaQGfnM4mz9H9GDtaPvmYexDw9q/
         KH4BtfTv0cSMm2HvT3FYLxxJ7BnT3idWMBJY3MidMN7CQcZ0RE+cQ/zFpolb99Jf9yMr
         aI6w==
X-Forwarded-Encrypted: i=1; AJvYcCUcY9XAcaxhu7xURn/XRjfuULLSseBozYhYGdtYYJTt1VmQ/Ci08OrYKKmf/tYadjgoBxoN8fBrgVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28LOZx2OlbXJ1OuCRa4fXrVgdSUDzBkcEkYw4CoqpEcw4Meau
	fsv1MW7oXIT01AsqFCGU8qBTPU12kW1DW/zskwOPcvWx6XkTjbMIpQR/oofHs7cmspsV956FYDP
	X0oRDqV2581Jhk/EdgCp9idICq4CcB8TA9p9+vINi0g==
X-Gm-Gg: ASbGncvniz8swWemkEM04B8hm4Co72UfGCn4vNJWlQDClJi82rmFCJ5VSVytExRhATt
	+KwMeEAoMX7I24PNqVMYyPglx94MdaaZPbIyoNU1sDAuBRhX48/FyXvwfs9AQc80Fd+C5TINadO
	CtFC324EE2SUk81oS3QkzR2+NU1EolXXh6awrWeZ6neo9QhCvRg2iyGSUlQGPeKynrQiRxGVP6o
	sA0I65FqipsfuRkOM7yB0+FJHnwpCjuY7gL1Q==
X-Google-Smtp-Source: AGHT+IGS2AjVg06y9Gl4ZoVygRe0txj+WZLEO+s0iRtEWqABbE+tNtV+p0mvb++GTiupjPDEskTHy6Yf/wVmcolsOo4=
X-Received: by 2002:a2e:be07:0:b0:36a:97e5:c4a5 with SMTP id
 38308e7fff4ca-36a97e5c8d3mr17177811fa.39.1758550638057; Mon, 22 Sep 2025
 07:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:17:05 +0200
X-Gm-Features: AS18NWBBtPPpfa65LcAbGVqvkVRIVUyroOGhaWLkgkmXpHaSdWCO_RUkKb2djeo
Message-ID: <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com>
Subject: Re: [PATCH 00/10] RDA8810PL SD/MMC support
To: dang.huynh@mainlining.org
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

On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
<devnull+dang.huynh.mainlining.org@kernel.org> wrote:
>
> This patch series aims to add SDMMC driver and various drivers required
> for SDMMC controller to function.
>
> This also fixed a bug where all the GPIO switched from INPUT to OUTPUT
> after the GPIO driver probed or by reading the GPIO debugfs.
>
> This patch series is a split from [1] to ease the maintainers.
>

This is still targeting at least 4 subsystems and isn't making the
merging any easier. Are there any build-time dependencies here? If
not, then split it further into small chunks targeting individual
subsystems and the relevant ARM SoC tree.

Bartosz

> Tested on Orange Pi 2G-IOT using a Buildroot environment.
>
> [1]: https://lore.kernel.org/all/20250917-rda8810pl-drivers-v1-0-9ca9184c=
a977@mainlining.org/
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
> Dang Huynh (10):
>       dt-bindings: gpio: rda: Make interrupts optional
>       dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
>       dt-bindings: dma: Add RDA IFC DMA
>       dt-bindings: mmc: Add RDA SDMMC controller
>       gpio: rda: Make IRQ optional
>       gpio: rda: Make direction register unreadable
>       clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
>       dmaengine: Add RDA IFC driver
>       mmc: host: Add RDA Micro SD/MMC driver
>       ARM: dts: unisoc: rda8810pl: Add SDMMC controllers
>
>  .../bindings/clock/rda,8810pl-apsyscon.yaml        |  43 ++
>  Documentation/devicetree/bindings/dma/rda,ifc.yaml |  45 ++
>  .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
>  Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  92 +++
>  MAINTAINERS                                        |  18 +
>  .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  20 +
>  .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  20 +
>  arch/arm/boot/dts/unisoc/rda8810pl.dtsi            |  47 +-
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/rda/Kconfig                            |  14 +
>  drivers/clk/rda/Makefile                           |   2 +
>  drivers/clk/rda/clk-rda8810.c                      | 769 +++++++++++++++=
++++
>  drivers/dma/Kconfig                                |  10 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/rda-ifc.c                              | 450 +++++++++++
>  drivers/gpio/gpio-rda.c                            |   4 +-
>  drivers/mmc/host/Kconfig                           |  12 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/rda-mmc.c                         | 853 +++++++++++++++=
++++++
>  include/dt-bindings/clock/rda,8810pl-apclk.h       |  70 ++
>  include/dt-bindings/dma/rda-ifc.h                  |  28 +
>  22 files changed, 2495 insertions(+), 9 deletions(-)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250918-rda8810pl-mmc-3f33b83c313d
>
> Best regards,
> --
> Dang Huynh <dang.huynh@mainlining.org>
>
>

