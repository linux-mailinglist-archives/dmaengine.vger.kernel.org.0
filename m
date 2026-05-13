Return-Path: <dmaengine+bounces-10436-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HoSIATXBGqIPwIAu9opvQ
	(envelope-from <dmaengine+bounces-10436-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:54:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB53253A3A6
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF33E3023069
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3EA3AE1A2;
	Wed, 13 May 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CexnOkjq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FA3A872B;
	Wed, 13 May 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702079; cv=none; b=J1BjFw/wHrJE04w6TNNXxOunbqW6SsvlXfoeeUGLe/5u1pZhuM6j1bzjlRsv6fQAGUAojz2Xp97uShJIzSGkRoAZQZDlJ5bFdRtt/Eoi/9HF+Q2HQfMlX4tfiOmUL0Nu5GFXlP7uHDOU5jXqRgg4Mz1OfavtEZcnpJ81lQ2otls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702079; c=relaxed/simple;
	bh=paOk2Ph+X+UCkMq982xLfubN6sNLLaeAOZ+Tr1nKqhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sm4qUBi/iwJ42Lac3avTR8MRt7V1mXpkXoEQ2CsLkcio3haWkmEmgt4K/Yt3knw/kP+PvXrFpkSj+NcYGYg8lGAMZQWJbixduMzDSohkVs/Elu/L39dCarH77C0wIoUIbY8y+4CEidWECedrQpoE5TZaa6Qc4yUM3WneRWUJ6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CexnOkjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CBCC19425;
	Wed, 13 May 2026 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702079;
	bh=paOk2Ph+X+UCkMq982xLfubN6sNLLaeAOZ+Tr1nKqhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CexnOkjqQj85sgOb2cQINITKcmYp5nZc8JKABuRVlyTgE4h9qHQJ39id2WHt+2x4l
	 s+qlCUtfdTUvkbc3KccfAsL5S0V1jSbUPpNMqwp4WdLoKdEPNLKN+R5/GQgTgIx+al
	 IBdAF4aL6QrG86jgPPzbuVbutgv7NUzUrDrnDcnGdcdjtqT/vdqVbQ94wmhjfO4XYx
	 rWE8Cwxyv+A68wMNVDdWMmn5hRsPNzn4UO/Dm0roYRs4KeLF33ixiaEaFQB7y7D3Sw
	 Et2Ztg+VBeXsBiJ0QTWB4+DmUHOM3TAdRNJQlDO47eHx2+S1iKXigSkcI8d5rvRGfS
	 13k078zHY+Ktw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/23] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-15-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-15-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:54:38 +0000
Message-Id: <20260513195439.49CBCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: EB53253A3A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10436-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized spinlock access in sdxi_alloc_cxt() error path causi=
ng kernel panic.
--

commit 892562ce0135e1869cdd9bddad2a442b66eeef94
Author: Nathan Lynch <nathan.lynch@amd.com>
Subject: dmaengine: sdxi: Per-context access key (AKey) table entry allocat=
or

This commit adds a per-context IDA to keep track of used entries in the
AKey table. It introduces functions to allocate, retrieve the index of,
and free AKey table entries.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -64,6 +65,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi->dev, sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	ida_destroy(&cxt->akey_ida);

Will this cause a panic when freeing a partially initialized context?

If sdxi_alloc_cxt() fails allocations internally, it will trigger
sdxi_free_cxt() on the partially initialized context object via the cleanup
macro.

Since akey_ida is initialized in the callers (like sdxi_admin_cxt_init
and sdxi_cxt_new) rather than in sdxi_alloc_cxt() itself, a failure within
sdxi_alloc_cxt() means ida_destroy() will be called on a zero-initialized
structure.

ida_destroy() unconditionally acquires the internal xarray spinlock. Attemp=
ting
to lock a zero-initialized spinlock can cause a bad magic splat or kernel
panic.

Could ida_init() be moved inside sdxi_alloc_cxt() to ensure it is always
initialized before any potential cleanup?

>  	kfree(cxt->ring_state);
>  	kfree(cxt);
>  }

[ ... ]

> @@ -322,6 +324,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	cxt->db =3D sdxi->dbs + cxt->id * sdxi->db_stride;
>  	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
>  			     sq->write_index, sq->ring_entries, sq->desc_ring);
> +	ida_init(&cxt->akey_ida);
> =20
>  	err =3D sdxi_publish_cxt(cxt);
>  	if (err)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D15

