Return-Path: <dmaengine+bounces-6975-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C8EC03EF7
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 02:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F3E189833E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BD610B;
	Fri, 24 Oct 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YpwzmUv3"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA210E0;
	Fri, 24 Oct 2025 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264419; cv=fail; b=sc/Axad/3MTF7PFCbnAZsPTn5khFUg8AhZJFA4V1hHYtWJ1krK7qoX+dmfWEULVy3TCWgtWaXDgiH4NUyo5GIsxfA1Ung5Op5x0l0psAqBrpTAt2dAfghG3TvcNS90D+2V1IA0uN0TZAXPjmNrPY0FnYtWZWrIxwOUTuNErFT1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264419; c=relaxed/simple;
	bh=XzobeZJSsiX/hO4Rt2kfJFnMxcK0gTuMXzmPvbIVpL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7RpjuYoqKq+DD/66sPialdnWzmj/zWql1ABe13ltPUrCRfEvv1o63xhwCp6/MEMpYjqO1/M+KkDLS5LvQK+kf5jDzq1X/+T4UYGCbLMn4nLI5m0Y/DhIk2nKKiKua8mc24WMk3f+t329h7vnqe/mSvZ+tW+INye/y8x80WGmU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YpwzmUv3; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU6Eh7x8cn37c9HOXZkO552XXA3S08d/pLuvCPvs+isdu4rI8FKJdVOGIx9KjEkb0CJYOAvVKBiyZWthG+UxKupfakB3dVssyk9U2oL1zmDnBHCV49rs/SD1eVwPep/nie4ElfDJPYvv/0xdv9QWNFtgcEOOVpsRaxpY7WSwFK4evQGMN4Ak/PxJQ/IQq+sctycPQ/IDSfNOAkdC7A5DJyXgMnBaMGe2ZRSg3qRI/B4gLaJwDNouWHY3MkOMxgai1iZp+EBTZ63wg7YFIhVMgO0Dk4kxa19UXoPbBSWY7Xyk25PTNMxtCOOTeTUJ4CdCGR5Y9Ypf/wUi9e7H8DfwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WBooeqds4HmgDLsfYMAmi4XevwhgIrL8mLtm400p9g=;
 b=U1CQIROtoToMNGqWXzDIVc7j+xGYABLPFWhsoF1BLlRP2bRtptOpq586hRk1PLSS0Sf8GogEcvDTo7QKXVrQFyKIHxzfPsHW923dOkc8vD3coE4t3ZmKlph0Gk2QDkhief69C0l15gFwq8dl86VR0UgxwQClDvcTyYatCGT9r1Gw7GX1up6Xe4gjhgwERQP4oCBI1hnA0NKuXkuxK5rQLltDWewDCrKlJQbDvqlr5LrsFFb6q6PiZx+SsPcnKyH0ABshJU6gFsCKPK0UnhuhV6PURfo5PAc95XJV+zCj9+xarBBpbi1ZsASWMHsDlI8jakOB3y6Hss7T+0ZCz/tmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WBooeqds4HmgDLsfYMAmi4XevwhgIrL8mLtm400p9g=;
 b=YpwzmUv3ajhu4Fj/+ReuxN2CVNojjFKOFvsgmOAdTuIlcxD42AANWuegHlMfHv+mcDVJuUzofRuQ6Vif3a+/otJ3lNCDkI+aDKK9EqoE5cUMFHDI0pxJV0OxCjyQTeTuNd/5GrbyMI01O/g+nYVgxT/MTokVcYlem91w2KMWoTlVgIKsY7OMDqshV1V38F9eEYiK2G79j3Hc64Lx1NqdDFAfWG0jwncTWBgyWV66ODn7dxL21+N/zlJgbLOsrMtSc6Z9TsHUlbmGZtI0x0RMFisaJbruIUsAJn26tQ8ylqmwNTuB65KjDGF/0XhrAHF/n8T0rSUYQVd+3mZ0wGFSGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10474.eurprd04.prod.outlook.com (2603:10a6:150:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 00:06:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 00:06:50 +0000
Date: Thu, 23 Oct 2025 20:06:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 01/25] PCI: endpoint: pci-epf-vntb: Use
 array_index_nospec() on mws_size[] access
