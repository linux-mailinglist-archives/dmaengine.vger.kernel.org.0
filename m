Return-Path: <dmaengine+bounces-10475-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFa8Cu0hBmodfgIAu9opvQ
	(envelope-from <dmaengine+bounces-10475-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 21:26:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF35465BE
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C818D3011BF9
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC73B38BD;
	Thu, 14 May 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8O3Zt+u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqD8A2pS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0773603DB
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786653; cv=none; b=jkzGp1WjUJvQbnwFUJtcYgc2xepQO95EpLaWDBSIAzksFqcXQhX/uqGCyIf97iIC6dZBvlQ+huSTQgoeHyKh9IDJKIDzrCoUsugO1fymbw61Ax/BoHFkMA/ZeRImD16/6RgPb93q4Q4Dl8r1KhRt0p+txPTMouATUu5oKpSLZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786653; c=relaxed/simple;
	bh=070Xbb2yH7rviMxEVsDp0aqueE1Kr933aUlYRRWqT0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAzNiwuEi+VURl1QgmAT2WJ+eMbJmRhMo/ScV6oTXVIRnU2cOeY4G0dZvgjQtd8h56ueRKu++YurzQD4e81B7cLWF6FDGuy8hF4K4Pngw00icxvoyO+dEhgQmJFDMm/0j85J5+bN9B/MG9XLHcDSMniDDrbe2gIa2Hfakr/c4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8O3Zt+u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqD8A2pS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpWKX3671009
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XBdCprBquhJT6uJVe5HV6Os2DLU+NPDukg1/CpLMV1I=; b=C8O3Zt+uhCIKom6L
	Dnlt6RMMVI6HUw4Q9tvyfpxUDrQxsH7C3rgbM+HyZ5Bq/0odZlUIQVrYpJQDe25k
	QCP4Fj+VLw5P6lZ4sLMolh570FU+WWcmL2ty0BNu4kNAf9+o4oedEY0vEnzdMyj+
	mVmeJDKkZ5TI91bJ6cFdsUtSIjIPwY+/4Amt/Tx22kShnMh18+9UgfsRCJhuKoZQ
	9kHUoZTQrzUqQ05ol+cvQ3sY3jwzqAlCp3oahPgR9llDLCWtA0dHU0dfz0b7zMNf
	JtvYnnSnUUcloLWvgswnhMKysVj95Yv0flxBcDv+OFj3fRDSrhP8AG5dzxYAxPvF
	rsS47Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s03vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b99eb06178so175851875ad.2
        for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778786650; x=1779391450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBdCprBquhJT6uJVe5HV6Os2DLU+NPDukg1/CpLMV1I=;
        b=hqD8A2pSvLstggTsiQtNdx4UtL9QHxsh32vqtrEkAHDFLZHCmojOSSptsjZ1KX/Vtj
         l9713+xeq5YFyVgxEIpOfRldfHwebBXzsD8PheBUrLDbrGCRb0LV68ywb60LM2x+Wv93
         SOq2KP7NeXerqfxoZTa2RepqgNBZTd6e4ZB2TK+cguhkPnq8Ojd6m5BoTr3oKOhC+XmW
         7+gbULq36ymSdWRouWZPkjBvaalMQGqH05l+qYggrXwfIfZz99CDckNJf6q/gREV9Nuo
         RW/udUWzL52wpgjWKvnKq4yCm27U0wWC4LR2D1WkOMOzsJJ7xW35UeJxyDjAF16PJCDi
         1U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786650; x=1779391450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBdCprBquhJT6uJVe5HV6Os2DLU+NPDukg1/CpLMV1I=;
        b=rPXBUlBA5k5cGmgK9KHqDcthJjf9yfSmjSC1WwLPPnU3siBK3ffRyRH0uDTAQOCfCO
         TMURDMtMJZaCQ/sBmityWrHTMhBlbm0Y+Sc9ka5XWN8NITFdQUzKljwGP99hXRTlT+Rf
         HAh/FEn3plylhD1nRIhWRGcH7L+WjkwyFYiomCSiMsirlZvyQdXfid6Zk9rd9aitesXu
         mF1EtNpA1ZxuA20uzdqTwsXb6XxDpnzP1fsSfRTTD8f0nyKMtgW57DTJmsmA8jnHe17I
         C12Mbz9KgCnorctYcKy9BrkWGhK9nTEoh2AtUc2oJDFsDsDt0OdnvYsWl4sZDI4H/Enb
         OF8g==
X-Forwarded-Encrypted: i=1; AFNElJ/YDFCfa7/40XYjr/61fR/kppZF213t7ZcInEOfqolK3M8eiP5Ytn25eNH9/55fUQrkApd+ghXAfyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCmhAf1Kx7KfAmcU2DF2X6sSY/BXh+2+/Gqct8j2hiffRprsx
	LpZG2WTfpX+YGUHPqK8Bw+19l73lJxqynLzRZ5Od5A5OLO4n9j021nh7m+nK2OjpttRrLWAQmsK
	a2FkyDM6aiHS6eFOE2WJ/Lg/RvBLctHnxfSYJcgMzH4PH2NPLreT8eQsZgC1OjvQ=
X-Gm-Gg: Acq92OEnfELTZCMpufjS32EAnOL6BOj6VJW4JtHRf1DeEaDd6fNpCoOCrAbgCmcgiZV
	h8ySzlStpdTugYS+AryOTRPm2nAmqrYRDyZ1CzDSLSSxNvDls5y6K128pC+FgZbXpM+ydnkU11Z
	xdQHcDFaMSDx505Uy1WBCq4RgIrbNSD5nJFIfdH8BYZuvpVRdRTbUrXzRnc30GE3e2J1OubTCN2
	0P9v1owgiG8bD3v1qLsaWcHyzYs3eTfg5/5m5nNCGYcjsMtTqZQKCBnxxsUbX1buRby9m3oZFUv
	O4yMiYidX4Nbv8MTU9ZZoYRGcI+K9yDUwyRkCbbloeMX27Mo1xOtrFbqS7jGdsRoc3ergZBpsyw
	mg2CUq+51xTvp8iZSJfXk04dtMf14FWC4Lo+4aaJUwfbH9WGUJBqOFpb+s9ODHOnh9w==
X-Received: by 2002:a17:902:a618:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2bd7e9399f5mr6818335ad.35.1778786650120;
        Thu, 14 May 2026 12:24:10 -0700 (PDT)
X-Received: by 2002:a17:902:a618:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2bd7e9399f5mr6818225ad.35.1778786649681;
        Thu, 14 May 2026 12:24:09 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f291sm35506535ad.15.2026.05.14.12.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:24:09 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 15 May 2026 00:53:38 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: shikra: Add qcrypto node support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-shikra_qcrypto-v1-3-80f07b345c29@oss.qualcomm.com>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
In-Reply-To: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5MyBTYWx0ZWRfX7tB9/fZXGFxs
 Dhqkq0xT6MEgkKX0nzQ4YHw08ATkxBoaFQCIKq8mo6yY1cqElStm1UdBgM+b7f2FW1+IacDIWOs
 drqpY6FZ+rSKdk6tvvHifJtglGqRhwNCS7SiGzLw67DrJ8RF0kDCUicrbXl2D5lBF2wFEd5etLK
 /DCgeMmVS/arVVJ4qTjDA9RPMD3sP7MOmnsN7D/IoZ1yMyEtGa0qMMC1yGZilMiZPEKM7nbmNsJ
 UqarM+k+hL5mBubnaECOMiydvHbRMfOGFZF8N6LsDQ83IfHYcOTQffoWhQB2HRmeTXGmBJ4Xrkt
 w89LjkdSutbDMcZQvoEoWUdRrYHx93CERTv3kEIKtniKb5DoNusVciDIuy3z5nvbSIQ5dxkT1qr
 +R0iEL6EPy6JeayriVd481eQOrCcDdv80UB7aQ3VYjR9fav0YNcxAInmZjifSoS9Bp7iobX0Swp
 u/q2JRDHqWMT/xJn0Jg==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a06215a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fM5HeO57NUmuB1IZ8XwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xPes0y1qx_0bPkhslt4tjL6u53IVSn50
X-Proofpoint-ORIG-GUID: xPes0y1qx_0bPkhslt4tjL6u53IVSn50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140193
X-Rspamd-Queue-Id: 93DF35465BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10475-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1b44000:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,1b04000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.28.253.224:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add qcrypto and cryptobam support for shikra target.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 262c488add1e..dbac0e901d6e 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -541,6 +541,41 @@ config_noc: interconnect@1900000 {
 			#interconnect-cells = <2>;
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9F 0x0>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <16>;
+			qcom,num-ees = <4>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,shikra-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9F 0x0>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 0
+					 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names = "memory";
+		};
+
 		qfprom: efuse@1b44000 {
 			compatible = "qcom,shikra-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b44000 0x0 0x3000>;

-- 
2.34.1


