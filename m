Return-Path: <dmaengine+bounces-11280-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9MDZLiE0JmqdTQIAu9opvQ
	(envelope-from <dmaengine+bounces-11280-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 05:16:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B06652689
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 05:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RIwVU+Jq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11280-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11280-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9E58300AB3C
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4D31AF3B;
	Mon,  8 Jun 2026 03:16:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30748318EEE
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 03:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780888607; cv=none; b=l50TndJ42hqJz0/xPZITRulZvqyvJ+z4jJD2EhRcxtK+C3eM9J++it1WqgG4iN49WjbdPJ0u+60ua3icXki1Nl395zDxg/qL+YQtoLkpoKYj6MSgJ1JPcpJfudCcAZyu5Gjd2JlwCqmp8F2fcRWkFd3K0zhMzDMCIRNMROtFufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780888607; c=relaxed/simple;
	bh=aLuq5M63mC/fRTgOhSVFiWnc+s4iIHo4Ao19YNh5+lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QiId2unRl0KqCwFqBrHHFv0WX2REyfUbiQ13aPM+cgfLuVV8t/4WKX7W1fGSSlKc9FdnihbH/F+LjOLURM9ArKOp0moH+Hgb/R3FHZK6kcRHatv+nSJMkGRLDt5hG3ddJBD8kFcSj3jYzoMYaFgw4pvgj9HuZwSnQIPSbLj266M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIwVU+Jq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E59F1F00893;
	Mon,  8 Jun 2026 03:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780888605;
	bh=1kZTAzSmo2UBGUuKlRb5G90bPrA1TYnCasX1wnX7eps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIwVU+JqFxur0zulrwvEAz3u7693auOvgO/YHUHLAMJuXwDvr36N+wgq/VNNfM8B3
	 Zs/WBctHOGpB4QzRHGmY09sKeQMgtobTESdoY89EVhs6mVq9zxnuqUBApwH6e/8ZgF
	 wEQn9hTbjVJciJ72GNne7XC6F5nW5I1fYLQJcB0OhPsuCHoshDa/YdfY4k/9CVU6jU
	 e8YXlVGoki2TPHHIpuNyO+b+aW4EewNAT7m6vu9YOd4/K2CpxHS+p9IxGrXjwMsj7P
	 Akr3w/npRXpCGBRf9W9smcGwGMXNCeDg3RRF8pwfKFRofLPHMUHNVTQZOKRbUwEL7q
	 uGPLDaRi40nww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dmaengine: qcom: hidma-mgmt: Fix sysfs cleanup on
 setup failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260608030846.2602111-1-dbgh9129@gmail.com>
References: <20260608030846.2602111-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 03:16:45 +0000
Message-Id: <20260608031645.8E59F1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11280-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13B06652689

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reliance on `kobject_put` without `kobject_del` for sysfs cleanup =
leads to use-after-free
--

commit a6dc90d05cf8a69c255834fbadc8ca4eb60dbe56
Author: Yuho Choi <dbgh9129@gmail.com>

dmaengine: qcom: hidma-mgmt: Fix sysfs cleanup on setup failure

hidma_mgmt_init_sys() creates the chanops kobject, per-channel
kobjects and sysfs files incrementally. If a later creation step fails,
the function returns without tearing down the objects already created.

> diff --git a/drivers/dma/qcom/hidma_mgmt_sys.c b/drivers/dma/qcom/hidma_m=
gmt_sys.c
> --- a/drivers/dma/qcom/hidma_mgmt_sys.c
> +++ b/drivers/dma/qcom/hidma_mgmt_sys.c

[ ... ]

> @@ -231,20 +231,52 @@ static int create_sysfs_entry_channel(struct hidma_=
mgmt_dev *mdev, char *name,
>  	return sysfs_create_file(parent, &chattr->attr.attr);
>  }
> =20
> +static void hidma_mgmt_uninit_sys(struct hidma_mgmt_dev *mdev,
> +				  unsigned int sysfs_count,
> +				  unsigned int chroot_count)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < sysfs_count; i++) {
> +		struct attribute attr =3D { .name =3D hidma_mgmt_files[i].name };
> +
> +		sysfs_remove_file(&mdev->pdev->dev.kobj, &attr);
> +	}
> +
> +	for (i =3D 0; i < chroot_count; i++) {
> +		kobject_put(mdev->chroots[i]);

[Severity: High]
This is a pre-existing issue, but does this teardown logic still leave a
potential use-after-free?

Since the sysfs attributes (chattr) and their names are allocated using
devm_kmalloc() and devm_kstrdup() in create_sysfs_entry_channel(), devres
will free them immediately upon probe failure or device unbind.

If userspace holds an open file descriptor to any of the per-channel sysfs
files, or if CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() will
only decrement the reference count and the implicit kobject_del() inside
kobject_release() will be delayed. A subsequent read or write to the open
sysfs file would then dereference the already freed chattr memory.

Should kobject_del() be explicitly called before kobject_put() here to
synchronously remove the sysfs directory and files before devres frees the
backing memory?

> +		mdev->chroots[i] =3D NULL;
> +	}
> +
> +	if (mdev->chanops) {
> +		kobject_put(mdev->chanops);
> +		mdev->chanops =3D NULL;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608030846.2602=
111-1-dbgh9129@gmail.com?part=3D1

