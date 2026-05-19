Return-Path: <dmaengine+bounces-10550-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LWDD6tpDGo8hQUAu9opvQ
	(envelope-from <dmaengine+bounces-10550-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:46:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEAD57FF21
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CED6E30602A9
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25113BCD20;
	Tue, 19 May 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0f39IXc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA1409608
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198293; cv=none; b=aEed7iTrEzkfvQr7AvD06bynhYuBeT5QSqEf+m71zFRihAb5gWXOOYN6lGRCMr61CI+f3PpJHGgPE0xJRgVA1v+S8DmsaLKwja1V64hhG7MyAntWVZhQxM6FbzlKDC4BQZS/HmkrzimCZ1V31pYxAag/5IXTp2NME1gYO9CBz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198293; c=relaxed/simple;
	bh=vqJ1jDdmlORHsFR/mwniDQauLKbD/Co98wqQh6b89KQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GtAnNg71b470KB5Fa3QK902D6iLecOe10Jq+qUcq7yZEDZZIPjM1nVxMUbNJlRzWvxavQCjc07lz8VK/6DiqOrIUYiGgOcnu0Y2zGxFYTX9elpzRNY+bzRbMuLJwVDeYCdYABqOzL5Y2RK8ZbN6WGCMK3i6Njy9oEUkerwxqbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0f39IXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89022C2BCB3;
	Tue, 19 May 2026 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198293;
	bh=vqJ1jDdmlORHsFR/mwniDQauLKbD/Co98wqQh6b89KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d0f39IXcq4+yHFJw5V+akVP2wo1tsAdjuLjltuEvFdIjl2qGisX1XhpQKrSJKsA70
	 GB170eHQnVo68A5pJtnZuNUDA5uIHB//T8K4PGAsR0GumvP5p4uio9kLk2ereyH2Or
	 ID15P2pdOp975QVOaqVoIFse7XD4kZeFl5BO7ODOnRB+hucFTxpX6bwS+UilIczTyW
	 ghctMlBYPa+Xuc6j0bTCBYTyo/OXaS91JEvJP0EtUGsIMEou5QsUDzfKr/pSnf90CR
	 t29HKrjkIb2OMIXtFtKjXk6YYlxx1zmdteZVHa75+YOb0QU3vZOpSP5LOfJQw3U76c
	 a6RwhZSIms/6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/14] dmaengine: qcom: bam_dma: convert tasklet to
 a BH workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-3-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-3-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:44:53 +0000
Message-Id: <20260519134453.89022C2BCB3@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10550-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AEEAD57FF21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PM usage counter leak on failure in bam_start_dma() and bam_dma_ir=
q()
--

commit 16a499b407c35e00637c627257ad62de2a108b14
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue

This commit replaces the legacy tasklet implementation in the BAM DMA
driver with a high-priority BH workqueue.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index cea44833201d6..e2f16efcdb55f 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
[ ... ]
> @@ -893,9 +894,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
> =20
>  	srcs |=3D process_channel_irqs(bdev);
> =20
> -	/* kick off tasklet to start next dma transfer */
> +	/* kick off the work queue to start next dma transfer */
>  	if (srcs & P_IRQ)
> -		tasklet_schedule(&bdev->task);
> +		queue_work(system_bh_highpri_wq, &bdev->work);
> =20
>  	ret =3D pm_runtime_get_sync(bdev->dev);
>  	if (ret < 0)
>  		return IRQ_NONE;

Does this code leak the PM usage counter if pm_runtime_get_sync() returns
a negative value?

While this wasn't introduced by this patch, pm_runtime_get_sync()
unconditionally increments the usage counter before checking the state.
Returning IRQ_NONE here without dropping the counter permanently prevents
the device from entering runtime suspend again.

Could this be updated to use pm_runtime_resume_and_get() instead, which
automatically drops the usage counter on failure?

[ ... ]
> @@ -1111,14 +1112,13 @@ static void dma_tasklet(struct tasklet_struct *t)
>  		if (!list_empty(&bchan->vc.desc_issued) && !IS_BUSY(bchan))
>  			bam_start_dma(bchan);

A similar pattern is present in bam_start_dma(), which is executed by this
newly added work queue callback. It calls pm_runtime_get_sync() and returns
early on failure without dropping the usage counter.

>  	}
> -
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D3

