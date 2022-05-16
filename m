Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C42527FE7
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 10:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiEPImw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbiEPImn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 04:42:43 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E3E09E;
        Mon, 16 May 2022 01:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0vVbbkL4f14Aac+GNShj8zy2uKWHpxyzAAGxgEP6yBvPxk9uRdgIJZepR9+CwSWEql7zCcl6VbPgezE+gnLeSAlzOGaTpvsteoUCnVc58UJQoeLFsWf86DTWxpVMUgh7KstF18XSML9loCOFwmqALt9WCR+5b0ua+TxbE6wRA2DEu5hFVF3RL+/S1zQ61J6EOfvJUo8tIv40+sFDehhSaVQeUAORyomI/quTmYDi+cLyCvz0tU+CZuOULugTWjzHv94yXClj6I1k6GSggIRq44p1hkQlyTwPShLPnqZ3tOy9yG/Yqyp/iKANPr6up5PbYgO1GHxcuWzbee2YlKSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXNEXCszyK1k1ab9hq0q1ucGzPn4mrmbmlx1iDS71fk=;
 b=Bo+goWztaXz7IedzrwByJtUs5WZl+JEGa3WUcT8iIq/uXKsVYdaC7pkOUPCe22ehWdpxCPZVEnD0NuXLEi6a4usPPOrw1twS540halSNFV+/+XyFnuXJAJtxHQE6u81uRfyH0nOCGbGum4SKH2St8dxdtLjcqxc60ctqvBPmnEfq4TXVqaFIFEv+j5Bnv81+pzEoaFi5m4F2WSDvYi8cQLa5g7NSzOygPWdpznLobhB7Z3/k2Yto0vSI3hcBrqUHehfdnWgf/kyYUzMUQZIlwDALtH1LT/ZbU2pmNifsWe8Em1UtyxFWd4OWxG1a8SUaoOQaa/EEf9RHzEw2DAXNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXNEXCszyK1k1ab9hq0q1ucGzPn4mrmbmlx1iDS71fk=;
 b=gzysEHfEk5EXm+Vh3V2DBbWqC5YOAJ18dVTX7HFiL6rkXEkhGtz0VCgk8my5kDujAkAkjr2k6r1Wc9EEbodk17kN1MGVNcafHkwLLG908YCz11FfcLriyhpU4WGVFnsBpH2oJJfhxFoBBN67706cflRkQBBiH3x4ewqDQ3k/ltE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2977.apcprd06.prod.outlook.com (2603:1096:203:88::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Mon, 16 May 2022 08:42:34 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:42:34 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH 4/4] dmaengine: xgene-dma: Remove unneeded ERROR check before clk_disable_unprepare
