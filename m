Return-Path: <dmaengine+bounces-11010-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKGZA0lLGGqjiggAu9opvQ
	(envelope-from <dmaengine+bounces-11010-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:03:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F345F34F0
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 16:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4716931E9E9D
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C03F39CE;
	Thu, 28 May 2026 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CGym0uXD"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464FC278156;
	Thu, 28 May 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976324; cv=fail; b=nZihgizBOYuKibfBe1/KnyCa8onC0YONSzodCxPp64Nt2/maJfilnKxc/S1dnh7JiZlwZp4CnKbrfL/TGFI25PrmeVbDjekh1ooSNKaDhoWwGrd/8WhUNMsDDmBlTG+F1KEJBJfGhr7jlP2x56o5/1eZj2tKLRdMQnz6GXbaH8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976324; c=relaxed/simple;
	bh=CSL/ckfyLuFk2JYCs5u4Fgf19wQzR6koeWrmK3XV/pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GbS0gk8+Lf3Cc1bhyAu7sWF9l9izKWILOWaiEnlrTSI9+hG9h/noHyNX6kbBrp2UXJhQdlEMI2Ozk4qOMG+fXaRQYUjDvCqXPjYwKmaZZxBfiBjHCiPG91vS48K2s0G5J4zctrS1JFgCL3ysV6sbQVy4cUmKcsGcKTsGT20gd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CGym0uXD; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOcVYpEPQTBLC/A8967ThovACfngy5TYCKYTgpDdc5aqH46Y8H2Fel/f8hLMJSO9HJzvKpZRq4++yhnAImJXp601t8DReciKgtDUdp0urUtgIljM8EL5uOBIov5OOmtfaaXG7E68h6rVDC54nwNS0Pu8niKfJ3pkiEE3eEf5aOY0wGbw25GEa+Uv8kxB72+18kxQgJRUL7mW0VIThxKvyYU5wLDh+CYn3Io5hfSRxxUztivOjaRVuwE+553SBx2sVsTCKJhTs29rmLirPUHptdZh63JEpwxPyNDq/u6vOdpALbvGqMOYh+Lq+ByQxqVQCWUCRQtJdOb2K/yt4HQWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgoWDGfOce3jcNUckbhyN5BK287rekV1uxdtVEdrsuA=;
 b=rGZe2CWpjF0URnR1sAicItob1nlkaXd6Jv03zrFvkIy9bmLE+4/NLbR5O6ONwsi7w49QFSZXrarsIePP1FRENu/iP5B/VPWP6Kb+0lVp2UIYBFyrBlnYdNGl7QJHJ8fHxMHrmsA35BcLF563hxcVF8Dgjb831vCPKDdo0dr8uh2m40FU9kiNkAxuD746ehK2zQPQndOF52iht3e+8OmRbY1hQNMtK+JFT2d0Czuin51sS02uq1GxqqBNiPOnBe9lgTcu8UglZLxqPGz/jMY/XIDl/QWCCnQLMVbSCjgETzJGSms1CvR4SghuCaJxbb1/o55lw9AtYShfU5Jw7PbJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgoWDGfOce3jcNUckbhyN5BK287rekV1uxdtVEdrsuA=;
 b=CGym0uXDqIvQCdgZbQCqO5PZhjRjlj2OrE0DYuynDWV+8kKJMH1fWw1iFogsQMRsR4ET9to+0Q+wywptUkx6zK4Nk4UfccMdihUewxlcGz74LETjNkt+thbltJIDkE9CCOylvx74RFH5qxe6bJAV/lxjnmSsyZJTzM5drdbFQlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:51:59 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:51:59 +0000
Date: Thu, 28 May 2026 15:51:47 +0200
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v6 13/18] dmaengine: sh: rz-dmac: Adjust
 rz_dmac_chan_get_residue() to return error codes
