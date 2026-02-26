Return-Path: <dmaengine+bounces-9128-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI4uBDj/n2n3fAQAu9opvQ
	(envelope-from <dmaengine+bounces-9128-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 09:07:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5D1A2460
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 09:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFB063013DE1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACB1393DC1;
	Thu, 26 Feb 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StagU9uF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B043939D1
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093237; cv=none; b=m5A6ZI0q9UXwcQD+HkJ1N4WMXYVgkaiELBpuVTxHX4QqN0bna1MTj7+JHYl2g4lrtGfDITv/3ZaY4RANW9b3RIcPkZLLanRaB97at1KvndqdL/bAzLWqwIBEwInSOmtCIslqbgcyY4/0yzKPVtiq+zX/wk7IF02tCJ1j70Dmb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093237; c=relaxed/simple;
	bh=K0n8HxF6lOZqrVlB8vEJwgYuzkOQryDbQZJNjlhSba8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1kudwbT34Qc4S47z8CX3dYIqJsmOGBu+8ZTutKQTIswaXwRknKXN0iCIadAIkgiFR27ggtHzEvKedB7scE4ozN2SvsC3gz+DYsAOvi68r4mYyy+gHkayTqpYDIMLiW4hgrL0miMlUzzKBUVCS8hm3QAeGD/wUB9qywPu8DUmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StagU9uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD67DC19422
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772093236;
	bh=K0n8HxF6lOZqrVlB8vEJwgYuzkOQryDbQZJNjlhSba8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=StagU9uFt5bPoZAOY2hlmDGJqVsdjf1LQSED/+Dih0bYvRA6DReAF7ai7BKAvy25U
	 1//p+EjDttuvF1KYh0Aq8Wr2DOjaqkjFOJ2njQTTbQy6U5S3/O/yt4yoDSO1cZFGtN
	 HobCxRFEQJJ+dZewDILJCAv3v2QEL2mpWLQzV3v+5gzWGOfCd/MUSrMqcxwqv7i4ty
	 q5xj6s5DlQarW6bhA0d8RuDM4/kJy/zzGdn8UWeUM5gOG3ROFUCwD1xRzqcW9eIs9w
	 ltYmnFHfW56/3+ZQUWJRNmiSMA3GPdguSt/458bHdaTI/AVr6+MyxGLsL8GHHOHanC
	 yO0BkPZ1a33tw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65faaa8b807so1244852a12.3
        for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 00:07:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYoUwf/wggNjjGfxm10DDrPsyGjJl71qGMhandpIEHumMauGJKpY/okc452RwE7PiIEhLfBWl4bQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJ5c96liFVbe8nuknATWH+KTTwiq6lxTt22yQTdlJoTZTMSM1
	I9X7O7u88vJRH2B3ph9TMpPOLlC0PxZF9zWTmW5s4kh/yvvdE18wj/Bf3u6OlBlCi4T4PchSU+A
	BVl1pndu14HUYk0OosUUch934p5Ayx+o=
X-Received: by 2002:a05:6402:2692:b0:659:4554:2dbd with SMTP id
 4fb4d7f45d1cf-65fa476ebfamr2133550a12.7.1772093235170; Thu, 26 Feb 2026
 00:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770605931.git.zhoubinbin@loongson.cn> <d62faafc653efab602c8d6bfcdcee1cb217171b9.1770605931.git.zhoubinbin@loongson.cn>
 <aYoPyWS7o27G-AHh@lizhi-Precision-Tower-5810> <CAMpQs4+NHVQTcxdsBYp6H7c4FZpsuTo=QpKKY09sgpppDEiuNA@mail.gmail.com>
In-Reply-To: <CAMpQs4+NHVQTcxdsBYp6H7c4FZpsuTo=QpKKY09sgpppDEiuNA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Feb 2026 16:07:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ODRYLC=cmhWzkkxAMNJK1SRT9b-L+eQEqzhJKtmENhQ@mail.gmail.com>
X-Gm-Features: AaiRm53wN3tuv3Fr6JhWHeaXk9ZvsrAGSuLaFtOSYLHZz0Hr2Lq5IiPjFj5GUhA
Message-ID: <CAAhV-H5ODRYLC=cmhWzkkxAMNJK1SRT9b-L+eQEqzhJKtmENhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dmaengine: loongson: New directory for Loongson
 DMA controllers drivers
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, Xiaochuang Mao <maoxiaochuan@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@vger.kernel.org, jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9128-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com,aosc.io];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,loongson.cn:email,nxp.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8DD5D1A2460
X-Rspamd-Action: no action

