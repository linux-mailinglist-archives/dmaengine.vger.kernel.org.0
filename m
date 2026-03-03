Return-Path: <dmaengine+bounces-9206-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIhSGN+DpmlQQwAAu9opvQ
	(envelope-from <dmaengine+bounces-9206-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 07:46:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48081E9C40
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 07:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB3F30177A5
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771332DF6F6;
	Tue,  3 Mar 2026 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5hcMhOYj"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5416CD33;
	Tue,  3 Mar 2026 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520401; cv=fail; b=hZu9yAgc4/mvSIRNTK4BZ1OiTD9zFisQLuaDcqmKPit2OWmOxKfWohATwv12VTuWmHoQShy7fJP1xuUhb1bFoIXukxcqCg+qhMG14zwABjwqbleB25EGDklXN9AdeJyhnTQYiyJX58IXL/Vas50rew4SN8NDL+iZOQT822xaA3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520401; c=relaxed/simple;
	bh=7XlkVIPukrerF2FTX2W34ykbjdwErHuyramEb2eAXyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=By4Z6psXITGxYiJbJDpkgabELwT+ZZRl9U79UENabmr51NEIEmQlm0GIR9tPrl0LTJHD0StBoV97+A0U0WAb3bFNlabLLn6uMygFSGZhsRfto2EUZaCr9spTpbOPpL64oi2QIivnERMwHS60/lZbBg8LGNefPJ8GRSdPJJx0ZGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5hcMhOYj; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH3KzaEH8xbDbCis5fqQrXo4eOugaXJ0cmPGvUv4P9L9mrFAxyMtmKnSqvbyzj7p6ho9cijOJu91HDOrGpbR71h5eOtR083p2UBLkLGv2C5hlCJJSee3HP0K/fEaUjNDKLGExWavYRuj9I2fsvJtLy9jni89zRlZyAbelPdW+tuGnehfN3li4c5JmbF5L3LKg9jsMwI3YTakYNKEFAvdS2aY+I3iBIB9Ykn+B9qRUSv53TBy39RHyvS1u1L0vjAobM1Iihl71PU4Bqv/4pPqxurs6skaaykInjjI+qAqWXz1eawlTV4WXFrVa6YG8sh6pg6ZOmfhPip+LpG0eCQHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLkcqLpQHcqMNjhk+47E+ZmkyYQBW6NuVr0G8dpZnZE=;
 b=IxyK6Zjn8hScC5frCTvkBYliS2rOWT7z8PIbxE1syvTVnxOIW/rIHns+o+qmzlLpNT3ruGMsixbXXp3f9FFvjsC92zHJIIq0nOUIEcDyM2NxNyj05fHYj5VcgUe0LDuyX1zNau5lfizcdjwsU2tJT4m8xapBZP+Mf1pp3EC1Rbkup4tBc/Bs4yZQHCjs5j/uSNWEGWrOaKqqCTgL/ZxI2DjH61niReZf9AVERYO+lWtKHLWiELyOEtHkBNsmkTPC3MqZbzqybxvdE2/nTv50oXAm54nUuLRkzmNcgZ11kQAJ+nSzo6PVST3XbAwS1s9xHr3UuwKR8+iCIP0exQ/Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLkcqLpQHcqMNjhk+47E+ZmkyYQBW6NuVr0G8dpZnZE=;
 b=5hcMhOYj3IqEGH15yHk36KNgMfdGqOgV1GocBEDyKxex9qE8AWFlZhIa/8EXa96mN4rJ2oZwOrEMufiCTh+b/HT28M+xmhVuTSaaRiGQuVjuvqaW88monL6ejkW4pkP7432KNoom5lOrlzN9vh3a3YELFohMsu2B12cM5BsCp/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:46:36 +0000
Received: from CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::83e8:3732:1f8b:269d]) by CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::83e8:3732:1f8b:269d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:46:36 +0000
Message-ID: <98bc3a1e-27dc-4b05-a949-d8830cc552d1@amd.com>
Date: Tue, 3 Mar 2026 12:16:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dmaengine: xlnx,axi-dma: Convert bindings
 into yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com, git@amd.com, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260225050521.160724-1-abin.joseph@amd.com>
 <20260225-cerise-oryx-of-pluck-8e2f30@quoll>
