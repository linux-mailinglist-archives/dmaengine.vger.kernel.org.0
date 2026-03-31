Return-Path: <dmaengine+bounces-9777-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAS4Ac60y2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9777-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:49:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F72369167
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C9FC30381B3
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0303DE424;
	Tue, 31 Mar 2026 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oeeQeodj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653B3822B5;
	Tue, 31 Mar 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957725; cv=none; b=HPigsCHRndjcR5fCC9krGCKvpxF7m3avlJIcgITPkpUqK/ZNg4Rorh+E2vEYkg0XOSP3a6X3VygYFGSMUlgXwK3Wq561ni+1qNwZDaNvXNvMuU7LLJ8p1KarXQKmTk2nashmpIX4e9MC+JjtHMSaLWXC88jQwLUCuXe6YE5Ho/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957725; c=relaxed/simple;
	bh=OrTPCLFoy/lXjg+kOZqJZMWotZiwF1YBFeK6SAao5D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfQA3D/ZO8t2Du6Ii/QoPFuR1qlznRpjLAtPNDmB+jv8DjzhgVoCbDtycNEFVfolRZHi8i5eDL1dBaGQGk+bVb4myy8ySsV58fJYX+RS07WnpIBlnLHecQZ7fMLh9LFODfoE2qy0iObrHVJRgt8qxg98d/F6su1+IF7pehQ8xVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oeeQeodj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VBk1ce2391342;
	Tue, 31 Mar 2026 11:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FJDNGZLM93w
	QFe5ymtZ0GbdfY8lxJ4Mzqty5jJep6hw=; b=oeeQeodjHaLJIHQeXRJRdQbp/W5
	cCK9A2pRkyrMQw4MestTJdMRZhdnuPpw+Cr438RyFbOaogXmDjlfeHEx4fjjcFVI
	7Lw11qgHL9KSX/5q5Y7FLCSJ6RRocoWvScIzAybrcGf7HXDbLLEy8fxM+GpZYa9g
	8O1RyZrjSXzkku46x9p3Q7ogJc6Js1uasCr1UO53G0DUCVKgN7IhldkfOJJg9qI8
	K3c69kMAIbbqO1GPCiyyLOF+s0DSOsEL1o7recktiLQoi0q9mLa3XdW2EYc7OaO4
	SZlB5qUAsH8WXnkRrQPr+1EM2Tcx9FGJCiRrJSZgjWaI8L1lSYaVtBLxF+A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7ue7mc9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 62VBmaMY011366;
	Tue, 31 Mar 2026 11:48:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qk1ven0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:36 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 62VBmaZT011361;
	Tue, 31 Mar 2026 11:48:36 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62VBmZqh011359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:36 +0000 (GMT)
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id 387792579A; Tue, 31 Mar 2026 17:18:35 +0530 (+0530)
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
Subject: [PATCH v6 4/4] i2c: qcom-geni: Support multi-owner controllers in GPI mode
Date: Tue, 31 Mar 2026 17:17:42 +0530
Message-Id: <20260331114742.2896317-5-mukesh.savaliya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExNCBTYWx0ZWRfX4EIMPCC6+G3F
 kaPnwIABJWb7zWX2OeVj9elD2aGSc4+espdoQMsLQnF+svLGcV8jvoJ5OpkO9I5fnvTtZSLq9KT
 xOLdyuV/Om4GMZjWf1uOnQJzoYlvFHqURQfLPDIaypBdQeslexEd8f9j+bTF7+2DyT7swPDxmzH
 OF6oTTD7eIAo41HLT3Iab2C4/fM0u9m12JYp2RXizqJodWf8n80ttVd0q/V2Zu1tmoEVlg6NWJc
 aksIIZggqc5EFSfnB7alWfc/3uNwHmW/GePh/6n2bJhF4s6yWep1CjTw3QPLEFQhzW+eSnqS2y6
 Lee+3FuWASkQyW+as/oh0or2FD3dxuKtWF8UjGEtvcTyVLcrTa5zT4Wd//UAwefCwmjvtgQ7yEr
 xAViIg7/58FhCEhwQCozM0uHGlfW217zo6o81WhMFYk0Zza83auWQJwNKIqoOn+PXz6pSaUYJPI
 9v5ZeBZx/ekAV39CE0A==
X-Proofpoint-GUID: Za3FSEG0VLwaC8DqKNHp_YFTAWkpSgaS
X-Authority-Analysis: v=2.4 cv=G7sR0tk5 c=1 sm=1 tr=0 ts=69cbb498 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=r5MnBgDnrAiVjouRZIUA:9
X-Proofpoint-ORIG-GUID: Za3FSEG0VLwaC8DqKNHp_YFTAWkpSgaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310114
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9777-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E3F72369167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/i2c/busses/i2c-qcom-geni.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ae609bdd2ec4..1925e4ec9842 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -815,6 +815,14 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
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
@@ -1014,6 +1022,17 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
+		/*
+		 * Multi-owner controller configuration: the controller may be
+		 * used by another system processor. Mark the SE as shared so
+		 * common GENI resource handling can avoid pin state changes
+		 * that would disrupt the other user.
+		 */
+		gi2c->se.multi_owner = true;
+		dev_dbg(&pdev->dev, "I2C controller is shared with another system processor\n");
+	}
+
 	if (has_acpi_companion(dev))
 		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
 
@@ -1089,7 +1108,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (fifo_disable) {
-		/* FIFO is disabled, so we can only use GPI DMA */
+		/* FIFO is disabled, so we can only use GPI DMA.
+		 * SE can be shared in GSI mode between subsystems, each SS owns a GPII.
+		 */
 		gi2c->gpi_mode = true;
 		ret = setup_gpi_dma(gi2c);
 		if (ret)
@@ -1098,6 +1119,10 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
 	} else {
 		gi2c->gpi_mode = false;
+
+		if (gi2c->se.multi_owner)
+			dev_err_probe(dev, -EINVAL, "I2C sharing not supported in non GSI mode\n");
+
 		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 
 		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
-- 
2.25.1


