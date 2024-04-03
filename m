Return-Path: <dmaengine+bounces-1733-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C853C8972D0
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE231C266F3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F3D58AD4;
	Wed,  3 Apr 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf89M7OU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FD57875;
	Wed,  3 Apr 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155172; cv=none; b=de8Q1BSl5/8gJQIdpZwyiAoSUmPfiebI6wlA9Y2/ls4B5V/ApM2NZ/AXrHDqsv26/8yuVplkrhuN4kiR83cWT0Q9EASi20eQEDgr3/Dwefft5FgYtTm/OOpNHnu58M6z7N2YxuEH44VFXu0pTmwXZnzlLUFxu9XDee4+OB7SM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155172; c=relaxed/simple;
	bh=YKqExGBr65A6TUh0IVYYxD5y45n6GXWAm7jxxR1yP10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf8DfI/ktIDfuVldPwbGXNYGbP6byu7r2PM4UJ/Pldvvumn1beGatoZxMcpj8j05Rop6RP1Pq75vwSVUXt8jq/DRgcsgVFs5KzpPxuUVDBeAxHtCBl47RH9W+5QNItRDNLOFjbANvzlHjI7ScheQaMcXeP1cS4lIgxQuIIa8Aok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf89M7OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0D3C433F1;
	Wed,  3 Apr 2024 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712155171;
	bh=YKqExGBr65A6TUh0IVYYxD5y45n6GXWAm7jxxR1yP10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cf89M7OUXoPWiKh8AIrChpZAZTgogsrbI6/rdPRaUH3WKGMb6W7ViQePW+cuhk7zJ
	 gfoQdKbTCs6J5FeUzg/BTCtEyvsck3wO2Fq1FO/ts+sz0u7UKRqCeMTT70zFKWROLp
	 GxHrk/n2HNmHLsRH4xzmaDGPBHB5ffB/KZfOslqsSo1s+JKWkwXfal17sSoKmLpr/M
	 yH1nBvH3C8HSWJvPpPDLGzv9dAtl2+PzS6mP/kM1j2GNyLkjUj0oC5A6uqBWky6Z5G
	 v7rIsS5XzD6DsUMa/oZPT1Plpph+bC0dk2vpcJj6GS2Te9vwwLEgZAI8WkLU5mhe28
	 y2Ca/SSU1DHRQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so9574508a12.0;
        Wed, 03 Apr 2024 07:39:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNQp5IWsZfMXjbxOmoyOgOtNZjUlgXr4WzWV13jqJoGKTm0TUm8ZIlxx1tI5IqnDs48TDrqPF8z/BSCFIfC9PywOU6bq8gQowUCVeRr+T6j0JP1pL5OkIvT6NZDr6A9m9dITtxNDVbU8CLrwSPW9rsBZJ+1krVpfBRfS0tgaKJvUMVJUp9mbJY9y0LO7cTWLQE5+5Z5kaeF89JvrT8Bpo=
X-Gm-Message-State: AOJu0YxUY0hbP6oU4Ge8/YyDFGBR8ZrAs8mFrMyXWZWX3DTBL2WlbcI+
	s+UF2OFNjDIeieR2vJBnht2QoyleeRLYDQ/uaBC9XiF/HKdY9OIOzv6hnybb9yMB68ffR2Li3Tz
	RQqfkwt/wnwmkFqb/UR1ci1naBpg=
X-Google-Smtp-Source: AGHT+IHhqionis/XNMW6IHEemKRDd0P/qbSpclMA1shMLJcyw5fHWIGOsu3ijTpYm8HcIN41Iw+ZgTosrt8n5b+Zfh0=
X-Received: by 2002:a17:906:857:b0:a4e:237a:82ac with SMTP id
 f23-20020a170906085700b00a4e237a82acmr2047641ejd.32.1712155170089; Wed, 03
 Apr 2024 07:39:30 -0700 (PDT)
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
 <CAJhJPsU6agzBR1jOw73SpMoogUMYu0qQT2VaBa+z1DXw2ZPNvw@mail.gmail.com>
 <CAAhV-H5uLcfaNYb7GAF17ruhJ02Wv71VZYEnxM_a642cuYaSBw@mail.gmail.com>
 <CAJhJPsWNuFMPEgDGsjdUdE1gYO3eVWLQ0QbYMXRTaMHv5bz9Ug@mail.gmail.com>
 <CAAhV-H5BSS1k6aCLYg4DT12nq-d4YyAKYBvy2ucLydwjVKNhBw@mail.gmail.com> <CAJhJPsULnEfTMFK5HS5TQZ_0XSs77Tw58Yfvw67BtTTHvjSLLw@mail.gmail.com>
