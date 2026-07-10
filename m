Return-Path: <dmaengine+bounces-12303-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o45iNrqtUGpZ3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12303-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:30:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FED7387E9
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fVr80+8K;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12303-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12303-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795083087BA6
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640353EFFB2;
	Fri, 10 Jul 2026 08:26:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696A3EFD14
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 08:26:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672014; cv=none; b=ntu8mmzGI0UTY7ZRBltTNlHkQ1dxpfolJ8Or7DdA+KOzP6kn+l8arIXHBMedL5Wf30g0BGmeMFqNJrNX9q/CmqT/lslihh3JTqUReKYb1xCBUqNw6b47u73HYdWGMSZeyC4rX/+udUvxN3hYXslYuAREqAtT9X0IP2s39RET5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672014; c=relaxed/simple;
	bh=3ZJlb3n0FHDsncSzBw8WBSNWiF98l9Jqs0uDzUd/z74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EoxkfdEOQ+IUMY7ghHiYXidXzpcjeyz1HNtbXD4SVUw/BtAo8SnFweWWdc3jtNNfPsvrz/Fnv0fbwY70O1VGsUDC0ekO8eKbb5/NbPVR+LN3q4RCHlMgA8YptRlk4w8qVcQrNefw9EMzVIwftBwrs9wgbHQOM7kfyds+F/UYn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVr80+8K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524491F00A3D;
	Fri, 10 Jul 2026 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672012;
	bh=82mUp+fAs7Jt0revhrC/1h+8/onNy0pn+fHJOaMcepY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVr80+8KkuE0orokAT6Xi7HolBsVQ+z81kcds2xOZNvU8lIr1tKZOXEtcv8S73iV/
	 o6gmnUkD/2GYvPltOdN6GaumZk8ukVxOpIrojRZswu1Wa9740jHjmgTMTqAV4IbIWS
	 dILUYqs+oks/hky1fSo8QbkSoh9FnVYgi2BmoGRjJPBUSUMsgYV+J/RXyp/cKvemZc
	 rDyVX4t3zdwIsq6YbE134+ntlc5JFH2HwBXWOURdbCjxO9lUE0Ts5FEBBl/CxeJAYh
	 +zz0T37i/Z0I9gBNdpGw3uB/viUJ4+959ZKXAK55njb421NDHBKGEXVZMjBBA4yJv4
	 xmfLpJ0Cy2PLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] dmaengine: dw-edma: Terminate STOP requests without
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710080903.2392888-3-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:26:51 +0000
Message-Id: <20260710082652.524491F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12303-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,valinux.co.jp:email,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42FED7387E9

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incomplete synchronization in dw_edma_device_synchronize leads to =
memory corruption and descriptor leaks.

Pre-existing issues:
- [High] dw_edma_device_terminate_all fails to clean up pending virt-dma de=
scriptors.
- [High] Lockless state mutation in dw_edma_device_terminate_all causes per=
manent channel deadlock.
--

--- Patch [2]: [PATCH 2/7] dmaengine: dw-edma: Terminate STOP requests with=
out callbacks ---
commit 8726b379b2e15e03e4a564512f4646c2031734e5
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Terminate STOP requests without callbacks

This commit fixes completion handling for stopped descriptors by moving
them to the terminated list instead of scheduling callbacks, avoiding
potential use-after-free bugs. It also introduces a synchronize callback
to allow virt-dma to release the terminated descriptors.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -673,8 +680,7 @@ static void dw_edma_done_interrupt(struct dw_edma_cha=
n *chan)
>  			break;
> =20
>  		case EDMA_REQ_STOP:
> -			list_del(&vd->node);
> -			vchan_cookie_complete(vd);
> +			dw_edma_terminate_vdesc(vd);
>  			chan->request =3D EDMA_REQ_NONE;
>  			chan->status =3D EDMA_ST_IDLE;
>  			break;

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_terminate_all() clean
up pending virt-dma descriptors properly?

If a client queues multiple descriptors and terminates the channel before
completion:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
    ...
    } else {
        chan->request =3D EDMA_REQ_STOP;
    }

The driver sets chan->request =3D EDMA_REQ_STOP, but the interrupt handler
processes EDMA_REQ_STOP for a single active descriptor via vchan_next_desc(=
).

This appears to leave the remaining pending descriptors untouched in the
virt-dma queues, rather than clearing them out using
vchan_get_all_descriptors(). When the client later issues a new transfer,
won't these stale descriptors be executed unexpectedly and potentially
corrupt data?

[Severity: High]
This is also a pre-existing issue, but does dw_edma_device_terminate_all()
mutate channel state safely?

dw_edma_device_terminate_all() reads chan->status and writes chan->request
without holding chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
    ...
    } else if (chan->status =3D=3D EDMA_ST_IDLE) {
        chan->configured =3D false;
    ...
    } else {
        chan->request =3D EDMA_REQ_STOP;
    }

If dw_edma_done_interrupt() concurrently finishes a transfer, acquires the
lock, and sets chan->status =3D EDMA_ST_IDLE, could the following race occu=
r:

1. terminate_all reads chan->status as EDMA_ST_BUSY.
2. done_interrupt finishes, setting chan->status =3D EDMA_ST_IDLE and relea=
sing
   the lock.
3. terminate_all writes chan->request =3D EDMA_REQ_STOP.

The channel is now left with status =3D=3D EDMA_ST_IDLE and
request =3D=3D EDMA_REQ_STOP.

Will subsequent calls to dw_edma_device_issue_pending() silently refuse
to start new transfers because it requires chan->request =3D=3D EDMA_REQ_NO=
NE?

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_issue_pending() {
    ...
    if (vchan_issue_pending(&chan->vc) && chan->request =3D=3D EDMA_REQ_NON=
E &&
        chan->status =3D=3D EDMA_ST_IDLE) {
        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);
    }
    ...
}

[ ... ]
> @@ -856,6 +862,13 @@ static int dw_edma_alloc_chan_resources(struct dma_c=
han *dchan)
>  	return 0;
>  }
> =20
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +
> +	vchan_synchronize(&chan->vc);
> +}

[Severity: High]
Does vchan_synchronize() wait for the hardware transfer to actually stop?

If a client calls dmaengine_terminate_sync(), the driver asynchronously
requests a stop via chan->request =3D EDMA_REQ_STOP but doesn't halt the
hardware.=20

If this function only calls vchan_synchronize(), it will return immediately
because the descriptor is still running. The client might then free or reuse
the DMA buffer while the hardware is still writing to it, which could corru=
pt
memory.

Additionally, when the interrupt later fires, it will terminate the active
descriptor and add it to the terminated list:

        case EDMA_REQ_STOP:
            dw_edma_terminate_vdesc(vd);

Since vchan_synchronize() has already returned, won't this descriptor be
permanently leaked on the terminated list?

Should this wait until chan->status =3D=3D EDMA_ST_IDLE before calling
vchan_synchronize()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710080903.2392=
888-1-den@valinux.co.jp?part=3D2

