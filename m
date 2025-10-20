Return-Path: <dmaengine+bounces-6893-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55033BF2A24
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94F618A596D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799B332EBC;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCvy6s5f"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEB332EA1;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980282; cv=none; b=kcm3wAkd+XEOKdN8L8nYs8q8tFJQ0wuTybQ6o8nLQZR4CIMBEQo/c5CU87A7RsOZJnIK0LSftFunsJWhcBFYQmL16+x/FESgzb163LrRILGnmMFAVs6CTbk8912z/xYFSNPClpHLs15ceIKgyEWsVNXT+B81oVe9S+SO8ExmNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980282; c=relaxed/simple;
	bh=qJlYlCdLicsk3Qg+mKxU+NISEK1JvSSkuCl6A572eG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akhiSYiXQJ5Qn44t/A2lMpLlqeWdS9S/NuS8i81pKWDlJwtO44TnyfIY6UIrXU9hjG1BW1hr4lBwbYzJIaptuvx8dfXvJbNGCBf0L0WvRvOpUOVWqlmtJlM4NIoHSOP1rPgrDH4EtdLNOrjJqEIQeAcok/nPzafT9LHFClyK0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCvy6s5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC18C19421;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980282;
	bh=qJlYlCdLicsk3Qg+mKxU+NISEK1JvSSkuCl6A572eG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCvy6s5fuw+OQYHnGwF2kNwuSXGkZ9hKH3PWBHPFC7S3XeMeVN0cRdly0W5bSUDhb
	 RO0kfd1ZCJJBB+L3kHSFqP4hi0W5zDMB+H1QkBHrQcufHuCv2H2Sx5IQm59Xs47c+v
	 3m92pOgPjxML37+9DRFI096dxL/esFy85urgSV1M1ON3kcgWPOB9jW1wL3x2QQd4Zn
	 r087FlRGBv+wMUvcr0GzUiDEEpZonvClaznrMU3KMtxAOj94zdvfKiIPm7FXSoLL4v
	 2Uzhkb70r7FJN7vW28nHLxcRiLjUB4NNMwIG/oZTJcscTDnfJga+Y4cE2ABC3L77QY
	 kxVBwDt1xsQpw==
Received: by wens.tw (Postfix, from userid 1000)
	id 4B4EC5FDC7; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] clk: sunxi-ng: sun55i-a523-r-ccu: Mark bus-r-dma as critical
Date: Tue, 21 Oct 2025 01:10:51 +0800
Message-ID: <20251020171059.2786070-6-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020171059.2786070-1-wens@kernel.org>
References: <20251020171059.2786070-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "bus-r-dma" clock in the A523's PRCM clock controller is also
referred to as "DMA_CLKEN_SW" or "DMA ADB400 gating". It is unclear how
this ties into the DMA controller MBUS clock gate; however if the clock
is not enabled, the DMA controller in the MCU block will fail to access
DRAM, even failing to retrieve the DMA descriptors.

Mark this clock as critical. This sort of mirrors what is done for the
main DMA controller's MBUS clock, which has a separate toggle that is
currently left out of the main clock controller driver.

Fixes: 8cea339cfb81 ("clk: sunxi-ng: add support for the A523/T527 PRCM CCU")
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
index 70ce0ca0cb7d..fdcdcccd0939 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
@@ -121,7 +121,7 @@ static SUNXI_CCU_GATE_HW(bus_r_ir_rx_clk, "bus-r-ir-rx",
 			 &r_apb0_clk.common.hw, 0x1cc, BIT(0), 0);
 
 static SUNXI_CCU_GATE_HW(bus_r_dma_clk, "bus-r-dma",
-			 &r_apb0_clk.common.hw, 0x1dc, BIT(0), 0);
+			 &r_apb0_clk.common.hw, 0x1dc, BIT(0), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc",
 			 &r_apb0_clk.common.hw, 0x20c, BIT(0), 0);
 static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg",
-- 
2.47.3


