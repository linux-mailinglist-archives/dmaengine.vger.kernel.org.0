Return-Path: <dmaengine+bounces-8480-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAKWCbwZd2kCcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8480-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2C84E17
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35FEE3002D3D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937E2D7DE2;
	Mon, 26 Jan 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="L6rrpss/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7112D6E76;
	Mon, 26 Jan 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413044; cv=fail; b=dHKl2Dbqr+FvW2Si+wkmP6kNse0XS2SCDyOB+Z3hSy5OwSN5WlLByrRZaC/1GvxD1SnSYhVZSB8ipFUh9lcliwOmwujohQUC4pRf2dcDe2i9WpXk/wQBijFRmXn5BwkO3Z6zTHwgVVWM8dO1BUl5+p3m0SjuWN8quHiPtr5n6uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413044; c=relaxed/simple;
	bh=zv/ZbZdaxgglkOES5dwCyaW+ycYMwm9IKGG2xCws42U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nr4cQ0AkD5x6zhl9FJl10joLX2+QOiLfwKr1SaJ+WJTgk0AaBybg0vse2rljNsGeqJE95uVuhpH31l8R46QyR1dYFl5AsHgs0cPajk4gZDdQNMqy6wgWR0FkBM0PczI4RXsLCZYCbLtERz1RL6L/kP8qNryHqJAsQ/gbGHCCuGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=L6rrpss/; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOgEHmhSZaR27Tz+08zkcwWg7CGyRDVe/9MBFyHhE9GbVYlfTai3HVBP74GnquSovEKCuTgBNTSsTKRreuG2oAiN3mbaY0mhkh6s1AyauMamEtpCeqYYJTL4KQHlgTFqsOgzZjiLSmVL7De2kjiyhGId53EXWafQCDLyur2UP8TxGWP2v6EBGMG62F7g5Vm+qAfxwGcHrg2b1sAeEzx1UoGbzZGeXUxUwSH0ikrLlJ738d2Ky0IzObmjvxrjZRkHYkbyjAXi4DASxcgSYO1GLCLrCdGlhcHQe8Dpy/Ed/EsTu80nthFEBGXld+F1YYnVnx/DOB5LKE74qHG3NEHQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUBAZ6ta0OG2ESCLfr4L6TV3Ztsxay5flHIuHzmFBRY=;
 b=D5eyR9zwKwFWcDZHYctPwfm3Mxr7pRwpqc64MpckJIJ+awYjAUfKMEKQu/XAkyrE7c5Q5AuP6UB7+yU4j7R6HV+/3BtZAvIK+ZanvgYlARZYbxSSnO7890Pbo/G6hKQFrXVIZ77gXVLy1Vh3wFmA6oxMz+puXws212cpncqcRFtHcRx8deQlC/SfrqYAUYDaXzxJtIePztB39VZ3npM+3CDqV2jkxqkE03IlVlfQaD5VcLadO8EySPJG60BDV8TjlUPmscdbnfgZL6wT5nRsxE47uE5nUeVtqZgDZcERAlbhfhMteUPbSCfvuzHfq1qvpnRB8b4AX/y0it3wIcAuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUBAZ6ta0OG2ESCLfr4L6TV3Ztsxay5flHIuHzmFBRY=;
 b=L6rrpss/P/3uaUYrYB+s3Og4Hzzka9LTDkBi1p7QuEnx0IIxG9WYUrFxQivB2tJjbAKGs6SPgoUCT3nPYfC4J/G8JSwIt43i23dQ675hnwtsGLjXmhdIrtjipQ3qM/3EYgiUzH+brVraT0jEmNVTRSaqcDT7MmSYbZdFzRtpvOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6300.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:37:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:37:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