In-Reply-To: <CAJhJPsULnEfTMFK5HS5TQZ_0XSs77Tw58Yfvw67BtTTHvjSLLw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Apr 2024 22:39:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5oYCBGAhPcU2S_giD0g9c=uBorK6Yh6mraWiXRiCfS7Q@mail.gmail.com>
Message-ID: <CAAhV-H5oYCBGAhPcU2S_giD0g9c=uBorK6Yh6mraWiXRiCfS7Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:24=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail.=
com> wrote:
>
> On Tue, Apr 2, 2024 at 10:50=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Tue, Apr 2, 2024 at 6:51=E2=80=AFPM Keguang Zhang <keguang.zhang@gma=
il.com> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 5:04=E2=80=AFPM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> > > >
> > > > On Tue, Apr 2, 2024 at 9:56=E2=80=AFAM Keguang Zhang <keguang.zhang=
@gmail.com> wrote:
> > > > >
> > > > > On Mon, Apr 1, 2024 at 9:24=E2=80=AFPM Huacai Chen <chenhuacai@ke=
rnel.org> wrote:
> > > > > >
> > > > > > On Mon, Apr 1, 2024 at 7:10=E2=80=AFPM Keguang Zhang <keguang.z=
hang@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 1, 2024 at 5:06=E2=80=AFPM Huacai Chen <chenhuaca=
i@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 1, 2024 at 10:45=E2=80=AFAM Keguang Zhang <kegu=
ang.zhang@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Huacai,
> > > > > > > > >
> > > > > > > > > On Sat, Mar 30, 2024 at 9:59=E2=80=AFPM Huacai Chen <chen=
huacai@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi, Keguang,
> > > > > > > > > >
> > > > > > > > > > On Fri, Mar 29, 2024 at 7:28=E2=80=AFPM Keguang Zhang v=
ia B4 Relay
> > > > > > > > > > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > > > > > > > > > >
> > > > > > > > > > > This patch adds APB DMA driver for Loongson-1 SoCs.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com=
>
> > > > > > > > > > > ---
> > > > > > > > > > > Changes in v7:
> > > > > > > > > > > - Change the comptible to 'loongson,ls1*-apbdma'
> > > > > > > > > > > - Update Kconfig and Makefile accordingly
> > > > > > > > > > > - Rename the file to loongson1-apb-dma.c to keep the =
consistency
> > > > > > > > > > >
> > > > > > > > > > > Changes in v6:
> > > > > > > > > > > - Implement .device_prep_dma_cyclic for Loongson1 aud=
io driver,
> > > > > > > > > > > - as well as .device_pause and .device_resume.
> > > > > > > > > > > - Set the limitation LS1X_DMA_MAX_DESC and put all de=
scriptors
> > > > > > > > > > > - into one page to save memory
> > > > > > > > > > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > > > > > > > > > > - Drop dma_slave_config structure
> > > > > > > > > > > - Use .remove_new instead of .remove
> > > > > > > > > > > - Use KBUILD_MODNAME for the driver name
> > > > > > > > > > > - Improve the debug information
> > > > > > > > > > >
> > > > > > > > > > > Changes in v5:
> > > > > > > > > > > - Add DT support
> > > > > > > > > > > - Use DT data instead of platform data
> > > > > > > > > > > - Use chan_id of struct dma_chan instead of own id
> > > > > > > > > > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_f=
ilter()
> > > > > > > > > > > - Update the author information to my official name
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Use dma_slave_map to find the proper channel.
> > > > > > > > > > > - Explicitly call devm_request_irq() and tasklet_kill=
().
> > > > > > > > > > > - Fix namespace issue.
> > > > > > > > > > > - Some minor fixes and cleanups.
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON=
1_DMA',
> > > > > > > > > > > - and rearrange it in alphabetical order in Kconfig a=
nd Makefile.
> > > > > > > > > > > - Fix comment style.
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/dma/Kconfig             |   9 +
> > > > > > > > > > >  drivers/dma/Makefile            |   1 +
> > > > > > > > > > >  drivers/dma/loongson1-apb-dma.c | 665 ++++++++++++++=
++++++++++++++++++++++++++
> > > > > > > > > > >  3 files changed, 675 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfi=
g
> > > > > > > > > > > index 002a5ec80620..f7b06c4cdf3f 100644
> > > > > > > > > > > --- a/drivers/dma/Kconfig
> > > > > > > > > > > +++ b/drivers/dma/Kconfig
> > > > > > > > > > > @@ -369,6 +369,15 @@ config K3_DMA
> > > > > > > > > > >           Support the DMA engine for Hisilicon K3 pla=
tform
> > > > > > > > > > >           devices.
> > > > > > > > > > >
> > > > > > > > > > > +config LOONGSON1_APB_DMA
> > > > > > > > > > > +       tristate "Loongson1 APB DMA support"
> > > > > > > > > > > +       depends on MACH_LOONGSON32 || COMPILE_TEST
> > > > > > > > > > > +       select DMA_ENGINE
> > > > > > > > > > > +       select DMA_VIRTUAL_CHANNELS
> > > > > > > > > > > +       help
> > > > > > > > > > > +         This selects support for the APB DMA contro=
ller in Loongson1 SoCs,
> > > > > > > > > > > +         which is required by Loongson1 NAND and aud=
io support.
> > > > > > > > > > Why not rename to LS1X_APB_DMA and put it just before L=
S2X_APB_DMA
> > > > > > > > > > (and also the driver file name)?
> > > > > > > > > >
> > > > > > > > > So far all Kconfig entries of Loongson-1 drivers are name=
d with the
> > > > > > > > > keyword "LOONGSON1".
> > > > > > > > > The same is true for these file names.
> > > > > > > > > Therefore, I need to keep the consistency.
> > > > > > > > But I see LS1X_IRQ in drivers/irqchip/Kconfig
> > > > > > > >
> > > > > > > Indeed, that's an exception, which was submitted by Jiaxun se=
veral years ago.
> > > > > > > Actually, most drivers of Loongson family use the keyword "LO=
ONGSON"
> > > > > > > for Kconfig and "loongson" for filename.
> > > > > > > Thus I take this keywork as the naming convention.
> > > > > > But I think keeping consistency in a same subsystem is better t=
han
> > > > > > keeping consistency in a same SoC (but cross subsystems).
> > > > > >
> > > > > In my opinion, "LS*X" is too short and may be confused with other=
 SoCs.
