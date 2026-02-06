Return-Path: <dmaengine+bounces-8776-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLGmB0C9hWmpFwQAu9opvQ
	(envelope-from <dmaengine+bounces-8776-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:06:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B992AFC743
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2DF3076EC5
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB936214F;
	Fri,  6 Feb 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XEDBnzIW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E962FFDEA;
	Fri,  6 Feb 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372147; cv=none; b=AUEjNHOTKzwlBKz82nxKUyCe3J45iLTbi3zME1AC+n5kPYvpf25LkaodV3EnAT9k1pJ/nVia5Z9iwnVXVnA13pOq+b85dyX54Z13ka5ik1GSmkmQrugb2x3zBl/yG8IMHZfiY1D6yetxYPyL4qd1ynB778+7jSU7zObW+hlOTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372147; c=relaxed/simple;
	bh=bi7yBYd3PFeOKKx4wJOd1GzYz4oeBOGqT+AsRDVzOxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qUQIsVV50WGbU4HhMVQe9tXHy5ZT/VkWWRNc/i4/aVV3Wg3tHOFj32MSmHzZW8O9ukR5q2ipagHo058zqVdcu7EqdWhGUa4HizHZsGktP6gTiFk2St1FKkkGB1udOMRwnmcpVcKhvo2mee2TEUF57RkuCSMl8NVqfpplWtbqSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XEDBnzIW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167Xqmi2482148;
	Fri, 6 Feb 2026 10:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uwgIDWyqreuDun5lxtO7uw
	lRttAqP/WxKZaJDXC0pEQ=; b=XEDBnzIWrAyjymgKFv/wjw0WysRZkJKxqn6pGa
	P725BKynd5adYBQvpDS6Pm5foY6APW23fN528UfcAIiMNXPr04AbnmRaJva2uO4h
	v4Pd72tfftXHUANqpArjcJFVyPw7bn1yJHMFA4jS4k3l8h6Q+Ll1JqDPESaDXnP9
	KZAHoMS15vRQ4uvd8fwVqXMInf3u0lO+k3knubtUZNkeWXog2lAx7HRcT3GxDkKI
	xVLCEPJ5rscW/CqyV+BdreBrx1jZn+h6scqhnevKI9AqHURV51Xz2iaIbzttqiBS
	tGCGTcyOJBABQaSM6P0LvCtqEfTpvjYACGacgtQM4MbWUkMw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c170h7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2O2v002140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:24 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:19 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 0/7] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms
Date: Fri, 6 Feb 2026 15:31:55 +0530
Message-ID: <20260206100202.413834-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: ST90EGnPD7lE0IvX1MhGCsUI9JkNfgcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfXzdwEZU6TaBpB
 IkX++uo2ipIsr4WIctJh5zuhvl3sWg1+ImeHaeCecrtAN2liB3i0hHOwKWtIcYohKWPydIr+Sr1
 jQD4bwf1JN+4Bv0uuJuEZu2YaHNd+o07yhDwQ3BsvrKpKuqFTkEKQU82jeH6ZPgbK1C9CQWmkJ+
 416MFQAtL15g4FsYnaJ4DJYaCELEyZd5rOH8W57nNmn8Swbdk5RcpdCT6qv2EKo0+SePWJ3bL4h
 F+qyixr2hiUFYx3e3Ow4kBJ3sLALATfo6AcJRXsL99Te8IbFDLAicD1aGH1zB8S2HFjYq6UcOps
 NpbQRrO7FGY9sb71L8C0RLCxetbYi2MRkUbUR5ql3wRAtbckFRBSFiLGV4woz1SxesrqNXkN3EQ
 78n/ubBw8+I+VxMAtBIe+j575A2m63TNpRvuhHsWf6o3GrkB2BGRoDBY2PsUcZg4n4744tsyrtw
 Cf3pXlFCbkoge22kzVQ==
X-Proofpoint-ORIG-GUID: ST90EGnPD7lE0IvX1MhGCsUI9JkNfgcr
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=6985bc30 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=TQ69iSlqDmPYr9GvtBUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8776-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,quicinc.com:mid,quicinc.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B992AFC743
X-Rspamd-Action: no action

From: Md Sadre Alam <mdalam@qti.qualcomm.com>

v4:
 * Rebased onto linux-next
 * Dropped two changes from v3 that have already been merged

v3:
 * Added Tested-by tag
 * Added Reviewed-by tag
 * Reformatted clocks, clock-names, dmas, and dma-names properties
   to one entry per line
 * Rename ipq5332 to ipq5332-rdp-common

v2:
 * Added Reviewed-by tag
 * Added Acked-by tag
 * Updated board name in commit message header
 * Added \n before status

v1:
 * Added support for spi nand for IPQ5424 and IPQ5332
 * Updated bam_prep_ce_le32() to set the mask field conditionally based
   on command
 * Removed eMMC node for IPQ5424 and IPQ5332

Md Sadre Alam (7):
  dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
  arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
  arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
  arm64: dts: qcom: ipq5424-rdp466: Enable QPIC SPI NAND support
  arm64: dts: qcom: pq5332-rdp-common: Enable QPIC SPI NAND support
  arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
  arm64: dts: qcom: ipq5332-rdp442: Remove eMMC support

 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 44 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts   | 34 --------------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 33 ++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   | 44 ++++++++++++-------
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 33 ++++++++++++++
 include/linux/dma/qcom_bam_dma.h              | 21 ++++++---
 6 files changed, 155 insertions(+), 54 deletions(-)

-- 
2.34.1


