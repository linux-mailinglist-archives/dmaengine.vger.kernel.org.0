Return-Path: <dmaengine+bounces-5626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B7AE7D47
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB433B6236
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9602F2C6E;
	Wed, 25 Jun 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kl6FDDOG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3812E1735
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843417; cv=none; b=mztJSA6tMYgAodhf+SkpsAV/Euny70Q+CWKA22H8S/e9k+4K0xOnk5gZ1eEpAXcbdZcQCbB3UOW/W7OrzTczEafA4H09Qualk82UbvzWw+rmsvxHbvZ2JR1Yd+6H1mmBCGJn32WfC6MQN5HeAsG6oCws0P22huUyuF//8/JCY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843417; c=relaxed/simple;
	bh=b1L8T64hp6GAFH9idBAVVMlsB+uDom6OB0svksRrRtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGKEOoz4gii4rRbODkFheqz58ZnP6gBU+UOEet0bP5AVmd25TjVec5rz0Lh2Clhs2MoEzD0QpNhu7udKIeRS8idcrkn47ScjsxyXIJHgD+sldET/HhPXQDzol5hYR2ViQObsax/PpCVs7b7ssxHefz6w2TRxo8cDwqLTXiiI3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kl6FDDOG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so2468896a12.3
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843404; x=1751448204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj0/+b6JxMQ0DFvOT8IeOkRqFe6fOK9ZEY2KhBVS8oQ=;
        b=kl6FDDOGVnGwH8+xE9V+VNyJIsZCjY3NtNsOdSqtjZPa153/4XwO24V6d2PQYaD4Fh
         JrMrzxyJgoce5iJxR3HKCMZcE1XKQ2zumAIpfr4845KC9aPUyCQdwbsdqi21M7bZYszt
         P1ZxbLuRtta7L7LS2yvAJiyHyhN2G9UTbw5TOEMivzgzslLgRPJsIS+k5zLuJcuUjykg
         IyOvIYCkjQlHQFrd2KTENqPpayQCw4IUPPyJdA4evVZJnoGFbFqWeR5S6GGY2iGSp5ZH
         y3HuMKHyn0f+H5VRt3nCj/5EGoEIQWvHrevi07TGUFvHEH13otrwm3O6a1wK6gvy4B/T
         Pbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843404; x=1751448204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj0/+b6JxMQ0DFvOT8IeOkRqFe6fOK9ZEY2KhBVS8oQ=;
        b=L3FlFBhxso9OOdF+RCc/5YzXcBkCqEiMML0tDkCzn1xXJqU8eHs10PRLsKFJ2qKE0+
         SezqH150Q0+jTAAGjxPH+gBrmVqoZ/T2P++nmOu9/djYKEz68kmC02/qqELNKVCCYBlo
         11QX05HB9XJC8nSOqA9GGJLGXYh7fCIng08pwrAAmOYGYjYTt82u04UkspFk2Ui0BIB3
         2tzoYaqk5XvU4VaTAsnuws7vBfA7/5du+AOb2wVwjFeMMs980DuPRCrjY3z7BE0GvEx0
         a3NNJoZJNB3BIDI2NSd+YtHtCBsYq/j8RWoZzoLKxtDCsdcC4WiFpT0/0cJM3kLtqw0I
         tGhA==
X-Forwarded-Encrypted: i=1; AJvYcCUYXgxdJ00oSlKAllN/vzG6vPUg+5Sa6e1Ix7h/pINSijWtvAp8kB9BWUUmF8GqrIAwvOEY5CJpZxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0nJdynp4ouFX4+TB3OFxsTDadD+hQU4hd8SxIM196wFq29Ih
	FP0ZI5+PZTFSeQynxymhnqLKMpELNY4xYTyqMxV+/Ch5LjPnCorsH5bqrVb+fN+C9Pw=
X-Gm-Gg: ASbGncs/tBWSPWenFb3NiNjUndDrqDIiYhfWyDKK920iB4x8z029RUZ7RC82Kdpn4xs
	Dc23D8lyEyy61Oa8EDX1ddy1gKrgMbYOp+HWDi8CtF+2GSGAsuCIgKqORIEctrRyy72xE+M9YlA
	Dl7EqmQTkEsLZcBdJV2ZACNZHZvwl1/oKeP3mHffg3kCYbQk28Nz5oYceW5KFQhiUdV2VRScNc8
	PGCkX9ADWzVw7xF7Qcq1n9o+SL5v1e1U1MBp6RKuz49O13+Ov1+icfq5rKmjbHNmc0VuYyf7/SZ
	8H2CVGj0o3yHsemVMtUWQrH3reIs5NqkBvjo8AIqdkuDY6XCcb45yhPXRaWbbFa3AI5N6F2RTkh
	3C6WmMgWymy8L+whIWtCnWwdyXpAgtdL9mKVhmf1BDqE=
