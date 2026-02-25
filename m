Return-Path: <dmaengine+bounces-9085-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKZ+Nz0hn2lcZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9085-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:20:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9019A761
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A02F30CD90E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05823E8C44;
	Wed, 25 Feb 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/PJRheG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785853D7D70;
	Wed, 25 Feb 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036240; cv=fail; b=iFgR6sUEEtnX026y4fGi2Yz3X4h3xBIeYuWnPSrCxU6HUCdJ8y3IE4dl3Y+0UopH+dmu8tcKWThnHvfsoUTQw+8GwKiIzd1EspbnnHy0rjXMogb+gb1AjLD7OgKqPLEIhJJ2zzrfJ7vih+kiH4lyhirkvF5mw7RoAkuCWftz2Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036240; c=relaxed/simple;
	bh=cyPchmXsZFhjzbhUgXZm/ZTtqR8y6SNDn3m/o8MQxi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dwYPnDnu2DwxGJDhzXbZ15Ga/nu4goZJckgjN9OgND4X3GgYlc+U12EMUMhQesP4cpwv3w4hm45fZAKIy1WZ7dIz0eas6cML4D17W7dOe1DFMut6vuo75h5KI7S2URnmDfriE0SjtNWkhP5hCUa8AxcVQe5sEhsymNw3P5sEztk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/PJRheG; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shl7htMQEMHr9y39HEsqyy3gqYZ1TNgQ6X7f4uEV5EU82j6PKRoJxPQDirALZwIm/jLWP7Okipipvt7+FwmOJkEEBQVOqBcAhWZimIFhXoW7jPag6h97JwCNkmoSzyqyekIpiwX8mBHWwQkqj1HWBxgIYqySZmALFJTqvFbwQuIVnYfVXf02osGZmC6Hb1siMOXroPp8xqOjp/8r9z/kvwvPCx0gksMt90Lx8CJ+CmwChDUpISSlHt0JsgRNEhhzOixcnaQ5LScNi0rkBBmXf8ybkzRdCMvtfVJeFi6GtUKAroxgecDnTWZIgGutfBM7/fMqgEe+r0GHSDbglbtFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXyRBrKcCy8hfmLH3cumR4Y+8rUUFi37F40rPihNdZs=;
 b=w7XSbuD6HG3IP9qoe7bMrb2mbM15odcHiYL/yH1J99eATKBvmJR+pMKuMYZdrIkvxfRztL0y5oRvfQL5iW2PzxnwRp3CjwCkykUejYv4IW4ENbkUTWRYIK5zg2ced/I1f3y9W6/5eQK7QHrJwZe2TsTfSYb6RjKeySxlggAiecJxPG/tSYDbwDLyzJnDU/uXXQMOob5LzEAetNIU12t6eEhCobgviLgrixdiAdI6ozWbvLxz1SQzkp5sIaFwNxblU/cokue6kY3YwSeULwDIPJPNP17oCkbLBO81ahvAaIVay8G/eYVCsBsu7JxuOHpqaeMofERbxsk91iUuHRVZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXyRBrKcCy8hfmLH3cumR4Y+8rUUFi37F40rPihNdZs=;
 b=D/PJRheG2zsSeBSn7eqx7qObOmWoo6vihyLoQGPMT2N4cgDxRZmDMBvGTr55xFKK8njk0IEB90CmrH2Qoxk4r1wtnYM221raeCbFifUv49knGYSTQqoTHtak8g3fQnLqENihXIfUQbUY8YWnIfYuAd6qqIRQmirdrfQ+WF4lLLcbgA1G7PtHVblhFq2UXdwdK8nGSlf5xINE+vRNEXl/7+sdUIY3mLGhVTtZ/v4Cx6cBXasO+NPH2WhAboe2RXURSylJGc5vB6Nz87d1pGLzKS3L0PxS9fSrRatSlzOClQA7X5qJU1UD/o35ObgTUSpuXclhkNCqY4YmrAnN1+/8TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB10015.eurprd04.prod.outlook.com (2603:10a6:10:4d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:17:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:17:12 +0000
Date: Wed, 25 Feb 2026 11:17:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 1/8] dmaengine: sh: rz-dmac: Protect the driver
 specific lists
