Return-Path: <dmaengine+bounces-1400-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9D87E20D
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 03:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392851C21125
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE261CFA9;
	Mon, 18 Mar 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxUrkA21"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9FFC19;
	Mon, 18 Mar 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727692; cv=none; b=n1ENK0cfiswYOj7+u8YjHyg3wf1OPpcXM9WLXCVejrAZJG2lpANzVXnZctBPIQI44jYAJ9GPvMLXtskkOfa7n/cXjRZENPy68HIVxkFDNELaCRkCgY4V8DykNIf4VMrVlIAsBzFYujJRI5lyd2f5aaO26mxtaiAnZRv3SZBwyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727692; c=relaxed/simple;
	bh=mws7dN5Idqqrfvi+n0P3+pOKyWtSoMBBeE76poHLdbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaX6PLnm0Q+bwB++KVGxwvuCngmXcEEXGmcanqutQKCjVtL0lk+Fy1pRivhjyUIoU3esdipNeduQRsGfkmME539hxSBxqklzPDYSNWGKyUV+yOSh4P1AEeqmJRSwZjgi/aaB5oihs6uh/9+C7ovSiuNCWM690E57Q/PrPJsDn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxUrkA21; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512bde3d197so3234340e87.0;
        Sun, 17 Mar 2024 19:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710727688; x=1711332488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWwzY7BG/SocTQKZ/npPoCXiIUvaGwetrinQ1Oo5Q6A=;
        b=QxUrkA21t6m/ZJKVEFTlMt7M0/ErwP/XRLGZ0uAnKLTXCl/sBuEQcOelXouDItjzxJ
         RpilwV+O3slTYRAruSqIna1p5N2npY3SiN+31WA3o/1pOeYo4R7+UDrs08kMT4pfq0rn
         vTsQw/gqzn+LF13eCcIeqj8NbleTidw0k3+uyYCvBpQpKd2YWg5AnKfeIEUbxOnO382P
         n6bqVhQMhxTZ4dtn0/KE+lVKYpZm2kjlca8sYaRfFcD6aLEwmX3cR8KzinCimmTuvzCl
         mH7fm/m4gYYp5Z6hue5AU7A/HJwzj6Eiy0eDQS5nT3W18jxamkbBPOB7CrIQddLpGi9c
         EDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710727688; x=1711332488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWwzY7BG/SocTQKZ/npPoCXiIUvaGwetrinQ1Oo5Q6A=;
        b=RTWjbgbtKi/w5z+kCtgruzot2FxL3zOjYUH0jK1Co+Aj0neSON79S2/6VC6SfOSabO
         bfn+B4nv4/NEFfykIIf4ySeqecJ0mYliFxhM3Lmrhn3FN19iIl9qK/72loiFVGmiXW56
         ZlhaU12k1VkAo4HE6tlnCTm0iB618/tgz5XK/DyerMDL2sTnjgpYMhv6+/KGVrD+qj9V
         mlTg3FvB/fwOc6qSgbdmBwujQFFH/EYy+/4fJLN/SjHp0IgPIhqkUaizP1APPk+kG99h
         Xa8sYifUD3yGnx+qsa7WkYFNwUuoIdkU7qLs+xNdDzHe/hEDttzhzUujeB+AAaBesC94
         fPLg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6Bmy1AfYezUdngWQXct9K1/kQR0IKpq8f9GTkN+W2IoXuADLLplIZuC57zn9+HKj+SXcKqXEuz0gYyDPAGDVlb4KHf/FWvXRoBx95ski09RjlhC252ecuXnogdR9XJTKPr+FYVfY38V2lYvtptB067LZZ0UmJb+nGruWSYLmLioa90+d+Qnjo9dDt92wWUheqqen63fgvThZg6iPh8c=
