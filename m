Return-Path: <dmaengine+bounces-10966-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF99LPwFFmr/gwcAu9opvQ
	(envelope-from <dmaengine+bounces-10966-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:43:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E955DC6DF
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 057493007ACC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1E3537FB;
	Tue, 26 May 2026 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0CM0hGo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646893AE190
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828099; cv=none; b=act0mnlfLcEE+VECBIeUMGnqm076U34QdDbVcninAKcDWRLnqGXSEGvloizaDmJTZg1K5JlPj4LcABlkA9f3Zk2ClOobL0w+p1WcWjvdCBMnWuYygJpgIVDzjwl7m5jyP7EUW4Fycp582fKWUTu8v2OqOgOw1yNTCLcI41sUf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828099; c=relaxed/simple;
	bh=YzYFShYYIIMoNQUVEGshtTHKCnnvQMaYiPm3FWYIha8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQx5eGTlK0DqUwVoNANeiILz6k6pw+g2/rpFecmUDQytdCDHM50C4jv5jFcYAQCNOi9khoehmzc/eG+qukdHiKz9DrzJreNitJRpar1tAHGvG69wAd19ys4MMLxM6+zhXBELhUQ6OCL3YdGvr+sk8YWkcfe/AzlPbuylMV+hBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0CM0hGo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3BE1F000E9;
	Tue, 26 May 2026 20:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779828098;
	bh=uUVLsxBoEsJ+9B3Wk3igbOuhIX6/jUvUCFobrjO6Rl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0CM0hGoC5JRd/s5OHbLItExW1QDCZ1GOAbVQVpbK3LY/uBr8ILLoPnXU4oA4R/T4
	 C7ABDKwd2KQ1wgIM8RkRkO13/NOe3sdL/dOZK9Kea72vgsdIWuE1lr54kSSEhjr4vN
	 /m6thfkrSkby17ZzR1eb0AVSFABNdTCtyyLpKX/nX3WFFAhlDmniOt/VElpYIszRNm
	 EotvFRiX4g5pH8e9lL+YV9wK445E1demtJZaP4uzyAKVtYYXRJQHeq2HCWSwlkgtV7
	 w79AWLD8DUkVVR7WK0JbhF4RTqVundwi3cknbwDgv2M076KpwpPI01MFaN9fTaP50e
	 FbnSLiTsohr8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526201552.13376-1-rosenp@gmail.com>
References: <20260526201552.13376-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 20:41:37 +0000
Message-Id: <20260526204137.CE3BE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10966-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 13E955DC6DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Adding directly to the saturated result of `struct_size()` bypasse=
s integer overflow protection.

Pre-existing issues:
- [High] Missing `free_irq()` on the error path in `d40_probe()` leads to a=
 resource leak and use-after-free.
--

commit 4d4cd912af1facbb011b5847b403605ba43b7f48
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array

Convert the separately-offset phy_chans pointer to a C99 flexible array
member at the end of struct d40_base, and switch the allocation to
struct_size().

> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9b803c0aec254..d3e3c4cd43f17 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c

[ ... ]

> @@ -3197,10 +3198,9 @@ static int __init d40_hw_detect_init(struct platfo=
rm_device *pdev,
>  		 "hardware rev: %d with %d physical and %d logical channels\n",
>  		 rev, num_phy_chans, num_log_chans);
> =20
> -	base =3D devm_kzalloc(dev,
> -		ALIGN(sizeof(struct d40_base), 4) +
> -		(num_phy_chans + num_log_chans + num_memcpy_chans) *
> -		sizeof(struct d40_chan), GFP_KERNEL);
> +	alloc_size =3D struct_size(base, phy_chans, num_phy_chans);
> +	alloc_size +=3D sizeof(*base->log_chans) * (num_log_chans + num_memcpy_=
chans);

[Severity: High]
Can this unprotected addition bypass the integer overflow protection provid=
ed
by struct_size()?

If struct_size() saturates and returns SIZE_MAX, the subsequent addition
will wrap around to a small value. This could allow devm_kzalloc() to
successfully allocate an undersized buffer, which might result in a heap
buffer overflow when the channel arrays are written out of bounds. The
manual multiplication also appears to lack overflow protection.

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential resource leak and
use-after-free in d40_probe().

If the probe function fails after requesting the interrupt (for example,
during regulator_get() or d40_dmaengine_init()) and jumps to the
destroy_cache label, it appears to return an error without freeing the
requested interrupt.

Because the base structure is automatically freed by the devres framework
upon probe failure, if an interrupt triggers subsequently, could the
interrupt handler d40_handle_interrupt() execute and access the freed
base structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526201552.1337=
6-1-rosenp@gmail.com?part=3D1