Hi, Binbin.

On Tue, Feb 10, 2026 at 9:27=E2=80=AFAM Binbin Zhou <zhoubb.aaron@gmail.com=
> wrote:
>
> Hi Frank:
>
> On Tue, Feb 10, 2026 at 12:48=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrot=
e:
> >
> > On Mon, Feb 09, 2026 at 11:04:18AM +0800, Binbin Zhou wrote:
> > > Gather the Loongson DMA controllers under drivers/dma/loongson/
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  MAINTAINERS                                   |  3 +-
> > >  drivers/dma/Kconfig                           | 25 ++---------------
> > >  drivers/dma/Makefile                          |  3 +-
> > >  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++=
++
> > >  drivers/dma/loongson/Makefile                 |  3 ++
> > >  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |  4 +--
> > >  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  4 +--
> > >  7 files changed, 40 insertions(+), 30 deletions(-)
> > >  create mode 100644 drivers/dma/loongson/Kconfig
> > >  create mode 100644 drivers/dma/loongson/Makefile
> > >  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)
> > >  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (99%)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f630328ca6ae..27f77b68d596 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14777,7 +14777,7 @@ M:    Binbin Zhou <zhoubinbin@loongson.cn>
> > >  L:   dmaengine@vger.kernel.org
> > >  S:   Maintained
> > >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > > -F:   drivers/dma/loongson2-apb-dma.c
> > > +F:   drivers/dma/loongson/loongson2-apb-dma.c
> > >
> > >  LOONGSON LS2X I2C DRIVER
> > >  M:   Binbin Zhou <zhoubinbin@loongson.cn>
> > > @@ -17515,6 +17515,7 @@ F:    arch/mips/boot/dts/loongson/loongson1*
> > >  F:   arch/mips/configs/loongson1_defconfig
> > >  F:   arch/mips/loongson32/
> > >  F:   drivers/*/*loongson1*
> > > +F:   drivers/dma/loongson/loongson1-apb-dma.c
> > >  F:   drivers/mtd/nand/raw/loongson-nand-controller.c
> > >  F:   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > >  F:   sound/soc/loongson/loongson1_ac97.c
> > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > index 66cda7cc9f7a..1b84c5b11654 100644
> > > --- a/drivers/dma/Kconfig
> > > +++ b/drivers/dma/Kconfig
> > > @@ -376,29 +376,6 @@ config K3_DMA
> > >         Support the DMA engine for Hisilicon K3 platform
> > >         devices.
> > >
> > > -config LOONGSON1_APB_DMA
> > > -     tristate "Loongson1 APB DMA support"
> > > -     depends on MACH_LOONGSON32 || COMPILE_TEST
> > > -     select DMA_ENGINE
> > > -     select DMA_VIRTUAL_CHANNELS
> > > -     help
> > > -       This selects support for the APB DMA controller in Loongson1 =
SoCs,
> > > -       which is required by Loongson1 NAND and audio support.
> > > -
> > > -config LOONGSON2_APB_DMA
> > > -     tristate "Loongson2 APB DMA support"
> > > -     depends on LOONGARCH || COMPILE_TEST
> > > -     select DMA_ENGINE
> > > -     select DMA_VIRTUAL_CHANNELS
> > > -     help
> > > -       Support for the Loongson2 APB DMA controller driver. The
> > > -       DMA controller is having single DMA channel which can be
> > > -       configured for different peripherals like audio, nand, sdio
> > > -       etc which is in APB bus.
> > > -
> > > -       This DMA controller transfers data from memory to peripheral =
fifo.
> > > -       It does not support memory to memory data transfer.
> > > -
> > >  config LPC18XX_DMAMUX
> > >       bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > >       depends on ARCH_LPC18XX || COMPILE_TEST
> > > @@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
> > >
> > >  source "drivers/dma/lgm/Kconfig"
> > >
> > > +source "drivers/dma/loongson/Kconfig"
> > > +
> > >  source "drivers/dma/stm32/Kconfig"
> > >
> > >  # clients
> > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > > index a54d7688392b..a1c73415b79f 100644
> > > --- a/drivers/dma/Makefile
> > > +++ b/drivers/dma/Makefile
> > > @@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
> > >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> > >  obj-y +=3D idxd/
> > >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > > -obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > > -obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > >  obj-$(CONFIG_LPC32XX_DMAMUX) +=3D lpc32xx-dmamux.o
> > >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > > @@ -88,6 +86,7 @@ obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
> > >
> > >  obj-y +=3D amd/
> > >  obj-y +=3D mediatek/
> > > +obj-y +=3D loongson/
> >
> > keep alphabet order
>
> Sorry, I'll fix it in the next version.
> >
> > Frank
> > >  obj-y +=3D qcom/
> > >  obj-y +=3D stm32/
> > >  obj-y +=3D ti/
> > > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kcon=
fig
> > > new file mode 100644
> > > index 000000000000..9dbdaef5a59f
> > > --- /dev/null
> > > +++ b/drivers/dma/loongson/Kconfig
> > > @@ -0,0 +1,28 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Loongson DMA controllers drivers
> > > +#
> > > +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> > > +
> > > +config LOONGSON1_APB_DMA
> > > +     tristate "Loongson1 APB DMA support"
> > > +     select DMA_ENGINE
> > > +     select DMA_VIRTUAL_CHANNELS
I think "depends on MACH_LOONGSON32 || COMPILE_TEST" is still needed,
otherwise it can be compiled for MACH_LOONGSON64.

> > > +     help
> > > +       This selects support for the APB DMA controller in Loongson1 =
SoCs,
> > > +       which is required by Loongson1 NAND and audio support.
> > > +
> > > +config LOONGSON2_APB_DMA
> > > +     tristate "Loongson2 APB DMA support"
> > > +     select DMA_ENGINE
> > > +     select DMA_VIRTUAL_CHANNELS
The same, "depends on MACH_LOONGSON64 || COMPILE_TEST" is needed.

Huacai

> > > +     help
> > > +       Support for the Loongson2 APB DMA controller driver. The
> > > +       DMA controller is having single DMA channel which can be
> > > +       configured for different peripherals like audio, nand, sdio
> > > +       etc which is in APB bus.
> > > +
> > > +       This DMA controller transfers data from memory to peripheral =
fifo.
> > > +       It does not support memory to memory data transfer.
> > > +
> > > +endif
> > > diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Mak=
efile
> > > new file mode 100644
> > > index 000000000000..6cdd08065e92
> > > --- /dev/null
> > > +++ b/drivers/dma/loongson/Makefile
> > > @@ -0,0 +1,3 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > > +obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > > diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson/l=
oongson1-apb-dma.c
> > > similarity index 99%
> > > rename from drivers/dma/loongson1-apb-dma.c
> > > rename to drivers/dma/loongson/loongson1-apb-dma.c
> > > index 255fe7eca212..e99247cf90c1 100644
> > > --- a/drivers/dma/loongson1-apb-dma.c
> > > +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> > > @@ -16,8 +16,8 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > >
> > > -#include "dmaengine.h"
> > > -#include "virt-dma.h"
> > > +#include "../dmaengine.h"
> > > +#include "../virt-dma.h"
> > >
> > >  /* Loongson-1 DMA Control Register */
> > >  #define LS1X_DMA_CTRL                0x0
> > > diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson/l=
oongson2-apb-dma.c
> > > similarity index 99%
> > > rename from drivers/dma/loongson2-apb-dma.c
> > > rename to drivers/dma/loongson/loongson2-apb-dma.c
> > > index c528f02b9f84..0cb607595d04 100644
> > > --- a/drivers/dma/loongson2-apb-dma.c
> > > +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> > > @@ -17,8 +17,8 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > >
> > > -#include "dmaengine.h"
> > > -#include "virt-dma.h"
> > > +#include "../dmaengine.h"
> > > +#include "../virt-dma.h"
> > >
> > >  /* Global Configuration Register */
> > >  #define LDMA_ORDER_ERG               0x0
> > > --
> > > 2.52.0
> > >
>
> --
> Thanks.
> Binbin