Date:   Mon, 16 May 2022 16:41:39 +0800
Message-Id: <20220516084139.8864-5-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516084139.8864-1-wanjiabing@vivo.com>
References: <20220516084139.8864-1-wanjiabing@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20cd911d-4537-47f3-7050-08da371805c0
X-MS-TrafficTypeDiagnostic: HK0PR06MB2977:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB29778B4DFED0F0F3D10570DFABCF9@HK0PR06MB2977.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0ELUy40NiaQaE79smYmlhhQNh+vxfoZnCE79QVbG1mQrlJcz1NYatnw7a50jH4DKOnhxJxAZgaL+omipYJAYEzsaMKRcXvwrbOEBuqvI6P526Wh8XEDQ5O55p9rSOQcGn4IkxeE5CSN1Mh1lpuZHWc47GHqIh4P/mxID0BZ1NNwX4Wbs7J3d8RDGVoGNzJqx0tAGUiA+gkLPQuBnKMTR3ciUCpmSojqzvEBZzETv9Zx7DVgK/cQWxEGQhDFoCZ9QczKr/KzourmQmTwqg/JXIWsuKwM4XzndwqOlrLTs61oBiLE4V6+X34JfDgSh9Xr4lnHO3KtITHPdk+/ku+UJWPLlHGO+V6jtW50Z9cSds35iklcNyShCFX2CbJf74gv1qwuNrioUuuOEsR9Plf5zMSrZbGSx8vYQEyJNrnSLa0x61nrjz7rp0+2sRIkcHww4sDIwLdk9QBcXtpixWZyTbykjgAwzyo2PRA8dkNpRhINT1I1w9SF0uB17dskLlEuDENCKB42x8+o1KvvBlk65PHj3Qqlmy0OT4+2a4lEPAV6KA+dBvvVVgwsuobTkqM7qauE9z+bQfhN5O6e0f49qYZACcR5XkqdTv1xcz/FdQKSCpNNTJ2BYOlopV0UAsGN5IA1TRdwgHJ2fsvl4fMQiHs/lOXHwBrCdIctTRTmHUzUajgjDVvvcWOP6CnsFpl+W+z2rO2SHzMhupX4/5MKJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38350700002)(38100700002)(83380400001)(316002)(110136005)(52116002)(6512007)(66946007)(1076003)(186003)(6486002)(66556008)(66476007)(4326008)(8676002)(4744005)(5660300002)(508600001)(8936002)(26005)(6506007)(86362001)(36756003)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUfll+W0zoQF9O64Y0HfuJsprIzgH6mPX7efi1H0oYzsQU955xosbqToKbRK?=
 =?us-ascii?Q?mKT8WyQpKFMmBCBzFWUb0yPqDg+g1HIB9o787w6Eu7U0tw7DcZSFoBu8pnKY?=
 =?us-ascii?Q?taHfQCZH3y49stvIy8gZPMYlR/hSvfkzzi3S6m2BXNTaoDhj3iRLSzJCrXuY?=
 =?us-ascii?Q?aVz3TG9TFrTnpAd/v9rsRKXVw5g2AR31WJkjM+ejvjNgtoopQZCrjcX7jNDO?=
 =?us-ascii?Q?KYDHpu7TPgjeVc+jPgSTCYrVzNgqvy4gEsc5t4FbzWiBEeEMjYU4X27dyjmI?=
 =?us-ascii?Q?LntUCbiW0wAhix2jPa2iAHXJA3cR+q8wnsqq1B7prdl26JJq77y3ROgHoNkY?=
 =?us-ascii?Q?BMCqVC47c5Z97Q6ekbpnlx0wdQwJHlBClU/aVTLnCgCjJGOuQFsVkL4S0mBo?=
 =?us-ascii?Q?of/3ofiDTRKQdi2S4oWgSYZ5ou7spmqR/t8aAYq/ZAi7+n9kUbPSTY2BecAD?=
 =?us-ascii?Q?RFW4XG/TdhW3ZkxUfvHATzx4FsUl30h5pfD9lmrAw85yhn5hmFhgS9vLE+Ws?=
 =?us-ascii?Q?rRUVT/kWpxCg3F1gy+RqnO5sdJMfZoB/ZcW72PcLXxj9mc1J1fVthZ4o5ItR?=
 =?us-ascii?Q?r6h/ypAqUcfLb68JjL961gIy2yeIOGkzL0FDLaSuJYcimzBCWPIM6Ss4c2Kp?=
 =?us-ascii?Q?5FHThmq4PiBw4L2rnPN49PWvfjEqMpcgrzr3ijQ5+Axv4vHqa1BwLHV17c9A?=
 =?us-ascii?Q?Wn2S1gG8g+MdHzcKKZAqvHsG8WNQGHUWseHX5d0udtod1I22RNqVrZtC8tta?=
 =?us-ascii?Q?SksVME6lmyfzRauBLg1gUN28wqN16fRu3MUTsdmY6NutCeeLokb+qLxBtrss?=
 =?us-ascii?Q?c1CkrP5kUqHvfWnUb3zD5jJZ/Yrj647kNrAbyZxg+e/2nS0WPnWr7ti1t8Sa?=
 =?us-ascii?Q?k2WaH/hajkM/vgwVGXffNyFWRco6GBZLuu/1UAQ1yYpacHr3vG/oUUoDM7Vv?=
 =?us-ascii?Q?Nwu3w/27d7uGondowIlQzUVNbWPn2OxDMkMIHb7aXTgVtlho9ZfWx9CWAfv1?=
 =?us-ascii?Q?wPlCoyrUiep6xtbg77IfuaTlS/SLtS/cgegAf5TAAF/hNnvZPbqbCkgBpeBx?=
 =?us-ascii?Q?z56dqyMUuasVoMJFzyNkzAJqK71y/BK3hpnUUL8CnC4kfhKF67Ip+IWJeElU?=
 =?us-ascii?Q?eH0Zxh6vyPOtWU5O37ZDGGzik+fsJ9muYuvaKZPkueKTZ2D1plkPlD7/WYnq?=
 =?us-ascii?Q?cQ6bKDCcRP3OEnf1cgLmxBWFskpv2W2rU+BF9ltcLV6fqGZYAZAbTZtxjq2S?=
 =?us-ascii?Q?nMl+ZCkHZMQc+2u/AnIqmBn9GPcIwk37ibhyvkW40z3GAMagPq9Hiz0orin3?=
 =?us-ascii?Q?tKeRJI+wsITa+MZs6ILPS0Qg2rx25w20QYHK8ugWYaj/zsitnfJvcCooQA1U?=
 =?us-ascii?Q?VaH/dY1JZ4XppME3k6U3wNoEVUQPnoRfF3GS+5Ter9YEsgS5UiVO3er0floI?=
 =?us-ascii?Q?LV+B26r2opp/Kfk6TqzJ35hyFJnKSfyMDb6AVChmUTw9S7LAdeKAVT3WIGHr?=
 =?us-ascii?Q?QtGcXdceY6lb8kSyO/LC+N03dGE8dqau7QuyLb5wdHz2+Z5G4BpMflVem+jC?=
 =?us-ascii?Q?qx6TRk/ams0MARlcB6LI30tvX8y7e9Fl+Y4OyOTb+AJZjTTyNHAHuihuZADo?=
 =?us-ascii?Q?4YTnXLFMl/iTyUAZI+/QlpmqvRnOrpjaTx4KIEPDtRwGSdgHafhfubaP35DP?=
 =?us-ascii?Q?hLv3VjIhITSzpIaa51pia/eZk85GDjMsY7zrmvYSOihsMPao6CG2v/nM7Vx1?=
 =?us-ascii?Q?BZL3yvAXiQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cd911d-4537-47f3-7050-08da371805c0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:42:34.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaGqYM1UUaw9lbx5Uex7MEmkaGoLLuxFze3ahjaSu0T1QA70VTZUY4A4A63fbl6+k+iR5bT6J/omBqZDnyEOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2977
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
Remove unneeded ERROR check for pdma->clk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/dma/xgene-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 3589b4ef50b8..7f0088b09714 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1769,8 +1769,7 @@ static int xgene_dma_probe(struct platform_device *pdev)
 
 err_dma_mask:
 err_clk_enable:
-	if (!IS_ERR(pdma->clk))
-		clk_disable_unprepare(pdma->clk);
+	clk_disable_unprepare(pdma->clk);
 
 	return ret;
 }
@@ -1794,8 +1793,7 @@ static int xgene_dma_remove(struct platform_device *pdev)
 		xgene_dma_delete_chan_rings(chan);
 	}
 
-	if (!IS_ERR(pdma->clk))
-		clk_disable_unprepare(pdma->clk);
+	clk_disable_unprepare(pdma->clk);
 
 	return 0;
 }
-- 
2.36.1

