Return-Path: <dmaengine+bounces-1700-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBF8950E3
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 12:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CACE1C232B1
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119BC604C8;
	Tue,  2 Apr 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSTsAQW3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C775F873;
	Tue,  2 Apr 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055093; cv=none; b=JPMZSH/lA6MWGWhABEAzv+RbpdwH38FpoCElXgOHz1miEZjyYY537Znhwn3eC+zhq6VT6/NgMxzOg/TfAdDMjLZpWDjIxHijexN3ZNJom+ohQwTcLwfeCzH7QRl1bAo2UOHR9Mhl2KcEU/93Q+lbIjyJj2sc6bXID/tLzSaCNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055093; c=relaxed/simple;
	bh=QRObyKBYDLpvGf4SkVcB1YY26VA1G94YGJpzm6GNEfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmrJiW/AsYTbQr3cbWhkAHDGjArW/ljFZM1+f5Zp3hKP5s3us8L2KdoAH9CKltuU6H4dCgEi/Al6oWtoLsbXC5INxyE2MTeoF6n2xe7tztuHkFXpbqdjb65RYGJVfgf/Oo85UUobyjPd0K1/SkS58/FJhY3ckvUYSvaG4sC00Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSTsAQW3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so7239752a12.0;
        Tue, 02 Apr 2024 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712055088; x=1712659888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siG88n1H19g8GWod/0z+EKACNA0oGaIy+1N8DU9AEcg=;
        b=fSTsAQW3GbtGHCaOJS7KPQjPRCxwgFo2JinJKNFwPAWnasVutuZD7e3HJF/mDROOs6
         l5swX6gIeKDeWCb6Tc2LWB+Cfgf94OlsKTsH8zdD6+RhmbclLTdrY/MnwwjGnGuEB3yW
         7PucFUmc8cKFjV4GClhN1YuW4RBrm/4cD5FzHS26//mI0BOtXrnSk0Z91cNpPH+NtMqq
         362RwpAOdSZ/rG3P0RmglXBDaNCb7NcrZRDGC2gquX6PRSEQf5tOBWIaBIwvUtGH06Yi
         zDndTVvsSb4iRTnt0dpeT1mnW/rSSwAAj8gEIuylGBVSa9WHJfACYSfYeBpR43w8zYn6
         vURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055088; x=1712659888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siG88n1H19g8GWod/0z+EKACNA0oGaIy+1N8DU9AEcg=;
        b=bHm+57kmUMVLAJSb63Fb7zE4KNRIHnJf23VATEGctw/UdoZ483zdHXhyedHWPn/iw5
         TnHZQNC+XfXaJrlHDIrKnD7qGV8PTW+YcZOH/sn6t3xOs3F1+acUZwBXmbCnx8NIAKqi
         eNDsIqOJL1HoZzrXvCk6Ov0qdzwKRRzA6CuyuWM8RXeeAh5EkX578y8WQfSzYI87HIkG
         AnJw44KLFnsQpFwm7iMnJiQ0vSKerBOWu/MEgNAIWUDvLO0RqFia1J48CETXO6zUnv4T
         hDOpX9SAhJoJMDzSji8lXPrfdNsNyCx7XplxcbPD21m1JtaNkeNfjQHsNYyGXNzJ3I+n
         Oftg==
X-Forwarded-Encrypted: i=1; AJvYcCWoyNr0NpMALyyxIFhK3HuYr+R+/x6iO3ZtL0BY3KLCcAJt5n4mOBQfFzhjf2sjL+vloFMk8HUquHvF9OE/1bd1jm1WQ+quflr2uS3QjCN+rAW3SnsVyn+T7xeWFwo2skoMhrs6VZVfIgCwxUo8mfYz4dh+UY7fK60omvwY0AcC1fVc/dEKLv0HSZpJ41MzfimPrXot0XFL5RmpO8xcTc8=
X-Gm-Message-State: AOJu0YzsB+gIkX3x4vpMqqjlg12o9bqCnA7CPHBRsvJswDHS0WrjsiXN
	8ImD7o6AG6YwjNebWdGAT7xpSlgi/cIHzFSh/NEyYu/TNHPXa2dmlj2zrG/eZmsYQuzZmQunWAC
	vWhCy/mXwXl0QKjTUcOMebxFJvnE=
X-Google-Smtp-Source: AGHT+IEcViv6lDVB8Y0J2jbZwQrlRsqBMjdz7BMO5P/3YeCehofmXIegc8Mof5KarpMVq3IwjJ0MbP9y/K6fVUl2/X4=
X-Received: by 2002:a05:6402:3591:b0:56d:f937:9656 with SMTP id
 y17-20020a056402359100b0056df9379656mr33567edc.9.1712055087459; Tue, 02 Apr
 2024 03:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
 <20240329-loongson1-dma-v7-2-37db58608de5@gmail.com> <CAAhV-H6gG5KGxku+aZPwfmqAVF9zfL-9-nNqCd2Z_swxgCe_HA@mail.gmail.com>
 <CAJhJPsXutxdZkhjWdc-JuJOaC_6+6zsDjbYT1Bg6Yuk8AQX1ug@mail.gmail.com>
 <CAAhV-H63wMMhVng=kn+XOHFL8sTchtGAMae0v50FEN6TO1kAhw@mail.gmail.com>
 <CAJhJPsUW14vMAAhGTobCkSnYytwtUbdsZ5V9p33fzdnr3=L2Ag@mail.gmail.com>
 <CAAhV-H4TH+DbC2XsvysS7yH+M99qhHdpADACGdM0Q83FztSvFg@mail.gmail.com>
 <CAJhJPsU6agzBR1jOw73SpMoogUMYu0qQT2VaBa+z1DXw2ZPNvw@mail.gmail.com> <CAAhV-H5uLcfaNYb7GAF17ruhJ02Wv71VZYEnxM_a642cuYaSBw@mail.gmail.com>
