Return-Path: <dmaengine+bounces-11210-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j+H0BnJKI2oRoAEAu9opvQ
	(envelope-from <dmaengine+bounces-11210-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:15:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F664B966
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:15:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NgeovF74;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11210-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11210-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F29993031C0E
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1728C854;
	Fri,  5 Jun 2026 22:15:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE281314D06
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:15:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697711; cv=none; b=Y9fS3w16K1DAWxrgdm6XW9tqwrMS8sfG+iF8lWBlg6zqf2Tad5lAboLMrmO/aYd3nZAucNJWMh0rpLL+EgQcgku8j364A/CV5cy8v+ZBVwcTChnNaJ0uxH44bduRmlOynYZ4k+jcY+GSzOHMoqmQwqm78OTsiPJ3vJmAHulLdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697711; c=relaxed/simple;
	bh=CC25I477E5gx/raook8grms/9PcBZM15S8sZGjm7MfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSTq2mNKl+ze/soiSz/BGnanR7UQ83yQwwXwBD4/jy1YT/M35nczsAcOdqO8YMWZko9uJdYfgW2bdzggfBoK53/n7SvqHpQla9ou+XqMYdVTYc30MuLK/3heqFWsKdKV+H1Vn9lj8sw0MF9wDVRFhhKhMJh7aWgzWC9NsEakG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgeovF74; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61C1F00893;
	Fri,  5 Jun 2026 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697710;
	bh=TE0Efr8TfiRQ/M+pND4vWkirWizfV0AF996f4WGWw6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NgeovF74Zsy3L21r9zXkwNtyBn+rLNa2pg8VtXv/rG83ccn+ng9UZWBhMUWF/6wGY
	 05VFGr0VQ5858UVWRhoWa2q2eI5oaMwBynr5DhoSu0qaQAvfRtQVrVTDqGKfKs7EYQ
	 Vk2XZZtCqK5nZBcqYUNaM7w3V/K5EVNpvqZjoY0h21E4+Ska5UPhbT1tz1IOYJxM0X
	 3rYF5Rs3yg0UI2lClIaiEXG6rRueYkQyqNthhsgzivWC2l6FzYBM+xIMjyQ004godf
	 VGpWKXpZh8r44tzBe0lcBuoKEvsnHKAOESi08Z6sWUJIMRIK7FSehn9SJ0WwA6YglM
	 JHkoNRwW6TJcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] dmaengine: fsldma: convert channel allocation to
 devm_kzalloc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605220134.43295-7-rosenp@gmail.com>
References: <20260605220134.43295-7-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:15:09 +0000
Message-Id: <20260605221510.3B61C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11210-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A76F664B966

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Permanent IRQ mapping leak due to missing `irq_dispose_mapping()=
` for channels.
--

commit 0a179f7b88544d88df0377a17f9feb95d32cd67e
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: convert channel allocation to devm_kzalloc

This commit converts fsl_dma_chan_probe from using kzalloc_obj to
devm_kzalloc. It ties the channel lifetime to the parent DMA device and
removes the need for kfree in the probe error path and the remove function.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
[ ... ]
> @@ -1208,7 +1203,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan =
*chan)
>  	tasklet_kill(&chan->tasklet);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);
> -	kfree(chan);
>  }

[Severity: Medium]
Earlier in the patch series, the call to irq_dispose_mapping() for chan->irq
was removed from fsl_dma_chan_remove().

Although IRQ parsing is updated to use of_irq_get(), that function still
internally allocates an IRQ mapping via irq_create_of_mapping().

Without a matching irq_dispose_mapping() during teardown, does unbinding
the driver permanently leak the IRQ mapping for each channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605220134.4329=
5-1-rosenp@gmail.com?part=3D6

