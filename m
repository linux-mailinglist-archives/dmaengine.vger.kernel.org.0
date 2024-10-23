Return-Path: <dmaengine+bounces-3426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC39AC686
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 11:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FA328231B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259619E7F7;
	Wed, 23 Oct 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL30c8PQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845619DF45;
	Wed, 23 Oct 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675761; cv=none; b=GE71Za+QfpDZVzADpZQ6qNChyFPnpMMw328bH9ow4tWrZkluWc7zTSWjbGIhfffu3JC4wLbj0PLFoonEOIdWFkPpoAEyLti5vyPAi/vW52BeSpfw8d2MHf1ezoPTkQIpjgAsbnYNxAR7JPdL2CcdC/y+rRo520KYsQShtWV7QEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675761; c=relaxed/simple;
	bh=frcbCBcxWI7oSZeWp5sCkDmE4+FLgK5Jb/M/koYwAog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7C5J8HPKpv4hRRThCqtzwJ9EgYb6spa0hMWRIRithkIM59RR3WY8eVGo+43kzxJtXzB4TAKWXmAToSkeVEvAIKF/t4hJwcDq3DIfY+kDq0FY0QJj/D1RI6snISvNLjTrUT2A0VmMaHGF2kZ4OU9kyystojWkO3f15N+us2mat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL30c8PQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so5197015a91.1;
        Wed, 23 Oct 2024 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729675758; x=1730280558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7qoBhi0xE/U5iDBqGE6j6rllERkT9TsqQw7ivuvrcg=;
        b=QL30c8PQwFVINX7CJ6KDsVMQm90OlTWtEOtpZipUfzayjMXV0SUcdAJM4OMQee52co
         a7OPGj0FEvcQQBKAyuh0TrzZ+mZtTg2D5mojb94wslrmIZ2k5AyCrsgAZO0pqMqEo+tO
         PoUok2YNgLN+Eht+d1fFyjeOkTSzUYtSzgb9nK+KgED+DZjEuUpQ8pd4uGVF8KfKWk0i
         DA7AgTTObi8iCaCFMtd74FbTYCFjCKy42YkXsmwAnO6T6dmJW5gB/kHawWwjanzFkDcD
         SqPgOPza1RymYNs1D+PujVU0pjkASsFdUSsLiUMZEzSKCk8KP2qK83c6zjSWFCQ/J69L
         CtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675758; x=1730280558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7qoBhi0xE/U5iDBqGE6j6rllERkT9TsqQw7ivuvrcg=;
        b=OJn1SE+bu5PLFOJmWd0+3alGJjWrDBjkhrlLdZBH7sBpWMA7f2SRc5k3sGE0gcwz+I
         jCc4U8wx/OjhcWP3MDuvxNOP9/CSdVMz7mQaqzXS919ZnsYUF93WL1v3RflYsT3qVtrX
         TSsdo9wXzhhWZIa0Yyvj5yMuWp/BYUmhY2wuPLe3a7iq2HF9t5NXuFTGLTUs35jUY9q/
         YPkRMwfwOBKUsoc6cefxMATxFAuoiZTWtdk3Rg+NgkMGoxgw5Xix+s9qt09RXq2ujeyE
         m8XSIzMVynu8KiXjs3GPSG4tb8NkyJOuUxJRtAOpQBmnalSAG4p6qF19nT/91UiJMEMV
         6y3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8lZayaHbTpYiMGPVoAwNOWjii3OfDISkhLZ642Tb3b93P0O8LTCCmtm4YVSveZikJ11PDhsPx+hG8@vger.kernel.org, AJvYcCUUl2dUgvKoWUTB5YPsWtNPHTxXogFy7+4uMbJkznqFG8AOKN515S6QHOkLFJR3lJzXZmT8k5n5xiyli+mMdX86/RQ=@vger.kernel.org, AJvYcCV2670/ze0nyiU56WOtk7rll+2A8sVFDziFoByJP6TYTcXRpIhAGlQmwhO/ovQPQ/goCnCtXTXihBu5@vger.kernel.org, AJvYcCVDEftggW2uclciuuuyheABYwCHwHEiAY/E64rdKjdznHZdi2Z3DuXCFMWtStIQ8VoAxwCXrKmL6DPnQQ==@vger.kernel.org, AJvYcCVF2U8u6319riJ31EInfFSK0YQUKRabqorrLqQqVp5xeQ7+F1EXe0CAeUQqjRN/wGuTCeKurMoEx+Epug==@vger.kernel.org, AJvYcCVlTq5mV08J/skfYf3wrHX6LSzXrlN4XQi703NiSPp/KttjLFgFa9A9l4Diqr+kcnA+Nl1hTu8jbqQbfA8=@vger.kernel.org, AJvYcCVo5PjY2E+z4pzxw0WpluDS8JyOkUV+zQyNb+E1vrf9EM39YE0diiqJIrQCTbZXDegFAG7MRTgWYL8=@vger.kernel.org, AJvYcCWEdBwIT5yA4V5ik0Ht/6zf30CL3anVDvdNBjdKq760Hn9udN0oyucE0GwBifVEikQ9jGqDvHLCCHafyw==@vger.kernel.org, AJvYcCWfPx1ixTY7VPATrxg9uAikfoRlhjg3zOmNeKBXIG859F9AqUZu2V7m8slGwByJBwM7jrOh4DOl@vger.kernel.org, AJvYcCWuS7EHBOgwJlQeIfk9xPsM
 mmPyUH8iVW7Mrrdj7ZRBm9hq+fgF9blbWYJ78IfDiUEaWzNLxq9js9A0KX0=@vger.kernel.org, AJvYcCXD51QTVLx7Jdea2hdnpuBWuElRH5a3MJyOHyIVpdV5P392Bt658wm1YwVEYnH+YUaVoEv2Uxg9yXkz@vger.kernel.org, AJvYcCXETkiiiPS27D2E4C7ArjzgL3F2kXjpDuC3bi89mnsQsASJBo0EB6CGow6e3dIhb70bvepLecvnhTgykd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfb8LNk9dOEuLd5tYQsns+PRC3AK85W11FunADNwZDFL4L1AhV
	6c7K2K/B7D8qsTfSqfGkKVK49W8JYFXt22bXbf7pMA5Sl2RiHARBG1ZRXB8fos+0pkI1wRNrjmr
	TZ+IAeQcf0KDbUPQcFfD/UZ1865g=
