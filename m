Return-Path: <dmaengine+bounces-10030-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD0pHX3L5WlIoAEAu9opvQ
	(envelope-from <dmaengine+bounces-10030-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:45:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D845D42763D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A30B3307B407
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 06:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF2390CA2;
	Mon, 20 Apr 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RTOAnkGn"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7439150B;
	Mon, 20 Apr 2026 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667032; cv=fail; b=INMpYZYTDCO4LlXtW7eGbpwVdW3DT0NaRQmeLg80CHpAGY1LAsRFjPQdCOGH2wprCIGKZaGO/OH7uUSJVR9JN/CYvw9SprMiS3kmIgx0AZMi9bSg5mPyYH+KfbqT6EMXOfqoZbTYFxAWFHoDtEK1rrf+fb7UUpWjttomapo4hyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667032; c=relaxed/simple;
	bh=D75vPN705TWZ2mdGNkWC/N2Ab3CwL4StUWr+92eSL8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DU/UrgU/IgNgvlXy9PV1mGGBhJBOOxVNqSEYUzzszzvPRl9wmmqovNvV6u252XFPUfToNbS8gBvWdaHEjyqmvJpylQ74MAytaLPMxeIOlllLhctnOVTCoRS1yUor8N+jB3eO30CSxN4IRjfph8pHYZIkwj6u1SN9HV5OUKd+FCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RTOAnkGn; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD5rGWJk8H6rwW/YyJOWn9JU2ZZVnwD7p+eWS1t2aEjZRiBktunjOiUSDtlbPrMkyoacbyAfuP6df3tmfC9wpSRsHQE6em0k0j2dpJnqJiK+Er6uXXvfz8hUF3vuIEA0zvcA++uM1LB8cgSUDh8OuxUzK5uEWPVjIPnFBAev6OTdkx8ONitXp6gihXDwyNQAYc4WQ3o4zAfkVe2kafqXhla64e3gUIbPbA9+BBDAwGl+SzXV82lOEYYy6oLtYA3j0JSnzhQQjppm1tbCViEKXEJwZLVk0xXGuwk4HbU4qbsIvwBhZvcuFKjZkaof7GMBMljNNH0WNpHXloreCkvPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbakunPtCCOq2t8KJRph6dxZkm1DlBomwSiFcE6m0kg=;
 b=qtaE0Xv9emOwul2/YfZx4PVp1s/9LlUGeinNYfFiJEAkgOoC+sMJUQ9CjmDcneoXx85tMHKoE3S3tx1dZPzHvWSgqC5tHIegPqBZOPzjuxIn0SQWHO3bsjYwxCSQvM43FnRHONdX73sar6zLThOW2Qs/uXlCnD8vwZ2zEC6V+oJ+fM8sxc0qwejjwqYo22LKtUNumBFDdr/w6ZfNlJuyapqAIS+kKYa7yWr4deGj0kEQlUW9mfzMCPGSP18obF2iluXpIFmDX8JP8EcxlrWU9swUW/vfpM3ccBrf6EXiESdlbr6REGSJgkd1mQhf8RnSFa1FiVS07xIPKrZivh10Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbakunPtCCOq2t8KJRph6dxZkm1DlBomwSiFcE6m0kg=;
 b=RTOAnkGna9cHyR+nCVE2FbHQlK+/bgWCbh/UmStK77wTZp3MuI+erlFWjLRhLfkpXU7g2x/md4A3ps2XjHDEKXx0x3Vj6OkIFSJpt0N0wJLFh6DgfdMUqHIaHTxbTdz0UNi2Z58f8EZfX4Sjd1yBSKQJOyyDcumTYnc/y6DLViuO20okbA4S0nZEw1ucvdi4e3Ig34vME6gAF97t9qaZinAcx0EyLcOFIIMUduAHRlqKh4BNIxJYB43nQ7D0fo+7HtmLas5z/JTNZ6TmcLnYvN/4iiTgyoU1Rg57lit2O56sBcyMtXpOs0mRDF954xtsQkh0MtdaFN9dasemJut0tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 06:37:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 06:37:05 +0000
Date: Mon, 20 Apr 2026 02:36:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 03/23] dmaengine: sdxi: Add PCI initialization
Message-ID: <aeXJhhPgfGjGZa__@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-3-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-3-1d184cb5c60a@amd.com>
X-ClientProxiedBy: DX0P273CA0035.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: 55842493-a709-453b-292e-08de9ea73ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LU2gCKoXWPyxdgRHMINPV/UjeU56s6JYXorRiQY1IakPszpzU66/5pW8v7NM5dSWdB2d1alx5VXF3ncaooOIbpxIas0EPMHh4BPFCEvttr+81L4PNH/crLXSAH1UBGMdmXwZ91YkUYD2dxuIiM3nrj4Iz7hyfQhUtvsgSkT9/5nLj6Texq1pf90JfRxYiw5L4H8F4WMkWjVsdaLPlvjgsj1qEoomiKuwdNRoU6y/5mmAtKewEz4h5UXmRM13J4Hws3r925ksYXcrixoqFeoB2wI/vd3eJ6pyr2iQXBOFrE2LCgZcj4uDitnSDEdlR7xR5bqm+o6g4Zo1yberGp3SucaTbqzwSxhjwROz+VmJh2gsFUWNVHaWuT/Sc1NSObIDBnNuKNlFgG2P1R8rYq14pXw9hFgoOscuBRorsWGp2NOfLYcsIjaf/XFv0S8XHSXFm0iXLClJnKGndqJJAc5euGaVxYS08Q7FXDmpE0R5KyPX/4W11M+/Zh1tSAzKKgEaUD6lGFzhorDGvEMG4sxXsyGFIcG5OE0Mk+w4j2kCiGEn2TUXmBoLaZ2uiV7jtlHe0UYkGqFMudLwIcgQaWj4tgG/eLKz431mOAmntvqzN5MKc5PSrOOKzuKBgLw6o0id5e8fCDZVLZa1Ujzpgb2RqZ4FU7TFleh4Dm/fWInJlzrfxOAsASquAyW/I9F36SWTnxgkjPQnBcYK5ac6fwG0c6Nk7RMNT2M6Yki4tGrSFeHEbMf3ppVMJU3fz1tT9LFtQWnG7f4+tyQIgs35PJ4XCG1j39yH+3Lbe/8c4VbEyI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpdzWoP39sUnK1SnorgjF6TYaLdYkKTRViuMBjN8CxQxMI3iieFcuhzIefvY?=
 =?us-ascii?Q?wjWkdfbVw4FmlsY0x2+D5fsT18QrBbpWMTc2QS11OyxMM5DlbthqieL1dsoP?=
 =?us-ascii?Q?m4w36uBQHH538Gnzai5ulG44zpUteu1YzImzvcPuXYzZS3WpSkV0TUQ4DNQC?=
 =?us-ascii?Q?QfwrxVLcN+beOTThUUVoUYx+KHo6CEd/Ka+7VA9SuPM8xB3szSwU3WJtZx1h?=
 =?us-ascii?Q?K0xQjd6n9VxFqjMDpptcmaqxoN1bL5xCQpekM2wu3UGdCJBR7YVyoR6h1Fjj?=
 =?us-ascii?Q?XSHAaDYFxGleTg8Ry6htTZ1/iMLiPiCto8JRIZKwaT6FDW/16CaN+q8jhbyn?=
 =?us-ascii?Q?ZE2/0cbappQP4sojTJeWK8ILBsxfAMNd8q36VgjR30GxlszvmxERzLuUvSju?=
 =?us-ascii?Q?wnDLxzf8sqgKLLxF+NGUUr0QM2an2anMg9hUsHbGDngyTD2MA/bj6A1JjszV?=
 =?us-ascii?Q?CxS+gctjbrFV+UdynZFmMiAOq44N/NtWaEM5LHBNB+3qiw0d+yUDKcCksR5a?=
 =?us-ascii?Q?+PVbnBsSfRp7ZZYUo6Lj1fW3LrP0ZNlyKGa2nc7w4j6f4h+SF3teZInlpCA3?=
 =?us-ascii?Q?8ylMr+9ahemg8DA6K2EqsFjsWI//Ty4KJiHS4ZjzS7doNg5lKsiuXrl5I1NQ?=
 =?us-ascii?Q?UB/sSYasU9sIazTwvarxC3xYqtopxVW9OhPm3XufmCwE+rML8vwdMV66vj1I?=
 =?us-ascii?Q?X7O9R1aFLV6ifFAqD7+YfBgVEjmxVEXYc6QajY4ud5yW4szApE27aSt8piCs?=
 =?us-ascii?Q?iBgQSyQhCv540vgmUp7QJ0fL3WZosvPTpkc39T4JB+KtEEQ+taiAqy1g+Sdo?=
 =?us-ascii?Q?Zd1YZxjAeOk9Tve3d4aOoMxW1w18Hvq1mmWoDFjqgWWl1BJWs1JAk8/KbHFA?=
 =?us-ascii?Q?+lnG9244ywmR2j3wTpKz9ctEXCZ08o1vYT3tI2c/nP5BK3/KzdMR+nLSjoSv?=
 =?us-ascii?Q?YatGZMWXhOG8FrydOpoSFuwwFxXE2zqyqKstObfAk+76X3Swk5BqXizpSZBk?=
 =?us-ascii?Q?efrTc1C3MVUzzcBvHXW8wzNyEuqRIzpmx01oEmTqV//oXpNNfl1WpfdxlUy1?=
 =?us-ascii?Q?/NpuqgglyrKHv1/3DbWhZhJZJsMo1C+vKi/ZImJUWYv+FcXlyE+hxWwxKXPB?=
 =?us-ascii?Q?xPQwZF0/LQQM/TxMOZ2vAZpCw0JAIbso4klb7xqxdZqEpuXa2lDYEtIpJKjF?=
 =?us-ascii?Q?o+VSD9rFwoTfAECKJEC5cla8muQJDpMYmRFQ1SzrLveywhcgOSisVZPKbluA?=
 =?us-ascii?Q?Ko9eMemS1MaCn7YJxqU40KgKxOwKvseANtdxQCREtvRAyHZcIUt626a8lZfQ?=
 =?us-ascii?Q?mEC/VJVgLP0eT0T31A4PjwlU/7NVMdB5vfuH9ia2KMQEy49loMU6x0nW15iC?=
 =?us-ascii?Q?z9r/jwCWZiI0zeC373+DhEaqxfYKvKICqWYYHKZrtDXQ4wRmU7ZBwY+8J9JR?=
 =?us-ascii?Q?pKbgf3I3zWpfKgmQQjdel6v9v75idaUL5qurecYHjhMNmNTG8OahCCMhs6SX?=
 =?us-ascii?Q?boGFEjxjoTiLKpgXKj8Q2AUTMKYKLq4g2XjcmHB+E+5epB6B25NxOUt5iMv/?=
 =?us-ascii?Q?Q8SUZGrv0oVHWrzvsHafCVRSGmQrLDofbQQ3Z7JDp01WOkOlQmJvrYSWPhbc?=
 =?us-ascii?Q?uJ+eWSt5G2b0Air8RFGDPa8WCP5OkXDlsGgbEruJlQ2QJn+DZUKuxAG65kZr?=
 =?us-ascii?Q?/ECoAb+/fGoMGj9mKbBAUCCbXAVS+yB5XqJExh2yaCN9qME7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55842493-a709-453b-292e-08de9ea73ce2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:37:05.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+2UXGDcyiy69O0tFKuYpwxLVrG3dQJkyjec7vxJlENY8MhCDHsqJ1p6KWzSoBsw4/CNO/HGROJHNF03MgakwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10030-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: D845D42763D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:13AM -0500, Nathan Lynch wrote:
