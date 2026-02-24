Return-Path: <dmaengine+bounces-9035-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFabDdCgnWlrQwQAu9opvQ
	(envelope-from <dmaengine+bounces-9035-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 14:00:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C540318757B
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 13:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF7D307E841
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366D376BE4;
	Tue, 24 Feb 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCMVD3+2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E539B49A
	for <dmaengine@vger.kernel.org>; Tue, 24 Feb 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937997; cv=pass; b=Sq/6VqaDEmt3ZNlocaRtGleS7zfxfs/o59cz55pBOWXQl3E3Z9V6PlPsXlYbA0RyHhMfq0txJsgaxEji4QwHO0Wj1hmYCjyWZxLti1T0qWfKquFlpt73papXqbckFhtzY3xSBv2ZFCXeNw3ebLFwW07yfRH6G1X1/H4vr2GVAEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937997; c=relaxed/simple;
	bh=p3qDgr2OscXe7mu3kKJNCPd5RoBLoFqV9caAC5ANbj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7bBH+2E86tTE8d68hLHyQIb19PjdymcIezB4jr1gx2TPbgLhPLA+o3zDwI2/1GWHBudQMGwebuFYj5weJ11o+lHxIoVMmv8bVrVkvfbWiLYqCKajAWU4J8MJEdsDtTClhbzbCFJUCs006hvL+s0nHLDcbjNTRu/tv7XLW6Uasc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCMVD3+2; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65f73d68faeso413973a12.3
        for <dmaengine@vger.kernel.org>; Tue, 24 Feb 2026 04:59:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771937992; cv=none;
        d=google.com; s=arc-20240605;
        b=S1ijtaFr1HW6IvjWAkKsOX7RuMZsLf5FJzYbSFs8w0Ph6D6soAkqcCDXDHg1cz5tDi
         EVHJX1hxRXfmruRfPgYPMvxMNGBZP7yorKJqdebQD5HQ+iJXLU1GZatLIUxk5w2TgV97
         u4HUc3n2Ihi5yHUq8R4SYmoxlWXVuHqYyexWyuSDPPIQxeU+6EWAHUkqi+JGryL8gYEu
         RBdW5nPN6PXsc1JyYSXCo1ujy93izyBaXYawsjNEx77OhxTsqkQcV5K0QJDgskYWriuC
         cG3E3A9IqRZMpLIIhaHoonYfiRl6zmYHBxMCiSH1YRwt5TC7JtrcXjIg8Bmz6arZNcPW
         oJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q7R0WczpvcKeUxWf2NQQ/Mxmqc0lLtvfvQI6kBPMl2Q=;
        fh=9Ffqpina5kt8dsDklt5AfeUwKKtHI3s1vfkHFhi0CA0=;
        b=f0fFQ8sMZ9HXF7h6Axrcuy05cswH7HPzObyem9IbaDi835EEajF0L1QqBeLZ/pCX19
         sV+BEUW0N+oSC0631Z8hq2qAfv8ZYwMIQ4zOWz0okf69YdGSlPTPYvfvHZzqWPQRbBFf
         vWY9WNmQ138S2mRF9WhlZbsDbYtGOFk8yWVsyKmIKsiwEAJRLnV45QBkYGm7OYJh3GSm
         QcfTodLkLz+/2Vnz1sCZNespaJnHUCD0V6fFOEoie7YVI1mh2qlB3XyOpNAPmO72xeas
         EcFhSmYc9ALOzrJTy5JTSarKRlWyy43/7J9hTuWwfFK772f8p/t4XF2qAXAFeg6FlFtE
         MHWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771937992; x=1772542792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7R0WczpvcKeUxWf2NQQ/Mxmqc0lLtvfvQI6kBPMl2Q=;
        b=fCMVD3+2o2RduQT9R3YPe0VqjdNdf9gxwrAOpYradyo6uDWmuSlqT+o+vxqlBav3Uv
         8miGDygr3j5SrtngGvhWYheo5ypJvibxl6yYOuL5TuY+zLGp5nDCQoAXDBGS3yHFD/xl
         4pqpx7kc6xD2Gi+SVzunc0iWlHHYLD7Hw4pj0otLV0Re69HP9fZzvwJwhqdJwlHbEFLF
         IL1IqmlSiVbcO/yoa/Ry5cMGG7fE8c9caiS1jFAdP9xAGoIr2r2/+pi5E5v0vZZMq7Lr
         OKyYSz02MYMTPzQomfE92AUjSnXkxULDe4S6bxCbuSRigU3z/IGx/dlnwUw9M+h9toqV
         j8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937992; x=1772542792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7R0WczpvcKeUxWf2NQQ/Mxmqc0lLtvfvQI6kBPMl2Q=;
        b=Z8hHA3d+PWym0ISY7Ka04Own7C6pwYzTZhawUueiQaEGkV564tUpf8fZ6CHRcUHOLO
         neR9ykXIf2X2vC4n95ourb51b7TuOMG6YDyBldDlCJSaAhP/Dd036Jpq2bRdAwNRaSVt
         GZA1z446lM7rQA2p8JKFSqnpsHppxblkgTD/QumSfpaIZWGZTxnXcw8KmKDtjIDD7hXI
         GPPq9waiBcrnvxHJqCqE2P7IHg3KjJU07z7uGaKS9eQ4iwpr1b19i1A+EduTNsgzOH0o
         YmzlR5eXDUnvAWvxu2dvQrx8pKqx+c4Uqakv4kfWJjMPJhNuzhSIe3lxqtbIw7DDauD+
         L7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX2vpszumoTk6h6lg2upwJksyo/LZozpYGH8DUqEPmeO/RUvsfsMPgs71JFnoM/ZF4oEsr9B1Vvmdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyygzXnm+/UW2yhkbJWWOlhmZ+pVqZ1+ONMiBNRn3LMXQ7r5OJ9
	sIZT6V0Zt1cBAksyG7DqpH8Ck4T0wpRkl5GJ+26Doj3ixftaMg6XnzR7MndG3DMZdopSLejBLhq
	4k8c3ptociDAmEHy5sxejBvuzmIGFD/I=
X-Gm-Gg: ATEYQzzvljLKNUzlNNKndnHmVHttwA3GvZcJ3Hzb2cdPMZnEFWIp33bNalsn/NLYJlN
	EzvzqluVCNxxY2IQ2v7SU2Zh1EX2/N37lBkoP/WdEexkhwFBMK6yJN7JbRHArZdeuHUqb5hwwq8
	RuMLHQKnH32G4WD9t2IMmD6o/pe1TVCmH7CND4K+39xGMKGRVQR+1YlxITBlqUkVouy5NHY9LfC
	NinUibCvNHQy81M0zq5E6kYqdi8GaQDAXAFtYvtBdxONrPjqpRw/qeo11TsctjfMzGDsii2jY4d
	yjsbW9MDUg==
X-Received: by 2002:a05:6402:50d2:b0:64b:58c0:a393 with SMTP id
 4fb4d7f45d1cf-65ea4f07f63mr7802475a12.30.1771937991199; Tue, 24 Feb 2026
 04:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770605931.git.zhoubinbin@loongson.cn> <a0eac5b7ba0bcced9664ff64349e563da3d031b3.1770605931.git.zhoubinbin@loongson.cn>
 <aYoTtQ01VGXEW2Fu@lizhi-Precision-Tower-5810> <CAMpQs4JwDSWCXYFiPXNf1pKbYqUK+9hLXYsQsG+rQQqi_eZJwQ@mail.gmail.com>
 <CAMpQs4KSyj3HFrY0Qn_ZByekVWu3-re__6TAE=nU+uC_VfKB8w@mail.gmail.com> <aYtOVFsoDg2m6yhi@lizhi-Precision-Tower-5810>
In-Reply-To: <aYtOVFsoDg2m6yhi@lizhi-Precision-Tower-5810>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 24 Feb 2026 20:59:38 +0800
X-Gm-Features: AaiRm51oouIxUHfmuvDSElqY3KeK3njM2hJlpK97fARkHRke_xqjEUejkgh2qQE
Message-ID: <CAMpQs4+RHEDMs4PhMtRyg16zbggFQZ22rqiJfkH6An7SLyNFEA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9035-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com,aosc.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: C540318757B
X-Rspamd-Action: no action

Hi Frank:

Sorry for the late reply.

On Tue, Feb 10, 2026 at 11:27=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Feb 10, 2026 at 08:02:21PM +0800, Binbin Zhou wrote:
> > Hi Frank:
> >
> > On Tue, Feb 10, 2026 at 3:41=E2=80=AFPM Binbin Zhou <zhoubb.aaron@gmail=
.com> wrote:
> > >
> > > Hi Frank:
> > >
> > > Thanks for your reply.
> > >
> > > On Tue, Feb 10, 2026 at 1:05=E2=80=AFAM Frank Li <Frank.li@nxp.com> w=
rote:
> > > >
> > > > On Mon, Feb 09, 2026 at 11:04:55AM +0800, Binbin Zhou wrote:
> > > > > This DMA controller appears in Loongson-2K0300 and Loongson-2K300=
0.
> > > > >
> > > > > It is a chain multi-channel controller that enables data transfer=
s from
> > > > > memory to memory, device to memory, and memory to device, as well=
 as
> > > > > channel prioritization configurable through the channel configura=
tion
> > > > > registers.
> > > > >
> > > > > In addition, there are slight differences between Loongson-2K0300=
 and
> > > > > Loongson-2K3000, such as channel register offsets and the number =
of
> > > > > channels.
> > > > >
> > > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > > ---
> > > > >  MAINTAINERS                                  |   1 +
> > > > >  drivers/dma/loongson/Kconfig                 |  10 +
> > > > >  drivers/dma/loongson/Makefile                |   1 +
> > > > >  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 736 +++++++++++++=
++++++
> > > > >  4 files changed, 748 insertions(+)
> > > > >  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index d3cb541aee2a..61a39070d7a0 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -14778,6 +14778,7 @@ L:    dmaengine@vger.kernel.org
> > > > >  S:   Maintained
> > > > >  F:   Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma=
.yaml
> > > > >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.=
yaml
> > > > > +F:   drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > > >  F:   drivers/dma/loongson/loongson2-apb-dma.c
> > > > >
> > > > >  LOONGSON LS2X I2C DRIVER
> > > > > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/=
Kconfig
> > > > > index 9dbdaef5a59f..28b3daeed4e3 100644
> > > > > --- a/drivers/dma/loongson/Kconfig
> > > > > +++ b/drivers/dma/loongson/Kconfig
> > > > > @@ -25,4 +25,14 @@ config LOONGSON2_APB_DMA
> > > > >         This DMA controller transfers data from memory to periphe=
ral fifo.
> > > > >         It does not support memory to memory data transfer.
> > > > >
> > > > > +config LOONGSON2_APB_CMC_DMA
> > > > > +     tristate "Loongson2 Chain Multi-Channel DMA support"
> > > > > +     select DMA_ENGINE
> > > > > +     select DMA_VIRTUAL_CHANNELS
> > > > > +     help
> > > > > +       Support for the Loongson Chain Multi-Channel DMA controll=
er driver.
> > > > > +       It is discovered on the Loongson-2K chip (Loongson-2K0300=
/Loongson-2K3000),
> > > > > +       which has 4/8 channels internally, enabling bidirectional=
 data transfer
> > > > > +       between devices and memory.
> > > > > +
> > > > >  endif
> > > > > diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson=
/Makefile
> > > > > index 6cdd08065e92..48c19781e729 100644
> > > > > --- a/drivers/dma/loongson/Makefile
> > > > > +++ b/drivers/dma/loongson/Makefile
> > > > > @@ -1,3 +1,4 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > >  obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > > > >  obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> > > > > +obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) +=3D loongson2-apb-cmc-dma.o
> > > > > diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drive=
rs/dma/loongson/loongson2-apb-cmc-dma.c
> > > > > new file mode 100644
> > > > > index 000000000000..f598ad095686
> > > > > --- /dev/null
> > > > > +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > > > @@ -0,0 +1,736 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * Looongson-2 Multi-Channel DMA Controller driver
> > > > > + *
> > > > > + * Copyright (C) 2024-2026 Loongson Technology Corporation Limit=
ed
> > > > > + */
> > > > > +
> > > > > +#include <linux/acpi.h>
> > > > > +#include <linux/acpi_dma.h>
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/dma-mapping.h>
> > > > > +#include <linux/dmapool.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_dma.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/slab.h>
> > > > > +
> > > > > +#include "../dmaengine.h"
> > > > > +#include "../virt-dma.h"
> > > > > +
> > > > > +#define LOONGSON2_CMCDMA_ISR         0x0     /* DMA Interrupt St=
atus Register */
> > > > > +#define LOONGSON2_CMCDMA_IFCR                0x4     /* DMA Inte=
rrupt Flag Clear Register */
> > > > > +#define LOONGSON2_CMCDMA_CCR         0x8     /* DMA Channel Conf=
iguration Register */
> > > > > +#define LOONGSON2_CMCDMA_CNDTR               0xc     /* DMA Chan=
nel Transmit Count Register */
> > > > > +#define LOONGSON2_CMCDMA_CPAR                0x10    /* DMA Chan=
nel Peripheral Address Register */
> > > > > +#define LOONGSON2_CMCDMA_CMAR                0x14    /* DMA Chan=
nel Memory Address Register */
> > > > > +
> > > > > +/* Bitfields of DMA interrupt status register */
> > > > > +#define LOONGSON2_CMCDMA_TCI         BIT(1) /* Transfer Complete=
 Interrupt */
