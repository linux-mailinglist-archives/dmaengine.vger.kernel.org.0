Return-Path: <dmaengine+bounces-5339-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7132AD4D9B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0150C17BAD1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FE2475E3;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcN9Rl7g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFC23F404;
	Wed, 11 Jun 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628485; cv=none; b=tBA6Y7YZqrhp7HAzDGPymrJgtMi+5VeQJivkRfHR0N98k0zJk7vmKb0L5KUUZ5rLzCeLyDpC1FMCHonxQx44+O2nBRvP62Xjx8tvevgBRFpTzt3jxOyLOOnUlO5zKalCq6/RMClzEqQEILNp8hhCW3D/xPWAkoQAL2Z44s1AAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628485; c=relaxed/simple;
	bh=8GrpHyotFw6qoax0TmiooIxZmjK9mk3pgyVRG2KobhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwArnV0/Om9aJg77zjJbO042539zDOdeUxtINLbpYyxOj2k273EJ0+ukaDtZ8DvJ60bI1AEs3A7NSWjkKd9zhFFQUZv6MG2JaOZ5PVmXiPx6vJOCfh/w6qNOY+lnbyTF4LLa+oQ+fZJj/CKZIOjTXPeg66dnmvE3RaE+kxpwRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcN9Rl7g; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d38b84984dso561237985a.0;
        Wed, 11 Jun 2025 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628481; x=1750233281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UymgIkDUFmAW2hJ2k6aLRjbZp7eBofh8hO/e/40bbVU=;
        b=LcN9Rl7gD5CXtdv4UJrGhV/eL1mETTnxnFJKPPxnLrhVEajLFCHiEvJfdqM86A8wIF
         mKlzXbCjCDdwh8qLVYLCVGN49HjDmX/f8zKPEU8ousyli434IA+M3lz2ANpK26G+C217
         GZUcHxGVg1j1H/ndST04/yY9m7rYcyCGUY1sk4zqdm2LGhMQekI40hlg0qBYXIj42zTL
         PvsdlOcYOASUAheEhLyRNcC0/I8aAdBKBtOpyG+jYTmFvPny7BKLby0Ict1sPbiHBDdY
         AQl7nY2f47s5AONxvSBFef7yiwfEixmSmX/mimDB+XMnDuy8NXvZhJTFnHdlCP62TbcH
         Qvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628481; x=1750233281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UymgIkDUFmAW2hJ2k6aLRjbZp7eBofh8hO/e/40bbVU=;
        b=Kg8Bup6d2JYRrkhWzHyjV7R6BpDCIXjMhOSj5c375PH9gE48slK9NBrqpy3Oi1r9Y5
         oRrp4mSjhRMLar/huKkeHeqJMQK1eGvjahLZCzs+Az4OXdTompD77fdC0aeC2TStEsLc
         PCIN5jsPCEmXLIHrlZndDZ/a3P2WC+t2aTQ3fpWpw8TDYsHfzOg1artWtn4zjog/hgoS
         hVPTjCqUjCqgtl3HvXO5OGr/VOgmWykc1DAIB51mhfByoPUgR6qNmG90RkFgEqY7ZPps
         xBKiv55nJ+Jhfb5IprJcLnp2kZ56Nc+39JdyGpx2seloVHHNWyo6JdzeLBEbRdkINRFw
         it2g==
X-Forwarded-Encrypted: i=1; AJvYcCUFCChi/36CTRTjgntf83tegHBfF3kv8Sindb2rM9Pjl6RNN4ZdKlw7CgmL3e8R09Ee4o20+st6v04uaPZm@vger.kernel.org, AJvYcCVtskCgudu5pmXt79W9XLmqk5FsEQGE7hj/bJwtbZUXSg3EsVzuYygJwMNmHzgmXEt1UAkmBvd7HpMn@vger.kernel.org, AJvYcCW4GjlAOWUJ7FPRG0tdGk4T260Uuv5xzcBAHtGDktXit462PDvqeBjg0NRT4AfbWBwr/50wW/oa3aU7@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyTgTsRI5tWiM5VPGPOgHhK2K44yg7xHGDzzS84G9Ddv/hxHL
	WJCNRlo5B4GpRINPjXyQQISy52qLUG/ylE45n3G5ACRUMzOyZ/cMPpcS
X-Gm-Gg: ASbGnctbB9QfJem0G2YwH1wYOlXzuIh4PP+5khZyoqPhe9a5f8lgllqA+E/kzPOdmes
	P7gw8095Z8x5u95QUk094gE5ENou6XlwuNiO3d06q6KFgFFVwju6We9cnA1hSK8F3JQd+m3uKbE
	Bors0LEvaeUx2Yi3+Gq1AekXeOpoK4tIeW/74dzS+ufgPhnyjoBMoL6J51lVHF2CaPaIY+k2kzF
	t9qUxDcrSJj+C3fCAj2PyceySBAA5EEM+630H4iYM2/pOOfO3oW+OP3SamtBlRFOMUKKBuJQR4r
	cyxslAv+kqvucmfZ1WrGvOfLNE1KobCmVQiGSw==
