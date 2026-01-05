Return-Path: <dmaengine+bounces-8027-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5931CF3E0F
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F103430090F4
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D433A9D2;
	Mon,  5 Jan 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XWeq5s4S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZGiRR6B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A26337BBA
	for <dmaengine@vger.kernel.org>; Mon,  5 Jan 2026 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620073; cv=none; b=A8HnUyASg6asCg5QzdENmxvRTnAIUZI7/z5ok8c8uUhhaB0ODc5MkgyB+kW7ItiCssDp9QPPvurUiTLSfAEnw83qebP5J7twU53jfELsQWBIDYkJ08TL5aMrR6wbt7qr2wR0P4HfEI6wItF9LHjlgHOQoZQwohu9X/A0UMtkaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620073; c=relaxed/simple;
	bh=OVCWQJWSot2eG/7wK3qMzP+a9sG5lzn0vIz1M3MguJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiVEdFeB04nyuLrOY3JFvlcnHzi0mmO31wL3uFoKM+9xZedArqymovzMb5ztVfRwYKbI2/GP7m7g0pgbHd8rmjNk4m7k1V7I9lvRlKod//O+H/ofZVLvocDps0hXFO2PMpgObR2UwGoLTRr/C4MfLUYGDgTOGdDQBqI7O76Lh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XWeq5s4S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZGiRR6B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605A2kZH3541656
	for <dmaengine@vger.kernel.org>; Mon, 5 Jan 2026 13:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GQU5Kz/VgyQX4saHEvB7jD5Kcu9XiHJQFMsoC85Sd9Q=; b=XWeq5s4SwBY/Gda9
	3xTgtWQFxjHVut66+dBaXjRsiKU4gNBlppMhL44RCaB6DvVDCDQCgP6Sin/uuoAn
	dBgVtukRQmEt7++SPuwNQhs02McsAqJWyQWjAZWQGgICBfX9obwAmZHLV4GoPklH
	cE8DIp4HHAWlrpMfPhnfGQwOQ9wOnQDnR60YHBSF/WU5i0veL39urcU2bHxBxMpu
	QYGQDvLJlIji5PfwZomS4P2bB3PfZCNG/ynB+3IUKDvLe5KwKjPDE1elYTT3+pUc
	NNbWwi5bvoLIGdslAqZlxIRCpHmcekkvY5KAA0GoeADt8nG9pFgGNE7YmauVnYjr
	lBAVwA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg57shmcq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 13:34:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb6a94873so282773131cf.0
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620061; x=1768224861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQU5Kz/VgyQX4saHEvB7jD5Kcu9XiHJQFMsoC85Sd9Q=;
        b=QZGiRR6B0DDv6ZRdT1GjVvtelM5dHADY8K+WLTsktsCbSzjeZG29bKRmLQUPFkenWn
         fnoq6x/9fzVgYICiAKAL4Zh6z9Z6VNW65HtBcvWA4Gk0xOV9L+b30W44HZixvVb3/YNk
         bzR9UHnqHUwHat+2SjWfGPWOZ1bN8NqFu9FRDVtbhbJXMojfeF3JYvqFBKb8tYa+HN7a
         avjxhMUR4YTX5XGQ6R6+7aQqjK8so/0J1R4tMlx8DU1jT6Fk8cCMpGyiBNXkIk+ipBKB
         K5+ga2JG3l5PP7OH7NIKTeq8qpL4G1uTOTvbD8WNff3G69/umqrBMfqQb+PIX7bfeQu5
         ttrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620061; x=1768224861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQU5Kz/VgyQX4saHEvB7jD5Kcu9XiHJQFMsoC85Sd9Q=;
        b=XEj17jrAriwpkwTiy2khj11BFoi8zldTrMl49cE2mg+kbsPDjAAv3sFJGRiih72UAP
         1XCrvAC24zPgUPuSfv1q95UxWgpYT2vPJTlecyolDlpY6I0lc91+gDXkKxYkO4PXApfC
         XX01aWfOSYbof8wl5gOdnGprS5zzxvC8fR7P+TN5YwB8lTHx5iw2F4qtL93WVf3OmhXW
         quqSq7k8dJXGu6WQkIOSw31EKJ8tDLUPm8oqT/73fEW3lHnbToXRDUV2WYI+9RUPrEEo
         nmyjfMb4D5/MgswJ3pcjoXGdKJHHLxq/8what/uIuQwmjudmsgeUkna9Y39Z6F7OSuiJ
         J9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiXfLxUpm+5ub1xdrlNfM8APEE1mGd3zEBdCA+ZVzFf0tLTCjrUL5q2pX1WLDgTlQtRS3eCXD6/Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcedZMPeBact4PB7hwRoZ3O8l9ZrAEKioRD8dS5roTs5Poy4CC
	sjLHKZnFyys8igxl9+QBxCs0ZjclGl+9GMKWICSIgiQEjpePqrb6WUJiYuNQlCpN15py5f6KkUE
	wUlZQaTCOiBHIzsXn4av+MupE+CHLmLE1jvRxIUOMBDMlHWLy5AF3hgIiJ2iOlVY=
