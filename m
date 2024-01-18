Return-Path: <dmaengine+bounces-748-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA61831D8A
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 17:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDD0285463
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD82C193;
	Thu, 18 Jan 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBwQ6otw"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891629436;
	Thu, 18 Jan 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595379; cv=fail; b=XZupyc05pV6yZHVoc5jbgay9M9v6MHGOHmdd2QTMvOQiGr4bszLVfkGwE05ByUguAHViT9YbSF4bhK1riJFQjkNG3No0FtwBIWa9IrzbsmZB37dxU6sF94FoDZlrivmS9/MevrKmfaZGkMySO6OzfZZZs6tEe8NDniuti7HwCDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595379; c=relaxed/simple;
	bh=tQwoC6MNp2REzN5D2Jj34VQawTbZFQMXs21A+33tTto=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=VG6kXfixYKNexxWsYhembCdyU+shhQIwRKTU1pDUIkAfVm55qbobEmnRp5sDHw2imGqNDcPfaLQ4IuP7zy2p8VyomMxt1m8QD3cVG8AhKdlAg2DB6G1G+8hN2ZVl6THAE0MlS8Qh84Ej05XxrNQZ7HlWbbakgGLuf5m8802eseU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JBwQ6otw; arc=fail smtp.client-ip=40.107.6.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhOXYbcvd280yMSd1NuajLlyRcalU0hUsWsCngrkX2OCikL8cJ/ReMd2FGqZnPYAo3sSHRDbMiBodYjBzzoyHHlEL8woPilr99qkifpW+LxX53512Ej/LnZcQHFQSN+yJaY0150F+Rx4u2kO0PLANIypl7Gt3AWv8u3hJFsx6kW9ZRTyB8w+vYnoj0bdK4vIg5GdW/E4vT3Wrxot5jwzbgsJt/N0U/zMBWkYHxTp+HTYowm9hq6EVP+H4/6t1zJQnLUQ8FgMCkSiNOP+kIPWUYQxBgdX+/NYLcW1rvul/F+rdrR7i1PBkfWlr7aVqxSruMRw4SXqVOb4HoySjX3JXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb2niAk1XXw9fss5zuux8gNVGN7wtZtvlW6UXzKqcfY=;
 b=H1lPdTawAM+tcPk0mikQT1Ueuvnwy50HNJfsdwRir6V4Fz/23OzLXfpx5FMLcJGsWaTY3wei6fq0/N6PIjErRsr0ID29UpKUFVg39VBqV8/rH0kjIlaJIoNJaW3TLKFQlCXr3Vfxm+PIpkaK4qcP8SpsgqCH7IvnWFLli+HHSHwmYgNBBoqr05BfGNmktASrrABOSttyyxo4RdKllRcZreFU6Chzv6L8I/l452XlnnT2T7AYK+japfFzIB3X071RU0oMak+LUdi5GZBazhuOqxWwYXzFlCel36F5cbJFoQPx1uIYXWEwWHufda5oxroJg1F14GsTAyyi4n0VGUKwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb2niAk1XXw9fss5zuux8gNVGN7wtZtvlW6UXzKqcfY=;
 b=JBwQ6otwqIWBclQgTU9QbjJvva+YPHHe8Hgc7c/LmELCFljyRXgs9+7hcmrqrHBFwRqGwW7avuPKHUJWSC1ietfv6adfj/zahmlazQ+RVaInQVGeKQo3qI45Y7ToSQvMFGYAoFMdtdkV4M8QACO3bfruTCLD1Yhl1iz0tJkdOCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 16:29:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 16:29:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Li Zetao <lizetao1@huawei.com>,
	Peng Ma <peng.ma@nxp.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools
