Return-Path: <dmaengine+bounces-8865-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP18AynhimlyOgAAu9opvQ
	(envelope-from <dmaengine+bounces-8865-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 08:41:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92153117FFA
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CA89300B18E
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B432C926;
	Tue, 10 Feb 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOaRm/wD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05833507D
	for <dmaengine@vger.kernel.org>; Tue, 10 Feb 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709284; cv=pass; b=odY72gY1U3gRu4qS98LeiOs3T1QdcPjcATPesjXL5PK5pZNU42mVD3BUumfR8tbA+GvW72m237DGco01mKlssIHR8EnQd69b7OvLZMDFsVKCRSD9XcCBuRd5bEHzc7s1ouTWPJLJSSzxwP5CjEXqo1ZFEIZZDNv0zX97Azo1gUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709284; c=relaxed/simple;
	bh=gRJYKAbzSsitC71W1NcbF2/MM1JRyAz1HzIH9qUfUhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbwQ0S/RThBnCl5outZ3MfvnKxr8V1nJyUBvJjoqrKY7hikrW9pay0iWyuLH6Uy9kqqma/8xd8h4gvT9PmAqGDGpQhLHLuur5Mc31DmgsHn3S15hldQuJeV77oNuQiIJeKSEiromm3P1zE7Kln7PsklFj/i+/crVeM8DRQQ2OZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOaRm/wD; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8838339fc6so528072766b.0
        for <dmaengine@vger.kernel.org>; Mon, 09 Feb 2026 23:41:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770709280; cv=none;
        d=google.com; s=arc-20240605;
        b=cU0kXTAGfKNmUeWycZv85k+SyXbm1G6otyc2nEDp/+mLqnNINNf16ausEuyNqQjyh0
         OLWi7Huu2X0dxqoVn7ZD9wuLb6wy/UCVkaduHF6dQzTE/pSVcmZFEl5RzsD8sqlKmzXS
         omFKq1QBHZOe945HzWtMaOmwyJAWM9m155nGUCnfEYEkkSsBkTehpxjw+YUH4PV2655L
         eSqO9tpYvnQMgsG3tTzKRnX7otYZrPFlyiJlaOsKwTag7MGXnDGvmgyTWzp0XaG+pr5O
         3i1Wvjfcr3sjyy4dcE8FRDxZCRp0AQmq5yCLWQ48b1uqVqVtUpyZy1F9RZZjDW+ZBSUu
         cNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=psxP0om9fQwwfCk6F0RRf1i00gq8HbwKkl6roFSDFEQ=;
        fh=TWl8sAqb7yY8d6TWTo+jVFUXIrZFRMUcIM+lK3q76so=;
        b=JKcFKEPDM5dlsmNpZ3KmqcpilFkgVR6wZqxep4Vz9JgMNksjo81kbKHzzyD3m4ZiCx
         MWIl6Gru2cCAnkqBlxy7UfrANpg/6bVBSrqV1eQqd+tcAuBqlhcT+yvpRdMg98Fc6ga5
         h7Bk/ODIUIWCKjwfhn5KF2gOHX266AK8D6IzV1ac7Vb+HI0LnezP3F98wBbqvlPo67wY
         v/9zSeCFwNGiEaeXMozF0A5mExeiOktpXO5riQHYj0yUCvw7RQmt5BCwcqJBQV6crx99
         wSWKZgHeiEGOviP2YHMN9NAg5t12IP/16p7Kp6JtUdk/EvJtnuHqUe4/Cn3V1wSQPo4y
         Il9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770709280; x=1771314080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psxP0om9fQwwfCk6F0RRf1i00gq8HbwKkl6roFSDFEQ=;
        b=SOaRm/wDqu/36Wrik6Dam+FOl33VEFtPkD76854WTVOqisfxY/U8LEW74knz+4Mj05
         C4/X1ACimRcQgeK66FS3PRUHMwoshljWH68Hq0JShJAePwb7tCDb/v044tK1FWgKuCgg
         ALRwL0YZ+i57qJdqv35dHSL7mu2yRoNCoWf/MNZ9+q9e8s5FVFbe7+cC2PDZqNB14H+e
         mv7gxBRm5+yPeeWK5mYOg0SOUDJG3aSM97NnSktnKuTMw7azLJcJxWPSuCYBPTV+yDJf
         A0VgkeQMjGkzoRA9i3k95aYp3GSnCKyPaDslmw//IfCZg5fUljbxl2IfAcwLtUIhTh3T
         h2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770709280; x=1771314080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psxP0om9fQwwfCk6F0RRf1i00gq8HbwKkl6roFSDFEQ=;
        b=uqZEou0LeGd44tuVIxi0AFbItnEAqjVt7E7OXZr5WXxnVNiCWx1FmE9NXB9i6pNS0w
         Umzm+phAgpim7Ou16gofctjxU/DkINEPNH1JG7vqf4JkuDwo+0e9JAaausz2g7o5IcSP
         v2ifMn0ht7qj7QkYk49/F1TCI7hwOE/WRO3fG2G/llYoHdmLyxS+10S6RbHMdldqGvQM
         1cINYB5gF2K+E9nISR/ISf/OZ1Fze1inFBbiRIF+z2aOkTrqUJ1Rz/ja8eB2OrK88Mji
         hI8Hdfoo5OmDtGdSnVU0OyH4da1GC9exVjpY/oHKy/Y+C/dcyT4JpQYm/nBw/sp4yuy1
         vNew==
X-Forwarded-Encrypted: i=1; AJvYcCUmgMUf6iwRn6QEiB++tnk2mKS6rS7vy29UKERHNP/EZQKUW6qdCRdctWBrPm2p80ZgidY45KT/JmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3pLXtGE84pE/33dFrSl1MpRzUFjoywbv+ysSE+b0zEIY8WpzZ
	OV7KYcyWn8/asSmW56x50L8TQO1UqcSQ3L5TwwQJIK4kQO9mVbyuI4flEgFluIDRuVQzv0ujFqy
	spDvrel8wuozeOlqFS0uBzjHvI4uzngk=
X-Gm-Gg: AZuq6aJ1QKqab462aEMcNL2wCkqngwVgonOTpDU94vW1+DbmLMJzAWnRtg+JeKRNSiN
	6oRr4jRB7dx9WhqP/HbnnAvFMVHtzWn2jxRP93eNIEYXwc96QFgMtFWtEzd2QmkL81S8R3h/9ws
	I278O0ynB99z8Kw+fT/dClmkftgsjsC7V1kxfz19zYS9sntOWv9LasbrQhx5+zT3/8V4/qMUMuu
	qsYxF3bT930Dc4vHNqBoyJXYt6sEgHLjQL/arSwt1k5qbRmG6hBFvzsY/4eq7UjuRIh+oCN5ZAW
	zPwf08MF
X-Received: by 2002:a17:907:1c03:b0:b87:59a8:4c8 with SMTP id
 a640c23a62f3a-b8f510d4d0cmr89300266b.5.1770709279617; Mon, 09 Feb 2026
 23:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770605931.git.zhoubinbin@loongson.cn> <a0eac5b7ba0bcced9664ff64349e563da3d031b3.1770605931.git.zhoubinbin@loongson.cn>
 <aYoTtQ01VGXEW2Fu@lizhi-Precision-Tower-5810>
In-Reply-To: <aYoTtQ01VGXEW2Fu@lizhi-Precision-Tower-5810>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 10 Feb 2026 15:41:06 +0800
X-Gm-Features: AZwV_QjET3aYp-Yt7268AWYyRfStsjS47uJUtZOMmms_VKpXYn1hcW6yLJd2r6E
Message-ID: <CAMpQs4JwDSWCXYFiPXNf1pKbYqUK+9hLXYsQsG+rQQqi_eZJwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
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
	TAGGED_FROM(0.00)[bounces-8865-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 92153117FFA
X-Rspamd-Action: no action

Hi Frank:

Thanks for your reply.

On Tue, Feb 10, 2026 at 1:05=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:04:55AM +0800, Binbin Zhou wrote:
> > This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
> >
> > It is a chain multi-channel controller that enables data transfers from
> > memory to memory, device to memory, and memory to device, as well as
> > channel prioritization configurable through the channel configuration
> > registers.
> >
> > In addition, there are slight differences between Loongson-2K0300 and
> > Loongson-2K3000, such as channel register offsets and the number of
> > channels.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  MAINTAINERS                                  |   1 +
> >  drivers/dma/loongson/Kconfig                 |  10 +
> >  drivers/dma/loongson/Makefile                |   1 +
> >  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 736 +++++++++++++++++++
> >  4 files changed, 748 insertions(+)
> >  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d3cb541aee2a..61a39070d7a0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14778,6 +14778,7 @@ L:    dmaengine@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > +F:   drivers/dma/loongson/loongson2-apb-cmc-dma.c
> >  F:   drivers/dma/loongson/loongson2-apb-dma.c
> >
> >  LOONGSON LS2X I2C DRIVER
> > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfi=
g
> > index 9dbdaef5a59f..28b3daeed4e3 100644
> > --- a/drivers/dma/loongson/Kconfig
> > +++ b/drivers/dma/loongson/Kconfig
> > @@ -25,4 +25,14 @@ config LOONGSON2_APB_DMA
> >         This DMA controller transfers data from memory to peripheral fi=
fo.
> >         It does not support memory to memory data transfer.
> >
> > +config LOONGSON2_APB_CMC_DMA
> > +     tristate "Loongson2 Chain Multi-Channel DMA support"
> > +     select DMA_ENGINE
> > +     select DMA_VIRTUAL_CHANNELS
> > +     help
> > +       Support for the Loongson Chain Multi-Channel DMA controller dri=
ver.
> > +       It is discovered on the Loongson-2K chip (Loongson-2K0300/Loong=
son-2K3000),
> > +       which has 4/8 channels internally, enabling bidirectional data =
transfer
> > +       between devices and memory.
> > +
> >  endif
> > diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makef=
ile
> > index 6cdd08065e92..48c19781e729 100644
> > --- a/drivers/dma/loongson/Makefile
> > +++ b/drivers/dma/loongson/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> >  obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > +obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) +=3D loongson2-apb-cmc-dma.o
> > diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma=
/loongson/loongson2-apb-cmc-dma.c
> > new file mode 100644
> > index 000000000000..f598ad095686
> > --- /dev/null
> > +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > @@ -0,0 +1,736 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Looongson-2 Multi-Channel DMA Controller driver
> > + *
> > + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/acpi_dma.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include "../dmaengine.h"
> > +#include "../virt-dma.h"
> > +
> > +#define LOONGSON2_CMCDMA_ISR         0x0     /* DMA Interrupt Status R=
egister */
> > +#define LOONGSON2_CMCDMA_IFCR                0x4     /* DMA Interrupt =
Flag Clear Register */
> > +#define LOONGSON2_CMCDMA_CCR         0x8     /* DMA Channel Configurat=
ion Register */
> > +#define LOONGSON2_CMCDMA_CNDTR               0xc     /* DMA Channel Tr=
ansmit Count Register */
> > +#define LOONGSON2_CMCDMA_CPAR                0x10    /* DMA Channel Pe=
ripheral Address Register */
> > +#define LOONGSON2_CMCDMA_CMAR                0x14    /* DMA Channel Me=
mory Address Register */
> > +
> > +/* Bitfields of DMA interrupt status register */
> > +#define LOONGSON2_CMCDMA_TCI         BIT(1) /* Transfer Complete Inter=
rupt */
> > +#define LOONGSON2_CMCDMA_HTI         BIT(2) /* Half Transfer Interrupt=
 */
> > +#define LOONGSON2_CMCDMA_TEI         BIT(3) /* Transfer Error Interrup=
t */
> > +
> > +#define LOONGSON2_CMCDMA_MASKI               \
> > +     (LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CMCDMA_T=
EI)
> > +
> > +/* Bitfields of DMA channel x Configuration Register */
> > +#define LOONGSON2_CMCDMA_CCR_EN              BIT(0) /* Stream Enable *=
/
> > +#define LOONGSON2_CMCDMA_CCR_TCIE    BIT(1) /* Transfer Complete Inter=
rupt Enable */
> > +#define LOONGSON2_CMCDMA_CCR_HTIE    BIT(2) /* Half Transfer Complete =
Interrupt Enable */
> > +#define LOONGSON2_CMCDMA_CCR_TEIE    BIT(3) /* Transfer Error Interrup=
t Enable */
> > +#define LOONGSON2_CMCDMA_CCR_DIR     BIT(4) /* Data Transfer Direction=
 */
> > +#define LOONGSON2_CMCDMA_CCR_CIRC    BIT(5) /* Circular mode */
> > +#define LOONGSON2_CMCDMA_CCR_PINC    BIT(6) /* Peripheral increment mo=
de */
> > +#define LOONGSON2_CMCDMA_CCR_MINC    BIT(7) /* Memory increment mode *=
/
> > +#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK      GENMASK(9, 8)
> > +#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK      GENMASK(11, 10)
> > +#define LOONGSON2_CMCDMA_CCR_PL_MASK GENMASK(13, 12)
> > +#define LOONGSON2_CMCDMA_CCR_M2M     BIT(14)
> > +
> > +#define LOONGSON2_CMCDMA_CCR_CFG_MASK        \
> > +     (LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LOONGSON=
2_CMCDMA_CCR_PL_MASK)
> > +
> > +#define LOONGSON2_CMCDMA_CCR_IRQ_MASK        \
> > +     (LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LOONGSON=
2_CMCDMA_CCR_TEIE)
> > +
> > +#define LOONGSON2_CMCDMA_STREAM_MASK \
> > +     (LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_MASK)
> > +
> > +#define LOONGSON2_CMCDMA_BUSWIDTHS   (BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |=
 \
> > +                                      BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) =
| \
> > +                                      BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
> > +
> > +enum loongson2_cmc_dma_width {
> > +     LOONGSON2_CMCDMA_BYTE,
> > +     LOONGSON2_CMCDMA_HALF_WORD,
> > +     LOONGSON2_CMCDMA_WORD,
> > +};
> > +
> > +struct loongson2_cmc_dma_chan_reg {
> > +     u32 ccr;
> > +     u32 cndtr;
> > +     u32 cpar;
> > +     u32 cmar;
> > +};
> > +
> > +struct loongson2_cmc_dma_sg_req {
> > +     u32 len;
> > +     struct loongson2_cmc_dma_chan_reg chan_reg;
> > +};
> > +
> > +struct loongson2_cmc_dma_desc {
> > +     struct virt_dma_desc vdesc;
> > +     bool cyclic;
> > +     u32 num_sgs;
> > +     struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_sgs);
> > +};
> > +
> > +struct loongson2_cmc_dma_chan {
> > +     struct virt_dma_chan vchan;
> > +     struct dma_slave_config dma_sconfig;
> > +     struct loongson2_cmc_dma_desc *desc;
> > +     u32 id;
> > +     u32 irq;
> > +     u32 next_sg;
> > +     struct loongson2_cmc_dma_chan_reg chan_reg;
> > +};
> > +
> > +struct loongson2_cmc_dma_config {
> > +     u32 max_channels;
> > +     u32 chan_reg_offset;
> > +};
> > +
> > +struct loongson2_cmc_dma_dev {
> > +     struct dma_device ddev;
> > +     struct clk *dma_clk;
> > +     void __iomem *base;
> > +     u32 nr_channels;
> > +     u32 chan_reg_offset;
> > +     struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channels);
> > +};
> > +
> > +static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_config =
=3D {
> > +     .max_channels =3D 8,
> > +     .chan_reg_offset =3D 0x14,
> > +};
> > +
> > +static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_config =
=3D {
> > +     .max_channels =3D 4,
> > +     .chan_reg_offset =3D 0x18,
> > +};
> > +
> > +static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongson2_cm=
c_dma_chan *lchan)
> > +{
> > +     return container_of(lchan->vchan.chan.device, struct loongson2_cm=
c_dma_dev, ddev);
> > +}
> > +
> > +static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_chan *c=
han)
> > +{
> > +     return container_of(chan, struct loongson2_cmc_dma_chan, vchan.ch=
an);
> > +}
> > +
> > +static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_de=
sc *vdesc)
> > +{
> > +     return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
> > +}
> > +
> > +static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
> > +{
> > +     return &lchan->vchan.chan.dev->device;
> > +}
> > +
> > +static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev,=
 u32 reg, u32 id)
