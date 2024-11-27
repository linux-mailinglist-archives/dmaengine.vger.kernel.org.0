Return-Path: <dmaengine+bounces-3804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E19DA58A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D451162C22
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D6194C6F;
	Wed, 27 Nov 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H5UnbwW+"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB2192D6A;
	Wed, 27 Nov 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702610; cv=none; b=vCL/qwxR8kIrcP5v9rUvuQkSjJJPbPO9MqmV7os6h2h2w0mJ5H4G55z7Ct3WJAJQ4Zwaqv+y0XVOAnSOJH/mVjnTUwQZ55wnGmm6G68rTqQukaEYqv5v8Nvz2LMrKF1bnuvTfh77CLbUqtVCYY40zA9cav4PF1Hvm8KiX/QPrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702610; c=relaxed/simple;
	bh=qfCyvtY99DfDmPqgaQS+U84tT5eant8410Ojc4A6OEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huo7yCsFHY7Le0//xVSH4oZI4EWGZVBO+xrkuGLeDVaY/LuheGmNnpcFYfNusbJ7RTA5d7hxBOHMSUgRZKQwX86OLbcl1GqoS7fBH3P7HRc93UD2Pc9AZp7zLg8hx/QzFhY5nYeO2NFB2tie0ZLVAyFW5ie2r/WUy37B77oPip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H5UnbwW+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ARAGd5V012437;
	Wed, 27 Nov 2024 04:16:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732702599;
	bh=ZY7nVrJb3L8ZPeALxkMls6WK7R1jRQchtAmQWRa5Ebs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H5UnbwW+p2TsTaVNIKdL+fGor0prhdi9Yz6AMNOQcsT48gO1snu2PGugyhdXbcNjk
	 VfAzD2pVXoI/SbZ1PeaUTTcipLwu8tVOIotwi+F7P/0wJXdA5j0J1QsaqP4JO8ckHR
	 YZ8uZM1P0duKDoJ6y97+NRZ2wBQxm7ynXERPUGmE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARAGd6V038509
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Nov 2024 04:16:39 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 04:16:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 04:16:38 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ARAGRoM104602;
	Wed, 27 Nov 2024 04:16:35 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v3 2/2] dmaengine: ti: k3-udma: Add support for J722S CSI BCDMA
Date: Wed, 27 Nov 2024 15:46:27 +0530
Message-ID: <20241127101627.617537-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127101627.617537-1-vaishnav.a@ti.com>
References: <20241127101627.617537-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S CSI BCDMA is similar to J721S2 CSI BCDMA but there are slight
integration differences like different PSIL thread base ID which is
currently handled in the driver based on udma_of_match data. Add an
entry to support J722S CSIRX.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V2->V3 : Minor edit in commit message.

V1->V2:
	* Add new compatible for J722S instead of modifying AM62A

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


