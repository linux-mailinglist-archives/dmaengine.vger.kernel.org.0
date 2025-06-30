Return-Path: <dmaengine+bounces-5677-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A88CAED7D2
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5A617546D
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14110215F72;
	Mon, 30 Jun 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoRQm32R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC22BCF5;
	Mon, 30 Jun 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273485; cv=none; b=CWXL0BYKU4OZImTyi1mM/zdbf8t9HdllO87PODl94KFTP1/st5R3l8+XYWgU85VRRu5NlGX0VrxjkvwdfB74tdcz6B7UOZXQU8u2Qy+91px4Ka1oPbQ3FlOhdmHDGrOUVUC9ETUwmeIULatLL0Gmc0uXJf5VUSjYj2YHkPJhLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273485; c=relaxed/simple;
	bh=vNw0QcDEpf8wvRwxc0dkNAt5A5x7kJIOR/+/9FPvDQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9QpCtE8YLKPGnezZg0iGGPKnLVhyaow1Ye7sm7Ihw0s04jv/gaSiMPsxxj53UmEj9qS5hdimR8FZV3yCHlPlYSYGfKLEWkihKNrsojE24P3NmipEqTyPgBy3lBikpAY6yXCNPb8twIso3UMFvtO7fxez0KrMn7Zw2/hj/AS2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoRQm32R; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553b60de463so2084544e87.3;
        Mon, 30 Jun 2025 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751273480; x=1751878280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxlhdwY5NSE2ujq3dyZbznmzCl6Jt5M2WFeyE4bxeF0=;
        b=CoRQm32R5W7L5cGzw+7qcOO2iiq3zfhfYP/+ZiVLsA5WuxxFedza1cd24MBB2A80gU
         LydqFnckgoDJtukmlMppqy2T/zkB7wyhYqzI0P2bg5L+C7hI+qDWgFZbmq64yC0h9ebP
         JNQGmXkmhx2HI51qVr5mGMp6Ju3d6iFZtIJ9Pd1uT4wJRxwRs5GiN3TdyRqdD791GFSo
         iepUDiDONyVy43rYpT2NUDwTZG6uQHbjd4fm1QT1iOvys9mv5AJehbt7NBIf1ZfxeWOJ
         BUeJDwhG1erGrNGbKD9PyM+nWbtqHUWG5eS04viwhU3ctE4fu9DRJrYeJsoHisSA/EUT
         FD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273480; x=1751878280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxlhdwY5NSE2ujq3dyZbznmzCl6Jt5M2WFeyE4bxeF0=;
        b=UZc8z9So0MPEBcRvd7pqGu7Ivsh8ENozHhK7j8EUWpC1kK2hv2gz0yH/8hWVe3PjZV
         q1Ch5c7+iE5LOrU8iHhTWbDS/GcS37m5V3uEkt48v+uFLc/RCV5O8xEF4uuD0CdnKP7d
         /1i49oGWT+wz1PmgY58G8iwaBYP7v+NAUDXf8dRzTYOyxa/BDv8Y9kEk7TyydYidnnw9
         56ry8uibzrpvmBBCVDq/PWazxnlG5JrU/NxzZbl+CxKymEGTMT3FWrTmFTQIM1sw/33c
         W9zr11J/ev1169e+AbsklEomGBGjarOBME+5zpr2ixzAU6P/f8rqYQpkwA5r1jd4IReq
         cIpg==
X-Forwarded-Encrypted: i=1; AJvYcCVLK07hvYZ2fsb1U9zKDOIIXfDAolwGRs0Mkm1DGAy5XJ77b4PF+3y7HZbA0iRcYfEQLNKweelWgiso0+qY@vger.kernel.org, AJvYcCXar1ZmK1APMwiqXBmLbWUvJeE+Xwp+9iREMeILdobetJMPT9cZNy76Z6jxcc54cI9gYkoVEZeCy+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEGXfST7mXc8CL8elCfhSPwWoo4WMTYFSRX+MauJy70bAgntO
	Wdqkog31DFd8ew2ZSET2Nj/oJwMthm/OKlTdSzT5HhSNI4bOvm/4yGQyuzAQmMcGG1K8o6BChw6
	+qzS0IWW2FUHjHHaUbtoUZZBqf4slDDI=
