Return-Path: <dmaengine+bounces-2701-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40513932302
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 11:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76DF1B20844
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC3196DA4;
	Tue, 16 Jul 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzgW2kLs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26441A8E;
	Tue, 16 Jul 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122864; cv=none; b=HKgNiGD85isM8f3L5joOwITCVJUcAZYT0dd4CLBLDIsdmp4YseQvy0YdkwqiW0lN427jPsG2sU7N52yRElT/43EC57KNLJmtNw3fInYBFlTSC2V9wH4wUcekomz2rxw7p8J7xa6cTODMQuC5IIHvOwXN/9iYkeTA7c6NHfT69OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122864; c=relaxed/simple;
	bh=5Lhv2MWbc/qpZDBmQeIkbJ4Fh5cwZsrgGq6obwgN+Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEwQ2arvYc+ZuQYdUp+I/9Ut04kGH5iNm0PjCdJeYh1ndPtw/GLhrHfRvPv7QJnLb1NfGmZLVH2juNc5uWj4qJfJGOET3TvkexOFySeonPuB0x/0jLLsvGYn/JfSKXsHz2X6JvsEdpOaqWsyyMwVdgKiQa9klZKDg2vF7sXlKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzgW2kLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EA2C4AF09;
	Tue, 16 Jul 2024 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721122863;
	bh=5Lhv2MWbc/qpZDBmQeIkbJ4Fh5cwZsrgGq6obwgN+Bg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bzgW2kLszJ6AqUktHnkjKxg0uufIxlfzP7LlFhRjCPj4XYbg5Y7t5EIY+G/sydn7m
	 GNmSqAjCfxw9HeCqRWeOejxyi8MpXiWa76Wtrlz/HMqZKlU9Lmd0Lyw3zeq5SPc/cK
	 X9v2MepKf9ewnEXB4Sb4BJ4rdKdWVsf//WDcPIswbzbFZ/Q4X9XKxiiiYwYKLkvd4f
	 1k2+aI8QcR0xOGkggk3I2Ce4QPHvpf6SmYasL+1aW5V6g1GyB3/G4SpkkL2hEBaN68
	 YwmQNX3aAcIkzD37LVr62RYmtDmwB1UVEU9GedD8pIQzSJgFqTzNou78rFSv0TVTtG
	 gc7yFOV90rqgQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so34598731fa.0;
        Tue, 16 Jul 2024 02:41:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsat3+raNo1Ac5DcHehzi8cVRrCggFpvfIqw+zMY3gWDb+7J3qKuzhqBqNDQUfl8mnHLlyUQObovpnAEqtnVVwoAlsAFBtdLGQG/33U5rcf29a8RJp4fe878zdCm+qT4Z1iFuJEzyKO7KtJh/Ere6PpRWE0hL3mUMOSInG7ihz5Vi2x7n3eGRavcdeqswCfJztqYWDk741IgfkSHAKPRU=
X-Gm-Message-State: AOJu0Yw/jv9rfbCKStDm8/Atc/TEgrB8p+Ac1Kwbnf+KnlH/Ft6MqTEQ
	Lz8ef9KfwxtHTORrZUneFoxrJMMLwvAEZHb+MknI9oMtR0WEEwFHgpQmGIMW+JWzjyZugwTxVmr
	3ogSwfTa5cUfqypsqlPev33cqf9Q=
X-Google-Smtp-Source: AGHT+IFNuSA6H3vBYEA02jikcpDWsWbHnSz+F7UeviPWcwDTM3KKs3IU1L/Occf2nay7b5LoDEclAsMtP+ErAVWY4qs=
X-Received: by 2002:a2e:b17a:0:b0:2ee:e0a1:c496 with SMTP id
 38308e7fff4ca-2eef415ff6amr11889151fa.9.1721122861833; Tue, 16 Jul 2024
 02:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
 <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
 <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com> <b1a53515-068a-4f70-87a9-44b77d02d1d5@app.fastmail.com>
