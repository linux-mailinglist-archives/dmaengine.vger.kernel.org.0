Return-Path: <dmaengine+bounces-8287-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23766D25A84
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 144903068FB9
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2A3BF315;
	Thu, 15 Jan 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WtOIsJyD"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914AE3BF2F9;
	Thu, 15 Jan 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493275; cv=fail; b=WTlWWhxnvQ6KzNGEMAoeY/NtAyl+lYfxuocWth1YsYGd3ag7yBSzQzihC9mGlBJE6FzIiXPx2BsMCQyymFAqjsdMeZNpDy4/zUORdxAUn/FE7ZqizmNXT2cQWeb22kK5gg1fpa2MDVg1KzPpe4EqzxA75dRAoo0M3KYVc0KMh2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493275; c=relaxed/simple;
	bh=qa12qCvVjcto3KZzY4Y3LKmNK5yieXGtyEDDIcjU46c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WC96E+g0c3uFUJYj2iSlEL7WcMhSXHWeYH7xAoMujVq6qzzgrvMXQbYC7mckCqzhE4rwLXB998RGClTmBrdsM2KVJi+BG6Ho3F88tUjkvf7416nZ0S79Heli351gf0H/Iuad2kusX1KeCM3dhsKowCWyJkEXSEM2MYRooQtXhBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WtOIsJyD; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu/S5n0QL0PkpYU7Jufy2bYKzch/ERpKT29MPDw4K7AKK+7PPYNAF2XiiBPlm76OCLTaeRMb2qNuUTT/rHBCAAyKghiTEIdLX/96JfVthF86PCDmxE6YpidyMm5YVko/XjlfSNzTUfu9YuNXnz9QEM0vZ42VHvKIz36ADkU/20LPMwdqbhqJ5UefvS/ixetg2VxVqZ+6maxL/+rIJPeULHQfW6cF8zJSB/tF8d6wQUZHAAA83HYSwoKU/2H8/ZsxmGN10oEbuehxI2YvYcCLB8DAhnuzIL4ALxkHn4w7B8mp6Lo/ddZN6RT27CyPDZTG8I0JSuGi8BCSlePU32bLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzXVUfCikU/CH6YenUvZ8dbJ+qttDoX5n9MFRjohbnM=;
 b=fab83swoASsj0h0KlYk9UeBTeTBoc9JgEYX7PkLEVwPSKo2yZrOPEJdJgBCctBWgk0575FzDVqgvhbRBh6xR1bdwGSF3FDNkbExJfdA3ZEST57K71bVFB2/8hODLNQE7h7CRU1fXCLz/WAD3aN7SQ5DCBzAvyVkstlpzN8e1tjEXJ6WNeGLGRWhhptsq3QjR/YNeWn70DvC9X7shUbJTRORc74H3UBmEEla+NbXToXvugwZo/iO9MBU+PVkGshhBxEAXTWcHgK6uvP4soD4i18RSEmCBDyv9MRJ5+YXuAtFFoInGi5Io96DSKEUNpRzMnmEDcQOuTQF1112XOVgK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzXVUfCikU/CH6YenUvZ8dbJ+qttDoX5n9MFRjohbnM=;
 b=WtOIsJyDwLwN+XNHABJ+VoIgL0cpAiqHFKZPbd5lBi75Hez8KsIA0w2rsEcP5yEHKab4gRfdjG3a0IdvitD724oUlbn/raQSKwlSOiX1NWlQzjz1AfEdjIbZQe6YjY5wnf4oW52RUJN3yIoz6oI1nT6iVFdUCqV2kL/+dceuDc4Z/0I/ET/STSmSlXOtcC8wz+9Al70mjgdcqbm0ZcSswAZfTQg5hDUum4et5t74oEN7hr5dWcjanhhAVURBlS7BmwkF+uuDweNa6g2fS2Kyc/bt5mSvnfPtcOiz06+gt1ZcjW/6PYvaqEbxolqZpy4h37GnhtjfXR7FjROhNsvEjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:48 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:52 -0500
