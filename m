Return-Path: <dmaengine+bounces-8308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAD6D33504
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EEAA30963D0
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519329D267;
	Fri, 16 Jan 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GlFLfy2y"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E5171CD;
	Fri, 16 Jan 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578335; cv=fail; b=PGLnpYOqzs/g1LI/uaZfilcZcd9wwWY9vbYmAxVmdCVtjHGP/SFBlItscNSNZwotN/qQHsSXVJbtTXD4askaHQUTGNW/cuta5/kCUkbuSeT1j16/Q/m9rkUNrPkdyma0MhuPclkx5OdZNxrJiLzOuLy+MJirxU2cPGi3wJOB7tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578335; c=relaxed/simple;
	bh=7otTCsvehKjJvESplye1Y9BHC0sjWfz7/hmwU770CGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxXdGvHJTIEhs4IsInl8FcVj461ylG9chndJMQeOOaeaM66g5WrYP7E4lke4zg6UQbd6ligBjzc2qYbuhobGjt+V0of7heE3l5tlceczdk629ntHiy8N5G0HLw5mYzwlUA2Mf+a4YmbCIja9oPZlDegVxUcypiMx9p00a62Im0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GlFLfy2y; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or2W8k8OarsCCdgF56MzQNRTh/IBDVeozc1A7mlCcVatuNJlF9N0HmjN/cpOrdCIBd12uZbO7hYWIW34CT/+C6Ac8QGSvKv16lBEJYGBaMsuDIFmg7UlwRrMcrBEA/YtObX6sinu1xPXVcWG0uVmDrlPVT7gp5ax4cUGKQiW8+fQNLOhdX9gnqMjh8OmcAS8LjW/vMlwynjoRkg91beJvMqPNlW0MBgv/+xNyfMWKYkGxXhYKjHcUq6/mYHkKqyuztoNu1BatXG2BP+YYcUrOBfw7HPT73Q6CIdziUgTfbAZeKPZ0b71KX8aVh12dUHvwNsSxPsCEGZ7OvwLGSri9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN6wDDWBdlrNkJiH3zQBr79Ax4r+HdGBpN1yadBjXPc=;
 b=JQ/x4iFF+cKUg7fbb9Gth5htCwyvIFgSDPM5HdclR1OAA44P/CIkdoCF/JEMwi1CaUdrvmoGJ8zy7ixWFQKCv58nuKut9YABuThHFSOgN9LaVjfWt9KJvh+L7DUWEOR7w54BUlS9WaDBwiZMlqF6/ceKbdWjtKJbsUSYYTx43o35ffmw5I6x+Dxz418k7WqFw9frnq/iaavwBVtmmEQKCJLt99fPSgZ64hPe1a9znRAWMI0VS3nR76vab5MfmXlUcuitU+nzZVT3sapoMm4D9bxbgIQD0AGPO9tY004fBIaZu9TA0nK5MBZBoiUdJ2ew/OzAXchnWLsLGXfcOi3b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN6wDDWBdlrNkJiH3zQBr79Ax4r+HdGBpN1yadBjXPc=;
 b=GlFLfy2yQXm0Mmo/Tmh6LBAfaZd+mFyuM2UQqzFz8K24VtPMnjMH9tJRNHhU9JWlsbZ70ZE/EpxCwg64BUyZGB+QODA9EPWl626xS4PhffIcGGaIs2lwT0EL9cYXLkGkU0PQAIr3f6HcSIiE0YeXNDZs5xDUbcoZ6Dq8+orCK5PBhkKgeC8orwYZo6dJPuTiIqJKvOQ3ZfGzzAtxrVcAQxNgR8e/Vx9r3EAlCADFAojhoSo0UBFUYy/tiiRT3V43bav9eZT+0hLforuaUKLC+XxWHCqwZJzK60sr29Es0vBcoMvnb1X16g+sQ0VtdpYjzW7AuPYfjPd4WEltTOUXfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 15:45:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 15:45:29 +0000
Date: Fri, 16 Jan 2026 10:45:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	"Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B
 DMA
