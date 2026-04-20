Return-Path: <dmaengine+bounces-10045-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDwSF4rn5WlkpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10045-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:44:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65C4285CB
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B16693019D9D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED293845CF;
	Mon, 20 Apr 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YRseQIgd"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C69382388;
	Mon, 20 Apr 2026 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674369; cv=fail; b=hjGC0DELKXzJgcZ+n0Hvnuum5s8DYQ6HArxVnZ+mg8WzrhIIrQfadHWezqu8aomZyEW7Pysc4NC8d8BK2j3IKDcfBD+Fz/J3VBsDQ1VtGiZne7GZKRlHc2F4xVzAzPUFwcAE5j0SwnQd233lETAJl2ndX4Bhi7s0jd3DMEYXw5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674369; c=relaxed/simple;
	bh=8BBXnpagWkcXWvFtTRokR9+gNamZ1IIW5sj8US3I1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kp3sn12nP1Y5hf2iC0kFqdqU6pM4dYrsvXNawJeMDB+3LYkq2ZGUUbtVbximgFrnzIfUsPUJ1HU9LMnAlzrYs/9jt6a01iLdQZKb/btA7EIYuD5zd5aK2ZMspuCwjDENcuRnZDL7AQMR6VpX4iQ2kKGp1YJqrGFrPIIqrG66BSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YRseQIgd; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHLRUCt6v4emKaIqrTXg9E4ExydGzqu+KASTJHt2cRoT6o5X1ZAQhfrrk7OPaEIiy14VqH6pDzhcypURbTC/dcHlJXHPMOfvPNQaIfgOGIRntgI5hDF0r/10bbBZtkMVSIDn+5xLagUzg0nzLSoAeTblWlMEI+TTsf+N4JW3WRS4qjdXL/lVsO+6ttQ26DVbYU41PbBbvsKc4ZUg9+fTYDSmqlDj2B1hB1M+ZVoSRbmMUDzNQStGFeB85XbThjH0YNqMD0TspOwviopujDOUgMBlbaWm577FeId0qmy7wb9NDwyJR/5x4Z8tln1gMEwRy4mCmhXJ8rMn81Zebd1a8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q049j1MNBd2kSLsxAV9WdDj+RVu4G3Bs+6YkSpwsfxI=;
 b=CiQnERvKCETcXb5tHTao4SNmVqX0nfYT+bvwXV7EIy7ZU7oI9aze/WUwok3L9H7Mzqd8+jrfHDMegWV75+aO33IqPJAPFLl1lHzi3MWoeF6I3wvhDpYqVimkTXO4ZFYEJk8qoFgmJ7SWus8C5cWZN1Lv+FHLA336ingYnTl97fQQsitftGjikCsgWYZYaa/4f/7LLU6pDiHhcTv9wrlp1PPGxdPktIE7UrUl+tIdU5gWZ69/lkg1tovCAIUoXxwZCx0IB50yfw6eif6AIisPONyeGHv0/aF6L4YNuKXIWvN5DFRnIw9H4LA7tqFSqm5S6FHzo+9QLYsxxrxAyNla+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q049j1MNBd2kSLsxAV9WdDj+RVu4G3Bs+6YkSpwsfxI=;
 b=YRseQIgd34vNYT9exJPxiFPts0gwaQRqlZov7nJpyRzz1YwSlyi9yJwjcTKWSbxQb8nhdFSq/mmk0gTw9mEWiaYeu/CETv6Wa3WKcg2V64bH5jJgtp59K6+goATMv5kNAK54Wqf18QKiG0E8B7hf6i/ewczvow0N9fScwgq82dV36uMZeMJImx3yopv0ddhue1Kg41IfBvMBZZIEbb9/FfCEA/68INJ71N0UOi1dyK6Xhe4S/j4jkSagU+uEPeoxKUP5FOYNreCMK+7ALuKbtgIS2s4ibWFuj4YpRuCn5bqer+iaLDmO866ySATLKDb/KHCZ14+T4Y/B6RSMdkwASQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:39:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:39:25 +0000
