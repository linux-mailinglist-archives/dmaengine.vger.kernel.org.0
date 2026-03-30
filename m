Return-Path: <dmaengine+bounces-9733-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJpfKLGcymmg+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9733-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:54:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC4335E378
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7248300515F
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520A372EC7;
	Mon, 30 Mar 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lUDYSCE9"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD02F6170;
	Mon, 30 Mar 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885633; cv=fail; b=rebeu6TQz+t+x+y152GDfJqlHIXrBm1dW/CVEZwvoF+E6k/VYneiGVH+2/3ULPF9TiQqQH9EekjB1U/Ju8YLsSASA7JIPNUoi4phjpCDvyJlDo/g5ZEwQkmtCloKIOyNLDn+YispKy8TdmaP6cYXBIKb/gUByENlSJai52XER3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885633; c=relaxed/simple;
	bh=pto7a2QCJlp4YQ0zb12xUEQ6PNAFiDYcUvdWKv5A6TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tr+81mfYUnDAiI3zTz6IkDuXFn8FluCWh6vxRFXc0yoHadk0JxsqV215Miwpb9DKAtqq0wKC1+H6QjqY/RIvCTQFVsH2YUDQKVfogReh63IlNQWml63RPJT+KPvnQ8jXAtUpbqI0qZl5m4wRIxXZguJWMUuvaV0R66JUOlLFoHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lUDYSCE9; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wrw/wtC4QgPPf0cXM0jcUE8hUjtYszZuZ7O5aFYbETpM7e1nrk/nERif3TJrqELkyGlYlBX+LbkdN85fmv6ukZJLxYTVET5SkXNEaHFBCW+14qxWyoLSUhOFypv4Qjr7yJlWP5PXMUiLn1xLGEtKoyJWjWwpMqyAU0XYx/U0RMAMm2kVNmn+Y2NPXpqTinluSWI9VGo6acZdR0S0Aeuz+hmxt4PWfRSFmqmuMBcv+VtmN/uUT8W3oIl8A18CKLxnsylENw90qZVQcjxvuBmyt0bUmEgf/TLWXAovyO+YiqAVtsxl8d8+E5rvwULyenLEHBJkX7N5Jnm9mYCj0bXGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu/cxAdOyPi5zZCG3TBGMCDpNbGuZO7erYwxGvjP6ag=;
 b=lGEHGptTfoNYu/bU7EjYUG2Ut57OfC7VOYZzoUpOtdMzqmbNVmQhj58iJAxVdIMvQKvfBWMlBccrUOYnUh4LK60pxfE49z3lc3wQh+w3CwfZ+GfLl/s3pbmDrngMNk4n/lVTfGoV/c7psOSnZQnAzRRD2rwXxfjCKWWTsy6GRc2aPFLyns+aw3pjPLgsBjMBpFs4mUJouHbpNlV5RYA5BesCUJdIi/lWnPUVZPaIYUvJjgwSpUHUg3a64ECdRmlGAFeNc/28wgb5WPGxY7LXf2UKNTmY/yveVoLfMpGBfw1yKUVBLeN6L0g1c4bb4uMkHLFWxv8vhiaERIGpwyq3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu/cxAdOyPi5zZCG3TBGMCDpNbGuZO7erYwxGvjP6ag=;
 b=lUDYSCE9o7FEv/jqrTALwbPMFtI0E8vqTIJthj8wi6B8jaGE9HuNfDyxS2FVAM/sb3+f8zli5KIqBF22UWWEJys7NZt/Tkg5BZeu11mnRat46hzUppFbBjXuCg62FSIhv7kEfvUTId6hidZx94prrdt5HTKPJNY9tOqBzE1UzMxIxQgBX+WrkjMagMYJsF0VKMcMu3hCyatWKbFaik7H/1Lrw93dqwieX8mZS3muUkuVH1Agsn1rk2FHgALnOqoo25qpoeJQ0/Jh8JA8m+mcRXBy5iuJT9YEzmp2ej/Hgzz1OHuai2KO6XKC6CWKqp9R4TkgeoI+UOCoCxBOUdMXdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9945.eurprd04.prod.outlook.com (2603:10a6:10:4d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Mon, 30 Mar
 2026 15:47:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:47:08 +0000
Date: Mon, 30 Mar 2026 11:46:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, git@amd.com,
	Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Abin Joseph <abin.joseph@amd.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/5] dmaengine: xilinx_dma: Fix MCDMA descriptor
 fields for MM2S vs S2MM
