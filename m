Return-Path: <dmaengine+bounces-5636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA3AEA96D
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC53D1885BAE
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE00B2609CC;
	Thu, 26 Jun 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLYfMXdC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1323B634;
	Thu, 26 Jun 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976060; cv=none; b=kdLOHwTyYlPvWO4qal3RieKCBgO0BcRjw1C99Whz73bLzS4i31kJSbDRdkMdcHy4AbWqtU+CuMsDSYWMn6pB1islcULw51/v7rjaV7R57flWIZz/jLO8AcvukYJf1TQD7TSleTajNNWGxcTJgGtVdAH9o4+82OCJVvscMIdZlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976060; c=relaxed/simple;
	bh=NdFw2ADpTfpWgA0EQty53QwutKobBhj7JUQ3fk3v3jc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ppROY71+Jwe1I1KEhxEVi7ikzwqYly2tMpdY5TAn6TSCIy8eBrUbIKEQ6z27gCVq+KK+tf6UMY5JPMqWR7yLDWNn6ABfudNUe/na2VED89M7rNKvKLa+NpNbd7J0y14U6PawtKe9Q7EZf/TTrJWdBi0uHzwqJOukw29L2letQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLYfMXdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABFEC4CEEB;
	Thu, 26 Jun 2025 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750976060;
	bh=NdFw2ADpTfpWgA0EQty53QwutKobBhj7JUQ3fk3v3jc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tLYfMXdCW6YGCUJHyniUaCmkNb0lqs7cdAY65UBz4bkI5WMCtUqTCK4qqcdTnXtyw
	 kpsW0gE81tmoVoxhxuCCDDE2oUQL6IFSUUFJM1nZI+QeEQrmkkGzoSeCvinzRrme7l
	 4dT/KhxsSUkbqz7GWorCOGv3hSjPplJDbNF1V4cE09akN8IlG3jMaKE+ijUDziSRVa
	 iJmGaEz4jZ7/wmgH/w263OrbDqTuSGQz5+p7BaP9dTvSm2C+HtfMM6ykN7wxoVOAIU
	 99e9KHEAvHV9baLK1Ea39f0tuZ9oeChnjjFJXnVF+OqXBzQV6EBCxmwMpWIQm6xZCQ
	 CIIlddlDGQ/EA==
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
Subject: Re: (subset) [PATCH v7 0/2] Add `devm_dma_request_chan()` to
 simplify probe path in atmel-quadspi.c
Message-Id: <175097605979.58944.6982488308454095610.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:14:19 -0700
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
      commit: 56137a53f8ebb400f4098ca26ef18934e9a4de45

Best regards,
-- 
~Vinod



