Return-Path: <dmaengine+bounces-5358-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B0AD5648
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8AA3A89E4
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347B283CA3;
	Wed, 11 Jun 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="v5rnMyAs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA828541C
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646824; cv=none; b=iFIh8wC5Eyt/MLC1QHf1Iks4zsF77+kZx3FBHSK3IIQDF2pzAHUf3O0RKr3pcywknhuQ7YdKPFLl4ZA5nFcukwM13WK4AneyS/sESqwNsRn7+tYGnwX8eCnpPgsxWoec9hYxheFTqTgGXVEpj5/ZcU3/y/rYLRKFfMkNbdUjKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646824; c=relaxed/simple;
	bh=OwZYPy6rlzwZIArlF9lrCLQyQuHFt7ZjSzgDcEQMuBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjuWJ6VV+Haz0yTplZzIraxYzniLrpxsuRWSEGcrwqk+dklaxFDZ6fBfFcX18U0Hqz77lSnmFvo5tdGzje1n5AiUNLMb5ATIq/LHUyz9iaAg8tWVFiMzxkrfqPr7SVjB7rwLykBnvAuSW0ZGQwKXJ6Pz3zk876m/AnNudh+J4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=v5rnMyAs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so81835865ad.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646821; x=1750251621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfkuc3Nm6XNXxPvRJIgpzIHQXi51C7ZBujG/Lertj5Y=;
        b=v5rnMyAs0vQpyaummZegu9aJcVqtckwEt0dmd5b+1JPotFPml5QohfkuROcqwdI7dA
         wZmMv1atOFklvcG910jzOAAN1eI35jcA7AzeJ0VLa4kNDO/Re8wKOZ6ds+5SMLs+pdQ4
         tdXx+63q+29PeH6tQZjbvbigRnMW5RWYEXD5vwcFAJC4/TsUvG8PuK6eEtSo1FG2Ff27
         n69ZKfoCqpVgaYWXctwHXo5VBPOI2lH5RUAhK9RLQnyPkOnp4htQkwuSQ1uO3MlHIUjJ
         A+DLHWk0zoGcVp5NSnavdCNfMtWd4u4vNfPvuIrc76w/cWm+ziZsG8cqy8g6C3doOHG+
         UhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646821; x=1750251621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wfkuc3Nm6XNXxPvRJIgpzIHQXi51C7ZBujG/Lertj5Y=;
        b=CHBhU6479akZ40nSTZH8A0FFJbf0VmCgc2iDaZQmUjMtKJPswIaj19RUwuuKNscRvx
         N5AxMnnK/a9ObT8SyBMldwkwwW7jDZK9jf5Ta0F8436VGMKkbw8Vzjy6SiZ+csaUCWFN
         PMc0KwfKZwgzqTmOWw1ND8n+8x5hZMDLhqctHWQm1q00pzT5kVqKTZCkuTOVP4PQYmE7
         ZJsiPTUMiaqyknBXJ3DePjFki9v6gVaNloRLpVVxNWAd7UaBudG9RkEKn1STWwkkDTg6
         m42BLn1UKmoJZ+xkIAVQN0LZUDpnmEapgiHUaPCX1uzE7DDL7N84HOX3s4s4puMBaPXs
         H3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUVTh9cUdvdKLYN6mXYEbIW2XmIoP7t9+RvWoUZywAhphfIKV/h7UXJSxs795mKss1AqwVD3Y8iaJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6PbqivxNxibVyPg70bZHqCxuUF8WMwGxTTduL1GUlVdyYgyX
	FzqRu/Im05GOnBA6jAjZzXbEy7vQfnKMDSJ0P3lXJ3eTLEeZV5bmdShIC8CzxdYXKVs=
X-Gm-Gg: ASbGncvPhkqYtjefrw8oJxEy0C0Itd4mxwPc5uDuSRZ8+hxCUpDrWgnds9/JKOlX636
	Mk55WHzA3KNg/7yTTdPL0ZB8XyewwvLTs9M629d+dQw5fBCy8Bk5w4c1yRzd+FbwpTiqpGBeVul
	aDEAFBy8bYpLxz9SyKmG54KWXA0gC7RZ/0GyoPDLVNsWB4DXp8AjBok61Nz2+TwXna3H3wetGi4
	bva89tBnRnbvuo7ZQFBR5RQkyxkbbDyhbH2X7WD4CO2HSswbPI4bDM5uTD13sjY+09n+6agT7t9
	agfRPznot3eYtWXZN6HRwF18Vou2i1FGo2y0n3rIQSYZg9DcNfr+eSbVUWat2GWg7NSzhM/Nkvl
	nOB84RxTUOIYrHxMnttEJMA==
