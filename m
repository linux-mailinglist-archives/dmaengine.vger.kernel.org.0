Return-Path: <dmaengine+bounces-4658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE466A57400
	for <lists+dmaengine@lfdr.de>; Fri,  7 Mar 2025 22:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260E016EB84
	for <lists+dmaengine@lfdr.de>; Fri,  7 Mar 2025 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E801DE3BD;
	Fri,  7 Mar 2025 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="em4kC5Ek"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A485931;
	Fri,  7 Mar 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384282; cv=fail; b=qMJKHqYXERTa9tinMaLRbTsElWd62TKPkQKfgcKo1AT6JptRzncOf4W0IgmCs45f8zk/mlNCfymYrJKifx/CituHWHvuVaFLTruxrmNOLQVDiFz9tL+mK1FWkME3kmRuQT6vB/3u9wPm2DufdWWTfkRjJ2KKWDoyVpaKVFZOkkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384282; c=relaxed/simple;
	bh=xad+EiNR35RN222ez1uxhyOpO5hO5sQcVulqXNCwNCg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kH//TdxeWNJEOJEGtBGJJ2bjEOFPLPS+0FRiWrPlPwJPIgkuoeq2HCEoMUBQZMKq7wsAs31ptniKk+kHeNjbsS41DrRrtdhL+BBN7YTKIB66HksXLvwOrRNnoR8L7HH5mH4TgO7WO9Ttjf961e2cXwnBU4VipRKKbHBlv86WX80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=em4kC5Ek; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pchOQ8FM+5R2SuAAKN7pRwkhLl+7wzewGkJwGslreyEdi4bkzFKoWyS10IHleix0dpG8QQBccppSkdaQxn55BP0lxABbTAArOknPKDYJrLaz/P9JmCFq5Ac01F4YQPI105pn/YrIXCP1mD3pusYSmdQHq3C9gkOXw5hHPgQrq8IVjipE1EfC9Y+9X9e3dMpbNKFULOAFMDbCdPoMnRtriutxrcb68S8+U3+igGwZOJyxowzw62byMFvEdQ489BRU3kYPZZny9x0q/l1O+2Kpv34U0l2cqdZtnmYCQz2HnpVkU4IOpaMZmzK6wC3OxJHiE8Tj+7eajw+Vxsl6siAeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCcw1nOGksNE0agITQ1tlIJWmMWgi+GlTbteT3MWbLM=;
 b=ITtPQsgeXw8eRCD/q2ZmoIeMMhB/mpqHjcGevabn07uGHsxkEnYmmcNWZA8c44jFj6nejCtc0Po0Ge3h5E9QIyyKfYESifsS38DXcQfxKYWYLMh6HKqiXfRsMVY05XPalvZvnPPdvURHfAmTZXnPZq5TV7AZvoTv6MA6M+fw4mWFlQiV7WcwdUl1pZC8m+wsNo8jAppl0gbmmmt9N3wGdSKt8lYmr1E/04plwC8WxcGmWRkudGr8oq13OC2MsUthNgmQoBeQSQQxRqvrscGCoeHwt03lq8e122aF/xIjI47gu6E439O6pJndbt6mfGhG8xPb7uIy1z7fUDESYwCTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCcw1nOGksNE0agITQ1tlIJWmMWgi+GlTbteT3MWbLM=;
 b=em4kC5Ek7j7+yUHo7pqsca6Jg4eNfAWhfRfGwdKtb9BOB5S0rRez70/9z34fdHaTF5oDmUaA8Hed1Q54U0rE2cT/3fkdD1q7abMF/4mfHNtKVRAZaSMtbxOfPi5MiU+xsBpJ/MLH7868hxfP5YDnE9XLUQKucA/myHnLLZ9/aSGlWN2uR6YuGYiQIS6gHKJXg4abczGEoE7tMjYNcCMu0WSE2VhFBGVuI3WvSnys+LJTc1gLGGtHL9vQBiRmxXCw8Etsejii7+BtAARZekcxY2DcCd7eZnVRKR8X9pW6YRX5GKrCOBuhASfuQpY0jL40A/q6/q24kAZnmaOOLiZQxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 21:51:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 21:51:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: dma: fsl-mxs-dma: Add compatible string for i.MX8 chips