Subject: [PATCH v2 13/13] dmaengine: fsl-qdma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-13-0e1638939d03@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=2838;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qa12qCvVjcto3KZzY4Y3LKmNK5yieXGtyEDDIcjU46c=;
 b=GTyQ1POY7w5He4cY/TqtgmQ1ll/pc7KDEnaf6hxXNgPyTBxVYEhrtw5ZUNSoAov7w7CBezqu/
 2qOGteGcc9WDbkLUmC0UDMTyysPKPi+1hsJSuVxZ+/3CRz0CvSTsZ7M
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b70f63f-b435-4907-7b46-08de54503a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjlXSlNRWkJySTI1TlZTb2ZIdm5WaCtFdWJKNlBWZE1wazVCakFHQ0RORFFp?=
 =?utf-8?B?MGg0SEJNcEE1K1BLMVVyNXczSzl0N09VdURDUjE5ZkdEU0g3WHB3dVNFYzFW?=
 =?utf-8?B?VWJ2SUNubEJ6V0JMUHgvZkk5Y01CYVZFUmkyemJmd2grWWxza0ExbTF4NGpQ?=
 =?utf-8?B?bG1vZHQ3K05aT3dpRGZ3Mnlab0NndlNFbmZMdGZhNEI0cXJ2Zi9Sajh3NkZC?=
 =?utf-8?B?NHlPRG5YQk5Tb0ZqRFhCenhsekl2T0VjTFlPOUhkOXc3NStOM0V6Nm9ZbUxI?=
 =?utf-8?B?TE81elJ0ZE5FTHl0VGJ5VUZKRlVnN252Z0tTRGV1RURqN0hzdmhsbm5SSTRX?=
 =?utf-8?B?dEJNY3ZtQzVxYlBGalZOMnFlRUNwODBpMEozNmFPbUQra0U0dURFUExuRllF?=
 =?utf-8?B?UGdqLzBmQWRxSHJPSUNRQXRPVTJ0RUJIMDUzUjlGT3orZSszN2VENkJ3QlJn?=
 =?utf-8?B?YmNBZTZJTFhsU3JXYkwxQ21DaUk3bXdiNDg2NElBUWNaNTg0elBUR3NjUjI1?=
 =?utf-8?B?VkROZ0VYZG1yZitCdExVOGs0clgxWTFiZUxnRmJWbkdibUtkMnFVRnJXaVho?=
 =?utf-8?B?U1A4VmN4SEpQSXZUTVNwKzd3TUlSUTlIa3RJUEptYmR5VVJLUzF5RjZuMDBh?=
 =?utf-8?B?eitNUEtMWGNwQmtYN2ExUWpnMjQ0K01lRnBIOElHaytnTXpuNFpEdEFFR1Fw?=
 =?utf-8?B?aHVhYjErMVVpWVFPZDUxREw4d25DWkJDOWl6cWNnV1dFZ3FpT3R6SjRYdVlt?=
 =?utf-8?B?Nm5pRkY4QXd4NGQzcE5QZG84aXFuWTgvMHdER2RmaWo3blFUekcra0pSQmEz?=
 =?utf-8?B?bDJCK1NIckcrNG1VYmtVYis4SUd5V1d5Yjc4WXc1Y1cxcGxqSlFJSWQ2ZDh0?=
 =?utf-8?B?bDFLUm1BTitVS2R1WlNWQkU3NHk5Zlpib2pva3UvQW9BWHhZT3Y4cnZTdzdt?=
 =?utf-8?B?N3hPak95cVY0Y3dtMDJWUFB3WjZOb3JVSEIxVS96QXJZYUptMWlMZUUycmpR?=
 =?utf-8?B?eW01UHhqZHlBWnZKQ0MrbkVPZkxRc0g5TVVhY0pvaVlaOUVJUGV2a2FtU2Jp?=
 =?utf-8?B?RlJSTGFPYVhFZHAvcWhiM3pUdmEwclN0TjVTSWo3YnM5bnJyaGluRFZxOTJx?=
 =?utf-8?B?azRtQ3lZL3NVSTd0V3ptMTBXV1RLeU9QSjJueXdOU0NzVzlhbUtFNXBrcXNB?=
 =?utf-8?B?dFpvK2hpaTZqVmpMSlRheHhuUVJoL0VCZStCb05EM1AwZmZybzNRcEoxZFln?=
 =?utf-8?B?bFRDeDdOa3BZdjkxYjBmY05CT3BDcm92WDJhWUZiVFFmTUZ1M2svdEdmWXAw?=
 =?utf-8?B?OStWQ25pRjA2VlFIRXNTTm1qQVQyOEJ4RUxkUHVGTEh5VGVEWFM1UityMlE4?=
 =?utf-8?B?T0RINm1GNGFDeFhadDg5NHNpSlQ1Qkh6eG4zOGFMbzM3cDN5RDd4ZGI0aEc2?=
 =?utf-8?B?SWlEeFB6SktTZ3N3RUUxTjJ3anZsSW8vV2x2Z0t6bE5jSGdqVDJEdjdZdlBl?=
 =?utf-8?B?SDJjWkFtTklBd1dLTDJqZVQ0M0RPOWZ6bkcvTzdFUGNyUVN1aDNYQ0xQVDJC?=
 =?utf-8?B?cmNRTDIyOUhtTWZQMGl3UWxXN3cvK0R3d0NUaGhsUDNCTTNiMjdmYlRTUm45?=
 =?utf-8?B?a1o2TkxZTkxFQmJFU005ODBVdC8rclFsUTM4UlN4V0tWWk5maitJNExEbU5S?=
 =?utf-8?B?ZzRNR0FxYk1rN1pieXM5am5NUDZjdk5LL0N4c0R6bmlFd0tWM3RLVU1DUGhi?=
 =?utf-8?B?NFc3eG1ZR2VNZ0luWTltTGdHZzZlaEpyT3kwN3hYLzVVbzFvZEk5cklyZnA5?=
 =?utf-8?B?Zk1iSXQ1dEp3ZlhXYzVIekxmSVRkSGVyRnZmZFIvOEE1QlhtMFJiblpLY1R2?=
 =?utf-8?B?eXR0VkNkUEtxWkg5VnZVY0EyMnFvN3ZWK2lPaUV4b2t5QWNiUkhVSGx2cjdM?=
 =?utf-8?B?RW5VNitEOW5zMWN6U0xVMnF2QUp3YVRlZG1NZm1rOXVpbkRPVTJ3UlFHaExD?=
 =?utf-8?B?NmJPSW5PT3JDNUJmZjZ6MTJuWHk1L1hjNCtOR2R3Z0djMEhhQ3dudXAxUmxG?=
 =?utf-8?B?UnpMMzdkQVZzZVkzOHhFc1hpMm01emlNcEdodUZzTEl6cEhWYmNWckJOd0lv?=
 =?utf-8?B?Y08zc3M3REwxLzFGaGlWaDVLKzd1Z0l6UUR2OG5hZGJndXE0V2xoY1VlRkFl?=
 =?utf-8?Q?n5esAyAQdZ04iDQmIdv9McI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGp5S0dRN1hsNkk5SHBnSUR3bmE3ZEorekRMR2JWcEZVSGprc2dTV0Z5SS81?=
 =?utf-8?B?Q3kwWjJaanFrOEtMVkkzZWk2Tk9qV0NISGhOKzlZMFc3cEJkK01QS3JOamJJ?=
 =?utf-8?B?eGVGOU40QlhObmdvSkV5ZXNWRjdCZHNmT210aHp5cStLUXhleWVQbTlkZVlw?=
 =?utf-8?B?QXdIM3lIYjVpMkh2OTRFYVZSbTBqTFA4cEFENGJ3Z0tDZkV1dUtRUE1KZVI4?=
 =?utf-8?B?WFRvY2wyZ2tFalR4VTV3THZXalNtWUlUV1pUdGR5WFpkQ0Y4Y0ZLTHorZm5w?=
 =?utf-8?B?TzhpaVdFNklobFZGTS81MnhPWUhQOU1ra0pjeUtjM0lsUUNKblhtMk5Pa0Ri?=
 =?utf-8?B?cWFnWkI1dTNBTWZsOHlwV01sTzh0RFBRYjJPSE8xRGxOWXQ1Zi9ZU2tja3VS?=
 =?utf-8?B?ZHBqMC9ZWkRDVHJEcy8zRjlHYkFJbmFxNjFtRm1Za2JJR3ptSWthclR3RUQ2?=
 =?utf-8?B?d1pHQjFHTk14R1c3Q0VEcGowcjNJUGNiT1dUYnM1MGtuWnBGemhWdEZuajlY?=
 =?utf-8?B?ZzlXTWhUZVlaQ3VzSGpYRmJPWUtqelc2MEoxUld6M0YreVBhVGMyVzZNUCtq?=
 =?utf-8?B?U1VtYUpVTVlDUXZsVVFESjhvTlNSeUlBMUx5azA1cXAyb1Byc0JHQytLcHZ1?=
 =?utf-8?B?YkloaHVYWS9HRUFMRjltdUtaalNuNmswMlBBbFJNNUt6WWhIYnFaeXhaRWxu?=
 =?utf-8?B?bERNNGhNWnEyOUxRR0RqVHNYMElFdTNsd1BrRjIyaklPYnZvYjJSUVgyV01Z?=
 =?utf-8?B?aE1yNmY4VkRCOGRQMkVNei9OY2JaNEwyemFvZ3FPdGZNYXprZkxrSUs0OTV0?=
 =?utf-8?B?ajFhUndHa3E2bHVheU9tdytEQ202c2N1SFVtaHMwWkZBUGhXRE42MVA2a1Rs?=
 =?utf-8?B?K2NpeTVQMCswTDdqWjVqMTdhM0YxWml6UkR3SGpRL2FTSVM1OHZvMmpTME4x?=
 =?utf-8?B?ekdQZFlwNm9IS0x6Sm43ZDZYUVRPblJTMDVCSlZLZHNIaVVGRlpIVHFqaDll?=
 =?utf-8?B?eXI5VU51ME01aUV4ZFR4QkdpVFdJQ05vaHFoVzMzN1R5SjZLMVIrQ3NPR1R4?=
 =?utf-8?B?WnB2Tm5KbWxzZHN6eWVrT2JBeTBNc0tBMzAwMUNBY3gxWGluUklJZUJ2aDZH?=
 =?utf-8?B?RjhTMnUrczhiTVRBcHlUQU1mWU5VZGpRVHpoSDduNnoxcUUvNVpOenNITmt0?=
 =?utf-8?B?dXZ3ZWJKNEZiZTBCZExwL05UaFQ5VkpTM1ZGTE12TEw1bjNKVmJlb054SGpa?=
 =?utf-8?B?TGtTOE5lZ1Yrb2Z6TWIzREhjMjNVNW1FZFBVNzNoMkNEclEvYm1zcE9RSjNQ?=
 =?utf-8?B?emdiT0NzNmRrUUNpdXhvOTZvc2Z0UGhzYnlXc3dEWjJRSytEOSs2TXNSMmJv?=
 =?utf-8?B?d3hQTHpzdU5vMGE1Y0Y1eFJEWStzcEVjbE43a3ArNThSTWVQT2o5YVJXVEN0?=
 =?utf-8?B?WXJWajZuUVhkT0ZRNm15WUFhOTI0Vyt4djc0UTl2eDYyeDg5VFhZMGVhQ2Ns?=
 =?utf-8?B?Mml4L2NXWStZdVZXWWx1S0FMSTdEeFRlSXpQYUxkSVgxS2RVblZZTmNrSEE5?=
 =?utf-8?B?ck5Pa0QycXY0YnVTY1FZT2tSWHhmdVB0enVvWGN2OStGaUtWbUJUSGY3RkdQ?=
 =?utf-8?B?aWVacjV4L2pXdVplUTdYaVVpU1RSczNlVGNIMDFBQUZQdHlsbEZicmxsOE8v?=
 =?utf-8?B?VnZ0cmhWcVQreHMyTi82a0FPUEJYOTRPWm93T3NhUVA4cFNvUy92WXp5OXBR?=
 =?utf-8?B?ZmtDdE5mNmFMbEtiZ3pqbUVzT3U5VXR6a0ZDQyt5YlpLYVN3cDNZa0RldGVx?=
 =?utf-8?B?TUU0SmZHOWt4WWlZT1pVRE1VMGtZOVF3cm54S3dxMHhwL0MzSUR6b3VRSTBo?=
 =?utf-8?B?VGpuTHFsaDVsSTN1eldlYUh1dGlkYjJnQTZlUjhDWUFRSmJURE80TDZpTzlQ?=
 =?utf-8?B?TnErNnhDdk00aHRsSDYwY3RHT0syVmdWMGZkei9QbVZlV2J2MlFvNWw0dkNr?=
 =?utf-8?B?MFUyYlE5bHhXZ0d0WitZNGs2NkJCYXdwaDBYVWFReU8yazNqNkNEYlFwYjZj?=
 =?utf-8?B?bGtyL0xSbDlsM2xzb1JuRlh4bGdvTVY2SWxvVFRVeW8rU2lzUU5ITGNEV1lK?=
 =?utf-8?B?OWgyVFJ0ekpKVy8ybG1qaC9SRXpINlVVYXZKMG9HMHpQU3N2VGJuVmppWXZr?=
 =?utf-8?B?cDU0RVd0MWhRVHUzOG94NE9oeEJWdXBXVTVsU1ZhcnhyS3JQYnpXdzA5aGY5?=
 =?utf-8?B?QjQxUjNrbU84V1I5WWtUMkxOeUJmNDVYS3gvdkFIZ2pGSGpHM1BDWnF0S20z?=
 =?utf-8?B?d21KNU40djNDOEdITDBuZTcwY0hac1hEdXZiNkdLY2tNR2RxejJvQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b70f63f-b435-4907-7b46-08de54503a45
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:48.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fBlQ6EGOKi9dGDgu3SaT1tUDpejzlHt3Ehm5IF6sXvBOhcfaoIAn9ODPZnpXWoV3AMQzpm9zXWmvncVj9WylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

