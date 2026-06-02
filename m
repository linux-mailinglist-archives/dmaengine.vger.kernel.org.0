Return-Path: <dmaengine+bounces-11116-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCoLL0KaHmoAlQkAu9opvQ
	(envelope-from <dmaengine+bounces-11116-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 10:54:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9F62AE88
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 322D130143C2
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1333C768B;
	Tue,  2 Jun 2026 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CriX9yZM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A263C417E
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390102; cv=none; b=RbshTV1s8Vp3I6rksEK+IA5WALq/+CN3fMYVHgxi8aG87l8URweCGadBGa+T9NUqQwE0cbixO7M1rS+LDOusL2gadXiMtLdfCTgJ5/Oe0nFLBaFk6G8FWJkeCU8jPeFb3/DL1aCoswL0+aqH5IhtnYZrdC0H9U+ocdy+0139798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390102; c=relaxed/simple;
	bh=e+o5C/P5d0I6Vm020HBIaK4nbIwFltOYMA3AQE33m2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJ1dkyx5KBGofJfikYAOhSOrVZm1EugmdVgtllV4Z9usNOG77pByB36+Jn1BNS4YhtXzpbeKNgaP7hmgOPTW6E3+U3DTJG/tiNI1DbCSI2sdS06xxILeNdkD2uN7OYzLY5gzjMtVGK+vvRPl/rbw4v9D9swBHoakPzDkZxm4wSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CriX9yZM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11071F0089D
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390099;
	bh=TQremWpHulJgA0xC8GSKmqUNN54WassWQxieEBKaLLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CriX9yZMrlWbbMCO4OGOj9hb1zc1jzbOGRQqIHPYwVhbSc3iCfZ44gkJP781UnyhC
	 b53iKrtZODPXLiOm0VBe//FWhNFgBVZ1w+jjT85A8phdi7ZgS1l9PPxrD6FT/YGRGJ
	 4qovy+zAdjciDRwwOB5dGigOORfauhv8ypWPP/PlT04frThefM2HRgOg6doMD5tsIP
	 M93uc+qAhnmmPtNe9WaamSYm6nUVOsIHEIRfhxA6XkYUFGVyqmi32NNRt3RQ4knBLl
	 jEXp+raygM8GEeVj9L0b+9zDCiBSVbuViA7XXSTv4hvepkgpDHKsk+BvzIL0/l5XIc
	 ABiLaEhrCW51w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so2284312e87.2
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 01:48:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzvCC/nE4GADLsYSeyG7yWx+iIS8a3r+rACeTDhXO3QSRC88H0H
	jrPRqzg75kPRTezWqd++MIpcj7bQYjvcdZLJ7i6Hh+FOzWcGtEoRfJyCdS1xdNEyqvJwSBHDXI3
	TvLs7TyjKymFA/dUpZuVrq8z6UVDNGng=
X-Received: by 2002:a05:6512:3d08:b0:5aa:6d0f:1dd3 with SMTP id
 2adb3069b0e04-5aa6d0f1e9amr2405110e87.20.1780390097725; Tue, 02 Jun 2026
 01:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531210747.11401-1-rosenp@gmail.com>
In-Reply-To: <20260531210747.11401-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 2 Jun 2026 10:48:05 +0200
X-Gmail-Original-Message-ID: <CAD++jLk3HmmTBfjLaVKBcRi87EmAdzs9BGy6teerJ-rN92MtCg@mail.gmail.com>
X-Gm-Features: AVHnY4KpUZtZBbTRTEr9Tn5IC1OGG9aYmmZvoErnhrvt_7GfLjmo4gWCXcriDrE
Message-ID: <CAD++jLk3HmmTBfjLaVKBcRi87EmAdzs9BGy6teerJ-rN92MtCg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: fix out-of-bounds access from D40_MEMCPY_MAX_CHANS
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11116-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 50C9F62AE88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 11:08=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:

> D40_MEMCPY_MAX_CHANS is defined as 8, but the dma40_memcpy_channels[]
> array only has 6 elements. This mismatch causes an out-of-bounds
> issue:
>
> 1. d40_of_probe() accepts up to 8 memcpy channels from DT
>    (num_memcpy > D40_MEMCPY_MAX_CHANS allows 7-8), then writes them
>    into the 6-element dma40_memcpy_channels[], corrupting adjacent
>    stack memory.
>
> Fix by defining D40_MEMCPY_MAX_CHANS as 6 to match the array size.
>
> Fixes: a7dacb68b35a ("dmaengine: ste_dma40: Allow memcpy channels to be c=
onfigured from DT")
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Excellent find Rosen!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

