Return-Path: <dmaengine+bounces-5340-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5FFAD4DA9
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE023A84AD
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E0248F46;
	Wed, 11 Jun 2025 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGem+Kdi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042724678B;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628487; cv=none; b=KVldjOh0q1kHsHBOtVRi28yKeWRQO4ahJUIZRzcxvLYOumy+sG21QE1WJNNcb+Jm/cYxA6W6oB3hy3ZYKn4igFaKTCDgNHUWKKk2T2VcyjyDU9TwOZO6nqZjC1v59mTruAd45FNt9/T9WU4Bfw61F4BpRAzYNEwIfbVa2Q61nYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628487; c=relaxed/simple;
	bh=VluJ5mmYbGngSNNUREfnzarLKZaoN59HUH1rSdoa7gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9X+3lO8aLmkjl/LAzWhMlRGxSCCr5ORzxeM6WXFSV4A386dExz0dH2/QjjiGluc5Hxewh58riZLUApYdlEgcOFdHYg/91aMSI6gk0YJJz06hW0yGpET+++Eg9Y+ASd2i29uaj9GSsoN3AXaIx0PngOlwvJKI8+am70EjMUU4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGem+Kdi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so69126485a.1;
        Wed, 11 Jun 2025 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628485; x=1750233285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhFbypeFAxQ8f5bzL+8ikB/KiObjW6nRA+DZBhJ2u9A=;
        b=lGem+KditxvbZh8417eDN17ATiT4mJpqGdi5M6muVhcraJ+CUM5rr8a2cLyIjcNCy2
         HP2QOukYc/FQG0SxY8akbteeLlMmZNPeUagS0D1yRjPdwtoCDzRIVRM8TLg5/lFql4b4
         EDRszTWPTydavWtcTSWEdY8un6+/J07STF5wcsQpzf1difChD3iekdAvPItR9+R04GyG
         lJYrELI8jY+hkxFM3jnTTQjjiXYqesWDXMqA7tJP7KHHRugnq+7c3nP8x5ll+61V8uH7
         P6WlqSRJFEQbveI63RXRO5h4XbXUas1e1ISZP4kaBF7NiDnZsqlbLyN5/rqD4XuO0VCk
         YCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628485; x=1750233285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhFbypeFAxQ8f5bzL+8ikB/KiObjW6nRA+DZBhJ2u9A=;
        b=BGLTMNXmvvsUY6GJh6S4e4vlAx08UQngvC49R8Ut2lg0HDWWuY7j56BggZEhshjOaV
         F2f50KXQqgsFJ8vVsebXCN6H/woGSkunl1JKv4KvzuTcdJ+2nuSKhLT3e+MNwitbUTI0
         XfPx+vcByt9PrjXEga5bhqkyDJ7j7Vssmcz4ndBYiZcxJCmhj7gPm5XYNlOE2LDjTKy3
         QdlUB+gwNJGL5bh2+48//cWffXYXwSRlfyCl/qpZB6WQ9T4gb/WqfxagsQHcyhSicjhm
         T4JP4ZeEE395XJ+Vz1zdvG0VzjkRael2EPpkSr/DvlS8ZpWycqsMzJqqB8+4WMkuzDw2
         jX7w==
X-Forwarded-Encrypted: i=1; AJvYcCU0G8Ieyt8sNDkQYAhXc3XZPtxaHJwDx694ZXIdAaD85fkFPMXzckJkVsfBB/RCayvyi66b8/PrOAoR@vger.kernel.org, AJvYcCUPO4nOCrbMWMpwvPz9uH5mPkAeCLrS76y2bAtBRZ+noerui2avaZDVL1VYF01z+QXXe++cjzofPG4E@vger.kernel.org, AJvYcCXi/OV4V0jmmfBdUctcbt5lKEkcvf/bmners9fDfXiwjT/dZt8tgHjx3+o2M1SvAZoT0XdJ9A3/bh3Lve7l@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgKtaDlJahiTcCHK1WVmJZfDw6UtFrdesFLs80/JB9N5yvYHz
	dh/kQG0FFk8SyTWgLu/uiCfLqYc8n6MP8DFtPuAVX1TXGkUmAwWI2yGz
