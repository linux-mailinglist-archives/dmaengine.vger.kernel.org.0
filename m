Return-Path: <dmaengine+bounces-6538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E6B59A78
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD433A53A0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0E329F05;
	Tue, 16 Sep 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhTegtnX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20ED2E092B;
	Tue, 16 Sep 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033405; cv=none; b=d1HFpJ5qqvQd1MFaHwe2cbkseiUxnhnpcXK63Uxt+3JcGZQzJ6P2HpVjPviD53a8C+K1gb6zqBK8wTaEjK0UN9iuN5dYUMvPPtZsrikZaSmpFEJFOxYqUY5MzueTnZFkaBupdjlrhClCKf5FNCplsGRbBw0eQ3Ky6hBkAJldM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033405; c=relaxed/simple;
	bh=OeUD6p+SfGXy76+3JB7HOj5XLh3Klp1RYgnLqCC6sIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKcDOmwn5YTezd17o7M6h8bE5bwBNy3A+4IP545+bQHybgFzAb8hv+ugCHDm6Pnn8gcCf4+6HkxTaB7PNS1JZh9gk7KWVrC4r8b6yBH+t/mCYzcnK1n+ElEOujwoDWPFuMcVlNoWXQGf5DhR2EZWmEI3QQveT+KQNLpo/bC4WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BhTegtnX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GD3M6v029861;
	Tue, 16 Sep 2025 14:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=P4wi4n7s2TxZKQYOJxOrQFBg32v2R
	rwvHWCRx0am/xw=; b=BhTegtnXrg8WR8qlBHEsexZCjRQUYKMtYrNO0qjknBkOj
	zgRuo1KlTTojl7fbWHbZA/w/VZ0s/fLTrPR6I4gaFi0DX5jn/ZjtNBuiFMG0XbwH
	QHdtXJb7dZGahhzpS47sLAXJAxYub2qzIdmFvJTMe8Nd4amhuRF4lApJjrony49O
	WLVcc+0CQ3McoQXsj+mkOyN4uszEehxfvT4f7JTosSubj0Tzm4Eul2lHEPw20Qb4
	azI4VLnVvCPQ77fircRtruvVqCuova9Gucf5hIJ6SBMM6xl3PpZt117DFb9XCOAn
	AkTgQvg0I8jd4+oEtDUhX2CdKDOgpMbVbJzZXP7kQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72vupd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:36:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDJLKb027194;
	Tue, 16 Sep 2025 14:36:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2jrj8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:36:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58GEadTL039436;
	Tue, 16 Sep 2025 14:36:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y2jrj8p-1;
	Tue, 16 Sep 2025 14:36:39 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: mani@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: fix RD_REGISTER_LEGACY macro definition
Date: Tue, 16 Sep 2025 07:36:34 -0700
Message-ID: <20250916143636.51986-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160135
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c975f9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=ZVz_MZLp7Mt2adhBaIMA:9 cc=ntf
 awl=host:12083
X-Proofpoint-ORIG-GUID: M9kWERJ-TJJ_wQiMaIjaFWDrb_Vo2Jcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfX5tEPyiXWR1NE
 /3k/zumcHU3PD93JrSUF+NYld3OlNEUfNLbp6Y40c80A67/R6ahQNIOP0xP0isv8DyBHBY3AMDJ
 4gKQW8uDG2X+nv+pEbL7jftMrJ0GGkiPPnpyCC3J19zHt9iYSpQIEJGqk9CkTzNrdL3cBU4SESo
 f8gKM0knCpTD1MNP6aqS7lyKZfnZNv4Pu/2ztT0VZwnpjDFmQCNECjILUJT29OBCP5AvjeU4w97
 n46t3S4C9t3kaD//YXpKzeD2FDA5fn6Xy313w4YLlo0txE1w9B3M1er6bpnF8K3/RSALspY0nq7
 q1ZP91vVGnkojuosU85bK/AxE0ta1Ncl8G2XpCpHYM7BmpjMF3vhUS0y0qSaOronYre4XxUmeCk
 KfroihNU2uhuFelGPlogmeY1oYj2aA==
X-Proofpoint-GUID: M9kWERJ-TJJ_wQiMaIjaFWDrb_Vo2Jcl

The RD_REGISTER_LEGACY macro lacks the "dw" argument but still
references it inside the macro body. This causes build failures
or incorrect expansions if the macro is ever used.

Currently the macro is unused, so the issue is not visible, but
fix it now for consistency with WR_REGISTER_LEGACY and the other
register access macros.

Fixes: d0152168538e ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 406f169b09a7..1dd3d2ae86ba 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -47,7 +47,7 @@
 
 #define WR_REGISTER_LEGACY(dw, name) \
 	{ dw, #name, REGS_ADDR(dw, type.legacy.wr_##name) }
-#define RD_REGISTER_LEGACY(name) \
+#define RD_REGISTER_LEGACY(dw, name) \
 	{ dw, #name, REGS_ADDR(dw, type.legacy.rd_##name) }
 
 #define WR_REGISTER_UNROLL(dw, name) \
-- 
2.50.1


