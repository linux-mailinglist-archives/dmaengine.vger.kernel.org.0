Return-Path: <dmaengine+bounces-2028-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1F8C46B9
	for <lists+dmaengine@lfdr.de>; Mon, 13 May 2024 20:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF0A286E02
	for <lists+dmaengine@lfdr.de>; Mon, 13 May 2024 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9D2E414;
	Mon, 13 May 2024 18:12:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651482D7B8;
	Mon, 13 May 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623961; cv=none; b=V7hRdfZm+Ow2Y8x/mKJtwvRaMfFIR0AHhmQd/nxCSzRV1dkhF2XdHfKecAAHgUYMWgSIl6DQXfa6yUacl+g1yRR8HWJ019ZnFvzpsiy6NkwYvP0naqADc4hsDmYebgchO/FU2do73dJfBVsWGCMJ+bv+mvt/ZH8Dra8sVQbWxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623961; c=relaxed/simple;
	bh=V8O8b/a/9SKnu8BvsqCHZuN34e3VNtVB8eSNq1AvVvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/R0Txy2Oxm70yIIpR6PWmmTxES6qhGxfkcr2eMIyzvPcygbViCxAS6hq2kcPkY7X2FgYrz3HXkeKKf+kHspaTSdXTm2CCcM50lSJiCfF51YWLbKkarpkuq6CyQ7TygdZVJr3HxI4Z3+2AcqUQ73CJ49Wrmd3d189P1NzYD7TIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62027fcf9b1so40040377b3.0;
        Mon, 13 May 2024 11:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623956; x=1716228756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz8i2MYQZHxasbjZ1GiJBGuINHDKmK9M19imzVTEtiM=;
        b=GjYJWsjw34hMqYJdHYnj9iOD4bJ13aTk/D7U3CV0oOz7dtDSrY8CugW7pT71xKwwg1
         vlp1rdhzHsDUMRdFw0HMoZ5uSq7eLVKQI/zF3L9ZZI38UrPpc5n78AkJCYFFhoB/1F3M
         HZiGlKXHjp1AmOU0bN6eHp5LGkgLsaBCfl6ZyVKe/O/ryc4VHeU51k+/J8OUobnEAEoJ
         nM0B2DjELHeVBD5Yu42NHkzqiRKSQFEotkLQKqVnhH9JIL11S0rFp2HVwXDRgoZJz9Hl
         RhVcK2N6TDgGHKQeQCOJ9jzNB4YfqIopA4uzL4IiyOsZUjCtZ+ZOwHOeU3ybfpDs6Rmc
         P+bg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHV+TF8IHMiDOVL/HHM8EFSQOtXnygO65soeNRIewbSKq/D+wctDHD8ZeEOcvIF89gcBO2fCoqni1+oj/4Zq3IEfpqacAnzE0FxzeO58AcYVLA1xGd2ctefOe+f5XkxdFuUPbJruI
X-Gm-Message-State: AOJu0Yxh8HC+myC6Fe5Cxp8gQWlFIFbkyoxvAyqYDlYDxnX5CW8ebxEf
	lhPHgzGk7jzgLKbKVzSrytRfm3abhnFbblAHnzuCdF3dTVaLLe7uZ3f+/wKI
X-Google-Smtp-Source: AGHT+IEXH51TPp972li10uXpYku/Ng6SgrQ88gqr1qbeucLcvDzmwD+csl1tgZrLHBLXaJACLh6d4Q==
X-Received: by 2002:a81:b60a:0:b0:622:c892:6ae7 with SMTP id 00721157ae682-622c8926aeamr49035177b3.12.1715623956114;
        Mon, 13 May 2024 11:12:36 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e346ee8sm22021357b3.77.2024.05.13.11.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 11:12:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3489207276.1;
        Mon, 13 May 2024 11:12:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkx9Eg2hkv2U2qLMZAl+y20NagNFJxdD0rsqjeq4THUWJkmWeeSr1gyqslXri10FeJuEppYInk0uqZ3BiMP0u+vVb8Sr1Mhud8y+WWphc5N5k4PAdRUw4qfKPY0TARTqeJwQotzg2G
