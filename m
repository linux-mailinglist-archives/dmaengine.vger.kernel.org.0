Return-Path: <dmaengine+bounces-8169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E083AD0B78B
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480373021F88
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D228313D;
	Fri,  9 Jan 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TrKzJhB0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjX2Y9Ns"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48A364EA2
	for <dmaengine@vger.kernel.org>; Fri,  9 Jan 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977903; cv=none; b=RZjUAipZa8Os7ZwtDYQywP5s/iWrnXIRryDSwwaFmhlByTF7FVOJzdKNIb4jpUvmLe1t3l1tRFvvNqLqrwCgBXUrggxw1cnrVHX2czbaY4HmZlc9zTVQaMxPk76EwwkbnPkHOURsIC3iHHa2cKtRzu686QciUk6igWaK48n2AoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977903; c=relaxed/simple;
	bh=T0iguywPlMIlSsxDnFb4fp3zFOJO07SWV8Pm8YIMsCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaucL2a1CvayaAZfL0y1VyFEH9nBxdGGrJoBB4Y4CQ9O3otT2pQ+e6336B04wnsYScoxhXur00QsxJH6nyydq2WqI3mHqE5YAegYf6VPLt204WoEKR1Ae+02BSVsgOqRQtRsmepGKrdP3RqVkEGmVybQ7ir1TrMmNkrRr/GQjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TrKzJhB0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VjX2Y9Ns; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609ClUlB3542105
	for <dmaengine@vger.kernel.org>; Fri, 9 Jan 2026 16:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZY43g8OUARiRqY7R9ml/55ZrYNP5JqsZS+eT8CaDSWc=; b=TrKzJhB0BPjVRZA5
	9HXeD+qqFANtO5FgzcPUflJJjsJPmL+iJaZopRqfyCmZ0dq0S/5iw14XtqHrOVgM
	4MO4vkkaBoarumcKSw5Se5ySi39PhjzujAkIjNf6M4uC/iH2NeGQWYZBPqgu5Axj
	6Jzyu6+djq56Q6do6Igt7/aNaLpBSvENldQireaPsTCDbDt4T+H0hHoB6jJt4Ucs
	CUn9EDyjfO7I0WpuJ3hezEvLPhB3lNfAGjRLsPX+bRz6/MoDRCWK3PYnff+6X4/s
	NZhrDeHnw4NdZhSkx595XpdxqPSfHy+/9h+vc0cnmB9eoTjX5fy12uMpe0V5g6o8
	wreOxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b210k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 16:58:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b51396f3efso821645485a.1
        for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 08:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977898; x=1768582698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZY43g8OUARiRqY7R9ml/55ZrYNP5JqsZS+eT8CaDSWc=;
        b=VjX2Y9NsZBWS35A2/RoXiM4Mr0CSfzA1LIwxzSKXtBiPw9UsA7AbeRotAbuPKbyrVP
         /gdjz822qRfT7OjicASG2Nxt34ApHdI8U66pTkVEGh1R9b60gT3IaUTkGZyev7h92wXG
         RH+KHFeV7iB5NE0OgtgsmMVovwHTM+eeJay6tJN3/tc65rBXW6i8f3f7wLA8wXk6V9wX
         a8qQbjV8KOOVCg46k6A4a2uX4EyeyzrUusRtxDBqMQ3r178EbEJfXfRRsfz8gPrUbI1g
         q1KY/qm+tWmfxZOxi4sX6QGuPCXooh/GlJOHuy3M7KSKJSkjQ5KVuD80A06pmn+YsRVq
         3Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977898; x=1768582698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZY43g8OUARiRqY7R9ml/55ZrYNP5JqsZS+eT8CaDSWc=;
        b=Fp0+aAyQWslVKrDUNF+UJ4bHyeJAVOQ2X6gPFzlRX0m4+93bpPiiOLpI686YAeq4RQ
         1CkG+RJ6Ez0fGcQmYUgAhSkRQQi+8Wu8VgRAxK6dAfnI4gFsi3zKhItAQNKr65K2Pc9N
         GLUHtpK/tOwDY7ZN1y9FmhJHQcmIIwbtlhbKpzcG5JugyBwqAXYN2pKCuKwYU2HgS9/y
         KxUPENEPM0oCEsWdCwIXlU7QzOc3sK3s2bwcuHAUw9EdwXiURuz2qs2WsmdbY5AwnGdn
         t9UCE/RR4grckiFC0wUatbcPuVUqsBVAPE76UUcalaloD//np0ITCBOpzi2gtwxRuDg6
         KDug==
X-Forwarded-Encrypted: i=1; AJvYcCUcVTHqZ23DU61P/Au+nf63Fuf/7q5GZLEO34L0/iuKpYF62Pm/QRybJ3WPhhMPmo151UHd3NostDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8xjIVpR47Jbc309RpURhrVPBPEjREEke5VGQXwS3cPpcfohr
	/0PywmiUbMtkoAxSryOXSdIJokRjt6TV9QuTvVsO7FnAmrIMB9aA1bMiEd1hVjzQ/unUpzHWJrY
	FHraKCDSrP8Psaeg4YVh6cGJW0j1lOvOem2Jv8ojm7fsr/uN8Aq3GTdXnNXHnlwM=
X-Gm-Gg: AY/fxX62Fd+DKb0X2G4su+2i39xCSZOVD4K9maRZdENvlmdBXfpSDcRII6HvMGYRaF8
	uJjBRafXlddDRRg2UKhI1aFhDVAuYh7mX42lk6Kf4AzgH29/mqlXX7X6vD1aLYzof6X4XO3oJ3E
	5SO76ZK4eB8YZoP6k2aQ4i1mW0j+M0go50dIwxFy/HFR3tNrFrE7Jp/JW7kW47wcwnLEBAySmKN
	vd2AtWbmL7WFDI/vK4PrCBG0+LFsKvOHruCP390/1aIhlCG6zhKx4cqaY/M5hKcBSy9P+Gtvdoy
	WXo672U27FQwhPyat2xCQuOe9n8zPf63PxiWHm3Zspo924yE3qne1HelY/mTKA48l/TP7GkAgNf
	icc0GK9edTsKl7Q/7iWrPfNqkPjrPZFEbMw==
