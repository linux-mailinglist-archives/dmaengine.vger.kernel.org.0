Return-Path: <dmaengine+bounces-7843-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CECD0718
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820E6308A3AE
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BC733B6EE;
	Fri, 19 Dec 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K76zcaq1"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96125A2BB;
	Fri, 19 Dec 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156477; cv=fail; b=B4Dddy/wyK+1i3azEeFH/kvzoG1DX9nkzjvyIwIUdY4wjECByZ+qCh+O7wbbra7cbEz5S0tGgMPjiRMp/Uc07P1rbDZt/V7b5VO4MtB0HmpX8G9Gjy5jOZbchO4Bcqbyxoh+2XCCZSTBHOGzYjYqth6KJZRSgKmApgIRHJ/27EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156477; c=relaxed/simple;
	bh=2A9hx4aQTBBjEPSEi27eY57iA4lQKYM2Kt1/nsZn1K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eUAhHIAStsETycv0psSnCnXfFCAKhJrJaCvlZrDM6I/0RoENd089LW98JTNinD9uaOZKIS623AcuJJzceJrhWOInY/Y40AB8Reqfdd1bB4uiJhWGvYjZjOxz+GqBBrKrE705qFE4PLipo8TT/VhG0L6NoPnq1YsgbFuU24Oqvxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K76zcaq1; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGMGLp8PXjg6qHoz92TT62sS+9IPfJBYl+38l7nD4dQEdRmzlH9p9V5zePLl4EiQkKEO7WFXgip/CMivDKcSxpM1kCpUfRoM+T6VwBetISbEaVHtFS/74d2SF4f9gJAFB1MsANYjX2H13qQxcAKfDtnuiAPWMzqPNZqIoGkl+J9g/Lw5yPEwQrBrSeJJxewkf2iV+wq61HSFVDTmqdCh8KgGyQHUAKsH/pbUGDmcfM2Wi4dyfdiJC0XZY+sT5TLWE1QdhiWlBCHHABWt9BnxHeRS2solQWjYVl4Bs3PWjwVj6oPtmGc51w261D5uXjem8WuA/nK8SFj9vxF1Xam4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwsPfaAnHMiwrkGiTpll4i1jhXTgLm0huu5qWL+nhNs=;
 b=YU7CHzbxdawiTh2qOl7YRJQssahS/MI/sdW/wB+bJrAxCrJKx9mV1LkxpaeR3GTY008lm9OZU6/FPX6hKff0Cu4uOBtgbieW577df7aDXhn23mHyX3iZW6+MWMaJN+vXZJZ5R5r7f10/wInvyICmOBTsdWV5W2vveOW1LgFcdWccUvYhWcAhCnlrsgkHGgpnlksUl4go7/GE5y+7IGlJ3a71TeGjnVInC9K8K72i7EM9FgU09vA9As4xYXCry5Npz0e84xOdaYwZF1aEwko6JBt18bUGi99c/OZKAviIVNQfJagli2tm+A0STCTw/yhLBgy0gpsHAy5FVHAYf2OFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwsPfaAnHMiwrkGiTpll4i1jhXTgLm0huu5qWL+nhNs=;
 b=K76zcaq1gcDhLZFcH/zuAnJ3i0MfXPMZj5WY5IFFWIXQWfEg6HpBR5n8X+sghuOk6IL/suRJOk0yqOerQ+saCoB+XTa4TUdBVujI9bkMKWPe5poflGYNiv1jgCX2xuYawd8YOCZPojPN6MOayzQNAWHBaVL6xVj52nG8Z8HvQ1Dg3kwqu50/AH/wKerN/oRwPdFaNNgzq3UIk3RJSuIPyxfAc6V4QVOeKDGXdgiH7f2e05FYnVcV/Lxnr5CXD4IFTkrQweXqy42qs0d+o8ys5YghXzviPxEbY9DzpZ84tHvdvKlSvAIutgCI9MiFUMgoUgfAs/icbKr5Dtf7fSgFzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 15:01:04 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 15:01:04 +0000
Date: Fri, 19 Dec 2025 10:00:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be,
	magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us,
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com,
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de,
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 26/35] NTB: ntb_transport: Introduce DW eDMA
 backed transport mode
