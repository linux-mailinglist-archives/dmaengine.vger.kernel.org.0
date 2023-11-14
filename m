Return-Path: <dmaengine+bounces-112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0927EB40F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 16:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC971C20A02
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300141775;
	Tue, 14 Nov 2023 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcVaf0ad"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED704176E;
	Tue, 14 Nov 2023 15:48:49 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E312C;
	Tue, 14 Nov 2023 07:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGLFRDTW4rqST6uX7TF2jIgmO6GH7fecswFgcwoE7H81P21FfFiWST2tQhk/I0DyBx+GltkMc6M+lPSuPz70MC6KwJk4982rdO1c/fyXv2I+TMQWa5a5HQ7H2r7vGsuWTKIYfHZ9BeY/6TJh9JbJYrGfxymZw0Tih8avuazTIamOKt/zhEEolztcIrSm5bTEh3NbXYoiOgyT1DK+rGimeS9wnwPXoAHEDcF6NvpZdjzllksaGAnNI/tETutVfvXq1v7SPGj3r9pIAJ+gCmkL4d3ihMCkzatltVlYbNmz5unnT1pUi63TuBa67EIoh4ytlhrmsJ4hu/7AJTWH7SOFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbP4Fa+v6IJTu7gDJeCQNNRYU86qiUHCZY8xgO5kY74=;
 b=JCArtKjDF5AWoDvioaxSu1PoNdICTDQXrMlAlJlWEerBE2MPqPBEX2iW1wwgePyxaj5qsURMgeGs9zpR8bvfUWYRE6Ve5Sgi1CWJU3HMIijsCtv8hVcESDYz8vfO9YlpQE/e92AUZVAm+YkqpEO2tNqyQcOg44/7fN41zpRYUknJNQFcF0DYxwPIgPV7obh0WbvgEgErkcZF9tIZfEDXBNMBW/q5mYI45/z4i8thLEpRYI4hn6qsNOykecZK37Tn/54USasaoUh0+ka1cSXj0Y7UU9zV8WRjTT1+14jx9h6MJwWOKo1BdCZVVYW1FNJNo2Roe85lUDw5nD0XqzayBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbP4Fa+v6IJTu7gDJeCQNNRYU86qiUHCZY8xgO5kY74=;
 b=UcVaf0adliT0IWrKRJRfJKZ/vK9Rt25GC6TCtk3f2KluL09+fruUJIDGNfQJJlZ4oAIZHGr2zCwLWB1cqkE+YZZ8YMhGK4YPEwNeSMWrK/5V2jfbProNIaj4lKV+CS6/QO55nQmEYLvGo95jhRPi8yNSER+SUwpDvxT0ke/rdvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:48:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:48:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org,
	shawnguo@kernel.org,
	festevam@denx.de
