Return-Path: <dmaengine+bounces-8019-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB60CF3EC9
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 14:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 786323048EC0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA332B989;
	Mon,  5 Jan 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTmiAZ4f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TbUG2YSI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B82D9EFC
	for <dmaengine@vger.kernel.org>; Mon,  5 Jan 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620048; cv=none; b=fKGd9+Us5FMQw8A9LSux0+A5XvIac7beVYhKY22QpkyVRZiyn7ZYdZJTY6T+tAdnAFUgUg9G5ajXuJtUyLHzJFBBIeXRoEFU096FbqHiG8Mb9Lj5nN4g05Ff/N9W3DrgBXNneqFHizRjYhVxx0H6HbzgLOIeahjf7fg7Jv3JWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620048; c=relaxed/simple;
	bh=bfaPWC73VDShQNH2kIqzuF1gw0VIYTXqr0RY6cBFgHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKm/4H1aTYj9r5iz4mOwNb7TNGAbnrQa+j21HZJiHKuAA5YH2SlWGsayGgqLunphJ6bwdFALGUtsPMPR7hytbEiHMW8ZWQ5nola8n9bcEDXYGnWnmZE6ErjMvLHUT0RdRFMdr0Z0K6ns3wB6LL/ZAXhW7FhG6FXlm+Nd+9Po+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KTmiAZ4f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TbUG2YSI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058Jcpb3464867
	for <dmaengine@vger.kernel.org>; Mon, 5 Jan 2026 13:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDuQ7jwVyqM8dLR2MdkMFCrAzvUDPbW3eerEyflpSSA=; b=KTmiAZ4f2+7mqquu
	nFT7z/6wpZyTaieeceeiYqcTm/vafkPAOsbuyKb4qia21luKq81Ho7RQGEok7ToH
	72uPhEAazvSCLCb1sfg0AyvDPph6FH+1qchOZqxmB+QTore6vep26fSWDonl7nE1
	jNx5/OxUU3h2/Qx8WFZkXu+fu0FrOgreOD7+HNVyUWjGvaoq0HGKRHVEqH7zx+D5
	RHVd52Hou2ENiHHmQW1cA6Pc+riIF73U24qKtwMr8zo2+0Z37MYadOvlnuAyzF7t
	0KZrYkvRZ424xtzlYxKCdM1EEgcl8HsCeUHyhdhx8tk9+dOSUWdOKNCx8Xm3BAp+
	LGOHeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet2qvsub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 13:34:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee16731ceaso284714611cf.2
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 05:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620040; x=1768224840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDuQ7jwVyqM8dLR2MdkMFCrAzvUDPbW3eerEyflpSSA=;
        b=TbUG2YSIY3FV6J58Zwo26OKaqy9biPT5zAHAGCNcH43qRASHz8hO61Thgj25Yh20T2
         L3euAO9jFMnMI6uv0SIMxuZT9EAEOsO7K8vNHMT2TfvKP5YEX7CK2b8AssGvL2Qh+pn9
         lUv/3ZAcdb0NXV+tnbBn6UlLv1pFj8hb1cJSYMUIR/GOwVIFKXGAlLpZmITVOemjKT24
         rsB7yk3Nm8n9tqKwzWty1/6dHv4KAxcMwIWLED8z/NELCyod0QfVb3HGl3MG/4Ka4/6X
         gZM0EB+f+Z7D0afU81xoU4zZ2ScWCRWxO/Rib7LIyKvGsM9rh94NxPuyK/aeBfz5wz4E
         kNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620040; x=1768224840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDuQ7jwVyqM8dLR2MdkMFCrAzvUDPbW3eerEyflpSSA=;
        b=bjnCIWexyZoy3krnsPqg9Iq5q8RK9e8Sldu0ZVqmxEMdhhnQxXL9kMDz5Z9sRicTR0
         hm87ghXqHGXbVCyGxC5ZELCL9Mwsi3DxWzrxgA68acSj8tjkIRYkejvxCpuBTow3WAoL
         eEJp4zfptm9/mbglVGnwDdfP7w++OApJa3QocQqZxBJW9el/XRcS6JpLy9IwPrJLoXKW
         p52343gu4ki/R6Dw1bH3hqbgOB9OcUnGRSibtE8N16cIXkD1vJc08irkgNLhuXpNEXGi
         JM3+TfinWLrpzdK8x+w9s8aRSITS4mJFfw2IuPgoD733A2/2zQCUpL9IsFG5+3y5uQs4
         pkKg==
X-Forwarded-Encrypted: i=1; AJvYcCXgkq0zXun9TPayJmeS/NijlkBOXkmrsdCAWmw33cfgfXf5QRIp56iGgoyvpxwCB3w1uZiWW5h2Lr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtexaWawKYfud4ZOsgdQ4PV3lBQmlW/SFif5OFGpVT1awlG48e
	vQ/EbTFQhROS+EgAQ7172dl9h5NN0cS2bRWPtQAxRmPkJRBy8rVC9AJFZd0+BfrJbtAaju3vdts
	/vLZXIfBzB2oEUaxKac8/L2OZYvjw8m5WjXM0KO3mVt2XhvQ7SDAlQmdvvLc1nzE=
