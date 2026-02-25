Return-Path: <dmaengine+bounces-9110-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPmkOYFtn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9110-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:45:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1119DF95
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190143122C9B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EF318131;
	Wed, 25 Feb 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EPxjX5cU"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AD3164A5;
	Wed, 25 Feb 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055739; cv=fail; b=ekkq1+RZd22qMyXb3oZy3bhakqTbWic/W7QMNCDRBkYTqiIAK4LkR/tCV5OJywcIjc7OXGpFmHilpOFmq5RdgJQp2Ng+d4OnD3dUyKMFvgAaJ3eeeEY3ZKSoZWxu3b0qdFXeB52AcCYhbOLpO/wFP6O4W26YTXIoPAMRDDfvoLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055739; c=relaxed/simple;
	bh=Zsiu0ZX4apduiFXPT4qQHZt4V39hp3d1G4V2rQwzfgo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bLIL1AzJ9FT2aKDYbdc6IhpMdKh8wT/QMzmsqMRiNjUzgTghPLg3GiC8OTkrN1ZHGEG65hi+ZdCM11EwEwLn8TLXLC+NhL/Jyp7XflItT1dZQs61maPpm9O3wgjVBKCSb78+h102lIcKfX6C+bOaWKBT8Owx/3mYTqQPwuW12gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EPxjX5cU; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dho1MB15rcvaZwyblKOHn6EhFp1/lOxD2xYhNvys4mPvCI3chzFvxzF3EJtpEKA+yCJOcyWia3Le391RoyRTTLSjPbRHPUIeiBPYIeMD8Yid5jhuDze6Ikb4jWLxkzdqOrT3g5J4Lo/DvU8x+Lrwz4U/fXc4pX1shVZKWhurFkU6AlqV6a8cc8TkyBNJC0WZv7cRaIz7ZHARuzrhpI2WuhHFll9tFJ6bAT7UjsHnd8hnzWm+7XdcTX1KhLg09mml8wy2y7t28J7DvZyPfINxKFe8dSGblifHkmnMw6UQCSIyUR7hUx6l6WDGiRc80NsKBk3/OPkqN8Jnp7ald6R6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH6XB4t9DDahzp+/l2z36GyP3p817v9OaRDH9rXUqkU=;
 b=IcBj35KymtGSKAg0goz+MsumVzF1URFwoE1IqeL8l41dWd2WQ4Dee5lqe5PjLcYlrDXc/XhJXuoEt4SyujivRBpbboT31H0MQGKixcR0Z/oGIz6OGNKWYF/DiVJB/uoc0WqhtSUwgM8ep6pONwHWSlkhiL0OOfIIxv+eO8pYFf2j707aZKkBtgEzAKbRfa9Zl2/6CT15PQQ1SJO6Tw483VwsEvAn+jrV8vhVTTVBM+pBYjWiSYCstZas+d5KT5ZwpX8qAOCOVoDIn1UgIuwh//sWrnRR/Vx0rMNUz/PQm9M6ok3X2irxahm6BNRjtNO9N8BIoSO1HMEGc6wgiVRkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH6XB4t9DDahzp+/l2z36GyP3p817v9OaRDH9rXUqkU=;
 b=EPxjX5cUHGMVNVFPm5AvoYVDtQ/DMO/sMBqCWaTePHjSSoo1jPxDdVisHA1zhBlw44qKpUonC6jNE8dS2Ul4qFHuL8bez10T7T1eqUH8kjN81Gd0WuYhTjqrqMM2ZGQKu8OxkQkV4RK6nAGD+wqqmUOAKoUPukVb9NExXV4FgYulXNdAm8AAnJPy+r+n7DXqYLoIyWY+0oAevvxpPpAFlr8d8AUcrapWaSz9KyCluI12FHBeqcovXW6o7jq1l9HYv0zzz1ATUfNnHz50QAif4VwRQBcWcGfKaHpnSlwIy9bUMzmpV4U9exr7tyK8jqJS4jFLGRdNSDGVTVCKRDjJ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:42 -0500