X-Google-Smtp-Source: AGHT+IGTQR16JIfczgjiJDhE97qKg0H9XYRosojidd3FLQgGETflIpsSTEjq5mENRWeE6+WcGFS80A==
X-Received: by 2002:a17:902:e5c6:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23641b19943mr43885485ad.30.1749646821466;
        Wed, 11 Jun 2025 06:00:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.06.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:00:21 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 5/8] riscv: dts: spacemit: Add dma bus and PDMA node for K1 SoC
Date: Wed, 11 Jun 2025 20:57:20 +0800
Message-ID: <20250611125723.181711-6-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611125723.181711-1-guodong@riscstar.com>
References: <20250611125723.181711-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize the K1 SoC device tree to better reflect the hardware topology
by introducing a dedicated dma_bus node that groups devices sharing
the same address translation scheme. This change aligns with the actual
hardware organization where devices are physically connected to different
bus segments with different address translation characteristics.

The changes include:
- New dma_bus node with:
  * DMA address translation ranges:
    - First range:  0x0_00000000 -> 0x0_00000000 (size: 2GB)
    - Second range: 0x1_00000000 -> 0x1_80000000 (size: 12GB)
  * All UART devices moved under this bus to reflect their shared address
    translation domain

- New PDMA controller node under dma_bus with:
  * Base address and interrupt configuration
  * Clock and reset controls
  * 16 DMA channels
  * Required DMA cell properties

The PDMA node is marked as disabled by default, allowing board-specific
device trees to enable it as needed.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 234 +++++++++++++++------------
 1 file changed, 128 insertions(+), 106 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index dead05a3c816..557feac860de 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -369,112 +369,13 @@ syscon_apbc: system-controller@d4015000 {
 			#reset-cells = <1>;
 		};
 
-		uart0: serial@d4017000 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017000 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART0>,
-				 <&syscon_apbc CLK_UART0_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <42>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart2: serial@d4017100 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017100 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART2>,
-				 <&syscon_apbc CLK_UART2_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <44>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart3: serial@d4017200 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017200 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART3>,
-				 <&syscon_apbc CLK_UART3_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <45>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart4: serial@d4017300 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017300 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART4>,
-				 <&syscon_apbc CLK_UART4_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <46>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart5: serial@d4017400 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017400 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART5>,
-				 <&syscon_apbc CLK_UART5_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <47>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart6: serial@d4017500 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017500 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART6>,
-				 <&syscon_apbc CLK_UART6_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <48>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart7: serial@d4017600 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017600 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART7>,
-				 <&syscon_apbc CLK_UART7_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <49>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart8: serial@d4017700 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017700 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART8>,
-				 <&syscon_apbc CLK_UART8_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <50>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart9: serial@d4017800 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017800 0x0 0x100>;
-			clocks = <&syscon_apbc CLK_UART9>,
-				 <&syscon_apbc CLK_UART9_BUS>;
-			clock-names = "core", "bus";
-			interrupts = <51>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
+		dma_bus: bus@4 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
+				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
+			ranges;
 		};
 
 		gpio: gpio@d4019000 {
@@ -792,3 +693,124 @@ pwm19: pwm@d4022c00 {
 		};
 	};
 };
+
+&dma_bus {
+	pdma0: dma-controller@d4000000 {
+		compatible = "spacemit,pdma-1.0";
+		reg = <0x0 0xd4000000 0x0 0x4000>;
+		interrupts = <72>;
+		clocks = <&syscon_apmu CLK_DMA>;
+		resets = <&syscon_apmu RESET_DMA>;
+		#dma-cells= <2>;
+		#dma-channels = <16>;
+		status = "disabled";
+	};
+
+	uart0: serial@d4017000 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017000 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART0>,
+			 <&syscon_apbc CLK_UART0_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <42>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart2: serial@d4017100 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017100 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART2>,
+			 <&syscon_apbc CLK_UART2_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <44>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart3: serial@d4017200 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017200 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART3>,
+			 <&syscon_apbc CLK_UART3_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <45>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart4: serial@d4017300 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017300 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART4>,
+			 <&syscon_apbc CLK_UART4_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <46>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart5: serial@d4017400 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017400 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART5>,
+			 <&syscon_apbc CLK_UART5_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <47>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart6: serial@d4017500 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017500 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART6>,
+			 <&syscon_apbc CLK_UART6_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <48>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart7: serial@d4017600 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017600 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART7>,
+			 <&syscon_apbc CLK_UART7_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <49>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart8: serial@d4017700 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017700 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART8>,
+			 <&syscon_apbc CLK_UART8_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <50>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart9: serial@d4017800 {
+		compatible = "spacemit,k1-uart", "intel,xscale-uart";
+		reg = <0x0 0xd4017800 0x0 0x100>;
+		clocks = <&syscon_apbc CLK_UART9>,
+			 <&syscon_apbc CLK_UART9_BUS>;
+		clock-names = "core", "bus";
+		interrupts = <51>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+}; /* &dma_bus */
-- 
2.43.0


