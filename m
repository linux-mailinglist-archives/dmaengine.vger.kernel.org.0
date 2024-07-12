Return-Path: <dmaengine+bounces-2685-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D628A92F57C
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6458628310A
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF81422C2;
	Fri, 12 Jul 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsNw0uwL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C71422C9;
	Fri, 12 Jul 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765435; cv=none; b=pbG1xX4H1rxpbo/wOSyOwzYkRE6CndDq+6YApbHwkPqK225UW8z5cC/6OUHFi94QVQpxBFuFcVlS0cF0oSNLphEB6UC18mTaqRlfq9Ivk4aNwytwc7DBV+enE6TgRzZrq9VR/qpgA9+lqJ/hxIvrBH8GG0f9+zBoa5LB68kqyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765435; c=relaxed/simple;
	bh=7RFVp2lz5mp+1LalWKNK2wS8PTe89bJIPp+ETCS5+Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeNm/B02FcxehCwFZOyYHQWyn8M5TWVTpveshiO3TbyNHpXXGUxnnGiXgBKypWK0DHyA9OBi0LWJki8e6adBlDGTo9ozOh994IxBqrANPcv5rAnO54AbrnSSDmxdUSCC9Yxrc+UII9hoEbqWC/46tL8F0kcR7Glwh5hv/1HUb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsNw0uwL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso2192801a12.1;
        Thu, 11 Jul 2024 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720765432; x=1721370232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfBvVsUJKI8nyPHXgvko/GPI/IZoVopWDS9NjHCJL6o=;
        b=fsNw0uwLeEFLW2F4CmBUxgHPyA1h/7t979TKwYOmBCkfmJ13kFNOYfnDNQO2utOZv/
         e8Upi/p0AZiXNzk8M0C1T6/VhoUMgnCgo31qEICony1u+rZZ1IJ9dBXOdspRQJI3Jq9c
         vVPHQt3+mnmhZnjNdLq/YvxkTxl475Q/aI42D+QZf4AVYfxoBQYJt8+B4Dki3Gq8WDGP
         qlW/dvIFcVM+6ZckZ2whvz9FWuyPZUFk9Yhf+44J4oS0pRpYBzNredtrFVTv21V64xte
         BMQQ2L80uqYc5wHjAzJIFfpxzYSzGWuSeO75YJN7PW/ochQMoT8F+S30jel4wWJYP16W
         Swjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720765432; x=1721370232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfBvVsUJKI8nyPHXgvko/GPI/IZoVopWDS9NjHCJL6o=;
        b=uUMpXtYJlJHqzXJejiHGPjQyOZOhf+zUg4oDdmEjFzw4+uCUptL8Or0KRBeNESIQEs
         R6flYCHe6+Q3U8nd4npkY5mTJ3BW/xUUPegrz/E1lXCIYgjMI24BK890D1FdbK+Z0AFP
         bM4qXfBSqIF58YLKQ1LRN+wU37Cd0DHyi31gObprOJuoDpn4RnSKPjALm9DKrd5BWF+V
         A2yZMsX/z81Dn1XlOYejoyvXkEWSvm53nshxQPw0bOfiPr0vZsjIw19BmBA/bxIY6RT9
         Pd9z/NgGNULIvR6FZ+WFxTgXkf1VRwG5TpH6jRaO7v6CpElRLAXkhSyGYQG1/73Z3NDa
         3yUg==
X-Forwarded-Encrypted: i=1; AJvYcCX1NQ11UWDq7bmdMIrQP75id6Y/ZF9LUiozQSnDD0U4CZoBoBq89lT6ZdsMWPF98tuHOu0QIznV8WcGQQ+nELJM0OZN4Pf5+d3KwTkWIyDgTWmTyPkirpOvsFnAcXd1GxLIAgLheDuk31pzl5cxmeADpkgwdZ9FmaaM3oBLXWSR45Kh8UP4SVdi97/zTkEt0JOhj87ajUCK/KUVfDKvIsQ=
X-Gm-Message-State: AOJu0Yw7lYj/YY9rat2MypxFm2No5zKw1QvlSLK3V/paf4e9VaLj0uuE
	KQMpxDdJaMX4JbTnF7XIpEVOMIS1SOLO4k5CCWGL7QcQQzuV+pcTXtXYG32doEglQg6v6uvYF0y
	pjUC5+iH7eTvzQJ+JarU15GgZKQY=
X-Google-Smtp-Source: AGHT+IFXLER3BNV6bbOH8bDfhXCke7H7254UOtRPJbe4WM7UFV4H5FiA9CFeviuOFjOJ89kcY3dh/0yYPa15nLXFPeI=
X-Received: by 2002:a05:6402:1ec9:b0:58d:836e:5d7c with SMTP id
 4fb4d7f45d1cf-594b9bfc09emr8105517a12.7.1720765431343; Thu, 11 Jul 2024
 23:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com> <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
In-Reply-To: <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Fri, 12 Jul 2024 14:23:15 +0800
Message-ID: <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:22=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Keguang,
>
> I accept your suggestion about the cpufreq driver naming, and now it
> is upstream:
> https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=
=3Dcpufreq/arm/linux-next&id=3Dccf51454145bffd98e31cdbe54a4262473c609e2
>
> I still hope you can accept my suggestion about the dma driver naming.
>
> I know you hope me rename LS2X_APB_DMA to LOONGSON2_APB_DMA, but as I
> said before, renaming an existing Kconfig option will break config
> files.
>
> See an example:
> Commit a50a3f4b6a313dc76912bd4ad3b8b4f4b4 introduce PREEMPT_RT and
> rename PREEMPT to PREEMPT_LL, but then commit
> b8d3349803ba34afda429e87a837fd95a9 rename it back because of config
> files broken.
>
Hi Huacai,
I understand the breaking issue of the Kconfig option, so you can keep
LS2X_APB_DMA.
You said that you've accepted my suggestion, which means you recognize
'loongson' as the better name for the drivers.
Moreover, Loongson1 and Loongson2 belong to different SoC series.
To be honest, I can't see why Loongson1 APB DMA should give up this
intuitive and comprehensible naming.
Thanks for your review!
>
> Huacai
>
> On Thu, Jul 11, 2024 at 6:57=E2=80=AFPM Keguang Zhang via B4 Relay
> <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> >
> > Add the driver and dt-binding document for Loongson1 APB DMA.
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



--
Best regards,

Keguang Zhang

