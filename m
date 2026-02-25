Return-Path: <dmaengine+bounces-9111-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAKgH41tn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9111-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:45:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8D19DFA3
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD164312B1F9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42331690E;
	Wed, 25 Feb 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XwUJ/y01"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DE53176E0;
	Wed, 25 Feb 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055741; cv=fail; b=gvYg5cqdjyVtNTzknRzt3e/qO/P6R2be25SHdUEmRx4eP4N2T/FsIygmBXG+Z6HzykadGWomf3DbAjaWmGYHXL+0HXzyT+vA/yobhZGB+K2Oo2LYSVrIG7TuVzDBRTZbpE4tUNtejYv40ClngQ03p6siE6wIsYpekdZ2z6btZf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055741; c=relaxed/simple;
	bh=i2Z3b3A9ueeWzwU4AJm4YhrDdoiO6WZI3utY/uz4hpQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YBwizIJZhcHaiwnrXrefLiPW/BN7nATQdxkvw2p6iNYM8gKK1L3DFC8cR5Hs+TSq4xMldrL8yEZcgl2WXpWhDEyEeBBkQq0QhNP0+KgObE8FkB8KFCzSswiuK2Eg5n3hbaN3M0GNF0gK6Nt8yTLQD0C0PAIYnKdVqLRZ/BKl4zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XwUJ/y01; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMoeHWWEIRO/lzuwrXZiRxCeHG0rKpXLGihwUcodec0NMsY/iOY5HDA7pHGGo1ZpcHDc/EzFYqw3xD/QYJALU5hIWtJNuoYbaq239XQtmPj+TGSdvflEuIBFzMMEPyD7FElk+SpUPs38aVtjP4rkJRyQNFOMSsN18sG4MOCO/JvD7yLkySA3/mXfYEKpaZe6XHPt1TTZ2e0GJJje+MYNMoKBNhbApk2ZqNSJvlMfzOeiabkh3F2DpVJLLqFLX+Z8RVnUzAkdB4k7wkUEj6o/OAdWzVClifiT2cMxevhqa0qCyp+tIjtNeVxuqhLRYosT+ldUOhHIXKNm0PkPlNOzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i69jXBqSvvLCdaaOVy/e7Jt5B2plN0fujbO6xS8p/aI=;
 b=vZrKZx+2eow/il5bOu0N5MotfpSIq4v+nAUSud1rQg31Yw7At2HZn43IVeNV+sarAdNqf5s92uE1OmFQ8QWHX0jzyx3/GKqTblF0GtnRvdG/fA4xWxksYPyWUCCQZff8TmDZQaJbJd17bvgwBGvXby3aNYxoQF8X0BbufdVXNQXGL500LdLKouioRIDuYR4IKwArJGkK94BdAd0OqPgGMrr31qiex/YDyZGvexiRjcMg/hm+pZa3gIV/OucGqbqtBksOp7OFTs6Dsd3Z8zozV+fQ0pixn13ZF72WdtBDYzz0hwZciqcdIRRfTbw65DWom8QaRFxyjcYRSYAW/rx6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i69jXBqSvvLCdaaOVy/e7Jt5B2plN0fujbO6xS8p/aI=;
 b=XwUJ/y01Xh3taMehO32PqIPJovyshdeNI7Lk/UrNbQGtk0pxp1fdVBX8oteoQXKyUUCvviMjpwSUc0AIq0fDtq0iP3GQ2j5qAHaqCTBJ22pWc35Y2P7ET5djMHPv455bASQ1wEgXfUkXz6p6oNgJdZHYogPO3PPswv44NEsT8v3kZ+OYxMtzUij9HyILGTFtVHQrDGI0cQ7kYjMKWzMkqoUz9Lo4IOhL5qV3ruKwkD2p8hP8C5ZQTxHxR5N167cErk7pr+OHWA0YUEfUlwK0o+riqoKB8hvm+kEKgm1TmuD+1CoI3ZiQNhf4oAgIyFJTlR3sic9kHD0DZr/8kWleDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:43 -0500
