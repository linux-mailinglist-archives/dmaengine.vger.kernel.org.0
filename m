Return-Path: <dmaengine+bounces-8018-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EECF3DFA
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5D7A3016F88
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532553128D9;
	Mon,  5 Jan 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HpwB7a+i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDppoon1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008C2C2356
	for <dmaengine@vger.kernel.org>; Mon,  5 Jan 2026 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620042; cv=none; b=Uq0HZ1D7sxLBgKhZuaXhMZ173HrJGyb8PiYpKRNSshHp+oJM+zBm9qKwKc92nPSFRfo62yfPZj4cBM67RXNB8flXegMEYXooFtCsRikoyFers4yKFZyG7ea+XHi5Kaylb7gsL2mixKStXnLX61Nrjy2VGS+YKCk5lnKqrOJCkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620042; c=relaxed/simple;
	bh=GAS9AEe5svij+iU9HSZ0g+GWVfBCriapq27kDniovIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlcmwgzbriYOAhk+X1XctArSZkP8iXn/0Ek0ZGh4wUSNYn2rwstjlVFEY+3nXM4nSZTmOXjIji1vQZ3l8N/NuSghSiZlDCMhwTTioQKC7kcDY01PN09H85vY1165fwFzayBZLVEDemD+SMadGLQ2yP8/AuwJiEQL3NnT1HsOx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HpwB7a+i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RDppoon1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058Kr6K3655686
	for <dmaengine@vger.kernel.org>; Mon, 5 Jan 2026 13:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRm9jmTww7VVgDoLVcF8mMh0LdpCo6QQ7D5Go7eNjzA=; b=HpwB7a+iAZkL1k4x
	s3UZKic6MXZgtLDFjUUvN17XE+8wQX3uis3IILFluMqIJjirnkjq9KUIyCrDGFwJ
	w+lCivFopT9AAdAfMRbbpNhmoCetqaXH/KJ113RKYAJBAjaqaK+DMplCm6ocFC78
	SWTD9FZoub1NQBMw3rH03kIrWNG/bMVph0VJG5G+Ed+z47cykYtc+nhPYbql4LEW
	HbbtwlIqGxwwngxqe5DqyzoemN/xIjvVpbCVhk4S+eL8qBZK5g/F5ON192UUgNo9
	dvfnUiYcZ3RKSWb1diDxToCjUUWq+UGvflV8+vdBsMK7dHF6lXIMKnttSTsuyagQ
	m+t1wQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet2qvsu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 13:33:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f35f31000cso193782081cf.2
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620038; x=1768224838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRm9jmTww7VVgDoLVcF8mMh0LdpCo6QQ7D5Go7eNjzA=;
        b=RDppoon1ehRugnFNWhEntsYRgtGqS+EzTICaL20OlUwMRuvZZ2x6OSOjsWTuNivTFZ
         1hNd7eDZ0MqEeCYFZXznQYiosFtglndHvLh5+DweQMd9gZvTxzykw2e21JJUvaD9VSQx
         GDqSzkYeES2LmSBccFugB+9X81YIyXc6NOVmFPj9kLdzc/hEw5n38Zn5mELmvmcJzGT1
         oB5NevOJ5hzSjjqKlC0TqBY+LNLxTXVemW9pnFDlQIhz2p6r45RNls+h1ty2323RZ8VK
         6KjWAKZkipt+NO0s/JJCplVXfzmilGDQkBTDtUf93a8bF+TJYX3c3tXZiX46Gs4EZxfL
         bzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620038; x=1768224838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QRm9jmTww7VVgDoLVcF8mMh0LdpCo6QQ7D5Go7eNjzA=;
        b=SyTZj0bxk41Kemrd9XEUEEAKnZvOVR8b/QROLAu72m6oRkTgZN8Bl3nurwrnN7AmBc
         xxO9RKqWJl04y8fXOvLINbAk4nM8Ir0e9OhDaxiE0UUvvF/rQ+AFA63CaNgNGQ4rcTRO
         153sLzfeJdremk2ceW3W47CsAAC7zpf7Z3JoC4XFuBZd0ylAFQJmdh0qmS8yp0emcPUX
         YierNan0A1kdIMN2HPAYVaj5HoiWOt/Lu0Vq4uHWu0CvfDspP4gd9H/GNNjw1jxiPZiw
         TbAKbt2GFgmbgWrfKzPQCNhbaYAkhURiMxK5kfFPo79429nyP56Bo8t+uVIFRrbweBph
         AByw==
