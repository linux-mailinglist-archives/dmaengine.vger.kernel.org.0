Return-Path: <dmaengine+bounces-8263-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F2D219D8
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B0330B0EFB
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924A3B5306;
	Wed, 14 Jan 2026 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B42EbfgD"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32823B52E6;
	Wed, 14 Jan 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430087; cv=fail; b=G2/dPhmfJKfd8DqVfetbsm3hJD8LNFCkt18g5ZI5ZTnKQwRqJJ+7lLA5lJk8h+lA2mGlt2xHQy/ut6GqyzcPXvWT2ZjhDbnIkgft2Hn5JFYAgs1bICqOJTmAz4OpXHkiZaaB5zO7Psl2YLh70veu/C53o6g/QltX+jaijZrvTMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430087; c=relaxed/simple;
	bh=mtWh9Hch5ipVRwCs5krrPrgeutiWaVDjxVDb7BqYxnM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kjX3VjiOt743s9sVp2PLHgI0wGBP7QbyYYDctix7425i71G77cINsv1qCcw20E0gYwubj/SS2Joo3YuokpE16XELywVLz4zHz9X9v+KqF6GxhWpLr85iotBgrjTQj5D+8zOgSWMPfJoG4OSC/lXbnCyHHHdXGsfeehT4ptrVdU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B42EbfgD; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnDbOc/7V0XYpebVy0ueEgnzPdSCE7QK3M8PwZSOBN1ev0OgA11G16tYC/URojvMVGhSn5fVy0Jfx9V5zHgdyc8QaFndwQ2ls+ByBzoSj0QhOFZpmZOsJT0uopnidsqQE3gp00vC05gVYrUzyF8huQGmB4Fz1rDpcSj/IIBv3z9C3HtYC5c24cXqKu8EDF+Noompo6bxgglOL5fRHPe5Jez3X3AwyuZjuyA2DU6+veL1QNz3tCgrHPKK6dLfIpGm4yim4Hpk8wXRo+USVQB2G4mkqZHOwxinFrh7vMiM7Y4Lsu1/U4cDM2ASLAOjLs84C4nHwH8Jg2avRFNXlmllUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GPckIE97hpzL4zQy9F1FrQQhqwyhIQD4NMx9ypn0h0=;
 b=TlFPCuo1cREpni9fU8F7fQzEfedT3Nm2oAbeT2KTL6TwwIEnV4t3T8k5TskXKtJJ12BIAqqpJwHN4CfR1OHoxoXkHpvIJiY8CM7xOf94xqjkpKVn6siMPhzNfQt9moE6sSz2rOFHHLpBIhIW4mmWHhBeoJC9a1SezapI/HR2s4kC1MG6vnAUvol7p7lUpXB0Wcm6N36NY5D0MXXwMXISbS+Y5QZJmwNZunzuKfZDpsKB5iiJUrZadHEp2UNxiZYY6IhAzcpL3WP3IWIgDz2FT0eSVe5Ocu5Vr9CIV0hFRGTrdxKrjb61ZOHf6L8ZDoqn7goXtfRTM85ooAtv9mmXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GPckIE97hpzL4zQy9F1FrQQhqwyhIQD4NMx9ypn0h0=;
 b=B42EbfgD4zbepEU8IMt+oSBtcZbo+ou+HwAFaUXE0ShHh6gY2+06DFDCmvoQ+UygAGAkG9VIYyym35we+up/Kja3uVE4KXdia1O2+vx/ooHZZJ6Bocz2ZOK0Ikz7JqAZO0HJ9tyAJXzs324IBMmJxVN+tiD38RTYA58dIy8dvqqYY3I1S1aY332v0P40g5X5XRX3oLhTywh3nvT0elSAAeuL5cXrblVkW+r2cSGFAM6ARFj1TvU/xefsRTITN5+ZXOIS7ZfpVijIdyjJXctmJdmdiAw4Sx3rKdg0VNOeP8TWvb3aW7ykiVgP5+rGG4yuLnvNqZcuQhHIpfFCUm/SSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:15 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:21 -0500
