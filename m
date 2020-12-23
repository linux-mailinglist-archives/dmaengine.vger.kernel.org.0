Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732DD2E1BC8
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 12:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgLWLWm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 06:22:42 -0500
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:49249
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWLWl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Dec 2020 06:22:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcy7BZ2IOjKeJlsVgjCFVgEalFCIVZzY7slb+fC89P1GsvdR5glfT9G6BOy7nS33S8eXyQtbFKbgFS/3yXaGd2jMlLaZ1R3GdgcbMNlP4G0orjMeCVrT9DoU6TnwP4H2NmTPRi0jC6q7+l2O6HDks62/9La/3MOdD+ddvXX3Dzz57u7Cre6SSPFsP7pMBFLSi9HSiqfNVuLaArqmdm6fBfL9AHkPUPks5mTJOygTjwR78of8nd29Ik+6nODiGS24V0MU62sGvPB6gdGdt7eFGm8dNEz8YSYeOYqHGdQ6emQ/j27vYI4pEaV+uiw4dshYq7JKn29ZK9r1P8SAONOmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkEtzzrc+86GjyONHxbCIfjW2FCP6/H64UojCU5h/+E=;
 b=UQNKot6Gqh/e+X6M0yqkfIQcGiSiyfo3baj/EnRq9fuePIKLRNHcKMN3AOT5IlZTfCuN4+Qqt8GYnpCqMWJMF3PYm8Bp1HN+RHVXU4e7Bkr7E8GulIEQlsPatN//43Hd2WxytVdTct08BIyh3i/+Unj4QND9hDDHtGLPXKEv2VZRscabtDIPI72VXVDed151ZYkV4huh9tZKGrXBeYCS5N3H2z61pJ7pSj45/z2I563zL7qRyuhNCqFSSYnLUVRYTNNDZ0UiQg2TWExM1vabtdyhyuxdbuQJLGI6Wg7QHluQxTHp7P7REbIOpaAkwrjQX/kAYCUl4tc9E+C1iBfSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkEtzzrc+86GjyONHxbCIfjW2FCP6/H64UojCU5h/+E=;
 b=paHEFAxF/8fuqJY9Cialeyp73mFkVGTjqGdO06U282Lk+i47at0EEawZ0y8+2wmb7CBMtBcByPrs5gwYhnKioMZw3BSSOp2dC55Tw/PVf3UxznFaDzBFsreSh/SBWzVonq0HeV2boFs/TVEOroQjmMOIDh4J79EKB8lId9Xtuxg=
Received: from DS7PR03CA0141.namprd03.prod.outlook.com (2603:10b6:5:3b4::26)
 by BYAPR02MB4165.namprd02.prod.outlook.com (2603:10b6:a02:f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Wed, 23 Dec
 2020 11:21:48 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::f3) by DS7PR03CA0141.outlook.office365.com
 (2603:10b6:5:3b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Wed, 23 Dec 2020 11:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Wed, 23 Dec 2020 11:21:47 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Dec 2020 03:21:37 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 23 Dec 2020 03:21:37 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=34643 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1ks2D1-0007jQ-4G; Wed, 23 Dec 2020 03:21:35 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id F1F131211AF; Wed, 23 Dec 2020 16:51:07 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 2/3] dmaengine: xilinx_dma: fix incompatible param warning in _child_probe()
Date:   Wed, 23 Dec 2020 16:51:01 +0530
Message-ID: <1608722462-29519-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed01ab7-5da7-47dc-3e53-08d8a734f000
X-MS-TrafficTypeDiagnostic: BYAPR02MB4165:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4165F88BFED06661342F6726C7DE0@BYAPR02MB4165.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPn8p9gMcpVKvFu25B7twf7EX/LOxYdEcp4so3/j9n2jQL1Sj6veg6/Jb+AgTY6B0VcUxYp5PVjOi1tRpBX6rCraTWFktOLQ12mrVTE0uxLraxU6NK/0sASbGBIHRkiX5ihqVU1CJZY/MqBOPse4m9W4oXmBpwPc+mNcrnNszalxXyPHO/Tsr0hc0nLIPPKePjJPXNEXMD/OTWGCEGVC5Zqt54GwHqBO7esYsCx7r04ygqj2fJhlz5C9BlSJMnlbigYPwqjXu/XN/fPoGd+g3qsqBtd3Fz+Pg27kaamVxIaCeiCGzah900Ctg5UiVXmaze1U33hmbS7Lyi07RGQH0z8KEwgvnUAaHKrtz37VRZeZ1MRDfjlZa2agruCcjO/ZpYaVX+M5MOJIWQzRC4jW8Bz9esQ2gobahHIgvNr5XTW60zT6XcKlS1XHbm0QsMTlqxQ7EnVYSmh5MLlWSNjFfhv+P2RmLzqYdHIOqMa81bcJMlWEjs+FIEA8UmI5QTGRs2xHtVOseDFGQNGELnjZXQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(83380400001)(5660300002)(426003)(186003)(70206006)(107886003)(82740400003)(6666004)(356005)(82310400003)(8676002)(36756003)(478600001)(316002)(70586007)(110136005)(2906002)(36906005)(2616005)(336012)(8936002)(4326008)(54906003)(6266002)(42186006)(26005)(47076005)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 11:21:47.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed01ab7-5da7-47dc-3e53-08d8a734f000
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4165
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

In xilinx_dma_child_probe function, the nr_channels variable is
passed to of_property_read_u32() which expects an u32 return value
pointer. Modify the nr_channels variable type from int to u32 to
fix the incompatible parameter coverity warning.

Addresses-Coverity: Event incompatible_param.
Fixes: 1a9e7a03c761 ("dmaengine: vdma: Add support for mulit-channel dma mode")
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- Include fixes tag.
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

