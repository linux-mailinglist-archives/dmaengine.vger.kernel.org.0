Return-Path: <dmaengine+bounces-12010-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMvOCsbaRmqiegsAu9opvQ
	(envelope-from <dmaengine+bounces-12010-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:40:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A66FD00A
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DFInOqzq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12010-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12010-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 223BB3025708
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0C39891F;
	Thu,  2 Jul 2026 21:40:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851138C2AA;
	Thu,  2 Jul 2026 21:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028417; cv=none; b=apekC1zg4p+WiVmMkMaWzQUklrPVdnhsJEnPtZ+v0gB30Ighlfiv4qO+J+DszCyusksNJC7YjqWYVK5i/16X/OhPRqmeJ1FoSfokL2I0pe/aoGllLSs+k8xs2z9QqrPMvXknFRQByur0ikVMPUmYpjrv/SR/AH8/usZP1qvPLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028417; c=relaxed/simple;
	bh=uQ0OI1LrVYlyIGYRdlOeSzV305Aoqq1Lipc5pXO3ESU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBtGqet+PtyGXOIb4wXKA+3Ro+7+XuwMBrWtYJuq3anX6LfsefC9hheF7c/i+sQ0zi/E78k9JZVgQymWYr2K+OwMS0cXjZ7bqWenVfJfTEjgDF2zOtnPVmkc/YB45MsI/pzZ10wdkRmwbZQAN3jo//OmUUTSs1S8Qmy1JRlQJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFInOqzq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79121F000E9;
	Thu,  2 Jul 2026 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028416;
	bh=53B/u5Oi9+ySFk9NNzlVBxe1WWsmENvFv29PxgvNvjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFInOqzqj+tbxdjXGXq8RGQz0yLjkB3q1nXX70xqGAV76oC0/NL+6sH/pDMWmoomC
	 p5g7WG9fgT7VRsaW9p2VOHjbK6B3f45tMZJbru9a7oJ5zj5EAOvKBJ/a4ny3LDan53
	 0OQS5o9iuiugCK2poXxFSOh6KIhTJlvlDEXZAgKOR6CPgjyFg6SZhICxe1O6Gi3qLq
	 LD7wUHB7zVdSFB3a4InBJYuaym7QFx4p29nwxKrdn/KIVPcMjupLrZd7lKAy7gMz6k
	 JmNcikuAIKFX+3yrhex3iPb8NW8CL/kzl7fbu8EnDBUUXMWNY7WqRnnIuWIZc8Zha3
	 28pFqkrHjg6ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-9-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-9-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:40:15 +0000
Message-Id: <20260702214015.A79121F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12010-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: B17A66FD00A

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Early loop termination during scatter-gather mapping leaves traili=
ng bursts uninitialized, leading to invalid DMA hardware configuration and =
silent hangs.

Pre-existing issues:
- [High] Missing spinlock in dw_edma_device_resume() leads to list corrupti=
on, data races, and lockdep warnings.
--

commit a2364f066e8539a3a2c9d2afab52db8336748992
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list
   =20
Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Allocate a burst array when
creating each chunk to simplify the code and eliminate one kzalloc() call.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f52d9fd18e573..01bee22fe3b3e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *v=
desc)
>  static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan =3D chunk->chan;
> -	struct dw_edma_burst *child;
>  	u32 i =3D 0;
> -	int j;
> =20
>  	if (chan->non_ll) {
> -		child =3D list_first_entry_or_null(&chunk->burst->list,
> -						 struct dw_edma_burst, list);
> -		if (child)
> -			chan->dw->core->non_ll_start(chunk->chan, child);
> +		if (chunk->nburst =3D=3D 1)
> +			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
>  		return;
>  	}
> =20
> -	j =3D chunk->bursts_alloc;
> -	list_for_each_entry(child, &chunk->burst->list, list) {
> -		j--;
> -		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> -	}
> +	for (i =3D 0; i < chunk->nburst; i++)
> +		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> +				     i =3D=3D chunk->nburst - 1);

[Severity: High]
Does this loop iterate over uninitialized bursts if the scatter-gather
loop in dw_edma_device_transfer() terminates early?

In dw_edma_device_transfer(), if the loop breaks early because !sg,
chunk->nburst remains at its originally allocated count rather than the
actual number of initialized elements.

Since the irq flag is only set on the very last element
(i =3D=3D chunk->nburst - 1), and that element might be uninitialized, could
this program the DMA hardware with zero-sized transfers and cause a
silent hang?

> =20
>  	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> =20
[ ... ]
> @@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er,
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
> =20
> -		if (chunk->bursts_alloc =3D=3D bursts_max) {
> -			chunk =3D dw_edma_alloc_chunk(desc);
> +		if (!(i % chan->ll_max)) {
> +			u32 n =3D min(cnt - i, chan->ll_max);
> +
> +			chunk =3D dw_edma_alloc_chunk(desc, n);
>  			if (unlikely(!chunk))
>  				goto err_alloc;
>  		}

[Severity: High]
This is a pre-existing issue, but looking at dw_edma_device_resume(),
it appears to modify state and access lists without taking the channel's
virtual spinlock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}
    ...
}

Since dw_edma_start_transfer() eventually calls vchan_next_desc() which
expects lockdep_assert_held(&vc->lock), and hardware interrupts could fire
simultaneously calling dw_edma_done_interrupt(), can this lead to list
corruption and data races?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D9

