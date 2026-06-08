Return-Path: <dmaengine+bounces-11330-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id adGTK23CJmp+kAIAu9opvQ
	(envelope-from <dmaengine+bounces-11330-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:23:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDE656984
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:23:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dzWekN7D;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GCPf1yIN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11330-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11330-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5273035B46
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12496382296;
	Mon,  8 Jun 2026 13:11:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278737B03E
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:11:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924291; cv=none; b=RQCordWwgb5LMbT5koJFMXsIMyg1JXdK6yxS9V7jxLlJYbKYxqjcrPLxaIJE4Dd8gPvB4P6hS1cqAGdB31O74XqcLciywUQfxljbJ0KP1hENGDFcJacBLWcauzB2QSlIs1O8T99I0kFmSyvrZ82w8xYKgLjqe47vPxVKws3ViWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924291; c=relaxed/simple;
	bh=Y9Enl0Zph26PkTk+LomlG38/z42iBDvGRg5nU5WG7PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkP9wExd1Moo8CfGHgE++2CdlLfSiVibItvZxMj//j5Vf2EfOTs78Cva1qQpjr+d9CgI4Et/LYJxz1rXTsY1F03kVLMC9TdgNdkbR9ixCtHTOT5Va1MSrU3uKvZp7pgAzJGZmG0Sfr68k2Q34HbNgMbK7bXajU3pjcQtVFVvP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzWekN7D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GCPf1yIN; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9UqY3038246
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=; b=dzWekN7D8Gi9zRlb
	d0UvdvgsaiC3rwRvvt44OTUroaLXnoW8clHT4A/nDIElf2DiIx2rNDCK2E7qPFPh
	2N8ITTUcEciXrx9SC+Fdd7hHk5t3GvhT5TvgW4d75OU12+AAh8sDSXdDSbN+fF6S
	klU5jTtfTNTJJ+1hV6QBsxMEIMlL138CIqBYeDPUoC7ia0JXbwULeo2TaRkLSePY
	SpZXq2fkSmNwenCIEe516d9Bp0b0zruP9+36EFTD/xDFfBAi06HTOk0zILQ+jWbr
	V51UeKYMEzraun9EWLChCtRf3YJnw6DgjcfMFgYV8xTGBiaRVV6YTM60ZZcuvaui
	B2h8jQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8jp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:11:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so4482001a91.2
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924288; x=1781529088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=;
        b=GCPf1yINNjeFHdMVlYkRMwbQXKEA9grBLRWnP5kuDs8BDGYTfTM3VQnC83qvuXmzLE
         r43patIp3jGocnew/VpyiezIPriooxvsLYHRBs2e1okTbhowVFIezyBNp2XBX/GSBv+y
         KDhQpo5LT7OJfCLrW9MzBzTvSR4TaBZ2TKEdmkRNq1aYPtMiNgAjuemojTuSBp6uZ0yc
         DNNDkgrFwmGzHCJY7XuZzW6mXuuCs41dxPeTn7tXf5MZz+ot/egAzxo7SFJKf9ogh1d1
         5cSMn1froHoHlg41vhmIlgV3M4u/0LdzXZxzGy5WkYhv8JFhba1MuWDissPK7Az3hCz9
         i2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924288; x=1781529088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=;
        b=MS633RDE6Fie3FPjNXoYa/aQLQAC44wk9u5CBqLem0Uds20foHTx2/HfEyTl0Itc5d
         fHv2xUwvrgp+T8Ed8EkMHnk71KO846Ip1Qdcb9xRM6Vg2KdV6N/VfqWplT6KW0Q9J0Mb
         3sphpH+ioSl4LvMfZxh16VHmtVhilN2ySUIML3Sg1G3fqCuZ5HpgXyQ/p5DymM3pukTk
         0LgVJV4Y8REBpr9NeBfrCOJLyADSYCxwSSspzxPJpgY+LxFiLVqATzCCDQ8DrZXBQRLQ
         zKlyd/PcXpzFAKW2Zdc90f6BEFj68f1KAAut2GM+HJVOat6zcuKncmK++rMDafUs0b+s
         YIuQ==
X-Forwarded-Encrypted: i=1; AFNElJ88/ZXmS3ubnMZbzHTOtF8iMnZr6+lplRLubvBFnn6Yrxgu5JAKq39goG+5KJglQI5eXDVhu5YV2XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhoq+/t7WD0B8qk4ABhdnA4Wc9i8NTC4xIhby/oGYEgifPz1lS
	RvgmXiPrzdE4A8lJBIJJ2wBtxUD0il6VPI4mgjzYa5kTm5ndgfx74k2n0sL+lmNXSjo7IIKdTwg
	KvrGjSq+1f7x6Mg1AHMs5p1sp1wbWQHttMmkLCNURtMTxTTZYLTLKCySj37309iM=
X-Gm-Gg: Acq92OFbFid5WYis96r0lOPE23LQx+05BNF6aqUokm9iJw8/nCptFY1cNGsofjwMaYs
	J7uOFgyfxwK/eFDjlUnQ467zeLtzwXvmkJOPsHSxCtoaqIeY5xj8CM+4EKAvY5ARctn5IellvvU
	7KuGYl0Jo8YzZ/ll1uGmfIkVm47LfqGCeisD5+9EAqSH84/vX4qyv7JzAxyad4hi/xMNV1RtFiB
	ABZEupLo13f4tNq9shwj4J02q9iPzmn1snCDE73pviqEqs9H+f8xDWx0CHM9fl2geGwUlGQL4a2
	WCyWjBAowdsn8JiD59Kl8czpIjctvDaSdFtCugyK6ericZm8OxTyyVDE1geen2tVvK9j1njtb1J
	eEafOW4kO8pN0tvGM4/iPJYLxNlL1+0RWDSSEfbZBQpVHIrI=
X-Received: by 2002:a17:902:bd43:b0:2c0:ccdb:e031 with SMTP id d9443c01a7336-2c1e7b401fbmr114801605ad.2.1780924288413;
        Mon, 08 Jun 2026 06:11:28 -0700 (PDT)
X-Received: by 2002:a17:902:bd43:b0:2c0:ccdb:e031 with SMTP id d9443c01a7336-2c1e7b401fbmr114799295ad.2.1780924283081;
        Mon, 08 Jun 2026 06:11:23 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:22 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:27 +0530
Subject: [PATCH v4 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=5225;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IaDoauPJHJLmeg0KCOp3wjoXaMuRxylv+BxtByokKWc=;
 b=Ab649ndMnmGUP8LhgjQw+eo6ASF4OZQlbYe3gvzZLXgz+5B7OhaD1U8njDGyntiXoNU15FdU7
 sC+sSmuDMfSD6S38cuSPlHedORtzvdFjoyeVjWT82iCsqxQ7eczNuTH
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: Qan4PODys9lqbx2Tr77Zxa3ug_xw8fVM
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26bf81 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Qan4PODys9lqbx2Tr77Zxa3ug_xw8fVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX0rQb7743JJoN
 QHIlVpPhWzT7lDta5xrfO8YaD30vTi0F6HSvBf0deBJqPF3SI7IuWc9LX2zhrQsWxt09m8UGu2A
 4jFCVXWwJB4FhE+NNBFABiwjcypUydmcRk/2AYHioXTh9vWMNlnnDpjIcQCejGicrdXrSzh56nD
 QDGyYxzcrxWblvhqXbc0Il9yPpyggLE2w227HHdwmwoEmnPFjvdfEAzuq+1B4vQe04849KElO0V
 vrBpBeg41SnZTikPEwafaB2A4UxO2tFLcmfyeKCDHvBnbdl2SHnKAcK05UL046Bg3Zb4qmSfWX/
 j/U9T/EieQd2EF+XVQT7/arYR5l+TdScMclo4CNm1PUWlnLVs5pWWZI7tZeFNyOguijnRNgzf+e
 qWLpZuXR01oMncdUU0hZsM3fb8R/oFxq5aMCeiU1M0y+k+OEZwW3TB7n2OnCLOz7o58kf0uGQqX
 xoXYfmurkkE81hmPozA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11330-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40DDE656984

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 219c904fba29..445dd8bb7269 100644
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


