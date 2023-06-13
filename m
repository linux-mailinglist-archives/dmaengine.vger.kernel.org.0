Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40EB72EE06
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjFMVdF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjFMVc5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072361BFB;
        Tue, 13 Jun 2023 14:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntupCuzYvVNiwbUbWhUxqPBAUipmnxJm+kLZnmxCViLJAo8SSJGhOxSi4xNCJc1jf5O4ogAEWUD95x3dGeLU2IvR4Rfs4kp9QRpfhX0qqi3rGIzr+q2bdo12hvw28s0S9N2NDgzZ2i8jSUwY1peoPXPy/vMvawodqnpwaYmw55sFro64axYRk5wtw2qOlXN3y9IjF0srV4VwK1Vj6vDAhscTILgaTnIyIticEYLmby9m8vdXRfOTZBjQb3IczGDE7GBqMhW/d0/gtrIXG251MG6ot6C11Zvh40fMfwfsa2JlmtLxtyHDuZU/qoADkqk9ax7G8qrCRWeDNhGjUgZhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=m/ibRhRZKSgA0Ed4vsyPHJHHeKjDhmPrHAeKjaX1xO35/zTUT5dNK/wHuMFn3h0lVhdG+/BYBos3bgfUcS0yGSXdcV+NM/VcK66+qtJY2ts+PARcsOMcyBAYiDm3xanCvQALJLF1pCe3GicFjCbHJW2+0UJP1TYfz4m5vDQ6EJaLU6ueFtU9re1w/txVc5zcwHe5CVsWdGaFm1d1MpgnHH2h6YABEbjAccTbpaVHTsao4nKHjXwj3gCsIFb24lU/91O+3nX3qb9/6LbhhUpH5JgMg9w9aT55t3UEeESgcVMtNhUsW2sw+dUvgNSjPdv5Do6mA2fqfLcXpVmUtA8luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=AAVMVsni0vz+ODlZAuhuuZsi0kTcq+jS/cK+sbw8j6Tea8GJNK5uY3JlpH+gir/5MeTm/70WdtjqLyqrqizLUytHsFRWt628RguTMlnPTC9C0Y/Smgyn08TYqgxr7fpUMyyyeaDGdL8NPIW/SW8DYDk8+VM7HhaeeQR/VSkW0bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Tue, 13 Jun 2023 17:31:45 -0400
