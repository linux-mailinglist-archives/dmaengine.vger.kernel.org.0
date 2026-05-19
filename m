Return-Path: <dmaengine+bounces-10563-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN/GGuCgDGq8jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10563-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:41:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA405833C2
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92D933013AAE
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC43438A1;
	Tue, 19 May 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3ZEqBwD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4C343894;
	Tue, 19 May 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212450; cv=none; b=a+5gaCNGT99N6pskptG0wQcv6cbBN4UIGpY+LnYos1j5ojnBki/q9h0TGIUXJah4bJWirBv5cjgEMnst6/Q8CtMk6jOEM/mqLH/Qf6CoTpM3Nh2FOHj02B5GKaesuzLyHdXuitpEHYELtdoRwl5ZR5GHjKxBWWv4HLoiNjVGLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212450; c=relaxed/simple;
	bh=roncchQ6gRIvDa6f3EmKw01L4C9zHft5fUpPmg64Ig4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=duPgeeN2VhGTRyMb8PEVq2Sv1fso6e6p9UXaj3ZatQDE9MuF8PcRn5Ebi5Os/YNdns9RiVz4kA+bYHQ5r4slhGvcCgd4N6D6BaDekgUkybjg/1bovTuRX74UkXJliozld48xw29U5s0EDgrpfzWVnTTG0yceF7AwovPUwR9B9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3ZEqBwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194C8C2BCB3;
	Tue, 19 May 2026 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212450;
	bh=roncchQ6gRIvDa6f3EmKw01L4C9zHft5fUpPmg64Ig4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d3ZEqBwDa0DWUqJMsmhhTGT6C+kFcGKS5uTqPAQOpmOobLBT0fgvJcqyeRw+ryL9h
	 uKPsi8d8WIT8FLjU4PE0psjZj8upRSI2NCeBS/9H4JDA6kNuTfBFNBL+BTvjHc5Epj
	 Cn58lvbDWYVTNY79TkHeFQl2NuxqSy0eDsv51JUNatQeGGG4fuyu5vKH7kg0vBbkwW
	 gUM/UJr/r67cSryalNsrSgXMH9bx4cJgeEEEJhdio39kwEYFZz1CBS/llPTL2UZ28A
	 SzzDExhuaWi+f8a9llPCX8rD5T78XW20un6Hk0QMZzzneefZAlKvZIVzU29m4b6iEY
	 LT0IUyJsw8Q4A==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
References: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
Subject: Re: (subset) [PATCH v6 0/4] dmaengine: Add Peripheral DMA support
 for SpacemiT K3 SoC
Message-Id: <177921244361.339411.17197667376748873904.b4-ty@kernel.org>
Date: Tue, 19 May 2026 23:10:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10563-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0DA405833C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 18 May 2026 11:32:40 +0800, Troy Mitchell wrote:
> This patch series introduces Peripheral DMA (PDMA) support for the
> SpacemiT K3 SoC, leveraging the existing mmp_pdma driver.
> 
> The K3 PDMA IP is largely based on the design found in the previous
> SpacemiT K1 SoC, but introduces a few key architectural differences:
> 1. It features a variable extended DRCMR base address for DMA request
>    numbers (>= 64) depending on the hardware implementation.
> 2. Unlike the K1 SoC, where some DMA masters had memory addressing
>    limitations (requiring a dedicated dma-bus), the K3 DMA masters
>    have full memory addressing capabilities.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: dmaengine: Add SpacemiT K3 DMA compatible string
      commit: 55620b11186c81757b05fb8e2df9ddc7127d6fd2
[2/4] dmaengine: mmp_pdma: refactor DRCMR access with helper function
      commit: f46b47623e70dea8b03794a5420ffba060425e85
[3/4] dmaengine: mmp_pdma: add SpacemiT K3 support
      commit: 6587b8661a0b61c2f4b260bfc9f0e9ef9de0ea2e

Best regards,
-- 
~Vinod



