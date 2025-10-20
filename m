Return-Path: <dmaengine+bounces-6895-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFCBF2A39
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EB018C0339
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153B4333429;
	Mon, 20 Oct 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll1u0K+4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441A332EBA;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980282; cv=none; b=etSkMv4uN4gYTqOmFCRH1IA+/JiPWYi1uEc7hSc9q9IUJgntxl5F2TbjA9sU+6nRcgrp9MAvb/cznt405FZRjaC90WvkxoDl5oCZXEoeakWhCmXI5yFbPH0/UbejFtQu2WtSnBqp6VZ9tIprfRLzIaQSs+3o0/lEiKh2HmrD9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980282; c=relaxed/simple;
	bh=IrJnFSl0vpD3jGCn+oBa7YlslutdYfojddkzQZM95dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzYWJjjZqT3I0RNdRnpf0X6yfb8E+TeUYA7Fpt1awzjwF0obQROxbyRsmb5nHyLAFuVKxX2P61b6aAAIAKjS7YZ1yNQZypEE38DN1jn0fBgGhEc/Uu+QAGv7Ds3Xqf7qw6T9gdRj7cvL8wfqE0DWBLX71gqZDb6UQJpt7KA5gLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll1u0K+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD3FC113D0;
	Mon, 20 Oct 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980282;
	bh=IrJnFSl0vpD3jGCn+oBa7YlslutdYfojddkzQZM95dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ll1u0K+4eP+gsGLcebeYiSuIsCSyF8lilj4gby7yHw+6Xm3n7BC9FS3+kiL4RKIr8
	 G9aTXWih4Z4rHUEHbA1WtbrlC1svYG/6DBSJHXtC3rf01P2OcNLgo1BOrzMjxzb6Jq
	 0omSqngr32C9EmsA/OmpFuXddT91xBpOPlD8ayQYbi/k4TEt6scLSZy1KYhepV/Gl4
	 7ActQB0DDucoi9b7qvg3ndo1UDigjgpj6ksXdVIuOO32YllCwPDoqWPO3TJiMdh2te
	 hiFUGH0YEV9gU5YArLPP+4CmX+3nOdB8ITc84yPdyMUo5xc95YJ6yli0E38DqmOy08
	 Q35J/32vbmsPQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 524AA5FEC0; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
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
Subject: [PATCH 06/11] clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll minimum rate
Date: Tue, 21 Oct 2025 01:10:52 +0800
Message-ID: <20251020171059.2786070-7-wens@kernel.org>
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

While the user manual states that the PLL's rate should be between 180
MHz and 3 GHz in the register defninition section, it also says the
actual operating frequency is 22.5792*4 MHz in the PLL features table.

22.5792*4 MHz is one of the actual clock rates that we want and is
is available in the SDM table. Lower the minimum clock rate to 90 MHz
so that both rates in the SDM table can be used.

Fixes: 7cae1e2b5544 ("clk: sunxi-ng: Add support for the A523/T527 CCU PLLs")
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index acb532f8361b..20dad06b37ca 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -300,7 +300,7 @@ static struct ccu_nm pll_audio0_4x_clk = {
 	.m		= _SUNXI_CCU_DIV(16, 6),
 	.sdm		= _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24),
 					 0x178, BIT(31)),
-	.min_rate	= 180000000U,
+	.min_rate	= 90000000U,
 	.max_rate	= 3000000000U,
 	.common		= {
 		.reg		= 0x078,
-- 
2.47.3