Message-ID: <ahhIc-KR3TUmbmG7@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-14-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-14-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 701d5c14-f497-455f-a972-08debcc049ea
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HlKiGoQNl+tAbRdRm0Lu6w3Bc8h2COHcB1zPaUuNsb4LDQCJvRgWjMSw24ZJCRL1iDTcBNcM+y0NyGsdEfS1fgqM+XP+Dja5IbbRDsNC+jTXJpnbxE+neYyliwpcUyRxdd8XWV3v71k9kxsVhRkpY0l+tG7Bq0bL3rOfs+cKsSNVVVvRFwK5ViZW5bYjIsXbqmozlT+qbnTjSByR8S60AhxIlCw+4r57ns2WvEGZRJapLDzaQXSJ7rkMHlQsKkTzUPsPe+BUXMvblqa2MaAD80reIaLkEE4XEBBB69gFQL8smHPmjs1lu3hbqp54JQZ9y5/RlwLInGBIgv9GCR6euV+5n3hQaTZIWaosJmTNs5Ab4JnFks1uglsw3p9IzCTXkuc1nE79bn4XaU5k9rxkZNTfEGLGv+4yHk7bbe1EEvBN4ZcF7VVy6/Nmz4UhN9XSsQEdP83IAVAKLnrbhgqi2lld1/qlQFfOTyWQmDGr3Sn52do3cbUGkKuE0NNqAIuviXdXBqOIyyMZl1gjN+e3iB30YK20xc7+3PropWrA5KIPgK2lOGb2YhFQKdukft02olm+M6pXsNAK7k1yprAXKKTfyAj6pa9MDpMGd6U5YembD0KR/paWdJrj5DqwedX1PQHCPPD17qgljySIjoeIb6olEyeDlX0Z0120D+vNabBO+Nb+9bxjMgTjlkW+9y75OMdlLNtIGgMfkJPDzBzBf0eyCOMSsvU504c8d8vJZev8cSMuQAM3rMd7uIommNno
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiR07V1XwHsWlulIwGNu5oB5VlnAmPXRug1Ax1oVny0lE875ZfO407w8w+t/?=
 =?us-ascii?Q?syNx81hJcGEPnACZaihOHChm8wAVNGqFffS9iu5m+av+oXBYQnvznYmjlIRg?=
 =?us-ascii?Q?CmtVi+9AYdujgpcT4xR0dNrbn6pqRLK/9830jmugXFABYiw4yfPIX7Z++dWi?=
 =?us-ascii?Q?BLvSR/60qmwQc/TK63T7RMMSnQVHW/ow93BZkh+G5ZHNZ/wG+dDef3TiZHd5?=
 =?us-ascii?Q?gdS6nXK1AEQVe+C2SY7O6OFk+Z9kB6cC/RS7xST/Ro6iiAnKrF+lEWqynftE?=
 =?us-ascii?Q?1D1VpUAkZD4wPglIJ6cqy9CxFZGNHIGJdmalGxOoRPjCOh2Om5yJs1lLjWNE?=
 =?us-ascii?Q?RfVI3drifEZ2hxz4RTXAQ9hcLw3bQxi2yOCAIieOsdRydlVHw/jOpWKF13Cc?=
 =?us-ascii?Q?Ysbx4ETRQYf4tYxkIsoj8whHf31OCAX+D+X6SB69CVkxv55Dpgf7NLWbsMhv?=
 =?us-ascii?Q?QyBg+Az4/zWp+tbiISnE5c1ycRjcTIxfzhwpTn1+j5yUo24WDvvlfHnlM9WG?=
 =?us-ascii?Q?VozvurcT8s/4m1dBdTmWHENsdaKs7PDyywGm1YvPxbh4SGoMsJyzkdu+Biys?=
 =?us-ascii?Q?GZ87ptgD4NQn3/yeQU8f1wSodmik1fVAXuUwS5BRvvEGbOg3DOa1tpSeJhd0?=
 =?us-ascii?Q?W6ty+oqVGb7XMvegp1KQkYI++kCkrZfHFeZy0zEDOjmlSUc3pIQ9tAQpdqIr?=
 =?us-ascii?Q?JCxC+l4HJrLQuBauCJhO1jLvZkBG9QN4QCzynIbQIn4QDD4tcM6nJIU7BxzQ?=
 =?us-ascii?Q?T0EJz8NIGMKYPdrMQKx7ohUwdCGqEpD3NZjnwHSCyDGPduUzxDJiKsuc48K7?=
 =?us-ascii?Q?Z5UbqMC4tpBWRmkO88nHv/rSm+mFDMaoEeHyQ5vPEQuxgUcSIvOhuuP0DbNL?=
 =?us-ascii?Q?dMeFs9dd9VGOTs1b/ZHAf0Hb8Uo36PjKyzGk9oD41mnCcou5Hqdo0LL5MjhT?=
 =?us-ascii?Q?iJvpCNdr021UlHloH1QRll90blskUj0ef854s5huTqLR+dHlaiWIOj44MPAw?=
 =?us-ascii?Q?FpiZQFh3ionl/jRYVvnV/WkBxLGAA20ZTFU1DVmRf+eRTnKVeJ4+UWLqDWYM?=
 =?us-ascii?Q?hEYi/g6jZq5BGWSMQE0T444J1nrNWd6d3iQpdK3lwRpYg+gJZuSKlakp7DgW?=
 =?us-ascii?Q?Pj+pLU6RLVo7rssnPKbPZ9I/OMBdtKgNvGuqly9KJEQMwsBxxkqo4CbrSl15?=
 =?us-ascii?Q?IMkXRyKOz89PdebIhTCQRw0kWTBvgsrcl5/Hc2dBWpCQjsn368E2s6bwdR35?=
 =?us-ascii?Q?ETfPUyDn2AbGcNjvU05Yjws8YbA5VNN6lJ0/B8cXL1kTt2/XDQvxCeuLzjTc?=
 =?us-ascii?Q?TGZQM8tLC0sdtA9jrny63OW0G39c0adHn9LKTHKVbw9imdemaaAmmgeelzhQ?=
 =?us-ascii?Q?G0Cmkz7MHu1DHTs8TFJ7EH0mSLuW2v84c6MmLYKJ5VXOjuKS1mxE9GaqWwvx?=
 =?us-ascii?Q?2OqrwiuOE8Bh7sBF55mNxxX8or+qa4QYz4Xvn0BDvPskeFpu5/qyi8gyYJOg?=
 =?us-ascii?Q?BPaxCaBCU8eLzvxmkWpr4iZtJNvBUEKh/zivf1PF88IiQrvAeEuS3+pL/LA2?=
 =?us-ascii?Q?FJF/J1COCOR8ODwj6TmUThEcsZI5FvbQzyAEOtTu92CjQKLXzBzmWt+/Jfxr?=
 =?us-ascii?Q?HQ3nTtod5GVQ/pkadrRZiQzZEoDQ974RxhHBUCRFwFHQFtAa6U+RFuBcbCZy?=
 =?us-ascii?Q?ip31j7wqNacH0kZg8fA0Qpxzj7bD7gPTpbN3zcw4YY8D5mp2GTNR7d7ysNOG?=
 =?us-ascii?Q?PyFtO3z1edtUTr8/5HDf2WVZeJX04sb1K3iTuH4NJtUmEMZIULI+?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701d5c14-f497-455f-a972-08debcc049ea
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:51:59.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji/7PBAHOSc4XaYK08CSV2ReZ6KjET3DM6+et2VDssYNUiAyNVlZKQEEVvw55BOA0aOS8V2eu+DbnN52DlOb54AoszA050BMfuv+epIbQQtn0WZtoTdC2reh/U4H3k17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11010-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bp.renesas.com:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 74F345F34F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:05AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Adjust rz_dmac_chan_get_residue() to return error codes on failure and
> provide the residue to callers through the residue parameter. This
> prepares the code for the addition of runtime PM support.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 8fd8a4bd9cc9..93394b9934c8 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -860,8 +860,8 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
>  	return residue;
>  }
>  
> -static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
> -				    dma_cookie_t cookie)
> +static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_chan *channel,
> +				    dma_cookie_t cookie, u32 *residue)
>  {
>  	struct rz_dmac_desc *desc = NULL;
>  	struct virt_dma_desc *vd;
> @@ -871,7 +871,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	if (vd) {
>  		/* Descriptor has been issued but not yet processed. */
>  		desc = to_rz_dmac_desc(vd);
> -		return desc->len;
> +		*residue = desc->len;
> +		return 0;
>  	} else if (channel->desc && channel->desc->vd.tx.cookie == cookie) {
>  		/* Descriptor is currently processed. */
>  		desc = channel->desc;
> @@ -879,6 +880,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  
>  	if (!desc) {
>  		/* Descriptor was not found. May be already completed by now. */
> +		*residue = 0;
>  		return 0;
>  	}
>  
> @@ -901,7 +903,9 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	 * Calculate number of bytes transferred in processing virtual descriptor.
>  	 * One virtual descriptor can have many lmdesc.
>  	 */
> -	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
> +	*residue = crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
> +
> +	return 0;
>  }
>  
>  static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> @@ -909,15 +913,20 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  					 struct dma_tx_state *txstate)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	enum dma_status status;
>  	u32 residue;
>  
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		int ret;
> +
>  		status = dma_cookie_status(chan, cookie, txstate);
>  		if (status == DMA_COMPLETE || !txstate)
>  			return status;
>  
> -		residue = rz_dmac_chan_get_residue(channel, cookie);
> +		ret = rz_dmac_chan_get_residue(dmac->dev, channel, cookie, &residue);
> +		if (ret)
> +			return DMA_ERROR;
>  
>  		if (status == DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
>  			status = DMA_PAUSED;
> -- 
> 2.43.0
> 

