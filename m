Return-Path: <dmaengine+bounces-10049-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHZ/MRnq5WnxpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10049-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:55:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCBD4288B5
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D031030479FD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF3DDCD;
	Mon, 20 Apr 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+ysMmVP"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B737FF50;
	Mon, 20 Apr 2026 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675044; cv=fail; b=e9wXMSksc59HiqrT4JCx4V7bwm9WAGojeBB5ZqfFDhNBsZs59oKlMif66R/7gaF3FKmMdAAvLhElsLCvoxxQUOmNvbDeJEwM/LQBtT9KFHtr9PaQI44NXYt8xOdvhYruqMu+T8a5Q6YliXw8vKFYJ1hRl9ndXu7iJ960sJiFBU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675044; c=relaxed/simple;
	bh=qqm9JRiJFjgiNGOmhESlnxY7iy8tIxK+YGPYKpLproA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZEWwArqOog3CScOEzbmIkkBcWYzLufsMB4LvHKrz6YD1fXD3VKI4qswT70x/zP9TWQ8XCbTQhaEQGX0BcsNxdqf0PObqcIviWbwbxy8O52PcNp6osb5eYByScPobeebENn4+ouK+guBNDR2yXwp6jvONHGVfaUOaPl0sCet9GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V+ysMmVP; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMDL4/gOqAN/u9qK5KJaPOFFPBI5/ti+/ElAFS+exYzYtjUUGJ4HOkORtcSCvXGYLMGONpsiPwZ1L0OC642ZlEQfUJ0Ve2Byttm9W8Az6itositOUQHNivqbHCgOCAsHcR0z+iMCCh2GC5+MfCJa4k18vqBXbsMvx1hbAd8awJHQiXboBv6N6fTJjQaStirHBE+wXKhIHmRxIzVMCWqJ5tqwOGFhLr3D9JBsBWDXlZRSF4SqzPT6NPNPDiuzzJBXtBvupnjZfe66yJR9L3MzuVWHNIgePvp55iPeJXs4/y6c5f+pUTLCuYytpRHMtF1ric/gCKbmQBfIkRewZuQ7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5a41nxpOc0VacOxeJx7G05rqQpZm2n7Nkl9hUDuDBo=;
 b=VePDYfHvObsi1485oIt42//EFjHYsTtKCcF4MpUspaAf55u0INi8d/b7ESKUToQOU7tlWy5QsfL4LYMxu/GuD5XBN3IdUhcEHwStbe/wrBRxMxxrfbjmIZOJk4nJ/LT1raby4JwZT9lvFVNy5utfa5IVUCvgKrcnsKxowG3gloEdMa6s0/9Zl5wlqnLoEXaDkoH5YdVTwC38f/rnOlXJNczauXWIvyvE2SKkez665PMS4U6LgaQOqGb2z4MZ9lZq00ysOxQMvA31o3qLvEyIu9+UWciqZwIEnzmTjJDaeZaYLiqSSxcqvHb7w5fzodnnZGWC4jWTi3Bqkac29ilpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5a41nxpOc0VacOxeJx7G05rqQpZm2n7Nkl9hUDuDBo=;
 b=V+ysMmVPO9ID4CvCZgqkvRo2ISj4dX1Zbfq+A1hxtJOHdNdRjzXTDSCTE92W4FnCj4fnbP+QwgcvoawBa0+uzTg1dcDsB36tifrdUgKpVMfVsE0y3/ukLqzewNc+axq6wQ97MGNGDcMoDzwlIYyiQgLTcaxXuMxPP0toHN39RDMmDWgGnz4TuYXnlcFthCyfWyTP6sh+AQNgobs4hMuAC8I0yaIc9VNzxPnlZYpfF9W1mVEpZ/1dssvyvjVViV5aYp1Gz1j8zHdMFetyKJRAuenKn4tOUfeHR3VBB4AZTaTlSLTqXuQWYvp25+sa/r2ScQvKBGo4+3dByQG1j9KCiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Mon, 20 Apr
 2026 08:50:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:50:33 +0000
Date: Mon, 20 Apr 2026 04:50:25 -0400
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
Subject: Re: [PATCH 19/23] dmaengine: sdxi: Provide context start and stop
 APIs
