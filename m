Return-Path: <dmaengine+bounces-7442-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1BC9910B
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 21:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41C5E3446BB
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B1258ED5;
	Mon,  1 Dec 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XY7iBdyD"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6021257B;
	Mon,  1 Dec 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621713; cv=fail; b=E4lqjCcAz7UilG7P7cVNacos68mMrHGBNYWU/WyrYzjEG7/IU1b8pTJy1N7YAQ1iwZDoyX6sn8dMPDvGaaFkao5s/rA7JaBZfNhLxCHxd267gCM0GNPDItZ3Bh0w4LbpdDnd4+M5K8Nu0NfmnUyN7piVL+N8gICRDchOvQiE4r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621713; c=relaxed/simple;
	bh=2pJ9WyLIlWrk5C1oPR2ARM1LxwEDHQ6yeP4t2LVQhBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H6ymh/solVJeQTm1ITAyzNqKJS+rNjMCzqOvYO5KIjWBvoD03O2lDCK7pxiCpUdrV1pKvU+mKfaSDx0jM4IhqY+3Fvwr4tezXOuMH8+HPHY8kzL+xNP5QHWRnscfyATSObE9Lm3KIIHOqUhO+BtNp36L6BTsJec9gvxXbUFAeTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XY7iBdyD; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x63MZHmG5FhxC2p1yGxAXO6cUeV2XLPy+stRmrw2SfPiHXpP/WqMYE3SNJSyoebHZidY7Wbb7Tw01pfhZSRVRa5xsgqa4uOVYeR1fT3EUlv2M+MrjZTxQpvOF4R1+WVPNxeGA6DCLCffRdB5QSCM7aJY9bf2rnhA3f/tjikrwRQ0xSkrfJIkExRHv4HnT6GCjUbRb5KwSAIjRRM+IGdcz3Eyzk3oNM1v8+HaAWpcD7gCnvYRF95ITUBeB/2V1FxR9wN9qC6L09P3Ro972zeowi3gDJz/WdZIbCzOJnborVdyyNRBHz1OK7lrTOsItEHtVHvpclSEAHd8mEi9+5NxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEhRG08DxpyKmboJS62O4Lw+ph/FaWqbSV5FwU64roA=;
 b=boJx9YXNuOquMom+C6/AsevchiEshzXoDrMxaQdKhpaWUSDWQeLnMFrOhI0d5jmXvahcHcYiTQ4o8mjgaKlPVIthN0CuJRfxf7ggNHrRto/CfQmvipp7ezv6QPTBYsASRLEj6CL8kqIrpb6XFSU9gOVHCbkOnanXsc8OHfPQerid8lvecGTp4/qj5Z96SGy/sHN7Df4hGeLdKOlnC4vXdug37H5iheG9TUuG8cdrOoQQJ0pH8syS3JWPyCjOOreLduhM3hbRNwnybBeAipe25g9N6N0G3Em4NuNr8crxQK44XdTJRovd4priSa00+HgKGg7DW/r1ASyKLL8w+XZNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEhRG08DxpyKmboJS62O4Lw+ph/FaWqbSV5FwU64roA=;
 b=XY7iBdyDjsXgG4KH79V4yLajPhFOA7BtV1o6Fe9TcFCzy31aCuxwfFj/gbfgkhNg84y0nkD4Cn5xlRd44AqPGTruKSDCUncUS3pX0htGfgyJUumCGq+jf07Udb3VZOHzpuUQv/qd+bVvk+EecvD8+E+FcVJB60vLcZRA1HFFYAm4Tdhoe12+RcfsE5buwtbK70LiCjHw0P2lNtPvq1YW5gJShwiut6346ifX2tf/iZVDGotzWSbmtxnxWUtdKcwur4i9w6L5P3Fo5mMfJgRd6aya+DT838jt+cIEkGFldl6OJUyQp8NG8anRJ2QeCSt03ZdcfGxbcid3RjuGdqAPZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB8325.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:41:47 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:41:47 +0000
