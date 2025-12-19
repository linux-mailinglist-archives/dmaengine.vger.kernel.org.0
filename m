Return-Path: <dmaengine+bounces-7841-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B2CD04D7
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90DF30EF21C
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696933BBD2;
	Fri, 19 Dec 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eM4Xs3FI"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735E33ADB1;
	Fri, 19 Dec 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154691; cv=fail; b=oLeYJ+2SrmHnFKZM7qm7//3gT+r8/5QSDJFDYa/nW9r25aEXAWKXtuf4rc6/1YIM0dQbv2+xGvy3ZuVeFRxedEjfYJmKZjchNbicSRl+2HpYQhARa/KAk3dpFKCi3Rw8jeRG5mpmnRG5GQTsGDE1a2oORTiXN5r95LMkJsUxk8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154691; c=relaxed/simple;
	bh=fnDXsxD7I2bg2FR2+0YaW+19cpNqfceI+nPXhoGoHsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bL6pX0ScFhtsX2XDvlzoUyhyfMfjNGNpPhcE+RvxsUxczfeuxncWLlBqQtds6sCGrdS5CXf9UkNq7fwDDVhGKCuVBTVd11mXGxqdv+umoHg2n/Y2I/Pj/sec1codMwKyfGHMEoJOcVNaA7mUTYbeRucjAppmJWbggc2Z6Jlpppc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eM4Xs3FI; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/rBgLFdmxyzV+ndQXGsx8aDimt5C0pvK5p3uqV/aj8PRV8p/x0lh246mzJDgvRMakmZED0+uyQ/ZL8Irt2ITlJ0iH7zX2Jc2Qw8NucumCXuYIqyin9rvRJRrha/Gp40WK/xzo9KQSxY2F9QLfJpGqJ2efcYzgBIufoJCt0dAd9kJ6Vv7AD7nU+q8sNw2iDw97cO2SbNIHgeL9oqUajq3tG2GQgWhLRx8wfh5sbc3Eeicjuy48IR8GYWfPk8TGdfor9d9Tn5HNeeJvFO/OhlmhwSqYksB34lvwJSfFFlqdvmVkIBdfHMMU9LMQEMsp8P995VWRoCGosSsUbNSpefGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfnxpmtpIZmkyItTbitl66X0BdIpszZOCIl8h9MEA5Y=;
 b=ZSuAHDpnJYSPHLt6yHpKzisrj++eyP6OtU7cMByXyPkmb8AWaL8ydhLlEEO0lqzPbQitOsWFtQOLoQm+oznoRlXfE7pU3YTn/oHTqaiBE/wBnUXFFe5S6kVDm4U2E0Yd76TcEtHirvaiGmY28brYXo8KZwkIgV72uoM2Rz7GG7PkSeLzJLCT4dtWLcgxBSdTyTknjzD36h7gkepqzm2IUb4Dvt2mUjpml2nSVLQ8lYClVPYyegkuChsOYcbMI9k3f3haQfWnmiQRgF2h5133z1YLEuR2t2fpDfxyPBqSljn8ZDBKvGWVQHmY97dcO0KYwzUvLyziHOuwyIESAGtm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfnxpmtpIZmkyItTbitl66X0BdIpszZOCIl8h9MEA5Y=;
 b=eM4Xs3FIiK+KcJmXGPMYUQHM7OYxqBWCBS45ibQgKXu9rs+HydmwkDHJHxM82oGJ1aguUE28pU6k9UEJpoL2kPmTbdOh3VAAnfhHFst5f1zcJj6g2TL8MNifR1UICqb9ZXRYSoweUywOXCU1I/sr7reRHPVvVVV31fL+hZJjC81XyXu11JqYbzmpGJMwWh/aWkyhBqL9r0VMTYTr4mmzuOD5T0bO3tQ9CuTEyapsUYQAZz1UfSkvJy4AJp0TFVh/vKchrpq/3syxfgLpAZ49yXALz5iT0+9kpFY6QF7MODBwnMWFiZophtd7orDtIM1qyuqsf3t2c4GGzL1gnpcbdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB10006.eurprd04.prod.outlook.com (2603:10a6:102:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 14:31:24 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 14:31:24 +0000
Date: Fri, 19 Dec 2025 09:31:11 -0500
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
Subject: Re: [RFC PATCH v3 13/35] NTB: ntb_transport: Introduce get_dma_dev()
 helper
Message-ID: <aUVhr33M86WCAIqZ@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-14-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-14-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:510:325::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAWPR04MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee4069f-155f-49c5-bc24-08de3f0b4967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GN+HtotOjjyfr6G7byFZmnAOWNTd5aXLVwu1uRMxfbP74CC/PcQpMYmdJkmh?=
 =?us-ascii?Q?Mygbh8dJhwvNnoZQhFme/Jk8a8BZtFHYz6O3CsWrSuf3Eyk11EGDO7fAsz/E?=
 =?us-ascii?Q?cFa65xy09l4Qb0Iej5IZ4j7qGir7ThQFvCVXt4Hw4sfZPo95cta3vA9rN08I?=
 =?us-ascii?Q?UOVhuPnpgbTAd9uEpUWrF7zq0prFIAkADqrkziAl8/4lN5bZknJc0crNu2mf?=
 =?us-ascii?Q?nKduY3f359SZNvVib8zl3cQBjfNBrSyMwoZnA1UUrxumpAWAcs5s1t8CP9UW?=
 =?us-ascii?Q?YcqvkJzLArUkEyZizE6UK31/bZNCWpzMq0s4QNrT0+u+9BVjLY776PcSgADn?=
 =?us-ascii?Q?jW4k4Mns7QCv773cTSO+fdDT9N75QrO/g0ybDKsBVjauU04O+Q9LIMjTdxQW?=
 =?us-ascii?Q?AXxonJ+3MtFhe5mKR239tJrBcJ8HGV36tw6XW4SmjFMrGmHH0B7WX4TuQfF1?=
 =?us-ascii?Q?hIDFYTXWDfFAWhuyyacXJEh9XDhb3MtkrGDd/wcmlfCOXjz67oEveYnF69vn?=
 =?us-ascii?Q?TBpYxUdtIaWA4g8a75rLlIxm5JQ1I9xlYOGziYt5iSHsI30XkzSV8G3dvDk3?=
 =?us-ascii?Q?tRmY70EQLwEEz9Ch5wgXTRQa6b9aout65lUjElBKkyJrtTYsPscazvIDIeSa?=
 =?us-ascii?Q?CetWqRtFvdTlfznQBu13EQa9WWlZPvctw4Yb1nEimxMaE6QrKMMkgZ4H0vMB?=
 =?us-ascii?Q?D1z5lVkma5qo5JdZygyyRMmG/y6wD0rdgTt8rbXbj63CIUeqa37YvI4s6mwt?=
 =?us-ascii?Q?4RxRPyFdIDR7/kf/qzSTwtiyw2QGEY80i1cPrSy9sroMfopCVRtd7qPCXcRx?=
 =?us-ascii?Q?7VUamU7XcXJI1y/251qoAIwPFiHSIL/XyqS3/NlZKvP/mEwGS0o30rXAa6Zb?=
 =?us-ascii?Q?ilJeIm68DLhyM1hKqV4G72RLCw0N/JCd1ygOsZtlgRA/PMZ7WZHpAFEwX6+b?=
 =?us-ascii?Q?0i7P+OUx7s9SjZP/cE05IfI2yuWD73r3eDIYF8bi8ZrXXqZ2FrEPY0DiHypj?=
 =?us-ascii?Q?zL3pg0OLR//KwPqm5JmYtSFAlwedNpxpbLGnPnCinf72MWN7fjZxnMS3MRRk?=
 =?us-ascii?Q?cX22f4azfuE/WsuFIkLBz0LEaIBXqZ9APx0mV5BUqOMz9ut6p4RRfiL1s6vx?=
 =?us-ascii?Q?7d91yacWvZFdWx8SlezXL+JnsLiLpr3PhVpWOcJ3mwT6y4JfsW6nmuSGBwU3?=
 =?us-ascii?Q?nxkGGzdrKkinn0u09iwzEB9OCM5R7z5x4sypNbKmA0PEQSCVpI/GXVDNWazy?=
 =?us-ascii?Q?7/m7Tk7bbdVIEdcR2FYx6GlpOVv1QwbNH6qbATZJr8yCztwXvjT5lM+ovta5?=
 =?us-ascii?Q?UuMZ4Lyqx0KCHNFaIWcglHMwEdWTzu6n6cBibmJ8VAWzyYjx3GyTdX/bEwYn?=
 =?us-ascii?Q?9q5oKqu6brFQJpVcJUjCTD2gV7N34m5qHogkCNHRkpYaac4aXmNTAoiB4wiD?=
 =?us-ascii?Q?+rND3C0XbM8lqFdctQlkzHjeFFE4qdM4hNR3hNP2nhl4UoySNM3c7bvNRdAi?=
 =?us-ascii?Q?Hc1l+/gjVzN5MXHAgckJoZF32rYomIMYiaXr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfXMRcWqrXzHEhgcgD8XNAvbjOlG4GA45W1SXPW1VnW0210AL9Dekma67x8H?=
 =?us-ascii?Q?YCdLfz3rqbEnBe7nMoyOUiDANyhFLL+vZ9MW2yCKPUbyyTT9q2yRZeOk+hKG?=
 =?us-ascii?Q?GgnMYgFzjUDO6d3cpAhRYh+8mBAbwICQQR9b4HYhQM4M3ZXpxdSgGftxPe+Q?=
 =?us-ascii?Q?KnM9maikVeKlgY+rqgEVwTGf8QPJE1DcWZRPhIXQgy0Ljl3dul4yNrdoVyNT?=
 =?us-ascii?Q?XsZzVA1FnyKrQ5cdPTAnEoTmXZ2B26UJQmvrpIbwjavlejtaBYerbpA/9cIU?=
 =?us-ascii?Q?IMZNP1LrYT2hDU93xPiL49GsFxpobesj4qcnWuVYct5YX1BQNz8X+hY/D3T6?=
 =?us-ascii?Q?ypQxJCARHrD6DwwWUokMdVCblLgXEsTmEAIh9MgeCTzqY6naj+Uh1JIFrJo/?=
 =?us-ascii?Q?uPvEWc7VaugViNdwlAwoXf8pPxslZKNH4dEgWG+mnZ2EX7TAG5pb8+K6iU+/?=
 =?us-ascii?Q?Gb5E7GyIUuw6AEgP8Dhu1v6Nt//7dhPf/TuHbmTefAw15LmFn/pJERAralcm?=
 =?us-ascii?Q?zv7GJBhsFybOFG4Mnq7/leKyCNejP8ASNPXtYl/mddLeqhdcTe1PVu9RYdo+?=
 =?us-ascii?Q?spqVRsLb0rSELAUWMVbcxpB1ff12k7XjrB/DNJyhZFyRIn0N947tl1cHsx9N?=
 =?us-ascii?Q?xEThQtf72SnaHGy7fi8XwJbXfSNLGVLRKp4Bzofou9ItFJefqPe3bd7RYpPz?=
 =?us-ascii?Q?2NvBIcNoJ+P24w3Kw0jwEQYz0/7W5VCKBoV42zCjl5xolUm7r9YDCH0btiCW?=
 =?us-ascii?Q?vBz+u5cIQVwQUFaAYCy5acQUjoixCHLE+d5LEjLRS1p3WTs3A5GMNxZJYHsg?=
 =?us-ascii?Q?ZC+FCBwB83L5Q4Lm+nQUUTUpaVMLJnXhIh7som1PEBWs+uVZaAKZndnoA5v3?=
 =?us-ascii?Q?3VZDfSxM476V1YrlqmczBrpQKxj7vHUYPt6TvSs9i3PUTKKtoAPlQQpiT8Gu?=
 =?us-ascii?Q?Ptc8D8sqB4PCMQt/HEmBEtjg0U28Cu9NGahwHjlKs4E9NYIwcxFDrOZpxNbQ?=
 =?us-ascii?Q?7LDOW9rz2irT9kUPchtYUQQuZfxwdGq32rrs0gKdi0eymuMakaM2tU6AONw6?=
 =?us-ascii?Q?uObY49GSE2cG6yKQ+E2ChLGz96PLMx/nySJkDqo+2/NScGRWLfXxbhCAW7sU?=
 =?us-ascii?Q?B9CLZp4F7w7/p6nmk7gYxugDVASgMK/e1NuD5R/IoS9IVzW/OdNlUFkKpJyj?=
 =?us-ascii?Q?oMyhzL+B77FrE0n0nD15f7aqEbCyKIEpuiHBpH6USKQfxm9MhEmc+qgWgmSp?=
 =?us-ascii?Q?Hk6ABdI6aZVt+6+R1dqQZpDq7yKcH16h64PA0sp5BA1sYLCDlF4N/HFx2Icn?=
 =?us-ascii?Q?3zbkYEck3jfRg+PfDtqLxHitW5p+QT/LHP40XhMO7ec6RFA0SXf857a5+tn+?=
 =?us-ascii?Q?IgVuZZ05BEI7Nc/VGUHXXStgig/OsfaI4eIrL7O+ex7cpilb0acfhNxEiAtN?=
 =?us-ascii?Q?KtuUxFsCxa7y5ZRycnwbqZdUlQ1UaEDNPUeLoNnhvyyFW3YnqcyOBtx6ZNSx?=
 =?us-ascii?Q?wLav07EFF/S/A3ucAhdqkfi2ZPtrRxiwDkX6CkP3XjJ9yocnSS+yyuutQ/6T?=
 =?us-ascii?Q?OoLUzuY/T/Iy/r66oeDoC93gFeupWc6BmNehJ7EP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee4069f-155f-49c5-bc24-08de3f0b4967
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:31:24.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Is9KduDtS/+dVa8qx7cB1f8VGxN0iq5MJEUMF9ZFYsxWlRngcKKXoShQWm3lqeS68bBI+3xZPMG1GsztcvEuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10006

On Thu, Dec 18, 2025 at 12:15:47AM +0900, Koichiro Den wrote:
> When ntb_transport is used on top of an endpoint function (EPF) NTB
> implementation, DMA mappings should be associated with the underlying
> PCIe controller device rather than the virtual NTB PCI function. This
> matters for IOMMU configuration and DMA mask validation.
>
> Add a small helper, get_dma_dev(), that returns the appropriate struct
> device for DMA mapping, i.e. &pdev->dev for a regular NTB host bridge
> and the EPC parent device for EPF-based NTB endpoints. Use it in the
> places where we set up DMA mappings or log DMA-related errors.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index bac842177b55..78d0469edbcc 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -63,6 +63,7 @@
>  #include <linux/mutex.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
> +#include <linux/pci-epc.h>
>
>  #define NTB_TRANSPORT_VERSION	4
>  #define NTB_TRANSPORT_VER	"4"
> @@ -259,6 +260,26 @@ struct ntb_payload_header {
>  	unsigned int flags;
>  };
>
> +/*
> + * Return the device that should be used for DMA mapping.
> + *
> + * On RC, this is simply &pdev->dev.
> + * On EPF-backed NTB endpoints, use the EPC parent device so that
> + * DMA capabilities and IOMMU configuration are taken from the
> + * controller rather than the virtual NTB PCI function.
> + */
> +static struct device *get_dma_dev(struct ntb_dev *ndev)
> +{
> +	struct device *dev = &ndev->pdev->dev;
> +	struct pci_epc *epc;
> +
> +	epc = (struct pci_epc *)ntb_get_private_data(ndev);
> +	if (epc)
> +		dev = epc->dev.parent;
> +
> +	return dev;
> +}
> +

I think add callback .get_dma_dev() directly. So vntb epf driver to provide
a implement. The file is common for all ntb transfer, should not include
ntb lower driver's specific implmentatin.

Frank

>  enum {
>  	VERSION = 0,
>  	QP_LINKS,
> @@ -771,13 +792,13 @@ static void ntb_transport_msi_desc_changed(void *data)
>  static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
>  {
>  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> -	struct pci_dev *pdev = nt->ndev->pdev;
> +	struct device *dev = get_dma_dev(nt->ndev);
>
>  	if (!mw->virt_addr)
>  		return;
>
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> -	dma_free_coherent(&pdev->dev, mw->alloc_size,
> +	dma_free_coherent(dev, mw->alloc_size,
>  			  mw->alloc_addr, mw->dma_addr);
>  	mw->xlat_size = 0;
>  	mw->buff_size = 0;
> @@ -847,7 +868,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  		      resource_size_t size)
>  {
>  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> -	struct pci_dev *pdev = nt->ndev->pdev;
> +	struct device *dev = get_dma_dev(nt->ndev);
>  	size_t xlat_size, buff_size;
>  	resource_size_t xlat_align;
>  	resource_size_t xlat_align_size;
> @@ -877,12 +898,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	mw->buff_size = buff_size;
>  	mw->alloc_size = buff_size;
>
> -	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> +	rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
>  	if (rc) {
>  		mw->alloc_size *= 2;
> -		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> +		rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
>  		if (rc) {
> -			dev_err(&pdev->dev,
> +			dev_err(dev,
>  				"Unable to alloc aligned MW buff\n");
>  			mw->xlat_size = 0;
>  			mw->buff_size = 0;
> @@ -895,7 +916,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
>  			      mw->xlat_size, offset);
>  	if (rc) {
> -		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
> +		dev_err(dev, "Unable to set mw%d translation", num_mw);
>  		ntb_free_mw(nt, num_mw);
>  		return -EIO;
>  	}
> --
> 2.51.0
>