Message-ID: <acqa8jj9Q-0BUc85@lizhi-Precision-Tower-5810>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
 <20260313062533.421249-2-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313062533.421249-2-srinivas.neeli@amd.com>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9945:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a51125-8126-480c-91bd-08de8e7399bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	81z+xMVjPlyCN0sLz1gAnplijP8DwzVaW3CgRSx6C/uZTf7GuX+yHIhSE3SeRYv0R1c8CmjSTMmgkdck7n4J4NrLlZK+qEfy5NcaGJCn+fkhKK0AQDO0uUOcZIWSXA44c03VK2BNVMMC048buDoZ1xXV8IHd8c3v/drgmJBTcketUIWt2UGLHD7X5omiFbCQcpXDYyoW/5hwZmV8ELK80VwPVP3sIHLXmmw0VMbUfrnVb+F17A2sx0/+mue2ReavEGH0anhW+xYJTSLL+uk0GPfC9652Cdjps49JJZNKmbQzOvPhtQLSe9IEIb76SpsIZYJOT0Zv2JjaHHIZq2VHpnOX6Pkm6iN4xU9X1PsnJ4wLzL694dE0EqK4lJ7WItyD6eWbSVwKyWV5khd/qjKJYHEXST31vtNPHqN/jabZaMxoscOXsgt3V17Jc/kuZZ8epra3DMPOJLknkigvvV4mPZtRpiNWiL1AAsaNx/yYNBKU5xKyIyXKyr/ju93oSa6OXnq4aCzkh94mFAQSIKUNOb7wVSmJvU8Yzh+cNmsyfw8K43ubqsbIcp1aDWnK9REybVEwWbg6AE2+0FN0127RbLSn6bxaSzPYU4IMM3FfgivmL03W2oE3sSuXyMOhrEr0PTOncudtyIsy+QHJjT+JzBX4lqsBP+y+KoPheLEH/xuw67JlUqktTgKceYOmOGEY80XOnmhavWNKtfQ58Y1+xe9Ov5sZ92sRcTW6F5Nb4i6KrsNqygJRBtwTed2zmkfAuyvIG4H/nPcf0Ir0Z3Ia9PfzdiY32gKAK4q0wIjzAcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uwvo7u2tufD9CHKgQEj4m1qmdmUdWh3PtoHDDXnDo++LLHcfhEF75ERxsgvZ?=
 =?us-ascii?Q?errRWxzTpNDpsa/oc0ag3Soe/Y9HTtq2yaYx+I7jSYCbrunBi1fU/xtEtk45?=
 =?us-ascii?Q?cHe6nvbHpwCkU3jOJq46inMhOssq3PZR7C66RM/pe4piJ9GSodEMHo/cQBP6?=
 =?us-ascii?Q?UDhlpK+RayXJEJfCrCHNlyuNVCe2d5yf9qDezQgx4YFyPUcNtftDTQhSszaz?=
 =?us-ascii?Q?czMPeZl3YcqX6wYu+qa05B4N72GbBb1bdQ9FUHbbIDMrW1lvP14JYwfn4+mz?=
 =?us-ascii?Q?YTJVIalyJrY4Km7sWfQ0hm5yOAmq3oX1HaCIYFTkY+26Edg8mSO1SkM2jmib?=
 =?us-ascii?Q?F1M4lzioM1OYA6DsK0P6sawcuocUgYZ6h6HBTKfJXCdMsw2N4Wj9VUebK7X3?=
 =?us-ascii?Q?bHbBrPHZC4B0XzsXDkToWzwyd77fjAJWecg7yDyIQtuAmV9meD1wv32aQ19v?=
 =?us-ascii?Q?x7/07maAVlcWEoKKaZjCU0c9mpYQqd/tF1ldnmiWy4bE+IpLYK0mY7OryO+O?=
 =?us-ascii?Q?2orxBwOJS/StjVAT2sIFXe47Y4kp50geTFvNWTn0ANS0w/gJy73TWZ43AwqU?=
 =?us-ascii?Q?Mezo0hXmw/XQ6KJsHQTX+k8Tr7x4vYStJVv5MYXHOCNJLer+hPDAHSNRumNy?=
 =?us-ascii?Q?KpPeNtPFZh8+DzNjtAY+JmgqikKeBnvV177rbRVajbThkyrVeMW1QAiwlvbk?=
 =?us-ascii?Q?jKFZfXTJHbuet4B1yGxYItaCoolo65uIB2Tus68OY2bSwcTukv0NCBQMshSr?=
 =?us-ascii?Q?Xw0Lmu4mWzVTPBYnKElEqpwM5FJfxDEYACNsGasfyf8onIhiiZtTU1cPNzil?=
 =?us-ascii?Q?AtCaqqXUIJ6f81q+l8lqjPzNDAPXiNbqWaid4SZ0+D3oIDuJkv8fUx8ReNnF?=
 =?us-ascii?Q?KXLGcLLiN7th5zJBNfytskkUOCOBFCaR3EXxOsYkViiCRGkfdRYoQ9HJ9uTk?=
 =?us-ascii?Q?x22ztK8BKvSer6/cLEYTej7uVYT5gMmL3oIegl2o2wv5pz+oI7e4RxiZDkLU?=
 =?us-ascii?Q?B9dXK9leeSG9jJ4Dazt3bpQUyRbbwMQbp/XEHiL9ri6FV/D7f1+bCk775t/n?=
 =?us-ascii?Q?0Fq+snaNENxlfs6BjnZtnz8IzS8t2SF2O13UkBAZTMLwmE0yeiZ1U/C27DCE?=
 =?us-ascii?Q?FZyhNy9dDgzSyTVyJqZYtInxVl6J5wGrJSrSSaGgJvDufpSMrE4TsLrB7Fjm?=
 =?us-ascii?Q?TCTmjVfeq6kOSiPYVBH9BrQpSgJL0r1xym6TZUYYwQY62sLdhFAnE3YSEVGK?=
 =?us-ascii?Q?IxxCnW3WdJXxjnGtxtVzkj5jrdg/kg3hJyJkiLFLkvWgOvlbs+8QUMdo5j5t?=
 =?us-ascii?Q?rkBfKWBh+3zOFXc5z44VtD1X72TK0w+ICSeg8fVjD/E3sqw8WuJ2o2W3Ufmc?=
 =?us-ascii?Q?MBX2dA8IOcmPa7GYyYQpYm/gpj/3FAdu5P4UqzScUQc5hokIMI0aEqfCj3o+?=
 =?us-ascii?Q?gE/G39o16ztBwhXmQmijWKC2tjQwarlqFe8TJpVdKBeJWlCfFZdQzC+xkbBv?=
 =?us-ascii?Q?9Jnnz7e2R5J3pBxwVEdRc4310iwL7e599mB4k9plintgb7XakD86JIv5HAxy?=
 =?us-ascii?Q?kp+O4OMHIpVvI3T5EHQUGtbHsLg7L4DR2C1K5kiWSfAwWZA3x6R/4E5SlDTz?=
 =?us-ascii?Q?Qo8QjfnYh2UzxPiAyJlyI2cwIWc14/k4Q0cT8yQom2DujOzY9q7MG888Ps59?=
 =?us-ascii?Q?1TgNJznewiUXlx8a4B77ejUyUR4TwOxed9bG7E1KRBZWfU4CJPTHizivBqGj?=
 =?us-ascii?Q?Y/9HdOtcnQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a51125-8126-480c-91bd-08de8e7399bd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:47:08.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czMLODAAbdOrNXrYRK1fKe+vqqjPscZzis6VrnDc6whDSXXUtxlaNlkCc5CHyCCHmsjPOLk8xL09txQmg+jU7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9945
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9733-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 0EC4335E378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:55:29AM +0530, Srinivas Neeli wrote:
> The MCDMA BD format differs between MM2S and S2MM directions, but the