X-Gm-Gg: AY/fxX5DgdVW6Xo/5UQ144G1KFZ09RVxoCFznaoeN+Icqkk1KjzdJGAJR6kXOkHweLk
	HloCnXx6k2w2RsXH5AGinsJy22W1KiVfhd4vD77OmLh2Pv3aqcp+lvbc3lmrg/JbZ6aIDxdPAq2
	nxc0PElYiEllUR16izimLJ6o+UDnofZOi43ItRGW/0w3fkRSHz914dKPXx3uw1JG6OzS1Acvc7R
	dqTutTwnCTZKrNeR8ug78JfGOKaqYaU7IKsmy3ie3ylLNrWJgIg+Phb6/HVuNqL4FmBYRSYLqce
	3Evqz6ZzXEI770I/+aBTAW+c/ZWCvQ5bMm350MHohGNl6rAoV/CqUMHK3KnEXz454xlSt8oZyFD
	YaajwazTKhg43Mg1tRnyuXy4Zotk20q+qkg==
X-Received: by 2002:ac8:5751:0:b0:4ee:155d:b560 with SMTP id d75a77b69052e-4f4abccf941mr657072951cf.8.1767620060957;
        Mon, 05 Jan 2026 05:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvohOiETwplgpb7x0MhUosVavCMzgIVhmuUS1hAuC+K3fqYHLtDaKXS+BJRX6q1JcFTIgL4Q==
X-Received: by 2002:ac8:5751:0:b0:4ee:155d:b560 with SMTP id d75a77b69052e-4f4abccf941mr657072381cf.8.1767620060493;
        Mon, 05 Jan 2026 05:34:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:34:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:48 +0100
