Return-Path: <dmaengine+bounces-10996-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG70DtBGGGr2iQgAu9opvQ
	(envelope-from <dmaengine+bounces-10996-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:44:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB25F2EE3
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2538C3004420
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075913EFD39;
	Thu, 28 May 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KWkOH/1O"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011046.outbound.protection.outlook.com [52.101.125.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B03ED3CD;
	Thu, 28 May 2026 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975882; cv=fail; b=Uqzji0qrX+WFCAKK3/BAcU/P4qpuuu+iGyFqnqpKOrhgcMb597aSHNwcODuvNu0vuJCdxfjRGFtFkjEwAEMsuYSIr1KbIGTpYUUQsrRqByg8Ym+ydTiozcwlZHZdY5364Iw4eHCEPxNiT/ynHBBy25mfXEAg/59icW4QGqiswBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975882; c=relaxed/simple;
	bh=OARlBGGnrcRnPK8+7tY4wdUb+N7dX13Dh32qspNUENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iuITe4BTG366sPwChp1AMK/UddD5xRj6JJlA0Tk028ukuFjAq4v7T82hfTx+fG6urlW3fIuXuLER1QoOifak/b2W0CYI8D7kX606tB6wx5dVuMULWPmX0zCcjYUmXQdxkEV0H9BuQEd91t4nziamAYbx13x49OXGA6FYRAlBSfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KWkOH/1O; arc=fail smtp.client-ip=52.101.125.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q26CNvOP8XkvLiAAajyF7Rv1wp78TTkBnoe8w4m40wcjZhlOlaYnnAnnB0osbqRFFSTIna7/8FfCsdBCbgfRgbH3d8pfaWTcreiXbh6UFwLzCnbitMCIDkI6ivtZVyw8GGS1tz3Cw27g+rJYBKwUvgPsCyFh/4AgvMXTeGSo5AJFC3loc0arJLTcjFajNbeopTK1m3zor2grhyFN6H8F+pvjhvN+3HUFeUorj/tJ3iIvV4O2laqyjvF48mSxUKlDiYiby6zt61+I4QM8p9uQI+iRsxY6IU4m67KS6J+jc8u17VSIb5PbNT7Hua7wHFUqJC78raCmXT1EXDu5Uf6/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT8C4K4xZeVLUPkokd0P8cWQzDWGI96DJmCWXcwBlQg=;
 b=UkfkAoHEiVHv5TH/OAFhOjKOJbEtOxoqXbSHDXsumpa4cu9dWCq/IoNUZYYhBZZXrqsyvXs6CJjw58pqx5No00P0JztDW/mFBNdg24PyGgxm4/mo0tlNmylQs5F6Lbm7c9TcRee/VysntdWvw+hefN8AWXq6y+CI9w1GH91p80MJJC/sc7Y01YkdSaEL1bQWPqG+UAoIogNo1eK0xppTMIv1BsMzfFtiKFLtQjFpWxWS+irjCjlkf8tLkzdcredmu//DivFGQOXD+2kbA24b7LIu/Pqfu/yBW0G0bB37m44kOu8C3cslEWVfaNFXuTWXSHned56cts13J61jPwH+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT8C4K4xZeVLUPkokd0P8cWQzDWGI96DJmCWXcwBlQg=;
 b=KWkOH/1O+23naQ0BeoL3CBipMjFywmkQpUmBUd8nwTOutCBBeIDJEOcwdjHE2Wpj0gHk3JLZotnVqulPWCrGtfSCtgA8XsTOfwQThu6Ia5Loeq0AQjT2JB3o6e9AoPE+Qi7CO8xO4KK+DiadOHr2NcV1+ELn0qkl1SJGgmci7p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:44:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:44:37 +0000
Date: Thu, 28 May 2026 15:44:18 +0200
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
	stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Message-ID: <ahhGstBA7Lh09psv@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-2-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-2-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: d40d5aa7-f6ce-4939-e843-08debcbf42a9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gYs5H5dWTLqgsDx4vArqtp8nhGzulPhimN8GIDIptDESRqi6H16uj2cKpiV4uCydMzR9qNxMmdYNEaJ28wjNn7aVZzLFeqbRh5b2FYswY8j9D6yLPP5LZHppm+/kUSB4dpbuxxO9+8qm+0LdD+NALMNS8USe04QslGgI9WTzuMcOow46I3ilfY2OJynivKTuCX3rHSiNGw7k7qX8G2TjcLqbGvVM4zhIt5qux/3bmwL3mTIChSBlV6K2/hPCRMw5E87mxo2ocUTd0LgEoDsRMqEtBRco+5sDib6lib3vezhEbLF2HmVGlSn0A+yV7hUaZYfQaJJLNDPdHv4NEuPjP2oxdNJsn/B2WnCTTTe5nYicU49sqhQBpm8HnCmz5JXd0+vGpHkBXo66MV71gSjLsIncmmWLIo1T5poHZF8PvdQtTo63/XphCqjWkcOZbTFXnFlSyUKK6zOEuUrV184G+goNH9uOqynHyZ6pK6+MItqECi2/WdBhNAsDjnZY5vMK3TZDKdUCzI4wiv7VE1fvuV5bSvedaP2PiX2C8Z91vq/+PTv6IdlT9j3A8tzn8TRu/pjUyxxEfwzQYy3ADLCn7pSZlzFyTfAVQuGAsEqYNlBR3ILOv/Ykniv4YEi2kIFDWJuWZfEn2kpUbg7ckkMBxlW9VNeq372kMNpuYQ7NJN9RIXTZk3dI6dRO9l67j6ng/sRqBiW5Q7lv2DvFfr61n29upyEVf+drYAahbJq5xCfqFjLA4IkR/ksfGJmdK4Wn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjJ6QTEAlr8MlK2zcBTLMxYP5GvJCTgJTO0Q+iKWzYF+b4G5jvWZoxnyvt4Q?=
 =?us-ascii?Q?u1kK0jHZg/WuoZs0b1okLdRCZlSQYNUkHb3cnNTIE4NNZZ/7mw2/kDN6WTvi?=
 =?us-ascii?Q?Ivz6dLWpTA0xqtKaBTu5pv3zBpaYmDdZmi0qn9ZZ4Ne2Doeh1hsY/BkKpEOT?=
 =?us-ascii?Q?KfrpSJuZoCG+4e8oAzp8AJnUnESBzDdynVA0XN7pZMsAb003suhIDzvBMud7?=
 =?us-ascii?Q?WAlMfVj6GoyYHkwRdHIA39ENra3VmCHT51Fr3b47yDdsp4311fy9o336DAVY?=
 =?us-ascii?Q?kf613+gblD98cKI1hyQJSMVA8H7bOcGRyCyYImOqVKOO0mlvqNQcDpEAUag9?=
 =?us-ascii?Q?+uQtbGHf5bhj+jnbTBz1BQz9UiGGNwaJNssYHJTnuvpAFt8EfMK7qCQ0lMZc?=
 =?us-ascii?Q?FSvbyL4QDTSU2RuC7TJ6gd6GHJ9e+1XQeeTLxGLwiZ/utuOzjmqshxniZ0Oy?=
 =?us-ascii?Q?/VPUuXnpHqNyh0qs3LM6k0sArw3S9K1eBqvl5T5VQZ6lfvNnvC/8YjK3hlKe?=
 =?us-ascii?Q?WUHSaEqIIEHAAvR1Qc1cG2ZIhNJEhd3HhUu+P8vlUIVNVNy44AkHfhZV0+je?=
 =?us-ascii?Q?XRUtxfvHR0a6hLs6TatzNYAqVKAEDwiwa7L1r/uOqbT9A0w46J4qec2cv6+o?=
 =?us-ascii?Q?O3ostZmwfkNOQhJT+4Nx1PAykF6oeqRgu7Wqfyfmz8XdTzhT6jDGmZr0zerB?=
 =?us-ascii?Q?KXe9RGfHlUrRPtk+ik7WplEbqw112zJh0yF+fKHR0rgSbOHbZBTVCIdkSeso?=
 =?us-ascii?Q?DaGnxbzc/2NAmXXsl5ipy/bDTJINKyGAuqdV/IVf4PKxWBLQ2eBSHXUrVVBR?=
 =?us-ascii?Q?ABLZ3ytoFHvF64WC0RCXdIC/InozRcSZ4FNWcYidwnIFV0MWz01zk9W7blVk?=
 =?us-ascii?Q?VKtObWFWtH++xiVYkt1kK/erqX1XnF/BbL3wYQEMwmi4ikWUk13nUntSGrJN?=
 =?us-ascii?Q?sgZ768v+zDGzB3pROF3UWqiJV5C/XfraQjKi5aKeNBYwoUMoNF63fBzkNPss?=
 =?us-ascii?Q?Qd9l5ZWxhNyGguHB+dUCud8620TvHkL8QFlhee35hmvegUgPD4kt5+dqczj3?=
 =?us-ascii?Q?VAbu6MPKfjIr7qsQ+QjNHLsR0yryO7TGb9dTogWv8f4u34t1roIw0DFkA+Vo?=
 =?us-ascii?Q?P2UphAyqD6RQWOiUkXqZBIms/fNPx+tsHJLcq6RVr6k7S1juFPoNofIS3TKe?=
 =?us-ascii?Q?CF4fikITWy8igH3ZhThNtQbBudxIAz8SdUc40I2knIw+uwEF3Hy74Pj5EKQW?=
 =?us-ascii?Q?d/Shzt9IJvaSe0fzYagwq93LrYe0tqmU0yhMMS1Myj2JOSegsH0WMKDfWgC1?=
 =?us-ascii?Q?sS3MfdkNB5rGbb0akaINMYUWWZCR4sjOv2gddBqhPZUabHSXEw2MB7W806qT?=
 =?us-ascii?Q?y91kGwVG0OQ3SQcYuJJfwU/19XQwBW5w9+uWDJ7oAHTTi9ytImgOSv0lX8dg?=
 =?us-ascii?Q?GulATY7EehowxrXGemAMvqq3adhvRwuWFtnb8iSkzKwNRRIUP8l7B711QbEK?=
 =?us-ascii?Q?7R/81EEH/Xlbo7StXuuS5gXLqsvCnm0gmJ0UHlGuqmdqEC9eFZn4aCRn7MpI?=
 =?us-ascii?Q?AM5F11vmkP34k0tmOdObi3nMx40fsyBxpsUkoIrL8w8ydDU/YeTA/jSO+sqc?=
 =?us-ascii?Q?OtmaimD0D0vvjPvZ5s4fEzzhEqI+DpIYRkBWjkowRPVP25nTUy9Fc+RSvZig?=
 =?us-ascii?Q?NlOyfNDeqW0k1sYvicEFy/1Ev85mmDYTCg+HwjFkQCcYDgtzXdbr8ZhNK02B?=
 =?us-ascii?Q?B9dnnUXXcqcTKUWUF+Qfs9jUX1pqJEjXaIaYwTdya8EQJrjZSM24?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40d5aa7-f6ce-4939-e843-08debcbf42a9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:44:37.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo71VdGvjQGkJGcHpS55xU4DNymQFGP9t5WvyP7dIxXTZH/rUlf6Ikrvdjo/znFI9+e0GFvgMaUA5HMq34XsikXv7ZTpPPUKZGeAguyjqMa3l4MGU3fpFbAhluKn3DTm
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
	TAGGED_FROM(0.00)[bounces-10996-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org,nxp.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 3AEB25F2EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,
Thanks for your patch.

On Tue, May 26, 2026 at 11:46:53AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Once the interrupt is requested, the interrupt handler may run immediately.
> Since the IRQ handler can access channel->ch_base, which is initialized
> only after requesting the IRQ, this may lead to invalid memory access.
> Likewise, the IRQ thread may access uninitialized data (the ld_free,
> ld_queue, and ld_active lists), which may also lead to issues.
> 
> Request the interrupts only after everything is set up. To keep the error
> path simpler, use dmam_alloc_coherent() instead of dma_alloc_coherent().
> 

Tested on RZ/G3E using dma along with rspi0
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Thanks, Tommaso

> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - collected tags
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 88 +++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 625ff29024de..9f206a33dcc6 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -981,25 +981,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	channel->index = index;
>  	channel->mid_rid = -EINVAL;
>  
> -	/* Request the channel interrupt. */
> -	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> -	irq = platform_get_irq_byname(pdev, pdev_irqname);
> -	if (irq < 0)
> -		return irq;
> -
> -	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> -				 dev_name(dmac->dev), index);
> -	if (!irqname)
> -		return -ENOMEM;
> -
> -	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> -					rz_dmac_irq_handler_thread, 0,
> -					irqname, channel);
> -	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> -		return ret;
> -	}
> -
>  	/* Set io base address for each channel */
>  	if (index < 8) {
>  		channel->ch_base = dmac->base + CHANNEL_0_7_OFFSET +
> @@ -1012,9 +993,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	}
>  
>  	/* Allocate descriptors */
> -	lmdesc = dma_alloc_coherent(&pdev->dev,
> -				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				    &channel->lmdesc.base_dma, GFP_KERNEL);
> +	lmdesc = dmam_alloc_coherent(&pdev->dev,
> +				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				     &channel->lmdesc.base_dma, GFP_KERNEL);
>  	if (!lmdesc) {
>  		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
>  		return -ENOMEM;
> @@ -1030,7 +1011,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	INIT_LIST_HEAD(&channel->ld_free);
>  	INIT_LIST_HEAD(&channel->ld_active);
>  
> -	return 0;
> +	/* Request the channel interrupt. */
> +	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> +	irq = platform_get_irq_byname(pdev, pdev_irqname);
> +	if (irq < 0)
> +		return irq;
> +
> +	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> +				 dev_name(dmac->dev), index);
> +	if (!irqname)
> +		return -ENOMEM;
> +
> +	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> +					rz_dmac_irq_handler_thread, 0,
> +					irqname, channel);
> +	if (ret)
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> +
> +	return ret;
>  }
>  
>  static void rz_dmac_put_device(void *_dev)
> @@ -1099,7 +1097,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	const char *irqname = "error";
>  	struct dma_device *engine;
>  	struct rz_dmac *dmac;
> -	int channel_num;
>  	int ret;
>  	int irq;
>  	u8 i;
> @@ -1132,18 +1129,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  			return PTR_ERR(dmac->ext_base);
>  	}
>  
> -	/* Register interrupt handler for error */
> -	irq = platform_get_irq_byname_optional(pdev, irqname);
> -	if (irq > 0) {
> -		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> -				       irqname, NULL);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> -				irq, ret);
> -			return ret;
> -		}
> -	}
> -
>  	/* Initialize the channels. */
>  	INIT_LIST_HEAD(&dmac->engine.channels);
>  
> @@ -1169,6 +1154,18 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  			goto err;
>  	}
>  
> +	/* Register interrupt handler for error */
> +	irq = platform_get_irq_byname_optional(pdev, irqname);
> +	if (irq > 0) {
> +		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> +				       irqname, NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> +				irq, ret);
> +			goto err;
> +		}
> +	}
> +
>  	/* Register the DMAC as a DMA provider for DT. */
>  	ret = of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
>  					 NULL);
> @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
> -	channel_num = i ? i - 1 : 0;
> -	for (i = 0; i < channel_num; i++) {
> -		struct rz_dmac_chan *channel = &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
> -
>  	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
> @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  static void rz_dmac_remove(struct platform_device *pdev)
>  {
>  	struct rz_dmac *dmac = platform_get_drvdata(pdev);
> -	unsigned int i;
>  
>  	dma_async_device_unregister(&dmac->engine);
>  	of_dma_controller_free(pdev->dev.of_node);
> -	for (i = 0; i < dmac->n_channels; i++) {
> -		struct rz_dmac_chan *channel = &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -- 
> 2.43.0
> 

