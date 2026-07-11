Return-Path: <dmaengine+bounces-12349-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KBn+FUVWUmogOgMAu9opvQ
	(envelope-from <dmaengine+bounces-12349-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:42:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F4741D06
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:42:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=x6JdXSOv;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12349-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12349-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E60330041E6
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1400926ED40;
	Sat, 11 Jul 2026 14:42:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B0232395;
	Sat, 11 Jul 2026 14:42:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780930; cv=fail; b=q4yLE6ukCN6zmo+fwjBrbKV7616CVvKWtUo7vZE2vBo78okF/5p5piQFrovbMKZFOVz6aHaD8Yp3WIMIZrYW4ui3kWkbt5g5oHFUn4pRzPOHQ4Ay4pWeA4EBQwE6oiruyt7F7ZIlzukMtCT8mdnyFO5vd+4MTrP3gYKxfCJjzQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780930; c=relaxed/simple;
	bh=/dxyeDMz/qGpY6tq3VdijcqCpv0V9I2CNXNvBkO/ZLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxX9jfm/xCBOJbxrQcTdFKpeTSWMYaoeY5otVz2Cou1EKKBoaNhwJux0Im+vUDpVOyDZMst+PefbpizBC8ed9d5eItQJ+2z4dIYDfn5uZgqdw/bMw/xBLmzYro4VRMSeEmY+Ui5ZsEtBrhcSk6TlBnBDeYAtfLOYb3KF6fCvWuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x6JdXSOv; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/9j1taI+Dwnr4siefg56kI0E0Tj0RlPuyY2k4u8gSuVPwZXDR3RFTYTHrAix2GRfo43Dq4HWUvmERUXg9Y8OHknTc7MOxV5gk7dxKfp+TDTlefJkSW1IjtYklwOfYOIFjpYSdDcE7O4yb367mfnZehT8TQesi8vYdPao8y5DJX11Fo8iUMAxuA17BV+DgBqQ27zQcer1rPHUqrk1CJFhAkVxq4+Fv0Ek7Tb9dTmzm+Le5FOkJY2B1k0uJXc5v0Sab7zCz80bIqfIzjDIsCXCQTQSpkfOz6rQB3b2hi9pgzhPL0UKq42nLVV7c7hkn+pgmWLWRq/OL7zZCOW6YOvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXkYxVU0xfmJuc5jcxwPFEPTBdu0Z0Lu+lvKKsS4s3s=;
 b=ZNnUUS0lBcWMYFxob2Vr+ycp2xCCjpaiLbMmwh/YCxAd678uhxNOcgI59wY1Ukj1f/80fP6ctvTSQ8fUfBkmPjMMeobkfxoHdlv+R5VA1p+WZdkDFPAm+Iuk4La35m5slCKVleLaBv21yK0bHSMtI54gec9/SgplCvsDW2g6avwoUGkcykWfEr/ND6l/tWLNJshMpxary1Q58v4kG41sEEOoeNArYHCk29EzVN3Y6F4At7qkF0bQ2BdwpElef4/fpmao7MKdtq5lHNoGvayt9NjMBIhc3vYbW5JtJ6Ye0WyzW9UcyjoDTde2B3liTrRqo4bD0FI5pOcDd5ULnh0bxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXkYxVU0xfmJuc5jcxwPFEPTBdu0Z0Lu+lvKKsS4s3s=;
 b=x6JdXSOvj/ChLXuIqYiJp6ijSIrgcCTbrUrNnlh6PVBb3e9hJYwircfY2vYJWZgbpqAZUsVczhH2wFefwQIYDjuYVsXxZnHn69rEQxMwNQmyy8jRYDivwv5iaptE0SXfhRR/kiV5s76abrHuwIDZ/8P0UnMB7Xk8i56eXnSVKdo8cCBD3HiMaFXbWDeq3taROBjy2BAgDdHSNRWu/9vivWVG+eHnQFK9X3C7b2BTyS4jPXV+gyXjrf9VUoGzy/pVxz1TsavT3IGYpv2xSHtLn7kCVr04WYB0jzAk8UN6L9aWDtCVWSBk1QflzynVca8jx6YNiqXtBjXlf2loXOEMBg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10282.eurprd04.prod.outlook.com (2603:10a6:102:464::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 14:42:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 14:42:06 +0000
Date: Sat, 11 Jul 2026 09:41:55 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dmaengine: dw-edma-pcie: Drop redundant
 pci_free_irq_vectors()
Message-ID: <alJWM1oUwCuLAhqB@SMW015318>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080903.2392888-6-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0186.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10282:EE_
X-MS-Office365-Filtering-Correlation-Id: d52168a6-8672-4dae-2e92-08dedf5a9418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|19092799006|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aYayNnAXyq10l4TC0GROC4IFlzctvDvlQ5fB9mf0W8I3ZvxnP9B6RY1CaBANcA8qQVqZOa+oBXkAdApNd5hjGNWxiVm6ifY62pRvNfBxBPvfpT0K77qq8zi3nDPyHPjXq8p4vi8bh6dHOTuFEAzxLiivcbPoDMvzLnyD7RmU/ZdjnHzjdVo184M0474MX0vG2coMenbKI5EVHY5Eqw1UKC0GAu0ZAqLjWLHratFUB+FxHlCml8s/gbb1mB4mxpxK8dw8VOK8rbAXNOpLF0vKI3ffqWMcFM2MALOGxvDKkg5k3m6yV/Pemk1v2zlf84+zfhKuQaVCOROXJ9SsTLwxnYxax7DDeDzQ+uV4EHgdODPih8KNG6ePjuLlKBDmplepCBie8Ja3Hh2i0tDNXt5h325DW04ndkZQjh358LN9kVSHum5Bv+JffeTT7aH3yZhDO+ITMawuHfmtUY3vs0PeOWGl1vlQX4nmY3kws6bmw4T2yW9djaR0IdtiPCH+dtrQpyWLgyv5jqLZNYORUcDAX8WBhXlqexKhPpK+jSWQl8Gm2Z8VZogNZGJadBn0zSTrxbEUN/SUaKJjBsEVS6c2QW0RD2+oa3DGezJggBM8qZjz8ULBd5rS2i9jz+RMfucR0K/tt9/fpRORePGiJXYf4h3KOIwFRBiQ3cO16yQ18n4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(19092799006)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7b6i6QjgvCdIFc/Od1TXi6IuKCB3RuJGkhw7PxRwVYT2utS92ZEcl4767ej?=
 =?us-ascii?Q?6LqfCaNELPBE3Mm+0meNOCdI3Rvuf7m2oSJw7Vhiy3zA2ly1ssfvS7mZ610I?=
 =?us-ascii?Q?5M0SRHVXa+JRksmImAroI3tEpZLgsOi7+hRr96w9N6goa4HpgXi+P6Bhhwfb?=
 =?us-ascii?Q?RC/qEtfycoomSdweKaNXLqariA+A06UfnPYVIbiBS/JkYwnaQIx0JihMv8KT?=
 =?us-ascii?Q?VYetiEPeTy5l7ipsBtqT7NAlikCrg5g/jUB/5JsOx0ga4xXs4Bq5OvHTdayo?=
 =?us-ascii?Q?QYLEv3K5+GgzDZfj2ODfDZVN7KunqNNhJWCcJYGBjK7PWicsIEX3Eh1Pe0up?=
 =?us-ascii?Q?7LGzT7ke4EzNxtUVx54OWhoP/Ci+0ZdBBSouJZmfMvwRQ6/DF+FeF5Woj9Jx?=
 =?us-ascii?Q?8WUAlPvqPNg+eN5r0oNUAPbrQjZ+EjHYVcLrmIZylpyaDNsFgqpQb7rkokQE?=
 =?us-ascii?Q?SFBTUKIpG44kB71KJc33ht5X5W66gUtc0UavvIj91epUpHwYBUadeT7OEe9T?=
 =?us-ascii?Q?wu7rveLLnJV7w5RsVGg6TCuJvtCEAbToDXhnRWdq1V5FHf+Q5S1BMSaWL6L4?=
 =?us-ascii?Q?q0pB+jyNz5yrGBB4BFhaEWjWi0uFk+PIRkGK2+nPPMFeP2FGrBwossnWUjAO?=
 =?us-ascii?Q?027NB70h1ocW4uU2mgTo6gj18BpzxzRIhnWM8gALwIX1QXnmIPXbFLrxC1mS?=
 =?us-ascii?Q?YYuD5WoXhh9nbC9etVQ5/LhellahQgo2ydUHArJssiewXblbXGwzbgq8s33w?=
 =?us-ascii?Q?FoYFt39DroV45ANz8grnYEso4w5Ap1Zbb65C+h7YZmdJ1YVvUlU8FIXUmBc2?=
 =?us-ascii?Q?TDskqfzFbflt0ARvvyVAWRL8FAPTYExb465VjhHaV3lzPkIGOWFPqv10Vp26?=
 =?us-ascii?Q?f36wfxJAnWYpv+d4B0v+be6H1bu9jntwF5wfnZmmBT2Vw42ViN5NGcSfwu4a?=
 =?us-ascii?Q?ru01C5fI+KJiaooVa5XL7aM7PpmDsu0mRxTFajPzsFx4O96aViJjc7BlVW3K?=
 =?us-ascii?Q?CeqqONiZ7+UzjL69FDMMK5FJo/iWtU97SIe8wlzmXXnZX2RVLF66wYC/Qapl?=
 =?us-ascii?Q?lpbiGNf/a0mLyKbZcnpVn+8kMn6j7ABKDzTlWIyudhjIbnoHk0TN8jkGFtC/?=
 =?us-ascii?Q?Blj0xs4aEqNaw6lWh+Zxfcu9Uib8YB82ILatpldWBxuBgrmdiTYPAQJJXm/4?=
 =?us-ascii?Q?bTWce7pao191k6Lw2ctnX+RXIuzNQhpAGemAUz+2JQeInLlpgbEgPo7/ooMq?=
 =?us-ascii?Q?Zj9KVVehHVE5K/qeSN4QOlusRV79o7jGh8cMCnWpND5P/TnMcoIAGucnjG1l?=
 =?us-ascii?Q?UxNu5bpwCJleD3i75zofZAGCr5xClnPKU+W7WII8NY4N20kj+++7kK9GVtlO?=
 =?us-ascii?Q?nuoJg9wniK2mJz6TNfzUX9ej3c7t0VcHhOWg6ZW+lOoHWD8waZWdgPXtkSSg?=
 =?us-ascii?Q?6R53WMewIxotwp8qeCjHIOyX6mhyjgqb6VnzUr8Q9t3pwmsJ0Kzre6iT8c9h?=
 =?us-ascii?Q?RGf1NfoiLB7/or5+W8NNwRQ7pzbuqHMGdhpMNz4Sa3UTQ7AxowuXcZlygmf3?=
 =?us-ascii?Q?521JLOdIwasCpckk4Fb/hG4G1634R5oiFeY/cWbRvw55vnFCzxaB9PuP+mtQ?=
 =?us-ascii?Q?jBsy7o/F9bGaVp2oVSkp8ThuBfF0HHd9bL7cfFOtWHoq9PpiVrla0rTC4QOl?=
 =?us-ascii?Q?JFoZk9+qLfJQytop0HMyWWe2PHyejYdlBn3vPDhO3P15dJxAkGJHAemBWgW/?=
 =?us-ascii?Q?PeFQV6jhV7+EOPJt2quGUwYAwFxyXdHGt8w2dtfyRc/z7Y6tpOLP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52168a6-8672-4dae-2e92-08dedf5a9418
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 14:42:06.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQtgeAKPZvlMREK6UNGXFkeYVTQ6q7Z93ovuuZeYflnnuCx0V5FBJl+PMhU6F1MsvK/Oj4ug3aUqBRvLAZLoHj9EuohnV/93wagsUg5lexMoLkkwc3CmCb4Vmlvrmud6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10282
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12349-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D16F4741D06

On Fri, Jul 10, 2026 at 05:09:01PM +0900, Koichiro Den wrote:
> dw_edma_pcie enables the PCI device with pcim_enable_device(), so IRQ
> vectors allocated by pci_alloc_irq_vectors() are released by
> pcim_msi_release() on device release. The driver should not call
> pci_free_irq_vectors() manually.
>
> Drop the redundant remove-time cleanup and rely on the managed PCI
> device lifetime instead, as documented by commit 03e4905402ae ("PCI/MSI:
> Clarify pci_free_irq_vectors() usage for managed devices").
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - New patch in v2, posted as part of this preparation series.
>
>  drivers/dma/dw-edma/dw-edma-pcie.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..5e81a433a957 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -555,9 +555,6 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>  	err = dw_edma_remove(chip);
>  	if (err)
>  		pci_warn(pdev, "can't remove device properly: %d\n", err);
> -
> -	/* Freeing IRQs */
> -	pci_free_irq_vectors(pdev);
>  }
>
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> --
> 2.51.0
>

