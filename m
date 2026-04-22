Return-Path: <dmaengine+bounces-10082-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG+NLt+k6GngOAIAu9opvQ
	(envelope-from <dmaengine+bounces-10082-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 12:37:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084A444CB0
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BAF3300EA94
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D63B27E2;
	Wed, 22 Apr 2026 10:34:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023126.outbound.protection.outlook.com [40.107.44.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DC374759;
	Wed, 22 Apr 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854039; cv=fail; b=hAE+HxEMDEMgfwFaqmxamClHABs0zB5q0Lg/8deqtos27F2d+wQy9KNgcCrwXIYakNG2SfCG3xNf6CMJFWUYrN1Kf9hMUsU1fUc4DO0nk6Fohjo/4p6hIs8n43WkeIigQFM/6geHN75ETtobIfoYzwfavYBzL2uiG769EHeXqA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854039; c=relaxed/simple;
	bh=lfxvUXvwFVuWcPptvpRzQbreyT2j+9RpNYVOKyJGIbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPe3nwy6PCGvp0SBf3mTi9wXKtt79B4EKX/TNmzkJ1e9RfePJS8TdiWFmMuhx6NgK0mZ6Tfs2OeF6YHvEHk9xoFvJyp8pQtw1yeRSiGMEVAqPkFRAz/155UP7cj6cl48Jmyl9gWxW0PgTTOI4iEszdbl8X8PQhF5NvcHpYFs4j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw31M+jmdrYJbE2OZ8RN/IlsS40F7fnPO1zLOigProjcJRN8bhAxnFRqs0puUTUhQtsoRKQ2r0Iw8YMOInOaPy280132Mf9OF6UKuf3r3OB4I8pNBQyt8zs4GibBlYrfoS5Kgxg1IjpKLgRE+LDIA8rzPZV6NG2vmhhenWgrb5bSLvSaJ/aX5h+3URMWREqXpnMZBtAXOOasoEahebGRK9vALZKo2wHMJr2dWqdqmTpnO/EMZ9TSJ4rQc6KUIG9SVsJV9Vw+z9o6L6r8rAfpHJjrkAzGOfNQkkaDD6em77eGS2u6cg7sHip2gqgrYAy0yesZjESayTPHKnPG9OtbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WablyoBFy+gxbiiAwuqgA+V3P4WM6fUiNbf1+c/IFcM=;
 b=lRIhx84J0q1w20qol6wyVHqyoDgb0g0WONw6BpnVpFYWSBtC3icbcD6/jBjturHYDHJZCVtCHQRxKuLnTYBytPqJoUbkT1cRuxSipOQTorE47scgqoabPOTMpI6NlsXCdFBxkO8I56NTlH85tI3FpxtHPVhWl4jxgNTgVxh2pNlczGWks1pkZVHei0WCQPlx/OOtLa87F1C3O6U997wFxk0BSTMFO3awEs+v5vp5+ZPAxZHYYgZxkJ52yJH9Gfi4LBWURx6b+LTGbZxFqqlf9lO7IYNV9GN7kejWvI9N7UzPa7WqRp3EBp3GTg/U5C2AMBSKL5W7kn0uBeYl/DNAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) by
 PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 10:33:53 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:d) by SG2P153CA0007.outlook.office365.com
 (2603:1096::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.8 via Frontend Transport; Wed,
 22 Apr 2026 10:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 10:33:51 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 37C854126F9A;
	Wed, 22 Apr 2026 18:33:50 +0800 (CST)
Message-ID: <1c1025c1-ead7-49fe-b18e-0454119d85f8@cixtech.com>
Date: Wed, 22 Apr 2026 18:33:49 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dma: arm-dma350: enable ANYCH interrupt for shared
 IRQ wiring
To: Frank Li <Frank.li@nxp.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260325112159.663881-1-jun.guo@cixtech.com>
 <20260325112159.663881-2-jun.guo@cixtech.com>
 <932db8ad-a9d8-47ff-bf3c-62a54c42bb76@cixtech.com>
 <aeia3uoz4g8tlBaV@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <aeia3uoz4g8tlBaV@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|PUZPR06MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: f59b8d3d-2c49-4fbe-8e73-08dea05aa5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qunEvMqNFrMDS/2CWi6RsBVyYLQFdQU8jm2B5bggqaoLFh1af2XWWyAc9iYkHs2mDkdNEYWqUruXyi3ZXNByOlIJ2lXPAk+G1IkEfoZPjk5VRPFIhyurcPRfFW7ESpz+YXCfELK7lY+Fo6zq4auFzigO+vsto+KsC7BwrK70fX80Q7GZoW4XpLNifyJiRVZBXoGcW1F26ZalXOXu51EnPMr7sQOr60m1uK2yttpVGWCdlUWq2IGaeFd0YpVwATMrQfbvaRChRGQ+UYpyf1ZKq4BvCnzFnxwKvnrQ0qvbGNaoY0PvC8PnxiFE75cAet2Qdh0DEh9UgHWNdolEqGGeHi2xXqbkEfplApbUAYwCkXQesPb6DLTm7EtNtkfngxBPHmqn/ksR5D4pG1nHdF0DRv09JHOGTYhoI27ifYi9mtyOz/Qh73a5fzFh61Sxe/OPdxaMWtA+t7Sk7UBia+8qO/TzfYWWcngnvjq9e+566ggliIOk7dclnY3bPKjfUiYB7M99+MAmXvXPtaP6eTS4HHnHR8TyHNhLr+KDilB4ehLdIhp/5xcdt1sq/mYZznB6F9YCBOgZt0mpTks3/LTvqrjBSynDzg99DLNrh+11mcMw3kPzaXAKVwLWRtRQ8kET+h7j2wLGwDyHVJ6ss/26L8MP5tjhSiUJldEWXW/pxS6YRztUtVnDdNF51Y/g8s0UPdK0VYLE/34eewZ7jeuQSAVnhcp8g8j3uwDHA/W/dKfqKtiIQL9Zte3qZKONAVpwwtcWtKT0Sgf/rbkMzzRH/Q==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E6QyIMqtbUeamiLWTTm0mMXVVtExWz7ifIeCVTbFkVs8RmiD5TldJPvmosYyPe9ACXMeVEu6++gjgBjQM/hRyJAMqWoyK0SeaY7fpNx9H4dbz5GLqxPLkqXmu4xncXGU8eJSXwYKF0H/Y7wQBf3Wb+Xxh5MAaybRvE4yiwKK4lU/wIEECtlN50u/SFuhy6AaAn/e+Dau7Jk3A09UrxixQNGy3ZK+Sk73PV1+IH5xBJzrSs8tA6Hgz+kJRjQtwnH9SAqsM1YLbcJ5T0ec3MsAKmIEKPVEpiXVQgw+vJ/m48CwXMYk3vKBG/Qs6/BmxfurLvGvrMz1r6WKlgVZim2dwuhipJqm6pqP6q+PwDqXHZIpYlUblTwM3cxmY4Qg8PMva6eJ7weScr8L+Dem7RHAzGMpE94NvUNz1+6Mn3Jo1ytbSpsBtr8NIo6vxxFuPqgD
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:33:51.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59b8d3d-2c49-4fbe-8e73-08dea05aa5b3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10082-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aka.ms:url]
X-Rspamd-Queue-Id: 2084A444CB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/2026 5:54 PM, Frank Li wrote:
> [Some people who received this message don't often get email from frank.li@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Tue, Apr 21, 2026 at 03:24:11PM +0800, Jun Guo wrote:
>> Hi Robin,
>>
>> Just pinging. I’d like to ask if you have any comments on the latest patch?
>>
>> On 3/25/2026 7:21 PM, Jun Guo wrote:
>>> Enable DMANSECCTRL.INTREN_ANYCHINTR during probe so channel
>>> interrupts are propagated when integrators wire DMA-350 channels
>>> onto a shared IRQ line.
> 
> Your tag is wrong
> 
> dmaegine: arm-dma350: enable ANYCH ...	
Okay, I'll fix this in the next version.

> 
>>>
>>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>>> ---
>>>    drivers/dma/arm-dma350.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
>>> index 84220fa83029..09403aca8bb0 100644
>>> --- a/drivers/dma/arm-dma350.c
>>> +++ b/drivers/dma/arm-dma350.c
>>> @@ -13,6 +13,11 @@
>>>    #include "dmaengine.h"
>>>    #include "virt-dma.h"
> 
> extra empty line between header file and macro
The space actually exists in the code, but it is hidden in the review 
records.

> 
> 
>>> +#define DMANSECCTRL                0x200
>>> +
>>> +#define NSEC_CTRL          0x0c
> 
> why need two layer regiser define, your use DMANSECCTRL + NSEC_CTRL，
> 
> why not use one macro for 0x20c
> 
DMANSECCTRL is the base address for a set of control registers. 
Currently, only the NSEC_CTRL register within that set is being used. 
All other registers in the same group share this same base address, and 
a similar arrangement applies to DMAINFO.
> 
>>> +#define INTREN_ANYCHINTR_EN        BIT(0)
>>> +
>>>    #define DMAINFO                   0x0f00
>>>    #define DMA_BUILDCFG0             0xb0
>>> @@ -582,6 +587,10 @@ static int d350_probe(struct platform_device *pdev)
>>>      dmac->dma.device_issue_pending = d350_issue_pending;
>>>      INIT_LIST_HEAD(&dmac->dma.channels);
>>> +   reg = readl_relaxed(base + DMANSECCTRL + NSEC_CTRL);
>>> +   writel_relaxed(reg | INTREN_ANYCHINTR_EN,
>>> +                  base + DMANSECCTRL + NSEC_CTRL);
>>> +
>>>      /* Would be nice to have per-channel caps for this... */
>>>      memset = true;
>>>      for (int i = 0; i < nchan; i++) {
>>


