Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA55F8D01
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJISPm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJISOy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C262DC;
        Sun,  9 Oct 2022 11:14:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so14082460wrj.11;
        Sun, 09 Oct 2022 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gl5E4rKbJFpFDbpqJhrmR71zChEONYs60mlVSNxv7Q=;
        b=Hf9xV59KNbiJmIeFb0v3W7hbvyktDzOgWDut5dkFFR/ntdnFPdjwz7lqmem2b8qvBl
         ialUKm9BQi1bglOo0qQJk38aY2KzDdk2LF+yp9YPP+pkUmVcq3Lv1nSz4Mhkq5h26Wfy
         WZQv9AOo5pL+lfeTTj5JiwBeX8qt12JspyIHE1AOwvv4zdnf3WrijB6JzxRKJDCNE8fU
         wkZNyTMfbr99mctiICPPaIdofvcyFEfzx33X4qFuWKfDPHjZq4hIUYF6sY+oTH+U+X8w
         7/l/pxlpSWue3AxzRqnOPa0Yf7MspZoYV7RfHtjDUNjlFON84pmWecpB+60kjclXvDlS
         Wi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gl5E4rKbJFpFDbpqJhrmR71zChEONYs60mlVSNxv7Q=;
        b=Qmbq9grrwr0Q2b/V+GHygLCYED0crjKAkZaCRdax03qc6gebW+RqqURB9HWovP89OC
         WSy4dZ6HSRMBc/taAd6F1rlQKAIk6uFbDWFWAkiZ212qfCGO2+xoA6Nl1qGDhl/bWHvC
         wEgOy2uKjZGhd/59PSGmT/5fFZnj+39pNMMWfCx/IwTa0mQz8APcPAh59oSHKuymc7Jq
         f8bsVWiUFDmzLtqXHjpHlYjKQfjBOQ9VNDDx8fDcPyxusjGDdyOc1tnR2E2ng96NpyVR
         LvNugsAJ5UHVEUtjN6bOGfXwSQKWwToS7+BQFsagggZnBORHUsNtQe+ekTtPD/EMZb97
         ndkA==
X-Gm-Message-State: ACrzQf3Cu4NqZym/fv5SdlhhkFLPat1jOleLw9i+xylp9pWbLynRoB/Y
        xCa7pQN70eXdHxTO1rOaVp4=
X-Google-Smtp-Source: AMsMyM4/vuN5Kazlk+Wovuvb1wFgsBiEW7cVEXIFXI645ABmIMQKTxjbIbuy7UceELlyuplkY/LJBw==
X-Received: by 2002:a5d:6384:0:b0:22e:6027:9da4 with SMTP id p4-20020a5d6384000000b0022e60279da4mr8859991wru.686.1665339273441;
        Sun, 09 Oct 2022 11:14:33 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:33 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 8/8] MIPS: DTS: Ingenic: Add support for the JZ4755 SoC
Date:   Sun,  9 Oct 2022 21:13:37 +0300
Message-Id: <20221009181338.2896660-9-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221009181338.2896660-1-lis8215@gmail.com>
References: <20221009181338.2896660-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add preliminary support for boards based on the JZ4755 SoC from
Ingenic.

It is a low-power SoC with a MIPS32r1 SoC running at ~432 MHz, and no
FPU.

The JZ4755 SoC is supposed to be newer than the JZ4725B SoC, but its
internals are very close to each other. So JZ4755 DT is reusing many
JZ4725b drivers because JZ4725b support in the kernel appears earlier.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/boot/dts/ingenic/jz4755.dtsi | 439 +++++++++++++++++++++++++
 1 file changed, 439 insertions(+)
 create mode 100644 arch/mips/boot/dts/ingenic/jz4755.dtsi

