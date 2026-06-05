Return-Path: <dmaengine+bounces-11213-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D2c0O2tLI2q2oAEAu9opvQ
	(envelope-from <dmaengine+bounces-11213-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:19:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD964B9B5
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:19:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I7+RPgdj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11213-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11213-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 021CD3004F02
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373022FF22;
	Fri,  5 Jun 2026 22:16:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8840256C84
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:16:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697814; cv=none; b=J8MeLSjMWeIE8ImcAp0LknPw9uOVafTfxiOWJhOcaRrlTGv1/Ausoiw1/cqiu01IhyENLXa9dnbPiqS7UMKzMqzfycxuX26F0NKN8+mIYgRO7CuZlM6jBiAm4WxNxRqVaoDpyRtoFuPKJQSYTS1SdCFuYehr9o5GBDcXkD+PSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697814; c=relaxed/simple;
	bh=wu0KjFBU6gM69nvkN5g1NtCeakMwBXFyaycSEeS1t7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHi7kYb+mAvRIVHFV85klAW9dBYfcOQST3ZRXfXjsuWgZCjOGU0ussUrWYW7YjezU3YGN87UROQXeY6Z+5PmuG2r6EHjq7osqjlL4EbLPsdUXmNVMssFNpMd/37jjUNm3VUZHD5OYT5fHTQ64HenLIzWi64NeQWhJnp52Jw4/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7+RPgdj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424F81F00893;
	Fri,  5 Jun 2026 22:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697813;
	bh=Fexy7G1ZyuctRIcVBENtP/+0xS0GMCXLKGB/Gyh8KAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7+RPgdjG5QDp++DlZkaQqzw0RDA4golUntMMQqE5w6Yg62xAVdJz67hKxerbcKv4
	 HNq2IcrlsASwH0f4O/O5r/Hx/Shw7FXwxrShEwxZUq8VPYqLkgDrV9HYyBaZGG/ljc
	 622aYhTAm0Pt9VH3Wa1xXveB+8xTHi2Tt8y7VHYlzvm+P+rtOthXIxMH9EpGG9gKsH
	 s7eLjUk1JZKeX3oA+HN2amgThgQtHCcmMvpdoM0bkWHvCKbXZdNysozNtSitx85mTr
	 kct+dzO0l8+a2UwfdV8PpQkrBHmxeI4WNG37l8p/VYjyeExyvkBfTOEIOocxuH6+Sx
	 AC/CAmR/MhXgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] dmaengine: fsldma: convert ioremap to
 devm_platform_ioremap_resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605220134.43295-6-rosenp@gmail.com>
References: <20260605220134.43295-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:16:52 +0000
Message-Id: <20260605221653.424F81F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11213-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89CD964B9B5

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Commit message inaccurately claims to remove the 'out_return' la=
bel.

Pre-existing issues:
- [High] Missing IRQ cleanup in probe error path leads to resource leak and=
 Use-After-Free.
--

commit 377d9333b3cd60b40444ff2c8de7a2822f91747a
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: convert ioremap to devm_platform_ioremap_resource

This patch converts of_iomap() to devm_platform_ioremap_resource() in
the probe function of the fsldma driver. It delegates unmapping to the
devm framework and removes the manual unmapping from the error path and
remove function.

> Convert of_iomap to devm_platform_ioremap_resource to let the devm
> framework handle unmapping. This allows removing the out_iounmap
> label, out_return label, and the explicit iounmap in both the probe
> error path and the remove function.

[Severity: Medium]
Does the commit message inaccurately claim to remove the out_return label?

The diff for this patch only removes the out_iounmap label, so it appears
out_return may have been removed in an earlier patch.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 2efa16d12679a..2a6a247761a47 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
[ ... ]
> @@ -1309,8 +1307,6 @@ static int fsldma_of_probe(struct platform_device *=
op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}

[Severity: High]
This is a pre-existing issue, but does this error path fail to free the
requested IRQs before returning?

If dma_async_device_register() fails during fsldma_of_probe(), the code
jumps to this error path. At this point in the series, the IRQs are managed
via manual request_irq() calls inside fsldma_request_irqs(). However, this
error path fails to call fsldma_free_irqs().

As a result, the IRQ handlers remain registered while the underlying
devres-managed memory (fdev and chan) is automatically freed upon returning.
A subsequently firing interrupt will access freed memory, causing a
use-after-free.

While a later patch in the series converts this to devm_request_irq()
(which fixes the leak), the use-after-free risk persists even at the end
of the series because devres unregisters the IRQ after fsldma_of_probe()
exits, allowing an interrupt to fire and reschedule a killed tasklet.

> -out_iounmap:
> -	iounmap(fdev->regs);
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605220134.4329=
5-1-rosenp@gmail.com?part=3D5

