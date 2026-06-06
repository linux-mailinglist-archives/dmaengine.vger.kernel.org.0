Return-Path: <dmaengine+bounces-11252-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G7n/NMtnI2r9swEAu9opvQ
	(envelope-from <dmaengine+bounces-11252-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:20:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC764BFE3
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:20:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZKP9Z7ww;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11252-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11252-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A4883005AE4
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69D1991CB;
	Sat,  6 Jun 2026 00:20:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EB3BB4A;
	Sat,  6 Jun 2026 00:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705223; cv=none; b=lXGwaIW2i8EVrTuTiJLTpV2a24tslGKWBWJXzFOfyvVjpJ6ZDQprtRLwD+XtM9u7NSFRvkrpQb3N+PprqEk8KfByhF0ktojnFq9B74zG0XgV2kaUd7PZ4g3BnNdSZWzqt2GHrYTo7+i4m9IphwwPyACItcjOZkoJLZkpbh5fPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705223; c=relaxed/simple;
	bh=BjMz0rbuWlQxAECFFj7qvuLwLidJj/HZIglzbfza7GA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JlivHqs/FKJ5LDPw/cp+mrZqeipmsJCgFnhiQkKmyOF+YqGnDREMtiuwJglPYXQaC0YotnW2pWpmL3UD99VlTEHdQxg8BgcaNh1NrUro9raWBn+q0Jwev0hJ3RbDINRj9XhSc3xpbLm4YLwh0HGznWtHvdwksxFb0RYT9CGBA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKP9Z7ww; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DD31F00893;
	Sat,  6 Jun 2026 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705222;
	bh=qlBzx7aKG5I6hsVkkeqOOmRc1F5FzGcPmU24g/sv574=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZKP9Z7wwVIxYrBHpt6P0Udz0ZSPJ0kI1uBeH27ALtXgQ1khdsLW7HcLkAPWCoNRMY
	 c0cdUfqpdM9M7+a/t8s3c6+n4iEBD7n8yZZgb+eolLvC2xMfUJMDnfOMsmij1GitxV
	 CEqHlhKKQFkjSAUgazjDcrySHVZ7X5uG6Vbhd+6nW+WEle9A22ff2O6OAg+DOpqR7k
	 V36P//wpCasYkmVgTB8rON3ymR2BENKceuuHhA3tqZK1AdhJhuEAlH0hCUcui4MuIh
	 vqBES5DzWSZDT0PROhJNwKff3MGSNo8FmSj5jWjfpR8lIzODIIZuwt/C8WI0Y5rgLM
	 qcg6m6HnyJkNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/23] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-15-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-15-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:20:21 +0000
Message-Id: <20260606002022.65DD31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,amd.com:email,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-11252-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86DC764BFE3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `ida_destroy()` on an uninitialized `struct ida` during er=
ror cleanup will cause a 'spinlock bad magic' BUG/panic.
--

commit bae483227e10a5de8c4656d9cc0ae199cc275f05
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Per-context access key (AKey) table entry allocator

Each SDXI context has a table of access keys (AKeys). SDXI descriptors
submitted to a context may refer to an AKey associated with that
context by its index in the table.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 907547ac450f2..9b0984842d9a7 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -64,6 +65,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi->dev, sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	ida_destroy(&cxt->akey_ida);

[Severity: High]
Will this trigger a spinlock bad magic BUG during error cleanup?

If sdxi_alloc_cxt() fails during its memory allocations:

drivers/dma/sdxi/context.c:sdxi_alloc_cxt() {
    struct sdxi_cxt *cxt __free(sdxi_cxt) =3D kzalloc(sizeof(*cxt), GFP_KER=
NEL);
    ...
    return NULL;
}

The __free(sdxi_cxt) cleanup handler automatically calls sdxi_free_cxt().

Because ida_init(&cxt->akey_ida) is only called later by external callers
like sdxi_admin_cxt_init() or sdxi_cxt_new(), the ida remains uninitialized
on these early error paths.

Calling ida_destroy() unconditionally here will try to acquire the
uninitialized XArray spinlock with xas_lock_irqsave(), which crashes the
kernel.

[ ... ]

> @@ -322,6 +324,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	cxt->db =3D sdxi->dbs + cxt->id * sdxi->db_stride;
>  	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
>  			     sq->write_index, sq->ring_entries, sq->desc_ring);
> +	ida_init(&cxt->akey_ida);
> =20
>  	err =3D sdxi_publish_cxt(cxt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D15