Subject: [PATCH 09/13] dmaengine: fsl-edma: Use dev_err_probe() to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-9-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=3281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mtWh9Hch5ipVRwCs5krrPrgeutiWaVDjxVDb7BqYxnM=;
 b=B3G7vqJ66OorqggIyK1Reeogdaw7tEMWKKiwM8YLcjdwl2pl1g+csuc+0TFkgYoAGbTv/0rup
 HHOKwT/2q8oAI/Vqw1GPiKUbcSdRr0fu8c6n6TVW/iB264eM6rideW4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b49874-1078-457c-2c2a-08de53bd0bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OERnaHEzQmVwWFhRQzdnTmI1Y0ZHaXE0K2tKVFJXck92dmFTYVZGa3dJdW5D?=
 =?utf-8?B?WHMvQXpKVUFoenhYeXB2Vmw4MGR6T2hqRjhIa2ZNKzgyeGsybk9XVTFCNThp?=
 =?utf-8?B?OFJrRlFiZVBlMXcwRVBjSmZGT05tZTRzYW9iY1p0cTFzMjBYbnVmTG05RFNS?=
 =?utf-8?B?dmgxRXBGeEpqZURreEpiVzFzdVI0S1E4KzYxSVdKcFRMeXh0MVdFL2pPTlR6?=
 =?utf-8?B?ZXBFOExnQS9OaDJ3U0gySy9GQzQ4eTYzL01QWkx6REdiUHdmQVh2Y3BhcUpu?=
 =?utf-8?B?alNiNExQRDluaVVSUk1MNS9hYWZSOHo5TEhvMGJSS3FYTktRYWhwUEhueHRs?=
 =?utf-8?B?RzlaR1YxTVhveUNqemMrT21VTURNeUphWlA3c2pUK2JoR3ZkR1RQWWtDNFcx?=
 =?utf-8?B?OW5nbmtObkR1R21URU1vT1BWclB5Q2E5UlZ2S0pFb2lEZ1V1dHUxTTFmSjgr?=
 =?utf-8?B?MmxjQ3NaY2w5R0N4NWN5dDRYenVMKzZsckVKa0E3M1RUMG0wMVA1Q0N5Ti9M?=
 =?utf-8?B?SGRtYXBzdVpab1AwR0FzM0VQUE41UEk3NFIwWlE1SEJVeXZDSjJoS1JWOUp5?=
 =?utf-8?B?QVhURTRpeFpZQ0NhdE5FdWVZQldrT0lpTzZXYTdtVTVmS05ZV3MyWjh5QW80?=
 =?utf-8?B?bURtRy9SbHdDYWMrWGE5dnNzUXpQOVZxc1d1VE9VaTJXOUg4VWJxalJ1Y0li?=
 =?utf-8?B?YnpDSEFva1ZPb1VRY2lJRitMQ2VZbzJkMjY5VmsyT0ZzZXhlc3hMZHcyeGFo?=
 =?utf-8?B?K1BBY25RMllLMnVjakQ4Mi9vWWNWbXlLTEd5ckRLWmYwZHFUbHk3QmhXL0ND?=
 =?utf-8?B?dEtMSVAySDR3aXF3bEUwTVJjNXBxMG9UWTJINVpRbFpPRTZtN2ZFQjBNbDVt?=
 =?utf-8?B?Yi94Rno2djNCaS9vUHc5bDlIcllzd3VSRjVYeisvTzNuU0pjbTVOL1E5MGov?=
 =?utf-8?B?ZHhnSHJIYXBWcS91YWhkOFM3RDdURnk5Sll3OERtYm1SRlpHUVFOUVY5NzVu?=
 =?utf-8?B?M2o3bmtYN2NzaVBpcFJlbGlLRTBvZmNPMzdlbVp1end1emJuUWlQcVdJcWdX?=
 =?utf-8?B?Mk5ocUZDMDdwTnEwdVFCSWtHTXFpVVQvZ1NjNzBWT2Fkc0pmUEo2ZlVxMUJZ?=
 =?utf-8?B?SXhrNWxYREkxaHA4SVF1RFlIWDhkR2QyWTZXWXAzMmVEci9JT1hwc3N2cWVP?=
 =?utf-8?B?bVFIZUtjb0t4ZUt5dEdadExvUGpKYlYrWmg4WU50YWtLNjcvZ0tHTzg4Z1U1?=
 =?utf-8?B?NnFTakhyNmxyT0FrTkZSUkhKS1RxYzZRNGVSWkx5TmxJVDBDV1RhTVQ0YitN?=
 =?utf-8?B?Tkt2Q1h3OTVXbzVRUEtkYkwxVHora0loTkp1Z0NXTGpuOVhrVkNkMHBDN1A2?=
 =?utf-8?B?c1doUk5xekZFUityb2tCaFNsSVZGUjk4Z2JjVmZnaENyVFpiSHJEREwwNVNi?=
 =?utf-8?B?S0t3dGkyWHd5WVBkN3VKbnNKUVVjYWxiMXE2VEtudmJiL2RtaE8yQnVqSzJF?=
 =?utf-8?B?T2dObm0xbWJyTzN3K2lGTTNLWHlsSVFIblM1MjMwa2hJTlJ0RFZXVm9zUDJN?=
 =?utf-8?B?Z1FwWFI3cjB6V21KVi9MdXVKQnEvN21ZYnREbXo1ZU8xOTE1b1I0NlpFaGZD?=
 =?utf-8?B?WUJUeDFvbVkyQzRVWmdmVVQ3cnVVYTZEYnpGWnF1aG5xQVVzZGZRK1NEN0NQ?=
 =?utf-8?B?a3EzM2k3RjZGYzBNU1duZlFuQzdsdndNaWFLQWJmeGpwMWJGaE5jY1F4dnhQ?=
 =?utf-8?B?a3ZtcjNxdmlIeDJ6TlNpalZOUVNKNDluOUt5M2lzWURvYTA2ZXJNVzM5alhW?=
 =?utf-8?B?UTc3TXZJQVJtT05aNisrRXZkNjdqdFUzNG8zR09nbVRIRUphODQ4bjhsc1dz?=
 =?utf-8?B?dU5JaTZyZHA3ZXRZNm90bzFDS2ZKMEZRbHFCRnlvU1RXQTRpTmhJeDRrTUJ6?=
 =?utf-8?B?aDBwNzhWOU4wenhZNFk0SDRROU10M1N2ay83d04wMGIveHB6dmh4MVFlSzJH?=
 =?utf-8?B?dFpSUlFhYmN5cjdUN3V2OFZnNEJaTHAxKy81YWVSUlkvQStXMWlpeS9KWkp4?=
 =?utf-8?B?Zi9WQUVtQ3FGU2x6ZUVRT3JUNU4rY3U4QTBzclBoWnBVeTBLRlpqWkRtUkcv?=
 =?utf-8?B?RDJRL2RDU2paeTBYdU8xUHdubU5VaHR6enQ3RzhCZHg5eUhEcytkS0lFNkIr?=
 =?utf-8?Q?nckUU5XmR6KJxMKB+53BaDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDFYUkJxVkkrYU10cFcrYUNCOHQyRDBLeW5XYlpSbU9jYVBzTjB3ZlJjL0xp?=
 =?utf-8?B?TlF2czdreVhDcWpDMWg3OW81d0pRcTA4dngvVnhTMStuOTdrTWdEZDNCb3VY?=
 =?utf-8?B?dENsTHoyK1BRWk50LzMrdTlWNTYrOWVYZlVVUWV5N1lWeTZRTnpCMldsYkpB?=
 =?utf-8?B?NE5EdFpyMXdtTTVIV205akR1THZiWmxkbGtQZEZJMkdTc2hkbEtPdGphMWF5?=
 =?utf-8?B?TVVFbkxHRWowTjlNQW8xeEZ2Q2w4bnBmYUZBSHJNc3BzTS9DWFVoK1crUTcy?=
 =?utf-8?B?WWJLYkdlRkhOVHljdWI1eEhUbFozajhKQXNLSlRIZ3RwSXQ5WHdIN0ZKV2o2?=
 =?utf-8?B?ZVRiWWNoRkZtd21yektKb2hBditzMTdRY0xmZW9MS2VRbEFGMy9FeUdSYjNT?=
 =?utf-8?B?N1Q4N1d2SHlBaitHVnFkSXd5K1VpVWIrZ2w4TkpWNmdDaU1yVUV0Z09Pczhx?=
 =?utf-8?B?dDlLT1Q5RUNUaThuRVp6Y3pRU2tQbU1IY1NKZzkzbVM0QkxMV1BxcktWaVBy?=
 =?utf-8?B?Z3JFcUVDQzBjOE1OaU1tK3VhVkxMVm9oN3N6Z1JvUGx3bEViV2hTaE5mSGFp?=
 =?utf-8?B?Ky82bzlGMksvNFdNMklEcERINk5UU09JQWg5NGgrcEZIbU9Vd09BT01CVGVV?=
 =?utf-8?B?aTlCaTZBd3MzeGsvb1RObVQ4MWlmdjBYLzQvbEJobGJPYWwrbEZNOWFuZXlB?=
 =?utf-8?B?dmx3QzBhVE0rWkNDejhWSFh2bk9sZWNQTUgzejBiOWJjREpIVTJidHhCL1d6?=
 =?utf-8?B?TUdEdm55dG40QWpEcnd6cHk2amkyMjQ5VGVEU1RHZGt5bDM0b2IzR2diQUY3?=
 =?utf-8?B?TmhHZ2lCb0xlMEpZMk9qdjZJQnpybkovN0JJRjVRTGEyNHR6Qis0RXMxSUho?=
 =?utf-8?B?UWpKMVhLUmpyRm9xTkFGYkJxaWlNUHMrS3Jqdndub2ZmNkxtYTVHOGM3QmZZ?=
 =?utf-8?B?aWJhYXM2YTFMT04zcDh2dTZWQ0NjM0Y0UFAxaHlvSTArN0xLK1Y2N1NkVUJ4?=
 =?utf-8?B?NnJkYlhzQzFpeE1pMlRQS1VON0EzV0ZGdGFDZitROTlidUg0RE1yVjhwdVh5?=
 =?utf-8?B?QmZia21Zc2U2Z2JtUFZwUDlaY1RiYzR4WUR6cmhCbWNLOXdXRmZwcy9qUHF3?=
 =?utf-8?B?K0treThLTlFRQW1OaXJkamZWdmh2L3AxUjRBYlVJTmVZZXgvVGMxd0FIQXJt?=
 =?utf-8?B?aHI2UVExdkNydmhKZ2FYT3g5YlNvSTVNWDlJMFRJTDQzajlYQTEzZzVieXhw?=
 =?utf-8?B?UDZ3WEdLYXQ2ektQRUVobi83c2xXOTR4K3BBZnhSeC85ZythRFlVOWpXQXY4?=
 =?utf-8?B?YVVxMVVlUGZZR3o4TGZMVkFxNU8vWEc2aGdOKy93aDRXcGh4RUVHcVJGT2VV?=
 =?utf-8?B?bjhNTVdZSWJBTGMrQWJlSU9VQkFpMzJFaTltK0M2Q3UyaFF3T0dFc3VIY0tH?=
 =?utf-8?B?UjBNSnNORGdabHJjaWkzRnloNGNDQzA1eGxoZXpwR3YyMDRKT1BZNCsrVFNO?=
 =?utf-8?B?NTdIUFhMY0oxK0JveGc2NnlxWnJzV2NycWtUYjNLMTZlMnRTQ004bitNTUlT?=
 =?utf-8?B?T0xCNjFCeEpVTjJFeVJrbnVhc3VYQi9BbDA3ei9mSGhId3YrSStqUHN5Q1I2?=
 =?utf-8?B?YXVnREtpMHpwMDR4VVZRRThIcnB4K2ZmTXNwKzhiUWRNQkFPQ1h5eGhBa2Rv?=
 =?utf-8?B?S1FjSDAvU0VBVEMvbUpOeTRsdTh2b2FRU3hCSXZCUE5Wb05oYk5Td0QxcUtH?=
 =?utf-8?B?cW00RHpXTnkyKzdTVDRSZTRwZHgwcm55Q3pBbk5ZVzZkdERTaXU4ZVcrNzF0?=
 =?utf-8?B?OWlXM2swcUhRSDk1dXlNODI1YzdKenVkUlZ2U05xMS9VTGNnd2cyZGpCd1VT?=
 =?utf-8?B?M0lKbU5NR2pHdll4Rnl0cFhNQlFBeVBTbVg5VmQvZ2IxOW5iRHAvTXRILzU2?=
 =?utf-8?B?NjgwVFNyRXpJZ2xKY0R4cTRuS2VQU1BDRE1rYzVMMnV5TE1LWVkwcjVxUzc5?=
 =?utf-8?B?b3FCYUtDTmE4cGhEUUg2OThxMWlZaXc3MG14OXJyc2J0VzZLVjU4UU9kT3hW?=
 =?utf-8?B?L2tDN0lKeUE4MnhHYnFGL3pmYVc1STV2UjF0TXV4SGQrMDZCbGZMa1ZRalli?=
 =?utf-8?B?bk14dG80Z29YVnV5d3R0WlB5L2VZMHlrN3F5ZjFubGxHVUw3cUNqc0xpRDhS?=
 =?utf-8?B?dXhLMi9aTWdIbTZSOE5YZWdVUm1Tbi9vcDRZZjVGOEUwMVlzbmNpd2VkRE80?=
 =?utf-8?B?djVhT1hFYUpUZDRYcGJuam1Vc0tXZEU0M2ZDN0taNGQ5YUYwQ3FxVWcxS3ow?=
 =?utf-8?B?c1BWMmVIVGhvV3FVaC9QWVlUNjhNUTFNTWNlczBlUHk4dWRTVFVKZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b49874-1078-457c-2c2a-08de53bd0bf9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:15.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCYmURXD6rWtR0HFqVuAAb+cPTz94A//svd0py9N3T9QGSua8/ZvzHHbwxqzXmRXxrs57I/4Fx6l3ici/sO26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use dev_err_probe() to simplify code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 47 +++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index c0305fd2ec06c41dfa8396bad6bfc225fd3861f0..8804217facba7870a0a9973d99ff7264cfa2b59c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -709,16 +709,14 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	int ret, i;
 
 	drvdata = device_get_match_data(&pdev->dev);