X-Google-Smtp-Source: AGHT+IFbStyu+dkT9cOjOdqNNy5J2sN8CjYyQ9O4MflTt+DtsG9Md6cICBfE0pHpwOnvfAgxWGxYyg==
X-Received: by 2002:a17:907:940d:b0:ae0:b7c7:e181 with SMTP id a640c23a62f3a-ae0beea8657mr227766966b.41.1750843403827;
        Wed, 25 Jun 2025 02:23:23 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:23 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:09 +0200
Subject: [PATCH 14/14] arm64: dts: qcom: Add The Fairphone (Gen. 6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-14-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=22034;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=b1L8T64hp6GAFH9idBAVVMlsB+uDom6OB0svksRrRtA=;
 b=6wEHmsKRLfFnwKu02OdfcHJvVK9QXGRgOWwPAr7b1FFxeIsI8uFOclBVLITGPRc51pgfVDOzJ
 HqrQ7RwE1EyAdixR9FhzQC4qs0mDjec7XrfgjGtWWzdQI/KfWMuZXJN
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
on the SM7635 SoC.

Supported functionality as of this initial submission:
* Debug UART
* Regulators (PM7550, PM8550VS, PMR735B, PM8008)
* Remoteprocs (ADSP, CDSP, MPSS, WPSS)
* Power Button, Volume Keys, Switch
* Display (using simple-framebuffer)
* PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
* Camera flash/torch LED
* SD card
* USB

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/Makefile                 |   1 +
 arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dts | 837 ++++++++++++++++++++++
 2 files changed, 838 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 669b888b27a1daa93ac15f47e8b9a302bb0922c2..c06c93a92fb9ce24aed9dee51c0907ab22903ac5 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -266,6 +266,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-nothing-spacewar.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm7635-fairphone-fp6.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dts
new file mode 100644
index 0000000000000000000000000000000000000000..d687e4e75f21afbe317093cd3b48030354411592
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dts
@@ -0,0 +1,837 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+/dts-v1/;
+
+#define PMIV0104_SID 7
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm7635.dtsi"
+#include "pm8550vs.dtsi"
+#include "pmiv0104.dtsi" /* PMIV0108 */
+#include "pmk8550.dtsi" /* PMK7635 */
+#include "pmr735b.dtsi"
+#include "pmxr2230.dtsi" /* PM7550 */
+
+/ {
+	model = "The Fairphone (Gen. 6)";
+	compatible = "fairphone,fp6", "qcom,sm7635";
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart5;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer0: framebuffer@e3940000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0xe3940000 0x0 (2484 * 1116 * 4)>;
+			width = <1116>;
+			height = <2484>;
+			stride = <(1116 * 4)>;
+			format = "a8r8g8b8";
+			panel = <&panel>;
+			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&volume_up_default>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&pmxr2230_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch {
+			label = "Switch";
+			gpios = <&tlmm 107 GPIO_ACTIVE_HIGH>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_MUTE_DEVICE>;
+		};
+	};
+
+	/* Dummy panel for simple-framebuffer dimension info */
+	panel: panel {
+		compatible = "boe,bj631jhm-t71-d900";
+		width-mm = <65>;
+		height-mm = <146>;
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm7635-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 131 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+			};
+		};
+	};
+
+	vreg_ff_afvdd_2p8: regulator-ff-afvdd-2p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ff_afvdd_2p8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 93 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
+	vreg_uw_afvdd_2p8: regulator-uw-afvdd-2p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "uw_afvdd_2p8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 23 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
+	vreg_uw_dvdd: regulator-uw-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "uw_dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_s1b>;
+	};
+
+	vreg_ois_avdd0_1p8: regulator-ois-avdd0-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ois_avdd0_1p8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
+	vreg_ois_vdd: regulator-ois-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ois_vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	vreg_oled_dvdd_1p2: regulator-oled-dvdd-1p2 {
+		compatible = "regulator-fixed";
+		regulator-name = "oled_dvdd_1p2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		gpio = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_s2b>;
+
+		regulator-boot-on;
+	};
+
+	vreg_s1j: regulator-pm3001a-s1j {
+		compatible = "regulator-fixed";
+		regulator-name = "pm3001a_s1j";
+		regulator-min-microvolt = <2200000>;
+		regulator-max-microvolt = <2200000>;
+		startup-delay-us = <1000>;
+
+		gpio = <&pmr735b_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vph_pwr>;
+
+		pinctrl-0 = <&s1j_enable_default>;
+		pinctrl-names = "default";
+	};
+
+	vreg_vtof_ldo_3p3: regulator-vtof-ldo-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtof_ldo_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 76 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		/*
+		 * ABL is powering down display and controller if this node is
+		 * not named exactly "splash_region".
+		 */
+		splash_region@e3940000 {
+			reg = <0x0 0xe3940000 0x0 0x2b00000>;
+			no-map;
+		};
+	};
+
+	thermal-zones {
+		pm8008-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pm8008>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm7550-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s1b>;
+		vdd-l2-l3-supply = <&vreg_s3b>;
+		vdd-l4-l5-supply = <&vreg_s2b>;
+		vdd-l6-supply = <&vreg_s2b>;
+		vdd-l7-supply = <&vreg_s1b>;
+		vdd-l8-supply = <&vreg_s1b>;
+		vdd-l9-l10-supply = <&vreg_s1b>;
+		vdd-l11-supply = <&vreg_s1b>;
+		vdd-l12-l14-supply = <&vreg_bob>;
+		vdd-l13-l16-supply = <&vreg_bob>;
+		vdd-l15-l17-l18-l19-l20-l21-l22-l23-supply = <&vreg_bob>;
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "b";
+
+		vreg_s1b: smps1 {
+			regulator-name = "vreg_s1b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2080000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2b: smps2 {
+			regulator-name = "vreg_s2b";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1408000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s3b: smps3 {
+			regulator-name = "vreg_s3b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <1040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b: ldo2 {
+			regulator-name = "vreg_l2b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3b: ldo3 {
+			regulator-name = "vreg_l3b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4b: ldo4 {
+			regulator-name = "vreg_l4b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b: ldo5 {
+			regulator-name = "vreg_l5b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b: ldo7 {
+			regulator-name = "vreg_l7b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b: ldo8 {
+			regulator-name = "vreg_l8b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b: ldo9 {
+			regulator-name = "vreg_l9b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10b: ldo10 {
+			regulator-name = "vreg_l10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b: ldo11 {
+			regulator-name = "vreg_l11b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b: ldo12 {
+			regulator-name = "vreg_l12b";
+			/*
+			 * Skip voltage voting for UFS VCC.
+			 */
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13b: ldo13 {
+			regulator-name = "vreg_l13b";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b: ldo14 {
+			regulator-name = "vreg_l14b";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b: ldo15 {
+			regulator-name = "vreg_l15b";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16b: ldo16 {
+			regulator-name = "vreg_l16b";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b: ldo17 {
+			regulator-name = "vreg_l17b";
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b: ldo18 {
+			regulator-name = "vreg_l18b";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l19b: ldo19 {
+			regulator-name = "vreg_l19b";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l20b: ldo20 {
+			regulator-name = "vreg_l20b";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l21b: ldo21 {
+			regulator-name = "vreg_l21b";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l22b: ldo22 {
+			regulator-name = "vreg_l22b";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l23b: ldo23 {
+			regulator-name = "vreg_l23b";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s3b>;
+		vdd-l3-supply = <&vreg_s3b>;
+
+		qcom,pmic-id = "c";
+
+		vreg_l2c: ldo2 {
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <650000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmr735b-rpmh-regulators";
+
+		vdd-l1-l2-supply= <&vreg_s3b>;
+		vdd-l3-supply= <&vreg_s3b>;
+		vdd-l4-supply= <&vreg_s1b>;
+		vdd-l5-supply= <&vreg_s2b>;
+		vdd-l6-supply= <&vreg_s2b>;
+		vdd-l7-l8-supply= <&vreg_s2b>;
+		vdd-l9-supply= <&vreg_s3b>;
+		vdd-l10-supply= <&vreg_s1b>;
+		vdd-l11-supply= <&vreg_s3b>;
+		vdd-l12-supply= <&vreg_s3b>;
+
+		qcom,pmic-id = "f";
+
+		vreg_l1f: ldo1 {
+			regulator-name = "vreg_l1f";
+			regulator-min-microvolt = <852000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f: ldo2 {
+			regulator-name = "vreg_l2f";
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f: ldo3 {
+			regulator-name = "vreg_l3f";
+			regulator-min-microvolt = <650000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f: ldo4 {
+			regulator-name = "vreg_l4f";
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5f: ldo5 {
+			regulator-name = "vreg_l5f";
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6f: ldo6 {
+			regulator-name = "vreg_l6f";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7f: ldo7 {
+			regulator-name = "vreg_l7f";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8f: ldo8 {
+			regulator-name = "vreg_l8f";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1320000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9f: ldo9 {
+			regulator-name = "vreg_l9f";
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <970000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10f: ldo10 {
+			regulator-name = "vreg_l10f";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11f: ldo11 {
+			regulator-name = "vreg_l11f";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <864000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&dispcc {
+	/* Disable for now so simple-framebuffer continues working */
+	status = "disabled";
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&i2c1 {
+	/* Samsung NFC @ 0x27 */
+
+	status = "okay";
+};
+
+&i2c3 {
+	/* AW88261FCR amplifier (top) @ 0x34 */
+	/* AW88261FCR amplifier (bottom) @ 0x35 */
+
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+
+	pm8008: pmic@8 {
+		compatible = "qcom,pm8008";
+		reg = <0x8>;
+
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_RISING>;
+		reset-gpios = <&pmr735b_gpios 3 GPIO_ACTIVE_LOW>;
+
+		vdd-l1-l2-supply = <&vreg_s2b>;
+		vdd-l3-l4-supply = <&vreg_bob>;
+		vdd-l5-supply = <&vreg_bob>;
+		vdd-l6-supply = <&vreg_s1b>;
+		vdd-l7-supply = <&vreg_bob>;
+
+		pinctrl-0 = <&pm8008_int_default>, <&pm8008_reset_n_default>;
+		pinctrl-names = "default";
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pm8008 0 0 2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		#thermal-sensor-cells = <0>;
+
+		regulators {
+			vreg_l1p: ldo1 {
+				regulator-name = "vreg_l1p";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vreg_l2p: ldo2 {
+				regulator-name = "vreg_l2p";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1144000>;
+			};
+
+			vreg_l3p: ldo3 {
+				regulator-name = "vreg_l3p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vreg_l4p: ldo4 {
+				regulator-name = "vreg_l4p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2900000>;
+			};
+
+			vreg_l5p: ldo5 {
+				regulator-name = "vreg_l5p";
+				regulator-min-microvolt = <2704000>;
+				regulator-max-microvolt = <2900000>;
+			};
+
+			vreg_l6p: ldo6 {
+				regulator-name = "vreg_l6p";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1896000>;
+			};
+
+			vreg_l7p: ldo7 {
+				regulator-name = "vreg_l7p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
+	};
+
+	/* VL53L3 ToF @ 0x29 */
+	/* AW86938FCR vibrator @ 0x5a */
+};
+
+&pm8550vs_d {
+	status = "disabled";
+};
+
+&pm8550vs_e {
+	status = "disabled";
+};
+
+&pm8550vs_g {
+	status = "disabled";
+};
+
+&pmiv0104_eusb2_repeater {
+	vdd18-supply = <&vreg_l7b>;
+	vdd3-supply = <&vreg_l17b>;
+
+	qcom,tune-res-fsdif = /bits/ 8 <0x5>;
+	qcom,tune-usb2-amplitude = /bits/ 8 <0x8>;
+	qcom,tune-usb2-disc-thres = /bits/ 8 <0x7>;
+	qcom,tune-usb2-preem = /bits/ 8 <0x6>;
+};
+
+&pmr735b_gpios {
+	pm8008_reset_n_default: pm8008-reset-n-default-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-down;
+	};
+
+	s1j_enable_default: s1j-enable-default-state {
+		pins = "gpio1";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <0>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&pmxr2230_gpios {
+	volume_up_default: volume-up-default-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <1>;
+		bias-pull-up;
+	};
+};
+
+&pmxr2230_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>, <4>;
+		led-max-microamp = <350000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <400000>;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sm7635/fairphone/fp6/adsp.mbn",
+			"qcom/sm7635/fairphone/fp6/adsp_dtb.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm7635/fairphone/fp6/cdsp.mbn",
+			"qcom/sm7635/fairphone/fp6/cdsp_dtb.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm7635/fairphone/fp6/modem.mbn";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/sm7635/fairphone/fp6/wpss.mbn";
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+
+	vmmc-supply = <&vreg_l13b>;
+	vqmmc-supply = <&vreg_l23b>;
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>, <&sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep>, <&sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&spi0 {
+	/* Eswin EPH8621 touchscreen @ 0 */
+};
+
+&tlmm {
+	/*
+	 * 8-11: Fingerprint SPI
+	 * 13: NC
+	 * 63-64: WLAN UART
+	 */
+	gpio-reserved-ranges = <8 4>, <13 1>, <63 2>;
+
+	pm8008_int_default: pm8008-int-default-state {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usb_1 {
+	dr_mode = "otg";
+
+	/* USB 2.0 only */
+	qcom,select-utmi-as-pipe-clk;
+
+	status = "okay";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l2b>;
+	vdda12-supply = <&vreg_l4b>;
+
+	phys = <&pmiv0104_eusb2_repeater>;
+
+	status = "okay";
+};

-- 
2.50.0


