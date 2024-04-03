Return-Path: <dmaengine+bounces-1714-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA589627A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 04:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0B1F24CE3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 02:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4A17997;
	Wed,  3 Apr 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqh/epna"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F156FC6;
	Wed,  3 Apr 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111045; cv=none; b=GXyTcS5kmgphJynkeUnHwJsy2r44PJEWFtqnR2M9+xrag6vctzbWRXNDFU1ROiXFMocCLCZXlKkOek79P0O1Y7ZMQGb30s9NrBYt0jd3loe3xCJhn+tePJBcdTL7R0uXF4dgukqKbU95oFq9lIwRXp0gd58QjFnjEjzOYYftzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111045; c=relaxed/simple;
	bh=C9u8Ug9qidIgYE1krGvBok9diunOmUaVpO5CE07iWK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgggESM9YldaL0jMp6Wy+KaHJjCvFL3hDgCo+dlwHV/4qSLgFn3tM5Ztccbkvmz16yIx+Jlic6wKVSNeVGX0r5Z0MFBYx410g5JNH5fr7CENOOkJlgiPWaOwLtYpSDzJVkX8iLg7JdHLQd9AtE9oxba9/U/IsfiTyOfZX+D0LHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqh/epna; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso7376881a12.0;
        Tue, 02 Apr 2024 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712111041; x=1712715841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQgc/uOOuxzwzhBP1mJVuLrGHb7Kb5GrKwYZtbW1skU=;
        b=mqh/epnazbDok9O6Z1UwQ6YJ5f/phhvs9to/VW7zuvWDD+w37b6HY19EyehnMwmwvB
         CdfKRGO+NbW1X0KBymNjinFbfPJW2wiDUlb+gzvpRQabNE1EvUpe38Dm+V5SI6njNBcP
         ht9HvxSKXkmjSqoijJVZdNCky6Ke86tLdsVP6L0udUrgK8mv8P0KAfUrV7jk08u8fr4K
         J5V8fnnaDzdEOgBRabPKSDIE/B1igfVDpgGys98+GQDkeiBvSyPCn4KEqpgo3+DGyTue
         85tBVKFWWLRKrSZVKlUZOf5luIuMaj/K8W+4bxzRMapi6lkTFc6KtqOWIfmTqfhF8L/p
         W2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712111041; x=1712715841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQgc/uOOuxzwzhBP1mJVuLrGHb7Kb5GrKwYZtbW1skU=;
        b=NvgfcGxyHEsozsmi9oyUOXrlYKyRbcxn3o3W4UsJ/4b1iNmpfotK7IcWIccCEQDFof
         58FAwkIrrUpwckbZSmsvMpkr6FUBaOro59jJN7veLGpxF0e6eRJfuO/7554Uo0gLmK4B
         uLidNIAdIYfYtfRaO/2XYmDUaOX4Dm1s/Mhxzg5qK6OXHQ93fv4uwvcXnapVG2TQbDID
         aIYxG6l9Gp/YLIgI/nV0wJjDMbu/93BOilbXb3lYrYvr+j/6vQIw+LKGgXJp3Wl3O6tp
         sXAX6CTyI/3b1t+7snkOOaTzCjD1lFalrfnCMvyv1iYB8wPyD7Jo6eYPONETfcWqxI7b
         vLPg==
X-Forwarded-Encrypted: i=1; AJvYcCX1WR6IYyUIWMeTCLzZmygJxkjJKjtNkTWtVLVKqJHDAGJxp9ij7fltANzJjsc10B2qcCFzmDyA6mbdmKPlyzbfnogIZm8DEUDEt6Vh7AtcUAfHCg5TTQgbV8ljEzbQmgtDhNAcZe4xCsoZ7rDh8+O/AVQ7NY8wL0xcUNwWJXsqqAogVcoScLApowJDR7IauaBBnwqEnbVA1NWV1JL3h34=
X-Gm-Message-State: AOJu0YzenafKin2q4SSyYpoJD5WvCkwIc4uZ1vH1GPFkV2yN3avpt5PW
	2ng/3zJBeGJLiUGyvE/unx1nKpNYfrDBpeTq0VU1VElJvtXOQiSAjB6nXxEpyXEnE/EUMUohbq9
	LfW2tbS8f1SSpc3gjbgAjsAicCE0=
X-Google-Smtp-Source: AGHT+IG2721X8Fq2rxEOCFxD3ElMjH/oOOxDvqB52wlpg8rUEw9R+vID0IIt45oNIi+Qj+2j05hOYMr3qXANWo6IHP0=
X-Received: by 2002:a50:f694:0:b0:56d:fb36:c383 with SMTP id
 d20-20020a50f694000000b0056dfb36c383mr791473edn.1.1712111040571; Tue, 02 Apr
 2024 19:24:00 -0700 (PDT)
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
 <CAJhJPsWNuFMPEgDGsjdUdE1gYO3eVWLQ0QbYMXRTaMHv5bz9Ug@mail.gmail.com> <CAAhV-H5BSS1k6aCLYg4DT12nq-d4YyAKYBvy2ucLydwjVKNhBw@mail.gmail.com>
In-Reply-To: <CAAhV-H5BSS1k6aCLYg4DT12nq-d4YyAKYBvy2ucLydwjVKNhBw@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Wed, 3 Apr 2024 10:23:23 +0800
Message-ID: <CAJhJPsULnEfTMFK5HS5TQZ_0XSs77Tw58Yfvw67BtTTHvjSLLw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:50=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Tue, Apr 2, 2024 at 6:51=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > On Tue, Apr 2, 2024 at 5:04=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 9:56=E2=80=AFAM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > > >
> > > > On Mon, Apr 1, 2024 at 9:24=E2=80=AFPM Huacai Chen <chenhuacai@kern=
el.org> wrote:
> > > > >
> > > > > On Mon, Apr 1, 2024 at 7:10=E2=80=AFPM Keguang Zhang <keguang.zha=
ng@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 1, 2024 at 5:06=E2=80=AFPM Huacai Chen <chenhuacai@=
kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 1, 2024 at 10:45=E2=80=AFAM Keguang Zhang <keguan=
g.zhang@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Huacai,
> > > > > > > >
> > > > > > > > On Sat, Mar 30, 2024 at 9:59=E2=80=AFPM Huacai Chen <chenhu=
acai@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi, Keguang,
> > > > > > > > >
> > > > > > > > > On Fri, Mar 29, 2024 at 7:28=E2=80=AFPM Keguang Zhang via=
 B4 Relay
> > > > > > > > > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > > > > > > > > >
> > > > > > > > > > This patch adds APB DMA driver for Loongson-1 SoCs.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > > Changes in v7:
> > > > > > > > > > - Change the comptible to 'loongson,ls1*-apbdma'
> > > > > > > > > > - Update Kconfig and Makefile accordingly
> > > > > > > > > > - Rename the file to loongson1-apb-dma.c to keep the co=
nsistency
> > > > > > > > > >
> > > > > > > > > > Changes in v6:
> > > > > > > > > > - Implement .device_prep_dma_cyclic for Loongson1 audio=
 driver,
> > > > > > > > > > - as well as .device_pause and .device_resume.
> > > > > > > > > > - Set the limitation LS1X_DMA_MAX_DESC and put all desc=
riptors
> > > > > > > > > > - into one page to save memory
> > > > > > > > > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > > > > > > > > > - Drop dma_slave_config structure
> > > > > > > > > > - Use .remove_new instead of .remove
> > > > > > > > > > - Use KBUILD_MODNAME for the driver name
> > > > > > > > > > - Improve the debug information
> > > > > > > > > >
> > > > > > > > > > Changes in v5:
> > > > > > > > > > - Add DT support
> > > > > > > > > > - Use DT data instead of platform data
> > > > > > > > > > - Use chan_id of struct dma_chan instead of own id
> > > > > > > > > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_fil=
ter()
> > > > > > > > > > - Update the author information to my official name
> > > > > > > > > >
> > > > > > > > > > Changes in v4:
> > > > > > > > > > - Use dma_slave_map to find the proper channel.
> > > > > > > > > > - Explicitly call devm_request_irq() and tasklet_kill()=
.
> > > > > > > > > > - Fix namespace issue.
> > > > > > > > > > - Some minor fixes and cleanups.
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_=
DMA',
> > > > > > > > > > - and rearrange it in alphabetical order in Kconfig and=
 Makefile.
> > > > > > > > > > - Fix comment style.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/dma/Kconfig             |   9 +
> > > > > > > > > >  drivers/dma/Makefile            |   1 +
> > > > > > > > > >  drivers/dma/loongson1-apb-dma.c | 665 ++++++++++++++++=
++++++++++++++++++++++++
> > > > > > > > > >  3 files changed, 675 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > > > > > > > > index 002a5ec80620..f7b06c4cdf3f 100644
> > > > > > > > > > --- a/drivers/dma/Kconfig
> > > > > > > > > > +++ b/drivers/dma/Kconfig
> > > > > > > > > > @@ -369,6 +369,15 @@ config K3_DMA
> > > > > > > > > >           Support the DMA engine for Hisilicon K3 platf=
orm
> > > > > > > > > >           devices.
> > > > > > > > > >
> > > > > > > > > > +config LOONGSON1_APB_DMA
> > > > > > > > > > +       tristate "Loongson1 APB DMA support"
> > > > > > > > > > +       depends on MACH_LOONGSON32 || COMPILE_TEST
> > > > > > > > > > +       select DMA_ENGINE
> > > > > > > > > > +       select DMA_VIRTUAL_CHANNELS
> > > > > > > > > > +       help
> > > > > > > > > > +         This selects support for the APB DMA controll=
er in Loongson1 SoCs,
> > > > > > > > > > +         which is required by Loongson1 NAND and audio=
 support.
> > > > > > > > > Why not rename to LS1X_APB_DMA and put it just before LS2=
X_APB_DMA
> > > > > > > > > (and also the driver file name)?
> > > > > > > > >
> > > > > > > > So far all Kconfig entries of Loongson-1 drivers are named =
with the
> > > > > > > > keyword "LOONGSON1".
> > > > > > > > The same is true for these file names.
> > > > > > > > Therefore, I need to keep the consistency.
> > > > > > > But I see LS1X_IRQ in drivers/irqchip/Kconfig
> > > > > > >
> > > > > > Indeed, that's an exception, which was submitted by Jiaxun seve=
ral years ago.
> > > > > > Actually, most drivers of Loongson family use the keyword "LOON=
GSON"
> > > > > > for Kconfig and "loongson" for filename.
> > > > > > Thus I take this keywork as the naming convention.
> > > > > But I think keeping consistency in a same subsystem is better tha=
n
> > > > > keeping consistency in a same SoC (but cross subsystems).
> > > > >
> > > > In my opinion, "LS*X" is too short and may be confused with other S=
oCs.
> > > > Meanwhile, there are only four drivers that use this keyword.
> > > >   config I2C_LS2X
> > > >   config LS2K_RESET
> > > >   config LS2X_APB_DMA
> > > >   config LS1X_IRQ
> > > > Then, my suggestion is to change these "LS*X" to "LOONGSON*" to get=
 a
> > > > clear meaning.
> > > We have made a naming conversion some years before with Jiaxun.
> > > 1, Use "Loongson" for CPU in arch code;
> > > 2, Use "LS7A" or something like this for bridges and devices.
> > > 3, For drivers in SoC, if the driver is specific to Loongson-1, use
> > > LS1X, if it is to Loongson-2, use LS2X, if it is shared by both
> > > Loongson-1 and Loongson-2, use LOONGSON.
> > >
> > OK. But the doesn't the answer the question of confusion, such as
> > "Freescale LS1021A".
> > The same problem happens to the filenames.
> >   ./drivers/gpu/drm/nouveau/nvkm/nvfw/ls.c
> >   ./drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> >   ./drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> >   ./drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
> >   ./arch/powerpc/platforms/embedded6xx/ls_uart.c
> > Regarding "LS*X" itself, it contains the wildcard character "X" which
> > itself is confusing.
> > Therefore, I don't think "LS*X" is clear enough.
> >
The confusion problem remains.
Honestly, I don't think "LS" is a good short for "LOONGSON".

> > On the other hand, I see "LOONGSON2_*" strings are still there.
This question remains.

> > In addition, some of "LOONGSON_" definitions are not applicable for
> > Loongson-1 at all, which breaks your convention.
> >   config SND_SOC_LOONGSON_I2S_PCI  /* Loongson-1 doesn't support I2S */
> >   config SND_SOC_LOONGSON_CARD
> They are shared by LS2K and LS7A.
>
> >   config DWMAC_LOONGSON1
> >   config DWMAC_LOONGSON  /* This glue layer doesn't support Loongson-1 =
*/
> >   config COMMON_CLK_LOONGSON2
unaddressed

