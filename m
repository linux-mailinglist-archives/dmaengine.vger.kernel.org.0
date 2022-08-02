Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2C587A95
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiHBKWl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiHBKWk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 06:22:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A14D4EC;
        Tue,  2 Aug 2022 03:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIfUDBgDf+4TmnyRq+MLCNIGj77fO1CDcu4iY4ej0xlwOk5VAf37xcd9R40pVCzm/WGO4C95MLpBfv/LCe/Z8ZuiQk7yWxWKgviXCZW5UfBoaFTAIfY9BYDOsWyDFInD0VsHgETH9d2WZoGQ7DsUNwig7bBhQI2fwm63UNHOeTUGHaKfqXrdsxKjeQ/SDHELs640+AvF6RwVjRfWXlfJh8CKh25Yj32QHQWxi4J4hBhQUXCZRZPI5mZSmGsyaR1HXfWhXi8QXykgpHEtv1ImJwDLrLLe4QFk8YhJg47y0JeceGwpMTkLL2b21sL+oQJPWkTIEdxFAyFXMxVbE4aLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxFmZJ30Q5dN1XVbkd07mmY5cV0iFlpxYaMZMEQqXXY=;
 b=eGM4Gi6RMsJdQDMdQHbYDhEUD4VBZw4zpcbHlhgTjcdCSl7VsdGVnAUn4IzGyrNvSJmeMYnz1St7jPEpRP/JR7sogZTo8RAWB+jZUFnmd4NSH87hWGNalrD403uqfeB9XbJlqIXk3g6IhOfY0ulvh62qhO51i3axnYuZEgkMfySKJrBQCwJyyfAf8gBH3CBt/GcwkiZCR4G3XMKJMIS1w4cUSq17FFlIhEBD0Y5/1+RSWF6zaDKE9/Cux7AgEqheihlex88v4ExFpPw+vVR1iVDrZBhp1C47FbySGjmtEeH16H1Kg4S+UYqR7i2SlqSdKxYtGfh2i7Da/woZM2kmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxFmZJ30Q5dN1XVbkd07mmY5cV0iFlpxYaMZMEQqXXY=;
 b=u7+Cvq7G3cfqQXIG6vqyBSo45HNPthX6lyPHPJwSceuDj9FoX/az160mLQruTTdllCGsBLwZYYNXFh5FSUbLeBNbCS91Hw1rxVAb1FuEVSqdAx6jI1B0fDDQKrgrbMLlsdcFsOuO1aE9I0Qc/QsR0gzL7kaWRIqJIijIqwvp8A4=
Received: from MW4PR03CA0354.namprd03.prod.outlook.com (2603:10b6:303:dc::29)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 10:22:37 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::fa) by MW4PR03CA0354.outlook.office365.com
 (2603:10b6:303:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 2 Aug 2022 10:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.11 via Frontend Transport; Tue, 2 Aug 2022 10:22:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 2 Aug
 2022 05:22:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 2 Aug
 2022 03:22:35 -0700
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 2 Aug 2022 05:22:33 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinikatakamlinux@gmail.com>, <michal.simek@amd.com>,
        <harini.katakam@amd.com>, <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dmaengine: pl330: Remove unused flags
Date:   Tue, 2 Aug 2022 15:52:32 +0530
Message-ID: <20220802102232.17653-1-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f3dd29-bf5d-4552-802f-08da7470ec2b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jn+EimVEgp+GS6FlQUvQqK/Tab7sWdM4ID8yHIMa/00UlkfuGtIjL4I3Mrbj+M9EljZZtaVy38SWLF3xicOsOGP1sQ6e+ln8MaC9JEpI3FTnKz7c/KJOB91gZl3neXbk37Nt11sS5CG/ptm0SsGozJlwEVK/qTpzXCIOdEln4TlSIIEwboglPx4yhmai24Q5UqR464sbFmIozDfiZr8rFA+uuyOPwtpYKyPzF8m6xS2qqw9JZ1dUz/g5qN0D1WUBfGLtd3Qgc3UYSuU4iEyeVLj/t+ThOSjpfBM9pO3pKXISM/pETV40ZSpzm/GVWY/zobo1VtlR8UzM2ofr/HtVJnrGNSAoc15+LhrRevfOXI2Pb+BNadFs2Uow3jE0duOuBVTskkOZR2qZk3lG2b2/mM6DyPfAcFZ1D1Mb/cC3BUP4+k8I/M4v5WNiGqiNLA0pnLcHg5+mQTu/1ClgHgWFvG0xzCYT3BhQqvVn3IiJkp2Gtp3cRf+axs1ux8eU2vDva7VAxxp/84M3XZ8Oc+SNYO5hNqD93KuW/Gj77L+vtojjmLlSs4QTb0+p96f7T7nYXUQboybs3yZAwPbG/8tYP5VeK63TlUMJFnviSQLIMbYHFZro2Zf/NpEozkcRQc1c0z4yw/L3dy4Ihzjk9VS1YCP/O8il43H/py5FnER9V+9gZMRmfVfUzI6DSclnoVjY5ttuSuaUeiJ9Vsj+M6Jfsc870s2B8Z00EvGmucERF0NI7+dMSotSAJUeZKG+2O9+lXtTvsXR6jM4TxGtP6HyZEYRyiTig+QGakwM+VkdKJ5L0gfP6aL1LuCeHEHPXH1N9+KBIDooreGcCPAIC1Z++A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(8676002)(83380400001)(4744005)(4326008)(2616005)(1076003)(36860700001)(186003)(36756003)(8936002)(70586007)(70206006)(5660300002)(44832011)(2906002)(316002)(478600001)(82310400005)(40480700001)(6916009)(54906003)(41300700001)(86362001)(26005)(40460700003)(336012)(426003)(47076005)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 10:22:37.2060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f3dd29-bf5d-4552-802f-08da7470ec2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

txd.flags is unused and need not be updated.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
---
 drivers/dma/pl330.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 09915a5cba3e..0d9257fbdfb0 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2752,7 +2752,6 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		return NULL;
 
 	pch->cyclic = true;
-	desc->txd.flags = flags;
 
 	return &desc->txd;
 }
@@ -2804,8 +2803,6 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 
 	desc->bytes_requested = len;
 
-	desc->txd.flags = flags;
-
 	return &desc->txd;
 }
 
@@ -2889,7 +2886,6 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	}
 
 	/* Return the last desc in the chain */
-	desc->txd.flags = flg;
 	return &desc->txd;
 }
 
-- 
2.17.1

