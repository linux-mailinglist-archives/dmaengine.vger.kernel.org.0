Return-Path: <dmaengine+bounces-5627-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9EAE7D36
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903D816D87E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AF2F431F;
	Wed, 25 Jun 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="C04KKdZB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A81CCEE0
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843418; cv=none; b=CTFXWbf+7D37i0DYKwS1ZQaoR932WtUQvYa4HzO/CkZ9GrfqwrJYsAzYZnnTspfKpVewPfwWDXz2ZWP5X8OGU1WD0a/yZwr91K+nIg1+wrsBbIguLOa6b8T4jic6NyCk6aKR3Lzw7R1q9vqlEE/p/HJk3xZr5OKQbzDEDeCz7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843418; c=relaxed/simple;
	bh=d/c3UyUOA3x0NuGxzjRH0ALpLawY4s+fCPlQFFikjh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhQtrN85OaUlpwi2Xo9b5nBSulSngOUZx24QgPEY+z04y11hR4IrVqy5Pc2ObeilnFC5gkdO2+ichxzJlb2sAsQnYNuxONavBIJqEqntbKIowNIeu/FS1rrBMoTqH0YwcXly7PZ14mytht5vJAiEVRrtgvNi3LxRlFHbHRpA8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=C04KKdZB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so1532563a12.1
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843403; x=1751448203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBmD/PsoOz/asqSbux+4nW4cZM42fL85tfGtHYo7/qs=;
        b=C04KKdZBwC95QCLzl84JbvSt3Do5i3iz/X2OjYNyDg8CGQA+OTx7d5eAGiGBgtDrA1
         nNT2Dkacodl9nWea0cuJ1oVIL/kaXsQBLG6iY4MeiD2jP8JHmL5uQAB9PCjavk+Vzed2
         aymaI5Bh5kEPpPRqYsZ+eaUpBjyKQDKLBsf3wXx/mGXeu7QZyDiUlDdXZibEnn/kQWoD
         aAmT97EA3My88SM8ZsydkknvSs0W/7XLcWnC0tWoIqfAyuY+2OoYu+FBkWwZxs3FdoLL
         3row+if/D0IG9/zb9CcxOUazfJo0NeErBc1L1dwLz295ab2e6CYewQbBXKG5TVNdsBCM
         tIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843403; x=1751448203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBmD/PsoOz/asqSbux+4nW4cZM42fL85tfGtHYo7/qs=;
        b=l1mqwwR7aRiudtDus8XkEj9+ZECju/fC53kc3E37X0zLuioKQsjCi3aYI9HU1vRu9t
         MdC9bjP1Nn6NK4yE/jxXikoa4GIa8U3HrNiuyzx3SNxGdmiCpRRNF0kMOBpbWgVG36zq
         3Odx1RDf2jBqLj0L4FhEgNMvFseXhQWWUnZbA0Q1av90DLSKz2EtRHUF7+Bib+qNYwmk
         jeqLKr9qcjVdp6hJNLo9I5z2s5pADFTq5tcEo/3czmUPqIr+WIoVVIe98gMxnRDn3YNe
         zbtrmcUmL5Gkkous4ezGUX4CYq8BK2WCh6k3zqDFjXVhHoHfjjv0Sq40C1NlXCBM83Dk
         IutA==
X-Forwarded-Encrypted: i=1; AJvYcCX5YIW3X+aWDa2fM6T0oqASfF1LePWtXEelFmyGydUqWaPq+THjUNg8L6Ool9Pg9BNlV9D0dsPhXdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSZGwy4f73xPyoQL9NCZ/L+KdvqkNqfO3zPan0IWj2u1zj+t7
	0qTGMOCu6HVRdzQV7SbfT1uWUyuRMDzOJ/m/eX625sjMaGYDZxAvWaF6RnGyXIwX/vaWaBdvn+I
	79Ogc
X-Gm-Gg: ASbGnctjw+kR8erYz7NL9FlfS91hRZTtbb5phSym7GVVnDqexzqUEtJBecmsRGMRF5c
	DuXI5v7ZbZR+PiQ/VZYR1pi/GAn57TqHmQFi0mF08sqRGFwMGZ2qvQ5+VvflQXUV4K8Pq4PRzKp
	Xj2iDFx0AlYYswUvvAeU/eciRz9LOe3ucNAB+YS9QC8W1zuFYAD/e92rW4oxBA7oVWmh2fo6xwc
	6MPVb/6Kg5d8xQ2CdUDkS3wnqp7R0KwC4qsQnCSE6NYbf2ddcVobtAkQPshko8r9QQcdsMNIg92
	lmci/RMKiSioQmD5dtJcJqjT10sAEsvHOOPAPgXPtFQ+Hd/RsSp++5rqK0bu5CdWTz9p68nk63N
	ATyOTg17Fr53bPDp0ldTzCkWn0G5LO+oaHjM2jr0vn2E=
