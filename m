Return-Path: <dmaengine+bounces-6586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6FB5A3D1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 23:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB931BC8467
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD4296BDE;
	Tue, 16 Sep 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ndmyF+qn"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE42582;
	Tue, 16 Sep 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057821; cv=fail; b=NE8LcPmGvUsGcp4sBn2giUH20J/idgXJPMDeT26vgnKUOSXKr5keWqa9YWyL393Sm/VPDI2Vo+t5GcHozMxuThCHDZMW04fa0kUXNiveXFK8DHPuw4I17kgo9Vjhy2PHpboKrcBN4b6xgsGzfp1Q8+KuqzIXXrAiYa/pl7FHTz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057821; c=relaxed/simple;
	bh=bme/BIQ+ERSLWMRr9m2wRIQik7VMJC596tVTKSkGcxw=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ha1Fp9ZiZCEPepO4QU31EbwmWKhB3bcQITFsQa6+kVc8Ru1oMY1xwrq71XeW3U5M1HTZIQCU4Bf8cNY5ExXLDuPmOJh/XVWIm1yGYcAOe4qotGW11aQgZtgIWl8tzsRxTNQ/y3TOwKlOz2dIaesAnLiPJIF19BgXTbjnIqz9gms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ndmyF+qn; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCI3uylqQkEkngSVL+falLlhRYoR0t7eiotfqIyDbP/y6j0TOhI0AKM88kdteTRdEhd/fhR591TG2BLUPS909tKibyttvgEDdbv12H3BZKaGZRG36nsAwuAnv5fV6OyzvXfI5zkrn0ffNgNiquDdS+hQiGsEZv2p5uDsBrfg0oFqq1vRUtgkWKH6r6d4cp93R+zT0OwsWSWmam3bnXPSZaydbGdhz78yRWeyUmBiocGrljLHw2ahb4dSqUkxtuWcESPPqEvgMG6NYVVTQ9viUIhrEs5JvxeVbZaWDxmCou3dBIe0mOvn54L+OCTRLPiA1mH8JaW9HMH8AMTnwH3X+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxkUMB+cxkAwR/lVny6R0/u+5bSXhcB48HCofQ3EJAk=;
 b=fq9imV+fMRD2khj4onAu4MePA8QlKYNEPs9rLZ/kb6aP15qLsdyxBGsymVPo0+eKszhb55eHY7alMnhQDzK/gDNH31PgEa+SLKpi6EwmusxliqfGQkkz3TCd9xo1vcHWp0FWTwCjJ5BFHCvyzUXR6CiRZlGQkORWzwBWnqCtoz0B7iGpOKjpWJqqpHmdavZDaSx77VAM6KZyPiWaTGW42dNrHHpkncEouqfL3of4b0zF3+3nOfh/GW3B03HA4NeosTKHk2mToApXoi8uMfsskihoirgzoEMeNmMwBBMGVjXR+nL+R1DJdbLCO5uYf5pu7Uv5u8euJpEOX0jtGpSahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxkUMB+cxkAwR/lVny6R0/u+5bSXhcB48HCofQ3EJAk=;
 b=ndmyF+qnvwf3cp7MLcd7f0As/JSeDtDrUnpzGd6JelMQp9fWhBAM1Al4A7NNJfEZJQ4GjfLvYDzWcVW43TQHSY7tnhyQMi8b9VXvCCwbh3n8gTq+7xLP8FUjrmqB+2t+yuLQq/HdRXC31fikVRgg1qR9M2Ie89SQ3eOlvo5vbMw=
Received: from CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 21:23:36 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::2c) by CH2PR14CA0031.outlook.office365.com
 (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 21:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 21:23:35 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 14:23:34 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 09/13] dmaengine: sdxi: Add core device management code
In-Reply-To: <20250915152331.0000246a@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-9-d0341a1292ba@amd.com>
 <20250915152331.0000246a@huawei.com>
