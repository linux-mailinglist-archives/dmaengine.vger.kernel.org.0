Return-Path: <dmaengine+bounces-9595-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENI4JiYwwWm7RQQAu9opvQ
	(envelope-from <dmaengine+bounces-9595-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 13:20:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D22F1D15
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8393A306B157
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8839B962;
	Mon, 23 Mar 2026 12:14:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023135.outbound.protection.outlook.com [52.101.127.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FF37F8AC;
	Mon, 23 Mar 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268047; cv=fail; b=o+FkxtUqs43InLmgzU9Z8v8d4kMoCdWM9Bjza6gGaDrnJt/hENlX8QwY8Copm1oeadh0WRaINefEBWQHO1fD3rvh7oEnI/o8FGkmf2mGAsr4dIkia5Q/fcZ0f6s5ubw6YROmKPsRXkfKU7lOCgKAX4Xb/2QykRztoJgQ5YmwiNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268047; c=relaxed/simple;
	bh=PBZIQHFjolFK5uVPoRvknCfl+dNARmvDLwek4J8BJek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUiVucUKBPPN0snGkWxwiqEsNQRj8uIGSgaW3EUo2FvFlFQuOosLVsIDLscO9pqqOglVGI/o9L4m6u1sEE3Lgh5ugFXf3NIyoKE4znxvK36UM6si8gV/GHeSf9eRkVx6GUD8Hmk6oZ2copYT2PcoekeKxfSUaFdQJNL1kOz/MTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOKveYanyruuYCPdPgdDGXNyHtRPCicbpjJ9BspZNaG+39a3hjBvwbBxhZ8ERegPW5rfOT49We58tsgUXlBFBYHkbVZuke8sCP7ILayhUnjQSDow3DXgpqtGWFB1EBr2xyl1svLX/KwX5q2dhPwkAGK9d+CwerklzBkzBPGTETHX5D+gbqWEBw7UAMFHviVBuCWj8Tld5JnMrVeTlGGceEYuwZD80JI2CqmNeW34seeQMYAxRcEgsGz35snAxXgTDKDCrBCQB+lApNWfszIK6a7LqHw3HcVIJw9kTCAUJ6QzkeCB51O81x0frlMEGOWy1tdAupfr1b0RPhT027QL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da9KCl4Fe1DI3kspYWijVqjPmpaTn6jew0aLw6xDIr4=;
 b=A5YiaNbcM92YNYrxxiSRAtZQrvJbZo3R/BZY9AV6UfljTAfpEKRvFWEmAXAMe3FwhTWaq5UjBPe6o0HdHLHUoAvlY1nbwpvf30J+ZqmSogBehXiAFO1FUt9ijSdFrxdll+90DGep4dKJQ4phKk8PpgaqmWXgX5+GkBgNoml5VVnl7NSMVDm7JgAOp8Ry27/YU4ShFZMqSLxeZO3GJw2BbEO1xatiCpgzqXOFlSqDFPNdn6vCYCHxVtyKhdfOmuoeELTuuq1BRG3EoIqJKFnj/99U5NmyfRRex1P/E0P/WbqCR9nMJBSaS1wVl2kBVa+0Z0l0wqqg8ykXQStKMP9vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0053.apcprd02.prod.outlook.com (2603:1096:4:1f5::8) by
 OSQPR06MB7183.apcprd06.prod.outlook.com (2603:1096:604:295::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.25; Mon, 23 Mar 2026 12:14:02 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::f) by SI1PR02CA0053.outlook.office365.com
 (2603:1096:4:1f5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:14:02 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C6C5040F0506;
	Mon, 23 Mar 2026 20:14:00 +0800 (CST)
Message-ID: <53011077-f3e5-44cc-914d-ec5c0cc47d34@cixtech.com>
Date: Mon, 23 Mar 2026 20:14:00 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: arm-dma350: document generic and
 combined IRQ topologies
To: Krzysztof Kozlowski <krzk@kernel.org>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260323114822.1925869-1-jun.guo@cixtech.com>
 <20260323114822.1925869-2-jun.guo@cixtech.com>
 <64836645-7c54-44bd-a21f-b02e684d3863@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <64836645-7c54-44bd-a21f-b02e684d3863@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|OSQPR06MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: b4042234-753e-4afe-1d3d-08de88d5aba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dZadxYw3kqXfuGL2sM2OLoKnZTx9SoxVuMpCrXsq7HIznRUexC24yZvgWgb65J8YnGydjkA6M2oYkmBLoRoHGTSHOVLxcmid55Ih9gEhVFxxrUXL5Wsc7tfwGg5GtHdptlD0z1uFj7aE8nbxQaFgR0GIhS+UV+kD/ny2CQRenVVaaIqcgxK23DXKaM/U8sIzwoHaNdtudyO/wgUekNP5+pn4r67Xa37uhh2/aDKTJDsyjToHpAo9E1cza4rS2z2nAzGUpRg92+899oYu34jIKVa4lVMYk+CCHPL/butGsLbKSCOcR0kcg5T1cYP2W94y61otpLplCCPe7eV9I+T4dNcE0Tnb/Xk2e2e3jIlp+qLKpzmOiDrCt027E65AtbxZFO2FJUj4hLZLXfpMi+/HTCHp2HewRgKlDnsR7WYI59/35oIHQpGjyDU/Q0GKT3grCGS0o/to85rag5CgtV3GXwH2tZZH4ceYYtuE/MFj1Ri1Saximck0Ase6XXnZtjzcjzauOVinglID9GLjpBY137ra+dKdTiyXzKuORnuvyEJ8YLCVAkBhhmSEk6kO0AbHhstXnq/9OIpjv+fwFzGAMwKm6c3LIHrNwC1MnobrpRDRCEX21XipVfVTFWczoQe3Ra35VXoaP+DIybBXmIFiaP5Sb3uA9p2PJPqwrejQbyaKDMtDOK565yjzp/a2d3TD20XaL5DSZGDgrlOWTs61gfvBK7zxdHNr3GdLg2rrss8ULoRASCUG5QQaaZdZqsAuyay5idb2T2zZ6TDTwD+Uz9xP1VbuHZB17VYOf0s4V8S9ANskyXcWvLsqyqNG+fk+
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zQI7zD4ywQIXtoMvT0Rurq5wofWaxskKJvSCGJ7hyJ/nAV4ldve6dGiJoi+hC33XDyRTk1tFmerSmovU1u5mrr5aDjUnXn24KKcgIW/2u5IKagTJD7DAs+o9UL3hmrDqRRrqYlG8Ouu+4e5P6s32Vza68SGXx1P4UT1aPaJYRMwTaFyWsuaZGuHvZIyVG3r6PJgRoyVE1ZvDPaJEaFfcHypLj+vzPgjFoKPQhezbKQDcOdkss6ULulXx0RlOKRr4efYf4g6MuYSANAj8N/CWmiLUb84gFARV/oFheYBrAD8il4SzqNHtg4GsAyPoz4xTx6sGXIax9e+PtqdNMAjMYNdV5yyhfTN/Gd9m5zhN9GRcr4HXJ7NWgLyYAO5RydzsK4NnEYcz5uUPyW7/CcoP+2Xaaqf8xbQlFoALmGhXkeO+PZjokwU5yDokNexRI18Q
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:14:02.0770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4042234-753e-4afe-1d3d-08de88d5aba8
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7183
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9595-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cixtech.com:email,cixtech.com:mid]
X-Rspamd-Queue-Id: EE0D22F1D15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/2026 8:00 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 23/03/2026 12:48, Jun Guo wrote:
>> Update the DMA-350 DT binding to match the current driver behavior.
>>
>> Allow both:
>> - "arm,dma-350" as the generic compatible, and
>> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
>>
>> Also document interrupt topology variants supported by hardware
>> integration:
>> - one combined interrupt for all channels, or
>> - one interrupt per channel (up to 8 channels).
>>
>> Assisted-by: Cursor: GPT-5.3-Codex
> 
> There is no space here. Read the docs, I quite insisted on this last
> time. If you make mistakes in this, I doubt you read the docs thus I
> doubt you followed the requirements - have actual rights to send it for
> example.
Sorry, I did overlook the format between AGENT_NAME and MODEL_VERSION. I 
will fix it.
> 
>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>> ---
>>   .../devicetree/bindings/dma/arm,dma-350.yaml  | 34 +++++++++++++------
>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> index 429f682f15d8..47091614d1b4 100644
>> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> @@ -14,7 +14,14 @@ allOf:
>>
>>   properties:
>>     compatible:
>> -    const: arm,dma-350
>> +    description:
>> +      Use "arm,dma-350" for generic integration. A SoC-specific
>> +      compatible may be listed first, followed by "arm,dma-350".
> 
> What is the point of explaining it? What is the difference between
> generic integration and non-generic?
I might not need to add the "cix,sky1-dma-350" and can directly use 
"arm,dma-350" instead. I will rework the code and description accordingly.

Best regards,
Jun


