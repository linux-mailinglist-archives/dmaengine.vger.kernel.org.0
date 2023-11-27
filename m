Return-Path: <dmaengine+bounces-270-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DE7FADC7
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F2281B45
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537B48CFC;
	Mon, 27 Nov 2023 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KNjsphWA"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BA10E4;
	Mon, 27 Nov 2023 14:56:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwaLJcQIvm6XrvMMbInjVnzpTet4IV+XA4aI/md3vALT9V1QvY7fQu/T8IsKPFrkcOzVyn9JMcZVJYXqDt0ytSRIQIkCBdg6h0K8pbqcn1KgZGwyLPlVneY2C+IIigTLhcQNFdzTMdm6FsgR1viPis5thU/qA24J8eXW77XMuvXLs2Ournr32JbjitaZxGyKpeWfg4AL/P+XLke4Q705iTXSUqJ+Tcmz522XaMSnWnk5L+1yYbnJUKePHJfhaBkmv12R7zMyKjV+UyfPjMuB0FPK8nKfLagQTMqPOOrlpX366xsHtdr7bGrvMvUmmJR0QW7FGTF4VTdYeBy3kaLArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+zRSoV7LgvuOA6yhNiUe6i0nJhSsRxigx39PV4Jq7M=;
 b=R3tJ61GI+hWifQQMz3rqWrcYhnLipBkM2G0Z/oYdgyZOeV3FMbFpykKCMBpfpe1zo0XK1A4aPEyT40eIqlWhTMQrA2tZOHukGVrZyZHfVSO2WqpFKx+D4u4kN14u+QpoyVTgyFYUb0NX91aUBf8FbmZ0ae8mM2hGKhB2PFunyHS3Y3kY84Tv+rnfB0B926M2AaR+IOxJuEIDEZHhUkyNxlBAlkNsQm9/R0AbuEXOEBmiAhNjIXx/X+JYp98woYaa9Qw4pB4bYbMrzA5G4pYUvE0xMPwudiSLMn276ES1T6t3Pfy+cerm8H7YACBAOF7AerbCKr+McyciE+abSbUQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+zRSoV7LgvuOA6yhNiUe6i0nJhSsRxigx39PV4Jq7M=;
 b=KNjsphWACqRJTjMnmDcViuGTKk9hS2uf7KNC6mmcqL+AwETCsxJhgIP9Vv2Oh9FxycOpMiBv5e8XNAw7EtT+0gbmP4/t8lQGUnGEUx/sOIihaISqcTjBCzPD61we90eD8xUyXh/lWUn5vgBdMPndSnSFRKMH4m3Xl4uGZccCtdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v3 4/6] dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
