Return-Path: <dmaengine+bounces-11634-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tE7qG8bNNGqrhQYAu9opvQ
	(envelope-from <dmaengine+bounces-11634-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 07:04:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2606A3E85
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 07:04:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FaHjY1yK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11634-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11634-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D920303CE88
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 05:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26031F996;
	Fri, 19 Jun 2026 05:04:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B31DF980;
	Fri, 19 Jun 2026 05:04:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845442; cv=none; b=u2i+PU4y8qZuj25Ih4pc4vNXrHaT0qaySIG3TExEkukTQJ74WEDUh6b7imKHaFIog3NXbSR+h7ykM1fPYT4q5X2DayA5M/iZ3af8WaTHkFuEtrHkvpgEtHk40SGSjpPsV4S+I9c6oafgWB1WZqWP79/a+zRou2LL+6/OvXXu+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845442; c=relaxed/simple;
	bh=YOKOGmwu6xWY00cbjxPhUx+gJeVQo2xZln9Zv3XNT1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MavNMK9S3ASrLVF7qki8lNSkjVjMFCu0GFV4heoPL3+Wcscf2V1DuTMRdS9m1bdLJpbBK+ubAsP/z4cql+UNPyEoGwlHWP672clnIrtzlDDYooixUPZOLGmOzNGF6hJs1cjPtEgSuJrhQvkm0A5u0dz5ghbOnYbqIgXeTMbGai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaHjY1yK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F8D1F000E9;
	Fri, 19 Jun 2026 05:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781845440;
	bh=MUOlrb8tYCEvB4NE9QX1/7hnmer3p32/vl+xSGZP2D4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FaHjY1yK3cbN0aZ7zarQYxnAx5Zu6rJgw6RdYdOfLbyNkGyQXQIZgw4CaVavYf/NU
	 AzGF52j9fiIr7CoIQRJmLQKrdRBaNm3qo0IIB4YBQi9gd1yJ8ltpjIoKam75knVkcM
	 6EvZVasc32Y1fvpLVaRJ3jpf4sDN0EoPnYRM3RCbloo4CmUKV2vGjH4B4NihqlVm6Z
	 AjKrHABzpwxAfFfTDkX1CDtfUJyhwRoJdXUxVwPhvIHk3YJVG2JZrqgazTE4EmGjJc
	 /mMxRHq2uKyc1faCDGSxZLdv6rrmPZ3z1E6fdTbggf1p/zcA+Aotl04UAEnZyGPQl3
	 CQGHSVoxtMy4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] dmaengine: sun6i-dma: Add set_addr function pointer
 for variable address widths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: robh@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260619-sun60i-a733-dma-v1-2-da4b649fc72a@gmail.com>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
 <20260619-sun60i-a733-dma-v1-2-da4b649fc72a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 05:03:59 +0000
Message-Id: <20260619050400.03F8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11634-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:robh@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:linux-sunxi@lists.linux.dev,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F2606A3E85

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free vulnerability in the error handling paths of `sun6i=
_dma_prep_slave_sg` and `sun6i_dma_prep_dma_cyclic` when freeing DMA pool i=
tems.
--

commit ea99a7147f9100709dbaea854d96eccdbc89f235
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Add set_addr function pointer for variable address wi=
dths

The A733 DMA controller supports higher address (up to 32G) compared to
previous generations. By moving set_addr into the sun6i_dma_config
structure, we can provide specialized implementations for different hardwar=
e.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index d92e702320d9f..059455425e19c 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
[ ... ]
> @@ -787,7 +796,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_slave_sg(
>  				sg_dma_len(sg), flags);
> =20
>  		} else {
> -			sun6i_dma_set_addr(sdev, v_lli,
> +			sdev->cfg->set_addr(sdev, v_lli,
>  					   sconfig->src_addr,
>  					   sg_dma_address(sg));
>  			v_lli->cfg =3D lli_cfg;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error handling
paths for sun6i_dma_prep_slave_sg() and sun6i_dma_prep_dma_cyclic(), is the=
re
a use-after-free when freeing DMA pool items?

In the err_lli_free path, the code iterates over the linked list of items:

err_lli_free:
	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
		dma_pool_free(sdev->pool, v_lli, p_lli);

When dma_pool_free() executes, the memory associated with v_lli is returned
to the pool. The loop's update step then accesses v_lli->p_lli_next and
v_lli->v_lli_next to advance the pointers.

Under memory pressure, another thread might allocate this newly freed item
and overwrite its contents, potentially causing an invalid pointer
dereference. Should this loop use a safe iteration method that reads the
next pointers before calling dma_pool_free()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-sun60i-a73=
3-dma-v1-0-da4b649fc72a@gmail.com?part=3D2

