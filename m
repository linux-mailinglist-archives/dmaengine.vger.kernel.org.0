Return-Path: <dmaengine+bounces-9927-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJsND2X41Wn4/gcAu9opvQ
	(envelope-from <dmaengine+bounces-9927-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 08:40:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A373B7A89
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E66DB303DF41
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BA369235;
	Wed,  8 Apr 2026 06:39:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022077.outbound.protection.outlook.com [40.107.75.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADD36B07F;
	Wed,  8 Apr 2026 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630365; cv=fail; b=CHdw3IT54xBmHqKrY4rUOebMzgcAoNGKq3cV9YwKONHMpEz47JxO05/uc6+oGwFUlhjP6WEdoFu49j6m+OMweR9Pjnk4Myg5xFK9EvSyiBga58SNb3s8TYlguswPO1r2dMAvkJ1wnJS7Oh/IP83ssA+V66v+QbS00v3m4v/Ck4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630365; c=relaxed/simple;
	bh=O35vq/Ce2z7ieocAgIz/3sl+HRDcmehKlAcc0lHi9uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdBZwZnShzC5gOs+eDXznOLPcaw9tmzwfUel5ffsBXcjQva798BUa3KXl93ORVujh3oRv1IFKBAo9DxelH90Fs1Zji0ib56rpl6APr1666ernZnV9ITcAEx3iuN1LKOyG4MHeyMU2y4fdNH2Ij9S4fkj/QIYphvtaBNy+USBEoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYodkEy4vpMYi6FwetgubuV9kDyLvSPyvDyPny0aYWCsLy22YVt5ePaKgHbtnFijeSc8MBU9Tz1WFO3RQyFnoyAIYQLehYvG8uDiETjqpdXxMlxyLOsu+DKkTjdZknF7ubQU7R/oIxsISJD1YzHhj+60QfNFCmLwTgM3DPJAwxlIQg57DqgUdRN3XEpf4m4WkzGV6zavtyxgwmBWrUCcpnzLdfGyEZsF9Zy1Zzz9XRFaV06nIpa91N9D9NL4RnwB10SexW7C4c+sN7RjXUWLfN2M/GoCzUvQ8KTw7umM5/21/Ej5pAJBgQOpOKlQXMOaYEgQ8K63YUGT9VHoMGoJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7nl46sto5oiezNArpd/wCnGKrfS/j3oNwJu4aTd76E=;
 b=iWejiM+Yya+Yj01WWWZKkkLbV16r3iReExaaIBFhwI8PsbMA2iVf9tpc8yV6DXHn718jsl94skdd4gw4SnFsjzck6HSW3oDD7SvhePz8wEp90wstuHsl9+6ZQwnG3XSb3vfs9vcn2NBQ81xdtbV9GTbNMCI0xXNQdEdVRwbLiN7qpUW3OuGmaNeXRKHdPMN4ulmCugeb/TvrUSVftSNW3HvVo/fOLPIc0gqXW0BnaNIpVUZZdIgSFKi9acz2v05oxIbFF8YtfSL50EBozNogkmK4snRmUYykYS8E/a+Q5y5tJQmqzOmIKU1J5OiS+SCEO+YHd5UZpaQGZq1tZsBj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0148.jpnprd01.prod.outlook.com (2603:1096:400:2b7::7)
 by TYSPR06MB6289.apcprd06.prod.outlook.com (2603:1096:400:411::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 06:39:19 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:400:2b7:cafe::d9) by TYCPR01CA0148.outlook.office365.com
 (2603:1096:400:2b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Wed,
 8 Apr 2026 06:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 06:39:18 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3D6044126F83;
	Wed,  8 Apr 2026 14:39:17 +0800 (CST)
Message-ID: <eea87be5-5257-4ed2-b8f4-42c35889fd05@cixtech.com>
Date: Wed, 8 Apr 2026 14:39:16 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: arm-dma350: document combined
 and per-channel IRQ topologies
To: Rob Herring <robh@kernel.org>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260324120113.3681830-1-jun.guo@cixtech.com>
 <20260324120113.3681830-2-jun.guo@cixtech.com>
 <20260407172014.GA3090142-robh@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <20260407172014.GA3090142-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|TYSPR06MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db1028a-cf41-4d8e-a851-08de95398f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TVAaewECHsIhaEnhyvs6sy1ewZ4xpTBREd+iOcT2Ve4fWhJd6YCrz+lNkBhWslA+H7A+13WhqoegCDSJV6C60DYJIF44FX11hS73MrB611AOvVh7EIrzh0ZhdK+jy7hd8VCOds4+jSGTXEgmhZWpu+AAfOrM7wxp7pzEZU61QdiT4EYoXuxvnXIPKxbFa+coU/Q2aENJ/CtizQEdwjULcJNkPIjJu1AXhfwmxcAXQkEPFFl3E8hUzypuw5UsQdXErZR3BwIXUn2f7R/TjBUH6Kos3P6zb647ofuzRjBgNIDwK5R2MkAtbN9rhTFyg3LX3X8tj3MWcL1MbuDK1aKbaK4Va5JuK4Tjr6PXiT1XitEGYTNvHnSHcVu8vno+HuoVXjcrtTcAE05njxd9fW1AzqdXL+p2VKQrO1B8mmVgAfyGC3W/sQ2eaDT9O5h2HCp1Bvkuo86cghUtONgR+MYs9uoH6lMBdELGoz8TqEHVXOOphD2GkSV8h028a6OwWvUegIQFC+J4OHmrMuON8D7JxPisAxQYmhaPSPfOcKjWZkLbAehGVhhkbN1w8A1TY6/Lp65b2MnLTdlAXxpg09d7Lgv/jnRQwG5I0/XlfERbbF33DdASLEkS24i/D+VXW1AlY3QZ3mTwLFlz5EpsbZIpLdiWyrdw9dpBmURk/87B16PC8jNHAppHo77HFHv20vyrm2coAIXA8PLhesarlFkq5NRz15HUL6FsDLUaSESlo0aREiY4IFYV/DqlME8jgNUB5i9DeSXGpgm6/h66f4n5sQ==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VmVCGsM+k0us2VAykKy5xlzg7Cs3q5cIInY7lVOaZsdcCKJ3AsdNad+U6TLYItcM8aNUQlAo8o1sGIkoL7/DddmNqNFcrn3zonJDreqMu6AzWFPhB6VZhBHRRXON2kEaMDLURUjDFwG+moHGewLLQVp7bfyZ0b5uxd5zk5xfKoQ4OF+aeQTv2+B3TQlBpyjPmqy9k7WO2BDKSDPVCU57T+Bx39GOyh3l4BZ1rYN4I9rR7wFgkedtch1Rk9LNpM1sQzDoiAp9Lx5jGRbdMrMSWWb4MiXuNNiXyq3HtHm754lBJnpuN9BhJZl7Ok7PRmG3CSbFo0eMGpcr0bvspb4T44midy1IYTZDZdX99b+V3WaQKSmmp8g0t4J6FaM8x3RPADi/T9jWThlabRI8mXjpOzR+bzKfRUbqUMBubokwwJpbowCWPTKmiq8xjiBbgDq6
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:39:18.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db1028a-cf41-4d8e-a851-08de95398f82
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6289
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9927-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.161];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cixtech.com:email,cixtech.com:mid]
X-Rspamd-Queue-Id: B9A373B7A89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rob,

Thanks for your review. I have already resubmitted the V6 patch. Please 
take a look at the latest v6 patch when you have time, as it includes 
considerable changes compared to the v5 version.

On 4/8/2026 1:20 AM, Rob Herring wrote:
> EXTERNAL EMAIL
> 
> On Tue, Mar 24, 2026 at 08:01:11PM +0800, Jun Guo wrote:
>> Document the interrupt topologies supported by DMA-350 integration:
>> - one combined interrupt for all channels, or
>> - one interrupt per channel (up to 8 channels).
>>
>> Assisted-by: Cursor:GPT-5.3-Codex
>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>> ---
>>   .../devicetree/bindings/dma/arm,dma-350.yaml  | 25 ++++++++++++-------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> index 429f682f15d8..bec9dc32541b 100644
>> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> @@ -22,15 +22,22 @@ properties:
>>
>>     interrupts:
>>       minItems: 1
>> -    items:
>> -      - description: Channel 0 interrupt
>> -      - description: Channel 1 interrupt
>> -      - description: Channel 2 interrupt
>> -      - description: Channel 3 interrupt
>> -      - description: Channel 4 interrupt
>> -      - description: Channel 5 interrupt
>> -      - description: Channel 6 interrupt
>> -      - description: Channel 7 interrupt
>> +    maxItems: 8
> 
> Don't need maxItems
> 
>> +    description:
>> +      Either one interrupt per channel (8 interrupts), or one
>> +      combined interrupt for all channels.
>> +    oneOf:
>> +      - items:
>> +          - description: Channel 0 interrupt
>> +          - description: Channel 1 interrupt
>> +          - description: Channel 2 interrupt
>> +          - description: Channel 3 interrupt
>> +          - description: Channel 4 interrupt
>> +          - description: Channel 5 interrupt
>> +          - description: Channel 6 interrupt
>> +          - description: Channel 7 interrupt
>> +      - items:
>> +          - description: Combined interrupt shared by all channels
>>
>>     "#dma-cells":
>>       const: 1
>> --
>> 2.34.1
>>


