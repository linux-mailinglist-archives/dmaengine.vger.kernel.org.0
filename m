Return-Path: <dmaengine+bounces-10298-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L+nMIsYAmognwEAu9opvQ
	(envelope-from <dmaengine+bounces-10298-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:57:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05C513EC8
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74DC43025309
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B55453486;
	Mon, 11 May 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hZh+hcFz"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209936D9F8;
	Mon, 11 May 2026 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522130; cv=fail; b=uG5KBKMhRYCTbiGJxnIcis/xkj0MOJ4FwcRjSN+KaBnzni3AWaypwLrt+aENtuznjGFa4qbtSr6pZPzvDG/2e/Bht79FHn3Icb/3JaT1IcmZvOJ8TNATq9WTv+wskcNrIIkZZydnrHwCRDVrddcLqyonh5i2eLkD6aoL2s5+6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522130; c=relaxed/simple;
	bh=VTXAtXg/oekZxQDKx31V7DtosnQaDqEFuPS545G/K7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2wUicNclCl9H25VGudGq8j7crJAKlAEF6ESWURA/UM/ESp4Gy3slHZlyQEahdAL08aSZcVFScJ1rd6+5OQ/hRQu7by6qP1lgnznKU0sAmJ2IvS6477fKgAlpcVLykEFUUCeYg0rqFKuOqIc4v37U0qqDHORiMc53wjQ5ecWbVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hZh+hcFz; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xysJptIXMaTUfU+hTbz+uW5QgNeTMKxY5aJFKbIeJc7RVkveTDMcmbvteEvEz41oRh8cTna0htqKfJJyWX8F7ILEsNhvJJ431pHlBq+8bwvAl+IbVCuTIC2eNomzRJj/AXRsGKHotUzo1kgad66dlfWWfKeh1upYEW0u9npuuBJ6crgSYqlhs1ntVNOukb3FJpIL0YPtesWEDzNWW4hl3derzndn1+k1tdapTpkltVpGo6G3lY0RjOWgFO1pjpKELlWM3QteBq2gh/W3EsS/a+fhlSIW9a0n22Gs8nxXSSMG4w6u3HMaeDp5DYbhpBAAlhHFza1TBssQO5JoW4dvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAoP9I2mQWJW6XPVtCHe8WcUbm4bm9nrK9aBpH3T4Gw=;
 b=wDTbP0IgB9Y4/02hpqhFFCHiK5GggIN5cGkoegZav+bdjLasC92NQ7GsJlM/oFlFvVHyUSaB1cLdfmixeKl+eCKusdAtpv6R/tyLkP3U71jFr0yQG8bgIbTlzg6Bql74LUh2qan/HRpvnYhO+FQh7A8thLNwviUSctMsoIj+HL25l5XHaJoZD6PvMD1g+aFMbKJaQ9ay3KWN/QtbGx1yaoC2JgY/dhdVeNYuon62Z81BOu7MK+Y6t8eTGMXTuaAIFvQ8xl9UEoKlg7Z0qGKPZVWMe3Vlzj9Oq3dakNzLjY48vn1KqMp+ErHgkXzWFEkbCPqQGGikDD6dw+yUgb+dIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAoP9I2mQWJW6XPVtCHe8WcUbm4bm9nrK9aBpH3T4Gw=;
 b=hZh+hcFzTfuEdke97eB3oAYuEk8+x5ECJNxGLEI3JAl5CvBlaawl2rtvtDOoxqyFy/LwJoYHwZjbc1N+iC6EDhvmFQCZo1vhRN5z8rq+FTAK/eCHXeyviX2qaozRpClFMhZ1Vfxocg/d4S7ZnVMj7n48xutGuFV1aoEWPGwLumk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:55:21 +0000
Received: from MW6PR12MB9020.namprd12.prod.outlook.com
 ([fe80::879c:bf22:f7a0:e8c8]) by MW6PR12MB9020.namprd12.prod.outlook.com
 ([fe80::879c:bf22:f7a0:e8c8%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:55:20 +0000
Message-ID: <37fdf21a-3c6c-4b11-9b97-e84f86b702b3@amd.com>
Date: Mon, 11 May 2026 12:55:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] dmaengine: sdxi: Add client context alloc and
 release APIs
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-11-1d184cb5c60a@amd.com>
 <aeXhkIZgwGttlJB0@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXhkIZgwGttlJB0@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::18) To MW6PR12MB9020.namprd12.prod.outlook.com
 (2603:10b6:303:240::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB9020:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 61472eab-b55c-4ad6-0158-08deaf8677ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LkkbSrYtAKgYfsLb7X9XArM6ygs2oMjnQQGwCOXzeATBafMC/CEdcf5sozL9GhX/qH/SgCSmjl0sGDw0Dx/fbvcCBoyl7LUEK1mNy+g2putkuKRnfV+x1m0SKkr6bL+P4GRF/ThtHr5FYlgX6pii2i/zsHl8UlIpi1BVhhG6Bc86Xif75XKJqc4XZa6fUT9M/F/l4A74qJ1yVzjncr8jv/5QpHsHiBsHpHFOrjK+GimA+SiHKsA7vsKRh0FYCAIB2infIx9r99An8zFLpQEe6I48ldJyND28vw2dR+ofCoFnoiWvQbekKb1CAq71yY0USJNBiZ+vcjTMzSuZRkxo3pZOdHcEaxNlPqt3rJK+M9Z63xmEmyqoHY+UuH4888gt1deO2OlJ2/tGHoFLQ/598spMGNhNnvjyL4truTi/vvPXZb3pwSQCajzZvq41k9d6Pn6NJaO06SX729m44KvpK1pWKTm71Q7fZKqzP4g1FBghSNWt3EOKODHcG4zcn4tO/sqpEonf9ErlAndRb3okjm8PwEJMcC/SKWzJLuqZiK+H/jU39blk0BmHmqP5/ZBz/k68F5RlQ3ctaIG8wmcAUssCifQV5rIcOt5R4yK1byqoCzLJTafgZ/VPMCuPcT96Nzgtgxqao1CX0rQxKpE7p5C8ZDbZ9EzueFpJidVk+iRlI6LV4RwLCnUjOMOIDUKj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB9020.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTU0RXl6Z0h2ZGJ1STBDUmx6WnpPb3RpSW1VazRwMkpNekpRczljZDBnTEx2?=
 =?utf-8?B?eFlEbHhMUm85dkU3RFFNMm1QWGJNb3JlVXFPblN0QlkvSEJ4TVp6Q1hXTFgx?=
 =?utf-8?B?TUdLY0JKRllZcVZ3bVlHaWs4OEpnaVY0ZllEcW00eWd1WGlCU011TmpzeGVI?=
 =?utf-8?B?WlJQUTJKS1RjVytuaGpDREh1ZG92QjRkOFdmU2d4R0sxYWxOc3VGWTlDZXBk?=
 =?utf-8?B?UjVYWjloUTdnNzNKRFhZT1FROGhyZ0R4NkFUbHJIb0FJaU5KRDlJb3RaMTZ0?=
 =?utf-8?B?U0twU3M0eTBpUXM3bmZ1akFHQU5yVDlxb3M3dHhPL0N6S0cvVFowaVlkcTlH?=
 =?utf-8?B?WlJJQVFiUHBnUEdLd1NBVVlGTUtaaldUVktpRVBISlI2V2c5VW1YUFlITHpV?=
 =?utf-8?B?SGNMdzErWGNOc2lIU0FtK1EwYlRzcWFTdXkrRzZNS1FkNldFQkpIS2N3c2ds?=
 =?utf-8?B?c0IzM3hCNUxabzg3Zlk0WE1UOW9ZL3pESVFKdnIycjhhNExkeEFSa2tHTU9H?=
 =?utf-8?B?VFpBM1FqYmxDeksrVGI2bGVENldRYk1mTW5BOUpRTlZJdmxha0NjdkQyRHFF?=
 =?utf-8?B?U1lJWUUyVlJaWG9JNzh5T2tCRTJqbHhNNFB2VWo4OStiOUJpMUE3NGJ5cVoy?=
 =?utf-8?B?WTBrY3hSRFBrVXpOU0ZiSFYyUlB2SGZaR1R3TzFPT1JIWkcxRFBJZUIxdEQ2?=
 =?utf-8?B?L05zN2ZGcEFTOUtQOWlkMjNVbnprdXpoSzFHUDc4c281YTNvUURoQVBYU0dx?=
 =?utf-8?B?eldma3YvUkU3RmJENjhSSkYwQytjUjlpRGRrWHpSazFTaE1JSjV6cHFUUlpN?=
 =?utf-8?B?bDJsbFJQcFJhYVlSZi9WOW1QdmdhdXpoYlhoNjB1c1paRGdwbnlsZ1JNMTd1?=
 =?utf-8?B?bXhMSy82dEdzMHpSaW1jTDRCWG1Xb0VRNHZlY1ZRWDNteGxXZElGdXgwdnA3?=
 =?utf-8?B?Q2hKVHN5SVQ1c0dyTGd6QzVLRzkyaXozSTR4a3ZMZFRqNGQ0QkNCNWorN2FT?=
 =?utf-8?B?NmlyVlg1ajFsVkRPTlJ6emVWc3g5NlE3TmV2alZNaS9QbjVrbm52L241S0hq?=
 =?utf-8?B?QTRjRU1GdmROalU2cGlMWk9tMC9VbGYxSEhFWkJ4YVNNSkNGSDRzdGNCQXBE?=
 =?utf-8?B?Y3E4cmVieVlkMDh6dmYyQzYyeW1rS1ZnclJRb21YbkJNZDVRdG1rdkZNZjFn?=
 =?utf-8?B?YTBHM3o0Q1FqdHc3YkVQSloweVBYTFA1YjR4V2tOd0R3V00vN2ZUSXJXOVBi?=
 =?utf-8?B?QUh1NFVkdTV0NThaS1N0cUllbkQ3NTBENGZQY1EvTVpVZEJEaFBYUnB5dGRQ?=
 =?utf-8?B?K0hPd1Rmek1uZ215c2RtQk54N3NHbW16QzljOGcveFNjM3p6QkRDTTVldnNy?=
 =?utf-8?B?dFVSc2lCQkt1dm1KQkxkU2JQSEFiTlh2S0w5cUpVM2h0UCt1VjFrQTZzMFFx?=
 =?utf-8?B?MzAwSHAyQ2NEZy9VbzZuSExzWlFpZkZNbUlsN2loS1hRemRTTHhsWnJ4M0Zs?=
 =?utf-8?B?d2t3K3A3SkJHc254TUc2dm9LR2ZOL3pISUYxVjlUS3ZJbDl6V3dPNnkwQ2gx?=
 =?utf-8?B?SDdWNUx0L1h1ZmEyaVhScFFxc0JzTVc3Z3RKNHNJUkh4R2h3YWJ4a0Y5M3pt?=
 =?utf-8?B?ajcwZ2J4NnBrMnR1NmU4NGtGYkFSQmF5VFh0YmlMR1I2VVdJUWY3aFBaN1pN?=
 =?utf-8?B?dzU0UzVaSU5YUDZqNXE0QWlOclRZcWdnSUNYVE5KcURLU0pTV0JnNnlQU2Js?=
 =?utf-8?B?MFhLOGVzNGpTVHZtQlZRUGs2STQ2bnVsNmtKNURmZlh1SmE2dHN0RTdHZnQ5?=
 =?utf-8?B?T0d5QUpFZ1JEYnUvNEZRZkZyQmxDcmxLYUFNNFlFZ3lIT2NQTmt6YWIwc0p5?=
 =?utf-8?B?THVDM2w2b0ZueDM4L0wrN1RLeFYzRDhJemhHMEcxZzIweEl5QkhUdzVtRGRs?=
 =?utf-8?B?bXRxeXozVXVqTTI2WGEyUnBBKzNLRTJVcjExY3BscGFxbXZSdnM3TklPYUN2?=
 =?utf-8?B?cUU0aG1TeGZrNCtiMTNzYkRINHhuYWQrOXJHbXNSbW5aQnB1cVZXcFdGOUxT?=
 =?utf-8?B?b1BpZXNGQmd3ejBVNmpsaUlZRUhHZU5IVFpnUTI5TmNrVEFDOWtFTVNQbnht?=
 =?utf-8?B?TG5KY1djanVVc1k1dEJxanRPK0NOWDRKbVZWSmg5Y3RrTlpYcjFRdHlyM1Bu?=
 =?utf-8?B?U0JkQnozUGpxMTJoMUpKYlh6UzI2eEk4UC9nVnBnaGNrUG5OanJRYWl1czNh?=
 =?utf-8?B?Q1poU09zUUt1eTZuVWRIY01mYmdnYXZEMFdZYjhLQ0dLMXpnNUlMMnZ1ZUNr?=
 =?utf-8?Q?Fim0vw/Suqg2YK59w1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61472eab-b55c-4ad6-0158-08deaf8677ca
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB9020.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:55:20.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUUa65wQbt+CIpcXIP4yTT2ye6nKwPpw77F8TCqRk2byvrFRl5pDKaoC1TxpZYW9siD5XzHehTkefsAVBDfHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
X-Rspamd-Queue-Id: 5A05C513EC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10298-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,slot.id:url]
X-Rspamd-Action: no action

Hi Frank,

Just following up on one thing as I prepare to post v2.

On 4/20/2026 3:19 AM, Frank Li wrote:
>> +/*
>> + * Allocate the context ID; link the context back to the device;
>> + * perform some final initialization of the context based on the ID
>> + * allocated; update the context tables.
>> + */
>> +static int register_cxt(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt)
>> +{
>> +     int err;
>> +
>> +     CLASS(sdxi_alloc_cxt_id, slot)(sdxi, cxt);
>> +     if (slot.id < 0)
>> +             return slot.id;
> 
> I like use cleanup to do this. define error macro, like cleanup.h
> 
>  *      ACQUIRE(pci_dev_try, lock)(dev);
>  *      rc = ACQUIRE_ERR(pci_dev_try, &lock);
> 
> so hidden detail "id" in sdxi_alloc_cxt_id.
> 
> Or you can refer runtime pm method, save necceary information to "cxt"
> 
> DEFINE_GUARD_COND(pm_runtime_active, _try,
>                   pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
> 
>> +
>> +     cxt->sdxi = sdxi;
>> +     cxt->id = slot.id;
>> +     cxt->db = sdxi->dbs + slot.id * sdxi->db_stride;
>> +
>> +     err = sdxi_publish_cxt(cxt);
>> +     if (err)
>> +             return err;
>> +
>> +     take_sdxi_cxt_id(slot);
> 
> I undestand try to keep id to avoid call xa_erase. but it hidden too much
> detail.
> 
> If only one error branch, using cleanup here have not bring too much beneafit.
> 
> 
> Idealy logic
> 
>         id = __free(your_xa_erase) your_xa_alloc()
>         ...
>         ctx->id = no_free_ptr(id).

Non-pointer types tend to require a class for automatic cleanup AFAICT
but I think I get pretty close to this in v2. I also reworked the
context allocation logic to reserve IDs earlier.


