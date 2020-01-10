Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AFD1373AE
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 17:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAJQbL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 11:31:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36872 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgAJQbK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jan 2020 11:31:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so2103820edb.4;
        Fri, 10 Jan 2020 08:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcakXweHEcQflg8HJoYvX703zzGZOe1NoqnogCk40Mc=;
        b=HHBJL4oRgZ5AHo4D3Myx+7AstucPXmrouLYgxNarRiHci02gzL1+pq1qTRPnXMjtCq
         nN6jDf4vUcHiMmfQIYDqAZh3rKNRMwDgrXqQJ5px0ed2NUKszp41G0GsmwTMDu8oMTM5
         fccU4GWuDREMI0QIuPcLbUlBbh6ew2GH0o3kfWDpebuxyEucJqfBVKmOVpw6rEQqPIB4
         POhvv4MRDbTjk3XzgfYyxySEl4WnPc3fm/+HpRH28I/vEHwFrKPE28hYLLeCBRAxR79H
         Bw2fMlaFiJBuKP6lfyp9S2wN8H+Q26EbqzCb/PvAIVKk31DAC/PFTbN0jYPaYmaQ5eHf
         jB9Q==
X-Gm-Message-State: APjAAAXK9YJrdYoPhfnCgGSUPknyW5iUvJVv7KUyyeXxpKQjNj8O+Fua
        KNeX3ntACUgg8bCTigcHdyfTX8oj4lQ=
X-Google-Smtp-Source: APXvYqx+Uj4+Ogzd2iRX/LmIf08/wrqorKSrcKk7c2fEgjhuU1ZI4m7zk35JVqfmG/28hwD4SfPbnw==
X-Received: by 2002:aa7:dd95:: with SMTP id g21mr385361edv.355.1578673867807;
        Fri, 10 Jan 2020 08:31:07 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id d8sm52249edn.52.2020.01.10.08.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 08:31:07 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id b6so2426722wrq.0;
        Fri, 10 Jan 2020 08:31:06 -0800 (PST)
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr4522664wrp.142.1578673866678;
 Fri, 10 Jan 2020 08:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20200110141140.28527-1-stefan@olimex.com> <20200110141140.28527-3-stefan@olimex.com>
