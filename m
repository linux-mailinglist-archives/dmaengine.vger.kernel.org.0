Return-Path: <dmaengine+bounces-6836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEDBD8E5B
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B02B54FDF70
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4C30BF69;
	Tue, 14 Oct 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2LUVB8M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685F3090EC;
	Tue, 14 Oct 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439972; cv=none; b=ctCyZ3VJ1bqRb3cOyIPFq8H2BvPKR8GbvHRBNoeKW2uX4RH2kSMWMo+2vMsWVm1XeU/oxq+JMKe4CaiI+GI3OAgQ7LiXACQFf5/AWJi7A82wxGrm5pYBhNb/N9xK17X+OLt1V+eWy0pmrc7hOKrHGSpINMo/hDEwxqIN4cco/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439972; c=relaxed/simple;
	bh=2E1NxvVojdomwHalI5nV7X8ki447+qrubVNSFDfL/w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsjAHxmTPYabPsxpb5+QvBp6B6mvBl0gR56mSuMlbc1zFJg60SvWvyJuivrgbGNZpQmsjYEnksG4WcbyFV290jIr2W5m18FhNpcNKImuT9kQPWmo6RAsDtB++pAZFMnXeog2t8pzM47WDNWbARNbkI+1+o8Vtyr0RMn9C7GIObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2LUVB8M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JYg030974;
	Tue, 14 Oct 2025 11:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ef9H/MDHjjmnc5xhBGKmf0tSXs7E9CYD7VPZwmd4784=; b=R2LUVB8MhIMjRInK
	94RAsf9T3VrNA0ckCru7ZWBDNacl8jMsw3v+OlIxWDmMcEeejskmcLNFmspcQKEw
	Q1B20WZcgTwXXOZ/JscT1mwUDTECNS2H8vvM1HgMH9DRe1r8gTGRFR7c9ZOeNlAD
	XM3Pgx5lD4fwGqW3/6RaUIFPkLrLIl7N4vRL9E4xzR2/CV2czwoThJra9eQXMSPE
	MxRR8hhLYYVAdf9/WJQYZ75ZNg6zWcYlG4ndUrEFx2S5ACVfRxHVdtZssFqmXUDa
	pBplx6eym4blHIJAGQZuflWgFUSvKbvoMRaui1JKO75mQNBDwZagE/I9z1MVar3q
	dEWJ+A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0r5xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB68DU027813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:08 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:06:03 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 3/9] dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
Date: Tue, 14 Oct 2025 16:35:28 +0530
Message-ID: <20251014110534.480518-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014110534.480518-1-quic_mdalam@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8UrcdW2NQl01
 qLxN7isfp5f4WhOxVLql3YZeDGukAdPPoDMVwogWhxcAybDgIO/0UvVWPKcJ9+oCb5LgNcLYhZT
 UGJOoyTDfF6xGvML6LkFISlKif+HiwOZftoyFF91OkV7a50g2PLJG0Bwb8ybKpbNNM1JTiXDko7
 BO/yNkw2+LP7lXJzfIMOh720uKmLxHJBDwSaQhAoidZiwr3p+PYwAVpZSV2fkiiLlJm9kI3Iwvn
 sDjWmVgqHNn7Hq3q2IdSRtiR9yEqfFJ7zVUqzIOvV++hCR3f6/vHGWwM+wae8sNjq3UKLNz+n2Q
 fbzHfNv0RAYJbTQ/33bU8Vx/rCCdWFFqqaXp98Y0mjdsqxo1J5uJ9nQqq96U8t+4L2NwEIqZVmt
 u8KR7U+hvtlGduTLTSdJ5xYMUPoWpQ==
X-Proofpoint-GUID: 76vfMmaRAuY1ErwvkdgQ11_yqH9DB1Re
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee2ea0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=tI2DGrTi7ExM0tNOktYA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 76vfMmaRAuY1ErwvkdgQ11_yqH9DB1Re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

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

Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Added Tested-by tag

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


