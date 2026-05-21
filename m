Return-Path: <dmaengine+bounces-10711-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AG5C6lQD2pEJAYAu9opvQ
	(envelope-from <dmaengine+bounces-10711-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 20:36:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA45AB1DC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F244E30094C2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917B3CF676;
	Thu, 21 May 2026 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3zisQtj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11420350D7D;
	Thu, 21 May 2026 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388270; cv=none; b=eAke4RIToU103BBuEY3W0zX5g11pSxdTxz6ycTRlBBwQW03cc93Q9VAQQX4TzX/R7hOPuZBGc+6IXqLnd3eNWjJ4Qg+7iindJz3JUq2BrJxgHaviV0Ak37dCAz0Cy0PmVewIsneVU9Ku+VfP06XVnRP3BBOw4T1aErYAqGSCQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388270; c=relaxed/simple;
	bh=ahGhyvY/71NS9tCUpw2XlbplLozg9RkrfY4Zdu0Nk6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E2VqawV/2iyX2dpujrkayyIqKR8J27UvOS1XooMzB3fhRs+AZMYOhKxBbOkSkVH9bkXnZjx2pspjTQRd4bC8/zSJXNuZvaKzkoAREmpu49cMCRCibzIvxyWPE6MVfV7EwXaxwh+UZ5ENhCHeiR9EHOIjuQuPVGb+VV8NRZ8QQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3zisQtj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0690C1F000E9;
	Thu, 21 May 2026 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779388267;
	bh=VxfOj9nR4ELTY9TlWQ42ULxW5xAe9d5mrIlKR991cBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3zisQtjoZYmV1cZ8XUHB9FTHjFibbFn0cA7YTo44ADdNA3SXG2kwNp2fYG7NtBBz
	 oisR5TY+KmRQNLpBiTMrdc1HB7bAthHJUqAxYZZbx4zWFTwT9LNDo+DyRXn9oNeVSw
	 6JLruDEHC4xbL/ElQ48KKR+RCQZMKlvi2l7rDSe456x5wbH0Hy453Qxc/s1WkC6zbl
	 GSEKR6BTvv0Hbr7ft9cI7ais6ljyeeF8XBlXSa6yzTRDBwvydlSETwoIesoFSImcSF
	 vWLGxw/PX04E0Kz4I+6VClLshkeOeT2jp8Q2joQL6W631mklSsgtZk3TZxZJ4vmVKf
	 0XgGGqX+yfAAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260521-dma_prep_config-v7-6-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-6-1f73f4899883@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:31:06 +0000
Message-Id: <20260521183107.0690C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10711-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,nxp.com:email,lists.linux.dev:replyto];
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
X-Rspamd-Queue-Id: 9BFA45AB1DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Directly mapping embedded, non-cacheline-aligned struct fields (`c=
md`) for DMA causes cacheline sharing corruption on non-cache-coherent arch=
itectures.
--

commit bb3da580c11e6aae50b53789fc87a1f21f670249
Author: Frank Li <Frank.Li@nxp.com>

nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA t=
ransfer

This commit removes unnecessary dmaengine_terminate_sync() calls from the
success path of DMA transfers, leaving them only in the error path.

> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 4e9db96ebfecd..2afe8f4d0e461 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_p=
ci_epf *nvme_epf,

[Severity: High]
This is a pre-existing issue, but does mapping this buffer for DMA cause
cacheline sharing corruption on non-coherent architectures?

In nvmet_pci_epf_process_sq(), a pointer to the embedded cmd field of
struct nvmet_pci_epf_iod is passed to nvmet_pci_epf_transfer() with
DMA_FROM_DEVICE. This eventually reaches nvmet_pci_epf_dma_transfer(),
where the buffer is mapped via dma_map_single().

Because cmd is not marked with ____cacheline_aligned in
struct nvmet_pci_epf_iod, it shares cachelines with actively modified
adjacent fields like req and cqe. When dma_map_single() invalidates
the cachelines spanning cmd, any pending CPU writes to adjacent fields
are discarded.

Could this lead to the CPU later reading stale or uninitialized memory when
accessing iod->req or other adjacent fields?

>  	if (dma_sync_wait(chan, cookie) !=3D DMA_COMPLETE) {
>  		dev_err(dev, "DMA transfer failed\n");
>  		ret =3D -EIO;
> +		dmaengine_terminate_sync(chan);
>  	}
> =20
> -	dmaengine_terminate_sync(chan);
> -
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-dma_prep_c=
onfig-v7-0-1f73f4899883@nxp.com?part=3D6

