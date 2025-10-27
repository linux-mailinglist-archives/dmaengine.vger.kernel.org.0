Return-Path: <dmaengine+bounces-7015-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C03EBC10867
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C68503C0A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81E3328E2;
	Mon, 27 Oct 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ixh1XGep"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43230274F;
	Mon, 27 Oct 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591578; cv=fail; b=igYzwBYiqTykaLdkKNTVBPGx6ODEexN84ToHZoOzQ3DH0L/370MOf7N+p69iNkpHnNfpn1C5ELB1RFjh33Ib2STKVyOubF+xMFpPCy/ONiGxqS3C8hDzje8XqgJPn3feM31+aqTAkLsicNNoMzMhxChgyadpxhgokJBkz8JJmuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591578; c=relaxed/simple;
	bh=GWlqaXFcm3TnLF/iQehewMVjohq0NUFujVdvKkRKXgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gw4pbhEt7CSgweVdjaRz+RFRZrN84dHhOTNLDhU0p2kpmgcONm49DMIypFGAXZAjy9+bRVMTWraBTQISNhk4BRVtmODMY+BLVUzncDZVSB+1uGwrCPpCpDK/tPsRN6Z8ycEMT82HcMxvl7MSQghays2A9we5FiltsvC1bFGN1I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ixh1XGep; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTzKig58gvo/VTpoXtwBipkQPaTUZ5ScrrkhRkVvf2vvc4ate0GlmhcuawA+zU/Tc3fTzcnB2AzA6lvWmbWG2EGrR+/bbJ2PPQyDiZoZcvlmIGwRtZ/2zuwLv4+6ts7OlVkuZ7rdzjg5LbxTbflW37594wpCaGaUceKKWEurBxbJzdbjcxQZkqgOOtewbcxjGuWRwoLfDd4ue2/Yg0W38jedldIOagsLSq2EsVAHB8umrk9D+Rifm4CvdX4DCpItFgD1lXvuFXgW7F5N+GhMXgmo2o/Er8NhspsGQ3FEal4z9ieXFFVCYzzeCzQDl7aEd2eJld7bWfF+wP1b++cVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvJX+cRkHrE5VuEbPfwgyJJ4+rBkv1qtDiKvgRi7kfo=;
 b=mWNXDoUXpdmj2+TGMha9xVtyI1QdHgOZULSpL9t0GJEhgsfs/2U06BFYQBp/jaByZMcUVyP9tQhtLsAjSGzGb+dSSSi8y4D7rl+8rmO5/68a8mvvm4JeR9Dpnt0DulwL7RCLR1MfQtjSogMBy4+wSUE3C5w7MRmMTRPbesOQzGBbZHDxrXYF3YYkI2x5nf6Lr8CDkYXOgcGTfGbQQRPO48hz5ghulg5H7+KNAXVAEvwEKl2tjf1J3UAyCzICpsIv0yIeIiQ+/33UwzeMPOagE9imdJpUB8WueboR79hXc+dGmqKYy5kaAXYZKsdxgwHiSwbK9i0oj3XdwkROWALTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvJX+cRkHrE5VuEbPfwgyJJ4+rBkv1qtDiKvgRi7kfo=;
 b=Ixh1XGepENlHYhAiwByYXReljlc6qNLOZC3PAS6rjf0WAiRZqjiOCv5x97Upl20bebeIe8Gc0kJVRkyHwDfDROWR8GXgvlcRhAkv7C40fgXeiP1FMupUw76/GOI8u5Rymn5eFgryTOwuW2YB/iwBFb5a780FvE7EIDZm+78Zhbm+t2gBe2QAkSpJmuyXBEa4ydGY28ZHtBxrpQjoaZbApvck5Jx4D8ly5CSu93pivrfDxobcdYGKnNFa1oikn3lFuDsEM32qFftBF2de89xiDXU3UqF90RMA0Yvvh5lakqchkDqNttvFNkOZ/J1QY60JL0iKd82HpiIyQ5f/XVYpig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10096.eurprd04.prod.outlook.com (2603:10a6:800:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:59:29 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:59:29 +0000
Date: Mon, 27 Oct 2025 14:59:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, robh@kernel.org,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: add device_link support
Message-ID: <aP/BCfg2NnPut5IG@lizhi-Precision-Tower-5810>
References: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
 <20250912-v6-16-topic-dma-devlink-v1-1-4debc2fbf901@pengutronix.de>
 <aNVufDmHjLRauKYo@lizhi-Precision-Tower-5810>
 <20251027011103.GR13023@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027011103.GR13023@pendragon.ideasonboard.com>
X-ClientProxiedBy: PH7PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:510:33d::32) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf75330-0ce4-460f-19d4-08de158af500
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FSWyqdhaGnp5AKyLJwyCanud81LkBueXeU3IEFvIqecGtf1ef/Ocnk0Ub/PY?=
 =?us-ascii?Q?qOSE/panZJhJXcc3qczHQUu5FUESQIp0oNb8zlYQHnWSoQlKfWFporzaqGhA?=
 =?us-ascii?Q?+2Lp9gyVELITgFoCoKYmYbyTKYZF65AfYkBqbQklJpuyKvMrT0H+L7ripNeB?=
 =?us-ascii?Q?PnKuhXC5mXPq701djdjYYvtycrHo7JsyQcfLLRtFUscKHPOdN8g4GDPth9nP?=
 =?us-ascii?Q?8WjK09rH4tRn7zjs/TO3wuuGt7NrZPztxGSBEVbgPlrU0nlJS1UtFmJxnjQa?=
 =?us-ascii?Q?VLATJ4185LKNXwPljZhsA+uzljw/cUoHRn4Br5CcYfNFlE24ZQQ1Tf/TLinW?=
 =?us-ascii?Q?qOEHzlFUQ1LpUZGbijv2swVFkKTH4ZkBu8ztKWobkEhjsTh7UYje8/SpUOZ/?=
 =?us-ascii?Q?o253qC1pUcKPQQ9wCjeq40orwgvV1yuciLUQmJ9zjWQYTkvnKTw0KLB2m4hi?=
 =?us-ascii?Q?WlQc1zBazesWnwmpkDW5oOvesYoO6SLmCS5MKzUQ/5OlbyHLY5bfx4J/Ay1j?=
 =?us-ascii?Q?aE3b6TsGYkhCQ5fsGaBiZ8/dS3JB+8ux3on8YKRiG+A8GE9mDwrdj06WRgm1?=
 =?us-ascii?Q?L04+I9erVW9/ImwSBao2G5Kv53asn4vlmatCLrIO8UxQbYEZRIf7fQFtVI0r?=
 =?us-ascii?Q?1yZTmkiRuuGSnNdwow6ZHkpYsK1FHxp8Rq+JdWHULEaChagMRe4cMXo6uC2T?=
 =?us-ascii?Q?3zoTX+NH9wEmkWqLnpwgY8lSK4Fg7q2zxi/inkkp3CHBzCbb63oETWSwb7io?=
 =?us-ascii?Q?+F9XRo7++2+WhBJNoViTZ6ZJZL8mI+rJqF7ZTsNCnPhJfM1guLRWks8eTK1I?=
 =?us-ascii?Q?q0NiyDUtxcfp0gn4Z5W2IGNga7yDQjLIa6GSHLwKTQ2x9HM+Mt6VPUZy389r?=
 =?us-ascii?Q?glYiuziTCxSVnX83XjP8+5d37LTh93WrVWoyrXPy08tuKggFv9Tir5xQWBps?=
 =?us-ascii?Q?nf56Kj3HHQ9d+9AzK/IezCNDS0+E1kkIQ+DDj9s40IOBQEv7vcXiQdA1DbTS?=
 =?us-ascii?Q?hXEEvJBZ7yGl8lXu8ooRvq8BYav1NN6lcycdKvW2lMclopGyrMHBeVeNg9zj?=
 =?us-ascii?Q?AMKOdyjrL8ytKNCer2uYnoI1rxNl0sCwBjovK2pn85LNmj8YE2tcLUYPBphH?=
 =?us-ascii?Q?Iq9twY0EA8h1UHsJ9WvciRaGERK5HFsV0yQTSNaQOchd4Ul66YH9n5QlmWc+?=
 =?us-ascii?Q?NL8c4ZBCipuc/IPUJiA1fKa3yzvr7k5bRU1ao0j0hTJQ1CDLokMC2khb3bRg?=
 =?us-ascii?Q?tgNRsV+eYzv04Q2ESR79Sop+JNS++jMNtKMMhOctlOuUtib0tw4kuVaBjPlQ?=
 =?us-ascii?Q?904+DfCBDobBW0JnRmOwMwdsP8j+Xm1PETbpdgYLBtzEqRLk3CSiufx/khbq?=
 =?us-ascii?Q?zz6ghMXWM/xN4r4v3mNBgqiHf4Uvp8WgX8XjOYaEIxO0z+5A7oXJ2QkpRWPA?=
 =?us-ascii?Q?k2L5q5PL3yJ2eRg+DYqmcIm4RPluqFK3QS5onmnMEsW3N7oRRbs5Bw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6sluUhvg+rGSgO/PKdRh6PJJZbjNW2WvwowweBw/eilfMqBQ6fsU1livRSU9?=
 =?us-ascii?Q?MnQSJIAfqcVCJ3USeyqJpLjey3ExxJV7jFAaU2vrIOzUrWCREAyu5XBhmYEX?=
 =?us-ascii?Q?1QiSnG/WGCZRUuQSyS71mMyB2yZGqlgOVLhVUAK6UDQYxCQKxb9nu3/eZM7w?=
 =?us-ascii?Q?NiC/uIl5x2QUUpSckQpeZOjhv1JP17v1FiAn/yRx3my38SiT81fng02cyvfM?=
 =?us-ascii?Q?YCDKOw8/AYqjys9PDCb+dLCDLAZ63oNuPRZnKy6TqnhTSXe84zhKZIqBOqSX?=
 =?us-ascii?Q?MuClSFyRWuYB6001XTMhiAjMwMQlc5ZmEZ/kjmngUKyiYPdzGhFq8qX2aDE8?=
 =?us-ascii?Q?RbyNj3oCa50evpYT0kq8EA5RKO44P46H5dMNlxWl6I3q62hu/sMqX3w0gc0B?=
 =?us-ascii?Q?/mOlmfzecERpJSyCpX4Bf2tn9wiPvsTZyRR6LIVtfFvEtaVKMWJpc8+XM7Wt?=
 =?us-ascii?Q?XJ0iowHwJayci+lJ9kWcaMqt7NyRBLOXr7Iwh0CHByDIAGoMs6zFUsYn75qb?=
 =?us-ascii?Q?WTwnl+XvqtenQXdxUO6ZNgk8KkX5eCuaVylK9y24C9khtENIzqa8a/pPNe88?=
 =?us-ascii?Q?cl3Q4hLGyTPQ3FqGTm7hnFh632rUjcqH5g5jXuyznF0dXEN/rtjjQjot383i?=
 =?us-ascii?Q?REgyd3EZRJKd33BZdpvPHu3ReFRNGgNZYFYeCi3Vp5Ccut+ww6dkFiN1R5Wy?=
 =?us-ascii?Q?4o/GfEkGF92T97Xnz3cHHlIRjQ4aT1TUwYsiNbBWPVYRbYsiKwUBqFNYNeXu?=
 =?us-ascii?Q?xPc7xrlMzJEZVHEYr9wXFjk2aS01xSEHu8st/5LOOvijakCagW75Qkrnkw0H?=
 =?us-ascii?Q?VR5mCw0cOBPvaJNjbkPVjofREYlhzkc799AXmy2s28d2l5YQ1zKCL7Z+nmEj?=
 =?us-ascii?Q?SXKumlEtc5oS8CS3rpDevFWCbxQAltx66f+Ti6tXWdNwcnc8CIz4td8YGFX2?=
 =?us-ascii?Q?EC9mZgYc+TMCSeIKSfkH0ElSz1ldE1kWci2ax1fxIycelrCJf5b7qdBsos/s?=
 =?us-ascii?Q?o1/6LkJTIWdrBQNqIKG/76w0deNy/kPTXhCmCbpvoDYfoBhp4QxuhMf5CyFi?=
 =?us-ascii?Q?WwJ7d+C15bAmDmHZRtESvUurfvCiYjqydQ+Sr0vsRoiIX06UwycL+ylTs+kK?=
 =?us-ascii?Q?P2S7MRKI+zOBs5/PURzNZQEt4I2VPRZ4uLBgEWTo4PfWRC+u0PrGASeC52t3?=
 =?us-ascii?Q?aX7pXZKQGag5ahWIVyf1iOvN6tXTa71+3TjtWkw8XlRL0jkqTD+QdHPDcCpC?=
 =?us-ascii?Q?U7fSp5dWPbUEAvuHAcrc4UXG99QyMsdwVFkCAGBpKsPDRBSzotpc1BvkKuKz?=
 =?us-ascii?Q?IAhHZdgddgegCthS1le43Xa5q9T/MBfzFRiLaMrwC8nX2wdz/xGQKJncojWJ?=
 =?us-ascii?Q?VI56L34YZX4UA6/Tcm0YyKMX/20LN1kzdh4K9jxKeAhj5Em3fp9fzi+OGmYW?=
 =?us-ascii?Q?GYZQlabAENIuJ922i1NXDgTwqf0RmvfhJWEREJMSS1E/PmQQqwXg+gxQzv9Q?=
 =?us-ascii?Q?cvUByiEMy0n6gAcdXOMrFSrGaWX9+IjrMCsgtxWd+sjNQDd5o//7QBVi6gxP?=
 =?us-ascii?Q?i2B9FcOcmgfuk2eIJctIdkbCqrdWgsmnxaGx8y9y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf75330-0ce4-460f-19d4-08de158af500
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:59:29.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3GS3ydvNajkxBNP2ZeYdYZqVX0v9ZVPMeqxYdYZkClMfMOoVzv+YoLQXUmmdzkGvFCiHRBgT7fCtGeU1dtrTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10096

