Return-Path: <dmaengine+bounces-10984-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAdIHo5YF2oPBQgAu9opvQ
	(envelope-from <dmaengine+bounces-10984-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 22:48:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B95EA2BF
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 22:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C243006971
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C23B637F;
	Wed, 27 May 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko5NfgTK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96083377EA7
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914889; cv=none; b=iI56Z9sduTY7s2O7YMosq4hsdTDKPu+d8vrjmgPL4T/EEJay3ak6uEeg6w+FO3+XfC10Wg3SDMghRRjX/h1O3eGTI+YecYSYxcC/+DX34nMLDF10CVJbr/XG74tc87ECOdu+v6hJi5qFtAw/va5wwxbWEEqUCKMekCJZ1rAtGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914889; c=relaxed/simple;
	bh=WmwTFRHsFeMbetSjEyp3E1mOrqbT6Tf4M1fKlCtEorY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDnAYb6+AzRdLOIpLMe3r0O0UqHDRlASvDPJt8NqeGUhysHW0QqepVRR50KisGL4NROrMCw3xDoKKyiMXoOEJP36TiN4J1lHjyWR2r22mecUjRrZXKsh53J8rEgf4SrwNJu+gyd+Mh7dqcQBsALU9sTdDjrntwPegxerY00CCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko5NfgTK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDBC1F000E9;
	Wed, 27 May 2026 20:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779914886;
	bh=cUEehyB8acw4VuPzBZINZXNsLOBaNRX8rFLezggANOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ko5NfgTKojYIJNN2ZxnC/EgVwGN9YHej1SIKigCRovjM1rYvCXM5EkNcBtPc0jTJb
	 64Gcktv7hPI5jxYP8l5rCwZHZkJIW8UkxDE/eLs4/rFAUJgIX5i31YZrZlr4i+RR8z
	 r9+k6Jvx2hesT8sCei8vfvy7fpX1hu5V7hIw0MFMyuk/9G2JrTr85igCTdnAmtM8+l
	 /IHnrKkG/VA8mIvH8W1kRlI43R5OgsTxMwOwiWBobaP02LLIXxPaJ6O1axGi0bOUhk
	 6sPk7znp/KtYenxOuVm04lqFfWpnvV1ajXCmCIyPrmr3Q1G7evYtDXHWAxDNQbDici
	 YcO8PTJRHp5yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260527203126.7053-1-rosenp@gmail.com>
References: <20260527203126.7053-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 20:48:05 +0000
Message-Id: <20260527204806.1DDBC1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10984-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C65B95EA2BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Defeating struct_size() saturation arithmetic with unchecked addit=
ion can lead to a heap buffer overflow.
--

commit e3bf7e1250eb198cd9bf4617a8f0c3d6cc4d796b
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array

This commit converts the separately-offset phy_chans pointer to a C99 flexi=
ble
array member at the end of struct d40_base, switching the allocation to
struct_size(). The log_chans and memcpy_chans slots continue to live in the
same allocation immediately after phy_chans.

> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9b803c0aec254..d3e3c4cd43f17 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c

[ ... ]

> @@ -3197,10 +3198,9 @@ static int __init d40_hw_detect_init(struct platfo=
rm_device *pdev,
>  		 "hardware rev: %d with %d physical and %d logical channels\n",
>  		 rev, num_phy_chans, num_log_chans);
> =20
> -	base =3D devm_kzalloc(dev,
> -		ALIGN(sizeof(struct d40_base), 4) +
> -		(num_phy_chans + num_log_chans + num_memcpy_chans) *
> -		sizeof(struct d40_chan), GFP_KERNEL);
> +	alloc_size =3D struct_size(base, phy_chans, num_phy_chans);
> +	alloc_size +=3D sizeof(*base->log_chans) * (num_log_chans + num_memcpy_=
chans);

[Severity: High]
Can this unchecked addition defeat the saturation arithmetic of struct_size=
()
and lead to a heap buffer overflow?

If struct_size() detects an overflow and saturates to SIZE_MAX, this
unconditional addition will wrap alloc_size around to a small integer value.

As a result, devm_kzalloc() might succeed in allocating an undersized buffe=
r,
causing an out-of-bounds write when the channels are later initialized or
accessed.

Since phy_chans, log_chans, and memcpy_chans all use the same type and are
allocated contiguously, should the counts be summed inside a single
struct_size() call like this:

    alloc_size =3D struct_size(base, phy_chans,
                             num_phy_chans + num_log_chans + num_memcpy_cha=
ns);

Alternatively, the size_add() and size_mul() macros could be used to preser=
ve
the saturation protection.

> +	base =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL);
> =20
>  	if (!base)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527203126.7053=
-1-rosenp@gmail.com?part=3D1

