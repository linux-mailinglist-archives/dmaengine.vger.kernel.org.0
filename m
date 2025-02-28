Return-Path: <dmaengine+bounces-4616-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310DA4A0AE
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336D73BB451
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16327603E;
	Fri, 28 Feb 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLsdBeWm"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAD1F0991;
	Fri, 28 Feb 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764564; cv=fail; b=nfBexadSJvg3MHuCiNN0fBQjPRQVzSUF7//O+QIvVq5PUQwIbgCAPHESI0QLgps+td+74TQ9lIiCTAQZSVh+B+WWNcqQl5zARuc2vrC7WqEOrK6wbjJnN6bbYFhaKc7Xm3gE6d4Y6SdCBVc7Vagjrla5FTN0NrOHc9xFVc1Bhpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764564; c=relaxed/simple;
	bh=Z8W3n6kNqIxL6eOG3TEULBRTOLFSmjiwur4x+uzA1/Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W9ZSaVYtIUBATUNBxsahxKjgXrzcTAINshNGKvRKKeItqfs3r+WwiGE/rDx4PJ0FonT9zf/wZyOtL3D8ZiLoD3jc5qSoxZuUM2hcRXCLlkuvENK/Q8jBhG0v2pZEGdvlU/v3FlAPgqUpFU/Mtri/SFpWlKKq2JF0fAh2XiqIMeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLsdBeWm; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl/Gdm3GD8NjgGcMGZ4HYTR+zFeXPYZKkH2gAsaitudzKItvv6rb6gf3NM/9cNxHQht1/77v7UKuPcXT4QwuJG1vUjwXvHa8LT4bWwAGT+okJuTFSNir+bfRgDAujQac+732Og4pp351226siwNscYsONApyNH7JtkEJFXQi7Ehiavt9Zz5FOPbxZM2pl69M+rT+167DmCM8TL9O/+UbXPtIZAsRhySrHk1ZryW8cgfMM0wEw8wdOelLR2k6L0LK+x6Poqg9HD1S55ML3T3wRy6/+l5eL0dKI9VAWmUl8EE/QHirsijwe4u0+KP4r0PxMCTvnrTPJUV/JukXcfSv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk90zrzM/+YjOb3Ny5hHPj5Cg13BdLiP1rIOJbKUQZw=;
 b=ET29AcpJ+sMyyiO+kWLLAGVqzmRWSvh2Shj7n9j9ZEvE7xfZ4au4Pa6L3iiGkUNwdDdEvN3Zpdjaxln/DnLGAymmofnJNpTFu1ns6AmOOAxgWRja2aC0YavwtX1N4AMnuW1Tj2acGbPnYwl1v+Uf9uXbGlCBjrfv60HorQ3KHJVfDrmINzzBDBpKNYml7+m03a5SxTYB8vhWOPUT0Bl3nGdG254Y4KItJNpThJlaoyjDmNBxIO3kWCtz7yasoZF53TURBqBxjI/Rh1iOpM5uFBFsEG31i50TzJFvzQ339jEhRBEzEz/YRfmBXJ3lFTuRBzNCEcwmlkOPD/bsqEYZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk90zrzM/+YjOb3Ny5hHPj5Cg13BdLiP1rIOJbKUQZw=;
 b=ZLsdBeWmATiCCH26ivwfP+MKhxbjZUj3c0d+EV53yWeRwZx6VSpL1nD/rtspf1evFEfglNovBvSFDs6ADH9oExL0cCkdD8dd7ffUmjJWw8PGMDhgspPecO10jxU225mBniKQ++yizcOT88kq4CgFtoGLe2Cu4TXMZtLW8YnvYAmUerruM3PsyUfC4i7rD2AyauM+k43CGkHp3Dmn3bx8IL3iQKdDB81sUVfAawbIiHm3uXrbwa8zIw2PBAQKxKqgPketV9miWqMwP5d615DBSnvXH3qnEImuniU8abs87pIiwhSbqkYlyNuYffLigTD1Y8bz0YeCI8hQpCC7XI3NNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10498.eurprd04.prod.outlook.com (2603:10a6:10:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 17:42:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:42:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 28 Feb 2025 12:42:04 -0500
Subject: [PATCH 2/3] dmaegnine: fsl-edma: add edma error interrupt handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-edma_err-v1-2-d1869fe4163e@nxp.com>
References: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
In-Reply-To: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740764548; l=10726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Q1pC70/P1OQQexCZsZePrl9IF0fRQ9Vjdy256MmnB4A=;
 b=Mc+aOwr9xp5Is8p/5eYsvEVPCIyvZ68eJhEKijDaddNU2arP09tghE9c5XfgagiMHW3HR4Jtq
 YmpIkgdUz0NDzcdEHi1ZbiVC7kDHSXfRqbY9Ojzrv6Cum1oXkOyfrDd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10498:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cda954-6edf-46da-acf8-08dd581f4bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExXMlNwcW9DcHpGSWh2WUJDUVRCemZKRjhmUk8zZzhQcHJBdHBPNlhYU2pD?=
 =?utf-8?B?TVhQUFFTUmZOa05WMjB4MklGeU1GaDMxdVdQQWo1aXBBcDBESEQxS1RWaFV1?=
 =?utf-8?B?czEvM3dLWFZGVmNRWERHWmcyWU1Uc1BKNjZpWVVKQ1hlZXQyaXFOUGdLR1M5?=
 =?utf-8?B?SUMvczl6STJneHRFeFQweVVwVWl4bGtqRStXS0g3YmQ1QWJpMnpGR1NUNC8x?=
 =?utf-8?B?NEJRbW5MenB5bVVCV2ZVRXhsSXBGVUdNbElRM3BGSzEzU29YYTZ0Zks4NlFS?=
 =?utf-8?B?OGNPUmJRSmxpT1A3OWlNU2liN1Q3QlcwbE1BRFNxK0FZQmtUWEJnUmNYQjhT?=
 =?utf-8?B?b3lXc2tRTGsxS3FhV1g3NjlhOGl6NG9QcFU3eE1HSXp4NXdqTXhXQlhmWHhJ?=
 =?utf-8?B?ZXEvRWNLMFBESGFoTFBzN1hoWkp5bjdFZlJMWkx0aUVPY2xSOGs3Y1poTzlQ?=
 =?utf-8?B?eHQyeXNZK3piSllNbTZ0bS9Fcm1qMG9DcndXYU10b0VxOXFURk51ZDl5WW5N?=
 =?utf-8?B?RThsN3piQ3dhNmtCamlTa1VTMjM1NC9qeWlQRGkvSmwxdUtmRk91YUpMQVNa?=
 =?utf-8?B?dWFqSEIwTEZQMzhoVC9pdWpZenowcnkzMDdoUlpJYkdTUGQ5ME51TElOQjNZ?=
 =?utf-8?B?ZVdrMTdqdytVanBPaFJRdEhvKzJUdGNjbW9BWlUvUUNWM2lNTUNPQWFjY2du?=
 =?utf-8?B?WlBkamdQTkwwN1JvMUVaR2JWcDZhdGdJVS96ZTZmRmFxQ0JPbm9zQXYzVlpy?=
 =?utf-8?B?MHkvY1BDc1FlU2JRRmJsSDk2empHVDd3SEkzcjZRcGNieUE5Y0c4V1JacFNN?=
 =?utf-8?B?bXdRWmRSNlZmWWhla1JQelBFRlJobWFxcDk3dGVQRVA4S3lTTEwyaEh5YXMx?=
 =?utf-8?B?WTRUUU44S2tXbzdtWHpPUS9QWlNhTUN6ZHNmMFhqRWpBakxwd2Zmb2NpQkVk?=
 =?utf-8?B?NWpZSit1MytPT0tQdWZNdmhMRVZkTkpDVDRmRThUZG5RNEd1WlJQd3FRS3Q1?=
 =?utf-8?B?cHNtbXlXTXR4bkt3TkJnR3JNWjdMZTM5L3dFQkxNZWl5THIvV3NrM0pFKzVC?=
 =?utf-8?B?ZVRQeVF4TGtCRE5mTUorQ0U1RHBvMTdZY3JzRmRJMDU0UEVxQ1FQNnhaT1R0?=
 =?utf-8?B?NlJXWkd4SW1jakRKMnJiaG5EeWhOQlBPQVpaUS9oNlNRZ2NXSCtGcFNZUGor?=
 =?utf-8?B?S2NOSk9kN1M5YVR6ZWpRM3JqQWdWc3d0ZFMwYWZQd3lnODJ3VStic09vTVhQ?=
 =?utf-8?B?QTA1RlB3ZU9OVVhVNXZIaVgxZGZPOE1iQ0JyblRHb1pBTWx6Vi8xcUM5UDFE?=
 =?utf-8?B?aW8vRjdadFpxSFFaUGRkaVhHYS9wanhVOTZmR2RWVzdHYWQvdkcvTkVTeHRu?=
 =?utf-8?B?T2tOcFlWNERZUTl2b1V0c3EzMTFSQ09zZDJ3RG44akZqYUpmV2ZsVFVsQnBF?=
 =?utf-8?B?UE9GOER1WklpNjJLd2xsTkwvZXM2QTJvL2lRYU5QbWxkeTZZeGNWQXVqVzkw?=
 =?utf-8?B?WmxkSnlFeHAzK09VWkZ4VUJ1ejFlMzBEcHBTNDY2Vk9FdDlHOEt1bXA2Z0p3?=
 =?utf-8?B?K1VNemZXZ1dPN3lzUmxCY21sMTV1WUd2SWpsOTE3ckNaTDNNNEI0YlJGdkNw?=
 =?utf-8?B?R0R3QXhxTUwzWjZsQzBiSm9IaEdvTloybnIrTFlzTTZmUnhDcFZ1NUtoaXBh?=
 =?utf-8?B?NWtSQ0hjNzRtay9RUmcvSU5xVm5CY2pES1F0bGQ4SUpyZXd2OEdDd1EzVXMw?=
 =?utf-8?B?aUlJYnl1bHFib2Jidm0zRmVJc0ppWm9iVndtbWlVaC9NZUQ0aitVTDU3aGU2?=
 =?utf-8?B?WnZPTHBSbzVUTnpVV2d2Z3JyRmVMdWdreVFnL2s2VUQzdnhRNlcyU0FINXhN?=
 =?utf-8?B?UUd6Y2dOTW4vQnJ1T05CMG5rVWMycUszM0JxYUxDL0d0cE40TUFTS05iWVpM?=
 =?utf-8?Q?AKhA2ojnQEPD/gnOrkpQc7TElkNaEKmY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWNHcWlLdUhYMXJhMTZpMElvWVQ3aTRnd2ZodzFnNHcyb0pvdXA1SkdZdk9z?=
 =?utf-8?B?WU42TjFNWnZHeVpaRjh1dlA2RHFsN29WL3J2T1VpdTcwTzF4OTdXTk9YSm9N?=
 =?utf-8?B?Wk5zNVc4dEhKc3J3VGc5amVReDlVMXlSN1VRS3RhYjNwVGozbng1NHMwWDR5?=
 =?utf-8?B?enB5TXMwS0xlRmdNMWxRc2l3dzNGM2s2NU9kK0pyRngyWk81NGNRUzJscnFN?=
 =?utf-8?B?elZLYXJRd3V4QUE2enVaKzhhRG1MTXhBOTQxL2dBTHZUY1gxbmZ6enZCRXRO?=
 =?utf-8?B?MEl2VWYrNHNvbmZZNTZJRzdnTDh1U0F2V1hXWjU3akxoSmRSUTVNMGE1VWRT?=
 =?utf-8?B?cDFNZDdSb3czM1B5UzdpVTZpZ05JUFN4YTJKMUE0VCtnZlN6MW9YWDNKejkx?=
 =?utf-8?B?MVFYQWZkNk14SUV3RjQvek1tMGJMaGxLQk81ZnZaQ3RabEpvUFVhKzFuR2Fz?=
 =?utf-8?B?SmlPWDltbnlKZy9qVzFpZnl6ZksrdFRyb3hKTEE4Ni9SN1krb29EeURYOGpI?=
 =?utf-8?B?RHJnUEZYWm9POE16YjVDekpkTk0vNGxyTGp0TUlROG1obVJQRW9UTS9HeEdr?=
 =?utf-8?B?MFg5alFZVVhLNE10ak1Cam5DMmVTWEYyR3FzZVc1VWtTRkk1eFU0dDJCMm1W?=
 =?utf-8?B?OW42WHhITmtSOG51QVJnZllSUUEvUE9PWkY3WmsxMm9qL1N2dVlHS1QrNExP?=
 =?utf-8?B?VEdQVUFmMHZ1L2U5cGRScE5nVUZmUDBhQUNhcnRUUEw5YnRzU2FCcUw0NDVM?=
 =?utf-8?B?ZlMrckprVUUxUzNWOUhoL2lvU242aUhvNk02RHh4SkhOR25CZXgwUUR4bHJn?=
 =?utf-8?B?dWx3TjcvcTd0dm1DWHpSbUZlMDViLzhBamlzOWx0U1lkVWg2WVBtOWZObTA4?=
 =?utf-8?B?c2tBdU1BZVBvOW0vMkhJSkpoMDU3bEY5OTEyNVBFMUJIRzU5aXJMdkZRbHZO?=
 =?utf-8?B?TDdNRk1SZGR2VUZPaEtOK2FlbDRFTFI0RGpQQUZiQ1JKQmRydUtHdjIxSWd2?=
 =?utf-8?B?TjZua1NlV0p4S2VrbHNSZ05HMkk1YXNOVHZaRTFLUEphdzhrMWl1R1NJK2Zp?=
 =?utf-8?B?c3BjVXpLdEJUdzl5SmRCM2pyczdzRmNUMko2TmF5VFovN1pCRDdOYkFXTXdU?=
 =?utf-8?B?VWxaT0MwVGhaU0JvVmlUc3RiN21ueEg1SWRzTC9CVUc5clhmL1llSFAzUUNK?=
 =?utf-8?B?SFlteVFSRm1ERTlkN2ZJQmZ6N1hxN05kWmdmczRqSndGTmJZcjZzMlJGbHJ0?=
 =?utf-8?B?TktNd0ozVVZrMHpaVDhjcFlHNGFKOUh5WVk2WmtxSnljSDBFeWpmbWd3MUly?=
 =?utf-8?B?Q2hnV0Zmb2o5ZkIvWHlTUG9kL1RsNmtld3N1eGpFSHkzQVg3RW5MYVJtVmph?=
 =?utf-8?B?aktya0dPUThZVlQrbkFjd2JUM3RpM01FdHVON3RxWjd3TnhqTmtXWXVobkpB?=
 =?utf-8?B?UVVtWTNyQ3dvTmxBNHhSOFJMWTB5OUFja2I2L09GTFNGZzd3MGlWK1p6OHU4?=
 =?utf-8?B?YlkwYy8xVEFCcnM3N3NPamFjTlFkbXdNYWNWd1dLdVd0bHdVVSs5KzJ5M3dV?=
 =?utf-8?B?TkVwMit1OGdTRUliaDA0Q09YeHRja3EwdnhYMWNMVmVrV1BlTlpNUHg3Q2o1?=
 =?utf-8?B?RWJsaTBrbU5pR1lqTGNQa3FSR3YrRkhVZTRzbnFWUi9wQjNTQ2E0ZnB6RlZz?=
 =?utf-8?B?ZDZNcHpBQTdvWWxBaGtjbjI5WldubmtaVTJsUzY5YTEreGtrcWRrMEJvSUhS?=
 =?utf-8?B?WituUjc2bkRkc0F4eVN4TFBROUdJR2xWcVZadnJvaWc2VmJSaDRUbnI4ZlRx?=
 =?utf-8?B?UWVvV0JQQ2lWSHZ0MVFXVzZJcWdHRDVaeG9UZ0ZjdVZQKzAyODBpcWFFYWdr?=
 =?utf-8?B?aHNXbU83RUdpSklJOTBrNy9VbFJ5bTZybXcxSDh1Zy9sdTR5SVQva3RhTTdU?=
 =?utf-8?B?NHpLU3YzaUU4N0ZJZnBISTJjdmIwd08vbVZrdktZamxhVDZ1Y0FBdm80ZHFx?=
 =?utf-8?B?YXhrQmpFSDAwYi82cWs5aGhBYUsvKzVsS1lnYmhNT3RRSEhjOXF6TXVRekVy?=
 =?utf-8?B?NldWZW1DalhLQU1VenN4UUN3L1EwVWxWRStzdjJGeWVnQWQ0WkswZ05KdU9o?=
 =?utf-8?Q?sJIXHqFEOvKII2/b9MUyS7QyS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cda954-6edf-46da-acf8-08dd581f4bd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:42:39.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVuz7HZivJjOjmvpBNuZtx7rLOOj/djN4Y+ZXycL6DFQQbzAdjHLRzhs4l84NaMhWOKPjq/iv/YtSpuEapnR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10498

From: Joy Zou <joy.zou@nxp.com>

Add the edma error interrupt handler because it's useful to debug issue.

i.MX8ULP edma has per channel error interrupt.

i.MX91/93/95 and i.MX8QM/QXP/DXL edma share one error interrupt.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  30 ++++++++---
 drivers/dma/fsl-edma-common.h |  18 +++++++
 drivers/dma/fsl-edma-main.c   | 121 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 443b2430466cb..4976d7dde0809 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -95,7 +95,7 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 	}
 
 	val = edma_readl_chreg(fsl_chan, ch_csr);
