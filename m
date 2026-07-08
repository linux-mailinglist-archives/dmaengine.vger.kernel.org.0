Return-Path: <dmaengine+bounces-12119-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V2mDF9N0TmqFNAIAu9opvQ
	(envelope-from <dmaengine+bounces-12119-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:03:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46072868A
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=y9rOZHPl;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12119-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12119-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCCC30D2490
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF606373BE0;
	Wed,  8 Jul 2026 15:32:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794036F91B;
	Wed,  8 Jul 2026 15:32:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524758; cv=fail; b=awYNCC55FnJSlvX5nPQEK6RIVDS/jSQ4u+r9UzccOvICGqfa3LtCJXMfomZ7E4cQ85lIgA0t979d3XKF+UtPs4PEkuCAvJ16JLjFABMgt6uskuaJgSVghOhhzMGZ29E//NrQm48g95VOE2dq0emQ8qOXWWcspuq7OmqC6PExIt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524758; c=relaxed/simple;
	bh=LzyCVUNfs9CXfZ6SWl9DWoic73HlvDomq4PLrxiZJV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c9iLR6oVT3STvikRohJyY3dp2F74AQ7yXV0EzuuI27fuVza2J0c15PkNCPgfK6aMK2TrjMGq5ef75dPXSLqomA4EYmnWNF9F1gnxSECYH1PbBiBPHg2IgXsdTXnjFtaIfy8jHJkYBxoYlu9YKyYCB6cDQJMT+o44u9Mlj5xSJ+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9rOZHPl; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEaOC5ryLrVVHv2vXftmj+8F1IqnWAqC5A6oICiljXFZic+xfn0VNkXggW2x+UzaGzQM2vRKpATDWpSNW8swmRN1u7KIhSNeTVl8u8oT4speEm5xNV5RjYQLDouYj1MDOY49rjmLA1zdM8kLIV2/bAEJBzP+/zA5G8TRYBIAQE350GW9BXrvn/cpxma+XtkcsEeRGBkzv4gool9gtktDdMXVL/VEqGyeHo5MahkFM0c8Bfoa8rkZiY32C/G7wcAzO/nV10Y8O/VpjuYMvKEC6URDSLhXU+diEnVOAQucbq6wGkU/UJzgw9GkSqQLGDNVHNr7xF6BE/sRYuURCHZF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsASyIWmAtkxRgXRPjjruR2WEiGzZEDLIP6qCnvVRHU=;
 b=FtNgwuIKJR+kBF8VXBIVr+OOe3NIUyqEYKUcu/Q4U9xICxslhZYEU5fr5sd6cdEtzULR9OVdbJ2mmx1+gjRPCXfIKUjUniIr77svczzXWs/gGmNZ7oE021aPuWZjEVhnT50wajnOmu0HHWFpQgP19U9vd6JpnJyEoLWQoOMl8BotrHvqnA+jpBrwb8ql7buuE5eLbnpp6LZfI1PQOIUDJSYtu18wxBI7WVHCkWaYPCP8os34Vef3RQUMMeDrRcGHwqti9UGxiwQSRBd7iWlMXntp2++wejqc1REDvjZyU1xlYOoP6fdW16JGRLFrL/cIV+o+9kZ3vylRmJg8AhvPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsASyIWmAtkxRgXRPjjruR2WEiGzZEDLIP6qCnvVRHU=;
 b=y9rOZHPlw73FwF+oxqgonXvZriLv6XyPg0YsqB7QPpz+hpntKsijxNcfTTPvDUtWsAZeqaKuw9THHn5RMeF2aswNBrZ+UVKxJ/mQCezPfV876ekxkgpvwD31iJ74Rt9kMlIIvAmf6Uhd4KEXPbJsUkR5nleaY+E4sTHYoLBHeko=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:32:26 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 15:32:26 +0000
Message-ID: <95fb4fa5-f5c0-47f0-99de-aaf4c440dd93@amd.com>
Date: Wed, 8 Jul 2026 21:02:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] dmaengine: xilinx_dma: Fix MCDMA descriptor fields
 based on DMA direction