X-Gm-Message-State: AOJu0YwEu6b0iqOlxztDUVeNd8eV2PaPZiaJJIY73s0z/U2tKDSx7rur
	gtf2jpIbacS5UWU26GPrwSdKae0+sDNa83UVD/BFWaYoAQJYe0T0eRXiX1GjUwOhqVxtAoqLYVc
	1Gkhm4KzDCogxTUdnPFVKtxRWYZaOM6k4X682NL/f
X-Google-Smtp-Source: AGHT+IELJXfpHKY5OkoWCRxQO1hyaqGsdD/u6pXhrGkKOfTw4yoWtJPKyBqeeDjD/TMgR8o3MZzm+CvWvYv7033/2Os=
X-Received: by 2002:a19:ae17:0:b0:513:cf5e:f2ad with SMTP id
 f23-20020a19ae17000000b00513cf5ef2admr7502601lfc.60.1710727687838; Sun, 17
 Mar 2024 19:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com> <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
In-Reply-To: <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 18 Mar 2024 10:07:31 +0800
Message-ID: <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Huacai,

> Hi, Keguang,
>
> Sorry for the late reply, there is already a ls2x-apb-dma driver, I'm
> not sure but can they share the same code base? If not, can rename
> this driver to ls1x-apb-dma for consistency?

There are some differences between ls1x DMA and ls2x DMA, such as
registers and DMA descriptors.
I will rename it to ls1x-apb-dma.
Thanks!

>
> Huacai
>
> On Sat, Mar 16, 2024 at 7:34=E2=80=AFPM Keguang Zhang via B4 Relay
> <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> >
> > Add the driver and dt-binding document for Loongson1 DMA.
> >
> > Changelog
> > V5 -> V6:
> >    Change the compatible to the fallback
> >    Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> >    as well as .device_pause and .device_resume.
> >    Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> >    into one page to save memory
> >    Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> >    Drop dma_slave_config structure
> >    Use .remove_new instead of .remove
> >    Use KBUILD_MODNAME for the driver name
> >    Improve the debug information
> >    Some minor fixes
> > V4 -> V5:
> >    Add the dt-binding document
> >    Add DT support
> >    Use DT information instead of platform data
> >    Use chan_id of struct dma_chan instead of own id
> >    Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> >    Update the author information to my official name
> > V3 -> V4:
> >    Use dma_slave_map to find the proper channel.
> >    Explicitly call devm_request_irq() and tasklet_kill().
> >    Fix namespace issue.
> >    Some minor fixes and cleanups.
> > V2 -> V3:
> >    Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > V1 -> V2:
> >    Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> >    and rearrange it in alphabetical order in Kconfig and Makefile.
> >    Fix comment style.
> >
> > Keguang Zhang (2):
> >   dt-bindings: dma: Add Loongson-1 DMA
> >   dmaengine: Loongson1: Add Loongson1 dmaengine driver
> >
> >  .../bindings/dma/loongson,ls1x-dma.yaml       |  64 +++
> >  drivers/dma/Kconfig                           |   9 +
> >  drivers/dma/Makefile                          |   1 +
> >  drivers/dma/loongson1-dma.c                   | 492 ++++++++++++++++++
> >  4 files changed, 566 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x=
-dma.yaml
> >  create mode 100644 drivers/dma/loongson1-dma.c
> >
> > --
> > 2.39.2
> >
> > base-commit: 719136e5c24768ebdf80b9daa53facebbdd377c3
> > ---
> > Keguang Zhang (2):
> >       dt-bindings: dma: Add Loongson-1 DMA
> >       dmaengine: Loongson1: Add Loongson1 dmaengine driver
> >
> >  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml |  66 ++
> >  drivers/dma/Kconfig                                |   9 +
> >  drivers/dma/Makefile                               |   1 +
> >  drivers/dma/loongson1-dma.c                        | 665 +++++++++++++=
++++++++
> >  4 files changed, 741 insertions(+)
> > ---
> > base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
> > change-id: 20231120-loongson1-dma-163afe5708b9
> >
> > Best regards,
> > --
> > Keguang Zhang <keguang.zhang@gmail.com>
> >
> >



--=20
Best regards,

Keguang Zhang