-	val |= EDMA_V3_CH_CSR_ERQ;
+	val |= EDMA_V3_CH_CSR_ERQ | EDMA_V3_CH_CSR_EEI;
 	edma_writel_chreg(fsl_chan, val, ch_csr);
 }
 
@@ -821,7 +821,7 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	int ret;
+	int ret = 0;
 
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
@@ -831,17 +831,29 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
 
-	if (fsl_chan->txirq) {
+	if (fsl_chan->txirq)
 		ret = request_irq(fsl_chan->txirq, fsl_chan->irq_handler, IRQF_SHARED,
 				 fsl_chan->chan_name, fsl_chan);
 
-		if (ret) {
-			dma_pool_destroy(fsl_chan->tcd_pool);
-			return ret;
-		}
-	}
+	if (ret)
+		goto err_txirq;
+
+	if (fsl_chan->errirq > 0)
+		ret = request_irq(fsl_chan->errirq, fsl_chan->errirq_handler, IRQF_SHARED,
+				  fsl_chan->errirq_name, fsl_chan);
+
+	if (ret)
+		goto err_errirq;
 
 	return 0;
+
+err_errirq:
+	if (fsl_chan->txirq)
+		free_irq(fsl_chan->txirq, fsl_chan);
+err_txirq:
+	dma_pool_destroy(fsl_chan->tcd_pool);
+
+	return ret;
 }
 
 void fsl_edma_free_chan_resources(struct dma_chan *chan)
