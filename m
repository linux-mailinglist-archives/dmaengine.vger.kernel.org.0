Return-Path: <dmaengine+bounces-8632-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKeaFXcEfWmRPwIAu9opvQ
	(envelope-from <dmaengine+bounces-8632-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 20:20:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E184BE11F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7A71300B508
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBD3876B0;
	Fri, 30 Jan 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LUzqOzfs"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE23431EF;
	Fri, 30 Jan 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769800816; cv=fail; b=FhrI53bMer+8UmO+yuSY+uVzlb+lMG422wpmtUWSknhshqeE6g/F2xrf9IeeBhE7i9IDeOwRZGq7ujOTdN1TGinPGxOIm5B3KB7GdnuJpTEZq2qmGd4F75Pe10A30uZsBv0mEVeAeMu4fTYdbm7QRFkpPzyW/SBuUt3ha6FBOV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769800816; c=relaxed/simple;
	bh=AU7PhcDfPbWo00/XV5xVb8CD8NNaQOQtcgp1UHWUMJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+RYkTx9LB5w7mJnciIV3tck1Zi0DcQ6hAORomg7yCjc1d0hyAGATJJks2xtSwni0/9RBLFxuBcCT9E4jXr5+8gCx77LGWILcL2lXAVuojh8vxBfb9oubdPCMRlX2fIXjpyZNL0KE6hL8Sjxe5dhJVJwmD2nuXz1MZOsWtKkWqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LUzqOzfs; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPLVli/TYdsMZl0pVgx10OpMbB7etSUEAMfsL4iSbwnb+JN/jS5mIthSXui5sRApSeVWqX6QUfgmIooCwROyNpzLsF8m1Ja5Ek5vvzhJ4PESDTGkXrq4ucmHS4vVbrgQKg8TU8wMXof68XxCuv2U9kiHYAVeBVOi3SCri/4qK8MhZcY7ikjuP1/HtxXqhwpSy34ivOeNbFuDKJbPAGAfLCmdf7rlc1dJn/opw4wMCEO8aKyaSHAGsyevdokerdPRK54gvMwWhRDufopXQrlhlRAJjn/ZQwNCnyM5Aoj+nBHJ91jUiF+MPTWACvzYYi9ot4HVepM+pG+Mjl3AlSWVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iXcfhUO+aNfRWufSV2ZwHFJ41ttxSrK/r+nuEgOr0c=;
 b=OOe+QLkLlyPC8QjcaHchnxgp6LzkUd+vZl16hBndr84yaNhHyeq2jbPtnvFc374I5fY/zywGwo1O2u/Hb7z2vZe6oDF4EK9Cno8g6pbg0/SBKCNcP+uNAdDcfgrLz99vTDj6qln38aPu+gQQGPf9/JDr6IYP+dSIBKtsX4PVZaVmRatD6cSXuj31OBEma7cxY6xQo3oq/v+yci2jM1JP7AZXD8mieMxRub7hyIBF8vR6HuR9Y4gNh0exwPXVdgLvxnSZTm9ZqW0yUNW9lT+ioOkBKydu3oTeMoPgP0DjazK3kWd58lU0VE30B+9ccr3QMyH4n+B/9XUWhcVdEh387Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iXcfhUO+aNfRWufSV2ZwHFJ41ttxSrK/r+nuEgOr0c=;
 b=LUzqOzfs2FrJPyBapphgA6OS9ZcbEgrtysu5z/MXxb5hSTqQlbTHCpC1KtFbjyRcrBLI/oR6JHyCkCVZrI7EyzyzR/nygwkdYeYOIOj409wxuIAIn2YfwegyzjkzytYQxN9krU+npmh8DSe0ZL4HZoBGbYjpvUXJu874RYuqd+OHtQQ4J/7TRF908yuT5IILs8C9lANzYQxWs9vG3UiGzsHRLM8wZgfiLUB7Dbu+JIgkx0mEDXzrBZuZd+5ZgEW9N4NKQKKhcRVz1VaRQ5xwzWd+A9JM1i8+OokIkxXQUzdC5Ssz9c1xVLj1uM+I0Fzq7iU/4XWb4JPmyU3dgkzNOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8157.eurprd04.prod.outlook.com (2603:10a6:102:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 19:20:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 19:20:10 +0000
Date: Fri, 30 Jan 2026 14:19:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aX0EXjM4LlO3Hygd@lizhi-Precision-Tower-5810>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aXD/EYqhhRJEN8oy@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXD/EYqhhRJEN8oy@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: be7e65d5-5353-429c-cf85-08de603495cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cpIrGDs650IFBa+361QfFtXyupR0UnPXKYODFK8o6swbKS6RMKN3qI85ggS9?=
 =?us-ascii?Q?TMa4xVNAFyy0WzpwBKJvDrXwuwK1JpC22gcHL0vYfLu/ErCOMpP7zHAuxDgn?=
 =?us-ascii?Q?zmT0Mhyrxvd9pZKZ1LW3VqIc+V5mShJw9vMU+s2fkJL7bOIcdbYoJHc0P4kx?=
 =?us-ascii?Q?iFOl5JU6Z/QOMRUEJKApTxsPfL6Kf6tnVeTCkd0lpRMk4nb2hGMAquRu5Ous?=
 =?us-ascii?Q?HpmAE1GF/oPme0Wy6kw/6lMX9xjKaHNfrNURIjHQKtY3RTtmgh5+24JKpk4C?=
 =?us-ascii?Q?GuNRoBj9hbd7jCO+C8Th9h0SZKlRsXy+C1OnpaWFQmeEXXfagL8aiJh6+VGU?=
 =?us-ascii?Q?ZsfRGgtu+5DpPpGep4RL4rv12CegdKv9R8RChsxAaRCCYD1NCRzGfjaZpuKD?=
 =?us-ascii?Q?xPXd5IUDfuW8oKyKceyZwwP8DhXZgULQQvrr8o8CZ08G3+fPOB/0wlCmlBxg?=
 =?us-ascii?Q?ajPk4Woo4NmL846h5lCBFMRDBLK3sb+vvMuw6bYxNv15aosdZz+cuLyyjq9T?=
 =?us-ascii?Q?m3b1H5ErJMFprm5eNO4QjR0gTv1Sxb8RCAybzE31M/3sY2J0MhBagzTA2GfX?=
 =?us-ascii?Q?OWgUrVxLXJ4uvkjRog41F2Iv6MR+opJtdkDVe3L85N+iw0RHCiRF+E15l9z4?=
 =?us-ascii?Q?dpYmFHfo/s4Hm2kDkXOxPyV9LIq9C19rbrV3rk9jEU4NY6Mdigf+cR015pgP?=
 =?us-ascii?Q?VIwvpVKTvMqcruOviGmN7L3BJL6xSBzmXO5ggXbZo+5PbsVoFyEM9hDlFIxh?=
 =?us-ascii?Q?oLqilljQOduPJs8/fcyo7KT9m4g+u0lXr9qle2wm0tES7KEgJwASliN2vqLS?=
 =?us-ascii?Q?kUXSGR9YBD1Cce7VfjnWGRXexveUaUZqoKzXc4OCDXtm7HgUxLPO8WUbmiJX?=
 =?us-ascii?Q?ze0CddRz4pIMrKDdwPhMt0NXSS1leozwaIVQ6Y0VySAPvAvM4fy9yjZlDKUM?=
 =?us-ascii?Q?pdxXAoeTKRKoX652EjmrXJMbLGi/Hi3Quscf9yoRd2MF5hfnsTQ2kDlAuTvz?=
 =?us-ascii?Q?ATnbGXukDPKYYT00wRb4bjw8/IwFCfXPt25zO83feVsAtdHUBZfMv14usHoI?=
 =?us-ascii?Q?x51p3/bSCO+hIOQvE+I6XkmWkJuW5kpf8gka/QjSkD5d+l2RT6s2NU6Peyx8?=
 =?us-ascii?Q?enSyqp7HrKR4gW760/mGzxzdGhIbtEmJK1gpb9IZS9qi3Jxe7PKy3bhk1dt3?=
 =?us-ascii?Q?wUXyEqyQW4Xi8BVReIWH3iPFrMU076PoYBEe+h2q8/rwvyUWGPrH22PO2VUV?=
 =?us-ascii?Q?h0wWbeYmjnVz7H7lLYHgCj02CHJFkE5dERGNGUjZmDSYRJG8NBdVoUL6A58Q?=
 =?us-ascii?Q?1os2GqWe2GNOh2QpmoQSgunY/JrorzFfRmcHu3pYLdqL9FBz0V18nvS7WUJ9?=
 =?us-ascii?Q?M1/OaUHJYAK8oXkS+IA2eOe/l71EKLI3/UNVkItjRujXQPmOnVKH3B5Fw34O?=
 =?us-ascii?Q?1LS9jadC1MZzzj8hDEGOUgQ8sOWKoYzLhyJDyQ8GMDvPQ2dgeW4ul47h8ZTy?=
 =?us-ascii?Q?gtXPfgzUamNajKyueV4ZYWJw6d9uWX0AsohhzDt9jl5CGkN+NzgPM9ILOtzY?=
 =?us-ascii?Q?Q0h79YyiVJ2tTMvTPqh6daevp40lRYNh9GnBFC8pbj5C0KzzvOCXU0uw0y6e?=
 =?us-ascii?Q?G/WvFdq7dt5luTX4oRjAQfciHxNqG5yTB5Gp9M/kwbzO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OaCmW+A1hWR5RORcRGK6LhMkCJ7ztVPBEgOhYX1Z+UaHWlMweTFB+cz59u6C?=
 =?us-ascii?Q?LoETk2nXqPWz1stbVffhRRKjxRCZR58pw9BWksB/CrnbGqMG1f50r15rlh1D?=
 =?us-ascii?Q?5OYJqna1C7XniewY1b1SjHz7//61BvPfXqtoK1AmfPFSTxH2ATx9d3ptCwyq?=
 =?us-ascii?Q?oeLzEoddkggKQtEYr93ytlqWB9pPtraRaXCYVKdwaAX/YmUM9XxfQnPqSyVc?=
 =?us-ascii?Q?kWhGzBPi4kOd+vDCMIy5V4NeOu6MmeNg8qlNf1Mj4JLoN3ShpmWcC/6cuznF?=
 =?us-ascii?Q?5JZFKGu15buKFD+RqcuM8i3Uh7nUhL+1Zz5aimMjv6S1Ffh1PjU8IwAWKhof?=
 =?us-ascii?Q?2k8uhpZSBCeHNkVO1CcNKKhpqsx8/3AIXIZUUflJMU5uEAoSovXuPxmJwhyF?=
 =?us-ascii?Q?1+RTZ+fUj7I2H0mBi8UXX8oUtxcUEQrXRqlucWAkKp2X9Uj/KM38ZhrKZict?=
 =?us-ascii?Q?q5SAWFoVozh0j2hf9V+sliXhvtUBP4TfRov2crgLSG83m3bTwO4KpEoIQJXb?=
 =?us-ascii?Q?5M7uvYb8b74FxQKOfg+Q1oAYPEeMy6rxXfy+CYQxQxbaoI041SOiC5flh10g?=
 =?us-ascii?Q?XTZLPrF8szNLUkV7WW1HsSO7me6v4Dt2P92TN4ossFwqKrzaj1tpETe2Z48S?=
 =?us-ascii?Q?Le/diSmvc32JRDUoLgb+J3QQD83Ti+pieY0/y7lZ26ibwwWVunbVErhADXNr?=
 =?us-ascii?Q?hwdbBG1nrNDDqfZ9mmepTc6kQDoDC6+AuQ8sxmkjMkB9q+9BwDeTUTPkT4LB?=
 =?us-ascii?Q?0un7Tq9iHKWJhUh9EQtT9GaYeYv4oAaO/71NfzY/RjV9PAWvtdoSid0SrfSN?=
 =?us-ascii?Q?E4b6+Wg/n5vgPXYF0fSo6w0+ItykKvf2MKb+svv97WLLE7wMkqv28sxPf0yo?=
 =?us-ascii?Q?rad/dccJyTh3iY2Ean073qtrg1Ht2/QYV34YWnhvxUL7eIp1mDutaaGoco5V?=
 =?us-ascii?Q?ysox2iebMOOyexLjczckAkuwlQmtDUTl7MHgVFVnO8B3doS+X0T22TCMyvbH?=
 =?us-ascii?Q?qAgFEC9Jqp/7t55+M18hMNRmZ+E4IcGvleaLIaXn3zKWpUse4D9Ws1KdGF3x?=
 =?us-ascii?Q?2UM7XZ0jO5unzKHkgCIQtUON1d7tFjoJJDtUizpjkXqnElNysNyXcNorfxFw?=
 =?us-ascii?Q?2jpA23PnI0VJlbJgnaDzlGwsTEnjOf2x4P79qGH9rGUY8cllTf6qQw/UOjFA?=
 =?us-ascii?Q?8baSfH2nLqlTT/P3Nfoy5q6sO1rAWMaH4+8FoenRcccOsbxruw3r+oRruD1S?=
 =?us-ascii?Q?lU8CWdWUYuY2ZBJvJJMbF2mvfTp1FlpVGEp9O8fWICiEqQCBiOGOG7QK1tW5?=
 =?us-ascii?Q?+uxRsPmevOzXHJz2/rWguCFcsqhKosTKNst66NoKOHVYT12vvK+mcrQEJwhZ?=
 =?us-ascii?Q?MJdPGzs6V6/Osh+RdC56LVhGcTsAXsVSlYGaBnlFm6A2q4xl/3qO0tBr/4MC?=
 =?us-ascii?Q?E8dbVOJQZorc5aOqy5g8WqrcGni/WXKHYRo2reL3SPdYb+oAHvwluK876Ztx?=
 =?us-ascii?Q?hruNqaigS+vUBpdS4RUgUY1zfKMkWQIkZ/8r7xggMMJhf5Fi2EXYgtP0unmm?=
 =?us-ascii?Q?vT7C0jxW2endfu/gzC9G6MQXiPZto4zpV9qsv4Zg6faBPoKadcZc81Ju6p0r?=
 =?us-ascii?Q?jc6btpCh9yF5rVQpAOiW0cn1z/Wzt6NJL3Um2nDBYJ7LLCtkaLozi119QkuB?=
 =?us-ascii?Q?tAFOigFBYCCscp96SHDb6t4aQaWsDfZsnmHcwHDOBNFXmVBn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7e65d5-5353-429c-cf85-08de603495cc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 19:20:10.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZn5laUxKyzZ0mwl/dXHRU3jly5x64lZPm5J5sxD5qbHYfFVHkmKEKnxXTgPt4aHpHxNl2/MFBYUR24jCNvrPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8632-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E184BE11F
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 11:30:09AM -0500, Frank Li wrote:
> On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
> > Previously, configuration and preparation required two separate calls. This
> > works well when configuration is done only once during initialization.
> >
> > However, in cases where the burst length or source/destination address must
> > be adjusted for each transfer, calling two functions is verbose.
> >
> > 	if (dmaengine_slave_config(chan, &sconf)) {
> > 		dev_err(dev, "DMA slave config fail\n");
> > 		return -EIO;
> > 	}
> >
> > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> >
> > After new API added
> >
> > 	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);
> >
> > Additional, prevous two calls requires additional locking to ensure both
> > steps complete atomically.
> >
> >     mutex_lock()
> >     dmaengine_slave_config()
> >     dmaengine_prep_slave_single()
> >     mutex_unlock()
> >
> > after new API added, mutex lock can be moved. See patch
> >      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
>
> Vinod:
> 	Can you take care these patches? At least first 2 patches! So
> I can did more clean up at next kernel release.

Vinod Koul:

	Do you have chance to pick up (at least first 2 patches) for 6.20?
So I can start do more cleanup work.

	There are two serial depend on this one

https://lore.kernel.org/dmaengine/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com/
https://lore.kernel.org/dmaengine/aWT4p7RnFykJnuOz@ryzen/

Frank

>
> Frank
>
> > Changes in v3:
> > - collect review tags
> > - create safe version in framework
> > - Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com
> >
> > Changes in v2:
> > - Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> > - Add _safe version to avoid confuse, which needn't additional mutex.
> > - Update document/
> > - Update commit message. add () for function name. Use upcase for subject.
> > - Add more explain for remove lock.
> > - Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com
> >
> > ---
> > Frank Li (9):
> >       dmaengine: Add API to combine configuration and preparation (sg and single)
> >       dmaengine: Add safe API to combine configuration and preparation
> >       PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
> >       dmaengine: dw-edma: Use new .device_prep_config_sg() callback
> >       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
> >       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
> >       nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
> >       PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
> >       crypto: atmel: Use dmaengine_prep_config_single() API
> >
> >  Documentation/driver-api/dmaengine/client.rst |   9 ++
> >  drivers/crypto/atmel-aes.c                    |  10 +--
> >  drivers/dma/dmaengine.c                       |   3 +
> >  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
> >  drivers/nvme/target/pci-epf.c                 |  21 ++---
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
> >  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
> >  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
> >  8 files changed, 177 insertions(+), 84 deletions(-)
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251204-dma_prep_config-654170d245a2
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
> >

