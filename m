Return-Path: <dmaengine+bounces-11838-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGM5N9A0QmpI1wkAu9opvQ
	(envelope-from <dmaengine+bounces-11838-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 11:03:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABE16D7D55
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 11:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cuwsbNZq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11838-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11838-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB2A300CCB6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB133F825F;
	Mon, 29 Jun 2026 08:59:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8863F8230;
	Mon, 29 Jun 2026 08:59:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723558; cv=none; b=riaYOIKZrT6kcz57V5sLj6c06dqEP7nQlanhghudGjp56FLjJKCbMjaY6vtvXu8VQR/GAfIZ6QKwJ6Mm8DqsBkWD9NQNmsY0uHndclkoqY9XMuYmLHPzlPofLj9El5+z0VNYsPwJ6R3d3DS4kvuJZRN7ixMVq0Lnra4Qp2OR5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723558; c=relaxed/simple;
	bh=XHk/6Bd+ObNJrqh8/2hH/6tiAo8At03y+wek0Qle4eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggkqjSw68O5s7n1H2pclNjjuTeJEEhrjk3ufkS/stRemcsmNsFEMukZi38HJHjhBDg84O5o8j3RUclJxBtfmADY4035EGWCdSVBwm78C9BDbV8ni2f7P5HabEJT5HXdIhdwDHRZP0N3JZW/Wr74kydeRerAM7dRZ5aBmeWtvA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuwsbNZq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350211F000E9;
	Mon, 29 Jun 2026 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723557;
	bh=GfqqiFKOWzk8WSgIA8BsgncDcgJyhlG8Dd8qHV9ySGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuwsbNZqHJ/OGi+6AG7ksElZf1Q7zwwco/RdhCmInvqmkVGFSZ8A8NXqFXVqU/o6w
	 Anx8MAJ7qF8UKlp6xb5QgyaoHXPfHw55TCiA/T75TullupD0JWihqCG2amaN4Q35np
	 Ye/8RyBAt54uzFv7CBo/koqKIEfQHWuR4ezWmTIGpy0FHPxv2NXNdQOsK0c/f8ihpj
	 zkKqK33u3YhemZAONuJjAlnhHpj5afr4W0QKDpSeNWSKhQoNkhTIxu/gujYCI9yyGs
	 ZbjdCnpGpntf2T9sKR1MF6gMSnsEMpf0JxWNYl89JuckwL61oZTy9Y3lfqyav3teAe
	 6wXZVCDRzPEpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async() callback
 to flush the async read/write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-mhi-ep-flush-v1-2-714e0d56e87c@oss.qualcomm.com>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-2-714e0d56e87c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:59:16 +0000
Message-Id: <20260629085917.350211F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11838-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,manivannan.sadhasivam.oss.qualcomm.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ABE16D7D55

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Incorrect ordering of channel teardown, disconnect notification, a=
nd DMA flushing in mhi_ep_remove() causes data delivery after disconnect.
- [High] The newly introduced flush_async() callback lacks channel context,=
 forcing a controller-wide flush that aborts DMA operations for all active =
channels.
- [High] Dropping the channel lock during flush_async exposes a window for =
worker threads to process disconnected channels, defeating the fix and re-i=
ntroducing the UAF.

Pre-existing issues:
- [Critical] In-flight asynchronous DMA operations are not flushed before m=
hi_ep_ring_reset() frees ring->ring_cache.
- [High] Lockless access to mhi_chan->xfer_cb in completion handlers causes=
 a TOCTOU data race with mhi_ep_remove().
--

commit 191c1d6e4eab8c4a6ee949c2b5b9499a56060800
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read=
/write

This commit introduces a flush_async() callback in the MHI endpoint
controller. It is called during device removal to ensure any in-flight
asynchronous DMA operations are completed before continuing teardown.
This aims to prevent use-after-free issues caused by delayed DMA callbacks.

> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
[ ... ]
> @@ -1636,6 +1637,12 @@ static void mhi_ep_remove(struct device *dev)
>  		}
> =20
>  		mhi_chan->state =3D MHI_CH_STATE_DISABLED;
> +		mutex_unlock(&mhi_chan->lock);

