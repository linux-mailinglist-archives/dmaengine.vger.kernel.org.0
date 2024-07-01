Return-Path: <dmaengine+bounces-2602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65F91D851
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57EB1F222CD
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF904EB45;
	Mon,  1 Jul 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s9cEnOk+"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9385914C;
	Mon,  1 Jul 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816823; cv=fail; b=m1RFtz+D7RupvI/0vuWKXIDr6y0e0FHUqjJXDp5HQD+3yCsnPxrm176ITVol3GkyptrWykIzl9+G90DPUpaR3Vd1I36+pZPpPUfTulzGdHInEJ8k1vb4ei19pzb39JqlJdhwmwDz1WYDNpieZeOYayxwC83w/GhE7ImIjN5i+C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816823; c=relaxed/simple;
	bh=U9UjN0ACiWMX1mjF9L3m188NlShFBmWAbf2LoihAZ30=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GhoFYfjG+R0sgVZ1CFwaZO5BPp/6AXFVKQ/GRlDwqSTHz65V07og+8lF0/VkuhLM6RSM05sz0i0m2dgRXBmNB1EAGWHVIATAS+x2ibWh9zA/I/9pxHa3Iq9yrZs1PppY7r8PYBYmS4S/438Z2XfSyXr64KJKlEMLQ9o68VN+oXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s9cEnOk+; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5esMu59m7wwoJWVRmmbgShdVw29lHXM68wA4GXi3i1Mwkq7Y/hxYH87S/jZKCjhl7G/9ATgwF1plVzAozY6qM/+btJ/NsSwNVUjyGjugrajwPbm762rFIWViL24ifAYpu6OFmQtEvPgiUQqw7n0sAogu6IuUbf1G5gnERBGoYsNXXB2GTUQ2rR54vgBqhEkxe77LvbNliFI71JaxXju3tGQkYEVPdQm0B1srLV3Nb6GXCv6BrxOcF1phKp5KumQVgkSJ60EPCGQHVQiSZHCxkjvfBT/Blmn7VMwSsuUO/Btcjr/GK7AeJv6kseTTT0+TvD45OCzgbjWJHqprTjqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icshawFxWlvTkQ1fTacsuMl6DYIcbJwrgA6jdkYaEM8=;
 b=K653eZJ1o9lCqNglFukVgA2bkBWD+X+QM1aga71j+rIStog68G8ZB3khF2zwKo2KhnIbKrwdeIftS8LTrOJm63X5bh+0DnfNCuY7E+8Q1AyFcndUXi8NCT29amHHrxlenqz7m/W427ScAhySA2H+mIDFAQVP/QUdvROeMAF1AK5JRkOQuKSP5uZdzzNBUKTM/RmGFtFLsvxvAp3V21MKPCsqsBPumIwbvanEp+x5cvIlzv2yv21WGYkSC0L1J5+1nbqDXXtjAPXzMyZ6p/QzxsHhlccxCMzVPNkmJ+h2Jkx2QjHSjR77odOUEb0Z/5zFUiZh3Yf1KUZVzIMBRjRj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icshawFxWlvTkQ1fTacsuMl6DYIcbJwrgA6jdkYaEM8=;
 b=s9cEnOk+5qyO4Hpa3YllF6lkf0VF0RhskZaAg/N84v7jsvCT2W6vNXBMA7wNMrsPJ1GHXnmZqgvFBkaxPJc2DNNvPUBDqyyU8NA3H3+SIXsqqOtJNyXJnqgHE0QTn47QKH3jF/Vk7zFsUWGZ8Kr6dF/x1lw3JvxSXEfIFLYNRxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 06:53:38 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:53:38 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] add edma src ID check at request channel
