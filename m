Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0560C5A5
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiJYHnF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiJYHmx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 03:42:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B74D15B332;
        Tue, 25 Oct 2022 00:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5/fz0vlQKEXdk/CrK1o7t8syBKy5bhv+upcFiud2UcUELlaVkXRpHefr2Tez+QgGrodiBDRmoA9VEXxiO26dRAL+ud8/qlGu7RZ97Vyj38S2nXiNzDpdPfIIrZcXLOoC96sSbE7Q6VrAP1RLxD598JzVftAOkfj4ma4jxoHqcjEpQqjWyRwGXO0QGUJBj5uG8wtWLqA/IW4LCnPOEQlR8JM0nhiWSkgPUolvVjtmiQ1CSlPJVsutEC9DI3wxkJ3KI/SyGKjhlKveS3YryGUGCyQzbzxyO6uOXVyh45IWLKdEagi1VydTZ2PDI4BKXIO/TMiUwWpwHboKXiHOIYKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgk2sAcNnGetUsiJ7ISneoDbz5GPlSbQSzif/2LXHNA=;
 b=lkmzvVbTXIWDoui78VeNWlkoO1W/Gn9fY9TT1hCUSjmGtgEr2sf2F6e6lPUWdSYYy/yUzsND8DUVzqFVA2mVxj/gcVxR48T1H++wSGRdz7ElYj49jLe7Bn+G0aplEB3Svo9GXzjYmAQhTioz6HH4IPDswMBH8EcHjp1BPLnDdmOR49Xoc4l3nkoMciSx90jMIJu7NuVHh34niCGxpQTYKxJ7AZ5P2x97C3O9cA17+dYJRgoUKavEKeNoiYAZkvTXttP5CI76fJekHFe+rC8+t/pOMa0JJSY51jbzk4Jz7XWNjk8UkrCQvp5xt1PNmQULxgtBEJSpGHM1G2uKNGOS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgk2sAcNnGetUsiJ7ISneoDbz5GPlSbQSzif/2LXHNA=;
 b=Ky6p6aa+gpRYsF2mYTRah5juCaAW8+vd+XXqchkTulsMuJwcrU1obI8yEBCkx+Eie7WKljczgQsNh97GfymJthLE7FevFQX8rPBjNhlYHtplH32HaEPVo2hz0FIzO1rwxqI5PgBJRCIO622qhGzZhjjoiUpCIbFD2D7m9nuumEw=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by DM8PR02MB7989.namprd02.prod.outlook.com (2603:10b6:8:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 07:42:50 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::61) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 07:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:42:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 00:42:49 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Tue, 25 Oct 2022 00:42:49 -0700
Envelope-to: git@amd.com,
 radhey.shyam.pandey@amd.com,
 marex@denx.de,
 vkoul@kernel.org,
 lars@metafoo.de,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.3] (port=50965 helo=xhdvnc103.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1onEaH-000GuX-Bv; Tue, 25 Oct 2022 00:42:49 -0700
Received: by xhdvnc103.xilinx.com (Postfix, from userid 13245)
        id 3ED6010550F; Tue, 25 Oct 2022 13:12:22 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <lars@metafoo.de>, <marex@denx.de>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 2/2] dmaengine: xilinx_dma : add xilinx_dma_device_config() return documentation
Date:   Tue, 25 Oct 2022 13:12:17 +0530
Message-ID: <1666683737-7668-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT026:EE_|DM8PR02MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9d5550-46e0-4d81-13d8-08dab65c84a2
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gn45ScSEb9P2FLnt/T0aCdO9RCZ3Do4orNekVzTwR4ckYXSsWuVPsmAjGQcBKI/CvUVhigGAgcSPlv/nw+PKn2huVkG8nKwTJqYskq8n+ltuMItOqyQjjtck0NvnwH61oUrG+dmQxlMTtnZ6kYhbnKyny4EXW5EragvUiblkLq+BJ7I+tsoWvN8vzjS+oW+Kg/epF9rLL1itR+ONTaMNF4D2QhdzbktDeNQGd3+ogbqvQWzOmShY85ApxDWt6K/q2joKnaV8174GlnVBA2VnVtmpDvH7henUlNjcyFbtTDBiBqKhxrOHy2FboJqRvWE+bDG4SRJ7Iar4/0DUyvDIO/9gRQmIKslxXTSYD36bziSyO1ehNB++PRb3HovleBjSy8wV6uLash1NFaxim1AwXvPPosXcmUK84VnZqfH8V6+KfBll8lAoKgn/AQTeShF5fwG+2x0iIq44QG53UZBVwdo/83mZsC4Qa9rO1CESM6S3v3SnAytjdwYtmnlBPuEqPv33/OgeHWNQgkudEDw4RMlRmpvp4VphJm+E+2MSNtW4mxqCsyKXbwC+mO/fw3vqJoNCif7LRrLOXeZbFTD8lZ5IeKLcFIu9rHX8O2EjoARD3+pZZMTPwoRiKMX5JyjGMF7ewQwbWG63kBtHSGYpV+oCZREpR2hjawBotZRCFJy436ZrvMgT+/CNwxNJrJraw2ETx8Gprh7UDQ6pjtBq0RiLViwDYgg8EqhKAXazQrzp6m/NJfDiM1iu//Ql19IPHKPEqHsH/XIlsr9OjNJq+ArprLWz70caQH5UGEXCic8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(42882007)(186003)(336012)(6266002)(2616005)(26005)(82310400005)(2906002)(47076005)(82740400003)(5660300002)(6916009)(36756003)(41300700001)(83170400001)(6666004)(42186006)(54906003)(40460700003)(316002)(8936002)(70586007)(4326008)(70206006)(4744005)(508600001)(356005)(8676002)(7636003)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:42:50.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9d5550-46e0-4d81-13d8-08dab65c84a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7989
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

document xilinx_dma_device_config() return value. Fixes below
kernel-doc warning.

xilinx_dma.c:1665: warning: No description found for return value
of 'xilinx_dma_device_config'

Fixes: 4153a7f6440f ("dmaengine: xilinx: Add empty device_config function")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3b8cfeccf2da..a8d23cdf883e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1659,6 +1659,8 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
  * xilinx_dma_device_config - Configure the DMA channel
  * @dchan: DMA channel
  * @config: channel configuration
+ *
+ * Return: 0 always.
  */
 static int xilinx_dma_device_config(struct dma_chan *dchan,
 				    struct dma_slave_config *config)
-- 
2.25.1

