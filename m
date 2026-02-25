Return-Path: <dmaengine+bounces-9105-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGo4Fr9sn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9105-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6919DEBA
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0CAD3055426
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891873164D8;
	Wed, 25 Feb 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MnFHwVcW"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055F31197C;
	Wed, 25 Feb 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055719; cv=fail; b=o8v25xS3HSwHA5neBuk1+E0kumQO6boawN4h4INu2Z6yoS2pjQbFMtgPzHL3B0aOCiHbhmTq/kMeayfaN8GWisXC7jwHQ8QgLC6LWOgOs4CzG/KCopufPamyPnWxVhQaWuhnkzZY5clBW5rcOG2v/JKnDLTa3YKT6KVw0jLW0to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055719; c=relaxed/simple;
	bh=zHXZMR2tF2e3Fruc6EuxpvwfhTDZPzT78jGnZmIZnXY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JIUowYYKdeuX8Kwu32rQqB0+POvl/JgIIE7nonWxs3/DCfZyPpQ+CBLuJEOb61ECSZ7Lrz1W/98hYKyxXFpTyY5XQ8JUyEjzupa9T4ER3FP0cschtHMzc9vS3HhmNF5aPllHBqZMq+otdk3NMQ4ZvP0pnlWIWlT+gJuCO2a7C1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MnFHwVcW; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5iuB00WnFcL1UXwBhZfj75Pesk1ZLGiT6+p/wtZ/+IW1ErnV/oY9gspK+6VBMxQGS+d5PH6pbR0utPAfzEg/O8K1e5zmwOvr2wtdO8237sDOQoniqjLqExYTOQOKEEeWawPlRUMj5WMqO+cPaiRTvwBRnw3AaXE72f9+RgsqAq3BjFnY5RD7w52ZfQIZJuQpmH3ErrgVChObfpJBceUsCLnDtv9KvBn+im57z4qCsYibc/IkDQMm5w107Vb8Z0Q6/WY+Qy1YWo6JbowsJcnx0LOTabHDOORdrVOWoVajZNbRfHu8tAZV02zdg2QuR6nCznwI5dMomzL7YxOV6hwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN92TA4b+9EUDqsWEayH6Zvm8nqPJoD7/rA1JdqdOiU=;
 b=F5NdUlbFE0zmGeg/H/ShYNRb0p/GCdr2BobxzKjsrgA6KPL435nfrdTkrbUgEd+FEfUx29RoMVOnzwyCEAkA5y1fuwTyJcULRkamvEqA8PPePdMZVAsstUJ8dUpau/6BBPFPUlZuf0/sUMOyNJWuI9lUdXggo3gP3WkLjN/VUUGpzLWYukHNpuEC6cPTCuUbzB22jG63+0MmAV5FT4yVdNXZCMWwSvc0s5eVuKllS4+PeH/oPlFYd4KokPBpwjTATUBw/3Am0sXUcHV6M/BUzN7HsgrTOcWwqNa4YdDvEDMKaftRaMNtWKJmlLGODeI2AK7ystr8dWcKXQYqgGeARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN92TA4b+9EUDqsWEayH6Zvm8nqPJoD7/rA1JdqdOiU=;
 b=MnFHwVcWOXSpqwpsaKUHDpF0PKNkS6MptAMn3olO/7b7odBOlVrCwznzEDJjHku7LACTPozR4RRUlP4pqEFHaQ0lKW6H4JheRrwyh4dFM7pb7HXAnwy8rUbFLrFHSHJ4KWGmY88XQ+s+7Mmsn4T96gzblJdHArq3QCEchA8pOSCiWFZAJLROjf7QD0TeACXR+NsmkwaicFZ4XGYRRTK8RTW/Vkrk3ZvK/tF2/46LolgF1r1LD2YLFEOdxQMwzSbhljqj3r9rWrq5egOUrkt8ljhwerjE5KdzcdmANT/bXsSvD8ixA5857XT7kZ02inWl7AbAHJBiXP+cGeRwE3p/JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:41:55 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:41:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:37 -0500
