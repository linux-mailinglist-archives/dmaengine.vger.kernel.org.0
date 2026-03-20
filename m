Return-Path: <dmaengine+bounces-9569-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB6tNY+qvWk8AQMAu9opvQ
	(envelope-from <dmaengine+bounces-9569-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 21:14:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853312E0C10
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E723306B9E1
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446313C9EE3;
	Fri, 20 Mar 2026 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="a+wDTiBk"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011025.outbound.protection.outlook.com [40.107.74.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C837757B;
	Fri, 20 Mar 2026 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774037605; cv=fail; b=Q26uV1ce609Hj7zdpzwO+EZC9G/nMB9UwOWlEa7VcGosYuVZb21kVfUkgQOIgY0UkrZYFkTidMKyIlZ7gaNt17AMF0GeIjuuXN+W5SZ6H398puqWUaaLbFnGGoehXFA1P1K81gkNfJgydj//9HDJenVFf3zb+MODSP/pfQ/8ypo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774037605; c=relaxed/simple;
	bh=q8uj1qEajuVhjmccNqvsyS03eX9yQ50roYYO5bojJiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XD/VTOXOb7NiOGSB1zuaxA/ViiaV68TkY64YTxudzIpBYjFKqfX1yVSnC8XOpJk84hT5ryh/dk8q2nv8V1Io7M18tgX+5rlmx1pliaBt4I2e081tOWMKz7GwrwYmdpI6dO+OYtthmgi6ihsuE/4Jf8xNw9qlN+V/cEPbnSs9doc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=a+wDTiBk; arc=fail smtp.client-ip=40.107.74.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLZW96jggoWOjyI7cyv7rcQM3/8hVpMkwxWcVcpGUHvaI4KxpnN+gnwYlhY1tBV0C+MePIDGpMhQeG1kxZWY0uMGoTz2aMBMmEIoCcDQNuoZXfPOan3VyHxGvyFPw0Uv4IcRYsOj46XKknnx1JvvsJ/r3dnYkejudeo/ojuhnqUNCc9MNsTD5TPKmxjY9Z2F+KgTK8vG2kueNQo5VliSq7fJ10tOabOQrLDngH3NPOXZNa/qFZ7E8cX0meR/2k+56nCDM6OTqesKTyQlvn0v7RcZPZRKoYJmJX9xuKHfLHVHqwW5ktO2QYAFlK/f1kC3z5evh5PsbMYXgLcyTH9f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BsAgp3/n1V0LU5vnMJYjN/AEWXjIqjBsnULvVjoiZ8=;
 b=NqVHAqdAqAcKXKG56oK27pl5gWnOkSmTxY9S23KBPZIIhqQd/0KY4HP2xT25DFvCE1fMmZFno3Z24YiGHj7+FW8n5aBFO6/KfG9PojGW87CIuFmLsdugX7TlbOK0bnw1nVzxk5pq7NIlJ0NALwNd1sLLFev7OavaJiwIrO6PpcI1ftykUN56MOORxHpo/ZSW+7t6UsExIxoxAQirNdimKyeRyPOkEFZJm0E5pkxjH1Qhzn8RNMi6A6DVFo5P0dUg8s6Ha+OitlW8+RGHBuBWxgKpxQETwSNh0GnHsKDqQk/ajJvS2Ty8vhHo7mFTkBk4kWc0aMOodmjR/MfaRC4TgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BsAgp3/n1V0LU5vnMJYjN/AEWXjIqjBsnULvVjoiZ8=;
 b=a+wDTiBkhN64lpFih9wl+99S7XTz90aP5jlsRwIWiML/cWlySMdiGbwwnlBdWe2g9xuWqW1RLkjYwS/9FZLavOpg116XwIj+gW/LrsMwMsdP48vMCF1xAZEBPT57ihT9yuInlV6PgtZgWC8vUGSpVhik9zmbHasqbgVbXsP3jyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB13146.jpnprd01.prod.outlook.com (2603:1096:405:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 20:13:19 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 20:13:18 +0000
Message-ID: <c46836db-98fa-4323-b4fa-93af47ca0958@bp.renesas.com>
Date: Fri, 20 Mar 2026 21:13:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
To: Claudiu <claudiu.beznea@tuxon.dev>, vkoul@kernel.org,
 Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
 john.madieu.xa@bp.renesas.com, kuninori.morimoto.gx@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com>
 <20260320112838.2200198-6-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20260320112838.2200198-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB13146:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d2e5be-ed27-44b7-a940-08de86bd204f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	6HRwoXbrLxNN0HyO1VMTgCz2vOjoMGyCt7p2xbN++GYOVpbZ2GoSAP1ywtPrBF1GEAWKUx/xBNI5xDNiGLrhbHzffFS/0Y63tdEhcWkfpGU7hpz5xj/sgJOWMwtf8HfgcJUV9YrNzIu7k1wIMOse75q5ei7soHEr5rHhbtSYY8NvE3pT++wO946qP76S6A21GLp8xFxoNlO4mXi+tl8AdfCa/bqT2od8aLYU8gHhvwM+nBkL3wC8vWE0LvEXLWsqqM8orAUtv4wJpZUUD2KrQMRx7WBGLN1hy2VUMRGDpl0lBypEIUaWDWb6GmOI5+PJ2pt1JdpYiPpRYlPLgWfuNKBdYOBihIA/jrRE3Q9IQ7T9+mmRxbiKNwBWvU2Ib0ou04/NC6j3Tnp1dUdmCsxLQ+SzquU3rdiCf4x3QjO9VDvBuDoRz9R4GavmO0TUlrs7rSfomWMeMJLwa/reT1L9ldC3l9v0ZihkmcQAkvc5oz5vvdTxnt46f5YoQknY6IPZPT8Yu9tP8YVdS3YjWLk0yM55Uj3Zh/il4mhfLNBxfb+BxbMvGRr5+l4+y7f+L49rKC9MvMPMjPAnloFb8LQR6pFkEnFNmip5+vFOl55OMSS35grHjdQg5CaeqAgZfzzptQE/Jsx50tVSiyFgVlZssCvSBVXrLCmY1TQSdp+fPjOcs89AEvpFk7xFv9A9WiDheNkRgGpTe4/0K1IZisv5C/cjXtb3m7nByk5NNcGa7gt4EW7ewDzTslDIke+2t+ce0Gc08d12IZ7vNHzsPm9YiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjZVM3ZZZmVOd25wNnFFVVZCaXIrRkhPNmVLN1NTVG9EU3dTK0RxaFZvSTZ0?=
 =?utf-8?B?RDRzbWQ0akl1Z3l3TzllSzI0QzlVV0l6YlZhWFJmc2dhSEYwaTlMSlIwUHBz?=
 =?utf-8?B?cVdRSmtVNGRNYW42akN5bU9KcmZ2bS9ZcGg4Y2dFc095VUtZQ2FEcXNXK0xH?=
 =?utf-8?B?WW9LbmQ3WGgxYzRxbkpFM21mUDVEQ3o3cDhrcWc1cmdreVV0WjdNVWlldFh0?=
 =?utf-8?B?TitUNzlsMHREYi9nTUQzazhWWVNNeHd5MnRTSGlHNFNFSmdUOEdEdVJwTnVC?=
 =?utf-8?B?YXB2c2ttV00xN0hVaURDbDlUR2d6RExzeDBkMkg4NXQ5K3lHSzc0RSt3RjR1?=
 =?utf-8?B?TFErRFUydWFjZjl2UkRGc3B3Mnl0SzlMK3N5b1l1cDlEOFFnRjIyZmg0Q1Zo?=
 =?utf-8?B?Z1pmVzl1UVlFcXdpYys1TkRxUEc3VE1PYWpGeEd2UWU0cEZkdVJ1Y3FFYk11?=
 =?utf-8?B?SDZPeityYlZzRXp6Yk5MM0lNaFIrdlN2UVBBaE4wYVpObDZobE5ZVG1jQ2Q3?=
 =?utf-8?B?T1lwazIzT0pFWDIvMHV3VnhxN2czbzVMZTVObFRPeFlhdmtiQmROTW1USUFr?=
 =?utf-8?B?OVBzMmduRFR0bXJiZ2NMcUxGOGtjcHNPbHg4K21zZ1oxQmIwcGdQN0tvenh2?=
 =?utf-8?B?L2VISGZEcm9CUDdJU0FtVUROOVBDMVBSTGp4dUU2UnBpMWtpNFhqekdzcmY5?=
 =?utf-8?B?dW5HT2tNTjI4UHloQTVTUEZuQmcvc1NSaS8vaHhjTFg4dzZRdDFhU2llYklq?=
 =?utf-8?B?VVp6M0FVejBwZFFjYjgxbnB3dEprQjUyUEJFZ1BWbWhYNFJDWDUrQ0RiY1VT?=
 =?utf-8?B?a2d0dEhTWUFrOUdXcVhURzBvY3RYZmhuK2d0UkJwejJYL0MwdnI4eVdjanVt?=
 =?utf-8?B?dk84c1NCN3UvQnVmcHVYWDgyWExLTG5DemMwOFpxYm5WbFAwa2cyclZ6RGUy?=
 =?utf-8?B?cHAzbmk0WUNnbXc2Mi83bXNKYWRBbTQ2enJhdjVQR2E0TmlZbUc2U2J0MTZT?=
 =?utf-8?B?SFlyLytlVjc2Vjlaa2R6Q0dkVDdmL2ltOE1yblBOSG1QZE5GbEhidHdRdVll?=
 =?utf-8?B?V2JZaFVsdVR1Tk5sU3pqRE52cU9yRUg2bDJzVnBGUXduSW45ak15a0lrdXpm?=
 =?utf-8?B?UC9pZmF6ZTFVSHVuMnFlVVY0YlhjQUk3QUIyNTN2NXBmeU9qRnR5UnNYMGNY?=
 =?utf-8?B?ckNRUmNEK0tLMzZvZnQ3Mm5yNm83a0RYbDM5QnZxTzlGeGJxb2NHaDhvYlMr?=
 =?utf-8?B?QXVkVlMwYm5hZjJQRlNJMzdRN1FDd0RzblpHVEM2V2oyTFZtbm1nTElHbjl6?=
 =?utf-8?B?bGczRTNTdzRrQVJ1SUIzZ0s2Uk1ER2xiTXNNclhRRGY4S2xmdHA1MG5MK1ZP?=
 =?utf-8?B?UEtoNlpWaE94cU5XZDg4ZWdDcFV2aGhRaFBWZWZaNDNTV29zSkJLbVkyY2Y3?=
 =?utf-8?B?eHlTbnVRakdEZEVLdys3Vko2VEFaZGpQTmxycXRlWUQvNmlHNXF2TWU3RWlO?=
 =?utf-8?B?NUxBdGZDWkpsdk5WM2kvYkhZMVFPb0N2aVBMcG8rd050NEFMcXdKSm0yc09B?=
 =?utf-8?B?c3pLRGZzbUhMYkpHSC9XZ1RPbDh5OUJpeXlxajI5a25NZGdIdVl3ZDNQcTdW?=
 =?utf-8?B?b1RnbTFFSEFDMDI4eHJlYkp0VHNpOS8wOFIvQS8yMUt2UlRGa2NpbG1kQ1I4?=
 =?utf-8?B?SWlyc0QvUEprb3ZWT3BZa1k1cmZxOUVqMVptVVY5OTdOTmFwMWsyYUFGWHl0?=
 =?utf-8?B?eTRBblY1dzVkeW9pWFExYW9zTVM2RWpnUmlrZjVtODRkU2RpNVVoQlpJMmRm?=
 =?utf-8?B?OWJxVnZzb0Rwb21iYXJTdC8ybHZxTWMvY2NBTVVrK0tSTlB4MlB4MUpLbzVH?=
 =?utf-8?B?TVhmZHo1dkYzRHZtYTJlZzJDTVZmcldDSkpzaHV1bVhZdGFpY0d5bStqWVIv?=
 =?utf-8?B?b1I5WlNPcUlOSVAwVk8rRzUzQi9jdVpHRERLb3dvLzBVNmlzbnJoY0UxL2pp?=
 =?utf-8?B?Ui9DSGJ0Y3ZKMWo1OE0vWGQyQmZDQ0ZteVJNMmQ1SC9sOU84RWVXSW0rNzRr?=
 =?utf-8?B?YXQ2WHNNR2JjaDBBcVkzS1VOZ2NNSG9WUFVyVHYwTFU5QUVodG5RQ3VmNFcv?=
 =?utf-8?B?SE82azVreVVKaEE5VWZGYVROUmJKT3J3Z2VwZDhFaXcrc0w4ZXdhY1NMdzZ4?=
 =?utf-8?B?ZXRXOFVaWi9ndmxUSGFoT0tSRHY1V3ovRW1aRG8xZDNPVHBxL0hzKzg3MUJT?=
 =?utf-8?B?T29TMDdVZzNQcGl0VmZpcDBBR01WeU1EanVvYTF4VmtZL3loeUZ5TENudnMz?=
 =?utf-8?B?Mjl1NlBGY1pnT1dWWDhUMkUxZHcxbXVMcUpiUkMydHJsbkRmRFpsRSs0WVZs?=
 =?utf-8?Q?n2cp0WianZYgaL12AyUTiw7tUqCB0Aj+qMHG9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d2e5be-ed27-44b7-a940-08de86bd204f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:13:18.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXuR5bAs7kjh/mh0vyf/sONft5EIqibkdzsM057vhrfjKqDV5TzFuE3KAFM9lNRSQeLAOVygwpJtNfLiLur+7w1izSdTOGZrzO13qQlD8j5BjLuBUWaXvBfd+SLQ1DJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13146
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9569-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 853312E0C10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,
Thanks for your patch!

On 3/20/26 12:28, Claudiu wrote:
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
> paused and resumed as part of the system suspend/resume flow. This might be
> the case of a serial device being used with no_console_suspend.
> 
> For non-cyclic channels, the dev_pm_ops::prepare callback waits for all
> the ongoing transfers to complete before allowing suspend-to-RAM to
> proceed.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - fixed typos in patch description
> - in rz_dmac_suspend_prepare(): return -EAGAIN based on the value returned
>    by vchan_issue_pending()
> - in rz_dmac_suspend_recover(): clear RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED for
>    non cyclic channels
> - in rz_dmac_resume(): call rz_dmac_set_dma_req_no() only for cyclic channels

I've tested this series on RZ/G3E.
Suspend/resume support DMAC + RSPI is now working fine.

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>


Kind Regards,
Tommaso

> 
>   drivers/dma/sh/rz-dmac.c | 185 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 177 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index ca8c0aa8ae59..6f83ccdf94c6 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -69,11 +69,15 @@ struct rz_dmac_desc {
>    * enum rz_dmac_chan_status: RZ DMAC channel status
>    * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
>    * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
> + * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through driver internal logic
> + * @RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED: Channel was prepared for system suspend
>    * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>    */
>   enum rz_dmac_chan_status {
>   	RZ_DMAC_CHAN_STATUS_ENABLED,
>   	RZ_DMAC_CHAN_STATUS_PAUSED,
> +	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
> +	RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED,
>   	RZ_DMAC_CHAN_STATUS_CYCLIC,
>   };
>   
> @@ -94,6 +98,10 @@ struct rz_dmac_chan {
>   	u32 chctrl;
>   	int mid_rid;
>   
> +	struct {
> +		u32 nxla;
> +	} pm_state;
> +
>   	struct list_head ld_free;
>   	struct list_head ld_queue;
>   	struct list_head ld_active;
> @@ -994,10 +1002,17 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
>   	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
>   }
>   
> +static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
> +}
> +
>   static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>   				     enum rz_dmac_chan_status status)
>   {
> -	u32 val;
> +	u32 val, chctrl;
>   	int ret;
>   
>   	lockdep_assert_held(&channel->vc.lock);
> @@ -1005,14 +1020,33 @@ static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>   	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
>   		return 0;
>   
> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
> -	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -				       !(val & CHSTAT_SUS), 1, 1024, false,
> -				       channel, CHSTAT, 1);
> -	if (ret)
> -		return ret;
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED)) {
> +		/*
> +		 * We can be after a sleep state with power loss. If power was
> +		 * lost, the CHSTAT_SUS bit is zero. In this case, we need to
> +		 * enable the channel directly. Otherwise, just set the CLRSUS
> +		 * bit.
> +		 */
> +		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (val & CHSTAT_SUS)
> +			chctrl = CHCTRL_CLRSUS;
> +		else
> +			chctrl = CHCTRL_SETEN;
> +	} else {
> +		chctrl = CHCTRL_CLRSUS;
> +	}
> +
> +	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
>   
> -	channel->status &= ~BIT(status);
> +	if (chctrl & CHCTRL_CLRSUS) {
> +		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					       !(val & CHSTAT_SUS), 1, 1024, false,
> +					       channel, CHSTAT, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	channel->status &= ~(BIT(status) | BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED));
>   
>   	return 0;
>   }
> @@ -1026,6 +1060,13 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
>   	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
>   }
>   
> +static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
> +}
> +
>   /*
>    * -----------------------------------------------------------------------------
>    * IRQ handling
> @@ -1430,6 +1471,133 @@ static void rz_dmac_remove(struct platform_device *pdev)
>   	pm_runtime_disable(&pdev->dev);
>   }
>   
> +static int rz_dmac_suspend_prepare(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		/* Wait for transfer completion, except in cyclic case. */
> +		if (vchan_issue_pending(&channel->vc) &&
> +		    !(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
> +{
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL))) {
> +			channel->status &= ~BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
> +			continue;
> +		}
> +
> +		rz_dmac_device_resume_internal(channel);
> +	}
> +}
> +
> +static int rz_dmac_suspend(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +	int ret;
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))) {
> +			ret = rz_dmac_device_pause_internal(channel);
> +			if (ret) {
> +				dev_err(dev, "Failed to suspend channel %s\n",
> +					dma_chan_name(&channel->vc.chan));
> +				continue;
> +			}
> +		}
> +
> +		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
> +		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
> +	}
> +
> +	pm_runtime_put_sync(dmac->dev);
> +
> +	ret = reset_control_assert(dmac->rstc);
> +	if (ret) {
> +		pm_runtime_resume_and_get(dmac->dev);
> +		rz_dmac_suspend_recover(dmac);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_dmac_resume(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = reset_control_deassert(dmac->rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(dmac->dev);
> +	if (ret) {
> +		reset_control_assert(dmac->rstc);
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
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
> +			rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> +			continue;
> +		}
> +
> +		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> +
> +		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
> +		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> +		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> +		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
> +
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)) {
> +			ret = rz_dmac_device_resume_internal(channel);
> +			if (ret) {
> +				dev_err(dev, "Failed to resume channel %s\n",
> +					dma_chan_name(&channel->vc.chan));
> +				continue;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rz_dmac_pm_ops = {
> +	.prepare = rz_dmac_suspend_prepare,
> +	SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
> +};
> +
>   static const struct rz_dmac_info rz_dmac_v2h_info = {
>   	.icu_register_dma_req = rzv2h_icu_register_dma_req,
>   	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> @@ -1456,6 +1624,7 @@ static struct platform_driver rz_dmac_driver = {
>   	.driver		= {
>   		.name	= "rz-dmac",
>   		.of_match_table = of_rz_dmac_match,
> +		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
>   	},
>   	.probe		= rz_dmac_probe,
>   	.remove		= rz_dmac_remove,