Subject: [PATCH 10/11] media: samsung: exynos4-is: Simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-10-24e99c177164@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=OVCWQJWSot2eG/7wK3qMzP+a9sG5lzn0vIz1M3MguJI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW72+pcoko1mnJ4T8CjzyeksWqs2tk1MM7uyw4
 JFwm941XT2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9vgAKCRDBN2bmhouD
 15rLD/433Y2qlSNgI4eoywUOZkUks4q0xTYlw1bGBpx+mFsiTiNHcpEOcYjeWfmdvTGx2F1cAgC
 cC+bCiy3spwz22ZAUVF7b//4cn5Liw649LSiRq47/JP47GivQs4k2TOrSl+ZOaAtzu5Q2kN8z7f
 zaQTrug2e6YbkeZX6qdinK/8Wnq74VvzywOtnQnU+2e83CZ6PaeNy1WPOzii/7m/AlFbptjbQr2
 I9e02BSTfPfb6yV7olKvuSHZY40JL2vjkftyY1Z5UkszPE/AYNPubhQcBEksDmGDIfpRuV2Hpgi
 4ixUBeKworGjL7Qk0m5qOnd/ZWR6fmSj0uTbkHOsMVUV1LKct5l4hkKeJzP4I0QYl1cBcrYXBQk
 rM21mJR6GGrWi+p2gQUI/XbGFQr68vMfIHoeOkCXgLUqRz0kef3xrD8PVgs+EfTjp/EVdnZsohH
 pzVjvBalpg+JAmiMo81/i9+dRGT68OE/VkUcK+lRv+dVFo9JAmRWb65HrK4gsih/Icave1dp/uF
 IxUYM7rbVQnxLmdDtG5UAS8MpiV+8U6pLTPl5iqG6UCJys5ATZViA0/OVAxGMcaLMNbACsllgxN
 4pk6C1UAeDWw+3YD3beZ6C/C1sO3pc3V7arSSThH79bzj8in9O0R1a5YLrzfiRBlhbby05633mr
 0caQ+z69JhZ3tBA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=UJ/Q3Sfy c=1 sm=1 tr=0 ts=695bbddd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2mm1MoeH4kfNTzOWiPUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfXxbdO1TVoGcJP
 KDzbKpNmCj5yMpgTyhhNdgxhCmAsGjOik8s0DBRY4cOwqCzzHgiN8LA9+UoOaXWCXJWmuM+jHuD
 JQisdl0cy3EN/kp6jKcG+81t44GhRIA3MGNUlCzhHkhakAI2l1EXmP7pBcIn0XMgJxr7Dm04ah9
 h1U3hQdVDgds+P2XQrkdz8PZwLPj5y4R9UyaJcz9qSSLEImMvd6xsf5DuVVscmmTIXcPKSIuQHG
 VBNPZdfdiNQHUItHv/MbUsCvsaufwNjH7jFSFWUJWyRW34bouE4j8+9S+fJEy6qlYVJKtCgsJH8
 VBimRItjSfioNL7/2P3uYGH6ppPjYIv9lYBirtiuaBDCX/Bu05HJjmCRfpQnsU3lNQ2uGWC0iGx
 893fy9d7MXB8OBGRJxVF6/IoA4NWyupZUbUtS72mhAPROHJgNW4NtNhc0Z9k90aztMU3suE4ZF9
 NWfPxIExbhKRRuCwA2Q==
X-Proofpoint-ORIG-GUID: aaSAcOTzwqzUN2G1hsPyDWPSjWoCOJ5g
X-Proofpoint-GUID: aaSAcOTzwqzUN2G1hsPyDWPSjWoCOJ5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050118

Use scoped for_each_compatible_node_scoped() loop when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch and on:
https://lore.kernel.org/all/20260102124955.64904-2-krzysztof.kozlowski@oss.qualcomm.com/
---
 drivers/media/platform/samsung/exynos4-is/fimc-is.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
index 14d84cc96831..b7d9bfedd590 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
@@ -200,21 +200,19 @@ static int fimc_is_parse_sensor_config(struct fimc_is *is, unsigned int index,
 
 static int fimc_is_register_subdevs(struct fimc_is *is)
 {
-	struct device_node *i2c_bus;
 	int ret, index = 0;
 
 	ret = fimc_isp_subdev_create(&is->isp);
 	if (ret < 0)
 		return ret;
 
-	for_each_compatible_node(i2c_bus, NULL, "samsung,exynos4212-i2c-isp") {
+	for_each_compatible_node_scoped(i2c_bus, NULL, "samsung,exynos4212-i2c-isp") {
 		for_each_available_child_of_node_scoped(i2c_bus, child) {
 			ret = fimc_is_parse_sensor_config(is, index, child);
 
-			if (ret < 0 || index >= FIMC_IS_SENSORS_NUM) {
-				of_node_put(i2c_bus);
+			if (ret < 0 || index >= FIMC_IS_SENSORS_NUM)
 				return ret;
-			}
+
 			index++;
 		}
 	}

-- 
2.51.0


