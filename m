Return-Path: <dmaengine+bounces-11009-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHQkF+ZKGGqjiggAu9opvQ
	(envelope-from <dmaengine+bounces-11009-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:02:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B65F5F3479
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C64D231CFF9C
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105C276028;
	Thu, 28 May 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PbVglNQO"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011069.outbound.protection.outlook.com [52.101.125.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BD26E142;
	Thu, 28 May 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976287; cv=fail; b=Iouwix+7Q0Q56eKr1nJ0OoAO/oFFv+T3g+WTiQQ/TV7AAbuwOa6rZ0HG6cY7gn6/Kqc3k5FfYIenmlLGc0CmJMPkQu5A7TX00AU+5HMA1nqgBBP3xlUtTbVudoh/mNazhp7jVU6prlxGGsib+60/HduBDF59XnC1HS+lSG9GBCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976287; c=relaxed/simple;
	bh=kstbdFf5cYN2nyVNKhoxfIP/Z/X6mcRP0K339Y1xvfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vnq1nmsvHRduBJxt6Yf3aq8jQEECF4v8Y07JE9Goro1Fwtc9AbfXnZhzkmfYfNrY+lzP/hqNPm6jZyk1lH5wItK+mPjAxuDoThz6PwUh+cTZN8WLZmzyvURJrvo80OOykcGat63IdHxdWTVb3nKjHxcVtoyo/Pae+tuMstElkf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PbVglNQO; arc=fail smtp.client-ip=52.101.125.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgkCEVqntlONqikKci1q+ngWg6bHChbxdqM+m1FGP4oPKqlUnV6n3aPEGbQubiKDKNuBODAHXoZwYRcF5L5uZEM1fYN8a9T9EGkpusbPMpqCziRwxeCxRlXM2C/xYkFj4r3JiP+svJGrBRlKv7MP47qSOSlcK/CMMcR0KaS4mrz2ukZUHrVRn1cdHDLe3vxR3gDe3dFte9wR81pKYSzv9Ktp0rb+b+7Ph2oOI8joBFLVBUft/C13smzQ5cSDHtdSCgvgovkZpp/Gzn+xr9NMnWr+h/vJBdOc4N8g0NMuqIdTSa2JDsNZkmgQCIpVB1Yh7PWBC2U0D4kvDCRxX+WoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIfvXkxFmnHX+3zftJ/ddlMdXlICgQ0gfbjSWsfaGdI=;
 b=x1qyy5GTu/XlPxabMA9efCnaLAHfwixSvOmsCgB2B4OMhUuZvNs6DsJIxDghrw/Zfjgglz1PoZOk6KWymv20thDwOce94A6uenEJ3J0UcecZpipNjxCo83ORo9X0PpnoterMfNjhybf4SUgwEb2VSUK0kdMzvupvkpwRhYJdZScPh2a1/qCMf9KQHVxcYi9NIA4By9C7F/j64okFyuSYgz0TkdgeCvBsXmlK5K7hqJzXdSc28uBoXAhRe+roB1OTUqnGYwLmBDcaVpmm3KzyxaE21WuFdJWmbQOOB1TA1doBcGs8cru/3uaZZUCAzNq1FTZjSOzjH//hkvsO11JQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIfvXkxFmnHX+3zftJ/ddlMdXlICgQ0gfbjSWsfaGdI=;
 b=PbVglNQOR0G6WlaexXA9y5DJQNmgdKoRrRaChwtNNZtKcq/MgNdpJdhox/q9cdusktovBRvzPQRBlzWdHhIB0KcL3vYhQfhl7lnKBhwcgiNAzEH4sJPkowTy31b7vlRJrb2H7+J9VZgnZwFt+DVB3Tl4mOZ9uhNXBamewW1M4t8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:51:22 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:51:22 +0000
Date: Thu, 28 May 2026 15:51:08 +0200
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
Subject: Re: [PATCH v6 12/18] dmaengine: sh: rz-dmac: Add cyclic DMA support
Message-ID: <ahhITG7H_yk2_alj@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-13-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-13-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb2f06f-0faa-4c0a-cde6-08debcc0339e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TJiTR43TVbGj8Eh6DxmxzwaUafvJKsJCNvQ2PbYnXcU9WhJOMGz16d0O7gsJaqIYh7DktWZFcx3IBhjKDMwxzLAL3cQ7xXh3ucZroAuq2vsONhLkh4j6e74vxlsUlpNoceuhTv8hKZ5mb5v12OlCIQd1W5Axn/zKSU8Luu613C7Sd2NY6l0o6ud91Tz/Gp2qsx1Y7OSEX5uYmONCcksATb3nokmdH1YMnHbEVtLXkyqCVukbJU779fGLS/iKG6tkrgOqd/CFL+6GPIXpKsb1kkuVEzBB1BfWoJiXymXij3FHC1Qawcg28tThKFenXwdQwm7ZxE6PJOscUdu3pULRLvlqMzqDeXerl77KhHknVOXEubqqXwIIV25BwU+yz4gMxvk+2dC55fgSI0Ag4dUwR0JfQtuH7zm49Ynnfy6+Fnt5G36RyOGPspF2/sj7XC4MHthCg6CX7Y/NmRIq50s56thhtGiV8drxd/gRG6Vtzm44NFpy4Dd3cRiCZ+aieZURJeeGUqVNx2R1syNo0mqvnTZBidrJds1QYvwMRpXWHttfLP/PizOb7pD+xlRkPAoXXDtgX1jpGPMewPMapdjVIFF1VhVyKgA7fkO/kEAi3h253ikGQVnNd2P0CKUenILG6b8rR17rs1mNTlE9EnYBJRRxg0B88gAlD2P8jI5AC4adzpkhYL7z0VOzOtkQE8unHkgmDI7FK30e9H+cPjRBplHWnvZWQHtnhMxZyGtYIoJPNo+Sbn+D/gQj/vBye5aR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ym+TkCNWcmDce1nWGbdj/qsV71EBCjOpD8ZuIP0ulCOAoMy0v+n3wckTcSnl?=
 =?us-ascii?Q?pNo2vFDoNiKL/D78HoQyNZ2Col3M+lrUGt9Q2WEFM2TVmVXuew0UPjsNiwl2?=
 =?us-ascii?Q?fNQhwkL9bA7CbGpT1pFf+d5x54/vw7ig40vsQPYfUh6gL7AmvaXwi9LZVm4Z?=
 =?us-ascii?Q?EUiPMCvjCiH0JmmT6eTdE7jE0arV32Gg9YAuSZ3lGHlHneoEdTJn65imXgJG?=
 =?us-ascii?Q?B6xU5F1fcNDIANojqsm15n5CnQIxeO+6iImQvAc9C2BGRdvANZEhCG+X8JbE?=
 =?us-ascii?Q?GCT0Pifs2vQxKenBWBbzSCqVUic1uMsfQPfURUhiDNCZpUVIMCoWyeeYT0v3?=
 =?us-ascii?Q?Dkh6x03+ws54cBjmbJyfncpVHkW4RQgbHrKrJJvGseDQQq/RFscXTpNC6MH6?=
 =?us-ascii?Q?TbSzkMAGpUSvJ67qCWyAKz+BuNi36EjQbml7WW410jChc33U/W70zNT/rSig?=
 =?us-ascii?Q?khRzBy2eZWN2Ftk8CyjIrpfxnIOy0FkHuVU1yWjwga2ESy9gcIphUIaxD56D?=
 =?us-ascii?Q?MdlccjMUweKwh72quMySfxw6pEYzdXJeSCYmvlzUOpUciQ7mogi0xFMc1Gm5?=
 =?us-ascii?Q?dg2z0By7o6rFjDe3IX/yOvdExu0wJ5UQFqokyqMBL/Qw/mIPm/YnS0BECcbb?=
 =?us-ascii?Q?YgYor7Z12mZXuxthsh102C4Tqxr31JhalesbI+hJYj2GSOUFkS0rhJtti1wK?=
 =?us-ascii?Q?CE/KNunc61HOLcDqevP0g5TR/OlbJ2NxJHqTICnb32AVXUSy1VeScktDB5F4?=
 =?us-ascii?Q?FYQVhHGxW2uIoos04RRl0gua0DxGHthpKPHuX0mwpRGiReN/5KCzH5kReJsA?=
 =?us-ascii?Q?bbq4nr87ls1LIepn5O+1uLUkv8EZvBJvo88PIYlqzfaD9IUThY/helQr6ayI?=
 =?us-ascii?Q?4rjdxo4oGd/ecC4C7t1Nm5R01sBkETN1y7sm6UT9HwJ9zwp3N3FfAizMRLrS?=
 =?us-ascii?Q?SDnYYI+T77nPavn9oOia4Wf07WkmCQ9JsqiT+CBDLff6w2hBSWzsGWvsxM7p?=
 =?us-ascii?Q?DctCUhdvkoegLOjASc7TLlF5SwccrrMQYSxhx3eZxmHZwsvEM6moeVtVkD3o?=
 =?us-ascii?Q?nKIIRU7hvUJFi/0+meQHqXXklbxw5JjCDjfJC1U7TNBgPauHccMfpGDj0L/C?=
 =?us-ascii?Q?sXdglR6cBOHoKd9MXidxt22SgHNkA11ko9/+qt8dXjJ/bMulZaOQ6OXdQz77?=
 =?us-ascii?Q?QT1GDGSPf3oOWS6N2kUz9gkSWAyVbXYU0aKBeL0BdNgTGC7AMZUVXm8erkmX?=
 =?us-ascii?Q?jEegBm6VBqlN4EHuF5nlSub06MQUIA7xw7BD5I1YvJguOp82wfYDQ9gB5iuN?=
 =?us-ascii?Q?pSyu35cS3TMj7vltDCQ+f67TDEGnZMmS7na5SUek5GmiD8vXGUBl+x1G30BN?=
 =?us-ascii?Q?YKkmN+YeYEg8dnJbYWz3UsAZfS2zVIIdKiD/a8bK93rdlFrXOOHrPDlO1IZu?=
 =?us-ascii?Q?2V0RmSkwZoKI2faGuNhSFxDQVk6Rh5hecER9yDkZoyDTiGMKd1g/tVzBTuv+?=
 =?us-ascii?Q?/fBChpjtQZVhm7QiEYJeqetLOu48ZLUWQyleYOtl9BbEa6pFaVqi9YghWV3i?=
 =?us-ascii?Q?yhlFFivy8DBxfMwqJTjVPM/zMPZ0yaxTteQ6nCV/EZQS8Z1IucIVsl3BAGHk?=
 =?us-ascii?Q?riudVxsIJPUff/2wByRQRQ0jO3Jrt+ZVmSfFmRElYroaFoSvu6uaCHG+4597?=
 =?us-ascii?Q?3VOOg3FSvo0imveHiwHuICSYjlRMxaPZ+bxLHcuqaFwtfjsROVWS/wR8ZSdv?=
 =?us-ascii?Q?Qng1UvRGvsKBgyH72BofUZUmKKz9ywKOiXzknn0N2ZeQVSt92L18?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb2f06f-0faa-4c0a-cde6-08debcc0339e
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:51:22.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk+jKO0q5wgYjM3FBTkyJeQLwRmzuI57HDs2hclV7B+bbHqNcLx+5RV5njVP2vTz1URa2BJUs/rBe/sFc+i4w0ev0wuSFQtBJ0HlC8oZl0QqdYUt6nzyjDruP0sE/05d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11009-lists,dmaengine=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[bp.renesas.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,renesas.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B65F5F3479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:04AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
> introduced to mark cyclic channels and is set during the DMA prepare
> callback. The IRQ handler checks this status bit and calls
> vchan_cyclic_callback() accordingly.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

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
> - drop the nxla update logic in rz_dmac_lmdesc_recycle() as this is
>   not needed for any kind of transfers
> - drop the update of channel->status = 0 from rz_dmac_free_chan_resources()
>   and rz_dmac_terminate_all() as this was moved in patch 09/17
> 
> Changes in v3:
> - updated rz_dmac_lmdesc_recycle() to restore the lmdesc->nxla
> - in rz_dmac_prepare_descs_for_cyclic() update directly the
>   desc->start_lmdesc with the descriptor pointer insted of the
>   descriptor address
> - used rz_dmac_lmdesc_addr() to compute the descritor address
> - set channel->status = 0 in rz_dmac_free_chan_resources()
> - in rz_dmac_prep_dma_cyclic() check for invalid periods or buffer len
>   and limit the critical area protected by spinlock
> - set channel->status = 0 in rz_dmac_terminate_all()
> - updated rz_dmac_calculate_residue_bytes_in_vd() to use 
>   rz_dmac_lmdesc_addr()
> - dropped goto in rz_dmac_irq_handler_thread() as it is not needed
>   anymore; dropped also the local variable desc
> 
> Changes in v2:
> - none
> 
>  drivers/dma/sh/rz-dmac.c | 136 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 130 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c9c00650ddd5..8fd8a4bd9cc9 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -35,6 +35,7 @@
>  enum  rz_dmac_prep_type {
>  	RZ_DMAC_DESC_MEMCPY,
>  	RZ_DMAC_DESC_SLAVE_SG,
> +	RZ_DMAC_DESC_CYCLIC,
>  };
>  
>  struct rz_lmdesc {
> @@ -67,9 +68,11 @@ struct rz_dmac_desc {
>  /**
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
> + * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
> +	RZ_DMAC_CHAN_STATUS_CYCLIC,
>  };
>  
>  struct rz_dmac_chan {
> @@ -191,6 +194,7 @@ struct rz_dmac {
>  
>  /* LINK MODE DESCRIPTOR */
>  #define HEADER_LV			BIT(0)
> +#define HEADER_WBD			BIT(2)
>  
>  #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
>  #define RZ_DMAC_MAX_CHANNELS		16
> @@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  	channel->chctrl = 0;
>  }
>  
> +static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
> +{
> +	struct dma_chan *chan = &channel->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	struct rz_dmac_desc *d = channel->desc;
> +	size_t period_len = d->sgcount;
> +	struct rz_lmdesc *lmdesc;
> +	size_t buf_len = d->len;
> +	size_t periods = buf_len / period_len;
> +
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	channel->chcfg |= CHCFG_SEL(channel->index) | CHCFG_DMS;
> +
> +	if (d->direction == DMA_DEV_TO_MEM) {
> +		channel->chcfg |= CHCFG_SAD;
> +		channel->chcfg &= ~CHCFG_REQD;
> +	} else {
> +		channel->chcfg |= CHCFG_DAD | CHCFG_REQD;
> +	}
> +
> +	lmdesc = channel->lmdesc.tail;
> +	d->start_lmdesc = lmdesc;
> +
> +	for (size_t i = 0; i < periods; i++) {
> +		if (d->direction == DMA_DEV_TO_MEM) {
> +			lmdesc->sa = d->src;
> +			lmdesc->da = d->dest + (i * period_len);
> +		} else {
> +			lmdesc->sa = d->src + (i * period_len);
> +			lmdesc->da = d->dest;
> +		}
> +
> +		lmdesc->tb = period_len;
> +		lmdesc->chitvl = 0;
> +		lmdesc->chext = 0;
> +		lmdesc->chcfg = channel->chcfg;
> +		lmdesc->header = HEADER_LV | HEADER_WBD;
> +
> +		if (i == periods - 1)
> +			lmdesc->nxla = rz_dmac_lmdesc_addr(channel, d->start_lmdesc);
> +
> +		if (++lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
> +			lmdesc = channel->lmdesc.base;
> +	}
> +
> +	channel->lmdesc.tail = lmdesc;
> +
> +	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> +}
> +
>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>  {
>  	struct virt_dma_desc *vd;
> @@ -452,6 +507,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>  	case RZ_DMAC_DESC_SLAVE_SG:
>  		rz_dmac_prepare_descs_for_slave_sg(chan);
>  		break;
> +
> +	case RZ_DMAC_DESC_CYCLIC:
> +		rz_dmac_prepare_descs_for_cyclic(chan);
> +		break;
>  	}
>  
>  	rz_dmac_enable_hw(chan);
> @@ -586,6 +645,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>  }
>  
> +static struct dma_async_tx_descriptor *
> +rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +			size_t buf_len, size_t period_len,
> +			enum dma_transfer_direction direction,
> +			unsigned long flags)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac_desc *desc;
> +	size_t periods;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	if (!period_len || !buf_len)
> +		return NULL;
> +
> +	periods = buf_len / period_len;
> +	if (!periods || periods > DMAC_NR_LMDESC)
> +		return NULL;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
> +			return NULL;
> +
> +		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
> +		if (!desc)
> +			return NULL;
> +
> +		list_del(&desc->node);
> +
> +		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);
> +	}
> +
> +	desc->type = RZ_DMAC_DESC_CYCLIC;
> +	desc->sgcount = period_len;
> +	desc->len = buf_len;
> +	desc->direction = direction;
> +
> +	if (direction == DMA_DEV_TO_MEM) {
> +		desc->src = channel->src_per_address;
> +		desc->dest = buf_addr;
> +	} else {
> +		desc->src = buf_addr;
> +		desc->dest = channel->dst_per_address;
> +	}
> +
> +	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
> +}
> +
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> @@ -733,9 +841,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
>  	}
>  
>  	/* Calculate residue from next lmdesc to end of virtual desc */
> -	while (lmdesc->chcfg & CHCFG_DEM) {
> -		residue += lmdesc->tb;
> -		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
> +		u32 start_lmdesc_addr = rz_dmac_lmdesc_addr(channel, desc->start_lmdesc);
> +
> +		while (lmdesc->nxla != start_lmdesc_addr) {
> +			residue += lmdesc->tb;
> +			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		}
> +	} else {
> +		while (lmdesc->chcfg & CHCFG_DEM) {
> +			residue += lmdesc->tb;
> +			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		}
>  	}
>  
>  	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
> @@ -928,10 +1045,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
>  	if (!desc)
>  		return IRQ_HANDLED;
>  
> -	vchan_cookie_complete(&desc->vd);
> -	channel->desc = NULL;
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
> +		vchan_cyclic_callback(&desc->vd);
> +	} else {
> +		vchan_cookie_complete(&desc->vd);
> +		channel->desc = NULL;
>  
> -	rz_dmac_xfer_desc(channel);
> +		rz_dmac_xfer_desc(channel);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1183,6 +1304,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	engine = &dmac->engine;
>  	dma_cap_set(DMA_SLAVE, engine->cap_mask);
>  	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
> +	engine->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
>  	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> @@ -1194,6 +1317,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	engine->device_tx_status = rz_dmac_tx_status;
>  	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
>  	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
> +	engine->device_prep_dma_cyclic = rz_dmac_prep_dma_cyclic;
>  	engine->device_config = rz_dmac_config;
>  	engine->device_terminate_all = rz_dmac_terminate_all;
>  	engine->device_issue_pending = rz_dmac_issue_pending;
> -- 
> 2.43.0
> 

