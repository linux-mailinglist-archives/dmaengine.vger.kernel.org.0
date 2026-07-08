Return-Path: <dmaengine+bounces-12144-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C11HNMubTmpPQgIAu9opvQ
	(envelope-from <dmaengine+bounces-12144-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:49:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71C729B3B
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:49:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SI3eZIkp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12144-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12144-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11713006B4E
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5423BB9EB;
	Wed,  8 Jul 2026 18:49:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002237C0F9;
	Wed,  8 Jul 2026 18:49:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536585; cv=none; b=SBydCc6bOGf+oM3z0dcPYGnmU+Wxv+DIbxUgS4lPn1r77gH0jxT0NvfTIE8qYfeGwZb0yZNMOAJtztsj09+xZYb75JWu03DRY2avQVGfMb7kIkB11y/MInWEmEgqKLaWS58DNbfuKzbUl2Av3xQ2HZBR3qkb8lfIKO6lPw0ALzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536585; c=relaxed/simple;
	bh=5PhGChqIPPMQp4xWjFpFYC8kIzuuSx7QXn62O7lXvVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5itg5ip61DsyBOWUu0+p73Wf33CFa4AZmK7HZSo89aR6IqrOEQj1/IKeTKiASj5Z15eCcKAXkODCu/7+at2ubbp8GKjhVHVJ8rSe9lrLLxfEtnM8jRV+pJ+Q0MYtRXlp/tTBOsijbhioKWcac6FGQY48b7Mp+JzHGGMMwPyc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI3eZIkp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F171F000E9;
	Wed,  8 Jul 2026 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536584;
	bh=Cty63/z88jEVhceG7935CFPE1q5l+K61l51l9Ne/4sI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SI3eZIkp24SpkjbKnxmQZQRlPh2+zPOVZtQ0tsF2bY3h1JMvzEzf7KZHSu/JZld78
	 YERY0P1btChAdL77rDo9YqX+KUC8xuMI1/L8uXOgyDDApFhwYPTGSmiAlCKH0DF8B5
	 RGI8ODi2s5e1DzgQsOU0UWRDAbvb2G99aYRTxXu/VNNP67BZ8ZQB6E2X4Kt1W89f1K
	 iXQTEPUlElvCde3POw/PYdpYA6G46FqspNY3UoZqW+6YFt+qd0adFXtsHCUK09p1mI
	 wziiF4gshLjC94e/lE9nbArQGxJcQza322AGW4JYmki+q9nLzt158+Yj/c6ivh9r+j
	 XPXMulcl/2Ggg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260708-edma_ll-v4-9-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-9-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:49:43 +0000
Message-Id: <20260708184943.99F171F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12144-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,nxp.com:server fail,lists.linux.dev:server fail,smtp.kernel.org:server fail,sashiko.dev:server fail,sto.lore.kernel.org:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E71C729B3B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Multi-burst transfers in non-LL (non-Linked-List) mode will silent=
ly hang because bursts are incorrectly grouped, leading to hardware program=
ming being bypassed.
- [High] Early termination of scatter-gather iteration leaves uninitialized=
 bursts in the pre-allocated chunk array, leading to zero-filled descriptor=
s being submitted to hardware.
--

--- Patch [9]: [PATCH v4 09/10] dmaengine: dw-edma: Use burst array instead=
 of linked list ---
commit baa518039c3b11326baa6f39333dddc50d2d6b4f
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary. Allocate a burst array when creating each chunk to simplify the
code and eliminate one kzalloc() call.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er,
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;

[Severity: High]
If this loop breaks early, chunk->nburst retains the pre-allocated max
size (n) without being updated to match the actual number of populated burs=
ts.

Will the subsequent hardware programming loop in dw_edma_core_start()
iterate up to the unadjusted chunk->nburst, inadvertently submitting
zero-filled descriptors and setting the completion flag on the wrong burst?

> =20
> -		if (chunk->bursts_alloc =3D=3D bursts_max) {
> -			chunk =3D dw_edma_alloc_chunk(desc);
> +		if (!(i % chan->ll_max)) {
> +			u32 n =3D min(cnt - i, chan->ll_max);
> +
> +			chunk =3D dw_edma_alloc_chunk(desc, n);

[Severity: High]
The previous code used bursts_max to limit chunk sizes here, restricting
non-LL mode transfers to 1 burst per chunk. This new chunk sizing logic
unconditionally allocates up to chan->ll_max.

For multi-segment non-LL transfers, will chunk->nburst now exceed 1?

If so, when dw_edma_core_start() runs:

    if (chan->non_ll) {
        if (chunk->nburst =3D=3D 1)
            chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
        return;
    }

Might this cause the function to silently return without starting the
hardware, permanently hanging the transfer?

>  			if (unlikely(!chunk))
>  				goto err_alloc;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D9

