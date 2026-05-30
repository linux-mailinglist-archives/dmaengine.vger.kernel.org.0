Return-Path: <dmaengine+bounces-11058-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF87EnYtG2qU/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11058-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:33:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B222F611F72
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99CBE30F9D6F
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE413C3C1C;
	Sat, 30 May 2026 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkdSD2tq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsCwnpI3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273B3C454F
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165715; cv=none; b=FeZxU+NFunO3guyvuiB9dW+x6/+UtA+1LOFKpiVT+L4r0ZlA0GqhkNJNGTFew76BRLxwmfIKIntXSSEXENLGlWlOQaZ40/3McORqhwm20YCFe1MuzNzt0wIdo47j7jEmm26Ps8ZH2iaTTtWICpVhckhXVb7Y1kVQLWIWdJY/nW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165715; c=relaxed/simple;
	bh=oss1AbFlJjJbPFMAGAr7Uw+fsc5hDCEahi8e9MXUcUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1/7/nmjDjPuX+8ckkvSnmM4mZpkO13St15FgB7JUZS61FBg2SnwxabApdz94nisAXBmSowYgUbeYwmeNUxfPnSHsPHr4bkO+yh4200bLmv++7B4pLxyNk0FY3BCLbAlUuKmErNygT5vv3XzcUYPtPt5bxKGZDu2uD1qmXsG2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkdSD2tq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsCwnpI3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UHj21h2662654
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bH+gIPsCKk/nJTFnyZErSz7Q6U91uzeLCAr7o+pT6dw=; b=RkdSD2tqGpV7b5Pl
	o6cKqdJG+urywZMAVXFPFf0afLHmvqKNVg4T8ljunsS820TSZNvNoAciOjX77S1Z
	vULSOCgVJ+eBUBLOe0n4zHuYLzVNDfJZlzKMiMPBk0/MEu5MD0MLuq2lUCGbr5nd
	4uIeLXnA4NL0dop79zsqR4tg9am9g91dDkEbPRDQ8n9/gIt98EjLnN6LAB8rP2NW
	VLPEDsNVtsO+xKmPh/oAxbk9xfWkH6npnldT3Xym8eAyNGnaYnPJ6hb6e5x2xkSp
	sfl9DNUA8FkMRBSOtAdiiVGcRgaKFm2cZMtx4H4CpmcgZ8W8UnsBs1uLrVN+17rK
	zw64Zw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efs66sjnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c1e112dfso739795ad.0
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165713; x=1780770513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bH+gIPsCKk/nJTFnyZErSz7Q6U91uzeLCAr7o+pT6dw=;
        b=BsCwnpI3kMdC4C6YRjAtQYS65er0/3omQDR40hrLsJoa0OhJ7ShQNQJ7kfhZbZgxRa
         bip5FIiZYCOo1JtSADhtUt1fx/jJQrLPChiGmFbfznRtPVCohAWYblLVFvxxmJA0q8pL
         6Cj1UqKE2XUxT8zMPKxEBsY5BdCbw8ju9Bf2f2xTDkksSwjCMLJimA0chKzNLnATK60G
         iaQ4/dn5hpl6IzbEAwThM7XfQzpYaeJNfajmm74ZCA5nnbkA67oJ2RMQmP7sb3iX/ObI
         1Y6fusYhMlmyN0UN+B5FRfYW/ZevrRYadDE3KJ1tgD3Qf8U1jqBVQwWI+EOHOScfVhdM
         Io6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165713; x=1780770513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bH+gIPsCKk/nJTFnyZErSz7Q6U91uzeLCAr7o+pT6dw=;
        b=C6mmORIXz4gnSJ123bYHQApPvTXotBeltqgg4gmpAN7Wq2AXBgXGJ6+Yef4Ycb6/s7
         thYe6UMGhtAOwErZcHupH+07U3KGM+aJDc3pUV0dd5FFPKDvvRS9EoXoTfyPA0lCh8A2
         EMYbw4W2Aehj0LlorLjlUHFN36kdrLtqJKTHYPGaaH3bZpny+CYDlO+t365zmgU5Hx2Y
         QngmTI9+BkPeYBb1WXOnE9KR33FNLFG0+HVjP5OC4yRrIozuOkZ10pIXvGrlaaruKJ01
         VDa0qda8O1fQKdYpFMnZqUcV7gN8IZ8WdiveBUuMFILT1hxHpO09q2CLt+TQARpOBc6o
         DfSA==
X-Forwarded-Encrypted: i=1; AFNElJ+H29PH65znKUK9EJZt6/DYgMZv0SsPrVbYP2FnsotwdqzyaCRanLOzFKg+9AlAPSYyt64DTNL5vDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgwcVx/W4PgQhtb4UKrvmMhTHhqYfQkd2tYRswvcrOxAjgv5d
	sQZY7+q3/Erv9h0SPpNujyJ6/BWrR8W76c40wdf04WEnLMcOiGyUre5KYAVIH0SHaO2vw58ZTMa
	LvFb5gm+OM8vpv4Qkh4AlbE9aT0i0L2tccUA1u1GHKR+74Mk71v/G6lH+v5pzcAc4dlXMrLs=
