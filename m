Return-Path: <dmaengine+bounces-10772-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKdwDt/REGpyeAYAu9opvQ
	(envelope-from <dmaengine+bounces-10772-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 23:59:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825A5BADB5
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 23:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3B3300B125
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B11038E8CB;
	Fri, 22 May 2026 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q36ScUAS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D19306742
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487161; cv=none; b=dSZnUWYzwnkoCRmQys0/tPVMs9v4vOsY9351rhYRPPtrgBdQoEn1S/kne8uBEICPwjQonLOTc+TdNSjG6G3EhSl+XgXnsO5VQFIlul2Y5sq2Hbft8HSqhMqUuIWMTIF3KzJOgR4ggxbq92w+D8WJkqDg6O+ahmHyWKMt5Xqftp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487161; c=relaxed/simple;
	bh=NTVvQr9iuGZ9/gaXbXtvMVr4Mx4GmahapAuGDeIzamM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aXCepWSBgOWOc3q0VXIba67EphyL2bdNTvYbeis6WE+AgWYOa+66hap/v4tTMX7NQW/gWCBD5xKr/RYYfHtm8dCZS5NDDvE2ryjBTSJqwi1pYCb2YVXWzch7hLmoFQWYlFx0RIyyrL9kKeYCnJ8sBAOVVMGMf3cUV/2c0xNFxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q36ScUAS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D8C1F000E9;
	Fri, 22 May 2026 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779487159;
	bh=BSvl0Fn+97WxpAzACyClnEmJBTO1ko6MtgkNxug71ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q36ScUAS8rf1xhiUAF9xYNIhjjJgz+7mJxcT51YR00V9CBb3QQHGUfBD8qLZ2nOSg
	 j8C69H1Pi6djg6M4LwKQPG9DS3OliRYytk4Kffo8NPrhorEqACSID+A0jC57MUccPD
	 iKn9bJ6GsZ+IyJQMC4PeRMPIgi9lseTvyuLQaZhgY+IG8PuW36eT2rnRcd0pTcmKHa
	 A9RLOKoTxTf2A+v4dIL23RUSNFVZ84tfrL03xGvpCpVhQR4LWTmCVSH/0rxp/IOzbS
	 P4BWbtsTHcB6bJwaLIF+js/Lq83JlLx2XRr2jbu3krOeZMwTxtmxTbPdg4XQ6oTOe+
	 2jgu2U5kfAecg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: idxd: Do not call destroy_workqueue
 with null idxd->wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steve Wahl" <steve.wahl@hpe.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260522203414.336549-1-steve.wahl@hpe.com>
References: <20260522203414.336549-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:59:19 +0000
Message-Id: <20260522215919.65D8C1F000E9@smtp.kernel.org>
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
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10772-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid,hpe.com:email]
X-Rspamd-Queue-Id: 8825A5BADB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver violates Linux device model lifetime rules, causing=
 widespread double-free and use-after-free bugs in error paths and cleanup =
routines.
- [Critical] Error cleanup loops for sysfs device registration incorrectly =
use `while (j--)`, causing an out-of-bounds access or a resource leak depen=
ding on the failure iteration.
- [High] The patch adds a NULL check for `idxd->wq` in `idxd_conf_device_re=
lease()` but fails to handle dangling pointers, leaving a double-destroy vu=
lnerability.
--

commit b2f5425f47723d096641d78d72f8c45caffb8a7a
Author: Steve Wahl <steve.wahl@hpe.com>
Subject: dmaengine: idxd: Do not call destroy_workqueue with null idxd->wq

This patch prevents calling destroy_workqueue() with a null pointer in
idxd_conf_device_release() by checking that idxd->wq is allocated. This
avoids a crash during error paths where the allocation has not yet occurred.

> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d251095c350f..d5ffc641c8567 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device =
*dev)
>  {
>  	struct idxd_device *idxd =3D confdev_to_idxd(dev);
> =20
> -	destroy_workqueue(idxd->wq);
> +	if (idxd->wq)
> +		destroy_workqueue(idxd->wq);

[Severity: High]
This is a pre-existing issue, but is there a double-destroy regression
here if idxd_cleanup_internals() was called?

If idxd_register_devices() fails, the cleanup code calls
idxd_cleanup_internals() which explicitly destroys idxd->wq but does not set
it to null. When the error propagates to idxd_free() and put_device() is
called, this release callback will be triggered. Because idxd->wq retains i=
ts
stale pointer, this check will pass and we will call destroy_workqueue() a
second time.

Should idxd_cleanup_internals() set idxd->wq to null after destroying it?

>  	kfree(idxd->groups);
>  	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);

[Severity: Critical]
This isn't a bug introduced by this patch, but are there use-after-free and
double-free regressions due to device model lifetime violations?

When put_device() drops the refcount to 0, it automatically triggers this
release callback which correctly frees the parent structures and nested
allocations like idxd->wqs and idxd->groups.

However, in init.c routines like idxd_clean_wqs(), the code explicitly calls
kfree(wq) and bitmap_free(wq->opcap_bmap) before or after calling
put_device(). Does this cause a double-free when the release callbacks also
free these resources?

Additionally, when arrays like idxd->wqs are freed in those cleanup functio=
ns
but not set to null, won't this release callback free them a second time wh=
en
called via idxd_free()?

[Severity: Critical]
This is a pre-existing issue, but does the error cleanup loop for sysfs
device registration in idxd_register_engine_devices() and similar functions
cause an out-of-bounds access or leak?

In those functions, the error paths do this:

    j =3D i - 1;
    while (j--) {
        device_unregister(...);
    }

If device_add() fails on the very first element (i =3D 0), j initializes to=
 -1.
Because -1 evaluates to true, the loop executes and decrements j to -2,
which could trigger an out-of-bounds array read (e.g., idxd->wqs[-2]) and a
crash.

If device_add() fails on the next iteration (i =3D 1), j initializes to 0.
The condition while (0--) evaluates to false, terminating immediately witho=
ut
unregistering the successfully added element at index 0, leaking the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522203414.3365=
49-1-steve.wahl@hpe.com?part=3D1