In-Reply-To: <CAAhV-H5uLcfaNYb7GAF17ruhJ02Wv71VZYEnxM_a642cuYaSBw@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 2 Apr 2024 18:50:50 +0800
Message-ID: <CAJhJPsWNuFMPEgDGsjdUdE1gYO3eVWLQ0QbYMXRTaMHv5bz9Ug@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:04=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> On Tue, Apr 2, 2024 at 9:56=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > On Mon, Apr 1, 2024 at 9:24=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> > >
> > > On Mon, Apr 1, 2024 at 7:10=E2=80=AFPM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > > >
> > > > On Mon, Apr 1, 2024 at 5:06=E2=80=AFPM Huacai Chen <chenhuacai@kern=
el.org> wrote:
> > > > >
> > > > > On Mon, Apr 1, 2024 at 10:45=E2=80=AFAM Keguang Zhang <keguang.zh=
ang@gmail.com> wrote:
> > > > > >
> > > > > > Hi Huacai,
> > > > > >
> > > > > > On Sat, Mar 30, 2024 at 9:59=E2=80=AFPM Huacai Chen <chenhuacai=
@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi, Keguang,
> > > > > > >
> > > > > > > On Fri, Mar 29, 2024 at 7:28=E2=80=AFPM Keguang Zhang via B4 =
Relay
> > > > > > > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > > > > > > >
> > > > > > > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > > > > > > >
> > > > > > > > This patch adds APB DMA driver for Loongson-1 SoCs.
> > > > > > > >
> > > > > > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > > > > > ---
> > > > > > > > Changes in v7:
> > > > > > > > - Change the comptible to 'loongson,ls1*-apbdma'
> > > > > > > > - Update Kconfig and Makefile accordingly
> > > > > > > > - Rename the file to loongson1-apb-dma.c to keep the consis=
tency
> > > > > > > >
> > > > > > > > Changes in v6:
> > > > > > > > - Implement .device_prep_dma_cyclic for Loongson1 audio dri=
ver,
> > > > > > > > - as well as .device_pause and .device_resume.
> > > > > > > > - Set the limitation LS1X_DMA_MAX_DESC and put all descript=
ors
> > > > > > > > - into one page to save memory
> > > > > > > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > > > > > > > - Drop dma_slave_config structure
> > > > > > > > - Use .remove_new instead of .remove
> > > > > > > > - Use KBUILD_MODNAME for the driver name
> > > > > > > > - Improve the debug information
> > > > > > > >
> > > > > > > > Changes in v5:
> > > > > > > > - Add DT support
> > > > > > > > - Use DT data instead of platform data
> > > > > > > > - Use chan_id of struct dma_chan instead of own id
> > > > > > > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter(=
)
> > > > > > > > - Update the author information to my official name
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Use dma_slave_map to find the proper channel.
> > > > > > > > - Explicitly call devm_request_irq() and tasklet_kill().
> > > > > > > > - Fix namespace issue.
> > > > > > > > - Some minor fixes and cleanups.
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA'=
,
> > > > > > > > - and rearrange it in alphabetical order in Kconfig and Mak=
efile.
> > > > > > > > - Fix comment style.
> > > > > > > > ---
> > > > > > > >  drivers/dma/Kconfig             |   9 +
> > > > > > > >  drivers/dma/Makefile            |   1 +
> > > > > > > >  drivers/dma/loongson1-apb-dma.c | 665 ++++++++++++++++++++=
++++++++++++++++++++
> > > > > > > >  3 files changed, 675 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > > > > > > index 002a5ec80620..f7b06c4cdf3f 100644
> > > > > > > > --- a/drivers/dma/Kconfig
> > > > > > > > +++ b/drivers/dma/Kconfig
> > > > > > > > @@ -369,6 +369,15 @@ config K3_DMA
> > > > > > > >           Support the DMA engine for Hisilicon K3 platform
> > > > > > > >           devices.
> > > > > > > >
> > > > > > > > +config LOONGSON1_APB_DMA
> > > > > > > > +       tristate "Loongson1 APB DMA support"
> > > > > > > > +       depends on MACH_LOONGSON32 || COMPILE_TEST
> > > > > > > > +       select DMA_ENGINE
> > > > > > > > +       select DMA_VIRTUAL_CHANNELS
> > > > > > > > +       help
> > > > > > > > +         This selects support for the APB DMA controller i=
n Loongson1 SoCs,
> > > > > > > > +         which is required by Loongson1 NAND and audio sup=
port.
> > > > > > > Why not rename to LS1X_APB_DMA and put it just before LS2X_AP=
B_DMA
> > > > > > > (and also the driver file name)?
> > > > > > >
> > > > > > So far all Kconfig entries of Loongson-1 drivers are named with=
 the
> > > > > > keyword "LOONGSON1".
> > > > > > The same is true for these file names.
> > > > > > Therefore, I need to keep the consistency.
> > > > > But I see LS1X_IRQ in drivers/irqchip/Kconfig
> > > > >
> > > > Indeed, that's an exception, which was submitted by Jiaxun several =
years ago.
> > > > Actually, most drivers of Loongson family use the keyword "LOONGSON=
"
> > > > for Kconfig and "loongson" for filename.
> > > > Thus I take this keywork as the naming convention.
> > > But I think keeping consistency in a same subsystem is better than
> > > keeping consistency in a same SoC (but cross subsystems).
> > >
> > In my opinion, "LS*X" is too short and may be confused with other SoCs.
> > Meanwhile, there are only four drivers that use this keyword.
> >   config I2C_LS2X
> >   config LS2K_RESET
> >   config LS2X_APB_DMA
> >   config LS1X_IRQ
> > Then, my suggestion is to change these "LS*X" to "LOONGSON*" to get a
> > clear meaning.
> We have made a naming conversion some years before with Jiaxun.
> 1, Use "Loongson" for CPU in arch code;
> 2, Use "LS7A" or something like this for bridges and devices.
> 3, For drivers in SoC, if the driver is specific to Loongson-1, use
> LS1X, if it is to Loongson-2, use LS2X, if it is shared by both
> Loongson-1 and Loongson-2, use LOONGSON.
>
OK. But the doesn't the answer the question of confusion, such as
"Freescale LS1021A".
The same problem happens to the filenames.
  ./drivers/gpu/drm/nouveau/nvkm/nvfw/ls.c
  ./drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
  ./drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
  ./drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
  ./arch/powerpc/platforms/embedded6xx/ls_uart.c
