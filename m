Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729BC74FD42
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 04:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjGLCov (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 22:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGLCou (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 22:44:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97509B;
        Tue, 11 Jul 2023 19:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+OhjTLB0/HmCuWaPbZoaqHnxIdAE5d2ZdoFPIxhJCgdQnFQ1mZx6Not3ftpejcTx2CmgO1UXW8apVPcKrCapMIeJUzm5M2rtXJFZ/Vy9cgpva4JF3H+YRwR4lZS9+TghwIMTf5rSIVl+UqGKKBTllmuH7fe/o7y5SoPrDdvdbQV2trBxsX/ZcxD6sJwb0JMw2fUGIEaRYu1Q4BvChkDDDyvXcH80kluORNzSOuSRHY7KcHGQvFICl42zIuEqmz582j1Usw0penJARnjLqODeWV3+kuKyAYYWDFzcNazKvjrsm3xqHcgu1n/QjuS3cngpvtVoQMyIWYYjEVCjiKRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KYt5yRiQVGWYlu9qqaoU1eLX3GdqPecF7OMPRSEEpg=;
 b=NcgeHciTesNk9EpkSfBeoIRoTy/IOKJ+EYzIuEkSkcS8/zFpuEAwnQNBC/o3Ex2anNTAhDYvg9l5CwWwFrOWYkb/oHStwp2hVTxr6aetam1P18kZehbE976kmZrH9ZOx3VLp9Ij/ksvYU2q0hggrvIrXXcaNlfnqoC14TC6GdQywjaeehHI+ORjR2zV5AryJuNb+Qd3lu2JO3fSAReS0QFSLPhyoqWx2m03LLGNZpihzTieC0FPVr85vhAa4AlCHV8hfvY/Uij3fuaat4TnxkgRfNC3lkRdlnk9EycZc6v05ONE86oAKl9Vuncj3yFaUeE4vCznNmI7UBRsuVm9uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KYt5yRiQVGWYlu9qqaoU1eLX3GdqPecF7OMPRSEEpg=;
 b=M7uDQSf5qHFbXtF3CygYZG3ZcBQZ0Rs8FkNtJ6eiuN7btf39OnM+ncY96tdr8e9XZitLa35hwx63CDBO4rCQ/RwNl/crb/oxFydLpndiWmjBPrSzrctWjH8pqpmwGk20SOF8zSOeCW9tsginByqf6BmU5scCCsb7wv8q74Xk7eMpit+pnksL7ExCafFc4TUQdkD2/sjJ63NDk8lDn0sTdRZE5mDqgjOYSzK10fcKucKRhdSoqfd61ofhjCl4hyBaT+mi0Ap7FAmn74hdiembaGqt9YgZETHUFH/Nqly3HcLxbh5+OA9Onr6NhL/VEPTERLEaG6tV364/8NdLwolngQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4435.apcprd06.prod.outlook.com (2603:1096:820:6d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 02:44:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 02:44:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx: xdma: Convert to devm_platform_ioremap_resource()
Date:   Wed, 12 Jul 2023 10:44:21 +0800
Message-Id: <20230712024421.15005-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b405eab-9b97-4074-e359-08db8281ef67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtjAl1wcMliP1ysLw4RIYAkFsPMjrXBdZKJdVGQHsGgcIE1jUT0lAr5JkH8qhap1Avif+6rAXDrQXIKZxkxus/Tfwxf8PPpyjvYbW7ePemR6W0C/AONeNeJqfkIhfMFAmJbVf/VBa2GVc0Mb+L9UU0Q+Ncz2uoI8YuEBm4woBdv6XX1yUi3c+iGI+lx8RSpwCWMSIONBXuqRj0CRVyq5Tt4LCoTj1Hq2Vnn58S+rLOxj4YvKb2RjVpLWxiHFazPNj+kZNuK31hCHhrnxCpVfijttxid9tnNezOZmV5VdAHRTJ48MzbEcRRNQ7CpwNVgeW3EAA6VOgL/BTCzxAcZHecL842LceRjZWatcdYySbr6oz2OA5qBPSctSYDqPamwETx5Ns+MKnrYjNASkxRZ7FEHyYOQXDZaCRE5npt/V84BfuBkYoVY6jtwpcmHneuTyBEvid4r7YmJsOn1ShYBFK2BNDktjxPuqsZZ1x0HUrClPBCAxlN+D0G09tTbkE4+/wUpsKtTn0ILmIS4CY4+bvHFponPm/VITtrzhvYJFKaHV0ZtdIxLPMTeKd220wT+QOu+p9UeIMf86XDFGrNnU1SotvgD9wOetHTKL9uPX0EK2Q73epB1r78S2Q4MURP6u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(41300700001)(8676002)(8936002)(316002)(6512007)(478600001)(110136005)(66476007)(4326008)(52116002)(66556008)(6486002)(66946007)(6506007)(6666004)(83380400001)(38100700002)(38350700002)(86362001)(36756003)(2906002)(1076003)(26005)(2616005)(5660300002)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlC1e4AbAHBZdbqGSPQkpUk16CDXijD8aOqk9hxqNKPtKGarmeoBcJKfONFy?=
 =?us-ascii?Q?Bd6gmk2gc5I2/yxUCNvOZVqxPFMoiWPST147+7wmyqVPI//jradPHTbk/mzi?=
 =?us-ascii?Q?dAwahDSE2wZvLU56CO2nVOPZeBW+H5n6dhYCAktX40/Du6yLIFmpaZFJN9hB?=
 =?us-ascii?Q?MNinH6utROa+d2U1tgfexlxgtF8/9h6xa5b2rlLe3GoVklVWhBMuOr/8i6Mc?=
 =?us-ascii?Q?vNhleX9B+s/ZH5CM+f1RDw5mJ1yAbGjP2RA5gWwC8v3i9cLg1oKIREt1jeIp?=
 =?us-ascii?Q?bKvpWgopYetUoPi6kiDWgeEcG0njjnXYCeWagdQsfgWg0edVfNcbS13Z0VTf?=
 =?us-ascii?Q?eN8UsXdkbSBBqz7anHbGFS7OLGxfNHamYcJE37osxTljTuVpHWCx3052n6RZ?=
 =?us-ascii?Q?ktfCh7WpcvJ521rlX1d8vjp8bSrsbK3qk0Z7XzgufxFQAb1lFmNAtgajUPOO?=
 =?us-ascii?Q?iU/llzoyyOA81q6WFMMu0nMFKnDeq4rfUPrHhyyBoAWypM69ulkRMCXbDsTK?=
 =?us-ascii?Q?Sr0j7u09faFEK/H8mjacXX8W9Z0Dcm+yETZvjDAxlg9ckI7AQm42PE4V+p6q?=
 =?us-ascii?Q?NmoJjnlVv4RMjBu2/DOC5YqBdhMWxwVC/Uh/YxZ26xjvyHsX8jWAmcbjWMCT?=
 =?us-ascii?Q?2sQ07JN0zjE5m91MDinNuSHaMpuVl6qQqZDGbumnzhHiOmewfi/22cRRCPe9?=
 =?us-ascii?Q?Gj87k2TMEA3Wvxq/AuifULUeVywkTMFk//+c4gMfMd32WHCDOMOE+LlHSWhp?=
 =?us-ascii?Q?tNt15W1XQKLBGtudT9jFr6CXaUtI4UbQD6AwCoj9MlZfomM2p/PiNS3xfmXq?=
 =?us-ascii?Q?AAO9fq6ZLO7M8g67XSn5o/Cxm49ZldKZYP39RRSGdfvg4VGjdcQLbKKz9FHM?=
 =?us-ascii?Q?N4jh5ZQY++UyjwoXeglC8JDXG651s3ZzY7j8FKbxOQXYnW9BS4aSuFVGqrru?=
 =?us-ascii?Q?6KbjjDH7wFQOQ5ezCtHVUbPeyYoTUeEtOtxZ6EsvE1iv0j0H86UQnRAjCuMo?=
 =?us-ascii?Q?i96NCXrHJO1VQGYet+ItFEDxQ15EHzXL1XoKU1uMr09vM+UdOQ/MjM2NLp29?=
 =?us-ascii?Q?6lHQQWxcLka1Y+poRYAZfdvhAvZIqsTzALxY37zhRfghDQKiDvNgaRrWVIiX?=
 =?us-ascii?Q?fu6hujRJzROJffrNxScFYtBYnCORAJ0zTpNTKXEmxte7QlJnsG0K//Ud/git?=
 =?us-ascii?Q?eIFxWuE5O2zI+W/3KWQ8/Ze9cep0Hrjy3SFacW5OEPrGbJOQazkgMFyhLSn7?=
 =?us-ascii?Q?iMP7V4vwfiojhJqeZtsut0qtC9DUJ8Orvyd23tJW1IOJ+ueh2hEvnO+k9aIu?=
 =?us-ascii?Q?/vZptMvmsHp0oarcLIWiS5meBFkCzg79Ea9sttVOkBD5rlJ7V2Nt1yOda506?=
 =?us-ascii?Q?ofI8IlRNWZctki4ScymsrT8CN83lziKW4KU1s/dtto20m2MbwCA6Rgtd0i+8?=
 =?us-ascii?Q?fgl5PQFWuu/uNPxUoUilkYPSIlCWWbyD3VjRamKVenT0stYJVl3+qerrH1E0?=
 =?us-ascii?Q?aLtejZzy1tcEjGiqZEHypfLFOcYQOjbljKycIVomkzhmZ12cf9VZ/vc1MJTI?=
 =?us-ascii?Q?eBTAaYoC5uWpLei4Moo+ofs5hafG/SGBWK3GiI+R?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b405eab-9b97-4074-e359-08db8281ef67
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 02:44:38.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTMTbOnkRot+2z5D7nAbgXf/M1KCqDo3rVKas2TtG1C/UQ3ZnUd8+diUirzdxpdE0Clo/iDf9s1t3bRnR2Kpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
patch based on next
 drivers/dma/xilinx/xdma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index ad5ff63354cf..630927dc90e8 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -885,15 +885,9 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->irq_start = res->start;
 	xdev->irq_num = res->end - res->start + 1;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		xdma_err(xdev, "failed to get io resource");
-		goto failed;
-	}
-
-	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base)) {
-		xdma_err(xdev, "ioremap failed");
+		ret = PTR_ERR(reg_base);
 		goto failed;
 	}
 
-- 
2.39.0

