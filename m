Return-Path: <dmaengine+bounces-12428-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uHm7Osk+VWr0lwAAu9opvQ
	(envelope-from <dmaengine+bounces-12428-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:38:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060474EC6F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:38:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YJNla1oC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VENVs3s6;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12428-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12428-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD2B3109717
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC92357CE1;
	Mon, 13 Jul 2026 19:37:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDC357A4A
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971449; cv=none; b=OC+lU9R25/Xhp03eUXiQdw0uzC6Ldo1Z4eTQa0cAEsue0nK/xf+kcd7Qxa2YPUevZf7ckb1j/ScdIY88pxr9UUuzCVybMyDmKqyoH7tMHdbL/luuqzjY8TfstnRZdmxSkJ4fCX9QMIB4rG4O8VTKTyUupSSsPueffhQC7yKJDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971449; c=relaxed/simple;
	bh=MG3sAgTxM2yS2k98bs7iCxw+/UEc3/K3gbnTW3sIzdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZAhmUaV1bkJh/N9kpp4B9BJQuGPbvm3rX3BYiTmJFECPo3mfIhpPe0WaZgAed2s+fZYQ8ZUwI94qWZB886Or/bGAdJZSpOzpRJ6pUYIxEuy8N6YmD4K7cLwiD4TTUcD9a2Pt/QRLqMDgn/Dg3d1NUmLWykf29O/IDsVk7h0IDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJNla1oC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VENVs3s6; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9eKQ2460987
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=; b=YJNla1oCkmh2/frg
	3NzRL+lxHZZHk2V5Sh3+gxiaa9sm+cF80ZPd5islSQqyjBB2vop7C9At2xxXz2By
	wLxgU1kcD8oWfGkD0itXOA0fVNvWPEvGUhV6qYvXok87FN1L1RNhFOhnIkAZLCBi
	pqTltNsyREvnrLHuP1Dlg6w4VsSrXNjJNKX899x26bVUGvVc2k4hWHfxWC3tCFOB
	JeyvBY/db+Dw7j1GzDsrgJX5C4VPk5UkVqzdt/GCOijMnlvFx2Uh7cC8hvmfp0jI
	ErM4RblIK3k/uvbs7Ho5jO7r3vIal20Iw4fPCke5UsNrFbbb0eerNUXweA/tlFNZ
	XT0pVA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda2cgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so450186a91.3
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971446; x=1784576246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=VENVs3s6R34UVnQPBe+UCdUBLQHE9AYjREglUlLmrS4RSZ4uf5g2LX2iNUmzyNJPGA
         GBQHfIQK3/dtrNXg3nFjWVoaR77/b3Z25HjH+CEV2Di+SxQwacMrhY3V/RuDhs6BwWFO
         fKinw+ZQxbNiFzLC3EH+R9h6davGGTCVz50UOx8a2pWNTWPhyfa1wx1ZNC89pxhiLbcq
         P2dQBQCtIHib5bsOER5pQI/fk86SOPnBr1Tu/5ox3GR3/cMbzjLaiU9zYH4bc3mD7lqX
         FmIkDGYPP5LDbIhEksVOsqw/zOT+rbNLP58+7vRQHVX8RLJQPS65wzIzeGAZYj9xIuvr
         9ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971446; x=1784576246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=VhXLYL6nRow2+zSyq1IXJScBAgh8+0dgXFtS3Y8DWE0+0pMKhG2BOqjXNr6ALTu1UW
         3qUtmu6sC5hmzG+GV2FZH/U0z4AWM3+HJoaDiECZEck1rP9BPBsRYJ6UoyAm+hPlbYSs
         wgtTL/kVw7wS8pcUIWXOTi9AKYcwOIBI+jrvryskowfSpwTNqY4gv/xRxOIa2dq/iG5T
         X18q7uk8V5lV2vNu9AL6rNsnZtFMZuuwjCKIRU3BGP8E3EtuFtvKKOr729mcf+12iqMo
         y30oaq83VESHEvKdoOQzFsmWAfJvemXYw13yUu7SWnq55uq0rs0ACcxPh2EADD8SBB9M
         f7LQ==
X-Forwarded-Encrypted: i=1; AHgh+RryLPIawfV5s7u6unppopVeOFrXPAvxb/uOHN9sSBTJ29cHOsk4xCReULpGOslx4YGJpIKus2H4CU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7yiW/fIRqClnv0Gw43zFg7ep60+TBlEnw4VvFFRLaWsVllm6D
	vVnwMvL0GCBUUuaY89HLzUEhNK9b0YbE2D6M7kTbb6fGT8K4roPYGOBTz2kSSfmWuBqyn4t18+n
	hYrGAz4CPnhzE7/ZMf202ta+80tveUn+DYwS2y4o74cRZ1HcqlzeLTO5qVEVCUXFMrJQsr8Q=
X-Gm-Gg: AfdE7ckvX5IEgVa1zqah5DtSoQhfEWLQ9PLjRjMZ31iginzkC+58r1+fO00AcCRRVhD
	bo5u9DaMCy166Msi/RCeoOc6Qsq6f8Fsr94K9q2iLBucmAs7XlTJ3hb6Z54gGZ3gdbSeJXWz1de
	FWIYaj7C3PcmuJifqJTp7lZFqstWsLuHLdRXZT3ted8F/47mCi7+athGzoSKaZRaz0DUEtktpJz
	J2vo2g/jzsCsU/vp2U1QtBadIMqQehm7oWR7h+mpy5bTPRWZVPFNf7qSMKk0/hik3wEfAj9R38u
	MSQHKFCKuFWZ3rg7XBzEgkYKemB9R3HnLriHbJGqFcY2F5xAwnKv64A5UINS8o+5gmlFmG9zyad
	ZpbHAx4qLKHK5ZPGEY89YlNeihA==
X-Received: by 2002:a17:90b:35c4:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38dc74cfa71mr10093750a91.15.1783971445810;
        Mon, 13 Jul 2026 12:37:25 -0700 (PDT)
X-Received: by 2002:a17:90b:35c4:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38dc74cfa71mr10093727a91.15.1783971445373;
        Mon, 13 Jul 2026 12:37:25 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:24 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:52 +0530
Subject: [PATCH v6 03/11] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-3-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FgXZj7vad2zgvA0RfnbjlrO8hgDk3pUjpoRSx0IOZh0=;
 b=ohJI347iFWs4U0QCz24SLyaswuGcNatjjEcjZ0P/Z5bStmRHOkpTD1QghBUSqS6AW4VqA/afb
 NMa8uB/KQEZBospBXUY9lZGnuTiWhQQKjydmq6jMo44RFV/g51mTMx9
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX7RVf0IBUTjCh
 wa9J4MpSUNxKSB6Z7IiTsXcED1UXAElaGQNNg5yKbqrqVCLqEhogT6PejWWZri820ySLmRbr28B
 BKgqLeWhy4MRWWFGlPubrpFhgfO+XgE=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a553e76 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: OJdg1N9EDI5CBiwRiaujfl_luYh5KdcV
X-Proofpoint-ORIG-GUID: OJdg1N9EDI5CBiwRiaujfl_luYh5KdcV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX68JVjEqoYOLc
 SebioKMVEqR7FqjtMq2Te2typpWQ5uIlQAmTbABujLDTkvxoqlCWzAQvcri0hujlAdddZpwriIK
 QZs6Jv/kwyb4C9pP7TBizjtCPY6NrB+lzYwB0cLYCw7lPtolPzttXOWETUY31kcNgjdiqr26sQc
 ill2gQXAWrQY2++K5nhwvzGuYgwS9NXGZeFwUsD5zgNfFni6mOBlw+3UCd2tISHvfH0DL0yjHGo
 kaJMZi/oM3OjqdvaivpcTvS1mVK9PspY9YIk6gD/5w6WHkqxrV45syP0i8kd+Qh1O2bxjNx/JrV
 BMcCYj3iFQ3LCJa0Vy799qWJ5nXitEUMf4CpzDJiix9yvKk+vDp6PU9u1zZBmr7FtbdsWZOvO5G
 e0OzCSVD5hhFvAJqEmapKgNJhWTQiW3r9KZNEYsuP3tyGoMzt30VpsaE6+REXkpqTihPlBCaNk4
 MdgtD/2rm2AONnOlbSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12428-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9060474EC6F

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f0fb55b9deb9..d66b97dea319 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1


