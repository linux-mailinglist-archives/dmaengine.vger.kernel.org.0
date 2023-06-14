Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6573086D
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjFNTgg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbjFNTg3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049BD2;
        Wed, 14 Jun 2023 12:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQK/gbXWcvEGH5YTD1na40aQ7dXIpVPC0lVmHJkHPf0prevwW3ZQMX311Mq4mUtba7V6lKuPZIa5toJcwgApfZC0I+38xy8xrZxylVPk5bUG+qd2uc0ygrDL4bI45IuNPKV8hVf0W4Ijni4ZihvaoN5T/sLikQnr3v5ORXsM0vjfhRy8l2JPoL2/jSbAQcudJZLT+nKB4SrvcDq+E6D9fHjryuT9BlaLeTA6f9ZJxot+8pnhqnIS4PLNpgXzUuB+rTsbmt9l+J6RZ2IQZhQoOrVGjoaxJCLGLTfXYqyP4Psr8EoAvWnb+XcGIm0H5dzGzNWRlzHdr9mEDiHD/skbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=dT4RhVtz8QBVpgJQvFtrEyA5p0y9FKd0ufmpVk4mg7dHTvMZmWMg/DQbfkBgbdMx8PTxontsgEg4C7kxd73AjUBWx5+/QdEArM3vhf0jydw6uPCYmXKJg8WtXPF+KRRrvsiza4dylZYcodDAO9L5SPomggPjPTI1BAKLU9sZv+GQJtJLWNCX1Cz05w/7jBrtOxF8VioVoNms3sDGAFwbdKbNo3+8qGOYMxS6V/laRYBwXcDq9n7tfMcw0rWRljkVp0VqyIFG4TbQbdhz1qgRX4W/8e16YMPumUlojpm+7cv8pwZc0flu11lk70hn8py1Ai2oenD3J4VD5wT85oVgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=knT1BvxJOvd+HNQHU6K2aR6ni2cifod0V7sRS6hcGYCjn4W1DHnnqlCtXANFcF69u5SeZcOgZGu0SMWrJAJ6cBMMbegk0Hpyldx+3kpXENMpkuW3u9DXw/QeFsPRmOhsWppSrPiYbvEJ9/ayCsacj88dPU8I9JmHZl6QcWKZxwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:25 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:25 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Wed, 14 Jun 2023 15:35:41 -0400
