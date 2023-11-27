Return-Path: <dmaengine+bounces-263-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CD7FACBD
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C511281BB1
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A546531;
	Mon, 27 Nov 2023 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HuoZY9q/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B9695;
	Mon, 27 Nov 2023 13:43:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBYCnFnvE0nVc1/1JejL1F8WKUmAsGq1ZuGZIJtpApfJ4qFRfFe/pHFdjnC/f1P3hQJl49Vrvz+PdpVsm2YtxvdN2dc4gE7zcRCDVQaD83AJeCIrtSbDGTd1Urx8KHrq49yV3zUgWSgYxRTslQaPIyRYqbSTbPOSEDnkaojgpXupmSistGFgVUfnh41/qV03n4qsZKgQPoOCWDWS2gKZAAVP/H0DGKSbeEpicUBa7LlrFP78/tAuDmWWWEpArKKmYbLGaYlA7oFN2u1AVfcidGaH0qtfkypF92G40RhJ0CoeB7hCi5CVcz2JI/h95jMJzgkmumpMvjwQ6IK3Q89ZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxytWk+jybXR3cgfzcjYVZ5PS4AZYUVXNvsnrJk/hDM=;
 b=S5T0OAj7qJtqff504pkZr7P4iRBOdbciFBsdDytVByjz22ySlq9IQZaFUfoIAxEcdKV/y8mzG2EqYhYN2Tdjas/7H60Eyu3R2ACfuGtvPiCWAWWLOvOElZr34UVt1ci2lGj71Gj7n10qG9unks3yOLMJMrZrPofxf1FyI1OyzbBCk0CM9nftlur9n/fFzLoxiw3BZ+VoOiKb+54/nk4Edy5actvxXXqIfuxnQ3knijmhKxq7uHZuBiKRKFJKKis8+e45Age2asur+p5cdvOpik5ss86HfxtBjzQWbSQk/F6ZBeh7mvVkVNadB6na8SdQG9lUea16rSFAV6YyYqqjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxytWk+jybXR3cgfzcjYVZ5PS4AZYUVXNvsnrJk/hDM=;
 b=HuoZY9q/KtfrtcqBX4VNs5KE4EN46YICnPtttJP7V40W8KeSj5jCj7+ii8TZUbJK5RYfF53bjktxtHxgJ7EQERjv13CryhnfwzFfR2C2ZSAvMLROScApdH4FciEOQXbEycNsYfm9eHa8Z9llM2sE8d9lpbyJPp1A7sBfh6B6yHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 21:43:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 21:43:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dmaengine: fsl-edma: fix DMA channel leak in eDMAv4
