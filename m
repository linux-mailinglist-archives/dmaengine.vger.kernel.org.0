Return-Path: <dmaengine+bounces-7817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D08CCE513
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 04:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11E01302FDD3
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336129B778;
	Fri, 19 Dec 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9CV/qmd"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D301DF261;
	Fri, 19 Dec 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766113704; cv=fail; b=WQNvwH1vpSdphNQ3vc0Y9wBnBpPhIe+ZWH0YgVpxK5cn4BDZFUDnfQVxqE8OWX6Zf2z03Ke3ACopDH1sBQn400G3UkKh/N9rEFAI4RFFI1CQYb0lj02YdGqxNmmqP+JRKM3yTxNs/u2o+fvNUiSYnG4Jfmw1B/eiioMv+U6kRNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766113704; c=relaxed/simple;
	bh=yYwNNUnp3ksxUjc3eywOS6CmoUFupJVOZtZXHoAM04E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R2wzJbp0GeVs7wVsv7BvWKZatBm2N0vOUMsL/V8BnkX8wh0j+RnICBS9qAxvuXlIF7UWl3tDLmJHMybflQ2XO6uZrbaqLFbqeE9q+EG/tz0mHmEWMVeHlzUTI+q/9onZdOL9tM7IHSkFXSZWulKCqO/sA7Z+sYJt0ACcmIWM5D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I9CV/qmd; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gE76pHvuIMMTM/8Y/UU0qEH1Yrilvj/90z1otJOe/ETSAm+wyBxfwYIKNU6kbz/uwjhG+xp3Y8NUZwURsQHEZnIrGOmGI01yWvZCZ2Z+SDGh8Aj1NDHMUrSKSaBYvUtDAkDuPnOAX5kldUaXix25gEkgxc0bIUWlBv6Q7AyDCVsUQ8HFIInfHW0WWA6b3jMA71/RQWiF0pfgFxXDQbNn/AXnU1mmcfC/0g+1MKMzcrz00HpXIgeVIi19iFqVYFUagBFCR1Y+6ugt+MJOoXw+fspNb2aUgGNStH+3DhSO3kIxq+nrWdzdlqx0R8xWDECmCltso/wuImTLW8DM2QmxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K45RTTvc5NVXW2T9zTYJO756ddXzRjrSgDf4zLfPuEg=;
 b=ryzzaXxVb2U23rOt1QjN0pKFhLtYUYN+5yDoeXieMMAUa0TzgkwY01Xt0CIQcqWwLXxm8o6VTUnv5Yks2qr0F2ehqkF7ULP4Bz20I/a3Cw3phM8h/PcMTOxkUXjLCFaO1x1whMCDMbTdWRv2/52T5gBtvk3+IX2443QaUvTb3eJpO4dtmpbkLPiXAKbuqYgrrcqRftic/tYZSZAgBMowLwt98ARWD+j3BknlOQK7KuDLiNO+paxp2gGzRJeYrTaB5tDuRiG217dq3fE/PgDEemVDp4X22x/rsvA+VWub4ut+n4imIHDXSUQo4QaY4yF1hlnf9HTOfo5LEbD63s4Bzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K45RTTvc5NVXW2T9zTYJO756ddXzRjrSgDf4zLfPuEg=;
 b=I9CV/qmd2pn7lGflVaCwKCW9k/lu5Uqb39kiRiiaeERJLVv63qh//NQ82cAoozmk0oNbMwD32RWT0RrxlNC9ucxEPKAPr1yxB17YJo+O09al3nBxZV479UtTyQD9xdPyLPjRs3kv5kgdHixk54nWGmK+jkHsO+Lz+A7hjrSxOwxW59JZCIFNEjdvwUTBa4yeK/vKRf9LzPoBQBE5o/hw5wHxd4fqmFiTTbkOxPCqSIrzgTpsqUHxFIRt8LHK3AF9XZ2CTgQXlPnnxlwKYSFOBl9Q5Hlkj3ghPozGi0x7PoQALLWAY05xt9KcQWtEM+NRvaUToClQKUMuhV1q+jDexQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 03:08:16 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 03:08:16 +0000