On Mon, Oct 27, 2025 at 03:11:03AM +0200, Laurent Pinchart wrote:
> On Thu, Sep 25, 2025 at 12:31:56PM -0400, Frank Li wrote:
> > On Fri, Sep 12, 2025 at 12:00:41AM +0200, Marco Felsch wrote:
> > > Shift the device dependency handling to the driver core by adding
> > > support for devlinks.
> > >
> > > The link between the consumer device and the dmaengine device is
> > > established by the consumer via the dma_request_chan() automatically if
> > > the dmaengine driver supports it (create_devlink flag set).
> > >
> > > By adding the devlink support it is ensured that the supplier can't be
> > > removed while the consumer still uses the dmaengine. Furthermore it
> > > ensures that the supplier driver is present and actual bound before the
> > > consumer is uses the supplier.
>
> How is the latter ensured by this patch ? The link is created in
> dma_request_chan() (which is called by the consumer), after successfully
> obtaining the channel. I don't see how the link improves that mechanism.
>
> > >
> > > Additional PM and runtime-PM dependency handling can be added easily too
> > > by setting the required flags (not implemented by this commit).
>
> I've long thought that the DMA engine API should offer calls to "prepare"
> and "unprepare" (names subject to bikeshedding) a DMA engine channel, so
> that consumers can explicitly indicate when they are getting ready to
> use DMA, and when they stop.

