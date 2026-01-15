Return-Path: <dmaengine+bounces-8275-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E9D25994
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF1A0300EE78
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EF37E2EB;
	Thu, 15 Jan 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HPiAYUZJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C32C11E5;
	Thu, 15 Jan 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493233; cv=fail; b=l5FQHaLhqxILrlyIzLch0MWYFyRFhUDJ0hhVli42Ozh+T3YxWgQFZq3KG/jChXAzdlLqsTvOZLWGNsHOdno8Pm5Jjc7YU5sX+qElx3HLLelnETjw8Q0u4OTIcQ+zuw70vFKWg8KFaM/DGvZ/YaAbsYuJ3ukF5a6CjG2OIN1NkR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493233; c=relaxed/simple;
	bh=R8Dl7OWy/PdUwUlJEGn9rTYgDYnsbnDnK4rlASG+RHw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FQPrRWtZu3wdLuctg/vdzVJXy/fR+RFEdvoyLu4MQ0akZ+aMCzZWvTLyuTrKTBqat+uiILI9o8NwT8jTdIWkFTqX0/pBOct+kyTddsgriwfhlJc1IprvMKF7kwVamh9BLfSeZPpXm8H7wHYvXZ6p/W8ZeHBkUSFRJb7VXO3PGYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HPiAYUZJ; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWyDMOkl+bxY7ZEKg/ISQrC+DWzDXtXkPf4TW+AHsZmBLZl+sYMufrKJX8NnABlm3EIlFlLiQUM/dMOYDWLtNAnFqlA/oi7XYWTNk6IL+WcLoqkCeJ6o25D8jDSVNZeQ2c8URBzf76ZgDiS1Q5RRPBIbznjf0Bj+cwl3RkOSdrLxT4Aa8ejENf1TkLw6nQwcF6UDu94R1gt9Px5H3/qtIi9flviEEEfmT2CCfttZ/gVowyjOzVrgr3W70p4fDpJIOSdGoRjkGbZsa8ELGnxNLpKnammO0ceJ710HeBsE2SdzeZHAaZHSLizrk9VR5Y3Tzx5cT12ubb/U5ChfexCKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrMDFO59/LvSF5k2ySoYvPc7Xw/Vta3hHtQ/A43m724=;
 b=ZM2ln3dbP7WE1+XHkNZvgMpJxZfcS+GCufhovMU2SWjxfeGyktv7jkqZz0LisU7P9xRWBmttwcXU6MqB/HYk26X+vkWY9MVC1y3InpZSUTBnfvIjIjg9MiGwEkdeVxt+ZUyA5OvP6ySvNFFR/Vc+tp6y2c+dEVeIyBuk6IzOs55sdtN4BVPJj4tKoSao5c0kYP8WGpPR4IzE1NSXu8uBAaAaL1wtsZ5j0NJkMn9zYYbW/4ZrPKjsfhOnEB8TFQ+2v2cToYJ/On0OT/4m1Vy8v2N8Xwyl2kuWXFcwJtGALT/A/hcV7C1nGxvALQQ2gjYPFJ62YtTWQ/EVqdR+0qtG9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrMDFO59/LvSF5k2ySoYvPc7Xw/Vta3hHtQ/A43m724=;
 b=HPiAYUZJGy/J4PCEn1ZiAkgkGeT5ojy1B3+vmAdSpsX7pCx8tSBo0Fy7q0l2c02NxhryfMb08ZBMmCo5cBtG0LEC9iWAMMaefEbThDUSG8vi+JIYcXopdk8N2zwEZZ387n9S5NZz+0fP3xJ1tdzrLZt0jvXk+Uhve6m0JhfqQGc9M1AJ+fi4pFPwnuP/Et3Ag6wqelnoAdwtgivu/yU3WpR4O7gDgBnUK659cepM2jsd6NBi5maTTDAhVOl9Vb+b6fWVCHE4cSa6u7AmWLReP312P8Rwal/BZ+Y4hGY/JxUjO3AAx6kss8YVjt27Nb3ypmssHi1HKLn+ge0XIQAWJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:08 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:40 -0500
