Return-Path: <dmaengine+bounces-2693-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F8930E5C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 08:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15EE1C21014
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BC1836CE;
	Mon, 15 Jul 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkyGCI3p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5C4C62;
	Mon, 15 Jul 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721026595; cv=none; b=WK1vyuMmg/jkRgvObN46gdUNfwgG0fanrAULkrgGZNtt+sslTLcPH8yt/0wFZHvIelFv8EbxWwD8wF56iZpE4dD+H2k2MSxTwLx0vRbbGbFTMZutt3Q8XtLzIcNIqaQAz5zriZECFb0ttEkwXzqpnra+0xXZdyQFDjle3Zqvb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721026595; c=relaxed/simple;
	bh=sj24mXfJxNAsK3V4XNrptTDcHLVycvhu2EJaDJ53lmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1azyRSwbqyz/I+5y1HUexi8Yma8UoV6ma9Day9BQaXRmZDP6L3ZhGjqXn7cZaaf8F9vGwbrD18NH132O2sX/itxZaKBWWYGCJs29GlfVI2FXKD1p8qceCLVPxgvoSZ+N9xiTIsX2EWvNrvkIksi/djYyIuApzNkzgZTd73/75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkyGCI3p; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so4518508a12.2;
        Sun, 14 Jul 2024 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721026592; x=1721631392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7PFoNkNgHba/pyzFfUVpppEO6+SdTsOVULW6GmYfnA=;
        b=mkyGCI3p/4EglSX0IzmE/AupXd6QeyWBZIsjNRQ5Yuoa2pJzryUJxKBDyOAPtaPXRT
         nE8xXYp92eobK8Nd1gELNhPAh/cp5ftpcapO14+5jTd8XvRBlIqC8DTEM4spd+lWeetj
         0QezGadzAmp+5ZdJLTOFwJekxAA9s5aatwqLUmXMcFTcvMqUT5jriYY6s7JY4aeq1Jly
         EaUVeC3xkZF44csVeJ3ueGM42n0uoehwCzV8I3+GbEyCx8ZXEwzrpYA6wfHP/LkKap4T
         0C0n5P9yXKMLFaxelGdUf8lKm7iNeKwvh24M6ABbyLXJzEunIe/AVXtMIebx1vdXxsmj
         5Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721026592; x=1721631392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7PFoNkNgHba/pyzFfUVpppEO6+SdTsOVULW6GmYfnA=;
        b=TKDvlSVLXkPoIGFXTmlogcIMjjdhH7Ztds4UdyCCir1o9iSJmiajlKQMOIlkwdBJpc
         rbu7dVMB5VGmwDjG3s0Gb0oFPeLsLAuwIy+Crpsgl9mD4IpBkC5m0p1FXo2qWG1bre5h
         eaUNPL6cuu9Vqqh9xJJQoJQ8iGIwk7nuzcM9panL1lPu0gV58aP+bHxdjYuzwZ8D2rgj
         Htca7pZeGMmQrQZMCExjeVWQSP1C3xD7WY/q68le6AfHb9rVk+XsfOCD6nLG1tTSiG9S
         gUDVP+sWEXtELjo1CLzvO4F/WywC+qL/NzlL1lOsKetdrKhSwsxV6syY4aLvPitSkoaK
         OUSA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbWqcpq68uqVHjf2YEQmmZ8WOaDkZ1V9aEimESVh83pHkXXmYK+7cjul5Bdmdus1KnDAegsNTsJUHIbRC/hZBlKLvsRjxTkRNdwRUGlZw5/gAAD2D6x6Xr2VdF/7FHrTRGd3EKtoNpiWWJe4Os5HRA287EI14CJnHqp9Svs9/iHCKShfyCRqqKKAGxiKFlyPp9ckIpn32nVV74FmjKPU=
X-Gm-Message-State: AOJu0Yzf4gH7tsBQmjBgpcY0tqMZnaiDxFTeL/Os7JOEhqXSHBKdatgL
	5xzQwFkcKi/2E6LBX/lRhYVza9O5GHFGEv5nRQAo0Etmd11wtsyBC1oYSk/UK59yGeG+k3AUDU7
	zG1wKG6OzzXFJMhhPk/ZvvyhLTTyqJoQpO8oJBQ==
X-Google-Smtp-Source: AGHT+IE/BykdZ10MgUqF+I0qU267xPcxK+nONoB7eARDPhS1gbhZuxZoGkHNTiWSiz7YAX5Vhmreez3DamRub9nkIqo=
X-Received: by 2002:a05:6402:1c87:b0:58b:7413:db00 with SMTP id
 4fb4d7f45d1cf-594bbe2b9e5mr11631791a12.37.1721026591858; Sun, 14 Jul 2024
 23:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
 <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com> <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 15 Jul 2024 14:55:55 +0800
