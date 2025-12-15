Return-Path: <dmaengine+bounces-7634-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B580BCBF24C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 18:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7A57301B624
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C733C53A;
	Mon, 15 Dec 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="kRZNdhI7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536733ADB4
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816761; cv=none; b=YuUelAyXWTXcxpqxAk5o3VtGbvXsi7B8iETU0lWWYvv9eZ5snSf84RV75QiOgzcYzhgsBC4b4quQEE34DfVdeKqHmyhxWLhpniiVpxKZtH/KhbcgTBDMdk7j9aoVMMPFh/ZUFxKU0xU2n2tafIjN4iwymMglzcBF5dJIgj5rEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816761; c=relaxed/simple;
	bh=zNw09kOsPbEJayoOghWFNDJf8HFgX3f+gFhYXhvRe7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfivYI/5uvCdZh6247zZE2Q78ENimcTgmfyoFae//bEqpcLKMpBNjsulmvlS+zcPWt4ajyXwyC9FeFGcAubUezsAZpe2IXR2eacXcARaWwnhQpqhvYaKFgf+iACLMI4n4PfaygLvSkUSOS9oIEMarz6gFwqK4oXVK0A4bSla2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=kRZNdhI7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so26285045e9.0
        for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816747; x=1766421547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/34UGaq9v643aeXJRAvLRyUNbZhdcO0qFb5NQcEAoQ=;
        b=kRZNdhI7um/1xRWaezpDXyQa4S+18TTiz/dd9gU0vELfItpxYtOkepGcXvbm1Jm3sJ
         IH95ZN+s0UADR4EnuivkEvJ6q3aHjIV4HfQpsNHiiKAQ5lUEqfL8wU1HrVOz+6XQZcow
         m1I1c1LPIvlfJOmiHuqe3AtW5sZtVzDS4RjHVG5lCP7q8OSSKhjEDs73atNvUnxeMUeN
         Li1nYaknzXrjvDX0tg/uzi/ajtEvRxKttJEmBPxEr/HhxXOuloDqdSsFgwJoniMopb0m
         lEF6mA61yjRyWdj6jMiyrKmS3Qqgg8JEHYNhMEvyiAdp2rr1KQ8dzq6HMmYjpYf4ewar
         eoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816747; x=1766421547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/34UGaq9v643aeXJRAvLRyUNbZhdcO0qFb5NQcEAoQ=;
        b=ND8Y7PTzNuKoRABP4XEVqNP5nJ7OIlgQkNHm8KLQr3NlwSkVIrjTrL4f8c7zenI9ll
         L0hRFWIUq18+Yi/0oU1wqp8h+PvDxUJTbI5LxTUghRNHFgPWaiSzYfpgIv13FpevXqyn
         UDrjknLADS3Ej52gP8J8oYyixKqXXHLVKh8xEUB4VtrZk9LMDmVSq0qwE9Es5T6W7IaO
         vy2HhqeEfk0Mu/E6pn+js2n6aKArCZjNiM/4oaHb5NcmJOJblwRnzqTRpbMxWUgoxhcd
         x8uecsi4W4k6f5mZbuwNIKm7jL2V3uN83Chjg7f0/EHmU/kqMakUTISitBf13JbVZ4q5
         bD8w==
X-Forwarded-Encrypted: i=1; AJvYcCVwKNLb8KAevs5bxIY9sby0v4xLBJdQaaVrAvTnIijOjjMC1iLWrDbwNlFm8+ghQYniybDwHopgN0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7aAuQd2onyJUA/Np47blqrRChsS2gySgd4hopFEsyJNiD0OD
	8m5xOC+8+i6GWmzbL/pM0wfgqE3hmrJHxxkQMbH1WUWI27eDf7h41CcuuM/ReuwXqLQ=
X-Gm-Gg: AY/fxX6iIZm5ZGCwq8q+ZAqRJamikNSptZ9uXpiBMH6bjuFakWNTUTcceNAYs2IEqde
	BqycfidaZMc4TmScUE13H7/VHcolGUTVJShM1H8ehOhXt145IfGAwxI5Lk/QaoiCAa8Z91bMkuC
	04qvZwTJunoVHMH+LWbNzuobfUKF+tXRaxz2tgb3qgFpdmGyTz6dtKV/s63o704s8nNbje9eWAC
	PfbxQGHGqsS+6N4Li/0csEyM2PyeaKoQPzhqCBbbjqGrQIdU136+z++mrqAAkl86ovzEbS55wIH
	xRfBszWZHigyF8a/JpNquBiaCdJ96AdidZf/LiUf7UBgQ1ynvwkO1cymdfUQFaw56gb44mtWvh3
	KbdSSFRQJzhnPShfoYerj724zvWDbbQzgpq9RcDRh6+XbGsRGDivmVz89VdhjFwMPiqyHHDc1xR
	o50Gy1hei4GNLXwk4sxT7PyNcA3xEFlHiusKO0bLeyIz3g