Message-ID: <aUVopEgFmxsMIPpI@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-27-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-27-den@valinux.co.jp>
X-ClientProxiedBy: PH0PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:510:4::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bd2db2-1e46-4c8b-7dfe-08de3f0f6e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qw2dr7nx83HD5J7u67SwcCoAnmjNcoYx3VeNGBdxGht6ldu/bjdLKUZCD6iu?=
 =?us-ascii?Q?xq3xXv/KuU8xxarh0KYtWEuet5Fd48NxfT3MjLH7uWtq8U93Ye3Z2ScsqEoH?=
 =?us-ascii?Q?ucUuN+XKw3sJWhw2ZsOYNKvc1I+70PS60SaOZSDVQVtcgAvj/ml2kkV2rTar?=
 =?us-ascii?Q?pzkVnUb4TW62odohuWeuWE304NnZF/S/sp5Z0ittn96bqIsRE5UwOo1sQ3GE?=
 =?us-ascii?Q?UA9sBdYb+cgYFY5ufpzuIXsW6AyfyKcI9vLYL/pf8F8J5IEx7D5cFXNMkNFI?=
 =?us-ascii?Q?e1cE5fvJMgZMabqQ3uJqTPRf6baz8J9VtWBrUMNyCAvzBht7VcZwhnx/PsJF?=
 =?us-ascii?Q?lGSjQYujctOc5VzPnaKM6mbVHkYQ5Rs0m+ComkGcb4OqWkLX/gNvUiTCr+ij?=
 =?us-ascii?Q?v+uU4CEZdkI/zyLAHIUVD5GcEl1z9ryEUSUqqnyjhzbFLDk++rCALSwNQB7w?=
 =?us-ascii?Q?B6UqFAWGs2GYE+O9Tl5QdWK35QB+DPk9/JVyp7BEojS5Foss1oD/jt0LEgO7?=
 =?us-ascii?Q?6scRN7TqIp7P+5hJ9dOp4dgMrhvz2khro+FZ39fW1MrtGSURkdc/+rA7Yqyk?=
 =?us-ascii?Q?ihN23OfMP3Fl8oA6XTRGf7WH6cSMhHr+Xz2FAPoh0QtagS3Jm+nXt6JMcW7f?=
 =?us-ascii?Q?/8knsgvx+Z5QLTqYZM4kS0h/Ri6P/vfEHIjU7JYMep4r0LK9hqeDgvO0yZXu?=
 =?us-ascii?Q?JeCYnclmNcWt0uGbK+jpZIKJRICExTEDRGst1K8a+QQNzrACzJ4qIX2uGmAW?=
 =?us-ascii?Q?LsrEEXA71n7gyedyWgUHhb3p8X/FIy67eshCxnKoKG/kVoOe6h5HZJW28qQo?=
 =?us-ascii?Q?85Cdo5APKuS1gGBElVVdxsySKMvbIcM61aQefHOrEWcNMTctSA273wOaw3Nn?=
 =?us-ascii?Q?hovSbb4u254kpplhkxsME3pHdxmhHiZtaL7HL7+jp2GzPEqKp4n3A8Y7WIp1?=
 =?us-ascii?Q?nJjuiHFlvWXOM08HYD9l3jc9jBIZeG1D7Rv/x0aeL6hwMgUxYEHrFSy76t5U?=
 =?us-ascii?Q?4WBaFo0BsaD/EcM8KYrVjqRcTMvKuqfpJdcF+KVbLfcxnQJpDVsLNsJF3Vnm?=
 =?us-ascii?Q?Ff+hdYkAjxL3Unh5SkRQ70a/vhMbg3q9n/YMbxKCIg3WbG5kUGt0vc+0V4ot?=
 =?us-ascii?Q?nHadMcdMZVflvFHeM0rjd8CdhereyOg+D2RZn1DT0OcbhOtTXUsyoPZDgY3k?=
 =?us-ascii?Q?k0iFmePGnLbAR0vyeahdeT9EpHhpEwvTDLdIQzzf2NHtslnpGt8kXDxCYBPv?=
 =?us-ascii?Q?QzJAMeZuEmWvjAmOPww/B1jR6rBZfvaUBZrGWPe5nD+BfstjhpELsUz+59f2?=
 =?us-ascii?Q?zmlV44Ee+8V9grYd1ozsit7uhjRoRNY6mJnJ4J98Z3aZAlxbVFSBKydlIczC?=
 =?us-ascii?Q?GTj//UCjnqV6eYtuWoAl/7NE6sz6fo+Y8YnIUpGeXIXMCkpdq7hTp7MXs8AY?=
 =?us-ascii?Q?hZX7vNEhQzpy6c2NdOZo3WGLXCLlNkamFu/1XIoNkkS9l5Sah6MqaUHtcmn9?=
 =?us-ascii?Q?hxn0UvTQ9NRxZqNa6uagbxQdq3jwDPatVOKt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEWtojPRsCfiCymnn+WlZr8eq9mz8ZQlJ3eT2kLPHPlc2YRQABTRdjud2fo0?=
 =?us-ascii?Q?g9VueDUJyAxkR09dH1vLYiYRSvH3PvA1ASCTkhASwtZriQU85KCMAEr27B5M?=
 =?us-ascii?Q?7tWGc0Uqa7sJEnRQS98C+QOmXgBrdbAPdZW8CqmhWShwe4JSy0cgCWuvHL2v?=
 =?us-ascii?Q?BtmWOp08Lg5snkatKLvxdz2qhRSeIS5kUG8g5v6GIjf21vUJvci7hs7VaYlP?=
 =?us-ascii?Q?Y+anOs1hk5IZ4qqKjpr3UYHOKNDxOqdIREVdMi6LhFaaxV+TOEiqMVYT6kNi?=
 =?us-ascii?Q?SqRuoaXHqQla5VAnCb4NqaypdB1atbyF/Skq9TExPijBTzWjtT/fqGm2k5Vl?=
 =?us-ascii?Q?zCTWkmVMx76PpuM3L4JEU4ZPnRlyEJNIpwmbnKuRW7YeyA3b6yDtJgPFEVPz?=
 =?us-ascii?Q?fcknt3QFH60S1fIAp/QK/DqYYvrPJZzhJ1bf4l+qaxDHegAJH+xsU8qrs0/S?=
 =?us-ascii?Q?+q8kvmTH7062Vb4huENEsp4NMX0fFZh12hFUjZOFffEjK6VrnP6TiEJtNnIv?=
 =?us-ascii?Q?MTc4NVikR3gIrwoeRU7XNmX9ARns9EQZFFdR9JNOt2vIASB0ZuHWWsizjy1e?=
 =?us-ascii?Q?W++701jgRDownbOo0oyTNuLvLmc2ViJD9ob7aBvXN0dNkSvjTZwDissK+Y/0?=
 =?us-ascii?Q?6SkSw0FmQpYjio8dPJLjlpNQTVaf626Sidi2Z5tMGd8voqhgyQRtX9ifbw5/?=
 =?us-ascii?Q?T2jDDpAetYoiXcM3WZHuf0ala5xOGj84xbasbu5qwSzrABKJCG3I320/ksSJ?=
 =?us-ascii?Q?hD9bWoYQ0tXWl3HsHdJw/8KK92xLqMbg0YEeLE95SLXVTFry42Q7jST4+78i?=
 =?us-ascii?Q?ALnEkcwhB3UvUJeUMWmtUmSJOjz7H01ZctZ72vSo29QDy9pGhkKnB/2pfT3s?=
 =?us-ascii?Q?bl/vt6YAavcQZceAOUWH8V78MbqcFc0wZzgFaF4a9Uw5DP2rZwe7wDy73GmI?=
 =?us-ascii?Q?eFK1c2R1wKY+qGGxVt1RI6R0Tl1Ap2LnbTTytUepfdoWpYcFf42b+cegXMyL?=
 =?us-ascii?Q?94wm5gEjEpyCTWG6aWzZVb5R7/Ot219g37MSMYJrspINlWBO07/G8gOeOCF1?=
 =?us-ascii?Q?T7Q2h7f703j2p8Ad6nFACTCm5YhNUltFJxej+fSmGeG1hJ+ZweYNFJVf4hyR?=
 =?us-ascii?Q?rgSTEtIMz+CixjmlUTe85/0rjqGcU3v4rfWNr2TxTR/v7Ocz8b9BRWzGtgoB?=
 =?us-ascii?Q?xen8fElkmJUbVto/925neYjqGhpB7teDDeWU8Z0EumXyK2jY9bZRkd62/vhT?=
 =?us-ascii?Q?EyFrHT9kt7r2I+hguTw0rTbwVH35lGBL/7HzNmiF5DJXU1wTibq2DszWLOrW?=
 =?us-ascii?Q?WNbCcf3yLgqxDYHs+ITkJ1Ly75HffPKoJ/6UQSUG1cwWNPZEWHYpdI3HHpEd?=
 =?us-ascii?Q?JHlpcx+SoXXXNngGhHvACR526oaoEQfO8NPEhBcOJ/2L8J6fVpsZRFpWnIVR?=
 =?us-ascii?Q?GyLy1bCO8eA028I0VyCSGrJ00Yfryg4NOTXtQzAZvhsV6VRlVN/l8+453k/V?=
 =?us-ascii?Q?ChUpKGW3slysjQDxFytEsF/t1nsqil5zpNKuRyDcFhZmGMBSnzYfZIB/SjJB?=
 =?us-ascii?Q?bSsFkAU6dLZOUinF1XY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bd2db2-1e46-4c8b-7dfe-08de3f0f6e83
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:01:04.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4E9Vst2pC3y031D3Rnxg3QqtQE/BVy68fDk3tvW4x6aDt71JMlHJRMVBnexyyuGEnXIZyYPbkEaN/n5aSgwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

