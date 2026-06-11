Return-Path: <dmaengine+bounces-11433-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vLVSM580KmobkAMAu9opvQ
	(envelope-from <dmaengine+bounces-11433-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:07:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556966E1F9
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:07:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tm8A2x49;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11433-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11433-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3575F312F846
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFC31F9A5;
	Thu, 11 Jun 2026 04:06:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A836283FE6
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 04:06:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150814; cv=none; b=nwdLUculZSa1YOmR45qWwvMhbaIABN3zCBot24SE9QSvcMg7kRoS+4tk4wrPS8d/DKDcaeNu4tiB85ytrm+fbJMuArpbyW010M6VCRPQ7WIT5iUOixAWNXCCCcTxJMMxCucipMBPd/NZdoJATBBcGwQ0h41CUn5mtCsa7qg1cTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150814; c=relaxed/simple;
	bh=AGyXj7HFKdojy1IfS9Dt74aaDb4CMkw/LSf/CBUsxEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZM1LHmvV2v2T37xfCp9yUrSWmT8gCODBEx0o53fPpItJgjsOHmBps3S+ZFlEF9ARXk6YEU7K7ycaSDmucJqZlQHOttKmKl+gjN0o+oQitSID4ahEOo2GlGY8fFYmSe4NIfa23wWm7kfuNgpDNMaIBaGUek9kAowDbXLJ6RsgiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm8A2x49; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C321F00898;
	Thu, 11 Jun 2026 04:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781150812;
	bh=1APAzTmZw+iK0P8Z5e9kpbx0yNZt7zdq8E9wWo/OnCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tm8A2x498+5NYeUClQZoDgyCIMfh9XNWrdJA0ulTQpLPY2sMQTfoXr+StqJ7/38HF
	 hqpYnlF2qZwlD0BWM1TlzookEVuI1wYBjNL6i4EotLvMMzLXlUfjDS7m8Mg/ZL4m5c
	 FDUzS4pvj8d2+Zfjtxx7Pp/6a25Y6jpWlyoC76QIbjyYCSW7G37EiEWKw1Ugm09MFP
	 ODfrtPUcNRX70MLAs0rE2v30EveRuW7qJYx0WOWDsdXTK7GXpOyXHckTLZ7nZhaqO5
	 WEFQvJhJqSH/N2ISmhVqg1QqDH2NZODvhAJuZLQZJP3FbTAqtxCrXVfo8jv1VHzktS
	 sKvyvyJ26/Fww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 02/15] dmaengine: fsldma: drop desc_lock before
 invoking client callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260611035245.13439-3-rosenp@gmail.com>
References: <20260611035245.13439-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 04:06:52 +0000
Message-Id: <20260611040652.99C321F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11433-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3556966E1F9

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditionally setting `chan->idle =3D true` inside `fsldma_clean=
up_descriptors()` clobbers the active hardware busy state, causing active t=
ransfers to be overwritten.
- [High] Dropping the lock without reentrancy protection allows concurrent =
execution of `fsldma_cleanup_descriptors()`, breaking callback serializatio=
n and corrupting `completed_cookie`.
- [High] Dropping the channel lock during descriptor cleanup allows concurr=
ent channel teardown to destroy the descriptor pool, leading to a Use-After=
-Free.
--

commit 3e8446b448ad00b0206ad968720a0177b8f36855
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: drop desc_lock before invoking client callback

fsldma_run_tx_complete_actions() calls dmaengine_desc_get_callback_invoke()
while still holding chan->desc_lock.  If the client submits a new
transaction from their completion callback, fsl_dma_tx_submit()
tries to acquire the same non-recursive spinlock, causing a
self-deadlock.

Fix by extracting the callback info under the lock, removing the
descriptor from ld_running, dropping the lock, then invoking the
callback and running dependencies outside the lock.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..5c8a8fe25617d 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
[ ... ]
> @@ -635,22 +603,23 @@ static void fsldma_cleanup_descriptors(struct fsldm=
a_chan *chan)
>  {
[ ... ]
> +	/*
> +	 * Take descriptors one at a time from the front of the running
> +	 * queue.  We re-read the list each iteration so that we don't
> +	 * chase a stale next pointer across the lock-drop below.
> +	 */
> +	while (!seen_current && !list_empty(&chan->ld_running)) {
[ ... ]
> +		/*
> +		 * stop the search if we reach the current descriptor and the
> +		 * channel is busy
> +		 */
> +		if (desc->async_tx.phys =3D=3D curr_phys) {
> +			seen_current =3D 1;
> +			if (!dma_is_idle(chan))
> +				break;
> +		}
> =20
[ ... ]
> +		/*
> +		 * Drop the lock before invoking the client callback, since
> +		 * the DMAengine API explicitly allows clients to submit new
> +		 * transactions from their completion callback.  Otherwise
> +		 * we self-deadlock on chan->desc_lock.
> +		 */
> +		spin_unlock(&chan->desc_lock);
> +		dmaengine_desc_callback_invoke(&cb, NULL);
> +		dma_run_dependencies(&desc->async_tx);
> +		spin_lock(&chan->desc_lock);

[Severity: High]
Does dropping the lock here without reentrancy protection allow concurrent
execution of fsldma_cleanup_descriptors()?

If another thread calls fsl_tx_status() concurrently, it could acquire
chan->desc_lock, enter fsldma_cleanup_descriptors(), and execute callbacks
simultaneously. This would break the DMAengine API's serialization guarante=
e.

> +
> +		chan->idle =3D true;

[Severity: High]
If the loop breaks out early because the current descriptor is busy
(!dma_is_idle(chan)), chan->idle is still set to true from the previous
iteration while the hardware is actively busy.

Will fsl_chan_xfer_ld_queue() called later in this function evaluate this
corrupted chan->idle state, skip its !chan->idle safety check, and forceful=
ly
overwrite the active transaction by issuing a new DMA start command?

> +
> +		if (!async_tx_test_ack(&desc->async_tx))
> +			list_add_tail(&desc->node, &chan->ld_completed);
> +		else
> +			dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);

[Severity: High]
Could dropping the lock above allow fsl_dma_free_chan_resources() to execute
concurrently, destroying chan->desc_pool and setting it to NULL before we c=
all
dma_pool_free() here?

>  	}
> =20
>  	/*
>  	 * Start any pending transactions automatically
>  	 *
>  	 * In the ideal case, we keep the DMA controller busy while we go
>  	 * ahead and free the descriptors below.
>  	 */
>  	fsl_chan_xfer_ld_queue(chan);
> =20
>  	if (cookie > 0)
>  		chan->common.completed_cookie =3D cookie;

[Severity: High]
If concurrent threads execute fsldma_cleanup_descriptors() due to the dropp=
ed
lock, can an older local cookie from one thread overwrite a newer one writt=
en
by another thread here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611035245.1343=
9-3-rosenp@gmail.com?part=3D1