Message-ID: <aPrDEE80hSLbL57a@lizhi-Precision-Tower-5810>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <20251023071916.901355-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071916.901355-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0176.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10474:EE_
X-MS-Office365-Filtering-Correlation-Id: 352bd1e9-645a-425b-a0f2-08de12913af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Mxki5zC9hf/cDqrRfsa6DkkHV55veQObO27K8yr5gHqJ13J7fl0ZEEv1UhQ?=
 =?us-ascii?Q?S0cnTIyI0933HDeyxMwP3VfcWsrRpwECyZi9i3YGzCZ4oV7ztoHLAym+boon?=
 =?us-ascii?Q?gflN3YtlZFdZOvgi/FloyazLyfG+DzkRGwDmBMuUYZq6r1teY4s6aF50D5JA?=
 =?us-ascii?Q?NmqjxONDfK6h6wydhkQeVA15/tmyzcFHEEHuaoWD1VYM4Oa0D55boemlqPmh?=
 =?us-ascii?Q?7TyEHW4zFMewLfh658nknsGUX6g2jnEeHalLybHRjRhSxZLLEb0HA7Q0t6Q6?=
 =?us-ascii?Q?/uHFVe5VTt8bje795ucnbWMnrNZ3JU5WyFZuftuRPWZmMdtuOo9vCfuFlbzw?=
 =?us-ascii?Q?FE+0myxAQXyTIYfFoyr+AFvVw9FiTnprakgF45jmKxWQXCX54vXd9e6OJ9V+?=
 =?us-ascii?Q?Ocl9F+Pbr+74uWSndWIEs20pTWd3wEW2Juf2bntLPR4nqA8Zrq/RcnVd2OLo?=
 =?us-ascii?Q?B8CL1Y//aR+IACQYYttp/03KL1yM/M2At126rPYOfuCYUGZSM2PnqYljk4d5?=
 =?us-ascii?Q?ke1ILshia0WXHOrzA/cZdum3JTe52RtRWgcDWYe2VZdwqW+A0k2VzoN94LlD?=
 =?us-ascii?Q?9KpjerzTRPLbvhRnOn+VSeW08B+JjnKOauvTNaAmnnjqgSVdfK2vNbYDV+2K?=
 =?us-ascii?Q?kOIVe8ThUg0jVLmqQIKznjlYELoGQ5rK8grWdagyQ5TRKdXxp1ldVMceY8m/?=
 =?us-ascii?Q?iHikqMFOfND3m+eQE47ajLLAGrJD/JpPfVIdfAhbi/W9RhFy7jDsw9OncKMe?=
 =?us-ascii?Q?XVm3u4d7Eu3k/PlKCNEHC4ZlBcUFk9kwVC/KiVsRN1QOmS+45C0laVsNmShG?=
 =?us-ascii?Q?FQ496KGg4WDKSlpqY7RbJfEDKsOWhgku9Ql8njbNOmRwO1re0JAsySpOPYY4?=
 =?us-ascii?Q?s10SaFA3PIr5KZ1ZiqnGwOcoGiE9qLw2qQp02b/mYgsMCyAMjDnsRL6mFg89?=
 =?us-ascii?Q?MBNanssD12mwCuj00Y7o/b58Vq9+lfkpXRMC4RTxZ/32sxzrkJ4tDqe2nlTG?=
 =?us-ascii?Q?s5tSnRUVulbUQs48SUFqNoLekFJ7YVrOgVyhXm9WswYw23uEo/IvuriN3G29?=
 =?us-ascii?Q?u80XJTRfcDX41k3IjuuaxIg9v1+zfP6EtXDzU6yfLDs95MG8pmkitzqbG3NZ?=
 =?us-ascii?Q?S5WFxftbBVunlAvqgsNEC/LSkYxqzUD7RkA89dt5nawEuiouDDjUS8ZGpur1?=
 =?us-ascii?Q?+jo8SAN5RT8gMF8odxDeGIGdamw5nBvtlHbNfk4dGX/hocTls+er4k7IcXzi?=
 =?us-ascii?Q?rHhq5NizQljs6woxKjHRZH+4rgj+5GuQjYiUa+9lW63tPb9vPg0e9+CyBl80?=
 =?us-ascii?Q?rpcRTv7JHCZ8RBVSGWFb1pH1YKjoKSKKtweMnpwgBozlRnuWp8Zztp+n1S/x?=
 =?us-ascii?Q?HJfU5KdzNBTdaw776kHoIpHZxbcCV5lBwm4qCtGeKms7dxiWAkDC3ncLjLa+?=
 =?us-ascii?Q?9gz1rW3T0LC3HqcMR56MLQlrsywAFhdU7NuK49Fn0gYccT+88Tu/+BkeWn8J?=
 =?us-ascii?Q?JSLJ1dzXh30jDVupCAqeJuHgHD3qda0jTqnM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGfKjGRrwyhKVlDBMqYBhxGv2P42BQE6GiJh562deOWp1Ly3XT/k+pJGjnbM?=
 =?us-ascii?Q?yGOBl0r4C1q4fpLyratAKDoLsz/RfciexR2lVNRfI1RqNS+6QvUXQznY0boz?=
 =?us-ascii?Q?P4BU1W3Pe8f1H+l/bHtMg+WGZldErWcoGtYEyj+NTJc7UJvqeBC4Ldx0EnDZ?=
 =?us-ascii?Q?QYhctE7ENLvYoAuMwodhhzuxuaIlGw/IoNXY6XoOz2rkspApCTcts00l9XUH?=
 =?us-ascii?Q?rtefhmGqGdMaHVIfjJwRWrwWuMIhtroLypMh6JyAkeUvyV9AI8b0PnE7gC8i?=
 =?us-ascii?Q?+/oh6FUxmZfoD4q17UimoaMojUCIVmVE+FF8EMw1WPeL4auqmN7+fmpcPDoi?=
 =?us-ascii?Q?7qIyrFe8DHtyXC7VfLO94oK8nO43pxxQ9wAszQ/yOP9SB81LYUqKxog9rJeV?=
 =?us-ascii?Q?QXrRtG8oE33/Y3Lmh/jQ6EDqh5NlehE4MSO+h8+bs0Wt1St2lmazpcuK01CG?=
 =?us-ascii?Q?dwyk+N9GLJOTnM95eSF0c7LDl7RjkhARbGqdmw/QJd0PhHhhGORpQ+S730IL?=
 =?us-ascii?Q?V4NQh0xREJMa/vzX49zSbcowWc3y1GdzQKloNO8L94pGfZ6Po1cLPwYBIcnz?=
 =?us-ascii?Q?8d9CUXdbDODujDsqPGhtXCxf7yir7wXQA+HBYr99QEjy402FJehRje1K+QKy?=
 =?us-ascii?Q?6V5/IeAqjQebaYbiwlBXv4pzasTaKa9hMFnMVye+dv+2XuOeMppecR+uI11w?=
 =?us-ascii?Q?chCDnmRZ8o1gVk3L7Kl6eRyZ/8sNue+txJqXGtcIDW7uO3oxNfZ3JnB4Okxw?=
 =?us-ascii?Q?rzvLpq6ZrTXenKQyNP6w/1nO/oUyRB+6jISOjxnVZMccZQInRgAvj44bYGou?=
 =?us-ascii?Q?/Wt1zRDhi9ewmVC7TE0BxNT8VNuzQkF2WnUY+HMJtlObpkBp88PfYOK2wru2?=
 =?us-ascii?Q?5lnNSt2+Nn/W5q6Jb4Hir48usTbmAw5dPZTgBgZfOwJTmN8qb+OiR5eeQ7/V?=
 =?us-ascii?Q?LlJllAECPihrccoiz03aWD5aQJCfSkivkct732ecepgqHFRKaCbWr2Fe99ps?=
 =?us-ascii?Q?gns5BJQ7JZ1vzRzSW8UpA053qbiN3CaRsXSrLWpbhJrQwFQ9kdOSpf2ElhRa?=
 =?us-ascii?Q?N6f53M4UmSs8mrM/lsCNWydlmI1c+DFsq4YMtZXRPqQAWwRjSr+gptB8KOPH?=
 =?us-ascii?Q?O5/gtIyrCt3go1R+buouI3nR0k+iCpm/xITI0HIi72b96sosP00MVWMlfLUB?=
 =?us-ascii?Q?dk9zxTvbU/4CW2Jgb2zUTQXjo8ZgBkv2x7Gvg6eSwjvr2eMViPGb5w1+Tcvx?=
 =?us-ascii?Q?8YkVwRKTaRmh+KFPTRVSqhEbcTc2an49RQ7Eqnk1gVp6XuxS17ex44lcm4ip?=
 =?us-ascii?Q?mrwK93Y32hsR0W70Z1BEnePU25FmZgoaddsn5yBX/9FwhMjUdJaYYoV3kq30?=
 =?us-ascii?Q?EzPEbumHgpF0oQvF2TVcHoZS4nG1HnPENElAsjb+Rx642ct7a7Q2OJpoQU8p?=
 =?us-ascii?Q?XtBw2qpqrHD3y11uia/bBJhMNHVMNnviE6MXVv0VxfeVp7OZqUbnTjCj0UBk?=
 =?us-ascii?Q?mV2kBmdeA4QP8v9O/z7XsGX07AnAix6QpQ3F9AHa1AM1R9d3k01yj/rymh8m?=
 =?us-ascii?Q?8QUoLXD4nnCqckoU7Zw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352bd1e9-645a-425b-a0f2-08de12913af5
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 00:06:50.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eevke9gtzItTMqJUV2/vPpyp8LpaXc99SLdGMVWOZDIvJCVa1EQDoSub7don7NbggyxVjdw4tkFZy1JzK3Z8Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10474

