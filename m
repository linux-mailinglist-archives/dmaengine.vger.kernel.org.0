Return-Path: <dmaengine+bounces-6619-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01689B83D66
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FA14853AA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A02D59E3;
	Thu, 18 Sep 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NYRENgRl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750A1F3BA2;
	Thu, 18 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188476; cv=none; b=bGb0yLeE98Lnq+XDplO8fj99LQqUwToBxSQKA1X20hKSlqEFTqmooWr7OVyStj2oMQHT4A4XFp1apacqtorti8W9KMXa53rO8cZGUW6BvDmRheoNgiLZYrOR8X91yn+t4KNwk3FzlG2I8TAE7VEdSyW5Por1QTBkALJ/RKGPb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188476; c=relaxed/simple;
	bh=LQ506tB3WQ7hJCV2EpaTj4/AIAYT56h+nU4Q0rMGDMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcnDW0hJzoIvZIlCOGWlmrvHQ+QDTavyH7BgJA1smLTzbOwDkvweWkdG4MHvkHJ7t8xV+jI2mC3FFaD97F5iomaIT4c16YdM3nrSZcoigLgViLmYDU8no6HvWayaIbPynT5Q1ZrlSd635ULYl9j23/0OOd/Or82T0UuWV6ttymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NYRENgRl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4F70o029495;
	Thu, 18 Sep 2025 09:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0BwVydKM3XUUS2XtcsYDduIU7aFphgN9R/6nOwqwD0g=; b=NYRENgRlzpORcJKD
	rmxJQ/GxBSl4zcu0O1XUCzKHuwfngPUjctmmTsR9ecMV37QIoY/2m6qq5X5lZgxq
	zEKsaJpmNuglZYq9dUEjwTKpIp7uBtpsgttnqRYxHYQvrn2d7A595wzvy4m4UUSc
	noB/yPudqLV2Yr4PaSKtMgPv08uJrESEmwAkSNod3wAmG5vxwZAGIxKyBZEwAw5X
	vXvdBRt2U6ZQ6C8toSljfj79xWRb92jHsPUc8Wc6kdeUveMW56fAHIF0Od+ufO5C
	SvOpqZrrUcsKH0xPYPJF9CWZ1MShuuZp5P9V/nKMd4A7vg8mLyjgc0SbKVj9VEpW
	37HDkA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0wrb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gi029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:47 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
Date: Thu, 18 Sep 2025 15:10:11 +0530
Message-ID: <20250918094017.3844338-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Tph0pl-LUBOxn5KmIWXwucSvAXPWPt-r
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cbd3b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=tI2DGrTi7ExM0tNOktYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Tph0pl-LUBOxn5KmIWXwucSvAXPWPt-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0/BCCYTDdrwk
 kDqrA7ph0PhUrPNHbrpT0sjbuqJQKetiZfBJ0iGaCGRj6kKohvm5vLkeOYWcAUNY2a+qWhsikkO
 6ibaJkxY+N1iwN7x1XKX0rJXWALmQnX8mKC5FsLL+RueNrmA9WdAunpy3VMOss81pJsrKmmtNbQ
 nHpV+jqDViVF1aHgPf26/U4JkiXAv+w3VpG+XLdgMULHTYsZEqn1UoQvSh/4nnVEu1+ndgkkR81
 d57l3CIgZxPfjHwgeprN5OBEq1b5uj8ycw3+v7Mpt2ZBM3gFXeZtReetzy7OPo79kNeN1VYVP9Z
 9aQsyWGALgW9KOCDl7XMl8SJB/XJLjmtnurvjnGp8X4O5icABF0WwImOJ+slJjVZYvUjQm+XSIZ
 c1C1Ds8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

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


