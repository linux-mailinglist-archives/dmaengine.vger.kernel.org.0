Return-Path: <dmaengine+bounces-4333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B0A2CDE5
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16162169D33
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4DB1A0B15;
	Fri,  7 Feb 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PL5mlcE0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3119992C
	for <dmaengine@vger.kernel.org>; Fri,  7 Feb 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959112; cv=none; b=RQgwzF+c8MV9xw/hw4DFtKPRWt3E2z5o5uzZkvOjh/PGTprNnBij9grbX03efx1rBS+zGMQC5WVC75KVr3VbYCYlNzV/bfTK00oQYOVK3Wq8JE8Q+BxwMU1gkYPAOLGnBgGMXV/mOSdNF+pGgYKLSoWfQKi9/XGuxKVCdCbYvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959112; c=relaxed/simple;
	bh=o0JjXXcxDBv5TFdiXfnwXkrMd28amcy8OmNIPYYWh9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LhB5gcFt3i6eITRiS8URnjDaeMsDhANiLrgXZX+CgdHStO/wydQcslO8eoVrN5lDn2t549L345G3ZVMfeUde+Sx27Gj+wxsxUq43EeZwUIVUdrcHfT4q1hVOQF5TTgf9vrJMEOJDxe1w7L4rAmVxqtxxtV1UUUoOkGqUW9cmkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PL5mlcE0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517BNaEt032196
	for <dmaengine@vger.kernel.org>; Fri, 7 Feb 2025 20:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kDMiMudtV4tgXrnAq0wBH3
	feb/UwjZ0g++lmYLeshWU=; b=PL5mlcE0EoqntLZxTAHB3tdKWGaTln3Gos4ikq
	ivTq4o8QpTXZHwSma8QkcNSqOG9SgYe0/UtkznOE37N8h96p5H750cnBmKZ18i4k
	AXv/4OxEtUliSdKKdVyqkjApasPpZi6uAXetQuliUU9T47m+wsKNe0Y0XWAN/6KW
	P9D+KvHpe556cnjYTAE438sU189CdnhDAuRatemEDuQrie0V9VeTX/y59/HXLluw
	4V/lHdEMQPpTnU2IsE/Q5B5HvREJOGvop7qWqksacGI2rLa1qVqmmjzi6eYIDmup
	68RraPLethyUy3Oz83DbSvTscHsXhE9g9+yATRUdP0O30iVQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nh8us8vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 07 Feb 2025 20:11:48 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2b8515341c1so401649fac.1
        for <dmaengine@vger.kernel.org>; Fri, 07 Feb 2025 12:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738959107; x=1739563907;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDMiMudtV4tgXrnAq0wBH3feb/UwjZ0g++lmYLeshWU=;
        b=lYuTSxGH44qRrvY+2NIw2HbeDY68unGVVlZJ0+/479xXqm007TigR72bhtST/Iu5Kr
         o+Yx2PyCgxU/DG2boOSiLD3u+o+OvCwibdgidAQnpTx6odxYapp20O9Imq4eRIFRU2Pm
         PzY8RmljC6o59x2zqGO5wIrjlc3BXsWpI01T6q0QGyn0uyRqBrb91vgIFMJRwGxM1flj
         uh4PApW1DwhnhpALHvpoKUaENPLwnADIjZ2U3fZUyCwS9572guN+3UB96Fu7UVsg1x08
         yBBr840NKaBOJPL5fG6BCeRq3Jx0tVUSN0mBHq9qYFNc68zbYUqR3i7WOxUnZ3aKktpj
         fKvw==
X-Forwarded-Encrypted: i=1; AJvYcCX6qwwbXV8vuOhZBaj7aolXNccwYXSn1+c0/H9jUEl6UCVt/Q4y/IRULVVSXsrCCzsRXsQ5Gr9lmx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqELUr2ekCiefBbSGa3s8WNd/55aoighLwYo3o5HFYWhEM17X4
	ovKwiS7+qHSevf7/vwaniY9mn3Qe1F0k/rec63ZFQaLQF3priX2AalurJdxym40zoAfguR11XHf
	/a2+lWRzdqswbwyPZPtfLQ3Xp7zVLqdclW4rQB5Vgdqlcu7Sltjshv2St65IndOKML8U=
X-Gm-Gg: ASbGncvlLU+v3yfhYJLkN2+a0sW+pDwPUxYk6/TFrOBJzjhXjJxxwdH9T6s5Sx6HHH0
	h2omfWd3SybRJbGI/ZsqusGHjpi4ccUQ3obE3adFlULiXG4puHv+iJYzxIxJBtHe6vsb71FLwFC
	cRI3rfOnPRSdD8hHwjkiII63p2yyNll1rDVsDAysR5xG8PvvxdgFPhTBnda3h9kWxptEqNZ4bhj
	8o8ucf87rxsw5vvxTQUzNcMdydjsmNXR9xbJaStlIzxcQU0bqkGMFdYaajl7enWKKXCRhAdcgRm
	bxwTnA46o09GL6ZqYb0IHGfmB1wxSjpdPeLu91kpGSyiN/VHkyJ+COq0ywywetGuY7EDf+UfWV5
	jJCwA
