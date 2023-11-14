Return-Path: <dmaengine+bounces-113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E47EB411
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271B81F25273
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AFF41770;
	Tue, 14 Nov 2023 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/42wZXr"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DA41761;
	Tue, 14 Nov 2023 15:48:54 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6C12F;
	Tue, 14 Nov 2023 07:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVv53oJCfnOq0FLbMyCyBETDBjPmf2onPdaRQMmOFzc1bEghnC3t9OVauNrd+uINCUmpyfleQGmHLY+/daGIIFRZAClqq5HhQMkfAVf0k4rzSaPBp+AFTW9bxP4EfwrDegTpUfOLXT8FGPiUOyS9ALYf3fH1vpJQ1+CQ9sJ6LyqrFM6ZAKya0Ibggs/RvA6uWUPf+pGMD1/wxkC3RiMvsAT8JGqEzVHFz3rbyxKH8QjgO7rMLAjaaPr5dBZ6PkVnzclz93usoK54EIQAxnLpnY/TE2UdwRsJVPpnZSMDz5laXEASBF03Xld2tysq+VoFSK7j54pw6x+Neu9Bp1KOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95cUwS0vKJDzzxXLzF7IYWyGJ9mITiC5TUqKbauSppY=;
 b=ghYmkenX76WwbawPKmScMIx4SbIXY8KOYyvfNfoqG/t6OYUdSqzY61Okb4liX8tzR5sRXedlfHsvOkQ0j0pacT1os15go0JA6fPQNMYhb/GUVQ6OS+UXDLwOzu/pcLMf1JnI4CnD54lZSnNc/Qi+Aj8Jn3tcUxCEqlJW/jWdt8o1ZpQ4f46pTtiv2P9w3htQt+FfTGpKPOdsvehWFbg7yWAit39Izq41q2SzaDRpY3njSCFL+1uI7E2fO2CZDGKRZPlxh57xiAvKg9XzAwM+mqaf5VA5mdTMx/GL9Wk4C39qffTLKJzTtk2Ou9Hy8A6WqzoeO3E4Fxwxb8EFA4qLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95cUwS0vKJDzzxXLzF7IYWyGJ9mITiC5TUqKbauSppY=;
 b=C/42wZXrUTQx8E7TtHxELZS3btv0Ca6NEGwo3GwxJmU/t2wIJ3fgOrwlSe6m6X5KC+Bj0rSVau6fNt2qbzJAJJqfG9FBDGanApjxYk+1TrsEnYr6t10NPCNVQ3k3gvR6ulyJVs9YMZDpSP3D0n1/i+Rm744/KK4uJjdTk7JasSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:48:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:48:51 +0000
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
Subject: [PATCH 2/4] dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in dts
Date: Tue, 14 Nov 2023 10:48:22 -0500
Message-Id: <20231114154824.3617255-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1db399ea-7ed0-49f7-fc5f-08dbe52932e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7+ahv/otMtGYlufskv/n/Ucthoa2INYeXtPnB/1NCa4aL7Gnfcy7oxX+o+n6Fu2F2INk9gUz/gtW+I1m26hkwICaqFqjjM06JJ61Pi93vn7o6e1EoHR+vQ1QHGIz8yRNwS1gmoit1181p8+5Ulu3UK8yJgdbTXD4YEQKCi93SuKEWwBrU39jsLuSjL2D+F/3yzMtLRgI/luIumH9Eo9QBzPj8d93wqc/IDE1DhybcAPth9D3wDBNeg9c3caHmxiAmg8gjDzFHtvRX3agzE6xvQS9R+QKRzYRFQp8U1rbKsZHxp6JQoHCd/Gpq9QYUcGUQac6er2+Dcg2UfsCBwjyvI1rdZqMcYeoihGq/QjPMYi4tajDj/m6HKOprfUwW/hro3pJBKlrgF+TomUdzlU/LI7we5x5Qhyj3YfhP+q4vRcRj/zhH+zUcflG8L1zUqfAkY2g0sC9dr3as1aFq4LyTquZ0cgUSYFD7KBylbGdssc0s2eGTvsxqb7sAWE1QHVHgw1x41T10kRWlyDD3WBnoIsK/HfXUZ7Lb4w8KuDBgHP4kHO9HYgKwcub6aWaaTuPDGnVIbDrxI4ns635gmyVBtXblRjjSCHoxaPluM2e/MxDeBD9mKziLW3PY2netGjy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(1076003)(2616005)(38350700005)(26005)(478600001)(52116002)(6666004)(6506007)(6512007)(6486002)(2906002)(38100700002)(8676002)(8936002)(4326008)(36756003)(41300700001)(5660300002)(86362001)(7416002)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYwWSY3ZlPktqJQP5LeavmTqsMvMjmk1p01wOE4+63+7gsgieyYsf90JBALC?=
 =?us-ascii?Q?ek+LCkXJhMjOlc8HiLVhRZ5dEfninRsOqfY12VAVue26rf+Tgj4Am5WMu9ez?=
 =?us-ascii?Q?GO0OUZcn0kHJRWElJarbj5pO3Bg7usPiC5BWZ7NKFGXmuvpkkpUf2EmBjfz4?=
 =?us-ascii?Q?PnLoS7+Wqy3UFnveKFub8Fo6Ig5NvFqFXbYVynjejuhoBmkL4ybyxzLSPchq?=
 =?us-ascii?Q?S3fYD3IW9e6Lc81iOCy/fnCkFw0YSsXlYy3voLxBwYaZT5dOHDj8Xd5rf0dp?=
 =?us-ascii?Q?riww4/8NWSQPRgf2LwThGMyWnpKX3d6gTO3u2Sf+nKWe+QVt3bPUf+sR7XlE?=
 =?us-ascii?Q?k3IqDYrYBHtK6Wf/pND+roIbJTvV3cHgaqLdgsW5J+/3ha9N22af4UxyLjqX?=
 =?us-ascii?Q?7UvzEL2Saog46B9o9sAegl9qxCyeA7S7SYPvxeaKZk+jnek1C1r/uaoe9pnu?=
 =?us-ascii?Q?p+DW89G7j7mp0UY4L/6HkdKBipPz0YK6SZ76Nl49wP6qL0iIIhJ52wmzd+eq?=
 =?us-ascii?Q?p95fp1Z2okMDC0DQS4OzGU7OlSEvIFS9gVzAJzJNe/rXr7P0RUnhYLvCpYjI?=
 =?us-ascii?Q?yucAlAEhFG/rM3hTOsoRLbm+P+GYoWpqFz98LOeDaLQ7okp5GmMBarafuD2o?=
 =?us-ascii?Q?WsVwU/K36Ger3RJT688/KPUzi356S+V9XJ9KWi9NQBNPp6Euz9bfKmXs7RNs?=
 =?us-ascii?Q?4E3bC2nMwB8jefC/7X9IPc/bYxqIhcBq9zpiPut2N3MQSNX2gLV0LUHcX9GI?=
 =?us-ascii?Q?lqt4ifUDR25PMQ+V+uO9YopKAt71p6FGOE0Eo/ty0VOm/QYXq4SJ/FEOIDjJ?=
 =?us-ascii?Q?w0lzl4x3uGGphDrh+a830AhSVSqi4sHBansUnXkMPrBu8qNK0TCJONFLbQCx?=
 =?us-ascii?Q?EzGXpYs4iKPPOldfkq4fvkoJ43JR2lwjJdomwQGcdWKXBji04dv0+17ZZsT4?=
 =?us-ascii?Q?sg/dO8HwOKSpHKFCqwo3EhZru9jEfHmpBWs/h6R5foWqwvbqCqc8HabkXP1a?=
 =?us-ascii?Q?ZjMw2jeFtAC/pYZABswEOpSW45g7e7eW4er4y3+jek6DhEclUD+7kGfQOsV0?=
 =?us-ascii?Q?3Yej7vGFOVOqvksZ0p2n3H72j1t03Xe0oUbZ6S7w9HvNLq8en14pwbM7b9q7?=
 =?us-ascii?Q?WXyhsohITx0rUpLTDZGSUdVMV1dynpgOAlQzJwRlskVyzQWSDvo6lGIjRscm?=
 =?us-ascii?Q?kky2uazu3HYxq5eSMQb0mIn9xNznRZM138po/QWHX+fh7vkTBDXIBbWeP4RL?=
 =?us-ascii?Q?h5a8t7FeTOj/NTTnD4JEyfbXOuKMjdv90wiquFnF5jJ8/IlYdEoATEnXM0b5?=
 =?us-ascii?Q?m22N+oOl/Y8LKbylrapSDJvVSkHShX4Wl/Msoxjnt2GdPl2pXZ8I/6IrESPa?=
 =?us-ascii?Q?IMRknsF9yIs51X37Xf4MKqr8HBD0cBHC+kpzp6EO/hoMXKVpdBFOIw/umTXZ?=
 =?us-ascii?Q?X0+E/xSbqpa7/ztOHOc+jDjJH2xqgWcfFSPdoDm5+th+0JOB70Aa+dc5TA1W?=
 =?us-ascii?Q?gBNgvmVDgvXzK2sarL9SMNxZC0UJ7EheutVl3G7OgH3pBl7j+4MynfjM7AxC?=
 =?us-ascii?Q?G+u4+yD89qaNQr79/Nw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db399ea-7ed0-49f7-fc5f-08dbe52932e1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:48:51.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhB7SxxKHEn6S0GlKy57R6g7RfFiVcuky92//OST5yYd0wgCNHG93eg6QXz9VuCZ+c+ANdZskFwzX9MjVBloSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

Introduce a common dt-bindings header file, fsl-edma.h, shared between
the driver and dts files. This addition aims to eliminate hardcoded values
in dts files, promoting maintainability and consistency.

DTS header file not support BIT() macro yet. Directly use 2^n number.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/dt-bindings/dma/fsl-edma.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/dma/fsl-edma.h

diff --git a/include/dt-bindings/dma/fsl-edma.h b/include/dt-bindings/dma/fsl-edma.h
new file mode 100644
index 0000000000000..fd11478cfe9cc
--- /dev/null
+++ b/include/dt-bindings/dma/fsl-edma.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _FSL_EDMA_DT_BINDING_H_
+#define _FSL_EDMA_DT_BINDING_H_
+
+/* Receive Channel */
+#define FSL_EDMA_RX		0x1
+
+/* iMX8 audio remote DMA */
+#define FSL_EDMA_REMOTE		0x2
+
+/* FIFO is continue memory region */
+#define FSL_EDMA_MULTI_FIFO	0x4
+
+/* Channel need stick to even channel */
+#define FSL_EDMA_EVEN_CH	0x8
+
+/* Channel need stick to odd channel */
+#define FSL_EDMA_ODD_CH		0x10
+
+#endif
-- 
2.34.1


