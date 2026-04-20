Return-Path: <dmaengine+bounces-10069-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCcONdWl5mlQzQEAu9opvQ
	(envelope-from <dmaengine+bounces-10069-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 00:16:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4044348A8
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 00:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE6503020EAD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE593CD8CB;
	Mon, 20 Apr 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="joaPu9ns"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D13CFF6D;
	Mon, 20 Apr 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723394; cv=fail; b=dt2h+iy/CVZ/woK7MwO4rlRjjkzNjrvb8toFUOkeIjWaMHAI57ScymSe/p7YTlJA3sJdnXwiEUWQF0nT3VH3mNX1Nh6GPabT78n7SGxjO4Rmw1TXwvjtVKp3Ygl5iIDY6e25Z3+iW1P1jCo7sqUP5GdIz5Vuk+6DKU7Nr6klRlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723394; c=relaxed/simple;
	bh=N4iDFdt3Y2zHqFxBnCXa8by04IlQ5YnoH8Jda9yFVnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P1dtMM/ReIBNK4flZn6jnBOVv6r17NeII68B0i6k5fkpv+HS8IUvFYK36Fzi6lCQF5Kptax5C5INhORvI4PpnjNUOwu/BFJm2vXPqJrdaiDoBYUrguJ4m9BIiptv2ceg79/PlI0WDlid9d1JP26vfZjqy7JGFiuzCA0vMOCwGto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=joaPu9ns; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njifqtz4CiehJV3CGp32MaYzcGKwr3W5KfDXNpZ61Om2AHijD4rc3USZWAF2Zl9Eqdk8GEuM8vq5pXiY/QXtVZtsRMtChCAhv46nqg7QJslmdHqz3vWuTRBCTIeCQ6f1kblJKe8DrKWVwKVVBS/14/CftdDlcINjyLSQ9TiEEX0JnOuB7mZoVTyqPUxM5Bz1qx2tiJq6ZRK+SBv0pigQKcGMkhJsWt2jVh2QDbFRsL6rixM1n755y4qmJmK0S2CiZMv45xkOdx9tXgvub8xMTb7XdmLyPr1pdQYlYci9yyNuqdXD4IV5sRbdSxb4DHRcqDXIz927+iz6NYJG3gC49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h1zy2u9UTQhSI5735iZSEWK90s3aeOdOfkof1xDuKo=;
 b=xCjDbLle0vqAuCq0pGQ+WOcz0+q7Lq07jIzDpd7Q9pa3JAbIveWzq9g4C1/Yh7B3QQXNDcqlhrnTJeSLluOpHCN6t36fUiMvNR61tPVyjQsYt0kR99fv7Isld2/nBN1lGtktCpyPePVsitNNuTnDTRz2zeXfphTsJivGosGNoj+8pBFGg/h5fq1RsaPCuhw62oeVzQcFIC5F+hPdbAWCV0ICtyRnh5GQrT1kLqZFvorS6xpFfCU70FiGIpjkEA2hV8omG8xFIp+kkxoOlqH74sQi2+KOSOjN1RiurvKlN2jDgfEeDzG4z0FM7XbsmpMY++MBA6xsyBuNiXep9MeLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h1zy2u9UTQhSI5735iZSEWK90s3aeOdOfkof1xDuKo=;
 b=joaPu9nsfK9Vv1ypyHApAUrfpQsk6Q4+xdiFwrEeO1Z/L+HEO53jCJEmybxyj3qABGPkp1EcscrO7AzlMWfuo/LL/NAhM3JLXZsKtgBG5uTdkGNeVpim6ZQJcOEvkDZ6bVzhDJuqqp8UZRPzIjYAG2kHU5xSm9xQA/ru1M8tuYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 22:16:29 +0000
Received: from MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57]) by MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 22:16:29 +0000
Message-ID: <67b36b5c-718c-4a9d-94a1-0db790655319@amd.com>
Date: Mon, 20 Apr 2026 17:16:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] dmaengine: sdxi: Allocate DMA pools
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-6-1d184cb5c60a@amd.com>
 <aeXPvc-9pRSNFKAR@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXPvc-9pRSNFKAR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:33::24) To MW4PR12MB7357.namprd12.prod.outlook.com
 (2603:10b6:303:219::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7357:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7865d251-27a8-41ba-331b-08de9f2a7875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QNVGgix3TVgZWOfzFDJT2PLoZ5lZAvrudfPdqXREY/disghETDPcplTElLR3vy5y62h1vMMYJ0uDXNrh1pu40WSoJbfQi2RIFuOPGUg71rx7YecKMTOI6PR7Ve3V2DWqm1XeRA1W7dJOJd5YlStS4s31wZEoUAzG2+cGTgw1nwwYxotKX3Eqn2QqjlbtWROAQpvZMChLkHuZlAAbSPF1y5SaUWESfgcvAJA0JniO8W/RSER7seynqejkn7mcAtkrCwtTLSu9v/6uqJDtiAa9CqR+Dct5753vpcYkt+84eWTWyWX2Jihdae6KOBIT+yJNL/IVy2tzdgvq4j/G9tX5nlALv2nbP3pF7ff9qGdRggkDJQGzOCi6wnbCeW0VRLnc4N/U40cPZCI1g0INgu5KUodv9TK/2tbo2/0totlNWfKGEtn2osIqVA0e+HH07KYxWxxmOfDdcVrMKNH+XY6mswpUJMHpQHz3SYEjLAhDRyx61TmtlIbRL0KIJLBxb/4Htdbs6OCaWNmw7b96EVS18N8bafonAK6SNHDkIhivR+Wp2x9kiQu5MbR8LJgp7W+T4E8Ff2bGtJD7bNVynJN/jjnoeJFJjr9LrO88tSpIoIOduNzuJqJh0ykFjw0ND287YH4NLkgKtvvdhQZ6AEvjuD3zZXdxucA7kr77XXrxkI9rhdkCNhkXvplQS5rYW/Qqa01t7fhBf+AVSJc57e7Je6Upg/+Bv0NlsMcAbr31e5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEx1Y0UranFka0V3anNJZGRTbGNXODlQUWYrUzNWNWpTMVJKUWpSSjVzK2Vt?=
 =?utf-8?B?UHlkbVF2Wi9DcVJ1VGE3MDQzZ2JkV3NsMkZUdFEyeThRSzh5T1I3OU10T21D?=
 =?utf-8?B?dkJVb2xUOW1GejBSbEtRZnNtNXd0Tk91eFpsbW9KYlhiWnRpSG9SYU5UbTdQ?=
 =?utf-8?B?UXlmZzlrRzFubWVBNHNTdFBmRngwdStpRGptbWcyRHNYQ2pkcW1oa2hNTmE0?=
 =?utf-8?B?anlxdVk2WGtWSWczZmRHMmt6MkdRQTh1bXA1empyZ2VOM3kwS2cyOUh0S3kz?=
 =?utf-8?B?aGordTZobTEydzVGc1FVMlh3N2xQTzJia3hXd3lieVlpSjhlTTlmQmVGWUd4?=
 =?utf-8?B?UGFPWDVQNWhxSC9EdTlxeUhuZlU4NFRoN3Nad2lYU280TWpRZ2J3VFcrWGc4?=
 =?utf-8?B?SGwyc1ZyRmRpNnVUQis4a1cyYllnQVlzL0tmUlBscmVNb2RiUDRuR2xOL2Jr?=
 =?utf-8?B?WjhMU3RlUUNRZ2NvS0VJSHVvK1EvNEhxTFdkb1IwK3oyMzgvUU85TEZLeU5E?=
 =?utf-8?B?RmxCQmZLa2JxaVY3eHhwNkF2N25xQnU5NUpxazcyZEFKc2JhQURMZVcwRjV0?=
 =?utf-8?B?ZjVzKzBUVklOdnJSNUlFeWRSWEhtdm5lV2wrTWhOblo5VVdrQTN0aUx1VFNt?=
 =?utf-8?B?ZTVJUW5YNzdVV3h2MnNFNVYwSGtuTTZjVjNNcnNkSWV0NTFjTXF6bCtPbWRm?=
 =?utf-8?B?bWF5Y0F0Q0pNeHI0a01zVW1RVkVJTUdnK1JJUklpdndGcGxDTHpNY29ZM0pG?=
 =?utf-8?B?VDQybzlhYlB0UmZJSmd0U281bmNUZGdEOTZqWGQrWElvSmpyRloxN0o1SUZy?=
 =?utf-8?B?RCtaQXlXYUJ2eVJjTjBnZE5vZmZtRjEzSGZRcWlCeGwyRnlJNjUwUUQveTVR?=
 =?utf-8?B?NVJieEd6VXpIaVkvcDBHSzRLNUNhdGNMMGF5Qzh1WjgrUVBDRGgyclZZTUR6?=
 =?utf-8?B?TDVjZEVTWXhCNzlxMm1OcXZxZDRpY2NsT1QvMkNTTTdUWUxHMDVKUW5YUElB?=
 =?utf-8?B?UlNIb3RzVnlKZ0lMRzVvT0s4RDN2Q09oTWdKbGZBekR1RERNYVpoYUNKV1pD?=
 =?utf-8?B?MXlEK2ZtMExGNitOcEFnUzlML3hXSkREdzU3RXRGMGVlVHhlNU1ZZmgxbk9u?=
 =?utf-8?B?TVd2QjROZHlIeE5QMUdoQmprejl5eHVqczFKY2k1bDBMbnFDZGFYdjNnZEFt?=
 =?utf-8?B?b2Izb1hsbisvVkY2ZnRGQ2pvK1gzck5ZWXBqVG5MdVVKU3B3ZEQ5QXlDS1Uv?=
 =?utf-8?B?WTBVaGg4Z2xNUENjNjRtOGt2NXpRRHVQYW5YamVLdW96YTZLTmRWZzQ2eWtl?=
 =?utf-8?B?MXdNMC8yY2M1OWF4YStMT2RkNVZLUWxLZHFodG1TTitQSHZVUTVSSmdIbkht?=
 =?utf-8?B?RitHcVBINE5yWm1hUTZJOVJYM0N3bCtQb3FFMU5HdEFnODJzWTB6NllCS0gx?=
 =?utf-8?B?MmtWZjJxdVBHYnBjeDhsYjlubzNpbUZqSEMrNlBjMFR3anRIZXpIR20razJK?=
 =?utf-8?B?TW1PcU1EbytVby94bDBEa2F0WnlDNTdxYzl6UWRJcmhHcVFWNHU3aWR1M01m?=
 =?utf-8?B?NzFYcC9IcmFiczRUNEQ3VHViQzE5VGxmZG03VndBcURKZGZBR0VrcEFBL3Jn?=
 =?utf-8?B?elhUYXhqa2g4VE0zL0VlTTZuUTJZZnNRV1Z0aWptcXExUUdOeXpnWk5mc0E1?=
 =?utf-8?B?UG1TQTdjN3NaTDBaM3dCU2k4L1AxZHNoSXFhaGsxelI0ajJFZStuaVR3RkN1?=
 =?utf-8?B?Zy9jUHFjMERXZkN1VDFrZXVxSS9Bd1FZc1RXUmJNMWszQXhrRzhSa1lsMjZW?=
 =?utf-8?B?em40Z2h1REgvTWhjRFZFL1gvUGFzenU2cVJBYlJ2VTVuTllKUnlPRTRpZFBm?=
 =?utf-8?B?R3R6dWpsMGIvTlJwNkVFNHRWREZ2aHdUL04zbW5BM0Raak8zTDNrNDhsOU9t?=
 =?utf-8?B?MDRaODZBWWVaYkYyRTdpemgwRHlLTFFXeW5Mb1dRZHdMaElzWFhYT0VaREZh?=
 =?utf-8?B?S0lWUnhZUWlRK2VHMXU3YzNuVXF5MFhRTGpYeHk4VklxbnJiLzhNc3hXS0F6?=
 =?utf-8?B?RFk1cUczYllwbnBVQS9tMW9hQTRIYkpLeHV2RkFDSGhZSzlCbnZ5MHdIUDBp?=
 =?utf-8?B?cy8vMWZsTGFFWVZNeVZ3b2owV214OE9wa0ZpVHhzWjkyU2thTXVyajkxZUJF?=
 =?utf-8?B?WGcxZXA4WkFMcGNMOG10cm8vNndYb0lvblJjQ1loem5KVjBORERtdzNYeUFL?=
 =?utf-8?B?eGxsQmxaQ2dBcmZsbUVtbmpHMUlXNHpzc1IvczRBSmFxdnI0Ui95NWgwT2dx?=
 =?utf-8?Q?pe6mThzCEPCjm13bcv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7865d251-27a8-41ba-331b-08de9f2a7875
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 22:16:29.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv+d1PQnGsv+VmM+eYt+6Q/KT73b+5kF1c7PLD/E3OghmlQ0CUSLYPBQh8GD7PeWso0EoC4jMHR7qbbfaVz05g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-10069-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D4044348A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 2:03 AM, Frank Li wrote:
> On Fri, Apr 10, 2026 at 08:07:16AM -0500, Nathan Lynch wrote:
>>
>> +static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,
>> +                             const char *name, size_t size)
>> +{
>> +     *pool = dmam_pool_create(name, sdxi_to_dev(sdxi), size, size, 0);
>> +     return *pool ? 0 : -ENOMEM;
>> +}
> 
> This helper funciton is not help much!

Hmm OK. I can drop it and make sdxi_device_init() look something like this
instead?

static int sdxi_device_init(struct sdxi_dev *sdxi)
{
	struct device *dev = sdxi_to_dev(sdxi);
	size_t sz;

	sz = sizeof(__le64);
	sdxi->write_index_pool = dmam_pool_create("Write_Index", dev, sz, sz, 0);
	if (!sdxi->write_index_pool)
		return -ENOMEM;

	sz = sizeof(struct sdxi_cxt_sts);
	sdxi->cxt_sts_pool = dmam_pool_create("CXT_STS", dev, sz, sz, 0);
	if (!sdxi->cxt_sts_pool)
		return -ENOMEM;

	sz = sizeof(struct sdxi_cxt_ctl);
	sdxi->cxt_ctl_pool = dmam_pool_create("CXT_CTL", dev, sz, sz, 0);
	if (!sdxi->cxt_ctl_pool)
		return -ENOMEM;

	sz = sizeof(struct sdxi_cst_blk);
	sdxi->cst_blk_pool = dmam_pool_create("CST_BLK", dev, sz, sz, 0);
	if (!sdxi->cst_blk_pool)
		return -ENOMEM;


