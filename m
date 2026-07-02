Return-Path: <dmaengine+bounces-11954-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id toKSKQdHRmqFNgsAu9opvQ
	(envelope-from <dmaengine+bounces-11954-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:09:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D326F6768
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SR0NRDn2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Kwj5Ln8t;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11954-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11954-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 849AA3152920
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5848095C;
	Thu,  2 Jul 2026 09:51:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADC48124C
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985909; cv=none; b=ARTc84zeQEZ9CKH9erd/KDdFmc+8qaL1TQxOucR8nfDt/3Hu/z+iBM2MM/xfexIYf8dJo28EGqYOq0xp5Ups5I6OPSKsLAHqGPDXfvh0MXonea4abfxBRKaW87SsrfV/IG8KaIbm1lqUNpl+kMgn1uEo8Ri2tOPsTtsVQP/LiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985909; c=relaxed/simple;
	bh=ZtZsdV4JkXxbOxcKUCwhxX6Lrgj9McW3w3WH/d5uxLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4juGbY2oJonS2noJsXamfNUCygD2nI7E+7/V7BQjxME0N/qP4IX1rsB5mYwHatDfPT82u52mdFqXlbrf6okdeCU4acuFSEUGZtgcjQK1gEKqjsuVoUAWLSpmVsXtxWeeRmLstIC0H/S+n+Q9Qdyf7/bor96F9FDV/DCaKfqukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SR0NRDn2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kwj5Ln8t; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KK5B4115146
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zlvi4GBsjhcL++MyzJOh+e6LH6/D7aaIomb2JYpGLck=; b=SR0NRDn22lvQw/4x
	iobZjKk1eDXxcfnFV91OcbgryKNA+zU7UWCE6Gc0atJjFoOW7a4ZZzMaEVtHYrEY
	+T9COn4qyMYwPO+2r9tCYzMeEgvXqpytCNYLRVvY0ToP98yS+CgGBzPM7Z6UEbEH
	TZJmsLPGB1HJWxNwHmsXBf5eHsiCuEr5w4at6SQbSqETsd39Unn6CNdHbAd+c99n
	UbrJKV64QaBKrRLa1P6DwtF4or/7sY+9IDEi8bZdlV3YDHOP5iUWUT7h6MTT1v5+
	DNzjevcW2RvMkw6sxS6ecOf1ljlXfX1YfymvN1BVUGWt8H7TiTB56qzqr4ss1m3a
	ntClyQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9403ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423f544944so1293777b3a.3
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985907; x=1783590707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zlvi4GBsjhcL++MyzJOh+e6LH6/D7aaIomb2JYpGLck=;
        b=Kwj5Ln8tHb3OIAjyBOjXQV8hZYb5U0vUVHWTLUiwpXQG8xI1x1dJehqtZ1PFdgxF5n
         HsyCBtRKFQTJCIhqux8Au47k5sJZpts2XWaS5Lo6O5ogVf6QBKrIqpyJj9UIYXYyMxBW
         DUkK1WFBTCrgjddOcp5IO5S2iAJY2pkv0moipW7EKGCaB7ICiY6u6gUve65/qucQfiYF
         P8P+Af8wq/89uyWczmZ92ZVR9kyXZlPinQWb8b8hELtIODr2tl+JuEtVa4op4amIOQgv
         9IVG4baNloxUjxK3E+N1KGAWcPV3UCAYpFtJs9yGZCSAx7+nDLhhgcpEW7J/EE4XHQi8
         NNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985907; x=1783590707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zlvi4GBsjhcL++MyzJOh+e6LH6/D7aaIomb2JYpGLck=;
        b=riBKy4JCAB5MUJfYRGn6EphE+oYJkoNvRt5dGir/XnsWDLhuDjrf6E2d3mNq+nsKdC
         0orRPuGE+9Qs9hxcKH60hvmjSB3GEU8Y8XGRNjfHFfbNIXyhoJF81FqyqXIzZlRp5/8b
         /piPKHv7lCx2xNtfcsmQbUZ1EMl7C+G5UG8vCjQR4pGRHKQm1LCreR1FhoPchEQfoaFv
         sm7aYUWbVtWvGg3o1Uez5OJ6VZ5zBGYQPv7eGSzJ0ZbOBS+LHA+QvcBtk4AedgeeKIfW
         ghc96QRWQQbKByq1pLBCK/sxnfq3r04aZAFk6jvyPHsuPX9ohZw4wRzE3IIx2lKWnMp+
         w8CQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrw3UpkbnXUcsXre8/iKOKAFI6gU3rxe+7xJM8HrXPLUw7jU2aDS10+wCABqQB7IElr7A/2DDlXvvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkCQpdInxPuRTwuQjusGAE+TPNQoUdVNw69WhqIVww3cgQP34
	uWG+ZYnt0gQVMGd0YmNCpv7Fv77BkrKkv9COM8IlM6nIjc9TPXb9GfpH05O8QZZFyBuyYGWEpgf
	VpaHjXKlnM+94xn2Y63J0VbV5aiqKWEP3kd6U/lrSkxk+yDB71gNF6ALIHBdKg1Q=
X-Gm-Gg: AfdE7clxcIXwM54S+9lZ1hB/NaTN5/UxSXOj9QtdZ+1jBE1ANVuHimvq8DtbRHNwGdV
	PaHIO6JmyAbcEL298H3vUT8aBcwC7CWmzNseCiNo5PwBep8KDq7zeQGc7SjLN82RS85FHsrJol2
	9OAfxeAuYRcrvTM6ZkrR/OO8P+cAs3N9895ydofdMxeIsuWi/DiFS60xE+0Xq/FX0j/VrcZ145w
	LZBrzBq9pz94wvkIOxqfGKqZ5vZtMLHjMZu+Fsivi1RSJfkAnmlJBBNGiQ7Y0Sz4vLgffR/k8EU
	5KhSBB15jFNGt5b4i/caEzuW8XG4Eu33veeKcCXyc5mKsvyyTcMlJVgxUQ6SAC+LkCatOQGpI+J
	voCZ3IrAQQ6ZMvLrYAGBdwJ7HeA==
X-Received: by 2002:a05:6a00:3d04:b0:847:94bb:30db with SMTP id d2e1a72fcca58-847c51b72b9mr4232458b3a.49.1782985904107;
        Thu, 02 Jul 2026 02:51:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d04:b0:847:94bb:30db with SMTP id d2e1a72fcca58-847c51b72b9mr4232416b3a.49.1782985903508;
        Thu, 02 Jul 2026 02:51:43 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:43 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:51 +0530
Subject: [PATCH v5 09/11] arm64: dts: qcom: shikra: add WiFi node support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-9-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1847;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ZtZsdV4JkXxbOxcKUCwhxX6Lrgj9McW3w3WH/d5uxLA=;
 b=JHIFUjwh8ZTgiC3GBrS3iPiXG1b8RKwl2fVzZhOo9lgtfDqizMApzLt58p0nx33cBYI3mp1fr
 lfHfzqFj66jADU/uSZVWcLxfQnsVAEg6+CIfIDZhq296tyRrYgjsyvd
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXyiJVSaAxY50f
 Ga5VsH6vODUpadKWl86/EQu+W94etMZ7XvORYwYlR8lYyGJqpMghr2kg0VkiTTWQ88CwnnBsvUx
 P//IGZ3nyB693Yr4aCou6hf6tj3VHGKuyrIucQAtuzvt53oY+0u+ddsATrkqHUzbCmR7+rOlWxU
 Usx02FmdBzV1WRGBxE0Ws14Bg1NWhtaUwm8vuRZgzoqSbc3HZdSHlk/9hHw+0zT2Q/lgXKAttdm
 bDUSeE3AmOu94GTdLBZCyVVJ1/gUUZmSODcc5yA/GvcrA2yD2frk5slC8HYHdfmDk9uO1GYCLEK
 sNRV6MICqaHqvylitsQGkZ8XNCTB0Vb9/KVkmziDeUMFimxVOiby6gd1afiE9r3c9TBsftNZRdU
 KAq61XY8neEZdeGFKvYDWY7Wu2CEugcgy7Erp94VBGaWd9bspcCi8uVO9T6QpeNW6BgewLKSGW5
 G5rW+7VWHCVbNVRASFw==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4634b3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: gV3ECkSgzhEsMzbBm5r6AsCk4Iru2IgQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX85m+7a1jbcPJ
 1J5awDBWkx+AsWZs3waWCYtlPTnR0lenpsbi5SMfyoSVVgl0ibI9FJcrSYt230d5QN7tDxsvdnS
 K3Dcnr5YA+KoUFYS2/hcVtq2I5cphaM=
X-Proofpoint-GUID: gV3ECkSgzhEsMzbBm5r6AsCk4Iru2IgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11954-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D326F6768

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 3abd0a686d0e..205814c4b349 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2079,6 +2079,29 @@ apps_smmu: iommu@c600000 {
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


