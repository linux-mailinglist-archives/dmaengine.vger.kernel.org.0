Return-Path: <dmaengine+bounces-7206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF98C64379
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 13:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 389D028E48
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121A3314C2;
	Mon, 17 Nov 2025 12:52:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022138.outbound.protection.outlook.com [52.101.126.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827132E73E;
	Mon, 17 Nov 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383928; cv=fail; b=kspOdjjH8h6wi9vLS5v16uuYtHusIcSnanMnxel479r0mIpA9PErH/gLeJUVy7rkBFDF7zPt7qnJXpx4qOOkQ6Cs7Gl7KpBLTcwL/Pt+jnzKUccwPtaP8/SifhQbiU853Eca/tU3cOez/RVb7N8/we/yoStT+uIrEyLSkkGbpP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383928; c=relaxed/simple;
	bh=oGYeYgofvUcpwWFVV5iDyOSlHu6FItUrWHmRq9Ujk6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJS32njrBTMMxdslk4ON1bSsP6Rw5IANICyEBZIQ2TTbwQfk7VKbEKCPIqOlvdMSq1lSWWHI7F3Ufrwia3wYvV6vO8lurCWazrPMlQl8BcAKp4Fnfc3YBcO/iy+XHCUnlfg0xow1yGxsw/9jciUalw0BMAvdTN+TS2WXedlnr6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3wKZPinBMHAHzrWY9nJc5o1lBA+LeWB0LRtqylyLKZajQqLvDDVmtzjg3XWv+Mi1bb5tqU1H+QK9wwln18PCGddIJv5w+bcen+A7wxQ9Zs+3YbYC1+cGOaot4qnFEz2bGfebik99/p2m+g6i+NxNrn0vyVU74ekH7as3lbqIWEtTf6L299qOmkJsqYTwDswJsq3/oNJ1ndjHZ47nMu1wjK7gSNu65PLmNlCW18e+lbsH2T3UQ4qmCAO/8U/Pnn7MOXadapsKiR5Ial9QxqqlFYErVAFS5oeJWb7+4/hAGq7RlF/xEc06TDoFptlYW4u6UiVPKaq+Q+rgzS7ATNiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3xseSfgGSk8z8D1AyjLt0MJGVhHLoyQosqZuz8elzY=;
 b=PnhBvfF4DvEbZWb4Ih4BBHpAAHFE379i4Xg01tI+T3wzBoeOvZ5oh4Xls3IOzR2Jgj6gj69PazQ+E/McLgt7XIPQCYfrPg2H/7XkN2hQxhQwV81kxETJtb962mgzFAGaGutnTYrTWIlMe/ZI2oecZh4DKKzwy4kyXYJkx0eDm4lDPMhE8HFABCTZf+WNmxl5amA1sksq6fzUtTEVsBYbsPmNt5zQbdepEvyZT8pbsi9u1CzMqX/s7KVExCb7f4HWMV2sb+eLci3GcqtQNOz06kOyb0PU+P1LGL4IFKKE04xKHlLsV/CQpw6HpI+bBP9OUzjemQYYDSALI9a1Ao8+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:4:188::12)
 by TY0PR06MB5404.apcprd06.prod.outlook.com (2603:1096:400:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 12:52:01 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::be) by SG2PR02CA0138.outlook.office365.com
 (2603:1096:4:188::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 12:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 12:52:00 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 73DD841C0145;
	Mon, 17 Nov 2025 20:51:59 +0800 (CST)
Message-ID: <08142bd3-4a17-4c4f-88ff-fd81e9941a18@cixtech.com>
Date: Mon, 17 Nov 2025 20:51:59 +0800
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
 <aea1429d-b67e-4c42-ad19-88d04f69467b@cixtech.com>
 <024eb64f-74bd-4170-a6c1-09c4af647926@kernel.org>
 <62b59d52-7107-4426-b922-812d343195db@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <62b59d52-7107-4426-b922-812d343195db@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|TY0PR06MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0ef6cb-06f0-45bd-2bec-08de25d819ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVo2Z0drUTR6c2xnaGc5b09KQkYyN29VbVZBQlNUU2Q0SFV4NG9KVXJTTmF0?=
 =?utf-8?B?WkFJYmt2SzNOREtlVm5OQU8vZXk4enVkajk4T1A5ZWJCcDJCOVp6VCtQRXJ0?=
 =?utf-8?B?RkkrT0s4UnVoUWo0SnN1T0ZKdmsxTVlEY1ZvTFUxVHNCR2tpdXFtTUlTVVNl?=
 =?utf-8?B?Y0JybVpXbUx2NE9vbjBUbXZBdUNjL3IxcnNrNUFTSnNKTFlESm8weVcxd1p4?=
 =?utf-8?B?dWNYWGs4SHlXQ1VkZ0tvMUxmbGtJeXFOdGVnNTRmSzBvZ2lOMVRsNjNwd0NB?=
 =?utf-8?B?Yjk0UjVLS0d1cXdhb2ppbWdEUnBybGxEQ1BMUmlLN3NSQm12MTRuRmQ1cGNQ?=
 =?utf-8?B?c0lGZEhOYWxwbGlLSzVFZnRyZ2pBRGRnVHBIbnRpamUyWTdNWlpTQTN6TEt6?=
 =?utf-8?B?ZWcwekk4cU5seWxSUDI3Ty9vZWM1SWhLQktLYkZZU3JVVS9HcktIbUt1TXE1?=
 =?utf-8?B?MkNjZXpzK09lelJETVdITXFnTEVhVHlva3A5akpIK3o3bWlwYWg2MEhIYTZv?=
 =?utf-8?B?Rnd1VnJmVjAvZldSdFdHdTljSzd0YkVtYXN6cWtxNmVpeHZUS2w0eDMvZEhw?=
 =?utf-8?B?aW01Rk5rNy9SblFEYjJwREs3OWl5dm9kZEVXOFE1MG9OSnZIRzIrYjJXTEdI?=
 =?utf-8?B?Y2RhMkJERkRNRzArNnVwNXk3cDNNblBUbmlBOTJKVTlFTW9XUlJkTkp6czlV?=
 =?utf-8?B?aUlOTE9OSm1sYXh5V0hLblpOMXZmejFFVzh2ZWZESXJScUtyRXNlOVNldUhi?=
 =?utf-8?B?WmpVL1NEVlBlejVpVHppdnZOTWsraXh6OCtCaE9UTWJWeng1bXovaCtoanov?=
 =?utf-8?B?V25PRGNOc0tHRjZSZlp0SXVJVnE0MHhQUE9iQjRzbHhBYWVjR1dYKzI1RnR0?=
 =?utf-8?B?dGcwNHFUR3FESXE2MXVsd0U0OWgrb2dPOGFZQ3lCVkdlSzV6WC9tcTlvcVhY?=
 =?utf-8?B?MHdjUGs1bmt4S2xPQkdaaTdTWFowdHF3SHRIbTBOUnNXYWIybGd2VXFnNzJD?=
 =?utf-8?B?NFg5anVRTjJuWDZUczNZZ29iamE5alZwNmx1cGp2V3ZxL3ZmQ2pDN0pZK2Jk?=
 =?utf-8?B?aGIxaUNtVjhiY1Z3Y3p6SU13UG05MlVlQUMwd0xBOGNPeVJhM3BmaitFaHZY?=
 =?utf-8?B?SHN4Z0lKR3JWUHB6WU83aWxOWEttWnBkaGNxVzVjaTBTZU90NCtQcGxOdGJs?=
 =?utf-8?B?eTYwb2NPbFp1Yzd5WXVvRVdBT2E4Rms2NnRMbzBUcVpsdUVYaThMc2kycGlB?=
 =?utf-8?B?YWs3UjA0cGtTUnhncll1Rjd5Q3EyZjliOTRYZnZTdXowdHJSd2ZOa0J0am5Y?=
 =?utf-8?B?L0JiQTBEUFlwaHZ4azVnL0w4RFJ2MGJqblQ3Z1NqMTJYbTBIT1F2NFl5Q1Fl?=
 =?utf-8?B?ZllNYlBPcXFDcDhqRHBLQmpNNmJTbDR4MWtreXZBMW03WUpXeDJLL1IvOEZ0?=
 =?utf-8?B?QkFRNGxVQThsdi9xak5wanFMTlNEY0c3RUhSMms2OVZpTkNNU1RLdnVteldZ?=
 =?utf-8?B?bFlLSjcrOGlnVHRmaHNjek1oVUh6NmV0NUltTllya3hqVWlacWNHWEhvQng0?=
 =?utf-8?B?WDZXeFMvNnpyT3VBeE1SbDhVbzFWV1p0NFlxcWIzT0dBWlI0TGtMTnppUmVo?=
 =?utf-8?B?Q3JFR1psbS9xczgxNjNhUnJySlNaUzgxclJDa1VPMWdSTG51QXJ5ak9KLzFF?=
 =?utf-8?B?NDhBZFJqcmROc0dzeHJxYWdtNjNla2tvbGp0NXNpYnM1YURXK0JVaUxOWk5H?=
 =?utf-8?B?TnJob2VTYkJEcjZiTlBlMldjcTY2eUszRFd5ZWFMdDNRRmNqdmQ0N0pncVFj?=
 =?utf-8?B?bk9UbzNETmlGMWlhYmFtclh1Umd4MExHeEQvVUFWZ3hmSXlTQmljL21vMnk0?=
 =?utf-8?B?MlVLYWVFM254cUZFWDhaUENQcDQ2dVBMTjNveU9EcExsd25uSHdNRFYyN1Rp?=
 =?utf-8?B?MjlpTzJlYmhZOTJTZGtrZEQ3TTA5cHhVUTJKSkRLVjVNN3FrSEFhTmlLbXRK?=
 =?utf-8?B?QjZlZ2YxZ1ZPRXFWWXpjSlhvK3lpdXF3U1lEa0tqVW1uWlRTcVMxRkRacXo5?=
 =?utf-8?B?OS9kcWhaU3NNa1UwbzRVbzZ0T2JJb3FsVkcvVDVXOFV0c0hlL3dDR0pZYkRv?=
 =?utf-8?Q?6CdYPZiASRCZY959UA/tJmREZ?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:52:00.6108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ef6cb-06f0-45bd-2bec-08de25d819ba
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5404


On 11/17/2025 3:13 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 17/11/2025 08:11, Krzysztof Kozlowski wrote:
>> On 17/11/2025 08:07, Jun Guo wrote:
>>>
>>> On 11/17/2025 2:11 PM, Krzysztof Kozlowski wrote:
>>>> On 17/11/2025 02:59, Jun Guo wrote:
>>>>> - Add new compatible strings to the DT binding documents to support
>>>> This is not a list.
>>>>
>>>> Also, subject is completely redundant. Everything is an update. Why are
>>>> you repeating DT binding docs?
>>>>
>>> Thank you. I will incorporate your feedback in the next version.>>   cix
>>> sky1 SoC.
>>>>>
>>>>> Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>>>>> ---
>>>> You just broke all existing platforms. Please test your code properly.
>>> The patch includes proper checks. Since this platform is the first user
>>
>> Nah, tests are here incomplete - look at the binding and DTS users...
>> nothing there, so you cannot test it.
>>
>>> of the driver in the current codebase, the change won't affect other
>>> platforms.
>>
>> NAK, and you keep pushing... I just told you it will break everyone,
>> which is obvious from the diff.
> 
> But if that was intentional change of ABI, then could be fine, but you
> must provide in commit msg proper detailed rationale WHY you are
> changing ABI and WHAT is the ABI impact of that change.
> 
I'm not entirely sure if I fully grasped your point, but I also 
identified the potential issue. I've reworked the patch to accommodate 
both the default DTS case with a single compatible string and the 
scenario where platform-specific compatible strings need to be added. 
Could you please review it again and confirm if this aligns with your 
intent?

properties:
   compatible:
     contains:
       enum:
         - cix,sky1-dma-350
         - arm,dma-350

Best regards,
Jun