Date: Mon, 26 Jan 2026 16:36:47 +0900
Message-ID: <20260126073652.3293564-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0355.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: cac899cc-b9d6-45ff-1dff-08de5cadb480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+D05cREE167GMMnAmJduGG4xdE9D+zYEBkzv/34z6VopbU3dKIEdZuM47RE?=
 =?us-ascii?Q?4rND4Osr9ZKKImBK9doTWOYNSEzAXIN1XiR7RQeEcfYHcCH/KJXqf1u2vNpC?=
 =?us-ascii?Q?I/Usk4awFrc8oSncucvkC+vE/PVE/aZQ74vFXRtWzg3UYw29i2XAswY/yMLg?=
 =?us-ascii?Q?olq0RBBQxrw+hEMSiQLtCmkhB1PrQbyZkrpsx9fy8C1oHAhUL+3fHCOKrrbI?=
 =?us-ascii?Q?5eHVIThev5GTXk80RDyfNcV9Vt+SOX4IBPCgnOyB3QOdDgJB1/1XKzGyCkC4?=
 =?us-ascii?Q?11NP8VDIXYwJQHrl5c9hTK2FllQHc9RCLWy4a1sZVZlBSESk/CH0juTMzOdy?=
 =?us-ascii?Q?GUt16n2xkcUO6GOg+bOesxSFfZ0HLu/cASiue92T5pf05+MkPg3TKg0WZC1v?=
 =?us-ascii?Q?ZqLC4AY8YsIOVzI94wBuaPLunVjs1xP5cM4yndgfaDiR5yIMkI1H7Xhgj5YB?=
 =?us-ascii?Q?kqHnU8QUW8BptBr3F9KbUmmUOTGM3HKzVls+Q6a3g6lZA58FSc432nQIR5SE?=
 =?us-ascii?Q?Vonm5G1GqqLT0ULzU1t82tVH94zXdBmEvfXLLBcelSfaukBY8T8U9nhaBFDT?=
 =?us-ascii?Q?kPsOhRtonUPMxKJuqThvVoOPSju6245g3kfcrlPTnAxcCBiAWs+lVQfjQDEa?=
 =?us-ascii?Q?ijc3PhxDGZFHGmONz0FX2vMeawYg2FD/6Bag2jq/TEAbI/8s8jQKycUiu/1Z?=
 =?us-ascii?Q?Kzy/oYk9Lf2kEi8w+z1i6bu8kll8HPFtTwWNgQkUsi8bNArYyhJc9rAizFr5?=
 =?us-ascii?Q?4xljIhuEGXGjpToRonL92Bu2Zl4iEwolVzSeeL6HheCd4VKgDeve41p5Ii3s?=
 =?us-ascii?Q?R3+stkyUEQyiN7vXNC/xQpWBh5YjyqJls+BctjYwsMQJGQRNJImU9J7zhCR5?=
 =?us-ascii?Q?DDGUH8j1sm7u8LqIz4Kwa9ZvEpN+rJN00GR/3POwpmq1Pb3VlGZVa5BZMtnA?=
 =?us-ascii?Q?H29DHx2KHlWftSl7RrsBalKW2Hf5jFFodaA07g8sjuy+Fie2e8pm0/la5Y9h?=
 =?us-ascii?Q?Q7Seo2dRdgLBavYaDUGPJ+rE1bTt9yuUeyXffpaYstOwx2HNG28XlLPRPG5X?=
 =?us-ascii?Q?X30OnOoVZTu+SWWE4MmBdicxKWYJs3pKwfoVofEGurJERDA5sR7CfsCRqNR7?=
 =?us-ascii?Q?OQoWjeIsfQVNs6aJfUHgj4OkQ5SE/V7ifsM7ePMWAtPA/qVH7QPW2E1XOhdR?=
 =?us-ascii?Q?RCCPy/2G1I0/SYcdUZKC2F4uVFJyaObLSCvEQvFaRNeRuzOFuQqpJYFTVtjG?=
 =?us-ascii?Q?XtY1qX9b4cHtRatfy3XAW/eRhEkH7bwEvg1oqEzI7s/fae7xrNIr+XQnf1NS?=
 =?us-ascii?Q?10OwFlnHoZxlNUlDp52koLInyB4m209C/0QaerUD2HQ/Km9JmRfA5sQhJeyL?=
 =?us-ascii?Q?tht5t6QZVSTnaN11gR9dxgjIa/b8gnNUaOWGHPmu4LU3g+oGtUflqjrOhaHA?=
 =?us-ascii?Q?mGnlOrrW/TrZN7ZIpJynfAuv3zKR8W1w3TWjFc6ZFui8HL81ENl0Qfm/Hpr1?=
 =?us-ascii?Q?zFGnUXSo00+kufW4cvyHnl9+iRFo9vNFqM7USipWmo9IZ+WOLEGHl586i5kG?=
 =?us-ascii?Q?kgAXHOxUWt3BY0yXX0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nx35plO7q58kij6+vX6K3mbfOSVmgmQMBKfTKN3v8Kjr3ubzmyq06nWpK1kV?=
 =?us-ascii?Q?2gX9EQEYGSIY/4cXDJ8VKb3Ucn95DwWpnDHgjgnnJLnDIM1TfKLt9TMCjnM7?=
 =?us-ascii?Q?S74vZreLY3NHqxu7PFr3qu6j/DSJ9KlkEWTx3VzQOizw+U6qQbf3mOrhG76t?=
 =?us-ascii?Q?4HX0Ufus09RW6VcGCyIPTk37p+OIlwLgVKPemD1cy9suoCdb58Ed6BbVqs3A?=
 =?us-ascii?Q?JOiaCvuALyoeeD4vF9epuWu/ry6hlt2UGs2bhSdXEl3y7aD2PDPX/LoyRw/d?=
 =?us-ascii?Q?QtYWpcarGj0Yb47p4vGR0Es0yTFGUNTjMzDMxHbU/puIWHQYRDMjnq6qndzu?=
 =?us-ascii?Q?lrZd+i0Zkrac/c1j/njmGWqiMa2pIs0OgNWjgHASVQ4go6WlXk1HFmPofsYu?=
 =?us-ascii?Q?Mb7O38xGqH7KNwwIM6Y3QOzd/5wEgsJapx8O/Bpjy7IYRnqDgcAoktHWcTUW?=
 =?us-ascii?Q?4ps1cyLxwtpCPtoAcaIl0toB7Om7SFBeItjGuU1u8pO0gxRCo9Gwm2XACn6B?=
 =?us-ascii?Q?tof1/grFSPv0nqojRuA8mZvOvCBPigFNrFQ56mZHzP2ECtqKOkQjSRBD/Jug?=
 =?us-ascii?Q?AmRjYdBUwNAl8VoK2yXEmoZwvC/QW8HyWXR8YKu8R0xsjAx/Q2Yz0AK1llBh?=
 =?us-ascii?Q?zvByT9OhC1RWlbjgWa56ywncHhHZ1HU1+gnF4i59hZ5LcDBD6AA3MRFXjFTu?=
 =?us-ascii?Q?8U/h4vaPp39JHpx2DpsVklPLUYQcMhN/SKBBv1HuDuUS7MotkF1W9Y3zlEOZ?=
 =?us-ascii?Q?iDCHUWEcNhme4rv0Hf7wRcDnRX+NWXR2NTt8Mpxtr4DCuW+AOsfXI5u180MU?=
 =?us-ascii?Q?038ZvsF1GeJx91+yK+83zeM6u9/PxExzJIEXnUo33zufo2HAVYUDm2T86zoE?=
 =?us-ascii?Q?/GgqhNQMo8G5LMu5SlOBN62UI0LzLMNHnJZomfl/plMUkX1x7+j0+I+xfEA4?=
 =?us-ascii?Q?Ggl4k2PVHAGJAhIKNxzYeiWLQZWjt6PyDyZVbxrZ5a6CJ7JiGSx52yENKa3d?=
 =?us-ascii?Q?IkuTHbAMOW28LEzga7IgJI52sBimPO+CSfr0RIrRszUHOPRH6hDY8zFe9SCK?=
 =?us-ascii?Q?nZ/ojr6TbzwQ8K0rFfzZOfeQK2CylT+GLtSqnkC9JCqyV+ia9UjqcsUZzPkp?=
 =?us-ascii?Q?7/dBy7AugmSxwk4NwkOYekbHyMMdacEcKN1CAyIL73dd2XVhd/iBajoqWl57?=
 =?us-ascii?Q?KW2KOrvSF6mXLAXorIRVmDH51CYwgfCxn+EpFXm8960bkT/0BRAZpDG6FsDC?=
 =?us-ascii?Q?FkB9IbSvk/UODzqeB1jH2qWrGPhCxa8laxl5pG4FzJyFVOu9yEzdslyjKjx8?=
 =?us-ascii?Q?wEAU8G8hjVZ/DWCWC5nuskMAhGZf2uNfWNjHs5lanTL39m/0yhW7POyd9dRz?=
 =?us-ascii?Q?65A1Ge6NbrSYM1jN9xxOY1ZYx7HZgJHyfeOWIXfRBloUwq/X59GAGQvSjJdT?=
 =?us-ascii?Q?5ZRpWyqXJUfVmauO9/JhFds7Dn4nkNcsOejA/ZjJYy3AZ7zbEsskyGNSW+qc?=
 =?us-ascii?Q?BID+DgATt8BQ4+421NI7y03hikT4Nr0lrLWNmhULMUrg4I2Nt4wNMXNopliO?=
 =?us-ascii?Q?fmkOdCvv/Q2nqiMIxJvdqFYM+VIUEbSTnA/vsbFvKTowybdUBVhV2Dc+5kk3?=
 =?us-ascii?Q?gLg8YjrFAULnc3vkFJDUPDUk4y7B7L31+CTdQBTYgn7WF5Z/pSRQjE0mu8SC?=
 =?us-ascii?Q?4ivxTp65VhcxB7lHxy8/m06DKK0E/cRD16dTesz3iSaFlLOonqDQBarABiSx?=
 =?us-ascii?Q?9xVhg/SosiYNOqmBUgp/lIOQSv9v8psvPYEh1EJi5uqPkRQr9aLf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cac899cc-b9d6-45ff-1dff-08de5cadb480
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:37:06.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFM7I0GouirUZnFFCHp3j/HZIT/7FBhTfwxa+oRccw7NdWs6gSaQOt04lav/SyZpch7wQJUCXYkVwyG2MtWT8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8480-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 47E2C84E17
X-Rspamd-Action: no action

