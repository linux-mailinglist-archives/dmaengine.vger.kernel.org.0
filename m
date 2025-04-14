Return-Path: <dmaengine+bounces-4885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BCA88F82
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 00:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3101891416
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0897B1B9831;
	Mon, 14 Apr 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="As8WJJB6"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2221E1020;
	Mon, 14 Apr 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670910; cv=fail; b=ewPRHCHGuzMhHsABTkF1pPncXBT7lx9z2SoKDK5vN6+Iwj+NUPnZiKhU/dPCIeJuvFD+zCp923ZpOQ4IHsqlwEyuxz2Y98MHfEwrOvNJlapOimM8HKV4r+5a90M3r7edXaF/uXP6C1qMOt4ObddMClas95/+dhzeyv8kFA7WLTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670910; c=relaxed/simple;
	bh=NNKuVFeCyK7vtN20mRigPqCmnumQahWi0Kfu76HWIEU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EOkiswi/O+pLNweQut1FSHpqeSHCynjxtZKFbA75I47Ry5GLJ+XLf2voQN/y2hD53dUw5UYC25E4/5HoSUYT/rpkItD7/cKeo2+B2aikl6DD+5eB3zreZF8UbwNmEyMxDV+SSLsM/ClgW5eSiV6ggjJ5UM8NSPp5wejRpU5mvUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=As8WJJB6; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAboLL7YYQcNL22rI07oOgtxfm+8nbLiDD2Vh/Y0Epa2JJDT+XYv2UTga60Kfvu4SEnqE7WCKS1MODgVGHKgfhdUL1Gl/i0peGhbjhZYEmwc8weA3mLTpQzqm2cMDZvF50Tfx/jWagtoEmEWmmxyzYIsgZshw87LQBfor7et+RYHEnPpRSwkqQUJ0IF0eSS9oAsKt1QQECxUymPF7xj7qAhMmOLrTKwhu2sd3Gu3SfZN3XcJlT7uEvRBs2UusjBVfHTEyvTtPaZasjyvYpHgDLMHHMCbxC9crsx3OGCIROPB9cMeIi77hcaXkQ7lWtw4J/SWk6/pqDOSxqN2dmvDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCzoHrLLebSmE9H9CM+uTvEYwBUKEcaH6re5NoUahds=;
 b=UNbiVi2BYJPdsansQ2I2Fs6O+3JQNKDhWBHx7vKVH//Bcc1l2pey/dSpkqQIOlGRO/bSbbKIT0IBVgIsCvyHvMWQGi7O9/7KiXnGH7J1xMMSbgkXoHj4XV67Cq7Lglruf5chJ/DnhzUQvhaF/uYHhpvK55vLfQEblku/Hlw9+05EUH2mxQfDnYhpX8GeafeIRB0Fpul3ZT9bANgWOa1Edsn3d1gQb5TgElkTCJHTyFVdYf2WO89DZ0xWWsACncwc1eSZJB+j6mEaOtQNFT3RUcf6Iz1aLIKql8I9P0GC3lKk1vlkXx3+9s0//Xr5TrU4m+cLWhzvyufgjBV2d14yOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCzoHrLLebSmE9H9CM+uTvEYwBUKEcaH6re5NoUahds=;
 b=As8WJJB6AsOUCrpMFUHU8qH0Va6Nn3JbWWouEXH1b28dShjWA6Z06GJTnuJUtcTjJd0nuaQmh8M5rmVV81hEFooGNIzKgFDPk/eIInSiKZhcuQINET2uADzx87wVcc8gUpT/+tQ5cV6mA5fBzl+hQrQ3NxrYe45wE0E7/bDuJVI=
