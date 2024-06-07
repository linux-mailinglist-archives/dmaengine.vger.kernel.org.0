Return-Path: <dmaengine+bounces-2317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EFC900BB9
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFB2812B2
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABAA197543;
	Fri,  7 Jun 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="grDTLYT9"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DBC13793E;
	Fri,  7 Jun 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783879; cv=none; b=Zvr0GZx986qqBzknjF/4H8PFrZXS+w52SQYOv0hzgnb8v9TXDOiWZrBtio9f753h6Kd2xO2pK8JYgYq29hC5kZuZJzisKdnWyBBxb0ArQOVO/ARMfyBZ24jw3AUG/m0xjbOAJvVD/D3hMzRUSeqrIeUyJGo/8QvHrLPvwCveQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783879; c=relaxed/simple;
	bh=uP6g4ZiyWGtPQ7RHo7iYlw0mMYp0OieY9LHKtLNrOrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qLleepPxvc7BnckRDUIH7zZ6iCZP7Xt22wdXyaDl8My7mgosThCiIEVXlltMWq9Sb0jM+Ae7BndKMwBCrcDl1PMMmYVxHNwwiBdB0WmnXWB/CSeCmjWVWR+J8PUdDTsgyVezNNFwGbLsqeSGVlg2K89jzo0DS9wlRqCqpmZq+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=grDTLYT9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457IB8qc084349;
	Fri, 7 Jun 2024 13:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717783868;
	bh=1NbOSS+4rivslz6nKFc+8bXVa0m/UsOBAIGS0ru8ukg=;
	h=From:Date:Subject:To:CC;
	b=grDTLYT90srjuBoZvfUFkjM143ofl3i5zfoh4N9yTXUBt6pR1/HurXe05CTGtf34U
	 cl3iPYQT/z5H42N36j12692D7c4LeL0G72dUoQWhl6Jh5fm0hj8/NtHfQsZL1t7TFW
	 YU9NSdHMF1+P2qoYxow6aRp9d3ZMW2rrUNaCvrZs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457IB8Mp034461
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 13:11:08 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 13:11:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 13:11:08 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457IB7ew118297;
	Fri, 7 Jun 2024 13:11:08 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Fri, 7 Jun 2024 23:41:03 +0530
Subject: [PATCH v2] dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC
 channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com>
X-B4-Tracking: v=1; b=H4sIADZNY2YC/3WMQQ6DIBREr2L+ujRIlUhXvUdjDHyw/oXYACFtD
 Hcvum9m9WYyb4foArkI92aH4DJF2nwFcWkAF+1fjpGtDIKLjkveMYN21dOxTegTMwYlclS96BX
 U0zu4mT6n8DlWXiimLXxPf26P9q8qt6zGDeomZjlY1I9EV9xWGEspPyTVN9epAAAA
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vignesh Raghavendra <vigneshr@ti.com>

Unlike other channel counts in CAPx registers, BCDMA BCHAN CNT doesn't
include UHC and HC BC channels. So include them explicitly to arrive at
total BC channel in the instance.

Fixes: 8844898028d4 ("dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v2:
- Add all BCHANs in a single operation
- Update the Fixes tag to the commit adding TPL support
- Link to v1: https://lore.kernel.org/r/20240604-bcdma_chan_cnt-v1-1-1e8932f68dca@ti.com
---
 drivers/dma/ti/k3-udma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6400d06588a2..df507d96660b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4472,7 +4472,9 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 		ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
 		break;
 	case DMA_TYPE_BCDMA:
-		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
+		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2) +
+				BCDMA_CAP3_HBCHAN_CNT(cap3) +
+				BCDMA_CAP3_UBCHAN_CNT(cap3);
 		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
 		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
 		ud->rflow_cnt = ud->rchan_cnt;

---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240604-bcdma_chan_cnt-bbc6c0c95259

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


