Return-Path: <dmaengine+bounces-11004-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KbGL/BIGGpoiggAu9opvQ
	(envelope-from <dmaengine+bounces-11004-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:53:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D10895F31DA
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 371D7301579E
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58D26B75B;
	Thu, 28 May 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="N48cCmMI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011001.outbound.protection.outlook.com [40.107.74.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFD21ABBB;
	Thu, 28 May 2026 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976188; cv=fail; b=UhKXCQDH0Av2CatVSCKO7/uJW3vV5imqyECJPClN4N+wxeoYYBzBbv7Un710nU8O8BaK6qxYXmkA87X3OVGEtMLLh9gEfabqDPWB1+XkMJEOef3hkcNYjNEOK7asHM7c10IZvZ4mula9MTVcD7LNKfr22YQwgPXU6AhKUg2kIFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976188; c=relaxed/simple;
	bh=xgy+Qc2zkeJetuiNA66+zkPXmHLqYJAHO8LosjkCwf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1E81LSaOFzYLJ2H9UfZVTIksr0hUp27SOU0qSf93sswreKG2JFwC55ffahyq4iMeMjhq9UUeS4T3gNGJvVPOFE6zuq6imEiYhZ1cWPQv6S4Z91lEMXNTaBZY6kvHh+FtCXQ/Vfee7srgWNgjvNYpJkAxqZLwj36rbKWSXrZ7zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=N48cCmMI; arc=fail smtp.client-ip=40.107.74.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emyLMpDIeTzljHWGzhWgdFWtq7A3ArOjahOW5LM75xMY9oOC7ecDVv4lRB1gzO8j2htRO7V+YhTHgdaCpEm+jqMJ5IswIGIIB5fA+Dj+5ahJGKbu3J2XxQLfKwolcsmP/fBQFXBEOJEqBNZe5c2R/xYwmW0hniOaRH1I8PfOcTD6DEldbotByxhpaX5Z1ptguO70eu0smgZkGXS5g9v1GAMMWRgeAAnwF9IINmB7IqBsncBUhy4wwMn4pyHIIpZxwSiosEIsvZFQuhJrUJyYnvLOjD2N8v4TH+x05vJ/fCbmYQUFK0JQGl5Cz/mzHk6zrteEt0i38rzeRODHvl9d2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyu2KLjbhdwOLwLQk/vgNkaomy1wv/hEWfajqn+eARY=;
 b=l2tl6muILiTOBAKCmMgy8lw4YgeHgOXIGNdztVpguDRetFpvljp4wff5AM4gF+xOCIUMCl1MQs1hm88XT7lScg/nCoxcliwm6LYYbwIL3GbFcdtIMs2m9d78DvxIEzN7bo+N7ynnilHg/PaA5TaKkkYyS/naYZ3t6M/wDB3Zh1KbMaXjVtBjaCl6cR7hLCm2VHX98aNG/TrA2mJ4z50cr7PIMO5mrl1CR6WXQahokT3eDA2rPnP/iBTmzzEYukA31AkagmfjL6RbMiiQZMOVqn11hwRzE8GAJLuHBA6PMDx7O1lXcxFR2/+VybjExuRamQZpxcUhJeuZ+GGci+Ib6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyu2KLjbhdwOLwLQk/vgNkaomy1wv/hEWfajqn+eARY=;
 b=N48cCmMIGXjE+BZIojdbwh+YbKcFVTQCWEnbDvX5zXv9balM/sUvA9zBHbKZnx3/JsEXYGMTKDLIQAX0LjX9Bo6yZ61f+Sqxi4OqTd/GvYU0WNO/BGTQSScE888HMwSl+KAeWNkz4Xf3GlBHWB35D5GE47yp25n5Oyki7liekQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:49:44 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:49:44 +0000
Date: Thu, 28 May 2026 15:49:30 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
	claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 09/18] dmaengine: sh: rz-dmac: Use virt-dma APIs for
 channel descriptor processing
