Return-Path: <dmaengine+bounces-9710-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BxkJSE+ymnD6gUAu9opvQ
	(envelope-from <dmaengine+bounces-9710-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 11:10:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49029357E50
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C0C30160D8
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857E3ACA7A;
	Mon, 30 Mar 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHEURsVK"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E82D6E7B;
	Mon, 30 Mar 2026 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861435; cv=fail; b=UuDwePAQ1qjTnkcwwJH0NDiLqFqJa9gfchkx3EeNRZgQDu3OCj3NRxK97JISEEUcuN+qDwqe9QdyMnTinWLkEF0xclVnE3+4YDZLTjrIR4LHqLVVqQtXB9LI5enBe+O2JER29yn1XIiqyvreUZC60lR2C9PAOJsCsRrhtXihNz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861435; c=relaxed/simple;
	bh=ILsytof+OjAQD6pOdQT69cd6dJtjwaqV5Cy8b5ugTr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG24TABN3uHh6ISnG/CQD665ZjTU6wWS2IjUaYsFkAm9b1PEh5OHpMdISYmIjAP2Y5rMb/NOC/QirWc5u7LkSTqAGXSxQ8IiS7Y4y7u5ERoAEjI8dfzc/1mAMoGAkCyUfcDA3eNThdi7tfJcW40Bj+Fq7X3e4Pgyg2m6Y5N22gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHEURsVK; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPtWQv95ROawkTkyAXI70uZTv6PU06K9fsjktqCOEQmoohFJCb2JZPiWv0Ilc/GN0Rbhtq/nBaz7P68mOpWaT0pWY07FK1hhXvB1dKsZ4S92Zv0UErHcJjAdfiiLZPGnFKtQ77qybU8ZGvk3URFSydctaART0mo1+vpfhrph+cTOGxUVZpk52snfY05Gcmqr8K87XgBkqr9CvoDLWxpk8xAKNR4D2xL2EWKnnOoiTqo7pnUDwE9S9+JLrQYvxGaEI0QLdWlePNXloHZ9k0LURhbpQr3/r7MDcwKuAnpwxNXlSwGZqr3qDH9C1jcOOAP7UKXIj6pYgTmP0JrNZ+5FiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlSLTfBvPxWLnftxdGDo5FDZWjJli6shCTRATo4jx2Y=;
 b=n1ClSKPmr/2chJpXNU8usXADQiYGGx82kYgZ0beXsaevsbldUypAgPACY2GB3fH2uv940Re5HwTyTNabL1T2blL6mPUh3bSgROaM430UwqypDRm2ros7vDX0aoolteffYQzsqQlnAbQ51NZHc55DU+OQxvj+5qYukS0oQaidq1OA1DKH3HS+9He+HNLX4vpds+wXl05dYKmfiCgI6ltKpgCrgCPMmD+xDW7BNulTRIFrMXHDpEjoe8j+jI+iW2O5BYYSeOeNuVWvm360PHUh4VYrkjlmSVSKDYVd/2e6wpGIRFicNVt7EEhdIwvdqU1cD4e97rrN0Q/RqPoUXglYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlSLTfBvPxWLnftxdGDo5FDZWjJli6shCTRATo4jx2Y=;
 b=HHEURsVKuorm0pPTdzzQpSi7Ml/wSyYzYfNkltsczfKU8l5cFEUPboh0JvZ9tCRNOQygu3BNpI28I4qMBfVmMKNwiiIKKTz7CFseJ+e5vRXAlS8perncOEjI3aQnW7dopwtufBiPJFGec85X1aXm0q42zL3WjU2plRp3h10Xl16d+N8yb7zt7Y+HF8JHLMT2CuBxga0pOxV4VuGi+r+6wh6fGXwovhtjP9CfATIrCuXf+De+CkWYjXMJ4d1GUflWTFDZ4YDnncGRCQx/Colw2iPn9JXALfvCo1WSzmtecvV6WXZWL/CFrQK1cyXQyaRLWu4jpP24FCnehrlDuqAgng==
Received: from CH0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:610:11a::28)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:03:47 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::c9) by CH0PR03CA0340.outlook.office365.com
 (2603:10b6:610:11a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 09:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Mon, 30 Mar 2026 09:03:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 02:03:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 02:03:35 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 02:03:31 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@gmail.com>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v4 08/10] dmaengine: tegra: Use iommu-map for stream ID
