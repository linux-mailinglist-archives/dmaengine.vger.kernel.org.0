Return-Path: <dmaengine+bounces-8707-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF2lA9PogmlHewMAu9opvQ
	(envelope-from <dmaengine+bounces-8707-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 07:36:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468EE259C
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 07:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B102F300B457
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1937F8AE;
	Wed,  4 Feb 2026 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TINTJfZU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0437F8A8
	for <dmaengine@vger.kernel.org>; Wed,  4 Feb 2026 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186958; cv=pass; b=grrZ1uGtKzFFHbIag2NspqtDwnHayg/O8k3M5mBB3ZXZRXVl40dMt/IVgHLMMzoxdtpBMvzNLn9BiudaVcnVgmiz3G754NzVE1gBR/GC1WtsMIzLimcM2f0+UOgLIrjiPXgoPAOMTTGy0gQzwhYePjNMMHyi1pd/irzADkZdPaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186958; c=relaxed/simple;
	bh=OPJ6hN99fILkc0gQaQdzFx5Dkfa45kS3jkjmQOQY6lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFLQ3ka4uEh453ZXHyhyJMf8EoYtLi3UAHtR8LykGVXbduP6Rg4IeI7q8UWfo/fHFXLj8TajkOFOWm9qYteov2Zxu4zHywFaA09xoJSfEBwPV1YSiHP7PeTE6nB5v2Amt2yz4TdSv11aki4+0pbHUy3stkUAJWoC4XCqD1Urp14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TINTJfZU; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b834e3d64so6996986e87.2
        for <dmaengine@vger.kernel.org>; Tue, 03 Feb 2026 22:35:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770186956; cv=none;
        d=google.com; s=arc-20240605;
        b=AD0buodQWLL0Tu01JcM1e3hxt3P+MiUO5k+q6LIA1wy5Ky4vyph6fuE0Alamp/jjyR
         THtN9Eato+pxSCk51tFhkLF7Ntasj8MKhapvQaHKvOIUAdVVvPp69VsjQKOpG5zScGA2
         BZvlLI5TlzfvqW+00dTXELbv/cvriZoTUb0jcA/2IKU/LUz+gIvxfQwJQK8sIaPZ/Bzt
         y34tt5PbOoYs3xJ7qwIAs29pdYW3t20itWv4cRIqwDGmm00M4l2vOwa8ynH6bjD1lthQ
         nHK5wFgy8szq/MfQDLnt062NuM0w6yUBsHnFWLKfhQqVuljHTJ2WT0dhVF/yOb5gcwdr
         nKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BPp0z8Fv7wvLo+wR3RpA3lIEoxPehy2fBk8QQW+/QDY=;
        fh=Q+AZBiooO2bASfaEdOis6R/qpe/bzumAD+OyrL9ubpE=;
        b=kCTwDTAnRH13FFkn36zUfvv7WBw1Ho56lRd0dy4BRaSvLl/VDnBVRBIQESM7NZIvTn
         fyBOUFzyVqEDcxcDFjxXRp5+ju0/qv776M6Rk3HqNIf9NxmqphDgz74SA+67zXirkAS5
         UZBCyx/YLLZKWOB/Ll7U+CM7Ra7HyBmnc5OWbUlznEAvXEU7hahQ9F1xwo5dUyUYQHD0
         5d0o6gmy2stmPfh3qVLQwTxVLGsMPdr/KdHsxk9HP5PQ6HqLs2KmwUbAsByxWDYXk6e8
         5OEkx1PnDlvYWWxoAMJJYWEL5ueeOIFTqmelULgCe1gt4LldgOAAWk/iNhlhnY59Mzge
         0ciQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770186956; x=1770791756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPp0z8Fv7wvLo+wR3RpA3lIEoxPehy2fBk8QQW+/QDY=;
        b=TINTJfZU5ggvuVjGFFI6yYfp35sm4iX0UbwN7oLltam/spokBRD5wxFafmztJ7Zoji
         +amZzyeLcHoaASVbkzHKPvSspupk4l9xMKZUntbOi3/TyM4/IjJ/RmP/SDorjaCKhN2X
         BDUH4Um9uiOuRaNENYjuk4EkgPDlOLZuEpxGpzAsoCQMnxCdiUr9SSEb5H5/2ArdbKiy
         SZaqKKF4G0JYxhBJEBaXja3K/4a813KOAZO6gKS1oyuCrhhHNtGsntYHCwgh8Y4EI0Tb
         HyLbm5EzLX9A9penbjW0jQF3/qLV7+9Y92PevOsc7mZ1f5RMycSJ4PdUu+c+YAx9aOzC
         KR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770186956; x=1770791756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPp0z8Fv7wvLo+wR3RpA3lIEoxPehy2fBk8QQW+/QDY=;
        b=YIwRzwZBAEHIXfsWM35Wzp/59klTzb4bk1DBp+abB/2XSpEft4i/5sJwND3I6gRJUe
         LeaYcds+ej4l0vubM2pb0Lsd4bksqdl4ovUSCOe/X45FmftEAtm571iXwHOMQptPLP3L
         CL6fKeRHmZRv2W+0QkqK/2RXQ7iSQgnD9WvmCrFNbKYKYgZxCnnKgnipP43vZpfjcHt5
         6SNMvZ+eW24135uwrQ++8GVW6YCKeu7iVGD4gycKdXhM/PWkQmT3ecIyZurEEIBo7AxS
         m/tk3+2LlGc7nFdfAK08yGBNiN4XsM2OUp8GJhWLBT/bth7RFhonYBE6lSzoE+d6YSuR
         pRNw==
X-Forwarded-Encrypted: i=1; AJvYcCVTtO7f6hhHrBcxk7YQ2h0WKzuygSAH5fCn/RvJWpJJxUt10z/Gm19i7/TCAjWIwyj4ccSwspv+1o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbOzSz4WVsEDndGosaWq8dlt7jHbx6uO6cVsYbQxZCG6Od05V/
	NSStL1wLozbgrBUbBGbEFkrDBrPIxsbzaI9gJBX7v52Uwe8dYnw5J+zhFjmnAwOAE7LNj/wb54M
	jA4QWem43Ayxtvf7bVP3qdIvRAaovK/U=
X-Gm-Gg: AZuq6aLLym88QZzkvTHCQPoSVlSV3SvA4eiC9ULv+QxXRPUSzk3JVIuSLrIMxbdk0gY
	DBnn48j7A8Nk17ZH+we3u2Df9WcAW/61JIy0+UJXuw/VxvRpMKk6i5Jytgp0I40/vckvt+JQkTr
	7oG9sf3GZVQFXyvKiAAeLSbu+DrHADBiHdWi+IIcN3+PuriOzO7Wp0HkEhU/Mgg4fcH7vsw1TBi
	fqDjFXv0ki/9typnComdh/fhc77bOVHurYBwqHku/1IVpRXPbV+pvR8p+ndy/NfxGjwdDgk3EQE
	0u0/ePu/9nHSXNx6k9OJ29akZoWVOBhT+/LmFkmkm6chAsH5jCX+PweD6CC9bzKtpFEN
X-Received: by 2002:ac2:4e10:0:b0:59e:6f4:d21e with SMTP id
 2adb3069b0e04-59e38c30bc6mr627593e87.35.1770186955513; Tue, 03 Feb 2026
 22:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770119693.git.zhoubinbin@loongson.cn> <d7a73d1fe8a3e4e57055a15a6ec03170f0d8ca21.1770119693.git.zhoubinbin@loongson.cn>
 <CAJhJPsVRZe_E6FsNBUa6K=GmPp3FXRrOH=yguvTY=K1cGwa62Q@mail.gmail.com> <CAMpQs4JM43ePsYAA0GVeKc5_WJL1TWSm-K2RKXcYJjttR6k6-w@mail.gmail.com>
In-Reply-To: <CAMpQs4JM43ePsYAA0GVeKc5_WJL1TWSm-K2RKXcYJjttR6k6-w@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Wed, 4 Feb 2026 14:35:18 +0800
X-Gm-Features: AZwV_QiO7G4Ev4glVwn9PgtXPCuEnylN60ZTP0WNS0S1J--3jxgCaWQEGD8l0o4
Message-ID: <CAJhJPsXHZnC-BZu13YiMXNTP9VqE_0mnpOUBbnB7a6-GJy-n+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: loongson: New directory for Loongson DMA
 controllers drivers
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	Xiaochuang Mao <maoxiaochuan@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8707-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,loongson.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3468EE259C
X-Rspamd-Action: no action

Binbin,

On Wed, Feb 4, 2026 at 2:19=E2=80=AFPM Binbin Zhou <zhoubb.aaron@gmail.com>=
 wrote:
>
> Hi Keguang:
>
> On Wed, Feb 4, 2026 at 1:43=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > On Tue, Feb 3, 2026 at 8:30=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson=
.cn> wrote:
> > >
> > > Gather the Loongson DMA controllers under drivers/dma/loongson/
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  MAINTAINERS                                   |  2 +-
> > >  drivers/dma/Kconfig                           | 25 ++---------------
> > >  drivers/dma/Makefile                          |  3 +-
> > >  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++=
++
> > >  drivers/dma/loongson/Makefile                 |  3 ++
> > >  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |  4 +--
> > >  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  4 +--
> > >  7 files changed, 39 insertions(+), 30 deletions(-)
> > >  create mode 100644 drivers/dma/loongson/Kconfig
> > >  create mode 100644 drivers/dma/loongson/Makefile
> > >  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)
> >
> > The file loongson1-apb-dma.c was moved to drivers/dma/loongson/,
> > but the MAINTAINERS entry still refers to the old path.
>
> In the MAINTAINERS, the loongson1 driver filename is matched using the
> wildcard `*`. This move operation appears to have no effect.
>
> As follows:
>
> MIPS/LOONGSON1 ARCHITECTURE
> M:      Keguang Zhang <keguang.zhang@gmail.com>
> L:      linux-mips@vger.kernel.org
> S:      Maintained
> F:      Documentation/devicetree/bindings/*/loongson,ls1*.yaml
> F:      arch/mips/boot/dts/loongson/loongson1*
> F:      arch/mips/configs/loongson1_defconfig
> F:      arch/mips/loongson32/
> F:      drivers/*/*loongson1*

