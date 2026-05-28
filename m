Return-Path: <dmaengine+bounces-11013-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LONC7tVGGoQjQgAu9opvQ
	(envelope-from <dmaengine+bounces-11013-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:48:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06975F3EED
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5392B313830F
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED53EFFDD;
	Thu, 28 May 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TU2RlV3s"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011020.outbound.protection.outlook.com [40.107.74.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F82D8795;
	Thu, 28 May 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979122; cv=fail; b=LMuu7Sg2K6dnXcHPpU4WBfkLSWi5Nt5DzwWL6KsoGIzIyKuBJ/URVaq2RMbyhj06cSjb/8q4bnC7GYTumdSBmVI5WMkhRJHXmvtSxogEBJbtddt9cOMSP9uGx/I6+2iqNYad0zLanq5jFGSv+FZDh+d2m88ItjJ1jy4nwxnfEz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979122; c=relaxed/simple;
	bh=QXm0+vN9ClpZ+wZtCG/h3iPYJTsrpNTo/6P4rk7tLe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTYN2ofD0Kqe8MZiKeUPYNIY+s7Yv0y8F1EB+PTUka4sbBpzu0swWbgveb7tS6ErmwFKlGhIc9osCMy4aF+RLK4kMAFHhoQSc51pw/VoQoHAVOdZTrvJWm6yNLqzkdkPsUK1VmXbWLWU7V1+jScn2uHoedRnsn43BDnoDUmRNAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TU2RlV3s; arc=fail smtp.client-ip=40.107.74.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GczmqfmlZCqeUknmmnV9JccAHomCrTVsS85vGJst+ggXMSbwq/SIM0IlS8US9X/CPQ7v5PJPIuIDZo50ZTn+w7w0bcYsXNx/BIiM7E/0/oWNSGL8Erf43AFylxtPQPlQBzotXiZQIJqPQNoUeypIBh6QxzUXDdth35hyA55UZSzu8ZQcB8/FDEydOAibxSUUEZgzZND+RZwvG0pPxOGlwWyKSW72obR2bv168yxgqQtN9nLYd9QihixAxYA0iYwzAgXCLquJG1ks0C+oN7/TNMyvVNivUqM0uukZlSGScsDI1UkxYiRrTcYBrrRudzgJnK/AffHtZbRwk1KCgnWBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYlB2SDK1JjK0u/M8utjjceEnLyIPiWTtTMiGQ210C0=;
 b=X4gWT7URGhRzk+eVE+HeRWA5SLnkZXbMyD6sHNtpI8eR4sWKu+qQ22GLRwkOJu+Re1DGdtonIuC5o7b3iwezJ/12G7e+UixD+x5CERTS/2QEJFbE4pzTj/FKNk0LHBe6hP9HwCQHF7FGKC2hZc2c1esQPwGRDvWfeB1I/coK4NPPCvrfTMoYerjvnj2FTTUE3ZW+vwhzsNUKqMCjY7QfdXP79ixcwbISxTYlQdmHrIO9jCY1LAM9wOk0BrPpEumAgVJ93OXmW50kdmBxK2AYEzLea5IgcE3czr6omN5BAiXTP7TA8ETlnAdF3OLTZW6g8FlMHLiUcEQ9EYpDKE6zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYlB2SDK1JjK0u/M8utjjceEnLyIPiWTtTMiGQ210C0=;
 b=TU2RlV3sGBqb/31NJ/8iQZ4y/UNgyHgBgnnWiG+nCrE+39LtEfI8XJ2Xc5T1Wte1X4IvqLJiUDZsZpP74ca/Mo8ccHwbfz16HIE5Pjhyv3POUteI/fnWJi43cyXbQXM5u9TIIsXN646XiTomSNHs4mZ1IWwQlGVg62bx3Vu6X8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB15060.jpnprd01.prod.outlook.com (2603:1096:405:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:38:37 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:38:37 +0000
Date: Thu, 28 May 2026 16:38:18 +0200
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
Subject: Re: [PATCH v6 15/18] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Message-ID: <ahhTWpGqdCx-ZcZq@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-16-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-16-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR3P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB15060:EE_
X-MS-Office365-Filtering-Correlation-Id: e4912798-8430-40c6-5b18-08debcc6cd5b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8YLwSouPcmKwXagdx7/fiILO6QYv8AINemrasD5KLxjQprR8QfBlywUihhPCf0BQbbvpA52+RXswB7HGsHIFFz4H9ep26+3nT8K/oGU8VYQz/rGWmiw+abtwT647i3w2F1DYMg7MeQbfU3cdrRjMAikyWroXeGqKqW4Po7Z+7CKMs3OvZL5SwbSb9/gTidPArQf9JVAvEI0JoV0hXZbTG2/iqiNf4u7g6IAi7+2L9Tn5opCX6u8W4BZLxb0ThMXNhCfiDus5fFlkNMnGDX7G5//m4kZAkPsZfaWegc89aUCaj+T644bux3gDSagvwLgAUuK+aKEFg3NExBz3bDHjiSPEfn87oMl5DzC/feMoGTcmR/mYN/6FGMpLIl+pGkNoHaAMJregFucjGIRAlujXxmGmQDGpnfxSi8jGcBeWhXPg/I00NNI0suMX7zRzegysgJbMZ9Im92rBAIkgt02e4qTNI/+RnIJAe2Vfzb01Bj+KJUvnP/dmgY05lyoTMbyw0duNgBuC02JZ9jwnJSY+qMQk0VDHzf87zUpmXQpRrkiwbtTsKVBc3V0RUUIUWOmnR1MfVjWYmmxM9PIKNCwGNP8LyJVY4h00fpoYNGxFeYJQs4R5uOHdpX5SazlFDb1ARFFH5YrtWI2Qgi6oTh4370C80E51cWeC5A3U19tNrh00Kp2CEZyuLw8JzdkGtX26vbWdL99Q8q46RPe16dZaePrIGq9Iha6pCZK5itbvyWPzoK91jgITLPlXCJMb0vP7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?246ufLHD5DlV2NKOzZK+SDxGYLjS0igA3Dra+lIFsOjYL39W5tv6UUMakKzt?=
 =?us-ascii?Q?GaQ534Ugwn4XomZlqwoRaZezzT60ux0SZkykDllyPKya0hs33sWFhRqLKeRi?=
 =?us-ascii?Q?pzdY6X+Vbqwe7BLKZTb7+ddcrwisbxpGzcT1p8rry9dJsMuBws3OdiDUZVWN?=
 =?us-ascii?Q?7fWWsDUBAeEIrnQQ/gqoYHEil1AtDOtfW30neP15RCljK+z1BRzvkmY8ABJd?=
 =?us-ascii?Q?ecjD+XACHTOHqOXPhGwZpA5ikN5mvK/8INiJu6qIupZMYjSc4ePl85PK6G9/?=
 =?us-ascii?Q?uOkr442ZQC6lS/8tyZ/IxhSaTcISDEP00bmKwQNQZPXmExnj4d+OJPnUa5xq?=
 =?us-ascii?Q?T6wp8S+BcrtAkGLk2ymfzw/xa6/OdZxU0zW8R2Be1EcvsEX3NRrA7//u9hoQ?=
 =?us-ascii?Q?KwHYIEBl9ddvAsLKLNtnZH5/UNwVTV8ZJONlMegIGU0alUC4DT59LoMjS6HV?=
 =?us-ascii?Q?hvTaEeecy1pxIwh0AW2vbpSQLL4ESfoh8YvBxHZ1LUsUi1VOv7vE+JLGEIeT?=
 =?us-ascii?Q?C4gqG4mGVPPWp3MJ6+ZAS/hO4TJ1rOyQKxx1qoFmXpJ08tY6YB0ZCwwjvzDs?=
 =?us-ascii?Q?sSE+/vlZ04I/t2lk6aCAHb/IPfp2CJ9Lr6mY/8MmOvI03k2wvYtnTU5cHkH3?=
 =?us-ascii?Q?hGFnfJzi5VvVQlhrtl8bBkmwfjBJKLye6z4ro4vWr4RJ3yHNPcgKl88fW7nc?=
 =?us-ascii?Q?TB8dtdkYtFHOblN6hbbgoh3604vuL6ySg68xOIeQqhcbCJqs+B1jlPS3KxqX?=
 =?us-ascii?Q?SuUWzXw9H5fNr2oKjKuIeawWeAmsE0srk1O8Gt8WilMwBPssjP66h4F4Tc5P?=
 =?us-ascii?Q?2VBCh7H4RF/H4BRdfZQnOMfm+YNXaVeOsnPb58WZWp15xwA0nFyirGYCpT8U?=
 =?us-ascii?Q?xqtFVs8dVXfG0ZOmIwouFsWBrso2dGThNAmaTTNq68yw3/uCAVOEmVMKh4Co?=
 =?us-ascii?Q?bM7SCsiqfNO9foC4JaH8qzmbuPmzE9BLFWX1i6LjczlVatmU2N+KH2mypdPk?=
 =?us-ascii?Q?dYGhyX5nmdHMOOFSOIHZBpHxgZ8TBgpOt5lnipBg2cznEYbqPs0XqvGO6mgd?=
 =?us-ascii?Q?ELZ8UYnrEPlKBVSMD1OYd0r5mBX8R8WMZ1qEJ8ytdz5M2VC8TG2ZnkHNbsEc?=
 =?us-ascii?Q?XZXnkKCy8TucDlkApDAQT9e3qbicq0v5TTefvQshxbJBrCwbWjPSe1jE45Yr?=
 =?us-ascii?Q?HNumUbPjCSPmHKES6U/3Y+CZ8+opv+ugEEN3+4uy3skMY3pSGJ7A3ujS4j5A?=
 =?us-ascii?Q?6M9veYPXWNRpV08IxJn9vrnYO8OVCwegSPXpZk2BR4U8XAU9BGJEFjJPAFe0?=
 =?us-ascii?Q?OcpcFmDN5vF9u7/HQg7AOpaZkogF0Lt0FPss69j4xSL4fWR4ZAliOSYi3qbJ?=
 =?us-ascii?Q?4UwH+IpMnEnWa2e1zKY5uK/wlSZuIRQeFVGFc6nbT7UjoZDNEuayE+oGtkTX?=
 =?us-ascii?Q?+1tk9zAee2siuUbuFpBqbMtaEr92ad6zpj4DBzBAcB+1PzuPVyFpBEm2daZu?=
 =?us-ascii?Q?cIbWNZlBC8wKQ9FVBkzPyujkGFtAyYLj/BFIvSYR+ppBS1vFz3Czr4HCEMAh?=
 =?us-ascii?Q?FEArT3+SsGXahmK9j7hBr9q8rgTGNJZxJU5tyuTCzZNBw8Vid7Ez/jeBDWfZ?=
 =?us-ascii?Q?MMZYX6yKCvVbNoglBT9lC8u3k5nhodjjNmU5DGqnkG8WPsReMSGjLdInM7rI?=
 =?us-ascii?Q?Kj6+E6LOsca95y1CvhYBm4CKQbeg191x8Q0fb0WoNQtpSSyPxhAn4+hcA81z?=
 =?us-ascii?Q?toLGVse4C9mlqaCd9Xndv45ueDbcE6p0e/mCFPtWm9tyMVjsETmD?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4912798-8430-40c6-5b18-08debcc6cd5b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:38:37.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CGwIEnkQ6eMHn6aJ8hkZQw82UKb6BJjFUQpgCUUwMZp64LjEfDOrZx0PjmSy5Zy5ktlBrX4ynOvlDGDFMzVfe2IB3aVjC6/R6IRTl5d5I/RTcIrFyepUX135NkWK3pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15060
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11013-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A06975F3EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:07AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S SoC supports a power saving mode in which power to most
> of the SoC components is turned off, including the DMA IP. Add suspend to
> RAM support to save and restore the DMA IP registers.
> 
> Cyclic DMA channels require special handling. Since they can be paused and
> resumed during system suspend/resume, the driver restores additional
> registers for these channels during the system resume phase. If a channel
> was not explicitly paused during suspend, the driver ensures that it is
> paused and resumed as part of the system suspend/resume flow.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - collected tags
> - dropped rz_dmac_suspend_prepare() as I found issues with it and updated the
>   patch description
> - with it used DEFINE_SIMPLE_DEV_PM_OPS() for PM ops
> - used pm_ptr() instead of pm_sleep_ptr()
> 
> Changes in v5:
> - runtime PM enable in rz_dmac_suspend_prepare() and rz_dmac_suspend_recover()
> - initialize ret in rz_dmac_suspend()
> - in suspend/resume APIs changed the order b/w runtime PM and reset calls
>   to follow the sequence present in remove and probe
> - in rz_dmac_suspend(): take into account the error code returned by
>   pm_runtime_put_sync()
> - in rz_dmac_resume(): use "return errors ? : 0;" instead of
>   "return errors ? : ret;"
> 
> Changes in v4:
> - in rz_dmac_device_synchronize() kept the read_poll_timeout() as
>   this doesn't fail anymore with the proper status return from
>   ->device_tx_status() API in case the channel is paused; with it
>   the patch description was updated
> - keep the cleanup path in rz_dmac_suspend() simpler to avoid
>   confusion when using guard()
> - used SYSTEM_SLEEP_PM_OPS() as there is no need for having the
>   suspend/resume callbacks being called in NOIRQ phase
> 
> Changes in v3:
> - dropped RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED
> - dropped read_poll_timeout() from rz_dmac_device_synchronze() as
>   with audio drivers this times out all the time on suspend because
>   the audio DMA is already paused when the rz_dmac_device_synchronize()
>   is called; updated the commit description to describe this change
> - call rz_dmac_device_pause_internal() only if RZ_DMAC_CHAN_STATUS_PAUSED
>   bit is not set or the device is enabled in HW
> - updated rz_dmac_device_resume_set() to have it simpler and cover
>   the cases when it is called with the channel enabled or paused;
>   updated the comment describing the covered use cases
> - call rz_dmac_device_resume_internal() only if
>   RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL bit is set
> - in rz_dmac_chan_is_enabled() return -EAGAIN only if the channel is
>   enabled in HW
> - in rz_dmac_suspend_recover() drop the update of
>   RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED as this is not available anymore
> - in rz_dmac_suspend() call rz_dmac_device_pause_internal() unconditionally
>   as the logic is now handled inside the called function; also, do not
>   ignore anymore the failure of internal suspend and abort the suspend
>   instead
> - report channel internal resume failures in rz_dmac_resume()
> - use rz_dmac_disable_hw() instead of open coding it in rz_dmac_resume()
> - call rz_dmac_device_resume_internal() uncoditionally as the skip
>   logic is now handled in the function itself
> - use NOIRQ_SYSTEM_SLEEP_PM_OPS()
> - didn't collect Tommaso's Tb tag as the series was changed a lot since
>   v2
> 
> Changes in v2:
> - fixed typos in patch description
> - in rz_dmac_suspend_prepare(): return -EAGAIN based on the value returned
>   by vchan_issue_pending()
> - in rz_dmac_suspend_recover(): clear RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED for
>   non cyclic channels
> - in rz_dmac_resume(): call rz_dmac_set_dma_req_no() only for cyclic channels
> 
>  drivers/dma/sh/rz-dmac.c | 180 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 175 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index bd4ca8e939f1..2a7124e4aea3 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -69,10 +69,12 @@ struct rz_dmac_desc {
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
>   * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
> + * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through driver internal logic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
>  	RZ_DMAC_CHAN_STATUS_CYCLIC,
> +	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
>  };
>  
>  struct rz_dmac_chan {
> @@ -92,6 +94,10 @@ struct rz_dmac_chan {
>  	u32 chctrl;
>  	int mid_rid;
>  
> +	struct {
> +		u32 nxla;
> +	} pm_state;
> +
>  	struct list_head ld_free;
>  
>  	struct {
> @@ -1017,20 +1023,57 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
>  	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
>  }
>  
> +static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	/* Skip channels explicitly paused by consummers or disabled. */
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED) ||
> +	    !rz_dmac_chan_is_enabled(channel))
> +		return 0;
> +
> +	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
> +}
> +
>  static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  				     unsigned long clear_bitmask)
>  {
> -	int ret = 0;
>  	u32 val;
> +	int ret;
>  
>  	lockdep_assert_held(&channel->vc.lock);
>  
> -	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
> +	/*
> +	 * We can be:
> +	 *
> +	 * 1/ after the channel was paused by a consummer and now it
> +	 *    needs to be resummed
> +	 * 2/ after the channel was paused internally (as a result of
> +	 *    a system suspend with power loss or not)
> +	 * 3/ after the channel was paused by a consummer, the system
> +	 *    went through a system suspend (with power loss or not)
> +	 *    and the consummer wants to resume the channel
> +	 *
> +	 * To cover all the above cases we set both CLRSUS and SETEN.
> +	 *
> +	 * In case 1/ setting SETEN while the channel is still enabled
> +	 * is harmless for the controller.
> +	 *
> +	 * In case 2/ the channel is disabled when calling this function
> +	 * and setting CLRSUS is harmless for the controller as the
> +	 * channel is disabled anyway.
> +	 *
> +	 * In case 3/ the channel is disabled/enabled if the system
> +	 * went though a suspend with power loss/or not and setting
> +	 * CLRSUS/SETEN is harmless for the controller as the channel
> +	 * is enabled/disabled anyway.
> +	 */
> +
> +	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
>  
> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
>  	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -				       !(val & CHSTAT_SUS), 1, 1024, false,
> -				       channel, CHSTAT, 1);
> +				       ((val & (CHSTAT_SUS | CHSTAT_EN)) == CHSTAT_EN),
> +				       1, 1024, false, channel, CHSTAT, 1);
>  
>  	channel->status &= ~clear_bitmask;
>  
> @@ -1056,6 +1099,16 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
>  	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
>  }
>  
> +static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
> +		return 0;
> +
> +	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -1421,6 +1474,122 @@ static void rz_dmac_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
> +{
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		rz_dmac_device_resume_internal(channel);
> +	}
> +}
> +
> +static int rz_dmac_suspend(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		ret = rz_dmac_device_pause_internal(channel);
> +		if (ret) {
> +			dev_err(dev, "Failed to suspend channel %s\n",
> +				dma_chan_name(&channel->vc.chan));
> +			break;
> +		}
> +
> +		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
> +	}
> +
> +	if (ret)
> +		goto suspend_recover;
> +
> +	ret = reset_control_assert(dmac->rstc);
> +	if (ret)
> +		goto suspend_recover;
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		goto reset_deassert;
> +
> +	return 0;
> +
> +reset_deassert:
> +	reset_control_deassert(dmac->rstc);
> +suspend_recover:
> +	rz_dmac_suspend_recover(dmac);
> +	return ret;
> +}
> +
> +static int rz_dmac_resume(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +	int errors = 0, ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(dmac->rstc);
> +	if (ret) {
> +		/*
> +		 * Do not put runtime PM here and keep the same state as in
> +		 * probe. As subsequent suspend/resume cycles may follow, leave
> +		 * the runtime PM as is, here, to avoid imbalances.
> +		 */
> +		return ret;
> +	}
> +
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		rz_dmac_disable_hw(&dmac->channels[i]);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> +
> +		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
> +		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> +		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> +		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
> +
> +		ret = rz_dmac_device_resume_internal(channel);
> +		if (ret) {
> +			errors = ret;
> +			dev_err(dev, "Failed to resume channel %s, ret=%d\n",
> +				dma_chan_name(&channel->vc.chan), ret);
> +		}
> +	}
> +
> +	return errors ? : 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(rz_dmac_pm_ops, rz_dmac_suspend, rz_dmac_resume);
> +
>  static const struct rz_dmac_info rz_dmac_v2h_info = {
>  	.icu_register_dma_req = rzv2h_icu_register_dma_req,
>  	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> @@ -1447,6 +1616,7 @@ static struct platform_driver rz_dmac_driver = {
>  	.driver		= {
>  		.name	= "rz-dmac",
>  		.of_match_table = of_rz_dmac_match,
> +		.pm	= pm_ptr(&rz_dmac_pm_ops),
>  	},
>  	.probe		= rz_dmac_probe,
>  	.remove		= rz_dmac_remove,
> -- 
> 2.43.0
> 

