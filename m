Return-Path: <dmaengine+bounces-11601-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3yccLL17M2qUCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11601-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386269D9F1
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f7rqHq4K;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11601-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11601-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 512DB3016C63
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B9137DEA9;
	Thu, 18 Jun 2026 05:01:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496392FFDE3;
	Thu, 18 Jun 2026 05:01:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758903; cv=none; b=myF/KeRJG30fAcmKGodHG7Udire4jC9wRD5cf0ddJYBSsFuijGmmd9Ou2ZrNCuY9ZZgjla0U6N11gnZuV2mds/JZlDSGHDviWH8gp/dmWNqlwMAlpOVXO74pE5VnkH8jMC+4TacwFVGviLF+9vYJU7J1Gx1EKesXVXCeQiW+Rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758903; c=relaxed/simple;
	bh=fjG8J44WgCmoXGioGpHOWL95CYY8uPHIIfyowvIO6/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1l+UzyFIcuahqUfwrNLzIn9pgn9gYDD/+zvyn1WTvwKPwBbcAZHxgY0IFm7zPT7whldgIbyfBwmoG7vblwn6QhssCdYhXrtXfdzKYMZi42y86jVpjAvV3zzJiu3/zbt0BFYhQdzqHmvtLjRIDdUwwZBUnWb3K3r6+/222fdZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7rqHq4K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B231F00A3A;
	Thu, 18 Jun 2026 05:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758901;
	bh=kkYJRQCZSd9fkjyBntRgZwkCUGtOFSJhGqIN3frg468=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f7rqHq4KK128xp/WfbBeeNpsundDmSGw7FrkfzfQmhfV7GB1M7Kwxagmao2JrZy6j
	 WtiEDBTtjjYhYy4EQYKSvFQDm8gTwUs7kRgiUf9cripjlZaE+mfzwi0mzlnkeQhgw5
	 bL6n96iLemoJcqBhiw75nEGpKqtD3dCCtrdhjr46yq/Xn9mECQtERRqtp8d5dLPnNU
	 3kRrf/v//lyDxp3MGCw3VUqacwSSRHHwtAngMWxfbG8Bb/Z7Hvm/Y85yMJK2jG2KrN
	 cwdjxKf6YGdCHmfiUTBhG34XZiiea/OwfPm/ihwJL22u0v8p6elqLoNbIt/4h4u5ga
	 9Ls7dY/t2OK4w==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:57 +0200
Subject: [PATCH 11/11] ARM: dts: ux500: Remove DB8500 EPOD regulators
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-11-eb5e50b1a588@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:linusw@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11601-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7386269D9F1

Delete the obsolete DB8500 EPOD regulator nodes.

Keep the VAPE and VSMPS2 compatibility regulators.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 92 ------------------------------------
 1 file changed, 92 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index fd6a075e4c93..18727953a863 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -663,97 +663,17 @@ thermal: thermal@801573c0 {
 				#thermal-sensor-cells = <0>;
 			};
 
-			/*
-			 * TODO: Delete these bogus regulators and replace with power
-			 * domains.
-			 */
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
 
-				// DB8500_REGULATOR_VAPE
 				db8500_vape_reg: db8500_vape {
 					regulator-always-on;
 					power-domains = <&pm_domains DOMAIN_VAPE>;
 				};
 
-				// DB8500_REGULATOR_VARM
-				db8500_varm_reg: db8500_varm {
-				};
-
-				// DB8500_REGULATOR_VMODEM
-				db8500_vmodem_reg: db8500_vmodem {
-				};
-
-				// DB8500_REGULATOR_VPLL
-				db8500_vpll_reg: db8500_vpll {
-				};
-
-				// DB8500_REGULATOR_VSMPS1
-				db8500_vsmps1_reg: db8500_vsmps1 {
-				};
-
-				// DB8500_REGULATOR_VSMPS2
 				db8500_vsmps2_reg: db8500_vsmps2 {
 					power-domains = <&pm_domains DOMAIN_VSMPS2>;
 				};
-
-				// DB8500_REGULATOR_VSMPS3
-				db8500_vsmps3_reg: db8500_vsmps3 {
-				};
-
-				// DB8500_REGULATOR_VRF1
-				db8500_vrf1_reg: db8500_vrf1 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAMMDSP
-				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAMMDSPRET
-				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAPIPE
-				db8500_sva_pipe_reg: db8500_sva_pipe {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAMMDSP
-				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAMMDSPRET
-				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAPIPE
-				db8500_sia_pipe_reg: db8500_sia_pipe {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SGA
-				db8500_sga_reg: db8500_sga {
-					vin-supply = <&db8500_vape_reg>;
-				};
-
-				// DB8500_REGULATOR_SWITCH_B2R2_MCDE
-				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					vin-supply = <&db8500_vape_reg>;
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM12
-				db8500_esram12_reg: db8500_esram12 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM12RET
-				db8500_esram12_ret_reg: db8500_esram12_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM34
-				db8500_esram34_reg: db8500_esram34 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM34RET
-				db8500_esram34_ret_reg: db8500_esram34_ret {
-				};
 			};
 		};
 
@@ -1111,8 +1031,6 @@ msp0: msp@80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
@@ -1130,8 +1048,6 @@ msp1: msp@80124000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80124000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v1 */
@@ -1150,8 +1066,6 @@ msp2: msp@80117000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80117000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
@@ -1170,8 +1084,6 @@ msp3: msp@80125000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80125000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v2 */
@@ -1215,8 +1127,6 @@ gpu@a0300000 {
 			clocks = <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
 			clock-names = "bus", "core";
 			power-domains = <&pm_domains DOMAIN_SGA>;
-			/* TODO: delete and replace with power-domain handling */
-			mali-supply = <&db8500_sga_reg>;
 		};
 
 		mcde@a0350000 {
@@ -1224,8 +1134,6 @@ mcde@a0350000 {
 			reg = <0xa0350000 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-			/* TODO: delete and replace with power-domain handling */
-			epod-supply = <&db8500_b2r2_mcde_reg>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
 				 <&prcmu_clk PRCMU_PLLDSI>; /* HDMI clock */

-- 
2.54.0


