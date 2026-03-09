Return-Path: <dmaengine+bounces-9328-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCWHAIRyrmkCEgIAu9opvQ
	(envelope-from <dmaengine+bounces-9328-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:11:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC4234AC0
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A493011F29
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF7364024;
	Mon,  9 Mar 2026 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9xDRAyW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7D364020;
	Mon,  9 Mar 2026 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040235; cv=none; b=VyNNnxrEaE/DNVPEWyrmj4agcieRit7EmT4oQ/7tvEE0CRIGSOIk5dxUWaObzzIWgWUf3FZiKU3+WCsGW7HqKTf90zTvBwpjhdszgg2VhXbng9j/2DrOytW93TbpbV8dmI1QbJhqnIQjJBkMvju8quSuEhwgjvz/5hgevgLSTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040235; c=relaxed/simple;
	bh=Hse7aJxnrvlDuoRFVnc1ppocatR7quPw2ymU8XbhW8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ2QXivfx6foc7bZIWuRenXEHh+k7h+5WOE7DyqdW9RXjfH4cjiqgI1slbOSwpGxIGbmm0eoYkQfgUCkoqLkDxXqkWNex4g6S9zvNJb2o/eGP2A//a4GFXIywT5GC/2f8/xE9G1xv+0FhsBJEjPfSRLdAMWxx2IkV4c5u9/k9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9xDRAyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B91C4CEF7;
	Mon,  9 Mar 2026 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773040235;
	bh=Hse7aJxnrvlDuoRFVnc1ppocatR7quPw2ymU8XbhW8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9xDRAyWjt7dQPU36zhBt5GSaad0XjfaONFk2ujpGDkR/wM8be5/pq9G1ZHYCtU/k
	 Eh1pjnA9XsZChuV0Y2LZjowNxfI1ZLU9U7deOHkg4PhhhwTMKDxHLC4TLRc95A7Sx9
	 ic8+SklyJwXv32i+E7i9w1/pRH5cwTTEwYUSinirNgrroXvBIUboi5nyXMqSy5Kwrm
	 j4LpAQA/vD/4lRkre++ACWF/fAgANqfU3Yv15+vF4h28al5ClBUAE54vScOUgqIr9u
	 64xV8RZeU6Jn0QiXYwCMLP9FkRasXj5DnLJdNlzJTabU5bBc8qtvJ9dwOOjDTsEkbE
	 2JFylOsRJC6yw==
Date: Mon, 9 Mar 2026 08:10:31 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
Message-ID: <aa5yZ6xSW8yxm9gI@vaman>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
 <408551399f089d10e2ebc2c0add5ba58d659a1b9.1771989596.git.zhoubinbin@loongson.cn>
 <CAAhV-H6G6Zb7P8OpoM78FkfSW2HeLt+9xfbJyU21tdbUa8A=Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6G6Zb7P8OpoM78FkfSW2HeLt+9xfbJyU21tdbUa8A=Ww@mail.gmail.com>
X-Rspamd-Queue-Id: 6DEC4234AC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9328-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[loongson.cn,gmail.com,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 26-02-26, 16:18, Huacai Chen wrote:
> Hi, Binbin,
> 
> On Wed, Feb 25, 2026 at 3:41 PM Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
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
> >  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 729 +++++++++++++++++++
> >  4 files changed, 741 insertions(+)
> >  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aea29c28d865..af9fbb3b43e2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14954,6 +14954,7 @@ L:      dmaengine@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> >  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > +F:     drivers/dma/loongson/loongson2-apb-cmc-dma.c
> >  F:     drivers/dma/loongson/loongson2-apb-dma.c
> >
> >  LOONGSON LS2X I2C DRIVER
> > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> > index 9dbdaef5a59f..4278fbbe8096 100644
> > --- a/drivers/dma/loongson/Kconfig
> > +++ b/drivers/dma/loongson/Kconfig
> > @@ -12,6 +12,16 @@ config LOONGSON1_APB_DMA
> >           This selects support for the APB DMA controller in Loongson1 SoCs,
> >           which is required by Loongson1 NAND and audio support.
> >
> > +config LOONGSON2_APB_CMC_DMA
> > +       tristate "Loongson2 Chain Multi-Channel DMA support"
> > +       select DMA_ENGINE
> > +       select DMA_VIRTUAL_CHANNELS
> > +       help
> > +         Support for the Loongson Chain Multi-Channel DMA controller driver.
> > +         It is discovered on the Loongson-2K chip (Loongson-2K0300/Loongson-2K3000),
> > +         which has 4/8 channels internally, enabling bidirectional data transfer
> > +         between devices and memory.
> Moving this to after LOONGSON2_APB_DMA is a little better.

Yes and we expect these files to be sorted, so this needs to be done

-- 
~Vinod

