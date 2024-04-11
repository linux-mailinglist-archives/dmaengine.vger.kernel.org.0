Return-Path: <dmaengine+bounces-1817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116268A0A15
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351321C21563
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05991474A7;
	Thu, 11 Apr 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HXea9rnO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2913E04A;
	Thu, 11 Apr 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820961; cv=fail; b=GoMZ5kZYtV/rUaKJHVkPiZ/mmPhclpbxZAt3QnAm/NzgrqwOFnRl/JYZ9cUsmxE6/Pr46gJ5l545jmGD6sp8kjQqteDINkDuH98Pes80sgByhdxIg9NDY/ulBOx6fc4d1JlEh1j5aiEPWLgVE0SEgHQEdOypprz0KtBa6IUz3OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820961; c=relaxed/simple;
	bh=OS7CYKtFIfp6sRvhN8aniF5Y+iGJjYpILUsG7AX9ceI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOKnW6AzG3xP1WsExCMY1Qbt3HKRrNiNzQuQHo70jojA953jeDonzzrpyAz8S9HK2JspJNN+bbX/OE4p8hTn/glAWEgZ02XqFK4xDhXAWqu1Z48WbSaHHvrxzzIMtatXYRGZCWvuzSRFwv/fQcbpFripwJ9GyP9PTM5FfoV29bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HXea9rnO; arc=fail smtp.client-ip=40.107.15.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPLamP8TLRoUulQmM792v64k0Ib2LYCQoA3ldaDGMJc/VvCryrwjKwZH9bpX+2yJKmVr2Tm72CNbx2SjlogpDR2wm4j49IdJocPkNVkx7yuMu2IrmcMi/G52uh/AIYoBaOMDTEMHqVtOJVK8nC1OdQq32IX52PmXGm6V8wwIIq/SoqN1evdO0rXH1Px4zWu93S0g/hiDVmrZANSoGFC9dv38GP+aYV1iM7UJcQigrxltxzlB1Bj0hk5HDNELNFBt8Ykiw45pEB9vWbqaYB/IwGOY7k5ifbi5aFT2poUjOIs4GwJfbtDgiqJ59Q6YqXXD1l+UFIBGsiIyJOoi/YMqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAksOetlYivzLKuVjx1OcMHA53t0QGSnfn9MvVTvGsc=;
 b=NsUYGQFMdcvgMEQFcnyd0dCF6gGMi4h9M2dPyJvJiKbmKvUB5YOhPrh9+pvGrGIgap99y3xVQF97SnFhKgXiQNcqD6/pcvFufTRLy//5yr9a/MnzhVPuFdIn8mJL1nDiz83Vu8oCR1OLOW2HrblWWDS3kFTLbY9GojCvzQzJsdBR+XiJIq8QmHWljycX6UUxs0TT2RvUjUMCsFgoi3flCojjGGOo7faoLy5rYRLRYQIOvOuES/bp6k2ptbG4F27IDZt8R13fUWqu7BkYckOIqvyTO98KX6RL6REx1EG5O8MjwQDD7zODK50Y5P88kXHsqP6f7/g1GmE6SDIVTyK/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAksOetlYivzLKuVjx1OcMHA53t0QGSnfn9MvVTvGsc=;
 b=HXea9rnOflgmSuZJLojrlRsbUs9nHi6Ufc4xH+Hgk+KwAGtPf6Hm408M/yB2pCdGQnbl7GJkej5itJXcPBMM4lRvLlLMxw+DYmwCderWx5K8TcBnAVSUW9+mMn2TuJtwJ4qxNngqW1g1hOtIrQXhuD48ByOzzfyMkqDIOPrfgkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 07:35:57 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 07:35:57 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dma: dt-bindings: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
