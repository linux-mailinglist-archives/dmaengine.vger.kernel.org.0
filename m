Return-Path: <dmaengine+bounces-9189-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO9jIxvipWkvHgAAu9opvQ
	(envelope-from <dmaengine+bounces-9189-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 20:16:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9D1DEBCB
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD24303E2F5
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B0332EBB;
	Mon,  2 Mar 2026 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IjIwgJTQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azhn15010019.outbound.protection.outlook.com [52.102.138.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3A309F09;
	Mon,  2 Mar 2026 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.138.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478793; cv=fail; b=pjMcKCQbCCaAB5orCvRV90J6EBa8cmt1+cUSI5K/g7xQMOYswFObdWrasOJbQtt1PZvUz7R3tBQITHUvCFVBUHNpC0HOrZMLbhXfaGc66H/8+JMQOZeL5OMjnvnIogMQgEtQZQkqCZKHt/CTUWulSAZg9+LbmVy0YCff+ZPYmtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478793; c=relaxed/simple;
	bh=3hVA3uYPSx9kh7mjMUipJoT+o6/cqzMBEOJO+7dg99I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uk2b80lOVLbBjnLGL35zBUDOZIptD0dZiSwozQpPPBP/72SwZx+nxf2LH4ykoWHMCxSN4RhkxKZU0aZh+wZurcUUBlCF/LM5/E0ZfAe8rSYz8xbBPn0PCPtTCRGUArQdTs9hSU8imbxwP+pJMXLHPDr+NUWKeUTyW5gZgB/PzvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IjIwgJTQ; arc=fail smtp.client-ip=52.102.138.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH03HfpWyY+j57xh714hX47hr+EgF5103cN4SI7d9/G6yEIFgyRXS6vOBmE4qQLB1PCHVQv9EGc+EqxU4oo8SzUAyYrJmwwCmLwE31NHXYgVgV28kHROxkfusQjyEP7jsWrddecVVnucDMy5O27J1W8u9Dknr9UF2FOIdH3AIuuRVJUpmvGvmyHoZRMV7LIfXV8INMivZq2Q99mnRkSOYptbEbp+Vs31JhS9/jDEsxr8VefPKq8gFTdPVRUA5P5/NuNg42It1t7RTa6W74CiQAYMID+i9BWwP1Dr3P6z+SA9lwBRUq0i/KpDxRd2Xm9fO8ZWX/Cv4sHuF3r1gIsjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7wb2yS9SdXx+GmfFoNqC4XPNohRLbnuYKHfYpqLERo=;
 b=XX7UYxvzQnyMuoVlPoAp55aHvvMuVYqVXeOpWZP1wAgjwixmLmWU7pYtf4gIn7jUxlk7RmXrsrJads2/5z9lWatS9e6G7hER/tmnIDk6wYhEjIjM6Akzfn6CDS7Q1hRlBgbFK103vYFu0goKfmMR5sd5rErqCs/2fggXn0zwFhHmZoM9XozKBKz6lcpV6/d9S9u6etddOf+V1yVjhuREDaG5UUQTzuSfQfq36Nzfg5o5/vwFSsyLhwSZPMZ3SPtjrlcqqxdWMGs0Sw4UZXXBtSJ8mVn9MIqA8J9+re9FbDCBgKPj4b3+AHmLAFMkeT1Yir9dW8mTHrY8TulVZuj71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7wb2yS9SdXx+GmfFoNqC4XPNohRLbnuYKHfYpqLERo=;
 b=IjIwgJTQXDCcYPcSENKXwi60kCkN6TAMRB9u/2RXchB/PLTe29N1u54aRtn+vE4vILc32pONRaUSJEpHE5hTrTO313HcF6+KYcDkezGFP8lSc++3hbP8RwSe4EKQpyeZI8dMbOBmSRG/QuK7hz8xxjuoh1YIEbAFcmr0ckcoezU=
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by SA3PR10MB7071.namprd10.prod.outlook.com (2603:10b6:806:319::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 19:13:07 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::60) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Mon,
 2 Mar 2026 19:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 19:13:07 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 13:12:57 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 13:12:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 13:12:49 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 622JCm4P811252;
	Mon, 2 Mar 2026 13:12:48 -0600
Message-ID: <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
Date: Mon, 2 Mar 2026 13:12:48 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ti: sci: Drop fake 'const' on handle pointer
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, "Vinod
 Koul" <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bjorn Andersson
	<andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	"Philipp Zabel" <p.zabel@pengutronix.de>, Dave Gerlach <d-gerlach@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20260223202426.566958-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260223202426.566958-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SA3PR10MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f946e68-9500-4be9-96e6-08de788fbc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014|7416014|7053199007|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	VJVt5BvVY0Af25hZ0oJscD2qGfZQiHIJT7QN3P9mJcb7GeVbh5iQ7caVXRjv/ZTVtBzXduNgBpdV6cg2EcNQz8avOkDYilqb3ZECebMJo2v3ontXs5jOCDQFcc/ZmVCfUmB+feAEXOyt+Fsutrn1r8f1K3aL1FTn995hXqBUu9T8GoeyBh+0pYySeKgm1nA9Il3Z9qN79z8c7Vrs5W0bKkTt+SDqvIqhqD2WFDVN27JxEv/F8pfeJCHNGT4hiWZvIJfEqddYSEG90lFrUfnAVoNZzImIdDC5mDLIJoodwXrEcuhsNAICoFU+jI7JyUGqXyLMJn4Uk89RqJrpBN8dk3mk4yQmR5IjDoIE4Hr3gi2qw+IJp25smGGTCgUMDxPcp6c7kShJnc+k2MBW/tdIXSzYomHHFIirdPdB+nQSb3m2UDkT7+w3rME9ZoWNhQ3NyQVF3EL+GTS4fX/gdsdiXdwINlWJa/HPfU1E7/NC4w+TKOwTz6VJXxaCT9h202MyvpUEFXIqBhT4O7kA75KgaTKorlSl/F/uQLVU68FxwwoV9G5BpyqeHJZg4kwLEosRqR2L3V9JmoRZt+kHiX2JPRPaTqPFJHcyFwsyqi9KutmqEZOqoV9kWkdYjSL+RFx+jDibucAachAlH1dZ+aL4zR2xxTdpAXb/O6Fe4psYLgPkwu9zv4ElpVJsYZRW01dclUgwZhrzp8wdCJ+xarGuR2I7k+kiYqikODAjptgUAFgW2I+UcGdBGpJYF+zQKhDl/2gf4xipaT7jeV9PtG33qTJLeEPkoctnp7VBZg86hkjBzK5D3xeNOH1lh9s63DHRVqc0ZPje20bNXyIUqaO+DP3T4aw+8/i6eaeCtfMNL+w=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014)(7416014)(7053199007)(921020)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7hAxtkbOyfdA1jXPthtF+fVKSyITJP1iN36lm/wBfNYUxk0HhSfIPgbnQg38mfPio3JfTiTxrZ4LtOwKPfGP4VaDfnaUS+Y1On8ZXTnh1ZV3cx8O8SuodIIm+jhqlqyTylkrHmRtSUL6Pstu/4DVu0P+6sMOFtPu2NAPuh/Ps7bhY3lJFMhuUlJya2lmpr+VB7bYd6Kto93AUv+lz5YD1/uZE/IhmHXZNgNWvdIdTtQ9oR7QeEGMc7FV2iKCCPGCUPT67ZlyQzXlTmoOnPS8SoYbeFwPK30Pg3yAt51OF07gMHKftd7YqpLyo6tPQRNeqYknBtgsOiKpLs9itwIB5R26rFA774CYqkix83jok+tp5iS4OD8HozxI7ywe8nJ8m/oyTQlb6ABldbW1/bevvoBBezkUb6R11NoHjPk9hscF9m04e18+N7WHH5VxzrdE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:13:07.0981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f946e68-9500-4be9-96e6-08de788fbc8d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7071
X-Rspamd-Queue-Id: B8F9D1DEBCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9189-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 2/23/26 2:24 PM, Krzysztof Kozlowski wrote:
> All the functions operating on the 'handle' pointer are claiming it is a
> pointer to const thus they should not modify the handle.  In fact that's
> a false statement, because first thing these functions do is drop the
> cast to const with container_of:
> 
>    struct ti_sci_info *info = handle_to_ti_sci_info(handle);
> 
> And with such cast the handle is easily writable with simple:
> 
>    info->handle.version.abi_major = 0;
> 

The const is for all the consumers drivers of the handle. Those
consumers cannot do the above becouse both handle_to_ti_sci_info()
and struct ti_sci_info itself are only defined inside ti_sci.c.

> The code is not correct logically, either, because functions like
> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
> handle reference counting, thus they must modify the handle.

The reference counting is handled outside of the ti_sci_handle struct,
the contents of the handle are never modified after it is created.

The const is only added by functions return a handle to consumers.
We cannot return non-const to consumer drivers or then they would
be able to modify the content without a compiler warning, which would
be a real problem.

Andrew

> Modification here happens anyway, even if the reference counting is
> stored in the container which the handle is part of.
> 
> The code does not have actual visible bug, but incorrect 'const'
> annotations could lead to incorrect compiler decisions.
> 
> Fixes: 9e7d756da7a5 ("firmware: ti_sci: Add support for Device control")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> I fixed Samsung, here TI and I still think there is one more user of
> this pattern - SCMI.
> ---
>   drivers/clk/keystone/sci-clk.c          |   4 +-
>   drivers/dma/ti/k3-udma.h                |   2 +-
>   drivers/firmware/ti_sci.c               | 161 ++++++++++++------------
>   drivers/irqchip/irq-ti-sci-inta.c       |   2 +-
>   drivers/irqchip/irq-ti-sci-intr.c       |   2 +-
>   drivers/pmdomain/ti/ti_sci_pm_domains.c |  10 +-
>   drivers/remoteproc/ti_k3_common.h       |   2 +-
>   drivers/remoteproc/ti_sci_proc.h        |   4 +-
>   drivers/reset/reset-ti-sci.c            |   6 +-
>   drivers/soc/ti/k3-ringacc.c             |   2 +-
>   include/linux/soc/ti/k3-ringacc.h       |   2 +-
>   include/linux/soc/ti/ti_sci_protocol.h  | 131 ++++++++++---------
>   12 files changed, 163 insertions(+), 165 deletions(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 9d5071223f4c..adf87e2d63b2 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -29,7 +29,7 @@
>    * @num_clocks: Total number of clocks for this provider
>    */
>   struct sci_clk_provider {
> -	const struct ti_sci_handle *sci;
> +	struct ti_sci_handle *sci;
>   	const struct ti_sci_clk_ops *ops;
>   	struct device *dev;
>   	struct sci_clk **clocks;
> @@ -651,7 +651,7 @@ static int ti_sci_clk_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
>   	struct sci_clk_provider *provider;
> -	const struct ti_sci_handle *handle;
> +	struct ti_sci_handle *handle;
>   	int ret;
>   
>   	handle = devm_ti_sci_get_handle(dev);
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 9062a237cd16..120b6e1bd629 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -112,7 +112,7 @@ enum udma_rm_range {
>   };
>   
>   struct udma_tisci_rm {
> -	const struct ti_sci_handle *tisci;
> +	struct ti_sci_handle *tisci;
>   	const struct ti_sci_rm_udmap_ops *tisci_udmap_ops;
>   	u32  tisci_dev_id;
>   
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index e027a2bd8f26..de33893e6d26 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -511,7 +511,7 @@ static inline bool ti_sci_is_response_ack(void *r)
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_set_device_state(const struct ti_sci_handle *handle,
> +static int ti_sci_set_device_state(struct ti_sci_handle *handle,
>   				   u32 id, u32 flags, u8 state)
>   {
>   	struct ti_sci_info *info;
> @@ -568,7 +568,7 @@ static int ti_sci_set_device_state(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
> +static int ti_sci_get_device_state(struct ti_sci_handle *handle,
>   				   u32 id,  u32 *clcnt,  u32 *resets,
>   				    u8 *p_state,  u8 *c_state)
>   {
> @@ -639,7 +639,7 @@ static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_get_device(const struct ti_sci_handle *handle, u32 id)
> +static int ti_sci_cmd_get_device(struct ti_sci_handle *handle, u32 id)
>   {
>   	return ti_sci_set_device_state(handle, id, 0,
>   				       MSG_DEVICE_SW_STATE_ON);
> @@ -658,7 +658,7 @@ static int ti_sci_cmd_get_device(const struct ti_sci_handle *handle, u32 id)
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_get_device_exclusive(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_get_device_exclusive(struct ti_sci_handle *handle,
>   					   u32 id)
>   {
>   	return ti_sci_set_device_state(handle, id,
> @@ -677,7 +677,7 @@ static int ti_sci_cmd_get_device_exclusive(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_idle_device(const struct ti_sci_handle *handle, u32 id)
> +static int ti_sci_cmd_idle_device(struct ti_sci_handle *handle, u32 id)
>   {
>   	return ti_sci_set_device_state(handle, id, 0,
>   				       MSG_DEVICE_SW_STATE_RETENTION);
> @@ -696,7 +696,7 @@ static int ti_sci_cmd_idle_device(const struct ti_sci_handle *handle, u32 id)
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_idle_device_exclusive(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_idle_device_exclusive(struct ti_sci_handle *handle,
>   					    u32 id)
>   {
>   	return ti_sci_set_device_state(handle, id,
> @@ -715,7 +715,7 @@ static int ti_sci_cmd_idle_device_exclusive(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_put_device(const struct ti_sci_handle *handle, u32 id)
> +static int ti_sci_cmd_put_device(struct ti_sci_handle *handle, u32 id)
>   {
>   	return ti_sci_set_device_state(handle, id,
>   				       0, MSG_DEVICE_SW_STATE_AUTO_OFF);
> @@ -729,7 +729,7 @@ static int ti_sci_cmd_put_device(const struct ti_sci_handle *handle, u32 id)
>    * Return: 0 if all went fine and the device ID is valid, else return
>    * appropriate error.
>    */
> -static int ti_sci_cmd_dev_is_valid(const struct ti_sci_handle *handle, u32 id)
> +static int ti_sci_cmd_dev_is_valid(struct ti_sci_handle *handle, u32 id)
>   {
>   	u8 unused;
>   
> @@ -745,7 +745,7 @@ static int ti_sci_cmd_dev_is_valid(const struct ti_sci_handle *handle, u32 id)
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_dev_get_clcnt(const struct ti_sci_handle *handle, u32 id,
> +static int ti_sci_cmd_dev_get_clcnt(struct ti_sci_handle *handle, u32 id,
>   				    u32 *count)
>   {
>   	return ti_sci_get_device_state(handle, id, count, NULL, NULL, NULL);
> @@ -759,7 +759,7 @@ static int ti_sci_cmd_dev_get_clcnt(const struct ti_sci_handle *handle, u32 id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_dev_is_idle(const struct ti_sci_handle *handle, u32 id,
> +static int ti_sci_cmd_dev_is_idle(struct ti_sci_handle *handle, u32 id,
>   				  bool *r_state)
>   {
>   	int ret;
> @@ -786,7 +786,7 @@ static int ti_sci_cmd_dev_is_idle(const struct ti_sci_handle *handle, u32 id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_dev_is_stop(const struct ti_sci_handle *handle, u32 id,
> +static int ti_sci_cmd_dev_is_stop(struct ti_sci_handle *handle, u32 id,
>   				  bool *r_state,  bool *curr_state)
>   {
>   	int ret;
> @@ -817,7 +817,7 @@ static int ti_sci_cmd_dev_is_stop(const struct ti_sci_handle *handle, u32 id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_dev_is_on(const struct ti_sci_handle *handle, u32 id,
> +static int ti_sci_cmd_dev_is_on(struct ti_sci_handle *handle, u32 id,
>   				bool *r_state,  bool *curr_state)
>   {
>   	int ret;
> @@ -847,7 +847,7 @@ static int ti_sci_cmd_dev_is_on(const struct ti_sci_handle *handle, u32 id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_dev_is_trans(const struct ti_sci_handle *handle, u32 id,
> +static int ti_sci_cmd_dev_is_trans(struct ti_sci_handle *handle, u32 id,
>   				   bool *curr_state)
>   {
>   	int ret;
> @@ -874,7 +874,7 @@ static int ti_sci_cmd_dev_is_trans(const struct ti_sci_handle *handle, u32 id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_set_device_resets(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_set_device_resets(struct ti_sci_handle *handle,
>   					u32 id, u32 reset_state)
>   {
>   	struct ti_sci_info *info;
> @@ -929,7 +929,7 @@ static int ti_sci_cmd_set_device_resets(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_get_device_resets(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_get_device_resets(struct ti_sci_handle *handle,
>   					u32 id, u32 *reset_state)
>   {
>   	return ti_sci_get_device_state(handle, id, NULL, reset_state, NULL,
> @@ -948,7 +948,7 @@ static int ti_sci_cmd_get_device_resets(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_set_clock_state(const struct ti_sci_handle *handle,
> +static int ti_sci_set_clock_state(struct ti_sci_handle *handle,
>   				  u32 dev_id, u32 clk_id,
>   				  u32 flags, u8 state)
>   {
> @@ -1013,7 +1013,7 @@ static int ti_sci_set_clock_state(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_get_clock_state(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_get_clock_state(struct ti_sci_handle *handle,
>   				      u32 dev_id, u32 clk_id,
>   				      u8 *programmed_state, u8 *current_state)
>   {
> @@ -1089,7 +1089,7 @@ static int ti_sci_cmd_get_clock_state(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_get_clock(const struct ti_sci_handle *handle, u32 dev_id,
> +static int ti_sci_cmd_get_clock(struct ti_sci_handle *handle, u32 dev_id,
>   				u32 clk_id, bool needs_ssc,
>   				bool can_change_freq, bool enable_input_term)
>   {
> @@ -1115,7 +1115,7 @@ static int ti_sci_cmd_get_clock(const struct ti_sci_handle *handle, u32 dev_id,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_idle_clock(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_idle_clock(struct ti_sci_handle *handle,
>   				 u32 dev_id, u32 clk_id)
>   {
>   	return ti_sci_set_clock_state(handle, dev_id, clk_id,
> @@ -1135,8 +1135,8 @@ static int ti_sci_cmd_idle_clock(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_put_clock(const struct ti_sci_handle *handle,
> -				u32 dev_id, u32 clk_id)
> +static int ti_sci_cmd_put_clock(struct ti_sci_handle *handle, u32 dev_id,
> +				u32 clk_id)
>   {
>   	return ti_sci_set_clock_state(handle, dev_id, clk_id,
>   				      MSG_FLAG_CLOCK_ALLOW_FREQ_CHANGE,
> @@ -1154,8 +1154,8 @@ static int ti_sci_cmd_put_clock(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_is_auto(const struct ti_sci_handle *handle,
> -				  u32 dev_id, u32 clk_id, bool *req_state)
> +static int ti_sci_cmd_clk_is_auto(struct ti_sci_handle *handle, u32 dev_id,
> +				  u32 clk_id, bool *req_state)
>   {
>   	u8 state = 0;
>   	int ret;
> @@ -1183,7 +1183,7 @@ static int ti_sci_cmd_clk_is_auto(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_is_on(const struct ti_sci_handle *handle, u32 dev_id,
> +static int ti_sci_cmd_clk_is_on(struct ti_sci_handle *handle, u32 dev_id,
>   				u32 clk_id, bool *req_state, bool *curr_state)
>   {
>   	u8 c_state = 0, r_state = 0;
> @@ -1216,7 +1216,7 @@ static int ti_sci_cmd_clk_is_on(const struct ti_sci_handle *handle, u32 dev_id,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_is_off(const struct ti_sci_handle *handle, u32 dev_id,
> +static int ti_sci_cmd_clk_is_off(struct ti_sci_handle *handle, u32 dev_id,
>   				 u32 clk_id, bool *req_state, bool *curr_state)
>   {
>   	u8 c_state = 0, r_state = 0;
> @@ -1248,7 +1248,7 @@ static int ti_sci_cmd_clk_is_off(const struct ti_sci_handle *handle, u32 dev_id,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_set_parent(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_clk_set_parent(struct ti_sci_handle *handle,
>   				     u32 dev_id, u32 clk_id, u32 parent_id)
>   {
>   	struct ti_sci_info *info;
> @@ -1316,7 +1316,7 @@ static int ti_sci_cmd_clk_set_parent(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_clk_get_parent(struct ti_sci_handle *handle,
>   				     u32 dev_id, u32 clk_id, u32 *parent_id)
>   {
>   	struct ti_sci_info *info;
> @@ -1385,7 +1385,7 @@ static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_get_num_parents(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_clk_get_num_parents(struct ti_sci_handle *handle,
>   					  u32 dev_id, u32 clk_id,
>   					  u32 *num_parents)
>   {
> @@ -1463,7 +1463,7 @@ static int ti_sci_cmd_clk_get_num_parents(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_get_match_freq(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_clk_get_match_freq(struct ti_sci_handle *handle,
>   					 u32 dev_id, u32 clk_id, u64 min_freq,
>   					 u64 target_freq, u64 max_freq,
>   					 u64 *match_freq)
> @@ -1540,7 +1540,7 @@ static int ti_sci_cmd_clk_get_match_freq(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_set_freq(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_clk_set_freq(struct ti_sci_handle *handle,
>   				   u32 dev_id, u32 clk_id, u64 min_freq,
>   				   u64 target_freq, u64 max_freq)
>   {
> @@ -1606,7 +1606,7 @@ static int ti_sci_cmd_clk_set_freq(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_clk_get_freq(struct ti_sci_handle *handle,
>   				   u32 dev_id, u32 clk_id, u64 *freq)
>   {
>   	struct ti_sci_info *info;
> @@ -1670,7 +1670,7 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
> +static int ti_sci_cmd_prepare_sleep(struct ti_sci_handle *handle, u8 mode,
>   				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
>   {
>   	u32 msg_flags = mode == TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO ?
> @@ -1737,7 +1737,7 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
> +static int ti_sci_msg_cmd_query_fw_caps(struct ti_sci_handle *handle,
>   					u64 *fw_caps)
>   {
>   	struct ti_sci_info *info;
> @@ -1794,8 +1794,7 @@ static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
> -				       u8 state)
> +static int ti_sci_cmd_set_io_isolation(struct ti_sci_handle *handle, u8 state)
>   {
>   	struct ti_sci_info *info;
>   	struct ti_sci_msg_req_set_io_isolation *req;
> @@ -1852,7 +1851,7 @@ static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
> +static int ti_sci_msg_cmd_lpm_wake_reason(struct ti_sci_handle *handle,
>   					  u32 *source, u64 *timestamp, u8 *pin, u8 *mode)
>   {
>   	struct ti_sci_info *info;
> @@ -1916,7 +1915,7 @@ static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_set_device_constraint(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_set_device_constraint(struct ti_sci_handle *handle,
>   					    u32 id, u8 state)
>   {
>   	struct ti_sci_info *info;
> @@ -1973,7 +1972,7 @@ static int ti_sci_cmd_set_device_constraint(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_set_latency_constraint(struct ti_sci_handle *handle,
>   					     u16 latency, u8 state)
>   {
>   	struct ti_sci_info *info;
> @@ -2063,7 +2062,7 @@ static int ti_sci_cmd_lpm_abort(struct device *dev)
>   	return ret;
>   }
>   
> -static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
> +static int ti_sci_cmd_core_reboot(struct ti_sci_handle *handle)
>   {
>   	struct ti_sci_info *info;
>   	struct ti_sci_msg_req_reboot *req;
> @@ -2123,7 +2122,7 @@ static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
> +static int ti_sci_get_resource_range(struct ti_sci_handle *handle,
>   				     u32 dev_id, u8 subtype, u8 s_host,
>   				     struct ti_sci_resource_desc *desc)
>   {
> @@ -2194,7 +2193,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_get_resource_range(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_get_resource_range(struct ti_sci_handle *handle,
>   					 u32 dev_id, u8 subtype,
>   					 struct ti_sci_resource_desc *desc)
>   {
> @@ -2217,7 +2216,7 @@ static int ti_sci_cmd_get_resource_range(const struct ti_sci_handle *handle,
>    * Return: 0 if all went fine, else return appropriate error.
>    */
>   static
> -int ti_sci_cmd_get_resource_range_from_shost(const struct ti_sci_handle *handle,
> +int ti_sci_cmd_get_resource_range_from_shost(struct ti_sci_handle *handle,
>   					     u32 dev_id, u8 subtype, u8 s_host,
>   					     struct ti_sci_resource_desc *desc)
>   {
> @@ -2243,7 +2242,7 @@ int ti_sci_cmd_get_resource_range_from_shost(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_manage_irq(const struct ti_sci_handle *handle,
> +static int ti_sci_manage_irq(struct ti_sci_handle *handle,
>   			     u32 valid_params, u16 src_id, u16 src_index,
>   			     u16 dst_id, u16 dst_host_irq, u16 ia_id, u16 vint,
>   			     u16 global_event, u8 vint_status_bit, u8 s_host,
> @@ -2317,7 +2316,7 @@ static int ti_sci_manage_irq(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_set_irq(const struct ti_sci_handle *handle, u32 valid_params,
> +static int ti_sci_set_irq(struct ti_sci_handle *handle, u32 valid_params,
>   			  u16 src_id, u16 src_index, u16 dst_id,
>   			  u16 dst_host_irq, u16 ia_id, u16 vint,
>   			  u16 global_event, u8 vint_status_bit, u8 s_host)
> @@ -2351,7 +2350,7 @@ static int ti_sci_set_irq(const struct ti_sci_handle *handle, u32 valid_params,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_free_irq(const struct ti_sci_handle *handle, u32 valid_params,
> +static int ti_sci_free_irq(struct ti_sci_handle *handle, u32 valid_params,
>   			   u16 src_id, u16 src_index, u16 dst_id,
>   			   u16 dst_host_irq, u16 ia_id, u16 vint,
>   			   u16 global_event, u8 vint_status_bit, u8 s_host)
> @@ -2378,7 +2377,7 @@ static int ti_sci_free_irq(const struct ti_sci_handle *handle, u32 valid_params,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_set_irq(const struct ti_sci_handle *handle, u16 src_id,
> +static int ti_sci_cmd_set_irq(struct ti_sci_handle *handle, u16 src_id,
>   			      u16 src_index, u16 dst_id, u16 dst_host_irq)
>   {
>   	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID;
> @@ -2400,7 +2399,7 @@ static int ti_sci_cmd_set_irq(const struct ti_sci_handle *handle, u16 src_id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_set_event_map(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_set_event_map(struct ti_sci_handle *handle,
>   				    u16 src_id, u16 src_index, u16 ia_id,
>   				    u16 vint, u16 global_event,
>   				    u8 vint_status_bit)
> @@ -2424,7 +2423,7 @@ static int ti_sci_cmd_set_event_map(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_free_irq(const struct ti_sci_handle *handle, u16 src_id,
> +static int ti_sci_cmd_free_irq(struct ti_sci_handle *handle, u16 src_id,
>   			       u16 src_index, u16 dst_id, u16 dst_host_irq)
>   {
>   	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID;
> @@ -2446,7 +2445,7 @@ static int ti_sci_cmd_free_irq(const struct ti_sci_handle *handle, u16 src_id,
>    *
>    * Return: 0 if all went fine, else return appropriate error.
>    */
> -static int ti_sci_cmd_free_event_map(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_free_event_map(struct ti_sci_handle *handle,
>   				     u16 src_id, u16 src_index, u16 ia_id,
>   				     u16 vint, u16 global_event,
>   				     u8 vint_status_bit)
> @@ -2469,7 +2468,7 @@ static int ti_sci_cmd_free_event_map(const struct ti_sci_handle *handle,
>    * See @ti_sci_msg_rm_ring_cfg and @ti_sci_msg_rm_ring_cfg_req for
>    * more info.
>    */
> -static int ti_sci_cmd_rm_ring_cfg(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_rm_ring_cfg(struct ti_sci_handle *handle,
>   				  const struct ti_sci_msg_rm_ring_cfg *params)
>   {
>   	struct ti_sci_msg_rm_ring_cfg_req *req;
> @@ -2531,7 +2530,7 @@ static int ti_sci_cmd_rm_ring_cfg(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_rm_psil_pair(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_rm_psil_pair(struct ti_sci_handle *handle,
>   				   u32 nav_id, u32 src_thread, u32 dst_thread)
>   {
>   	struct ti_sci_msg_psil_pair *req;
> @@ -2587,7 +2586,7 @@ static int ti_sci_cmd_rm_psil_pair(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_rm_psil_unpair(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_rm_psil_unpair(struct ti_sci_handle *handle,
>   				     u32 nav_id, u32 src_thread, u32 dst_thread)
>   {
>   	struct ti_sci_msg_psil_unpair *req;
> @@ -2644,7 +2643,7 @@ static int ti_sci_cmd_rm_psil_unpair(const struct ti_sci_handle *handle,
>    * See @ti_sci_msg_rm_udmap_tx_ch_cfg and @ti_sci_msg_rm_udmap_tx_ch_cfg_req for
>    * more info.
>    */
> -static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_rm_udmap_tx_ch_cfg(struct ti_sci_handle *handle,
>   			const struct ti_sci_msg_rm_udmap_tx_ch_cfg *params)
>   {
>   	struct ti_sci_msg_rm_udmap_tx_ch_cfg_req *req;
> @@ -2716,7 +2715,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>    * See @ti_sci_msg_rm_udmap_rx_ch_cfg and @ti_sci_msg_rm_udmap_rx_ch_cfg_req for
>    * more info.
>    */
> -static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_rm_udmap_rx_ch_cfg(struct ti_sci_handle *handle,
>   			const struct ti_sci_msg_rm_udmap_rx_ch_cfg *params)
>   {
>   	struct ti_sci_msg_rm_udmap_rx_ch_cfg_req *req;
> @@ -2785,7 +2784,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
>    * See @ti_sci_msg_rm_udmap_flow_cfg and @ti_sci_msg_rm_udmap_flow_cfg_req for
>    * more info.
>    */
> -static int ti_sci_cmd_rm_udmap_rx_flow_cfg(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_rm_udmap_rx_flow_cfg(struct ti_sci_handle *handle,
>   			const struct ti_sci_msg_rm_udmap_flow_cfg *params)
>   {
>   	struct ti_sci_msg_rm_udmap_flow_cfg_req *req;
> @@ -2855,8 +2854,7 @@ static int ti_sci_cmd_rm_udmap_rx_flow_cfg(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_proc_request(const struct ti_sci_handle *handle,
> -				   u8 proc_id)
> +static int ti_sci_cmd_proc_request(struct ti_sci_handle *handle, u8 proc_id)
>   {
>   	struct ti_sci_msg_req_proc_request *req;
>   	struct ti_sci_msg_hdr *resp;
> @@ -2907,8 +2905,7 @@ static int ti_sci_cmd_proc_request(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_proc_release(const struct ti_sci_handle *handle,
> -				   u8 proc_id)
> +static int ti_sci_cmd_proc_release(struct ti_sci_handle *handle, u8 proc_id)
>   {
>   	struct ti_sci_msg_req_proc_release *req;
>   	struct ti_sci_msg_hdr *resp;
> @@ -2962,8 +2959,8 @@ static int ti_sci_cmd_proc_release(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_proc_handover(const struct ti_sci_handle *handle,
> -				    u8 proc_id, u8 host_id)
> +static int ti_sci_cmd_proc_handover(struct ti_sci_handle *handle, u8 proc_id,
> +				    u8 host_id)
>   {
>   	struct ti_sci_msg_req_proc_handover *req;
>   	struct ti_sci_msg_hdr *resp;
> @@ -3019,7 +3016,7 @@ static int ti_sci_cmd_proc_handover(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_proc_set_config(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_proc_set_config(struct ti_sci_handle *handle,
>   				      u8 proc_id, u64 bootvector,
>   				      u32 config_flags_set,
>   				      u32 config_flags_clear)
> @@ -3081,7 +3078,7 @@ static int ti_sci_cmd_proc_set_config(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_proc_set_control(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_proc_set_control(struct ti_sci_handle *handle,
>   				       u8 proc_id, u32 control_flags_set,
>   				       u32 control_flags_clear)
>   {
> @@ -3140,7 +3137,7 @@ static int ti_sci_cmd_proc_set_control(const struct ti_sci_handle *handle,
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_proc_get_status(const struct ti_sci_handle *handle,
> +static int ti_sci_cmd_proc_get_status(struct ti_sci_handle *handle,
>   				      u8 proc_id, u64 *bv, u32 *cfg_flags,
>   				      u32 *ctrl_flags, u32 *sts_flags)
>   {
> @@ -3290,7 +3287,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>    * -ENODEV if the required node handler is missing
>    * -EINVAL if invalid conditions are encountered.
>    */
> -const struct ti_sci_handle *ti_sci_get_handle(struct device *dev)
> +struct ti_sci_handle *ti_sci_get_handle(struct device *dev)
>   {
>   	struct device_node *ti_sci_np;
>   	struct ti_sci_handle *handle = NULL;
> @@ -3336,7 +3333,7 @@ EXPORT_SYMBOL_GPL(ti_sci_get_handle);
>    * if an error pointer was passed, it returns the error value back,
>    * if null was passed, it returns -EINVAL;
>    */
> -int ti_sci_put_handle(const struct ti_sci_handle *handle)
> +int ti_sci_put_handle(struct ti_sci_handle *handle)
>   {
>   	struct ti_sci_info *info;
>   
> @@ -3357,8 +3354,8 @@ EXPORT_SYMBOL_GPL(ti_sci_put_handle);
>   
>   static void devm_ti_sci_release(struct device *dev, void *res)
>   {
> -	const struct ti_sci_handle **ptr = res;
> -	const struct ti_sci_handle *handle = *ptr;
> +	struct ti_sci_handle **ptr = res;
> +	struct ti_sci_handle *handle = *ptr;
>   	int ret;
>   
>   	ret = ti_sci_put_handle(handle);
> @@ -3375,12 +3372,14 @@ static void devm_ti_sci_release(struct device *dev, void *res)
>    * The function does not track individual clients of the framework
>    * and is expected to be maintained by caller of TI SCI protocol library.
>    *
> + * Do not change handle pointer to pointer to const.
> + *
>    * Return: 0 if all went fine, else corresponding error.
>    */
> -const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
> +struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
>   {
> -	const struct ti_sci_handle **ptr;
> -	const struct ti_sci_handle *handle;
> +	struct ti_sci_handle **ptr;
> +	struct ti_sci_handle *handle;
>   
>   	ptr = devres_alloc(devm_ti_sci_release, sizeof(*ptr), GFP_KERNEL);
>   	if (!ptr)
> @@ -3411,8 +3410,8 @@ EXPORT_SYMBOL_GPL(devm_ti_sci_get_handle);
>    * -ENODEV if the required node handler is missing
>    * -EINVAL if invalid conditions are encountered.
>    */
> -const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
> -						  const char *property)
> +struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
> +					    const char *property)
>   {
>   	struct ti_sci_handle *handle = NULL;
>   	struct device_node *ti_sci_np;
> @@ -3457,10 +3456,10 @@ EXPORT_SYMBOL_GPL(ti_sci_get_by_phandle);
>    *
>    * Return: 0 if all went fine, else corresponding error.
>    */
> -const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
> -						       const char *property)
> +struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
> +						 const char *property)
>   {
> -	const struct ti_sci_handle *handle;
> +	struct ti_sci_handle *handle;
>   	const struct ti_sci_handle **ptr;
>   
>   	ptr = devres_alloc(devm_ti_sci_release, sizeof(*ptr), GFP_KERNEL);
> @@ -3566,7 +3565,7 @@ EXPORT_SYMBOL_GPL(ti_sci_get_num_resources);
>    *	   error pointer.
>    */
>   static struct ti_sci_resource *
> -devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
> +devm_ti_sci_get_resource_sets(struct ti_sci_handle *handle,
>   			      struct device *dev, u32 dev_id, u32 *sub_types,
>   			      u32 sets)
>   {
> @@ -3626,7 +3625,7 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
>    *	   error pointer.
>    */
>   struct ti_sci_resource *
> -devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
> +devm_ti_sci_get_of_resource(struct ti_sci_handle *handle,
>   			    struct device *dev, u32 dev_id, char *of_prop)
>   {
>   	struct ti_sci_resource *res;
> @@ -3664,7 +3663,7 @@ EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
>    *	   error pointer.
>    */
>   struct ti_sci_resource *
> -devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
> +devm_ti_sci_get_resource(struct ti_sci_handle *handle, struct device *dev,
>   			 u32 dev_id, u32 sub_type)
>   {
>   	return devm_ti_sci_get_resource_sets(handle, dev, dev_id, &sub_type, 1);
> @@ -3720,7 +3719,7 @@ static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
>   static int ti_sci_sys_off_handler(struct sys_off_data *data)
>   {
>   	struct ti_sci_info *info = data->cb_data;
> -	const struct ti_sci_handle *handle = &info->handle;
> +	struct ti_sci_handle *handle = &info->handle;
>   	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
>   	int ret;
>   
> @@ -3746,7 +3745,7 @@ static int ti_sci_sys_off_handler(struct sys_off_data *data)
>   static int tisci_reboot_handler(struct sys_off_data *data)
>   {
>   	struct ti_sci_info *info = data->cb_data;
> -	const struct ti_sci_handle *handle = &info->handle;
> +	struct ti_sci_handle *handle = &info->handle;
>   
>   	ti_sci_cmd_core_reboot(handle);
>   
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> index 01963d36cfaf..88617a0ce794 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -98,7 +98,7 @@ struct ti_sci_inta_vint_desc {
>    *			Global Event number.
>    */
>   struct ti_sci_inta_irq_domain {
> -	const struct ti_sci_handle *sci;
> +	struct ti_sci_handle *sci;
>   	struct ti_sci_resource *vint;
>   	struct ti_sci_resource *global_event;
>   	struct list_head vint_list;
> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
> index 0ea17040e934..9a13adbdac48 100644
> --- a/drivers/irqchip/irq-ti-sci-intr.c
> +++ b/drivers/irqchip/irq-ti-sci-intr.c
> @@ -27,7 +27,7 @@
>    * @type:	Specifies the trigger type supported by this Interrupt Router
>    */
>   struct ti_sci_intr_irq_domain {
> -	const struct ti_sci_handle *sci;
> +	struct ti_sci_handle *sci;
>   	struct ti_sci_resource *out_irqs;
>   	struct device *dev;
>   	u32 ti_sci_id;
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 18d33bc35dee..913373a0b096 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -27,7 +27,7 @@
>    * @data: onecell data for genpd core
>    */
>   struct ti_sci_genpd_provider {
> -	const struct ti_sci_handle *ti_sci;
> +	struct ti_sci_handle *ti_sci;
>   	struct device *dev;
>   	struct list_head pd_list;
>   	struct genpd_onecell_data data;
> @@ -63,7 +63,7 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>   {
>   	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>   	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> -	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>   	u16 val_ms;
>   	int ret;
>   
> @@ -83,7 +83,7 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>   {
>   	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>   	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> -	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>   	int ret;
>   
>   	if (device_may_wakeup(dev)) {
> @@ -111,7 +111,7 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>   static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
>   {
>   	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
> -	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>   
>   	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
>   }
> @@ -123,7 +123,7 @@ static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
>   static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>   {
>   	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
> -	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>   
>   	if (pd->exclusive)
>   		return ti_sci->ops.dev_ops.get_device_exclusive(ti_sci,
> diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
> index aee3c28dbe51..3906d006081d 100644
> --- a/drivers/remoteproc/ti_k3_common.h
> +++ b/drivers/remoteproc/ti_k3_common.h
> @@ -88,7 +88,7 @@ struct k3_rproc {
>   	struct reset_control *reset;
>   	const struct k3_rproc_dev_data *data;
>   	struct ti_sci_proc *tsp;
> -	const struct ti_sci_handle *ti_sci;
> +	struct ti_sci_handle *ti_sci;
>   	u32 ti_sci_id;
>   	struct mbox_chan *mbox;
>   	struct mbox_client client;
> diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
> index f3911ce75252..d20859a9fb13 100644
> --- a/drivers/remoteproc/ti_sci_proc.h
> +++ b/drivers/remoteproc/ti_sci_proc.h
> @@ -21,7 +21,7 @@
>    *	     device
>    */
>   struct ti_sci_proc {
> -	const struct ti_sci_handle *sci;
> +	struct ti_sci_handle *sci;
>   	const struct ti_sci_proc_ops *ops;
>   	struct device *dev;
>   	u8 proc_id;
> @@ -30,7 +30,7 @@ struct ti_sci_proc {
>   
>   static inline
>   struct ti_sci_proc *ti_sci_proc_of_get_tsp(struct device *dev,
> -					   const struct ti_sci_handle *sci)
> +					   struct ti_sci_handle *sci)
>   {
>   	struct ti_sci_proc *tsp;
>   	u32 temp[2];
> diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
> index 1dc5b766aac1..7fea18eb350e 100644
> --- a/drivers/reset/reset-ti-sci.c
> +++ b/drivers/reset/reset-ti-sci.c
> @@ -36,7 +36,7 @@ struct ti_sci_reset_control {
>   struct ti_sci_reset_data {
>   	struct reset_controller_dev rcdev;
>   	struct device *dev;
> -	const struct ti_sci_handle *sci;
> +	struct ti_sci_handle *sci;
>   	struct idr idr;
>   };
>   
> @@ -63,7 +63,7 @@ static int ti_sci_reset_set(struct reset_controller_dev *rcdev,
>   			    unsigned long id, bool assert)
>   {
>   	struct ti_sci_reset_data *data = to_ti_sci_reset_data(rcdev);
> -	const struct ti_sci_handle *sci = data->sci;
> +	struct ti_sci_handle *sci = data->sci;
>   	const struct ti_sci_dev_ops *dev_ops = &sci->ops.dev_ops;
>   	struct ti_sci_reset_control *control;
>   	u32 reset_state;
> @@ -144,7 +144,7 @@ static int ti_sci_reset_status(struct reset_controller_dev *rcdev,
>   			       unsigned long id)
>   {
>   	struct ti_sci_reset_data *data = to_ti_sci_reset_data(rcdev);
> -	const struct ti_sci_handle *sci = data->sci;
> +	struct ti_sci_handle *sci = data->sci;
>   	const struct ti_sci_dev_ops *dev_ops = &sci->ops.dev_ops;
>   	struct ti_sci_reset_control *control;
>   	u32 reset_state;
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 7602b8a909b0..5bc41b838ba4 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -220,7 +220,7 @@ struct k3_ringacc {
>   	struct list_head list;
>   	struct mutex req_lock; /* protect rings allocation */
>   
> -	const struct ti_sci_handle *tisci;
> +	struct ti_sci_handle *tisci;
>   	const struct ti_sci_rm_ringacc_ops *tisci_ring_ops;
>   	u32 tisci_dev_id;
>   
> diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
> index 39b022b92598..a254b4243c21 100644
> --- a/include/linux/soc/ti/k3-ringacc.h
> +++ b/include/linux/soc/ti/k3-ringacc.h
> @@ -259,7 +259,7 @@ struct ti_sci_handle;
>    * struct struct k3_ringacc_init_data - Initialization data for DMA rings
>    */
>   struct k3_ringacc_init_data {
> -	const struct ti_sci_handle *tisci;
> +	struct ti_sci_handle *tisci;
>   	u32 tisci_dev_id;
>   	u32 num_rings;
>   };
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index fd104b666836..2c07c0545673 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -34,7 +34,7 @@ struct ti_sci_handle;
>    *		else returns corresponding error value.
>    */
>   struct ti_sci_core_ops {
> -	int (*reboot_device)(const struct ti_sci_handle *handle);
> +	int (*reboot_device)(struct ti_sci_handle *handle);
>   };
>   
>   /**
> @@ -96,26 +96,25 @@ struct ti_sci_core_ops {
>    * managed by driver for that purpose.
>    */
>   struct ti_sci_dev_ops {
> -	int (*get_device)(const struct ti_sci_handle *handle, u32 id);
> -	int (*get_device_exclusive)(const struct ti_sci_handle *handle, u32 id);
> -	int (*idle_device)(const struct ti_sci_handle *handle, u32 id);
> -	int (*idle_device_exclusive)(const struct ti_sci_handle *handle,
> -				     u32 id);
> -	int (*put_device)(const struct ti_sci_handle *handle, u32 id);
> -	int (*is_valid)(const struct ti_sci_handle *handle, u32 id);
> -	int (*get_context_loss_count)(const struct ti_sci_handle *handle,
> +	int (*get_device)(struct ti_sci_handle *handle, u32 id);
> +	int (*get_device_exclusive)(struct ti_sci_handle *handle, u32 id);
> +	int (*idle_device)(struct ti_sci_handle *handle, u32 id);
> +	int (*idle_device_exclusive)(struct ti_sci_handle *handle, u32 id);
> +	int (*put_device)(struct ti_sci_handle *handle, u32 id);
> +	int (*is_valid)(struct ti_sci_handle *handle, u32 id);
> +	int (*get_context_loss_count)(struct ti_sci_handle *handle,
>   				      u32 id, u32 *count);
> -	int (*is_idle)(const struct ti_sci_handle *handle, u32 id,
> +	int (*is_idle)(struct ti_sci_handle *handle, u32 id,
>   		       bool *requested_state);
> -	int (*is_stop)(const struct ti_sci_handle *handle, u32 id,
> +	int (*is_stop)(struct ti_sci_handle *handle, u32 id,
>   		       bool *req_state, bool *current_state);
> -	int (*is_on)(const struct ti_sci_handle *handle, u32 id,
> +	int (*is_on)(struct ti_sci_handle *handle, u32 id,
>   		     bool *req_state, bool *current_state);
> -	int (*is_transitioning)(const struct ti_sci_handle *handle, u32 id,
> +	int (*is_transitioning)(struct ti_sci_handle *handle, u32 id,
>   				bool *current_state);
> -	int (*set_device_resets)(const struct ti_sci_handle *handle, u32 id,
> +	int (*set_device_resets)(struct ti_sci_handle *handle, u32 id,
>   				 u32 reset_state);
> -	int (*get_device_resets)(const struct ti_sci_handle *handle, u32 id,
> +	int (*get_device_resets)(struct ti_sci_handle *handle, u32 id,
>   				 u32 *reset_state);
>   };
>   
> @@ -169,29 +168,29 @@ struct ti_sci_dev_ops {
>    * managed by driver for that purpose.
>    */
>   struct ti_sci_clk_ops {
> -	int (*get_clock)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*get_clock)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   			 bool needs_ssc, bool can_change_freq,
>   			 bool enable_input_term);
> -	int (*idle_clock)(const struct ti_sci_handle *handle, u32 did, u32 cid);
> -	int (*put_clock)(const struct ti_sci_handle *handle, u32 did, u32 cid);
> -	int (*is_auto)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*idle_clock)(struct ti_sci_handle *handle, u32 did, u32 cid);
> +	int (*put_clock)(struct ti_sci_handle *handle, u32 did, u32 cid);
> +	int (*is_auto)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   		       bool *req_state);
> -	int (*is_on)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*is_on)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   		     bool *req_state, bool *current_state);
> -	int (*is_off)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*is_off)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   		      bool *req_state, bool *current_state);
> -	int (*set_parent)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*set_parent)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   			  u32 parent_id);
> -	int (*get_parent)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*get_parent)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   			  u32 *parent_id);
> -	int (*get_num_parents)(const struct ti_sci_handle *handle, u32 did,
> +	int (*get_num_parents)(struct ti_sci_handle *handle, u32 did,
>   			       u32 cid, u32 *num_parents);
> -	int (*get_best_match_freq)(const struct ti_sci_handle *handle, u32 did,
> +	int (*get_best_match_freq)(struct ti_sci_handle *handle, u32 did,
>   				   u32 cid, u64 min_freq, u64 target_freq,
>   				   u64 max_freq, u64 *match_freq);
> -	int (*set_freq)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*set_freq)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   			u64 min_freq, u64 target_freq, u64 max_freq);
> -	int (*get_freq)(const struct ti_sci_handle *handle, u32 did, u32 cid,
> +	int (*get_freq)(struct ti_sci_handle *handle, u32 did, u32 cid,
>   			u64 *current_freq);
>   };
>   
> @@ -216,11 +215,11 @@ struct ti_sci_clk_ops {
>    *		- state: The desired state of latency constraint: set or clear.
>    */
>   struct ti_sci_pm_ops {
> -	int (*lpm_wake_reason)(const struct ti_sci_handle *handle,
> +	int (*lpm_wake_reason)(struct ti_sci_handle *handle,
>   			       u32 *source, u64 *timestamp, u8 *pin, u8 *mode);
> -	int (*set_device_constraint)(const struct ti_sci_handle *handle,
> +	int (*set_device_constraint)(struct ti_sci_handle *handle,
>   				     u32 id, u8 state);
> -	int (*set_latency_constraint)(const struct ti_sci_handle *handle,
> +	int (*set_latency_constraint)(struct ti_sci_handle *handle,
>   				      u16 latency, u8 state);
>   };
>   
> @@ -258,9 +257,9 @@ struct ti_sci_resource_desc {
>    *		range start index and number of resources
>    */
>   struct ti_sci_rm_core_ops {
> -	int (*get_range)(const struct ti_sci_handle *handle, u32 dev_id,
> +	int (*get_range)(struct ti_sci_handle *handle, u32 dev_id,
>   			 u8 subtype, struct ti_sci_resource_desc *desc);
> -	int (*get_range_from_shost)(const struct ti_sci_handle *handle,
> +	int (*get_range_from_shost)(struct ti_sci_handle *handle,
>   				    u32 dev_id, u8 subtype, u8 s_host,
>   				    struct ti_sci_resource_desc *desc);
>   };
> @@ -280,14 +279,14 @@ struct ti_sci_rm_core_ops {
>    *			Aggregator.
>    */
>   struct ti_sci_rm_irq_ops {
> -	int (*set_irq)(const struct ti_sci_handle *handle, u16 src_id,
> +	int (*set_irq)(struct ti_sci_handle *handle, u16 src_id,
>   		       u16 src_index, u16 dst_id, u16 dst_host_irq);
> -	int (*set_event_map)(const struct ti_sci_handle *handle, u16 src_id,
> +	int (*set_event_map)(struct ti_sci_handle *handle, u16 src_id,
>   			     u16 src_index, u16 ia_id, u16 vint,
>   			     u16 global_event, u8 vint_status_bit);
> -	int (*free_irq)(const struct ti_sci_handle *handle, u16 src_id,
> +	int (*free_irq)(struct ti_sci_handle *handle, u16 src_id,
>   			u16 src_index, u16 dst_id, u16 dst_host_irq);
> -	int (*free_event_map)(const struct ti_sci_handle *handle, u16 src_id,
> +	int (*free_event_map)(struct ti_sci_handle *handle, u16 src_id,
>   			      u16 src_index, u16 ia_id, u16 vint,
>   			      u16 global_event, u8 vint_status_bit);
>   };
> @@ -342,7 +341,7 @@ struct ti_sci_msg_rm_ring_cfg {
>    * @set_cfg: configure the SoC Navigator Subsystem Ring Accelerator ring
>    */
>   struct ti_sci_rm_ringacc_ops {
> -	int (*set_cfg)(const struct ti_sci_handle *handle,
> +	int (*set_cfg)(struct ti_sci_handle *handle,
>   		       const struct ti_sci_msg_rm_ring_cfg *params);
>   };
>   
> @@ -360,9 +359,9 @@ struct ti_sci_rm_ringacc_ops {
>    *	RCHAN_THRD_ID register is cleared.
>    */
>   struct ti_sci_rm_psil_ops {
> -	int (*pair)(const struct ti_sci_handle *handle, u32 nav_id,
> +	int (*pair)(struct ti_sci_handle *handle, u32 nav_id,
>   		    u32 src_thread, u32 dst_thread);
> -	int (*unpair)(const struct ti_sci_handle *handle, u32 nav_id,
> +	int (*unpair)(struct ti_sci_handle *handle, u32 nav_id,
>   		      u32 src_thread, u32 dst_thread);
>   };
>   
> @@ -519,11 +518,11 @@ struct ti_sci_msg_rm_udmap_flow_cfg {
>    * @rx_flow_cfg1: configure SoC Navigator Subsystem UDMA receive flow.
>    */
>   struct ti_sci_rm_udmap_ops {
> -	int (*tx_ch_cfg)(const struct ti_sci_handle *handle,
> +	int (*tx_ch_cfg)(struct ti_sci_handle *handle,
>   			 const struct ti_sci_msg_rm_udmap_tx_ch_cfg *params);
> -	int (*rx_ch_cfg)(const struct ti_sci_handle *handle,
> +	int (*rx_ch_cfg)(struct ti_sci_handle *handle,
>   			 const struct ti_sci_msg_rm_udmap_rx_ch_cfg *params);
> -	int (*rx_flow_cfg)(const struct ti_sci_handle *handle,
> +	int (*rx_flow_cfg)(struct ti_sci_handle *handle,
>   			   const struct ti_sci_msg_rm_udmap_flow_cfg *params);
>   };
>   
> @@ -544,14 +543,14 @@ struct ti_sci_rm_udmap_ops {
>    * -hid:	Host ID
>    */
>   struct ti_sci_proc_ops {
> -	int (*request)(const struct ti_sci_handle *handle, u8 pid);
> -	int (*release)(const struct ti_sci_handle *handle, u8 pid);
> -	int (*handover)(const struct ti_sci_handle *handle, u8 pid, u8 hid);
> -	int (*set_config)(const struct ti_sci_handle *handle, u8 pid,
> +	int (*request)(struct ti_sci_handle *handle, u8 pid);
> +	int (*release)(struct ti_sci_handle *handle, u8 pid);
> +	int (*handover)(struct ti_sci_handle *handle, u8 pid, u8 hid);
> +	int (*set_config)(struct ti_sci_handle *handle, u8 pid,
>   			  u64 boot_vector, u32 cfg_set, u32 cfg_clr);
> -	int (*set_control)(const struct ti_sci_handle *handle, u8 pid,
> +	int (*set_control)(struct ti_sci_handle *handle, u8 pid,
>   			   u32 ctrl_set, u32 ctrl_clr);
> -	int (*get_status)(const struct ti_sci_handle *handle, u8 pid,
> +	int (*get_status)(struct ti_sci_handle *handle, u8 pid,
>   			  u64 *boot_vector, u32 *cfg_flags, u32 *ctrl_flags,
>   			  u32 *status_flags);
>   };
> @@ -603,51 +602,51 @@ struct ti_sci_resource {
>   };
>   
>   #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
> -const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
> -int ti_sci_put_handle(const struct ti_sci_handle *handle);
> -const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev);
> -const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
> -						  const char *property);
> -const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
> -						       const char *property);
> +struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
> +int ti_sci_put_handle(struct ti_sci_handle *handle);
> +struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev);
> +struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
> +					    const char *property);
> +struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
> +						 const char *property);
>   u16 ti_sci_get_free_resource(struct ti_sci_resource *res);
>   void ti_sci_release_resource(struct ti_sci_resource *res, u16 id);
>   u32 ti_sci_get_num_resources(struct ti_sci_resource *res);
>   struct ti_sci_resource *
> -devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
> +devm_ti_sci_get_of_resource(struct ti_sci_handle *handle,
>   			    struct device *dev, u32 dev_id, char *of_prop);
>   struct ti_sci_resource *
> -devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
> +devm_ti_sci_get_resource(struct ti_sci_handle *handle, struct device *dev,
>   			 u32 dev_id, u32 sub_type);
>   
>   #else	/* CONFIG_TI_SCI_PROTOCOL */
>   
> -static inline const struct ti_sci_handle *ti_sci_get_handle(struct device *dev)
> +static inline struct ti_sci_handle *ti_sci_get_handle(struct device *dev)
>   {
>   	return ERR_PTR(-EINVAL);
>   }
>   
> -static inline int ti_sci_put_handle(const struct ti_sci_handle *handle)
> +static inline int ti_sci_put_handle(struct ti_sci_handle *handle)
>   {
>   	return -EINVAL;
>   }
>   
>   static inline
> -const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
> +struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
>   {
>   	return ERR_PTR(-EINVAL);
>   }
>   
>   static inline
> -const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
> -						  const char *property)
> +struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
> +					    const char *property)
>   {
>   	return ERR_PTR(-EINVAL);
>   }
>   
>   static inline
> -const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
> -						       const char *property)
> +struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
> +						 const char *property)
>   {
>   	return ERR_PTR(-EINVAL);
>   }
> @@ -667,14 +666,14 @@ static inline u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
>   }
>   
>   static inline struct ti_sci_resource *
> -devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
> +devm_ti_sci_get_of_resource(struct ti_sci_handle *handle,
>   			    struct device *dev, u32 dev_id, char *of_prop)
>   {
>   	return ERR_PTR(-EINVAL);
>   }
>   
>   static inline struct ti_sci_resource *
> -devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
> +devm_ti_sci_get_resource(struct ti_sci_handle *handle, struct device *dev,
>   			 u32 dev_id, u32 sub_type)
>   {
>   	return ERR_PTR(-EINVAL);


