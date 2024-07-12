Return-Path: <dmaengine+bounces-2684-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4EC92F49C
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 06:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCDD1C21732
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239112B63;
	Fri, 12 Jul 2024 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd3eor4G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF50EADA;
	Fri, 12 Jul 2024 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758142; cv=none; b=ERf6uEwAb5J0sSnP2258Q2hyk00nyJojCT1DwYQ4tfJs8VdCrA61jhrF+KsAgnVamUUxi45tF/ytVqo4PApUutyuUXdh9PSfPs4gmaqFHYLfzSbjWEuaSCGCGk5SNWQ6ucXmkkezn7SlwZg1GuaMpKsP/sjGqXkQPpuRa7yUF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758142; c=relaxed/simple;
	bh=xJBLJGnkWv3RnZFtKq5BT4EAHngkcGgWajxTgdWFIM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb6b2TQq4XT8APRuU+syi1EVITUHI8gM0DNlGavRzuqvZ/a0qkMblNao5X+5K95QQW1HxGfvxuWWJGjdSGvK/PHxNQtN00T6C25YqsfqmyRSwl6enCGEp/Q+EvhJe1UfEmT9qCgKBwesTokv+wWais/rFbxZoyzFlTdA7IN8fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd3eor4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD8CC3277B;
	Fri, 12 Jul 2024 04:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720758142;
	bh=xJBLJGnkWv3RnZFtKq5BT4EAHngkcGgWajxTgdWFIM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yd3eor4GNLA8fYHcqmA4Mgv8I3ZdA4JH6mM9zf3HLseJw7L3jDF65Ylo/fLdoHaWl
	 Uralm29SGUhMNypXFvFvdBMuRvCIsvaSvxW25kvbWFcf7wbUHEiE5allvDbffeHXrg
	 mwjIa1RV1FvV7lfxjatwPY3/wT9GsyrRIDLkrtx8iy499wxa/kYBXuAdwk69JWuKqc
	 2PijPZJlhy8JQrAyyLWicanXm+cSZ/ZXwoN0nTbvh9xN37/sbDeGQFUOWUXw/plDu4
	 4pPKdV5slgWYRNh6DRKAEZMz1d2fkYGNszqn2zmQrMIJ+J7Pjcqfv/77qoN4sNzU/v
	 6jfcdQ2YXT8Mw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so2556274a12.3;
        Thu, 11 Jul 2024 21:22:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlnqRmzKRgkNAs5C5qWIKbUP7+IFXywBJgQ04GFoX+W2iJnQ8Ew4ZE048fcum0bX/+E2dsErW2XUREXtklisiVS04YQw60mLl7z9G8jdQ3fVWRolIAQe9xUgTnBtUzP8DEdjYlcXdfa4zlrugYJyAScsYXPQid/Lse0j2DedfR0GTtDjue4hwuY9I5QkaPz39ELxgTKm54QvHnntCuzP4=
X-Gm-Message-State: AOJu0YwPXD0tYdNPBzhudqCW2HGI6t8nRJN4Xd4jFoMr6TLklYfcUwca
	Jl6RFCidWniPhCtqkoZ4Nap3FE31FoCMl+r9tC6Chkbhb5Ap6q9bV1XLWG+FGKjL11y4zz67GPX
	Ou7fQPNcHzIQDj7GvE8z+5OSw9MU=
X-Google-Smtp-Source: AGHT+IFZKOANoM8v8rM4AFHqokwhiDj3xRGVMXUW+F0ed4fhiS7GlTQJabdLva7OWql+9JFgkZTWGMomt7QcU8BUYrs=
X-Received: by 2002:aa7:cf0e:0:b0:57c:7ed7:897a with SMTP id
 4fb4d7f45d1cf-594bb869e6bmr5922024a12.27.1720758140498; Thu, 11 Jul 2024
 21:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
In-Reply-To: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Jul 2024 12:22:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
Message-ID: <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
To: keguang.zhang@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Keguang,

I accept your suggestion about the cpufreq driver naming, and now it
is upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=3D=
cpufreq/arm/linux-next&id=3Dccf51454145bffd98e31cdbe54a4262473c609e2

I still hope you can accept my suggestion about the dma driver naming.

I know you hope me rename LS2X_APB_DMA to LOONGSON2_APB_DMA, but as I
said before, renaming an existing Kconfig option will break config
files.

See an example:
Commit a50a3f4b6a313dc76912bd4ad3b8b4f4b4 introduce PREEMPT_RT and
rename PREEMPT to PREEMPT_LL, but then commit
b8d3349803ba34afda429e87a837fd95a9 rename it back because of config
files broken.


Huacai

On Thu, Jul 11, 2024 at 6:57=E2=80=AFPM Keguang Zhang via B4 Relay
<devnull+keguang.zhang.gmail.com@kernel.org> wrote:
>
> Add the driver and dt-binding document for Loongson1 APB DMA.
>
> ---
> Changes in v9:
> - Fix all the errors and warnings when building with W=3D1 and C=3D1
> - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-0-f9992=
d257250@gmail.com
>
> Changes in v8:
> - Change 'interrupts' property to an items list
> - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0-37db5=
8608de5@gmail.com
>
> Changes in v7:
> - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Che=
n)
> - Update the title and description part accordingly
> - Rename the file to loongson,ls1b-apbdma.yaml
> - Add a compatible string for LS1A
> - Delete minItems of 'interrupts'
> - Change patterns of 'interrupt-names' to const
> - Rename the file to loongson1-apb-dma.c to keep the consistency
> - Update Kconfig and Makefile accordingly
> - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-90de2=
c3cc928@gmail.com
>
> Changes in v6:
> - Change the compatible to the fallback
> - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> - as well as .device_pause and .device_resume.
> - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> - into one page to save memory
> - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> - Drop dma_slave_config structure
> - Use .remove_new instead of .remove
> - Use KBUILD_MODNAME for the driver name
> - Improve the debug information
> - Some minor fixes
>
> Changes in v5:
> - Add the dt-binding document
> - Add DT support
> - Use DT information instead of platform data
> - Use chan_id of struct dma_chan instead of own id
> - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> - Update the author information to my official name
>
> Changes in v4:
> - Use dma_slave_map to find the proper channel.
> - Explicitly call devm_request_irq() and tasklet_kill().
> - Fix namespace issue.
> - Some minor fixes and cleanups.
>
> Changes in v3:
> - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
>
> Changes in v2:
> - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> - and rearrange it in alphabetical order in Kconfig and Makefile.
> - Fix comment style.
>
> ---
> Keguang Zhang (2):
>       dt-bindings: dma: Add Loongson-1 APB DMA
>       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
>
>  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
>  drivers/dma/Kconfig                                |   9 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++++++=
++++++
>  4 files changed, 742 insertions(+)
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20231120-loongson1-dma-163afe5708b9
>
> Best regards,
> --
> Keguang Zhang <keguang.zhang@gmail.com>
>
>
>

