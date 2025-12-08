Return-Path: <dmaengine+bounces-7527-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9BBCABCCF
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B523004F7F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 02:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570EC2236FD;
	Mon,  8 Dec 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SfEFZt0j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4ok5T+W"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692025DD1E
	for <dmaengine@vger.kernel.org>; Mon,  8 Dec 2025 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159665; cv=none; b=JfwdvopsF8OaLQlBbbOc/4XWnIBYLJk6v84HqyxUMAekba0B8oqEDAZA+RdtZVoJphQBYdZgzEEVB7NVL+gCmeD8RAvwKJD0Kvg2vJQKUCw0jwhVvaFG6FqEsOBdyrQNXGjGSgXvYJAPSQLfOc6dw49oWEMh5uZxvUwxi8+ckbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159665; c=relaxed/simple;
	bh=gMen/gq2qbb3evDcxh/JIUbW5y5jZwuYFY2YO25kuro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJvqMUyVKMOb0wuN+OOBAE6mlimfNmRon009FIBEK//M+oJltwyh48pnShbJGCIvYSqDFK+PUMOmZwk0LmFFSQ5sp4PvgrgHBZNaz/jCfmd6MR8L/mVqqmeUhJq3mQgCQh8IUuIYuTXOd1Ax/bDwFBk566Cd+R7RDb5tIp780P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SfEFZt0j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4ok5T+W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B826srT3668968
	for <dmaengine@vger.kernel.org>; Mon, 8 Dec 2025 02:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kyHmknQkCVxLSMd4maYwpzVVh7sGVCZ9KQx
	o0EUBDD4=; b=SfEFZt0jM7dx40OXlp4oUpIFWf0dyiPQyHpR3DJGD1RmYJWhiud
	ztQCxEqStGLrkbWrSSeMDLT1s5z+eC6BxS/OZDtvXMj/0T66DN9aim2gpX3Oq+xB
	2Nu4iWEu+5z2Vt3axQLTqmWrfgIbZvf35z3hBRfJLLhHDF2XVMwhz7HRrE7YXFuz
	9Ypcv40072YkZDbAHdlMKqvweeHpKjoN+eShwPeM0UfOyzmbEi6xTu9HppqvpHT+
	CWVgWR9QwvSmzNLCC1J5Q6mzVRfT7fFH6znB5exHTLVbBvbw+eXSnVJ71JPhTxXO
	2HQf9ksxk+E2PV7pqN6k2YLdtdIWffHXXaQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awnkr001p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Dec 2025 02:07:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34a1bca4c2aso597333a91.1
        for <dmaengine@vger.kernel.org>; Sun, 07 Dec 2025 18:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159656; x=1765764456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyHmknQkCVxLSMd4maYwpzVVh7sGVCZ9KQxo0EUBDD4=;
        b=a4ok5T+WHLc+VmFYpc6U5heOtoxJ5dAqD3xFaWjNKlVXfRREz1mvRK+2Zq6q3yIO4D
         SEnihKj/lBSItLzZDgCmHWLqKDfj6Dh8eSnr89Wk8zQcufE1kg5mfeACUj4BJCi88ocS
         +S0nLHYQ2fX6fX4GUs9n2FGC/BK+uXmmvVZOlt+dR/QhZO06LdEL4wFfXjRuQrD3clFa
         p4JIBt4DrKZhxLXW3mW/ewxsHAKqUB99XPcyDExernvD1UQSHgZY2iZU0fIqejcs83lN
         UOsdP6GfzoRT8scnDdkuOZKOGO/Wzu5wbqv45S0/pOQR1J4MweQnU+Qaz9br+7tRd3la
         JtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159656; x=1765764456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyHmknQkCVxLSMd4maYwpzVVh7sGVCZ9KQxo0EUBDD4=;
        b=XtmEILK+8ebfsWHJRo4UJUrFlSQn9EUs9EwaA02nTFbYeDx70yk9MCql/Uq2mTjy0D
         fOrpF0WjHhkG4JuPWmm5Nj52HKmHFMIelngAxurtCfCt1HvHnab/Z6SGGe1u54SwakAX
         IWKcfmigUhdcHB97E1Ewe+3k5clY3gynO/11eILrFL5WE0YrmIfKUzFlXNR7pqHNFrIg
         XyTLmXHFJ7gqDsaK412Z2VOwhDodomY31BpYiH1hElD/Ruox8A8sZA8fdvtMckjxqyzW
         JNTTt3wamqN7LwXLsW43T9mt0rxLrOQ5LWvmip4cXC5lu9NSJk6v3yhkCzAGX2lIZsTy
         sN9w==
X-Forwarded-Encrypted: i=1; AJvYcCVQkKHYzAyWWQvBDmMXzlqPZpe1vrjd7TA2kbE+B8vZ0ef5a9X4IERE6I1VZ9keLYYvmqFiazAsmyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DHXmXlDz8q8dodf+p2g3ED4C6uBttVWW7bkjGkq/G4/OSrA4
	CqgTapwqYZnsk9caErAR3lzZBQKg+ERQGHoVGrRx671CWCRhymg2PisDaZHO99wenCOb2hBaPk3
	mu8e5NI4BeSm/nHWb7t9GDn2xUOneKEvPuzMubewCvFdSMRAX4PYoz1cMScQ+R68=
