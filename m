Return-Path: <dmaengine+bounces-11044-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG/fF+ZXGmqt3ggAu9opvQ
	(envelope-from <dmaengine+bounces-11044-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 05:22:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B361460B202
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 05:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE24430945F6
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 03:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615F3164A9;
	Sat, 30 May 2026 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/aUzJbZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F4288D0
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110781; cv=none; b=CZOAGly8rO+hniQgjhPo3hHYhBRe3Wvyi8R3vmph2rpjcOqTI6nY/DFR/mWLKyTuQulV9fbJlPpP/RO+j6AHPEbUfV5F0nHz/vFe9B63vFUJS4CIUi4Pzb0g7Y9EasRSy0oASZZRpMTGP7YB9nCVof8ZuM8vKyNpHWh2OQaFeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110781; c=relaxed/simple;
	bh=0uCvjvjua2Ie2LNjHaJ+8JsOR8BD3Dcdqd0aat3vDFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hyVSoJTzeOb8qEpXsXzZRhVqyPe6SjOjgO82nN1BCM36DboR7uNdCMJh5wLLRNlUjz+h+Wb2e3PvxHT0fj0K4NiXx/0l5tFzsj+jteH8owVh5072zb7jdQE57zYcuvKZ5th2ww0dIOBRZdfucxIdVuQgMKUQRx/Lh52H0wPsxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/aUzJbZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A630B1F00893;
	Sat, 30 May 2026 03:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780110779;
	bh=lxBkCW30pMpwgr0mLxC0lXM7iluJbu+nrXT11/683DQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/aUzJbZ9o2ERblJyNkNE5dP/GfdCYSTa4HNp9+rv7bc8c3W3kcAgR8nk3hEt75gh
	 cJITFHQ6RdpClOf5iMgc7G053H1pN4ODNIkhLPvl9dinLmuf8TYtu8gVLkJJILTWHL
	 wxWiIbLPG7GO9YRrX5EeGwTLq4CA6SuVwpoHb5hxQXSUaI4AkaPocB3YUGx/mRjXTw
	 /n7Js/eENHc0HDHDMQNHsROSr6nL+0YRCZC6R/7zPicS4gXrr5+SOXz6+C5cNQ0Ts9
	 dGgSSPqb4GxoGJSu9XHCM1/ZH3J3nZCpKSXDVYfo52gaNyqXwfraWOvogHqleea2dI
	 eHXPhhhFyCwBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bestcomm/gen_bd: fix out-of-bounds access in PSC
 parameter lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260530030152.49759-1-rosenp@gmail.com>
References: <20260530030152.49759-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 03:12:59 +0000
Message-Id: <20260530031259.A630B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11044-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: B361460B202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked array access in `mpc512x_psc_alloc_clock` and relate=
d clock functions where `psc_num` derived from device tree is used to index=
 arrays, causing out-of-bounds reads and writes.
--

commit 7a3c433b5cd814a1fd0d2b57113cd41cb03279a5
Author: Rosen Penev <rosenp@gmail.com>

bestcomm/gen_bd: fix out-of-bounds access in PSC parameter lookup

This commit fixes an out-of-bounds access issue in bcom_psc_gen_bd_rx_init()
and bcom_psc_gen_bd_tx_init() by properly using ARRAY_SIZE() for bounds
checking on psc_num. It also removes an unused forward declaration in
bcom_psc_gen_bd_tx_init().

> diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
> index 8a24a5cbc2633..75d1a6f543df9 100644
> --- a/drivers/dma/bestcomm/gen_bd.c
> +++ b/drivers/dma/bestcomm/gen_bd.c
> @@ -315,7 +315,7 @@ static struct bcom_psc_params {
>  struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int queue_l=
en,
>  					   phys_addr_t fifo, int maxbufsize)
>  {
> -	if (psc_num >=3D MPC52xx_PSC_MAXNUM)
> +	if (psc_num >=3D ARRAY_SIZE(bcom_psc_params))

[Severity: Critical]
This is a pre-existing issue, but while looking at this fix for the psc_num
bounds checking, I noticed a similar unchecked array access regression vect=
or
using psc_num in drivers/tty/serial/mpc52xx_uart.c.

In mpc512x_psc_alloc_clock(), psc_num is calculated directly from
port->mapbase:

drivers/tty/serial/mpc52xx_uart.c:mpc512x_psc_alloc_clock() {
	...
	psc_num =3D (port->mapbase & 0xf00) >> 8;
	...
	psc_mclk_clk[psc_num] =3D clk;
	...
}

Because port->mapbase comes from the device tree via
of_address_to_resource(), a malformed device tree could supply an address
like 0x11F00, allowing psc_num to evaluate up to 15.

Since psc_mclk_clk and psc_ipg_clk are arrays sized to MPC52xx_PSC_MAXNUM
(which is 12 when CONFIG_PPC_MPC512x is defined), wouldn't this allow an
out-of-bounds write of a pointer to the BSS section?

The exact same unchecked psc_num calculation also appears in
mpc512x_psc_relse_clock() and mpc512x_psc_endis_clock(), leading to similar
out-of-bounds reads and writes.

>  		return NULL;
> =20
>  	return bcom_gen_bd_rx_init(queue_len, fifo,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530030152.4975=
9-1-rosenp@gmail.com?part=3D1

