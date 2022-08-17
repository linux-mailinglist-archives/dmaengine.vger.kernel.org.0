Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505F596936
	for <lists+dmaengine@lfdr.de>; Wed, 17 Aug 2022 08:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiHQGLp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Aug 2022 02:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiHQGLo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Aug 2022 02:11:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCAE79A4A;
        Tue, 16 Aug 2022 23:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/zW9FY0hyr07vMDJYdZSyevOGeh6Z7AYkOk/e1IksJ0gnRz3K2v3Aa09SDsxuo4d1+qu+dtp1Mc7NsurGmZfcv7oammD4mMNZuzi5knDGeBo2F4CYjhT9qMOEL1veyeR8p4yJNIutiS/Hm9b7IqyULmGFhKgoL95Mx8/9PcmN0nY0KpsoZMDKE4IJEHNdg4HlNGSuoNuJ2mGtB/SwQXWTiHx6ddk1fVl01RCBnV5B6iyK+Pj3f+PMIcG4vqA2/7R8vEKGnymPfjVIcn4sooOpGuLaAxP6UN4ShTbbQlNo9mPm/Ee2bMoq62LLtzOXQYxUns/8pGkEtU6YLkbx+gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDb+IkdjolsD8gX05Ms+LaztnJjqMuoa+YQVCMKaHB8=;
 b=kW0ci+ze/J5S7rL2Zjv4ofRAHbIBG7b6h95lWw1ktZp6X5jvmIRIG0dlYJLYeJtG/t5WunSJsWLaY/IgMNQnm6NeoFohcix1fmK7gUXF9+n968U7t9dOTlV1cqFSqJnjtJT8fI8TfECGo5yLlyodru+b2HrE7/HJYyeBhb/7pZDtB+tmhW0S2/u8jDtVpAxJf7FdvA+asut090WipwzFBdwaNX7SIG/UlgzBf5himwp2UKM7bjOmYx0Qr8d/BolGARlIBH8+ZunsVeEih/0YOiEozcfiFXZdyIaKkFCU74+LD+ng855SDrFSx6WzYuTMGhf2slC+vbjgOGF73qupbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDb+IkdjolsD8gX05Ms+LaztnJjqMuoa+YQVCMKaHB8=;
 b=kry6qnnSbvIodtJbUGklIRUmuP4Vius9H164ylTo2vx7r+HEbS2JU4bUVlqiappfBO+b6XcIzPfQlKO27qv/0xRrQkxuK+Sftpvc2AZdJNXO/DaAYErPdE6sfu97iVQT6XO1XWpDTHdDLk+QksheCo7vL/UYM+DtYw0ZVScZPzU=
Received: from BN9PR03CA0729.namprd03.prod.outlook.com (2603:10b6:408:110::14)
 by BL3PR02MB8115.namprd02.prod.outlook.com (2603:10b6:208:35e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 06:11:40 +0000
Received: from BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::95) by BN9PR03CA0729.outlook.office365.com
 (2603:10b6:408:110::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Wed, 17 Aug 2022 06:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT058.mail.protection.outlook.com (10.13.2.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 06:11:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Aug 2022 23:11:39 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Aug 2022 23:11:39 -0700
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
        id 1oOCHC-000GsX-PS; Tue, 16 Aug 2022 23:11:39 -0700
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
Subject: [PATCH v2 2/3] dmaengine: xilinx_dma: cleanup for fetching xlnx,num-fstores property
Date:   Wed, 17 Aug 2022 11:41:24 +0530
Message-ID: <20220817061125.4720-3-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220817061125.4720-1-swati.agarwal@xilinx.com>
References: <20220817061125.4720-1-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044090e1-bf1b-48d0-5042-08da801759ab
X-MS-TrafficTypeDiagnostic: BL3PR02MB8115:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ws/vTgC4hgtIuc2yvWjX9mRhNUQphzH1TufW6kgwK5qttdmHKQNXlltq4AELwPXMhsD6sp2KZqr0lSEyQHxvK2ynI9R07fmKEGraNm0u78GCAG8vNZo8mHHZko23uv8BftIJaTImm60+B5l+MFZGc4GkyYG0UB++WbqGRsICDC/RgC4fXwWWd74Lw49Fad8ScDMcpfpvaKyE7dMQChVk8sxzduk2NN3nZJyETXAlDWVyi+P0bfu8EeQHOxou3ZzUEv3iEllnygMcCU5sg3jzshn2vKx06Zj8pDvVhkNzmP2iub1U/ZduoYcZHmFZ3eBGGE1mrq0f188h2CBDhjk1TIwApCPxvNgFt8BKCoKW2qpzAU8IHYe3boJAbcq468d2qMjmbTsoi7gUzqbVtGRqwfOWMpfVBQL6THvUP6NdjxbYtuvEH9BByta/vCQJ1B8y8UHQGbxluWOZZnmNKR0egRCh51KApx/9WUDi7x6xGe9zpnMWdCs8VXKjy/BUtd8dbnTPU+8hwRZbvvsYtItzu5PKVKWVm3dPZqE0xSmiWedJ8Z5/+BiSWCTh/8+HHSdsRXPSS6JHmp6Xzt5oxkioqOteX3LnXd7Omkyad+1lVQpCT4nxr/dwcijVk8PbRKBR8pxrM/DESTxuRZnftIvsKG3aqpie14mkX56+7dgH3kmFJE0/mDDKLAdk58kX2WfxSSkVuVmo6lp3mctHHMTka/8+ecQhbJrzR4ep9zwqv2lp+0jZA7dHXRRMf+hZ5ao9JHl57RpFCKdNzHsrjh8ixXu8rKkn2mc/pkLmWHTrpysOpBxWN6LLgUBDCW35WAKsC6hUpffenU+opD0IvG010g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(40470700004)(36840700001)(2906002)(4326008)(26005)(82310400005)(44832011)(2616005)(7696005)(40480700001)(7416002)(36860700001)(8936002)(40460700003)(41300700001)(36756003)(478600001)(9786002)(110136005)(54906003)(6666004)(356005)(82740400003)(426003)(47076005)(83380400001)(336012)(7636003)(1076003)(186003)(4744005)(8676002)(5660300002)(316002)(70206006)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:11:40.1942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044090e1-bf1b-48d0-5042-08da801759ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8115
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Free the allocated resources for missing xlnx,num-fstores property.

Signed-off-by: Swati Agarwal <swati.agarwal@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ba0dccaa8cf1..f63ec9d862ff 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3191,7 +3191,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		if (err < 0) {
 			dev_err(xdev->dev,
 				"missing xlnx,num-fstores property\n");
-			return err;
+			goto disable_clks;
 		}
 
 		err = of_property_read_u32(node, "xlnx,flush-fsync",
-- 
2.17.1

