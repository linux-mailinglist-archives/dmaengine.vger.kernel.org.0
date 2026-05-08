Return-Path: <dmaengine+bounces-10280-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH0UCqzJ/WkpigAAu9opvQ
	(envelope-from <dmaengine+bounces-10280-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 08 May 2026 13:31:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C464F5CB5
	for <lists+dmaengine@lfdr.de>; Fri, 08 May 2026 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87675303E2F1
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2026 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEEA3264D9;
	Fri,  8 May 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3z+d9DCQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6203988F1;
	Fri,  8 May 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239677; cv=fail; b=RKGOzEFEBUm8usP6PFPfK3M/j/0/BdvbOvIpxpVz0oTEABh/mA6sPV4FcokQr5kZMfjuPvDqrKdBxvQLnXoQ4HR1560f8LrwfK9I17zad3p2RhmQOVqrlTGlUjOAwkDXSg5RS6dBr09+mq3eJ8u5BsOQ366DhmXtAfLUa3z3ups=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239677; c=relaxed/simple;
	bh=igpsOStcITAL3FSWMal325hYUQIlASd5NnZo3T5DCP8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ogl4tSWLeMM1ChjJTafmfKETHijYYLPU9IsVrMiX4740/a2/9NB47/uOo77TioBfoCTVgVy1ajPp04/nqE5fSB6qYCcmcKoo4Sim2Y9DP/b0xEThPMB+uS92HPoSwMcoAcPeazccB0c2ugutigph3PfT9A42Ny1Zdz8SmBz0bTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3z+d9DCQ; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVfQmPQtxeb8nGVjcFiHebrtMN1Eb/+BJRwZq/lzvLS2NHQqxca6M3iKtjd9xD1OIfCfs5dGgJ7wqBgep9xTrkSNNjl0010FhIefDMbv5e37kvnstPptFARsFN16ohSSI35pRo6qlB5dcRjKIePsu6blW6LNq6XlglwKpR6HXkYrThees46mcsiP7RtQnPgrRBemRJCCANRFPiFX/Crzq1J4wSthqmlfxa3MImO0Qsm0/6ZMsdG+S5Zl5whwHxPyM+5gHy5V6T7+tsBlxlrZxT9jP+36PhTBx4dlkqYlbIKK6rNhwNwc0N3Ju1iE6hBktK/Jy0RbVKC9O5q1wNhCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se6meUPg80UufpgrD1eyNQ7phEH5lkl7svNvMV/aBfo=;
 b=jNFCgDwOO2cITzYiXCpS+zC+UtYGd4xqCYS9aRfMpCipdwBBH8U7OygvQCSo5XJVMSO+PWTZQt2xipLK+kC3WWlBjHxTwZJWslpbvmVcfO48VkiyWJEhAv2mrTQHtB3A6gbPPP9alZvpU9xBRx7ohA4auXWuRaoojnyWxT8VuJMR8haUlKeTI3BXtapx4wnaYY1QnqHsCpmdpOUGOHCmpq93f3IXbHYeINcbEO3XJlr1iflKI8FRV4wQ+s4nR32ORMFQZhq5VyRtPl9IsG0d2N+OR/cyjCOduDKfVWT6/9XDzDjY7hg58xVXR2fdsBFZ7oFPVtJ+BDFUhWX8jFZNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se6meUPg80UufpgrD1eyNQ7phEH5lkl7svNvMV/aBfo=;
 b=3z+d9DCQ9qIrdiWAm4qGzklSd+R29iHZAPHfG2lgXjexNEaJ6kyn5PrFxrJprZP207twKCrHiyEb1lrE623+fayz/XqpflKzadBzOiiyvqZa8qQe4g3pKFmLVeDRxJiHFa1EOFCw5YGq1akp+1P77GzAvsQ6U5KsKQjws1TVGWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 11:27:53 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 11:27:53 +0000
Message-ID: <2bae4897-7d94-4daa-ade8-7d858e1c25e1@amd.com>
Date: Fri, 8 May 2026 16:57:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Move MODULE_DEVICE_TABLE next to the table
 itself
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260505102932.190219-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260505102932.190219-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0279.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::10) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|BL4PR12MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4605c5-9fee-4e50-f9d1-08deacf4d806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rNsvlNzUMckQ3Nmdn5ST5JkmQPYdbTB9oBdaqh1cd+EXit9LdhFZeIYuskw3MKpEJylFUUDxazJOTngklMXGGXu4i6Zoc4YkYDuFPjHE/pU71zE9vk8AKwCjTW6S2KSkAwyh5lXiWQteBx2nybGyO23hpJ5bFSgefk/RP7lmcO2uuCX3rJfcfuDY8gk91tgoNQJqL6xktkO8MPnP8mTcEnfYML07p1BuHNawaw5MT9UIczrPDDX9tApQ5dTCaFODZQDzO4wo8Me+0vqkurmLzkUWh1T1JTkyMd3qFWCdF6Idc2glubraGRr4Iy5XPojPcLoFfspI+tFrZ5MoSi1vhv8wFQvbgFBL1fiC0STbMk1Y4rheJ62AnxdEnK1nQ44FqS/Jc4pKvzOPCa5E2SMuIzt0zkhUX8eXgXuBZSJsZ7p/XAQPUWu6K1Ku2Qfp+zG4uIQN+Tluh5lQKLsgVYObdubpvQiOVC9zEsEXqv97Ztw8k3G4qa6SeKKNwQ/OASMzAK6ugaEiurBgTOrFw1A5vHsc/zkrYcy2aVi54jwCXwLsZ4dREgJVg6Bbb42DGEF/+c5owgLl0NozaQhw54sB29anXkQeiHjPhsMzuSRqOEwAEy1IjVujgxoaW/iruSDz4PpjhVBhlkzwslO3AMVYQj5Xr5WvIOvvlfw7fLMq6c1m79KkFxSJm6pXPhVMvL4k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXdUL0IzYVlYKzVtWmdLUFJOMHViRitDa3ZxUEpabW5NdmRYYzFOanhDODhX?=
 =?utf-8?B?U1NBUmE3dklabGxsNlIwemM3THRFTEFLVWNGRnhNaFMvOEpjU2xlVlVCc1c5?=
 =?utf-8?B?UnJPRTQ3QTl2Z0ptYmdROWZ0ZXNEMjZXWHpYY2lwdmRsZzh6ZDBBSGhNbW9C?=
 =?utf-8?B?TkFUUlB0cmUxNG1CdVA1WTBBZUlkKzBZMWRvWGtuSE9FWGtKaENPL1ZzOGNy?=
 =?utf-8?B?VE1ORjVYVzlWb3RBeTkyU09FdURkeHdLd3YyL3pobnFhWHBxdjg2K2JhMWds?=
 =?utf-8?B?RDFnN1N5TXVCbGdjYnF3enlseTVvS2plbHAxd0pMRU1zNFJjTUpUNitWWE1q?=
 =?utf-8?B?VHFSSE5PQWZjRm9yWDI2OE1mbmo4SlRPQ0UweWlQRTdXK0NOQmlIUTZlK0NR?=
 =?utf-8?B?MmszUVRnV1RhK1huYmZwUmh4ZWtEanArZVBHODh2SFk2bXFVdm5YdzFZK1oz?=
 =?utf-8?B?d1IydjM5N1d2QWcvdEJVMXNNOW1hdnFJNFpPYisrQWdGTXRPOGc2Q3RNaU9k?=
 =?utf-8?B?R1REVGFrSWFZUEFFRFZxU2pLOTdXSWpDSy9nNUkwNHlqZCtUb2Rnc0FWWDg4?=
 =?utf-8?B?V0x1QnFxOUswT1hpQW9VNk1LNVl6cDh2V1p6QkZjWUFjcENGN29oSThyK1ZU?=
 =?utf-8?B?Ry93Zjh1emNZSG0rUC9pS1o4bGdJZWxnZ1JtaE1acHlibEhOTTJUcXVMWHZN?=
 =?utf-8?B?Q3lDUm5IOHRWY0dCMEZPYXg1czlxVi9ubldSWkgwWWt3S2VvNVJxVkxaSmVF?=
 =?utf-8?B?NmlIcDVHaTRFNzlzcmNXLzFkRVEyNmNQc1RKZGdIQjY1VWtIUERzY3l0TE95?=
 =?utf-8?B?c1dXeTJDUDdXSHJBNHJVNjIyYzZCc1ZZMDNRb3BTdFBNbzl2Z0pEdHBUcVlV?=
 =?utf-8?B?VGtzY1d1bXIwdUFGSUU3bXlybFpPNVlzbDZQaEo0eEhULzk1cE9yK1FPNXBK?=
 =?utf-8?B?WklMM0tpUFd6cTJab1J5UTdHU0xUNktLQlhTTDFDamx1T1VRbTRUQnd0YmdX?=
 =?utf-8?B?K2NueDVBMW5jYm9vNHlveFhNRVV6bWcxdnQzcmVIQ3BZdTYxcnA5eFN6dWpG?=
 =?utf-8?B?alNCb0YzeWVrTCtxelRHcDZNcmVwaGFyTXJTK2VXQ0VXYVNDOTgvOWk3NzFi?=
 =?utf-8?B?Q2lTSzg0b3VjSXBOQjR0dkt1M3ZyVEE3VHhrRHRKNEpLLzNud0lGd011TDY4?=
 =?utf-8?B?VXp3NWNsUTFMUm5yRGs3ejNZeXZhMkx5VkFlUmtVY2pZTWFtNmpXbmRBNHh0?=
 =?utf-8?B?bE1nSUlib2Vqcmc4MkpqQy9YT3FlRFRjUlFUL0dTQnJ4TUg4UGplQjNHNGpJ?=
 =?utf-8?B?TDM4c2ZVQytIVlRCNU13Q1FYQUovWkZpeUxlYXdxRlpML2ErVVdYeUZTc296?=
 =?utf-8?B?VjlnRkJxbUhXNndSRGMyL1B2eTNpbTRBdXhiOWdSUjVsRzNlZXR5elNURkVj?=
 =?utf-8?B?NkI3bVVVd3JBcFpsa01CYUdoTFdvd3NaOGJvV2ZwNVltOStIcmdDbFovRVlR?=
 =?utf-8?B?d3B5V1JnUFBCcllmTEFhWUJIeVg2VnFVU1lzeEZUZWw4clp4eEZ2RURxMlY3?=
 =?utf-8?B?MXB3cEVGTEhkKzFaSlZiM3VxK0h4WVhvZE9DV0Y1c1FqRFQ4M3VtbTZRUFNW?=
 =?utf-8?B?M1RaWmJORVdnZ0tySWlKcjFLZ0t3Z0plaFNMQ1hhSWNSQ3RQMW5wdWpPSGN2?=
 =?utf-8?B?MVgydWFCK0Q2OVhNNURRUU9obVc5aHZ0Qk5Uam0zOEg5WTdvb0tTYzRIaE9C?=
 =?utf-8?B?RDhCdWFSb1MwVDBaalU2c2QzWkVKUS9oUVVEaTNzZHliSG15QlVtM3Vwa1gw?=
 =?utf-8?B?Kzd6WElIRE1SMFZ0Nm95VnRlcUpDQ216VnU3Z0ZkR2NBR245SmQrekhpSEMz?=
 =?utf-8?B?U3JKVnEwYUVEV1llTmJXNWJJSUJManoySXJZMEJqcEwvSjJ1Rlh0ZXpMTmZ1?=
 =?utf-8?B?NDJnSTRNTHpXSzFoWjNSVWhNOGNBcnN6bkdrOGIrNjR3Sll0enFhcEJpYk1B?=
 =?utf-8?B?ZFpKWnJ2YVNtYk5OaEtZR0lnUzdGWGhIYW9qMzAyckdGaGlqM2pCbVJWY1NE?=
 =?utf-8?B?Nm5aSWhuV3ZkYmZod21HQXc4ZTVmVks4VWFRRTdrK2xvMVRnTjh4M0VyZjls?=
 =?utf-8?B?ajhZZGtIRFBpRnp5MmVzd2xhcTd2cElmWEZZRGRmNmJzRHlSYk95TTBnaSt1?=
 =?utf-8?B?YzVFdTZndmtQSGZaNnY3eHFmeEM2cFNXSHcvK2FkQnpWeUNYZmIxUUNQSDVm?=
 =?utf-8?B?OE1VOWFIOG9BdmVNeG0wMjdqMkN4djRYSXB0L2FpY1FyTDFNT0dtT3FOOWsw?=
 =?utf-8?B?L1BPMHRKWUN5dVR3WkxSdXRhOHJrdDVWT0c4M0FlRHVSa0xpTlo2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4605c5-9fee-4e50-f9d1-08deacf4d806
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 11:27:53.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gLnL8n/cclKseemgyexTefVEvHshilhNHzvng5eV0gbDU6nzHIF3Uvk1mXhD+ER
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534
X-Rspamd-Queue-Id: 21C464F5CB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10280-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim,hisilicon.com:email]
X-Rspamd-Action: no action

