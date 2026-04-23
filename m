Return-Path: <dmaengine+bounces-10094-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE7sFU006mkCwwIAu9opvQ
	(envelope-from <dmaengine+bounces-10094-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 17:01:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6F454062
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B051230C4156
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48735A388;
	Thu, 23 Apr 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6461PjQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F093126B2;
	Thu, 23 Apr 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956265; cv=none; b=SYZ4bD7ceBKk9Wrz51Qa6mtN2WRbuRLy/KbP0OFAZ1CcP4XVeudljwMoJvBif2UQQAZ5NU2IvJ4fFe1i2oLmKYpLaVwHpGnmuiD8GCtsHqrTFC3RRJou7m9VT6BWeRcvX2Q4nWIpFB1EXpikcTmKq4VrBg2Nts5ZuVJrKUqJjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956265; c=relaxed/simple;
	bh=5wWO8YpZZeKWSICm5+VAGrGxxREHvjDClIgimaLRvN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiwzlh+xhywg0A/NaAY+kg66Vlyh4I5aOXS4HBhKsi+cofSzQEgNEGsw5xdGrnOk1bZqbMzJ1pWRsB1FN0HheCL4JCo0mZgu4lXzYUlQV/CJzLGBAq3wo/rrAWbgMWncO+0oIQ02JIoAnokkASj7xcEQJLbRHdFxCbDZWxxrpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6461PjQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NBwigG009885;
	Thu, 23 Apr 2026 14:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dKWP3BzwCZ7
	DH9txszXX63ggQ7TbNv0YUXlfrhzzdJs=; b=N6461PjQ6aSKrwud81Z4tlKnObp
	u06Kp7qaogu4vi8Utp80pgq8j+fNaWBeYPmhyqTr+WtNf/t1UkGkH86E8dqYUGHU
	w/DO4LgEvCmd0GFsU5wYMbP383SxOHgijMKVRnT3/aizhju8G3VfM9Pvb3W6rjjj
	z5N1MsqmWVYvaj4ffAON/jhDgfJ1C2LKeqTkQk1aToLqhOrTQwteOk1cAibc3t8K
	m9nUzSyJ6xB7jye46PmO1RqUtZ3g5IEzVdvn0+qFI8wZ7ulouMiWQ6J9P63yOgzS
	AIVPUDFMUwTm6j+QmfcNQ0DRawsNiLot9AwhhF/3TubQgKwPsvdFiygjq1w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqk178p60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEvUA9011463;
	Thu, 23 Apr 2026 14:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4dm31k24bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:30 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63NEvU7i011455;
	Thu, 23 Apr 2026 14:57:30 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 63NEvTsT011451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:30 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id AF69E21C47; Thu, 23 Apr 2026 20:27:28 +0530 (+0530)
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
Subject: [PATCH v7 4/4] i2c: qcom-geni: Support multi-owner controllers in GPI mode
Date: Thu, 23 Apr 2026 20:25:51 +0530
Message-ID: <20260423145705.545552-5-mukesh.savaliya@oss.qualcomm.com>
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
X-Proofpoint-GUID: xpahXvXzHtvYjIgZ8PxySvxbpBjJ0HGd
X-Authority-Analysis: v=2.4 cv=R98z39RX c=1 sm=1 tr=0 ts=69ea3363 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=r5MnBgDnrAiVjouRZIUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OSBTYWx0ZWRfX8iwpSd9tFd8F
 zxbZ7rJP4V3sMaVsWZDnblxkLhxkNQYFzz0+iZHodA9vh/MGzbCmDlGGWYfaLB9Vmz5JU+Ucve8
 NuLGwJ8Lh3xmFccnI2qrSo6RezdSHYEohLl2fTDzP+dw4D7LfvWPc3EgvkUvlQL0JlojqvjCG/E
 RxIAoQnlibBF9KUDfHK1Wf8GRg9dCwIGC4Vs2kkxsZqMy+P3FmWg2YgF2l80aMRz0E6PFw/08Hs
 9wa1IMiTP4AYrtHpSoglQGB/JlbGsE0piuEa14vcufowljWjaSXhJjaD3WpmvLcwWbwQCFwOhrO
 Yat/pW2ZAc4rto6RavaE9RsaUGKA5RuY939KeZhdn1d0guoPya5cftHf5rR8oYZbmdGPteDnQ/E
 +x9RxkNt2XY+iuXRW3UbmyBnoZusEPvxjFXZtAat3GSuWuVu/EqzsB3NtsILmyuD8l+fm8tOtnM
 ZH9jFElxrQVkVE3fzng==
X-Proofpoint-ORIG-GUID: xpahXvXzHtvYjIgZ8PxySvxbpBjJ0HGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230149
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10094-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4EC6F454062
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
 drivers/i2c/busses/i2c-qcom-geni.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ae609bdd2ec4..a396ddc7d8f4 100644
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
@@ -1014,6 +1022,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
+		gi2c->se.multi_owner = true;
+		dev_dbg(&pdev->dev, "I2C controller is shared with another system processor\n");
+	}
+
 	if (has_acpi_companion(dev))
 		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
 
@@ -1089,7 +1102,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (fifo_disable) {
-		/* FIFO is disabled, so we can only use GPI DMA */
+		/* FIFO is disabled, so we can only use GPI DMA.
+		 * SE can be shared in GSI mode between subsystems, each SS owns a GPII.
+		 */
 		gi2c->gpi_mode = true;
 		ret = setup_gpi_dma(gi2c);
 		if (ret)
@@ -1098,6 +1113,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
 	} else {
 		gi2c->gpi_mode = false;
+
+		if (gi2c->se.multi_owner)
+			return dev_err_probe(dev, -EINVAL,
+					     "I2C sharing not supported in non GSI mode\n");
+
 		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 
 		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
-- 
2.43.0


