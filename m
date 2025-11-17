Return-Path: <dmaengine+bounces-7196-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60019C62ABA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 08:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07A804E9E3D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71C318132;
	Mon, 17 Nov 2025 07:08:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022093.outbound.protection.outlook.com [40.107.75.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84640316914;
	Mon, 17 Nov 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363323; cv=fail; b=mc7ffB5O4Nl4lKaomtpDzV4aIVnSl+CmtHCCBPu0Nj2kHm54397Fvi9iSYF+QGDVAWf/9++ji390FLWdP98zZiIS0dLrhIC70eLD1yamY1V+8yo/jakeD2KCdfm/XebXRODSArT+N/zE9OfnD7m/MlAdy2vlzWs8WoHVDYUlEMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363323; c=relaxed/simple;
	bh=7pyzB49E8Dwr8iYrLPckhezQuLpbLTglI0naGzp39P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm2UdB2+0xJfN41UqJN1/91qbBUq+Brmw01rJOkzXXLOgU+RPU8jSZJvEg0OfeZ1fwDoJkdoNSKc/fq//EM1bSHU+RVDv44nY90eRkO/UDpPf4RoOBcwT/P22oIbi5CtfjKOa9I+rzyHSp9FAjy87qYazZ3dYSFXTPLMODhfTKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+pJE5x5mSbdZyGOADCLaej30nP9X34K6qSL58ECi0V1xcnSVX0zPF5ypQdNc5bLqUOLDNDlgBUdJ0HXKqDSbT2HTvmRaMxjfYDb9X6Elh/g4f4vMRha0B+C2onpC8j5fwfLCENX4jiySLWJ+ydRt3P842nbo2jFoLB9fUrV1k2vpdiWX0NWCeRRunVGVXKztb5PkFU+tRvdXtza1Bou5LCfFCV5lPylX0MWiMLu4ISx1dH7UNEXNb6TUH6H1OX//PBfDJwRQ/CjmZfXOmtfRbwOqBD8uZ8keX+ivQkegFj30splLC4jCAGXTrIEnBnLUlQHHYI5cG3rZTpNWkUm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJDLjzYzksEaUZj1huOx4aZsDu5ZfxQ12UQNcEnFG8A=;
 b=AsCJNaXmaOtZYdz76jjk83ldooRn9vDhO3Ek/uqlPWwc+i9JGYH8AUYmNtrODqTg/M3Ir1MvbDHgt25RE+ANn+zJQo4AnXH/ljAdap196WxU7rDJl6Z2XEa/vIDwq8LzHOgBhLxCTo6utVd7q1uG8MWWQkwm68e9LuwfgPjWin4DzwdyIpdj2EQxmJVsXY+kxXiVGA/6dVhQmxoXDzjRhnoDeE5Y6guWlaEAOmJOYhvPOtouL/+EtQdjj7PO/blB99kusZN4FntfoAG7DS8zX4gebaaTP8Oox9GBRvUv7lkHN8pdOKs+NZBvAYES96gP8/Ygwojxql9Wx/or8i3WHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:1f5::12)
 by SE2PPF06C2A6398.apcprd06.prod.outlook.com (2603:1096:108:1::7c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:08:37 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::6d) by SI1PR02CA0050.outlook.office365.com
 (2603:1096:4:1f5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:08:36 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 88F3B4126FFD;
	Mon, 17 Nov 2025 15:08:35 +0800 (CST)
Message-ID: <2d2d54d8-30c7-41dd-8d95-b95fa56e4c8a@cixtech.com>
Date: Mon, 17 Nov 2025 15:08:35 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: cix: add DT nodes for DMA
To: Krzysztof Kozlowski <krzk@kernel.org>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20251117015943.2858-1-jun.guo@cixtech.com>
 <20251117015943.2858-4-jun.guo@cixtech.com>
 <70fd6151-905b-40db-a392-df458deaf5a1@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <70fd6151-905b-40db-a392-df458deaf5a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SE2PPF06C2A6398:EE_
X-MS-Office365-Filtering-Correlation-Id: edfcba42-3748-453c-0e42-08de25a820ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekVoaVBKMW1LTGhBTWovYUR0M3hkb3JzTWNTZWRJSHFOV1JSa0dpdTlCQ3lH?=
 =?utf-8?B?b2I1YklwUEdNWmkzeVp3NzAxVlNNdzVLcEQwYk9MQkVGTjRWdGh0SjMvSGh3?=
 =?utf-8?B?Z0RDblhiaGQrbW8wREpDTCtCdHVZbzEwMmVrWVB1amtsSE9zdi9IY0R5a1Bn?=
 =?utf-8?B?K3did2M1NWVML0dRUVFMelhFYmpaM01EVUhtWXB0dU00RisyRnlLNGdqY0Qz?=
 =?utf-8?B?YmdiTk82TlB3RUU3TVBQamhUMW84VUZqN2cyaXN1QzQ1U2h3SjJqdU1XQ0oz?=
 =?utf-8?B?QWx1R0w2akVaYmlRRXRsVHdRclJNY1FRTUp4WlkyQllPSjNMSEFtclpYS08r?=
 =?utf-8?B?aU96UTR5TzdzVGs3MnAzUnNaVjNQQXdtbDJhOUN4YllZSmQwUXBaKzkvejR4?=
 =?utf-8?B?ZFZnckZPUThJRXNJL2NWT0QzNDhyYkU1a25DbmNRUEV0Q0FrK2FVSDJFOUlL?=
 =?utf-8?B?RHE3d2JlNjVreXlsOS9rc1hFQVRGQnNaT2lsYThkRnFBOU83bThKSGtEenB1?=
 =?utf-8?B?TW1lWklrRmpwZDlaVGRtZGQzWVk3Yzl0UkU1dkxxY21qOFl2VFpYSUNiMm80?=
 =?utf-8?B?SG1XM3NKa21VdyswSWFwR0p1SHp6cVcrcjlLL0pHNDQ4aGc2NDBZL1FDTHZa?=
 =?utf-8?B?akJCNlBtU2tPQWV1MkRtNVNqaU4xTUt1L0xnRFlnbnFVTHZrSW12MTVzVlhl?=
 =?utf-8?B?SVZ6MzBRQS95eWV2QXZ5c2E1ZGMzNjJsVUNTclM1bUJJSk8xbnBFYWxkN2Rs?=
 =?utf-8?B?UkN5aVBXKzg2ZGN6cHdldzdlbTNSaml5WkYwNlNXL29VcUNHM1ZyeTlYVU9H?=
 =?utf-8?B?UHBMK3lyWkpUY0JVaTlBTUI3aTFFakJKWGVBZ1VXaHlST1NxbC9SUTNnMFpK?=
 =?utf-8?B?MWNVTTkrZ1JmMFpDU0IxYUhjUDFaTnpkbnZGRlByeVRVZmovN2Q1U3hxUnhY?=
 =?utf-8?B?Z1BVaG54WUtydzlFTGR1d0hLVlVlbnd3ZEl2N1BzN2RhMGtxK0RBdHpmek56?=
 =?utf-8?B?OVlwYU9LdGxKdUZhV09PWTE2UTd1WlB0ZEtjNFpGakF4dWZOdmJjMmN2M1hl?=
 =?utf-8?B?UEtLZ3NDT3FlQjh6WE9nM1lyWVZLU3RHN1dpcEFhMnYrdGx1SVNMMTNhSXBq?=
 =?utf-8?B?QXlXRldYa0ZMZXk3LytCQTRrR3QweXJLNVQ1SzRlTFJZWDh3R2FoQUZCRmxj?=
 =?utf-8?B?ZENvYWVYcUdiMzVxVmZEcHdIVlh3NVBJc0IxQzhpOGc4NjlCZEIvaFdoZjJ1?=
 =?utf-8?B?WFFkT1h5UmZYeEFadWRhZ1JYazRpRldCdnhwUFB5QmkzZS9IK3A0amdZcXJt?=
 =?utf-8?B?QXpYZElrSWF1R1R5UU9tVmd4RzlZY0ExWXQ1NlR3KzA1NnFSeDRmQW9IL2Rj?=
 =?utf-8?B?VE1xd3Z0eHp4eFBWWWg3Um9ocFhwSVdnWG4ycGFnSDN1cTR4UkFnMDFjazMz?=
 =?utf-8?B?Vm1CcS83b3J4SHZJTHM0bzIrYlJ1WnY3NWh1OW9wczB6OXdUVDREbTc3Um04?=
 =?utf-8?B?SW40VWt1WlRJTk1YY3Y1NXh0Ny8zbFV0U1VwU3BMU2lkRHcwVmxJWHlsdnBS?=
 =?utf-8?B?V2hTSHpBUTY1aG1hWnRtRVhsc29qQnRBWDNkQW5ZcDlxQm1vbU5jaFcya3hy?=
 =?utf-8?B?T25zY3NFeWY3RTFEaStNa2FkUXlBdjNLUk9YRlVIYmNvSXUzY2N2d1FqZXlW?=
 =?utf-8?B?cG9NSGsrWmZsMHJNOFZ1ejN5eWZIdEpUbTRXWDQyVlhzbXFHTnVDcUxEbzZZ?=
 =?utf-8?B?aklyRUZsYWNVcGEvM1BTZ3Fwd2h0OW43TGhrczgxN2JXZTF6OGtKbmN6MlVZ?=
 =?utf-8?B?OUJIVUFSM2Noc2dSY3BzYTNzaENpN1BUSUY2YVYwWTIrbFZtWkcrVUoxVlVF?=
 =?utf-8?B?UGVGQUFTMTlIZmIwWnpqdklnYnE5Y2xuMzExR0t1dUNLTVRmRWtPTytydmU2?=
 =?utf-8?B?aWJDTHp0aTlpUFN2V0xQV1lPbHVPRTI5V2NKSnpNTUQ3am9NR1BrOXVON1B3?=
 =?utf-8?B?bmV6c0FoUFdqdFIzM1d6d3JsLzZ2dXNEYmpuU3lCdjRIdHZHZkoyd1FnUDh5?=
 =?utf-8?B?WXRGOW1KZDh1WTNUb0lZQWJMVlRsa2U3dHE1aEs1ZHZacmNMQUVnRzcwaGJa?=
 =?utf-8?Q?l4R/zrBjO65AdADPY9+7qGnUa?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:08:36.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfcba42-3748-453c-0e42-08de25a820ae
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF06C2A6398


On 11/17/2025 2:14 PM, Krzysztof Kozlowski wrote:
> On 17/11/2025 02:59, Jun Guo wrote:
>> - Add the device tree node for the dma controller of the CIX SKY1 SoC.
> And here again...
> 
Thank you. I will incorporate your feedback in the next version.>> 
Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>> ---
>>   arch/arm64/boot/dts/cix/sky1.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)

Best regards,
Jun

