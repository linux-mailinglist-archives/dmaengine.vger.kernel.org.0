Return-Path: <dmaengine+bounces-11832-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9tlCGWIJQmqpzAkAu9opvQ
	(envelope-from <dmaengine+bounces-11832-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 07:57:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C816D61C9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 07:57:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=xJ1dL0wS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11832-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11832-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893E13002F8E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 05:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90643932E9;
	Mon, 29 Jun 2026 05:57:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C590389460;
	Mon, 29 Jun 2026 05:57:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712671; cv=fail; b=ooRibrRu7YaYVOjWzSau+IL2Oj3nI6BJdl8i/0MYdV9mQFoPwYyDctEC+HZe9WFCYMki4nqbgyNc/0CDr8UpwhKTZe8LwzbJouXHSJYw02MJAEl9rhFdZKkv1aVkGT46ywcwfMzuPKXPgj4TmINwxtLRotuFI8oyeAUXIu/57a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712671; c=relaxed/simple;
	bh=SuBNFpigFrVS/iW6ZTp8YO49CJ5inG+ZCgQmaU1RUXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YlqyWTIIiZWRd3I32CH5DYF87zjNpXgDwy9b/kPjIBivLYlQzlm9piA2wNZqiHh2St8mqCm1rOkrxs66Fk8acspzRR/xQOq4kgoS51cTbS1Z5tbSRTazU4yOz28vWWwzJfjv5p7nAd1yM+JLGmXjvhtNFklt5xEiKyI9TlTc/fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xJ1dL0wS; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrHWFMoQxJvI4n9T1LE04/PLTevYxh/+KM1YlpQupBikql0/As08dQkSvjRRw74LgUkYk9WIsMSZG9pLXxuadZxbYjpy+EYJIUXbi0VBjwxDoL3FOZIaScFYStcjSj2tbKVsY0CQHclhGCf5HRgtPwzAb6fESQ6YT+J8uXCEnv2fCzWxVvv7n6uJgF+CrFohzVb74RsjaW/Hlb+jbhjQbBwLHUecoipWQBBfS0CpOI67JcqPWMM4ZIXe9gmHmMq4d+yr9rv8Ua2s8jrZd8h+DA4sm1qFzw2Uk0Ac4oQ45Xk203VblOY8JcO4tLkHuOOkfz+FeyY2XiSzzSDnC0glUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3R3UXcHa+9UCcFyL2rlZj0TBdSNleguhPNqMCjONaU=;
 b=v+AEd8jvgAEdi6KthWNw4H/9EsBlk9WDHdmJ59Cui52ERqbiNINdUWLFjnDbc06Vd1bc6m+0QGFY6jjscPYHy++5SEYNDX+kUd1YPyWj6xKznm0rHqkNHa2c7aKJL7rzkV2LKUlwFvhyR+j3GuelDNLiQPd6Vj2EI9jeYYQUAtg3hW8rhrwOka5ANXIDrf6X4kPFCCBYF8knEgmgiQAjuDB+dAxEw0w1RJJKRyiom/nXDr9AMiRPf1gjT6mPPYOfctsQ9ImtAX1Ycj4D2v7+P6xkQ39wXRlgmys/NMSYuO9xRz+uJuH0hYUSIadYcCl13eilD3cqHVeG+Etb2dOgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3R3UXcHa+9UCcFyL2rlZj0TBdSNleguhPNqMCjONaU=;
 b=xJ1dL0wSq+ekstS36HKiNIr/gDoQBdgKpx+MW+nwUwBftNNEid20fjxPPRiclOqPi8QptHM1BoMbA0beNARg3JpCo3mtk5Vqro8XtWklq4cBMeF7zb9hCwOFv7s6f7RyheYdXvF54tzG3A43/sqjEM2nGyM6gIGc9TIzBLzsoVo=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 05:57:46 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 05:57:46 +0000
Message-ID: <791ac596-69ae-4eea-9741-0dc889111909@amd.com>
Date: Mon, 29 Jun 2026 11:27:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Frank Li <Frank.li@oss.nxp.com>, Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com
References: <20260626132151.1875965-1-devendra.verma@amd.com>
 <aj6kWCMbzyYC8Nh8@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <aj6kWCMbzyYC8Nh8@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::11) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: ec45c73b-64c3-47b9-e72c-08ded5a357f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dWwoauAextmy3hj+h+9/VLHCobs6VnJygRBuVNQmA92OABXY/HjRYHpzDfWvMhcPZgsMKBeO8biu2iu4POA8CUoNu/a6IvseWW/NH10Q8ZFbnQdQGdxr7aRY2vc7kICDHI9dy8PiEnfm5C08fAphJoWVinPItPqy9N1KftU+iK/182viOSjhxHz5Avb4lk7oR0I4aDOnaO9QWosPMU9MvygzhMPSFEiS9GnFIgvYgzSQab+KwLgtfbrKTIkplqu54TmPBHXCBqppO0PATrzBCd6UOMJzrHaNYFMXeXOymB+SVdoOveOfdERaW2tc1Nkke0QqsPkkl952+wtX1W+FuWrYNyRYg1hdoTv5bPNiZmLUc/ICinRKH78HBsHx3qZCVVQ/c6GvMDML/f2UpV02NRBHIIiNsFhX+bQR7WX9STUQK9is3+9l8aydIun6y4fkjTApnPpsXowl1TYuzMN+v3K9vNJb2cwAK0ikV8QHm5RnsJVZ3Qw/4ZoFA/CevT8cxzjK1yHhfAx3fmwg2pgktkz/VRbXnDYpJ9dKfCy+bRn5o6fdQ6MJPui1DRvcMoZBOWGQKcAhlcjnXPirXv35nnmUXm9eZxTMzVMLGhGad+bGn0GxngESBjbSMxaYGE8lxRzYXu2XHuCjnqjrpCuLYGC8t3Nwt2c1uh/UCYtThJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3BQbVp3K04yUEpzck85Mk1zR3E4M3RjdUxrVTBGNjZ5dE52bG1pczdja0Qr?=
 =?utf-8?B?TzhZM2dXSUN1bllTYnVUaDAzdmpUZHNjTnE5TFo0byszZnJSaUtQVlpXOGlZ?=
 =?utf-8?B?RWZHNmlwWG5NRjFZTk9GSWlRVE5XS0hRWldmYkZrQ3JFQ2hmVUFyaVBoNlpN?=
 =?utf-8?B?a2czdy9wQ3l5eCt6RDg4d1R0VjhOR1ZOZzFYcWtERXYzRDlUUjgzWStVU29H?=
 =?utf-8?B?VE5KUE1QbktqVkI5alNuWDRUQzhDTFNkM2NEd2xSbFBXNlJaMjlab0Fybllp?=
 =?utf-8?B?VjIvWHg5T3djUm1zMHAzRXEyeWFIdVNITFFzOTA2VU1FRitGVTEyYi9yR0Y2?=
 =?utf-8?B?SFJQVW1NTnFDUEw1L2dEUUNlNlJ5UGwrcDFYaitTQjcyeVkxUWZ0R01MNm42?=
 =?utf-8?B?MlNFWkVNNXQ3N243TDNpa09DamlSdGJodXgyY2Nicm5xSUprVnJtSmtvN2Fv?=
 =?utf-8?B?dGltSi9tK0ZFWTJLUjhnNHd1ZDM2S0JRaTk3ZytwTlJNdThlYytYUkZMUWRh?=
 =?utf-8?B?TnhrS0loZHhnY05zdG82SmdQQlZYM01oc0F0MTh1NVlGMWh0U2FzWW90VnhL?=
 =?utf-8?B?NElxRGNaQWZEc2VHV2NuQ0F6SUh2WFdxYm5icDlISTQ5VmpwTE5xdkttRXpT?=
 =?utf-8?B?SUxIRHc5TVVXV1YyLzh6RjN4Y3loQzVBc0RRWVEyY2FtR2hkckw3ek05K2R1?=
 =?utf-8?B?RmJlVWhJRVgzRnFpVHgzL3JSeXpiZXhJZ0xaa2EyckJMbm5lWjRobUxrUzg0?=
 =?utf-8?B?Vmh0bmg0UFpRK0pGWTlpWXFuNFhxU0xTc3RIbTZaU3ZPUmpuOHUxcnh1bU9p?=
 =?utf-8?B?bHdjWi9FR3MwdFN1WHc4cllXZ28vU1VIN2lMS3laS3hYMS9tUEdVMk1NS0J1?=
 =?utf-8?B?T2RydlRrTVhsSkRjUEppSGpkdDBmZ0VEbmNINzBNUTBVM25KTUkwbHZBNXY0?=
 =?utf-8?B?QXhHQkhyNzhYZnE4czZiL2h6RFlRL0c3aXVLYWRIcDh5QjMzdnhUejhxcGxm?=
 =?utf-8?B?VFNGL3M4VnZQcE9WVnhTLzNCWUhnSzhiMVppR3dYWEFueDRlaWM0TksyKzlW?=
 =?utf-8?B?MFI2RHgrNmZGaWxwNlNlQkszYktreDBkV0NmRFMvNzRrK2lZMkFwUFdUUHI5?=
 =?utf-8?B?MHBYa21GZjNKMHJWZGxZdFFqUDZxdlZxd2VDL1pSSFprQXY3WFpYYVRUOEFs?=
 =?utf-8?B?czZGMXphNGVEYUEvbTdhZUlQWWJDRndmekI0Vmh1MXkwTmtDb3RrUk9Nd0Vo?=
 =?utf-8?B?T1lnWkNRS0xSbmJEeS95WDVWNWE2dzVTcXZVUkJ0c2tOcWJqWGo0dUFtZmZN?=
 =?utf-8?B?S1k4eGRjVTIrQ1RsNGdCdFkybW5pUGVNcS9VbHNJMFFBUHRZVTA0VkgzMytr?=
 =?utf-8?B?elpHanFIcldQOGswOFFNa2hjN3EvWTE0djVOZXN6eEMrSGVWOHJGWUtrdGM0?=
 =?utf-8?B?R242Y2hiZU0wWXVxZzJ3eTAxSmowN2t1VW4vV2NCemxKNTdEbm1qZE1ENnRu?=
 =?utf-8?B?RVJVOVllTzUyV1JVeXpLK09LVXdEUkt2WTY0RnVvYXZaMDFiNkYyWG1NUUZG?=
 =?utf-8?B?cm9nYUtHRWEwZThnQ0M0MXFiMm9RcXQzdU42TGJvZ0JwY2VBVUV2SlJLTVBq?=
 =?utf-8?B?ZWgzbVRUajB5b0luNjI3ejc1Z0R0ejRENFFKSEs0dURaM0RWaC83cTduanlJ?=
 =?utf-8?B?a0pZQlE1VFhmQ216MHJ3OVY3eGhoT2ZOZU5UaUJWcTFwVTNsYUNFMStDdmhH?=
 =?utf-8?B?alNSUGZDVDdCb3RNakx0MDV6dXExaUllMGtoU2MzOVF0c2xKS05GWmowQ0lL?=
 =?utf-8?B?KzVBOWZ4S0o4WmxHcnpmaHhHd3orcVRPOW5yMlhIdTc2UmlPTGxJenkyNldz?=
 =?utf-8?B?MXdiU1hWVVdiZDRIOTNSd0lTWXdDMXE2U2ZDWXhEckhxaWEvbVRnTWZzNDZt?=
 =?utf-8?B?eWpWSkdLL3JXT2FUcDZBSGt0UmVYZWdxOG56Rm5qd2JXcXI3ZUlXenNaSHZu?=
 =?utf-8?B?RTdFdnJKOGJOd245akZhSXp6N2VwYnFwb2d3SzdjVHFQZkVtdFgwMU5QMkJm?=
 =?utf-8?B?SnY0bTMxK2JnNG4xbGNRdWI3RlRiREpLTTVjeW1YKzBHVzlRd2JLUGhVd09Q?=
 =?utf-8?B?Zzg2aG1DM001cnErUE0zYm1UTFptZnhNdTdCZHZxN3RzdTN2MU5lL0liQjE3?=
 =?utf-8?B?aHM2bkdTNFhtL2o0a2FSTHVLS2N2dlE0czJ4cDJZK1dUa09EMUgwUGhHQmsv?=
 =?utf-8?B?TDduZXlTYzBXQ2Q3U21CcmprdDA0a3BRbGxkR1ZtRU9BMCsvYU84WGJSVHht?=
 =?utf-8?B?dkVPc3NwdWQ5bFFnL1F5NlY2K1JmWVZrSGUrbC9tOWlxK3V4QVcvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec45c73b-64c3-47b9-e72c-08ded5a357f6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:57:46.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPPvliOd1txv20A+kLNUacvmdVxSUA0bdZWPt41iQkHwZ9FataN9PvgvsZBYBKoiS60w0FAkuGWUFVV+n77NAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11832-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1C816D61C9