diff --git a/arch/mips/boot/dts/ingenic/jz4755.dtsi b/arch/mips/boot/dts/ingenic/jz4755.dtsi
new file mode 100644
index 000000000..e1630e0fe
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/jz4755.dtsi
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/clock/ingenic,jz4755-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ingenic,jz4755";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "ingenic,xburst-mxu1.1";
+			reg = <0>;
+
+			clocks = <&cgu JZ4755_CLK_CCLK>;
+			clock-names = "cpu";
+		};
+	};
+
+	cpuintc: interrupt-controller {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: interrupt-controller@10001000 {
+		compatible = "ingenic,jz4725b-intc", "ingenic,jz4740-intc";
+		reg = <0x10001000 0x14>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	osc32k: osc32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	cgu: clock-controller@10000000 {
+		compatible = "ingenic,jz4755-cgu";
+		reg = <0x10000000 0x100>;
+
+		clocks = <&ext>, <&osc32k>;
+		clock-names = "ext", "osc32k";
+
+		#clock-cells = <1>;
+	};
+
+	uart0: serial@10030000 {
+		compatible = "ingenic,jz4755-uart", "ingenic,jz4750-uart";
+		reg = <0x10030000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <9>;
+
+		clocks = <&cgu JZ4755_CLK_EXT_HALF>, <&cgu JZ4755_CLK_UART0>;
+		clock-names = "baud", "module";
+
+		status = "disabled";
+	};
+
+	uart1: serial@10031000 {
+		compatible = "ingenic,jz4755-uart", "ingenic,jz4750-uart";
+		reg = <0x10031000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <8>;
+
+		clocks = <&cgu JZ4755_CLK_EXT_HALF>, <&cgu JZ4755_CLK_UART1>;
+		clock-names = "baud", "module";
+
+		status = "disabled";
+	};
+
+	uart2: serial@10032000 {
+		compatible = "ingenic,jz4755-uart", "ingenic,jz4750-uart";
+		reg = <0x10032000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <7>;
+
+		clocks = <&cgu JZ4755_CLK_EXT_HALF>, <&cgu JZ4755_CLK_UART2>;
+		clock-names = "baud", "module";
+
+		status = "disabled";
+	};
+
+	rtc_dev: rtc@10003000 {
+		compatible = "ingenic,jz4725b-rtc", "ingenic,jz4740-rtc";
+		reg = <0x10003000 0x40>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <6>;
+
+		clocks = <&cgu JZ4755_CLK_RTC>;
+		clock-names = "rtc";
+	};
+
+	pinctrl: pinctrl@10010000 {
+		compatible = "ingenic,jz4755-pinctrl";
+		reg = <0x10010000 0x600>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpa: gpio@0 {
+			compatible = "ingenic,jz4755-gpio";
+			reg = <0>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <16>;
+		};
+
+		gpb: gpio@1 {
+			compatible = "ingenic,jz4755-gpio";
+			reg = <1>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <15>;
+		};
+
+		gpc: gpio@2 {
+			compatible = "ingenic,jz4755-gpio";
+			reg = <2>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <14>;
+		};
+
+		gpd: gpio@3 {
+			compatible = "ingenic,jz4755-gpio";
+			reg = <3>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <13>;
+		};
+
+		gpe: gpio@4 {
+			compatible = "ingenic,jz4755-gpio";
+			reg = <4>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <12>;
+		};
+
+		gpf: gpio@5 {
+			compatible = "ingenic,jz4755-gpio";
+			reg = <5>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 160 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <11>;
+		};
+	};
+
+	mmc0: mmc@10021000 {
+		compatible = "ingenic,jz4725b-mmc";
+		reg = <0x10021000 0x1000>;
+
+		clocks = <&cgu JZ4755_CLK_MMC0>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <25>;
+
+		dmas = <&dmac1 27 0xffffffff>, <&dmac1 26 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+	};
+
+	mmc1: mmc@10022000 {
+		compatible = "ingenic,jz4725b-mmc";
+		reg = <0x10022000 0x1000>;
+
+		clocks = <&cgu JZ4755_CLK_MMC1>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <24>;
+
+		dmas = <&dmac1 31 0xffffffff>, <&dmac1 30 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+	};
+
+	dmac0: dma-controller@13020000 {
+		compatible = "ingenic,jz4755-dma";
+		reg = <0x13020000 0xd0>, <0x13020300 0x14>;
+
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <29>;
+
+		clocks = <&cgu JZ4755_CLK_DMA>;
+	};
+
+	dmac1: dma-controller@13020100 {
+		compatible = "ingenic,jz4755-dma";
+		reg = <0x13020100 0xd0>, <0x13020400 0x14>;
+
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+
+		clocks = <&cgu JZ4755_CLK_DMA>;
+	};
+
+	tcu: timer@10002000 {
+		compatible = "ingenic,jz4725b-tcu", "simple-mfd";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		#clock-cells = <1>;
+
+		clocks = <&cgu JZ4755_CLK_RTC>,
+			 <&cgu JZ4755_CLK_EXT>,
+			 <&cgu JZ4755_CLK_PCLK>,
+			 <&cgu JZ4755_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <23>, <22>, <21>;
+
+		watchdog: watchdog@0 {
+			compatible = "ingenic,jz4725b-watchdog", "ingenic,jz4740-watchdog";
+			reg = <0x0 0xc>;
+
+			clocks = <&tcu TCU_CLK_WDT>;
+			clock-names = "wdt";
+		};
+
+		pwm: pwm@60 {
+			compatible = "ingenic,jz4725b-pwm";
+			reg = <0x60 0x40>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
+				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
+				 <&tcu TCU_CLK_TIMER4>, <&tcu TCU_CLK_TIMER5>;
+			clock-names = "timer0", "timer1", "timer2",
+				      "timer3", "timer4", "timer5";
+		};
+
+		ost: timer@e0 {
+			compatible = "ingenic,jz4725b-ost";
+			reg = <0xe0 0x20>;
+
+			clocks = <&tcu TCU_CLK_OST>;
+			clock-names = "ost";
+
+			interrupts = <15>;
+		};
+	};
+
+	aic: audio-controller@10020000 {
+		compatible = "ingenic,jz4725b-i2s", "ingenic,jz4740-i2s";
+		reg = <0x10020000 0x38>;
+
+		#sound-dai-cells = <0>;
+
+		clocks = <&cgu JZ4755_CLK_AIC>,
+			 <&cgu JZ4755_CLK_I2S>,
+			 <&cgu JZ4755_CLK_EXT>,
+			 <&cgu JZ4755_CLK_PLL_HALF>;
+		clock-names = "aic", "i2s", "ext", "pll half";
+
+		interrupt-parent = <&intc>;
+		interrupts = <10>;
+
+		dmas = <&dmac0 25 0xffffffff>, <&dmac0 24 0xffffffff>;
+		dma-names = "rx", "tx";
+	};
+
+	codec: audio-codec@100200a4 {
+		compatible = "ingenic,jz4725b-codec";
+		reg = <0x100200a4 0x8>;
+
+		#sound-dai-cells = <0>;
+
+		clocks = <&cgu JZ4755_CLK_AIC>;
+		clock-names = "aic";
+	};
+
+	adc: adc@10070000 {
+		compatible = "ingenic,jz4725b-adc";
+		#io-channel-cells = <1>;
+
+		reg = <0x10070000 0x30>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10070000 0x30>;
+
+		clocks = <&cgu JZ4755_CLK_ADC>;
+		clock-names = "adc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+	};
+
+	nemc: memory-controller@13010000 {
+		compatible = "ingenic,jz4725b-nemc", "ingenic,jz4740-nemc";
+		reg = <0x13010000 0x10000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <1 0 0x18000000 0x4000000>, <2 0 0x14000000 0x4000000>,
+			 <3 0 0x0c000000 0x4000000>, <4 0 0x08000000 0x4000000>;
+
+		clocks = <&cgu JZ4755_CLK_MCLK>;
+	};
+
+	udc: usb@13040000 {
+		compatible = "ingenic,jz4725b-musb", "ingenic,jz4740-musb";
+		reg = <0x13040000 0x10000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27>;
+		interrupt-names = "mc";
+
+		clocks = <&cgu JZ4755_CLK_UDC>;
+		clock-names = "udc";
+	};
+
+	lcd: lcd-controller@13050000 {
+		compatible = "ingenic,jz4725b-lcd";
+		reg = <0x13050000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <31>;
+
+		clocks = <&cgu JZ4755_CLK_LCD>;
+		clock-names = "lcd_pclk";
+
+		lcd_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@8 {
+				reg = <8>;
+
+				ipu_output: endpoint {
+					remote-endpoint = <&ipu_input>;
+				};
+			};
+		};
+	};
+
+	ipu: ipu@13080000 {
+		compatible = "ingenic,jz4725b-ipu";
+		reg = <0x13080000 0x64>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <30>;
+
+		clocks = <&cgu JZ4755_CLK_IPU>;
+		clock-names = "ipu";
+
+		port {
+			ipu_input: endpoint {
+				remote-endpoint = <&ipu_output>;
+			};
+		};
+	};
+
+	bch: ecc-controller@130d0000 {
+		compatible = "ingenic,jz4725b-bch";
+		reg = <0x130d0000 0x44>;
+
+		clocks = <&cgu JZ4755_CLK_BCH>;
+	};
+};
-- 
2.36.1

