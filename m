Return-Path: <dmaengine+bounces-4922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F12BA92CDA
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912FD4A0F42
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331662063C2;
	Thu, 17 Apr 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEUxuBQN"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA218D63E;
	Thu, 17 Apr 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926722; cv=fail; b=UnPiRCrq4XZC2x6ctfEz5OIOF12AiN7Xoesmv2KFp9nbGRBp2GJY6oymI40t8s9X8vFSDKZbL9zdPx+Uk2f+2J4VckYQQeD8OihamutrqMCSuXHg9ZNGge1InZWCiBkX0uQLi3Cw7aiZM6OD8sdgVfn9e+EkZlTWwH5cwjCTX24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926722; c=relaxed/simple;
	bh=ZDoA19B28phZLbCWKhqW3v5Hjb97FwbrBZMSuV7iJJE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6mP6wobp6nb+dh8yR3kQMBpp9VLNdjBPe6CCx3V5fZ3iyBuao1aW2/LDYwhIcnyfepiF6A3Y31e9xnkky5c1y+e1tHMWhqiWH2WkU+wnGlgVuZf1IRdQzREaz/dYFruyNPc3ddslsdNkuldngUfgyxleXAqloN2t/9HOMIqyHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEUxuBQN; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb831lkeLwnzWUKrYsrQdxraNgPGrsAL3NhJ84mRpboMvUdjdpkrI/4VnWvEx1+x47C+81oAfsl4QDPm+rZrNUH5kw/gjQXyPANFCRbSkfwphPkPfoQPrY6u1OlzSu52Wk8GBNk6PZy5elzbrH3lGESYEdyo4MMSmu8iRMPxW02f8MIGjPfv4In+Nd82GxYh59HZFxsJPU3qmKb/d3GA7WAzuTzP+d6eIlYHBnudUvV8xAXLZTbX1K0N+6dCzM0bOx1HYDswu9Kocpt0xmeXoDbwgn9RisGzMCYgXFRw9/sgbNuu/iptkHeWHMJ+DWIkG57z6FYVG9gLIXL+9DI8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naNUxmbofIheLcc/hz7/cy2QGhHAewc4tPZ5YbI8esI=;
 b=yz5Pif24Tt1gau7AIsvgNGANGiG5PKtW9+V2XevdHk9Rw8rqI5wgfeUugMgiKylstO48ECHPhaxIowtsiKhtn/SIK/VSDi9tdbgJg2F+gKvB4tAIHOS9ATygfQejQKy17HDryhL/I45E+QEpIc467+f3GiGQCfAzEmOv5e6a1h0UqMi37DWnxzudtqCSh4rvVr6H1hnp2vnbAvBH/pC8aaOeZG8SVAu21D++T+8yl2EGwMS5OE7l9kgaV61pVW50celgPh3lnx1sH3ui/vVWjoArH2YAgA6KlkFQZGdsTeuEVIs7HNvjWL+AHkSjClvRClc0zBWyzC0gWz5IPgaWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naNUxmbofIheLcc/hz7/cy2QGhHAewc4tPZ5YbI8esI=;
 b=JEUxuBQNyaQEEx5liskjRdnHjJn+ph32q2Vh+mls2UdDqlqyZU+QQ+Kzs7+oXmcEkKIE9Qc9YmhljAtDWcxukDUr4ACkW4X9zYEUiITlGLqfkZKQ4uIa3sSe2LuEJ/AQ+6k6Z2ZUMeWg2uKC14LpgY//P6rRCFW4/mpjIe9gToo=
Received: from MW4PR04CA0360.namprd04.prod.outlook.com (2603:10b6:303:8a::35)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 21:51:56 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::1e) by MW4PR04CA0360.outlook.office365.com
 (2603:10b6:303:8a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Thu,
 17 Apr 2025 21:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:51:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:51:54 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Henry Martin <bsdhenrymartin@gmail.com>, <peter.ujfalusi@gmail.com>,
	<vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Henry Martin
	<bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v1] dmaengine: ti: Add NULL check in udma_probe()
