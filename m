Return-Path: <dmaengine+bounces-10413-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKxTGVVfBGqiHQIAu9opvQ
	(envelope-from <dmaengine+bounces-10413-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:24:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB5532268
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE1C830D80F4
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FEC3FB7F6;
	Wed, 13 May 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h3Qf2ACU"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB434751B;
	Wed, 13 May 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671349; cv=fail; b=mY8pyT3QMnD/A+RcTaUZdCpQDFJna1WTSl6hDeG4i1/B2moAwdROUNi2l1iLrb2jYF7EV5/XmTYjcKcPI/bZwfj6IYKvEpQQlpQykoYFw3a8MVXuVJSHBZjX+Hn8EXrWhr3eUrW+x18u/uwfmMvXF3UYdFDG3b5V0DYDW+OO+xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671349; c=relaxed/simple;
	bh=xHiZeQh6FGH7NMkgCHnkYPMyunhLvuMGgo67foy2UEA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r7P2xnUmaS0eIXlOuUuzBHiAD3rqy2OvwakYCxWl22NCDPLccVOOhFhCzjqsWafknRQJjFtHd6o0Jg4I+5nBVuc5Iwp96t0iSBETI2LTnFBPCJiYdwPmlUjm7zvycP3mJAVC06MwBrSVkY2JFeNVFKDEDkyARlbGearv51Ir9dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h3Qf2ACU; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IATmExSrr8TJs74TzCWayugOj+TqbnHiPhF78hMrR2hJU5JvhvuPU8LegkM1Wkjo4g+BgHsRSDMoYUz6n6KQOA9Kk0Rsrif0VhN5B/rLJ+RUanbnXXo20MwlnJqPPxx/D/jRYY4m+dj+xzGmsMRXYv/9IyaCZBSkpCjcFQLtHXZTh6n6PQv/eVallRQgyK30G85YOI4ijVdu5xpsUj9nm5jvKEUI9Jm/Wnllx8P2XVCKirRtY+Ejvrvr8Sw8UGJD2pk2LJFJuMJl55Cx+Lq24RsdMLj6lQQgdZvY12UARgJjM5vkfmzc4JH5JOmPrMwFKBCPBAY/vLt9xPwNNhblig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcjipqru+xx5o17jgHY19qH21EJlaS1N0ZeSQjU/kKc=;
 b=qKQrCPta3C7aAi4/LSztUYmaIuf9ZXJCMsbHuNBmpMS4g3cgbRXK7aHafYIvM3H2F1lhXHv5zoAvhFzSo7/PjOA8fh7OW8wiktc1x2c5klhUe59Jkccc42bqFlJmY2I6+jBQ/XF/uCdvEzzY5mAFvSOYysZzt0C1VniM7LsfFFtrKFneiIGuwxDoSp0Lzr9oBheHvAhGSLkJZ+VHxEVIP/xEKLW++O1itnqFa0NP0tzPlRFNv4inyuiv6CY33RJr9G2fqG0QuI5eX5g0IJesC5+QrxxOgghXmZ5HKl5RmIRsFG8K4SyPJKJ/SJXIMH46NrsCKL65thwto3P0/3AdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcjipqru+xx5o17jgHY19qH21EJlaS1N0ZeSQjU/kKc=;
 b=h3Qf2ACUWJZ7oc/M/GpZJpfEFlw2P4Ym7rAkvNGsW/yWncpCZSDKRrcmKqERucDti8L2cQDMDrfHtWU9cDgb1YzwSabHfIMOA6M8nduhE7XnVP30+oR+5H1iMC4kyWnhz/mNgkh0Cem03Xbtou0ccbNLAk6ZavMbvJQLOiHAbQCvwqiv5rmm/xGBL5PlMDbiFckSGckLvh9N0qkZFQeYUSbxhVitGiycJpESiSbg/8NRDxHC1mjcmBe0T7sKrT+6Ff7yBfTKaQwX0huOSKdu4OzAZLu/Vq/mjwYd4OMGYolSrQgVTjRg6+hyvrgkuL6+6cvGYVfKrMcjFqKm9zCtPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:22:12 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 11:22:12 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Wed, 13 May 2026 19:23:50 +0800
Subject: [PATCH v5 4/4] dmaengine: fsl-edma: add runtime suspend/resume
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-b4-b4-edma-runtime-opt-v5-4-1e595bfb8423@nxp.com>
References: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5765:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1154deeb-357b-45ac-fae9-08deb0e1e141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1Ao7GzeGw5EdkGUDNIBE/uCxK2fYeH4UdFThslA6fMkxNc3uMy6Moc11guywFg1pZL9JBRTQOwto+M3EDn6joHyTITl3KYSYvd888qLlqS19f9TcVp/dljLIPFlqvC3gIStawcuHwT70Ej2GyzulwF8+gIX2p/trpdmBGUFiA2wmKYBLdDsI/s/AMPgVYY2faOR/5d+2i0Q14Jj+69RzxRAIN9tjNUZqM4xt5l2p4ZEN8aJGJX4WN+osWlavB3n/VA9WR/5CH/NZ97rsgDCjY7VXZGSNpCEXX1iJA0uSGA/DyeBQ0PnF0W8Vd71rfNDSlY8LZ+Mis2GrwhSZ+WRTB3nTgKS6gtQ7TwigcZDxZuzf9w6WHwlj6ur8DmEk4gUvkUU9nFFWiLG8z2yCIBUaLcKtw6hoiqgpTJGnfkSwPUoGds/YasKQzumpvVfTA8/7+jwu9KAPpGGfRtaUavREUxAroSa9+kkN1evoCgym8cZPfSpUyYKcF1LaiVNl/02EX7orHKu2SnNI8LwtPUIP4cXTfzitwUj2ZJQuRew8rBCKLmcevn3v6tMKpanpfhL/eZ13rtWSuVOJd05uFWWhd49XVp21jCrgsdrOQINu0DORtrAp9PONpRNkkCW+q5kGXfMZwWkz5U0DxHZ70njlNVSmatIoc5UOCnYW4NNaYhR4xuRi6JyEH3YwVfrI6bKGZxFRhF6gI0LJJsu0qVuWQ8XXkzVKRSjD+0FjPR/RBhowwsOOrqXlJ0FSchmarVl4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3czc1FqaDRySHNJV25tSThXMTJLSlZIR01NVnllZUNxOVQxVEpBSWliY2Vn?=
 =?utf-8?B?bW4xMk13ajVuU3F2QzNDLzZySUdzUWtBU0VVVHRCMTNnRUVlSXMwOGljUUR4?=
 =?utf-8?B?NE83R2dqNEdzUlF3enAzRkdHZEV1R0U0c3hvaVkwSkRPWmNjTFRLRkViWDgw?=
 =?utf-8?B?Q3RqbVIyMGlSRmIzdU9NcTJSd2NtRDVxUGcyS21SbUVxei8zMm9GOWVzeVg5?=
 =?utf-8?B?RGxlemtBaTR4ODdqZGU0NWd1VkRZMC8vdTVDSzk2bFk4Sm5aZlBud3lFaERl?=
 =?utf-8?B?bVpydkhrRk94RnRzazZWS2tYb3o1WTZTdHlod293eUczb3RqT2gxRXpRWEQ1?=
 =?utf-8?B?aDRXWHo1SGRMOERBSStmNnRmbGhXby8xOWd0VmttVFdVRlBKdWZteVR3a1pY?=
 =?utf-8?B?ZGo3VUdCUlNFN25FTmNUbGZtc2R1Sjd3NzVKR25yQ1RBSDBYaTR1QU1BQVR1?=
 =?utf-8?B?Rm93RXpRWEdFS2c2cUVqaUpySEN4K3BDV1p4UGNqL29EcjcrOFFPcEFvUytj?=
 =?utf-8?B?NXBBbjFkaXdHcFAzVi8xOHhoWVp3UXl3Zm9QNm8ybEVBaTYzZHRTRlc3aSt0?=
 =?utf-8?B?aTFmc2xSNUtSMDFvdjZadU1jR093UDFSYU95ZVBSS0I5LzJiQWZMQi9vcEFr?=
 =?utf-8?B?dDVpdGR3dGxYSVMxQkltZWxFWG12UzBCRlgxVlR3Z1FsWGNUd0VFdmN0ZE12?=
 =?utf-8?B?QW42SmFYNndVQTVmekx3MFFOb3ZSSUpZN0NkcnBZR01LQmt3NTNQUmgwYTJq?=
 =?utf-8?B?V2V3WWxqNzFEZXBVbFZZaWJyb1hmTFB2L0hGMlk3c2xDdGZIMDgvcC9Wcm9y?=
 =?utf-8?B?YmxQL3NNUkdsSXN5eSthVG1hNk1HeDZlZzgzZ1RWdVh3eHdob0dvMFVhOEpR?=
 =?utf-8?B?MFZIYmJGR2tCNG4wTmhsR1BZVXFyZnFmMEw5ZlUrUUlTNGlvQWtoSllxc2du?=
 =?utf-8?B?NGhqckZGYmEydVBXLzYyN0ZjQTZRYysyQkI2SDRsbXJGOHlwKyt0L1pLQUlD?=
 =?utf-8?B?TTRtblpHL3NGNkNHRnhQR3dNSEJPK2FBSXJvSllkSjMxQnRLenNENGh6VURo?=
 =?utf-8?B?SW9JOGQzYTh0K054UDFhaHJ2UWYva1pQUkQ0VlJPcTF0SkM5VStTczAyaHM1?=
 =?utf-8?B?cWdvV2ZNTVF6dE9pUXlaM1pnbzJtU2JPZEplWTIyR3BRK25KaGk1NHJRV1Vr?=
 =?utf-8?B?YWdwZjgwamJYY3NZMms2MkFlcjNOZncyVlhBdHZieUM4VXNaaDdhcjZlVEU4?=
 =?utf-8?B?MGlzcGthR3UybzNZOW9GMXdxR2RHZjBNOXBPSlJZTzcxclk3MXF4WkJtRno3?=
 =?utf-8?B?MVh5T0ZaNlFDNmhGZG1JK3dtaHppSVBiT2xUeUQyTjhxeWJDUEJaWVBIQWtM?=
 =?utf-8?B?MlBzeDRlU0N4SU1aazgxUUdHQzVjd09mby8xdGE3aEhKbFhjQmdhajVzNFZM?=
 =?utf-8?B?aVB5UktVZHVsOHFSQnFnTFBmb1REYXVZYU1SZEVEZGR4RnUrMGw4QzQzUGdr?=
 =?utf-8?B?UXhjWllkclQxNEdhY1lNVVFDM3dzcVVhWXJlREdiVmpXSzBZYnYweU1CQ1ZV?=
 =?utf-8?B?SmV2b2xBRWNvbFo0Skt2QzRuWXh0MGJ0UHkvTDllTFoyYUlRdUxDZnRydmRL?=
 =?utf-8?B?RktQM3VmbW1EMU4rK1RzelFVUzk4WTVYMU45NHRnNUIzOFVqNi9HUkJ5bEdI?=
 =?utf-8?B?eUFRRk9yUDIyb1NVOXJaQ1hvc1Bzd0tLQlp4OVUxbjArNWYrL1AvOTcvd1dQ?=
 =?utf-8?B?cTc2ZGZUWndCOTNUN1hOZ3JWTXdWYzh6U3ZaZm9SSHZ3MzVuNmRXZWtDelQ4?=
 =?utf-8?B?bXM0NkNNVEVQR3ZaSERKeEQvdVNSemtqa2RnZVF4cUdVWFF1SERoMlllaUx2?=
 =?utf-8?B?akxhdTUvNUxyTjNnWmtqaXBNYkFOMkZ3Uk0vd3QwQ29KS0RCend3cEluOHQ3?=
 =?utf-8?B?NW8vOEswLzBwS1lJa2R6U0RxSzIrR0NoTW1oZWg0WG9aRlV4TnhQbHI2WHNi?=
 =?utf-8?B?a0ppTTY3MWFhd0xxR1lYRTA4ZHg4YklBcGUyZjRvYURBLzdyTVhoNmcySy9L?=
 =?utf-8?B?RjJiTGpTT2V4S3FTRkdnWDNpN2FoZDZTQTJqbFZQU3FYT0ROMjlFZmUxNVRH?=
 =?utf-8?B?UE5GbktIZFE4bit2cGQ2MFdKTkp0NEt6RUZYZEdGZC8vL01yRGFxTzMzQWU4?=
 =?utf-8?B?aWNabXh6UlN3bUFEQTVTZWlPQ2NiRXpxdkRUOUxMbEg0QTNsRVFqU0hmMWcr?=
 =?utf-8?B?L1ZvMWd0bTdpT0syK3VZRkZVN1o3ODZhcWZLOXljN3J0SnM5MitXZXAvZFA2?=
 =?utf-8?Q?34l+6YozUo8hVf7dG4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1154deeb-357b-45ac-fae9-08deb0e1e141
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:22:12.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHcyBm9yHJdz89KrD2cT07/y5bdKFkXZt/ioXPZgFJov4XsdBsAkX0goS0+ZcuY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
X-Rspamd-Queue-Id: EFBB5532268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10413-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@nxp.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

Implement runtime suspend and resume functions for the eDMA engine and
individual channels.

Link per-channel power domain device to eDMA per-channel device instead of
eDMA engine device. So Power Manage framework manage power state of linked
domain device when per-channel device request runtime resume/suspend.

Trigger the eDMA engine's runtime suspend when all channels are suspended,
disabling all common clocks through the runtime PM framework.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in V5:
- remove unnecessary flags FSL_EDMA_DRV_HAS_CHCLK and FSL_EDMA_DRV_HAS_DMACLK.
- remove redundant clk_disable_unprepare() due to the pm_runtime_put_sync_suspend() added.
- use devm_pm_runtime_enable() to replace pm_runtime_enable() and add return value check.
- add return value check for pm_runtime_get_sync();
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
---
 drivers/dma/fsl-edma-common.c |  14 +++--
 drivers/dma/fsl-edma-main.c   | 141 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 129 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index e1ca25ff228dbe392bb800f6ecac5a85ca326bf1..132b900ee6071206b9e2c8f67fdf60ceb8dccb8f 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -247,9 +247,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 
@@ -844,7 +841,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret = 0;
 
-	clk_prepare_enable(fsl_chan->clk);
+	ret = pm_runtime_resume_and_get(&fsl_chan->vchan.chan.dev->device);
+	if (ret < 0) {
+		dev_err(&fsl_chan->vchan.chan.dev->device, "Failed to resume device: %d\n", ret);
+		return ret;
+	}
+
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
@@ -871,7 +873,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
-	clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 
 	return ret;
 }
