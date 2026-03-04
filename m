Return-Path: <dmaengine+bounces-9226-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPg+NKayp2kfjQAAu9opvQ
	(envelope-from <dmaengine+bounces-9226-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 05:18:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D11FAA71
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 05:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB6C30252B3
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 04:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397C375F65;
	Wed,  4 Mar 2026 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VxHj+CQ8"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F09376499;
	Wed,  4 Mar 2026 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597922; cv=fail; b=HoLFMhqI3P1C5+XLj54fv+HzNDnlycxtCJnfxzmnCvTY4i/BMvduoqJQmakoMZOJke+LGKKTSM8yQALJcUbx0kIOJw7OQbY+cFLM1RMX18xuGXfoVNlFiTgh2J7DIoZkonN/3BFFRmS1LUGFHkxnMJ1GBQ0icjXaU7bo0pwv+A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597922; c=relaxed/simple;
	bh=a0CjB5etiQBO5ROjNafMQO9smEQpiOiczM2YiBZ/RbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8EPWUaaKlFwyGihdZ2DsLHIt6WmN7yAv0iD3h1asKcZf0oXmIyEgBqhtCvZStSPwHRPDOeHRmUH+Vq7fXXj4VEr+CjXTZeIWAw+BM6o8DbAIUBWMdC4f3+SQQGhgr73keq24Bdc8o93Y6N7aeM1l2zdDOjSA6FGnobUvoQXxFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VxHj+CQ8; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDG30rUADfLqIaBfGC3hL0z/0LbT6p7NkP9+/Iprn5shK9+DSiUGHqf9lxhC6nqK6rTSgMTfrIgihOZyBa16ki9bGo68QBkj2xTRR/1bhZFRv2HvGbCRgiY8tUVKwP98e5o9T/wRSBDBNcEabsPZbp5xKDpCXMMLdEysiGM5bk8Nx0AzXJpIunU+OzGCyKnsr9RETEJxA9OMFGsNYTFNP/pyrdIsJ4RmYg7EN6xcNQ2nKfxAxwWK3NnixmmZ8tNitItdYTZl857DMsjeJ/6DVjaa7l4eFUQNltcw7I7BoKIbbV9PnwEK9FG/f6R63ALKhzdDD8tjSS+tDoUAXcB21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJvB79MVV2wX7rhlE/CPsw9zCSyAbQnwk/SlPF/I/VE=;
 b=xnNG7PPiHDkQZ+ainCl+uTxwrmCC++C4iZAjo/8HD/EdaiZU5g0oj9p+a5V32khWAXNvIwjHoSTolsN7MW38+yVq1HTyhhKzSMBIfskM9CNVc9a+V+gXRi6tWdOANhpiMathoNIl8mJLSOILMTxEeyMKFAfnUTfyYzbDVi2c3NWp4f/XyjyK+J94MJ0Y3kKGTmSHBEAjgPFlfN7d4HTHsrpBM3R2ktgMC7U/5VgAd2Qy9p2BKmsR/A+Y8bINQ3fxqZaDLEkPybVbHTMIS+sxrENR0dEJdTtU7GlyM5ynH4xN22Tyl8FwbgP9yLTmXxGupebxRR7WSsApbek34fKuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJvB79MVV2wX7rhlE/CPsw9zCSyAbQnwk/SlPF/I/VE=;
 b=VxHj+CQ8KBtdV6TJr0RkPxBdwd9bWuG1pDhcgdtv8aq7t/1982uwe3N6Bx4zyk3JI6ivhtXMUbvZ5VFMEf/MI58Cxdz0ZqgGQGafeGIFBvaNmaQS/X+T26WCbrbaew+gBsX38+DxVErf/UK24shvd5NRlEbSPQYWa4kP1ROnV8sgM3VtQV9Ln2WCGX07xManRj1SQlCoZrAQkQ5XwIhs/RopuNc8WU+psJBFwsDhdHvWwfoRgQwOtOerYIEhHhSO4WbzY4ssWfY4WtH+xbaUE0ngZ/lK1ay7gCWBa91v978zjyDfoOyWPboi6T4MzD70GFecbcKtJ6g0j7EsE4k4Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7852.eurprd04.prod.outlook.com (2603:10a6:10:1ee::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 04:18:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 04:18:30 +0000
Date: Tue, 3 Mar 2026 23:18:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: LUO Haowen <luo-hw@foxmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Fix multiple times setting of the
 CYCLE_STATE and CYCLE_BIT bits for HDMA.
Message-ID: <aaeykIuRqsXCQg9R@lizhi-Precision-Tower-5810>
References: <tencent_0ABDB1BB5F3160C21114F754FA9B18E34005@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0ABDB1BB5F3160C21114F754FA9B18E34005@qq.com>
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b222126-266d-4969-e778-08de79a51744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	VDDgwPZq30sOp9SE3upwbApf4oYqu9aZjffOSI6v5IMVXiv/84s8/PIuspIxxY79pj63P1I16hkyX++ftC1DkTGsgHcZkej/NPMFhHcJ/aK0WDSnxsWFTRuGo5t5e9prYz59fLh0yzxZu1XZB5Ri1KE7VWgZY42EA0vDWsvV9YM9WoeTPcHIllZ2jPTusZ99tTJup+Hg7aFxQ6ATYFKD74sxnk7Z0KdTpZ/5vNCFx/xPsEbhBo15P7TUxcBzyANdyj865VQbtNaUcEU9UyeJaVVauUvKSYlbhmLZPgUKG9nb5i/6P24TudrfhIQeDmhoRWqoq4EpKcrM1XdnnzgaYYCCWVcT0j1kULYQ0eLHgVa2SgP0IdKf2WbUkQbW+ZydgFR4/exzZamEgr4GpQdCpYy4qVIE5kYUX6p8r8y6LJbqNQQrFcvaYRCjb/MPTiReMMmm4pPKpMlwImBTiEZCoNw0q3VyetV3Nc0LAIQXDTkp73/9o/lvxs1w+4unrIYvzZYflMOH+JA7jPERQt6P3ZMu4xm9seZ8mSpaG/IoyYWBgMUSQCP3vJlWJdQeN4WXjjWeOSNj05T3kuz07tLhm2A5JWMOZP1WMt0XnRf3gOOnXyDBF3kus1duppDUeBY/IYFL8OQOLzOd9vANnuFuLoyVuA8y5ZYQHT10MVZ8dwfG8pAzsMlJ2FdyQ4xgUimsIxoQDQoQzPJldOZQHdy6SSEcoRI2VQKioe+aYHh/sANQa0hAa+7F3nVGSTwFfyUb9UxubEAb8HjInul7rMjTItwHnAWS4ZVcylDN7CI+X2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCFFd3zsIMoVwslZq7r0+y86tAhCTKZQn2/T25gH9QJZDZ5DkwlGZFVnIRK6?=
 =?us-ascii?Q?BVHCWks+v0Punnwz0yiwBCmFZcfxQgG3oWjtMH6iFz1wHS6ZbH9rhjuS1Itj?=
 =?us-ascii?Q?PtHwB9SeIH5Z4RDvZb1D1JY3avTzakmyI+CgkgRkPE7zHmY4x27yp/MU59xW?=
 =?us-ascii?Q?UHMrA1d22bn0l/EBYymM7y7vJieSVnp1IPVigj00inmBnyBWr4YRPBnbPwcx?=
 =?us-ascii?Q?lFuLvfc1d1gfB5Euwhjzbvr0igSTQHI/ySYS0l8KgWATJ+PAfs2zmBqDPcC2?=
 =?us-ascii?Q?Nx7PLHmy9WDalFlLHdhjy6nO/JeqNERNBMBeCazF9bNVY9MV4l2iZN3ZrKaY?=
 =?us-ascii?Q?vs8mZx7KVn0R+G43VLWMoxGWeT4tnkwoLsM2fUluFN+dhLIWJpPf8U+NRQ78?=
 =?us-ascii?Q?vqnKPghovuriwUDzR6SbDzKz6YuuYwPkuOw0up+bJ8fFuo6UyiFl6yrbfe3N?=
 =?us-ascii?Q?NuWrzfVJ7oIezp9LrfEx2cC3z3Ghd2duWpd/iYqG5fwyZ5tCjVgqi0WxnlmL?=
 =?us-ascii?Q?c3+6DVHdlj9rdfUOre7Zk8uxwuyCnQ4ZfIqk6w+WUXlZHJ5sYAOkBqwwxVse?=
 =?us-ascii?Q?lD/azsdevS+TnBf4ZZaWncVCMF/7rlQ4NL/Xjz9Q15FMAScE8NzI3+zHCXIT?=
 =?us-ascii?Q?U/OHr4Bh17mUWVzMiLx80djUTRdA2xryQezWST2npdtlPvvmJKNCa6DGxE5U?=
 =?us-ascii?Q?Cc2neFGbqS3QHL9VCnkW6JtkTEqknbPOiyiOHnQxwV/DKpeJcVcQQlDp1V6F?=
 =?us-ascii?Q?CSIUNEFvLHivCVxC0Vm0GcE+jNvjS0FzRADRSl9jaFOfNfGvHl0fzd3w9rMX?=
 =?us-ascii?Q?n52yDZ92L0Ul3o5idTxeCS84+qIB19FPtO4JEBFc2J1LEkQ+AsLuKseEhJQ0?=
 =?us-ascii?Q?0C26CxSlgGAvceXdToruVIcxx+l53LBqCQI5VT1/7Daa/WUXbRQxUfzk4W5u?=
 =?us-ascii?Q?fG3r44t7yjc9a7HCZ/mJyx54TJn91NcW/MvGEdUMEp/Z/PLPofK365gBVKfo?=
 =?us-ascii?Q?p0d7xn/EkKg4nktDYlx4DYy1gajnFj87/BHsjHNvG0uGh0wLnwirfJaWBwmb?=
 =?us-ascii?Q?Y37hjPqiep22bhHajHTpnmBJ7o0UyvExppHFyNjFg+IGqFZZzyiVSvrs/Nst?=
 =?us-ascii?Q?tX5D9XnkXlQbzi9jVYthmAqEa6sq0Ye9yQOHZev6YHw4eM48w0M32Xo6oMh6?=
 =?us-ascii?Q?tpU59fMwc5ep/glwtmPTPJmO2pfWeJYr56eNbrSSIBNHOsJ8q+ym2D8RPwAo?=
 =?us-ascii?Q?uNAC1K+QR+l+oh5FSNn7tL9DVDNuXXiIkHfPmN9PqUSh3LjA4Noa5WXAwHMA?=
 =?us-ascii?Q?hTQ5SFxcptdTc+0ot3wuoN2MTV0ZIaI5AntMzqQh9RhkslwOO54OdV08Y0TL?=
 =?us-ascii?Q?DvzKZDMffm+BKXb9gjPwJ0yoHl/BIhjKMGcawbc5Z2OrYugI+0xtzerxnOj7?=
 =?us-ascii?Q?DRW5FOw281Z7XcRUCyUVJV4PVKYSw3Wxu6+l/vF5l908BX/ERb0v0f9wJ4KP?=
 =?us-ascii?Q?RwKYulQ0E7aRKjeLFgjlFPYQhirQpIXO6Ygm8LizvBrqwkSf7aita5jEs6Ke?=
 =?us-ascii?Q?cKPMklgl71HLRs/4YqVLEMInxhBdtFBdNGtQz8VQWxA/6S8sdcvztXFnGBsd?=
 =?us-ascii?Q?M8gX75KlBHYhziZ5MhYJAaJfLzIaNLKBhTgJ+RsD/3BLpJjpSmqUXumbbqzs?=
 =?us-ascii?Q?aKbKsS4TWe29EtnEmYcvlVkbLdSXM6lj2XOzF761tQMRuBU2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b222126-266d-4969-e778-08de79a51744
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 04:18:30.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGmITSoV3ykZwPBeWlKK4TDcfVAnLw2knU25NePf1aZlnt2d0bdjlrAsfXtZvFcWUxjv+WzRlJcwmXXUJD6+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7852
X-Rspamd-Queue-Id: 523D11FAA71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9226-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,foxmail.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:50:49AM +0800, LUO Haowen wrote:
> Others have submitted this issue (https://lore.kernel.org/dmaengine/
> 20240722030405.3385-1-zhengdongxiong@gxmicro.cn/),
> but it has not been fixed yet. Therefore, more supplementary information
> is provided here.
>
> As mentioned in the "PCS-CCS-CB-TCB" Producer-Consumer Synchronization of
> "DesignWare Cores PCI Express Controller Databook, version 6.00a":
>
> 1. The Consumer CYCLE_STATE (CCS) bit in the register only needs to be
> initialized once; the value will update automatically to be
> ~CYCLE_BIT (CB) in the next chunk.
> 2. The Consumer CYCLE_BIT bit in the register is loaded from the LL
> element and tested against CCS. When CB = CCS, the data transfer is
> executed. Otherwise not.
>
> The current logic sets customer (HDMA) CS and CB bits to 1 in each chunk
> while setting the producer (software) CB of odd chunks to 0 and even
> chunks to 1 in the linked list. This is leading to a mismatch between
> the producer CB and consumer CS bits.
>
> This issue can be reproduced by setting the transmission data size to
> exceed one chunk. By the way, in the EDMA using the same "PCS-CCS-CB-TCB"
> mechanism, the CS bit is only initialized once and this issue was not
> found. Refer to
> drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_start.
>
> So fix this issue by initializing the CYCLE_STATE and CYCLE_BIT bits
> only once.

Need fixes tags here!

Frank
>
> Signed-off-by: LUO Haowen <luo-hw@foxmail.com>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe..ce8f7254b 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -252,10 +252,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			  lower_32_bits(chunk->ll_region.paddr));
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
> +		/* Set consumer cycle */
> +		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> +			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>  	}
> -	/* Set consumer cycle */
> -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>
>  	dw_hdma_v0_sync_ll_data(chunk);
>
> --
> 2.34.1
>

