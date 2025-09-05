Return-Path: <dmaengine+bounces-6399-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3710B45AD5
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8873D5C5ED3
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829337289B;
	Fri,  5 Sep 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ap94kSNT"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBF37427C;
	Fri,  5 Sep 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083515; cv=fail; b=gTmjz1D8q0dERonDnG2WFY2+2e07XUr2QGGzyIM8Bu8imRu1xA7iCjoCUWWWj6cySmwpgrk/pwnneyCzt/NxDksuyLuJf1PPwe0a3wdqy+Sc+0ECRqgOZeF0f4phLSn+vf3vWU6BOpwzg6EphjFHuj+xYZUor8TR91pNCCGUY2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083515; c=relaxed/simple;
	bh=UiLYL0apFnXXxEEcQpVVr2Q3CvDug/+00KW3yZ7qbak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtSog8pdClc6pqcvJsodp6V9p0xriWzjmfIKJA2WKhSkyCt/WktFFqDxQmo43F+cgZ8QEW6P7nGFwXovMuDa0CXhIbaqonjJ+mT1YrcBcP38dfS6hX26hMRVfgPgaSstTTapdhYjz6RcT6RK5xh8jsc/Id1pnL1enO4hKv81ZXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ap94kSNT; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8Z9quKjQLnlDXAkKu7Wl3cCuoDdEFEOJFYUuen/+iv0hTnwPegSEhMjOPYnasu8XbvBMC+shoYfeKh6q7utU0OQXr0xsbCy/I8wZ2qMk71uNg/ptyoSoG0rRcdGmx2WfJVWT+SD8T3PnodA6LpLS8j5luQjCLg+vYThCzNXZcg4n2Pidgyg1fuvfCanCyISyilqQHe0TR/5hEBOFwlSzcqcGUdRAmtdlMQ6O517AAN9PZGEaqk4Jpz3cpu90Jf2RS13hcB5qy4GyyzzbynjNNpr9brc2eLwpVD/nIfY8x/xWLuzAezg4nFIl5uXSVUw8KEcR7Qm7tMfpxT5BGoqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onuy4OGZVBDwu4UcZTSpwP5Z83ycnYNPUMR64w4oxS0=;
 b=CgQFlbE9D6rZNiGMobp6e+Dd13dwJtLVKZWBPy8Dk1CNQJOwxquIlnHJcRFt9/GcaxEvhC0IWO2rxHSSS8Ct1wd6reYMtHDTFRElwYjk3iRCGOsy6LHrg7rOTIMM0LB/5J1iIpZCdehNbgS7Q1s63A5eNyLuiAu9PRREa3mYEMZcGvpvFx+1UrgMfy/KqCx7bAszx7ycVz/2ol1rqUgAE7YpmEjWc6lrzga47RLG0+IrYKKEk7BNXqviV2WQbUWgLWVFdku3BepL+gP5aW2Q5gn4zDFqH7uddR3O3hX+knt2ZQYkkaiHBXUWAC1l6n4nHwAuTgWJbBWoV5EXCPWO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onuy4OGZVBDwu4UcZTSpwP5Z83ycnYNPUMR64w4oxS0=;
 b=ap94kSNT7yaDfhkWT/Y9eQj28NWs0ApBcsqp7pEUOb/xyaBnB71SvdIE4bI6/mA/UFTN58oxP1LgDpay1Avo2VxBgznTAo8kh8eBd7v36vZ3ZnFUMEJf2u90vr89NcsPk1hAQRndNWDPsVxcagV5EgUerh1ZS0szu7BaMey63n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB14067.jpnprd01.prod.outlook.com (2603:1096:604:364::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 14:45:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:45:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dmaengine: sh: rz-dmac: Refactor runtime PM handling
Date: Fri,  5 Sep 2025 16:44:19 +0200
Message-ID: <20250905144427.1840684-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB14067:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d352eb-da7f-42f7-0ab0-08ddec8ad0f9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nHY6igO6HnTbXXkwWp8m+nLH4wZyXp4O+DAeBuDPsJerByoXRkDMwjjNb3E?=
 =?us-ascii?Q?xaumEamlQZo5qtdUkjvZeTiIL1T0GxPawcqNhQx65vYZupiWzbfgH43W3Gmv?=
 =?us-ascii?Q?w3IACU/o/Pqit+QsiK5eByoOB5ohUIAAg70/6DVwlkFKbe5P69dqgFNRalst?=
 =?us-ascii?Q?1JiMNZhSmuAJVh30e/D+7lVXcWXv8L3JqmEFWVZDLYrI7AWenjh5AB/QZOMy?=
 =?us-ascii?Q?awRurSrNSST8ir445BrxVZeSdjjxhXH261idsGUN659hkmX+dIet0zqD6dIR?=
 =?us-ascii?Q?DrCZyDpSgY8N+Xsd7JUuqCNtBzfqhBaQdiWvYU9/xTWhSMe7+0QnbCdZCcRA?=
 =?us-ascii?Q?gsLHbsZrX4aVMXFkGwtqtSL8GcqgkFVTKqQMgXQRKEtlr9fjDta92lF1ekA6?=
 =?us-ascii?Q?mPTvvE61/pFZulTFYgrgjeGVw8vvp/ZshSMcVA704ON8WroVuhlPdnaimT9s?=
 =?us-ascii?Q?4HK8dXQTuSKjP+mmUKMtIOf1LGHzAYdR0fu0nowiAfGSPrarnp8Rtpr9Sivz?=
 =?us-ascii?Q?oiivhIVifr9SiK8/yR6OsZJs3H0tChqn2EXEvb557uE6X2X2vf8hPUUDhVXp?=
 =?us-ascii?Q?6YF9eDDvVwOJnRBt+WvAvVjPRYOnHuU0lTkHmdaYaG73OiAd/aW7NUiiHay/?=
 =?us-ascii?Q?KvzNw5eh5RiDKGw6klj0s4tXRT4qqnc1+nHvVkSb7GUpr8ynCqItDj7j0Rpj?=
 =?us-ascii?Q?u+4Iu6PbeBjFEG/potrmkBk9kdkGSMvS8IdsjfX0lgO97uXAg8sBMnDnz/B+?=
 =?us-ascii?Q?CaQrzhn1nFIZg2y9xzhUSbbMMFC8tQrtLomg4QkMIZMzEnoLwoARy9vF/awP?=
 =?us-ascii?Q?8RYEQ3ZUsOh6VfKZx+NAl5AQ1ipRu174xX+Z6CaiAmp0Ccfwo3J2PUwLu9Hc?=
 =?us-ascii?Q?e8RnwlQZ4tf2pMLWIWCTiYxwWWtfYDgUn/T5k6OI5ZQrcqQhmZo+LI9+588Q?=
 =?us-ascii?Q?nb1o+EBogLiVhJYbqoO4HaSMv9jLCeq8vW/ADTr/iOao0ImO7S+4QG3f70NG?=
 =?us-ascii?Q?uJKutXVnARPgSTGzq2ixh3D6G4sCvJonlam6G1nUw8UoLVUgGt5F0KSArV3K?=
 =?us-ascii?Q?dDSaW9qvmvT6CyXiEwEdNwZQiv4YPkdOaSYey3eMt7+G1mzLsukGONLcv1tL?=
 =?us-ascii?Q?UEFnN78DLFNJxrgBRGw2Ja6GuGBY+EqSgGbaBEeroVaJmyvqamT/7nTye0KM?=
 =?us-ascii?Q?XbbFvI3kSUA24mp0LalHot3m64L+kReW2+aKU4E9Js5ckb9QsBtMHuMOj1pd?=
 =?us-ascii?Q?GP0fBZYs4JjichgeeWYc7Oh+oPLqvlgaukLJztO7RXc97FRVaiGkJk0hptRw?=
 =?us-ascii?Q?OIdD3iu8rxiyzSIj9EQ2UA1y+mNZJktoAuOaMXjx24/JQoCOSR8LLIrJX4Fg?=
 =?us-ascii?Q?8ewVT3BRdRs0x2xbo1v+veq9YxnA22068h2EIjpjQO3oGSx3N2GyfS/76KJi?=
 =?us-ascii?Q?ojBbcIsRKiNagTS6GMPqgWH1a0y5qhR2uwPdpsxB7/FQRh0dTCp2bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkCvHf+Z8yRo3G0kASzFuH/NBVyoObdCLsNZKCtqM+scstRHg23eNR/EZvTX?=
 =?us-ascii?Q?KTphLbxTlF7lCMibGWQqxZ6C9kYSeTMwyQjpldzghHBKNgGuS73AEGSt8EPx?=
 =?us-ascii?Q?OaEWwWvnOpR3hp+VkMJiL76kwneIIRgTpy7L2E2jYk3x2hhCr1LwIJ+U7Y6/?=
 =?us-ascii?Q?9hcRXhBRlYmfqMXiJmRpyYFDjCV+KnCsWBAZzd5zbxoB/qwhFmOHdzeSU5gx?=
 =?us-ascii?Q?VDuwXzG7Px/Ncn2n7PoRycouPLp8y0I/Wf65YpDJlzbJcDpyrAeEGDtG8lSU?=
 =?us-ascii?Q?n+84zmKvUkNldq/Bm4YiybpvS6iMPri9vU9CQpFu8lxPkd71aNS6Vw9ziM6W?=
 =?us-ascii?Q?DcFVlfrCSpy2PSNGQjGF59760JkH8gmjIi2wFe8PAk9v0s7Qv1xJgtxeGtnK?=
 =?us-ascii?Q?9AhSQhU1lcVjvu3on8aZRZT0H/xq9wttHUuB5b85rk4Yat78loqROcMm0/S+?=
 =?us-ascii?Q?Xk3sXpugb6EnYypXf0ok2qZscBIzPtcxYK+m/2TlaOGNBzOw1inFDHG1l9j6?=
 =?us-ascii?Q?UfNEIrvbP9zfctCssuswYYd7YmwModnuQEDbvekCzEGIamlrx3P3S5VS1gQj?=
 =?us-ascii?Q?nVBt53tNh6vGjN3Va11BxJHH5aE6yFSVLaUguELE6HCLhux/MURvAIHKok/9?=
 =?us-ascii?Q?d/INxYxqxc9LOwZlg9t2B3vZlObS5UeWhpjTDLB7b7ksha3Si3wbg6irFj2P?=
 =?us-ascii?Q?Zug9zi8zv+Mta/MI9nRozWpmlDfhGjON6VJI1RlDwQEwLDtlWU8MjHdy7S3g?=
 =?us-ascii?Q?Aqx/aiQkdKPxyCf6JZjP72D7hL30HBOw/HJfGxduVX81cS5cKOdVQeeySfQy?=
 =?us-ascii?Q?tYVYPYl33JibxxHfTbzPUeV+QD6Lf/nt3xOamqYgR2CMCz5gMUSkwFSrkA/N?=
 =?us-ascii?Q?5QFEm49oNf3PrXQ96mambkMsf6BBfmFsNPbCffoX079MYspHDEaGqHQIcNdt?=
 =?us-ascii?Q?PS8zGEjSKHJfcUWq+XQHmUbW5WncdDvG8a1jaI0sAIevE9VhSgdPWSZPopeI?=
 =?us-ascii?Q?FKdKUBwin00cBxpkppvv8IDukTj1+tRt8JI31hQKIKHebVLhXn36HOln8gWL?=
 =?us-ascii?Q?ebWUhctzeeLwCtaziFfXWiPf9c+5RBoX2x43Q9w0IUsxCrhAx3WDiu5xBbJU?=
 =?us-ascii?Q?hRl5H5QS6Ikh9WLkSN+MFPNfKGCfA7F2FbmE5TKthDi2QjQ0MmF32iWQhd67?=
 =?us-ascii?Q?qS3mrMYrZmmn7Ge+PAg8cvaXR3NuQgIs0wNf59bR1xSSwj4GtiZkL5duC7o0?=
 =?us-ascii?Q?CrGGgIF/saHQEk2Jtn0uIXCkF39t7MkpIp40+rvjQSFIfqN2yqYacquufQea?=
 =?us-ascii?Q?ni306zoWLs44JzX+brFHSzmcyhuaNJDuyR2nZhut1FU6zFXMMiQvd6FvLoqb?=
 =?us-ascii?Q?BrjuIlFyVnd5x9lYWNedO+atOw1QWzcWK7SP7049T6SuzckM8cPuCr1ngnk8?=
 =?us-ascii?Q?ZPSJv1yFmt438iyb6vEr1NDYGEAHw37jQPOReucskbb0BOZ4E4D346qamIAW?=
 =?us-ascii?Q?yxJyXLbHCJsLd8Gktj+bIqlzGwY7o2Vb1Pbp2FlTxBN3hSF/k5Aw41EyDxSu?=
 =?us-ascii?Q?T/Yxf6llFJpbt2FUfysVR+i3THoiWa9vAEeathcaJyo3eOOwp82mb4W1KAgc?=
 =?us-ascii?Q?kgBfYeghbex6tsLlr1iNGXs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d352eb-da7f-42f7-0ab0-08ddec8ad0f9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:45:11.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/+kX8eRd47gCB+h59imL4fAd5lHrpY51DJdzj3zscxkHfXe0b3KJi9J1qJSIZq1O8T3t6yX4a5yLbRZenYXi8GvgxapCLX0LQvD6B9begPM7Z/lXp1r1gF+z57uUFQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14067

Refactor runtime PM handling to ensure correct power management and prevent
resource leaks.  Invoke pm_runtime_get_sync() when allocating DMA channel
resources and pm_runtime_put() when freeing them.  Add pm_runtime_put() in
rz_dmac_probe() to balance the usage count during device initialization,
and remove the unnecessary pm_runtime_put() from rz_dmac_remove() to avoid
PM inconsistencies.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 0bc11a6038383..4ab6076f5499e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -455,7 +455,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 	if (!channel->descs_allocated)
 		return -ENOMEM;
 
-	return channel->descs_allocated;
+	return pm_runtime_get_sync(chan->device->dev);
 }
 
 static void rz_dmac_free_chan_resources(struct dma_chan *chan)
@@ -490,6 +490,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 
 	INIT_LIST_HEAD(&channel->ld_free);
 	vchan_free_chan_resources(&channel->vc);
+
+	pm_runtime_put(chan->device->dev);
 }
 
 static struct dma_async_tx_descriptor *
@@ -1027,6 +1029,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unable to register\n");
 		goto dma_register_err;
 	}
+	pm_runtime_put(&pdev->dev);
 	return 0;
 
 dma_register_err:
@@ -1063,7 +1066,6 @@ static void rz_dmac_remove(struct platform_device *pdev)
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
 	}
-	pm_runtime_put(&pdev->dev);
 
 	platform_device_put(dmac->icu.pdev);
 }
-- 
2.43.0


