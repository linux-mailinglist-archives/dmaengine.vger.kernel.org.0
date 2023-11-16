Return-Path: <dmaengine+bounces-123-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D467EE941
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 23:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8792811EE
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E60315B3;
	Thu, 16 Nov 2023 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdYm/w++"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD24D56;
	Thu, 16 Nov 2023 14:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIlRplRaGEolorjiFLxFUAupEyoDfEM6CjuPSIUe4qnwbtViHdGMJFd31L9ahnKSbNbL5TO7V6aZIHDk8BRBx5ldlOQcay4sodr4aIt/VHYv7r4Mc6X+MTF0kKbPXrOS7+R1hpxpS7oxHKeTlBKKxFIpvOYPcklnfZYMzZsNEMQbYdm84XeWj48pFTB4WNalfIjKdsLVU4Dny4C4w/w57ObbyEP1T6VOxJyIoqusCTt8cVmbfe6gwdSPwRQ6LxO4GdLomffUQfNS48Vt930s5lWPqniFmg7WdZaGuMzm7vI/mFtUKck6/Tk9H/px2jl44oKHDIl62vs0IJ/eaMFzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvWEH8TpUyOz5PnKH9wjxMICSByFjoiIVqDIjBVbGnE=;
 b=WNO4zqb2RN0qSyUCL9H00p9yfZF5Bl3xmQ0DaV1tlzG0D3lJWB/xGhoiiXwk5mRNyQMFP1iVHDq1juBHCoXtDld/5KNA0FK7Ujqh4low7TRLyGcZky08OtG6ZjYHA1rDD48Zf83ZLoZCFf5G3/jWKWP7i33lJaXRNkM5WK1/ndtJ+6STT9L4k+ufXw1dbHScdKyzVVAR6NLHf20U5IMnN1AU6W/1Za+Z0an0G+FubxC5fNyN2A86F6wG3Qr3Q6N2pLJklfUC6dP3BhjQ5wh9OeurmJ+H+aZlCKjRrFXu3fX4I1LRkjg8Bgjj1tJupxQU6T17UbUOBxlpEie+1DRtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvWEH8TpUyOz5PnKH9wjxMICSByFjoiIVqDIjBVbGnE=;
 b=SdYm/w++V2Wx6y7Q85f6PhfcTZum7/NBy1e0f5gQWaP9wOFRj77AzVNgmKvIlni+i4PhF6xhFEtrtOOMI0l5QIszRaz441eg20ieAAUObsRohECEXX+aaG7wM4BJmPbjRxrMw2Qt5GltOCQwvxW3g+eDPIETCt8SqW375CHb5Y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:28:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf%3]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 22:28:14 +0000
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
Subject: [PATCH v2 4/5] dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
Date: Thu, 16 Nov 2023 17:27:42 -0500
Message-Id: <20231116222743.2984776-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116222743.2984776-1-Frank.Li@nxp.com>
References: <20231116222743.2984776-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: dd382790-56dd-4992-8a3e-08dbe6f35281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rSWJiYsFXy3+Z1GE0xcPCyRbZbI23exURVJZ4ZQB9G+y70GIR1PitFYZYL/dapCY/X5ITYU0AiaqaHuzRfeXBlvnc8dy/GMsgnGxri2Ex7J8t0T57jzl/R20Fob53oUBLwM2FN8y1nuuadO5RQbS+AzgMUd6Zd3jWMCYA1YiXfoTx8muIOHbVMTIN7HVk8ZrWCdvyURmvdSTX1IYZB2frPQUVbLVVW+44I/14D7jgF0R9o/2WTbTopKeixLJ0z+6pBIejoQgwNEvhxmsMsYC7yEHkjlFMIQXXln3sgqmj4GYc+7SwmwE/pDgqkYmT7aLNdxh/LO4mtHUakvW5jVJDiDKtNghhT1i3kdgBqYctpdaNayZL59A20/cN4fqbm1+FM9yrKUbuIkODF/aulxF5fGPlu5OmzzxfOqAO/IqJtdqxH/5+a3DE12BPs8xPHfvuc/aAnjZjO38Cpn6NAoTtCSqK6AOxxrhnP+Vq5D4E33WPCxxz2m4T7DgPHjKCA6/SQEvgzcxjNIHPHoFbOx5U33y2jg3Rc6pMkrGBOIaqlR9UBMoJT4lXVHumHYncvV28o/7ONEgDKQnxC7Zz/ooSCIOKRrARUf2MhMcm5tGP8MlHaHImH4Lnzv6CXnyqZd1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6666004)(2906002)(2616005)(6506007)(5660300002)(52116002)(86362001)(8676002)(4326008)(8936002)(4744005)(6512007)(66476007)(66946007)(66556008)(316002)(41300700001)(38100700002)(26005)(36756003)(38350700005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mUnTNE4a3es6GpIin7JW7Kv3mwotz+c2aw2D/PITpPiWTE0St3U/ambPWbSM?=
 =?us-ascii?Q?nokhw04hL8j7QNpbzmpNRL1ZYjs0/PrPrRiFF6Nwb7ZOILW5XCzZXtkuXg0S?=
 =?us-ascii?Q?9Jc0uYNaNgqi/fK2t9FTr76qIaffKwtNsQenPW5NgJAewceJpqKMdgHxwpO6?=
 =?us-ascii?Q?aa1hd0F+48s9BsmiyvTece5emXYoFV3jnXHaxY3ADU59foGjqYDUMx/CjGA5?=
 =?us-ascii?Q?RYS8Ccno+02e+qenv2XLbaFcudvgi4wewFrrQpKNRYyMx/eEM9nEyDuYk6JU?=
 =?us-ascii?Q?RlqvNqmR99i9EzniyM6S6UfBnkLbcXVSbL/gDPNRscJG6+Lt3y0Edwi6xTDj?=
 =?us-ascii?Q?Z36DteYVN1AADPEzsbzRSv3nvNtfl2I4XJmsfnOggVeorxgVLnfZqOpPLDYv?=
 =?us-ascii?Q?nLGII41hduAw5iAfS/mb17Yc8YdpElkY0M6vp/9PGLawpV+LY5Rix4HZZsxf?=
 =?us-ascii?Q?mj8oZLo3W2UC+qaRSrMhVKms5YGdmvHTFzqDIQeiVbGBfPQFiGGM+Xd3ubR3?=
 =?us-ascii?Q?PwGLgOBM9hTjz3dv/haymMVWODGziUrxofBJ0jB00y+N+2YVy8Oelfgi63ks?=
 =?us-ascii?Q?vdgVi6X//wIY+G/3MImNwbJzq1vQiNA3kLY9zSuVk6QuMQ4EPJVFyzO3qBgc?=
 =?us-ascii?Q?sbsY8PSxhefRR6T5Lj0278MEq0ua3OuVB6u1Z9OZsA8z7Yb3R0RedZ//mnwR?=
 =?us-ascii?Q?Yq59HGc+FP8WZ0d1pqU5Uqs8nWXGE5M6v2C3JnunM/rPvCgibNhaipmOMUbB?=
 =?us-ascii?Q?sVLFiRfhHbdNY1yI/AkgFd9KlO8zBJi4WmPfxBBXYL1jSDWR2sGOMsLP4k/T?=
 =?us-ascii?Q?fhkBA0Gd6H0Ww7hCGN/9zoIb7y+2G7O065tcn0xwLQozEB7pwnCjPhcNZknS?=
 =?us-ascii?Q?JsqVK//pMtFiSNbSNk32cmfBhkjr/6RONXDfxruwwFpfRifaifL5+YyXL8mn?=
 =?us-ascii?Q?xwPzzu4WS69dcwDyWt9gyQciR3ZCC7XNq8LUnoOipLYIP/8qPpa9BFMWjpk5?=
 =?us-ascii?Q?aTg+sdjnTh+vxk6qXFpKz5LbSR7uIbf55MkpTEqdyCsCIIHlQykoNXnUk1Y/?=
 =?us-ascii?Q?bGajQy6b1wMY05HwkAXKc5QVcsGwtwZovDsILU8KLOlroURtnOHqVD28bqSx?=
 =?us-ascii?Q?QQidK2qkcp3qJS2fnyNqmsCqs7nayVtiasmI2D/Ufop7IE0ScBLkvbIsTqdP?=
 =?us-ascii?Q?7iEJLwjer1gS4dukQRcD6Q+zmHNr1aj/o4wV2CG9m8CAMTD7hvRlFdHry3gu?=
 =?us-ascii?Q?LEkfiF+tionR2FJGZ8l34/+UuolEkL/lPMU9yNmtx02cOq/uGEy+y5wmUrRs?=
 =?us-ascii?Q?/G7ZfTvvnPlPrOh3Q69iFEtQdQLgXJcd6ZQAvryQQG4ebDwDm4o27EGqVCoA?=
 =?us-ascii?Q?dKQzcwozeGuzSZNkk8oEQloOedA+xYYFa3Eak+Dtq6NObfMgOIHIFbBFuFqE?=
 =?us-ascii?Q?gXcczxkEQPgZU/FjoDPejK3JQVOdSfFtnngKzl3rmsXAB1fFWDZC+E5N++Aj?=
 =?us-ascii?Q?HUTCu/mVC79+671DqPi440+xfcS0N2bbivjxLUQWwDKpya/P4IdvLIP722zh?=
 =?us-ascii?Q?aJ/9nj9xsRQYq2pkDEPl1DN74pTGjr9np8K1fGqZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd382790-56dd-4992-8a3e-08dbe6f35281
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:28:14.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQD8NUvHOP3ddAOUg+hBJKXgfziW59Gd+DZypPyr4JM4viJcI/FahtxywqOTEM0V+9/vacVaMFw4rfPgJLv9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

Add the compatible string 'fsl,imx95-edma5' to support the i.MX95's eDMA,
which features 64-bit physical address support.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 437db0c62339f..aa51d278cb67b 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -25,6 +25,7 @@ properties:
           - fsl,imx8qm-edma
           - fsl,imx93-edma3
           - fsl,imx93-edma4
+          - fsl,imx95-edma5
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
@@ -83,6 +84,7 @@ allOf:
               - fsl,imx8qm-edma
               - fsl,imx93-edma3
               - fsl,imx93-edma4
+              - fsl,imx95-edma5
     then:
       properties:
         "#dma-cells":
-- 
2.34.1


