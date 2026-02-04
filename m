Return-Path: <dmaengine+bounces-8708-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id etFSL2DpgmmPewMAu9opvQ
	(envelope-from <dmaengine+bounces-8708-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 07:38:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE633E25CA
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4567B3009E1B
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245437F8DE;
	Wed,  4 Feb 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6e5KHmb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8837FF51
	for <dmaengine@vger.kernel.org>; Wed,  4 Feb 2026 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187099; cv=pass; b=Hb8jZVmxiuYN2Rf9+SBpN8UERzJptTH9GF0mbXmV9BLcnvCl5sftrRtNDn/PR3HqkjIbeuKNZHGvEZ0Gvx7Fl6o9LeRN5FHaJ19PIBX8BsXPlY+5GFhhZXg0XWmO6P7wq/kl1bMjUyXQqDpswFrct720NHFwpDcwcKQAgd4NOXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187099; c=relaxed/simple;
	bh=G1czA/atzJVQ0I8k8+uEe7K7HnzEQCu/aZUYWjlKOms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIywOFx8gz5od5lWnbv2EFQggkudzNO3oGZ90yG3R9IqF4xiHsgRGh/Is3Up+ZGRoUB0vKtDJcFlBYHdhTW1DbcZlIhgIa/WPMe9gBycxVEzOf3jrEQ5n3a24WxXX3msNIf6QXElJRXO53sepqeKPtCJC5SlDV92GOT/l9o3rMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6e5KHmb; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8838339fc6so126027066b.0
        for <dmaengine@vger.kernel.org>; Tue, 03 Feb 2026 22:38:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770187097; cv=none;
        d=google.com; s=arc-20240605;
        b=T/R4f92LLIdyB2ri+8TdaemxmApvOM04z9gwx18YP1neKtNKZugZV5mXhGUt+R+2wE
         W2qew2u/K8a+riByGgNfuIBtvUbVj4Uh0VErY/f0GJM7jW8mL1Sx79RmtIZR95DnQIzI
         rFkZPATN19NJDR3ESn/4vHOdEmsMCbESDZjEKoA7KQx6GYvhy5vjG3wbzgOl/f3wiC0N
         hEke5G4yaJwBiIZiII8OHQD0duFrziyvx3C6dDbItGuztgsSzzJAbGjj3sM4Xl+FsFjb
         JRTM3cZNJLuAAGaVjYgc50dlfZCt4VnFvuGU7oH9zpYS0Af+2sFLTyJ+TC0JxeW5CZmu
         n1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PmAMbKQUycWizHRkwV+uncj9jKX+nJIb4YwsZPnmiOk=;
        fh=XCUkAln9Nve65LHlK8gmQu/aiqo1+4wU2I4YVhvfYXo=;
        b=B5VPhbzwKg88xBHzF5DA6r0YXoBwdRiLZGLzyQQ27Ms3oLeccVUno6jSufYSxjg/IN
         qnvIVAqKHOGXgQR+/AqlQ5gYIfeP1t0k/KwfFnMjWgkl++FAwLPwzhDMzH7sRtFvXFBt
         DZuZLAmi6rIwVApFbY43jOym8uTCokOGB1D3SZzf3vXflPmn0Mswc5sa5GD9romqTbfZ
         fpxhnNmy/AJXzAHRa2zuMBWtqXRrH4TNy7SjCe1XPsxdReDF0aOabAWQ5viDUTnDYL4g
         AkLXQh52RAEVS55lkovCcl2a3yL8P7KpBNe3z/ZJrewEigr2sG5Sfxupa18vz5KzQM6G
         8Bbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770187097; x=1770791897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmAMbKQUycWizHRkwV+uncj9jKX+nJIb4YwsZPnmiOk=;
        b=g6e5KHmbcKELnmrOMdcrEZZxmTkEYIENmQ9BUeXrUCWvpptleTeS/Ha0T4LiMNEL9p
         +XbCFxgjyqGhGbkQPPsKq6XPzY1WHCZ0iuIaSvbfNWAOXoMvFs4gdib4KjIQDSRF2N8k
         j8EhtlNgi/hwPpvbkT8UQuwtym7MRSY3dym2B+OHqFLDBJXbfHD+5lO+WO+QvRbRJMfE
         XDiQ2yvsS1bA8U5QEEXGcnTVRNyU7xLoxZwWSGok7xDZGsudqvuC2FF4acrPN4OW5NCN
         nFa8HGPOFmumeSEzPRfd4EClwEjYPcz01SrX0aFylSWuW9uBX1BzgjnHAAC9wEnPR800
         3ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770187097; x=1770791897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmAMbKQUycWizHRkwV+uncj9jKX+nJIb4YwsZPnmiOk=;
        b=vb8fXvNambgu5RFjXzgJUFG+c8xdMGT1qBhKKgWOhvZqZW5c3CynsEKB77PDKte9QO
         YEr5r7OrYogGOkIDVikuJ1HbObVy1nnXh4UYKB5wqdse3wLDK7c+xxcMOkqgelB/ynTF
         GzULC0Xut53HeL1Edgl7EPgmj29XKmwIZE7ZCXOiYsuzYGl9leBJRJWK0oEL+FReT3er
         kN+zuOKF7/W1F+xMkFKEaa7V/ore3YREF3/L1EVz0mb1qRIJIUbvPwtTRbxKBN17syWd
         SuAft52Hh9t2kMf+sjM2iM8hljI+ipy+znhhwC3lEtbUlhf6ifILFjPHRKOMvoWXvkTJ
         vEcA==
X-Forwarded-Encrypted: i=1; AJvYcCWC5N8ET04WY8K4sEVOhQMy9fKrfomEas/rLDc+GKivH/qdpax34bICuWZjU84KRGKIhAYRdjcWz2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweKG15Z8q1rxefZQy6A+qwMg/ZgXEeMeMnLL9ZCs4mfIZKLev
	DC1G+xMeJpv+tlsBbZUCZ2al4iCkX06zuE/hMp2q/o/Cm3Bmp3LlMbjDiWGxoS8PkPCwgkfXIj+
	CEFbWSzhPAhPjUbV4mUdERxSzXTPmy08=
X-Gm-Gg: AZuq6aKE6qZQI55vj8yZCwJY+mLilRFa71vsMrGxWJjDwEOMnmkU/Ocz+i0/s1l4e8H
	/+/1wo6QLEAx5+kWeyrmvY/mwU5EVDXpm/YrCty9iOk6guJnBsL/wnrCCNkPpakaRpz1l0bL3HP
	ku8dZ2TojT5IvLn2i70ft9JpzqoZt+nIo9/6xf41C9DZSGXlCd0IQy6sAMpzP5YEY8hLKbEhwt/
	LSNHwTqcn4eoFe3an15gMwY1Je+B3/GiC9IemtthjFxf6xVWN4TfX2TwyQqtsBi1WB9Q4MuHX+n
	YNlEFA==
X-Received: by 2002:a17:907:1c88:b0:b88:4224:815b with SMTP id
 a640c23a62f3a-b8e9f916070mr149447666b.3.1770187096906; Tue, 03 Feb 2026
 22:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770119693.git.zhoubinbin@loongson.cn> <d7a73d1fe8a3e4e57055a15a6ec03170f0d8ca21.1770119693.git.zhoubinbin@loongson.cn>
 <CAJhJPsVRZe_E6FsNBUa6K=GmPp3FXRrOH=yguvTY=K1cGwa62Q@mail.gmail.com>
 <CAMpQs4JM43ePsYAA0GVeKc5_WJL1TWSm-K2RKXcYJjttR6k6-w@mail.gmail.com> <CAJhJPsXHZnC-BZu13YiMXNTP9VqE_0mnpOUBbnB7a6-GJy-n+w@mail.gmail.com>
In-Reply-To: <CAJhJPsXHZnC-BZu13YiMXNTP9VqE_0mnpOUBbnB7a6-GJy-n+w@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 4 Feb 2026 14:38:04 +0800
X-Gm-Features: AZwV_Qh2oEmLUd_ddWtCs_wCyqukUmQaKhtMX0y9BvYgZyKogQ8PSKcUYrrILUc
Message-ID: <CAMpQs4LNZ-ukbFq5rLLFhVegYQBvHijnDp7pEp4uz7ebGZE_NQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: loongson: New directory for Loongson DMA
 controllers drivers
To: Keguang Zhang <keguang.zhang@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8708-lists,dmaengine=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CE633E25CA
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 2:35=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail.c=
om> wrote:
>
> Binbin,
>
> On Wed, Feb 4, 2026 at 2:19=E2=80=AFPM Binbin Zhou <zhoubb.aaron@gmail.co=
m> wrote:
> >
> > Hi Keguang:
> >
> > On Wed, Feb 4, 2026 at 1:43=E2=80=AFPM Keguang Zhang <keguang.zhang@gma=
il.com> wrote:
> > >
> > > On Tue, Feb 3, 2026 at 8:30=E2=80=AFPM Binbin Zhou <zhoubinbin@loongs=
on.cn> wrote:
> > > >
> > > > Gather the Loongson DMA controllers under drivers/dma/loongson/
> > > >
> > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > ---
> > > >  MAINTAINERS                                   |  2 +-
> > > >  drivers/dma/Kconfig                           | 25 ++-------------=
--
> > > >  drivers/dma/Makefile                          |  3 +-
> > > >  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++=
++++
> > > >  drivers/dma/loongson/Makefile                 |  3 ++
> > > >  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |  4 +--
> > > >  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  4 +--
> > > >  7 files changed, 39 insertions(+), 30 deletions(-)
> > > >  create mode 100644 drivers/dma/loongson/Kconfig
> > > >  create mode 100644 drivers/dma/loongson/Makefile
> > > >  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)
> > >
> > > The file loongson1-apb-dma.c was moved to drivers/dma/loongson/,
> > > but the MAINTAINERS entry still refers to the old path.
> >
> > In the MAINTAINERS, the loongson1 driver filename is matched using the
> > wildcard `*`. This move operation appears to have no effect.
> >
> > As follows:
> >
> > MIPS/LOONGSON1 ARCHITECTURE
> > M:      Keguang Zhang <keguang.zhang@gmail.com>
> > L:      linux-mips@vger.kernel.org
> > S:      Maintained
> > F:      Documentation/devicetree/bindings/*/loongson,ls1*.yaml
> > F:      arch/mips/boot/dts/loongson/loongson1*
> > F:      arch/mips/configs/loongson1_defconfig
> > F:      arch/mips/loongson32/
> > F:      drivers/*/*loongson1*
>
> I have verified that drivers/*/*loongson1* does not cover
> drivers/dma/loongson/loongson1-apb-dma.c.
> Please consider adding one of the following entries to MAINTAINERS:
> drivers/dma/loongson/loongson1-apb-dma.c

OK. I will add this.
> or
> drivers/*/loongson/*loongson1*
>
> Thanks!
>
> > F:      drivers/mtd/nand/raw/loongson-nand-controller.c
> > F:      drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > F:      sound/soc/loongson/loongson1_ac97.c
> >
> > >
> > > >  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (99%)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 5b11839cba9d..66807104af63 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -14776,7 +14776,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn=
>
> > > >  L:     dmaengine@vger.kernel.org
> > > >  S:     Maintained
> > > >  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.=
yaml
> > > > -F:     drivers/dma/loongson2-apb-dma.c
> > > > +F:     drivers/dma/loongson/loongson2-apb-dma.c
> > > >
> > > >  LOONGSON LS2X I2C DRIVER
> > > >  M:     Binbin Zhou <zhoubinbin@loongson.cn>
> > > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > > index 66cda7cc9f7a..1b84c5b11654 100644
> > > > --- a/drivers/dma/Kconfig
> > > > +++ b/drivers/dma/Kconfig
> > > > @@ -376,29 +376,6 @@ config K3_DMA
> > > >           Support the DMA engine for Hisilicon K3 platform
> > > >           devices.
> > > >
> > > > -config LOONGSON1_APB_DMA
> > > > -       tristate "Loongson1 APB DMA support"
> > > > -       depends on MACH_LOONGSON32 || COMPILE_TEST
> > > > -       select DMA_ENGINE
> > > > -       select DMA_VIRTUAL_CHANNELS
> > > > -       help
> > > > -         This selects support for the APB DMA controller in Loongs=
on1 SoCs,
> > > > -         which is required by Loongson1 NAND and audio support.
> > > > -
> > > > -config LOONGSON2_APB_DMA
> > > > -       tristate "Loongson2 APB DMA support"
> > > > -       depends on LOONGARCH || COMPILE_TEST
> > > > -       select DMA_ENGINE
> > > > -       select DMA_VIRTUAL_CHANNELS
> > > > -       help
> > > > -         Support for the Loongson2 APB DMA controller driver. The
> > > > -         DMA controller is having single DMA channel which can be
> > > > -         configured for different peripherals like audio, nand, sd=
io
> > > > -         etc which is in APB bus.
> > > > -
> > > > -         This DMA controller transfers data from memory to periphe=
ral fifo.
> > > > -         It does not support memory to memory data transfer.
> > > > -
> > > >  config LPC18XX_DMAMUX
> > > >         bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > > >         depends on ARCH_LPC18XX || COMPILE_TEST
> > > > @@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
> > > >
> > > >  source "drivers/dma/lgm/Kconfig"
> > > >
> > > > +source "drivers/dma/loongson/Kconfig"
> > > > +
> > > >  source "drivers/dma/stm32/Kconfig"
> > > >
> > > >  # clients
> > > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > > > index a54d7688392b..a1c73415b79f 100644
> > > > --- a/drivers/dma/Makefile
> > > > +++ b/drivers/dma/Makefile
> > > > @@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
> > > >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> > > >  obj-y +=3D idxd/
> > > >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > > > -obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > > > -obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > > >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > > >  obj-$(CONFIG_LPC32XX_DMAMUX) +=3D lpc32xx-dmamux.o
> > > >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > > > @@ -88,6 +86,7 @@ obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
> > > >
> > > >  obj-y +=3D amd/
> > > >  obj-y +=3D mediatek/
> > > > +obj-y +=3D loongson/
> > > >  obj-y +=3D qcom/
> > > >  obj-y +=3D stm32/
> > > >  obj-y +=3D ti/
> > > > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kc=
onfig
> > > > new file mode 100644
> > > > index 000000000000..9dbdaef5a59f
> > > > --- /dev/null
> > > > +++ b/drivers/dma/loongson/Kconfig
> > > > @@ -0,0 +1,28 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +#
> > > > +# Loongson DMA controllers drivers
> > > > +#
> > > > +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> > > > +
> > > > +config LOONGSON1_APB_DMA
> > > > +       tristate "Loongson1 APB DMA support"
> > > > +       select DMA_ENGINE
> > > > +       select DMA_VIRTUAL_CHANNELS
> > > > +       help
> > > > +         This selects support for the APB DMA controller in Loongs=
on1 SoCs,
> > > > +         which is required by Loongson1 NAND and audio support.
> > > > +
> > > > +config LOONGSON2_APB_DMA
> > > > +       tristate "Loongson2 APB DMA support"
> > > > +       select DMA_ENGINE
> > > > +       select DMA_VIRTUAL_CHANNELS
> > > > +       help
> > > > +         Support for the Loongson2 APB DMA controller driver. The
> > > > +         DMA controller is having single DMA channel which can be
> > > > +         configured for different peripherals like audio, nand, sd=
io
> > > > +         etc which is in APB bus.
> > > > +
> > > > +         This DMA controller transfers data from memory to periphe=
ral fifo.
> > > > +         It does not support memory to memory data transfer.
> > > > +
> > > > +endif
> > > > diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/M=
akefile
> > > > new file mode 100644
> > > > index 000000000000..6cdd08065e92
> > > > --- /dev/null
> > > > +++ b/drivers/dma/loongson/Makefile
> > > > @@ -0,0 +1,3 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > > > +obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > > > diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson=
/loongson1-apb-dma.c
> > > > similarity index 99%
> > > > rename from drivers/dma/loongson1-apb-dma.c
> > > > rename to drivers/dma/loongson/loongson1-apb-dma.c
> > > > index 255fe7eca212..e99247cf90c1 100644
> > > > --- a/drivers/dma/loongson1-apb-dma.c
> > > > +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> > > > @@ -16,8 +16,8 @@
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > -#include "dmaengine.h"
> > > > -#include "virt-dma.h"
> > > > +#include "../dmaengine.h"
> > > > +#include "../virt-dma.h"
> > > >
> > > >  /* Loongson-1 DMA Control Register */
> > > >  #define LS1X_DMA_CTRL          0x0
> > > > diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson=
/loongson2-apb-dma.c
> > > > similarity index 99%
> > > > rename from drivers/dma/loongson2-apb-dma.c
> > > > rename to drivers/dma/loongson/loongson2-apb-dma.c
> > > > index c528f02b9f84..0cb607595d04 100644
> > > > --- a/drivers/dma/loongson2-apb-dma.c
> > > > +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> > > > @@ -17,8 +17,8 @@
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > -#include "dmaengine.h"
> > > > -#include "virt-dma.h"
> > > > +#include "../dmaengine.h"
> > > > +#include "../virt-dma.h"
> > > >
> > > >  /* Global Configuration Register */
> > > >  #define LDMA_ORDER_ERG         0x0
> > > > --
> > > > 2.47.3
> > > >
> > >
> > >
> > > --
> > > Best regards,
> > >
> > > Keguang Zhang
> >
> > --
> > Thanks.
> > Binbin
>
>
>
> --
> Best regards,
>
> Keguang Zhang

--=20
Thanks.
Binbin