Subject: [PATCH v2 01/13] dmaengine: of_dma: Add
 devm_of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-1-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=1866;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=R8Dl7OWy/PdUwUlJEGn9rTYgDYnsbnDnK4rlASG+RHw=;
 b=kaVXmV4FxR6qfoF4s08YPkAEq3XfGqPbrXj7N0LYFQS7fgZXcHEnaFPt0L9ARemTOcJNjwLqq
 P2oJ/8rKjKRAbE2wwTrBe+ajSkFc75phZgxOyD98kuwWcD2dlroDhJC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: c166b0ba-088b-40db-7b21-08de54502206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk0wcDB6TXFSckhtd0xNeG9FaHEwbFNIVDBDcm54V3ZTK004S08wbUhJSmUr?=
 =?utf-8?B?TGV3NEtEUkdYdE1WME4vSThHNis0aEpNeEsrRk5KYVNlVWJhUXBDN2JRUWtC?=
 =?utf-8?B?SVFUdDRoeGxvOVhMYW5GRitwc0k5bXZsMkNQQm5ucVptMDJiSFVxdGVHSmNt?=
 =?utf-8?B?SS8xR2tEb1c2WkhGQ0I3ZC9jS25CMHpKejdXbXUzcVM1aXZpQlF6Wmp1bE9j?=
 =?utf-8?B?RzJScjYrUFVzTmFnWVJTK0ZDVXRSTVJpSTcrOFBNYVhibjlvVUZqREIreWgv?=
 =?utf-8?B?RmZyZEkxWmoxWWk0RGVWQ3BnalVWdHk1SE43WnF0MEZveXNOV1dMODBjT3dI?=
 =?utf-8?B?OHdzbnUvNEFyWTNuQzFxdGdpVzN1NnJzMFJkd0NaM25PVDVWS2d5YVllakx4?=
 =?utf-8?B?SlAyWHBMeUExSE9wd0FlakNpbmZTZ1czblJzeFhoYkIzZnRNd1lLVFl4Nytr?=
 =?utf-8?B?UWExbzdlR0c5QVZDcmFyQTZrZzZuSEY4M0EyOFMyanlzLzh4OGtzZVZiWHpt?=
 =?utf-8?B?ZUpkdk8yVmd1cUZ2d1RwRGJtMDcvTEpuZ05VSzkvcWU2c0JZL2ZUV2ZZTDl2?=
 =?utf-8?B?MThjKzdvMUJLRWt5ZTVlMVo1N29EeHNPbitUNENQcnVxSUgzWmtnSCtNcVA3?=
 =?utf-8?B?MGtlL2Rrb2tIZGR5Tm95clc0Tm5zQ0R6L0xYblF3Vk1BRTIwcnNvZkFicVlV?=
 =?utf-8?B?bDdJemJGRXU3eXNMaHJQcmJGMUtZanQvZkRXMTlZWTdud1BaRmZSaE95Z1I5?=
 =?utf-8?B?M095dGorOGt5dUtJRDRiY3ZmMDE2c3BjTHh5Z01kVW5VUkREK25IUU5sWlU0?=
 =?utf-8?B?Rkk3bnEvUUtkL2hGQnRMMkl0eUJ5aCtURStKeWNpSEF3M29pKy9GcEFxK0RD?=
 =?utf-8?B?ZTV6aVlhZG5aeE9DTXFzb1hGWDZCY0ZXbkVibXpxVWl3SFZsY2tYdFRwWmph?=
 =?utf-8?B?VU1PM05tYmkwZ3kxUWV3ZGRTLzlGaTAvU0cwYzJKMDhkaHNKYTl1elRyK1kz?=
 =?utf-8?B?NDRuVnNvNGUwUnBFVjRXZ3pSeGM2QUxTN1N4bnVIVlJteG91NDcxMC9EMlM2?=
 =?utf-8?B?VlUyUDRlSy9uc3ZIblAydUs0aWZueHJCd0U4OG94QXlWdm00aXdDaVBEQkpI?=
 =?utf-8?B?OENxRUQ0K0E2NWg1UkFsQU5qZ0lpZnNIanhsMUNqWUZsWUtyakdES0owMmJF?=
 =?utf-8?B?RWpLMjYrTkdYUEs3TlFKbzdEdnBOMnRpM1RKUW1yU2FKTHRxMlArbVRSaUVZ?=
 =?utf-8?B?NHdqcVI0cll6em05YkZVT3pMZXFsY2Y0bXJhNXU5WUJWVDRuZ21oQ0FLNHE4?=
 =?utf-8?B?Y3J1SjE4TU1CM3RKUWRrbnRzNnZpR1pTWnhQS2xmMVA5eTlFa1FVRzBVa1V0?=
 =?utf-8?B?bHRrdmlTWTZzWE40aVR2UjhSMHF3NUtwRkIvQWs0RHoxVWtZbEduM0lDQ09G?=
 =?utf-8?B?OWxnWTRhS1JlQVNxTVR5QkY3cnp5bUtyWUJyTWJvOVFzdVh3bXE1WmovV1M0?=
 =?utf-8?B?MFE4b2ZzWXdaNm1VUENQV1hGV0pWV3FQZXRaQmpDNXV4alE0V0pXM3FSMlZw?=
 =?utf-8?B?TThCNFF3K0pHbWhVckdob2grcmp3aVYxV3FpcGtVak1UWHM5S0ZnQlFackIv?=
 =?utf-8?B?ZHY1K055TTQ3Mkl4d2N6OTBmUm1TT0V0SUVDazV0b0FLT0FmRmJlQm04eXds?=
 =?utf-8?B?RTR6b0dzMXVVZzhub3hxRVZ5QWU3Y2FiUXJoSS9jTTBQRVNTWnlMNzJ0NXgx?=
 =?utf-8?B?VkYzbVh5em8xZWx1SUJ6TzBYN2F1Z0U0ZTl4c3E3V1NMNW5yWVgxZGppNTJt?=
 =?utf-8?B?OUlIYzU0RFg0TUo5UCtrczNZcnYvY2Izcjh1TTE2c3lpL1owOGkwd0E1TW8x?=
 =?utf-8?B?V1pZNllITVl5dTkzeEJSaW1xS0hWL21Eek1HSVRqaFlCN2NpUy8vRHFibnBO?=
 =?utf-8?B?Q0F3MDlGZ3dRSGVrZ1F3Rk9ybCtyTTZrQm9pblZLTmhKRUNteTBDZjNDVVpo?=
 =?utf-8?B?TTZBdWg1SThMeVYyNWlBRG51dE0yeU5VZXFHd0NUR2VZSmFPOUdZbXRKaG5v?=
 =?utf-8?B?NTRyOFBla1pPbG1lYStlaUptWVZHRmRpNzZQUlp3SDVWZWU3b2dKWkM5Rzha?=
 =?utf-8?B?eVZ0YzdUVEhGYTg0TjcrQ0VvQjkyQU1EMzF5R2F0RnlObFQzb1J0ZmpPeURT?=
 =?utf-8?Q?iWFKc6fekij1pR5wnJdbmgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0Q0U3FpaVg0R1ZaSkhTZG1nZnRZSkVsamw4M2JJVHgvb2dObDVCbjNIR3dF?=
 =?utf-8?B?MXJZRThTTFByaVRwUEhiSXBBVDFTSjlFT3pFMWVOTXYxSDR0SHlIdzVhQ3Q1?=
 =?utf-8?B?SzlGRnc1VUVrOTJjM3YyNXV4Wkp4VkUrcXg1Q0ZrVmx3ZVJDdFJuck9MNFZl?=
 =?utf-8?B?WnBQaGxSWWhpb1MyTmd3TUV4dWdHRWYwL0ZtZDhYbVpZSTV4U3MrWGxpdEFO?=
 =?utf-8?B?VjJidkp3YjIrQXVGRkZ0cjN5cVdudWN6ZVdGbnlYZ2cyTjBwMlhUeHh6Z09U?=
 =?utf-8?B?M2FnTWJBVmZvNCtVTFpPQnNhUGJ3c0NndzlMMDNGdktzemphUDBoaVBWZGxS?=
 =?utf-8?B?aUlFUFEySW9IcWpoQU1MZHFOVmxNZnc3aUVHd1ZPZUkwZ1ZvaEJWV1hYVFBP?=
 =?utf-8?B?dnNmWEoxNmllWGVhdUpFSVoxN05TWFJhd1NtT2dKZUI5dS9SKys3QlZUajBx?=
 =?utf-8?B?ektrdWxjUGY3WnNvWEljMmVVanFjeTgxbEtRUGx0NFlEQnZCUmxaR2gyUG1l?=
 =?utf-8?B?TDFXalpJWTBTYWtGVlBRSjRrcDZlU2RISk1BUzFJNFYzQzlMT0o3WG5PQ203?=
 =?utf-8?B?WHRaWnJQdUdJaHlONyt5cEJqalUyWEhjRUZ6cVhZL1BSQ3NEdzNTdUhYbmZk?=
 =?utf-8?B?aExON25OOThhb3FuOHBtOVNuaFRQN05GK08rUmx2ZnZuejY5cmhWU1d5cFVl?=
 =?utf-8?B?Ulh6MlliT1BxRnFhenJUVEF1eW9NbFNXWk90dFFqVnJsSGEvblRsS2xrZ05p?=
 =?utf-8?B?emMzUTAwYmoxWUJibTU3cHZvUytxcDJ4MVJNaGpXL0dCeSt1N3c4S3FuYUpX?=
 =?utf-8?B?TFErbTJFMmtwQTVPK0EzUkJZOG02NXczR1B2UDZDM1NpY3pvN0pFQ24rejVC?=
 =?utf-8?B?dkpjMlMyZlhzRkVOQ0U5ZE10SVhJYzkzN3l3VzhSc1UyMTM2WUk3OGpxMDYw?=
 =?utf-8?B?T0lzZlFXcXhLRk9vWnFidk55dWNWdlZ1S1lKMDFaVVZlcXZlNUp3TmczQzFm?=
 =?utf-8?B?UldNNW95VEQ4WTM3ZFlJeG1zT0I3R0JKQlBJcDBTeDRRRGNkd0FMT0JwNEkv?=
 =?utf-8?B?MnpKVVlRaVo5Rmhzc2xkZE9BUWEydUlpd0R0KzRsMnpsVmZvN3lvMTJGNlpY?=
 =?utf-8?B?Zm1XTTJUVzg3L3JtcjlQRFYxeC91akdrL3ArYklabUg3VEdLOHNYR0tHMno4?=
 =?utf-8?B?VXo4RVRjaGNnRURMdDA2aHJmbXRyRFBqSGozbVZXMGJWdEVmbzc4QjlRRmNt?=
 =?utf-8?B?VllBTUtpaEswaWFVcUlMaUM2emU5RStuVDBMR1dJS2tzc05aUVNGWXF1dVJT?=
 =?utf-8?B?TkxvdFFmK3FEcXg5MEFnVjlnenk1UDJJaU1VM2FsMWlRcGhZR1lwY2VWUmF1?=
 =?utf-8?B?bmxFaWlZMThFZUVQN011TFFrcXRaOUxLL2UwQmRjQ05qTHoxNWhWa0xsQWVt?=
 =?utf-8?B?NC9ha1lyajEyQnhkcE12UEdOUUZ3YlpPblJsT0dqRDc1R3hwWWRKUUQveDlO?=
 =?utf-8?B?azNYazRpaTMzQlAzWDJkS2pQdDVFV3B2OWhGc1IvdTJwenR1NWRSRU5Obk05?=
 =?utf-8?B?dWl1Mzhlak5IVzd5YjJHSTBFZkd0OXA5RHZ4b3hpV29qZEtGRWhEUERTVXo3?=
 =?utf-8?B?bFhRdGx5T3JtNEczUnZzK1pmR005VmNsYk5nZlJPNGEyOXdNNEMxRlgrWGJi?=
 =?utf-8?B?Tm81Z21DVjlpWTluemRWcnE1TXFkbmczUUp3TFZGS2k3cnZjMm91dHRidXFT?=
 =?utf-8?B?M01xSXZ0WjVLWGliQzNaWVJHN3JSbG53a09lZWxZekN1b0xNRnl6ei9GY0Yw?=
 =?utf-8?B?RFMwMkdXWlRZQlNlOEdQRTJOZ1dKb2pzRlMrQzZvWmlZa2dPY1BCbEhrS0Fy?=
 =?utf-8?B?bXl2S1ROTmJVSVRGcm05NWJ4U3FGZkNCV2ROb3dIcGxvcm9Jd05EVmpWRHVJ?=
 =?utf-8?B?N2xvNnAyNXNRMFErKzVaTHZWZEZ2Q1c1TFUwZkRkZzA5bUFTbnN3YmVQTzAy?=
 =?utf-8?B?dEtwa1FMMWhndWRJeHB3UjBWNVRuY1g3T1F6WGFURktFVWx0eksxUzloenF6?=
 =?utf-8?B?S3RxN2gvb3VUdkZRZWdFWXBaNnFnS2REZW5PR2V3SUYreGZUTjJIbm5EdFk3?=
 =?utf-8?B?Zk00RTcwaG1hWlp6dmR2dVFOZTJON0t2aTNEalp5K0Y1TjYxWWZPdXhPb0c1?=
 =?utf-8?B?VFpyd1dxVmtBVFhrbnBpT3VjUjNkMldSWlJHVjZCUzhpYkFQNFFjc25XOEox?=
 =?utf-8?B?Znl5NWRJWWQvNFZQaWpvRVFPTUVDbjluaW1DZ1ZzamkzdU9ZWjZBeGsxQ0Z3?=
 =?utf-8?B?dUhxV2RlakdVdXRvaUp0Nk4xZlNuMVFhVVk0TzdaNTYvMjlkV0Zadz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c166b0ba-088b-40db-7b21-08de54502206
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:07.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCBo/Wn3tYQW29EkL4bhnGVnJWNWDL+aZRrfA6BtSlSfh3YAi5l2l4rVSorNCU87W2YfE/CcIXcWXHY6XGVJkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

