Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61D81A28E5
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgDHSzY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 14:55:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41344 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgDHSzX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Apr 2020 14:55:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038It487080851;
        Wed, 8 Apr 2020 13:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586372104;
        bh=ccqDRMm3FCs3RXBDaJi6W1MUSOA9ffDYkYbKumIKNi8=;
        h=From:To:CC:Subject:Date;
        b=hId+MfxKpcBxPl5HsKrUITUr3flgFfREfi9l8D03gPY31KYNh7Q7+sNc7OsOdZSVf
         dwO5xpWblkRTzUjcmmkglBhYujI0FnfiMsg96zzpizVmHdgqmwERAi5UN0u6y/YzJP
         Mt2UlN1yK9lTvxK++uLy3atB+OlOfj+NbwFaFtwQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038It4XN084399;
        Wed, 8 Apr 2020 13:55:04 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 13:55:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 13:55:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038It2qQ072145;
        Wed, 8 Apr 2020 13:55:03 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil: fix deadlock on error path
Date:   Wed, 8 Apr 2020 21:55:01 +0300
Message-ID: <20200408185501.30776-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The mutex_unlock() is missed on error path of psil_get_ep_config()
which causes deadlock, so add missed mutex_unlock().

Fixes: 8c6bb62f6b4a ("dmaengine: ti: k3 PSI-L remote endpoint configuration")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/k3-psil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index d7b965049ccb..fb7c8150b0d1 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -27,6 +27,7 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 			soc_ep_map = &j721e_ep_map;
 		} else {
 			pr_err("PSIL: No compatible machine found for map\n");
+			mutex_unlock(&ep_map_mutex);
 			return ERR_PTR(-ENOTSUPP);
 		}
 		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
-- 
2.17.1