In-Reply-To: <b1a53515-068a-4f70-87a9-44b77d02d1d5@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 16 Jul 2024 17:40:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cDiwAWBgXx8fBohZMocfup3rbe-XjDjEzsLAUB+1BUQ@mail.gmail.com>
Message-ID: <CAAhV-H5cDiwAWBgXx8fBohZMocfup3rbe-XjDjEzsLAUB+1BUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Kelvin Cheung <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 3:00=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B47=E6=9C=8815=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=882:39=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >
> >> You said that you've accepted my suggestion, which means you recognize
> >> 'loongson' as the better name for the drivers.
> > No, I don't think so, this is just a compromise to keep consistency.
>
> Folks, can we settle on this topic?
>
> Is this naming really important? As long as people can read actual chip n=
ame from
> kernel code & documents, I think both are acceptable.
>
> I suggest let this patch go as is. And if anyone want to unify the naming=
, they can
> propose a treewide patch.
Renaming still breaks config files.

Huacai

>
> Otherwise, we are going nowhere.
>
> Thanks
> -  Jiaxun
>
> >
> >
> >
> > Huacai
> >
> >> Moreover, Loongson1 and Loongson2 belong to different SoC series.
> >> To be honest, I can't see why Loongson1 APB DMA should give up this
> >> intuitive and comprehensible naming.
> >> Thanks for your review!
> >> >
> >> > Huacai
> >> >
> >> > On Thu, Jul 11, 2024 at 6:57=E2=80=AFPM Keguang Zhang via B4 Relay
> >> > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> >> > >
> >> > > Add the driver and dt-binding document for Loongson1 APB DMA.
> >> > >
> >> > > ---
> >> > > Changes in v9:
> >> > > - Fix all the errors and warnings when building with W=3D1 and C=
=3D1
> >> > > - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-=
0-f9992d257250@gmail.com
> >> > >
> >> > > Changes in v8:
> >> > > - Change 'interrupts' property to an items list
> >> > > - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-=
0-37db58608de5@gmail.com
> >> > >
> >> > > Changes in v7:
> >> > > - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Hua=
cai Chen)
> >> > > - Update the title and description part accordingly
> >> > > - Rename the file to loongson,ls1b-apbdma.yaml
> >> > > - Add a compatible string for LS1A
> >> > > - Delete minItems of 'interrupts'
> >> > > - Change patterns of 'interrupt-names' to const
> >> > > - Rename the file to loongson1-apb-dma.c to keep the consistency
> >> > > - Update Kconfig and Makefile accordingly
> >> > > - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-=
0-90de2c3cc928@gmail.com
> >> > >
> >> > > Changes in v6:
> >> > > - Change the compatible to the fallback
> >> > > - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> >> > > - as well as .device_pause and .device_resume.
> >> > > - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> >> > > - into one page to save memory
> >> > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> >> > > - Drop dma_slave_config structure
> >> > > - Use .remove_new instead of .remove
> >> > > - Use KBUILD_MODNAME for the driver name
> >> > > - Improve the debug information
> >> > > - Some minor fixes
> >> > >
> >> > > Changes in v5:
> >> > > - Add the dt-binding document
> >> > > - Add DT support
> >> > > - Use DT information instead of platform data
> >> > > - Use chan_id of struct dma_chan instead of own id
> >> > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> >> > > - Update the author information to my official name
> >> > >
> >> > > Changes in v4:
> >> > > - Use dma_slave_map to find the proper channel.
> >> > > - Explicitly call devm_request_irq() and tasklet_kill().
> >> > > - Fix namespace issue.
> >> > > - Some minor fixes and cleanups.
> >> > >
> >> > > Changes in v3:
> >> > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> >> > >
> >> > > Changes in v2:
> >> > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> >> > > - and rearrange it in alphabetical order in Kconfig and Makefile.
> >> > > - Fix comment style.
> >> > >
> >> > > ---
> >> > > Keguang Zhang (2):
> >> > >       dt-bindings: dma: Add Loongson-1 APB DMA
> >> > >       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
> >> > >
> >> > >  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
> >> > >  drivers/dma/Kconfig                                |   9 +
> >> > >  drivers/dma/Makefile                               |   1 +
> >> > >  drivers/dma/loongson1-apb-dma.c                    | 665 ++++++++=
+++++++++++++
> >> > >  4 files changed, 742 insertions(+)
> >> > > ---
> >> > > base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> >> > > change-id: 20231120-loongson1-dma-163afe5708b9
> >> > >
> >> > > Best regards,
> >> > > --
> >> > > Keguang Zhang <keguang.zhang@gmail.com>
> >> > >
> >> > >
> >> > >
> >>
> >>
> >>
> >> --
> >> Best regards,
> >>
> >> Keguang Zhang
>
> --
> - Jiaxun