Subject: [PATCH v3 06/13] dmaengine: mxs-dma: Add module license and
 description
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-6-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=651;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iSsNbTm3cQXSqGPxXAFmjakJYV3L9rNOvQ4BRXU0PHw=;
 b=pJDhdqcVhtrqdB+VjGPVlcd4DpNI1qoMENyFRVFy+5C1K8EM/ZBe6xvSwU1IGNMW//d5CnAQg
 WdE5ls3c5/8DAbd4SCyEITl24/qLJ/W4E5we13lw76n/kxti4tzgI31
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
X-MS-Office365-Filtering-Correlation-Id: 985d2f7b-6441-4c1a-ae39-08de74b6bc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	FR5u4zQb8Fj9S6XXeUrPZm0Bq0LV7CJefZ1lKt4hl57ICwJihcUORaLAhOjcX4XFZYzMm9RjTOddzbq2egmF6k7DURKM08F8ea42iHEKL+TTNlP4w/4FyYER5JBw/nFNAxYSu+59ehpa0srafYvwgwCbqVP/i6qtEnIPRyPvDLpRy4nundxAiIj1+7bGAxK+wxe2XhCtmQewRzOx+xO2NDq6f5mtsRis3qW3l8V3p+GJaWZjIxPi0Wd7pUJ4pCBqxkrJGIlwgTa6z2je64Dn3Kw3GY0DSKsXfFt051X5NzCigQ0x4U9LkS2ztMYKrhSX1UJKkY9uYi5Dx2CUezEOxzLgqNDjjzRLiP038XlgbZAevVSw9GW6ujqF/ubgzO+MD1fouVZdD9j4kgGJQF5emz6HomlukbJ+BsOZPkE8/KY3Jv6wTFfhTkYtgCaICf/0aLqf81E2XWBI/8cOLS3J3hM6xIi4oQE624d9D8C8Sll5MfsN21flb8k8Ox6guFP+60/RdMtpOUBVYM6Ndyr4iUIi39c00ntUkY4AfHYz2SdPhyo0gb9eTX2FRj2PtqWD+SQhPTNv53Fajr+3NqrgCL0wwM/SJORFegKG+z+mLZNybLXoNXF3UctzGGzdKsr3i37lThSVRAEq2h7SVAZEZAjZi8gO/kgYQmjD6g3G3i2SWBIj02s9Ru0fsJqfO/ct969I5HF+90pVI2WJ75B5TOp1IyKTWcMO5IjW38nvH3SuA0V7W8FChQeLtU69Mnv1sGrmfq5h1SoZLrV+evx4t+yo+C3M/LlKwIUi2rYL7SU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhQbEtncTBtb09aSFl3M3pPUUhqVndCYUJVVlcxRXpKVWhDS3NiaHowTU5Y?=
 =?utf-8?B?ZnNjOXFEV2pjdW9yQThEeVhGSXRmUlc1MVNyN25jbXBpM2NGTm1nUFh1ZFVJ?=
 =?utf-8?B?amJJUnRsYittNFMyU1RtV1RPbi9aWVNjVmNDWndHWXZDZ25CK3ZWUjMzU3Jz?=
 =?utf-8?B?M0JBR1lBSHJJeXVYVXVDUHdkb254eFZrRDFBSXZCWUdoWXhtUVBTbTJEbnhL?=
 =?utf-8?B?YnUzRlpmYlJjUGNjQ1VHOTdjZ2ZjSjFuQ0VoQzFnL2xvaUdZcWx6STdoMUVZ?=
 =?utf-8?B?MW5lSkN1Nndnbzd0K0N6SkZzQUZiWE9RUFNsTmpvSTF6cHBxOWtKdUZtTDQy?=
 =?utf-8?B?ZitCb1dYa1BjTDFvd1VBMG82bFdQci9KTzg4TEhBR09jMm1WQ3RLZDVHT1I4?=
 =?utf-8?B?UjhQemZsM3kwczNqWmh6djBQSTBRcGhMb0V3TTdXRC93ZEpwejFLT2VlTko4?=
 =?utf-8?B?blpqNFlSdEJFTHAwK2J0RnRZZEJTb0RjNGlNUWZOWmo1bzU1cDR2eUZHQklq?=
 =?utf-8?B?WUg3S3pBMjdpU29uVjlFRS9vYzFnTWJuVjdLakYxekY3YVVnT1A4blpCRzFU?=
 =?utf-8?B?SFlNN21IKzJDa0dtcjVwMmpPMFMvblAxUTFFZlNCWkZ2MWNYZWJ2WVJXU2Ra?=
 =?utf-8?B?NUNLbVRKb0JYUjBaZHI0YWNvVG0rSSt3cmN4WkUvQVFhSVpUUldxTU4ya1R2?=
 =?utf-8?B?Z0dvTUJFV0hLdDU3Q1c5NVdDaGwwSFlMKy9peEhKN3dkcllCcFgrZEFHbVhs?=
 =?utf-8?B?clZ4amF0Mkx1ejhnd1F2V05Vd0dnRmRLZ2QzM2RPSkl1YmlybjQwcndPTEcr?=
 =?utf-8?B?NFRZSkRsOU5RZGN1Vyt5cHYrZ3NSRksxVkZxM3ZoSUI1N0I0c3NSNkpsZGRh?=
 =?utf-8?B?S0tQOTdOY3VQbTJzNzF2dFcvQWVmdmZTaC9CQ29OdFFRN2p0bmg2RVRORmZa?=
 =?utf-8?B?N1JGOWtwc2Q4RERScEFHRUI0TjBvYXlsdWhpRGRGSFByYmhHTCtRV0tSYW9W?=
 =?utf-8?B?N1lSQllYSit2ZUh3Q3ZHc2FYeittTTVGQ1pKY0tCSzhsc0d2WTRGcDhwODJh?=
 =?utf-8?B?MVlxMWRjUVJSNUFEdTJCS2g4bTMwZ2oyeVhoL1Z0bFBSSUZHZFdoNmZYYkFi?=
 =?utf-8?B?Vkt1M3FYd0ZZbXRLaEVPb3JLUjF4QktTaEh0b05MU2t6TlRjdHRab1BOLzBs?=
 =?utf-8?B?bmpFZU5wNG5xVG9GaWU2QVhCN3ZqOWhnSkU1OTZWV2UzVDhiWFFobUhmSmtw?=
 =?utf-8?B?VjBlSGl1Zk9RY3p2SFVBWjczS1Q2Zy8zWFo4dXM0bWVvNmg4dSt0TDNtM0Vu?=
 =?utf-8?B?d0RmU0xzZ29JZHJ2dWNna3oxVmRyeUFGVFFIclNUUzA2R1NYc1NMZU1HbVZm?=
 =?utf-8?B?N2pDQ2grTTJiQUdCRUxQM0xpZTAvRnNCVUpNTEVNTjJkK29aVFFMSEVEZk9W?=
 =?utf-8?B?cHVGZkZoYmsxbVJKRjcxelByVzRhQ0ZyS1JucVZrRTRIeUFvemN5NjI0Y084?=
 =?utf-8?B?bnpjaXU2T2tkV0tPRktRQmtvMEcxZThwakEvUVBLWHlVVWtrT2Z3Qk5ZWjB5?=
 =?utf-8?B?T3lYd21ZSXBHbFlwSk1vd2FGTDQ4V0RDMDEvK3k5VXB2NDc4VUd2RmhvdjFK?=
 =?utf-8?B?UEV0Mjl2djdtZ3NBTW43am1EMFpwUU9OTWRpSm9IUHJGOUtxUVVRT1hzdkV6?=
 =?utf-8?B?NG5tQ2hueW9YVnQ1YlRPR2ZVMGNhamswSWNTUTdIZXg3Z0JVcGQvM1pDR2hE?=
 =?utf-8?B?bzg0bFUzbTUwaUYxQks0MWZYTVhNZ2c1a2c5RytwSXc4ZUdGUDAxRUNIWDN3?=
 =?utf-8?B?RkZQZzhnZ0l2UjdRdnQrSzBvV2tNUDVFNVM3dkpENk5pUVBzcmo3QXltK2Zp?=
 =?utf-8?B?VWhZeWVxQmJzTFFIWW95UTRsQ214bzRjVVVDY3ZWLzlQR0hwMXZCeUdNWXkx?=
 =?utf-8?B?Nm1pQjRyd2hxb2ZXN2hmT3JqelZ6aXR1cUgxMmhuQTQxaEZCQTM0QmlBaUxU?=
 =?utf-8?B?dks2WlhPZkhHdXlITHBDaXFnME9yTG5MMEtlSGtQMTYrNEtpNVhpRVh4VjRo?=
 =?utf-8?B?czcvZmdBM1ZSeWo2UmlNcHdnRnJXNXQrWHlobWh3NlVUZG13TUtHWnhZb3ZW?=
 =?utf-8?B?OXF2ajRaY0pza1g2TGFDb0ZyTzhDaVYxcStUYnBmdFNXSlBqa2NxYWFBNVQy?=
 =?utf-8?B?VUZEL0ZwNldHTHpSdk1XTTZLU2ZHQU12elNiVnZwNW91WDA2bTlhc0xQcnl1?=
 =?utf-8?B?RzB4MTdSbjI3Nkg0anRvSS80dVB5YytqbEtjVzZvSmlEWFJ4T3ZqQXB3Yit4?=
 =?utf-8?B?VEdNdTA4MWdGSFd4cXVZa3ZlWHZUTkJDeGQ1aFdJUTYzMmpmRlB1UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d2f7b-6441-4c1a-ae39-08de74b6bc13
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:12.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cd2u7xMWHmZG3q8JF/pLFmUiEMswLSccEw931SFnySPxj6575BTuNLhb5XHHvbq296cYUlXVuYjU58Iebf3x6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9110-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 49A1119DF95
X-Rspamd-Action: no action

From: Jindong Yue <jindong.yue@nxp.com>

Module license string is required for loading it as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index be35affb91576f43d4ec41179f4f0013eee2d347..7acb3d29dad3074ac842425619f7373fdf0e56b3 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -836,3 +836,6 @@ static struct platform_driver mxs_dma_driver = {
 };
 
 builtin_platform_driver(mxs_dma_driver);
+
+MODULE_DESCRIPTION("MXS DMA driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0


