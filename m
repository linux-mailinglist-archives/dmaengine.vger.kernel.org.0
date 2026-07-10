Return-Path: <dmaengine+bounces-12342-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRf4EkgnUWqBAAMAu9opvQ
	(envelope-from <dmaengine+bounces-12342-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:09:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCE73CED8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:09:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gbJ5KIzj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12342-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12342-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E1C63008D70
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41143B3D8;
	Fri, 10 Jul 2026 17:07:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A8434408;
	Fri, 10 Jul 2026 17:07:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703230; cv=none; b=jWAQpMYfukxBJ0YHk99lChqdx0aqNOFeStsUdQQ3/WIX2drvPIk8eGLizrWOUmYU4KYyl6VqrEw+L7cPAHKkMUSkWNHRPYIM+ccKP+1NNG6DzTZ01muPZ/8NBpJDm9IlK4kRwmkBbFgRFpXiXGmctv3llVPCdtWMEZWzXsMRgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703230; c=relaxed/simple;
	bh=kwEpGpTES/SECB5AzWXXvxM3AgBrprRApMyOzIMuP5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7J62IZc3WlW132Bng8T/NTZ90r5s7E2+CWl9OW6Cy8KLy1eUHVRiOnPUYrpsFLJbPel/QTs4Lf3q0bQIZsbs5DTVfN5mk2oIIg3TrMnO4Y6VIN5fQNjL2AJD6MMN9H04W0FjyYntl56Zg0j7eXnflcJrjksRagBhT/yyYVdCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbJ5KIzj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD611F000E9;
	Fri, 10 Jul 2026 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703229;
	bh=wsjYCuKWTfokQ/+ixcLrkIiA5mWulO+PKTTEJ2EeMDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbJ5KIzjBk0dJFQTAZoyVkTVczMV6rJMagMNKa0j48YPGN17AsyfHtVqo/rPXC1TA
	 a+je47x/i1kIz+gfa5MyA6yvLOoO/t7h0bRlIiI+24fiA+p9/BKwSjTuB9SE+HUkJY
	 Z3K79uDSuhn2KEeUioznjUJ+mbLHUC7jAj5AqDXpNWdFL4Yl+KrKUTi5zgUhiIij+b
	 orMkKv19BPm4Rydk/eEodgC5eEJ3zpU3Ar1pNrYunOP81J+zsxv9UPvyQ3MgGXMC8E
	 +BQa6IJgHws1v6tGPCqNgR8CYboBgBQ4K5g/CeuNoOqxKGEVv4jl1nROwVWCHr99bd
	 97BC3/yp6qC6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260710-edma_ll-v6-9-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-9-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:07:08 +0000
Message-Id: <20260710170708.ACD611F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12342-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6FCE73CED8

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] In non-linked-list (non_ll) mode, the burst array index is inc=
orrectly calculated using `chan->ll_max` instead of `bursts_max`. This caus=
es a heap buffer overflow and leaves the actual DMA descriptor uninitialize=
d.
--

--- Patch [9]: [PATCH v6 09/10] dmaengine: dw-edma: Use burst array instead=
 of linked list ---
commit 755f4cc5fb98a43f3634cf5e1dc7f15a35af8c49
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. This commit allocates a
burst array when creating each chunk to simplify the code and eliminate
one kzalloc() call.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f52d9fd18e573..202862a828b4d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *v=
desc)
>  static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan =3D chunk->chan;
> -	struct dw_edma_burst *child;
>  	u32 i =3D 0;
> -	int j;
> =20
>  	if (chan->non_ll) {
> -		child =3D list_first_entry_or_null(&chunk->burst->list,
> -						 struct dw_edma_burst, list);
> -		if (child)
> -			chan->dw->core->non_ll_start(chunk->chan, child);
> +		if (chunk->nburst =3D=3D 1)
> +			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);

[Severity: Critical]
If chunk->burst[0] is bypassed during allocation in dw_edma_device_transfer=
()
when i > 0, does this code submit an uninitialized descriptor to the
hardware?

[ ... ]
> @@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er,
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
> =20
> -		if (chunk->bursts_alloc =3D=3D bursts_max) {
> -			chunk =3D dw_edma_alloc_chunk(desc);
> +		if (!(i % bursts_max)) {
> +			u32 n =3D min(cnt - i, bursts_max);
> +
> +			chunk =3D dw_edma_alloc_chunk(desc, n);
>  			if (unlikely(!chunk))
>  				goto err_alloc;
>  		}
> =20
> -		burst =3D dw_edma_alloc_burst(chunk);
> -		if (unlikely(!burst))
> -			goto err_alloc;
> +		burst =3D chunk->burst + (i % chan->ll_max);

[Severity: Critical]
Does this code overflow chunk->burst[] when chan->non_ll is true?

If chan->non_ll is true, bursts_max is 1, so dw_edma_alloc_chunk() allocates
a chunk with a 1-element burst array for each i. However, burst is indexed
using chan->ll_max.

For example, when i =3D 1:
- i % bursts_max is 0, so a new chunk is allocated with nburst =3D 1.
- If chan->ll_max > 1, i % chan->ll_max is 1.
- burst is set to &chunk->burst[1], which is out of bounds.

Consequently, chunk->burst[0] remains uninitialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D9

