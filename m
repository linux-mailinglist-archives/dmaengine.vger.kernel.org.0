Return-Path: <dmaengine+bounces-10938-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGgOCHidFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10938-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:17:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE925D63FC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA4213672A1F
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5A199FAC;
	Tue, 26 May 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCQ7OedJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5B3FADF2
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800763; cv=none; b=oPu5VnPKFCUkouCAeZ+ysBLUKR+ddiy4UtgOCiZDJ+6vT7wEaZibEA0KHzfUrRb0ZUlcNBwVGISLG3mTGb0ymindrprRq16/LqvQLzG070f5WKqtBOMfyaB11PxkJGCFvRd0w8h28BiZ53dBENf1RlV+SxTWFlU2TC8pzca3zMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800763; c=relaxed/simple;
	bh=rUpfLx3JFBmn+bHpIzxTVlaJrN82ncwNSkZC4RExHl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDTx8EH4vbAcG5j6b7KTh37yvkS3cQoKXzcHu8f99XJOU1rIQfUNBIOD0UFS/B3EX+u8ySTWwr63AVOvNSJdmwDr7NEdlnT4g1sVBJ8svmwJ32iHlXZwTrh8LAq4urKtgvqyD/ayTOeU37213FKVOFdl+igDYZjIkolp4p2ztao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCQ7OedJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FC61F00A3A;
	Tue, 26 May 2026 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800761;
	bh=kYVqK+aaQY9XUfKW3lnIfiqtZrZwoiVK0097DrEb0zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCQ7OedJou/xkn4R1WwlsaiHayF4TPau6QKs+KKFSpciYnjw2spSNG6UjSQuB4PaG
	 5D3ywEhZQHcaKPVqEIxz/tnyixFOLp/eB8WWR5GHfBZr6cOT5BqQJVP5Cs3hd7WP9v
	 M6Q16PW5+GwSz1ZMVuorUXwN8/k+XKbIO9qn+sWJ3RKzcNqK68O6rym1cVBtmyxXFy
	 4FFpIKdZjTXs/zpaIzfTV+Eb5ppDQTKlrkv/PF81iv3qKF0mk0eYo48tXcpggwpKHb
	 001AXXTauoTEbx/iEMPMviNS65Ax/rBw414/oFZuLqbozke1EKFrHEH1mNcuHqsqA5
	 NuyMv//pHmXvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: fix use-after-free in dma_chan_put()
 and dma_release_channel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260526-dmaengine-kref-fix-v2-2-3df60afac01d@amd.com>
References: <20260526-dmaengine-kref-fix-v2-2-3df60afac01d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:06:00 +0000
Message-Id: <20260526130601.89FC61F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10938-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,amd.com:email]
X-Rspamd-Queue-Id: 9EE925D63FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free in dmaengine_put() during channel iteration.
- [Critical] Use-After-Free in dma_release_channel() after forceful DMA pro=
vider unbind.
--

commit 5c65161b4e60f0575ac687342210c12a79a7958e
Author: Shivank Garg <shivankg@amd.com>

dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()

This commit resolves use-after-free bugs in the DMA engine channel
management by caching the module owner prior to releasing channel
references and reordering the cleanup in dma_release_channel().

Link: https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d612=
5048fb7@amd.com

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 605bfa477a004..9c4e206f24686 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
[ ... ]
> @@ -518,7 +521,7 @@ static void dma_chan_put(struct dma_chan *chan)
>  	/* This channel is not in use anymore, drop the device ref */
>  	if (!chan->client_count)
>  		dma_device_put(chan->device);
> -	module_put(dma_chan_to_owner(chan));
> +	module_put(owner);
>  }

[Severity: Critical]
This is a pre-existing issue, but can this lead to a use-after-free
regression during channel iteration?

If list_for_each_entry() iterates over a device's channels in
dmaengine_put():

dmaengine_put() {
    list_for_each_entry(chan, &device->channels, device_node)
        dma_chan_put(chan);
}

When dma_chan_put() drops the final client_count reference, it triggers
dma_device_put(), which can free the device and its embedded channels via
dma_device_release().

When execution returns to the loop macro, evaluating chan =3D list_next_ent=
ry()
would dereference the freed chan->device_node.next pointer. Even
list_for_each_entry_safe() appears insufficient here since the list head is
also inside the freed device.

[ ... ]
> @@ -924,6 +926,7 @@ void dma_release_channel(struct dma_chan *chan)
>  	kfree(chan->dbg_client_name);
>  	chan->dbg_client_name =3D NULL;
>  #endif
> +	dma_chan_put(chan);

[Severity: Critical]
This is a pre-existing issue, but can this code trigger a use-after-free
regression if a DMA provider is forcefully unbound?

If a provider is unbound via sysfs while clients hold channel references,
dma_async_device_unregister() iterates over channels and unregisters them:

__dma_async_device_channel_unregister() {
    ...
    device_unregister(&chan->dev->device);
}

This drops the reference to chan->dev and frees it without setting the
pointer to NULL.

Later, when the client driver closes the channel via dma_release_channel(),
it calls sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME) before
reaching the dma_chan_put() call.

Will this dereference the dangling chan->dev pointer?

>  	mutex_unlock(&dma_list_mutex);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-dmaengine-=
kref-fix-v2-0-3df60afac01d@amd.com?part=3D2

