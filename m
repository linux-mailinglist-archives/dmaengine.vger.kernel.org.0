Return-Path: <dmaengine+bounces-1407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8423387E41C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 08:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3999C280C91
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C372262B;
	Mon, 18 Mar 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPtWy+0D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313B12B76;
	Mon, 18 Mar 2024 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747132; cv=none; b=nTSTYx/aQEJxOgpcGvFnw4895Cweg3eniIyDb3tPEwf6ZWvjHHZJwr9t7wKUGnVgMG8JOWrNh8DiPpM7gfsauEWWdV1XYjqxHBYLGrNnF+e+7L0sWIReyD3iUB22LleE/4ssG6evGXeW8D74ZRrqgKtBa6Wt5L3lQkUAyNLYcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747132; c=relaxed/simple;
	bh=bbXziPqpBRV0qZLhsg4AuOlJ5+y5Q/jIj9u9f8Qa0oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYe5tKaPFOaUQQgDisaUJMpnh+XXG+FJYco8Ubw9fnTrCEgMIRGsd/bN0lWPj2fGK59T0vv6FXkfeqdipMo7hr5jyRNYUoMSCdBEr7die878q2v7Awe+BkIT53y4HYrhlpGljPfrCKUajihgcYtOF1TI/rMgVXmZX7IYu2a2uBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPtWy+0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD32C433F1;
	Mon, 18 Mar 2024 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710747131;
	bh=bbXziPqpBRV0qZLhsg4AuOlJ5+y5Q/jIj9u9f8Qa0oE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BPtWy+0DdHelY0cUpomDcHadMgLGsnERO7NmFWITDsTFpK6lYBLOZlL1UYXRjxKdv
	 jwLuYbEZZHPba25GsXQfPaoAU6XWIwkGnYyq9jgtXIMn6En6oDx5dhagvajEv7/huV
	 G/o6Vwov+mZluIFM6Lxk7xH2XG3tWyR6P4Q31mMSWpPQuGYEOlnv0ZkfZMdBwAn6Up
	 pSyc/F+gLepn/StzjSGPAIWMSXGWvenpHTi7qAKnjQWlVJI+dM03CtCApJCelT57RC
	 QLTLnSsHrs1OjCveuSINDLZb/aEvbBcKuhkZXsX9xgOKcRKRGrwtOLGT9useW7R0u+
	 NcmmtXPAbERsg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46a7b8e07fso200419266b.2;
        Mon, 18 Mar 2024 00:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBzxt7lVKl7gztnC+BSOpIeNN8YzVH3IbpA6RkINjtvF5NpeEd5PNOyqvPRoWCKqsFkRfcqUejos2hJPgGiPdAhcodNeKPjxyz3iUboRL97M4a5MUo7+owzx7kSB8T31mD5nzq/DHVq/ZAf9tKyWYMqLSIqSLwaH+T9+86S9w9d3yr+NRz9Tg/bC1zJf4ncPzYfcu8dVViNtacH15grs8=
X-Gm-Message-State: AOJu0YwENSaIcT2ygYcH/sW6Dj8UPM2RSR8FnROXCQeaAI2AiHjJjeL6
	srK2jLUZNB3zafUSBq2K2cQgwattO+DCS+h2LR6TtTAXfkH5fhnNMSzxLXyU8f1cYPc+Hcle8p+
	zcTgabF4dGXLAJWuPOGkiRnstKCo=
X-Google-Smtp-Source: AGHT+IGJX09VGiPCmDBQJOuiE6At/QFzjXzSe62Lp5pSTm289d5FIHTFaalD0QxYzSNcbCHWVXOQPMIzfeA2/rY4UUA=
X-Received: by 2002:a17:906:aec4:b0:a46:83fd:b52d with SMTP id
 me4-20020a170906aec400b00a4683fdb52dmr5654190ejb.30.1710747130092; Mon, 18
 Mar 2024 00:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com> <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
In-Reply-To: <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 18 Mar 2024 15:31:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
Message-ID: <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
>
> Hi Huacai,
>
> > Hi, Keguang,
> >
> > Sorry for the late reply, there is already a ls2x-apb-dma driver, I'm
> > not sure but can they share the same code base? If not, can rename
> > this driver to ls1x-apb-dma for consistency?
>
> There are some differences between ls1x DMA and ls2x DMA, such as
> registers and DMA descriptors.
> I will rename it to ls1x-apb-dma.
OK, please also rename the yaml file to keep consistency.

Huacai

> Thanks!
>
> >
> > Huacai
> >
> > On Sat, Mar 16, 2024 at 7:34=E2=80=AFPM Keguang Zhang via B4 Relay
> > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > >
> > > Add the driver and dt-binding document for Loongson1 DMA.
> > >
> > > Changelog
> > > V5 -> V6:
> > >    Change the compatible to the fallback
> > >    Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> > >    as well as .device_pause and .device_resume.
> > >    Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> > >    into one page to save memory
> > >    Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > >    Drop dma_slave_config structure
> > >    Use .remove_new instead of .remove
> > >    Use KBUILD_MODNAME for the driver name
> > >    Improve the debug information
> > >    Some minor fixes
> > > V4 -> V5:
> > >    Add the dt-binding document
> > >    Add DT support
> > >    Use DT information instead of platform data
> > >    Use chan_id of struct dma_chan instead of own id
> > >    Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> > >    Update the author information to my official name
> > > V3 -> V4:
> > >    Use dma_slave_map to find the proper channel.
> > >    Explicitly call devm_request_irq() and tasklet_kill().
> > >    Fix namespace issue.
> > >    Some minor fixes and cleanups.
> > > V2 -> V3:
> > >    Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > > V1 -> V2:
> > >    Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> > >    and rearrange it in alphabetical order in Kconfig and Makefile.
> > >    Fix comment style.
> > >
> > > Keguang Zhang (2):
> > >   dt-bindings: dma: Add Loongson-1 DMA
> > >   dmaengine: Loongson1: Add Loongson1 dmaengine driver
> > >
> > >  .../bindings/dma/loongson,ls1x-dma.yaml       |  64 +++
> > >  drivers/dma/Kconfig                           |   9 +
> > >  drivers/dma/Makefile                          |   1 +
> > >  drivers/dma/loongson1-dma.c                   | 492 ++++++++++++++++=
++
> > >  4 files changed, 566 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls=
1x-dma.yaml
> > >  create mode 100644 drivers/dma/loongson1-dma.c
> > >
> > > --
> > > 2.39.2
> > >
> > > base-commit: 719136e5c24768ebdf80b9daa53facebbdd377c3
> > > ---
> > > Keguang Zhang (2):
> > >       dt-bindings: dma: Add Loongson-1 DMA
> > >       dmaengine: Loongson1: Add Loongson1 dmaengine driver
> > >
> > >  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml |  66 ++
> > >  drivers/dma/Kconfig                                |   9 +
> > >  drivers/dma/Makefile                               |   1 +
> > >  drivers/dma/loongson1-dma.c                        | 665 +++++++++++=
++++++++++
> > >  4 files changed, 741 insertions(+)
> > > ---
> > > base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
> > > change-id: 20231120-loongson1-dma-163afe5708b9
> > >
> > > Best regards,
> > > --
> > > Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > >
>
>
>
> --
> Best regards,
>
> Keguang Zhang