In-Reply-To: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
References: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
Date: Thu, 17 Apr 2025 16:51:53 -0500
Message-ID: <87fri6lame.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 7932c90b-0709-4457-bfde-08dd7dfa123a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p65ri/5MskqL/Z/e2AOQur01oX5B6YTcJU9Ebcd6l75nZUAGnCzzbe2jRiys?=
 =?us-ascii?Q?Af+GihCRXNdKbC+ASsh5BW2KBGpVqgEixT3saLgLgcpTxq1Fr2lw1Nu+AfXM?=
 =?us-ascii?Q?yLmCWLYox14COFHl/bzBoZRiiTeIRo4Y+uJnA4/pjMOpLvMN7sjWlBENG2s/?=
 =?us-ascii?Q?dHuMpUnJPKQy1qBkUSGXcog8rLAEuJEXSXp7bFtzRZy9q2FmMj87o4cuu7T5?=
 =?us-ascii?Q?IiernAzq41udjBlxg1UIFxJt8B14V6syiURt5Tc34s/G+wGX81GkSjPhcWCC?=
 =?us-ascii?Q?a0PmZwcIdKhGpC0TVHHDmOpU87MxCIuHDUSQNHhogNVeXjA+knuYdh96uHHN?=
 =?us-ascii?Q?h8tYkxnjY2NRnYCr4cre0kn9+sKVvdmMQxrXCnL2e8nHOFNdVrMunVUC9fSr?=
 =?us-ascii?Q?GgqlwbXoBCIQVbJa70EKBa/X8h/H79OKZPfnNrduU69Y1dU+K2mn+n5Tt0pQ?=
 =?us-ascii?Q?fthzXF7ANSEwDOJC65tYjiD2E7hbPK5PwfJDfcuDiFVsdrC6pHbTiGaRGSpU?=
 =?us-ascii?Q?Z/rLsRwEKtzvMqRxunfNsugwWO+ZnF3c04inqo/oXlrIFaBdgc6RWW9ZbPsL?=
 =?us-ascii?Q?AWF+c0gMxdgBh8MpvEXzkVjrPq8dzQElda4wp9cbarm87C7oHfWVrU3dTEMH?=
 =?us-ascii?Q?2rcWVF2G2EkOhHb97V9MX7x8g41I5Ecl0WptFMtVOi/Jq4Xn7t2GDJU1lbTg?=
 =?us-ascii?Q?PfttBS3JU6nJVc+hNnSuEpvUurdgmNvv699YyARV7ee2EEHr3fe5MxL9MGhl?=
 =?us-ascii?Q?Z0VRGgScnyj3sX5UL7xW+e56rOOZW32w+DPsTdKIoUSMdo/PszJFizcRnw3k?=
 =?us-ascii?Q?m5a5S+nYcV4v7buSRXACKZBSxkhGRY7//+570iDBdaQTvN7CE4oaaAIMjO2/?=
 =?us-ascii?Q?qUBXIXD1U8oP1Mlf/xW9b5ee1KqdswCDIkyU+s4Mjz8G46SW9TQq5cPu3Btb?=
 =?us-ascii?Q?uoa/HMNhgWHthr6fjpqpsTgQWXUWZREluxgkpVgdk5GMnognvr7Tw1RZGLtE?=
 =?us-ascii?Q?evencRNkzbzfIR1IY1BMeSLXsb5H95Si8N7srGRYLjE7U+Rv7t0mpWJ4Ayr9?=
 =?us-ascii?Q?w4UKDCA8J/PLzKOkwKNE73q+rtrp72j530/e91uJpp2kQha3LL8lYux6u490?=
 =?us-ascii?Q?9j2Q2Gaa4fG3Xf0s9gwbYU5uzSKSQ+pyJfTvvb+hMlsBenjnxj9+SY9S0OMY?=
 =?us-ascii?Q?GP9pNxKx8RoqhtgVjcNtri09uSquyD8r9ySofNBS+uMNxGrjvO3Pk5qdnaxo?=
 =?us-ascii?Q?H63IKDAyyeyxt5agXHVxO05hli+wvPI4DByXBqeICy4xuyp/rohNog0MBcIB?=
 =?us-ascii?Q?pVjDgnVrJy0flPLvXBQ3a7DffqepRVkZveApLNLJOllf2pUl59hcv4bQBLII?=
 =?us-ascii?Q?XoI8FZR7g3oIsIuWd0tdroOaDx3YWOMlpIbl7oAIatvJs2uyGvwSyBJrcGOA?=
 =?us-ascii?Q?d8cs57ht/FAdGDsIgLQUlVbW37chwc9zgWK335dKfFZpWD+ZE9VT33KPtgE0?=
 =?us-ascii?Q?rP/Xvc50gUPryhJynTC5ZcUYA4RDIqnTpSoC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:51:55.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7932c90b-0709-4457-bfde-08dd7dfa123a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455

Henry Martin <bsdhenrymartin@gmail.com> writes:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> udma_probe() does not check for this case, which results in a NULL
> pointer dereference.

Yes, it does look like this would happen when uc->name is eventually
passed to dma_pool_create(), at least.

>
> Add NULL check after devm_kasprintf() to prevent this issue.
>
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/dma/ti/k3-udma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7ed1956b4642..f1c2f8170730 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5582,7 +5582,8 @@ static int udma_probe(struct platform_device *pdev)
>  		uc->config.dir = DMA_MEM_TO_MEM;
>  		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
>  					  dev_name(dev), i);
> -
> +		if (!uc->name)
> +			return -ENOMEM;
>  		vchan_init(&uc->vc, &ud->ddev);
>  		/* Use custom vchan completion handling */
>  		tasklet_setup(&uc->vc.task, udma_vchan_complete);

Returning -ENOMEM directly seems fine, even though this is in a loop
200+ lines into udma_probe(). I don't see any unmanaged device resources
that need to be released before returning, and if I missed one, all the
error paths this code precedes would have the same problem.

Reviewed-by: Nathan Lynch <nathan.lynch@amd.com>