Date: Mon, 20 Apr 2026 04:39:17 -0400
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
Subject: Re: [PATCH 15/23] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Message-ID: <aeXmNfn2unYevYzQ@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-15-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-15-1d184cb5c60a@amd.com>
X-ClientProxiedBy: PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: 2150f296-4bb2-4703-19e2-08de9eb853b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bC9l9SFGDFZNx3guYyRmoXsscjl7sgk+GeETW2JQeZdkffl+TUAUgim2XDEa1VTiAiPLqpkRNWBmQ9vLJFL+Tpc6+4vjOzv0ErSSR5QnsAo+9bTWdex4tv8jTodifRhWoq/Vnu3vWSn4hkue8jtQUfKlIbdkbVb0Z/iCDeh3afh4SDj6GgUD0Rz2o+POBY6L30DdiBENpOu2y7yRE+cXnE11ZM5+UtfhfHVc2d9g4m5gUxdfnqErM7JjI/0Jr1PCDjRWRiYuAaI3SUOuQMoqHeANFMCSFQ0gGZUWlRSzeU1sjXNkGpTlcNYMUQlk4l4GL2BP7DOHAB/43WomyOQxyC+JEepH8Gi730b+CeSMeNpGzs4OcPUw6kPo/PEBlo0HuAn4+3zBgXUhxdxxKZNgOfyUyUfrPLvEIypVZrzdIAisOFYU2O0DWXiYuxIIzkdJh7+5LSWRpw24GAyP9OE+uE1JwNmCEpZMVSR+IJMx2Gq5eXnG2gy501W9QZR0OXmOf0d3i9PMdVukJFQ4i6yj3vkb+5AyNyotpEso1sL1B+MIAraMj+VbCYIQprB7SmWg6xtNamoRvCRXdk4kmJi57XCMhg0vBCmfVd3aMGs2z0JP3Lk+qpMfa+R5te1w6dLnE/5z5JRiYTA017Fdh/v9KuQB/hhN5pztIMsK+bWvwpb/BBQ7sRX28P/TmwRujBhRq+PLcOLXQ1D2bZ2skqfSUSLzeKMe4UlRd5jC7N711tC+UHwYudhgMIsCvdF2XUuzGS7dtMXvp0D7xmwFb90BrFGSpHtKWcGirr2/dLbVnYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KKpBEUGit0TYLblNKETXj+tgtWYrBTqlFPXS69L1i65uK41CqC+ze6gmPtGK?=
 =?us-ascii?Q?o4U2McX2jd0hlmzxaTR4GwwMfNopI6AEVbBOamsQUr/4W89BQLVsG7KoBZ9V?=
 =?us-ascii?Q?pEfuMhuaJaI3xppMx0HwBUqyt+lDSLot8oTsLXpBidVzMm7qrhAclG5NDa4a?=
 =?us-ascii?Q?CKkZvUdJYF64UrQgViKQWN+Dh65N5K3OxhsgqcGNwtam527ACy43oRDPC5XK?=
 =?us-ascii?Q?2kgGCYtN5MRVxDnniVRuhSAyVF3QpZCfb45KwZ2DW8cRiGt5YIRIxFO9snxo?=
 =?us-ascii?Q?nB8pXXmRO7GLLrV8xXQV9M0oIN10ndeK2Le5nbAQy+z4EnCN5oaszZudgKzG?=
 =?us-ascii?Q?FZCjuTXP0vJCuBh8n/pIMaTVxw8owvc+hCMkxh2HtuQFYkaRTKUZn3XrN84y?=
 =?us-ascii?Q?Acc3XSeBC9dPAoQT2EK1ox254qdnSvpbyCSCubghIr2Gf+li+5hUudVotVzD?=
 =?us-ascii?Q?RIn0hbNAhzeSvXzq/+M5y1s662On5WlcVi3LngIgUWQlxgN5RMW9aXwCDigh?=
 =?us-ascii?Q?wFVX/LRKgbhlaIsJNSCs4Gi7r9JaQdiGhHjP9bO4CtkEClVXooCWnJToKuO7?=
 =?us-ascii?Q?/oL/NGT35lyCH5UnvOFatMYa+d/D/bT/lhaUTzg6grm3MCKpeeMXekox4Vkf?=
 =?us-ascii?Q?fCD76EX8/IbkmqoaG9TQnKGkmiJRaBQC914iujXWudhXKVbenK3TEjpc/5b0?=
 =?us-ascii?Q?isSF2cwAv2/L5YKwWiTWKuCGBflmWsZDrlByJscUbtfpSroKRRHijbIx6LQR?=
 =?us-ascii?Q?q6NnliqB5NSVsrxKZ+miNBMNTNOsLS00JPKewr/brGesnF5/IxrDu4zEXCR6?=
 =?us-ascii?Q?R4sCavgGEWNQjehnY+4mFQ7iXbJ6ic7Vuc5nhBYySP6UvTGSGfOBDRNVFobS?=
 =?us-ascii?Q?d9Cnkp/k8lOiWK+IqFUtSnQDbGOHjE8Q2UFLvmCsKq5XFl9sn4KFlM91LAFs?=
 =?us-ascii?Q?kIFFO3azDlCPa56hdSdTsCOVhI2swfrdhwzFokvN7BcQvIzXKH5cYSNVfNBv?=
 =?us-ascii?Q?ARvch11x0arjLKD6UFpGkIR9Dj0EHQ1X99gsk4QnDUBSHyGx60xoDvuovDlw?=
 =?us-ascii?Q?u7DH28xAFF00Fz0hdevnBQPhmQjxrmlz/Z4LXYGd1CWGhTW+I2Ec9pv6qUBV?=
 =?us-ascii?Q?IQhyB1kIBw9+PsrpdhXzk1KGrzg/1+WU++a6YCCWqgyXc1rDMkf2f7IrrnHs?=
 =?us-ascii?Q?G4BbPw6/mZjkqKkanJsWWlLm5TxwsXbPNpkS03W/VxSks1mmjCwtxGdXTJxX?=
 =?us-ascii?Q?liy6KlNUpnPlCE9TNe0K5d2r073sB2oq/quqPZgvZtUxtIQHpJUa4SKNlJoL?=
 =?us-ascii?Q?+7qehpmh1uO9tTHNo+syV9+GrSwM4rN50oFV1Fhd1FTAA0bafjNE/n9IvBQ6?=
 =?us-ascii?Q?gaGB+kwz0tH8ofgtd/uuzbPxlNOGJne+Ad6Vy79PrijGa5hHctlrML2jsz0x?=
 =?us-ascii?Q?RFd/muczBHerrbXgxYUod3SEkA95QwFNubF3C2JqKmX23qRJhXQukTo5hkMS?=
 =?us-ascii?Q?KrZPPQ6Lt7vNsXNng0jn5jlt1n+xIPsY7VJqf4TK38QoPFqrQjaCMDlpwJCL?=
 =?us-ascii?Q?rx/muayxglxyKIndDMCKZlvFtSKF6722s9vSic4JfGBarM5Sesqv4HfINFeY?=
 =?us-ascii?Q?ONLcM8m+Ry5l3sCs+OOjlA5AKbsDo28rLOjo1JBVaUbo531L+CJuDFRcQwlA?=
 =?us-ascii?Q?uvuJGKF0zgohEUjpR9g72GtAENXlRFT6zv8Bxg4fN1pPG3G54BVXzQjK9kkZ?=
 =?us-ascii?Q?FtBeD15XSg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2150f296-4bb2-4703-19e2-08de9eb853b4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:39:25.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l11t/GwrqMlW+PeSZGHq3vCMQoIU2ooRI9MA9k5JyHMnTka/NDJogrZIrJR1yEunCMfAToEwoAVkHc9lH8eeIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10045-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 5C65C4285CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:25AM -0500, Nathan Lynch wrote:
> Each SDXI context has a table of access keys (AKeys). SDXI descriptors
> submitted to a context may refer to an AKey associated with that
> context by its index in the table. AKeys describe properties of the
> access that the descriptor is to perform, such as PASID or a target
> SDXI function, or an interrupt to trigger.
>
> Use a per-context IDA to keep track of used entries in the table.
> Provide sdxi_alloc_akey(), which claims an AKey table entry for the
> caller to program directly; sdxi_akey_index(), which returns the
> entry's index for programming into descriptors the caller intends to
> submit; and sdxi_free_akey(), which clears the entry and makes it
> available again.
>
> The DMA engine provider is currently the only user and allocates a
> single entry that encodes the access properties for copy operations
> and a completion interrupt. More complex use patterns are possible
> when user space gains access to SDXI contexts (not in this series).
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/context.c |  5 +++++
>  drivers/dma/sdxi/context.h | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 792b5032203b..04e0d3e6a337 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -15,6 +15,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
>  #include <linux/errno.h>
> +#include <linux/idr.h>
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/slab.h>
> @@ -61,6 +62,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi_to_dev(sdxi), sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	ida_destroy(&cxt->akey_ida);
>  	kfree(cxt->ring_state);
>  	kfree(cxt);
>  }
> @@ -381,6 +383,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
>  	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
>  			     sq->write_index, sq->ring_entries, sq->desc_ring);
> +	ida_init(&cxt->akey_ida);
>
>  	err = sdxi_publish_cxt(cxt);
>  	if (err)
> @@ -406,6 +409,8 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
>  	sq = cxt->sq;
>  	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
>  			     sq->write_index, sq->ring_entries, sq->desc_ring);
> +	ida_init(&cxt->akey_ida);
> +
>  	if (register_cxt(sdxi, cxt))
>  		return NULL;
>
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 9779b9aa4f86..5310e51a668c 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -6,7 +6,10 @@
>  #ifndef DMA_SDXI_CONTEXT_H
>  #define DMA_SDXI_CONTEXT_H
>
> +#include <linux/array_size.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/idr.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
>
>  #include "hw.h"
> @@ -50,6 +53,7 @@ struct sdxi_cxt {
>  	struct sdxi_cxt_ctl *cxt_ctl;
>  	dma_addr_t cxt_ctl_dma;
>
> +	struct ida akey_ida;
>  	struct sdxi_akey_table *akey_table;
>  	dma_addr_t akey_table_dma;
>
> @@ -75,4 +79,24 @@ static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
>
>  void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index);
>
> +static inline struct sdxi_akey_ent *sdxi_alloc_akey(struct sdxi_cxt *cxt)
> +{
> +	unsigned int max = ARRAY_SIZE(cxt->akey_table->entry) - 1;
> +	int idx = ida_alloc_max(&cxt->akey_ida, max, GFP_KERNEL);
> +
> +	return idx < 0 ? NULL : &cxt->akey_table->entry[idx];
> +}
> +
> +static inline unsigned int sdxi_akey_index(const struct sdxi_cxt *cxt,
> +					   const struct sdxi_akey_ent *akey)
> +{
> +	return akey - &cxt->akey_table->entry[0];
> +}
> +
> +static inline void sdxi_free_akey(struct sdxi_cxt *cxt, struct sdxi_akey_ent *akey)
> +{
> +	memset(akey, 0, sizeof(*akey));
> +	ida_free(&cxt->akey_ida, sdxi_akey_index(cxt, akey));
> +}
> +
>  #endif /* DMA_SDXI_CONTEXT_H */
>
> --
> 2.53.0
>