Date: Thu, 18 Jan 2024 11:29:16 -0500
Message-Id: <20240118162917.2951450-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 5895efe1-4490-483a-89c8-08dc1842a7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O7M1vt+0LS04mRfjyAMi0gmYw/Oj2Z9GMqGD+ENAB5zYPOXLXYzizvxtYx/bR0yDJUMOCPV5wWaVsGLAOM4dD/32z8pr3DTuReMCrGQ2zu6DtwICM3P6Spb4Gz5BwpKb4IbpZPNEzbH3YWN4NVmb8EeY0eMYdbgFd6sSbm15BpK/h4+pVAOAoyPgeKro7hhX6LfWW7iN1n1VRJJxDM8VevLr9wAzgBmDEbIswy+1kUsxOj0V+DDKT3P1P6kA34jIJULcYXA7gy/hopyu5DqaXfP0mTx/mT2ElQ9p9JOSx/wIfxhNyw2KYTFDEgOHkBMzFQTE8f4u/pUabS/2O8s4OXq9HGZrZQZBwe+DusqlmFh4FrIZuoz2/6NpcJ36N9cnyYDaLcFJOXyzPg4pon/Wy07k5a0pOU4v7oWt0kO2Sr7VQlfV2RuqbPwSE5R045zIn5wmJtupEOc0BBaisyWJ0L0HKEC3okK8wGSavBQ2TQOskSGk/OkYX5MzOQ7K5/GoerWhPM1f33jXXQK53KPuOb7XGXuc4Nbm2K4RHKSRamugTObxzRc6FmJqIFVf+Ikwe9RmP+zyVwwoy7ShNipSxZE0xY3JQDrcgLhfBbYVLS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8676002)(36756003)(8936002)(2906002)(41300700001)(86362001)(38100700002)(38350700005)(5660300002)(6486002)(52116002)(2616005)(6666004)(6506007)(26005)(1076003)(478600001)(83380400001)(6512007)(110136005)(66946007)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJqGQuHuFi1hjhGxvx3HB05v9rGa9uycrgCoe4u6DHhcmFFqeKH6sHl1eqBt?=
 =?us-ascii?Q?aMJSr8fHTT2wmmCxSGY3PzEGhKAzYA0XNZbVwEGg+aqO5VTeA8iwVMLfpN7I?=
 =?us-ascii?Q?PCEDt5T6Zp7URxvri00khrXSccyUAZKoFu9yIWJqixRpPb7xQNY10fSK3yYc?=
 =?us-ascii?Q?cDXIjLqRz+b1gEYV36YMMTf2zc3WhGi82jYTuxPJxkpZ07VTBku6AdP0YPNK?=
 =?us-ascii?Q?Aa8dtfAkQsGATX+dCMJEwIxJeahDE+zBDFBKSWQDElv2bCfeD86QhqQh0nzJ?=
 =?us-ascii?Q?qLwiRpJVEAGQmB+s0/Vv+73aMBRtwxXfd6tUcno0qx5z1/ON6qKg8ewv920w?=
 =?us-ascii?Q?R2q9jp5T9Gq1BGujCUHtxTXDuLDSWmvQZaw/d+/kkK9fsZfZ/p3FOjx9S9dV?=
 =?us-ascii?Q?9DIwKkhnSNp61aviz0mil3R455I3ZkdJjWXYc3XfxkQfHOF2dGw1GVrAt/Iz?=
 =?us-ascii?Q?z3Vkj5F/BcwkHwkSB0c+B5XqOpl1GT7NQmqMLIcyZ9Ns4UdofR4lVgSrPHPh?=
 =?us-ascii?Q?0naYyOQtrP7Kcs7r0qTUrcAjno2c/xYkQVwUKowxUAEvipDGrf/s6OttX27a?=
 =?us-ascii?Q?XdUySlSsy/7Nh1beZ8m4L8pMHSKIWWX0yUepfTYgM3mn4es/x38GNzA3W0f7?=
 =?us-ascii?Q?tn+eUT3D4HqRnccfFCQos6pz6fYQs7j0ImGbZ6oNGHtgnIC5yxi/KgnYAuxc?=
 =?us-ascii?Q?Sw+UFMH0CwYvPAYI2FxZqA+vR0aHrQSe1fVzZeJXAK8mKBRfBOuTgK7fdVjL?=
 =?us-ascii?Q?SOAnrvfAqSgX8vR2aHLu0FjvDfbYrHbMUcPMG177HbSTSG/Si7xleZORtyWW?=
 =?us-ascii?Q?2uxXtgGBhdrG0bfaqmRz9M9gaQnyqcKLlDxaCZ5gfc52hJJs3N3V8rRLorBQ?=
 =?us-ascii?Q?4EfkOQvTqq4qczknlG2IV3v1PKPaZs/0Qi2I9yhZAg0DrWUdcEG9QIvy10tb?=
 =?us-ascii?Q?AuYDMcwafTo33nEgsrn3lxZeI6kJVNqqMxpRTe1Jm4KOk05Cr+v43x5eS3J+?=
 =?us-ascii?Q?6Y7QDTTpDm0O24/uAPm+FIqKSB0G5EGhpF5P8d6r/7uRMUMhDvGcGZPvtKYp?=
 =?us-ascii?Q?JknT5xgrlvRFeNT8T1qDyEu1UyCu3CIDXTA9CMU3WldOlXRjdtW2UguTN1WO?=
 =?us-ascii?Q?Og3Yg4fs9Kp/ZqL5E5ii4/WqTatfutGAaBBLdUGlgdyxJvOa3GJM61M6LeE1?=
 =?us-ascii?Q?/hTgsCuwP+wolFDh6Ox1U3/bk/cOEh6mZZjn39GvjMeLEt07shZghgHji5OY?=
 =?us-ascii?Q?ga9f42X1z0Z0Kt802S+VdjJna3LzQjAnnNZmAL+zLD4mN9MlEBVjF9xXSTAt?=
 =?us-ascii?Q?7Tls2jSJIEPDgoJ1vy2gn4eNIOYlLEW5TgcEsBsx8mfqe7s4Vgg3Tf6SqmFk?=
 =?us-ascii?Q?VhSr7Ouib18hv4weNJUxrGZNT5lrM0V9WRR/bOkeYgxI0dcMNdmMz61QK7zl?=
 =?us-ascii?Q?EVzlwqlZrxEKVW+m0gsqQ1SuTGL0UeDihUCDSOGTXTCcPxADOR4vMBllGsUZ?=
 =?us-ascii?Q?I1crwRAUXrw9Jmah/CuEnOIlQ9V8lhLJ3COqBvnk44K2uFTBjEgu+Guko1h3?=
 =?us-ascii?Q?mIPx59mRSxghKoIl8e8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5895efe1-4490-483a-89c8-08dc1842a7fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 16:29:34.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdFVuqsvAVj1B17rtoTY+ihvH3LF66Dc+hrrezSWKBsTxLAx2ajvFooJ9GfFfDUF2jd6J2Fw7HGts6AliD9ovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

