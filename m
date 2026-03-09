Return-Path: <dmaengine+bounces-9340-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGbwL4SArmlfFQIAu9opvQ
	(envelope-from <dmaengine+bounces-9340-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 09:10:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4523558E
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ADCA303321D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F2364924;
	Mon,  9 Mar 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAx4Hi9R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D56230BEC
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043518; cv=pass; b=RwJlzAZHrotZs93k5Csw/bsrVfyzxZ1mfMApep56LDenObG4oPEg9WgKvcmnLPgZ5lWkVZPN6P+t1XMus6QTa7Utk0qiN1sT1agXqoGEOtlm0xFM/OVHRCAs3TpoqKh87jRPGtdZ3Xm0xzKI0BhwHDLThnRsBSxQI1Xb03DC//g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043518; c=relaxed/simple;
	bh=9rRUzy7I4Yn9TKSxdiDUjmYRtwSYsMyZ7fp/5IbO/q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AteJVxq50UzgW8ny4OFfVZqRNh2YvjSTPRfqr6fU/oOD72QDA43OYfC1B8B+EclqBw1/nSdX1uVPmT9Za3k9u/EHxnqz7e8a4T1lVc8cfLFRkAaSmU74mqFKl0tHO78fUGsHtM9kRVFfWNIBlTdgv+NoDz8gF13uIx8EMHC6nGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAx4Hi9R; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1922309766b.2
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 01:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773043516; cv=none;
        d=google.com; s=arc-20240605;
        b=DmETopB177e/9gDHGgr98GaC70216qrxSqDvQhzZc3lk64F+es6VjeVyv0JbiyKeDm
         uuwjr2N0Dei1HY/r3SrZbf2MtUXbkM+Vn4Fq4wHiWkBrxGx2iL2ZHPSQe44sqTN9IYKa
         Cia5UvqFBC09ZDdCzplLUT1TyJSGu4uz1Hw2/yPntC1jNjxlppBNQ72qnYaOiIXt+WyS
         O3gSBwvK2KgiYmHpXw7JPoIgJ1UZD4nrbgVfkdAYbyThRsbKzzX60oi1aQFF8vxV7YBX
         PjlW09+KXNVW3CaFYnxZEpdmtDdhCutRqedx2ukJzdGecHtbWb1JkjTuqXBo7uCVfC/n
         GIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fRzvHdv5ruH/JD72yB5V1Ivp7J4AaqZR7aIdb2pmk7E=;
        fh=HK8ZlYy5w1F+H4h1AuCD6A0Mv/c0LDif2efgDlQjBdw=;
        b=NR78yNRgRBKhkoHFoBr/P3CDjtu5zdxTlXQ8Ld/w2jNol3uv+fFW1/ebUUWDY9Y0p4
         RQaksNq7WC2BB7VM3xlfCispdM7aqzmXuUntvHpcVJHEB9Yl60egX66XbWZKdG9NIVo8
         mKT08zUlXT6BTpQ8YJOvrzYOg+bCUtaTGzPYGNOVIkTgshrbuH0Vl0VDVXWDE2lUqKcM
         cVQJI3PYTzQmJYZ7zf9gERUAjg/HfaVwojxWQJDP1/rxsHNHJs5QLjUcANiFQtBtPC7w
         P+23EqriVEIiw61GjP21sN6EiiXanEX/CC13GeNm4B0ADjFRsIDk35v5xMx8ObZk/QXS
         eDWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043516; x=1773648316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRzvHdv5ruH/JD72yB5V1Ivp7J4AaqZR7aIdb2pmk7E=;
        b=MAx4Hi9RxMreRTgf25Ojtq5AG7m7gIV/tqxFeHXNpVdUzSLUev3oGKpJm8MkCdeBWd
         V6WraHNYY9IpCCte7d0KmJk4Rw6ZHPuTvXIrwpaF80CXe0kRICihs95nddO+blWdaKho
         FLshdXU6RJwto4UOW43mY0o0KYdk7qaO9Yb+DVuEleX8WrSn9UnAkXN6WYsQFsBZ+VSS
         eHEprYT9E33a89JZKF6F00lq1j63VN2AOIMTYBWdkrOcybsGFKIh6Bc3fUOUcHdeX0h0
         HTLkRf3/EMN/3s9Ybb/zlhf3yoY1Qng4nhdzun0q7XJvAhhlvGwE9ZCHO6KOQ1LM0WOz
         4kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043516; x=1773648316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fRzvHdv5ruH/JD72yB5V1Ivp7J4AaqZR7aIdb2pmk7E=;
        b=CUd15vKUwsbW95Ap9j0nBXyTE5cNNswxhVPbLuUGpxX5nuQVupVyb6Sh8O+rwh/2Cc
         e5O2rzjlpEd8ZiW/eWRuYWkjK7KBNJ0e76ocVNSILlrmrn47ng0IXkAREOHQUyewYd9N
         gFcajkDyIem9/HcOD92qg5nnHU2AoK1WX5eVGi1By4qB6zKp7rJseD0wEVMe/j2iq6iE
         J3QsKL2RGdbM/T+7L+Hl9nWVlhsJo9PAn8f5o7SLr73HMooP2VLTXA8ApJiwfQW4/QuN
         kbQXC7XlS+MfizmIRQtmFAF5Z1FDDA+4DXiitfVSpLALcV7aVHPAZ/2a15/M8xferFMk
         g+DA==
X-Forwarded-Encrypted: i=1; AJvYcCUVOCnRn8SLv/gsI9m2aIJ72zKevHI9gpi/pUN3D/ycE6oZATqti1N6+h67uFHVreaEF4b6QvHpfEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNwN22tWstjQnppFYv57QK8dG6bF6CoiNXU28rxlWALX89E+Q
	rjiiDePliaw+BEEQpj42KJVR3pK9ud/CqyLR2m9Zo4eJWo4GZrE8fA88KLq+o4IXt2pwsKVRJ53
	ZAJ03URqY8rNoj7soNV6BLgGJebJ4LnAcM33a
X-Gm-Gg: ATEYQzx6BVoqG+TK6xuuzlG0vfMb+9zEfpuJTKuevCmYox/Jb849XbBQuN3GdlPTt1v
	eP5n487i6X1s113iJKtmH0jhgXSbxs+3KW/w5CphnxOLJqEwMbgW5SYKuzHZd0jmdLBcQfysCMK
	1BGacc2aUrRYGEarjd2t2ztqU8e9KOYIrm348Lcu/sZ3HXQ68okIlmAm4eQSCaYOjh7FuuBJA3h
	QvwEY5tzv9CKn5zaQfEGOtOLUf1fhbQk3ljukDNR9UGZA5WOCKWoQg18IZtkMxxk3OtYoFBCb+K
	KU2Z4JA=
X-Received: by 2002:a17:906:c14c:b0:b88:dc6:3967 with SMTP id
 a640c23a62f3a-b942e026133mr560704766b.40.1773043515456; Mon, 09 Mar 2026
 01:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771989595.git.zhoubinbin@loongson.cn> <408551399f089d10e2ebc2c0add5ba58d659a1b9.1771989596.git.zhoubinbin@loongson.cn>
 <CAAhV-H6G6Zb7P8OpoM78FkfSW2HeLt+9xfbJyU21tdbUa8A=Ww@mail.gmail.com> <aa5yZ6xSW8yxm9gI@vaman>
In-Reply-To: <aa5yZ6xSW8yxm9gI@vaman>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 9 Mar 2026 16:05:03 +0800
X-Gm-Features: AaiRm5294yKy8lbGyQ7Hmx4k6HbI1oWu6Wm6ACsqemZt6_dIw21pirDFEH1wTc4
Message-ID: <CAMpQs4JX0jZuLk84QnW79cVrjA-Fs6oDx8Uq_cyTVLTaE3F8vg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
To: Vinod Koul <vkoul@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	dmaengine@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>, 
	linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3AF4523558E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9340-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,loongson.cn,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,loongson.cn:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:10=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 26-02-26, 16:18, Huacai Chen wrote:
> > Hi, Binbin,
> >
> > On Wed, Feb 25, 2026 at 3:41=E2=80=AFPM Binbin Zhou <zhoubinbin@loongso=
n.cn> wrote:
> > >
> > > This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
> > >
> > > It is a chain multi-channel controller that enables data transfers fr=
om
> > > memory to memory, device to memory, and memory to device, as well as
> > > channel prioritization configurable through the channel configuration
> > > registers.
> > >
> > > In addition, there are slight differences between Loongson-2K0300 and
> > > Loongson-2K3000, such as channel register offsets and the number of
> > > channels.
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  MAINTAINERS                                  |   1 +
> > >  drivers/dma/loongson/Kconfig                 |  10 +
> > >  drivers/dma/loongson/Makefile                |   1 +
> > >  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 729 +++++++++++++++++=
++
> > >  4 files changed, 741 insertions(+)
> > >  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index aea29c28d865..af9fbb3b43e2 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14954,6 +14954,7 @@ L:      dmaengine@vger.kernel.org
> > >  S:     Maintained
> > >  F:     Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.y=
aml
> > >  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.ya=
ml
> > > +F:     drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > >  F:     drivers/dma/loongson/loongson2-apb-dma.c
> > >
> > >  LOONGSON LS2X I2C DRIVER
> > > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kcon=
fig
> > > index 9dbdaef5a59f..4278fbbe8096 100644
> > > --- a/drivers/dma/loongson/Kconfig
> > > +++ b/drivers/dma/loongson/Kconfig
> > > @@ -12,6 +12,16 @@ config LOONGSON1_APB_DMA
> > >           This selects support for the APB DMA controller in Loongson=
1 SoCs,
> > >           which is required by Loongson1 NAND and audio support.
> > >
> > > +config LOONGSON2_APB_CMC_DMA
> > > +       tristate "Loongson2 Chain Multi-Channel DMA support"
> > > +       select DMA_ENGINE
> > > +       select DMA_VIRTUAL_CHANNELS
> > > +       help
> > > +         Support for the Loongson Chain Multi-Channel DMA controller=
 driver.
> > > +         It is discovered on the Loongson-2K chip (Loongson-2K0300/L=
oongson-2K3000),
> > > +         which has 4/8 channels internally, enabling bidirectional d=
ata transfer
> > > +         between devices and memory.
> > Moving this to after LOONGSON2_APB_DMA is a little better.
>
> Yes and we expect these files to be sorted, so this needs to be done

This is reorder on the latest patchset:

https://lore.kernel.org/all/cover.1772853681.git.zhoubinbin@loongson.cn/
>
> --
> ~Vinod

--=20
Thanks.
Binbin

