Return-Path: <dmaengine+bounces-821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E599683C09C
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2C288D13
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64F02C696;
	Thu, 25 Jan 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wJQsllC7"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA328DC4;
	Thu, 25 Jan 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181298; cv=none; b=OfkgbXIghul6tw66KcKA4Vstr3XPayXlMAOkmhmNq12ROuL6mKmAVQx0sP5drVmWs94Fafj45WaVVs1U4fD+IUygvNL7ofIjAqwZjgBBOnEdKSfeBT8ZfgZcBUOla2oCyfvbfBZPnwXSPmmo8at0n9EAPS/IlXmzcSRypFEWptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181298; c=relaxed/simple;
	bh=HZxAE4+693ZGgkuVWmJaA59ddkhcAmD22T3imvZcIGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHz906E8dpnpTonmNXUymwXXy+Ee2XbO9XaIn5mB5jOpFbH+bQmQOVAPKPKjcGZb8HIIE81KSyeQ8eAXS7WctGAJ9CfX+UzjZx9L+PnVOG6LdbfUJlzD/oHH8nfhgbHn8vgqdyBiXu/A3vvG0kMinXrCDqBSh12WKbTUo/rNdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wJQsllC7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PBEqpV084295;
	Thu, 25 Jan 2024 05:14:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706181292;
	bh=zwL0qHW+HcUrrm4Rz75LXs6hgLXZji8xSGHiZZgScfU=;
	h=From:To:CC:Subject:Date;
	b=wJQsllC7UEvtwMm+JK/2Lp50j+YRGK+yXfVqFGtEJH24LO1Wyb9C1yVaZwa3ly3hU
	 CasYrIgj11BN2uZsdu0Z+ffvK+zVeb7e0erUGGKipa7Huq7sn2u2/n/GIgK18/Kcbj
	 BpYP8ieo2fzZcGGHi7wrqaYw8LfGZVuKgmQ3iqaM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PBEqNj080677
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 05:14:52 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 05:14:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 05:14:52 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PBEn8u089844;
	Thu, 25 Jan 2024 05:14:50 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vkoul@kernel.org>, <peter.ujfalusi@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil-j721s2: Add entry for CSI2RX
Date: Thu, 25 Jan 2024 16:44:49 +0530
Message-ID: <20240125111449.855876-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
have up to 32 threads per instance. J721S2 has two instances of the
subsystem, so there are 64 threads total, Add them to the endpoint map.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
Tested on J721S2 EVM on 6.8.0-rc1-next-20240124 for CSI2RX capture with
OV5640: https://gist.github.com/vaishnavachath/e6918ae4dadeb34c4cbad515bffcc558

 drivers/dma/ti/k3-psil-j721s2.c | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
index 1d5430fc5724..ba08bdcdcd2b 100644
--- a/drivers/dma/ti/k3-psil-j721s2.c
+++ b/drivers/dma/ti/k3-psil-j721s2.c
@@ -57,6 +57,14 @@
 		},					\
 	}
 
+#define PSIL_CSI2RX(x)					\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+		},					\
+	}
+
 /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
 static struct psil_ep j721s2_src_ep_map[] = {
 	/* PDMA_MCASP - McASP0-4 */
@@ -114,6 +122,71 @@ static struct psil_ep j721s2_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4707),
 	PSIL_PDMA_XY_PKT(0x4708),
 	PSIL_PDMA_XY_PKT(0x4709),
+	/* CSI2RX */
+	PSIL_CSI2RX(0x4940),
+	PSIL_CSI2RX(0x4941),
+	PSIL_CSI2RX(0x4942),
+	PSIL_CSI2RX(0x4943),
+	PSIL_CSI2RX(0x4944),
+	PSIL_CSI2RX(0x4945),
+	PSIL_CSI2RX(0x4946),
+	PSIL_CSI2RX(0x4947),
+	PSIL_CSI2RX(0x4948),
+	PSIL_CSI2RX(0x4949),
+	PSIL_CSI2RX(0x494a),
+	PSIL_CSI2RX(0x494b),
+	PSIL_CSI2RX(0x494c),
+	PSIL_CSI2RX(0x494d),
+	PSIL_CSI2RX(0x494e),
+	PSIL_CSI2RX(0x494f),
+	PSIL_CSI2RX(0x4950),
+	PSIL_CSI2RX(0x4951),
+	PSIL_CSI2RX(0x4952),
+	PSIL_CSI2RX(0x4953),
+	PSIL_CSI2RX(0x4954),
+	PSIL_CSI2RX(0x4955),
+	PSIL_CSI2RX(0x4956),
+	PSIL_CSI2RX(0x4957),
+	PSIL_CSI2RX(0x4958),
+	PSIL_CSI2RX(0x4959),
+	PSIL_CSI2RX(0x495a),
+	PSIL_CSI2RX(0x495b),
+	PSIL_CSI2RX(0x495c),
+	PSIL_CSI2RX(0x495d),
+	PSIL_CSI2RX(0x495e),
+	PSIL_CSI2RX(0x495f),
+	PSIL_CSI2RX(0x4960),
+	PSIL_CSI2RX(0x4961),
+	PSIL_CSI2RX(0x4962),
+	PSIL_CSI2RX(0x4963),
+	PSIL_CSI2RX(0x4964),
+	PSIL_CSI2RX(0x4965),
+	PSIL_CSI2RX(0x4966),
+	PSIL_CSI2RX(0x4967),
+	PSIL_CSI2RX(0x4968),
+	PSIL_CSI2RX(0x4969),
+	PSIL_CSI2RX(0x496a),
+	PSIL_CSI2RX(0x496b),
+	PSIL_CSI2RX(0x496c),
+	PSIL_CSI2RX(0x496d),
+	PSIL_CSI2RX(0x496e),
+	PSIL_CSI2RX(0x496f),
+	PSIL_CSI2RX(0x4970),
+	PSIL_CSI2RX(0x4971),
+	PSIL_CSI2RX(0x4972),
+	PSIL_CSI2RX(0x4973),
+	PSIL_CSI2RX(0x4974),
+	PSIL_CSI2RX(0x4975),
+	PSIL_CSI2RX(0x4976),
+	PSIL_CSI2RX(0x4977),
+	PSIL_CSI2RX(0x4978),
+	PSIL_CSI2RX(0x4979),
+	PSIL_CSI2RX(0x497a),
+	PSIL_CSI2RX(0x497b),
+	PSIL_CSI2RX(0x497c),
+	PSIL_CSI2RX(0x497d),
+	PSIL_CSI2RX(0x497e),
+	PSIL_CSI2RX(0x497f),
 	/* MAIN SA2UL */
 	PSIL_SA2UL(0x4a40, 0),
 	PSIL_SA2UL(0x4a41, 0),
-- 
2.34.1


