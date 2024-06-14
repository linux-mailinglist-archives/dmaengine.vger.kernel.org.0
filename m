Return-Path: <dmaengine+bounces-2365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328390816D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 04:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E5F1F21772
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 02:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1263158D83;
	Fri, 14 Jun 2024 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh3elEu8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59051EA6E;
	Fri, 14 Jun 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331211; cv=none; b=QjsmsQFx5DX22SA/C4MTkQnx1DFoGeGX8wVRJNvY8qb1x6yBNtJn/ylQHAwmaWWdVb4zyGG4b6oVbFc97Slk/0ZPfCbJggN7ewzW4CpIi3BBXlVHqgC6sk0L3OTvb62OdRjwzxlf5XMRWdLC67QmpZ9dUzScV4qzeE5o0sY3uR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331211; c=relaxed/simple;
	bh=R68pf7/oFWoczgGEjNVxQ34C8OE4Jgtc65QILPRtObE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPyQSL2Pz0kBZqrJlrcuD+17OdCYE8+io9liBJx8E9nSNPeP68FuXnKJt2JsK8gXJ7Ihn2q+eNvqrKdeAtPtX4IEcD9XGBVFNDpjcs0E0vXeDCdEm4NNCOx6Qq32UMepaQiVlWLGzpg+Dj7nojA7MEFhTt/k2MzYVrrGh/rUmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh3elEu8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so1709833a12.1;
        Thu, 13 Jun 2024 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718331208; x=1718936008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OoBbFOR2khXMsl5o/WhgD3a3y3rMZo2Ty9YI0rs7V0=;
        b=Zh3elEu8D/uZOcYbkR1aTkVcEBs6wBSHfiYJEg+ow9Pbs/qASAwYBO4XixiXqlRPQN
         MHXGd5xSF2R8aAWVk1u6NrNQ+WlDRlihsaqeA/HxkBs+Sk+N1/qVzMnzYUIRjbA+Dh52
         KWKVIhuooG8o+L8lmZEOUZDVzbYTbr3s6P74YDHGTrxJ8j1CJCAJgOGLdLYBtEVp4nqd
         bB2yu7qnUViBrPVhgJ9VVAmxr8+10H5wbPK9PsVXutEHL4GQVsOHinHLGAJsvh5Dnvqw
         2qZQVo5rhO66LpWftMHe+xMO6WWdzLasWFZTHR6cJ88sOLbvBHX8440UKz7XevyVqq7A
         DjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718331208; x=1718936008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OoBbFOR2khXMsl5o/WhgD3a3y3rMZo2Ty9YI0rs7V0=;
        b=HZ+PnW5IqzKd1bSH5VpzrxTVnDVQ5bZHrtXCRjJ1ZUBDIKlvT4kQt1RG8qly7NcSPQ
         Ssvla7VD2LJmHhsVVCfi4+rdQkrg+VHaHP/oaPyoZDFgX8pJoQMKBFsfmJQhSFnNeve9
         FUdfpixspxPsPU2ihIu3/Mooafk6Rhvst8hHKYVohVNEjzGTOtExQdfe3CXsuRFPZz1a
         uOy4x8eWikih8SPiKB1p7L8MGw9ANZrsx2eTfUTxjbtbINizaESdku7wSn7BSeTjOwxQ
         CgBMPc7vaiRRd+Zq2GeoxXBuJE4ukVkA8pnTjySi1sB93HU0FSgaUDKezdXgSDlh+oNe
         8Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOrzrLqp8xjkr+A3v+FBRYj/+RwQM8WRtjnJiGAU5Px5x55YLqjKJtHk83rvbuAJSvHgTfnCnrkft6gVGJRorcX9PcMLaceSinh3gp+P0/mYOfN9FhJyrj1Td0DcYubPFxGUy1d5AQUuhDtVESw8jh2XAMn/3xfj7w/Jm1EuLyMRoi2uPcjwYDbu7d7tmicPhmjPnQ+OQrQg9lo6Qmq/U=
X-Gm-Message-State: AOJu0Ywt3p5v5KitfhMzODJdw+jkCEek6JD8oN7qCWRBgxnnpI4WmEoi
	Xu4r/nVtJfLxUx7Rol3oYJuCfCSb3wzgLBIk6hgNBCR71z1dcuTY6B/OZ4kzD2hodXDqoTFsk9w
	SPWngTPVNAHeit/8LPuKqTP+izb4=
