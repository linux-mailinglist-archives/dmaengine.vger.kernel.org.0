Return-Path: <dmaengine+bounces-9583-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CxXEjTzwGkSPAQAu9opvQ
	(envelope-from <dmaengine+bounces-9583-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 09:00:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D12EE027
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 09:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAA7C3058491
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E6364053;
	Mon, 23 Mar 2026 07:51:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023126.outbound.protection.outlook.com [40.107.44.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203836308D;
	Mon, 23 Mar 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252286; cv=fail; b=bUdUPFSWMvZbEzZDcf0rOFtvwtRZgc0AyoETLumiXjSetRciu3PMkIjRERDZRz6k19aaB0TVw31e8iKUVKXgiSKbRDvouzQ1SzHopulr6RjIKucNmbodoegeYPs8fvONf0rwvDkxOJ7OEkVSTV8LYMj8GWfoyQ+Kwm/a+baj7Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252286; c=relaxed/simple;
	bh=gcb/+JmbKTpZx70URIhMl+LfSUwy/M1ROKadzGm3CxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4EmnGfcgt4oPr2c55Y0tsVQ+zuBIUKfIwsQVxhc5rDajDebcZNn6RocxuEdnoEXPvbjtRo0i1Q3KgOgGnXywcD8TPe+4OadACUMDrj1cJAv09qT1x1ShXOS1sQzGrGjU31NByTDgBSrZ9XO14GUG4sDx0WUY2EDwE9ckKcBZsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8nmiIloEpXovqfTDO0DXa9SkYGDb9kvPNaLTh+73zpWNjPcNfcM+dXZYzUbz4EmRisMj5DKH2YsXpD7nnLkh+Ku7HXoh/wz4HCPBNsHWJxMasM7pheFQuB1tIhTHHcArlVbKlwUbI/Ts2Bhrr5AerxLbNgZGg4fjT13is0JVHREpenqn+0ZwciANa5H1isSvwJB1PDQ4rXQFtRZFL9DpjCyvtDciOGA0XXnA35s0pw07sZkU6zeQ4uxGdcJRA4PmvCx4Ygzyn4UE85oTY/bRJxiHuuoPLiM5eJmOOMkDqIz9SsBPTn2rYyVHiwJQ3gM57SBjALw1U61DbsbIjXUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt9HfRwWJSTnHRYt+TLcQOviKP49Gp1hGYj957X3Vec=;
 b=ae+HErfdakN1IR4jUzfIT94u64k5jxKfrDD/DbIfDU5o5+j8N+N3oc5+ZD23/pIvVwF2JJLb5odMe2IabHpD4jpDQhX5EFw/+0sNFtM06eXwuBDH6y2uT9nwrO+DOsO4TubQPWf4OuUx3deH4tpMxAeYrAVDUmo1iNxnltxUj18vfo0wsDv6hTSNCm9GX2WVo3dNocQe+jE7yge6IR5HxUiBefIrw1xoSJjNPZBn7Zg9hh7fI/svyH/FBXWY2XPVjEWE7nIzYKiWNPleRkJL4rqcE2s9BlO8cvQtEb6Bs2XrV9i+LGwlaOzWtHZuNyw0SGxCCYEwyUHnjFvO+HXjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0196.KORP216.PROD.OUTLOOK.COM (2603:1096:101:19::11)
 by KL1PR06MB6905.apcprd06.prod.outlook.com (2603:1096:820:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 07:51:19 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:101:19:cafe::4d) by SL2P216CA0196.outlook.office365.com
 (2603:1096:101:19::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.26 via Frontend Transport; Mon,
 23 Mar 2026 07:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 07:51:18 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 691FC4126F83;
	Mon, 23 Mar 2026 15:51:16 +0800 (CST)
Message-ID: <4ba1e549-eb92-415c-9ddb-a00f52de6586@cixtech.com>
Date: Mon, 23 Mar 2026 15:51:16 +0800
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
 <dd6ee455-7bba-4734-be84-a7db097754c6@cixtech.com>
 <7967caff-101a-461a-bc61-aeb8fc8f04b1@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <7967caff-101a-461a-bc61-aeb8fc8f04b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|KL1PR06MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6b75f3-167a-4ef5-1fed-08de88b0f7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SADoJXWlYVk53xriZe+fASFsYzdIjKYNwWZP8PxKIqTOksfYkc8Et3OZAoaIcZ/xhLKb6lA9hZz8WRm9jrWlmYJcw9xeMeIf8SXtN7oU98ATTilWbmOeGVRv/Si5uBeF1t/aWLjVZnzBVxzhqU48Xqajx1zAWO9WxRniC32I6uoAYQnBP0mDl2lJsBzcIdBcjePR8RcxPHxcX0YiUbvOFxZUsqawb063+bB+GGsUrKH597h5sGHPQJfGk14YuGqGg+LvYFzUtmPf2pBGY04/alD/z38Fn/AfmljrrK5EKRHXzceg7/cZApZWNmG3e71ZC1nHbwx2UMDQ8+6hou9/5oEbBqAQnatOclkJ8QDIrodpcfYzt+az+mEKSyLYJmOYzx9GrkQZw4VyrVkQ6U/QtcJkiM21+33BuQ/p0ih8iFtr0MsKrLtUykhfvzUJg9hRJAcN93nusflpeyeDixbDwR2ln3BPOmGlv/d1WgDmmGqhry1sHvLoG29klhtkZJ7oxd9YuFEs/QL/Ny7BeDmXeI0pN6ig3BssJMz8dIsE7/cjHcWN0DYdVlKDKpfwa+3fRJ5ySj64tDr8cB4V3EXDDX/obVsNchN0dygIqicUOyYeIrfVTJl23VqwI81dsIIicWHd7z2tqjyLbtIlD6g3N3x2Gw4zM5JYMctvd1UqdI7lSY9iAzqT55Ou4CzHk1wAB/MhZ/jUonjZYBrIik3Irf6N0bTd4g7spctz+3rJxceAuG9MOyX6puBt9cJe/wARfcq5mYivmWeNhWFwYgRzDA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ww3OE9AEvNsNw/qj9GG7y0ID1FhHA59rxaZJiGe9A/1ttwqNpAC0+xyF/zS2NSizQKaXHCXW2ei10AL6HCsoKyUnadsUrilkBiTFBaMbnKZ/RTGZPcJRSDGWpU6WlnX5+nqgj7WV5tSsQ4yICyQ5uuhud77laG2uH+SKzap0iH1eOJecus4S/yeMq3kq5GquBpwydhxX6UkpLZtzGzNfw3lYSZZ53th5/CCbyJ9W1htsNzlfaEM6XnF9PEEn053gsX08ge2pOw7n+5uH8e2WWeL4Qj8bAsNSxRu5WiJT9GuwxSEDN64dbrajRUOjv0m4mrzZJwC4DQDQ0TXSlL9wAdIPALt38acOhVnHkePZsjHGK9evmey+SKvFrhNamNQa2UaF1zyDGEKVcEXFMa+4v8KWUxw4QgFpWH/c8+42R3qxbTmVqoSm6OzW+Q77Z4Gw
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:51:18.1223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6b75f3-167a-4ef5-1fed-08de88b0f7b1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6905
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9583-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: A16D12EE027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/2026 3:27 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 23/03/2026 03:09, Jun Guo wrote:
>> Hi Krzysztof,
>>
>> On 3/20/2026 6:04 PM, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL
>>>
>>> On 20/03/2026 10:58, Peter Chen wrote:
>>>> On 26-03-20 10:43:10, Krzysztof Kozlowski wrote:
>>>>> EXTERNAL EMAIL
>>>>>
>>>>> On 20/03/2026 10:38, Peter Chen wrote:
>>>>>> On 26-03-20 10:12:53, Krzysztof Kozlowski wrote:
>>>>>>> EXTERNAL EMAIL
>>>>>>>
>>>>>>> On Thu, Mar 19, 2026 at 06:17:21PM +0800, Jun Guo wrote:
>>>>>>>> Update the DMA-350 DT binding to match the current driver behavior.
>>>>>>>>
>>>>>>>> Allow both:
>>>>>>>> - "arm,dma-350" as the generic compatible, and
>>>>>>>> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
>>>>>>>>
>>>>>>>> Also document interrupt topology variants supported by hardware
>>>>>>>> integration:
>>>>>>>> - one combined interrupt for all channels, or
>>>>>>>> - one interrupt per channel (up to 8 channels).
>>>>>>>>
>>>>>>>> This patch is Assisted-by: Cursor: GPT-5.3 Codex.
>>>>>>>
>>>>>>> Wrong tag, please read carefully the guideline before using LLM tools.
>>>>>>>
>>>>>>
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> It is the trade off for coding-assistants.rst suggestion and
>>>>>> passing checkpatch.pl. Currently, checkpatch.pl reports the
>>>>>> error for tag without email address. So we choose to add tag
>>>>>> description at patch context.
>>>>>
>>>>> You still have to use correct tag.
>>>>
>>>> You mean even checkpatch.pl reports below error, we still add it
>>>> "Assisted-by: Cursor: GPT-5.3 Codex" as tag?
>>>
>>> Yes, after fixing the contents (that's not entirely correct format I
>>> think). Hopefully someone will fix checkpatch one day...
>> I cannot find any commit records referencing AI via "Co-developed-by" in
>> the latest kernel GitHub repository, and I also cannot locate any text
>> describing the correct way to cite AI in the submitting-patches.rst
>> file. In this case, how can I confirm the current correct format?
> 
> If you do not want to read coding with assistant guideline and follow
> its words, then please don't send code created with such tools. Do you
> even have full copyrights to send it here? What license was used by the
> tool to generate you this code?
Sorry, I overlooked the programming assistant guidelines. I will comply 
with the requirements of the programming assistant guidelines and 
resubmit a new patch.
> 
> Best regards,
> Krzysztof

Best regards,
Jun