X-Received: by 2002:a25:8503:0:b0:dc2:2f3f:2148 with SMTP id
 3f1490d57ef6-dee4e57066cmr7440441276.29.1715623955117; Mon, 13 May 2024
 11:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509193517.3571694-1-Frank.Li@nxp.com>
In-Reply-To: <20240509193517.3571694-1-Frank.Li@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 May 2024 20:12:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVB2PrkxDMoo0y1y6SLj-yuW5o+PJ+sQn2VtB2yrXzkbw@mail.gmail.com>
Message-ID: <CAMuHMdVB2PrkxDMoo0y1y6SLj-yuW5o+PJ+sQn2VtB2yrXzkbw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: merge mcf-edma into fsl-edma driver
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>, Greg Ungerer <gerg@linux-m68k.org>, 
	Angelo Dureghello <angelo@kernel-space.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC coldfire

On Thu, May 9, 2024 at 9:35=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
> MCF eDMA are almost the same as FSL eDMA driver. Previously link to two
> kernel modules, fsl-edma.ko and mcf-edma.ko. These are not problem becaus=
e
> mcf-edma is for m68k ARCH and FSL eDMA is for arm/arm64 ARCH. But often
> build both at PPC ARCH. It also makes sense to build two drivers at the
> same time. It causes many build warning because share a fsl-edma-common.o=
.
> such as:
>
>    powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/d=
ma/fsl-edma-common.o' being placed in section `.stubs'
>    powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/d=
ma/fsl-edma-trace.o' being placed in section `.stubs'
>
> Merge mcf-edma into fsl-edma driver. So use one driver (fsl-edma.ko) for
> MCF and FSL eDMA.
>
> mcf-edma.ko should be replaced by fsl-edma.ko in modules, minimizing user
> space impact because MCF eDMA remains confined to legacy ColdFire mcf5441=
x
> production and mcf5441x has been in production for at least a decade and
> NXP has long ceased ColdFire development.
>
> Update Kconfig to make MCF_EDMA as feature of FSL_EDMA and change Makefil=
e
> to link mcl-edma-main.o to fsl-edma.o.
>
> Create a common module init/exit functions, which call original's
> fsl-edma-init[exit]() and mcf-edma-init[exit]().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405082029.Es9umH7n-lkp@i=
ntel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/Kconfig           |  8 ++++----
>  drivers/dma/Makefile          |  5 ++---
>  drivers/dma/fsl-edma-common.c | 28 ++++++++++++++++++++++++++++
>  drivers/dma/fsl-edma-common.h |  5 +++++
>  drivers/dma/fsl-edma-main.c   |  6 ++----
>  drivers/dma/mcf-edma-main.c   |  6 ++----
>  6 files changed, 43 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 002a5ec806207..45110520f6e68 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -393,14 +393,14 @@ config LS2X_APB_DMA
>           It does not support memory to memory data transfer.
>
>  config MCF_EDMA
> -       tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
> +       bool "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
>         depends on M5441x || COMPILE_TEST
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS
>         help
> -         Support the Freescale ColdFire eDMA engine, 64-channel
> -         implementation that performs complex data transfers with
> -         minimal intervention from a host processor.
> +         Support the Freescale ColdFire eDMA engine in FSL_EDMA driver,
> +         64-channel implementation that performs complex data transfers
> +         with minimal intervention from a host processor.
>           This module can be found on Freescale ColdFire mcf5441x SoCs.
>
>  config MILBEAUT_HDMAC
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 802ca916f05f5..0000922c7cbfe 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -33,11 +33,10 @@ obj-$(CONFIG_DW_EDMA) +=3D dw-edma/
>  obj-$(CONFIG_EP93XX_DMA) +=3D ep93xx_dma.o
>  fsl-edma-trace-$(CONFIG_TRACING) :=3D fsl-edma-trace.o
>  CFLAGS_fsl-edma-trace.o :=3D -I$(src)
> +mcf-edma-main-$(CONFIG_MCF_EDMA) :=3D mcf-edma-main.o
>  obj-$(CONFIG_FSL_DMA) +=3D fsldma.o
> -fsl-edma-objs :=3D fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
> +fsl-edma-objs :=3D fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}=
 ${mcf-edma-main-y}
