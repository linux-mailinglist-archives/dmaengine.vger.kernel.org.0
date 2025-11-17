Return-Path: <dmaengine+bounces-7195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC92C62A90
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 08:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 529B4346D5C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067631690D;
	Mon, 17 Nov 2025 07:07:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022101.outbound.protection.outlook.com [52.101.126.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79757310624;
	Mon, 17 Nov 2025 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363244; cv=fail; b=sVRU1XTLV9UIMkz6FXKo5kxU55HcCl0VCpoiSRYMRS0z3kCDZKl+B3xZ5X0riAJkpDpAb3shN7qJv356f94sgec/l0yG40AdAgCHFoE4UnxliSov2dz2t3POr9c3n4N/8xkf62cYmpC0DuycUu1kB86PJHaoMU+GYCd8YwyxRJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363244; c=relaxed/simple;
	bh=Z12mn2+MY4P1eS9ON6H8kbib2PdObQBy+Hi5c+lf/QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW6Ihe7971/ESIBrinaeCDHrovEap/krWHK0mo/lurOyw5CNO6g09aOq5h1m568rk5MivjvKdUhtigEKmf8A92/tNvfpmETbMu5SXIxzDnmSdSs/JThy41qs3EeHvQKq7geCMAhzc3YZIHCFBeoDXaYyafk0ilKxu0Ka115hkFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/kkll9h/0QMfjThQOv+J0DvPeFoOG4jZOL4XzvUuO+JpbsXpJq2vTbNp+s0mCUjZRgLM/NIk60IgVYMk+/LBIE/c9BFbszLfMMRya1MNYt06Jd2xAIHpJPEsuCcj0YcjsZDKb1r9v+MjzjqIQbHTlOHXCfT5qgtviMj3gOjR7t8u8BZ3X2eiAZo4/H9naIinDw+2GDNrLdFZaYQNymyV1URbk0oOz9SW+D+Vu4LvtWKlNpWoAkd54muBvhJQmK/KPK5j+qL0QjwyHR83lqP5wqPUXvcmqcbAqkUj1RjnHOoSFsAXnWZeZ8kvDHnxBVLD1mXs1v9z5u8frbhDi69vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKoqGkgXQOGIwY96TSfnuDzwQEgOxVm7Ju9LZGKdOjo=;
 b=rtszudMKm4k9QJJmAgXdVi80uUm/1lSZCnGImtDL/SAGWmD3YDLvF9bNnwE5ny+1xb1e4q+Qj6+B0pUBfJDjJepjh8eo3QKLThzNjWnLZJr5ed4o8S1GyZuXZ8OBwWL+o54Qdwlj+3yQxyh9S7fM/iJmtfw5oakTzabLobf0+rxKJkDGGyZOeXJY+SwVpzM7yTTPgmrub5yXt0zHNmy/yctu9+3UDIplpriLyniPOKmnEGbHif21Y5gtG9O3a1Yh3AY7L7WH0uIBCQ9/wpf3dUhAFTdRihNzRtCItgAWZojb1Sb9AOZr/qzEJ/58XspgB4nguA0W9vVdtPt+v3Xpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0057.apcprd02.prod.outlook.com (2603:1096:300:5a::21)
 by SEZPR06MB7024.apcprd06.prod.outlook.com (2603:1096:101:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 17 Nov
 2025 07:07:18 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:300:5a:cafe::1a) by PS2PR02CA0057.outlook.office365.com
 (2603:1096:300:5a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:07:17 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4B0064126FFD;
	Mon, 17 Nov 2025 15:07:16 +0800 (CST)
Message-ID: <aea1429d-b67e-4c42-ad19-88d04f69467b@cixtech.com>
Date: Mon, 17 Nov 2025 15:07:15 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: arm-dma350: update DT binding docs
To: Krzysztof Kozlowski <krzk@kernel.org>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20251117015943.2858-1-jun.guo@cixtech.com>
 <20251117015943.2858-2-jun.guo@cixtech.com>
 <bfe6a067-704b-45c1-919e-6a7dfb08b984@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <bfe6a067-704b-45c1-919e-6a7dfb08b984@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEZPR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: adcb29b7-f6b3-493d-9bba-08de25a7f1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3E3RUx2dk5nN2ZCd3hyYW4vdnJ1WE8zZnc3aHpXRGhXZ0p5Vk9RSkFRN083?=
 =?utf-8?B?RGRzV2RVY3FqZjJCbzd0dlF4M25RdmU5bWdYWFdwWUdrQ2hZajJJcXdlSGx1?=
 =?utf-8?B?UllIN0FzQXMySit5VG5UcmRVd1dlVDJBckNOelZVdTFVMmkrUXpXR0FuellN?=
 =?utf-8?B?TjVncFJtcTdDQ2ppbEgzTWtScDdsc3M3eCtQUTV1dDdxbGxMS3hsN3Z2dXZ0?=
 =?utf-8?B?U0RDM0x6RFVyWW9DMnBlaEFHTG1DVzNFZjQ3MlIwSVdYRlRGWCsxcWY1dHB5?=
 =?utf-8?B?Wm5RUTVWcmpuYmFQQ3JvTFlqOGd2TEh0anZ5TzhQNEk5T0lJbDJRNW5VSFlH?=
 =?utf-8?B?djIzeEFOTmQ4RmJocjV4K2tRM1BqM3hUL05rN0tJckxDOTVmSVJCZFVaQ2FJ?=
 =?utf-8?B?TTI1OVdsci80S3JuQTlSNE1BTzdkS0RjanFja29xY2hOcWF2b2hPVWYxaklH?=
 =?utf-8?B?TkFEZXpDR3NCeTlBbTBtSkF4bm5uL01hWm9mTVdOVTlYNVpydFZqWmhKQmZQ?=
 =?utf-8?B?cTBlamFJOFlIenFya09FNHZJek5hU2tkK0luZWNwT3VBU3ZlaGZBajlPQk54?=
 =?utf-8?B?Rys4SGIrenF4TS9xQkdkZnd2M1hsc2VNcHNLREU1WUhPeEMyMUZJc3VRRFUy?=
 =?utf-8?B?ZFlXTTFOcFVHQVNSSXI5SXBIQitUb21YSmhPVFl6UUJMZHpNL1lMZFdSZnQr?=
 =?utf-8?B?eVAxMDZiQVJrK1NjVW5yM05BWEc4WHhEUGEvaXVGazk2WDZzSkVIa3ErYWEz?=
 =?utf-8?B?dmlnL2FzTlhLQlhRSUVxVitIQUZqcVdmbXF3MUxHNWMwaUVibmRKRHhSVkpB?=
 =?utf-8?B?eFd4aStVQkh0SXBseWNOMzFvTllZUEo0dkhOZHhnNnBra3BvSUFOcEQwRlVi?=
 =?utf-8?B?WjA3M3lUcVhYbzNSTjJ5SDhscnJsOWh6L3R6VEVCQjZvTlFRU2xTc1VEUFRv?=
 =?utf-8?B?NnRiTTRMNEoxSXYvZ2NyY3UwWmZTOHE4eEx6TkhSZlJ0NGROMkswYjVxZy9J?=
 =?utf-8?B?TkRmUTlyUW8rc2p5dGlHdnZHekVzeVBSWWQ5TytBMU5jZmZTclFWTEx6NzVo?=
 =?utf-8?B?dEsxQmFDaXNJcTJEM2E3REdFMkVxK2FMYitzWU9sL2hVbUJoRWpzSGVwRnN1?=
 =?utf-8?B?UmNNejNtK2xPMW5QYnJBbGlzdFA4Zk4rZHhyM0RwQzlINVN6RVNBVzdGTlAr?=
 =?utf-8?B?bnlubEVLWXZGUzFtZHVjckM3VVgxMU5ybUdyTy96TEt0OEZjU3Y1M01ERWlW?=
 =?utf-8?B?bG9nZTlTc3ZhekIrMEdlVDd6S0RDSTdXY2pXWktDcVFQSjFvSnlGMnVmWmpD?=
 =?utf-8?B?WkY5Qkt4d09hODBpWCtwVUdyRHdqQ1I2QzNObGlLRDlGUDBQTnhWTjlmVjZk?=
 =?utf-8?B?RkR4VUNsTXRxWjFGQWNDMm1GM0xnelRkcDJMc0dJSW93eHJrcElCdERnKzFZ?=
 =?utf-8?B?YzU1QXVKTVl4UVZ4N25wRWdHb2NhRDg0Q1AvcGlyVGpZVGZxbDJybllENDVM?=
 =?utf-8?B?N3NOOUVjQ1dkUjNscnFFeXFoWUVWRTZRNHZHV1VaMHpNRUtqZ0RaaDdHNDc4?=
 =?utf-8?B?M1BnRzV1WEtNdzBIbjFWNzRFcjNoTW5vNEtCR3lwaG9pL2JHby8wZzNLN1gx?=
 =?utf-8?B?dlRvN3p0aXJHTnhlUjI1M0xWN2NteWpYTnZxSm10Z2x0cUVndTdJWkRTclln?=
 =?utf-8?B?ZWMzS3djOWFEbkc4UzJHT3ZXV25zVGVVTjBvVzBBWnNpY2VHbEF5S3FjUHRw?=
 =?utf-8?B?L2JUd0ozcVE0dkpKdnN1bnlGdkJCcDFoczhBRDRhNlhUTkZibXQ1c29wU3k3?=
 =?utf-8?B?VTFpL3o2amZ4cVRHVzlUVjM3RDl4RW1KbWZucFp2ZU1yY0xiU3F1cUNrbThL?=
 =?utf-8?B?RWRxV1RyQ3B4OXd2elM5SzdIWWtzRUdZd3NFVjZiTE1aTExzVjRRSG80MGNJ?=
 =?utf-8?B?S2JkWlBWV1RHeTdOemp4ZmptY3dnSnQ4aDNVYThGQXROd1cyTXZMbURMYllC?=
 =?utf-8?B?dTJmT2JuRUEvTUpuNGU1bVBVdHJLNVIyc1RiM040RUh2bWxYVE9BQm80ZmIw?=
 =?utf-8?B?bmsvZlRJRkE3akVBelBGS2dQUlJneGZJK29kQXVNaEY0NmdVZ3FYTkhlNTRB?=
 =?utf-8?Q?1SR5/WaFwUh2dim7KGvUiiNNr?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:07:17.6072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcb29b7-f6b3-493d-9bba-08de25a7f1b7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7024


On 11/17/2025 2:11 PM, Krzysztof Kozlowski wrote:
> On 17/11/2025 02:59, Jun Guo wrote:
>> - Add new compatible strings to the DT binding documents to support
> This is not a list.
> 
> Also, subject is completely redundant. Everything is an update. Why are
> you repeating DT binding docs?
> 
Thank you. I will incorporate your feedback in the next version.>>   cix 
sky1 SoC.
>>
>> Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>> ---
> You just broke all existing platforms. Please test your code properly.
The patch includes proper checks. Since this platform is the first user 
of the driver in the current codebase, the change won't affect other 
platforms.


Best regards,
Jun