This series proposes helpers for remote eDMA use cases (e.g. [1]):

  - Add an optional dma_slave_caps.hw_id field so DMA providers can expose a
    provider-defined hardware channel identifier to clients
  - Report hw_id from dw-edma
  - Introduce per-channel interrupt routing control for DesignWare EP eDMA,
    configurable via dmaengine_slave_config() by passing a small
    dw-edma-specific structure through dma_slave_config.peripheral_config /
    dma_slave_config.peripheral_size (as suggested during RFC review)
  - Add optional completion polling for channels where local IRQ handling is
    disabled
  - Add notify-only channel support for cases where the local side needs
    interrupt notification without cookie-based accounting (i.e. its peer
    perpares and submits the transaction descriptors)

Note: a companion PCI/dwc series ([2]) was posted separately to expose the
integrated eDMA register and LL windows keyed by struct pci_epc. Users can
use dma_get_slave_caps().hw_id to correlate per-channel LL regions.

Note: stm32-dma3 implements .device_caps, but it's untouched in this
series (i.e. no patch adds 'caps->hw_id = chan->id' in stm32_dma3_caps()).
When a concrete need arises, this can be addressed in a separate patch.

[1] [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
    https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/
[2] [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
    https://lore.kernel.org/all/20260126071550.3233631-1-den@valinux.co.jp/

Developed on dmaengine.git next:
  commit: 3c8a86ed002a ("dmaengine: xilinx: xdma: use sg_nents_for_dma()
                         helper")

Kind regards,

Koichiro Den (5):
  dmaengine: Add hw_id to dma_slave_caps
  dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Poll completion when local IRQ handling is
    disabled
  dmaengine: dw-edma: Add notify-only channels support

 drivers/dma/dmaengine.c               |   1 +
 drivers/dma/dw-edma/dw-edma-core.c    | 167 +++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  21 ++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  26 ++--
 include/linux/dma/edma.h              |  57 +++++++++
 include/linux/dmaengine.h             |   2 +
 6 files changed, 249 insertions(+), 25 deletions(-)

-- 
2.51.0


