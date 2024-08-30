Return-Path: <dmaengine+bounces-3037-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C09965D2D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7B01F25A65
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777C165F04;
	Fri, 30 Aug 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kOJ2SttK"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2061.outbound.protection.outlook.com [40.107.117.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EDA1B813;
	Fri, 30 Aug 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010894; cv=fail; b=rxjfTVJfsH4Bakyqvmt2vt6IbkQrmQBHhHQGyQxQe6pzj4VB3RBDtYPo/S+i3yAI0VqqrFWgr4g6tNSajKThxSohnWDS7dby+1MgN8M/xSvOsDFhrra7Qp+M4zBNLnglz+xhPQJP6NmaVdqPeXtCgSeq/x8DpPnBBCzfiJlmyWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010894; c=relaxed/simple;
	bh=jcQW0lF4wNtB1LF53XHCx5NMKifyuzHDNByXITj8cgs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rdt1ccWShs6Oeo/OSuy8IhG+AdvTFDS+fc57TVzBEVw/m8//YbXrJu7L8O5haL+0YH0xwrSYsTZcx09r/TnRJ0r0dnt55YihGqI0Df4jgz1n+rdwsONTBvXFw7AfQtq95203RDpzRf2jKaIhxRuzcEmnO1nuB78e87oPxmNAlN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kOJ2SttK; arc=fail smtp.client-ip=40.107.117.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmo61xpUXV68by2AlRw58sGeypVoLKLWEJsTsGnQMNY0zU21dVurs5InshMIuMKISFDqdRKSuYCTB9blkuU6F24F3Vns1QLULTT3GEcUfH7GbHD8BbEugRLEjAzE471UqWe4OI6av209U/SjMpuK4X8GyL9V6PBvIhWEvaOuF/Gm8shb6FdVKydOkee/yyMcnKD9L2KADa6rhEjTezui7Fz0tz9r+txzn12ckB1c3hCx4nzPkd9Yjup5yT+DzLJfiRjDypqn/SZ1GxrsniBFaAcen2MwzA0w0AZyM0Oxvu6QKpbOrGMviOEiKtI7f00koMjRzTSHw8YTPag7VQOYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B10NzQfC9sbMghNKpqcp/ePrTB6oBQF1jjvC1d3oQgQ=;
 b=yV492QNki0xJP35xZE3q4aB9Bpd3J4U3EuMT6I8N9WD6DSpP8P1xMTqBDWMsieqU3EUqN1uxnYqkxekvlIjDg2Zchdq1e0Bjpgh+gLwbIK/EJBDVRFRm+XXIQEySSgiJKQoJaDTdL1kT+K0adovdcBWuqGdDW0yKTCICuxJXJoGBWErT2dJFWuEhD7BP8JCMbEKRU8Vuj0ZyXpPdZiWQwYDQx54J9dUrz/XXWoPbJPY+O7zMV4MuY7nGqy9cmoOLHndD9PPEyH71lpQI2DrWv66k6dFEU7TSDbAAb45wmp+M1IFL5Iqeh35Vf4KvOKhpmNQfpPcvbSAQxIMeAgva4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B10NzQfC9sbMghNKpqcp/ePrTB6oBQF1jjvC1d3oQgQ=;
 b=kOJ2SttK3+ItQ+P/bwYSLacFpfBwHaLl0ITKDjdXj8NCWo7ruz/h5QAi+kdGT8T6n9i3FOme8MpjHhb1u3prb5zw8NZ0kla8XV8mHuqcrR2o9Q/469EFoIXPfBLVskQ2w/TlT6DHZw/Is0Kkpngs3F3nZ+KU6RhuOBpnEdQsuzXsQloRpFnGqAtfZzkWBQm2hGg/1/Z9digSEJ39DMC8/NhS6xIcKKkgwwfSp9+ZhQ7cgV0VPwamF68EIwEzfcw2/pj7NkRKHPzr/+TI056Wb87tFJc712RQx4DT82XqeThnD1P3GAdJ+fQUGjgCXtoFxPaxiVEBL8n3Su1q2vk6Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:41:29 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:29 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 0/7] dmaengine:Use devm_clk_get_enabled() helpers