Date: Thu, 11 Apr 2024 15:43:26 +0800
Message-Id: <20240411074326.2462497-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240411074326.2462497-1-joy.zou@nxp.com>
References: <20240411074326.2462497-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf71fe1-4dc5-4791-7579-08dc59fa06be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/XOGIjR7KAzKfAhJPBplMl/vvWLU6dRUxiWVygfN09HZQCSspV/5rje8ncMZ6y6JT7gASO2/F0DwqaqTy+M8GuhxXAygOSbHkoCh2Y3CyjZssE5pBIJOlPm9r1yQRB+Uyc2ORD9BVQnY4oNrKLo1o1acLC5XX8egcYztiRF58tI2PbnWXBymvyxr4F1/jqjY0mjwso/WlrHWeDh6jPw6CMerLas2l1r6AjQS4k5rUKxYbreImrsaFfTo5AvcYS/OACGjwC3Yo6nQf66sTirF3c/ktvmsQ8yy7+mxLwv53dUQveZU/d2sX3TCRtg1LzVTp3HgcQWr2Om4oV3HdlfD43wSUrt5hM775a92ZOvDj1JA6QBlHd4rhPeZgio2mXFjTlrdcrrgjhGdeTOjXRXaHHCwMBTs9BUyEiJ089YHNhWa96sKiJ7SUbkORD4xs8ga0T8+fwbVZOJpU940bDhhoJqH2kCLur7FWQALyXd3quXW/d6Vl+uOKF3D/AcPrI9gn+nZ/FSv96Kn8KPdIMAG6w0Jmw/YqmSU5twpazMxo7AsVxl7anaEnfjPPA1Uftd2OgfIDRyJYk6LoPpSYaRdZBIzJOOd+IvgtIJD2olo9XiBJciZ88dMQTSxcg1cG5GIiJYdMrhsgOqfkRWO9gmxNPZUwLJzxTCWkPT1YObQAWtKDLSdVQHDmOYD3ork3jxszOcM+FBRYsSYxHBUQthCE+/EhL9hNfIhX1llLRWQgTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyYKZfuWlBu/j9NaRXtnbrPP16XFIvVWXLapjnFkerJbECVaROmX/VvVj/KN?=
 =?us-ascii?Q?oyS1KOd1+L7n8RSvPYagDgtxMu0dWDwLKWB94NCTW3hg4HMleVCoOBk66aVU?=
 =?us-ascii?Q?83KdFi6EthmWlwoNO0ru6dOCr+46x4yiDWv0HlxKWb7kyjsMAv80zRTJtOuP?=
 =?us-ascii?Q?g7R5Agl+Td8N7XBuXNBIK0ifWc1U/I1AnyewGpE+Sv7WMSDg/vnT5bVICbch?=
 =?us-ascii?Q?uPnSIHcEYhK3OwYwNdm+kdo0L+pa/2X4k0eWMfJujLy26azlh4Ls4N9gNUrU?=
 =?us-ascii?Q?b8giZZqISPZ9lc92T457k6VZOJfmSJz/VHBBu8FK+78RpkEY74fblNfRXdKp?=
 =?us-ascii?Q?VzIGo0tD3qOUMZXJcQiP9+OX0w95akEkPabOWDQPGWdqoTaA3ksM/tyT5wtD?=
 =?us-ascii?Q?c7izXZThHkOsmZREo5Em0O8EUxkKHctsyeV8Wx2V1ib9l60E9v7V49AsIHcl?=
 =?us-ascii?Q?hSpBnLfGgV1hc0smgXNOiv9GznqVIMWUQyjwp25mMf8GY1uhcHIUlMLMciQj?=
 =?us-ascii?Q?SOiErwt+9qdBY6/zpbq3Awq9f9lvGNLTJ7H60jZJ216KijjhYrGxGfZ2FbXh?=
 =?us-ascii?Q?3hSzYYmlJmeNFqObQmL9UwzzLZIlkQX23RMejOeEAi/J1jMSMahHZwAYNMTT?=
 =?us-ascii?Q?+EGUTVuhMxyl16jvsWx3+TmVSt+LXhR2Tc4iMQEMZJ/W0iRFYGtwmnLq3yyg?=
 =?us-ascii?Q?MxNZx5DiSFBjozcxYMaGRaKWf+eOnNBJlEUr5mtmb1Z5Dx8U/2gx/ZQdnrGm?=
 =?us-ascii?Q?jdO3J/IfMaCadKTc1f+PjFnImESYe02atVwlQLVUBZtrZINhoG8XGRptQtYq?=
 =?us-ascii?Q?ktE0FU0KC4RRo0Mp0JI5oHpRoZVfQKbApNQoLzRDArS2bpKZX3hv2xWobSO4?=
 =?us-ascii?Q?4/CrWAuzJpEzksE8LSHiYVJuuAjSsDmfulKo68YU5MAzPBUatlp+JxTW+4Ke?=
 =?us-ascii?Q?GojY6tD2B5CORrMzxkJasbgskeoTF43S99vFY1nDznlEiRfELThwjQJUJx66?=
 =?us-ascii?Q?u6AQLufRVM0nbyS2ajl5063ohWz5m0OipAxbwsjjCw+FaNPUd20KSw4rSjjs?=
 =?us-ascii?Q?OMLjDL9PF6S0/ciUdmYz9AQBONvVzSIxsOwfMiwcIuCeWmZcsIxalH5FBKfH?=
 =?us-ascii?Q?lIIvZYyHMpm7a8c6p0nVhMWhZclNFqDzKXF/vFutgCkGSVLwUm+QDqy/48hG?=
 =?us-ascii?Q?d+tfVJSJrzzA52xwyl5FA1N+BJaMzRS0XT7ya2tosvVO5lcFI7AgJR8iYyfj?=
 =?us-ascii?Q?80ycqDojIPp7rrc+a8cpX73TrZkfk47h9eYWRgjMOSwhtdhomZy8YBHZVD+Z?=
 =?us-ascii?Q?vF7G5ToaydquIQwQ6vz4jNjEX7LVipA9tnkwQ32mIwWLP4yMfiG7CG7CvaR5?=
 =?us-ascii?Q?c5rIjxQCCgasNFlQXBxfnRlQ6ugTtkQU9wGytx7oVlafugwMcQHxD/zOwi32?=
 =?us-ascii?Q?9CA8FcrMPFkjXnRQYymJdl8O2546GT78b70ZDznI2ji5PbC3ZvSK28XF61nZ?=
 =?us-ascii?Q?Uwq+lVOA0KztPLgzn+Q7ABbdclaxQsd0/B8kIChtUsuJE7A++xyHbGsWxVgv?=
 =?us-ascii?Q?mCkFR9/Dz+ULjeSlzBRmXyx1d2XOCxeV/TAMgfEe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf71fe1-4dc5-4791-7579-08dc59fa06be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:35:57.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo4qWwcZCC48GsEr+K7DnkD3j7iqQEs87lDo1/+YVhqrfqE2AySSIQmN/QINR41h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

The compatible string "fsl,imx8qm-adma" is unused.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e..64fa27d0cd9b 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,7 +21,6 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
-          - fsl,imx8qm-adma
           - fsl,imx8qm-edma
           - fsl,imx8ulp-edma
           - fsl,imx93-edma3
-- 
2.37.1