> > > > > Meanwhile, there are only four drivers that use this keyword.
> > > > >   config I2C_LS2X
> > > > >   config LS2K_RESET
> > > > >   config LS2X_APB_DMA
> > > > >   config LS1X_IRQ
> > > > > Then, my suggestion is to change these "LS*X" to "LOONGSON*" to g=
et a
> > > > > clear meaning.
> > > > We have made a naming conversion some years before with Jiaxun.
> > > > 1, Use "Loongson" for CPU in arch code;
> > > > 2, Use "LS7A" or something like this for bridges and devices.
> > > > 3, For drivers in SoC, if the driver is specific to Loongson-1, use
> > > > LS1X, if it is to Loongson-2, use LS2X, if it is shared by both
> > > > Loongson-1 and Loongson-2, use LOONGSON.
> > > >
> > > OK. But the doesn't the answer the question of confusion, such as
> > > "Freescale LS1021A".
> > > The same problem happens to the filenames.
> > >   ./drivers/gpu/drm/nouveau/nvkm/nvfw/ls.c
> > >   ./drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> > >   ./drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> > >   ./drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
> > >   ./arch/powerpc/platforms/embedded6xx/ls_uart.c
> > > Regarding "LS*X" itself, it contains the wildcard character "X" which
> > > itself is confusing.
> > > Therefore, I don't think "LS*X" is clear enough.
> > >
> The confusion problem remains.
> Honestly, I don't think "LS" is a good short for "LOONGSON".
>
> > > On the other hand, I see "LOONGSON2_*" strings are still there.
> This question remains.
>
> > > In addition, some of "LOONGSON_" definitions are not applicable for
> > > Loongson-1 at all, which breaks your convention.
> > >   config SND_SOC_LOONGSON_I2S_PCI  /* Loongson-1 doesn't support I2S =
*/
> > >   config SND_SOC_LOONGSON_CARD
> > They are shared by LS2K and LS7A.
> >
> > >   config DWMAC_LOONGSON1
> > >   config DWMAC_LOONGSON  /* This glue layer doesn't support Loongson-=
1 */
> > >   config COMMON_CLK_LOONGSON2
> unaddressed
>
> > >   config RTC_DRV_LOONGSON
> > RTC is shared by LS2K and LS7A.
> >
> > >   config SPI_LOONGSON_CORE
> > >   config SPI_LOONGSON_PCI  /* N/A for Loongson-1 */
> > >   config SPI_LOONGSON_PLATFORM
> > SPI is also shared by LS2K and LS7A.
> >
> > >   config LOONGSON2_CPUFREQ
> unaddressed
>
> > >   config DRM_LOONGSON  /* N/A for Loongson-1 */
> > DRM is also shared by LS2K and LS7A.
> >
> > >   config LOONGSON1_WDT
> > >   config CLKSRC_LOONGSON1_PWM
> > >   config LOONGSON_LIOINTC  /* N/A for Loongson-1 */
> > >   config LOONGSON_EIOINTC  /* N/A for Loongson-1 */
> > >   config LOONGSON_HTPIC  /* N/A for Loongson-1 */
> > >   config LOONGSON_HTVEC  /* N/A for Loongson-1 */
> > >   config LOONGSON_PCH_PIC  /* N/A for Loongson-1 */
> > >   config LOONGSON_PCH_MSI  /* N/A for Loongson-1 */
> > >   config LOONGSON_PCH_LPC  /* N/A for Loongson-1 */
> > All interrupt controllers are shared by Loongson-2 and Loongson-3.
> >
> > >   config PINCTRL_LOONGSON2
> unaddressed
> > >   config LOONGSON2_THERMAL
> ditto
> > >   config LOONGSON2_GUTS
> ditto
> > >   config LOONGSON2_PM
> ditto
> > >   config LOONGSON_LAPTOP  /* N/A for Loongson-1 */
> > Laptop driver is shared by Loongson-2 and Loongson-3.
> >
> > >   config GPIO_LOONGSON
> > >   config GPIO_LOONGSON_64BIT  -> N/A for Loongson-1
> > >   config GPIO_LOONGSON1
> > GPIO driver is shared by LS2K and LS7A.
> >
> > >   config PCI_LOONGSON
> > PCI driver is shared by Loongson-2 and Loongson-3.
>
> You said "if it is shared by both Loongson-1 and Loongson-2, use LOONGSON=
."
> Now the rule changes from "Loongson-1 and Loongson-2" to "Loongson-2
> and Loongson-3".
> Then, when shall we use "LOONGSON"?
"If it is shared Loongson-1 and Loongson-2" is an example, if you need
an exact description, then "If it is shared by more than one series,
such as Loongson-1 and Loongson-2".

>
> Here is the situation: only are four drivers use "LS*".
>   config I2C_LS2X
>   config LS2K_RESET
>   config LS2X_APB_DMA
>   config LS1X_IRQ
> My suggestion is to use the intuitive "LOONGSON*" for both CPU and
> drivers, which is easy to understand.
> And replace the confusing and unclear "LS*X" with "LOONGSON*".
> Use "LOONGSON" when the driver/feature is shared with Loongson-1,
> Loongson-2 and Loongson-3.
> >
> > >
> > > What's your plan about the above Kconfig entries?
> > Yes, there are exceptions indeed, but very rare. And some of the
> > exceptions are due to the limited spare time of Jiaxun and me. But in
> > this case, it is better to keep consistency in the DMA subsystem.
> >
> Sorry, I'm not persuaded.
> Please consider my proposal.
Renaming Kconfig is a bad idea, it breaks existing config files, so we
cannot do that. Part of your proposal is reasonable, for example,
Loongson-3's CPUFreq driver will be LOONGSON3_CPUFREQ, to keep
consistency in the same subsystem. But for the DMA subsystem, it also
should follow the existing style, use LS1X.

Huacai

