Return-Path: <dmaengine+bounces-10791-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDWlMpNWE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10791-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFF5C3E69
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 773FE3003D17
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDE317177;
	Sun, 24 May 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVDyVxsi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCprqNYy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A531A56C
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652220; cv=none; b=KpuuxONchWo02tjzKmyuIdZdclnWgWd3/axTFoSMO8C2cO+u0Ceva7ikHKBVbMyJRf/c806VHiTNDKrZiYi08sKAcZDoxA7swSkaOmL8Tjg9JXo+CE5dNBEwvgTDOMD3zjUfLdsEtAxLahdi+Bq1xHVR/Fwl8f0Bh4cwwYM4CoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652220; c=relaxed/simple;
	bh=h2561MUTAlBWP9LstFppBlJ737L72NjnE3HiMjLnIww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZwT8KK2e3iyIa7jQky5o39fjgzZpcL6/fB9IHXQ4XGNr8eQd0uRZStaM+QfcYTqb48b92ypd3xGy2l2dpakT9lb1XW3cwETdK3v3Ny3/0ItVoQ8bYA+g/lp4PbSaP4ZFmw1A16CapI4EKMOygSJEr+zyukOSMaodJBM2neF6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PVDyVxsi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCprqNYy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O2FO9Y3686465
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y+KE1req0AFK4kYUvSBuXjFMHaKhuk1XxVZE4565XCs=; b=PVDyVxsiK+92KTA3
	1sQ8Qi/BMCBPThWVpUuYsztNz0J+/beLWfeKLDr5J0pXm50LEOpnokbqoDq+zFjW
	7dqM8x9r5OnuHVqNuPl51qXEhSSoZeTH6acqlHExmn+Y1kNfKA9B0EEZxTGbVuhf
	7BTqKOweZv8lcynHBQ7ht08kUI8WBnBZjD8JlcbmOgwMpQ6te/DqL8EWGdqVYAo6
	IceHXquy91T7fqqz8RPHeTNMdIG2V/xQu25NtJHKIHeslEpyWh7imDcmTtUQcZg1
	/K7tGE2vbQJwO0zQy7XteEIRzwe4EEZZgwanmIOWBjggfB+EmgP6XUf0jPCl4z5e
	KVBwhA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgv0nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so5382135a91.3
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652217; x=1780257017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+KE1req0AFK4kYUvSBuXjFMHaKhuk1XxVZE4565XCs=;
        b=dCprqNYyG+sHO0PFapIfydjq4VYcpPiVsAljQItk6rYNU9Rib+qvslTLXBYOkQ5qh5
         m87ZrT00EhnUhJc8lgr6AU6WYViRgzDIFpzDhsMv2XfTCbtUKGGzsTHlubLFjvKT2zsW
         nl8OmfCdUYEcCxAbJ2JHDak/8F4YnLe9OD5N0dJweRhesjDXu+Vyms1e0KURUDzh20a0
         mD3kD+nRDDLJlHxUqfDfniE4Eac4oZcLNaAwymWw11yRPLNa3OMZr0K4TcsK7sViHyCV
         omEMtvgSyi3blzR3+t+p8uSd9n85foyqbNHjer+yTI0UsqKKKv47yUvXb+BCcHauXt/0
         1rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652217; x=1780257017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+KE1req0AFK4kYUvSBuXjFMHaKhuk1XxVZE4565XCs=;
        b=sTXP/OB7Oi/xSrCU7IywJC8ovObXROMsz2jRY5zmoGsM+yyLS7mdg1CUDUwOIjzggS
         Ht5Ls/V0mYdvbKZUxuJauMLS6Eu5NK604rPJTKc+SiDg4DMk2NyXPgMN3OzyG8IPbjpo
         tSpnAlrJkg2L9ybvf7VlvbEIPfcfGLCniWUqpWQn+It7M4kMoGCxxO2KElw/vCBN1gRg
         QnIq8XAb+QPHqpb5DHNsx9pWbNJxmzfcj08IOmb/orHvFeRTznsmV/vKE2Vjr5HfxecL
         I69Yy3fig9lx0CXA8f3OgsLpzlz5DJanDLaPeI1OpsvfjBTVw+sdqVi+fBJbZ+vkqCPI
         979Q==