X-Gm-Gg: AY/fxX70WqOjTuHIYgIjPnF2yDE9zT1rpMsjWoJMhpkqtfIaFnTG6O/kfBBQdEcl3HZ
	gYz/Fix7zSw/7Mo2sSvrQsNo2yIxs1VZvEmEftp3+rVuLHtU+67OYuVr97LO4cLM+yvh82ZDWX9
	UQ6PF//OkYtRPpmy+GDhdQCNSqA32c0zVjVy+NgwKZu3vIrlX3OCVWx412DGPwhgYHZCArzLAIz
	cTnqJG0HstTtYeh0FVy9WI2/NoKHQiYc67zonVnpCN0kBB2JpPc/o458XRGX3GIno8JP7bvXaZz
	AKqo2bg+YUFyZ90lDt02RgkjaVwXAlcAvIUYQ3gwDfLY33JrHkdZdNr8AlMq5CrrujEyAOdcqbl
	RTZuHOzzr7wRKkgSxB2ii/BWkC8PRrIo9dA==
X-Received: by 2002:a05:622a:1ba3:b0:4f1:e8d7:fda6 with SMTP id d75a77b69052e-4f4abcd0980mr678978531cf.8.1767620040197;
        Mon, 05 Jan 2026 05:34:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+2uQzUVm47u56oWac1o+unOum2Uh65uFLZk8whT4SPW8P78l+PPnQGzRG1E7obagWs5+I7g==
X-Received: by 2002:a05:622a:1ba3:b0:4f1:e8d7:fda6 with SMTP id d75a77b69052e-4f4abcd0980mr678977861cf.8.1767620039693;
        Mon, 05 Jan 2026 05:33:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:33:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:40 +0100
Subject: [PATCH 02/11] ARM: at91: Simplify with scoped for each OF child
 loop
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-2-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
To: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=958;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bfaPWC73VDShQNH2kIqzuF1gw0VIYTXqr0RY6cBFgHk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW72343oLFYqnExfyIbIyofQ+4lJgORIRg4wIn
 LJNeUB+yP+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9twAKCRDBN2bmhouD
 15wYD/95pyYOAVcfEa979jYh09zE3m4X+5flU84acBvxVqaTD34XXFcK9Kzv5oW8nj1++Dikv+i
 D+55T4nth83xvP5ehkxVAE802+nZQ8oWC11R895v5omyeDUzQFeK4vxzXsR50vDpdeMbfD3K5rT
 bANp+cMheGhrvVS2Qddqvv3oOd1n52J6VX/PgHuGZnJb29uxF06SGT6MZWtcrW1DSzydaOWn2iB
 ju02BP25NgclvWYlqsqO/FAXRaqdcmfQE9aesRx6QCN2NWD3oywpUzF275EvPga2Pt1AkhM/tFY
 kRRxaWgsJ9/P8Grzs9ArlIH1w1TXPLeoWJVgwPod4/CR0mchbMJmcrBjVGDOpftwFBP5WM14e/N
 Rnd5dwuJjOXCqk1ZMWgRYb8mX7gYqitraBfNVufk5WNZDlQcRTkUueo84o6EtegrsFI5M9IsiDz
 oM+aK0lQ6AaclAHqC3HksEPslZQOLIcSHt3d1TZqSJPtHwGWUXUlb0AGTCbp2RZNXW/AO1EJJ24
 bk0Syf4125/6q3f5G90w/08kVg4jd1FXEFNsd+/GH6A0njwtwml1WuT6rju927e5IezYtE1RnQG
 Lh5tLdIrb1WNMXyyQt91khSZ+ovCrQVfT2CdkjIHqM5e9N8AZTTMnXpmejqGoTPqAQ2Pcq6O4mT
 OpwyEuBAKtA5MAA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: Bt4VOe1mrBjM9RnzE_vPqNvrDHqU0wbo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfX3PhaFZ6T9b8H
 m+yg9slV6JpR5W80kjbv58xqD7a/MBSz1CoNIdrnt6HUfhm65wLP/9pH7e7ZRtgScGKswESrrsM
 dw/m+UQu1Tld6Utz5XkTAijJZ4ndCeXlfJzO+OpHBHsBywbE2IsPAXTbTuVwTMvDj0isQPWBAzL
 efglk5S8yXx04dOsFbd/fpCtNPHkCwXtiIC/r4fcmGYdGMhX+XwfHkVBWdCw+/dQ7FFCZFc45t0
 AyoghyL9Z756CR7njSo7fx0dc+optH/jsx9H//6d9NMJP7YPVp+wGdCJEUsD0evkQbRN2zRqt4T
 RAyDyuIjOROQpGz26vdNZfpvP9zpGH0Cj959Md9PjCxRYKkuLRyvX0oXJCxPE8m/KRxbo0jDrZf
 Xen7okmqnLdjaDyzYgzUOvJRlJoQ7lciI4ZS6iQIBPNdpXtyxWtDJKsJbepkR3AQQ2mZc+8kaU3
 kmnFAnYmtZ6nUDRvBgg==
X-Authority-Analysis: v=2.4 cv=RKK+3oi+ c=1 sm=1 tr=0 ts=695bbdc9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TtkSn9LXl2vsqZFf_0EA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Bt4VOe1mrBjM9RnzE_vPqNvrDHqU0wbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050118

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 arch/arm/mach-at91/pm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 35058b99069c..68bb4a86cd94 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -982,15 +982,12 @@ static void __init at91_pm_sram_init(void)
 	struct gen_pool *sram_pool;
 	phys_addr_t sram_pbase;
 	unsigned long sram_base;
-	struct device_node *node;
 	struct platform_device *pdev = NULL;
 
-	for_each_compatible_node(node, NULL, "mmio-sram") {
+	for_each_compatible_node_scoped(node, NULL, "mmio-sram") {
 		pdev = of_find_device_by_node(node);
-		if (pdev) {
-			of_node_put(node);
+		if (pdev)
 			break;
-		}
 	}
 
 	if (!pdev) {

-- 
2.51.0


