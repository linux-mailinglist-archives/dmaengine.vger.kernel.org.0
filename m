Return-Path: <dmaengine+bounces-3026-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F1964CCA
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107381F22C79
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A447C1B86C1;
	Thu, 29 Aug 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obPObq/J"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260D1B6555;
	Thu, 29 Aug 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952636; cv=none; b=hwolLB2AvY+ublYz4UiD3ymTB6WdO4EnaIc0h/YpWg2aWyLNGjynWPoUVZLXSVC5Laz7ascnSeTlY1cEdLC73U5h/DlZlUfJKjjw5F7/9ya8WNc+zSMggLwuhiopulKoPXTQyMU04BCCiOclbLiqqrpqSpFcp2z4EuqF1hve2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952636; c=relaxed/simple;
	bh=FuOYrMqzK3XVlcDAmkKGGdPoD9Y9wjiTxYxK9E0bH6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T/OYSGRfo8yWTDS6oK6l+Kvdy1R4+BupGdSm/2VjtJ//kX885rm3X+T5FnZaAu1OpGUGPJESJqzfk1+hW0D1LDYKfHmU6tYtdPyn86K7gOAjMUew+m+J0PWkh8CvhjW5SIQq/MLol3JrCJjQZetDffA/3m1eKJOUfPmxiBQT+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obPObq/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72709C4CEC7;
	Thu, 29 Aug 2024 17:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952636;
	bh=FuOYrMqzK3XVlcDAmkKGGdPoD9Y9wjiTxYxK9E0bH6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=obPObq/JD+VgVe6nh4DT5lIsFwjOQhE1RADGad2eKRqcKkRm7gOprPfGE1cbUKm3S
	 nMtdnfobxt0pPWtIrTAiP8CixFiBcQXTlRqaks6o/qJWQn7GbzhkBgBuasGuEb42jL
	 tpebzXbDgFSSROSJug4xGMVOS4eTwxJHAnP3dxZvdosXZmkt+bRpcfwmKZXkcalLT9
	 Rx/4foMGtj3pga/OM38xZdsLVUfGIgHP8u7/5APWcNBMCI7G1DEdUAhbNdXOwAvOLC
	 1rtPNJ26IVAz8Unh9TXgRTVbNPMHwLP6khQ0T/SiLWMeoIa3iqxe4Uaurn5JWmoh+y
	 CfcD8u/xCWbrw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20240809-loongson1-dma-v12-0-d9469a4a6b85@gmail.com>
References: <20240809-loongson1-dma-v12-0-d9469a4a6b85@gmail.com>
Subject: Re: [PATCH v12 0/2] Add support for Loongson1 APB DMA
Message-Id: <172495263311.385951.8113964072819506950.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:33 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 09 Aug 2024 18:30:57 +0800, Keguang Zhang wrote:
> Add the driver and dt-binding document for Loongson1 APB DMA.
> 
> Changes in v12:
> - Delete superfluous blank lines in the examples section.
> - Move the call to devm_request_irq() into ls1x_dma_alloc_chan_resources()
>   to use dma_chan_name() as a parameter.
> - Move the call to devm_free_irq() into ls1x_dma_free_chan_resources() accordingly.
> - Rename ls1x_dma_alloc_llis() to ls1x_dma_prep_lli().
> - Merge ls1x_dma_free_lli() into ls1x_dma_free_desc().
> - Add ls1x_dma_synchronize().
> - Fix the error handling of ls1x_dma_probe().
> - Some minor fixes and improvements.
> - Link to v11: https://lore.kernel.org/r/20240802-loongson1-dma-v11-0-85392357d4e0@gmail.com
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add Loongson-1 APB DMA
      commit: 7ea270bb93e4ce165bb4f834c29c05e9815b6ca8
[2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
      commit: e06c432312148ddb550ec55b004e32671657ea23

Best regards,
-- 
~Vinod



