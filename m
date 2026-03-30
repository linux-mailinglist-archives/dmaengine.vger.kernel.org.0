Return-Path: <dmaengine+bounces-9734-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEdvJsSdymmg+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9734-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:59:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D97535E499
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9C343013846
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD83374185;
	Mon, 30 Mar 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VMgw0/rP"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5436D517;
	Mon, 30 Mar 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886103; cv=fail; b=ng6iWGirBqoOUUNq6QBr37bOHuFCbw9qPcw7ocJ0WfuhJFlPVzG+XZ7UGGN7O9Xs1xvqaAzpFK6RE0QGWJN22RVKZVWVfZ7DnpnoTNGUi9nIg3ggGUXs6yH11zKkGYCp7gTcKyNTJCyd8n4FHylO2OPNMYQ6Z2L3UBuJ2uJ5SpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886103; c=relaxed/simple;
	bh=+X/iMR1kPuDxF3qH+AEHYF15+fq/YwkZBXFb0sY9G5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PebDl8yCOSMiZ69HvMNYMkVE9vvfO9lLr8FlHyMNQn7QOhP3mc/yl6/tQ2sB3qDgELBZc/YqIXcKkl9E+Cb6uY7R55Zh4XXfM9unFMxsAd/I9sFAaJizv6zNOThNdjtxoFwpJPrVuGxWeXFfd6t0aV+uIULEpTo1TriJiLtbBuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VMgw0/rP; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHBYdw4P8mjZ9+Wuh9eOtYhykyxI6C9iHWn8z+8hQJO8PjHxLlEvpctvZWwaJWYYsvwapaT9dVYBfd1eR+XuldaIDfyaAihqwp05N6IhO0/rQexwDZvqVJwKvsi7ooZhB3gfW30JTN/7kgXoGX54R1DA80X1kfzFA8RB2SHRekae1ev9i03kb+sAsCDGpkfXVcoSafsjV5r6S5eckaaVz5iHy60R+LGIX4I4VgYrFh7hBEx3q2uaVJcGilKwVezuDla9IU7peR2ZD95S8Ovds+mzty2utSubX/p9w7oJlRzmffjssMCy3AALKWxzLFgo/xQ3+yD4MQxPW7p6pNpq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtapOcrAuKvlFMZ6A13qH/lcH4rhfOijEWkO6D7mQDA=;
 b=fu9I3AddZijiZ0mKrA4V19F4Y9rziyyAOsCpOC/7aj8PwO6Gc7DpbzqyuULKDcUYG2iDlIBDpzhNormWp3ahqjGrijLuRzcWVbPWYG1GPxAuoGuwlvrF6ajKhDU5lsUVLchhw4kgFhAKPQKNUOh57+TEHBeVnoC+1uNHx9YCrshBCb58gGH4k2T6Ql1Ep8YT2LdE8+U4MS6GxgMWke1aC8TQgFOJgjJHWaldmPBC5pRbGQlNFvyJeC4psXG9GRmdDvQKYDBOM1C9b5jD3itICkDzbcCRhREh18wIFBLh37CijwTv3ePtSrOB0zAavV9MIv2VW1S6HoDSKlmlsWDSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtapOcrAuKvlFMZ6A13qH/lcH4rhfOijEWkO6D7mQDA=;
 b=VMgw0/rPXmgAI33J69JUHIgPblT00cfDORcNB3YSWAfy2aA0zQPXEWmNqlLpgnFdZNQw//sDbzMxGyoSIBKK3felnJWeT8vVuUd7UmgFlfQLqMjOeD4x4WyxRPMMs0o7kyEdDIAz13Kp2Yd6VfExS87+ywxuerwvtStLgDnMUwDjsK2HIFxINLZ5IjgAv4iq7utTFuFAkzuBsTqaV+KNRAADYKvvPLOc8bzmEE3Lg2WSfscSE3QPE6IVnUlviABrnytdzE/96alNQNJC8b23rx8dxZJDW1BuhJmlZu3oIjUtiptHSCNrnHlkNo/QQWX5rIssTNUYtDtrL9CYSjTbBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9819.eurprd04.prod.outlook.com (2603:10a6:10:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:54:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:54:58 +0000
Date: Mon, 30 Mar 2026 11:54:51 -0400
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
Subject: Re: [PATCH V2 2/5] dmaengine: xilinx_dma: Move descriptors to done
 list based on completion bit
Message-ID: <acqcy_3Bkjkq31hs@lizhi-Precision-Tower-5810>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
 <20260313062533.421249-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313062533.421249-3-srinivas.neeli@amd.com>
