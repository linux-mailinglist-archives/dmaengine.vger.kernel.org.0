Return-Path: <dmaengine+bounces-12097-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3P+oCs3cTWoq/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12097-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:14:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF85721BD5
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:14:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=lJWHMjVP;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12097-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12097-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF90304B6AF
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901843B8BA1;
	Wed,  8 Jul 2026 05:11:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E43B52EE;
	Wed,  8 Jul 2026 05:11:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487472; cv=none; b=m8J4Q3TtaUJTMxgU1SeNPlbYvO1qwxfSP/PiBJkrOt/ClANMup+f4Dwv7P2eQFvDq6a0e27MJI5czXoGcY9WECLK6ZPEf1bNGWhdEX9EogkCbBwn9SN5rtr8Qr0wm9VZjCV9B0VJTuR/QlyS3ud+o+HuJyWWJqJlKYbFeogXC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487472; c=relaxed/simple;
	bh=54bOuTBHsrVJm0To4WdY7wYQO5a35b0rqvHGbj4qzcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eewCtw2RvtoiEpCmgoB+o+yaVUCaZRqhz1usN9FzoM6jlM9aVyYjnOvVIOLcl2Fm7DAV1LD2oMcz2E2Kln5w8oJR1OqsprvJ9iXKJyBJPcT2Gc84VGks+HuLVHS6MPVP458bKd51SRHXjK38xku//mLjF28loTZLi6sbaEKyeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lJWHMjVP; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842Lqv1509149;
	Wed, 8 Jul 2026 05:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HbPnb+dK3aX
	8unSNSSGNP/5/4X50TofikTE4FNl3CSk=; b=lJWHMjVPQyGunBYmJSvcL+js9HD
	lICyM1mHzRcMx+ICG47409CNJhka6F8hjG/SbivjcrNfQp9T+CwoP20RkUC6raNq
	fA3PdUrn41jwYMZQJQyL6WBGJwHM7BuTJduyLO+fJTHlRbSinaWdQlS5TMi004OV
	Aqq0iioWIgA38hCyLSFaHInSYq4iUunXVpAzePNw125+fAIZDy1b7j5hv5E6DE9G
	S7pv8zxLniXbCKVrHQztCpis4bS6j4f02Uu+AKxCvMT65raeV2ypO1m+K9GKuU2+
	uOHajzqRNo+pmQ4xulTFHPw4zya9nemWmGr2KUCFP5k8Upn8SL/syQO7bMw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9be58xf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:11:05 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6685B2UD016208;
	Wed, 8 Jul 2026 05:11:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8kcs01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:11:02 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6685B2Bs016202;
	Wed, 8 Jul 2026 05:11:02 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6685B1Jp016198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:11:02 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id DB83E2181C; Wed,  8 Jul 2026 10:41:00 +0530 (+0530)
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
Subject: [PATCH v8 4/4] i2c: qcom-geni: Support multi-owner controllers in GPI mode
Date: Wed,  8 Jul 2026 10:40:10 +0530
Message-ID: <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GJc41ONK c=1 sm=1 tr=0 ts=6a4ddbe9 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=r5MnBgDnrAiVjouRZIUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfXwcZNr2O+jNxw
 rFgR3hZuEqYqqhgwcapNdPyswZtVVy/Yarmms5vl9dbbUo07vG45RZu9xSHqWFoNh1g6ZhmyVR0
 +klYyLIo5wyUYuki2FZ2jQ/6lyTB/5k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX/JqxDR/tQ3od
 zSu0e/TGlddtewu0Cuc+H4CNxUhkoCjJFdSIfaqDj6eRpCJW7ySSK5NWPFOdqwi80c0Q9tjaD55
 Q7SfgPpmLFL23yW1cR8xTrHXHurbi8Jpv/E2CeSVReSZhQV4gaqwGzKjvOgE2qEpaKIVh5QzlL7
 YO7iL+9J/GBS5f6s9PVEMvRlo5KvsrzBFE+lMxirg7aTABG49jEfSfP2rpPPzA3GPoVgdrEO5YI
 FoD0gZ1mpd29tPkOD62I73Z41IoI0fSSnZIocA0CIb0Kop5bMQ+C4D8eJOPg0SeZb8D1tVZiV0Q
 JO/FHdqxLCYDn9WDschuKgB9pB3z+MGHDzvCmZR/t5upwJmx51WraTbrgiBFF2ijzrmLY1cF6Ce
 YgNwpAUDFe2nN1ZF4V9k97Z21q+vZ9LFxfc81jxSUi3l0+PWZ3PcSCEXL5RjDqrz25qHQwNqa24
 gAfvVFNHQTBTlkX/r9w==
X-Proofpoint-ORIG-GUID: UxUcopPNPONFzT8JJBT9qpsUYotrqFAM
X-Proofpoint-GUID: UxUcopPNPONFzT8JJBT9qpsUYotrqFAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
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
	TAGGED_FROM(0.00)[bounces-12097-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: AFF85721BD5

Some platforms use a QUP-based I2C controller in a configuration where the
controller is shared with another system processor. In this setup the
operating system must not assume exclusive ownership of the controller or
its associated pins.

Add support for enabling multi-owner operation when DeviceTree specifies
qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
shared so the common GENI resource handling avoids selecting the "sleep"
pinctrl state, which could disrupt transfers initiated by the other
processor.

For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
driver by setting a single lock_action selector per message, emitting lock
before the first message and unlock after the last message (handling the
single-message case as well). This serializes access to the shared
controller without requiring message-position flags to be passed into the
DMA engine layer.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..757c2c8eb207 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -832,6 +832,14 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 		if (i < num - 1)
 			peripheral.stretch = 1;
 
+		peripheral.lock_action = GPI_LOCK_NONE;
+		if (gi2c->se.multi_owner) {
+			if (i == 0)
+				peripheral.lock_action = GPI_LOCK_ACQUIRE;
+			else if (i == num - 1)
+				peripheral.lock_action = GPI_LOCK_RELEASE;
+		}
+
 		peripheral.addr = msgs[i].addr;
 		if (i > 0 && (!(msgs[i].flags & I2C_M_RD)))
 			peripheral.multi_msg = false;
@@ -1019,7 +1027,11 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	}
 
 	if (fifo_disable) {
-		/* FIFO is disabled, so we can only use GPI DMA */
+		/*
+		 * FIFO is disabled, so only GPI DMA can be used.
+		 * In multi-owner configurations, the SE may be shared between subsystems,
+		 * with each subsystem owning a separate GPII.
+		 */
 		gi2c->gpi_mode = true;
 		ret = setup_gpi_dma(gi2c);
 		if (ret)
@@ -1028,6 +1040,11 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		dev_dbg(gi2c->se.dev, "Using GPI DMA mode for I2C\n");
 	} else {
 		gi2c->gpi_mode = false;
+
+		if (gi2c->se.multi_owner)
+			return dev_err_probe(gi2c->se.dev, -EINVAL,
+					     "I2C sharing not supported in non GSI mode\n");
+
 		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 
 		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
@@ -1098,6 +1115,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
+		gi2c->se.multi_owner = true;
+		dev_dbg(&pdev->dev, "I2C controller is shared with another system processor\n");
+	}
+
 	if (has_acpi_companion(dev))
 		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
 
-- 
2.43.0


