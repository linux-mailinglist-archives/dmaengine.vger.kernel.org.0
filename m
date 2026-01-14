Return-Path: <dmaengine+bounces-8255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626ADD21973
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47155302AFAF
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F043AEF46;
	Wed, 14 Jan 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iG+fic78"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AB38A9A0;
	Wed, 14 Jan 2026 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430038; cv=fail; b=Bh++4n82zNp3vkkcY00/9I6Cwr3KFfargk3zgJfm+PhZwAgA1JtEViqvtvzL6WFRVuDPUlZt4b9FxYLj1pZZf9yhEu4DympLqIlPnzjio7AbzYUBuAex79ZN5/BXLAQGU4mAS5AYDBMZ4nrRBBvJ6Thpz+vb11wGRpawPuQoHbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430038; c=relaxed/simple;
	bh=ZznyAiannHCV//djJVHYRk+dXgyestgs7UtT0MO/plM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EJhZlJ5CUlBIcEEXzzEBV1IVowZYQeATtBWtAVvI2tAyG/56hRtyVItyOZXeLtT46D8yzpK5jDkPyfcxAA4zZJNL/SHfYQ+XYe8fRepz2dcI/1sfhk/qz7/EVN+hEOjvg8SR4DDE3dUZCJr31vhfPRkodGO4c/YP9t4C4CzDuyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iG+fic78; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ1GOt9LcJgi9zkb/v2qCxNXZlXMTTiQbqR5bXIkszRUoMhr0e6uYMFVB4vqdEAaq6+EK8DI78tUdussE6vauhyPSbSQjkfEXQLY0gxS4Wim6KTtm9vuj3QIMiyh2lOgqWrebT+ctoHC/KIe13qt16IUsed6mzlO1KHSM4UrUKcB2zy1NVkYPZeu2BuGfyqhUScEOZ6Duy88g+DyE2YQUcTbja3KxWndnp3lJIssLfp2ruqm6FEZcK0XXGBQnNgNk+Fwd7tzljjIrQehYiwiz9jYEQeU1bE+VWghuXNCcGs2qz+9TJ1lN0V71FIOE2aeBHIsv9UZ07pqA9g+WnGjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilaCK77WsUQwVnbIr6BAE3l0TqFwwFYU7f+lcv2q3ms=;
 b=SK0QZSsw5bPz170JZlnQ+fJL4FX3E58t8m9MqrtYc/8fn/QEsmDDNwcGJLsklabayAnnnnSJNmwOyC2Wc37KzE9p4/D89BsAcxDRi5s0QjKV3y9BUc1MYIHE7M4KFWHCKv73N4tadCuiER8qnEE1cuKxtHYNPde0aqibcL8ztU6FPzAsrEb7UNKYdOJVRmw4wYdWWn1vnPOtMnUUNSfxpiO65aucdVqVMM+0mgrSJLKl1aXmQJQzc+K8IoPriOupAQXMTzVkIOusR/eCMn48UgIFc+pz8Xt1feswpHgxd/L/WuDPptoI5hWGTnuvdn20E+ZmnEbp6xSU5b4Qai/T3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilaCK77WsUQwVnbIr6BAE3l0TqFwwFYU7f+lcv2q3ms=;
 b=iG+fic78ARtEWTdzqpuRO8F9Si50FGpCOzFXLnJbxv963BFfgaQprmpWvS6jqzEuWmDbUa0O7J6gDERWu2ed+DYsI7OC5t5kbcx8R9mIdqkcq9Ws9g5F4AU3GZuiYuOX2EEPh1qWfSIAMNsmCiIrbEo6xP7lJ7Ts+lzKuV3Kix1FAOFuAQWVRd1aC2fW5VPvKHPVxFp60rGfZ/Z3QdGJXBUN5m3V6YHPNVoGa4NtvjIcoCNR8FgAcsgy7etX7rWFC5WGw5Or2Q1gxZWv97M/e5IJy955/nnASHIDN6ELZlPG8x8I7ZkrcDh4NhA8p6dNwcYTFInsTyDVMKY+4IrXJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:33:43 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:33:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:13 -0500