Date: Thu, 18 Dec 2025 22:08:02 -0500
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
Subject: Re: [RFC PATCH v3 01/35] PCI: endpoint: pci-epf-vntb: Use
 array_index_nospec() on mws_size[] access
Message-ID: <aUTBkr83isZfmE3x@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-2-den@valinux.co.jp>
X-ClientProxiedBy: PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::9) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: d934932a-0924-4557-f9d0-08de3eabda99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYqwfsF37cppaaB+z9dOiSP5o9Mug3bIvLLADNY5p6EJCQKwL3I7mX67DsVj?=
 =?us-ascii?Q?ZrnllFkL8+VzpO1VeOL+/F8cd3f/8hzbJYCKtEYOqi5PEoWxLBmykUBYY4Ei?=
 =?us-ascii?Q?tmk1YZFBqUviM7ht8tz/shDZKEkH/UvxWSHCx0olbDL6jtykdy9OD7fbIarB?=
 =?us-ascii?Q?pw3gshpbd+t6uFpGuLRFDnQ2doYrg3Tjo2HW5dyJ5lTkkh03AeUlZoHUoK1B?=
 =?us-ascii?Q?MlGTq6tbACcYZTYYB6oT65hWz6rf9Hin612dfSYtJs7HChcpBTt9GFy5mgAY?=
 =?us-ascii?Q?2DmrRtB960OdAiorqjcbmom5EB0d0eRY+3HneP8e5lgers+4v//Z4YX9tKKI?=
 =?us-ascii?Q?xrEhf7rNFUYsOVV6sfmOPCy07bqJPDNmA0IYvYxCQkcPjwDfdbWzR6NdI/SK?=
 =?us-ascii?Q?s9FhodnL5BX6gxIeTwJmwNRdhWta+s5lGgYXpheWFLmdXT7b8BbhgheNQhxQ?=
 =?us-ascii?Q?ycPD191zJakfJ/yVpdty8sV5Mv7C+z+CLBl9Cnc3LpZ2opvwSWegXdTFTxab?=
 =?us-ascii?Q?Yd0uAnrxgpg5WkjqfB9exUr+bT7bxFalNw3w1aTUgTTuoIhVxTr+YLmJqweX?=
 =?us-ascii?Q?sqlZ9bcb+wPjNI5KE37DvvgjAQRTSqlv85q1nRydI+bqZjVpeVoQR+N+7re4?=
 =?us-ascii?Q?N4U1GUQgkg6N5FNwuU4ChEcEwDCmuBc93N11MYPhZPj2QrdKpM5uiRrAfxjV?=
 =?us-ascii?Q?f2EOv9Jp90vs3UpFNDi6k15/W/vzZYvZXhSn4UkKbFTJVrMQIIUvgl0osMo4?=
 =?us-ascii?Q?6wMmI3Y0bXk5iEagIgRrsj97B4gZxnfHdsu0q2KVJaPF9141HqQBd3znNK97?=
 =?us-ascii?Q?mwwSlVU22ctLHdQO/Sb9KaQPazuwPndKHaMgm09kX1yZd+R6ndXk3fe5A2bY?=
 =?us-ascii?Q?F9S1emeeUoLwmMvs+R3828LspgACsJ2TbkCkfzKXZ6cky8b/SBGK3NBrNZ77?=
 =?us-ascii?Q?zoa+OiZTDfF4ijBPMNWHTeNCdmb3s1YClc7o+rHd+eTtIFLk5u6OU9I5P9o8?=
 =?us-ascii?Q?RJ2rUn1j3C69HrOfvtx2MzdgJhrigF8DWVIET0OYKeoke6AqABWDT47B4HKf?=
 =?us-ascii?Q?833JMQLYziz3gkraXl75bpOZT79nYZaB07b4vhnzkcX1s3jo+j1ym3JGX76t?=
 =?us-ascii?Q?6FZXGNg3n0MWdP73x1yYFeix2Fq3Ws4sBuu1OxLeMDmVLfFbWdmUTGGrG5D7?=
 =?us-ascii?Q?xhQdCgrKhxq7DXnDWrm+F7gprUbzAa0CQKD1ZI4P0wqZqnSOzFHNMMHKNcn4?=
 =?us-ascii?Q?/Z32WlYW1bGHPD3tC44qmxXtg0NVu8sgUH7FPa7xuD/uEyk8TGd5j/q2tNk/?=
 =?us-ascii?Q?JwXazsEOyTVawXgFpiKixRRHDpuZteUWhk2moK5oaakhXhSXKCuLEzgzGkOw?=
 =?us-ascii?Q?Y/vY6Dgr4v2MpYehJbTjRAGwO2dNVHTC5JPoU24loEzfpBYGDMAsBUym328x?=
 =?us-ascii?Q?IcIcHzo+nGrBIsn7aKiQvjHYD5/Ohn1w/n1p2mIeSDda+7byMGGKW3YFBub7?=
 =?us-ascii?Q?YJjqpZ46qTQZi6vjljPpEJEEejXVW2whRDd2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NEDQ3uttEZyIoFhpcfYH73SiGrloHbY+k1E6eE18CwGwkBLMtAzpo/dLCLh?=
 =?us-ascii?Q?uApfk9e1fI07ozdeshNYUA1XNFwcsbaQ6UBB6JZnpwMlSkFDL8/zPknwjN6c?=
 =?us-ascii?Q?B03eERRencTJEPZHI8HdaByULaR3As6mB6eWxUMjflwsbc0Mwhf9+LSIbYh+?=
 =?us-ascii?Q?BcF6yCo/jZ/c+18NfiH+n1WdP1P4BaBS2zNTnaoRp1NuRClalNzaABZY15aa?=
 =?us-ascii?Q?wTg9JzjyTdMUfmFAY1J+8iQrUkOnNJwKZkow9caRn3xQado/4ENQ0ybChfGz?=
 =?us-ascii?Q?wqDdORQeuDxyAkC57p0XmLaGC7m2CpoZPUfHtWPPrjZt5V70WK80ST+kayUY?=
 =?us-ascii?Q?rzYnQzykIADPmJCoD+osEK3PWlG/6+oUJ6A12OkqE/mTXAHU9Ycrd9BRV2gd?=
 =?us-ascii?Q?WLSfBkZkRZvxCpj2tLXqeq6Mfzy7HEPTgWUnEPDCVhiLfwn3jOJLjeJ1illx?=
 =?us-ascii?Q?+fzC7Rrf/5kW37AE7yJhPa0DPT5ZX3PefBQ4txX8+EJ0S33s5rVlflmdv6m7?=
 =?us-ascii?Q?6nUhY2hDnsqs9VWjkMBeXVOGZSfQCln2GQ/T1c06UIxKWMbOP0JGhASa8w79?=
 =?us-ascii?Q?5/LJRu7rdRJC4qhFCYOtHFwKCyaoSVDMNf6rwNnkNu5XEwm/8FgPb9yaLsVq?=
 =?us-ascii?Q?elV4rIYiGBBwW38L1CSwDjr5VlneAq7NnbBcOCy0FeM5qy5Ew7+SjyI9dzNh?=
 =?us-ascii?Q?5MVoHlhO4G85OOajLtKM3jVbhfMyTSqOWHYxG2hFp165kn++/XwV6NXUSCSE?=
 =?us-ascii?Q?srdqZGMz/ZI/Ph3nvUUY74fu8KZCA3EJGKJon17ocpL1yKxbOo98y9EQ3DAI?=
 =?us-ascii?Q?es+hdjetJz7vYmAa4+AxHYc5WpPTfj3NmQ65diPzSlp0aziamJNaKUXuFw7C?=
 =?us-ascii?Q?O2YAClyhdUabR1F1dxnUkyXcZz8G0PSyJ008wJmQ2vmiSl/SaHzAl/+5Bvmq?=
 =?us-ascii?Q?EBA+DEn0D93MxFgZ3bN1CDEaVBOM3NTYztEEqGjCCVXuE6rT5snB6DbFQJOI?=
 =?us-ascii?Q?iBhtdL7stTQ5Lp3H8+GH7SnTYPKtcPlLCrOWg/5oE6doI4GF8fHnrvATQunY?=
 =?us-ascii?Q?Xv3biVXERH8WOzb3ZxPUOQ9XTbywk0eOdy1lgzbTuzvwZi1dIxm+BdVqpZ1v?=
 =?us-ascii?Q?Zki7VaiEwGAdZKYxZ7/Y+rV90QFon/FhTQz9sRz+LJQlQyUbck7lrxf1hrYs?=
 =?us-ascii?Q?zL1kSyYsN1YpoYOPfAR0IYIBi+EQ95HLNqjUJ76MFqkVG2CrW25PAr+jPm5Y?=
 =?us-ascii?Q?xJCU8Sk6Jiq7yXTvsrxY5kKrTYfQRwJvpbvC35UOun7IkxMpw19h9BGrQ5bZ?=
 =?us-ascii?Q?s2bqL1saNortNr/3O4olEyh+qOlGR12yeHBfBWwWlvkc0Av+Zh49dqLoqVBI?=
 =?us-ascii?Q?0FE9y5/Fs6Nv7s8dtOdpgoyM6mtWSuUxsGh52HlrouxWOZec1ool7wReUcpH?=
 =?us-ascii?Q?WXqmrRrAYlXnFzfP+7ylNl7oH7J4CguQppAMHY4qFCGht4bk7XSqer+S2Sh4?=
 =?us-ascii?Q?mAnA+jKoRFH4p/D3JL4l8d029Wbzv9o6gWcumCOGCoU5b8uldV2ikJxpkkHw?=
 =?us-ascii?Q?ly/DtUuHeaQS2Yqxdd0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d934932a-0924-4557-f9d0-08de3eabda99
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 03:08:16.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1bTuzyy8JDZizCW8BMZodYh8EB95ReLXyM0LcVcKJvdRpH4D0C2cB2I/1zDOFTeGvuFBEhJvjh2qxjx15zrgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

