Return-Path: <dmaengine+bounces-271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093587FADCC
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398B91C20B55
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7748CE8;
	Mon, 27 Nov 2023 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pEoSUnuA"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20A19A6;
	Mon, 27 Nov 2023 14:56:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghZEWoKOKeoIU+FI/DUK8OF5Wj3N1mCwYPc4TF+S2hyHe598+/PZSYT38s2hKmthlNlUhosreKMDdPieceFMkg7uBSUPonEBg6JIDVKp4iAWIp3dROuTDoKzWYbdf3Q+xqHyp1M9V2tht5VuvSh/NkUUxuu6cjZfFqQaGkhlquJCGYHIL78YaeUivKvtLPFfjL5YWB5PvqlsOtxFqxM0DVjCKUVfp8NsLwYPlV7xGCcjabjPdZFUeT7/Q3yp8WpgMPkZJP0tPBc5azWRyM5wBsVcx7WHosjj4N+OSgX4YJUb2CG/3wdq57ipoLtupGR98CpDS8QPswY1Uqqd0AfOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvWEH8TpUyOz5PnKH9wjxMICSByFjoiIVqDIjBVbGnE=;
 b=dV/MQdD6fzwj80mZvaIgEFH+R7fobZ+NFzat7g1LozgOhONnZqYZYA29mwELEERbB0TtFPoIl/Ub7ayRy61JFfyEz/OrKbz3xPw9nfiEn3PgQLtQ22DJpioSQP8SK7IC3+7aoL5Ybq55Qw2aP9dnFb7f8lU3dPciM4SXM2bHyfIiF0T+TcO3xV8QZVPcYusyXCEsx/Yq09CSU/65oIzdRhotLzjKF1+XW3bLDAphTEjSGxezbfjotK2Y/KtwaMYN1mY+j48Minrdr3YHyFAOLWgDmmAmwObC6Q2dyu0NINnftn+r1FkKIwT5T8LR14NH8gdsyVla+eiMVYgOxNvk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvWEH8TpUyOz5PnKH9wjxMICSByFjoiIVqDIjBVbGnE=;
 b=pEoSUnuAZuEsvBhYwNi37LwmGTkH6d8Ta/ZtVcxubvWgyXlKbQM7UU926ejdNSaP75O3Z+jkfr7KIw3/JLbszGfERXcxbJd7lD/BpA++m+UCvC+OfWxFm0Omj+f3hmIYLXr6kpT87gmueavJU1+BTNCmKiuMEBA8xNFTpLQQ7MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:19 +0000
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
Subject: [PATCH v3 5/6] dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
Date: Mon, 27 Nov 2023 17:55:41 -0500
Message-Id: <20231127225542.2744711-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dad4bea2-468b-4f59-882f-08dbef9c1173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mMGp3RRJDqaDeh8S/SAUiQsOW48gEV0QWxklI8LIKQpFmF4v8TPC2Y5PCxLuaOUpkL1MeZXT9m8ryFQ0a+byS9edAxh4YKub+Off74o5Ksb2rQnnPH305xxM/oF13QaUPxcZTqNhyuZ1xBLvRVUc6xIDfx0HqFqtuXLD3RCSlSIYggRM/1JT2yD1s20fcDd98A3aWsFM1AY8OyfENPXiBa5oOhVb3PCExHFSoWudPzwqCtGvsQ02UoPeEeCroDlw8ZtuBmR3yKkayqnnPyQ160s0SxRNVfkB6WSvfrHanyRQKUaYxTjHno+lwzeBRAXRw0ue97ql/bb+quLq/prLE6bfN2QznoQfwISJsUYTZMig2mXcK6sOS8GVx2O7QzrdJb5sKrNdDIov3v+sAJ0eLuDaeiGyla4SCC+FsaQTSUDP9eSQQKbIwNmjQ0xYX9G1Sn6ISz1lUsHOvx2M0UtemB4FZMbGBTC6dGSXLtjpSEisBwQP0X6Vp7Xz0gk+xKEnJj3s9Ol6fDxEwAQUQz+E89bXI0EEwQPydEV9eE3nj4WfK/5R2a0xXWySZvIt22JyRoArLr8BHoChiWxVBlaOyP/DHdFhKKgB7ZdDMxmCkE1790a/tRFOnVkGCnc7FoZv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(6512007)(38350700005)(2906002)(4744005)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?luWGbVhPslpe0qqoNreIdakozAO8y6rw2KyRP7hbLPXTj8QUcPmIbkS/UeTr?=
 =?us-ascii?Q?bIzS8OY3JdQes0bdll2YXZTl6z3Z2f2fYAbjBr4C2pm5fY7uM5ati+xw+wFX?=
 =?us-ascii?Q?6y1sd0chLE3QOp8IPpy+OnuiucNt9y65lMFTKh8e1NAEgSPU75NETq3NYWA1?=
 =?us-ascii?Q?M+s6jpPkauFWXcfDzceYaeA8bPLLem4IJf8gZ/SUzqPTej16iNHPQLEbbXxP?=
 =?us-ascii?Q?OlXOQ0rMtA3KsBI5CCayOFXdvFhFBGF6QADA18K9+A2zq2kU9DVHZ7IviU3q?=
 =?us-ascii?Q?bsEjMDsjdtSWCOs8m3xKHZaASIuKvEAzGVi+qby4C81AolCMcZdWJNRJjk+b?=
 =?us-ascii?Q?9yKJrOEqPXQNQ3wtqq7CmDJsTx2fne2Zd7YwRDxtzK0yeP+Z2Tlk8yV0sgM9?=
 =?us-ascii?Q?EdKDctoy7B6b5YcLhcRsIVMWgalcEGuyMkCaUF/DpCr4oKg3wWSwuMAVZAdo?=
 =?us-ascii?Q?56OSgIgBV27xYgGe3Itf5RIHhJvwHE/lb3YXM3N1FsnCRY+Mtz8nmhiqA79+?=
 =?us-ascii?Q?4bANZ/hTP9/m+RCuj9P4/SiCMB4X+UJeta2MKPB7/1hbL4VZIwyaTIbF2ntm?=
 =?us-ascii?Q?vyq+RNq2cwqmYDCb0qs/7ZqNgzztC8ldOe86j/GKqdu3Nfsh9+U9IYVex9L8?=
 =?us-ascii?Q?qTUWVP73aFEBLmszmXfs7Ee0lF2M7MWQ4v3gRPe6YhWercFaK9PORSNiYjzv?=
 =?us-ascii?Q?OhZ2wN8AAhBsP9TwtqUuw9lSrijr6jVnZsIqxgGayLq0nj88RH2Y8R8Az8yL?=
 =?us-ascii?Q?3RI3lXrdyRxFIKnVSWLNkT9KBi2ehn8iBN8yXd+pfUgt8TC7+GWPGXl2Dfzn?=
 =?us-ascii?Q?WBLNAS71ah6AyZfGwguSXk8OVtPyt35APoQuwz7F15xgu+jASmQyo65N2z5g?=
 =?us-ascii?Q?hbgSiqgZksyxQuPFHbvR56vtf4rSKWk1QmKigyDWVOfYHYEmqRMr9rYGtFd2?=
 =?us-ascii?Q?nTnpSLr/XzQgfmz0xaKKPiwZ1y6WFKCRW9mfI61QQBPmLLJMFmaTjK8BGzo/?=
 =?us-ascii?Q?LrkgadU8CMeMPpaeeGZYcpTmaAhub+3Wv42UCQuFgxznoRF65TExux1Gs8x3?=
 =?us-ascii?Q?0GbwB8qmynWAshMmWJPOuZwfO0QuDqJMGAh600+Ebn3mI00ynp2axYt3jxiY?=
 =?us-ascii?Q?TPhZDUu4bOWeZmjRvywg429rHfIDa5tV1fn003Q/DiCZN6jzb+iAPpSLtDwB?=
 =?us-ascii?Q?PTrRSQLgqN2eFzkaeZw29vk4QvK2Vbyw/hfP5kEh16dZefTKr0bCQXLXcYYG?=
 =?us-ascii?Q?UL2g2vNae5o8nNKLIJpYG95qk5BXj+xYW4ScpMEa+Xh1dLcQIZx46c2NVrED?=
 =?us-ascii?Q?tihfN6ryyyhRXcq9A6Vrq27PsZsIsQhIKzJN397Ln5+6QMnOX6ZqNzlyvGIv?=
 =?us-ascii?Q?ECAIFRL/r0AcwmlCTWrfen/ivgobjt5gHRSAvCjolnIFrVx2DV160hsEj4vw?=
 =?us-ascii?Q?JGY8g1IggKmGZ6DHjojfY+4jmf8GROsTZsVhmg+mpsmpgwcy9Fx2F5KOhX9+?=
 =?us-ascii?Q?Jj8zUcI32HUCMPyAFHvq7NCa61wIXnOkv9zpLOOcnFuZCOqBZMl69/YMY1wy?=
 =?us-ascii?Q?OyMc6DBYO2qjRqyvp6Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad4bea2-468b-4f59-882f-08dbef9c1173
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:19.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCeIcnKVdPicsaQrkQsggKd/keZpVY/v/AXI76+ht8ffoL13PRNxP54sJEh5Kq0Si5JNDLRiFfKdzgRiXv541g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

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


