Return-Path: <dmaengine+bounces-10433-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCDfCsrIBGodOgIAu9opvQ
	(envelope-from <dmaengine+bounces-10433-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:54:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DB5395B0
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80EE030325B7
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3423ADB99;
	Wed, 13 May 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gDt9Gewu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e2OW+mMd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441133B0AE3
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698377; cv=none; b=qrxWJGkN1pizSTxqWq1jI+WkLKjbI+Sdcc83naoJUA1/4cj4LW/hUc1xh2UeDSCRN/fY5wm9Ph/JcrmXYWaiWo+Q/fOOPzvmsdwJH24W6/xJx/8wNPhiaBIMHBT61C3sNiiO17xcUno24JyzbDZ+peaPcE6r02loe2JAh8mTDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698377; c=relaxed/simple;
	bh=LTHMLdWF8HFpPeJgdf3vWYwEXH7E4tFvMQpFvdkayZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qDonzS5Xd0yDt1Eee4M6SWBJZeYgNAN0TQ0q3LsGpriFv5r0XMhzKZscfISEPcsFQJxWlY2+S/yaw5zxDBQXFHVyff+Rhelwo7Y2wdQZWY+ZAtnesWxE4+gcqgU6fIFyMenHrdXiuYsw6+ftDHLI+fKImdIB1H3q/Z/fFilnnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gDt9Gewu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e2OW+mMd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DH0Jec2321422
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G8j67tz9WUMhPlFuCoWNwxqGklud16mbggJpzoK33PU=; b=gDt9GewuvcQXRWE0
	7RmGFVGkES74hmnZENQ0eB8DiDdsIiTlPFEH49fV3hF8vB1lT3OGNldHSbIz3aUa
	qem5IOwY3QshRbiAXLoqWJGlsViq8d56GMZcZyyTlWBulVzE83F2zOXMWlmA4m/j
	N3+tE+WXYlhiwZ/aRymbcHcfW3NlAZl863mHcUDhUNk7KWfoMRIM8Xvu6BHbKh1c
	HjmwupE7VUwUrCINPxG9JyPhSWp9SOHwoGZVvhyUDvxiJvP/QBdPt4G4KK2B7oI3
	aB8N57/nlk4hR1KzgoH7VgJkiFRQuJjreSA+LidP9sD9A8s+/JDH6bgXgBzySMNM
	tl1Nuw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgubjp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so6232471a91.2
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698375; x=1779303175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8j67tz9WUMhPlFuCoWNwxqGklud16mbggJpzoK33PU=;
        b=e2OW+mMduS2c9XYAdRcTWc5N1ufu2Y3y1GV6WF9YS6WtBKvgENcpMIK8sTlM0zbvJp
         MJhviUZb4Jvdl8jVZopAgJTOhyWzXrazY7+wwubxQLvWQTmkLgcoLXavvxeIRUcPV7np
         Ea7ZKWU5BO0hgmPr8TIuBJBNqTI5qnEcFS6AGfTZx3VgR3BNiHZGjO4aoXi5WMj1DMUh
         UED5GrhHNLnmeeccyW12ZcmBqEoFNp72wMm2DLDLaCQh0jcdt6CVUvwKEHq3UOfoVl5B
         nCLuSBxJm+n7WTVt0gdKKe/KLOAkbJTz7FRXx83BvZoDZTbQ/92zKGXuAeWuumKGYsVn
         Rlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698375; x=1779303175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8j67tz9WUMhPlFuCoWNwxqGklud16mbggJpzoK33PU=;
        b=iJ1jh7gA+f4F0tcvu1/3iMnm+UzfsRQrlXj++JprFByirvYg5oZNHXTvU5acZF1hFE
         OWolCPDQ2FfnlUwcxkmShipLZUeEcwaR0Vp5Pz8E94GuKAdsBCsBMUBVvfMBgynADyeS
         paAosWir7fEHBwMcnN2Hs218iQ6bvX91BXKxn1s55BiLzn2sytPoox8CdQ2otlLFegR2
         nq0TLWwUJlRtNC4Fc1digurJarR+LanNgabm01DEvGFyvmo1U8+GCKp9BdV+gBSPP4nd
         haaeZ5zwSy+eTj+xXjwke1mWp07iKvNejicJA1+RNLmvv+jZOenwdNX3Cy19kxCnemiX
         r0vQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rle0wZrXN5XAGcC+PGl9TeEBwCW0gaL75BQJBLnG0tmpAVCbLIqg1zQi0VUJ7MAk1EcY9ToYcaME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5qCb3MgAdSCoOEw8oCwesSEgPbizS7eGYgkblKYMXQ55NmBa
	7iRucDpcICNJzVv7T9/6ecA491yMhT+yAOWudPrqIdVVjdP+fo8tPh2zXXztGBFXlu7Lcfnc37E
	EV+q1hW/JxeHo4So+5tuSPgnkd/ldMy1QFk8jsXrqmeI5CVAeiUIXyICE0q1h4VY=
X-Gm-Gg: Acq92OEWKp6Gfy+rdUfnldoEvKcG8eak7FzJIqnUhr2umSTjhkED8looGNStQpEgxmB
	m6tKplb6fUC2JscyWenWJA6gK0K1ajr0HvgCyJMmtz/u8tZYwmlpCO1kZrKMepbkDjSFdeX0cg5
	XsljnDVB+z0GIaeUQshzKzHfpVrr9hU3xVKUJUgJAcn7VMZY/XXxtE1h/Xa8fdaJlTf2jpLT8vb
	aVprOn2SZZQ+lBSpt1e+gkNHW4Dly4KFO+l2e7D5Esmkp6+P/+k23HVYGuzrKmXLJIgOV3nnqr3
	iCDU6VFsFhSr3bHWfq6nsld4cmjrKG1u3x/Um4dDVtoZ0iXCOWPIpnvlyDojqmNd60rc34S/x/R
	brLeSyWrI6k/MvyZbMiaQJuAwbyg9H9plkmS7cSNFzDKU67N6ELFNC9Y=
X-Received: by 2002:a17:90b:380a:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-368f3e5ae6fmr5091632a91.22.1778698374975;
        Wed, 13 May 2026 11:52:54 -0700 (PDT)
X-Received: by 2002:a17:90b:380a:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-368f3e5ae6fmr5091595a91.22.1778698374380;
        Wed, 13 May 2026 11:52:54 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee626a04sm3660219a91.14.2026.05.13.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:52:53 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:22:22 +0530
Subject: [PATCH v2 3/3] arm64: dts: qcom: kaanapali: Add qcrypto node
 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-knp_qce-v2-3-890e3372eef8@oss.qualcomm.com>
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Arun Neelakantam <aneelaka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04c887 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=lX4hch5PzS7iFd4KNucA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: GBqzK2LjjGUGBAXFhj03FVmVKQ_HtA_Y
X-Proofpoint-ORIG-GUID: GBqzK2LjjGUGBAXFhj03FVmVKQ_HtA_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfX2JFanIEALgrk
 P6RRfvt+R4NRVMKgFOOzQQIjB0yB/iHwN+iyp9V7BeHz9sd4z0GbqFOQYxrIheD69RPzOrcPzTQ
 80lo4tUICpxEQt755PPmKA+WI+8sGdUloI2yRyk6gfrHJIiESISBrgeaIUR4+m3pURiMe/YQ9M5
 xopZ7tqmy3P7RYmBQMInyoFg9EVTNtXJQF0Qbn/oh9IEuxGR+O3gSaXPtnbJyR8caqIzhPSuc+7
 soonwcjI9l0tb/8ODeTZtI9yftDJsSK/5RlAnJnuqyo2s9zae/vYJhwMDijIih3wDBxcAQBKgim
 tiVZQoAXXVkkRUjWHqIVeoVtJyaY5zsk2RtIlzTped/IIj3InJAf6MKo0EQbCf8FLnO0JOj5cPs
 KTwJnTj/6ijLq9oJFJ0rAaI+gXwlv117z68oDf7vJ/PeZISkWhzf8KQbBvp8HrwrY/nLPMDr1Lq
 WSMvG0p8gzOahmPCtFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130186
X-Rspamd-Queue-Id: DD0DB5395B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10433-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1dc4000:email,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,1f40000:email,1dfa000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add qcrypto and cryptobam support for kaanapali target.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 7cc326aa1a1a..941c9b131a4e 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2541,6 +2541,31 @@ ice: crypto@1d88000 {
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v2.0.0";
+			reg = <0x0 0x01dc4000 0x0 0x22000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&apps_smmu 0xc0 0x0>,
+				 <&apps_smmu 0xc1 0x0>;
+			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
+			qcom,controlled-remotely;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,kaanapali-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01dfa000 0x0 0x6000>;
+			interconnects = <&aggre_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "memory";
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0xc0 0x0>,
+				 <&apps_smmu 0xc1 0x0>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;

-- 
2.34.1


