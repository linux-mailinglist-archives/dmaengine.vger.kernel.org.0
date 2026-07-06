Return-Path: <dmaengine+bounces-12061-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wn1SD0IsTGoFhQEAu9opvQ
	(envelope-from <dmaengine+bounces-12061-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 00:29:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9AC715F38
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 00:29:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G1CpuDRr;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12061-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12061-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10A14300D1EB
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE1A3FE369;
	Mon,  6 Jul 2026 22:29:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E225782D;
	Mon,  6 Jul 2026 22:29:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376957; cv=none; b=RHi5K2LOyd/hqnbdyvguPs1l9Ay6JEicP9IEPh666TLEfilDNpE4jxDQkwEPW/vZKiKRiDxnLIXRCtKgcGa/KR8azT8amh81zjrTGnC7zyFJN9zHm7IKo9Gy57Z90vPn7VSYjOXTEGpGAFEbxxTQiq+lJYjtEb469Fg60S1GwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376957; c=relaxed/simple;
	bh=RNYHsdS28HPuySSWvP1Yyr5i9l6ITmxkysSASJfZwD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUzMG0++WkJG1I4oyJdaL8JTw3bUVkVskn5ysR4Ha55KEKZJ02W3K68XA5+1D31D6Rsdxs3hZJWpFj/V8U4vPF/+piYVPcA+i5caLdMTGqtGaqv/9IqOZcjVyP98uXpizqzesBJ/cvRIG5ac7PSTKWLy14W8lIX0PRM4KGHm7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1CpuDRr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CBD1F000E9;
	Mon,  6 Jul 2026 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783376955;
	bh=NIKhsdKujmUyo5f1I8e0key9LsLGYc70ehoq2AKl2uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1CpuDRrdmcEC3wEPp2EVGqS3HOURCh2yKP14x2Er3LIpE0Tkc0mbAgDMaBJN5W0X
	 181F/jwiOAN1KUKl7d8Tt9eqaXftQp+0szy8NqHpE4ZGAN+l6ygxC6pQRp6QD4Qi9b
	 PD+cjXv5G0p1b4RhnU3thcwBP/tAEKulVNe+MkjBA+OskiUYP4gz5Af3sxvILh5i9y
	 NSaJwEybJx+Cmcj73mmLNBb+CZKxXIwmgW3FpsZ9uRWTaj3E2yosi1DEV/TEJrrTx1
	 sRsIQcEh/TffxG3kOyZY+Vh0qjdF+17MokOULQIjZKL+OkpTJomQieKfasUeuzHmUS
	 qgxzLhRCrca0A==
Date: Mon, 6 Jul 2026 22:29:13 +0000
From: Yixun Lan <dlan@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v4] riscv: dts: spacemit: Use symbolic PDMA request
 numbers on K1
Message-ID: <20260706222913-GKD35811@kernel.org>
References: <20260620-b4-k1-pdma-req-macros-v4-1-3cf77d0bd0d6@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260620-b4-k1-pdma-req-macros-v4-1-3cf77d0bd0d6@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12061-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:docular.xu@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:docularxu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dlan@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,spacemit.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD9AC715F38

On 01:07 Sat 20 Jun     , Guodong Xu wrote:
> The PDMA request numbers (DRQ) are fixed values specific to the SoC from
> a hardware perspective. The detailed definition can be found in K1 User
> Manual [1], Chapter 9.4.3 DMA Connectivity & Assignments. Add a DTS
> header file to define the symbolic names for the DRQs of non-secure DMA
> peripherals.
> 
> Convert the K1 SPI3 node to these macros.
> 
> Link: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md [1]
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
Thanks

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)