> > > > > +#define LOONGSON2_CMCDMA_HTI         BIT(2) /* Half Transfer Int=
errupt */
> > > > > +#define LOONGSON2_CMCDMA_TEI         BIT(3) /* Transfer Error In=
terrupt */
> > > > > +
> > > > > +#define LOONGSON2_CMCDMA_MASKI               \
> > > > > +     (LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CM=
CDMA_TEI)
> > > > > +
> > > > > +/* Bitfields of DMA channel x Configuration Register */
> > > > > +#define LOONGSON2_CMCDMA_CCR_EN              BIT(0) /* Stream En=
able */
> > > > > +#define LOONGSON2_CMCDMA_CCR_TCIE    BIT(1) /* Transfer Complete=
 Interrupt Enable */
> > > > > +#define LOONGSON2_CMCDMA_CCR_HTIE    BIT(2) /* Half Transfer Com=
plete Interrupt Enable */
> > > > > +#define LOONGSON2_CMCDMA_CCR_TEIE    BIT(3) /* Transfer Error In=
terrupt Enable */
> > > > > +#define LOONGSON2_CMCDMA_CCR_DIR     BIT(4) /* Data Transfer Dir=
ection */
> > > > > +#define LOONGSON2_CMCDMA_CCR_CIRC    BIT(5) /* Circular mode */
> > > > > +#define LOONGSON2_CMCDMA_CCR_PINC    BIT(6) /* Peripheral increm=
ent mode */
> > > > > +#define LOONGSON2_CMCDMA_CCR_MINC    BIT(7) /* Memory increment =
mode */
> > > > > +#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK      GENMASK(9, 8)
> > > > > +#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK      GENMASK(11, 10)
> > > > > +#define LOONGSON2_CMCDMA_CCR_PL_MASK GENMASK(13, 12)
> > > > > +#define LOONGSON2_CMCDMA_CCR_M2M     BIT(14)
> > > > > +
> > > > > +#define LOONGSON2_CMCDMA_CCR_CFG_MASK        \
> > > > > +     (LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LO=
ONGSON2_CMCDMA_CCR_PL_MASK)
> > > > > +
> > > > > +#define LOONGSON2_CMCDMA_CCR_IRQ_MASK        \
> > > > > +     (LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LO=
ONGSON2_CMCDMA_CCR_TEIE)
> > > > > +
> > > > > +#define LOONGSON2_CMCDMA_STREAM_MASK \
> > > > > +     (LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_M=
ASK)
> > > > > +
> > > > > +#define LOONGSON2_CMCDMA_BUSWIDTHS   (BIT(DMA_SLAVE_BUSWIDTH_1_B=
YTE) | \
> > > > > +                                      BIT(DMA_SLAVE_BUSWIDTH_2_B=
YTES) | \
> > > > > +                                      BIT(DMA_SLAVE_BUSWIDTH_4_B=
YTES))
> > > > > +
> > > > > +enum loongson2_cmc_dma_width {
> > > > > +     LOONGSON2_CMCDMA_BYTE,
> > > > > +     LOONGSON2_CMCDMA_HALF_WORD,
> > > > > +     LOONGSON2_CMCDMA_WORD,
> > > > > +};
> > > > > +
> > > > > +struct loongson2_cmc_dma_chan_reg {
> > > > > +     u32 ccr;
> > > > > +     u32 cndtr;
> > > > > +     u32 cpar;
> > > > > +     u32 cmar;
> > > > > +};
> > > > > +
> > > > > +struct loongson2_cmc_dma_sg_req {
> > > > > +     u32 len;
> > > > > +     struct loongson2_cmc_dma_chan_reg chan_reg;
> > > > > +};
> > > > > +
> > > > > +struct loongson2_cmc_dma_desc {
> > > > > +     struct virt_dma_desc vdesc;
> > > > > +     bool cyclic;
> > > > > +     u32 num_sgs;
> > > > > +     struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_s=
gs);
> > > > > +};
> > > > > +
> > > > > +struct loongson2_cmc_dma_chan {
> > > > > +     struct virt_dma_chan vchan;
> > > > > +     struct dma_slave_config dma_sconfig;
> > > > > +     struct loongson2_cmc_dma_desc *desc;
> > > > > +     u32 id;
> > > > > +     u32 irq;
> > > > > +     u32 next_sg;
> > > > > +     struct loongson2_cmc_dma_chan_reg chan_reg;
> > > > > +};
> > > > > +
> > > > > +struct loongson2_cmc_dma_config {
> > > > > +     u32 max_channels;
> > > > > +     u32 chan_reg_offset;
> > > > > +};
> > > > > +
> > > > > +struct loongson2_cmc_dma_dev {
> > > > > +     struct dma_device ddev;
> > > > > +     struct clk *dma_clk;
> > > > > +     void __iomem *base;
> > > > > +     u32 nr_channels;
> > > > > +     u32 chan_reg_offset;
> > > > > +     struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channe=
ls);
> > > > > +};
> > > > > +
> > > > > +static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_co=
nfig =3D {
> > > > > +     .max_channels =3D 8,
> > > > > +     .chan_reg_offset =3D 0x14,
> > > > > +};
> > > > > +
> > > > > +static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_co=
nfig =3D {
> > > > > +     .max_channels =3D 4,
> > > > > +     .chan_reg_offset =3D 0x18,
> > > > > +};
> > > > > +
> > > > > +static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongs=
on2_cmc_dma_chan *lchan)
> > > > > +{
> > > > > +     return container_of(lchan->vchan.chan.device, struct loongs=
on2_cmc_dma_dev, ddev);
> > > > > +}
> > > > > +
> > > > > +static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_c=
han *chan)
> > > > > +{
> > > > > +     return container_of(chan, struct loongson2_cmc_dma_chan, vc=
han.chan);
> > > > > +}
> > > > > +
> > > > > +static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_=
dma_desc *vdesc)
> > > > > +{
> > > > > +     return container_of(vdesc, struct loongson2_cmc_dma_desc, v=
desc);
> > > > > +}
> > > > > +
> > > > > +static struct device *chan2dev(struct loongson2_cmc_dma_chan *lc=
han)
> > > > > +{
> > > > > +     return &lchan->vchan.chan.dev->device;
> > > > > +}
> > > > > +
> > > > > +static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *=
lddev, u32 reg, u32 id)
> > > > > +{
> > > > > +     return readl(lddev->base + (reg + lddev->chan_reg_offset * =
id));
> > > > > +}
> > > > > +
> > > > > +static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev=
 *lddev, u32 reg, u32 id, u32 val)