Regarding "LS*X" itself, it contains the wildcard character "X" which
itself is confusing.
Therefore, I don't think "LS*X" is clear enough.

On the other hand, I see "LOONGSON2_*" strings are still there.
In addition, some of "LOONGSON_" definitions are not applicable for
Loongson-1 at all, which breaks your convention.
  config SND_SOC_LOONGSON_I2S_PCI  /* Loongson-1 doesn't support I2S */
  config SND_SOC_LOONGSON_CARD
  config DWMAC_LOONGSON1
  config DWMAC_LOONGSON  /* This glue layer doesn't support Loongson-1 */
  config COMMON_CLK_LOONGSON2
  config RTC_DRV_LOONGSON
  config SPI_LOONGSON_CORE
  config SPI_LOONGSON_PCI  /* N/A for Loongson-1 */
  config SPI_LOONGSON_PLATFORM
  config LOONGSON2_CPUFREQ
  config DRM_LOONGSON  /* N/A for Loongson-1 */
  config LOONGSON1_WDT
  config CLKSRC_LOONGSON1_PWM
  config LOONGSON_LIOINTC  /* N/A for Loongson-1 */
  config LOONGSON_EIOINTC  /* N/A for Loongson-1 */
  config LOONGSON_HTPIC  /* N/A for Loongson-1 */
  config LOONGSON_HTVEC  /* N/A for Loongson-1 */
  config LOONGSON_PCH_PIC  /* N/A for Loongson-1 */
  config LOONGSON_PCH_MSI  /* N/A for Loongson-1 */
  config LOONGSON_PCH_LPC  /* N/A for Loongson-1 */
  config PINCTRL_LOONGSON2
  config LOONGSON2_THERMAL
  config LOONGSON2_GUTS
  config LOONGSON2_PM
  config LOONGSON_LAPTOP  /* N/A for Loongson-1 */
  config GPIO_LOONGSON
  config GPIO_LOONGSON_64BIT  -> N/A for Loongson-1
  config GPIO_LOONGSON1
  config PCI_LOONGSON

What's your plan about the above Kconfig entries?
Why can't we use LOONGSON1/LOONGSON2 for drivers?


