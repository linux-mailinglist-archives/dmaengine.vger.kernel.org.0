Return-Path: <dmaengine+bounces-4921-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D1A92C76
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 23:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672A14654BC
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 21:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953331B6D08;
	Thu, 17 Apr 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkn/Ki01"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D241C63;
	Thu, 17 Apr 2025 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744923756; cv=fail; b=u5wKxM19t9q7RWrSnCzmU/UCHDsCdWTbyo9+7cfDkytENwVy2MyOP66GhuUiVx0wLXHEUTglrFduytcWzXu4k20gBoq9wzXK4bD5TrfdgiiaoU2tjZvWiv4M0z4Af1/UUcRR2d9lLBf6Fvu8KWLagSBkjJGRsRXX9cvAzqxgQF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744923756; c=relaxed/simple;
	bh=xRF8ZTvfrbDMDcP8Hl9jDqJ1Vku5Ctkt3ugJnXkeqoQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kK43EVGPKoheQnq2Ibs7sW+R6TMTOl7Qi2hd+R3dI11vp0nGQFRrnvzoWbIonjAi3+goEfsrtw7O8K3opQFSIX7tZYpptMQWQL+YMhvY0HJlvCYHa9DlXUDXuwuebMlCh2nZXIVcAbPOUj79QUHPqsol0ZmOuPltXOR1VLjvBvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkn/Ki01; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C110KRL9wu/CsGgt1ZlvdWZqPTwbbZmbxNnKHRi0C6f1vwSpynEXy1poaOoG6rBQ/iKMkEwQtYYCxfaU/jslPIZfMVHgS2PlqDWnSoJlI23+yQct0+MvzvInqBd8n/mxVZi/jqT17Nkh+FS79FXN94yNPGScNJQ92fJMZxoQXN2fd9hii0BTYyjLvlTNFWiOq/tU3i6UQvV92Q8W9rMdNR21yTxp+KZu3MEHdbRZjTSy63E+FQrvgH+ijCRJfOLGMXcFpEgH3y2gQnuxg11VvnreXbIhBRegpCk81FTnpatwOWN5eLQMFBbjWob1+UQtBMOWL/adD4R41WQRbimsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdaH9sIZsoYvT7ITArsmuIHBNm6OdMF8Py35Q48Vwdk=;
 b=G0t4Fdtli4zZpIB0WDMS+cAULGaMwxcH9VHBAtTtlsiQGtYNkYahzIY9rVawgQeSAeVCG8D77S/dfL4VRd89B5Q9N/Mor+SUY8h3e1RoOU5dX7ISwBUGlEe/0I4TXRgn9uGUH6U1pSMo1hmEuIo+Qnmjh4y0N3nHtbhWTWzYyZwy27umRBPKVo94iFfrMAkbwSlCB0RmiixzNScFj+YoNS8P8Kt1vA1r6gVBSsOrZjmP4Sh7TixU5TH5ybhyaglg/O33/POw7eHo6RI1c5OHEgOBKq81JwYXzkuz7sy54d+7JihDS0LN3Szv24ejOy9gw9rIRI4BGJD/y2SzU2hM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdaH9sIZsoYvT7ITArsmuIHBNm6OdMF8Py35Q48Vwdk=;
 b=wkn/Ki01UTgrZf1N7j0UJ7Fnza2DH1NIJdQ+46tAT6UBhcI4DEB43xlEEdkgu1I2Ux9hj0tSDhpZEmpPkrfNP1wwjOcL/VkUSC6Rp1lYBx+zRvocANLO8HtUFZVAh180cHxFfI/+IUAJfBVWLfmmhcE1egp4GN5hVAU6PNNRN/g=