Date: Mon, 27 Nov 2023 17:55:40 -0500
Message-Id: <20231127225542.2744711-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127225542.2744711-1-Frank.Li@nxp.com>
References: <20231127225542.2744711-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c3af9f-b6e7-4603-a5df-08dbef9c0f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mr1W+RjIhC9fb/nIR4HHKYx2pEkDv93ct9yis5iVKfuibvLp8nKtr29/5KIzHgycjfep38kl8DrUq1lou78jBby7BJEv7mTvImxNISE70Zw+reCf8s+2sqijwwVLQLpFfIBSiLUT5jbpWF1FkFQIBuQI9ZHEdONMpFewZe1Nlw4IPRBSW3u5q3tBT4IsBmdt3o+2PqwWOx+O0sXtSHcbiY+WDu/fGQ+XTNbo410DZl84DQdGspItQI99C0aF6UfMz6C7oPjpkMDQXPQwUMznklRJ+8ve+TWAP51JSMZUOuRZzWkTTFUtovAvq4tSYGCFfT2X3fu2GOcYWPs5mMwFlhajDKKsvIwlUeLYfNxNZA7socoU1isTbgyT8C3kpM3seF9rGTS0bCowGGBJFODh0p5m4rCWldE8uGhM38mz0z4OpJvCBv57MGGGdKl0/5yI572wQ64nD9DYOm2jyy+gRcUuEdOjSeaWBRKifDS519bJxxhhvrnB28oTcpg6vlHVEVw8II+8l2KsdC6GdDJai3TFIotHnxmtHYorMBrxMwkQRI8xwDfZ27Sm/fq0zPpLmHdt75u4X08ALNlKaEUARgjSgajGZ4Bu3aeNDCoCpSNkWiWwNj7BpX5i3HoTR6y0w6OafVXEBzRqzaODoJevYakpGMYtZpxJw4GaSSptFcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(38350700005)(2906002)(4744005)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hupsw5qqkza55Q8VVj40N/00FNrrJ91Q5VEKh/E5xZxXLDQJ5fXgIYIfCYvk?=
 =?us-ascii?Q?UiptTGKp/72wJhwm9Wh8b5mgzvQo/PdQ0HPSgMgzN/rokkmbXKjqpYtuazDK?=
 =?us-ascii?Q?PLVhjflJNsytooHI7rcT/n1ahz4zkfn2wuxe1YdbtEyddxAAcGi62QlXwQAW?=
 =?us-ascii?Q?2M0v+ZgSOkYBf0P5CUKxhjLwaA6heWB8c9l8wj6/LafnZ9yI5aiAxzlQ99Pc?=
 =?us-ascii?Q?goNGyNk8+VXvArbPyYiYXMueTb6ehrQe58UObDS/HSs55u8eHUyzqkxUnB8n?=
 =?us-ascii?Q?ZZt8LEa0Z8oe/Kh8nYqc3QQQn9LPD61VcgT5ffTBDe3Xtor/g6rgpYV463Lw?=
 =?us-ascii?Q?1c+Jl4+kA+MdrnKGWKBUhItY26n9Qp/auKWAhgWBF64F6EZSfZGmZmIPkCTU?=
 =?us-ascii?Q?mSKh/gnzRzt0BXvl6YJbSyRPv1lQu2upglZjaerKE+FhqlLJcdyGASmMQT+V?=
 =?us-ascii?Q?4sApJw0j0b1YHEzWBgy/cdL0Pz0gdTl0BMgGrhdzk7TH9HGTM+qhSacNfdf7?=
 =?us-ascii?Q?sAPO0q1iIw/1h2XkBlavNcCvVgvYFnGZUX8XBU8AATIdOTrAonXsCd54/fk3?=
 =?us-ascii?Q?AGchQPnuU5A5Eh5FqwPaW2ibmAAYuP+MTGtYCrcpWBKdXT6Hd7aVbmbK8fx+?=
 =?us-ascii?Q?giPGt3s7E2Y5D+EUkB3U3fW3uGIJ4FOl2X8q0hn9wuybTUvbEJTmmUAk7O3s?=
 =?us-ascii?Q?FzixooQMx+pOQKCaFBxMzebjGLs8MXirtovMgUqjGBfpp1Qo+ArMxUkx9cvT?=
 =?us-ascii?Q?ZwdqYUguRJ1qzn33fXDz/b2hExuA2uSCTG4Hw6w/YRIG1VAw0pY+Xb/27HpJ?=
 =?us-ascii?Q?yMq8Q8Zpyh4WJcdd8JrS+ex+u0bxNgN9NHbmdbCW0K9GO/KEDOb4pctc/vRu?=
 =?us-ascii?Q?oMxblhKkEHlMrYjSDBxbP4r12tedHqLzaOZbUV7cGwqY92QblikzzCXSpWpQ?=
 =?us-ascii?Q?HmnO9O6d2b7gtDZDKVbURNsjGpvWL5bm+C32AL2lWPMGR3pzsqQrBP+3TuW6?=
 =?us-ascii?Q?dUgMD1PmQfstWgbbl6sF76+I3DHbfiQrk3dJGp/TraJMeeCKz+drSYkYxd4n?=
 =?us-ascii?Q?nzWcoiM77HyfLdU+M880mlJINegYJ3IgWZ91RfDYnrWcTtwcnhlxGGtblKiT?=
 =?us-ascii?Q?5FlyZir/xVAz9G0sKivP2UdOsQXN+ot5+PUbjtO0ti2iOGQuSs3432U0PwCW?=
 =?us-ascii?Q?trNcWNXStW516NqQtgDBLGTYzqTTUYgubO9exJplbsIXBYEomYSOBdOfUV0j?=
 =?us-ascii?Q?ICLTjT+fYPn7mVat4KrakvybXyG+AJs4a+Ro44dX0yAQ+KO/cYCGCrGO/IGx?=
 =?us-ascii?Q?lCHJKDR5q7+SuaKrTzpfqciRPgmL6cJ4x09i6L95P+5OLPch4+8KWxpeoH4x?=
 =?us-ascii?Q?jvQMd77QUzAYuW9awdDWZKMvwdBHHyyPKzzEB+jtaq/e7Th2AoGM4IkV0d4B?=
 =?us-ascii?Q?fKjLLPCAYOEBi/pFmBkqB5bNFk2pieoGh/wQXVN3cgTIWGlJKxKd9Q6N5KQ9?=
 =?us-ascii?Q?BcxGiQ945lb1Xf3zaL3CcVsy2+b8XF0GFJF6KxqxWtMVUTXE995Intu+yVSY?=
 =?us-ascii?Q?4LDoDx5LQXzfDQXkfa0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c3af9f-b6e7-4603-a5df-08dbef9c0f07
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:15.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBs+f/g2PEkyXCTeqTTjAt5vKB0Cwk+s4IVt34gwCFzgHL3fg9dVcaGNoiy1uXg0XzywKhIVLxa9N++DkwUdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

The TCD structure has undergone modifications, incorporating fields
extended to 64 bits. When TCD64 is enabled, the TCD type shifts to
'void *'. Use of the edma_write_tcdreg() macro to facilitate TCD register
access.

Add cpu_to_le32(0) to ensure little-endian compatibility with TCD
registers and avoid a build warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mcf-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index ab21455d9c3a4..dba6317838767 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -202,7 +202,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
 		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
 				+ i * sizeof(struct fsl_edma_hw_tcd);
-		iowrite32(0x0, &mcf_chan->tcd->csr);
+		edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
 	}
 
 	iowrite32(~0, regs->inth);
-- 
2.34.1


