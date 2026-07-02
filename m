Return-Path: <dmaengine+bounces-11984-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hKG+IBuORmoGYgsAu9opvQ
	(envelope-from <dmaengine+bounces-11984-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:13:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F646FA02C
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:13:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XDmHyGxW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11984-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11984-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B012C30B0932
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6530D3F4;
	Thu,  2 Jul 2026 16:03:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044F1A9F8C;
	Thu,  2 Jul 2026 16:03:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008226; cv=none; b=Z2uVq2HdhcEpdRV0qpV39ADzEu7P39VAg5rhnAWeVp/Lz5u3o+dXO3zVkfoN05sAPiIJufTXDs3MW/1NeTCyj/wMVp7QmWeTSVkMT5Yldm2UezLf0Fd6d0LDS3ON3QQfVSWSXa8ymsRTiBkC0uXJRxAYJETSlluS6mQhobd67f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008226; c=relaxed/simple;
	bh=2W5jI5Z0ruU7sjL+sATlklT+n3cwAfJOAOb87kLkQX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ANdohWk6Km0amaR9p7elPKSvlQlOyKGbALQxO3+pYk2/pM+CMlISp6n76rW/sDY5YZbzev3tGNsBbtcJhKeuFANPxyX4joZnMoiCuG83QbyEeCvwnku8wgviEVLKT9jynu03xZDb5x5AvWR48PIqonrpap6tG+FxmU9GgxjOFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDmHyGxW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CD1F000E9;
	Thu,  2 Jul 2026 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008225;
	bh=rzDg6Eu0nRR4p4AkNSCywRzTxAwA/c7nHfpbUiOlcNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XDmHyGxWFNpd+TXH31F8Y65qId4sMIqFOB/0x0UMCZtGjx1jtvshcuYYeASiYxTcO
	 dBk8EX9wQiBK4XTNWdHEODZqN7CNateo63o+1QQ1ZvG4nSZXjJrskVxNclS9QB7c7j
	 rwg8IqwC+anXaKa8AEZsX058hCfCTFGZQptu/CQh8NPFr7uGPg+uGZ5sDofleZ+Qrc
	 M7VuuR01jXbWi+uD3guMuH8+vnhHmmYaZ9sG6fppmDOjLvvJTzaqLOY5cSK/ZT5XM2
	 hqqdwi6jI1+WYZjlmYitdaD/B7kkTG9JB78Ch+suKYQ3lztkYEPlBBDEhwtL3M2VBW
	 li4EWV8pKpXMQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, michal.simek@amd.com, dev@folker-schwesinger.de, 
 Suraj Gupta <suraj.gupta2@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260626092656.1563871-1-suraj.gupta2@amd.com>
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
Subject: Re: [PATCH v3 0/3] dmaengine: xilinx_dma: Fixes and optimizations
 for AXIDMA and MCDMA channel management
Message-Id: <178300822284.756665.15130671466547971043.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:33:42 +0530
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11984-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dev@folker-schwesinger.de,m:suraj.gupta2@amd.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7F646FA02C


On Fri, 26 Jun 2026 14:56:53 +0530, Suraj Gupta wrote:
> This patch series addresses issues and optimizations in the Xilinx
> AXI DMA and MCDMA drivers:
> 1. Fix channel idle state management in the interrupt handlers.
> 2. Enable transfer chaining by removing unnecessary idle restrictions.
> 3. Optimize control register writes and channel start logic.
> 
> Note: The patches in this series were part of following IRQ coalescing
> series which is under discussion:
> https://lore.kernel.org/all/20250710101229.804183-1-suraj.gupta2@amd.com/
> 
> [...]

Applied, thanks!

[1/3] dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers
      commit: 0b6d055edb55ecadadf54e930c2b4fab76fa9a5a
[2/3] dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by removing idle restriction
      commit: 6078690034790131b9a59081bdf30e26de2254af
[3/3] dmaengine: xilinx_dma: Optimize control register write and channel start logic for AXIDMA and MCDMA in corresponding start_transfer()
      commit: 887b3119380cde56f648130029062c223341a1b3

Best regards,
-- 
~Vinod



