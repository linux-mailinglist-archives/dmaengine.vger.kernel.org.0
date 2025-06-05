Return-Path: <dmaengine+bounces-5306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADAACEB4A
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 09:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CFB170FE9
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 07:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2821FFC46;
	Thu,  5 Jun 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLKV2zKC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE77205AB2;
	Thu,  5 Jun 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110137; cv=none; b=dkRKKMdZQ/YMQehTfbBz0I8lxYJ8cVhrlmSIB6iwhVvBoOQ5J+nneDBeQGPnizFOlCTi9xeE9GCBOVjO3ccvf0iJQEwb5PRFyVWStyrZrRgR7bsWCwUWFNvpoTgPEs7JDKAfxaL6XhafJiP2W9TDH5IC0D/CTw/VRVNh7BKNM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110137; c=relaxed/simple;
	bh=X0y//244IcVVvTsWhfk0S4rqcPTMLP52+OwILkbFL8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1BsfCAaxmYw8SVairfKUDwZaZbCnBu9SHeBGhKtHbjT2vT09krGQMdB92i6kREej/vUPkxFu4q4jkCblzZzTXkTi6ALp1fagurVtWLLE5B6mlIZdrh/MhsO/yaRfaDRzUVa/p9+cqBSXFo3qEv4DVWA1TcwtvZh43kATpN6rzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLKV2zKC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231e8553248so7039095ad.1;
        Thu, 05 Jun 2025 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749110135; x=1749714935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anP5W6fw320yDkAAyVm5897/IbGfmYVQQj7SpOyp4mo=;
        b=JLKV2zKCn9Nc5pc0vMJDq9L8cXtdOMVLrQMtcGEGpVCTb3w5Ccy/0cO6Si4Q+nY84j
         Wl1EZ1KbIYDjQAyXDK7GNsEZDgrOvifhwYbyi8AwmhbzGdZdJpAwfkDPORXOSY90vZXW
         0J0BSMH7YUIKrKSsCdzstGWEoDafWb40eip0oNSlIze5YTZwTklqf4zwwi+WC0tembbL
         X0G7j/AZd64LKgPajvmLdq3guHaFVhaDCXeGA4MR7jVgTErIYS0zWaXUJQTl0OX4Pjgy
         NSMckLCDK9PlY5XXQpq9nRjG5tL/gcVGAYzugm5+GAi41F0C8J7F2864DldAH5PKYQ6l
         H2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110135; x=1749714935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anP5W6fw320yDkAAyVm5897/IbGfmYVQQj7SpOyp4mo=;
        b=GFUo+Uf8gQCDWbrP+2GS0Fpq8tqNfCInMfU9I1cpMw63xzbWosBRz6aoL0WxkiQPOp
         8RT9FCOcqoYsEVa1UiK6xGICtEMcsdsyK1eQD/z8+6LjLW9WvoHtLwk+C8t6mPfviHaY
         dWOwTypZTzDlXJ1SXKGJyNlicpPJZ3yJu3ZCNOdmW1yW5pR1LPAcZGS0Zl8vROhJSuKh
         ujhvRuFDepVGV6YeJwWKAT0dOmOvvf5T3lTjdbfNSii/jXSGNfSvzIXKt/ewTFG9xLQS
         1LLz5J+Afsp4LB2ASwaZrLq7Rsd/9ICgia8umno8bUZl3Oxvt/0wJtqAzHjrI6F4Wb47
         VevQ==
X-Forwarded-Encrypted: i=1; AJvYcCVST2MHLIwG7ah/T+N8MmtukxmlI/aPaF7vDE358hSFrdLNO8DEJwHQOXyZbGZtCBeKwvyENHO3TJPP@vger.kernel.org, AJvYcCW10VJ2Wvbu03d47C+4I9wkH8UkiC8kVQQUkEy0v0GnCU7dCceuiuyQlLwx6Odw9Q1HTPrmhfM+Kd9P@vger.kernel.org, AJvYcCXkliMV6BxLQAk6/QUATQrc2/1Hin8lPQWV0ZcSjX1NUtZiNG25BPz+/hlHv04jRylz++6fC+IlFN5k5E8I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cZdvxU1GOq+tZekjEgkpu8FVf/iWRlUe1hPyOKAmUl4OSCbT
	0v3NMj7ek+fXSnTuHY1aYc0jNf25i11bJDQ8aKy4bgwt3fy8K72EdZEo
