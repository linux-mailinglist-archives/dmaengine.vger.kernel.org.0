Return-Path: <dmaengine+bounces-9158-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ERXCJFLpGmQcwUAu9opvQ
	(envelope-from <dmaengine+bounces-9158-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Mar 2026 15:22:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9531D0313
	for <lists+dmaengine@lfdr.de>; Sun, 01 Mar 2026 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7629301725C
	for <lists+dmaengine@lfdr.de>; Sun,  1 Mar 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE132D0DE;
	Sun,  1 Mar 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClLK3Nsx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QRaSJnX3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292B31715F
	for <dmaengine@vger.kernel.org>; Sun,  1 Mar 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772374925; cv=none; b=XtAgQzRitCCrcfxPmXbg2XJi8zipg1humfWpUwx+zGPmT0rLNgaozFvY7p6QB8l3Hv/rTrrxQyqLXFOWKZctQX7rI1sxXSVOsp0CzEEE/y1lm9MNSjUMfEoaJxhu06Xvciq5syzZPHBHNCGTozg+/DQ8eyz8DwBZ/mhsw/0CT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772374925; c=relaxed/simple;
	bh=iD96boLQ8I7RchyAagC/taDWPsWnNpqMCY0MPFRwPm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHegcfj0ZYXPYmoG/LwRP+3W764Fw2Ymw1+oSKmytbvESVkdZhMT4L4OHh8d38hGZupLmXkFAyz//+qvX+1g5SPNj5L2J0V0UFJn0+vWkKP+CecCVrydG/YnGm/9PCOvPp0pMcOsWC9XwvcT4aMk3WcPPABKLtYsdoHQUmcZels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClLK3Nsx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QRaSJnX3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62130onw4148349
	for <dmaengine@vger.kernel.org>; Sun, 1 Mar 2026 14:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b5jdYQ+rQNyWXtGUdSfK8sVn9Lf075zpZKN
	QNsmNl6s=; b=ClLK3NsxB0auTZTw3SJdKebOvuF9GyJ6b1CAeNjCRU/2rLIWo9o
	VMjLjic2OlEV6zOaiiI/iJS8dBcaOeQxVcUw8OGXE6kv2IGAQp39bdwwbgN59l71
	sqZE52k3gw03c5I2RXRf/F21YCIbOKtDF2sYVmjXFHDNaVrivqdgacL+nCtkuqDs
	Z1Y51NpC9nOr5Eh0vEj8kHJYdCZpjDx9pNbzA3+yOTxIt3hI0cTL0Kk2E+KfLknW
	GznlcdMA0ESorKey4QNAZ7R4J4f1GGv8GN1jRVXl0gqihjf/J4ZezM56jPCQDAYh
	dXjbI5QgW39Tzd4EPBNa5YKciMFx400Y1Cg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksg72quk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 01 Mar 2026 14:22:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb3d11b913so3111746185a.1
        for <dmaengine@vger.kernel.org>; Sun, 01 Mar 2026 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772374923; x=1772979723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5jdYQ+rQNyWXtGUdSfK8sVn9Lf075zpZKNQNsmNl6s=;
        b=QRaSJnX3La5EUbr/FIqDU1m4u5g5STcD9I6JX7Nhvfqr3eVoHaE+fiNhZnQUcfxnWA
         t7UIqHLGU1Q3Dcx1udu/cuBbNgkkRbpqWYoUqQexjwQx6UAVHXZ5I2oRlA7/gHBs67Lm
         igOgkEAisyzvZkL6yKEzG3c7BuGG+EGOcAaJ4p6V94CAZdqCPPswX201Rkld73n+F4zi
         XGeu8MIfO/su2CXVvYtI+7WmS2GGk1mS509h2ncEkai24DA/+cImLyOMSNMzFZkaRuik
         kkurEScdtL78iaRJMIYrto4iyXkDj+pKsZfgVPT7XETApamgHmh2r/J3CuTGY/XNwf3a
         9W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772374923; x=1772979723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5jdYQ+rQNyWXtGUdSfK8sVn9Lf075zpZKNQNsmNl6s=;
        b=Fy1/stNqY6lz8iAwEiWXjUv3ETm4UBkvjWtU3+c8RpTVglFoqzAw+SDGYOr8kz9HH3
         mUD2keu92zcbRrx2Vq7iUmnzKuwGd49oLu5O97ZMKEd484OI6tYi3GY+IDCD3jy4U8Zt
         b2PhDIILrs8kaXXuYb2lPL4ZnjXOFLzGAJXNykTcWjIacsGEcs7PRepbrMr5+LrtJbQ3
         sItt7z1SdQhwAlHwGuc7XsBnwuFZmfTNWkzaiZOQh/ejFaXxa85lz+8TyNbfx5APLRYu
         Acq4B4mxsBlxobYHgy7EY0UsE/hMgQQCzX6V4OZ2nnTCBpEq5+Ubl4A0/N5WMMXNCGn9
         JUYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/FmVuNCNapor6oLGY7Bi5FB0kYrdLysLvmwaKL7RF5nQPFJAyEi140MqYvAmcuo7cuPihTotQRBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMVrT+ggIaM+yGg/mQeRGo4a7eyHDqEuHQXCTgOVKN4hGr/7n
	cUuli9ReEnaHLYnhij87Se48iHULRcVAApIW7cQjsoH7IJdU5F9FFFrwZQ0FJkIj0DNhDEqtkcM
	kUZFdPY48ICORszj6TmmiaSypTdw3wgE6IFYBEBKfJCXm2NqUP1onmB3+VWVW2ew=
X-Gm-Gg: ATEYQzz1fGnz0hy5z1r4oP4vLMDK8RsQ49+BtP0hXP+aWadIQn7dVRHRBbzIfI4GAOq
	+uz97GWVp/AZOcmVdHvp4MAOngsbhZORYxtvyRlkp3b3dMqJSK+dddRbzyyFQe0xS3B/Qhlhulc
	WVboHX2uJIbnaoTWnWg3Z7y2oSbAxoGumnFvQwor+5D0xWYWUJlSn4vjAeVVeV68AFCSRWBlbtY
	VRdZQCMQ1yex1n2bMTTQR1bOKXX86GPNGTBTvSSMSDOP6IQVzSheUH4BaZ6jz0pyttGdlmm2YDT
	bW7rAO525vWgqeIy/fJhZukCtDa72DsM5Ms4BHYwZf7njKr1+mS0iGWX/EnHE7sPOLJFQBNZRzC
	UcDAOwxhV5sUkHEFKGev5ozRG2YklIaxkbCLy
X-Received: by 2002:a05:620a:254f:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8cbc8dc2b70mr1097922585a.14.1772374922934;
        Sun, 01 Mar 2026 06:22:02 -0800 (PST)
X-Received: by 2002:a05:620a:254f:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8cbc8dc2b70mr1097919585a.14.1772374922544;
        Sun, 01 Mar 2026 06:22:02 -0800 (PST)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b346ccsm206693745e9.2.2026.03.01.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 06:22:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH RESEND] dmaengine: xilinx: Simplify with scoped for each OF child loop