Add a managed API, devm_of_dma_controller_register(), to simplify DMA
engine controller registration by automatically handling resource
cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- fixed missing int at stub funciton.
---
 include/linux/of_dma.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index fd706cdf255c61c82ce30ef9a2c44930bef34bc8..16b08234d03b33476ea3f8cc6654f6fd72e60df3 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -38,6 +38,26 @@ extern int of_dma_controller_register(struct device_node *np,
 		void *data);
 extern void of_dma_controller_free(struct device_node *np);
 
+static void __of_dma_controller_free(void *np)
+{
+	of_dma_controller_free(np);
+}
+
+static inline int
+devm_of_dma_controller_register(struct device *dev, struct device_node *np,
+				struct dma_chan *(*of_dma_xlate)
+				(struct of_phandle_args *, struct of_dma *),
+				void *data)
+{
+	int ret;
+
+	ret = of_dma_controller_register(np, of_dma_xlate, data);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, __of_dma_controller_free, np);
+}
+
 extern int of_dma_router_register(struct device_node *np,
 		void *(*of_dma_route_allocate)
 		(struct of_phandle_args *, struct of_dma *),
@@ -64,6 +84,15 @@ static inline void of_dma_controller_free(struct device_node *np)
 {
 }
 
+static inline int
+devm_of_dma_controller_register(struct device *dev, struct device_node *np,
+				struct dma_chan *(*of_dma_xlate)
+				(struct of_phandle_args *, struct of_dma *),
+				void *data)
+{
+	return -ENODEV;
+}
+
 static inline int of_dma_router_register(struct device_node *np,
 		void *(*of_dma_route_allocate)
 		(struct of_phandle_args *, struct of_dma *),

-- 
2.34.1


