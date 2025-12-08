Return-Path: <dmaengine+bounces-7533-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F88CADD13
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B39AE30096B9
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DB2C21D5;
	Mon,  8 Dec 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4v/eav/"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCC2D4816;
	Mon,  8 Dec 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213815; cv=fail; b=ZPFbO1LURpoxBh4zeXzFghm68UM7OHM7jGtMXUF8OD03nkGXO84YYdDwVeuqn8Isyc4NRhH4VfDspTksq3vR0sDs8oEVbS83zCP7taFFgCl2JQSZfZ6ddXQefq+YKKEJwQyqhFVQaGOATcHnrEkkAh5LUxJSBL9PMjCg4xr/evU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213815; c=relaxed/simple;
	bh=y3+TVV9Kj9vhiUDz2E5rnRGVhWEdDFrbjbn5SkEAMvE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DKcDrdYa704FtGYWwvT4kGBWzOXPkxm8+Zv4K6jmryijfMyeYbejqQj7+zZu8ZyP4A+xweYQAPVN0QOAfVEwhG0bZisnZcZ0W5l7P3RD8UpIkTbO/TmrGpUkhNfVlpRYL8aIg2O88U9HChJKAutfH5EATGswbcs8JQ4CIohMGrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4v/eav/; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmHzN9aVqc644JEE0aqBPcotQkgD0+N/AnhxhsNyHswWWkFkpEsH/fhGrEJoc2EmxGEClwMOMXgMsGC1y9fVqcgXVZ+pYHofvl9p3mlwm/kCMxt45zGFtFHwP9J7GdHNHtFWjf7YPif/s/19dKWyc9jAheHMFRUlfYFkaHcxcciWJkngkXwlq4mFJo8PwSpojS6GI0ocFWmx9nTNx+BbVVnJjZtu3i3HcUxRyMEMJ1UeKxRmyouSgmkzQj1GeQvcjnXaxzHNBUVQ8m/gQUxYFnlTXZSiTazCKIoQG3PeDP5MqvE/rKL2fsvl1AIId4II7yVlOCPpYxnCL13sKcN9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66n7/T3TyiwaDr+Jg2tIZl/UqibsljCsejhsn0CHizM=;
 b=rHraJAfJyy5439onRopaC/HSZrOJQ2STyOB+9rRkk9NJZHHt0rOB0stTbm/2Tge2dzNQyVZ08c12e52eszW/eYb4jjbCQ9uVhD1FyRcKwa/DoLyS9rYd0SnhxE2ZwJYhGpPBkEUpG+zKmNNX2BJi+vGRLMWbC37w2js1d2u5IvCHnL4Cr4o3hBexaVyNMY5gRPlv6SM8Ok2h3qmIJeqinyzd4DEm1X/xvcS2gh0Ok2tzp7i/M0ANu9cyP70ZEeZjXvqnrO2dRQ7M5hMEXzf5N7m5CkG8e2qB5dUIUa/hCeY2JG4YYmHqUkCyJer1l5lxGH+arChz3/z3PDe2CafZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66n7/T3TyiwaDr+Jg2tIZl/UqibsljCsejhsn0CHizM=;
 b=Y4v/eav/JbXvAcVLvU/VaIinD8tNvxd2zsM6z+jKVYJp5xEBTx/5S7DJJ4wHMQLsAn3nm/D/y1mzKRja4rVijPYNanH0YdWuQLmizu2lX+xrve1ZKqsd5wKca7SB5+vjGZF1oxK2g7EICHjcayXi90h/UgS0z7Y0hYtWiHgTIUVIOKH+WyfQZfRgL7CqDScIUERjvvMWEo+DrgX5TR54SiiqKYMuSerF6zcYsSKzVgkdQ2pzWJjiXgCW1lKbxT1Mu2O8xxmVT2/DXSJg9pUdps7T6DsfXvT1G0qFDmd+Fd3VQ9WAnZW9PA0EkzCAEawi/K9vFcKu/zCws5DbK+DXMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10318.eurprd04.prod.outlook.com (2603:10a6:800:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:09 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:40 -0500
Subject: [PATCH 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=5369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y3+TVV9Kj9vhiUDz2E5rnRGVhWEdDFrbjbn5SkEAMvE=;
 b=Lw4DkSmZjIIm5+06czFVivCRi/r+f4PbaD+5LsTF4RL+KbZKQtNnPh2orQ7jJuxzRCs0NhfTk
 apC9qpQIt6QBOSz1lH39Uvtn9e9w3qp+RkCWdUva6lThK8/xyREVjzq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10318:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dcb348-0c76-492c-d12a-08de367ca406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTRPQWRDSmJXNVVBWjBicURwU21SaUhUYndmM1ExTVhvcGc3LzZTbFlwUDlW?=
 =?utf-8?B?YWd2bUwwUGJxbFZqck5OQzU1b2hTUmtwb0M3bzFDSmFPUXQ0ZnNrUDF4YStv?=
 =?utf-8?B?REdjTjVWNEJWWkR0ZEhPdTRKM3RvUG0wdjBjNVVWK2VZTnU4S20ycm5LMFV3?=
 =?utf-8?B?L0dhUzg5YlFPRUt5aytGYTZ1NzRHT2IwM09LWm5iY3p3MmtvaUF1RitCeEpx?=
 =?utf-8?B?QWZhZWxNbENSa2FicFBLdithZjhkS052WmNqYTNZU3p0NFJxQlozNjZhU0cx?=
 =?utf-8?B?dDJPd0F5NklTOUpGdzVRT1VYaTU4RUJNclFNSzR5ZGk4d2sxT1lHUng2SGJa?=
 =?utf-8?B?cmpKZ09Xb3hDeTlGbU5yYmpjVnFpYUt5RGRhZ2IxUktkcXpCV0g4Zjk4TDY1?=
 =?utf-8?B?emR4eXQ4eG1LL2pWY3RmNi90dTd4eXpvU0VxWW1PRWM3ZE12YnNIalJhZ1Y3?=
 =?utf-8?B?WEZUZ0dXbXovYnhYMFNoeW0veEhwbzcyZzhvUUMxQVFCcHJHRW1CMjBWbWtq?=
 =?utf-8?B?L0FLN2tPWkpHQ1RnTldpVGRSdDFndlduYnlDSTNkcUhLTStjNDdnSWZFMld4?=
 =?utf-8?B?OTQ0cm9ob1FKczZHSHNrMDFOcDIwMisydERHL0hsQ3dZbGRkYXJXN2kwQ0pG?=
 =?utf-8?B?d0pvb0lYUC8xek5NcGV4UGs5b0VnR2hTaE1hUkZuWFdSTFJUdGo3MWxBR0cy?=
 =?utf-8?B?Y2lzNFVwYkltZHRmNnVNM0dEVVY2QnovcG9yekZtMDNoYUgrb3M1Vk5Oc1Bx?=
 =?utf-8?B?KzZiOElBQmpwbGczYVA5eUNvSU0yYmltNDl0eC9yd3R3Wno0aWtYZVlDWnNy?=
 =?utf-8?B?QkV3YjM1RitveTFOdzZoN0RuMjZETDVhKzI3NGFEVllDN1dsZDFaYUNVUkp2?=
 =?utf-8?B?TVRzWE1nVjdzODNSRjRBM3JwNXh5YlIzL3Y5aTcvcVJKdFh4OERuVzRpU1dx?=
 =?utf-8?B?b1Z3Z0FKN3NsN0loZlVwWXJkbUJ1LzR5R2h2elJZR05aanFwYmRkYTE1UGVM?=
 =?utf-8?B?Z0QwS3RLV0k0UnU2UjZicXFyWnJ2akhFTDhjekJwNkYyK203cGgzU1B1RkVt?=
 =?utf-8?B?cTRKMGNTZDhxd2Q5d1BMVTNENHVEVXZ0L3hVSXB6VTN3cFViaW51dzZFTnEz?=
 =?utf-8?B?aVVJNmFYRnYxNjYzNzVFalpWUUthd25MTzQyREVnTzkzYnBwWXhCRkc4dWR4?=
 =?utf-8?B?dnJMY1R2c3V5ZERVdEFpUVZ4cHJHTTkrdWs1MzJSSDl6aUhMbndLOHloN29s?=
 =?utf-8?B?MFB5RHJTN2QvQ0gwRlZzUkkzOG12cEk2WUNKd2hYc2x4UjRpYk9Qb0FERkJF?=
 =?utf-8?B?WGhHbjIrbnowdGRpVDEwQnVZcFUzcUlUNEJKQUxrbFBFOEtGVEJHK3BrSXpv?=
 =?utf-8?B?amg1SjgrQ2x1c3BIWXlWaCswc090WmR2cFUzcktGM2gyMXVFdlBPWmF0R1NY?=
 =?utf-8?B?M0lLMkNsNmpJZG03RjU5OTdpZEJMUzJ3Q0tRUXRHSzZOR0FwL0FrN1BFbXlu?=
 =?utf-8?B?dnZteEZEMHdiWDgya0haeGNZbFZ0bGplemk3TWZBR0FGM1gzSVpJN285cTFG?=
 =?utf-8?B?ZDBFOTVtcVV6T0w2WlpUajdBWlNKdWF3Tkg4YUx1NXBZUzV4cGdhYXlJaWh0?=
 =?utf-8?B?d1AvMk5QRWlOcVBWZjBDSGJ1VDlxUzJhVTc0L2J1VGQ2aCtBZytCMkVmNkcz?=
 =?utf-8?B?MXdGYTNYeFAwazNFNjhPcGprZEs4c2hqL0diL0NCVkh1SkQ1dDFFWm8rSUFj?=
 =?utf-8?B?c0llcUNZamlYVXVXNEc2c3psS0JsdVZxaElZWWRUU0JJcm9DM1NObzZPZU9S?=
 =?utf-8?B?cjJmdGRRVXEwUGNIYk9WZTBJMHJZdkNFdlNOeWh3STRFNGwvQ0lQMWJPUGdK?=
 =?utf-8?B?dXcvMmpSOEV2ZUZCa3RZNnhtdi9SQ2lxRGo5VlRwakVSbWc1S0RobG40aDdk?=
 =?utf-8?B?NzRSRXJsMzNhckJZaStFTDF2QW50NndhUUk1dUtLMzlXS2pjZCtNRllGOGpz?=
 =?utf-8?B?bUc1NWs3elNNUy94SkhmQTNtOEVtdTgyREVuVWtOSkZoNFRXZ1VCSUkzOXdU?=
 =?utf-8?B?WHpzZDJWL3VLakEvd2hGcXh1SkMyaFhOWG9LQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGM0TUVIeUNWOTJERTNpNFg5OGNkTlpyTVdLUU5oTVp2OE95bG9aQm5yVmlZ?=
 =?utf-8?B?R2c5cVozOWlVeVZjSGg5Y1lEMWgvRjVQd1ZpU1FnZmV3RmFPNVU4bmlYUWsw?=
 =?utf-8?B?SHdjcVdJSjJvTlNlTDFYTGNVMHp3NExzNFMvUWhrZms2cVc5Nm9YcnBJMzhK?=
 =?utf-8?B?S1BaVzhERWRGQU5vVy9YRy9EWUl3MWt5dzBCWjhrMTVIeVNKREpBZkw0dG85?=
 =?utf-8?B?RGVlc1JwTG9xL1JLUUFKazdhOExBZlZsRW13SzEremFaaCtzd3dpYWJuc3l3?=
 =?utf-8?B?QUVyMU1FVHRxbTM2TFBXcVFHY0xRK1ZwcENlcmhWY1JPQzg5MlpOa3RsMnRR?=
 =?utf-8?B?MmJwdWxScjMwL2tFc2lGM3RQOVFxb1hnK3YzTlN6QzlqYkc1bk8xUkdpOU5p?=
 =?utf-8?B?dHduVms5SWVqdEh2dlRWWjhkTHVkNVBYRkY0c2hHNXlPZXFoeWRKWDJubUF2?=
 =?utf-8?B?blFISXZZNkRldlV6R0EwNkJRYTlCVXpkbGdwK2ZhRUdlTXhyUjVGTGovN3FR?=
 =?utf-8?B?L3VMZ2JJVlYwdCtnUE9idlE0akl0K004NzYvUUpUUVBNWGRTek9BaUU2Rllo?=
 =?utf-8?B?bjg3UHRPMnhtQzZQTzdXczRSVUEyQU1mMXoxKzd5MmI5VkpmK0xzdUZveVp2?=
 =?utf-8?B?ZzBkblNZd3lGRDlWMDJ5aW1rYm4reGlOM2tSNWhDR2N4TkphMWl2eEQ3aGtm?=
 =?utf-8?B?OGxuUW9iOUJJTDZFYW42cU9UUFlFZUtYalVNNUFwWlJqQjB6T0RGcVRvRXVC?=
 =?utf-8?B?R1d5N0t5UUJvbCtEV0o4TW1oOEFpUTgxWU5TRXJkbm4rUFZqRzREZzlZdEJG?=
 =?utf-8?B?TEdPUVRhbEIrZG1NR0d3QzMreTRIS1hTdWRnSTY0UExNMVpaekF6ejF2MVFK?=
 =?utf-8?B?WnZYTW43Y2pkdGRqdmJodlhuejlvTDRVYWU4SE1DVWViVlFwQ0V0YWFBTTBH?=
 =?utf-8?B?TXlpYnlCclJuazJIMGs2WDArMExXejdER1ZUeDdHTzZxMTRNdkEreUxINmZ1?=
 =?utf-8?B?dnVyWkdGMXpaWGpXM2doN2FtdTFoM1hkMi9RY2o0NTdUVUx4T0FTb1ZuVkFM?=
 =?utf-8?B?bUdVMWpuTlI4Z1g0TS91dnhOeDEvRDNWejdZZGlSa0hvNURPNlVtRjFHOW9a?=
 =?utf-8?B?OHE3a2sweVZ3WHhiR2hiSTdkaWhmYjllRVlQditkZWRiVGM1cyt6b2U2ZC80?=
 =?utf-8?B?RW5LUkZDMHEyZnVEVDdXUkdBdXVpRGt1Vyt5YWZFMGF0S0RhVG12eVBISzI1?=
 =?utf-8?B?eFlBMUc2cXVIdkdxZlcwc0xKTzFEU2xSeUxtMEhDWXZIRWM5VDhzU2g1SEhw?=
 =?utf-8?B?QTlKeTJqRmUxZkRHOUdyb2JtME8zT3d4cmhWOWwwVzJURCtTSnpkSmVjOXRJ?=
 =?utf-8?B?OW5WWXIyNDlrVlFyenVPZmNTc2NGempjb3A3VS8wMkVrM3l1R2VNMzZzcU9M?=
 =?utf-8?B?dzQ4ZlpDNW5oaTl5UGRUcGRqVng3Z2RvTnoyY3lhTzA3amZJQ3RmRkJoNUhw?=
 =?utf-8?B?ZWdpVmxCa3BRc0ZPNGVjMUNxcnh6YXhaSU9HZjh3OVBUZ3lwRkIvUERnNTg3?=
 =?utf-8?B?WGtZN3ZsWVlFRExGRm9HZEY4WUNCdWQ4L0M4R0ZEeG0zb3Z4ZHVmaXdqTTBU?=
 =?utf-8?B?VGdMY2E4RUJCVEcrcWhDbHdIK0xJMHN0MHB5c1c2d3B5NTNxN3RpRWFBNmFy?=
 =?utf-8?B?c1FSbHB3TTRzbXhCYnNPR0JNUE0xRHJNczQzN2tiMCs2YWxhb0t3RzNiY3Qr?=
 =?utf-8?B?aHk1TUhWdU5EV0tFZEhpUVRVTmN0TU5VRWhTSVIwQjE1bERaS25mTmJQc3ZX?=
 =?utf-8?B?clArTTNKSzF2REErVW9PUG5TZkx0dHVRZERWSzJUN3Zhc0pkUEtEbnVUWmxl?=
 =?utf-8?B?N1N2N0J4UlIrcTBUSVRtemRNZDlSejFLR2VHZUsvWiszUUxodnk1SDZkcWFH?=
 =?utf-8?B?Z3M1S09VQ0IzWVJBMXkxYmJpdmRBNVBCYzI2R25XYTQ0UCtaTHFDSzJ5M0w4?=
 =?utf-8?B?YzRuZ216dWVRMjNLaW00WkJoeEZPekF6ZzR1TlZha2JLeStEZDlwMDlYclhG?=
 =?utf-8?B?OTBHVVZmYmhFaytPeWlqd2RFR2FBNmV0L0txeUFmaWR6eit4UDdva0FOM0tv?=
 =?utf-8?Q?axQwUfZ2r0lLkaKlEy7SnhQI2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dcb348-0c76-492c-d12a-08de367ca406
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:09.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vchTP9W/ZB+oq0ac+j6GJHrvZOyoTMAEccAqg1NwcD+dI2wdPiPV9l4387WoQ9IMsY+68OBxkUTnYk4HJUZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10318

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose and
requires additional locking to ensure both steps complete atomically.

Add a new API and callback device_prep_slave_sg_config that combines
configuration and preparation into a single operation. If the configuration
argument is passed as NULL, fall back to the existing implementation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/dmaengine.h | 64 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..6c563549133a28e26f1bdc367372b1e4a748afcf 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -835,6 +835,8 @@ struct dma_filter {
  *	where the address and size of each segment is located in one entry of
  *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
+ *	(Depericated, use @device_prep_slave_sg_config)
+ * @device_prep_slave_sg_config: prepares a slave dma operation
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
@@ -934,6 +936,11 @@ struct dma_device {
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+	struct dma_async_tx_descriptor *(*device_prep_slave_sg_config)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, struct dma_slave_config *config,
+		void *context);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -974,22 +981,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
 	       (direction == DMA_DEV_TO_DEV);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-	struct dma_chan *chan, dma_addr_t buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_single_config(struct dma_chan *chan, dma_addr_t buf,
+				   size_t len, enum dma_transfer_direction dir,
+				   unsigned long flags,
+				   struct dma_slave_config *config)
 {
 	struct scatterlist sg;
 	sg_init_table(&sg, 1);
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_slave_sg_config)
+		return chan->device->device_prep_slave_sg_config(chan, &sg, 1,
+					dir, flags, config, NULL);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			    enum dma_transfer_direction dir,
+			    unsigned long flags)
+{
+	return dmaengine_prep_slave_single_config(chan, buf, len, dir,
+						  flags, NULL);
+}
+
 /**
  * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
  * @chan: The channel to be used for this descriptor
@@ -1009,17 +1038,38 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 							    dir, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
+static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg_config(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
-	enum dma_transfer_direction dir, unsigned long flags)
+	enum dma_transfer_direction dir, unsigned long flags,
+	struct dma_slave_config *config)
 {
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_slave_sg_config)
+		return chan->device->device_prep_slave_sg_config(chan, sgl,
+								 sg_len, dir,
+								 flags, config,
+								 NULL);
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
+	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
+	enum dma_transfer_direction dir, unsigned long flags)
+{
+	return dmaengine_prep_slave_sg_config(chan, sgl, sg_len, dir,
+					      flags, NULL);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.34.1