> Add enough code to bind a SDXI device via the class code and map its
> control registers and doorbell region. All device resources are
> managed with devres at this point, so there is no explicit teardown
> path.
>
> While the SDXI specification includes a PCIe binding, the standard is
> intended to be independent of the underlying I/O interconnect. So the
> driver confines PCI-specific code to pci.c, and the rest (such as
> device.c, introduced here) is bus-agnostic. Hence there is some
> indirection: during probe, the bus code registers any matched device
> with the generic SDXI core, supplying the device and a sdxi_bus_ops
> vector. After the core associates a new sdxi_dev with the device,
> bus-specific initialization proceeds via the sdxi_bus_ops->init()
> callback.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/Kconfig       |  2 ++
>  drivers/dma/Makefile      |  1 +
>  drivers/dma/sdxi/Kconfig  |  8 +++++
>  drivers/dma/sdxi/Makefile |  6 ++++
>  drivers/dma/sdxi/device.c | 26 ++++++++++++++
>  drivers/dma/sdxi/pci.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/sdxi.h   | 45 ++++++++++++++++++++++++
>  7 files changed, 175 insertions(+)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index e98e3e8c5036..5a19df2da7f2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -783,6 +783,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>
>  source "drivers/dma/lgm/Kconfig"
>
> +source "drivers/dma/sdxi/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index df566c4958b6..3055ed87bc52 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_SDXI) += sdxi/
>
>  obj-y += amd/
>  obj-y += mediatek/
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> new file mode 100644
> index 000000000000..a568284cd583
> --- /dev/null
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -0,0 +1,8 @@
> +config SDXI
> +	tristate "SDXI support"
> +	select DMA_ENGINE
> +	help
> +	  Enable support for Smart Data Accelerator Interface (SDXI)
> +	  Platform Data Mover devices. SDXI is a vendor-neutral
> +	  standard for a memory-to-memory data mover and acceleration
> +	  interface.
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> new file mode 100644
> index 000000000000..f84b87d53e27
> --- /dev/null
> +++ b/drivers/dma/sdxi/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SDXI) += sdxi.o
> +
> +sdxi-objs += device.o
> +
> +sdxi-$(CONFIG_PCI_MSI) += pci.o
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> new file mode 100644
> index 000000000000..b718ce04afa0
> --- /dev/null
> +++ b/drivers/dma/sdxi/device.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI hardware device driver
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +
> +#include "sdxi.h"
> +
> +int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
> +{
> +	struct sdxi_dev *sdxi;
> +
> +	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
> +	if (!sdxi)
> +		return -ENOMEM;
> +
> +	sdxi->dev = dev;
> +	sdxi->bus_ops = ops;
> +	dev_set_drvdata(dev, sdxi);
> +
> +	return sdxi->bus_ops->init(sdxi);
> +}
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> index 000000000000..f3f8485e50e3
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI PCI device code
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iomap.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "sdxi.h"
> +
> +enum sdxi_mmio_bars {
> +	SDXI_PCI_BAR_CTL_REGS = 0,
> +	SDXI_PCI_BAR_DOORBELL = 2,
> +};
> +
> +static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
> +{
> +	return to_pci_dev(sdxi_to_dev(sdxi));
> +}
> +
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable device\n");
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA masks\n");

Needn't check return value when mask >= 32.

> +
> +	sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
> +					    KBUILD_MODNAME);
> +	if (IS_ERR(sdxi->ctrl_regs)) {
> +		return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
> +				     "failed to map control registers\n");
> +	}

Does check_patch report warning, suppose needn't {}

...
> + */
> +
> +#ifndef DMA_SDXI_H
> +#define DMA_SDXI_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/types.h>
> +
> +#define SDXI_DRV_DESC		"SDXI driver"

If only use once, needn't define macro.

Frank
>