> Huacai
>
> >
> > > Huacai
> > >
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > >
> > > > > > > Huacai
> > > > > > >
> > > > > > > > +
> > > > > > > >  config LPC18XX_DMAMUX
> > > > > > > >         bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > > > > > > >         depends on ARCH_LPC18XX || COMPILE_TEST
> > > > > > > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > > > > > > > index dfd40d14e408..b26f6677978a 100644
> > > > > > > > --- a/drivers/dma/Makefile
> > > > > > > > +++ b/drivers/dma/Makefile
> > > > > > > > @@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
> > > > > > > >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> > > > > > > >  obj-y +=3D idxd/
> > > > > > > >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > > > > > > > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > > > > > > >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > > > > > > >  obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> > > > > > > >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > > > > > > > diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/=
loongson1-apb-dma.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..d474a2601e6e
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/dma/loongson1-apb-dma.c
> > > > > > > > @@ -0,0 +1,665 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > +/*
> > > > > > > > + * Driver for Loongson-1 APB DMA Controller
> > > > > > > > + *
> > > > > > > > + * Copyright (C) 2015-2024 Keguang Zhang <keguang.zhang@gm=
ail.com>
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include <linux/dmapool.h>
> > > > > > > > +#include <linux/dma-mapping.h>
> > > > > > > > +#include <linux/init.h>
> > > > > > > > +#include <linux/interrupt.h>
> > > > > > > > +#include <linux/iopoll.h>
> > > > > > > > +#include <linux/module.h>
> > > > > > > > +#include <linux/of.h>
> > > > > > > > +#include <linux/of_dma.h>
> > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > +#include <linux/slab.h>
> > > > > > > > +
> > > > > > > > +#include "dmaengine.h"
> > > > > > > > +#include "virt-dma.h"
> > > > > > > > +
> > > > > > > > +/* Loongson-1 DMA Control Register */
> > > > > > > > +#define DMA_CTRL                       0x0
> > > > > > > > +
> > > > > > > > +/* DMA Control Register Bits */
> > > > > > > > +#define DMA_STOP                       BIT(4)
> > > > > > > > +#define DMA_START                      BIT(3)
> > > > > > > > +#define DMA_ASK_VALID                  BIT(2)
> > > > > > > > +
> > > > > > > > +#define DMA_ADDR_MASK                  GENMASK(31, 6)
> > > > > > > > +
> > > > > > > > +/* DMA Next Field Bits */
> > > > > > > > +#define DMA_NEXT_VALID                 BIT(0)
> > > > > > > > +
> > > > > > > > +/* DMA Command Field Bits */
> > > > > > > > +#define DMA_RAM2DEV                    BIT(12)
> > > > > > > > +#define DMA_INT                                BIT(1)
> > > > > > > > +#define DMA_INT_MASK                   BIT(0)
> > > > > > > > +
> > > > > > > > +#define LS1X_DMA_MAX_CHANNELS          3
> > > > > > > > +
> > > > > > > > +/* Size of allocations for hardware descriptors */
> > > > > > > > +#define LS1X_DMA_DESCS_SIZE            PAGE_SIZE
> > > > > > > > +#define LS1X_DMA_MAX_DESC              \
> > > > > > > > +       (LS1X_DMA_DESCS_SIZE / sizeof(struct ls1x_dma_hwdes=
c))
> > > > > > > > +
> > > > > > > > +struct ls1x_dma_hwdesc {
> > > > > > > > +       u32 next;               /* next descriptor address =
*/
> > > > > > > > +       u32 saddr;              /* memory DMA address */
> > > > > > > > +       u32 daddr;              /* device DMA address */
> > > > > > > > +       u32 length;
> > > > > > > > +       u32 stride;
> > > > > > > > +       u32 cycles;
> > > > > > > > +       u32 cmd;
> > > > > > > > +       u32 stats;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct ls1x_dma_desc {
> > > > > > > > +       struct virt_dma_desc vdesc;
> > > > > > > > +       enum dma_transfer_direction dir;
> > > > > > > > +       enum dma_transaction_type type;
> > > > > > > > +       unsigned int bus_width;
> > > > > > > > +
> > > > > > > > +       unsigned int nr_descs;  /* number of descriptors */
> > > > > > > > +
> > > > > > > > +       struct ls1x_dma_hwdesc *hwdesc;
> > > > > > > > +       dma_addr_t hwdesc_phys;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct ls1x_dma_chan {
> > > > > > > > +       struct virt_dma_chan vchan;
> > > > > > > > +       struct dma_pool *desc_pool;
> > > > > > > > +       phys_addr_t src_addr;
> > > > > > > > +       phys_addr_t dst_addr;
> > > > > > > > +       enum dma_slave_buswidth src_addr_width;
> > > > > > > > +       enum dma_slave_buswidth dst_addr_width;
> > > > > > > > +
> > > > > > > > +       void __iomem *reg_base;
> > > > > > > > +       int irq;
> > > > > > > > +
> > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > +
> > > > > > > > +       struct ls1x_dma_hwdesc *curr_hwdesc;
> > > > > > > > +       dma_addr_t curr_hwdesc_phys;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct ls1x_dma {
> > > > > > > > +       struct dma_device ddev;
> > > > > > > > +       void __iomem *reg_base;
> > > > > > > > +
> > > > > > > > +       unsigned int nr_chans;
> > > > > > > > +       struct ls1x_dma_chan chan[];
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +#define to_ls1x_dma_chan(dchan)                \
> > > > > > > > +       container_of(dchan, struct ls1x_dma_chan, vchan.cha=
n)
> > > > > > > > +
> > > > > > > > +#define to_ls1x_dma_desc(vd)           \
> > > > > > > > +       container_of(vd, struct ls1x_dma_desc, vdesc)
> > > > > > > > +
> > > > > > > > +/* macros for registers read/write */
> > > > > > > > +#define chan_readl(chan, off)          \
> > > > > > > > +       readl((chan)->reg_base + (off))
> > > > > > > > +
> > > > > > > > +#define chan_writel(chan, off, val)    \
> > > > > > > > +       writel((val), (chan)->reg_base + (off))
> > > > > > > > +
> > > > > > > > +static inline struct device *chan2dev(struct dma_chan *cha=
n)
> > > > > > > > +{
> > > > > > > > +       return &chan->dev->device;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static inline int ls1x_dma_query(struct ls1x_dma_chan *cha=
n,
> > > > > > > > +                                dma_addr_t *hwdesc_phys)
> > > > > > > > +{
> > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > +       int val, ret;
> > > > > > > > +
> > > > > > > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > > > > > > +       val |=3D DMA_ASK_VALID;
> > > > > > > > +       val |=3D dchan->chan_id;
> > > > > > > > +       chan_writel(chan, DMA_CTRL, val);
> > > > > > > > +       ret =3D readl_poll_timeout_atomic(chan->reg_base + =
DMA_CTRL, val,
> > > > > > > > +                                       !(val & DMA_ASK_VAL=
ID), 0, 3000);
> > > > > > > > +       if (ret)
> > > > > > > > +               dev_err(chan2dev(dchan), "failed to query D=
MA\n");
> > > > > > > > +
> > > > > > > > +       return ret;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static inline int ls1x_dma_start(struct ls1x_dma_chan *cha=
n,
> > > > > > > > +                                dma_addr_t *hwdesc_phys)
> > > > > > > > +{
> > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > +       int val, ret;
> > > > > > > > +
> > > > > > > > +       dev_dbg(chan2dev(dchan), "cookie=3D%d, starting hwd=
esc=3D%x\n",
> > > > > > > > +               dchan->cookie, *hwdesc_phys);
> > > > > > > > +
> > > > > > > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > > > > > > +       val |=3D DMA_START;
> > > > > > > > +       val |=3D dchan->chan_id;
> > > > > > > > +       chan_writel(chan, DMA_CTRL, val);
> > > > > > > > +       ret =3D readl_poll_timeout(chan->reg_base + DMA_CTR=
L, val,
> > > > > > > > +                                !(val & DMA_START), 0, 300=
0);
> > > > > > > > +       if (ret)
> > > > > > > > +               dev_err(chan2dev(dchan), "failed to start D=
MA\n");
> > > > > > > > +
> > > > > > > > +       return ret;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static inline void ls1x_dma_stop(struct ls1x_dma_chan *cha=
n)
> > > > > > > > +{
> > > > > > > > +       chan_writel(chan, DMA_CTRL, chan_readl(chan, DMA_CT=
RL) | DMA_STOP);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void ls1x_dma_free_chan_resources(struct dma_chan *=
dchan)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +
> > > > > > > > +       dma_free_coherent(chan2dev(dchan), sizeof(struct ls=
1x_dma_hwdesc),
> > > > > > > > +                         chan->curr_hwdesc, chan->curr_hwd=
esc_phys);
> > > > > > > > +       vchan_free_chan_resources(&chan->vchan);
> > > > > > > > +       dma_pool_destroy(chan->desc_pool);
> > > > > > > > +       chan->desc_pool =3D NULL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_alloc_chan_resources(struct dma_chan *=
dchan)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +
> > > > > > > > +       chan->desc_pool =3D dma_pool_create(dma_chan_name(d=
chan),
> > > > > > > > +                                         chan2dev(dchan),
> > > > > > > > +                                         sizeof(struct ls1=
x_dma_hwdesc),
> > > > > > > > +                                         __alignof__(struc=
t ls1x_dma_hwdesc),
> > > > > > > > +                                         0);
> > > > > > > > +       if (!chan->desc_pool)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       /* allocate memory for querying current HW descript=
or */
> > > > > > > > +       dma_set_coherent_mask(chan2dev(dchan), DMA_BIT_MASK=
(32));
> > > > > > > > +       chan->curr_hwdesc =3D dma_alloc_coherent(chan2dev(d=
chan),
> > > > > > > > +                                              sizeof(struc=
t ls1x_dma_hwdesc),
> > > > > > > > +                                              &chan->curr_=
hwdesc_phys,
> > > > > > > > +                                              GFP_KERNEL);
> > > > > > > > +       if (!chan->curr_hwdesc)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc=
)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_desc *desc =3D to_ls1x_dma_desc(vde=
sc);
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(vde=
sc->tx.chan);
> > > > > > > > +
> > > > > > > > +       dma_pool_free(chan->desc_pool, desc->hwdesc, desc->=
hwdesc_phys);
> > > > > > > > +       chan->desc =3D NULL;
> > > > > > > > +       kfree(desc);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct ls1x_dma_desc *
> > > > > > > > +ls1x_dma_alloc_desc(struct dma_chan *dchan, int sg_len,
> > > > > > > > +                   enum dma_transfer_direction direction,
> > > > > > > > +                   enum dma_transaction_type type)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > +
> > > > > > > > +       if (sg_len > LS1X_DMA_MAX_DESC) {
> > > > > > > > +               dev_err(chan2dev(dchan), "sg_len %u exceeds=
 limit %lu",
> > > > > > > > +                       sg_len, LS1X_DMA_MAX_DESC);
> > > > > > > > +               return NULL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       desc =3D kzalloc(sizeof(*desc), GFP_NOWAIT);
> > > > > > > > +       if (!desc)
> > > > > > > > +               return NULL;
> > > > > > > > +
> > > > > > > > +       /* allocate HW descriptors */
> > > > > > > > +       desc->hwdesc =3D dma_pool_zalloc(chan->desc_pool, G=
FP_NOWAIT,
> > > > > > > > +                                      &desc->hwdesc_phys);
> > > > > > > > +       if (!desc->hwdesc) {
> > > > > > > > +               dev_err(chan2dev(dchan), "failed to alloc H=
W descriptors\n");
> > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > +               return NULL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       desc->dir =3D direction;
> > > > > > > > +       desc->type =3D type;
> > > > > > > > +       desc->nr_descs =3D sg_len;
> > > > > > > > +
> > > > > > > > +       return desc;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_setup_hwdescs(struct dma_chan *dchan,
> > > > > > > > +                                 struct ls1x_dma_desc *des=
c,
> > > > > > > > +                                 struct scatterlist *sgl, =
unsigned int sg_len)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       dma_addr_t next_hwdesc_phys =3D desc->hwdesc_phys;
> > > > > > > > +
> > > > > > > > +       struct scatterlist *sg;
> > > > > > > > +       unsigned int dev_addr, cmd, i;
> > > > > > > > +
> > > > > > > > +       switch (desc->dir) {
> > > > > > > > +       case DMA_MEM_TO_DEV:
> > > > > > > > +               dev_addr =3D chan->dst_addr;
> > > > > > > > +               desc->bus_width =3D chan->dst_addr_width;
> > > > > > > > +               cmd =3D DMA_RAM2DEV | DMA_INT;
> > > > > > > > +               break;
> > > > > > > > +       case DMA_DEV_TO_MEM:
> > > > > > > > +               dev_addr =3D chan->src_addr;
> > > > > > > > +               desc->bus_width =3D chan->src_addr_width;
> > > > > > > > +               cmd =3D DMA_INT;
> > > > > > > > +               break;
> > > > > > > > +       default:
> > > > > > > > +               dev_err(chan2dev(dchan), "unsupported DMA d=
irection: %s\n",
> > > > > > > > +                       dmaengine_get_direction_text(desc->=
dir));
> > > > > > > > +               return -EINVAL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       /* setup HW descriptors */
> > > > > > > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > > > > > > +               dma_addr_t buf_addr =3D sg_dma_address(sg);
> > > > > > > > +               size_t buf_len =3D sg_dma_len(sg);
> > > > > > > > +               struct ls1x_dma_hwdesc *hwdesc =3D &desc->h=
wdesc[i];
> > > > > > > > +
> > > > > > > > +               if (!is_dma_copy_aligned(dchan->device, buf=
_addr, 0, buf_len)) {
> > > > > > > > +                       dev_err(chan2dev(dchan), "buffer is=
 not aligned!\n");
> > > > > > > > +                       return -EINVAL;
> > > > > > > > +               }
> > > > > > > > +
> > > > > > > > +               hwdesc->saddr =3D buf_addr;
> > > > > > > > +               hwdesc->daddr =3D dev_addr;
> > > > > > > > +               hwdesc->length =3D buf_len / desc->bus_widt=
h;
> > > > > > > > +               hwdesc->stride =3D 0;
> > > > > > > > +               hwdesc->cycles =3D 1;
> > > > > > > > +               hwdesc->cmd =3D cmd;
> > > > > > > > +
> > > > > > > > +               if (i) {
> > > > > > > > +                       next_hwdesc_phys +=3D sizeof(*hwdes=
c);
> > > > > > > > +                       desc->hwdesc[i - 1].next =3D next_h=
wdesc_phys
> > > > > > > > +                           | DMA_NEXT_VALID;
> > > > > > > > +               }
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       if (desc->type =3D=3D DMA_CYCLIC)
> > > > > > > > +               desc->hwdesc[i - 1].next =3D desc->hwdesc_p=
hys | DMA_NEXT_VALID;
> > > > > > > > +
> > > > > > > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > > > > > > +               struct ls1x_dma_hwdesc *hwdesc =3D &desc->h=
wdesc[i];
> > > > > > > > +
> > > > > > > > +               print_hex_dump_debug("HW DESC: ", DUMP_PREF=
IX_OFFSET, 16, 4,
> > > > > > > > +                                    hwdesc, sizeof(*hwdesc=
), false);
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct dma_async_tx_descriptor *
> > > > > > > > +ls1x_dma_prep_slave_sg(struct dma_chan *dchan,
> > > > > > > > +                      struct scatterlist *sgl, unsigned in=
t sg_len,
> > > > > > > > +                      enum dma_transfer_direction directio=
n,
> > > > > > > > +                      unsigned long flags, void *context)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > +
> > > > > > > > +       dev_dbg(chan2dev(dchan), "sg_len=3D%u flags=3D0x%lx=
 dir=3D%s\n",
> > > > > > > > +               sg_len, flags, dmaengine_get_direction_text=
(direction));
> > > > > > > > +
> > > > > > > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, directi=
on, DMA_SLAVE);
> > > > > > > > +       if (!desc)
> > > > > > > > +               return NULL;
> > > > > > > > +
> > > > > > > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg_len=
)) {
> > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > +               return NULL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       return vchan_tx_prep(&chan->vchan, &desc->vdesc, fl=
ags);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct dma_async_tx_descriptor *
> > > > > > > > +ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan,
> > > > > > > > +                        dma_addr_t buf_addr, size_t buf_le=
n, size_t period_len,
> > > > > > > > +                        enum dma_transfer_direction direct=
ion,
> > > > > > > > +                        unsigned long flags)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > +       struct scatterlist *sgl;
> > > > > > > > +       unsigned int sg_len;
> > > > > > > > +       unsigned int i;
> > > > > > > > +
> > > > > > > > +       dev_dbg(chan2dev(dchan),
> > > > > > > > +               "buf_len=3D%d period_len=3D%zu flags=3D0x%l=
x dir=3D%s\n", buf_len,
> > > > > > > > +               period_len, flags, dmaengine_get_direction_=
text(direction));
> > > > > > > > +
> > > > > > > > +       sg_len =3D buf_len / period_len;
> > > > > > > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, directi=
on, DMA_CYCLIC);
> > > > > > > > +       if (!desc)
> > > > > > > > +               return NULL;
> > > > > > > > +
> > > > > > > > +       /* allocate the scatterlist */
> > > > > > > > +       sgl =3D kmalloc_array(sg_len, sizeof(*sgl), GFP_NOW=
AIT);
> > > > > > > > +       if (!sgl)
> > > > > > > > +               return NULL;
> > > > > > > > +
> > > > > > > > +       sg_init_table(sgl, sg_len);
> > > > > > > > +       for (i =3D 0; i < sg_len; ++i) {
> > > > > > > > +               sg_set_page(&sgl[i], pfn_to_page(PFN_DOWN(b=
uf_addr)),
> > > > > > > > +                           period_len, offset_in_page(buf_=
addr));
> > > > > > > > +               sg_dma_address(&sgl[i]) =3D buf_addr;
> > > > > > > > +               sg_dma_len(&sgl[i]) =3D period_len;
> > > > > > > > +               buf_addr +=3D period_len;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg_len=
)) {
> > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > +               return NULL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       kfree(sgl);
> > > > > > > > +
> > > > > > > > +       return vchan_tx_prep(&chan->vchan, &desc->vdesc, fl=
ags);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_slave_config(struct dma_chan *dchan,
> > > > > > > > +                                struct dma_slave_config *c=
onfig)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +
> > > > > > > > +       chan->src_addr =3D config->src_addr;
> > > > > > > > +       chan->src_addr_width =3D config->src_addr_width;
> > > > > > > > +       chan->dst_addr =3D config->dst_addr;
> > > > > > > > +       chan->dst_addr_width =3D config->dst_addr_width;
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_pause(struct dma_chan *dchan)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       unsigned long flags;
> > > > > > > > +       int ret;
> > > > > > > > +
> > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > +       ret =3D ls1x_dma_query(chan, &chan->curr_hwdesc_phy=
s);
> > > > > > > > +       if (!ret)
> > > > > > > > +               ls1x_dma_stop(chan);
> > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > > > > +
> > > > > > > > +       return ret;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_resume(struct dma_chan *dchan)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       unsigned long flags;
> > > > > > > > +       int ret;
> > > > > > > > +
> > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > +       ret =3D ls1x_dma_start(chan, &chan->curr_hwdesc_phy=
s);
> > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > > > > +
> > > > > > > > +       return ret;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_terminate_all(struct dma_chan *dchan)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       unsigned long flags;
> > > > > > > > +       LIST_HEAD(head);
> > > > > > > > +
> > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > +       ls1x_dma_stop(chan);
> > > > > > > > +       vchan_get_all_descriptors(&chan->vchan, &head);
> > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > > > > +
> > > > > > > > +       vchan_dma_desc_free_list(&chan->vchan, &head);
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static enum dma_status ls1x_dma_tx_status(struct dma_chan =
*dchan,
> > > > > > > > +                                         dma_cookie_t cook=
ie,
> > > > > > > > +                                         struct dma_tx_sta=
te *state)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       struct virt_dma_desc *vdesc;
> > > > > > > > +       enum dma_status status;
> > > > > > > > +       size_t bytes =3D 0;
> > > > > > > > +       unsigned long flags;
> > > > > > > > +
> > > > > > > > +       status =3D dma_cookie_status(dchan, cookie, state);
> > > > > > > > +       if (status =3D=3D DMA_COMPLETE)
> > > > > > > > +               return status;
> > > > > > > > +
> > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > +       vdesc =3D vchan_find_desc(&chan->vchan, cookie);
> > > > > > > > +       if (chan->desc && cookie =3D=3D chan->desc->vdesc.t=
x.cookie) {
> > > > > > > > +               struct ls1x_dma_desc *desc =3D chan->desc;
> > > > > > > > +               int i;
> > > > > > > > +
> > > > > > > > +               if (ls1x_dma_query(chan, &chan->curr_hwdesc=
_phys))
> > > > > > > > +                       return status;
> > > > > > > > +
> > > > > > > > +               /* locate the current HW descriptor */
> > > > > > > > +               for (i =3D 0; i < desc->nr_descs; i++)
> > > > > > > > +                       if (desc->hwdesc[i].next =3D=3D cha=
n->curr_hwdesc->next)
> > > > > > > > +                               break;
> > > > > > > > +
> > > > > > > > +               /* count the residues */
> > > > > > > > +               for (; i < desc->nr_descs; i++)
> > > > > > > > +                       bytes +=3D desc->hwdesc[i].length *=
 desc->bus_width;
> > > > > > > > +
> > > > > > > > +               dma_set_residue(state, bytes);
> > > > > > > > +       }
> > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > > > > +
> > > > > > > > +       return status;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void ls1x_dma_issue_pending(struct dma_chan *dchan)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dch=
an);
> > > > > > > > +       struct virt_dma_desc *vdesc;
> > > > > > > > +       unsigned long flags;
> > > > > > > > +
> > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > +       if (vchan_issue_pending(&chan->vchan) && !chan->des=
c) {
> > > > > > > > +               vdesc =3D vchan_next_desc(&chan->vchan);
> > > > > > > > +               if (!vdesc) {
> > > > > > > > +                       chan->desc =3D NULL;
> > > > > > > > +                       return;
> > > > > > > > +               }
> > > > > > > > +               chan->desc =3D to_ls1x_dma_desc(vdesc);
> > > > > > > > +               ls1x_dma_start(chan, &chan->desc->hwdesc_ph=
ys);
> > > > > > > > +       }
> > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static irqreturn_t ls1x_dma_irq_handler(int irq, void *dat=
a)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma_chan *chan =3D data;
> > > > > > > > +       struct ls1x_dma_desc *desc =3D chan->desc;
> > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > +
> > > > > > > > +       if (!desc) {
> > > > > > > > +               dev_warn(chan2dev(dchan),
> > > > > > > > +                        "IRQ %d with no active descriptor =
on channel %d\n",
> > > > > > > > +                        irq, dchan->chan_id);
> > > > > > > > +               return IRQ_NONE;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\=
n", irq,
> > > > > > > > +               dchan->chan_id);
> > > > > > > > +
> > > > > > > > +       spin_lock(&chan->vchan.lock);
> > > > > > > > +
> > > > > > > > +       if (desc->type =3D=3D DMA_CYCLIC) {
> > > > > > > > +               vchan_cyclic_callback(&desc->vdesc);
> > > > > > > > +       } else {
> > > > > > > > +               list_del(&desc->vdesc.node);
> > > > > > > > +               vchan_cookie_complete(&desc->vdesc);
> > > > > > > > +               chan->desc =3D NULL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       spin_unlock(&chan->vchan.lock);
> > > > > > > > +       return IRQ_HANDLED;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_chan_probe(struct platform_device *pde=
v,
> > > > > > > > +                              struct ls1x_dma *dma, int ch=
an_id)
> > > > > > > > +{
> > > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > > +       struct ls1x_dma_chan *chan =3D &dma->chan[chan_id];
> > > > > > > > +       char pdev_irqname[4];
> > > > > > > > +       char *irqname;
> > > > > > > > +       int ret;
> > > > > > > > +
> > > > > > > > +       sprintf(pdev_irqname, "ch%u", chan_id);
> > > > > > > > +       chan->irq =3D platform_get_irq_byname(pdev, pdev_ir=
qname);
> > > > > > > > +       if (chan->irq < 0)
> > > > > > > > +               return -ENODEV;
> > > > > > > > +
> > > > > > > > +       irqname =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s"=
,
> > > > > > > > +                                dev_name(dev), pdev_irqnam=
e);
> > > > > > > > +       if (!irqname)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       ret =3D devm_request_irq(dev, chan->irq, ls1x_dma_i=
rq_handler,
> > > > > > > > +                              IRQF_SHARED, irqname, chan);
> > > > > > > > +       if (ret)
> > > > > > > > +               return dev_err_probe(dev, ret,
> > > > > > > > +                                    "failed to request IRQ=
 %u!\n", chan->irq);
> > > > > > > > +
> > > > > > > > +       chan->reg_base =3D dma->reg_base;
> > > > > > > > +       chan->vchan.desc_free =3D ls1x_dma_free_desc;
> > > > > > > > +       vchan_init(&chan->vchan, &dma->ddev);
> > > > > > > > +       dev_info(dev, "%s (irq %d) initialized\n", pdev_irq=
name, chan->irq);
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void ls1x_dma_chan_remove(struct ls1x_dma *dma, int=
 chan_id)
> > > > > > > > +{
> > > > > > > > +       struct device *dev =3D dma->ddev.dev;
> > > > > > > > +       struct ls1x_dma_chan *chan =3D &dma->chan[chan_id];
> > > > > > > > +
> > > > > > > > +       devm_free_irq(dev, chan->irq, chan);
> > > > > > > > +       list_del(&chan->vchan.chan.device_node);
> > > > > > > > +       tasklet_kill(&chan->vchan.task);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls1x_dma_probe(struct platform_device *pdev)
> > > > > > > > +{
> > > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > > +       struct dma_device *ddev;
> > > > > > > > +       struct ls1x_dma *dma;
> > > > > > > > +       int nr_chans, ret, i;
> > > > > > > > +
> > > > > > > > +       nr_chans =3D platform_irq_count(pdev);
> > > > > > > > +       if (nr_chans <=3D 0)
> > > > > > > > +               return nr_chans;
> > > > > > > > +       if (nr_chans > LS1X_DMA_MAX_CHANNELS)
> > > > > > > > +               return dev_err_probe(dev, -EINVAL,
> > > > > > > > +                                    "nr_chans=3D%d exceeds=
 the maximum\n",
> > > > > > > > +                                    nr_chans);
> > > > > > > > +
> > > > > > > > +       dma =3D devm_kzalloc(dev, struct_size(dma, chan, nr=
_chans), GFP_KERNEL);
> > > > > > > > +       if (!dma)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       /* initialize DMA device */
> > > > > > > > +       dma->reg_base =3D devm_platform_ioremap_resource(pd=
ev, 0);
> > > > > > > > +       if (IS_ERR(dma->reg_base))
> > > > > > > > +               return PTR_ERR(dma->reg_base);
> > > > > > > > +
> > > > > > > > +       ddev =3D &dma->ddev;
> > > > > > > > +       ddev->dev =3D dev;
> > > > > > > > +       ddev->copy_align =3D DMAENGINE_ALIGN_4_BYTES;
> > > > > > > > +       ddev->src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_=
BYTE) |
> > > > > > > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_SLAVE=
_BUSWIDTH_4_BYTES);
> > > > > > > > +       ddev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_=
BYTE) |
> > > > > > > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_SLAVE=
_BUSWIDTH_4_BYTES);
> > > > > > > > +       ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_=
MEM_TO_DEV);
> > > > > > > > +       ddev->max_sg_burst =3D LS1X_DMA_MAX_DESC;
> > > > > > > > +       ddev->residue_granularity =3D DMA_RESIDUE_GRANULARI=
TY_SEGMENT;
> > > > > > > > +       ddev->device_alloc_chan_resources =3D ls1x_dma_allo=
c_chan_resources;
> > > > > > > > +       ddev->device_free_chan_resources =3D ls1x_dma_free_=
chan_resources;
> > > > > > > > +       ddev->device_prep_slave_sg =3D ls1x_dma_prep_slave_=
sg;
> > > > > > > > +       ddev->device_prep_dma_cyclic =3D ls1x_dma_prep_dma_=
cyclic;
> > > > > > > > +       ddev->device_config =3D ls1x_dma_slave_config;
> > > > > > > > +       ddev->device_pause =3D ls1x_dma_pause;
> > > > > > > > +       ddev->device_resume =3D ls1x_dma_resume;
> > > > > > > > +       ddev->device_terminate_all =3D ls1x_dma_terminate_a=
ll;
> > > > > > > > +       ddev->device_tx_status =3D ls1x_dma_tx_status;
> > > > > > > > +       ddev->device_issue_pending =3D ls1x_dma_issue_pendi=
ng;
> > > > > > > > +
> > > > > > > > +       dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > > > > > > > +       INIT_LIST_HEAD(&ddev->channels);
> > > > > > > > +
> > > > > > > > +       /* initialize DMA channels */
> > > > > > > > +       for (i =3D 0; i < nr_chans; i++) {
> > > > > > > > +               ret =3D ls1x_dma_chan_probe(pdev, dma, i);
> > > > > > > > +               if (ret)
> > > > > > > > +                       return ret;
> > > > > > > > +       }
> > > > > > > > +       dma->nr_chans =3D nr_chans;
> > > > > > > > +
> > > > > > > > +       ret =3D dmaenginem_async_device_register(ddev);
> > > > > > > > +       if (ret) {
> > > > > > > > +               dev_err(dev, "failed to register DMA device=
! %d\n", ret);
> > > > > > > > +               return ret;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       ret =3D
> > > > > > > > +           of_dma_controller_register(dev->of_node, of_dma=
_xlate_by_chan_id,
> > > > > > > > +                                      ddev);
> > > > > > > > +       if (ret) {
> > > > > > > > +               dev_err(dev, "failed to register DMA contro=
ller! %d\n", ret);
> > > > > > > > +               return ret;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       platform_set_drvdata(pdev, dma);
> > > > > > > > +       dev_info(dev, "Loongson1 DMA driver registered\n");
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void ls1x_dma_remove(struct platform_device *pdev)
> > > > > > > > +{
> > > > > > > > +       struct ls1x_dma *dma =3D platform_get_drvdata(pdev)=
;
> > > > > > > > +       int i;
> > > > > > > > +
> > > > > > > > +       of_dma_controller_free(pdev->dev.of_node);
> > > > > > > > +
> > > > > > > > +       for (i =3D 0; i < dma->nr_chans; i++)
> > > > > > > > +               ls1x_dma_chan_remove(dma, i);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct of_device_id ls1x_dma_match[] =3D {
> > > > > > > > +       { .compatible =3D "loongson,ls1b-apbdma" },
> > > > > > > > +       { .compatible =3D "loongson,ls1c-apbdma" },
> > > > > > > > +       { /* sentinel */ }
> > > > > > > > +};
> > > > > > > > +MODULE_DEVICE_TABLE(of, ls1x_dma_match);
> > > > > > > > +
> > > > > > > > +static struct platform_driver ls1x_dma_driver =3D {
> > > > > > > > +       .probe =3D ls1x_dma_probe,
> > > > > > > > +       .remove_new =3D ls1x_dma_remove,
> > > > > > > > +       .driver =3D {
> > > > > > > > +               .name =3D KBUILD_MODNAME,
> > > > > > > > +               .of_match_table =3D ls1x_dma_match,
> > > > > > > > +       },
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +module_platform_driver(ls1x_dma_driver);
> > > > > > > > +
> > > > > > > > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> > > > > > > > +MODULE_DESCRIPTION("Loongson-1 APB DMA Controller driver")=
;
> > > > > > > > +MODULE_LICENSE("GPL");
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.40.1
> > > > > > > >
> > > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Best regards,
> > > > > >
> > > > > > Keguang Zhang
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Best regards,
> > > >
> > > > Keguang Zhang
> >
> >
> >
> > --
> > Best regards,
> >
> > Keguang Zhang



--
Best regards,

Keguang Zhang

