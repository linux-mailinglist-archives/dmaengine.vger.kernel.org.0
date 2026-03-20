Return-Path: <dmaengine+bounces-9559-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAzSFGoivWmr6wIAu9opvQ
	(envelope-from <dmaengine+bounces-9559-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:33:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7A2D8B9F
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F1D030A6E0B
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA1375AB5;
	Fri, 20 Mar 2026 10:28:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023114.outbound.protection.outlook.com [40.107.44.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F59314D1A;
	Fri, 20 Mar 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002523; cv=fail; b=MP0bJHrt4NOKxdjDB8koSuNin6rtjFKdDkanyyW09hHykrD72Iff0Ov5J8VfsdCJeCEcvfnjUk2yNUziLGGgdDad5wnuwTSCWU+2bI0rlHQTjU+XlTxtrQKISJVHC7toEJs1zAlyC+EwKeAHzsC8sM4KsHf+omWVDF9JNd52keU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002523; c=relaxed/simple;
	bh=+IoiRkmfcNSqTWGpX/L1q/PVQ6oP11i24FvsPgLbGBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9aBZTKKklMPhFa6jar0U941Cw/aEoHgON9WeOD7xari9zbMi+GpWOpl9RyhPio7Sm5dSmmhAS7L2/SdO82swbi7MG4VwZROiQGjaYlE+GBlvBOMlaBlftrewZbEqPdjilUxO7dzL0cGBlZpJJ2S/AgWwJM0jK6Nu5KeooPdkKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM0A8LpiCf99z9wijj/+OvjPRbLzpXKriqKlNUDDOKssDbNI/vKOA3kpGe/MV1w68f5xkkOP9vX2Z70+LeZrfIYBgHh3Dkb0HStox29999I43Z0gLTxNOrTY8x+nrf2GgKNrK3QZUJLorfeJjyDW6kEIyMGDCEBverpa3fXmL5tzwMjTnKSDgkzJRxeuzIK0xbox8nvc08I0nXTdm51Pqpifq0zvYpLD7vrmg7/jqf9HyzIaYDSfXMDMt1AnbDfwD4jZEA7UriUrjwNySlNLSKPAif2IjgWMHQSvszjd3Zc6U+s/fV+qcgXvYoHaOj0gKQmQj1Jwl558/dHNxYhRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdq6kd2e/QetCN5+0KvkNKA9+Xu9sw78ttZMSbDkXn0=;
 b=FSLbhg9z3AwZL2/l0piHGMl0EBtXjnq3DA2/18VCY7yzuaqTxuTxULRi8rowAu27QAwJPoFjBBvh/jeZ3NvVuAK3U+2X6TV/mBM0uMnD6smPVeZ93UbdGQbKY4p14mf4OtuwdfOHzT8xeZq+y2ywn2MHCY2oqkunw0NvXZuvL2SQw9BCcB39leVib8Xo+AIhSfuFNeE7J7H3JGEfaGsbctUMWARLdow0wsfN0XKxfooGBjt6JM1mGUIUi2ZbUrkATI9NjxMd0C1SXhE7rDqqYXEvmeeB885hY8v6nAsjC7DXw3dZfuamD/4a4brjXrY9pVmfV9r1Iz6RYxlkkSUQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0017.apcprd02.prod.outlook.com (2603:1096:4:194::17)
 by TY2PPF5221563AF.apcprd06.prod.outlook.com (2603:1096:408::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 10:28:36 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:194:cafe::e6) by SI2PR02CA0017.outlook.office365.com
 (2603:1096:4:194::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Fri,
 20 Mar 2026 10:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 10:28:35 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 747374126F82;
	Fri, 20 Mar 2026 18:28:34 +0800 (CST)
Message-ID: <40fc5cb7-a5f2-4b86-8dba-1b39e1ea0da4@cixtech.com>
Date: Fri, 20 Mar 2026 18:28:34 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic and
 combined IRQ topologies
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-2-jun.guo@cixtech.com>
 <20260320-vengeful-violet-cockle-382580@quoll>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <20260320-vengeful-violet-cockle-382580@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TY2PPF5221563AF:EE_
X-MS-Office365-Filtering-Correlation-Id: c10e4ae6-3009-4e9f-f4c5-08de866b71aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r8sFFwBC6ObsQSPen90pyXg8xIQGpKGIkl7aquw4le+dsEl7JPKMcJW4UcKHfWarzwb2EqyADmskws9IVrRqD4JM9se6NV2Ibn9+xsrYMF9eMKBozaqWaZ/p8l//31ExE/ASyymSWfx9DQAB5vTgv8/qHKOQ5hw63GEECAZIVYnLHQapbHh5u5DjRHqquAXL/OkmumDvaD8XZ6bwA2Pf4gZQ9R+fI4vI/J/iqvq+FRf48qGLjj19WbDLhrd0u1h2/0LtE3yG982Q5uikP139+n+2/tmreRmKza1BBDvz4FeZQfbRskIDAUoqbsXfTJKmwXDXtS+9IeIey0LHXHcYG+xab1YAwPjSYa/fzfqUFBsYAqphSjtpYlFCs/FGoiSCLlcb8Z+xnTqs1m418oNrg1rzCUkbIivLltEDyskqEnniYnAQKYM+6RYmgr5F9A90GvVSHa3cRSpPdYhRLlPj870F1YJepmzya1fVtcRbBSUosLiMzOZxog4ScN8yK5hsKUulkAyTHFxPd3koWozIAN13ONkD0w6QFue/aLmSDJsV+XAjL8N1YxWqgqAFbZ5YRHkPcxCdqzqJELcVNdyfLe66LO1sgxdrOxohVGlAwyUA1ARL0ggmalpdIg909hzjWUs8PHvOUAxsl1qWqR7jF9Ho6bjkYDD5nAS8zgNvVwHinEU5fNFEOArRN6/fSGGRCJFO4mrC9YS3UeIKfw3WGgMeT35kvW/gpuLVKanXR21DFJHfQ5ZPWsJRu2HFpt+HmXd0GqDEnuRaNbkk48a0mg==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E6l3c1EjVdaJIuCi15i5a6s7o1qEdRuzJQClsUjlDLIdOFesxZIWCZoHwxKmFhOCb0YgcjerF1aX9schm6gMuIzjXq+eHcoYxEGWeCAfio+gvf0dwHQeU+bITRN1nNbo+bgOH++yg3DudUI9rnpayl7ii2EzpGaekiUk+7VvKhD7MqIOrff8BoVBcrltf3aHHa1H7/MVnCQ5csVxy1TZDJOOlB3pfiQNEmg5En9WZVS+1K8zSYJk30Atjvrq6gun0F3oLvjI/UL/6oEWZOZw6QKvKk5Fo5FjucdRN59+tpW1+ITbhcbtuGTuxpUDC16KkoosgncX7Q+rx4NfjiY+4V5CgyT8D7V1pr0JRNN/rHlw4/xsINyWMWg5KLdZ4KxHT0I553okHfIiCRUULOWq+wHFzUk+17R8CRPus0HDoguda3PU0pchDaFTOtqTJTrp
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:28:35.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10e4ae6-3009-4e9f-f4c5-08de866b71aa
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF5221563AF
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9559-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.407];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cixtech.com:email,cixtech.com:mid]
X-Rspamd-Queue-Id: CAD7A2D8B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/2026 5:12 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Thu, Mar 19, 2026 at 06:17:21PM +0800, Jun Guo wrote:
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
>> This patch is Assisted-by: Cursor: GPT-5.3 Codex.
> 
> Wrong tag, please read carefully the guideline before using LLM tools.
Okay. I will temporarily disregard the check patch warnings in the next 
version and correct the format of the AI-generated tag.

> 
>>
>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>> Link: https://lore.kernel.org/r/20251216123026.3519923-2-jun.guo@cixtech.com
> 
> What does this express? Changelog link? Then keep it in the changelog
> --- part.
Okay, I'll address this in the next version of the patch.

> 
> 
>> ---
>>   .../devicetree/bindings/dma/arm,dma-350.yaml  | 31 +++++++++++++------
>>   1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> index 429f682f15d8..3639ce0d5054 100644
>> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> @@ -14,7 +14,11 @@ allOf:
>>
>>   properties:
>>     compatible:
>> -    const: arm,dma-350
>> +    oneOf:
>> +      - const: arm,dma-350
>> +      - items:
>> +          - const: cix,sky1-dma-350
>> +          - const: arm,dma-350
>>
>>     reg:
>>       items:
>> @@ -22,15 +26,22 @@ properties:
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
>> +    description: |
>> +      The DMA controller may be configured with separate interrupts for each channel,
>> +      or with a single combined interrupt for all channels, depending on the SoC integration.
> 
> And more important - you must review the LLM microslop output before
> posting and adjust it to Linux kernel coding style. Don't send
> unredacted tool output.
> 
Actually, this part of the description was not AI-generated. However, 
I’d like to confirm the issue you mentioned: are you saying that this 
description is written too verbosely?
Then, do you think there are still issues with the revised version?
   interrupts:
     minItems: 1
     maxItems: 8
     description:
       Either one interrupt per channel (8 interrupts), or one
       combined interrupt for all channels.

> Best regards,
> Krzysztof
> 