Subject: [PATCH v3 07/13] dmaengine: mxs-dma: Turn MXS_DMA as tristate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-7-8f798b13baa6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=680;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uMWp7/R0M0jxJVbVx+TdtkHRsJX12h07Y4jJGvtFsvk=;
 b=M58uy2wqKmB3ZYi9eZ9G9XqdeJC6UzKNRdL8PL8Q7/C9w8fdnihKSwCI2UgA5kIxV+Gb2UXi4
 5DGnhFAV8bWDaecAMVi/iMI8EiXZ/Zj2sgc/wOwKifktvqX2X0ekHGx
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
X-MS-Office365-Filtering-Correlation-Id: ba0f206f-b572-4784-d596-08de74b6be2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	n//UBvViS4AJ69jA8pC79FoId1VpaoBbZApXB62+8ume4lQh0VEOOPDbKfepV/xxdBRELg0JGzqZlakNvIZeqbmstslEcml6e/mBtqbeVLzb5YdFmtqnRk2RAOA1jEDuhQHL0h/jLvuICcRn1k+pWu5PkomraNoaHoLp4/7MQ3geZYAESEcKJqzH8xjV1Gbqc44Q2dsAbXbzpWhpQyLzAcJt8qIAopKSHNtZlmjNBHbyjUTKbzs+jC3wBhXx/n0ZP8JpOYJ8vSOd7EqADXGjIAhdc6zxu0YaDla4T9V7mvUUlMO+PXQhMiffN7qIfUbNs+SZmYvidCc0L6i71o+OnxBrCSY6j7MC3jcHxmFFUIOcqo8nPWlNFC38QnxWoszRMacWJbqsGG6IaU4/r3WCRbrZ17qJ/oFV2RtlJWQDLsGyT+fTct1y9NQPfjPSd4woUQU/M35IQFOXTaZsMy3pbcLxuZxgyrkUZGEyAE3+gKVpkELfqAF28Rveekizfg4FZxWU9q8dyi5kaGYlpZn1U+6U/T6laLg/KJEyyCpoYhSGpdhvmX25xR/WWeypcT86SL7qQ/7rzCOrHApXT176LGrHjiXAUVV+czsMGJMSVEPqg/5K+8j1cVN4PnqWj4tP98L1RAl4nP9OKxQ4kR1hSb13FcXlsP1OU3BqDG8yCOgOj9DitQq+I6LSX6yrVxlmg1IvGZq7Ud2/NJV1S2u3XiV5mPSp9Xb5l0UxQ6Q2+ia+ngYqmzpwkc0eV2ToWa8yuHOPhj+pb7JO64b1VrGn1nGKrHSrRpPl/PKhTDgaGcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U21zQUZLcTBadHdWa0VTTXFyZWNaVU9OdzBqR0tzb2VOdGxkWWdyWjV5aTVv?=
 =?utf-8?B?NXdNaW5MLzBQMmVIQzFQTjU0WGhvR0x5UHM2VnlYWkJHcWhRajhNYTB1QmU4?=
 =?utf-8?B?SGhIMHd4aGJLbE9XeDIrWVBZK1dnUWpOa2dQb21TQTI5azBNZUJBUUVKR1Nx?=
 =?utf-8?B?STg2cHhnYUM4emkzbjRPZGl5Zy9rQXJlN204cHdMM1c5OHB6UzdIOURkMHFN?=
 =?utf-8?B?VTdnN1BSVkhOUEo2R25sdWhZK0JtV2JlRkpjZVRITDZ3VGVSNXgramc2TW1z?=
 =?utf-8?B?SmZ1SEhMVEVhQlhhcGREKzVZWmZ4T0ZMaTFRUlZMQ0FhZENFREt1dWZwV2Nm?=
 =?utf-8?B?WlNPQVByekMxQ0ZOUlRtVDRnbUxkSWw2RXFRb0xBdGR1Y21iRFVXV1oxS0tU?=
 =?utf-8?B?c0VoZitQc0d1OGtTRERkdnhEdEcwdUJGS25NblltTldrK0hRMGZOd0dIMi8r?=
 =?utf-8?B?ajFrS2RwemI4WjYxOC9yaEp6b2FNb3JkS2p5S0pnVXAwVUtTQlozZ1JLVmF3?=
 =?utf-8?B?R25DcGJqWU5UYjVaekFpOEFFelp2Rks3cnpKdTFsbnV4cDBqOGQ3RysreEc5?=
 =?utf-8?B?WFFwV0U3N2R5ZXZ3TVJnKzM2a1ZWL2UrSWUxYm9idGVuL3YwTlhTLytmcEtC?=
 =?utf-8?B?cExGTE5XYkhuVnU5S0tMNkZrNFg1VjI1dlY3cGJGTUFjbC9STmNHVTExVXNx?=
 =?utf-8?B?NGtSM3dRSnQxeE93YnZFNkVlUGhIS0dveU01N0pMUUV5bE9hWDkvR0IxMFJN?=
 =?utf-8?B?ZjdTVHFZeUk0QWxtNGxLK3NyOG9HbDJlUVlnS1JiUUlyVTlkZFJiektiWkRx?=
 =?utf-8?B?aUNRSlhLV1RXRm9jcHJUQlp4TWZvSzVPWGtzeXV6eXUzNkduaGVSeUVjNTJt?=
 =?utf-8?B?dThaaWRTSXA0VjFTMGpFakVicEtLQ3RkVTJoV2NRak00ejd5cWdBb3EwY1gr?=
 =?utf-8?B?RWJCMUVlRE11TEJzUFpyNUpiRjl2Y3p2ZGI5K2M3Z0RXRVdCUzRNZTNZbjBl?=
 =?utf-8?B?T25LSDUrZzFxdlN4WUxLVjk2WHROOUo0YU1PL1cvZ1pUVi9zM2hKSzBsYkhC?=
 =?utf-8?B?dWtxV0RqTCtURFFGU0JqUTJuUjBIV1hKN0FXcVdQd1NpWDNocUhPNG1YZjgy?=
 =?utf-8?B?TW9XdXRaemJORTNBcWFkVDZsRDFqSnZ5Ym1oYWpTZmgySzV1dXVJb3lNeldy?=
 =?utf-8?B?cEpiNHpaOWNTa0lKNlprM0ZzYVR2RVdkRkdvNEdMN0o0ckRDV0pBQ1pRdkJC?=
 =?utf-8?B?M0djbzk1SWx4TzB2NTN5bThFVURnc0I5enN0b1BuV3ZjTmUxRWpSQU0wTjJ4?=
 =?utf-8?B?L2gzMGFLcjVWQ1lRTmNBbXcrMGx3dlRjM0U3aXk2WkUwYk90OE1GL3I2Qmpw?=
 =?utf-8?B?Um1wZ1h4WDlzZzlsZTVCUE5aSWNBYm5yNXl0OVFKTkRDZmQ5dU1SN3RBL21z?=
 =?utf-8?B?MmFDWHV2ZmNsRjhZcHpqZEswMXJJYU1OOEl0bm8zczEyOXlmeEdVbFdsZThJ?=
 =?utf-8?B?NFhyQzBxdENPNlpIRFZSNEFzaUZ5RkpJNHR6LzZQVkRzaGJ2a0RlRmpYU0tM?=
 =?utf-8?B?Wld0aDNvSXZPQS8wSUd1Y0gyQno3M2lPczRtUUVNS0pkTTRKM2RpMWNJV0Nm?=
 =?utf-8?B?OUlHOXdMM25OTmZ1K1NVTDFza1ZDUnJmK0h3UzdYMjdGQnV4NjdDSk83WWN5?=
 =?utf-8?B?c0FqSUhHYVJPa1hvem5iYVlyeFpmN21MNkluUElWTkcwVEdEU0pXZ1hRaUkw?=
 =?utf-8?B?TUZPdXFlMGpFZGN2MytCVHY2Nkx0NTY4R0ZYQzZqZDNSTjdTVDVLRVowOStY?=
 =?utf-8?B?OXdtQUhZVjN1RlExaVZ5RFJxUkF0SE9KVWthRFdYUkZpWUdFL2tYaFB4L1Bq?=
 =?utf-8?B?U0gzK2NtbnIxWjI4UkJMcElFL3ovdHV1MFhnS09wVjA1c0k1Tzl1aUI1T1JX?=
 =?utf-8?B?bzFiZEhrUUpEalNpNDlDVW9xdFdrMmdzUU5HVmJoL3dMKzlIUnd5NWU0clBr?=
 =?utf-8?B?UDZQMmgwdnE1Z2h4T2hwRDJTWllnQlBUYlVuQVQwSVZzWnRQYXp5ZlV6cXpm?=
 =?utf-8?B?d1FOZ3dCZ3JseHBnbmdFS3J0aVozZWwzeHpsVi9XU3c3dUpXTE1NSlZmTjRa?=
 =?utf-8?B?MzZYOXlIaVJRTU1hR3hjbEVEemxMTUtmVGpvUnRPb1FNRDl4OVlxUWEwV3N3?=
 =?utf-8?B?YUFjckFWV2oyeEpyeXhRWHBFK094aUZjbHF3OXJPTCs4KzFlblhTM0RNVlRk?=
 =?utf-8?B?SWNINGhWMU5QblFxdlRtdWtRYW9IMVRIRDE2a1hYeWZrckpMaWhoOWZDNVlP?=
 =?utf-8?B?TkQya1JNNFVSeDd4dkYvSFpzM3FXNys1QW1HeEUxN2w4UkNyaGd4Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0f206f-b572-4784-d596-08de74b6be2f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:15.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMINCZqriCzXGen9nErSN3qGkP7ZfrPVEAJP+a2Y6GGxNBQbVEckHdDMFaWsVCYGepOOiB19K0FVM37qGZ6qHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9111-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 22C8D19DFA3
X-Rspamd-Action: no action

From: Jindong Yue <jindong.yue@nxp.com>

Use tristate for mxs-dma to support module building.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 66cda7cc9f7ab92e198d80cc5f0fb6420b937088..abeb086ba1d6b31206be8b18acb6363d73170339 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -505,7 +505,7 @@ config MV_XOR_V2
 	  platforms.
 
 config MXS_DMA
-	bool "MXS DMA support"
+	tristate "MXS DMA support"
 	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
 	select STMP_DEVICE
 	select DMA_ENGINE

-- 
2.43.0