On 5/5/2026 3:59 PM, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.

Nit - drivers

With that fixed .
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   drivers/dma/hisi_dma.c | 2 +-
>   drivers/dma/pch_dma.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 32a0e95c6a20..28bf818f9aa6 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -1037,6 +1037,7 @@ static const struct pci_device_id hisi_dma_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa122) },
>   	{ 0, }
>   };
> +MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
>   
>   static struct pci_driver hisi_dma_pci_driver = {
>   	.name		= "hisi_dma",
> @@ -1050,4 +1051,3 @@ MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
>   MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
>   MODULE_DESCRIPTION("HiSilicon Kunpeng DMA controller driver");
>   MODULE_LICENSE("GPL v2");
> -MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
> diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> index e9fbfd5a3d51..bf805f1024f6 100644
> --- a/drivers/dma/pch_dma.c
> +++ b/drivers/dma/pch_dma.c
> @@ -970,6 +970,7 @@ static const struct pci_device_id pch_dma_id_table[] = {
>   	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
>   	{ 0, },
>   };
> +MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
>   
>   static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
>   
> @@ -987,4 +988,3 @@ MODULE_DESCRIPTION("Intel EG20T PCH / LAPIS Semicon ML7213/ML7223/ML7831 IOH "
>   		   "DMA controller driver");
>   MODULE_AUTHOR("Yong Wang <yong.y.wang@intel.com>");
>   MODULE_LICENSE("GPL v2");
> -MODULE_DEVICE_TABLE(pci, pch_dma_id_table);


