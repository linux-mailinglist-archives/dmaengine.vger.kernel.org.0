Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA786143764
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 08:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAUHAb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 02:00:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUHAb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jan 2020 02:00:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00L70RBA026879;
        Tue, 21 Jan 2020 01:00:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579590027;
        bh=UQBJCDZRnfhIDDJNLa9n5i9Wb+4Tvw6qRjtCAg/LL6E=;
        h=From:To:CC:Subject:Date;
        b=h5GGTdllqZQpx4QHql7o+6NsUE5IZDdZC01LWHwp5nSdOSpf92eLybPClG9wsD7QJ
         ED6esDlH/kTh5UzYI8b8GE/dKdKBQxFZufyA6+1UlAdP/wZTJuRgHa9kuf7TqhtsNg
         ktfOyd5dJ4xZKL9AJ9nkn1gZvAM35xb56uZutp9g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00L70RvO123473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jan 2020 01:00:27 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Jan 2020 01:00:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Jan 2020 01:00:25 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00L70NgB111713;
        Tue, 21 Jan 2020 01:00:24 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil: Fix warnings with C=1 and W=1
Date:   Tue, 21 Jan 2020 09:01:04 +0200
Message-ID: <20200121070104.4393-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes the following warnings:
drivers/dma/ti/k3-psil-j721e.c:62:16: warning: symbol 'j721e_src_ep_map' was not declared. Should it be static?
drivers/dma/ti/k3-psil-j721e.c:172:16: warning: symbol 'j721e_dst_ep_map' was not declared. Should it be static?
drivers/dma/ti/k3-psil-j721e.c:216:20: warning: symbol 'j721e_ep_map' was not declared. Should it be static?
  CC      drivers/dma/ti/k3-psil-j721e.o
drivers/dma/ti/k3-psil-am654.c:52:16: warning: symbol 'am654_src_ep_map' was not declared. Should it be static?
drivers/dma/ti/k3-psil-am654.c:127:16: warning: symbol 'am654_dst_ep_map' was not declared. Should it be static?
drivers/dma/ti/k3-psil-am654.c:169:20: warning: symbol 'am654_ep_map' was not declared. Should it be static?

Reported-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Vinod,

Thanks for catching it!

This is on top of the v8 series.

Regards,
Peter

 drivers/dma/ti/k3-psil-am654.c | 4 ++--
 drivers/dma/ti/k3-psil-j721e.c | 4 ++--
 drivers/dma/ti/k3-psil-priv.h  | 4 ++++
 drivers/dma/ti/k3-psil.c       | 3 ---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/k3-psil-am654.c b/drivers/dma/ti/k3-psil-am654.c
index 7da9242b6114..a896a15908cf 100644
--- a/drivers/dma/ti/k3-psil-am654.c
+++ b/drivers/dma/ti/k3-psil-am654.c
@@ -49,7 +49,7 @@
 	}
 
 /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
-struct psil_ep am654_src_ep_map[] = {
+static struct psil_ep am654_src_ep_map[] = {
 	/* SA2UL */
 	PSIL_SA2UL(0x4000, 0),
 	PSIL_SA2UL(0x4001, 0),
@@ -124,7 +124,7 @@ struct psil_ep am654_src_ep_map[] = {
 };
 
 /* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
-struct psil_ep am654_dst_ep_map[] = {
+static struct psil_ep am654_dst_ep_map[] = {
 	/* SA2UL */
 	PSIL_SA2UL(0xc000, 1),
 	PSIL_SA2UL(0xc001, 1),
diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
index a609d496fddd..e3cfd5f66842 100644
--- a/drivers/dma/ti/k3-psil-j721e.c
+++ b/drivers/dma/ti/k3-psil-j721e.c
@@ -59,7 +59,7 @@
 	}
 
 /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
-struct psil_ep j721e_src_ep_map[] = {
+static struct psil_ep j721e_src_ep_map[] = {
 	/* SA2UL */
 	PSIL_SA2UL(0x4000, 0),
 	PSIL_SA2UL(0x4001, 0),
@@ -169,7 +169,7 @@ struct psil_ep j721e_src_ep_map[] = {
 };
 
 /* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
-struct psil_ep j721e_dst_ep_map[] = {
+static struct psil_ep j721e_dst_ep_map[] = {
 	/* SA2UL */
 	PSIL_SA2UL(0xc000, 1),
 	PSIL_SA2UL(0xc001, 1),
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index f74420653d8a..a1f389ca371e 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -36,4 +36,8 @@ struct psil_ep_map {
 
 struct psil_endpoint_config *psil_get_ep_config(u32 thread_id);
 
+/* SoC PSI-L endpoint maps */
+extern struct psil_ep_map am654_ep_map;
+extern struct psil_ep_map j721e_ep_map;
+
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 9314cf9a52e4..d7b965049ccb 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -12,9 +12,6 @@
 
 #include "k3-psil-priv.h"
 
-extern struct psil_ep_map am654_ep_map;
-extern struct psil_ep_map j721e_ep_map;
-
 static DEFINE_MUTEX(ep_map_mutex);
 static struct psil_ep_map *soc_ep_map;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

