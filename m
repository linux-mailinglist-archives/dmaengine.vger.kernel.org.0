Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EC072EE09
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFMVdg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjFMVdf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:33:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836CC1FD9;
        Tue, 13 Jun 2023 14:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P29evHS2fZhWv0R20yc2bFXsIykdTi/EXgS2Jq7aDGQPVMRQ65bLmyE0xGTaCq/jWRY4+RwlTHvMEfou4n9hdEVWTmVRcx1pN3/vJOZ7O3oVlNQKoVT4wHJnil5UF1kt+wnJJWevA3lzq/6R1uAYstNokMJewz8/+SMU00gfolPDZbR8H5tEOsfMqbtATWwMqOvtZ4vpCB85aAbhBKZQl5xQMWGH0GIVowgfIAyM7clhQXGTZUB/z0SlfnsHiLk685pFhhJQRHH10pPmUdB9Eh6zRc+dYwl3AUJ7mWIjW0Uep7BQapZOtIvwPmcjXzDMrf0yfazkOgGABskhbuJL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=n8xTAIYVl4CDDLiUyqT6TVYHKiJ58MFVVLZ4wdbR04bB3itJAgnlrg3WFiZjNooq17Htpp4fFLPLtyCeJ956hwtufb9HcKe/e88BdLOwIPdqZJ3/x1SF5y+AXMSwiNSrJ07TOLopYquV/uWtBLxElzyUyJ/ahd49GKL45P7Dlf4CgsKlbqjfT/k/235NCz2132QtnIBF0eCko+BTxXttA1lJ7TWar8m7Ju98UpK4lcqz0aqNX6uswzSly0dI6lZaQ/QKaaSEaO3wQ+6aVnZjUc0LLEKAKy5xlOA2FVAr3zY4fUykrYiBYMlzOnWuSQ/e9346NYPx7nOT0c7d0TK5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=betZ3IhB4+79lTSoLTIPdrkd0D0FkojxEn9Gs1i/s4kDrRoEBF3p/AQsvUW0J1ntE4EDi1Qa3KtLKHt2vYO9v9ei3dQ6NVqDOl0c1grSg4GVOxmlts4DItWu7eDqyBUGe9XLaOzcNJMac61SV0K9ApwHlGOj25QkVe8oVK9ujuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:32 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Tue, 13 Jun 2023 17:31:46 -0400
