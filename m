Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2438596942
	for <lists+dmaengine@lfdr.de>; Wed, 17 Aug 2022 08:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiHQGLt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Aug 2022 02:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiHQGLs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Aug 2022 02:11:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097497A527;
        Tue, 16 Aug 2022 23:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TILnaZtFRRzT1dR6Y40kNBO9tbE3XfDrBK50weZPD3oGXNSJqrCP2frl/6HMLR9KoKeQeDSuLY2/HMKjJ9qTPWAuldioNDlf/+nFI0GzXZy9ALJtQD0obviw4AKXScEZJogEDcpiMLtv/y0DZrpF7ru5keGVEfHJM+K82hhLWkgHJtaRE9vYKKfL53gigPuldEX5cGqMnP/BET4ldulDHChzA3tAo1MroxRNiaqVzSBLTreqQixNbKt0pFEutFDz97sfinQWQOY832Ktqz45j/FF8oGU2fJmEvlFClWGsqt/bisGU0fzugkbgFcsO4REuoyWAyRCLgiKuUXKLoQkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn0bTQhbJNyN9rfrlMOD+JUDJqBB96ZPf6EdZle+JWc=;
 b=WcE2MYw08wtwQ0s78vdplcqBhyhYu9sT6+Ad3SutxMgQdbNVPjATX8lZNkq/5kVjWWOacXA8Md/5r42wOE0Zu1gwhoNeAVfngkgVZtn+NJ/NY97WbTjDrhOfxGh71g0qxWg8vMRH5cySjR6DuRUsa3wC/fYAQLPk2g04GdwGMyas9gcio6ev35fYIDEFpKKvumRpPytn78NNi6L7AiFPpVoYf3ZZ5Bi8LzoX7acktQb4TWQTdhT2EtTlbE5SIzZcwVvbj7bWUgce9qD73awA/47uO4PTHPAHmtctvnVKYXr/QvQofucVixo/cAo6LogPpvyf0cEfXJnUTjbp44aKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn0bTQhbJNyN9rfrlMOD+JUDJqBB96ZPf6EdZle+JWc=;
 b=SW2wkHCX0pqq5SCQ8UAIokndLJ4h4XM7X/ilkvpFmVVMf0/OBebAdHKXAPRE2dx3cc0e5BW4YHAeFzAenJLeRgoWgXq9sToPYAZSaAO4Tf3j+Qm2SkhYFsk9YhXWeToNiWWGdD7hK3NfeMjaiqbKAjGxdEZMGr8gFektxeSy9s8=
