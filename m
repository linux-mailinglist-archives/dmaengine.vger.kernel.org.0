Return-Path: <dmaengine+bounces-10457-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLiQNtMiBWpySwIAu9opvQ
	(envelope-from <dmaengine+bounces-10457-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:18:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F44753CA60
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FB330134B6
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE078175A8B;
	Thu, 14 May 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slLnwpqD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DD199FAB;
	Thu, 14 May 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721381; cv=none; b=QogNnEmwoOq4pa2LhUL+iKw5JBkp61htkM6KmVyPUnBau2/asC52Fo162josYnNcxIFWyJaLPxLM4hnMjuDIk4NctGOX9CpetwTei/yjkh9cTJvd4ao1JwRtrQkS0M5BC3MjX8d0mdPIRitGgLRoqlkJvnu8WNqR192RM+nMbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721381; c=relaxed/simple;
	bh=3T4/l0cYcsvO43u+Nr4UWLZS9aaPPniMiBrtIhuG2Zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AdXfGCCeLBjaYa8xglK3Rm8aDe0DD2xmVvv1D92EarRgPk09WhVE+PfmD/rnFgBz159YISju/nmbhAh7+5ke8sWv5ZiCWq6XvQbS5duNcCm/7FOSDAvFXL7GsLt61ddEiv/Fm2hGCH8EC+pBL5k8Uuq/k2otcFIdbF+ERfH+oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slLnwpqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065FDC19425;
	Thu, 14 May 2026 01:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721381;
	bh=3T4/l0cYcsvO43u+Nr4UWLZS9aaPPniMiBrtIhuG2Zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=slLnwpqDAuifXWl50CVAEz85b8gjXuXA3eEV0RMXaoF7f3W0RQfRwVBYHBPBdLYSl
	 8de0kYgqB7Gg/VWfJImW7lXSNKw8qDr7tenRCrSFbChbuOV3CVEwRWxD+1/zF+k4kH
	 Awy5uWgh67GfqlEhEsO209odkjPzaXVY1/xZUOQKgZ/didqe43PRj7/rwM44sWD9bC
	 ddwWOFIbrmfIIOw1PNORAeT9VsewlQV/3C9tRCJeXBUX9M6ikEmz/wq9LRq/hhzuMw
	 hvTqijyVCca8uGS5tb23SMKnzzpDep1vEvrANJz/osbWB3jo+4uH++N9BYHvhMOlfT
	 bFX7L0Genh8hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-7-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-7-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:16:20 +0000
Message-Id: <20260514011621.065FDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3F44753CA60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,nxp.com:email,sashiko.dev:url];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10457-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing the DMA serialization mutex causes severe CPU starvation,=
 spurious timeouts, and cascading DMA transfer aborts.
- [Low] Unused local variable triggers a compiler warning and leaves dead m=
utexes in the device structure.
--

commit 4b68a703ef44d7ed4b6b20d869ad94bab23d5076
Author: Frank Li <Frank.Li@nxp.com>

nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

This commit uses the new dmaengine_prep_config_single_safe() API to combine
DMA configuration and descriptor preparation into a single call. It also
removes the mutex that was previously used in the DMA transfer path.

> Since dmaengine_prep_config_single_safe() performs the configuration and
> preparation atomically and the mutex can be removed.

Is this description entirely accurate?

While the configuration and preparation might now be atomic, the mutex also
strictly serialized the DMA transaction pipeline.

> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2afe8f4d0e461..04d8f48d69503 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_=
pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
> =20
> -	mutex_lock(lock);

Does removing this mutex introduce concurrency regressions with the shared =
DMA
channel during the wait phase?

With the mutex removed, multiple concurrent NVMe worker threads can submit
transfers to the same channel. Since dma_sync_wait() busy-waits using
cpu_relax(), could multiple threads spinning simultaneously lead to severe =
CPU
starvation?

Additionally, dma_sync_wait() has a hardcoded 5-second timeout computed at
entry. If concurrent transfers queue up, could later transfers spuriously
time out while waiting for earlier ones to finish in hardware?

If a spurious timeout occurs, the error path further down calls
dmaengine_terminate_sync(chan). Does this unconditionally abort all active
and pending transfers on the shared channel, potentially causing cascading
data transfer failures?

Could unbounded concurrent submissions also exhaust the DMA channel's
fixed-size descriptor pool under load?

> -
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

[ ... ]

> @@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pc=
i_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> =20
> -unlock:
> -	mutex_unlock(lock);
> -
>  	return ret;
>  }

This isn't a bug, but does leaving the local lock variable and its assignme=
nts
in the preceding switch statement trigger a -Wunused-but-set-variable compi=
ler
warning?

Also, since dma_rx_lock and dma_tx_lock in struct nvmet_pci_epf are no
longer used anywhere else, should they be removed from the structure to avo=
id
leaving dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D7

