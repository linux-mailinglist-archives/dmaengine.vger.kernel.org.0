Return-Path: <dmaengine+bounces-9579-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK8PDtqgwGmLJQQAu9opvQ
	(envelope-from <dmaengine+bounces-9579-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 03:09:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 214312EBDA9
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27B67300290C
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B220CCDC;
	Mon, 23 Mar 2026 02:09:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022102.outbound.protection.outlook.com [40.107.75.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E949620;
	Mon, 23 Mar 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231764; cv=fail; b=bQ2pRiagqc9znQ1IZNjFHeLGwJXGfUxSndXRCSGXsrdiIcVvxlsb1Swuollqb45k+Ld0fAZosgboNHKg+G1XlOaPoOi/gbvGktFsKmqIwtHNE2EIS9dFRBEsPzAGNOt1EpdPQwymR/GsXmCv6Bem4YFga3eg1AYCh2Hc1Tm9HyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231764; c=relaxed/simple;
	bh=d7EO1nmWOyrEI8++Unm45oOxz0xtVAOaUk7BuNHcF8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHBhw1s0oZhgvK0DXsLlvwUsm+dipC63gp0fUGDwzG+ea/WrvA+juxhwgNf8Yx/z5KDBnvQBCaHW+l82+VjzSBHsMe0OZ5FSTkbwFHmY5ygKBTffxRgQO3t41wcpDLCteuh+zLNfDRzb4K/iqruJ0K9c2MNUu6TLintvatmmAlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tivKghnMzz7WBc9jv20mEgYQafL9f0N/Byq7y72s65fPi4Z5E24A/6X1KRyofuI8j5DcIS4y/ziPADc6Q5shy+RE/bJUBQFUvRMvrSs52UcrzjAgoXANlW/MygTy9CuOd4HTONEFhs0Cr/YSe4wOS0QvGjMeZVBUoaXWly7pfLNLWKTF+ROgiG4xyVhAw8MZkyCl8mgU9WPOBF9W08EOfpeWEG4U7OGmPGN8PPNvjd3C4v3GyVp5L/9WhzE4qoNZmzk5v0F6KQU3nxZA9sWRTc/lGLQLanDxO5/p3MvhA0/L+DyRlfDFlAg7AwHSl1dCVjYl6fcZnqeBvzeGt3pahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM56Xu5TqsbdjPRgX0inxobr617BTaRZcPMWGL103OQ=;
 b=pHZotG5Cu0KHC0Q7ra2sLkr9XT31MJmm42b5yyquOb8BGFQU1P5C6iIo4EvywaADR/qJApMLDcRUmvMGKuH4vA+OXVWKtxFjQENX1RTh6qMocH0R6UQ54yXwS+GLtzn7HurXjlCD5eKwHwFW9cGJ5vvDuPCzUvBcCylNi4XUFOoHeP2hZZ9sUr8QxcVg2i0Q9WNi7vxlljfeZ6fEtrv8F4WV119i4UEHTZNCVKan1ablPNZVNwITrUVjHux6a9jRLNwugOsgdZ1624Xuz0y37HaMENvu0vUJlLJaeQHvJ8LG2GVR7I4XCqXBms+lUdR24Nms9GNavjTMWQg9YwfT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0151.KORP216.PROD.OUTLOOK.COM (2603:1096:101:35::6) by
 JH0PR06MB7235.apcprd06.prod.outlook.com (2603:1096:990:97::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Mon, 23 Mar 2026 02:09:17 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:101:35:cafe::3c) by SL2P216CA0151.outlook.office365.com
 (2603:1096:101:35::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.29 via Frontend Transport; Mon,
 23 Mar 2026 02:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 02:09:16 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 74D3740F0506;
	Mon, 23 Mar 2026 10:09:15 +0800 (CST)
Message-ID: <dd6ee455-7bba-4734-be84-a7db097754c6@cixtech.com>
Date: Mon, 23 Mar 2026 10:09:15 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic and
 combined IRQ topologies
To: Krzysztof Kozlowski <krzk@kernel.org>, Peter Chen <peter.chen@cixtech.com>
Cc: fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-2-jun.guo@cixtech.com>
 <20260320-vengeful-violet-cockle-382580@quoll>
 <ab0VoTut0u4f7EVr@nchen-desktop>
 <41254f6c-3ce3-4566-acf4-f0bf764565f3@kernel.org>
 <ab0aYUK1NlUV3riG@nchen-desktop>
 <45bb547e-8a9a-41ef-a5d3-417dc4f35746@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <45bb547e-8a9a-41ef-a5d3-417dc4f35746@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|JH0PR06MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d628bbd-baa7-4464-2a83-08de88812fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Vpy+wsXDnKyzGkJFa0iA/CDTgDAM4EGljQUivMg55WwdLTODtxnUI/+1WVkyNapW+9ucSeVZlzGWsp0TmR6PlVzw+jJs7p0sCYxk+NO9v35C8NXEZY90ilF7iYQi/AjMZowGoE/VE2g8VnGwjiqp2PwFiecOZ9KjmUYHL2pIPEYHsGwols/1bgUsh9oUyanuScCQhKV3me4C8AWpSYpIObj4rhJYuQiv+O42ET7/f+DVxQGdDAQvgDvH0s28Vah1QWBn9luSpjVvniC1H1LJuFrO31mvzLD7BgLRlhHJDopMkibJD204sK3ozdvIPT2rlJC0vnP41caBdInn19wDNqqOfYtNs8TYmcxbq7mcZnQTql1f6Af9AAd/kbAyz8MMZARpRiCaijrO2kErOl48mDeJesJK+5v8beG8nV1MqYSVKvLn3UocdDlkFnIemSn/j1+DRAo9wiWYj7n4OoW+SEfR94AbMptwJikJbYeI3n8ktg7Vxc9uFWPP4WtfoGdph690AO5ytizkSwSzZFbyoh1zrKtq+SVtIlCcuKrrUpJ9+u/EWXuyCnk3td8m3Z5aSdAXA3oJxGfQT1v0xZSDOVoFUcD2wACneSWfW8udT88bsc1K1Ei2Qhr6BY0+qHaZukppOq4W+ttWZ+g7AVPLTlaKm9a5wiqfk8/qvm71bE88QLZeZF44atdVGaWu5tur7bDLL/r+2O8O7UJz17zmImUU8NVPFZrwau1Ft2KzDDdkhe86Yzd0V4DXdSAR1zVmrW/FCkM+xHIuqHu4kdHtEA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Oso0Xx2SGEcH+nzzofFwXTEi0G0Gv4nIF13dqTbkJDiyg8i8m2LXZP0Ni9+wSjJk24dB5cYIYG1VzMh5ZDByczvDAN2k2vY6m4dm87PVEv/S5vYSu5kuPiQ1mABcGKSht6s/lko7lEue3SX+fF8lJRCdaXT3B504/R4WKNm/TXD0Xcz1T8XBdvDoYurr2Wo/CugqOgCr8z9fLwNTspVFAAiDy6IIFEHVHUZUUYrS8vCDHavCGygcTgQipdVorB82lToTkBgyQe91sEhEyIafHezvfdCjEkYMYQkJMdjVAcVxg2lOFLl09MwyOutKF2N2f/SNdFMK1Q4T7FhKvsAJHSCqAvGc+KL3pnSeF+g1+cZOS9yKBlcWtntDMwyy/i4l0kyZFyOCk+ei5tqH7NEvnkXmjScg7ZGE4WB6DaWqmz09umP7IfXNA1pF2MzP+gUL
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:09:16.6921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d628bbd-baa7-4464-2a83-08de88812fe7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7235
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9579-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[cixtech.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 214312EBDA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Krzysztof,

On 3/20/2026 6:04 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 20/03/2026 10:58, Peter Chen wrote:
>> On 26-03-20 10:43:10, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL
>>>
>>> On 20/03/2026 10:38, Peter Chen wrote:
>>>> On 26-03-20 10:12:53, Krzysztof Kozlowski wrote:
>>>>> EXTERNAL EMAIL
>>>>>
>>>>> On Thu, Mar 19, 2026 at 06:17:21PM +0800, Jun Guo wrote:
>>>>>> Update the DMA-350 DT binding to match the current driver behavior.
>>>>>>
>>>>>> Allow both:
>>>>>> - "arm,dma-350" as the generic compatible, and
>>>>>> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
>>>>>>
>>>>>> Also document interrupt topology variants supported by hardware
>>>>>> integration:
>>>>>> - one combined interrupt for all channels, or
>>>>>> - one interrupt per channel (up to 8 channels).
>>>>>>
>>>>>> This patch is Assisted-by: Cursor: GPT-5.3 Codex.
>>>>>
>>>>> Wrong tag, please read carefully the guideline before using LLM tools.
>>>>>
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> It is the trade off for coding-assistants.rst suggestion and
>>>> passing checkpatch.pl. Currently, checkpatch.pl reports the
>>>> error for tag without email address. So we choose to add tag
>>>> description at patch context.
>>>
>>> You still have to use correct tag.
>>
>> You mean even checkpatch.pl reports below error, we still add it
>> "Assisted-by: Cursor: GPT-5.3 Codex" as tag?
> 
> Yes, after fixing the contents (that's not entirely correct format I
> think). Hopefully someone will fix checkpatch one day...
I cannot find any commit records referencing AI via "Co-developed-by" in 
the latest kernel GitHub repository, and I also cannot locate any text 
describing the correct way to cite AI in the submitting-patches.rst 
file. In this case, how can I confirm the current correct format?
> 
>>
>> WARNING: Non-standard signature: Assisted-by:
>> #14:
>> Assisted-by: Cursor: GPT-5.3 Codex
>>
>> ERROR: Unrecognized email address: 'Cursor: GPT-5.3 Codex'
>> #14:
>> Assisted-by: Cursor: GPT-5.3 Codex
>>
>>> You ignored rest of the email
>>> message, so I assume you agree that you should not send LLM microslop?
>>>
>>
>> I am not the patch author, Jun will reply it.
> 
> Ah, sorry, I did not notice that.
> 
> 
> Best regards,
> Krzysztof

Best regards,
Jun


