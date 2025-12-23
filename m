Return-Path: <dmaengine+bounces-7879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9BCD91B5
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CBA630028AC
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138F330B21;
	Tue, 23 Dec 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTZpsN3e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2A32BF2F;
	Tue, 23 Dec 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489301; cv=none; b=NA6v6Ccs2WmUayuvwk4Zp4+t7LQ2NT0EzSufMTyTJCkrWEEVLMw86iNNnHNQmGPJhPfwf7BUbPORmkws5hMxNVar4jcnpLIZ41j7bz2Iy4fMETScesUoXWvzAnAbZihkfUfx3+LB7brQ7z2cDoQyVG/Ohz5X+TqlbPbWXyKgC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489301; c=relaxed/simple;
	bh=lZe1cCbxkn52whYgqfzuO8vrl214dFz4RWvAWiF8ObI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8h63SqzpjvhIqrXCJAV8m86lNvCTBJ4wnLgy5Ueto3+K21sDH80WUHRBKt8kwauZIQsmNTnwR8ThJdBmrI8TDzM4CGdOS7TWXoSX8OBZ7joofCkyavCxXXLCr0vTbh96w1uZwfTAo7/HeeuvkW+7oiq9l7eqTAt36w0V6Evg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTZpsN3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB01C116C6;
	Tue, 23 Dec 2025 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489300;
	bh=lZe1cCbxkn52whYgqfzuO8vrl214dFz4RWvAWiF8ObI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DTZpsN3eHoFAL9lrlZRgFKStnM20W6ebr/myjO8gHzSWEQKg0j7s+gU5cLBlx/qhk
	 2iOvObt6Oxh3c0IoTL3f0rp2ZZd6wCYPH/aCbVLV9O3EeVp8I66XxWnELaoZWpdWL2
	 KS1hCJeaWL6G+hDcujgg9Zmns9YQkyp9SAoz4EDxQl57jEN6411dFMCBuXX8lkg+Tx
	 rYm5Jc5LjJkHArFYrjdgdNxzbOCU4hSqtePP0JKUyR6M9BVa3v6zUAqeNCmJ9cINU/
	 Z358X8iWp06b+w2Sz3N2U0zAhckweAxPNdfwnJiyOHXbCoSn8lmBiL6OyIIZII/75M
	 wnD1ZyGfbFyfQ==
From: Vinod Koul <vkoul@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, dmaengine@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251221080450.1813479-1-wens@kernel.org>
References: <20251221080450.1813479-1-wens@kernel.org>
Subject: Re: [PATCH] dmaengine: sun6i: Choose appropriate burst length
 under maxburst
Message-Id: <176648929819.697163.12733277039569161505.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 21 Dec 2025 16:04:48 +0800, Chen-Yu Tsai wrote:
> maxburst, as provided by the client, specifies the largest amount of
> data that is allowed to be transferred in one burst. This limit is
> normally provided to avoid a data burst overflowing the target FIFO.
> It does not mean that the DMA engine can only do bursts in that size.
> 
> Let the driver pick the largest supported burst length within the
> given limit. This lets the driver work correctly with some clients that
> give a large maxburst value. In particular, the 8250_dw driver will give
> a quarter of the UART's FIFO size as maxburst. On some systems the FIFO
> size is 256 bytes, giving a maxburst of 64 bytes, while the hardware
> only supports bursts of up to 16 bytes.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sun6i: Choose appropriate burst length under maxburst
      commit: 7178c3586ab42693b28bb81014320a7783e5c435

Best regards,
-- 
~Vinod