Date: Tue, 16 Sep 2025 16:23:33 -0500
Message-ID: <877bxyxfai.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: add49c3b-f86f-4b03-44f2-08ddf5674ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wO+lV/iSz0jkX0ekW827hR01BcmVRr9ZphB/3ckoP6TSxnEnAGIujIsh6ZRi?=
 =?us-ascii?Q?g0U35UAAw6DGA7QDIWwyluiPEA7ChC4BzAi+x+fiV9cNnNh+IW+rlsfXW70m?=
 =?us-ascii?Q?L7HqPydzBfawBt7rIc8Fi4ocAJBkLDC529nNwVcLfqCFkoOVkhltReAwLABC?=
 =?us-ascii?Q?GnGYC7errMgpYvn9TP2IbBCfe826p7fxcT9TkuCQz4/8mFmksPx14Ygt1ye5?=
 =?us-ascii?Q?Nymt/bJCk6xiU0UA2Lw7YiToqlm2zZnYixFAFp6yh/yIlgcDHxopexWKYZzW?=
 =?us-ascii?Q?+jjSi/fXvbguA4fikekDirGXf8KIDdL4hYy79AQWs2AKHkEmCyk2mrnD1fui?=
 =?us-ascii?Q?SrPTUnXEnqUq/BpMCR2kyXX9hIxTrvRT4R5jVSVTQA2LClg6PG3r9/5uyvkz?=
 =?us-ascii?Q?r9Pwz1wO+aeskcmuzxMQ8E8Z2BnGzrIHq+Mx6qriAh+c6F8UBfmpRhD68Gxs?=
 =?us-ascii?Q?CNctZhB7+sCXAFNic2D4RfFSXOf42G/tEwHh1dc0sYe1nH/tJH4DvMzwSh/6?=
 =?us-ascii?Q?Jn9dlTxSXi649zBZBd4+0E9v10ssGyQ4g83xvRuqNFAPBLNxixx4GXAbFWCO?=
 =?us-ascii?Q?7329vSpgV5xbfssxtZLmV5sDkGIpeN5jY6qFE3Rrg8NX/Wy0cMBywcVobabt?=
 =?us-ascii?Q?7iF44V2A8wtRPbhvVzq5CTiZCHS7b8NUpjrGcNejAKZ1rcx2v7eMuSX8bMvT?=
 =?us-ascii?Q?I8wEw2DKQ0A5Kr5ylf2Mch8Hu2rVR6i8lqSAjZU4Tv2kRJp9nm0fi/vIl4pF?=
 =?us-ascii?Q?CSjI9QmQ33Q6m/fg3nLIepq+xh55DtgXiDJOTm+3jC6grpdMZt18ChrrwGm0?=
 =?us-ascii?Q?VEi0uRP3LKMD4C782BhIiTY00xSVaKRDMw3jGb52lx0bdWgdmp7frjaG27VL?=
 =?us-ascii?Q?vgMyC+bpCM49eMBQzAQcCSHE+eGlsvLVAA+KEXrtRPWPFkrcssbISUnHFJoc?=
 =?us-ascii?Q?NERJfBylhCOoPs/KGogeZuVgAgkCgfRROS3YyDs+y6YZxw8d4BHjdx5UkE+C?=
 =?us-ascii?Q?v29hiGPeMgyDtAyGEgaXu0ZqxISpoZYf4nHO9npqE8gd8S83q9dn6veq6LZw?=
 =?us-ascii?Q?0akSi958pCzGtiolmABooibowfcbZFb4uC71afefQmpV0RwAddSER5JA3/MJ?=
 =?us-ascii?Q?xY2lm7Q67Hy0bZaxKOzTc6wDc8I/T/Q1/KIxqIdf2J48lCNvushxeZgYWFzs?=
 =?us-ascii?Q?DttJDBZNJWBZGvu3g0I2gD+pZ0jxzfeWkfYWGDpOl2fL0ruPyRfHQjlsB+lU?=
 =?us-ascii?Q?UQsY8pD4289FvkHD1VqHFHEqqJuJ2D1ff/M+AnCqQg85cVzJyJO0x6IEMfTw?=
 =?us-ascii?Q?OZn8GqPHRM3iw+QmCM5JQ/0wlItg+8OikS2uEKerT8E2fTKp8ZxCZRCFYXmI?=
 =?us-ascii?Q?8t+4qgbaVczFJoLe+Oed9id8dUJ2yIdLfrtvu52eLxi2fQ4DdBWntkVMOjOy?=
 =?us-ascii?Q?svlnOWiAiYA2Z/c7/Bd2yBeyc4cmC/nQZVXMNRuhp5hrOHhano7oPaKIvvKz?=
 =?us-ascii?Q?SNErGlwoMNWUm5EkNqNm/ayhnjzTXB3il8KA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:23:35.5304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add49c3b-f86f-4b03-44f2-08ddf5674ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> On Fri, 05 Sep 2025 13:48:32 -0500
> Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:
>
>> From: Nathan Lynch <nathan.lynch@amd.com>
>> 
>> Add code that manages device initialization and exit and provides
>> entry points for the PCI driver code to come.
>
> I'd prefer a patch series that started with the PCI device and built up
> functionality for the stuff found earlier + in this patch on top of it.
> Doing that allows each patch to be fully tested and reviewed on it's
> own.

Right, I think you made this point elsewhere too -- I'll try organizing
the series as you suggest.


>> +/* Refer to "Activation of the SDXI Function by Software". */
>> +static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>> +{
>> +	const struct sdxi_dev_ops *ops = sdxi->dev_ops;
>> +	u64 cxt_l2;
>> +	u64 cap0;
>> +	u64 cap1;
>> +	u64 ctl2;
>
> Combine these u64 declarations on one line.

Sure.


>> +void sdxi_device_exit(struct sdxi_dev *sdxi)
>> +{
>> +	sdxi_working_cxt_exit(sdxi->dma_cxt);
>> +
>> +	/* Walk sdxi->cxt_array freeing any allocated rows. */
>> +	for (size_t i = 0; i < L2_TABLE_ENTRIES; ++i) {
>> +		if (!sdxi->cxt_array[i])
>> +			continue;
>> +		/* When a context is released its entry in the table should be NULL. */
>> +		for (size_t j = 0; j < L1_TABLE_ENTRIES; ++j) {
>> +			struct sdxi_cxt *cxt = sdxi->cxt_array[i][j];
>> +
>> +			if (!cxt)
>> +				continue;
>> +			if (cxt->id != 0)  /* admin context shutdown is last */
>> +				sdxi_working_cxt_exit(cxt);
>> +			sdxi->cxt_array[i][j] = NULL;
>> +		}
>> +		if (i != 0)  /* another special case for admin cxt */
>> +			kfree(sdxi->cxt_array[i]);
>> +	}
>> +
>> +	sdxi_working_cxt_exit(sdxi->admin_cxt);
>> +	kfree(sdxi->cxt_array[0]);  /* ugh */
>
> The constraints here need to be described a little more clearly.

Heh, I think I was tired of finding and fixing memory leaks when I wrote
these comments. If this part of the code survives to the next version
I'll improve them, but I plan to rework how we track contexts using a
per-device xarray, so this code should become a single xa_for_each()
loop followed by the admin context cleanup.

