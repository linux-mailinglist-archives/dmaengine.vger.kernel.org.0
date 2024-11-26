Return-Path: <dmaengine+bounces-3797-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4F9D9783
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 13:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BF9164DAE
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6131D432F;
	Tue, 26 Nov 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m0DCrF2M"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE61D45E5;
	Tue, 26 Nov 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625532; cv=none; b=VjBDAJuQkOCVASBZCOkVCKPa08Z5S1k1dXiLC7bdMrUaMDSULuHerG0FTKRC61vTmd4E7PY+U3ZOe+WfZ0xRm+BvhsIlG+/rn29cvbY1x6GHaaNDxnIKBbtMLOsR/qPW5xkr0eqyArzXqQkkj5vtThuAIkcEqaXADuqxbAiMrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625532; c=relaxed/simple;
	bh=/acHYtFNj06wvc7vTNE/a0R48sIgzIGssjgoP0DHf8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZvdy42KrDemEYOml2bkfI0VTZJeBSz/2kFszXgDQyFOu1WQDYrQeUITLh2GcN7a8unSV+S7Sdz7hOup8Fe5nZaeELz89C75ewtfStrWZcXiu7M08ejs7eLt5+g94JEtBvewKUtltzvRRlQm4fB8SzOCzjOJmKwol2kZgaND1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m0DCrF2M; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQCq7t3107389;
	Tue, 26 Nov 2024 06:52:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732625527;
	bh=TsG/YxY9Tn6z4GYZbT+eG4y83xYCvHonowy9SHnDCJY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=m0DCrF2M+GOC/6/GWmKRMk/UJNXxHSXTeO4EPLJEON+1CdhNNfcafXr1ypMPTFbLf
	 v8AdWM8y5RS3g13+CNN60CDfN8ziDDBVi4OrGpbAD2L4SPhkMiK2gS+XQQTl5UpwK6
	 K97UPP7QtbC6iPRdAfq1GsrAZUps44+OJntxvrpQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQCq7Qo106891
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Nov 2024 06:52:07 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 06:52:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 06:52:05 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQCpwjo100089;
	Tue, 26 Nov 2024 06:52:02 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v2 2/2] dmaengine: ti: k3-udma: Add support for J722S CSI BCDMA
Date: Tue, 26 Nov 2024 18:21:58 +0530
Message-ID: <20241126125158.37744-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126125158.37744-1-vaishnav.a@ti.com>
References: <20241126125158.37744-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S CSI BCDMA is similar to J721S2 CSI BCDMA but there are
slight integration differences like different PSIL thread
base ID which is handled in the driver. Add an entry
to support J722S CSIRX.

J722S TRM (11.2 Data Movement Subsystem):
https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
	* Add new compatible for J722S instead of modifying AM62A

V1: https://lore.kernel.org/all/20241125083914.2934815-2-vaishnav.a@ti.com/

CSI2RX capture test results on J722S EVM with 4 x IMX219:
https://gist.github.com/vaishnavachath/e2eaed62ee8f53428ee9b830aaa02cc3

 drivers/dma/ti/k3-udma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b3f27b3f9209..7ed1956b4642 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4404,6 +4404,18 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
 	.soc_data = &j721s2_bcdma_csi_soc_data,
 };
 
+static struct udma_match_data j722s_bcdma_csi_data = {
+	.type = DMA_TYPE_BCDMA,
+	.psil_base = 0x3100,
+	.enable_memcpy_support = false,
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
+	.soc_data = &j721s2_bcdma_csi_soc_data,
+};
+
 static const struct of_device_id udma_of_match[] = {
 	{
 		.compatible = "ti,am654-navss-main-udmap",
@@ -4435,6 +4447,10 @@ static const struct of_device_id udma_of_match[] = {
 		.compatible = "ti,j721s2-dmss-bcdma-csi",
 		.data = &j721s2_bcdma_csi_data,
 	},
+	{
+		.compatible = "ti,j722s-dmss-bcdma-csi",
+		.data = &j722s_bcdma_csi_data,
+	},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, udma_of_match);
-- 
2.34.1


