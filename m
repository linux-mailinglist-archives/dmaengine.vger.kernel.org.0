Return-Path: <dmaengine+bounces-8777-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CjKDzy8hWmOFgQAu9opvQ
	(envelope-from <dmaengine+bounces-8777-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:02:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17198FC634
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 796DE300614E
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112F3612EC;
	Fri,  6 Feb 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WmBrYdTk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712030FC1B;
	Fri,  6 Feb 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372153; cv=none; b=VqiERerIcFW9GmRq3jQbCY9Cy2ecejNHD5yWRY9Ci5nWXEnwmo+2zudwp7Sa19YTeGFXt6xIdW/uIkifagkAodh8fSnPKaWNcOMO2BO/OvdJoa4oxNM+3OIW/2XI0OAj2tIIOVTbqA6Duv1pGn/bEoq5RyRcqb/5sSwfAmUvImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372153; c=relaxed/simple;
	bh=r/RdQQg+btfaZ8TmXMe2dshEES9i6gJivJL0pF9E54Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjxmrSipUJXinoORav5DvgXjTnrpSq5tefEP5Nmoz03w2+Zem4sXcTHqNacqEDnL94UDcBFpQKlfRI/C0YpUhB000ACOUAArn4aDiUCLYTq/jqnRJnPGoe+BznTFB+rCmA9gJpd885slLploQ7i1oFokoiwk+/uFqoCgXTzYF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WmBrYdTk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168XidW694782;
	Fri, 6 Feb 2026 10:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZMgrkvZbN1R3Qhju7i46aVtLtRKW+YRAau1QzsFFi5Q=; b=WmBrYdTkGN3UNKhw
	DAqr7VTYEhEm1Tz/HIMNYgAxwqtZnQcr2tE1TH9IhHerAsxGxb/vH7rjBGYI61W1
	JhjDnJ9Acmouz2N8C7vhEteawQVXK5uiYyvG3GFfoMBu2/bWRL7kmhGuLj/OEBDV
	jYkNCaSHmFjGztte8HA8EKTC4A/FTDu9tx7SekT3HILtNnEmW3XNpICftKzimbZU
	yTy6puOjGdUBpdYNwxE40+oRiKksK35WlUM8Ow3cmOoBtWihvRSA2PF0x5uJIp0Y
	Iqsqx8zkcjbEZIcMO2cXgnF+0mD5Ot2F/sppptrc6wKnhRy15eaENgav9SSBDTf8
	18Jp/w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c53qva2fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2SL8002198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:28 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:24 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 1/7] dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
Date: Fri, 6 Feb 2026 15:31:56 +0530
Message-ID: <20260206100202.413834-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206100202.413834-1-quic_mdalam@quicinc.com>
References: <20260206100202.413834-1-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=TsPrRTXh c=1 sm=1 tr=0 ts=6985bc35 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=COk6AnOGAAAA:8
 a=tI2DGrTi7ExM0tNOktYA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KlPEK_w6vA4QpzIc74Jz_1tabkJ2zYrJ
X-Proofpoint-GUID: KlPEK_w6vA4QpzIc74Jz_1tabkJ2zYrJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfX8yGjlIKZJGki
 /xfCzJAwCMOUNO+f3N3UiVhY8YqBfXlcb4WL0vt1+xzA6WmQe4CClL/hqBS+34Rs6fQlgpNKPYN
 ESjSXBznbnPDK3Z6FV17loRThynISIcX6A8K+RQiRkCbOxpSewRusO9u3CdVc6xmPFtbJxazlF7
 Z69ubbClaazWQb0si9AD/YHjKb8bEoHMqybhfYcdAOc+J0rltQhOwdARma9iF1f+05oI0ITnArk
 xQX0A1RplMUG2Fws7ckKHaCG2c2OLGlhIy1e6tVeJJ80k2bfEiL9KkWCfFbC6vS8D5gJaMaXucz
 CRPiHGN3zJfzmbcwQsLRjU+Unl41yy7Txh5+cBUKz7qownuZzBXW4vfbf8fSWLVK1lji4R9e1a2
 Z3SmuNeH1fRiqlm7fZX5C6fSgNy7PgwSvK1zYygI8yANtkitQdbGLGpR3k6MTVCAGwwHjSlASEe
 bq3UY4qxeXGkWG8EOhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060067
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8777-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,quicinc.com:dkim,quicinc.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17198FC634
X-Rspamd-Action: no action

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

Change in [v4]

* No change

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


