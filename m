Return-Path: <dmaengine+bounces-9953-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN6bLl+x2GljgwgAu9opvQ
	(envelope-from <dmaengine+bounces-9953-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 10:14:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4693D3DB8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 10:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B754C302EEDB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF293AA4E6;
	Fri, 10 Apr 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tmT7gtq9"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB53A168B;
	Fri, 10 Apr 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808591; cv=fail; b=iRmV5gvreFs2HNp6UfMcI8zimaR3ml+lYtSmwu0EtGdDQsla0w2hkW8rhTwD35TPVLekq/iMWvn6wBrlgMF7uXNdBfuSOMOQ40UXg8Xl6u3h8TncE7eTdNHG9i5omHRxGU73j3gEmMHH6EP/6kZ84prpgCIgAFkk6wtlAwgCILo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808591; c=relaxed/simple;
	bh=hHduKQBmvSuGXKDFeR5B2NTXaXksr4I3aIM1X1QBrac=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQW8GZmSSsnygnQSZstT5wNYiz1R+4FYxmfsNHtimm2asdbzg17uehZQTNxq9PAqoL4AHdeXEmMQ5VrsCZhl6RbcQkK8KLrNOz9mrJ0OsYaGB/5+ZOckSiodlf0zUTGM9Gn/0os72TMlBQOaZjt07dJ0PF8gzdZo6DgTTbmphkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tmT7gtq9; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAaTiA83WHY4q8BIwYuq7gD9us05MngMwL1z1GGszvuW9ViaiKK3BZVBssisCx43V5QBfP2rsFo5E+eP+hHaklu01dpYafr3B6/cxq5XPW8WxxLD+Pp9IqBUdeNwzcMFsFIGpvWEkYlEDzq82ioB6gHXYo0g4Y+J8vRIlNe0mdL9iKfQv3JxC6cxYwAOMPf7rS0dLD0DrGRg8Hd7w3bzgbaLihHaD3Nk9cgEtkbB7uDWruBwZ/gUyDHnObObI8Ub9WQX6/vPlv/nVj2iOIL/22yYKTD51BldSJ/i8xdBJzzp4vm+wCMYyyis393k7te3EXZxZKutzuIqsNsZxjskKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+WQ2WngTosibfId3PPGT1r8JEexRVIXDvyUbKDjdC4=;
 b=sBagF/mCE9WquQ7PSN86eRJGIJ947R7bZkF4GeCUZABg2UslkabIH2OcADz2/bTAASacft0xnjMPELrOEa7j/+/BfMngPG4gU/AfIG23HXsJ+1n0KO1sKCErZOU7wsiDWHyEJLumN9EaA7ZrudoDXLOr6mIl9pA1NR68q0JHKyx/Z2QxGy67Y9wbK7QmVeIu47A1ug6RpUSeT6IGcc7DlxDsr8u6a+lz2RUxu3weiD3cjnMYWeJjPETT4/x02eToynHimrrruD1jx7Hxqm6UyUyX/pgTM48VuqB4ED2GSkz77FBHFIMcFR2rmAtghKScLShxI4L7iXuX8KnMtJDlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+WQ2WngTosibfId3PPGT1r8JEexRVIXDvyUbKDjdC4=;
 b=tmT7gtq9viuIhIv9o8Y5aW87+AKE0ttG1XlFUbR7Oa5HDdeorb7kP3jKu9SIQlJU8zBjNuy3GJl7pkGlS7A17ATDswE7GNbzqN008I+l21cToD+d721dZox2QdvLROvdGuZuXfIeqGvJLSrPZSdp2hmsV7/Tyf3CiCqGlecfPaYG0QufZv73D4Ca/pP10+1b0P269Xn2GxfMp6qmPw37xvGSp8qdA++0drn+CvcWnr0UXbOTpfYJaX3X2S8GPz362S5qnLdzqu/JLfWjv2xBJ0xAcBdHIBTjAZhToxezovahxWV/lAe0TmUzXfFgeKnZG0RjYJ1tXwvrkeFOGlCRVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 08:09:43 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 08:09:43 +0000
Message-ID: <d548278c-8bbd-4871-8fb6-e22db1688546@nvidia.com>
Date: Fri, 10 Apr 2026 09:09:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Add GPCDMA support in Tegra264
From: Jon Hunter <jonathanh@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akhil R <akhilrajeev@nvidia.com>,
 Frank Li <Frank.Li@kernel.org>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <586052f6-d415-4603-accb-be15bad80db8@nvidia.com>
Content-Language: en-US
In-Reply-To: <586052f6-d415-4603-accb-be15bad80db8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24)
 To DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3395e151-43a9-4dbd-5204-08de96d885ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wrl6oAXYd9OLMLEAMVtzQ8MBcSFpZn4MEOrtXYgsSUZVnzqambVQEjaP/5yQRnk/spSn3jfVLpPd8ACVGFhS37pOm4aQkX5DlV9SmmeF4gPTF0OZHF+0531sOhyoE2xWc3Rmo524phnlbqKeag566+0jzNYHd3zOZJllSGCnY5wpUx5Zk8n92t1uBTRJfDe35ug9Bc14G3Apd26RvU5rv7CGph+kNesKl3Ke01uVRyLHN0/oDSjq3xWUkrUysyeTU1k/9Qu3ddLA9/jHRVHbXdCIxYmsPDOLncYh8IIg5nMBmm+zOoCgEq60MoXWUDWkjjaTHe7Xxew9gjbzB/9gBhpyU6fqXtWnXf3Mym5kuK9+2yWsFi4SMWVTg/nH5kHanI3ZEF2Z6eG3U5gPXaswsXHAOhER+PNdvKcTLcs8XuOqrtqIXcehxMJighWOT3Mma1VLdzYEiPfxCyrfKMZCXRUmH4nQWSP3A+qsXsz5hKWSp21rxKj6Z2924SIGR3yVNoOtZWHCd/kfuqwSfodPSnpDY7WqPmsuMl2ps+gL6/XqNspWWpSYuCyNlFiZBpkemSnnF8LD6APgqlP1EARVelijftwsH5Nfw9FEnkUPhvkrfMnaYky630aT5Hon8TvUHiUf+f4F6m80s606OJQuTJMtIQoD0//VtTFHtdDQ1dcCIG16wN+t+Y1aWQGLJEDsnvzcSb4azKMLip4ybGOtxb8hZeZhblG8yfTJsZXvLVUypDrx68Xsj3YArwI61zcb05q1hS0tNXDjDZ7oMoNkcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGN3UDhQMGtrU2RXWEF6ck1tSDJWaWFyTjBYU0tTTERPTDdlazJ5Yzh5V3R3?=
 =?utf-8?B?VmpRZ254Rkl4OUpBWHQ1WmkwR3lWcEtOaDRQajEzcytvYk8wZTNENUY5SEU0?=
 =?utf-8?B?MWVKR0J6bGtrNm44SkwwZ21UK1NhUVRyNlhFNGkvWTNPY3VOeXFqeWJCSWdZ?=
 =?utf-8?B?OWNLdGZwejZadStDb2F5WTIyWVk5REdObTVST2dBYkU4SFhhV21BMVh0Mmc0?=
 =?utf-8?B?SzkzeXRZVEYxWThQbGdvT2lqKzBXVXA0OFo1MGpWaG9tRWcwY3YvckpFZ1Nx?=
 =?utf-8?B?VDhCYXAyWEltMEF4citIOUxTb1FIN0xOKys4aTlIS01kajZUSEpmNzZrQ0Z5?=
 =?utf-8?B?bzBsWmlJODhqTHZUelBvY2Z3aU9PajU5c0ttR1ZyODZab2crekZ1dUVEVTFs?=
 =?utf-8?B?MGtyZTBlODBJdmZ5R2dieXJiTWllRFVXU0tURURFRVBBL1FSUm5LRzJSTDNN?=
 =?utf-8?B?eXR4MXBCYzRvZXhnRURxa2xUSEVYNllsU3JKY1g2QzJPdHY1RFRTM3dGVUdG?=
 =?utf-8?B?cU4wU1VPQjlRczgyZURScyt5MGRqemV5UFQ4eTRBcFRLRnBCZURMa1NQa0Qw?=
 =?utf-8?B?M0R4R0pqLzhLNUdOTkt2RVhpQmk3Vkp0aWxkai9ZRDJqbkdIVndkbEpXV2J6?=
 =?utf-8?B?SkI5Ym1KL1JNWW1xeDZGZmxJSVpVNEJEL1VpN0dqNFRrQUxyV3FJVG1rUm81?=
 =?utf-8?B?cWdJVDI5OCtabHlWNm9MOVlScnJEc091UXNkRE1UeGxWMTZkUkxWdkYzTnRR?=
 =?utf-8?B?SmhTSmpQNmtqRWFJclQ3MVhpSEZLOVd0VlMwU0NjWklNdFk5OWs3ZWhNTTNv?=
 =?utf-8?B?eUNLUmxwUlRtaVNlNWJlLzZyTTdIeCtnb01FR2orTEUwTVUwTGsyT2RvMktm?=
 =?utf-8?B?dnB5ZUVFUDVkZ3M2aTR1R1hnbUF1WERSWDdWb3FSVkxSU3N6MzdDNkNsdEZw?=
 =?utf-8?B?MjkxQ2tudi9RVVlSMXNhemJZUE1tYnZrVTgyM3ZPWkExRnAvNG1ZRElTMEEv?=
 =?utf-8?B?dnF1VFByYlA1RjlnMnlJYzV4Sm44N3ZyWUNUMjlMSVpxeldJUE5ic2Y3TkJi?=
 =?utf-8?B?dVdpcTU0NWYwTC9YdEVuL3REMjFZWk9YNTA0VWU1Uy83SlhPZnFPYnJEZkgw?=
 =?utf-8?B?OG9PZDBOamQzdUE5ckZ2NFJaV3Vna0lmcFhQZ1liK253dDJFWTA4NHplN0lx?=
 =?utf-8?B?UGRYaWc4TzNFeU4zWWs3cVRIUHZ0REN2MnNJK1F3dGJSWWdDaVMrS1pnNkc5?=
 =?utf-8?B?amFrTUtCVTJwSE9CUnMxUGlUVEE0UUkxSWlIRFJRa3p4RGUrLytTeHd2dHo5?=
 =?utf-8?B?RVl0U2RjdmpWeXBsRlZtY3ZJTnU0SmpFYU9vUlVIQUFGQmJ1c0FFSVBVaXl1?=
 =?utf-8?B?UEhFZHRZWjRnQVVCL285WGJXQ3dZOUQyWkUveDZsZ0VhU21qY1krVURpemNh?=
 =?utf-8?B?NkNBNHpsQTVoNXMrdXIyT2FSUE9yZkppQWl1TGJXZG5ueENPZmJFTFVQZlMx?=
 =?utf-8?B?WTRUUXNyZDVJZ0VUV01XTWgraVlneituUmpKRS94TDhXcTV1Q09ZcjRnSW1M?=
 =?utf-8?B?MldtUjRJb011ZWI0R1BqSHNVSWd3YUNUV25GNnU4SkFEYVNZOXdwOXVoZEJu?=
 =?utf-8?B?YWxWcFZYR0I1NXhpUVlVNCtYWkhtcFQvODRiUVU2ZXA3QmRwL2tHQVBPeWJK?=
 =?utf-8?B?MEZ6WkFGWE5xb0JuVjVPSVd1bW93bDlpSVJzS1JBWVJEaC9OR2E0dUJaeUVI?=
 =?utf-8?B?Z0cwTzZzYVIwc0JmUnNMU1BZaGpMU3BmK21RVzltVHlyMEU2TzBoVWwvZHo0?=
 =?utf-8?B?S1hLamJSUi9SeUJ4WTJEZ0dWM1czakQwTEhwdXVEMHJpVU5jeXdCTVhuMUl5?=
 =?utf-8?B?WkxjZi9oZndFUFp2T0hONCttTWNheUJzbnRYdENZQnV1cGRjem5YRjI4SmNq?=
 =?utf-8?B?ZWo4K2lVcU5aOUNnT1FyOUk3S3JCZjRZditDbDZJNDh4TWp0RmF3TjhWQnNu?=
 =?utf-8?B?ZDh6Um44MzJ4cXFCVFozNzFLbW1JTndVb0VpU3ozcDUwY3cyRG9qeTZoM1NO?=
 =?utf-8?B?UUNkbXEwOHZVQytpTTJLWVNtci9qby9ZTmxXSXhLM29DMGJZWjFkbXJzVzE4?=
 =?utf-8?B?QWVkMkVGV1NYSStFNHgyVzhDcnllbEhKbTJYODVsQTNNamN0MzRwWnducTM3?=
 =?utf-8?B?RlZzOThoOUM5ZktlWGtpTUg1clhiY2Rzbjd3bVZuZDJVLzRtQytKa1R1eTBj?=
 =?utf-8?B?QnhZN0FQc2JTbW1sZXBqUWRXMjBUdXU4aGVMRElyVUZMNjdwa09xQ0Z6YnFM?=
 =?utf-8?B?bFljaDVpNjJ2SzdyQ0VISUwySlg5Q1hNRTg2ZnhRV3VtMHdhYVdlTkRmQmNm?=
 =?utf-8?Q?no28UhSlStxkY5Wc8KfQB3FFdZnjy5UMs5bGGqJRkxLR8?=