Received: from SJ0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:a03:33e::18)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 22:48:24 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6) by SJ0PR03CA0043.outlook.office365.com
 (2603:10b6:a03:33e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Mon,
 14 Apr 2025 22:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 22:48:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 17:48:22 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Eder Zulian <ezulian@redhat.com>
CC: <Basavaraj.Natikar@amd.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: ptdma: Remove dead code from
 pt_dmaengine_register()
In-Reply-To: <20250411165451.240830-1-ezulian@redhat.com>
References: <20250411165451.240830-1-ezulian@redhat.com>
Date: Mon, 14 Apr 2025 17:48:16 -0500
Message-ID: <87y0w27427.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: a31c2c60-2b3b-41dd-0b78-08dd7ba67652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LokmVI1DFtUJmOKnZiSxVBwnwp9ffXsU+BT9jL8zs/BY3WaWRgWtncFK8/iM?=
 =?us-ascii?Q?XJLziYW7dUgyUqHLXYA84eYAhzAminG65P9QhUyATNrms3WzO9hwo5z41SjJ?=
 =?us-ascii?Q?rivz23ReUvG5rv9i3hN2GCo6jBncQHgxVuhYin3izQxKIfRoF5m2DuqlNxbx?=
 =?us-ascii?Q?Ok65ASMeNzTdXc/0IvOFIiid9ngpk6qO2VTya/rfFhWj1cr92yXlsOZPRQTz?=
 =?us-ascii?Q?veDlDsI1OEhLh6D8Y3N7d8jk1orOnzmDMZXSHUBB94ClhVn41QmwlLiDkR1h?=
 =?us-ascii?Q?jwLcYNJnVxcSGGRO1dNHCllpMsej4jdHj/mkyY8vsITOl+c+kqSFFCDLBYK5?=
 =?us-ascii?Q?okenqqOC8KW1s0P+89c7tARqpceniZEY1kRHr42/OkBfLBJ+8KB+maQXOqoK?=
 =?us-ascii?Q?K6gMR+IXZUxel/Sn2enVQiAq8goz1nrp7b5xrBip2IyDXRhBclHbYrUfzJdg?=
 =?us-ascii?Q?zG3c+x4mm6BjHz0Cb82Re7YeG09e/ngn7/rFKigKOMzvFdaBVa/wiYCezCHi?=
 =?us-ascii?Q?plUw5ai6LpK+kb0e17wFPcRUwqBM+XKOL3JINhhvJBHCfomZ3VCJupvVQdsV?=
 =?us-ascii?Q?6w9xLuE7/id3U32ugODifP/0gmokEvD6gGJlfVFK8Ty2yuDfs+05QYXB28fo?=
 =?us-ascii?Q?bG0COdVt56Xo/ax/zlvFGlPJwt3aBQBpMiLb08xgdDJPfKxghCKmttrgBs1/?=
 =?us-ascii?Q?WWfR1uCV6wrL78o/pDIdj0MjL3hG7nW0zN3sLkDNzA78Nnb22sIv5Do/Va9t?=
 =?us-ascii?Q?m1oFThH0hk0NGIMK+T2XoJdvtdCDBGQso8GhI8m8DlrFj+zx5pn9OD3HUApU?=
 =?us-ascii?Q?xQQOfzrY52WuoCM9Ekn84H1iKVxho/deFU30zXSm1uq6EqYNw39XYyNVst+t?=
 =?us-ascii?Q?dNFnMs9FfQRzCHUGc2Mifc50tJNqisLTINA66L9In3M1Q/PMoVkbChCgliS7?=
 =?us-ascii?Q?mIOP3nQ8ojw0mNWuHYEizLv86ij+r20gPU0PmjOjmkJr/8gjxMiLDCS2ybEZ?=
 =?us-ascii?Q?j2BW1ihSCmRkGuQjRZMMsJ5v+JkYv6H83plAfS4a4hSWMlLoZyGAwe307zYF?=
 =?us-ascii?Q?elccId4yadkpP5iVdtp1BkadI8iYZJ7aX8LTw5DQCB4PK8rtnk6J3Kz39NT2?=
 =?us-ascii?Q?25+tYjZOKuqYzUXWBpHBiUD0C2EWV/FatkC3OUCNO3AP6QXaFO2AycxgM9Oz?=
 =?us-ascii?Q?SsOCwDxtVwQ69145R7k6yCxPgqHkVhg0mLn2ewEVyBKGF5Nj67xc8ksU5sQW?=
 =?us-ascii?Q?Uk7HfXQ4BsPPJdfADJ0bkMrErGljVBu7yg/BY9FFTKlgiWUMFScw5BezLUsT?=
 =?us-ascii?Q?VOHVXOMu+gCTxPFZgOO1Y+Cp+Q4TSkTvZ7yqdAwO97K6j8FpRH7Twx/OtKP/?=
 =?us-ascii?Q?PKdN3s9J471ArJ6QD+A8FpHSrTCEWt4YqjU3+xEvUsFfIQdUdvmihR2Fyxd/?=
 =?us-ascii?Q?eMCXi1LHJM1sdtXQ6NrJB4pHU4JKtDBloDysf7U/heTy196iCIQIgCNIoEO1?=
 =?us-ascii?Q?VLNL1/lwcCRI22dmugGReBSikHrFuwXyKwaP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 22:48:23.4948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31c2c60-2b3b-41dd-0b78-08dd7ba67652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367

Eder Zulian <ezulian@redhat.com> writes:
> devm_kasprintf() is used to allocate and format a string and the
> returned pointer is assigned to 'cmd_cache_name'. However, the variable
> 'cmd_cache_name' is not effectively used.
>
> Remove the dead code.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>

While I work at AMD, I don't work on this driver and I defer to
Basavaraj. But it's easy to verify that cmd_cache_name is indeed
unused.

BTW it looks like struct pt_device->dma_cmd_cache could also be
discarded.

Reviewed-by: Nathan Lynch <nathan.lynch@amd.com>

> ---
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..3a8014fb9cb4 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -565,7 +565,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>  	struct ae4_device *ae4 = NULL;
>  	struct pt_dma_chan *chan;
>  	char *desc_cache_name;
> -	char *cmd_cache_name;
>  	int ret, i;
>  
>  	if (pt->ver == AE4_DMA_VERSION)
> @@ -581,12 +580,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>  	if (!pt->pt_dma_chan)
>  		return -ENOMEM;
>  
> -	cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> -					"%s-dmaengine-cmd-cache",
> -					dev_name(pt->dev));
> -	if (!cmd_cache_name)
> -		return -ENOMEM;
> -
>  	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>  					 "%s-dmaengine-desc-cache",
>  					 dev_name(pt->dev));
> -- 
> 2.49.0

