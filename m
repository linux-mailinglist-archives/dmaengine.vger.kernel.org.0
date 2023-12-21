Return-Path: <dmaengine+bounces-606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0881BAED
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A711C243AA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEAA58212;
	Thu, 21 Dec 2023 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oUlNEx9S"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A860539F4;
	Thu, 21 Dec 2023 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK1ARgK6vUf2TOmXgfZPjd93MhbrWF6sndkxLaJxdb551Yind98UdbuhYfHiC/J8Gfqvp8eAh1CgqUiB63W73uUrE+KVrVbFypkobX/Be0R5l0SF16dQFIrGylr397OYpBhQARshh/IiRlffvG7qimOm755i9Ib+i7O6TusBR7sl7BOgnTlS7+7QfVF2iwhEP9ok5qqql2+FmYb+aopSj9Az7EGvyOxl0PHCrGUoJik+YMu/nbMKsxhHU9fW8OtGPs/RYn1+59JoMnblDzLqB65pfnkcXsFrJaaGKJVDLqrHBK/zbc+fDTbpDantLKJ3lnfysCUANLbVqGelMJHgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+zRSoV7LgvuOA6yhNiUe6i0nJhSsRxigx39PV4Jq7M=;
 b=isxQSTWMIdYRsDDxo2RGqRJBuyjgeD9QZbqY0Dk28o9IZ0q+x9CXBdarVX6pZqWwrbOK13k9DPeYgdju2iw602M+SykkqGucuw1oK5dQW537Ya58hyUYTT2kp2htIVWlAzGa+CEoDtjP1Fs9kQ3iItboLzNG0OUlwgY8V0DB/0fKE2gDE0SxhdRgT9NycT7/ehSi//86dPmZlWZ9p8/WOlRFHkxp7eQdDxj++seagsGd0sHWwLV4d4S+gqx97giQ5hQjPPohogz/YNIhQTRxsc9YO76YFRem6tRZavjnYjlfjsLyqL94p86iADVdu+WMAQJZ1cvCZy4oPKtaSBoKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+zRSoV7LgvuOA6yhNiUe6i0nJhSsRxigx39PV4Jq7M=;
 b=oUlNEx9SqowkOhg7k4LCVkVN2WIzfOiN50JvDTFrEx04gRO+NDb6NTTvSbRHY4Xl6EeZWofqvnQC6wjtJRL+EoYkx5n04vvIELDK1TvLBVD4sbkxB1aZr8IDYNdHxkdhPnABsG8/48SLXFvzqeU/0QCMW+CWSndeELNYTsocE/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:35:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:35:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: joy.zou@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v4 4/6] dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