Message-ID: <aeXo0VyXMhnZH0h7@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-19-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-19-1d184cb5c60a@amd.com>
X-ClientProxiedBy: PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 465c15c9-1a9e-4d8a-e76b-08de9eb9e242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M8aMuiAtfpwr+TSo36Bgzy0cvlVSfltQ8k35OSowdmiQ6JdimmG1ILRNZzv7KHE9GjRdWdtl0/mhkOVUdRhaLunqTTkWlmEXF54NjRKc88p8EFCNvZXpO5ode0HDMwMw2gHDvxUTtRfcvbV6PxSC3RmPbkOLGqq705K75tvINgtWxsKchUHZTFCaIL6KTS1RLZKS+j2lvuxHafZjFg60eY1yjB4WdQYVm71vUjKY3KHeMMu4haqoQjnML3b28TFpikule3ywygKINcnZTHlfjP6q/1hZg6GM0E2PDDhvVMVzW7lVryR8yxhwPBYDekyyKUmkOt6GuibJM+4bXbbSbXJkIM02XAfjBsoTnrTDVedWMljHWNmOuHHVJrW0JKUeTuFupIYV5SB2eumw4UiG6y2fpRMTAHnVzXuHvuu7Sb8BLO14InaUKEdg6txYaEpMhl3lK4OPNq/lenMOUMmQFV9R57ZlPq+2vAfilgXubIT6dXCIf5dbyQh2TxE6R6ib78Owtw3bVOi4KWKSC1ibf8a3c1y3WDsvs5snK3GUV6rnr1Z247pWTm8kkqAGG+uazYIth7KHlunjHflI+zixTaVCsoY72rdrOdWZycR3dHGEkzKiQdn4WWD2Nl7TNv64srqKgbEhWN37Zk6KqhrmhIMIUEyQxqbH5W2ieBQ8CWunaQCsLoHzceO2sWXGfy+Ju/zM3JvQ4E/8d5fiQla28uSlSC0X6ev+NzIrKMKGDEqUH3WYu8dSZ/ig0ly0c1ds3DgdzqUqpoPJd3bhPpm16J+bDWuTNm1qXrTv0Naiihg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yOMeHjmToj3ga7MePxu8ns2Bo33a+Ua5iyaRYPn0JiuFDF5T5kbnoIECPfA2?=
 =?us-ascii?Q?kkmqjifM5IAN1BZSXZrWhePRBdCkbKAQvY3e9/fSe2JyjQYXhZmML0Wj78EJ?=
 =?us-ascii?Q?ypEeq0j6Afh4nqGeytXahycvpbT73AJfXYbw0Qz/8Hw10kk/85EDbTjHnH3t?=
 =?us-ascii?Q?SAux9IhZWuYXXsBPu1sF8fCDzggOe33GlhiA9GN6uX01GqioZuQ29bPeyAjA?=
 =?us-ascii?Q?B843G6E3/yOWkQ/+DcaeTaLkKOTX31nzHDODLQVai1Jc23BS6WnynmiiEJwB?=
 =?us-ascii?Q?MHsEIfYlQdz6xKX/zCxl0rvTiVZI5lYHs5G9c9fzQV68HJv9tJvmdGMplfN6?=
 =?us-ascii?Q?9+kJEyy4Lz4E2ZcnyeUY+q0O8XNMBEqnsdFHYadCeteRlTty++rw9FjDtXuF?=
 =?us-ascii?Q?Wt4NbDYhWhcRHj/VSQPcooWMtuAcill+DL+Uyb3mpdiGqHJTttnHHJt5MG+O?=
 =?us-ascii?Q?BMQCoK5+bk9xik951ncXKcj1sc2AvqWiyQD7k1h1/n44d81ryCZNiZxec5BX?=
 =?us-ascii?Q?6LT6O3d8Xhmu/9qEi/w6vt0HGnBRRfGSUWm5k9Qwgba/7Rcx5hA0DZTcZbr0?=
 =?us-ascii?Q?jlD3sQWvQ/yiDxF6AB3x3yTsXGD0Tn4Ss9ev7EckcNKdAuBdUfjAlGdb9+La?=
 =?us-ascii?Q?wjkykF36fqP7CldAP51f50kDEfZ0DJYr90j6TUJd2zLTwqnJ1ua2svj6XlMr?=
 =?us-ascii?Q?RkgRh+qrhOorkhDX5Q/cITRt9J76lfG68LEGNykXE5CwVpyjKnqsAaBwF1WT?=
 =?us-ascii?Q?NxNuAggY+TzVyRQoAr6euhzQw0Q+INIoXeJL7jrud76OS2mDzeOsourOx66/?=
 =?us-ascii?Q?5d7hACluLb9difrkAvxEUxR5QpOcjC/zn4VkK3c6qvMtQfqSrmNzP9aIWX9A?=
 =?us-ascii?Q?pJuVSi30sLX+9/XvhBZNIjQ48Ng24MO9Qj0xc3+lwq0Num4HvYQB1vWO4z51?=
 =?us-ascii?Q?N2+0WSLcZoaUgX1Vxj9HOZ/Yfo0O6ztWsmx0jXQP8C4CyWIFzi9RmAUctjZ1?=
 =?us-ascii?Q?83W9EDPTdI5V2xPc+O+ltYvuDgXkSbjI/ZMTda9aQep9uPBBWVTu6WKnFib2?=
 =?us-ascii?Q?DkrPHl6NUj4YqjswRdO5MR3HVBE9d9w4YQKEtOQVYAp4E1rb5p5kwu/AzNB1?=
 =?us-ascii?Q?qvFz1wX5pGunJF138i/1Pmipk/Hf1ZvorGCvIiV3Vl1Y+IJaJsH3EdI46dN+?=
 =?us-ascii?Q?o6g31fPUtkAXMeFO6a8XDVkgeZzim/CioLQWuK02XXJTT7xhQiphhwBPJ42i?=
 =?us-ascii?Q?24mSkCgI5smlvtJLYj75PXyjhnYPML0bfwyRXeBHzKxR4jSRjTSn50qF1zvw?=
 =?us-ascii?Q?wsfdf8aPcdbsnb/LpXTmh1OQOjYSxr0T6tg3sSkbYa25iN/Do1ZFU0lw26HB?=
 =?us-ascii?Q?vFnM4f6WaEkxYc8DwyNK/2IS9skv39ioLZdr9nXP1T6bCfe8wAKjbi1FvdIL?=
 =?us-ascii?Q?lVHFpQ8KuhANY6rSMAbJ6Z59w/IA222k+PSFc0za6P6rEkhrP6LXTU87TsPz?=
 =?us-ascii?Q?6kRUa23ywg+mYZ/gDkGSpb82svRIXGxyESaEQUdKMVLiaY6+t3XBG+ELIxCp?=
 =?us-ascii?Q?FF28VPmILRNmfi+EoMg8b+SQMREqovye0N7ggF7OIhEKjm4zfrjy80nZjIXq?=
 =?us-ascii?Q?2U9ONY5DVFcj6wBzuh7gjGtldzoo+YVe/2RtbcmErKAdKmTwHW72mUjU/x94?=
 =?us-ascii?Q?i8OAj7818wajSedgtpbO4KJ2vc8Nt3GJuDR1Tm6BwHJ304kL+9yGZaYYypdc?=
 =?us-ascii?Q?dtuCbg9csQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465c15c9-1a9e-4d8a-e76b-08de9eb9e242
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:50:33.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoxEC1/pRdQEzHn2vUKUfkIYZvrAq9r/Oc1JEM1N88jTwQ1Z26WXmD29IbKpkH2GUiNM7Ye1LA0sGGHFOPzEeA==
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
	TAGGED_FROM(0.00)[bounces-10049-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 3FCBD4288B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:29AM -0500, Nathan Lynch wrote:
> Starting and stopping SDXI client contexts is implemented by submitting
> special-purpose descriptors to a function's admin context.
>
> Introduce high-level context start and stop APIs that operate on
> struct sdxi_cxt objects, encapsulating the administrative descriptor
> submission and completion signaling. These are intended for use by
> clients such as the DMA engine provider to come.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/context.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |  3 ++
>  2 files changed, 80 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 04e0d3e6a337..fc6291f12ffe 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -23,7 +23,9 @@
>  #include <asm/barrier.h>
>  #include <asm/rwonce.h>
>
> +#include "completion.h"
>  #include "context.h"
> +#include "descriptor.h"
>  #include "hw.h"
>  #include "ring.h"
>  #include "sdxi.h"
> @@ -394,6 +396,81 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi);
>  }
>
> +int sdxi_start_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm = to_admin_cxt(cxt);
> +	struct sdxi_desc *desc;
> +	struct sdxi_ring_resv resv;
> +	int err;
> +
> +	might_sleep();
> +
> +	struct sdxi_completion *sc __free(sdxi_completion) =
> +		sdxi_completion_alloc(cxt->sdxi);
> +
> +	if (!sc)
> +		return -ENOMEM;
> +
> +	/* This is not how to start the admin context. */
> +	if (WARN_ON(adm == cxt))
> +		return -EINVAL;
> +
> +	err = sdxi_ring_reserve(adm->ring_state, 1, &resv);
> +	if (err)
> +		return err;
> +
> +	desc = sdxi_ring_resv_next(&resv);
> +	sdxi_encode_cxt_start(desc, &(const struct sdxi_cxt_start) {
> +			.range = sdxi_cxt_range_single(cxt->id),
> +		});
> +	sdxi_completion_attach(desc, sc);
> +	sdxi_desc_make_valid(desc);
> +	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
> +	sdxi_completion_poll(sc);

Do check polll timeout?

Frank