Message-ID: <CAJhJPsUmG7nRycKzbiPKMJfgN-0ZdDH3mV3k8prizunD2G0HiQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:39=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Fri, Jul 12, 2024 at 2:23=E2=80=AFPM Keguang Zhang <keguang.zhang@gmai=
l.com> wrote:
> >
> > On Fri, Jul 12, 2024 at 12:22=E2=80=AFPM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> > >
> > > Hi, Keguang,
> > >
> > > I accept your suggestion about the cpufreq driver naming, and now it
> > > is upstream:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit=
/?h=3Dcpufreq/arm/linux-next&id=3Dccf51454145bffd98e31cdbe54a4262473c609e2
> > >
> > > I still hope you can accept my suggestion about the dma driver naming=
.
> > >
> > > I know you hope me rename LS2X_APB_DMA to LOONGSON2_APB_DMA, but as I
> > > said before, renaming an existing Kconfig option will break config
> > > files.
> > >
> > > See an example:
> > > Commit a50a3f4b6a313dc76912bd4ad3b8b4f4b4 introduce PREEMPT_RT and
> > > rename PREEMPT to PREEMPT_LL, but then commit
> > > b8d3349803ba34afda429e87a837fd95a9 rename it back because of config
> > > files broken.
> > >
> > Hi Huacai,
> > I understand the breaking issue of the Kconfig option, so you can keep
> > LS2X_APB_DMA.
> LS2X_APB_DMA with loongson2-apb-dma.c? Even if I accept this, can you
> accept LS1X_APB_DMA with loongson1-apb-dma.c?
>
> > You said that you've accepted my suggestion, which means you recognize
> > 'loongson' as the better name for the drivers.
> No, I don't think so, this is just a compromise to keep consistency.
>
Sorry. The naming 'Loongson1' is the real consistency that I need to mainta=
in.
Thanks!
>
>
> Huacai
>
> > Moreover, Loongson1 and Loongson2 belong to different SoC series.
> > To be honest, I can't see why Loongson1 APB DMA should give up this
> > intuitive and comprehensible naming.
> > Thanks for your review!
> > >
> > > Huacai
> > >
> > > On Thu, Jul 11, 2024 at 6:57=E2=80=AFPM Keguang Zhang via B4 Relay
> > > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > > >
> > > > Add the driver and dt-binding document for Loongson1 APB DMA.
> > > >
> > > > ---
> > > > Changes in v9:
> > > > - Fix all the errors and warnings when building with W=3D1 and C=3D=
1
> > > > - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-0=
-f9992d257250@gmail.com
> > > >
> > > > Changes in v8:
> > > > - Change 'interrupts' property to an items list
> > > > - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0=
-37db58608de5@gmail.com
> > > >
> > > > Changes in v7:
> > > > - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huac=
ai Chen)
> > > > - Update the title and description part accordingly
> > > > - Rename the file to loongson,ls1b-apbdma.yaml
> > > > - Add a compatible string for LS1A
> > > > - Delete minItems of 'interrupts'
> > > > - Change patterns of 'interrupt-names' to const
> > > > - Rename the file to loongson1-apb-dma.c to keep the consistency
> > > > - Update Kconfig and Makefile accordingly
> > > > - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0=
-90de2c3cc928@gmail.com
> > > >
> > > > Changes in v6:
> > > > - Change the compatible to the fallback
> > > > - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> > > > - as well as .device_pause and .device_resume.
> > > > - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> > > > - into one page to save memory
> > > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > > > - Drop dma_slave_config structure
> > > > - Use .remove_new instead of .remove
> > > > - Use KBUILD_MODNAME for the driver name
> > > > - Improve the debug information
> > > > - Some minor fixes
> > > >
> > > > Changes in v5:
> > > > - Add the dt-binding document
> > > > - Add DT support
> > > > - Use DT information instead of platform data
> > > > - Use chan_id of struct dma_chan instead of own id
> > > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> > > > - Update the author information to my official name
> > > >
> > > > Changes in v4:
> > > > - Use dma_slave_map to find the proper channel.
> > > > - Explicitly call devm_request_irq() and tasklet_kill().
> > > > - Fix namespace issue.
> > > > - Some minor fixes and cleanups.
> > > >
> > > > Changes in v3:
> > > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > > >
> > > > Changes in v2:
> > > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> > > > - and rearrange it in alphabetical order in Kconfig and Makefile.
> > > > - Fix comment style.
> > > >
> > > > ---
> > > > Keguang Zhang (2):
> > > >       dt-bindings: dma: Add Loongson-1 APB DMA
> > > >       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
> > > >
> > > >  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
> > > >  drivers/dma/Kconfig                                |   9 +
> > > >  drivers/dma/Makefile                               |   1 +
> > > >  drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++=
++++++++++++
> > > >  4 files changed, 742 insertions(+)
> > > > ---
> > > > base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> > > > change-id: 20231120-loongson1-dma-163afe5708b9
> > > >
> > > > Best regards,
> > > > --
> > > > Keguang Zhang <keguang.zhang@gmail.com>
> > > >
> > > >
> > > >
> >
> >
> >
> > --
> > Best regards,
> >
> > Keguang Zhang



--=20
Best regards,

Keguang Zhang