> > +{
> > +     return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
> > +}
> > +
> > +static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev *ldde=
v, u32 reg, u32 id, u32 val)
> > +{
> > +     writel(val, lddev->base + (reg + lddev->chan_reg_offset * id));
> > +}
> > +
> > +static int loongson2_cmc_dma_get_width(struct loongson2_cmc_dma_chan *=
lchan,
> > +                                    enum dma_slave_buswidth width)
> > +{
> > +     switch (width) {
> > +     case DMA_SLAVE_BUSWIDTH_1_BYTE:
> > +             return LOONGSON2_CMCDMA_BYTE;
> > +     case DMA_SLAVE_BUSWIDTH_2_BYTES:
> > +             return LOONGSON2_CMCDMA_HALF_WORD;
> > +     case DMA_SLAVE_BUSWIDTH_4_BYTES:
> > +             return LOONGSON2_CMCDMA_WORD;
>
> is ffs() helper in case your hardware support more buswidth in future?

It seems there's no need for us to do this.
The data width setting bit in the DMA channel configuration register
only has two bits (LOONGSON2_CMCDMA_CCR_PSIZE_MASK). The bitmask
values are: 8-bit/16-bit/32-bit/reserved.
>
> > +     default:
> > +             dev_err(chan2dev(lchan), "Dma bus width not supported\n")=
;
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int loongson2_cmc_dma_slave_config(struct dma_chan *chan, struc=
t dma_slave_config *config)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +
> > +     memcpy(&lchan->dma_sconfig, config, sizeof(*config));
> > +
> > +     return 0;
> > +}
> > +
> > +static void loongson2_cmc_dma_irq_clear(struct loongson2_cmc_dma_chan =
*lchan, u32 flags)
> > +{
> > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> > +     u32 ifcr;
> > +
> > +     ifcr =3D flags << (4 * lchan->id);
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_IFCR, 0, ifcr);
> > +}
> > +
> > +static void loongson2_cmc_dma_stop(struct loongson2_cmc_dma_chan *lcha=
n)
> > +{
> > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> > +     u32 ccr;
> > +
> > +     ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan=
->id);
> > +     ccr &=3D ~(LOONGSON2_CMCDMA_CCR_IRQ_MASK | LOONGSON2_CMCDMA_CCR_E=
N);
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, c=
cr);
> > +
> > +     loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_MASKI);
> > +}
> > +
> > +static int loongson2_cmc_dma_terminate_all(struct dma_chan *chan)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +     unsigned long flags;
> > +
> > +     LIST_HEAD(head);
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     if (lchan->desc) {
> > +             vchan_terminate_vdesc(&lchan->desc->vdesc);
> > +             loongson2_cmc_dma_stop(lchan);
> > +             lchan->desc =3D NULL;
> > +     }
> > +     vchan_get_all_descriptors(&lchan->vchan, &head);
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +
> > +     vchan_dma_desc_free_list(&lchan->vchan, &head);
> > +
> > +     return 0;
> > +}
> > +
> > +static void loongson2_cmc_dma_synchronize(struct dma_chan *chan)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +
> > +     vchan_synchronize(&lchan->vchan);
> > +}
> > +
> > +static void loongson2_cmc_dma_start_transfer(struct loongson2_cmc_dma_=
chan *lchan)
> > +{
> > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> > +     struct loongson2_cmc_dma_sg_req *sg_req;
> > +     struct loongson2_cmc_dma_chan_reg *reg;
> > +     struct virt_dma_desc *vdesc;
> > +
> > +     loongson2_cmc_dma_stop(lchan);
> > +
> > +     if (!lchan->desc) {
> > +             vdesc =3D vchan_next_desc(&lchan->vchan);
> > +             if (!vdesc)
> > +                     return;
> > +
> > +             list_del(&vdesc->node);
> > +             lchan->desc =3D to_lmdma_desc(vdesc);
> > +             lchan->next_sg =3D 0;
> > +     }
> > +
> > +     if (lchan->next_sg =3D=3D lchan->desc->num_sgs)
> > +             lchan->next_sg =3D 0;
> > +
> > +     sg_req =3D &lchan->desc->sg_req[lchan->next_sg];
> > +     reg =3D &sg_req->chan_reg;
> > +
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, r=
eg->ccr);
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id,=
 reg->cndtr);
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CPAR, lchan->id, =
reg->cpar);
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, lchan->id, =
reg->cmar);
> > +
> > +     lchan->next_sg++;
> > +
> > +     /* Start DMA */
> > +     reg->ccr |=3D LOONGSON2_CMCDMA_CCR_EN;
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, r=
eg->ccr);
> > +}
> > +
> > +static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_d=
ma_chan *lchan)
> > +{
> > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> > +     struct loongson2_cmc_dma_sg_req *sg_req;
> > +     u32 ccr, id =3D lchan->id;
> > +
> > +     if (lchan->next_sg =3D=3D lchan->desc->num_sgs)
> > +             lchan->next_sg =3D 0;
> > +
> > +     /* stop to update mem addr */
> > +     ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, id);
> > +     ccr &=3D ~LOONGSON2_CMCDMA_CCR_EN;
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> > +
> > +     sg_req =3D &lchan->desc->sg_req[lchan->next_sg];
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req-=
>chan_reg.cmar);
> > +
> > +     /* start transition */
> > +     ccr |=3D LOONGSON2_CMCDMA_CCR_EN;
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> > +}
> > +
> > +static void loongson2_cmc_dma_handle_chan_done(struct loongson2_cmc_dm=
a_chan *lchan)
> > +{
> > +     if (!lchan->desc)
> > +             return;
> > +
> > +     if (lchan->desc->cyclic) {
> > +             vchan_cyclic_callback(&lchan->desc->vdesc);
> > +             /* LOONGSON2_CMCDMA_CCR_CIRC mode don't need update regis=
ter */
> > +             if (lchan->desc->num_sgs =3D=3D 1)
> > +                     return;
> > +             loongson2_cmc_dma_configure_next_sg(lchan);
> > +             lchan->next_sg++;
> > +     } else {
> > +             if (lchan->next_sg =3D=3D lchan->desc->num_sgs) {
> > +                     vchan_cookie_complete(&lchan->desc->vdesc);
> > +                     lchan->desc =3D NULL;
> > +             }
> > +             loongson2_cmc_dma_start_transfer(lchan);
> > +     }
> > +}
> > +
> > +static irqreturn_t loongson2_cmc_dma_chan_irq(int irq, void *devid)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D devid;
> > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> > +     u32 ists, status, scr;
> > +
> > +     spin_lock(&lchan->vchan.lock);
> > +
> > +     ists =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_ISR, 0);
> > +     scr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan=
->id);
> > +
> > +     status =3D (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_MASKI;
> > +     status &=3D scr;
> > +
> > +     if (status & LOONGSON2_CMCDMA_TCI)
> > +             loongson2_cmc_dma_handle_chan_done(lchan);
> > +
> > +     if (status & LOONGSON2_CMCDMA_HTI)
> > +             loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI);
> > +
> > +     if (status & LOONGSON2_CMCDMA_TEI)
> > +             dev_err(chan2dev(lchan), "DMA Transform Error\n");
> > +
> > +     loongson2_cmc_dma_irq_clear(lchan, status);
>
> irq clear should before loongson2_cmc_dma_handle_chan_done() incase you
> missed irq, if loongson2_cmc_dma_handle_chan_done() trigger new irq befor=
e
> your call irq_cler().
>
> > +
> > +     spin_unlock(&lchan->vchan.lock);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
> > +             dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->v=
chan);
> > +             loongson2_cmc_dma_start_transfer(lchan);
> > +     }
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +}
> > +
> > +static int loongson2_cmc_dma_set_xfer_param(struct loongson2_cmc_dma_c=
han *lchan,
> > +                                         enum dma_transfer_direction d=
irection,
> > +                                         enum dma_slave_buswidth *busw=
idth, u32 buf_len)
> > +{
> > +     struct dma_slave_config sconfig =3D lchan->dma_sconfig;
> > +     int dev_width;
> > +     u32 ccr;
> > +
> > +     switch (direction) {
> > +     case DMA_MEM_TO_DEV:
> > +             dev_width =3D loongson2_cmc_dma_get_width(lchan, sconfig.=
dst_addr_width);
> > +             if (dev_width < 0)
> > +                     return dev_width;
> > +             lchan->chan_reg.cpar =3D sconfig.dst_addr;
> > +             ccr =3D LOONGSON2_CMCDMA_CCR_DIR;
> > +             *buswidth =3D sconfig.dst_addr_width;
> > +             break;
> > +     case DMA_DEV_TO_MEM:
> > +             dev_width =3D loongson2_cmc_dma_get_width(lchan, sconfig.=
src_addr_width);
> > +             if (dev_width < 0)
> > +                     return dev_width;
> > +             lchan->chan_reg.cpar =3D sconfig.src_addr;
> > +             ccr =3D LOONGSON2_CMCDMA_CCR_MINC;
> > +             *buswidth =3D sconfig.src_addr_width;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ccr |=3D FIELD_PREP(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, dev_width) |
> > +            FIELD_PREP(LOONGSON2_CMCDMA_CCR_MSIZE_MASK, dev_width);
> > +
> > +     /* Set DMA control register */
> > +     lchan->chan_reg.ccr &=3D ~(LOONGSON2_CMCDMA_CCR_PSIZE_MASK | LOON=
GSON2_CMCDMA_CCR_MSIZE_MASK);
> > +     lchan->chan_reg.ccr |=3D ccr;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct dma_async_tx_descriptor *
> > +loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterl=
ist *sgl, u32 sg_len,
> > +                             enum dma_transfer_direction direction,
> > +                             unsigned long flags, void *context)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +     struct loongson2_cmc_dma_desc *desc;
> > +     enum dma_slave_buswidth buswidth;
> > +     struct scatterlist *sg;
> > +     u32 num_items, i;
> > +     int ret;
> > +
> > +     desc =3D kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOWAIT);
> > +     if (!desc)
> > +             return NULL;
> > +
> > +     for_each_sg(sgl, sg, sg_len, i) {
> > +             ret =3D loongson2_cmc_dma_set_xfer_param(lchan, direction=
, &buswidth, sg_dma_len(sg));
> > +             if (ret)
> > +                     return NULL;
> > +
> > +             desc->sg_req[i].len =3D sg_dma_len(sg);
> > +
> > +             num_items =3D desc->sg_req[i].len / buswidth;
> > +             if (num_items >=3D SZ_64K) {
> > +                     dev_err(chan2dev(lchan), "Number of items not sup=
ported\n");
> > +                     kfree(desc);
> > +                     return NULL;
>
> if use sg_nents_for_dma(), you can use multi sg to trasfer more than 64K
> data.

Sorry, are you referring to sg_nents_for_len()?
64K is a hardware limitation of the controller, so it seems impossible
to resolve it using that function, right?

>
> > +             }
> > +             desc->sg_req[i].chan_reg.ccr =3D lchan->chan_reg.ccr;
> > +             desc->sg_req[i].chan_reg.cpar =3D lchan->chan_reg.cpar;
> > +             desc->sg_req[i].chan_reg.cmar =3D sg_dma_address(sg);
> > +             desc->sg_req[i].chan_reg.cndtr =3D num_items;
> > +     }
> > +
> > +     desc->num_sgs =3D sg_len;
> > +     desc->cyclic =3D false;
> > +
> > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > +}
> > +
> > +static struct dma_async_tx_descriptor *
> > +loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t bu=
f_addr, size_t buf_len,
> > +                               size_t period_len, enum dma_transfer_di=
rection direction,
> > +                               unsigned long flags)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +     struct loongson2_cmc_dma_desc *desc;
> > +     enum dma_slave_buswidth buswidth;
> > +     u32 num_periods, num_items, i;
> > +     int ret;
> > +
> > +     if (unlikely(buf_len % period_len))
> > +             return NULL;
> > +
> > +     ret =3D loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswi=
dth, period_len);
> > +     if (ret)
> > +             return NULL;
> > +
> > +     num_items =3D period_len / buswidth;
> > +     if (num_items >=3D SZ_64K) {
> > +             dev_err(chan2dev(lchan), "Number of items not supported\n=
");
> > +             return NULL;
> > +     }
> > +
> > +     /* Enable Circular mode */
> > +     if (buf_len =3D=3D period_len)
> > +             lchan->chan_reg.ccr |=3D LOONGSON2_CMCDMA_CCR_CIRC;
> > +
> > +     num_periods =3D buf_len / period_len;
> > +     desc =3D kzalloc(struct_size(desc, sg_req, num_periods), GFP_NOWA=
IT);
> > +     if (!desc)
> > +             return NULL;
> > +
> > +     for (i =3D 0; i < num_periods; i++) {
> > +             desc->sg_req[i].len =3D period_len;
> > +             desc->sg_req[i].chan_reg.ccr =3D lchan->chan_reg.ccr;
> > +             desc->sg_req[i].chan_reg.cpar =3D lchan->chan_reg.cpar;
> > +             desc->sg_req[i].chan_reg.cmar =3D buf_addr;
> > +             desc->sg_req[i].chan_reg.cndtr =3D num_items;
> > +             buf_addr +=3D period_len;
> > +     }
> > +
> > +     desc->num_sgs =3D num_periods;
> > +     desc->cyclic =3D true;
> > +
> > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > +}
> > +
> > +static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_=
chan *lchan,
> > +                                          struct loongson2_cmc_dma_des=
c *desc, u32 next_sg)
> > +{
> > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> > +     u32 residue, width, ndtr, ccr, i;
> > +
> > +     ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan=
->id);
> > +     width =3D FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
> > +
> > +     ndtr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lc=
han->id);
> > +     residue =3D ndtr << width;
> > +
> > +     if (lchan->desc->cyclic && next_sg =3D=3D 0)
> > +             return residue;
> > +
> > +     for (i =3D next_sg; i < desc->num_sgs; i++)
> > +             residue +=3D desc->sg_req[i].len;
> > +
> > +     return residue;
> > +}
> > +
> > +static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *ch=
an, dma_cookie_t cookie,
> > +                                                struct dma_tx_state *s=
tate)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +     struct virt_dma_desc *vdesc;
> > +     enum dma_status status;
> > +     unsigned long flags;
> > +
> > +     status =3D dma_cookie_status(chan, cookie, state);
> > +     if (status =3D=3D DMA_COMPLETE || !state)
> > +             return status;
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     vdesc =3D vchan_find_desc(&lchan->vchan, cookie);
> > +     if (lchan->desc && cookie =3D=3D lchan->desc->vdesc.tx.cookie)
> > +             state->residue =3D loongson2_cmc_dma_desc_residue(lchan, =
lchan->desc, lchan->next_sg);
> > +     else if (vdesc)
> > +             state->residue =3D loongson2_cmc_dma_desc_residue(lchan, =
to_lmdma_desc(vdesc), 0);
> > +
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +
> > +     return status;
> > +}
> > +
> > +static void loongson2_cmc_dma_free_chan_resources(struct dma_chan *cha=
n)
> > +{
> > +     vchan_free_chan_resources(to_virt_chan(chan));
> > +}
> > +
> > +static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vdesc)
> > +{
> > +     kfree(to_lmdma_desc(vdesc));
> > +}
> > +
> > +static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan, void =
*param)
> > +{
> > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> > +     struct acpi_dma_spec *dma_spec =3D param;
> > +
> > +     memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_=
reg));
> > +     lchan->chan_reg.ccr =3D dma_spec->chan_id & LOONGSON2_CMCDMA_STRE=
AM_MASK;
> > +
> > +     return true;
> > +}
> > +
> > +static int loongson2_cmc_dma_acpi_controller_register(struct loongson2=
_cmc_dma_dev *lddev)
> > +{
> > +     struct device *dev =3D lddev->ddev.dev;
> > +     struct acpi_dma_filter_info *info;
> > +     int ret;
> > +
> > +     if (!has_acpi_companion(dev))
> > +             return 0;
> > +
> > +     info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > +     if (!info)
> > +             return -ENOMEM;
> > +
> > +     dma_cap_zero(info->dma_cap);
> > +     info->dma_cap =3D lddev->ddev.cap_mask;
> > +     info->filter_fn =3D loongson2_cmc_dma_acpi_filter;
> > +
> > +     ret =3D devm_acpi_dma_controller_register(dev, acpi_dma_simple_xl=
ate, info);
> > +     if (ret)
> > +             dev_err(dev, "could not register acpi_dma_controller\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_phandle_a=
rgs *dma_spec,
> > +                                                struct of_dma *ofdma)
> > +{
> > +     struct loongson2_cmc_dma_dev *lddev =3D ofdma->of_dma_data;
> > +     struct device *dev =3D lddev->ddev.dev;
> > +     struct loongson2_cmc_dma_chan *lchan;
> > +     struct dma_chan *chan;
> > +
> > +     if (dma_spec->args_count < 2)
> > +             return NULL;
> > +
> > +     if (dma_spec->args[0] >=3D lddev->nr_channels) {
> > +             dev_err(dev, "Invalid channel id\n");
> > +             return NULL;
> > +     }
> > +
> > +     lchan =3D &lddev->chan[dma_spec->args[0]];
> > +     chan =3D dma_get_slave_channel(&lchan->vchan.chan);
> > +     if (!chan) {
> > +             dev_err(dev, "No more channels available\n");
> > +             return NULL;
> > +     }
> > +
> > +     memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_=
reg));
> > +     lchan->chan_reg.ccr =3D dma_spec->args[1] & LOONGSON2_CMCDMA_STRE=
AM_MASK;
> > +
> > +     return chan;
> > +}
> > +
> > +static int loongson2_cmc_dma_of_controller_register(struct loongson2_c=
mc_dma_dev *lddev)
> > +{
> > +     struct device *dev =3D lddev->ddev.dev;
> > +     int ret;
> > +
> > +     if (!dev->of_node)
> > +             return 0;
> > +
> > +     ret =3D of_dma_controller_register(dev->of_node, loongson2_cmc_dm=
a_of_xlate, lddev);
> > +     if (ret)
> > +             dev_err(dev, "could not register of_dma_controller\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int loongson2_cmc_dma_probe(struct platform_device *pdev)
> > +{
> > +     const struct loongson2_cmc_dma_config *config;
> > +     struct loongson2_cmc_dma_chan *lchan;
> > +     struct loongson2_cmc_dma_dev *lddev;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct dma_device *ddev;
> > +     u32 nr_chans, i;
> > +     int ret;
> > +
> > +     config =3D (const struct loongson2_cmc_dma_config *)device_get_ma=
tch_data(dev);
> > +     if (!config)
> > +             return -EINVAL;
> > +
> > +     ret =3D device_property_read_u32(dev, "dma-channels", &nr_chans);
> > +     if (ret || nr_chans > config->max_channels) {
> > +             dev_err(dev, "missing or invalid dma-channels property\n"=
);
> > +             nr_chans =3D config->max_channels;
> > +     }
> > +
> > +     lddev =3D devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), G=
FP_KERNEL);
> > +     if (!lddev)
> > +             return -ENOMEM;
> > +
> > +     lddev->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(lddev->base))
> > +             return PTR_ERR(lddev->base);
> > +
> > +     platform_set_drvdata(pdev, lddev);
> > +     lddev->nr_channels =3D nr_chans;
> > +     lddev->chan_reg_offset =3D config->chan_reg_offset;
> > +
> > +     lddev->dma_clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +     if (IS_ERR(lddev->dma_clk))
> > +             return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Faile=
d to get dma clock\n");
> > +
> > +     ddev =3D &lddev->ddev;
> > +     ddev->dev =3D dev;
> > +
> > +     dma_cap_zero(ddev->cap_mask);
> > +     dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > +     dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> > +
> > +     ddev->device_free_chan_resources =3D loongson2_cmc_dma_free_chan_=
resources;
> > +     ddev->device_config =3D loongson2_cmc_dma_slave_config;
> > +     ddev->device_prep_slave_sg =3D loongson2_cmc_dma_prep_slave_sg;
> > +     ddev->device_prep_dma_cyclic =3D loongson2_cmc_dma_prep_dma_cycli=
c;
> > +     ddev->device_issue_pending =3D loongson2_cmc_dma_issue_pending;
> > +     ddev->device_synchronize =3D loongson2_cmc_dma_synchronize;
> > +     ddev->device_tx_status =3D loongson2_cmc_dma_tx_status;
> > +     ddev->device_terminate_all =3D loongson2_cmc_dma_terminate_all;
> > +
> > +     ddev->src_addr_widths =3D LOONGSON2_CMCDMA_BUSWIDTHS;
> > +     ddev->dst_addr_widths =3D LOONGSON2_CMCDMA_BUSWIDTHS;
> > +     ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > +     INIT_LIST_HEAD(&ddev->channels);
>
> where use this 'channels' ?

