Return-Path: <dmaengine+bounces-4292-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF6A28A0F
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C08B3A9277
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287422C33C;
	Wed,  5 Feb 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BigginXc"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA622ACF3;
	Wed,  5 Feb 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757900; cv=none; b=RdUoWPAxufkT+394k7Ap+Gz90s5Hjq8XBxCMJUk9w5CbcTC/PRfhIn+wn1fIkeEXyvUHOLdn27MihObWRqMb5SMsUqHJq2arLOyxskYMSMRDdzHEIXEfNpyc66qA4GkYOTbRFy7pNkPaXj1aCyZ5UrEH1siooqk1kmSm01T2Tlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757900; c=relaxed/simple;
	bh=twv/zklPczSbnNe+2Biv8DEX5i3eV+yTDJPYWyQBI2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evnCOHbPIkJRGFlvriIvWtJ8HWJ+iA5pfBL2srSwZOBLjrx4ndikRoCqrIElhMUA31o+l2xEo7bf507O/eKcxDZcRaALMu6jrisWd3nUVr4pRU0NJkfpoDk9ICWd09Xy+UJF1Eq7n52QS4I/Jjm18zEtb+IVywyOzFmtuT20SLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BigginXc; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515CI9MH2529619
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 06:18:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738757889;
	bh=urwHlgDO2lKuC9/wGjafEmW2fGbENgohK10qmloExbc=;
	h=From:To:CC:Subject:Date;
	b=BigginXcRnAdyEUjb12W009uOLlGrmFC2wMxOltdTIfpz/IolOl41kRFQmIrXP9rE
	 hZ3HAsFj/mO0/ytFiJVRp5GWb6FIgQ9icVpZLzHkzpQTIXbLkyPEhLqoO2SeeCdVdn
	 HVhFX7fAD4v1QMQMVY+FqF4bJ2RfZjVFzjTRrGc8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 515CI9GN009081
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Feb 2025 06:18:09 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 06:18:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 06:18:09 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515CI6lk071061;
	Wed, 5 Feb 2025 06:18:06 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Enable second resource range for BCDMA and PKTDMA
Date: Wed, 5 Feb 2025 17:48:01 +0530
Message-ID: <20250205121805.316792-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
combination of up to two resource ranges. The first resource range handles
the default partitioning wherein all resources belonging to that range are
allocated to a single entity and form a continuous range. For use-cases
where the resources are shared across multiple entities and require to be
described via discontinuous ranges, a second resource range is required.

Currently, udma_setup_resources() supports handling resources that belong
to the second range. Extend bcdma_setup_resources() and
pktdma_setup_resources() to support the same.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7ed1956b4642..b223a7aacb0c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4886,6 +4886,12 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i].start = rm_res->desc[i].start +
 							oes->bcdma_bchan_ring;
 				irq_res.desc[i].num = rm_res->desc[i].num;
+
+				if (rm_res->desc[i].num_sec) {
+					irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+									oes->bcdma_bchan_ring;
+					irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+				}
 			}
 		}
 	} else {
@@ -4909,6 +4915,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_tchan_ring;
 				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+
+				if (rm_res->desc[j].num_sec) {
+					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_tchan_data;
+					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_tchan_ring;
+					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+				}
 			}
 		}
 	}
@@ -4929,6 +4944,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_rchan_ring;
 				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+
+				if (rm_res->desc[j].num_sec) {
+					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_rchan_data;
+					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_rchan_ring;
+					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+				}
 			}
 		}
 	}
@@ -5063,6 +5087,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 			irq_res.desc[i].start = rm_res->desc[i].start +
 						oes->pktdma_tchan_flow;
 			irq_res.desc[i].num = rm_res->desc[i].num;
+
+			if (rm_res->desc[i].num_sec) {
+				irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+								oes->pktdma_tchan_flow;
+				irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+			}
 		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
@@ -5074,6 +5104,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 			irq_res.desc[i].start = rm_res->desc[j].start +
 						oes->pktdma_rchan_flow;
 			irq_res.desc[i].num = rm_res->desc[j].num;
+
+			if (rm_res->desc[j].num_sec) {
+				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+								oes->pktdma_rchan_flow;
+				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+			}
 		}
 	}
 	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-- 
2.43.0