To: Srinivas Neeli <srinivas.neeli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Suraj Gupta <suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alex Bereza <alex@bereza.email>,
 Folker Schwesinger <dev@folker-schwesinger.de>, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-2-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260708100652.603074-2-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::19) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e086d78-bb3e-4e0d-357c-08dedd061d31
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YjFefU4s2X7PjUHv3ZQBIDKl4FyI5McTe7BPn4hXfRZftqD+4/0H+kGTbXb5dAYSihWoF8WDnfzEB5UqNQhT4S3ZbeGXTdQPYYkvm3FPCm9VAuV1hPHfUA+hW3MvRrWkf5Jmp3WvVFIJO4AyyrvyCYkCFXcaVvQFHtjsJ88HmsifPfiV3Wx6cm8g7ThhR8Io7/TwUAQLa+N+zBVABtzmv0+6Cd5mpU4oeNI23EzFGBBxz3v900LqYIU4Fw72iMNJgjEVOhaxUJpQj95G6yzxgNm4mMCCUHK2ZHWlcUpvlF+i8YmHTx7MlQtCaZZ5iU/VHctdxs6F4t8oOGdPRmWJbFsrcWl5Ao3jYxINHRM2IivBfnPDn+e6qtrJhtWIESEifb8UyAlKmeruZobA0Zk49Mdd48qhwsRl0REGK7uYsk/dDVOCP/WV7DjyiSANhwXiQuk4gOs5raK9Os6kWp+66p48YfsfafSGixO0bbhhzQNu8aaAG1x3rnRCbypsfNdnPWLbEboZTsXUUb7risSzLGxZhtA1Y6Z7KAI3VqYjezf82rRLg2CcnR9g6qK45jOFLx1oWYuBdWoEZM/jJSMz+UW/mQ5iYOWTTH2MJ1z91a3lGstoRjlmHJxh6PMsWdgy+vW+5nAqwpXIBgYgefMBq0r065i2evYGBjyHIAxd/VA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3QvNXpTMFA2Vzllb1FnZFNIMnpuZnRhLzlsV1V6Yk05ZVA0WUx2NG5KYTVj?=
 =?utf-8?B?VGl5RDcrNENZWmhXazBHazJneXhaZUdVL1FQdTJzWGtUbmhCLzgvblZnSTlz?=
 =?utf-8?B?UG5ORWpkNkZtQzBKQmlvY1NQUjhqVkRtVXhTWnluTHhweXBScVdMTVVkaEIw?=
 =?utf-8?B?OFloVzZGb3o4RGliYUQ4T3Jua2s5Q3JuMmovSWpZWmxqNTBvQzdlMjBQd0NZ?=
 =?utf-8?B?MFJWdVV4eS9BNDI0Z3AvanVjY2kxOVIvMWRkUXlyYkl1MUwzZ1JCaWhKRWJD?=
 =?utf-8?B?dTN6dHF0NGxZTUpFK3VIbU5UT2Z1MFl5dWIrcDYreGw4a1R0V0tuUXpabDg2?=
 =?utf-8?B?dXB5T3dFV1dxazJzSm1Mb1dUbGhPL0NKbFZPNXhqU1RZZi9IYUJ2VGZGbTBF?=
 =?utf-8?B?Q0JkeU9iS2FWWVA0cTQ2QmgxNmZFN3FHR2IvR3VYT3VrMHJqQTdRSERmcGgx?=
 =?utf-8?B?cFFQdFczd3VKM21EbzJDKzFkZGtETDdxWEp3U0pKNW9peko0QklBRi9rdmx4?=
 =?utf-8?B?K0hSUmtWUnVvVkFvM1hFU1ZaQzRUSG80ZHBBNE42bmswNnhyaitIS3Awb24v?=
 =?utf-8?B?by9iZUM1K3JsWnNzL09UK1ZJUDlGTVdFTnFYUHJJY0FEMTBGWW51VDQ3dnRn?=
 =?utf-8?B?UnlMRFM2bWhKWVcrRjVnMjk1OHZBZUdnL0QzSjQ5MTRKcWdIMmt6SExOTjlw?=
 =?utf-8?B?V0RoK2hncXdjZ3BlbS82QWU3WDYyZG54S3pwYUEwUmQ3NDByU0U0RmdPbWRW?=
 =?utf-8?B?dFVvdlkrNHFNZFNPWVZycU1lYWFIWXVWQ2RTTDJGRjh6VytKdE5hMWwwNnRJ?=
 =?utf-8?B?WUZiMjgyWE1qeWNoMmt1ZnhMeFhFTGZiY1JxV1RMRm1GaWhNR1JvUVg2T0ZU?=
 =?utf-8?B?MVFQaHowOWp0cUF1Q0hDNUVScG9BZHdMWHIxNEtmQ2VVVnA5YkNrRXZXUVMy?=
 =?utf-8?B?MnpwWWhWckxLVnJPMGlkRXpYNk8rUXJZNDRHNUpwQ1o4ZnNVMUw2YTBwbzJr?=
 =?utf-8?B?K3hUS3IvRzVFSERpdmZKdk1FRUZoNUtWNkFnSy9TdzVURUxkeUFpckhGdFF4?=
 =?utf-8?B?K1JOZVFmT204WjNmbkZnM2FaSHA0NW45ZFRFVER4dmV0MlpYbWFoeHgvcjBx?=
 =?utf-8?B?Z0w3Y0hobjlBZUJUME1Sa3BHaUhyVEpzT0hVSWEyOXk3YVNOVDd3Vm1WSFg5?=
 =?utf-8?B?U0FnUkMwSzBRcEF3UjQ2UGx2S2xuWCtJM1JEYXNTckFxRzl4bFhOL2JyclNy?=
 =?utf-8?B?TVJPZkdDMkN2UkZXVC9WK05JK0gzOSt0NFZFZXRFZnpVVmd4MTlMUUphZ2RM?=
 =?utf-8?B?UmhTRUVJbHhzUktyU1dFL1J3K2tMdnJmNndQei85R1hmQTV2UnIyRytscE9t?=
 =?utf-8?B?ZEFrSHpsbzU4TmdQYzB2eUk0WHRiTHlHL0tHajlHRWN2b0Z4MzB0ZzVFWFRs?=
 =?utf-8?B?VmNFWlNWN0RIUVVIZDc0NldRM0pYTStpdWlaU1BYQkthVzI4U0xPamhBSHZF?=
 =?utf-8?B?NDdSTVl1QWwrUWZGS1lCL3ZIN3FPVHhsRXVzRVBXRnZqaGNkTG1Xb0t4c2Uy?=
 =?utf-8?B?VTViK2hxdGR3VkNQaU5jamxVWUwwY09LdGxVdTdWbTZ0RlFKTjZTWjVLbTJB?=
 =?utf-8?B?OUdQN3ZwdmxtTHI4NUxCWGY2SHdSMGs2R3JwNFpkSzRKMzE2aWVmK1FsQ0ND?=
 =?utf-8?B?ejlXRGVKTmJ5QlpLR0RrR1dZWWxBdDFyZGpBUGRlYVd3OG90WVJ3YlV4WDdm?=
 =?utf-8?B?cnVoWnRNbVQyZlk3NzB0cFphTCtwdWJ5dGVwckRsbUN5YVFFVk5zT1g5SDda?=
 =?utf-8?B?TGpoa05sQlpCMkFDb2pob2dhQ3JYaUdUUzJHSXRqZ2pkR0wxa25sNDhQclJW?=
 =?utf-8?B?ZmkwYjlTUzBaNjc1eDNCNU9nVHJpa3BhT0hkUnRlK0NraFlRcWdjaGNqM3Vy?=
 =?utf-8?B?N1p2cUpGbm4rR3pLMmxHVEI2RVFudjByd3BIcFk3K2VERzlFL0wwYWNGcDUy?=
 =?utf-8?B?b1VkbXlNWTZzRVhtckNpNVl2bHU3N1BaM3RnMC93dEU1MkhEWjFEZy82T2kr?=
 =?utf-8?B?M2s5UURyTDVJM0xwVytTZmVxQjFNNDNvenNpOXF3M1pzSW1HV3RBNzBHQit5?=
 =?utf-8?B?R0lEclNZeTQvbnBwNkV3YitjbWtSSVZyaTloUlI5ZDIxeVBQQ2ZYYkxjOWZ0?=
 =?utf-8?B?ZGFaOUZFbm5jUmNVNWFWenJ5M2tQTUhodXRvQUNsZUNGb25NYVVjTlRoYjlS?=
 =?utf-8?B?VEFDZjdJZURFd3d6QTU1UFpmKzBHRUJVb2ZZZG4yTEtVZmN6c3NrWkZkT09N?=
 =?utf-8?B?WlcrMi91RnA3c2ZYdVpJL1pjUy9TZ3JGTEdnZVYza1B6TU5DRGdVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e086d78-bb3e-4e0d-357c-08dedd061d31
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:32:26.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFR2AoPeChl7C1OASACfthTBnYXUzscnM0vZkRubeOmNJsBxqYXXjO/zQZjm9BUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-12119-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:vkoul@kernel.org,m:radhey.shyam.pandey@amd.com,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:suraj.gupta2@amd.com,m:marex@nabladev.com,m:tomi.valkeinen@ideasonboard.com,m:alex@bereza.email,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:git@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA46072868A

