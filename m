Return-Path: <dmaengine+bounces-8257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE940D21984
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21463031CE0
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620413AA1A8;
	Wed, 14 Jan 2026 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YPtpCOiT"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CE3AEF37;
	Wed, 14 Jan 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430049; cv=fail; b=ag4zGZ91ONyCab504tz1KM3XFtR5Kl8wgFTt8shDjjz3EvCD69SjRzTGOjrDpMHKG8X7sxVNDYcJ2+Mt7Nn8v8dlLN+8v7RQn/EYW2yKoS1gyTE4IUvewcBR7exrPpQ/S+VKTnE4T6dn0/nvCGBA8DKOZk7Sk0xNRqzm1RHg7KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430049; c=relaxed/simple;
	bh=Dn3jvl+Wv3UAOYJjegOJ4GhmWjiCU1rS9PVdIHa1nCM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OfVp1F3Q8WrsH6HcSSt2igCTKOIQH8+I0mrnL8+u7l52VKu/g3kf/ItegD0LnlWTr+q+/uCX9oeSw7vFkKHnvHDS7HmAaE4CtJKOU8xU5GMWrxYVWTMRIp8kDPpsZo4pKyghBNMdanelt9JS083cBfOqVDi38Jfp4RUZO8yXeaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YPtpCOiT; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H05sTQqX5EwYPqrCAaUfPTfwK6RxqTudZZCPBZF2BWLTATfWzoD0rCFHYICVxlHxhktDjZQG9y5mFriAEs/lgGYcTBs4q7+C0Y+Ad1B5fsQQFbNFn3vVFGCUGaLK27QERKPAu3QvPPy5r7J1C/avQvVBGHpCP18bhOx9tvMdt61gGk+nt5eLUl/s+kxp/RkFSSXWLXZeieW/G8SYj8Qervssi0dVcuBwncxUPlSsMzRqfqfFLY12SBDd7eMIpdrN3UK+N0sOwu+Kx/0/oXh53upjwd3O42LhnjUUTH5Vf/x75JOQgDv7Xfc+BL0VWKAvb7S+58DYUTvcPA1G+TCcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTNkqtlZuraCTvmR7jwJmiO6EUKxyPb3OlosLij2NMU=;
 b=OD/vHdph+v5sB/uVAf9wg2c9ch/FZwTBCUVZIfRzWcsllDgRBuBuqGqSLQP1QnkvE9zF+1p7PAJ5G3U1vLw57LBjCTwGIeX+HiLDFIsMK5j6a6DrnmfqBCrHAvPnfdHOfCzrXXxFTs2V3BbwOtx1yFjUt2//+/lfq8/UfR5L8nAOnHPjXpB7jRveybIqhjie4j+jeXaV6yqxPJkMgphTtwpeWhOjQSaFPi6l2QXOwNixQgsDNlaU//GoQ4r/eM7iOYjirLcO1eLW2s1EZDBPfT95ZP48DkOPpJb4wtTXTAKmrqDJwAPASzTavtMajBjxzNxOuQZyn4uPUH5EUxW9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTNkqtlZuraCTvmR7jwJmiO6EUKxyPb3OlosLij2NMU=;
 b=YPtpCOiTqHkWEmAtZ8nU3SvmE75E1hJ+Bc4EPlo4EV2eHZ/hR5H0uutPk+FL+XML7KoUQ9GOC4wbCM7mSXEXklsgLgmXt595sNgIJE9ddL6x3q1KyhaEp3Ql6MwH1BOl4G5gz7nojk4fyLVrZf9WSMsf8+OWqAqb1SUSnbcuPHIzbaNlnAVf51uQHt9hmX5E+bJQfg81toBVxUp75BXD/h/OfzLsJGpQiwAlW7s8nRFfzn82MVWpgz8Nq7KOuqGWCMlMxic3SFKLBOft5QfKEs+1fvs9r6gZ+ME6rqesJkanx6D5nZtiiAg4EvjBcLCfMzb0wX6bePSkwkabdQV4RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:33:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:33:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:15 -0500
