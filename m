Return-Path: <dmaengine+bounces-11298-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mKu+JwGcJmrTZgIAu9opvQ
	(envelope-from <dmaengine+bounces-11298-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:40:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A22FF655368
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UmxlxGC7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11298-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11298-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11A0E3027632
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2225E3BBA1E;
	Mon,  8 Jun 2026 10:29:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C634389A;
	Mon,  8 Jun 2026 10:29:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914552; cv=fail; b=eX0HTHLfk+7uFoCf/2RGkmjxuLiru/6eaGxxVRuev9DmiCWh0WxEkV1MdCUiypr2pZimMk9g5vsxu/f2hKB9uZl52eQZr8YvkV3FMPi0gjYQRE4XFyUtYjIF+dr61EgfKOb5l4fw2mKH+qfl1tAIdTrZ1ryoWMKygMNbJSy0xLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914552; c=relaxed/simple;
	bh=vj5XfO0yesDI6JiKv82bjhw1bhMzqUAaxQQ6/u2dgzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CI58ph3GB5rVWh8y4pX/GgS9yU2LBZnWCnAiykY73MKtLFHb5ZydRWT2Dn0XBSMKGmp98JF/GizFPhYBo+ybcjK3/AsBNp02RFBGhLSW/5DKsZgwQ5cUwqB/JIBOOmdjTW/sVoCeszH8Wqn/e6VNnAH3gisXlPmcMy2Tv4G9RLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmxlxGC7; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7Smrp5A2oHmmWC9fsQrHS2wX+l1JzQ6a9GpCbhRAITddN+OVJbivDCaWK9eUMXxWuAoqFzIEffOT1NDCHxr0SXsFL75rkCcGJPF1G7L7ulfMcwPnyLVKIG0A0+0S4dkaB6VnLilKsTIkrvP1yeyxI7FALuq+6DljNqWlS4oU/Y0x8kj5fHiP9v7zHkouCwGLLT6TfkOie+2dxiE6U1iOM5x9ql43VurUXpCYRzihFPeTNjtFFKYMEtqP8PR6G1oQyAPgm1zUw2nMdcX+3wkYNZzI0FFJ7fIGcWYVIU/V9zFmFsHcAEsrzAmNxYE4K5hpD2EbIILEoq5qkpJvFvPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFpG1OVApXuwlXaIdhCuM3P44YYPcIKWgn+UOJafuHg=;
 b=Zu8mhGoqfwoHD6Tpaml3wKpoiG6AoVUljI0e1PeSqPEUCKaBrIDvbuRp4/7uG2YXSHJRQQISYvYPQfwqPKG3mmngCJIKsrZJmOqnVa65ixj5eBiF/bI0VgvWo+UcNYVBrSvaxCoQEUuxQx1/CrHiKUXJoOSRHB6PY90dfqUvEK7pTU/i4oZDXT+aUf3I3sPz8/RLPrSqEUprvJU6oqJQYntVn78LaUzeAp1hSY7CmHX7V50LEZ7KOKjQLWktzotRTO5RU01L4uoPB/xVk2trE6UONeb8A53b7hakAWW6TtXSpl6uKEHhgJZ7brR9l343WXMq3LDgxth/bKrPYmne+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFpG1OVApXuwlXaIdhCuM3P44YYPcIKWgn+UOJafuHg=;
 b=UmxlxGC7fRngzU/lmLrTxCtY87jazy1kYj8SCUv13Dp58OtvDqLPPKOXStwWJ6VZrzmvPsXtdJvR2kY37bTIiwNvT5Q5d0sTC6ujF3eGre1vS64ONJ+endpoCRuYw43lWX4e3Kq3dgcCmTt2Ca936AJChT73jI+OlwGipAFaPKYKah0XFz91ws9Eh6i+rvuy+LjwSrqN/fVH94xJcdYdwCyv8FVC0g8DEcU5yk5TNjglpTZjhz5SfPg57lAV3ThGfUivVxfvfQNHm1MauOHoj8xQ9+G0BrQDfZSsGdFfZ1yR3k9Ru2OSICrAm1hmIlCSdmu0ZoDDB3SyncgJqHTVlA==
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PHXPR12MB999234.namprd12.prod.outlook.com (2603:10b6:510:3ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Mon, 8 Jun 2026
 10:29:08 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 10:29:07 +0000
Message-ID: <65416413-d307-417b-91ce-51d6357552d2@nvidia.com>
Date: Mon, 8 Jun 2026 11:29:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dmaengine: tegra210-adma: Add error logging on failure
 paths
To: Frank Li <Frank.li@nxp.com>, Sheetal <sheetal@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, Mohan Kumar <mkumard@nvidia.com>,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512092508.1406119-1-sheetal@nvidia.com>
 <agOInxpOCTgX7dwi@lizhi-Precision-Tower-5810>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <agOInxpOCTgX7dwi@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PHXPR12MB999234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f07bc00-3ff6-4a97-ef2b-08dec548c59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|6133799003|22082099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r7bEbQD7h2KtVrR9GMWX1cnfX4blxL9roDJP81SmterGHnCvIL55Fnu0E1n2VHI/t11QFJCe2nv4SmsGWen8aw4DZPXnXymQsteevETqo5kABtHsWopL/FpFdvQ/FjQ/vO0xv2EgQ4e5dljqu+mgrMdOUr5Qk0NNrndcQGWpjOYpWSKhTNyfkDbm0rjmRynkeMuxmTHB1aXzWZ+LzilW3QWC7U+frnohzBLcfNim23iBIGUpaDeCg4fQ5YaplFNpoPVAiVZM3cOs82lKCB8qdB140NPjTNAbTxaqNQuPCykyeqiuxQbyAQFp9rTjUcGdIo+apxQDSI5iQfyRzpVkRpm7a6gvxhOYjD5bb7zCVO2KyBqxTSasYjluk3kARyJlJ8W9oXqnycr/CdFxAM+qwci99F+QeUeAHLXVROBfzQZl6Hq/BZHTs129cHVBiEaiBaJI3WOfYuBRcANz8ZxXjLU7dOo5Y7+WscGfXhZ7eYBrwngU401tq7nonncnH6iavo8yx2ZZZhjJmKUzAUsbI5/ft1irItkOBz42ZmAX1tMJUWN28Rur1cfFgmtLUy/dM4/FPpJIEhJtNvMbGVI5r7yndBd3dQZvH7QuaEkDP9I1zI2UPoJomY4AEUwb04ps1Q6YVJd9PsFNeOEgQA1aXIglAe44oJfA6W+q6MJspkw7vWKUQjE+D00JuL8dIsGH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(6133799003)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGpBbEwxS0Y1MVBLeHRGSnBjMHp6VWduV1N0R2I1NXphS0s5M09yQ3RQUGho?=
 =?utf-8?B?aGhHSm1aWWpZMUJ4RWJBZEw1a1lXNTNVMmhTaXdiL0FibEJjTEcydGViNWxX?=
 =?utf-8?B?TjJkQjNMK3NLNmRLcXNOcUFpT2NXSVhKTUVwT3BBbms0amcvUmtIZGRwdlVP?=
 =?utf-8?B?YXQxRHZVQmp1S1J3amNIQjZocUlqN3VLZVIxZTZrUThqOUcrVGF6WjNkeGlP?=
 =?utf-8?B?amRpbkUxcDR1NnVCeHpqZ25Ca0l5T2FHZnE2bU11bldiVFV4cVBZY2s5TDFR?=
 =?utf-8?B?TlpaT0h0UENGd2pEa09QMVFuMVd4WmtlY2NuZjhLdFRRQnovOVlhWjRpUm5R?=
 =?utf-8?B?dHE3VXFkRlZFVzZiZ3FmaGxiVEF1c3BDWXNwS3B2enNnZWtlcG1MZ1VnQUpx?=
 =?utf-8?B?SjdUdVNtTi9jZlJOMHc0QUZ6aFB3Z2JtMlAwSEc0bmd6b3QyTGhlbzNyS3dh?=
 =?utf-8?B?QXA4ZWIzRmhQVG9BeVJ1dnFvLy9aZHJhMXIvYm02RnlrQjR3a2VZQkZlcWtn?=
 =?utf-8?B?N1IyYSs1NmhwVndUd2xnZk5MK0htaEpoZ3pLM2VKL1dadWRmSlZwSm9abUlo?=
 =?utf-8?B?Z3FCeFJvVm9WREhhSzVtTmV0REN0ZThKR2pKZVg2eXZMblh3dmpEalBwaHdn?=
 =?utf-8?B?aWpEVk1CYUdzZ0FEbmw4R2NtTnc2UXY5Q0xvd2N1eDFlRFQ5d2lqSE53Uzg3?=
 =?utf-8?B?SkR1dkZ2NkMwaVhjSXdmeUY1c2RiSVE2cWlPVCtoS0JtZ0VvU0VwMlpncS9I?=
 =?utf-8?B?MUFkb2FXMjJVb1lGVmlwR290ZTFhNEY5NHh4TStDbG5ySWVwamwycFpPbndI?=
 =?utf-8?B?dW55QUZScWp0NFF5Zm5QSnF0MjNsQ2hjNXBzamhxdTFEOWNkQ3pVdGcwaXVF?=
 =?utf-8?B?ZllJZXJpaUVtTk85dGloUGY4ay9wVXFReDlsUVcvbmhESEVHQU52bDhFb2Fq?=
 =?utf-8?B?Mko0TDUvY0FnR3owK1g0dS9sUmplZ1VCZVFBd3NqeTNhQWRYYjRyVkZzUTZI?=
 =?utf-8?B?Q3pvTFFTZm51RkxaNkpSeC9neUlsQkdOYy8zQ2RVKzYxUktjTWtIaG01RXBL?=
 =?utf-8?B?ZkpZQk5yY2ZpSWRsbGhVOXpFeWFLbVNDV3FOUWM4KzZRRlFVMENlNnBrdlMy?=
 =?utf-8?B?Z2FJdENONnVCanQrbVN0Qzd5NjlIQldJNG5uSEJZWmJMVmdDSlp0SHVmMVJi?=
 =?utf-8?B?WWI3RGpsRUhQY2w2WEZiNVhBYmgvSDFBVGVaczV2cVArdEFqbjlhY1FBV1d5?=
 =?utf-8?B?NjJGTUhYYXV2eG1mTk5BLzdoR2xyenBUazl3bTlsL1dnRFRPMWV6TFZhR2Y1?=
 =?utf-8?B?bHMvcXl4RjVrd1ZVa3ZBSmxSYVNvYm5wWnhaeWh4a2dZdG1xdU5qWVVEamFF?=
 =?utf-8?B?Sk5PMnNMMm1lcmZFb2ZVMSs4N05mL3ptM3prSGNSSHJBc0Jra0hVZFNndnkr?=
 =?utf-8?B?RW9XTWN5TXF6MnFlcXJhNTRraE05cTAzQXRsREp6MkxwV1FINFVjQU82ajlR?=
 =?utf-8?B?Z0N5UVJCV3Ayb0xNS0JaVElPVGRlcGtxa3phQUFudUhUZmprTXluTlVNaXhj?=
 =?utf-8?B?dkZ0aFA4V0NxT3VYZDY3Z2ozVzJ1ZUNxMGpibGRvU2xCWElXdUlITFQ2QmdN?=
 =?utf-8?B?dW1vOUg4dTJBZUZNQU1jNWozRzB1RUpWOE8zRTJNazFEam44V21pRUhSb2Z1?=
 =?utf-8?B?Yjh5L3JrSVVwWTFaS09ObUFKZzNWa2xOYU84UDFUeDFYMWZZRGxabXB4azdP?=
 =?utf-8?B?bkhqYmRKeGpiSFdiYS9BZDJxQnFvRjRCL0dlUzkrRjQ2TjB4TjJtL0VyUkw0?=
 =?utf-8?B?cDJrTzRuQnpiTTFpRTRJS1pCQ3pLMEtGbmlpTG5OMWl0QUdNb1JYcjU3Vlll?=
 =?utf-8?B?cFM1NlhjTFJCa3VwK0dLSVpncEd2dWhxc1g4eWg0aXIrRS9WcFNCQXJUNjlP?=
 =?utf-8?B?d2NvNVN6Z1EvbUFTYThhNWpvbEtrTXBYMGY4T0dvTGUvTHc2U20weFNNKzFs?=
 =?utf-8?B?em1yeUNSSzJ3Lzg5Q1RMS1ZMKzNrMFBKS21NOTRCVktzb2xaNlRWTnZIdUgz?=
 =?utf-8?B?RDNwdEJ2RkpYLytnSFlSV09VWFFCbjg1WGtITXkwTU1nNldQOFZVUHNDWUM1?=
 =?utf-8?B?UUYwcEdpcjJNWXdNdkZZUldQSGlYTThKYk5peU5rd0sxM2s5aWJxYVF4QWZ4?=
 =?utf-8?B?cXFnaWZ1ZDZXbDJtY0lDaDY3aVdQMEh5Ykc4QXRsRVZxejFZQ1N5cWl5aUJl?=
 =?utf-8?B?ZDMwNGhkaUVPdldINWI5R0ViZ1JyQmVXM3dlTkh1WmloRXBrYTZEWVZhek9L?=
 =?utf-8?B?TW1HN0RXaTcydnBKVVlvNW0rQ0xGT2NwSEozU3diY3JhRkVpU2xuS0lTZ2NU?=
 =?utf-8?Q?Qp84evX8IpLRDeF/6HOPebCebH9A/Mv/a7AH20HitSXJR?=
X-MS-Exchange-AntiSpam-MessageData-1: Y5xc4riEQLwTKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07bc00-3ff6-4a97-ef2b-08dec548c59e
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:29:07.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfd2aIMkfKokH1dYYICaN/sLTbjACRdsnM6vyD3DhSNsPQnMHx/3p1ut52DTqrTahZL57cLpf3Zuckka30lFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999234
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11298-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:sheetal@nvidia.com,m:vkoul@kernel.org,m:ldewangan@nvidia.com,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:spujar@nvidia.com,m:mkumard@nvidia.com,m:dmaengine@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,nxp.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A22FF655368


On 12/05/2026 21:07, Frank Li wrote:
> On Tue, May 12, 2026 at 09:25:08AM +0000, Sheetal wrote:
>> Add dev_err/dev_err_probe logging across failure paths to improve
>> debuggability of DMA errors during runtime and probe.
>>
>> Use return dev_err_probe() pattern consistently in the probe function,
>> and dev_err in non-probe functions. Also convert existing dev_err calls
>> in probe to dev_err_probe for consistency.
>>
>> As part of the probe-path cleanup, use dmaenginem_async_device_register()
>> and devm_pm_runtime_enable(), and add tegra_adma_irq_dispose() for managed
>> IRQ mapping cleanup. These managed helpers remove the probe error unwind
>> labels while keeping the remove path minimal.
>>
>> Signed-off-by: Sheetal <sheetal@nvidia.com>
>> ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


