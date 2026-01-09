Return-Path: <dmaengine+bounces-8168-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACFD0B767
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBE230ED941
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7C3659EF;
	Fri,  9 Jan 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vykohv77";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IvuTgpcZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DE364EAE
	for <dmaengine@vger.kernel.org>; Fri,  9 Jan 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977900; cv=none; b=B8ZmeJ0zaEvJXMjbVXcKfaaogNF3fEG59KrwIft1Xc/4pGwiUwiz6gDySvKgT9JYnugonbEq5/vQcwgkz9BF1gg+vqVI3/BXqhS1QzzssNnNjF4dNF572pVS+KcW4QI/B5Rx6Se5bHQeqiAsufvOCJRsvjWGgivNqfqG08DI57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977900; c=relaxed/simple;
	bh=hWij0Cx2nUsE3a6sV+TeED1rlFEQMwzrQCGei407aGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSJEY9CzWut2nnPtAmWjvRRPYOYhgw98LmYGWZjMJNOvYpxc29eQOSWZDV2AsTSZxm1m0IRPJyr5ub19WtSnOh1PM3kipVCLLeelZOiCGMH0O9koYyB5hBmMioR30nRoWORQ1W5br6qBGBUK/tCAXAa2J1VIQ1W/C2la2Jz+iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vykohv77; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IvuTgpcZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609CnJwG3542153
	for <dmaengine@vger.kernel.org>; Fri, 9 Jan 2026 16:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ADXvSV8kR6oK/joxnZuLV2sADvFjrfufvsAY5SEvyoo=; b=Vykohv77h7z1Of4A
	xXh/fqXuzRIH/PbRRIxfYdGGnxwMQUo8igi1aNjeeV6K6Q7c8bVeyJadWeXzYDU6
	PhWQfwMWtVpVsacS9iASx7ISQoQ6f4Zk+kNh9kzbQHxtqTQ7aFYv61QhOwwFgrUX
	+LZXegAPJkQj0Oq8Mfw2PT7WnMjosGX3u3ZObRY7IgEfWIRGR2aID4S7cBNnKbBa
	k5QH24HY9KzH3SwS+g2rxk0NyQn4q9ICWkZOvPDJfnLfFXO4E3fB1a29bB2te7VN
	kWMOMNx7rjBp7HvW8utlT0nd3BRy3gK10OCnA+E0Kdlhr4z4IKVYCRhyf8bKXKaz
	rdfaYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b2104-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 16:58:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24a25cff5so1310078885a.2
        for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977895; x=1768582695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADXvSV8kR6oK/joxnZuLV2sADvFjrfufvsAY5SEvyoo=;
        b=IvuTgpcZhSa1Pqx7gCjQ8vDeB8XUSArcGgVODYXHG7hHJDCbYAEvaFi2ydBJmiMr8o
         lz5Or1Mpd78KIDQB+X2LM0D6hwGD2h32mHwNiDJXX99efGzyYs3cIgELXYJ5gHDu/8cU
         ugml/ZLn/NlQnTpa25Km9LJr3a+5iKUf9anstU3v1aODcFVL5aPnuymOZ8iOm9qj9c90
         w9zOELhHdgYveNK73M+xl5a7nCxdDsd/c67psNyMJNs0rGpu/rWt/dM9H9Y+WJei2BNT
         CM83+qOMBxDnuU3eOTlst3l7xqcTtEnpRGuETVil00+MxPXeVk3+gWXEqm3cnrv0gr6r
         4Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977895; x=1768582695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADXvSV8kR6oK/joxnZuLV2sADvFjrfufvsAY5SEvyoo=;
        b=sUfOoYA9xblBudM56GlFQJMeGrWrG+DrSmgUXfMKGIq1b5Y9jFclkJfviGTCwyQUVV
         E1ZAmVyyWbLnYOy3OSls9apZCBGreh+jpfFZSrhzNlwQFE9+XATlwqpUZ9zt/n3MC776
         Uo7qTYH0UZhucxI4Au3hO0B00SHEYk2f9vOqRJ9+ZIt3FdrHxLQSQ1o8vWakvTEIY9ql
         IhJz/lFAQ05dUbKP1feFPSSslWR8+ys2gitP4dMpPFZ3NY99OYsq+MT1JCC7bHXFZlyq
         rT3yXd3Qs+mnMXWnfaNWseEcOqL2tgma7GWoJWgCWQ2HnPTSBC3n7gakB5gPHmpa0WPB
         e7nA==
X-Forwarded-Encrypted: i=1; AJvYcCUWBbS92tNMlDWcY+A4x0bNX44ATUkVcFZkTMSxUm1QMHzfMKauo8aoTZ9/AsdxBRqMNwOvHo5Z/sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ttBovHeKZNQB44aOn4hFt8dLsQN133Eo3U6NecOOvEJWPZ7U
	BJjmsFE+GxszAVjyO2vtMgkHCLBB+jjz0ETtfhMNFQdYR/4ImhopgXDffAyFNvIkHt6LvItjLw3
	4uEPp8cfi2koSGC14X/v3GlLPbGmCY+eXfyw/5bS6iEbqOta3YaDbKuro++xuJvA=
X-Gm-Gg: AY/fxX7XfASWrRSLvAExrntECrRS8MDBXUKZvaCuCth1repLkI+9S//2b6/JTQnu5Gq
	ezDW2yrCQHB8T6viXSyb1buTbfHTl7AS6SSYxL8HofcPMJEUBtOIB9VGWhm45RVLHP/BgMmB05A
	1Q42QXhYxa58+kTP03yyB2sdu5XTP9PaBiYwhnhR1heqGW30MyciZM03jcJQHwQ5KWpLkXySk7r
	gPWkBGxoVo+lzEDrRMUO880rumMYL1EZISqlbbF+HZhQmqLJdLiyw3BmA46joW7pUEUI2wYnN+1
	VrRQ3cXJvqkgAvaovrBl7ZePfhSZDlLaaWa/q/iWTlBUB2HuTI4tUahKwCzibAusZTIU8DaYvlq
	v98gTLWZHJ8ZMK4D3B7zVHpmPVHJjW+3jMw==