@@ -903,7 +905,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index c12126ea6552d51b773bdd61c018570dbd618602..9446a0c3bc576c23b0d0277604b41e36dfba0e14 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -629,7 +629,6 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 			device_link_del(fsl_chan->pd_dev_link);
 		if (fsl_chan->pd_dev) {
 			dev_pm_domain_detach(fsl_chan->pd_dev, false);
-			pm_runtime_dont_use_autosuspend(fsl_chan->pd_dev);
 			pm_runtime_set_suspended(fsl_chan->pd_dev);
 		}
 	}
@@ -660,23 +659,8 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 			dev_err(dev, "Failed attach pd %d\n", i);
 			goto detach;
 		}
-
-		fsl_chan->pd_dev_link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_RPM_ACTIVE);
-		if (!fsl_chan->pd_dev_link) {
-			dev_err(dev, "Failed to add device_link to %d\n", i);
-			dev_pm_domain_detach(pd_chan, false);
-			goto detach;
-		}
-
 		fsl_chan->pd_dev = pd_chan;
-
-		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
-		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
-		pm_runtime_set_active(fsl_chan->pd_dev);
 	}
-
 	return 0;
 
 detach:
@@ -684,6 +668,29 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+/* Per channel dma power domain */
+static int fsl_edma_chan_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_chan->clk);
+
+	return 0;
+}
+
+static int fsl_edma_chan_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(fsl_chan->clk);
+}
+
+static struct dev_pm_domain fsl_edma_chan_pm_domain = {
+	.ops = {
+	       RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
+	}
+};
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -809,10 +816,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			return PTR_ERR(fsl_chan->clk);
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-
-		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
-		fsl_edma_chan_mux(fsl_chan, 0, false);
-		clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
@@ -869,6 +872,51 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Can't register Freescale eDMA engine.\n");
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't enable eDMA engine PM runtime!");
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		struct device *chan_dev;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		chan_dev = &fsl_chan->vchan.chan.dev->device;
+		dev_set_drvdata(chan_dev, fsl_chan);
+		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
+
+		if (fsl_chan->pd_dev) {
+			fsl_chan->pd_dev_link = device_link_add(chan_dev, fsl_chan->pd_dev,
+								DL_FLAG_STATELESS |
+								DL_FLAG_PM_RUNTIME);
+			if (!fsl_chan->pd_dev_link) {
+				fsl_edma3_detach_pd(fsl_edma);
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "Failed to add device_link to %d\n", i);
+			}
+		}
+		ret = devm_pm_runtime_enable(chan_dev);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Can't enable eDMA channel PM runtime!");
+
+		if (fsl_chan->pd_dev) {
+			ret = pm_runtime_resume_and_get(fsl_chan->pd_dev);
+			if (ret)
+				return dev_err_probe(&pdev->dev, ret,
+						     "Failed to power on eDMA channel %d\n",
+						     fsl_chan->vchan.chan.chan_id);
+		}
+
+		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
+		fsl_edma_chan_mux(fsl_chan, 0, false);
+		clk_disable_unprepare(fsl_chan->clk);
+		if (fsl_chan->pd_dev)
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+	}
+
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
@@ -880,6 +928,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
 		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
