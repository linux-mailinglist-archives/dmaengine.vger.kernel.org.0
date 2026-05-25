Return-Path: <dmaengine+bounces-10878-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCW0DlVpFGr5NAcAu9opvQ
	(envelope-from <dmaengine+bounces-10878-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 17:23:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE875CC373
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 17:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3454304C61E
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93629827E;
	Mon, 25 May 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duNA/R2c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0B3F0AB1
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722405; cv=none; b=LKyv9OPnurPnTtBeoYZmSf+rIQFbouvI96K8Df6Bki3GTiv9ijPHBSxwdAf3NbT02WzKDFOHdUIZf9K+L/QN2Hh4YMdxsrfnRKXxo624LB6TUxoGqFsoPYv3F+0k8gEp7wOgAoLWmzEfr6fVwUsaWGr4LrpmnzM5luO6EwJbtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722405; c=relaxed/simple;
	bh=IXFobVuuxgh0CPTEb2jIFMgofjq4i95uNK0aThTYw+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tD6gWyarFNITl6V1vVMgCyw1g1lbA60p8vvcBchGVc7W5ACEusFPpHVedo0GNDO0jtBPhxxt3AGiqoDuxKvkGnuC+30FJnM87p2peZAgrioRzGVdj2spZqtRTUCQv6CAgrKcCsKt/8DE3ZaJ6DdQGMTcOVE9PXguGzGATq2Svfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duNA/R2c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548991F000E9;
	Mon, 25 May 2026 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722403;
	bh=M1C7Tapb3fMiAZtx9i3w4msdqYkp+MULCx69jO88XUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duNA/R2c8zHTfruvnKX2yGKxrsmKY81ZAw86ewZZVDQ9VUWfV5z30DfMw4ZYkot9D
	 5cu+gv5S7z7zhrVENpNi9KZ+mKD6+OXI06WRjpQZF8KnCUuIiUH8qA9gaTOwFfnM1W
	 PNvxCMgbYUocN/eVtjDmn6nIj+GHV0gc+MzgRSwQDI/Lv5CPPQ0Hime/qTJOHGPJ/Y
	 U9iP91GkX6t8YPFkTGA8frNHqfcj3pQLs34sf+RpfYIupehuxA+wIuzuljO0MQTQKK
	 vZGPhPE/d8mx1msBEv1G1+MR8C8gwFJ1XJvUAWfCNVtSw+kvO9Bjoq9Pdk0f0Km9gN
	 pc/bcAGnKbGdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dmaengine: idxd: fix fdev setup failure cleanup in
 idxd_cdev_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260525141550.1385581-1-dbgh9129@gmail.com>
References: <20260525141550.1385581-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 15:20:02 +0000
Message-Id: <20260525152003.548991F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10878-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 8DE875CC373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] If `ida_alloc()` fails in `idxd_cdev_open()`, the error code i=
s not assigned to `rc`, causing the function to return 0 (success) while le=
aving `filp->private_data` pointing to a freed context.
--

commit 51406f4c692bf6e1cbab1fe293fc2fda433beb08
Author: Yuho Choi <dbgh9129@gmail.com>

dmaengine: idxd: fix fdev setup failure cleanup in idxd_cdev_open()

This commit fixes a deadlock and use-after-free during file-device setup
failures in idxd_cdev_open(). It moves idxd_wq_get() to occur before
potential failures and adjusts the cleanup path to return directly, leaving
context cleanup to the release callback.

> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
[ ... ]
> @@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, stru=
ct file *filp)
>  		goto failed_dev_add;
>  	}
> =20
> -	idxd_wq_get(wq);
>  	mutex_unlock(&wq->wq_lock);
>  	return 0;
> =20
>  failed_dev_add:
>  failed_dev_name:
> +	mutex_unlock(&wq->wq_lock);
>  	put_device(fdev);
> +	return rc;
>  failed_ida:

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for rc to be
0 when reaching this label?

Looking at the ida_alloc() call earlier in this function:

    ctx->id =3D ida_alloc(&file_ida, GFP_KERNEL);
    if (ctx->id < 0) {
        dev_warn(dev, "ida alloc failure\n");
        goto failed_ida;
    }

If ida_alloc() fails, it returns a negative error code to ctx->id, but rc
is not updated and remains 0. The function then jumps to failed_ida,
eventually frees the context, and returns 0.

Since open() returns 0, the VFS layer treats the system call as successful
and returns a valid file descriptor to user space. However,
filp->private_data was already set to the freed ctx earlier in the function.

Could this lead to a use-after-free if subsequent file operations (like
write() or close()) dereference the dangling filp->private_data pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525141550.1385=
581-1-dbgh9129@gmail.com?part=3D1