Message-Id: <20230613213149.2076358-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1f8011-984b-43af-f413-08db6c55b07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJvwuwlbpS49oeM3f39c6YCs7OTczdB3unIh3pjD2cbnZOkzqd4oVrQgZOcz3HlWMdmppwf+c5sBnJ5sEnCkD770SC+Y1A9lsdZ+UDwv6kgzESWa4m18OfIshruuc+8xqx7HRSjQ0Z9f3HCC3k5rigfS1npVBaStdWRxaR6creD2XedacZAjKwW7VDHBYO8IkfOXBHJLgbhY3pKeWbQPZd6Lhx0GHrK/fTGWtilSXQiJYmxSpBVCjhwr5PLTiXv9i0ad/JrD6KPQupxLpCIbx4eosb8cS88mL4uIof7++sPlYudhRBshZls5A2xYlFAqW1Nsgsak/lFEjEch9nYd0VnMs1Wo7LCbcIwNCHg9a8j3MSTXnsnkBZEQmdYsmQ+DFeBy52gAtaX8uidFi4KsdfKWd9LfTK+XI7hHtqt9OBLTyFcY1EV41pv+BhtdNWse8uMudVP4quwK8pbQBKIqSkCoqOpLjNmaryJz6B9M3TKLIUWwWMGMwUynl9a/x7iq0e07zdcmGPL2Ir1z7lWdjWeaJDlLjfVMYGFHKlnBKZqaWjhurC6ZSGLCUxUgBXgf4Ggi0Q3v+sAf2zV1hIOV6qhgw+fzUx/Q7/2BWQjw1ia3LNRFQEsEWrh5vpC6n8dY4tjRGvqeptOSxStZkgTDLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8PrLlWilR8JTyxFfmHLdX+sWlWRPE38MEJ5f5CmjLLpBcFoDw4qN74fY2Im?=
 =?us-ascii?Q?HgeUJuNcd9avaT+ekXmfk13Tw2XuI5qPzIHNEbMAw4h5zr6GMMntyE5MCJKV?=
 =?us-ascii?Q?lOQO8L8GU49YNrX3OWV0ZBW1RiL6z+JFKE94mjEZYOO7EQIgFLek35p/KFG4?=
 =?us-ascii?Q?EJkxX3PxLAtpylmV5z/V6t9TimLl4T0RjA/3VAfv7l3qqKvnFSOs/fLFwVPa?=
 =?us-ascii?Q?rU6eDjjteqZPMcu51P2f+nVDje+iG18OQH4GmbbyzQDBsIWDa9lfLDYWzd9f?=
 =?us-ascii?Q?yoTZxFNGiL8Gg8x0/kIN1CnclgRKPCfdoEJAMPP3E8DbuHwLkEVyx7lRHE/X?=
 =?us-ascii?Q?kzIkKYGPn3A1b8sJTM8ceQsIQeiPKMMWzKf3cwkGOiUNcOxn1iJ5bOwRznDV?=
 =?us-ascii?Q?20YDG13Nb1D7wK4oXNkY3v76bVXqKXVWyjhxfqs74/cn+L95PP/iRyhCGMl/?=
 =?us-ascii?Q?/DaNQI3W1zWi3p4qRD+blIXeOV9LoiZ0K4yf/TGUCe+GONnMOTbWrUu+jZYE?=
 =?us-ascii?Q?MN+hmjiwO44PbV5Jt1uW5K60QXL7Ob4HDt/BghI+n421XMPIgiann7Di7s8x?=
 =?us-ascii?Q?HmngsKDOkfmJVZ8dLg3G29rsiH8eSkb76lSG2sArv/oUADqp6i+25FBeK71t?=
 =?us-ascii?Q?LnuIssNq01e4bkiK7vyCm+eATSLd+n6q00GRvW5N6nTaQSv/LxJ01LbF4ljH?=
 =?us-ascii?Q?weqSx8MyAn0dINmSH65qOqxeghThADVv5d/GswEvQAskuM8/SV4JkbQg6dtj?=
 =?us-ascii?Q?5ymYZoPTZPULLOebUORZPjhatQ6Q2dh0NCS0EHCOS0yQcEDt2zozkx4LiMDj?=
 =?us-ascii?Q?aAzaZbyz5E0Ibf01Zi26Sbal4qrlStbPBHYUHw8bj0l7kDGO8QSGnw14uGu+?=
 =?us-ascii?Q?xXOVfKajKvN9Ny9I51FEgURIRMg14mrrLOaOlPUN7UdfwfuXVWxrHDhQfOoI?=
 =?us-ascii?Q?GMLY/9fn4Uts0NJPVchcLPd3UykwDjVrC6LW+w15D+UUxc4ZfvGitEW3c0k8?=
 =?us-ascii?Q?hkheUFTzPFeDt9JRvtlzM2qdpyoBqIPtgT9MAThYumRBZh4+aQveFx37Vs9h?=
 =?us-ascii?Q?Js1iQjebbam3iDtOZKs2x4PVRh43SOxgz2+lP8G5GPePYf9ZTNLYq6cuL+M6?=
 =?us-ascii?Q?x7SBkDcZ0wcklonA0NDMhouUismp8xMLM0z4rJl8bmlpg1Az2VTUisK0upH/?=
 =?us-ascii?Q?o50+jLT8+B31ETOAdJYaHYejMe1nDGkcVUitJ7wEHSTbJ006UXAf9EUgSuw1?=
 =?us-ascii?Q?xm2KYKz3XLrkze1X+IVzNHdYuzYnXE7Amhpb7yzjhFt0Yajr22n6JxPaBYYH?=
 =?us-ascii?Q?OI2fIr/KsLApUl22C/3z0LTpNDmACYi+SO1pyfCcrpGGp0Zr6NhpCW9Sdo/x?=
 =?us-ascii?Q?qFm3WzxExji/egklhNHpU8Sf4ZXE2q+ZVudYQl7mrJtYqPYkOUBceepsv4x8?=
 =?us-ascii?Q?NvJmpvjnfklr1G1I0L0tAjlmLo026bC/Qbe5j5RSmMX2VPCA4e5+K4O5SkKg?=
 =?us-ascii?Q?mf/Jm7YqM16YNyi55++f63m4iNW6t9nx/bCHlLOpoGcAowHGoM3Xby/St37C?=
 =?us-ascii?Q?IfZ8vRnSCse8xbXKI+4ILA8y6oH8v0WoiXp+rZDW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1f8011-984b-43af-f413-08db6c55b07b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:29.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfVz3d2cwQSD+9TzvnAKUBc+kYe0Hn7J5lemQMBLxxLS6PVgO5muvJsZxu/TaYxcH3zu3ivodVjiwW50183zRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This accommodates differences in the register layout of EDMA v3 by moving
the clearing of register interrupts into the platform-specific set_irq
function. This should ensure better compatibility with EDMA v3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 503e5ad5a8dd..e67aec3f76b5 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -113,6 +113,8 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 {
 	int ret;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
 	if (fsl_edma->txirq < 0)
 		return fsl_edma->txirq;
@@ -154,6 +156,8 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	int i, ret, irq;
 	int count;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	count = platform_irq_count(pdev);
 	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
 	if (count <= 2) {
@@ -311,7 +315,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1

