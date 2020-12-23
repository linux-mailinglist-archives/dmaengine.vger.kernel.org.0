Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0A2E1BCA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 12:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgLWLWq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 06:22:46 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:9056
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWLWq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Dec 2020 06:22:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxGDTjI6n5YDSjaNFMQrChSvtx9nxD4VAQ6Yd9T5P/doe38ZCGNUoWnjomJDHZaUx2xl8SN6wblQ+s7ObUF5giNYdXImo51ZP58AOh2+EQ16umVQNwNdR5ifywfHGu5yeo+Acg8rzdCBWblb4GGgNLZCNJI+7LVObizOwogMr+2mgBk3ltYp+IAs9VZvngbuAFgxdqDR/c5H5Dsciqr9KbGSVjVeSuWc94CiyQlWHX2C2DglifIyD3YRuMVTTm2awZlfGR5tzGn8OQtmt+dFx6pDXkLlu74DwUjKVBvWmI157dhbye9pq3mlupcQNkdWUOMDxI1GBTk4J6kz3pphHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y7nffqDx0UUI+Po3O45Do6Y03d26ArWoSlxtC2Vvsk=;
 b=l+kOoNWpvIcafskVqpHpd5rvZzZC8AJmo7T7ONc2bFaaPuqBYSw9UrpjW0lhkYKvrxwRBeuEcMF7dKJ/ok59iQxILCi/p/crQaXqRhYhreaEDRKYACBmKy0nZlfiGihkGVqWW2DpXOv+CbcUOwrWJF8htJ/lQuQvBQBLBNCV6kjmPY3KnhsmsW86lR/XXn09qTjOuvAxtn4/B099cy4Ajy+HWBeG17NDa1rQYd7MkxRi7KqnSsSlPg6hyvcUYaCg37rkTCeGKe9jIQWdtv4h7T8Pi38aHfH5WWsCoOtsn9FoamQCoZyZiDayvi+bg6Mv1ndBE9Kn92n5CIRKNToYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y7nffqDx0UUI+Po3O45Do6Y03d26ArWoSlxtC2Vvsk=;
 b=BGCfuMWRxRJlUmRg/Elptt/DUZacHwqhS5i1VdZacoXDMha6/r/xU/llm4+zTFfOLmLVlhrRRMj16fzxweUgfoSXMKC/3tGUzT3t71eClrmmVjvzJQx58GEJQbq5cMU8MHwenVCFOWzdmIndUPw99wokqXsWkTwdJwf1QozrXVI=
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by SN6PR02MB4607.namprd02.prod.outlook.com (2603:10b6:805:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Wed, 23 Dec
 2020 11:21:53 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::e1) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Wed, 23 Dec 2020 11:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Wed, 23 Dec 2020 11:21:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Dec 2020 03:21:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 23 Dec 2020 03:21:49 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=34659 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1ks2DE-0007kA-9o; Wed, 23 Dec 2020 03:21:48 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 06AB81217F9; Wed, 23 Dec 2020 16:51:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 3/3] dmaengine: xilinx_dma: fix mixed_enum_type coverity warning
Date:   Wed, 23 Dec 2020 16:51:02 +0530
Message-ID: <1608722462-29519-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 451f0e82-e8c8-48ff-3ba2-08d8a734f332
X-MS-TrafficTypeDiagnostic: SN6PR02MB4607:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4607775F1A36C080F3F65689C7DE0@SN6PR02MB4607.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvVtfEMJDFJgoTe3HjXRomZED5bqRdSrzOdrGYPTyeBoei7OTWmLn1Q7MZujeeJq7vSDgjsHHyy4LX7Axih1bjSDS9v4VG7s3819X9N8vG8pRRuuS1EygB2uUNXXs9uSQA9I3RoDEvRnVBcrtDsyOGEmh8qQkKXY/Jzq9qiGlVLxd2+pDuJm72HOHKndCkhbKXVX1DqCaLCQ+nqbW1cWQdQu5qL8w8dgafrjfnJ+KqAXT6RCwKutPNfhyqeuU81I7Eydp3sM4xLtcLizEk+zqnzo+r5/ujQOc+9AOeNiYZwmkKvcrJqhG5BeMjkakB2tKECv1mklOYVPXKyBzlk0B5b2a6CpX2rEhVp9LyrT0+DBWqTmbDdHx7AuXJvGb8iVCWOADtuWQWobabhPwTYInTc6m8UofNoQKKimuUKNh1X0Zsm6Ju0QhyXAbh4ZpRITK4HmmeeeWvkOq3fWBh6DMbI+id9WejNxAfjFCnUzhsBPOiJ6Slb2h4VKFa06051styAbZZPQ5YlPk45DXYyxkg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(6266002)(54906003)(107886003)(336012)(70206006)(82310400003)(42186006)(8676002)(2616005)(36906005)(110136005)(316002)(426003)(478600001)(4326008)(8936002)(26005)(83380400001)(82740400003)(186003)(356005)(47076005)(6666004)(36756003)(70586007)(5660300002)(7636003)(2906002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 11:21:53.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451f0e82-e8c8-48ff-3ba2-08d8a734f332
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4607
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Typecast the fls(width -1) with (enum dmaengine_alignment) in
xilinx_dma_chan_probe function to fix the coverity warning.

Addresses-Coverity: Event mixed_enum_type.
Fixes: 9cd4360de609 ("dma: Add Xilinx AXI Video Direct Memory Access Engine driver support")
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- Include fixes tag.
- Keep typecasting changes in the same line to increase readability.
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cf75e2af6381..7639fd07e280 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2801,7 +2801,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		has_dre = false;
 
 	if (!has_dre)
-		xdev->common.copy_align = fls(width - 1);
+		xdev->common.copy_align = (enum dmaengine_alignment)fls(width - 1);
 
 	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
-- 
2.7.4

