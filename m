Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B0712892
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjEZOik (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbjEZOii (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:38:38 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9EAE45;
        Fri, 26 May 2023 07:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqVf7Sd68iCCHmqboY8WZdnMrQlh1bY+sMOCfEELBkrtwg7/cWBdFBNuPcByrE1+lX1ug+0pG//472j4ma00lpnSelI1YVYg039gybukT7PE20t9hSn1dK2N8veZRRYgPnopl3hAcWBIRGD1SykUNF2qD+Dm7fpvle4I19HQQPm0LBboa8pJ5NZ9gz/2oVbbUbsFeQTQro20maCCJOEswetZIEuevtJVsya6n5p0MVFEFRQDNpON1vhOitt16zg5UEBwQYwsj9cWhR07iPslERzKjtxG2g8gmZAXTImjdUi0uT8LuSNXQZS+5gLVYpO/UmKsFG1xpJicuPUvO/Dz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouCBlwm7fIzHEcTW7UBupyDePR7cnWUmtikSOmu98+k=;
 b=aQTsUuEcOLleapwWvPRIJ5ckojx5gIA2USInIkWh7Mp7X7EbSBbY+GXim3f3XpVcOwR8fngq+aMNDl6GMpDPDCcFkwrYok4wIsPku+62xxqq3gHXY3AYPjSq6qv6G6Fpf64CA9fq4AiRZO2PG+aqND8K81sXXPO+9SWwwVADO1rnnfvNq1kEZ0ksuriAwDGidaFZV5SpLvyzfCpNb24FTtAn85pfqi1Z/YTdIksR7iaGgF9m/RIfrw9DVD1u6AiEP2oWMXLhJ10fmRfQGo7/jPYOrD1PsDK4QP92vZCgP4rOas0D9O15VP9j8ZcAQ+7V2GMwmAA5DFYHuXMkplccVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouCBlwm7fIzHEcTW7UBupyDePR7cnWUmtikSOmu98+k=;
 b=a73f633YstTWlBagm8R5FBytQRHzg9nhnKVhgCI+H4vzELSTY9+mpsDvPB71+/flvI160RgSSuzv8MVYwuXlpsVsQCuHRiYZMH0T3ajKNXggXkt4AOUyTgPC8cCubp7bfdh0UautyekGh1JfuOBS2Y/Dt/Dqvmv0jjFSUdD3424=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 04/12] dmaengine: fsl-edma: remove v3 from enum edma_version
Date:   Fri, 26 May 2023 10:36:31 -0400
Message-Id: <20230526143639.1037099-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a4c8ff-b9d8-484d-bc3f-08db5df6af32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJ30xwZiDAIRS+TMY6G2LjRE5q7sf25VjhZea4YZXkdXorgyNZVDBAjKWvbAKryBEi1yLvAy++lrLMhZRoGvsdfhltrGD5tYHENBdxk8B5lvPN/AunYYgR5UdXOIAvRjaUzyDJB1dxLN0xu5NIBg6KEtHcWs5Q1Z5+fkW8lAQW73HD2EV7d4cD42QABte/pcVfG2d3CKhPJb/hEdeyTCNOkYBJSzU2bYnnAxYoCq6/g0tnm9l9zKveMmB4MwwkLYozuhhH9+7m6euETa/+Z0EZzcHwXaj114/rDr5VZbWEWurroQG1YLALH9qY/ulcmns7QmIAif79VpHjykIk5r1aB5Yl1Y5/fEIe+G1svunZSyg/Z+64XLT2AHJGfHhWAtupGLtTfAjb1n91hT9JvWY21vDQCSbrqOLqBzw7ufESjz0GvlkubwkjU6UzLvZ5xj7/7rZH45UeA/jlpmiTfHd4TowJwV2ztbQNf17AmxLkDLjqbA6Q2L6Y7NryFRx608SzB/7O0DgkgH2+ctRddwghH89FJya9t3DZe3HiXeNCpCSLNzUPJYnZYONbbhrYvuA2clIZKig3wKr+iNFLgLdvvC2CmEPOncuv3ukQEGEoLnUgCCmnOcByAoT8Fwv/kDuSzNZ3T59pwe8XEMTHab1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xbQO1d/c8mTh9RIRwOyihtoH6vr71pbVbc3g5+gHgU2mYSigd1V1XbCj692q?=
 =?us-ascii?Q?u9EGToZEd5tfKrowiWI16X2vFJYVfAUW1+EOZWQeLaWESKB9loeeBMXhiE0D?=
 =?us-ascii?Q?4Gwz+O3H/CSul1gBhVRWpTl7ZuBQAgJVpktukQUluFw7ZbUfh4kqENbxdJyU?=
 =?us-ascii?Q?Ckkv9HuOhdJIRUNXBsTSJhwREzZm8ykyPZNS4DUjKGIOm1KVkBAK/fbUcdTE?=
 =?us-ascii?Q?CEp8m8gdkjLtAyjsyiUcy4bN06hSs/77f7d5mYlmDeiKHSNGFvOh9fRwkAPa?=
 =?us-ascii?Q?AnyCZcRgqC2979KvnxRlhJ2Yeu/uk4Kh27edL45SMk9d60lzxYw4q5wsYmpe?=
 =?us-ascii?Q?dR6BZwM95t3vR02Ct72zxzQ5ic5ziQd1Kr8GvH9QHFoaXS3WB6wbEA0eaiDe?=
 =?us-ascii?Q?Y9pTsI1eFSws7cR6Rv65CD4Lnrx90R8XTEYUtkHnCqpYgv2BnZ/Oqv4JoH99?=
 =?us-ascii?Q?AHdkHS/yopKRbtMYX9ct8TeTqFcdRCJRlEk92j4G6Q9vjXr4F1a3OjwzVtv0?=
 =?us-ascii?Q?eaVmqrPV07zizeQwW+kqhC48k/lmvrRmTkX1UZOr2G7Y+q/garg+ASXNNYHW?=
 =?us-ascii?Q?0lonv514oHkgy+WBeiz22HbDk9JEAbVnj0r0MQNcmUvL1C1T8c8nklIXGeae?=
 =?us-ascii?Q?Yu3pAw5vHpctPszq1ZuRqQvMkfgYa/XbrC1+rI9Ije7A/qTQGqH+oUk7514g?=
 =?us-ascii?Q?XDayyrlK6CKisc2ztYtTFV7mfPFWiwgPiYRrf2ccA0zdylq017m62CyRJdtb?=
 =?us-ascii?Q?DsM9ADa0mHvBfVTfD76BiokndSAYxqVu3ockjEaVmlxgLtoBRUamy6im8SFz?=
 =?us-ascii?Q?Zhvi0ZNbJKWlM9bk0heI4fZvX1EFparQDX3vGyN0uGwfjr7P4NO2vcPPglmq?=
 =?us-ascii?Q?7ZNAAZqO7TSiGooJIpLnasyj/pLhx56BbhroOy1d+yzBuGNiLvagp0+2h9t+?=
 =?us-ascii?Q?peeNAeXCfXCWmxKPz+TjacXbG1FjdBqR4YltxZFlO5AMIdxrKLvzjWA5Z2ai?=
 =?us-ascii?Q?M+njT9dfcmvPz5BMz9qNJQmtOBeUzDH2dKvj14nHknlhXyVWkU4MPHjCyJGo?=
 =?us-ascii?Q?dwabysNADKdL1LxijbPJFWE/qvQ9WWj5F79UwpTkB/IGA4hJGtTj85uILmIo?=
 =?us-ascii?Q?GDYpp4DpmeXd6A5TjuO7rv96Xq1K0OmfKFjVyKZPYTNNLETnvVoNIy2XsVX4?=
 =?us-ascii?Q?wY3GGT6KdvbfNKJyt/C5c4jYz03ascd8j/4AH1+scIznE3ftH2J+GzV87OLi?=
 =?us-ascii?Q?5rs7EeVK+AITQ7h69q83PIRBNEAFx7Eng8tJ8U7QrNY6xs3cuBGyXDueFohj?=
 =?us-ascii?Q?jJeiyXS7wg8hdWufGI57F17KKtFghXga6Qhq2FF3Ek6H4xV/vjV5ckNAUYOP?=
 =?us-ascii?Q?JZnSQs1FRKtMzTnvci9xmx35Y/2FBJrVOHV+swp8NsCXU+0XDq3i5QQf3rAl?=
 =?us-ascii?Q?dS+tOrK6cGTRAHSExX9LVYwICV1L79X80AA08xA8iXuJ87POH3TSzkFVapMz?=
 =?us-ascii?Q?4VKZG7Z/KWh6Iwpstol90RlIVpQdJ+afIFNvvpdyAcg4dQphCdnbxkRGmfDz?=
 =?us-ascii?Q?6kbVVymE8KanhQA+xuy0pZVvEKicl+sHiJqBA4Mp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a4c8ff-b9d8-484d-bc3f-08db5df6af32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:08.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQpuSE9Yu7+hjrb65H8sFepMxdDRdVu9nJ3OgrBK6SxhIe/e23ExBCde9yFpA0ZaPLtXmMt+fdL5/dMzLBR6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The new IP of edma refers to version 3 in the hardware documentation.
However, the presence of "v3" in the code is merely a software indication
to differentiate between certain chips. To prevent confusion in the
future, this commit removes "v3" from the enum edma_version.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 drivers/dma/fsl-edma-common.h | 2 +-
 drivers/dma/fsl-edma-main.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 10dcc1435d37..e5c7497c1ff3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -120,7 +120,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	if (fsl_chan->edma->drvdata->version == v3)
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_CONFIG32)
 		mux_configure32(fsl_chan, muxaddr, ch_off, slot, enable);
 	else
 		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index db137a8c558d..2f13e687a721 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -141,11 +141,11 @@ struct fsl_edma_desc {
 enum edma_version {
 	v1, /* 32ch, Vybrid, mpc57x, etc */
 	v2, /* 64ch Coldfire */
-	v3, /* 32ch, i.mx7ulp */
 };
 
 #define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
+#define FSL_EDMA_DRV_CONFIG32		BIT(2)
 struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f5cf95d185f8..31531b8bde78 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -238,9 +238,9 @@ static struct fsl_edma_drvdata ls1028a_data = {
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
-	.version = v3,
+	.version = v1,
 	.dmamuxs = 1,
-	.flags = FSL_EDMA_DRV_HAS_DMACLK,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
-- 
2.34.1