X-Forwarded-Encrypted: i=1; AJvYcCVJWjl89A3sOOL6DTIDwKPEs5BBldnSXhpFt+xGC3pU8C7n9ywBdcUZOVZs9U4wvqRsgOfapqdOUc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRX1PsqjgYXZRiUuRkt5L+NO+RxdlRIg8MIqUfuFXpclBJB2C+
	3T3I0qC9GOS/bgWqwXdAutQhACTffiLlMVpuYqc/Vx4g+xqAz+3meSbEFUBflQHSCdJnTMhRNHm
	y80i+JDuuQoVXjIiubG03YGgcsXiqf8tEukXh9SJq1vl4qZs6zWiPQ7uBXgnyA1c=
X-Gm-Gg: AY/fxX5lPtcDy+alWM4maAJwpTAsRnEsfWzHpk1OOnpvmXc1oJG1Wf+fKGvt/5Ia4F+
	rxEA9eLT+mbqdtmxNYtaOhaCxJxH9sxZ8x90uJO9uK2egmmjYt5HLPByPlnkf5Qr8MRK2pRC97o
	tlZfg0UWqh6ddeOg3rOEvXXmNOP/zFKJ4FIYtec7ccUhOPn8AgosEhjnPxOF1gpt2+9Hp8eDgTx
	A7OlLqyyTCQqaIx0MbUrIjWO3n7WED3R3OBG9dkuPGROC4xsej8Zoxw9T8qPq9Y3PntssuMI+xE
	vRjSrHPYrz6QBwr4iNlM91BogbIs4+qOns7RNymsSrgRZ/arptQP697kcb9vGmEvefdr4Pr56An
	7u7kg2GIkAIejTZuaOzmGJNeQEpWVp+xIYQ==
X-Received: by 2002:a05:622a:480e:b0:4f1:bdba:8cfc with SMTP id d75a77b69052e-4f4abd942dfmr763072591cf.65.1767620037890;
        Mon, 05 Jan 2026 05:33:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXQkdFy+C8VMCsuzSjjG/gB7L6UA8wdH00hVPMYjUK2EJpc3FaxCWzsUTPLbxXtEYVpT4NdQ==
X-Received: by 2002:a05:622a:480e:b0:4f1:bdba:8cfc with SMTP id d75a77b69052e-4f4abd942dfmr763072071cf.65.1767620037276;
        Mon, 05 Jan 2026 05:33:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:33:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:39 +0100
