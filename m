Return-Path: <dmaengine+bounces-2692-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB4930E30
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 08:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E4B20D28
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6F1581E0;
	Mon, 15 Jul 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grH9VhVE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789013A89C;
	Mon, 15 Jul 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025564; cv=none; b=DJ5VIH6Wg/2V6m4rOwyyaVDPSDpuCa1g9UGpXfAm3hKf0TnfVr6hGWTey4srdHZZcRBtL+y1OzltkT3asTAqj1k+jxY6iylJjIa/hhli7p9+8Zgt262ZAONrflSk1QtbZm0ViMXr+JY1TiIzn7FVHWutZSiH4NxFQ/b7n1DrgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025564; c=relaxed/simple;
	bh=ue63PD+WH1lgrlPIZa8Y+VSW6ci4bkPtwOr0znH5a1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogkVc5g9FDVbgTCAsdBCf+MSh95zIVdA80gZAe3ERqex/2fODuvnWBY2aaPAmbMioVZH00nRhwEKLd8RmcpVwCDy2RTa8ZMQtNO7sJ25b9N24foft86GEenRWS/uO6dprBc3Ol/XnJi6QnExrvNe2DdfaTjtdOG4pLkRTAU7Uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grH9VhVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE17C4AF0F;
	Mon, 15 Jul 2024 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721025563;
	bh=ue63PD+WH1lgrlPIZa8Y+VSW6ci4bkPtwOr0znH5a1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=grH9VhVER5hrr8fRYCZnWSIpyKuyTe+5J5UcDUFHtd4gf1jOpsHvqDP8HV3B/8pWZ
	 c/g7SEDgEFWj2KkflFfT+19mCRVWt0OZ4lbqmuAfZj0gaoPuPW8Fxp2PraXh4y2wwy
	 cv1HO0XVw/vwkTGHYuJlU2m+DO0nGUORL0EVT4hknl7DwX+h0AnjYSr9djRACCBvtF
	 b2iz0s5YUJcJYW+/RcCwG7wpipAuQ6Lmm+k+o1qoNA/pl2zkAB11g4IXmTK0uuoyrc
	 E1VsiQmozrPrMjLw1r9QiYKf5XxsFaUCe45qDm1cGv9J/CGbSjDNlNv5MfKXt+M1KD
	 sYchGa6RVi+Pg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7979c3ffb1so232033666b.2;
        Sun, 14 Jul 2024 23:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSn1OjLxdaBLcEl82hApysSbKM1dAPPm28SOhP1v6b1FIj8iic8z2oO71GouXZVBH1kQbySbFToHUJ4BPCakhKTL42mD84JpAneFcit1fwke7YwSeCTM+vfAzllMBtc51fARZs7fPhiTsgv/H7sdulzrfVfFQ2r+TKiC4QuO+LLccfl2huD2gPNFQGObK0Y9SsAwNyW0LNvQTX7tD0LwU=
X-Gm-Message-State: AOJu0Yyp69yBNEQNdcMnbeZI+nndarfeyPZW93Jy6HQdkIT1s40W0VKT
	aDBqujV3CVXqqTFlaurK2ImSnYrdT+bGXoA+OPT6h8DcmzwHXydFtpyDuIchFZZAGN2ujYvN5bz
	90tBOkyIEo14VKdPD40zKvobxHZU=
X-Google-Smtp-Source: AGHT+IH2afvBMorpe8R4SLEsYoeUFbK9UHI5/G4ctIqHVHC1u91eh0R/gjYIBZbJ9cXDaFCVPedBryinNyCj8beDIjk=
X-Received: by 2002:a05:6402:2684:b0:58b:b617:eee6 with SMTP id
 4fb4d7f45d1cf-594bcba83e2mr17226269a12.36.1721025561941; Sun, 14 Jul 2024
 23:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com> <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