Date: Sun,  1 Mar 2026 15:21:59 +0100
Message-ID: <20260301142158.90319-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=iD96boLQ8I7RchyAagC/taDWPsWnNpqMCY0MPFRwPm0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBppEuGvKheUVxqafvMaRtg/VGTXqOo0lrgZIjYS
 RE+h4O4tSeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaaRLhgAKCRDBN2bmhouD
 15OFD/0Rr93m1y8RAkpwIS/Hf2Z/RLrcEJ0bYZY8sNP3qXtcZa9FvpQLyJ5gak0+FBkzpfBL1ET
 47YsR6mRjuqhg+R6qfVF46HG39K+T/Xe/DFu8DoahA3zua/874kK3zwAdsI9bXvD7p4TgO0AdQY
 WBJIHDOPW1KaXpuoLhLC8pjNeNNIVc3Z1xfHADVEtCg81FOJvblEpSeQamsJBFW35p1RxSMooKc
 a0QL5RCQ//DGlADy5eX8vEbTNE/Z52Lu/FOh7B52zOOD1Ae0IX9joLH2uzgHCuJnwgLlQKl++ga
 HGvewysDtPuNXr3ZO8k62wZMjKqd4Vh4jM/hrudsANd5wwOGrvkZzMY7IIN95XYKpgoHP1pRj0o
 f/W8KWBob4JZlG9TI4kc4K6ZaUr7OGhfRwliL7aK2xKPxB/cI0qUjNiQIAHJRu+cUrgJ58iVDAb
 XcZTYyKNqls1VZ8ws/bXAvyKOx7+oMTmhuNRdALUlDo5CV/BVhf3fU8mzw8NTKqMPVVRiyvOVJS
 foShfF6yvrWO3UJOvNVu7Yw5vLYGS/jB2Qn+j2k4J1W/tDHTorZ+YaX5sFolk2Srv7YgmIAq7Zm
 raT/1EgbUM1e/e13S2ETfTI5JyZBIQ0e/348MJF+ytTEvhQ4j7p/+f+rPTvRQWIbXzw2hTISWNC joedJ4Bl7UHNROw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: exHUQL9Je-Dia7SVAOTQQ2RvfTfo57mr
X-Proofpoint-GUID: exHUQL9Je-Dia7SVAOTQQ2RvfTfo57mr
X-Authority-Analysis: v=2.4 cv=FaA6BZ+6 c=1 sm=1 tr=0 ts=69a44b8b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=f0Vwk3E23dc-4RkOOFYA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDEzMCBTYWx0ZWRfX8XWF9tawTqjN
 DJs4mDoPh4qtSTjsJAhspEMmrXVU2G4hN3mBOL2Eaj92KCNlr6hxSkD/aXS6NM+KnOfgNeouAlT
 MIycC/kL3O0FYrHyRJbXvc8YVhhTfMFHo1Wlm3Lw4fva2zlOQguCYG4QN6/IaBxLI8dliITvlfH
 zcxXmzvhQ4hkqyOVdZBEFpxEwrxbh18UB5LYNLoIZLbL+1IS9yGug1nJdd85OJ7ygunPv+0/A2Q
 wCo5pEzH4EBJUpxQj+VptSodTi48cLur1T25XQQ6S4PR4EWYdut0prK6QFcfqYHiHuufjio59aG
 vtOuiS+byBe5qHSS9qh2Dz3jls475ML1Oc12WhPBZHzqd4bhuG9OZnesFz1RZH7CKy1+Fr2pDvn
 BWtwb8mUBHQZzpNsUlYEWlhb4As6gHzs1bHHQUt7Tm9XsJzfDiWXtQMolrcQ3T8lQ4ESeZjs0+I
 jFApAmwK12D0Grb8mRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9158-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A9531D0313
X-Rspamd-Action: no action

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b53292e02448..02a05f215614 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3180,7 +3180,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 					= axivdma_clk_init;
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
-	struct device_node *child, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	u32 num_frames, addr_width = XILINX_DMA_DFAULT_ADDRWIDTH, len_width;
 	int i, err;
 
@@ -3320,12 +3320,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, xdev);
 
 	/* Initialize the channels */
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		err = xilinx_dma_child_probe(xdev, child);
-		if (err < 0) {
-			of_node_put(child);
+		if (err < 0)
 			goto error;
-		}
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-- 
2.51.0