X-Gm-Gg: Acq92OG731GricJC80O26EU/o824lFQI0HWCHEBURKdfuqn83B/z5Uf8z/PDy5nzsEq
	0NiJXpuWOTb7wC1UE0zMcANoZHaWo8uNIi3Hl7/4JtoplWC+yWxjwBaG2Z+k8YfbZYIfiFVuDE8
	6MtqTsaqdr9tnL+2X3ro5dVadRJRrS6Wb1bmHP0vZK/UZHXKghBNpbprsGc5hM+155iXWDqtrYj
	An+AE76zaXv/pRCjwqUUYuF5a2DrB+i4GGLoMqCdqSSVcUvuRF7YiEeixMY9N/j4NnxUeg5ppVe
	CB6QxBjNx+uwWZVo8JcpwPUJx4HQDgeRh+dyImCddukir9BSxPq3ITuxd1yE48r1fHrYGURgb3N
	ZBGL7hywLFP9Dsp2NBCDu+Bx5XloVnogQhNpnl/CMa7OKwls=
X-Received: by 2002:a17:903:2f85:b0:2be:3626:dd49 with SMTP id d9443c01a7336-2bf367938eemr52641525ad.8.1780165713239;
        Sat, 30 May 2026 11:28:33 -0700 (PDT)
X-Received: by 2002:a17:903:2f85:b0:2be:3626:dd49 with SMTP id d9443c01a7336-2bf367938eemr52641295ad.8.1780165712739;
        Sat, 30 May 2026 11:28:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:25 +0530
Subject: [PATCH v2 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-7-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=5225;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=1fh1aHI11+QB91jAsPzkCHohWd1ShL+ruDzWZEwaklY=;
 b=jkexY4H/VhsA0FT/YAUnimWweeds4hhgaM+7ZPRYNmmJyJ46fWpb/M8dupPhcFAMGyxrMt1hb
 U3+Osf2QNkBCNSrZDihs6WpptjZlX9hmD8hK+FTUR48CwZMktCpOG5q
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfXz+jUAYqGjHCA
 9uyqkr2tBwq2vh0cZYUeByekLK2dfUt+IgmkyRj0SVPqhZoMwkeQ9Y3H4xmXhvxLuP1B91NwI1g
 mtnjY/CSrY7nBgSDVwRSSEPScH3eI8azpN0WqAx8m5MzRVL5q8WoXS5V8sEN1wXQ9ZVE2MtCW8d
 N1n8RE73RXk1VOv0u8+kVbvdXUxM6GLFywNxEexiUbN+tJTtm7Fdczf6/09vkJbEKi22hxBfgOn
 XeepCDpcVNx+OLTCEqVcagai0zSvS5ojhaVtToBI8Q7t5LM/xW17WO7tBLtuFguBLHCsWJTgPDs
 2IxT2+Hp+9PD1KHssM6ntSSoMJOsY21+CaXgWSPjY/WnG6X2G+WHTv+66mrOE1Gjumcqoz/yaCa
 DLjNe2e8ceAOhMxTDOTXaR4cpdLVmKsznvYyX2qmb9m1y3Oy1jNY7wKq7P6SV3pK4+L7eOYRxw1
 qQFC/2cjUzzBO7vY4Ug==
X-Authority-Analysis: v=2.4 cv=X8di7mTe c=1 sm=1 tr=0 ts=6a1b2c51 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: EN-XTcSLTqZgVmwCAOBK11KYvvrz2vBM
X-Proofpoint-GUID: EN-XTcSLTqZgVmwCAOBK11KYvvrz2vBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11058-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B222F611F72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 10a6e9f3b5a2..eaed7c53d4cb 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1798,6 +1798,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		remoteproc_mpss: remoteproc@6080000 {
+			compatible = "qcom,shikra-mpss-pas";
+			reg = <0x0 0x06080000 0x0 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING 0>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+
+			power-domains = <&rpmpd RPMHPD_CX>;
+
+			memory-region = <&mpss_wlan_mem>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 12>;
+				qcom,remote-pid = <1>;
+				label = "mpss";
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@b300000 {
+			compatible = "qcom,shikra-cdsp-pas";
+			reg = <0x0 0x0b300000 0x0 0x100000>;
+
+			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING 0>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+
+			power-domains = <&rpmpd RPMHPD_CX>;
+
+			memory-region = <&cdsp_mem>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 261 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 4>;
+				qcom,remote-pid = <5>;
+				label = "cdsp";
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					label = "cdsp";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x0201 0x0000>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x0202 0x0000>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x0203 0x0000>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x0204 0x0000>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x0205 0x0000>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x0206 0x0000>;
+					};
+
+					compute-cb@9 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <9>;
+						iommus = <&apps_smmu 0x0209 0x0000>;
+					};
+				};
+			};
+		};
+
+		remoteproc_lpaicp: remoteproc@b800000 {
+			compatible = "qcom,shikra-lpaicp-pas";
+			reg = <0x0 0x0b800000 0x0 0x200000>;
+
+			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
+					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
+
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
+
+			qcom,smem-states = <&lmcu_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 9>;
+				qcom,remote-pid = <26>;
+				label = "lpaicp";
+			};
+		};
+
 		sram@c11e000 {
 			compatible = "qcom,shikra-imem", "mmio-sram";
 			reg = <0x0 0x0c11e000 0x0 0x1000>;

-- 
2.34.1


