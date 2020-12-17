Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02F02DD812
	for <lists+dmaengine@lfdr.de>; Thu, 17 Dec 2020 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgLQSOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Dec 2020 13:14:41 -0500
Received: from mail-eopbgr760075.outbound.protection.outlook.com ([40.107.76.75]:10627
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731479AbgLQSOf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Dec 2020 13:14:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVhZc98VstQ+Di+l9Xdk8nl0azgHY/DUaYqplSVEHYRyOaetzs4Y+Aqu1gkoOtatEun4fnS61Zzw1L5zVWq0iQybndCm0JThKTSw0lzSKW3cDgkCf6uGmKZGnDh3mkgLgju8j8GHtMjkorCzu55T2Wx3sUqaypQwXxMWHwzMxJHqQUG04LfrcCdhKXIYkEOHg1v7k2R3jjJHd/2ln6d+fArA6gLfk1+HzPfaBTPMkg7i8dnhhVMZ1m5l9ZBAcZ6hPEJZQ+m2ZAbpyFAoe0WOg9LkAYhkAbEpj/DqHI3VV3GxLerLsQAedfaLDIWvEF7XjYDbAJhOOC3BcL8Ejtv9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6pNn18DyepbDYAR6RD6yq39uNnTtroIzm1G86krXU4=;
 b=lAoeAL3i+NJfEtzE9Oif4WkU9M10OMneYUfWDQZZgCsxZvHtxqnOfmj3IY4tpDc0RQzW1IDHFXrLmAsWhetQwe3zUqFfxJiDuVyi00LISrLR7S61O6aqiZ2hrxFG5YsXpVNEiPJ9QgOWHA2PZ9KKC+P14E+9++MmlCALkgdLmAyKkzwqPtuo+z8eeXhp5rL7I83SuNgtMlHN/PPRfQuti0fbR7woGOpfxfywNHsreEYAVkUMp9DHsxRd9SBhF/6iJHyKQh2vQ701dVkpcOlGWU614Nli62gVDZ7Rd62ezdt0+gkE/kuJF21FXQiNOlW70dr4g4mPxDKxJWd8o3SdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6pNn18DyepbDYAR6RD6yq39uNnTtroIzm1G86krXU4=;
 b=Fl4iuyditL6VzUP7E/D9wVPr5Mgv7Plc0YiN2F8g1nox1Atl5Nf6eY+gd4RFY3G3tcFVaDPnee2QHZR9o6d6LU1ta5XL8T18CB+fuGPYsuRXVjgmdkorXlAhcjpyMfC2BHmrtJ/nJaAMvN1sttuPtiFVXLyLExNZ3GJB+FHTPkI=
Received: from BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20)
 by MN2PR02MB6077.namprd02.prod.outlook.com (2603:10b6:208:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Thu, 17 Dec
 2020 18:13:44 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::f4) by BL0PR05CA0010.outlook.office365.com
 (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.12 via Frontend
 Transport; Thu, 17 Dec 2020 18:13:44 +0000
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
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 18:13:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 17 Dec 2020 10:12:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 17 Dec 2020 10:12:09 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 dan.j.williams@intel.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=52468 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kpxl2-0004rP-L1; Thu, 17 Dec 2020 10:12:08 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 69A9D1222C2; Thu, 17 Dec 2020 23:41:28 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 3/3] dmaengine: xilinx_dma: fix mixed_enum_type coverity warning
Date:   Thu, 17 Dec 2020 23:40:15 +0530
Message-ID: <1608228615-7413-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99d3700-8093-4ddb-1251-08d8a2b77da1
X-MS-TrafficTypeDiagnostic: MN2PR02MB6077:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6077580C1F65FB26CF2E8441C7C40@MN2PR02MB6077.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XX5oP/8KEMH7sUew6Tdxq9qJlybNzGGcnYtaDpsDPLA5TMWiT2D898nA/hm4Irs3fClJgcYjqdL4RY1L/Y5IF4qgX9lyyEW1izR8EVPmCoPhja4xuopg3E8dt6QEFfSCppBs0k81ph7RMAubWQCu6CTIHuhVYDRVKJsn2EhQCHeKttCGuxbZwVBK/01/f+2oOFevqC6st+bLRADFtkSun5chM2Csc5tPdGLlf/TsmXsCZI3Gwr06ni2juTiP5Q/qUt3a5+Ji/1hvOQ8NdxMcD3MgwlH2XLcz6MYQ2jN3/6ZNhBXAbS5jy0CUxQLC13JB12X1Xk6idDsXnpfvqwroKsrlwg8wxx+bdDL9lt0jLjBVjjXRhNbnG5h78qOejmmxCVZb8CxJkCb0EarvuzGK4hysoWfhekhBy8hKtkJ0jzfEO7jB85orBd/FOalGeFKVVLuEnfFIMuq+Zg3Tvy3ZGCY0+2YjwGePv5Dn2LBwZFkBqyIPWwyqkwRHLqzQSjv8
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966005)(6666004)(478600001)(186003)(47076004)(110136005)(82740400003)(54906003)(8936002)(82310400003)(6266002)(2906002)(70586007)(70206006)(316002)(26005)(336012)(4326008)(36906005)(426003)(356005)(7636003)(83380400001)(8676002)(36756003)(107886003)(5660300002)(6636002)(2616005)(42186006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 18:13:44.1908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99d3700-8093-4ddb-1251-08d8a2b77da1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6077
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Typecast the fls(width -1) with (enum dmaengine_alignment) in
xilinx_dma_chan_probe function to fix the coverity warning.

Addresses-Coverity: Event mixed_enum_type.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cf75e2af6381..5e6dcb72a888 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2801,7 +2801,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		has_dre = false;
 
 	if (!has_dre)
-		xdev->common.copy_align = fls(width - 1);
+		xdev->common.copy_align = (enum dmaengine_alignment)
+						fls(width - 1);
 
 	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
-- 
2.7.4