Message-ID: <aWpdEKVBjbq7Lrqv@lizhi-Precision-Tower-5810>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <20251214224601.598358-3-inochiama@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214224601.598358-3-inochiama@gmail.com>
X-ClientProxiedBy: PH8P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VE1PR04MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b4302e-0a26-4769-e12c-08de55164689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WtC2zTLBCcXjMUIwav80myY6tNOkK08DlfUTRmGstqu+VErxcY7gKhUkeClU?=
 =?us-ascii?Q?Rxevd29ZHpOFL5HU2zk3G48szUG8t6pLuFBH3b7aRUf/yxl36o2pYxEgdIby?=
 =?us-ascii?Q?owKhcEznh0gyAPeCp5oFJv43uDHsEVCdshU+6qAJwrL5WZ4SoOCJROX9jv5N?=
 =?us-ascii?Q?n05gAbUmnR3hmHKPrO6nPtOecf1Rw1gyg7fiffvbIAuKP1Pk5EBQGD4EwM3K?=
 =?us-ascii?Q?uqhPJb0vp6n3NrZ4rrd1sapCOrBCQHB9SMgY5qytz6wk9mz9zLBTU5Hjbyhc?=
 =?us-ascii?Q?+fxb15Ai6+j3CKE1RQ3QIIABOcKLxgDyFEwmOkeoWo7h2Z4/IWaw3qOmTlNs?=
 =?us-ascii?Q?A8aEQN58uRAe629t07wlZJLyfpSXa+Ilf+p14ItYGBmOLbQpXMlPJo+j+poN?=
 =?us-ascii?Q?UjMtWnZsm2ObRnngKUsp7GbZ6WCiDELezINohB47xozgK6Ph4QKaxAAQzuvW?=
 =?us-ascii?Q?imcAmMjELgmv45sME6iQL0BiJXhIBxiws8JqegzeXSo6Ze7tR3apblwSOkyE?=
 =?us-ascii?Q?CKxIaGRvSfY9ufaZgZo93ykOGQDkHQ4/TjMWPUuGgu2qVpChnEil1BYV+l6F?=
 =?us-ascii?Q?LQw1aEn1FC3Nz1hOHdjhKN10nZQcAJYn1bdmh4/CjP/OaAS23mF3GwwZyIpo?=
 =?us-ascii?Q?68afOcQe8ROdrLgRCsZ8V3xxE/imva3+AsZRVMn4+1R4QYoZVGd3CgWioesV?=
 =?us-ascii?Q?4of0CjIyFGMch8BA1SVAYZ6ZaSD+vg8fS+T7C4wepJ0uJDJqSRuIMcQdIyh0?=
 =?us-ascii?Q?vxVyXNe+QWzE/aDKHJTP98zPYEu0sKb11XTTgMh54ZNuZrmdyrqtEC37aLyb?=
 =?us-ascii?Q?f76CAmNBY3MfmUnuLKXmIrL0/vmGJeAjkvAHFdc4xWyrYsStDuRBnSiMKJya?=
 =?us-ascii?Q?PIuW+Ezh+CYvPzRzP0BoNCHXBV96OeDfosgV1YL5St+JLdObacRlfELCCyVb?=
 =?us-ascii?Q?117AtcXvEWSUyTkz6sVON1swuf0FG05Q8f9OdGqEGd+CMccT6ioz3arVwB60?=
 =?us-ascii?Q?rgXN/5ZMuAJKeBpJhf09F7XqP73Ik4RSstQEyKtimntkPoSvDqtLpHmAS3kI?=
 =?us-ascii?Q?B6OvHC9fjceeniYqkFw/A+VBXeIq8cwNSEBbT10Qiu8mdSrgnFUxVof9AD8/?=
 =?us-ascii?Q?cbnCuavFj5hINUzXdlo+8G3b74MFm4g7RXDl4z23Xko816lrmkuG5KoSwgzK?=
 =?us-ascii?Q?CUqjsSe5jkI6s4SUHAGnsfW0++JzTHPcWwzZzjOPawXi4vFbCOdq81HMr8Oe?=
 =?us-ascii?Q?pix7xcvMm+9HksaDM+oSO9uYdYtWryNMRpeaxpQFoovLErjfbl8ODRLKwSL8?=
 =?us-ascii?Q?nhGDRyt9C7pDwS54PaPE7oIZ/qU0CXlTq2GjlV/aEVpeeYNNU3KiZfxcABrU?=
 =?us-ascii?Q?/cVcMK0C7MJGmEpPgbQtDiBQiD5L6yigzz/XZRgmlGMuHfd11NoBxUzeVwuK?=
 =?us-ascii?Q?Sd2wxblvayVmq3jWWK9inEdsZ4uUV/IBXAi9Gke+JgdVgeaZ/fup1l8sPH+6?=
 =?us-ascii?Q?PtPgrzjkCW+nVUNCerxQUT2Z51nlyPgdWudVWOvFCw5ELT8qrVOwszob8ilI?=
 =?us-ascii?Q?2tuKyj/BzQu7b+ZeUc6c1tI7i/41cB38LFmf/RJNFLRUx3KS+HDFKIpyl3SA?=
 =?us-ascii?Q?dVmn/cbjplkqhRLA4hynJv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ud2sFCQlJraAEtRSG25frllksbdsK4diEegNqKEPH3OlzQ3y0jH8PY7Sivh?=
 =?us-ascii?Q?7fiBiQAcvWyqn3nsU50AyaCfCk0KMZVn3dak4G3VRyoFhxRwaynolFKCFFxb?=
 =?us-ascii?Q?klwa/9XvFdc9WZTMHsXC2jDCpWtOkcK2JdqPCV+PQU/zHdpS73MGD6roDR87?=
 =?us-ascii?Q?cPqaR6RHjJgmjt1tVA5ISYkEgok7sULAap69hh/pWvjyLt17TCf+wTrzexjz?=
 =?us-ascii?Q?eJWlwm1oCJc7lghcxYGZdwblAadFtobH4LoBXCjzt2h+hnJVAJ73pFSkQAx0?=
 =?us-ascii?Q?IafDOmtPeZpb6UPvwSZ8aq+MXTN1kDeXvMaMmeg/NR7FUWDMOMJ1DQLR5hd9?=
 =?us-ascii?Q?zDQrOojMXkzZtiNlQVpXYCD//SG1k8hWJaGjfBhd1ashQq6cKSbwDZ6tOgc3?=
 =?us-ascii?Q?oC71VuPNr4AaLqDAG3zchOc+1WH1mXZ97iNRIY9bJkJ/vm5Pg9F5WNza7cRd?=
 =?us-ascii?Q?Z3yFyIqtjEPuIc+Byre5lxNrT8pE0pebUAdU3eq3R+q35C8QaxJDLuXLvMQY?=
 =?us-ascii?Q?xCjGlyLnS28eh4w2OhMlue8Vw3LXbFD1xYEp/iYIjb68USO0oyY7VzwU9Dao?=
 =?us-ascii?Q?IOkhSmA3OcgTzSNZnN3PtJS4lr/z08hDCPB8z911JFPtSyVd4UcDmkXGeL+b?=
 =?us-ascii?Q?ftxu//4ucyq5BXvB2AcEp75MpQ2MJu0l7th8sgiigGakcm4B7ipk3Lk84s+z?=
 =?us-ascii?Q?Mpq3pxta3y0XsNvQSzJllf/oMYTqe+fJqw5qf/nGiPNd7fZmr6+UfdUboA5R?=
 =?us-ascii?Q?S8t8h89wURCPOySL754aMe+QThRVILPFj6HAj10Yht4hPtz5tjc9L9EJGTxn?=
 =?us-ascii?Q?Tf+EcOK0IwxvrGX85Tt5Hnn0R9WoWRONPtSZFd03lmXa6hSFFg/TzUm5fkxF?=
 =?us-ascii?Q?uugfhcjT/ylGWtj2HIQPU2Ts12dWh9pgwn5Lw3NwsHw9ZSa25Rb9yfN8Xlz8?=
 =?us-ascii?Q?1TA5l8rcv2uqoCDR3oZXMXbjZqzsXvPRJHe0jD23nAXpArmSTeTJka3v+/iP?=
 =?us-ascii?Q?lf1Jje+kd97KKnV46+tFp03MQmrSp4lLbZ13/AK6naoArF8uKoGBSVQYqFBU?=
 =?us-ascii?Q?kOBp+NULCowQidOs37Rb8WPIu235ITq2Cq7gnvPjADDfrp7toiYDTa6rM94/?=
 =?us-ascii?Q?45n0co/Mx2OS03OaB+WPejD3Z8dysMSMecThaomGBEiMxmCAyflOEQhuWa+d?=
 =?us-ascii?Q?hGyP+uX4NKGzZRTlHgDp8QyaLrE/3JO2zWV34xnqKZT+zD3LkS1/VgZCJYWa?=
 =?us-ascii?Q?p2DpRbtHLePm7+FtWD3H6uSBy+TzZUO+ToLcZ2UT6zS1tBxFI0ld1fWLMCYb?=
 =?us-ascii?Q?tFYTKEjhwLmzu96iUvLf62dWGb/GBPKfb35ixxzKiJ3tg3QQYn2YZSgTzjm8?=
 =?us-ascii?Q?tupmWdl6IHb8XrmGaWUhYiADVuOc8HctJ+FkbNxpm4bYHfErruJKj0V3WbkT?=
 =?us-ascii?Q?M1CYyFaOUkdj5vWKkYDDPjOyMHRx7MQa3OHUO1+nbiaspnXr4rIC0HmxNHBJ?=
 =?us-ascii?Q?/XjT8sR8tzNR8BvRkVRX56sEptH/Hya76cDozqwMNag9zKtXW1wyqGxxc/XQ?=
 =?us-ascii?Q?AwBbFqVT0lCc5WAM+bg4dUgNIezLtJepuX+FHOb1bOjcmbp363xlw2LZCOXO?=
 =?us-ascii?Q?/aMoXZqFoeImRPkeOTLkgg6Ir9Jvb7kU4Vf+GYGeYEyGKJd4X+WdjI7aD9gJ?=
 =?us-ascii?Q?SV1d9f8rMWlOHSj+7zSAZQG/K2HWN2Wrjoya/+xymNRvZ+mb4C6jDxqHcX59?=
 =?us-ascii?Q?PbXl2lpdKA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4302e-0a26-4769-e12c-08de55164689
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:45:29.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbswvQ1TLgG2lByPbyiL82QY0AuVnRHDAhIMdVE7aHW3uzIUZQpQxQk5cZwwih5iZHRgumjb1jZOunpvpI9d9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408

