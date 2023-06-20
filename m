Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774BA7375BC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjFTUM6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjFTUMu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:12:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F001728;
        Tue, 20 Jun 2023 13:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkSRnZnW14J30Vc3ugyJLPTHqljCce/qfnpJdGLwBoiM109pt2RW9UNNTVAAAP/stQx3cDuYPUgbJ1vhK+hx8K6LXOFcNhm5BsbJRxYc4td8il2cnsVQ0BmWiQ9ulVra5nE/Qi+o7LoezFz7qIUbVY7Bw06NjeQyw6bLlS9VIhhYSLNcGjMb5hek3KrPAVDWXgIQltCbzHc+gSJSbf0rhhIghLw5z8wC1WQZDreeNucPB4AE6XI4vcNMw2+IQ571Tjh7BL+FG9Ev19ltLEASp9Y+xR8x/2u1ffzTHGMV0oou0S/IkQsQAvwmP1WfjFLUCKpw/LJo4Vih1JpKHcQfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=KRelEUIE+PzuzANgVEZUyCW10xJ/SB893ob0Cd9fdLzCT++DQrKXw2zoeV5G6GwoTGNbacmdhuDxK5qI4BUsfv7udnRRjp0KHGE4ra3lonLQWc1JoPlCk7fh+g5tLmausUXPQ+ivHbUIvECPnG1/tvEWdhovipIUv0mSsFqq09+hqoaGqaMpIY9mJjwe6ynELb6i9e0W8hmjjLVkPq2G/b6uey0ivWdJxtyg5fC+F1+ZOPh7Re3lbJ8qw3hPYFIBHVdr54yRZN4OY8mnqnZYf4jnya8qvHXP71HMHeTXHMrFzJcucHnV0/L6W629b6D3j+zioW8hCqq7ilR/FNynfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=gEdhM43XWUua0sHQsgGwua9MakxmThjBZZfgLbJoeqcqEop6TP7p6NwXZKBgDiu92nKRxB8aBFVl1OOtxIUkIn5HO1HTZLh8KZklE4vL/e7hfIjfUF+owiv/wBoepTr6RB9qK1dC2T0muvQkHcV4B2ooTNwgs+Mut5unHZ/gbiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 03/13] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Tue, 20 Jun 2023 16:12:11 -0400