Subject: [PATCH 01/11] of: Add for_each_compatible_node_scoped() helper
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-1-24e99c177164@oss.qualcomm.com>
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
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GAS9AEe5svij+iU9HSZ0g+GWVfBCriapq27kDniovIo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW722LmpKz6ga22yVNigaxc6TbG9MFhD0lOLYz
 7KcR095lKmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9tgAKCRDBN2bmhouD
 1838D/93vCXd+UZrPicCNSlGq0pDKnZ06PbiU5ryxUc4AR5JcGFQz041BCQ5MQfeOzIBlHThKzE
 akOLKKjAfTtHE+UfhdJzn2EXuHduDj3kbSkhi9/HR+pPEyZDcH7uHCn7mcIEtryrN5z6MzTzQkc
 /AxXVgKCr2N33F/AY4eVdpVPIiCYHk7Rcb7xs69cEeFgkNFFzC8scDEayJq8Ijy43NeBkiHHL89
 hpmE/KT4gu/Fkl8QUkxldwLMP9SqvbfDrXsTkt4BWiGM40zzIWe2P+xYjqs3ckIhVNIIX8gO0XS
 hnMNRXTxZHe17ZJgVclUuGVZEmoWoEH0iVxOiUS8RIN0E38lj6LFICvgQESkxmBzVRlJvHNnNFJ
 1rNigrMb/Xrx0MgSu8+VcKRKB5IVpemev7bAmGMuZFYzP/nfdKsFXDRpUzl9mJkV9nzAtqrmN/S
 VcV6jhBDOq18cIxjBk/hr/95kstkCb8jld23pYvf2ebPDIdlkFXVNBNOerNtZWBbmGBFLidmpUV
 CHm7AgPKg8LscfMZrKZyl6FNKScZw0YkO5RIz19HyBrq0Gh1nvdsccqFlRVa5rk6YoUNrMKy3pG
 ygYnP7LfU1nqPXDEBnkl0AQnb9Se8tdpGrNjNtbff/7bOGrGHVAIBvJSI06DriCEf2ZpHh2RtLj
 SeI2gkRt4EdtVBw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: g8CbyLzBkeWnW4iHI3Dt5rKNlMdyDgOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfX0SCYVhrpxIy2
 7S7GdyeE8VtJ+n6W9mAr1lEB5DNnpRwx2fuCMtRyHG5tviSmNRBwIhmW7hDCEvuVSxUQTW+LTMw
 112hYXAJCQofO33D/9k5uVevjMY8jFUaTAzeQ3AQV0omyCpBsRVn4gNapEnHNzzvDEkPzrpgc+p
 2YND3iy/KI4gEmnM+nqpQ56tzaguakebne8HgZoD5EAoVxi+c0/rpUoISvHUCpax/Wb4QSHqh86
 sevPsUNnBmO3/QpLa2OSkMAoh4tdN15L5f9MFKf5k2PdcxmlgFhFIeDSeuGJRsOADmUZ4PeL+iC
 WiOiiP044HSDwbEYun9dXuDoheWmjmxfzkFJre33TBkhQGLh0UN1q2Yn+tWGPOb8EUBZ/fAjpC2
 WGyB6O6rpw5L7/G9Vhff1d899YUbZNU4ZQSOhMD3gp/6kLAaNWVx2xfP4b+kPdYc+nkt2aq880B
 wzeqsNrFMg66Fqv1pIQ==
X-Authority-Analysis: v=2.4 cv=RKK+3oi+ c=1 sm=1 tr=0 ts=695bbdc7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=fqHlcV494ISa_mgYehwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: g8CbyLzBkeWnW4iHI3Dt5rKNlMdyDgOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050118

Just like looping through children and available children, add a scoped
helper for for_each_compatible_node() so error paths can drop
of_node_put() leading to simpler code.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Prerequisite for all further patches.
---
 .clang-format      | 1 +
 include/linux/of.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/.clang-format b/.clang-format
index c7060124a47a..1cc151e2adcc 100644
--- a/.clang-format
+++ b/.clang-format
@@ -259,6 +259,7 @@ ForEachMacros:
   - 'for_each_collection'
   - 'for_each_comp_order'
   - 'for_each_compatible_node'
+  - 'for_each_compatible_node_scoped'
   - 'for_each_component_dais'
   - 'for_each_component_dais_safe'
   - 'for_each_conduit'
diff --git a/include/linux/of.h b/include/linux/of.h
index 9bbdcf25a2b4..be6ec4916adf 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1485,6 +1485,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_compatible_node(dn, type, compatible) \
 	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
 	     dn = of_find_compatible_node(dn, type, compatible))
+
+#define for_each_compatible_node_scoped(dn, type, compatible) \
+	for (struct device_node *dn __free(device_node) =		\
+	     of_find_compatible_node(NULL, type, compatible);		\
+	     dn;							\
+	     dn = of_find_compatible_node(dn, type, compatible))
+
 #define for_each_matching_node(dn, matches) \
 	for (dn = of_find_matching_node(NULL, matches); dn; \
 	     dn = of_find_matching_node(dn, matches))

-- 
2.51.0