Use dev_err_probe() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-qdma.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 6ace5bf80c40be4226b17503fbe8caf8f08dd139..4c3a06653c909ce89677b66aa6a900c82c38a872 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1127,22 +1127,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 
 	ret = of_property_read_u32(np, "dma-channels", &chans);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get dma-channels.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get dma-channels.\n");
 
 	ret = of_property_read_u32(np, "block-offset", &blk_off);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get block-offset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get block-offset.\n");
 
 	ret = of_property_read_u32(np, "block-number", &blk_num);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get block-number.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get block-number.\n");
 
 	blk_num = min_t(int, blk_num, num_online_cpus());
 
@@ -1167,10 +1164,8 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "fsl,dma-queues", &queues);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get queues.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't get queues.\n");
 
 	fsl_qdma->desc_allocated = 0;
 	fsl_qdma->n_chans = chans;
@@ -1231,28 +1226,24 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
-	if (ret) {
-		dev_err(&pdev->dev, "dma_set_mask failure.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "dma_set_mask failure.\n");
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
 	ret = fsl_qdma_reg_init(fsl_qdma);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't Initialize the qDMA engine.\n");
 
 	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
 	if (ret)
 		return ret;
 
 	ret = dma_async_device_register(&fsl_qdma->dma_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register NXP Layerscape qDMA engine.\n");
 
 	return 0;
 }

-- 
2.34.1


