Return-Path: <dmaengine+bounces-10797-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBg/LoJXE2qA+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10797-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:54:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB65C3FB3
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 568A03046DE4
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF78333727;
	Sun, 24 May 2026 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nu5pLaU3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AnnnuZTM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6C33ADB5
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652251; cv=none; b=m/WQtsiz4BxKf9f4u0fjQ3reGV04DnU5KqQ4R3hT66No+3PMSB5y2cvjYCY1Uby480e0K6l5miwKsbilE3OJhWYDj+7Ks3PjYAHPNbV5SeCJiOsO8GZFp7XNTi8qYY3adH1GOXo53/BvAmRKWHF0gH6+74RgUiu1FKH8J0QslGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652251; c=relaxed/simple;
	bh=QHs53WAmeGFMfxkmSZB5/SkFtyoQnJo08LrqI81uq3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOzi3H1zbhHweWQGaAK5FfcisEtN462fD6y6Zz6mg0S8Xe+iXl0iWbpVd9CN3A2APY2aRTFkRsWPziiTXSKvtZM4PK0todLBtxIBfXfU8JPNNqR/CBPXMQsrKjaFwe0DCjX9P9KSrcwZr2xyCpq/hQEQW4GkvIZYI1muDcztBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nu5pLaU3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AnnnuZTM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJG4Oi2490773
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEUb66gxJlk7bkld/NToFu/2Ms1dKDjAx8+uGsJgYsQ=; b=nu5pLaU3yp0/nJ+W
	7yOSyi4NZY4LbZGLX9RudoyGxCDeA+YYhMFnKCw8uGknpEhg9w0sn9l8wn21NtVX
	IcNwbg90N45DWVyw7ZsviAefX1YI+TUfFXC73zq87JGk3avMEz3QauWN8teQzNid
	A3YW0/omlKXUqn0wLinmngf/5hu3aUYQ5h8qM4w0n95QjqtKXiFcqyXK0vKH7XVV
	F9lr4LUF6LjtXwJb1trza/f/R0TxTMVdBUjgjEfVY8uFlv5SnPdIQfQiCr/PNNAz
	utGySmlkXSS/5no45C739MYadAXnQ2yWzMy42F+DytUQaur+2T9bcCcOX4eovQnx
	3mNNZg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50fut6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3662990c03fso7054200a91.0
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652249; x=1780257049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEUb66gxJlk7bkld/NToFu/2Ms1dKDjAx8+uGsJgYsQ=;
        b=AnnnuZTMGD26iOY1g+s0yfXwJqyz1uA5mzquU/PIJakUXw66huiwQbFxuL8MGC5hiz
         /4WPtCOqn7chweUMq5NeinLK8d1Je0+cB7Hm5Vu7Clts9HeEM/3gZoaMix+O0HQL0rJP
         X0mxfCWQ+0Exyzo70FqBIdEROhu1U2nPftTcqvO32gPW3VPpyOXDnjVQPlnJ1Y1FC454
         E7zATlzvmfGK3QL9ZbdlEFPnFYJuv/3K+PxuiDEJsrNjFNtbPEBuvZkj/hY0u3c7/LCd
         7tc77S1AdAws8CEdIU5lmfPAspNWxE1IQ3poyyVhUjS9NMBuPgzPjm0rAx7vmXTD5HvY
         GeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652249; x=1780257049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kEUb66gxJlk7bkld/NToFu/2Ms1dKDjAx8+uGsJgYsQ=;
        b=MBxGLEALfbf1qmCkoPzy2IMz4P1f0svM0HCBH3VolcfwRXjaBZt7ENgsBEk/eJVz+N
         /0QYYXk5qQFhw+zjIiue6QIpQucqgqwYVqN3L5eGfejKwLCTHu0T+VGcWQyjUlyavA2v
         dLQYYPAeiiuuPaAS4g/A15H2jE87mPe4w9Bp5Scgb8/JlDygCH/HrroQmRYJkiIpcALi
         Tmh4zrOD2C/6iruFqzpJB2w/Z436ebwVbm81o/QfA9z1cnriK0DUkDiXRrl4EtbZw0zJ
         8zEob7ntH73GnM9pJdvTI3Ktyr37k7OfYaJAgE7UvVtDoW145FzQI/zyUZ+gUxDZbP7d
         bzIA==
