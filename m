Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291964A746C
	for <lists+dmaengine@lfdr.de>; Wed,  2 Feb 2022 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiBBPPw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 10:15:52 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:17367
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239404AbiBBPPv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Feb 2022 10:15:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqjYOqFh8JSXQJ9Mj+Eaw6BGZ2e8RT6VYqG47WvQ/zj/qRyyGNOarfoYsKuqN1cSpELki6R1sc92q72HtVYdAuJJYi5iUxbZilH8KJ8V20cR442TxCH+VDmm7qut4egxYmEgbcyPbHIwUKxT5YVbm48w/6DOxpfejFJuBzcfbiMNhEDZ2KBMosiNmTlTOtBF+h9StRQQGJR/J/9bU+utT0UI/XkjdP+tQqrQxeW1Yd1EMwoL7EfwtA9rRTYswe3DWBjR/+LoXZcvLDEDbRB4rKvCqLzlfTQJGLZ+C3fzEY1nFFo9OV2xyHvi76kwYnc9afsb/DDtCj7MpmS2+AmEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICvFwPO+MqgZci5I82ZuvqG2YUix/dEwATteDntxTDE=;
 b=gF87/89RN9OMZXscvoBiqzggwRebVpLW3wQf172cAiPKIJqxCu0UDx/ixGfRGMosbB2APIkiGJqO5Ndu7AWs3Xn2+CCqpKsetnptUFkH2ItwwKH6QoYsbplteQo3DffYwhRJwX6ffxaCAY6bvNzSh8S8Q2/M3iwYATICV5xDV8tiiHmJTbxpqZ1BWwLCHTIAMiGdJ5Gymq5utObX/274O4uEMSqkHetmBRS6lOgIxTSK5Mt8im1lfvN7V45nvrIvbqF0d2yZcmGGw9DK/OsJjKrxL+/U1tMk+1wU3v9bxn45WgBT4NabvITJtqDq1pO9637FIp02f4b25SqE5dhuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICvFwPO+MqgZci5I82ZuvqG2YUix/dEwATteDntxTDE=;
 b=cby0a78c3i2u20sK+SyXoh1Hm5/sRuK3XAV5C1CcaWNkcuxbKvJfKcaVuU65AJuw/AqtI4d9FvwOogb6N+AWbJ3qZGkaOVg+amNfZECcxMEmBOtNmdNaAkU3cVtr5AF5P+BKxfksHkYuUy/IQI1NbnmQOfKfzF8D7ecP2SKjibU=
Received: from MWHPR08CA0043.namprd08.prod.outlook.com (2603:10b6:300:c0::17)
 by BYAPR12MB3608.namprd12.prod.outlook.com (2603:10b6:a03:de::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 15:15:48 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::42) by MWHPR08CA0043.outlook.office365.com
 (2603:10b6:300:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 2 Feb 2022 15:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 15:15:48 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 09:15:44 -0600
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 2/2] dmaengine: ptdma: handle the cases based on DMA is complete
Date:   Wed, 2 Feb 2022 09:14:40 -0600
Message-ID: <1643814880-3882-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
References: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063375ad-e584-450a-7846-08d9e65ee497
X-MS-TrafficTypeDiagnostic: BYAPR12MB3608:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3608493E27D495E6D0F06F60E5279@BYAPR12MB3608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Te0FxAqE7EEKGoz+whGtPoJQV2V8UT/u9Re2Y9b7M8d48vqxaA8BRUMjDzhXEhdhh/Tyj16KX5IPrTYa2SROZR9fJjpFQTLi2CBhdQvcvYHmjdX/ji/hnaf7RDsHgwEzSuasgX4o/1g1fMB12OoEoRN9yQkcXUvk86+18mdxRKNBfOo2WeXDQcH8boQ6YuqxuMuWXfnEjqw26mrUGeElDEO0Qs6pxHJfGER73gYfdZdrvJv5kbz8ZDSuuucn/WWARIydOnPIjp43OSzS31yN45M3LZ0szedA4aQpqGCnL8kKO86+un8+bjrSbDhnB3WPnItPeF9jlF2KViZvv+x1/6R9q7fsnf1WlW2EZx8kzI/rMCIjkJ0QTWfadU+V2gURM5Rx1irllHx7aI4svRWIcO94KM5yIXcaFgu5rBcInqH4K0VcqMHtfGN42SqJe2+RNRcYPhsLyXnBbp1hB/XAo8MGV06lMCDZwLMVUiYbasVMlBOEXL983LWuOlKfoQwk0h38vqqYoWQXTZRCXnKW9CFhw19eA3qjgul6EmO4HvolAuyrav/UL04/K+JqjhJYc7sz8W4snhr5HyLQguXncDYImp1dIVNMjZjOBUAufunL5xWlk8kkAt4qi5dAeeGbm3JuVKbamRSedKy0SQdNkMDwWvN4Ii+grcsje0ZQt5Lb/gSJ6wAtcLmo7v57k+CHihcXfq2hgGLdUDN/KAvRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(82310400004)(356005)(8676002)(2906002)(8936002)(83380400001)(7696005)(6666004)(4326008)(36860700001)(26005)(336012)(186003)(36756003)(426003)(16526019)(47076005)(70206006)(5660300002)(316002)(70586007)(40460700003)(508600001)(2616005)(6916009)(86362001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:15:48.4363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063375ad-e584-450a-7846-08d9e65ee497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

There is a need to segregate the cases when DMA is complete or not.
In case if DMA is already complete there is no need to handle it
again and gracefully exit from the function.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index e38dca4..91b93e8 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -100,12 +100,17 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
 		spin_lock_irqsave(&chan->vc.lock, flags);
 
 		if (desc) {
-			if (desc->status != DMA_ERROR)
-				desc->status = DMA_COMPLETE;
-
-			dma_cookie_complete(tx_desc);
-			dma_descriptor_unmap(tx_desc);
-			list_del(&desc->vd.node);
+			if (desc->status != DMA_COMPLETE) {
+				if (desc->status != DMA_ERROR)
+					desc->status = DMA_COMPLETE;
+
+				dma_cookie_complete(tx_desc);
+				dma_descriptor_unmap(tx_desc);
+				list_del(&desc->vd.node);
+			} else {
+				/* Don't handle it twice */
+				tx_desc = NULL;
+			}
 		}
 
 		desc = pt_next_dma_desc(chan);
-- 
2.7.4

