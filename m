Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14F72D09D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjFLUfT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbjFLUfH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:35:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD8510C9;
        Mon, 12 Jun 2023 13:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/JBDNY30+OG0l3l7ew7FXt5RtxswKu+0d39h+2kmClr6fnm6uKOelJRKPhx9BQg3AVUKojsleosFLNRMiraGT1RK0/3sS4YxvnjtNz8YGu75uZucbwvsYtiAFyIjyJxFnOBXe9cdJPS4fN941YpFxhFg1PfUWXgjVLTQxV0qLGpQfyUr0rh5/jbcOXFvc9emU6PcE8P3z7CgsWCLJumFD4cOSbSZ2mMlmNEHfiUxGBxYUQjSqML+UxlrgAajRpnbBSWiNaZQCV0eUNXndVve8Gxov4tBV8dILOZy1z6XRwgLjnSs9J/J2lT6h7pME1D9fvRcmODml+aU64bZ8Q4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=VJVDsl/Uhh1LwIwsCChDdi5tzq0WuUeYLHinauuCodhtMsKqAe4C8sejPXw1OLJ3jjVxs4jRSjpglxAQybbHQWv6aBDxW/i0v4TBS4HYnA9fWCmDxhVFgKxbRQG9/M2GXOx+c2LCxE8byfrIIWaOu+QKB8BPKpNZo2vK04zzPBvqnqORWFJmZTC27+cf4Of1jmKVwTXph6DMCT/XP9uisD3IU5YSbj5IrInnSmWbn4bi0SSwf0McmS9Sw3+wUHaBnsrzX0ur1bEefHpvkCCOGU1KhsMq9NkUJRK4yO8V8pjXlOi5rqcWFQKjEAewflP6iQI6xiWqYRfKlCfzL2ZPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=bFMcNWxpZ/cfGS2gndTSFsa3gbQk8jY52JlwTxACoLQGYGEs2+WXdHRpbK18hHblreg4AIOWDrIiX3SFSGMIgsy3+2Yh1NgYBTAkHn7Zhk/UrFV5QruelBkOIm4rRdlBjwVS+EDlaatFlGT1YwrN3lYwWtlpWhMpoFVkYCIUjwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:35:04 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:35:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Mon, 12 Jun 2023 16:34:15 -0400