Date: Thu, 21 Dec 2023 10:35:26 -0500
Message-Id: <20231221153528.1588049-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa473bc-f2ab-40f8-e141-08dc023a8723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8wsSDykpaQ23GtlynDBIMfBusz0kNyEP8baiBuUgOltWncDnC63uX07ixaIbvB6pLZWq+k/CjOBDwbWc42w1Cc4t9bmtIXrw1ZQkEeoyq4qWET43Uj0bc3FhXiJe/b7rYd/jNyTh5md0B3+TYNmfjAx87X0V4TRhjhtrvLqciNh93CObtuwz0+F6/Hl6OueDSrWAvLZlu/LRBfUw2Kfhx/S5mh2/es2atrwfzBIB2ldhoNvJWie0LYlLwEY71mXuV2hNaEalP/d12L4MweGj5pmkYmaznqkgX/k+YlpEseeO3qYd+5fgYkUei99l4xLC/sri5n0sxw4BzG4E3KZL5Vc77z/+dL0jlMJS71CoyTHkiBk+KFtJtENZ+GbC4PlOUFGR4IR4nXyjPlwkWIA8wc193jNX4c7M3xz7HBOdAgnTVkdpyJ5aMXOZOnWFHw9O7UiFI1LWhcWwnPuSDJoN99UJvI35NcSqrS/uOVY0/08s8wgOPfPH0Hnc3+P+91G1UUONrTVRs6i1CxYEmYcyyVpNLRcQvtctUgPQO4o81R4uQEP22EkOXyJkDDMyadX9j78YSFB90sc14QwMzVUdjL5RfkNO4OPyosCYgZUvJ4AeKiVRHp9Zry8dhFkHr4y8OKMcvASNm5VULBfJpP6YuBD8rccj3BpbP5DrXKO+XQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(83380400001)(8676002)(8936002)(41300700001)(2906002)(4744005)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Uu/8U9THeLX5/c2MriUISC4IRTMinAUPe/PlZK5MJ/eosE9qpn7ea9kVv/R?=
 =?us-ascii?Q?gBctsNp0YOq5m8mYQNAhVVXXSHB2HmLYilfGhATcx//XzD+4nLWx+mueNba+?=
 =?us-ascii?Q?HryY1t7vie+hmBV3FvYgs1VhiVW+0EFveJ9eoljQ+tHYTl/JdbplChtP1y0N?=
 =?us-ascii?Q?+0LQh659AWtHeQIEacjqLksZttuW8K0dAhrjrDdq/HUw4uzsZJZgioS/B5Oj?=
 =?us-ascii?Q?nxrGrBaluLQH22EaNn0u6jxdSPXfryktHGdcrrmK9OG/VIk8aA/PXTzkMtAD?=
 =?us-ascii?Q?Y2T/3u0Lh3LgOm9D2uHEQc+RXazfQjvGgUsFP2YoHPKFxhFk4YJVo9ThvoZn?=
 =?us-ascii?Q?qpkrg0zXY6Z26Y5gkFIHYn/m9L5C6zN6dQgPe8f0jXj5aU08kEcGiPZrxVQm?=
 =?us-ascii?Q?0hQNy0UGwAIaC9REJUuUsOvo/q74yBoEPuUC5vjDrztnXtpq15y6gwvDWiB1?=
 =?us-ascii?Q?eeAhEyE8222BghWISVKfoxF/L5lJomjKtDxqpaMYuQzW6M7bEkJpzgc24Zhz?=
 =?us-ascii?Q?89Ys4QzKpB6h6eDJjcSj8+rQbpq8kTEGm2rERSOuQHDte1kWfTGMHYZhqvFv?=
 =?us-ascii?Q?CYKBt0Sqs3C1v8BGjfprG0WzKHrm+Xh3VSnRiemWhbiuApt4Bn5NCEaNdxtL?=
 =?us-ascii?Q?9jER3uRukV/L7UGpPs5WzY9yHF8cI98O8GMPq46WgNU+lGDlGFitV1sihlq4?=
 =?us-ascii?Q?KFP54Cxg1gw0UBKK7tweiv7ECaR563uiT1oNANS8MB3fdJLz9Gg24tzRuVmH?=
 =?us-ascii?Q?Lw7ZJKMcNwCnm/iKOFpXZVA4XJ+yenkNJy07wJzhCfRIOBkxMttbWBBMd0FR?=
 =?us-ascii?Q?Tz0kQB5bvDGRrR6IUbN+c4RWNrESc5RHvCCpEjfuEsIoJTMO/oTUjglQpXig?=
 =?us-ascii?Q?t44Mb8XvYKL5lOT+FSIwzV0mQpl+3pztQA81TL/6JoN6XKGQs/QFfQlqjJRu?=
 =?us-ascii?Q?9efYpdUmB9+MEi+oLjdteTAB0Z3wHno8AZ0TRH2NWHcLHBP/HkZr69/y6iHq?=
 =?us-ascii?Q?zEwbtlAbD32CwFgdB0fdDJf0Vu7LQ+fanq2GX6rrdnB5wQ4KqZsNjeIVK5Vt?=
 =?us-ascii?Q?xrLpHhiTzZk74ojhPYLLz6f9J8sinaTta+wfltwMV3tUwGIMzCVWnm7DYFYC?=
 =?us-ascii?Q?iWf3Q4EWrU2tARl8acY+TzkNmE38/YCOhDe2SxPH9XNPsGYJCApbRWLjVLXN?=
 =?us-ascii?Q?71Sr6iXmw1p8c3k9G94Bu6wl+hAGEtDnKiclSErgleM/zk0HoCG4BSlKU1sG?=
 =?us-ascii?Q?4mXzoDeXiyINAeQMDrNvjvChIUthG+F67wVIXa2Ekl1ERjhh9Pl6dML203n0?=
 =?us-ascii?Q?P92MhcHngCOJV0z10yjJHl4OabDylWtQhQtzBw76oOQoyK/BtT0LZ5P1ddN3?=
 =?us-ascii?Q?1cTxO6WXvDhVzDuPMJrW95UqkzSXXk8vJUc5BPMMIlicUTrPmJ+ymeFeEFBO?=
 =?us-ascii?Q?Ipix9Osj/A9e5rMIMU8vP0fzrKrJ+XeQYvSOS14p/hJz8rkkHmcxGmYWdvGD?=
 =?us-ascii?Q?p8Qsfgv2G9dLPPyHeMANc3lAhQHNFstKNVa1HNZ6mt1l6+CPF8knHhqDEL6T?=
 =?us-ascii?Q?9Y0KfHmcLMGhOB2goeSel2dNgrNHXUQ5Ti8XwAVr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa473bc-f2ab-40f8-e141-08dc023a8723
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:35:58.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjySaDMa9scJ2PQjkZG69edJ/nWwLPnFwts7uJnJiIiXM/8JSn0fGN0NIk92XMC+XOqFpqLk87ucN3dseI49Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

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


