Return-Path: <dmaengine+bounces-2678-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A642F92E854
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CD01F226DC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE815D5DA;
	Thu, 11 Jul 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="reIq8+ku"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5315B57C
	for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701254; cv=none; b=uqoaGlqwwRDsgPjul/2oA6xDBaAlXOPSRSsJG4d35YenxlU68TyrNZB24V1ICV1cs1bHetNnLCdMPlIRS82iwCYMQNuRN0jDKzIX69Dks8TMoXvRbD0CVLZNkX904PRm/rGW4Gl89EmRPxzIDMYFZzjAGVSRJblEZFjc+TEuPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701254; c=relaxed/simple;
	bh=dY61pVfeYdptbpc1CWeooXje6VkidAQD5fhpL0AyjXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISx0n7qxeyqPClbg1+esQTjXZAuHR2ELJixP+r9pMf6GuKETGbBFKZHgKAzQHCf1bVOv9xAYBrXPdJT5pWhejIhPLj4+qIRKI1lhzpjqFtBWgobfKccUNeHH4j6yiNWh4javS+ZS6JTSR9xZ3QOaksh7icKM+JzuKDqGA8hN+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=reIq8+ku; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso2140405e9.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720701251; x=1721306051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAFQBuBHIxkQvbv8fOdzuOd5saHrgFyg5FB8jBW+qBE=;
        b=reIq8+ku8dLPzXdOR/+4yeP7tX03CHvSovobC+OsHWrzWNRNjY3DGIMRuqSjgQ+EjH
         MuSjdLH/DcBKYJi854NYsUwPEtnN6B7ItGztFkO3A3w+MGMJagKrj01xeLFOnWMCdBkK
         cDAQ46yJ/3PCht9picOteYdOa1djQ0AfbvEYMlb414R0GoBdtnuIdIs8wNBmMy+pek+M
         xblNvBLLziD+/cLsslUlaaK/qrDmXahyBkcFqS3jXvbgMAOmis5rDcRoMhTwTDbXO6Fb
         h/cRu0g19QqlpvQDcTNtfZ7oppzE89pwhCGoqVh242BPzj2SCxHTAxTM1D5UKJAweH50
         g31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701251; x=1721306051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAFQBuBHIxkQvbv8fOdzuOd5saHrgFyg5FB8jBW+qBE=;
        b=Q6GO9zgWBgr+59A6xVSFaasKu8YxYkiilIz86QG7twB0/vHbICcwXIMzKfdY2nJS7d
         byC2pX8aYAY0sXjmyy75+kygFyThtblpR0yECs51wgVDmHq6c2USuyCgL3Beks6Ooszw
         U19Erx7xlQfp+43wi7wfFe9enSXWNx6t0UQEQxl7brnDrdbTHl9FNP2k/P2O1iRqQnrp
         Im3lN1up9UoAtsK9rc49crCgq5w3VjI1zz4KVe13l93wd2RfUxC4iwHfhftgubqEm1g+
         44pee8AEugtJfPhV+TRTqnQuTmoR9H0dbJxv0M9jacEfKlWw2jEwA7pAkyiBieDVsBr4
         SZkQ==
X-Gm-Message-State: AOJu0YzkkDJYN/jtDAoyny9zX6yKDKCssPgprMM/kCT+6DgISEayztYM
	ouBo4TMZmHL4n+Ld5yqILMks2ggnY0eeMQOghObPTZmweHmQu27GEO3RG88fJ6o=
X-Google-Smtp-Source: AGHT+IFpavZbQE94svJyuAh6eTlEt3fIERDL3R/CcPSJlAFPUb9Zk6IvoUXtrZbD2FDIq2wriausKA==
X-Received: by 2002:a05:600c:6d4:b0:426:6b85:bafb with SMTP id 5b1f17b1804b1-426707db6e7mr45894665e9.20.1720701251335;
        Thu, 11 Jul 2024 05:34:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741fa6sm118583955e9.45.2024.07.11.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:34:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/3] clk: renesas: r9a08g045-cpg: Add DMA clocks and resets
Date: Thu, 11 Jul 2024 15:34:03 +0300
Message-Id: <20240711123405.2966302-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add the missing DMA clock and resets.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 1e471426d4af..8a3ec5780722 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -193,6 +193,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("dmac_pclk",		R9A08G045_DMAC_PCLK, CLK_P3_DIV2, 0x52c, 1),
 	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0),
 	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
@@ -233,6 +234,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A08G045_DMAC_ARESETN, 0x82c, 0),
+	DEF_RST(R9A08G045_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A08G045_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
-- 
2.39.2