On Mon, Dec 15, 2025 at 06:45:59AM +0800, Inochi Amaoto wrote:
> As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> the SoC provides a dma multiplexer to reuse the DMA channel. However,
> the dma multiplexer also controls the DMA interrupt multiplexer, which
> means that the dma multiplexer needs to know the channel number.
>
> Allow the driver to use DMA phandle args as the channel number, so the
> DMA multiplexer can route the DMA interrupt correctly.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..829aa6c05b5c 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -7,6 +7,7 @@
>   * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>   */
>
> +#include "linux/stddef.h"
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -50,6 +51,7 @@
>  #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
>  #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
>  #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
> +#define AXI_DMA_FLAG_HANDSHAKE_AS_CHAN	BIT(3)

Look like ARG0_AS_CHAN is easy understand

Frank
>
>  static inline void
>  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
> @@ -1360,16 +1362,27 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
>  static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
>  					    struct of_dma *ofdma)
>  {
> +	unsigned int handshake = dma_spec->args[0];
>  	struct dw_axi_dma *dw = ofdma->of_dma_data;
> -	struct axi_dma_chan *chan;
> +	struct axi_dma_chan *chan = NULL;
>  	struct dma_chan *dchan;
>
> -	dchan = dma_get_any_slave_channel(&dw->dma);
> +	if (dw->hdata->use_handshake_as_channel_number) {
> +		if (handshake >= dw->hdata->nr_channels)
> +			return NULL;
> +
> +		chan = &dw->chan[handshake];
> +		dchan = dma_get_slave_channel(&chan->vc.chan);
> +	} else {
> +		dchan = dma_get_any_slave_channel(&dw->dma);
> +	}
> +
>  	if (!dchan)
>  		return NULL;
>
> -	chan = dchan_to_axi_dma_chan(dchan);
> -	chan->hw_handshake_num = dma_spec->args[0];
> +	if (!chan)
> +		chan = dchan_to_axi_dma_chan(dchan);
> +	chan->hw_handshake_num = handshake;
>  	return dchan;
>  }
>
> @@ -1508,6 +1521,8 @@ static int dw_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>
> +	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_HANDSHAKE_AS_CHAN);
> +
>  	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
>
>  	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
> @@ -1663,6 +1678,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
>  	}, {
>  		.compatible = "intel,kmb-axi-dma",
>  		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
> +	}, {
> +		.compatible = "sophgo,cv1800b-axi-dma",
> +		.data = (void *)AXI_DMA_FLAG_HANDSHAKE_AS_CHAN,
>  	}, {
>  		.compatible = "starfive,jh7110-axi-dma",
>  		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index b842e6a8d90d..67cc199e24d1 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
>  	bool	reg_map_8_channels;
>  	bool	restrict_axi_burst_len;
>  	bool	use_cfg2;
> +	bool	use_handshake_as_channel_number;
>  };
>
>  struct axi_dma_chan {
> --
> 2.52.0
>