X-Received: by 2002:a05:6871:628b:b0:2b7:5726:c931 with SMTP id 586e51a60fabf-2b84015e5bcmr2686347fac.5.1738959107054;
        Fri, 07 Feb 2025 12:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYyG3xljRm3I0DrpeKbRB9vGDzRlNGHyM0fmkRS4g7aLScA8naZOYGycC46hNgw83glXa44g==
X-Received: by 2002:a05:6871:628b:b0:2b7:5726:c931 with SMTP id 586e51a60fabf-2b84015e5bcmr2686329fac.5.1738959106644;
        Fri, 07 Feb 2025 12:11:46 -0800 (PST)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b825fe58a9sm1017758fac.20.2025.02.07.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:11:46 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Fri, 07 Feb 2025 12:17:33 -0800
Subject: [PATCH] dmaengine: qcom: bam_dma: Avoid accessing BAM_REVISION on
 remote BAM
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-bam-read-fix-v1-1-027975cf1a04@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFxqpmcC/x2MQQqAIBAAvxJ7bkFXQuor0UFzrT1koRCB9Pek4
 wzMVCichQtMXYXMtxQ5UwPdd7DuLm2MEhoDKRoUKYveHZjZBYzyIHmjabTBRKehJVfmpv/dvLz
 vB1R6MoteAAAA
To: Vinod Koul <vkoul@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2733;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=o0JjXXcxDBv5TFdiXfnwXkrMd28amcy8OmNIPYYWh9o=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnpmp1RtxFcyltaPy4QkUHiZuJjtKYg4o3K8zlj
 uCRKySR3oqJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZ6ZqdRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVD2g/6A8MHdtGf7f1BUcAhzUWaEHPcVGtQSlcHHwNHbIX
 fo4oS0rrmMpcXOinC/Hl/WlPZhg9kRewpVgGMT3rvIwNVWa7pLQbUpJHI98/MdQwxm5hKneFtuS
 wHwFdD10g6RpZka/HgEzwTv/rin2uTAHaHe2+zzqkRaE9raaU6vU95CKSG++u87l9CpCM6EPU34
 H8oAB0I9ixITUzOer489lG/ET4tF2MEdvA2/fCzJFpP+IDQ8bsq1gv+yEhNUb3jVjqsd3HuM7Qi
 nXBmnQS4GJ7K+MwZUxcGkYkDEnZovmEVmdyeCJtHy+NC2lf5NSPe9qk2UM7EFP04lrc3IjuBDD/
 IPl/5OV1o1dUp3ZTpP8RPm6w77ny787CMdgNEsIXIPvypzjrJVe3avTsCu451CjUD94tPdiTKKX
 G7A3+oqQWL3TP+fehmwPuxZSLLo7RJmdnrhmvi5Cn5FDI286SXccC0m1Qb9+cItD6E8KJyhtj2m
 bovtmyWVMuPRRKMdLJr5Hl66v5RwGzHxgfPwzsMljs6KCy23i9PqmqxRTlbloTw6aIKR+Roar1n
 HT7zL1UYc8QmvRfhY+T2NiQYMB1Z+YgQkGnIxj3gD7Lzmd+G3rc5y1iN/5RAHLKOwV/StU+eviN
 a4FYq6MWzrZu+hfukZJUHYupReI6NDun7YWL2zAsYP9w=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: 55koSaGNu2Zx3QjMZ_jT-_9nbgjUPGH8
X-Proofpoint-ORIG-GUID: 55koSaGNu2Zx3QjMZ_jT-_9nbgjUPGH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070151

Commit '57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing
unavailable register")' made this read unconditional, in order to
identify if the instance is BAM-NDP or BAM-Lite.
But the BAM_REVISION register is not accessible on remotely managed BAM
instances and attempts to access it causes the system to crash.

Move the access back to be conditional and expand the checks that was
introduced to restore the old behavior when no revision information is
available.

Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
Reported-by: Georgi Djakov <djakov@kernel.org>
Closes: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c14557efd577..d42d913492a8 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -445,8 +445,8 @@ static void bam_reset(struct bam_device *bdev)
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
 	/* set descriptor threshold, start with 4 bytes */
-	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
-		     BAM_NDP_REVISION_END))
+	if (!bdev->bam_revision ||
+	    in_range(bdev->bam_revision, BAM_NDP_REVISION_START, BAM_NDP_REVISION_END))
 		writel_relaxed(DEFAULT_CNT_THRSHLD,
 			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
@@ -1006,8 +1006,8 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 			maxburst = bchan->slave.src_maxburst;
 		else
 			maxburst = bchan->slave.dst_maxburst;
-		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
-			     BAM_NDP_REVISION_END))
+		if (!bdev->bam_revision ||
+		    in_range(bdev->bam_revision, BAM_NDP_REVISION_START, BAM_NDP_REVISION_END))
 			writel_relaxed(maxburst,
 				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 	}
@@ -1199,11 +1199,12 @@ static int bam_init(struct bam_device *bdev)
 	u32 val;
 
 	/* read revision and configuration information */
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
-	if (!bdev->num_ees)
+	if (!bdev->num_ees) {
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
 		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
 
-	bdev->bam_revision = val & REVISION_MASK;
+		bdev->bam_revision = val & REVISION_MASK;
+	}
 
 	/* check that configured EE is within range */
 	if (bdev->ee >= bdev->num_ees)

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-bam-read-fix-2b31297d3fa1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


