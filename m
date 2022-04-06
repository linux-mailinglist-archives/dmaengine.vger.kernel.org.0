Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F24F67A7
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiDFR0V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiDFRZz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4273E1482;
        Wed,  6 Apr 2022 08:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6mhALYqv/vWgQDDaSBy7Dw+4yHRwufdvO2VYMtT9NatY6kpH50gJ7dfKXQ5GNRGaALjLXbaC80opfVntf19qjhO4d0LGlSynv3mUGWyRSPYKa/KeZBalAukPjmjOAqd9SNU9ITm6KrBRi04xOXPMWFSNknB+vGjYA0/2qKW/Z3Ap8cZ26ujVLY/DpPAza+2vKExZ3mbssGa+zCKgq24JLaTbSM5SxaibNnJsOfVMhonysjAGKVJOgCH9K5MQ6MVhvIq6otrVMxr0sjWqdHrcxlcq8/RhvtSKn7uMxrYymsBWpePhvgQRAmuT63FvOiBCE6tNhDrS8MhZrjVwGvPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyjQwQHvzM2CQhoUU9+2mxa7LiZrdjp6OmFw70z6ejk=;
 b=XO9P8yVfKV7uNdHbPiFJjbaauwxhjmKfVm3CrhStVw2UeSJ6lR9ybEt2bZhrUJaQnHISexTt5OsBGAyzEc1X1nGmmWvvrJ+Pbbc4jIY3ewPCEftNF8G35SmCmNGWhKpi4fyXXNeka+rwlR+vHdvtADFJwFpdICUsLlRJf7snF4DC2juB8Nj8IoQBksWRRNCqGv1LeQOks4jOAgXPGCDgNOoeMzyF2bC1VBsDq01NGR7IIQVq2FqUVAPPrHknpnLouXL3lBR1hwzDQM5vnvXsyOSjRDQPqF3YgdgY6TKAqCz9TNescgrOJaSDuDRppSCM6ISY8Xw3bf55OcQnSLk5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyjQwQHvzM2CQhoUU9+2mxa7LiZrdjp6OmFw70z6ejk=;
 b=FvC3qhNJhdg+zVPigAnmNlMKeAenDGZAs6gvje4PwBAIGMv5od/x7t9ZHJk+9tl0NsAAFSAVR1b1j8G1BlbCakh1LqmJe5O/rMnASbQ5r4lMYZTNn5gy2RrIby5Tz4S5lldkv7RrOcYBVGvDmiOBXHmfjwzerq+nyfXp4Sp2+88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4033.eurprd04.prod.outlook.com (2603:10a6:208:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 15:24:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 7/9] dmaengine: dw-edma: Add support for chip specific flags