@@ -862,6 +874,8 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 
 	if (fsl_chan->txirq)
 		free_irq(fsl_chan->txirq, fsl_chan);
+	if (fsl_chan->errirq)
+		free_irq(fsl_chan->errirq, fsl_chan);
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 10a5565ddfd76..205a964890948 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -71,6 +71,18 @@
 #define EDMA_V3_CH_ES_ERR          BIT(31)
 #define EDMA_V3_MP_ES_VLD          BIT(31)
 
+#define EDMA_V3_CH_ERR_DBE	BIT(0)
+#define EDMA_V3_CH_ERR_SBE	BIT(1)
+#define EDMA_V3_CH_ERR_SGE	BIT(2)
+#define EDMA_V3_CH_ERR_NCE	BIT(3)
+#define EDMA_V3_CH_ERR_DOE	BIT(4)
+#define EDMA_V3_CH_ERR_DAE	BIT(5)
+#define EDMA_V3_CH_ERR_SOE	BIT(6)
+#define EDMA_V3_CH_ERR_SAE	BIT(7)
+#define EDMA_V3_CH_ERR_ECX	BIT(8)
+#define EDMA_V3_CH_ERR_UCE	BIT(9)
+#define EDMA_V3_CH_ERR		BIT(31)
+
 enum fsl_edma_pm_state {
 	RUNNING = 0,
 	SUSPENDED,
@@ -162,6 +174,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
+	char				errirq_name[36];
 	void __iomem			*tcd;
 	void __iomem			*mux_addr;
 	u32				real_count;
@@ -174,7 +187,9 @@ struct fsl_edma_chan {
 	int                             priority;
 	int				hw_chanid;
 	int				txirq;
+	int				errirq;
 	irqreturn_t			(*irq_handler)(int irq, void *dev_id);
+	irqreturn_t			(*errirq_handler)(int irq, void *dev_id);
 	bool				is_rxchan;
 	bool				is_remote;
 	bool				is_multi_fifo;
@@ -208,6 +223,9 @@ struct fsl_edma_desc {
 /* Need clean CHn_CSR DONE before enable TCD's MAJORELINK */
 #define FSL_EDMA_DRV_CLEAR_DONE_E_LINK	BIT(14)
 #define FSL_EDMA_DRV_TCD64		BIT(15)
+/* All channel ERR IRQ share one IRQ line */
+#define FSL_EDMA_DRV_ERRIRQ_SHARE       BIT(16)
+
 
 #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
 				 FSL_EDMA_DRV_BUS_8BYTE |	\
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 760c9e3e374ca..cf309bd0a9473 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -50,6 +50,83 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void fsl_edma3_err_check(struct fsl_edma_chan *fsl_chan)
+{
+	unsigned int ch_err;
+	u32 val;
+
+	scoped_guard(spinlock, &fsl_chan->vchan.lock) {
+		ch_err = edma_readl_chreg(fsl_chan, ch_es);
+		if (!(ch_err & EDMA_V3_CH_ERR))
+			return;
+
+		edma_writel_chreg(fsl_chan, EDMA_V3_CH_ERR, ch_es);
+		val = edma_readl_chreg(fsl_chan, ch_csr);
+		val &= ~EDMA_V3_CH_CSR_ERQ;
+		edma_writel_chreg(fsl_chan, val, ch_csr);
+	}
+
+	/* Ignore this interrupt since channel has been disabled already */
+	if (!fsl_chan->edesc)
+		return;
+
+	if (ch_err & EDMA_V3_CH_ERR_DBE)
+		dev_err(&fsl_chan->pdev->dev, "Destination Bus Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SBE)
+		dev_err(&fsl_chan->pdev->dev, "Source Bus Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SGE)
+		dev_err(&fsl_chan->pdev->dev, "Scatter/Gather Configuration Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_NCE)
+		dev_err(&fsl_chan->pdev->dev, "NBYTES/CITER Configuration Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_DOE)
+		dev_err(&fsl_chan->pdev->dev, "Destination Offset Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_DAE)
+		dev_err(&fsl_chan->pdev->dev, "Destination Address Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SOE)
+		dev_err(&fsl_chan->pdev->dev, "Source Offset Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SAE)
+		dev_err(&fsl_chan->pdev->dev, "Source Address Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_ECX)
+		dev_err(&fsl_chan->pdev->dev, "Transfer Canceled interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_UCE)
+		dev_err(&fsl_chan->pdev->dev, "Uncorrectable TCD error during channel execution interrupt.\n");
+
+	fsl_chan->status = DMA_ERROR;
+}
+
+static irqreturn_t fsl_edma3_err_handler_per_chan(int irq, void *dev_id)
+{
+	struct fsl_edma_chan *fsl_chan = dev_id;
+
+	fsl_edma3_err_check(fsl_chan);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	unsigned int ch;
+
+	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		if (fsl_edma->chan_masked & BIT(ch))
+			continue;
+
+		fsl_edma3_err_check(&fsl_edma->chans[ch]);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t fsl_edma3_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_chan *fsl_chan = dev_id;
@@ -309,7 +386,8 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 
 static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
-	int i;
+	char *errirq_name;
+	int i, ret;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 
@@ -324,6 +402,27 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 			return  -EINVAL;
 
 		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+
+		if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE)) {
+			fsl_chan->errirq = fsl_chan->txirq;
+			fsl_chan->errirq_handler = fsl_edma3_err_handler_per_chan;
+		}
+	}
+
+	/* All channel err use one irq number */
+	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE) {
+		/* last one is error irq */
+		fsl_edma->errirq = platform_get_irq_optional(pdev, fsl_edma->n_chans);
+		if (fsl_edma->errirq < 0)
+			return 0; /* dts miss err irq, treat as no err irq case */
+
+		errirq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-err",
+					     dev_name(&pdev->dev));
+
+		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_handler_shared,
+				       0, errirq_name, fsl_edma);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Can't register eDMA err IRQ.\n");
 	}
 
 	return 0;
@@ -419,12 +518,11 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
-	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-	} else {
+	if (fsl_edma->txirq)
 		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+
+	if (fsl_edma->errirq)
 		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
-	}
 }
 
 static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
@@ -460,7 +558,8 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx8qm_data = {
-	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE,
+	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE
+		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
@@ -477,14 +576,15 @@ static struct fsl_edma_drvdata imx8ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx93_data3 = {
-	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
 static struct fsl_edma_drvdata imx93_data4 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4
+		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
@@ -494,7 +594,7 @@ static struct fsl_edma_drvdata imx93_data4 = {
 
 static struct fsl_edma_drvdata imx95_data5 = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
-		 FSL_EDMA_DRV_TCD64,
+		 FSL_EDMA_DRV_TCD64 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x200,
@@ -694,6 +794,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
 							   dev_name(&pdev->dev), i);
 
+		snprintf(fsl_chan->errirq_name, sizeof(fsl_chan->errirq_name),
+			 "%s-CH%02d-err", dev_name(&pdev->dev), i);
+
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->srcid = 0;

-- 
2.34.1


