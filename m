Return-Path: <dmaengine+bounces-10243-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BwUEgeU+2nccwMAu9opvQ
	(envelope-from <dmaengine+bounces-10243-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:18:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D94DFAA6
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0ED30063AB
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AB30DEAC;
	Wed,  6 May 2026 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BE5cYVdm"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B224A076;
	Wed,  6 May 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095108; cv=fail; b=HBmH4eAvvy/aIRfnxdKgHBPMnq4sfubgI9duIAZw3HaUZAyZTWiFzN7HSN1NT23g78DKK18IWDUcw0j6spdybKDy6uGLRBMxfUNh1G/9AWMJ0syxZTCauVQ9MeaDa096PqbS6FDysvW1QoN/+FfhwHsUbqpXVPinTtsWUfvg+bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095108; c=relaxed/simple;
	bh=d6U83iaTDTZnATLQ/C3ANMpiVe27Uq9DE6bBSF1aAUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NXV1lhYWY2xvaX2bm1l0ZfShR4/QnRK4qeB2AwKmxkCyC7ZGYbIIEcRZ28/BKJP64hM1joR6Pncv1COyWllMThK0FY+pUZErSSnoJnEYIjcucCedALluhYZwZMmadix/VdPyqyBTpdfLeDotTTQXI/EW1pxX2lainyTV0vKQviA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BE5cYVdm; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCFDhTDoUfVsLR4ppNrN7VpThyxMPJI1raX7NhfJ70eZJsTqx6ZS2iJ6xg1pUpx4sPXTpWT+evrqo2iPyXejIML3YeC8sG7BChPEmoS5iwfrz18nxogFNMBsCDkgX8oECdXFS5lzOz4xDbof/txWjVgZqM1M0qGfQxyHdp11ATLqfjRV39sKBaYWf7fxbuliK/RjHsbSkjYaQpOic+kFHcA9Jrq4ZajSv2UtBqcN1u2UTKSkkuhecLXgkRw7i2TLZpAlzjBXD/DTEtICZmPv+oxODOYkhFGi9FNcndnnZtrOakjFMslPmDQCLPzSN4fFY6nKfKPd/36Sh55Qxe9NgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VUcz+cgQOFJokzxAiq0TUBOmt5/CnNCW2uDlxjOhSY=;
 b=A5SqJ5WmOrXs35i60NhUYxhdqBLnAermD3OLS4cAnmBvFKtQE45LHaiT82JY5UXr3pfjDKnl1k3PMBUsUzL1ZnmohWxjxB4EOJwWqeA23aMX99SZl25Rxxs8Oui2DT13PYU7tc0FgREDDX4EbJmHZ3vEZGasav2Ur+svWSoFzK1Le5oaCpBDLbf+SS6F7tvLPZ7G4DppGFHviHzD+wh4vfoY1gPyfmK11PlifOo8Iz/qKsaMtOWgmYsuXmXcQDi0lMJiGbt0qXj0dlMMOWyeq2t/zgNGWCShypKjm/dOFgdrtiCTegmvtzucuexDIQwPSdLLltCWTYrGt0FQG8Ch2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VUcz+cgQOFJokzxAiq0TUBOmt5/CnNCW2uDlxjOhSY=;
 b=BE5cYVdmweH98an0ancWvI0YkxsGoTrq44Cec72IvkVwiPaOclcKK6ed/DXU7jAzjxMZN3TaiFMo1OQvXhf7GxdsI53ya7jSuxYUADqumT5v92vaSonNuKuXZdFvg8Dzot8nYelFFFd7zHQ+n7KnEUaiEAuP1seF2HPltx+29B7Z6OJejDkKsWcthQTxVPaqypaiqaCfkJ957ntjh2ej96V5YustfCuXeEYY3mWR6QJZ6g0IbBBCLTzWE9AY/EKD6a3nGZUZbH9Zz1AM8EJ5lzcnzZJTVCi3cK3/CBJXHFr/yDZ+QlYEhfDoI1rRi/uMpPx/yz6P1ktEDEccCwiZbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DB4PR04MB11277.eurprd04.prod.outlook.com (2603:10a6:10:5e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 19:18:22 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:18:22 +0000
Date: Wed, 6 May 2026 15:18:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: idxd: fix double free of wq, engine, and
 group structs
Message-ID: <afuT7TE2EYCXxzAX@lizhi-Precision-Tower-5810>
References: <20260415205452.67155-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415205452.67155-1-dbgh9129@gmail.com>
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To AS1PR04MB9382.eurprd04.prod.outlook.com
 (2603:10a6:20b:4da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DB4PR04MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: 74af226d-0758-4dab-2a3f-08deaba43c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CW5dPY6jy4DFcQ7L9m53sT+fIrFhIKUlvVPPnUtYBC9MyQuEVYiaIAr8fNdKLzSkyobxryb6frJL88BR6MeOP643+JyuwvgUAXZIo6VESabAVCl73Hsp9rIzlH4sIq4BDJnlNHNqJMIUZZfsJnYzK4pwG+fKroVOjUNljfMVG+uwiiSlD4S3K6UWPr8OT/9UoFZOPtryaohBBSI1GxYtijs3BT/7q3CJ3fItKVxJXWNB9vr30QtfF1OMO6eCg9vybvz7t37t06hvAQ5I6D9CPtmMv3JMTT1CdS1/Bl121QTZD9fcQ8Xo6aM3iNqB0bFkeTDx0eT4NgmXC8wf8KNTfDOagDIuZRObR63WtK3T/I/+YIrI3q52OK+6MwQkwQ8Tq55J+RA1fq39h5PZLy08tDUe365PJ6jJhEn3q1TBIOAI8jKGubfOAx1FagpQCtpN0NBXOINYmuoKllmZ0OWUN11trGlZd+tcBUTzUxMkv+ZSHCxW2cbR0YtH/P0stUPhwMzHuG/frRw687Y8o2QwHL3OlUCaOuABd8uDHWixIqLQI4+sgZmWNV+nqiz/EoDM6a2hZ6wHT18nCLoV9i01zadx1EbZGos4/+qPLqfVab7tlVf8br4ceizWK1T5Wu0Q0+KRRbzfv/wT17rAw/pg9M9KiXJ5RuYu9bsjShgq6nYBfujB9NCkSPY3jyfUGhHn7aY83fbjnZINg0Yd3l/S6jeAjG7g0WPGfC8tPLGpz2mbahmFzx87uehqqpLh1S7y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5SmPYHmwfU4333oYoCgIVkj7vgvhPisrM8OC9CDFPMnrkCg5MP+62a8JnTt?=
 =?us-ascii?Q?1m86OoY2Yd+viPRW1SdS8ezuNnIHVBofaJ8cr8WQ9Zsl5CYK0B+ZN3ytdEvI?=
 =?us-ascii?Q?imRT2+ttKvCop6p/zdy/7BdbD4eMS6Mk+pzFzxUkkUIVGCH3FEAjiH74vBlT?=
 =?us-ascii?Q?cy6iuVk0zrUCwn+iF8I6PHukYSel9FBnxWWvHuW3XErJbMLEQRU8f6OTcW6H?=
 =?us-ascii?Q?FaPTkACHJn/xi3yUwZhPKNn4OdLUEyh23NAa1UKcr0vOAqKfNtisjmkCBjYZ?=
 =?us-ascii?Q?eMLonhgYI5f/z1ELXb/kWdfc50ln0QNU8+jjJ0/PnH7oPGzG61of2DL8KeVE?=
 =?us-ascii?Q?EVfmNmE517nYVmUWVto3+YaicPs/lgXVohhdjbomaSiIxPZ5H4TBPflE23ni?=
 =?us-ascii?Q?LTZpwjnuA25aGvfc1JfuHdbAVm7RjGoaLKmgXxvb6N4KR+GY4YsATrZupzug?=
 =?us-ascii?Q?Ril8Wu+NG+JWLLY4OMLPdYYBaB85U7UAxWViUpQJi2rsncCKwo27KHT7V6UY?=
 =?us-ascii?Q?m46VbKOw1VCV+aIF39DTmq3Awfq4FRymiL8IGuZWQSFth5VNktkPmnwSOmvd?=
 =?us-ascii?Q?IyQ/+64/m+ZQpwG7X+YXD7BQEpFlqqXMF/DHSyMgyrd6Yik053qUEG8oj7zj?=
 =?us-ascii?Q?gc0W5O+0HtiGPFhTlWBm/OlcjGSamaSZW36HCb5GTrZWZKo+bKrh1xGqlR1l?=
 =?us-ascii?Q?9GsnHZ0W8ZmjYUaUQh6+WRrZgN8Hq0jIlaRrZ4qiTiiaYQ0DQV6tGas9EBXc?=
 =?us-ascii?Q?P0KMxmdsBq8v61ovetFgoYKnBzM1OUgisNrSPNwFU8X6LfAPQMiUqXaePw/d?=
 =?us-ascii?Q?9ntvYvJ6I0pwhdoZd7yORnLZ23fULScUlRUeVvcNZ71lA0pFH/wXJDsDgezg?=
 =?us-ascii?Q?DL6cSqYz4G3OgY7nC5/Y3t7tnEQMF6wkjyPghyRUQhAa4jP2tA1O2eqrXRC+?=
 =?us-ascii?Q?BhZiTFK44o7TTxtWrChGFmFPWfCWKLwz6agQaov8VnLC8lhrJ4sJjIIFzW37?=
 =?us-ascii?Q?iAddPJsAZhzjU5JiMUPQL2PpWeXwZ528U7+PW+/jfMwy0se0PZoDiy9bdYDT?=
 =?us-ascii?Q?rNJBwyQSWP71u0rVmucWpuYup3Fs2iTzJm4gKfgj4zBQEvkSfcNSKwlSFJat?=
 =?us-ascii?Q?1b0aOp3Md384rUpnLcKOTtfkavU1aJlVLfKOkmDN0NVgzfH3bCB9W51c96Zh?=
 =?us-ascii?Q?pukNyV5vQ82S4d8x5qt2qEfOO4g8kq01QOTqR1qB9r98sqV2eDDwU2HyCDKP?=
 =?us-ascii?Q?h63WRRn9QnU1eSHYGpIenBbcfVwR2KU5svQjfPOrETiKhJNCgGVmkiam4mwB?=
 =?us-ascii?Q?8LAXGkPyYpEjY2bAlD3A9XoOOkRWAMO1JInjgufziKLuLqnb6i3Ih5UgnpTS?=
 =?us-ascii?Q?zlsudScZ2Kd2ubOFIFTEClj+QvpdZgi0Hqd5sGesJY+9uXwb7NJ9LWNbSGi4?=
 =?us-ascii?Q?StwbT0DeVaMWIZVtSOHiR5WfGZ/TvUrJnbnpUIgGZqHqwMJ2Xwkc/ewV7qP2?=
 =?us-ascii?Q?2tSnllqkXGQCLKbkyLwXSQZ8cP626EK2+UIWI4x2mICQgDlFvqj5RJLEc8EK?=
 =?us-ascii?Q?IRGio2s1BbkiWjlKWJMduBXJGLc4T0icbvjg3b1V8o+Kjp5FjuklltgubUtj?=
 =?us-ascii?Q?Ik84U+/iwrl4qFOD5m51h8nLoDxaCMmOhHi8n3DXLJJRRgmz4H5TNfgKlCJ5?=
 =?us-ascii?Q?dI32anV72ARwYC7Psb/faGvB4zjdpNxLpYinNAb4+oi/YmsruRpxlE7NJYWl?=
 =?us-ascii?Q?vluLQP8LrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af226d-0758-4dab-2a3f-08deaba43c72
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 19:18:22.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGcN5hLjyJCaDnV5EBIGwQJFlqtO03RNxPBdHreUhlosbQnbFpNNaLHzuY2BKg7PM514N7+tzds/ZAmKKBqs5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11277
X-Rspamd-Queue-Id: BA5D94DFAA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10243-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]

On Wed, Apr 15, 2026 at 04:54:52PM -0400, Yuho Choi wrote:
> The release callbacks for wq, engine, and group devices
> (idxd_conf_wq_release, idxd_conf_engine_release,
> idxd_conf_group_release) each call kfree() on the enclosing struct.
> The setup error paths and cleanup functions also call kfree()
> explicitly after put_device(), producing a double free whenever
> put_device() drops the reference count to zero and fires the release.
>
> In the setup functions, device_initialize() is called before
> device_add(), so the reference count is exactly 1 at the error sites.
> put_device() unconditionally fires the release, which frees the struct;
> the subsequent explicit kfree() then operates on freed memory.
>
> For idxd_setup_wqs(), the wq release callback also owns opcap_bmap
> and wqcfg. The error unwind additionally freed those fields explicitly
> before calling put_device(), causing further double frees on both.
>
> Remove the redundant explicit kfree() calls from all setup error paths
> and cleanup functions for wq, engine, and group structs, delegating
> sole ownership of those allocations to the release callbacks.
>
> Fixes: 7c5dd23e57c1 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
> Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/idxd/init.c | 36 +++++-------------------------------
>  1 file changed, 5 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f1cfc7790d950..4b827a3297564 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -159,18 +159,12 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
>
>  static void idxd_clean_wqs(struct idxd_device *idxd)
>  {
> -	struct idxd_wq *wq;
>  	struct device *conf_dev;
>  	int i;
>
>  	for (i = 0; i < idxd->max_wqs; i++) {
> -		wq = idxd->wqs[i];
> -		if (idxd->hw.wq_cap.op_config)
> -			bitmap_free(wq->opcap_bmap);
> -		kfree(wq->wqcfg);
> -		conf_dev = wq_confdev(wq);
> +		conf_dev = wq_confdev(idxd->wqs[i]);
>  		put_device(conf_dev);
> -		kfree(wq);
>  	}
>  	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);
> @@ -212,7 +206,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
>  		if (rc < 0) {
>  			put_device(conf_dev);
> -			kfree(wq);
>  			goto err_unwind;
>  		}
>
> @@ -227,7 +220,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>  		if (!wq->wqcfg) {
>  			put_device(conf_dev);
> -			kfree(wq);
>  			rc = -ENOMEM;
>  			goto err_unwind;
>  		}
> @@ -235,9 +227,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		if (idxd->hw.wq_cap.op_config) {
>  			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>  			if (!wq->opcap_bmap) {
> -				kfree(wq->wqcfg);
>  				put_device(conf_dev);
> -				kfree(wq);
>  				rc = -ENOMEM;
>  				goto err_unwind;
>  			}
> @@ -252,13 +242,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>
>  err_unwind:
>  	while (--i >= 0) {
> -		wq = idxd->wqs[i];
> -		if (idxd->hw.wq_cap.op_config)
> -			bitmap_free(wq->opcap_bmap);
> -		kfree(wq->wqcfg);
> -		conf_dev = wq_confdev(wq);
> +		conf_dev = wq_confdev(idxd->wqs[i]);
>  		put_device(conf_dev);
> -		kfree(wq);
>  	}
>  	bitmap_free(idxd->wq_enable_map);
>
> @@ -270,15 +255,12 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>
>  static void idxd_clean_engines(struct idxd_device *idxd)
>  {
> -	struct idxd_engine *engine;
>  	struct device *conf_dev;
>  	int i;
>
>  	for (i = 0; i < idxd->max_engines; i++) {
> -		engine = idxd->engines[i];
> -		conf_dev = engine_confdev(engine);
> +		conf_dev = engine_confdev(idxd->engines[i]);
>  		put_device(conf_dev);
> -		kfree(engine);
>  	}
>  	kfree(idxd->engines);
>  }
> @@ -313,7 +295,6 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>  		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
>  		if (rc < 0) {
>  			put_device(conf_dev);
> -			kfree(engine);
>  			goto err;
>  		}
>
> @@ -324,10 +305,8 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>
>   err:
>  	while (--i >= 0) {
> -		engine = idxd->engines[i];
> -		conf_dev = engine_confdev(engine);
> +		conf_dev = engine_confdev(idxd->engines[i]);
>  		put_device(conf_dev);
> -		kfree(engine);
>  	}
>  	kfree(idxd->engines);
>
> @@ -336,13 +315,10 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>
>  static void idxd_clean_groups(struct idxd_device *idxd)
>  {
> -	struct idxd_group *group;
>  	int i;
>
>  	for (i = 0; i < idxd->max_groups; i++) {
> -		group = idxd->groups[i];
> -		put_device(group_confdev(group));
> -		kfree(group);
> +		put_device(group_confdev(idxd->groups[i]));
>  	}
>  	kfree(idxd->groups);
>  }
> @@ -377,7 +353,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>  		if (rc < 0) {
>  			put_device(conf_dev);
> -			kfree(group);
>  			goto err;
>  		}
>
> @@ -402,7 +377,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  	while (--i >= 0) {
>  		group = idxd->groups[i];
>  		put_device(group_confdev(group));
> -		kfree(group);
>  	}
>  	kfree(idxd->groups);
>
> --
> 2.50.1 (Apple Git-155)
>

