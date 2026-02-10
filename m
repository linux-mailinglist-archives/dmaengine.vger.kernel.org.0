Return-Path: <dmaengine+bounces-8859-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOoSFIyJimmPLgAAu9opvQ
	(envelope-from <dmaengine+bounces-8859-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:27:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7713115FB0
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10E2A300CA39
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE7264617;
	Tue, 10 Feb 2026 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoIFJ9gD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650525524C
	for <dmaengine@vger.kernel.org>; Tue, 10 Feb 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686857; cv=pass; b=Tf4M4zGQGywxYnsqk0RV3kTsIBtYbaiHzUGVL3/d5Yf/eXtG4uP7rTiK3cyT9j4/yQ4TM5AObLQ0Tu47S4ZHQ5UEB/0uUN5khMYq14UNYfGe4yF6vqTwe6GLnj4Po1MpcesMvSHzi0AlPR5mn856QO6g6r+ezhYQEJcIBTAwkjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686857; c=relaxed/simple;
	bh=SCjo7Ef55zh44/8UoLsoSqyzqn7OjE/L4/11ImGPxkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+FsxFjCc/r9tstmUq5r+YHrpmbYEGuCJNtwd6uUMJjUBKQOM6uhfGc81gmTP6nu0S3jU4prsuyEl3jGdTK44LV5QMpZ0FR9B06r5c55KeFAaUp9dwHuEQhdeO3L5aO09Qdx4qp5jWkOXk9x3ypfNC9re/d8YHYF/KF2gOXbN1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoIFJ9gD; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65941c07fb4so7939986a12.3
        for <dmaengine@vger.kernel.org>; Mon, 09 Feb 2026 17:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770686853; cv=none;
        d=google.com; s=arc-20240605;
        b=bMnjLg2RIvyoirA04LTv3vHrNzTQS1ad6llhdlYzqanEbxjLoaRQC2XYMXt8Msl36G
         gqIk0s+Zlv9fXKMpwIxJaW6Hc3eBCa0Maz7dNWbcAs6XhdO6rLIGb6rgA3+WieOernyd
         6fkTXq19itcRWeyAFy4sSRIkIEeWwpziWNSAkrxJc7pijd8eDc54yHIX/ufykNfjrGm4
         XThY9vecU5hlkNJmEm9V/hvkUjyVvWpMajqFCbRtESiMbafbWmhb9UoUoGAGrNWx+KWP
         sCn4EnTwPZStFuOC08eaaKSIDJXNtrpzvNPGlhqzQG+9PijrJwQyzxcOLD0wf7PAljIO
         oc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sePhY3+7FDed9E+NZqtmjotVtiqisjqNp0aqjZx4AYw=;
        fh=HvVN5GPwQXiSrZwb9HQPEf5Mix6Uhyu55QMg5GrG+Js=;
        b=lPetNasT46YffjPvMU4xszBHpme34nPTCmGI+H9TIQTDKhpj6+I3A4JGnnG6VgJlWr
         jEZbXoI0dHO+yPfWGU9H4Mtz82DdvsBHMDVjObNRJkoyo0Z7pr8fli9uwD9j6NxYULcj
         qFn8Q2P9IUeMAwE4TTeMaksZCYF0Fvx2/dlpj28PSZXzKPTwRz2Fu64ByLy+hnhiVFmg
         Y4NH91FLqqv28aCLmgO0hqae49kUoWv7LxhsKMtyJBUqsQJiGyX3PoD1Uwvri6WEQOFU
         zCk/pkvPNN7WMv1VO2yR4BXjdErv6XINUgJ9whcbfCgAYpN07g51US35IKF31YmG1cZf
         Jr9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770686853; x=1771291653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sePhY3+7FDed9E+NZqtmjotVtiqisjqNp0aqjZx4AYw=;
        b=CoIFJ9gDPxnEy/IQ6n+DanE1VXPJcqJphNumKDAHbajCxINzPPBXL+f57llOLxYQvZ
         slB9+UHFhMGisndnoEvirRug0Q8D/7OXjb62hSh3hAvNW/ptQ7vCh7cwEJkn0onkKU3L
         O92gWqLEuEbcVFW2/EV+2EJFscIR3fjHoPpaqLHhclzcfxZAZryVWttcwmQj2CguiWoI
         JKZVdUEcAqvAIKY4AB2ecrhErMiIPTwfWq/IO9ZopfE6ORzZx3gDJ2yhEVMSMXo7uwrR
         K62NUQXHTtlX5zq75znJ/OJCgX3G8YqoRuZR639HVCwi3QDjm+wlHx0sj4drp3kj5qBT
         YOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770686853; x=1771291653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sePhY3+7FDed9E+NZqtmjotVtiqisjqNp0aqjZx4AYw=;
        b=Tipil3loWAClIsN2ztkJHqaCqnR4Ye7hG2tYVNcZMfd9OQw52XiwtVGSs2r1j17/QL
         JdFL+gWDIHYqK/yMQdNt1Sx/OLJLlT0DBJ8FFr74Oddcm41DP0bHH15y8Ch0tW3cXg7D
         qDPzllWqICmgoZaQFV+ZpUhGayDEo58uU5BaS0zL76YWbq/v3cqGxqq4mbDyS9qCohSR
         wCBiljBIgrWMs7eUzVbhRRCl7Jj1jbF3vba0kHuHuyG312VvrRfcq5i0MTK6lwEYEifm
         j4GpoocLEpePE0I0a2h2cqUrHg/C82jKSfCO8uIWP7TocWFnyTwnNCPi8ACnKZFVq5Oj
         j+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYzNd92fEuB5nVVkJN+21pP9SYsPWJUhV199XVUXTlY2wZZzDFg6RAd6UV4zwLQlKR/Hq/cCFiD04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxgn4eivbzUF8BRqSs3qyA/Q0fe5uVNpUhf9YZkwxp/lLFjGM
	DNXaIV2OlGcgYLMfZQazKQuXSoZTE/6eIT8T31oH8ZiRzh+/QHzZUTAwuI85gUYG4MpD3+/mpPM
	KOXWoGbGzuSk1/630q5foew4GtY97XUs=
X-Gm-Gg: AZuq6aKr3Zye1HFscTYY9JhfbSFva3qVy0OZnM2SxIxIGRZjlQOUAny2N+GeLnDufGP
	79fE/XCxFpqPIRsXRm39eFde8qI895zyMRoAIxyVbj/wopcsXJgnZFo1f8AnmAMm7hPjPqAzlpv
	+GLqxJIK0oZCGS1Y3xC8Avlp3OJpeiI/Hy8JPp4aQP/5Ewjhn5YfNY4yc/mlFN4BHJo6bPQSGt8
	IJH+fDdq80sMshLYpfU2OeBOcpdCcklC/tGle8/xU+2TOXrJ8qVU9EB4unHC9TRfQiyYxUx
X-Received: by 2002:a05:6402:146b:b0:658:1528:669 with SMTP id
 4fb4d7f45d1cf-65a0d144dcbmr262464a12.9.1770686853202; Mon, 09 Feb 2026
 17:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770605931.git.zhoubinbin@loongson.cn> <d62faafc653efab602c8d6bfcdcee1cb217171b9.1770605931.git.zhoubinbin@loongson.cn>
 <aYoPyWS7o27G-AHh@lizhi-Precision-Tower-5810>
In-Reply-To: <aYoPyWS7o27G-AHh@lizhi-Precision-Tower-5810>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 10 Feb 2026 09:27:21 +0800
X-Gm-Features: AZwV_Qi5_a-cKTFI06iITBG5Gu1YQfAyT8X0Ih3cxfFWjkoclvcfYBubQp9RiT0
Message-ID: <CAMpQs4+NHVQTcxdsBYp6H7c4FZpsuTo=QpKKY09sgpppDEiuNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dmaengine: loongson: New directory for Loongson
 DMA controllers drivers
To: Frank Li <Frank.li@nxp.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	Xiaochuang Mao <maoxiaochuan@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@vger.kernel.org, jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8859-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com,aosc.io];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,loongson.cn:email]
X-Rspamd-Queue-Id: C7713115FB0
X-Rspamd-Action: no action

