Return-Path: <dmaengine+bounces-10274-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBoeJhLc/GnqUgAAu9opvQ
	(envelope-from <dmaengine+bounces-10274-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:38:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EC4ED86F
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E8A30262EE
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCB451069;
	Thu,  7 May 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cgwvGLAD"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377136AF6;
	Thu,  7 May 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179087; cv=fail; b=kccyotXtz1VNlHW6h3dHm6sW5dp3qRgNOPAwwLn/yhhz6js/GgoMv1icipbeVi68giC0YZWPAvwuiX0kpEGSQ+s1lttKa/zshedreuU7/MoJMZNB9rdbv2wehhMe8BmmGOC7SjiYUCfC+wEfdygK6bD7VySLbTtKHvb2LiZxzaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179087; c=relaxed/simple;
	bh=pizQtG8eNAlTvF30V2+qtuoRwstnG3LlT6iyMBXBdaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V9UTw+6T3c4OE5vX/pwQRlE8e3iXpnRRLeC8hij1SR6nyXQiuwr2YffhAh5wOGvEMoF58IlmnM+zwprCkm6MYyeqkyCM4F8+p/kvXu3ggz+rEgtruKZ0ACSmB3yvjljtEVUHKK5N8AtshDBTfBuVUkfiR2W9Xr2nbmAYrierU6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cgwvGLAD reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDIFqoKSXNBEiz5KypFXBB9mFJMOazd/PYhPEvEThUwupFDSdO1A0Lu1YMg6JcnHRbwFhRErqABP0x59o6C18v418V/HELQUEC32oEPW5ssb75LCDSH+yYcOf+2E2IYzp/QQ7Sg+91x9r/p7kxIEGSiDA61lMFZ8UmIrEMAGN2mdRfiM9W8+cXhifDDzcaobef0M5I8KSEHd0/RjqVuDG2dbE98owwh2YsPTA1RV8MoRhkp696b7ZhYigyxPjQCrNDZ+PLmSCi1eL4xyoLZiMVozV/rRaIW2pAHgqDKgi/kVJbsSwIRtZdn7zZTMHzXeLIyD0Co2osiUo2KCFr2wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW8uYnX7aZvBItbmBEOYX35lFI/jqt+HQ1uean8A7q8=;
 b=BCap4oOU5zzYdwwsmP4+l2c2vzXsnVNLtug61d/PlTgHxRHAARX9ea+kPxCoi7mvwPZQbDmakY3QlLjhJF8FhRyRPKcOQBZa1kwNmw1JayCpFCVvNe0OKaHem5xuoxGMY0Ng7f/jt3d4ClGDzZ03Vo0GLxk9cNBa12TOTGNdDuqBc6D2iRHv/WzmCN/m77NbieLcISwIVJQAzm2Ft70tBksUXghoyNkzOo1ot32IKcIk9p4ob2Wg1kDQgiG6Svnb2QcpyC7xHjfMqfIUYKDUbcHmYuT7Eeh8CDTF0cfGy4FePDRMfieNaOzyP9p4QeKjB9PCVgk9b2C0V4McWwY9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW8uYnX7aZvBItbmBEOYX35lFI/jqt+HQ1uean8A7q8=;
 b=cgwvGLADAmgc0IJyk9xQl+cn957/rr0tAqWthP0ECCXbMVJOppbHOKozDVTriaECFe1o89ywiayzhlsPcII7kQx8lf9GEiCpAnqjpWeNEajCstLmX7zjAPoRObgySIimJIs7F2Rh69q5stwF6WHzyy+HXj7tWXc99O46xsoItVaUMyMlkl0tO+AuhqRzD97eptL/1Vckn8xSuYh6th3awbroSLPjEMYEOKiJTfFfHxBE0GDRWpJXUEq0my7cEiJii792MFZUdELi2tP3xjza0cY0EIOKF7xLQleeVtDX3hGrGNDxDeye0ERp8RRXuYLUrXiZkyFFkVoq6fwZygbxjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12614.eurprd04.prod.outlook.com (2603:10a6:20b:778::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Thu, 7 May
 2026 18:38:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:38:04 +0000
Date: Thu, 7 May 2026 14:37:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v4 4/4] dmaengine: dma-axi-dmac: use DMA pool to manange
 DMA descriptor
Message-ID: <afzcBnqS7UCmnPyN@lizhi-Precision-Tower-5810>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
 <20260424-dma-dmac-handle-vunmap-v4-4-90f43412fdc0@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-4-90f43412fdc0@analog.com>
X-ClientProxiedBy: SA1P222CA0136.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12614:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7470f8-c9ec-42c1-ef19-08deac67c617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	K3XeqceOX3cey1iSa7N1zKyhMZf6NDz55qWA07WLTJCA+A8FGQWNbeK2XIDpw4lFXo5PbpjtKyebp30z0iGbnVnzzgvafWJp3cQb5kkD3WPVknZQSYUdtUwLnzGK1Qoa6L/yYLRIGd3b9VwmJapghDOQ3NHoo0YkkTX/QEHswUY0XQulHZjLBMg8Dj8WF8+GMzkWr2QIc4f0ncCB79HYPl3gXqtMwUd6r9x5xQ4ojIWimLr1uqjh/mWDyJu6sNBeVUtzQtc8leglrHBx+1mO4CyaaWgBiPEwR0bD09s6UcCNZMb9RAhkl49OIYr/lIhsm6giUqLeJDYVJ/Q+V+QQt5h5hT8knql3cBnqAm4vmjh+zFbRWlWwmgbhAtAYctpm1uCfdl1dKBGEu4ybUs9V9mHWUU9cgpND5mtEta5Gf6/wQgMCOprbfHp42GgmPZHPVJbJkOnYCBXiz8RLckr6DIdoKElsuAfgoSmRHaPT+NmrvP7IkO0/3fO6hrtusR204nviAfyhcyY4M2cPzP7X1CJA7Bw5VFvn1VEJAZ9VjT763EH71DDdV9uRhxuiLK7u7ewDCyXEk7O8xWywHI4z0MZKPFrZRfHEi/Q5m8SaZmqw+4WSoL0uz730YKHsoth1u8mF5W6rytBXqETtrSNLloilIJGOYa//NDFab2AUbQ3XOiNUdeFABTmUMSXiwehRjK4d9JXUaQslpH7oMeDD9xwR2f7Ehlowz81XS/XCU9B3UFZpmq0LCz2OWmo1u8HM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7Sg8S8YyjeQJ4JkMsCR3qghRQHePVe0L5KXgq2DDxa2ZcBkJvQSaUjDzhf?=
 =?iso-8859-1?Q?gh1Ia5AU78Nwtx2L/lZ0V4fM4g8972GKUTCQjxX6dYiXQwrEn+doqCE6gb?=
 =?iso-8859-1?Q?xlMbkBVn2kPhPJXlSjAL27ty1oP3pReOFUjvWaKeC4vkswv0Pv/RAD7Eul?=
 =?iso-8859-1?Q?VcTTeTTd4W0bZFQmJnZ286SYSIoH+R4fOOiKvusc8LI53TK11sgKadeqlq?=
 =?iso-8859-1?Q?kOsADg8JK/fkZ99QT36c9tbemMrw0fRV3DR/eaAk45b/y6NSzvAI5J5gkU?=
 =?iso-8859-1?Q?iHsu9MyUeQw9xtP2DK03zjzc68QusN85d9ezfXxeNXELRQSfRIo0KCGj+i?=
 =?iso-8859-1?Q?gOpmK0N8eOKiEF8Um09nuWI01E0Da0KR+FQmsjGIFCvRND4WGN8puiG2Ak?=
 =?iso-8859-1?Q?vGNctA+UtnYnEj2iU29haIv/dLFSonu9cpBnUQtUzkuCefMBPFJ/8jBxOa?=
 =?iso-8859-1?Q?dmibJLzIRIRvVoW6sshntjf4Kwt7xdFnkwh9KNJzXGtQUCleIK14PBBTo2?=
 =?iso-8859-1?Q?HJ2l7RmP9Uk7S5uWaxSSTwu4Si5zZZsMAF9NgGQoXIbGJQUoB4W/WLtAY0?=
 =?iso-8859-1?Q?w2isJakemkSuuwhwCSDN40CM/hruFWD53aesBhhUUpS5xUgSFmKk42/PlA?=
 =?iso-8859-1?Q?eVstREiaJO/FskE+djtQpQfJBpZ0ayywccpWB+/SGGi/trAkgUP5wxTRJY?=
 =?iso-8859-1?Q?LtGBo1e80yOoBw+iY+VGhtpoDaecgAWiX7Mz2tLBmjh1rjoEzYSRptTcfS?=
 =?iso-8859-1?Q?anUIvUis29h3vds2RDD9TD8h2cXcXaHS+ZlPw51wky/xf7qES5UuNDM0US?=
 =?iso-8859-1?Q?5sDn7vEWtka9X+1U9VtLCzLIL/wlUU8A/Y6KApl7haKfQpc2/a/3WGNwtv?=
 =?iso-8859-1?Q?q8E/J2RICslO1ikQFMzeMaLbu89/qrPmsXd5yZq254K0ZwL63r816fZmgr?=
 =?iso-8859-1?Q?sFK9gegCmf0mCCvNWxYYuhbMr8pG+5UcyPHmhs2Uwy4mZbi331iAzDrye9?=
 =?iso-8859-1?Q?mg8jQuR4kvY9TIcuRqda4iI5QUkF2aAjT/8VmWPdNKmfwefdCjXwbZzc75?=
 =?iso-8859-1?Q?FrB3Q2Z3CqdPszsMDfA/D5v74kbrPvOOf26Dt3fmylH3GgER4l2y0A6VPK?=
 =?iso-8859-1?Q?y2/aX94+76odnuXLdHXTqaKQynJaf6D/j7ECvZ2961PWQ59R14P73oi5MX?=
 =?iso-8859-1?Q?bK76QishRNcAuNqY55csJolVhU8PiyvR6kOghG30TkFuWex14hfqpunRzb?=
 =?iso-8859-1?Q?MDuFbWFIg8CzeyKm8q3O8sEtB5dj0X4aWHwdGR+HlxB3+/6o7gRy9qZr2S?=
 =?iso-8859-1?Q?R8/PEIgZBT2ynPN9yJ1W3syuIKbBcFPKkVZVDQZ0u9d9DgyGVO6huXGC8O?=
 =?iso-8859-1?Q?K3tvwbq9yVcCZcjL4dSX6CzVwCJQj8ACdB0Z+FzN2bY7mj7Y2j6WnAqsCD?=
 =?iso-8859-1?Q?wlKSRw+D3VyI2shkZhqX339K2/BHbHb74fjVD8qMJmvW0b2oQQASzrS1Ql?=
 =?iso-8859-1?Q?nmamVTWXEqqo96s2m1nLoSqex40vYvqNlHNIvJPbCOdVQlprVNEk/4N/5r?=
 =?iso-8859-1?Q?ZD8aWwHDMxtdCcV3CUQLSlcDDEEGcktPlQBBiEARTAUJQgLgtRvqgsnLz8?=
 =?iso-8859-1?Q?1Ww1KmBZidfEGj9LdOwZp1SlznbHYzBh3Do9P09RwOdIferWCd0YbOeMqF?=
 =?iso-8859-1?Q?sPd6GPEZydUkUkzR29LABNRkxuK5flyYmfk/+wJ09LSTmw+wUL91oHWXrY?=
 =?iso-8859-1?Q?7zuxKzmj0ckIgBPynTBUsGubKCr+pzZBCXKwtr2l/6hFYZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7470f8-c9ec-42c1-ef19-08deac67c617
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:38:04.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slhEOlBopJa2skda8JOAAKHd7b/kCsUrYdsSfZRaeLSxpIcUEFuxc4YwLhloXjC8NWaikJ7fc8jl9vFBu1xndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12614
X-Rspamd-Queue-Id: 029EC4ED86F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10274-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,analog.com:email]
X-Rspamd-Action: no action