Subject: [PATCH 01/13] dmaengine: of_dma: Add
 devm_of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=1804;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZznyAiannHCV//djJVHYRk+dXgyestgs7UtT0MO/plM=;
 b=gusjEMCnYMesQCTdDRPW+VyEfYQb+F4TmhHdzypD517p5TngV43EVKx2hBeVc52t5c4DL7Ysd
 PGmNophpkcRAJHQO9YgDbdjsjH+BqJvqy4lupfzQm4MNmmjoTH5fbXg
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
X-MS-Office365-Filtering-Correlation-Id: da8c9b22-f93d-4314-7cda-08de53bcf8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHFZSXFSM3pKcGl6RWgxbVNyRVU3dWJqY0FxZ2x5Z3BOMHVWTTFXOFY2b0RO?=
 =?utf-8?B?bkhsYjFkMmM2Rk9mUngvQUhSdTFZSE4zcWIzYk9QVEJxV3Q4b2ZUU1RnenFV?=
 =?utf-8?B?Y2tiWURoWjFGYWNYNlQxYzQzQ0JzWndjR09FemFTb2VueWhEYVhwbnRTaFZy?=
 =?utf-8?B?TUxEcDRSbUlZUVlmekVHbFh6N3RRTGlUMldpS3NNcGlSRlJ3TEpyYnBnQ0pi?=
 =?utf-8?B?Vm5PTXFZbkpVZzJBdERyMHhXN3lyT3p0K3RpRUJDNGp2am5PVTFOaEhNSjds?=
 =?utf-8?B?SDBsN1RkLzFJQ2JuK3ZZSHBIM0Jac2xjSGQ3NjdKVG9NRGV0VzRiT0NJTW0r?=
 =?utf-8?B?RUw2V3J0QysvZmY1cTVFSDFnTHE5NWxqUE5zNDlyd3ZWYmZNR3FGb1lLQTBP?=
 =?utf-8?B?UjFiNG9NcVVNQVNhK1owSFAxWkhNYjA3eHZjM0xNNi9YY3NaVTkrdnBCNFFY?=
 =?utf-8?B?c1phVVg4N2lBNWlEeGU1VmxhdERGYWFpTFB5VWZHdGdzT3BsT3h1ekI4ZG1y?=
 =?utf-8?B?akdPdFNlMGxwWkdDMDlMNnFJb2s2SDQ4dnFXREZXOW1oajg2cW11Z0lUVkdq?=
 =?utf-8?B?Y2RrZ3ljVCtVaVpjOHhWUERhRExiVlFFM21xczdTSkxGQnRLajVqVFpuSEp0?=
 =?utf-8?B?Q3JzUE9zYnJFayt0M3BuS1d1TTM2OTA5endYQTNTbDFHdFVybDFwMmREOE5Z?=
 =?utf-8?B?MmtmMjNFWjdqcmpPOTA5VGQyQkdrTmlKVHcwQTlMUHFwRDFySTJtK3RYTVNP?=
 =?utf-8?B?OUVvRWZ6OWRXZERISWlrZ291aUFUd045VXk3RklUYmdMOXkyanAwbnl1alFJ?=
 =?utf-8?B?VTQ5OXVVRk00QUwwbnlUUUZ0cEtlaVhUYUlWMmZGdkhGUU9VditTMG9lY0RM?=
 =?utf-8?B?dlhJWWI0MTlkMzF5NDJqaHFVb3BER0xoSWE1RXZaUVdnUjI0bHllaWQvbFV0?=
 =?utf-8?B?N2xqN0EzZVBuUGx5NklJUTM5OW1GMjVUVDFtdTBKNG56Sm1NUWNvdFByYmg2?=
 =?utf-8?B?bERPc3luQkh5Zlkyc05hVUtmQnBpbitIMGVwcGM0VHp0SEw2cTYzdUdhTjJL?=
 =?utf-8?B?clBxOHNmVW9Ed1JmekZ1djNoYXFQdURPMzlWT2JsK3gyYk1zRlJYSGpabHhF?=
 =?utf-8?B?Q2FhcWEvMys0Qm8zdlpxcVhycm9abW5vaXJ3OXVkcURYYVplTzVGSzd1dVZr?=
 =?utf-8?B?TmhNcTdGQnozalpmK25seGN0WWMrWEJ5dStDcEphMTJuMEx6ekxwS0xKQU9o?=
 =?utf-8?B?STlBMm5JcGoxRTRyc3hINnVpbkRyQ2kvMXIvaCtrNVo1UllDSzJqWFV3OFEz?=
 =?utf-8?B?TUFhZEExb3JQRHlnQ0dpaUtlSEx0VTFRdzgzaThjNW5MaExhUldqOXQzUUY3?=
 =?utf-8?B?RlBwcWlVSzUzQWVLbnJ0N3ZjQ1VJZytaSVMwdjFTYXRWa2ZKN2xlRktETWhw?=
 =?utf-8?B?RW5WWm1JeXpOT0JyVlNrTitjYzRLUmUwN1dPMktsU1ZTaFdPRngxUDA3ZTUv?=
 =?utf-8?B?M0lCSG1PbUZzWVcrcVpWd29FSStUaVpvcjVTa3Yvb1FSTmliUWJGSy9ReWE3?=
 =?utf-8?B?eUh5SXJhOTdsU3ZST3ZTSmR6VGRGR3UvdENnNisyV3JYcWVRWWJURkFTTHVq?=
 =?utf-8?B?Sy93Ty93cUFSTk5Za0c1OG5veDJIZTRiZWVGcHhFU3BpcDBUcUE3RkpBU1pE?=
 =?utf-8?B?UjVLSXFrSy96TFFyOE9scEpEKzd4RnhQdGszL3c4bkFOYnhDQUtsQkJpR2lW?=
 =?utf-8?B?MWNmK3BQRTNsbitKWlNITXRGWHdKUFhNbVgzMjNqNFlDZE1PWWZnMVpPYUFT?=
 =?utf-8?B?UXI5Wk5tcUFQSGR3NkpuVUVpbUN2NFh4Mzh6Qkx6OE5zaTBUVlhGVjcrUHpZ?=
 =?utf-8?B?aG5yMFFMbWJNQS8xQ0hEcTZqaFBGeGpCNFZoZzRnV2UrTzczcTdJL3pQN0ZP?=
 =?utf-8?B?RmRUNEhSb1FLZHhIYXZDeVFOL0V6aTV1a05kSk1UK3RsYmowakpveUN2WG4z?=
 =?utf-8?B?Ny82OHAvb0tSekJ1MVU4aXlMbVJiNHJWQXpmeDJoTngvY2lDem01MHg5WnNh?=
 =?utf-8?B?WjBNbG1ld1Jjb3RqTHM5WElOMXV3S1RpYWNieXJ6M2hOTjJxeWp3WldiN3R5?=
 =?utf-8?B?Z0NZOTRtZnNZYWZuSDR4bWs3UTlLVUF5ZHlEVlJrVHUwcWxnVXI4T1lqaWdz?=
 =?utf-8?Q?SDhoXNy3vXxKX2Py7DVmaiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NExCMmN4Zm92MnF2bUtxRXMweEdtRGdpblV6SWN1TUV5YVJ2Z0lyQXhyUE5Y?=
 =?utf-8?B?S29UWjRqTVFwdHU3bnNveGlPY3d0N2JLSTlLWURmU1ZTNzBMMUFMYS9QaHJk?=
 =?utf-8?B?NVVMZXFHcEVYSVE2a1RaRnNmVi9mQWxHMFc3WVB6MHhBL0grdk1TZSttNXpG?=
 =?utf-8?B?aHlIVDQ0cTdnQ0JRQk1BR3lTRlFDbE9ndG1wVCtlWDRUdUgzT21jZkVQcVRT?=
 =?utf-8?B?N0Y1TEVKcEgvQXRPdENQWDN2UkovNjBDWitxY3poSXgwNEtnRENoMjNZTHp1?=
 =?utf-8?B?VUIrWnhCTVBIMUE4a2ZTam5jbmkyMzhUZ2kzZFc3ZzI5aFUrTksvM3MzQ3gr?=
 =?utf-8?B?a2c1cUcyNlI1Tmx5MnJuMDN3UG83ZVkxSlZmc05FcEJxVzFPd0t1K2pyU1VO?=
 =?utf-8?B?anZBcjRGQ1kza3Q3S1UzR0NFalZCdVlXVy85L242OVlIbWhHaXYxSVE0YTBn?=
 =?utf-8?B?Z21zNElkVFNzK1Bsd2I0S0hGQ041VytHdnJVM2F3cENoUSthUGtnQUF5eGFW?=
 =?utf-8?B?QU1zZHY5VXlCak00YmVhQVlHbk0wYjJBVlFZa3lxQngzdW5GU0lLMGZMUUpl?=
 =?utf-8?B?bDlYeFh1aTlOdDB3MjhBMWI1YnN6YWVPbVl5d2xscTRjcDFINnNuYTBpRk8v?=
 =?utf-8?B?clBoTVZTMWpUWG1QTnZWRDRieXpXREhxNmNNbDJHZ1NiOEdlMVJCU3BFamNJ?=
 =?utf-8?B?SC9CcytCbVlRNmF6L0JPUVpuUTU4TlFlQU9QdFhzR2c2WTFxZWFZUlY4TkNL?=
 =?utf-8?B?bmxxMGRIQ016dEpTMSs0NjNTWkVmUVUybTMzdkpvaDZNQkRtMWFqS2RJdFQy?=
 =?utf-8?B?QkNPYVRMd0lUSDFOdEU4NGt6Yy9taHdhbm94eVp0RWZRL0N3TXEyQ0xQem9h?=
 =?utf-8?B?MzBra1Y3V3hzZUhnSW9Mejh4OUMwVnRIK2x2Yko2SHpqcEJ6ZjdtTWttQjZL?=
 =?utf-8?B?KzdGV3VmdFNhdm91UEVMeG1neHhTNHR4aVltOUpoOHc1WlpMTUVvNjJVOERi?=
 =?utf-8?B?bHZvTjVaZ2IyVG95S3RmYUZjMDR3TUxnbFcrSUNNVUtIZkpRQVY0ZVlZZFVQ?=
 =?utf-8?B?bU01RHNkY2dWUlNuWU5oK2tLU1pjUm93N05GeHcyajJzbzVaandrWTlRWGdO?=
 =?utf-8?B?TjV5NFI5U1ZCTG8waFdnazltQXVKUmZPeXVYRTBrZnp1L3praDgyQ3gwS0JP?=
 =?utf-8?B?enFYU0VKMm5ndGJRanAwazJiYWxHcC9OVEllSkxIN2VOMHdyRUo4NjNUNUI2?=
 =?utf-8?B?MVhZSEVmbUxYQ0FzbHJ3VGlFNU1nb1JOYit2Rndxb1BQOHh3Mk5mbm9OMDli?=
 =?utf-8?B?RnpERWVuM2NLaXVjYWVrTDVmMGhTak9qOGxDWUpuYkxkMXQrVWFZd3ZVK0Iv?=
 =?utf-8?B?LzltU3g0YVFQcUpsZk00U2NiLzZ2NTh6d1JBbW1wd08xakFxQTRaRWdNL2VX?=
 =?utf-8?B?OUNCazVqK1FRK0s4NjZLTEw4N3AwNzdlWmJhK3BidkdqL3hTbzBCRDdFSDZZ?=
 =?utf-8?B?cVluMmh4YWYwMmVncUZmVEY2QnlkMUpYMlJDbmZ3NFRnYVAvN0NQY2NYT1A2?=
 =?utf-8?B?Q3FOQWtyQmRHTzFuRCtYNnE1WVEyTUtzbEtWN2NiU2R2RTlRNGdyaHVBY2VU?=
 =?utf-8?B?TytiS0RKc3J0RTFteThaSUlSd2ZUeUtKcGs1NmFkd05LV2lJUjlrYXc2OEhO?=
 =?utf-8?B?anMrZ200eUR3cTQyaHIvbmxWTjFCUFpwL2MyMWZPaFFrbHRVTDBYVTV1NEsx?=
 =?utf-8?B?TFJ2eFR6bjk5VStoaFQyNDBLZGZhdzVkaUpxOFA4OWxUSFBVZGwxNnFkUFpU?=
 =?utf-8?B?dlVuelAwRUZMVWx3U0FORDU5RTFvT3QvSkdGRVdRaGhoeG1TTHFPSUNvbUJB?=
 =?utf-8?B?a3dYTDE3M1RzcGJ6T0xDQUNKNVlFQ1J3ZW02cWcvUUNheVlubmZZbVhycDAr?=
 =?utf-8?B?RlhnQzd3c2t5TEYwSlRFcFBhTGwvekdkSGswR0VZdlArcm5qdStYZkZGTnF3?=
 =?utf-8?B?Q1JwZ1pFV2YvQjlZRFpJemREWjhSTnZjaFpNcE4zcnRjRlVpQXhFRkl1T2x0?=
 =?utf-8?B?aUZkSmEyenkydlQ5NEZ3Sno1Q3F5WkorN0t2cllyNDZ0Y3VaQlNXRTNOTWVm?=
 =?utf-8?B?eURMaEZLMnprYUpqdXZkL1ZJNUJJSjUzR1Mzc3lPaExTVmd1WHZuYkViWGc2?=
 =?utf-8?B?QS9IQjZINjJFdk4waUluYmpDWWVRQzR6cGY0czRDdm00NkZYbmtXdDlQNEF5?=
 =?utf-8?B?VlFQdlFObndTRmMzd0NKZmVRTG1tVzIyeWx6amlES3lYTFdBTUtjSzlZRTF6?=
 =?utf-8?B?Uks5SmFCc1dlME1zOGJTa2RmWEJOdWxIN3FIR3UvU0FkNG5oRmNlUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8c9b22-f93d-4314-7cda-08de53bcf8e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:33:43.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwNVgL2/NygS3z6RfXS/sYRDWixs8ZD1oONepDIkgfCIK22QlxmWTVbeH3CgjAde8pa/ENkG+2cNllsEwGafNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Add a managed API, devm_of_dma_controller_register(), to simplify DMA
engine controller registration by automatically handling resource
cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/of_dma.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index fd706cdf255c61c82ce30ef9a2c44930bef34bc8..c630b23fdd1313168e2362415093f106d6a66c46 100644
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
 
+static inline
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


