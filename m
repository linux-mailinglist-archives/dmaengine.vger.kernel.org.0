Return-Path: <dmaengine+bounces-10330-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFTxFO9AAmp9pgEAu9opvQ
	(envelope-from <dmaengine+bounces-10330-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:49:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35E516028
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A77EA3009F96
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E173A7F5E;
	Mon, 11 May 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aFzYkYjJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD361E9B3D;
	Mon, 11 May 2026 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532524; cv=fail; b=G+0sMHnB305n2HtkeV0h1CMgur6FbO8eIorQETeUgHE6dSVzvxuPFM9EfN++YuvcUqpp/aKzlUGcJipd+gS2J2lQ2k2THyubLVb0+brMdfx55JabkOiVRCuUDnahogacGQN+o3ETn81o35D71K2NaJeqsROSE6o2PiQPYAHwOJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532524; c=relaxed/simple;
	bh=+tXclo+ppUykjprFpEiMYALD8s6GXqF++9FRB9BqvhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lztYKiTggBfm1t1eafa/I94bsYi1LGh7rhUdUso0LEJraycTmAaoE/dNmp2q6nQ3tBqqiZCVj745sOhY1Ro0uNoSlhG+fhVpNhRrlKgxeE9Rab35VuPHm9/JJWYBzwfUEonz6wxFSsI+Kcum4dfu5wr7GyWZbi+2ftvKvfwnAMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aFzYkYjJ; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM82NETLhr8YFWwNrmrjJDXx8tQk5FRsOA+/k9BY7nGQxeyh76zmRZbyUkF49ySX7YRyci5oweC9z7EiaaC14dim3q7mbAorhFZFR/GNvnpJfo0xVRjYC8Fnx3459ejWmlbwmAByCA9G8Vtafwm54MQ1Vw9c1bfRilojBroe5rc2cgJCmuVqrD7FVCrPOG/1Qhkvvn1hqKGzw24I3GFkCrTeHnHoFHVoucASZJrzRsm11jVJjNh1I30ZEI4N/L8dLGHxCi6zBLySGFc8+tUZiGSE6z5h8+UUu8We5dWz17Pzk8lNdJU4DkLEr0BY4Jrk/ki98QlkBbo0V+tRcOBROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYPtON/LmnTA8inHJVDNlT4hcWivyktz3mbqR6c3vcc=;
 b=sB22wPcwWODW519Aa7u0jhr5fNV2KCxnmeQ1Co7WSOapIXQ8VQFcX7TEzIG6JGcUSChdpNInTQ5pGYM6IU6WLIkSWNwPjjE8kv2QKLdsqmsERS+n3iqyyTlXno57RGwnWJSN/9w49GCazWzgvxb0CK6Nc3hz5MnF+suaZLVXi2dCnmwahY/A14ZS6i4r7lxdB1et9J6R11HAE3SO0Xw2EX4x0rk5LPNUnYiaoHOWFs4Z3ERQZOORSJ18Zede01jMNixN/2EbV5w7DfYNm+twJq3qMQlLNEZpkdmZlvW9tyrWQfhww74rX1waB8te6U/svPvRXu+BfLUOkvUDnlL2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYPtON/LmnTA8inHJVDNlT4hcWivyktz3mbqR6c3vcc=;
 b=aFzYkYjJx50jQ4eM5DOWi2VpXE2YOzWvBq6bB1T6tOWBbBRjApj1WZhvcMgmnTekEVxQQDOlsReVL/GN2qpRIlyVjDEGNKcl44R/CDhM1mQ9fPvM0VDNBJ0HcqSP0tzmlMtpIDB5LNhNI+/RY4mvxop9qafgQ+yN3RAulRJYFLJTvNyZb4bs6VHRgHLdff86Okjjrx7gtqAm/aFSIq615D+C0SR+q/7XFUQ/lmjjEZvb56zrzQ+mDS9xEe1DpKATiVJii+SJs+nytsS3K06rdgNehOXvfvTG9+GolYfTyvHX4wPTOoiqcp16jsOfAM3dCcU+ARoMoNphT9fU62NOOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB12274.eurprd04.prod.outlook.com (2603:10a6:10:62b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 11 May
 2026 20:48:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:48:41 +0000
Date: Mon, 11 May 2026 16:48:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 01/23] PCI: Add SNIA SDXI accelerator sub-class
Message-ID: <agJAoLioFKvJ-_6H@lizhi-Precision-Tower-5810>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
 <20260511-sdxi-base-v2-1-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-sdxi-base-v2-1-889cfed17e3f@amd.com>
X-ClientProxiedBy: PH7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB12274:EE_
X-MS-Office365-Filtering-Correlation-Id: 3528ccbf-bb2a-4deb-44a3-08deaf9eaf0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|19092799006|11063799003|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	v7uu0QeMPIgLIsN6l1updq6+RLiC1vwBQNGe5+Bh5jJQYK+jCoSkVMBf/LvYKJIl5L6tqv1q4gJgE1RpDLW/dbrn1HeTx1FmGk2fqR6GIbVf1JNl1Y5+2gMMICwl+A1lPmRaKrAELyuSVSpDtqDbuSUhoniemDSA+gbrobLONt5gAnnUyiPboX9YyJuMykJdEuuamnWls8V7VeG0LZEaXiTeHPlUGpEgzo767dnfI3/Qph5HfSpuFUoaxXAdoOhqjpxv3VHfvpz33RcY0LEN08CZ1/qJFBViraPIC83Or2VIo7YIgjsMO6f/32edDXl8Fk6RQrhzidoMarLdCfn3NP3pLPEkZwjjK3mu3LFe32L78hD2dNX04zPApFbXoqZeAv7UkTHMLPJ+RhkgEO+kChExSYZPMlLmWjCjAy41g3TTeSffZznxrrJSbwa1Rcjza9B/mIXI5R+3s75iWw2G2JkucRljCg7UZP3q7Ik4i6LUqB3UM3obcW+AmgFnq6+ANcEHUINULalGy8TNWYzPXMNApj5x9fnyPdY6cYMW7oxL1h+fRdWohKmyngrwk2R56yr5GD64OC7ENwOB3NKQkjuNeMpupNA8Fdf6YNhfoN8Fw+XgNp1uum0lUzemqXZfePgWvB8oPuvorU3maCJu2vAlpMnn1IGg07imZ7MGjt4X9VLIqAdpkFTKyxIPwb05CQvnx9mqYRMk2y2aXym+bL1aYUPPI8JoP+FYivGXNQiE4ZzIi7gQUzJttu/Gx5iV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(19092799006)(11063799003)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u90i39LwSJUswNCF5Bd4yOhZ4W3vCOcBDYAEYs4xCMaoOb0qgK8p4hPG2GO5?=
 =?us-ascii?Q?Kx9PPfifTl63GdlfBIQe01grtLu+XM+NhXMpwMqN0samhh1OCaenofNuLYTi?=
 =?us-ascii?Q?NC34gDyrHYEeDy/vXPSEAsEpH6aWXuYSfN/agHaaKd0um1SP0qL+07Q+tqV+?=
 =?us-ascii?Q?GjtihN0OYVBjEr2iZpxFyqv+iBcBZMGlYM9WS1DaizPzus5aSRYSHEda1cQC?=
 =?us-ascii?Q?JNVPZE07yNcnbDSN18TKA4E3oKWH5DyhE4DzbX5yMM0ZWt5rG1edjaktI2vr?=
 =?us-ascii?Q?z2HH8BOaLV4aENspr3lYiqk9AarxaMnHu5SIv/qUN975ZVZ4CwtWrvGhhKAf?=
 =?us-ascii?Q?4RKLjdE70cjywTJ75nlH91vqassWip58KzJXpo0qDfZnVvdtxAim99JYE0LG?=
 =?us-ascii?Q?0QIrGEK5DNup9ajWeZqz6g7VahCfFCCsZGszC24L1Q0ly6mYWyf99WD8jYhL?=
 =?us-ascii?Q?dkA7wanb8FFgW0IpYKjDtoE2i6Z6t4w9IDoeONd2/g2RZ63Ot6GjLI9d7KnW?=
 =?us-ascii?Q?Hi4zenYK1626xW0yhHyltp9WLCPrsE5pSxUYotm86Cvlu4tATZvRIqfhKH0I?=
 =?us-ascii?Q?sVfokKmcO8HKmNQneWBG0L3U1961yCp2kWj//GSiOKVZZV7/9p/vj/8uxJCd?=
 =?us-ascii?Q?BWzSV+jxpfhSgQYMm0XmwZQK3ux965x//9lFAqLrAfRpIAacoUyCzTx5rvRK?=
 =?us-ascii?Q?lh5V52/B4nyy9nXyXulzmqiyQ0FFkWe1xTD7l8c6mguBtJb7Vf5GYyXIeqZF?=
 =?us-ascii?Q?J9MAnRxlih+xZSLGMz96MpfOygGNCru+fJrUnsNVV79dmPIu+mgLBugaas2g?=
 =?us-ascii?Q?wmft3H52sCpHDEqZWqLqU/qVArcDPbf0/tlAttCza/DTwcg3upX1ru6BgDfh?=
 =?us-ascii?Q?wQfY05HiZFsTGKch0WNgSHFQZci/4Vsm1/ZJgPpwoTC/Jn7WmGJIK/VSIQgM?=
 =?us-ascii?Q?xw/2mnidS1AU4p/IsaO+fg+W27k0mJgQWvkfXHK1lUIP1JpB/M074Fdu8tvW?=
 =?us-ascii?Q?VFu1wcniNu0uTN00D7SHXU85vQjADGfEVXSVPIEFbImYWCVWvSFOt39ALYrK?=
 =?us-ascii?Q?RzEAxlxB8mOE0gQ3vscgRCggovm6cnPCHMnNCeXVD/YinlV3FeXgA5Pebn47?=
 =?us-ascii?Q?3jUifxTzUVapxCZ0qQWqqQTDQ2U54tdHKu5BYPtPjDY1Bw10OAInbqoXB0Hy?=
 =?us-ascii?Q?UTsCV93Kr3Yh2bWx6iWXntVXcK7EwoZFtuX83fw3U8yBIxuAhRK3s7b7tccO?=
 =?us-ascii?Q?i7Pw8YtKbLY3i61U6+x1x890tP3mqrgQn6i2PLzuMXa7d/6I/7pReeik3ow+?=
 =?us-ascii?Q?yKt5jXzJetaAxLJz2J+DINX03G8N3STheKETTV5iDcmmJG8Y4xOXFbeY9fV+?=
 =?us-ascii?Q?KemfsNetPJHc2MbpDX8y86fDY+t+cqpXpRvu9n0GEZeDLeiIcM3qrk0jBAKa?=
 =?us-ascii?Q?sI4155dBLxcx7bMjTq3gvbx06k6NZLE56uQjE/RWCFTGFz59IOAQshRIRxfR?=
 =?us-ascii?Q?eHUPxf1cQH89j9uCVeRaTBdRPRQKoiqjDubaBZqZwqe0uZthktFFRSdYTzi7?=
 =?us-ascii?Q?WxdmGizuX3tgAT/HEHZre8uk5ZDBSOoi5ZmXqNWac3WRTt2VrmrLp9X//bwJ?=
 =?us-ascii?Q?wtiHCD+p+eyU+oDMVv3HF1UKqcviBzb9O/yohi9ZFirqUYT6DGUEfjJi5spL?=
 =?us-ascii?Q?W3j9chPXLXpCv2L1c4dswea/5MYuinVQp6Dq4tjqMnuFtX6mqMbDuQ0duSBi?=
 =?us-ascii?Q?XwRbyy5hLA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3528ccbf-bb2a-4deb-44a3-08deaf9eaf0e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:48:41.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F82DHkAvg4jdNjqKLtCYiV+W0S8vagwg10IWlb/PZwYZ7DOmZCQO739b2JB2Pzq4TT6NOWnIic4yfN26Eg1A7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12274
X-Rspamd-Queue-Id: AC35E516028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10330-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:16:13PM -0500, Nathan Lynch wrote:
> Add sub-class code for SNIA Smart Data Accelerator Interface (SDXI).
> See PCI Code and ID Assignment spec r1.14, sec 1.19.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f66e4b..83ab3f27eb5a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -154,6 +154,7 @@
>
>  #define PCI_BASE_CLASS_ACCELERATOR	0x12
>  #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
>
>  #define PCI_CLASS_OTHERS		0xff
>
>
> --
> 2.54.0
>

