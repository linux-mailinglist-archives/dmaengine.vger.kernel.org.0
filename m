Return-Path: <dmaengine+bounces-12419-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fhs7LroeVWrGkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12419-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:22:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0320474DF8B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QRRWgYTC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12419-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12419-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67FEC300B82C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A911346ADE;
	Mon, 13 Jul 2026 17:21:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FF347536;
	Mon, 13 Jul 2026 17:21:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963313; cv=none; b=XxoDPbmbm9jhIls1xK7PIw/J9HH69+08ccqIwn8c68b1M6eEOjpPnDcAWDFzZninFLoe7zzB92Bc96rxZPYsreFWj6sLMsCgoS9i2tDt2qJWkm7o2q1sFDMS5XVfK71iOmfKVOPxFtTml06ozwDflrjAlfL0ip5q91LE/I7xYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963313; c=relaxed/simple;
	bh=VaunfQ/e6sC9NCGkubdy6D49j/TN9tYTme1o0ulMURo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/2r5b5ahO/xdGl4FJqbhCVTbPkqGwrqAOSJvZN+J95Rge8tmFanHmiIytN4r+LFo9h2/O94sgztAzj26VMI521Dt0e0804Ylm9M2Uxaak38gVbzuqH/xcrMPsuyAcABS/u8dWsy8B0cWyyrc+kzl+rp/LRb0TaoTycRc5qgc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRRWgYTC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B8A1F000E9;
	Mon, 13 Jul 2026 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963311;
	bh=KtzniS4S2SEveFRnCWgspZpvD/ummeoQ7/M85E9eZzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRRWgYTCprOVDFCpEv28cEBn0orhAvt1bZ4WpA8y4dBDH8PKoZU1EIGsyxM5BH1X1
	 wdmBNtwij2ybdjCXOwOMmjGZdcZ8Z4cyXQFtrSSO4yzyYT/Ozn++LBW5xC1AR8cbKC
	 IUd55ShbUtczWGvTcSV6ccRcQX6NOyBrX0KrRoSKT2/FYwayYkHZDp07gUQOpZ1Fdo
	 m9L/uD6V85Ga09PryWb/XZaJ22wEJwIwSGMEEK+gNopuHwTKtyoN1MWnKcYrK1Zpru
	 8J9aEOJZSIWOG0/WQDF0IxE7zYitKhiFj50orfTNw/Q6GrVK26feiEqtaxtNCkPe6w
	 Jw0VMgpiVNWdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-7-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-7-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:21:50 +0000
Message-Id: <20260713172151.65B8A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12419-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0320474DF8B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The first burst and chunk are systematically ignored and dropped d=
uring DMA transfers, causing transfers to silently fail.
- [High] Data race and list corruption due to accessing channel state and v=
irt-dma structures without holding the `chan->vc.lock`.
--

--- Patch [7]: [PATCH v7 07/10] dmaengine: dw-edma: Add non_ll_start() call=
back ---
commit 7dc5c95dae459bfa0e6a411b33405e84c6e8c394
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add non_ll_start() callback

This commit adds a non_ll_start() callback and moves common non-linked-list
channel handling into the EDMA core so it can be shared by both EDMA and
HDMA. It also prepares for the upcoming reorganization of the burst and chu=
nk
structures.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index bab4d49c92feb..e18d6e827c2c9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
[ ... ]
> @@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, =
enum dw_edma_dir dir,
>  static inline
>  void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk,=
 bool first)
>  {
> -	dw->core->start(chunk, first);
> +	if (chunk->chan->non_ll) {
> +		struct dw_edma_burst *child;
> +
> +		child =3D list_first_entry_or_null(&chunk->burst->list,
> +						 struct dw_edma_burst, list);

[Severity: High]
This isn't a bug introduced by this patch, but does this skip the first bur=
st?

The driver implements linked lists by treating the first allocated element's
list member as the head of the list for subsequent elements, instead of usi=
ng
a standalone struct list_head. When standard Linux list macros like
list_first_entry_or_null() are used on &chunk->burst->list, they
automatically skip the head node.

If only one burst is allocated in non-LL mode, would this return NULL and
silently skip starting the transfer?

> +		if (child)
> +			dw->core->non_ll_start(chunk->chan, child);
> +	} else {
> +		dw->core->start(chunk, first);
> +	}
>  }

[Severity: High]
This is a pre-existing issue, but can data races and list corruption occur
due to accessing channel state and virt-dma structures without holding the
chan->vc.lock?

For example, when calling dmaengine_resume() on a DMA channel, the driver's
dw_edma_device_resume() calls dw_edma_start_transfer(). This reads from the
virt-dma lists without holding chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
    chan->status =3D EDMA_ST_BUSY;
    dw_edma_start_transfer(chan);
    ...
}

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_start_transfer() {
    ...
    vd =3D vchan_next_desc(&chan->vc);
    ...
}

Concurrently, dw_edma_done_interrupt() handles completed descriptors and
modifies the same lists under vc.lock, causing a direct data race.

Additionally, dw_edma_device_terminate_all() mutates chan->request and
chan->status locklessly.

Could this lead to list corruption or kernel panics when racing with
interrupt handlers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D7

