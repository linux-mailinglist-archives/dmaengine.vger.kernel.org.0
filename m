Return-Path: <dmaengine+bounces-12421-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7vocH50fVWrwkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12421-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:25:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EFA74DFD0
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jFRSbDy/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12421-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12421-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE67130315E4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E74346A01;
	Mon, 13 Jul 2026 17:25:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8C1E1E12;
	Mon, 13 Jul 2026 17:25:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963524; cv=none; b=isMZ3ztvQ9kD9ktbVT7gOzF3EVfWjE2x6Nv2ju24GIAw6kuP7TUkeBnoAZhMpUIBT8XzRyEAYgvr7/IawyVWBcMV6hlcD/0rEMZKer8mUic1bwtfLpIgI8ZlUuunk1+nkEHtHd3FxX5fKKg7nk+L5aWOf9UilVzIuOPAZmvlpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963524; c=relaxed/simple;
	bh=PR+cxLj73+fjanKV1NKzCtcMQE/BpTFkVaimgkXvc1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SpjLPsyr9zb4ZBqnMmz4p7AsXXwsGdnG8aOCPqmC4RLeiNm5p7EKGXHo9ax/FjT5J+e6OO3ZTwePIXNRQCr2mp4iju8Qbq3/7QO7N/gVirpCCsRLCDUwotM/f7/gf1Wae++wp9KCQs/S7oGBzkG6i2HXFh3JFfHwt/BGTJqXnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFRSbDy/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3571F1F000E9;
	Mon, 13 Jul 2026 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963522;
	bh=6PvRjjv5Ke6VW5MwcuvoC+CkH/D2yP8rRnpwMBC1Uko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jFRSbDy/GsbA2nqk9jeAvsdy79jOSii0jgXxep/Kl/m8VyR5YRzuFP5Eyr00LXAbi
	 bgR4JwclyFoQ0B+nXlB6P4lk4nh2BT3nCvmCalUjtOSIpeEm3qurpKRjh1Nr3AG8eK
	 Q8xREB05EKjDSHry7Pz7OOrBPMK8zhscPpliHnyOib3/LWqIjimtXuY5gUj4Vq36Eb
	 a1954xV5yRF8T9jQQ3RVy4NkMKGO7fQPbq2SwKMDpgwtbhzr8bxXW0W/rjmI0QhPjP
	 +AtxAIlISyZTA/EeqjMR0yCsxENZPHJjl2wvdim63mlmNQqkjQSK1sy+rFnyFBE/Vg
	 irrk8tcpUs4Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260713-edma_ll-v7-9-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-9-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:25:21 +0000
Message-Id: <20260713172522.3571F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12421-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,smtp.kernel.org:mid,sashiko.dev:url,amd.com:email,valinux.co.jp:email,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8EFA74DFD0

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Early break in scatter-gather loop leaves `chunk->nburst` incorrec=
tly sized, causing uninitialized descriptors to be submitted to the hardwar=
e.
- [Medium] A zero value for `bursts_max` due to small linked-list region si=
zes causes a fatal divide-by-zero exception.
- [Medium] Replacing multiple small slab allocations with a single large fl=
exible array allocation in atomic context risks memory allocation failures.

Pre-existing issues:
- [High] `dw_edma_device_resume` calls `dw_edma_start_transfer` without hol=
ding the channel lock, causing list corruption.
--

--- Patch [9]: [PATCH v7 09/10] dmaengine: dw-edma: Use burst array instead=
 of linked list ---
commit 7aeaeaa1123dc1b005fda28afac5f4dff692b62b
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary. Allocate a burst array when creating each chunk to simplify the
code and eliminate one kzalloc() call.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f52d9fd18e573..c028011cc61ca 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> -static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *de=
sc)
> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *de=
sc, u32 nburst)
>  {
>  	struct dw_edma_chan *chan =3D desc->chan;
>  	struct dw_edma_chunk *chunk;
> =20
> -	chunk =3D kzalloc_obj(*chunk, GFP_NOWAIT);
> +	chunk =3D kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);

[Severity: Medium]
Does this single large flexible array allocation risk failing under memory
pressure?

If the hardware configuration results in a large linked-list region,
bursts_max can exceed 2700. This turns what used to be many small 24-byte
allocations into a high-order contiguous allocation in an atomic context
with GFP_NOWAIT, which is highly likely to fail if memory is fragmented.

[ ... ]
> @@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *v=
desc)
>  static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan =3D chunk->chan;
[ ... ]
> -	j =3D chunk->bursts_alloc;
> -	list_for_each_entry(child, &chunk->burst->list, list) {
> -		j--;
> -		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> -	}
> +	for (i =3D 0; i < chunk->nburst; i++)
> +		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> +				     i =3D=3D chunk->nburst - 1);

[Severity: High]
Can this loop submit uninitialized trailing descriptors to the hardware if
the scatter-gather loop breaks early?

In dw_edma_device_transfer(), if the SG list is exhausted before reaching
cnt (which can happen if the original length was passed instead of the
mapped length), the loop breaks out early.

Since chunk->nburst is pre-allocated and not reduced to the actual number
of prepared elements, this dw_edma_core_start() loop will process the
remaining zero-initialized elements.

Because the completion interrupt flag is only set when
i =3D=3D chunk->nburst - 1, the valid elements won't trigger an interrupt,
and the zero-initialized elements might cause a hardware hang.

[ ... ]
> @@ -206,14 +137,13 @@ static int dw_edma_start_transfer(struct dw_edma_ch=
an *chan)
>  	if (!desc)
>  		return 0;
> =20
> -	child =3D list_first_entry_or_null(&desc->chunk->list,
> +	child =3D list_first_entry_or_null(&desc->chunk_list,
>  					 struct dw_edma_chunk, list);

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_resume() call
dw_edma_start_transfer() without holding the channel lock?

When the dmaengine core invokes device_resume() without holding the
virtual channel lock, dw_edma_device_resume() modifies the channel state
and calls dw_edma_start_transfer().

Because dw_edma_start_transfer() calls vchan_next_desc() and reads the
chunk lists locklessly, this can race with concurrent interrupts
(dw_edma_done_interrupt) or software calls (dw_edma_device_issue_pending)
that legitimately take chan->vc.lock to modify these same lists.

Can this lead to list corruption or a use-after-free?

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

[Severity: Medium]
Does this modulo operation risk a divide-by-zero exception if bursts_max
is zero?

If the hardware or device tree configures a linked-list region size
between 24 and 47 bytes, ll_max will evaluate to 0.

This leaves bursts_max at 0, which would cause the kernel to panic when
evaluating this modulo operation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D9

