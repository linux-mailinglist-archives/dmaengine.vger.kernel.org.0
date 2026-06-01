Return-Path: <dmaengine+bounces-11101-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCDtGqOCHWqTbQkAu9opvQ
	(envelope-from <dmaengine+bounces-11101-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 15:01:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1861FB8C
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F85A3084F36
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D137F8CC;
	Mon,  1 Jun 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9w8nmJn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2D+1std"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9339E6F8
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318558; cv=none; b=m6p4HcqKA4NtIPRuh2/9TNahTu7FsKZJEVA+TEWldDtGa0vpn/5luXhBdz2SMi8FH6rMttY26EH3js47GtTMppMSz99LL/+Nmodhpc5uN6kOb7QS/9uJHqEucRwPjUfRJEU1a8ikqzVLe5nVseTh9AjGVC9laNg4SyGefSZbAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318558; c=relaxed/simple;
	bh=Y9Enl0Zph26PkTk+LomlG38/z42iBDvGRg5nU5WG7PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmED0lyGJPLsf5z52O/zUda65jFp7ZUt1QQ045Sr03quf6+p7R5kUENtTQungKUrXvW/OOzoMm/KHP9Qu4gS0MJkt8PVbdsploVvtWL6s2FGJUDaLUi11Hl8uEZzzH1ZnNNv0GfhBptRc0kkTW1TOhtd4ODS/UGefe0e0DJlgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9w8nmJn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U2D+1std; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6519Y2jQ3372613
	for <dmaengine@vger.kernel.org>; Mon, 1 Jun 2026 12:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=; b=C9w8nmJnAdQrcKo2
	cntyEEuj9hbkhktUUmjxZpwmHhbV8Ep6lXH6VfZd8s+qenqfr5P9cgr4WoBtAc5W
	Luv1FYYhZqruqTD/MzB8hXgsb3Utxh+HLN6JMSd6K3sKLaWEqiE9G8ZGSV/pURRb
	MtaUeSWkeSenbQbmYCnO0TLCAZ1SczlTa5o0SfZojb4cE8lOvmUlJlF3uTFc73TJ
	xb6kgzDv/fxNktHcvbGiiAp5U/RNtTdH8OqWX1DnS3S7dUw4IB1oqQt9zneQXM8A
	VhcPxNQ1f0IeZPQoyeB4JkBJBJu4tm0hxtsDipwiIyslt8yQLVesejwzcgtF/oC6
	pd0zNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh7jh8t36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 12:55:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf243973c2so21751405ad.1
        for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318556; x=1780923356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=;
        b=U2D+1std9pue5/A73jXqrKmG1VNjXqpd6A6nsUthwCXwsRRiynAMOYiCxBSjdob7tt
         wShFPuFXrCLpud0JXvFskC/dGhID4KvAx3IBX4RGprqccO8A0Z84rBOSRsv9MnVsg8Kg
         fEpkcHf1S36YO7hl3ZmiVo0o1vl3BS36jVHauUeRMKlc+cqZZTPQi074lV3OIPip3aL1
         elCgpPl2UNvFZT/eJFXxM6BsR41JgVFLa0TgB6zpu0Ok21wr70rd1v1G+Y57MIGSh58A
         5P3wiZx4suFe0hM9f4PBMbtlYL131I/x0nhyFzX0WImEctcB/z/wvfEengifuIiK26ex
         MApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318556; x=1780923356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=;
        b=IXGyePpBOxtvtmbwLi4qEMRDvUQiXS5697mVUO8HmeIEAswOA0KUHNFycviM+tfb0Z
         dnARazS9H6dhFSOVPnO5nmwW2wKLWGMv3hEcJuLvBtxJkgwVRxKHvlpyLouyXLrx7kYT
         9v6LUQsqQORSpmlKgeuc+nOwwYHXwcQajc9Lf1ooHV8OkC5nS+uI2KqvCvHgYJbHJcte
         IwlHIKLzkpqM5IHdwLOFlK2MfrbUPXEklq85FiEPRAao5HBQYhxj09wzCucE23DOCRlG
         ZxK8LVuw4hQCNzr2MIBgwCBWhA0eBZKlEHsWAaCtD31iXZt7lx/8KlYj0jOo7Vgv4vdv
         lfrw==
X-Forwarded-Encrypted: i=1; AFNElJ+9emdhG+C4EYz99xi/7Qb7ttsYH++bbA0KYu8LHjbfHSdvEOxfatJcvoWyxKIB9jyCR9S7tJxyhuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXXTRHUms8DmdbzMEIchzNn0RD79zd4602U/3O7eJ6gje/6VB
	rcZJgabDpivYCKsWOKE2697s/QQJ0DCjHL8xtVYnWTZMU17a86dNqEYu1Jg3JR4ACOREfLMMFZ5
	r9GY7Cqj/wIH0JC2K70PxUM4OYplL/dE5RW5yUca7EvlMIKp42t74F9Faz9UmYFo=
X-Gm-Gg: Acq92OF6ZnVIQcJtYKnaswiRkTwNkYOfrPgqeGpXvS+WRC8PouJsW2TqwKCIDplbzrx
	Mfd2y9zvtOplc6XWy3g56BiWwyhayIBaf3Qv+gnrKDYeEALYu8Gxz2Mr0Qtr/WMCHOrK5IF4yd5
	fZNzLEJZsEj+i73R12wX6gRznhz+K6koUeHhzZ/63z9tk0lUUHcqmpwNjRZylUoLRhDskgLEUXL
	8PMHXr8K++qODh9rBKzLE02VBgR2/Prt/es72KLREkGBFzwYhrfzh6jTU16V4wb6ucE1A/D9M8N
	rz23GGWVc5/VazX85ER2RCKTGr+sruPJm3ksmPqoYs6fFEanmpa4JAin6Bjv+X662huLZI06EP4
	TnmzUzDbLktToPS9RtSeLJP9Z24zTKC7PiCeX9BJ8BtTytIY=
X-Received: by 2002:a17:903:3c05:b0:2c1:2fd:47ea with SMTP id d9443c01a7336-2c102fd4a5dmr6792055ad.4.1780318556087;
        Mon, 01 Jun 2026 05:55:56 -0700 (PDT)
X-Received: by 2002:a17:903:3c05:b0:2c1:2fd:47ea with SMTP id d9443c01a7336-2c102fd4a5dmr6791625ad.4.1780318555537;
        Mon, 01 Jun 2026 05:55:55 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:55:55 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:09 +0530
Subject: [PATCH v3 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-7-0fe3f8d9ec48@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=5225;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IaDoauPJHJLmeg0KCOp3wjoXaMuRxylv+BxtByokKWc=;
 b=sdkzBqG443jHdegGYp/cTWdetB41PNbQHKXDU8E4fF5KehlK9WxGcnEcIfxRMJjI4+hoXekjE
 Lzn9XZuzE9UC3IRrdADuCIPzB3CPD1GuvlE/1NLVoWw9eRbSbH+db8Z
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: 9V1iilx6E-rhR6JNd_LgoiLjMFt09dKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfXz6azKc1GEn2i
 Rjw3PUhxMujfunvxrTPaucmkRPCVP1DbHv/sh9mCcwwBLjeWL5+j7l0hvUyNb4fGGfSTxMOy5ca
 nLtWjtXhHJ0s87GJQRzS0WmIBeAhqHD3GJjo9/vjGp0VXjJCCc8G7cvBB3RTIxAdsGSjiJYGuXx
 9tpyPREJQ0RyBB4b4Q8VOW1J1PbSWE9Z9Vxn9fRM1Va8twgUzKV9c2AbpZdPptFu+mfcZsLvEwH
 rewBOTVdnN6MRl4XHUpLpZJeNAumIC9Xv+Zg+3DzQwXNcDOtx8iC4KfwBfDGoMII1f+oRXE3YxA
 cJnULKNGBNmyYPjYYzxaaEG5TsijA+IsNUiekERWt8EAGpd8bfm3Cf/ygKb/Wr7ePJSMRAnJdL6
 4dgCbRHHpQxwWb17ZQDt1UGwhXNu8tcmgph82MxZr8vX5RMFI0XUiRrccvYL3bzDpHw9kDKf1Fw
 c7iEmhYz9ktcsVdSnyQ==
X-Authority-Analysis: v=2.4 cv=YuY/gYYX c=1 sm=1 tr=0 ts=6a1d815c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 9V1iilx6E-rhR6JNd_LgoiLjMFt09dKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010129
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11101-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[compute-cb.0.0.0.9:server fail,remoteproc.0.92.198.0:query timed out,compute-cb.0.0.0.4:query timed out,compute-cb.0.0.0.6:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CF1861FB8C
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


