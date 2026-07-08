Return-Path: <dmaengine+bounces-12096-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7qW5OLfcTWoj/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12096-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:14:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86221721BC8
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:14:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=A7hQ2nWi;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12096-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12096-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69D830456B5
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFD3B774D;
	Wed,  8 Jul 2026 05:11:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF31F03DE;
	Wed,  8 Jul 2026 05:11:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487470; cv=none; b=WTu95JC8nD4iMo3KDd8nevg/Coy3NTFp6CfgEyFKpZBT25FMN5OBl1RXbagYPow+crr6P/qv/WneuyBXQ97pwmqePZPbjOgmUED0SuOw+NSVcqzHYxaVxXn4hBdJstc5I/49jS2tBb1yNWsrUpjzgNaFmbSDZL4eneAO9tSZlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487470; c=relaxed/simple;
	bh=XAC9z3SGMspdUbU1AKyBQvkMGwoWiIjzeOqiePCLFQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhc+WXFWSjAV625XD5qwR3Jr9xurDm0a6PoeA0mQmat2/fbgGCkOJQh/E9jrrVv4MTwnsLyJtaX+Cc1KEYOdqlgM+MiZwimJAtNTGc+w7KJ2DoFK9Mxq5G5nEVVj0683t5FKzJQoAhOh1KTYPFiGigiZ+76/xcLKe5qZDprsGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7hQ2nWi; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66843YrA1528618;
	Wed, 8 Jul 2026 05:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aFR6A9tQPak
	Y8gK/v4Ib9iOnj/8NuVkxMrn62iCtlOc=; b=A7hQ2nWiGlzWAsgjZRtoPFgSuL6
	wbTkGzmpsO4Xt4DH4NRGNcahPZkr/MBnkhrlitv2jWjw2TDS28PmVA6ZRGyroy6V
	i36K404waKmvWQD16v0T4DARFFDzsGVXIf/A6rX5cFLLvhbciuGlG1CyVS6PtCz2
	I7QZDqRxPqutzsm8ldtQrmddZv34QsarKFlzolr8lUnwuRpQko07qzc6Zi/nXjlV
	xe2VsyqSBfRqe0rxNX4reJqyRya0rpNg5+/vyxtR1P5qtrVwQDW/QwaLB1g4lpof
	wE8oO004fmIjWGiNqIkxboyAXDeJRcadjffTlaeu2BdiNW9L3JH91S0x3pA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun4wmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:11:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6685AnXs016076;
	Wed, 8 Jul 2026 05:11:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8kcrys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:11:00 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6685B09T016173;
	Wed, 8 Jul 2026 05:11:00 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6685Axer016168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:11:00 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id BC4842181C; Wed,  8 Jul 2026 10:40:58 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v8 3/4] soc: qcom: geni-se: Keep pinctrl active for multi-owner controllers
Date: Wed,  8 Jul 2026 10:40:09 +0530
Message-ID: <20260708051023.2872304-4-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX05aXBIqdrKyw
 GYO1OgA8fwfQ1a+kmr+IAkQSkLkzUzbDsrxqD+oS98XQnf68a9+riH0tEDp6Eb4hHM2TJI0EzjA
 b2WgXFtxjuV2ruLHZDjQjtoYT0Kq68U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfXzYwz9aiJIb5Z
 sikPkYCiERPg4zLO3f2Zli82jneX3uh/fP/9YTK741hVxSFqA9ZkHkcibvcsMGD2nUUXPgvQ5Ec
 Ruol7vZgqdy1R4peq2PvwPTR2ey4OOnb/OLZhRXABxFwTvObkRzGgOPRd7nGqiwRmn4D+MKsFFJ
 VP9rUvmxMAiHP9kwPpw66rirbeKmU9wcY+DddDZMk9eYjMB7z/2xq4iq7oQB1QgAVMxc02hY5qY
 sloafqOX+xxQKhLQTZAUssdc79MrY7UmkVKkq4wsxEIJPydc0I5Nrb3VObdf5d4CVhhlnYkAlJE
 8YnWHw7pupcqwXrqHL4BPRtz7uHCm5JWzGdO7Q31ovk4t+gbZhi+u9SxwvCFZ1PUym6YleDQz2n
 7yA/uCo/4xgbW96X+Jzeg3RSUBeMVGHKAXmTfj5o49oOjjBsL/9/pB72FRlkaWKerKgH7ZOk7d+
 tenwY2oE0OQ98KNlcxw==
X-Proofpoint-GUID: fmH19qmcDdSAElhggrfkQIT0h6CVTOOD
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4ddbe7 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=yjsoBxkUdLS_pUp0TqoA:9
X-Proofpoint-ORIG-GUID: fmH19qmcDdSAElhggrfkQIT0h6CVTOOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12096-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,iscas.ac.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86221721BC8

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
 drivers/soc/qcom/qcom-geni-se.c  | 14 +++++++++++---
 include/linux/soc/qcom/geni-se.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 15636a8dc907..3441ae3431e6 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -607,9 +607,17 @@ int geni_se_resources_off(struct geni_se *se)
 	if (has_acpi_companion(se->dev))
 		return 0;
 
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
index c5e6ab85df09..9571da2c51a8 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -66,6 +66,7 @@ struct geni_icc_path {
  * @icc_paths:		Array of ICC paths for SE
  * @pd_list:		Power domain list for managing power domains
  * @has_opp:		Indicates if OPP is supported
+ * @multi_owner:	True if SE is shared between multiple owners.
  */
 struct geni_se {
 	void __iomem *base;
@@ -78,6 +79,7 @@ struct geni_se {
 	struct geni_icc_path icc_paths[3];
 	struct dev_pm_domain_list *pd_list;
 	bool has_opp;
+	bool multi_owner;
 };
 
 /* Common SE registers */
-- 
2.43.0


