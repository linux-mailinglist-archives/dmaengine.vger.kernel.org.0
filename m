Return-Path: <dmaengine+bounces-8140-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5AD06F36
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 04:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A884D30351FD
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 03:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DD32D0CF;
	Fri,  9 Jan 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT8Njrej"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5B320CC2;
	Fri,  9 Jan 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928465; cv=none; b=i98u5p2K7t/rrLqAOLVH8PLX0Ms2dgKb/LeZDHdKJ+IppD8weHNsEwkxPxnHEsdKPXqetujI5KmDMz8ZemWsF4XDFKbWFV2Drwpez2+SmTOLIJ2UaBOxNKVcZsEh4Zgq3gB2BEbvObo5ZJG1GKsqqjAhSDRXWGUEx7IL6Ci2PO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928465; c=relaxed/simple;
	bh=1OfH9cXQ1n9IgCUR8xbgkEJ7/o3KWmQ+DhK20cO/3Yk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SkbI9QIPK/hC/ZooTEvL2lXRabklnRwCveJKA2/cnALAxIL+p+nHPqlQk1WuHynAG3rJTlqIlMfPPv9u+U8VcEShuA2lpQgyZBvIUGmIORIYh5X4rSUCFIhJLxzbb5tL1Gr5RlDaR59sj5Bn8gq+tUJcGU0jEmSvKkkEnC7Vx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT8Njrej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B10C116C6;
	Fri,  9 Jan 2026 03:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767928465;
	bh=1OfH9cXQ1n9IgCUR8xbgkEJ7/o3KWmQ+DhK20cO/3Yk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cT8NjrejqTLsdtIoF5taYGdEdQXIvX40GoQGA8NY9Dba+hmOHwxdNFXpn/K+ge7mf
	 7MOzRf4NMFc0OSF4kUeJuqZUhmEAe+20JlCRaKcs7xaEb2n7MTgiTsj4iQzW3W8WrX
	 yD6N3xCYRbyg+kZshZ8pO/oe5Hvxi/nuHH65d2OFOOfguucMR2Fpr1OeLsUeG1ik1k
	 gwO74JAYP5NBtdu4utMXgUsmF3e0OC4RsH/4L5VAVZ6casl3Eae/iY1d3ZxJHv7O4b
	 3NRe1XDqntefVyWDXEBWLl1AVCyQl2xuuZ3M7eKBej5kriVP4mDcVPbwccSIvMhKpc
	 0BvJxnyC05xkg==
From: Vinod Koul <vkoul@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <312c2e3349f4747e0bca861632bfc3592224b012.1767718556.git.geert+renesas@glider.be>
References: <312c2e3349f4747e0bca861632bfc3592224b012.1767718556.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Make channel irq local
Message-Id: <176792846366.658957.4098367863769099741.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 08:44:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 06 Jan 2026 17:59:25 +0100, Geert Uytterhoeven wrote:
> The channel IRQ is only used inside the function rz_dmac_chan_probe(),
> so there is no need to store it in the rz_dmac_chan structure for later
> use.
> 
> 

Applied, thanks!

[1/1] dmaengine: sh: rz-dmac: Make channel irq local
      commit: e0c51fd02f9cfab341907f6764d2f15c134eea55

Best regards,
-- 
~Vinod



