Return-Path: <dmaengine+bounces-5641-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D87AEA9FD
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0803AD7CB
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DE22759D;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUnQGwQE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3743226D1D;
	Thu, 26 Jun 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978089; cv=none; b=im4z8Ui8DZBas9JXDp+aaybxgqw4njttRjWDy4J5fCISEEdEaytLzFAP1qnwloCc1pQOmUWZ5Lq0gNBx4ngxiJzW4PPsHQUJNADgyIcAISWG51DdSGXIfidPZO9cWRPAdIhEM3y/kk9uz+s1UgMA4Z6bKtVcgwr5h/TYXGwctd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978089; c=relaxed/simple;
	bh=UOOZqUVVQFUoc7bZ295+uDKZCugXA5Wvp3MAd/fhdrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W1fZNz3jvkTRx4hC3Z6GmwnzvqbSfvGclWZyk7UWkP/jrv5WSSJ3S7S33y7P+TYIAYdGtts1QU8Lwi9cZkCLR5QpU75p9ruwSyHMi8Swa8itUKSs+Rh9eNzsTYWMlL59RV+RA6qYP2IM5gOe8spmzwvURY7Sy+Zke1/UJBo9y1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUnQGwQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18258C4CEF0;
	Thu, 26 Jun 2025 22:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978089;
	bh=UOOZqUVVQFUoc7bZ295+uDKZCugXA5Wvp3MAd/fhdrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gUnQGwQEsJ9ge0VZgXMVu9Lv/49qvmNlKocha/kF6+BrmG2ufSjIXEmYLD/HB41cv
	 nzvk52EAXwiC6JkuCNvDsnaf5iq7/iafMHo0AnCrkeJBopgzhsCkF8MkwlbWwgpKKE
	 UYDEAYkODZT57+HuzQ+J64ivbHy1KdhKgIA9SeRJeu27BqyZlt7dDrub1653yzZfmu
	 ASC2m1uhUTZlST2RooJ1KgL3VGqpX4K454reuLGnb8xx+Uw+5v0C4uejj0voJtqkDh
	 trIBg73kgc7jgrdpy/ARO543hpPEUzc9CICIxNdlIp5YYdrcAGNEDinJNY3j9trKKx
	 d+DS1yRWEZrWQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250610082256.400492-1-csokas.bence@prolan.hu>
References: <20250610082256.400492-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v7 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
Message-Id: <175097808905.79884.10352681234846740562.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:09 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 10 Jun 2025 10:22:52 +0200, Bence Csókás wrote:
> The probe function of the atmel-quadspi driver got quite convoluted,
> especially since the addition of SAMA7G5 support, that was forward-ported
> from an older vendor kernel. To alleivate this - and similar problems in
> the future - an effort was made to migrate as many functions as possible,
> to their devm_ managed counterparts. Patch 1/2 adds the new
> `devm_dma_request_chan()` function. Patch 2/2 then uses this APIs to
> simplify the probe() function.
> 
> [...]

Applied, thanks!

[1/2] dma: Add devm_dma_request_chan()
      commit: 08bf1663c21a3e815eda28fa242d84c945ca3b94
[2/2] spi: atmel-quadspi: Use `devm_dma_request_chan()`
      (no commit info)

Best regards,
-- 
~Vinod