> >   config RTC_DRV_LOONGSON
> RTC is shared by LS2K and LS7A.
>
> >   config SPI_LOONGSON_CORE
> >   config SPI_LOONGSON_PCI  /* N/A for Loongson-1 */
> >   config SPI_LOONGSON_PLATFORM
> SPI is also shared by LS2K and LS7A.
>
> >   config LOONGSON2_CPUFREQ
unaddressed

> >   config DRM_LOONGSON  /* N/A for Loongson-1 */
> DRM is also shared by LS2K and LS7A.
>
> >   config LOONGSON1_WDT
> >   config CLKSRC_LOONGSON1_PWM
> >   config LOONGSON_LIOINTC  /* N/A for Loongson-1 */
> >   config LOONGSON_EIOINTC  /* N/A for Loongson-1 */
> >   config LOONGSON_HTPIC  /* N/A for Loongson-1 */
> >   config LOONGSON_HTVEC  /* N/A for Loongson-1 */
> >   config LOONGSON_PCH_PIC  /* N/A for Loongson-1 */
> >   config LOONGSON_PCH_MSI  /* N/A for Loongson-1 */
> >   config LOONGSON_PCH_LPC  /* N/A for Loongson-1 */
> All interrupt controllers are shared by Loongson-2 and Loongson-3.
>
> >   config PINCTRL_LOONGSON2
unaddressed
> >   config LOONGSON2_THERMAL
ditto
> >   config LOONGSON2_GUTS
ditto
> >   config LOONGSON2_PM
ditto
> >   config LOONGSON_LAPTOP  /* N/A for Loongson-1 */
> Laptop driver is shared by Loongson-2 and Loongson-3.
>
> >   config GPIO_LOONGSON
> >   config GPIO_LOONGSON_64BIT  -> N/A for Loongson-1
> >   config GPIO_LOONGSON1
> GPIO driver is shared by LS2K and LS7A.
>
> >   config PCI_LOONGSON
> PCI driver is shared by Loongson-2 and Loongson-3.

You said "if it is shared by both Loongson-1 and Loongson-2, use LOONGSON."
Now the rule changes from "Loongson-1 and Loongson-2" to "Loongson-2
and Loongson-3".
Then, when shall we use "LOONGSON"?

Here is the situation: only are four drivers use "LS*".
  config I2C_LS2X
  config LS2K_RESET
  config LS2X_APB_DMA
  config LS1X_IRQ
My suggestion is to use the intuitive "LOONGSON*" for both CPU and
drivers, which is easy to understand.
And replace the confusing and unclear "LS*X" with "LOONGSON*".
Use "LOONGSON" when the driver/feature is shared with Loongson-1,
Loongson-2 and Loongson-3.
>
> >
> > What's your plan about the above Kconfig entries?
> Yes, there are exceptions indeed, but very rare. And some of the
> exceptions are due to the limited spare time of Jiaxun and me. But in
> this case, it is better to keep consistency in the DMA subsystem.
>
Sorry, I'm not persuaded.
Please consider my proposal.
Thanks!