Message-ID: <ahhH6vSmdX7Aca1N@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-10-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-10-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5547631e-af9e-4281-655f-08debcbff935
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	GQRUcJ58bh3Ate+xmy42nJ+pZoLoPJyM6otjSmE239wsVEQLxdL1kQEpNjBZKlTxwOQoTtZcYZdPd0Sn5kWlHWS66BVpRz1DxL6y3O0IHrDiK88Db3Cwu4KzgI7R6iEo5JAsE3kef1UvI8oi5N8JKNN5gAhRAPCVsJIeQrmUvq7PZxzwzh/q5NvTtDn+E42DeCi0amH99L41CzHizh9Bo1WxNVt6CTERiw33jY6Bp5OHpBtH/BeGgfhC7hnf2SaEJcKwwyXJXhNu7qznx0q8tt8uMZPK841zPvRrq4TgSfoiY+BSbTyXIBCswC76ZTUpTsNoZiArBHubp5s7ZETZnSlAeUAjkrJyQE4hlOkG3HwritENklg3tjsvp3G+N9ppN5MM/Ce9q3ioFIMWrl/idJb61sW6MIuEOpg1TiEQ/XJw8X5iNiluUj5Fq9F9WtvreUfOvfwsxMumEviMKCteKLP1VwNTpN+cR7/2FGaktFbINMCkit150m5F7WUFwvm1144/swTF4Jg5wZrgCqe38pYRUxNEAxKRGDlq0PbXI6kfyqdh7kL0WudC5ZY/gZoek/T/4BRM81JXLPhWuwvUqPyMvJC596B0Ni0X8bwSpEgD1Wi2ICRH8TYCKdkihrybmFUzyXfax5rjMgSu/jQtWrJlQZHOXMudf772KwBbf6SKim+UCoTt7BWDifWVCA/70JDeFVbAZdxOn0K/5g4qCkqwb2IEF5JHR7eCN/IarCA5ScM0OqNxvMB/Btpk7Rgm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vW68E7xk6M6ZrgkYVNbSZHaAeMP4jHvSbHNDAC2bwcnGolTqEAC02UjLFEzf?=
 =?us-ascii?Q?QSlYz1INb7aK+mR+81GuCmGzCQUVB6tIwFJ+ETgr7MCgQ3dNzH1q/qMgL+a5?=
 =?us-ascii?Q?tqWS/2afnuK++vYL1a+1TSWtde3drSGGag23UWLHN8ErzBn9uFThTdhpQhuK?=
 =?us-ascii?Q?9kCL9rgLZR5yIglnkCHQe4OVomaAuM5MAimm5q0CaMCi2bVsiuzySmkhx2yv?=
 =?us-ascii?Q?Ci+9Jm1peujdlb4Z32PUtLfMqQQ86aP6Ku5Why4AsmgHYv/wk6Pbj0eTTl6Q?=
 =?us-ascii?Q?K5TcPE/LSWC+GaEbX7Zz+Od3ciICITfMY893BrN6Dgp1xb3mc1FEK1fKXY9P?=
 =?us-ascii?Q?DSHbFzvmfTpyzjUz/WQ91LHxbIPmOFNC2a4YsU/Vme7pYZv7NdRUyjMa36UC?=
 =?us-ascii?Q?vPm9RLvx1gY8/SN9HwHLE+US+Am0uwZ7AU686MQUaD0ouxfK9tBW//sJRl/l?=
 =?us-ascii?Q?e8n5KLfMGFpNy/61yW/KS8eqLVymvF3Q/oOcZ1GC1ba2BEolhAv4j4uw8Mgk?=
 =?us-ascii?Q?+fWzF6SBL8wGijEIAZQDp2rxoALHuQUtEIq7nGvhzlz6xExufHWEkKtgy4dV?=
 =?us-ascii?Q?sEO5xbDB+ExYIEx2FNcrCt3pg75S7wOlDdymDqtnsIAQGU2wOH20dvxS3k8X?=
 =?us-ascii?Q?X7GAOPvTbW2UStCG4bsCQ6bnRqoJKAW/Cncl6i9oaRoxNOw0yGm0XO17yFV8?=
 =?us-ascii?Q?MVMLIC8AklGA1UCCDsihQbrstK5+q0e8BaDY4dqph1cwRxYL2IOecymj9BhM?=
 =?us-ascii?Q?aqqoraWunYUazuSMaVwqNgimqHWUMg7ZKnhCoTSLVZaRp13ft75zR7Q1t/0q?=
 =?us-ascii?Q?jrUXVd0F+jyveHoDRNCu0eGsPJZaVwdpSneBzrSLvjEFiDjvHTMxs1aGfnWw?=
 =?us-ascii?Q?OLkbaqXbBTAFD9Dc+fSnkH5WybMwk5nL3iusw2Xkpt9kVGcHCysY6cTwwkz+?=
 =?us-ascii?Q?yHyRFIv5TrQVFkus1NpOOuQbwUBl5hVB1FmrkAeCaNbr8CeXEtnO18tp6k0d?=
 =?us-ascii?Q?KUzWqNrAI9N3XE6NRVcyMkTZnCBpb5rcghtaODKUxd/4P6gjgDx8iPB2OZdl?=
 =?us-ascii?Q?nXg1nuLp45kCPPM5Y6hI74uXT1kN1jDmlasYrJThtrczsq3tC/WOPZX9kSU4?=
 =?us-ascii?Q?btTAgNXejmWw0AtpwzCPHKkSPyBjpZOcdJQsrK9Uq1oNXq2pg59ZbGTgfeS2?=
 =?us-ascii?Q?attPTZXfsEoDSiYvdGCx7vK9l3FU86h7wRrgsuSAR+g9S1Ik3sc4f7o2Hq9B?=
 =?us-ascii?Q?abepn5Qp6dnJ2VlHi4GRIZL2QeWNTpGF+aWniRDuM/cYDIEnHK0mJ/p2aXga?=
 =?us-ascii?Q?Fl3aGkhScCw6dbV/OHLkcLyjdIUx3SQBfq9C5d3YJyVOh08hfSTIdh5G/9yZ?=
 =?us-ascii?Q?dELTFKDM6XAK0RQjfsKKCiImD2Nvw2z1ifxGfrmwPlFrPcH626wW72YF8I11?=
 =?us-ascii?Q?ikRO1BlAKmWUSlnKyZX3h9m0OYlUncJc/95BgvBS/z4AL0qB3I4Soz9GeFOO?=
 =?us-ascii?Q?yjeAXvQ7W7PyWM1oPbpCWRfn1XonbSo6UJ3nK4uCO4zxrM0EOcfyRAtZTIa8?=
 =?us-ascii?Q?PfiwQPOGBRkAsJSPp5XPXe1+ywhZm/ME86WPnymmj1Uqlyvpe7gNyP4B9xi2?=
 =?us-ascii?Q?GUPHvjx/I2X+3Mbgi/o/u12LE4oWQEN2rFrPzPQKCjNCp2w5o3po7exLme9v?=
 =?us-ascii?Q?wZ1hRpDOHGPeEQLR30KUQJmr/gUvseB3IvcRAdNlKCrOa77vSObESRZLeGgI?=
 =?us-ascii?Q?RWaUwCjOJ7zuZF2N26oHcMCUjV0yDTlFvC2BTzujP46z9RBanA3f?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5547631e-af9e-4281-655f-08debcbff935
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:49:44.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmZR/MjAXsR1jD7u4FiYhCbpkfxI4ip2ST8tA5STf4rdX3Q8St+ho/8yZxc4xftRApoGpGkK7/mt9t/iOkA/3vcglTc4hopz+2kpf0VhiZ3Pr7AiKF5bE094FJ+MOlBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11004-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D10895F31DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:01AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The driver used a mix of virt-dma APIs and driver specific logic to
> process descriptors. It maintained three internal queues: ld_free,
> ld_queue, and ld_active as follows:
> - ld_free: stores the descriptors pre-allocated at probe time
> - ld_queue: stores descriptors after they are taken from ld_free and
>   prepared. At the same time, vchan_tx_prep() queues them to
>   vc->desc_allocated. The vc->desc_allocated list is then checked in
>   rz_dmac_issue_pending() and rz_dmac_irq_handler_thread() before
>   starting a new transfer via rz_dmac_xfer_desc(). In turn,
>   rz_dmac_xfer_desc() grabs the next descriptor from vc->desc_issued and
>   submits it for transfer
> - ld_active: stores the descriptors currently being transferred
> 
> The interrupt handler moved a completed descriptor to ld_free before
> invoking its completion callback. Once returned to ld_free, the
> descriptor can be reused to prepare a new transfer. In theory, this
> means the descriptor could be re-prepared before its completion
> callback is called.
> 
> Commit fully back the driver by the virt-dma APIs. With this, only ld_free
> need to be kept to track how many free descriptors are available. This
> is now done as follows:
> - the prepare stage removes the first descriptor from the ld_free and
>   prepares it
> - the completion calls for it vc->desc_free() (rz_dmac_virt_desc_free())
>   which re-adds the descriptor at the end of ld_free
> 
> With this, the critical areas in prepare callbacks were minimized to only
> getting the descriptor from the ld_free list.
> 
> Introduce struct rz_dmac_chan::desc to keep track of the currently
> transferred descriptor. It is cleared in rz_dmac_terminate_all(),
> referenced from rz_dmac_issue_pending() to determine whether a new transfer
> can be started, and from rz_dmac_irq_handler_thread() once a descriptor has
> completed. Finally, the rz_dmac_device_synchronize() was updated with
> vchan_synchronize() call to ensure the terminated descriptor is freed and
> the tasklet is killed.
> 
> With this, residue computation is also simplified, as it can now be
> handled entirely through the virt-dma APIs.
> 
> The spin_lock/unlock operations from rz_dmac_irq_handler_thread() were
> replaced by guard as the final code after rework is simpler this way.
> 
> As subsequent commits will set the Link End bit on the last descriptor
> of a transfer, rz_dmac_enable_hw() is also adjusted as part of the full
> conversion to virt-dma APIs. It no longer checks the channel enable
> status itself; instead, its callers verify whether the channel is
> enabled and whether the previous transfer has completed before starting
> a new one.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated patch description as suggested in the review process
> - collected tags
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - in rz_dmac_tx_status(): return DMA_PAUSED if the channel is paused;
>   call rz_dmac_chan_get_residue() only if status is not complete
> 
> Changes in v3:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 233 +++++++++++++++------------------------
>  1 file changed, 86 insertions(+), 147 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 217657513fa7..1f884ec101f8 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -79,8 +79,6 @@ struct rz_dmac_chan {
>  	int mid_rid;
>  
>  	struct list_head ld_free;
> -	struct list_head ld_queue;
> -	struct list_head ld_active;
>  
>  	struct {
>  		struct rz_lmdesc *base;
> @@ -299,7 +297,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	u32 nxla;
>  	u32 chctrl;
> -	u32 chstat;
>  
>  	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
>  
> @@ -307,14 +304,11 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  
>  	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
>  
> -	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
> -	if (!(chstat & CHSTAT_EN)) {
> -		chctrl = (channel->chctrl | CHCTRL_SETEN);
> -		rz_dmac_ch_writel(channel, nxla, NXLA, 1);
> -		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> -		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> -		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
> -	}
> +	chctrl = (channel->chctrl | CHCTRL_SETEN);
> +	rz_dmac_ch_writel(channel, nxla, NXLA, 1);
> +	rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> +	rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> +	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
>  }
>  
>  static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
> @@ -426,18 +420,20 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  	channel->chctrl = CHCTRL_SETEN;
>  }
>  
> -static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> +static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>  {
> -	struct rz_dmac_desc *d = chan->desc;
>  	struct virt_dma_desc *vd;
>  
>  	vd = vchan_next_desc(&chan->vc);
> -	if (!vd)
> -		return 0;
> +	if (!vd) {
> +		chan->desc = NULL;
> +		return;
> +	}
>  
>  	list_del(&vd->node);
> +	chan->desc = to_rz_dmac_desc(vd);
>  
> -	switch (d->type) {
> +	switch (chan->desc->type) {
>  	case RZ_DMAC_DESC_MEMCPY:
>  		rz_dmac_prepare_desc_for_memcpy(chan);
>  		break;
> @@ -445,14 +441,9 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>  	case RZ_DMAC_DESC_SLAVE_SG:
>  		rz_dmac_prepare_descs_for_slave_sg(chan);
>  		break;
> -
> -	default:
> -		return -EINVAL;
>  	}
>  
>  	rz_dmac_enable_hw(chan);
> -
> -	return 0;
>  }
>  
>  /*
> @@ -494,8 +485,6 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>  	rz_lmdesc_setup(channel, channel->lmdesc.base);
>  
>  	rz_dmac_disable_hw(channel);
> -	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> -	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>  
>  	if (channel->mid_rid >= 0) {
>  		clear_bit(channel->mid_rid, dmac->modules);
> @@ -504,13 +493,19 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>  
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  
> +	vchan_free_chan_resources(&channel->vc);
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +
>  	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
> +		list_del(&desc->node);
>  		kfree(desc);
>  		channel->descs_allocated--;
>  	}
>  
>  	INIT_LIST_HEAD(&channel->ld_free);
> -	vchan_free_chan_resources(&channel->vc);
> +
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  }
>  
>  static struct dma_async_tx_descriptor *
> @@ -529,15 +524,15 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		if (!desc)
>  			return NULL;
>  
> -		desc->type = RZ_DMAC_DESC_MEMCPY;
> -		desc->src = src;
> -		desc->dest = dest;
> -		desc->len = len;
> -		desc->direction = DMA_MEM_TO_MEM;
> -
> -		list_move_tail(channel->ld_free.next, &channel->ld_queue);
> +		list_del(&desc->node);
>  	}
>  
> +	desc->type = RZ_DMAC_DESC_MEMCPY;
> +	desc->src = src;
> +	desc->dest = dest;
> +	desc->len = len;
> +	desc->direction = DMA_MEM_TO_MEM;
> +
>  	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>  }
>  
> @@ -558,22 +553,22 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		if (!desc)
>  			return NULL;
>  
> -		for_each_sg(sgl, sg, sg_len, i)
> -			dma_length += sg_dma_len(sg);
> +		list_del(&desc->node);
> +	}
>  
> -		desc->type = RZ_DMAC_DESC_SLAVE_SG;
> -		desc->sg = sgl;
> -		desc->sgcount = sg_len;
> -		desc->len = dma_length;
> -		desc->direction = direction;
> +	for_each_sg(sgl, sg, sg_len, i)
> +		dma_length += sg_dma_len(sg);
>  
> -		if (direction == DMA_DEV_TO_MEM)
> -			desc->src = channel->src_per_address;
> -		else
> -			desc->dest = channel->dst_per_address;
> +	desc->type = RZ_DMAC_DESC_SLAVE_SG;
> +	desc->sg = sgl;
> +	desc->sgcount = sg_len;
> +	desc->len = dma_length;
> +	desc->direction = direction;
>  
> -		list_move_tail(channel->ld_free.next, &channel->ld_queue);
> -	}
> +	if (direction == DMA_DEV_TO_MEM)
> +		desc->src = channel->src_per_address;
> +	else
> +		desc->dest = channel->dst_per_address;
>  
>  	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>  }
> @@ -588,8 +583,11 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
>  	rz_dmac_disable_hw(channel);
>  	rz_lmdesc_setup(channel, channel->lmdesc.base);
>  
> -	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> -	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> +	if (channel->desc) {
> +		vchan_terminate_vdesc(&channel->desc->vd);
> +		channel->desc = NULL;
> +	}
> +
>  	vchan_get_all_descriptors(&channel->vc, &head);
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  	vchan_dma_desc_free_list(&channel->vc, &head);
> @@ -600,25 +598,16 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
>  static void rz_dmac_issue_pending(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> -	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> -	struct rz_dmac_desc *desc;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>  
> -	if (!list_empty(&channel->ld_queue)) {
> -		desc = list_first_entry(&channel->ld_queue,
> -					struct rz_dmac_desc, node);
> -		channel->desc = desc;
> -		if (vchan_issue_pending(&channel->vc)) {
> -			if (rz_dmac_xfer_desc(channel) < 0)
> -				dev_warn(dmac->dev, "ch: %d couldn't issue DMA xfer\n",
> -					 channel->index);
> -			else
> -				list_move_tail(channel->ld_queue.next,
> -					       &channel->ld_active);
> -		}
> -	}
> +	/*
> +	 * Issue the descriptor. If another transfer is already in progress, the
> +	 * issued descriptor will be handled after the current transfer finishes.
> +	 */
> +	if (vchan_issue_pending(&channel->vc) && !channel->desc)
> +		rz_dmac_xfer_desc(channel);
>  
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  }
> @@ -676,13 +665,13 @@ static int rz_dmac_config(struct dma_chan *chan,
>  
>  static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
>  {
> -	/*
> -	 * Place holder
> -	 * Descriptor allocation is done during alloc_chan_resources and
> -	 * get freed during free_chan_resources.
> -	 * list is used to manage the descriptors and avoid any memory
> -	 * allocation/free during DMA read/write.
> -	 */
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(vd->tx.chan);
> +	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> +	struct rz_dmac_desc *desc = to_rz_dmac_desc(vd);
> +
> +	guard(spinlock_irqsave)(&vc->lock);
> +
> +	list_add_tail(&desc->node, &channel->ld_free);
>  }
>  
>  static void rz_dmac_device_synchronize(struct dma_chan *chan)
> @@ -692,6 +681,8 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>  	u32 chstat;
>  	int ret;
>  
> +	vchan_synchronize(&channel->vc);
> +
>  	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
>  				100, 100000, false, channel, CHSTAT, 1);
>  	if (ret < 0)
> @@ -739,58 +730,22 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
>  static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  				    dma_cookie_t cookie)
>  {
> -	struct rz_dmac_desc *current_desc, *desc;
> -	enum dma_status status;
> +	struct rz_dmac_desc *desc = NULL;
> +	struct virt_dma_desc *vd;
>  	u32 crla, crtb, i;
>  
> -	/* Get current processing virtual descriptor */
> -	current_desc = list_first_entry_or_null(&channel->ld_active,
> -						struct rz_dmac_desc, node);
> -	if (!current_desc)
> -		return 0;
> -
> -	/*
> -	 * If the cookie corresponds to a descriptor that has been completed
> -	 * there is no residue. The same check has already been performed by the
> -	 * caller but without holding the channel lock, so the descriptor could
> -	 * now be complete.
> -	 */
> -	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
> -	if (status == DMA_COMPLETE)
> -		return 0;
> -
> -	/*
> -	 * If the cookie doesn't correspond to the currently processing virtual
> -	 * descriptor then the descriptor hasn't been processed yet, and the
> -	 * residue is equal to the full descriptor size. Also, a client driver
> -	 * is possible to call this function before rz_dmac_irq_handler_thread()
> -	 * runs. In this case, the running descriptor will be the next
> -	 * descriptor, and will appear in the done list. So, if the argument
> -	 * cookie matches the done list's cookie, we can assume the residue is
> -	 * zero.
> -	 */
> -	if (cookie != current_desc->vd.tx.cookie) {
> -		list_for_each_entry(desc, &channel->ld_free, node) {
> -			if (cookie == desc->vd.tx.cookie)
> -				return 0;
> -		}
> -
> -		list_for_each_entry(desc, &channel->ld_queue, node) {
> -			if (cookie == desc->vd.tx.cookie)
> -				return desc->len;
> -		}
> -
> -		list_for_each_entry(desc, &channel->ld_active, node) {
> -			if (cookie == desc->vd.tx.cookie)
> -				return desc->len;
> -		}
> +	vd = vchan_find_desc(&channel->vc, cookie);
> +	if (vd) {
> +		/* Descriptor has been issued but not yet processed. */
> +		desc = to_rz_dmac_desc(vd);
> +		return desc->len;
> +	} else if (channel->desc && channel->desc->vd.tx.cookie == cookie) {
> +		/* Descriptor is currently processed. */
> +		desc = channel->desc;
> +	}
>  
> -		/*
> -		 * No descriptor found for the cookie, there's thus no residue.
> -		 * This shouldn't happen if the calling driver passes a correct
> -		 * cookie value.
> -		 */
> -		WARN(1, "No descriptor for cookie!");
> +	if (!desc) {
> +		/* Descriptor was not found. May be already completed by now. */
>  		return 0;
>  	}
>  
> @@ -813,7 +768,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	 * Calculate number of bytes transferred in processing virtual descriptor.
>  	 * One virtual descriptor can have many lmdesc.
>  	 */
> -	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc, crla);
> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
>  }
>  
>  static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> @@ -824,21 +779,17 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  	enum dma_status status;
>  	u32 residue;
>  
> -	status = dma_cookie_status(chan, cookie, txstate);
> -	if (status == DMA_COMPLETE || !txstate)
> -		return status;
> -
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		status = dma_cookie_status(chan, cookie, txstate);
> +		if (status == DMA_COMPLETE || !txstate)
> +			return status;
> +
>  		residue = rz_dmac_chan_get_residue(channel, cookie);
>  
> -		if (rz_dmac_chan_is_paused(channel))
> +		if (status == DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
>  			status = DMA_PAUSED;
>  	}
>  
> -	/* if there's no residue and no paused, the cookie is complete */
> -	if (!residue && status != DMA_PAUSED)
> -		return DMA_COMPLETE;
> -
>  	dma_set_residue(txstate, residue);
>  
>  	return status;
> @@ -918,28 +869,18 @@ static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
>  static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
>  {
>  	struct rz_dmac_chan *channel = dev_id;
> -	struct rz_dmac_desc *desc = NULL;
> -	unsigned long flags;
> +	struct rz_dmac_desc *desc;
>  
> -	spin_lock_irqsave(&channel->vc.lock, flags);
> +	guard(spinlock_irqsave)(&channel->vc.lock);
>  
> -	if (list_empty(&channel->ld_active)) {
> -		/* Someone might have called terminate all */
> -		goto out;
> -	}
> +	desc = channel->desc;
> +	if (!desc)
> +		return IRQ_HANDLED;
>  
> -	desc = list_first_entry(&channel->ld_active, struct rz_dmac_desc, node);
>  	vchan_cookie_complete(&desc->vd);
> -	list_move_tail(channel->ld_active.next, &channel->ld_free);
> -	if (!list_empty(&channel->ld_queue)) {
> -		desc = list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
> -					node);
> -		channel->desc = desc;
> -		if (rz_dmac_xfer_desc(channel) == 0)
> -			list_move_tail(channel->ld_queue.next, &channel->ld_active);
> -	}
> -out:
> -	spin_unlock_irqrestore(&channel->vc.lock, flags);
> +	channel->desc = NULL;
> +
> +	rz_dmac_xfer_desc(channel);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1021,9 +962,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  
>  	channel->vc.desc_free = rz_dmac_virt_desc_free;
>  	vchan_init(&channel->vc, &dmac->engine);
> -	INIT_LIST_HEAD(&channel->ld_queue);
>  	INIT_LIST_HEAD(&channel->ld_free);
> -	INIT_LIST_HEAD(&channel->ld_active);
>  
>  	/* Initialize register for each channel */
>  	rz_dmac_disable_hw(channel);
> -- 
> 2.43.0
> 

