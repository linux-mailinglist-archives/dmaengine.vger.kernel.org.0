Return-Path: <dmaengine+bounces-11008-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOpnMutJGGpoiggAu9opvQ
	(envelope-from <dmaengine+bounces-11008-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:58:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BF5F3356
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C69A308CE9F
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17426E142;
	Thu, 28 May 2026 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sTk6IrT5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011071.outbound.protection.outlook.com [40.107.74.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A885B5AB;
	Thu, 28 May 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976257; cv=fail; b=oY0vT6sm5mJWe/jPG6XrxeuQhHYSn+cn+QB1m5gczeBYikurbkXvLdJfdr0q1EJoEeXC6XxDZbDK+u5ocor4SL8WzY7PLL3MijfrwX5YchlX9Am5Ml3LQdrv6WAmXAYYcgePdJymdTkoz4Ue69Gz4O/lhhZhresZfK0H0E3VKzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976257; c=relaxed/simple;
	bh=4PjT2npNBJe8ObGdUXpYMwN72qwUC5+aPWLJT0R+H6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KfTDa+MuyxKTr/MbUEK+OEKoi1f3BtXcGLEgbQJ3IMLAJcu8qOhJqaWqYB89G8zNs+7vULRJIMejHodGE+OalNvhulS6z0EfHDS+lLxs07Vzkps8Qldn0lfE9xWokzCgxYbUKdd43IdUe2wkkcFeYyWL4RlB3X21E3M53X0TSkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sTk6IrT5; arc=fail smtp.client-ip=40.107.74.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmZKB0+28/8L+YEbzN7PaU0VVK81tK1esGShmL4H9kkkz86vOBobol7CSymj5iQZuhoNysj61GliBy0vx3QBzqomi+TWPYEYdRAgXFpPJny+55pwU06HZzrqXE747/3GId8r+lAsWQggnBAKKQZSYJT/RW/n7pNh25JoqyZon86Ql2YqlIaH5wP7HiDFHy0Sk9xFY++OlrjvBRchOlhVNF7cm8woop8ZlQpVVP/WTuSeLxwGfB8nY0VnytldAdm6Nn3NfaX/8uVShnAIHLn7XpzTWhPWMucwpg0edELD03lUq1xldN1q6bcfH8Ybkac4AHCxHCa2uxzJz5G+FKeO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ICX6SWaysZ8zw8Ehhm7MFmQFlBpAi/AxISfe/N2Xwc=;
 b=t03Hnrcbu5EgE2EXdw0tC1aE63xdemhlDmbwZ+u7pb9zAN1KCGzOvyNaz7/lHcA51ZlF+ix0f2+hHBFs9pCg71uKZbbGWrEgWLKEt1kc8jsvroSbz1VjHXIYlrsdGs7r4CYxQ+iikOpqYZ4dJoM3anhIgPgX5SN1ijJx/NcVj9W5vjuHnp67Qi8WyU0/AIAUluLpuwWaHcmYJaopKmt68ANKaKUQBssas2NQ+D7qOPEzCsdhbhR+38Tmdei60uZzLkDKuVrTnqnt8JNCrzEkwi1yYxrx0if+OT0mcZKE/L776LViVRmfsecsBC7kuaQE73GU5ZLaGaZC9IHy44e5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ICX6SWaysZ8zw8Ehhm7MFmQFlBpAi/AxISfe/N2Xwc=;
 b=sTk6IrT5tk+5HCfgdW4DuL9qaeARPQPlS1QIIHwSiX87nTN7tKFqzhGD1n+XHjiB1AMDv0iS9DcK1gxpBS/HYEzN5aKG6tRHRlRCHoGruLg7jqDH/8LDdhOGsHQnFCgaC2lFPt8GazNFjM57jgUfWkT0q6x+vkxbNJ3gUjAI80c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:50:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:50:53 +0000
Date: Thu, 28 May 2026 15:50:39 +0200
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
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 11/18] dmaengine: sh: rz-dmac: Drop the update of
 channel->chctrl with CHCTRL_SETEN
Message-ID: <ahhIL5FxD1qGZJAC@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-12-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-12-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 732d4ac7-2574-4516-ee54-08debcc02238
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yjkRQpn9pYTOPiX6DFhmmLAvTtSBIBScS1p1twPFTicDqiOeKMkaeHhy8lhwKDIAaZzq7MyBFomVbwSmovgegRJsL/MUMBsVdMbAzND/H7VgxZu7xZ6huNQEjx0p8gpnN4Hoy5Obo8+QippY/UNteQxOh4goacUaL0H6kGmoS6Hc9VKr5wEw+Q3r4xDjcgb+O/ILLs6hzE1Rm7+Ttcdj8J9U2fh0WShR/ti3yNybFXxLfos6T7JvZh6briqJq88fPGY5fLmRHSApMexslMTtXPuMg6IW7sddyrITMBS6c+HAedfZVR7pbqH2L/G3l3sOnLsWx4744iuZaND747GoQTZUEQ/nGYYi8sZ9D0vdVRBI5k5aJXcZUIgcptazvmdiP+NvWrCG4+LfIdT1Z7yOeezBYnDq5/g3w6fC+4S7Mp9p6+EVra+0tWNnZl9iFcEwtOSaQw3xKYP2IOosHtRrJF3EeF7xruJAnCNSg5aaBlP/4/D9oS+sG6xUE/MS9+QAo1pObxro9FqMXtuT9DGX4YiSVeqe4BvquyFr9y7mOR+wp8pwzhE7h/vplMsyxrHY2ie300mMPSb3z3XomC5nLuY8BA5+lPawl92b3DK00HtoD3ymv7s0GBqcgo/M4hqKiJ98dyTzRauWc8I3nXxf1d0ywPLeL5mSI4sl51IMg8fuWOfhA3QRUlok+kkFejcHjr2kITKGEN6XUYGQRc8v9zm4vRlz5Hvs46bjcViJQcKWZAzJjucmbBNDFzFPL+Rv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjaZnZFBWUoOwI63f/Cmb25qIWCq/VmJKXLr97YXbO90m1mxRk05W24GrV9o?=
 =?us-ascii?Q?s4HatNMPI3WEFcV3b+GdQRxLJHUmgQsC5ALghntxEO4JcM4iYvoUUvQ30Ffq?=
 =?us-ascii?Q?0Z+/o2BLh13nsUTdQcfRH7A7ML3ryqqswBbacl8P7wsU1y4FPSFOMIUu4cPe?=
 =?us-ascii?Q?WbgWiZhgnX8lPrLh4QrvzhsU73dQ7WLairkQfTsEW2fInabHUo6C9pic1WHj?=
 =?us-ascii?Q?s5fOEsEX+YLj4N7AbY5XwM4U48LtHflSGgEz9pnf+ifFCY+AxHvFzrzWw3ZQ?=
 =?us-ascii?Q?MtYKFwM1Xu2J5tFZZVilyLn+Vp0Q1nMmbl6GFGJYkCww7KgVw+FPT5TQJTFE?=
 =?us-ascii?Q?OR6q405/IhmjMjqMQiMc0qnBqmC0TRxF5pFB1EqDIWYbuqK+6RAOqJVj8lLz?=
 =?us-ascii?Q?sHTw5IKfttc8WsexNd3KBfT49Pkv+6ICoAL7NEW/irflszpAoCqbhpVG/274?=
 =?us-ascii?Q?Tz06uwFqNsixlWRMEPFRPU7x6IjMC/xLo0Jsv7x8vAFbXT32PvS8Yd1b8PSZ?=
 =?us-ascii?Q?0FOksVp/bCnvget2aZhZPLk5LAvGiB6+SMAiOALzmCZDuSDU8VTLFPJsj+mJ?=
 =?us-ascii?Q?J/tMlzGQipL/jEDlJJHashhDxQIWCM7/mkCYF/B7I4nWqN9egNgNQdx/g7qZ?=
 =?us-ascii?Q?LKXVSP3x2HLIom05gsOOlvVVM0lPnHFlvNS6iICLQQbWqBctxhO71kRRHgjI?=
 =?us-ascii?Q?kQY/EyEEgJ/mYaDNCuvIFsBWLyEzGM0Td0sMm6V4MyneQAG4PylNcCn/WNVi?=
 =?us-ascii?Q?M/e6qsBdisp8fUsDUD7InschpmjXgD9wi1RH1mvphMg40CKfVmZ76UdyVjG7?=
 =?us-ascii?Q?bFgf4AjrjcD6tCV4+8VD/4zORiZC2TvJJHB6ztODgjo2NEt3jjmcC29uTbH0?=
 =?us-ascii?Q?ITNxF4NZ2AB3zNANgJMqucbPFewcQ8S8XMpS9th733TgtX8/5JRBqFDagSyo?=
 =?us-ascii?Q?aYhyqiswTbhVcAG4fcmLTvmNy3L5q8Spp054bCuYx8+dBYN6ZGrFzhuILykQ?=
 =?us-ascii?Q?dojExCS4C3ZE74rO4iijBn5e1JqPKcUhPHV90Mb5uME+wS9c3OXM4CkyLi/x?=
 =?us-ascii?Q?RZG/iJY+iUCuo1oXBQz+KdjKm7qKSG7ZS2m1eZh/ERZTPRKgQmhzepmlF5XI?=
 =?us-ascii?Q?G0gCpvONzX+c/kYLcicpy04r9TO6RduRnc5mWrQ0/VaWQz83aPz/KlqTMLXy?=
 =?us-ascii?Q?y6hTzjOnPRE/9qJ5EzvhGUKMYnSUMVppB+LKEMFBBNAE6Sg6uR5Z3xPEe3T5?=
 =?us-ascii?Q?LOyCuxhq3eE5Ydl4A2erI9WMHp2Faex0b5hXZdER/wGL5SmL9G4uRdGPCDmH?=
 =?us-ascii?Q?DcEK5Cx7e70bsLDnpu4BMUcPp6IeVROodGnOAzIVB3Nqg9QOkU+P5uySgIk7?=
 =?us-ascii?Q?0W3IfOq53Er9g52ojjfChscU+r/DkNrPrQt4H8weaCOWLftUPwaLOOo7SZk0?=
 =?us-ascii?Q?Xu6Qb1N89EzHL/1oHlRVxcqT88YeeIiwwdKLflaERmux55hWM3K/6mdnTzf8?=
 =?us-ascii?Q?QUi8dl2mCKCxVe0DER6B3371uWJGYDCoyt8pJqnCEMZuaCEKUqR8lNb6unbX?=
 =?us-ascii?Q?xH7MgjKDd3Lfy/PxEOCk3Nf6tkkCbGYzgLapJ2Fh6GDLqzcAVCGQfTuvl+pU?=
 =?us-ascii?Q?jXsFxFj4yGNkmSL6+B3bTuNOVRmNJbYyC0Zf+2EgdqhJx7wNngKrci50iBk/?=
 =?us-ascii?Q?U81/4JwMGkItdz7qJQtYtuOlGbzn0kF7qUyDYkxWndPgWEq2mGTl0ekKuj+v?=
 =?us-ascii?Q?D5WNZfC+IOqIzf1QkCoUBheF3gL26jvnZQSr8xTq9j0bDgXolCEs?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d4ac7-2574-4516-ee54-08debcc02238
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:50:53.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BR73Ly8wRHXwNq0Y/YDyaGZncK22gEIvlLPj07+IlMNlWhVCSyZTrqRXMqVV55rawJhrFe1/tCcidDOk1bBrU8lfBzAbQEFZH2FVf4Wr13a5/+aWPPu5dVCAoIHMcb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11008-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org,nxp.com];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:dkim,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 248BF5F3356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:03AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
> struct rz_dmac_chan::chctrl with this bit in
> rz_dmac_prepare_desc_for_memcpy() and rz_dmac_prepare_descs_for_slave_sg()
> is unnecessary in the current code base. Moreover, it conflicts with the
> configuration sequence that will be used for cyclic DMA channels during
> suspend to RAM. Cyclic DMA support will be introduced in subsequent
> commits.
> 
> This is a preparatory commit for cyclic DMA suspend to RAM support.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

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
> - set channel->chctrl = 0 in rz_dmac_prepare_descs_for_slave_sg()
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - fixed typos in patch title and patch description
> 
>  drivers/dma/sh/rz-dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 557364443a5f..c9c00650ddd5 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -377,7 +377,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
>  
>  	channel->chcfg = chcfg;
> -	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
> +	channel->chctrl = CHCTRL_STG;
>  }
>  
>  static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
> @@ -428,7 +428,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  
>  	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
>  
> -	channel->chctrl = CHCTRL_SETEN;
> +	channel->chctrl = 0;
>  }
>  
>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> -- 
> 2.43.0
> 

