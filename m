Return-Path: <dmaengine+bounces-10072-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLUoL68n52kf4wEAu9opvQ
	(envelope-from <dmaengine+bounces-10072-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 09:30:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 475504379C2
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDBC13012BD6
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953C34CFC2;
	Tue, 21 Apr 2026 07:24:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F3175A6D;
	Tue, 21 Apr 2026 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756264; cv=fail; b=nYtJ23MejX9WHVI8PcXBDkx9es8mMlCCJKT9nJLp/Cu32rmbo7O9GJ1NVU5eDydTAhBhz/z8fhCYMXkZ4mmZgC7QAz+FMaWiDvegyct2fm37nQddQ4w3iMCP7fNB6h1BsEx8hcg1s3QFD8JOFPHnE260OPUPrPBurwu5ydlNkYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756264; c=relaxed/simple;
	bh=jq3qMsGWqyplXPP16Xg2FeGmoBUA8JVV+FkWnkoBSMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab7jMXhAP2e3xUB+sOIrQGifWkhevZ/cs18S8DJBIg7WlSYn/1cUoZn2gag/YMkfnFAkCvw4VtN+lt8dVzhsI6xrRGVYwTT0NiI3eWnPOCNfuA5yb3N5bMqweEuUxayEJOiCrRdvtcNLjFPc6D9H7IvBHvII6r1hqu1FyToJZD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBVVgn76V+apWO7/9IJu/uJOe10tW1ZKZWgJyWd0rFwbEMkNOcXYfky+EAIeWmOGxmAHkgwcUagHkL1Zab6XqgJIF6XjgZ7151SFPS5xGHzz+8rzjEKvosgGB7d9T5B1ISnQhq8fcoL2zQG12Ftah2smDtkcCKJoDhtqJnm38b2RHV81a4vC4xj00GxU8FL+M3aENoV4ovGsR1LErkKhjsiSRrsAft9rAWGN+HC67LYQaq5lWNF8mW9B79/0NYosq+q4421DruUHnWNuEWljH9S4ao4LOZ/wrcdxN3+5TiVmNpzY7HC4G3Lw8SinoGGb+H64Yb/25lFuJ89YGcLPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ehx8b1vGpM+1jTfOm579D4xaYy2lVCgplYViWaypLw=;
 b=ZXkgJ3zxIDhJQu+r5O619/P7bP93ZB0WtI9vfG6aTXZkwZJfx6iNv89szVa7fxd+ts6Rq0feDnHzfvru/5Bvij4apee5o8iTo8PjLaWuPU8035WtKcLca5cf5d8U9USsygBm+T6fDR4mqO0SlJCVP9tPXAn4wBCKkpB/QK29qFoVJb/Ufq0LCA3jnPDAuYV7fNIICwdR8ehOjSGkiUWaexT7lfitwgd3tf7aWMrdbt6bQWA/JRvqyGQoO5eqBnUNwH43ihG4Oqaqpr8Dsfm+zDbzjFYDId4pBwDVywvoJ2Xk3vrS5fMz9SUq2tT+HcJocuZqsU5L6z/xtZXbtltxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:1f5::14)
 by KL1PR06MB6886.apcprd06.prod.outlook.com (2603:1096:820:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:24:16 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::8d) by SI1PR02CA0046.outlook.office365.com
 (2603:1096:4:1f5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 07:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 07:24:14 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8AFE9446DB61;
	Tue, 21 Apr 2026 15:24:11 +0800 (CST)
Message-ID: <932db8ad-a9d8-47ff-bf3c-62a54c42bb76@cixtech.com>
Date: Tue, 21 Apr 2026 15:24:11 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dma: arm-dma350: enable ANYCH interrupt for shared
 IRQ wiring
To: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
 Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260325112159.663881-1-jun.guo@cixtech.com>
 <20260325112159.663881-2-jun.guo@cixtech.com>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <20260325112159.663881-2-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|KL1PR06MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: c9131afa-547c-44c6-598e-08de9f76fd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2HK6hsaQuGJXcmGpbh6PXPXdkEBcYM8ws+uJ2YnQpvTIVCm57K/6fuJghCMSy6OdreKFNZe6dGxkJZ72QDoEHex3X2ntTuEUosf8syKwGj2Xx9VwPExynOQGKNNb8+RikKx8XL5X+5Az/ucRIy9O4t1I6JJLwc1T6Fch6YoSGyozoDMafrub0qTw/iv7jDI7OkUvEw6ifZueWUpKThvIg4omJzmE5MbrSJcMfxjAMajeq8iF/IR+kbTeqDatgKoB5uRRqdlnM9XavaJeTVFG8W1q93EgHavmG5nSPTLwwEhbZYgMSUUtkeuCdm1ROM7+jvZOieHgA8mvnSVDCs5WpEJ806lVgont1fYmjAHzO+BjVbcjXJ+seL0o2nSgrz2p2Llvvq32T3A7gMaWLCMqV+0oPsxQa70Hpp0Pb6xaKw5X+cSFO/LgCzKx/LEcfcDSg7f+xwce446Hh8FVD+0GRRG/SJg/oqmFtmva330xA6bx784NqjDDKbXBGXc9JY87g1HLSXv8nVXmEWVr7iv8Dlr2b4rBNAWm233vwGLulmHvJPhvFRn1pZ4GyXW4oADQTt9fsRVjG5WUnJyeE1dETRh5ZhkuqQLM6n8U7sw8JjZ3WOMdQMP+xfd45awqx+jdyPTkCP3tVnzqu+g8APi0nvXns4gH4cE/PdgDQszWE3RlipRZnTPSxEshu0+76OWnH4lovm36wk/Dod5Ye3INjZ5IRKWhcEPq6ig9l1ELaweRihvbdNP+Z8plirX6WQZyqcLuSy0Xwg+1gtlB+YpBk50MT3fwHiTRfKeVvRXL8+dGyZOdd3h0TcNF00PzlOAT
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nC+IrZKDLKQJlmf9hYZwVVVUhLWQ0L4bAFHWjUTGqYGcOUVBQE7sQ+Zj2EiYujRCu5qzQprQgVoqJa7iJLdYNkoqVBpLlk6WFArlHs+uhmqj/8uu3ZWSKRPp7y45cS0qydBLn6cIcSXEeIxQqPBRffrH3Ucdn1nKUh9H4xdnkejC64yzIRhR8Pw02SQzUl024LspVYsb0wXui6cf48+TJa4zjFdHqQZfXEJOGSQcZ16rr9PDR2qh22mpSLiodbCBDP1861+fOYkULaowgJUb0llUpxHzlvnFED4vzLbhqyuhYSiOpCznj9Lw1gg/8Y16LSyrHdsDqxLxEcqrFEtUDeLIL05U8u47hfmVb7SKWsMbGvf3dx/O6Zg4TYO4Ka6m8BQqC3j7J2b1dUWxdiv2gint44Y8tMbLRJ6OUlExo5EUNPyY9m5p+rOBiaRzXfwY
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:24:14.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9131afa-547c-44c6-598e-08de9f76fd88
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6886
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	TAGGED_FROM(0.00)[bounces-10072-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cixtech.com:mid,cixtech.com:email]
X-Rspamd-Queue-Id: 475504379C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Robin,

Just pinging. I’d like to ask if you have any comments on the latest patch?

On 3/25/2026 7:21 PM, Jun Guo wrote:
> Enable DMANSECCTRL.INTREN_ANYCHINTR during probe so channel
> interrupts are propagated when integrators wire DMA-350 channels
> onto a shared IRQ line.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>   drivers/dma/arm-dma350.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 84220fa83029..09403aca8bb0 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -13,6 +13,11 @@
>   #include "dmaengine.h"
>   #include "virt-dma.h"
>   
> +#define DMANSECCTRL		0x200
> +
> +#define NSEC_CTRL		0x0c
> +#define INTREN_ANYCHINTR_EN	BIT(0)
> +
>   #define DMAINFO			0x0f00
>   
>   #define DMA_BUILDCFG0		0xb0
> @@ -582,6 +587,10 @@ static int d350_probe(struct platform_device *pdev)
>   	dmac->dma.device_issue_pending = d350_issue_pending;
>   	INIT_LIST_HEAD(&dmac->dma.channels);
>   
> +	reg = readl_relaxed(base + DMANSECCTRL + NSEC_CTRL);
> +	writel_relaxed(reg | INTREN_ANYCHINTR_EN,
> +		       base + DMANSECCTRL + NSEC_CTRL);
> +
>   	/* Would be nice to have per-channel caps for this... */
>   	memset = true;
>   	for (int i = 0; i < nchan; i++) {


