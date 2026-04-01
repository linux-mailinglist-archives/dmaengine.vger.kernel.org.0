Return-Path: <dmaengine+bounces-9814-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GpvIfCdzWm9fQYAu9opvQ
	(envelope-from <dmaengine+bounces-9814-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 00:36:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6B381070
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D36A2316E15D
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545E3CF02F;
	Wed,  1 Apr 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OgvpyrP1"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A23B7752;
	Wed,  1 Apr 2026 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775082471; cv=fail; b=IQY5O6itRMl0pGcLPztBrU9FUKK0fG2qtldt1Md2g3BzcdoV7r0Zyu0Jbu64//tOHeMC+EC7QoU3U8VcZHpIVLvMCsXsTsqKp0PsYKV35CCtAVxSWc1S5nZzFKdCrgXBITxlwIQoTlAMs0Q/a6GSTZlp6Q9ISSxupXjoR47XUnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775082471; c=relaxed/simple;
	bh=9CExT1KQEQ+dfDxDexZyvvNRegbdmjPU+zKIgA9YNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RHwLze23r6TarQg6AX5kyqaYVG2L6+hD8HBwtzn00GKk01UqOcbeM/eiMleqov4Eze4iRU1YvvQxGTAKGwa9FARYoY0P0z0aju8dbPrHj7DNzhkQiIqrB+Vk2OIn4ySj3O6WrzXu/IcSbjeh1bDIl5FSBw2iQyPVibx9O+FjjVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OgvpyrP1 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjIbM86pddzCdUcNOsxq7wwKbTH/BRciU+/BiMUUfOG1DziBz0hiSnhsXEQ6qf0tJ7qpjglHIqdQRtz1J65UNWHorFTpt1l1Y1BcrBeAmXEGa9WH+3/HLQhnKn4/CC3Tq/3eTtQTGN/sF+pzkguHT83QUCOrkn8zzrPe4ZNwknUUmHhZ+sqaRUM2NKwSxwOCMcdinCQv9M+CqWoWFk7TBD0/iGiCeGuTzue7MkHlaYlU6kYXUshYhumQuymgrspwTk69y8STSauR3BMpCssBlwMsPAwPk+YmHhitqTcPBY83Tm3fUxQjtzz2tUxYAo9dxWpKf1iZ+otCIENDBrcFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oCNpG/opc0IKe79X1xmaZ+7DIifMW6WsB1RQ5/4kVY=;
 b=XFyMTiUc6NEBNKWpdrMFDL9YNpFCxLPfNPEOBB0jZBtjnyg4r7UJ/L6oWepSkRYjT3hgBlPZSvVsqcB97jjd6qkFl33wx1QPrc3A07clneQsyWKRlp1RiumPvQ5qgXc6EwAEQX3ot7TSIUeo2FsW10YxyrphxBVHZ4Ts7C6f988h4f0D/RQ5uKEbUy5R8qQtS9Tmsc7I/pW6h5bQAeGxJ+T9Xm7yxpTooLiRvZsI2jCEOMh80jGd2Okyds40moZfv2VPomSXQVuMm4yCETJ2UIplh4zeVNdL+ZCoVZ4auyWG+n+FmQp5oeDu/bvQOhrJbplfzudoyZhAnP5CFC8z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oCNpG/opc0IKe79X1xmaZ+7DIifMW6WsB1RQ5/4kVY=;
 b=OgvpyrP10yET9XSl+1IYvZMIpnRSxgmtP/5cnmUm0U8QTqriDOt9cOqOnSwVPuaGKRMx+8eumqrUiGcJjltIqKAqkVXchemilQysoTc5FdBCqF3lUVzIgZf8CcE494kYGODgCwCLzqSc9+YaUM5mq1qoXswwrXVSWMq7D+Abs/qL8zveszlPMTEsdqTg8LQP5YbUfoQz2576WO8vQipF6NVc0sHJnfq5zBSXj+sRGkbZ0/m+eh8720I43KFW/hv67+HVQykl2Ag5lX6rHEurEIj67ygj4DQR2w0nlJk6X1Ryi1vRQorA0uqUHZkFdSL+mZ+ODx3dx1pKNt+YFPSadg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 22:27:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 22:27:33 +0000
Date: Wed, 1 Apr 2026 18:27:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <ac2bzkImYBdujGPS@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
 <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
 <acuJ-Girr0ozQHh2@nsa>
 <acvXKYJkXID9qiqM@lizhi-Precision-Tower-5810>
 <acvmNkDwLsdJCvWa@nsa>
 <ac1C8VdYXe3pMu0B@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1C8VdYXe3pMu0B@nsa>
X-ClientProxiedBy: SA1P222CA0076.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a2e6b2-496f-4dae-f367-08de903dde91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ytE+3Zz3ZgLMerLG2q1wmvZlxftGXmsZOtq5xBm2dLDbtufS9CoaNjwq4HViJH4H2aYhhCltFMT4d86MgiHx4j6E/9OSRAv157kafKyRJqKqN7WMNF31BYMimx6dp/tAZel4B4zyilECX55olztXFdWXU4PkEPfIT6sHEFx/sK8XAyaySiu2EiED2sNducDAPvQvuSuB3xzhIuWM+YwnnfOTADuu3q1QHmz7OSIxV3PAYn1WVGPtbm58YjPK5Jzlp4XBkALIChAOEZZ4G1XCzoDxVvy+dIhXxRC7NekDRVzK7qW1Z/qmfZES2TtKngJFTsyczDHk9kETHiMVWmYvaLwQ7gatKcj1uuLtJTP0/AeLEeJVGVqny61lqyCV5s6bSTewL+Uwrh6IQJ9RdMF8XMaSZl580llc2D9UVyJ2IALZ8MmXVipwybkM50haa3uShyjDXdxq7QTNKCVu6oBcX1kprG3n7CjsWJ4SgruSCzNStfM9BsLi2wGDQkW2O33Q7U7e9sSzVw5t6F6q+1M0K0PYeWhN/dDbPrS8FCtGOCcNaGCcUrCzy4nPXdF+5IUM7C+OlHVFqLazR/uH9iQ/c79YWkypfL2K9A98HIpL1ZvjXDTc1wH60zooFSFybyVQMC4QrHL28MbbhfVpzVbJGizAJXijbwq8WP5Yiy5bPiHSug+yyjYjLqkEtz2CaikMNMTJOccCv+LtZVMNdt2Xo5ORqjhNcuQFCiIWZF4B2rnzsNgIBP1JH5L/oWsn3K86
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?JfoPBE10jP+L6i6eZKMh3BLZBiAzHLh+whiPyad0CUEi6f9lM8JZQmStdj?=
 =?iso-8859-1?Q?ReKStO34c8IJvYl0OH/Rw1NSBg2pisVR867wg3jMOhjbp30dd0AjwZlkoM?=
 =?iso-8859-1?Q?4fznhsJ0zpfNKN+DsKS7Xs1QWHdhcLv1nW48lIdnfU+9vzskfB8C6O8ays?=
 =?iso-8859-1?Q?SXomz1K8nvYGjnHjR2Q144mERb9lNw1dLmKfyx8i3+P8OEcSb5GbM1IS6w?=
 =?iso-8859-1?Q?EI8164F4E6Rtr2INqExs09Id89xHhp4R3PEH5kzRspzJobz4p/b0ymdyHI?=
 =?iso-8859-1?Q?738U3XiNeuqsEiDHH5ekkL59OM4UenFvTipeBh7L7MJghSugrP+DfKM5J3?=
 =?iso-8859-1?Q?VumkXnwhdjkmusHYkJn/c65tnSLw58dQtqwOoepxvAuVthKQtVCfgrp14Y?=
 =?iso-8859-1?Q?XOGFws7/VpEddjKfxIIKBdWMhAA+uxOeIolxK3i4Wz/qL1CfzS/MB7JVDA?=
 =?iso-8859-1?Q?SSGUw1PaU+QMfBMCcdQqEmNKaBZq9wWxBxs5vWdQqZ924/x6JTiirCgS9V?=
 =?iso-8859-1?Q?nY+8ffP8PsqXkbDKKTaZx9rV8bBl+msrOP7+LdfwyRalUSptNXsbLqvHAy?=
 =?iso-8859-1?Q?kuG2qKWVqUcGaz+CRGT8MkWCQqppUyoT5CeS4fit2ngls9s4HGPVHslH2S?=
 =?iso-8859-1?Q?W8/U/Kx8eNZS5opUQd9vJqNIYrbCFBFm9hYpT0nm784eIYj7tgHWQtr4wk?=
 =?iso-8859-1?Q?VIAM0xMZ6JtkmRt9QBoL3fSkQDUEEXjPNO/nkqKgnVQxMjIIbb4zSq1N/v?=
 =?iso-8859-1?Q?m8/cYT8MLxPONdXyg/SdK4OJlZtx8RVFLhmn65xR0GmIgXGRy9wzeVV9FD?=
 =?iso-8859-1?Q?J2XcWyXjbd/o39C/F3SU/tzBtzX2d7VABToUDTHLltMvnQjphjfJVt/OYo?=
 =?iso-8859-1?Q?Y641AruHqSM7tb7tYl2cfqMzCN02ITcYxtdV9GlsqpgGkaqK5Ts+TkAicm?=
 =?iso-8859-1?Q?fbN3/RnBA3IKar0iIPJqvsXw2Po6w1rIx2oFHn/0/CuH0e2YXvexeGb9PP?=
 =?iso-8859-1?Q?Hzu2WLsUiGrOFJ07E0fhFyv6BVTtxEUNIELwIBxQkHQDD0OSaJHtaIfCy/?=
 =?iso-8859-1?Q?tqqcPtgu3Z/A49bzlCg1hDhahY9VtGBrHJGTRNdsGpIVYD45S8mk/nzg40?=
 =?iso-8859-1?Q?44j9GUg63l2C3WmF9bCjcUXIfqUQX0DDdIDQMEAgRl4AqIA3J6m5QqDFWa?=
 =?iso-8859-1?Q?z7CLaP6U0GNvzsYqplUhlKq+5IWtbY4hHgYaMVgz50kL8yL762ygblyhf4?=
 =?iso-8859-1?Q?R0/U9EkU68KsjmG1DWiBAl/ntJ580khRNuYNWTa4BPxExr5y++NVZhfzsB?=
 =?iso-8859-1?Q?Hyeg6QO9wHe/zRzk6l4+wEV0N8tgRHr+a2N8QJAdhkOQ6vfBQaJEeBe2bI?=
 =?iso-8859-1?Q?fimUJ9KwWZDl21WZM66G+YJbdbBTCeAnv51r0aUbv20yBu1kavBy2zMhp4?=
 =?iso-8859-1?Q?I8/Cq79jsrg5JAHGcgHmh1pCB8JSSFeA1c5Nv7QLgv8k0QiUsp4R5R5f7f?=
 =?iso-8859-1?Q?7GKk063BwXu0wGMLG7/UgLsI5hhOpNL6p7+bK3I4HWFd8C3q8xyr46x6yj?=
 =?iso-8859-1?Q?qAZRxfzjZneshToe9eN503DgYS6NBt/CYcPF0cQgk5zd2Lm9B78lOaspv6?=
 =?iso-8859-1?Q?U4qCXG+7RHwYw0HUeVFISsZr+LNcfZnh4DHSIferjXW4ormOntg1E2dJzL?=
 =?iso-8859-1?Q?GIYueJ1Qp9AahIEDFbmai+WVYEQwShsQw6avVNeDPMCa840Lza33fdxJ3V?=
 =?iso-8859-1?Q?dU1HEhVvNTw4kpyUIhjEZDpYGrc/VetNPnbaFSMsd553mW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a2e6b2-496f-4dae-f367-08de903dde91
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:27:33.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk5ONXAZKIkEwliaQPuU+fDeDhijINy00EUf+MO4oFOtkcOBlKstQKamXDZgI2XEh9S2zjPYKrg6DGOHa67FEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9814-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_SPAM(0.00)[0.265];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 08D6B381070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 05:14:16PM +0100, Nuno Sá wrote:
> On Tue, Mar 31, 2026 at 04:21:06PM +0100, Nuno Sá wrote:
> > On Tue, Mar 31, 2026 at 10:16:09AM -0400, Frank Li wrote:
> > > On Tue, Mar 31, 2026 at 09:53:45AM +0100, Nuno Sá wrote:
> > > > On Mon, Mar 30, 2026 at 11:24:34AM -0400, Frank Li wrote:
> > > > > On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> > > > > > From: Eliza Balas <eliza.balas@analog.com>
> > > > > >
> > > > > > This IP core can be used in architectures (like Microblaze) where DMA
> > > > > > descriptors are allocated with vmalloc().
> > > > >
> > > > > strage, why use vmalloc()?
> > > >
> > > > It's just one of the paths in dma_alloc_coherent(). It should be
> > > > architecture dependant.
> > >
> > > Which architectures, this may common problem, dma_alloc/free_coherent() is
> > > quite common at other dma-engine driver.
> >
> > I'll double check this but I believe this was triggered on microblaze
> > where we also use this IP. Will come back with confirmation!
> >
>
> Hi Frank,
>
> I now went to the bottom of the issue! The problem is that for archs
> like microblaze and arm64 we have DMA_DIRECT_REMAP which means that when
> calling dma_alloc_coherent() in [1] we will get into the code path in
> [2]. Now I did some research and we might have other solution for this
> that does not involve this refcount craziness plus async work. But I
> need to test it. FYI, what I have in mind is similar to the what
> loongson2-apb-dma.c does. This means, using the dma pool API. IIUC, with
> the pool we only actually free the memory (dma_free_coherent()) in the
> .terminate_all() callback (when destroying the pool) which should not
> happen in interrupt context right?

I think so. If your dma engineer descriptor is link-list, suggest use dma
pool. If it is cicylic buffer, suggest pre-alloc enough descriptors when
apply channel.

Frank
>
> [1]: https://elixir.bootlin.com/linux/v7.0-rc6/source/drivers/dma/dma-axi-dmac.c#L549
> [2]: https://elixir.bootlin.com/linux/v7.0-rc6/source/kernel/dma/direct.c#L278
>
> - Nuno Sá
>
> > - Nuno Sá
> > >
> > > Frank
> > >
> > > >
> > > > - Nuno Sá
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > >  Hence, given that freeing the
> > > > > > descriptors happen in softirq context, vunmpap() will BUG().
> > > > > >
> > > > > > To solve the above, we setup a work item during allocation of the
> > > > > > descriptors and schedule in softirq context. Hence, the actual freeing
> > > > > > happens in threaded context.
> > > > > >
> > > > > > Also note that to account for the possible race where the struct axi_dmac
> > > > > > object is gone between scheduling the work and actually running it, we
> > > > > > now save and get a reference of struct device when allocating the
> > > > > > descriptor (given that's all we need in axi_dmac_free_desc()) and
> > > > > > release it in axi_dmac_free_desc().
> > > > > >
> > > > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > > > Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > ---
> > > > > >  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
> > > > > >  1 file changed, 37 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > index 70d3ad7e7d37..46f1ead0c7d7 100644
> > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > @@ -25,6 +25,7 @@
> > > > > >  #include <linux/regmap.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/spinlock.h>
> > > > > > +#include <linux/workqueue.h>
> > > > > >
> > > > > >  #include <dt-bindings/dma/axi-dmac.h>
> > > > > >
> > > > > > @@ -133,6 +134,9 @@ struct axi_dmac_sg {
> > > > > >  struct axi_dmac_desc {
> > > > > >  	struct virt_dma_desc vdesc;
> > > > > >  	struct axi_dmac_chan *chan;
> > > > > > +	struct device *dev;
> > > > > > +
> > > > > > +	struct work_struct sched_work;
> > > > > >
> > > > > >  	bool cyclic;
> > > > > >  	bool cyclic_eot;
> > > > > > @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> > > > > >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > >  }
> > > > > >
> > > > > > +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > > > +{
> > > > > > +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > > > +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > > > +
> > > > > > +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > > > +			  hw, hw_phys);
> > > > > > +	put_device(desc->dev);
> > > > > > +	kfree(desc);
> > > > > > +}
> > > > > > +
> > > > > > +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> > > > > > +{
> > > > > > +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> > > > > > +						  sched_work);
> > > > > > +
> > > > > > +	axi_dmac_free_desc(desc);
> > > > > > +}
> > > > > > +
> > > > > >  static struct axi_dmac_desc *
> > > > > >  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > > >  {
> > > > > > @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > > >  		return NULL;
> > > > > >  	desc->num_sgs = num_sgs;
> > > > > >  	desc->chan = chan;
> > > > > > +	desc->dev = get_device(dmac->dma_dev.dev);
> > > > > >
> > > > > >  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> > > > > >  				&hw_phys, GFP_ATOMIC);
> > > > > > @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > > >  	/* The last hardware descriptor will trigger an interrupt */
> > > > > >  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
> > > > > >
> > > > > > +	/*
> > > > > > +	 * We need to setup a work item because this IP can be used on archs
> > > > > > +	 * that rely on vmalloced memory for descriptors. And given that freeing
> > > > > > +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> > > > > > +	 * Hence, setup the worker so that we can queue it and free the
> > > > > > +	 * descriptor in threaded context.
> > > > > > +	 */
> > > > > > +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> > > > > > +
> > > > > >  	return desc;
> > > > > >  }
> > > > > >
> > > > > > -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > > > -{
> > > > > > -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> > > > > > -	struct device *dev = dmac->dma_dev.dev;
> > > > > > -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > > > -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > > > -
> > > > > > -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > > > -			  hw, hw_phys);
> > > > > > -	kfree(desc);
> > > > > > -}
> > > > > > -
> > > > > >  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > > > > >  	enum dma_transfer_direction direction, dma_addr_t addr,
> > > > > >  	unsigned int num_periods, unsigned int period_len,
> > > > > > @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
> > > > > >
> > > > > >  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> > > > > >  {
> > > > > > -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> > > > > > +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> > > > > > +
> > > > > > +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> > > > > > +	schedule_work(&desc->sched_work);
> > > > > >  }
> > > > > >
> > > > > >  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> > > > > >
> > > > > > --
> > > > > > 2.53.0
> > > > > >