Message-Id: <20230614193544.2114603-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6ae214-ea6c-4324-4020-08db6d0ea3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: An1sLp/64vx/+WJdz9eGXKjAIq/WjgRUs2cM0yhM5nUKT6dqpfrqPbIaEpC+mt+lxw2C8s82x0tzzX5XiY04c7tfY5K/Vx7pwS5cr/eTVk9XCj8kIauJw08Vnk8pmGFqUj8MHBseC+O2VBnhc8h4OLfXzd1TlmfFEuRtACXAiGpU/k6wgjbgPuq3Yo55srFY3clHEGzeIdti7GRH8/xg4xTc87tz9fOQhfm4wX8T4HGY/oTeFWSCogM096SWnQQyCw+wHrdpFOkayFjXchqjRFoxgWLenMvlaVrkkq1skDNHMUyUfMmEwomrHoppaZU9xFCZYv15aloAfva1GeLJI/uYIBHLzma8J11weDxC7lCZ03pmZsTvUP20/tulfIB3n5irRzSDwSIpFtkUwi7ycMKEAhvLmFCtFMCW45CSNfnQgHbMq276KwZnvzOH0oGZbpNbZIYCBcicSbBQeqgxMIGIsyq55AazX+m6fd06sWu2rnxB1U8Cbq8CAzUYOFxbdLzg8Ky6mA0QK2iFbAOa7RKOJ0t7MD50mKJZ0XnIHXgJ3jTSNQPk+MaICAvR2VcNPna7tkKO/dv10cCblLwMt5ffFRHrwobd651fS4JVCZalMd6rmmvHi+EaITZdNkVE/zb9MZW+IKg/4+cFi989KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51mJV+8p02sBVYavpgiVMZsnN2Y5KEEJRT0+mcqjZZ7uzXlkFVP/r6E2Nv/Y?=
 =?us-ascii?Q?90Qt5LWoi8fbQluXkMEbgwvV43SbDr8W+sgSuzDWUCmGy9Rfzcb9TYTnUGSC?=
 =?us-ascii?Q?/m69DOJpC2brySDV9jB0CDKZ7A/RME1uA3+botoIVMhGzUA6DFew6yDAZFY3?=
 =?us-ascii?Q?vsUr/kEcs2mnfCEHarn5t1nADJ5unI5pFptrDMVQAEys3TmZsOKdt9n9418m?=
 =?us-ascii?Q?9xocayUHsND/aPygG4LcvhLlKitEyhXRwcdVdjhyPs9olfhvNmXK5HmFemG4?=
 =?us-ascii?Q?jW5GAwIH+Xyhky8zYZR3KbGPxfpxhRKEwoyIY48W7eyZk0RC9VkoQSsfo8lA?=
 =?us-ascii?Q?ckJna3nnORNKrF/osicGbw5+0hUrT8LFAvIJ6DiRtwX+qHNuhBMSoAQgVjcj?=
 =?us-ascii?Q?1C7IFIczTjRoOgNMxjNxzgexUJkvNsgYeLpUwN+FCK+t/vSZaxI7g23khsWX?=
 =?us-ascii?Q?8ovBPxD5rHUnAAYio1RN9+GBtFHOryBvzjpFLHid5sMRbPUCHGBUqkIWLQwj?=
 =?us-ascii?Q?JkN0inXj/eeDoqkMqvFDluBbLOvtv48uT0cVROWEiSsRqhR55d9SvfEd3yXg?=
 =?us-ascii?Q?QGxcqAPChGaAqlJ3k/K5o5n2yfOnkBqiM6HvJphTUKIcfA9xo8wV2a/LfGXs?=
 =?us-ascii?Q?4W4MYiuwMEmeIAozZ+qSYi6B9FQtBzmnmLOLDHulC9mOldFoQ8iVTUze4xuB?=
 =?us-ascii?Q?REx4mrIlYXSNbPOsFF76q+mf7UiAlCEs16aF07nMEjbmk7w5D+YdfYOtrBXB?=
 =?us-ascii?Q?/ls/w7gesxqG//WKwINozBDWgdDNpOjP/Dyz5eL8phCLf+IRsIhsE8fTkC97?=
 =?us-ascii?Q?BBsAXFTBkuOj0c2ChvgqoJwXAZIcSj3CLBHq43GyazFmo4cHNCrLB31oduwd?=
 =?us-ascii?Q?0LZSr18AGqNpu8Cl/sIjYv6ZvwRbIpw5klbSqyvS0odjMG+AAeLWy6BkL4La?=
 =?us-ascii?Q?DEBpmaOaLr+TCunqVOmSEKvC3uL87FJIter8nNRFbsrUoAB+NN76fyaPkzee?=
 =?us-ascii?Q?YjF1uy6wcgpwuXHwQwuysymcg5GlbsFt2/YOeAz3O9XhSYppbmxCywB3v6Bv?=
 =?us-ascii?Q?kTjZ38z2ZTyX88iDIXrMxRYVffVfSEmcCPuYXrPOSqtsRamu1Plfwjycm49v?=
 =?us-ascii?Q?UlrsQMW8wwA/Uf9swwlbHCmcI96A7Z/vSn13Z5AHAyCMc4SEC0bHn5B0QEde?=
 =?us-ascii?Q?7fIAqTYrQHfs6NDJurtsNKhdK2hdr0sm2vtvzlYYZdiarqZl5OXGbf9vsVTC?=
 =?us-ascii?Q?v6LorS8wV8WQavRxrs6aLXKTZUB918c6CxsQvpNGOhIArsNBe1nO2/ZiN1Ys?=
 =?us-ascii?Q?wtg++bmLFO0JD5nfFUEejcgZPmE25TgJZYL0y8GtLXOeI4MbsI+5eaaG0mbg?=
 =?us-ascii?Q?kQN0shUvN+dfcILJb9ST1vMHjW2igwdzudWWPW1VvFjlh4/9vq6F8z7DhcsV?=
 =?us-ascii?Q?pGwatDvGhuX8BMldvsCvYodoXoN1FMWrpDG9yoCWuv7gtGlLzm087yqjhIJV?=
 =?us-ascii?Q?WhCJm+lXPYUfY3Ljbw95KaW6ybKGgfZfiFcO9NfqTSUTT//LhzGb1mlz0N9i?=
 =?us-ascii?Q?3Zb7Y3chkgpojX7Kbec=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6ae214-ea6c-4324-4020-08db6d0ea3f1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:25.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69VbtJrKtKWyy61Fl6V0o6GjwyN1xEbspvz81caOFseduSm3KWfWD7gMrYRKs5DC1VDOyu46PG+VmFxHrUvt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

