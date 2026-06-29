Return-Path: <dmaengine+bounces-11861-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uQG8DOpGQmp+3gkAu9opvQ
	(envelope-from <dmaengine+bounces-11861-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:20:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9AB6D8D54
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:20:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WkqwxJfV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11861-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11861-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A53A4300A12E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250153EB0F5;
	Mon, 29 Jun 2026 10:18:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8553BAD9B
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728298; cv=none; b=HMeqSkyWD75Zqm66GtlTot3nRl8jSSdMPMhoZdnO0A1nBfpgKNdb00vfYzV7QMyWIPfbxtWxPtRXeLgDtBwN73VpUn6Q3wFM7RzTxEhqQOqxhcrDss7m2FB1lzU6OSZNm0soL6HuXjS+TMJRbB6xL8zmyyDK/wuKx6CAKmlecho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728298; c=relaxed/simple;
	bh=AgFAz7ThXX2o+ZIDMrht+FoMD9f/einV75ABiT4n3qU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpJcIhrUL1iAOSQDclz4i4huoAi7Z0wO/tW+MBqW0nTLqqXwzIeT23RB+Iso9My4IOZn6y6KKYPwxjorxlQj8Yu5R5sNaHIfKj0pME6ocUsuXXa5WxcLEQpKxGReW4p0qqWQG9Nqr/dFI0kCG2tRWwoTnYZ+QplC/G5xS4mx0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkqwxJfV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0301F000E9;
	Mon, 29 Jun 2026 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728296;
	bh=Bnm47HYgXQHBJmO5oD8qNtxIIzMEYIQvWzk7aiGRlO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WkqwxJfVr3vrmGCKkZoAPjbt13wbt7nuty3TUqY4nOlf9wXCQ6SNX2i523BfdkbN2
	 y9hgU0CE0vRsZHcv+16kCnY0s7bsy46+Iru9dInH18pJEDgY60niPgkfHlk1Y9Q4TU
	 NsDywF6YyMvpUBKo8FatFYs+4AKL755AudMKdBImzZ/DFRu7aqaVyIW346WvQnu3mU
	 Xdp0M6O12BCw1eTdKVjgGCuD+9RlnR3Vlkt6mKSpKxUBVZ0191g4p0HtYjFgjUTlJ2
	 NcpECwZ05UUWBMi9skQbhDPQI2zSjzPFemUCYNk9IxNrglczKXS4V1PIY7vQIoxjqe
	 gDfiQ7EMPOtDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 05/14] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-5-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-5-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:18:16 +0000
Message-Id: <20260629101816.7D0301F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11861-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F9AB6D8D54

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Prematurely freeing the IRQ in `bam_dma_remove()` before unregiste=
ring the DMA device.

Pre-existing issues:
- [High] Accessing hardware registers after the clock has been disabled in =
`bam_dma_remove()`.
--

commit c3d67a708644d5b3039f73321dfd2a2034b5a7b2
Author: Bartosz Golaszewski <brgl@kernel.org>

dmaengine: qcom: bam_dma: Add pipe_lock_supported flag support

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 8ce0fe085c5fe..f3e713a5259c2 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -115,6 +115,7 @@ struct reg_offset_data {
> =20
>  struct bam_device_data {
>  	const struct reg_offset_data *reg_info;
> +	bool pipe_lock_supported;
>  };
> =20
>  static const struct reg_offset_data bam_v1_3_reg_info[] =3D {

[ ... ]

Looking at bam_dma_remove() in drivers/dma/qcom/bam_dma.c:

drivers/dma/qcom/bam_dma.c:bam_dma_remove() {
...
	free_irq(bdev->irq, bdev);

	pm_runtime_force_suspend(&pdev->dev);

	of_dma_controller_free(pdev->dev.of_node);
	dma_async_device_unregister(&bdev->common);
...
}

[Severity: High]
If a client has an active DMA transaction when the DMA engine is removed (e=
.g.,
via sysfs unbind or module unload), does freeing the interrupt early mean t=
he
completion interrupt will never be serviced?

This could cause the client driver to wait indefinitely for the DMA transac=
tion
to finish, leading to unkillable tasks or system hangs. Should the DMA engi=
ne
be unregistered and channels properly quiesced before the IRQ is released?


drivers/dma/qcom/bam_dma.c:bam_dma_remove() {
...
	pm_runtime_force_suspend(&pdev->dev);

	of_dma_controller_free(pdev->dev.of_node);
	dma_async_device_unregister(&bdev->common);

	/* mask all interrupts for this execution environment */
	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

	for (i =3D 0; i < bdev->num_channels; i++) {
		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
...
}

[Severity: High]
This is a pre-existing issue, but can accessing hardware registers after the
clock has been disabled here cause a system crash?

The clock is disabled by pm_runtime_force_suspend(), making the subsequent
writel_relaxed() and bam_dma_terminate_all() register accesses fatal. On
Qualcomm SoCs, accessing BAM registers while the clock is gated triggers a
synchronous external abort (NOC error), resulting in an immediate kernel pa=
nic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D5

