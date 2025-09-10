Return-Path: <dmaengine+bounces-6440-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C6BB51B93
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 17:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A855414A4
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E322586FE;
	Wed, 10 Sep 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xb+DVblI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A51311C11;
	Wed, 10 Sep 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517957; cv=fail; b=AVPmOqLr9tVNb88KCklWU88nyJhzmEMlpOq2prWwSEcCDx2yCWvSywHLtC4YU3U6/7eRwYYIMObbG1xaipBGpoQbBChmjR6wY3hl2VMgNW7Rx8exLk6h7yAGKL1KoUFBXIi656+GBAjmv4LqqsOJNLDTu9rPeCuRb+amzULHsSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517957; c=relaxed/simple;
	bh=ef2p3VMhA4++5MCrXgN6wvo/JhP+GkWhMwYsssLZSQU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4ImOzzv8HhcigF735T044rrqmGN38TBs0HnOR4/nM+QJFoUZaJk7e0OnEU4bcBxgRK9vxQFe3XsEHNDPZfUH8E86LLvWMAYfD6SBHBnxKYUZGEJNcAXJT9BLzYRzg7vboLxKhyszIwBoUC/I31VdXe0jOpQ/BaeqS8UX4dqQsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xb+DVblI; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8VuhVhVQoMWN0mIVCJKmOVYDMqgCr+l5rQu6kYf/ciNA6gr5dFQP8Gn/RE29TtTaSbtSdGaVg54VQMHFWFflii8sotQrNOGpFDCrH9wvCSaOyZk6QQoIoZ3FFuVVYlwd49uqf9Jbf58gmhVxyZwYJxLPqwmCiCOPY2WCZv4eFXa6ucSNxlROKDurqkX5e/+j60uxbIIAMPQ2cVpbyi+UOyZqmATZUE2q/vODpMGj1vlymQn31mVg9Ial3sH0HV5tWgQA1WiyGRHZMLyJOQ5vYYtEIOvilrFoIL+SPxxCj9mTcGXyllNzMU0yibdj3VlVyYGH6tFdzwCkYusGKy3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr9yfTMfqvHNzK0aouK5oybH7EUqA0rOFT6yan3OVj0=;
 b=lMvZrmvlpDssMjqC96viS8ajbI3JksU5dJgN5LT7Rh9qBwhpKnc7VCEnqY2j3ik4J+uXg/eNVRU6AbKTqUuocS8USBrZrB0Rol0uObfVoR3w7ON/DEMwDyG3ZkWTIPK5VqSc5DyEl8awpc6Hjq44xxmFIWedUp3DxaUEvrBvpwjg41ktSMPK7bK5CfXRTtoC8VpZuKfbZO2R3SdB1mNTcnFQU6R8TE399QjGPx3slZX2tb78x38FhHC5u5idn1uyCUxCl4te9Rj6+1/XoiHPhbP+mcdROl3e6vJedkK3fJpuTdAU+5I1Y8goHeUowTh2AcH12V+zhxBfkkWKe0Mg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr9yfTMfqvHNzK0aouK5oybH7EUqA0rOFT6yan3OVj0=;
 b=xb+DVblIb+ktIHgdPBN42y4IG7E0QupFhLDMJXj1iG1QQPADG4oQ+mhouwte1709DjYA41h2OQA/hOHSpdfdGBhzvP3dkC/B1V/Amo1exbNO760S3+kdBQEO7FIWY6Xec3o09tmZH7b+XTiz12+0VPyuQq9aa1V+jmcN8MQ2/fA=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:25:50 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d9) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 15:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 15:25:49 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 08:25:47 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Vinod Koul
	<vkoul@kernel.org>
CC: Wei Huang <wei.huang2@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver support
In-Reply-To: <4720dc80-4c30-4f0c-bbac-4e94285dc23a@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
 <4720dc80-4c30-4f0c-bbac-4e94285dc23a@amd.com>