Date: Mon, 1 Dec 2025 15:41:38 -0500
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
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-20-den@valinux.co.jp>
X-ClientProxiedBy: PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::17) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f96f054-f50c-472f-1402-08de311a0be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kOo6um9ycJUroU6gucC/zlCxeHXh3FtxURsokyW4rGMghjtcMGiS2lxomK7Q?=
 =?us-ascii?Q?Ar44ZatoL5pI/PfZqwCzJs6QI8IhJ6yhkew5P1ysRrvElVb2zNpdhArUcgVa?=
 =?us-ascii?Q?QWeitzFXBo4xv1PGbnm2Z9rX0J2bv7OZjx9ZDOgPC6JNdZEFNAvI64DM9GGc?=
 =?us-ascii?Q?q3NcnMQ+jfN5S3q7tpKAycFR6B+uI8e4HjpSqCkr3kAZsrvckCJ+aMTvZ5i0?=
 =?us-ascii?Q?yBkNR1kj54br9q42eytopezPsCd7qAOjjyHTrvHajwva4Za22tWfJhRuJl3n?=
 =?us-ascii?Q?1bnne7igNACijUar/+Isi9NdSF9W3XxJnzpZS9VacETy7y83lH8ubojleqUx?=
 =?us-ascii?Q?Ldv4qsit0BnUSwlBEOLGYqg0nAN2GUka163NocIm6xoSItClFqKRiqCY24uG?=
 =?us-ascii?Q?XuXBPYHWXHMyadyxfiEU+/NwoCG9ishVgk911GSEDy1dmo2Vmq0vkwa+BdVa?=
 =?us-ascii?Q?hDrEmkEfPGhXOuiGqY2hzzGThiefZJSj1gCi3QBlB7MAv09+mmibvXCVL0SA?=
 =?us-ascii?Q?Pq351v9JNDqSgd3m2JtKiCMRGrrK19i9xTA8ZS0narEgOBPcJ3s6oR7d/4gU?=
 =?us-ascii?Q?4rrFdrruzA80sfZhxrVnT/Jtd5VtnRq37UsbQ//15xqh+6LLCYaZxUhD37WC?=
 =?us-ascii?Q?fUFCUJI9P/EtzKpRCdmeyDruihD83uVF8UTknKBEPKyK3992n/OsO8Zi3Gtq?=
 =?us-ascii?Q?hHn2bDe5A9Ou/C90bO47tYnxUMXTj3uGnryqSxuACU9sq44OFwczF8FcvrjR?=
 =?us-ascii?Q?AI+IBVJ5rp3KxxlKyJ2hkkXD6Gy+b2qKZBbcB1w1deVWZCBNZ5klEpgWdnz8?=
 =?us-ascii?Q?tlxUO0TEThXwsJOd1Qij19ZccJmv8oTmzis07x7DmWyNmYkZ9lPqTSBXe++5?=
 =?us-ascii?Q?H7cWByZDKA1HbaFnxWBpVf6T9g1uGTEoAHZILOVHYNRzbcSn58dkV06JYJ2F?=
 =?us-ascii?Q?EG3g7/TrUSIOnXJg3nt2H12eOOrJLe3TlB6HbU/MYiMDPuwjyyxUeUtiSzGl?=
 =?us-ascii?Q?5PuHau8UeysRz2WzYDyo//4+VeMbA7JqvM9qbn7OE4RiMOcpRzbPRTbGLbEG?=
 =?us-ascii?Q?Go6eupIGiuH+bmf8HLn9OsV1LCduHMRVYNs0+pf92wytFxEbtn80MNfh2VUo?=
 =?us-ascii?Q?p/SVsUvXHOZF9L80HxlFv5VLaSC5gQZWaSPVcAFLZ35RS0jTH0Mwi1KoVfXP?=
 =?us-ascii?Q?Jro+LB83z9/JOIrFDgJPIAdnth6ldmA5EdIj0IJz38uwSHfboYtHRt6ZQtP0?=
 =?us-ascii?Q?cLP37hpzsmyB+ig0DZ2kerpGYCia9tEC56GJlIrggJEHGFPiVB/A0J7p68cg?=
 =?us-ascii?Q?Gz1sKgH5mK9slhklR6U/XGRyG+EYvysRjjRAdE9/+NzJTQige/Z0iT+UkukG?=
 =?us-ascii?Q?tvTCN1DWM6W2QdOSWidlk953PVTsQvgKMORUPAdaGkgRTKtqg/SuB+ztM9A5?=
 =?us-ascii?Q?6qtnwuqSEsjyRKuNJWuN4WBql5i+zs3yPh81AVxXNNR8bMrknCk7NNd0geoW?=
 =?us-ascii?Q?e8MmaBkiGgAcKPNXayKjljZM1+E2uvvInidG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hSTXXcTAQuAeSwnakQYDPnDl9PZqEMY1x5PTktbT3ltTbyiLrPr6X9yjnB1?=
 =?us-ascii?Q?SL4jqdrjD8tjxf1iAyhuRIuq9dPy+m4LqL03A40STpoKLg2StbatUBGfXRsi?=
 =?us-ascii?Q?2wqz00NLWNn9kvFJhZ5ObQP8ikXFOC2u0eqJKlx0SXhdmqrGjU2LLOkIXw+T?=
 =?us-ascii?Q?va+fhTtxq7jTYlFuW6IfIxsOdja7WTaXgTnG5wzMnQRxtUjdlw60KlqaMYWy?=
 =?us-ascii?Q?gaTZsjWjJjRG4RkoFENbNXivKkci5lmSRnKAHDnu+tk+yFCW/gDo5fHhBT+X?=
 =?us-ascii?Q?fOpmuq/ld8+XWh3Z1CaXkgOy3/kj830A0I/KuqpnpCi0TVp3mlTsVcNZdhcJ?=
 =?us-ascii?Q?2jDJidTMt6DpFEQ0fIOLckDGmiys6XecVDMP/Bx5Q7qnR14d87/twH0LTAmB?=
 =?us-ascii?Q?1Arq167ZG1z9hfgDy8EZwL1phZVUQFaU4bCX7KVVjiY0R6ykRdtlrWR6DauO?=
 =?us-ascii?Q?30iP/+ixct+g2b6RWe2D7gzg5WA4QrvGi+tPx8vHp0MDZHyH0/r/TJdkfHZn?=
 =?us-ascii?Q?mWtZ5nkmYe/58eotPSDSjPYJLTj4HzVtLlmiCWZaaa2NQof/gkKq2UulnIac?=
 =?us-ascii?Q?B8hivy5VEZnPQOmGA+Wu3yMIUuu+Ed71JIzjnYKxGHyyHSBnh+eG09Bzp2Mw?=
 =?us-ascii?Q?LaBMVuKp8ySskZxVrR9/bUen0Wm5Zehh/kCeNJh8NQXtJsYauaFIj/Z02C0r?=
 =?us-ascii?Q?ZCZCPvzWhJEVRCfddim/E6ypfqz2cUm0RVeskVkjs1pjdZhp1Ii8rJMhlkJ6?=
 =?us-ascii?Q?V3iJbPZH8Ule4rgLtG9oD7/3RURfNnRYdzHNlqghDtm73cPeFYhYLu0DoIqH?=
 =?us-ascii?Q?twSgZI/r6iiMCmK2Trm+hhR7wI+XFTRWtK4E948okQIhEuxyvenhFdFbwoTz?=
 =?us-ascii?Q?WvFPdUr09VLwcMTB1LUS7sWRNm51xzyj/EDDCOWzxwF6eli+vPQAmPD6yS5p?=
 =?us-ascii?Q?YoYMPnjOQ3sCS6riRtXE0J0YFRcJHFhS33zO3GmdUNx8wsrqWsLFElPwjDvy?=
 =?us-ascii?Q?nh5eOawzuufk536GpQuRJHxJYfsBJYvk19SAiH69tkM8vxUvJpJljXglo/05?=
 =?us-ascii?Q?3B/zZ1OwGT9ctrz6rgapUm4pXivpZRDgc92Bgl9J0e3QDRULIZ2UtzYnuhP0?=
 =?us-ascii?Q?EwRj9XeTgDLjH1lZxDjxSf9hZV2IfUaE3jqQ3bCXaSzf65dtlzO3xjRuIlbR?=
 =?us-ascii?Q?Q6OkvjzolF3z03RMUC4z4S986PEquUkedVxQAv04afboznDp24buZqbHkK/H?=
 =?us-ascii?Q?dpS8ZClShzgxdRLVHdKD4Q38GlvAMczf07kSmIPntsqF6b6GW+UPetrkdudi?=
 =?us-ascii?Q?i2Y0JO9h3TGdQu+dIaVOc+mWd4kM8UpaxQ9zcr4qxB575eBljAN/NpYk0Bh8?=
 =?us-ascii?Q?ogz4f7N9ySeEQTj4JtayHOPYyi8inMbncQmrObhEZ+JygK57XaPAnR9SFtBa?=
 =?us-ascii?Q?P7ao1Pz/96joWooKNXQtLuvy092QgQX9CBT4MVC5RzblGKaoqGQCPeAelbJd?=
 =?us-ascii?Q?mNOXyi9DLB97nkPCAR4Jt5gHuDfv8nNda+n70QmbOcjS/+f9oTsYRlE323fk?=
 =?us-ascii?Q?LGD+QAAnRQJG2z66Y4W0IZdEGU7Lezr8w3gi7Zep?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f96f054-f50c-472f-1402-08de311a0be9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:41:47.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKICzqET7Gh4uI4eRRN5i5eYiq7OMskj+O6uWdB0LdDOOWDmsY3yVcXb5zwicswtPWUQWKItcjX7DD07sGPs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8325