X-Gm-Gg: ASbGncuT3dMp2Fu6l5rQpICGR/KDak7Cri/4IUl8x/w0uvHwYqdEeRc1mNbyoRj29bJ
	wU7SY606EocvVOXZ8Ug4XVxAAbNWhNkA5kC6RYUC+DedsZ/L14K+YVqwyGRMsRgOObSHIkwDVaO
	Cza3SU76Ix2XZJ+i2v1imfpV4+H5fEuT5IuTsM7+zrovAedDyRiYvnuMXWTuqfRzOzMJ96Mi/+B
	PmNf7zYsk96Vg1r9R1mxea/fTOPhWh0BgTDNt6yKcYdfSbpgn9Fe0+NBvAPJnkBIpwTCs3n5W/d
	8y3f+iRXDjZQufRkDpY+CWyO+R6tLLrnFv+Y3qz/kNN7wx3ZCdy9xo/XVF4reZhZMOtth4SYsCz
	o1hix/mpqL3hCBkHDlbwoO12CeZgwblfIjqOlcBlm9BIl5VNXSR448CiL
X-Received: by 2002:a17:90b:3147:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-349a2563d8emr5189563a91.13.1765159655860;
        Sun, 07 Dec 2025 18:07:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP8sXQR2Sb8rm/y1E0aqY/cAdvNLNh7/WjP0gnZUZkqH9ZRzEPk9fjBRdnLGdjSlWj3XZeOA==
X-Received: by 2002:a17:90b:3147:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-349a2563d8emr5189545a91.13.1765159655416;
        Sun, 07 Dec 2025 18:07:35 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349a28cdf5asm4992382a91.4.2025.12.07.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:07:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dmaengine: dw-edma: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:07:30 +0100
Message-ID: <20251208020729.4654-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=gMen/gq2qbb3evDcxh/JIUbW5y5jZwuYFY2YO25kuro=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjLhreeR6+EoBlpnTlVWIvGVDeLfVkpuYqxuV
 ttd5VVdpJSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYy4QAKCRDBN2bmhouD
 1yiJD/93hoNzW//isX/4xi2/d9VssT6jT9Dx4StYMk5Ww7eguZv9axEBJaUst9MOaudEXiqb+BF
 OOnP2GoDg0EuUhBLPpjp8MkOaP3KIwfnZZXNKtv3nWGjRYz3Q3pMPcnz0ykdrLRuuEz1GJK9/qL
 PR0pD5vPWXGpWjJq4P2fYv6VsFZDuuYZ7MZYB2MxqjXPGk8Oe1rgYScY+YfHPVoxIPpgHMDFenj
 URJFdpYfJwKE2hS+SwtPlCZQ7Js7xuS5KMO1W4C/1AcQk4PCErFD7F7KcT4gCBAlDO/19IsaHuE
 8U0pzLyBw5xCakVZWl9l4VDNXWZ7fPX3uERw2ZC4hRWIQlTfXiehMjc7v+4CNh63aFv03vq5Mvc
 baSBDx5bDP02AODeWI1aeS6AI7HZ/nMmdBQfCqXsdB3nR4fyCArI6sR6931skKpM8MnpweZgRsd
 /BlwFChBIK5Q3aDXGp2+SFarbFLynGBhXcYTFzNbam6ygdz2eRO8RwTS+jiUTCKadxo2F/IRHJ9
 P/ghE4sTF3LGHLXOPdaC+eUvsqTU8UlX8FPH4Jvis0qmF6Wy5/VwFnbUDTV4cgCHC2M7/CFlAkZ
 Gsi35Xjdcbc34rl+cDc0dbkPA4LzEhm6zGL73AHqLCcVwbslbLPFn36VcJ4THGnyM7tDqoRfSmK OqnzBPGWAm3guTw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNSBTYWx0ZWRfX44tb/Kj1ZtPj
 wtg9sWoI3AIqVJwlNwSUf5wPQu0P03v3p47nSeKI3ixkUbPqGuql2l1cKqdSQBgLNcf0RtzvJjn
 qOlS8UaIFEx0MD2fmnCkxQ5ffTCua3JsixoxQ4aiSyTD8zTICu8JbY8tXEKpqhhVGG8llzvoBdp
 bDwT3A/ZaxIEtMg0cURilM2y5tBZOd7XKelUHgpby0OyDAOHo88lD3gIuwKdegz1uokZSS9OpYv
 0LASrFCN900AL4F/jF3juAIUuMqdoG00qhwh3vw0IVU9KO7fpqFzw7PILaq0Vc+2g/ZyWgRQKWh
 URMwEElBklc/FIOyubhTHUZT1OdD1rV/HmI8WkE8j7SQbdQFlqh24vJHtf2nj6vXt2oMQoP754s
 z+F3nq+tFPBVFTf82EYC3a5fyyF4pw==
X-Proofpoint-GUID: YVNzD-mhK6KpMwSWzMXKovSwjRsKWbji
X-Proofpoint-ORIG-GUID: YVNzD-mhK6KpMwSWzMXKovSwjRsKWbji
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=693632e9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5IeaWxQi5oGOKGcrkHwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080015

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a76d3c..e9caf8adca1f 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -161,13 +161,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
 	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
-	struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
 
-	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
+	struct dw_edma_pcie_data *vsec_data __free(kfree) =
+		kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
 		return -ENOMEM;
 
-- 
2.51.0


