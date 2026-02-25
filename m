Return-Path: <dmaengine+bounces-9098-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E35Gk06n2m5ZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9098-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 19:07:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8719C01A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC6C3127895
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C92E11C7;
	Wed, 25 Feb 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+Q78U8q"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B82E22B5;
	Wed, 25 Feb 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042666; cv=fail; b=n74yceEx2lPyqoD1cbxW8l6ZG/ajmb6PlQeALCdr7Dd4sgH6XD6igjS5d9oPxSygehq7DZKW1Cz236frzaEJPT9FBD4dmymfvWkaI8J8E6X4SEoqzy3rX7kItKbkd1GWVtFo1GfdVAwO5YV3CbiC3E11ifh5+NyVUBZjdeW2coA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042666; c=relaxed/simple;
	bh=oGcHaPLNZCsPjpsUqhq2L7ic6UCNHUqUEvVgTXiCQI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eEnqIHj8oTLJ2hoCJ21wRmXpNtC/sRlBpU4vK1oxXwUEt0NNkabHGIZC5Cwf89d8Atn9epxk2ceOI81g6qWxvHc2Ho8g+NCiuqL+BTKwEqACcR1ieT/4sQ54MIH8uCvsn6S8fsQ1xUZarVN0a3+KswS2MVQUJGVzG4gvREuR7Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T+Q78U8q; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWYV/pngU2lY43o0W4+bgSXL5v9AAAIFpzzOE4RCM0mdn1917gKWUqed9GhPCnNM93KUcloIUkiR5Nn97R+Zg+zGKNb1cg/M0f7rG5quPCj+WSuwAa9A2rzJXX3U2DxbXjTkfbZr0aC1wdZuAqj/OWgXU/q/1GOP8LHMIPt1za3/9H2jrtCzw53HPtbEHFClssPhGfebvgGxyU1F7yUh7F0j1089U/GC75eb7BrZTXvetnoPGqz5fDoUSzfGwLBlPkKAOAcl/e+aN+rweUbjqPFNKGxp4LL2p6zzd+0XIB6KjbpCkqLGiUFE6uFJVmd285BTyDDQ20woGBPyUO6i1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiHhgW83qbAfkqglhlVpA7IjEeRMBiV5x4KbDXitcaM=;
 b=zDP0G0huPxtqDbTqRL9p+qNuLbgjSrIb98aMREv5WhCqyjbS2Gddm55klvMf2w549T1cxCZlfC7gYfauydz8NulQvtvPeQh2kea09ktZA/FO+S7wTAkMOvtqX82yAD6SWcti0Ppb8IO+s0Hef+I7oFV+ctbji5caKxXx9x+BNOvmPndYF8UxIRbPcg6IqF4MHy9XPkw9EJqxQt16n+N0jHpCFKvT+ufHjocSSfOOBHqDH9X5Pgajo7qhMWKHTOhI5ELZON2RsJ/QlFTXtiB8A14fbkJQaX+EcxTKn6YbmicPxRCYu6Ze2HlRKWPwaEnr/TLHRrANDr3HkOrfnyivfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiHhgW83qbAfkqglhlVpA7IjEeRMBiV5x4KbDXitcaM=;
 b=T+Q78U8qlb4tPoUCl9DB9qUaRmkJ6TWoyj4gOhBfu26kllHyf17NRaQHYYLNYf7yBf50XfAQGa760YAk5Ji589YWxSC3sN82Cz7CanpN1TcNocEbaFua9Z1sXjCcboAIiTrzBwxBeWyGP57yQxOH2+SQPqvJyfg8lexgHV2YYWp8yGrYqYyxBSAH4pE0+8pnANy/acOCjW6tR3xvqnEIIzzvMQaFn9Tds1m8Fzj+rw2NJZx4W0XF+wJ4LS1oKsD0gUvBMKe1JcS0e070X8i+eNEpCPPmKKVbv/RFmcxSHADZhfdkdIeaXjJiPeHUFU9CemAfvbFQbp0lLXTHeZTuNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 18:04:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:04:17 +0000
Date: Wed, 25 Feb 2026 13:04:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dmaengine: loongson: New directory for Loongson
 DMA controllers drivers
