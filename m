Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE990559392
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jun 2022 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiFXGg2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jun 2022 02:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFXGgY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jun 2022 02:36:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CA62708;
        Thu, 23 Jun 2022 23:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7Dro3jw9a24PPX4qSyZ4kvN7IlOyLe0N+Uo4EEpPeOpryac5vPRrCNt2RwyGfSNR22W5lWUrocFjXIAWZTMyKFvRck2Vg6YLjkpng0uivtYOvDtk+gOYryUxaCUQ18It6YGYFyYvqfpgn1mDQUYxnnzuE0hPsyGwrJ2SFu1Owrp3ae/Dgxm4juDewTx7djbm4UbzEXOOlOTDL/AjL+FyYD+qgPKJR+G3QXE+7Fn+fr0D5FlUq4PXXEg2V6cpM8ujz7pu4wVMe6PLthc726hnB1DgoyOY/IXiTwZeBgv85KLh6eSDiXeysno7dm27pLD1BAlkQQjgcEyo4BV/RLn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpTbg2Dn5w+l993Qdl4BtB67ymDxcj56bK9pi14JTb0=;
 b=UwstuVC1/kA42T+tA27+qMNrrFRUPXd3IxM3Yp3DGdCvJtM3k4sdh9XJuTUboMol6H3DJXGDoIP3JxeC6y9acykWYxCB3/xCVClpNwzxujBgZUJa8XoTnMkfikS9jA60bhrSWvoGeRi+lcrnC8DzkrcfLJBnvoWXkMpkeuGZzlQi+SwSaKl/7pjCExHMpeqTRLMoVSdYFhRFuXal2NXjSqNLZD8m1SFT/zqv3GvFWdZXhy+4SugjhEvIZ3VrQIhyqG3p7yLALHeNQ2iiFnP6dN0v9xMMwbO4i/N4VDnTaFBccB3v1+3rfKuWxoRHGl8wycuE6/G1jcnjrQRJHWA6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpTbg2Dn5w+l993Qdl4BtB67ymDxcj56bK9pi14JTb0=;
 b=k+umEzA5oqYVDDeXG8nkMvW+XebailNvabpr4xVCGGKDncAxjVXWWUPpMOwoC6KL3/0r4DxMG6YP+xWcsKmzxysstdBWRQyuZq+EMBI9mgtiO0Xd8UpZo9vLD8NXroBfRrYaH1zL83Ah36uPJA7wJ+2c+HY3gqqevleilR5SNEs=
Received: from SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::7)
 by CH0PR02MB8011.namprd02.prod.outlook.com (2603:10b6:610:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 24 Jun
 2022 06:36:22 +0000
Received: from SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2c1:cafe::fa) by SA1P222CA0055.outlook.office365.com
 (2603:10b6:806:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Fri, 24 Jun 2022 06:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0052.mail.protection.outlook.com (10.97.5.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 06:36:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Jun 2022 23:36:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Jun 2022 23:36:12 -0700
Envelope-to: vkoul@kernel.org,
 lars@metafoo.de,
 adrianml@alumnos.upm.es,
 libaokun1@huawei.com,
 marex@denx.de,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.78] (port=39188 helo=xhdswatia40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <swati.agarwal@xilinx.com>)
        id 1o4cut-000FW1-Cm; Thu, 23 Jun 2022 23:35:43 -0700
From:   Swati Agarwal <swati.agarwal@xilinx.com>
To:     <vkoul@kernel.org>, <lars@metafoo.de>, <adrianml@alumnos.upm.es>,
        <libaokun1@huawei.com>, <marex@denx.de>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <swati.agarwal@xilinx.com>,
        <harini.katakam@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <michal.simek@xilinx.com>
Subject: [PATCH 0/2] dmaengine : xilinx_dma: Fix error handling paths
Date:   Fri, 24 Jun 2022 12:05:37 +0530
Message-ID: <20220624063539.18657-1-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2472c35e-aa37-4f54-61c1-08da55abdab2
X-MS-TrafficTypeDiagnostic: CH0PR02MB8011:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5BR15YRooIXzaSZ+jikZu1l5TZoMXkbLTQ53Y1F3OOcV7CcN/ktOeSO1AYxHBJOsUBYblclwtWaZVVRv5N+FmJhB96tybLtcOB2+Sl0ZZprg7BQ/GIfzTWrcbmtxOYnEiLoRlZbwYsaeyl47iaWc17HSRlwYxjU41Wob4+6hsk26tzMlGRjBKNZ8pOy852HW5rmc4EHyDQD2wvxgtbqwJFd2QYXj+h+8TMasqfzQQBoLva/9lSluHRiegUf2BH65wZAiM+OtljAWZ9xGWzz+/G3OLRQmHGU1Bc9kOtN68awgO0/AA6Gj4sSpnSvNDxv9scCdCgScHWbFJeMKh9/BYaizEARTJQbgBNlr52oPSc+bQ9Gz8GJZR2l9pPxjVrL5gsZY31yW2XbTEUTbVmQYn9pCbvszbe+5aFJZOULpe81SDbyeeOIGEeaNwrApS+qBBlGYEX+5tWbwQzM+j4JLbcCAOeyujHQmf/++ahi81x2Rp/Ier1+LnOM8OOFVkh87kH15BeWQ+ZuxZ0C7sbQE1m7WRKri9pFMUI9oOFnZxS6viiQMbPIip3AkDqj5xarJmjX6vfqEJTchrZABRU3nF4sSUuwCUxmWs9yNsxgYaHtcQxphQYdzgOCRpKkQ/7eRnQBXTJM7xOe6QMHKqVP74WIj0Tp9ULFh348BkeN4ozSVcTczil4dDF83z9APwVne85P/aQ30GszQhn3u0q2tCdtFlt83UqJ9qrZFTjv1VAqGhtXYacoc3nRrxrkmDHDX2bj9Clxm1HSs6jEBX13pQLk9WOmJPEq7EJHU1jn2js5G8UA0FkJ8Xc1iz8NHU6FH2cujGI2WlOg8QtjeKicqQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(46966006)(36840700001)(36756003)(356005)(316002)(1076003)(7636003)(36860700001)(26005)(336012)(47076005)(7696005)(2616005)(44832011)(426003)(54906003)(82740400003)(110136005)(4326008)(6666004)(8676002)(8936002)(4744005)(70586007)(2906002)(5660300002)(82310400005)(9786002)(186003)(83380400001)(70206006)(107886003)(40460700003)(41300700001)(40480700001)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 06:36:22.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2472c35e-aa37-4f54-61c1-08da55abdab2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8011
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

Swati Agarwal (2):
  dmaengine: xilinx_dma: Fix probe error cleanup
  dmaengine: xilinx_dma: Report error in case of
    dma_set_mask_and_coherent API failure

 drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1

