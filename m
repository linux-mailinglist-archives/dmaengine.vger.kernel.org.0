Return-Path: <dmaengine+bounces-11034-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEBFGuEzGmrQ2AgAu9opvQ
	(envelope-from <dmaengine+bounces-11034-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 02:48:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A160A591
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 02:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7932B3084870
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 00:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959552C11EF;
	Sat, 30 May 2026 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leeoZkVj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9929D27D;
	Sat, 30 May 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101961; cv=none; b=Da5I+r8KVfEJUHjj4U7BA0IbDcfbPaNn8faEbF3lVqlmrNmTydQxR2jypqHX8JsyD1iUYzk1regLfZeghjJT2+5u0rkEoo909SBmWpLchsdo7XyXGmHL6Ycw946jc4B62YHSWD4SSIHT02A9BmpzvQM7zUjTppZoPTh/uafFFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101961; c=relaxed/simple;
	bh=ncJ2789ZxEManu0umNRfq8NgXuKtoilCWAr6G05xwaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AR9jXBsGXXOTCyJEf7DBQULmrBjmu/vLkdHnyWivEL4oQj4qwEuKTXyVtohzwNWpMX4QiMO/z9gvSB5zwMUF2w1PmweKoJQE/3ZiAfgOBG/hFZJcGyduOCviZ0MtaYzFGysHjuke/iE5B/7MB7skPoFsDiwkGomfxIdVPhCvxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leeoZkVj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82371F00893;
	Sat, 30 May 2026 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101959;
	bh=2JOWVvGPu8d06NpwIW3hSQNiXstDCk/vkp0BSRFR6RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=leeoZkVjkxCCKvr0U2PNFo0a+Dg6KKjN3LuN4AGfcS4aTIJ8nxk4ZLJ158d0xQRBT
	 OxvkrKhjGZPl2XyZeXERlkS4opM7vR9Ytde/f2XaQOo3FLzTzjadbFc2cDxXZ0luAr
	 0dT+NEDvATSmwVQZGWjYMeS6OYHrRYv1gAcut9QI41VfD526wxobn4tvQ379iqt8K/
	 KtFT8PpNSMpyumRyOMZb8l5g0Nqr8y97MiBYjT3TLyBkH0bidOd/GNDPKE9fwfkcaO
	 scIE2SfYKJoVEaqsqrDxmQchflM6MTIXBF09YjIAz4htPHFtqKCrkpiOGnLL5t/zge
	 Usgyqzy3dSjUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] moduleparam: Add seq_buf-based .get callback
 alongside .get_str
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, linux-modules@vger.kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260521133326.2465264-6-kees@kernel.org>
References: <20260521133326.2465264-6-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:58 +0000
Message-Id: <20260530004558.A82371F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11034-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: E11A160A591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent data truncation and spurious kernel warning when the sysf=
s buffer is exactly filled.
--

commit 6802395b5f9f236d2cc29365e6d39e6de2eae4ca
Author: Kees Cook <kees@kernel.org>

moduleparam: Add seq_buf-based .get callback alongside .get_str

This commit adds a new seq_buf-based .get callback to struct kernel_param_o=
ps=20
to format parameter values safely. It updates param_attr_show() to prefer=20
this new callback when available, using a page-sized buffer. The legacy=20
.get_str callback is retained as a fallback.

> diff --git a/kernel/params.c b/kernel/params.c
> index 6852caea17854..4eda2d23ddf28 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
[ ... ]
> @@ -553,12 +553,34 @@ static ssize_t param_attr_show(const struct module_=
attribute *mattr,
[ ... ]
>  	kernel_param_lock(mk->mod);
> -	count =3D attribute->param->ops->get_str(buf, attribute->param);
> +	if (ops->get) {
> +		struct seq_buf s;
> +
> +		seq_buf_init(&s, buf, PAGE_SIZE);
> +		count =3D ops->get(&s, attribute->param);
> +		if (count >=3D 0) {
> +			WARN_ON_ONCE(count > 0);
> +			count =3D seq_buf_used(&s);
> +			/* Make sure string is terminated. */
> +			seq_buf_str(&s);
> +			/*
> +			 * If overflowed, reduce count by 1 for trailing
> +			 * NUL byte.
> +			 */
> +			if (seq_buf_has_overflowed(&s))
> +				count--;

[Severity: Medium]
Does this code silently truncate data and trigger a kernel warning when the
buffer is exactly filled?

If the .get() callback writes exactly PAGE_SIZE bytes without triggering an
overflow, seq_buf_has_overflowed(&s) will evaluate to false because s.len
exactly equals s.size. In this case, count remains PAGE_SIZE.

However, seq_buf_str(&s) unconditionally writes a NUL byte at the end of the
buffer, which will replace the last byte of valid data at PAGE_SIZE - 1.

Furthermore, returning PAGE_SIZE causes the sysfs core to print a bad count
warning to dmesg and truncate the count anyway. Should this code explicitly
decrement count when count =3D=3D PAGE_SIZE to avoid overwriting data and c=
ausing
the warning?

> +		}
> +	} else {
> +		count =3D ops->get_str(buf, attribute->param);
> +	}
>  	kernel_param_unlock(mk->mod);
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521133315.work=
.845-kees@kernel.org?part=3D6

