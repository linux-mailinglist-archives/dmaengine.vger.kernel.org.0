Return-Path: <dmaengine+bounces-9106-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEn1Cblsn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9106-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA89119DEB3
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CF32305A2C7
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1D318139;
	Wed, 25 Feb 2026 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5bNU6hf"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CA314B79;
	Wed, 25 Feb 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055722; cv=fail; b=WLG/10RrsN+51oN3MEtJ13HJGLjtU3ANFT+n3aC77e5mJHQD7GxBu3iVbjSOlBPHasTK668If1kGDJfsA/4ok44IMB8rakTAHOaKYWAz1mlgJL8Lz6jgS751IIuuQPMVHzB6jlYWAUsJyu4gJvzOFKBb/Ka1USGiu8me+PdL1eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055722; c=relaxed/simple;
	bh=6oXoEVjw/s7KtenPfEUTRRX/JemT9wDDItCXEAwBMYU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rPtMSi3n/hdMiBqucHMj+UreKGqV0ZLAZ/g/BYaT8tOfQKdnnW+/wdhF8Ua2IbcTh3FWSX0R1HsNzzgJxJQPBA2QF9jhs7R7DDhbvvBG0hbPBAdRszDhyZwx7mTeKy1P5eDr5ilV6/OTgtw9/g2smGPYRWmEN8JgsxdF+vmOkjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i5bNU6hf; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqGom4H1sOd3i+nH9knUJZRkbXp1cHu1mAMN1VU0won/Z7t4+Lx+T2MxPZHLKQFSSNpG0FJzDuyFtkQ0ItrAXEjoMba5DbCWyXUT5+rgHm1rJ5scLaJLK56jmGwGlh0vrLcbrR8GqsswTjX/q88bi6ZBZR6d888Ia977sb3nXI4GMPlKY/AKmzM0S75XQu1+OJeXYan/6x7qfU/6/tejkOLRGbDGfcVk4D7ZsowCC//cUIZsPhErH3OHebVBOUJ/jnHIQH9pzuSf7KyqzS5KYkrnIf2nBugunQMJF/YD5aJcnKUF5/IBzMRe/PS/tlEJBPGRULAJilje7sICPfxofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIhPlzVB2eNCFFyPytfMKuAAalHWKWIeGDeY2sjzLX4=;
 b=UBKuuL/be/jvImOwdEiV6P7BYn9vS14kpEMvkdh9UJPNynXoRmTogI3eS0MWEZrel7mVxfVSkX5iPphDpuvZS2V1B/8F2QOTa/qd/vMpQPbTZ9s8tSk1Gc1QXP6biqqIzKrb9mOzLtTDFxDx9l5BGtLLil+6XkH78cfpVPUWhABSVczt9N8uvs5l/lyAnzqI7ZHLsTJBp2SCrMZxzOmNSEqWRyV/iHzi06VjCDy/0RhsWqNf7fherw1Y83IEDmu2Mmjm+0lVnh1NHFmR4KGo2xBBfzJLMBSGacgUUiQcrmtJig0/vGzY4ImPmXHctpaNAbONGq3H471N0SdrvWyK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIhPlzVB2eNCFFyPytfMKuAAalHWKWIeGDeY2sjzLX4=;
 b=i5bNU6hfJLw6pNEEL0vFiZZKkULFX5pySyuY5ig0bQgCn64zz8ILzZwiDm6lMt9pfsQ+rusm/irj3IQWVTmxjBUv65fyoYiusOx9Dz2kkoiOFW4n9xN9AcNx2d9q0qFcg+bw1FkZK61zrXTYOlxrecg2zBIZwMUQGBf3yTxqGYzxrgMmKP7BlqysiblHbqIHrvLD/z0ZU2XULGLfdO/29TnBAymKp5SaOSA6Sp8MC4DocnNWdQrOdA9S2Uvxik8Ijc6onRDPzmbM3D9CllLxqR/bWOWkZJsLnsZ8jUEFLFhDaLP4f3DdmLbaGS0AFxjUmxqjN/4d0erZDZdR9a97Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:41:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:41:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:38 -0500
