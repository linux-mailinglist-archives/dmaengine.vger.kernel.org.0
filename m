Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0412D9360
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438766AbgLNGyb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 01:54:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41440 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgLNGyW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Dec 2020 01:54:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BE6rJLs044767;
        Mon, 14 Dec 2020 00:53:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607928799;
        bh=fjMxuww0pI6MgGW3bPWunKl2njfFRpIUYB2BKc1LH+k=;
        h=From:To:CC:Subject:Date;
        b=sMP5NYwsVFA0Mgnuq4fje42VbNYMVRZa1xiKSw5AWmy25+W5Fx+8ek+Iz4uIjNrqc
         JyP2q99M3ACpN95rEzoun/GeSE7XUJ7Bx/AVjPIjMHILN6DgkiAbaCYWjKNTWpNMDP
         ea7lwgE9YSrQsr4GveWcOclqaq6T3xzuACMEM+Cw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BE6rJUa068701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 00:53:19 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 00:53:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 00:53:19 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BE6rGWS050104;
        Mon, 14 Dec 2020 00:53:17 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <vigneshr@ti.com>, <grygorii.strashko@ti.com>
Subject: [PATCH] soc: ti: k3-ringacc: Use correct error casting in k3_ringacc_dmarings_init
Date:   Mon, 14 Dec 2020 08:54:21 +0200
Message-ID: <20201214065421.5138-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use ERR_CAST() when devm_ioremap_resource() fails.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Vinod,

it came to my attention too late. This patch fixes the sparse warnig introduced
by the AM64 support in
https://lore.kernel.org/lkml/20201208090440.31792-1-peter.ujfalusi@ti.com/

Regards,
Peter

 drivers/soc/ti/k3-ringacc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index c88c305ba367..b495b0d5d0fa 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1476,7 +1476,7 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ringrt");
 	base_rt = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base_rt))
-		return base_rt;
+		return ERR_CAST(base_rt);
 
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

