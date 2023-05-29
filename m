Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABB71503D
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjE2UFt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjE2UFg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:05:36 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21640124;
        Mon, 29 May 2023 13:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPA+TXp8g1XnIwmjr5ikwgzAD/KzQNTYu/UQfYL1ysAq/dbNgTbeRWC1LmqK/zzb3pXtZ/B1kO51KWW3lbwMdzl9wwgCz7CmXcRdusC5b8pNomokkoEQHMj4nC6I31gjEk+TrX2PITDnj5tNxxd+meU8D8SmtGI/lQfWNaQwL/KL1t0U4OVrllPTV9Uf6lSgf88O7WZA0GtAeXKqBdqIxNLIcxnKxA6CtIDNJT+l0nFsk+uPt0Z7mhbOUfzzcai6OhBxVmnFMQctmZGk5AYgbDtms22dV3QKwyzf4f7+xW+HTRlumKOxfT/cHvMEu1UD0Vzt2+Yv5cVXGbor7P7aHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouCBlwm7fIzHEcTW7UBupyDePR7cnWUmtikSOmu98+k=;
 b=RNAfK1xkvMLkjjuhzIIL2lglWv51wlMYkzRxAjdg+ce2p44CIKOGqU+XS1NKQSeoazeqLcQduaMFrA7bdbIMERRl6HItVVI0hcte5w5AY8sconCDHCCqVZE3TD4zG5evseAj+p4IEZxCsIlFXpzpEMmTmdKZPVHxa+h/Km6T5i4ET5JgcbMP8FPhKROMnZhuD/vQnlpRfF4b7omDH0UD1WIinOAlYZHQYmnBwkQgm7Q2GVgI6pS+v0eUoyT0cBHscU7FWLKtInQq9ZkIkRXFPQE7OTVkoiowPmMnZSc1hwnr4bD3ATC+TFVjXs3w/Kz3aCT6FynmaiLHplwzhY43tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouCBlwm7fIzHEcTW7UBupyDePR7cnWUmtikSOmu98+k=;
 b=SQ+0zEXiSmKVWiZT6DtSgRL6Ab97RU6l0pZKwIPU+n31I4wA/A9MynMl/382ppYNudrwCW5Hp82cUCb8/O3yzDo88DNp/18af/UidIikllTa0j0CTaUah3egzRrByHNVmn6w7EAF1SuCX38/K+fHk9SmJfBPRwlmBML8iLVqDGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:24 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 04/12] dmaengine: fsl-edma: remove v3 from enum edma_version
