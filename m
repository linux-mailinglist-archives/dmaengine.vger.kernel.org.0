Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF0734787
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjFRSLA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFRSK7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:10:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4010DF;
        Sun, 18 Jun 2023 11:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhAvLBidn4XZttG0U1BsHwS4W22OjXhWKKvhvkXm8SIn+6J6AyzRBMG9aq59G6/oxxYAYjuW+jBYeAW1e0wL5UWWUdLkHcEXUWHi9JqhjK+MAPRjZL55YFlqE0y7U5zaZMH8UBPxgVcZisGHMoZ9A/vBi6JkWSJGel/tSsMvQgCjonhy9pinv7F5OEAKAItF38nzwW9C+BHcNAFiR8j162U22JK6FCy0Qs8sGBjBNXR29nId5rNA6+E/2HYJodl5iwS0RPdbE4dV97ELzuPXXCQTapaMfJNWxlvaNUINB4u6mO8jcUBEUYMtIOtnM7eED7KE439Yk7Mpl0lVN4CDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=ay0D4BZB6PxqhU1cIxX9dUnrWO5BzgA9wBRturWpQeYdIrfPRvDrmOxfdFSuvMnLi864dyWUcr19Kp+/3Hpp0qgXPpvdnXyV7Ag274eSn/1VaSfqbQ9HPkeU+Nxn1M2M70Vw3yfJdVOECQSKtQUQReht+LNAYvuV6FeZTMsL9MqAlaEO89jHRwYHMKskCzmJcphTt7+ZGbqbhw77S0AAHTrDgSZ89yM9BOPEpxww8z24IE/hHvXVTPqOFIEM15HwCVjt4fFlMvk3TPh9/N7PGpT1eBQmQC0QsK+U8YU2cYHV0EznXzagA1Nu3WK31GPX1HC7M++8z+JOhI1jGdvVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=prMEqIO6m0wa3rh8Crv3Z5ctdpzY/QElUmMFibIChv0rwzVLPOE7XzvGtsuIiwxS9cXGrrJaDf5y6zOjUNjJ1dPrQN5/37D0D6MWUcDMw7sP1nXCiqcgtZX+P/REngLbLvDrtwtEvyLNRfvacFB7c8GzntOvMxmysDkt0sLaNNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Sun, 18 Jun 2023 14:09:22 -0400
