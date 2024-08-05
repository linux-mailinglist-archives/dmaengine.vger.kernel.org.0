Return-Path: <dmaengine+bounces-2800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A2948066
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5135A1F239EF
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF715FA67;
	Mon,  5 Aug 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/y3KsG8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A215C14D;
	Mon,  5 Aug 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879460; cv=none; b=MaXuTMVnZqUlELZiGf/hmCH/EFR1EPuRuXq/vIs2PrCsjS6So9Ru5BzVvySZkX9cagoWf3S3haJZH3qK6SzJSkHAogsMV8UJvqXGgjZKAdUXJkADWPaOvhAzXAR+zrG4wKn/hJmsLZNE3hyU9hUoGeUDGZimMrkHexxsJo9ICTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879460; c=relaxed/simple;
	bh=aAT3ToTfxN4rnDt8ZcG/lgetUAeevb0J77TFliPQzz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jsvzGuo3N/Xb8D3Tgbz06YyqkdSTGN6u1S0EkDSCDA2Hy7cvesWWnpxXYqe4FrFNp5/BSCygB2DNGiII656hDMdUIMfEtyFn2w/i/3AkO+2HxHLKvnzqzr1noxsZ5GcrDburENoz5dcC2pXEofzSTfblBzCGD1yyy90Z9YogsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/y3KsG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2742DC4AF0E;
	Mon,  5 Aug 2024 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879459;
	bh=aAT3ToTfxN4rnDt8ZcG/lgetUAeevb0J77TFliPQzz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S/y3KsG8Tw/MOKSzrV8ymDNJN0LP/9sahwibeJh4VW+Hym9EkhuaRsXDQPzf0Sk7z
	 fQnVLA+yiG+jOa0WDfSlY9uIh1CiyFG0JfyBjB8jPrlRuQeZjC5DjFV2Fn0Z8ysu4B
	 dYkSXpwdH8lFMY+PTq62CQqUF2u/YL9+zqPV688+fb7NR2298vZSuazMfpptirbSQj
	 Q+gRL/vrLzrUZolhWPxA0dYyylM7bIaWvmEYnTRAJnqd8TAGdUi40GKLFm+cJizOd2
	 YN8vHAI/wHIjyVxmqiwRGhhOwoR8c2HwI/Y3buy6Udjy9tGAjtXRV4GAPuNcxREWRu
	 cZrPMmkcTm0pg==
From: Vinod Koul <vkoul@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Serge Semin <fancer.lancer@gmail.com>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802075100.6475-1-fancer.lancer@gmail.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-Id: <172287945675.489034.12734066497571580143.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:07:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 02 Aug 2024 10:50:45 +0300, Serge Semin wrote:
> The main goal of this series is to fix the data disappearance in case of
> the DW UART handled by the DW AHB DMA engine. The problem happens on a
> portion of the data received when the pre-initialized DEV_TO_MEM
> DMA-transfer is paused and then disabled. The data just hangs up in the
> DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> suspension (see the second commit log for details). On a way to find the
> denoted problem fix it was discovered that the driver doesn't verify the
> peripheral device address width specified by a client driver, which in its
> turn if unsupported or undefined value passed may cause DMA-transfer being
> misconfigured. It's fixed in the first patch of the series.
> 
> [...]

Applied, thanks!

[1/6] dmaengine: dw: Add peripheral bus width verification
      commit: b336268dde75cb09bd795cb24893d52152a9191f
[2/6] dmaengine: dw: Add memory bus width verification
      commit: d04b21bfa1c50a2ade4816cab6fdc91827b346b1
[3/6] dmaengine: dw: Simplify prepare CTL_LO methods
      commit: 1fd6fe89055e6dbb4be8f16b8dcab8602e3603d6
[4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
      commit: 3acb301d33749a8974e61ecda16a5f5441fc9628
[5/6] dmaengine: dw: Simplify max-burst calculation procedure
      commit: d8fa0802f63502c0409d02c6b701d51841a6f1bd
[6/6] dmaengine: dw: Unify ret-val local variables naming
      commit: 2ebc36b9581df31eed271e5de61fc8a8b66dbc56

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