From: Guanhua Gao <guanhua.gao@nxp.com>

In case of long format of qDMA command descriptor, there are one frame
descriptor, three entries in the frame list and two data entries. So the
size of dma_pool_create for these three fields should be the same with
the total size of entries respectively, or the contents may be overwritten
by the next allocated descriptor.

Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 7958ac33e36ce..5a8061a307cda 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -38,15 +38,17 @@ static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
 	if (!dpaa2_chan->fd_pool)
 		goto err;
 
-	dpaa2_chan->fl_pool = dma_pool_create("fl_pool", dev,
-					      sizeof(struct dpaa2_fl_entry),
-					      sizeof(struct dpaa2_fl_entry), 0);
+	dpaa2_chan->fl_pool =
+		dma_pool_create("fl_pool", dev,
+				 sizeof(struct dpaa2_fl_entry) * 3,
+				 sizeof(struct dpaa2_fl_entry), 0);
+
 	if (!dpaa2_chan->fl_pool)
 		goto err_fd;
 
 	dpaa2_chan->sdd_pool =
 		dma_pool_create("sdd_pool", dev,
-				sizeof(struct dpaa2_qdma_sd_d),
+				sizeof(struct dpaa2_qdma_sd_d) * 2,
 				sizeof(struct dpaa2_qdma_sd_d), 0);
 	if (!dpaa2_chan->sdd_pool)
 		goto err_fl;
-- 
2.34.1


