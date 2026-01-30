Return-Path: <dmaengine+bounces-8627-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGw6BVLVfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8627-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:59:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD3BC525
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A8053042770
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2BA3451D5;
	Fri, 30 Jan 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+8yTesu"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7F345CD0;
	Fri, 30 Jan 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788723; cv=fail; b=oMEh7hNM/vmtmAkgP42OeMl++hqPKFk/FkqlbiWG1MQhyTGVdU6vYXH/vXq1L4v72t9ogekUflrd3/8Nq926FGdCYnH601wmGRjSbfdgfZPYSJyJ/NjDM8GgSyx2GQ1mIiIlk1JaLfW2bRtruurxA25nqfUt3YXpDNQGzMioRHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788723; c=relaxed/simple;
	bh=DBiC5Of++VBdnNd8WetmTBP9WEfyxNJDzZ/ZJWbsOmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMiRMejgYIyxcvCCcTktdNShVNxivvDnlgPhpjPJRpcRTGFKaxh8IS+BqdXu1GmIED8CRgz2TtyM+aqFcIc2Kw922BZi/gQibWTdYt/Ks1nkWiCTnuihgOfSGa9s9e95Ouv9tJosJvy43PyJbg8DuOMqWKkaws/1tD4aP+YjoZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B+8yTesu; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCtSuKaLup8Ucbb1PqBqW0D5sH0ogfOg9FrNSo0SLz5fEjO7LtM1xEMfNCn4UATXeDj2JhVrOnim7XDjJeiUSRa1D9gFrcWBiL+Kpx+KSbx68a6a9s+5DbELAJw79W+fIs5G2TmNm1CGHQVBLFwpRjinB3idscQ4z0qRXeBp9kp5Ew9l8Eic5AwYVKWi9hOTSNp416SLl6de0m8bsNpydUnKjoW2Nxnq1+zxdiWm8Nx3dN2/vhgFGv1hNhaJ1pZPnC6wEYykamWtFKtu9NlVu997rK3PVAEPiXMdkDl7b3EtCdTNEzizBH/PxOVgcQM6gaVdAhQeozP4DaWZ0q1o2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeKM5cZmnaiGHaHqPQObTDn1u4Ppl2B0B5sSnkKa68o=;
 b=n0sFzC+Gqu96tCOpgTk9lIF9Qd9p0jikYrMIQvdjaLmdRSVVER6Cxt7N/DF5LvqKhgFVgYIsIkYmLx6AwI5r0jyNUgIrPkpju3a4Y4f91M6yqDM2Zy2hFvACbYahoLkBzfss9N3utsfvvZpRWRSeRXvD7CxmJKRnLnfJB/H+aLMJJ3RdlgLOGZlDvKAqJzQsqeIWHszA8A8Z+yXaLSNMrJIlZRWdH4IFADIzClbgpVJzmZ2wOI4N+X1xkU2Um6Plt3JIcGnGNAIJkZ/kR0fQ1HXIUwyzyReJNx+jno16EzBFRPgDfYATSXThnDgYn5XyOj9WpvDcZiFBpgpHMn0SgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeKM5cZmnaiGHaHqPQObTDn1u4Ppl2B0B5sSnkKa68o=;
 b=B+8yTesuHeegmWBwjTCRTfoGR2gpl/AiU9j254+7Pim62PXgjE0/cyMe21sGT9RwRKOsMqypmRI2QA+eEJawyGWWgHaD75gOzbxEVjYSH5cC7wgqltwehKyXKJLESXKToO2gmhnsA+hz9a72Mjuxk/8WKogI1JC6yjHQuWwmmjHllXCfFdNrgVlD95EP/VpVEkvPDtoAuV9gAyaLH6wLWo/mCZSrSigb2dNVYoYsKd8lnRlzG0OPnC/kDueVDyrGHiiYR11nlVvefePkzEJ9KGrOQNsVaAHOzaZFIL3plKq6i9wbH2nm6151BYFqUBThdl9l4LfZBn5SBGlp4vVvMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 15:58:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:58:37 +0000
Date: Fri, 30 Jan 2026 10:58:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 07/19] dmaengine: ti: k3-udma: move udma utility
 functions to k3-udma-common.c
