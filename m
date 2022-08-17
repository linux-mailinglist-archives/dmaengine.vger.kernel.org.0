Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A96596943
	for <lists+dmaengine@lfdr.de>; Wed, 17 Aug 2022 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiHQGLg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Aug 2022 02:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiHQGLe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Aug 2022 02:11:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261A75CCA;
        Tue, 16 Aug 2022 23:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K84Iz+1PSqKuQ+HbOE5HMLedroBkJoaMNAfx6X+29oSPd/t5Rw2dUHyubSvNFvhDQMYysnZxQtvHZqp0H403sngMmmDPO4++097YrNgqZZ3YgI6IvLKZSRQvfReKGUSP7U/n1++vzos+7Fg79Mo3n7Q8/Qbildy8QFXxyYFTA0nyxjBqtBCAqZ4rA+MV50AlSugBmP3YQLu8WN0mfg75uBJTZs/73VK546IOcGAq1hwr6wUwME8QIF9XyKExk9Eghw30sx4VB+yPl13b3jDmEfy7tJxf/8HB5CLCWkOUET8moFseBRKn3hPL85diOs91pb1YOeQApPoDg6qzvbMidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCW6pP5kANHnHHOIIgEXFcJj8qMd45Fu+oKiTOWkmSk=;
 b=c6w2IcAv9mvr0yXGvo5AupmoK4Lwmh/ZzitP9CepMDnPxF95JQcMG2MiD+oSpa7kH+KhPqLo67j4ADbumKxiPZbDVJW/dLjqMBwLz/3FWqTeODvxeiAlyDX2yz6CwY2pXWA7y83IZxARIXYKu+ydAizQcgtMc7gpDUKdRtsUXtr11238jb44cBkluK6AOixc/IsUPgup3FTVCRbBVSb0AKu6R/uIGL8vnCziFZ6s0Nv+59+Z5P2FN9uio3kc7ws9JRKtn+A8DCJ1hvMkoVPf+MWMGgZ8n/r0eUcf34pxL+vAJNf00NbfjdERgKA4GSsjXQLGlvGaFi57frgMferstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCW6pP5kANHnHHOIIgEXFcJj8qMd45Fu+oKiTOWkmSk=;
 b=EE+4vI5NjJm/rExB2TRHq+h8DUazFdU6Pzp0ZQS1JL3JcTRYa5yohUUgKVUka4YRdCcq0iklgSfEAYVOD5Rz0Ig864hzTdFF9xzon/bQ2Crw/vqKQqtxuaZ8i+b8cSAgm+4vPKj3E6zfuDQAhxmEIlaOrLK1dKuOd9uNQ96XKMA=
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by SN4PR0201MB3423.namprd02.prod.outlook.com (2603:10b6:803:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 06:11:31 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::4f) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Wed, 17 Aug 2022 06:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 06:11:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Aug 2022 23:11:30 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Aug 2022 23:11:30 -0700
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
        id 1oOCH4-000GsX-1D; Tue, 16 Aug 2022 23:11:30 -0700
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
Subject: [PATCH v2 0/3]  dmaengine : xilinx_dma: Fix error handling paths
Date:   Wed, 17 Aug 2022 11:41:22 +0530
Message-ID: <20220817061125.4720-1-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37fb53ff-b3d0-4060-3fbb-08da80175441
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3423:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w35gdYDn+O6n+rSZ5d9YZ5Z6W/bzwG52TyLzgizjktcONQ1yCXt+CymlOxqwwmOL3thykCfiTUIkwJ1KBbNVnPvxf8mb2YNhFVP/rK0/hah/Qns3wyLU/GK/MMmdb93pSYsjN71bkT5xAmIrlceclkf0AL5aER2yrDcbzh/NBWC8W7owOnZ2ML1Luru4fIszNU72OKvSosysNv2wXVUrmdmZbTEjiSmdyeavAfv8FmK6x799Qz2E82NFKMVunrfQ6gkOQeWtM3VF/s0kZs2l5QxPlzqET2Fi90/DrMmBgRtKy+lYE1Fh/CujD+LeRMepnLReh6BgyMWN/ov57DMUb6C/6QZClIHVTJv1WfrOzVkygudIF7NrEMk3dtnzp086t0gUxpGYR9XcS1p5P7vl1r+JPRzHSGxnrTmbo21Pk2b7o9HZBcBVLznEp39CFJ2kYPqaZ16sXv/C21oXp1Po1x/Ja7YsZgAFt9zkutIbMhfKb8WM3kDMKEJ+KVXg7d4IMefp64gKqrHQ1GwacNAed2z2L1GOLGF0z0iUqnXGp891leGe3uxBHRBW1CHrvkDXpKsln78CQTYUeseTlrCR9wVDCZRjzUclF/KidPK5T3bdR2qMQNbjVJDOyO5U3JzzlGajHV+Z6DMmTyvP9Mgz0ZdO1KvW7h7pNG4tT1csffE+cllIWeUO1+Qzk2Qexse7yPUyh19+5uUk6HdMJ9mvP0/iQ3xxiZDDh4KImH+lJtoQubzioDUQQKWoJI2XXosH8x5wXFSRSufD4CikvGqjRy72zGzt76EW/BJV5K4Ln4jI5+raQmLKHLLgCqaoDAbI54CooW90VlvMgcQQPQHEUQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(40470700004)(36840700001)(46966006)(70206006)(4326008)(70586007)(110136005)(426003)(8676002)(83380400001)(54906003)(336012)(36756003)(316002)(4744005)(2616005)(44832011)(5660300002)(7416002)(7696005)(2906002)(40460700003)(7636003)(186003)(356005)(82740400003)(8936002)(9786002)(1076003)(26005)(82310400005)(41300700001)(478600001)(40480700001)(47076005)(6666004)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:11:31.1105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fb53ff-b3d0-4060-3fbb-08da80175441
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3423
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix Unchecked return value coverity warning.
Fix probe error cleanup.

v2: split probe cleanup patch into two patches.

Swati Agarwal (3):
  dmaengine: xilinx_dma: Fix devm_platform_ioremap_resource error
    handling
  dmaengine: xilinx_dma: cleanup for fetching xlnx,num-fstores property
  dmaengine: xilinx_dma: Report error in case of
    dma_set_mask_and_coherent API failure

 drivers/dma/xilinx/xilinx_dma.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.17.1

