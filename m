Return-Path: <dmaengine+bounces-2362-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3898907626
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CD51C23416
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC416149C62;
	Thu, 13 Jun 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx68Lz/j"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7F149C4B;
	Thu, 13 Jun 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291460; cv=none; b=a3boukS7aZ0hGNRfGOm1asWG4GEbCUqUfCTfV58MrOvpk6Vd8yED9tkkn1ETspPetOpOfNt5BCLZPZeKdEDmkQ+SgW12T7qwAZklIxhx5iuMx5/KeAClDqJ6EG+l6NbcMdpaUtaHebJx4zN+YT2zP6BIimO3oVML14Ng5Jy+AFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291460; c=relaxed/simple;
	bh=KEXcr6Qoi1UOFLMTPPqZR4F4hcqSnV5GgodnaogfRVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9bWK3cEmP7YzrWy9/nJaxmfOASke1mzqCnkOIoHPlAJIvOdKrHHv1M4OwYFvZ5Cyav+2apLTwWxUe/RHqvjePesMBnEM9O06Vpzo61axgDibG4y4gYuB04BFRr7iEZJkRp9SE+eRlGWUqTmSInfCxRk4LqwcPy6Du2x04/T3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx68Lz/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41676C4AF49;
	Thu, 13 Jun 2024 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291460;
	bh=KEXcr6Qoi1UOFLMTPPqZR4F4hcqSnV5GgodnaogfRVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tx68Lz/jYiv25eoBL7oqfcUkd0kEGRiwX9e+hvytTB0AU3CYT+0SY55E0Hx1/TXEE
	 Y4gsftI68RBk+RT6C/Ll0CpHl8u8hs0PQSY+hAkYkAqzuTNRLCLdcyIyvrZhZBcnzS
	 avA+ZuW/kdYPdbfwEJOsDn/OC5s6WpDk9o7g2LDzEKlD6L8gbpIGF8jvDwOXDjsPDZ
	 DTv95nHqQLDA7KiNjdXaAqVSV4k9wHFSyI5DoQGolB58QRUYX6no+D2wblqlJRdqRQ
	 av+qBZHGPedqvjY+o4UYwH/K3pC2E3TDOOR8qQN6AsTZPaFXwRWn64jpC15YrFdvyg
	 iSuXSbw1oONaQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f177b78dcso156331966b.1;
        Thu, 13 Jun 2024 08:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrhM2F/HwWHmn5RZ54Gka2TAQOd/+tBvCPZyvTW/soDacMFYVPu7eO/V8KDCqQb5qyQtoBZ0elsiXeJKH8kFZT8Pn8WzK0629UvM4cPuPVbtl6ydq4ihcqPeDiQJIRaCL50ClEzW9yDLVRYrgQRzJ3qC/ClJtuOcOgi0PEADRDGiGYr1cp3/vGg7/oIuioLxM/oSVf1M6CeJgOOzkGcLY=
X-Gm-Message-State: AOJu0YwhClA+zZnq0p+9Fi3wmSuGRLgA2CSWE4iWjb6UUV9Ye3vw2/hi
	XBokq27ZdVY4b1JBB508fFAG4hYfPm3yARlk3HdCSjJ8pS62xPaAnJyjh0V0GeJxSyozy7zodb+
	zoH1i/FTlp8zfLcdzZUvBw93GgX8=
X-Google-Smtp-Source: AGHT+IGKNP0sdxhLdeP60+uyQGarAo1kFcz7UY2k9bl7YpOANQuMJ5e0qwSraH31Wrs/+OIKEhu08Ba/9OtrjZJ5cS8=
X-Received: by 2002:a17:906:b0d9:b0:a6e:f8b9:361f with SMTP id
 a640c23a62f3a-a6f60d1d1bamr3615966b.24.1718291458750; Thu, 13 Jun 2024
 08:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongson1-dma-v9-0-6181f2c7dece@gmail.com>
In-Reply-To: <20240613-loongson1-dma-v9-0-6181f2c7dece@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 13 Jun 2024 23:10:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4nZqYi4ccsmw=1fmWySVL-kjoZ+_PQU4P9YKSrWGKdDw@mail.gmail.com>
Message-ID: <CAAhV-H4nZqYi4ccsmw=1fmWySVL-kjoZ+_PQU4P9YKSrWGKdDw@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Add support for Loongson1 APB DMA
To: keguang.zhang@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Keguang,

On Thu, Jun 13, 2024 at 8:03=E2=80=AFPM Keguang Zhang via B4 Relay
<devnull+keguang.zhang.gmail.com@kernel.org> wrote:
>
> Add the driver and dt-binding document for Loongson1 APB DMA.
I still suggest using ls1x-apb-dma.c as the file name, for consistency
in the same subsystem. But as I said before, I will also accept some
of your suggestions, so I use loongson3_cpufreq.c here.

https://lore.kernel.org/loongarch/20240612064205.2041548-1-chenhuacai@loong=
son.cn/T/#t

Huacai
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