Message-Id: <20230613213149.2076358-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b3f507d-5e5d-414c-614f-08db6c55b237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Yy8YHE+6t4IpAKEk6pu0CVvi6Y9KM/HaNUm6TJlhB7b3zYlR8iIghvEoCxsxV2lyL0fhjWgOp+15UUXsbTrJG5BYVNd0sE2rYwXj3Gm4W0uS8kmdK10/1UvKVaZC1+2Xr0mgVS/kjnozEirT16/y8COSZUIHQtKNjPN/KJ+oQyfuvCC0rSTkdcp7Zq67TG6xzcFA/Y5WIpP49cJsAhna9rOgx0JxBvyI3toF1m1LR0towWnQx7Px8DdRTvwPH/e7Vqh38PV6eMKkxnq0JqJl0ipbisRzVzH39tYVOKW1/8gosJgzbhOjmI5fNGe7L5D6N2dj/VnueGId39402EALGzkQbkeOZDJFLn/rROh86SXXj9YlVhZh4jp6KsZb0z/krILgCXqyrQAUZ8SN+oOgsU4BpVxy+1d5QS+9k+a77iL0bLWrJk9joFZV2OAN63W0Wm1uKFJrxXyK7NG98qxqR+1RzPnl4Jsd6B8ZxRPZ312BN/BK/KJCg5S1JPro+oYnRjbwe6Qu0cqAV4mxEDtssMDXZPeNACt9YXRYpBxVRF7TbVb4xjJ1r8Kjj7hZy8Mb8HK9hPbpTm75vk5oae5AxWC0VSEquPTeJ63GwXfvDhnPuCCAnDR50ovVj6cl2bC2hUyqO+w1yiC2woqQsE8RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qN5e7+pbKeWpgPeRo9jyWwi0MUHJgjpbsWuUsDItvXqgVGJ+pBsxcIryz6qH?=
 =?us-ascii?Q?g4YZWqFrdMtQRkn7MD0AdkFvDL2vKCbU53u06QavrdmiKPu0IjUX6Qg9m75P?=
 =?us-ascii?Q?2MFz1GLhCiYAHpG2x81BdYc3uCAHxMAOyAC5G7RlY1eyb3WQCvdwnwKd4n7b?=
 =?us-ascii?Q?w1ciQTh2iZC/dFH3NQiwVFUMDPZuhSOX+DQaCICikp9RkF/6gSYQ/0ya82H2?=
 =?us-ascii?Q?ykcnJ+NeCMCX7I1/ki8JhMckpwtIcFsjNDC7FyvOowQQLDd5FMeGTpS16sec?=
 =?us-ascii?Q?6ewGTjxvROCepK2GtUmDt92U4SY2OXwKV+5a9i+tCbvRv2fGuWLUbG9JO251?=
 =?us-ascii?Q?PwKEJ6wP5aDIfKpG1TuwePbt8DVwZ8j79Fju3M2KOQxtIduBaXllY3xcqqXO?=
 =?us-ascii?Q?f7g92YfK82l0Uzr6JtcPRAU71Zke2BY5/7YfTjJRYHh2V1Sp1kUvB4accPMf?=
 =?us-ascii?Q?D4Ugn93rh1RqLj46CW1+bnRCud0zOk2iYf1SRQDZrFkNjo3mhukjXC/5Kk2I?=
 =?us-ascii?Q?Qu0f/pGQPhk2yG4iXZ9O9gVhgrxDD9kw2FFU2cfVcN+s+suce87zv1owh0iS?=
 =?us-ascii?Q?8QF9XsZpefwUcu01/Wuoe2ThIybvNsaJAbEKN7rWsM6sl+4F4TH64O1ZWN8J?=
 =?us-ascii?Q?TujzMei4mFg7/3B/sbQwXRkmsO1B3c/fYl87DMTXvMRWPoRbJT1xeQyMwO26?=
 =?us-ascii?Q?hrTo+Vj6iSKDGpZEcznVexmW2KXM6NnjFODksh7XGlkklXkymUMeDIi/D8VM?=
 =?us-ascii?Q?CfGRZmP5oA4pBZB4hXSakl2NMwCXi+qMjnxLFWwTXwiqnrExJye8IzXVz6Aq?=
 =?us-ascii?Q?3GCxhZDUClnwvHCioDwY3Cm6UAvIbkdsp/vSh9DU0ZGBTHLXbN+zmYPe1U85?=
 =?us-ascii?Q?tnRxlSZo9SmTMphlYoFmC2IHv4hWIoy5985h/ukOp5T5CQFKIqx+qEUe7pQz?=
 =?us-ascii?Q?cY9KanLXh8ughSfR2LBNw9Q2U4lAFbh2y452ciG73lnCYcxoN8AdDaRMTew6?=
 =?us-ascii?Q?JdQKErBkV09l4mAFId2sUMt0Ikm2KTzXJxdCVzxCmOp76jwKfNHnPgz/Llk1?=
 =?us-ascii?Q?EhwdBh/WGLDuxnSVVRuKwEkXrpMpH7AxinGIGxE3uzqq8i2EOMOmuv60hpWp?=
 =?us-ascii?Q?64SEFhbj1fiOuCqYGXc4HOvcJHI4YGxynazrTC7yD/wIRge+Z0hBsDVh44MO?=
 =?us-ascii?Q?kBuQ6LViWbpsUfw/itPsrg4n3/gDjjr9M6RLyYPckFoNWkk3fvS4LqkfcTXk?=
 =?us-ascii?Q?HdMeNQFivtK0ScrXJAHNFIUTCOhi0DUOXjE8UKFDdn1VKSJ7mLjG31laVHC6?=
 =?us-ascii?Q?2PGCehwnzqbSE4kGL0N6zHC1KpXdoaKTUOyYPSYCX0hk+78zObKTbK5p8zEK?=
 =?us-ascii?Q?0X4TRvKC5JjIbY+dVwLEC1kM3NwqDz3HRQSHRjwhFs7Ns/0901DKrijWRaWg?=
 =?us-ascii?Q?rKex2kmTk2eYfywRI1gqRdlERIATFHzI+YsHBplilHPeEQvwm9sySfeIrByO?=
 =?us-ascii?Q?ZU8fRUV6mJQT1/MpESSxHY4v6giKrVMipHpctOJKOL2Y24DQ3KtqKGySlE+W?=
 =?us-ascii?Q?F6Yj9YPz5alESwIHHq0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3f507d-5e5d-414c-614f-08db6c55b237
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:32.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34r6FxopL95Gj+z1XLFjWo+TJ22coybYkVARlgDSzqR9E7rywL5pBBlQL2ZLIyoC5il61T3D+E4Cxdm0FyGJ2A==
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