X-Google-Smtp-Source: AGHT+IELsClHkobrZVkV4DH8X5CX6hHOjfzlKDiKhXVHNJtHRVvLO1MbKag14T7uws5CKFtzBM+m3w==
X-Received: by 2002:a05:600c:1ca4:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-47bd466125cmr4165215e9.28.1765816747126;
        Mon, 15 Dec 2025 08:39:07 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:06 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 17/19] arm64: dts: microchip: add LAN969x support
Date: Mon, 15 Dec 2025 17:35:34 +0100
Message-ID: <20251215163820.1584926-17-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Microchip LAN969x switch SoC series by adding the SoC DTSI.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Rename to lan9691
* Split SoC DTSI and evaluation board commits
* Use SoC specific compatibles for devices
* Alphanumerically sort remaining nodes
* Apply DTS coding style

 arch/arm64/boot/dts/microchip/lan9691.dtsi | 487 +++++++++++++++++++++
 1 file changed, 487 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/lan9691.dtsi

diff --git a/arch/arm64/boot/dts/microchip/lan9691.dtsi b/arch/arm64/boot/dts/microchip/lan9691.dtsi
new file mode 100644
index 000000000000..afe8c59ee79d
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/lan9691.dtsi
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include <dt-bindings/clock/microchip,lan9691.h>
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mfd/at91-usart.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	model = "Microchip LAN969x";
+	compatible = "microchip,lan9691";
+	interrupt-parent = <&gic>;
+
+	clocks {
+		fx100_clk: fx100-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <320000000>;
+		};
+
+		cpu_clk: cpu-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000000>;
+		};
+
+		ddr_clk: ddr-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+		};
+
+		fabric_clk: fabric-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <250000000>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&l2_0>;
+		};
+
+		l2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Secure Phys IRQ */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Non-secure Phys IRQ */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virt IRQ */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hyp IRQ */
+	};
+
+	axi: axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		usb: usb@300000 {
+			compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+			reg = <0x300000 0x80000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_GATE_USB_DRD>,
+				 <&clks GCK_ID_USB_REFCLK>;
+			clock-names = "bus_early", "ref";
+			assigned-clocks = <&clks GCK_ID_USB_REFCLK>;
+			assigned-clock-rates = <60000000>;
+			maximum-speed = "high-speed";
+			dr_mode = "host";
+			status = "disabled";
+		};
+
+		flx0: flexcom@e0040000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0040000 0x100>;
+			ranges = <0x0 0xe0040000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart0: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi0: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c0: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		flx1: flexcom@e0044000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0044000 0x100>;
+			ranges = <0x0 0xe0044000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart1: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi1: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		trng: rng@e0048000 {
+			compatible = "microchip,lan9691-trng", "atmel,at91sam9g45-trng";
+			reg = <0xe0048000 0x100>;
+			clocks = <&fabric_clk>;
+			status = "disabled";
+		};
+
+		aes: crypto@e004c000 {
+			compatible = "microchip,lan9691-aes", "atmel,at91sam9g46-aes";
+			reg = <0xe004c000 0x100>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma AT91_XDMAC_DT_PERID(12)>,
+			       <&dma AT91_XDMAC_DT_PERID(13)>;
+			dma-names = "tx", "rx";
+			clocks = <&fabric_clk>;
+			clock-names = "aes_clk";
+			status = "disabled";
+		};
+
+		flx2: flexcom@e0060000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0060000 0x100>;
+			ranges = <0x0 0xe0060000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart2: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(7)>,
+				       <&dma AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi2: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(7)>,
+				       <&dma AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(7)>,
+				       <&dma AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		flx3: flexcom@e0064000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0064000 0x100>;
+			ranges = <0x0 0xe0064000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart3: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(9)>,
+				       <&dma AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi3: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(9)>,
+				       <&dma AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(9)>,
+				       <&dma AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		dma: dma-controller@e0068000 {
+			compatible = "microchip,lan9691-dma", "microchip,sama7g5-dma";
+			reg = <0xe0068000 0x1000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <16>;
+			#dma-cells = <1>;
+			clocks = <&fabric_clk>;
+			clock-names = "dma_clk";
+		};
+
+		sha: crypto@e006c000 {
+			compatible = "microchip,lan9691-sha", "atmel,at91sam9g46-sha";
+			reg = <0xe006c000 0xec>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma AT91_XDMAC_DT_PERID(14)>;
+			dma-names = "tx";
+			clocks = <&fabric_clk>;
+			clock-names = "sha_clk";
+			status = "disabled";
+		};
+
+		timer: timer@e008c000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xe008c000 0x400>;
+			clocks = <&fabric_clk>;
+			clock-names = "timer";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		watchdog: watchdog@e0090000 {
+			compatible = "snps,dw-wdt";
+			reg = <0xe0090000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fabric_clk>;
+		};
+
+		cpu_ctrl: syscon@e00c0000 {
+			compatible = "microchip,lan966x-cpu-syscon", "syscon";
+			reg = <0xe00c0000 0x350>;
+		};
+
+		switch: switch@e00c0000 {
+			compatible = "microchip,lan9691-switch";
+			reg = <0xe00c0000 0x0010000>,
+			      <0xe2010000 0x1410000>;
+			reg-names = "cpu", "devices";
+			interrupt-names = "xtr", "fdma", "ptp";
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&reset 0>;
+			reset-names = "switch";
+			status = "disabled";
+		};
+
+		clks: clock-controller@e00c00b4 {
+			compatible = "microchip,lan9691-gck";
+			reg = <0xe00c00b4 0x30>, <0xe00c0308 0x4>;
+			#clock-cells = <1>;
+			clocks = <&cpu_clk>, <&ddr_clk>, <&fx100_clk>;
+			clock-names = "cpu", "ddr", "sys";
+		};
+
+		reset: reset-controller@e201000c {
+			compatible = "microchip,lan9691-switch-reset",
+				     "microchip,lan966x-switch-reset";
+			reg = <0xe201000c 0x4>;
+			reg-names = "gcb";
+			#reset-cells = <1>;
+			cpu-syscon = <&cpu_ctrl>;
+		};
+
+		gpio: pinctrl@e20100d4 {
+			compatible = "microchip,lan9691-pinctrl";
+			reg = <0xe20100d4 0xd4>,
+			      <0xe2010370 0xa8>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&gpio 0 0 66>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+		};
+
+		mdio0: mdio@e20101a8 {
+			compatible = "microchip,lan9691-miim", "mscc,ocelot-miim";
+			reg = <0xe20101a8 0x24>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&fx100_clk>;
+			status = "disabled";
+		};
+
+		mdio1: mdio@e20101cc {
+			compatible = "microchip,lan9691-miim", "mscc,ocelot-miim";
+			reg = <0xe20101cc 0x24>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&fx100_clk>;
+			status = "disabled";
+		};
+
+		sgpio: gpio@e2010230 {
+			compatible = "microchip,lan9691-sgpio", "microchip,sparx5-sgpio";
+			reg = <0xe2010230 0x118>;
+			clocks = <&fx100_clk>;
+			resets = <&reset 0>;
+			reset-names = "switch";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sgpio_in: gpio@0 {
+				compatible = "microchip,lan9691-sgpio-bank",
+					     "microchip,sparx5-sgpio-bank";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <3>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+			};
+
+			sgpio_out: gpio@1 {
+				compatible = "microchip,lan9691-sgpio-bank",
+					     "microchip,sparx5-sgpio-bank";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <3>;
+			};
+		};
+
+		tmon: hwmon@e2020100 {
+			compatible = "microchip,lan9691-temp", "microchip,sparx5-temp";
+			reg = <0xe2020100 0xc>;
+			clocks = <&fx100_clk>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		serdes: serdes@e3410000 {
+			compatible = "microchip,lan9691-serdes";
+			reg = <0xe3410000 0x150000>;
+			#phy-cells = <1>;
+			clocks = <&fabric_clk>;
+		};
+
+		gic: interrupt-controller@e8c11000 {
+			compatible = "arm,gic-400";
+			reg = <0xe8c11000 0x1000>, /* Distributor GICD_ */
+			      <0xe8c12000 0x2000>, /* CPU interface GICC_ */
+			      <0xe8c14000 0x2000>, /* Virt interface control */
+			      <0xe8c16000 0x2000>; /* Virt CPU interface */
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
-- 
2.52.0