X-Forwarded-Encrypted: i=1; AFNElJ9jTpK5674dv2ddilJE2FLiJ8oLDGeFwZnbKSnFcO9r74fbA6PK831t1mbG+Oy8mHpg3Y5EYjDlp1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIS8AiNI5cBWqBOvtRfbhL/b1JRJE+mXjLMDlTT5ZnOH9O1AAL
	4j6yudSYa7s5+yZ11VyzM46K2FlJEldIK/rkHY1CwsC4Cx7YWn1TEfW6tUzV3nPT3HEskjB3OEs
	Ez7bxDCvA0ZBRQJELFXEhFJW9LCrJ5GPfm5MJutYCuo0c2uRAVe47BYKzmMnB5IA=
X-Gm-Gg: Acq92OExrMssHLLrCLK4p+UyBtn4MwXPqk8HBTum1vTfg2NQL+ctCIAs/6XICFi/0pH
	60WV6NQrru9PnjAjz2vOZ3RpXzSrXt/XzwWu/TGV6s5bObM8J1V3LT841QfXh2ftFTKe48l8CkI
	PQrmX6AI8syTmB+7ZP931SXjzUz/QSCUBG9Kb0UGzSaf7EyN1dx4FXW6xdLIv+O9g6/9gt01s8m
	6opU3rFflZEM1FvH/HSBn1ac/Z1tqte5PrV/pVvYdDjwW3BugpL1Dq8woFhKYkAjCThZFXVRiOA
	sp/2RjiB9cGztBwURb3bnDk1KmUcd7/cFKU/4T62oNNC9jWXlZLvODCGqZUJuHo52IrknO9yv4g
	IAzxaNBDTGnfTpyvwP/UyT4feH21CAjkbfr0tOwZIhh8dnTc=
X-Received: by 2002:a17:90b:3149:b0:36a:ee1:fc1c with SMTP id 98e67ed59e1d1-36a674c5677mr11953789a91.8.1779652216454;
        Sun, 24 May 2026 12:50:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3149:b0:36a:ee1:fc1c with SMTP id 98e67ed59e1d1-36a674c5677mr11953765a91.8.1779652215853;
        Sun, 24 May 2026 12:50:15 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:15 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:13 +0530
Subject: [PATCH 09/16] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=5225;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=N2myH3ZS/JYAPq+cEvLA9M1TLJ/FuYAVGQaHhcS9rEc=;
 b=O3e8l/eJsdXMmKUozXX9JNw/zpUBRo2I8Gt/I7iZ63YbLY/mHjcclWZhwD5/uSFxv6NgO2JJw
 8AjiUFKULpQCtHyOXwbM58Om4TJw4asWMcO0+mPdDvhSpJ/MuN2Wkmw
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 0eC2n5yO0xzHYq9blATKBfdfOvIlq6Mu
X-Proofpoint-ORIG-GUID: 0eC2n5yO0xzHYq9blATKBfdfOvIlq6Mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX16Noy8csNOZl
 D8mhHJYe+evOXUiomWhhKl3IuMMy67Lf95QGaO2JMdrc3e6lxoqgvmdfmyy98WnDW0YXYs8lBga
 mzWaM/azpnfk2NLbVR9GXq6R/N3SBhrlHzAuzXEwzq5KhKUyNwOVMGRehCkrENQVVItOZargqg/
 iGaea0NyDHtEFgMP4AcKEJe6sidiMHMicuHhdz3bAwh6yVPHSXuIxEPsPUwha8XYqFqN8gfU2bY
 tH06KXzkxXrKJDtvyLbFS5jadg15DVYdVCjqr3OEey7svWsUWHJzME0zOJ7v1Tk2k8SFmcw2dAK
 wPWHRqRxbXxyOYXmp3Z2PfchirOzOqDcedDmQgb2H+tJLtwUnllwUismsCRYY06dRY2//PNZoxu
 /x4C0b0C17p5XcKFfimF9bnOBtpgxixP0RtWjznj1TQ25+6oOM6Vlgz/wCpZbuynFlW0H4RGshQ
 gclqCpFPLbzX/zhGHNA==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a135679 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10791-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66DFF5C3E69
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
index 2ea35e4442ef..96ec5b5c7203 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1797,6 +1797,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
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


