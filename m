Return-Path: <dmaengine+bounces-9596-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNLGIFIwwWm7RQQAu9opvQ
	(envelope-from <dmaengine+bounces-9596-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 13:21:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE882F1D34
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 13:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A81A6307E08D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E6398919;
	Mon, 23 Mar 2026 12:15:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022096.outbound.protection.outlook.com [40.107.75.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3332E3360;
	Mon, 23 Mar 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268159; cv=fail; b=UUGuhunpvMz4SsDscaSQnMDZP4tVXMUnAK++R6+cEDarZJVMLxWNW0+ZPHrOoCrxZKFxtHpTVWG0m4pYwxVrQh+Cr8prAoLz/00pTR5Dpg3ade+xUBZfZPWfkwSw4SxW6M+Xq5G4K6joDodvp3BwZa0yuarsSYI6yIW8xkqmAR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268159; c=relaxed/simple;
	bh=4o5a8pjrKx/zjuVXZjDle5txoUy+hSdKwNSxKMzNaHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/h9AVeWQ4+b7QD74i771hvfHx7pI7r05P77RvFXV1I/TXegID7cr81Wj9LIrUssP68x/tinSji3noLYsGMwd3n2MXMLiPv0hkGWaJEmWB7Bwya7uJp0LYqis9QA7t4WcQTxH0I/tOl3TPo+w7WJgll/azlGSuhn5b0AotdBOCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSDFqFQ3ssVZMIagmzBLTgHuln/c7FQhGYgSB431wB3VfI4UOIxkLUHML/Xds7ipZksbezdRK9VGsH5ArcSAZ153Xsh2AEA0fQwjQYvox/gqz4XyWgeqjEpyQxkBcWeBZfXxf5AhbCvMXlEV6eQIYr+M7ZzjJxGTWrZHVOEsBBnbDfNJ1bzZ+YOPtyRMzloLiZcwzDG/7kOW94+Pxflgax1o7jGTKXnN0Dqz8rv4fqn3PxK5ukc7Zu3BFmf9R0+4trhtXE1DWdQqK5MSoZ58ERDwa7HXnCD7J54IMzmZa/sRHlTLvlre1qripAgvuS1L8HvULHjhSxNImqSKoDLMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ6j76QCH6X1KJug2i3dvqPUQd02xOfY83LD5JBYN40=;
 b=zB4gadV5+qtSR9Pc698dB5kepSH8hMNFTTUumPsv55Igup1vX+3LYjfbmB2Kk52Wpum60nuDMM3WF8BT+U4pT8XLf998q0PXGMr2DtPsXNqa80wyIpy2W/1d5h6uqrCPYvkr5sNQIuwPX052Z4mmlKA0q1a3bUe5ZYMYMGxdd7B/7uJwRxKdriR6UkvVBMl1ycbQDBzrw8RwaMDWX/FT6fiEJ7YQrXpI/tfxWlecularun6Jbpz5Oq8hzWOwQyUCFuQISZLBNg3oj5Ogv945qRsU2RtOMulmKLlF6Z5prTHyA8+0mvtzx/qiUKe9t+al844cBpcF/AVki/HKHmlQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::21) by TYSPR06MB6441.apcprd06.prod.outlook.com
 (2603:1096:400:482::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 12:15:54 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::fd) by PS2PR01CA0033.outlook.office365.com
 (2603:1096:300:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:15:53 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4AD764126F83;
	Mon, 23 Mar 2026 20:15:52 +0800 (CST)
Message-ID: <732ae85a-a473-41da-af1a-9ff125df172e@cixtech.com>
Date: Mon, 23 Mar 2026 20:15:51 +0800
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
 <88472f82-6171-4eaa-9a3b-59372c11a9f3@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <88472f82-6171-4eaa-9a3b-59372c11a9f3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|TYSPR06MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: b4893fbe-49fb-4add-b904-08de88d5ee3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8n96zLchw8ihko+/8iANV+I10GlXJfLFNojA2m8KH7267M8HS3ucCzrDN7H1EE8l/BFIC0MGuU8OlUmu7zStYgULPKbkxlD8neP4p+NJ+lp5Sz60c10JJD/UZDuF2TG09g5c64KOVggBNgFglRNovSnKm06hUpILHGtxBOulDOv40fyxIre6wYqV1WyhQKyd2pMb+2Ns4peFEzh6WhPpkHzQCRy6w1V9VqbFiLMUE99SnSZIT+DrsrOfeEf7C+NX2M+JnfWZHBGoZdep4hYdosi0ZsN3VMJlLs04UQzY2mgfFwrvzhEBqeB23JlgbRekNWEN4e1m8A5Q4xf0YXGmPoSNdF1TB/ERRZ514o5ptjjV8Tth0t/3bhBa1sHWCm0f3xdoTNa/tbOTY2L6wodsF0m4tDio0FkfzCTwqDgG4Xxk/vyI2uOeYtCkEfOiiB2Jx7XkOIlwwPGzk0lq7U2RAr5N2AuZxfxXtdbqdUp2HHZV4ALR+3YNU7w2kHYMu1wZ1Dfug4Hi+xzTJvhAY16nBgaEbxORZ3XSjiavOX9AZQ4lbXLqJOglBn8P4CeIh3iqAx2bw4WRKKPRuHw/DGEwV662FUbPNxmP65CPn7Zy72ASvUd2ghO4JuC9T6Dg3YIHFCiuNmwJ9Cd68iSP5GK++VkO8cjDpAOH3GRmWSqSx61YM8S2Zvq3n33LkEVgVlS+K29XU4+MY1/8Z5bXY9mLTHBj1G85SrNuwOsZlGiE9ZTtkrvrgY0UItXueFAf+Cj9RYjMDb0A4Y2xXQiGW8iVH/zjauKgNi61K5DifI6TYw0efZ2mZWwe776SwvS8OtBt
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8qyEAB5kcfODbiw2Y+BZ6CiASgkcpdEsLb2EJRoOcMfVXCqF80xufQAls6ebPKVTaevzPcVrAKmmEQZZw08Kqkq2bgMzrrwxvYDRHJYe/hT/iBLwQ1/L+uuv7WaootjbnQlueMLHnSRAnVWJDC5uYPZXrFAAugRYDWMV2F7VBNRBal6MFWaUZq1S6TjBRvHyZ2KMFAkqeEutcua9qwW1qI9vIDN33Xm7686B7VDtXKI35Gl4/zrhYOozJgOHOiIHQJXJ9g8m3AwrTmyioEa+aGS3WR3WTj8yGJ8gM9jTGlWuqm3x83LIkCoXKBq7I2OVdt1Yp+hINWkHjJdpA27H89Dm50MKeYon/bzwyBxv1bs2YuK/jUd8dmWmzQUcj85B6DAQfW7NOl4lfrJFuYXNIr/3FMAXRnEBMKB1bwX5DiKkFYq0jS8PXNpNkYY362Pa
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:15:53.7430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4893fbe-49fb-4add-b904-08de88d5ee3c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6441
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9596-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cixtech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BE882F1D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/2026 8:02 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 23/03/2026 13:00, Krzysztof Kozlowski wrote:
>> On 23/03/2026 12:48, Jun Guo wrote:
>>> Update the DMA-350 DT binding to match the current driver behavior.
>>>
>>> Allow both:
>>> - "arm,dma-350" as the generic compatible, and
>>> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
>>>
>>> Also document interrupt topology variants supported by hardware
>>> integration:
>>> - one combined interrupt for all channels, or
>>> - one interrupt per channel (up to 8 channels).
>>>
>>> Assisted-by: Cursor: GPT-5.3-Codex
>>
>> There is no space here. Read the docs, I quite insisted on this last
>> time. If you make mistakes in this, I doubt you read the docs thus I
>> doubt you followed the requirements - have actual rights to send it for
>> example.
> 
> And you already received that comment:
> 
> "Wrong tag, please read carefully the guideline before using LLM tools."
I did receive that feedback, and I will learn from this experience to 
submit more reliable patches in the future.

Best regards,
Jun