> The MCDMA BD format differs between memory-to-device (MM2S) and
> device-to-memory (S2MM) directions, but the driver was using generic
> 'status' and 'sideband_status' fields for both. This led to incorrect
> residue calculations when the hardware updates direction-specific fields.
> 
> Refactor the descriptor structure to use unions with direction-specific
> field mappings, and update the residue calculation logic to select the
> correct status field based on DMA direction.
> 
> This matches the hardware descriptor layout and fixes incorrect
> residue reporting.
> 
> Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
> Changes in V3:
>   - Renamed subject from "for MM2S vs S2MM" to "based on DMA direction".
>   - Reworded commit message for clarity.
>   - Added XILINX_MCDMA_BD_HW_SIZE macro and static_assert to verify
>     descriptor size at compile time.
>   - Refactored residue calculation to separate addition and subtraction
>     operations for better readability.
> 
> Changes in V2:
>   - No change.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 98b41b8f8915..ff5b29a808e9 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -223,6 +223,7 @@
>   #define XILINX_MCDMA_IRQ_ERR_MASK		BIT(7)
>   #define XILINX_MCDMA_BD_EOP			BIT(30)
>   #define XILINX_MCDMA_BD_SOP			BIT(31)
> +#define XILINX_MCDMA_BD_HW_SIZE			64
>   
>   /**
>    * struct xilinx_vdma_desc_hw - Hardware Descriptor
> @@ -277,8 +278,10 @@ struct xilinx_axidma_desc_hw {
>    * @buf_addr_msb: MSB of Buffer address @0x0C
>    * @rsvd: Reserved field @0x10
>    * @control: Control Information field @0x14
> - * @status: Status field @0x18
> - * @sideband_status: Status of sideband signals @0x1C
> + * @mm2s_ctrl_sideband: Sideband control info for mm2s @0x18
> + * @s2mm_status: Status field for s2mm @0x18
> + * @mm2s_status: Status field for mm2s @0x1C
> + * @s2mm_sideband_status: Sideband status for s2mm @0x1C
>    * @app: APP Fields @0x20 - 0x30
>    */
>   struct xilinx_aximcdma_desc_hw {
> @@ -288,10 +291,17 @@ struct xilinx_aximcdma_desc_hw {
>   	u32 buf_addr_msb;
>   	u32 rsvd;
>   	u32 control;
> -	u32 status;
> -	u32 sideband_status;
> +	union {
> +		u32 mm2s_ctrl_sideband;
> +		u32 s2mm_status;
> +	};
> +	union {
> +		u32 mm2s_status;
> +		u32 s2mm_sideband_status;
> +	};
>   	u32 app[XILINX_DMA_NUM_APP_WORDS];
>   } __aligned(64);
> +static_assert(sizeof(struct xilinx_aximcdma_desc_hw) == XILINX_MCDMA_BD_HW_SIZE);
>   
>   /**
>    * struct xilinx_cdma_desc_hw - Hardware Descriptor
> @@ -1015,9 +1025,11 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>   					   struct xilinx_aximcdma_tx_segment,
>   					   node);
>   			aximcdma_hw = &aximcdma_seg->hw;
> -			residue +=
> -				(aximcdma_hw->control & chan->xdev->max_buffer_len) -
> -				(aximcdma_hw->status & chan->xdev->max_buffer_len);
> +			residue += aximcdma_hw->control & chan->xdev->max_buffer_len;
> +			if (chan->direction == DMA_DEV_TO_MEM)
> +				residue -= aximcdma_hw->s2mm_status & chan->xdev->max_buffer_len;
> +			else
> +				residue -= aximcdma_hw->mm2s_status & chan->xdev->max_buffer_len;
>   		}
>   	}
>   