X-Gm-Gg: ASbGncv+SrYkIVwv56G/Zs/JEWBhJELBloInXjdLnAYdEC9ltTgC7/TG8k95kZOwu3k
	dJT4xuFj1GZG0FzGOppP2k7DKkkPejN2EjmTvx660XMJ0cOSdWgy3sCRnvjpjkGBhgDNnvHjdl5
	o5TE+4Fiz8d1Ocw3Sej8WAON1jrPMxSTEbQsxXw580F0wo
X-Google-Smtp-Source: AGHT+IEiO8p2X44t72jqVTD+mn8vsqplrq/W6Fs/arj54D4S4tf7xaQksgwXOiLc7knN5Os4cMWlrbITDpQHd3aJLPA=
X-Received: by 2002:ac2:4e05:0:b0:554:f9c5:6b30 with SMTP id
 2adb3069b0e04-5550b8e9158mr3709997e87.38.1751273479679; Mon, 30 Jun 2025
 01:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616124934.141782-1-al.kochet@gmail.com> <20250616124934.141782-2-al.kochet@gmail.com>
In-Reply-To: <20250616124934.141782-2-al.kochet@gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 30 Jun 2025 16:50:42 +0800
X-Gm-Features: Ac12FXxUmfXyKHRchRqBVySyp7vRmYA1AQvj0zXUMfDgr7eeFhx1PgkipwDNTeM
Message-ID: <CAJhJPsW5JoYiUi=ZfrCkg0sXVNY3tu0cg2URVdcGc21-vwdTEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: virt-dma: convert tasklet to BH
 workqueue for callback invocation
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nishad Saraf <nishads@amd.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Paul Cercueil <paul@crapouillou.net>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Andy Shevchenko <andy@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	=?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Amit Vadhavana <av2082000@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
	Casey Connolly <casey.connolly@linaro.org>, Kees Cook <kees@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:49=E2=80=AFPM Alexander Kochetkov <al.kochet@gmai=
l.com> wrote:
>
> Currently DMA callbacks are called from tasklet. However the tasklet is
> marked deprecated and must be replaced by BH workqueue. Tasklet callbacks
> are executed either in the Soft IRQ context or from ksoftirqd thread. BH
> workqueue work items are executed in the BH context. Changing tasklet to
> BH workqueue improved DMA callback latencies.
>
> The commit changes virt-dma driver and all of its users:
> - tasklet is replaced to work_struct, tasklet callback updated accordingl=
y
> - kill_tasklet() is replaced to cancel_work_sync()
> - added include of linux/interrupt.h where necessary
>
> Tested on Pine64 (Allwinner A64 ARMv8) with sun6i-dma driver. All other
> drivers are changed similarly and tested for compilation.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  drivers/dma/amd/qdma/qdma.c                    |  1 +
>  drivers/dma/arm-dma350.c                       |  1 +
>  drivers/dma/bcm2835-dma.c                      |  2 +-
>  drivers/dma/dma-axi-dmac.c                     |  8 ++++----
>  drivers/dma/dma-jz4780.c                       |  2 +-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  2 +-
>  drivers/dma/dw-edma/dw-edma-core.c             |  2 +-
>  drivers/dma/fsl-edma-common.c                  |  2 +-
>  drivers/dma/fsl-edma-common.h                  |  1 +
>  drivers/dma/fsl-qdma.c                         |  3 ++-
>  drivers/dma/hisi_dma.c                         |  2 +-
>  drivers/dma/hsu/hsu.c                          |  2 +-
>  drivers/dma/idma64.c                           |  3 ++-
>  drivers/dma/img-mdc-dma.c                      |  2 +-
>  drivers/dma/imx-sdma.c                         |  2 +-
>  drivers/dma/k3dma.c                            |  2 +-
>  drivers/dma/loongson1-apb-dma.c                |  2 +-