Date: Mon,  1 Jul 2024 15:02:30 +0800
Message-Id: <20240701070232.2519179-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB10601:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd55640-9b93-4189-8e0c-08dc999a8925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MUEpgErghBV5SGUzhQBZUm1lBOxvQ8GmqRgd8wrrwFm/ZpA1BR7aCN92YWMM?=
 =?us-ascii?Q?M8VuhiuIndoUiGXgq3SX442V4xgpUTxDI4iWgh/wF8e9mBDCqM1LpHxiQrgI?=
 =?us-ascii?Q?7bDhi52S7fq1r4YDcxV/OwKZ3NB0k8r3oxIJi+htB/R5Kun6x0l0+HUCzPzt?=
 =?us-ascii?Q?DHmIyOYgkByMBYELkSU9rDaywRnxV8o7/Yd1ecPds/LNSgwnnDDJ7c6MhLm4?=
 =?us-ascii?Q?N3lItwn9u0vz96fGVpBBrPPYMmfyR5w1SJ/vsPBsX3TZWJmG6ErbioPOXDsm?=
 =?us-ascii?Q?LR0WsOcImSj0/69b6UC7u7i4P685aCB6PIqUjJRVTPTBVaRY6xLqxyZHsBgL?=
 =?us-ascii?Q?ZVxWSDfMFKhV6r8kfZtd9Bna7G1WdeEiZumLLt3cCitaOoWPul13KOdFTADz?=
 =?us-ascii?Q?EL3PDsJsMcV/TXzDJp7mETYn3LVjp/2uW/s0QRpHtZJpxiY0wn9PMeAvDpUh?=
 =?us-ascii?Q?FvEH9cJ7za3myH8H9zzQtJppmrzCnas5Y/giFyIF4UvJnpjk4VtkJXz8sqH3?=
 =?us-ascii?Q?7a55r/WDFP6+4uOopUt3O4D/UD2ZH9582izWQhEmfYlHh+tJ/TOSxHmo37/M?=
 =?us-ascii?Q?x1bw0wRYjIEIoe8gNcsjn5Xr1XBTZ86j3geXKuzdsgcrKf5MME3gTZ8RFb1C?=
 =?us-ascii?Q?ZNDRQGqbOBzCr4WWC+LOvruczlirIKzmO1BhTxSejSybou7zLF27g4wCMxSu?=
 =?us-ascii?Q?xDFQXLljyh0HfBChsnpoi/KGa8Xnvk5x1EFVW/CH7j4/K3LMTpfZbooG389G?=
 =?us-ascii?Q?jMAhLNrHLvOLwccZ15xkZeJLwzGa0AR6KhJTZpkMdY0z3Hn5QsGt8y8IjUPt?=
 =?us-ascii?Q?iYWu1y3fsLbcCqJt6l3T/WDnl+CPct0VZ74cegN5Y8lDypsVcGWWtJXM8PmN?=
 =?us-ascii?Q?fkfaEz/i4CmsOUVx/irLPJy6Lr+lL3PFdRJSR5Y5bIT5gjiQ24WCAP2hOgCo?=
 =?us-ascii?Q?Qeq0se5YarpiSc8L3OSivD/SnI/2bXoj+uPIz0Rw9FhZvz6/IufZVp8HpGZE?=
 =?us-ascii?Q?0nrEsaPNNKUjw/LHukE9+XwErCF4aOnBplmlplGLLwkgXJ35f+NVNz/MVdkG?=
 =?us-ascii?Q?IHXxGoiTvsFkU04ruKz6hDleRtC1erUbHazdxLf2ryVs5hHPOXOzoWQuvA7W?=
 =?us-ascii?Q?NagDsG5N6EYnN2fFdPG97Iqqw98L/9dTd7+ZaHDq22CAoVyzvq0Q6A7cLhEO?=
 =?us-ascii?Q?EyNGRqBD65ur5+iQ/j3IyUi/HKQFt+CvWsudNqAXtH400YBvjEm+V2idyruc?=
 =?us-ascii?Q?Ctkl2uIV8dJd1OdXz18eFtVMlIeAX9U+3A3/Ej7VU7SOD22gGsJPJuKrnGct?=
 =?us-ascii?Q?07kiZmLyK1jId4qXUDM6w8RmqTRUXVr+16E3+SupPCxhepVv2p+8Ew9zE7o2?=
 =?us-ascii?Q?9iIZhCvqNB+s5zSWyIrhx0gN6eUMqPQb8mCuhlKkmRvJxLLwXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDJVT8bM4FlTuHJMmXxC0JVdDaR/Tl6E4HUhkfXxm70DCqMQ6PW0E09jWh/l?=
 =?us-ascii?Q?DyZfRic/qXZ08KU16HkgT7b/BjDrTiUt0enIyPAXuG7WVFMpGyZUiqWELodI?=
 =?us-ascii?Q?Md+CjM5aHwsO2Z1iRWlJln8cdj6WJ/ySDLP4ea2k1LnNcXV3oNi/hMgvZFE2?=
 =?us-ascii?Q?XLTK51MG23lK6TmJNW5N+FGQ2SkYd7z5ZdjfmZgOjPkv5Tbk1UHJyNarAG48?=
 =?us-ascii?Q?fXUlIb/UTJAFc4PPdFQ0JCYDVQFWtJ8ydWXdmucnPPGxs+iShaXkM/TFgp36?=
 =?us-ascii?Q?EaD8VkE+ebZ4NO/BI8q3gO7lPCi8lMfliLexqrBr4jN8e2CgcD/Nz8Y/BhDv?=
 =?us-ascii?Q?ZRU7qzVjH51u8/Os3KwuWuYQ945Y5XhYXMC7kfFTaY6RLyTxnnJLSQsXTawW?=
 =?us-ascii?Q?YN/F+z8YCmVmvzBZcolviodEV3x9Nf9ccM5PrVO5ybEPbw9443RyEAVheRz8?=
 =?us-ascii?Q?qtR+nwPXJzFlobBLSd7Nt9mK/VZRhXf/EcM70NMstcBsuTxrwmc2kNtoIUBu?=
 =?us-ascii?Q?J+Y9NTVVctFclakEi8CrkI0fUO6PpweiYYFTMa3NVQvuCP0eYJS3HJ8hiIJX?=
 =?us-ascii?Q?3VvlYQ4UAvyBNh2CakBHmILVXDAyAhQizuY85dKa0lpqVggSbbLLZTPbAAvD?=
 =?us-ascii?Q?WOUTEun/icn7JHU/eUyukfRiBM4cW8yO9r8KnlzH59eSH0Wys776nqBwEjSS?=
 =?us-ascii?Q?bai4xtQ51PjaHPe0LTxRyb2cCWE4cJOYvh+92qn23kCWm4KYxObaMfIrLaID?=
 =?us-ascii?Q?edUopW0KJdnJBDx8ZoTccAFlkHqWsloCaoU72T95lJybjJrK6PcD76KGe7e6?=
 =?us-ascii?Q?1Fjm0eqI7rP4Vhw35dY9I5DEy2NRbFoWURUqy63BTZmx27IUDfTXDlE2Cz0k?=
 =?us-ascii?Q?W9DDDE81ghtgpGqeBrkGVO45w8g/YUl47goLjBgl5m1d3NgPIKUcqX1XFboq?=
 =?us-ascii?Q?9AxDXza6Y0jjs9ZTMEAxrcjfI2GGb53+1YB8Ztc47GQQqdesUzq4nv9WMMUB?=
 =?us-ascii?Q?d8cxVBi10DhSNfFA1W8YN0TElq/C/snGPQk70AYQAr0+EQPGQxsgBUmieLpM?=
 =?us-ascii?Q?fmMDmWVRrejdstUh7gXSRrTIVZQpJdlg5wrbEuXktY5waeBAIpdIs+TI8/Sq?=
 =?us-ascii?Q?b211inGUQiDmc2ds+QVdpBiH3jMloO9LJZ/9NijotN6GPeFi6+dS+6a4Luje?=
 =?us-ascii?Q?F4fOC3EDWWY/qAfSMO89N56d0beQ/7H1ahZirCwPGLEiZX3tDI26iwpX/Ci5?=
 =?us-ascii?Q?TFqjfn20KMoEIR3Qb0gWpsYAJ6wfvpGZj7ov7oF1S7oVogFnLJkx/pVrFtYW?=
 =?us-ascii?Q?i5IYpKhd/p4mVLgkzwElHPd3cS91IImR0B3d52l79zJhut0iXXcW2x5jKrfN?=
 =?us-ascii?Q?+dQb1b5cyop8tbFVkplEqJ1Epe3RQaT/bKI41bGM2bwGt2rNo08z6vVLyTMa?=
 =?us-ascii?Q?2/3gixExMgvxJxI99hKIKLO0dDVLfxdrqtWbFP8kCOL7c53QcDGSnWPLVsYH?=
 =?us-ascii?Q?yusNhYvH+VQEAz7T4hK6wq/KDDQ7t23uRxysAPmoXzx1cV2vvSHEYOa1WqrA?=
 =?us-ascii?Q?lVFkS2HfIBMnDWyaVrgSxoGFf0LBEm1a17gO4ydi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd55640-9b93-4189-8e0c-08dc999a8925
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 06:53:38.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZsGycN96m/VLfnzPzZV/hCu5m7D8z2Q4IRDZ4Bzf6oCSq0n36aFMA4d2hXvphP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601

For the details, please check the patch commit log.

Changes in v2:
1. modify the dev_err() log description.
2. add review tag.

Joy Zou (2):
  dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
  dmaengine: fsl-edma: add edma src ID check at request channel

 drivers/dma/fsl-edma-main.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.37.1


