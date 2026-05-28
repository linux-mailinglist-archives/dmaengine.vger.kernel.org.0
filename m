Return-Path: <dmaengine+bounces-11014-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKMVN2hVGGoQjQgAu9opvQ
	(envelope-from <dmaengine+bounces-11014-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:47:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C95F3EA9
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C816E3023528
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FED3E9F95;
	Thu, 28 May 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bTe4pwyx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011055.outbound.protection.outlook.com [40.107.74.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52C3B6C0A;
	Thu, 28 May 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979225; cv=fail; b=l4XL/XwrP4VVYyGpCGWGX4kLAXvZuVFStyBbvpDf4gZ3zB/jM2wqFk/p8LILkKsohF5ZUhM9HFCRJtxXN3NvJ6ow+HlxoE6P2N9mE+kwRYX1LT2ABdwUMEm1excH1HeK3IbWlju1adxzccBWP7QUTMvBUoQVyfLhjmx+tUK/S+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979225; c=relaxed/simple;
	bh=tu4VTGMUk5GlGDSqTROfQsOIIZZ+Vhoi0JgD1WmL4Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G664di5JL/IAtBo5CTxBxg1vHZXAvbm1stQaT322LRJ2uHPBCz7z74S5BKfkkMneCUx/VN3ZC2l62K+9eT1XVIugnFf27zx+txGStYDv9FAxOB0hw7bFlRyr0kMizSCpG+wGEyRs/bHww9u4suXmOxAY6f+HXYcQ8uTTAhnsK0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bTe4pwyx; arc=fail smtp.client-ip=40.107.74.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiI/icu0c+94IsHSKRB1QMMs93VivJF7Ua0HzxpIk0gIU07DTAnUlfiKYMUGaeyyM7Z3Mq2eqimGcrYfyjNdzsD9d07mACwAvsJs/slYirE89Bnm9b9v41QFJEKaIz1soO63BQaltS9z0xsPxVULPBBk9hdYCGTx3ZJtS2pVvw3jYmXrFbIy2K5cAoorWQzMlrlgZUq7Z/+5Fe5ORYtKLXM3yrOQ0VqzbcDHwIi5NzpDnebP85PWwP7jBy7G1o2sQQJnxdNJed27Gol1PSyW5OqZP2awp3PCfZsY+glAtHPXlHA9BcVPcpzGiLQetMtQ/og1D1Xx5ztzDCcLVBOjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3CoBkX6JMQv1PzGjHvzVNKH5xtzuc9IP9tTJq4RMYg=;
 b=v6Zd6+aTcMfYXaYLRVaPQdnw8/ozg6/7qJtVXXPPf/ANprpN8nvj6WqayXCsPsUGL2dkIieURM7drlZb3PjULCnKPwKYH+v/hINeNEnBuuRINu3TaS77iBl5yaIkRFZLXnB5h2WU+zuP7selb8wTWL8WNMz2oOA2jTyHl2AwZq5xECBeiT9lySIQ8c5lPxNimK34peiyUfZ97Q/TU7LWvh50MlDZ9se5VIMh0ZD5+pDXQ4edquG0qVB9bGkXHTnmet+AXkqKKFo9k+dFoWQjVYC/CiGisnCfDNrnn+g0QszOSUePNAGD3oDQrz/QKnno3C2S5UY8oMf3eN0qD3Qb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3CoBkX6JMQv1PzGjHvzVNKH5xtzuc9IP9tTJq4RMYg=;
 b=bTe4pwyxJ9oIdfXfFsDps7xPzJcT4e4A0bntjzuEZkO2HlpCh/WMadfVCzqLETS1Z+ilaArStk0ptSoQUV4Ge4rUvicQIPX7+y9nME5n+hqITwEjL4WW+yjaftiaHAJXzrSn5iyJGZ9NNAdh9ZLyRg1LiFXCqJRe1sfLEwPoxow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB15060.jpnprd01.prod.outlook.com (2603:1096:405:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:40:09 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:40:09 +0000
Date: Thu, 28 May 2026 16:39:55 +0200
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
Subject: Re: [PATCH v6 18/18] dmaengine: sh: rz-dmac: Set the Link End (LE)
 bit on the last descriptor
Message-ID: <ahhTuzh-CxoKiTpI@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-19-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-19-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR0P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::6) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB15060:EE_
X-MS-Office365-Filtering-Correlation-Id: 362a3d74-dcf8-4698-c46b-08debcc7043e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3OaYct5j5Q841wg5m4DijDczKnkpPULj3bwVUmsVYNrDxxUP/axUDB6Sa+lIewY/CVPZW7z2MGreUKtv80FHIjecWBGQ3M1+6VbeMy7DK38SdeuDVtgrX5a5uyQZocnfDciEfZ4VnyfA972IOE9e/QjJ1Rqkv//NlR35kjwQH7rg66Ud88rNPda/qHmPAtqAdwEOoQHSDd5miRIgNMMMQ4cuHTQfT3WqC8vColJMCQ0DTZtQMj80ZVcXPAJ5uRq3f/VrfkyV9UcwKYDzGPP3ftoHpHO8lt88Yd4OBfurz27Z5J0xCKCbiaWubVfwbD0i3RA2vftq+OXkTvE9rF6KgJKOXEiasRnxaI3lOHeaWjSV3H3dcvAuND3npyfK2Ey2gFA7lJIg08+Hb9EfXALI9Ag0ZUPnRqH293HGVLIIAyQQruLVBqAnrimDPKNAGC6s1EHqXWmhLBKc94nasNAo/vJB/j0b0zw/1JiB6xaG05JmtTUNfjM3AJI4LnGBuVENLTmN/8yVYU1Q4Nd9iRu5YoggnTKliF91j1ttvr140wWghFVHs9v7VSHouVrxdpNkNS7La/fXi7JzevsqEGXLojO/UWE7T0/2wQa51kHeJ+KzWt7dZI81gnyqbQCRalXbXKjlGc6fqkpaOXJgs025tlX/57ETRr+c/5Upt3tRLH+IPzBZrJDL/sP6Buww8GcQErPtTC4WL/kAfSZ+Y65XfX+o3QXIkMs2+CxGHC5L3fJ1goVRYf4sOFiN0ddWg2vc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dJzYc0Gu4horFSq2aBYolSHp0mD70BeDAgVE7cEQPNIyaPSSzk/CLmwMM6b?=
 =?us-ascii?Q?pbKosxLUDaI8ySZ5bZyoItN4Y1zV8lQtbp3JwK9/s3qK1kHY68N2lErtnL78?=
 =?us-ascii?Q?HFfrBsEVrfMAJ91inp+1++yB/i8SNoq9QJAIG0VTXpS7LgVfWde1OlgNBl8T?=
 =?us-ascii?Q?bJYTsBZK+I7S7hOueqIIAuiewZ1kbhJwFIDQ6aO3RJzLS2pAgt1G3LUBRlbh?=
 =?us-ascii?Q?5/vfPt5WNzwKCAfSsTCSDyXg0TKxOr58dD6MiEyZIZsMvLGelK2RpCtlEIua?=
 =?us-ascii?Q?R1xP6+QY9wFEuvMgmta7cPhGB3QEKd9w+N8ljS3ovv5Pf7Q0T8gsbR/St5ZF?=
 =?us-ascii?Q?HPPwSNchZvT6cLGezRfAclih0Ci6XIiiwHZem0kIHY6XiUypf1ZtD9igYSEo?=
 =?us-ascii?Q?eiL0v9Dk29jWr1cGfKApINQLXEZP5H3GIcTvQMlCnStOGzvxVgripQ3AbZOU?=
 =?us-ascii?Q?1GaoK2+sd9M+T2q4FdxK0BZ3NxkpuQZTLZ03XKf2+hSRO+VfzPFK47KKCi47?=
 =?us-ascii?Q?6d9iD2LwTvwJwJ/mgR5JoSkepKz3uyxriE3kvLp1B7VVyL6PpMMPcPnAoLy7?=
 =?us-ascii?Q?wSm1UDnYphbNnWHw2uWc7AvlHi0fOsCuYoDJ6fKcOFQwVKYUxJs9Wtf4vYP3?=
 =?us-ascii?Q?FH1MMPN3HBqDAwf1vIvmoMBf0FmSM9ZxmCrScqPbAvnm1NreBOJ1NRnTFOyw?=
 =?us-ascii?Q?Qk65H2mRrbeAzlbQbwC+TJw/LsuLyiJPJO9uS10fOVaBFt8r8TSCGeKcmxjH?=
 =?us-ascii?Q?5MbOZkc6bCg756hiv01ocC0bbA8jPtJy/sPKsvqgK4lSW4qrUD74Cec+P33U?=
 =?us-ascii?Q?8DQYjNWy6mtzCX44oj6on6PrQrp0sBi/LfPAzaVvZrvS2ELnPD63UgBB+p4o?=
 =?us-ascii?Q?jLkkMkn1JUCYA7vRaCN4YuNiDBucGPNfF+Q2MV6UPXpVgmd4g5zyqcO+SGv0?=
 =?us-ascii?Q?gEcZdAcjUIDGxu6vi1ByFo69BrbgPvW8WHC/Fo12I2XFcdA917S7egmINtOO?=
 =?us-ascii?Q?WtZo6XzMgmMXnuJ2+8FabjjaCabZKnvbP2QlB/CiF9o3jcAI6X9PuuQLSnyf?=
 =?us-ascii?Q?CS98M5P/H8aWV+8+babupx5CWA7mSvy3B/E56uF+FBEu2xn00++uTlBshePs?=
 =?us-ascii?Q?czAoV/Zwy4Su9aMBil1qYHrPGJSTNSOqly/9kBA6yuYRxVPiUJancp71qfwJ?=
 =?us-ascii?Q?SRQjq7VCUMH9P63QM19GRz1zb87D8f9vomG2CTHKdY/kCgNO+GCyDGWA9VHJ?=
 =?us-ascii?Q?ZeV5E7ykJFMCDTPjmbiJcTJr35MR2rOVPmgpm24J5nZhRqLGKfLKPqgRgfkB?=
 =?us-ascii?Q?qKULWrYk9Raf8nAsBKJWKkComdqJXoFiBJRmCYGc1k7NjvfcMlcXrNyjfiyI?=
 =?us-ascii?Q?t22XpD9x1FDHIJdB+hKR0fEmR5tj04etfhPwaqhKSXpo8NglSg0nk0ZK+kt1?=
 =?us-ascii?Q?mTxR+FmgpSt+5PgvoK6VlPquqc2W6CIWy9ZaxGb45Coc3xG4xmfPjuElVvOj?=
 =?us-ascii?Q?2qqzk8lMAHPNWs08QeOEppqiWwJ4Hl09htZkhxDDOlJK4iaX6bI+imWvN+Qn?=
 =?us-ascii?Q?82anDGi4PgXOGc9IRqzTdo1hz6C0Cz8dCXGvjLgX2ZkCw9OKiOoTpu9cmUoj?=
 =?us-ascii?Q?aRS7Qx+kJiSsIZO2zWL1C5uaHAapmAvBDxUEvHV5/Ppge3h/OCyJI7QAya1V?=
 =?us-ascii?Q?pmMdXvRHZfj7MW91DPtkXKbmygb8b8TbjimS3tEi185g8tEVtXxub2CTr4YE?=
 =?us-ascii?Q?xwzvHzdz9hwG2DVnXS4y/nF9NpgZFsdJcgfWj6QJF26BwjPyQG+r?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362a3d74-dcf8-4698-c46b-08debcc7043e
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:40:09.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kTvT7KHhMJZd7aNGBpwmubwof85Ie/gqPEp/4BTqolweiYvYlsSMtlKLWie/HzEaJPqq4pAzFMi4lDIuNTxpNPPxER5CZp/shsBJVQES+4ClyE+oNlaNciIzKlR78pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15060
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11014-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 866C95F3EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:10AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> On an RZ/G2L-based system, it has been observed that when the DMA channels
> for all enabled IPs are active (TX and RX for one serial IP, TX and RX for
> one audio IP, and TX and RX for one SPI IP), shortly after all of them are
> started, the system can become irrecoverably blocked. In one debug session
> the system did not block, and the DMA HW registers were inspected. It was
> found that the DER (Descriptor Error) bit in the CHSTAT register for one of
> the SPI DMA channels was set.
> 
> According to the RZ/G2L HW Manual, Rev. 1.30, chapter 14.4.7 Channel
> Status Register n/nS (CHSTAT_n/nS), description of the DER bit, the DER
> bit is set when the LV (Link Valid) value loaded with a descriptor in link
> mode is 0. This means that the DMA engine has loaded an invalid
> descriptor (as defined in Table 14.14, Header Area, of the same manual).
> 
> The same chapter states that when a descriptor error occurs, the transfer
> is stopped, but no DMA error interrupt is generated.
> 
> Set the LE bit on the last descriptor of a transfer. This informs the DMA
> engine that this is the final descriptor for the transfer.
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
> - none
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - none
> 
>  drivers/dma/sh/rz-dmac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 2a7124e4aea3..f1174d25da84 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -200,6 +200,7 @@ struct rz_dmac {
>  
>  /* LINK MODE DESCRIPTOR */
>  #define HEADER_LV			BIT(0)
> +#define HEADER_LE			BIT(1)
>  #define HEADER_WBD			BIT(2)
>  
>  #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
> @@ -382,7 +383,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  	lmdesc->chcfg = chcfg;
>  	lmdesc->chitvl = 0;
>  	lmdesc->chext = 0;
> -	lmdesc->header = HEADER_LV;
> +	lmdesc->header = HEADER_LV | HEADER_LE;
>  
>  	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
>  
> @@ -425,7 +426,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  		lmdesc->chext = 0;
>  		if (i == (sg_len - 1)) {
>  			lmdesc->chcfg = (channel->chcfg & ~CHCFG_DEM);
> -			lmdesc->header = HEADER_LV;
> +			lmdesc->header = HEADER_LV | HEADER_LE;
>  		} else {
>  			lmdesc->chcfg = channel->chcfg;
>  			lmdesc->header = HEADER_LV;
> -- 
> 2.43.0
> 

