Return-Path: <dmaengine+bounces-11329-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zuRWKafBJmo5kAIAu9opvQ
	(envelope-from <dmaengine+bounces-11329-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:20:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C746568E1
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:20:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pLZoXsex;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=icF5Ea+C;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11329-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11329-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 657B33066417
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF4372EEC;
	Mon,  8 Jun 2026 13:11:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3637F74C
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:11:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924279; cv=none; b=mfbOnjEQbQdlzhHqJHUDPnQnEt+Y9KwVsdtcjFM9Ww+tklJyF3n1yf4TAmvzX2nUfW89upNwmqm6H2U23h2MGwJ/LuB6pXq1PGAXru4dLC88MZKJwzSHg2y4UpJYivlZGS4L38ebgHn89O32mb3HdzhdsAdzGDMciZnWiu17WAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924279; c=relaxed/simple;
	bh=jR6YhV5ep5pLBOPLg761UDA0PjAz0VbTKnHKpTcW+ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVPlsu5oBYlqrtJsn8afZNolW0cTBEo5LqJhK/XVrKTomo4b+MBl9j7mTgfz5q8Ruaon8kB/gyNc8jpUggzQxOnI5zP49tyAfkcScWkY+URK1YHHHPqJd9ZGGqV76ovSUmOsv4M3z1OjKYlUrUN3msUU0Qz/mbjlSxmZs5Opxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pLZoXsex; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=icF5Ea+C; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBrXn3454913
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I/wz/9NOwSAVpwWiAKx19eaHSA1euzCq6tjGAxoB9aw=; b=pLZoXsexosy80BEm
	FgbM5oPIX/uS9H+lZ7EBAX+DHYfslx0F4oNEamHsNNSnQi/DZ/yIhMdhObkNOUC1
	7leZVzg8A7gz9Z5Q+G/zmlBARu/2lgBDF2pOhxN4esEueiGfxEd4S4PdF3vCLMLG
	Z/ZUP6/leVGMhBG6tXIhZ/Xf0gsDq2SdANMaz0sgOuO2DdpNgLskdRKpiGOE7URM
	rbl3ijfu2Xm5/PPzu8I5f6zQZbtyoaL9PqNbI6eHrHSi71peLiE5twwWmXYLYo3R
	S8943QmMEglwMMfokAxyf3qEEIkeubSp048MrElXlW+ABqnI++NSqQUqpP9hCUEY
	ulUOIA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0h2a0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:11:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0bfcd629eso56354155ad.2
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924276; x=1781529076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/wz/9NOwSAVpwWiAKx19eaHSA1euzCq6tjGAxoB9aw=;
        b=icF5Ea+CJbknkKD/TxbLN8clgoAUT6AS4pVgaJmatnByCY73jXnfDqFC9+FUV2bo0E
         c5Dq6MRnrfQ3haZCObbJjfk1cJHyYjrDTd0AZaDupF6XnglKS0a5pbwq5hLsfJepAQIO
         QG7kc4Mx1XwThBRQUXh6JJ1+LKgxOKzfmOgsxfqAH0R2Y44E7lFThIXkoJd19/H7v7ON
         Byzkf8dUVUOxaucH1XnIgvlerLQ5srCtD+7hrF4pi9fUfYiutOeq+E2bNSG+1wylomV5
         3MBxFy8MoLc8ew4CDU9ZeHzyTD3FWoyCC4BkBCPUb2FGBBd5rMiI/Qj1vIsRHnMco7fM
         OMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924276; x=1781529076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/wz/9NOwSAVpwWiAKx19eaHSA1euzCq6tjGAxoB9aw=;
        b=k55PSGn6txzPafy1l9Grrn1qd/eEFp0SxWAV2AaJHKnFTA1qICIv1Bu++/EcgnFkp3
         gufhsr+LTCV9DgL60oCcwcl0e3+hXifoO49vHUQila+5FzuubUyYrkiXK1VrjfUmpRFu
         K4KDG1EtAzYGr8aja50sjzIj5KfXdcUbVTXSd+bMzIR0KnjtHEBdJo8mHvmXPySpNwm7
         ilTB0HQAdmZZBB/8RR3OV4X8T/ogLmrX8eFaGar6TOy8R3Q+QJYbIjs/wbaKsOSeuOH4
         kCFR0HWlAjZ4hQDC6qj1jo3yoK5xfYnPOBtv19YFmUjkfF1e82Qzlm9BInYhAG/SjJ8C
         jO2w==
X-Forwarded-Encrypted: i=1; AFNElJ/V3aCObQV1CdhZRhVtTQX+T1wPpr3bjqr3o66FzUe1bgw0Rwwj37jvlM3ON5nuoWwAu09L1DoDm/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjxnimc4YNLi/VeaVPie36JBOKPhXyG83HQH+I6/GhwKgxzi1N
	ezx9Als6mUfh7DPOmfo/Ycy8rB8pef/Ku+0TR/zYgvZ0gorx7bo4d8dG2tmWcCqnI2lRMeCv2ZU
	M8JL7biEhO+IoaxPsIPTU65KqImRN5ruA+6GT55a6gTtrr1VOWfdPSUXWP+U4rZM=
X-Gm-Gg: Acq92OFFHHZPe6+wvhP3n15sJkCrr/iIB79UNtSjk/8HiC483hq/6b6dS7vVWggTiIi
	9g4/DI1LRQNN9S1BBOjUlO84i5gYpRSCx85V8+9KWZxJ32ykpM/3DHd2wz/5RM+1A3vd2epxx22
	kACCEr/KVrx3fLhYzAiujWXrtrRhgTGAD4eu00hgWgpjHPg6KPjBUtRsIgS4IBNOf+n+QnAGknS
	3p5JCr6HRfDQJX87X/HA9wvwTQdWHMUihC2yeuzUFJbiVWpc+4levzoo/wBgO4Jmg6TmupCfgRw
	vZZaiJsIVL1MshSO0FMleDQRR+AoqSng/jiP9LmHbKl2sZ+s+4jIRII4j4wpUKdaP2TUqaaXARc
	cU9jvzLBXUeaoofOp4WxxNDirvMoTtQQoNS4WLJtqRw2MYCU=
X-Received: by 2002:a17:902:ef0a:b0:2bf:2e28:db28 with SMTP id d9443c01a7336-2c1e8232ec8mr186342245ad.29.1780924276043;
        Mon, 08 Jun 2026 06:11:16 -0700 (PDT)
X-Received: by 2002:a17:902:ef0a:b0:2bf:2e28:db28 with SMTP id d9443c01a7336-2c1e8232ec8mr186341915ad.29.1780924275509;
        Mon, 08 Jun 2026 06:11:15 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:15 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:26 +0530
Subject: [PATCH v4 06/10] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-6-2114300594a6@oss.qualcomm.com>
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
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=2278;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=D5gGyqtIwk2UK3htB2bHcmpge1N1N00jXDk8Ev0N0Bg=;
 b=+oKWdX7pL3lKgjEfn00fZFp2W79nd0TLZkO/Vp184qfUgWxSfRUypold2qgkn7c8W66zTtE6Z
 M6JTKXCI1biC2QVT05Y5C+W/uf91DMuFIR+LJElsoh/1uP9XymrqG/D
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX62vq+WaV/3CA
 Lhqj5OaC/60Djd+uFcerVLszEmcI06QOT6vk0z7AIEHe7Yy4vTMDAlyTTv7obD+TXDVkxWypEGn
 037d8SRvyUyvgKX/BVOp2sEXdUlF0WoDjW1UVXdAw+1CCGqCF1emvou2xb6tSNfFO/j6K7o9gUK
 A8ct4AAuDCtag/Mou79WFJGxPCRZantE85EQUum5t2zzx+0wnJdAc4ZfxFda4LG/9gk7jqpl1bo
 U/0cGGY737iZYJsWu8LnVtlICTcs4OhBnq1si471A/+gKgT0WGcSPVJEB/b1CTutPtc3et8yLXK
 BJmY6rz4Ofasc6xdcujPJyyWIk5rr37NJxG95ZkaToMqoh2bF+Ars447+6mn/dIbl+4KuPakFHk
 iheLhl4PEtJ1GdgDQ/QiSXAv29zXJ/yKV/WyN7g/rXbvnipyfYFt8XWLsiA2eQZDmC9eADE5rKh
 wNoJVou08bK9P6YwF/A==
X-Proofpoint-ORIG-GUID: RSpXOXdB7h5rOQoMaiMxQ9LhtrYyT65V
X-Proofpoint-GUID: RSpXOXdB7h5rOQoMaiMxQ9LhtrYyT65V
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a26bf74 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11329-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:vishnu.santhosh@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 21C746568E1

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 309ebe515814..219c904fba29 100644
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


