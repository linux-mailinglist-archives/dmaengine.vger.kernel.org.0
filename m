Return-Path: <dmaengine+bounces-11881-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vVXhFtBpQ2p1YAoAu9opvQ
	(envelope-from <dmaengine+bounces-11881-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 09:01:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BC6E0F49
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 09:01:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vf98ApJu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11881-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11881-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 504223007BB8
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439778F2F;
	Tue, 30 Jun 2026 07:01:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251B1EF36E
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 07:01:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802892; cv=none; b=fabw0xVfNEXZt1dn5jiCxp/02dDUFVbre73sJ6nSq9iGrxff7fVapBjXFUp41cjwn2a04jNpafxpRb+bc+6wFuAXmnb0f+ZKz2KWvHc7qi8Qj9QqVu1kHXWysL+ArzHgCcWfzvqOFdZh3Lp5GO45292w7EWeXBiLhxZ68VWtBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802892; c=relaxed/simple;
	bh=kiyRAOPlzZngjFfoQrDvicnhbulic30PYUbNuJyf9Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CzYjn6FZIRHoC52rbs5Xk7u0QFMUMujcSlNEAqjU+90POrRJStiwkRMHAib4+YvyJiLFlGPshOj5t0eZTWbqzz+mX4HrwPxqU/IkHs/dIrrn2ouLejfiOTKYrjZGsWbfGVl7oq57Y1JGYYVwA1dXxC604+u5S3jnPgAON0Tnqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf98ApJu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE71F000E9;
	Tue, 30 Jun 2026 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782802890;
	bh=IQz7YQd6N4taEuYBvRaoStLyD4FVyPjAuDXM33bN0g4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vf98ApJuBpgA5L8qbG0O6msrSF92KZGYIdwa9yKLLvX2XVxVQJf8/4MPLwNeM+NpH
	 KidUYfDpY8LX/PblVAf0tmGnpad+DoPpSpBuwbmHvZhhG0SAs7T4UyaH4mFpSdi8Rx
	 KCL3GeL0LSLAlY1PoJheq/N5lnuSo/7e/Q5aTmZr0aRysnYj59VxBHEWe9Zac35vwq
	 +LrrTat/w3DXLOGPEINXiyagj8vlM+K9YlEvvrJtcBHR2BBohLgNNmJej7PvxK8VQS
	 CCsOrJ7NKgca8R4kkeuEZl8amOvOIBPrgSodpm93JLQ02yKg0InCMpKH3Zzk6BNJND
	 9s/H0fVX1FexQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dmaengine: zynqmp_dma: fix race between runtime PM
 and device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Golla Nagendra" <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260630064844.705173-2-nagendra.golla@amd.com>
References: <20260630064844.705173-1-nagendra.golla@amd.com>
 <20260630064844.705173-2-nagendra.golla@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:01:30 +0000
Message-Id: <20260630070130.75EE71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11881-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,amd.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D98BC6E0F49

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe error path (`err_disable_pm`) fails to drop the PM runti=
me usage counter and leaves hardware clocks enabled if PM runtime is active.
- [High] Memory and PM runtime usage counter leak in `zynqmp_dma_alloc_chan=
_resources()` on error paths.
- [High] Device removal and shutdown paths disable clocks without first hal=
ting the DMA hardware, which can cause an AXI bus hang.
- [High] In `zynqmp_dma_prep_memcpy`, a 0-length transfer results in an inv=
alid descriptor allocation count leading to free_list memory corruption.
- [High] Missing dma_wmb() before clearing the STOP bit when appending DMA =
descriptors.
--

commit 14cd36b7d6a47ddc5e88925238c330623d079cf9
Author: Golla Nagendra <nagendra.golla@amd.com>
Subject: dmaengine: zynqmp_dma: fix race between runtime PM and device remo=
val

This commit changes zynqmp_dma_remove() to disable runtime PM before
attempting to manually suspend the device. This prevents a potential race
condition where runtime PM transitions could happen concurrently during the
driver's unbind path.

> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_=
dma.c
> index f6a812e49ddca..ca2dee0012c87 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1170,9 +1170,9 @@ static void zynqmp_dma_remove(struct platform_devic=
e *pdev)
>  	dma_async_device_unregister(&zdev->common);
> =20
>  	zynqmp_dma_chan_remove(zdev->chan);
> -	if (pm_runtime_active(zdev->dev))
> -		zynqmp_dma_runtime_suspend(zdev->dev);
>  	pm_runtime_disable(zdev->dev);
> +	if (!pm_runtime_status_suspended(zdev->dev))
> +		zynqmp_dma_runtime_suspend(zdev->dev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does zynqmp_dma_remove() need
to halt the DMA hardware before disabling clocks?

The function disables device clocks via zynqmp_dma_runtime_suspend() but ne=
ver
writes to the hardware to halt active transfers or waits for idle.

Could stopping clocks while an AXI master is mid-transaction violate the bus
protocol and cause an interconnect hang?


[Severity: High]
This isn't a bug introduced by this patch, but does the probe error path fa=
il
to drop the PM runtime usage counter?

If zynqmp_dma_chan_probe() or subsequent initialization steps fail, the
err_disable_pm path is taken:

drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_probe() {
...
err_disable_pm:
	if (!pm_runtime_enabled(zdev->dev))
		zynqmp_dma_runtime_suspend(zdev->dev);
	pm_runtime_disable(zdev->dev);
	return ret;
}

When CONFIG_PM is enabled, pm_runtime_enabled() evaluates to true, so it
skips calling zynqmp_dma_runtime_suspend().

Doesn't this also fail to call pm_runtime_put_noidle() to balance the
earlier pm_runtime_resume_and_get(), permanently leaking the usage
counter and leaving hardware clocks running?


[Severity: High]
This isn't a bug introduced by this patch, but do the error paths in
zynqmp_dma_alloc_chan_resources() leak memory and PM usage counters?

If memory allocation fails:

drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_alloc_chan_resources() {
...
	chan->sw_desc_pool =3D kzalloc_objs(*desc, ZYNQMP_DMA_NUM_DESCS);
	if (!chan->sw_desc_pool)
		return -ENOMEM;
...
}

This returns -ENOMEM directly without calling pm_runtime_put() to balance
the earlier pm_runtime_resume_and_get(), and without freeing previously
allocated structures.

Since the dmaengine core doesn't automatically invoke free_chan_resources()
when alloc_chan_resources() fails, does this permanently leak the usage
counter and descriptor memory?


[Severity: High]
This isn't a bug introduced by this patch, but can a 0-length transfer cause
memory corruption in zynqmp_dma_prep_memcpy()?

If a client driver requests a DMA memcpy with len =3D=3D 0:

drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_prep_memcpy() {
...
	desc_cnt =3D DIV_ROUND_UP(len, ZYNQMP_DMA_MAX_TRANS_LEN);
...
	chan->desc_free_cnt =3D chan->desc_free_cnt - desc_cnt;
...
	do {
		new =3D zynqmp_dma_get_descriptor(chan);
...
	} while (len);
...
}

DIV_ROUND_UP(0, ...) is 0, so desc_cnt is 0. The availability check passes
and desc_free_cnt is decremented by 0.

However, the subsequent do-while loop executes once, consuming one descript=
or
from free_list.

When the descriptor is later freed, desc_free_cnt is incremented by 1,
inflating the available count.

Could subsequent transfers then bypass the free count check and extract a
descriptor from an empty list?


[Severity: High]
This isn't a bug introduced by this patch, but is a memory barrier missing
before clearing the STOP bit when appending descriptors?

In zynqmp_dma_tx_submit():

drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_tx_submit() {
...
		desc->src_v->nxtdscraddr =3D new->src_p;
		desc->src_v->ctrl &=3D ~ZYNQMP_DMA_DESC_CTRL_STOP;
		desc->dst_v->nxtdscraddr =3D new->dst_p;
		desc->dst_v->ctrl &=3D ~ZYNQMP_DMA_DESC_CTRL_STOP;
...
}

The CPU updates the previous descriptor's nxtdscraddr and then clears its
ZYNQMP_DMA_DESC_CTRL_STOP bit.

Without a dma_wmb() between these stores to coherent memory, could the CPU
or memory controller reorder them?

If the DMA controller fetches the cleared ctrl word before the nxtdscraddr
update is globally visible, might it jump to a stale or invalid address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630064844.7051=
73-1-nagendra.golla@amd.com?part=3D1

