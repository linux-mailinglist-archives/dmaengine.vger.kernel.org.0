Return-Path: <dmaengine+bounces-11057-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKwVA2MtG2pa/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11057-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:33:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F555611F3F
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 620D630EF428
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735C3C4175;
	Sat, 30 May 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBNXFwo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFHIyg55"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE03C4542
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165711; cv=none; b=T2zvhOWpmtLeHtPS24/O65TpWgm9tOOJCgnErqwmGJuvq2mEuja/W+62EyxVAMJ7IRUkCVsjlkzAi2iECSWwxohufD5LjtKHbzGjkC0y9m/azLl+s9qTX8aOiB4h/b1hPSF65IWYWIt/jTY+9oYxw5Vnm+phR+XBUtPhKky3/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165711; c=relaxed/simple;
	bh=szx38dk7eO7FpCFIXCdeBV79GbDa6G0K3KhI7GR7yMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcmQJ4ZR14GAwxZ6FY4EZxwW7KRs+ofEGpjfHX8yV1xmC66sh3jMcQ/We0FpUoRlVVHx0xWGg7kjJu6+hMmNLiGhyJLGFcUS8+S8YB2+EqO8giUzF0XIfqSeIHTpSsYQI/kwYi23oUfVAMnauGr6fM7VsfLdHRT+tgsLAjrIQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YBNXFwo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OFHIyg55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOKF5249972
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D+HCzmgZuzP0sZVwn+sOEAlTZUisDMNqv33YeVPjZVM=; b=YBNXFwo69NQ7hhyT
	itWqKqjTE3E74niXyVWrZJHbnHE4jQeUUOIUw599BXqXfw2+AoMj/leboxsvgfou
	UqvUxDFs826UMvOqOlVIR4BofeTtfq9wd2MTI9SAcBht+ewK+6fn0toNIXyMXC2/
	Ut4TsOieWkU5zAIp7+YInrEDxZFtg21kuEXbNSLv1je0vSzFdjCupzkgNx9DDt/H
	xo+nL22wla/8a9ltrKmJlbrvfeRf7HkAb6fJHwOSZb0prSHt5gAh7bon2DTLQzZe
	/JjVM8R5WZsxFmQqn5cQNqIEEKRMHKVuclkAR08dp5GR3AHLJimInQrsfk06hcKn
	cHcQAQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux519mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf32259e0eso14165335ad.0
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165708; x=1780770508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+HCzmgZuzP0sZVwn+sOEAlTZUisDMNqv33YeVPjZVM=;
        b=OFHIyg55piYopCdpL5kihM9APrW1Qfq1m2U08M4r1YaLxftmBDj+Z4y1TB3L2oackc
         3NK6pDR++wQ1tWMJcWSSei9q+c1cVyryzn26/QIu7MI6zLcDCwZ9WvOtC5l+A98GTWJM
         PO1CukXWQ4OBJW/TuRJAd4tB7AE4g85oh9n4kQOVviW1gFdXdf3qxzvcVfJ1hE66CkE9
         FwNxC1kJxHaktD/H5ikj6Tj0w0T9dIDkpjDx5SF+g3MnsAq3/tUFpomxYGG494Ti7gNJ
         N8kPn/xg4vmQd+SAe5VT2u/wRoieyuycjMUb01Ymw6db0prNg2pjVmPgOjb/zwlDd+2j
         yBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165708; x=1780770508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+HCzmgZuzP0sZVwn+sOEAlTZUisDMNqv33YeVPjZVM=;
        b=s7hqdTNCFtpt3ovepzg22Rh1jKAP0Cz1mzXAamONATC5CHNMd45F/adZF2qFOVW9lf
         J4McVjzc1RJvN3mKcR4P1Fu2bdYQzsrdOQUWYQKVGYv/Qk1jALp9fg8bsDpmqDb+AqNh
         yz7FNNJfIvgN8kQum5Qbxjnnv+86IWkwsrHr+iIHe+X96DG7uI4KXUhWRqteUkpUJUpO
         TtBmFDCO2NvlNzw1X+YKiGZUoHKrZgAWjAwMArQXe+HcEeTRD3qMdu/MIjAQGwW7DTgE
         h/5VFna3G+vkhP6DwGEa6jmsaLthl5Mmm6Yjk18l1a3lJJMqMc4T26b4GZLpJgN32+N6
         C6zQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bZFJON0ZsZ1xjnjRenwrIx3A2/KzPGTDlqikN2QYXMGPqs/3zjkSkwr+Rzdlrgy9TaYxw/ZI53PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyryKnBYqg1SaORyw2KSh9kKFzqHiqTt/wwdOBZLxZO4mj4cHTl
	fmxO+jcbSE2ObUArbYjH6NY21vc9LOxtPhnKphbHcHx5IqsamUmcmUOq9rqlHihrgoyXsR+NrfV
	erecrkT46lu0fLi0udg+IwgJ6wPlz7Ioc3xyQWjUJgsTmRqBAIHrJ+VzDCTZGsnH/vLR2BHE=
