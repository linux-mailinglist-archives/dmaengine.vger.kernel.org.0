Return-Path: <dmaengine+bounces-12176-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rWcKOarT2r9mQIAu9opvQ
	(envelope-from <dmaengine+bounces-12176-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:10:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AB732055
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:10:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dTIJ5mRW;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12176-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12176-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0801F316EBB0
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFD435AA4;
	Thu,  9 Jul 2026 13:47:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF52435EC4;
	Thu,  9 Jul 2026 13:47:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604839; cv=none; b=jaWBARqkWxE3920Wh/yH7Bm7aHJCmw/mSRpWHA85QHhlNw1ukYEOJIXnxtSrgAo+n1Ob/deqg9qLV6J6BlAXBownd56IuC6T36Bapf06aCaCM+0El9Czeml6r6NZ6Rj3+I3hbLS6rZfDoTEHWppd7p/+88H1vnZgIgHiv5sYJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604839; c=relaxed/simple;
	bh=b5G3pq824rgDgJIxheSg/ZmnsBpdN5VzSalk6Zg6l1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoXXd1ZgogxTo28glTPFOubo6Kh2eWz/5uHrJ45uhQ9xaDxtnbBozSNR0q43jkIPA4/QHNo8LgjMHxe/7rROZMj5PDK+3Q4vNcsECemaoD5HmdUawDkwxfn3brcITCUd3ORJV4I197W9oSi+D3L9n3Ctr1QJ8oQH5DKS4q0HCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTIJ5mRW; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNVnh1575751;
	Thu, 9 Jul 2026 13:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kf2+xmIFZM5
	pDRquKAFQ9+RwzhakCT7kPK0IXGe+uPY=; b=dTIJ5mRWxv7z+vaNTa1ryG/gtIK
	ZmDaU0QdccMxyxvsU/Qv+BZKXT6KDLyG9vTqeavpbsemOdZT9cZOCzE0y12RMKHD
	XnO/gOCdfeeGtG45oD51nT8fnUtTkTA2WdjUQ5GOA67l6zcXpzhiY2LdryDlJd1K
	QkPdiTBnN8GKg9hVKEDWKyWj3jrHRxqzjycd1X50VX95NTsWe5tppegId/ZL5TJk
	SM6gcHRS79qjCDnWr1ds10wy/CL3xroKFmUbtR2Pg1R5y+psAzxEzi91p5b8gzdf
	e/jPNY8CSUzZwmm38nC6bkoHanW3lPKfC+30sLKCZUUXZPeWwFer6R6yX7Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwcgu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 669Dl7wg013912;
	Thu, 9 Jul 2026 13:47:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f6u8kn9k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:07 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 669Dl7RL013906;
	Thu, 9 Jul 2026 13:47:07 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 669Dl77h013903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:07 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 323CE217C4; Thu,  9 Jul 2026 19:17:06 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Frank.Li@kernel.org, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, quic_jseerapu@quicinc.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniketrandive@oss.qualcomm.com>
Subject: [PATCH v7 1/2] i2c: qcom-geni: Handle runtime PM disabled state during early resume
Date: Thu,  9 Jul 2026 19:16:22 +0530
Message-ID: <20260709134623.1724212-2-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX84G2hhgFeezn
 4UBM7lQGg3CJB43GfkOJW/Qwtm4qD5vXgrU5bzxkhDbSkHoNPnW3hGQjYOO1TAl7OHSEeJVXVHG
 IwlozGWngkPxS2Ohyyo14s5AGUKr+DPP03RGQ5nacHxX9CXHe6DqE8L/espPiezEGV32vwJGi3q
 9SyAZ3E3giCsGxzcu4kRurrfPwzQF0eqza+Np44qZ3N0jG/BHIvOeD+CXScDaRBe46GrxO/SD+K
 RoXJfKNSaK3dDPVUSwxz2+0wuGYNERez8OvfEAjCEJ8di1hNWN2fgecIOEmWnoMYFisdsHo0w3A
 FdpwkaUHXck5vl1DCPmLD7uvJ6RLf10w/cLX1x+CrsADnzgQ/bFuTNKoxnXGJiAQn3vUvCiKfRI
 +E47SPmtoNLmVHgDjKVZ18m3G8+qWhjT6nBtAuUYHMomgsCbVHXPPfmPt0onJX55+q+kJ3stfjm
 ubSIBh5nibCsbToSZUA==
X-Proofpoint-GUID: Hv_GkG8nuC1QamiYq8BfOuwpMQ3CDqso
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4fa65f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=a4dKUO4ndeGlH0Ie8rEA:9
X-Proofpoint-ORIG-GUID: Hv_GkG8nuC1QamiYq8BfOuwpMQ3CDqso
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX5bxG8Ip58FXl
 NEKwCFx74P0ZvEwW8E0BsLQZLSAIHTRjmcIeq8wS2Fvq4OKSe/ALgogq9XUhyxvB3Jdy/q9gwqM
 X6fTU5Bk3y16zgRtCZsoNx1JUCBRt/0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-12176-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:quic_jseerapu@quicinc.com,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:aniketrandive@oss.qualcomm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A92AB732055

During the noirq resume phase, the GENI I2C controller may receive
transfer requests before runtime PM has been fully restored. In this
window pm_runtime_get_sync() can return -EACCES, causing transfers to
fail even though the controller is in the process of resuming.

Treat -EACCES as a transient condition and allow the transfer path to
proceed while preserving existing error handling for other runtime PM
failures.

Also enable runtime PM in the resume_noirq callback when it remains
disabled and allow the controller interrupt to remain active across
system suspend/resume transitions by requesting it with
IRQF_NO_SUSPEND and IRQF_EARLY_RESUME.

These changes prevent spurious transfer failures during early resume
and allow the adapter to become operational before the normal resume
phase completes.

Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Acked-by: Aniket Randive <aniketrandive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..4bc00922cd97 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -917,6 +917,10 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 	gi2c->err = 0;
 	reinit_completion(&gi2c->done);
 	ret = pm_runtime_get_sync(gi2c->se.dev);
+	if (ret == -EACCES) {
+		dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
+		ret = 0;
+	}
 	if (ret < 0) {
 		dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
 		pm_runtime_put_noidle(gi2c->se.dev);
@@ -1115,7 +1119,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Keep interrupts disabled initially to allow for low-power modes */
-	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
+	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq,
+			       IRQF_NO_AUTOEN | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,
 			       dev_name(dev), gi2c);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -1223,7 +1228,12 @@ static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Enforced disable_depth = 0 to actually enable runtime PM during noirq phase */
+	if (!pm_runtime_enabled(dev))
+		pm_runtime_enable(dev);
+
 	i2c_mark_adapter_resumed(&gi2c->adap);
+
 	return 0;
 }
 
-- 
2.43.0


