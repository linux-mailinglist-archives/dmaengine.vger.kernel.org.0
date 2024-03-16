Return-Path: <dmaengine+bounces-1396-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89B87DA65
	for <lists+dmaengine@lfdr.de>; Sat, 16 Mar 2024 15:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFAAB212FD
	for <lists+dmaengine@lfdr.de>; Sat, 16 Mar 2024 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3918E1E;
	Sat, 16 Mar 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTyPkDiW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873F2F4A;
	Sat, 16 Mar 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597905; cv=none; b=uStQ8IzkykXSDfoWbR+Uq+N9iLCgGJJ5HDuZB7rD5c4Ukr+cqMQBdoI9b4qEu9lyN+fQgdQfNIdbsf1VvkPginGsSyt67rAF38Q/xlBZWeUrU2Qo5je3bPtWqcWu+2F99FK8vh8rgbCtu7wEoJC03DlDntiKRk5/NG1Y/CxQyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597905; c=relaxed/simple;
	bh=amixzluleKA1HX6A3tMriG6xxpkzudzpXqwqjiZetbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzrKl8pt4Qbulha7BFCjfE8t59vqV/SDD49JTJYpu72hsVM8luu3kNL53NGfA90Wh9RA92eSPpBGWSd9PEvyDqIlKaO5ONmDwUNIkyT+NY9DYucrH1FGcH3GTYxUL4hHetB/PHzDqJV2TGF8qA/1C/HfZ9FF1es+ZogwdP8Te/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTyPkDiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C4C433C7;
	Sat, 16 Mar 2024 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710597904;
	bh=amixzluleKA1HX6A3tMriG6xxpkzudzpXqwqjiZetbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GTyPkDiW/xjYqiebMrtBr69ygwNafwO79gbrZq92gRVVyR6Dv03Pnbt0ieH2o49NR
	 w089NssxcGEbE3r9gaOWw0DXw9p3NvmvUZOO8p4vCFqwXj3iqVkR0otg4m1YhLexBu
	 D3B+J8Wasf5Ivde5izXuVcAiEhkF9ELVWdatXJbRed5l6Tk1bvbqu/hcHNAsfHK3sb
	 Ma44B2bmeeLghltTp1ZBjJS+WxwcaxlIcr+MNxvcrLYI+Be3ggpbmKhnwt8V/qFhWK
	 Mmk8KO3vFMBK0sOZX2Bgr+5y4WRR1S1CJ+eB+3IDHt44Y/cMCg/u7EYnXpSBk9FwXT
	 rqwDgO4+EhheA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46805cd977so252048766b.0;
        Sat, 16 Mar 2024 07:05:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSUYPPrDcV/Yy3Ar41kt86gPYqZxprz+yntBG84anrMDbiyAd6jK3dR33pLAtxsJqFz7jplWQ0lXTxyYjKRVt+ZhTKxtPmbj9jJJlY7vWMM9vx/d2zyh2wjlpR7jIZOHZBtTltt3WQr/jxA1Z07VYR6azZa0v6oVMOj7GAaMFeGYawak1O4KTBkViYD69fJ4uATMLfMP8IuIRWUhnh1CU=
X-Gm-Message-State: AOJu0Yy2bcggv+4NgHGK1WbtXilpLpMvv05mg4JL10NpqXR2YrtdW5Go
	GlczByJR8bd8DA6Gbs41aVQT4DvV0Odhm4TLuhUnFhDJiAp4YTkHbDfX2yRb4ZO9avLBii7x7Z5
	+q+o9fiJVQY4jBh6gYnwX9UZ7WsE=
X-Google-Smtp-Source: AGHT+IEKrLynn+1R7Lwe8ZlP5ZBJbdrQdC8AxTeaSG9WCvKWqEifH6WOwfvgxH0I3TH4jaUEoyd3OYA49aWSb25FVeA=
X-Received: by 2002:a17:906:11d6:b0:a45:1850:e6ed with SMTP id
 o22-20020a17090611d600b00a451850e6edmr3653615eja.6.1710597903023; Sat, 16 Mar
 2024 07:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
In-Reply-To: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 16 Mar 2024 22:04:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
Message-ID: <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: keguang.zhang@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Keguang,

Sorry for the late reply, there is already a ls2x-apb-dma driver, I'm
not sure but can they share the same code base? If not, can rename
this driver to ls1x-apb-dma for consistency?

Huacai

On Sat, Mar 16, 2024 at 7:34=E2=80=AFPM Keguang Zhang via B4 Relay
<devnull+keguang.zhang.gmail.com@kernel.org> wrote:
>
> Add the driver and dt-binding document for Loongson1 DMA.
>
> Changelog
> V5 -> V6:
>    Change the compatible to the fallback
>    Implement .device_prep_dma_cyclic for Loongson1 sound driver,
>    as well as .device_pause and .device_resume.
>    Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
>    into one page to save memory
>    Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
>    Drop dma_slave_config structure
>    Use .remove_new instead of .remove
>    Use KBUILD_MODNAME for the driver name
>    Improve the debug information
>    Some minor fixes
> V4 -> V5:
>    Add the dt-binding document
>    Add DT support
>    Use DT information instead of platform data
>    Use chan_id of struct dma_chan instead of own id
>    Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
>    Update the author information to my official name
> V3 -> V4:
>    Use dma_slave_map to find the proper channel.
>    Explicitly call devm_request_irq() and tasklet_kill().
>    Fix namespace issue.
>    Some minor fixes and cleanups.
> V2 -> V3:
>    Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> V1 -> V2:
>    Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
>    and rearrange it in alphabetical order in Kconfig and Makefile.
>    Fix comment style.
>
> Keguang Zhang (2):
>   dt-bindings: dma: Add Loongson-1 DMA
>   dmaengine: Loongson1: Add Loongson1 dmaengine driver
>
>  .../bindings/dma/loongson,ls1x-dma.yaml       |  64 +++
>  drivers/dma/Kconfig                           |   9 +
>  drivers/dma/Makefile                          |   1 +
>  drivers/dma/loongson1-dma.c                   | 492 ++++++++++++++++++
>  4 files changed, 566 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x-d=
ma.yaml
>  create mode 100644 drivers/dma/loongson1-dma.c
>
> --
> 2.39.2
>
> base-commit: 719136e5c24768ebdf80b9daa53facebbdd377c3
> ---
> Keguang Zhang (2):
>       dt-bindings: dma: Add Loongson-1 DMA
>       dmaengine: Loongson1: Add Loongson1 dmaengine driver
>
>  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml |  66 ++
>  drivers/dma/Kconfig                                |   9 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/loongson1-dma.c                        | 665 +++++++++++++++=
++++++
>  4 files changed, 741 insertions(+)
> ---
> base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
> change-id: 20231120-loongson1-dma-163afe5708b9
>
> Best regards,
> --
> Keguang Zhang <keguang.zhang@gmail.com>
>
>