>  obj-$(CONFIG_FSL_EDMA) +=3D fsl-edma.o
> -mcf-edma-objs :=3D mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
> -obj-$(CONFIG_MCF_EDMA) +=3D mcf-edma.o
>  obj-$(CONFIG_FSL_QDMA) +=3D fsl-qdma.o
>  obj-$(CONFIG_FSL_RAID) +=3D fsl_raid.o
>  obj-$(CONFIG_HISI_DMA) +=3D hisi_dma.o
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.=
c
> index 3af4307873157..ac04a2ce4fa1f 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -888,4 +888,32 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edm=
a)
>         }
>  }
>
> +static int __init fsl_edma_common_init(void)
> +{
> +       int ret;
> +
> +       ret =3D fsl_edma_init();
> +       if (ret)
> +               return ret;
> +
> +#ifdef CONFIG_MCF_EDMA
> +       ret =3D mcf_edma_init();
> +       if (ret)
> +               return ret;
> +#endif
> +       return 0;
> +}
> +
> +subsys_initcall(fsl_edma_common_init);
> +
> +static void __exit fsl_edma_common_exit(void)
> +{
> +       fsl_edma_exit();
> +
> +#ifdef CONFIG_MCF_EDMA
> +       mcf_edma_exit();
> +#endif
> +}
> +module_exit(fsl_edma_common_exit);
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.=
h
> index ac66222c16040..dfbdcc922ceea 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -488,4 +488,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *ch=
an);
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
>  void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
>
> +int __init fsl_edma_init(void);
> +void __exit fsl_edma_exit(void);
> +int __init mcf_edma_init(void);
> +void __exit mcf_edma_exit(void);
> +
>  #endif /* _FSL_EDMA_COMMON_H_ */
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 391e4f13dfeb0..a1c3c4ed869c5 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -724,17 +724,15 @@ static struct platform_driver fsl_edma_driver =3D {
>         .remove_new     =3D fsl_edma_remove,
>  };
>
> -static int __init fsl_edma_init(void)
> +int __init fsl_edma_init(void)
>  {
>         return platform_driver_register(&fsl_edma_driver);
>  }
> -subsys_initcall(fsl_edma_init);
>
> -static void __exit fsl_edma_exit(void)
> +void __exit fsl_edma_exit(void)
>  {
>         platform_driver_unregister(&fsl_edma_driver);
>  }
> -module_exit(fsl_edma_exit);
>
>  MODULE_ALIAS("platform:fsl-edma");
>  MODULE_DESCRIPTION("Freescale eDMA engine driver");
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 78c606f6d0026..d97991a1e9518 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -284,17 +284,15 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void=
 *param)
>  }
>  EXPORT_SYMBOL(mcf_edma_filter_fn);
>
> -static int __init mcf_edma_init(void)
> +int __init mcf_edma_init(void)
>  {
>         return platform_driver_register(&mcf_edma_driver);
>  }
> -subsys_initcall(mcf_edma_init);
>
> -static void __exit mcf_edma_exit(void)
> +void __exit mcf_edma_exit(void)
>  {
>         platform_driver_unregister(&mcf_edma_driver);
>  }
> -module_exit(mcf_edma_exit);
>
>  MODULE_ALIAS("platform:mcf-edma");
>  MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
> --
> 2.34.1