Message-Id: <20230620201221.2580428-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 46027cf8-060f-4c5a-b22a-08db71cab626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gp+ttxQT7vjRgM7LSFlpsxScnooCIra+bYVo9WknjuRoaqS9ujqr6nskwNATjc2ImsZtRb+P96zmf1E/8socbNwhbe+6HtXR+JU/C+d7zjq5FZaSwdzy+eH29fLjEWjpBhvpO+sRxVmKrf+t7TM44vowO2d3mULrWoVEFVf49OycLn7ckFQwtCWkjFwVbplU0EUUnbiyolPSEErWR0BJmZEPvD0UJWcjVuk6elcUsY63IwDSqPA4DctjyfR+azpUEbe629E/n1RraBV3ebG5QvZ4KYtkNy4umVTncSJ3tMrN830cMeYqTLoln7y+SNdTkD3TD3EzF+1ZapGa9lBuDGYA1L0spi21pnfraWP+CI+0REhw+MZZb4QO6iWpxw7Yzq36A0IcRrpaQABuNBcbnLt8RiQ+U5e8v8O7Zr2Wwd5n/AmLzq0vTtUALVsTX8ZoqDinXx0NG1bx0NlvN2shE0re3CWNT3+WNA5hoPy2QHzqYFYibZEOfH4RtKoK4u57Ts5+ysp6Mc52yN3/pLTeI5VJe5OZhEo+3Sf5nHs4k9/JBBy6mgFiMN5xadWwYE9Q1mKnH7zlTv88wPP4/6mf/RHmA7jDOXGkpx/tY9Zst9hO7O9qEAfj7vp8oF3xoVw5i4SI6INFeIWtPoTYK+2VqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6boJ1Z38BV27ugACHumHqICt7/Ah43SJogu+iGbvrc/blcl4PSO8kpZyG8Xd?=
 =?us-ascii?Q?qhL3pR1RmMVMiBA4jy+3CLrp1Z81wVXHOplmqdfYN4fH6UgaTdxcFH8Z44df?=
 =?us-ascii?Q?ieNlQvpBWXLmIHBQk2Vj8MA3ThnAhPdYlPtCI1h5UTjEE70TYiYS+xFRS63q?=
 =?us-ascii?Q?hmpCVZcjjtSX+mmxW6RilQ+m6jgU+oIzeCVh6V/JCxsIQZ0DilMpzTXleijc?=
 =?us-ascii?Q?NG55KvrevECHoIoVwjwvqAXcB29pIyhv+8kq5LqTsCdTqIN1Zni3X6qXYQ/f?=
 =?us-ascii?Q?K7ReAt2luXRrCPIUJXredN9Xak4nGKiXlIuZ8SHQ31xjpxZfqEuWpsacU1QJ?=
 =?us-ascii?Q?Bi3auD+vKPr/pEbaWAwyM8aeGUyGZnojy0akC2YtpuauAAec7rj9dV5TmjYl?=
 =?us-ascii?Q?phgD2yLS1lb5cCJoJVnf9oPD0WiKtPxwsAJPJwFSRP6HlonIeDLELbYiw5w2?=
 =?us-ascii?Q?l0EEzLhQGcIQSm4qeCzIAgz1F9SHp3DiGVmm0KRpMFYv+aD/0hVI/+kk2Ykm?=
 =?us-ascii?Q?KzID67XNe+pUp9MNe8f2MTLSkOv36xPhbqqfpSvN2DgWXl9s7vDz+J05rUWd?=
 =?us-ascii?Q?YviouxnP1cv8KfOiQ11BvM+tn/FgQsk+Sg12v4AHeZ9in2DflC7Gg0/6b/TB?=
 =?us-ascii?Q?ye5OU1wwHaIb38812+J9gMeYSzdKrf5OUd4TR5UdPxN2eyIXGE+2E8mgrEd0?=
 =?us-ascii?Q?56rJU1HW9mouj2toP6fDxR/xbJZdri9tvJDU/eQeI7lPwbp7y8N1mEQO2gX8?=
 =?us-ascii?Q?wFVP64pzQggJYF75Rn4eKOO/z9HL/dxW1ZB61OBzrkUi/eZJ7012baamW0SE?=
 =?us-ascii?Q?V57iZ9Yv+xeORVD7l6xmvBwh5cR0e2TRwKkS0YGIM6Aayamtrn3M2FoypslY?=
 =?us-ascii?Q?B85s/+t3QE47f1fG3GBktp9la6KE98KAIOWLuE16+N1B5sMlNb5IPz4yyKWI?=
 =?us-ascii?Q?/o4qxHkyzc+M439Q4IxbFWVqCQpzCNW0HGXs+4TtnkF/hYhRonMzdRglHpcU?=
 =?us-ascii?Q?VtAacSymg6EqQkM6jP9gJVnSRYFb9kXmW7PJ+LfjJk4Vedma5hrFrIZ4uw6X?=
 =?us-ascii?Q?UbhbbIr1Z8CMwAkOwzSkN8+tNnfr9w3HbzwPyr8uhpSl77IsA86QjrwHpnV9?=
 =?us-ascii?Q?yjXenzZavF2JVNW+Mc5wDCPQxRPVRuqfjzL2ddSE6HksBs2lrUTQdl4koSHS?=
 =?us-ascii?Q?o+BTV0F4MjAo5IdqxHlijlheO7x/WLBxNcHNGeAziWnBW1VrGoBSUBykgJ0W?=
 =?us-ascii?Q?aultUpxH0/xSLw7seHyxm6PAAXja5/WcSCks46bvYoMxekuXg3R+cWuXN0fF?=
 =?us-ascii?Q?LT8KeL4Q0i6K5x4VrBF5AycT0JMRQJlbK3SXXJQGjlO7OJs0Hwom+Z0Oy3rg?=
 =?us-ascii?Q?UTu3U6CZUylHmKHDVw+gUkFseL+o/AQFjYXTF53uJ8cixnaceIHNUVEE42LO?=
 =?us-ascii?Q?9AAzQgA0/89aB+iDoNiM75BDtlNadd4FQjHGcrQEBntuIR6bk7YxO7ieTBzp?=
 =?us-ascii?Q?lTX/Cpimx9olW0oviIC95DE1eAV15EEr+ig4TMA7HTDlRIBmMNUpOd9Hw3Qp?=
 =?us-ascii?Q?p9Ydupb0WQpFxmxwiuciDd+Sg4vLVE2agHly60w5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46027cf8-060f-4c5a-b22a-08db71cab626
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:45.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaVPJbTCu0FXqJZoPz106TEX/YQqC2da9rKSU6s7gYGj+BuifqzgUIiGEBUdVr75nTs47l73EnC36gHmPcFeVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the probe function, devm_request_irq is now being used to automatically
manage IRQ. It eliminates the need for manual IRQ freeing during removal.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e40769666e39..16305bb9a2ef 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -216,17 +216,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void fsl_edma_irq_exit(
-		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
-{
-	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
-	}
-}
-
 static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 {
 	int i;
@@ -427,7 +416,6 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
-	fsl_edma_irq_exit(pdev, fsl_edma);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-- 
2.34.1

