Return-Path: <dmaengine+bounces-3038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28305965D2F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8571F25C1E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88277179665;
	Fri, 30 Aug 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kakSq0N/"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B81175D3A;
	Fri, 30 Aug 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010898; cv=fail; b=dsUB18K/NBpxF7NLNqWqf+W43TAnN8uP5L8jShetsts510WSJxvsJYSGfZU3eBmX0atTnp6k8zViPZ52dYrXN1GOGIvVgLFOaLAfqdI1pJAD4je8xHd0IP717UDvC91BRWYUiM138XAP2zWozmEADDVTYIYHHRu0fX9utKvxaSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010898; c=relaxed/simple;
	bh=GvIc++rqEwozamJgPgjPeSpylRLRXAcXLbai12DeWFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tt7Dt3vaSvIgpoXte2FlZ2tpHdEM+m2bCAsEypEAnJwt+QtG9MkREVTbsI+yid2iEryBWRybgL4yXA/HfafweMzKsdkWJ621vR+VWIbi1xOEDYYgKjisA/rKdS/JkaKIJVbmLNLJiFZCR63p9LVYOGDsEF+Cs3k+O0vYB+6XcUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kakSq0N/; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q01dL9eW7sR1g3CETuiOvOck94kfITUN6iucNnG5vWGCdGgsR/i+iMFcHVsCLZz6SxPAoXtMt3n503ay5Q5YI5DIbTYUHzPzXDgg1X4K2ufcUWSievCXYbRZOPgOaQJy2GTpfAZacStOHngWWRc3fZbbXLwq6YH67QS7LH/i2yB3M/J1g3Vb7yE2Gd70CYNymLsJj+FVY3xvIDYsb1lCp6ac1iEHVBwBdTAFSYo/AcCwxnDaENLG6BTv2Yj4CQa5AJUt8tGc1fAZtgkyHqvWelSTU+k3I/jR4HsQWm1WA08i1eG1q59wElxbLyFEk/dA0mQFow/9ip9roGy4JMqmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMD1tFMtbjg7clIkuF6//6Le86g++J4t/EXP2XF7roI=;
 b=SAsOjIthhKjSbPiwH/0M/CNBcDUFrVCtvRHnENsy3e7xc1tXU0p8PXN299BlLJapCgfyJ9NHOjsxrsUABcDgYslMD/NDTnci81rJvvE6/SfnMwBam2J8MRgktS/BkceH1S7uKH1zXut8l6eV72fXnqmZfYlI+tYA9M/XaORflWlNWiaPlyKHrSh5v/jV3LCE5zOZEuf6ufiBSFOmHinb0tsAa/+WbtxET/fn6ny0MuBAzhO1I1jE7S/5D68nOaIMll5nzXA44iTl0U7ztmFl4Y8NkALxT/iiXZpa835ls4WzxeZvzDmyuVkvnfaZCeX61rhE9ZTHMXiEQ3FAgKZqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMD1tFMtbjg7clIkuF6//6Le86g++J4t/EXP2XF7roI=;
 b=kakSq0N/XhmMbzbgmJj9CgyvSzsSU8rnPWKRwkX3tHgyelvWrMCT8tmeDGrEs/1aqMnt6XY4MDmb/Au468m35PxFWOTjQUyypSacyS2pt5rnWgkPdQYJEYHduXVEnLHRh+/s7gCN6NTEd3lLDIiLURzoTwIuKW+qmZrtetJt/wWa59XlOuDqgWov1Tnnu0jl3VRcxb2+VKHZA7Cu6fb1Ro+5NSJA/zsFZSrsCDCJoAU9BuzeaVhDT1LcSHWKty9zdl6F/R5Qv85ug3KLKIsMiQdGqbLnfW9SEiaxTNCl4YfSfj4cnf/fpLSX2EGww6boBDt3YKOBPzuNWapNZ0rNJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:41:34 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:34 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 1/7] dmaengine:Add COMPILE_TEST for easy testing
