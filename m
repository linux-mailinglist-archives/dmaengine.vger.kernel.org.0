Return-Path: <dmaengine+bounces-10712-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L3OF21XD2o8JQYAu9opvQ
	(envelope-from <dmaengine+bounces-10712-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 21:05:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD05AB55C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 21:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CFC8301301D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20F401A3A;
	Thu, 21 May 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA2ts/Fj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44E3FADE9;
	Thu, 21 May 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390310; cv=none; b=Pv/7DhMh64f2xeH389b7yHdLV6nZsB4f6hBY6pIT3lha9IuLyIwVDRdq7lOjqTcxYc36dD6ZDO6oXENHpB48Mc5ZUcoQs5JDg2uov5iGygOTerZPtm6nDPE6uSzZADFm4xGv8RPyiv644dz9FCAls0JfKMFeVRA+G28PRJ469I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390310; c=relaxed/simple;
	bh=nS1YohvRA6+QYc47+oKdHKG14mzoayhGT0SLjurt5Us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L1K6pL3seMLpGrlObOnG0SMo4qo/Cm/kSrJiFux8F/v6J7Pr50oYFYtLeieMo0Isl+eRPBxDD3yA2lMjjI7/7Bg+FchQWiSkkrYR+spC6wSd1q0Aztl7tZrN9nuXSdNRJg3flXAPg715srX/DKq3FXwxORdBLFAi5uIvxPiqc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA2ts/Fj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF321F000E9;
	Thu, 21 May 2026 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390304;
	bh=rrnpxsFPI13KfFrjgq5YPmQff2T/DywbBASDJrqj44I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SA2ts/Fj5CsxA2m12xrSqnz0sde4BmS4OWIxBDOj7sXTbJY5n7NJWkjmUQDW2mwOl
	 D6w6n29ROmzufvdl+6GJO+5UcVwJKSxa93tXuQlc25dYITe+P4wDVrc472YDw/kQx3
	 2SfTd7w8H4T27vKb7D8ahrIKeukSOrXXv/0gp4glouVc4bxpOmSapRGKIs/esE+3PZ
	 LtCX0H0tF5NNIM0iYMRyr31lrQFfMwaJQZYnJr1mA/6Df0mCTprd784fejalChw+SG
	 Pa6CbOxl/BZvr3Zjfn840+hHSyBckSAR9m5j7I/g24JWIRYHjG1XDheAk3bu3AGaVp
	 GQQQ5vb75xTyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521-dma_prep_config-v7-7-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-7-1f73f4899883@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 19:05:03 +0000
Message-Id: <20260521190503.ABF321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10712-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: D1DD05AB55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the DMA channel mutexes allows concurrent synchronous tra=
nsfers on a shared DMA channel, leading to destructive error handling (casc=
ading aborts), severe CPU starvation, spurious timeouts, and descriptor poo=
l exhaustion.
--

commit 57a71fe2904773875ab4a20b8b7b4de2296d0683
Author: Frank Li <Frank.Li@nxp.com>

nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

This commit replaces the separate DMA channel configuration and descriptor
preparation steps with the new dmaengine_prep_config_single_safe() API.
It also removes the dma_tx_lock and dma_rx_lock mutexes, assuming they are
no longer needed because the new API call is atomic.

> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2afe8f4d0e461..b1ba2d0bea6d9 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
[ ... ]
> @@ -388,22 +376,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_=
pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
> =20
> -	mutex_lock(lock);
> -

[Severity: High]
Does removing this mutex expose the entire synchronous transfer lifecycle to
concurrent access?

While dmaengine_prep_config_single_safe() is atomic, the removed mutex
also protected the subsequent dmaengine_submit() and dma_sync_wait() calls
in this function. Since NVMe commands are processed concurrently by unbound
workqueues, multiple worker threads might now share the same global DMA
channel without synchronization.

If multiple threads concurrently spin in dma_sync_wait() on the same channe=
l,
could this cause severe CPU starvation due to its tight busy-wait loop?

Additionally, dma_sync_wait() has a fixed 5-second timeout from the moment
it is called. With concurrent queuing, a newly submitted transfer's wait ti=
me
would include the execution of all preceding queued transfers on the channe=
l.
Under high load, might this exceed 5 seconds and cause spurious timeouts?

If a timeout does occur, the error path calls dmaengine_terminate_sync(chan=
).
Will this forcefully abort all pending and active transfers on the channel,
destroying the in-flight DMA operations of all other concurrent NVMe comman=
ds?

Finally, unbounded concurrent submissions could potentially exhaust the DMA
engine's hardware descriptor pool under high I/O load, causing
dmaengine_prep_config_single_safe() to return NULL and fail valid commands.

>  	dma_dev =3D dmaengine_get_dma_device(chan);
>  	dma_addr =3D dma_map_single(dma_dev, seg->buf, seg->length, dir);
>  	ret =3D dma_mapping_error(dma_dev, dma_addr);
>  	if (ret)
> -		goto unlock;
> -
> -	ret =3D dmaengine_slave_config(chan, &sconf);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto unmap;
> -	}
> +		return ret;
> =20
> -	desc =3D dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> -					   sconf.direction, DMA_CTRL_ACK);
> +	desc =3D dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
> +						 sconf.direction,
> +						 DMA_CTRL_ACK, &sconf);
[ ... ]
> @@ -426,9 +407,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pc=
i_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> =20
> -unlock:
> -	mutex_unlock(lock);
> -
>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-dma_prep_c=
onfig-v7-0-1f73f4899883@nxp.com?part=3D7

