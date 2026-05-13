Return-Path: <dmaengine+bounces-10437-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG0sEGfXBGovPwIAu9opvQ
	(envelope-from <dmaengine+bounces-10437-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:56:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B115E53A3F0
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63ED1301A2B1
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15F3A9611;
	Wed, 13 May 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WNwWgXEn"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF403AE6F7;
	Wed, 13 May 2026 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702180; cv=fail; b=pgAI294gQPuh3+ZCnPTB8qr9yp8AAdi15hzNf5hLkK51WgyFCME38x7LMlXraDOTwBGjp5BocTeaJDY9cVsWW/o9VHA4166U4wr5VAth6E8F+7VQceXsCZuyzhXd6zF9nHsZDnNw0f2WlkKe6OQnB+diMC9og4DNL6nrG0/zc9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702180; c=relaxed/simple;
	bh=N8AGDXVjmgM/s5J9JEmXvT+ULAlBg2bj0yK+UbZ7HLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gxi1z/J25nGYTAQEwa1VlTspS5KKcf0MKOjStGD2ir/zo+ckesGr2HzeKmGSm3FbAc3SHAdMreTqg/Bra+zwHF5ttqK1lUIRVdwL3s++PZMNJwhToR8F5+CZdzBVbpq1PW31HKj6y2SNMR/3agyD88PiJojSCzIc0mfuLE7i++U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WNwWgXEn; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H820cMN3vNCpJNrZY/mkFJaXf7mkfntiuSus5SxC7D/gNptQxAgzRgXyb0SlKIlQiXQakjYmavwueLhwzpNkqtvcBC4Q9y+4OEGeR8vqBbauw2thf0rauN5cuIw1wg5keckh/fU37XM6vwV0yVe4rn2aJjAYQ0FytchWdLGws8dzO7XAfscWcc0ZI3yDkGLcs1InGm+sDIPrqMccTCXueuLXnkHvJYJdhfQckXxzaQtMgVl+076bpJXFTlrvWYhsA1/onFMOUnjOwzLLOlewwsNIUjxv++xub/O0Y/FADh7QzxeA56NNolsUhch9YBrnC35rMoWtbnk8CgnoFyDXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKP5W2vt4/hjZm64KLjG5x6P4x7TnXWM4V2IXirTd+A=;
 b=EtkMx2q/+Vm0kV0UqQoq2RWhew9cuyQITyMZqaJUBnyLUbM02oAJ74XarvPdSkqiYhGe8WUnofrak3xtGL8c3CX+hq00y02Zk5LXThIGJxS1FyWAqWj4SuSQPAYHpc3pcNAJYnhgC4mvofPtDtO6iuZ/aCmUs7ARNtLMuU++1RjwjWwbV6xugujT8qhvhUP+fO3y8hFPiPO1PsaUrey1//YwWO5crLmbgPpsd6R+9vZy1onjAT189hN7Rc0sxU37DXpCNJrnWoWM6d8tT1H15Q5MzzAx/ipohzhYJMGFWbzwhvWvd8inwRaChqiuyDw2Fv7BYcUPaM0nJe1/KMmL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKP5W2vt4/hjZm64KLjG5x6P4x7TnXWM4V2IXirTd+A=;
 b=WNwWgXEnT+GqIdGoatLQDar1NIZBElSFAtXs2qCb4XztlrrZvYwwNP9ADSaHq+jX3sQcrBBYgMhTSJV4hOF9u2F1fjM3Hnwqgo1rk45pYwpoR1DNp1ujn3U2EOEZKHBhTzS1HUAh9JCaK7sP56AaHCbxK2V84rL2NUIerdAKrbE5RAgf0B4N+xw9P9/y94hw2+y/I80KyN0rW3aQMMI0SIXJdhveZs/QetEy++OhvHmnLi2lSkGvv9NDrs0jypLtOxYVPrg9N4LCHMVHou/p9DWnuo7qydbnxZTGqRXor61k5fx4skRSXs9YYuCxO0msVtNC/IzpNiFW4xTuNiYrTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 19:56:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 19:56:15 +0000
Date: Wed, 13 May 2026 15:56:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, vkoul@kernel.org,
	Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
	kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 13/17] dmaengine: sh: rz-dmac: Add runtime PM support
Message-ID: <agTXV0NCP7PNk570@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
 <agOjwF12NI_jkOzR@lizhi-Precision-Tower-5810>
 <94430a9b-b5ae-475d-b001-e1a4ff35db8c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94430a9b-b5ae-475d-b001-e1a4ff35db8c@kernel.org>