X-Gm-Gg: ASbGncvs1QabodUKk4Fx+iMBLd6gVZKGSdzdec0BWsgjo7LqWBUZba41RWK9Y2fYsCv
	G2v5z4ma9T7LPAfcj6lstBO+W4ameptbikRXoSTd4kACqCcVuaYeM+yiCiW/DAtdkNXmVQ4NppA
	W+1sznis6ItwJvHGs3a0BABBDhzYMQQA4q7tVZBNJ9q19fQaDQv2HvtK/inp/W+w1xAHUqDRtje
	DB0HgZRfHrHn+yFCqvyAJw7ghgLm7sWObNXVPSJnfRmrHkRHPY3I+haLtZd3i3BwjuK11NpXOJ4
	wwT6Xi9VW1BC0T2hDKlNSfqeSBNdlEViAWA/YPlp0f7xtRLefw==
X-Google-Smtp-Source: AGHT+IHRz7DFmS+m/wbIEmlbjNK9ONjoUM/9Rb0PzBQyOZSLp92DEkSiMsqKQwTUJrZzAOq+0BPCVw==
X-Received: by 2002:a17:903:8c5:b0:224:10a2:cae7 with SMTP id d9443c01a7336-235e1205a43mr91528285ad.40.1749110134572;
        Thu, 05 Jun 2025 00:55:34 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc86cdsm115201015ad.8.2025.06.05.00.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:55:34 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH RESEND 2/3] arm64: dts: qcom: sc8280xp: Add GPI DMA configuration
Date: Thu,  5 Jun 2025 15:54:33 +0800
Message-ID: <20250605075434.412580-3-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605075434.412580-1-mitltlatltl@gmail.com>
References: <20250605075434.412580-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPI on SC8280XP requires DMA (GSI) mode to function properly. Without it,
SPI controllers fall back to FIFO mode, which causes:

[    0.901296] geni_spi 898000.spi: error -ENODEV: Failed to get tx DMA ch
[    0.901305] geni_spi 898000.spi: FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode
...
[   45.605974] goodix-spi-hid spi0.0: SPI transfer timed out
[   45.605988] geni_spi 898000.spi: Can't set CS when prev xfer running
[   46.621555] spi_master spi0: failed to transfer one message from queue
[   46.621568] spi_master spi0: noqueue transfer failed
[   46.621577] goodix-spi-hid spi0.0: spi transfer error: -110
[   46.621585] goodix-spi-hid spi0.0: probe with driver goodix-spi-hid failed with error -110

Therefore, add GPI DMA controller nodes for qup{0,1,2}, and add DMA
channels for SPI and I2C, UART is excluded for now, as it does not
yet support this mode.

Note that, since there is no public schematic, this configuration
is derived from Windows drivers. The drivers do not expose any DMA
channel mask information, so all available channels are enabled.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 368 +++++++++++++++++++++++++
 1 file changed, 368 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 87555a119..ff93ef837 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
 #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -912,6 +913,32 @@ gpu_speed_bin: gpu-speed-bin@18b {
 			};
 		};
 
+		gpi_dma2: dma-controller@800000 {
+			compatible = "qcom,sc8280xp-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x00800000 0 0x60000>;
+
+			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-channels = <12>;
+			dma-channel-mask = <0xfff>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0xb6 0x0>;
+
+			status = "disabled";
+		};
+
 		qup2: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x008c0000 0 0x2000>;