Message-Id: <20230612203418.2017769-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 847aaf31-04b2-456b-0b31-08db6b8480c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6XoRYen4L/uga5Kbut+0kWn59VekKsbChklZ+dqV2BVTvAKi2N3FOe0fEM2211thR2F7d3dE/ZvpXvP7imVzuHTlvHWw9DRvgIRZPlc7lPOYh4l8519pSnao9jIS0+uHuOU+u/4Ff4wgj+ymD2nnBpyYMouIK0dUs7FN5ckrPNJpNc0/QU947sHuWn0NEBbfEafQlv0TdMRfD2SGV+E5iPEDY6QWh4v7OwsrcUMeiSorstqlwsTlqasTeaRLGJCmG6g4aAzUOLk1edZDtiT5lMCrOkwF8ElzoNK4mpqODoUygjRiKdc9YU4Xwh24XNsmgUERaVn83i6wxEQc/RzEGxvTGdyYUn5HMAnPvKIyB11G+//s7OPCI5lvMboiUpbHcAyzwcuhrx+8UWRs7il6E0sBxFa0Xusbt4jvY9P4imDfs6M+eOylwmbpyOGrNq3pDYp1PBC4SdyBFhNzGRVOhzL8UzDKrgA0e25ir+0fTfbqcgrjxF6fR61cbjGyGYn8NkeBYQCFMTAy7GlrAV8oCy2syv5oc+ejQnA1BU2JKNu84mVl7H1oHV3bY8YGsqwddiYPr6dGdf/Wvn1tYp43Ho+RK3YI85piJzbymFk8loK5jKbYvcDF041XqQt/HzDwAdo0t/OyUkqqlda46K1AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2FzYFtSwUR9f51MDMYu4RxTRM+pX3TZLjya3JZCeZQk0gwKfoI5pQZUJUxb?=
 =?us-ascii?Q?yRYn2ApmEGontL4FLA7xM18ioJL7wZ5iUNJGnXYRz/XFKDfexUIygCWVTaEQ?=
 =?us-ascii?Q?fBntlFqvhBznGcFK404Q+gpmFNRz3K5Jp8jXodDo79zxAPQ73acLTtmmAMSB?=
 =?us-ascii?Q?t5Ux6JCwYmtC1bswH6ZRLsfnu9v6/mey3e1mWP3OyRINtIAjTxM3u0+UKZrT?=
 =?us-ascii?Q?KZlBp489RnFb/qFsUMmoT6Tm1xIyafLYxtW7RerRh8G9UMfk5CSlgSBvuPu3?=
 =?us-ascii?Q?zb2/EjPRblXy83eXx3oI5DLKu2GNUe3XDSZl28teNHTpx2Ce+LTqsnyw0c4k?=
 =?us-ascii?Q?VEIE7CEbZ58F5bWEMvKQwoXULC+dEEbvy+G9++wZ7lh8h9qFTduIf88mwJ2W?=
 =?us-ascii?Q?xQCWjktTBiJvhEhQoqU5+hKwSLqn21nsJZNxfBQ9n9h/SdxSMwCaZXFbPrGc?=
 =?us-ascii?Q?tPgZ4RLN/o0ooz2PSOjinnGWLwedOrYrn2pZyrvVdajPIWUuLO/3uWJQKc+E?=
 =?us-ascii?Q?3lqAQ93hWpBvYsFpvHuuaheeJcw74DLJusKlodOeb82WuqzBdKe4ZC4k4+jb?=
 =?us-ascii?Q?qAtDYeXBjKOnWses1xTyMWb4nN6EkXpkjyMBnRHGaBOdFhWe+AdD5Va8dc/E?=
 =?us-ascii?Q?K+fVh2mg0TWP6COHA3BvLjGCwLUwNMGkw1GB8D/zLf7B1nme23kTG9X6jMkA?=
 =?us-ascii?Q?iBEiXn1Q3Yx00uzxIJRFoothGTRWELWaPfHjEhfpDe+lAFI+++TSmvbFgjNK?=
 =?us-ascii?Q?wxGa0tmoXFjIPoesg7+czZwX49q915PKzjhgQNhd39tWOXg5AUg9twpdEJDz?=
 =?us-ascii?Q?g63ZK1DgeAz9lCd3wgsQJGVCT5oe1SN9BnwgOiOLBlmVFx2sjTzbj5OFOTZK?=
 =?us-ascii?Q?/MV7SHQ1F6/osKj4q30BdTkkNuq8lRWWkRnxuk8UVma9B5Yo6alNjzhVuw/l?=
 =?us-ascii?Q?DqPuJORpafnGDNV7Wh3GHk2ZQPBrk8Hj8POqXl98eYNMUyiWhg1oCZmnms36?=
 =?us-ascii?Q?LLfXAnUHTzLtBr7kdeA459xdUWD5lMzVo9OwoEbuIv0l7L6ZHXsccNkIoDb+?=
 =?us-ascii?Q?MA0RyORR/jWieqp5r1iDcx1d93jKF1xAUbTBKJRiXEi1o/RwneInDUfemBQE?=
 =?us-ascii?Q?p4mw1D3vHvfHmUvf40zET9RRRmP5kkeHAequLOvJky3MX2NZuI3VWOxTiwd6?=
 =?us-ascii?Q?pmauzBsZZzy5B+DGnsY1ayHkX8RnhgII8+OFeMhCut16StJVwlZwKcuhPFuB?=
 =?us-ascii?Q?UIaMO2NdCNe7BrlyMwOef23roaqISVjxPZEAFlmqhlMqua4WbE1r7DJU8bY6?=
 =?us-ascii?Q?DMxWKlSEc0uG89A1zd5+oRNlYiou4RZTkQ6YqGskZ7UiZ6SVar7Gbzndlfnb?=
 =?us-ascii?Q?AopInRHvIesZPLdhraez76aaDEruuW2VzN8txP/ET/5+0arl1IgbV0sMwhsU?=
 =?us-ascii?Q?BRUtMGQIh/uq7w3OSMoXquSwFAQGflM2vGuFJsdxu71je3hr0Q/js9f55F3N?=
 =?us-ascii?Q?MKd7cAsoUSaY6tYZU0S+d8lwaKTCPpOPz7J7qTRzqJwnUQkQUPH5UJXihAQW?=
 =?us-ascii?Q?shKFOYW/zFMEW6Y4JWszjuOBHVd7ZkgkoCKevs9h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847aaf31-04b2-456b-0b31-08db6b8480c7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:35:04.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksNltWXTuoeicG+6yRaJy29lpDiOzysW+W6Bim83iL9mHM8oN13x5HI8pW9fHHzCb/RYaZ+rC7b4dle/7DT6Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Relocated the setup of chan_name from setup_irq() to fsl_chan init. This
change anticipates its future use in various locations.

For increased safety, sprintf has been replaced with snprintf. In addition,
The size of the fsl_chan->name[] array was expanded from 16 to 32.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 drivers/dma/fsl-edma-main.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 521b79fc3828..316df42ae5cb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -116,7 +116,7 @@ struct fsl_edma_chan {
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
-	char				chan_name[16];
+	char				chan_name[32];
 };
 
 struct fsl_edma_desc {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e67aec3f76b5..e2fbfaf9155d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -175,8 +175,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 		if (irq < 0)
 			return -ENXIO;
 
-		sprintf(fsl_edma->chans[i].chan_name, "eDMA2-CH%02d", i);
-
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1)
 			ret = devm_request_irq(&pdev->dev, irq,
@@ -303,6 +301,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
+		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
+							   dev_name(&pdev->dev), i);
+
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->slave_id = 0;
-- 
2.34.1