X-ClientProxiedBy: SA9PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:806:24::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: c43d6616-4312-4b53-65ac-08deb129b0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|11063799003|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8q3YiIx9PYVeteWhna5v7aZ5FfY2mZyg2cgOgC77neEYdrL8R0Pd/vLrsqeQcbrFel7f2/8tVyWl9EpbmXsDtfA0S7BkjQ+RrsCFpoCD3yDS2JZR4mTzpMaOC0FTGcwTDnRt22GwuZDhY10KCaRsdvs8EJdU9SnapXcGlJnpN8pS+fTdcNnx/fZgCmOf3vMBX53miIyV2li3ot+htIVMKxYKB9pIESnT+cafnDwikm5ERU/QPu+wGkIroflT7XTmOzVYQd52dI8E+7vYC8hCyGtd1mpBkMEEhHMVsWvXkZUCQWnGyojU0yIk0/y5wWJawpj+SqJN85GxdfCft2IMubvRskaEz3Q2G7Glz9XniaaVKgi/DRL4TOr9+afThtWkxpB4D2U089OaHz8HMArlVDflL7ZvMhVkdxYTAlt+SQyWG7RoDUN9HEG2x2+YLh/RcfAoBR5SixMvq0b5k0dcf/QH3XnsBv1DoO2xK8k73pjpqO+EWJ3/mKyE/eyXpn6KCFxwNVtPdoJlFMxfOCDHLl2ITsuTHEYQDEmBVar/agguFuBugUlb2NfAmAqqOrPB2FQb/l1/OnYf1RzTVXLgiEP0HVy1+Is/6XvMB1Qv8Jw2BrR7a37X/vRYBXdEh/sBJrM0bQjnhz86ZbNTbtdIwUbaJA5pB57byJMq8rAt/1Q6d7Cvr+EgdJXgR6KIfJaC1jk9wbdL5nNKixz+h6UvvaJDW1f+l2vqEBqmcKTZkIPNqxj4fkG+PSGy1NQGyuDO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(11063799003)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tF3QbIy6Jk+P1KVttZi5nS6TgeYb7Na4ulN82ikJeFtyEpEC/HhZW0rZMRx?=
 =?us-ascii?Q?HVLmF5GosK6qNXY8tiqLJQxTaAcLWWmWlC0X3mzFH8FbC5Ifs6PgtHEajf/q?=
 =?us-ascii?Q?hdRS7BS4b3B2uluZrPLv8QjHy9keoiux81ZROHPaRxSW5lmpUhvKxnmP4AFm?=
 =?us-ascii?Q?7pSK2hpFZ1yFIHOhqpLtBehhrXSny5HdsbAIvDbjxJgD+62n7GztG/VZf03p?=
 =?us-ascii?Q?q1S7x/2lLEhHzJdVQPuJK6gcF6j/W6SRsPbB9D1X3IPziG/rNFBnXbl2Kwao?=
 =?us-ascii?Q?mHuV33uKXGV2oUTmzBfzygeU5Szssdq4HdbqvfJya8UZB26PM8tjFb4VT4By?=
 =?us-ascii?Q?9O6HWnf1jGgBiwuXGSbeDoLGXoq64ybqzTT/6PA9r8kmBS0XGNeJX85e1WoB?=
 =?us-ascii?Q?U8sXVdRr+eZ3w5X7LU66eMa4msMegqohWW2I0TGRZsgzUUSlqQyqwYVo1KMD?=
 =?us-ascii?Q?N029LKLBrix69lhvr/VYn/ftFRAquGLt6vg9Gf8KebL62nm/WItnTyWmbd0a?=
 =?us-ascii?Q?VtcYpuuNnBMUCIGWdKefJKge/Mg+OZBio85iWweYLifBxm+CSZSpZgkktqzc?=
 =?us-ascii?Q?+5JkzdNko4wFX0eCrjrkQfT0nmtcTJs2opSzOCrHQaESvq8iwNbQLucGGxMI?=
 =?us-ascii?Q?w41zaBo59j+QsvDtWZJyhroinX8whNRl13LMuwFqXjc7RTlgjJxtBlRU2HOM?=
 =?us-ascii?Q?8bBMmGML4lMVM6RMWJyYIjgJedu6KxzAqyZ2cvn8Aca6zv5A8RXyhCE/SMC4?=
 =?us-ascii?Q?VySXpXJWc9jd/IUQIV4COWtzDLktEMuPF/3lD48PppzhFc4sGJ4oE7OhAmBL?=
 =?us-ascii?Q?GenJabsR+WHWHlnRV+15lcpVwufO/vUlXsVi4nP+eJ4d3myd9A0laXHcxUEK?=
 =?us-ascii?Q?9FKoRmx2FGLm480+JUI6YLJUuRuAb1TpepRaOv4lmOtbAzK0Cq8XO06+JhhS?=
 =?us-ascii?Q?tLFDtGOkwHxTAhE6XJHVHU0e+l6UUltQmSfmeq0zqoZS48P7sDWC7ZxJamd4?=
 =?us-ascii?Q?DWsssDDNbISs//PHkDxlfJja8ccXQiAzcvIyBEUWdv+5jlXPrSHzTo72iAmH?=
 =?us-ascii?Q?shjh0Ew238RdwVEATiEwVJBngoSTsTCYvg3zeDwtZkix+aximHgb7s3ONl1I?=
 =?us-ascii?Q?VlL/2yl68kcq/39r/IIAw7ALvhN3CAjiVr6NJM6T8jNvNg1wA8DuwNbpDIcz?=
 =?us-ascii?Q?9+UNcgiaUGZflCtHXrkPSVFXCTbYQ8QgwHGEIYJYP8IuE4tMbSo2Fwx6jn2Q?=
 =?us-ascii?Q?DLuCxFvaQV1IecXYwvvfxcHjCcCMl9nEPaJsMq2msEtH2D2NawMoZCdyFwKe?=
 =?us-ascii?Q?PDJ1JLIgQUccS3Qt+zHcP0OMH7sT21JmWYmWTi9dRqoDb35q8SfOxNl8oFIR?=
 =?us-ascii?Q?KoFDnH8DZlTPB2yPIuTdE4oXmoNM/lChXd/ob1zr5rp9CJeb51qASF/xyAIe?=
 =?us-ascii?Q?Tq7euk2AwLeMgkD6ejX03kdubiYWIACaLhrXQCdEfVJe4yrJDaAtscDIYZlG?=
 =?us-ascii?Q?cxeSDxkf1jKQJSahm6oGNUR8oKpyKYB9vExW7gCxYRTZjnu2VrtbnIu9BVwz?=
 =?us-ascii?Q?7Y6KZF3N69E1cbenEkRuW4b5KfKjJG6ZzhYOIXAhUWJcUVQ0QygUR+wPfMyS?=
 =?us-ascii?Q?4GHhbw6uzvJySDoMupUBkXs1N0X5zShHz5/pz2Vlcy0p27LNIROQo3epirOa?=
 =?us-ascii?Q?0fmOwJPL8C/eU8zvDrPlR7w8/LFg8oKjxL2yHL5pCmFgU3pJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d6616-4312-4b53-65ac-08deb129b0bf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 19:56:15.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo2gPREdA+EE7pR+oDv6u7Q+kglZ1+hgHRqXbh8nmZDMS+S59aLiJvbLP0QZBkNHubE31RVwemY/zUJCqNEMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9426
