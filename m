Return-Path: <dmaengine+bounces-12213-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YP7cDsexT2qCmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12213-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:35:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A548173250F
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:35:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=hDUXOKuS;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12213-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12213-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51DB1319367C
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAC82BEFFE;
	Thu,  9 Jul 2026 14:14:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C99263F34;
	Thu,  9 Jul 2026 14:14:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606444; cv=fail; b=bq1rKG8ryaLKUKf3sc6mys+/aUowPKz/wG0VEZylwiE6rh8Yl5R8pYIGbc2SH0T7pVOMV0UQmt1/hU2/MHQxGOy0ekavQMotjf/s4V52uBu8JFCpXoWY2GEGQF8TqCYrBghKPHsUuPveyNxq0jFbkSY0VYnNdfqM9aUxAWZ52zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606444; c=relaxed/simple;
	bh=zSg/zg9VbYmPql1I2EtH/j0ORBB+uf0otCQEaVpqPHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A9i4hGVINDHPXrF7W1k7RsU44PPB05HlhkFcfoh/abW3XUTFdRSEswdynD4vEmGxHl/P0jJAAki9imeqCIb4ADlOtH0jGPu7otvoaEw/cIiH5y109A1s6oJhPhUAoZbxLYUzH5NJX1VCOp3JE0XfHh/hv2XU7s3VyS/WcNTV5wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hDUXOKuS; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPH9Qg1LpZnFQo5Np2cmlMwEE/P4FsPw5EoK0C/MQW0Bm/TrOxye6HGiEsMw5EGGZlKbOJB6MvpHzWfDWjxHaC2jZN0nmccDRAwG+YnuwhGKcGtMCxNp5vml8t0uQrGU8sNUsVqVoGg4npZ8SYQiYAuv40H/nfRAYvxad2KOZitmMTUJT/C78aEAQJa9Hxy+67sNZNkQZ3PKAd7eOglrWMLhswlN+KjxP/j1rlyRwLcfDvj29K2A6tKg1vNAeLVr1+0yilJ9TnrTYILQTDrbHmwW4q1C4NgejA3CMBRnamE9jNEhZRv6fWXlNtWsFmpwy1FmIdjAgxFFwtCnQ2G73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0ih7vNULsYP19N+jqpufFpInVKLoHWbksrWxmLOeL4=;
 b=rNho6I0ksH/ULSSoCi1A3Y0ztk2YMr72ZlJO40xvAyDAsMyO7xMCQzRrMsW8Xfq+ZSLonJjpMHGdCcOLNdpb7Mnqfr8fOM6e66nHEz7JrE9ykxshjQ//K0qrq99QfL6OqD7OLNT4kPZaBpja0Kp6bxJOO0Zkob6y0o1ttB3EVgRVk9wS0Bc48kVAMLaosBx/rpWp9fghWvA4XFQNDUaxsbeDs4BoO436ump8pFP+jjiphRQw9f32MhvT6iV8gcHjOIaYBnaCaKZvL+byOz8/nR1zUzDtqT2HVQfbPuY8AbXOsyhEl48L8enrfp/NSpyaoKID1IX+/yeesIzQi8hKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0ih7vNULsYP19N+jqpufFpInVKLoHWbksrWxmLOeL4=;
 b=hDUXOKuSSB0DFVra7pHP4ZxTK+5ZYJqo+7w69UwrYcvr+8kHBzf5pSqFl+Q4rb7oXegm2fmLnxu8vbUDZumS35wU5SHTsdH3kQJdyWbPOqIXwRQGJhgRDn+Fq48NO0Q4rDPBBFV2HE3p52a2FWn2BQve26hYDAZ9Zz65cnFD5Dw=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 14:13:55 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:13:53 +0000
