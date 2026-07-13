Return-Path: <dmaengine+bounces-12418-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8n62JIMeVWq7kAAAu9opvQ
	(envelope-from <dmaengine+bounces-12418-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:21:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2074DF63
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mDwcRNnj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12418-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12418-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBC393025F7B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF072D3225;
	Mon, 13 Jul 2026 17:21:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1D276050;
	Mon, 13 Jul 2026 17:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963265; cv=none; b=GoigQeNQIxwQbzoNGMzFPOfpQ4qQyps6+nZiwh6Rhr/aEm6Lf8/k8SCDWzVUhXSl17H3kepB4VwB9pmnZKqyg9vZ3y+gzoBLQtVdTTqeBIVO6PC5MFj0l3kUEQqnfNZU7/6/+XmhQ69l2m1YoKHoMiIoQpJS78ufxi/fJT7j/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963265; c=relaxed/simple;
	bh=xvrIkZmn8PzsKxruEtr0meVc3epM8XJ25bxGn/oaUEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EeTJZMfNydEeTRX+8FYASrJ2uf6OGtl5EoDRpdKZm/8c2ncPGkGg0yujXl8OGNfikcTuW12KRebyEzaPuotmkBKECcpSfxVlZ5uB401wcbk/3DLCJRyB3tQ61ssffxzkgT9neJJbJmwl68uLhd2clfaJ9grSjzgP00EfijimsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDwcRNnj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A9C1F000E9;
	Mon, 13 Jul 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963263;
	bh=sidqgmLzcWmTpWAkypaI1hkVDALPM7nQ6+fZAZ+5TmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDwcRNnjYzaxoy9iEeayLD6AKIkRWyk3pSBhJpl8oYbqbNwamjNUyn/XDa4su0cvk
	 /oo893kl6nO0uKlCKHhz+K0H3ND1K61NgO/ZN/GRoJlLwTwehx6cPAE309AM2kspAw
	 ia1QN0+Wf4gNvwg3ryEXiyHWo0RNBvrbXc+cGzRq0LbsoehaxD9m/H2CoAhcGVmiJW
	 c4fEPgY/zUUqcK5fK4YONYED3+TJukwxehIRWofFntgAhPvAVERID/DdWAu8Syj4jm
	 AQgFawkt+e2DBE0nexEy9TTmrsUyQdBTpFI92cecTrn+M7kGc7wDLLT2DggOJEVd4A
	 nbJtyVbK1ZVlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260713-edma_ll-v7-8-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-8-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:21:02 +0000
Message-Id: <20260713172103.25A9C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12418-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDC2074DF63

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `dw_edma_start_transfer()` and modifying channel status fr=
om `dw_edma_device_resume()` without holding the virtual channel lock.
--

--- Patch [8]: [PATCH v7 08/10] dmaengine: dw-edma: Use common dw_edma_core=
_start() for both eDMA and HDMA ---
commit 44d14981017ae5dfd9faba4190eb71b1ca628fdb
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
   =20
This commit consolidates the start routines for eDMA and HDMA into a single
dw_edma_core_start() function. It removes the separate .start() callbacks
from both eDMA and HDMA implementations.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 2652ad8e7a8f6..f52d9fd18e573 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan=
 *chan)
>  	if (!child)
>  		return 0;
> =20
> -	dw_edma_core_start(dw, child, !desc->xfer_sz);
> +	dw_edma_core_start(child, !desc->xfer_sz);
>  	desc->xfer_sz +=3D child->xfer_sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);

[Severity: High]
This is a pre-existing issue, but is there a race condition when calling
dw_edma_start_transfer() from dw_edma_device_resume() without holding the
virtual channel lock?

When a client calls dmaengine_resume(), dw_edma_device_resume() updates
chan->status and calls dw_edma_start_transfer() without acquiring
chan->vc.lock:

static int dw_edma_device_resume(struct dma_chan *dchan)
{
    ...
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}
    ...
}

Once the hardware is started via dw_edma_core_start(), a completion interru=
pt
can fire immediately if the chunk completes quickly or encounters an error.
The interrupt handler dw_edma_done_interrupt() acquires chan->vc.lock, chec=
ks
that the channel is not paused, and calls dw_edma_start_transfer() again.

Because dw_edma_device_resume() does not hold the lock, both threads could
concurrently fetch the same chunk, start the hardware, and execute
dw_edma_free_burst() and list_del().

Can this lead to a double-free of the burst structure and list corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D8

