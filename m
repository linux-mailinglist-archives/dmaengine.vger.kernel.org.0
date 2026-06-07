Return-Path: <dmaengine+bounces-11273-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kE/KG6KeJWrsJgIAu9opvQ
	(envelope-from <dmaengine+bounces-11273-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 07 Jun 2026 18:38:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E7650FCF
	for <lists+dmaengine@lfdr.de>; Sun, 07 Jun 2026 18:38:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dU/uCHa3";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11273-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11273-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47D99300CBE4
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jun 2026 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEE2D3ECF;
	Sun,  7 Jun 2026 16:38:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FB223DE9
	for <dmaengine@vger.kernel.org>; Sun,  7 Jun 2026 16:38:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850335; cv=none; b=mlCmBzXrPCp3tGTI8dc2l7Ubuc4YS8hTniPDkGrDKX2nK6fMZBkOVKl/oiOJJ+Zh8yfy7prWVtneQbD3cBCa4aL/N/lXkFe4AHeKHfrXz3dQ5anSp6LJZhA0T3sJtEbTZlfnlwNRnZxxm5U2AbvQ7ktJIzdXeRF949qcvohYgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850335; c=relaxed/simple;
	bh=yHCsQXCG1FXnjVJ6ppzjjlJ7COjAI/TxhAZNMmun1fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+lEwLadz0p+SKF2LTevzu76IoDHFaRBAtMsI9etGlRED2lA6mylGXJLMepgQtYLKSuuXssNAfX041thr4FTj5bQyrrxq4kNjBkppyuCZ/vNZOwv5f9J8O+OaF2C+IDt18U8+yipwhvOp70ogqlaEc5woqxeKn/4VFLYC4md8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU/uCHa3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCFD1F00893;
	Sun,  7 Jun 2026 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780850334;
	bh=81g1ATF0QlN49WB9tgvfFd7wieo3RG765oW+LPQqrog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dU/uCHa3S8Ol1ZaxaTYo8CifeMLjv9x4ShQaJFvmcinoDW3xdkfwsBWx44HHnQa4h
	 tLA05OHoDx3ooBqt87omjb8GRWQ05eGGepZV75a3FpAAWzfrF5sc4a4xZVFuGBVR/3
	 QUwMYKonXQlQTbjDYTjRjJOjUEcB71AI2nt6uNagFrTvFwxCW3xWeaqjUaN/lJgYDV
	 QJ9+RFTaa52Islc9uBeTaXAnYTo/Mbk9VZ2WHe/g5CJO+3CnqzO6LjWU0plcso7+HA
	 Y54R6GB/ZvAfjihDiOVh3Y/jCokkToF3YHeXDWcll6X9oXMewUB37BodJvhEqkV3Em
	 xNk0M+2ptTO8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: qcom: hidma: use sysfs_emit() in sysfs show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260607163119.78717-1-dennylin0707@gmail.com>
References: <20260607163119.78717-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 16:38:53 +0000
Message-Id: <20260607163854.3DCFD1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11273-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dennylin0707@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF7E7650FCF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing kobject_put on error paths and driver removal leaves d=
angling sysfs files, leading to Use-After-Free when accessed.
--

commit fad7d7a1746d0d84aca95c02e2a6fd4400ce44f9
Author: Hungyu Lin <dennylin0707@gmail.com>

dmaengine: qcom: hidma: use sysfs_emit() in sysfs show callbacks

This commit replaces sprintf() and strlen() patterns in the sysfs show
callbacks of the hidma driver with the preferred sysfs_emit() helper.

> diff --git a/drivers/dma/qcom/hidma_mgmt_sys.c b/drivers/dma/qcom/hidma_m=
gmt_sys.c
> index 930eae0a6257c..9672ef9ee8fc0 100644
> --- a/drivers/dma/qcom/hidma_mgmt_sys.c
> +++ b/drivers/dma/qcom/hidma_mgmt_sys.c

[ ... ]

> @@ -143,15 +140,15 @@ static ssize_t show_values_channel(struct kobject *=
kobj,
>  	struct hidma_chan_attr *chattr;
>  	struct hidma_mgmt_dev *mdev;
> =20
> -	buf[0] =3D 0;
>  	chattr =3D container_of(attr, struct hidma_chan_attr, attr);
>  	mdev =3D chattr->mdev;

[Severity: Critical]
This is a pre-existing issue, but while reviewing these sysfs callbacks,
could there be a use-after-free triggered here when mdev or chattr are
accessed?

Looking at hidma_mgmt_init_sys(), kobjects are created in loops:

	chanops =3D kobject_create_and_add("chanops", &mdev->pdev->dev.kobj);

However, there do not appear to be any matching kobject_put() calls on the
error paths, nor a remove callback to tear them down on driver unbind. Since
the structures backing these attributes (mdev and chattr) are managed by
devm_ allocations, they are automatically freed upon probe failure or device
unbind.

Does this allow the sysfs files to remain accessible in the filesystem,
triggering a use-after-free when reading or writing to them dereferences
the freed memory in show_values_channel()?

> +
>  	if (strcmp(attr->attr.name, "priority") =3D=3D 0)
> -		sprintf(buf, "%d\n", mdev->priority[chattr->index]);
> +		return sysfs_emit(buf, "%d\n", mdev->priority[chattr->index]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607163119.7871=
7-1-dennylin0707@gmail.com?part=3D1

