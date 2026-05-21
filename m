Return-Path: <dmaengine+bounces-10619-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Al/C5WtDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10619-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:00:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C869B59FCCA
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8D9301E3CA
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C37386C12;
	Thu, 21 May 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg3JFuVS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C33546E0
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346527; cv=none; b=qmacd+g7KU6CuD+26l3C2bFpc3/IQ1Y7UL11VCotCHaAzLtT5KNzUBDZDdL+tcy9rI0gVlRFlr1YK3vL2BXQGtIZXIbr3kKzDgEnqxG4/bGr+bCTI11WFcri2G3MjSfGWnBAAIAecQI1nVLX6SNQUxFIDOBjloZcfN7vHsGSsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346527; c=relaxed/simple;
	bh=uzvXZ2VgA5ufmxSxVI1wE523hz+Rb2209wGtnbXyaq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DEW2aKL/mve8yZk292ghLxcBK90hk3r7Xn1VGmWDLzfRhQVdeA7rjVrZMnuscsuBaonLosFaErlBn8Ii9n6DoiP7LrOaLBHMDuKcpUrIOV2aQ+7cA1vrnqRo4ch7Ig3WAJhoU/Af8l8JSM+WbtZYkohFLiFU6UgsqW/2/Dul810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg3JFuVS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65DB1F000E9;
	Thu, 21 May 2026 06:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346526;
	bh=ugoXmkCwGCK+OFSO14nyfe9vxWPdPkvmyelXzRH8nFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hg3JFuVSlvXRYA2KXONXd6t4qoMBH5y6IRsiSaFea/0kK2R/EqmY0NEv3BoYBNztW
	 8IGSCKcPZNWrXyXe9JLFH0NYUOnR29fgDKipYjbsX/AvH26/pP43aPH4ohmPM4ImuU
	 RYQkX90ikpS4Z6qSB1s7YhfZinjhjyavCZBPJ/rn1X9sAg0OXTgNTH1bg4ruUp7QM2
	 Sy3q14bD0yYaJa5nw8nGrHhOaRrrHW4EDtyUVoWSJu7J6tq3PnOYUMTp5KP9rIpakx
	 HKKj7blLRhz8AHDogGd4fGa7toIb5XsI6opKlj6NlYC4x3jD5yNwDGB3wf0STirc7w
	 F5mCRha1d8Ojg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] dmaengine: dw-edma: Add channel lookup helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521063115.2842238-3-den@valinux.co.jp>
References: <20260521063115.2842238-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:55:25 +0000
Message-Id: <20260521065525.C65DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10619-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RSPAMD_EMAILBL_FAIL(0.00)[den.valinux.co.jp:query timed out,sashiko-reviews.lists.linux.dev:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,valinux.co.jp:email]
X-Rspamd-Queue-Id: C869B59FCCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dw_edma_find_channel() returns an unrefcounted dma_chan pointer, i=
ntroducing a Use-After-Free risk.
- [High] dw_edma_find_channel() can dereference a dangling chip->dw pointer=
 after device removal.
--

commit e830a617205c7611be91f86f0b039e1df241f258
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add channel lookup helper
   =20
This commit adds a helper function to map a DesignWare eDMA hardware
channel number to its corresponding DMAengine channel pointer.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..6660380a1bbc2 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -1189,6 +1189,38 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
> =20
> +struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip, bool wr=
ite,
> +				      u16 id)
> +{
> +	struct dw_edma_chan *chan;
> +	struct dw_edma *dw;
> +
> +	if (!chip)
> +		return NULL;
> +
> +	dw =3D chip->dw;
> +
> +	if (!dw)
> +		return NULL;

[Severity: High]
Is there a risk of a use-after-free if this is called after device removal?

In dw_edma_probe(), chip->dw is allocated via devm_kzalloc(). During
dw_edma_remove(), the device is torn down but chip->dw is never set to NULL.
When devres cleans up, chip->dw becomes a dangling pointer. If an external
caller invokes this helper after removal, the !dw check will pass, leading
to freed memory being accessed.

> +
> +	if (write) {
> +		if (id >=3D dw->wr_ch_cnt)
> +			return NULL;
> +		chan =3D &dw->chan[id];
> +		if (chan->dir !=3D EDMA_DIR_WRITE)
> +			return NULL;
> +	} else {
> +		if (id >=3D dw->rd_ch_cnt)
> +			return NULL;
> +		chan =3D &dw->chan[dw->wr_ch_cnt + id];
> +		if (chan->dir !=3D EDMA_DIR_READ)
> +			return NULL;
> +	}
> +
> +	return &chan->vc.chan;

[Severity: High]
Could returning this unrefcounted pointer lead to a use-after-free?

The commit message mentions the pointer is used "only for later ownership
reservation." However, returning a raw dma_chan pointer directly from the
driver's internal devres-allocated array means there is no mechanism to
prevent the eDMA device from being hot-removed between the time the pointer
is obtained and when the caller actually reserves the channel.

Does the DMAengine API require taking a reference at lookup time to
guarantee object lifetime?

> +}
> +EXPORT_SYMBOL_GPL(dw_edma_find_channel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D2