Cc: Frank.li@nxp.com,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 1/4] dmaengine: fsl-edma: fix eDMAv4 channel allocation issue
Date: Tue, 14 Nov 2023 10:48:21 -0500
Message-Id: <20231114154824.3617255-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114154824.3617255-1-Frank.Li@nxp.com>
References: <20231114154824.3617255-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a6b557-af37-4f0c-6a95-08dbe5293046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jg6c0IIBaYz0qoCJ1ZDAZwRrL9k9swP6DU+4b5yOSWHTKo8Yz2y07UqvOUNEhVWadN8NZ0xOGeHjudXCd2CVCshKDZqSEke2Jx8Hxzkt+hms1E+xg7pdCJtCf6j6smvZQwJlWUzI53ksUxUjsQAe3fZmk77a2DsTweEqaAPkO671I0SKWgZjR5qxhaWlg4P6Qs1bjUWqzkJf6cnBtzCi/82yzmjt1WVQP6hUPUPiMm3pB9UuuSZDcWbpeLtKZYJkMGIufj+24UdBg3NXEG3sjXCHPhKyhvjH7S1x10vhsAN5yELd+5MFZE0lKilcoRKdN7LJUkgOX6GgXFzynpdK6nWYQJHcQs17d/9/f0da80RU4uy5H9DOe+HR1KfkcmDwp+M42CwHvSno2WGRQa2oCbq+kXMDeEYrMQVYd+YNHtcLCLMvGNfRSfEETd02VP2hYWUvv3zm/yAcbmhjKTb6iIRAYmUxc9X0b5FgMBe5kfPWpGjPMAAzVVLRAbFed0fxwJm8PrLNdVeIl9+Rjwhd/AyHjoSwE+XSsyviUciIGwn2v3/lO7m+GBi8Vkpjz62vaduy+8PpQNXy6onB59w+w6IiCg63+jU5H9F8QOoTFEQvY/MCu5pqn7muyiUxm0UV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(1076003)(2616005)(83380400001)(38350700005)(26005)(478600001)(52116002)(6666004)(6506007)(6512007)(6486002)(2906002)(38100700002)(8676002)(8936002)(4326008)(36756003)(41300700001)(5660300002)(86362001)(7416002)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6hrnA7HPG8TEinXNjqpa889QhOk483vPGC4PgrqdZz3i3R1Tdq1g6oBxeV1?=
 =?us-ascii?Q?oSvIHWEh14d6EmM0ukqAFsWWv4JOGb5e8fS9dC08Ev4y8WjxhBz3sMk9LRC9?=
 =?us-ascii?Q?qt79ddDfR1C5RV9JeiuSkYueh4SPRSv2W2X2IED8/gZnWnbBlvkhGJEoIEdB?=
 =?us-ascii?Q?av/T3gvckk/30FdDSVaEos7R6YjB0Kd5SeQxkCaNbbaNc36uLPsG34Uk+TF2?=
 =?us-ascii?Q?j3RUCeq6qiGmKS53kdkjUtVUy2RUlI0AC89oNWuN/XMah7c4tc8OX+j2qK5l?=
 =?us-ascii?Q?IKZ0enoGvcC6Vzmx3HEPalNV5kcWozzKGiU1ZPJDcEYyvL/Z2Cx8XKARV9n8?=
 =?us-ascii?Q?HWXbCuE4t6v6excU/RA/QRUJPqyD6SSJdCEoAsgNWKKGLpmFG/N2/KFFXV0+?=
 =?us-ascii?Q?bqkbXsZP+O20QZbbMwOG90bGac9UcaPXeVSSFNungKDQ9AJzMCA2L/FzZkwZ?=
 =?us-ascii?Q?051yK3WSlrJuEqGMvTzZYyaZOXNgCrvvWxZKEAp3ElIEnUBnFjQY+0VvDhtT?=
 =?us-ascii?Q?U+HduoJSJEerhIlb33QuoW0C1LQdwUZJjBGAstno03lw8kupnfu/+xIA+Ghj?=
 =?us-ascii?Q?P5CFw1nfjNabhcL42KpzAdr5DMqFnC5UJMCBnS5TA+V1j+/WUMDc4zHWGvwV?=
 =?us-ascii?Q?QOH5loMspsWb5x5l4+wGmgSTQMtjsQf7CNFYUIcfB+Vyk1ZbsbsMHplqaDTQ?=
 =?us-ascii?Q?2xgOy23L+4lp2iW+BE51/qw2c3bWbjt3bWHBvpQ9VMt/FKeJChc1mqm0Yxqi?=
 =?us-ascii?Q?I6I488flOhgWbAqG0D5DLJp3K1RSl7jysWubG1PG/K8y1lhkhBxTtnCgUuKn?=
 =?us-ascii?Q?rPEvus8x1LkZGAl/ZRnPKERNFrigV25HZBP1YhVKOTx13cblBhgEkMLUk2Wu?=
 =?us-ascii?Q?rrnMKTc/lrtgUScej8qXi08JqDj5LVUXfF+NsEg7+NjzScYyDm0CW3pmpWRu?=
 =?us-ascii?Q?xHjjEW6/tOsKV1bLxJUwWxCUGPjFyiEaOG03Hath41rKMO6dJ5NTQD4oDVvH?=
 =?us-ascii?Q?LOXVu0pXiujaIKqUclhMqdlzU6GngMk/8p43xSZkag0Ra7EKpL1jms6VBLh9?=
 =?us-ascii?Q?HNm3GGp7p7K2Ky6hVXbKyS/byD5ZJYTno0b5Zi084fvFr5XpGv7dAg1r4EkF?=
 =?us-ascii?Q?GoOHwDnLvZ88Lg+Ui6yXiVzE2dGuFGRmD4/vR0XrvVjG7v4Uh1Ykf3X6Pz3f?=
 =?us-ascii?Q?I3EUmkMkkAo9d8LkZbPP7DX6Zwf4ufO/DXVI3bmNe7++kwK9BKTqphZ5Sr0o?=
 =?us-ascii?Q?Da3WN+hgjyxwhiGJvSyI7CF9HBGM+t5ZAja5mjcS0VKxG6Z0ipV0huCRuW6R?=
 =?us-ascii?Q?3pEOpy/3vQFwVmYRgRn5yLyBHXRf+pdANz/cG0+R/3hE0CGw6GmbCszvu6d9?=
 =?us-ascii?Q?eLCx5h/Lb03SqzjW66Wh9Lq7cNpEF1HBvebg2ZpSxIzF46xHFdRja/cgtOzN?=
 =?us-ascii?Q?gPCZtZlr/9S7AhFd6tQR+/ge0PPqLfaBhktCkDkokMtp7erNjnPMCjDJbaee?=
 =?us-ascii?Q?ZbblOXShX0SeJ6SRYwF+sxS3v2m1uFYN0B5+UjBptiumDgO7fbu1cgLsE3db?=
 =?us-ascii?Q?ZhAK4ZQRET3adAbDuwg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a6b557-af37-4f0c-6a95-08dbe5293046
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:48:47.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgNmV/Ior5IihPDOW+k719p6NVfPSyw85qMNn2gCWBz4qscpojioDQ8qSKrPXPqzyEAkFb5qLY00NL6IPoWkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

The eDMAv4 channel mux has a limitation where certain requests must use
even channels, while others must use odd numbers.

Add two flags (ARGS_EVEN_CH and ARGS_ODD_CH) to reflect this limitation.
The device tree source (dts) files need to be updated accordingly.

This issue was identified by the following commit:
commit a725990557e7 ("arm64: dts: imx93: Fix the dmas entries order")

Reverting channel orders triggered this problem.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 4635e16d7705e..3ee08f390f810 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -24,6 +24,8 @@
 #define ARGS_RX                         BIT(0)
 #define ARGS_REMOTE                     BIT(1)
 #define ARGS_MULTI_FIFO                 BIT(2)
+#define ARGS_EVEN_CH                    BIT(3)
+#define ARGS_ODD_CH                     BIT(4)
 
 static void fsl_edma_synchronize(struct dma_chan *chan)
 {
@@ -157,6 +159,12 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
 		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
 
+		if ((dma_spec->args[2] & ARGS_EVEN_CH) && (i & 0x1))
+			continue;
+
+		if ((dma_spec->args[2] & ARGS_ODD_CH) && !(i & 0x1))
+			continue;
+
 		if (!b_chmux && i == dma_spec->args[0]) {
 			chan = dma_get_slave_channel(chan);
 			chan->device->privatecnt++;
-- 
2.34.1