Date: Fri,  7 Mar 2025 16:50:59 -0500
Message-Id: <20250307215100.3257649-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: d3325d9a-2c66-4691-ba5f-08dd5dc22f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khMteRcvz832rrARq/ccTksx3GWw6rW8DIlHHn8Uij8qSRfqWpCFaIAiJTNb?=
 =?us-ascii?Q?WgLvYKx8aizecfBd7a5MWy4CCLZHzfaP8xcq5na0jqJYYHUuRk7eGd58qk5r?=
 =?us-ascii?Q?2Y8sGwXRZsOCArlHBrFSW7JhV+1YaCvRxBh2to348CXi2rR2bNhkrPx4h8Tn?=
 =?us-ascii?Q?ezrLUua37apNtPYcnSgb5CTTp0F5K4YPx5ZWe3M/VKmc9HcdUvrcK6RtRtcL?=
 =?us-ascii?Q?u9Ul4rIqLrvZQDm+ofQ8TgSu3QRqkVHeFV3KQBCBGHZ3nSL4fJuf6TerR5LR?=
 =?us-ascii?Q?aCGDUyGmcGaAg8PoZfztW+bedjM4PCby4/chk07gTdlsrwvgcaIc0T5NqKdS?=
 =?us-ascii?Q?GhYpgTEt2kzYkyFC7A6MPvyw2muU1NDLBAz5r5lQqlIuW4DgP+QWpdT6Czqx?=
 =?us-ascii?Q?7uL8N754SEZ+vx/5GVs5VcPaVWmLDc5+1wp4C7phyEjPm5B615nzhG7ZOFne?=
 =?us-ascii?Q?CkB2Dp/tjfFx89cs7VMyR+6se4zWmAT61+zBEcVT+Kjo0hKawNW8944sZFvn?=
 =?us-ascii?Q?KYTQIxKhOtGAuLMgypEa7zhyqwO1Avj4eNP5WkEAf7lHDMHnOBCcjXzNU98F?=
 =?us-ascii?Q?+kiCJ6ha08ngLjBbilYgQL8tqFOumTb7AsC543LQqdHsPOftzX6VsyYDOmvX?=
 =?us-ascii?Q?1ET6T9YCJbfpFoxbDOQosWShX4QkA8wqM3G6U1Nw6RhCLCjGdqrwkrbLGPbk?=
 =?us-ascii?Q?RFtH5QgoZ7GKI/zJ1QInA9doKX61qVl8WBYEBdKaZc0ZPAqFisymDOfAjdDE?=
 =?us-ascii?Q?4t8UQ6phgjA+cT/USac8ZQsMkWJmy9RTj/C7rA0CS/ljNMvRfdzK3VWlh9lB?=
 =?us-ascii?Q?JYXlxpQ+7ntGIfcN9ujMBb8oJoJSQ1exN7iuizl6X5D7f53vmrlxv46+X9eX?=
 =?us-ascii?Q?zHK1Hi1TN4fpLbI3uS5up/X5IgyUBg4rJlQCi9Hg4of9t8uLCSJe6Wfd4dBD?=
 =?us-ascii?Q?ayAB+/w87qODsQgzL7tFe8M8wP+yM+pcHZnc2DbKlNIZCSKo62xYURKPym43?=
 =?us-ascii?Q?H3PAZrU+0KYRc3DnR4eC3B8bZv3pVkY170rBhhOVPMnJQRmGB3XXS5CUVW4P?=
 =?us-ascii?Q?JrhTNiDRBtRReSioMkt+biLgmNkL85OCYbEc3RSjhLqL3Ltyc3vIKcvwBngV?=
 =?us-ascii?Q?TEUov0VFUHxNlELHhGSzAFmy7k0GXONJC1FZkCFFLW81Y7v3tVnQzw36zr64?=
 =?us-ascii?Q?EsrpSnS82CM8+YmvZ/TO6L2WzfLlks+3Uy7AfsXKjVUZl1rJmXGLlD1292jg?=
 =?us-ascii?Q?z3CA5uqxZnuJAuPW6G3eqGj3h0N3OtC2jxeEUp9Vz3eC17/hOHAnGKDgjsMx?=
 =?us-ascii?Q?2Qx4OnVhVa9tFPlDqtdtW6yKKloht33CaMwNOHeJ+aG5gNEyyI6py+IRZzCF?=
 =?us-ascii?Q?YsgkoxnKcHo0imhW/CNO1I0fT+W97cHYJioJAav+0tASsc5cpnGvVwNXkGiK?=
 =?us-ascii?Q?s046RWOll5J7g8JLFcDuBGG6DAfj+HPYIled8jZlXmYGkFMUO7X9/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJJGz04nkVf0cvtXTaODatQO2j8NKpwPvZGeKfUNzhz4VXm0RHpfoeaTzMwS?=
 =?us-ascii?Q?Y3Apse1Li+SMJCn/o6Q3Qo8NgdiVcoGYOVq3wo4CoMm9YnECKIzsSTlfSMop?=
 =?us-ascii?Q?ynCsl2KsE4mMaD5XwIc0QWgUv3GD+KF/PMQKDL5R0xjSzODvXHhzGk5Ods6W?=
 =?us-ascii?Q?67yr/P909jdEVtdyx55Bx4GfShsi/+HaDtfvPtF6SdDh9QoxtSz/BemcgFOR?=
 =?us-ascii?Q?T4Mxuqf+irkS6v58qFszDNPCpKjHcWEoRm1EV3rL4R+nniwOMa8oZV6sIZrp?=
 =?us-ascii?Q?4vjY6EcHSzLDn+mNfudd606Ylu2b4sOXeHk97yxAX4TLaoF8afU4hHpzFA1y?=
 =?us-ascii?Q?WC31jjTU3yaJsKJgrqG79j0FamIiWgrOva1RB0uYInBFvBpPo5Tlu1ftUwJl?=
 =?us-ascii?Q?6i/QDstW3WT2fO3DeYjRe2r0uxxQS6Q84VdhVZ6TAkdbsDhdymZfzpCOxtfV?=
 =?us-ascii?Q?krtRtugB+da5jlFMWDeIDdUb5BpQwTMdsDcjH5opnCi0c3EwiGoLhnrRe1bF?=
 =?us-ascii?Q?5VrM3CZ7oQ3lELKeFglifI3YQHjKRPyWz1v9FpR7+GlFnvn0DXZKmxcR/miJ?=
 =?us-ascii?Q?ZWVrvvQkeZO0uARKGnrRS6G3n0Tx61MfvZehk0TSotmroGDuz1y0Has5BPdJ?=
 =?us-ascii?Q?5mnX9dY2f4fXNYV05Am+/u69dsRjwfYOv+D7KEFENAf/ort1lk8wSgB0UgVn?=
 =?us-ascii?Q?D5CG0ciw2j8rgnENqvOVu9KXQSOVV+YL8oySRzgSxtyzDxzyykUJR0GIjL82?=
 =?us-ascii?Q?w4Ph5Y7GkqcfBlULnHjc/xeLp89fP0cz5d1vVksyOOf58WY8eEzpO0RAghU8?=
 =?us-ascii?Q?wEIVVAICnfRorq9REFyyf/rSRf7BY+ngpNbCNN1Nue85QbUMSxWkL7qb3/bl?=
 =?us-ascii?Q?RRZiD7iOObN6DQR/izKMfZ8h529CiOL4enFiqXlQ7gyh67LeBdfxug/7y7IB?=
 =?us-ascii?Q?oRPf4RYHyUGjUQ1Lhdk77hGSm/qGLe515XvtVI1XyOmLPNnnFw4VhK2H2zm0?=
 =?us-ascii?Q?7lEz2TYQr7oNyTrXczmMDj/5vu9+Az8iVfQ4ob4Yg9R1COGRUZjWKCA/YnEr?=
 =?us-ascii?Q?yKruLeBHNpbqtnl1J8BJiNiEzMZwt3jzxvuDU/u7svnixbCjXwGmH+abhywa?=
 =?us-ascii?Q?mFraudQtvYu8z16CmUW3kuXx68/pVeaQemXHHdKSxD171ktU8BfUg7dWobb/?=
 =?us-ascii?Q?XaXbZ27invtahPsA2b2/52EhPk50ANVRps+FJe0te+9B7ltU+Q4Qa9K5EnBG?=
 =?us-ascii?Q?rsR+dzYC4t4c83OP3dSI1aCotnhL+IKFEZrW6Z6U5s8au8lSXt+lZot+MgVo?=
 =?us-ascii?Q?9hoCgttZCvMvJAX3nPZFxUtLuwIlGwVeY/lQ9Wx8lIM79yNE6iCnqb/SzFMT?=
 =?us-ascii?Q?30CDwz3pgz5ANG+jESM59eDH+xq+45g9muzUUSr1ytHD0ulAQd5zY3kAdpsA?=
 =?us-ascii?Q?ukTv62sjvPp+twbcU2xBdrir0lvx65jnhzU6I8RmWBIybUdXqj2t9MwfkCl2?=
 =?us-ascii?Q?YJATs4pKLD5dxIeSZGjlhiNna6V8ZSFGMsUIg7hwB2vQ+ZfV3/BXQFHztPwI?=
 =?us-ascii?Q?DjHK/z80WwqxE2FPgo8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3325d9a-2c66-4691-ba5f-08dd5dc22f65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:51:15.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piHZJ6mWw14nr4bVnkfYCN91yUmiDtb7ltilLgg3v8ZGLYvNEW9kHj1ecqL+AAPYPx2dwge3gtxFi5sVOO5gxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

Add compatible string for all i.MX8 chips, which is backward compatible
with i.MX28. Set it to fall back to "fsl,imx28-dma-apbh".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
index a17cf2360dd4a..75a7d9556699c 100644
--- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
@@ -31,6 +31,12 @@ properties:
               - fsl,imx6q-dma-apbh
               - fsl,imx6sx-dma-apbh
               - fsl,imx7d-dma-apbh
+              - fsl,imx8dxl-dma-apbh
+              - fsl,imx8mm-dma-apbh
+              - fsl,imx8mn-dma-apbh
+              - fsl,imx8mp-dma-apbh
+              - fsl,imx8mq-dma-apbh
+              - fsl,imx8qm-dma-apbh
               - fsl,imx8qxp-dma-apbh
           - const: fsl,imx28-dma-apbh
       - enum:
-- 
2.34.1