Message-ID: <b56ae718-1ee6-4d5d-9901-ae5a01d2f9f5@amd.com>
Date: Thu, 9 Jul 2026 19:43:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
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
 <20260708100652.603074-5-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260708100652.603074-5-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::8) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a621aa0-cf90-4702-b65f-08deddc44e8a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3UN4Yt+vYOjXVT1/Ql+0vpO9DdCjLv3jwmwkQ96SA6WHP++DUR77h135Dfsz3SD32Zk3rd1Spxk4zYr3ledtiYPsX1DFFfnfspmEcIzH9RNAcicSrw+uVQhcfopYJYJ8oSJz7YXL0S1erp9HF0BjXSqz50Cp38fuC0sjc7JwWFatKCfaU+RClb0/AxC//ricnAW3H/K0fcJjpbdQFNI/feiCpPhKtmaG26QjsqGT34wwyWHLkuCUH78yWk/NBYmXp4+ikltMEvhtmBDMgah/ltUx2EkhmdyWFSe6bDCyJqeKhFHGZcUawr6ziV30mKwuvwor3IJ0Pk+APCiqe/mWcwQ/4dfuvrns6SmDNF1Q31GMAVdr6svQUNM601AWengvBjeaLYJnKZ/v4bEC6SyRblDjQPVEp5I4h+ogxm0FZkXMtbyOhRfkj9RqqNb2HUWeOW1PPLVUJpuJXY6RbRqEEfTfgZC0KaZZtkVm5VgZecQd6WVV1W9eloxgrj/iXuQxamHToL4lYfghLacihuuCi7NjecvOeqkD8eR3eeJrddXnpzc0vx5b2l9FmNeXshGImdfGQ9kyMg8NXB56fX9cNRHwWC4lKcp+2ZRSpq5jTUsCzbhiCfIm2WrOYquB4NdcaYcQ40cMw+ZV8LfS3GPZe8k9CMTyAa9PIxKEqGYgaLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWRoSHpiQWpDQWEvbGJvN0Z5V01LdUR0Z2JhUWUxN01LYjNyY3BKVllvYW5Q?=
 =?utf-8?B?YnZUR2J6ME1HaEFodEF5elFTeTNZaTBPNnVVQjc5WXZwazJqMlM5NEk5ancx?=
 =?utf-8?B?UTJkV3RRYWN4K3pIUjMxeHA2WG5Ca25RKzRJK0xtNEczQUhRNW1nZGN6K0RY?=
 =?utf-8?B?TFNwaXM5cnM0UGJuNnFtVWNsRmFpNGxPczhieXFaZEJud1d6YUwyaXZRaWRy?=
 =?utf-8?B?SVFVZkQxY3VGYzM4NjlTMlR6bnJQc0ZYUmJVUHZnOUVKclc0bUUvcmN6YUh3?=
 =?utf-8?B?eExpcitzNUs3UTdmb3R4VFVTaHZ1U2JGcURtNlhFVFRWeXdvejdNbGx2VURF?=
 =?utf-8?B?VFZGMmloMFZpTWFwZnE3VGtISW43bHZEdmNFejhML0tKazBiMXV2YjBPVmVI?=
 =?utf-8?B?VGYzYWtBdVloMGp2OUZYdXZOWnF2NGdZN0FvbmRCVlFVUjFKNXpYV1Z5L3Nx?=
 =?utf-8?B?YWhkZE9mRUJvbWpFdExXbmduNjFkVnM4NlE2bFB6NytTdk9pUlBVMlE3ZmNN?=
 =?utf-8?B?a0N3WVA0cDR6V0pTa2lpeHNoYnhXcUYyL0FwR3hFVHNFcVJyQzlvc0lQUUZY?=
 =?utf-8?B?WDJQUUxOTXErVDc0Z2tYekNtbWpqb0N3VHhleC8rY1JqSUw1T1JiekY5dDNB?=
 =?utf-8?B?MUc3c1FzSmMxbXZjb0UzQVdXa1BrT2NESGpzMFdsVTlYSUZZVG9GVS9vT1pU?=
 =?utf-8?B?a2tpSVhaL3ZhWjl6cm5BRUtaZDRTa0FEU1diN1IvendoYSt3VWdaNGZ4TXFN?=
 =?utf-8?B?R1FXcmZiTy82dCt6RW5SS1VYK2U4WEZxWEZiWlZuZlMxaFRLU09EL2V2TW9Q?=
 =?utf-8?B?eFRnaEJ0Z3NYM05sS1J0aEFPT00waGdYanZ2YjhJcWorZzdleWVYeXdPVEVJ?=
 =?utf-8?B?YzQvWno2b0JzUjlQQk1rdWRrTG5kYkRmWDRMeEJOb3ZHWG1RTEdwZHNCUXla?=
 =?utf-8?B?UE9NcmpJMFNVbUFTajUxK1hydmFmMytUL1dnc0k3Tm5vb0ZORGY3bGpCSlhK?=
 =?utf-8?B?VmNGdU9UTnlVN2hHQ1JWNXQwM0tWUitpcEdrRm55K09seWx4UWZOWTlWdld6?=
 =?utf-8?B?WFpUY09HcU02dHdXcGU1bjh0bG5rTEdJVWpDajhiNitIajdBVWMvTUlyNzhv?=
 =?utf-8?B?N3RCV0ZnZ3B4VlpQR3lwd2RMQUpYZ3hjT2g2K25zSGRjRUNzdjNGRGw5dmlE?=
 =?utf-8?B?Qi9TZlBBSjk4RFVzcTY4NjFwUzFBTWs2NERkbTBsY1JidXY3cXhFeXoxNkRw?=
 =?utf-8?B?UVptWWYyR2duQkwxTnJKTUtqZ25Dd3VvamJweVR3d0dIVk9kMlpuUUE0VEpx?=
 =?utf-8?B?K056Q0lQcDBpclNtajBGRDZsYmtnekVaVGlqREhXRVZ1aUZvTDZhTDJadWpI?=
 =?utf-8?B?SjcrNzBYTUsrNHhaL3I1citmOHJBV2JyRnBJMU85K1VSWVhWOFVST01FRnVJ?=
 =?utf-8?B?NytmTzR2bGNWK1B6dlkvWk1GekErZ3c0TVhTYXdCVHlPak9tbjhUbG82VzFZ?=
 =?utf-8?B?TzNGWnNpemwwWDNJUVdYbjJkMlZJdnVNL29jSXFnSFFyQXFLdTljNml3R3lk?=
 =?utf-8?B?YlBTYThxd0J5L3F1QjlzWHMycVl1bmNiTW84dW5FOFNMVU1EbEJtbVRGMnB4?=
 =?utf-8?B?ekxZRlZGcG1ncjhqS3Ixdk9GVVlReTBCbE82QUtYQm5JTjEzbmRObXpUVExC?=
 =?utf-8?B?MEJTb09waGxuUlBlRkp4TjBMU01LVXRoV20wMU02RWNuMmZ4KzhRbDZ4VFY5?=
 =?utf-8?B?eEhVM0hibFhWdWF5TUhWeE1vWDl6eGJGOGR0Mk5HNkVZSmY2ZVI0SUZlYnBq?=
 =?utf-8?B?R3h5SnMrUnNhUzBHQXYrMDByOEgybWt0SVZVYWxRdk81ZzBFWHNCSGw1UFJQ?=
 =?utf-8?B?MHcyWFlETXU4S0trZ2lYYjBaUTd0bFpvTFlOUURUMlptUFE2TVdPQ20vekRD?=
 =?utf-8?B?QU1ZaWdFdE1JcVZPZmxiVmsyWFVEMFMwa0IwS3JJWHVrTWE2YnVFSjk5TUFT?=
 =?utf-8?B?RVRQeitNWDNKUzhkQ0luUUxNcTM1UDdhQ2s3RTBydExXUll1OUMxOGMyTDk0?=
 =?utf-8?B?OFlCT3FIVDg5WGZqdVM2c0NEb3hGVlpNdyt1cUtMM25vMEllQlhoci9GdExE?=
 =?utf-8?B?a21kdVFDdFR1bGFaMm9TSTZCSmhBYldMS3NFTFBIWjVVZkV1RUF4MEJoU1RE?=
 =?utf-8?B?OG5rUmtoUWFkTDl4SXZkMlZ4YTRQSnE2M1N1bTFGdE5RRWFIM0dwNWp0UE4y?=
 =?utf-8?B?VU5xVm0rVk9NV1lQNHhFZHhtVE9USStSYVBBNWFpSS9DeXhiQTVweEgySmpr?=
 =?utf-8?Q?+BGerUQySvWHzoyUu7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a621aa0-cf90-4702-b65f-08deddc44e8a
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:13:53.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6WZfETVtgp3uXxwV6vaPRhwTx2P7+ogR0cARZtNqn5zPcHVY3CIkWopPL1T67Iv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-12213-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A548173250F

