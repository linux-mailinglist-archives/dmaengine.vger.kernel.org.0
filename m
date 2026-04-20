Return-Path: <dmaengine+bounces-10051-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJtiEfvq5WnxpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10051-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:59:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D0428980
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F23E7302FAA9
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60E389E1F;
	Mon, 20 Apr 2026 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eyh2e7TN"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7238A738;
	Mon, 20 Apr 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675289; cv=fail; b=cigjem8M5b/TW9f9/lxob+4JPGjqfVFGKn231ViqltxI3xHHM17Pwas470vSXb1CvIsOKLpW4/dzq1o2vso0uMLXejVssm0o/toAvCxd1Zgdf5Q7lZiLpndrjTGlAWTmUaP1n8rVEvVEi30NHA8RqwDRF9y5CSGoqzVO6zpnWxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675289; c=relaxed/simple;
	bh=YdKptnnvSmqL3EdZUizJ5LuAKauI09dO9HLDhAXfrx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOuvVR2UuNK+r3/xp2iko5gS2d+ISkxspTPyFIAANzSYLXX4x+mGTeABFvx5P4TUwQZvtStpuGgHJbBj5602QuFlOn6OfSlnGP+ojlcP+21RB6SECIiJVcKJrKtv532T8Z14tNEPOzApKcNwYPP4vRLVrwPiFkmP6SdZ14kyFQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eyh2e7TN; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wqwx6+f3FCqJqaK6hoqkvQHrEvqVysrr2dIpiNvkWmVx1yaMgtRIez8scv9vbmi7G6LZKYLrWkTL23v2lwQ2VP9h3MLxJAwrDEUzTtQcEndcbUuQpTIi8Nyp3/IZscGYkVs873g6UZPtBzLfBOzVCJFk+MGQLgIsySwn4C75SRvsvkcUFHpbi9S/bU4zXdkQItQVWksWzHxLUXfQJOKbMzYQAokPB0ogiiErqAC+P50APKsIWGUHb++iGaxmklDiZv+7CcIf5TgbEJc5YpbnUpbi4vuPBS46YHKdElQCJ90/kKyW0wd6n2vtMrX/9eAK7wYHuh3VkrQGTQDSlv2PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4Tz/Ejxx79OsvuJrFq0XYD4ImzpzXw4aAn9Q3vAkkc=;
 b=vsVEIuqPBorqSqS+V+iqxeMFYgTgjLyWDLx/M2TEq3l16B5Zq/ACGDi6ej0IQQUFV6t1OTCiS14+kuauZMXWFAc70LZ/K1YDvearDDvPk8QP1S0fOMCty4yQKFbl8z61JZdodROl+L6kVYdQOWqKZ/pxV4HtVsFWDvG3USyB1nroVl0LPUjPE5copLNrk+nSAxRhtrMtIcnOaPhx+nzhSDqxiPlU6Zurs30Y1mU+HpXrUmoxWTN8wvInMgFI+djKKIRYuX9rUSaQaearZ+G4NT0d4M9b4TQ1ghZRHH1u04jg/kTBlPNjhQLUpyBjslhl+MkB3dZSKSPdxelW+xYoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Tz/Ejxx79OsvuJrFq0XYD4ImzpzXw4aAn9Q3vAkkc=;
 b=eyh2e7TNPEaRVVa/WAL4Y9DpYL2CfuSirNLVD5jfYPuiogvGOFaq/KXSJahJbg/NiIh73ufDtOJQZTODox+GcBvG5pBFKG5qOcI1p7+R3Er4rzj/0Tlkl8nuowgqv3OBsf5bGb5uBnequozTHbx9goke9D+ncNN1/oi7HIN0aChi+KmFVUywsA0ql5pSD5mKZOWDgQrZKY6F8CXoCDIZlq0oaUZZH1Nn89Q8SYbJR+EG8+eMLU7wP4Os4UqZPe75ThdxBC9PjO235xBkYp6m0YBPOQOQ3MqlOe2ESjP4k9p7ZitLGsQZwc/0s3b/nN2b9VbMAA+vzWzYYRupAS9zKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Mon, 20 Apr
 2026 08:54:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:54:39 +0000
