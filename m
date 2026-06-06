Return-Path: <dmaengine+bounces-11255-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wFvfBV1oI2potAEAu9opvQ
	(envelope-from <dmaengine+bounces-11255-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:22:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790464BFFC
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=avy6G10z;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11255-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11255-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 731913014C54
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE721EB19B;
	Sat,  6 Jun 2026 00:22:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451C199385;
	Sat,  6 Jun 2026 00:22:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705370; cv=none; b=hAnUxdYxEwVQ2iM4dEoChB4tE+fF+NzUxT2UjXxikMrCCt0hpoPkOTp+bty09i8oXT93RdpcWK72JiTFQbCDiyPPUM6IvHU2bIp729d0Zr7Euk8Al5UW+c4RJo2W113tLCHSSngHEk9J45du67Z84OEfIxvk3lDDD4RGQspEPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705370; c=relaxed/simple;
	bh=jB5iNEmDjf6EW9KcP+YJLwWKvrfcpWkMTGgIt7zKDpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=agw/JPybPQ0pQMm2yV10O+ChuS0QMzmN3NS2YF91PPQjYJI+IAT5GcTaCPXZOPTwJPXqAVor385HhGVvazeQREfkRvdiAanbX1eFjxJS2y2bJVJh9reVu+QWEl2SkLJ0UXPz2fWwl+AorU/L4c4Zhd+CB3t0uj8A/QWB4Gl+9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avy6G10z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA71F00893;
	Sat,  6 Jun 2026 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705368;
	bh=DBfD3CfCkfF8zT8GCRswpOw+X+oxnk7tG8v487CC6wQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avy6G10zMSnjoYj90qE15tlgdFSum+fBWgGmxi7iycVB7OgvKHJcRLpTYDzAH2wrp
	 sILHQ2lqxNWErZ0b5Nfru1iv2xoOtoVff0pcg1VXDUTfyQ/lHEFYcHgd9/WtCiPBPl
	 9ky/BfK+ezvaLb93gfVa3LMggGkv5FAuQvxdlNMRAmKVgytpqTPgrEq031HhLTGG9I
	 vvtKHXki4tsHIhB9GFieE7XdXMdJCbnsgIJbFfMek8dH1H5EFeK5ybkpkqxrsXFVpO
	 fmpiw3T/Zw4TzJyp+I8+EgfCoWBinZH3pInlVs3IdIH7hLwobOxWv7jinyySfDh647
	 IYI1HWz1ioVzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/23] dmaengine: sdxi: Provide context start and
 stop APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-19-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-19-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:22:48 +0000
Message-Id: <20260606002248.8BDA71F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,amd.com:email,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url];
	TAGGED_FROM(0.00)[bounces-11255-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7790464BFFC

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Silent failures in `sdxi_stop_cxt` do not stop the hardware bu=
t provide no error to the caller, leading to subsequent use-after-free of c=
ontext resources.
- [High] DMA memory use-after-free triggered by `sdxi_completion_poll` time=
out in `sdxi_start_cxt` and `sdxi_stop_cxt`.
--

commit 6a36436cc92c4877bfb050c28457f1ac8dbaf6a2
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Provide context start and stop APIs

This commit introduces high-level context start and stop APIs for SDXI.
These APIs encapsulate submitting administrative descriptors and waiting
for completion signaling.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 9b0984842d9a7..afd3414163428 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> +int sdxi_start_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm =3D to_admin_cxt(cxt);
> +	struct sdxi_desc *desc;

[ ... ]

> +	sdxi_completion_attach(desc, sc);
> +	sdxi_desc_make_valid(desc);
> +	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
> +
> +	return sdxi_completion_poll(sc);
> +}

[Severity: High]
If sdxi_completion_poll() times out here, does this return early and
trigger the scope-based cleanup of the sdxi_completion structure?

If the hardware operation is just delayed and not actually aborted, could
the hardware later write to this completion block address after it has
been freed back to the DMA pool?

> +void sdxi_stop_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm =3D to_admin_cxt(cxt);
> +	struct sdxi_desc *stop, *sync;
> +	struct sdxi_ring_resv resv;
> +	int err;
> +
> +	might_sleep();
> +
> +	struct sdxi_completion *sc __free(sdxi_completion) =3D
> +		sdxi_completion_alloc(cxt->sdxi);
> +
> +	if (!sc)
> +		return;

[Severity: Critical]
Since sdxi_stop_cxt() returns void, do these silent early returns leave
the caller unaware that the hardware context was never actually stopped?

If a caller proceeds to tear down the context and free its backing
descriptor ring and memory, could the active DMA engine continue processing
descriptors and corrupt memory?

> +	/* This is not how to stop the admin context. */
> +	if (WARN_ON(adm =3D=3D cxt))
> +		return;
> +
> +	err =3D sdxi_ring_reserve(adm->ring_state, 2, &resv);
> +	if (WARN_ON_ONCE(err))
> +		return;

[Severity: Critical]
Similarly, if reserving space in the admin ring fails here, the function
returns silently without stopping the hardware. Could this lead to the same
scenario where context memory is freed while still in use by the hardware?

> +	stop =3D sdxi_ring_resv_next(&resv);
> +	sync =3D sdxi_ring_resv_next(&resv);

[ ... ]

> +	sdxi_completion_attach(sync, sc);
> +	sdxi_desc_make_valid(stop);
> +	sdxi_desc_make_valid(sync);
> +	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
> +
> +	WARN_ON(sdxi_completion_poll(sc));
> +}

[Severity: High]
Just as in sdxi_start_cxt(), if the poll function times out here, does the
early return free the in-use DMA memory without aborting the pending DMA
stop/sync operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D19

