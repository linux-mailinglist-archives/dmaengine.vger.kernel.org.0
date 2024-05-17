Return-Path: <dmaengine+bounces-2053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB18C8472
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B62E1C22C0B
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF0376F1;
	Fri, 17 May 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oNbGawra"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE03613E;
	Fri, 17 May 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940280; cv=none; b=OMM2MZqPGygJ7AqgaljqlpX8dlHS4mdmL2UZKXMtcYvjHR7Iop5onQEKgVKpCTdtf7HLoYcNAgQrTLtpKBkSCEnmgbf0bgGgAxs0B/vijdg6FtWSVBRL7+5OaHb85zTPpvnkEV2UoAjh3tCfoLUCag0QqpntHLokuds2aG8tkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940280; c=relaxed/simple;
	bh=khnf29i32aNVAMX+4Zk9uX22LHX/hcZuuWR91ou6qAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONKucQgoPO51fXKMMFBYM3blupUrijLxX5YtXWTxKsnHVKVWRvDtCmXj2e12k6oCyeKt1pIVziF4h5Y3urWBz081IgEYpsivk54v1Ax19Q/NdkHPw17K/qL4ox8/5z94L5lBVFNavxv0dBHAyeiRUJQMew2Z3zXmFaBWZPrd/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oNbGawra; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H6nI5t007149;
	Fri, 17 May 2024 10:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=FlgfZTd
	i55ysQfpWg3ZieDj6f689imZPhj+6Dyj0gSE=; b=oNbGawraBdbbdl0VzzArllJ
	u+b0txNfmcWPyiNvJeH1PTmY78E3PjrVVbjcvkSWimW6Adjj7N8rxo6YFv5mhGI4
	cj7RowmbeDNbFN5jKnmIdRuxot/Gw+zctkgaZuTa2b9troz4Kvl7xwYuRf6SnfFa
	DLT4icxvFDyya4TAXqfovqBkHqekwl+VJ+eaUUkSkfTxM/w/qO5GNooZXcQ/5MzR
	lYdGBoJig2RwB5xTCsgzn+lKGeRUKsJ//1ou+RPQWYc8ZEEXjDYuOaAsiAge43lV
	bNA8lcwtyzkh+8zbzafAyWQToUdIHN0HNsvrVqHRLkRzRSGcDBBXWlXs+9X1qpw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y62a80d7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:30 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44HA4QaG008006;
	Fri, 17 May 2024 10:04:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3y5k8ap6ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HA4QN7007997;
	Fri, 17 May 2024 10:04:26 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44HA4QGM007991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:26 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id B9FD221295; Fri, 17 May 2024 15:34:25 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <rohiagar@qti.qualcomm.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sdx75: Support for I2C and SPI
Date: Fri, 17 May 2024 15:34:23 +0530
Message-Id: <20240517100423.2006022-3-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
References: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZRwZdF3oyFLGRu2glpDNQ3iJKypzQmM-
X-Proofpoint-ORIG-GUID: ZRwZdF3oyFLGRu2glpDNQ3iJKypzQmM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170080

From: Rohit Agarwal <rohiagar@qti.qualcomm.com>

Add devicetree node for I2C and SPI busses in SDX75.

Signed-off-by: Rohit Agarwal <rohiagar@qti.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 431 ++++++++++++++++++++++++++++
 1 file changed, 431 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index da1704061d58..5e0204b3ef7b 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sdx75-gcc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sdx75.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -441,6 +442,28 @@ gcc: clock-controller@80000 {
 			#power-domain-cells = <1>;
 		};
 
+		gpi_dma: dma-controller@900000 {
+			compatible = "qcom,sdx75-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x0 0x00900000 0x0 0x60000>;
+			#dma-cells = <3>;
+			interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <12>;
+			dma-channel-mask = <0x7f>;
+			iommus = <&apps_smmu 0xf6 0x0>;
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x009c0000 0x0 0x2000>;
@@ -457,6 +480,52 @@ qupv3_id_0: geniqup@9c0000 {
 			ranges;
 			status = "disabled";
 
+			i2c0: i2c@980000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00980000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_i2c0_data_clk>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi0: spi@980000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00980000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
 			uart1: serial@984000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x00984000 0x0 0x4000>;
@@ -475,6 +544,229 @@ &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						"sleep";
 				status = "disabled";
 			};
+
+			i2c2: i2c@988000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00988000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_i2c2_data_clk>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi2: spi@988000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00988000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			i2c3: i2c@98c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x0098c000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_i2c3_data_clk>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi3: spi@98c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x0098c000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_spi3_data_clk>, <&qup_spi3_cs>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart4: serial@990000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x00990000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&qup_uart4_default>, <&qup_uart4_cts_rts>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c5: i2c@994000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00994000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_i2c5_data_clk>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			i2c6: i2c@998000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00998000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_i2c6_data_clk>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi6: spi@998000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00998000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			i2c7: i2c@99c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x0099c000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_i2c7_data_clk>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi7: spi@99c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x0099c000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&qup_spi7_data_clk>, <&qup_spi7_cs>;
+				pinctrl-names = "default";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
+						<&system_noc MASTER_QUP_0 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
 		};
 
 		usb_hsphy: phy@ff4000 {
@@ -661,6 +953,145 @@ tlmm: pinctrl@f000000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
+			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio8", "gpio9";
+				function = "qup_se0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_data_clk: qup-i2c2-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio14", "gpio15";
+				function = "qup_se2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio52", "gpio53";
+				function = "qup_se3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_data_clk: qup-i2c5-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio110", "gpio111";
+				function = "qup_se5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c6_data_clk: qup-i2c6-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio112", "gpio113";
+				function = "qup_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c7_data_clk: qup-i2c7-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio116", "gpio117";
+				function = "qup_se7";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_cs: qup-spi0-cs-state {
+				pins = "gpio11";
+				function = "qup_se0";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi0_data_clk: qup-spi0-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio8", "gpio9", "gpio10";
+				function = "qup_se0";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi2_cs: qup-spi2-cs-state {
+				pins = "gpio17";
+				function = "qup_se2";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi2_data_clk: qup-spi2-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio14", "gpio15", "gpio16";
+				function = "qup_se2";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi3_cs: qup-spi3-cs-state {
+				pins = "gpio55";
+				function = "qup_se3";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi3_data_clk: qup-spi3-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio52", "gpio53", "gpio54";
+				function = "qup_se3";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi6_cs: qup-spi6-cs-state {
+				pins = "gpio115";
+				function = "qup_se6";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi6_data_clk: qup-spi6-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio112", "gpio113", "gpio114";
+				function = "qup_se6";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi7_cs: qup-spi7-cs-state {
+				pins = "gpio119";
+				function = "qup_se7";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_spi7_data_clk: qup-spi7-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio116", "gpio117", "gpio118";
+				function = "qup_se7";
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			qup_uart4_cts_rts: qup-uart4-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio52", "gpio53";
+				function = "qup_se3";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart4_default: qup-uart4-default-state {
+				/* TX, RX */
+				pins = "gpio54", "gpio55";
+				function = "qup_se3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
 			qupv3_se1_2uart_active: qupv3-se1-2uart-active-state {
 				tx-pins {
 					pins = "gpio12";
-- 
2.25.1


