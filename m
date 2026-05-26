Return-Path: <dmaengine+bounces-10917-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEAHMvJkFWqCUwcAu9opvQ
	(envelope-from <dmaengine+bounces-10917-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:16:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70C5D3201
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB31C305D12C
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39D35BDA8;
	Tue, 26 May 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0a1m7zA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3934750F
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786207; cv=none; b=p9oxAbP5v3q44ozdZqV6YsSLTHXeXCyA4+q3R5V7HsFeH8PXLVMEw0PkkZ8SXD20KoA5mzkVLbfJhOkUZ+sf94dYqQIaRuRiJI2p8qM1gJma4dWrXnKzRzAeCT1VRv2PgnRwotDuP9lE/uqT+BawQtw2z/4cQCsHVwvHYqAqdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786207; c=relaxed/simple;
	bh=rupmt12Sd3jXHUFz+VPsHwyZKOztUECaNhEJXV00qFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e5S+2GzSacn8hJV7cukYdEJx4tT3ysesRR5Nn1Hp9uV4SJzoEaL6qWX4m/baRs6zn14SwKDmSlcCH843W/d3Fd7KcoQh6XYGWQ+SNOYPvyKK1JZ96MqXK+/7oNsUo6IJE3llukx0hoH1aE5SKOUYzUwoZ60HFis8KFHCZmG3TnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0a1m7zA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731A31F000E9;
	Tue, 26 May 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779786205;
	bh=y7reFkKEUTY6CChjMViLXVG4w4kMdlETKUMHAMH0pio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0a1m7zAwyuXJFAY8wNhwFBE2LyYsUKmT3nqPYEXLdg5v0wWXAW335j5oKMcYuXkI
	 XxY4xETKT3+yQ7Rc+v8EX/5k3spUqaueGjJvwpCWBuPsHl2uHfM1z+VRKf5jPHiQi5
	 a3NpM/oojFZrP2hY6cqazD279vZx+SJGIytE9WEEok/CaeE9a5ETsqGqCgC+faGTZm
	 H80bqB0kmNBsLR2MD5KfKAwoUfyYwK8y/vLAHzYyzLkNdvBdDV3FIZfqo04VNTDjXC
	 8UxcxaF83vZyWgfl0TQYAMHGkbsjy05PO+QMxpTlGLg5T4iWITWH0MoGYyKBzbpLvX
	 Dx8zG9jxlCp6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/18] dmaengine: sh: rz-dmac: Fix incorrect NULL
 check for list_first_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260526084710.3491480-3-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-3-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:03:24 +0000
Message-Id: <20260526090325.731A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10917-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 1E70C5D3201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature early return in `rz_dmac_chan_get_residue()` incorrectly=
 reports pending transfers as complete.
--

commit fea7825b62a6663b4eee5a60ada5a7e2123e0506
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Fix incorrect NULL check for list_first_entry()

This commit replaces list_first_entry() with list_first_entry_or_null() in
rz_dmac_chan_get_residue() to fix an invalid NULL check. It addresses the f=
act
that list_first_entry() does not return NULL when a list is empty.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 9f206a33dcc6b..6d80cb668957f 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
>  	u32 crla, crtb, i;
> =20
>  	/* Get current processing virtual descriptor */
> -	current_desc =3D list_first_entry(&channel->ld_active,
> -					struct rz_dmac_desc, node);
> +	current_desc =3D list_first_entry_or_null(&channel->ld_active,
> +						struct rz_dmac_desc, node);
>  	if (!current_desc)
>  		return 0;

[Severity: High]
Does returning 0 here prematurely report pending transfers as complete?

When ld_active is empty, such as for a transfer that has been prepared and
queued but not yet started by the hardware, list_first_entry_or_null()
returns NULL, causing an immediate return of 0.

Before this patch, list_first_entry() on an empty list evaluated to a non-N=
ULL
pointer, allowing the code to bypass this early return and successfully fall
back to checking ld_queue to find the pending descriptor.

By returning 0 early here, rz_dmac_tx_status() will override the transfer
status to DMA_COMPLETE since the residue is 0. Will this cause a DMA client
to falsely assume memory has been transferred before the hardware begins the
operation?

Note that this issue appears to be fixed later in the series by commit
d09437d0a9b5a ("dmaengine: sh: rz-dmac: Use virt-dma APIs for channel
descriptor processing"), which refactors descriptor tracking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D2