Date:   Wed,  6 Apr 2022 10:23:45 -0500
Message-Id: <20220406152347.85908-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406152347.85908-1-Frank.Li@nxp.com>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a4429c-d5cf-4778-3889-08da17e19658
X-MS-TrafficTypeDiagnostic: AM0PR04MB4033:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4033793AED6F1AE028C1C46188E79@AM0PR04MB4033.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SxbjHIwURMoNrBmQKzPFT6v9Ge+j07CzUmi2z8KRUT4gQngPRTiLQpCPrwYjqbjr9oIyrQfqX8J9pTGgkNQ8xRktyQvV5uWiJXnLHfkWLjaDx/vKaOYx2lBVaJko00lsOnsjaBUfV/UYeGKdZU6GxZ3CrxyvyHHUEbCxA2LiRtRh/iubqfeoFu27Ox/lYw2jWUyvxs1gYWeKr62eHETyoCwRZoAKqtC8S95D73tcADpV7hucHkVW7j9+QGqiIKcqRK9m0QN3evJqFRdldupM/Hr4ChqbE1/BhRHg5nmndbyrQiUnnsoCa37AWWh+1e3Rq0SO+VHFWkJKnFsViXGOzUjSjirv+p0xchZ9mlrhnwzDxq3dCSUm8Bl84qbZqslBNhaeQ+1gbJiGatu8XQagofelsr8sUzJNC1m33hef+XFcPB0vAoRJjG/h5gKbsefkySGOviHKWzs2m5U0+ZNeHSEZmG/7Rgibil8x80/4MM5+UXpT1NnVO5CY4fE33DrmUadOl7/ycAqucinsalpEsH30Wjs2TGixTmFlgaHejidNo2pZ1/VvRBB4ULoOA2EYAw2GLSYhwLLbxquTpd9TSxM17JQawJjn1y5ghVsoVAIUu0jZvlv3iou3GYT0i/+CyQe//t4a5BV6MfWvYC8kNFYxLBTLmILfjeklB8TV1fLJ4JptceA+CZf6t13XiLIzZCKOxqGuMlaWTyQUnjAnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(26005)(1076003)(2906002)(2616005)(36756003)(83380400001)(186003)(8936002)(8676002)(6666004)(66476007)(6506007)(66556008)(86362001)(66946007)(4326008)(5660300002)(6512007)(316002)(508600001)(52116002)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I34iP3/x4GcPhATKqocpvAlKgNPEXVSqSPDtDmM73btSgSLAmcEfA3LhCBBF?=
 =?us-ascii?Q?ygzK4eU6QK1gUgsy7VA+XP4nUCAqc7KkcpL7LP0fbhpeOp/3XUvdSjuE4c0O?=
 =?us-ascii?Q?TslEPSGdCs11qEnrp3jCr8ONzwIGlaHLZJCeDMpauWSFc92aCEnC8OCS/jyN?=
 =?us-ascii?Q?dzgfW0+TJ+TMrFg72m41aiVyh8/yqa0cCAMGdiHPwEhh6GcbTfgFdWobd/Zi?=
 =?us-ascii?Q?sR9dj0Gvpyg+ei3HFNdMC4qc1R2YZMhuxrSir/xHj48PVqs737eWw87NPPoM?=
 =?us-ascii?Q?rHiCJ144jlKIcx3ba0OBKhoUzvSFvbMXed1IBKhkmL3/CQz8IQNz7k2Sn8IE?=
 =?us-ascii?Q?yEfld+KuVhNNhs8l1CqxLCZByC3mByDRBVfslq1Z/duRc3GowZrCxzhY+U9f?=
 =?us-ascii?Q?dCsWDV/SdFliexO/KT0tzNvZ1Wjy6P4V92KU7CvD9wZEzhGJ4JguZkH6T0yn?=
 =?us-ascii?Q?pzm3+1Yg2Xnr6RgklohFxt0z2kl0c22JXNTr25r83pfJ1q/AP79eP02zyLNb?=
 =?us-ascii?Q?REt7Ga7wEoi2v5f5vk49iWavEloX5CGU6NoUKkVsK0/vVs9YdXUSxGFpbdyZ?=
 =?us-ascii?Q?1PYbijn6e4bkeHgzz0mmTTt+OJWysvzsWwtskM87AjD2v4hd7E2wXHMl8OZN?=
 =?us-ascii?Q?oOlZpwUAt0EUbu8AlS8/qmKBvt7OEVdfQ36tXtlju8ZnYXHzUOIRsgvYSJ3o?=
 =?us-ascii?Q?oCvWp2kVYJXJAQjeNKKC9guJnKDZEdB5Kaf04/hR4s8psfWS5bPuMikNXLfh?=
 =?us-ascii?Q?VOVNJIMq05PdtgGyDalP7mxgmcjIno2g2D53eSVJJEn6Ujzudbon6Jpievl5?=
 =?us-ascii?Q?ehFMrhN5vmAzE2e/kSEvDI5w1xcKDj5My5nhd4LBsa6tekKp8SJbEQAPiSf2?=
 =?us-ascii?Q?dwTO7yiPLK496n6PK1xbW7fgOAYUME2TNvrYyBU02wE50HLNv+MIbrGUGEMV?=
 =?us-ascii?Q?Dzoy/07HgjzD4P12hp2sUIeCkN9iKQo9KA/gCpTiXa89C3bz1s+CUGnr5o0P?=
 =?us-ascii?Q?yzzVCy0A024ZGlBnbaoDUyV8emQdol3ppWQb94S8S5hWqPf9P7FExgxKsrhE?=
 =?us-ascii?Q?Kfg0FHe1LVGdFgNOe1qljy/S+2F02aLZZ8x7q6k9a5jBw91cK9HcJj/tzOMO?=
 =?us-ascii?Q?IPQ+dKIolTLMHOh45D4jHzwPxbkDXTRqibapfy7OFcmGeErbZjb7LyEjncr9?=
 =?us-ascii?Q?Wz8QRwgQdR6klOJwO5bZ48YmMk96pugldZVam8DX/KxY5xdN7w8Avv1rleSK?=
 =?us-ascii?Q?SZp4q8iarDd1LO4hQjhlS4zu8qcvOhnGUX2KubprwjIzcHDMxDQj3pAmU/w+?=
 =?us-ascii?Q?vKIX9WoyYQqhj174knh2m/B0kDUOB2pLswUecvKwLsaBDvAauYEqvFlVgDxP?=
 =?us-ascii?Q?bljSgOBAs/Ycg5MOzgdGJ7zrtd2fcCbgCv3MD3neT+LvriAz0z5QucIVmlrV?=
 =?us-ascii?Q?ONr+QQXrFdSOTvFygX+J7mNbyTJ2y0kyYq7urC2os0h2RbSj4CuJNIsf3duf?=
 =?us-ascii?Q?Z6YliAQto4L7/bnZA+y1X7Lxg6OXbNuaLTzRCGk2S9u+w5zzRUMo9igvsV3O?=
 =?us-ascii?Q?2+iVW4lECyJ88UxbyxjaIacqumK1MCmKDktyrhRMwdVmAMm2l8Y8Gxfr2kjb?=
 =?us-ascii?Q?FmKNqIeCPtxQy4pk8DVq+0aoRxLKzGpf2/2I2RTN+D4VBqE9/ZvvWKxeIv0H?=
 =?us-ascii?Q?6tWSl8yVncQez9cxOP0KM8OhJUAkXb4k27ZM3ZkoEjp81ekZsZ81ToRV5X7N?=
 =?us-ascii?Q?mNb4C+Q2mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a4429c-d5cf-4778-3889-08da17e19658
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:48.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYnHiWdiUtOKSKSPXlthCU6CUpfGo6uc9uuFB8/Jlfa1RwIswu2eYdlr6Cq2TflD/w8byTzAzSd1U3c7NhAaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a "flags" field to the "struct dw_edma_chip" so that the controller
drivers can pass flags that are relevant to the platform.

DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
locally. Local eDMA access doesn't require generating MSIs to the remote.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
 - use enum instead of define

Change from v4 to v5
 - split two two patch
 - rework commit message
Change from v3 to v4
none
Change from v2 to v3
 - rework commit message
 - Change to DW_EDMA_CHIP_32BIT_DBI
 - using DW_EDMA_CHIP_LOCAL control msi
 - Apply Bjorn's comments,
        if (!j) {
               control |= DW_EDMA_V0_LIE;
               if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
                               control |= DW_EDMA_V0_RIE;
        }

        if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
              !IS_ENABLED(CONFIG_64BIT)) {
          SET_CH_32(...);
          SET_CH_32(...);
       } else {
          SET_CH_64(...);
       }


Change from v1 to v2
- none

 drivers/dma/dw-edma/dw-edma-v0-core.c | 9 ++++++---
 include/linux/dma/edma.h              | 9 +++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8ddc537d11fd6..30f8bfe6e5712 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
@@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	j = chunk->bursts_alloc;
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
-		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
-
+		if (!j) {
+			control |= DW_EDMA_V0_LIE;
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+				control |= DW_EDMA_V0_RIE;
+		}
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
 		/* Transfer size */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index c2039246fc08c..bec444e2939b2 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,6 +33,14 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+/**
+ * enum dw_edma_chip_flags - Flags specific to an eDMA chip
+ * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ */
+enum dw_edma_chip_flags {
+	DW_EDMA_CHIP_LOCAL	= BIT(0),
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -53,6 +61,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	enum dw_edma_chip_flags	flags;
 
 	void __iomem		*reg_base;
 
-- 
2.35.1

