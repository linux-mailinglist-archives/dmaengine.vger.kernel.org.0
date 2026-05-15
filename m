Return-Path: <dmaengine+bounces-10486-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCskOgs3B2rftQIAu9opvQ
	(envelope-from <dmaengine+bounces-10486-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 17:08:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB72551E7C
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D667301FAB7
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B748AE1D;
	Fri, 15 May 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2+wzFjr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF435A397
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857722; cv=none; b=jC69kXF4+jidfoEHlqJ+Mh6wlYdt0ZN8KLwcuCaBWN1njwwyJ8ql3QW0KpAoM7el02e1ImNwUuGRvuOGUflwNMjh6VsY/wDFf6tP9FksPji309YQQzg9dpZ2I5i8DmmNWh2vUcU48n+pvPMY/CowefzK/F75HpYPTJeHrnkGK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857722; c=relaxed/simple;
	bh=lIpEQrXlajMOFICW7MzNodUJb/HupkFG9o0RzZwkwxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTe0jRfosF4BiVbd6qmzHr1RsSgSgb95P+z7jqUdHT3lmezF3UrV6YrNyuaOEVBsGpSIiAabFJNB+K8zkVaBvBc5do1DretpBeQcfqIpSWXtloKoC2CPMhKlQa/IxebWL72Ym9+zr35MLOqmcZJVdKLpbpRDd6CFdQ0Q5hYcKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2+wzFjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE11C2BCFD;
	Fri, 15 May 2026 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857722;
	bh=lIpEQrXlajMOFICW7MzNodUJb/HupkFG9o0RzZwkwxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=t2+wzFjrAXYZQqeO/w6XOSYxrLnz+9C/WMmzCuOaI0CdPBR0NFGudxQq0Dcj64QOf
	 2ELVno60a4bACSiReH94vUh2VkzH8umvu5YBysnDDJnuL9Umzr7ekqm7XmmR7ODPvG
	 bG0CRUqXYozOwOiCs0FTgw7aHB5mIak9HZOcn0XsEbLhZRnXzV2JGZJj+6m9UBDwfY
	 ioHyOYuxVHO/I5Faqr0MwoAoEjxw1KFenxc6ZSlM+MXLeMBJRYx7xV1ToZLN+d0ZUw
	 xo+3spHs79uj77AnrNI1BocZlSa2ccOiy91PjKBH3YRM6GodchKiFfV0BAx7WVsqoF
	 DYCuQtJ8hQAAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix deadlock and double free in
 idxd_cdev_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260515142623.793549-1-dbgh9129@gmail.com>
References: <20260515142623.793549-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:08:41 +0000
Message-Id: <20260515150841.DDE11C2BCFD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4EB72551E7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10486-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[lists.linux.dev:server fail,sashiko.dev:server fail,smtp.kernel.org:server fail,tor.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware state leak and potential IOMMU fault on ida_alloc() failu=
re path.
- [Medium] Mixing goto-based error handling and scope-based __free() cleanu=
p in the same function.
--

commit e8ca7b853ba46b3d4f21adcfca83ffcc065ffc9c
Author: Yuho Choi <dbgh9129@gmail.com>

dmaengine: idxd: fix deadlock and double free in idxd_cdev_open()

This commit resolves a deadlock and double free in idxd_cdev_open() by
using a scoped put_device() cleanup for fdev. It also adjusts the locking
and reference counting on the error paths when device_add() or dev_set_name=
()
fails.

> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0366c7cf35020..18ff29118d121 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -216,7 +216,7 @@ static int idxd_cdev_open(struct inode *inode, struct=
 file *filp)
>  	struct idxd_user_context *ctx;
>  	struct idxd_device *idxd;
>  	struct idxd_wq *wq;
> -	struct device *dev, *fdev;
> +	struct device *dev, *fdev __free(put_device) =3D NULL;

The official cleanup subsystem guidelines recommend against mixing goto-bas=
ed
error handling and scope-based __free() cleanup in the same function, as it
can create confusing ownership semantics.

Since this function still retains several goto labels for earlier failure
paths, would it be better to either fully convert the function to scope-bas=
ed
cleanup or continue relying on goto for this variable?

[ ... ]

> @@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, stru=
ct file *filp)
>  		goto failed_dev_add;
>  	}
> =20
> -	idxd_wq_get(wq);
> +	fdev =3D NULL;
>  	mutex_unlock(&wq->wq_lock);
>  	return 0;
> =20
>  failed_dev_add:
>  failed_dev_name:
> -	put_device(fdev);
> +	mutex_unlock(&wq->wq_lock);
> +	return rc;
>  failed_ida:

This issue predates this commit, but I noticed a potential hardware state l=
eak
on the ida_alloc() failure path that leads to this label.

If the workqueue is dedicated, idxd_wq_set_pasid() is called to program the
PASID into the hardware registers. Immediately after, if ida_alloc() fails,
the code jumps to failed_ida.

The error path then unbinds the SVA device via iommu_sva_unbind_device().
However, because fdev is still NULL at this point, idxd_file_dev_release()
is skipped and idxd_wq_disable_pasid() is never called.

Does this leave the hardware workqueue enabled and programmed with an unbou=
nd
PASID, potentially triggering IOMMU translation faults during subsequent
hardware activity?

>  failed_set_pasid:
>  	if (device_user_pasid_enabled(idxd))
>  		idxd_xa_pasid_remove(ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515142623.7935=
49-1-dbgh9129@gmail.com?part=3D1

