Return-Path: <dmaengine+bounces-11011-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODqEIrhLGGr4iggAu9opvQ
	(envelope-from <dmaengine+bounces-11011-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:05:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416A5F358C
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BB6E311FEEA
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D204282F30;
	Thu, 28 May 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DT2ZKaEF"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011024.outbound.protection.outlook.com [52.101.125.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3223F417;
	Thu, 28 May 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976360; cv=fail; b=n4RINDR2wjCU6RzbZhFSGyO7E68toAPfbAqnYv1gkIpE2DXt0be4hc77+tSCbRXWhgsDa2IQPMzjdxuMvuSqXs20PEPKOGQyGEvALKVVFo0OzNK6YWs31kFb1Nonle3igKNp15/rclbDfR0DRVzbcw0G0v6GVbWjldqHbBqpteo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976360; c=relaxed/simple;
	bh=BACwCvziaVrd4EUmnPoXfWUDFnHX6wfzqzuNW7BZ1JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qgMOLDO9fGF8mFD1YuTMUKals5k484Z6DsBMZQurKsCROgdHGXSlaLx7d3VYXdp2px2W5McMUEmF1QgSeEF4HzuEQ095rliRTufFt6lX3g+RXE5y8jaKt1BNItKs46yGQ3qeL+xAfXdh6zAcrBA/UihGxdIqJxUajZdYE9B3lAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DT2ZKaEF; arc=fail smtp.client-ip=52.101.125.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGaYwiOjXvkKG2pxKdoGVgStWHqkoUe+AkaE04trMsmpsG80MiuPrmfWC8GtQ4400JBxmhffH503CtkQaxvxaJODxtREcn5DwAJjjMeUGItUnQafHNbeKy1Ht7d7Ooe4eZyB0laS41CKqoAHKUesMQvn1rLaVQf9UAolh0hRVSMdeSdzGcwePcOyef8BwEZOnL6INX7zU8adCSChAjW8Xw7xwylxoA37LdiNbERCnMDR/j9MYpuY8dPbW5KKFCYa1eo3jKGnqDiGaPXxLd4CZPsLDYEzf8au0QZaM+ZnLFiPZGDJMs5W9PhuqojKtShP7FvgPnvxX1xLOLtszOXylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfeq3SQYqFuj5ANy6Y5DoAKF2WAq9ncemjONf/pe4VA=;
 b=Jzx5mFxx8Yu7EwHd/QFTws2H4Qy3zQ8kyY8OIvZ0Y/E5UuDkWD+Oy61VgeZHrUD3GKqLJNmHZy/Wp3OIwDF/drXX7CP+Dz8J5I+24DqyXivinS3gGChMCYTiuDLCvYRQMtNNKJdvaS8icNy21IHn6pPeEAzO6/RYqEJwzjTewXO621new4A1wYJWKPIFl93gkbX7ikPYCpxE8oRuZuiIx2aOwJgGGX1zf6hpW1cByIrfN5JCJlamw9JN7rXGDMXFJAsOb+bj97F1DpDyJGkbpqWW9SXLDM7xJgL7oVb/eZo7QhN4rDn2Kkhq8GJ9ioK81JZt8XD1/JUnDrJ00iQaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfeq3SQYqFuj5ANy6Y5DoAKF2WAq9ncemjONf/pe4VA=;
 b=DT2ZKaEF93F2WmNeN9axeZhvhvKK6Nefcr2KaTzLQavtEHKJWguofxQNZ7oC8c+jMqq/5NLthRXMnpo8RRuYTIOEGEf1KKgzD19XKQ0ED8wWYxQCGIdmqx31yw182VS9OHTMbm+m0yN4u4gRvPO6I9V/BKtWPV0nu+3Z9HeqKX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:52:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:52:36 +0000
Date: Thu, 28 May 2026 15:52:22 +0200
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
Subject: Re: [PATCH v6 14/18] dmaengine: sh: rz-dmac: Add runtime PM support
Message-ID: <ahhIlt8PSF6_DoRU@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-15-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-15-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5332e1-303c-4a54-aa43-08debcc05fa0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	z9qmO2FiGqw1sPcnSlM5FV5QhZNSGmUPE5RFl7MPE4rR0/CSyuqXR29oUVtasWEJvlnkzhm9hmgt7K50Kl9K0tOLajw6DBlLTl8r3/GrXQ12/G2SDpxXlFchYTjTFQh1CQmnHVu1hTsWduohtxEmjS8umC7m1zAEXlXT8FPtotf7gzQNB8jLqI8P1vOd1TTYXVnzznDaBS7wQCXkIs+rHKJQX3uEZI606FR4zbwcbeUtt6x9iOKOdboX8e+7JjXgBGusE503dgWkjbMscgvqhpjDWZZJB1vN14SqUPX3mPW7euNj2meUp+wS37jzDOQhK746+XIldLHlEvbXTZsiW40/uzfzBO76Lm3KtqfP8LXhWEAhwAeeyij+8exu4m6iAi/JZ+BvMjtvfbZg5NvfFAAMrN+IQ6A/S3MZjl+sc8IZ/c0H9IUIFXOpz1JIY3A1EFcElG5I1FVMhvCn2XXxR+LEYLEYIce6Crcgz9INejd9dDwSzYX4UWlWEYGW0dSvrEX/Y9cBc9B1LvMwan7OavsEkYbfxbkAbndC1sm5pWekZWsUvgijbPQ2PGsZeWL6F5+qy10xZu7pnJT+nMzraQOQRBKdf3jCo3RsP01hvJfdk9Sd8hsgYiMZgYsybF1iDRNPU9dgkV9zYz0LBq08jvVhi2+rvNGVejvcVWWrAgxCS/OlH9kzLKoG/kD7l9gqEshdjn0WV52xEVIE5ce0oHKWB4KUXiWZevSxTX8ZjmcDhwwXiexTCC5kgiFZ/1C7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tt1P95KUQK9ac2BVv6AzcFhLw2qWoW5rJed19K5EKZ/AoCSbeGOF7sGQxG8W?=
 =?us-ascii?Q?golgRziJPNd8kN94mTIn9MTCSshEOHbK208FAxSz1uxSK4RRnUR2to/mtMKl?=
 =?us-ascii?Q?leYVXaztdajWwqLzFkAQBuinh/O9EWH5d+8dV+MewVDB63CE7zwPsW5Ne7b3?=
 =?us-ascii?Q?cLfCnmGmBbVAyoLHKPXD5RWWAl1YZBQQrP3RUfLuryYc9HteOsdYSaXDzi1r?=
 =?us-ascii?Q?xZ4gIdvGucLenc5xNPFUXYO+0UgprS2uNp4MSK5hAccl/wc3v1CjDnugt94a?=
 =?us-ascii?Q?rvBtjTUsK/Uq/JwNCd+XC4AoBSF21tvlyi4MXfN1Jz9XwU6+MZs018EQUSXU?=
 =?us-ascii?Q?mxkKPWjAuNWvQfRaCbWHcnVkT0s5k3k/q4VSrFeVNUZVCmAHOyJU3Jz2WogN?=
 =?us-ascii?Q?4Y3JSa6wzfGWw5es08GWQljYxtG6C/biUtW9KlD23ochWHugiLmQCovFINNr?=
 =?us-ascii?Q?vC8+7xI8s7E/Z/74SK+DsF2CDb5uzn6HY/u+/4lEmGxjZUEGetyb1mAWjeAV?=
 =?us-ascii?Q?6/1T8eWF8PsqkQ2/SmiADRoCpNV4scBQJEP2ZK9txs+r+RmnuQWsCliioMxj?=
 =?us-ascii?Q?+f1M3quWlbuIjoi+yGTBaFFaJdXkGfq0iGeHzwtByIiTo40U2iQ1Ox9cJy1y?=
 =?us-ascii?Q?C3YnJkNCgvWzU47H1G0AFocDKvwHGa0jrwhfen+wtgDzBOPA0enAFrUzaEjX?=
 =?us-ascii?Q?PeeCpjWwaQ7UJcq2We5X6wDNHw6wDnYvQG0wQZrUrbdbOBbcGoH+FaGatExu?=
 =?us-ascii?Q?99v6sg/DtVzeHN4hlNuPKPd/I79GQO5r9fj2vZfxRDzV8Fqh0k0TnPpEC1j5?=
 =?us-ascii?Q?Po5naedTFmPmC13YZ4vk7tM2zffxPs1RCPMrgfQhMOdldBlJ5D0+uijQydJj?=
 =?us-ascii?Q?SY6KVxwJNWLHYq1tzmF7iTrfCMqx3PXnbeYkSVv7LlCYGU1vUZpjM4hq3ZDO?=
 =?us-ascii?Q?7dF13gmFSnwe2/CvZ672OiLiPQHysvgAbhAL4nnZNmHlYCMZNF4tM9/jxs5t?=
 =?us-ascii?Q?yw3WD7Igk4rEDS3uolWQ9sIayzJOU/6k2nU8imn1T9+4Y04ulMiP4q84vSSl?=
 =?us-ascii?Q?RZs2pXnpxNBsDff5FF0QreOPIk/yCLYnKgNDne6ZVMrZmZut3Yy//3FR61de?=
 =?us-ascii?Q?wGvwraLZ7+wnwytn6kqDA4jP9Y/e2eQbUamOht8YS5PVy7NwIVbMN0LmEEyR?=
 =?us-ascii?Q?jxnJE8q17Lt4nx83UdhnHKcvqXRMIUDtFSmboAFKeUZyvzd72iSswRO5hAwC?=
 =?us-ascii?Q?ReKg+kLOeHLb0Ga2RHNnJGqVNSuv0KYmWsqix5sXbkfy4SQ0HL1urmEtfwrO?=
 =?us-ascii?Q?L6JREPynq4AolQDEoZspe5QSAVsxrkgY4BqZ4AW4zUm8u2DnSrtb0BBFrm0t?=
 =?us-ascii?Q?JasKjZjn1Qik+Pg3fIsHo4PAwdhyuetNf5uW/Jm0QH7+FpOZ2uqP5ED4m4xj?=
 =?us-ascii?Q?B4vSPihS8JGMZGndj/DXNKJ3qPp783nabGzQYKCUPiMpiYA5kDPBwFEXkZls?=
 =?us-ascii?Q?MBZMzo2bgpJHcIlzqx/42ErMhzQXE6M/seH3JhmjL4g/f0oxCju2r/N5a/Wz?=
 =?us-ascii?Q?OOkonFtPsMiWHityp/huJOe4MRGoXSg6J9u5t2qoyopjqOnrAIR+6Ujbav0d?=
 =?us-ascii?Q?sQm9A3w46zEpQc2hzK2RK+21GYBJnYOCsCqdE8xCLFelB6GQ4BuYuIYi+xnR?=
 =?us-ascii?Q?4Y21or+bkjlFaVFkdNSlkx1QliFqDOyKZ2+eqQmix6ZLVvRF6R6ZxpwJ3za7?=
 =?us-ascii?Q?ueXfw3TTtHBVNxigOAN7N1H9Bk+MkE86S08cxbMij2TzZf3BZJvw?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5332e1-303c-4a54-aa43-08debcc05fa0
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:52:36.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUcrGfOSQZZ9oF+l1bukor7YEgpBlfA731smWZ5qr+yhZoFbRT4P5u+4Lico4mAI+eRFVFC4XQUIJ8iP+CHPVyHQ+T/ShVPBrGKFo8MyFyumrNb1AACfmF04a7MRRAT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11011-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 8416A5F358C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:06AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Protect the driver exposed APIs with runtime PM suspend/resume calls
> before accessing HW registers. As the current driver leaves runtime PM
> enabled in probe, the purpose of the changes in this patch is to avoid
> accessing HW registers after a failed system suspend leaves the runtime
> PM state of the device improperly reinitialized.
> 
> In that case, the driver remains bound to the device, the APIs are still
> exposed, and any access to HW registers without runtime resuming the
> device may lead to synchronous aborts.
> 
> To avoid leaking resources in case of runtime PM failures, save the error
> code returned by PM_RUNTIME_ACQUIRE_ERR() in rz_dmac_terminate_all() and
> return it only at the end of the function to allow the cleanup code to
> run. A similar approach is used in rz_dmac_free_chan_resources().
> 
> Because some exposed APIs (e.g. ->device_terminate_all()) may be called
> from atomic context according to the documentation, mark the DMA device as
> pm_runtime_irq_safe().
> 
> This patch prepares the driver for suspend-to-RAM support.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated patch description
> - collected tags
> - in rz_dmac_free_chan_resources() and rz_dmac_terminate_all() don't touch
>   the HW registers if runtime resume failed but allow freeing resources
>   as suggested by sashiko; along with it added debug messages in case the
>   RPM resume failed
> - dropped the runtime resume from rz_dmac_xfer_desc() and move it instead
>   in rz_dmac_issue_pending() only to avoid calling rpm resume code in
>   interrupt path as, if we are in the interrupt path the device is sanely
>   in runtime resume state
> - moved the RPM resume code in from rz_dmac_tx_status to
>   rz_dmac_chan_get_residue(), as close as possible to the HW registers read
>   to avoid RPM resume in case the residue could be returned w/o interracting
>   with the HW
> - updated patch description
> 
> Changes in v5:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 60 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 93394b9934c8..bd4ca8e939f1 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -549,12 +549,22 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	struct rz_dmac_desc *desc, *_desc;
>  	unsigned long flags;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret) {
> +		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=%d\n!",
> +			dma_chan_name(chan), ret);
> +	}
>  
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>  
>  	rz_lmdesc_setup(channel, channel->lmdesc.base);
>  
> -	rz_dmac_disable_hw(channel);
> +	/*  Skip touching HW if RPM resume failed. Let the cleanup do its jobs. */
> +	if (!ret)
> +		rz_dmac_disable_hw(channel);
>  
>  	if (channel->mid_rid >= 0) {
>  		clear_bit(channel->mid_rid, dmac->modules);
> @@ -697,11 +707,22 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	unsigned long flags;
>  	LIST_HEAD(head);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret) {
> +		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=%d\n!",
> +			dma_chan_name(chan), ret);
> +	}
>  
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> -	rz_dmac_disable_hw(channel);
> +	/* Don't return if RPM failed. Let the cleanup do its jobs. */
> +	if (!ret)
> +		rz_dmac_disable_hw(channel);
>  	rz_lmdesc_setup(channel, channel->lmdesc.base);
>  
>  	if (channel->desc) {
> @@ -716,13 +737,20 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  	vchan_dma_desc_free_list(&channel->vc, &head);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void rz_dmac_issue_pending(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	unsigned long flags;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;
>  
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>  
> @@ -807,6 +835,11 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>  
>  	vchan_synchronize(&channel->vc);
>  
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;
> +
>  	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
>  				100, 100000, false, channel, CHSTAT, 1);
>  	if (ret < 0)
> @@ -866,6 +899,7 @@ static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_chan *cha
>  	struct rz_dmac_desc *desc = NULL;
>  	struct virt_dma_desc *vd;
>  	u32 crla, crtb, i;
> +	int ret;
>  
>  	vd = vchan_find_desc(&channel->vc, cookie);
>  	if (vd) {
> @@ -884,6 +918,11 @@ static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_chan *cha
>  		return 0;
>  	}
>  
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * We need to read two registers. Make sure the hardware does not move
>  	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
> @@ -965,6 +1004,13 @@ static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
>  static int rz_dmac_device_pause(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
>  
>  	guard(spinlock_irqsave)(&channel->vc.lock);
>  
> @@ -994,6 +1040,13 @@ static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  static int rz_dmac_device_resume(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
>  
>  	guard(spinlock_irqsave)(&channel->vc.lock);
>  
> @@ -1274,6 +1327,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
>  				     "failed to get resets\n");
>  
> +	pm_runtime_irq_safe(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0) {
> -- 
> 2.43.0
> 

