Return-Path: <dmaengine+bounces-4904-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4FA90766
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67A3189D03C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42B203704;
	Wed, 16 Apr 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jz137fVa"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AB1A4F21;
	Wed, 16 Apr 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816247; cv=fail; b=Qsv6qzz+L4NsgN8uscR5Kw/5AVLzVaZ9YgMooETs8IbdHM2TPb8zRbhxW+CptInvH6z3DgY+At+vCiyx0Pp60tIUPeMWRCCOdKPnbba968SZ14fhkCvKBIGPMrw/btXPzPQndbjd6WIRHtXTjUm4ctblPe7HzsaWQgnunUptMqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816247; c=relaxed/simple;
	bh=4vfuN1PmFNSCIOmT2fFxmUdoue8sq1y9/mUlWHLLukc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8cF+LkCLrqGzqpOJj+8nqRJxlDVXmEblK63jjq273S4ufHVtVjbQqHXf8FXOXpdHLHxg6w9McZ7jOu4U9hEUEi+EEXnnO1SlIIq6XxN/dO/UBIiCaoar8QvZNhvG837EbdKgmB7NkYygfSk1z66avohW3K+EKpWVzcvV0O5X18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jz137fVa; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phttslX22AHuWCQ1dM0SeCSRTabhP0DqTypZdfZ4FODjc03FfNRKrTmVZ4eYtC+G3MUMAVNMoKNaOyZQMnqz6htX28op0rVIFFQxFY8ZL9IuZs3PiD0DK2Q3hJKV4WzjBfhiD6pr4axQ3N5MOR1cO1YFXlTP2X+olD8iEQYRB641blfdfN0MgYJb5yjCDcH7f8KcUnWVjwoqzUibSQPh59YZzVuvewbV9At8+q/qNDMlf9/abdP/jMYsIXNY//6aFS65T6QzBcjKhftR5IDTAnpvSEnrKe+WqVIv9AmpSpOCofcK3QPZ7cFSOZ6zf+FYN7zBXe/nkcwnCxyXK7LlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwEXUIcd0Dq7dV6oAx/vf0P/X9MyrIV3q6fozcBfGk8=;
 b=CTP7/+1U5OKI6b1CkluCS4WYkgYJkBbGZIvQj63IvxTNGlyvGbye6yfuqRqBrB3Y4i/2uWZHW+aaZx9a4zw8hPicKErU+T1lvIwQS9L1FlHnJ6t/jhAoU5Gjcc7r0vUchLkMnFJvccINVELWR1M+MUmW5q1RogESw70SkJHWVbUl6lSVI9fyQuP87V7lpqfSYhhEme16WaaqP04TfJzsw4Rjh3CuEB+jdTInugRWlwDIAegdXpKCDqrrhRFwcHxEInGoLNocDKB3sAaIWGdee+Kfz2bBeLm90sVVNNCvonSxs0wwdFxNnOuHsbEQeV+xkUC0zeDnuFtG8PqK+YmIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwEXUIcd0Dq7dV6oAx/vf0P/X9MyrIV3q6fozcBfGk8=;
 b=jz137fVaAwdFMvPMEVDPurs/UBQDejVWgrw2R6/AowwsBiWTDNpU5XHLnU3pjmh8g2t1dBhN6MeXZTT5HqdBDnh0Y4jmosmr/w/ctf7nZDIIO0sPhWJwDAuAX8a6oio0JfU19p9ImA9cOUSc2XD1lfEKUD2SgYO2vr4i2HlSKF4=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 15:10:41 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::7f) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 15:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 15:10:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 10:10:38 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Arjan van de Ven
	<arjan@linux.intel.com>, Nikhil Rao <nikhil.rao@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: idxd: Fix allowing write() from different
 address spaces