X-Gm-Gg: Acq92OFz0TuzM7loAHHSVUYz5GVPfT1jtVVH+gQBmcbjA8Nk7tTVItHH44HGSe1Dqdo
	kAz1XaWQO9MR9vb9aLlP7Zy4nJmGClAAq7C8umZCny+f4Fx/4XmID6+yhePrdRF5lJD7poY8CNI
	4qjybMt4a8YTR3BD83tGiR8JjbypDSoQmd8Qk/rFRJLgjzAH9IJzGR1nkg4H2SUuHuoLKBc1pYe
	EUYXJFmRASPw4nYo6kpnKWlCueNuCWoDvc2oa/0woAXNDCpPnFyjeqPQE1oMOhAZmDXlmT7Yz1w
	UH7KHvHOXkd6Lc05VE1Nx2AQ8FQyuT78jihAjulJ3Zjj2cU9uxfEi6pipq8y8mpwhGFWC9c7mQp
	ijllzXhzGSbHaQXYkCrAU0fxhWvc4i+D1O6ppNn+n+PMZi3c=
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr56498645ad.17.1780165707751;
        Sat, 30 May 2026 11:28:27 -0700 (PDT)
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr56498415ad.17.1780165707285;
        Sat, 30 May 2026 11:28:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:26 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:24 +0530
Subject: [PATCH v2 06/10] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-6-6bb581035d13@oss.qualcomm.com>
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
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=2211;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5A79pcddnRcu6d01V9L1rukvuSe4x6q+6eyE6jTLb9g=;
 b=r7bbRuyLvwN1pjchzJaul7Z78pPorFr8QoDVS2AY9Doxsz0i7SAi5DjpHc1SFm4uM539uvC2k
 4VRZtRUKUAuCdm8N6xAnXzBVs2q6zK+gLeLPOdJvszvxQYfqbHicGfP
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: sCEtHoUNM8oGLYmwtigTx-dmSfJ1w_LN
X-Proofpoint-ORIG-GUID: sCEtHoUNM8oGLYmwtigTx-dmSfJ1w_LN
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1b2c4c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX3cCzUW6QULpY
 x1skDbynBYmBJlTSMYBT79pc1SfZQ/XGvocnUTJswHEq5WEzz0Cxv1mdevxcy5ytROUOzhaTAoF
 i2xXujQBcZ5lXUvggEjWODqTC0c09x/hmLS6+OIW/BFXa0y6KEj5Eez8iIyI0Y+4yhsoJqXsCpe
 hQ7eTuzXTT1l5Y3ZDe47jXKkbJzmWvjG7yvYZT1ogKFVYhM/40nqaDAQ76kcK9PWIbiOgoAFUDm
 GsWkl/OdXu6bF/LAl9sTW+55+WgxftLhRpKu56GFy32wXKsSUHaMC+wrN+yAmb21ZHSmN6PwIk/
 WBn2uzaCID14BBO0rlMCL8ebhyeUfcat5ecxyLvUkWTPb2MBg/ng1Jl/eHfhnAtzG9wcChTPbeK
 InKzCJ98EJ56w4dW2haJM4dzNlXQG/B0nx7acBKseR1JyeywKFJJzqBA8L7er2ccN8m6ySaJc8r
 HvTiZ2SX3LThHRM+l/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
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
	TAGGED_FROM(0.00)[bounces-11057-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,0.0.0.0:email,b4702000:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 8F555611F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 6c0cfd73cb70..10a6e9f3b5a2 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -413,6 +413,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 263 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lmcu {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+
+		interrupts = <GIC_SPI 287 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <26>;
+
+		lmcu_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		lmcu_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1


