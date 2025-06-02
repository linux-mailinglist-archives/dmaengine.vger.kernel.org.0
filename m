Return-Path: <dmaengine+bounces-5295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68790ACB501
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B49E4482
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62F2236E0;
	Mon,  2 Jun 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLEj72wG"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012000.outbound.protection.outlook.com [52.101.71.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689C2C3247;
	Mon,  2 Jun 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874989; cv=fail; b=dc1r3yw4jFoYRiiK0AyNzqcRxqi1s4GZzwU/uCUfFBYA6oEhaReAUV24VyogTpiWob9B6H+cNJQxsSThGlXbUZZWHjCr5ydUoNGQzZ4vd/CsbXYgvOvaZAMs+tNvMwA45F8hdSU+IWTeoFLXXoAmb0F3QiyF5HvimuhjjbTCzRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874989; c=relaxed/simple;
	bh=BCQwImgtKx81r7s1lKDKU06bSgnuJrix3JS59JbRHxc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g+vBMPm1HUAws9JAr2THFeysnp2EGWtWVwu/Q66jEIEyhGOXps6RdTWojQIMyp70WgcuUhl0Gy6PtNHaAoO22EBvRtWw+rYD8YXSIrtBxcBV6zNyb37EJHEHbMZ1B9bUyIMU9AIN0jqxvC6gxLR9rPAvJrof3gD8HjFnOtj4CZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLEj72wG; arc=fail smtp.client-ip=52.101.71.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRkl8omGlMjOAC9+DjPYwCfxhnYF4QspxXG96YralP0X17fIY8I/uzaSVgCcL3x/GnUvzVUIX5MQmiXaOieHJ23sim6NaY4FCmpjTkMjfzrM0LLq9M1HC6lECB17wJjRp2XkHaI9eCxAp9XzYQKm0agQuUVnOko4uVf+Qae3Y27Gx7U3JVKoTbd/RUd3SYUsrlm41w1C6S47n29O6VH1H25u5pYIRsHnsMDla/UZVJTBhE6bLKjI8CfOfQdjz0JC4FT5Z5lCwPrjNnIczCQhw0dND6cRgh1Jvv7XeKdquIgj39Y8UrEKr5FSTUCG1fWeLR8eHZ1jBuwzY6pRvLTouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EnYe0uZ+uklSirATKZHGaxMRFHPX2TsOYFTDm8SPsU=;
 b=Sh6Wpj+qyYEKm87DHC7pr8sNxwBM+2lszIjZD10Q6PT7j+jdP/P0lfXO2intjJrRYJeRCBntUl/JQ4yqvpeMWb9fpdNFt3vOecwh5Q3Wpmcm339Gtuvs5m2oEQBWvgm+1q9YGUUBbibqZtU8G7w+fH2W4E5dxQdkf/QGLU3t4me7zYp056w12x/i0ZcRzjV0baxcDlkopeKby3quFtV7Us7hAIFLL9p2DmU3k+FScVXObjmk0VpxRcRl5GgQNMTCJ49waNpQl3ATdeDN1E1brGRu7HsNM6G8fVSxwLk9YKP7g6ygjWhVC27JK3M2E6HMdH7TUtK4b1bzdE9vV0A1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EnYe0uZ+uklSirATKZHGaxMRFHPX2TsOYFTDm8SPsU=;
 b=HLEj72wGqb35zIXajEAm0kCc/zr4qNhpVtQD+fTyyoEqQYKbFVMHxUZjQyb2n38egwLVr5kd5SkNRoCq5/1d9vQ2XBWt5wbH3fiopQoIIiyDKiPuCH3QKIS2/06KmHq+n7lm7lFC+bHwQIj9ehDgovWNaJorJp7ucx3bQXHMdnlamcDbF7E04jeycXXnfCReQXs2m34SwAhTskzpqzWJFF3TsyhsatsTX7D5nfo7trr11xkxm2gGXQ3s0qaO3tJbJOu9V5q7yozwoS+UXycpW3PBxsN49h+I4UX9tlLREwlxJXHTZim5AO+/qsIVYb5a9gaosSRgAogfGpt8I0EnvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10386.eurprd04.prod.outlook.com (2603:10a6:10:56d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 14:36:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 14:36:23 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC18XX ARCHITECTURE)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mfd: convert lpc1850-creg-clk.txt pc1850-dmamux.txt phy-lpc18xx-usb-otg.txt to yaml format