Date: Mon, 27 Nov 2023 16:43:25 -0500
Message-Id: <20231127214325.2477247-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ff7b6f-fb85-4fba-34ca-08dbef91ebf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2t9TaNPUx6HULovB0LClphXJhMWHleYrwjsxElrE63u1oijp+2RNMzF/5ouUsUO86JJVIqpK+eXz9qO2iJWmEQ6sBwRY2UWegn2dhEOnG9LoB8GWU+UtWtZ8oLTU1qB8lR4XPfCqIxCJ8JHjIsk0d9kXONnosg0WbMdSIIg7ipVsit6V+TlRo/X/NpQZDCwdTSASDWBjwQdF2VJnVLTI8WLcZyL+DpZqc1YL4GbeMTMO1b69JeZ10L8IOKiG93j+jXw6A3BiqF+PcnDUDnn4uC8lpi6T7AAxIXHYZeD3LijALDi1+M4nCUcRkE6dZGjqm5+Z5X2U7ODHRHOL2EqkH77rNkro5hXr3UjMq3u1uoZXo7my2VbaAkgdrqLaP2fEWosTg+sywIrkSMyW9FzrwfvMlETA2vAjLvQiryrLOMA8eFgyT3oJuG7UfSuPEenO/ozLqklLS+HPOTWI7/vsl2SYy6/88Ke6q5ZA3MBklkCEUFisRY6JUCxTjPKem1JpgEzJN15SiY8fwPXv+iHIz6uAB+F1ix+9DFaelxFXsBNo3tf57qfY0YfqjYHGmE+ivFC2iho1pML7h9qpVvnh/sqOF895B3YhLdUK1IRBMuiUAbRAALy7enK4NuCmLdgP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(38350700005)(36756003)(86362001)(316002)(41300700001)(66476007)(66946007)(66556008)(8676002)(8936002)(5660300002)(2906002)(4744005)(6512007)(1076003)(6506007)(52116002)(2616005)(26005)(6486002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQbeuvE9fOc1lNJhZtAimMCTXEpmgeS9ZI+R9LcmJlRiY4aXUwHjAZJRjx9s?=
 =?us-ascii?Q?7X9MhonCu01bzIROIzxhCbzDqezuxPBLTv3Rt1PCF7WUb68QiONf2XmE3U75?=
 =?us-ascii?Q?+yhasPYKlvHaoGU+1KJxxfyKr1cICb6JyLctAQ0MdirvfXvSHU9J/qd2VR0J?=
 =?us-ascii?Q?PgAFdJ3tUyX/GsbEBreVU++EGM7TNzxpA3lSeDqJlKckyo/hm8FDn4tig1WU?=
 =?us-ascii?Q?O1+sLmrDBFxribiMxlqOCF7y/YTJZcqHkjfRXjnFvDEKubJXixasMsKB9dQD?=
 =?us-ascii?Q?nFV84Sfk01twGEAsxuSmXm2cdQK8DDbuNNFsopwyhdMhWWAkFfJ5OPvdIxWR?=
 =?us-ascii?Q?gkJBaPEqfKAatv8t+CZf2LnE0JzVnoCp0uBMvCpqeT6p/4qfWeabPhzUuXj6?=
 =?us-ascii?Q?q6V0N7LEcapITvUhhf1qpOgd6uqV1zxgpz3VteCJBmvvQA7qcUAzdf0PplTa?=
 =?us-ascii?Q?nBUlvtCZ0qq8dxaj6/gx+SOOl/YljFyT4oCne5a45lP4+eW3t/+rvJzWtQNv?=
 =?us-ascii?Q?mm87CW+70DTkXdJcD5rfY+fw1oQUtLp0caY8KBY/iQfrDqOcfJ6sk6mkW2Ig?=
 =?us-ascii?Q?/xYM2b/8rBAPhQ54X510lbyxQOjvM6r6eg2HErVbEj557YTS3hP/+BdByodt?=
 =?us-ascii?Q?8TIfO8OJbM5nbEDf3EpJsZ/Ih8MBtHAJr1GEvdVM6yk37PxrbN5Yxw4Gm4/H?=
 =?us-ascii?Q?3eyQJKpCttIV4kmgfc7Gl06/BCiYrbfmPVsW6b0HgLGu8KjxqRPIbqKcYcWK?=
 =?us-ascii?Q?pCFHO6jGnxVeUMpcCe6JNwNSFRQft4WU4l6cHGqACMewFgQpYASQTFubTBvT?=
 =?us-ascii?Q?LD3cY9l6FVIbs7SZ3b+3W/zLSsDNPGVmTlHh7ot5jhk+037yfVsfJtMis7Ns?=
 =?us-ascii?Q?psyxVQzd8dpLfZ1KuNHl9TL6fohifTrcHh1cipECtWUeWVBFXV9xt8tBbUic?=
 =?us-ascii?Q?6PRowZmJIBzm7VXwlJfVQaVJknvdER+HLZNOILT5Jmx5NbDPu7IVsSsf29Vm?=
 =?us-ascii?Q?ilk9qk6MNlvmU/vaaYc15eHEwsigTROB0DVwj4ohGvTBtcp/vRHuYeV8E4Cn?=
 =?us-ascii?Q?wL5MRYT9MwyN3kq5ATcZDz+aYOo630krl/XhjyLUY+mZ/S1KF57CqbT3I34A?=
 =?us-ascii?Q?mUuQrBoSDcDk/+HwqHyZyvBR1vnIfarSQ54y+L46nOWYV9cMdNIPgF9IyXnU?=
 =?us-ascii?Q?Htwy4B6X9wSHEtqVExcv04oM29Z5LzCF+qGaiUfjRDkda0BC4HGpy0BRczjC?=
 =?us-ascii?Q?U8REXpXr3dX8kM77cRBF5tc8t7AH2vhv7rkKw4feZdqmYc97N+G0slE3UHxw?=
 =?us-ascii?Q?lIkeYWZux1761ATT2bVeyhJGfEE0HG2m+aNzrNeuBE9bKDNcLPY8vw+O51CK?=
 =?us-ascii?Q?28inqIDW4cha6NZuD3Da3NEBN2pnA1m6+TbhRtuJ8XY8p3fKlnmnhXylONsy?=
 =?us-ascii?Q?PbEnr0cX7OIVtQ1DNrbJijPn2pFuXBBtDDpEMSSwPuBiUETmMqeC8mQWbbkf?=
 =?us-ascii?Q?MIaBEy2/ArV+39iam0DahuxWT5FHH33WIcdwL6hWnzP/EWWcVK55OjA/rTva?=
 =?us-ascii?Q?SY/4rdvT8JwNfF8lFe8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff7b6f-fb85-4fba-34ca-08dbef91ebf7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 21:43:41.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBOXeI4WHO/5N68lcto6xx1gB9gOtg90c2EA00E1sSqBBP5v2N0tyMNUo0r4REjdYZx0LjUWBibYOxV+eoT5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171

Allocate channel count consistently increases due to a missing source ID
(srcid) cleanup in the fsl_edma_free_chan_resources() function at imx93
eDMAv4.

Reset 'srcid' at fsl_edma_free_chan_resources().

Cc: stable@vger.kernel.org
Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 49e6cfc285029..c8acff09308fd 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -837,6 +837,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	dma_pool_destroy(fsl_chan->tcd_pool);
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
+	fsl_chan->srcid = 0;
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
-- 
2.34.1