Subject: [PATCH v3 02/13] dmaengine: mxs-dma: Fix missing return value from
 of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-2-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6oXoEVjw/s7KtenPfEUTRRX/JemT9wDDItCXEAwBMYU=;
 b=ZT7DT+KZxIwr0JG4PhVUhQv9VPIXYyA5QM8OC+BVhsUtShUPFj5eZlDsyzV/jVZXBE+WcM/JH
 1/1Xj1pqOicBPFd8i7KM/Th1xcq1uk/jqFETjfs6uzRAwMQ2+Sp4Z08
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c102da-b1f9-41f7-9f2a-08de74b6b3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	606ethjBZ1SorBJQQcNinIO9u3be+Gx7PElxUK3gAYhO8nQGuD0HWL+l4m/fqfd5Q9MOWuQHVNi5tc9pK30oCbsM6UTL7aalAeap4zlHqgSCue4KKpdVnxjI3koa95C/V8/UnhQIQMEz75+Yg1H6UYjGzCBHuOPhQ1RDQDEKh9JHE412rTBDpx42v94X9Q55fa8U0isMV7iw6tYDOnfuV/0OXua8EGAfVOW7bOFwxg2DrU0xDFsu1WzLYOr6X8x45yn0pEp386E2+DqB9maprLDW34i2PqCmU295XMQ9nAD5bSuqri6Mna4GzswkzyZANKJpmNf57EtDma6aTPj36KgLaKr09njMkTwsoWQA00PVDDYYzkL3U2sVAlisCB2v+EAcH8XQDheuH5V52d02p3VHxIxzb/XjPoBzrBhlHPX/Sit34jRFfK9aSalsZrOQTWQ6u/LBc5DFB9VSCs96atcEkt5tggHkXG8OzHDZSKKoixjto23ht966eBW7/lWxclaE/cMhacN/M9+/RB0+kMdXuNLJyO0T/KdURorJCFZYc0AcdPYrjD8/fv4YXw6KSBe9rUD892RH+Uezron87WpgQN7d/6hZUnDv3As5w/R5t39XsGQ5wesvOacKrbQ+y9I0FESeE8Xi/g/5vws8VpEIH9TgQv2TlXCg//gGUmSB1s9/nSQQ9AcZVru5zOfLvCyBe9in65WIkx9pqmYycNZO+K5fB2+jXXFf6vm8egKvpu0aPsh9RBpWHoSGbZVFC1xISQWWb5WT894WHKKugopj79RJsTG/XiDqJeUZwu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1ZtSzV1WE9aczhVTVRkcW1LNWdsOVg2MjNEYXJhRHFBSTNhVXBDcUQyWmN4?=
 =?utf-8?B?cGxsUk5NMHYxaGNNL1ZpOTFDeXNnQXZ2dUdFZTgrMHJPUzJkMG9UOW9oMXJ1?=
 =?utf-8?B?Y0s5aElMOFJPSTBHN0F5azNZR0NFc21YNnVvcVNxQ0E0cTQrWFZMbldUdHZj?=
 =?utf-8?B?djdCbW91WFFTWTljeExrSVpaa3c1SFlkc1pTcG5TU3RueVhnS3cvUVFrS2Qv?=
 =?utf-8?B?Y0tFbFNrRDQ4OHM0MGV3dGxkWVptT1pjL1lXdEcrb2Nuazl6YjNPOWtZUjF5?=
 =?utf-8?B?NzlXcWkwSm0welZpamxkZTVOL1RZV3gvUjUwbEVoR2RleVYxSGNFZm9vazJo?=
 =?utf-8?B?QTVVT3lteWRkL3dIbUZPMk9QOUxGUE93Q1YvR3J2OWwzSk5ac2ZTeWFML1FL?=
 =?utf-8?B?OVE4WDlRRmZ2dnlsNU5wYWdQQldxZTM3Z1RWR0JFQUc4VHQybjY1MDlWZFp6?=
 =?utf-8?B?ejVoWVV0NitJNnRCMGhHM081WU5TU2NiUGtQa2pJdjZoTkhGOGhqL2FEZ1VZ?=
 =?utf-8?B?Wm1pMXZMcm9BQ1VQNjlLQzRrQ0d3VXlPL3EyOXVFTDFWRmVWUVBuOEdMTEFN?=
 =?utf-8?B?RmtqTDUyb3dXRFFxR2svUVdudTExUFNEREJmNGZYdWsybDdqU0haQVJ0d1Bm?=
 =?utf-8?B?OFduNTRMZURHbjErRlgyV2NqQWExMzlNaXpZbGJSUVRxcEloL2M2cCtNak5K?=
 =?utf-8?B?dG9IYUVTNzdHT1EyKzVQbnJwRlVjRW1iNlZrdDBpbGFiaVUrNzZyRlJobXpJ?=
 =?utf-8?B?N1ZBa2wyWDFYc2NadWVKUTFWdWNSeGg5a25kaFZ4WVdaL2dwMk4weVdkT3Rj?=
 =?utf-8?B?bEJGa1ZDQ2NIT0JuSU9sM25SUFFYenFmMFdueTZQWVZEc0FsaHFzOXd1U2M1?=
 =?utf-8?B?aS8rS0VkRmIxc0VGZ1FISkoyKzVLa2habUszVXV2cUhOTmhxWlppV013ZGlj?=
 =?utf-8?B?VmlxKzcrZ3lWQnJhQW1YeXljZ21lVk5NTDJJMU5qR05CRlZsdFZxOWU0UEFu?=
 =?utf-8?B?OXE5K1kzYUMwb0lpenoyeGhXMFdaVkVSUnZocTFrbDRmN0tINURmMGYyY05u?=
 =?utf-8?B?YjFTbFZnU0hmMWxZd1I3eUtCeUNQNExDbzBvS2FMdEpKSmdxRmtCdzhCK0hM?=
 =?utf-8?B?U0YwUW5lQWVTSWdrQ0xqZVpocmVyeEd6amtRNndHRlFaYWtmTjBuYWhhTUtB?=
 =?utf-8?B?VWxKMTI0M1NGRGVmNXJUL0g4Y3RQYXc0UG9xWjBvUlZkOFFyaUp5WHNzUDJZ?=
 =?utf-8?B?RmtGZzNONzI1NDJLUGFxYldYWmh4S3lGUFYvQmliRzExRFhWVFZuckNXbVlk?=
 =?utf-8?B?bWRkMkR3Rnh2N0RuSVRWeTdBempXSXk1YnMrNlN3RjRsSTdNT3Y1bExnd0xG?=
 =?utf-8?B?YjFUS2pQWjJ1TzdCYTlva0pmV1pJUldXVXBzYmhLUlZFK3Y5ZktCTzdwUGRH?=
 =?utf-8?B?Um9kaEdJUzRxbVliRVJVQWs2Q3RnZlB1VWNFb2tqdCsweFY3UTQvNWJSWGRt?=
 =?utf-8?B?cXZxd210UUQ4bFBKK0NkRDJwb0c2UTR3dTNvV0V5V1doWGZTdXJaaTNSZkZD?=
 =?utf-8?B?OEh0WFZtNnYwS2h4NE84M2JqSzRCRjhzK2V1TUNibUYvZHBSTVppUXEzTk5q?=
 =?utf-8?B?L0dvV1UrTExEUHZPcWdVNUprSkpXaStpekNiQlFLVlU0RjY1ZDNpL2x1UkVN?=
 =?utf-8?B?RGdyRERzcVU0SHl4V2Z5MFBQYkdOQlIwdHI5d2hFSExENUhiWFZkcWpvTElr?=
 =?utf-8?B?QUFQUXVZMTZjNHBvTGRHMmgyYU5odE5TeDBxZ2dMRG9iVkVqM3FvenhkSTN3?=
 =?utf-8?B?ODJGc083eDQ1Tlg1WUM0ZURzd1hmdkI5bkZsUmlXbUtuVFU4eUtOUWgvWk96?=
 =?utf-8?B?N1VQSExjVlgzWUE2UzhBSlgzOVVZZDAvbXo0SGRZSHgrOUhSMDFxaDEzckFQ?=
 =?utf-8?B?dkNKaDltdS9QdWgwMVdqS3ZsREJ4S3RHQkdGbnJvM3FrQWw0b0Z5TWpqS1gx?=
 =?utf-8?B?dVBRQmZPRTgyWXM3MnM5a3FTTldjZmRBM3FCL3c4L2NiaEszTnR6MUJZMDJI?=
 =?utf-8?B?ejZTbnVLd3BzQnJQa3AxSVpBajQ2REhLMXYrWlFPN2k5MlhEL0ZXdXlHQkhU?=
 =?utf-8?B?TEYvN3VGaGhXcFFKSzRDelBoR3hBM2h4WmF5b3ZCL3JvUnhXOGFPc3lZTkRn?=
 =?utf-8?B?a2Q3STR3NjBxZkJsRWRweUVGU1FGVkpwK3B2NW9td1dMUEV0Ry9PU1pheFlM?=
 =?utf-8?B?VitWeU1pRHJDanJGWklTYWJHWS9qbDRQQ3ZKOG5mTDlLMVJTMTNSZjJ6eWVM?=
 =?utf-8?B?Y24wVnRXcnZCeklKYkgyRDRQSFpjWkE0MTQ5MThVQWxXMWM2R1FCZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c102da-b1f9-41f7-9f2a-08de74b6b3f5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:41:58.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohflYVburAEWJ8vtIbRhW3AUArS4WlvL558YqPwPHfoxGst8jt1DP2DFejtLvzPuiruGEnqg6C2csSwYx3EQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9106-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA89119DEB3
X-Rspamd-Action: no action

Propagate the return value of of_dma_controller_register() in probe()
instead of ignoring it.

Fixes: a580b8c5429a6 ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index cfb9962417ef68e976ae03c3c6f3054dc89bd1e6..53f572b6b6fc62c6cb2496f0da281887f8fc3280 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -824,6 +824,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev,
 			"failed to register controller\n");
+		return ret;
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");

-- 
2.43.0


