Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7B456F83
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 14:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhKSN03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 08:26:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56130 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhKSN03 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 08:26:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDNQld095904;
        Fri, 19 Nov 2021 07:23:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637328206;
        bh=BBXJ/b5sPYbB356jWMzfygFqZ2TuG47zr60+AaJBZKI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IZPRt9Ns7F9jP9g0ki3zNWdY6Fi/eepmCbnGFPthiarjVeLecmGdClVAmX6O0E1PJ
         vuWSAnLP64WNJt6UgpJHtPu9j5bSBzrmm133iGjnowLGyoaKXm5C5u07PU3JuonRFU
         zQBEGnOQogmAJPlNp5k0JUP8YFGOIwz873mWVT3g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AJDNQUi075784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 07:23:26 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 19
 Nov 2021 07:23:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 19 Nov 2021 07:23:25 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDNHbV098826;
        Fri, 19 Nov 2021 07:23:23 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 1/2] dmaengine: ti: k3-udma: Add SoC dependent data for J721S2 SoC
Date:   Fri, 19 Nov 2021 18:53:13 +0530
Message-ID: <20211119132315.15901-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119132315.15901-1-a-govindraju@ti.com>
References: <20211119132315.15901-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add SYSFW defined rchan_oes_offset number for J721S2 SoC in soc data.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 041d8e32d630..895dcd0e8b60 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4376,6 +4376,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J721E", .data = &j721e_soc_data },
 	{ .family = "J7200", .data = &j7200_soc_data },
 	{ .family = "AM64X", .data = &am64_soc_data },
+	{ .family = "J721S2", .data = &j721e_soc_data},
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