> Huacai
>
> > Why can't we use LOONGSON1/LOONGSON2 for drivers?
> >
> >
> > > Huacai
> > >
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > > > Huacai
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > Huacai
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > >  config LPC18XX_DMAMUX
> > > > > > > > > >         bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > > > > > > > > >         depends on ARCH_LPC18XX || COMPILE_TEST
> > > > > > > > > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefil=
e
> > > > > > > > > > index dfd40d14e408..b26f6677978a 100644
> > > > > > > > > > --- a/drivers/dma/Makefile
> > > > > > > > > > +++ b/drivers/dma/Makefile
> > > > > > > > > > @@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma6=
4.o
> > > > > > > > > >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> > > > > > > > > >  obj-y +=3D idxd/
> > > > > > > > > >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > > > > > > > > > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma=
.o
> > > > > > > > > >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > > > > > > > > >  obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> > > > > > > > > >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > > > > > > > > > diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/=
dma/loongson1-apb-dma.c
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..d474a2601e6e
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/drivers/dma/loongson1-apb-dma.c
> > > > > > > > > > @@ -0,0 +1,665 @@
> > > > > > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > > +/*
> > > > > > > > > > + * Driver for Loongson-1 APB DMA Controller
> > > > > > > > > > + *
> > > > > > > > > > + * Copyright (C) 2015-2024 Keguang Zhang <keguang.zhan=
g@gmail.com>
> > > > > > > > > > + */
> > > > > > > > > > +
> > > > > > > > > > +#include <linux/dmapool.h>
> > > > > > > > > > +#include <linux/dma-mapping.h>
> > > > > > > > > > +#include <linux/init.h>
> > > > > > > > > > +#include <linux/interrupt.h>
> > > > > > > > > > +#include <linux/iopoll.h>
> > > > > > > > > > +#include <linux/module.h>
> > > > > > > > > > +#include <linux/of.h>
> > > > > > > > > > +#include <linux/of_dma.h>
> > > > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > > > +#include <linux/slab.h>
> > > > > > > > > > +
> > > > > > > > > > +#include "dmaengine.h"
> > > > > > > > > > +#include "virt-dma.h"
> > > > > > > > > > +
> > > > > > > > > > +/* Loongson-1 DMA Control Register */
> > > > > > > > > > +#define DMA_CTRL                       0x0
> > > > > > > > > > +
> > > > > > > > > > +/* DMA Control Register Bits */
> > > > > > > > > > +#define DMA_STOP                       BIT(4)
> > > > > > > > > > +#define DMA_START                      BIT(3)
> > > > > > > > > > +#define DMA_ASK_VALID                  BIT(2)
> > > > > > > > > > +
> > > > > > > > > > +#define DMA_ADDR_MASK                  GENMASK(31, 6)
> > > > > > > > > > +
> > > > > > > > > > +/* DMA Next Field Bits */
> > > > > > > > > > +#define DMA_NEXT_VALID                 BIT(0)
> > > > > > > > > > +
> > > > > > > > > > +/* DMA Command Field Bits */
> > > > > > > > > > +#define DMA_RAM2DEV                    BIT(12)
> > > > > > > > > > +#define DMA_INT                                BIT(1)
> > > > > > > > > > +#define DMA_INT_MASK                   BIT(0)
> > > > > > > > > > +
> > > > > > > > > > +#define LS1X_DMA_MAX_CHANNELS          3
> > > > > > > > > > +
> > > > > > > > > > +/* Size of allocations for hardware descriptors */
> > > > > > > > > > +#define LS1X_DMA_DESCS_SIZE            PAGE_SIZE
> > > > > > > > > > +#define LS1X_DMA_MAX_DESC              \
> > > > > > > > > > +       (LS1X_DMA_DESCS_SIZE / sizeof(struct ls1x_dma_h=
wdesc))
> > > > > > > > > > +
> > > > > > > > > > +struct ls1x_dma_hwdesc {
> > > > > > > > > > +       u32 next;               /* next descriptor addr=
ess */
> > > > > > > > > > +       u32 saddr;              /* memory DMA address *=
/
> > > > > > > > > > +       u32 daddr;              /* device DMA address *=
/
> > > > > > > > > > +       u32 length;
> > > > > > > > > > +       u32 stride;
> > > > > > > > > > +       u32 cycles;
> > > > > > > > > > +       u32 cmd;
> > > > > > > > > > +       u32 stats;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +struct ls1x_dma_desc {
> > > > > > > > > > +       struct virt_dma_desc vdesc;
> > > > > > > > > > +       enum dma_transfer_direction dir;
> > > > > > > > > > +       enum dma_transaction_type type;
> > > > > > > > > > +       unsigned int bus_width;
> > > > > > > > > > +
> > > > > > > > > > +       unsigned int nr_descs;  /* number of descriptor=
s */
> > > > > > > > > > +
> > > > > > > > > > +       struct ls1x_dma_hwdesc *hwdesc;
> > > > > > > > > > +       dma_addr_t hwdesc_phys;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +struct ls1x_dma_chan {
> > > > > > > > > > +       struct virt_dma_chan vchan;
> > > > > > > > > > +       struct dma_pool *desc_pool;
> > > > > > > > > > +       phys_addr_t src_addr;
> > > > > > > > > > +       phys_addr_t dst_addr;
> > > > > > > > > > +       enum dma_slave_buswidth src_addr_width;
> > > > > > > > > > +       enum dma_slave_buswidth dst_addr_width;
> > > > > > > > > > +
> > > > > > > > > > +       void __iomem *reg_base;
> > > > > > > > > > +       int irq;
> > > > > > > > > > +
> > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > +
> > > > > > > > > > +       struct ls1x_dma_hwdesc *curr_hwdesc;
> > > > > > > > > > +       dma_addr_t curr_hwdesc_phys;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +struct ls1x_dma {
> > > > > > > > > > +       struct dma_device ddev;
> > > > > > > > > > +       void __iomem *reg_base;
> > > > > > > > > > +
> > > > > > > > > > +       unsigned int nr_chans;
> > > > > > > > > > +       struct ls1x_dma_chan chan[];
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +#define to_ls1x_dma_chan(dchan)                \
> > > > > > > > > > +       container_of(dchan, struct ls1x_dma_chan, vchan=
.chan)
> > > > > > > > > > +
> > > > > > > > > > +#define to_ls1x_dma_desc(vd)           \
> > > > > > > > > > +       container_of(vd, struct ls1x_dma_desc, vdesc)
> > > > > > > > > > +
> > > > > > > > > > +/* macros for registers read/write */
> > > > > > > > > > +#define chan_readl(chan, off)          \
> > > > > > > > > > +       readl((chan)->reg_base + (off))
> > > > > > > > > > +
> > > > > > > > > > +#define chan_writel(chan, off, val)    \
> > > > > > > > > > +       writel((val), (chan)->reg_base + (off))
> > > > > > > > > > +
> > > > > > > > > > +static inline struct device *chan2dev(struct dma_chan =
*chan)
> > > > > > > > > > +{
> > > > > > > > > > +       return &chan->dev->device;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static inline int ls1x_dma_query(struct ls1x_dma_chan =
*chan,
> > > > > > > > > > +                                dma_addr_t *hwdesc_phy=
s)
> > > > > > > > > > +{
> > > > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > > > +       int val, ret;
> > > > > > > > > > +
> > > > > > > > > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > > > > > > > > +       val |=3D DMA_ASK_VALID;
> > > > > > > > > > +       val |=3D dchan->chan_id;
> > > > > > > > > > +       chan_writel(chan, DMA_CTRL, val);
> > > > > > > > > > +       ret =3D readl_poll_timeout_atomic(chan->reg_bas=
e + DMA_CTRL, val,
> > > > > > > > > > +                                       !(val & DMA_ASK=
_VALID), 0, 3000);
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               dev_err(chan2dev(dchan), "failed to que=
ry DMA\n");
> > > > > > > > > > +
> > > > > > > > > > +       return ret;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static inline int ls1x_dma_start(struct ls1x_dma_chan =
*chan,
> > > > > > > > > > +                                dma_addr_t *hwdesc_phy=
s)
> > > > > > > > > > +{
> > > > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > > > +       int val, ret;
> > > > > > > > > > +
> > > > > > > > > > +       dev_dbg(chan2dev(dchan), "cookie=3D%d, starting=
 hwdesc=3D%x\n",
> > > > > > > > > > +               dchan->cookie, *hwdesc_phys);
> > > > > > > > > > +
> > > > > > > > > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > > > > > > > > +       val |=3D DMA_START;
> > > > > > > > > > +       val |=3D dchan->chan_id;
> > > > > > > > > > +       chan_writel(chan, DMA_CTRL, val);
> > > > > > > > > > +       ret =3D readl_poll_timeout(chan->reg_base + DMA=
_CTRL, val,
> > > > > > > > > > +                                !(val & DMA_START), 0,=
 3000);
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               dev_err(chan2dev(dchan), "failed to sta=
rt DMA\n");
> > > > > > > > > > +
> > > > > > > > > > +       return ret;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static inline void ls1x_dma_stop(struct ls1x_dma_chan =
*chan)
> > > > > > > > > > +{
> > > > > > > > > > +       chan_writel(chan, DMA_CTRL, chan_readl(chan, DM=
A_CTRL) | DMA_STOP);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void ls1x_dma_free_chan_resources(struct dma_ch=
an *dchan)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +
> > > > > > > > > > +       dma_free_coherent(chan2dev(dchan), sizeof(struc=
t ls1x_dma_hwdesc),
> > > > > > > > > > +                         chan->curr_hwdesc, chan->curr=
_hwdesc_phys);
> > > > > > > > > > +       vchan_free_chan_resources(&chan->vchan);
> > > > > > > > > > +       dma_pool_destroy(chan->desc_pool);
> > > > > > > > > > +       chan->desc_pool =3D NULL;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_alloc_chan_resources(struct dma_ch=
an *dchan)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +
> > > > > > > > > > +       chan->desc_pool =3D dma_pool_create(dma_chan_na=
me(dchan),
> > > > > > > > > > +                                         chan2dev(dcha=
n),
> > > > > > > > > > +                                         sizeof(struct=
 ls1x_dma_hwdesc),
> > > > > > > > > > +                                         __alignof__(s=
truct ls1x_dma_hwdesc),
> > > > > > > > > > +                                         0);
> > > > > > > > > > +       if (!chan->desc_pool)
> > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +       /* allocate memory for querying current HW desc=
riptor */
> > > > > > > > > > +       dma_set_coherent_mask(chan2dev(dchan), DMA_BIT_=
MASK(32));
> > > > > > > > > > +       chan->curr_hwdesc =3D dma_alloc_coherent(chan2d=
ev(dchan),
> > > > > > > > > > +                                              sizeof(s=
truct ls1x_dma_hwdesc),
> > > > > > > > > > +                                              &chan->c=
urr_hwdesc_phys,
> > > > > > > > > > +                                              GFP_KERN=
EL);
> > > > > > > > > > +       if (!chan->curr_hwdesc)
> > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void ls1x_dma_free_desc(struct virt_dma_desc *v=
desc)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_desc *desc =3D to_ls1x_dma_desc=
(vdesc);
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(vdesc->tx.chan);
> > > > > > > > > > +
> > > > > > > > > > +       dma_pool_free(chan->desc_pool, desc->hwdesc, de=
sc->hwdesc_phys);
> > > > > > > > > > +       chan->desc =3D NULL;
> > > > > > > > > > +       kfree(desc);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static struct ls1x_dma_desc *
> > > > > > > > > > +ls1x_dma_alloc_desc(struct dma_chan *dchan, int sg_len=
,
> > > > > > > > > > +                   enum dma_transfer_direction directi=
on,
> > > > > > > > > > +                   enum dma_transaction_type type)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > +
> > > > > > > > > > +       if (sg_len > LS1X_DMA_MAX_DESC) {
> > > > > > > > > > +               dev_err(chan2dev(dchan), "sg_len %u exc=
eeds limit %lu",
> > > > > > > > > > +                       sg_len, LS1X_DMA_MAX_DESC);
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       desc =3D kzalloc(sizeof(*desc), GFP_NOWAIT);
> > > > > > > > > > +       if (!desc)
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +
> > > > > > > > > > +       /* allocate HW descriptors */
> > > > > > > > > > +       desc->hwdesc =3D dma_pool_zalloc(chan->desc_poo=
l, GFP_NOWAIT,
> > > > > > > > > > +                                      &desc->hwdesc_ph=
ys);
> > > > > > > > > > +       if (!desc->hwdesc) {
> > > > > > > > > > +               dev_err(chan2dev(dchan), "failed to all=
oc HW descriptors\n");
> > > > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       desc->dir =3D direction;
> > > > > > > > > > +       desc->type =3D type;
> > > > > > > > > > +       desc->nr_descs =3D sg_len;
> > > > > > > > > > +
> > > > > > > > > > +       return desc;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_setup_hwdescs(struct dma_chan *dch=
an,
> > > > > > > > > > +                                 struct ls1x_dma_desc =
*desc,
> > > > > > > > > > +                                 struct scatterlist *s=
gl, unsigned int sg_len)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       dma_addr_t next_hwdesc_phys =3D desc->hwdesc_ph=
ys;
> > > > > > > > > > +
> > > > > > > > > > +       struct scatterlist *sg;
> > > > > > > > > > +       unsigned int dev_addr, cmd, i;
> > > > > > > > > > +
> > > > > > > > > > +       switch (desc->dir) {
> > > > > > > > > > +       case DMA_MEM_TO_DEV:
> > > > > > > > > > +               dev_addr =3D chan->dst_addr;
> > > > > > > > > > +               desc->bus_width =3D chan->dst_addr_widt=
h;
> > > > > > > > > > +               cmd =3D DMA_RAM2DEV | DMA_INT;
> > > > > > > > > > +               break;
> > > > > > > > > > +       case DMA_DEV_TO_MEM:
> > > > > > > > > > +               dev_addr =3D chan->src_addr;
> > > > > > > > > > +               desc->bus_width =3D chan->src_addr_widt=
h;
> > > > > > > > > > +               cmd =3D DMA_INT;
> > > > > > > > > > +               break;
> > > > > > > > > > +       default:
> > > > > > > > > > +               dev_err(chan2dev(dchan), "unsupported D=
MA direction: %s\n",
> > > > > > > > > > +                       dmaengine_get_direction_text(de=
sc->dir));
> > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       /* setup HW descriptors */
> > > > > > > > > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > > > > > > > > +               dma_addr_t buf_addr =3D sg_dma_address(=
sg);
> > > > > > > > > > +               size_t buf_len =3D sg_dma_len(sg);
> > > > > > > > > > +               struct ls1x_dma_hwdesc *hwdesc =3D &des=
c->hwdesc[i];
> > > > > > > > > > +
> > > > > > > > > > +               if (!is_dma_copy_aligned(dchan->device,=
 buf_addr, 0, buf_len)) {
> > > > > > > > > > +                       dev_err(chan2dev(dchan), "buffe=
r is not aligned!\n");
> > > > > > > > > > +                       return -EINVAL;
> > > > > > > > > > +               }
> > > > > > > > > > +
> > > > > > > > > > +               hwdesc->saddr =3D buf_addr;
> > > > > > > > > > +               hwdesc->daddr =3D dev_addr;
> > > > > > > > > > +               hwdesc->length =3D buf_len / desc->bus_=
width;
> > > > > > > > > > +               hwdesc->stride =3D 0;
> > > > > > > > > > +               hwdesc->cycles =3D 1;
> > > > > > > > > > +               hwdesc->cmd =3D cmd;
> > > > > > > > > > +
> > > > > > > > > > +               if (i) {
> > > > > > > > > > +                       next_hwdesc_phys +=3D sizeof(*h=
wdesc);
> > > > > > > > > > +                       desc->hwdesc[i - 1].next =3D ne=
xt_hwdesc_phys
> > > > > > > > > > +                           | DMA_NEXT_VALID;
> > > > > > > > > > +               }
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       if (desc->type =3D=3D DMA_CYCLIC)
> > > > > > > > > > +               desc->hwdesc[i - 1].next =3D desc->hwde=
sc_phys | DMA_NEXT_VALID;
> > > > > > > > > > +
> > > > > > > > > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > > > > > > > > +               struct ls1x_dma_hwdesc *hwdesc =3D &des=
c->hwdesc[i];
> > > > > > > > > > +
> > > > > > > > > > +               print_hex_dump_debug("HW DESC: ", DUMP_=
PREFIX_OFFSET, 16, 4,
> > > > > > > > > > +                                    hwdesc, sizeof(*hw=
desc), false);
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static struct dma_async_tx_descriptor *
> > > > > > > > > > +ls1x_dma_prep_slave_sg(struct dma_chan *dchan,
> > > > > > > > > > +                      struct scatterlist *sgl, unsigne=
d int sg_len,
> > > > > > > > > > +                      enum dma_transfer_direction dire=
ction,
> > > > > > > > > > +                      unsigned long flags, void *conte=
xt)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > +
> > > > > > > > > > +       dev_dbg(chan2dev(dchan), "sg_len=3D%u flags=3D0=
x%lx dir=3D%s\n",
> > > > > > > > > > +               sg_len, flags, dmaengine_get_direction_=
text(direction));
> > > > > > > > > > +
> > > > > > > > > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, dir=
ection, DMA_SLAVE);
> > > > > > > > > > +       if (!desc)
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +
> > > > > > > > > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg=
_len)) {
> > > > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       return vchan_tx_prep(&chan->vchan, &desc->vdesc=
, flags);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static struct dma_async_tx_descriptor *
> > > > > > > > > > +ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan,
> > > > > > > > > > +                        dma_addr_t buf_addr, size_t bu=
f_len, size_t period_len,
> > > > > > > > > > +                        enum dma_transfer_direction di=
rection,
> > > > > > > > > > +                        unsigned long flags)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       struct ls1x_dma_desc *desc;
> > > > > > > > > > +       struct scatterlist *sgl;
> > > > > > > > > > +       unsigned int sg_len;
> > > > > > > > > > +       unsigned int i;
> > > > > > > > > > +
> > > > > > > > > > +       dev_dbg(chan2dev(dchan),
> > > > > > > > > > +               "buf_len=3D%d period_len=3D%zu flags=3D=
0x%lx dir=3D%s\n", buf_len,
> > > > > > > > > > +               period_len, flags, dmaengine_get_direct=
ion_text(direction));
> > > > > > > > > > +
> > > > > > > > > > +       sg_len =3D buf_len / period_len;
> > > > > > > > > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, dir=
ection, DMA_CYCLIC);
> > > > > > > > > > +       if (!desc)
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +
> > > > > > > > > > +       /* allocate the scatterlist */
> > > > > > > > > > +       sgl =3D kmalloc_array(sg_len, sizeof(*sgl), GFP=
_NOWAIT);
> > > > > > > > > > +       if (!sgl)
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +
> > > > > > > > > > +       sg_init_table(sgl, sg_len);
> > > > > > > > > > +       for (i =3D 0; i < sg_len; ++i) {
> > > > > > > > > > +               sg_set_page(&sgl[i], pfn_to_page(PFN_DO=
WN(buf_addr)),
> > > > > > > > > > +                           period_len, offset_in_page(=
buf_addr));
> > > > > > > > > > +               sg_dma_address(&sgl[i]) =3D buf_addr;
> > > > > > > > > > +               sg_dma_len(&sgl[i]) =3D period_len;
> > > > > > > > > > +               buf_addr +=3D period_len;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg=
_len)) {
> > > > > > > > > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > > > > > > > > +               return NULL;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       kfree(sgl);
> > > > > > > > > > +
> > > > > > > > > > +       return vchan_tx_prep(&chan->vchan, &desc->vdesc=
, flags);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_slave_config(struct dma_chan *dcha=
n,
> > > > > > > > > > +                                struct dma_slave_confi=
g *config)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +
> > > > > > > > > > +       chan->src_addr =3D config->src_addr;
> > > > > > > > > > +       chan->src_addr_width =3D config->src_addr_width=
;
> > > > > > > > > > +       chan->dst_addr =3D config->dst_addr;
> > > > > > > > > > +       chan->dst_addr_width =3D config->dst_addr_width=
;
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_pause(struct dma_chan *dchan)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > +       int ret;
> > > > > > > > > > +
> > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > +       ret =3D ls1x_dma_query(chan, &chan->curr_hwdesc=
_phys);
> > > > > > > > > > +       if (!ret)
> > > > > > > > > > +               ls1x_dma_stop(chan);
> > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags=
);
> > > > > > > > > > +
> > > > > > > > > > +       return ret;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_resume(struct dma_chan *dchan)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > +       int ret;
> > > > > > > > > > +
> > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > +       ret =3D ls1x_dma_start(chan, &chan->curr_hwdesc=
_phys);
> > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags=
);
> > > > > > > > > > +
> > > > > > > > > > +       return ret;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_terminate_all(struct dma_chan *dch=
an)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > +       LIST_HEAD(head);
> > > > > > > > > > +
> > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > +       ls1x_dma_stop(chan);
> > > > > > > > > > +       vchan_get_all_descriptors(&chan->vchan, &head);
> > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags=
);
> > > > > > > > > > +
> > > > > > > > > > +       vchan_dma_desc_free_list(&chan->vchan, &head);
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static enum dma_status ls1x_dma_tx_status(struct dma_c=
han *dchan,
> > > > > > > > > > +                                         dma_cookie_t =
cookie,
> > > > > > > > > > +                                         struct dma_tx=
_state *state)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       struct virt_dma_desc *vdesc;
> > > > > > > > > > +       enum dma_status status;
> > > > > > > > > > +       size_t bytes =3D 0;
> > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > +
> > > > > > > > > > +       status =3D dma_cookie_status(dchan, cookie, sta=
te);
> > > > > > > > > > +       if (status =3D=3D DMA_COMPLETE)
> > > > > > > > > > +               return status;
> > > > > > > > > > +
> > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > +       vdesc =3D vchan_find_desc(&chan->vchan, cookie)=
;
> > > > > > > > > > +       if (chan->desc && cookie =3D=3D chan->desc->vde=
sc.tx.cookie) {
> > > > > > > > > > +               struct ls1x_dma_desc *desc =3D chan->de=
sc;
> > > > > > > > > > +               int i;
> > > > > > > > > > +
> > > > > > > > > > +               if (ls1x_dma_query(chan, &chan->curr_hw=
desc_phys))
> > > > > > > > > > +                       return status;
> > > > > > > > > > +
> > > > > > > > > > +               /* locate the current HW descriptor */
> > > > > > > > > > +               for (i =3D 0; i < desc->nr_descs; i++)
> > > > > > > > > > +                       if (desc->hwdesc[i].next =3D=3D=
 chan->curr_hwdesc->next)
> > > > > > > > > > +                               break;
> > > > > > > > > > +
> > > > > > > > > > +               /* count the residues */
> > > > > > > > > > +               for (; i < desc->nr_descs; i++)
> > > > > > > > > > +                       bytes +=3D desc->hwdesc[i].leng=
th * desc->bus_width;
> > > > > > > > > > +
> > > > > > > > > > +               dma_set_residue(state, bytes);
> > > > > > > > > > +       }
> > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags=
);
> > > > > > > > > > +
> > > > > > > > > > +       return status;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void ls1x_dma_issue_pending(struct dma_chan *dc=
han)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan=
(dchan);
> > > > > > > > > > +       struct virt_dma_desc *vdesc;
> > > > > > > > > > +       unsigned long flags;
> > > > > > > > > > +
> > > > > > > > > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > > > > > > +       if (vchan_issue_pending(&chan->vchan) && !chan-=
>desc) {
> > > > > > > > > > +               vdesc =3D vchan_next_desc(&chan->vchan)=
;
> > > > > > > > > > +               if (!vdesc) {
> > > > > > > > > > +                       chan->desc =3D NULL;
> > > > > > > > > > +                       return;
> > > > > > > > > > +               }
> > > > > > > > > > +               chan->desc =3D to_ls1x_dma_desc(vdesc);
> > > > > > > > > > +               ls1x_dma_start(chan, &chan->desc->hwdes=
c_phys);
> > > > > > > > > > +       }
> > > > > > > > > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags=
);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static irqreturn_t ls1x_dma_irq_handler(int irq, void =
*data)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D data;
> > > > > > > > > > +       struct ls1x_dma_desc *desc =3D chan->desc;
> > > > > > > > > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > > > > > > > > +
> > > > > > > > > > +       if (!desc) {
> > > > > > > > > > +               dev_warn(chan2dev(dchan),
> > > > > > > > > > +                        "IRQ %d with no active descrip=
tor on channel %d\n",
> > > > > > > > > > +                        irq, dchan->chan_id);
> > > > > > > > > > +               return IRQ_NONE;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel=
 %d\n", irq,
> > > > > > > > > > +               dchan->chan_id);
> > > > > > > > > > +
> > > > > > > > > > +       spin_lock(&chan->vchan.lock);
> > > > > > > > > > +
> > > > > > > > > > +       if (desc->type =3D=3D DMA_CYCLIC) {
> > > > > > > > > > +               vchan_cyclic_callback(&desc->vdesc);
> > > > > > > > > > +       } else {
> > > > > > > > > > +               list_del(&desc->vdesc.node);
> > > > > > > > > > +               vchan_cookie_complete(&desc->vdesc);
> > > > > > > > > > +               chan->desc =3D NULL;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       spin_unlock(&chan->vchan.lock);
> > > > > > > > > > +       return IRQ_HANDLED;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_chan_probe(struct platform_device =
*pdev,
> > > > > > > > > > +                              struct ls1x_dma *dma, in=
t chan_id)
> > > > > > > > > > +{
> > > > > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D &dma->chan[chan_=
id];
> > > > > > > > > > +       char pdev_irqname[4];
> > > > > > > > > > +       char *irqname;
> > > > > > > > > > +       int ret;
> > > > > > > > > > +
> > > > > > > > > > +       sprintf(pdev_irqname, "ch%u", chan_id);
> > > > > > > > > > +       chan->irq =3D platform_get_irq_byname(pdev, pde=
v_irqname);
> > > > > > > > > > +       if (chan->irq < 0)
> > > > > > > > > > +               return -ENODEV;
> > > > > > > > > > +
> > > > > > > > > > +       irqname =3D devm_kasprintf(dev, GFP_KERNEL, "%s=
:%s",
> > > > > > > > > > +                                dev_name(dev), pdev_ir=
qname);
> > > > > > > > > > +       if (!irqname)
> > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +       ret =3D devm_request_irq(dev, chan->irq, ls1x_d=
ma_irq_handler,
> > > > > > > > > > +                              IRQF_SHARED, irqname, ch=
an);
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               return dev_err_probe(dev, ret,
> > > > > > > > > > +                                    "failed to request=
 IRQ %u!\n", chan->irq);
> > > > > > > > > > +
> > > > > > > > > > +       chan->reg_base =3D dma->reg_base;
> > > > > > > > > > +       chan->vchan.desc_free =3D ls1x_dma_free_desc;
> > > > > > > > > > +       vchan_init(&chan->vchan, &dma->ddev);
> > > > > > > > > > +       dev_info(dev, "%s (irq %d) initialized\n", pdev=
_irqname, chan->irq);
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void ls1x_dma_chan_remove(struct ls1x_dma *dma,=
 int chan_id)
> > > > > > > > > > +{
> > > > > > > > > > +       struct device *dev =3D dma->ddev.dev;
> > > > > > > > > > +       struct ls1x_dma_chan *chan =3D &dma->chan[chan_=
id];
> > > > > > > > > > +
> > > > > > > > > > +       devm_free_irq(dev, chan->irq, chan);
> > > > > > > > > > +       list_del(&chan->vchan.chan.device_node);
> > > > > > > > > > +       tasklet_kill(&chan->vchan.task);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int ls1x_dma_probe(struct platform_device *pdev=
)
> > > > > > > > > > +{
> > > > > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > > > > +       struct dma_device *ddev;
> > > > > > > > > > +       struct ls1x_dma *dma;
> > > > > > > > > > +       int nr_chans, ret, i;
> > > > > > > > > > +
> > > > > > > > > > +       nr_chans =3D platform_irq_count(pdev);
> > > > > > > > > > +       if (nr_chans <=3D 0)
> > > > > > > > > > +               return nr_chans;
> > > > > > > > > > +       if (nr_chans > LS1X_DMA_MAX_CHANNELS)
> > > > > > > > > > +               return dev_err_probe(dev, -EINVAL,
> > > > > > > > > > +                                    "nr_chans=3D%d exc=
eeds the maximum\n",
> > > > > > > > > > +                                    nr_chans);
> > > > > > > > > > +
> > > > > > > > > > +       dma =3D devm_kzalloc(dev, struct_size(dma, chan=
, nr_chans), GFP_KERNEL);
> > > > > > > > > > +       if (!dma)
> > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +       /* initialize DMA device */
> > > > > > > > > > +       dma->reg_base =3D devm_platform_ioremap_resourc=
e(pdev, 0);
> > > > > > > > > > +       if (IS_ERR(dma->reg_base))
> > > > > > > > > > +               return PTR_ERR(dma->reg_base);
> > > > > > > > > > +
> > > > > > > > > > +       ddev =3D &dma->ddev;
> > > > > > > > > > +       ddev->dev =3D dev;
> > > > > > > > > > +       ddev->copy_align =3D DMAENGINE_ALIGN_4_BYTES;
> > > > > > > > > > +       ddev->src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDT=
H_1_BYTE) |
> > > > > > > > > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_S=
LAVE_BUSWIDTH_4_BYTES);
> > > > > > > > > > +       ddev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDT=
H_1_BYTE) |
> > > > > > > > > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_S=
LAVE_BUSWIDTH_4_BYTES);
> > > > > > > > > > +       ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(=
DMA_MEM_TO_DEV);
> > > > > > > > > > +       ddev->max_sg_burst =3D LS1X_DMA_MAX_DESC;
> > > > > > > > > > +       ddev->residue_granularity =3D DMA_RESIDUE_GRANU=
LARITY_SEGMENT;
> > > > > > > > > > +       ddev->device_alloc_chan_resources =3D ls1x_dma_=
alloc_chan_resources;
> > > > > > > > > > +       ddev->device_free_chan_resources =3D ls1x_dma_f=
ree_chan_resources;
> > > > > > > > > > +       ddev->device_prep_slave_sg =3D ls1x_dma_prep_sl=
ave_sg;
> > > > > > > > > > +       ddev->device_prep_dma_cyclic =3D ls1x_dma_prep_=
dma_cyclic;
> > > > > > > > > > +       ddev->device_config =3D ls1x_dma_slave_config;
> > > > > > > > > > +       ddev->device_pause =3D ls1x_dma_pause;
> > > > > > > > > > +       ddev->device_resume =3D ls1x_dma_resume;
> > > > > > > > > > +       ddev->device_terminate_all =3D ls1x_dma_termina=
te_all;
> > > > > > > > > > +       ddev->device_tx_status =3D ls1x_dma_tx_status;
> > > > > > > > > > +       ddev->device_issue_pending =3D ls1x_dma_issue_p=
ending;
> > > > > > > > > > +
> > > > > > > > > > +       dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > > > > > > > > > +       INIT_LIST_HEAD(&ddev->channels);
> > > > > > > > > > +
> > > > > > > > > > +       /* initialize DMA channels */
> > > > > > > > > > +       for (i =3D 0; i < nr_chans; i++) {
> > > > > > > > > > +               ret =3D ls1x_dma_chan_probe(pdev, dma, =
i);
> > > > > > > > > > +               if (ret)
> > > > > > > > > > +                       return ret;
> > > > > > > > > > +       }
> > > > > > > > > > +       dma->nr_chans =3D nr_chans;
> > > > > > > > > > +
> > > > > > > > > > +       ret =3D dmaenginem_async_device_register(ddev);
> > > > > > > > > > +       if (ret) {
> > > > > > > > > > +               dev_err(dev, "failed to register DMA de=
vice! %d\n", ret);
> > > > > > > > > > +               return ret;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       ret =3D
> > > > > > > > > > +           of_dma_controller_register(dev->of_node, of=
_dma_xlate_by_chan_id,
> > > > > > > > > > +                                      ddev);
> > > > > > > > > > +       if (ret) {
> > > > > > > > > > +               dev_err(dev, "failed to register DMA co=
ntroller! %d\n", ret);
> > > > > > > > > > +               return ret;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       platform_set_drvdata(pdev, dma);
> > > > > > > > > > +       dev_info(dev, "Loongson1 DMA driver registered\=
n");
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void ls1x_dma_remove(struct platform_device *pd=
ev)
> > > > > > > > > > +{
> > > > > > > > > > +       struct ls1x_dma *dma =3D platform_get_drvdata(p=
dev);
> > > > > > > > > > +       int i;
> > > > > > > > > > +
> > > > > > > > > > +       of_dma_controller_free(pdev->dev.of_node);
> > > > > > > > > > +
> > > > > > > > > > +       for (i =3D 0; i < dma->nr_chans; i++)
> > > > > > > > > > +               ls1x_dma_chan_remove(dma, i);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static const struct of_device_id ls1x_dma_match[] =3D =
{
> > > > > > > > > > +       { .compatible =3D "loongson,ls1b-apbdma" },
> > > > > > > > > > +       { .compatible =3D "loongson,ls1c-apbdma" },
> > > > > > > > > > +       { /* sentinel */ }
> > > > > > > > > > +};
> > > > > > > > > > +MODULE_DEVICE_TABLE(of, ls1x_dma_match);
> > > > > > > > > > +
> > > > > > > > > > +static struct platform_driver ls1x_dma_driver =3D {
> > > > > > > > > > +       .probe =3D ls1x_dma_probe,
> > > > > > > > > > +       .remove_new =3D ls1x_dma_remove,
> > > > > > > > > > +       .driver =3D {
> > > > > > > > > > +               .name =3D KBUILD_MODNAME,
> > > > > > > > > > +               .of_match_table =3D ls1x_dma_match,
> > > > > > > > > > +       },
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +module_platform_driver(ls1x_dma_driver);
> > > > > > > > > > +
> > > > > > > > > > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>=
");
> > > > > > > > > > +MODULE_DESCRIPTION("Loongson-1 APB DMA Controller driv=
er");
> > > > > > > > > > +MODULE_LICENSE("GPL");
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.40.1
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Best regards,
> > > > > > > >
> > > > > > > > Keguang Zhang
> > > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Best regards,
> > > > > >
> > > > > > Keguang Zhang
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



--=20
Best regards,

Keguang Zhang