Message-ID: <aXzVJLX3uWNPeqI8@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-8-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-8-s-adivi@ti.com>
X-ClientProxiedBy: PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0564dc83-bdf0-489d-b2bb-08de60186d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1MncxYmRTZXeTcCL1GrWuP1jXGMiGKOFlKvG65T2AnU71pRrJYyl6vWoF395?=
 =?us-ascii?Q?UvFN9zQT1+ULjJNmKZ9W2V32r9tCDTTZikVrlktKNV84r/qCpDDM9BBdb5kf?=
 =?us-ascii?Q?Fi63jkj1cbsLvQjd466mTVeyLMQGKTFWqW7P0u+uh0lrw1ZnyQSTG70ouand?=
 =?us-ascii?Q?ep9hEOevczlLdM1l2gp06t0i9gM2jpIBhHrvsqRsE2zEM4paXGQ5BPIBLBdc?=
 =?us-ascii?Q?7cY3/N54Vf0kH+ahkMA5ZjvlpDvmK+ryK3M/GRNObGhBT7/U+za6FrIPcnjb?=
 =?us-ascii?Q?4iKyObEuSS31+H+OGqjqi+L+PjQGxGCTiO/i43TFTb7AjF1yl1/uq1TUNsT7?=
 =?us-ascii?Q?HfpojAVm4fff9eSoC2uKy9cwYVjaFDLMlB/gxC93f+5NRixJWBICak4vkXvc?=
 =?us-ascii?Q?J5q+hmNgY5GgZ6iv6cx0SsTsqpjro1kP5nZasUIKwqgQsGQvCGz7BiD/0BPq?=
 =?us-ascii?Q?1hIG/c0kTKN4uTllvDbfS+ayF7R1D9nnYqaJaHlSHIftEOtg8be1aw0iUxJe?=
 =?us-ascii?Q?AQ+boNOPdCZCChWNWGvs5jtfAUnroIu7P7KtMGyYrnWqxDFQEcQqpFGNZ481?=
 =?us-ascii?Q?vNEjX3Y/IoVQqVMsPO5oyD2z6SqTeD26tXtKD0uyHJtb/A14bIL7Lsk/SM+U?=
 =?us-ascii?Q?AFKKosCdfMq7uZGbUvgO+aoqqEISnz5JW381O/pImTk0t3TtgkpFf8JSU1N1?=
 =?us-ascii?Q?1DpQmwZV3ive3uJLYxRLNkWD5SOqHE83gWYYHiiG6MxMK8KnRUXA+qFMlxH3?=
 =?us-ascii?Q?Q7v5rizxqa+pV6nLgv5rgY9NAQMxoSQAgAXyx3aY10QcinFSLIrbMZqSfwJB?=
 =?us-ascii?Q?9vfo6yWzfkw+sZeNPtWbXQjJNipIOHRtpkvcMyfRFoiRRJbg/sfuue+I1lob?=
 =?us-ascii?Q?bR97xLLS+IlBt005LOwM3YKAIfOSxzpFssgWTHGinagkpgDFXAQ8gY8SqiN3?=
 =?us-ascii?Q?dOjfGC24ukUsiAZgeIoy2tNNlgJnRXmgLz1mIPkO3l25/+qHY9dODqzluivc?=
 =?us-ascii?Q?bzNbWbZxHAe+1kBq2fNPgAoq37fn0v08/Cbc4Qq2PbumZjUxlXfdmzJHRmt3?=
 =?us-ascii?Q?kv/nCarsfVwZso4U+Q08x/NzZePMxYNu2lFbQGWenSJErWXN6IMssIx4va3B?=
 =?us-ascii?Q?6z635v0ObKUjDjWd8iJlebpvYVs7rVjI+Z6nQ5OnZwQigmps5dlpHl+rY1rW?=
 =?us-ascii?Q?HZcw/xlmeVs4ucYsDT85MNuTW+GuBTkqWv4j6TBUOZPrEs8in0lA6ghsfRCG?=
 =?us-ascii?Q?AZtKOmFur+9zNeQnOvpxCJPYJ6bD5htwQQ52kRRAccznRBeCwuyxF121ECW0?=
 =?us-ascii?Q?pLAa0hnESvyquje6wH9XfLTzSwjZJa4MP4gAVzIb1kwsLgWyfzT4r1Wqsj2m?=
 =?us-ascii?Q?F4m3yRBWs/mrPu4oeeftIHs9twuSBZ+hhMHt6fCo1sVEcvVXMgenDgAnkfzU?=
 =?us-ascii?Q?01tpJXUKp+bXFxeum0qIPV9x/AwvT1Sxhzidxb1bh27rAp1JCBP3g6VUlbGY?=
 =?us-ascii?Q?eRepAMIE2e5YTVvGfeIqCG83cLptpKLZ/6f2jGFgO0boPlcvFDrKjTCtpndK?=
 =?us-ascii?Q?1kdP0nwC9VPUsPoWC1cne7+xYQlEXuau9/iX4A7lwp7E+DMPtshMUhOK4sbw?=
 =?us-ascii?Q?ZrWg2/7fiXuJ0/li6/1xGSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCpIfxR/qrSSs4iwF2+Kbazgw8eclKhb7kFLbdSYko5pK3h2b8JmEVpurO1k?=
 =?us-ascii?Q?jBaCQFdhqV2tDjBtGTCYkkYD4QOYyf71nbc6/glrlF6zPHAEfh3aLakrIqXo?=
 =?us-ascii?Q?XHNaks20ppS2MsL80cL3MThW/tqI7iV6tMWeSvIS3N2yBwi+yBPhndEf24TG?=
 =?us-ascii?Q?Tlz62JFkRoyTdd4KPk9nlaBPYbswSmlCTtWRFHKBhAyaO0tmd9P+CkKWHZYg?=
 =?us-ascii?Q?8GJ17aUomwAAQDjQxfP+rAyZ7B+0ht8IXuXBmE3co6I6Lh9KOWSXrrmFugCK?=
 =?us-ascii?Q?4yn4xbvcN0/Abdp7mW2o6WBenNKNoQPoch6a1KrdMWTfzhaXId8CauvSnYgq?=
 =?us-ascii?Q?clPXAgIaN7OBIvLZL7xumkIiCA+YBn6YYrTeeX38HImesMjTk7oaXgulZCiG?=
 =?us-ascii?Q?QRYpyn0pii0TyGVb2cJ3oifoX4iM5LF2KNep+7WJX1MPVRt9CFos5Y9RCZFm?=
 =?us-ascii?Q?r/YOaBGTwqzdludsVDxEFpKa9xHQo9htvNLOnFlQ+eulQOAXlyb5O+C72xh9?=
 =?us-ascii?Q?VZfSj+te4Kh9TSOStYEsSpByhKgahHhzMRtIr54ibEiCR+6KNZ2Ll31qDRno?=
 =?us-ascii?Q?0mT8U22hbNbiqpPH54aesnD2vFsvt/d2Dr2EdTdj+Ot88JTV1+r27sb9A5pE?=
 =?us-ascii?Q?nHwuCvQleMR/BTBEI+POdXbxIHn23gMXlAc0DZXbUsB2IlYkVHRiJ5I+gDB5?=
 =?us-ascii?Q?sqksHFLPmi4UYNuJdlh8mrAYd1k7p3sr8KN50vQdnM1yBFTGWb8xnfceGVqA?=
 =?us-ascii?Q?uSlM15ml2RwpBXHuN6oQcr3sbwWmVv9b6/JyP6QRCIx2kEUE5oqSlYWurlLq?=
 =?us-ascii?Q?2l7jlYVtG8njtY9dNwXj3KiJ46jGmpxIiebLSDVxLbgOleyQNJkAxVNEnWWQ?=
 =?us-ascii?Q?J7Hc0Tqc0CWbfHSECU8TzhfU2tndT2L0N4AJw1LBN2ANyzdcLAnVL7fEahfv?=
 =?us-ascii?Q?ytL2yHJpuvjmm2DtDA4/GgfukTg6EUSWwCgbAXSm5y91Cw3mu7ydTkcb+hWV?=
 =?us-ascii?Q?4+M2L7LZC8+vDIB70lox2Z+udNlRcuRb29cF+2wcPND13Dqflnh8O1i7aPyh?=
 =?us-ascii?Q?g+9nebw9bR+2MmTSutI7bRhs+OMmSQN7BLIdjE2leo9fRV8nNaKiPyBGqXPN?=
 =?us-ascii?Q?/9Euohet5XXMbZWKMISelsh6XW15vN23rEB+v9h0x0ZzRrxLSX+wYFwY40lg?=
 =?us-ascii?Q?b+ZqmsSx5nbKv84+s1ID49uGc3B+ulp1A2QZSNGJZFB4yrRSQmDjTQ2h/Wvk?=
 =?us-ascii?Q?A+zCa+LFqVlefdy2pTtpjxfLDOv8NFx3/FjHpqUnn9w+lFuv7Zd2mtRl4B84?=
 =?us-ascii?Q?miTvoY7kUdFaqho7+Q1QA4sGZYmsk75R8H8b0eiwHIiPpC1Bq2k555xnCy7X?=
 =?us-ascii?Q?TKjNzKGjceSPEmDMT6Eq6LbeERgdBC9a9ekUx/yqhf8Ul+zsYrGOpk+0K5H9?=
 =?us-ascii?Q?e2p0xiv3RGYprWMcvE3K5OojkwA+dnyi5np9bvDNUueeOKG0jxqMnj80qE/z?=
 =?us-ascii?Q?qFWohZH1YSB+s3LsBCw1YvVjhs+/xNsxmDCeA5JgvXKJA8PZwHaxwZ50HDn5?=
 =?us-ascii?Q?SihoMFn9MQrHDLRHA4ymBuSrqv7eU1hYbtJlOZjWo3HZX7m0JLs408xh+TN9?=
 =?us-ascii?Q?9EgZHf9ludov7NaOOK6fihgA7bRkb6xeYl+l8rZNuB/b2tzKUip2urf1sC63?=
 =?us-ascii?Q?6OlShjhU5G6Wa9p1jp8S/3mNwmPuWJTR7ketThLEJPUvrS/c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0564dc83-bdf0-489d-b2bb-08de60186d67
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:58:37.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66X/9kpyKnkg962FeLAkYuhnr0KRKVk6mGUKqKf+N4XdYbSYR6U3WL4LspxuPt571xhBr+NuxCUfFXLZYo9eFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8627-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8BDD3BC525
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:47PM +0530, Sai Sree Kartheek Adivi wrote:
> Relocate udma utility functions from k3-udma.c to k3-udma-common.c file.
>
> The implementation of these functions is largely shared between K3 UDMA
> and K3 UDMA v2. This refactor improves code reuse and maintainability
> across multiple variants.
>
> No functional changes intended.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/k3-udma-common.c | 549 ++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.c        | 531 ------------------------------
>  drivers/dma/ti/k3-udma.h        |  28 ++
>  3 files changed, 577 insertions(+), 531 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> index 4dcf986f84d87..472eedc4663a9 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -4,6 +4,7 @@
>   *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>   */
>
> +#include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
> @@ -46,6 +47,28 @@ struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
>  }
>  EXPORT_SYMBOL_GPL(udma_udma_desc_from_paddr);
>
> +void udma_start_desc(struct udma_chan *uc)
> +{
> +	struct udma_chan_config *ucc = &uc->config;
> +
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
> +	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
> +		int i;
> +
> +		/*
> +		 * UDMA only: Push all descriptors to ring for packet mode
> +		 * cyclic or RX
> +		 * PKTDMA supports pre-linked descriptor and cyclic is not
> +		 * supported
> +		 */
> +		for (i = 0; i < uc->desc->sglen; i++)
> +			udma_push_to_ring(uc, i);
> +	} else {
> +		udma_push_to_ring(uc, 0);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(udma_start_desc);
> +

Not sure if naming pollution in future. suggest use "ti_udma". You can
rename after these relocation patches.

Frank

>  void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
>  {
>  	if (uc->use_dma_pool) {
> @@ -1342,5 +1365,531 @@ void udma_reset_rings(struct udma_chan *uc)
>  }
>  EXPORT_SYMBOL_GPL(udma_reset_rings);
>
> +u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < tpl_map->levels; i++) {
> +		if (chan_id >= tpl_map->start_idx[i])
> +			return i;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(udma_get_chan_tpl_index);
> +
> +void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
> +{
> +	struct device *chan_dev = &chan->dev->device;
> +
> +	if (asel == 0) {
> +		/* No special handling for the channel */
> +		chan->dev->chan_dma_dev = false;
> +
> +		chan_dev->dma_coherent = false;
> +		chan_dev->dma_parms = NULL;
> +	} else if (asel == 14 || asel == 15) {
> +		chan->dev->chan_dma_dev = true;
> +
> +		chan_dev->dma_coherent = true;
> +		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
> +		chan_dev->dma_parms = chan_dev->parent->dma_parms;
> +	} else {
> +		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
> +
> +		chan_dev->dma_coherent = false;
> +		chan_dev->dma_parms = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(k3_configure_chan_coherency);
> +
> +void udma_reset_uchan(struct udma_chan *uc)
> +{
> +	memset(&uc->config, 0, sizeof(uc->config));
> +	uc->config.remote_thread_id = -1;
> +	uc->config.mapped_channel_id = -1;
> +	uc->config.default_flow_id = -1;
> +	uc->state = UDMA_CHAN_IS_IDLE;
> +}
> +EXPORT_SYMBOL_GPL(udma_reset_uchan);
> +
> +void udma_dump_chan_stdata(struct udma_chan *uc)
> +{
> +	struct device *dev = uc->ud->dev;
> +	u32 offset;
> +	int i;
> +
> +	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
> +		dev_dbg(dev, "TCHAN State data:\n");
> +		for (i = 0; i < 32; i++) {
> +			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
> +			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
> +				udma_tchanrt_read(uc, offset));
> +		}
> +	}
> +
> +	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
> +		dev_dbg(dev, "RCHAN State data:\n");
> +		for (i = 0; i < 32; i++) {
> +			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
> +			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
> +				udma_rchanrt_read(uc, offset));
> +		}
> +	}
> +}
> +
> +bool udma_is_chan_running(struct udma_chan *uc)
> +{
> +	u32 trt_ctl = 0;
> +	u32 rrt_ctl = 0;
> +
> +	if (uc->tchan)
> +		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> +	if (uc->rchan)
> +		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> +
> +	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(udma_is_chan_running);
> +
> +bool udma_chan_needs_reconfiguration(struct udma_chan *uc)
> +{
> +	/* Only PDMAs have staticTR */
> +	if (uc->config.ep_type == PSIL_EP_NATIVE)
> +		return false;
> +
> +	/* Check if the staticTR configuration has changed for TX */
> +	if (memcmp(&uc->static_tr, &uc->desc->static_tr, sizeof(uc->static_tr)))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(udma_chan_needs_reconfiguration);
> +
> +void udma_cyclic_packet_elapsed(struct udma_chan *uc)
> +{
> +	struct udma_desc *d = uc->desc;
> +	struct cppi5_host_desc_t *h_desc;
> +
> +	h_desc = d->hwdesc[d->desc_idx].cppi5_desc_vaddr;
> +	cppi5_hdesc_reset_to_original(h_desc);
> +	udma_push_to_ring(uc, d->desc_idx);
> +	d->desc_idx = (d->desc_idx + 1) % d->sglen;
> +}
> +EXPORT_SYMBOL_GPL(udma_cyclic_packet_elapsed);
> +
> +void udma_check_tx_completion(struct work_struct *work)
> +{
> +	struct udma_chan *uc = container_of(work, typeof(*uc),
> +					    tx_drain.work.work);
> +	bool desc_done = true;
> +	u32 residue_diff;
> +	ktime_t time_diff;
> +	unsigned long delay;
> +	unsigned long flags;
> +
> +	while (1) {
> +		spin_lock_irqsave(&uc->vc.lock, flags);
> +
> +		if (uc->desc) {
> +			/* Get previous residue and time stamp */
> +			residue_diff = uc->tx_drain.residue;
> +			time_diff = uc->tx_drain.tstamp;
> +			/*
> +			 * Get current residue and time stamp or see if
> +			 * transfer is complete
> +			 */
> +			desc_done = udma_is_desc_really_done(uc, uc->desc);
> +		}
> +
> +		if (!desc_done) {
> +			/*
> +			 * Find the time delta and residue delta w.r.t
> +			 * previous poll
> +			 */
> +			time_diff = ktime_sub(uc->tx_drain.tstamp,
> +					      time_diff) + 1;
> +			residue_diff -= uc->tx_drain.residue;
> +			if (residue_diff) {
> +				/*
> +				 * Try to guess when we should check
> +				 * next time by calculating rate at
> +				 * which data is being drained at the
> +				 * peer device
> +				 */
> +				delay = (time_diff / residue_diff) *
> +					uc->tx_drain.residue;
> +			} else {
> +				/* No progress, check again in 1 second  */
> +				schedule_delayed_work(&uc->tx_drain.work, HZ);
> +				break;
> +			}
> +
> +			spin_unlock_irqrestore(&uc->vc.lock, flags);
> +
> +			usleep_range(ktime_to_us(delay),
> +				     ktime_to_us(delay) + 10);
> +			continue;
> +		}
> +
> +		if (uc->desc) {
> +			struct udma_desc *d = uc->desc;
> +
> +			uc->ud->decrement_byte_counters(uc, d->residue);
> +			uc->ud->start(uc);
> +			vchan_cookie_complete(&d->vd);
> +			break;
> +		}
> +
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&uc->vc.lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(udma_check_tx_completion);
> +
> +int udma_slave_config(struct dma_chan *chan,
> +		      struct dma_slave_config *cfg)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +
> +	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(udma_slave_config);
> +
> +void udma_issue_pending(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uc->vc.lock, flags);
> +
> +	/* If we have something pending and no active descriptor, then */
> +	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
> +		/*
> +		 * start a descriptor if the channel is NOT [marked as
> +		 * terminating _and_ it is still running (teardown has not
> +		 * completed yet)].
> +		 */
> +		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
> +		      udma_is_chan_running(uc)))
> +			uc->ud->start(uc);
> +	}
> +
> +	spin_unlock_irqrestore(&uc->vc.lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(udma_issue_pending);
> +
> +int udma_terminate_all(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&uc->vc.lock, flags);
> +
> +	if (udma_is_chan_running(uc))
> +		uc->ud->stop(uc);
> +
> +	if (uc->desc) {
> +		uc->terminated_desc = uc->desc;
> +		uc->desc = NULL;
> +		uc->terminated_desc->terminated = true;
> +		cancel_delayed_work(&uc->tx_drain.work);
> +	}
> +
> +	uc->paused = false;
> +
> +	vchan_get_all_descriptors(&uc->vc, &head);
> +	spin_unlock_irqrestore(&uc->vc.lock, flags);
> +	vchan_dma_desc_free_list(&uc->vc, &head);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(udma_terminate_all);
> +
> +void udma_synchronize(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	unsigned long timeout = msecs_to_jiffies(1000);
> +
> +	vchan_synchronize(&uc->vc);
> +
> +	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
> +		timeout = wait_for_completion_timeout(&uc->teardown_completed,
> +						      timeout);
> +		if (!timeout) {
> +			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
> +				 uc->id);
> +			udma_dump_chan_stdata(uc);
> +			uc->ud->reset_chan(uc, true);
> +		}
> +	}
> +
> +	uc->ud->reset_chan(uc, false);
> +	if (udma_is_chan_running(uc))
> +		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
> +
> +	cancel_delayed_work_sync(&uc->tx_drain.work);
> +	udma_reset_rings(uc);
> +}
> +EXPORT_SYMBOL_GPL(udma_synchronize);
> +
> +/*
> + * This tasklet handles the completion of a DMA descriptor by
> + * calling its callback and freeing it.
> + */
> +void udma_vchan_complete(struct tasklet_struct *t)
> +{
> +	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
> +	struct virt_dma_desc *vd, *_vd;
> +	struct dmaengine_desc_callback cb;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irq(&vc->lock);
> +	list_splice_tail_init(&vc->desc_completed, &head);
> +	vd = vc->cyclic;
> +	if (vd) {
> +		vc->cyclic = NULL;
> +		dmaengine_desc_get_callback(&vd->tx, &cb);
> +	} else {
> +		memset(&cb, 0, sizeof(cb));
> +	}
> +	spin_unlock_irq(&vc->lock);
> +
> +	udma_desc_pre_callback(vc, vd, NULL);
> +	dmaengine_desc_callback_invoke(&cb, NULL);
> +
> +	list_for_each_entry_safe(vd, _vd, &head, node) {
> +		struct dmaengine_result result;
> +
> +		dmaengine_desc_get_callback(&vd->tx, &cb);
> +
> +		list_del(&vd->node);
> +
> +		udma_desc_pre_callback(vc, vd, &result);
> +		dmaengine_desc_callback_invoke(&cb, &result);
> +
> +		vchan_vdesc_fini(vd);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(udma_vchan_complete);
> +
> +void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
> +			       struct ti_sci_resource_desc *rm_desc,
> +			       char *name)
> +{
> +	bitmap_clear(map, rm_desc->start, rm_desc->num);
> +	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
> +	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
> +		rm_desc->start, rm_desc->num, rm_desc->start_sec,
> +		rm_desc->num_sec);
> +}
> +EXPORT_SYMBOL_GPL(udma_mark_resource_ranges);
> +
> +int udma_setup_rx_flush(struct udma_dev *ud)
> +{
> +	struct udma_rx_flush *rx_flush = &ud->rx_flush;
> +	struct cppi5_desc_hdr_t *tr_desc;
> +	struct cppi5_tr_type1_t *tr_req;
> +	struct cppi5_host_desc_t *desc;
> +	struct device *dev = ud->dev;
> +	struct udma_hwdesc *hwdesc;
> +	size_t tr_size;
> +
> +	/* Allocate 1K buffer for discarded data on RX channel teardown */
> +	rx_flush->buffer_size = SZ_1K;
> +	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
> +					      GFP_KERNEL);
> +	if (!rx_flush->buffer_vaddr)
> +		return -ENOMEM;
> +
> +	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
> +						rx_flush->buffer_size,
> +						DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
> +		return -ENOMEM;
> +
> +	/* Set up descriptor to be used for TR mode */
> +	hwdesc = &rx_flush->hwdescs[0];
> +	tr_size = sizeof(struct cppi5_tr_type1_t);
> +	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
> +	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
> +					ud->desc_align);
> +
> +	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
> +						GFP_KERNEL);
> +	if (!hwdesc->cppi5_desc_vaddr)
> +		return -ENOMEM;
> +
> +	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
> +						  hwdesc->cppi5_desc_size,
> +						  DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
> +		return -ENOMEM;
> +
> +	/* Start of the TR req records */
> +	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
> +	/* Start address of the TR response array */
> +	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
> +
> +	tr_desc = hwdesc->cppi5_desc_vaddr;
> +	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
> +	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> +	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
> +
> +	tr_req = hwdesc->tr_req_base;
> +	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
> +		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
> +
> +	tr_req->addr = rx_flush->buffer_paddr;
> +	tr_req->icnt0 = rx_flush->buffer_size;
> +	tr_req->icnt1 = 1;
> +
> +	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
> +				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
> +
> +	/* Set up descriptor to be used for packet mode */
> +	hwdesc = &rx_flush->hwdescs[1];
> +	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
> +					CPPI5_INFO0_HDESC_EPIB_SIZE +
> +					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
> +					ud->desc_align);
> +
> +	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
> +						GFP_KERNEL);
> +	if (!hwdesc->cppi5_desc_vaddr)
> +		return -ENOMEM;
> +
> +	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
> +						  hwdesc->cppi5_desc_size,
> +						  DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
> +		return -ENOMEM;
> +
> +	desc = hwdesc->cppi5_desc_vaddr;
> +	cppi5_hdesc_init(desc, 0, 0);
> +	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> +	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
> +
> +	cppi5_hdesc_attach_buf(desc,
> +			       rx_flush->buffer_paddr, rx_flush->buffer_size,
> +			       rx_flush->buffer_paddr, rx_flush->buffer_size);
> +
> +	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
> +				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(udma_setup_rx_flush);
> +
> +#ifdef CONFIG_DEBUG_FS
> +void udma_dbg_summary_show_chan(struct seq_file *s,
> +				struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	struct udma_chan_config *ucc = &uc->config;
> +
> +	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
> +		   chan->dbg_client_name ?: "in-use");
> +	if (ucc->tr_trigger_type)
> +		seq_puts(s, " (triggered, ");
> +	else
> +		seq_printf(s, " (%s, ",
> +			   dmaengine_get_direction_text(uc->config.dir));
> +
> +	switch (uc->config.dir) {
> +	case DMA_MEM_TO_MEM:
> +		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> +			seq_printf(s, "bchan%d)\n", uc->bchan->id);
> +			return;
> +		}
> +
> +		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
> +			   ucc->src_thread, ucc->dst_thread);
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
> +			   ucc->src_thread, ucc->dst_thread);
> +		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
> +			seq_printf(s, "rflow%d, ", uc->rflow->id);
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
> +			   ucc->src_thread, ucc->dst_thread);
> +		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
> +			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
> +		break;
> +	default:
> +		seq_puts(s, ")\n");
> +		return;
> +	}
> +
> +	if (ucc->ep_type == PSIL_EP_NATIVE) {
> +		seq_puts(s, "PSI-L Native");
> +		if (ucc->metadata_size) {
> +			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
> +			if (ucc->psd_size)
> +				seq_printf(s, " PSDsize:%u", ucc->psd_size);
> +			seq_puts(s, " ]");
> +		}
> +	} else {
> +		seq_puts(s, "PDMA");
> +		if (ucc->enable_acc32 || ucc->enable_burst)
> +			seq_printf(s, "[%s%s ]",
> +				   ucc->enable_acc32 ? " ACC32" : "",
> +				   ucc->enable_burst ? " BURST" : "");
> +	}
> +
> +	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
> +}
> +
> +void udma_dbg_summary_show(struct seq_file *s,
> +			   struct dma_device *dma_dev)
> +{
> +	struct dma_chan *chan;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		if (chan->client_count)
> +			udma_dbg_summary_show_chan(s, chan);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(udma_dbg_summary_show);
> +#endif /* CONFIG_DEBUG_FS */
> +
> +enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
> +{
> +	const struct udma_match_data *match_data = ud->match_data;
> +	u8 tpl;
> +
> +	if (!match_data->enable_memcpy_support)
> +		return DMAENGINE_ALIGN_8_BYTES;
> +
> +	/* Get the highest TPL level the device supports for memcpy */
> +	if (ud->bchan_cnt)
> +		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
> +	else if (ud->tchan_cnt)
> +		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
> +	else
> +		return DMAENGINE_ALIGN_8_BYTES;
> +
> +	switch (match_data->burst_size[tpl]) {
> +	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
> +		return DMAENGINE_ALIGN_256_BYTES;
> +	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
> +		return DMAENGINE_ALIGN_128_BYTES;
> +	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
> +	fallthrough;
> +	default:
> +		return DMAENGINE_ALIGN_64_BYTES;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(udma_get_copy_align);
> +
>  MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 397e890283eaa..e86c811a15eb9 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -61,92 +61,6 @@ int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
>  						src_thread, dst_thread);
>  }
>
> -static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
> -{
> -	struct device *chan_dev = &chan->dev->device;
> -
> -	if (asel == 0) {
> -		/* No special handling for the channel */
> -		chan->dev->chan_dma_dev = false;
> -
> -		chan_dev->dma_coherent = false;
> -		chan_dev->dma_parms = NULL;
> -	} else if (asel == 14 || asel == 15) {
> -		chan->dev->chan_dma_dev = true;
> -
> -		chan_dev->dma_coherent = true;
> -		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
> -		chan_dev->dma_parms = chan_dev->parent->dma_parms;
> -	} else {
> -		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
> -
> -		chan_dev->dma_coherent = false;
> -		chan_dev->dma_parms = NULL;
> -	}
> -}
> -
> -static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
> -{
> -	int i;
> -
> -	for (i = 0; i < tpl_map->levels; i++) {
> -		if (chan_id >= tpl_map->start_idx[i])
> -			return i;
> -	}
> -
> -	return 0;
> -}
> -
> -static void udma_reset_uchan(struct udma_chan *uc)
> -{
> -	memset(&uc->config, 0, sizeof(uc->config));
> -	uc->config.remote_thread_id = -1;
> -	uc->config.mapped_channel_id = -1;
> -	uc->config.default_flow_id = -1;
> -	uc->state = UDMA_CHAN_IS_IDLE;
> -}
> -
> -static void udma_dump_chan_stdata(struct udma_chan *uc)
> -{
> -	struct device *dev = uc->ud->dev;
> -	u32 offset;
> -	int i;
> -
> -	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
> -		dev_dbg(dev, "TCHAN State data:\n");
> -		for (i = 0; i < 32; i++) {
> -			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
> -			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
> -				udma_tchanrt_read(uc, offset));
> -		}
> -	}
> -
> -	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
> -		dev_dbg(dev, "RCHAN State data:\n");
> -		for (i = 0; i < 32; i++) {
> -			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
> -			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
> -				udma_rchanrt_read(uc, offset));
> -		}
> -	}
> -}
> -
> -static bool udma_is_chan_running(struct udma_chan *uc)
> -{
> -	u32 trt_ctl = 0;
> -	u32 rrt_ctl = 0;
> -
> -	if (uc->tchan)
> -		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> -	if (uc->rchan)
> -		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> -
> -	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
> -		return true;
> -
> -	return false;
> -}
> -
>  static bool udma_is_chan_paused(struct udma_chan *uc)
>  {
>  	u32 val, pause_mask;
> @@ -275,40 +189,6 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
>  	return 0;
>  }
>
> -static void udma_start_desc(struct udma_chan *uc)
> -{
> -	struct udma_chan_config *ucc = &uc->config;
> -
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
> -	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
> -		int i;
> -
> -		/*
> -		 * UDMA only: Push all descriptors to ring for packet mode
> -		 * cyclic or RX
> -		 * PKTDMA supports pre-linked descriptor and cyclic is not
> -		 * supported
> -		 */
> -		for (i = 0; i < uc->desc->sglen; i++)
> -			udma_push_to_ring(uc, i);
> -	} else {
> -		udma_push_to_ring(uc, 0);
> -	}
> -}
> -
> -static bool udma_chan_needs_reconfiguration(struct udma_chan *uc)
> -{
> -	/* Only PDMAs have staticTR */
> -	if (uc->config.ep_type == PSIL_EP_NATIVE)
> -		return false;
> -
> -	/* Check if the staticTR configuration has changed for TX */
> -	if (memcmp(&uc->static_tr, &uc->desc->static_tr, sizeof(uc->static_tr)))
> -		return true;
> -
> -	return false;
> -}
> -
>  static int udma_start(struct udma_chan *uc)
>  {
>  	struct virt_dma_desc *vd = vchan_next_desc(&uc->vc);
> @@ -453,86 +333,6 @@ static int udma_stop(struct udma_chan *uc)
>  	return 0;
>  }
>
> -static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
> -{
> -	struct udma_desc *d = uc->desc;
> -	struct cppi5_host_desc_t *h_desc;
> -
> -	h_desc = d->hwdesc[d->desc_idx].cppi5_desc_vaddr;
> -	cppi5_hdesc_reset_to_original(h_desc);
> -	udma_push_to_ring(uc, d->desc_idx);
> -	d->desc_idx = (d->desc_idx + 1) % d->sglen;
> -}
> -
> -static void udma_check_tx_completion(struct work_struct *work)
> -{
> -	struct udma_chan *uc = container_of(work, typeof(*uc),
> -					    tx_drain.work.work);
> -	bool desc_done = true;
> -	u32 residue_diff;
> -	ktime_t time_diff;
> -	unsigned long delay;
> -	unsigned long flags;
> -
> -	while (1) {
> -		spin_lock_irqsave(&uc->vc.lock, flags);
> -
> -		if (uc->desc) {
> -			/* Get previous residue and time stamp */
> -			residue_diff = uc->tx_drain.residue;
> -			time_diff = uc->tx_drain.tstamp;
> -			/*
> -			 * Get current residue and time stamp or see if
> -			 * transfer is complete
> -			 */
> -			desc_done = udma_is_desc_really_done(uc, uc->desc);
> -		}
> -
> -		if (!desc_done) {
> -			/*
> -			 * Find the time delta and residue delta w.r.t
> -			 * previous poll
> -			 */
> -			time_diff = ktime_sub(uc->tx_drain.tstamp,
> -					      time_diff) + 1;
> -			residue_diff -= uc->tx_drain.residue;
> -			if (residue_diff) {
> -				/*
> -				 * Try to guess when we should check
> -				 * next time by calculating rate at
> -				 * which data is being drained at the
> -				 * peer device
> -				 */
> -				delay = (time_diff / residue_diff) *
> -					uc->tx_drain.residue;
> -			} else {
> -				/* No progress, check again in 1 second  */
> -				schedule_delayed_work(&uc->tx_drain.work, HZ);
> -				break;
> -			}
> -
> -			spin_unlock_irqrestore(&uc->vc.lock, flags);
> -
> -			usleep_range(ktime_to_us(delay),
> -				     ktime_to_us(delay) + 10);
> -			continue;
> -		}
> -
> -		if (uc->desc) {
> -			struct udma_desc *d = uc->desc;
> -
> -			uc->ud->decrement_byte_counters(uc, d->residue);
> -			uc->ud->start(uc);
> -			vchan_cookie_complete(&d->vd);
> -			break;
> -		}
> -
> -		break;
> -	}
> -
> -	spin_unlock_irqrestore(&uc->vc.lock, flags);
> -}
> -
>  static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  {
>  	struct udma_chan *uc = data;
> @@ -2097,38 +1897,6 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
>  	return ret;
>  }
>
> -static int udma_slave_config(struct dma_chan *chan,
> -			     struct dma_slave_config *cfg)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -
> -	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
> -
> -	return 0;
> -}
> -
> -static void udma_issue_pending(struct dma_chan *chan)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&uc->vc.lock, flags);
> -
> -	/* If we have something pending and no active descriptor, then */
> -	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
> -		/*
> -		 * start a descriptor if the channel is NOT [marked as
> -		 * terminating _and_ it is still running (teardown has not
> -		 * completed yet)].
> -		 */
> -		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
> -		      udma_is_chan_running(uc)))
> -			uc->ud->start(uc);
> -	}
> -
> -	spin_unlock_irqrestore(&uc->vc.lock, flags);
> -}
> -
>  static enum dma_status udma_tx_status(struct dma_chan *chan,
>  				      dma_cookie_t cookie,
>  				      struct dma_tx_state *txstate)
> @@ -2256,98 +2024,6 @@ static int udma_resume(struct dma_chan *chan)
>  	return 0;
>  }
>
> -static int udma_terminate_all(struct dma_chan *chan)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	unsigned long flags;
> -	LIST_HEAD(head);
> -
> -	spin_lock_irqsave(&uc->vc.lock, flags);
> -
> -	if (udma_is_chan_running(uc))
> -		uc->ud->stop(uc);
> -
> -	if (uc->desc) {
> -		uc->terminated_desc = uc->desc;
> -		uc->desc = NULL;
> -		uc->terminated_desc->terminated = true;
> -		cancel_delayed_work(&uc->tx_drain.work);
> -	}
> -
> -	uc->paused = false;
> -
> -	vchan_get_all_descriptors(&uc->vc, &head);
> -	spin_unlock_irqrestore(&uc->vc.lock, flags);
> -	vchan_dma_desc_free_list(&uc->vc, &head);
> -
> -	return 0;
> -}
> -
> -static void udma_synchronize(struct dma_chan *chan)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	unsigned long timeout = msecs_to_jiffies(1000);
> -
> -	vchan_synchronize(&uc->vc);
> -
> -	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
> -		timeout = wait_for_completion_timeout(&uc->teardown_completed,
> -						      timeout);
> -		if (!timeout) {
> -			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
> -				 uc->id);
> -			udma_dump_chan_stdata(uc);
> -			uc->ud->reset_chan(uc, true);
> -		}
> -	}
> -
> -	uc->ud->reset_chan(uc, false);
> -	if (udma_is_chan_running(uc))
> -		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
> -
> -	cancel_delayed_work_sync(&uc->tx_drain.work);
> -	udma_reset_rings(uc);
> -}
> -
> -/*
> - * This tasklet handles the completion of a DMA descriptor by
> - * calling its callback and freeing it.
> - */
> -static void udma_vchan_complete(struct tasklet_struct *t)
> -{
> -	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
> -	struct virt_dma_desc *vd, *_vd;
> -	struct dmaengine_desc_callback cb;
> -	LIST_HEAD(head);
> -
> -	spin_lock_irq(&vc->lock);
> -	list_splice_tail_init(&vc->desc_completed, &head);
> -	vd = vc->cyclic;
> -	if (vd) {
> -		vc->cyclic = NULL;
> -		dmaengine_desc_get_callback(&vd->tx, &cb);
> -	} else {
> -		memset(&cb, 0, sizeof(cb));
> -	}
> -	spin_unlock_irq(&vc->lock);
> -
> -	udma_desc_pre_callback(vc, vd, NULL);
> -	dmaengine_desc_callback_invoke(&cb, NULL);
> -
> -	list_for_each_entry_safe(vd, _vd, &head, node) {
> -		struct dmaengine_result result;
> -
> -		dmaengine_desc_get_callback(&vd->tx, &cb);
> -
> -		list_del(&vd->node);
> -
> -		udma_desc_pre_callback(vc, vd, &result);
> -		dmaengine_desc_callback_invoke(&cb, &result);
> -
> -		vchan_vdesc_fini(vd);
> -	}
> -}
> -
>  static void udma_free_chan_resources(struct dma_chan *chan)
>  {
>  	struct udma_chan *uc = to_udma_chan(chan);
> @@ -2822,17 +2498,6 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
>  	return 0;
>  }
>
> -static void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
> -				      struct ti_sci_resource_desc *rm_desc,
> -				      char *name)
> -{
> -	bitmap_clear(map, rm_desc->start, rm_desc->num);
> -	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
> -	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
> -		rm_desc->start, rm_desc->num, rm_desc->start_sec,
> -		rm_desc->num_sec);
> -}
> -
>  static const char * const range_names[] = {
>  	[RM_RANGE_BCHAN] = "ti,sci-rm-range-bchan",
>  	[RM_RANGE_TCHAN] = "ti,sci-rm-range-tchan",
> @@ -3463,202 +3128,6 @@ static int setup_resources(struct udma_dev *ud)
>  	return ch_count;
>  }
>
> -static int udma_setup_rx_flush(struct udma_dev *ud)
> -{
> -	struct udma_rx_flush *rx_flush = &ud->rx_flush;
> -	struct cppi5_desc_hdr_t *tr_desc;
> -	struct cppi5_tr_type1_t *tr_req;
> -	struct cppi5_host_desc_t *desc;
> -	struct device *dev = ud->dev;
> -	struct udma_hwdesc *hwdesc;
> -	size_t tr_size;
> -
> -	/* Allocate 1K buffer for discarded data on RX channel teardown */
> -	rx_flush->buffer_size = SZ_1K;
> -	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
> -					      GFP_KERNEL);
> -	if (!rx_flush->buffer_vaddr)
> -		return -ENOMEM;
> -
> -	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
> -						rx_flush->buffer_size,
> -						DMA_TO_DEVICE);
> -	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
> -		return -ENOMEM;
> -
> -	/* Set up descriptor to be used for TR mode */
> -	hwdesc = &rx_flush->hwdescs[0];
> -	tr_size = sizeof(struct cppi5_tr_type1_t);
> -	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
> -	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
> -					ud->desc_align);
> -
> -	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
> -						GFP_KERNEL);
> -	if (!hwdesc->cppi5_desc_vaddr)
> -		return -ENOMEM;
> -
> -	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
> -						  hwdesc->cppi5_desc_size,
> -						  DMA_TO_DEVICE);
> -	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
> -		return -ENOMEM;
> -
> -	/* Start of the TR req records */
> -	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
> -	/* Start address of the TR response array */
> -	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
> -
> -	tr_desc = hwdesc->cppi5_desc_vaddr;
> -	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
> -	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> -	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
> -
> -	tr_req = hwdesc->tr_req_base;
> -	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
> -		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
> -
> -	tr_req->addr = rx_flush->buffer_paddr;
> -	tr_req->icnt0 = rx_flush->buffer_size;
> -	tr_req->icnt1 = 1;
> -
> -	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
> -				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
> -
> -	/* Set up descriptor to be used for packet mode */
> -	hwdesc = &rx_flush->hwdescs[1];
> -	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
> -					CPPI5_INFO0_HDESC_EPIB_SIZE +
> -					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
> -					ud->desc_align);
> -
> -	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
> -						GFP_KERNEL);
> -	if (!hwdesc->cppi5_desc_vaddr)
> -		return -ENOMEM;
> -
> -	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
> -						  hwdesc->cppi5_desc_size,
> -						  DMA_TO_DEVICE);
> -	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
> -		return -ENOMEM;
> -
> -	desc = hwdesc->cppi5_desc_vaddr;
> -	cppi5_hdesc_init(desc, 0, 0);
> -	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> -	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
> -
> -	cppi5_hdesc_attach_buf(desc,
> -			       rx_flush->buffer_paddr, rx_flush->buffer_size,
> -			       rx_flush->buffer_paddr, rx_flush->buffer_size);
> -
> -	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
> -				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
> -	return 0;
> -}
> -
> -#ifdef CONFIG_DEBUG_FS
> -static void udma_dbg_summary_show_chan(struct seq_file *s,
> -				       struct dma_chan *chan)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	struct udma_chan_config *ucc = &uc->config;
> -
> -	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
> -		   chan->dbg_client_name ?: "in-use");
> -	if (ucc->tr_trigger_type)
> -		seq_puts(s, " (triggered, ");
> -	else
> -		seq_printf(s, " (%s, ",
> -			   dmaengine_get_direction_text(uc->config.dir));
> -
> -	switch (uc->config.dir) {
> -	case DMA_MEM_TO_MEM:
> -		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> -			seq_printf(s, "bchan%d)\n", uc->bchan->id);
> -			return;
> -		}
> -
> -		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
> -			   ucc->src_thread, ucc->dst_thread);
> -		break;
> -	case DMA_DEV_TO_MEM:
> -		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
> -			   ucc->src_thread, ucc->dst_thread);
> -		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
> -			seq_printf(s, "rflow%d, ", uc->rflow->id);
> -		break;
> -	case DMA_MEM_TO_DEV:
> -		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
> -			   ucc->src_thread, ucc->dst_thread);
> -		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
> -			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
> -		break;
> -	default:
> -		seq_printf(s, ")\n");
> -		return;
> -	}
> -
> -	if (ucc->ep_type == PSIL_EP_NATIVE) {
> -		seq_printf(s, "PSI-L Native");
> -		if (ucc->metadata_size) {
> -			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
> -			if (ucc->psd_size)
> -				seq_printf(s, " PSDsize:%u", ucc->psd_size);
> -			seq_printf(s, " ]");
> -		}
> -	} else {
> -		seq_printf(s, "PDMA");
> -		if (ucc->enable_acc32 || ucc->enable_burst)
> -			seq_printf(s, "[%s%s ]",
> -				   ucc->enable_acc32 ? " ACC32" : "",
> -				   ucc->enable_burst ? " BURST" : "");
> -	}
> -
> -	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
> -}
> -
> -static void udma_dbg_summary_show(struct seq_file *s,
> -				  struct dma_device *dma_dev)
> -{
> -	struct dma_chan *chan;
> -
> -	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> -		if (chan->client_count)
> -			udma_dbg_summary_show_chan(s, chan);
> -	}
> -}
> -#endif /* CONFIG_DEBUG_FS */
> -
> -static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
> -{
> -	const struct udma_match_data *match_data = ud->match_data;
> -	u8 tpl;
> -
> -	if (!match_data->enable_memcpy_support)
> -		return DMAENGINE_ALIGN_8_BYTES;
> -
> -	/* Get the highest TPL level the device supports for memcpy */
> -	if (ud->bchan_cnt)
> -		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
> -	else if (ud->tchan_cnt)
> -		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
> -	else
> -		return DMAENGINE_ALIGN_8_BYTES;
> -
> -	switch (match_data->burst_size[tpl]) {
> -	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
> -		return DMAENGINE_ALIGN_256_BYTES;
> -	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
> -		return DMAENGINE_ALIGN_128_BYTES;
> -	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
> -	fallthrough;
> -	default:
> -		return DMAENGINE_ALIGN_64_BYTES;
> -	}
> -}
> -
>  static int udma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *navss_node = pdev->dev.parent->of_node;
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 2f5fbea446fed..797e8b0c5b85e 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -625,6 +625,34 @@ void udma_reset_rings(struct udma_chan *uc);
>
>  int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
>  int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
> +void udma_start_desc(struct udma_chan *uc);
> +u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id);
> +void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel);
> +void udma_reset_uchan(struct udma_chan *uc);
> +void udma_dump_chan_stdata(struct udma_chan *uc);
> +bool udma_is_chan_running(struct udma_chan *uc);
> +
> +bool udma_chan_needs_reconfiguration(struct udma_chan *uc);
> +void udma_cyclic_packet_elapsed(struct udma_chan *uc);
> +void udma_check_tx_completion(struct work_struct *work);
> +int udma_slave_config(struct dma_chan *chan,
> +		      struct dma_slave_config *cfg);
> +void udma_issue_pending(struct dma_chan *chan);
> +int udma_terminate_all(struct dma_chan *chan);
> +void udma_synchronize(struct dma_chan *chan);
> +void udma_vchan_complete(struct tasklet_struct *t);
> +void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
> +			       struct ti_sci_resource_desc *rm_desc,
> +			       char *name);
> +int udma_setup_rx_flush(struct udma_dev *ud);
> +enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud);
> +
> +#ifdef CONFIG_DEBUG_FS
> +void udma_dbg_summary_show_chan(struct seq_file *s,
> +				struct dma_chan *chan);
> +void udma_dbg_summary_show(struct seq_file *s,
> +			   struct dma_device *dma_dev);
> +#endif /* CONFIG_DEBUG_FS */
>
>  /* Direct access to UDMA low lever resources for the glue layer */
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
> --
> 2.34.1
>

