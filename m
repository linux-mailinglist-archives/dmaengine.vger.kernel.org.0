Return-Path: <dmaengine+bounces-11515-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fihDLCXGL2ryGAUAu9opvQ
	(envelope-from <dmaengine+bounces-11515-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 11:30:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EC685101
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 11:30:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=v74CveI0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11515-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11515-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D691E301AB82
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424AD3DA5CA;
	Mon, 15 Jun 2026 09:29:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89D3DA5B5;
	Mon, 15 Jun 2026 09:29:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515797; cv=fail; b=YxCrrSFwx5CVyIc60xocGwVzBZkou/QbcOarhZw1XnlvvGkDdy9bk5F42ABnk9QG2VIUHuZOgoMXdCKxBa02xnO5YiBqfU3kFenTVOR0zhox6GP+7+KDataV1g5i/ChUJH3A9FeM2/QIVWNxxW6LKjo71iYPQGfWaH/+SV5OlY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515797; c=relaxed/simple;
	bh=GqVlSFGJcIEbwKj5ktMi4YASaL6Dus3Qx8hvKuGIhQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hwHn7IpFbZE5sJgkXXQFBxjh1ayUXkZsqFozks25P67iJTAXKcnmDHhgs9nb3Lsp5YZrRNtUs+yKmFFD0aasfX4NwlyKRFjunje6pITbi92jr4Xpk1BPbRRS0+JlqhiCG8lxbirEr43oDr9a7pMFd2TB7BlxtT6NWYPcKo3l518=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v74CveI0; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWc0nClJGqfu33MoBQENd+vCWgyJd3xEa4+56cl9oZrWV1zHK4LWMtWcekmAjS0toC+MpZjEM/+tIo+hGsJwzuAm0mvaHoyVFwdGbT0Q6drRrapiFXBOmFT8R3OVgtmEKDOEzQypNCLYj4/pMWGs4uDBib+oVHEdm0MUX4KWleALIQBNY590tDUP7q8IP4V6uRwOSML1B4UNH4BLgh+fSp2eF6wr2RTzLy09g3R2uo4JQRjWCWUY684VnG85jQkOswMVeJvBlZWlS1Cpn2+1wNgmK4oB6k7PLa7+r/FUrwWnL7ajLQlVgTvWpHH9XZJJP6HAS2cDyEVTODouJnTsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t29QSM+WLjSDuS+TqD4z1sLdHXZaqgdOjllJX/8bDXA=;
 b=dqHxaK8fgt7KYiwgMNQpirwN2D3A4feL/M2jEh9iKqTTdyNFZ1kZd/URydQ8iXEjbwf7/Udzj+MVcJMufdotVlt759loeohkwFU0e7hYRL8GvagV+hNJkrSK1AJxuwf+ABjq1PeM1RfJyGoAiYPInr9FcLJJiZakpRo/k0yuuqaQ330nGnaYD0xmD55gbp3Owl00ITfF7hAz5EkNUOrGfWfjQBXlsF0ei+ZUAk/gmzTNeTLvgbdrltJx7YzbZwNSS9ERcvf+psENazx10eZd3TaX97Argb4RLy+aelLQEjd7qq0kN/Jselv8vpK9y2NBG8mFokrumZPoZyhpft5l5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t29QSM+WLjSDuS+TqD4z1sLdHXZaqgdOjllJX/8bDXA=;
 b=v74CveI0flgUrOgxqRpTEVEhs27xrQb1ujT9lXSocJ+Mh+sv2WfTnGbrBBXryTrgI9Teufaq7+L7flLM4EJBRLgU8j6ILWJDKp4hRVDSWT25FIKdG7i6JnIvoHljfzyeRL8/3dGetCsNJB7itppAuybyFcaWeeawwYL0xQe7XMo=
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:29:52 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:29:52 +0000
Message-ID: <efa45058-6724-45cb-8b8f-75427446f62c@amd.com>
Date: Mon, 15 Jun 2026 14:59:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: zynqmp_dma: Add per-channel reset support
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org
References: <20260525105042.2249542-3-nagendra.golla@amd.com>
 <20260525113349.68D6E1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <20260525113349.68D6E1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca6aece-317b-45c6-b903-08decac0a71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aInr9agrAXLyvekgtDZQiy4MxMkONSHOqKCGIb9F0YIWRDwngYN/GP4I9+SPrS4n+5tgGxGVvsf1XgPjzPjR9BcFMIb2y2fOylhJV1tf8jYmMESezsfuFo2j1GDYv2UCd4lw+4ajplNgfYQPjiVKR1iqQayf9+av/DIBP3hiVVlVC4rbdcIwlre9blEi1fUIBUUOoYxq6VCwlm+gKLqZWWiR5tX30UdMZo7QRbSkFGovDEL5QdaHgdErr/GGjZxEvD2ebZDDC3xt2zfOjIXpl1kTeVSAsJ5YoEKScx1//VE6c43fFuZjsH8Jjojgv9AOPZmhIJXFFRZflke/O9zCnB04rdLIYsCP/LAxu+w+twqfO9Ib/EPaI4oRUBSudWu/yxILWzMpMBxg/1giDZ7bD6GGsL61CgnI304HLBcTX0b8QpjXFOcH79iB7f/EgjQzT29IVyDxSbqDZwwikbU2D6Mnbhffit2qsiuUpgGjeQzdOq/6DOehko7TIf5rOFe/OHODYcTO7KJuEslziXh/HNadKynK2nY1aSq5eS+xDLVwunqUJgh0TtjihcNFU2FqsXzERo7+UEYNlZhXNmwCwWDFm/sMvrRN+ZqlOBIRNpe6HR0WuAEsWjTgJaQtlTXjs2t+d/PBxztBAK+WO7/qOIWMxPj0HdMcMMBWYw+W78MXKRCtuNsa6VY7bSd11Q56
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpYbkZZTWFnZkRzazRadXBIeisvK1RZMEVKd2hSbXozSjU1WmhuU3p6MStk?=
 =?utf-8?B?TDBQTFhLMkZxMkI0dXlFdUduMHQxZFlWbUQySFdGZDJMeFNYU1ZiZjI0blAr?=
 =?utf-8?B?ZU13aUFIdHdLTXlUb0xwU216cEw0a3RzUUZnakd5R3dtdnFlYTRGOFNpVTNS?=
 =?utf-8?B?VzFVTUhUNXVoUHhYR1BDdVE2Q0Fnd2I0TGFUaXRPWFhCLzNDWlY4aXJLYTcx?=
 =?utf-8?B?TzNxN3lPcktXUy9sTzRwY1c5YmhObCtJdE1DdVFpRDJaNllEeDFkcWlQVnZE?=
 =?utf-8?B?S0VMUFZ2RHBIbXBIdWhlaDhCMmZhTk1TSFVneVZhT2I3cFlwWTJYRkRFT3Jq?=
 =?utf-8?B?WjlwMk9CSmk1bExlRUpta1ZWcmdoNmhEZG1IN2pMaXY1RDJLWkdmZXB4ME56?=
 =?utf-8?B?U09DYW5JT1ErRVNjNUJoT2VUeUk3NC81TXc1V3ByUEt5VEhKcHZNaGFkT21P?=
 =?utf-8?B?Ty9ORlU3NEVlTlk0Q0U3Tlgrd0dPOW9KMHNVKzd1QUlWU0htOElnWTdWWGxk?=
 =?utf-8?B?T0F3TURCMXhHUUdnWUxFVVEwUS9kbmNZTmduZ1MyRk4zOGtWaDRreEtpTjdX?=
 =?utf-8?B?a3hidEh0VUNnc2VUNVhxL2h3NkhPMU1naHA3NWtqSVpkcVBUeTc2WlJpRm5Y?=
 =?utf-8?B?WXkxUVd0b3l5bkN0aFhTYTRNKzRBNHo3bWR1NzMxM2dYZ3JHUWJ5eGlObWQ2?=
 =?utf-8?B?T3NiYmR4TzczK2ZmMCtjVjRPbmE4WHJhT0l5dDB6eFIraDBWQmZGWEFvSFpX?=
 =?utf-8?B?d1d1VDc4YXhYcEZnWnM2bWxDMmx1VHJrWThTTFVHS0Vidmh5MFpWa1BIUXlq?=
 =?utf-8?B?bklhYmxucE5lVjdJRzgydEE1R2lsZnBoVlFSTjRVZ01vNDR0VXR4a3cvbFo1?=
 =?utf-8?B?WUMxUXlyNWFqWjlyT21RaVhTb2hBTFIzOXlzcUpYS3hzUlhUVUV1T1R6SDFN?=
 =?utf-8?B?N1V5ZkJkSU0yOUl6QmJ3M0FHcDI3Yld6bWVQM3NqTnE5elc3UnFiSEdsMTkx?=
 =?utf-8?B?NXZnV0c2UHpHVk1hTXJ0TER5bjg0NVIwSi91NEZBL1l4UlhHcUlwUFYwRThq?=
 =?utf-8?B?NzVRMnh1cXZjTFhOandTYVlDR3p0Vy9VYXVSR2lPY1M2V0ZOWlB6SUZaTXNV?=
 =?utf-8?B?VjlVS3pwRCtHV1dZVjR2MU9SVFh5eCtneEZ2WTM5emg3Wk91cVBRRjROaGFx?=
 =?utf-8?B?Tjc0TDAzeWNpeTRjLzNtUmNQQUFhamJHaGpSY3ppY0lWbXlQYUVxM3dWUWJr?=
 =?utf-8?B?ejBxbGUvNGFFRzV5OFA4bHJWSFNFNG8wcnVXQndKaCtNbm5oSDBvWnVMU1lJ?=
 =?utf-8?B?c003bGhPeHg1eWJTQldWeU51L3ZTOUdHNENsWmxielFhWm1SMHdaTTUwVHJ5?=
 =?utf-8?B?QjM4UTZUdUQ2YUdUK2lOYXpwNnhWclkzeSsydjU4ZllZVzNyakNpME04YlQ5?=
 =?utf-8?B?SE4wc1JubE1ic1FCVUhFL21ZNzFIUXhjNngwZVZUOC9OVHF1RWswenk1b25j?=
 =?utf-8?B?U3FFdmRneVZmaEk3MHErbC9RL3lGa01BVG9lbUQ2WHdPT0dGU3FHUG56bUxK?=
 =?utf-8?B?WlZ1K0FvWjZhQ21sdUREY0FadUpPd3M2Zkl0TnFuRnRQL0FQYzJyRFVZTTUy?=
 =?utf-8?B?RFo5N0g2Y2Rac1MvNG1BUWZBNXFyUWRHbklLTzU1YjRIN1hsNkVHSlhTcnNr?=
 =?utf-8?B?cWZlSE5LUk0yaHdJcjVZZ0Rrb0VaVC9MYXF3RGd3akwxUU5pT2h2T1QrQjZn?=
 =?utf-8?B?Vnd2RUkrR1dqTDd5T0JYRk9jTndrRTQ5WmNKUDZmcTZMekFOTUVXMFB2Nm5x?=
 =?utf-8?B?YmZaQVhyQ2lPeTdFaGFnVEZJSEFaSzJnSGdHZ2FNQW9EcmtxWlhJU3VNUllv?=
 =?utf-8?B?MmxydFNoVHZDcnJBRjNUZ09KVHFiZjlDM1R6bFlVVDB1UE5sVTJkNmpOaThI?=
 =?utf-8?B?alZsQXo5cVROZE16ZmdrQjNCWm8rd3didnJvMnVtMTNzTGRNbTBHaFcyN0Zu?=
 =?utf-8?B?cHhURnh6bXdJb3JBb3kyVVM0TU0zRWcwcERwQW1uQ0RyWXloNTl5aTNNQ1hV?=
 =?utf-8?B?cCt3UE5SRkt3aXNHNlVTZ1lWUkhQbjZwUGc5ckdWNnZsaTlLTDdSWVJSZHBC?=
 =?utf-8?B?UERjNVFQMTlBcllyT3picmxpM3RpaFZXODRzRXpXRnlLV0RsakRGQ3hoMEFT?=
 =?utf-8?B?YnpCZWYxRlZLcGx2Vk1JaDVnQlh4bWdkbG5PalNLdTBOSkFreE9NbFR3eXlC?=
 =?utf-8?B?SjV1dHBFSXdoM0ZERTVRMjN0czFORjZjYW92cXBHY3ZhcDRiZmgrOFVGTStQ?=
 =?utf-8?B?YWZVUHlzKzZVWG9NUkdmQUhBUnluc1lmdVVxa3NQV3k3c3NzU012UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca6aece-317b-45c6-b903-08decac0a71b
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:29:52.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kA1FIHLbLnOKuc0XTogWjy4jml8sbzwVt5el1Rfkpos3V3cVWq+XoZ0CbZGGTLB+9Fuv9MFa+3/ZySCA99vAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11515-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 155EC685101



On 5/25/2026 5:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The probe error path leaks a runtime PM usage counter reference, permanently breaking runtime PM and leaving hardware clocks enabled.
> - [High] Dropping the spinlock inside `list_for_each_entry_safe` allows concurrent modification of the list, leading to memory corruption.
> - [High] Hardware registers are accessed in the IRQ handler without verifying if the device is active, risking a kernel panic on spurious interrupts.
> --
> 
> commit b2d2a678f48614c7188f8d81cbc70143b2bdfc0f
> Author: Golla Nagendra <nagendra.golla@amd.com>
> Subject: dmaengine: zynqmp_dma: Add per-channel reset support
> 
> This commit introduces per-channel reset support for Versal Gen 2 and
> Versal Net SoCs. It adds reset handling in the channel probe path using
> device_reset_optional() to trigger a reset pulse during initialization.
> Platforms without per-channel reset are unaffected.
> 
>> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
>> index f6a812e49ddca..51c831760372c 100644
>> --- a/drivers/dma/xilinx/zynqmp_dma.c
>> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> [ ... ]
>> @@ -916,6 +917,11 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>>   	if (IS_ERR(chan->regs))
>>   		return PTR_ERR(chan->regs);
>>   
>> +	err = device_reset_optional(&pdev->dev);
>> +	if (err)
>> +		return dev_err_probe(&pdev->dev, err,
>> +				     "failed to reset channel\n");
>> +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this error path leak a
> runtime PM usage counter reference?
> 
> In zynqmp_dma_probe(), pm_runtime_resume_and_get() is called to increment
> the runtime PM usage counter and enable the device clocks. If a subsequent
> initialization step fails, such as the newly added device_reset_optional()
> returning -EPROBE_DEFER, the code jumps to the err_disable_pm label:
> 
> zynqmp_dma_probe()
>      ...
> 	ret = pm_runtime_resume_and_get(zdev->dev);
>      ...
> 	ret = zynqmp_dma_chan_probe(zdev, pdev);
> 	if (ret) {
> 		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
> 		goto err_disable_pm;
> 	}
>      ...
> err_disable_pm:
> 	if (!pm_runtime_enabled(zdev->dev))
> 		zynqmp_dma_runtime_suspend(zdev->dev);
> 	pm_runtime_disable(zdev->dev);
> 	return ret;
> 
> Since the device is still runtime PM enabled, it skips
> zynqmp_dma_runtime_suspend() and fails to drop the usage counter with
> pm_runtime_put_noidle().
> 
> Because -EPROBE_DEFER is a normal occurrence during boot, this path can
> be hit multiple times. Will this permanently leave the usage counter above
> zero, preventing the device from ever entering runtime suspend and leaving
> its clocks enabled indefinitely?
> 
>>   	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
>>   	chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
> 
> [Severity: High]
> This is a pre-existing issue, but does dropping the spinlock inside
> list_for_each_entry_safe() in zynqmp_dma_chan_desc_cleanup() allow concurrent
> modification of the list, leading to memory corruption?
> 
> When zynqmp_dma_chan_desc_cleanup() temporarily drops the lock to invoke
> the DMA callback:
> 
> zynqmp_dma_chan_desc_cleanup()
>      ...
> 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
>          ...
> 		if (dmaengine_desc_callback_valid(&cb)) {
> 			spin_unlock_irqrestore(&chan->lock, irqflags);
> 			dmaengine_desc_callback_invoke(&cb, NULL);
> 			spin_lock_irqsave(&chan->lock, irqflags);
> 		}
> 
> A client driver can concurrently invoke dmaengine_terminate_sync(), which
> calls zynqmp_dma_device_terminate_all() and executes
> zynqmp_dma_free_descriptors(). This moves all remaining elements, including
> the prefetched next pointer, from done_list to free_list.
> 
> When zynqmp_dma_chan_desc_cleanup() reacquires the lock, won't it continue
> iterating using the corrupted next pointer that now resides in free_list,
> eventually interpreting the list head &chan->free_list as a struct
> zynqmp_dma_desc_sw and resulting in out-of-bounds memory accesses?
> 
> [Severity: High]
> This is a pre-existing issue, but are hardware registers accessed in the
> IRQ handler without verifying if the device is active, risking a kernel
> panic on spurious interrupts?

Hi,

Thanks for pointing this out.After reviewing the runtime PM guidelines 
and the driver behavior, I believe this is not a strict requirement for 
all IRQ handlers. The PM documentation does not mandate that 
pm_runtime_get_if_active() must be used before every register access in 
an ISR. It is mainly intended for cases where an interrupt can occur 
while the device might be runtime-suspended, such as shared IRQ or 
spurious interrupt scenarios.

In the case of the zynqmp DMA driver, the interrupt is generated only 
when the hardware is active during a transfer, and the driver ensures 
the device remains runtime-active while DMA operations are in progress. 
Because of this, the ISR is not expected to run when the device is 
suspended, and accessing registers directly should be safe.

So, in this context, adding pm_runtime_get_if_active() in the IRQ 
handler may not be necessary. That said, please let me know  if you see 
a scenario where the interrupt could be triggered while the device is 
runtime-suspended, and I can revisit accordingly.

Thanks,
Nagendra


> 
> The IRQ handler zynqmp_dma_irq_handler() directly reads the ISR and IMR
> hardware registers:
> 
> zynqmp_dma_irq_handler()
>      ...
> 	isr = readl(chan->regs + ZYNQMP_DMA_ISR);
> 	imr = readl(chan->regs + ZYNQMP_DMA_IMR);
> 
> According to the Power Management Subsystem guidelines, IRQ handlers must
> use pm_runtime_get_if_active() before accessing hardware registers.
> 
> Although this IRQ is not shared, spurious interrupts can still occur. If a
> spurious interrupt fires while the device is in a suspended state with its
> clocks disabled via zynqmp_dma_runtime_suspend(), could this unprotected
> register read lead to a synchronous external abort and crash the kernel?
> 