> > > > > +{
> > > > > +     writel(val, lddev->base + (reg + lddev->chan_reg_offset * i=
d));
> > > > > +}
> > > > > +
> > > > > +static int loongson2_cmc_dma_get_width(struct loongson2_cmc_dma_=
chan *lchan,
> > > > > +                                    enum dma_slave_buswidth widt=
h)
> > > > > +{
> > > > > +     switch (width) {
> > > > > +     case DMA_SLAVE_BUSWIDTH_1_BYTE:
> > > > > +             return LOONGSON2_CMCDMA_BYTE;
> > > > > +     case DMA_SLAVE_BUSWIDTH_2_BYTES:
> > > > > +             return LOONGSON2_CMCDMA_HALF_WORD;
> > > > > +     case DMA_SLAVE_BUSWIDTH_4_BYTES:
> > > > > +             return LOONGSON2_CMCDMA_WORD;
> > > >
> > > > is ffs() helper in case your hardware support more buswidth in futu=
re?
> > >
> > > It seems there's no need for us to do this.
> > > The data width setting bit in the DMA channel configuration register
> > > only has two bits (LOONGSON2_CMCDMA_CCR_PSIZE_MASK). The bitmask
> > > values are: 8-bit/16-bit/32-bit/reserved.
> >
> > Sorry, I checked again, the ffs() helper can make the code cleaner:
> >
> > static int loongson2_cmc_dma_get_width(enum dma_slave_buswidth width)
> > {
> >         switch (width) {
> >         case DMA_SLAVE_BUSWIDTH_1_BYTE:
> >         case DMA_SLAVE_BUSWIDTH_2_BYTES:
> >         case DMA_SLAVE_BUSWIDTH_4_BYTES:
> >                 return ffs(width) - 1;
> >         default:
> >                 return -EINVAL;
> >         }
> > }
>
> if (width >=3D DMA_SLAVE_BUSWIDTH_4_BYTES)
>         return -EINVAL;
>
> return ffs(width) - 1;

Yes, this looks better.
>
> >
> > And the enum loongson2_cmc_dma_width{ } can be dropped.
> >
> > > >
> > > > > +     default:
> > > > > +             dev_err(chan2dev(lchan), "Dma bus width not support=
ed\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> ...
> > > > > +     if (status & LOONGSON2_CMCDMA_TCI)
> > > > > +             loongson2_cmc_dma_handle_chan_done(lchan);
> > > > > +
> > > > > +     if (status & LOONGSON2_CMCDMA_HTI)
> > > > > +             loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA=
_HTI);
> > > > > +
> > > > > +     if (status & LOONGSON2_CMCDMA_TEI)
> > > > > +             dev_err(chan2dev(lchan), "DMA Transform Error\n");
> > > > > +
> > > > > +     loongson2_cmc_dma_irq_clear(lchan, status);
> > > >
> > > > irq clear should before loongson2_cmc_dma_handle_chan_done() incase=
 you
> > > > missed irq, if loongson2_cmc_dma_handle_chan_done() trigger new irq=
 before
> > > > your call irq_cler().
> >
> > Yes, this part should be refracted, how about the following code:
> >
> >         spin_lock(&lchan->vchan.lock);
> >
> >         ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lch=
an->id);
> >         ists =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_ISR, 0)=
;
> >         status =3D (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_MASKI;
> >
> >         if (status & LOONGSON2_CMCDMA_TCI) {
> >                 loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_TCI=
);
>
> if status is w1c, you can clean it unconditional.

Emm, it can be moved outside.
>
> >                 if (ccr & LOONGSON2_CMCDMA_CCR_TCIE)
>
> Not sure your hardware, generally irq status register will not set if
> enable bit have not set.
>
> >                         loongson2_cmc_dma_handle_chan_done(lchan);
> >                 status &=3D ~LOONGSON2_CMCDMA_TCI;
> >         }
> >
> >         if (status & LOONGSON2_CMCDMA_HTI) {
> >                 loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI=
);
> >                 status &=3D ~LOONGSON2_CMCDMA_HTI;
> >         }
> >
> >         if (status & LOONGSON2_CMCDMA_TEI) {
> >                 loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI=
);
> >                 dev_err(chan2dev(lchan), "DMA Transform Error\n");
> >                 if (!(ccr & LOONGSON2_CMCDMA_CCR_EN))
> >                         dev_err(chan2dev(lchan), "chan disabled by HW\n=
");
> >         }
> >
> >         spin_unlock(&lchan->vchan.lock);
> >
> > > >
> > > > > +
> > > > > +     spin_unlock(&lchan->vchan.lock);
> > > > > +
> > > > > +     return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +static void loongson2_cmc_dma_issue_pending(struct dma_chan *cha=
n)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan=
);
> > > > > +     unsigned long flags;
> > > > > +
> > > > > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > > > > +     if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
> > > > > +             dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lc=
han->vchan);
> > > > > +             loongson2_cmc_dma_start_transfer(lchan);
> > > > > +     }
> > > > > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > > > > +}
> > > > > +
> ...
> > > > > +static struct dma_async_tx_descriptor *
> > > > > +loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct sc=
atterlist *sgl, u32 sg_len,
> > > > > +                             enum dma_transfer_direction directi=
on,
> > > > > +                             unsigned long flags, void *context)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan=
);
> > > > > +     struct loongson2_cmc_dma_desc *desc;
> > > > > +     enum dma_slave_buswidth buswidth;
> > > > > +     struct scatterlist *sg;
> > > > > +     u32 num_items, i;
> > > > > +     int ret;
> > > > > +
> > > > > +     desc =3D kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOW=
AIT);
> > > > > +     if (!desc)
> > > > > +             return NULL;
> > > > > +
> > > > > +     for_each_sg(sgl, sg, sg_len, i) {
> > > > > +             ret =3D loongson2_cmc_dma_set_xfer_param(lchan, dir=
ection, &buswidth, sg_dma_len(sg));
> > > > > +             if (ret)
> > > > > +                     return NULL;
> > > > > +
> > > > > +             desc->sg_req[i].len =3D sg_dma_len(sg);
> > > > > +
> > > > > +             num_items =3D desc->sg_req[i].len / buswidth;
> > > > > +             if (num_items >=3D SZ_64K) {
> > > > > +                     dev_err(chan2dev(lchan), "Number of items n=
ot supported\n");
> > > > > +                     kfree(desc);
> > > > > +                     return NULL;
> > > >
> > > > if use sg_nents_for_dma(), you can use multi sg to trasfer more tha=
n 64K
> > > > data.
> > >
> > > Sorry, are you referring to sg_nents_for_len()?
> > > 64K is a hardware limitation of the controller, so it seems impossibl=
e
> > > to resolve it using that function, right?
>
> you can use multi sg_req to implement it, which max 64K.
>
>         sg_reqp[i + 0] -> 1st 64k
>         sg_reqp[i + 1] -> 2nd 64k
>         ...
>
> Only need allocate more at kzalloc with sg_nents_for_len(), in stead of
> sg_len.

I double-checked, and 64K is actually `max_burst`, which represents
the maximum value for a single transmission. It seems unsuitable for
this purpose.
I should set `dma_device->max_burst` to this value and define it as a
macro: LOONSON2_CMCDMA_MAX_DATA_ITEMS.

>
> Frank
>
>
> > >
> > > >
> > > > > +             }
> > > > > +             desc->sg_req[i].chan_reg.ccr =3D lchan->chan_reg.cc=
r;
> > > > > +             desc->sg_req[i].chan_reg.cpar =3D lchan->chan_reg.c=
par;
> > > > > +             desc->sg_req[i].chan_reg.cmar =3D sg_dma_address(sg=
);
> > > > > +             desc->sg_req[i].chan_reg.cndtr =3D num_items;
> > > > > +     }
> > > > > +
> > > > > +     desc->num_sgs =3D sg_len;
> > > > > +     desc->cyclic =3D false;
> > > > > +
> > > > > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > > > > +}
> > > > > +
> > > > > +static struct dma_async_tx_descriptor *
> > > > > +loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_add=
r_t buf_addr, size_t buf_len,
> > > > > +                               size_t period_len, enum dma_trans=
fer_direction direction,
> > > > > +                               unsigned long flags)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan=
);
> > > > > +     struct loongson2_cmc_dma_desc *desc;
> > > > > +     enum dma_slave_buswidth buswidth;
> > > > > +     u32 num_periods, num_items, i;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (unlikely(buf_len % period_len))
> > > > > +             return NULL;
> > > > > +
> > > > > +     ret =3D loongson2_cmc_dma_set_xfer_param(lchan, direction, =
&buswidth, period_len);
> > > > > +     if (ret)
> > > > > +             return NULL;
> > > > > +
> > > > > +     num_items =3D period_len / buswidth;
> > > > > +     if (num_items >=3D SZ_64K) {
> > > > > +             dev_err(chan2dev(lchan), "Number of items not suppo=
rted\n");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     /* Enable Circular mode */
> > > > > +     if (buf_len =3D=3D period_len)
> > > > > +             lchan->chan_reg.ccr |=3D LOONGSON2_CMCDMA_CCR_CIRC;
> > > > > +
> > > > > +     num_periods =3D buf_len / period_len;
> > > > > +     desc =3D kzalloc(struct_size(desc, sg_req, num_periods), GF=
P_NOWAIT);
> > > > > +     if (!desc)
> > > > > +             return NULL;
> > > > > +
> > > > > +     for (i =3D 0; i < num_periods; i++) {
> > > > > +             desc->sg_req[i].len =3D period_len;
> > > > > +             desc->sg_req[i].chan_reg.ccr =3D lchan->chan_reg.cc=
r;
> > > > > +             desc->sg_req[i].chan_reg.cpar =3D lchan->chan_reg.c=
par;
> > > > > +             desc->sg_req[i].chan_reg.cmar =3D buf_addr;
> > > > > +             desc->sg_req[i].chan_reg.cndtr =3D num_items;
> > > > > +             buf_addr +=3D period_len;
> > > > > +     }
> > > > > +
> > > > > +     desc->num_sgs =3D num_periods;
> > > > > +     desc->cyclic =3D true;
> > > > > +
> > > > > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > > > > +}
> > > > > +
> > > > > +static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cm=
c_dma_chan *lchan,
> > > > > +                                          struct loongson2_cmc_d=
ma_desc *desc, u32 next_sg)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan=
);
> > > > > +     u32 residue, width, ndtr, ccr, i;
> > > > > +
> > > > > +     ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR,=
 lchan->id);