[Severity: High]
Does dropping the channel lock here leave a window for worker threads to
process disconnected channels?

If mhi_ep_ch_ring_worker wakes up while the lock is dropped, it sees
ring->started is still true. For Downlink channels, mhi_ep_process_ch_ring()
skips the state check and fires xfer_cb() directly:

drivers/bus/mhi/ep/main.c:mhi_ep_process_ch_ring() {
    if (ring->ch_id % 2) {
        /* DL channel */
        result.dir =3D mhi_chan->dir;
        mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
    } else {
    ...
}

Could this execute xfer_cb() mid-teardown and cause a use-after-free?

> +
> +		if (mhi_cntrl->flush_async)
> +			mhi_cntrl->flush_async(mhi_cntrl);

[Severity: High]
Does this order of operations allow successful data delivery callbacks after
disconnecting the client?

Since the channel lock is dropped, completing in-flight DMA operations duri=
ng
flush_async() will invoke their completion handlers. Those handlers find
xfer_cb still populated and call it with a success status.

Should flush_async() be called before sending the -ENOTCONN disconnect
status to avoid notifying the client after it may have freed its contexts?

> +
> +		mutex_lock(&mhi_chan->lock);
>  		mhi_chan->xfer_cb =3D NULL;

[Severity: High]
This is a pre-existing issue, but is there a data race when clearing xfer_cb
concurrently with completion handlers?

In mhi_ep_read_completion(), the callback is checked locklessly:

drivers/bus/mhi/ep/main.c:mhi_ep_read_completion() {
    if (mhi_chan->xfer_cb) {
        ...
        mhi_chan->xfer_cb(mhi_dev, &result);
    }
}

If mhi_ep_remove() clears mhi_chan->xfer_cb to NULL after the lockless check
but before execution, could this result in a NULL pointer dereference or
execution of freed memory?

>  		mutex_unlock(&mhi_chan->lock);
>  	}
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
[ ... ]
> @@ -164,6 +165,7 @@ struct mhi_ep_cntrl {
>  	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_inf=
o *buf_info);
>  	int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_inf=
o *buf_info);
>  	int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_in=
fo *buf_info);
> +	void (*flush_async)(struct mhi_ep_cntrl *mhi_cntrl);

[Severity: High]
Does the flush_async callback need a channel argument to avoid flushing
all channels on the controller?

When mhi_ep_remove() calls this without specifying a channel, an
implementation like pci_epf_mhi_edma_flush_async() terminates the shared
DMA channels indiscriminately:

drivers/pci/endpoint/functions/pci-epf-mhi.c:pci_epf_mhi_edma_flush_async()=
 {
    dmaengine_terminate_sync(epf_mhi->dma_chan_rx);
    dmaengine_terminate_sync(epf_mhi->dma_chan_tx);
}

Will this abruptly discard in-flight operations and cause data loss for all
other active MHI clients sharing the controller?

[Severity: Critical]
This is a pre-existing issue, but is a similar flush required in
mhi_ep_ring_reset() before freeing the ring cache?

When the host issues a reset command, mhi_ep_ring_reset() executes:

drivers/bus/mhi/ep/ring.c:mhi_ep_ring_reset() {
    ring->started =3D false;
    kfree(ring->ring_cache);
    ring->ring_cache =3D NULL;
}

If in-flight asynchronous DMA operations complete after this,
mhi_ep_read_completion() unconditionally accesses the freed cache:

drivers/bus/mhi/ep/main.c:mhi_ep_read_completion() {
    struct mhi_ring_element *el =3D &ring->ring_cache[ring->rd_offset];
    ...
}

Could this cause a NULL pointer dereference when a remote host triggers a
channel reset?

> =20
>  	enum mhi_state mhi_state;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-mhi-ep-flu=
sh-v1-0-714e0d56e87c@oss.qualcomm.com?part=3D2

