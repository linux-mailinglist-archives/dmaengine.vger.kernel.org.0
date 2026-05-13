Return-Path: <dmaengine+bounces-10424-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJaNDrKbBGr3LwIAu9opvQ
	(envelope-from <dmaengine+bounces-10424-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 17:41:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A337053654C
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 17:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D35733A240A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0D3DB628;
	Wed, 13 May 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mocm7QNn"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4034FF74;
	Wed, 13 May 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684093; cv=fail; b=rdp5uHgvUZD7jBi247UBBnZqFde0qH1oN4q7fqUKXgPuCOU2+PSWdPfcRq3mx4mkQCQtNPlWh0KUBiLAO2dS/XNWsr/jWI05TJVtOyMahY2tBndy0ByhS5zaJ6ZpJ0acbhXO/98E2fT+8869crHhYGFKZOFGlSg5Au2b5/f0W3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684093; c=relaxed/simple;
	bh=gbQf2ZkWuP674bULFNyRnl3mJhXgfyKweTU6RBMxOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y70zWW0G9GFMx79yjce6ZKycn5cleoPl6u5/iKDM0XnzktnEnRea4s0h8mWk5/AUTidkIQhbor1fcUb42zv1EPCKbtj9B6kx6M0FMAvfKdp4KgPFbkReQ3DPdkusmWYZfa2rTzYUOVYVscOz/4ZiQyF/zu1a/gH0DYlE14ca0+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mocm7QNn; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGqxEJalkONf0813fI1aDEWUZvwN9JhmrkfVn3e/rvQWYi+pCP2t5A8p+9P9oNgpY3MRtHsFdsHolzNpbGJdpREvGCi8xME31ftcsL9z0q7jW/A9xskP7gCbJ/fMME3yk0E6He3N2Yc94bcY8nJ7UE6Z2gclSHA+pvNYh2TBLM/HY5IXEuQDd/ntKIIy+IMh9UPTIceek7nm9Ogb7kI8aWvgrQhqdIXEp8KX2VybKMthe5Xe4Yyjox3f3eNRoUwRABGZSfbSJfl7t2QZaOVIa11OIseiLudBAPtYtBc4P34RL7PdTP0AEWvBAojjmxs93gztf7IJobIF5VCK5brt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRstbcoafgYS7LG8o2vspsY8WHKo+HwgZWDaOuDIqWY=;
 b=yq8ILasFC+nYCc1mdpinjnH8g2ZR7LFjOP+cZ6U0ibEhP/hUvzD8B5dvDqD5KXA+efofGsR6oG42MmGzApzuxeq6py3dePPatFbUP6uEl1iz2L3dj16rywou28TmIJuS/lzMsPXZ3yC6PfQqNKNXdL9STte09ctsbJwgWUHYoYhAEHjD44AyBifhtDCbzlOoJsV5jEiauoZIJYXrRyZoweOgtz7Bg/7YRQMVn1zK3dqAg2MlX0XLwT1HHT45WzY+x9HqBY7XXUiZ7IBN5H9VQZbTOQJXablAeW2rOWAfTs2Pb8ZSMvB/Pthri52iuo8CYrv4G7vDYECwuJ53zoUTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRstbcoafgYS7LG8o2vspsY8WHKo+HwgZWDaOuDIqWY=;
 b=mocm7QNn6cVjGRF1zyo1851qwqpGdv63STrVibOETP2nXuXYhM+yT1TTpb3GhWwZgVuHdLSGJ+RJG/pp1+z7LPhZY7SkJPocZxCeR+G5hFmPnyFcdElVs5naX+dnCw8+aWokMZA7/NhQVghBttoe2WzFGCmHA23GK37UsULjyRAOaiGiCjI6G8+kzJFJnRazYoL3PamOL5CUMX94GUa6609wxO+4t8zaZu9njaTZhmZ5PgLpzlgBE1g7lTqr9xXA4OYr5rInrDiS9PPZjDgnLDSuFvBoOJga9uUJ8r1lokdp1tzRz3RuTZjsLgpxmxHR+WWrIrrbJGj/xHTVsFYNLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10558.eurprd04.prod.outlook.com (2603:10a6:150:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:54:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:54:48 +0000
Date: Wed, 13 May 2026 10:54:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dmaengine: fsl-edma: convert DMAMUX clock
 handling to bulk clock API
Message-ID: <agSQsljSzv1Idjwz@lizhi-Precision-Tower-5810>
References: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
 <20260513-b4-b4-edma-runtime-opt-v5-3-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-3-1e595bfb8423@nxp.com>
X-ClientProxiedBy: PH8P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4b3a4e-f70d-4edb-4be9-08deb0ff947c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	BfBhkOzIseHO959rMo9mlNsmHIxPGZhcSCY0sXjg/y86AKPmVlZIG4BDfcZ011ZoiB5icRNYA99xKhVrNRKUnYnVPOQs9meLpQ+ClTee1ZXWxs2Zmy11HgE5lRls/7Sil+SQFg7b6H2BoEdl6ljUwVhwbrPiRhpKJ0tKtrwXTiP9jagJcJKNnUCYH7qEH3i7zL5ZPdJmywac3MECRxrYAuVTij7ZOc8UNSzFFSH23dOKeFl8dc9mhk+8XVgk2W21ZJudeYwVyrDzehN0j/hr9uiwUFgEzRpb5vGOZhl6d3MujdxrrSkRQneTtavzrPSXAhOSBNHk70qlsPvtyFOBq7o8MfWyePoqd9lIP5C/MDW2JQq+oM02Qr6OSBOZX7TJNcED6cBnQqUsLN970awScP0qLwt1yermKhBkIyHoUZzZEnTLtXqWkkaOMmMpXHb6JZfkyyuqDbEE/aDdp2NI6qLgQA5l5jDG6PAdd75wVTddwZvBU9jB5iFeOblJorIGekkAtrN/hexDIWd4EIy/vn/sDf+CiPMET+BhC6myOc20v+rx1ldJRQqiKTlIpbEEHNgX4k3TXnyJ57wHCwxc+FxWBhb8t5SzHta8FFxXMK/fZYfc0WzXHZotYaOAg6vb7+bxcwrdp0zJjxn8WgjvaG6K4FcwEPoswJmjWSscMfZ2+6W5argazVwgM3HDnswmXLkHazDwU+AnTYM9eSK2fHPJPph1d94OXtTXE0bcvN2I+J6gIHFrAa7HX69YXSgm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eoM208Ud9pcRMkSU1xV4RJRMQ+SAy84hBpNFE2znozaLBg3q6JkETpA7z5n?=
 =?us-ascii?Q?X3331OEOUzEykBdL/awQLhhmZo26SUohD+sjMNMAwC88gw+xyQKdI9t8XXPL?=
 =?us-ascii?Q?cSzwj7waZ3pP5MA+0yeRZSv4Z9UERwaxMa94qFmbNiHBgiH3ioAsZ9i9jLqa?=
 =?us-ascii?Q?W5XbcvvDOQMDlpK6pHvHBgHcF33sWge8JURBugFCXr23nxcrCF4OR1ZmT9Ko?=
 =?us-ascii?Q?OIUgTFEgLj5kSPHt1IQNI7NTVoTXe89mqgvdfDgMhIrrVJnql+5+xEQ4lMNu?=
 =?us-ascii?Q?0+imtoA/NLKoYW8nO3NvrNQU+KI74pDQT3PkO6eYpWTCasJTbg7qFH2QmBfl?=
 =?us-ascii?Q?rutmlgez180bOBz9We55rCGsWVZ61HtFgWejDgn8yHGhL3jIXB46+JgdkyFw?=
 =?us-ascii?Q?PwgJPnYV50l+MHCo0y4P7TUB05PHzYVlHAU5ZQ1C26GSYYgwL2X7PHuF67Z2?=
 =?us-ascii?Q?+UAxhUV26joadWnLQx7xDgcUl0q/ZB7rktqjhi4H213pPyot+6VAg0jbgj+G?=
 =?us-ascii?Q?i/GELpBeJ22Ras6RQzv740t36tiCdHcvQdmqlTqs5LgTkwcR4t/WifkDIAVI?=
 =?us-ascii?Q?xAIa0x6qvNYZoiVVZLIGrCgYvc8fQyRxYIP22o41mdEKFi4LG0MV9rJQpDow?=
 =?us-ascii?Q?vv0Z7bd0DigadI1yEXmS2wmqePQqAZr9vuY/ot/39bxHgfj3p49KZrQNc4mC?=
 =?us-ascii?Q?GMpSjVE4EQXdPbU9Wx7EpCcI0IdPaGuYPMXoZmmEUYkwjrNXTLFWu0VAdsbz?=
 =?us-ascii?Q?7wT5iHS7IS8FFmbe3Sp80jfQ+HGCSkzdFkPARMKleLPPRHWp5I4fj77udkjn?=
 =?us-ascii?Q?1LAEyhXE7EON9T+RErBD8eU/VnwAHgO08o7wOJJkTQd6KBg+Z0ndodQZI5RB?=
 =?us-ascii?Q?ynos0VBuVCYg51eQ9XcKLMuzp/mCQj3S5HZWXpUqiJH6qsSDPvuLQg6Qq82x?=
 =?us-ascii?Q?VzisXCHPf2zizAEZ0t4Rc3snmiLwtsuZH9C+STElRwcL7/KAdLKtSN50lgAO?=
 =?us-ascii?Q?unlhexH9D26vcl1GHbjNC8HuyTw9tcRs1SkSe7rB5KmmUf5MIxnA6reVBIpA?=
 =?us-ascii?Q?o+u6yIzniv6xb8Xvt4uMNEWPiD76OEoP55O3aXdsfAtIBy/Nkqh2Rj7xgPE0?=
 =?us-ascii?Q?jeAnChDlQPS2fa4HFPfcrv9BUpy3chsWdcOUj70DYGQQ2XHXkIg4hPHgeaX1?=
 =?us-ascii?Q?drbUZl70LlEALKz9/Q1v07XlEHovYskserqa3f/bveniOQhS+okZ4PTOkimK?=
 =?us-ascii?Q?zKpyG9REH9vWArcIY1OlCXaG+abfRM2pF2I1uQ+Im9ZiVT9scfSIdQz3uerU?=
 =?us-ascii?Q?OnAxyrtglqqyvUPjkhXodS6WKhalCJdz60VEoYA9skeJw8Yp8+GpOs6OHFyN?=
 =?us-ascii?Q?AVl/YtTuOROkkYXlvCKhxOfKc13CMoijR+r6XIc2n4GnctLXbWqlUSxHWNB0?=
 =?us-ascii?Q?Tn9dKmWWozJvu3RA8QdvRKXIGXbr5S/dQDdViQ2FkH39HtO2Zc/0gr4jbEGM?=
 =?us-ascii?Q?xjrcx/QnkZ1SmtZpaKpMga8s2el9kptt1zGpiJB0FqTN7nFpEIgDaufbI5xX?=
 =?us-ascii?Q?uBeHWiKOBopg60YKeaISAHMMSlsQyNRDUutP+vhsyka+/CAxdIq27wAyO+xe?=
 =?us-ascii?Q?rw/qan3MSdwd7sTHcs2c+dAX+5loqE96tKLCn5hiDw5Kbia602KU5lsTHa9i?=
 =?us-ascii?Q?huUZJCig2gowbkiAkLx/bdIN6P0OfIAsD5Llg1gSw3UsJCKRSD8uQrCVCNHs?=
 =?us-ascii?Q?CxxYegzarQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4b3a4e-f70d-4edb-4be9-08deb0ff947c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:54:48.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbn3YHe1Xv7p3iCLEa5giJDxduyZ02Aw2zAB19+ziX9a6wz27wSmnwyoYSVqSsq9NXq/uhhq4gqq6t2+4gCoKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10558
X-Rspamd-Queue-Id: A337053654C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10424-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:23:49PM +0800, Joy Zou wrote:
> Convert the DMAMUX clock management from individual clock operations
> to the bulk clock API to simplify the code.
>
> Prepare to add edma engine runtime pm support.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.h |  2 +-
>  drivers/dma/fsl-edma-main.c   | 43 ++++++++++++++++++++-----------------------
>  2 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 54128b3f45cb399e1c11d9f86d64adce5c65c102..824b7dd2b52618b826154e55fb96a82c27e846ee 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -253,7 +253,7 @@ struct fsl_edma_engine {
>  	struct dma_device	dma_dev;
>  	void __iomem		*membase;
>  	void __iomem		*muxbase[DMAMUX_NR];
> -	struct clk		*muxclk[DMAMUX_NR];
> +	struct clk_bulk_data    *muxclk;
>  	struct clk		*dmaclk;
>  	struct mutex		fsl_edma_mutex;
>  	const struct fsl_edma_drvdata *drvdata;
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index ecd14967bfbc07d373a74790e87f9aa36b60e6c9..c12126ea6552d51b773bdd61c018570dbd618602 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -526,14 +526,6 @@ static void fsl_edma_irq_exit(
>  	}
>  }
>
> -static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
> -{
> -	int i;
> -
> -	for (i = 0; i < nr_clocks; i++)
> -		clk_disable_unprepare(fsl_edma->muxclk[i]);
> -}
> -
>  static struct fsl_edma_drvdata vf610_data = {
>  	.dmamuxs = DMAMUX_NR,
>  	.flags = FSL_EDMA_DRV_WRAP_IO,
> @@ -747,23 +739,28 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		fsl_edma->chan_masked |= chan_mask[0];
>  	}
>
> -	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
> -		char clkname[32];
> -
> -		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
> -								      1 + i);
> -		if (IS_ERR(fsl_edma->muxbase[i])) {
> -			/* on error: disable all previously enabled clks */
> -			fsl_disable_clocks(fsl_edma, i);
> -			return PTR_ERR(fsl_edma->muxbase[i]);
> +	if (fsl_edma->drvdata->dmamuxs) {
> +		fsl_edma->muxclk = devm_kcalloc(&pdev->dev, fsl_edma->drvdata->dmamuxs,
> +						sizeof(*fsl_edma->muxclk), GFP_KERNEL);
> +		if (!fsl_edma->muxclk)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
> +			fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev, 1 + i);
> +			if (IS_ERR(fsl_edma->muxbase[i]))
> +				return PTR_ERR(fsl_edma->muxbase[i]);
> +
> +			fsl_edma->muxclk[i].id = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +								"dmamux%d", i);
> +			if (!fsl_edma->muxclk[i].id)
> +				return -ENOMEM;
>  		}
>
> -		sprintf(clkname, "dmamux%d", i);
> -		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
> -		if (IS_ERR(fsl_edma->muxclk[i]))
> -			return dev_err_probe(&pdev->dev,
> -					     PTR_ERR(fsl_edma->muxclk[i]),
> -					     "Missing DMAMUX block clock.\n");
> +		ret = devm_clk_bulk_get_optional_enable(&pdev->dev, fsl_edma->drvdata->dmamuxs,
> +							fsl_edma->muxclk);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to enable DMAMUX block clock.\n");
>  	}
>
>  	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
>
> --
> 2.37.1
>