Date: Fri, 30 Aug 2024 17:41:12 +0800
Message-Id: <20240830094118.15458-2-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830094118.15458-1-liaoyuanhong@vivo.com>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3cbb205-0a9d-4226-d357-08dcc8d7ef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rTLww4l/8YwNk+AkGkn5ZcDf1eY92y/nT0IlQysewdbZGMBdjEWhCmr8O1Nk?=
 =?us-ascii?Q?wQnWtAcM5ne2geNPPnnCS4kJrHxPrfOyPIBGghAIigJ7v0sWX/h6x1FIqevg?=
 =?us-ascii?Q?7HvHphAFV1DxGcqDp3lQ5XOYf02GZLQsSbsaMFVcmGU1n0DX3V68Hl25CTKC?=
 =?us-ascii?Q?eQxkuov2vOT9/+kubxE82sbLzZEU8mcXnLa/fJYgecvGK4FofJoPutlgwIOS?=
 =?us-ascii?Q?SPDFCjfJpwzQje2FATTk9OS+cFHfxN0oWdrYyk8XeFh2YpnU2pFOVo6dpTFP?=
 =?us-ascii?Q?Gw+xaUhiDnTjME4jerdso2zsDElHJk3UiAeTNwPQvVlYlJexvvtznPfv1Ucu?=
 =?us-ascii?Q?+wCFQJb69uiUcxzp0RvndwkkHn7QPzk/Oq85XMPI3rzfInbUSclr6HWKZJFV?=
 =?us-ascii?Q?XqsELlkrH79AvGUYLXoeWlA2WYhbj/zW/wx3WE6pRRklF/ZVq+w0mG3Ymr7E?=
 =?us-ascii?Q?AXE43PUnrTo+1mgibaVsGF12v7HFA+EHTPqTh+mSoGa6pLQiPKRM9xe1qpbH?=
 =?us-ascii?Q?TvbLRWMffZcS8NzkZhTR8Po7GLWsCkAUXayUtTGyg0Zm53qJff1I8l5fGqOC?=
 =?us-ascii?Q?5xu+ur8QBozTv5+rw47bGAF1XJTjaWWRFzEGemSRVcZeQFLFjvzp1pnIhrJw?=
 =?us-ascii?Q?got/iEvnqhRpWMGI4KqFUJTB4o2a8S37t67obrxtF+N2z2Ux15xx+lGX2r2k?=
 =?us-ascii?Q?1j9VVhZxOu+cxHEMp9HL6ulPS30o4iKPXiPGQs55DEL7lnUPZKf/TUxkvdOh?=
 =?us-ascii?Q?CGQUeTNsozV/OJaPWqwQXHqgI5qry6CU7gmOA3O3ZW81DE1bHfRc7BdqCyLY?=
 =?us-ascii?Q?FibUOAQn9nPsjCQfh+dF+CLLV2IZysvQViwAvDgDQZGYuPT7Jo5H6QZEc0Xy?=
 =?us-ascii?Q?jmTe35WsZIO+9ZnVWLD8sk/OkjVcfzWFjjS027OZrTCDyhyvpjc5PphTOgrk?=
 =?us-ascii?Q?dYurSY0Jhxu1yhPOmOLj4WrPpPGl0TSP0b5yiv5c9vaN9jeQeSdQUGDuv/J1?=
 =?us-ascii?Q?Xr93CX6dcGORpKL1W/I38KlBMhSPU92rsaZLTWH/FbeN4adnsECv5WqYpeg+?=
 =?us-ascii?Q?fJ0+ukPfRhYWFk9G885qiLiGiqdOzEAe11w3/JPeeuz/LPDLdtMolnf+n8bS?=
 =?us-ascii?Q?BS7hQwcT856mhNu8gPyIksVXtdbnyqPKicPOfQI1jS2Gmo89EMTYj/d547PL?=
 =?us-ascii?Q?4dgP5ZhKSgcaYOlMXZ9Y0hKrx/VCjwhUxFcSr2gX7ipzJO6yiLtJqAT+scl7?=
 =?us-ascii?Q?BWnWBLI6mQzCfPAUc8+H67FzSRBQeQoKiLa/sHWg8YoQpfse7fHfN3CCOO9+?=
 =?us-ascii?Q?oRvtptKc7ywdKcv1CvJQG6MEFjsMbGTLXIuNdSj+ZD668M+NJuao3o4kI/WM?=
 =?us-ascii?Q?jexl5YYLNH04j+HaTpLqMrS1m3KtLDwnSqEWgEdu6slopN7CRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MW/S8MERK5FgtKtuNRlwWRb6SS5NVurcJUVZ8y5O02Cap01AHv0SQNoWLQt?=
 =?us-ascii?Q?DWx5UxzdVeXSvTyz/mOD248M98iDb4A2OdK2Z2YJ6lG6/TY3szIZ4RL7gg6R?=
 =?us-ascii?Q?u6wpE5nDP4eCgDv+yru0B+YkMAzNCLsAtgAKUYyVL28ZtIMMtZohXcvpYdvQ?=
 =?us-ascii?Q?kbLZ5eE95u9htYa0gfPe1btg8PuIhdMahB47CPRILs9Lc0RGX0J5MxrI8CjH?=
 =?us-ascii?Q?X+HLjO1K3sWbPAw4zTevt3NICMKqM0cMoLwUg8sdrBzj9JgjCd6Y3fYq4vTa?=
 =?us-ascii?Q?XgexZCYkRrIo+DxheuGCRUuwN+poAmMpOSAgv1gJMyYMiGf23i91ZPOt+Dv2?=
 =?us-ascii?Q?xwDqxJ9rntgNpZkeLBi+GhSxLyclesLhyqN9G+yZqH80/iNS4LpKI4dytH7K?=
 =?us-ascii?Q?qeOLY+lu4m1d8lMUL6NA14p9oBBeD8RaFLHbug1bji9yiZrmE0ldZLY7/cvD?=
 =?us-ascii?Q?xggsXS6kug8p9ZXKuKS30nXd7zPr8PARqwXKuS34w8K5f8/iDF9T8T+acpNa?=
 =?us-ascii?Q?j0fBuw+1WYO85dftA2E/1KwZFZkMhl0wz4XOGMVYUqwQjtLaxHhH21CJx6YJ?=
 =?us-ascii?Q?jGKcUNlPSbXhB/b2K7Xpi+d3LD7JDyV05s1IICE2b4Fp8KMVTawgyKSborrC?=
 =?us-ascii?Q?14glPhK4UDhqIT11oIztIgAKMrJyiOGMB2a+IayQoIpGxxUz0uj0lO+cqaX6?=
 =?us-ascii?Q?NB+6lqHDJRX9b2x4i9/VjGD6mg25JEUwMiKBi7YvP2kB5x4FmkWDOvCe/4Oq?=
 =?us-ascii?Q?pv5HEB24Uqeo1AcP6HdhGnRCep5NFX53VxnisflvQGRBT83uZnCNRDRq2Q9z?=
 =?us-ascii?Q?1PUqYsMY0Y2tMc4689d/8Ar89ekus9Gn9lGGdiCOwIWowE9YUgU4LxACktFt?=
 =?us-ascii?Q?AgjKPgH/h1rdx7IA2+crQ3rFjLAwlmHf4c0cLOktMJfJeQq3+adBxPwtsPJS?=
 =?us-ascii?Q?1sta/Ul2flM1XqJwVDVn9YaRG5HSGhuSu2DXS1jPwuIQI9izLnR2UF9wGY4h?=
 =?us-ascii?Q?Yvo7kCVNcvj9bw9gpvgashIoURqJR7IG4i/SwLvy3Es70os4gqsDyFtjt2ed?=
 =?us-ascii?Q?UPPRt0S5bMBYx9ue4LzYNTwLkd1768ciRsDhOmg7sh0b5e3+9Qblkni5L2MA?=
 =?us-ascii?Q?7xoHPm9OrTumH/KdbrrVYBMVVlHm90IcvXVQiU6RGzAyBFsPOljjmeB/FrG1?=
 =?us-ascii?Q?7eynwTyeCwaS54OcCMLT8pj6dxjanXTkevkvxpsMa1A2OUJsBn8QNnvAl2P4?=
 =?us-ascii?Q?bILRlmXw2Cxsc+LC2uNIXY+C9AcRa3b6H5XLKoGh8Bw2mbCnWi+6LfRC47zz?=
 =?us-ascii?Q?DT2LoQgB/0QTFb7/8BfzaK7JA1MBZ5yGfErMtK0VW7Cc59oXULbCGlq0jREw?=
 =?us-ascii?Q?lmr81QLpFhkVPb93Hr/g8xRKq4UgJNGrB2uf/aOK4bp/ZU7pGhaZW9ayHK39?=
 =?us-ascii?Q?7wgcwoS8KHGoXnIvAnoE1+nlBj753nDtZZ0SEYRh8CoeiKaTzs9A6xwQnrl+?=
 =?us-ascii?Q?jE2YRs5d/qOdRVPvBQLLRAAXwi/6owwzYfu96pEd2+Y/TmHhzweHsxn5y4Nc?=
 =?us-ascii?Q?HTbgrGtiFBGM6j5mQ13RiI1jKfwz+6ErORuHxq6k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cbb205-0a9d-4226-d357-08dcc8d7ef7f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:34.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4/ToLR1fuKOKQ9sZYdS/9avJ1MvrkWkepljKNL/JmS6Lj6bnOijymTYX+QkU3rVgCNhNl7ViZBRi1HEwoc7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5203

Add COMPILE_TEST configuration for at-hdmac, imx-dma, imx-sdma
devices for easy debugging.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc0a62c34861..ca1ae677e0fa 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -95,7 +95,7 @@ config APPLE_ADMAC
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -264,7 +264,7 @@ config IMG_MDC_DMA
 
 config IMX_DMA
 	tristate "i.MX DMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the i.MX DMA engine. This engine is integrated into
@@ -272,7 +272,7 @@ config IMX_DMA
 
 config IMX_SDMA
 	tristate "i.MX SDMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.25.1