Date: Mon, 20 Apr 2026 04:54:29 -0400
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
Subject: Re: [PATCH 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation and
 mapping
Message-ID: <aeXpxcUulPaMqYBM@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-22-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-22-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df4ae9c-3cde-4705-bc44-08de9eba74cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ur8MmgJyrrx24zIdz/tXKhoZ9MPMcdNVKBwuzPgYSiKlCfxFJhjFxGh8XvpX2Ngw1XzDeTGTIV/ZF8LVMYjwdA1WrIpTApbjDG/r/7NKMWy4Tu+oCFIti4Lx/f2PAZOeXAdIefa5S0ttHINFmfDkZ2ZpCdelIO9j85sOZ3xRv7Gn97S2W++V39nFswloFBzBzO5TlObD0hi6764NWfrpOPqWDRMMFchsm0oJR/dEjDTHrYFL8QCwyJtTY3VJa1dy99tthy0xzap3nEP3Kq09e3nk8ml3Uikt2pj7DdnWfc/rnMMCfY2QzJ2oZ/WMeGB7wchJV0H1z1mw0OW3aH82fzP4edz3PozNrVUOMdz4kAafstKFyrsZvCaynkU9ze5deGqtQp/WM3ks6aE2xvij439ZMYfDLdsLgqs6SUFzwK04F/sEeCghR9zHhR9hS6YbBojwcOmfiOXcbmK61f4pseD02ObsQ0tbR/qMVTUIpV5x5IOSABnjJTZMetV2BIInchDM4fjvN4chQ1OWI7rIfDJozmyM7NtssvzWjQEHAR147cMhv7e4NMKqi7W0pc9PdQ7oQfSibA/E+CGCkflQH/OvSYFOqiitqA3XuXuqCxNo1FQkhOTL2w6u2p5B4h5/8iesD1D/2/Cr0hJIY9CwXIo8CAlRC9Uyhs0Gifhny//CEdzyHQq6iepnFXyN9xG+zTBIQd1Sprg2pIOYEXNRtefQVPPKn/LSVdU1cLcbprPm/jK1C78N8VzS2ga1d6bMNUpVdIgLmG8sKZW+W4DW1RD6/RyuIGRrB2ovC3ujMWc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sauDTVV+UZv1V3PDQ9CuY7TRYkBxbSAeYGxSqDSejvk0ZDL1J0lr+apUXSsr?=
 =?us-ascii?Q?HS1zsn542DYsujBsxU44FhQ56S6/T/Z88DzYWg4LkpZyTlgOWlQSl+nRAUDr?=
 =?us-ascii?Q?nYhk43qSxzSyEJjqo/ABwaTe4T9KHjKBVmdt1G1iQ0UVBlgLHKxnYZMbFCAf?=
 =?us-ascii?Q?SCCrPXiYcTBcNQ4xTmK5euB5DtF7xmeyYwp6pTRJHOhFho2TuvHiBhSHxmoZ?=
 =?us-ascii?Q?hr31y/f+H4SEjCXkWmeKGX4+KmWdPgq3R/BK7IAK2UdolYGr0M9HF626sPAl?=
 =?us-ascii?Q?di1+G6kkM7ABhBU11wj/dHHAgvTuOLrRCvytQgOaBlfMX5cpQOFFFaPW4XSF?=
 =?us-ascii?Q?LCwVFZ7bt8WxC/RIHwtDdYd4GSqRmr1z1/SBQcTWNGopn61nJw8lhM9qMWNP?=
 =?us-ascii?Q?GyLei92WWDmeIzS9YJGIXc5LUKv7/wdEP3mdl/2LPLsWovgr7zPIFQka8Mkn?=
 =?us-ascii?Q?KAxHwILBKXWbokYQqzm2CABZSJ/gg6gJTmng7Xbb3iP9FbWg1vvNTEEoXeVG?=
 =?us-ascii?Q?hf5F4KQglAABdgj/0ZI67iGN4JAKeviE8azbY8KX2EvecldmQKSuiQS8au2H?=
 =?us-ascii?Q?JlU2Ro31N6xnk6KV8hgnG3+1Sb27Na2Y3nYxdBRKrQsSDzvI6pWn2yoYrT1y?=
 =?us-ascii?Q?tlQrUOWoybbPh00HFLoUzcwupEv345MsCphXr578F8l/gmCyHDXMGulivomB?=
 =?us-ascii?Q?pwBUkEwstwQoJ/HIfdXvYCtiJsQfkJMLo0pvE5lq70qjqyxO2vx+fUg4KZql?=
 =?us-ascii?Q?/bELJ7EKup/U9NloPCo/35COeYqfXvhWry3p9pE57Fli1H7OXLBF5otH7FKj?=
 =?us-ascii?Q?TOB2EDviWs1HRgr0iKqFFeW2aBD+scudyPH9cJPSdkZQcNCdg84ONZ4VcAJM?=
 =?us-ascii?Q?OhGzviu5UWwhr+zmM551DGMkIOehjNerRxzQdlkJ3V/JH5nylVKWhaoVpOeD?=
 =?us-ascii?Q?7xRO3Fh5KmFkMl42hCxdJ675nHydi+lBQ19Ltury1Mg0zrqSQm48z6BC+Ybj?=
 =?us-ascii?Q?AvQDZfI35C1i6NMFv9GuVgQVAWkxo6AGKn4eAwKw0QfQ+0Sfqa17vkymLImA?=
 =?us-ascii?Q?7oSQuYO2aUhsXflk4GkGFPMPr2H9OFHQxsEG8fq4ts3A3nmgQiH/TmE8Hj62?=
 =?us-ascii?Q?I8S7KAbGcHtWthr6As+7w1Ofk4ZrjmjNiud3YIBD5OtLirtLjMdaL7BWBt2K?=
 =?us-ascii?Q?sKs/HBir6syXUp7tGxFpdgBYv0HzNLucXIEcxz8GcmF/kuhQlhhtRU2rorMH?=
 =?us-ascii?Q?zZ0e4QWvh5bO6X6x/1KSLgxkMkK/TKaEBIYj42wBQXGWPexQF62y8/VNERt+?=
 =?us-ascii?Q?wLCSXFXrQfHiJFhO60+uTrRNQxFqIbOuVfj199X4JXkGoK9V1yRAY1GlwyVg?=
 =?us-ascii?Q?mG/7NeXFcpzYAvLp7cv+OZdeFDwVH1rcQZshRVw8ciMmTnEMplA32VaTVYHg?=
 =?us-ascii?Q?3igJS19wpQ4UY4xxWK8kFAM3ehV72NJXZ8bUQbr3ExurSO6/6u32KFHLwrNR?=
 =?us-ascii?Q?wu8DiW3kxIXB2EmgcQ0qiV8aKeNNHzXAtSmN5PqfB2wvw1adFnkaPN2LpVgg?=
 =?us-ascii?Q?jBWugmwKqUl1lgRSJPoK4akT1IwqUqWhlYJLVeiOzl+6T+DbLhroW3g1z3ys?=
 =?us-ascii?Q?LdFmt00+ux+CS9HBcymcBibD6iPwI6JL7z5lvKM7mBkSIB8pPEGstnBmWy9n?=
 =?us-ascii?Q?vGxR6sIO5q2NeGi5cmdB+izqFPuctbbUXNaQes32O2MXznSyyT6nDLZjiJQH?=
 =?us-ascii?Q?4o9YhtwRIQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df4ae9c-3cde-4705-bc44-08de9eba74cb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:54:39.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffgu5jNeJYp5qSZ76TeOnNJX3Cp/tnVNjsgWcGQwvOJ63pV1LyQ1JaWgIm5LOIlnL1YVfMeAZ+ZnjvuPorU4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10051-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B1D0428980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:32AM -0500, Nathan Lynch wrote:
> During PCI probe, allocate a vector per context supported by the
> function as reported by the capability register, plus one for the
> error log interrupt, which is always vector 0. The rest of the vector
> range is available for use with interrupt-generating descriptors.
>
> Introduce sdxi_alloc_vector() and sdxi_free_vector() which are thin
> wrappers around the IDA that tracks the allocated vector range.
>
> Introduce sdxi_vector_to_irq() which invokes a new get_irq() bus op to
> translate the device-relative index to the Linux IRQ number for use
> with request_irq() etc. For PCI this dispatches to pci_irq_vector().
>
> Code such as the DMA engine provider that intends to submit interrupt
> descriptors should prepare by using sdxi_alloc_vector() and
> sdxi_vector_to_irq(), and clean up by using sdxi_free_vector().
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/sdxi/device.c |  4 ++++
>  drivers/dma/sdxi/pci.c    | 29 +++++++++++++++++++++++-
>  drivers/dma/sdxi/sdxi.h   | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index aaff6b15325a..8b11197c5781 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -10,6 +10,7 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
> +#include <linux/idr.h>
>  #include <linux/log2.h>
>  #include <linux/slab.h>
>  #include <linux/xarray.h>
> @@ -303,6 +304,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>
>  	sdxi->dev = dev;
>  	sdxi->bus_ops = ops;
> +	ida_init(&sdxi->vectors);
>  	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
>  	dev_set_drvdata(dev, sdxi);
>
> @@ -323,5 +325,7 @@ void sdxi_unregister(struct device *dev)
>  		sdxi_cxt_exit(cxt);
>  	xa_destroy(&sdxi->client_cxts);
>
> +	ida_destroy(&sdxi->vectors);
> +
>  	sdxi_dev_stop(sdxi);
>  }
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index 8e4dfde078ff..99430eaa583d 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -5,6 +5,7 @@
>   * Copyright Advanced Micro Devices, Inc.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/dev_printk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> @@ -13,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>
> +#include "mmio.h"
>  #include "sdxi.h"
>
>  enum sdxi_mmio_bars {
> @@ -29,7 +31,8 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  {
>  	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>  	struct device *dev = &pdev->dev;
> -	int ret;
> +	unsigned int cap1_max_cxt;
> +	int vecs, ret;
>
>  	ret = pcim_enable_device(pdev);
>  	if (ret)
> @@ -53,12 +56,36 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  				     "failed to map doorbell region\n");
>  	}
>
> +	/*
> +	 * Allocate the minimum required set of vectors plus one for
> +	 * each client context supported by the function.
> +	 */
> +	cap1_max_cxt = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT,
> +				 sdxi_read64(sdxi, SDXI_MMIO_CAP1));
> +	vecs = pci_alloc_irq_vectors(pdev, SDXI_MIN_VECTORS,
> +				     SDXI_MIN_VECTORS + cap1_max_cxt,
> +				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (vecs < 0) {
> +		return dev_err_probe(dev, vecs,
> +				     "failed to allocate MSIs (max_cxt=%u)\n",
> +				     cap1_max_cxt);
> +	}
> +
> +	sdxi->nr_vectors = vecs;
> +	sdxi_dbg(sdxi, "allocated %u vectors\n", sdxi->nr_vectors);
> +
>  	pci_set_master(pdev);
>  	return 0;
>  }
>
> +static int sdxi_pci_get_irq(struct sdxi_dev *sdxi, unsigned int nr)
> +{
> +	return pci_irq_vector(sdxi_to_pci_dev(sdxi), nr);
> +}
> +
>  static const struct sdxi_bus_ops sdxi_pci_ops = {
>  	.init = sdxi_pci_init,
> +	.get_irq = sdxi_pci_get_irq,
>  };
>
>  static int sdxi_pci_probe(struct pci_dev *pdev,
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index da33719735ab..d4e1236a775e 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -8,8 +8,10 @@
>  #ifndef DMA_SDXI_H
>  #define DMA_SDXI_H
>
> +#include <linux/bug.h>
>  #include <linux/compiler_types.h>
>  #include <linux/dev_printk.h>
> +#include <linux/idr.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/types.h>
>  #include <linux/xarray.h>
> @@ -27,6 +29,21 @@
>  #define L1_CXT_CTRL_PTR_SHIFT		6
>  #define L1_CXT_AKEY_PTR_SHIFT		12
>
> +enum {
> +	/*
> +	 * Per SDXI 1.0 3.4 Error Log, the error log interrupt is
> +	 * always vector 0.
> +	 */
> +	SDXI_ERROR_VECTOR = 0,
> +
> +	/*
> +	 * Request at least one vector to account for the error log
> +	 * interrupt. Increment this if the driver gains more
> +	 * dedicated interrupts (e.g. one for the admin context).
> +	 */
> +	SDXI_MIN_VECTORS = 1,
> +};
> +
>  struct sdxi_dev;
>
>  /**
> @@ -39,6 +56,10 @@ struct sdxi_bus_ops {
>  	 *        function initialization.
>  	 */
>  	int (*init)(struct sdxi_dev *sdxi);
> +	/**
> +	 * @get_irq: Map device interrupt index to Linux IRQ number.
> +	 */
> +	int (*get_irq)(struct sdxi_dev *sdxi, unsigned int index);
>  };
>
>  struct sdxi_dev {
> @@ -61,6 +82,9 @@ struct sdxi_dev {
>  	struct dma_pool *cxt_ctl_pool;
>  	struct dma_pool *cst_blk_pool;
>
> +	unsigned int nr_vectors;
> +	struct ida vectors;
> +
>  	struct sdxi_cxt *admin_cxt;
>  	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
>
> @@ -76,6 +100,39 @@ static inline struct device *sdxi_to_dev(const struct sdxi_dev *sdxi)
>  #define sdxi_info(s, fmt, ...) dev_info(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
>  #define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
>
> +/**
> + * sdxi_alloc_vector() - Allocate an interrupt vector.
> + *
> + * A vector that will have the same lifetime as the device does not
> + * need to be released explicitly. Otherwise the vector must be
> + * released with sdxi_free_vector().
> + */
> +static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
> +{
> +	return ida_alloc_max(&sdxi->vectors, sdxi->nr_vectors - 1,
> +			     GFP_KERNEL);
> +}
> +
> +/**
> + * sdxi_free_vector() - Release a previously allocated index.
> + */
> +static inline void sdxi_free_vector(struct sdxi_dev *sdxi, unsigned int nr)
> +{
> +	ida_free(&sdxi->vectors, nr);
> +}
> +
> +/**
> + * sdxi_vector_to_irq() - Translate an allocated interrupt vector to
> + *                        Linux IRQ number suitable for passing to
> + *                        request_irq() et al.
> + */
> +static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
> +{
> +	/* Moan if the index isn't currently allocated. */
> +	WARN_ON_ONCE(!ida_exists(&sdxi->vectors, nr));
> +	return sdxi->bus_ops->get_irq(sdxi, nr);
> +}
> +
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
>  void sdxi_unregister(struct device *dev);
>
>
> --
> 2.53.0
>