X-Received: by 2002:a05:620a:17a4:b0:85e:b7b6:81e2 with SMTP id af79cd13be357-8c3893eb55fmr1410579485a.50.1767977895021;
        Fri, 09 Jan 2026 08:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrBq7Oj9urWGrpAyGkXDWzVgxkYyRBhfKrUthko6Zes9haa8dRS5mYm1yWfIN6yIJkyYVWUA==
X-Received: by 2002:a05:620a:17a4:b0:85e:b7b6:81e2 with SMTP id af79cd13be357-8c3893eb55fmr1410575885a.50.1767977894515;
        Fri, 09 Jan 2026 08:58:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:47 +0100
Subject: [PATCH v3 03/12] ARM: exynos: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-3-c22fa2c0749a@oss.qualcomm.com>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
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
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hWij0Cx2nUsE3a6sV+TeED1rlFEQMwzrQCGei407aGw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpYTOTQudL3FhN/34Bx16jwi5rezq66og3KX2Uf
 nRZnoW0HkqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWEzkwAKCRDBN2bmhouD
 14y3D/4nRgbqVx8NtVKmBEK82/3qTuU14fmyZPVMKAzr3vodo9z/CnsYeX4Qs1/H+v0LL4bLIx0
 KAKUSyyY9ODpBcUTAjJN4/BIOegFdaaC7IjIAwyELLeBRd/3om/oSeas8xuNpggHee/nl+w/MSU
 xFz+iDuuEfBIiVSCW+YXK3KrfzQ4Xn4QuR4njXOrnNOSP8JMAQK+sDYahJYSjkFPhKFcDDbvm97
 R0VcxMpp3lbC+UDz3noSUjgLmlPlQOInreZDxRuumLEV0zvDzRuM/wJRD42VLh7gWw/NBBGu0z3
 kgjnZeMxSp+g+b+fPw/ec7Yv7MnK+qs9Wq+kGlESUXzmSB+Fsjo2dNVhyUCLcWgtG73zmT1MRgJ
 xefiuNEHNpvmWTKQK16hRQK2NL1qFwaz1JayxTJkQm3qAcOuzgGaczahlz7IXO53lQ6PVLDTVmQ
 EBFoOhQfNtnN6D3MfQ++8WB1kHf2Mwyx/RypZZ4jwz1yJ3qqmJEQQnfoGjprZ0G0ssDE7wGcabu
 hntZ1KDKHv9vqVhxYpRcY5WUvvajcC5cCbbVCzq/u9BdlVm3yum0xkaTKKIr8+EPGC/5gcJq6B9
 Hi+WNrkX7nZ9NkWFQSY3iXfuuSG1OcdSKgjIZjRnXw++nfWCpe/oMSiC3zukGykDljEPv8/QmQi
 gLVKlFqabwawcPA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfXygmqvkov3UR5
 iSnyrkAkio4Z6DG0rsMdNvVuYgZiKwbfaOG1no/FLqED+Wpv6BS+XZNTeIJeQoRtYEty+o+99hl
 re7ymoktsiKt/tZ6RbUbn/mdqBMnhZ3YKXBiUi4RQpKiFjg8OKJd2MMFioQ/0Rq5//2iIkScHJX
 9B2cWL6w6iZkTbmS2Y9yY2WInITMpmDsQhOqdAPm8usHZAOVZofvIJX1Xdn3eZ5Lg6Io4XVnm9H
 DLSnM2HmC58nc/jqWQPraYnoPgfkpkkzvDpX+vi7pKFS53SYrmBU6sQxRwwcgwylgsJb+CXE25h
 4AFRr8AGIvonoaSkEzr70Hxo8gB4GEgO5yunRIw5CQUcqqghQOBRyJaVZdgNlHEsIyuMWY3/a+T
 bLADlA3aTv+97/3hyhO3kqgxq/ncoS6u8RHgLHH82LLGj/cx/jFdkE0gWc1dEdL+XvxQoTumF/O
 kM+4kMhUwzj89lJPx5A==
X-Proofpoint-ORIG-GUID: TsmQc4je5HPdgRnTZ5glvbmrusthYxl4
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=696133a7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=75aRx82TGYjwQxWndmAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: TsmQc4je5HPdgRnTZ5glvbmrusthYxl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090128

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Depends on the first patch.
---
 arch/arm/mach-exynos/exynos.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2e8099479ffa..18695076c34e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -47,9 +47,7 @@ unsigned int exynos_rev(void)
 
 void __init exynos_sysram_init(void)
 {
-	struct device_node *node;
-
-	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
+	for_each_compatible_node_scoped(node, NULL, "samsung,exynos4210-sysram") {
 		struct resource res;
 		if (!of_device_is_available(node))
 			continue;
@@ -57,15 +55,13 @@ void __init exynos_sysram_init(void)
 		of_address_to_resource(node, 0, &res);
 		sysram_base_addr = ioremap(res.start, resource_size(&res));
 		sysram_base_phys = res.start;
-		of_node_put(node);
 		break;
 	}
 
-	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram-ns") {
+	for_each_compatible_node_scoped(node, NULL, "samsung,exynos4210-sysram-ns") {
 		if (!of_device_is_available(node))
 			continue;
 		sysram_ns_base_addr = of_iomap(node, 0);
-		of_node_put(node);
 		break;
 	}
 }

-- 
2.51.0