Reviewed-by: Keguang Zhang <keguang.zhang@gmail.com>
Tested-by: Keguang Zhang <keguang.zhang@gmail.com> # on LS1B & LS1C

>  drivers/dma/mediatek/mtk-cqdma.c               |  2 +-
>  drivers/dma/mediatek/mtk-hsdma.c               |  3 ++-
>  drivers/dma/mediatek/mtk-uart-apdma.c          |  4 ++--
>  drivers/dma/owl-dma.c                          |  2 +-
>  drivers/dma/pxa_dma.c                          |  2 +-
>  drivers/dma/qcom/bam_dma.c                     |  4 ++--
>  drivers/dma/qcom/gpi.c                         |  1 +
>  drivers/dma/qcom/qcom_adm.c                    |  2 +-
>  drivers/dma/sa11x0-dma.c                       |  2 +-
>  drivers/dma/sf-pdma/sf-pdma.c                  |  3 ++-
>  drivers/dma/sprd-dma.c                         |  2 +-
>  drivers/dma/st_fdma.c                          |  2 +-
>  drivers/dma/stm32/stm32-dma.c                  |  1 +
>  drivers/dma/stm32/stm32-dma3.c                 |  1 +
>  drivers/dma/stm32/stm32-mdma.c                 |  1 +
>  drivers/dma/sun6i-dma.c                        |  2 +-
>  drivers/dma/tegra186-gpc-dma.c                 |  2 +-
>  drivers/dma/tegra210-adma.c                    |  3 ++-
>  drivers/dma/ti/edma.c                          |  2 +-
>  drivers/dma/ti/k3-udma.c                       | 10 +++++-----
>  drivers/dma/ti/omap-dma.c                      |  2 +-
>  drivers/dma/uniphier-xdmac.c                   |  1 +
>  drivers/dma/virt-dma.c                         |  8 ++++----
>  drivers/dma/virt-dma.h                         | 10 +++++-----
>  41 files changed, 62 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
> index 8fb2d5e1df20..538aa49c6a5f 100644
> --- a/drivers/dma/amd/qdma/qdma.c
> +++ b/drivers/dma/amd/qdma/qdma.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitops.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 9efe2ca7d5ec..9e87856ab559 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -5,6 +5,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/module.h>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 0117bb2e8591..24411d7ac895 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -846,7 +846,7 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *o=
d)
>         list_for_each_entry_safe(c, next, &od->ddev.channels,
>                                  vc.chan.device_node) {
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>         }
>
>         dma_unmap_page_attrs(od->ddev.dev, od->zero_page, PAGE_SIZE,
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 36943b0c6d60..181ba12b3ad4 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -1041,9 +1041,9 @@ static int axi_dmac_detect_caps(struct axi_dmac *dm=
ac, unsigned int version)
>         return 0;
>  }
>
> -static void axi_dmac_tasklet_kill(void *task)
> +static void axi_dmac_cancel_work_sync(void *work)
>  {
> -       tasklet_kill(task);
> +       cancel_work_sync(work);
>  }
>
>  static void axi_dmac_free_dma_controller(void *of_node)
> @@ -1146,8 +1146,8 @@ static int axi_dmac_probe(struct platform_device *p=
dev)
>          * Put the action in here so it get's done before unregistering t=
he DMA
>          * device.
>          */
> -       ret =3D devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kil=
l,
> -                                      &dmac->chan.vchan.task);
> +       ret =3D devm_add_action_or_reset(&pdev->dev, axi_dmac_cancel_work=
_sync,
> +                                      &dmac->chan.vchan.work);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 100057603fd4..90edd8286730 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -1019,7 +1019,7 @@ static void jz4780_dma_remove(struct platform_devic=
e *pdev)
>         free_irq(jzdma->irq, jzdma);
>
>         for (i =3D 0; i < jzdma->soc_data->nb_channels; i++)
> -               tasklet_kill(&jzdma->chan[i].vchan.task);
> +               cancel_work_sync(&jzdma->chan[i].vchan.work);
>  }
>
>  static const struct jz4780_dma_soc_data jz4740_dma_soc_data =3D {
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..3acf095c3994 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1649,7 +1649,7 @@ static void dw_remove(struct platform_device *pdev)
>         list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
>                         vc.chan.device_node) {
>                 list_del(&chan->vc.chan.device_node);
> -               tasklet_kill(&chan->vc.task);
> +               cancel_work_sync(&chan->vc.work);
>         }
>  }
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2b88cc99e5d..a613b2c64e8a 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1005,7 +1005,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>         dma_async_device_unregister(&dw->dma);
>         list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
>                                  vc.chan.device_node) {
> -               tasklet_kill(&chan->vc.task);
> +               cancel_work_sync(&chan->vc.work);
>                 list_del(&chan->vc.chan.device_node);
>         }
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.=
c
> index 4976d7dde080..9a498c14471a 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -894,7 +894,7 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev=
)
>         list_for_each_entry_safe(chan, _chan,
>                                 &dmadev->channels, vchan.chan.device_node=
) {
>                 list_del(&chan->vchan.chan.device_node);
> -               tasklet_kill(&chan->vchan.task);
> +               cancel_work_sync(&chan->vchan.work);
>         }
>  }
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.=
h
> index 205a96489094..1bd80d68f5ec 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -7,6 +7,7 @@
>  #define _FSL_EDMA_COMMON_H_
>
>  #include <linux/dma-direction.h>
> +#include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include "virt-dma.h"
>
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 823f5c6bc2e1..bab0bb9fd986 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>
>  #include "virt-dma.h"
> @@ -1261,7 +1262,7 @@ static void fsl_qdma_cleanup_vchan(struct dma_devic=
e *dmadev)
>         list_for_each_entry_safe(chan, _chan,
>                                  &dmadev->channels, vchan.chan.device_nod=
e) {
>                 list_del(&chan->vchan.chan.device_node);
> -               tasklet_kill(&chan->vchan.task);
> +               cancel_work_sync(&chan->vchan.work);
>         }
>  }
>
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 25a4134be36b..0cddb4949051 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -720,7 +720,7 @@ static void hisi_dma_disable_qps(struct hisi_dma_dev =
*hdma_dev)
>
>         for (i =3D 0; i < hdma_dev->chan_num; i++) {
>                 hisi_dma_disable_qp(hdma_dev, i);
> -               tasklet_kill(&hdma_dev->chan[i].vc.task);
> +               cancel_work_sync(&hdma_dev->chan[i].vc.work);
>         }
>  }
>
> diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
> index af5a2e252c25..4ea3f18a20ac 100644
> --- a/drivers/dma/hsu/hsu.c
> +++ b/drivers/dma/hsu/hsu.c
> @@ -500,7 +500,7 @@ int hsu_dma_remove(struct hsu_dma_chip *chip)
>         for (i =3D 0; i < hsu->nr_channels; i++) {
>                 struct hsu_dma_chan *hsuc =3D &hsu->chan[i];
>
> -               tasklet_kill(&hsuc->vchan.task);
> +               cancel_work_sync(&hsuc->vchan.work);
>         }
>
>         return 0;
> diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
> index d147353d47ab..fd8d30a02153 100644
> --- a/drivers/dma/idma64.c
> +++ b/drivers/dma/idma64.c
> @@ -12,6 +12,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -624,7 +625,7 @@ static void idma64_remove(struct idma64_chip *chip)
>         for (i =3D 0; i < idma64->dma.chancnt; i++) {
>                 struct idma64_chan *idma64c =3D &idma64->chan[i];
>
> -               tasklet_kill(&idma64c->vchan.task);
> +               cancel_work_sync(&idma64c->vchan.work);
>         }
>  }
>
> diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
> index fd55bcd060ab..4fea332497a8 100644
> --- a/drivers/dma/img-mdc-dma.c
> +++ b/drivers/dma/img-mdc-dma.c
> @@ -1031,7 +1031,7 @@ static void mdc_dma_remove(struct platform_device *=
pdev)
>
>                 devm_free_irq(&pdev->dev, mchan->irq, mchan);
>
> -               tasklet_kill(&mchan->vc.task);
> +               cancel_work_sync(&mchan->vc.work);
>         }
>
>         pm_runtime_disable(&pdev->dev);
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 02a85d6f1bea..37a3b60a7b3f 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2427,7 +2427,7 @@ static void sdma_remove(struct platform_device *pde=
v)
>         for (i =3D 0; i < MAX_DMA_CHANNELS; i++) {
>                 struct sdma_channel *sdmac =3D &sdma->channel[i];
>
> -               tasklet_kill(&sdmac->vc.task);
> +               cancel_work_sync(&sdmac->vc.work);
>                 sdma_free_chan_resources(&sdmac->vc.chan);
>         }
>
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index acc2983e28e0..6ff3dd252aa2 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -981,7 +981,7 @@ static void k3_dma_remove(struct platform_device *op)
>
>         list_for_each_entry_safe(c, cn, &d->slave.channels, vc.chan.devic=
e_node) {
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>         }
>         tasklet_kill(&d->task);
>         clk_disable_unprepare(d->clk);
> diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-=
dma.c
> index 255fe7eca212..f5a1c3efad62 100644
> --- a/drivers/dma/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson1-apb-dma.c
> @@ -552,7 +552,7 @@ static void ls1x_dma_chan_remove(struct ls1x_dma *dma=
)
>
>                 if (chan->vc.chan.device =3D=3D &dma->ddev) {
>                         list_del(&chan->vc.chan.device_node);
> -                       tasklet_kill(&chan->vc.task);
> +                       cancel_work_sync(&chan->vc.work);
>                 }
>         }
>  }
> diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-=
cqdma.c
> index 47c8adfdc155..a659484a4ecc 100644
> --- a/drivers/dma/mediatek/mtk-cqdma.c
> +++ b/drivers/dma/mediatek/mtk-cqdma.c
> @@ -895,7 +895,7 @@ static void mtk_cqdma_remove(struct platform_device *=
pdev)
>                 vc =3D &cqdma->vc[i];
>
>                 list_del(&vc->vc.chan.device_node);
> -               tasklet_kill(&vc->vc.task);
> +               cancel_work_sync(&vc->vc.work);
>         }
>
>         /* disable interrupt */
> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-=
hsdma.c
> index fa77bb24a430..dea6dd61b71f 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
> @@ -13,6 +13,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -1020,7 +1021,7 @@ static void mtk_hsdma_remove(struct platform_device=
 *pdev)
