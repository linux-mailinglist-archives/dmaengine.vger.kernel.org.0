Return-Path: <dmaengine+bounces-7840-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87527CD03B4
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F33D1301F1E8
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3727F01B;
	Fri, 19 Dec 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gF/4tixs"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39A27B4F5;
	Fri, 19 Dec 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153989; cv=fail; b=aj22CjgFSht0QD3u8UvG+lo1sEhGb3XebYwNRmdxfoZ9sjURFFo20Rs1a2DqxrCY0lFKGz1+0zBnwNqAmVzys+M/wVTMJCMBBIU/Q2qzz90OtblI/WJW5Yo7aLaGjpip/894ltpkfWq2AR/AOrKQDS1CjweofnYuCpW1noqjJus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153989; c=relaxed/simple;
	bh=kGdqejHtwGLDE3yYjvrzpDiofwgl9y9r/DX7ZpXvlBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RVpzy0F9Ie5bG5YYvdGnJeDbkb83rFaNw7vs6jKSl6p0lTDJfMLcz32UecnQ8W5NrYdkpJZAOv+YfWRiz+WG7SNQtXcyr1M3HEU7/9p1NL98jvkNIZkWyK/xddkEz0Qi57w4Akur0WnrJXzkta00AmsZl38lWtfFf2I728xn3gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gF/4tixs; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFVBQWVn4Y4lhyUyOqOwTn7YnAdwQfhPT3vJFZ3qGUHO7BP4itcyseKpLjeeM6ITgvEM7tulRDopy/2KaXB1j/0DLjOJbaaT23x+yNMUXgBSZ/opkcrE+SvB2/Tm4XkbNt1HdnAsSVUe75Jk3jlj72Z3LraOPUtmntRJiL2fPOp0OtFTM0CVYV68T7BC6ZDFoSptZi7GUWtmJpCFt2UJMsm4eL+XsA8bndm0i2vD+hkYg/9ZwDnWk/wbnTltIX1YSERjhFTj+205fHCAIgh2/I7u2isuOR3EirNTzLB4liJX5bX7H0FtqlH5aPqebVgQim8vqBgHsFwr3QCLrZN0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daDAHe6/HhXl+zh31D596KH2+kJOay79t/RP1oSQWU4=;
 b=LLWyGAHymwrgK1jAJ4NlW5loxSQe3LEDD4v1ixVSr0URHxxaTitJCcu0XmqZOSw5PXq3/1OC2hLWHBVUhEsjiGm+Y14Pbqjoqo73iwfvXklfsjJra9gxsY+iAHNbMxpkcfHD6RW0g4u2L6I08YTj2v8nN90X1FazsEhcM0giTzVVTlnqn1uXWU/oKJ15vLNBUnd84l1NlHMGOnJRPoqswBGyNjib6p4C2G/tYZDrRRBzJMPVj2/IvkxeN769ZqdDD+7zOx8SVm+MF713XfQWgGLbPB2v7f9oMdB+Q/tz4ojubSahYAjQ33HEdqBBwscehmmyx0UTlAA+zTkXnLaKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daDAHe6/HhXl+zh31D596KH2+kJOay79t/RP1oSQWU4=;
 b=gF/4tixsvNvZpdfOXL4ixTTqdZWfIjo/wLR/duwjzNZHvb6dXK/jkvOaOM3/giwJYhUp0lidVYe0ITUjq/wWTe4Kr8oNcTtLmD/oUlgg7T+izoq4/FTAyK1uZLs9KOamTXMVMUj9E08WggOKHPLLXcCU07jluBIOXaEzD1pL4H5Mv006CYfwSkWQ70R46f7oKUuxL1sqpb3Ow/tQim5RLsC2wBqbfbBPrmQMEb4lskoYXTs0uuSwI/WudcWWF7FdCPtd470V83rVfx6ioUBAJV+8koEJitKsj66HVHRE8nnO4cYyIO+3kKWmzeE9hnkolU5Eyrbzzl4n0lYxw0M8kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by OSKPR04MB11366.eurprd04.prod.outlook.com (2603:10a6:e10:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 14:19:40 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 14:19:40 +0000
Date: Fri, 19 Dec 2025 09:19:26 -0500
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
Subject: Re: [RFC PATCH v3 03/35] PCI: dwc: ep: Support BAR subrange inbound
 mapping via address match iATU
Message-ID: <aUVe7r0BkaF1YXrF@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-4-den@valinux.co.jp>
X-ClientProxiedBy: PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::35) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|OSKPR04MB11366:EE_
X-MS-Office365-Filtering-Correlation-Id: b08c6b4f-310a-48f7-375f-08de3f09a5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rhy02Hw1t7x7BkyEkrMo7vsrwAWl+GlTcdslGF1q28KuI1NQiP9wEp7/hwjU?=
 =?us-ascii?Q?oA+ov+0e2BW7MpJ7lnRvl76JBNH8jb6eC9r9p3PyGT4O++EXj6k2pP77uQvm?=
 =?us-ascii?Q?M74nA61bBqN7CqnOUkp/9+TnIZkXtirRZxhohKN1jJDa2NB+yApcn/XKLy6o?=
 =?us-ascii?Q?eO5uvManOx5K5ExPBuIDsOaV0HPkhEg/CqbES+QSgzgeJb3FpOck2iKHaWf3?=
 =?us-ascii?Q?uzm4Xl4706oY0w4Z7DvWXSrH1WSIWtvzqMEiQYKweYcSelZYLuja8fAynDpi?=
 =?us-ascii?Q?wgHUGUTkOXNiL9GK4rgtXEcqWc47PHoMWwEStCLp+6F3dbbrMt4lf7p36Yi2?=
 =?us-ascii?Q?c0wi66SsKK5KDrm8g781ddIQ2iVeFKc5fxwi/e656G4hL/BpiponyZZUTm71?=
 =?us-ascii?Q?UeL1eNaQoLAJxWvSvcRnynCEuIXGbraXUQwobJCSLttjyQcZamilEq5MJZwO?=
 =?us-ascii?Q?gxCSRzOtIgJEjZcI+McESETONsAG6BqPTNWKacLK50Dqj0uuzyH9aFWltwPJ?=
 =?us-ascii?Q?+aupOFN7i6QeIhus99oOhwkJfVXFVA6x2OK/5HbbLlIva16ahhbAfaGiyFbQ?=
 =?us-ascii?Q?jKTp0yPuvC5Q8ZkM6jlCwtfDFX/JSTxJGdBC80xTSMMir+Q3KODw4kKa4LXd?=
 =?us-ascii?Q?LIAoAEj6cMT2nAgvNOtbUrDWZScB2U97OriM21Mtd/bU/krE3+FwoxL5oaNr?=
 =?us-ascii?Q?okTJkP6WwkieuNe/bqvkLOCeeQbZhgLgzKSGBHhhCn5fnFjrJEiuK6IKxicP?=
 =?us-ascii?Q?8OgzBzQQ4E/l4ktGxRj5zXCQH3fyrs3l2JMdFYR3p7WT/2gLEabzAXTl43N9?=
 =?us-ascii?Q?EG8tn2PFz6TORzssnsjea1dMq/WcbCf8EQDqZelY6La1utzj7+WIk+P24fnk?=
 =?us-ascii?Q?9LtRicxIfB1LJvosZdX34urCQCQa72NkCf4pBzA8zRUEi2wVU4VtnwajAiNz?=
 =?us-ascii?Q?dBOBqRkQQJHF1uuQFXQjqQYmBm+ercZbB4izrwwtyVTKVuVyJUGdUbL0DXH4?=
 =?us-ascii?Q?sL8zjCA6NsFi/u5VuOD50fh6p9G+jqjF92di4M2lWNOADYH+DdBav7v8HYpG?=
 =?us-ascii?Q?rX+gvbTp6OJ2Ccdb+jSgNyxg9DMPkbRMZsTEgw5lLovD7L6oBAvNXPmhWNiJ?=
 =?us-ascii?Q?BYM5ojPHkahzbGD2Zr3Ouua03ohjkkmUMFLxVejWuRumomttUHtUt6vFv3bc?=
 =?us-ascii?Q?Ug+AlfOIkK4amgG3pvFXcfFQjVVrH5l3n9u4X56jRdrrJTJ40WaiLxoDZ3Wk?=
 =?us-ascii?Q?GCPa5RPQSAnN2g1PoKd5G1x03d7itwE9o20ihFkKNeCbHKYvZi+Rtf/HDhk8?=
 =?us-ascii?Q?EGhQhD4DBaHCGbmsovpKWpz09J4yYDYdGLM1yDbXyfA5w2Qv1SLnrnGMCuCD?=
 =?us-ascii?Q?qTeN8eTFjic0MjJQFHXId2F5G5RkBZYMo2/R5vbj0IUgD0nwBLu0OJNNd3vb?=
 =?us-ascii?Q?PCFMDgbv0G8b9r4JAIdcsRNIa/ANNu3k3+oiaPS+Zovd2mp8m25p16LlZ9Y4?=
 =?us-ascii?Q?CB62lgJ9L7tEaG0+GhmCjrcttFBFGTI9l9fC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cX+L5c+b2Qt+WRjHvz9uB4g1OG8zkMmTc2igT6KRAiv5wxvpGEUIWNNgpxLv?=
 =?us-ascii?Q?bIF4+lS2ozfMc44NzSMBF+yjLIIe8hka4XBL+S6X4lbV8f2aQwZfUkgHRIPK?=
 =?us-ascii?Q?R78wb2vB7TnRBwTGdMQTGXD8wsre86Wik28LyRB9SyJgPUns45QLZYH5ylMU?=
 =?us-ascii?Q?YJqZ51oxoKeeW/WieLOjayuH9k3u3+e5CpK1DI/uoMD4ayduiIILrUxrQGU8?=
 =?us-ascii?Q?UHJFPo6KtMsNEDn3ENFIWDoBbZ88nhp/qIyPpO9XRaar1xBOf3AYzHcSslmu?=
 =?us-ascii?Q?sZe2SRLl1aaYXoVCt14Z174KJOowlNfnhNy+LiblTXB49cPb/+ZNxO9mlSr9?=
 =?us-ascii?Q?wVCmzFezGl0MLfvsvZT65elTnmAiXkqo1JotG/irIyT0UQJLbkEQDkST1n/x?=
 =?us-ascii?Q?N/ijWHg6V02rCvWZFyGCXQuFvBHUd9zqSg3fekYh3RIy4kQcNXfbrH43/xh5?=
 =?us-ascii?Q?BgpZbXaJv/HosJ2++gpbRh8h8S8zC89WGRXpPypgfcZoadwhrxT+71O4rO9w?=
 =?us-ascii?Q?fNKZM24VceyToMw5TpqT8CRshHKGYnEzinsRivA/Ia/8uZZBzCL3AEGJ3eUw?=
 =?us-ascii?Q?Dgeej/4ZRzbNX8qLVWkx8dCHLEIUE1gadFjQqAW2GePn1AzAK7hlXsjQJR5Y?=
 =?us-ascii?Q?1zsW+eTCXn8rUaNLQv3voTFWlFBDyT6ayc4A4pmR9VtTGc3s245kv8G5t1NN?=
 =?us-ascii?Q?h3nYUtFG7NW1ZXaEmD+uxzB1uVLeIz2fvEL8in0YrtW+5M0jMynQbTdCbnZN?=
 =?us-ascii?Q?H28L34/tJ9ItkoW7yP7gCPNcIpnS1utHm/26HoniK866RE6iMMliQTwogyy1?=
 =?us-ascii?Q?kxo/TADN/Io2FIR1OjklF9x7riUJjCABtdxojtFqhs5vLfpGuq/Tr1Z0nEQJ?=
 =?us-ascii?Q?gjFXNSjvaf3p4Be7pQaBKXHaQkC/yYfZj53dmtDYLxDbpL8J4A+yHFE3mXYo?=
 =?us-ascii?Q?uST9FAuKsKL9jsiuJVZRNK5kxT1W7opUPbEI8rA+f+ZU3T7r46xgA8p7vApn?=
 =?us-ascii?Q?ELdWSIy6t/sbVhCZTmYrk2TlV3+bE5yn7Qi76Hbz70DMBd2xyK/FO8Fp0Kdv?=
 =?us-ascii?Q?2ASmbgj4uJ0KQQ3ODTDfOs2vok8teP9BvwZn4DIgOOkhdcS/s/SHTsIHOJYn?=
 =?us-ascii?Q?FENwi4VdouhVvQIf0+WBxUEQ/3UR+nEaErssg63Gmpwc9oTBm5POdQBFXI+L?=
 =?us-ascii?Q?YoYLAUd4FqvoGj2Xi0X2ppCzZN/Nt/UyxpJ6xnTZ1PymqYxUm9R/mSA1rXwt?=
 =?us-ascii?Q?VQ7WO8XuofyosN7e4pEXDMRztc8KDlN98jKD8lyGxoUOuZjwUlfYiIcEMmg3?=
 =?us-ascii?Q?eJkOn2sB+VuOTlIKcZ9gNpv5kcuZmLN66pUNxFiZsgzpRXH2SR0ndvbtD08o?=
 =?us-ascii?Q?3STRZgNFeto3L0wUzgWQp6avA0ikMAQDQb3KRB+UqAzFrQuy6s0kT4D/Ut34?=
 =?us-ascii?Q?nqDmAifm7cMupDie9I7dHcKpSiju5X2/Qwf59c+eX2PTjzc8EHcFa2Sj11Mj?=
 =?us-ascii?Q?Mkac3+BiC02ZwpcwpvvXUBS87ROmQjDzV4kR4ParEDl/dYxmTvGRPGaaUghN?=
 =?us-ascii?Q?KT45yYX5b4nA1M5OYE4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08c6b4f-310a-48f7-375f-08de3f09a5d8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:19:40.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/0wuJrSk0QIc1ZarCRy2Djjpt8Hhnmoweo41buOOiz0Byk9A7Ex31UG4mly3u2rMfabpAp3pGWPkPzdBFXdNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11366