Content-Language: en-US
From: "Joseph, Abin" <Abin.Joseph@amd.com>
In-Reply-To: <20260225-cerise-oryx-of-pluck-8e2f30@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::17) To CH2PR12MB9544.namprd12.prod.outlook.com
 (2603:10b6:610:280::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9544:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 98da0fa7-33ff-4bdd-fb0f-08de78f09d27
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	sKfb/oHapT7CDejFgSHm0oPXf8ZEEY081AtsGWZD/vDiqw4n4yR7SXPRNCo+FsF8qBHuHkNH6KDUs+TJBYa+mxtpyeDt1h2fVzEgDOfFgPpf0HpwYGRVZZK8Qvr0Jyxh/A0iJhT/DFWYT6K618B6bSn8EO5bKoz4FA0bQW5w3sfV5CTVz/5vsqPOYi2oIWc9IBB5eL38PyLPPw1pcejQ4wgHPCCuVsiwdQ+AmrNyH/SDUH0XwxMSwNF0YrKdNzm91LAastOncFnDr3GlaM9E0cGmABucBzDxgcaRx3oiYIoN6WAUjjLCTS+UMG/DWNLb5vTjm100zCcL7LdZQ8cPyforG3QrBAiEEp303ZmAiQTVSz0obY5wvriSonNCNLfaC7zqSxUdxRPXvJyJy4LbE7T3Abu3RdtKBoMcJ+emnY/MAc6nZB3QKosOu7xMsMk8yQbFydRwlcXE6pdl6qREWu44zmohzTBiBTSkFThXSdB+hVky459TPHF26de342Jysoe9N8w/WODVY7ultMek12CggQM9Pc19b4D7FP9gw7pyRHeLZSmM8ura6K2Xwm7LrStZ5KRFXm9S24aDkSJ1CVnk90d74puhu6xHkbqMSP0SzZz8C5Y8KKKWbLjznteTZE+3u5IaWtWNGNCU1ozoiJergCWPs8nMbqRXXHDtdVfrunxGwz3/zs/+hn4X+bw7WXWMZT6jXlROgbXRRXiwMBfII3cC2a2DRpXZxKA5il4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB9544.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTc1anBhLzVnS1Y2WkhCdkFVeXRqMG9ZeWlmZStpNThRMXg2R3ZqRzY4RDRX?=
 =?utf-8?B?MW5EdStJVmhxWDdlVDZxSW5ITmVrNVRvZTYxcnRtZDZYNS84d1hLT09EUWh1?=
 =?utf-8?B?OHFkbThEQVRpcEJkVGs5QzRBam1DNVFzZ1VMNk1rR2c1blRZL3RMeFp1T0Nh?=
 =?utf-8?B?WkdVTjN0QXd5S1pPNUtVbnBiNk1MQVJOTkRFdkF2REJnUmoxbGhZN1o4ZXV6?=
 =?utf-8?B?emlHRFhQM2hmenZob2F5eC95YWMzKzh4Q1pNMGlZakh2elhHNTh0ZzlUVDc4?=
 =?utf-8?B?QUFOOVBVKzBNZ1EzcGxjZFpwSERBbUlWRDFwNFc2d3lCMlRMZHlTemJ3ZUhl?=
 =?utf-8?B?aVRtNmNYTFllL204RFJRaEh2a0dzY0VLaXhCNzl2NkVhWUxhSkNFUk9pT3NF?=
 =?utf-8?B?M1FZNU1YWE42eGYvR2laeGRzcHl4bjRVM2VpZDdkT20rRVcrRXdwdzBhU1NY?=
 =?utf-8?B?emNvMkYxY2dETFBiRjc2YmxXTVhFVXRNV1JiTTQxY3FjUUFqN0NiZE1iY0FR?=
 =?utf-8?B?TEl0bGQwUnp5VEo2WW80M1M4QmxjMHpjYjZWd2k1Tko3N2sxSXF1aENSaE1W?=
 =?utf-8?B?dVZGbGkrbjRSOE9CNUJRNHdCV2l2ZjhyK0lQSUx4R2lLWlluOEVwREpBUjB1?=
 =?utf-8?B?a2dCb0xpeCtGWUNvNTR2eHQyenV1OVZud3B1YnR2NnBQcURtbndzcllkTy9j?=
 =?utf-8?B?MC8yRkZCVVRrZUgxU2lrKzlGVnZOTDRyU20wak8yM3o3TFZRWEhoU1BDM1RK?=
 =?utf-8?B?b1lVU2taa0oyWTMzQUY4eTlkZ1lpSFdUVlN5VmY3V3VMNlhNQVVqKzRzWVBN?=
 =?utf-8?B?b1Z1TVJiemtBN3ZIaGh2N0F5RFFoLzk2R3FMK3VtaE1Kb0NmUHRaUjRWb0RT?=
 =?utf-8?B?Q2J1Z21wMG5MSzNCQm8yd2xFYjRnZVZhZGFzK0dVcVQzVFFOc1NDYjlESVVT?=
 =?utf-8?B?Q1BKcTE3OTFpejQvY1R3bWdwQmpKT1FPMmlZWmdvOHNjQm1pTlBGOTNTVHBL?=
 =?utf-8?B?UkkxdjZvZTRqRm4zeHJKSHBObzMyMmVPK0k0UjBzdjhOb3c2OG00c1RJZ2Ev?=
 =?utf-8?B?eThXeUV4UmpKZFA4Z0cxalBRUEx5ZXZ5cklHU2hSZkpKMlE2U29lN01UbEox?=
 =?utf-8?B?eU1YeDZ6Y04zd05kR2M3ZDFPaXpKQnJraHpGWklKQ2tkZFhwNmd0SnppS1hM?=
 =?utf-8?B?dldIYlAxa0dITUhuRzk1VDFjU2w2MG00eUdEZzN4WDl0N3FuK2ExcHdreFk1?=
 =?utf-8?B?OGtsMFg5Skt0c3A0ZGV1S3NMZmwrL3pxY09rSFhEYTJwcHZwbHlSVDBiS2s0?=
 =?utf-8?B?ODRrdDhycUhjY2o1SkdRakR3a016WjdNeUNDaWVCTVBkNllGN3JTbHlaMDBk?=
 =?utf-8?B?UzNTQkhlTEZudnJLdDFYSFRDMDQ2QzhkNnJRK3UxODhsOHNIaXYzclh5OEha?=
 =?utf-8?B?SVFlTlNZNkpVUXIzUlQzZVI4MUJsMmMrZjUyLy9RbUJseHVpTTgrNlZLa0Jy?=
 =?utf-8?B?SmtkbXBFNE1GQTFLU0xGaXFzc1d2K2R2MDhhYXErWmxlVkY5TjNNZExLcEx0?=
 =?utf-8?B?Mk1rbDQyR0dTTDFFV04vWDZKTDdqQWJoWWhRcjNTczM3c0Z6QkR3OHRGM3ZK?=
 =?utf-8?B?ZmcwR0FuUStob29rTVRRdm1PdFpSdk8rZDZIem53YkJoRzRteXBITXZrMG9T?=
 =?utf-8?B?MlJFRGFYdDdGT05vcC9FUkRWcXlrQjRYMFQva2JQclM0VkV5ZmhrTWlhaEt4?=
 =?utf-8?B?MG5nVzZiY3UxVDZxWTBMWTFnRmNCYTRIb25Pd3R4OGR6UHRwSGN6c0hUM3NS?=
 =?utf-8?B?dXRyWjVrTng5bDF0YzM2TklDbEsvRFllLzdvWjk5elcraFcyUjJkSjhZS2Jl?=
 =?utf-8?B?WHBzZEorNkNaSGJXUTVlUVhuSFZsVFB2NVAzOHE0UVlNbVArQTFuT3FRVG1H?=
 =?utf-8?B?UjBGYno2R3VLRzRtc3dKNFZXenFTeG56YzdKNE9XT1ppSzBsNzkxT1I5NE9S?=
 =?utf-8?B?aGFzajRhakI2ZEltd3BiTGZuSjhJdDkxK0lZaHMvKzJJWEFVdDlvREc2TmJy?=
 =?utf-8?B?YUZQQnM2UFIzYyt3cW1LL3ltcFlFL3NvalorbFI5a1NLdE1ZUVlDOG5hdnRG?=
 =?utf-8?B?SWJXYis2ZExhc3FkRFZIV2RmWldyMUYva0Z3cWVTUWRoeFdQckdhaTV1bWlw?=
 =?utf-8?B?eGY1M0tkNGJ2TzY0VDloTmJCeDVKbGY2NnBiOUUrTUVRTFlVRDFROGhBV1BU?=
 =?utf-8?B?SFQyeHdoNmVmUnlnYW5Eb3VGSEdNbTJPcVhFK2ZJVjVKby9Oa0ZyaTlWUHRw?=
 =?utf-8?Q?AjqiuGnePe5DZZpP+p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98da0fa7-33ff-4bdd-fb0f-08de78f09d27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:46:35.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZdlnOzpOD5CjTB1APn7EcowxhiMpwdtvSUFFPfNZ1JJgXULSLVw1qBBJJ30Y9vG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
X-Rspamd-Queue-Id: D48081E9C40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9206-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Abin.Joseph@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[2.98.207.48:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[a4030000:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action


Hi Krzysztof,


On 2/25/2026 3:52 PM, Krzysztof Kozlowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Feb 25, 2026 at 10:35:21AM +0530, Abin Joseph wrote:
>> Convert the bindings document for Xilinx DMA from txt to yaml.
>> No changes to existing binding description.
>>
>> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
>> ---
>>
>> v2:
>> -> Add examples for each compatible
> 
> No, why? We did not ask for that and (see writing schema) we ask for one
> example, more only if they are different.
> 

Sorry about that, my mistake.

Based on Frank Li’s comment,
[the YAML schema example should use only one of the compatible strings.]

I misunderstood this and thought we needed
to add examples for each compatible.

I’ll fix this and update it correctly in the next revision.


> 
> ...
> 
> 
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,axi-cdma-1.00.a
>> +      - xlnx,axi-dma-1.00.a
>> +      - xlnx,axi-mcdma-1.00.a
>> +      - xlnx,axi-vdma-1.00.a
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#dma-cells":
>> +    const: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Interrupt for single channel (MM2S or S2MM)
>> +      - description: Interrupt for dual channel configuration
>> +    minItems: 1
>> +    description:
>> +      Interrupt lines for the DMA controller. Only used when
>> +      xlnx,axistream-connected is present (DMA connected to AXI Stream
>> +      IP). When child dma-channel nodes are present, interrupts are
>> +      specified in the child nodes instead.
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 5
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 5
>> +
>> +  dma-ranges: true
>> +
>> +  xlnx,addrwidth:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [32, 64]
>> +    description: The DMA addressing size in bits.
>> +
>> +  xlnx,num-fstores:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 32
>> +    description: Should be the number of framebuffers as configured in h/w.
>> +
>> +  xlnx,flush-fsync:
>> +    type: boolean
>> +    description: Tells which channel to Flush on Frame sync.
>> +
>> +  xlnx,sg-length-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 8
>> +    maximum: 26
>> +    default: 23
>> +    description:
>> +      Width in bits of the length register as configured in hardware.
>> +
>> +  xlnx,irq-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 255
>> +    description:
>> +      Tells the interrupt delay timeout value. Valid range is from 0-255.
>> +      Setting this value to zero disables the delay timer interrupt.
>> +      1 timeout interval = 125 * clock period of SG clock.
>> +
>> +  xlnx,axistream-connected:
>> +    type: boolean
>> +    description: Tells whether DMA is connected to AXI stream IP.
>> +
>> +patternProperties:
>> +  "^dma-channel(-mm2s|-s2mm)?$":
>> +    type: object
>> +    description:
>> +      Should have at least one channel and can have up to two channels per
>> +      device. This node specifies the properties of each DMA channel.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - xlnx,axi-vdma-mm2s-channel
>> +          - xlnx,axi-vdma-s2mm-channel
>> +          - xlnx,axi-cdma-channel
>> +          - xlnx,axi-dma-mm2s-channel
>> +          - xlnx,axi-dma-s2mm-channel
>> +
>> +      interrupts:
>> +        maxItems: 1
>> +
>> +      xlnx,datawidth:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [32, 64, 128, 256, 512, 1024]
>> +        description: Should contain the stream data width, take values {32,64...1024}.
>> +
>> +      xlnx,include-dre:
>> +        type: boolean
>> +        description: Tells hardware is configured for Data Realignment Engine.
>> +
>> +      xlnx,genlock-mode:
>> +        type: boolean
>> +        description: Tells Genlock synchronization is enabled/disabled in hardware.
>> +
>> +      xlnx,enable-vert-flip:
>> +        type: boolean
>> +        description:
>> +          Tells vertical flip is enabled/disabled in hardware(S2MM path).
>> +
>> +      dma-channels:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: Number of dma channels in child node.
>> +
>> +    required:
>> +      - compatible
>> +      - interrupts
>> +      - xlnx,datawidth
>> +
>> +    additionalProperties: false
>> +
>> +allOf:
>> +  - $ref: ../dma-controller.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: xlnx,axi-vdma-1.00.a
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          contains:
>> +            const: s_axi_lite_aclk
> 
> This is REALLY unexpected syntax. You are supposed to have strictly
> ordered list - why do you need need it to be so flexible? And if element
> is required it should be the first item. There is no single DTS even
> mentioning it!


I will fix this syntax

> 
>> +          items:
>> +            enum:
>> +              - s_axi_lite_aclk
>> +              - m_axi_mm2s_aclk
>> +              - m_axi_s2mm_aclk
>> +              - m_axis_mm2s_aclk
>> +              - s_axis_s2mm_aclk
>> +          minItems: 1
>> +          maxItems: 5
>> +      patternProperties:
>> +        "^dma-channel(-mm2s|-s2mm)?$":
>> +          properties:
>> +            compatible:
>> +              enum:
>> +                - xlnx,axi-vdma-mm2s-channel
>> +                - xlnx,axi-vdma-s2mm-channel
>> +      required:
>> +        - xlnx,num-fstores
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: xlnx,axi-cdma-1.00.a
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          items:
>> +            - const: s_axi_lite_aclk
>> +            - const: m_axi_aclk
>> +      patternProperties:
>> +        "^dma-channel(-mm2s|-s2mm)?$":
>> +          properties:
>> +            compatible:
>> +              enum:
>> +                - xlnx,axi-cdma-channel
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - xlnx,axi-dma-1.00.a
>> +              - xlnx,axi-mcdma-1.00.a
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          contains:
>> +            const: s_axi_lite_aclk
> 
> Why do you need this?
> 
>> +          items:
>> +            enum:
>> +              - s_axi_lite_aclk
>> +              - m_axi_mm2s_aclk
>> +              - m_axi_s2mm_aclk
>> +              - m_axi_sg_aclk
> 
> Why this cannot be ordered list like we expect (see writing bindings)?
> 

sure will do it.

> 
>> +          minItems: 1
>> +          maxItems: 4
>> +      patternProperties:
>> +        "^dma-channel(-mm2s|-s2mm)?(@[0-9a-f]+)?$":
>> +          properties:
>> +            compatible:
>> +              enum:
>> +                - xlnx,axi-dma-mm2s-channel
>> +                - xlnx,axi-dma-s2mm-channel
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - xlnx,axi-cdma-1.00.a
>> +              - xlnx,axi-mcdma-1.00.a
>> +              - xlnx,axi-dma-1.00.a
>> +    then:
>> +      properties:
>> +        interrupts: false
> 
> Why interrupts are flexible in other case?
> 
> This should be probably squashed in each of previous if:then:.

I will squash the interrupt constraints into each if:then: block as 
suggested.

For VDMA and CDMA, interrupts are always in child nodes regardless of
axistream-connected, so I'll add "interrupts: false" to their respective 
blocks.

For AXI DMA and MCDMA:
- When xlnx,axistream-connected is present: interrupts are at parent level
- When not connected to AXI stream: interrupts are in child nodes

Since the current schema already allows both parent and child node 
interrupts
for DMA/MCDMA (flexible behavior), I won't add "interrupts: false" to their
block, which correctly permits both configurations.

I will fix this in the next version.


> 
> 
>> +
>> +required:
>> +  - "#dma-cells"
>> +  - reg
>> +  - xlnx,addrwidth
>> +  - dma-ranges
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    dma-controller@40030000 {
>> +        compatible = "xlnx,axi-vdma-1.00.a";
>> +        #dma-cells = <1>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        reg = <0x40030000 0x10000>;
>> +        dma-ranges = <0x0 0x0 0x40000000>;
>> +        xlnx,num-fstores = <8>;
>> +        xlnx,flush-fsync;
>> +        xlnx,addrwidth = <32>;
>> +        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
>> +        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
>> +                      "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
>> +                      "s_axis_s2mm_aclk";
>> +
>> +        dma-channel-mm2s {
>> +            compatible = "xlnx,axi-vdma-mm2s-channel";
>> +            interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>> +            xlnx,datawidth = <64>;
>> +        };
>> +
>> +        dma-channel-s2mm {
>> +            compatible = "xlnx,axi-vdma-s2mm-channel";
>> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>> +            xlnx,datawidth = <64>;
>> +        };
>> +    };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    dma-controller@a4030000 {
>> +        compatible = "xlnx,axi-dma-1.00.a";
>> +        #dma-cells = <1>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        reg = <0xa4030000 0x10000>;
>> +        dma-ranges = <0x0 0x0 0x40000000>;
>> +        xlnx,addrwidth = <32>;
>> +        xlnx,sg-length-width = <14>;
>> +        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>;
>> +        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
>> +                      "m_axi_s2mm_aclk", "m_axi_sg_aclk";
>> +
>> +        dma-channel-mm2s {
>> +            compatible = "xlnx,axi-dma-mm2s-channel";
>> +            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>> +            xlnx,datawidth = <64>;
>> +            xlnx,include-dre;
>> +        };
>> +
>> +        dma-channel-s2mm {
>> +            compatible = "xlnx,axi-dma-s2mm-channel";
>> +            interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>> +            xlnx,datawidth = <64>;
>> +            xlnx,include-dre;
>> +        };
>> +    };
>> +
> 
> Drop all examples past this point.

sure, thanks

Abin Joseph

> 
> Best regards,
> Krzysztof
> 