I have verified that drivers/*/*loongson1* does not cover
drivers/dma/loongson/loongson1-apb-dma.c.
Please consider adding one of the following entries to MAINTAINERS:
drivers/dma/loongson/loongson1-apb-dma.c
or
drivers/*/loongson/*loongson1*

Thanks!

> F:      drivers/mtd/nand/raw/loongson-nand-controller.c
> F:      drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> F:      sound/soc/loongson/loongson1_ac97.c
>
> >
> > >  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (99%)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 5b11839cba9d..66807104af63 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14776,7 +14776,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
> > >  L:     dmaengine@vger.kernel.org
> > >  S:     Maintained
> > >  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.ya=
ml
> > > -F:     drivers/dma/loongson2-apb-dma.c
> > > +F:     drivers/dma/loongson/loongson2-apb-dma.c
> > >
> > >  LOONGSON LS2X I2C DRIVER
> > >  M:     Binbin Zhou <zhoubinbin@loongson.cn>
> > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > index 66cda7cc9f7a..1b84c5b11654 100644
> > > --- a/drivers/dma/Kconfig
> > > +++ b/drivers/dma/Kconfig
> > > @@ -376,29 +376,6 @@ config K3_DMA
> > >           Support the DMA engine for Hisilicon K3 platform
> > >           devices.
> > >
> > > -config LOONGSON1_APB_DMA
> > > -       tristate "Loongson1 APB DMA support"
> > > -       depends on MACH_LOONGSON32 || COMPILE_TEST
> > > -       select DMA_ENGINE
> > > -       select DMA_VIRTUAL_CHANNELS
> > > -       help
> > > -         This selects support for the APB DMA controller in Loongson=
1 SoCs,
> > > -         which is required by Loongson1 NAND and audio support.
> > > -
> > > -config LOONGSON2_APB_DMA
> > > -       tristate "Loongson2 APB DMA support"
> > > -       depends on LOONGARCH || COMPILE_TEST
> > > -       select DMA_ENGINE
> > > -       select DMA_VIRTUAL_CHANNELS
> > > -       help
> > > -         Support for the Loongson2 APB DMA controller driver. The
> > > -         DMA controller is having single DMA channel which can be
> > > -         configured for different peripherals like audio, nand, sdio
> > > -         etc which is in APB bus.
> > > -
> > > -         This DMA controller transfers data from memory to periphera=
l fifo.
> > > -         It does not support memory to memory data transfer.
> > > -
> > >  config LPC18XX_DMAMUX
> > >         bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > >         depends on ARCH_LPC18XX || COMPILE_TEST
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
> > > +       tristate "Loongson1 APB DMA support"
> > > +       select DMA_ENGINE
> > > +       select DMA_VIRTUAL_CHANNELS
> > > +       help
> > > +         This selects support for the APB DMA controller in Loongson=
1 SoCs,
> > > +         which is required by Loongson1 NAND and audio support.
> > > +
> > > +config LOONGSON2_APB_DMA
> > > +       tristate "Loongson2 APB DMA support"
> > > +       select DMA_ENGINE
> > > +       select DMA_VIRTUAL_CHANNELS
> > > +       help
> > > +         Support for the Loongson2 APB DMA controller driver. The
> > > +         DMA controller is having single DMA channel which can be
> > > +         configured for different peripherals like audio, nand, sdio
> > > +         etc which is in APB bus.
> > > +
> > > +         This DMA controller transfers data from memory to periphera=
l fifo.
> > > +         It does not support memory to memory data transfer.
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
> > >  #define LS1X_DMA_CTRL          0x0
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
> > >  #define LDMA_ORDER_ERG         0x0
> > > --
> > > 2.47.3
> > >
> >
> >
> > --
> > Best regards,
> >
> > Keguang Zhang
>
> --
> Thanks.
> Binbin



--=20
Best regards,

Keguang Zhang