>                 vc =3D &hsdma->vc[i];
>
>                 list_del(&vc->vc.chan.device_node);
> -               tasklet_kill(&vc->vc.task);
> +               cancel_work_sync(&vc->vc.work);
>         }
>
>         /* Disable DMA interrupt */
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek=
/mtk-uart-apdma.c
> index 08e15177427b..2e8e8c698fe3 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -312,7 +312,7 @@ static void mtk_uart_apdma_free_chan_resources(struct=
 dma_chan *chan)
>
>         free_irq(c->irq, chan);
>
> -       tasklet_kill(&c->vc.task);
> +       cancel_work_sync(&c->vc.work);
>
>         vchan_free_chan_resources(&c->vc);
>
> @@ -463,7 +463,7 @@ static void mtk_uart_apdma_free(struct mtk_uart_apdma=
dev *mtkd)
>                         struct mtk_chan, vc.chan.device_node);
>
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>         }
>  }
>
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 57cec757d8f5..36e5a7c1d993 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -1055,7 +1055,7 @@ static inline void owl_dma_free(struct owl_dma *od)
>         list_for_each_entry_safe(vchan,
>                                  next, &od->dma.channels, vc.chan.device_=
node) {
>                 list_del(&vchan->vc.chan.device_node);
> -               tasklet_kill(&vchan->vc.task);
> +               cancel_work_sync(&vchan->vc.work);
>         }
>  }
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 249296389771..0db0ad5296e7 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -1218,7 +1218,7 @@ static void pxad_free_channels(struct dma_device *d=
madev)
>         list_for_each_entry_safe(c, cn, &dmadev->channels,
>                                  vc.chan.device_node) {
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>         }
>  }
>
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index bbc3276992bb..b45fa2e6910a 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1373,7 +1373,7 @@ static int bam_dma_probe(struct platform_device *pd=
ev)
>         dma_async_device_unregister(&bdev->common);
>  err_bam_channel_exit:
>         for (i =3D 0; i < bdev->num_channels; i++)
> -               tasklet_kill(&bdev->channels[i].vc.task);
> +               cancel_work_sync(&bdev->channels[i].vc.work);
>  err_tasklet_kill:
>         tasklet_kill(&bdev->task);
>  err_disable_clk:
> @@ -1399,7 +1399,7 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>
>         for (i =3D 0; i < bdev->num_channels; i++) {
>                 bam_dma_terminate_all(&bdev->channels[i].vc.chan);
> -               tasklet_kill(&bdev->channels[i].vc.task);
> +               cancel_work_sync(&bdev->channels[i].vc.work);
>
>                 if (!bdev->channels[i].fifo_virt)
>                         continue;
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index b1f0001cc99c..865d3b35d4e6 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_dma.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
> index 6be54fddcee1..c60a5bc17d99 100644
> --- a/drivers/dma/qcom/qcom_adm.c
> +++ b/drivers/dma/qcom/qcom_adm.c
> @@ -919,7 +919,7 @@ static void adm_dma_remove(struct platform_device *pd=
ev)
>                 /* mask IRQs for this channel/EE pair */
>                 writel(0, adev->regs + ADM_CH_RSLT_CONF(achan->id, adev->=
ee));
>
> -               tasklet_kill(&adev->channels[i].vc.task);
> +               cancel_work_sync(&adev->channels[i].vc.work);
>                 adm_terminate_all(&adev->channels[i].vc.chan);
>         }
>
> diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
> index dc1a9a05252e..619430fcb2f4 100644
> --- a/drivers/dma/sa11x0-dma.c
> +++ b/drivers/dma/sa11x0-dma.c
> @@ -893,7 +893,7 @@ static void sa11x0_dma_free_channels(struct dma_devic=
e *dmadev)
>
>         list_for_each_entry_safe(c, cn, &dmadev->channels, vc.chan.device=
_node) {
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>                 kfree(c);
>         }
>  }
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.=
c
> index 7ad3c29be146..09ea2e27df44 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
>  #include <linux/slab.h>
> @@ -603,7 +604,7 @@ static void sf_pdma_remove(struct platform_device *pd=
ev)
>                 devm_free_irq(&pdev->dev, ch->txirq, ch);
>                 devm_free_irq(&pdev->dev, ch->errirq, ch);
>                 list_del(&ch->vchan.chan.device_node);
> -               tasklet_kill(&ch->vchan.task);
> +               cancel_work_sync(&ch->vchan.work);
>                 tasklet_kill(&ch->done_tasklet);
>                 tasklet_kill(&ch->err_tasklet);
>         }
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 187a090463ce..ac8fd7dd63eb 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1253,7 +1253,7 @@ static void sprd_dma_remove(struct platform_device =
*pdev)
>         list_for_each_entry_safe(c, cn, &sdev->dma_dev.channels,
>                                  vc.chan.device_node) {
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>         }
>
>         of_dma_controller_free(pdev->dev.of_node);
> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index c65ee0c7bfbd..ccedcb744dc5 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
> @@ -733,7 +733,7 @@ static void st_fdma_free(struct st_fdma_dev *fdev)
>         for (i =3D 0; i < fdev->nr_channels; i++) {
>                 fchan =3D &fdev->chans[i];
>                 list_del(&fchan->vchan.chan.device_node);
> -               tasklet_kill(&fchan->vchan.task);
> +               cancel_work_sync(&fchan->vchan.work);
>         }
>  }
>
> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.=
c
> index 917f8e922373..280ea4c32340 100644
> --- a/drivers/dma/stm32/stm32-dma.c
> +++ b/drivers/dma/stm32/stm32-dma.c
> @@ -16,6 +16,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/jiffies.h>
>  #include <linux/list.h>
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma=
3.c
> index 0c6c4258b195..1b2bd9ec8a0a 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dmapool.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdm=
a.c
> index e6d525901de7..dc933851b448 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -18,6 +18,7 @@
>  #include <linux/dmapool.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/jiffies.h>
>  #include <linux/list.h>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 2215ff877bf7..3f7cb334feb2 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -1073,7 +1073,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_=
dev *sdev)
>                 struct sun6i_vchan *vchan =3D &sdev->vchans[i];
>
>                 list_del(&vchan->vc.chan.device_node);
> -               tasklet_kill(&vchan->vc.task);
> +               cancel_work_sync(&vchan->vc.work);
>         }
>  }
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dm=
a.c
> index 4d6fe0efa76e..9b98966444fa 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1279,7 +1279,7 @@ static void tegra_dma_free_chan_resources(struct dm=
a_chan *dc)
>         tegra_dma_terminate_all(dc);
>         synchronize_irq(tdc->irq);
>
> -       tasklet_kill(&tdc->vc.task);
> +       cancel_work_sync(&tdc->vc.work);
>         tdc->config_init =3D false;
>         tdc->slave_id =3D -1;
>         tdc->sid_dir =3D DMA_TRANS_NONE;
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index fad896ff29a2..13d31458afcf 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -793,7 +794,7 @@ static void tegra_adma_free_chan_resources(struct dma=
_chan *dc)
>
>         tegra_adma_terminate_all(dc);
>         vchan_free_chan_resources(&tdc->vc);
> -       tasklet_kill(&tdc->vc.task);
> +       cancel_work_sync(&tdc->vc.work);
>         free_irq(tdc->irq, tdc);
>         pm_runtime_put(tdc2dev(tdc));
>
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 3ed406f08c44..43b59af82753 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2560,7 +2560,7 @@ static void edma_cleanupp_vchan(struct dma_device *=
dmadev)
>         list_for_each_entry_safe(echan, _echan,
>                         &dmadev->channels, vchan.chan.device_node) {
>                 list_del(&echan->vchan.chan.device_node);
> -               tasklet_kill(&echan->vchan.task);
> +               cancel_work_sync(&echan->vchan.work);
>         }
>  }
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index aa2dc762140f..d08766e08182 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4042,12 +4042,12 @@ static void udma_desc_pre_callback(struct virt_dm=
a_chan *vc,
>  }
>
>  /*
> - * This tasklet handles the completion of a DMA descriptor by
> + * This workqueue handles the completion of a DMA descriptor by
>   * calling its callback and freeing it.
>   */
> -static void udma_vchan_complete(struct tasklet_struct *t)
> +static void udma_vchan_complete(struct work_struct *w)
>  {
> -       struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
> +       struct virt_dma_chan *vc =3D from_work(vc, w, work);
>         struct virt_dma_desc *vd, *_vd;
>         struct dmaengine_desc_callback cb;
>         LIST_HEAD(head);
> @@ -4112,7 +4112,7 @@ static void udma_free_chan_resources(struct dma_cha=
n *chan)
>         }
>
>         vchan_free_chan_resources(&uc->vc);
> -       tasklet_kill(&uc->vc.task);
> +       cancel_work_sync(&uc->vc.work);
>
>         bcdma_free_bchan_resources(uc);
>         udma_free_tx_resources(uc);
> @@ -5628,7 +5628,7 @@ static int udma_probe(struct platform_device *pdev)
>                         return -ENOMEM;
>                 vchan_init(&uc->vc, &ud->ddev);
>                 /* Use custom vchan completion handling */
> -               tasklet_setup(&uc->vc.task, udma_vchan_complete);
> +               INIT_WORK(&uc->vc.work, udma_vchan_complete);
>                 init_completion(&uc->teardown_completed);
>                 INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_compl=
etion);
>         }
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 8c023c6e623a..ad80cd5e1820 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1521,7 +1521,7 @@ static void omap_dma_free(struct omap_dmadev *od)
>                         struct omap_chan, vc.chan.device_node);
>
>                 list_del(&c->vc.chan.device_node);
> -               tasklet_kill(&c->vc.task);
> +               cancel_work_sync(&c->vc.work);
>                 kfree(c);
>         }
>  }
> diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
> index ceeb6171c9d1..d8b2e819580a 100644
> --- a/drivers/dma/uniphier-xdmac.c
> +++ b/drivers/dma/uniphier-xdmac.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> index 7961172a780d..5a4d221e54b8 100644
> --- a/drivers/dma/virt-dma.c
> +++ b/drivers/dma/virt-dma.c
> @@ -77,12 +77,12 @@ struct virt_dma_desc *vchan_find_desc(struct virt_dma=
_chan *vc,
>  EXPORT_SYMBOL_GPL(vchan_find_desc);
>
>  /*
> - * This tasklet handles the completion of a DMA descriptor by
> + * This workqueue handles the completion of a DMA descriptor by
>   * calling its callback and freeing it.
>   */
> -static void vchan_complete(struct tasklet_struct *t)
> +static void vchan_complete(struct work_struct *work)
>  {
> -       struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
> +       struct virt_dma_chan *vc =3D from_work(vc, work, work);
>         struct virt_dma_desc *vd, *_vd;
>         struct dmaengine_desc_callback cb;
>         LIST_HEAD(head);
> @@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_=
device *dmadev)
>         INIT_LIST_HEAD(&vc->desc_completed);
>         INIT_LIST_HEAD(&vc->desc_terminated);
>
> -       tasklet_setup(&vc->task, vchan_complete);
> +       INIT_WORK(&vc->work, vchan_complete);
>
>         vc->chan.device =3D dmadev;
>         list_add_tail(&vc->chan.device_node, &dmadev->channels);
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index 59d9eabc8b67..d44ca74d8b7f 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -8,7 +8,7 @@
>  #define VIRT_DMA_H
>
>  #include <linux/dmaengine.h>
> -#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
>
>  #include "dmaengine.h"
>
> @@ -21,7 +21,7 @@ struct virt_dma_desc {
>
>  struct virt_dma_chan {
>         struct dma_chan chan;
> -       struct tasklet_struct task;
> +       struct work_struct work;
>         void (*desc_free)(struct virt_dma_desc *);
>
>         spinlock_t lock;
> @@ -106,7 +106,7 @@ static inline void vchan_cookie_complete(struct virt_=
dma_desc *vd)
>                  vd, cookie);
>         list_add_tail(&vd->node, &vc->desc_completed);
>
> -       tasklet_schedule(&vc->task);
> +       queue_work(system_bh_wq, &vc->work);
>  }
>
>  /**
> @@ -137,7 +137,7 @@ static inline void vchan_cyclic_callback(struct virt_=
dma_desc *vd)
>         struct virt_dma_chan *vc =3D to_virt_chan(vd->tx.chan);
>
>         vc->cyclic =3D vd;
> -       tasklet_schedule(&vc->task);
> +       queue_work(system_bh_wq, &vc->work);
>  }
>
>  /**
> @@ -223,7 +223,7 @@ static inline void vchan_synchronize(struct virt_dma_=
chan *vc)
>         LIST_HEAD(head);
>         unsigned long flags;
>
> -       tasklet_kill(&vc->task);
> +       cancel_work_sync(&vc->work);
>
>         spin_lock_irqsave(&vc->lock, flags);
>
> --
> 2.43.0
>


--=20
Best regards,

Keguang Zhang