> From: Suraj Gupta <suraj.gupta2@amd.com>
> 
> xilinx_dma_get_metadata_ptr() exposed only the descriptor APP fields. Both
> AXI DMA and AXI MCDMA descriptors carry a status word with the transfer
> status, and AXI MCDMA additionally carries an AXI4-Stream sideband status
> word holding TID, TDEST and TUSER that clients may need. Extend the
> metadata handling to expose these.
> 
> The returned pointer now starts at the descriptor status word for both AXI
> DMA and AXI MCDMA. As the descriptor words are contiguous, the client sees
> the status at index 0, followed for AXI MCDMA by the sideband status
> (TID/TDEST/TUSER) at index 1 and the APP fields, or for AXI DMA by the APP
> fields directly. The payload length is derived from the field sizes.
> 
> This changes the get_metadata_ptr() contract for AXI DMA. The pointer now
> starts at the status word of the last (EOF) descriptor instead of the APP
> fields of the first, and the payload grows from 20 to 24 bytes. A client
> reading app[0] now reads the status word. No in-tree consumer is affected,
> as the axienet driver reads the RX frame length from result->residue
> rather than the APP fields. Reading the EOF descriptor is also correct, as
> the hardware writes the status and APP fields there.
> 
> The index 0 and 1 layout described above is for the AXI MCDMA receive
> (S2MM) direction, which is where metadata is consumed. On the transmit
> (MM2S) direction the same descriptor words hold different fields.
> 
> The probe logic is extended to read xlnx,axistream-connected for MCDMA, and
> xilinx_mcdma_prep_slave_sg() attaches metadata_ops when an AXI Stream
> interface is present, so MCDMA clients can use the metadata API in the same
> way as AXI DMA clients.

