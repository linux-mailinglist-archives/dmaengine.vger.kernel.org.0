Return-Path: <dmaengine+bounces-11754-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CtBACYCSOmrdAQgAu9opvQ
	(envelope-from <dmaengine+bounces-11754-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:04:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D316B7B79
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:04:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CeKDgpca;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11754-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11754-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07923301E946
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD473803C7;
	Tue, 23 Jun 2026 14:02:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A137FF68
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 14:02:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223376; cv=none; b=TJnUhOM6KYHAwvE4gbX6ns4nvMqHSIoUg2eeHK0az8KUyc/nhav3ZGzZchmqpjJqAqUrkrk2I8uh/htWGVg11JWvU+nDHv5H1plao+OHf/TDqTyttuIjHb2bwANxHDAB6fPBMphuC0FUORlPPh6VV301tWKwzG74ZyIoJfWr5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223376; c=relaxed/simple;
	bh=jh+uEuTwkH3T/NSqPTTmd+f9/dlDEQ6DOmOfFVq2m1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXu6QeR1satGBMmh1fNbE+YVZWrCDtZG1Q9YtibqD8K0kKE/zIY3C7JsW0xj875wsZMab9+tqxl/XnUlKFpSoNxcw6girU/cXS81VHGEYro0OrpOeDrOBtwvgQHhP7hC51OrBT89luK+NP47YsuzIwf2gwDETHCk2RSOSg4BOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeKDgpca; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523301F00ADB
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782223372;
	bh=1gJqQGyMHBR85BVsKfivTVP/l6UvFz79Emx0q7bw7R8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CeKDgpcaWy8GnBxz8C/3kDDRctthG4xFG0iAzgOejG7LM7TjaxVDiGHKX99//jBlP
	 Sxk7K5tlH2fzz4h2k2TrGPAVc55LD+pSgbE4QyT984yKvehjaHyCDSl+1u3Vsz7y04
	 tw56RpbPWkAZuKtsTJK+7wQFuwGRlV3uVcqRfj1+byRN/owfaKVXds4u1IahiO82zQ
	 QAV4y3DF8uk7FxLdF04i9wFBc7DYYMM689U3oal7/BvYGrmkNwoK2MGs6w9fMoYykL
	 YdaC/HX+OmPUjia3AH6Pc71Cib5RZisiD6CKJByiq96R/kOH2RvdAgveoOkCzRaS0k
	 4vnPXGShSRkaw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-befee9e5ef7so695197566b.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 07:02:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8xnQTXUFw0B0Rja4A+ZP9gfn25mq3gs+F3P82BA7xmMPJ90NzRcKxORBYab3wxHB/LWjjEjy1rAnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHbFUtHOYOdY3Kz6ueYk4VJ5lWHGzA1fpx3xOLyv/7zjkNG//
	QDS03OP743Og7uq6a6khE18FEETTrV5U2v5ZxRe/iOW+n6QpDG3hWFWbU3mivX5Sgxv8kt0UWla
	i3COX20Fj+EcR7F3SnstvjCDe6O8LoQ==
X-Received: by 2002:a17:907:980a:b0:bd4:6c96:f87b with SMTP id
 a640c23a62f3a-c097c6c1a5bmr1194059466b.28.1782223370908; Tue, 23 Jun 2026
 07:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331102303.33181-1-akhilrajeev@nvidia.com> <20260331102303.33181-3-akhilrajeev@nvidia.com>
In-Reply-To: <20260331102303.33181-3-akhilrajeev@nvidia.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Jun 2026 09:02:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+bbYZnE=Asv=2VnvTpSsLfKtdpcLvfPzn85hyiyp85cA@mail.gmail.com>
X-Gm-Features: AVVi8Ccz5pQCOoAn6KUfbBzvG9H4BnCCBdmvpJiCWRoaKDN4ysBpqyCY7xc7-v4
Message-ID: <CAL_Jsq+bbYZnE=Asv=2VnvTpSsLfKtdpcLvfPzn85hyiyp85cA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] arm64: tegra: Remove fallback compatible for GPCDMA
To: Akhil R <akhilrajeev@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akhilrajeev@nvidia.com,m:thierry.reding@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jonathanh@nvidia.com,m:ldewangan@nvidia.com,m:p.zabel@pengutronix.de,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	FORGED_SENDER(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11754-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62D316B7B79

On Tue, Mar 31, 2026 at 5:24=E2=80=AFAM Akhil R <akhilrajeev@nvidia.com> wr=
ote:
>
> Remove the fallback compatible string "nvidia,tegra186-gpcdma" for GPCDMA
> in Tegra264. Tegra186 compatible cannot work on Tegra264 because of the
> register offset changes and absence of the reset property.
>
> Fixes: 65ef237e4810 ("arm64: tegra: Add Tegra264 support")
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thierry, Are you going to apply this? The binding change has been
picked up and now there's a warning.

Rob

