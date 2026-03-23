Return-Path: <dmaengine+bounces-9581-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLNlJfKrwGm4JwQAu9opvQ
	(envelope-from <dmaengine+bounces-9581-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 03:56:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976B2EC04B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9937330115A7
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F622877F6;
	Mon, 23 Mar 2026 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ULeCChkO"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011056.outbound.protection.outlook.com [52.101.125.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA4286405;
	Mon, 23 Mar 2026 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234577; cv=fail; b=h3LWddyH+/wa8UvWExTKBqQOMT/dRbJ9APqrqkO9+6aweQK3BE2gX16aMC+Bznel1Fr7FyW37ezt/0GCkmtoefcwT9JyE2TsB2U2HLijsGn8StRRtvUEqVuCkV2+kd2T99PYL8DQ+abpqepDanZuWEwU2q7B9cCa6onepKO80LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234577; c=relaxed/simple;
	bh=keSNQE0cYXWlzUteUekohkJr+6i6HdtkR0EKvkrcGaA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CnmOc9r6UTMTYR/wLfRcesS/3X5QxYcTuNj17UP+i8sDmZJlNnWSiBHB3uJpTkY5JAwZFPOUdIxchJHk5l17K5WiT2GqAZ1ptiOvEGHM9NdCAq8KCd+thN2NgvQWfcpIGgYNw8luzpzg/ITZKrSR33JFM7AYprRKhiI8fO+cAnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ULeCChkO; arc=fail smtp.client-ip=52.101.125.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrmneg6YBT3e3Hr/46cnfpWiout5rc940dByjuiAjdktZX6QZ5sQGuWvuboXUcpePJG1L4rLnhoHWFGKrwAf+lI4F3/pdnqYzZNVsTiXwiK1cgRZx/p9STcnvE1d3SrHWkU4gxn/O+tXqr7v1gTnPkD1aJbq81zjatdNZiE7HOFU+faA8nlULkOTSv7jy2zlOUMR04B9E5WWzUXs1VGJxirO4m4czQ0uheNqPk+EvIUTpbZLsW6US3lYx+nx93YxbmrbceLPQJH/6JbLktX2Qcs2JbuPsy7FYMdfx2x2078GUyDUVsVzfGIgYdD6L4kbR5Ca0VWiWv+Nu563f4tluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYFEYQsMM0WSgdIzGW9K7Fb7vG5jQGqFFoEOmp5Cfao=;
 b=S2eg8tIOMTXmnxMGwcxS17AOcCo1qi1+Lzy5shh8nWgzz/J6qZvvhwY1J0KaQmdeQVGkFixDSOLnoJMSjc9k51nHdBcLVEpm3hHkjBvlvbOc3oIi8MrR8UgZ3ql31TprcUbHfi9Dt88oFAjmcBMd6xY87nz1xYB1X2D40P/y5UlT6i3SupCq90qtEkfqSMEuqP0G99FuFNrwDjTcLSvXVCXbuquNh/zoIWDuJjjvk8nSxbQWkbd4D4ZyZ8iCMhqtfiW1MDm1QxPwQVZ1rRjBFyLnbstRSRrM7fxZR3fgGysd6g+qX2tS5A0NRg3qBeVJ2SkBtdpajpnor5zbZ8Oasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYFEYQsMM0WSgdIzGW9K7Fb7vG5jQGqFFoEOmp5Cfao=;
 b=ULeCChkOe1MCitLab2NASHpHwQ9yL9QEkePBZO0O1LT48v/bGnwS7mGm3b95I7t3ud4m9DX3LuODxVV0MoxECBzD9zDZFC5oizaDUhPa/b46NSsIesuCPazPiBuWm9/EIsJrGPh9mG7hEd7auSgTAMgj98/s6l8JieyCu5gWYkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY4PR01MB15475.jpnprd01.prod.outlook.com (2603:1096:405:271::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 02:55:55 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 02:56:03 +0000
Message-ID: <871phb9ruc.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 11/22] ASoC: rsnd: ssui: Add RZ/G3E SSIU BUSIF support
In-Reply-To: <20260319155334.51278-12-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-12-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 02:56:02 +0000
X-ClientProxiedBy: TY4P286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::17) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY4PR01MB15475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f536142-744f-40bc-5dce-08de8887b88f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Z5pX70WhekNKyBLwhEx951OejuVLtASv202+QevuvpCkVZKpCyglVutYQKwj8jot0FJwyNx59j/cXVnLjZcsXI5Q3TmYw/R1N5+NPjGpDZV1CAbVc3LyFrez9hY8Cpvt0rXk9l2Vv4nOhhPgvG3IP+QcxeDlzpIG7POnrjlFynhGjBwPtzD3uJD0GBpuNnrl54H52x1hsZv0LHBHTy9hMHPeLwlmpiSfYp8ys/8B6BlJi4APgXgqEPKCRSbnOGtey6dTyhkXzNYNX18j7dwn8yHOG0A9PCuZ0u1ss5QZpXx63pK3mtEwYeCwNtZEe8pkN/jCaWZXM4I2sugZpHIwJqxDR9a2Kc+ZxWjb19br83QDY/TxGHeiyG7R5SZSkKJqspngIk76hu6bexTbEy3gdX4tMhbNCrWA/1jkojXWl3CQhTBq72GtfciOlhhney+Q5E41i22Z+tdPjHsJFnJhrMiPrGzkkMMXKtO/8rIS2RjxPYrzqNMdzHjcNR5WTqDmu/pPbCQmxgqCVABT4W3iP0fanAnxhsuN81q1CXSa9IDJX+Y+GMjHtHosMdWzac/ZKwKhqMRSNv2RhJ7eaC6IoB5EXK68qm9WMwtQG96wGmK3J/hyqEGf1wv80/fa6tvGd/k8qvkvyoMvabW9+0TtIY3tu9nMU/eQ/n6TRhs/vAeWFloLbERkwSyqFXf1MMXaMeMiw07xIcpTnaOw9sjLNR03p9fQO2dbrMg+DLqRvEA/VoIVVt+XTPX+UHZBNMMbfmKPn6lyzg2POxStMVToifWU+F8OuAZfAdmT0ejeNNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcj1tBcrk9Ri/wYxtc1V2DmnDoTlHbSre0y5XqDd5V5fBfCu4oGJSJgz/LXO?=
 =?us-ascii?Q?Q1V0dSklD+wzs1CCrqCp57spgmd/PkvQzaSlqFOpaVX425SG8rWO5RwBuqgv?=
 =?us-ascii?Q?oZvtw7ePa2A0hDU36bpWygYMmcPF725VmpD/EPeEDE+qVN1g7VM6IumZF9ds?=
 =?us-ascii?Q?gOCnil1ptp02XT2pRVuIuEUdQ2UO5KCi0P8lKyuhrwewEOhm6gm3gJx/63D8?=
 =?us-ascii?Q?bpE4IL1/vW9h9yGGIQMWgYvcfQuf6faeqvImJxykCQgVCk08y/60coDsBnKQ?=
 =?us-ascii?Q?a7e1+3koVhbhTnNC65PbCsO0Q9emCuVJm1cfJrlDfWQQTLiy2Oz9U0p0qFht?=
 =?us-ascii?Q?Otz3qD5kJRDZWuQEk5YJRzebkiSkkBPlSs0b7PR6LgHIljp35jtljURFIwNI?=
 =?us-ascii?Q?N0pcixMRGekDL+xn8cBXL5+26O//ZqdAHnDTEYPdBzJaRoA2ud860Cz7RvwI?=
 =?us-ascii?Q?p369QDr6c7qfbmWEvDmfPJEj1Ezwq2dm5lsC9Ne9prDXBPIrbYYhxb49xncf?=
 =?us-ascii?Q?gQEBEUB0ddKfZh0uodKLzCFUUfpgbulJEn10VULIvFZhwkkRzaJVjlU6RAlp?=
 =?us-ascii?Q?1yYN1eJ4J4Egh92dyWVp+AHmiEfDbVsTjpfDfUcdKoXaC9Q+KDUQQT33HF2u?=
 =?us-ascii?Q?TKhAsHnIVLskL3AvnuCHeIQQMmTdH6axTjxRoahW+v5MQrvU+7yan5yWz9Et?=
 =?us-ascii?Q?HYoH5pEadSiF+1XPjh95I2lVIriePi078/Mq4enrfu0VwjjXh1Q/D/Loqkkp?=
 =?us-ascii?Q?fsDsLez9NzRDjM5Rl1lgUx6SzV02h3mTyUD9CvA/AhZy/Qkv4PvOy55WtV9E?=
 =?us-ascii?Q?PvCypdA3Bu8hYjYZaHaH1pRd4QNyc64c/W0IrW924ckWPk8CgMLKVV2HdqR5?=
 =?us-ascii?Q?syCvuXV41LH4bg+KqM/MeOd8rdXmaWyQtFCjtOLeXiDHhV7U/vU/s4S7BzZZ?=
 =?us-ascii?Q?nvYOfGN73xjnL8ZjrZDN1AkWMCXlSKEiyv3DDjeGB5a7LTaXBbtQ32bfdjBe?=
 =?us-ascii?Q?eEYTlHeJbL/nw4bUevJtEOJyVtfpeebkxyC7f8or9iq5Pt1IzkW++QrmnYik?=
 =?us-ascii?Q?IA42XbR3C/OgPHN7ZGtp3Bekh/5wGBcsJMiPTB0V57Unc0ejZInEiQx01V9H?=
 =?us-ascii?Q?b4eNWnX9nowIJgcRmYovwmjamn+SLmCfIJiw8w0XDPwzpugjZmF0Cm4bSQjQ?=
 =?us-ascii?Q?5ylbM3MZ3MnVM3yr1QWvnP2CRuCdILx4miAC6pcS52iDCPV+ddeJ8rrkb/M1?=
 =?us-ascii?Q?TKxDY71VTkFuyEKb8rREa4D7k1/K6PyOVyKxYWh6sNwjcX318TfXr76rtrv9?=
 =?us-ascii?Q?189x9A+zubRSpFPAtpx04OEi4xmc2aZWf5mmbOv07zrCZwZOVKwiEyfowS3w?=
 =?us-ascii?Q?TBQkEjVcxqQF+nnaHTePVMW0DctJtQcaRbekRXufGHwMrIpN/ZrR0S8rSn/e?=
 =?us-ascii?Q?EsMlGTEjT4W+dsvUBXxdTS3Gvxn6iQ94BdvefWvxLHZaI7VQEPUnaiqo6N3x?=
 =?us-ascii?Q?iMLBIEibZI98kbP/avIDrBqTzbxxSpjFdoYhwzwjJMQmxBxNb4ToQJt3sLT0?=
 =?us-ascii?Q?dvbSyhBTsIRRdFzvwkqykpUT/xS5FmEl2g0B8xSm8dDWYn1IN/X+YqgbIW+3?=
 =?us-ascii?Q?6vSGRflStAgOm43DkcSIg3Uq7ImxPk09Do4TkrnpwJBQKynZ4rh3rkbS4E4z?=
 =?us-ascii?Q?VBN3mUGZ/Gw4vSWXOLeMUQ/MEwE2+Kl/7uw1/vPXCJCth4cFiwYMIrObqxUm?=
 =?us-ascii?Q?eANkgFIFrPDgwdZr2MgU9Sfy3nY5jePw4SkowOCPZgJWfULkdpq1?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f536142-744f-40bc-5dce-08de8887b88f
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:56:03.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6oARq7LuR/te70ASKU+TcGUQ6km1UGQF1njaHdgKgDdoC/vNT4Hd/cCyVjGh0Q1fUp+pFCmFDLaxIihMmSelx09YpFn0Rs6ARKUyIN5yhyS1661vayrR5mr3COQn1jD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15475
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9581-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:email,renesas.com:mid]
X-Rspamd-Queue-Id: 3976B2EC04B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> Add support for the SSIU found on the Renesas RZ/G3E SoC, which
> provides a different BUSIF layout compared to earlier generations:
> 
>  - SSI0-SSI4: 4 BUSIF instances each (BUSIF0-3)
>  - SSI5-SSI8: 1 BUSIF instance each (BUSIF0 only)
>  - SSI9: 4 BUSIF instances (BUSIF0-3)
>  - Total: 28 BUSIFs
> 
> RZ/G3E also differs from Gen2/Gen3 implementations in that only two
> pairs of BUSIF error-status registers are available instead of four,
> and the SSI always operates in BUSIF mode with no PIO fallback.
> 
> Rather than scattering SoC-specific checks across functional code,
> introduce two capability flags in the match data:
> 
>  - RSND_SSI_ALWAYS_BUSIF: the SSI has no PIO mode and always uses
>    BUSIF. Used in rsnd_ssi_use_busif() and rsnd_ssiu_init() to skip
>    SSI_MODE0 configuration.
>  - RSND_SSIU_BUSIF_STATUS_COUNT_2: only two BUSIF error-status
>    register pairs are present. Used in rsnd_ssiu_busif_err_irq_ctrl()
>    and rsnd_ssiu_busif_err_status_clear() to limit register iteration.
> 
> Future SoCs sharing these constraints can set the flags without
> requiring code changes.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
(snip)
> @@ -650,6 +651,8 @@ struct rsnd_priv {
>  #define RSND_RZG3E	(5 << 0)
>  #define RSND_SOC_MASK	(0xFF << 4)
>  #define RSND_SOC_E	(1 << 4) /* E1/E2/E3 */
> +#define RSND_SSI_ALWAYS_BUSIF	BIT(12) /* SSI has no PIO mode, always uses BUSIF */

I don't think we need RSND_SSI_ALWAYS_BUSIF, because PIO is used for debug
purpose when new SoC has comming.


Thank you for your help !!

Best regards
---
Kuninori Morimoto

