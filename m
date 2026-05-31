Return-Path: <dmaengine+bounces-11076-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u024ALOnHGpvRAkAu9opvQ
	(envelope-from <dmaengine+bounces-11076-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 23:27:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122C618066
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 23:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D189D300BD94
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3130E0DC;
	Sun, 31 May 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV1QruuL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F1268690
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780262831; cv=none; b=pLuRtQDP0gvnF9SIdSEEvE03z4414TPOmXozBmN8nxjFKRu5if+Uyo9IHnGGaR5gqSxWtU+YeCOzg3y/E9S2OkdA8IFWHrK0ed8Eh2F5cDXvA6O5JbE7/Z6aAArnT+ULgPjW/nj9K7Aj3uuHxC4AVhdlr9f8DML8IGWQEAPk0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780262831; c=relaxed/simple;
	bh=X3hmvTjai4y25AZbMTa/fE6r44Cw1bbaJF9FFuKwN7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJntcebnv+vS7EcPh+bufydTX04/ReKTONnmjSeQ4ySwItu/8tFUq1ELJGI3DXeSL23VY2kuCkqRRYjXORgdJjlCIkNRdNhYJBL87/8xilIF83EaHNimqoToS2tAadAvnmUIWYZ9+dDC4FKjjhb8GQywLcU/UrU6/uMoK22tLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV1QruuL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FFB1F00893;
	Sun, 31 May 2026 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780262829;
	bh=eoA+wSmgDfvIAYa0j8mxj1FAPOAMNERdbFLG9X3RPxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jV1QruuL9i1JchwYkUcmRNi3COAqUwZB2n9Gqgl1BK0Vxj6WDJnhME8pyEc1esR25
	 1WN2hste1oB3ET81eRggNv2sAclwfPZ//P6G7UtjT+FwHtKhYUzxZHpelwcQ0pEP/0
	 NMQQSOIKAK0R70GNqcrB0e65xwNr/SX9M4T9vLA1YAJxl8iiiyetDo2f7K2xJfGb+5
	 YUPdiPaxh5sUZ6HkvKY7nv4JkPEPNpqE3cz+4ZBDtI4mdCVH5vsGRdN3wBJEtCoVFM
	 vViR1/WvqfDG+R2RjxoX5KkuUtg0D2CWB9MSersA2cp8ahBntAbvNcZDZ9jIyY/t2O
	 otBobHw+3caHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: fix out-of-bounds access from
 D40_MEMCPY_MAX_CHANS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260531210747.11401-1-rosenp@gmail.com>
References: <20260531210747.11401-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 21:27:08 +0000
Message-Id: <20260531212709.10FFB1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11076-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 3122C618066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The commit message incorrectly claims that the out-of-bounds write =
corrupts 'adjacent stack memory'.

Pre-existing issues:
- [High] Missing `free_irq()` and `tasklet_kill()` in the `d40_probe()` err=
or path (`destroy_cache`) leads to a severe Use-After-Free and IRQ leak.
--

commit d80dea89461b0f1c87cf7d871360b4cb6985bcdb
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ste_dma40: fix out-of-bounds access from D40_MEMCPY_MAX_CHANS

The commit fixes an out-of-bounds array access in the ste_dma40 driver by
correcting D40_MEMCPY_MAX_CHANS to match the actual size of the
dma40_memcpy_channels array.

> 1. d40_of_probe() accepts up to 8 memcpy channels from DT
>    (num_memcpy > D40_MEMCPY_MAX_CHANS allows 7-8), then writes them
>    into the 6-element dma40_memcpy_channels[], corrupting adjacent
>    stack memory.

[Severity: Low]
Is the description of "stack memory" corruption accurate here?

Looking at dma40_memcpy_channels, it is defined as a static global array,
meaning the out-of-bounds write would corrupt the .data or .bss segments
rather than adjacent stack memory.

Could the commit message be updated to reflect that this is global memory
corruption rather than stack corruption?


> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9b803c0aec254..9dfacffa0548f 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -86,7 +86,7 @@ struct stedma40_platform_data {
>  #define D40_ALLOC_PHY		BIT(30)
>  #define D40_ALLOC_LOG_FREE	0
> =20
> -#define D40_MEMCPY_MAX_CHANS	8
> +#define D40_MEMCPY_MAX_CHANS	6

[Severity: High]
This is a pre-existing issue, but I noticed a missing cleanup step in the
probe function's error handling. Does the destroy_cache error path in
d40_probe() leak the IRQ and fail to kill tasklets?

drivers/dma/ste_dma40.c:d40_probe() {
    ...
	ret =3D request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
	if (ret) {
		d40_err(dev, "No IRQ defined\n");
		goto destroy_cache;
	}
    ...
	ret =3D of_dma_controller_register(np, d40_xlate, NULL);
	if (ret) {
		dev_err(dev,
			"could not register of_dma_controller\n");
		goto destroy_cache;
	}
    ...
 destroy_cache:
	if (base->lcla_pool.dma_addr)
		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
    ...
}

Because request_irq() is used instead of a devm_ variant, shouldn't free_ir=
q()
and tasklet_kill() be called before returning?

If probe fails late, the devm_kzalloc() allocated base structure is
automatically freed. If the leaked IRQ fires or a scheduled tasklet executes
afterwards, they will access the freed memory, leading to a Use-After-Free.

> =20
>  /* Reserved event lines for memcpy only. */
>  #define DB8500_DMA_MEMCPY_EV_0	51

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531210747.1140=
1-1-rosenp@gmail.com?part=3D1