Subject: [PATCH v3 01/13] dmaengine: of_dma: Add
 devm_of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-1-8f798b13baa6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=1866;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zHXZMR2tF2e3Fruc6EuxpvwfhTDZPzT78jGnZmIZnXY=;
 b=eTG4AsJmqH6I21HtEh5EA1O9zptKqHeMt9LLtSZDxTBsWbWkMk+xrkdg9Z2viM4buwVBpg2hY
 ReO90hDyaPgBRBqc2K0panS7GVTpaAQNG00ulyklf4w804GfZKRT8ll
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
X-MS-Office365-Filtering-Correlation-Id: 7ef74193-0eea-4191-094b-08de74b6b1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	xuHiqefrRlxRBd20aEGXzgFww19+QRj6H/kgC5MK7jI7cU2Ctw+NBJP4J6UokIr8/3UrBxL7MY7pQaFhJ4/UzI4z3dlwmXwnq9nybRvLMAkTnr5EpCS1Kvp9cti3RuLCAJVvCchq+ELmCcF1vwbPh9qPuOfn33YPxf0HBk4pu2QgUUMyrneOHDr/eZ+zZnaGXSuC22FXprjVU149nceDPZNr6SUMJST1JZ++Ld5xXByaWabjJsmuO+2nEP6eyQrgBn8INU7y8VJVVrTZY3fP4dbSQnUmVgsvRn/6nvNyEEOvql1gpvARM/jP6ptoLyQfA+aoESsTmDAH+SY/f4cdbSiZy06Vp/AWfBv4XQ3SxFAsDvGIcRRxa/6oYP5s43q9MoE4htpD6VF6G8G1dWUk5rHnZMIiWY3TCN9Lbf/Pvf7sa1+a87aijjrM7y2hSIGZZngXMmaaPp8XGLsfsNl+bIVNiuerbNb4l1nnCg42KmibhkZvdQwlqVAylidhrbdbl3Hg8MNqDKjuiwofM88W6gZmcL4wU9D4ez7E5Z6sHvIWJuNgmkCrakte/spcD8WRXRTBoKD+U5lzrEI3ctLc065U7rkrL5LR+Tepfm/CU7/wJPcox1/cuCrJAfiQKEPTNTr+dQd47HiUK4loy93YHmAiF9XRDBr6I+zDsgSH6cdJamawyQp0FRo920PSJIpHi10A/6FO9fOLDsR1I+fqOhF/2RUnpDjxXY91hJFfOfOaj/nDH9Mv4n/Arm55R8P5Z4Ij4dZkbWBUL+ellglbdm9fbG6zcgfCJYl2xh7vOX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE51eEFUQi81dytDbGhNaDdha29JcmJxNWE3cUtHRXFRMHVZTmxodG9mUGo5?=
 =?utf-8?B?STQ2QVg4R2NYbi9XMm94b0tsZnp6a0o1VWRLYlViYjJoTkxGVXhqKzNjUml1?=
 =?utf-8?B?b0FUMnp0R3paUkZRY1FWNG1PcUVjWE05ZCtpL3kyR0tlQUxOQ1ZrNkwyYUV6?=
 =?utf-8?B?cUpZaENENGVuWjk0WWJCZGNxNFZncW1SUUFOMW9PSjJ1ckpRV0hvT290b3pa?=
 =?utf-8?B?SnpQdXFjd3h5cVp2RWhadEYrcHdFdVBidE96Q0xwVGVoYjFaVFVLUUJVeEZy?=
 =?utf-8?B?ZFVSRnNZbWZTUnFEam5jaFhlZDFWVnZvTzIzVi9BdHlVRWRjbk9sdlMrVDlD?=
 =?utf-8?B?dlBtRnRQaUpoZWRlNGtzczkzNDJ6WnI2YUVMai9TMXFaTXNZL3JyOHBmSUFV?=
 =?utf-8?B?UnZtQzllYkJZWDd2dW5SZVoySGdlSUhRYS8yRGx6b1o0aGpPQXFsbGI2OWkw?=
 =?utf-8?B?amZwWnBtaHVhMEdnbDB0cTN4UnJJTGZ3RURjQVJKYXZkSlRXYlhIM0dDd2c3?=
 =?utf-8?B?cjZNVHFJU0hYSE43R3dyRUF2MHpWVldWWnpmaGZrakZ0bE4yc3ZTTjI4RnNL?=
 =?utf-8?B?TC9kbzBJRU0zM3lOTjlSbmtpUDlMeEsxSGkydTJQRkhYK2JmTUhUTzl1ZWN4?=
 =?utf-8?B?cCtrUHZlRkxOUVVPU3g1M0FES2JIckxoZUppejNUQXFZanBhalVuRU5rKzMz?=
 =?utf-8?B?S1hrbnB3ZURFUk9vd0ZPSHF6NjBuMUloSUIzeWhxb0k0ZnNaclpPajBISFEr?=
 =?utf-8?B?cFEwNldVaDFNRmFpdTNvRFhNbTd1WlVVZGowL3k0S2NNaG9oQ0ViR05uVzEz?=
 =?utf-8?B?NEZ1bnhXcEl4NFJVd1poNjJoU2NKQlpzZWZRMHB1WWxOcW5KR1dxY3pjMzhB?=
 =?utf-8?B?VTRTYnRlYWRrOVZ1VjlFTVpvaXZZQTZwSG5yZmYwWWs5bzNCREJ3MWRXNUNh?=
 =?utf-8?B?ci9MbUhsQnRQMUZuTDlzNDE2Q1dsdW1OQ3QvbmlQM212eWJiRDNTM0RtNWlw?=
 =?utf-8?B?ZzhpNlNkQUJPaStWelJZU3YxMjhBdEdVTy8ybEphbDkvYVQzRVdhbU5IaFZM?=
 =?utf-8?B?ZjhzRnlrNVhkbFQySlpDZVh3U1lFaEp3aEE2dWVZOEpYcmVOSUx3VWYxS2ZM?=
 =?utf-8?B?bTl2YVRrMU5PcStBVUF2anVZbDJxSzhnMFhmWEFJYkZIaHo0K2ZOV3hEQm80?=
 =?utf-8?B?eFZSOFNLa1JleU0yQjVTN3Mvcm5pRVdNMzNJbHg3aFJaWnFUd1BNYzFzNG52?=
 =?utf-8?B?WVBGVy9yclZOc21TUG42MDV3cGM4TTdxNWMyVEt6alFEdnhZbEVIVUh3cEkv?=
 =?utf-8?B?R0hERjFjRzVVU1RNczk1Mkd6bHRySzJYU3V3UkRUTXNkS2Y3SkIvejJXK2cy?=
 =?utf-8?B?MTBQbm96WWMvUjAzYmdNUUJHeFQzUHU5ZWJJVS80UTI1cnNYRTdENVdJb0s1?=
 =?utf-8?B?Wng3MnFoV3FicEtNMVdFL2ZZY3ZYMVRKTk1ibGtMZElaNVNZK2xRdWRJZCtr?=
 =?utf-8?B?Q3FUS1F4VmNtYXBVbHVnbE0xdnZxZVl5NnpBL3FGL21nbzA0dU1seUdiaEN4?=
 =?utf-8?B?OUFmRjNOajlneDRBT2Vrc1dXWUNVcnlIN2lqTVpDWVJUb3prQm1xbGhiWGlK?=
 =?utf-8?B?bUc2Vk9oU2ZZd0YzZmZRSVg5WWZYOHpCdzYxdUo4UWM3ODlMajdBdlBLMjNQ?=
 =?utf-8?B?RWZGR2t2b0N3K0p3aTYxeU4yV3ZYNE1RM3VZakRZaGFFSTVJUDdsN3lMVHpq?=
 =?utf-8?B?QVQzSDlzQUdGcU5iUzV4ZXVTTnQ4Um01MzI0VzMvdmx4WVdkOU1acEwxSnVx?=
 =?utf-8?B?S1VNaWsvNVZibDhkQVhSanlUSXVtN2RwZklNRUFZUktPTGpXcUxZMUJTWDkw?=
 =?utf-8?B?d09xOFRqbXlDSTAxZFRrcmtzWXFHRVIyOFNVWVMvMWdBS2lOZlZ4ZjVESWFm?=
 =?utf-8?B?YlFDMHdnYXg2YndqRno0cXR1dTZmdVZ4aFhQU3ZHRnpLUTV2ZnhXdzRuUmFU?=
 =?utf-8?B?R0VNb3JvRnpDaWlTUjkxNUcyS0ZHeHROcXRXMWRxeDdtc2tnRmtHU0NFK2hn?=
 =?utf-8?B?UnppWjMwWUlDY1RFMG51dDRULy9wekF3dmpwc25GblFZSm1BOVhlZDdySWYz?=
 =?utf-8?B?aGhYV2xGYUNOU0dQZVBhOXorbTdFandLa3U3cC9yajB2eXNaUVI5YzMvbW0v?=
 =?utf-8?B?MzRUdkcvUUljWlR0elFUODgwYjU4dkZTQUdCdmxDVG9NZG1pckpQMEZ4aU40?=
 =?utf-8?B?RmVKRUhTekJad3BnazNUSVhZOHRuTXF1dFpGdnRXYXVmeU1kQU9oSlV4UUpO?=
 =?utf-8?B?a25kRU1aeVNqS2JVTDRGUWMvT2VudjVKaFpqTEVGMTNWWU5xQVk5Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef74193-0eea-4191-094b-08de74b6b1f3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:41:55.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM5/9ROhbOW9tEo2D09yguN8yleLpIRYlcQbjhvjUXWfDObEhp3lL+5ZO0413FRz66lBhrHGZ0j2RJ1qegHLiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9105-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: E7A6919DEBA
X-Rspamd-Action: no action

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
2.43.0


