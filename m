Return-Path: <dmaengine+bounces-11021-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI1KOKuqGGoomAgAu9opvQ
	(envelope-from <dmaengine+bounces-11021-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 22:50:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D05F9B0A
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 22:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 622C830DCCAE
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3031DE4E0;
	Thu, 28 May 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFwTnXev"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC12F1FEC
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000995; cv=none; b=C6OqDwLYN6+bWmeXKDlcLsMao/yojOp3XS595qKwefk/Q/tqDLOUaaHCMJIgn0W5QkFyTwV/kqlWdBg3qH2ImXLxlxs+ChEuHyxHdtnjKj8yt1Xjy/NYSZOhpeZDjozRif4AMr2XnW8FajP8BkVdKC64aTZfQAAwUjwlvq/+g9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000995; c=relaxed/simple;
	bh=9JhyfOj9cMjMelMScz/ROv95avBfIknsr7HJU4AAerQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pcc87vmsmXpKsovtNUAMVbKxPSoNZxDwkL/E6Ewoc4JY7yOjs8ppg1Aq3YTlwO1sfXJPhnGPUTXBtnIjItvEApKW1594sWGWyir/mqa6pMsUHnUPPBeSHxhAT5R54TUceJmzxLPgw9iazzabB/vOFisZV3CgT8q7S+EM952kFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFwTnXev; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881241F000E9;
	Thu, 28 May 2026 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780000994;
	bh=kpb/mieu9R9Z3mTLIp5gnE3998YQEdjqR1T9LNiD1aU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFwTnXevOsrvY10Q8cKQWzQCqdsqY88aZ+PrvQPBZ1myFrZwy60y10oRtxOERrjrE
	 plEkzImN2oqKR5V6tSwXHVXtiApkWLqKVVrMQCZexzSIk7fnXx9Ag1+dSmc3rPpb/V
	 t/V/oV2D7cloSqDFSjZTKi5RuFzrELDW16/9ZZZB6U2g+st4MvhLUR9JT7698HMKdG
	 VQjMRHqkRweak6Zz6aGCZrfePkTh2O58M+7f7q96x+ouYCr2LAseQys+7dMdrjZt8E
	 /tguu7wMdkEbE3Sm2HDLMHRiCdLz6tC8f+V12sGFDeh1V+59C77d5y0ZesJAztfNKs
	 rcH0sMx7516zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma: bestcomm: gen_bd: split struct bcom_psc_params
 from array definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260528203534.137794-1-rosenp@gmail.com>
References: <20260528203534.137794-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 20:43:14 +0000
Message-Id: <20260528204314.881241F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11021-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 588D05F9B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit completely removes the documentation block for `bcom_psc=
_params` instead of fixing its kernel-doc format or retaining it.
--

commit ca2ec5c8d7bd735d412b27e8045b30e921157753
Author: Rosen Penev <rosenp@gmail.com>

dma: bestcomm: gen_bd: split struct bcom_psc_params from array definition

This commit separates the struct bcom_psc_params definition from its
array declaration. The split is intended to fix kernel-doc parser
confusion caused by the combined struct-definition-with-initializer
pattern.

> diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
> index 8a24a5cbc2633..0b400a76adcf0 100644
> --- a/drivers/dma/bestcomm/gen_bd.c
> +++ b/drivers/dma/bestcomm/gen_bd.c
> @@ -253,18 +253,14 @@ EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
>   * PSC support code
>   */
> =20
> -/**
> - * bcom_psc_parameters - Bestcomm initialization value table for PSC dev=
ices
> - *
> - * This structure is only used internally.  It is a lookup table for PSC
> - * specific parameters to bestcomm tasks.
> - */
> -static struct bcom_psc_params {

[Severity: Low]
This isn't a bug, but the commit message mentions fixing the kernel-doc
parser confusion by splitting the struct and array definition, yet the
actual kernel-doc block is completely removed here.

Was it intentional to drop this documentation entirely rather than keeping
it attached to the separated structure or array?

> +struct bcom_psc_params {
>  	int rx_initiator;
>  	int rx_ipr;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528203534.1377=
94-1-rosenp@gmail.com?part=3D1

