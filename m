Return-Path: <dmaengine+bounces-11253-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id otflEt9nI2oLtAEAu9opvQ
	(envelope-from <dmaengine+bounces-11253-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:20:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5164BFEE
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:20:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ierKsVEH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11253-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11253-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A80A53014513
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F3A196C7C;
	Sat,  6 Jun 2026 00:20:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC433BB4A;
	Sat,  6 Jun 2026 00:20:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705240; cv=none; b=uIPTRRMUKf3QS8dLVOFEu5jwJYQqWRrSdrXLLvTTMFU/QNIXm6lamzlO3h9RVnsHwueKR+Uh26MBRz5F1qHoJrXU66swfDlwojJ2RsQZ+p5l5Todu3cfA+H6iDwPgeR7txmSt81K98LKnwX1qFeqnSC6VkdPN45Ze3OMglWgJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705240; c=relaxed/simple;
	bh=GmwpaXntuFULSz70gEdcEIe/DXcA455nmyDJATnbwgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qu/GXLqvpni/5cTj3gwbvq3tPtwL5ypHm4Lq7gH6FpzJdoNxQOSRIicVyEPDWzOFy5LXDNNaXffB2LdAVXGviEXHsa+9cFCfRqLvmh1pWxdlUTtguKl5177kXtOL21ZClvjUI0uAVpZwk1Tv4AC6yO6Bp21aUlzfEgKIQV1Z8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ierKsVEH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7594D1F00893;
	Sat,  6 Jun 2026 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705239;
	bh=6h27/jJZuKC/ucShwNwbROrMLJdcZOaMxuylIy4Yhj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ierKsVEHOhce54fdy0UXz88mVpM7MEXEdfXEah3U2+4kzOhz68n9ghPm69Fz822Yd
	 9MaxKHu/ZnAQgByqY5zcdgvAOwAkqXXPbQbBAC4la4jefZijVOZ3u0/IZip8LDLMtX
	 QAP3y2ztajf18Zvj6jRpgpBjQI3+gH1prQMt9rO9aytw9V82YVzqRlvFKDeaGreGk/
	 B+4uU7oIix964gwPVwRAbq2ADs6HGuAz6SHuJtCudEs87RZh8Y+7IWuoKcrOPptDSt
	 A7Ie1CsbSfAFjDfO8ThdN/+UEeXP+18khVqrzeIdX4vcbEsKYByNVEDFyJWolhDYvw
	 79xoIPW45dYJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/23] dmaengine: sdxi: Encode nop, copy, and
 interrupt descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-20-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-20-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:20:39 +0000
Message-Id: <20260606002039.7594D1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,amd.com:email,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-11253-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8F5164BFEE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Use of WARN_ON_ONCE() for normal input validation leading to pot=
ential DoS, and subsequent dead clamp_val() code.
--

commit 7911601fb1520af0d6b7d063a371eaff05507d92
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Encode nop, copy, and interrupt descriptors

This commit introduces low-level support for serializing nop, copy, and
interrupt operations to the descriptor ring of an SDXI client context.

> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> --- a/drivers/dma/sdxi/descriptor.c
> +++ b/drivers/dma/sdxi/descriptor.c
[ ... ]
> @@ -7,12 +7,119 @@
> =20
>  #include <kunit/visibility.h>
>  #include <linux/bitfield.h>
> +#include <linux/bug.h>
> +#include <linux/range.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
> =20
>  #include "hw.h"
>  #include "descriptor.h"
> =20
> +VISIBLE_IF_KUNIT int __must_check sdxi_encode_size32(u64 size, __le32 *d=
est)
> +{
> +	/*
> +	 * sizes are encoded as value - 1:
> +	 * value    encoding
> +	 *     1           0
> +	 *     2           1
> +	 *   ...
> +	 *    4G  0xffffffff
> +	 */
> +	if (WARN_ON_ONCE(size > SZ_4G) ||
> +	    WARN_ON_ONCE(size =3D=3D 0))
> +		return -EINVAL;

[Severity: Medium]
Is WARN_ON_ONCE() appropriate for input validation here?

Since dmaengine_prep_dma_memcpy() doesn't filter out 0 or sizes greater
than 4GB before calling the driver, requesting an unsupported transfer size
will trigger a stack dump, and potentially a system crash if panic_on_warn
is enabled.

> +	size =3D clamp_val(size, 1, SZ_4G);

Also, since the condition above returns -EINVAL for out-of-bounds sizes,
is this clamp_val() call unreachable dead code?

> +	*dest =3D cpu_to_le32((u32)(size - 1));
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_size32);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D20

