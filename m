Return-Path: <dmaengine+bounces-12007-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dnloHWDaRmqBegsAu9opvQ
	(envelope-from <dmaengine+bounces-12007-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:38:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A236FCFF1
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cogDiINP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12007-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12007-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FDB53028E9A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117238D3E6;
	Thu,  2 Jul 2026 21:38:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE93537F1;
	Thu,  2 Jul 2026 21:38:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028316; cv=none; b=Qad+5B3s9WVW0BMJkT75BQIwMQOhhVbaLY+6YSkVer4xGX7qx/Hk1TIIWUbPOHb2X6eKSlf4T2T78SZK3Cfw0NgrrITehYtva6qnJlkDRAzWisOxLnb9F5bCQ0YfU99r0vBszpiDCW5ocAuUW3ibwaSjk+7n01d0sgj4z7HqRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028316; c=relaxed/simple;
	bh=OTvzDYUsVwigoZSqQ0GISaeTjkoHnvZWm07IMiN2u8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=peT9QAxVm3oycJhkFZ6cPSyhAwNsvMWRv4YuddBd0QOxQS9Wy1JpyPFsVU5FM8KIXhtbxlxkOSP1eabEc621jEQRvPYLFUnYoex9mUiyGCeL7uas1HN5fPig++pVjT3LOEYbhkPIQoqABdYC2DZMtRad92xDoME+YDypW50uk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cogDiINP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32741F000E9;
	Thu,  2 Jul 2026 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028315;
	bh=LyHhZo57THnUrt8CNkWSH+apbalRn9ITY43r465vq7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cogDiINPgPdPK1fGXvChnSeAdsfgnEDI3Xr4+AkfC8ik/c1LVcZcvCqMWf3Fs1tKB
	 5BlfMhygxm28tdgaxtVFZVEZHXW8Xz/P1MUlC4DjAXH6YF3XGsmiCjxKoxoR11icMa
	 YnanMSmkNa0ksPwqX8qPro9TA962JEzrqjcLmUflWgC/FXcS6YY7Fcgwp5LY1rgXeD
	 NtsC9FvmDntZfj+99g4eCmD+M9wF/xo1A/CCVcRTomGnF/4hD7VF2HVsg0JBFnLR8+
	 uMBLiTV/I34X4NLzuPXASxHmXA98SnpiNUB711zJhe0JMOfEHEAMWivmXSAtpEm0YB
	 WhyTomZgrVtcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702-edma_ll-v3-8-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-8-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:38:34 +0000
Message-Id: <20260702213834.E32741F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12007-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.103.45.18:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12A236FCFF1

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The implementations of the `.ll_link` callback silently ignore the =
`addr` parameter.

Pre-existing issues:
- [High] dw_edma_device_resume calls dw_edma_start_transfer without holding=
 the virtual channel lock, leading to a data race.
--

commit a71d48f7b78a779048479e64e69c2bb3e5bf67b9
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA

The commit removes the .start() callback functions for eDMA and HDMA
and consolidates them by using a common dw_edma_core_start() function
for both engine types.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 2652ad8e7a8f6..f52d9fd18e573 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -163,9 +163,37 @@ static void vchan_free_desc(struct virt_dma_desc *vd=
esc)
>  	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
>  }
> =20
> +static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan =3D chunk->chan;
> +	struct dw_edma_burst *child;
> +	u32 i =3D 0;
> +	int j;
> +
> +	if (chan->non_ll) {
> +		child =3D list_first_entry_or_null(&chunk->burst->list,
> +						 struct dw_edma_burst, list);
> +		if (child)
> +			chan->dw->core->non_ll_start(chunk->chan, child);
> +		return;
> +	}
> +
> +	j =3D chunk->bursts_alloc;
> +	list_for_each_entry(child, &chunk->burst->list, list) {
> +		j--;
> +		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> +	}
> +
> +	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);

[Severity: Low]
Does the underlying implementation of .ll_link actually use the address
parameter passed here?

Looking at dw_edma_v0_core_ll_link() in dw-edma-v0-core.c, it appears to
ignore the addr parameter entirely and hardcodes chan->ll_region.paddr:

static void
dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 ad=
dr)
{
	...
	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
}

The same seems to be true for dw_hdma_v0_core_ll_link(). While it currently
works because chan->ll_region.paddr is explicitly passed, would this cause
silent failures for any future callers attempting to pass a different addre=
ss?

> +
> +	if (first)
> +		dw_edma_core_ch_enable(chan);
> +
> +	dw_edma_core_ch_doorbell(chan);
> +}
> +
>  static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  {

[Severity: High]
This is a pre-existing issue, but does dw_edma_start_transfer() race with
other contexts when called from dw_edma_device_resume()?

In dw_edma_device_resume(), dw_edma_start_transfer() is called without hold=
ing
the virtual channel lock:

static int dw_edma_device_resume(struct dma_chan *dchan)
{
	...
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}

	return err;
}

However, dw_edma_start_transfer() subsequently accesses the virtual channel
list through vchan_next_desc(), which expects chan->vc.lock to be held. Can
this lead to list corruption or data races if another thread concurrently
calls dw_edma_device_issue_pending() or if an interrupt is being processed?

> -	struct dw_edma *dw =3D chan->dw;
>  	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D8

