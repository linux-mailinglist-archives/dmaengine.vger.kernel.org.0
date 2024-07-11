Return-Path: <dmaengine+bounces-2680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB992E860
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DF0B22A65
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D515FCEA;
	Thu, 11 Jul 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WYMHyBRd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA915ECF8
	for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701258; cv=none; b=tI2bDJiI8Vk30Kq7XJSs5aamDcm7s8+vRBqOnSSYIEfaNWzBNy5YQJNf5NJnOG2DPUpW4mmg1Ob5j4LbOhQ6giFNLuNT93iLOdxvyJ6O2N825CdND+wsQEkcnheboKten+M0RHStZ6xTtsIFPL/rrqrpndkh98tFf7g11Cg3/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701258; c=relaxed/simple;
	bh=Lnw6WVCoDGYqJbevISOZOc2dPUdG1/4V1rq5VXcFSC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsEa8qzJGucz8PhKFg90VmpAnGBbGFYobtdhruE+EDFrANFjBexfuPoLdy+CQ08HGO6Zv01PVK3plI7/HjOVe3ubG+2c6clplgYqVzqtlMB1Kmc5XGv8+FcoxfwZGe/M2VvFEhOS3ShVa0ApBfrXh56fH7h4cmeD1bajzAZlw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WYMHyBRd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-426717a2d12so5261155e9.0
        for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720701254; x=1721306054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TMSDdjSHMMbfEYs+qwLdoVucqWbdqXw+KkemXAy9e8=;
        b=WYMHyBRdD+WcpJEKJhfjq24G/cxaxKn+6PbBsHZ/frENsbH+MQgqMgB3lmuEZvIv/T
         BiGUfJASyaz0NtJ2e4G5eajoltVHGceerqVAbkCc5/VliQKjTHXg3k0UXJLCTWKJUIC4
         QNNnyTQetHRc+3abPeVq2GFzR9Lz2OXdwWdYqmink4LFNYEYYV1D7HYWsxAGfMDfe0i+
         ZnBtHCN0ghD2FFijBXEHWfxgNwoXRweEPrLRL3CwqbwOBpuHGhfdHtnM7uTJzXm1YZbU
         aJZiTIMN9vEwlJzTUK4OYFpVynKMswCrvgoTuartJOk+sxHjvW4Kolv2yikrdnBgt+I3
         5TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701254; x=1721306054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TMSDdjSHMMbfEYs+qwLdoVucqWbdqXw+KkemXAy9e8=;
        b=S9/e43XZNGY3X4hNJkBYssKqDFHtjupqb1D6hKFiYoRVhi9e+lF0EcYo3uC/kwet9B
         /k+5olzpx7Xvfu9t455Y96SsB1YLK6W7PeJEciMT2va5zFsK5pzPUCf+V0p3MJzOehwr
         rn8ye05/19kV0Z9EvAY2UpxdtnndW2pdEDjj5CEiXx3TvZ6GH74bFbv6lBzIFkuMh6Tg
         r9tHOj1yYRfQ/jU42WBytr80IGtgt5x6aHcSKZ87zKpfyiXCTiYq+MCoKJWnsfu0TCzE
         J0I6Qo35quPxeRnV74BS04clxVq6/G3DQODWW9uB+QAPeJz4or0tWc+owBHgo8GkFdXf
         S/zg==
X-Gm-Message-State: AOJu0YxNmligfHAa4K+cSphlbU78ysF+F+C5L0ipczs+39tq4qAqJgPa
	pTGQ8PNsNQGU9i+VhqN59UfEas32iPkaf8bkgl+wrUAI4yqWzGIBJP1bGoMkyHY=
X-Google-Smtp-Source: AGHT+IG3ie0L2yQcBYNCkX1wFuOkYRefHCR78VISFx6nmwufdVRAZ+HS8zHmnFUi0sv7+fPHPwtL+g==
X-Received: by 2002:a05:600c:3b93:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-427981e0751mr26099585e9.14.1720701254480;
        Thu, 11 Jul 2024 05:34:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741fa6sm118583955e9.45.2024.07.11.05.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:34:14 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: renesas: r9a08g045: Add DMAC node
Date: Thu, 11 Jul 2024 15:34:05 +0300
Message-Id: <20240711123405.2966302-4-claudiu.beznea.uj@bp.renesas.com>
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

Add DMAC node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 741c9226581f..b9114d1714c9 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -363,6 +363,44 @@ irqc: interrupt-controller@11050000 {
 			resets = <&cpg R9A08G045_IA55_RESETN>;
 		};
 
+		dmac: dma-controller@11820000 {
+			compatible = "renesas,r9a08g045-dmac",
+				     "renesas,rz-dmac";
+			reg = <0 0x11820000 0 0x10000>,
+			      <0 0x11830000 0 0x10000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 112 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 114 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 116 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 118 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 119 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 121 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 122 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 123 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 124 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD R9A08G045_DMAC_ACLK>,
+				 <&cpg CPG_MOD R9A08G045_DMAC_PCLK>;
+			clock-names = "main", "register";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_DMAC_ARESETN>,
+				 <&cpg R9A08G045_DMAC_RST_ASYNC>;
+			reset-names = "arst", "rst_async";
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		sdhi0: mmc@11c00000  {
 			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-- 
2.39.2