Message-ID: <aZ85l1PSRIAJrm3R@lizhi-Precision-Tower-5810>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
 <44578a06151437a1889b51566d72dc7356e03506.1771989596.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44578a06151437a1889b51566d72dc7356e03506.1771989596.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ed2782-4063-45f7-1ef8-08de74984aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	I2tfumqJtAiHRzzGahlaXK/HooIjdhFmabkNPpBli7+NHvqyjQKw4bIelX0q/DXVnkistRP+2v5YL6d+WsGTgFtVLtK6uVuuD4Nu2imrumVQZl+I03pHJzqzoQZyRozUKNu3E9ROebDRREQf3/Hw7Dab7cucMcx/igfNnkSnsoMbotI3nbFWcQeq5GnmGCNFkkx+zCufwyQY9OCKmyUuWu8x6TWsIjzVvfu9bVWB1UYDt4ftDY9MBr9WxSXtsWWOtZ+AcwMFIe9/FBJcuXgkQZFZUjVQwjOe7Cy2pycJpWe2mcFAlAzZWuiWi2Erbx6isJhWXm5NByqiaakIMvw8+Lt3BgI/KkvofeZMoevht5FH7GsbxPb2jvTcyG6nEp+Uhccsi+/7SArD7Pb5XhS4IeFb6T/10RzXhT2mtjUyZeLJSnkAw1z6QzKbC46xtzxwVlKERKV/d1A7T3e5F1f/HK0q959cLilZ2dAsTUtIBjNy/HGpZwxB+CFL6wASb+XdJ2ZQdsMz5XoJ5ng6ZGsOG7OBXnqwbN7PAwzYTgdwCwjQQOnCVBn/DUOlXjYX+dL49a58KIZps5cYuFIPwkKYqSEbYCxcdeczP2GW7s44D9S5LDbn5vuAxrsA45gJdRWiEia0EUupvXl74fQQW2unQULwqGOFrIY5F/ylBIpL1BzmRdrr10Jx6I5StvYeM7rkidWJo8oWWUAJgfdYOksP92w0vrmdKk/5mLe2ZUNiOmPEaJ8yer+RNlyt5R2VWZQBxMnP3EI8YZv9bJoR6fLzG4XcoqS5QO+AkydoNBy+ZOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JVJCSC8aeZF+3whvSPRS1D6n6MtlG8xMiOtwMN7IupgJhcLs9KDeKAKzgJrN?=
 =?us-ascii?Q?8XOqY69+LZYV/0epkHqpCPGufCze38FOSgfVHyflrFH3xaCPMHMIBSrITHJz?=
 =?us-ascii?Q?Ftxu3x1/79N17VS3xdSrvRLqXGbtKHkmQ7k9Fh5/xq6W1jSezdcYRQn2IH0a?=
 =?us-ascii?Q?1c5CXwSpOgogjDSF8yLMYu6roFIF6JeX7TYZyWWQhghHRJUesK/cehxMIk2L?=
 =?us-ascii?Q?h9bRAntvkmgjx5aHn5gG/DNA5r/QOEaMa/u02vvBvAvoVO2zqQrQFlS1Fw1i?=
 =?us-ascii?Q?AcOxN7mMQUebiETrcjcUdMZFd6fSWSQ79DZnqMgaG8WsQBe3D/KYaXCLjxUw?=
 =?us-ascii?Q?8Qf9JM1EobErqeyBMsiIJZ7DjIzEg/2mgXvTjWS6HeUhR7q2rajrru+llZVA?=
 =?us-ascii?Q?9uRGAfPqFrGDnNk13UKHQ67NOKZfkkjrT0Ruih2ECMsxUWPY+wJAQsaQiGGC?=
 =?us-ascii?Q?7PGvKs19UHfxgNQQiqNU1BtISexJ3ywqjrcttpeR84W9olLVezsskgoLpz7H?=
 =?us-ascii?Q?wjUF4FcJ9xQ1Et43/Cygnhtw6ytPcpLxbZ7ESILVzWELBPmBsrNO6S2ABJI5?=
 =?us-ascii?Q?fM590IKVwWjIvOLIulg8nsGEJ2KYZfwyfRFI5RKi5hZOVyUUPxPI9rkbFAv4?=
 =?us-ascii?Q?XppefQNGg5+hb2btMopuWkSClIba9Wx5QplVozVN0thkfbmB0ZrEdkoxtoLG?=
 =?us-ascii?Q?4l/1+lWE5Gdse660FAXNy5L5qixhEHu6ppvCNS1S2eVjkz1C0/HJH/EQ0XLz?=
 =?us-ascii?Q?io73p413htoNYc75QsJytmCfx/bFAuSd2AwmuXnAgxb3Ogj6bpDw5Fu10Alc?=
 =?us-ascii?Q?YsJKiMhlhvXZFyedk2L8rXde6Q5PIF1l4ZlqtF1eyVu+iprQ1KK4z3dSdKTM?=
 =?us-ascii?Q?bixfoYVoMdtoltgWwaQUQuzSlfzc0s+CPoqLvrl3kvbqXPLpbR4TGsXIsc6L?=
 =?us-ascii?Q?qluLtMk2Okcki1SYwNHsljT8SI5N+BcYwx7q65uSvUIYRDhslqQ/HC3TtNLc?=
 =?us-ascii?Q?dWttfMexTh29QsoDpvhmNj/zGnKVb+ZZJjW3bhr+ht2oWbKKRXHswQ4qmN9o?=
 =?us-ascii?Q?iBfDkTCheU31VdwffLQLCqBmDxrh46TiPaXl2/IdVpoZmmihQToO9ofgFs95?=
 =?us-ascii?Q?mavHxszS2ZbTOFXqppfJ5GEoy7gWRv4PQPwvU3HpqjiirnAiy9oxl4hlub32?=
 =?us-ascii?Q?asgFkf0JLZjfjpYLDYu4qkzt+xG1/pspLFzWOOdEY8bvbxVHGrmHoLL7Wy54?=
 =?us-ascii?Q?qx9fSimS1UKcAjOqAbEUu1pP4a21YXCsuyIELu+ujh+BaPRUayaDClANM19J?=
 =?us-ascii?Q?37DmIQSHGK6EUMiHzo9qFwdR89eGtDJcNgUVzkwc1UzTP/08r/aRXv44Mk20?=
 =?us-ascii?Q?ZcVEfoJEVvhVQDU+K/ML+cXfX96KCeOJRrz3jR58boxmkw4A3OHItmRxXZZL?=
 =?us-ascii?Q?YFesgl0TAZBl0wyIAmWXfaqYdJ2aMXj4tKzRC1a7joOrqzO/uSpu5Z/PfrOo?=
 =?us-ascii?Q?c6ya/xa3EdylLB7cTUbCpKyx0SoszzbcaphV3xYS+r8c6AHcwMVm/2c7Rors?=
 =?us-ascii?Q?zALXdqpGBD+rjRhuoT79ZD1YNX0yPpzapavSBnExXRFXXUfawB6qxw1oMIl8?=
 =?us-ascii?Q?C2/zcdoqzYPdqP7QHcpAKHAgz/E7Bx9deHYj8RYu7BweRUtTK4ybJO5zvWkl?=
 =?us-ascii?Q?NKin2oAHPjyfjhYy0d9WoM8fbVQGdIrBbXtF5N2eE0RxlIh5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ed2782-4063-45f7-1ef8-08de74984aa2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:04:17.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMABY4isg+FK2BiWAc0bm+TISLsXzvSW40fdDky5Tr31thhksuKJ6Pd/Mhqulw+SiCOEdS7AFXvN2rGTkfeNeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9098-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13B8719C01A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:40:39PM +0800, Binbin Zhou wrote:
> Gather the Loongson DMA controllers under drivers/dma/loongson/
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  MAINTAINERS                                   |  3 +-
>  drivers/dma/Kconfig                           | 25 ++---------------
>  drivers/dma/Makefile                          |  3 +-
>  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++++
>  drivers/dma/loongson/Makefile                 |  3 ++
>  .../dma/{ => loongson}/loongson1-apb-dma.c    |  4 +--
>  .../dma/{ => loongson}/loongson2-apb-dma.c    |  4 +--
>  7 files changed, 40 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/dma/loongson/Kconfig
>  create mode 100644 drivers/dma/loongson/Makefile
>  rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
>  rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (99%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..e8cd1e2dac13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14953,7 +14953,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> -F:	drivers/dma/loongson2-apb-dma.c
> +F:	drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
>  M:	Binbin Zhou <zhoubinbin@loongson.cn>
> @@ -17721,6 +17721,7 @@ F:	arch/mips/boot/dts/loongson/loongson1*
>  F:	arch/mips/configs/loongson1_defconfig
>  F:	arch/mips/loongson32/
>  F:	drivers/*/*loongson1*
> +F:	drivers/dma/loongson/loongson1-apb-dma.c
>  F:	drivers/mtd/nand/raw/loongson-nand-controller.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>  F:	sound/soc/loongson/loongson1_ac97.c
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 66cda7cc9f7a..1b84c5b11654 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -376,29 +376,6 @@ config K3_DMA
>  	  Support the DMA engine for Hisilicon K3 platform
>  	  devices.
>
> -config LOONGSON1_APB_DMA
> -	tristate "Loongson1 APB DMA support"
> -	depends on MACH_LOONGSON32 || COMPILE_TEST
> -	select DMA_ENGINE
> -	select DMA_VIRTUAL_CHANNELS
> -	help
> -	  This selects support for the APB DMA controller in Loongson1 SoCs,
> -	  which is required by Loongson1 NAND and audio support.
> -
> -config LOONGSON2_APB_DMA
> -	tristate "Loongson2 APB DMA support"
> -	depends on LOONGARCH || COMPILE_TEST
> -	select DMA_ENGINE
> -	select DMA_VIRTUAL_CHANNELS
> -	help
> -	  Support for the Loongson2 APB DMA controller driver. The
> -	  DMA controller is having single DMA channel which can be
> -	  configured for different peripherals like audio, nand, sdio
> -	  etc which is in APB bus.
> -
> -	  This DMA controller transfers data from memory to peripheral fifo.
> -	  It does not support memory to memory data transfer.
> -
>  config LPC18XX_DMAMUX
>  	bool "NXP LPC18xx/43xx DMA MUX for PL080"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> @@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>
>  source "drivers/dma/lgm/Kconfig"
>
> +source "drivers/dma/loongson/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..963b10494ee5 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
>  obj-$(CONFIG_INTEL_IOATDMA) += ioat/
>  obj-y += idxd/
>  obj-$(CONFIG_K3_DMA) += k3dma.o
> -obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
> -obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
>  obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
>  obj-$(CONFIG_LPC32XX_DMAMUX) += lpc32xx-dmamux.o
>  obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
> @@ -87,6 +85,7 @@ obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
>
>  obj-y += amd/
> +obj-y += loongson/
>  obj-y += mediatek/
>  obj-y += qcom/
>  obj-y += stm32/
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> new file mode 100644
> index 000000000000..9dbdaef5a59f
> --- /dev/null
> +++ b/drivers/dma/loongson/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Loongson DMA controllers drivers
> +#
> +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> +
> +config LOONGSON1_APB_DMA
> +	tristate "Loongson1 APB DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This selects support for the APB DMA controller in Loongson1 SoCs,
> +	  which is required by Loongson1 NAND and audio support.
> +
> +config LOONGSON2_APB_DMA
> +	tristate "Loongson2 APB DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the Loongson2 APB DMA controller driver. The
> +	  DMA controller is having single DMA channel which can be
> +	  configured for different peripherals like audio, nand, sdio
> +	  etc which is in APB bus.
> +
> +	  This DMA controller transfers data from memory to peripheral fifo.
> +	  It does not support memory to memory data transfer.
> +
> +endif
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
> new file mode 100644
> index 000000000000..6cdd08065e92
> --- /dev/null
> +++ b/drivers/dma/loongson/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
> diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson/loongson1-apb-dma.c
> similarity index 99%
> rename from drivers/dma/loongson1-apb-dma.c
> rename to drivers/dma/loongson/loongson1-apb-dma.c
> index 2e347aba9af8..89786cbd20ab 100644
> --- a/drivers/dma/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> @@ -16,8 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "dmaengine.h"
> -#include "virt-dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
>
>  /* Loongson-1 DMA Control Register */
>  #define LS1X_DMA_CTRL		0x0
> diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> similarity index 99%
> rename from drivers/dma/loongson2-apb-dma.c
> rename to drivers/dma/loongson/loongson2-apb-dma.c
> index b981475e6779..fc7d9f4a96ec 100644
> --- a/drivers/dma/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -17,8 +17,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "dmaengine.h"
> -#include "virt-dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
>
>  /* Global Configuration Register */
>  #define LDMA_ORDER_ERG		0x0
> --
> 2.52.0
>