Received: from PH8P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::26)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:02:30 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::e9) by PH8P221CA0047.outlook.office365.com
 (2603:10b6:510:346::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 21:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:02:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:02:29 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Eder Zulian <ezulian@redhat.com>, <Basavaraj.Natikar@amd.com>,
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jsnitsel@redhat.com>, <ddutile@redhat.com>, Eder Zulian
	<ezulian@redhat.com>
Subject: Re: [PATCH RFC 1/1] dmaengine: ptdma: use SLAB_TYPESAFE_BY_RCU for
 the DMA descriptor slab
In-Reply-To: <20250411194148.247361-2-ezulian@redhat.com>
References: <20250411194148.247361-1-ezulian@redhat.com>
 <20250411194148.247361-2-ezulian@redhat.com>
Date: Thu, 17 Apr 2025 16:02:23 -0500
Message-ID: <87ikn2lcww.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8895bd-4c25-458c-1232-08dd7df32ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2L//a7penKciMWg426D1MDPLCaV8YQ4bIES0ZxYZwWZQGn5RMkVJXT5FjeZR?=
 =?us-ascii?Q?GtPDbddPycFZ/Ye9bcK//XGcCj5Pv4ochXzLqa8ylK0j46yJvM4yCTDUuMRq?=
 =?us-ascii?Q?QfMydRN0gpv27Ogf+sQK8xAFieaoAA+vDGbi/tP4uRRVxDzXnJo1Zw9ASNOr?=
 =?us-ascii?Q?A5WipefORYGwkvbGENISBqubzAMjHVpoPN3zWQlFl4NB7/6PLt4/W7mBOuAy?=
 =?us-ascii?Q?1oJtO/42gSEcQuCVs1vVDce4YzIt1SYYw54hOF/fn9P63ycdnMCyHsyyCrX/?=
 =?us-ascii?Q?OJPvLhKnGnhPfyPY1vm5FP/2pyLYT+S6hhubU5nts/1fr4WBjqsCr6hsxvKh?=
 =?us-ascii?Q?7EUTyG4pkZ7jjxTZMXipk0de24YvD/AQH7YB0YrGzvE2cuR/fYbZlSA5tHv0?=
 =?us-ascii?Q?bzdarnltcnkGqADNlhplSM36tuH0GmTMzkQQlageSN+qBD6ViGxNl8V0KHUG?=
 =?us-ascii?Q?wZXd9FHQbGKDCAVccJlQdbA+fLk+ENLwHpm6ccdfGm1bLFnUwoKjb5khEyDN?=
 =?us-ascii?Q?CgsXykFs8vjLOZCgSMQw7eb6Nx4s+UWyGf4uxf+odudW/jzHRRLCvFD21gtc?=
 =?us-ascii?Q?qAMG9qbTa9bZ+YvEkDjOz58/3e2nKYHqjpA6JXLNti2LMdkyzXdDJv1WZauV?=
 =?us-ascii?Q?DW5TBhQVZlXceM52fFl7hD5W0agGjWDW7aUeAH0VjOnJQeYCj7Mm14u5cTCJ?=
 =?us-ascii?Q?GfZash4Tg2rpnvpOX6Mtp7JDS80pSylSv9uGLE5naqgqz5zjwvnfrQL0XrLL?=
 =?us-ascii?Q?NFIXZA2NgRzAGitfnR6n4wLxPecolE2FzsxWQ9RFh25J8BZVsu6K8WBC1QMc?=
 =?us-ascii?Q?FhIcRp+J/bLbYJfeD02YQNrRsyXquMiPIvaQI+sWYN7+/2sD5ipoN0G9TuPW?=
 =?us-ascii?Q?KbzA0U+DF00kzohZ3b3DcUpihP6ujMRyGZ/fZFVdxcBJ024UajmSWn7T1GNd?=
 =?us-ascii?Q?eonBM4fAbxPX84bjd9VZ+WFg50W/CV07zScK1bsE8to89/oW2fxqIfvZuaR0?=
 =?us-ascii?Q?PS3IB9iTQ4/rn9VpCw4TNDbi9u5nm0yVFp+oVR5mJBioqE24Z8NpRgP8M4jE?=
 =?us-ascii?Q?USc9IZSjDRNm2o+24Ca2CrG7ntErYd/8bUu8nHp2pY091SnIK4BA82bJuFMA?=
 =?us-ascii?Q?d6dqg6S5MWiMhwpqMsFTx3CcoH+7uNKlxjt7dNCXbZBC1aLNcF5fF6QIkoVI?=
 =?us-ascii?Q?5cqoKhv1mkbgPaAkbExwkiEE/aW0Z4H5ErJht3+cEbs6zR1Lh59QQKBvYA0M?=
 =?us-ascii?Q?OXaF0TW8lcX3WmFur3K1l/uPxXUsLNnHsLI7XkaRoCkHbhzbpAJUhNFLXrey?=
 =?us-ascii?Q?Ca5Ki9TS1WJgLlQDHJmgGUbxZhhg9bSdkl45YA+MvKbcVAp3kEUo+/qag513?=
 =?us-ascii?Q?U/fGuL9B6qCRezmEjm85zX9ecy8yK3Mc6UQDk3FaQsu2xI3Rg6IAlfvNpKvz?=
 =?us-ascii?Q?NgO7WXlwKdkthITe9bQYX5MXy1RcFNF2/6lHY7mIosSqdAaUT6ST1y0ZD1a5?=
 =?us-ascii?Q?/ujC2trHObT5odkm5nppH4e1m5aD3bFfD7dJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:02:30.4072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8895bd-4c25-458c-1232-08dd7df32ad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Eder Zulian <ezulian@redhat.com> writes:
> The SLAB_TYPESAFE_BY_RCU flag prevents a change of type for objects
> allocated from the slab cache (although the memory may be reallocated to
> a completetly different object of the same type.) Moreover, when the
> last reference to an object is dropped the finalization code must not
> run until all __rcu pointers referencing the object have been updated,
> and then a grace period has passed.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..b70dd1b0b9fb 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -597,7 +597,8 @@ int pt_dmaengine_register(struct pt_device *pt)
>  
>  	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
>  					       sizeof(struct pt_dma_desc), 0,
> -					       SLAB_HWCACHE_ALIGN, NULL);
> +					       SLAB_HWCACHE_ALIGN |
> +					       SLAB_TYPESAFE_BY_RCU, NULL);

No, this code wasn't written to exploit SLAB_TYPESAFE_BY_RCU and this
change can only obscure the problem. There's likely a data race in the
driver.

I suspect pt_cmd_callback_work() has a bug:

        spin_lock_irqsave(&chan->vc.lock, flags);
        if (desc) {
                if (desc->status != DMA_COMPLETE) {
                        if (desc->status != DMA_ERROR)
                                desc->status = DMA_COMPLETE;

                        dma_cookie_complete(tx_desc);
                        dma_descriptor_unmap(tx_desc);
                } else {
                        tx_desc = NULL;
                }
        }
        spin_unlock_irqrestore(&chan->vc.lock, flags);

        if (tx_desc) {
                dmaengine_desc_get_callback_invoke(tx_desc, NULL);
                dma_run_dependencies(tx_desc);
>>>>            list_del(&desc->vd.node); <<< must be done under vc.lock
                vchan_vdesc_fini(vd);
        }

But that's relatively new code that may not be in the kernel you're
running.