+	clk_disable_unprepare(fsl_edma->dmaclk);
+	clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+
 	return 0;
 }
 
@@ -902,6 +953,19 @@ static int fsl_edma_suspend_late(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		/*
+		 * Skip channel if:
+		 * 1. Runtime PM already suspended.
+		 * 2. Channel without power domain, and the channel source ID is zero,
+		 * so the channel isn't assigned.
+		 */
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
@@ -928,6 +992,13 @@ static int fsl_edma_resume_early(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->srcid != 0)
@@ -940,6 +1011,35 @@ static int fsl_edma_resume_early(struct device *dev)
 	return 0;
 }
 
+/* edma engine runtime system/resume */
+static int fsl_edma_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+
+	clk_disable_unprepare(fsl_edma->dmaclk);
+
+	return 0;
+}
+
+static int fsl_edma_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(fsl_edma->dmaclk);
+	if (ret) {
+		clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+		return ret;
+	}
+	return 0;
+}
+
 /*
  * eDMA provides the service to others, so it should be suspend late
  * and resume early. When eDMA suspend, all of the clients should stop
@@ -948,6 +1048,7 @@ static int fsl_edma_resume_early(struct device *dev)
 static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.suspend_late   = fsl_edma_suspend_late,
 	.resume_early   = fsl_edma_resume_early,
+	RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
 };
 
 static struct platform_driver fsl_edma_driver = {

-- 
2.37.1


