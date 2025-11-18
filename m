Return-Path: <dmaengine+bounces-7237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39DC66D99
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 02:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CADD935775F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 01:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117E26C3BE;
	Tue, 18 Nov 2025 01:37:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023074.outbound.protection.outlook.com [40.107.44.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2C304BB8;
	Tue, 18 Nov 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429831; cv=fail; b=h3rasr3wVlF3azOS6BM3Mrpyxvl0hpBkhZKdpqtm8nG+vB4dML9j6ReF17BW3iMOj5YFRp/pknqFxDKINTDL6/cjWThf1j53KlrglGnwQ1fTgLGUk0oPcjKQ98eKlP2tDnbINejhzpysh8IzE3fvnNFhgMqWIoCOCrc6hYhcv8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429831; c=relaxed/simple;
	bh=3rn0ZqUBpN/ge4G6Ws8FjTXFisj2SCmn7cDCs+FOt6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C26yN/CuBU0kddT8b7t2DW5OLhIDM3PhJUtw3jdTfABWy86rs2DwWEQ/LC72oA0zUOQsGkRoCxh4EzvSaAQd9n6XxaXe9rnyzDjWpcuF584ysgWWq1EXKPxhve7j26kaFOhlSk14CIxkQEdol5SWOl8oYo5XOH4vacjzxtBY0oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT7K93d/OhlneapWOeL0lersvVwBGOcp0CmaS8W3HlBz3q1nXDpiAs2htSneLhdq9L6WwTQ8RJSKPPO4YACabcQwVXgxA3fP/9WbfvXr9ur1UZvCODePxEKh8MFC6G1/dEE5H+RHh4xDOsGaEj0hPhKV7dTpjJEHd75R+uZm5viVcLvdmM8J/WttGliNMtU54vPwIIh67br7bNF1VG5tVqvE5IxFJmsQ7BVSYRjKmv92iPPmLqYa6Nbrg1wZtKozRhJWhEpjQ2uvX3lxqKy5joH04WdzZHtA5qQrWHlfMCWMvo6otDHpTP3E/DLc+TLRJChCSkWiusoPPrdWExouww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehmocG0wTtlacCkfjaU5Pr3pISe+y0EeoCTHiGbEF8s=;
 b=X0tDf6kXrmxghL/eI+J/a2Wxj2Hjo/FvB+i0gEV4nuHJ3fGq7T9Rgn2NERNm1kiRKamd1tZ2TtH2drej0cWbbqbFqe1W5WrW4CU7QZmHL0x0H0lgWVW2punaciv+FS4TVJGO6uv+yXkYKx9usei77/FEWUCsCaaxKJdXo2sCxbLCDY7EJPGAMm7/u5BFCwk/OVDdHrXYKIy/JMFybCFO566yecMWGiVvs2BaEVR64sEoB8JOM5+HHTj1aQFgel8P4pJCMysgX8Zd4K9Kq8KrorCLDmdZ8QfkC0oSVOdeOpKVnRNMhrNO4Eo0PC7wFGHFcaEiQCO3Wg+0ebIz3IbKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:300:5c::13)
 by SE3PR06MB7959.apcprd06.prod.outlook.com (2603:1096:101:2e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 01:37:04 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::e) by PS2PR02CA0073.outlook.office365.com
 (2603:1096:300:5c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 01:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 01:37:03 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7F3E840A5BD5;
	Tue, 18 Nov 2025 09:37:01 +0800 (CST)
Message-ID: <f32810d7-64a1-4d29-bdf0-04b9930faf15@cixtech.com>
Date: Tue, 18 Nov 2025 09:37:01 +0800
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
 <08142bd3-4a17-4c4f-88ff-fd81e9941a18@cixtech.com>
 <7df26091-97be-4494-8140-5e2ca54780ea@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <7df26091-97be-4494-8140-5e2ca54780ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|SE3PR06MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 1891966f-d361-46e6-8afc-08de2642f9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVZMTCtjb1VnWFNHS1pOYmRCTVhBc2pKQ1luVHFWVXhjdzVObG04Tzd4cHBW?=
 =?utf-8?B?cmcySWJEdWcxNDJEa2o0OFNGTzBta0M0V2hqMDFoRVlIUkxsemRMUTF1L1BN?=
 =?utf-8?B?SWd5M0ZEM0lVdDJFUGgzbTZOR1VlTzJxeUxzS295eFBPUmh2YmhRNnJSbFly?=
 =?utf-8?B?WVZWd3pSRnlVWENqZUYrcTg2NkpEdTI5Vit5OGdvM3gxTnBpSnJtZ21UTmtX?=
 =?utf-8?B?QkhFVFRoYVlXUnNWU1psTm9SQlVxMndKdG51U2FVZmZNUkVuMk9qQUsydWZ4?=
 =?utf-8?B?Z1VzbVlabWYzdmxzcUNJZElTTUpmTjdmV1E4U3VUZWc0ZDAwL2xFM3NYSzdr?=
 =?utf-8?B?NmNGTDBEZ1RqL1orMjlpZ3VGM1BwTS9YN3o1eWdnRUFWcXFKVmRSSDdHV09V?=
 =?utf-8?B?ZHV2NW1TQ1dlQk5obFprRWJHaWFYbE5ncDhEYVhqRVRvWlo2OGNCLzhVdEpO?=
 =?utf-8?B?T3VsWE10Vk1lSHJoZ0RuTmwybzhNeUZ1aDdxUU9BTzhHbVhBdnhQZVNhcFEw?=
 =?utf-8?B?cUdzL243Y3d2aStpdEdobUsyK3ljUnJ0NzRzVjdHOHpNV2N1ZCtJYm93c2xi?=
 =?utf-8?B?VkF5WUZ4RGp6dVdQbXdCVTk0cC9qQk5jbkZCTS9kVWkwaWp2Vlp3NnRnL1hE?=
 =?utf-8?B?R0s3OGpjTmVJUm01dVd3K1lDZ3FsbTNSVFA3VnlVQ2RjOVN2ZlJtR21hWS9R?=
 =?utf-8?B?WEd5Mlp4UGRqOStBZFpRbW9EajYreFltWldURnlYSVBEWXg0V1ZUZktpT3ZI?=
 =?utf-8?B?RU8zRWd2N2Z3QWdqUUNrVEVuT0tXVW1yMFBUeTRpd2hBcXdteGpKQWhyZjRh?=
 =?utf-8?B?REQydGJtTHlrSk10L0F3SFgxUElPQ3p2RDJZdi9Gak9ld0JJV3hyUW1JdUdN?=
 =?utf-8?B?UDdteU9JY3dhRGZuaWdzTVVMSnZCdm1kdWFybTFxemhoTHlYZTJ6S1BkUEow?=
 =?utf-8?B?Y2h3UUlvQ0tORFN1YStCY1NUVTRhR0IxMWtWWExTK21GRm1pcmNHSVdjL3lK?=
 =?utf-8?B?c2FwZjFRNHRPczBhYVNEU1daL2E4L1BEQWVRQlJ2MVFzQTh0bm15aGtJdzlL?=
 =?utf-8?B?RFl4Q3lFU3NCdnZIVERSVEpwczNZZG9IZjBUMFR0NnBRUnNMLzZTTjBYUmds?=
 =?utf-8?B?RG9XeVJFdDBITTd1UlZnZmpQRVp0NDE5VityOTNKN3EyUG5mWitZc2luSVhV?=
 =?utf-8?B?M1BJUTBKYUdUZ2RsSjF4ekZFUUNsWnNHSHJ1akcyWVdNVjZmZis0TnlRZjFi?=
 =?utf-8?B?eDh5NnNMcE9DcjdFU2NyR2FzYmk4Q2c1NVBXTWxPYVY0eDU4U2ovcHJYKzBx?=
 =?utf-8?B?WStLZytZczZUNGNPRWowQXkrVXZoVnBMbThKczFiaDNuSzNzUVN4bFpmNUU3?=
 =?utf-8?B?TWt1d2kybnYwSXVSSWo3M0xuRXk4QXJzMGhmdTByaXl3dUZWblJoT3RRVk5z?=
 =?utf-8?B?UkpseGU5MHI4aFNSMi9EYXFTbzY1VGRXalpjcmpIbk9hWXkvdGFwQXkvZjN3?=
 =?utf-8?B?SW5QNm83aEE5RkFMU3dXVW93YWZ4TXJ5VDRoUXRFaDFvbkk1Tzl6ZkQxMytU?=
 =?utf-8?B?dG54Vm13bm5SQ2dUOHJOWnhBT3djcHBEM1RwNmF2a2diUHlrNysrUitRRXZH?=
 =?utf-8?B?RlJ6Y21JajhFODk4a285ZDdwYVliUDRzS2ZjdmhYQUZJeWZmbk9MZnhXUSs4?=
 =?utf-8?B?T2hidTRKcUJqSFZCVTFDaGxOR2ZxQ1NxcUZRODZ1WWpWdjJ0c3AxQkFEVmVJ?=
 =?utf-8?B?U21rRXhDU3k1QU52YW4yVHA5OEl5WWx3bmVBczJPWGVRZS9PQ0hSRHZJdHRJ?=
 =?utf-8?B?bTRFRkFtUGpvYm5sVDNjRHF3bXVvdncxM0E4VnYzM3N2NUZwZURjWC9TUGhN?=
 =?utf-8?B?Q1BhYlMyalJXWGZzZm9ucTNoMWluTlhIay9RdTJkY01YSkpPakd5dUtNeS9Y?=
 =?utf-8?B?WVJxMmJDYWFpUHZjQ1NrZDNsWVRMZjdCUU44VEpqTGJ0Yis1Rmw0ajM4OVdZ?=
 =?utf-8?B?d3hOMVhUWmxiWHNNSkhOVklvanpaU1JHYjQrQjJva0pGM3VYd3U5d04vb0JI?=
 =?utf-8?B?VUlMMk5XemZZRnhmWjFpR3g4dlBhaTNwM0VLK01Kd2F1am5OZ3Vob1c1b2kv?=
 =?utf-8?Q?2aD2idf8ndnSe0UD9zvmF8yJ1?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 01:37:03.1855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1891966f-d361-46e6-8afc-08de2642f9d1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB7959


On 11/17/2025 9:29 PM, Krzysztof Kozlowski wrote:
> On 17/11/2025 13:51, Jun Guo wrote:
>> On 11/17/2025 3:13 PM, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL
>>>
>>> On 17/11/2025 08:11, Krzysztof Kozlowski wrote:
>>>> On 17/11/2025 08:07, Jun Guo wrote:
>>>>> On 11/17/2025 2:11 PM, Krzysztof Kozlowski wrote:
>>>>>> On 17/11/2025 02:59, Jun Guo wrote:
>>>>>>> - Add new compatible strings to the DT binding documents to support
>>>>>> This is not a list.
>>>>>>
>>>>>> Also, subject is completely redundant. Everything is an update. Why are
>>>>>> you repeating DT binding docs?
>>>>>>
>>>>> Thank you. I will incorporate your feedback in the next version.>>   cix
>>>>> sky1 SoC.
>>>>>>> Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>>>>>>> ---
>>>>>> You just broke all existing platforms. Please test your code properly.
>>>>> The patch includes proper checks. Since this platform is the first user
>>>> Nah, tests are here incomplete - look at the binding and DTS users...
>>>> nothing there, so you cannot test it.
>>>>
>>>>> of the driver in the current codebase, the change won't affect other
>>>>> platforms.
>>>> NAK, and you keep pushing... I just told you it will break everyone,
>>>> which is obvious from the diff.
>>> But if that was intentional change of ABI, then could be fine, but you
>>> must provide in commit msg proper detailed rationale WHY you are
>>> changing ABI and WHAT is the ABI impact of that change.
>>>
>> I'm not entirely sure if I fully grasped your point, but I also
>> identified the potential issue. I've reworked the patch to accommodate
>> both the default DTS case with a single compatible string and the
>> scenario where platform-specific compatible strings need to be added.
>> Could you please review it again and confirm if this aligns with your
>> intent?
>>
>> properties:
>>     compatible:
>>       contains:
> Which example uses such syntax?
> 
>>         enum:
>>           - cix,sky1-dma-350
>>           - arm,dma-350
> It's completely different than previous, so I don't know what you want
> to achieve, but maybe you wanted to explain lack of compatibility in the
> commit msg. Anyway, send proper patches with proper justification (and
> for above would really need to be proper).
> 
OK.Thank you for your prompt​ reply.> Best regards,
> Krzysztof

Best regards,
Jun