Message-Id: <20230618180925.2350169-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d1eb8f-ca9e-4110-f911-08db70274320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJz/XaybKhrU9/6C7hHqI5v9gaqgAmOt6GlTnsMo5Y5yiulCrN32g6EMdt31X8Ak8dfaIpgwThjFdjgh4611rhbBN/6hVbyE/XDKnALMfrLOkSn05FB517HeRHjQekS5ICVBIKSMXoA07EmaR5YvZcHpSZQZ0UbFEqd11i2/eEf2VgeZeGeKnKot9kLuNy6QYFurUWyA1P0dMKLfA9gCln/4GuUpNTew/e9JH2NEvkZltpxiEUaWK9rXFPkHosQmOYCH0lSPuJ5acnwhx3aJtV9yF06DVT5K21siEUqmYym4hIVuf3Qd9O1DWX+C1DUfGSFG896xQWGHj/h+/erANtivYHG4CBnSoSiyuWrDz60XTupBnc4Uit7+e9KNZsp0hLjuTSOedDPXOADsHQniqYADy8rzF+76qYaqCg2AHGAM0SPHZGb/bt2ZWs1qzKA5ErbOFgpsZbMdup5ifTEYja7lpCoJAHm2tk85U6+BSOXCLLXZz4YCOz5zblHgdxjbUtMUpAl0B73tOOi3aPduwCh+ynThZL3oISJpzuzlrqkSDW061vKN2TteRzcGcF+Iut4DDfLgStKnxv6bUbg7U9dIAzpoAHyzKjQC1s0piDO3QrEd09/k3PdIPku3twLP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckKbKidiS/b9WgjoSayzCOKmJMr18+5an8LkUQhfKGSvC+Eb0ySO6q4w6D3a?=
 =?us-ascii?Q?jk23WuaToV+vMQ7GetCXokbswwbwPQrnd6pT7jwhSdF7ECACNFpA7UamoCXY?=
 =?us-ascii?Q?tXsUCO+PrwEyc3taQgGU+Selgr3ubM9IOzbmN8Rsq/cZrznR7UEH3HXviNwU?=
 =?us-ascii?Q?FRh3LvJ4CGvrc6qQ4V89ef1RFX1qGXWZB/8Bts0Cpo1lmc4JJ0+TkNVyzMIM?=
 =?us-ascii?Q?KNrv11PYc3ys2VO3vWGxD+S3VUfMtxcZFKq/pPhI+Qub+VfNGuZ/aUiQfoXM?=
 =?us-ascii?Q?F3Ifsq9EDRCnaH7koOMCOfoajo/I2CUa/qIxHykcw5Pg2YhHUf8pEjvsF0Kb?=
 =?us-ascii?Q?gl9qdJNYbSK3suPrMSy/7aZf+8/lWa87U3fhkrEVyYc8iHzLlKfIFlYVKSyz?=
 =?us-ascii?Q?I7brphH7nCHLT9Fgr0ubtBeIBY9RqpUqFrKsDM71y1Xkz7wqcyy5bTtdir/M?=
 =?us-ascii?Q?+iRk2aHaxfyW+5w0NkRjpPjGqz8nvCDXfJY46W4uGZWZ6ESSHgwAS+SXyiTf?=
 =?us-ascii?Q?N4ufllTbiL2P0PyCJMkUhq7GvPLm9XrjJ+pMzcSLch+L1t3C9umaMZN0xfTE?=
 =?us-ascii?Q?AEe9Ajk4XOErg3EUfs0cZFrghHEQwlr2TvwSqkBFA4IXm4xAeDr1WfP3932w?=
 =?us-ascii?Q?wjzfQ+vHX349/P0DvjjPDHh8VXL0rnchBMlqCzSIBElglw5CDKjQzTM++L0h?=
 =?us-ascii?Q?PPApjjU7EPWZGie9F5LiSkLJlr1TkiQ1ap6HyfmVNuRgiOmpefHNHbTv2rRI?=
 =?us-ascii?Q?CmwPTHWqDDrar4psumZ+PmJGlV3Ru98zmb2id1Tmr1/IQKSQuLuM1t42t+Rr?=
 =?us-ascii?Q?hgM9Mgs95lWDu5MrsOkfCslf3+PZkj+xQeTfSNUQEbHvKVZ0hQtgqPbQ0nWE?=
 =?us-ascii?Q?t3f/e7HMsxzyBtdCH4fk7wsmTWnpvIofw5EmAXQRf3mS5XnGiMbvptN2LyUn?=
 =?us-ascii?Q?dXY4mjmaT7M9vrYpIVXn+y3lQAREU5ZnlvJdLjXb6F7w6PDf0vddQad/oEAw?=
 =?us-ascii?Q?mV2E3kgeDDJQVb9Yc1vhphadzNKOIa4pbTZC4LmIgR9LnEUAasiFIC6H222f?=
 =?us-ascii?Q?ZtoaVpXqL379b5qEel3PsOjztf+WziVRaMR4/SZnnLjVy9BwHHK8AKRUbGRe?=
 =?us-ascii?Q?Z9cqmi3JZ+MCzW/tT54zRRV4x85MWTwLyy9yB5Va9iMBG0NpIFYIV6m2K83l?=
 =?us-ascii?Q?8Q63OmfzHnAjAL+tvP22/ZtZfmGNchbEEZfbz4uPIXWtsC9lOboRog/avkUy?=
 =?us-ascii?Q?sImwIXD7PVEW6hsS4NnAxfGhVIEhS7Q/f4RAkq4zHDRH0A4FBmyL6dKNRqml?=
 =?us-ascii?Q?5MpoLDPcO9yHt1WpQvIGpe+yLKU3mz9SMmaDWyXDm+2mh6nRBJbVqwvbDCRn?=
 =?us-ascii?Q?JAmidFjXV7ANcMRvNpNUSr4MVo//Y929wRvVnfLT5GZtkfEjuDa3snE1Gb7B?=
 =?us-ascii?Q?98qDwmz3l7DRkCE7hhOVka+EY50q7oLoSRdIG3tezLowr3fYHeJ7ojv/36Fk?=
 =?us-ascii?Q?VasRbxXylmbApE7YkW9u3O6AfuOsQacdjXMRaRIrREp5JA+C0jl0kDmcUA3t?=
 =?us-ascii?Q?9Klg2IxK8V81yBCGYs4bH7YiREJJqmMelOGIrDXe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1eb8f-ca9e-4110-f911-08db70274320
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:13.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0RLTngDnl2kpxclDx/HxZmc7awQ3Yiu4iJySkzvu6FpJGaM24EL37LA241HaxMkkF0W/YYVq3HggloPSsUmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