Subject: [PATCH 03/13] dmaengine: mxs-dma: Fix missing return value from
 of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-3-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=745;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Dn3jvl+Wv3UAOYJjegOJ4GhmWjiCU1rS9PVdIHa1nCM=;
 b=SB8BN+4rmzNYhjzdB97JPsdDLUHb7iN1FC8bGwfXKIhOzG5k/ySUHD17Bx1vdLf4c3mnXdtT2
 jm1Iu0YbBylCfWi5PT24R5XcTPJNYg9pUc/FYvzn35APYI+8s7t+wG4
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
X-MS-Office365-Filtering-Correlation-Id: 13dbc781-38a7-4d95-1b1e-08de53bcfd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGRseVppSkV2b1prMXVoU01JM3JnSFlTaGFUM3dOWHk2V1hxRWUrSGk0bTFD?=
 =?utf-8?B?SW9NRzZPVkcxSXlxaEIvSEhFeTRkTHQ3ZkhGYUJONUc3WDNyMDNFQUVrS2tT?=
 =?utf-8?B?NURSdE1Dc0owV3g0RGs1cUNjS3duOXRNTGhSOHlSN0RaMFJ3NVFsNWp5VEsr?=
 =?utf-8?B?SExXU2c0T0xNUmk3dVo2bVVYSXVMUDI5cjVSaG5aYWY1Y1ZaOC9ielVOdjRp?=
 =?utf-8?B?Si9Eci9jQlhTRGhEcml3SnhFbjF2UTJvZUkyay9MS3JodWw5OTI2enYwdnJO?=
 =?utf-8?B?dHZxQkIyWm1MRjIxS2hiczJpZ1Rka3NldU1UbDdjd25TL2RqcVJsNkNjWjBF?=
 =?utf-8?B?emttMDU4dklVSTFpMVFyWUIzeE05RGQwaVk1amVNZGh3dG9nOU5ZMVVwOUla?=
 =?utf-8?B?UTllcVE0MG5pQkJleUNLT3BKTmtCTEpTaFpOWWZwUnZqT3JlbmtzTVRtNEZs?=
 =?utf-8?B?ayt5RUo2Vm9PVmJVN3VHZjVKMWNtak1vVVZsMDFFck5IZm5ZN3NFNDRMSnNS?=
 =?utf-8?B?QnFrd1ZKenB1b01NcUVxbmJPd0MwRGk3T3Z2TVNqMDJvMjZkYnA5bk04ZG52?=
 =?utf-8?B?UTM0NUtCRUVqek1LK0kwK3FvSnoveXFSeVNIYWFKK2wrK01xcHcxcHU1dXRG?=
 =?utf-8?B?Ylc4OUM5RGZJaUJ5M2pNc2ZyRWZQbmVTcjVDM0NMVHAzTW5Va1VZNlpSM0JD?=
 =?utf-8?B?Y1Vic1V1THVIcVR3d3AwdzY3Z29HaG4yelZud2tJREhlc29YOGtVajlFc3ZX?=
 =?utf-8?B?M2t3OUNkUE9YR3Q0aTFWVUxGRDNRS3VSN0xYcUhjRTUrWHU4Wk5iT0ZSYmlV?=
 =?utf-8?B?dVo2akllRVZPMEhudDkyMElTY25VTTBUWHRuMXljK0J4QUduMEY4OXluMzVB?=
 =?utf-8?B?Y3FRWWlNRWRYRkZrVTg4SytBZUEzdE9FZGRZamFSUlk0R3YzV2F3d2NFL1dB?=
 =?utf-8?B?VmxTeFBkK2krdEo0YWFsbzIxWXhnSS9QT3owRzdKeHhnbk1XeHBwajJLeGV1?=
 =?utf-8?B?OCsyY2F4Vk8vWnpQRnlVYXBEZzJsTTBuNFo4bytyQ2F0R055ay9rSUpycXFZ?=
 =?utf-8?B?T0lZeHZadmtjYjlDRlc0c0E2Z3lmeU5uYzFscE9RdDVyeW4yL0JJVlBuK3lJ?=
 =?utf-8?B?cDBQakVzeUhLVEswNEtGbFl1Y3p1ZmVQWmRtWHRQT2dRcXZ1YTFQM01aRGF3?=
 =?utf-8?B?NkdWcktsT0svSHRRc1luV3Yya0Voa090SHV6TUorcmp0TTgrcENTNGQzcnNB?=
 =?utf-8?B?cWhKTWFGL1o2b1ZILzVKM05qdzFMcGZmbStZSVQ4eHNZc0VlVmdpM0g0UUN1?=
 =?utf-8?B?KytOS0NUMEsvOW9ENzlSc2haSEx4QWxBVVhmTkVjdFFzR3dodTRSR0tNZzRE?=
 =?utf-8?B?c0ErTGt3YTExbUF0U2QxS3FUSjRNL04xL2VuWmttcmZEMzNxa2xUeXo2K1pM?=
 =?utf-8?B?YUFtMmt3emFjOXA5QWcwZWd6MW42RW9IVjZSUkgxQ1VURXJtYXNSQmVGSWI0?=
 =?utf-8?B?MlpaanRza3p6Mm54MDkzQ2YyWkh3aDk1S2lCZGZ3WHF0Y1FXaFI4ZDloWk1m?=
 =?utf-8?B?aGpQYjhFcEtJSFAzVFlVeEdSZWhReUR2VlV3MUZsVGtSRVdrRThOWHpMbTZ1?=
 =?utf-8?B?TFpmQTliZFVmbTBLTWFPQ3lCSWNKRGdVYzg1RGpqdlBVSkYwdHB6QUlyQ21K?=
 =?utf-8?B?VnBZd3k0dHhNSGZ3ZURWTVpEVW5tYStGdERhYmdPUmc3SnV1cldSTHJ1V1ky?=
 =?utf-8?B?S04wa0JWMHhyQ2JLVHVaTFJiam9waVRMSFplNGRyVlB1Rk44ejlMb0FxU09E?=
 =?utf-8?B?NTJOSDA0WEtsQU0vZ3puaXVaYWp3T3AyVjdZdW5yNmZpVVVtdEFiQnI3YStp?=
 =?utf-8?B?YXhqOUtBaXd5SWJiL2l5d3Z6MVNVWHFRTUQvMlUxSk5Ud2w3by9Qcldkelhl?=
 =?utf-8?B?OG05VlphQ0R6Wjk2QTNWSm5wZkRDeHhTZEVBenAxSzhpOGk5MCsvRW4wNFNG?=
 =?utf-8?B?T0g3TXlTK0tqMVRXdVZmUFAzanpkT3Q2RnpsSkhNSDd4MS9VNmRmcnl2RjZh?=
 =?utf-8?B?MUUxSUl0RzBWNXRUeFFHa3oyWWJueU1ObFVSMWpsYjVGTWlCaU9CQ2hsYi81?=
 =?utf-8?B?Y2dYQnhrNXpoSHhFMGpkU1BaZEdjRnBZVkhoNkVnZnJKMzNWOVZ6SXZFMExl?=
 =?utf-8?Q?GLrnLWYi2mNjSf7iRNMyN3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3kxVzd6WHozWnIrQUl1ZEwwVnNpVUJReDhiYnhtNTU1UG45bDUyVVZ3ZytV?=
 =?utf-8?B?eFp0QU9MZE45Qzc2cUJmcVNTZGJDMG1aajJHN2Nnb1dRTkJmL2xGeUxqVkhv?=
 =?utf-8?B?a2xMMmpRTEJBQVIwQWg0aFdWYkt1M3RSSlIvRVlSWlU4WUJBUGpZNHQrOTV0?=
 =?utf-8?B?TGZkc2ZhZFR5V0dJYnhaaHNVZVFhd1ZWZHJtcFRiRWVJSyt0RkdCcTN5eVli?=
 =?utf-8?B?ZjdLZElmN3NQYzhoM0hMZzAxNkNFWFFUOHBETkFYU200bzByRXAvU0hvK1BQ?=
 =?utf-8?B?QWxuRk92VnhpRlZKZkJTcURGVGxOa01IK0NaZHdqcFBwK0VRZ3BiRHRta1Aw?=
 =?utf-8?B?c2QwTG91RG9FMm1kSU9ITlFUbjF2cnM2SGw2QWwyS1ROeUNoV2tMdHFhMkd6?=
 =?utf-8?B?OXpLcVBjMkFtQm5kcXhhRDlyQnNHOXhwV055R24rbFNxRHZKUVZINGg1NnU4?=
 =?utf-8?B?dWQ5cW9sRnRPNmZsSnJWNE9FVnRzZUVNcWN5d3N4dEdWcWw1eDNsdERiZDAr?=
 =?utf-8?B?OU9VcWlaNHoyeVFjak41blZ5SEdNcFNkZXVmSG90QmdRL3p1cnN6dmRVS0Er?=
 =?utf-8?B?TUV6SnJsT0N2YnRGMHZIUFJMUG95d3RNYzEvK2pwajdDT0dSM25wNU9YTU02?=
 =?utf-8?B?NjJnTm9tNWo5a3ZoN1h5UkdOSDlJRElZTlU5dlo5NCtOaE5pRWhyZjBrWis5?=
 =?utf-8?B?TTAzRDRDTEpBaFVIV1pBb2IvejNIcytDcHBxa3BWWFNnOFlyVWR2UEFlaGJw?=
 =?utf-8?B?WTEyWlhsSDhmOFpKdDl4bGRqR0xkM29tM0dqZ2pQUE1iK3ZUTVB4QjFYUkNn?=
 =?utf-8?B?Ny9YeTBtMDJsY1lJM3RUTVMxN3VBa1ArVjlzTXZoMEdOc3BKbkRpMnpzaHFJ?=
 =?utf-8?B?WGd5RGRRa3grS0hKOVdGNmF3QUdQTndTdFd5endQd0R6bUxCbGhOR2RURzY1?=
 =?utf-8?B?WjY1WWdENHpwcll5YzR6M0NtLzdHL3FYZ3FYRzdqWSs5UlViVVB0UXN5K0pS?=
 =?utf-8?B?RFJ1bUpCN2FTRFVuUjk3dVF3WlkvdXMyZUN4YkxMTUhSN0RXcXVWKzBicWJp?=
 =?utf-8?B?OXg3ZlhTQnNMMVQ2L3I0MW9rUURsM05yMmh2VEJpU0szRVFRbVhkLy9IT3da?=
 =?utf-8?B?dGMvcytrZFVnbEdVWUlHOWZnQ1JOTW5nNDZQNm5jaUN3amFCVy9OaytxVStm?=
 =?utf-8?B?UUpSNnRha0tXYTBmMjI1WmhUM1VRNmxVanNqbDQ5NkFISTNvbHl1WERwaVVu?=
 =?utf-8?B?RnhHQUpFV0x1a3RBcWFaL0k4blJ6aXRUeFptZkp1Vnd6MU8xKzRPeHd6bWdD?=
 =?utf-8?B?UEE4amZERVZQVDNrQ0RaKzVtQWl2L0NlRCs0TS9ORmwvVC9HejMydUxPTWVQ?=
 =?utf-8?B?ODFrNGFQdEhiSzEwTkQrOFRQWmF0TVJoOFdmdXBvL2ZwK1Y1NlRrbmJ0WUZm?=
 =?utf-8?B?RmFyNDdCcHUzRzZUUDBFbVZFcjhtRHNRMFF5QTVRN1ZWa3dKVUxpeGdXdnlr?=
 =?utf-8?B?aFFMVkxUSVU4TDZ3eElWbGFPeUJsL3pLY3k2cmx0b1Q0NXhEbS9CazJYSW13?=
 =?utf-8?B?Y3VnY2tUaXd2NUd0T3RCZ1U0NzlqWXpGRm9NejRnYkU5WWUxMzBSWFRmZG43?=
 =?utf-8?B?dkdiVmErYm4zejQzcDdSeC81dENkdWVWUFpPQ3FpR3lxOVhZRnNEK040ZVVv?=
 =?utf-8?B?dVdUN201WjRxKzRzZTNqWDh2eDRuOE9zQURROStFNDIwZTlvcWhyT0xTSy9o?=
 =?utf-8?B?REcvLzFHc2lsMk83eStsaGpZSzN5MmxjZkF1djF2a2ZzdzhMRWdEWnB5dHZJ?=
 =?utf-8?B?RUpUV1BVRjVBdm1oaXRiSlhwRHQ4WFdYQzNKZ3hTcFNxeS9EL2hieEE0Mkgx?=
 =?utf-8?B?TXJTVmVuWnJtamRXNU5NMzNzcEM0WDFiS0dQRzdBUngvZmViQm84RzJNS21S?=
 =?utf-8?B?UUJ6Z3pzbzgzd3NsaCsyRTJ3NWhaSS94WmtuejEwVkNISWlnVno2bTZTcXNJ?=
 =?utf-8?B?eDBaV05LNU1JeTNYU3YyL1BmbnNtRmtYcytLUG5YOVkxZWNBbkdsa3ZSbkNs?=
 =?utf-8?B?anJmMmdDSnRwT3k3V0U1YTZrWTZubXlubGVCZk1SSXEwbGNSVi9PNkxlekp3?=
 =?utf-8?B?V0JrTFBtR2hDTDVDTXg3MDNrMUp2ajFFa0sxRG1YcXV0MVF5ZTZ2WlNVdXpP?=
 =?utf-8?B?T3h4eDRTaFFNK3hmQnFsT1BVOEVJRUtMR1dyS0Z5a2RnOEg1L1RGN0Z1NFdk?=
 =?utf-8?B?RmhtZ0VlUzVLaFE4RkRJa09vRnRWUVJpMmJBak9ITVE2SURSUGhXT2lWOVRs?=
 =?utf-8?B?anErbGxoRlVkWStkdDdnSXN4anh5QWtDY2xMUDdhR0p6cm5MZFVpUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dbc781-38a7-4d95-1b1e-08de53bcfd7f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:33:51.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjf08uMKGixqscHCju2MbJe7gT+Xj61PCTnYxx5MsE5sgyIdqMEMI99xKuJt6EPLbM2pX/g5I4CyMMdTfaaxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Propagate the return value of of_dma_controller_register() in probe()
instead of ignoring it.

Fixes: a580b8c5429a6 ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c7e535c91469f0d819d6fe7465725736dc6128d8..dbc8747de591cc83e39ef873633418f41b5ea982 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -825,6 +825,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev,
 			"failed to register controller\n");
+		return ret;
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");

-- 
2.34.1