In-Reply-To: <20250416025201.15753-1-vinicius.gomes@intel.com>
References: <20250416025201.15753-1-vinicius.gomes@intel.com>
Date: Wed, 16 Apr 2025 10:10:32 -0500
Message-ID: <87mscgkuqf.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dae6806-5d1e-4958-0fb1-08dd7cf8da2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IMSyZoYt3pZx5lsgp3uFcNYGbTMtoi9lvDxCvpHjHE1Pn65nOULUauojp3X6?=
 =?us-ascii?Q?/DURE/6aOb8gSjRiDwZ8BTlDBrFtJfV2jtzEzInNCSf3KHlBLSs0oCdoUm6P?=
 =?us-ascii?Q?R26ToHnfdYEg45HJtmXPD+eT7CE3AE73J/WoKlDOsUYLPOLgriAsfVZ25/e1?=
 =?us-ascii?Q?UuhgvUvIyww6e5c7xhktOHw3UNibVcTCURwpxpIw0kKdI+uxEA3LPtRX9BSP?=
 =?us-ascii?Q?ixRj7JLCAk8v+dUPRQhJntVJDKprBwrrLPW4b+sz8+8BY5PZF/zHl/oStg2n?=
 =?us-ascii?Q?ul47JUbE89wkb1RMiQJlcJYq3rYP73efBjeoD0EnoCc2X4t/ISbkWFxgG71l?=
 =?us-ascii?Q?GjuHLIluXWKshifDS0BnDcrPkzLsq6D8hvfsAb9vATqYU9EjiDBCfSpPbhqr?=
 =?us-ascii?Q?myIuZWzizFU/6UUGd9QYECpqIQRjJiD5VcPeuWuCkrMIodqeCmkRGwMhqIrJ?=
 =?us-ascii?Q?3GKWZE16rC7IZ4Pyo0erI1So0D2abIgMmlnuIe2x9NbVlcEM/xvJPdDfmrzp?=
 =?us-ascii?Q?V86Y88tNut8zmGiNGhNilrNXzeeD5tkOxC/pqTHwrv0F8io+ubKyoEKE3EDx?=
 =?us-ascii?Q?iA2+TRyh6IU+oRkJIQyWUIWuQ2iDQhBXr9t8Afr20WhzD7viebWYZhgyljel?=
 =?us-ascii?Q?KzmdbiGFnsJf3MkTDc8lTDPMinHenI3UohwbQFBSQqF2bJkAmBn5nQ9qhfZz?=
 =?us-ascii?Q?iNs+lGE3BxLkYXy2dYVRHlQwi6G+TLDZRMBCCzXYY+dmxG4Ibz+LcRMFZ2no?=
 =?us-ascii?Q?Kgvn3riziH8zkjLPXDgVnImrTA3lEUTAk8snxnwVSuYa/UIgrTHgJ2DKy38d?=
 =?us-ascii?Q?mDUt86pIi5z6IZOJ0n//vKsuCL/P63DIyhoplRMCSYCBdMlNk99MACsPPOGT?=
 =?us-ascii?Q?z6Cp5VKDwkgbi4+qA25GytzCfOkGJnTpKcrZFOPLzdZ0iSh6Aqw/eFQ3n6yR?=
 =?us-ascii?Q?Uv2u9A4y1Uw4y77KDk+85kZBLDsJ6hy25Heij9qcUBaAxHBEEn3A7CSk8QpL?=
 =?us-ascii?Q?JlzIZyayPt7Z6fy4880akHmsIVjeRmfUCmGpe/S9Vys68ji1FrHnJVdE0ZNE?=
 =?us-ascii?Q?7xYm5ueSDjxCeKieAQ03aB+AVTMuDN3t8ikgu+S5TrviYbipt8HwhTDcQKQ2?=
 =?us-ascii?Q?l36s3kK11ZADdxhzhGeygpaihWr5tQFJVYJhpwF+TKpaomhvemMG5IK4byoe?=
 =?us-ascii?Q?rhTz6PziQpdxDBpBKRTOAELtl7fbxKJkI84avbG8GTgNCq8Y8gzMQkC6k/mi?=
 =?us-ascii?Q?4PLQe5Ig7OeOX+mXk8ZjkcVLuItrAF6YRkiOvJwfWQILXd3zwgQT1DT23whp?=
 =?us-ascii?Q?IXoX3s7+Ks6cWWdzaHXVZr2nkU+bxoGT8q3n4fq8h7snvt5AkOZuasgVC2YE?=
 =?us-ascii?Q?hngS1yIStP92i1IFPaz5S/PA4jpn3AkA5019itDLW4MuU6zjfcAe0EHkgDTr?=
 =?us-ascii?Q?Pj+JbeXs3cX0Mg9+54Z4VntP2/Osh1XoOc+sABT10NDRkHxJzikVDzZumD+j?=
 =?us-ascii?Q?Go7XHZcK97NBxqqDKZ8/l5CXMT6nG91mXFnq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 15:10:40.8840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dae6806-5d1e-4958-0fb1-08dd7cf8da2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Check if the process submitting the descriptor belongs to the same
> address space as the one that opened the file, reject otherwise.

I assume this can happen after a fork.

Do idxd_cdev_mmap() and idxd_cdev_poll() need similar protection?

>
> Fixes: 6827738dc684 ("dmaengine: idxd: add a write() method for applications to submit work")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/dma/idxd/cdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ff94ee892339..373c622fcddc 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -473,6 +473,9 @@ static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t
>  	ssize_t written = 0;
>  	int i;
>  
> +	if (current->mm != ctx->mm)
> +		return -EPERM;
> +
>  	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
>  		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
>  
> -- 
> 2.49.0

