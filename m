Return-Path: <dmaengine+bounces-10093-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HPvDxM06mkCwwIAu9opvQ
	(envelope-from <dmaengine+bounces-10093-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 17:00:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B045403F
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24F2305FA12
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85AA3624AF;
	Thu, 23 Apr 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kY/JaW/8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CF359A62;
	Thu, 23 Apr 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956255; cv=none; b=fVtmyY8kZlPSZkeCOg818SA7xu+mrTxBMxyQUkfPEEwHzeQBaYluNEeYTe8wh6Le/gCEm1vYGYEDUYdDTnj7m/QvuAOUQWpgOx1Rm0etdjX5RxcFAThoOLsf7FJpiRqU2yWzVb97ua5Erc6vMvjjfQM8vnOrJNeZnkMIdeOiJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956255; c=relaxed/simple;
	bh=e7t6ShQ2cI3Mz6AmaHsbAxeWQh28RjNT6mgVG3MLxxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWzXB+Cz9ZKUgVlbltrEqJIZsUK/i5SkPEc0uHu7qEqL8Wg1ayWLKjxLG8THqrlx0nh6MLjMdnvlvs2PowYaoExcc4g6fwgp+mxLmo3+hWJtxN7TuYqpqPB85KLa8AsXmaf77l8G0nmChF22y8zM1WVdW8sziyzG0WNBPtMafgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kY/JaW/8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8uEtN3044055;
	Thu, 23 Apr 2026 14:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MVr+iQ0IOVH
	oD8QLuy6TdPdop5YCIZQZqq7rbtOLfq4=; b=kY/JaW/81tBDC3bTJ+dVIQt0hSs
	1h3N0RZEV68z56FENw+xhRDypU6TI2fCcY0IJlcQ1XSi5i2mkIgmdRQzhoYqUBAz
	wEF/v6ZUDN+MI1+Dy4DU4tvqX4WccIwe6lcN49Yk5Vme3N+BuLvQI4HEoRnBnBzE
	0MMI5vNKMIu4odslVmtFK7yh4ZNqm2nBNOpj94XO4FQZ9boPa7LN5C5TuqnL3XOq
	7lwCHx6ltYompWl3AD9bMvU5TH1HyCaEos1xk6I0kKQgP4d4ehQKZh+Pt7E3DCas
	fo40XpEPAYZU5MitramtUfru3Omi/WGRK6aaViyQlLYOxRgM1uRY/8Qlb5w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh4eqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:29 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEvQO5011425;
	Thu, 23 Apr 2026 14:57:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4dm31k24b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:26 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63NEvQnW011419;
	Thu, 23 Apr 2026 14:57:26 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 63NEvPrS011417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:26 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id E3BF521C47; Thu, 23 Apr 2026 20:27:24 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v7 3/4] soc: qcom: geni-se: Keep pinctrl active for multi-owner controllers
Date: Thu, 23 Apr 2026 20:25:50 +0530
Message-ID: <20260423145705.545552-4-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OSBTYWx0ZWRfX3wQntq8X80DI
 jdfK1b/mplihxHrqiHMq6M66n4l5ku3HLfiKXQCaiWNqCFmUKtkNuKR6oLOkZf7qUsNiBptMIrp
 UCxeDBsCZyab63xMxAlWJgzPU/EcwHtNUHdrCWyXIbQ6sdWuFfraAK/4aHwuPT2vLEskizDZEnq
 MprEdmwWjRW85/KT86bEyH7N9MI4Pb4f6AjDf0CXTtZw1c1xmU3XldMOs7ltQ8iXXvGBbkq7uHf
 GAY6oPRAt5Ztq4hJOVDyD+CMVAyh6422fIMI4fjoRofKJnlxTcu0WemV0RS0bPCQIK/DWw2UtUZ
 Vd6H64PHc8rxd027gknKFxbDRPXl/TD11M/hyOQqlTUKv5NEOqe2b5pmeyYNvC+QGav8dpF1QyG
 Ys98PQUgJYswh3wjCPoM8PHHrWiL27/Ls8k+1Oxf3abVaChe4aSelZSWPioZMOHUiEq1wV9yAtp
 ABLjXQ+MWblGP3YUmPQ==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69ea335a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=AU6ItHRBSQEJJjuWNb0A:9
X-Proofpoint-GUID: yn-QgtGEoKNj2wWp8mn69598A6mtBZow
X-Proofpoint-ORIG-GUID: yn-QgtGEoKNj2wWp8mn69598A6mtBZow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230149
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10093-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	RCVD_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 798B045403F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On platforms where a GENI Serial Engine is shared with another system
processor, selecting the "sleep" pinctrl state can disrupt ongoing
transfers initiated by the other processor.

Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
when the Serial Engine is marked as shared, while still allowing the
rest of the resource shutdown sequence to proceed.

This is required for multi-owner configurations (described via DeviceTree
with qcom,qup-multi-owner on the protocol controller node).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 15 +++++++++++----
 include/linux/soc/qcom/geni-se.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index cd1779b6a91a..1a60832ace16 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -597,10 +597,17 @@ int geni_se_resources_off(struct geni_se *se)
 
 	if (has_acpi_companion(se->dev))
 		return 0;
-
-	ret = pinctrl_pm_select_sleep_state(se->dev);
-	if (ret)
-		return ret;
+	/*
+	 * Select the "sleep" pinctrl state only when the serial engine is
+	 * exclusively owned by this system processor. For shared controller
+	 * configurations, another system processor may still be using the pins,
+	 * and switching them to "sleep" can disrupt ongoing transfers.
+	 */
+	if (!se->multi_owner) {
+		ret = pinctrl_pm_select_sleep_state(se->dev);
+		if (ret)
+			return ret;
+	}
 
 	geni_se_clks_off(se);
 	return 0;
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0a984e2579fe..46217cac73c3 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -63,6 +63,7 @@ struct geni_icc_path {
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
+ * @multi_owner:	True if SE is shared between multiple owners.
  */
 struct geni_se {
 	void __iomem *base;
@@ -72,6 +73,7 @@ struct geni_se {
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
+	bool multi_owner;
 };
 
 /* Common SE registers */
-- 
2.43.0


