Return-Path: <dmaengine+bounces-10767-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DeWKwLBEGoSdQYAu9opvQ
	(envelope-from <dmaengine+bounces-10767-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:48:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D05BA308
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BD6B301F4F4
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D51372073;
	Fri, 22 May 2026 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0T+ua8T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3234CFAB;
	Fri, 22 May 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482740; cv=none; b=qXysAL+SkNCsao9BOocF7/tD8Wpf2ZZFEfBWlk0g0Cqr/cF1vac0b0LeW0OcqzLA8R+xt+vsp9G/xzZ2IYYpjlyDj+D/tcJRyFJeLkJLoeTdgP2eB45pWdb6vjgjir3X6dDVgeQgiG7QQQb421WJwv45TUNQ6BtHYJ4TPOK/1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482740; c=relaxed/simple;
	bh=XmUnD8IT1VZLEQjBNsP+6vpSY3qZRjOXV4CmRoEBqt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9ZMvSnd3Dn+SU1kztvixNsRflQgxepEsbSXooh+D0bay4yNznYHFjUtK8xD46gVsVQicaHHhGgmN4S6djX7NeHFQjTvSnZ3CRv8hTgcH5BCMstHmrgqbwv1KDsL7zxt5Pi9/Oz2/7fX+xx3tD7xR68neZVtTGg4Eqggnij7IOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0T+ua8T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE9C1F000E9;
	Fri, 22 May 2026 20:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779482739;
	bh=RG8jzNtY0j6fPSMmsYrnMjwplApDHBCDXP+XzMLyZLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0T+ua8Tz76uyQutMV5Jc2O+RAhReUxa2Di28EA9fZJHHniKBXlrEhkGw9hvm2VCs
	 txSN8OEtSurOWboZ1WAh5k5/S6+dkOtgKSYyAW9BuT2BPGpNe6MHWygUY0VnISYj4t
	 o22LMFNXQUlsN2KwetbQP/p+sFmbGpxJU1MGnoH9h4Jo/AieWF0Y6UsJCGAEWqzcsl
	 9M96J9S3WCf3Ng5aQi0sYAIDSswgIHNJYFPvp46sIpMOuMJwkkJs9V7Kz3wmDhVSiR
	 ErushI5u0+Doo0WKefdYKQnknkiGJA1ThIPBqnX51e68g9JW3YICNPOgpG37UnwBZU
	 67S8iRGJPgRNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: Add helper
 dmaengine_prep_submit_slave_single()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260522-dma_prep_submit-v2-1-7a87a5a29525@nxp.com>
References: <20260522-dma_prep_submit-v2-1-7a87a5a29525@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 20:45:38 +0000
Message-Id: <20260522204538.EFE9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10767-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,nxp.com:email,lists.linux.dev:replyto];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: B60D05BA308
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The macro accesses the descriptor after calling `dmaengine_sub=
mit()`, violating the DMA Engine API contract and causing a Use-After-Free.
- [Medium] Calling `dmaengine_desc_free()` fails to prevent memory leaks fo=
r standard, non-reusable DMA descriptors, defeating the primary goal of the=
 patch.
- [Low] The fallback implementation of `dmaengine_prep_submit_slave_single`=
 contains severe syntax errors that break compilation when `CONFIG_DMA_ENGI=
NE` is disabled.
--

commit c731d16a7ec5a6fed71b17234ae1bc2184ad8818
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: Add helper dmaengine_prep_submit_slave_single()

This commit introduces a helper macro and function to combine the preparati=
on
and submission of a DMA slave single transfer into a single step. It also
aims to automatically free the descriptor if the submission fails.

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index ca13cd39330ba..1e25be78a22a5 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
[ ... ]
> @@ -1619,6 +1619,34 @@ void dma_run_dependencies(struct dma_async_tx_desc=
riptor *tx)
>  }
>  EXPORT_SYMBOL_GPL(dma_run_dependencies);
> =20
> +#define dmaengine_prep_submit(chan, cb, cb_param, func, ...)	\
> +({	struct dma_async_tx_descriptor *tx =3D			\
> +		dmaengine_prep_##func(chan, __VA_ARGS__);	\
> +		dma_cookie_t cookie =3D -ENOMEM;			\
> +								\
> +	if (tx) {						\
> +		tx->callback =3D cb;				\
> +		tx->callback_param =3D cb_param;			\
> +		cookie =3D dmaengine_submit(tx);			\
> +								\
> +		if (dma_submit_error(cookie))			\
> +			dmaengine_desc_free(tx);		\

[Severity: Critical]
Does this access the descriptor after ownership has been transferred?

The DMA Engine API contract specifies that once dmaengine_submit is called,
the client must consider the descriptor pointer invalid. If submission fail=
s,
some DMA providers (like the idxd driver in idxd_dma_tx_submit) internally
free the descriptor before returning an error.

Calling dmaengine_desc_free here would read tx->flags on an already-freed
pointer on the error path, resulting in a use-after-free.

[Severity: Medium]
Will this actually free standard, non-reusable descriptors?

The dmaengine_desc_free function is explicitly designed for reusable
descriptors. It internally calls dmaengine_desc_test_reuse, which checks
the DMA_CTRL_REUSE flag and returns -EPERM immediately if it is not set.=20

Since standard descriptors created via dmaengine_prep_slave_single don't=20
have this flag set by default, it seems this call acts as a no-op and might
not resolve the resource leak mentioned in the commit message.

> +	}							\
> +	cookie;							\
> +})
> +
[ ... ]
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea9..0f789fac7e91a 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
[ ... ]
> @@ -1575,6 +1582,16 @@ static inline int dma_get_slave_caps(struct dma_ch=
an *chan,
>  {
>  	return -ENXIO;
>  }
> +
> +static inline dma_cookie_t
> +dmaengine_prep_submit_slave_single(struct dma_chan *chan,
> +				   dma_async_tx_callback cb, void *cb_param;
> +				   dma_addr_t buf, size_t len,
> +				   enum dma_transfer_direction dir,
> +				   unsigned long flags);
> +{

[Severity: Low]
Are there syntax errors in this fallback implementation?

The parameter list uses a semicolon instead of a comma after cb_param, and
there is a stray semicolon immediately preceding the function body. This wi=
ll
cause a build failure when CONFIG_DMA_ENGINE is disabled.

> +	return -ENODEV;
> +}
>  #endif
> =20
>  static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descripto=
r *tx)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-dma_prep_s=
ubmit-v2-0-7a87a5a29525@nxp.com?part=3D1