In-Reply-To: <20200110141140.28527-3-stefan@olimex.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 11 Jan 2020 00:30:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v670FN7-dyjQuL+gyagupm5pr+z1ZWGG8E8YnYJA0aKPEA@mail.gmail.com>
Message-ID: <CAGb2v670FN7-dyjQuL+gyagupm5pr+z1ZWGG8E8YnYJA0aKPEA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/2] drm: sun4i: hdmi: Add support for sun4i
 HDMI encoder audio
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 10, 2020 at 10:12 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>
> Add HDMI audio support for the sun4i-hdmi encoder, used on
> the older Allwinner chips - A10, A20, A31.
>
> Most of the code is based on the BSP implementation. In it
> dditional formats are supported (S20_3LE and S24_LE), however
> there where some problems with them and only S16_LE is left.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  drivers/gpu/drm/sun4i/Kconfig            |   1 +
>  drivers/gpu/drm/sun4i/Makefile           |   1 +
>  drivers/gpu/drm/sun4i/sun4i_hdmi.h       |  30 ++
>  drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c | 375 +++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c   |   4 +
>  5 files changed, 411 insertions(+)
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c
>
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index 37e90e42943f..192b732b10cd 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -19,6 +19,7 @@ if DRM_SUN4I
>  config DRM_SUN4I_HDMI
>         tristate "Allwinner A10 HDMI Controller Support"
>         default DRM_SUN4I
> +       select SND_PCM_ELD
>         help
>           Choose this option if you have an Allwinner SoC with an HDMI
>           controller.
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index 0d04f2447b01..e2d82b451c36 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -5,6 +5,7 @@ sun4i-frontend-y                += sun4i_frontend.o
>  sun4i-drm-y                    += sun4i_drv.o
>  sun4i-drm-y                    += sun4i_framebuffer.o
>
> +sun4i-drm-hdmi-y               += sun4i_hdmi_audio.o
>  sun4i-drm-hdmi-y               += sun4i_hdmi_ddc_clk.o
>  sun4i-drm-hdmi-y               += sun4i_hdmi_enc.o
>  sun4i-drm-hdmi-y               += sun4i_hdmi_i2c.o
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> index 7ad3f06c127e..456964e681b0 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> @@ -42,7 +42,32 @@
>  #define SUN4I_HDMI_VID_TIMING_POL_VSYNC                BIT(1)
>  #define SUN4I_HDMI_VID_TIMING_POL_HSYNC                BIT(0)
>
> +#define SUN4I_HDMI_AUDIO_CTRL_REG      0x040
> +#define SUN4I_HDMI_AUDIO_CTRL_ENABLE           BIT(31)
> +#define SUN4I_HDMI_AUDIO_CTRL_RESET            BIT(30)
> +
> +#define SUN4I_HDMI_AUDIO_FMT_REG       0x048
> +#define SUN4I_HDMI_AUDIO_FMT_SRC               BIT(31)
> +#define SUN4I_HDMI_AUDIO_FMT_LAYOUT            BIT(3)
> +#define SUN4I_HDMI_AUDIO_FMT_CH_CFG(n)         (n - 1)
> +#define SUN4I_HDMI_AUDIO_FMT_CH_CFG_MASK       GENMASK(2, 0)
> +
> +#define SUN4I_HDMI_AUDIO_PCM_REG       0x4c
> +#define SUN4I_HDMI_AUDIO_PCM_CH_MAP(n, m)      ((m - 1) << (n * 4))
> +#define SUN4I_HDMI_AUDIO_PCM_CH_MAP_MASK(n)    (GENMASK(2, 0) << (n * 4))
> +
> +#define SUN4I_HDMI_AUDIO_CTS_REG       0x050
> +#define SUN4I_HDMI_AUDIO_CTS(n)                        (n & GENMASK(19, 0))
> +
> +#define SUN4I_HDMI_AUDIO_N_REG         0x054
> +#define SUN4I_HDMI_AUDIO_N(n)                  (n & GENMASK(19, 0))
> +
> +#define SUN4I_HDMI_AUDIO_STAT0_REG     0x58
> +#define SUN4I_HDMI_AUDIO_STAT0_FREQ(n)         (n << 24)
> +#define SUN4I_HDMI_AUDIO_STAT0_FREQ_MASK       GENMASK(27, 24)
> +
>  #define SUN4I_HDMI_AVI_INFOFRAME_REG(n)        (0x080 + (n))
> +#define SUN4I_HDMI_AUDIO_INFOFRAME_REG(n)      (0x0a0 + (n))
>
>  #define SUN4I_HDMI_PAD_CTRL0_REG       0x200
>  #define SUN4I_HDMI_PAD_CTRL0_BIASEN            BIT(31)
> @@ -283,9 +308,13 @@ struct sun4i_hdmi {
>         struct regmap_field     *field_ddc_sda_en;
>         struct regmap_field     *field_ddc_sck_en;
>
> +       u8                      hdmi_audio_channels;
> +
>         struct sun4i_drv        *drv;
>
>         bool                    hdmi_monitor;
> +       bool                    hdmi_audio;
> +
>         struct cec_adapter      *cec_adap;
>
>         const struct sun4i_hdmi_variant *variant;
> @@ -294,5 +323,6 @@ struct sun4i_hdmi {
>  int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
>  int sun4i_tmds_create(struct sun4i_hdmi *hdmi);
>  int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi);
> +int sun4i_hdmi_audio_create(struct sun4i_hdmi *hdmi);
>
>  #endif /* _SUN4I_HDMI_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c
> new file mode 100644
> index 000000000000..b6d4199d15ce
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Olimex Ltd.
> + *   Author: Stefan Mavrodiev <stefan@olimex.com>
> + */
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/of_dma.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_print.h>
> +
> +#include <sound/dmaengine_pcm.h>
> +#include <sound/pcm_drm_eld.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>

I would drop the ASoC stuff and just do a standard ALSA driver.
You really don't gain anything from using ASoC, since this is
just a really standard PCM DMA interface plus some controls.
There aren't multiple components that need to be strung together.

ChenYu