X-Google-Smtp-Source: AGHT+IGbYefqwW78K/H1m0jP5pTO8sADr7fMuc+EuriyAwW85qez09DPsSWhhSUp4GUlshiFVvEs7zQozTQd0pUMDWc=
X-Received: by 2002:aa7:d791:0:b0:57c:bf7e:f3e9 with SMTP id
 4fb4d7f45d1cf-57cbf7ef667mr321624a12.14.1718331207866; Thu, 13 Jun 2024
 19:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongson1-dma-v9-0-6181f2c7dece@gmail.com> <CAAhV-H4nZqYi4ccsmw=1fmWySVL-kjoZ+_PQU4P9YKSrWGKdDw@mail.gmail.com>
In-Reply-To: <CAAhV-H4nZqYi4ccsmw=1fmWySVL-kjoZ+_PQU4P9YKSrWGKdDw@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Fri, 14 Jun 2024 10:12:51 +0800
Message-ID: <CAJhJPsXjKdx6B8Hz81T6ic5xaXMFLDDBw4Q4VFFyjgetgn1DhQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Add support for Loongson1 APB DMA
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Huacai,

On Thu, Jun 13, 2024 at 11:11=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Keguang,
>
> On Thu, Jun 13, 2024 at 8:03=E2=80=AFPM Keguang Zhang via B4 Relay
> <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> >
> > Add the driver and dt-binding document for Loongson1 APB DMA.
> I still suggest using ls1x-apb-dma.c as the file name, for consistency
> in the same subsystem. But as I said before, I will also accept some
> of your suggestions, so I use loongson3_cpufreq.c here.
>
> https://lore.kernel.org/loongarch/20240612064205.2041548-1-chenhuacai@loo=
ngson.cn/T/#t
>
As we discussed in the previous email, =E2=80=98ls1x=E2=80=99 is not a good=
 naming
because it is too short and may be confused with other SoCs.
https://lore.kernel.org/all/CAJhJPsULnEfTMFK5HS5TQZ_0XSs77Tw58Yfvw67BtTTHvj=
SLLw@mail.gmail.com/
I insist on =E2=80=98loongson1=E2=80=99 due to the following reasons:
1. The meaning of =E2=80=98Loongson1=E2=80=99 is clear to everyone.
2. Most of the Loongson drivers use the naming 'loongson'.
3. Most of the Loongson1 drivers use the naming 'loongson1'.

My suggestion is to rename 'ls2x-apb-dma.c' to 'loongson2-apb-dma.c'.

Hi Vinod,
What's your opinion about the naming?
Thanks!

> Huacai
> >
> > ---
> > Changes in v9:
> > - Fix all the errors and warnings when building with W=3D1 and C=3D1
> > - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-0-f99=
92d257250@gmail.com
> >
> > Changes in v8:
> > - Change 'interrupts' property to an items list
> > - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0-37d=
b58608de5@gmail.com
> >
> > Changes in v7:
> > - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai C=
hen)
> > - Update the title and description part accordingly
> > - Rename the file to loongson,ls1b-apbdma.yaml
> > - Add a compatible string for LS1A
> > - Delete minItems of 'interrupts'
> > - Change patterns of 'interrupt-names' to const
> > - Rename the file to loongson1-apb-dma.c to keep the consistency
> > - Update Kconfig and Makefile accordingly
> > - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-90d=
e2c3cc928@gmail.com
> >
> > Changes in v6:
> > - Change the compatible to the fallback
> > - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> > - as well as .device_pause and .device_resume.
> > - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> > - into one page to save memory
> > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > - Drop dma_slave_config structure
> > - Use .remove_new instead of .remove
> > - Use KBUILD_MODNAME for the driver name
> > - Improve the debug information
> > - Some minor fixes
> >
> > Changes in v5:
> > - Add the dt-binding document
> > - Add DT support
> > - Use DT information instead of platform data
> > - Use chan_id of struct dma_chan instead of own id
> > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> > - Update the author information to my official name
> >
> > Changes in v4:
> > - Use dma_slave_map to find the proper channel.
> > - Explicitly call devm_request_irq() and tasklet_kill().
> > - Fix namespace issue.
> > - Some minor fixes and cleanups.
> >
> > Changes in v3:
> > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> >
> > Changes in v2:
> > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> > - and rearrange it in alphabetical order in Kconfig and Makefile.
> > - Fix comment style.
> >
> > ---
> > Keguang Zhang (2):
> >       dt-bindings: dma: Add Loongson-1 APB DMA
> >       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
> >
> >  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
> >  drivers/dma/Kconfig                                |   9 +
> >  drivers/dma/Makefile                               |   1 +
> >  drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++++=
++++++++
> >  4 files changed, 742 insertions(+)
> > ---
> > base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> > change-id: 20231120-loongson1-dma-163afe5708b9
> >
> > Best regards,
> > --
> > Keguang Zhang <keguang.zhang@gmail.com>
> >
> >
> >



--=20
Best regards,

Keguang Zhang