This is one validate method. Maybe we set flags in dma_request_chan() to
indicate auto prepare when request chan to keep compatiblity with existed
drivers.

consumers who support prepare/unprepare can clean this flags at
dma_request_chan(). So we can smooth switch each consumer and dma-engine
driver to support this prepare/unprepare.

Frank

>
> > >
> > > The new create_devlink flag controlls the devlink creation to not cause
> > > any regressions with existing dmaengine drivers. This flag can be
> > > removed once all drivers are successfully tested to support devlinks.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> >
> > Add previous discussion link:
> > https://lore.kernel.org/all/aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810/
> >
> > Another thread
> > https://lore.kernel.org/dmaengine/20250801120007.GB4906@pendragon.ideasonboard.com/
> >
> > Add Laurent Pinchart, who may instest this topic also.
> >
> > Add Rob Herring, who may know why dma engine can't create dev_link default
> > like other provider (clk, phy, gpio ...)
> >
> >
> > >  drivers/dma/dmaengine.c   | 15 +++++++++++++++
> > >  include/linux/dmaengine.h |  3 +++
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..e81985ab806ae87ff3aa4739fe6f6328b2587f2e 100644
> > > --- a/drivers/dma/dmaengine.c
> > > +++ b/drivers/dma/dmaengine.c
> > > @@ -858,6 +858,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > >  	/* No functional issue if it fails, users are supposed to test before use */
> > >  #endif
> > >
> > > +	/*
> > > +	 * Devlinks between the dmaengine device and the consumer device
> > > +	 * are optional till all dmaengine drivers are converted/tested.
> > > +	 */
> > > +	if (chan->device->create_devlink) {
> > > +		struct device_link *dl;
> > > +
> > > +		dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> >
> > I suggest link to per channel device, instead dma engine devices.
> > chan->dev->device like phy drivers because some dma-engine have per channel
> > resources, like power domain and clocks.
> >
> > Frank
> >
> > > +		if (!dl) {
> > > +			dev_err(dev, "failed to create device link to %s\n",
> > > +					dev_name(chan->device->dev));
> > > +			return ERR_PTR(-EINVAL);
> > > +		}
> > > +	}
> > > +
> > >  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> > >  	if (!chan->name)
> > >  		return chan;
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f..c67737a358df659f2bf050a9ccb8d23b17ceb357 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -817,6 +817,8 @@ struct dma_filter {
> > >   *	DMA tansaction with no software intervention for reinitialization.
> > >   *	Zero value means unlimited number of entries.
> > >   * @descriptor_reuse: a submitted transfer can be resubmitted after completion
> > > + * @create_devlink: create a devlink between a dma_chan_dev supplier and
> > > + *	dma-channel consumer device
> > >   * @residue_granularity: granularity of the transfer residue reported
> > >   *	by tx_status
> > >   * @device_alloc_chan_resources: allocate resources and return the
> > > @@ -894,6 +896,7 @@ struct dma_device {
> > >  	u32 max_burst;
> > >  	u32 max_sg_burst;
> > >  	bool descriptor_reuse;
> > > +	bool create_devlink;
> > >  	enum dma_residue_granularity residue_granularity;
> > >
> > >  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> > >
> > > --
> > > 2.47.3
> > >
>
> --
> Regards,
>
> Laurent Pinchart