Nit - make the commit description precise.>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V3:
>   - Renamed subject to include "AXI DMA and MCDMA" (was "AXI MCDMA" only).
>   - Complete rewrite of commit message and implementation.
>   - Metadata pointer now returns status field at index 0 instead of APP
>     fields, exposing status and sideband information to clients.
>   - Changed from list_first_entry to list_last_entry to return the EOF
>     descriptor where hardware writes status and APP fields.
>   - Added explicit handling for both AXIDMA and MCDMA types with proper
>     payload length calculation.
>   - Added WARN_ON_ONCE for unsupported DMA types.
>   - Removed the 'chan' field from struct xilinx_dma_tx_descriptor (was
>     added in V2) as it's no longer needed; channel is obtained from
>     tx->chan instead.
>   - Dropped V2 patches 4/5 (dt-bindings xlnx,include-stscntrl-strm) and
>     5/5 (xferred_bytes support) as the approach changed to use residue.
> 
> Changes in V2:
>   - Added support for MCDMA metadata handling alongside AXIDMA.
>   - Added 'chan' field to struct xilinx_dma_tx_descriptor.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 48 ++++++++++++++++++++++++++++-----
>   1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 1b5b00f08c5f..f5c4e0ca2cc4 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -651,18 +651,48 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
>    * @tx: async transaction descriptor
>    * @payload_len: metadata payload length
>    * @max_len: metadata max length
> - * Return: The app field pointer.
> + *
> + * The returned pointer starts at the descriptor status word for both AXI DMA
> + * and AXI MCDMA. As the descriptor words are contiguous, the client sees the
> + * status at index 0, followed for AXI MCDMA by the sideband status
> + * (TID/TDEST/TUSER) at index 1 and the APP fields from index 2, or for AXI DMA
> + * by the APP fields from index 1. These fields are populated by the hardware on
> + * the End-Of-Frame descriptor, so the pointer is taken from there.
> + *
> + * Return: Pointer to the descriptor status field.
>    */
>   static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>   					 size_t *payload_len, size_t *max_len)
>   {
>   	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
> -	struct xilinx_axidma_tx_segment *seg;
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
> +
> +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +		struct xilinx_aximcdma_tx_segment *seg =
> +			list_last_entry(&desc->segments,
> +					struct xilinx_aximcdma_tx_segment, node);
> +

This func is common for MCDMA s2mm and mm2s channel. Please make it 
generic to address both.

> +		/* [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
> +		*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
> +					 sizeof(seg->hw.s2mm_sideband_status) +
> +					 sizeof(seg->hw.app);
> +		return &seg->hw.s2mm_status;
> +	}
> +
> +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> +		struct xilinx_axidma_tx_segment *seg =
> +			list_last_entry(&desc->segments,
> +					struct xilinx_axidma_tx_segment, node);
> +
> +		/* [0] = status, [1..] = app */
> +		*max_len = *payload_len = sizeof(seg->hw.status) +
> +					 sizeof(seg->hw.app);
> +		return &seg->hw.status;
> +	}
>   
> -	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> -	seg = list_first_entry(&desc->segments,
> -			       struct xilinx_axidma_tx_segment, node);
> -	return seg->hw.app;
> +	/* Only AXIDMA and MCDMA attach metadata_ops today. */
> +	WARN_ON_ONCE(1);
> +	return ERR_PTR(-EINVAL);

We are registering metadata ops for MCDMA and AXI DMA so when is this 
error condition going to happen?

>   }
>   
>   static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
> @@ -2639,6 +2669,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>   		segment->hw.control |= XILINX_MCDMA_BD_EOP;
>   	}
>   
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
> +
>   	return &desc->async_tx;
>   
>   error:
> @@ -3287,7 +3320,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>   
>   	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
>   
> -	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> +	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
> +	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
>   		xdev->has_axistream_connected =
>   			of_property_read_bool(node, "xlnx,axistream-connected");
>   	}