X-Google-Smtp-Source: AGHT+IHTd7yTl2EhXEWGqXqQrO3RSi9nHq00JaRKQqBVePw8lv9s1qMh0E1idO3lwTwI8NX8Zju/frALMtTdjUoQ/VI=
X-Received: by 2002:a17:90b:274e:b0:2e2:e8a9:a1f with SMTP id
 98e67ed59e1d1-2e76b5dd9e3mr2083690a91.13.1729675757485; Wed, 23 Oct 2024
 02:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
In-Reply-To: <20241023080935.2945-2-kexybiscuit@aosc.io>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Wed, 23 Oct 2024 17:28:40 +0800
Message-ID: <CAMDZJNX6qPiXeaWfb-Yx6HFmX6qWmZjb=FKsz85R-axz40YzyQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Kexy Biscuit <kexybiscuit@aosc.io>
Cc: jeffbai@aosc.io, gregkh@linuxfoundation.org, wangyuli@uniontech.com, 
	torvalds@linux-foundation.org, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:19=E2=80=AFPM Kexy Biscuit <kexybiscuit@aosc.io> =
wrote:
>
> This reverts commit 6e90b675cf942e50c70e8394dfb5862975c3b3b2.
>
> An absolutely no-one-ever-reviewed patch, not even by the maintainers who
> got removed themselves - at least not on the mailing list. Then the patch
> just got slipped into an unrelated subsystem pull request, and got pulled
> by Torvalds with not even a comment.
>
> What about the next time? Who next would be removed from the MAINTAINERS
> file, the kernel.org infrastructure? What if the compliance requires
> another XZ backdoor to be developed without further explanation? Is the
> kernel development process still done in public?
>
> Are the "compliance requirements" documented on docs.kernel.org? Who are
> responsible for them? Are all that are responsible employees of
> The Linux Foundation, which is regulated by the U.S. legislature?
>
> Fixes: 6e90b675cf94 ("MAINTAINERS: Remove some entries due to various com=
pliance requirements.")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
Acked-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
> Please keep all discussions on at least one of the mailing lists.
>
>  MAINTAINERS | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3..501aa5c0887e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -258,6 +258,12 @@ L: linux-acenic@sunsite.dk
>  S:     Maintained
>  F:     drivers/net/ethernet/alteon/acenic*
>
> +ACER ASPIRE 1 EMBEDDED CONTROLLER DRIVER
> +M:     Nikita Travkin <nikita@trvn.ru>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
> +F:     drivers/platform/arm64/acer-aspire1-ec.c
> +
>  ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER
>  M:     Peter Kaestle <peter@piie.net>
>  L:     platform-driver-x86@vger.kernel.org
> @@ -882,6 +888,7 @@ F:  drivers/staging/media/sunxi/cedrus/
>
>  ALPHA PORT
>  M:     Richard Henderson <richard.henderson@linaro.org>
> +M:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>  M:     Matt Turner <mattst88@gmail.com>
>  L:     linux-alpha@vger.kernel.org
>  S:     Odd Fixes
> @@ -2256,6 +2263,12 @@ L:       linux-arm-kernel@lists.infradead.org (mod=
erated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm/mach-ep93xx/ts72xx.c
>
> +ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
> +M:     Alexander Shiyan <shc_work@mail.ru>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> +S:     Odd Fixes
> +N:     clps711x
> +
>  ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
>  M:     Hartley Sweeten <hsweeten@visionengravers.com>
>  M:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
> @@ -3802,6 +3815,14 @@ F:       drivers/video/backlight/
>  F:     include/linux/backlight.h
>  F:     include/linux/pwm_backlight.h
>
> +BAIKAL-T1 PVT HARDWARE MONITOR DRIVER
> +M:     Serge Semin <fancer.lancer@gmail.com>
> +L:     linux-hwmon@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/hwmon/baikal,bt1-pvt.yaml
> +F:     Documentation/hwmon/bt1-pvt.rst
> +F:     drivers/hwmon/bt1-pvt.[ch]
> +
>  BARCO P50 GPIO DRIVER
>  M:     Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
>  M:     Peter Korsgaard <peter.korsgaard@barco.com>
> @@ -6455,6 +6476,7 @@ F:        drivers/mtd/nand/raw/denali*
>
>  DESIGNWARE EDMA CORE IP DRIVER
>  M:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +R:     Serge Semin <fancer.lancer@gmail.com>
>  L:     dmaengine@vger.kernel.org
>  S:     Maintained
>  F:     drivers/dma/dw-edma/
> @@ -9737,6 +9759,14 @@ F:       drivers/gpio/gpiolib-cdev.c
>  F:     include/uapi/linux/gpio.h
>  F:     tools/gpio/
>
> +GRE DEMULTIPLEXER DRIVER
> +M:     Dmitry Kozlov <xeb@mail.ru>
> +L:     netdev@vger.kernel.org
> +S:     Maintained
> +F:     include/net/gre.h
> +F:     net/ipv4/gre_demux.c
> +F:     net/ipv4/gre_offload.c
> +
>  GRETH 10/100/1G Ethernet MAC device driver
>  M:     Andreas Larsson <andreas@gaisler.com>
>  L:     netdev@vger.kernel.org
> @@ -12929,6 +12959,12 @@ S:     Maintained
>  F:     drivers/ata/pata_arasan_cf.c
>  F:     include/linux/pata_arasan_cf_data.h
>
> +LIBATA PATA DRIVERS
> +R:     Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:     linux-ide@vger.kernel.org
> +F:     drivers/ata/ata_*.c
> +F:     drivers/ata/pata_*.c
> +
>  LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
>  M:     Linus Walleij <linus.walleij@linaro.org>
>  L:     linux-ide@vger.kernel.org
> @@ -12945,6 +12981,15 @@ F:     drivers/ata/ahci_platform.c
>  F:     drivers/ata/libahci_platform.c
>  F:     include/linux/ahci_platform.h
>
> +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> +M:     Serge Semin <fancer.lancer@gmail.com>
> +L:     linux-ide@vger.kernel.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.=
git
> +F:     Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> +F:     Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +F:     drivers/ata/ahci_dwc.c
> +
>  LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
>  M:     Mikael Pettersson <mikpelinux@gmail.com>
>  L:     linux-ide@vger.kernel.org
> @@ -14140,6 +14185,16 @@ S:     Maintained
>  T:     git git://linuxtv.org/media_tree.git
>  F:     drivers/media/platform/nxp/imx-pxp.[ch]
>
> +MEDIA DRIVERS FOR ASCOT2E
> +M:     Sergey Kozlov <serjk@netup.ru>
> +M:     Abylay Ospan <aospan@netup.ru>
> +L:     linux-media@vger.kernel.org
> +S:     Supported
> +W:     https://linuxtv.org
> +W:     http://netup.tv/
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/dvb-frontends/ascot2e*
> +
>  MEDIA DRIVERS FOR CXD2099AR CI CONTROLLERS
>  M:     Jasmin Jessich <jasmin@anw.at>
>  L:     linux-media@vger.kernel.org
> @@ -14148,6 +14203,16 @@ W:     https://linuxtv.org
>  T:     git git://linuxtv.org/media_tree.git
>  F:     drivers/media/dvb-frontends/cxd2099*
>
> +MEDIA DRIVERS FOR CXD2841ER
> +M:     Sergey Kozlov <serjk@netup.ru>
> +M:     Abylay Ospan <aospan@netup.ru>
> +L:     linux-media@vger.kernel.org
> +S:     Supported
> +W:     https://linuxtv.org
> +W:     http://netup.tv/
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/dvb-frontends/cxd2841er*
> +
>  MEDIA DRIVERS FOR CXD2880
>  M:     Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
>  L:     linux-media@vger.kernel.org
> @@ -14192,6 +14257,35 @@ F:     drivers/media/platform/nxp/imx-mipi-csis.=
c
>  F:     drivers/media/platform/nxp/imx7-media-csi.c
>  F:     drivers/media/platform/nxp/imx8mq-mipi-csi2.c
>
> +MEDIA DRIVERS FOR HELENE
> +M:     Abylay Ospan <aospan@netup.ru>
> +L:     linux-media@vger.kernel.org
> +S:     Supported
> +W:     https://linuxtv.org
> +W:     http://netup.tv/
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/dvb-frontends/helene*
> +
> +MEDIA DRIVERS FOR HORUS3A
> +M:     Sergey Kozlov <serjk@netup.ru>
> +M:     Abylay Ospan <aospan@netup.ru>
> +L:     linux-media@vger.kernel.org
> +S:     Supported
> +W:     https://linuxtv.org
> +W:     http://netup.tv/
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/dvb-frontends/horus3a*
> +
> +MEDIA DRIVERS FOR LNBH25
> +M:     Sergey Kozlov <serjk@netup.ru>
> +M:     Abylay Ospan <aospan@netup.ru>
> +L:     linux-media@vger.kernel.org
> +S:     Supported
> +W:     https://linuxtv.org
> +W:     http://netup.tv/
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/dvb-frontends/lnbh25*
> +
>  MEDIA DRIVERS FOR MXL5XX TUNER DEMODULATORS
>  L:     linux-media@vger.kernel.org
>  S:     Orphan
> @@ -14199,6 +14293,16 @@ W:     https://linuxtv.org
>  T:     git git://linuxtv.org/media_tree.git
>  F:     drivers/media/dvb-frontends/mxl5xx*
>
> +MEDIA DRIVERS FOR NETUP PCI UNIVERSAL DVB devices
> +M:     Sergey Kozlov <serjk@netup.ru>
> +M:     Abylay Ospan <aospan@netup.ru>
> +L:     linux-media@vger.kernel.org
> +S:     Supported
> +W:     https://linuxtv.org
> +W:     http://netup.tv/
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/pci/netup_unidvb/*
> +
>  MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
>  M:     Dmitry Osipenko <digetx@gmail.com>
>  L:     linux-media@vger.kernel.org
> @@ -14842,6 +14946,13 @@ F:     drivers/mtd/
>  F:     include/linux/mtd/
>  F:     include/uapi/mtd/
>
> +MEMSENSING MICROSYSTEMS MSA311 DRIVER
> +M:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yam=
l
> +F:     drivers/iio/accel/msa311.c
> +
>  MEN A21 WATCHDOG DRIVER
>  M:     Johannes Thumshirn <morbidrsa@gmail.com>
>  L:     linux-watchdog@vger.kernel.org
> @@ -15175,6 +15286,7 @@ F:      drivers/tty/serial/8250/8250_pci1xxxx.c
>
>  MICROCHIP POLARFIRE FPGA DRIVERS
>  M:     Conor Dooley <conor.dooley@microchip.com>
> +R:     Vladimir Georgiev <v.georgiev@metrotek.ru>
>  L:     linux-fpga@vger.kernel.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr=
.yaml
> @@ -15429,6 +15541,17 @@ F:     arch/mips/
>  F:     drivers/platform/mips/
>  F:     include/dt-bindings/mips/
>
> +MIPS BAIKAL-T1 PLATFORM
> +M:     Serge Semin <fancer.lancer@gmail.com>
> +L:     linux-mips@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
> +F:     Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml
> +F:     drivers/bus/bt1-*.c
> +F:     drivers/clk/baikal-t1/
> +F:     drivers/memory/bt1-l2-ctl.c
> +F:     drivers/mtd/maps/physmap-bt1-rom.[ch]
> +
>  MIPS BOSTON DEVELOPMENT BOARD
>  M:     Paul Burton <paulburton@kernel.org>
>  L:     linux-mips@vger.kernel.org
> @@ -15441,6 +15564,7 @@ F:      include/dt-bindings/clock/boston-clock.h
>
>  MIPS CORE DRIVERS
>  M:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> +M:     Serge Semin <fancer.lancer@gmail.com>
>  L:     linux-mips@vger.kernel.org
>  S:     Supported
>  F:     drivers/bus/mips_cdmm.c
> @@ -16408,6 +16532,12 @@ F:     include/linux/ntb.h
>  F:     include/linux/ntb_transport.h
>  F:     tools/testing/selftests/ntb/
>
> +NTB IDT DRIVER
> +M:     Serge Semin <fancer.lancer@gmail.com>
> +L:     ntb@lists.linux.dev
> +S:     Supported
> +F:     drivers/ntb/hw/idt/
> +
>  NTB INTEL DRIVER
>  M:     Dave Jiang <dave.jiang@intel.com>
>  L:     ntb@lists.linux.dev
> @@ -18428,6 +18558,13 @@ F:     drivers/pps/
>  F:     include/linux/pps*.h
>  F:     include/uapi/linux/pps.h
>
> +PPTP DRIVER
> +M:     Dmitry Kozlov <xeb@mail.ru>
> +L:     netdev@vger.kernel.org
> +S:     Maintained
> +W:     http://sourceforge.net/projects/accel-pptp
> +F:     drivers/net/ppp/pptp.c
> +
>  PRESSURE STALL INFORMATION (PSI)
>  M:     Johannes Weiner <hannes@cmpxchg.org>
>  M:     Suren Baghdasaryan <surenb@google.com>
> @@ -19518,6 +19655,15 @@ S:     Supported
>  F:     Documentation/devicetree/bindings/i2c/renesas,iic-emev2.yaml
>  F:     drivers/i2c/busses/i2c-emev2.c
>
> +RENESAS ETHERNET AVB DRIVER
> +R:     Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:     netdev@vger.kernel.org
> +L:     linux-renesas-soc@vger.kernel.org
> +F:     Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> +F:     drivers/net/ethernet/renesas/Kconfig
> +F:     drivers/net/ethernet/renesas/Makefile
> +F:     drivers/net/ethernet/renesas/ravb*
> +
>  RENESAS ETHERNET SWITCH DRIVER
>  R:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>  L:     netdev@vger.kernel.org
> @@ -19567,6 +19713,14 @@ F:     Documentation/devicetree/bindings/i2c/ren=
esas,rmobile-iic.yaml
>  F:     drivers/i2c/busses/i2c-rcar.c
>  F:     drivers/i2c/busses/i2c-sh_mobile.c
>
> +RENESAS R-CAR SATA DRIVER
> +R:     Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:     linux-ide@vger.kernel.org
> +L:     linux-renesas-soc@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +F:     drivers/ata/sata_rcar.c
> +
>  RENESAS R-CAR THERMAL DRIVERS
>  M:     Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>
>  L:     linux-renesas-soc@vger.kernel.org
> @@ -19642,6 +19796,16 @@ S:     Supported
>  F:     Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
>  F:     drivers/i2c/busses/i2c-rzv2m.c
>
> +RENESAS SUPERH ETHERNET DRIVER
> +R:     Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:     netdev@vger.kernel.org
> +L:     linux-renesas-soc@vger.kernel.org
> +F:     Documentation/devicetree/bindings/net/renesas,ether.yaml
> +F:     drivers/net/ethernet/renesas/Kconfig
> +F:     drivers/net/ethernet/renesas/Makefile
> +F:     drivers/net/ethernet/renesas/sh_eth*
> +F:     include/linux/sh_eth.h
> +
>  RENESAS USB PHY DRIVER
>  M:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>  L:     linux-renesas-soc@vger.kernel.org
> @@ -22295,11 +22459,19 @@ F:    drivers/tty/serial/8250/8250_lpss.c
>
>  SYNOPSYS DESIGNWARE APB GPIO DRIVER
>  M:     Hoan Tran <hoan@os.amperecomputing.com>
> +M:     Serge Semin <fancer.lancer@gmail.com>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
>  F:     drivers/gpio/gpio-dwapb.c
>
> +SYNOPSYS DESIGNWARE APB SSI DRIVER
> +M:     Serge Semin <fancer.lancer@gmail.com>
> +L:     linux-spi@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +F:     drivers/spi/spi-dw*
> +
>  SYNOPSYS DESIGNWARE AXI DMAC DRIVER
>  M:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>  S:     Maintained
> @@ -23609,6 +23781,12 @@ L:     linux-input@vger.kernel.org
>  S:     Maintained
>  F:     drivers/hid/hid-udraw-ps3.c
>
> +UFS FILESYSTEM
> +M:     Evgeniy Dushistov <dushistov@mail.ru>
> +S:     Maintained
> +F:     Documentation/admin-guide/ufs.rst
> +F:     fs/ufs/
> +
>  UHID USERSPACE HID IO DRIVER
>  M:     David Rheinsberg <david@readahead.eu>
>  L:     linux-input@vger.kernel.org
> --
> 2.47.0
>
>


--=20
Best regards, Tonghao