> Thanks!
>
> > Huacai
> >
> > > Why can't we use LOONGSON1/LOONGSON2 for drivers?
> > >
> > >
> > > > Huacai
> > > >
> > > > >
> > > > > > Huacai
> > > > > >
> > > > > > >
> > > > > > > > Huacai
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Huacai
> > > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > >  config LPC18XX_DMAMUX
> > > > > > > > > > >         bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > > > > > > > > > >         depends on ARCH_LPC18XX || COMPILE_TEST
> > > > > > > > > > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makef=
ile
> > > > > > > > > > > index dfd40d14e408..b26f6677978a 100644
> > > > > > > > > > > --- a/drivers/dma/Makefile
> > > > > > > > > > > +++ b/drivers/dma/Makefile
> > > > > > > > > > > @@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idm=
a64.o
> > > > > > > > > > >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> > > > > > > > > > >  obj-y +=3D idxd/
> > > > > > > > > > >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > > > > > > > > > > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-d=
ma.o
> > > > > > > > > > >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > > > > > > > > > >  obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> > > > > > > > > > >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > > > > > > > > > > diff --git a/drivers/dma/loongson1-apb-dma.c b/driver=
s/dma/loongson1-apb-dma.c
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 000000000000..d474a2601e6e
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/drivers/dma/loongson1-apb-dma.c
> > > > > > > > > > > @@ -0,0 +1,665 @@
> > > > > > > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Driver for Loongson-1 APB DMA Controller
> > > > > > > > > > > + *
> > > > > > > > > > > + * Copyright (C) 2015-2024 Keguang Zhang <keguang.zh=
ang@gmail.com>
> > > > > > > > > > > + */
> > > > > > > > > > > +
> > > > > > > > > > > +#include <linux/dmapool.h>
> > > > > > > > > > > +#include <linux/dma-mapping.h>
> > > > > > > > > > > +#include <linux/init.h>
> > > > > > > > > > > +#include <linux/interrupt.h>
> > > > > > > > > > > +#include <linux/iopoll.h>
> > > > > > > > > > > +#include <linux/module.h>
> > > > > > > > > > > +#include <linux/of.h>
> > > > > > > > > > > +#include <linux/of_dma.h>
> > > > > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > > > > +#include <linux/slab.h>
> > > > > > > > > > > +
> > > > > > > > > > > +#include "dmaengine.h"
> > > > > > > > > > > +#include "virt-dma.h"
> > > > > > > > > > > +
> > > > > > > > > > > +/* Loongson-1 DMA Control Register */
> > > > > > > > > > > +#define DMA_CTRL                       0x0
> > > > > > > > > > > +
> > > > > > > > > > > +/* DMA Control Register Bits */
> > > > > > > > > > > +#define DMA_STOP                       BIT(4)
> > > > > > > > > > > +#define DMA_START                      BIT(3)
> > > > > > > > > > > +#define DMA_ASK_VALID                  BIT(2)
> > > > > > > > > > > +
> > > > > > > > > > > +#define DMA_ADDR_MASK                  GENMASK(31, 6=
)
> > > > > > > > > > > +
> > > > > > > > > > > +/* DMA Next Field Bits */
> > > > > > > > > > > +#define DMA_NEXT_VALID                 BIT(0)
> > > > > > > > > > > +
> > > > > > > > > > > +/* DMA Command Field Bits */
> > > > > > > > > > > +#define DMA_RAM2DEV                    BIT(12)
> > > > > > > > > > > +#define DMA_INT                                BIT(1=
)
> > > > > > > > > > > +#define DMA_INT_MASK                   BIT(0)
> > > > > > > > > > > +
> > > > > > > > > > > +#define LS1X_DMA_MAX_CHANNELS          3
> > > > > > > > > > > +
> > > > > > > > > > > +/* Size of allocations for hardware descriptors */
> > > > > > > > > > > +#define LS1X_DMA_DESCS_SIZE            PAGE_SIZE
> > > > > > > > > > > +#define LS1X_DMA_MAX_DESC              \
> > > > > > > > > > > +       (LS1X_DMA_DESCS_SIZE / sizeof(struct ls1x_dma=
_hwdesc))
> > > > > > > > > > > +
> > > > > > > > > > > +struct ls1x_dma_hwdesc {
> > > > > > > > > > > +       u32 next;               /* next descriptor ad=
dress */
> > > > > > > > > > > +       u32 saddr;              /* memory DMA address=
 */
> > > > > > > > > > > +       u32 daddr;              /* device DMA address=
 */
> > > > > > > > > > > +       u32 length;
> > > > > > > > > > > +       u32 stride;
> > > > > > > > > > > +       u32 cycles;
> > > > > > > > > > > +       u32 cmd;
> > > > > > > > > > > +       u32 stats;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > > +struct ls1x_dma_desc {
> > > > > > > > > > > +       struct virt_dma_desc vdesc;
> > > > > > > > > > > +       enum dma_transfer_direction dir;
> > > > > > > > > > > +       enum dma_transaction_type type;
> > > > > > > > > > > +       unsigned int bus_width;
> > > > > > > > > > > +
> > > > > > > > > > > +       unsigned int nr_descs;  /* number of descript=
ors */
> > > > > > > > > > > +
> > > > > > > > > > > +       struct ls1x_dma_hwdesc *hwdesc;
> > > > > > > > > > > +       dma_addr_t hwdesc_phys;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > > +struct ls1x_dma_chan {
> > > > > > > > > > > +       struct virt_dma_chan vchan;
> > > > > > > > > > > +       struct dma_pool *desc_pool;
> > > > > > > > > > > +       phys_addr_t src_addr;
> > > > > > > > > > > +       phys_addr_t dst_addr;
> > > > > > > > > > > +       enum dma_slave_buswidth src_addr_width;
> > > > > > > > > > > +       enum dma_slave_buswidth dst_addr_width;
> > > > > > > > > > > +
> > > > > > > > > > > +       void __iomem *reg_base;
> > > > > > > > > > > +       int irq;
> > > > > > > > > > > +
> > > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > > +
> > > > > > > > > > > +       struct ls1x_dma_hwdesc *curr_hwdesc;
> > > > > > > > > > > +       dma_addr_t curr_hwdesc_phys;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > > +struct ls1x_dma {
> > > > > > > > > > > +       struct dma_device ddev;
> > > > > > > > > > > +       void __iomem *reg_base;
> > > > > > > > > > > +
> > > > > > > > > > > +       unsigned int nr_chans;
> > > > > > > > > > > +       struct ls1x_dma_chan chan[];
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > > +#define to_ls1x_dma_chan(dchan)                \
> > > > > > > > > > > +       container_of(dchan, struct ls1x_dma_chan, vch=
an.chan)
> > > > > > > > > > > +
> > > > > > > > > > > +#define to_ls1x_dma_desc(vd)           \
> > > > > > > > > > > +       container_of(vd, struct ls1x_dma_desc, vdesc)
> > > > > > > > > > > +
> > > > > > > > > > > +/* macros for registers read/write */
> > > > > > > > > > > +#define chan_readl(chan, off)          \
> > > > > > > > > > > +       readl((chan)->reg_base + (off))
> > > > > > > > > > > +
> > > > > > > > > > > +#define chan_writel(chan, off, val)    \
> > > > > > > > > > > +       writel((val), (chan)->reg_base + (off))
> > > > > > > > > > > +
> > > > > > > > > > > +static inline struct device *chan2dev(struct dma_cha=
n *chan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       return &chan->dev->device;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static inline int ls1x_dma_query(struct ls1x_dma_cha=
n *chan,
> > > > > > > > > > > +                                dma_addr_t *hwdesc_p=
hys)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > > > > +       int val, ret;
> > > > > > > > > > > +
> > > > > > > > > > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > > > > > > > > > +       val |=3D DMA_ASK_VALID;
> > > > > > > > > > > +       val |=3D dchan->chan_id;
> > > > > > > > > > > +       chan_writel(chan, DMA_CTRL, val);
> > > > > > > > > > > +       ret =3D readl_poll_timeout_atomic(chan->reg_b=
ase + DMA_CTRL, val,
> > > > > > > > > > > +                                       !(val & DMA_A=
SK_VALID), 0, 3000);
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               dev_err(chan2dev(dchan), "failed to q=
uery DMA\n");
> > > > > > > > > > > +
> > > > > > > > > > > +       return ret;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static inline int ls1x_dma_start(struct ls1x_dma_cha=
n *chan,
> > > > > > > > > > > +                                dma_addr_t *hwdesc_p=
hys)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > > > > +       int val, ret;
> > > > > > > > > > > +
> > > > > > > > > > > +       dev_dbg(chan2dev(dchan), "cookie=3D%d, starti=
ng hwdesc=3D%x\n",
> > > > > > > > > > > +               dchan->cookie, *hwdesc_phys);
> > > > > > > > > > > +
> > > > > > > > > > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > > > > > > > > > +       val |=3D DMA_START;
> > > > > > > > > > > +       val |=3D dchan->chan_id;
> > > > > > > > > > > +       chan_writel(chan, DMA_CTRL, val);
> > > > > > > > > > > +       ret =3D readl_poll_timeout(chan->reg_base + D=
MA_CTRL, val,
> > > > > > > > > > > +                                !(val & DMA_START), =
0, 3000);
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               dev_err(chan2dev(dchan), "failed to s=
tart DMA\n");
> > > > > > > > > > > +
> > > > > > > > > > > +       return ret;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static inline void ls1x_dma_stop(struct ls1x_dma_cha=
n *chan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       chan_writel(chan, DMA_CTRL, chan_readl(chan, =
DMA_CTRL) | DMA_STOP);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static void ls1x_dma_free_chan_resources(struct dma_=
chan *dchan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +
> > > > > > > > > > > +       dma_free_coherent(chan2dev(dchan), sizeof(str=
uct ls1x_dma_hwdesc),
> > > > > > > > > > > +                         chan->curr_hwdesc, chan->cu=
rr_hwdesc_phys);
> > > > > > > > > > > +       vchan_free_chan_resources(&chan->vchan);
> > > > > > > > > > > +       dma_pool_destroy(chan->desc_pool);
> > > > > > > > > > > +       chan->desc_pool =3D NULL;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_alloc_chan_resources(struct dma_=
chan *dchan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +
> > > > > > > > > > > +       chan->desc_pool =3D dma_pool_create(dma_chan_=
name(dchan),
> > > > > > > > > > > +                                         chan2dev(dc=
han),
> > > > > > > > > > > +                                         sizeof(stru=
ct ls1x_dma_hwdesc),
> > > > > > > > > > > +                                         __alignof__=
(struct ls1x_dma_hwdesc),
> > > > > > > > > > > +                                         0);
> > > > > > > > > > > +       if (!chan->desc_pool)
> > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > +
> > > > > > > > > > > +       /* allocate memory for querying current HW de=
scriptor */
> > > > > > > > > > > +       dma_set_coherent_mask(chan2dev(dchan), DMA_BI=
T_MASK(32));
> > > > > > > > > > > +       chan->curr_hwdesc =3D dma_alloc_coherent(chan=
2dev(dchan),
> > > > > > > > > > > +                                              sizeof=
(struct ls1x_dma_hwdesc),
> > > > > > > > > > > +                                              &chan-=
>curr_hwdesc_phys,
> > > > > > > > > > > +                                              GFP_KE=
RNEL);
> > > > > > > > > > > +       if (!chan->curr_hwdesc)
> > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static void ls1x_dma_free_desc(struct virt_dma_desc =
*vdesc)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_desc *desc =3D to_ls1x_dma_de=
sc(vdesc);
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(vdesc->tx.chan);
> > > > > > > > > > > +
> > > > > > > > > > > +       dma_pool_free(chan->desc_pool, desc->hwdesc, =
desc->hwdesc_phys);
> > > > > > > > > > > +       chan->desc =3D NULL;
> > > > > > > > > > > +       kfree(desc);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static struct ls1x_dma_desc *
> > > > > > > > > > > +ls1x_dma_alloc_desc(struct dma_chan *dchan, int sg_l=
en,
> > > > > > > > > > > +                   enum dma_transfer_direction direc=
tion,
> > > > > > > > > > > +                   enum dma_transaction_type type)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (sg_len > LS1X_DMA_MAX_DESC) {
> > > > > > > > > > > +               dev_err(chan2dev(dchan), "sg_len %u e=
xceeds limit %lu",
> > > > > > > > > > > +                       sg_len, LS1X_DMA_MAX_DESC);
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       desc =3D kzalloc(sizeof(*desc), GFP_NOWAIT);
> > > > > > > > > > > +       if (!desc)
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +
> > > > > > > > > > > +       /* allocate HW descriptors */
> > > > > > > > > > > +       desc->hwdesc =3D dma_pool_zalloc(chan->desc_p=
ool, GFP_NOWAIT,
> > > > > > > > > > > +                                      &desc->hwdesc_=
phys);
> > > > > > > > > > > +       if (!desc->hwdesc) {
> > > > > > > > > > > +               dev_err(chan2dev(dchan), "failed to a=
lloc HW descriptors\n");
> > > > > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       desc->dir =3D direction;
> > > > > > > > > > > +       desc->type =3D type;
> > > > > > > > > > > +       desc->nr_descs =3D sg_len;
> > > > > > > > > > > +
> > > > > > > > > > > +       return desc;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_setup_hwdescs(struct dma_chan *d=
chan,
> > > > > > > > > > > +                                 struct ls1x_dma_des=
c *desc,
> > > > > > > > > > > +                                 struct scatterlist =
*sgl, unsigned int sg_len)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       dma_addr_t next_hwdesc_phys =3D desc->hwdesc_=
phys;
> > > > > > > > > > > +
> > > > > > > > > > > +       struct scatterlist *sg;
> > > > > > > > > > > +       unsigned int dev_addr, cmd, i;
> > > > > > > > > > > +
> > > > > > > > > > > +       switch (desc->dir) {
> > > > > > > > > > > +       case DMA_MEM_TO_DEV:
> > > > > > > > > > > +               dev_addr =3D chan->dst_addr;
> > > > > > > > > > > +               desc->bus_width =3D chan->dst_addr_wi=
dth;
> > > > > > > > > > > +               cmd =3D DMA_RAM2DEV | DMA_INT;
> > > > > > > > > > > +               break;
> > > > > > > > > > > +       case DMA_DEV_TO_MEM:
> > > > > > > > > > > +               dev_addr =3D chan->src_addr;
> > > > > > > > > > > +               desc->bus_width =3D chan->src_addr_wi=
dth;
> > > > > > > > > > > +               cmd =3D DMA_INT;
> > > > > > > > > > > +               break;
> > > > > > > > > > > +       default:
> > > > > > > > > > > +               dev_err(chan2dev(dchan), "unsupported=
 DMA direction: %s\n",
> > > > > > > > > > > +                       dmaengine_get_direction_text(=
desc->dir));
> > > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       /* setup HW descriptors */
> > > > > > > > > > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > > > > > > > > > +               dma_addr_t buf_addr =3D sg_dma_addres=
s(sg);
> > > > > > > > > > > +               size_t buf_len =3D sg_dma_len(sg);
> > > > > > > > > > > +               struct ls1x_dma_hwdesc *hwdesc =3D &d=
esc->hwdesc[i];
> > > > > > > > > > > +
> > > > > > > > > > > +               if (!is_dma_copy_aligned(dchan->devic=
e, buf_addr, 0, buf_len)) {
> > > > > > > > > > > +                       dev_err(chan2dev(dchan), "buf=
fer is not aligned!\n");
> > > > > > > > > > > +                       return -EINVAL;
> > > > > > > > > > > +               }
> > > > > > > > > > > +
> > > > > > > > > > > +               hwdesc->saddr =3D buf_addr;
> > > > > > > > > > > +               hwdesc->daddr =3D dev_addr;
> > > > > > > > > > > +               hwdesc->length =3D buf_len / desc->bu=
s_width;
> > > > > > > > > > > +               hwdesc->stride =3D 0;
> > > > > > > > > > > +               hwdesc->cycles =3D 1;
> > > > > > > > > > > +               hwdesc->cmd =3D cmd;
> > > > > > > > > > > +
> > > > > > > > > > > +               if (i) {
> > > > > > > > > > > +                       next_hwdesc_phys +=3D sizeof(=
*hwdesc);
> > > > > > > > > > > +                       desc->hwdesc[i - 1].next =3D =
next_hwdesc_phys
> > > > > > > > > > > +                           | DMA_NEXT_VALID;
> > > > > > > > > > > +               }
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       if (desc->type =3D=3D DMA_CYCLIC)
> > > > > > > > > > > +               desc->hwdesc[i - 1].next =3D desc->hw=
desc_phys | DMA_NEXT_VALID;
> > > > > > > > > > > +
> > > > > > > > > > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > > > > > > > > > +               struct ls1x_dma_hwdesc *hwdesc =3D &d=
esc->hwdesc[i];
> > > > > > > > > > > +
> > > > > > > > > > > +               print_hex_dump_debug("HW DESC: ", DUM=
P_PREFIX_OFFSET, 16, 4,
> > > > > > > > > > > +                                    hwdesc, sizeof(*=
hwdesc), false);
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static struct dma_async_tx_descriptor *
> > > > > > > > > > > +ls1x_dma_prep_slave_sg(struct dma_chan *dchan,
> > > > > > > > > > > +                      struct scatterlist *sgl, unsig=
ned int sg_len,
> > > > > > > > > > > +                      enum dma_transfer_direction di=
rection,
> > > > > > > > > > > +                      unsigned long flags, void *con=
text)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > > +
> > > > > > > > > > > +       dev_dbg(chan2dev(dchan), "sg_len=3D%u flags=
=3D0x%lx dir=3D%s\n",
> > > > > > > > > > > +               sg_len, flags, dmaengine_get_directio=
n_text(direction));
> > > > > > > > > > > +
> > > > > > > > > > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, d=
irection, DMA_SLAVE);
> > > > > > > > > > > +       if (!desc)
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, =
sg_len)) {
> > > > > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       return vchan_tx_prep(&chan->vchan, &desc->vde=
sc, flags);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static struct dma_async_tx_descriptor *
> > > > > > > > > > > +ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan,
> > > > > > > > > > > +                        dma_addr_t buf_addr, size_t =
buf_len, size_t period_len,
> > > > > > > > > > > +                        enum dma_transfer_direction =
direction,
> > > > > > > > > > > +                        unsigned long flags)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > > +       struct scatterlist *sgl;
> > > > > > > > > > > +       unsigned int sg_len;
> > > > > > > > > > > +       unsigned int i;
> > > > > > > > > > > +
> > > > > > > > > > > +       dev_dbg(chan2dev(dchan),
> > > > > > > > > > > +               "buf_len=3D%d period_len=3D%zu flags=
=3D0x%lx dir=3D%s\n", buf_len,
> > > > > > > > > > > +               period_len, flags, dmaengine_get_dire=
ction_text(direction));
> > > > > > > > > > > +
> > > > > > > > > > > +       sg_len =3D buf_len / period_len;
> > > > > > > > > > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, d=
irection, DMA_CYCLIC);
> > > > > > > > > > > +       if (!desc)
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +
> > > > > > > > > > > +       /* allocate the scatterlist */
> > > > > > > > > > > +       sgl =3D kmalloc_array(sg_len, sizeof(*sgl), G=
FP_NOWAIT);
> > > > > > > > > > > +       if (!sgl)
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +
> > > > > > > > > > > +       sg_init_table(sgl, sg_len);
> > > > > > > > > > > +       for (i =3D 0; i < sg_len; ++i) {
> > > > > > > > > > > +               sg_set_page(&sgl[i], pfn_to_page(PFN_=
DOWN(buf_addr)),
> > > > > > > > > > > +                           period_len, offset_in_pag=
e(buf_addr));
> > > > > > > > > > > +               sg_dma_address(&sgl[i]) =3D buf_addr;
> > > > > > > > > > > +               sg_dma_len(&sgl[i]) =3D period_len;
> > > > > > > > > > > +               buf_addr +=3D period_len;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, =
sg_len)) {
> > > > > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > > > > +               return NULL;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       kfree(sgl);
> > > > > > > > > > > +
> > > > > > > > > > > +       return vchan_tx_prep(&chan->vchan, &desc->vde=
sc, flags);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_slave_config(struct dma_chan *dc=
han,
> > > > > > > > > > > +                                struct dma_slave_con=
fig *config)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +
> > > > > > > > > > > +       chan->src_addr =3D config->src_addr;
> > > > > > > > > > > +       chan->src_addr_width =3D config->src_addr_wid=
th;
> > > > > > > > > > > +       chan->dst_addr =3D config->dst_addr;
> > > > > > > > > > > +       chan->dst_addr_width =3D config->dst_addr_wid=
th;
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_pause(struct dma_chan *dchan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > > +       int ret;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > > +       ret =3D ls1x_dma_query(chan, &chan->curr_hwde=
sc_phys);
> > > > > > > > > > > +       if (!ret)
> > > > > > > > > > > +               ls1x_dma_stop(chan);
> > > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, fla=
gs);
> > > > > > > > > > > +
> > > > > > > > > > > +       return ret;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_resume(struct dma_chan *dchan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > > +       int ret;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > > +       ret =3D ls1x_dma_start(chan, &chan->curr_hwde=
sc_phys);
> > > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, fla=
gs);
> > > > > > > > > > > +
> > > > > > > > > > > +       return ret;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_terminate_all(struct dma_chan *d=
chan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > > +       LIST_HEAD(head);
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > > +       ls1x_dma_stop(chan);
> > > > > > > > > > > +       vchan_get_all_descriptors(&chan->vchan, &head=
);
> > > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, fla=
gs);
> > > > > > > > > > > +
> > > > > > > > > > > +       vchan_dma_desc_free_list(&chan->vchan, &head)=
;
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static enum dma_status ls1x_dma_tx_status(struct dma=
_chan *dchan,
> > > > > > > > > > > +                                         dma_cookie_=
t cookie,
> > > > > > > > > > > +                                         struct dma_=
tx_state *state)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       struct virt_dma_desc *vdesc;
> > > > > > > > > > > +       enum dma_status status;
> > > > > > > > > > > +       size_t bytes =3D 0;
> > > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > > +
> > > > > > > > > > > +       status =3D dma_cookie_status(dchan, cookie, s=
tate);
> > > > > > > > > > > +       if (status =3D=3D DMA_COMPLETE)
> > > > > > > > > > > +               return status;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > > +       vdesc =3D vchan_find_desc(&chan->vchan, cooki=
e);
> > > > > > > > > > > +       if (chan->desc && cookie =3D=3D chan->desc->v=
desc.tx.cookie) {
> > > > > > > > > > > +               struct ls1x_dma_desc *desc =3D chan->=
desc;
> > > > > > > > > > > +               int i;
> > > > > > > > > > > +
> > > > > > > > > > > +               if (ls1x_dma_query(chan, &chan->curr_=
hwdesc_phys))
> > > > > > > > > > > +                       return status;
> > > > > > > > > > > +
> > > > > > > > > > > +               /* locate the current HW descriptor *=
/
> > > > > > > > > > > +               for (i =3D 0; i < desc->nr_descs; i++=
)
> > > > > > > > > > > +                       if (desc->hwdesc[i].next =3D=
=3D chan->curr_hwdesc->next)
> > > > > > > > > > > +                               break;
> > > > > > > > > > > +
> > > > > > > > > > > +               /* count the residues */
> > > > > > > > > > > +               for (; i < desc->nr_descs; i++)
> > > > > > > > > > > +                       bytes +=3D desc->hwdesc[i].le=
ngth * desc->bus_width;
> > > > > > > > > > > +
> > > > > > > > > > > +               dma_set_residue(state, bytes);
> > > > > > > > > > > +       }
> > > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, fla=
gs);
> > > > > > > > > > > +
> > > > > > > > > > > +       return status;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static void ls1x_dma_issue_pending(struct dma_chan *=
dchan)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_ch=
an(dchan);
> > > > > > > > > > > +       struct virt_dma_desc *vdesc;
> > > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > > +       if (vchan_issue_pending(&chan->vchan) && !cha=
n->desc) {
> > > > > > > > > > > +               vdesc =3D vchan_next_desc(&chan->vcha=
n);
> > > > > > > > > > > +               if (!vdesc) {
> > > > > > > > > > > +                       chan->desc =3D NULL;
> > > > > > > > > > > +                       return;
> > > > > > > > > > > +               }
> > > > > > > > > > > +               chan->desc =3D to_ls1x_dma_desc(vdesc=
);
> > > > > > > > > > > +               ls1x_dma_start(chan, &chan->desc->hwd=
esc_phys);
> > > > > > > > > > > +       }
> > > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, fla=
gs);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static irqreturn_t ls1x_dma_irq_handler(int irq, voi=
d *data)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D data;
> > > > > > > > > > > +       struct ls1x_dma_desc *desc =3D chan->desc;
> > > > > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (!desc) {
> > > > > > > > > > > +               dev_warn(chan2dev(dchan),
> > > > > > > > > > > +                        "IRQ %d with no active descr=
iptor on channel %d\n",
> > > > > > > > > > > +                        irq, dchan->chan_id);
> > > > > > > > > > > +               return IRQ_NONE;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       dev_dbg(chan2dev(dchan), "DMA IRQ %d on chann=
el %d\n", irq,
> > > > > > > > > > > +               dchan->chan_id);
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&chan->vchan.lock);
> > > > > > > > > > > +
> > > > > > > > > > > +       if (desc->type =3D=3D DMA_CYCLIC) {
> > > > > > > > > > > +               vchan_cyclic_callback(&desc->vdesc);
> > > > > > > > > > > +       } else {
> > > > > > > > > > > +               list_del(&desc->vdesc.node);
> > > > > > > > > > > +               vchan_cookie_complete(&desc->vdesc);
> > > > > > > > > > > +               chan->desc =3D NULL;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_unlock(&chan->vchan.lock);
> > > > > > > > > > > +       return IRQ_HANDLED;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_chan_probe(struct platform_devic=
e *pdev,
> > > > > > > > > > > +                              struct ls1x_dma *dma, =
int chan_id)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D &dma->chan[cha=
n_id];
> > > > > > > > > > > +       char pdev_irqname[4];
> > > > > > > > > > > +       char *irqname;
> > > > > > > > > > > +       int ret;
> > > > > > > > > > > +
> > > > > > > > > > > +       sprintf(pdev_irqname, "ch%u", chan_id);
> > > > > > > > > > > +       chan->irq =3D platform_get_irq_byname(pdev, p=
dev_irqname);
> > > > > > > > > > > +       if (chan->irq < 0)
> > > > > > > > > > > +               return -ENODEV;
> > > > > > > > > > > +
> > > > > > > > > > > +       irqname =3D devm_kasprintf(dev, GFP_KERNEL, "=
%s:%s",
> > > > > > > > > > > +                                dev_name(dev), pdev_=
irqname);
> > > > > > > > > > > +       if (!irqname)
> > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > +
> > > > > > > > > > > +       ret =3D devm_request_irq(dev, chan->irq, ls1x=
_dma_irq_handler,
> > > > > > > > > > > +                              IRQF_SHARED, irqname, =
chan);
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               return dev_err_probe(dev, ret,
> > > > > > > > > > > +                                    "failed to reque=
st IRQ %u!\n", chan->irq);
> > > > > > > > > > > +
> > > > > > > > > > > +       chan->reg_base =3D dma->reg_base;
> > > > > > > > > > > +       chan->vchan.desc_free =3D ls1x_dma_free_desc;
> > > > > > > > > > > +       vchan_init(&chan->vchan, &dma->ddev);
> > > > > > > > > > > +       dev_info(dev, "%s (irq %d) initialized\n", pd=
ev_irqname, chan->irq);
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static void ls1x_dma_chan_remove(struct ls1x_dma *dm=
a, int chan_id)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct device *dev =3D dma->ddev.dev;
> > > > > > > > > > > +       struct ls1x_dma_chan *chan =3D &dma->chan[cha=
n_id];
> > > > > > > > > > > +
> > > > > > > > > > > +       devm_free_irq(dev, chan->irq, chan);
> > > > > > > > > > > +       list_del(&chan->vchan.chan.device_node);
> > > > > > > > > > > +       tasklet_kill(&chan->vchan.task);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static int ls1x_dma_probe(struct platform_device *pd=
ev)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > > > > > +       struct dma_device *ddev;
> > > > > > > > > > > +       struct ls1x_dma *dma;
> > > > > > > > > > > +       int nr_chans, ret, i;
> > > > > > > > > > > +
> > > > > > > > > > > +       nr_chans =3D platform_irq_count(pdev);
> > > > > > > > > > > +       if (nr_chans <=3D 0)
> > > > > > > > > > > +               return nr_chans;
> > > > > > > > > > > +       if (nr_chans > LS1X_DMA_MAX_CHANNELS)
> > > > > > > > > > > +               return dev_err_probe(dev, -EINVAL,
> > > > > > > > > > > +                                    "nr_chans=3D%d e=
xceeds the maximum\n",
> > > > > > > > > > > +                                    nr_chans);
> > > > > > > > > > > +
> > > > > > > > > > > +       dma =3D devm_kzalloc(dev, struct_size(dma, ch=
an, nr_chans), GFP_KERNEL);
> > > > > > > > > > > +       if (!dma)
> > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > +
> > > > > > > > > > > +       /* initialize DMA device */
> > > > > > > > > > > +       dma->reg_base =3D devm_platform_ioremap_resou=
rce(pdev, 0);
> > > > > > > > > > > +       if (IS_ERR(dma->reg_base))
> > > > > > > > > > > +               return PTR_ERR(dma->reg_base);
> > > > > > > > > > > +
> > > > > > > > > > > +       ddev =3D &dma->ddev;
> > > > > > > > > > > +       ddev->dev =3D dev;
> > > > > > > > > > > +       ddev->copy_align =3D DMAENGINE_ALIGN_4_BYTES;
> > > > > > > > > > > +       ddev->src_addr_widths =3D BIT(DMA_SLAVE_BUSWI=
DTH_1_BYTE) |
> > > > > > > > > > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA=
_SLAVE_BUSWIDTH_4_BYTES);
> > > > > > > > > > > +       ddev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWI=
DTH_1_BYTE) |
> > > > > > > > > > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA=
_SLAVE_BUSWIDTH_4_BYTES);
> > > > > > > > > > > +       ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BI=
T(DMA_MEM_TO_DEV);
> > > > > > > > > > > +       ddev->max_sg_burst =3D LS1X_DMA_MAX_DESC;
> > > > > > > > > > > +       ddev->residue_granularity =3D DMA_RESIDUE_GRA=
NULARITY_SEGMENT;
> > > > > > > > > > > +       ddev->device_alloc_chan_resources =3D ls1x_dm=
a_alloc_chan_resources;
> > > > > > > > > > > +       ddev->device_free_chan_resources =3D ls1x_dma=
_free_chan_resources;
> > > > > > > > > > > +       ddev->device_prep_slave_sg =3D ls1x_dma_prep_=
slave_sg;
> > > > > > > > > > > +       ddev->device_prep_dma_cyclic =3D ls1x_dma_pre=
p_dma_cyclic;
> > > > > > > > > > > +       ddev->device_config =3D ls1x_dma_slave_config=
;
> > > > > > > > > > > +       ddev->device_pause =3D ls1x_dma_pause;
> > > > > > > > > > > +       ddev->device_resume =3D ls1x_dma_resume;
> > > > > > > > > > > +       ddev->device_terminate_all =3D ls1x_dma_termi=
nate_all;
> > > > > > > > > > > +       ddev->device_tx_status =3D ls1x_dma_tx_status=
;
> > > > > > > > > > > +       ddev->device_issue_pending =3D ls1x_dma_issue=
_pending;
> > > > > > > > > > > +
> > > > > > > > > > > +       dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > > > > > > > > > > +       INIT_LIST_HEAD(&ddev->channels);
> > > > > > > > > > > +
> > > > > > > > > > > +       /* initialize DMA channels */
> > > > > > > > > > > +       for (i =3D 0; i < nr_chans; i++) {
> > > > > > > > > > > +               ret =3D ls1x_dma_chan_probe(pdev, dma=
, i);
> > > > > > > > > > > +               if (ret)
> > > > > > > > > > > +                       return ret;
> > > > > > > > > > > +       }
> > > > > > > > > > > +       dma->nr_chans =3D nr_chans;
> > > > > > > > > > > +
> > > > > > > > > > > +       ret =3D dmaenginem_async_device_register(ddev=
);
> > > > > > > > > > > +       if (ret) {
> > > > > > > > > > > +               dev_err(dev, "failed to register DMA =
device! %d\n", ret);
> > > > > > > > > > > +               return ret;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       ret =3D
> > > > > > > > > > > +           of_dma_controller_register(dev->of_node, =
of_dma_xlate_by_chan_id,
> > > > > > > > > > > +                                      ddev);
> > > > > > > > > > > +       if (ret) {
> > > > > > > > > > > +               dev_err(dev, "failed to register DMA =
controller! %d\n", ret);
> > > > > > > > > > > +               return ret;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       platform_set_drvdata(pdev, dma);
> > > > > > > > > > > +       dev_info(dev, "Loongson1 DMA driver registere=
d\n");
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static void ls1x_dma_remove(struct platform_device *=
pdev)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct ls1x_dma *dma =3D platform_get_drvdata=
(pdev);
> > > > > > > > > > > +       int i;
> > > > > > > > > > > +
> > > > > > > > > > > +       of_dma_controller_free(pdev->dev.of_node);
> > > > > > > > > > > +
> > > > > > > > > > > +       for (i =3D 0; i < dma->nr_chans; i++)
> > > > > > > > > > > +               ls1x_dma_chan_remove(dma, i);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static const struct of_device_id ls1x_dma_match[] =
=3D {
> > > > > > > > > > > +       { .compatible =3D "loongson,ls1b-apbdma" },
> > > > > > > > > > > +       { .compatible =3D "loongson,ls1c-apbdma" },
> > > > > > > > > > > +       { /* sentinel */ }
> > > > > > > > > > > +};
> > > > > > > > > > > +MODULE_DEVICE_TABLE(of, ls1x_dma_match);
> > > > > > > > > > > +
> > > > > > > > > > > +static struct platform_driver ls1x_dma_driver =3D {
> > > > > > > > > > > +       .probe =3D ls1x_dma_probe,
> > > > > > > > > > > +       .remove_new =3D ls1x_dma_remove,
> > > > > > > > > > > +       .driver =3D {
> > > > > > > > > > > +               .name =3D KBUILD_MODNAME,
> > > > > > > > > > > +               .of_match_table =3D ls1x_dma_match,
> > > > > > > > > > > +       },
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > > +module_platform_driver(ls1x_dma_driver);
> > > > > > > > > > > +
> > > > > > > > > > > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.co=
m>");
> > > > > > > > > > > +MODULE_DESCRIPTION("Loongson-1 APB DMA Controller dr=
iver");
> > > > > > > > > > > +MODULE_LICENSE("GPL");
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > 2.40.1
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Best regards,
> > > > > > > > >
> > > > > > > > > Keguang Zhang
> > > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Best regards,
> > > > > > >
> > > > > > > Keguang Zhang
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best regards,
> > > > >
> > > > > Keguang Zhang
> > >
> > >
> > >
> > > --
> > > Best regards,
> > >
> > > Keguang Zhang
>
>
>
> --
> Best regards,
>
> Keguang Zhang

