Return-Path: <dmaengine+bounces-10078-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dn6Cj7Y52kBBwIAu9opvQ
	(envelope-from <dmaengine+bounces-10078-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 22:04:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A9D43F345
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 737EA3028674
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175E3DCDA4;
	Tue, 21 Apr 2026 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VvGI7IKW"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F45374E7A;
	Tue, 21 Apr 2026 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801850; cv=fail; b=K4qYBcKb51GIq/uE+FPAw5eCIN0gswxW57kqkRXPgOaGnPfLbZcEcCi6TSFbA443fvRumMSdqTvMCCW4KlIexNiB8HIFjuyL+70Zum9220L5VnGN9bThhIQ4xY/KFzH7JxYyL4ZGJpwZU78W+Xt2tdcDbYySB4yFeDcVfFCkSdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801850; c=relaxed/simple;
	bh=egFTrjC/mEQ05UtGhoecf5BVhpdi/wOBwL0UJMJiaq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q05hd6yjdNU0KaTYVJN/7Do97dC84lPyyxWWCJdX61QJxofEMZ8SUhNVKx2NlirdVqleCTQnf2kagUwhzsRcjOL/l0ZSjIywrrLoulRIv1BCtsE1OjYwokm+O39XErDlx3xpll2RyXDpnVUNMO+uoZULLM7GnHIYqOPYjnUgbic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VvGI7IKW; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZHgWDk8tsCMxCq13umm2F3JaYtPRGiJwW6zbnlLC4N+57mm++Ts7ZDocNx1PkTqSFKrx+hoGrNaSi9F60Zmu4GxVXEthRMT5ykiJZ3d+T/5C31SfhfnBeWf3XQCy8hBGF+KlGmH72KeqcFl33O6uU3wgjfsIQ542rmgSDXhssDsnYu60W5KrBVCSsmtCpJvVQ71hOT9f+7+FQd1kRqCsjjiF9N6ZFW1Amfq3/DzPzmHfzHpdptxf4tnofBcdWCTjZSMf1+mu10a6+I1F756cnEhXq/hVfcePP8RjEhnbGGUaeuh8VAWTdr5NU7tkPwasKqNeUIsa0p2TDAccI4JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XFw6p9O581jIK/jBe+cvL5JadQaPVESvVr6NjPSPbg=;
 b=aCj6oIfYSkd4T0U7d9Pdw/h+Web1z7PNTmbjIo5rUSmLKrTU9wWJex1kJehstMw4uf71XyhdZWvme6YkNw2ZlMLqolc0dY63XbOHuLPAppifP55zjTzdSsz53PNFGnNIw7Zhcjib+Kgs1gz3HEQ8ovnQXAqUaAm+QD7wTiZqbAwJL+gkY1ncZFNMbln7FLMWTHZonvWgjtB1vw+JCYoBpZqFPka5cAImo/I1XuglVgzT1dl/gs5jQAxnq5us00io9tK2/xRpt2y6hmqcTyJXxJ2hNBP1uxEPjrdEwfyiXPtXAoprC7MyO9xHvrdy6FFZpB4cP00lpVAvZvZa2XeXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XFw6p9O581jIK/jBe+cvL5JadQaPVESvVr6NjPSPbg=;
 b=VvGI7IKWLo2wJWbVytEsGq1on/vvGw2cx4MG1MGBJTyuqBgUlQUAb3pb2ARDbEX/kxG5WWYb6pK8S6XKXugzsIp8sDXjDcalvQ7z2qp6nHFuGoRz4cZIwHVOt5hs5i97nsAbf8xwtN0+gxDaQhx4u8GxzBCxTi0B0n3weveH53M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 20:04:04 +0000
Received: from MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57]) by MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 20:04:04 +0000
Message-ID: <a33372fd-1dc5-4239-84ca-c2429e79cf2a@amd.com>
Date: Tue, 21 Apr 2026 15:04:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] dmaengine: sdxi: Add DMA engine provider
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-23-1d184cb5c60a@amd.com>
 <aeXs8pehnHIbPZd_@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXs8pehnHIbPZd_@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:610:e6::23) To MW4PR12MB7357.namprd12.prod.outlook.com
 (2603:10b6:303:219::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7357:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc1909b-3351-4cda-8068-08de9fe12370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/T0zGBG2W0GvCi9hEcL16RbzisXTC4Rg0YYXj2qlAn+Pe016NE1rqECcWGFkSyUmHzUhKyqeQnrfVSvydMWVGOTunUsCgobSJ70gj/FLqnpIa5kxRm3if+Sn5VIrEVhaemioID9crpMTgt+lQPaapfqoSJpEjv7OCHWNzxHALNm/E1jYJTKtHl/8kMpkn1sS7bDm5JRDOa7ycJ4NGDqmYtzMTF83bAGhdOcDNqLcbup5nKcqGqkUKUopZ/sGcNg3U+wkJTnNPljR2PyF+Eqz5iXqlBfsfEuGPCrGDqENbvO6XUe3XZD7pzTV3wHt080NiGop6wGEJvQlYTNNQJtCBmX1UYR+JAGzQPgoA8/cAjGANuc/ehCbvxloT8WD5jaUH4ljJkG1mjkwo4+ofDsj7OkMnivcI7dIqnslhlXrrgKwU3F03u2u7tPPbAgtIfl4rtOg17d4YBpz1MipZ3bmerv5p7DcGySY+9n1lTWlbVr3NJ5/mLHO78EsAS6FCGQYWDIoIWjxs8tlkEN5OtrFqjVHQ8ewQKw2Zn3MKdg8uMxRNXkSadjSGLgqKjmZtyYfYK7QviVQlmkJHoFYG1TN97B1COr+VE4rCatDvCqvgcLpJ6Qd8Z09NPukMRRZXHLJc4sWXthMUtXL9o9wLbN7xgHkR34GnJ5vl3lxUTrwWbkcgEfYSW9fpaXYr2KZ/LWXD7Pxa91X6npMVuRTs/rJV0VVc436itSc8bLtg+/QpNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1l6Tnk4Y3Y3cExIV0x5c3J2cWVqdE1mWi9rNUNVcHpVRlJmZndDMXc2Q3VC?=
 =?utf-8?B?TlMveW90N0lyeTFpTDE3WW9yOUgySE0yclhocloyTWtZcHFSREpBV0ljQ0xm?=
 =?utf-8?B?TTk1S1NCMmNiVlhMTmIvT2U2SFBVWWZSaGRIeU9saUtPcVZtbVRyZXJreGll?=
 =?utf-8?B?MWN0K0Z0aEZSTHdlZHJTRDF2UUZwaWFyekdocEFyS2hZMkZLMTZIaGQ0Ynp4?=
 =?utf-8?B?djZTYStMNEhMdUt4TDBGUTNkbHp3bVlwWm5hdWJhTHFTTkpiUEJpbk1QeFBl?=
 =?utf-8?B?SXo5THpPZ082RzVFZ0JSTW0vTVVZTlM4alR6blBZa2l1d1l1Zk1Qa3E2KzhQ?=
 =?utf-8?B?RW9PUXJ5NWxuS2FoOHUzWTNFMTlPcTY5ZkZOdUlFZWExR3pMVkpwWnZTb1Uw?=
 =?utf-8?B?Z1hwbzZVRzVyYmdtTm1ubm16RU9JT0JyZUJEdFlUWHV5eDZsY29qcnZBbXdx?=
 =?utf-8?B?L1ZyQS9BcURlNCtVZExVMFdwVE93dDFFTmRmK0RkandtRVFPWE5QZTROUjE0?=
 =?utf-8?B?b2p2OEJYUTQ3VnpvRUVHZnhnQkttdHNaVjJJVHRzZWJqczBvYksyUXZJdkRN?=
 =?utf-8?B?cE5KSWJEL3ppcGRUbGJUS21ybGJQVndzdXRVZm9UTTlKQWczbndPY3hnZUpw?=
 =?utf-8?B?QUdKWnU0V1E3UFJObHNpckxrMGF6RlBlRWJkVldtZGhKcEJXbFo5UzhSNUZU?=
 =?utf-8?B?YldhaTRrZ25XMEtLZHFjOFpyVk9mQkg1MUtHNmRXYlJ5VlRralpTTnpWS0Jt?=
 =?utf-8?B?MHgxNnA3cHYwV0xRZFhqNlM3S1FZbzRuT2lwcmhmMTNiNHU2djVWeExTejdt?=
 =?utf-8?B?cmtCTWxJem5XZXBNei9jTlNLeFl2UU12VjVHRWhqSWpENTVrc1ZZWlM2OW1S?=
 =?utf-8?B?dnVyUTZpN2grMG5HTFhqZUZtTDdGWFFlODkwaEo0ejFBaURPK3ViNlhhZ1o0?=
 =?utf-8?B?a2ZBMTJwKzJ3dWxKNjI3UFRoT3hDMnN2KzFnUXN5NVRkVEVlYTBuM0tCNUZx?=
 =?utf-8?B?enpiVU1HS3cveURoL0l0WEFjR1ZRUVdEWFNNNlJIVGF5U1FaZ1NsczFBdDJI?=
 =?utf-8?B?NlZvM0VpbFZyUVlmOExMRjlkSS9uOXRLU2orY0I0WWVnV1NVN0swT0RSS2pL?=
 =?utf-8?B?ZGNiMGI2Sm5iL01idTdaek1qeS9VN0I4MU9LQXBscnZhbENYQmJ0eCtoMmFr?=
 =?utf-8?B?SlJ3MVRFa1QzSmE5Sncvc1RGdzBhSmVBcnRBVnB3Y1Zld3hUb3pqTHZHeG4z?=
 =?utf-8?B?Mk4wYVQrZ1ZOdnA5a3lNa05mWHMxdDMvRUZ4cmtZOERqQVZRSjlXQXZOcWRx?=
 =?utf-8?B?ajIySUdPcGNrWWZXT2F5NzFkemV3WGVqUTMzZDBWN25FZXE4d0NvQ2R4UDda?=
 =?utf-8?B?Nk42NVd4dGJOeWhzdEdNUzlSRFZkYmJQaG9NZCsxeU5xOU85eEdHK2c3Ungv?=
 =?utf-8?B?aVEyTVJJNmx3aUZXbUhkaDJsUkZxa3EvVHFmVWIrek1mYVRsTnJLUUNPRDJN?=
 =?utf-8?B?SVQ3L1J2eWxmSXlzTnZtZzNlQ3d6Vy9GcE9RQXJrMGxkZCtUdDZtMFVtVFBx?=
 =?utf-8?B?cUdiaU4yWlpTamxZREZVVlc3dmpPckp1T0JBQ1ZsdDFQd2RQcmx5b2c1dGhW?=
 =?utf-8?B?ZVNmeHh0RXNLOEZJeDE0VzF4QnhVU2tldzRnVFdYcUlZZm5UdkE1UlZVZmdw?=
 =?utf-8?B?ZDVFcENmSFVYQ3RlamZ3WFpCUENVU0V5VnZBOStoclAra3UzQTYwL2JkV00z?=
 =?utf-8?B?bHZWSUJGeC8wMk5PZTRGMi9ENTVJN3B5RGw4bEpRVnNFV2QyR216OHpRQk04?=
 =?utf-8?B?ZWpDTEhCYjdDMldVaWF4dUNlOC9jdHJGSzdLOVNTQXNnVVp1VUJCRTVlQmZX?=
 =?utf-8?B?dnUwV0JpRHUvRUxHc2ZWaGR5VldyN0YzQWlXY083RXc5T2xoTzFjU2FyWklY?=
 =?utf-8?B?aXR3YlhSYnRIQUdPTU9KaE1TbXRqRTI1TitGY2lLR2xsNCthdGNSSHlNNkZ4?=
 =?utf-8?B?K1IyUjcwNDZZSU9IRWkrSWtoWGg5T3NQaDRRTnpMd0lod2Q1dHg3c0lqQmRV?=
 =?utf-8?B?bEtwb2cwb1ZBQVZxRGlqU2IvVEVlSEtFSkRPUG1qdnlGYmVjVnZwZUxDR0Er?=
 =?utf-8?B?b0VpRUNyc01TNUVhamhsUHJhK2hjL053eHhzKzFqemxmZ01hbXZIdGJaVlFr?=
 =?utf-8?B?ellnTmNxSEt5SklWMHc0SkhFaTFTalkxTjU0NDJpSmVDWTNld1BqZHVNOHFz?=
 =?utf-8?B?MG9zN0swRmtJRDBXZDFaUmtJZlBZMXgybkVBOTNQSVIyWGw4QWx0TWtmNEZu?=
 =?utf-8?B?MGxjTXEzQlJWbmhpSVZSTXBtUVNLd1djZ2dmVjNCYm1TUjdXNUVaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc1909b-3351-4cda-8068-08de9fe12370
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 20:04:04.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL8h5rAAOEBDKmA9xKz7SHmIzu9gNtT9t5IQRcfARE+Jg6Liie9FudulUEmQxbuO+kVsdEOAhIE8Ksce88fy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10078-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15A9D43F345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 4:08 AM, Frank Li wrote:
> On Fri, Apr 10, 2026 at 08:07:33AM -0500, Nathan Lynch wrote:
>> Register a DMA engine provider that implements memcpy. The number of
>> channels per SDXI function can be controlled via a module
>> parameter (dma_channels). The provider uses the virt-dma library.
>>
>> This survives dmatest runs with both polled and interrupt-signaled
>> completion modes, with the following debug options and sanitizers
>> enabled:
>>
>> CONFIG_DEBUG_KMEMLEAK=y
>> CONFIG_KASAN=y
>> CONFIG_PROVE_LOCKING=y
>> CONFIG_SLUB_DEBUG_ON=y
>> CONFIG_UBSAN=y
>>
> ...
>> +}
>> diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
>> new file mode 100644
>> index 000000000000..4ff3c2cb67fc
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/dma.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright Advanced Micro Devices, Inc. */
>> +
>> +#ifndef DMA_SDXI_DMA_H
>> +#define DMA_SDXI_DMA_H
>> +
>> +struct sdxi_dev;
>> +
>> +int sdxi_dma_register(struct sdxi_dev *sdxi);
>> +void sdxi_dma_unregister(struct sdxi_dev *sdxi);
> 
> where use this it ?

Looks like a leftover from before I converted this to use
dmaenginem_async_device_register(). I'll remove it.


