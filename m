Return-Path: <dmaengine+bounces-11915-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9LIRM4/dRGpa2QoAu9opvQ
	(envelope-from <dmaengine+bounces-11915-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:27:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242D66EB986
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:27:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=rzJtlbzk;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11915-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11915-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CD53060550
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F73EFD04;
	Wed,  1 Jul 2026 09:26:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587F32470A;
	Wed,  1 Jul 2026 09:26:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897982; cv=fail; b=eV+rVXcuYb7h+0baoyV4Q+nUEBbPmkWCnlWascD3LijJTn+JGemG2txEsT+WjFeERjuX66Nz7DCsf1LjFRQTOCJE2WCbNwepGF0sdSOmRnFCTG0bxEcIWtqrxw6LUxSsinqkL845OsZF1N+SAClminL04ixFzSrCCSuwf6f1OcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897982; c=relaxed/simple;
	bh=UMnEQh5dC3x6m5r3Tuy+SizAxnUT/serh/958M7Xq7g=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bEcgJTEL0Hoem6oEDiNarGA+iUec4QSXB3tY5V1Lql/1DphdV1d+TiNQgjCpt7hxIDjzwftHIa6+r6m218EKd90jb4mY9R7jTZxtgZ4f3h5jocsBKx/mlU3zb2zTJEbDd9GOz5FEwkZ7+jmp5vXvBbeuK+Ojw0/6ngZ1E5iMnnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rzJtlbzk; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3QNl+2v8GYqmt5yO+2YWbzy2TQhv4NzihVIAspAwaucuZIpLMPkaqHKLpbRjNuUFd1XwNVaHkXDJt8AvkGThZeZW50thJlqE86lJsKUwbEy2Q+gCcNQzV9Rh/oNMtm1atkuPG71wVbgb9FHCY2uZjXGzt5zY1QuhUYAdcdYuxxqgTw+n7nJemFh5b3N3dzFx9JZzLPDtMo96SyTsvRrxYtCPaWwuqlezNxDiQhg5Bfq3I+PHMQwASEnqEXMtswUjWvwpe50nzYoNY6+KV11kFSe6uM4bn6L4SQ0UCGA6DcABKKa0rmNc9IP83zYux4fg47KACcZ3pwbTXY7xPfh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JXr1KYRkKdfpDk6XCg3b5SSGEhBJ+8mGpfUam6DQ2c=;
 b=VKqzkmais9WWTshP43T6NPlvwWvYXRp4qq7h/mROAQUICGmsouXvMcVqdGjtkwD5UV71Iout8thpMoFVSGdVAThdto2mOPvoRX9h46prOVPcWTbtY0oftBEpBmcNgwmV3npAMbWzlKXWZcZFgIlK4LXh5pPTYXHiO8H4uIoUl6oKnghQs8YAgzIr1jAqRcHJSj0roG3xVYPlmJNeNwevGv3Z34TVR4Oqzj69WymBujMEBjDCbVGMsFwn56oIhYrf/5j5TzVpXn4NI0k6tE7UxsX3ZukZ0d/EpToj9oNWsoL3j//LYY4NYSU9Hg4QH5UPJ53OK1KsYw55XJLrwoR+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JXr1KYRkKdfpDk6XCg3b5SSGEhBJ+8mGpfUam6DQ2c=;
 b=rzJtlbzkPqbJOh3glP77u8qZQpZbtDQ8qeYT9HjkZZlVpmZkJmUaI55bJq8XKnEkjJS47ZIaP9JVsrbYz08GVB+vgUrGRXomUJipfq/lZqa+MU3BRpj7RZfdcz46u74kK8m9No5F66++Dklyk2T9tWOl1UeMxI7xn8XdNUVjOSVyZm4pELhYdUCONLBbkqwCJSFviZ85sTDOM6d3bnU0DETYSosa94YFHh/6P/ERN5zPvitvDrScoHAeg2MHkijKOSqVhhOKrGTSBzIlCu/5i1WuL4oYQD+JLnk/bWU82L2SsLNP6Rpv++qGdNtXByRlqJfJrDm8R6BW6heLY5LNgQ==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:17 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:26:17 +0000
From: joy.zou@oss.nxp.com
Subject: [PATCH v6 0/5] add runtime suspend/resume support
Date: Wed, 01 Jul 2026 17:29:22 +0800
Message-Id: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPLdRGoC/yXMQQqDMBBG4avIrB3QIBF7leLCJH/rCEZJYimId
 zfq8lu8t1NEEER6FTsF/CTK4jN0WZAdB/8Fi8smVSld6bpl0zDcPHDYfJIZvKyJlakbp3RnLEC
 5XAM+8r+v7/5x3MwEm64VHccJOx1RWncAAAA=
X-Change-ID: 20260617-b4-edma-runtime-opt-2b14d269bcee
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Joy Zou <joy.zou@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4b485b-4264-4f65-4039-08ded752cd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7O9/YG2FBNGL82PBpsp1FiWDBSx6Ia+l40TSVhkpm3cz8Dc42e3EeFNqABV9mkM/ieavkw++y4PJF6QbxqFf/YYDC8RVBs8MDpPYW+c1rtRjr+g2cNk2TIroamfeLvd4/BHm32I7bQ5jEghPZprpuL1RNf3fcQn199uKmdylnCu4TkMt871rsMbkIATvoKiJKjapsyQz2YbUxsyQ0BUJpxqpyFIvcPBgjA5/vE8gCS97HANIcq3kEeKojKGUlXjLE0Be1OTj++V5+UapRVsj+M1r4qYnUA0wQvG0E5RIHuN2JLERZ+gOpdZypEEkI2iHAHTuAK2uOLfGj++OQttEcMW/ZGq1TH7XbPAbwNV6e8Na92vq6GQjZa+mStYIV6Ptv1fnKxBMBzC96ke3VEAH2/qMyBONqih+1RbzS69EX1CbdmvEPTKs8oxnUYhKtemRz5KUmMpeEcgGi0Nb3tFLz5wRMH/feqbnfu6/EBEXpXlZ1wZwSe4o0EBgUgFUn1eSYUB9AsOyLGzSMvHNzb6LQ7g6TAZxMtyYnNzmJbK/zZH7f2rQqvBSbskdzZGeWODqStJeB6V6ShmQZGe8vliccQDAhIWw0iLPWAHh27AJyE70SUhvQnTGwj1CnB2V1O8v9TQOeRiPwbD5ujcRz9+fNWWpx3YsIlsZ+b5Fj7Z19f4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGRKeUN5TC9BN3AvdzZLMjc2SVFvcitUR24wUk5RZ250d3d0N0VoZ1BqRUdk?=
 =?utf-8?B?TGZWNW50dnJKRnZVS3hPSHBCRWtGY1pDSWtnZVZWV3pPYjJWMjhxYlBueVlk?=
 =?utf-8?B?MmpVVTFDdklvc085QmpLT0RmN3JBTWJEZnNaaEg4aEZ2Nm9qTVhSUE9SN0V6?=
 =?utf-8?B?blFuUzdKUVQrZDVCOTdMQXdtWHIzWUNlSlNNM2QvTmJ1VmgxU2hObzNvT1JN?=
 =?utf-8?B?azkrS3VRUEV4YnU2dUFBSUx1Z2JlajYzSFRHaGtPNmV1ZmliTExlTi9iV1FQ?=
 =?utf-8?B?VHJkZUM3bjBmcEVnR0JGZW9IY3U4VVNxY2ZaVjdkd1VqSmIxeTJHbGRPM0Fw?=
 =?utf-8?B?bzI4aGxpakZNcGt5ZFpVVjBWYUdLMXlTS0xRWEt5WkNoUXA1RDBRWnpSZG5l?=
 =?utf-8?B?ZTdGK0ZWaU5MS1g4N2FrVHJyRXp2UVptQ0JDNEhVdjB0aytvME1la2VFV0Jz?=
 =?utf-8?B?aGVKVkZqK3VzM3IzQzd3TWUxZlJGMG5IQms4dEhUMjd5NnF1aXFvUitaM2dk?=
 =?utf-8?B?WTFMZDBvUkhaeFNOdGkwY25aSVBCNUdrWmJBS0pDSElIbXZPV0pqcHk2VSt2?=
 =?utf-8?B?Tnh0SUFyZ3B0WmxyS3RBRFdTOFFLelBIQ1RRQ1hEdVFxUEVHdTN0ckNFNE0w?=
 =?utf-8?B?SmhmQk0rNm9QVW01d0tnRlFzdHZHK1RzU004Z3pLTWM4N25HUWFjN1d4ZDR2?=
 =?utf-8?B?NEpRNm9EWnppVlRkMVdyamROdTVDRnAvV3VMMnJiR0M3SWxDWU5MQXEzN1Rj?=
 =?utf-8?B?ZGpDeU45dlVRL0RuTGNCM3lMU1lsb0lUNEFZT2o1U1U4RTFpaHhuMGhmTGZS?=
 =?utf-8?B?V3FUeHhGVmRjV0d4ditWWFBOUnRrUFFVejZwL0pGQUVNcTRSd0lIWHhwNnJP?=
 =?utf-8?B?YXEwVnRFOGErL2p5eVNBZXltY2JpcEtYVlpnNGR4NFNjQnRpMUJjd0ZkbWRa?=
 =?utf-8?B?S0t5c1FRTitMcENvK1A1aDVFNmpLU3JZN2xMTTVjZGc2NHlhMzM3TjdReGFR?=
 =?utf-8?B?WEJCVUNyR09KdkxqVDVmTk9lYXpmUnh3TjdxNUVXdFpxTkJBQnN1ZjdoRHdm?=
 =?utf-8?B?YUt4bWd1My9jMGs2dWQzQVRRZTV0WW5CdmVaaCtycUFuY2VVVUM0YmtVYXNF?=
 =?utf-8?B?eURKWmZQRndEMEwwR0VTQm55M0FHd1NjdkJIZG4xaVdLNGZ0S1dadmVWK1Mv?=
 =?utf-8?B?VkhCcFlaWHZoOUoxeE4ybzNTcytyU0x3WDcrSnJsR2wyY0t0cGhaZmJ5ZjJL?=
 =?utf-8?B?UnpKa05UTWFqbkFObzZHY0JITHBYYnJHQk1rSzdhWnJNL2ZlUVloQWFrSkMv?=
 =?utf-8?B?cTdJaDIwUHQrdUhiV2h5RjdKUDZMZ3Z1Ym9HdTR0aVNETkNOTUdBVzVnWXVu?=
 =?utf-8?B?MlUrRXd3c1BmV2VOVDJNeFFpWEowTUlXb25JZm5BcHVpS3JvQzJIUkRFOFdL?=
 =?utf-8?B?Njd0TytDTkEvUGhtQ2djcDNpS05EQ2dsU2wyaHFVaE9CYWtiZm5tTFFnUlZh?=
 =?utf-8?B?ajFySUpWR0RaUzZjRjMvd1h6SVQrbXFpdzF6blU0VUVGSjUwemV2VkJmWjFF?=
 =?utf-8?B?eXlXK2hJWWQ3OHVRSiszdmpnMTVJOE1EenlpNFZNNkhCMml4WDE3aWFGOGlM?=
 =?utf-8?B?alZSNi8vWGJld1BSNml2VFdqK3RJdGNwV3Mva2lxbTR0UU8rbERiMGhjV0M0?=
 =?utf-8?B?UjRZWUdTdk5QaVYxMWJrZ1hGZnAwT3RUKzFuTjArUnRGTzdMYXhFSmJwODZ4?=
 =?utf-8?B?cURwbUJmVExUWVdWYU90bEtyd01udTlXcG9PRUVBTi8rcEZYZXlYcEVyaXl2?=
 =?utf-8?B?bFNtNzNXU3prNkFWMTd2MXo2dW5LV2FoK1ZkeGN4VjFwcmxoR1VPeGxLTEVs?=
 =?utf-8?B?dTNUMnZrdnJVYlExR2lTMGd6RzRvMDV3Ukdmc1VlcndNcGdBeFRGTmxoNjZw?=
 =?utf-8?B?UHk3MC84b2NiRmFUVWx4VGJYenhKcmhoeFdod0xXU3VrNk9LT09WWU01Q3pQ?=
 =?utf-8?B?OTM0OGpqWXlpTWt5RzhnQ29ZbDRjeXpYd0JoRGNVa0tHMzZvVUdxZm01SU9x?=
 =?utf-8?B?aloyYjFlODJYeW9aRXhGcHN0R2RWM0g2cVNnTzJIdjhFOHBsUXh0alZ6MGN4?=
 =?utf-8?B?RHdUbk1ZQzlxd2p0OEJaM3g4aVY5OElEb1BibjdWdjNEdWZJMDdodmF4VlMv?=
 =?utf-8?B?KzlOcUJOR2F0em5hbEtXQldpUWZkQldnNDNqWG5xaGkzWXAya1g5TmhGZzBz?=
 =?utf-8?B?cXRZd0swRWhsU3haSlA2bkRhay84TXNEMlp4TGovOXNOMVgveSttcGs0eDJt?=
 =?utf-8?B?cU1GaW1CS0tIejVnVTAvSVdQeDRCTDlmV3FWQzdTcE53ZWFZekttS2lDeTVE?=
 =?utf-8?Q?Vh60NaHz3l0oTPz9Y4lALUkTm6YIpdOOFBVXx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4b485b-4264-4f65-4039-08ded752cd7c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:17.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LA4ApEq+uBr1/10B7BhDts7sMqgCmrQJgRM9C/VtFldPq0AKc+yReSipyAI5CN5jq3uTAhxQsmPeTi0v4Fvp8I7fpYHyV4+XorFY6/Q1AhSjxCK+r7j4jT8UKFiy0IVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11915-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:joe@pf.is.s.u-tokyo.ac.jp,m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joy.zou@nxp.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,u-tokyo.ac.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 242D66EB986

Clean up driver FLAGs and introduce runtime suspend and resume support for
FSL eDMA.

Signed-off-by: Joy Zou <joy.zou@oss.nxp.com>
---
Changes in V6:
- add synchronize_irq() before disabling the channel clock in fsl_edma_chan_runtime_suspend()
  per AI review comments.
- add pm_runtime_get_if_active() in interrupt handlers to ensure registers can be accessed
  correctly per AI review comments.
- remove manual fsl_edma3_detach_pd() call when device_link_add() fails. The devres
  framework will handle cleanup automatically on probe failure per AI review comments.
- clear fsl_chan->pd_dev_link after freeing the device link to prevent potential 
  use-after-free issues per AI review comments..
- move fsl_edma->drvdata->setup_irq() atfer edma engine pm_runtime_resume_and_get().
- replace devm_clk_bulk_get_optional_enable() with devm_clk_get_optional()
  and clk_bulk_prepare_enable() in order to use runtime PM for power
  management later.
- replace devm_clk_get_optional_enable() with devm_clk_get_optional()
  and devm_clk_prepare_enable() in order to use runtime PM for power
  management later for patch #1 and #2.
- add new patch #5 fix use-after-free issue per AI review comments.
- modify the commit message for patch #1,#2 and #3.
- add Reviewed-by tag for patch #1,#2 and #3.
- Link to v5: https://lore.kernel.org/r/20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com

Changes in V5:
- add three new patches, two of which replace devm_clk_get_enabled() with devm_clk_get_optional_enabled(),
  and the other convert to clk bulk API.
- remove unnecessary flags FSL_EDMA_DRV_HAS_CHCLK and FSL_EDMA_DRV_HAS_DMACLK.
- remove redundant clk_disable_unprepare() due to the pm_runtime_put_sync_suspend() added.
- use devm_pm_runtime_enable() to replace pm_runtime_enable() and add return value check.
- add return value check for pm_runtime_get_sync().
- replace pm_runtime_get_sync() with pm_runtime_resume_and_get().
- replace DMAMUX clock handling with bulk clock API for edma engine runtime suspend/resume.
- remove dev_pm_domain_detach() when device_link_add() fail because the fsl_edma3_detach_pd()
  also call dev_pm_domain_detach().
- remove device_link_add() DL_FLAG_RPM_ACTIVE flag and pm_runtime_put_sync_suspend().
- add clk_bulk_disable_unprepare() for clk_prepare_enable() fail in fsl_edma_runtime_resume().
- remove the extra space before RUNTIME_PM_OPS.
- add skip channel comments for system suspend.
- add clk_disable_unprepare() for dmaclk at the end of probe function.
- add clk_bulk_disable_unprepare() for muxclk at the end of probe function.
- Link to v4: https://lore.kernel.org/imx/20251017-b4-edma-runtime-v4-1-87c64dd30229@nxp.com/

Changes for V4:
- fix a typo dmaegnine/dmaengine in the subject.
- Link to v3: https://lore.kernel.org/imx/20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com/

Changes for V3:
- rebased onto commit 8f21d9da4670 ("Add linux-next specific files for 20250911")
  to align with latest changes.
- Remove pm_runtime_dont_use_autosuspend() from fsl_edma3_detach_pd().
  because the autosuspend is not used.
- Move some edma channel registers initialization after the chan_dev
  pm_runtime_enable().
- Add clk_prepare_enable() return check in fsl_edma_runtime_resume.
- Add flag FSL_EDMA_DRV_HAS_DMACLK check in fsl_edma_runtime_resume/suspend().
- Link to v2: https://lore.kernel.org/imx/20241226052643.1951886-1-joy.zou@nxp.com/

Changes for V2:
- drop ret from fsl_edma_chan_runtime_suspend().
- drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
- add review tag
- Link to v1: https://lore.kernel.org/imx/20241220021109.2102294-1-joy.zou@nxp.com/

To: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Frank Li <Frank.Li@kernel.org>
Cc: imx@lists.linux.dev
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Joy Zou (5):
      dmaengine: fsl-edma: use devm_clk_get_optional() for channel clock
      dmaengine: fsl-edma: use devm_clk_get_optional() for DMA engine clock
      dmaengine: fsl-edma: convert DMAMUX clock handling to bulk clock API
      dmaengine: fsl-edma: add runtime suspend/resume support
      dmaengine: fsl-edma: fix use-after-free after dev_pm_domain_detach()

 drivers/dma/fsl-edma-common.c |  14 +-
 drivers/dma/fsl-edma-common.h |   4 +-
 drivers/dma/fsl-edma-main.c   | 305 +++++++++++++++++++++++++++++++-----------
 3 files changed, 234 insertions(+), 89 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260617-b4-edma-runtime-opt-2b14d269bcee

Best regards,
--  
Joy Zou <joy.zou@oss.nxp.com>