Hi Frank:

On Tue, Feb 10, 2026 at 12:48=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:04:18AM +0800, Binbin Zhou wrote:
> > Gather the Loongson DMA controllers under drivers/dma/loongson/
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  MAINTAINERS                                   |  3 +-
> >  drivers/dma/Kconfig                           | 25 ++---------------
> >  drivers/dma/Makefile                          |  3 +-
> >  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++++
> >  drivers/dma/loongson/Makefile                 |  3 ++
> >  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |  4 +--
> >  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  4 +--
> >  7 files changed, 40 insertions(+), 30 deletions(-)
> >  create mode 100644 drivers/dma/loongson/Kconfig
> >  create mode 100644 drivers/dma/loongson/Makefile
> >  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)
> >  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (99%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f630328ca6ae..27f77b68d596 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14777,7 +14777,7 @@ M:    Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:   dmaengine@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > -F:   drivers/dma/loongson2-apb-dma.c
> > +F:   drivers/dma/loongson/loongson2-apb-dma.c
> >
> >  LOONGSON LS2X I2C DRIVER
> >  M:   Binbin Zhou <zhoubinbin@loongson.cn>
> > @@ -17515,6 +17515,7 @@ F:    arch/mips/boot/dts/loongson/loongson1*
> >  F:   arch/mips/configs/loongson1_defconfig
> >  F:   arch/mips/loongson32/
> >  F:   drivers/*/*loongson1*
> > +F:   drivers/dma/loongson/loongson1-apb-dma.c
> >  F:   drivers/mtd/nand/raw/loongson-nand-controller.c
> >  F:   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> >  F:   sound/soc/loongson/loongson1_ac97.c
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 66cda7cc9f7a..1b84c5b11654 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -376,29 +376,6 @@ config K3_DMA
> >         Support the DMA engine for Hisilicon K3 platform
> >         devices.
> >
> > -config LOONGSON1_APB_DMA
> > -     tristate "Loongson1 APB DMA support"
> > -     depends on MACH_LOONGSON32 || COMPILE_TEST
> > -     select DMA_ENGINE
> > -     select DMA_VIRTUAL_CHANNELS
> > -     help
> > -       This selects support for the APB DMA controller in Loongson1 So=
Cs,
> > -       which is required by Loongson1 NAND and audio support.
> > -
> > -config LOONGSON2_APB_DMA
> > -     tristate "Loongson2 APB DMA support"
> > -     depends on LOONGARCH || COMPILE_TEST
> > -     select DMA_ENGINE
> > -     select DMA_VIRTUAL_CHANNELS
> > -     help
> > -       Support for the Loongson2 APB DMA controller driver. The
> > -       DMA controller is having single DMA channel which can be
> > -       configured for different peripherals like audio, nand, sdio
> > -       etc which is in APB bus.
> > -
> > -       This DMA controller transfers data from memory to peripheral fi=
fo.
> > -       It does not support memory to memory data transfer.
> > -
> >  config LPC18XX_DMAMUX
> >       bool "NXP LPC18xx/43xx DMA MUX for PL080"
> >       depends on ARCH_LPC18XX || COMPILE_TEST
> > @@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
> >
> >  source "drivers/dma/lgm/Kconfig"
> >
> > +source "drivers/dma/loongson/Kconfig"
> > +
> >  source "drivers/dma/stm32/Kconfig"
> >
> >  # clients
> > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > index a54d7688392b..a1c73415b79f 100644
> > --- a/drivers/dma/Makefile
> > +++ b/drivers/dma/Makefile
> > @@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
> >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> >  obj-y +=3D idxd/
> >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > -obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > -obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> >  obj-$(CONFIG_LPC32XX_DMAMUX) +=3D lpc32xx-dmamux.o
> >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > @@ -88,6 +86,7 @@ obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
> >
> >  obj-y +=3D amd/
> >  obj-y +=3D mediatek/
> > +obj-y +=3D loongson/
>
> keep alphabet order

Sorry, I'll fix it in the next version.
>
> Frank
> >  obj-y +=3D qcom/
> >  obj-y +=3D stm32/
> >  obj-y +=3D ti/
> > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfi=
g
> > new file mode 100644
> > index 000000000000..9dbdaef5a59f
> > --- /dev/null
> > +++ b/drivers/dma/loongson/Kconfig
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Loongson DMA controllers drivers
> > +#
> > +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> > +
> > +config LOONGSON1_APB_DMA
> > +     tristate "Loongson1 APB DMA support"
> > +     select DMA_ENGINE
> > +     select DMA_VIRTUAL_CHANNELS
> > +     help
> > +       This selects support for the APB DMA controller in Loongson1 So=
Cs,
> > +       which is required by Loongson1 NAND and audio support.
> > +
> > +config LOONGSON2_APB_DMA
> > +     tristate "Loongson2 APB DMA support"
> > +     select DMA_ENGINE
> > +     select DMA_VIRTUAL_CHANNELS
> > +     help
> > +       Support for the Loongson2 APB DMA controller driver. The
> > +       DMA controller is having single DMA channel which can be
> > +       configured for different peripherals like audio, nand, sdio
> > +       etc which is in APB bus.
> > +
> > +       This DMA controller transfers data from memory to peripheral fi=
fo.
> > +       It does not support memory to memory data transfer.
> > +
> > +endif
> > diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makef=
ile
> > new file mode 100644
> > index 000000000000..6cdd08065e92
> > --- /dev/null
> > +++ b/drivers/dma/loongson/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > +obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson/loo=
ngson1-apb-dma.c
> > similarity index 99%
> > rename from drivers/dma/loongson1-apb-dma.c
> > rename to drivers/dma/loongson/loongson1-apb-dma.c
> > index 255fe7eca212..e99247cf90c1 100644
> > --- a/drivers/dma/loongson1-apb-dma.c
> > +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> > @@ -16,8 +16,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >
> > -#include "dmaengine.h"
> > -#include "virt-dma.h"
> > +#include "../dmaengine.h"
> > +#include "../virt-dma.h"
> >
> >  /* Loongson-1 DMA Control Register */
> >  #define LS1X_DMA_CTRL                0x0
> > diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson/loo=
ngson2-apb-dma.c
> > similarity index 99%
> > rename from drivers/dma/loongson2-apb-dma.c
> > rename to drivers/dma/loongson/loongson2-apb-dma.c
> > index c528f02b9f84..0cb607595d04 100644
> > --- a/drivers/dma/loongson2-apb-dma.c
> > +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> > @@ -17,8 +17,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >
> > -#include "dmaengine.h"
> > -#include "virt-dma.h"
> > +#include "../dmaengine.h"
> > +#include "../virt-dma.h"
> >
> >  /* Global Configuration Register */
> >  #define LDMA_ORDER_ERG               0x0
> > --
> > 2.52.0
> >

--=20
Thanks.
Binbin

