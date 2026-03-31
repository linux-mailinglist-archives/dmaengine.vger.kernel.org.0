Return-Path: <dmaengine+bounces-9776-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCtwEme2y2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9776-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:56:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55A3692BC
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C930030A5598
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B63E120D;
	Tue, 31 Mar 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="egId9djY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7653D8909;
	Tue, 31 Mar 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957715; cv=none; b=sn2jXGwmslz+Hh8bnJvADVv2CV5aXawPsBl2NEwU5ueJLTHicXqoEcdSYGjPdus3O0fv+W0tV20ikElVyJeCRcWS5056dVFq0xM3/s8CNoEd66UbcLXc5tcVB+e7HHUiVEvzdZKKvXDOx/c0On5VfFBNlUJBf5I3w5B2g8AcMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957715; c=relaxed/simple;
	bh=O9MOKvtgRA5t9IWeLy7OsGvTemT+UD7RfWEloUcG2cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuX9jLSjxdZtMWWFO1bmL0tgZDFBTlgWM6I8Ggnml7r97FuwrNismC0ZnnALo5XyfSt/wx/KhkgGT3pIroE0Rz04oPVCQZAzDetaaaBgEx9HyT1BW80fB2wNhdDfJteV4QWLiNgNgNCN87eMpCicdyGiRt6JGTHk2s9r+6fEssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=egId9djY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V7sARr432749;
	Tue, 31 Mar 2026 11:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8+FNWnlQ7SF
	qp9C2dGpwd/G1f8IzOyv2V5eIXWNj+IM=; b=egId9djYJVL9rooq8JKFmoG7C+d
	D5uNEVBbGMbS87Cyum0FP3egYhyHbxgN6n57q0PyfiXJefEt8EyxOM44YdiKjHmM
	163qY7gysysEfsC7ahSwqhV+trLY+v2/H1lQNM66nDsj3NpMOYL+SIeTZ7o8gIHL
	0VWXrE6rdKLQYtBvn/YI4yMMtik1mB36xErmMNHZrIuwR8EoW3N6bAsL+Qd+h2J4
	gps8v+TchD5Dr8aftZr8S48O4LXU9YKbp4enw1lpGzojStOxkAzThWRe95MeBRaL
	1enGYqfoMxFj82W/O78MuaH90+mmCDoO7GyTUQxK9X6gQm5161BVGcCfvcQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d84bfj820-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:29 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 62VBmM1C011316;
	Tue, 31 Mar 2026 11:48:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qk1veme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:26 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 62VBmQdU011328;
	Tue, 31 Mar 2026 11:48:26 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62VBmQZ9011326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:26 +0000 (GMT)
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id 7A28C2579A; Tue, 31 Mar 2026 17:18:25 +0530 (+0530)
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
Subject: [PATCH v6 3/4] soc: qcom: geni-se: Keep pinctrl active for multi-owner controllers
Date: Tue, 31 Mar 2026 17:17:41 +0530
Message-Id: <20260331114742.2896317-4-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=INwPywvG c=1 sm=1 tr=0 ts=69cbb48e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=AU6ItHRBSQEJJjuWNb0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExNCBTYWx0ZWRfX2MUnKFwp3h2K
 ioOSvONYa3VhgpT8hkmiPRdGUkVeS4IuKJhHZIbR67vZOuHsk8ZQ6GqCMi2AfC2ORi6JuHXCWzC
 wt+ekvdzP3YzN0GXTGeoPgtIbOFlR8lmMzW8GB6GERI7vmco1ts+wPlU8E8wDit0RCynI2K2unP
 Py1IxN0Rm8wFfuRmjR5lYic0p5FpYeJMbggxIMbCbwr3p8R6g2Z2TJrKauRlsgnWg3PyjX3qyre
 G6ldJ/ngJglDgbKuA/qRJIX7G5PUWcPlzL5CE/Sp4+XdjRlGTQujmRkj2TyEmpb3FSLk+R3Rj1W
 +SaVKG5KWAZsfwdaG4PpHmxunVgX3yU36oT/ntrPGLNaH8nlTbDuW5GRSWVfgtKJ7tdNEcffwVP
 AZNyv+BoNSc0TblMqci0rA2rVyAJnRv9FZ7VPqSDN5McUEFim1gmzFbRNDajo+dUw8ErXlGT5oy
 xBbDcFdiuHaY/UX5wiQ==
X-Proofpoint-GUID: 7I1ywzjntiRF6E20hKN866Nyo8r-C712
X-Proofpoint-ORIG-GUID: 7I1ywzjntiRF6E20hKN866Nyo8r-C712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310114
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9776-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DE55A3692BC
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
index 0a984e2579fe..326744e311ce 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -63,6 +63,7 @@ struct geni_icc_path {
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
+ * @multi_owner:	True if SE is shared between multiprocessors.
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
2.25.1