-	if (!drvdata) {
-		dev_err(&pdev->dev, "unable to find driver data\n");
-		return -EINVAL;
-	}
+	if (!drvdata)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "unable to find driver data\n");
 
 	ret = of_property_read_u32(np, "dma-channels", &chans);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get dma-channels.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get dma-channels.\n");
 
 	fsl_edma = devm_kzalloc(&pdev->dev, struct_size(fsl_edma, chans, chans),
 				GFP_KERNEL);
@@ -742,10 +740,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
-		if (IS_ERR(fsl_edma->dmaclk)) {
-			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-			return PTR_ERR(fsl_edma->dmaclk);
-		}
+		if (IS_ERR(fsl_edma->dmaclk))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(fsl_edma->dmaclk),
+					     "Missing DMA block clock.\n");
 	}
 
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
@@ -769,11 +767,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 		sprintf(clkname, "dmamux%d", i);
 		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
-		if (IS_ERR(fsl_edma->muxclk[i])) {
-			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
-			/* on error: disable all previously enabled clks */
-			return PTR_ERR(fsl_edma->muxclk[i]);
-		}
+		if (IS_ERR(fsl_edma->muxclk[i]))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(fsl_edma->muxclk[i]),
+					     "Missing DMAMUX block clock.\n");
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
@@ -883,20 +880,16 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register Freescale eDMA engine.\n");
 
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register Freescale eDMA of_dma.\n");
 
 	/* enable round robin arbitration */
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))

-- 
2.34.1


