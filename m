Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7B785F92
	for <lists+dmaengine@lfdr.de>; Wed, 23 Aug 2023 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbjHWS1G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjHWS1F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 14:27:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA40E7F;
        Wed, 23 Aug 2023 11:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCavMQyahhzujB3by+/IDo7rzsqeuxcC2cADEez8zGV8CpxWpjb2olO+hn8CEPKb17v2jjqxgY1ZguVe9rirxA4DQl+HxzmPoLZRAtQELZ3O9/OavTdOVuXbH4+pNwXcrcC+HhdcjCPSc1MH/vhj/FgqBoYELlvnj2BvqpKZ65jV+RHeLy2M751vuIE0zsSJJTpzwMk2dn4yEm4cbM1UU9ghoLor4Y1jFfSHuhUppVtkT9ZaTdxgOsVIphZ2txXYhpjJ4Q1SKU4IijJjaVHfBT4Ph3uAz4bIr/KQL64BEloSIvpyBa5diTRpfdXZWcx3SK/4MtkriZ1GEuFD/RfhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+HhOaFE0Lu7eQOYxoTMn672CLEoIm2Vol59QiXEVP8=;
 b=n2a6FSqXxICR78mV8zU+rg1FqDJ0Mm8QoSm+llVXzLbxlh9sr0TJDbcRqRr9UuRt+cra007xknm6qT6KzBhT2DNmzGBiG3vZ9NlW5cJhystFyIaLqXamSHW1srmtyCxjxfd5Rs+UuUqQpbBveBqS99e66i4zF9JFSECb8tF8TPE7FCysVIRZlqglKohWD3QY1MCTUTVisTGbvAELOLOAcFs1nxxSpHFxb+HzPFhcgnv/FFgmsmX5rU59MnrvGDD/tiroX5369OnXTAufTMpNLtx4dYgtlsaOGSD9CCW7w3sa8wyL4TbEOAO4JZhLRe7FiFU/alhoviiGZFTMRsS9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+HhOaFE0Lu7eQOYxoTMn672CLEoIm2Vol59QiXEVP8=;
 b=d/6hijS2KDBxzkGyhf9vDtxbLUqspX7gCnkh/g9qqYftKUTbdQ4gmrGgY6dbHq1T9lq4Gh2kjsOirKO8R/pD5c3Ky+xjfRKGfSMJh7nQIb+n7bxMNnSZ2hp0sqjoxGmz6qFxt8DPZcbS211DszRe8o4FY1KI5P0u88q0IIXKLsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9393.eurprd04.prod.outlook.com (2603:10a6:10:358::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 18:26:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:26:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        frank.li@nxp.com, imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH 1/1] dmaengine: fsl-edma: fix edma4 channel enable failure on second attempt