Message-ID: <aZ8ggNdMiCDkZcBv@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-2-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: PH7P220CA0171.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB10015:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b27afe-75dd-495f-c769-08de7489549b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	VgH6nEhkidJduDe7wItcg3f/hduAABTm2+JmeG0LgjmnB25hvZJXJC6x0fPkpwVdREtavQTsumBgq8Yd9IQ9+3cvdA4b9v/YURqG/CnzO+U16f13TZXsVYHsaDpbfVUsiRTSTzcOWzv57Ggxq7R6cPFcikIUb+1xol4BgybisIzNKaKQyrRBnJQFkOKt1CejhPEaZUkUYlv1o+NJcWpt4Ra9ohBoeruWiKztoF9/bFOM0V84HbqxEPqovf4xg+9azMRDVxfOkYr2cZ2PEb93OxH16pCRgs3YsXl+/pfI3yvZ0R3GfEUlBITkVINtrjbDbvdzd4JNFXeR+qABQLGd/+k7VBmdMhfUn9bvYgLY/AcMI5nDCbP0NQwJ3lM7/K95DZOwkXODTMlJtXl4cjqdZ/7BPNthbaJjysMHQK0AIV4IphJ3ipTR30HL2wCZ/eWPfnJpZC6AHQeYeeNQN2WgtM+mrwxI8RmeL0foTTmk/2QXH17BKQp2RB1OlzSsUX/YaVMkc44yd8ERFE8rKXGzs0lvXRZliSd+UXLRS9+Zv7BAadaPHHI9671foC0Yh0pKPy3QNeFi8zDHXwHKS/wgCERqbP8msdSmCRzlDL6xpyYFOR/GCv3M4jf3MEwV9L5tAghXsdxsb8wNzqEws1t6P8OwXnzv/KE+Kitxz23vbKHXjgV6unL/18AkZ414IMpAVSekOrHMm2P7UBHuoGm3t+bJn29D8dPcnF00yENmPXSfPIHLPbdKtWXT0hd6xkDZzTEi3kEwQTbdwD4G0FC51A18FphPdjL7ljBZ5ESEqhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LrO503Z17IhOJtVC++cfOtZS0jyIcmv2IsgwkWA4ovTAwNudemX0OdRf1G3N?=
 =?us-ascii?Q?KdCzCei4BCr1v9nG/kzzJVwPegPBLZtH9uGkD4+bqZAqexwasG6Lc5dSRlY1?=
 =?us-ascii?Q?6wTZdB4aEvnWhRk78DE9vt71A5UsXhAZA+AtS1fNNMszbEnEtV1IpgqElnQV?=
 =?us-ascii?Q?mf3o4VipxCkCKyJLPGQziLUGhTKwEV/LE0qcuIPIvAD8XNt0i1PqYmUZzirh?=
 =?us-ascii?Q?oNKtIJFU58ooPeu4191S3g7rfVeF2gVUhpi9/KQjK3cSLPgPl7qk9wUblwyV?=
 =?us-ascii?Q?zwV0NKlVlg5xDmC4E7AklHgennfKbsXbKVSGzF9/TCrUXiEBSeqy4hyeW1dG?=
 =?us-ascii?Q?bzsoUVLzOSPLCL6EkBX1WyGwRoUpZzH6o/uUnqV8fcWRX7agJWmExi4d7C3+?=
 =?us-ascii?Q?OOQTtKX1UU4BL9ssjcmicbS3HLB+lIbFhTHGwxHQRj7GhfWk48fm3wM6cs1Q?=
 =?us-ascii?Q?D9BknGbcXgDm5aYvw4H623qJen7bd6KtpSGQiRJ6B3dyv5aKBCq3PL+qhTYd?=
 =?us-ascii?Q?krqjMqryWcHGk2ww/Ai8lqIa6liynK2qeIX4D9tfi8cKnnc6m8nZ7f2jX/hc?=
 =?us-ascii?Q?l3DN/s1QM30qHGm/JaTs6iG8koIwgZ6jrm4OneDQNjTrglfPALLe7z/+3Qu1?=
 =?us-ascii?Q?1dx0o3tp8p3X5dv+tmuewNNmliITiN+oGbe+f8cpjyPYUuUWUgdFNi/JHGuo?=
 =?us-ascii?Q?N6eKy8oBdThy+YjnxeQWjgUTrc2snOzpC03XUpL7a+ByeTZJgQ1F05f0jCHM?=
 =?us-ascii?Q?2QXzunI8z1QoGWluaolnezqC+6qTxbvvdyQm7WP5yTLQhWIPl433qAKC6mQe?=
 =?us-ascii?Q?rkoBbY7HFygQXOcXZ835DPZFo8V2PNcxpU9a6idp5GfjrNnDbVpoLf/TTHLo?=
 =?us-ascii?Q?SL9D9+V5Z/WY7z8fulYfwwRyYB9XHfkrUqRzgybHEPBRR/URvgFIl0Fln5TA?=
 =?us-ascii?Q?+UXRveT/8MN/P83qkuomFm4issTEgAfzN+bB6oYjJSYSRkP6mS/p3iGDXL6R?=
 =?us-ascii?Q?kLjhQO/YYYiYy/iHHGbNnBe0BlYE7ud0O8cCMeUD7UeDRKIE+LklmL5GZNQ3?=
 =?us-ascii?Q?+iDfMKuQbVZNBcXcJxadVu/7JFRO8OM6YX8mygxI84ZOyjAYQBCBOhA5iXQF?=
 =?us-ascii?Q?kjWG63KDLhN4/6QbjFzRBuwj5PlUJAE+pRbFd7+oYzP2dzC9DsuSd2WgbRzO?=
 =?us-ascii?Q?ya+RR/hEfEGaRTOE9lfv4NJ21wQN5CIrHbjInlApdAy+AhnpnMrkcLvzPYlr?=
 =?us-ascii?Q?8WxjmN7oyx8SrV9Lgn+hLkYguWUhA+F8wcPMGPH//Gu44xuxeWW1DGBhhsty?=
 =?us-ascii?Q?xqQ/VB5qFS4/4bm8t4YXGrA+fiVy8JxnQFVB3Bs35FJ43CWpsHhJm+DYM9QQ?=
 =?us-ascii?Q?YjSeIA04mCoMsjAf09jnu2d5VRdY47KhkOxFuA/XT1N3NldwLnmM0DvBDIqj?=
 =?us-ascii?Q?SzbZpsH5ai4RSQn3uW0fSiZ03yVJ2esbrzmScU4K+pUxtlvdXyDPbhpeFHcK?=
 =?us-ascii?Q?OqJNRXt19pA8x3D/jfD5ikAJ1kIT76rgPAEISbUu13qG2gxxoiiss+FU1zq3?=
 =?us-ascii?Q?6HpOc4cp7BlPcTjK3XGHxH+s1T3fd6FtLyqShcgmNNii9uLVhed4/kphgXy7?=
 =?us-ascii?Q?dZUrzHUjqZSupMFi4OTs0wRN7JSyyzfT4u856HnwhcI+AracUbSa48+HgTv4?=
 =?us-ascii?Q?QMM79gDNRnJQ9uWOIRySif+kEbFQhssknWa77ndqCGTOO/3b727LfvJHItVl?=
 =?us-ascii?Q?MLDUhsiJ4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b27afe-75dd-495f-c769-08de7489549b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:17:11.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkgjzL8bt3JXx4fadlo/P0PTk45UY6bVYhLIBvqG4O+0YU7DaiF56AytZAyT0zPYdb5KGv61ZW1SjFreM2QtpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10015
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9085-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 46C9019A761
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:23PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The driver lists (ld_free, ld_queue) are used in
> rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
> rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
> the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
> and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
> these functions also check whether the lists are empty and update or
> remove list entries.
>
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v8:
> - none
>
> Changes in v7:
> - none
>
> Changes in v6:
> - none
>
> Changes in v5:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 57 ++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 3dde4b006bcc..36f5fc80a17a 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
> @@ -453,6 +454,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
>  		if (!desc)
>  			break;
>
> +		/* No need to lock. This is called only for the 1st client. */
>  		list_add_tail(&desc->node, &channel->ld_free);
>  		channel->descs_allocated++;
>  	}
> @@ -508,18 +510,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	dev_dbg(dmac->dev, "%s channel: %d src=0x%pad dst=0x%pad len=%zu\n",
>  		__func__, channel->index, &src, &dest, len);
>
> -	if (list_empty(&channel->ld_free))
> -		return NULL;
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		if (list_empty(&channel->ld_free))
> +			return NULL;
> +
> +		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
>
> -	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
> +		desc->type = RZ_DMAC_DESC_MEMCPY;
> +		desc->src = src;
> +		desc->dest = dest;
> +		desc->len = len;
> +		desc->direction = DMA_MEM_TO_MEM;
>
> -	desc->type = RZ_DMAC_DESC_MEMCPY;
> -	desc->src = src;
> -	desc->dest = dest;
> -	desc->len = len;
> -	desc->direction = DMA_MEM_TO_MEM;
> +		list_move_tail(channel->ld_free.next, &channel->ld_queue);
> +	}
>
> -	list_move_tail(channel->ld_free.next, &channel->ld_queue);
>  	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>  }
>
> @@ -535,27 +540,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	int dma_length = 0;
>  	int i = 0;
>
> -	if (list_empty(&channel->ld_free))
> -		return NULL;
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		if (list_empty(&channel->ld_free))
> +			return NULL;
>
> -	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
> +		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
>
> -	for_each_sg(sgl, sg, sg_len, i) {
> -		dma_length += sg_dma_len(sg);
> -	}
> +		for_each_sg(sgl, sg, sg_len, i)
> +			dma_length += sg_dma_len(sg);
>
> -	desc->type = RZ_DMAC_DESC_SLAVE_SG;
> -	desc->sg = sgl;
> -	desc->sgcount = sg_len;
> -	desc->len = dma_length;
> -	desc->direction = direction;
> +		desc->type = RZ_DMAC_DESC_SLAVE_SG;
> +		desc->sg = sgl;
> +		desc->sgcount = sg_len;
> +		desc->len = dma_length;
> +		desc->direction = direction;
>
> -	if (direction == DMA_DEV_TO_MEM)
> -		desc->src = channel->src_per_address;
> -	else
> -		desc->dest = channel->dst_per_address;
> +		if (direction == DMA_DEV_TO_MEM)
> +			desc->src = channel->src_per_address;
> +		else
> +			desc->dest = channel->dst_per_address;
> +
> +		list_move_tail(channel->ld_free.next, &channel->ld_queue);
> +	}
>
> -	list_move_tail(channel->ld_free.next, &channel->ld_queue);
>  	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>  }
>
> --
> 2.43.0
>