> > > > > +     width =3D FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
> > > > > +
> > > > > +     ndtr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CND=
TR, lchan->id);
> > > > > +     residue =3D ndtr << width;
> > > > > +
> > > > > +     if (lchan->desc->cyclic && next_sg =3D=3D 0)
> > > > > +             return residue;
> > > > > +
> > > > > +     for (i =3D next_sg; i < desc->num_sgs; i++)
> > > > > +             residue +=3D desc->sg_req[i].len;
> > > > > +
> > > > > +     return residue;
> > > > > +}
> > > > > +
> > > > > +static enum dma_status loongson2_cmc_dma_tx_status(struct dma_ch=
an *chan, dma_cookie_t cookie,
> > > > > +                                                struct dma_tx_st=
ate *state)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan=
);
> > > > > +     struct virt_dma_desc *vdesc;
> > > > > +     enum dma_status status;
> > > > > +     unsigned long flags;
> > > > > +
> > > > > +     status =3D dma_cookie_status(chan, cookie, state);
> > > > > +     if (status =3D=3D DMA_COMPLETE || !state)
> > > > > +             return status;
> > > > > +
> > > > > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > > > > +     vdesc =3D vchan_find_desc(&lchan->vchan, cookie);
> > > > > +     if (lchan->desc && cookie =3D=3D lchan->desc->vdesc.tx.cook=
ie)
> > > > > +             state->residue =3D loongson2_cmc_dma_desc_residue(l=
chan, lchan->desc, lchan->next_sg);
> > > > > +     else if (vdesc)
> > > > > +             state->residue =3D loongson2_cmc_dma_desc_residue(l=
chan, to_lmdma_desc(vdesc), 0);
> > > > > +
> > > > > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > > > > +
> > > > > +     return status;
> > > > > +}
> > > > > +
> > > > > +static void loongson2_cmc_dma_free_chan_resources(struct dma_cha=
n *chan)
> > > > > +{
> > > > > +     vchan_free_chan_resources(to_virt_chan(chan));
> > > > > +}
> > > > > +
> > > > > +static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vd=
esc)
> > > > > +{
> > > > > +     kfree(to_lmdma_desc(vdesc));
> > > > > +}
> > > > > +
> > > > > +static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan,=
 void *param)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan=
);
> > > > > +     struct acpi_dma_spec *dma_spec =3D param;
> > > > > +
> > > > > +     memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma=
_chan_reg));
> > > > > +     lchan->chan_reg.ccr =3D dma_spec->chan_id & LOONGSON2_CMCDM=
A_STREAM_MASK;
> > > > > +
> > > > > +     return true;
> > > > > +}
> > > > > +
> > > > > +static int loongson2_cmc_dma_acpi_controller_register(struct loo=
ngson2_cmc_dma_dev *lddev)
> > > > > +{
> > > > > +     struct device *dev =3D lddev->ddev.dev;
> > > > > +     struct acpi_dma_filter_info *info;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (!has_acpi_companion(dev))
> > > > > +             return 0;
> > > > > +
> > > > > +     info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > > > > +     if (!info)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     dma_cap_zero(info->dma_cap);
> > > > > +     info->dma_cap =3D lddev->ddev.cap_mask;
> > > > > +     info->filter_fn =3D loongson2_cmc_dma_acpi_filter;
> > > > > +
> > > > > +     ret =3D devm_acpi_dma_controller_register(dev, acpi_dma_sim=
ple_xlate, info);
> > > > > +     if (ret)
> > > > > +             dev_err(dev, "could not register acpi_dma_controlle=
r\n");
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_pha=
ndle_args *dma_spec,
> > > > > +                                                struct of_dma *o=
fdma)
> > > > > +{
> > > > > +     struct loongson2_cmc_dma_dev *lddev =3D ofdma->of_dma_data;
> > > > > +     struct device *dev =3D lddev->ddev.dev;
> > > > > +     struct loongson2_cmc_dma_chan *lchan;
> > > > > +     struct dma_chan *chan;
> > > > > +
> > > > > +     if (dma_spec->args_count < 2)
> > > > > +             return NULL;
> > > > > +
> > > > > +     if (dma_spec->args[0] >=3D lddev->nr_channels) {
> > > > > +             dev_err(dev, "Invalid channel id\n");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     lchan =3D &lddev->chan[dma_spec->args[0]];
> > > > > +     chan =3D dma_get_slave_channel(&lchan->vchan.chan);
> > > > > +     if (!chan) {
> > > > > +             dev_err(dev, "No more channels available\n");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma=
_chan_reg));
> > > > > +     lchan->chan_reg.ccr =3D dma_spec->args[1] & LOONGSON2_CMCDM=
A_STREAM_MASK;
> > > > > +
> > > > > +     return chan;
> > > > > +}
> > > > > +
> > > > > +static int loongson2_cmc_dma_of_controller_register(struct loong=
son2_cmc_dma_dev *lddev)
> > > > > +{
> > > > > +     struct device *dev =3D lddev->ddev.dev;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (!dev->of_node)
> > > > > +             return 0;
> > > > > +
> > > > > +     ret =3D of_dma_controller_register(dev->of_node, loongson2_=
cmc_dma_of_xlate, lddev);
> > > > > +     if (ret)
> > > > > +             dev_err(dev, "could not register of_dma_controller\=
n");
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static int loongson2_cmc_dma_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     const struct loongson2_cmc_dma_config *config;
> > > > > +     struct loongson2_cmc_dma_chan *lchan;
> > > > > +     struct loongson2_cmc_dma_dev *lddev;
> > > > > +     struct device *dev =3D &pdev->dev;
> > > > > +     struct dma_device *ddev;
> > > > > +     u32 nr_chans, i;
> > > > > +     int ret;
> > > > > +
> > > > > +     config =3D (const struct loongson2_cmc_dma_config *)device_=
get_match_data(dev);
> > > > > +     if (!config)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     ret =3D device_property_read_u32(dev, "dma-channels", &nr_c=
hans);
> > > > > +     if (ret || nr_chans > config->max_channels) {
> > > > > +             dev_err(dev, "missing or invalid dma-channels prope=
rty\n");
> > > > > +             nr_chans =3D config->max_channels;
> > > > > +     }
> > > > > +
> > > > > +     lddev =3D devm_kzalloc(dev, struct_size(lddev, chan, nr_cha=
ns), GFP_KERNEL);
> > > > > +     if (!lddev)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     lddev->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > > > +     if (IS_ERR(lddev->base))
> > > > > +             return PTR_ERR(lddev->base);
> > > > > +
> > > > > +     platform_set_drvdata(pdev, lddev);
> > > > > +     lddev->nr_channels =3D nr_chans;
> > > > > +     lddev->chan_reg_offset =3D config->chan_reg_offset;
> > > > > +
> > > > > +     lddev->dma_clk =3D devm_clk_get_optional_enabled(dev, NULL)=
;
> > > > > +     if (IS_ERR(lddev->dma_clk))
> > > > > +             return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), =
"Failed to get dma clock\n");
> > > > > +
> > > > > +     ddev =3D &lddev->ddev;
> > > > > +     ddev->dev =3D dev;
> > > > > +
> > > > > +     dma_cap_zero(ddev->cap_mask);
> > > > > +     dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > > > > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > > > > +     dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> > > > > +
> > > > > +     ddev->device_free_chan_resources =3D loongson2_cmc_dma_free=
_chan_resources;
> > > > > +     ddev->device_config =3D loongson2_cmc_dma_slave_config;
> > > > > +     ddev->device_prep_slave_sg =3D loongson2_cmc_dma_prep_slave=
_sg;
> > > > > +     ddev->device_prep_dma_cyclic =3D loongson2_cmc_dma_prep_dma=
_cyclic;
> > > > > +     ddev->device_issue_pending =3D loongson2_cmc_dma_issue_pend=
ing;
> > > > > +     ddev->device_synchronize =3D loongson2_cmc_dma_synchronize;
> > > > > +     ddev->device_tx_status =3D loongson2_cmc_dma_tx_status;
> > > > > +     ddev->device_terminate_all =3D loongson2_cmc_dma_terminate_=
all;
> > > > > +
> > > > > +     ddev->src_addr_widths =3D LOONGSON2_CMCDMA_BUSWIDTHS;
> > > > > +     ddev->dst_addr_widths =3D LOONGSON2_CMCDMA_BUSWIDTHS;
> > > > > +     ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_D=
EV);
> > > > > +     INIT_LIST_HEAD(&ddev->channels);
> > > >
> > > > where use this 'channels' ?
> > >
> > > It will be used by global functions such as `dma_async_device_registe=
r()`.
>
> Okay, supposed it sould be done in dma_async_device_register().
>
> Frank
> > > >
> > > > Frank
> > > > > +
> > > > > +     for (i =3D 0; i < nr_chans; i++) {
> > > > > +             lchan =3D &lddev->chan[i];
> > > > > +
> > > > > +             lchan->id =3D i;
> > > > > +             lchan->vchan.desc_free =3D loongson2_cmc_dma_desc_f=
ree;
> > > > > +             vchan_init(&lchan->vchan, ddev);
> > > > > +     }
> > > > > +
> > > > > +     ret =3D dmaenginem_async_device_register(ddev);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     for (i =3D 0; i < nr_chans; i++) {
> > > > > +             lchan =3D &lddev->chan[i];
> > > > > +
> > > > > +             lchan->irq =3D platform_get_irq(pdev, i);
> > > > > +             if (lchan->irq < 0)
> > > > > +                     return lchan->irq;
> > > > > +
> > > > > +             ret =3D devm_request_irq(dev, lchan->irq, loongson2=
_cmc_dma_chan_irq, IRQF_SHARED,
> > > > > +                                    dev_name(chan2dev(lchan)), l=
chan);
> > > > > +             if (ret)
> > > > > +                     return ret;
> > > > > +     }
> > > > > +
> > > > > +     ret =3D loongson2_cmc_dma_acpi_controller_register(lddev);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     return loongson2_cmc_dma_of_controller_register(lddev);
> > > > > +}
> > > > > +
> > > > > +static void loongson2_cmc_dma_remove(struct platform_device *pde=
v)
> > > > > +{
> > > > > +     of_dma_controller_free(pdev->dev.of_node);
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id loongson2_cmc_dma_of_match[] =
=3D {
> > > > > +     { .compatible =3D "loongson,ls2k0300-dma", .data =3D &ls2k0=
300_cmc_dma_config },
> > > > > +     { .compatible =3D "loongson,ls2k3000-dma", .data =3D &ls2k3=
000_cmc_dma_config },
> > > > > +     { /* sentinel */ }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
> > > > > +
> > > > > +static const struct acpi_device_id loongson2_cmc_dma_acpi_match[=
] =3D {
> > > > > +     { "LOON0014", .driver_data =3D (kernel_ulong_t)&ls2k3000_cm=
c_dma_config },
> > > > > +     { /* sentinel */ }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
> > > > > +
> > > > > +static struct platform_driver loongson2_cmc_dma_driver =3D {
> > > > > +     .driver =3D {
> > > > > +             .name =3D "loongson2-apb-cmc-dma",
> > > > > +             .of_match_table =3D loongson2_cmc_dma_of_match,
> > > > > +             .acpi_match_table =3D loongson2_cmc_dma_acpi_match,
> > > > > +     },
> > > > > +     .probe =3D loongson2_cmc_dma_probe,
> > > > > +     .remove =3D loongson2_cmc_dma_remove,
> > > > > +};
> > > > > +module_platform_driver(loongson2_cmc_dma_driver);
> > > > > +
> > > > > +MODULE_DESCRIPTION("Looongson-2 Multi-Channel DMA Controller dri=
ver");
> > > > > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> > > > > +MODULE_LICENSE("GPL");
> > > > > --
> > > > > 2.52.0
> > > > >
> > >
> > > --
> > > Thanks.
> > > Binbin
> >
> > --
> > Thanks.
> > Binbin

--=20
Thanks.
Binbin

