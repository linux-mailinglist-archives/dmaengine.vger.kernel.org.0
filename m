Return-Path: <dmaengine+bounces-12482-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3P3yKR8KVmp8yQAAu9opvQ
	(envelope-from <dmaengine+bounces-12482-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:06:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF66753330
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:06:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YlQUfrF2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VkvimQZh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12482-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12482-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 831A43015481
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D646363C51;
	Tue, 14 Jul 2026 10:06:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900373630B0
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023579; cv=none; b=N4ZGzix8cLKjazkY1WJDVG2/OrpwkVFvoYp9N0o5o/smSpY8BMsUvTqDxwBxWbnnuXVLwNP6DADaFDaEJPRaczDHte9cUA+oRjzUhhjav/qY0PrJCNUBiv6Cu+XW/J9LgohYHRkignwsrSwEn0sdIS259WIxmu1RxdlcXY4DFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023579; c=relaxed/simple;
	bh=GYBtHdAfmrTdiirah8LRW7CT3SS4Dm/ZvWHw8lcOR9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHJQ1qh5O3hKHB5lZzIULKEipl0vvSYziX10EULUtgPmBOQcW/y9gYGnTyDZVeC3t0I5kHiz+jzZAsonZET5gSvpswZqSa5sqrHurfWsUydKVkjXog5Ec4CqIHTk8tOH5aW02poSytKsIkvhUjhRIXSs8cf93YsAcej8I5GfDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YlQUfrF2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VkvimQZh; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6Sb654005311
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+52xMxNLQjypHGjCHfpQGl3UABCxpAIWFYZGy+rwJc=; b=YlQUfrF29vid3f/2
	AmiT6GE8+d7TsIZ0NuiUUHGktyJMojP5+RsWJ62+EPneAzhjywyAQ2pci84r32zC
	LR1q0kLl2uysNGLti4M5IGCeXjIBUzxgHK0Um1Xl9ksoIfs183SZNsvEsWyKL29j
	nt6ebLBlJdeF5BVqVNtf/jBSPsCHy3gF4io7aonR2yWEweATBTvsQvODM9dSdF2v
	hrZVaE4fJRuoaQTCXWX4zh1KVqUkuRW5W8W9gMZ17J2LT+Vs45piRjzaDnbaHjch
	P9QhMneaCy+Ey2x88hqGKQdTKQtCX7igcf/ZtIWluc/fWUf/SgZnjiRsS/q2fo4o
	yIvdRw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44cu6ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so59969135ad.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784023576; x=1784628376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+52xMxNLQjypHGjCHfpQGl3UABCxpAIWFYZGy+rwJc=;
        b=VkvimQZhK3oMMQFR53RYN0hajD6ShZs1YmoVZzYOhQMRZwMZegTkb8k9dayXpOs7Ln
         m51ykmuYVEpx3DWLsea1phjR68FYYYiyI/qjI3Rb/mMkJEoKvHw4PeYyg/9+KMpua4Xi
         HfFX/NKK6EWnwtoEA7WJGypaR3+BP3lGX2EdfrYOU8yZfUpbb6pHIzZ37pENTt3oRgPT
         giWI3BM5ta0liiEr8QS+glRNq11ZolLf3dRhqQyY7lENZT74pYyL2sDN7WveRfg8n4WT
         1g2jibtHuSwiC0tmWVzLusR4d4Swoz7wGasIZpMxtAb0CzzVXsw+zBMJAwZgntT59npJ
         pgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023576; x=1784628376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+52xMxNLQjypHGjCHfpQGl3UABCxpAIWFYZGy+rwJc=;
        b=VKg9DQLU6/Y/TFkGZg9k/nwL5oETBESBeKpCU9OkIXQ68VBnwO07EeS0Suhe8B6FT1
         uK2NS8AlxU/b2LhZFNxAkAIjgJpj8KHzHX3EGj5Xf2XufMymeTxeUPLO68oPFFY3qja4
         y+KOJ8LpxCVeQIrVRX422MclNPNZP1HtrbNm0+7iBcFYBQ/QOMUTrS6Y2ky1yVtB9Yqg
         OhzZzwkm2ocU9t46UanklYURZjVE9ZAvrWwN8ib2/PdDx9ESgygABlZOg7vmqyDDKylU
         ADMZdkCmvNXmcooQ/EIqF8JTf7xr13hm2p4ezL7ULYLDJPaWS5r+mABorNQwAd9i9Yws
         lS6w==
X-Forwarded-Encrypted: i=1; AHgh+RoTF7OxDpfuIY3aHgpUsbEBl79VYrBUzjfQjaOT94v56qOymyVGuEikJLYkzMvtn0tXxHC1P8wa4mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7NRVC5hXVFZLwOWdklhZtSJfacuXtiXWY/XMRnUAvl7eY1Us
	w6pDfgo9LxHPM41xhiI0BrMO2GIjXaKfxbxUbdtYiZpjnQuwTVVeGvqYv7gN6JFkHwoPVqg5ara
	2ulj80h7CSHvVM5iZrCfnfwapWDvj6T6OghcZPe18JZZTO8Vpp+1q/au8L0N9uIc=
X-Gm-Gg: AfdE7ck8ZTrqvL+5VGnSX40TCHJUPnlSse3khEQnu51ObYglSBXTMT5H+T2gmvIPOBe
	MyAP1P6Rysiz/4YH07W7zfz9etiecknDefWalwXRppkjREdoRfn0jYoNCTti/X6V/ywAcGDQfMd
	r0btWasm6YwV4V5n6jU926gGkluFxWGL7B2LF7RyegALFOdcnaEfP3eGJHL0RACOHjxJ2eQT5QB
	VXc8MuTUbwDIcQ+1NyHIHJiMUQfFKHnM0LM1JERBpbH+egR0WzphakHkWeh4Nz9wDi+BLFkOlSi
	67kD+E8UM4/Iv+b8M06ANWy/0dZez+GaBvOAaxoJ/tIS6aicXj43Tgm3jXUyd6r6i1dleKfo/kf
	XEywv8yVNKic1ErgBurh5UKM03fAXZu+zVTQ5lSn+SlWb
X-Received: by 2002:a17:902:c94d:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2ce9e7aa114mr133557565ad.1.1784023575907;
        Tue, 14 Jul 2026 03:06:15 -0700 (PDT)
X-Received: by 2002:a17:902:c94d:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2ce9e7aa114mr133557185ad.1.1784023575445;
        Tue, 14 Jul 2026 03:06:15 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm112653485ad.19.2026.07.14.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:06:15 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:35:17 +0530
Subject: [PATCH v4 6/6] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE
 nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-b4-shikra_crypto_changse-v4-6-06a4ea97c209@oss.qualcomm.com>
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
In-Reply-To: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: lvDnGuQXQFWqtaa1NBBh2lZuQBpln-A7
X-Proofpoint-ORIG-GUID: lvDnGuQXQFWqtaa1NBBh2lZuQBpln-A7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX9cl9eX+cxJ5h
 aZtI/6yet+aocMUFEya1Dig0oS1GJsXEaHnGXvRFWulibJNRZ/VT76gbtpE3LU7gnjw2t1cvM1x
 LiRNuBPYhzaNTZKdht0lzaREIffve9I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX1Hv3MxbpbppQ
 +U33WHVp7DqNDOQ+6WeNBbuw5jqrF5rKKmVl1IX1O+uaG05MNmobwpjt0PC72Vk0pKBamK2/+iY
 kpP0nPTT2Thg7KlWcjozaX7716HL98YmFmFsGHUjmXlbLHPe89CLRBZldwk9kcPDWQrhAVAN5yp
 0szMLq380H5WV/+qcJihqtZhj+qUKKQTWAUsgWNhyTr3d2RA9F94wcsEUc4QhDBme+LGE601XuP
 I7NKEp06xbTCJYCgYrHOGGin9BEA4gBYBlftpJZgpZa1jsnfpvVPs8emi8pOziwpXd9aX57DA5G
 1eZVF43aRiw8WEzdy1jCfmlBpOIEt08qUxA2A22FmHwPjJ8XYNY6+CNmsJBvDngCe2QeLXE8Fdx
 RQYolMTB7vKQcz/NckpDRjJWGzz+wnJ9LNQBnAWXFSW4ZxheuFQCu5r/eMTf4xvLwirROm2tOmg
 BYnRzTIRz7d8qXi49sw==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a560a18 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=UqF9ul3sJ95V4vUiljcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12482-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EF66753330

Add device tree nodes describing the crypto hardware blocks present
on the Qualcomm Shikra platform:

- BAM DMA controller used by the Qualcomm crypto engine
- QCE (crypto) engine with DMA support
- TRNG hardware random number generator
- Inline crypto engine (ICE)

Also connect the SDHC controller to ICE via "qcom,ice" property to
support inline encryption.

On Shikra, different BAM pipe pairs (for example 0x84/0x94 and
0x86/0x96) may still resolve to the same resulting SID due SMMU-side
optimization. They are still distinct pipe pairs and therefore require
separate DT IOMMU entries.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 4e5bc9e17c8e..a95e2140416c 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -482,6 +482,41 @@ config_noc: interconnect@1900000 {
 			#interconnect-cells = <2>;
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9f 0x0>;
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
+				 <&apps_smmu 0x9f 0x0>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 0
+					 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names = "memory";
+		};
+
 		qfprom: efuse@1b44000 {
 			compatible = "qcom,shikra-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b44000 0x0 0x3000>;
@@ -521,6 +556,11 @@ spmi_bus: spmi@1c40000 {
 			qcom,ee = <0>;
 		};
 
+		rng: rng@4454000 {
+			compatible = "qcom,shikra-trng", "qcom,trng";
+			reg = <0x0 0x04454000 0x0 0x1000>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -582,6 +622,7 @@ &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
 			mmc-hs400-enhanced-strobe;
 
 			resets = <&gcc GCC_SDCC1_BCR>;
+			qcom,ice = <&sdhc_ice>;
 
 			status = "disabled";
 
@@ -604,6 +645,17 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@4748000 {
+			compatible = "qcom,shikra-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x04748000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core",
+				      "iface";
+			power-domains = <&rpmpd RPMHPD_CX>;
+		};
+
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;

-- 
2.34.1