X-Google-Smtp-Source: AGHT+IGuFm/leCcGVK7r6HezNtgvL1TWgJrtV/rVAk6j5FFH1iK3Y48fnUbAhUh3SFu/yXE8ngEA1A==
X-Received: by 2002:a17:907:d94:b0:ade:31bf:611c with SMTP id a640c23a62f3a-ae0c069550amr178885166b.9.1750843402807;
        Wed, 25 Jun 2025 02:23:22 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:22 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:08 +0200
Subject: [PATCH 13/14] arm64: dts: qcom: Add initial SM7635 dtsi
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-13-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=70138;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=d/c3UyUOA3x0NuGxzjRH0ALpLawY4s+fCPlQFFikjh8=;
 b=/1bACx/QwKk1F451Nv7aAHXbW8B9lqEsqPdFijsjplERTO6KBQS2pN9XG05GeTvTFbXlMKiYW
 pOU+y7uavxpDduww62iQd71YuOgGWkKzlZbxn2AhlwVNKB6OAbPsWRk
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a devicetree description for the Snapdragon 7s Gen 3 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7635.dtsi | 2806 ++++++++++++++++++++++++++++++++++
 1 file changed, 2806 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7635.dtsi b/arch/arm64/boot/dts/qcom/sm7635.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e6a2943c372bfcf05e06c98ee852afaccb95b3db
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7635.dtsi
@@ -0,0 +1,2806 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm7635-camcc.h>
+#include <dt-bindings/clock/qcom,sm7635-dispcc.h>
+#include <dt-bindings/clock/qcom,sm7635-gcc.h>
+#include <dt-bindings/clock/qcom,sm7635-gpucc.h>
+#include <dt-bindings/clock/qcom,sm8650-tcsr.h>
+#include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,sm7635-rpmh.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <76800000>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x0 0x0>;
+
+			clocks = <&cpufreq_hw 0>;
+
+			power-domains = <&cpu_pd0>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+
+			qcom,freq-domain = <&cpufreq_hw 0>;
+
+			#cooling-cells = <2>;
+
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+
+				l3_0: l3-cache {
+					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
+				};
+			};
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x0 0x100>;
+
+			clocks = <&cpufreq_hw 0>;
+
+			power-domains = <&cpu_pd1>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+
+			qcom,freq-domain = <&cpufreq_hw 0>;
+
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x0 0x200>;
+
+			clocks = <&cpufreq_hw 0>;
+
+			power-domains = <&cpu_pd2>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+
+			qcom,freq-domain = <&cpufreq_hw 0>;
+
+			#cooling-cells = <2>;
+
+			l2_2: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x0 0x300>;
+
+			clocks = <&cpufreq_hw 0>;
+
+			power-domains = <&cpu_pd3>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+
+			qcom,freq-domain = <&cpufreq_hw 0>;
+
+			#cooling-cells = <2>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a720";
+			reg = <0x0 0x400>;
+
+			clocks = <&cpufreq_hw 1>;
+
+			power-domains = <&cpu_pd4>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_4>;
+			capacity-dmips-mhz = <1670>;
+			dynamic-power-coefficient = <264>;
+
+			qcom,freq-domain = <&cpufreq_hw 1>;
+
+			#cooling-cells = <2>;
+
+			l2_4: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a720";
+			reg = <0x0 0x500>;
+
+			clocks = <&cpufreq_hw 1>;
+
+			power-domains = <&cpu_pd5>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_5>;
+			capacity-dmips-mhz = <1670>;
+			dynamic-power-coefficient = <264>;
+
+			qcom,freq-domain = <&cpufreq_hw 1>;
+
+			#cooling-cells = <2>;
+
+			l2_5: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a720";
+			reg = <0x0 0x600>;
+
+			clocks = <&cpufreq_hw 1>;
+
+			power-domains = <&cpu_pd6>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_6>;
+			capacity-dmips-mhz = <1670>;
+			dynamic-power-coefficient = <264>;
+
+			qcom,freq-domain = <&cpufreq_hw 1>;
+
+			#cooling-cells = <2>;
+
+			l2_6: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a720";
+			reg = <0x0 0x700>;
+
+			clocks = <&cpufreq_hw 2>;
+
+			power-domains = <&cpu_pd7>;
+			power-domain-names = "psci";
+
+			enable-method = "psci";
+			next-level-cache = <&l2_7>;
+			capacity-dmips-mhz = <1670>;
+			dynamic-power-coefficient = <287>;
+
+			qcom,freq-domain = <&cpufreq_hw 2>;
+
+			#cooling-cells = <2>;
+
+			l2_7: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			silver_cpu_sleep_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "pc";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <250>;
+				exit-latency-us = <700>;
+				min-residency-us = <5200>;
+				local-timer-stop;
+			};
+
+			silver_cpu_sleep_1: cpu-sleep-0-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <550>;
+				exit-latency-us = <750>;
+				min-residency-us = <6700>;
+				local-timer-stop;
+			};
+
+			gold_cpu_sleep_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <5511>;
+				local-timer-stop;
+			};
+
+			gold_cpu_sleep_1: cpu-sleep-1-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <600>;
+				exit-latency-us = <1300>;
+				min-residency-us = <8136>;
+				local-timer-stop;
+			};
+
+			gold_plus_cpu_sleep_0: cpu-sleep-2-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-plus-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <600>;
+				exit-latency-us = <1500>;
+				min-residency-us = <8551>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			cluster_sleep_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <750>;
+				exit-latency-us = <2350>;
+				min-residency-us = <9144>;
+			};
+
+			cluster_sleep_1: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41003344>;
+				entry-latency-us = <2800>;
+				exit-latency-us = <4400>;
+				min-residency-us = <10150>;
+			};
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-sm7635", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x19000>;
+		};
+	};
+
+	clk_virt: interconnect-0 {
+		compatible = "qcom,sm7635-clk-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	mc_virt: interconnect-1 {
+		compatible = "qcom,sm7635-mc-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0 0 0>;
+	};
+
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		cpu_pd0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&silver_cpu_sleep_0>, <&silver_cpu_sleep_1>;
+		};
+
+		cpu_pd1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&silver_cpu_sleep_0>, <&silver_cpu_sleep_1>;
+		};
+
+		cpu_pd2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&silver_cpu_sleep_0>, <&silver_cpu_sleep_1>;
+		};
+
+		cpu_pd3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&silver_cpu_sleep_0>, <&silver_cpu_sleep_1>;
+		};
+
+		cpu_pd4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>, <&gold_cpu_sleep_1>;
+		};
+
+		cpu_pd5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>, <&gold_cpu_sleep_1>;
+		};
+
+		cpu_pd6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>, <&gold_cpu_sleep_1>;
+		};
+
+		cpu_pd7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_plus_cpu_sleep_0>;
+		};
+
+		cluster_pd: power-domain-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_sleep_0>, <&cluster_sleep_1>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gunyah_hyp_mem: gunyah-hyp-region@80000000 {
+			reg = <0x0 0x80000000 0x0 0xe00000>;
+			no-map;
+		};
+
+		xbl_sc_mem: xbl-sc-region@81800000 {
+			reg = <0x0 0x81800000 0x0 0x40000>;
+			no-map;
+		};
+
+		cpucp_fw_mem: cpucp-fw-region@81840000 {
+			reg = <0x0 0x81840000 0x0 0x1c0000>;
+			no-map;
+		};
+
+		xbl_dtlog_mem: xbl-dtlog-region@81a00000 {
+			reg = <0x0 0x81a00000 0x0 0x40000>;
+			no-map;
+		};
+
+		xbl_ramdump_mem: xbl-ramdump-region@81a40000 {
+			reg = <0x0 0x81a40000 0x0 0x1c0000>;
+			no-map;
+		};
+
+		aop_image_mem: aop-image-region@81c00000 {
+			reg = <0x0 0x81c00000 0x0 0x60000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x81c60000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_config_mem: aop-config-region@81c80000 {
+			reg = <0x0 0x81c80000 0x0 0x20000>;
+			no-map;
+		};
+
+		tme_crash_dump_mem: tme-crash-dump-region@81ca0000 {
+			reg = <0x0 0x81ca0000 0x0 0x40000>;
+			no-map;
+		};
+
+		tme_log_mem: tme-log-region@81ce0000 {
+			reg = <0x0 0x81ce0000 0x0 0x4000>;
+			no-map;
+		};
+
+		uefi_log_mem: uefi-log-region@81ce4000 {
+			reg = <0x0 0x81ce4000 0x0 0x10000>;
+			no-map;
+		};
+
+		chipinfo_mem: chipinfo-region@81cf4000 {
+			reg = <0x0 0x81cf4000 0x0 0x1000>;
+			no-map;
+		};
+
+		secdata_apss_mem: secdata-apss-region@81cff000 {
+			reg = <0x0 0x81cff000 0x0 0x1000>;
+			no-map;
+		};
+
+		smem_mem: smem-region@81d00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x81d00000 0x0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+		adsp_mhi_mem: adsp-mhi-region@81f00000 {
+			reg = <0x0 0x81f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		pvm_fw_mem: pvm-fw-region@824a0000 {
+			reg = <0x0 0x824a0000 0x0 0x100000>;
+			no-map;
+		};
+
+		hyp_mem_database_mem: hyp-mem-database-region@825a0000 {
+			reg = <0x0 0x825a0000 0x0 0x60000>;
+			no-map;
+		};
+
+		global_sync_mem: global-sync-region@82600000 {
+			reg = <0x0 0x82600000 0x0 0x100000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat-region@82700000 {
+			reg = <0x0 0x82700000 0x0 0x100000>;
+			no-map;
+		};
+
+		qdss_apps_mem: qdss-apps-region@82800000 {
+			reg = <0x0 0x82800000 0x0 0x2000000>;
+			reusable;
+		};
+
+		mpss_mem: mpss-region@8ac00000 {
+			reg = <0x0 0x8ac00000 0x0 0xe600000>;
+			no-map;
+		};
+
+		q6_mpss_dtb_mem: q6-mpss-dtb-region@99200000 {
+			reg = <0x0 0x99200000 0x0 0x80000>;
+			no-map;
+		};
+
+		q6_adsp_dtb_mem: q6-adsp-dtb-region@99280000 {
+			reg = <0x0 0x99280000 0x0 0x80000>;
+			no-map;
+		};
+
+		adspslpi_mem: adspslpi-region@99300000 {
+			reg = <0x0 0x99300000 0x0 0x2800000>;
+			no-map;
+		};
+
+		wpss_mem: wpss-region@9bb00000 {
+			reg = <0x0 0x9bb00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		video_mem: video-region@9d400000 {
+			reg = <0x0 0x9d400000 0x0 0x700000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp-region@9db00000 {
+			reg = <0x0 0x9db00000 0x0 0xf00000>;
+			no-map;
+		};
+
+		q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9ea00000 {
+			reg = <0x0 0x9ea00000 0x0 0x80000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw-region@9ea80000 {
+			reg = <0x0 0x9ea80000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi-region@9ea90000 {
+			reg = <0x0 0x9ea90000 0x0 0xa000>;
+			no-map;
+		};
+
+		gpu_microcode_mem: gpu-microcode-region@9ea9a000 {
+			reg = <0x0 0x9ea9a000 0x0 0x2000>;
+			no-map;
+		};
+
+		camera_mem: camera-region@9eb00000 {
+			reg = <0x0 0x9eb00000 0x0 0x800000>;
+			no-map;
+		};
+
+		wlan_msa_mem: wlan-msa-region@a6400000 {
+			reg = <0x0 0xa6400000 0x0 0xc00000>;
+			no-map;
+		};
+
+		cpusys_vm_mem: cpusys-vm-region@e0600000 {
+			reg = <0x0 0xe0600000 0x0 0x400000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs@e1f00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xe1f00000 0x0 0x600000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
+		};
+
+		qtee_mem: qtee-region@e8900000 {
+			reg = <0x0 0xe8900000 0x0 0x500000>;
+			no-map;
+		};
+
+		tags_mem: tags-region@e8e00000 {
+			reg = <0x0 0xe8e00000 0x0 0x700000>;
+			no-map;
+		};
+
+		trusted_apps_mem: trusted-apps-region@e9500000 {
+			reg = <0x0 0xe9500000 0x0 0x1200000>;
+			no-map;
+		};
+	};
+
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_LPASS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_MPSS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		smp2p_modem_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_modem_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		smp2p_ipa_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_ipa_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-wpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_WPSS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <13>;
+
+		smp2p_wpss_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_wpss_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		smp2p_wlan_out: wlan-ap-to-wpss {
+			qcom,entry-name = "wlan";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_wlan_in: wlan-wpss-to-ap {
+			qcom,entry-name = "wlan";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges = <0 0 0 0 0x10 0>;
+		ranges = <0 0 0 0 0x10 0>;
+
+		gcc: clock-controller@100000 {
+			compatible = "qcom,sm7635-gcc";
+			reg = <0x0 0x00100000 0x0 0x1f4200>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>,
+				 <0>, /* pcie_0_pipe_clk */
+				 <0>, /* pcie_1_pipe_clk */
+				 <0>, /* ufs_phy_rx_symbol_0_clk */
+				 <0>, /* ufs_phy_rx_symbol_1_clk */
+				 <0>, /* ufs_phy_tx_symbol_0_clk */
+				 <0>; /* usb3_phy_wrapper_gcc_usb30_pipe_clk */
+			protected-clocks = <GCC_PCIE_1_AUX_CLK>, <GCC_PCIE_1_AUX_CLK_SRC>,
+					<GCC_PCIE_1_CFG_AHB_CLK>, <GCC_PCIE_1_MSTR_AXI_CLK>,
+					<GCC_PCIE_1_PHY_RCHNG_CLK>, <GCC_PCIE_1_PHY_RCHNG_CLK_SRC>,
+					<GCC_PCIE_1_PIPE_CLK>, <GCC_PCIE_1_PIPE_CLK_SRC>,
+					<GCC_PCIE_1_PIPE_DIV2_CLK>, <GCC_PCIE_1_PIPE_DIV2_CLK_SRC>,
+					<GCC_PCIE_1_SLV_AXI_CLK>, <GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		ipcc: mailbox@405000 {
+			compatible = "qcom,sm7635-ipcc", "qcom,ipcc";
+			reg = <0x0 0x00405000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			#mbox-cells = <2>;
+		};
+
+		gpi_dma1: dma-controller@800000 {
+			compatible = "qcom,sm7635-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x0 0x00800000 0x0 0x60000>;
+
+			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-channels = <12>;
+			dma-channel-mask = <0x3f>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0x36 0x0>;
+			dma-coherent;
+
+			status = "disabled";
+		};
+
+		qupv3_id_1: geniqup@8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x008c0000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			clock-names = "m-ahb",
+				      "s-ahb";
+
+			interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
+					 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qup-core";
+
+			iommus = <&apps_smmu 0x23 0>;
+
+			dma-coherent;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			i2c7: i2c@880000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00880000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc_cfg SLAVE_QUP_1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+						<&aggre1_noc MASTER_QUP_1 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
+				pinctrl-0 = <&qup_i2c7_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart11: serial@890000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x00890000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc_cfg SLAVE_QUP_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart11_default>, <&qup_uart11_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+		};
+
+		gpi_dma0: dma-controller@a00000 {
+			compatible = "qcom,sm7635-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x0 0x00a00000 0x0 0x60000>;
+
+			interrupts = <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-channels = <12>;
+			dma-channel-mask = <0x3e>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0x576 0x0>;
+			dma-coherent;
+
+			status = "disabled";
+		};
+
+		qupv3_id_0: geniqup@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x00ac0000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb",
+				      "s-ahb";
+
+			interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+					 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qup-core";
+
+			iommus = <&apps_smmu 0x563 0>;
+
+			dma-coherent;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			spi0: spi@a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a80000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc_cfg SLAVE_QUP_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+						<&aggre2_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
+				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			i2c1: i2c@a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a84000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc_cfg SLAVE_QUP_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+						<&aggre2_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
+				pinctrl-0 = <&qup_i2c1_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			i2c3: i2c@a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a8c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc_cfg SLAVE_QUP_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+						<&aggre2_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
+				pinctrl-0 = <&qup_i2c3_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart5: serial@a94000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x00a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc_cfg SLAVE_QUP_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart5_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+		};
+
+		rng: rng@10c3000 {
+			compatible = "qcom,sm7635-trng", "qcom,trng";
+			reg = <0x0 0x010c3000 0x0 0x1000>;
+		};
+
+		mmss_noc: interconnect@1400000 {
+			compatible = "qcom,sm7635-mmss-noc";
+			reg = <0x0 0x01400000 0x0 0xdb800>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		cnoc_main: interconnect@1500000 {
+			compatible = "qcom,sm7635-cnoc-main";
+			reg = <0x0 0x01500000 0x0 0x14400>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		cnoc_cfg: interconnect@1600000 {
+			compatible = "qcom,sm7635-cnoc-cfg";
+			reg = <0x0 0x01600000 0x0 0x6e00>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1680000 {
+			compatible = "qcom,sm7635-system-noc";
+			reg = <0x0 0x01680000 0x0 0x40000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pcie_anoc: interconnect@16c0000 {
+			compatible = "qcom,sm7635-pcie-anoc";
+			reg = <0x0 0x016c0000 0x0 0x12400>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm7635-aggre1-noc";
+			reg = <0x0 0x016e0000 0x0 0x16400>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm7635-aggre2-noc";
+			reg = <0x0 0x01700000 0x0 0x1f400>;
+			#interconnect-cells = <2>;
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x01f40000 0x0 0x20000>;
+
+			#hwlock-cells = <1>;
+		};
+
+		tcsr: clock-controller@1fc0000 {
+			compatible = "qcom,sm7635-tcsr", "syscon";
+			reg = <0x0 0x01fc0000 0x0 0xa0000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		remoteproc_adsp: remoteproc@3000000 {
+			compatible = "qcom,sm7635-adsp-pas";
+			reg = <0x0 0x03000000 0x0 0x10000>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx",
+					     "lmx";
+
+			interconnects = <&lpass_ag_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
+		lpass_ag_noc: interconnect@3c40000 {
+			compatible = "qcom,sm7635-lpass-ag-noc";
+			reg = <0x0 0x03c40000 0x0 0x17200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sm7635-gpucc";
+			reg = <0x0 0x03d90000 0x0 0x9800>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,sm7635-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sm7635-mpss-pas";
+			reg = <0x0 0x04080000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
+			power-domain-names = "cx",
+					     "mss";
+
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&mpss_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_modem_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_MPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "mpss";
+				qcom,remote-pid = <1>;
+			};
+		};
+
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,sm7635-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x08804000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc_cfg SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			iommus = <&apps_smmu 0x540 0>;
+
+			bus-width = <4>;
+
+			qcom,dll-config = <0x0007442c>;
+			qcom,ddr-config = <0x80040868>;
+
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
+		usb_1_hsphy: phy@88e3000 {
+			compatible = "qcom,sm7635-snps-eusb2-phy",
+				     "qcom,sm8550-snps-eusb2-phy";
+			reg = <0x0 0x088e3000 0x0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			status = "disabled";
+		};
+
+		remoteproc_wpss: remoteproc@8a00000 {
+			compatible = "qcom,sm7635-wpss-pas";
+			reg = <0x0 0x08a00000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 579 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wpss_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wpss_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wpss_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wpss_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wpss_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
+			power-domain-names = "cx",
+					     "mx";
+
+			memory-region = <&wpss_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_wpss_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_WPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "wpss";
+				qcom,remote-pid = <13>;
+			};
+		};
+
+		usb_1: usb@a600000 {
+			compatible = "qcom,sm7635-dwc3", "qcom,snps-dwc3";
+			reg = <0x0 0x0a600000 0x0 0x10000>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <133333333>;
+
+			interrupts-extended = <&intc GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 25 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			iommus = <&apps_smmu 0x40 0x0>;
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			interconnects = <&aggre1_noc MASTER_USB3_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc_cfg SLAVE_USB3_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			phys = <&usb_1_hsphy>;
+			phy-names = "usb2-phy";
+
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,has-lpm-erratum;
+			snps,hird-threshold = /bits/ 8 <0x0>;
+			snps,is-utmi-l1-suspend;
+			snps,parkmode-disable-ss-quirk;
+			tx-fifo-resize;
+			dma-coherent;
+			usb-role-switch;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_dwc3_hs: endpoint {
+					};
+				};
+			};
+		};
+
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm7635-videocc";
+			reg = <0x0 0x0aaf0000 0x0 0x10000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>,
+				 <&gcc GCC_VIDEO_AHB_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		camcc: clock-controller@adb0000 {
+			compatible = "qcom,sm7635-camcc";
+			reg = <0x0 0x0adb0000 0x0 0x40000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>,
+				 <&gcc GCC_CAMERA_AHB_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sm7635-dispcc";
+			reg = <0x0 0x0af00000 0x0 0x20000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>,
+				 <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
+				 <0>, /* dsi0_phy_pll_out_byteclk */
+				 <0>, /* dsi0_phy_pll_out_dsiclk */
+				 <0>, /* dp0_phy_pll_link_clk */
+				 <0>; /* dp0_phy_pll_vco_div_clk */
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sm7635-pdc", "qcom,pdc";
+			reg = <0x0 0x0b220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
+			interrupt-parent = <&intc>;
+
+			qcom,pdc-ranges = <0 480 40>, <40 140 11>, <51 527 47>,
+					  <98 609 31>, <129 63 1>, <130 716 12>,
+					  <142 251 5>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		tsens0: thermal-sensor@c228000 {
+			compatible = "qcom,sm7635-tsens", "qcom,tsens-v2";
+			reg = <0x0 0x0c228000 0x0 0x1ff>, /* TM */
+			      <0x0 0x0c222000 0x0 0x1ff>; /* SROT */
+
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <15>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c229000 {
+			compatible = "qcom,sm7635-tsens", "qcom,tsens-v2";
+			reg = <0x0 0x0c229000 0x0 0x1ff>, /* TM */
+			      <0x0 0x0c223000 0x0 0x1ff>; /* SROT */
+
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <14>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,sm7635-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0x0 0x0c300000 0x0 0x400>;
+
+			interrupt-parent = <&ipcc>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0x0 0x0c3f0000 0x0 0x400>;
+		};
+
+		spmi_bus: spmi@c400000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0 0x0c400000 0x0 0x3000>,
+			      <0x0 0x0c500000 0x0 0x400000>,
+			      <0x0 0x0c440000 0x0 0x80000>,
+			      <0x0 0x0c4c0000 0x0 0x10000>,
+			      <0x0 0x0c42d000 0x0 0x4000>;
+			reg-names = "core",
+				    "chnls",
+				    "obsrvr",
+				    "intr",
+				    "cnfg";
+
+			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "periph_irq";
+
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			qcom,bus-id = <0>;
+
+			interrupt-controller;
+			#interrupt-cells = <4>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,sm7635-tlmm";
+			reg = <0x0 0x0f100000 0x0 0x300000>;
+
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			gpio-ranges = <&tlmm 0 0 168>;
+
+			wakeup-parent = <&pdc>;
+
+			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio4", "gpio5";
+				function = "qup0_se1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio15", "gpio16";
+				function = "qup0_se3";
+				drive-strength = <2>;
+				bias-pull-up = <2200>;
+			};
+
+			qup_i2c7_data_clk: qup-i2c7-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio32", "gpio33";
+				function = "qup1_se0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_cs: qup-spi0-cs-state {
+				pins = "gpio3";
+				function = "qup0_se0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi0_data_clk: qup-spi0-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio0", "gpio1", "gpio2";
+				function = "qup0_se0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_uart5_default: qup-uart5-default-state {
+				/* TX, RX */
+				pins = "gpio25", "gpio26";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart11_default: qup-uart11-default-state {
+				/* TX, RX */
+				pins = "gpio50", "gpio51";
+				function = "qup1_se4";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart11_cts_rts: qup-uart11-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio48", "gpio49";
+				function = "qup1_se4";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			sdc2_default: sdc2-default-state {
+				clk-pins {
+					pins = "gpio62";
+					function = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "gpio61";
+					function = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "gpio58", "gpio57", "gpio35", "gpio34";
+					function = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep: sdc2-sleep-state {
+				clk-pins {
+					pins = "gpio62";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "gpio61";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "gpio58", "gpio57", "gpio35", "gpio34";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+		};
+
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sm7635-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x15000000 0x0 0x100000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+		};
+
+		intc: interrupt-controller@17100000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x17100000 0x0 0x10000>,	/* GICD */
+			      <0x0 0x17180000 0x0 0x200000>;	/* GICR * 8 */
+
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			#interrupt-cells = <3>;
+			interrupt-controller;
+
+			#redistributor-regions = <1>;
+			redistributor-stride = <0 0x40000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gic_its: msi-controller@17140000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x17140000 0x0 0x20000>;
+
+				msi-controller;
+				#msi-cells = <1>;
+			};
+		};
+
+		timer@17420000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x17420000 0x0 0x1000>;
+
+			ranges = <0 0 0 0x20000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			frame@17421000 {
+				reg = <0x17421000 0x1000>,
+				      <0x17422000 0x1000>;
+
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <0>;
+			};
+
+			frame@17423000 {
+				reg = <0x17423000 0x1000>;
+
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <1>;
+
+				status = "disabled";
+			};
+
+			frame@17425000 {
+				reg = <0x17425000 0x1000>;
+
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <2>;
+
+				status = "disabled";
+			};
+
+			frame@17427000 {
+				reg = <0x17427000 0x1000>;
+
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <3>;
+
+				status = "disabled";
+			};
+
+			frame@17429000 {
+				reg = <0x17429000 0x1000>;
+
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <4>;
+
+				status = "disabled";
+			};
+
+			frame@1742b000 {
+				reg = <0x1742b000 0x1000>;
+
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <5>;
+
+				status = "disabled";
+			};
+
+			frame@1742d000 {
+				reg = <0x1742d000 0x1000>;
+
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <6>;
+
+				status = "disabled";
+			};
+		};
+
+		apps_rsc: rsc@17a00000 {
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x0 0x17a00000 0x0 0x10000>,
+			      <0x0 0x17a10000 0x0 0x10000>,
+			      <0x0 0x17a20000 0x0 0x10000>;
+			reg-names = "drv-0",
+				    "drv-1",
+				    "drv-2";
+
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&cluster_pd>;
+
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS    3>, <SLEEP_TCS     2>,
+					  <WAKE_TCS      2>, <CONTROL_TCS   0>;
+
+			label = "apps_rsc";
+
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
+			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sm7635-rpmh-clk";
+
+				clocks = <&xo_board>;
+				clock-names = "xo";
+
+				#clock-cells = <1>;
+			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sm7635-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp-16 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_low_svs_d1: opp-56 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					};
+
+					rpmhpd_opp_low_svs: opp-64 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp-128 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp-192 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp-256 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp-320 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_turbo: opp-384 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp-416 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+		};
+
+		cpufreq_hw: cpufreq@17d91000 {
+			compatible = "qcom,sm7635-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0x0 0x17d91000 0x0 0x1000>,
+			      <0x0 0x17d92000 0x0 0x1000>,
+			      <0x0 0x17d93000 0x0 0x1000>;
+			reg-names = "freq-domain0",
+				    "freq-domain1",
+				    "freq-domain2";
+
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1",
+					  "dcvsh-irq-2";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
+
+		gem_noc: interconnect@24100000 {
+			compatible = "qcom,sm7635-gem-noc";
+			reg = <0x0 0x24100000 0x0 0xff080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		nsp_noc: interconnect@320c0000 {
+			compatible = "qcom,sm7635-nsp-noc";
+			reg = <0x0 0x320c0000 0x0 0xe080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		remoteproc_cdsp: remoteproc@32300000 {
+			compatible = "qcom,sm7635-cdsp-pas";
+			reg = <0x0 0x32300000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
+			power-domain-names = "cx",
+					     "mx";
+
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+			};
+		};
+	};
+
+	thermal-zones {
+		aoss0-thermal {
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				aoss0-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				aoss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss0-thermal {
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				cpuss0-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				cpuss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss1-thermal {
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				cpuss1-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				cpuss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu4-left-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4-left-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu4-right-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4-right-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu5-left-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5-left-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu5-right-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5-right-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu6-left-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6-left-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu6-right-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6-right-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu7-left-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7-left-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu7-right-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7-right-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu0-thermal {
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 13>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens0 14>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss1-thermal {
+			thermal-sensors = <&tsens1 0>;
+
+			trips {
+				aoss1-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				aoss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphvx0-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				nsphvx0-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				nsphvx0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphmx1-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				nsphmx1-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				nsphmx1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphmx0-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				nsphmx0-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				nsphmx0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss0-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				gpu0_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				gpuss0-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss1-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens1 5>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				gpuss1-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-thermal {
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				video-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				video-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr-thermal {
+			polling-delay-passive = <10>;
+
+			thermal-sensors = <&tsens1 8>;
+
+			trips {
+				ddr-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				ddr-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera0-thermal {
+			thermal-sensors = <&tsens1 9>;
+
+			trips {
+				camera0-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				camera0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		modem0-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&tsens1 10>;
+
+			trips {
+				modem0-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				modem0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		modem1-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&tsens1 11>;
+
+			trips {
+				modem1-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				modem1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		modem2-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&tsens1 12>;
+
+			trips {
+				modem2-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				modem2-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		modem3-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&tsens1 13>;
+
+			trips {
+				modem3-hot {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				modem3-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+	};
+};

-- 
2.50.0


