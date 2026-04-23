Return-Path: <dmaengine+bounces-10095-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAtoCzFZ6mmgyQIAu9opvQ
	(envelope-from <dmaengine+bounces-10095-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 19:38:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998704559D5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A4803095F78
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB153A872A;
	Thu, 23 Apr 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AiHza+s5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJSvKCy5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFE3A9D94
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965770; cv=none; b=CNNaWNSy3+ds7E6uDfAgb3OlzL8DgCr61hGo7f2nzow4/vFsPLV97QsdLJYu/+oKRUkDbtsEaR8RTRZ/CIYyUDvEMDowzK2iao0JdjyoMI0LL6JKNApAWCbHcO04/eCFvOTRcj/ISYiLpKYQdFW6N3/ew0ZFWKv+byo2riVq98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965770; c=relaxed/simple;
	bh=k4cApNW6bEe1ys8GQFPV/tdb7tTuHdx1qREU528uY98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7HVXALh7nJKUztRwEqUp8s+3W/W2Xy/Utmb3VmXQIcmH1/qxcTGpxTbJRbzv7oSNTz5iNqwbsE5Dv4dXpaLPEBUmYDZW75ECcQD6AqbK00aZOHdAfl+xBaYRh9+dVZhUEM+xnj741sA9gWxEpl2D1+HYx3cgPfht2N2QVXMXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AiHza+s5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJSvKCy5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NFs4Ha1204917
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 17:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D1LBLjBzXNnhQWwZ4y6m+Yz7V/UxsFvGsIw
	OV0Vmy9U=; b=AiHza+s5PG4Onio0MCEW3r9sRWjzwfkue9NjlnlK27A2iNw9hsH
	eQQm8x2VhAyGYO/vLmpUWyrOXPgyyI0YoetxBgkiZBA+NILr8KO+GFPDi86Lwhof
	TiWcZBDP0ggYZcG3jVB53YApAu07UcDuOutRBkAGkB+wK3//stl5q/PUBN36eoap
	XFl6sAem8zMWQB48TlnNhsG4cL/nmFov9KsosuxEXGxofYDMkw6AsIHcIM6cm9Od
	MXX3IHQ+qCgEOY9vG/OhTIzi5ZyG9+/jUSW0MWDfMStbALBEB2e07zaSt06Qy2tX
	bk6rmd0X1BvrAGi0K8gsSraBleHx8Nv6d/g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqggna2n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 17:36:08 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-950c363a552so3348078241.3
        for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776965767; x=1777570567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1LBLjBzXNnhQWwZ4y6m+Yz7V/UxsFvGsIwOV0Vmy9U=;
        b=SJSvKCy5XNoYif1MJReRJbGis4cyyOBGp4LXrPo7A0e6D4FxyYK7f8S4yn4+5LG+jY
         av/lHIdtnQPl/2ASp5Cprm7ZIMo0Lby8LpihZ5Hd1Hpe+EvdQf+SyuadSaop/OlU8msQ
         kRnwCddz1OvQbPkh59EWcWQTiiq+G1GlSEyv0fzwQ+PAjWmnB/JQoFnj207Eqf1gbgL6
         jQUD0d7WVtBbJsjwp0Ivsm5exzoPXcSBvTtzL0PSz7xCQvSs3GgR5r7YeIg24HwAypmd
         YapbBVRD+VG57YQD9YI3739JsX1MoZJpDiCjkXdCcBqZzevSd/eOFCl/O713bHlrHlEh
         qsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965767; x=1777570567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1LBLjBzXNnhQWwZ4y6m+Yz7V/UxsFvGsIwOV0Vmy9U=;
        b=onaix+doSlvNtIoHL80LU+rcOrBiwgv5J+UOY9nfcInp957aGkDkIdu50+c0gbvjVU
         hPkyNo+0c5NHwKk1Lf29hjTNDToZIAfKQWnyBBQrBxzpAP8X7WXwWFu4lVbYQdFe/MEb
         fC7TMlauTT5+Fwhvf8x0J74of+i2VzR7JdgiaXnN3C2w6ypLE7WBNBNiwR66VMfQd1lh
         yY9JSqZPAlyqj9iwqoMBQx8r9rr1cURjPwOTIfJ90GaxxLCE3LClUDSfK3ykGg8za2FM
         cz7/CqHWPABqXKaraDzO4EJus9TGBFVGPzu8MFI8nWOl/d3vComyU+8/8uFkRdNmqmbo
         ximg==
X-Forwarded-Encrypted: i=1; AFNElJ82iSaywmPmm22x1MwMxhozZz6mIlVS/sHH4QqFIJ96TXCmifbo6kRgy5Ll+zpmE4B4f7hLvN2ckoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUSaDWL9O4EeSX8Q8jnnuwuAbV7Ja1/5Y563eARtTrNmy6tFd
	OnXVB0hbsq41Z8YYpm246R8r6rpuYZRDeLaCi4WTAjjdFF7TG6X+xAUCJgNi127x3N/iV6Kuwu/
	EgFU0255ZnEt0EPg3I7ikerzSQlNjhsqkrzGkuA3nPUf2eVgvGZ8+rpEBy4XrlI8=
X-Gm-Gg: AeBDieu8JR4L1MGqn080WuEv00e3MayuVKJxdAqRtczGNF4IoqHKevNXCGKpSv+NAmd
	SytWPuVqifUiAlmxFA8bjqtXDx2dZ6aiTX8/66OYWNK0ljqOEaeyhT0XoYYdeBQs4mTlRoMkw3k
	i/6OZRa4GYYbNF4OAjMW5hBrNJSvFEoAtnAd0axpUdtYt8dbTHJfcr9uBfM5tD4w0KewXzlJn3F
	p5fgRWxa9wI5rx7K18H6bjxyaDe+BbCjR0Erh/L876WVneoPjqwI2qPLQ/vEGKdW4Qp7hHuAgvt
	i8JFKf69QNvaKxlQDwxpjw9JAhT7Asgwv8a+e0XnAWVx5U1wklSCNGUBX3XEsoS7Joe9ksJW3BV
	yPHbi6H9rY25uhzJpF+ezv0o1/EBOUX/8nHKT21tnuNUFrxg=
X-Received: by 2002:a05:6102:4489:b0:611:61d3:819c with SMTP id ada2fe7eead31-616f5eb8122mr14877270137.10.1776965767213;
        Thu, 23 Apr 2026 10:36:07 -0700 (PDT)
X-Received: by 2002:a05:6102:4489:b0:611:61d3:819c with SMTP id ada2fe7eead31-616f5eb8122mr14877247137.10.1776965766766;
        Thu, 23 Apr 2026 10:36:06 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm562700675e9.2.2026.04.23.10.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:36:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dmaengine: qcom: Unify user-visible "Qualcomm" name
Date: Thu, 23 Apr 2026 19:36:03 +0200
Message-ID: <20260423173602.92503-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=k4cApNW6bEe1ys8GQFPV/tdb7tTuHdx1qREU528uY98=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp6liCLBtoIguAkuB2UsuitenigLX+rqtvEeoxy
 80QZUxOdXOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaepYggAKCRDBN2bmhouD
 14LkD/sFAFMxC9uBrutHxfOXJwFLHHUl2+Ij8DwZvCwm2E7uVNV8QA5B41uBplqFB931bhMUjxE
 7ULx7tzNn0tCKdPv+la8tDPodieiJ8I8ztLxu8L3rb3Y/fWbPkZyj4a8qeDC66YFDo96ohdP6bL
 BJTVCEK4XtGKJznaqvDI/w8UX3liADanvg0btx/xx/nyyu2oNtiXVNoZBgQZVGYgyCtIfz3GD3c
 V6WCx8I5dcGIT2FK7tLC9CojNtuHjrcjSM4NaBODmvSA2kt1V8yRGkj5gxvpbSlRcV9xx5ARPn/
 YLbzmC7rFi0gpiwj6oG3VH5hdM7NSHsQEplLpHKjGP5D6Br2s+7TS6YzmA+GWGiqWIepcJQVvoj
 VU4y2B4T1ErMIe826w5nArSY8hQdDbn8E59Q3Wtq0ylN5njBMQslQGpAPqa2wxfTSVKlsH2h+G0
 4UdG+4JDWqOvO0GY5yWAI+Z5qslNWTp40QKo7ihrsQOKmIvLhnKP0ve7LKqqtppEAPnM4SILdee
 g8XYYTNJn8kKmFXGq3HI09M5Z57+WzWEzOMdJTHOtxBTaGaa4KMr3FNuiBMq1XRjk8Dvs7wFT2L
 cIWRkCcGxU+TaaVnNVjLMNltvTMV+eLvrmosQwrC7Oc+1rNLt/39BhTsUR4kwc9ibE7+/BkUGV7 3wDV5qGQIMlCAAw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E2yflQATeZ8g2QiB2F3nI724DUzEV2c8
X-Authority-Analysis: v=2.4 cv=YZeNIQRf c=1 sm=1 tr=0 ts=69ea5888 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-Y-akZLcyvlcO5CxEC0A:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MSBTYWx0ZWRfX6CUMKQECHAuu
 uYaggVomaor587wFt0PsReUoD0g0RefMlO9LT1a6paaYnKjlc8wm3Ej7IQohhRzuXM7MoJDME6b
 yeAvcZt7fDncMn/8M+saGvB+GZ92jyUf++7mV0UpkhHfR8sambqL76JdM04s769k9TsGoVbRHc3
 M2k+AYDA5vlb017Oj8VSb13cAi8/OVNugCwa90nR4hS5I64p9p8nHsElN2IdV4cfI7YiNbNw6F3
 l73eVMdt8zvy44SpYPUfhkJszWtUrR7HNx5EmZbvs1eiDftLqYr6K1LkRPyrBNrKRylY1kbGXIZ
 g8+TwKnJQHgZ0uwfxFB0BKAghs0fbmsaRz5Xzol6WC01q91t/PrSP2OoqUt1vrPbzZUy0WuQzon
 GTE9eoXSeiv20mF8jN1/x3VRXjHjFox6GYGleqVU7SBE77hvEYYOZCIXbyZNixc0iWGG249Tooq
 nFyT54A9dbpz7tFDQOg==
X-Proofpoint-GUID: E2yflQATeZ8g2QiB2F3nI724DUzEV2c8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230171
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10095-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 998704559D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/dma/qcom/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index ace75d7b835a..c71b0b5d536b 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -11,7 +11,7 @@ config QCOM_ADM
 	  and on-chip peripheral devices.
 
 config QCOM_BAM_DMA
-	tristate "QCOM BAM DMA support"
+	tristate "Qualcomm BAM DMA support"
 	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
@@ -20,7 +20,7 @@ config QCOM_BAM_DMA
 	  provides DMA capabilities for a variety of on-chip devices.
 
 config QCOM_GPI_DMA
-        tristate "Qualcomm Technologies GPI DMA support"
+        tristate "Qualcomm GPI DMA support"
         depends on ARCH_QCOM
         select DMA_ENGINE
         select DMA_VIRTUAL_CHANNELS
@@ -32,7 +32,7 @@ config QCOM_GPI_DMA
           transfer data between DDR and peripheral.
 
 config QCOM_HIDMA_MGMT
-	tristate "Qualcomm Technologies HIDMA Management support"
+	tristate "Qualcomm HIDMA Management support"
 	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
@@ -44,7 +44,7 @@ config QCOM_HIDMA_MGMT
 	  host would run the QCOM_HIDMA_MGMT management driver.
 
 config QCOM_HIDMA
-	tristate "Qualcomm Technologies HIDMA Channel support"
+	tristate "Qualcomm HIDMA Channel support"
 	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
-- 
2.51.0


