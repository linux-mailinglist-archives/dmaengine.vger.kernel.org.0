Return-Path: <dmaengine+bounces-3403-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513729A9891
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806771C21ACF
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF79C1547C5;
	Tue, 22 Oct 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjuNVGeQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7F141987;
	Tue, 22 Oct 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575180; cv=none; b=V76IomGHp0BAycw1Elat3qoinq2YLGZaECk4A0N1OPFyJVMEDSh0WP5m2VUtKSZA14/5cbqH7QNLstHSvCzUlpj/QHgIK3rkB1S+XbBoOAJF2FpIfMK4wrK+4y7jyfxX0Y7h42NLfBYAScBEXKlyTT8mVf+0+li5COcuuS/HJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575180; c=relaxed/simple;
	bh=+AXgSFYf9fdnrGNfDlq51aKCvpEV7kB6VjY09xwkUmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dg3OIigbueQfezBx7GIBHZ3M4LYsirTxJIpzUdPF6yL2oJsYC63QU4JOx3u2bmgvJJAQGI5Hpbdo0ELksJWaLCtovKMdKJCeXMzK4qDUWZPSPnDgMP3H5wFU2kfaws37lW4yWySUvTIMW13YhY/LcsmjG5oRRazwxS+0JPq+14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjuNVGeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08A9C4CEC3;
	Tue, 22 Oct 2024 05:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575180;
	bh=+AXgSFYf9fdnrGNfDlq51aKCvpEV7kB6VjY09xwkUmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HjuNVGeQZysJqJjvaKZIug4hYiox80wcdeGnF0bZvrNWkdIGo12QQx8xVXJ+NvEVs
	 6da2iye9KGPFGXBP21DAEGsL7uDmLsZZHrWeN1UNVCbl8oSPi3osHSQwoUjctYbp5L
	 YDENOR3bgthFy+eQRro1u5edvviTN1dpgQA3PrU3WqJGXo/IWJ+BIXi+uizPLznWg/
	 itHmCWHdGBA3VtOI+6ArH6aE5z6MEiIRv+B25+fKXldrjNoPAqkiYAwfoeQz/zfEnb
	 qWXilDDuxlXmOADPJvoIkU7f9AH8GQBc+aGKKnq4st1xIjYRFlyGgolz2CTKyBaONY
	 p8YokfXdZuIUg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
Subject: Re: (subset) [PATCH v3 0/9] STM32 DMA3 updates for STM32MP25
Message-Id: <172957517754.489113.8907734005204192905.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:02:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 14:39:52 +0200, Amelie Delaunay wrote:
> The HW version of STM32 DMA3 inside STM32MP25 requires some tunings to
> meet the needs of the interconnect. This series adds the linked list
> refactoring feature to have optimal performance when addressing the
> memory, and it adds the use of two new bits in the third cell specifying
> the DMA transfer requirements:
> - bit[16] to prevent packing/unpacking mode to avoid bytes loss in case
> of interrupting an ongoing transfer (e.g. UART RX),
> - bit[17] to prevent linked-list refactoring because some peripherals
> (e.g. FMC ECC) require a one-shot transfer, they trigger the DMA only
> once.
> It also adds platform data to clamp the burst length on AXI port,
> especially when it is interconnected to AXI3 bus, such as on STM32MP25.
> Finally this series also contains STM32MP25 device tree updates, to add
> DMA support on SPI, I2C, UART and apply the tunings introduced.
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: dma: stm32-dma3: prevent packing/unpacking mode
      commit: 689f05586e7ea620c8fc1066c067809e52ffc2f3
[2/9] dmaengine: stm32-dma3: prevent pack/unpack thanks to DT configuration
      commit: 12eb621e1abff65d89aeb4c92a4f3436225971d0
[3/9] dmaengine: stm32-dma3: refactor HW linked-list to optimize memory accesses
      commit: cb467c451163bacad4cbb7540ce7d731946f13f9
[4/9] dt-bindings: dma: stm32-dma3: prevent additional transfers
      commit: e18a9830233e739ae7045700232c53b4cb2e98eb
[5/9] dmaengine: stm32-dma3: prevent LL refactoring thanks to DT configuration
      commit: 2ff0fb9474eefa7149c199fb3f79e54355a6c184
[6/9] dmaengine: stm32-dma3: clamp AXI burst using match data
      commit: e713468e7c104a0598a7ec31ab7ec0bec94a174d

Best regards,
-- 
~Vinod



