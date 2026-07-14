Return-Path: <dmaengine+bounces-12497-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NYryM0AtVmor0wAAu9opvQ
	(envelope-from <dmaengine+bounces-12497-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:36:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3437549D3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:36:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UrPZZbTA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12497-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12497-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E714230041CB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08FA449EB6;
	Tue, 14 Jul 2026 12:36:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB7448CF7;
	Tue, 14 Jul 2026 12:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032573; cv=none; b=EY+AtC/BhDFnQw8SV3kj72tXC85/n6Dmah6UkQh2Yg4HSY40e7kyIuaCBZjIOurSHSEpzhgsqKg9o+cigl0ik6QJhxvtUGKzzdqpSudbt2fbkHE4kyz9jxIyLl98n5xPmaVjGbqmLhUMc/dBTdBGrPf3lRPvaGby0qrLvp/XTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032573; c=relaxed/simple;
	bh=b9TtgoyFYkHeVFTrJPUv3nguC7nq6LAuA+FDp2Tmqng=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ieWz/DAMmqCGTKT3vUOS6tWGGVdXhCXkqVHbT5zRoHZk8p+X5Ymf5SQuq0SZcVuVlwEkzcZuZHLJ5rr4qTYAi0+xQlrrn7RvpuO8WHuvDUjujBz0JO8vAzU4psjwC7gl5PrQHCV7JrgpWaxWVEDvphhmDlk4xgp3BWyiF9noxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrPZZbTA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7071F000E9;
	Tue, 14 Jul 2026 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032569;
	bh=kZT5Z2ul6wC3iZrv0Nw2GcNpHjPbc7At9/edEnc7Qkg=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=UrPZZbTAEh6YGXKDalDrxg7NYFAnvD2XRpHhwlhezxIJrbgySiYm/4QfYSTX0l29u
	 t9+6aYKFHKMISHFyEJ8GgUsp+Vq2TC19bnEyoasJZRrQRaoE058bMg1z5g8HPKkZTU
	 KHK4+3A4VpPWdSBpG7ZNoN2sD3XlvNDRAmUh9ZVRhPwiN7FAlYVsXneo0b3C5XUOYU
	 rb6gLX3KFiVD4kZSUCAvG93X2/VhAwpmfamx6oE2+gfN+/XbECIQ6/8ybY9ADYiqTV
	 mTjduzXCdJqAeM9oRZMsV+8wIUrVWx49iYQL7l9EqY50bBLZq+HprCHWfyFexeGPxO
	 9N9wI/sJrgYmQ==
From: Vinod Koul <vkoul@kernel.org>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>, 
 Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
In-Reply-To: <addaf51275355667045ec300fc8d725e2e273807.1782911845.git.adrian.ho.yin.ng@altera.com>
References: <addaf51275355667045ec300fc8d725e2e273807.1782911845.git.adrian.ho.yin.ng@altera.com>
Subject: Re: [PATCH v2] MAINTAINERS: replace maintainer for Altera mSGDMA
 driver
Message-Id: <178403256654.822807.331281330806123127.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 18:06:06 +0530
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
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12497-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org,altera.com];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:olivierdautricourt@gmail.com,m:sr@denx.de,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:adrian.ho.yin.ng@altera.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F3437549D3


On Mon, 06 Jul 2026 10:23:11 +0800, Adrian Ng Ho Yin wrote:
> Olivier Dautricourt has stepped down as maintainer of the Altera
> msgDMA driver as he no longer has access to the hardware. Replace him
> with Adrian Ng Ho Yin as the new maintainer and update the status
> from "Odd Fixes" to "Maintained".
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: replace maintainer for Altera mSGDMA driver
      commit: 49eee9b6c2b5646bd0cfd891bb7c0a218301aa7c

Best regards,
-- 
~Vinod