On 26-Jun-26 21:40, Frank Li wrote:
> On Fri, Jun 26, 2026 at 06:51:51PM +0530, Devendra K Verma wrote:
>> As per 'Designware Cores PCI Express Controller Databook',
>> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
>> channels. Current controller driver supports up to 8 read and
>> write channels only. In order to utilize all the channels the
>> controller driver need to have the channel related structs
>> and variables as per the number of channels supported by IP.
>> Following changes are made to enable 64 Read / 64 Write
>> channel support:
>>
>>   o Defined HDMA specific macros to reflect the channel count.
>>   o The count of ll_regions and dt_regions in dw_edma_chip and
>>     dw_edma_pcie_data shall be in accordance to number of read
>>     and write channels.
>>   o In dw_edma_probe() configure the channels as per the channels
>>     of the IP used.
>>   o Changed mask types to u64 for higher channel counts.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>> ---
>> Changes in v4:
>>    o Changed 'mask' variable to a bitmap type as per the
>>      review comment.
>>
>> Changes in v3:
>>    o Reverted the FIX for AI reported GET_CH_32() issue, as
>>      per the recommendation of reviewers, need to create
>>      separate patch for it.
>>
>> Changes in v2:
>>    o Fixed the pre-existing bug related to GET_CH_32
>>      interchanging the channel direction and id.
>>      This bug was not caused by any version of this patch.
>>    o Fixed the issue when using for_each_set_bit() for mask
>>      of u64 type.
>>
>> Changes in v1:
>>    o On review recommendation of sashiko bot, in the function
>>      dw_hdma_v0_core_off(), the loop iterates over registers
>>      as per the number of channels enabled and not on total
>>      number of channels supported.
>>    o Changed mask types to u64 for higher channel counts.
>> ---
>>   drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++-----
>>   drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
>>   drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
>>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 32 ++++++++++++++++++---------
>>   drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>>   include/linux/dma/edma.h              | 10 +++++----
>>   6 files changed, 48 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>> index c2feb3adc79f..adf1b3939f96 100644
>> --- a/drivers/dma/dw-edma/dw-edma-core.c
>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
>> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>>   		irq = &dw->irq[pos];
>>
>>   		if (chan->dir == EDMA_DIR_WRITE)
>> -			irq->wr_mask |= BIT(chan->id);
>> +			irq->wr_mask |= BIT_ULL(chan->id);
>>   		else
>> -			irq->rd_mask |= BIT(chan->id);
>> +			irq->rd_mask |= BIT_ULL(chan->id);
>>
>>   		irq->dw = dw;
>>   		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
>> @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>>   	struct dw_edma *dw;
>>   	u32 wr_alloc = 0;
>>   	u32 rd_alloc = 0;
>> +	u16 max_wr_cnt;
>> +	u16 max_rd_cnt;
>>   	int i, err;
>>
>>   	if (!chip)
>> @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>>
>>   	dw->chip = chip;
>>
>> -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
>> +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
>>   		dw_hdma_v0_core_register(dw);
>> -	else
>> +		max_wr_cnt = HDMA_MAX_WR_CH;
>> +		max_rd_cnt = HDMA_MAX_RD_CH;
>> +	} else {
>>   		dw_edma_v0_core_register(dw);
>> +		max_wr_cnt = EDMA_MAX_WR_CH;
>> +		max_rd_cnt = EDMA_MAX_RD_CH;
>> +	}
>>
>>   	raw_spin_lock_init(&dw->lock);
>>
>>   	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
>>   			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
>> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>> +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
>>
>>   	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
>>   			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
>> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>> +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
>>
>>   	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>>   		return -EINVAL;
>> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
>> index 902574b1ba86..d12fefbf3952 100644
>> --- a/drivers/dma/dw-edma/dw-edma-core.h
>> +++ b/drivers/dma/dw-edma/dw-edma-core.h
>> @@ -91,8 +91,8 @@ struct dw_edma_chan {
>>
>>   struct dw_edma_irq {
>>   	struct msi_msg                  msi;
>> -	u32				wr_mask;
>> -	u32				rd_mask;
>> +	u64				wr_mask;
>> +	u64				rd_mask;
> 
> Can you direct use DECLARE_BITMAP(rd_mask, 64) here?
> 
>>   	struct dw_edma			*dw;
>>   };
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 0b30ce138503..79f653da8e0f 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> ...
>>   	}
>>   }
>>
>> @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   	unsigned long total, pos, val;
>>   	irqreturn_t ret = IRQ_NONE;
>>   	struct dw_edma_chan *chan;
>> -	unsigned long off, mask;
> 
> after change wr_mask to BITMAP
> 
> 	mask -> *mask
> 
> So needn't change this code if support more channel in future.
> 
> Frank
> 

