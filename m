Return-Path: <dmaengine+bounces-11320-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EcJ6IqGzJmrGbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11320-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:20:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF468656167
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fNB+Sg4k;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11320-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11320-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDF75302D196
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07471372EE4;
	Mon,  8 Jun 2026 12:14:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EC37757D;
	Mon,  8 Jun 2026 12:14:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920845; cv=none; b=nQBZ2EzBlEkhlrNYlVgP7+yvylrtpxtetT9fYAJRyfRIDHuCbYggvqJ/L097a8SdAA0iF4LjwO1zyxRMVbM/AyRU4nf8JWZMFrgG3CpExz3g4LGhm8YUCC3Z7pJGSuCFb2eB68m+wFCnESgUlrgFu+UwMdyBbC1+KyF+OBS/t3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920845; c=relaxed/simple;
	bh=uAkeFGEr+5/XUKcLzDviNGpTqIZwHK2m9Cprm9WdTZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l3uqoLVj4/fAjcvX9ap6K7Hx9LA9eY8O33FEJlCG4x+G9u9rSKt+2r3chQQvjVflMhPZ3CL8DteKcteEUObwZgroUUxcFV0AJUWs0o2d79J85ArZ/IqAFsNM9Shhx7a357zk02iursynZTwZWJ0Je3VyIoQCuc3EL+ZYnG4AL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNB+Sg4k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCC61F00893;
	Mon,  8 Jun 2026 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920844;
	bh=ZJAvrbus89Qbks/IJw+0hx15BuYtV9x1JcauYLr8ETg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fNB+Sg4kojAegBQBisvOiE97KcEM+lqAd5FBdy7T4miiGWcKp02gmTdfQ1Tb8o20i
	 rzVML6h4RUaMKpZ4lUiW+MyY+j0PAVESmsKCFh3X13BIpC/L+8e24+NClS+f2q9lvz
	 bN8zxwVRuGmVqeSl7hZnMRjaXWxT/5Y1IW46sdW8NUAujGYXggVHAEiH9F6mxVNrjv
	 7ryPudnSwufOuQAL3wcf37AY+2buOkV+KgdOZEeftenVdZgCScZCDUYtfz3tG/r8cV
	 wJfUwkUx/RUZba9TAlTut127lqDqIeIRfLqbci/vFcyP7aM8uz3kJsm2dObJKdEFhe
	 htjzGn5KEhotw==
From: Vinod Koul <vkoul@kernel.org>
To: ldewangan@nvidia.com, jonathanh@nvidia.com, akhilrajeev@nvidia.com, 
 Frank.Li@kernel.org, thierry.reding@kernel.org, digetx@gmail.com, 
 pkunapuli@nvidia.com, dmaengine@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kartik Rajput <kkartik@nvidia.com>
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260422064134.1323610-1-kkartik@nvidia.com>
References: <20260422064134.1323610-1-kkartik@nvidia.com>
Subject: Re: [PATCH RESEND] dmaengine: tegra: Fix burst size calculation
Message-Id: <178092084039.97019.1123733589593196697.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:44:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ldewangan@nvidia.com,m:jonathanh@nvidia.com,m:akhilrajeev@nvidia.com,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:digetx@gmail.com,m:pkunapuli@nvidia.com,m:dmaengine@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kkartik@nvidia.com,m:stable@vger.kernel.org,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11320-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF468656167


On Wed, 22 Apr 2026 12:11:34 +0530, Kartik Rajput wrote:
> Currently, the Tegra GPC DMA hardware requires the transfer length to
> be a multiple of the max burst size configured for the channel. When a
> client requests a transfer where the length is not evenly divisible by
> the configured max burst size, the DMA hangs with partial burst at
> the end.
> 
> Fix this by reducing the burst size to the largest power-of-2 value
> that evenly divides the transfer length. For example, a 40-byte
> transfer with a 16-byte max burst will now use an 8-byte burst
> (40 / 8 = 5 complete bursts) instead of causing a hang.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: tegra: Fix burst size calculation
      commit: 4651df83b6c796daead3447e8fd874322918ee4f

Best regards,
-- 
~Vinod



