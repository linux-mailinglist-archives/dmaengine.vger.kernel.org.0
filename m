Return-Path: <dmaengine+bounces-9507-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL0gBuGMumnSXgIAu9opvQ
	(envelope-from <dmaengine+bounces-9507-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 12:30:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13D2BACF1
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 12:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97EAA30C1C3F
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F33C552D;
	Wed, 18 Mar 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2gT5N8B"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964053C1999;
	Wed, 18 Mar 2026 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833257; cv=none; b=sh71n82FroFpJ3jA5ZR5msEIA8gf6y3dBC1vuWoE7boj4KpeBytsPnRYo75RZxPqTl6S4y05QCQKs9OWRDZPlfnOTd/B9mA0VqN6l+iFdOZ6Td0LijKX2K4rNxEEDPAmq4SAd1Y8uAC1beNEu0oiTzExTcP640SX+7HlcJMlMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833257; c=relaxed/simple;
	bh=m8R4SLbHLPhRnMGBE/o02YONs9L5eByD5sU2IOjMhYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u4D9O+TOy9Vx0W9LAVzQbnhlz0GVjoAJFPaeI99ob0EaK7zaT0oup8+FEq2X8YHofhZAEPQzMCCaU8m5LFr4GBlxZ9qrXPh/2Mh/THpaZszH4fCUgdOg/LSyrEjTOFCpOIcOH2WqHoJY21TSZhyUO9I9u0MOjj49sp9ZF+fxYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2gT5N8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD715C19421;
	Wed, 18 Mar 2026 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833256;
	bh=m8R4SLbHLPhRnMGBE/o02YONs9L5eByD5sU2IOjMhYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R2gT5N8B7ymcBoR+WLdQNbRQYf/HghnFVWTX7HveoXiPqqtnIyR5e/LJqUIUerZIe
	 g3TV84DQVoOAsN7KaZVKmdKK4KNNSYSMGQI0bPUTDjJ7He0HkoPcY6XEkaGjcdHmIS
	 qg7Fb3BPafw/vpKg0WaSxCH2vJv/F+1fYGaT6nl9/yKplzApCjs4jWazkIPjl0/OhF
	 nERJ52vIQOihrZY96uUTVeaWzkJREwkZ3ePrK63jGiPmFr1VZasr6lwJVS7aLwFlKC
	 E7Y6W9gya7BoHtRJhm6FNUMutnzSrJThUc5cVtSnc3LiYEDqNigkzR5uAuCwW/yQ4x
	 zcL7zYWm8hQnw==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, mani@kernel.org, 
 Devendra K Verma <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com, Devendra.Verma@amd.com
In-Reply-To: <20251212122056.8153-1-devendra.verma@amd.com>
References: <20251212122056.8153-1-devendra.verma@amd.com>
Subject: Re: [PATCH v7 0/2] Add AMD MDB Endpoint and non-LL mode Support
Message-Id: <177383325446.408483.15991953985417401358.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 16:57:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9507-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F13D2BACF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 12 Dec 2025 17:50:54 +0530, Devendra K Verma wrote:
> This series of patch support the following:
> 
>  - AMD MDB Endpoint Support, as part of this patch following are
>    added:
>    o AMD supported device ID and vendor ID (Xilinx)
>    o AMD MDB specific driver data
>    o AMD specific VSEC capabilities to retrieve the base of
>      phys address of MDB side DDR
>    o Logic to assign the offsets to LL and data blocks if
>      more number of channels are enabled than configured
>      in the given pci_data struct.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
      commit: 14eb9a1d338fdc301a2297af86818ecf716b1539
[2/2] dmaengine: dw-edma: Add non-LL mode
      commit: b7560798466a07d9c3fb011698e92c335ab28baf

Best regards,
-- 
~Vinod



