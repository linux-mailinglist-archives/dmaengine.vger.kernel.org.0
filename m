Return-Path: <dmaengine+bounces-11140-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nkZ/CqOeH2pJoAAAu9opvQ
	(envelope-from <dmaengine+bounces-11140-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:25:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7A633E3E
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:25:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V2QvhQjW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11140-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11140-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74BE83008E2C
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C173F0762;
	Wed,  3 Jun 2026 03:25:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401301C84BB
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:25:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457119; cv=none; b=DdUugpX8aC/y0NMQB/2qJ8RfzMMQfyXjqYOlOEyBvpbCqBPWYpD5hHRNOnLuMD1D96phKDVugB4GPnKPTQKZH3AtUu3X1yr5kwSB/myrs88c0F+wmgJa6ILwaxVRWWwvroWtxx5d4e95Jwj3leK8PocEUvtJeRyEnTSzHGNqC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457119; c=relaxed/simple;
	bh=F1NNEbDFvlrh5A1rcwLzJ23MLTVsy7dBNFXgcUYE7yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kR2DeV2Dk7HUxsz0J39ZElubCjWCODEb5NnBSOS24W128BfBHlirsAHCdlg1UUSTdCem6LnaE26Iogzd6AFr2RF5dhnN+QlO8xvYSKI/TRPttorm2y3kVeO2hWeGjCVi7kcQo6KW+tTyFmXpJsEBeDVAoBBGmkH5GpIu/VCoA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2QvhQjW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A613C1F00893;
	Wed,  3 Jun 2026 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780457117;
	bh=yZT7NEJHizJPDlyN7AkKvUtU4j+tTf/IfmO7Fc2UCpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V2QvhQjW7Bp5+OmOBJZ9+x1XXncdzCzNDZhttaRpfDHvnitBQg7muyNvUCFZx3CbB
	 6G0vY1Ws/EKIrJ3yzSZl5+y0U49Bon7lqecEqohkSM9h+WBC6iQslF2B1Qt55xRMNv
	 gJPd22q9brkOeMrabCB2tCrwYi7mmJbrJM5apT9YJXPGVSanz1MBICVuUKdX9tYgnB
	 hyZ7Uomu/zhgfYGqXo+EzLbRuXaXVK4PL/wOO/VN6U5jeyLArUG4ZokIJeJbnTBu5s
	 ZNaElbporsTZbg/0TtgD6xA/2tAWQKyrxORKC0wbtd+CNjH/BoxIiEw7I/eOiC88cy
	 OM5MQRJd9yeVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 4/8] dmaengine: ti: omap-dma: stop channels during
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260603030754.288757-5-rosenp@gmail.com>
References: <20260603030754.288757-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 03:25:17 +0000
Message-Id: <20260603032517.A613C1F00893@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11140-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FF7A633E3E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-after-free on `od->desc_pool` during driver teardown.
--

commit cb697a8a2b4f2a6d911676cfaf5fc92a182d4653
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: stop channels during teardown

omap_dma_free() removes channels and frees their storage without first
stopping an active transfer. This patch terminates each channel before
removing it, and drains the virt-dma resource lists before freeing the
channel structure.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..3ed2e8d91ba6d 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1520,8 +1520,10 @@ static void omap_dma_free(struct omap_dmadev *od)
>  		struct omap_chan *c =3D list_first_entry(&od->ddev.channels,
>  			struct omap_chan, vc.chan.device_node);
> =20
> +		omap_dma_terminate_all(&c->vc.chan);
>  		list_del(&c->vc.chan.device_node);
>  		tasklet_kill(&c->vc.task);
> +		vchan_free_chan_resources(&c->vc);
[Severity: High]
Does this code introduce a use-after-free regression during driver teardown?

Looking at omap_dma_remove(), the dma pool is explicitly destroyed before
omap_dma_free() is called:

omap_dma_remove() {
    ...
    if (od->ll123_supported)
        dma_pool_destroy(od->desc_pool);

    omap_dma_free(od);
}

This new call to vchan_free_chan_resources() actively drains the virt-dma
resource lists, which invokes the driver's descriptor freeing callback,
omap_dma_desc_free(), for any pending or reusable descriptors.=20

If a descriptor uses linked lists, omap_dma_desc_free() will attempt to
free it to the pool:

omap_dma_desc_free() {
    ...
    if (d->using_ll) {
        ...
        dma_pool_free(od->desc_pool, d->sg[i].t2_desc,
                      d->sg[i].t2_desc_paddr);
    }
}

Since od->desc_pool has already been destroyed, will this result in a
use-after-free when dma_pool_free() is called? Should the dma pool be
destroyed after omap_dma_free() completes?

>  		kfree(c);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603030754.2887=
57-5-rosenp@gmail.com?part=3D1