On Fri, Apr 24, 2026 at 06:40:17PM +0100, Nuno Sá wrote:
> For architectures like Microblaze or arm64 (where this IP is used),
> DMA_DIRECT_REMAP is set which means that dma_alloc_coherent() might
> remap (and hence vmalloc()) some memory. This became visible in a design
> where dma_direct_use_pool() is not possible.
>
> With the above, when calling dma_free_coherent(), vunmap() would be
> called from softirq context and thus leading to a BUG().
>
> To fix it, use a dma pool that is allocated in
> .device_alloc_chan_resources() and allocate blocks from it. The key
> point is that now dma_pool_free() is used in axi_dmac_free_desc() to
> free the blocks and that just frees the blocks from the pool in the
> sense they can be used again. In other words, no actual call to
> dma_free_coherent() happens. That only happens when destroying the pool
> in axi_dmac_free_chan_resources() which does not happen in any interrupt
> context.
>
> Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/dma-axi-dmac.c | 66 ++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 41898d594be7..d47ff27e1408 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -13,6 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -147,6 +148,7 @@ struct axi_dmac_chan {
>  	struct virt_dma_chan vchan;
>
>  	struct axi_dmac_desc *next_desc;
> +	void *pool;
>  	struct list_head active_descs;
>  	enum dma_transfer_direction direction;
>
> @@ -648,11 +650,17 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
>
> +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> +{
> +	for (unsigned int i = 0; i < desc->num_sgs; i++)
> +		dma_pool_free(desc->chan->pool, desc->sg[i].hw, desc->sg[i].hw_phys);
> +
> +	kfree(desc);
> +}
> +
>  static struct axi_dmac_desc *
>  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  {
> -	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
> -	struct device *dev = dmac->dma_dev.dev;
>  	struct axi_dmac_hw_desc *hws;
>  	struct axi_dmac_desc *desc;
>  	dma_addr_t hw_phys;
> @@ -664,22 +672,22 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  	desc->num_sgs = num_sgs;
>  	desc->chan = chan;
>
> -	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> -				&hw_phys, GFP_ATOMIC);
> -	if (!hws) {
> -		kfree(desc);
> -		return NULL;
> -	}
> -
>  	for (i = 0; i < num_sgs; i++) {
> -		desc->sg[i].hw = &hws[i];
> -		desc->sg[i].hw_phys = hw_phys + i * sizeof(*hws);
> +		hws = dma_pool_zalloc(chan->pool, GFP_NOWAIT, &hw_phys);
> +		if (!hws) {
> +			desc->num_sgs = i;
> +			axi_dmac_free_desc(desc);
> +			return NULL;
> +		}
>
> -		hws[i].id = AXI_DMAC_SG_UNUSED;
> -		hws[i].flags = 0;
> +		desc->sg[i].hw = hws;
> +		desc->sg[i].hw_phys = hw_phys;
> +
> +		hws->id = AXI_DMAC_SG_UNUSED;
>
>  		/* Link hardware descriptors */
> -		hws[i].next_sg_addr = hw_phys + (i + 1) * sizeof(*hws);
> +		if (i)
> +			desc->sg[i - 1].hw->next_sg_addr = hw_phys;
>  	}
>
>  	/* The last hardware descriptor will trigger an interrupt */
> @@ -688,18 +696,6 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  	return desc;
>  }
>
> -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> -{
> -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> -	struct device *dev = dmac->dma_dev.dev;
> -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> -
> -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> -			  hw, hw_phys);
> -	kfree(desc);
> -}
> -
>  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>  	enum dma_transfer_direction direction, dma_addr_t addr,
>  	unsigned int num_periods, unsigned int period_len,
> @@ -933,9 +929,26 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_interleaved(
>  	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>  }
>
> +static int axi_dmac_alloc_chan_resources(struct dma_chan *c)
> +{
> +	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
> +	struct device *dev = c->device->dev;
> +
> +	chan->pool = dma_pool_create(dev_name(dev), dev,
> +				     sizeof(struct axi_dmac_hw_desc),
> +				     __alignof__(struct axi_dmac_hw_desc), 0);
> +	if (!chan->pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static void axi_dmac_free_chan_resources(struct dma_chan *c)
>  {
> +	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
> +
>  	vchan_free_chan_resources(to_virt_chan(c));
> +	dma_pool_destroy(chan->pool);
>  }
>
>  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> @@ -1238,6 +1251,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>  	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
>  	dma_cap_set(DMA_INTERLEAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources = axi_dmac_alloc_chan_resources;
>  	dma_dev->device_free_chan_resources = axi_dmac_free_chan_resources;
>  	dma_dev->device_tx_status = dma_cookie_status;
>  	dma_dev->device_issue_pending = axi_dmac_issue_pending;
>
> --
> 2.54.0
>