On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> for the MSI target address on every interrupt and tears it down again
> via dw_pcie_ep_unmap_addr().
>
> On systems that heavily use the AXI bridge interface (for example when
> the integrated eDMA engine is active), this means the outbound iATU
> registers are updated while traffic is in flight. The DesignWare
> endpoint spec warns that updating iATU registers in this situation is
> not supported, and the behavior is undefined.
>
> Under high MSI and eDMA load this pattern results in occasional bogus
> outbound transactions and IOMMU faults such as:
>
>   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
>

I agree needn't map/unmap MSI every time. But I think there should be
logic problem behind this. IOMMU report error means page table already
removed, but you still try to access it after that. You'd better find where
access MSI memory after dw_pcie_ep_unmap_addr().

dw_pcie_ep_unmap_addr() use writel(), which use dma_dmb() before change
register, previous write should be completed before write ATU register.

Frank

> followed by the system becoming unresponsive. This is the actual output
> observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
>
> There is no need to reprogram the iATU region used for MSI on every
> interrupt. The host-provided MSI address is stable while MSI is enabled,
> and the endpoint driver already dedicates a scratch buffer for MSI
> generation.
>
> Cache the aligned MSI address and map size, program the outbound iATU
> once, and keep the window enabled. Subsequent interrupts only perform a
> write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> the hot path and fixing the lockups seen under load.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>  2 files changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 3780a9bd6f79..ef8ded34d9ab 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -778,6 +778,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>
> +	/*
> +	 * Tear down the dedicated outbound window used for MSI
> +	 * generation. This avoids leaking an iATU window across
> +	 * endpoint stop/start cycles.
> +	 */
> +	if (ep->msi_iatu_mapped) {
> +		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = false;
> +	}
> +
>  	dw_pcie_stop_link(pci);
>  }
>
> @@ -881,14 +891,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>
>  	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  map_size);
> -	if (ret)
> -		return ret;
>
> -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> +	/*
> +	 * Program the outbound iATU once and keep it enabled.
> +	 *
> +	 * The spec warns that updating iATU registers while there are
> +	 * operations in flight on the AXI bridge interface is not
> +	 * supported, so we avoid reprogramming the region on every MSI,
> +	 * specifically unmapping immediately after writel().
> +	 */
> +	if (!ep->msi_iatu_mapped) {
> +		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> +					  ep->msi_mem_phys, msg_addr,
> +					  map_size);
> +		if (ret)
> +			return ret;
>
> -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = true;
> +		ep->msi_msg_addr = msg_addr;
> +		ep->msi_map_size = map_size;
> +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> +				ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI target address or the required
> +		 * mapping size. Reprogramming the iATU at runtime is unsafe
> +		 * on this controller, so bail out instead of trying to update
> +		 * the existing region.
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
>
>  	return 0;
>  }
> @@ -1268,6 +1301,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	INIT_LIST_HEAD(&ep->func_list);
>  	INIT_LIST_HEAD(&ep->ib_map_list);
>  	spin_lock_init(&ep->ib_map_lock);
> +	ep->msi_iatu_mapped = false;
> +	ep->msi_msg_addr = 0;
> +	ep->msi_map_size = 0;
>
>  	epc = devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 269a9fe0501f..1770a2318557 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -481,6 +481,11 @@ struct dw_pcie_ep {
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> +
> +	/* MSI outbound iATU state */
> +	bool			msi_iatu_mapped;
> +	u64			msi_msg_addr;
> +	size_t			msi_map_size;
>  };
>
>  struct dw_pcie_ops {
> --
> 2.48.1
>

