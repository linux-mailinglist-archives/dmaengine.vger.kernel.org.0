Return-Path: <dmaengine+bounces-9470-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPVWM7s6uWmKwAEAu9opvQ
	(envelope-from <dmaengine+bounces-9470-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:27:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE12A8AE3
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C116301C5A9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED83AB275;
	Tue, 17 Mar 2026 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuepidAi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9722D9796;
	Tue, 17 Mar 2026 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746871; cv=none; b=tTt77upCdIqBvsx7z4oqR8ZxoL8aYgMroVwJHfjXJTaQVFK/jxkljVHuD+EESuFrVAMzPKm4F50FVBlK29LanQ/W4ttnkVooNtYyicL9FaAqA1g8UQEP10vwTIxR0KdrvFOTurXz1IzG1dP4o3/04TijNRTf8db8/ZktYTsLky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746871; c=relaxed/simple;
	bh=/lJzgKXZtpaNxm1OXKdJSaQHb6rqsXre/eLfhtNuPiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H5KzHu6f0EALmHRdO1FkSJbN+8AJVj2jRUamG6WSPankfeMmvJuvzeBIG79DUGkvdRfTm0upt4Hs2IkEWaqiBIm/MPahvF4SIkyLx/tjoW//87yvqOrdq32N9PtHqCkPPCOph7ArojlJUamNA9I9XheJGPVbpt83zrYKeb5ykmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuepidAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C4C4CEF7;
	Tue, 17 Mar 2026 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746870;
	bh=/lJzgKXZtpaNxm1OXKdJSaQHb6rqsXre/eLfhtNuPiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JuepidAi89V8qdQRJBp2BIDWiFoG7kj/Ku2MkdVTHyyUqr2Rc8ZJsn2LnikH8Fsn0
	 sJd4b0km1i5kEp5RjsiI24PRRK2UghKmIQ0gbT+duSQK0Bo8lOawzeMtNknxseImbv
	 W+bxtXfNrPdrrSPPz5KqyzOlFuEDzOyDSL79hUYNT9knsfxAbOacaXPBwgBa4DFuAD
	 qY9c/ZX0VYIS2h4Rb1YKzrsa6j7bxhWzuWw/K+OtyejkijWM+uUQsPzMQVQeAQJXhl
	 xWWNEs5gKy5tw/gS7PN5lKUNEli4XCdfyIDqQvabmdy+7Xf/RUZvBfQnQSFlBOvcga
	 eorLBi7rv+fpg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Rahul Navale <rahul.navale@ifm.com>, Sasha Levin <sashal@kernel.org>, 
 Suraj Gupta <suraj.gupta2@amd.com>, 
 Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260316221943.160375-1-marex@nabladev.com>
References: <20260316221943.160375-1-marex@nabladev.com>
Subject: Re: [PATCH] dmaengine: xilinx: xilinx_dma: Fix residue calculation
 for cyclic DMA
Message-Id: <177374686790.337094.9907584689024913744.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:57:47 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9470-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBAE12A8AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 16 Mar 2026 23:18:57 +0100, Marek Vasut wrote:
> The cyclic DMA calculation is currently entirely broken and reports
> residue only for the first segment. The problem is twofold.
> 
> First, when the first descriptor finishes, it is moved from active_list
> to done_list, but it is never returned back into the active_list. The
> xilinx_dma_tx_status() expects the descriptor to be in the active_list
> to report any meaningful residue information, which never happens after
> the first descriptor finishes. Fix this up in xilinx_dma_start_transfer()
> and if the descriptor is cyclic, lift it from done_list and place it back
> into active_list list.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx: xilinx_dma: Fix residue calculation for cyclic DMA
      commit: f61d145999d61948a23cd436ebbfa4c3b9ab8987

Best regards,
-- 
~Vinod



