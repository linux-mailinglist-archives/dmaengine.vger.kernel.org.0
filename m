Return-Path: <dmaengine+bounces-10972-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN8hE902FmrrjAcAu9opvQ
	(envelope-from <dmaengine+bounces-10972-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 02:12:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC75DDE31
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 02:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C17E0305D6AD
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 00:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257542494D8;
	Wed, 27 May 2026 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bFQJZ9D+"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546F22A80D;
	Wed, 27 May 2026 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840495; cv=fail; b=eXspys5dZeoVZbqa1qNRKOtgPu3eOtKIimrLDAkOLIVnziaKKM5Ei0R1N9v5ruwLYrAI+A1okYiYXCbO2zqca17ZQPpMv5FifTtsaOGbKAPWqEbGAl6cGlzSW1Ead3/lk3VsvqJyxRk0jZ3j8nwGOFFJEMhcGE2MVnls7NBvG+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840495; c=relaxed/simple;
	bh=xAkmQM4vEPRTjJHmQhC0+STEUO7jufuPuYgHx/B62p4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVRju41R8stpnrKUat9IdtQFSzGlxfXVKwfHSr0eLsiFNr1ZMnya+7GPEabQPWAa2rNoW4jIcPBT0akTUX8vActrr3k8ilLTvz4/vDm1XHP4/UQP0DPPjDPRkU23Q2tOe8fIjqEwL5Y30LvX7V8lpfXk+HHFH1XuVntTXnAMFkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bFQJZ9D+; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvnJhlt0qblvhBg200I46N0xQwxD2v0R8Qzi5L1lIxgUE/UuSqqepZRSWbolNWCqCm//NaQMeCBuVJxQ2j4FthyO3t9x52odnX5bete225nYguWv3G+iLc5VzX1ltq8ncfAOwCXAilDeZqoLs3ii+OYZ2bkXFH77A3xugc1hHN5clVcglwlb6u85EJD5rzOSO14Os0aBIcuSyr5eFcGwE353zGQ0cvvENJV6/jiaNImXl6yuzhtNx+P2EDbOaMUpEHrWSvIxdP5VCzks1IXLI5wc03Ey4Pqpu4G8tS8XS/XmMDOQRrj4HYV1N5bZf8W+RJMTHVQy751ZPxVTFidwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5785gYNiNXKc4yZTEnKc/KUeIkEu1/HCMcfPzjKnhDw=;
 b=Smmzih13dZWqN7zztkT9Flcwu8uKn4WmDf8fYpxzxeNLPGDHbR3rewNFqIacoAgv0S5JBdWPtIT1t9BTYn+rSLj6HEV+Cs0ufua2h36lgERr/y0oQIiYlmuN7kyUufwTTy7vWnXWLyavwsg8oqxZvWKh5TVRp8pQIOh0JPPEyAjY/syNlahYr7Pwll7N4Gk2r8sGUAGCYsLTSeSNTpD24NoG/X/Nlbt4QkQlaVQGSysR9CYN9Rq6kLSt95gyPeu1R9zajiI62QHWEFIeZ/GDLwFxSvuZe3VPr6/0gJXVV6mqPKTwz7DECzUAIK44qId2GHKG18tpvJqBRWZWrwPGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5785gYNiNXKc4yZTEnKc/KUeIkEu1/HCMcfPzjKnhDw=;
 b=bFQJZ9D+DsyB1s4ayz225P3pKCxUHqLzFes3YhgoVuh4gaelNrqrrxD3TWm4Qz50iT/CE9N3NCPqqnQBCbnHMtRfz4u3jpSy95GwLJEJqPyx25fDwmyXglO9LWzjogOjN1NVPjivOK8t2901CjqS4+47VwDljggHXUAxchl9L9s=
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 00:08:04 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::84) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Wed, 27
 May 2026 00:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 00:08:03 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 19:08:03 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>, Nathan Lynch via B4 Relay
	<devnull+nathan.lynch.amd.com@kernel.org>
CC: <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 07/23] dmaengine: sdxi: Allocate administrative context
In-Reply-To: <20260513022009.22A3EC2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-7-889cfed17e3f@amd.com>
 <20260513022009.22A3EC2BCB0@smtp.kernel.org>