Date: Mon, 30 Mar 2026 14:33:30 +0530
Message-ID: <20260330090330.52081-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <acWWW6r5gZ2nGerQ@lizhi-Precision-Tower-5810>
References: <acWWW6r5gZ2nGerQ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c52a66-e4f3-47fd-09a6-08de8e3b406f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UwL2Znog9dMRL6oE86wY2C/Hrmw1jq5obQzN4Si3iqv6HjI8s8Gx0CFmoxUouQ10fQuu5JyHM7AFpi8l7isswJz9CA+Oy4NFgMtBkPy1VDCUkYp55a5cGpyEL4XfvvJ5jD1bQ99INwfMIrDsL6d2sfFC1CavHwh+FgK1Rr5vvyxQWZWXdBg4hd0DKVTRB9HYAR+YUu3vjCHICkxhTyace8EiuLBVBsiO5pRR1seyX82kCsUGt8fKTYpLwv5KDuTOg4LmpLNX0c5YHuGAZxNT+jF21SZ2vIew02vIM1mCglN25mLVgzEMbmJJ0de67y1LPYCZINjVCEVhqLVFeJgOgxrv/Dx8lng02qxJc8AsZZeSBE4/Tdc83gCCc9p0YzCYUeMgV6XFGWNyQbljOETy71kGmSkPpfuRQnx4GnPzsb7mIg+POpeANyzvIGIDzATv1RLczGFauSKVUTSgUjDGohgLppf1ouj9ROo5S4ckVuEh5apWfH8d34rkNJhq85oArXbrk0JgPLT5vA4Oymhn1cPTqDmTsIOJmcuAf6vHTQ7CAQubLbZexvqJggbrzbg2Wnrb7FJob71WOsofWJ5TNEItsLxJAe8dFk2aCHYjZdX1BTdL7Eln2/nKWrpwAbRdvs2+BSejUAIqzfFx23dKozecUwvHkW+A1hhN35keBNVxLjoVh4qT+5C/NX3WhDg4SZTExNts4QVOK9aE6ihFGvT/2NOVstaT+orLf2+YLUgqMz/rZTeScXOGd2gm1E4FBsefrW0aohTqupe89ITNZw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MTbLH2CJ540wfK3pDCmVlC8F7ZRpwsluLD6T++hCxJ0/XP7f7WvmMqYeYG2s6KrkQdTMn8SkuXJK8Av+skJXK/y2zbT+Sqp7IKBVBg7fGfQdF4xaooatqJZhI858KZ7yIX5ZycMqBp0Op0JyrrbNg+fTz6ZLWEojRLzPQHuDoYarFwoIkG/5mVTmGGFXQ/n/2eDsMl78ZnqogRDF3o6nHRK7iZ/T83gGx4ivqQA90jslACSyTgmchmJzrJ7Owh8966hl+ieI3cVIUTDSFmJ/8wGvG3/9emEyhKaEZcr0v4ViuaIhREYM9XxBdUmcCZiuVRHedLQV8z2FXvMZmWpK98ROmkc6UvyHU/kr7biE/jwwmHAjl9ivyv/phmJn1+MjHt+PYdtjormPSHHhQSliKKP99TVZkkrCXcpmPrtI9wdjVSpUSyM+2yMvFv3eyAJG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:03:46.6942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c52a66-e4f3-47fd-09a6-08de8e3b406f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9710-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 49029357E50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 16:26:03 -0400, Frank Li wrote:
> On Thu, Mar 26, 2026 at 04:39:45PM +0530, Akhil R wrote:
>> Use 'iommu-map', when provided, to get the stream ID to be programmed
>> for each channel. Iterate over the channels registered and configure
>> each channel device separately using of_dma_configure_id() to allow
>> it to use a separate IOMMU domain for the transfer. But do this
>> in a second loop since the first loop populates the DMA device channels
>> list and async_device_register() registers the channels. Both are
>> prerequisites for using the channel device in the next loop.
>>
>> Channels will continue to use the same global stream ID if the
>> 'iommu-map' property is not present in the device tree.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
> ...
>> @@ -1490,6 +1496,41 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>
>> +	/*
>> +	 * Configure stream ID for each channel from the channels registered
>> +	 * above. This is done in a separate iteration to ensure that only
>> +	 * the channels available and registered for the DMA device are used.
>> +	 */
>> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>> +		chdev = &chan->dev->device;
>> +		tdc = to_tegra_dma_chan(chan);
>> +
>> +		if (use_iommu_map) {
>> +			chdev->bus = pdev->dev.bus;
>> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
>> +
>> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
>> +						  true, &tdc->id);
>> +			if (ret) {
>> +				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
>> +					tdc->id, ret);
>> +				return ret;
> 
> This is in probe funciton
> 
> 	return dev_err_probe();

Ack. I will update.

Best Regards,
Akhil

