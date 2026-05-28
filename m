Return-Path: <dmaengine+bounces-11002-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEvaBEJIGGr2iQgAu9opvQ
	(envelope-from <dmaengine+bounces-11002-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:50:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136415F3074
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B3CF3062922
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679527AC48;
	Thu, 28 May 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="foZqyg8X"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010069.outbound.protection.outlook.com [52.101.228.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A82282F1C;
	Thu, 28 May 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976117; cv=fail; b=fg3PkX8by9+PV1DmmtjW7nzGAomxy41iwmmcsWAf0eeIKITWzvZxEPHXYjMKoWGSJu02h65jaE3odSiE5Ria0b2PgL/f//079drpLTrdogF5yiqRTsbduT5nJcIEyU7lrf4VH5C+OXhqkfyI/8Cg6UfFBy2MNcbHC9k7lLCiphk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976117; c=relaxed/simple;
	bh=BP7Kl2C+HfcVDMvpXic/0+fmnajGbqJvzxeXPMH/TS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADV0v2mCemNSu7mbY/ocnRG2/5zjvns+R4bq2Z0+lD9r223agthbwz0FLbQbHJpdydBQlRrQnExihWxsLI+MgJEnZsH8ZT6iEPN0Yhamw8/ZYSyCwXgUSKmSrSTJCsSIKzpDladPi68SMLXTYJkjbhPXckgPy12zqyCzdCdv5rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=foZqyg8X; arc=fail smtp.client-ip=52.101.228.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7kukL4r7kyMtJH3EnZAEPkJDAH2+XE188PIOdhlc3jXUHfYSvakWresSnliqcwt5U3UWnoNQa7MZrpPzF1ULeWUYGiY5dYOPB8meMC4PebOXp4io0JupwGssZJv+gLNX4TpOYVz2pdlRuk9jpk+Uk3Kxjey20FjEFvrQpWggg2Akd4UDD/e/agRLBQlwegoXmIAMwgUtwLvNKhYVMBWvKL8M6kTTe/J4maYxpL2tQzVgzR2nNcicL5F1AiEZqU478LXLFuE7t1xDZoJcwh7r/LYPx3F4dLrfdV46liysuygobi3fkMaQx3TVgtzn4XO9d2/B4lgcj2gTNGmMUQqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/c8lgSRDxGNl/NmZaP12UpZTW7D4+4eSpPU6IJeAyE=;
 b=ol7t11lJTkpbVEX1QFc3PMjH/vQsTJDa+Q4fVXGHrP86XLXXB/EIjdbU1O9F5AydAzWH+/AGHeBE1jhELZ4ObtdDMkhulUu8CJMyvzuh5M/7VeKL+Dr60XX8QA90WLiYSTWDCnqVCBok+JYoLYMCszzdSO/n8ErqHpRoR/6M+sEgRQmKqsgbc+4K+jOs93/g42TRgV7ea/xcx/p56FE98/dWaYAB/ibXqN+78c9z9Bb7gUbSsnitjK8pGg0Qvpn89M0s99kr/r1PDh/ttugIkf3fvLHiHAlEhpU5Twx/cZ9ffpNfclkTtZwgiWemS4hsEwka5RHHqu6J0IzpO6LuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/c8lgSRDxGNl/NmZaP12UpZTW7D4+4eSpPU6IJeAyE=;
 b=foZqyg8XnZOtKlig67NsmKE1OecjTrC4yJGE99X4goeMJ0+nKb9VIflsEXiHYuc69I9ux3RectdAmTQ4+WKTsoo5Cknugm6N98i++iuclr4EEfclvVyShhZFik6KPS1dF/NTrNoJqaZv6gyEG26iiouLc0M5Td4qiknnZeAKsdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:48:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:48:30 +0000
Date: Thu, 28 May 2026 15:48:17 +0200
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
Subject: Re: [PATCH v6 07/18] dmaengine: sh: rz-dmac: Add helper to check if
 the channel is enabled
Message-ID: <ahhHoT9sgC-Kje_e@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-8-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-8-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: a0788473-7fec-477a-a7f7-08debcbfcd6c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FKZnHOJOlC4ozYJxTjZMv010hNFoygQK7rOiHyZHK2bQ6nPAdAVr8Y0icWQcvtXcMRCZ2WJG5vShomv/PgRILesZY50zKMx4EG27cynyKZfJi83eFJnv4UrsrsX8FTu1YEh3Axs97Yxo4nRAjfu3ec5JxgfL0PKBxY5QTGYoLc8LN2kl3o4cOb8jgo9rGn9ixtM5fXdEXyS5hAgQLjg48i5MAdVAMNVCRV+Qsq1jYL0pvTgNfTprX4w+9uu3VmTfmX+flTXQ+1XYp6hbxINUv2nN3B8V53T6OX1Gc4piPxSY63dYBlh5bud4KOw563xm2O1xQQKTzvwejCQI6CTt3jcnnk0O7laZWJB1MxZpMdiV31g0UQGAU31Ic5rVAz/3GjYzLmJ9gDRrxjkmT2SrJLgBtTT1UxCTCfoC2+HjGYrJk51t05YDqWAgkhPvDAhks/znmL6omZkYBWFcgN4icCe2KkSmxmqWJ56ePszpqqLlyLb9jHFJUoARLez92b+PJ6oSn+TzTOtzm9+Ik4u6vhq9qt69flV5wCB3bfrfYrAz8eP3WZZ7G5OgNCJfX3TUib59uo8xrdU24MjTYPpOdBFozHBp8yr6M+p1ram7/k2G9p8VllkMypTiy2vvqaSQcwAx39UEIY5ySmY4WqNIKao13CVy4XbA9ZBlG/rp9Ms2qbFMI+YMUWPWngOPP/d1rw9h/ooQO/DVhal6DgDuJxly2e1mb8GYsRMHiC6rUP4aYuqiM/RXCtTBai1TD/v9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bJ7qfzzZtiHQzUqT9kTYtpZSUf2CjKhVs+QxEbPa+ZfLS0QGEODdtoWmdKFO?=
 =?us-ascii?Q?x96u8nelGXTKSifs87asQMtuYovduAHuU5YRjWKfldSCgHllZqjABaxumL0A?=
 =?us-ascii?Q?r/t77VUn5NJFC8h3GDmmKx67DydVXTFbRIf7M6EoGzIlhPxljQs/Mcs///sm?=
 =?us-ascii?Q?a79QSsqIfmBvXCmWEOGH4mtHD+1bDWltbap804JIa580C5k7Y/Cnccxr5CYp?=
 =?us-ascii?Q?0VskyTYeBfRszGnRvmzgQpRf+dzwyqit9Bdc92l59bJjqwcHVfv8rLMWUUWE?=
 =?us-ascii?Q?lLt7wHu3MPvxLMZSx1xrfpAdy5s0h+S25nDkCXkVY7piesG0vcmfyKdqm01q?=
 =?us-ascii?Q?JPVZUmfGOXeYcoqUUb7eXQQYiS/2J7fQRPOK9yTnuwifTlfSyGV1zDScaTb0?=
 =?us-ascii?Q?grdveG7LzLNoUuJr1rLvZGiFmJJ9QXW2B6XJ6ooQrD02lJn6qoB35oRirDRR?=
 =?us-ascii?Q?lb8oZdUdDcRlW0gWfs/i8+j+N/jQd/ztLaoMgaAcXJB0kV3PH/UZCYETOUo8?=
 =?us-ascii?Q?OwDoBj09RV7piSOx9LnCiLm+YXr5ulV65Zdz/WhHIYwjxMx2vENQG/O4Uyv8?=
 =?us-ascii?Q?e05D4e1a9rxLk6aI7Vo5eofWJOGZBwZ1xKP4/dTiFHIkiwqvSxQB3WXSC9uJ?=
 =?us-ascii?Q?A6z7KezwJgDmQiideBMzbBgOUdktF2GbDgBV8Ve2dJWXCXZIbPLhr4jnR0Rz?=
 =?us-ascii?Q?PXEu7LvhLGUgqdBWHYq5TtzxOnx16wiX3GV3Xx8mYDei7/biVZoA5mSOZvA0?=
 =?us-ascii?Q?fkHDw1TEM3glShfuKcLWm7zOkjUwIskvRKz9dpmFoCbwFGUsIshCKq2cw1aQ?=
 =?us-ascii?Q?FTqPwBfL7qUX05CDHG1tXgnIIbr0YBl9ErGJic3di3J/VuMjCWvQIxWwbx+s?=
 =?us-ascii?Q?sNADWSECHcKzlPup1gx6YbbqLRbCBPbNvEquFOgVaPWy8vmalhawqRDSde35?=
 =?us-ascii?Q?qjQ+FnpoAyGNUj2Fri03Eh8kXuNcVuRx9f4JjxgX7fPHRL+KlSDJ1qe6iNDu?=
 =?us-ascii?Q?mL5+SKXJKppOQV4r6Jri4qHCFZ6qCut36d/2zfFQatDzlFDKcJO4zF1q5okx?=
 =?us-ascii?Q?uYdSx4Dj3/ASxUxlax3dvtEBcE+pZAGshUfm7p2BE2TIfcPXLXwLble0EcQa?=
 =?us-ascii?Q?7GphvWQnKe5UoeR9tDJI5SQVkdVjtp6mPxqPB4yLu6h2XDrTvEwqxRTS9irr?=
 =?us-ascii?Q?9z8x+C43NcinAljuYVydfu/+CuHqGevpnlR1QYhwHiFB+TUhTA2wZaa+Z8V8?=
 =?us-ascii?Q?V6FZJjrN5plAz7mvSfSWrtNO6C9Pk4VzDIJwoCFjO5gj2k69ZZo/yzqunH1j?=
 =?us-ascii?Q?lmeEN/OkNKMpG46Zi/Nk1DrUGPJnXlceNBUqY7fpeGtPNYPkQJhVCoShWRsl?=
 =?us-ascii?Q?/1GvsSKyqnm7pvvuSyQORfP0Yl8u8pYCTQgT6dp4fMNwBnBkoktQqh8ELsJ3?=
 =?us-ascii?Q?FK4xBO6/lRiSqvlnwwdrqqr2Adu96nZ1yHdMNxE9U1Bpix+7S/CQNybXwUW5?=
 =?us-ascii?Q?O5WvCb2YC2FCmuKa99EW350ikt7qq46EQQmXF0fhekpYBjCVN3v5pdy6EfPt?=
 =?us-ascii?Q?7Bqd/elps47jK28G7eOUma571D7EE2F2oBKdPHCeJA6fybox4CQGeF8Fy4Gy?=
 =?us-ascii?Q?DfK18zCn6tJNofHt2Ko5CP/or4HBnFzAn+igTXTjNP+BUoZeVUel0KXSc9bG?=
 =?us-ascii?Q?qXgiJoZjj4u85FuzWcVhztRS1//NdJ/A3vWXmFtVVxwjKzmhs4+PyVUbTGMk?=
 =?us-ascii?Q?8N3tfl0z+I/Dss7O0RaGZuIIpOzSk15QtoVc/tsBZxBEHtqNfbaT?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0788473-7fec-477a-a7f7-08debcbfcd6c
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:48:30.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krFlC4aMoTkc1S6y23BNepNFlK/N6SgeW7AiDqF7ICnVJZTmN5UVVjyT4ulk2w2S48HzIg25aCYcEJOXnXJKqTaLjVoHFhlclkmu6GVksuG4llTeGrDnfEuhusT2W1AL
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
	TAGGED_FROM(0.00)[bounces-11002-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,renesas.com:email,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 136415F3074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:46:59AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add the rz_dmac_chan_is_enabled() helper to check if a channel is
> enabled. This helper will be reused in subsequent patches.
>


Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>



> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated the patch description to describe better the changes
> - collected tags
> - s/chan/channel in rz_dmac_chan_is_enabled() to follow the naming convention
>   accross the driver for the variable of type struct rz_dmac_chan
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d3926ecd63ac..76bac11c217c 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -279,6 +279,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
>  	channel->lmdesc.head = lmdesc;
>  }
>  
> +static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *channel)
> +{
> +	u32 val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +
> +	return !!(val & CHSTAT_EN);
> +}
> +
>  static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
> @@ -840,8 +847,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
>  
>  	guard(spinlock_irqsave)(&channel->vc.lock);
>  
> -	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> -	if (!(val & CHSTAT_EN))
> +	if (!rz_dmac_chan_is_enabled(channel))
>  		return 0;
>  
>  	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
> -- 
> 2.43.0
> 