Date:   Wed, 23 Aug 2023 14:26:35 -0400
Message-Id: <20230823182635.2618118-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed612b-fd15-4d60-e86b-08dba4068940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXnVqifhOV5o3IV29ghIEfnC8PjVzIBbO0NE5aAA0FalXW15flLuhXAuRH1PWEN452n/eoui5SZ4YdbbYg/uV8w1Gzx/CTmwcOtI+5qegFlAWIP84ZOH4G72+I2vrUzQGLE2tHY+HJ4T2dYIaaRPzE+dZQhe95knFdvjrRDQkSlrITKkzDFunPkEOW6sHZBlvd8HuoLcKkH9KXIE3uLA0P3O7K2m91NMKXZT7gxG4T4DUSEs/Ee+MkkYJSV08fV8zOoHiRZEUD8aWeN3g0B4BEH2P2YnltM2DkFAOYYuZXI0QSO439fS59vZyQOgJ146dukJaD0Yo36rXp2po8pWtprqCIyfpCh8No2qlcXwVlGngjRWYiqm9Wd+t6AI/FRtcFui2uZBtix/bcfT4C2sWpVkVlB4NCFchn2FFv+nz48D27+fl/4SW8kWlEI4+3narTZ4zus8zmJCvoYztJtEferIKS7AEex9TwZ1un5IJLH3yYIsGAd6Xsh5ljk1TZ3bp66amONUHhhJc+8V/rqi2cCOe1KTHyPwLSop7d6rNYKIPHdhe29XQkMgZf5JGN6r+4T/WiPZ9MG7z/jHE0OPuJdR+6dALOxl183HphqzUd1UNkfHmfc4JZDyAk34WU2G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(36756003)(6486002)(6506007)(66476007)(66556008)(316002)(6916009)(66946007)(6666004)(52116002)(41300700001)(6512007)(38100700002)(8676002)(38350700002)(4326008)(8936002)(5660300002)(1076003)(26005)(2616005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfjwH5f/VuR9K5GsaHPtNLNXRopqxiu8Nwlt9WmOQdAHdzcII5wCAmoFjN3F?=
 =?us-ascii?Q?nyBQegHuVT+byJNx12JoA0J1eu4XMgxrzgwUSrbA8p6wSZQyBh80gId+smCZ?=
 =?us-ascii?Q?nL3S5gUkHmWNkj3v5BsAbta3S//Rla1U0jzeiv+eNb1+Pictjl+B4ad0xJV9?=
 =?us-ascii?Q?1l1j9yU63QPhL0KB42lzJPpQiPIOekt3I2rCayl3Db6It+9iDQ0CxCIWZy7T?=
 =?us-ascii?Q?iTp48T8L0SBSP64hNdBnbmrUR04zv0dJ4IMtkRPjeUOTZBAHzpuovpD5tp/4?=
 =?us-ascii?Q?o8YTMI2bl6pebk3K6tNaWF3V8O6WJTN6AP7GO7NEyHfuWTzQPYiu+eWutIL0?=
 =?us-ascii?Q?H+65vrx1fwF7kbmtcUwlPQbQSpuWP5ZxQptRsIoWsOBbP3qQcCbs3ZSgXjTQ?=
 =?us-ascii?Q?5VuhXPsvdKJbvD0zDM/2kmIwDW4On+k+UZIBqQ93NWpJhTeaLLU6TV3TEd9X?=
 =?us-ascii?Q?vCkOQ4LV3HsJEnrdb3TNMPemLyNpYQQkwvZE2fEQk8r7s+aYvdfAhD8wxNs1?=
 =?us-ascii?Q?+Ry8xaYzi6jiLc8dK1FQiQP785WvJi7PljD9AfU/aduD5JKnCC3s9zNT7xkg?=
 =?us-ascii?Q?Bq7I/9VIW9USNj+x/SYfLBygolzBt/D934o55WjYt2yyzRxrSpUwRZndsjUW?=
 =?us-ascii?Q?E7jYEhpPMWhqC0SDV4OT1CtGp/2/ttNuxmwJYjdi6Jj9v8V+FgFOoEv61NYe?=
 =?us-ascii?Q?F0vWbmZCResknrE0Vh2YEvjyHnOZc/sn1Ed3xAep2h0D58fNK1M4qqaRd39B?=
 =?us-ascii?Q?T8+28B13PxWUko4oXONCEx36RQQ4vcCqWfE6XaVXDijR/uxEGkEbot6tZmPf?=
 =?us-ascii?Q?24cFKBQTJ9q0dPx9Jll8Paud2avHazPJTKgUTpMtVKR8eh4O5BXbqZqjIKrB?=
 =?us-ascii?Q?QKXKlhWDm+FPZdr5E9YQh+0lwNHaHfOXfYDshqHWbPiOSqfTKgVyzzaR7H0R?=
 =?us-ascii?Q?CRL38iAnIfDqPZ2fcXwjNQXJKShBPw3WRHd8+qE38Iim+5DauaFysdtqPCln?=
 =?us-ascii?Q?F45CciYlc7u2mFDt3h+6MiOOO0BkurTXaa6VxszyPIItv3nh0jgXLqhNyzer?=
 =?us-ascii?Q?8r/x0VMSQEkbiiy0wZOvCph0TN6K0x2G852Y8+4dfGBtS6orRK8+Xc8EDrn5?=
 =?us-ascii?Q?wsY5GP/fLkurEeAyXxUwKs4qFBB+Mv69zAr9z9Ji5d2FNOat/T4AbV1d3vj4?=
 =?us-ascii?Q?ZXuLt20Z0e2zTe8hhlff0lt7kkLiUTKFRGuRpP71Pi7qHyA0Pwj6OrxXhUtw?=
 =?us-ascii?Q?awf8rLTu+l4sRLMDYyAEUhwhloeHb8Gw24dDwY5qCsyHDiN0+GYYfL5dgSwk?=
 =?us-ascii?Q?1HeQa/bO91yPgQfaQJdC80KNHJiM+/YsHVzy4DBQ3ZbYx8smRVEtmyniFAlk?=
 =?us-ascii?Q?SAWldLkH6IVP3PxmNep3n9U72DeFD5jrKoTowwBdtJYLXSFrXnMSEjq4mMSA?=
 =?us-ascii?Q?hWAAEsYnccQbKn0Ax8UT4qPUgMw8qr8BGeNIGbQADyxrmvd8BEdfK2kxFceh?=
 =?us-ascii?Q?s3stRbuU63w8CAr08DFXHcHU811EUI1sEEjk7uuyVPpoq+t3EUxGik6mIB2v?=
 =?us-ascii?Q?u14vBOTV5ztq2kN5Kp0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed612b-fd15-4d60-e86b-08dba4068940
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:26:58.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOagCePGQEjiv2Vj2r7juST39vuGKXynXmCYb2qDAAi9VLdUUPeOLE2t6PBy+SyGFUjOwtnKWbj4pUrt5/W8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When attempting to start DMA for the second time using
fsl_edma3_enable_request(), channel never start.

CHn_MUX must have a unique value when selecting a peripheral slot in the
channel mux configuration. The only value that may overlap is source 0.
If there is an attempt to write a mux configuration value that is already
consumed by another channel, a mux configuration of 0 (SRC = 0) will be
written.

Check CHn_MUX before writing in fsl_edma3_enable_request().

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a0f5741abcc4..edb92fa93315 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -92,8 +92,14 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 
 	edma_writel_chreg(fsl_chan, val, ch_sbr);
 
-	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
-		edma_writel_chreg(fsl_chan, fsl_chan->srcid, ch_mux);
+	if (flags & FSL_EDMA_DRV_HAS_CHMUX) {
+		/*
+		 * ch_mux: With the exception of 0, attempts to write a value
+		 * already in use will be forced to 0.
+		 */
+		if (!edma_readl_chreg(fsl_chan, ch_mux))
+			edma_writel_chreg(fsl_chan, fsl_chan->srcid, ch_mux);
+	}
 
 	val = edma_readl_chreg(fsl_chan, ch_csr);
 	val |= EDMA_V3_CH_CSR_ERQ;
-- 
2.34.1