X-Forwarded-Encrypted: i=1; AFNElJ+zxJnP/yKis3TRkEd/189X6Y30FUXPxBTxZ3LFKfzji3tGFqsCrAL/13YOkmUPbikWYOtsDaFGN/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCzf+3udRPikur2kei5V2agk6DfU1FPXHa+/vLloJQawuqvKC
	1tRm4ZHav2VzSzhQa/Ck/puCWT7DNW76hH7kqD9ALn98Ag5s3Y2ku0fnAZe8U2iiDxMGWfRiZ7c
	LEwmUmJ2q0ZygPvd4wed9cLkT3YXRmASfv5Au2jO5dxFJM5FSmQRcBVrhFmSp+WU=
X-Gm-Gg: Acq92OGZH5DUrxEWpVShSXXU7+Sqcj18NB9JHz1pZtQYjE2Ggm4En0rCJOj7zS0/3oq
	de0Ii2GNY7a7IHAluYpMCrtlBI3hFFupSfWXLIMedor38ojravQZYaiY5CZfw1KmUV5CCPKeNo9
	kcNAi00i09I32nEJWgi4Rln8ISCb6APO/khmtkj17bpZJvPoSX00PQlMPsvfIy2oMRgmV5+ARFk
	Hpi9puyXbyCC2Ca7Bvu3W0pM8hzYYwXICnOTnITf3OKX1y5FWSgJhSTnsyb5BtTlRba95xkPmr7
	WtxVz1PL0ol+Mvp2wffOgqqScxB9YzNr0zytnWtVVhwBz5+234SRJZp220ziBiVxCaFVeWtuOea
	Kt4mXPNUHfg85j5QdgDOiMs5TxdVQr3K7994m
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-36a6bb5a6bfmr8169651a91.4.1779652248337;
        Sun, 24 May 2026 12:50:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-36a6bb5a6bfmr8169634a91.4.1779652247865;
        Sun, 24 May 2026 12:50:47 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:47 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:19 +0530
Subject: [PATCH 15/16] arm64: dts: qcom: shikra: add WiFi node support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-15-f51a9838dbaa@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1721;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=lmXTT1nlWiT0OHoqXSzRACrqa8lWFzuUSv43JPEixBQ=;
 b=WjkSsJ7S+eElgpBj6JCE03TqhmeeNHI/Z8Wif2z1S/SIogfB/do6Q61Y0ncIyB80iu/oJxFHw
 4NAlgJz+UEyAWUbpj5kqSRTLhyxupZ5odlJv1Nns4/V1vZlm8LiQfWt
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX05zyMcC8xBEN
 TWvSGTWy4cAuhj7McMtHHYpLIuLP1nKqdjvUBjxQOrK9an3Us5eH3Kg+s5ml82QfEGD2QsKd7+2
 nPCe6Hd4IJovdxXe8Fc+/sGjU2SpzAxMTXmeGnkxIE9Y+bLp+dH4QzJRPwuUkDM8doMxwi4GfFf
 5zFRO4gjky9n3WGG6XOax4DQLBmApQyUnusm6NXaOZ8+B4M2nNI9+3LbT9MzeosQOwUv35o+lX8
 ieHK5VtNKi7PR03Txm/VadmPTb4xO88IR1hVMGz2SlHGqEp+wbtf4zWag+uLIFnYnyubVCl9xdW
 oDJTfcoXze0n1+It0Vkv9J19pDZBa5s0yN2PImJbv0dszPJo5oW4IcbdEBpjS7fQDkoianb1a3s
 5EDGRBxuQJmHKfAGVHiDUV7zDdq4iaTM2pDx5UYNiXehkrzCCIZI7Cib4XTg9BlFk770SoXlwQH
 novPhBakVO5MiXC4mxQ==
X-Proofpoint-ORIG-GUID: yjp9gHaVzYmX4z5Wi9KJmDPbAjSM0YEZ
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a135699 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: yjp9gHaVzYmX4z5Wi9KJmDPbAjSM0YEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10797-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,c800000:email,c600000:email];
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
X-Rspamd-Queue-Id: 4AAB65C3FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 73681bf0e3ea..33feb6d3f73b 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2070,6 +2070,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1