Date: Mon,  2 Jun 2025 10:36:10 -0400
Message-Id: <20250602143612.943516-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10386:EE_
X-MS-Office365-Filtering-Correlation-Id: afc09956-e40c-4e93-2af7-08dda1e2d8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzcIM19j+6aYjpD/zqwkDcc5BY6F9PLDzla+w65RM5VTZLmqMzQcnX/LVSr7?=
 =?us-ascii?Q?8JNQocUf0uxjNaUhvzta/0S7v574JBg8EvLz/oWJ6BXTpiPONQPs06E13xXZ?=
 =?us-ascii?Q?XhIAyhTLkqtsDmiC8uLPVnFwg0hQFU7JJEYlPFP0F9MINBRIlH0cgF4YukhQ?=
 =?us-ascii?Q?auCgei5wCUb/HzLNfx2MwwywcgQeZpzM6jZ23ZpnJ14TDpZBJvWQozDfSOjo?=
 =?us-ascii?Q?wMJlPmn4O+E9+mMKHxCUphgQA2bv0EizMNhRsm66AVkYZX4YBDgWkDjM4B46?=
 =?us-ascii?Q?Fj565cJWa64Js2Ts3WSuIaiu2Rqg2iWBa48vb4qKCdSNz7n0pj+RHiW4r20c?=
 =?us-ascii?Q?mtlXHHzito9lhD3Q0DJryhcgK2BXDOplumWx+vCV++cXx4WvX7EWOLTBzpxy?=
 =?us-ascii?Q?XcOB228+vE/TU5ZhyEHPpzLyZ3lCE+ie/lcphhlOFTBIJCbTsF/ZuRB/5qLf?=
 =?us-ascii?Q?939SbT5JVqIdRRhj/D/7+ZGyEZP0+3lUEPLhrqbjDqcOqS4pmjnwARJLocOZ?=
 =?us-ascii?Q?U9O/gwvW8nZWdNxzHG3tdrlYh3zILfc0jDFOk3+N8XtzbaH/NtbyLwRIJO6N?=
 =?us-ascii?Q?mA/6CCsiagKbxw+6P1iQsoc1/V3+lnG2ykzeuRua8gzOr9QrjOBDeAV3l5ib?=
 =?us-ascii?Q?z+LPambM6wtGIv6EpQWZAAXdJSz2uicgIjpgTxzV/IbH7hYhDPOaMTZsUwLS?=
 =?us-ascii?Q?IqCC971g9gDxOVoQTk+zF8JqNltWkV+Zk/07mT+cF8RC7hYDvrsLU3NxfrmZ?=
 =?us-ascii?Q?c0/gyzxcxZouUwGYheEkFCwUB5Z7qQkjpo5n8eoWcQ0X06cE2l5jwDgOOGon?=
 =?us-ascii?Q?L2ps6ne4aZpdQo4sJjNiGBpdgyOgXdHhJKxQrt6F30WkNVC3rSB/GB3HiaSO?=
 =?us-ascii?Q?c54a9r779ugQ1lhDHlQZkFRJNs9SDbhVld5Hj7yvbREikyKvDZkrABk9gWvh?=
 =?us-ascii?Q?GJjnfCjFNS25El+w1md4AYjbZdS58NiZTyQgNyEjaiIf2r9C/3gcpefUl51k?=
 =?us-ascii?Q?mbZraPREcK3pRWO6GK6VAGDAfp0D7+wM2pXQLf0VQ6uXAzsxTFKNmwmMzjGm?=
 =?us-ascii?Q?2Bzz/rfX37MBHrVx3jQ/zBrisJw+WzlY5kDF7tu7mKT3w8YU9zfyMjqlTotW?=
 =?us-ascii?Q?Y/QWRS8S7P3m1hV0oNTFNiBgio6iy4OGBSTKuq4Kd5QGWB1ewNeFtB4gpnly?=
 =?us-ascii?Q?SKs8GSKDQp54vMhPH+MQxsUl1Ql6nSVl0tWDxmtA2+LWuN6OM6ccmo3GSqxO?=
 =?us-ascii?Q?/Fwtpr8XC7tFoXNiQ49FY3rwxRDJGbsbOw6yjdxLm2AVA//UGZA6N3p2+ZM/?=
 =?us-ascii?Q?8Y43hmivbwR4ElWXekTAK3KXiNYrlWujNxhYW2v9lu4if6rRCAmVHmREgFTM?=
 =?us-ascii?Q?KDjgAgI9/dgFR6Uvosr7Q3gP6ioLaHrg0GKD4LJg/SpNHcVEm2CcGZXeImoX?=
 =?us-ascii?Q?LvQQyNvKYE80TuhVR0YSXCWwyvlVT3k3dwWWyo8xWDYYkGQy/j0x9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWY8+YBaEq0gGalV6OXStbj6HtifqT+HU4aDct6qccneM9em4M3dq7BfKuO7?=
 =?us-ascii?Q?57eXm+jmdeXgVDO6FmCT7dqnhAzvVOovPjWvqNhfi0iuBeiSGdV/X4Az89Z8?=
 =?us-ascii?Q?6ZDOA07bt7G6PINHwR5MsOg2fehgpvOe13Z7uR3SbdH4CENTs1YqirO36ukd?=
 =?us-ascii?Q?qkJcoixix+mOwCuE+ELgXBO+sUkQGsQlfyrXjHAhsJ2qBPHbG3o44iEKK1A6?=
 =?us-ascii?Q?mwZivzk7+3NXdeUeYwK87cw39edYTfxt+GHE7PqEXKOhBXMoR7nDTqBNXG8p?=
 =?us-ascii?Q?PNvTq5saIauPxllz+xT0JMD87ZFfmjkGS2jrYqp5yEwGjYgU55sJiiLewMr3?=
 =?us-ascii?Q?yvo60jNwMmcddI4VMkAA4t42O3isv4psOph+fIzpyvfqkdFrEMvcxSJOkasA?=
 =?us-ascii?Q?QWSdI5aD2PhXqah/71BhDaGKdpymERssLu8odNcZhlljDctBD0UxsQ01p7SS?=
 =?us-ascii?Q?UejOAAEXvuWeY1EI/LtN1mZYu9KL8llauA2LRjgTX7rtllojgaXs9Yl93RNC?=
 =?us-ascii?Q?yvpsIuQEl/dwbD15Jbd5NbV+eQZrfQ/2a+K/IvA06V6y2glEcYxRBMA6kgMD?=
 =?us-ascii?Q?ik7qTX3DY39XHYzfj58SgHRnsYzPuPd7D1Yp/pgnfeqgUVMhO2HjYwPxscxr?=
 =?us-ascii?Q?eyNKB1vKA2H/njuJbP08NKVtuxJkFlyYihsveulOlizGzjv3h12q+hd6g2Sa?=
 =?us-ascii?Q?745SoKlF8enKV5YyZSPPI/qfO+/bkYzrndo7jCEbUZ3jdhMC06UW0nOMEM8E?=
 =?us-ascii?Q?D55h9ECAhZs44JBbn6meZJMqD7jyDdSCGoREPEoxSh9isMAJOBZ0ShkCVQWq?=
 =?us-ascii?Q?wwGE9JiWtwhmeui/S/C8jJe2HJgNzagdFDmGslJjVoPTnIgEUBrcoDHawpv7?=
 =?us-ascii?Q?nCisgGhNI34ZjuqkFlCDo9eXKmD5imvVYodM43qBz13SOD2qrbvPurzKqMcZ?=
 =?us-ascii?Q?EAiMRdUdJb1RoXtONpMUcDBSHN/bWZZHH3PGU0uUaYDE4zENIG0lTBDeuPat?=
 =?us-ascii?Q?N7GT7D9mVQgfb/r/ZrAOxcpymcibs7Lx2WpoKLj1IlNj2RXm4OAzJg8raEu3?=
 =?us-ascii?Q?3J0rxSFKjMNiYk2+xoWj+8vqFJxCVXVQTzyrgKPLUPm3O10c+Dty7Df2700y?=
 =?us-ascii?Q?YAT6VpRKcdbfF9wh+zaLcLd0z0+J562STHX0VGtdM7pca1e7HqOmLht6PeyB?=
 =?us-ascii?Q?h2xvs3qxFe2+nN13snHDKTe3Mly2zd2g88YvgepUkaBpTnieZQO40n6Rwy0m?=
 =?us-ascii?Q?+XAlj5dLBZ50sGZkKbbrz+LMxgylNyibJd0HVZOCa1Vl9IMk0fc+rrY1phfs?=
 =?us-ascii?Q?d3yBlSMXIgge68xhLjrStfrCvB3dqOD8UzH6tHGuVXL1v9kO5gIxJhvhUsTb?=
 =?us-ascii?Q?uiXvdGUByP4fZh31XEBIy8qZvcHW3HGSQp27W3bHQ2edwUxo2ZdktHQDFT1X?=
 =?us-ascii?Q?+eC/ryC1kshEPl+in5A9N1mUB+ajU76/i/IquOAJm2S5PLlK9bKfLZH782KG?=
 =?us-ascii?Q?5m5of96L1VUCdZ1j0UGUpUms6LRbXHhiCEnfD83F3yMdHJYpcQEygl8dErN+?=
 =?us-ascii?Q?E1sPA0RN7N1YSip7kU5wriJKrZBKwgPRYT9NWzJN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc09956-e40c-4e93-2af7-08dda1e2d8b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:36:22.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5m5f4OAxDaoLb5LFR+6iE2gFA54amb+1KU/sZhDsrAZcIc9Om18eG5TVZFawq7KuuthDsGPqgUgPAN6NeKqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10386