On Thu, Dec 18, 2025 at 12:16:00AM +0900, Koichiro Den wrote:
> Add a new ntb_transport backend that uses a DesignWare eDMA engine
> located on the endpoint, to be driven by both host and endpoint.
>
> The endpoint exposes a dedicated memory window which contains the eDMA
> register block, a small control structure (struct ntb_edma_info) and
> per-channel linked-list (LL) rings for read channels. Endpoint drives
> its local eDMA write channels for its transmission, while host side
> uses the remote eDMA read channels for its transmission.

I just glace the code. Look likes you use standard DMA API and
per-channel linked-list (LL) ring, which can be pure software.

So it is not nessasry to binding to Designware EDMA. Maybe other vendor
PCIe's build DMA can work with this code?

Frank
>
> A key benefit of this backend is that the memory window no longer needs
> to carry data-plane payload. This makes the design less sensitive to
> limited memory window space and allows scaling to multiple queue pairs.
> The memory window layout is specific to the eDMA-backed backend, so
> there is no automatic fallback to the memcpy-based default transport
> that requires the different layout.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/Kconfig                  |  12 +
>  drivers/ntb/Makefile                 |   2 +
>  drivers/ntb/ntb_transport_core.c     |  15 +-
>  drivers/ntb/ntb_transport_edma.c     | 987 +++++++++++++++++++++++++++
>  drivers/ntb/ntb_transport_internal.h |  15 +
>  5 files changed, 1029 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/ntb/ntb_transport_edma.c
>
> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> index df16c755b4da..5ba6d0b7f5ba 100644
> --- a/drivers/ntb/Kconfig
> +++ b/drivers/ntb/Kconfig
> @@ -37,4 +37,16 @@ config NTB_TRANSPORT
>
>  	 If unsure, say N.
>
> +config NTB_TRANSPORT_EDMA
> +	bool "NTB Transport backed by remote eDMA"
> +	depends on NTB_TRANSPORT
> +	depends on PCI
> +	select DMA_ENGINE
> +	select NTB_EDMA
> +	help
> +	  Enable a transport backend that uses a remote DesignWare eDMA engine
> +	  exposed through a dedicated NTB memory window. The host uses the
> +	  endpoint's eDMA engine to move data in both directions.
> +	  Say Y here if you intend to use the 'use_remote_edma' module parameter.
> +
>  endif # NTB
> diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
> index 9b66e5fafbc0..b9086b32ecde 100644
> --- a/drivers/ntb/Makefile
> +++ b/drivers/ntb/Makefile
> @@ -6,3 +6,5 @@ ntb-y			:= core.o
>  ntb-$(CONFIG_NTB_MSI)	+= msi.o
>
>  ntb_transport-y		:= ntb_transport_core.o
> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= ntb_transport_edma.o
> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= hw/edma/ntb_hw_edma.o
> diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
> index 40c2548f5930..bd21232f26fe 100644
> --- a/drivers/ntb/ntb_transport_core.c
> +++ b/drivers/ntb/ntb_transport_core.c
> @@ -104,6 +104,12 @@ module_param(use_msi, bool, 0644);
>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
>  #endif
>
> +bool use_remote_edma;
> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> +module_param(use_remote_edma, bool, 0644);
> +MODULE_PARM_DESC(use_remote_edma, "Use remote eDMA mode (when enabled, use_msi is ignored)");
> +#endif
> +
>  static struct dentry *nt_debugfs_dir;
>
>  /* Only two-ports NTB devices are supported */
> @@ -156,7 +162,7 @@ enum {
>  #define drv_client(__drv) \
>  	container_of((__drv), struct ntb_transport_client, driver)
>
> -#define NTB_QP_DEF_NUM_ENTRIES	100
> +#define NTB_QP_DEF_NUM_ENTRIES	128
>  #define NTB_LINK_DOWN_TIMEOUT	10
>
>  static void ntb_transport_rxc_db(unsigned long data);
> @@ -1189,7 +1195,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>
>  	nt->ndev = ndev;
>
> -	rc = ntb_transport_default_init(nt);
> +	if (use_remote_edma)
> +		rc = ntb_transport_edma_init(nt);
> +	else
> +		rc = ntb_transport_default_init(nt);
> +
>  	if (rc)
>  		return rc;
>
> @@ -1950,6 +1960,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>
>  	nt->qp_bitmap_free &= ~qp_bit;
>
> +	qp->qp_bit = qp_bit;
>  	qp->cb_data = data;
>  	qp->rx_handler = handlers->rx_handler;
>  	qp->tx_handler = handlers->tx_handler;
> diff --git a/drivers/ntb/ntb_transport_edma.c b/drivers/ntb/ntb_transport_edma.c
> new file mode 100644
> index 000000000000..6ae5da0a1367
> --- /dev/null
> +++ b/drivers/ntb/ntb_transport_edma.c
> @@ -0,0 +1,987 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NTB transport backend for remote DesignWare eDMA.
> + *
> + * This implements the backend_ops used when use_remote_edma=1 and
> + * relies on drivers/ntb/hw/edma/ for low-level eDMA/MW programming.
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/compiler.h>
> +#include <linux/debugfs.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/ntb.h>
> +#include <linux/pci.h>
> +#include <linux/pci-epc.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
> +#include "hw/edma/ntb_hw_edma.h"
> +#include "ntb_transport_internal.h"
> +
> +#define NTB_EDMA_RING_ORDER	7
> +#define NTB_EDMA_RING_ENTRIES	(1U << NTB_EDMA_RING_ORDER)
> +#define NTB_EDMA_RING_MASK	(NTB_EDMA_RING_ENTRIES - 1)
> +
> +#define NTB_EDMA_MAX_POLL	32
> +
> +/*
> + * Remote eDMA mode implementation
> + */
> +struct ntb_transport_ctx_edma {
> +	remote_edma_mode_t remote_edma_mode;
> +	struct device *dma_dev;
> +	struct workqueue_struct *wq;
> +	struct ntb_edma_chans chans;
> +};
> +
> +struct ntb_transport_qp_edma {
> +	struct ntb_transport_qp *qp;
> +
> +	/*
> +	 * For ensuring peer notification in non-atomic context.
> +	 * ntb_peer_db_set might sleep or schedule.
> +	 */
> +	struct work_struct db_work;
> +
> +	u32 rx_prod;
> +	u32 rx_cons;
> +	u32 tx_cons;
> +	u32 tx_issue;
> +
> +	spinlock_t rx_lock;
> +	spinlock_t tx_lock;
> +
> +	struct work_struct rx_work;
> +	struct work_struct tx_work;
> +};
> +
> +struct ntb_edma_desc {
> +	u32 len;
> +	u32 flags;
> +	u64 addr; /* DMA address */
> +	u64 data;
> +};
> +
> +struct ntb_edma_ring {
> +	struct ntb_edma_desc desc[NTB_EDMA_RING_ENTRIES];
> +	u32 head;
> +	u32 tail;
> +};
> +
> +static inline bool ntb_qp_edma_is_rc(struct ntb_transport_qp *qp)
> +{
> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> +
> +	return ctx->remote_edma_mode == REMOTE_EDMA_RC;
> +}
> +
> +static inline bool ntb_qp_edma_is_ep(struct ntb_transport_qp *qp)
> +{
> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> +
> +	return ctx->remote_edma_mode == REMOTE_EDMA_EP;
> +}
> +
> +static inline bool ntb_qp_edma_enabled(struct ntb_transport_qp *qp)
> +{
> +	return ntb_qp_edma_is_rc(qp) || ntb_qp_edma_is_ep(qp);
> +}
> +
> +static inline unsigned int ntb_edma_ring_sel(struct ntb_transport_qp *qp,
> +					     unsigned int n)
> +{
> +	return n ^ !!ntb_qp_edma_is_ep(qp);
> +}
> +
> +static inline struct ntb_edma_ring *
> +ntb_edma_ring_local(struct ntb_transport_qp *qp, unsigned int n)
> +{
> +	unsigned int r = ntb_edma_ring_sel(qp, n);
> +
> +	return &((struct ntb_edma_ring *)qp->rx_buff)[r];
> +}
> +
> +static inline struct ntb_edma_ring __iomem *
> +ntb_edma_ring_remote(struct ntb_transport_qp *qp, unsigned int n)
> +{
> +	unsigned int r = ntb_edma_ring_sel(qp, n);
> +
> +	return &((struct ntb_edma_ring __iomem *)qp->tx_mw)[r];
> +}
> +
> +static inline struct ntb_edma_desc *
> +ntb_edma_desc_local(struct ntb_transport_qp *qp, unsigned int n, unsigned int i)
> +{
> +	return &ntb_edma_ring_local(qp, n)->desc[i];
> +}
> +
> +static inline struct ntb_edma_desc __iomem *
> +ntb_edma_desc_remote(struct ntb_transport_qp *qp, unsigned int n,
> +		     unsigned int i)
> +{
> +	return &ntb_edma_ring_remote(qp, n)->desc[i];
> +}
> +
> +static inline u32 *ntb_edma_head_local(struct ntb_transport_qp *qp,
> +				       unsigned int n)
> +{
> +	return &ntb_edma_ring_local(qp, n)->head;
> +}
> +
> +static inline u32 __iomem *ntb_edma_head_remote(struct ntb_transport_qp *qp,
> +						unsigned int n)
> +{
> +	return &ntb_edma_ring_remote(qp, n)->head;
> +}
> +
> +static inline u32 *ntb_edma_tail_local(struct ntb_transport_qp *qp,
> +				       unsigned int n)
> +{
> +	return &ntb_edma_ring_local(qp, n)->tail;
> +}
> +
> +static inline u32 __iomem *ntb_edma_tail_remote(struct ntb_transport_qp *qp,
> +						unsigned int n)
> +{
> +	return &ntb_edma_ring_remote(qp, n)->tail;
> +}
> +
> +/* The 'i' must be generated by ntb_edma_ring_idx() */
> +#define NTB_DESC_TX_O(qp, i)	ntb_edma_desc_remote(qp, 0, i)
> +#define NTB_DESC_TX_I(qp, i)	ntb_edma_desc_local(qp, 0, i)
> +#define NTB_DESC_RX_O(qp, i)	ntb_edma_desc_remote(qp, 1, i)
> +#define NTB_DESC_RX_I(qp, i)	ntb_edma_desc_local(qp, 1, i)
> +
> +#define NTB_HEAD_TX_I(qp)	ntb_edma_head_local(qp, 0)
> +#define NTB_HEAD_RX_O(qp)	ntb_edma_head_remote(qp, 1)
> +
> +#define NTB_TAIL_TX_O(qp)	ntb_edma_tail_remote(qp, 0)
> +#define NTB_TAIL_RX_I(qp)	ntb_edma_tail_local(qp, 1)
> +
> +/* ntb_edma_ring helpers */
> +static __always_inline u32 ntb_edma_ring_idx(u32 v)
> +{
> +	return v & NTB_EDMA_RING_MASK;
> +}
> +
> +static __always_inline u32 ntb_edma_ring_used_entry(u32 head, u32 tail)
> +{
> +	if (head >= tail) {
> +		WARN_ON_ONCE((head - tail) > (NTB_EDMA_RING_ENTRIES - 1));
> +		return head - tail;
> +	}
> +
> +	WARN_ON_ONCE((U32_MAX - tail + head + 1) > (NTB_EDMA_RING_ENTRIES - 1));
> +	return U32_MAX - tail + head + 1;
> +}
> +
> +static __always_inline u32 ntb_edma_ring_free_entry(u32 head, u32 tail)
> +{
> +	return NTB_EDMA_RING_ENTRIES - ntb_edma_ring_used_entry(head, tail) - 1;
> +}
> +
> +static __always_inline bool ntb_edma_ring_full(u32 head, u32 tail)
> +{
> +	return ntb_edma_ring_free_entry(head, tail) == 0;
> +}
> +
> +static unsigned int ntb_transport_edma_tx_free_entry(struct ntb_transport_qp *qp)
> +{
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +	unsigned int head, tail;
> +
> +	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
> +		/* In this scope, only 'head' might proceed */
> +		tail = READ_ONCE(edma->tx_issue);
> +		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
> +	}
> +	/*
> +	 * 'used' amount indicates how much the other end has refilled,
> +	 * which are available for us to use for TX.
> +	 */
> +	return ntb_edma_ring_used_entry(head, tail);
> +}
> +
> +static void ntb_transport_edma_debugfs_stats_show(struct seq_file *s,
> +						  struct ntb_transport_qp *qp)
> +{
> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> +
> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> +	seq_putc(s, '\n');
> +
> +	seq_puts(s, "Using Remote eDMA - Yes\n");
> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> +}
> +
> +static void ntb_transport_edma_uninit(struct ntb_transport_ctx *nt)
> +{
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +
> +	if (ctx->wq)
> +		destroy_workqueue(ctx->wq);
> +	ctx->wq = NULL;
> +
> +	ntb_edma_teardown_chans(&ctx->chans);
> +
> +	switch (ctx->remote_edma_mode) {
> +	case REMOTE_EDMA_EP:
> +		ntb_edma_teardown_mws(nt->ndev);
> +		break;
> +	case REMOTE_EDMA_RC:
> +		ntb_edma_teardown_peer(nt->ndev);
> +		break;
> +	case REMOTE_EDMA_UNKNOWN:
> +	default:
> +		break;
> +	}
> +
> +	ctx->remote_edma_mode = REMOTE_EDMA_UNKNOWN;
> +}
> +
> +static void ntb_transport_edma_db_work(struct work_struct *work)
> +{
> +	struct ntb_transport_qp_edma *edma =
> +			container_of(work, struct ntb_transport_qp_edma, db_work);
> +	struct ntb_transport_qp *qp = edma->qp;
> +
> +	ntb_peer_db_set(qp->ndev, qp->qp_bit);
> +}
> +
> +static void ntb_transport_edma_notify_peer(struct ntb_transport_qp_edma *edma)
> +{
> +	struct ntb_transport_qp *qp = edma->qp;
> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> +
> +	if (!ntb_edma_notify_peer(&ctx->chans, qp->qp_num))
> +		return;
> +
> +	/*
> +	 * Called from contexts that may be atomic. Since ntb_peer_db_set()
> +	 * may sleep, delegate the actual doorbell write to a workqueue.
> +	 */
> +	queue_work(system_highpri_wq, &edma->db_work);
> +}
> +
> +static void ntb_transport_edma_isr(void *data, int qp_num)
> +{
> +	struct ntb_transport_ctx *nt = data;
> +	struct ntb_transport_qp_edma *edma;
> +	struct ntb_transport_ctx_edma *ctx;
> +	struct ntb_transport_qp *qp;
> +
> +	if (qp_num < 0 || qp_num >= nt->qp_count)
> +		return;
> +
> +	qp = &nt->qp_vec[qp_num];
> +	if (WARN_ON(!qp))
> +		return;
> +
> +	ctx = (struct ntb_transport_ctx_edma *)qp->transport->priv;
> +	edma = qp->priv;
> +
> +	queue_work(ctx->wq, &edma->rx_work);
> +	queue_work(ctx->wq, &edma->tx_work);
> +}
> +
> +static int ntb_transport_edma_rc_init(struct ntb_transport_ctx *nt)
> +{
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +	struct ntb_dev *ndev = nt->ndev;
> +	struct pci_dev *pdev = ndev->pdev;
> +	int peer_mw;
> +	int rc;
> +
> +	if (!use_remote_edma || ctx->remote_edma_mode != REMOTE_EDMA_UNKNOWN)
> +		return 0;
> +
> +	peer_mw = ntb_peer_mw_count(ndev);
> +	if (peer_mw <= 0)
> +		return -ENODEV;
> +
> +	rc = ntb_edma_setup_peer(ndev, peer_mw - 1, nt->qp_count);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to enable remote eDMA: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &ctx->chans, true);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
> +		goto err_teardown_peer;
> +	}
> +
> +	rc = ntb_edma_setup_intr_chan(get_dma_dev(ndev), &ctx->chans);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to setup eDMA notify channel: %d\n",
> +			rc);
> +		goto err_teardown_chans;
> +	}
> +
> +	ctx->remote_edma_mode = REMOTE_EDMA_RC;
> +	return 0;
> +
> +err_teardown_chans:
> +	ntb_edma_teardown_chans(&ctx->chans);
> +err_teardown_peer:
> +	ntb_edma_teardown_peer(ndev);
> +	return rc;
> +}
> +
> +
> +static int ntb_transport_edma_ep_init(struct ntb_transport_ctx *nt)
> +{
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +	struct ntb_dev *ndev = nt->ndev;
> +	struct pci_dev *pdev = ndev->pdev;
> +	int peer_mw;
> +	int rc;
> +
> +	if (!use_remote_edma || ctx->remote_edma_mode == REMOTE_EDMA_EP)
> +		return 0;
> +
> +	/**
> +	 * This check assumes that the endpoint (pci-epf-vntb.c)
> +	 * ntb_dev_ops implements .get_private_data() while the host side
> +	 * (ntb_hw_epf.c) does not.
> +	 */
> +	if (!ntb_get_private_data(ndev))
> +		return 0;
> +
> +	peer_mw = ntb_peer_mw_count(ndev);
> +	if (peer_mw <= 0)
> +		return -ENODEV;
> +
> +	rc = ntb_edma_setup_mws(ndev, peer_mw - 1, nt->qp_count,
> +				ntb_transport_edma_isr, nt);
> +	if (rc) {
> +		dev_err(&pdev->dev,
> +			"Failed to set up memory window for eDMA: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &ctx->chans, false);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
> +		ntb_edma_teardown_mws(ndev);
> +		return rc;
> +	}
> +
> +	ctx->remote_edma_mode = REMOTE_EDMA_EP;
> +	return 0;
> +}
> +
> +
> +static int ntb_transport_edma_setup_qp_mw(struct ntb_transport_ctx *nt,
> +					  unsigned int qp_num)
> +{
> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
> +	struct ntb_dev *ndev = nt->ndev;
> +	struct ntb_queue_entry *entry;
> +	struct ntb_transport_mw *mw;
> +	unsigned int mw_num, mw_count, qp_count;
> +	unsigned int qp_offset, rx_info_offset;
> +	unsigned int mw_size, mw_size_per_qp;
> +	unsigned int num_qps_mw;
> +	size_t edma_total;
> +	unsigned int i;
> +	int node;
> +
> +	mw_count = nt->mw_count;
> +	qp_count = nt->qp_count;
> +
> +	mw_num = QP_TO_MW(nt, qp_num);
> +	mw = &nt->mw_vec[mw_num];
> +
> +	if (!mw->virt_addr)
> +		return -ENOMEM;
> +
> +	if (mw_num < qp_count % mw_count)
> +		num_qps_mw = qp_count / mw_count + 1;
> +	else
> +		num_qps_mw = qp_count / mw_count;
> +
> +	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
> +	if (max_mw_size && mw_size > max_mw_size)
> +		mw_size = max_mw_size;
> +
> +	mw_size_per_qp = round_down((unsigned int)mw_size / num_qps_mw, SZ_64);
> +	qp_offset = mw_size_per_qp * (qp_num / mw_count);
> +	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
> +
> +	qp->tx_mw_size = mw_size_per_qp;
> +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> +	if (!qp->tx_mw)
> +		return -EINVAL;
> +	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
> +	if (!qp->tx_mw_phys)
> +		return -EINVAL;
> +	qp->rx_info = qp->tx_mw + rx_info_offset;
> +	qp->rx_buff = mw->virt_addr + qp_offset;
> +	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
> +
> +	/* Due to housekeeping, there must be at least 2 buffs */
> +	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> +	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> +
> +	/* In eDMA mode, decouple from MW sizing and force ring-sized entries */
> +	edma_total = 2 * sizeof(struct ntb_edma_ring);
> +	if (rx_info_offset < edma_total) {
> +		dev_err(&ndev->dev, "Ring space requires %zuB (>=%uB)\n",
> +			edma_total, rx_info_offset);
> +		return -EINVAL;
> +	}
> +	qp->tx_max_entry = NTB_EDMA_RING_ENTRIES;
> +	qp->rx_max_entry = NTB_EDMA_RING_ENTRIES;
> +
> +	/*
> +	 * Checking to see if we have more entries than the default.
> +	 * We should add additional entries if that is the case so we
> +	 * can be in sync with the transport frames.
> +	 */
> +	node = dev_to_node(&ndev->dev);
> +	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
> +		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
> +		if (!entry)
> +			return -ENOMEM;
> +
> +		entry->qp = qp;
> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> +			     &qp->rx_free_q);
> +		qp->rx_alloc_entry++;
> +	}
> +
> +	memset(qp->rx_buff, 0, edma_total);
> +
> +	qp->rx_pkts = 0;
> +	qp->tx_pkts = 0;
> +
> +	return 0;
> +}
> +
> +static int ntb_transport_edma_rx_complete(struct ntb_transport_qp *qp)
> +{
> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +	struct ntb_queue_entry *entry;
> +	struct ntb_edma_desc *in;
> +	unsigned int len;
> +	bool link_down;
> +	u32 idx;
> +
> +	if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_TAIL_RX_I(qp)),
> +				     edma->rx_cons) == 0)
> +		return 0;
> +
> +	idx = ntb_edma_ring_idx(edma->rx_cons);
> +	in = NTB_DESC_RX_I(qp, idx);
> +	if (!(in->flags & DESC_DONE_FLAG))
> +		return 0;
> +
> +	link_down = in->flags & LINK_DOWN_FLAG;
> +	in->flags = 0;
> +	len = in->len; /* might be smaller than entry->len */
> +
> +	entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
> +	if (WARN_ON(!entry))
> +		return 0;
> +
> +	if (link_down) {
> +		ntb_qp_link_down(qp);
> +		edma->rx_cons++;
> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> +		return 1;
> +	}
> +
> +	dma_unmap_single(dma_dev, entry->addr, entry->len, DMA_FROM_DEVICE);
> +
> +	qp->rx_bytes += len;
> +	qp->rx_pkts++;
> +	edma->rx_cons++;
> +
> +	if (qp->rx_handler && qp->client_ready)
> +		qp->rx_handler(qp, qp->cb_data, entry->cb_data, len);
> +
> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> +	return 1;
> +}
> +
> +static void ntb_transport_edma_rx_work(struct work_struct *work)
> +{
> +	struct ntb_transport_qp_edma *edma = container_of(
> +				work, struct ntb_transport_qp_edma, rx_work);
> +	struct ntb_transport_qp *qp = edma->qp;
> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> +	unsigned int i;
> +
> +	for (i = 0; i < NTB_EDMA_MAX_POLL; i++) {
> +		if (!ntb_transport_edma_rx_complete(qp))
> +			break;
> +	}
> +
> +	if (ntb_transport_edma_rx_complete(qp))
> +		queue_work(ctx->wq, &edma->rx_work);
> +}
> +
> +static void ntb_transport_edma_tx_work(struct work_struct *work)
> +{
> +	struct ntb_transport_qp_edma *edma = container_of(
> +				work, struct ntb_transport_qp_edma, tx_work);
> +	struct ntb_transport_qp *qp = edma->qp;
> +	struct ntb_edma_desc *in, __iomem *out;
> +	struct ntb_queue_entry *entry;
> +	unsigned int len;
> +	void *cb_data;
> +	u32 idx;
> +
> +	while (ntb_edma_ring_used_entry(READ_ONCE(edma->tx_issue),
> +					edma->tx_cons) != 0) {
> +		/* Paired with smp_wmb() in ntb_transport_edma_tx_enqueue_inner() */
> +		smp_rmb();
> +
> +		idx = ntb_edma_ring_idx(edma->tx_cons);
> +		in = NTB_DESC_TX_I(qp, idx);
> +		entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
> +		if (!entry || !(entry->flags & DESC_DONE_FLAG))
> +			break;
> +
> +		in->data = 0;
> +
> +		cb_data = entry->cb_data;
> +		len = entry->len;
> +
> +		out = NTB_DESC_TX_O(qp, idx);
> +
> +		WRITE_ONCE(edma->tx_cons, edma->tx_cons + 1);
> +
> +		/*
> +		 * No need to add barrier in-between to enforce ordering here.
> +		 * The other side proceeds only after both flags and tail are
> +		 * updated.
> +		 */
> +		iowrite32(entry->flags, &out->flags);
> +		iowrite32(edma->tx_cons, NTB_TAIL_TX_O(qp));
> +
> +		ntb_transport_edma_notify_peer(edma);
> +
> +		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> +			     &qp->tx_free_q);
> +
> +		if (qp->tx_handler)
> +			qp->tx_handler(qp, qp->cb_data, cb_data, len);
> +
> +		/* stat updates */
> +		qp->tx_bytes += len;
> +		qp->tx_pkts++;
> +	}
> +}
> +
> +static void ntb_transport_edma_tx_cb(void *data,
> +				     const struct dmaengine_result *res)
> +{
> +	struct ntb_queue_entry *entry = data;
> +	struct ntb_transport_qp *qp = entry->qp;
> +	struct ntb_transport_ctx *nt = qp->transport;
> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> +	enum dmaengine_tx_result dma_err = res->result;
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +
> +	switch (dma_err) {
> +	case DMA_TRANS_READ_FAILED:
> +	case DMA_TRANS_WRITE_FAILED:
> +	case DMA_TRANS_ABORTED:
> +		entry->errors++;
> +		entry->len = -EIO;
> +		break;
> +	case DMA_TRANS_NOERROR:
> +	default:
> +		break;
> +	}
> +	dma_unmap_sg(dma_dev, &entry->sgl, 1, DMA_TO_DEVICE);
> +	sg_dma_address(&entry->sgl) = 0;
> +
> +	entry->flags |= DESC_DONE_FLAG;
> +
> +	queue_work(ctx->wq, &edma->tx_work);
> +}
> +
> +static int ntb_transport_edma_submit(struct device *d, struct dma_chan *chan,
> +				     size_t len, void *rc_src, dma_addr_t dst,
> +				     struct ntb_queue_entry *entry)
> +{
> +	struct scatterlist *sgl = &entry->sgl;
> +	struct dma_async_tx_descriptor *txd;
> +	struct dma_slave_config cfg;
> +	dma_cookie_t cookie;
> +	int nents, rc;
> +
> +	if (!d)
> +		return -ENODEV;
> +
> +	if (!chan)
> +		return -ENXIO;
> +
> +	if (WARN_ON(!rc_src || !dst))
> +		return -EINVAL;
> +
> +	if (WARN_ON(sg_dma_address(sgl)))
> +		return -EINVAL;
> +
> +	sg_init_one(sgl, rc_src, len);
> +	nents = dma_map_sg(d, sgl, 1, DMA_TO_DEVICE);
> +	if (nents <= 0)
> +		return -EIO;
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +	cfg.dst_addr       = dst;
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.direction      = DMA_MEM_TO_DEV;
> +
> +	txd = dmaengine_prep_slave_sg_config(chan, sgl, 1, DMA_MEM_TO_DEV,
> +				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT, &cfg);
> +	if (!txd) {
> +		rc = -EIO;
> +		goto out_unmap;
> +	}
> +
> +	txd->callback_result = ntb_transport_edma_tx_cb;
> +	txd->callback_param = entry;
> +
> +	cookie = dmaengine_submit(txd);
> +	if (dma_submit_error(cookie)) {
> +		rc = -EIO;
> +		goto out_unmap;
> +	}
> +	dma_async_issue_pending(chan);
> +	return 0;
> +out_unmap:
> +	dma_unmap_sg(d, sgl, 1, DMA_TO_DEVICE);
> +	return rc;
> +}
> +
> +static int ntb_transport_edma_tx_enqueue_inner(struct ntb_transport_qp *qp,
> +					       struct ntb_queue_entry *entry)
> +{
> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +	struct ntb_transport_ctx *nt = qp->transport;
> +	struct ntb_edma_desc *in, __iomem *out;
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +	unsigned int len = entry->len;
> +	struct dma_chan *chan;
> +	u32 issue, idx, head;
> +	dma_addr_t dst;
> +	int rc;
> +
> +	WARN_ON_ONCE(entry->flags & DESC_DONE_FLAG);
> +
> +	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
> +		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
> +		issue = edma->tx_issue;
> +		if (ntb_edma_ring_used_entry(head, issue) == 0) {
> +			qp->tx_ring_full++;
> +			return -ENOSPC;
> +		}
> +
> +		/*
> +		 * ntb_transport_edma_tx_work() checks entry->flags
> +		 * so it needs to be set before tx_issue++.
> +		 */
> +		idx = ntb_edma_ring_idx(issue);
> +		in = NTB_DESC_TX_I(qp, idx);
> +		in->data = (uintptr_t)entry;
> +
> +		/* Make in->data visible before tx_issue++ */
> +		smp_wmb();
> +
> +		WRITE_ONCE(edma->tx_issue, edma->tx_issue + 1);
> +	}
> +
> +	/* Publish the final transfer length to the other end */
> +	out = NTB_DESC_TX_O(qp, idx);
> +	iowrite32(len, &out->len);
> +	ioread32(&out->len);
> +
> +	if (unlikely(!len)) {
> +		entry->flags |= DESC_DONE_FLAG;
> +		queue_work(ctx->wq, &edma->tx_work);
> +		return 0;
> +	}
> +
> +	/* Paired with dma_wmb() in ntb_transport_edma_rx_enqueue_inner() */
> +	dma_rmb();
> +
> +	/* kick remote eDMA read transfer */
> +	dst = (dma_addr_t)in->addr;
> +	chan = ntb_edma_pick_chan(&ctx->chans, qp->qp_num);
> +	rc = ntb_transport_edma_submit(dma_dev, chan, len,
> +					      entry->buf, dst, entry);
> +	if (rc) {
> +		entry->errors++;
> +		entry->len = -EIO;
> +		entry->flags |= DESC_DONE_FLAG;
> +		queue_work(ctx->wq, &edma->tx_work);
> +	}
> +	return 0;
> +}
> +
> +static int ntb_transport_edma_tx_enqueue(struct ntb_transport_qp *qp,
> +					 struct ntb_queue_entry *entry,
> +					 void *cb, void *data, unsigned int len,
> +					 unsigned int flags)
> +{
> +	struct device *dma_dev;
> +
> +	if (entry->addr) {
> +		/* Deferred unmap */
> +		dma_dev = get_dma_dev(qp->ndev);
> +		dma_unmap_single(dma_dev, entry->addr, entry->len,
> +				 DMA_TO_DEVICE);
> +	}
> +
> +	entry->cb_data = cb;
> +	entry->buf = data;
> +	entry->len = len;
> +	entry->flags = flags;
> +	entry->errors = 0;
> +	entry->addr = 0;
> +
> +	WARN_ON_ONCE(!ntb_qp_edma_enabled(qp));
> +
> +	return ntb_transport_edma_tx_enqueue_inner(qp, entry);
> +}
> +
> +static int ntb_transport_edma_rx_enqueue_inner(struct ntb_transport_qp *qp,
> +					       struct ntb_queue_entry *entry)
> +{
> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +	struct ntb_edma_desc *in, __iomem *out;
> +	unsigned int len = entry->len;
> +	void *data = entry->buf;
> +	dma_addr_t dst;
> +	u32 idx;
> +	int rc;
> +
> +	dst = dma_map_single(dma_dev, data, len, DMA_FROM_DEVICE);
> +	rc = dma_mapping_error(dma_dev, dst);
> +	if (rc)
> +		return rc;
> +
> +	guard(spinlock_bh)(&edma->rx_lock);
> +
> +	if (ntb_edma_ring_full(READ_ONCE(edma->rx_prod),
> +			       READ_ONCE(edma->rx_cons))) {
> +		rc = -ENOSPC;
> +		goto out_unmap;
> +	}
> +
> +	idx = ntb_edma_ring_idx(edma->rx_prod);
> +	in = NTB_DESC_RX_I(qp, idx);
> +	out = NTB_DESC_RX_O(qp, idx);
> +
> +	iowrite32(len, &out->len);
> +	iowrite64(dst, &out->addr);
> +
> +	WARN_ON(in->flags & DESC_DONE_FLAG);
> +	in->data = (uintptr_t)entry;
> +	entry->addr = dst;
> +
> +	/* Ensure len/addr are visible before the head update */
> +	dma_wmb();
> +
> +	WRITE_ONCE(edma->rx_prod, edma->rx_prod + 1);
> +	iowrite32(edma->rx_prod, NTB_HEAD_RX_O(qp));
> +
> +	return 0;
> +out_unmap:
> +	dma_unmap_single(dma_dev, dst, len, DMA_FROM_DEVICE);
> +	return rc;
> +}
> +
> +static int ntb_transport_edma_rx_enqueue(struct ntb_transport_qp *qp,
> +					 struct ntb_queue_entry *entry)
> +{
> +	int rc;
> +
> +	rc = ntb_transport_edma_rx_enqueue_inner(qp, entry);
> +	if (rc) {
> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> +			     &qp->rx_free_q);
> +		return rc;
> +	}
> +
> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
> +
> +	if (qp->active)
> +		tasklet_schedule(&qp->rxc_db_work);
> +
> +	return 0;
> +}
> +
> +static void ntb_transport_edma_rx_poll(struct ntb_transport_qp *qp)
> +{
> +	struct ntb_transport_ctx *nt = qp->transport;
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +
> +	queue_work(ctx->wq, &edma->rx_work);
> +	queue_work(ctx->wq, &edma->tx_work);
> +}
> +
> +static int ntb_transport_edma_qp_init(struct ntb_transport_ctx *nt,
> +				      unsigned int qp_num)
> +{
> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
> +	struct ntb_transport_qp_edma *edma;
> +	struct ntb_dev *ndev = nt->ndev;
> +	int node;
> +
> +	node = dev_to_node(&ndev->dev);
> +
> +	qp->priv = kzalloc_node(sizeof(*edma), GFP_KERNEL, node);
> +	if (!qp->priv)
> +		return -ENOMEM;
> +
> +	edma = (struct ntb_transport_qp_edma *)qp->priv;
> +	edma->qp = qp;
> +	edma->rx_prod = 0;
> +	edma->rx_cons = 0;
> +	edma->tx_cons = 0;
> +	edma->tx_issue = 0;
> +
> +	spin_lock_init(&edma->rx_lock);
> +	spin_lock_init(&edma->tx_lock);
> +
> +	INIT_WORK(&edma->db_work, ntb_transport_edma_db_work);
> +	INIT_WORK(&edma->rx_work, ntb_transport_edma_rx_work);
> +	INIT_WORK(&edma->tx_work, ntb_transport_edma_tx_work);
> +
> +	return 0;
> +}
> +
> +static void ntb_transport_edma_qp_free(struct ntb_transport_qp *qp)
> +{
> +	struct ntb_transport_qp_edma *edma = qp->priv;
> +
> +	cancel_work_sync(&edma->db_work);
> +	cancel_work_sync(&edma->rx_work);
> +	cancel_work_sync(&edma->tx_work);
> +
> +	kfree(qp->priv);
> +}
> +
> +static int ntb_transport_edma_pre_link_up(struct ntb_transport_ctx *nt)
> +{
> +	struct ntb_dev *ndev = nt->ndev;
> +	struct pci_dev *pdev = ndev->pdev;
> +	int rc;
> +
> +	rc = ntb_transport_edma_ep_init(nt);
> +	if (rc)
> +		dev_err(&pdev->dev, "Failed to init EP: %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static int ntb_transport_edma_post_link_up(struct ntb_transport_ctx *nt)
> +{
> +	struct ntb_dev *ndev = nt->ndev;
> +	struct pci_dev *pdev = ndev->pdev;
> +	int rc;
> +
> +	rc = ntb_transport_edma_rc_init(nt);
> +	if (rc)
> +		dev_err(&pdev->dev, "Failed to init RC: %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static int ntb_transport_edma_enable(struct ntb_transport_ctx *nt,
> +				     unsigned int *mw_count)
> +{
> +	struct ntb_dev *ndev = nt->ndev;
> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> +
> +	if (!use_remote_edma)
> +		return 0;
> +
> +	/*
> +	 * We need at least one MW for the transport plus one MW reserved
> +	 * for the remote eDMA window (see ntb_edma_setup_mws/peer).
> +	 */
> +	if (*mw_count <= 1) {
> +		dev_err(&ndev->dev,
> +			"remote eDMA requires at least two MWS (have %u)\n",
> +			*mw_count);
> +		return -ENODEV;
> +	}
> +
> +	ctx->wq = alloc_workqueue("ntb-edma-wq", WQ_UNBOUND | WQ_SYSFS, 0);
> +	if (!ctx->wq) {
> +		ntb_transport_edma_uninit(nt);
> +		return -ENOMEM;
> +	}
> +
> +	/* Reserve the last peer MW exclusively for the eDMA window. */
> +	*mw_count -= 1;
> +
> +	return 0;
> +}
> +
> +static void ntb_transport_edma_disable(struct ntb_transport_ctx *nt)
> +{
> +	ntb_transport_edma_uninit(nt);
> +}
> +
> +static const struct ntb_transport_backend_ops edma_backend_ops = {
> +	.enable = ntb_transport_edma_enable,
> +	.disable = ntb_transport_edma_disable,
> +	.qp_init = ntb_transport_edma_qp_init,
> +	.qp_free = ntb_transport_edma_qp_free,
> +	.pre_link_up = ntb_transport_edma_pre_link_up,
> +	.post_link_up = ntb_transport_edma_post_link_up,
> +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> +	.rx_poll = ntb_transport_edma_rx_poll,
> +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> +};
> +
> +int ntb_transport_edma_init(struct ntb_transport_ctx *nt)
> +{
> +	struct ntb_dev *ndev = nt->ndev;
> +	int node;
> +
> +	node = dev_to_node(&ndev->dev);
> +	nt->priv = kzalloc_node(sizeof(struct ntb_transport_ctx_edma), GFP_KERNEL,
> +				node);
> +	if (!nt->priv)
> +		return -ENOMEM;
> +
> +	nt->backend_ops = edma_backend_ops;
> +	/*
> +	 * On remote eDMA mode, one DMA read channel is used for Host side
> +	 * to interrupt EP.
> +	 */
> +	use_msi = false;
> +	return 0;
> +}
> diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
> index 51ff08062d73..9fff65980d3d 100644
> --- a/drivers/ntb/ntb_transport_internal.h
> +++ b/drivers/ntb/ntb_transport_internal.h
> @@ -8,6 +8,7 @@
>  extern unsigned long max_mw_size;
>  extern unsigned int transport_mtu;
>  extern bool use_msi;
> +extern bool use_remote_edma;
>
>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
>
> @@ -29,6 +30,11 @@ struct ntb_queue_entry {
>  		struct ntb_payload_header __iomem *tx_hdr;
>  		struct ntb_payload_header *rx_hdr;
>  	};
> +
> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> +	dma_addr_t addr;
> +	struct scatterlist sgl;
> +#endif
>  };
>
>  struct ntb_rx_info {
> @@ -202,4 +208,13 @@ int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  			     unsigned int qp_num);
>  struct device *get_dma_dev(struct ntb_dev *ndev);
>
> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> +int ntb_transport_edma_init(struct ntb_transport_ctx *nt);
> +#else
> +static inline int ntb_transport_edma_init(struct ntb_transport_ctx *nt)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> +
>  #endif /* _NTB_TRANSPORT_INTERNAL_H_ */
> --
> 2.51.0
>