It looks good to make this piece of code generic and support for more
channel but I did not push that change as the final limitation comes
from the HDMA IP which as per the documentation supports upto 64
channels only. As there is no channel increase BITMAP was not
implemented for *_mask variable.

-Devendra

>> +	DECLARE_BITMAP(mask, 64);
>> +	unsigned long off;
>>
>>   	if (dir == EDMA_DIR_WRITE) {
>>   		total = dw->wr_ch_cnt;
>>   		off = 0;
>> -		mask = dw_irq->wr_mask;
>> +		bitmap_from_u64(mask, dw_irq->wr_mask);
>>   	} else {
>>   		total = dw->rd_ch_cnt;
>>   		off = dw->wr_ch_cnt;
>> -		mask = dw_irq->rd_mask;
>> +		bitmap_from_u64(mask, dw_irq->rd_mask);
>>   	}
>>
>> -	for_each_set_bit(pos, &mask, total) {
>> +	for_each_set_bit(pos, mask, total) {
>>   		chan = &dw->chan[pos + off];
>>
>>   		val = dw_hdma_v0_core_status_int(chan);
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> index 7759ba9b4850..48e40efceb2e 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> @@ -11,7 +11,7 @@
>>
>>   #include <linux/dmaengine.h>
>>
>> -#define HDMA_V0_MAX_NR_CH			8
>> +#define HDMA_V0_MAX_NR_CH			64
>>   #define HDMA_V0_CH_EN				BIT(0)
>>   #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>>   #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e315..da7a5cc93ad4 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -14,6 +14,8 @@
>>
>>   #define EDMA_MAX_WR_CH                                  8
>>   #define EDMA_MAX_RD_CH                                  8
>> +#define HDMA_MAX_WR_CH                                  64
>> +#define HDMA_MAX_RD_CH                                  64
>>
>>   struct dw_edma;
>>
>> @@ -89,12 +91,12 @@ struct dw_edma_chip {
>>   	u16			ll_wr_cnt;
>>   	u16			ll_rd_cnt;
>>   	/* link list address */
>> -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
>> -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
>> +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
>> +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
>>
>>   	/* data region */
>> -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
>> -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
>> +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
>> +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
>>
>>   	/* interrupt emulation */
>>   	int			db_irq;
>> --
>> 2.43.0
>>