Date: Wed, 10 Sep 2025 10:25:39 -0500
Message-ID: <87o6ri49e4.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3323bc27-118f-4c36-97b6-08ddf07e5288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvczciUNDUeSvhCIPYxHCQE8NngSet1q2GxH/t1iUO8cYtowSDSF4mW2E6iG?=
 =?us-ascii?Q?HvDZC43a9PVSpfhyCMXK7+del0z7IrfRrcL2BsAmdAnxXUfFEMWasurSq3Tn?=
 =?us-ascii?Q?Hdo+63Y8BS4ZnNHXeQq1acmDbTnXsCABg1w+/L6crxeW2OCis+POvg0tGos0?=
 =?us-ascii?Q?TpqlI1jKIJ3lrYnEAp4QfNAO6+Nxgn4h003o2G/Qopu5Xd6cErwHevUdFCn+?=
 =?us-ascii?Q?DDslLTH7v1CMjCSAc+9plQ3TW2iVqbd2R53K5yST15W84KGQnfqitnFeyPp/?=
 =?us-ascii?Q?lOYMTvBswNGlrTCHZnihlsIWCpW/AGuDP7mYAuh7uJ5hfm26S6XRfxKWp7in?=
 =?us-ascii?Q?ICtVnQzW6coStVpV5dH8evv2PUQ4sUss+TChX6TIyckv1cJWhEb+4tD5xLk8?=
 =?us-ascii?Q?TL32pMpvDg8bGNFUHWDVJ8flGir79ZjPscLg37zsqaA+milYHSJgyxDoJlWx?=
 =?us-ascii?Q?x8FRjLaX7v+mYXpg4Ff0G/9sWAvsbaSXRVhLobQqOGeKBFHvK6Rkm2/669e/?=
 =?us-ascii?Q?QJWKqDALrKX0sYh4bP0c9Bnn7RNdmAWnWXOrV7THvJx08j/j/XEeTr1hImrb?=
 =?us-ascii?Q?F/2T5R5lb3ZP9WxZXPTOsvVVunv0WKrxb/JyjRyxLjrdq9kNcuJN30O9qodQ?=
 =?us-ascii?Q?DSFLiNkZ1atMggipdrU4Z9XlfSBWm6IThIfx3j8Yc9PVH48azOXauPStroRq?=
 =?us-ascii?Q?bv8zomD+patQZxEVFBmOGZZW9ZxpEYEqeH1j36RRF6fPfpmOqEONao7Uyvrv?=
 =?us-ascii?Q?GEBRUvyQrWIaDsN1ZVyD/hGGDfV4tnqHZ4vIF/ItMg4AxvtxRVFGis6GWCRK?=
 =?us-ascii?Q?MjJYLd/XiFJGT+8mcQw+MnpMQYig5PUljzxdEktsSF2eu5MeVC6T8AjDZUAr?=
 =?us-ascii?Q?znMvcCjXZnGTKYUXFkauvwIlpH7cMvZu53hR0ob54u7glTniG7Xbq02W8g8A?=
 =?us-ascii?Q?Y4OcpArDX3+Ra22uCfE1ZrtCtsb2kr48atmp1VxJ2YyDORaWcfexcqOoAczh?=
 =?us-ascii?Q?08zgblIT7DH3gzpp7TyUeLZNJGqpRc4OI+15CVZZY2rCCbznGFAkfAow7uSt?=
 =?us-ascii?Q?gLX4fbissbbLZ4sboqPriVHQV4BvZ9qWbKaRp0XW1z7kk0FrGdko8/MmGK8o?=
 =?us-ascii?Q?31bSNqULWyq7LR1YcASw1AtTzmpYMkv+oycVrdvBzfLSEWC8xEsrAefUpEyE?=
 =?us-ascii?Q?y1l2qtwHHeYX3K4MTtLklt13XcE17SqA/iR1QiXcyETGDZsIxlx/h0dfPHZG?=
 =?us-ascii?Q?h5bVB1f+zzoayVVhSPJ9SH1XgYHuJSHuZyNHy5hl9Pmia+RXjer518sBAQod?=
 =?us-ascii?Q?0p/6A70192fz6U3yQSOF1vZcpqBSueAE0IHIl2rpG3vNzSkbSv/Rpb+09ycm?=
 =?us-ascii?Q?RK0SoEIVuZr7bcLLy0RA50NMCBQfG42vZJ8Cj2Vb/ROrl/K1sLLlz1pf3vLl?=
 =?us-ascii?Q?/zP5wlZd8vK5K5uZcrOpFofMDZfLfzc6u9BT98hR8L4RudhR8Yq+OdfouWTg?=
 =?us-ascii?Q?WcuE1bHmWpttutkLN9+VjP2CLTaRrF/tNpne?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:25:49.6367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3323bc27-118f-4c36-97b6-08ddf07e5288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

Mario Limonciello <mario.limonciello@amd.com> writes:
> On 9/5/2025 1:48 PM, Nathan Lynch via B4 Relay wrote:
>> +static int sdxi_pci_map(struct sdxi_dev *sdxi)
>> +{
>> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +	int bars, ret;
>> +
>> +	bars = 1 << MMIO_CTL_REGS_BAR | 1 << MMIO_DOORBELL_BAR;
>> +	ret = pcim_iomap_regions(pdev, bars, SDXI_DRV_NAME);
>> +	if (ret) {
>> +		sdxi_err(sdxi, "pcim_iomap_regions failed (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	sdxi->dbs_bar = pci_resource_start(pdev, MMIO_DOORBELL_BAR);
>> +
>> +	/* FIXME: pcim_iomap_table may return NULL, and it's deprecated. */
>> +	sdxi->ctrl_regs = pcim_iomap_table(pdev)[MMIO_CTL_REGS_BAR];
>> +	sdxi->dbs = pcim_iomap_table(pdev)[MMIO_DOORBELL_BAR];
>> +	if (!sdxi->ctrl_regs || !sdxi->dbs) {
>> +		sdxi_err(sdxi, "pcim_iomap_table failed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void sdxi_pci_unmap(struct sdxi_dev *sdxi)
>> +{
>> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +
>> +	pcim_iounmap(pdev, sdxi->ctrl_regs);
>> +	pcim_iounmap(pdev, sdxi->dbs);
>> +}
>> +
>> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
>> +{
>> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +	struct device *dev = &pdev->dev;
>> +	int dma_bits = 64;
>> +	int ret;
>> +
>> +	ret = pcim_enable_device(pdev);
>> +	if (ret) {
>> +		sdxi_err(sdxi, "pcim_enbale_device failed\n");
>> +		return ret;
>> +	}
>> +
>> +	pci_set_master(pdev);
>
> Does pci_set_master() need to come before dma_set_mask_and_coherent() 
> and sdxi_pci_map()?

Yes, I think so. I'll audit this code for conformance to the
initialization sequence described in Documentation/pci/pci.rst.

>
> If so; there should be an error handling path that does
> pci_clear_master().

Right.

>
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));
>> +	if (ret) {
>> +		sdxi_err(sdxi, "failed to set DMA mask & coherent bits\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = sdxi_pci_map(sdxi);
>> +	if (ret) {
>> +		sdxi_err(sdxi, "failed to map device IO resources\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void sdxi_pci_exit(struct sdxi_dev *sdxi)
>> +{
>> +	sdxi_pci_unmap(sdxi);
>
> I think you need a pci_clear_master() here.

OK, will fix.


