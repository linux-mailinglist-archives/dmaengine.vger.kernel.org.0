Return-Path: <dmaengine+bounces-6779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A875BC4171
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 378114F9591
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B12F4A18;
	Wed,  8 Oct 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RkITRvU0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6192F5A24;
	Wed,  8 Oct 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914293; cv=none; b=KDmgBHF7q9FwmS+45GOg9Vn7BxlSgL1IJWAcVcjx+MldNhMi37+pBBLeImv9jAtLh9o+R0/jgEnsmKDhB22FhUWU5JmdGQevsMhl5B7+4IyZXFQnKxDY0h63Q2uuOFFbrk9yPy4J/PR7n2+gTGTc20nWY4WSBIQ260lqVTZzznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914293; c=relaxed/simple;
	bh=Ga3vsQYI9U1MOrny1f2jeZBb92wAnf1fHcwOP56x0KA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E13JhcAggOUEO8pPGjRORXAeteuoeEnrlEeO+8j8jPYkQsGqbdMM64htpFj07IrsUz9FesQwAQMxnXMJgOyesdjXT9BL4zsOYRmV8L062xncsV2+POE26wqfCf8NDwRTwU3aIekaJrZrYcf4LnfTSpGTt/62LZoB+R+Wx1S6xfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RkITRvU0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OZw015802;
	Wed, 8 Oct 2025 09:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDDhJTly/m1s91x+TaedAzGahuXDvMCF9VOIb9Iad98=; b=RkITRvU0KlJlcYhb
	XzcOH1xK/KCx9mdTI2pBz44mY2lXUd9cjTvr3y9wq34WDIf4LSFYZRAJ/L5SWJCR
	juJqOgGdRvW1DegOO/hv9rBjyc4gldsQsHVCjDx3lRW9vu/CS6JsX4Z6qgLcavgt
	dPbZIQsxk7HI2VrNcKBslEYvlsTqwJBq7ME+PEYNpKqahBMzW+twMluEcyGmWeYc
	XZQtBibq1M9OXALXlnBUHtWjsh1SKMoQIUplRGA7h28fmU0y+tnKFRnSjs4fgaeG
	FmHFNH4WBRjGlgZMb6cHI4ljbbRRkHksdQ9hmEw8/IPSMOfwSNlrMThCT4DiEoxi
	P4qweA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk71wq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:04:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59894lt6010592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:04:47 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:04:43 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 3/9] dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
Date: Wed, 8 Oct 2025 14:34:07 +0530
Message-ID: <20251008090413.458791-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008090413.458791-1-quic_mdalam@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX3SQgKIlUkVkz
 fK7nFPHvS7EcJOPPW6ueX1hyzIyviqAfXUE0fp7c462cXXcPwB3/3S7oMCVp+Sz9YAHXfHuEzSR
 fLti6tZ+gts/RUCeHxmY0W+FjA29FBWELUB62BHWoBX0I4XFcNwO2qBnf2x+Bp92CNefBG2e/DH
 r9+2n9uwAqv63ieHDgoX9iReI+hXGf0lttkDYIICRR1XbkP42ogsAlH6qvPtHEbZKvLpZdD4DCk
 Qmo8WylMz9sjBcoEglVFSE+chFaX3hzfEgvBOAXnXlGefOqm293Hm5v+SvguuisJsUDC/FKFTxR
 PSrjbsnR9A5FzGng1A2QamJXTs6LeBgL2sYoomizNNnRnZi9ZJ9F0jYpIqUS/pG4YQBrS3JVstC
 l0aEVViUp57k1lE0KXuSvqTOHJ2uBg==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e62930 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=tI2DGrTi7ExM0tNOktYA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WV6XXqzd2dZpZzM2zKkY9BjM6WF4M_SM
X-Proofpoint-ORIG-GUID: WV6XXqzd2dZpZzM2zKkY9BjM6WF4M_SM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

BAM version 1.6.0 and later changed the behavior of the mask field in
command elements for read operations. In newer BAM versions, the mask
field for read commands contains the upper 4 bits of the destination
address to support 36-bit addressing, while for write commands it
continues to function as a traditional write mask.

This change causes NAND enumeration failures on platforms like IPQ5424
that use BAM v1.6.0+, because the current code sets mask=0xffffffff
for all commands. For read commands on newer BAM versions, this results
in the hardware interpreting the destination address as 0xf_xxxxxxxx
(invalid high memory) instead of the intended 0x0_xxxxxxxx address.

Fixed this issue by:
1. Updating the bam_cmd_element structure documentation to reflect the
   dual purpose of the mask field
2. Modifying bam_prep_ce_le32() to set appropriate mask values based on
   command type:
   - For read commands: mask = 0 (32-bit addressing, upper bits = 0)
   - For write commands: mask = 0xffffffff (traditional write mask)
3. Maintaining backward compatibility with older BAM versions

This fix enables proper NAND functionality on IPQ5424 and other platforms
using BAM v1.6.0+ while preserving compatibility with existing systems.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* No change

Change in [v1]

* Updated bam_prep_ce_le32() to set the mask field conditionally based on
  command type

* Enhanced kernel-doc comments to clarify mask behavior for BAM v1.6.0+

 include/linux/dma/qcom_bam_dma.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..d9d07a9ab313 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -13,9 +13,12 @@
  * supported by BAM DMA Engine.
  *
  * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
- * @data - for write command: content to be written into peripheral register.
- *	   for read command: dest addr to write peripheral register value.
- * @mask - register mask.
+ * @data - For write command: content to be written into peripheral register.
+ *	   For read command: lower 32 bits of destination address.
+ * @mask - For write command: register write mask.
+ *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
+ *	   For read command on BAM < v1.6.0: ignored by hardware.
+ *	   Setting to 0 ensures 32-bit addressing compatibility.
  * @reserved - for future usage.
  *
  */
@@ -42,6 +45,10 @@ enum bam_command_type {
  * @addr: target address
  * @cmd: BAM command
  * @data: actual data for write and dest addr for read in le32
+ *
+ * For BAM v1.6.0+, the mask field behavior depends on command type:
+ * - Write commands: mask = write mask (typically 0xffffffff)
+ * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
  */
 static inline void
 bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
@@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
 	bam_ce->cmd_and_addr =
 		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
 	bam_ce->data = data;
-	bam_ce->mask = cpu_to_le32(0xffffffff);
+	if (cmd == BAM_READ_COMMAND)
+		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
+	else
+		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
+	bam_ce->reserved = 0;
 }
 
 /*
@@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
  * @bam_ce: BAM command element
  * @addr: target address
  * @cmd: BAM command
- * @data: actual data for write and dest addr for read
+ * @data: actual data for write and destination address for read
  */
 static inline void
 bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
-- 
2.34.1