Combine lpc1850-creg-clk.txt pc1850-dmamux.txt and phy-lpc18xx-usb-otg.txt
to one mfd yaml file.

Additional changes:
- remove label in example.
- remove dmamux consumer in example.
- remove clock consumer in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/clock/lpc1850-creg-clk.txt       |  52 ------
 .../bindings/dma/lpc1850-dmamux.txt           |  54 -------
 .../bindings/mfd/nxp,lpc1850-creg.yaml        | 148 ++++++++++++++++++
 .../bindings/phy/phy-lpc18xx-usb-otg.txt      |  26 ---
 4 files changed, 148 insertions(+), 132 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,lpc1850-creg.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt

diff --git a/Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt b/Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt
deleted file mode 100644
index b6b2547a3d17a..0000000000000
--- a/Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* NXP LPC1850 CREG clocks
-
-The NXP LPC18xx/43xx CREG (Configuration Registers) block contains
-control registers for two low speed clocks. One of the clocks is a
-32 kHz oscillator driver with power up/down and clock gating. Next
-is a fixed divider that creates a 1 kHz clock from the 32 kHz osc.
-
-These clocks are used by the RTC and the Event Router peripherals.
-The 32 kHz can also be routed to other peripherals to enable low
-power modes.
-
-This binding uses the common clock binding:
-    Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible:
-	Should be "nxp,lpc1850-creg-clk"
-- #clock-cells:
-	Shall have value <1>.
-- clocks:
-	Shall contain a phandle to the fixed 32 kHz crystal.
-
-The creg-clk node must be a child of the creg syscon node.
-
-The following clocks are available from the clock node.
-
-Clock ID	Name
-   0		 1 kHz clock
-   1		32 kHz Oscillator
-
-Example:
-soc {
-	creg: syscon@40043000 {
-		compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
-		reg = <0x40043000 0x1000>;
-
-		creg_clk: clock-controller {
-			compatible = "nxp,lpc1850-creg-clk";
-			clocks = <&xtal32>;
-			#clock-cells = <1>;
-		};
-
-		...
-	};
-
-	rtc: rtc@40046000 {
-		...
-		clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
-		clock-names = "rtc", "reg";
-		...
-	};
-};
diff --git a/Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt b/Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
deleted file mode 100644
index 87740adb29956..0000000000000
--- a/Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-NXP LPC18xx/43xx DMA MUX (DMA request router)
-
-Required properties:
-- compatible:	"nxp,lpc1850-dmamux"
-- reg:		Memory map for accessing module
-- #dma-cells:	Should be set to <3>.
-		* 1st cell contain the master dma request signal
-		* 2nd cell contain the mux value (0-3) for the peripheral
-		* 3rd cell contain either 1 or 2 depending on the AHB
-		  master used.
-- dma-requests:	Number of DMA requests for the mux
-- dma-masters:	phandle pointing to the DMA controller
-
-The DMA controller node need to have the following poroperties:
-- dma-requests:	Number of DMA requests the controller can handle
-
-Example:
-
-dmac: dma@40002000 {
-	compatible = "nxp,lpc1850-gpdma", "arm,pl080", "arm,primecell";
-	arm,primecell-periphid = <0x00041080>;
-	reg = <0x40002000 0x1000>;
-	interrupts = <2>;
-	clocks = <&ccu1 CLK_CPU_DMA>;
-	clock-names = "apb_pclk";
-	#dma-cells = <2>;
-	dma-channels = <8>;
-	dma-requests = <16>;
-	lli-bus-interface-ahb1;
-	lli-bus-interface-ahb2;
-	mem-bus-interface-ahb1;
-	mem-bus-interface-ahb2;
-	memcpy-burst-size = <256>;
-	memcpy-bus-width = <32>;
-};
-
-dmamux: dma-mux {
-	compatible = "nxp,lpc1850-dmamux";
-	#dma-cells = <3>;
-	dma-requests = <64>;
-	dma-masters = <&dmac>;
-};
-
-uart0: serial@40081000 {
-	compatible = "nxp,lpc1850-uart", "ns16550a";
-	reg = <0x40081000 0x1000>;
-	reg-shift = <2>;
-	interrupts = <24>;
-	clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
-	clock-names = "uartclk", "reg";
-	dmas = <&dmamux 1 1 2
-		&dmamux 2 1 2>;
-	dma-names = "tx", "rx";
-};
diff --git a/Documentation/devicetree/bindings/mfd/nxp,lpc1850-creg.yaml b/Documentation/devicetree/bindings/mfd/nxp,lpc1850-creg.yaml
new file mode 100644
index 0000000000000..89b4892e9ca71
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nxp,lpc1850-creg.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/nxp,lpc1850-creg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The NXP LPC18xx/43xx CREG (Configuration Registers) block
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,lpc1850-creg
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clock-controller:
+    type: object
+    description:
+      The NXP LPC18xx/43xx CREG (Configuration Registers) block contains
+      control registers for two low speed clocks. One of the clocks is a
+      32 kHz oscillator driver with power up/down and clock gating. Next
+      is a fixed divider that creates a 1 kHz clock from the 32 kHz osc.
+
+      These clocks are used by the RTC and the Event Router peripherals.
+      The 32 kHz can also be routed to other peripherals to enable low
+      power modes.
+
+    properties:
+      compatible:
+        const: nxp,lpc1850-creg-clk
+
+      clocks:
+        maxItems: 1
+
+      '#clock-cells':
+        const: 1
+        description: |
+          0            1 kHz clock
+          1           32 kHz Oscillator
+
+    required:
+      - compatible
+      - clocks
+      - '#clock-cells'
+
+    additionalProperties: false
+
+  phy:
+    type: object
+    description: the internal USB OTG PHY in NXP LPC18xx and LPC43xx SoCs
+    properties:
+      compatible:
+        const: nxp,lpc1850-usb-otg-phy
+
+      clocks:
+        maxItems: 1
+
+      '#phy-cells':
+        const: 0
+
+    required:
+      - compatible
+      - clocks
+      - '#phy-cells'
+
+    additionalProperties: false
+
+  dma-mux:
+    type: object
+    description: NXP LPC18xx/43xx DMA MUX (DMA request router)
+    properties:
+      compatible:
+        const: nxp,lpc1850-dmamux
+
+      '#dma-cells':
+        const: 3
+        description: |
+          Should be set to <3>.
+          * 1st cell contain the master dma request signal
+          * 2nd cell contain the mux value (0-3) for the peripheral
+          * 3rd cell contain either 1 or 2 depending on the AHB  master used.
+
+      dma-requests:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 64
+        description: Number of DMA requests the controller can handle
+
+      dma-masters:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle pointing to the DMA controller
+
+    required:
+      - compatible
+      - '#dma-cells'
+      - dma-masters
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+
+    syscon@40043000 {
+        compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
+        reg = <0x40043000 0x1000>;
+        clocks = <&ccu1 CLK_CPU_CREG>;
+        resets = <&rgu 5>;
+
+        clock-controller {
+            compatible = "nxp,lpc1850-creg-clk";
+            clocks = <&xtal32>;
+            #clock-cells = <1>;
+        };
+
+        phy {
+            compatible = "nxp,lpc1850-usb-otg-phy";
+            clocks = <&ccu1 CLK_USB0>;
+            #phy-cells = <0>;
+        };
+
+        dma-mux {
+            compatible = "nxp,lpc1850-dmamux";
+            #dma-cells = <3>;
+            dma-requests = <64>;
+            dma-masters = <&dmac>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt b/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
deleted file mode 100644
index 3bb821cd6a7f3..0000000000000
--- a/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-NXP LPC18xx/43xx internal USB OTG PHY binding
----------------------------------------------
-
-This file contains documentation for the internal USB OTG PHY found
-in NXP LPC18xx and LPC43xx SoCs.
-
-Required properties:
-- compatible	: must be "nxp,lpc1850-usb-otg-phy"
-- clocks	: must be exactly one entry
-See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-- #phy-cells	: must be 0 for this phy
-See: Documentation/devicetree/bindings/phy/phy-bindings.txt
-
-The phy node must be a child of the creg syscon node.
-
-Example:
-creg: syscon@40043000 {
-	compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
-	reg = <0x40043000 0x1000>;
-
-	usb0_otg_phy: phy {
-		compatible = "nxp,lpc1850-usb-otg-phy";
-		clocks = <&ccu1 CLK_USB0>;
-		#phy-cells = <0>;
-	};
-};
-- 
2.34.1