Date: Tue, 26 May 2026 19:07:57 -0500
Message-ID: <874ijt90ki.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bccc2d3-563d-437a-957d-08debb840567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|6133799003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BaK8UhjFkXDvN9xyraX7TKFwsZa1JWwtvVoFv4dpqIVtsgAe6BN+qznpg4T33xPnecG/Ou3bmPXXBNFQDcpzHFfIkxG3KbR4i1rB6bWDuRdmGAILPf9uLYMCauXjE0o9Czh8W/nko9j9AWafsPYuAs2mIxNd5+TysTrlstyWXd8+JXYHk9uavzg7rcoUdP7AZ9EdjCf2MVf/FKtZ+j32k5iIhAI9jHkTrzrVyxAYCUkn0pJfT/kzJ7PD58kIs8Wn8fQz7gI0OWO9InKIMmSfY8bSkrBXPVj+RUgEFvFWnEHrqmFm15Z71eCvg/Y/bH640Fzk41p3vxdZ1vHqKXO1oyo7GHjlWWVrSZpXEkfTMJiYryKm8CNyL8i+k0MI55n3MABK6AWRMYiVhHVgQSsVc9YVl0bKilmXN0onCJx8dXOGzAoUMu3362f5qsRRNajxQM0YzPElLz8ZxV4RPtTOzO7tDaFcr3xyzhMcynilAwc3IPPOF2k4M8f4n1v55+9C1445Y7oKSeIolVtQlzXlk6DGVx4Vmi64yydeuYHL6nrNELyiVv5UFXVi9LLOGvG26qHkRFtdKH/6iVFpbnDqNIyCe+gGJUI23hcxxRrTDpCLB9WDxV4CkB57zCvyjLbEez+0ikMz08N+G59xe6rMD4nZcHr5d1RTUpaMQrOlTzw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PRa/6NkCu7iMS/zAZxJTSVYs2laDNCvrZbcFWGPcAvLWuHO1wTowkRIPhy+wU7qqKN+IYoW6tTsABhkKb9A5Euq78gi2jP0zY25oRaYQmhFzO05Z7gKv5blFyeFGM99bnChKVLj2kzMOx7Mcw0ZGkZzR7i2cLIIobre/0W4/uWaeuEwvLuDiawU0FFO7VzWn1Kznh86ZGkRx9Awj5HSvE6GZS8jJVozlRKrSHZduSR2woKPt5XxsH+5ZhxWvNjZU/CNFT3rWzx8ezz1B4P2sGrO8JQ6cyuc+Y6A6tO04yjpuGQtBFTtzYTjC7ajfEVTwu72SLr2TW0oOdmf/x6dSPeTP3RUStlxaaf/XPDRT/UQbVe3pBe4atAOCcgDg4WC38OB+0yNY1LuvniOnnah+73tkpmCJ+VgnlndYnS4EwJYOVHUWVWh7bB7gY+HRK4Fz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 00:08:03.3286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bccc2d3-563d-437a-957d-08debb840567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10972-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D0EC75DDE31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Incorrect error check for `dma_pool_zalloc()` allocation using t=
he DMA handle instead of the virtual address.
> --
>
> commit 67ceee55512586a3fbe30b9f642ed7c90819e736
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: Allocate administrative context
>
> This commit creates the control structure hierarchy in memory for the
> per-function administrative context. It uses devres to queue the cleanup
> since the admin context is a device-scope resource.
>
>> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
>> new file mode 100644
>> index 0000000000000..27821cfaf0311
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/context.c
>
> [ ... ]
>
>> +/* Allocate a context and its control structure hierarchy in memory. */
>> +static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>> +{
>
> [ ... ]
>
>> +	cxt->cxt_ctl =3D dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
>> +				       &cxt->cxt_ctl_dma);
>> +	if (!cxt->cxt_ctl_dma)
>> +		return NULL;
>
> Could this incorrectly treat a valid allocation as a failure?
>
> A DMA handle of 0 is a valid DMA address on many hardware platforms and
> IOMMU configurations. If dma_pool_zalloc() succeeds and returns a DMA
> address of 0, checking the DMA handle might falsely trigger this error
> path and return NULL.
>
> Should this check the returned virtual address (!cxt->cxt_ctl) instead,
> similar to how the subsequent cxt_sts and write_index allocations are
> validated?

Yes, this is a legit bug likely caused by a code completion error on my
part.

>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-bas=
e-v2-0-889cfed17e3f@amd.com?part=3D7