X-Rspamd-Queue-Id: B115E53A3F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10437-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:39:12PM +0300, Claudiu Beznea wrote:
> Hi, Frank,
>
> On 5/13/26 01:03, Frank Li wrote:
> > On Tue, May 12, 2026 at 03:12:14PM +0300, Claudiu Beznea wrote:
> > > Protect the driver exposed APIs with runtime PM suspend/resume calls
> > > before accessing HW registers. As the current driver leaves runtime PM
> > > enabled in probe, the purpose of the changes in this patch is to avoid
> > > accessing HW registers after a failed system suspend leaves the runtime
> > > PM state of the device improperly reinitialized.
> > >
> > > In that case, the driver remains bound to the device, the APIs are still
> > > exposed, and any access to HW registers without runtime resuming the
> > > device may lead to synchronous aborts.
> > >
> > > This patch prepares the driver for suspend-to-RAM support.
> > >
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > ---
> > >
> > > Changes in v5:
> > > - none, this patch is new
> > >
> > >   drivers/dma/sh/rz-dmac.c | 48 ++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 48 insertions(+)
> > >
> > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> > > index d6ad070be705..df91657fd5e3 100644
> > > --- a/drivers/dma/sh/rz-dmac.c
> > > +++ b/drivers/dma/sh/rz-dmac.c
> > > @@ -488,7 +488,15 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
> > >
> > >   static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> > >   {
> > > +	struct dma_chan *ch = &chan->vc.chan;
> > > +	struct rz_dmac *dmac = to_rz_dmac(ch->device);
> > >   	struct virt_dma_desc *vd;
> > > +	int ret;
> > > +
> > > +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> > > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > > +	if (ret)
> > > +		return;
> >
> > According vnod comment *_prep() call may be called in atomic context
> > (complete callback). but runtime_pm may sleep.
>
> That's why the pm_runtime_irq_safe() was called in probe, to allow it being
> called in atomic context.
>
> The series was tested with CONFIG_LOCKDEP=y and CONFIG_DEBUG_ATOMIC_SLEEP=y
> no issue was identified.

I am not sure how magic it makes pm_runtime_get_sync() work under atomic
context, suppose runtime callback involve clk_(un)prep() and power domain,
if you call pm_runtime_irq_safe() in probe, it may makes all parent resource
on when probe. At least it should defer to alloc chan.

some platform's dependent is simple, which may just use MMIO to gate clock.

Frank
>
> --
> Thank you,
> Claudiu
>

