Return-Path: <dmaengine+bounces-11319-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JsIuE3SzJmqXbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11319-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:20:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48C656140
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:20:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WKRWJsPs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11319-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11319-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 468253085BBB
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03A37DAD5;
	Mon,  8 Jun 2026 12:13:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274103793B5;
	Mon,  8 Jun 2026 12:13:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920804; cv=none; b=ULlN6ZUrEn1JbeNBKMcB6xAdRJF24RHf14krrHjEHz8XH7mR5Szcz9ftrzzNumg0ORFopAKJROVJBTAm7sjYVuCWIeDqIpJ2oJjpUZKzYZdNLxaFtHir/8JLrROoRjzS5kcpi0bGleetaj+oVtyQcHPnqP32k+BPckGeuVtDTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920804; c=relaxed/simple;
	bh=ig5NwETrx/SLHTYpxBksHmZZkNdPPgVpCvj0meczrW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IybIwX4hyUtXb46elkvUU/+HOy71uNHSzljL6msIEAPAWCNWz3Dp1TLhWd7+CbVH9LJpUfABaBmV7NG8WQlo2ekUg+7isuJNzKIutV7RC5Z9NTe7z3WQ/p9e1vzpxfUzNTg54CRCnxQJKzzILgnPUve4ZVbN2fdvr4ZewY8nF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKRWJsPs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BFD1F00893;
	Mon,  8 Jun 2026 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920803;
	bh=OU8OEzp1Qi520XLK8cQ2vWkkSW166ocfGmUEp/YDK9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WKRWJsPs5zFcNBMvHcMMjSY/UWdEgW3DArXOeCsdRizYuPgYDBvg9rzjcnFwprHHT
	 dTEt2Td0FllxcFa65nACF51AvaXC48TG+w/CbUuj4KiJ5nbCeHdVpthYJA9KjrQxU2
	 l6mFaBoFtwnthdnfJyCtMPLfjijeIuvrkebrAPEUbs0iScpV5EllDh1IER4BDQt8PD
	 MI12VAfbsCgl3pXkwrs5/RUPANnTajj6NDeDvWdX7Q3tLmBi3J3447gNoediq/eXfb
	 K6hlCy3INLXO+5zF2Bk+zkgochmsKBiE0dADKIy9eTSSWm+25kKC3CbE1t8zlYs0RF
	 JyDZjd+4yTlYQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Frank Li <Frank.Li@kernel.org>
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
Subject: Re: [PATCH v4 0/4] dmaengine: dma-axi-dmac: Some memory related
 fixes
Message-Id: <178092080107.96550.13783888741003306021.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:43:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nuno.sa@analog.com,m:lars@metafoo.de,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11319-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB48C656140


On Fri, 24 Apr 2026 18:40:13 +0100, Nuno Sá wrote:
> Here it goes v3. Given there are some discussions about adding devlinks
> in damengine, I dropped the patch implementing the .device_release() for
> now.
> 
> 

Applied, thanks!

[1/4] dmaengine: Fix possible use after free
      commit: 92f853f0645aebf1d05d333e97ab7c342ace1892
[2/4] dmaengine: dma-axi-dmac: Properly free struct axi_dmac_desc
      commit: 4910ce1b3b35687bb2a5e742c4bfbea3c647c980
[3/4] dmaengine: dma-axi-dmac: Drop struct clk from main struct
      commit: a725ac2055271fe8123fa854bfeff6e349f7cf0e
[4/4] dmaengine: dma-axi-dmac: use DMA pool to manange DMA descriptor
      commit: 9e942c8579130e62734c14338e9f451780669164

Best regards,
-- 
~Vinod



