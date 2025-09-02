Return-Path: <dmaengine+bounces-6322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CFEB3FB20
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD661B231B2
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB02ED173;
	Tue,  2 Sep 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYVsMbmJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191A2ED852;
	Tue,  2 Sep 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806594; cv=none; b=pFJWFRaOgHIl2hy0t9IvbAfhCGj4PM4EnKtdD7twTRvK4WMYY6Mz+18U+0vZbATPmT5XeDv6NBOHKcHocQHU28CWcVYJDjWbo5c+A0Du5TraN/1Vf2JtS0NmcdgatPJBiOrvMcs5hpJmYstT2O2y5d9v9ECrKvUAYilHhsOtlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806594; c=relaxed/simple;
	bh=dIWtODJzj2z3afarX1J115TDTUy4z/tY9fh6ITu9yak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oroyW1utGU9cgSaUpqwZhVhK2PJ9EEFhIAHgZdK3KY1Mn/49VhHmJ8Df9+uWcWWb/k2qNVabnl8XYGyj7ImUEoKT4VMFMu4qra0r+h/ppvz4KJqHPREOm2BdmyKFqag+r08NqPUyC34puQ9Xsd22WDFvDpmpnKDQ4gHwhISzr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYVsMbmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C30C4CEF5;
	Tue,  2 Sep 2025 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806593;
	bh=dIWtODJzj2z3afarX1J115TDTUy4z/tY9fh6ITu9yak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YYVsMbmJBDhypGCtghxtK0hJhb/2u35ExwxIh+zRss2RrKBGs4OdBMOYkASinP00W
	 msmDIzknYFGwq/SiQ+0lFnesE0aAzwEE2hQMmI5lsQi2pNnIOm7kdaDMAvt9pXI1L1
	 Ax24QYIy4qpScDlqiE3o9q2mQvIsF/Z0Vn76CP4c2hBqIVXamwyEkVvkopPPXS2AYa
	 Dy2veRrBOICFlKytvRUT9fT4Nz6O7IAuvficoiAoHlmD+F6IBjYCavWzl2nIWSulD4
	 ju93+tNVT20oEdJg48eBJE3vx2EqOAML1txMOqBNtX1ShN2+XCeD0fyQYrf4pq3hDR
	 oAzIwRycFxmxg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Michal Simek <michal.simek@amd.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Marek Vasut <marex@denx.de>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
In-Reply-To: <DCCKQLKOZC06.2H6LJ8RJQJNV2@folker-schwesinger.de>
References: <DCCKQLKOZC06.2H6LJ8RJQJNV2@folker-schwesinger.de>
Subject: Re: [PATCH v4] dmaengine: xilinx_dma: Support descriptor setup
 from dma_vecs
Message-Id: <175680658917.246694.14605510999685994638.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:19:49 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 26 Aug 2025 20:21:10 +0200, Folker Schwesinger wrote:
> The DMAEngine provides an interface for obtaining DMA transaction
> descriptors from an array of scatter gather buffers represented by
> struct dma_vec. This interface is used in the DMABUF API of the IIO
> framework [1][2].
> To enable DMABUF support through the IIO framework for the Xilinx DMA,
> implement callback .device_prep_peripheral_dma_vec() of struct
> dma_device in the driver.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Support descriptor setup from dma_vecs
      commit: 38433a6fdfb75d12a90ffff262705e1ecfe88556

Best regards,
-- 
~Vinod