Can you use DMA_DEV_TO_MEM and DMA_MEM_TO_DEV instead of MM2S and S2MM?
or memory to slave, at least first place need extend term MM2S(memory to
slave).

> driver was using generic 'status' and 'sideband_status' fields for both.
> This could lead to incorrect residue calculations when the hardware
> updates direction-specific fields.

driver was using generic 'status' and 'sideband_status' fields for both,
which lead ... (use Affirmative Tone)

>
> Refactor the descriptor structure to use unions with direction-specific
> field names (mm2s_status/s2mm_status, etc.). This ensures the driver

Ensure .. (needn't this)

Frank
> accesses the correct hardware fields based on channel direction and
> matches the hardware documentation.
>
> Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index b53292e02448..4a83492f2435 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -275,8 +275,10 @@ struct xilinx_axidma_desc_hw {
>   * @buf_addr_msb: MSB of Buffer address @0x0C
>   * @rsvd: Reserved field @0x10
>   * @control: Control Information field @0x14
> - * @status: Status field @0x18
> - * @sideband_status: Status of sideband signals @0x1C
> + * @mm2s_ctrl_sideband: Sideband control info for mm2s @0x18
> + * @s2mm_status: Status field for s2mm @0x18
> + * @mm2s_status: Status field for mm2s @0x1C
> + * @s2mm_sideband_status: Sideband status for s2mm @0x1C
>   * @app: APP Fields @0x20 - 0x30
>   */
>  struct xilinx_aximcdma_desc_hw {
> @@ -286,8 +288,14 @@ struct xilinx_aximcdma_desc_hw {
>  	u32 buf_addr_msb;
>  	u32 rsvd;
>  	u32 control;
> -	u32 status;
> -	u32 sideband_status;
> +	union {
> +		u32 mm2s_ctrl_sideband;
> +		u32 s2mm_status;
> +	};
> +	union {
> +		u32 mm2s_status;
> +		u32 s2mm_sideband_status;
> +	};
>  	u32 app[XILINX_DMA_NUM_APP_WORDS];
>  } __aligned(64);
>
> @@ -1013,9 +1021,16 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>  					   struct xilinx_aximcdma_tx_segment,
>  					   node);
>  			aximcdma_hw = &aximcdma_seg->hw;
> -			residue +=
> -				(aximcdma_hw->control - aximcdma_hw->status) &
> -				chan->xdev->max_buffer_len;
> +			if (chan->direction == DMA_DEV_TO_MEM)
> +				residue +=
> +					(aximcdma_hw->control -
> +					 aximcdma_hw->s2mm_status) &
> +					chan->xdev->max_buffer_len;
> +			else
> +				residue +=
> +					(aximcdma_hw->control -
> +					 aximcdma_hw->mm2s_status) &
> +					chan->xdev->max_buffer_len;
>  		}
>  	}
>
> --
> 2.43.0
>