X-Gm-Gg: ASbGncuuB+0AraKbT6a2fj59muFmV9IsMlsW0eK5cZMxKyzxFfu9pZlwEWIADCqu2Qb
	aku8LZQxmzQfhbt3dfTVI2eZ8hGRdbQN944r7Rplnlze3q/RTcBCxz6Aj9Tou+/6MuHiNsN3882
	quva8hFvDzdI2TRYzV13Gi91CyOa/wzL6Ks5t9Oi8lEIptsmZBo4lVXMnEZMHWSFzY+38qGkLeS
	RQ1HduUnDF50MK346+RfI6UmBcfloJbiOrQz/Z6NyLoYLhTL4PWx8S9ulysKqKWTF3nxGfsgyrm
	Zu6z3Ghjvyj9JuiIc7RABZ6SITUA3dFjV9nyOA==
X-Google-Smtp-Source: AGHT+IG+bZxDKiJkiUxLzUSj6ZSrcG1zMQKfyU+XGW5MIGqNr/oq3BfFTD+gZoUkdiX7PQSX/dupCg==
X-Received: by 2002:a05:620a:460e:b0:7d3:9e56:6345 with SMTP id af79cd13be357-7d3a88088c9mr358828585a.10.1749628484647;
        Wed, 11 Jun 2025 00:54:44 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a60a1dbsm822918885a.56.2025.06.11.00.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 00:54:44 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dmaengine@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 4/4] riscv: dts: sophgo: add reset configuration for Sophgo CV1800 series SoC
Date: Wed, 11 Jun 2025 15:53:18 +0800
Message-ID: <20250611075321.1160973-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075321.1160973-1-inochiama@gmail.com>
References: <20250611075321.1160973-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add known reset configuration for existed device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 4c3d16764131..e91bb512b099 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -36,6 +36,7 @@ gpio0: gpio@3020000 {
 			reg = <0x3020000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			resets = <&rst RST_GPIO0>;
 
 			porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -54,6 +55,7 @@ gpio1: gpio@3021000 {
 			reg = <0x3021000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			resets = <&rst RST_GPIO1>;
 
 			portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -72,6 +74,7 @@ gpio2: gpio@3022000 {
 			reg = <0x3022000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			resets = <&rst RST_GPIO2>;
 
 			portc: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -90,6 +93,7 @@ gpio3: gpio@3023000 {
 			reg = <0x3023000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			resets = <&rst RST_GPIO3>;
 
 			portd: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -133,6 +137,7 @@ i2c0: i2c@4000000 {
 			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C0>;
 			clock-names = "ref", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(33) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C0>;
 			status = "disabled";
 		};
 
@@ -144,6 +149,7 @@ i2c1: i2c@4010000 {
 			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C1>;
 			clock-names = "ref", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C1>;
 			status = "disabled";
 		};
 
@@ -155,6 +161,7 @@ i2c2: i2c@4020000 {
 			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C2>;
 			clock-names = "ref", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(35) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C2>;
 			status = "disabled";
 		};
 
@@ -166,6 +173,7 @@ i2c3: i2c@4030000 {
 			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C3>;
 			clock-names = "ref", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(36) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C3>;
 			status = "disabled";
 		};
 
@@ -177,6 +185,7 @@ i2c4: i2c@4040000 {
 			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C4>;
 			clock-names = "ref", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(37) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C4>;
 			status = "disabled";
 		};
 
@@ -188,6 +197,7 @@ uart0: serial@4140000 {
 			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst RST_UART0>;
 			status = "disabled";
 		};
 
@@ -199,6 +209,7 @@ uart1: serial@4150000 {
 			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst RST_UART1>;
 			status = "disabled";
 		};
 
@@ -210,6 +221,7 @@ uart2: serial@4160000 {
 			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst RST_UART2>;
 			status = "disabled";
 		};
 
@@ -221,6 +233,7 @@ uart3: serial@4170000 {
 			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst RST_UART3>;
 			status = "disabled";
 		};
 
@@ -232,6 +245,7 @@ spi0: spi@4180000 {
 			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI0>;
 			clock-names = "ssi_clk", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(38) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPI0>;
 			status = "disabled";
 		};
 
@@ -243,6 +257,7 @@ spi1: spi@4190000 {
 			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI1>;
 			clock-names = "ssi_clk", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(39) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPI1>;
 			status = "disabled";
 		};
 
@@ -254,6 +269,7 @@ spi2: spi@41a0000 {
 			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI2>;
 			clock-names = "ssi_clk", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(40) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPI2>;
 			status = "disabled";
 		};
 
@@ -265,6 +281,7 @@ spi3: spi@41b0000 {
 			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI3>;
 			clock-names = "ssi_clk", "pclk";
 			interrupts = <SOC_PERIPHERAL_IRQ(41) IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPI3>;
 			status = "disabled";
 		};
 
@@ -276,6 +293,7 @@ uart4: serial@41c0000 {
 			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst RST_UART4>;
 			status = "disabled";
 		};
 
-- 
2.49.0