In-Reply-To: <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jul 2024 14:39:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
Message-ID: <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 2:23=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail.=
com> wrote:
>
> On Fri, Jul 12, 2024 at 12:22=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > Hi, Keguang,
> >
> > I accept your suggestion about the cpufreq driver naming, and now it
> > is upstream:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?=
h=3Dcpufreq/arm/linux-next&id=3Dccf51454145bffd98e31cdbe54a4262473c609e2
> >
> > I still hope you can accept my suggestion about the dma driver naming.
> >
> > I know you hope me rename LS2X_APB_DMA to LOONGSON2_APB_DMA, but as I
> > said before, renaming an existing Kconfig option will break config
> > files.
> >
> > See an example:
> > Commit a50a3f4b6a313dc76912bd4ad3b8b4f4b4 introduce PREEMPT_RT and
> > rename PREEMPT to PREEMPT_LL, but then commit
> > b8d3349803ba34afda429e87a837fd95a9 rename it back because of config
> > files broken.
> >
> Hi Huacai,
> I understand the breaking issue of the Kconfig option, so you can keep
> LS2X_APB_DMA.
LS2X_APB_DMA with loongson2-apb-dma.c? Even if I accept this, can you
accept LS1X_APB_DMA with loongson1-apb-dma.c?

> You said that you've accepted my suggestion, which means you recognize
> 'loongson' as the better name for the drivers.
No, I don't think so, this is just a compromise to keep consistency.



Huacai

> Moreover, Loongson1 and Loongson2 belong to different SoC series.
> To be honest, I can't see why Loongson1 APB DMA should give up this
> intuitive and comprehensible naming.
> Thanks for your review!
> >
> > Huacai
> >
> > On Thu, Jul 11, 2024 at 6:57=E2=80=AFPM Keguang Zhang via B4 Relay
> > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > >
> > > Add the driver and dt-binding document for Loongson1 APB DMA.
> > >
> > > ---
> > > Changes in v9:
> > > - Fix all the errors and warnings when building with W=3D1 and C=3D1
> > > - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-0-f=
9992d257250@gmail.com
> > >
> > > Changes in v8:
> > > - Change 'interrupts' property to an items list
> > > - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0-3=
7db58608de5@gmail.com
> > >
> > > Changes in v7:
> > > - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai=
 Chen)
> > > - Update the title and description part accordingly
> > > - Rename the file to loongson,ls1b-apbdma.yaml
> > > - Add a compatible string for LS1A
> > > - Delete minItems of 'interrupts'
> > > - Change patterns of 'interrupt-names' to const
> > > - Rename the file to loongson1-apb-dma.c to keep the consistency
> > > - Update Kconfig and Makefile accordingly
> > > - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-9=
0de2c3cc928@gmail.com
> > >
> > > Changes in v6:
> > > - Change the compatible to the fallback
> > > - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> > > - as well as .device_pause and .device_resume.
> > > - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> > > - into one page to save memory
> > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > > - Drop dma_slave_config structure
> > > - Use .remove_new instead of .remove
> > > - Use KBUILD_MODNAME for the driver name
> > > - Improve the debug information
> > > - Some minor fixes
> > >
> > > Changes in v5:
> > > - Add the dt-binding document
> > > - Add DT support
> > > - Use DT information instead of platform data
> > > - Use chan_id of struct dma_chan instead of own id
> > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> > > - Update the author information to my official name
> > >
> > > Changes in v4:
> > > - Use dma_slave_map to find the proper channel.
> > > - Explicitly call devm_request_irq() and tasklet_kill().
> > > - Fix namespace issue.
> > > - Some minor fixes and cleanups.
> > >
> > > Changes in v3:
> > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > >
> > > Changes in v2:
> > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> > > - and rearrange it in alphabetical order in Kconfig and Makefile.
> > > - Fix comment style.
> > >
> > > ---
> > > Keguang Zhang (2):
> > >       dt-bindings: dma: Add Loongson-1 APB DMA
> > >       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
> > >
> > >  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
> > >  drivers/dma/Kconfig                                |   9 +
> > >  drivers/dma/Makefile                               |   1 +
> > >  drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++=
++++++++++
> > >  4 files changed, 742 insertions(+)
> > > ---
> > > base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> > > change-id: 20231120-loongson1-dma-163afe5708b9
> > >
> > > Best regards,
> > > --
> > > Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > >
> > >
>
>
>
> --
> Best regards,
>
> Keguang Zhang

