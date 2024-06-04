Return-Path: <dmaengine+bounces-2252-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027188FAF43
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E46B1C20D97
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 09:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B82113A415;
	Tue,  4 Jun 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qA/DEVzn"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD684D3B;
	Tue,  4 Jun 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494718; cv=none; b=sdhZpgJrdbIOkoywfPdS4DQkUGS8HFdghvZlyqTKG+LUa95pRGv29MH+q1pA1MITuQJyV3v8bw9s1H8iiXbi47vtoCh2+e0GTvz6O4WyYqzIhS/I61Mmu6OUTSVTVakv7iiaQH/+tmhxQOZMzCnL8T58b5LWfdORleQygJzndYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494718; c=relaxed/simple;
	bh=lUkUOCHF7Cv2+ZbTj4MRALKLAq5jCkTjjmNKw5SUwDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=m1u3cp6iLC2GQ5IZ+GURH9fkF7jpAV1e3jz5WhOfe0Y7FGPPoShDHcnweUwuDsEkBONKaFqaD00LdK0l+rOzpaz14uFA2G6ZX0PbgavAw0Xu+ZXd3mSKBOCSR2dmtgC42B9cyBGeViHNH0tl2PQiow6GvtHJVNTCF+xNuzzzrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qA/DEVzn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549podN075113;
	Tue, 4 Jun 2024 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494710;
	bh=UN6MRQsiFgn85Z14EkWiM1zef5zvhpmb+LBqJbxYsls=;
	h=From:Date:Subject:To:CC;
	b=qA/DEVzn2YITZREohsgpP9BQPBMqYY3eftA9/pScVelJSIhaXWE7o2AmHyziT8NA3
	 /scPVZ3fpeignpAy0uXxMPcj59CozWt0bJ+JRjyH7/6cG5n009BDK1KSpTW6QP5j9X
	 fFoQ+/KLaYb3e/5vrK83NKHK4Uq51UVgKOHRQonE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549poZa126159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:51:50 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:51:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:51:49 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549pnmF026144;
	Tue, 4 Jun 2024 04:51:49 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:21:38 +0530
Subject: [PATCH] dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC
 channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-bcdma_chan_cnt-v1-1-1e8932f68dca@ti.com>
X-B4-Tracking: v=1; b=H4sIAKnjXmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMT3aTklNzEeJBcfHJeiW5SUrJZskGypamRqaUSUFNBUWpaZgXYwOj
 Y2loAT0M0qmAAAAA=
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=t22mFWigPDDkhAH+uX6y+nKLter3GXv2IBL4efY9NfM=;
 b=kA0DAAgBQ96R+SSacUUByyZiAGZe47OinCr/dhDCEo51vT9i8NTK7Ufq6EIVe+AJz0ojjicu6
 YkCMwQAAQgAHRYhBE3g2Bjl1XXo1FqvxUPekfkkmnFFBQJmXuOzAAoJEEPekfkkmnFFl84P/0sy
 uI31WIkC+V/SUQCVqijXCiHedERAc0Jwtg6gIqH1Xa88iM4nYuZuGv6oh7CeWusX17GS0S3bOIZ
 3i5MzbL9Ir0o/PvD6g+0XKvgR9X/xsRu3+66bcyW7jOsyuzYxzFDKGMSiHoPXqypuL+CbbQ05Xf
 mJpx6uenoWJsvG9iTRC5oiyWm8jkCjl9b87BKGcXfnWkqCeJBKYlSsTrk16xHn7WxWewml9Yliy
 n14UCZnXxzlz8x+95rfHo4xe+fA/6o3PvH8Tl3LCLXX1H/obj3E7L51glZ8xo4FYJtstO5BeF8n
 73pfVKZ8RUGNMbKGwvrVNbCC1IW1A9/xqntFejEm4XbtK7Pwn9exGKjPd6DEpEoIcQSUA+lI4eD
 VmMtpmhgsoNRvqTm+aLkqljyyGrW7g6Ojaqijxqmxh/cqLWvA9oNUX3lWVwuNDFRdFvSV7V8z7U
 EB9Kxtc2mYbj/6iDS1YYSxO8twZPsrlHwwjQ/h53tk38R+Sj3z8MTxpFGNYZ7W3VTVmo1eqHxuv
 foaHrzOapn6XW9jUBL4wFo7nLQczhL/hwdpc96bewZhqIE+GAYYNtfTA+CFnBpHvmPUIjRD50kj
 27kTylk2MNTNfs3s2OGokHmGO0ysaOasorrESQ49lLoOs3KD9LiPLmGP9vUZ2kP1fcjHXyeNsA0
 Kyppb
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vignesh Raghavendra <vigneshr@ti.com>

Unlike other channel counts in CAPx registers, BCDMA BCHAN CNT doesn't
include UHC and HC BC channels. So include them explicitly to arrive at
total BC channel in the instance.

Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6400d06588a2..710296dfd0ae 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4473,6 +4473,7 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 		break;
 	case DMA_TYPE_BCDMA:
 		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
+		ud->bchan_cnt += BCDMA_CAP3_HBCHAN_CNT(cap3) + BCDMA_CAP3_UBCHAN_CNT(cap3);
 		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
 		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
 		ud->rflow_cnt = ud->rchan_cnt;

---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240604-bcdma_chan_cnt-bbc6c0c95259

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


