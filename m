Return-Path: <dmaengine+bounces-7205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF6C63F7E
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F01D3AAD68
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E58632936A;
	Mon, 17 Nov 2025 11:57:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022131.outbound.protection.outlook.com [52.101.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752332C312;
	Mon, 17 Nov 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380675; cv=fail; b=iEyMwy7x/vSDwW3vH/Uu+uVlVfcA5LXtJ24iHVgNPww6OWiLqIj/zFclRpfxdDHy142/b379/5NCsonGSWn4CVSuipmsMu+dpkOAXnM1ZqQRIHn7/QUABReKdNBmUhO9JUgfNlNuY71rRc7DOeo9sq9e0VFQy+YOtIVtgaH4okA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380675; c=relaxed/simple;
	bh=i3pLgTOdlz+EPcCbNJWgiMz1NxbTAyjCwsg/17UGTUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GU38kQ3UXmXonk7F8a0dTPwk1WDT7CmRv51rJULI8ipHQsnlQfuCK4pZjgtZCP5SBEDL3CfQVBzs5qTI2i1Nhn2ehu2ph6YwQ7fXtXx+SjRj8uupIUxocFziXJ+VX+VS2n0bAvjXVj8GMfcb7UVYQX1ES+P/b0VXfWTHeJlO5rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJzXvnWwWzpLhlUgTDGejc7YBBi6Rex/IDx7/YJ+nb9xCZvA6vvNMOTiU3zDdA2EfS5ImCzV2pXTkyNlV33aq0B5gaiKyvL4swZ04HJfSQsSOvmU01IS+s8yANrG6jqCHe/Ro6JN+UmQm5OQAmnS476iqLL6IWiBDUu5aqaSiBwiXyOP9CuTVou5svGBJCwKwq73ilHs1Nx7iQUukRzdpxWKnL/FrPSmrabk5d2s9ouLV2K1XT8QeaxTJHuo76gvIUqQqmS9ML+RKw5S1ElIrEU0ulMfNENx7dfsOCxtwfZ9NG2/0Ri3DVJLWeaM4384z2iJI1vcm7fsTdhYuXCTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgligFAqVr4izT5/vilAqi1h82s3ni0bJNuUGYlgtgA=;
 b=ov6YW7+SM5LpeKBmNqe6R40c6RUEGRX2YmDVL7vZzNp/FGONzWzSeh+NQQL8LRBcr7fQzsn59ye+ABgVDo9hNVVZpZyqcsxRN0RKAodk4YcNFKOFKK4jQLqanGORSIddD1nx4BE5w29oHz9+0XHdo0G9c35QkKRUt6Zv7BtK3F+6PYnkwGOYnYQ76Q5lAZTHxAkaFAWMpyCdOWcOENakNIhhS8NfBeOfRen+CwHPZT4LZRfQ9EeiALAxyyMnsVyV0XrFdgmVQpOg0+/nQe13l7Cf7L04QulAbdEA1E2/tHAgKu/ZrFN+A1PKb1Jkf4xW6RPYE86dfWp1gbFS95at4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::18) by
 TYPPR06MB8036.apcprd06.prod.outlook.com (2603:1096:405:313::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Mon, 17 Nov 2025 11:57:49 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::96) by SI2P153CA0009.outlook.office365.com
 (2603:1096:4:140::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.2 via Frontend Transport; Mon,
 17 Nov 2025 11:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 11:57:48 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 032A841C0143;
	Mon, 17 Nov 2025 19:57:46 +0800 (CST)
Message-ID: <9b3bc85f-aa32-46e3-9e95-81490ddacaa0@cixtech.com>
Date: Mon, 17 Nov 2025 19:57:46 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma: arm-dma350: add support for shared interrupt
 mode
To: Robin Murphy <robin.murphy@arm.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20251117015943.2858-1-jun.guo@cixtech.com>
 <20251117015943.2858-3-jun.guo@cixtech.com>
 <00586912-661e-4092-a69d-87defe26db59@arm.com>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <00586912-661e-4092-a69d-87defe26db59@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYPPR06MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 826445de-564c-484c-7ce3-08de25d0873d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVh2d056WThaRXBxc1ZtTW9TSW9OOS9kc0M5WE1jNStGcGFZYnFqU2V2SVI2?=
 =?utf-8?B?UnlVTjVnTWRvVytpZlBaVDA2ckVZcXNUdWE1SnpEalpyYWhYaGpCeG5jcnZ0?=
 =?utf-8?B?MWNZWnQ3U0g1R3JyTlUrQlpjaG1mTkViYXUwdDUzWVVpOUp4L1Bhb3U2Wk1T?=
 =?utf-8?B?Rm9LODRkUjJ2VTNjbmlWNzgyT2loNktTR3R1MDgxNEhLMXovanRwRU1Ea05B?=
 =?utf-8?B?alpQajFiNUpSdVlSVWthelB2cGV4WlFKZ0JVcHVTVndnZ2Z1ZDNoL2RGRnpq?=
 =?utf-8?B?eXhtZlBHRGRjclBLUkRFT3BvMk9HRWpZRUJCNFFWVWp3M3ppbkdiRWwrVkh1?=
 =?utf-8?B?b3kyZEVXSm93Znp5M1I0U2g3OERCS2dqckg0Vnhza0ZrdXFzTGlGYlhDQjcr?=
 =?utf-8?B?aGVXbjNncmlEaVdMYTFxMjRJd2U4Y2g2Yk1uRStmTVlMY3RWejZBcmJpSnhL?=
 =?utf-8?B?bHpIRUNGTXYxYmltNk44SVNON1N2RjNqM3htQjN1ZjNLK3ZHTzBmaW9XLzJj?=
 =?utf-8?B?eitZWmxMdVNxYWNWU2dqV21xclUyQVp6SlR2UkFnTVVhMjZQTFFMczVVVm95?=
 =?utf-8?B?ZW05ZXIwbk1PNGw3UFptZklIMlhYSUhPUCtMV0Yvb09hYTNwNmRhUDBMaGd5?=
 =?utf-8?B?RThJaXgxT0lrb3k2dDNsTG9XVDBHZDhTU0FqNkQrb0g0ODA2eS94V2t4VHZO?=
 =?utf-8?B?bk50MDdoWWtvcU5iK3lWdlBFbXlxcnhyWEZTZkhnRmZnOFphK1I0NEhlVE1N?=
 =?utf-8?B?Unl2NVp4SXhabjhKa0RCVy95U09SeVBCZzRJcmpvR0VyNE9mUnBSWjFOam5r?=
 =?utf-8?B?Z0VIanBUR2MwRy9Ca3FhOENlSldXL1pLNEZ2SzNRa2dKSUlUcTF5a0doaWdF?=
 =?utf-8?B?TEEwV1JYWEgzSlhpalB1K041cUlJTFNsUS81NEUxSFkrVlppdE1JaUJVdnIv?=
 =?utf-8?B?Y1lId1c1aUJzajFyMFhGOWE4WWtuN3pFWXFPclFCbVdRaEhJNjBZM1Y4UE85?=
 =?utf-8?B?bTJiVzJsd1RiNzlwdTRLNk0wczJ0NVJ6UEdGR1pKdGNXdXJqRDBxcmJPVjVX?=
 =?utf-8?B?YlRCcU1rUTltZ3FuK1lVU29FR1pvRkpYbTVaeU1xYXZBOUdwR2lGVm0xQ1Jy?=
 =?utf-8?B?eHArR2xjeE5aa0EwRzcwTnRLbTNMZzJiQy94YXp0NDRmYXoxMEljMys0cXkz?=
 =?utf-8?B?QnJ0RWdadUNWWENsK3NJTFJTdGw1d0d4VWVNVDJiS1E3ZGwzSHB5VnJTcGN4?=
 =?utf-8?B?M1l5Vm1FMGVzUExrd21HaVlLbDBpczkvenNOOWlnR01JSTNTZWlHcGFTNGk3?=
 =?utf-8?B?TUgzWEVGczFTNERmZWFpMzVQVDlTYXhvL3BmM1A0WFZpZjNRMkl1ZUpETitj?=
 =?utf-8?B?RVVLSlpJcGRmenJYVWpIbU54TmZTdy90NlNqdjdWb1dnckVFdzl6VWt1Q29s?=
 =?utf-8?B?MmViVzhYbGFUZW9PSEt6L1JnR0JjcnpySDJLTEVNU1lIMGFINlQ1UVBIZ3hH?=
 =?utf-8?B?ZmxOUmExMlJMOEpOSnFtOWxvZlNUaks5ekxKZ0dyeENwRGRVQytNQ0s1SEp4?=
 =?utf-8?B?WUlLcVJmemZEdmdUM3JoVzFDRTBoOUl1Y1RZSm5oelBNOTVvMlpnd0U2TENu?=
 =?utf-8?B?YjZpdTlnMFdIWTQ0MXNNUktiY0g3Wmg5MWFId1IzQ3ZKVHU1clEvVWpQSlJt?=
 =?utf-8?B?SlEveThFajhyUjRXMndPbjhUaEUvc3N1RFFzRFlsWXF6SGN0ZnJyeXJLVVV5?=
 =?utf-8?B?SDk0VXg0UCtBQzVRbXJtTGxjeEFCZkdGMlc2SWFVWEdMbFFVT3J3cHpucm9T?=
 =?utf-8?B?TUIyKzdlakhueEEzSEROYjdMT0lKZyttTk9waGp2UWVpWUdPVnhiUmJMYlY1?=
 =?utf-8?B?bXN0OHJ0SllyUVd1aHRUOHhOSE9nVUp5ZGp0eTZmeExwd25MWUpWay90ZEpN?=
 =?utf-8?B?TFhnWVJFdzZDcDZkd0E3bk1HOGNtSDFxS1AvemhvclMvMUxvelUxeXlXakRC?=
 =?utf-8?B?QmZmWGdTVnlhT1V5TjROUWNGaUFMbEFlRldUZGE0RlJhblVxQlNjMExIUEgy?=
 =?utf-8?B?RHJ0STBWcjVkTTM4YUZPZGY1UU5HQllMZzFaQlRCZWFoazE2WEsxV3YxOGxT?=
 =?utf-8?Q?WE2E=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:57:48.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826445de-564c-484c-7ce3-08de25d0873d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8036


On 11/17/2025 7:32 PM, Robin Murphy wrote:
> On 2025-11-17 1:59 am, Jun Guo wrote:
>> - The arm dma350 controller's hardware implementation varies: some
>>   designs dedicate a separate interrupt line for each channel, while
>>   others have all channels sharing a single interrupt.This patch adds
>>   support for the hardware design where all DMA channels share a
>>   single interrupt.
> 
> We already request the channel interrupts as shared, precisely because
> they could well end up muxed to the same physical interrupt line. I
> missed that the dedicated combined interrupt output had its own separate
> enable, but for that we may as well just set INTREN_ANYCHINTR_EN
> unconditionally - the rest of this seems pointless.
I'm not entirely sure if enabling the INTREN_ANYCHINTR_EN bit to 1 would 
affect the current default scenario where each channel is assigned its 
own interrupt. The hardware design of the chip I'm currently working 
with does not support testing the scenario of individual interrupts per 
channel. If it doesn't cause any issues, I will change it to an 
unconditional configuration.


