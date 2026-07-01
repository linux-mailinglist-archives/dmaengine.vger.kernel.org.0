Return-Path: <dmaengine+bounces-11917-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UB8oFlzdRGpS2QoAu9opvQ
	(envelope-from <dmaengine+bounces-11917-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:26:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C17166EB975
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:26:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HM2L7cE1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11917-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11917-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 841F6301DC35
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7A3F0A9E;
	Wed,  1 Jul 2026 09:26:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96323F0779;
	Wed,  1 Jul 2026 09:26:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897993; cv=fail; b=G6dhze12ziLNPyITG3EbMsDxvZ+LLQXdizoUakDB/QH71J078LnkpBPHAHRYEaZG0AU4P0OfOvqFBNXBwBg5Z8b+L34jlUKcfOmXzL5lItEBr/Vte6q01aP0JB3cgx+LAqkrkP5dnWj9C73c5nQZ6n5AyM59ed5s1bmVeUM2rzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897993; c=relaxed/simple;
	bh=z8cX9LVvAfAMO3eGCWP4ThkmCy3QQA2yiPj/83qN8oY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HhIkupir0e5PrcOSdUzGC04ApY0wtAd9EUbSdmmxMTvWiRMbQvhiMNy1YD8ffb68NSTd+QIXXtZoykhwG+8QKrefEexuzd1z+aNQZoj9N4ddMuKI1MPPsefGP5OWyyCA0y1o46dCQJJQ1ILAU6Iu2rh/OPdFnEdqQ5jzY1sM3yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HM2L7cE1; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXPVO3ZPaEtW5ev4f/jTBMkQiG19hxaOMdbCzOjR0mubneh9/gyf1CrCk4PkQb7cTz432X0ZCH0KjN53yt51+XhfCXUKsAVrVaWMwcm/juvxtIoUzRCmrt0O0q6Dymk13rKBKLgIYJLQTKLL9ot6ty1ADGXCL5MsOKtNFCz05G+WMEGI1cmZm/fad7fMctAe2nuSNpO2h/gpYJUaYkh8IJZ13vG05v92wTCA1rre4N8oIaOxYqF+rjyccl7+bjYE/acOCYREyeecyGCo9lBjp6BII9P/zr9VG+6+ZwZy2xfMjv4FAmXfNB0UnYUfiHJjjGoaD6KGkdFKhgMVkKXz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ9pexjdgjehfKPFN0oRj93ShNmGLSRmsAPL1dT0n00=;
 b=TEm0WeR9SXN0zipP5fXbvy95uBXsxc5HFj88zbwG6kYF8TQpvIS3qRa1bvF9K1dpzIGMApOMmODCBBFHl0i9fPQqd0XJ3iW+HIACuZyUOzr6jIIl8gZaIDFCXeL9Uu5lw7/XdBpaPO9TX3iOzS5wttDOULjZthXbat4fbCaWb7apu2X/s6+zIbBwv3k62dOCaX4EFkxTSguwAoHtRJo2zq4f4Q2yqgxmHIlXoBxwGUXWG90jEit7Ay5Py207i6BUZfg8Vs6Cv2k1B2Uju4WPa2p3J4jRA9K9CWObKLq5K+O2Ac7ZCWtvE85J4nSDbdX0L2O49Nrh7kst7GxaQEGDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ9pexjdgjehfKPFN0oRj93ShNmGLSRmsAPL1dT0n00=;
 b=HM2L7cE1uPwHT6P4QBvmbYYFC5aCpYnCc7qZoa6jCq3pRgSBaIXCW/vcYR6keMwjR6ttTAlBeWeKCnR4CakD6+HgKwroMcH34RyFKeuUsAloIfgVzjLmepA95FQcx2yo0O7zjaMIiMVhp9ksPkeHGVH5qgwiud25f3G7PkZqCMZK9wfNnjnzDcRVXdf5tdz7tQQqoTKwjOlWITek0kpb6DePYLiE7RZXzeHRQDRq/Vfr2dTOvjQZ4iZyQ2+MdBnybHue2WMWL+oJ+8QUUzmD/qD50FtGNwqqvQPJSkTLSmzuNsVJijpLBSRut4Z7QKil96cPnj4IBRHyyXT/heXIwQ==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:29 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:26:29 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 01 Jul 2026 17:29:24 +0800
Subject: [PATCH v6 2/5] dmaengine: fsl-edma: use devm_clk_get_optional()
 for DMA engine clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-edma-runtime-opt-v6-2-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Joy Zou <joy.zou@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd46d55-dbe8-4ad5-dc22-08ded752d495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NxfM88U9DrZbkh0E7E6X8obfF71gtyRtwy0OtkJXvwo4G8fpZFKFjEzSrAL1EQobjiNYxgEmA4U8P8HOl1d2/OeHyF1x4elHdw0/wt2dV3c+HUwSObROlRPlQtJ6Zvvm4agoMgWqp3mv5tyrSoI67pbc84WI3s7IcivsWFoiAQ0Q83SuFDCYDm84xtWrj18pLMX6+7lcEuXsLnle705PVycKgSEunz9cxm0n9B6yTevQyomrWE4Btg2io5d7od/CohbIFO8z2q7DcDND5t9dudEPvAaNx6lfvwM4cxSXLxwai7kbrU/7nT1F208cE6TnqhE7eUNNuTPsE0j+/JHQIoITvSVJ9ddrdJjY4gepZX6WZZQxFSfA28B852nZDF6c5us6PU2ahIxzT1ZBJsJmAMryMcwMEml5+kzJdytlDx8BI5Lw9TNy45g26hPzcuZvQoJyU/v/dwnS/HfN+VvT3tW5Gk6GRqiROmXo58h5Pp8BB9jjdRuiach8Ko+TJkOETv7njVOIneqX0qT0NIdFFPRusdLuj26j0w8mSApOCjFSHpxm3CMdn1JqRhsypd+1TB2nOolVg5k+lnh8n5mpP1qU3iuf0Iby6zNCX3UVzSMO9t3IhOd9UFPfYvliZsS90a3iEvSrrRwnHsZX03jy39PGzMBj67R++iiXkhR7g0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0paZDNIMzRZRzBKVUREV21HZFYxMW4xRnhIV0NSb1RBU05LODhyclkzcDJ5?=
 =?utf-8?B?OVdYM1lrYmRJWUhqV2krRkdBWmVMVWZUdzBsNFh5dk16dWEyM2piSTZ2ektp?=
 =?utf-8?B?RE81WjQ3bWhSMmp1WXZaYzNaRXlXdVZNcWNTVldRSlBBVVArWHNLd3k3eEpG?=
 =?utf-8?B?NDlEeDlYT2pBYm8vRnpFNWRuUktzbjk4cFd6cHVvcjQrWU5FVkJUNWdBeUhU?=
 =?utf-8?B?TTRGSVZpcy9sRXY4cUpQNkM1TVZxWVpUUmpldUZLUFQzUWp3Z0JxRSt2YzV6?=
 =?utf-8?B?YW80WWpKdi9ENGh4ekw1akpPL2lVeDlpMHAza044RkYybzBjZVRyRHVHUkdY?=
 =?utf-8?B?SjZIOHNhZWRtSS9tRlZiT1kyOXI0Z2lYT0kzQXozTWp2S3k5bzlBcmZWMi96?=
 =?utf-8?B?WW1FNkF2VEZJcGt2TjBrc2xwOEZwc3dUdDFDdkxZeDFOSlZFbmMzVWh0R2N2?=
 =?utf-8?B?YW1oaWpGMytCRG9VK0M1dGk2MUNtdytYM3lmSEhNN25yUTIrYnR5eXUyYXhH?=
 =?utf-8?B?SjMzRGl3aENqODlKd1RGYnB4SUZuZFpiVVcxWU1ZeVlZTTQ4Zk5oaHRTK0la?=
 =?utf-8?B?N3I1VnVPQjhMVlp0anlJam1ZZE1uUWdFWm1jNWtrNFNlcStDUDMvb3h4dGY3?=
 =?utf-8?B?T3k2L2R5YjYyYm9MYktKTnVKVFZUOGFvRktGbnVITkFQT3VVT2Z4c2xXaG9k?=
 =?utf-8?B?V2puQmM2UWwreDN1YVdxWVFQcHlJNktpYTRYOEV2dnBBbkFJem5jUkNFNE5S?=
 =?utf-8?B?UC84S1dvcFR6allPeUJEMHA3WHdSUUo3SE5JeCtDTE8rdDRQcmNMYlRHcjB2?=
 =?utf-8?B?aVdreVphRHFVMzJXTGVQV3BhS2taUHNST1gwV01QTnZySXVYSUp3bFA4aFJV?=
 =?utf-8?B?cTlpa253RXdGMFphaG1KdUhzcUNhT1R1VFZPbFJsSVV6SmdrZEpRRzF6OTNS?=
 =?utf-8?B?K2RSeVRxQm8yRjdMU2QvQ1orQ3dtemJFZFQzamlKZkhwVytjTmFVK3VBVC9a?=
 =?utf-8?B?bTJieFZSQmtuKzhJSTZndUFvNGlEeWxwWUZhQjZtam5RcTlYWGNVZVNjQjlK?=
 =?utf-8?B?YTJ2b05rY3NsT3NmTVFacm5QK0FDK2ZnRlE5cUozc2RDYTNnVG1xODBkNWti?=
 =?utf-8?B?VHhaQ2RQYlRtL3cxeXlPM2tDVkJUM0tCL0NYd3h6dXJUZmJDTVlRVXQydWxH?=
 =?utf-8?B?WE03bWNqVzhubVNMZWRQUTlhcTdnOXpTc3Q4QTYwd0pqYlFMV3VuUmdIWktm?=
 =?utf-8?B?QmFIdTFvcmpuRzNKOC9PYW45UjdHZ2taRTVWMExFa1RSVTY1UW9hdUxSWm10?=
 =?utf-8?B?YlZuY0FuSXpuRXdPc3Fybk51QW5ha243YWcvdVJiU1g3c244TzdnMFo0cEJO?=
 =?utf-8?B?dHBJUTZFeVY4Zmt2b1NEcHhiV2p2N0RBcW0vM3ZCY2FhWmpWL2RtdXAxMkNO?=
 =?utf-8?B?ZVlrNVNWUGVDN3E3dElFdmhRNitZaTJVZ1hnQUgvcEJyYXRCRS9hbnFkbHpO?=
 =?utf-8?B?SVRrem91ZE9aclBKTHo5WW1HQzhoY0FaMnNRVFFNQ3hqRmRIUkFZQ0JTMVBR?=
 =?utf-8?B?S1g3eUV3MDJsL0txRkxPWnFZbTVXTW5TL1VLbEk2MUQvM0JrT0VNc2M3Zytl?=
 =?utf-8?B?aXY0azBRMUNBNmN1c3FXRjRObXU1eEt6K1RaRHE1K3BtS2RzcGFOTmRKZ3Vn?=
 =?utf-8?B?RTV2SlpaT1FaR2tIa01GUWwvM2lHSHNqQkVjRmd5K0J4SG1STnJENkNXblBv?=
 =?utf-8?B?aFdTUE5KZU50N211eUVlc1NLU0EvbUY0VG94eldLSHFCeVB2QW44aDNLRFdN?=
 =?utf-8?B?OUhBR1lDSzZlaVJUZldWNWR0SkM4SlB3YkpoenBrSXdrU21YcU1JdElkL3I2?=
 =?utf-8?B?L242UWdiWlFmYjBIMUcyb3lIN2lZMzF6byt0eHl2Y08wVGJwYzJoU1V6K2tY?=
 =?utf-8?B?MjNBV1kyZ0o5R0hPcXpyTUwxRGszQjNnR3ZVZHhmdyt2YWw4SmwwVVRyZWh0?=
 =?utf-8?B?bVA4T3lUNE0xVWZHY3d6MHhmOGcxMXpmYm16ZzRLTVErbjJQd0lBY3BLWnRk?=
 =?utf-8?B?R1JwZVpIOW1IOFVZdlltWEtDSCt5WTNDL042andJTkdLRjl5eWhyQS8yUGti?=
 =?utf-8?B?SmlmVUZpb01qQ09zR3kyTS9vSmdQN3RnUkVkR1NTalNzbGRrczltbVpmakwv?=
 =?utf-8?B?dENYcnk3OVFWbUxoZTZicHMwQWdtMms5aDNVU2IvaXp2eXNPcGwraDRSZk52?=
 =?utf-8?B?cEl2Sll0Y1NxMWwwSEFXU0RGRTdjUGlzZnJjbytBN1JNSTkvZzlhZmhRMERQ?=
 =?utf-8?B?QlVKcmFJVWw2cmViV0J6dDduV3NqdlZ4TlRob0UwM0R0MC9WQWFHd0xWczRV?=
 =?utf-8?Q?reHgjGbPT3z8BajQULErckQwk8sJ+pZHmb6IZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd46d55-dbe8-4ad5-dc22-08ded752d495
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:28.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu0YxTt81G6IAKwoEoCni7rACqveS1jbG1PST20+czAnodUpUnSenPBaH71EeDYyjAiIGHf1kRt74E4DT7LdAwWGo/A2/TjCu9/8SkFJTUsrPf0oYslVQDyzwphtWzLC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11917-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:joe@pf.is.s.u-tokyo.ac.jp,m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joy.zou@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C17166EB975

From: Joy Zou <joy.zou@nxp.com>

The eDMA engine clock is optional and not present on all platforms.
Replace devm_clk_get_enabled() with devm_clk_get_optional() and
devm_clk_prepare_enable(), and remove FSL_EDMA_DRV_HAS_DMACLK flag
to simplify clock handling.

Prepare to add channel runtime pm support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v6:
- Replace devm_clk_get_optional_enable() with devm_clk_get_optional()
   and devm_clk_prepare_enable() in order to use runtime PM for power
   management later.
- Modify the commit message.
- Add Reviewed-by tag.
- Link to v5: https://lore.kernel.org/imx/20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com/
---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 26 ++++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index f4354b586746..54128b3f45cb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -204,7 +204,6 @@ struct fsl_edma_desc {
 	struct fsl_edma_sw_tcd		tcd[];
 };
 
-#define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
 #define FSL_EDMA_DRV_CONFIG32		BIT(2)
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 1e864cd4c784..88fc1b06e518 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -554,7 +554,7 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 	.dmamuxs = 1,
 	.chreg_off = EDMA_TCD,
 	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
-	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
+	.flags = FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
@@ -567,7 +567,7 @@ static struct fsl_edma_drvdata imx8qm_data = {
 };
 
 static struct fsl_edma_drvdata imx8ulp_data = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA3,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
@@ -576,14 +576,14 @@ static struct fsl_edma_drvdata imx8ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx93_data3 = {
-	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
+	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
 static struct fsl_edma_drvdata imx93_data4 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA4
 		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
@@ -593,7 +593,7 @@ static struct fsl_edma_drvdata imx93_data4 = {
 };
 
 static struct fsl_edma_drvdata imx95_data5 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA4 |
 		 FSL_EDMA_DRV_TCD64 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
@@ -733,13 +733,15 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		regs = &fsl_edma->regs;
 	}
 
-	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
-		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
-		if (IS_ERR(fsl_edma->dmaclk))
-			return dev_err_probe(&pdev->dev,
-					     PTR_ERR(fsl_edma->dmaclk),
-					     "Missing DMA block clock.\n");
-	}
+	fsl_edma->dmaclk = devm_clk_get_optional(&pdev->dev, "dma");
+	if (IS_ERR(fsl_edma->dmaclk))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(fsl_edma->dmaclk),
+				     "Failed to get/enable DMA clock.\n");
+
+	ret = devm_clk_prepare_enable(&pdev->dev, fsl_edma->dmaclk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to enable clock\n");
 
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
 

-- 
2.34.1


