Return-Path: <dmaengine+bounces-452-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE380D4C2
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 18:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783721F219F9
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E424EB58;
	Mon, 11 Dec 2023 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyOzqIsV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AC495C0;
	Mon, 11 Dec 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D215EC433CA;
	Mon, 11 Dec 2023 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702317425;
	bh=27X4w9e1qWEYMIbF+OREzOmYAdGnUayZxwtJ7vuH6tI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FyOzqIsVzgmL7GusKSzeVR5GTJZAuDw6Hs8BlqA61e29Ph9LvBHnfaoUW3QGjBtLV
	 HibH3MHj3zGIkTX6UPN5ml1EUEdH+CJAq/HIwWoX4Z4ogiK33OgnF0hf97VODkjb+W
	 0REqg27TRYFcVIjbVop/AtpUS8FvEhWVoQOkw0x7mMkCAYYez+omQzVDA6FZJlBRej
	 2sXTNlpbS0hVz8Qyv/ZEIQfdHPb/DOF4ZUu5qP69TMTKmHUZrRPVgobsARIPpudp8u
	 GZSI6dmXiso0T9SbLadr2vaRUeu5SB/OsZL4qsAgyupO2P7/deIXOktFti9kJ5HplU
	 m78dpaYYpEwKQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso5418938e87.0;
        Mon, 11 Dec 2023 09:57:05 -0800 (PST)
X-Gm-Message-State: AOJu0YxjMKW6QQ0VupxdbQKexiQX8H6o5B9sGEsGXRe538Xx+ZmEoD8D
	CmSiRdsRPd46HoGbpiK8szMIs+1OlDbAyCyPNQ==
X-Google-Smtp-Source: AGHT+IFMrHyHRF+aoP9bK6xkMRkJgXmBAt5pmRe09xl8SvC/OWvXlucg2leD7g4aC+cEZFTOSwyflLvEBn2qh2/Nxrk=
X-Received: by 2002:a05:6512:2806:b0:50c:2254:9f58 with SMTP id
 cf6-20020a056512280600b0050c22549f58mr2216119lfb.11.1702317424052; Mon, 11
 Dec 2023 09:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129065305.70364-1-guomengqi3@huawei.com> <20231129065305.70364-2-guomengqi3@huawei.com>
In-Reply-To: <20231129065305.70364-2-guomengqi3@huawei.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Dec 2023 11:56:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+y8VsCLBgCsMPMeAbSgPvLs_iHqa4F6S=Cdh81tnjxcg@mail.gmail.com>
Message-ID: <CAL_Jsq+y8VsCLBgCsMPMeAbSgPvLs_iHqa4F6S=Cdh81tnjxcg@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 1/2] dmaengine: Add HiSilicon Ascend SDMA engine support
To: Guo Mengqi <guomengqi3@huawei.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 12:57=E2=80=AFAM Guo Mengqi <guomengqi3@huawei.com>=
 wrote:
>
> This patch adds a driver for HiSilicon Ascend SDMA engine.
>
> The DMA controller can do transfers between device and memory
> or memory to memory. Currently, the controller only support
> single copy. Drives can pass a substreamid to the DMA engine,
> which will enable transfers in user-space addresses.
>
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  drivers/dma/Kconfig            |   9 +
>  drivers/dma/Makefile           |   1 +
>  drivers/dma/hisi-ascend-sdma.c | 788 +++++++++++++++++++++++++++++++++
>  3 files changed, 798 insertions(+)
>  create mode 100644 drivers/dma/hisi-ascend-sdma.c
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 70ba506dabab..974a00e528ae 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -244,6 +244,15 @@ config FSL_RAID
>           the capability to offload memcpy, xor and pq computation
>           for raid5/6.
>
> +config HISI_ASCEND_SDMA
> +       tristate "HiSilicon Ascend SDMA Engine support"
> +       depends on ARCH_HISI && ARM64 || COMPILE_TEST
> +       depends on IOMMU_API && OF && IOMMU_SVA
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         Enable support for HiSilicon Ascend SDMA engine.
> +
>  config HISI_DMA
>         tristate "HiSilicon DMA Engine support"
>         depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 83553a97a010..0b736c54407b 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_XGENE_DMA) +=3D xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) +=3D st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) +=3D fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
> +obj-$(CONFIG_HISI_ASCEND_SDMA) +=3D hisi-ascend-sdma.o
>
>  obj-y +=3D mediatek/
>  obj-y +=3D qcom/
> diff --git a/drivers/dma/hisi-ascend-sdma.c b/drivers/dma/hisi-ascend-sdm=
a.c
> new file mode 100644
> index 000000000000..74560b1fdca5
> --- /dev/null
> +++ b/drivers/dma/hisi-ascend-sdma.c
> @@ -0,0 +1,788 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2019-2022 HiSilicon Limited. */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/dmaengine.h>
> +#include <linux/slab.h>
> +#include "virt-dma.h"
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

of_address.h is also probably not needed. Double check.

Rob