Date: Fri, 30 Aug 2024 17:41:11 +0800
Message-Id: <20240830094118.15458-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d61365-c447-46cd-ff0b-08dcc8d7ec91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNXJjTDH4W7hGVG1ty80RM4+ZseZx4ghbU2HCPbU/XU1J6ySa/Y9dIbsG7f/?=
 =?us-ascii?Q?+stV2dsPBvQos/ywpWUrGIuCjq82AGIkchHzLu4mRdxkgXtpT9D38pcna/BS?=
 =?us-ascii?Q?jngNDOzFAKb0PKniMTx6HuZ6PNUzo0kIZriGDfxSe5xRSB2AkuxKb7bks/mw?=
 =?us-ascii?Q?VPVGiwXnyv/JxhXRdbO2ZNC23oR80uOOaWs2Fi1c8ZN8X+1QZC8JxuMEFj2B?=
 =?us-ascii?Q?CxDPKUR0Tk9D1cHIZ2F4eodZ1tcYLMYUQAww2+R1gED82JHS2Iz4MO4R/jQV?=
 =?us-ascii?Q?sT2lDNwg6PM7yjc0jZsujWdmednP3+XWSUTe9pPg5VkOyDzmDb8O1h9pBYFY?=
 =?us-ascii?Q?uza2GWQYSF4Lmv9vL7e5OgGj1yjtLyci8kZpjKid4fUWjMdi2mJ9SQ1B8vpd?=
 =?us-ascii?Q?P/6nDB62pjQ30xTPbMMvqEKuN8TFDBVLlf4AOYoRgmpuNMA7Ae3TUFr7hkEj?=
 =?us-ascii?Q?D5KsnT3FpbsRRDWqmM53QHf73tZSGLdAmyfCsQV2NwCuR8i0d9kT9PmRFkWf?=
 =?us-ascii?Q?1++2s55Nkfn5bdJPWP1WUhb2/c03IbrFfsxYTZz8Hd2IShhAOoMnPoe+LeyR?=
 =?us-ascii?Q?TbMUAnD4ne/ui1J1tyJiwE2y0oPGZr53+GuubrfaZ5DKL+OYSm//BLTLjcPo?=
 =?us-ascii?Q?gsW7knbE0lvK9epKcAp2+NPKE3QtYPYQgCtr7NRsD15di4fIDcKpwCEu5Job?=
 =?us-ascii?Q?dw2XrHeGuAV5dlkj633YXRQ1Fq4Lb+6y1MLatxkhrjBrd7S3fGplvqmx2Ksi?=
 =?us-ascii?Q?fMio8CR2TzEsEkuNUgqm9r9NGFecJ9VOI1SH2MYJgIGfnE+g26B1U14qhtGU?=
 =?us-ascii?Q?ioLG/MXlLDCzaD0aNCYD6dITnPEGEEZzPOu3rqGoVmROpfaygYQSeQrgWhSM?=
 =?us-ascii?Q?lpei+Jp6fPV/MmlcngFPUfDje9HBmE2p3EL2IR7jqvvZT1yzMZERTipRaZhz?=
 =?us-ascii?Q?dWv4yB1Re3nm1uM38U+RIon7/i78uZtl1NR8XPnbGJ1GvkG7SSqtDciwEu4b?=
 =?us-ascii?Q?TOI9iQ89ZhqA5AL9pRW2q6pLQDn5ynkJ1Nxe+DnH3Uj2KCZE2hBS5eSWUdRX?=
 =?us-ascii?Q?di6dS4ggbe9aR+G7bbX40aZleuDYp206WFtpXAuQlJZINO4/ldS8ADongg1Z?=
 =?us-ascii?Q?RIm5kgea/EFxBxHZGBIU8qlxbvTkvdEPwnh49ilyqRkricNAZ76Nl/mCHKGj?=
 =?us-ascii?Q?4QA4qmuLt6VvYB1wWtWRapxFu4Rukygpqt/1B0R7ci/aanUd8b27O9gGP6Xa?=
 =?us-ascii?Q?MNka83O9X+7xYGh1Ld72U0nGowSo84TVz8e/EG9+ySUGRE85+vZLKot+tEVa?=
 =?us-ascii?Q?ltCFA9AhHCypGnrMkgD4O2kvXQHVI8RwD5TCiwWwBwmTI5y7SLtKGKFOIHQl?=
 =?us-ascii?Q?LD5gTW0rH2RSqMKVPTCXRItJBR9BX/bFwVyByJN9xsN7mkpuKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ST0Md2ZPpWVNgYEtiPaUia5dsUflEa9zC+MZPwB8q5C1kpte+UCt+TrynBzY?=
 =?us-ascii?Q?6drmKNsRB4Y6vNxgmEiD6Mg8oaHPUG5qr47Kwk+hiOOlYO1AWETTpUfxDUMJ?=
 =?us-ascii?Q?4mrQc6O1jeTLrWVX0YunU+I/E4BCuOuAwY0T+ZTCHkz0Z2wPwM83uxwDmC0W?=
 =?us-ascii?Q?gYNisFIwP+0Z0kW1+xsT3NlKu8DTmPYftyv9OcT+G3JBmDXEQ4vufV7+3Jop?=
 =?us-ascii?Q?VP6lySP0umvEFDd+SVV5JrGhDWsvYuu2wIRj8ZOBovxaZ5EvpP2YPcoWe2So?=
 =?us-ascii?Q?vzXsGXl+XwO/i5Fo4Q9Q9qwOc69yMPg/QIJS1CC+3p45f51yHmhCXUMMLsQy?=
 =?us-ascii?Q?EVhiM1tLnlEoNiJl7ti8uZeuwBInG3/juwzK/t+ULEQu2tb9CSLsGeh36PRT?=
 =?us-ascii?Q?TbDLwjQQ6OvGNdIBUTua0vQIE6Ygudi1YAt6nnhbZgkfqIpSoQYD1JK10dZK?=
 =?us-ascii?Q?1ekCQSsiCetZuh0N7OJetSTER3h/GqfgCDrJ4Y668gPRjiqKCFErgi6+fL/+?=
 =?us-ascii?Q?V/tU44rn7OomXqoWaRV0LAEC5zLIrRO6VIWyT0JAAz4uDKx8KfZsixFxQ1EG?=
 =?us-ascii?Q?p70LZbLPWTgQ8HaVo6Z6g4UwF+VxQmz600hACMQe6o13ZnmpzLOVLpHMXro4?=
 =?us-ascii?Q?Hff5Vc9qja8/fSiMDgC/WtKGXcIZSTGVApuq/uZSZuXywzQ774kqqmraCXVE?=
 =?us-ascii?Q?xXGYvAM04e9H2sAPjJUyEaSlA6d17m30pzwSULCcIYyx6cGk4u3mjeZqKxim?=
 =?us-ascii?Q?RRNqSVlPo8/timgRSiUxrFdD5XZfk7IgZFeloNluNW7iTkDc+7rRV0pEnqpM?=
 =?us-ascii?Q?aKrUViYKTFGULCZcoU3YsBsrf62OFkcu3JI/ygSX8jqrBMdLIjCMubF4jMMS?=
 =?us-ascii?Q?+6B49BaQJvGKJvXhNNGklh/i3T0ctuMm2gsZWEAbR8vjYdZGtCVcGf9+Ko2Q?=
 =?us-ascii?Q?UH9OKyjQsGr37VN4MGLkY6QoElB5YJSUKkcOPJJ0mXlV9CG+2zln9OcVfZDj?=
 =?us-ascii?Q?toBX47SxXIrLKatXd8FUOcihlwWDnqMdWn9z1nEIbeJTutGGLxKR/8uA/yRP?=
 =?us-ascii?Q?PuwsZ1TfChGcGKeQiYsA3JpCFKaeZE7L26OPFvrwN6TmTF0/RUhAW8f6UwWB?=
 =?us-ascii?Q?ilU6f2662XVjq9Gbda81yu/KJBRjcfpdmkzanz1x65E+OHRkmkS1FvrU5r2B?=
 =?us-ascii?Q?j3fAyHzKA+aaTEtB7QoLZV3qv70+s10fghKZNUJJ5z0z4AyfcSilSSbSP9rZ?=
 =?us-ascii?Q?bbvo1YGzbiv9edxXQZy6VZBbEVPlkjwSjqkkrgx5CzlWCFAYLk/aKz5tBVKU?=
 =?us-ascii?Q?vQPlhig4P8LxprEAJWPxerkx6mfN2m45DWfx9sT1u4qC4D3Bpz9om0lNnXp4?=
 =?us-ascii?Q?QvunZkG3MSD+tJUMyiozCWLqxl5HVXlZR8WjLv6/Dh449CfE8xZrqTnTL/iz?=
 =?us-ascii?Q?mnE059+I9YwnSNZPb9E3YGdgsAYNfeKHlvy9oaEkRn+MX7Yi9vVMw50xLXQY?=
 =?us-ascii?Q?sr15re0ikrAuKLnDONkYyjATdBYoY/o7qN/r6E9md1CIZnNZl/YHj8FXi+CO?=
 =?us-ascii?Q?moc1sAMZyQT6iiCcym3IhEnDI31b/Rkq5Vfkmqwr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d61365-c447-46cd-ff0b-08dcc8d7ec91
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:29.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+h+25TUowwemYGyiE3RCxlmGddvomfsYDJpmjz59MReMtiKcTu/DFEHyjMOmqW/Gn3ueSdjd5rN0bcniICkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5203

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().
---
v2:remove inappropriate modifications, configure COMPILE_TEST for easy
testing, add devm_clk_getprepaed() for imx sdma device.
---

Liao Yuanhong (7):
  dmaengine:Add COMPILE_TEST for easy testing
  dmaengine:at_hdmac:Use devm_clk_get_enabled() helpers
  dmaengine:dma-jz4780:Use devm_clk_get_enabled() helpers
  dmaengine:imx-dma:Use devm_clk_get_enabled() helpers
  dmaengine:imx-sdma:Use devm_clk_get_prepared() helpers
  dmaengine:milbeaut-hdmac:Use devm_clk_get_enabled() helpers
  dmaengine:uniphier-mdmac:Use devm_clk_get_enabled() helpers

 drivers/dma/Kconfig          |  6 ++--
 drivers/dma/at_hdmac.c       | 16 ++--------
 drivers/dma/dma-jz4780.c     | 18 ++++-------
 drivers/dma/imx-dma.c        | 59 ++++++++++++------------------------
 drivers/dma/imx-sdma.c       | 22 +++-----------
 drivers/dma/milbeaut-hdmac.c | 20 ++++--------
 drivers/dma/uniphier-mdmac.c | 20 ++++--------
 7 files changed, 47 insertions(+), 114 deletions(-)

-- 
2.25.1