Received: from BN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:e4::17)
 by DM6PR02MB6496.namprd02.prod.outlook.com (2603:10b6:5:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 17 Aug
 2022 06:11:45 +0000
Received: from BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::98) by BN0PR02CA0012.outlook.office365.com
 (2603:10b6:408:e4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Wed, 17 Aug 2022 06:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT040.mail.protection.outlook.com (10.13.2.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 06:11:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Aug 2022 23:11:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Aug 2022 23:11:43 -0700
Envelope-to: vkoul@kernel.org,
 lars@metafoo.de,
 adrianml@alumnos.upm.es,
 libaokun1@huawei.com,
 marex@denx.de,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 swati.agarwal@amd.com,
 harini.katakam@amd.com,
 radhey.shyam.pandey@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.78] (port=46002 helo=xhdswatia40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <swati.agarwal@xilinx.com>)
        id 1oOCHH-000GsX-5L; Tue, 16 Aug 2022 23:11:43 -0700
From:   Swati Agarwal <swati.agarwal@xilinx.com>
To:     <vkoul@kernel.org>, <lars@metafoo.de>, <adrianml@alumnos.upm.es>,
        <libaokun1@huawei.com>, <marex@denx.de>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <swati.agarwal@xilinx.com>,
        <harini.katakam@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <michal.simek@xilinx.com>, <swati.agarwal@amd.com>,
        <harini.katakam@amd.com>, <radhey.shyam.pandey@amd.com>,
        <michal.simek@amd.com>
Subject: [PATCH v2 3/3] dmaengine: xilinx_dma: Report error in case of dma_set_mask_and_coherent API failure
Date:   Wed, 17 Aug 2022 11:41:25 +0530
Message-ID: <20220817061125.4720-4-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220817061125.4720-1-swati.agarwal@xilinx.com>
References: <20220817061125.4720-1-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1605b740-49a6-4b93-9b46-08da80175c2a
X-MS-TrafficTypeDiagnostic: DM6PR02MB6496:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vrp1H4tDvMOsc7vtzJts8N9PSYd7rihZyI3cjgjTM5hkz+0m4uX76lzeLDBkarfHL05YzyBhKX92ZD5LpnJ+gvGds1ZdtX9G9epw83M7ZV67a3sfAku7lmeeSZoy5piR9klxXRqGWmy4ejY7cldXJrPa4L11Zmj0KPMyNFyhQQMO9MWij1EceFfZaItSxQVJt1GJtGPpx5JE+ncmDAio3s/CGt2m6dO012H8RUeTZ6aqqoYzMrzPtC4PAQ8ugQ5XI6Ke1m1zuvk/YueY8s9usTgdUum4Rm6z2b7Ie3d+JzvO2T3KRzBX1xr26Otaup3FAwhgg1BXbutgsw4IC69CzAsmgLoGsUHZsq574eGeF134QG1z0ayh5Gxj3t5yyXEEhND3MIYyNjtTREqX5H+E7UJyXUylT7pzXRneDn/1utdkZsGlr+Jm5FUN64Y/AGi0eJ/imTmpRh7e58DaJjFfw6wLHgEOa18jfNNYhOV6TcWMs8KqnXjN6mcxwK7YXSCP67woNs/47avVC6XqA6VO/7DdKEv4J9RRbKUlbfgP+M6CbfO9qtHd7xbotsNpi46ideTfBIjwOSLdrjWaMzd0e7Rs8nsJnjBH5mQ7GSHdz+DCVKkaelOmzZ02Mju1V1v41BUOZon5jcGfOiwZKozUgu1It458qn2RSMOEOS5CCypK1y/HcTlhm9cKc45ubai1f2DsSXhaAuNW0f4fALWA1sE2yj3c1N9SnPnC9YBUrhfSP7fKI208muw1cpUEC+v4vJpO+ekTc7t456ThSaBztPITovK8luazsp+iMjrgIV+KdFjcZds80l9fMBXvOiwKdbCYFyGSP2Zu5wr7/eJ85A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(40470700004)(186003)(478600001)(7696005)(6666004)(336012)(26005)(41300700001)(2616005)(426003)(47076005)(1076003)(83380400001)(36756003)(5660300002)(82310400005)(40480700001)(54906003)(2906002)(70206006)(8676002)(110136005)(316002)(40460700003)(356005)(70586007)(7636003)(36860700001)(9786002)(44832011)(4326008)(7416002)(82740400003)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:11:44.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1605b740-49a6-4b93-9b46-08da80175c2a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6496
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver does not handle the failure case while calling
dma_set_mask_and_coherent API.

In case of failure, capture the return value of API and then report an
error.

Addresses-coverity: Unchecked return value (CHECKED_RETURN)

Signed-off-by: Swati Agarwal <swati.agarwal@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index f63ec9d862ff..7ce8bb160a59 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3211,7 +3211,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->ext_addr = false;
 
 	/* Set the dma mask bits */
-	dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
+	err = dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
+	if (err < 0) {
+		dev_err(xdev->dev, "DMA mask error %d\n", err);
+		goto disable_clks;
+	}
 
 	/* Initialize the DMA engine */
 	xdev->common.dev = &pdev->dev;
-- 
2.17.1