On Thu, Dec 18, 2025 at 12:15:37AM +0900, Koichiro Den wrote:
> Extend dw_pcie_ep_set_bar() to support Address Match Mode IB iATU
> with the new 'submap' field in pci_epf_bar.
>
> The existing dw_pcie_ep_inbound_atu(), which is for BAR match mode, is
> renamed to dw_pcie_ep_ib_atu_bar() and the new dw_pcie_ep_ib_atu_addr()
> is introduced, which is for Address match mode.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 197 ++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/endpoint/pci-epc-core.c           |   2 +-
>  include/linux/pci-epf.h                       |  27 +++
>  4 files changed, 215 insertions(+), 13 deletions(-)
>
...
>
>  #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
>
> +/**
> + * struct pci_epf_bar_submap - represents a BAR subrange for inbound mapping
> + * @phys_addr: physical address that should be mapped to the BAR subrange
> + * @size: the size of the subrange to be mapped
> + * @offset: The byte offset from the BAR base
> + * @mapped: Set to true if already mapped
> + *
> + * When @use_submap is set in struct pci_epf_bar, an EPF driver may describe
> + * multiple independent mappings within a single BAR. An EPC driver can use
> + * these descriptors to set up the required address translation (e.g. multiple
> + * inbound iATU regions) without requiring the whole BAR to be mapped at once.
> + */
> +struct pci_epf_bar_submap {
> +	dma_addr_t	phys_addr;
> +	size_t		size;
> +	size_t		offset;
> +	bool		mapped;

Can we move dw_pcie_ib_map's neccessary information to here, so needn't
addition list to map it? such as atu_index.  if atu_index assign, which
should means mapped.

> +};
> +
>  /**
>   * struct pci_epf_bar - represents the BAR of EPF device
>   * @phys_addr: physical address that should be mapped to the BAR
> @@ -119,6 +138,9 @@ struct pci_epf_driver {
>   *            requirement
>   * @barno: BAR number
>   * @flags: flags that are set for the BAR
> + * @use_submap: set true to request subrange mappings within this BAR
> + * @num_submap: number of entries in @submap
> + * @submap: array of subrange descriptors allocated by the caller
>   */
>  struct pci_epf_bar {
>  	dma_addr_t	phys_addr;
> @@ -127,6 +149,11 @@ struct pci_epf_bar {
>  	size_t		mem_size;
>  	enum pci_barno	barno;
>  	int		flags;
> +
> +	/* Optional sub-range mapping */
> +	bool		use_submap;
> +	int		num_submap;

Can we use num_submap != 0 means request subrange?

Frank
> +	struct pci_epf_bar_submap	*submap;
>  };
>
>  /**
> --
> 2.51.0
>