On Thu, Dec 18, 2025 at 12:15:35AM +0900, Koichiro Den wrote:
> Follow common kernel idioms for indices derived from configfs attributes
> and suppress Smatch warnings:
>
>   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
>   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
>
> Also fix the error message for out-of-range MW indices and %lld format
> for unsigned values.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Note: I noticed [RFC PATCH v2 01/27] resurrected the Smatch warnings
> https://lore.kernel.org/all/20251129160405.2568284-2-den@valinux.co.jp/
> This RFC v3 version therefore reverts to the RFC v1 style, with one
> additional fix to correct the sprintf format specifier (%lld->%llu).
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3ecc5059f92b..56aab5d354d6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -995,17 +995,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
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
> +	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
>  }
>
>  #define EPF_NTB_MW_W(_name)						\
> @@ -1015,7 +1017,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	struct config_group *group = to_config_group(item);		\
>  	struct epf_ntb *ntb = to_epf_ntb(group);			\
>  	struct device *dev = &ntb->epf->dev;				\
> -	int win_no;							\
> +	int win_no, idx;						\
>  	u64 val;							\
>  	int ret;							\
>  									\
> @@ -1026,12 +1028,14 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
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
> -	ntb->mws_size[win_no - 1] = val;				\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	ntb->mws_size[idx] = val;					\
>  									\
>  	return len;							\
>  }
> --
> 2.51.0
>

