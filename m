Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F02DD816
	for <lists+dmaengine@lfdr.de>; Thu, 17 Dec 2020 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgLQSPX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Dec 2020 13:15:23 -0500
Received: from mail-bn8nam08on2043.outbound.protection.outlook.com ([40.107.100.43]:58017
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731487AbgLQSOg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Dec 2020 13:14:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUNe18WEKUFp6Z9K7H7cpuxrzrxvyCHurV4G3wWCORSI45F/9QJOXRer19V2QqWAhyJTye4UBp0xsd1nB5l2FC4FsyjczsWi4YATC7UdqbGZZc70xrmV9c3/4AIzlhk2zCdBKlW8ZtPPH+T5G5dFHDL4g3LY0rmWMxCEPWSW0vFJmHiT++eihbNG0I9X7NiUuHwnRGgLPxIt1rkYf95E385zuUPbpE8vUHEk1XTJ3pKSa4WnoAt0R1u1jIBZovjhSUg+hZWleKsq0h8G9n6XOafb5aKt0d/Tqa6hY442LyElEpIKbHGfqIfoYvDKG9V0kvA0ZTGa4Tl1BnBKjZSq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsoxlBfD5ghzCMcSOsova5v9JcQf7lsWdCtoZP4oHaI=;
 b=dvdWMTbwcMdpFRGpe06rVfLw2nqlv113txvQ0STAka9R4Cb//VSwZSfAkohEyHmOXsLO4tCEzHPpUSK8kVfHvYLED544x71DC7qX9BI5wvsH4IY4O21Pt1m7W3oRFLdeuI1Km1Bwkq6ktyMI4Q9KScLT6O76i4QuUErvlSz9okQ2KYiXiCJa0PiYLYGkt/0XaJdJNI5tVUw8EOGImY+FXuzpX3TUzGXrhhxjbZI6XK1kr4RLbkZMMwEpICkVx+LwlAFm4taql3z666fs7AHP3lTFjc56pz/iEMlsZOheXd2WZJ4IyYLaO259YjBaPN2u8Pih+dfV1tYp3lChxZQgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsoxlBfD5ghzCMcSOsova5v9JcQf7lsWdCtoZP4oHaI=;
 b=BZSLsBrrk+SCGh5asTHuqiKx/wco1O+rAm5qJFlstXdUjX6d2scisMjjoL3GYtxKPcNgzW/EsX6iCFvpe9c7CkMN954w5gxYMKQyvwhoYX5rv+X6imkHhYUzXxqexqgqowusbaiN5I5gaRs1lcJgju62GSYjXVQK+5JrutmYE+g=
Received: from BL0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:91::40)
 by BL0PR02MB4418.namprd02.prod.outlook.com (2603:10b6:208:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18; Thu, 17 Dec
 2020 18:13:41 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::3c) by BL0PR05CA0030.outlook.office365.com
 (2603:10b6:208:91::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.19 via Frontend
 Transport; Thu, 17 Dec 2020 18:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 18:13:40 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 17 Dec 2020 10:11:56 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 17 Dec 2020 10:11:56 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 dan.j.williams@intel.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=52450 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kpxkp-0004pK-GF; Thu, 17 Dec 2020 10:11:55 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 63E931222BF; Thu, 17 Dec 2020 23:41:28 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 2/3] dmaengine: xilinx_dma: fix incompatible param warning in _child_probe()
Date:   Thu, 17 Dec 2020 23:40:14 +0530
Message-ID: <1608228615-7413-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e9c34a-385f-429e-d0ce-08d8a2b77b9c
X-MS-TrafficTypeDiagnostic: BL0PR02MB4418:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4418A3B8F77AF32A2D21C3DFC7C40@BL0PR02MB4418.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2HqFoberTvldRc4FeDt3FHmkirfjlfq0I8FA8iJk4W41qQYPAmDlYRRm9ghA4MJUiXoauwIJLU7spHsrhc0It1doQfvHQxaibPvWhrDVfw/OQObChskZXnYpzP8tMKfpZKxYj0gIfTUp/CzrTF0sMfv5UGn+J9FU18mo46PiU7aqwh8h8T90dEw6jlbERRfSYndg8lBr98jK66pQFjlieynO0Mgox4OaHik1cfZS0FEn0N6sy+a3tVVXxB0m/OuXZlvKdufPmZ4DbTkTOVyTepZFEQa1esDREcQaIsb2EZc/1ktrFQI38KpntPoiSwaKDH7s+1wUqeq8qN2kx/3kbQJJmmUBWLOVG4fJUjg/RiVRZsYPrir05mVbwPNVaoPzDsgZBKqZ93vgvWqlF/x+dzokaYfaoDkzcODEL8ewl4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(6266002)(82740400003)(7636003)(36756003)(47076004)(2906002)(5660300002)(8936002)(110136005)(356005)(316002)(70586007)(42186006)(70206006)(54906003)(36906005)(83380400001)(26005)(336012)(2616005)(186003)(426003)(4326008)(6636002)(82310400003)(107886003)(478600001)(8676002)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 18:13:40.8095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e9c34a-385f-429e-d0ce-08d8a2b77b9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4418
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

In xilinx_dma_child_probe function, the nr_channels variable is
passed to of_property_read_u32() which expects an u32 return value
pointer. Modify the nr_channels variable type from int to u32 to
fix the incompatible parameter coverity warning.

Addresses-Coverity: Event incompatible_param.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e41435be5b79..cf75e2af6381 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2921,7 +2921,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
 				    struct device_node *node)
 {
-	int ret, i, nr_channels = 1;
+	int ret, i;
+	u32 nr_channels = 1;
 
 	ret = of_property_read_u32(node, "dma-channels", &nr_channels);
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA && ret < 0)
-- 
2.7.4