Date:   Mon, 29 May 2023 16:04:45 -0400
Message-Id: <20230529200453.1423796-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 784fbf76-cff2-4e75-9f5f-08db608009b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+XSaWnWXDbuGErEckgeOCnqBzhEoF2Fx0XvYgXvfpyr+2ZSR/0ejqCpM9PjR6Qu1PCXi/LBgb5Vz7/n51CLOq5raxn0iQ6vnsC2uBraq3ZUBjUGAOYnT/HVblvCtVaa7n9KJ4QbkbXW13857EoPDCte2cFNacMxEDM1JFvShxbTulvW2AG13/4gATSwdSOWpIUVuO7sNrIzjUAJszdoqxhD3tuVw4tncT62Vmr8u3yJQn57cph+uIScDOEVVaNzefSMTz1BigmVUJYwzd8AnSeIHNV6QCVfcHMhHm1NWkSt+mgSPEYZjpyWNff+pdq4lFprbCFtePtUq+LuOFtCP5vfpJBIhICZphEVaBWsof7UsGoQiLPFSxesQFutJY9R14HOEAYl5AePAvj3p6qrMGC4PajYpPc5HcIKaXhM36h+xnAdTVZVImv35rxtGDcCgzf5LRsrvdCqXxhyOF+V4r0fxKdswVBJ3Cs3F4RLu7EnH7A9448dXiEUIKp/Jy4U5+cXrbwawDNzG2uNBFBfb8IkiowdqMTAzH/RHZYjvwRzki4TEEhap6rWFBeYafZEzm1XPfywU9M52huGx37gDCH5kElnJVRlPVjt9AxIuVQ7oYQzTS7R9sdeqAjne4Ch
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KIU/HJ1X4AYiA1MNsBLO2iqZ7jtR8Z9/3Sof/9Qn0LtpnUEa3G4yRo5AxQT5?=
 =?us-ascii?Q?g+Y2dUXe44P7/vpCi25uCrLqX7mM+3WAGEvBEO733Uk03rwHzxAzPBgIgeDR?=
 =?us-ascii?Q?630EfNBh1294jq/h+psO+XDJJRMpniN4igYvbKnnQL2oh3MzTMEQF478Qsse?=
 =?us-ascii?Q?drzv6nPkLk4BT/mYE9ei1d8TXGphTCfROOgi4qyAPtTYNdvEBhZsLJjUzNNo?=
 =?us-ascii?Q?uvY86+Bi6nMUPfdsKgNpkPj6ujuXbnqDIC/12YS8JxpeHuf3w0zl9k++TbjX?=
 =?us-ascii?Q?NXgpC1chOA5FLLz1h2uEPHDNPPiYgJtjaZNpJ4eshZoTGwtvdM4wWHtVnZV7?=
 =?us-ascii?Q?9R5V38cbtpPeVRQD8N1zJgg0IwSj/qkYvbkrhVfdExPRX8Ry94wlh2jrS31A?=
 =?us-ascii?Q?lWTaH0xoTaWiH20GcCU5BIFbSlzwE2eShlra0iSB9lr9sHq+weXpEFArm3Ks?=
 =?us-ascii?Q?LWaiWZQ2tnD1dq5m2xUL9Xlj8yPe731EERVwkKHuXPCIrf+rWUnxD2smSOkR?=
 =?us-ascii?Q?Tc2nSwU1huW1qh8qAVGfZNqYelznNhViAcThGOcs5D4nv/URccBDXXiKPZYF?=
 =?us-ascii?Q?4karx7FlAnU08cMo4CB4QXQ6KK5JzN2G/ZWNhv3VVeJI9okBPrvw3FaTATlh?=
 =?us-ascii?Q?VKKhNrKAhi0mKc7AXHO3rnFBeHCDjIAbKcLkdCTgVDBE8aEKClWWJeSGKjw2?=
 =?us-ascii?Q?oZzWOucRdtHr03cPuHm68AjCBcGREcRMon1MTqKEgtNXm5QD1wAafxiW4Z5T?=
 =?us-ascii?Q?K9VivA+jsyomVkrdjS+7HzPdEMSh9d/Tdqo2n9Wk/0xj5aF4BJ9SmkUECOAX?=
 =?us-ascii?Q?NARM9hrEW26bhm9LJws8cMUfEeNtmgPlgNwdg5tQkZTB6TQazq9v1bdyv5yD?=
 =?us-ascii?Q?Rhyg8e6YvutYs9g3rVPv5O+sdyTLv4mUZN+5qb19eTDHH6+o8tHAzFyzuORE?=
 =?us-ascii?Q?rGC0l44JCMpYVKvL2gYQO52hSESy8EV1vsqzLCydXY6axJOjyDK1hIauuDtM?=
 =?us-ascii?Q?LFXc1cWP1plNj0FL05ZIxjq9FOJVltmsJdEweLwl80/T9srulEC2HOEcl9nJ?=
 =?us-ascii?Q?I6ZxsBIl2l8LxK9iG6ll/k1kgwG0M/9ET7ghymsob4kLrK3W36FXQxCQMBG4?=
 =?us-ascii?Q?6N4O8TXO4yIZ5m6HuKe59hLTctBWhaOTJ6mDBE3TJr5KOKlJF33gB+vHEmgZ?=
 =?us-ascii?Q?ezfqFtmQzcIvfF3IsXyRFpfOgveDDpyqX63nfJpYDQB1LaNJW0/HhAn72LkL?=
 =?us-ascii?Q?Th8VfcceY/nzXkhzhTyVpjMPuk4a2Iqhu+0T7b+WtMP1HJZDJKkXPAiasoAN?=
 =?us-ascii?Q?TJjJVEdXBnWeiSrRX1p2m4whAkMxAIh1QSg+5TfyR5KMirYqYbgQDcxURDTW?=
 =?us-ascii?Q?6ZubFb7tL1kj3PFvuxMl7TcwVxER5T4qL23cY6FY6mj0586v0Jhpf6KQbkYG?=
 =?us-ascii?Q?bYEgTAyddP1gloXieVJkEJCuJa2NIhy/1c04a1L6Tft/5G+cazbrKbIyHXt8?=
 =?us-ascii?Q?D2tYzzIrC3l/JQzcBfniDe9twZaJF5xyrMY4Ue17R1JV+25tKXVQANJ1+GR9?=
 =?us-ascii?Q?3uFgU2CbGWrKXhY5edKhns4iRFaaK39DPJIyNXSb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784fbf76-cff2-4e75-9f5f-08db608009b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:24.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBL1KdU5h84u/0gu/Px+HRIq3TuncDxy/9Gb8Lb+GSTGoa1Wnatvf0cFucxJlfQsHjPu47Kmjpec3AB81nJvUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

