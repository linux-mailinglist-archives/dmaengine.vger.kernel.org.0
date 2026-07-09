Return-Path: <dmaengine+bounces-12177-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c0+rA+yrT2oBmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12177-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:10:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC273205B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:10:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=VEEpw+7R;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12177-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12177-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0353F317000A
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B8435ED1;
	Thu,  9 Jul 2026 13:47:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8F3859F7;
	Thu,  9 Jul 2026 13:47:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604839; cv=none; b=ZOcDk1zC89/HfFKigWz8ZyAumfszJOiB9oLn2Qx0OAq1yLFnzWiPi0ewZqtoMNN3Vq0hwKURGEL3DmI/AkDlafM7Bq98wqKVBU/mcerVaKQch85fbULkVfTXVEx2L30rTl4+HyowxCovZhKkt25yV1Ozs+luBgSePy6R2XX6fIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604839; c=relaxed/simple;
	bh=Ppgj1VbFx+pd3Q2+ttuq9Oh+7SArO/zPy9wzIPjUHWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoIpPcSU8QXxaPGMxuhosBTZusI9XZ3nJsM8tXf7D1WJ3P7O7sqQT8ysLdKzuIA2bcdR97myDkDlgN+A4MCUVDzwUGj/fCru8b45IQM1awdgyjUR73vBmxNJlhmUfl5jtCow+z7C181/OFk07gQUlx93zbvVjjEQEPL7m+DUPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VEEpw+7R; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNSJw1672672;
	Thu, 9 Jul 2026 13:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ejMlQYhIEVD
	+cjGbaLr5W8yjBFGIpU/Y7VACIeglWQw=; b=VEEpw+7Rj+eTkBbM+DvrtxD/+V2
	EqTw6Gd3Nke5jxOB7gAwASih2Ffw49RcK8W/7IZg3Sm8IrnHFw8f5VPYw187oIu/
	BLvE5SonraClV+H9JXKPf9xBJ9sTSzd6ZxSKkFTk+0oGmTbC3fI3B6WzqUNuMHmd
	20xeVEfjomxzezUVOdvdUN/Ywt/SxYNGwdrtUyNLbocBrdcRYYVKiYllKGIPiWGa
	RjTgEh9Gn2oQKpeA5IoFuEV8LNKTYqAL6asfZsqii9Ww5jSaadII9XmQEf66+WCL
	nwJbI3ev653iR90+iHHoGdDpRM1NoWrZqbqYKqaWrwrEMCPFJ12bhtwJwYQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqscje1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 669Dl9lS013929;
	Thu, 9 Jul 2026 13:47:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f6u8kn9ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:09 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 669Dl959013922;
	Thu, 9 Jul 2026 13:47:09 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 669Dl9Mf013919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:09 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 24C19217C4; Thu,  9 Jul 2026 19:17:08 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Frank.Li@kernel.org, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, quic_jseerapu@quicinc.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniketrandive@oss.qualcomm.com>
Subject: [PATCH v7 2/2] dmaengine: qcom-gpi: Keep GPI interrupt active during system resume
Date: Thu,  9 Jul 2026 19:16:23 +0530
Message-ID: <20260709134623.1724212-3-mukesh.savaliya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX7Q0Fkfekh+l5
 FUTBoMCZpyhW37cG4ruoYYFwYb71U58om+4Nu2Rek5JDfIiY5xcUB3jjdgwdp7Nca9tqVn/9Upc
 jWnyZ1ITUTpBb30NmSB3cE12x3DgICE=
X-Proofpoint-GUID: V4pv3_wEfPLcUcHnhvEdoKmKHTCjJN46
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX1WpT0cen2X+n
 qds+RktoeCfXnB1UeOm1nmdc15b5e5omTJLWDhoN9rG3teKxCE0rLYsBNN48lP9dII3G5h9ukIm
 Sn9F4ZBV1M6cMjFqrP3MzjflWZ6mND4/0UbKBA7d8l+S+6X4pEWtBZdlseJ0swahnwwDNVY8PKS
 Kkj8LqTDE++SRgpRLoja5G5+E8cgfLZ8oDJxQSREzjIe0bhQmxF6g3XHHsqODpIcVGwdk/wtnBz
 Kz++35YDF1sRgcAvudsUTPl3W6C3c0u7KXERw2WT6QljJhRcwNeuCiY2r6Dx9mhgTroBFHVlJCg
 EbSrP0TIowFPjZNwbOQt7eRLxHAbdU3134AHpBbgtVP/xnK6YFw01LHplY1IIwOoFISlwDz0Oiz
 KaMmF60fjdrSJwX7kYUnw/tdHTPKYuFUrl6CsoWf0uUGnJH81OWtyh+ZcOsh6lWTqIcpuxH98FH
 UnOlDj7j5w6yiqlP7ZA==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4fa660 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=ZUwoNOqUPYlh0sfiATMA:9
X-Proofpoint-ORIG-GUID: V4pv3_wEfPLcUcHnhvEdoKmKHTCjJN46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-12177-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:quic_jseerapu@quicinc.com,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:aniketrandive@oss.qualcomm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DCC273205B

GPI DMA clients may initiate transfers during the early stages of
system resume before the normal IRQ resume phase has completed.
However, the GPI interrupt is currently suspended during system
sleep, preventing transfer completion notifications from being
delivered until later in the resume sequence.

Request the GPI interrupt with IRQF_NO_SUSPEND and IRQF_EARLY_RESUME
to keep it available across suspend/resume transitions and allow
interrupt handling to resume during the noirq phase.

This ensures DMA completion events can be delivered to clients that
become operational before the normal resume phase completes

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Acked-by: Aniket Randive <aniketrandive@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..29872b6cb2c7 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -615,7 +615,8 @@ static int gpi_config_interrupts(struct gpii *gpii, enum gpii_irq_settings setti
 
 	if (!gpii->configured_irq) {
 		ret = devm_request_irq(gpii->gpi_dev->dev, gpii->irq,
-				       gpi_handle_irq, IRQF_TRIGGER_HIGH,
+				       gpi_handle_irq,
+				       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,
 				       "gpi-dma", gpii);
 		if (ret < 0) {
 			dev_err(gpii->gpi_dev->dev, "error request irq:%d ret:%d\n",
-- 
2.43.0