X-Received: by 2002:a05:620a:4626:b0:8bb:7dd8:1922 with SMTP id af79cd13be357-8c38939d234mr1435776685a.40.1767977897629;
        Fri, 09 Jan 2026 08:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWFg16z7KscX7Y9jM28Hrz2EGd5LC+7ZiK/jAqogZOUQ1S1l+udCeLhRKjK2FRyHwECsbjsA==
X-Received: by 2002:a05:620a:4626:b0:8bb:7dd8:1922 with SMTP id af79cd13be357-8c38939d234mr1435769085a.40.1767977897126;
        Fri, 09 Jan 2026 08:58:17 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:48 +0100
Subject: [PATCH v3 04/12] powerpc/fsp2: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-4-c22fa2c0749a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=T0iguywPlMIlSsxDnFb4fp3zFOJO07SWV8Pm8YIMsCU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpYTOTq4JLeP1qeYnJbbJLJHoPa3XUUF+q1l3Qm
 yHiiBECvReJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWEzkwAKCRDBN2bmhouD
 15CdD/9iKcwGZWr1TPTh1N8VgCg7pZ1MqIHopwRh10bIppgFfKknY9qqEgNJPMZtoa7VsQyBmMv
 oKYS4n2YHL3iPteJQF23gA4VqXj3G9RMN534g7OIvdOY1VJGEBQSl+S/zcv9CHL3/AM+Wgmr+GL
 SXGJvW8MORgp/6Fa4q/5EmRaJC7kuOFxfahl8sPf7WPKy8mPBpKzNEjyl6rH5IE3q8LDjHRMKie
 9pr788DrA4sTL3SEHINAg/agHf6qEM/IdmpIdrnGJMPbgQ/K48mKbcUFljA90vB9RbjDVdnQ+CB
 y4A+2bS9CVv/G8PivbgPctgYy7jtlcVbrNDTl9i9dKYHRchMdVRI7WiEIKPkbvC+v/9T32y9Yy4
 kYCl8DoUvqCJnfzIpCLnSy5EjuSlwV0LaR2d3KpFeQ6GcsUbpXWB4IeXGck635nvlBKutve/vVl
 Me/ZHK20+Or5+fP7foZ0RyVore8ucmE2QIScRBzh4+NBll1cn0luUyCMBl6u4UpbPf+EhK/D5nh
 y/wYpkFV76Bk1oPhj3d0HC5KQ5DX8TKVBFNz3PV5wq1PP2+qTXHFWjv0g3pn8lno5WN0520upkd
 vo0VjbpyCbLmimtcJE8uP+nLHpKnR5WjDlttXt/x0SfIUhk4GEeaUAgHStwNI/UeGDcgWnbYFF0
 L0NEdtwx5ztHplw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfXws+bVxFexbOc
 lK2SEE4iIwZeqg3QuWLdn5sh8IDZjXo1QAhYA5sam5s6nfk40ikZJ8O0z5L2elbadlOr2tF4jD4
 uuf7RNFedOH21FB6brHjOXlHmElBNnrTfLxoEoCq0ag/yFBSA1JzjgS2TF2EwZtgjd/aUOeZkMj
 rtlv4tOA+pE54UDIaN5LRs709MxWLJP8vdWwfu4bX7RxqQWo5aSGrWBepGhpU2ryb2Ql7oLdnx+
 b9UkAU2Cpqq0yBcExvvrScuCJhdFO6E0WWq7kyWVsfxYzDmAhmaOOE9sY0wlhpjyKdhVw/KlRtS
 rWCUDYElJLJwpf4OkKspISorHaxG5NSR9v75oCnPQKDaYYmfMxIPl+DLojalYz7bws4bbVQrg89
 4lMTrtjHW9AUgUsrR5qGlE4G+1POZFLwiwv60xG8m0QtcXtDsESwJ6DqUWe3eIWLET3LGuqZlMJ
 yVtCMZHiNTxginzDECw==
X-Proofpoint-ORIG-GUID: _0bqg4ZFU_EX_uNdwSZWUZeCT_V0H2ZZ
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=696133aa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=bRA1xQHzFO3ZoMUYUbgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: _0bqg4ZFU_EX_uNdwSZWUZeCT_V0H2ZZ
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
 arch/powerpc/platforms/44x/fsp2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index f6b8d02e08b0..b06d9220844c 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -199,16 +199,14 @@ static irqreturn_t rst_wrn_handler(int irq, void *data) {
 
 static void __init node_irq_request(const char *compat, irq_handler_t errirq_handler)
 {
-	struct device_node *np;
 	unsigned int irq;
 	int32_t rc;
 
-	for_each_compatible_node(np, NULL, compat) {
+	for_each_compatible_node_scoped(np, NULL, compat) {
 		irq = irq_of_parse_and_map(np, 0);
 		if (!irq) {
 			pr_err("device tree node %pOFn is missing a interrupt",
 			      np);
-			of_node_put(np);
 			return;
 		}
 
@@ -216,7 +214,6 @@ static void __init node_irq_request(const char *compat, irq_handler_t errirq_han
 		if (rc) {
 			pr_err("fsp_of_probe: request_irq failed: np=%pOF rc=%d",
 			      np, rc);
-			of_node_put(np);
 			return;
 		}
 	}

-- 
2.51.0


