Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E1520E99
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiEJHiF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbiEJHQq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 03:16:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F92992C1;
        Tue, 10 May 2022 00:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhdpyCfjyqKhYfosZuHv3zjOBoPmFYoeG8MD9sGA2YM8Xw5WtoU7Kjaf11+4QGiHgpu9aoEystl2z2AUCW/VSbpQ3LytnlDXRnjmejj7F+cIau/2wJHjgmvlYQ/yJ2ojb/0bxw6kPOpXkKJhRXR/IcJAbhXVsIEVjDQN9ykQN5LHUvqdqdCFTRYUqy24Zksle3qvAghpVzDZfilC8z98LjAzVXBssQm4lvY8Qgxal7J//fTVWUc9YCWkkvVqayl9kkRMmKU3pfcuOzDoef0/TCgMFn+4rrmK7rf4q4vA3qQOB0euS6hD2Se7DhQ6SxOy8auOOdAyxqYQTzdMuJKZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6UhZ9Ju+sKS2B4lmecY5o11lTjBi9rrYVWUyX5lQnY=;
 b=lih4A3FuaPRlp8ouAEtfcZPgejvXErLvr3A9X5k/JMvclyarO9rmZ/JD8X1Fw2DceAaIQV+jjvFs0oR74RvwoKkVJJ43Q+d9AKs6GJAw/JtWjvvzG0BJcN203FDuu19lZw07j+DtYlcIgCA2rJ3ypLMSLp0ben35rzl0CtEx7v++n3rOZUVBIpsyGCBD7Uo7zHAjb0X1jz99pXzvEdTGVYGMcE6bsDu4Zd9vRT85JW+4MPkPt0MUJaLZmaCIYIpI5qLFM5VYwy7BM0q+aQrJym214JNoWZMrhkZPpMCAfpK3S9cUviPHAQNF3UwuRBY7A098gYaAeQ+UQgeJhFizVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6UhZ9Ju+sKS2B4lmecY5o11lTjBi9rrYVWUyX5lQnY=;
 b=cKNIvU5WWhKLodWhET1jA0P2rs6n2ma0NcoDuDdxcYenWUhwWfcKOtnUFFLowVfeYpvAuzZ50e5tbmqFoPhluP1dIz84iEKY4g0JfDnjMmPA6PFCDgWtMXh/Z9NYbIQpxnbQErZAhCPPyAH9o49B3W2gGxpRldyK4DN3MMKePg0=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by CY4PR02MB2600.namprd02.prod.outlook.com (2603:10b6:903:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 07:12:47 +0000
Received: from DM3NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::f3) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 10 May 2022 07:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT033.mail.protection.outlook.com (10.13.4.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 07:12:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 00:12:45 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 00:12:45 -0700
Envelope-to: git@xilinx.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.6] (port=41364 helo=xhdvnc106.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1noK33-000CbH-Bj; Tue, 10 May 2022 00:12:45 -0700
Received: by xhdvnc106.xilinx.com (Postfix, from userid 13245)
        id 8DA5961070; Tue, 10 May 2022 12:42:44 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 0/3] dmaengine: zynqmp_dma: coverity fixes
Date:   Tue, 10 May 2022 12:42:39 +0530
Message-ID: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028fab54-099a-40d2-ceaf-08da32547cbb
X-MS-TrafficTypeDiagnostic: CY4PR02MB2600:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB26002020F508148085014BD1C7C99@CY4PR02MB2600.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93JcVE7Nv2svm0crjGGEqM3QvWeKQjwYxa/z7cxUMahnOPYY3RVXfgZ5XwzcqIMdOyIDasH12kIlqKf8wwkznGfhiEyKCe1dkjrWtkoOpwo/fwQltUup0dGI6ySWNuPNDDI4nOFRIiM/lcYY4ykL6uhlbuP5AsWhEHl/QW7s1kEGAHfefKFYPbhFJv/BaDgO5XPd8s+VAjorTlGNR/fw5kJjGmHV5SdTpOavF6inboga8NAOIr/dnEvFS00vEiENzTk3JTSzKRZdFX0mSuIOw9jnuyYYZgjO6o7s1pVJa6YRpV7yCCUeejOMBVydlvmtemfQjs0UEEp1tF601NdXVxppUph9wJlC1L5Jm9WSsiKNab+gJFr1Tbtzhn61ZRObxrpL/TjKIOnXijb9eBe/P3SdeZRErf09H7kPvM2reID4PuMEUN992AkV5I/jYfdnc89bzb2pRHwXcCVsN3TySjkWl45DqPcaDTBmKlHR3rkf/N3rmNCFrFzAbLk13i2o7L7ARWLAWFv9YYeWthVSd5RImPAuElvGZGg+ICZ9NXf87dw+ALuhzz0s85WRB3rJXDhIdXCFGnuBkk7Ujr54RCJ9BoKxRcJuzAezztor4XK+BNcougANbw9YAPsWVo4I2h+2eQPFWJEMgs18iCpRpzVDXG2vkvHvIgSN8K3XxJ2YbOBDm/mVSntpB1Wv+JVAXBpu6oTDULJqnpRu7ZaBKA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(42186006)(83380400001)(40460700003)(2616005)(186003)(6916009)(54906003)(107886003)(26005)(356005)(508600001)(6266002)(336012)(6666004)(426003)(7636003)(316002)(47076005)(8936002)(2906002)(36860700001)(36756003)(82310400005)(8676002)(70206006)(70586007)(4326008)(4744005)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 07:12:47.6733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028fab54-099a-40d2-ceaf-08da32547cbb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2600
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset addresses coverity issues reported on zynqmp dma driver.


Radhey Shyam Pandey (2):
  dmaengine: zynqmp_dma: In struct zynqmp_dma_chan fix desc_size data
    type
  dmaengine: zynqmp_dma: use pm_runtime_resume_and_get() instead of
    pm_runtime_get_sync()

Shravya Kumbham (1):
  dmaengine: zynqmp_dma: check dma_async_device_register return value

 drivers/dma/xilinx/zynqmp_dma.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1