X-Google-Smtp-Source: AGHT+IFcYfRlGLgXB5F75tcWrqlrnxZDfFg6hV8DyibBKxLYVxu4hGJ8Kf67guFwXWUTsXHBzsnNvg==
X-Received: by 2002:a05:620a:29c1:b0:7c5:562d:ccf4 with SMTP id af79cd13be357-7d3a955398amr275831685a.4.1749628481494;
        Wed, 11 Jun 2025 00:54:41 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d250d7c2b8sm832873585a.16.2025.06.11.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 00:54:41 -0700 (PDT)
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
Subject: [PATCH v3 3/4] riscv: dts: sophgo: add reset generator for Sophgo CV1800 series SoC
Date: Wed, 11 Jun 2025 15:53:17 +0800
Message-ID: <20250611075321.1160973-4-inochiama@gmail.com>
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

Add reset generator node for all CV18XX series SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi    |  7 ++
 arch/riscv/boot/dts/sophgo/cv18xx-reset.h | 98 +++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-reset.h

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index ed06c3609fb2..4c3d16764131 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/sophgo,cv1800.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include "cv18xx-reset.h"
 
 / {
 	#address-cells = <1>;
@@ -24,6 +25,12 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		rst: reset-controller@3003000 {
+			compatible = "sophgo,cv1800b-reset";
+			reg = <0x3003000 0x1000>;
+			#reset-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx-reset.h b/arch/riscv/boot/dts/sophgo/cv18xx-reset.h
new file mode 100644
index 000000000000..7e7c5ca2dbbd
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv18xx-reset.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (C) 2025 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef _SOPHGO_CV18XX_RESET
+#define _SOPHGO_CV18XX_RESET
+
+#define RST_DDR				2
+#define RST_H264C			3
+#define RST_JPEG			4
+#define RST_H265C			5
+#define RST_VIPSYS			6
+#define RST_TDMA			7
+#define RST_TPU				8
+#define RST_TPUSYS			9
+#define RST_USB				11
+#define RST_ETH0			12
+#define RST_ETH1			13
+#define RST_NAND			14
+#define RST_EMMC			15
+#define RST_SD0				16
+#define RST_SDMA			18
+#define RST_I2S0			19
+#define RST_I2S1			20
+#define RST_I2S2			21
+#define RST_I2S3			22
+#define RST_UART0			23
+#define RST_UART1			24
+#define RST_UART2			25
+#define RST_UART3			26
+#define RST_I2C0			27
+#define RST_I2C1			28
+#define RST_I2C2			29
+#define RST_I2C3			30
+#define RST_I2C4			31
+#define RST_PWM0			32
+#define RST_PWM1			33
+#define RST_PWM2			34
+#define RST_PWM3			35
+#define RST_SPI0			40
+#define RST_SPI1			41
+#define RST_SPI2			42
+#define RST_SPI3			43
+#define RST_GPIO0			44
+#define RST_GPIO1			45
+#define RST_GPIO2			46
+#define RST_EFUSE			47
+#define RST_WDT				48
+#define RST_AHB_ROM			49
+#define RST_SPIC			50
+#define RST_TEMPSEN			51
+#define RST_SARADC			52
+#define RST_COMBO_PHY0			58
+#define RST_SPI_NAND			61
+#define RST_SE				62
+#define RST_UART4			74
+#define RST_GPIO3			75
+#define RST_SYSTEM			76
+#define RST_TIMER			77
+#define RST_TIMER0			78
+#define RST_TIMER1			79
+#define RST_TIMER2			80
+#define RST_TIMER3			81
+#define RST_TIMER4			82
+#define RST_TIMER5			83
+#define RST_TIMER6			84
+#define RST_TIMER7			85
+#define RST_WGN0			86
+#define RST_WGN1			87
+#define RST_WGN2			88
+#define RST_KEYSCAN			89
+#define RST_AUDDAC			91
+#define RST_AUDDAC_APB			92
+#define RST_AUDADC			93
+#define RST_VCSYS			95
+#define RST_ETHPHY			96
+#define RST_ETHPHY_APB			97
+#define RST_AUDSRC			98
+#define RST_VIP_CAM0			99
+#define RST_WDT1			100
+#define RST_WDT2			101
+#define RST_AUTOCLEAR_CPUCORE0		256
+#define RST_AUTOCLEAR_CPUCORE1		257
+#define RST_AUTOCLEAR_CPUCORE2		258
+#define RST_AUTOCLEAR_CPUCORE3		259
+#define RST_AUTOCLEAR_CPUSYS0		260
+#define RST_AUTOCLEAR_CPUSYS1		261
+#define RST_AUTOCLEAR_CPUSYS2		262
+#define RST_CPUCORE0			288
+#define RST_CPUCORE1			289
+#define RST_CPUCORE2			290
+#define RST_CPUCORE3			291
+#define RST_CPUSYS0			292
+#define RST_CPUSYS1			293
+#define RST_CPUSYS2			294
+
+#endif /* _SOPHGO_CV18XX_RESET */
-- 
2.49.0