X-MS-Exchange-AntiSpam-MessageData-1: bJZvzHHjkqFfvw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3395e151-43a9-4dbd-5204-08de96d885ad
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:09:43.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EBwQ51cmDKT+QsyiFCH3pz5Itny+MzSlXNpKEBMHEeUem+h3/c+TTNM30xh4BQCrDJZJ9SWpkxy1TE4GoucPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9953-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 4E4693D3DB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinod,

On 31/03/2026 19:06, Jon Hunter wrote:
> 
> On 31/03/2026 11:22, Akhil R wrote:
>> This series adds support for GPCDMA in Tegra264 with additional
>> support for separate stream ID for each channel. Tegra264 GPCDMA
>> controller has changes in the register offsets and uses 41-bit
>> addressing for memory. Add changes in the tegra186-gpc-dma driver
>> to support these.
>>
>> v5->v6:
>> - Replace dev_err() with dev_err_probe() in the probe function for fixed
>>    return values also.
>> v4->v5:
>> - Use dev_err_probe() when returning error from the probe function.
>> - Remove tegra194 and tegra234 compatible from the reset 'if' condition
>>    in the bindings as suggested in v2 (which I missed).
>> v3->v4:
>> - Split device tree changes to two patches.
>> - Reordered patches to have fixes first.
>> - Added fixes tag to dt-bindings and device tree changes.
>> v2->v3:
>> - Add description for iommu-map property and update commit descriptions.
>> - Use enum for compatible string instead of const.
>> - Remove unused registers from struct tegra_dma_channel_regs.
>> - Use devm_of_dma_controller_register() to register the DMA controller.
>> - Remove return value check for mask setting in the driver as the bitmask
>>    value is always greater than 32.
>> v1->v2:
>> - Fix dt_bindings_check warnings
>> - Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
>> - Use dma_addr_t for sg_req src/dst fields and drop separate high_add
>>    variable and check for the addr_bits only when programming the
>>    registers.
>> - Update address width to 39 bits for Tegra234 and before since the SMMU
>>    supports only up to 39 bits till Tegra234.
>> - Add a patch to do managed DMA controller registration.
>> - Describe the second iteration in the probe.
>> - Update commit descriptions.
>>
>> Akhil R (10):
>>    dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
>>    arm64: tegra: Remove fallback compatible for GPCDMA
>>    dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
>>    dmaengine: tegra: Make reset control optional
>>    dmaengine: tegra: Use struct for register offsets
>>    dmaengine: tegra: Support address width > 39 bits
>>    dmaengine: tegra: Use managed DMA controller registration
>>    dmaengine: tegra: Use iommu-map for stream ID
>>    dmaengine: tegra: Add Tegra264 support
>>    arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
>>
>>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  32 +-
>>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
>>   drivers/dma/tegra186-gpc-dma.c                | 429 +++++++++++-------
>>   4 files changed, 284 insertions(+), 184 deletions(-)
>>
> 
> For the series ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

I am not sure if it is too late to pick this up for v7.1, but we would 
like to get this into -next if you are happy with it.

Thanks
Jon

-- 
nvpublic


