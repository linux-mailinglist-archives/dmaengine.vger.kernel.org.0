Return-Path: <dmaengine+bounces-10390-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Nu0Jt6dA2rm8AEAu9opvQ
	(envelope-from <dmaengine+bounces-10390-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:38:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5C52A6E5
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4DC23031282
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9EF382F2B;
	Tue, 12 May 2026 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cXhz8cjB"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB43803D7;
	Tue, 12 May 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621914; cv=fail; b=Jel9WHY1vOiyaUt2T7nQl6Cu3A09DJTmsr6sDjlfv7m08Zf0vB7clkb0T/jKRWwekXwK/An9dTwFEOaOSe/d99V+rtwA4l5DSStMWXs1qXcFW9XVVM+bUe5Cas88+CrZa2Lok960H0AbmToem1uXkty94+NN0d5UtnPXmyQBfzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621914; c=relaxed/simple;
	bh=2DYSfg9y3Ji8Jepi2Hs4v31nRvhYhVqAK3CDU0qr5sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LG52iO+St2dYUSAZgtCddAtDhbbOCRTaUoIbte3cFWYlpJyJLHw105Z8FFlE6h1mBzlko10uQsUFOfBd1pKZXe4CTuo1UHVOJGqIwmihF+LQ1gSPVfyUItJF3b5oLRu2S/6fVO3hIcje4bGMfbRajUmzTx1nsalf2Us7UA/JuRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cXhz8cjB; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMAPShPRE2GjtWIj4mfEEgs6BZQxuGJRi16hE50EZYsgBuLZw1H4nFMhnLeEcIypKhJ0hfKfZtVm6H9CURR2ma3+tk+op9/vYJ3URmxJu1aj0YnMAVjBKX/SBM5ailwwfgTOTYrJlcUIA8VMta+6bV0jHxqKEieOk8WGMI4LAf3ka19/UPvVaPet8cBi+UnbrKKukEHD9jyNZWbZD+HQP4vO26xt9M/OXGmdeVEIbQBT/XO0SeiNgnCHqkXQiN5FxgR2FTVRldosX9dgaXL6KMa+wNN3WWNc0dsOmx+4g1sZn2cVb/8HeN0WblthEiy3wT3BFbhwAUB9o3eNnYR9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isL92Y8FYI3TPcaUqJ/sHdpZxfpvBQp6vxaQsyBjcv8=;
 b=cViFXtxLWnkLSnS7VlhBt1vbjEBdC0BC9KzvTdcQkl1WHkYI5CQZvLAgkZAMURVRQ35QIjL+YGQ3GiTLpaJDZ4kaEk/7+6lIUYUljdB1KFv+gD95y+5YJcUSoW2xqIUDw0wgQXn7PfEMznBonpP0IsKhKzZn5Sw6W9ZUnENK/X3LudJ2bWN77YvoDDlDYFAap1rPZNolwD1KewiTOBbaYGXwDWg6y6Km/TEO3mfSwVXLXikHh3nTvJfjc+r+wQmfppLz5id4m2WubRD7hiKPyTfqfFRryh4lU8CRnOEIJ/UykKv0YJeiriUjFDVZSBt9ALprnPEaEHJtNXh/dHXWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isL92Y8FYI3TPcaUqJ/sHdpZxfpvBQp6vxaQsyBjcv8=;
 b=cXhz8cjBnu4GNX1brYjtiR6nL0ZZ4GRSyj/JNOQbctRN26Ffdf6iUAqAoGTLhL6DsTM76lLxiOILuHpkQpgnRuw0TRlJm32/1/gUgR7SyZkqq8gTf3E4Tuaj0Tlo5rcbcPgr64ezWGf911dvX3Z334csk1cyNFeXMIniI5JOW5i0yxR50YlMxguLsZJ3/iWe7b2TJo8HKAhXU8dtccOZvqhPM5xFe5fEuV6jdtZOIq9JHSSvvbtx8ZEWq3SigB1qrL1nGsKvDYzrd9E94cTXTXY0wvKe1tIE2sEvpoA7EgG+/bavD48hoTaD+MsyBUXTTFYVoEMJTEHjr+V5REnjGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS5PR04MB11370.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 21:38:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 21:38:30 +0000
Date: Tue, 12 May 2026 17:38:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 09/17] dmaengine: sh: rz-dmac: Use virt-dma APIs for
 channel descriptor processing
