Return-Path: <dmaengine+bounces-11595-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W1G2Aat7M2qACgYAu9opvQ
	(envelope-from <dmaengine+bounces-11595-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9FF69D9AB
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bfY22fa0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11595-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11595-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F64309434B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6E36C0D6;
	Thu, 18 Jun 2026 05:01:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF7370AF2;
	Thu, 18 Jun 2026 05:01:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758876; cv=none; b=Py8Nx9Q1XT+XqnfGvj6VC6GLgOGxeJExQg0VnHO+5EV0aKdN2M2hD3PHCadCg7YzOy3XaQrXSofBI0Wqj2aQltVhT4fUab8gEM856rDcT6dnWrPy+O8i9QcMCI+GdHaAYHJ5SHZbjk2B6LgYXlQ2A5i4f4CfFf4xxqCATEhAe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758876; c=relaxed/simple;
	bh=3AV2vNBeBxDJKHOCEfKAM1Jr2VIbFk5h5SKd3iT/Krs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grGeb0ncXndSfHC0HgBEHmv28iT5MdW89lv58W5pBziQ/9pGY1xeoY7zOFex6/7iYg865GYbzQy81IAqH2QhiyND0XqF7VuZutDHn1Yj/+Wdcpx53m7SCEny7fKe3jeN/X4HP8nJ7mU6N1xUgdlT2UWj1yLSBzfn8phVx3NjRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfY22fa0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1311F00A3A;
	Thu, 18 Jun 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758875;
	bh=XxSTDge7G/sodyzW1LRalWXyNAqy7HlSdNzSUN7zIH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bfY22fa0nEOdApvOaupy4C+cvWjZc0OQR45R14YFphqZSROfWDlxpnKnz7V97bPSe
	 k2rJ9HdaK9gSwwzBo2J+gmck6XEHBEKZ2lUpQh5k+6Kav7WRrrtIKOaSitY7IhQQ4U
	 nzYydON2mzn0wpi0WexUw0wJug6RdUX0Rh1RVVtvDf7pldTdUBwElLlXEWw0aKDbdo
	 xoWb4nzDAymwMPdyaUsSiupUno6z6HCdm0dzvKFQIcoZ9taiTfcyOGrcVfJjYgYwzc
	 lwshMzYv/fUiGXrQEFss9LY/eVz9vzFLx2MIPMNMGk2rcAFlLRbmLVrORAPYHcSzAN
	 vF8NSUR/i2JYQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:51 +0200
Subject: [PATCH 05/11] ARM: dts: ux500: Add power domains
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-5-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:linusw@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11595-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B9FF69D9AB

Add the actual power domains to all the SoC peripherals.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 58 ++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index d76a65da7011..a6fef302c994 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -154,6 +154,7 @@ sram@40020000 {
 			reg = <0x40020000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_ESRAM_12>;
 			ranges = <0 0x40020000 0x40000>;
 		};
 		sram@40060000 {
@@ -162,6 +163,7 @@ sram@40060000 {
 			reg = <0x40060000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_ESRAM_34>;
 			ranges = <0 0x40060000 0x40000>;
 
 			lcla: sram@20000 {
@@ -181,7 +183,7 @@ lcla: sram@20000 {
 		ptm@801ae000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801ae000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU0>;
@@ -197,7 +199,7 @@ ptm0_out_port: endpoint {
 		ptm@801af000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801af000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU1>;
@@ -213,7 +215,7 @@ ptm1_out_port: endpoint {
 		funnel@801a6000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x801a6000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			out-ports {
@@ -249,6 +251,7 @@ replicator {
 			compatible = "arm,coresight-static-replicator";
 			clocks = <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "atclk";
+			power-domains = <&pm_domains DOMAIN_VARM>;
 
 			out-ports {
 				#address-cells = <1>;
@@ -280,7 +283,7 @@ replicator_in_port0: endpoint {
 		tpiu@80190000 {
 			compatible = "arm,coresight-tpiu", "arm,primecell";
 			reg = <0x80190000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			in-ports {
@@ -295,7 +298,7 @@ tpiu_in_port: endpoint {
 		etb@801a4000 {
 			compatible = "arm,coresight-etb10", "arm,primecell";
 			reg = <0x801a4000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			in-ports {
@@ -314,11 +317,13 @@ intc: interrupt-controller@a0411000 {
 			interrupt-controller;
 			reg = <0xa0411000 0x1000>,
 			      <0xa0410100 0x100>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 
 		scu@a0410000 {
 			compatible = "arm,cortex-a9-scu";
 			reg = <0xa0410000 0x100>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 
 		/*
@@ -326,6 +331,7 @@ scu@a0410000 {
 		 * and various things like spin tables
 		 */
 		backupram@80150000 {
+			/* This memory is in the VSAFE (always on) power domain */
 			compatible = "ste,dbx500-backupram";
 			reg = <0x80150000 0x2000>;
 		};
@@ -334,6 +340,7 @@ L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -341,6 +348,7 @@ L2: cache-controller {
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 
 		pm_domains: power-controller {
@@ -357,6 +365,7 @@ clocks {
 			reg = <0x8012f000 0x1000>, <0x8011f000 0x1000>,
 			    <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
 			    <0xa03cf000 0x1000>;
+			power-domains = <&pm_domains DOMAIN_VPLL>; /* CHECKME: correct domain? */
 
 			prcmu_clk: prcmu-clock {
 				#clock-cells = <1>;
@@ -393,7 +402,7 @@ mtu@a03c6000 {
 			compatible = "st,nomadik-mtu";
 			reg = <0xa03c6000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
 			clock-names = "timclk", "apb_pclk";
 		};
@@ -402,7 +411,7 @@ timer@a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&smp_twd_clk>;
 		};
 
@@ -410,14 +419,15 @@ watchdog@a0410620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0xa0410620 0x20>;
 			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&smp_twd_clk>;
 		};
 
 		rtc@80154000 {
+			/* This peripheral is in the VSAFE (always on) power domain */
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-
 			clocks = <&rtc_clk>;
 			clock-names = "apb_pclk";
 		};
@@ -435,6 +445,7 @@ gpio0: gpio@8012e000 {
 			gpio-bank = <0>;
 			gpio-ranges = <&pinctrl 0 0 32>;
 			clocks = <&prcc_pclk 1 9>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio1: gpio@8012e080 {
@@ -450,6 +461,7 @@ gpio1: gpio@8012e080 {
 			gpio-bank = <1>;
 			gpio-ranges = <&pinctrl 0 32 5>;
 			clocks = <&prcc_pclk 1 9>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio2: gpio@8000e000 {
@@ -465,6 +477,7 @@ gpio2: gpio@8000e000 {
 			gpio-bank = <2>;
 			gpio-ranges = <&pinctrl 0 64 32>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio3: gpio@8000e080 {
@@ -480,6 +493,7 @@ gpio3: gpio@8000e080 {
 			gpio-bank = <3>;
 			gpio-ranges = <&pinctrl 0 96 2>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio4: gpio@8000e100 {
@@ -495,6 +509,7 @@ gpio4: gpio@8000e100 {
 			gpio-bank = <4>;
 			gpio-ranges = <&pinctrl 0 128 32>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio5: gpio@8000e180 {
@@ -510,6 +525,7 @@ gpio5: gpio@8000e180 {
 			gpio-bank = <5>;
 			gpio-ranges = <&pinctrl 0 160 12>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio6: gpio@8011e000 {
@@ -525,6 +541,7 @@ gpio6: gpio@8011e000 {
 			gpio-bank = <6>;
 			gpio-ranges = <&pinctrl 0 192 32>;
 			clocks = <&prcc_pclk 2 11>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio7: gpio@8011e080 {
@@ -540,6 +557,7 @@ gpio7: gpio@8011e080 {
 			gpio-bank = <7>;
 			gpio-ranges = <&pinctrl 0 224 7>;
 			clocks = <&prcc_pclk 2 11>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio8: gpio@a03fe000 {
@@ -555,6 +573,7 @@ gpio8: gpio@a03fe000 {
 			gpio-bank = <8>;
 			gpio-ranges = <&pinctrl 0 256 12>;
 			clocks = <&prcc_pclk 5 1>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		pinctrl: pinctrl {
@@ -570,6 +589,7 @@ usb_per5@a03e0000 {
 			reg = <0xa03e0000 0x10000>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dr_mode = "otg";
 
@@ -613,9 +633,11 @@ dma: dma-controller@801C0000 {
 			memcpy-channels = <56 57 58 59 60>;
 
 			clocks = <&prcmu_clk PRCMU_DMACLK>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		prcmu: prcmu@80157000 {
+			/* This peripheral is in the VSAFE (always on) power domain */
 			compatible = "stericsson,db8500-prcmu", "syscon";
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
 			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
@@ -641,6 +663,10 @@ thermal: thermal@801573c0 {
 				#thermal-sensor-cells = <0>;
 			};
 
+			/*
+			 * TODO: Delete these bogus regulators and replace with power
+			 * domains.
+			 */
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
 
@@ -932,6 +958,7 @@ serial0: serial@80120000 {
 
 			clocks = <&prcc_kclk 1 0>, <&prcc_pclk 1 0>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_1 DB8500_PRCC_1_RESET_UART0>;
 
 			status = "disabled";
@@ -948,6 +975,7 @@ serial1: serial@80121000 {
 
 			clocks = <&prcc_kclk 1 1>, <&prcc_pclk 1 1>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_1 DB8500_PRCC_1_RESET_UART1>;
 
 			status = "disabled";
@@ -964,6 +992,7 @@ serial2: serial@80007000 {
 
 			clocks = <&prcc_kclk 3 6>, <&prcc_pclk 3 6>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_3 DB8500_PRCC_3_RESET_UART2>;
 
 			status = "disabled";
@@ -1080,7 +1109,9 @@ msp0: msp@80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
 			       <&dma 31 0 0x10>; /* Logical - MemToDev - HighPrio */
@@ -1097,7 +1128,9 @@ msp1: msp@80124000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80124000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v1 */
 			dmas = <&dma 30 0 0x10>; /* Logical - MemToDev - HighPrio */
@@ -1115,7 +1148,9 @@ msp2: msp@80117000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80117000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
 			       <&dma 14 1 0x19>; /* Physical Chan 1 - MemToDev
@@ -1133,7 +1168,9 @@ msp3: msp@80125000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80125000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v2 */
 			dmas = <&dma 30 0 0x12>; /* Logical - DevToMem - HighPrio */
@@ -1175,14 +1212,17 @@ gpu@a0300000 {
 					  "combined";
 			clocks = <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
 			clock-names = "bus", "core";
+			power-domains = <&pm_domains DOMAIN_SGA>;
+			/* TODO: delete and replace with power-domain handling */
 			mali-supply = <&db8500_sga_reg>;
-			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		mcde@a0350000 {
 			compatible = "ste,mcde";
 			reg = <0xa0350000 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
+			/* TODO: delete and replace with power-domain handling */
 			epod-supply = <&db8500_b2r2_mcde_reg>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */

-- 
2.54.0