@@ -939,6 +966,12 @@ i2c16: i2c@880000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -955,6 +988,12 @@ spi16: spi@880000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -971,6 +1010,12 @@ i2c17: i2c@884000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -987,6 +1032,12 @@ spi17: spi@884000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1017,6 +1068,12 @@ i2c18: i2c@888000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1033,6 +1090,12 @@ spi18: spi@888000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1067,6 +1130,12 @@ i2c19: i2c@88c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1083,6 +1152,12 @@ spi19: spi@88c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1099,6 +1174,12 @@ i2c20: i2c@890000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1115,6 +1196,12 @@ spi20: spi@890000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1131,6 +1218,12 @@ i2c21: i2c@894000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1147,6 +1240,12 @@ spi21: spi@894000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1163,6 +1262,12 @@ i2c22: i2c@898000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1179,6 +1284,12 @@ spi22: spi@898000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1195,6 +1306,12 @@ i2c23: i2c@89c000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1211,10 +1328,43 @@ spi23: spi@89c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma2 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 		};
 
+		gpi_dma0: dma-controller@900000  {
+			compatible = "qcom,sc8280xp-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x00900000 0 0x60000>;
+
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-channels = <13>;
+			dma-channel-mask = <0x1fff>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0x576 0x0>;
+
+			status = "disabled";
+		};
+
 		qup0: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x009c0000 0 0x6000>;
@@ -1242,6 +1392,12 @@ i2c0: i2c@980000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1258,6 +1414,12 @@ spi0: spi@980000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1274,6 +1436,12 @@ i2c1: i2c@984000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1290,6 +1458,12 @@ spi1: spi@984000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1306,6 +1480,12 @@ i2c2: i2c@988000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1322,6 +1502,12 @@ spi2: spi@988000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1352,6 +1538,12 @@ i2c3: i2c@98c000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1368,6 +1560,12 @@ spi3: spi@98c000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1384,6 +1582,12 @@ i2c4: i2c@990000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1400,6 +1604,12 @@ spi4: spi@990000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1416,6 +1626,12 @@ i2c5: i2c@994000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1432,6 +1648,12 @@ spi5: spi@994000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1448,6 +1670,12 @@ i2c6: i2c@998000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1464,6 +1692,12 @@ spi6: spi@998000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1480,6 +1714,12 @@ i2c7: i2c@99c000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1496,10 +1736,42 @@ spi7: spi@99c000 {
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 		};
 
+		gpi_dma1: dma-controller@a00000 {
+			compatible = "qcom,sc8280xp-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x00a00000 0 0x60000>;
+
+			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-channels = <12>;
+			dma-channel-mask = <0xfff>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0x96 0x0>;
+
+			status = "disabled";
+		};
+
 		qup1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x00ac0000 0 0x6000>;
@@ -1527,6 +1799,12 @@ i2c8: i2c@a80000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1543,6 +1821,12 @@ spi8: spi@a80000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1559,6 +1843,12 @@ i2c9: i2c@a84000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1575,6 +1865,12 @@ spi9: spi@a84000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1591,6 +1887,12 @@ i2c10: i2c@a88000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1607,6 +1909,12 @@ spi10: spi@a88000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1623,6 +1931,12 @@ i2c11: i2c@a8c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1639,6 +1953,12 @@ spi11: spi@a8c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1655,6 +1975,12 @@ i2c12: i2c@a90000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1671,6 +1997,12 @@ spi12: spi@a90000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1687,6 +2019,12 @@ i2c13: i2c@a94000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1703,6 +2041,12 @@ spi13: spi@a94000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1719,6 +2063,12 @@ i2c14: i2c@a98000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1735,6 +2085,12 @@ spi14: spi@a98000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1751,6 +2107,12 @@ i2c15: i2c@a9c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 
@@ -1767,6 +2129,12 @@ spi15: spi@a9c000 {
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+
+				dmas = <&gpi_dma1 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx",
+					    "rx";
+
 				status = "disabled";
 			};
 		};
-- 
2.49.0