Message-ID: <agOdyrPVur-NGfhq@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-10-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-10-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS5PR04MB11370:EE_
X-MS-Office365-Filtering-Correlation-Id: 5226a2d4-1a16-4259-b61c-08deb06ecec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|18002099003|22082099003|11063799003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	2r2391uo9wXRE8D2X3X29MRRHrtIWmvFLs7e4AOmKeG36BYJf30MdPVuOHE7rImiQSCBIN4l+dmGj1okdtbZCeyvj58k44HsGVx2u3XmPqfvQb6CxrEI/1ZNxeO9uTE/spJfkdCjAcg5oj4k6hGsUO3u8l7qVtHGaDuUi4LAkelx0xeiKW0J7fAnlsL8HX5cYw+1OUg1JzFBpDhuf0mVFWjHnkxc/BZ/5TKcm+vC/2umOs/v+w3vZ8qYAo2I8iyiOl9dD3l0Lmj9gdOzfsGZul3PJB/llYtOHtJ6Pp5EUPeKhignAGkvm+LbDf4zfIMTCAeSy37Y6FSEvLZ0qGehhIElCPJNfa/sgRa3d2IAb434Vq0zwcqf6PsHnYIk5+o/1boHyp2B+1ymvqFEj2bnwb305gKE+TNR4VoqlBM5EO8nL+ZOj9jvFyMUUGJvpBsQOzB1PSESv/FIpO9e2NB0Bg9OZ/ghLvUU0xvR/bl5FHeAbUrBZrkpOFKD/yq2cxEtNpjquQfD6hAdN/hNFWC/RuGSv4WiqSIkK/kLVkwQBD7yzGLxvD+NFCpCxp3+2GOQx291CSYwFtlVVti8q3n8rUltGGSBCunpMe4lw52ezRkZtw3yvZ7kJEmT9I6ts05lC8yfoyHAH4Pc+BQUWSw/FdNlBk2BpnE50Zfx+HrDhbKOYHrSpSLNIFEuV7gGnAKUav7AwbjU1V3TjAY85YxDELVLh4QaotKaf3beVMIyXSIkTFkXsK4wUs3MERM4ciiy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yN+Tms35tBLqM7PgIfyaKQzK4zTXzRPEEPMrR0Q9DtsK7LWZBzSUJqAfgDa3?=
 =?us-ascii?Q?Pi0o6MGxeO+CvZIXC0XLUtjoTbyVh24oPvEw/Q9VM1AquEC/kjXsbOabj5vz?=
 =?us-ascii?Q?PIqL+KB0F2icZUWiFYmkTjUNvCtYk3qa4KVYap7/O8pF81W1m0yd9mt+/ehB?=
 =?us-ascii?Q?4Cb+eANo3zNoumPDs23YP2WHusYANsxHkHbwYoHOvEXi74APKff02o3u9EAw?=
 =?us-ascii?Q?bJQ4XxBoe9XZ8vkn9X58IIpK585yaksAdUmucQpf4a/b5VjMCfvCDxs0RE3o?=
 =?us-ascii?Q?d4Fyo94T3o7JtVXV3q2AS31eziaW8CBxu6j5ZpP3T9z6+ECpteJNJlXq4aWO?=
 =?us-ascii?Q?ktP+/Y5JKTHOfyPgABsSUmlDgltqNEQU+s42nrWuK3v6ljnTKR4qTM+9JBZQ?=
 =?us-ascii?Q?54DzIsINI3g/Z7g4pTvPxfK2I1jfNVeuMrZs2ElTqZGRIRpj30NDOXFHPCA1?=
 =?us-ascii?Q?oar4jGVi46ZF2dYK56/wuFIVArSQscETgLAJxwOoYym2P4igVGGjmWOXsoHq?=
 =?us-ascii?Q?ox3ZrPyWRvQJSwrsDKk9xIfxkG8f1xugQNxkFQEnZ4dXLKuOWOm9CRBF8WuX?=
 =?us-ascii?Q?i5/Ne0iJFORj5Ca3xP1BDabZPqU+BjN7OKCbACX0mKCg8V+xJvxbOzYey2KF?=
 =?us-ascii?Q?swtLOKeKA3a+IuzFe6DrVewUGZvUs0tmawQX/29sbJWU7C0Q1VN6drFsiwpj?=
 =?us-ascii?Q?XAzz1Ho4LHyelceGglKgTPvgXfrzSRcZ3GdR1V13fCE33esAWQl4Atar3qLh?=
 =?us-ascii?Q?m5BQ/JzElAo+4I+KdEI8hnbOct+mYCvqvxroZRcyreqU0xfQQhfPLDcybte6?=
 =?us-ascii?Q?FgkyVDfVvR2eswTGq0lqzXLA+fxf5g4N0U99BIMkZUO1Fox3sxNdsXwtLOnN?=
 =?us-ascii?Q?JlcQ06fwkDS9nxuKiwmlgUwvAUq4XH2ey4qrcmOdG8/rmHy5HIhtuqiYmKH3?=
 =?us-ascii?Q?W1wUMM3rR/plWvtXjnuZx4+cnbi83DOmN65+KBsSQHYVOZQNcLDpDC+wqoE1?=
 =?us-ascii?Q?4SUDkvtGofZ6VNdBW0qURoadKGWWfR9KQDzJ+u3N0UMkUJ2ZQhYGhPTr+yrH?=
 =?us-ascii?Q?nXxREdBY5GT3pmRiwvEk/aiDXkbn27BTtlp9n+vjITuroCB9zX0mE7cGKdkn?=
 =?us-ascii?Q?K0OxgHYQ4QodVpnf0jZLLKTQVHOhXP5Q9FW4TdZmKp1efYFMDkZsEDoBOdki?=
 =?us-ascii?Q?RvZI8hp1EudseiRQ6enKl7jPZADq3yQ1LLXwU4JENKBzRb7ct6HIVMAfgaqq?=
 =?us-ascii?Q?nBQgYcRXxInARO9Mw3EZlKjuJMq+vwpd4hI3PvtTGZdTGX7jj7vlTt9teZKl?=
 =?us-ascii?Q?GqR0J2f5uGTIdH4gzcIdmBuBuUilruFbmr51u277U+Xfm9GIoZpwWKw4JGDC?=
 =?us-ascii?Q?aP6cxxGTrdqBhfyIkytcxQiH0hSEEDAarf20I91+nJsULgIfO7Q9+lWPnU19?=
 =?us-ascii?Q?5nQeh/SX2/jb5J4qNUllM+DHGmC7WXcouQ83NDh7oEwqnApKF/RRcC2JI75B?=
 =?us-ascii?Q?JN7uDoCW4lPhhkGNcTUsWYrj+74DL41QnIarelQMcgs6p+9f/TQG/fSrM6jQ?=
 =?us-ascii?Q?YzXjLTCAZeKLyeqjKxJDERu/6F5gvEjS/doSsepJROWTESgQJj1e/oVcV2wR?=
 =?us-ascii?Q?2V5GnNBEEdZ8yY4WsjXA4vNQXEZtfxa1gz0jJIxWdvjFrE/RXIwJF+3N7vFC?=
 =?us-ascii?Q?7MpH09vOlXVACiohkfyDrKKm4TTgqF6NXgaAE8w+83nf8YVJBZ0OyFg+dTOu?=
 =?us-ascii?Q?zqlRHTgLJg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5226a2d4-1a16-4259-b61c-08deb06ecec7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 21:38:30.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jVMnYPTw2YmSgXW1gOv0bgr5i2gyL0ss0rkmu2pnCzNyKphEpCbrEBx4gwK7pVOW6CC7gqI1clSfOr16a5xcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11370
X-Rspamd-Queue-Id: 3FA5C52A6E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10390-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:10PM +0300, Claudiu Beznea wrote:
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

Do you plan remove ld_free also?

>
> This change introduces struct rz_dmac_chan::desc to keep track of the

Remove "this change", just Introduce ...

Frank
> currently transferred descriptor. It is cleared in
> rz_dmac_terminate_all(), referenced from rz_dmac_issue_pending() to
> determine whether a new transfer can be started, and from
> rz_dmac_irq_handler_thread() once a descriptor has completed. Finally,
> the rz_dmac_device_synchronize() was updated with vchan_synchronize()
> call to ensure the terminated descriptor is freed and the tasklet is
> killed.
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
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>