On Thu, Oct 23, 2025 at 04:18:52PM +0900, Koichiro Den wrote:
> Follow common kernel idioms for indices derived from configfs attributes
> and suppress Smatch warnings:
>
>   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
>   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
>
> No functional changes.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 83e9ab10f9c4..55307cd613c9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
>  	struct config_group *group = to_config_group(item);		\
>  	struct epf_ntb *ntb = to_epf_ntb(group);			\
>  	struct device *dev = &ntb->epf->dev;				\
> -	int win_no;							\
> +	int win_no, idx;						\
>  									\
>  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
>  		return -EINVAL;						\
>  									\
> -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> +	idx = win_no - 1;						\
> +	if (idx < 0 || idx >= ntb->num_mws) {				\
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
>  		return -EINVAL;						\
>  	}								\
> -									\
> -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	return sprintf(page, "%lld\n", ntb->mws_size[idx]);		\

keep original check if (win_no <= 0 || win_no > ntb->num_mws)

just
	idx = array_index_nospec(win_no - 1, ntb->num_mws);
	return sprintf(page, "%lld\n", ntb->mws_size[idx]);

It should be more simple.

Frank
>  }
>
>  #define EPF_NTB_MW_W(_name)						\
> @@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	struct config_group *group = to_config_group(item);		\
>  	struct epf_ntb *ntb = to_epf_ntb(group);			\
>  	struct device *dev = &ntb->epf->dev;				\
> -	int win_no;							\
> +	int win_no, idx;						\
>  	u64 val;							\
>  	int ret;							\
>  									\
> @@ -907,12 +909,15 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
>  		return -EINVAL;						\
>  									\
> -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> +	idx = win_no - 1;						\
> +	if (idx < 0 || idx >= ntb->num_mws) {				\
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
>  		return -EINVAL;						\
>  	}								\
>  									\
> -	ntb->mws_size[win_no - 1] = val;				\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	ntb->mws_size[idx] = val;					\
>  									\
>  	return len;							\
>  }
> --
> 2.48.1
>

