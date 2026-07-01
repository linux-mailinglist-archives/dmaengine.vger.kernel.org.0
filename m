Return-Path: <dmaengine+bounces-11916-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D+dBCk/dRGpQ2QoAu9opvQ
	(envelope-from <dmaengine+bounces-11916-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:26:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7286EB96D
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:26:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=j9fSESpc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11916-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11916-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A06483019477
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE943EF0DC;
	Wed,  1 Jul 2026 09:26:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3873F0779;
	Wed,  1 Jul 2026 09:26:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897987; cv=fail; b=RVh9xtoqafqddMFWZPNwGNQ8LOAfBR3/tO5xhUK/JTch/0eIt0j20qVi1MaItaHKkPOXmTMgp8XdMqAzFm3t8+vyjk3kitEs30VUtulMG5VFdqiUk3xtT0Hyb9fjNHr+cEFStZUfZiFmXA6XgEzBwh2z4E6E693N7zNc86SLC2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897987; c=relaxed/simple;
	bh=x+oHZrqdv874yrs9ffwFmekw2Sn7OouzSXuZOt2tRXo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Lsnl2b1N/Da1Mn7nTWEiE1PLrut1TVMVS2BiZHhmYRNu2cH+i4ieoTS1msjKU48ygBf8mbTFMYklJVR9fIV/gzGBG6NJfk13Ife8Ndco+lQYoqQnTv5C2maZuQzZZt8D5qOfZvA19V+edwFctFX0xVXE3Z4FVzT55n/Fe2LSwLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j9fSESpc; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9QbdHv+LD4hg6xCik1wAFfsFYYozZqhLiQ1WsismzEfpx8ERfeTQp45d2NdLm0Faz1jKPtVpxxIFvohthCKyry5JjXrhRRadKTf1At0LBn2wzbyK82zmNPbNZRyFHg+s2ryom65l3bhxOCBjkMJng+7NMYJJdoJKAp+6aF2xsCnw2EjMPcuvItCk+noce14IIFO4jZk4Z+M1scHwAqklBnbRaCs5sNIAC6qvQEy7Saeb2Eo1bnCehyigxgoAZjhjGtwe66qyPZUBKDtdbpkd5kySErRZVUBwibRtxKITy1+1g/H7LYtE2n9ujdkxO77t6AfuLADul/zoZSNZFWpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoTZeK0aHwt06hE99N5cEsyfXE1kGCHz70Tlc/jA61I=;
 b=ox+5AGWQWcP7qKVuPskTVhPonv3loEtxMvFYa/LxTcWOv0rc5IkHZg7x0LVdgXbhQ1p6Y9uuFMDcpcnMiBkqYcsLS1yvYcD/MVZAxsZ5Uk+hUtRSNatILF5zCHeUTX3MIv1PplqQu1J957HSxDtawZBJkw51GKTm4TptPlOHIkH1siJZfaejFhYbasrHqgOrejiBY1O6oO1QAuZ9tOqQ4jBvS0CkHZBrg1GPfVTdUAQxNMH/bevCBXXdnC7VA/d0USYALIJ+mJl/u3M9QPSEvDWfo5NDcy/i39IWtNoHpyZ3mbhYVDhbKrU2OA3WQCo509zqj3V4huySre9DVZ6pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoTZeK0aHwt06hE99N5cEsyfXE1kGCHz70Tlc/jA61I=;
 b=j9fSESpcAiAa9LKyLdMZgSLBRTfGe6IENK6B1CpLKJHzFGVL03m9MqWWISIpvK/MYwE0JjFjlfXddKCInbdWhR/MP80qIPVpeV+963MZeJEKs5+ufmk6pQIcPJSU3/f7P3zGASd0tknjBy+6JQ7ksC3acMXSjqEiP5tABp1tQAICVp91bHdon9uS2ii0n63QIzto+Z2Lg/vBKyW1UydIzCaKTRdPmuDAf/ziNgUHqnns4rViuEiciqBPmSJ7dKb/09xZ351MoxD7CONeLCjOaJFpUuz7rtKTtxmVgjocymjuBGlwltLoJguoqDtQNc/QDRCJTOo7jEgDYs567phCRA==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:23 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:26:22 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 01 Jul 2026 17:29:23 +0800
Subject: [PATCH v6 1/5] dmaengine: fsl-edma: use devm_clk_get_optional()
 for channel clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-edma-runtime-opt-v6-1-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Joy Zou <joy.zou@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 26363014-ae0c-480f-505b-08ded752d10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xfvga1mCQKynj4bJ9Xsq22DATjKb1+YnmnO2tyYM888XJCm/bswIUOwFeBWRZMfeWlQMl1q2g3FjziM+qWo1x7h7PKoSF2uGqwf5CiG666Swc3ebbvaWhIL7mBjQKm82HeNBLECQwI1fq25iPGbh1Q8WA2PTn3ufPFRWISO5KCOLW7MpD8gRRv2KFLoAW9m4f5FfqLYOse6aW9fgnyqbQoSSDz6l3D3FzPkJzot58BD9GiiAzHKsKZkGEPNnEu9UiRZk+2KiimLODeb5ysjR1Cc09aj09WOOtysg4qIrHUGdND7v7MY3RqPJvA6Ud2ABwlDHc90L71JGTM44rdBWTdBalItZJKWJjY9MJ3JMOmjorm3ajBbCuURX96go++9cp5jMB29VJW4XYnxOU5aTcraMHQOVTQYT+PPfCkii0YHXhFVjNE0fKUJUV+SwbsnW/9jBl4GcDiJfnzb7Tzkj4u0it1oezQj2rat568r2lTtfNFLNiCvd3VTR7n51L0UEKfpj6zgT6Fm4p/068o/8wy3Ip3EWlbDMb9LwISK/1HuJyvWVZyxK3RrvPMhsrtOtjZoW/KFQkb0qvF3b61b1EeT26d4azPWCR7EaCTiPpXiUvCihhgibzVYK45ENxCCYJUXmdOQKbytJgYlBePsZJSkQPltH64IkYPUm2ZnA5/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bThQZmdUbGV2TkMwdzRjcXBENkVuZndmcGNBMmUrSmpNeWhwUnB3WFVWWGto?=
 =?utf-8?B?Y3QvMk9PZzN3TUVWa21Md0loT1h2eTJEMDJTQ0xyS2pscW91VTYvUlZtcHJ3?=
 =?utf-8?B?NVV5bkFSc2I3VzNnSW84bCtWamViSDVGTHk4bzJ6NWY5ejkva2dVZGVaWGt5?=
 =?utf-8?B?aDMzMUh0aW1pMzE3Snd4anFPZktwNk8wcmIxSVZ3S1I1WFBQS0N6L0c0TGRC?=
 =?utf-8?B?OS8wWjhrTndzYjhDYkdzWEJFSzdwcmZ2WDhvSmRuSTZRWlV3UjV5c2J1bVpN?=
 =?utf-8?B?Lzh6NUZkYVBiandCU0pHTVg2eWdiV0Jvdm9sSjRRZFFFQjE4bk9aK1F2U1N3?=
 =?utf-8?B?WVg3bXVoblY1UzZwNW9uL3RMMXJTV2kyWmVaSHlNVDJCZ0RvNFlMMHFYOHRu?=
 =?utf-8?B?dkVZQnNZU1F1NEVNL1BPeVQ5YTl5eGxRYVdIelpUMXYreTNJa2g5K05EWFl4?=
 =?utf-8?B?UjBzcm8zMk9oZUUwdFVrcXBTa1Q3WWJkanAyYVBqM2JuUDJ6bjBzWG04VE9q?=
 =?utf-8?B?d2pxTEF6dWVjcG5DQ1ptcG9NOHJubXJmRzR0NmFLUmR0WmNpQXBOMXA3UXkv?=
 =?utf-8?B?K3U1VEVseDZ0QVUrY1lYbjV1TDJDMG90cllYMjhTdXRZZWdXTk9BNU9MV0o4?=
 =?utf-8?B?OEtXUTBWdE9uYlhpbmFUS01LbkJHSkdDWi8wUlZzRkpwQmR0NjF0azJnWmxZ?=
 =?utf-8?B?OUJ4ajNMZThGeXhLYTFBYXlVbmRuQ1RjVUx6Ti9JNDNVUmZrWUtmQjZlU1FG?=
 =?utf-8?B?dVA4ZGxSV1psaC9hM3hCbEhnVEplSFNPWTA3dTBTcS80ZnVCVmVEcGNmeDBo?=
 =?utf-8?B?RWxEQjhqMU1jM3ZEWllndVRJOHBNZkVYdlB1ODV5aVRrMDh3cWFJOVo1MlBD?=
 =?utf-8?B?LzdaWDVXS0J4RW1xMTF2SWMxdmlPemdvc2NzZVdXQzlKMVdVUWoreloyejdZ?=
 =?utf-8?B?YzZCVGVhaG5FYjN2d3gvU3hNVXJ5OThQcHczVjJRSHdEbktJd1RITFlTMTln?=
 =?utf-8?B?VzNXZHYvZERhdTEwYzVVWVd0OHRIRDd5OVB2aHZDY2x1TllTcG0wR1JHeExr?=
 =?utf-8?B?cWtuUmJOREM3TkdPaHNUMnRkU2tJclluQzBCZEFZc3RwbE5RL3dHUmRLUkxi?=
 =?utf-8?B?cUlRUXZKem9lbTU5d1VwaGhyMmtoUkVPOHVienFvVXR0YS9GTERmRHltNDdy?=
 =?utf-8?B?Sms0bkxSQ2ljNzJxVU40S2FCeUhITTd0ZjQ0TXQ4S1luZ0RrOVJURzN2UUZa?=
 =?utf-8?B?a1FXcklWMXZqVjdNMlZBNzVvTHFGeVRPczlqd2NRWVlBdmRERHNQamVteEZU?=
 =?utf-8?B?WjFleGFHdjRPUXhTdmJZcjY1VmpLaGdTbGthN1ZIdmt4SHJMNmpVMjBSWDBS?=
 =?utf-8?B?Y2ovYkhZWTBPSWYzNUdZaHRSMTNhaW1ERXVEYnR5a2JySHBGS1NhTlhkRCtL?=
 =?utf-8?B?Ylk5UlNhMTlMcVI0LzRxZkNlMHhhOHVhRjlkdUx0UGJjbUZYNmhaZnZSOE9x?=
 =?utf-8?B?S0VBQnRuN21tQUo1RFJzSlhjY2xsSHRmWStQb2hjQS9yZ09vL3NKcDQvdE9S?=
 =?utf-8?B?aTVmTmtvbkE4cHdZVTJFd2laKzE5MzRxZFhzK0p2b1Bkd2Z3WEV6QXBuRTQy?=
 =?utf-8?B?Y3p4UzJSTDJDbVQ0YVJhbzN2WDU4RS9JNkRRd3FWdkwvQ3RNZ2hZN0YzYi9n?=
 =?utf-8?B?cmMvR2ZRZ1ZBOENnWExsUTNlZ3lCNUdOOVVIV0VmclMwZmU3SUJDR2tjRThw?=
 =?utf-8?B?dk9wZlc0aHk1WFgwNW1TQlBKb3pmdURxVjh1VXVBWUFyRlBhUEV5aWs3Ukc0?=
 =?utf-8?B?WndVWnFhM1NRd0ZFYWZTbjc2ekZUVk5oeTZ5RncwUVUwdnk4WjZ5VE9JTEE4?=
 =?utf-8?B?U3JPNkJaaUs5U2FJQVFyTVRQZGtoV3UyemZvV1RBMC9IcnM0cVVZYnJjU21u?=
 =?utf-8?B?b1FvUTIvK3JTbDErMWh4WElZUldIYlMzaHBZbzRoVHBWc0RxOXlCc1o4UXZJ?=
 =?utf-8?B?QlNFVjlWc3V3WFV4SkJRQlF0TTAyVkxoZHltT2ZYWUY3UmdPalVLU0pIT1gz?=
 =?utf-8?B?TmtoNTVUVCtBcWNFYVpwa1dEUkpWTzVvb2hvdGdqVDNVbVluM0s3RWtQLzZ3?=
 =?utf-8?B?dVh1OVBaQXNpR1ptUnYvMkwwMWxKdTRSck9iYXpvRkZ1MHZHbzU0cTlVQkha?=
 =?utf-8?B?Zmh0RjUweTRIOVZhYmMxZ21VOTVNVDFQVXZpeWZNRjBTUWxXUEg0a1Y0MkRR?=
 =?utf-8?B?cm5NUjAzWWlkeFBjZXBEeWJQcS8xeHNqS21od3FENkRUb0xvMU5YRVdrMUJH?=
 =?utf-8?B?UGd5WTFmcUdQWkhuQ09wUkVBUU5valBMa3VFUm85ejh5ZEFjakJ3eWlhVGQ1?=
 =?utf-8?Q?2hAiUSletD4AEkeyNPaMd9fduLD2+H4R9qhZK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26363014-ae0c-480f-505b-08ded752d10f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:22.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Geu/94VT0plaab/LX/7UpxyKne67HVtKnJb4PF5PCNuAMtxfKUKe6nS7MQ3prbZaYM8Ay75dsXnPX0icZQ0P7XeUAtnTlQ2amd5GzLj5JF/4pWpNcPggVbf5Avo69ZGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11916-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C7286EB96D

From: Joy Zou <joy.zou@nxp.com>

The channel clock is optional and not present on all platforms.
Replace devm_clk_get_enabled() with devm_clk_get_optional() and
devm_clk_prepare_enable(), and remove FSL_EDMA_DRV_HAS_CHCLK flag
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
 drivers/dma/fsl-edma-common.c |  4 +---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 22 +++++++++-------------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index bb7531c456df..e1ca25ff228d 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -844,9 +844,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret = 0;
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_prepare_enable(fsl_chan->clk);
-
+	clk_prepare_enable(fsl_chan->clk);
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094..f4354b586746 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -210,7 +210,6 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
-#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 #define FSL_EDMA_DRV_MEM_REMOTE		BIT(8)
 /* control and status register is in tcd address space, edma3 reg layout */
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 36155ab1602a..1e864cd4c784 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -567,8 +567,7 @@ static struct fsl_edma_drvdata imx8qm_data = {
 };
 
 static struct fsl_edma_drvdata imx8ulp_data = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
-		 FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
@@ -808,22 +807,19 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->tcd = fsl_edma->membase
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
 		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
-
-		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
-			snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
-			fsl_chan->clk = devm_clk_get_enabled(&pdev->dev,
-							     (const char *)clk_name);
-
-			if (IS_ERR(fsl_chan->clk))
-				return PTR_ERR(fsl_chan->clk);
-		}
+		snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
+		fsl_chan->clk = devm_clk_get_optional(&pdev->dev, (const char *)clk_name);
+		if (IS_ERR(fsl_chan->clk))
+			return PTR_ERR(fsl_chan->clk);
+		ret = devm_clk_prepare_enable(&pdev->dev, fsl_chan->clk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Failed to enable clock\n");
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
 		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
-		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
-			clk_disable_unprepare(fsl_chan->clk);
+		clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);

-- 
2.34.1