X-ClientProxiedBy: SA9PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:806:27::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1ffc63-53ec-49b5-a7ba-08de8e74b1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	UGxG5RDbIKIRpOLEJQm2wHhux2skVcrcX5hsXbsHtT+3CqGloDyC9I0FBBfghSBFGSTA8cRGwEXVRqtkTZe9u59L7nafjQ8oEDkuF/ooBamUmJ08l2BGrRWITAHAeSmErYp4dd7o7YuIznRtI34aQLxwFLsMezmjB2L5cMgoniQscm+RkWANB7Kfqx8tfKIZ3JKXy7vWTJGgBIBH70qIu532yVvKyyepQHwPVTsdwdDOYBu/PrhlbYmG8CUyOuVmZN4scuetFKscWqaOBwU0CeTM00bWJb/1mzCe3LRg0VvGSo+aNVmEXe0+lZOGmqgcDDGfIaiKrEKyhjJVnDfqPkgj3jQvjRF7kG+hWdCuGJhQMmm8ZI+Ww1YfrQG3nb/f1y5xeGyQ7kjZdtGksd20DBu+WPZyZBPGQhGi/CZDzjxsIhEbCPV8N9jPRGqC81NW7psq8kXLMEjF0VYewsoe07rQKfYPNtAHLp8GVq/M+TyfrlhwMZ3Exmhx5cKquOF/IfJvtxg7LdUVvQlMgN5ng1Fzrw5SnoeLycj593kOZIz/snyZ5HykXGQ7TvVF9BajlNFptk5TSq4BRUAShhtJUVq05TbXlJlTL3FbghqoSAl357dt4x3atI//6kOH3A2KX794Qopw7elvmt/zTLcmsUZR5HzPFEZrZcKTkUUOUWC10DEPgf+samocpK4vf1a9CB1YuD+wJUHbO1oueTr7b11FGcVPHLAw/H8yUoseSvMgsFCgTe3NUA6poltgZcyHtNjkEwq7ycTiBCWvVdvbdRryQPaJuMZ9bGyrEaiYNqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZq4Z6QnQg4nZ98k7tkGl7wB+aL1MgH9hUv0Hkv9VRaocHdi3uYPeJv86onJ?=
 =?us-ascii?Q?SPqvWtSIiKhcbWkConw2hRjno/XKOb06HIG1QwogmWOLDfxaeWSlIoMy6xGP?=
 =?us-ascii?Q?N/E6C14hWOSpJPLGtu6KLl9h5/xk1f7++awHOSmoClNtHTNkzbxv8DqXsUq9?=
 =?us-ascii?Q?awP5kQtXt7K3l31xZecgsm915m93V7ghq1kt9UPHPYmUM8YWElemLf9d7j9o?=
 =?us-ascii?Q?1yOZR1qwDzWbdy1P1tn2ZIUblC+xOk7U//fwBWgUztLIhjTIlviciwnP8x+Z?=
 =?us-ascii?Q?ZFGvnM6b031BvwXpegF2Nn28XJZbP+2dXX9XAP+CIDpvUFdh7bgBO8h5L6sJ?=
 =?us-ascii?Q?b8DEJThAlcOHSvEa5F+siulCHOHrt8AylLy9RFIpqK24L9b47Z56YN0Vfyj6?=
 =?us-ascii?Q?XcO5UuobaSUE4LR7UDdB1AkJS6M9jU6A2deAhdHkGoE/J15HJNNVD4aLMxMH?=
 =?us-ascii?Q?B2JNaNL2z8kRx7eXcYVXS+OhSjsthZwvZemWQdzj8QcVmkfeqTaIGCi8RtOO?=
 =?us-ascii?Q?OchuTLh4CdlhxsgiCGDvMlAdU3tqcwGUu7/G3AH2bsGAawNNTHuvE7rPSc6O?=
 =?us-ascii?Q?dhB+K+oXhUt5AIDblEsZNTh8j2m4aXNjf24SWQumzv2ZzfxbkAWBHnZ1sgYt?=
 =?us-ascii?Q?8ZnqJaoWPf2asqbZWYPgAa1V90wj93/sE3gybx2a751FCYlTsCocOBB3w+M/?=
 =?us-ascii?Q?TPSPd8ZpR50Yl/5TACjL+lVB7gW06BM31N0+oVjNcH8y5+iaasj890i1sQTc?=
 =?us-ascii?Q?//trZahG4GsZda9cjWihVfPxcHGjNgFHRe5oVyTcDp8wulCko6G2JUBbLzRn?=
 =?us-ascii?Q?oqwzzi52785ZBurvWAvteyBTNiopjCsDv3LYxeAhvKOCQFpb5nAd7NAAZB6y?=
 =?us-ascii?Q?QHES4dvbsO8c9B2RUxiG0/A52n/OGYTAhbY6xyUvexkV8JW2xV4OXJf5zF9w?=
 =?us-ascii?Q?Y9Hg6NZa++G1J0sXJjaXX4Hf2u6wIcvYSl6YGOdxkwoTdZdwSKx8utDPi/8H?=
 =?us-ascii?Q?Lr7QcqozdKofO7Sf+QZkXb1Iz035HWy4flR4mUsbEIECQJ7JdfNQaQHeT9xi?=
 =?us-ascii?Q?H2u7ylayqhyO3jomeUxNoVHgEz21ILByrB0atdV6KocZwKLvLjtk0DLeS2Q7?=
 =?us-ascii?Q?aaY7+RpPkRPrp6p+3YRdWFvMcbxQ88y59bPdMGGf8zoZjsUV7txT8WXq0dds?=
 =?us-ascii?Q?Ks9ddUTvlGH91A2JW4nTJDKXIpeHVrqz8uP/gntU1zMDCszY9OfHIwUDNye3?=
 =?us-ascii?Q?fJEg0z8+Xnmfe/y0YfbBO6srRe1Wru+cL/H/nmmAKPW0sVq5ajyl5UqFQTy6?=
 =?us-ascii?Q?ywJ54M/rKBs08ejgk8HORGl3n5LmohW2CQeM9WTpCBdN0XcfGt7VcW1Uo3PJ?=
 =?us-ascii?Q?OoZM8odXHCah30nGeHiF4B7Tptxqn9Lxv/RJOn262Cit2nCwrUjqMCCe6g7f?=
 =?us-ascii?Q?S3P2rhfY1dUjyasUKo0DegiaMeQ1BcObf5pY3gypq3FPCadEkDzNmYj7g1FZ?=
 =?us-ascii?Q?aDTCJB+0hnsiZIzbjUDIu4m5m3gVKn5ahF513diOD9n9RR/MePjmiwXgngS0?=
 =?us-ascii?Q?yYZWWAQwriWok5wBMnRHaDfHkE84xd/Ub1WjT7rmLdBWKAxKykgLmJ5sGw68?=
 =?us-ascii?Q?nZA9PDEa82p33k6YfQr5N02TRSPf2hbkLU76huSzUHqFHxjVV6Upy0qh961Y?=
 =?us-ascii?Q?IUuuhy34pzZWEU4YibzMB1GI+LzzVyQ+aUGfVLHHcI6wBl0lcL0KolGlJ6Zv?=
 =?us-ascii?Q?L56jJLU4LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1ffc63-53ec-49b5-a7ba-08de8e74b1cf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:54:58.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI1fRzCuk/SC9Drcs1wuidZS0hgaY2zgPozCfruFL6PCqvs28742FVWZMjr6c0xjBGQPBK6LBWTjgEnFJUk7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9819
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9734-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D97535E499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:55:30AM +0530, Srinivas Neeli wrote:
> In AXIMCDMA scatter-gather mode, the hardware sets the completion bit when
> a transfer finishes. The driver now checks this bit to free descriptors
> from the active list and move them to the done list.

Add check complete bit because irq may be triggered before a configured
threshold is reached when interrupt delay timeout Dly_IrqEn is enabled.

Frank

> This is required when interrupt delay timeout Dly_IrqEn is enabled,
> as interrupts may be triggered before the configured threshold is reached,
> even if not all descriptors have completed.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 4a83492f2435..00200b4c2372 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1762,6 +1762,18 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
>  					      struct xilinx_axidma_tx_segment, node);
>  			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>  				break;
> +		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +			struct xilinx_aximcdma_tx_segment *seg;
> +			bool completed;
> +
> +			seg = list_last_entry(&desc->segments,
> +					      struct xilinx_aximcdma_tx_segment,
> +					      node);
> +			completed = (chan->direction == DMA_DEV_TO_MEM) ?
> +				(seg->hw.s2mm_status & XILINX_DMA_BD_COMP_MASK) :
> +				(seg->hw.mm2s_status & XILINX_DMA_BD_COMP_MASK);
> +			if (!completed)
> +				break;
>  		}
>  		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
>  		    XDMA_TYPE_VDMA)
> --
> 2.43.0
>