It will be used by global functions such as `dma_async_device_register()`.
>
> Frank
> > +
> > +     for (i =3D 0; i < nr_chans; i++) {
> > +             lchan =3D &lddev->chan[i];
> > +
> > +             lchan->id =3D i;
> > +             lchan->vchan.desc_free =3D loongson2_cmc_dma_desc_free;
> > +             vchan_init(&lchan->vchan, ddev);
> > +     }
> > +
> > +     ret =3D dmaenginem_async_device_register(ddev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < nr_chans; i++) {
> > +             lchan =3D &lddev->chan[i];
> > +
> > +             lchan->irq =3D platform_get_irq(pdev, i);
> > +             if (lchan->irq < 0)
> > +                     return lchan->irq;
> > +
> > +             ret =3D devm_request_irq(dev, lchan->irq, loongson2_cmc_d=
ma_chan_irq, IRQF_SHARED,
> > +                                    dev_name(chan2dev(lchan)), lchan);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret =3D loongson2_cmc_dma_acpi_controller_register(lddev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return loongson2_cmc_dma_of_controller_register(lddev);
> > +}
> > +
> > +static void loongson2_cmc_dma_remove(struct platform_device *pdev)
> > +{
> > +     of_dma_controller_free(pdev->dev.of_node);
> > +}
> > +
> > +static const struct of_device_id loongson2_cmc_dma_of_match[] =3D {
> > +     { .compatible =3D "loongson,ls2k0300-dma", .data =3D &ls2k0300_cm=
c_dma_config },
> > +     { .compatible =3D "loongson,ls2k3000-dma", .data =3D &ls2k3000_cm=
c_dma_config },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
> > +
> > +static const struct acpi_device_id loongson2_cmc_dma_acpi_match[] =3D =
{
> > +     { "LOON0014", .driver_data =3D (kernel_ulong_t)&ls2k3000_cmc_dma_=
config },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
> > +
> > +static struct platform_driver loongson2_cmc_dma_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "loongson2-apb-cmc-dma",
> > +             .of_match_table =3D loongson2_cmc_dma_of_match,
> > +             .acpi_match_table =3D loongson2_cmc_dma_acpi_match,
> > +     },
> > +     .probe =3D loongson2_cmc_dma_probe,
> > +     .remove =3D loongson2_cmc_dma_remove,
> > +};
> > +module_platform_driver(loongson2_cmc_dma_driver);
> > +
> > +MODULE_DESCRIPTION("Looongson-2 Multi-Channel DMA Controller driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.52.0
> >

--
Thanks.
Binbin

