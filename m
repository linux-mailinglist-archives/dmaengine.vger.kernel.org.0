Return-Path: <dmaengine+bounces-9349-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ip0JRrMrmkDJAIAu9opvQ
	(envelope-from <dmaengine+bounces-9349-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 14:33:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880E239CC7
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A66DF301F6A6
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65A35C19B;
	Mon,  9 Mar 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4wL+B0K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3D259CAF
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063183; cv=none; b=CNQ6Alv+qokyECQ7+XER25CQURZjD9IHTLVkc0o8eKemMzoLSktm4Lhi4t2T1FvoRp/SYJevqb5CGvrLtGygeE6ZGvJi9HUrzZD3SJR4zSReQKq6z3rj9oxK3NUlBc6pfO/hfAJmXkcCrCN35bBC71HlUM3qR4Jiu5YecZww9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063183; c=relaxed/simple;
	bh=BTHtEpNf79/aZLsd9vWZFWEtV159n9Y/T5kPu0xKjDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LykoaBR7XWDF2OzgxXcE9pW+fayfgvTACHroiShLXZZ3aGw4uzFytOvh2iptDML8ndI1r/OciG9OGtrXYqRqpxHkMVCOL5f8QGmjbeVWbxjx1PuYaeiIY91w2iNg0SLj68KnVb926PIp1LSw9ArPGGi++UUb4+AnHQV+xHjYhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4wL+B0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD16C2BCB6
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773063183;
	bh=BTHtEpNf79/aZLsd9vWZFWEtV159n9Y/T5kPu0xKjDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4wL+B0KN0+mkKl6jlrce5TKebjg3Y43ayQb2agA8rlsxB2L5KrJbPRM4lffmOYVv
	 WeoCbphnvAiSn14vJApR0DkykhCZi84KdCPucmK3ODu0eGjLqok6PdyDHKytnwBgBj
	 CbNU5aXCnZQXzrMjw6j+NcNqh0foBwzW4aeI7pggoVoZ8ohWLocNPApwbUoMo85MFY
	 oGTTo7w0CXdRGL0nRVVZAoudiPxXEXUTap9s9O4ghOFb505d8XzBb/FUXUrxweC0Z3
	 PaYzMaRcgmkoxPVWNRrh+XRwyJqxfXrInguSTibxttrVEWJpgfwnDvqzFQAaapkrWb
	 n3DnV8F/mtSjQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660d2e48383so188487a12.1
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 06:33:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbHyAVtNtqm+CGKLx4QvHnM99x5ttAUE7ETkrepNdJ9xa4w0mo1jr6UgobFEzRej8dxiq9LZN7FFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yIdYM32LnMdR8a1lP3U7otQp13whrRPqoCb6ftdcDb1YmVce
	Xgkj3dOEHTlZ5d4H2/f/VnDvBDNbbAVL6e9MrOnt9eUO6ehm2tOMKuBKdby5aJYoSt0vFIDYWzA
	IlescJdmpbxLKpPeOpu/VQDs9S2wfF/Y=
X-Received: by 2002:a05:6402:42d1:b0:661:3804:b0c2 with SMTP id
 4fb4d7f45d1cf-6619d51d6admr5919005a12.27.1773063181991; Mon, 09 Mar 2026
 06:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772853681.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1772853681.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 9 Mar 2026 21:32:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H65H5WjRarf8KHN3zb1jSyFpGPS1By2=0Kqd1MqnVx9ow@mail.gmail.com>
X-Gm-Features: AaiRm53ShuE-RRVpgsb6NRxueHra0ZOJThCsn08_hzoyeP4saxxF_8G4DDjsnCc
Message-ID: <CAAhV-H65H5WjRarf8KHN3zb1jSyFpGPS1By2=0Kqd1MqnVx9ow@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] dmaengine: Add Loongson Multi-Channel DMA
 controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7880E239CC7
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
	TAGGED_FROM(0.00)[bounces-9349-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,loongson.cn:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 11:25=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> This patchset introduces the Loongson multi-channel DMA controller,
> which is present in the Loongson-2K0300 and Loongson-2K3000 processors.
>
> It is a multi-channel controller that enables data transfers from memory
> to memory, device to memory, and memory to device, as well as channel
> prioritization configurable through the channel configuration registers.
>
> Additionally, since multiple distinct types of DMA controllers exist on
> the Loongson platform, I have attempted to consolidate all Loongson DMA
> drivers into a new directory named `Loongson` for easier management.
For the whole series,
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Thanks.
> Binbin
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> V4:
> - Rebase on dmaengine/next tree;
> - Add Reviewed-by tags from Frank and Rob, thanks;
>
> patch(1/6):
>  - Add `depends on` restrictions.
>
> patch(6/6):
>  - Move loongson2_cmc_dma_config{..} close to its users.
>
> Link to V3:
> https://lore.kernel.org/dmaengine/cover.1771989595.git.zhoubinbin@loongso=
n.cn/
>
> V3:
> - Rebase on dmaengine/next tree;
>
> patch(1/6):
>  - Keep alphabet order;
>
> patch(2/6):
>  - Add Reviewed-by tag from Frank, thanks;
>
> patch(3/6)/(4/6):
>  - New patches, format loongson2-apb-dma driver code;
>
> patch(5/6):
>  - Add description for `interrupts` property;
>
> patch(6/6):
>  - Use ffs() helper make the code cleaner;
>  - Refact loongson2_cmc_dma_chan_irq();
>  - Simplify locking with guard() and scoped_guard();
>  - kzalloc()->kzalloc_flex().
>
> Link to V2:
> https://lore.kernel.org/all/cover.1770605931.git.zhoubinbin@loongson.cn/
>
> V2:
> patch(1/4):
>  - Update loongson1-apb-dma.c entry in MAINTAINERS.
>
> patch(2/4):
>  - New patch, use dmaenginem_async_device_register() helper.
>
> patch(3/4):
>  - `additionalProperties: false` replaced by
>    `unevaluatedProperties: false`.
>
> patch(4/4):
>  - Rename filename as loongson2-apb-cmc-dma.c;
>  - Rename Kconfig item as LOONGSON2_APB_CMC_DMA;
>  - Rename the variable prefix as `loongson2_cmc_dma`;
>  - Use dmaenginem_async_device_register() helper;
>  - Drop 'dma_' prefix in struct loongson2_mdma_chan_reg;
>  - Use struct_size();
>
> Link to V1:
> https://lore.kernel.org/all/cover.1770119693.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (6):
>   dmaengine: loongson: New directory for Loongson DMA controllers
>     drivers
>   dmaengine: loongson: loongson2-apb: Convert to
>     dmaenginem_async_device_register()
>   dmaengine: loongson: loongson2-apb: Convert to devm_clk_get_enabled()
>   dmaengine: loongson: loongson2-apb: Simplify locking with guard() and
>     scoped_guard()
>   dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
>   dmaengine: loongson: New driver for the Loongson Multi-Channel DMA
>     controller
>
>  .../bindings/dma/loongson,ls2k0300-dma.yaml   |  81 ++
>  MAINTAINERS                                   |   7 +-
>  drivers/dma/Kconfig                           |  25 +-
>  drivers/dma/Makefile                          |   3 +-
>  drivers/dma/loongson/Kconfig                  |  41 +
>  drivers/dma/loongson/Makefile                 |   4 +
>  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |   4 +-
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c  | 730 ++++++++++++++++++
>  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  93 +--
>  9 files changed, 903 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k03=
00-dma.yaml
>  create mode 100644 drivers/dma/loongson/Kconfig
>  create mode 100644 drivers/dma/loongson/Makefile
>  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)
>  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
>  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (91%)
>
>
> base-commit: c8e9b1d9febc83ee94944695a07cfd40a1b29743
> --
> 2.52.0
>

