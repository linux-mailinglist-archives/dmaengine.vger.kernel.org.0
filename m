Return-Path: <dmaengine+bounces-10385-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI6RKVeSA2pm7gEAu9opvQ
	(envelope-from <dmaengine+bounces-10385-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:49:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 437695298F7
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6056230970E2
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2CA3B2FD0;
	Tue, 12 May 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xe5oB7rh"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F036F913;
	Tue, 12 May 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618571; cv=fail; b=mZZXMTcsrtj6imFR0w7m+PmjYnarsZWBP6DmtgfecA1bq26c7lf4clvlL8kCDIB09Xal7xuEXflaenT2S6uJOBKuIQRYA63/9ni1pm5AaFFMROhWMsVYYvivM/YwvrfbeY0Y5BaEoP20DVxMRdo3hCQ+mIebpCiqGh4+YmUQ3KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618571; c=relaxed/simple;
	bh=qZprDIBF3Y0re0xkugvjiM1f70xHalIQhh1ncCy1hNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RprRXt9IRDIWIlOPanThgEEMrXo4SU811KDEVW68u//RuUKSh4y3WzoBShjefBrbINpMIhIaH64GcV2O7kYCqquzquTVE8tdbq0fNPQ9oE9KcQfbIkX+it9vwm1GG7U5YJyUvgnzRCT2SkzXogXaiDtblu3s1cVoLsyY2x9xD6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xe5oB7rh; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byLhlgeSYD91hYOU/iy7E7ZSYpYyVWgIBQycvRvQxxHiI9kmNTFLEH+ZH1ReQbxTdm85oP+ibs8I6GWl0+6Tl6rSOTY2ToFynhIZB1p/DbVaZ5nzVOavbFQmx1kisvBebLSelsq30LZ25cLsRJV/3Zyzk9I0j6BMcolt7GYeTN8iV8EncnHoLP/AydcSzVBWFY3uIPf/mmI9sCZpCXlpR6bJVZywz9qx6LDzl2o03dcU6Drj/p1BYSpVjv3iKNcW6XTJuUjPSgt9Wwlk7jH1GfeMDFE3yvzTcTRwjw2jRBSTNQxYU6D2jsMKzJEh2sDPif75olPh1cOrnOZx+72Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwoJO+fSWMPEShKoMhuGuoXOqEi70GBuzzltHklkxXc=;
 b=CSE33CyomMwVyMoRtTsQMAuF3TPnTtslpokIa4u9ufCyMipTXGQSd62X5nDeYdAknZlJoRHN6z0PTbnwSoeF+55yGNm2qRwF4K756NtpInZ6VPm96kUxF3TI3cVEnA2B+92dH+B2z6Ge/UW99lYB9wvCEihLNXKy79f9PdlSoiEN+tA2ghGxgHsQWyJjKYDb042cDxu5UnJ2+NBHko6Woa142PUyL3YAlQ2QTBjsHHqUNA95AEr1RvdStJOXaYCIQnccfYoBVlvpPdbSTYhsKt/4Jxfsm6RRh64nmzCtlBkjPvKZbN75oSpnNVVb2xaNmztnCQAFTZftVTJtQSygKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwoJO+fSWMPEShKoMhuGuoXOqEi70GBuzzltHklkxXc=;
 b=Xe5oB7rhu1wPj1mTsq3kFvTK9k8j0ZWIyxTpRajIEnengal5IVQ+numUH8vSP2LP7oy9Tu8MSCFIoVkik7SruPfShkqwNqWlrPCaATCm6rjkHIBhS1QvPLXrda7GsSNt3l6FmYhcSZFlUgUO+v7OxXL+GE5mwraEPWTPmDkOiw/PoNzeZua6DoMdOxMv9AK5cEov54qMWf/x8w481IT2G9v7/uAuy77MIF+A3xtCbuVkqqXR6U5MCO0osVIavTXXzrTtpXYv9lXxpvr2xne3pzUbfNjaE4N5BUJ4eDMxC+42Ch3yVUYND1llR4zAJD+IO3ZTLMIqgC1rfvNj8+M/DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PA1PR04MB10142.eurprd04.prod.outlook.com (2603:10a6:102:464::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 20:42:47 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:42:47 +0000
Date: Tue, 12 May 2026 16:42:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 04/17] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
Message-ID: <agOQv0SV_B2GuYUX@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-5-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-5-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PA1PR04MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3789005c-62e1-4b65-a00a-08deb067064c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|52116014|366016|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	97Y+RAGgVB2SVnSraI92JcknpWelmwni0U5bL5J2pXCDW93XBT7EJKjOqql3JmOlh+yLV/rM1PlBoveu5+2c3xSZxUXFWh8lfafSb17IfesyR74gDesMBpfV1WyirqVogps+OoWFmBKkZkVWWoW7Qe2+bFD29tNHjNlwJFL/hM+9I7c4zvpPFxzybuyrtksdFOe9OkbYUsEyUIBIf+fRykV1NWfM8ZApOA41yd9rzeNdXs7l2WNGxKxlZBFeP2MeeTiCDwCvZpgiyvcXgTUDCCusYRGqDzH0Rb6XWR75ynWVXMXaK+GPTwWN650CqhS3JBFf5jjstfZjYBbDbF9A9UKcKe2JyG8vS/zzT0pmBwqzp5TtNLTHibkCDywPqeMmLlAt//XVGMzA6ypICY6WXm2on4o4wlg6F5G5Aa6EpyLylATPGeIGCJs0lAVumedm+pXDc67J9/Hwi7Y99FiEAvQ0JQJKcBwSrAiQkvfD2EfVDMfIfR1lu/kspUAvP0dEz7MjdN+bSCNWvBtt1E2T47BOuTixq7v0ddlYU/DpwzHJEbKoHz6+C4J+XUXV2K9iHrZ2YDVrKTbUWx/zs9nv+2nV61fBcrqNOFx6d1QdOu0fchRzh7ZwiR52ZjPNsW8qK/6RFqkrra+TH0ha3EIgPt4wwTYCcYzQeo12rbIurrLHmy0WU/cvWTlQAn41dyFjDrHRftHhCpJSjH+Cc4dH63KS4xx9Bg/iAhzVU/CaGkUgCpV3mEBRpV9OtCnmwW+e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(52116014)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Jcef12Bl6UzbHXk70DbQ7wTCaCTZP0ZAxeSESGI47TG9GS2eHMzdCNSF/tR?=
 =?us-ascii?Q?egST6DlDNqU3iXsCrZY9G/ynGpK/52ftqjn+fUxc8g2brQEiXytKR79BYUSA?=
 =?us-ascii?Q?siTmHF6XrQhtFV0bCPIh2yodsvEe0k4F7/UHrUawP3Bjld2iENOIUcT3dtf3?=
 =?us-ascii?Q?CvLfJoQMWr5ZjA1tj3ovgOGb2UwfKF1pveE9MbixNMwg5NeteDgDz8vbggfA?=
 =?us-ascii?Q?chLCmd85MyrVpWAHASNDiRRk0mfNDzwPe8R6stuzNQ7szf5GRCK5TtGbLxjQ?=
 =?us-ascii?Q?G7pYqGfx3pDxqfiA5uNqAdnnW5vQFflt47Qoyc0+KVW/atdeOJFQPH+XcHfH?=
 =?us-ascii?Q?lq9eW88P8zpsNkHo1ak11GsDafhAWnoOXYJH0VA1mBxLEkhg1JAowM/7wcFa?=
 =?us-ascii?Q?eeCyjhhmPfs9oNnjQOyz5Y4Is7hNWeaPd9a2Kuv+QPn0V3XZAIPaL958eJ9C?=
 =?us-ascii?Q?BQNK2P64yATq4YSuMrf4R0u7CD9848MvT0i/vAzimk8d7uR30jcMZ4bk6hGI?=
 =?us-ascii?Q?huBhDuM2LZi8RfGRqW1vVtpwpEe1dbw3mcof1huF7m6vNADzu6ocNe9rcjXh?=
 =?us-ascii?Q?WFul5CS9rkWkA1WU4u/6ZHGoYAwe+b64mzpG5kbcYxwkGbdBsSL5e3mhFfr/?=
 =?us-ascii?Q?nBt1j/1pYbWOuTj4DkjXKOCv60HR9ui7o0Pgz5UezqfpyTQC4RKl6RVaTY9f?=
 =?us-ascii?Q?IJ0km/iQu9ybh/Wj73596Xc/yE9T/exeAH+OSAy7dSaGmDkHSUDlrQbySufs?=
 =?us-ascii?Q?7zS02juUD6hqAQfhsP7oenMZrxb4NsRXTir2F9FUbHszSri2OZKygyD2mw6g?=
 =?us-ascii?Q?RQu9SDsZlvJpDB2TRQVAlIinynQvSZ9f84y18/grj4sP6HYKxUH93lmko7Jd?=
 =?us-ascii?Q?94CbfsW+jfiNpMMQqv9Cpk8h+/w3p1hZHi9InrcvZETw6p7V5xcqG8jEiUR5?=
 =?us-ascii?Q?fQvmjBAPR8SJsRvjDiHMZp/bzz4Xat2nfyWrxvsMgSwrH53W9FWtdNC1fhb9?=
 =?us-ascii?Q?PswpCY/AKLBkX93+JTOksxgfm2c7WZEY7p6LsBptBsjhDGu4MzQp+ARxAo64?=
 =?us-ascii?Q?VE6YTfiKaBZZATIQMtR/xVqqH/1LFRS8XWiRw7Iui7+PscWJqAwQP9rpyLGE?=
 =?us-ascii?Q?8KU2f+ju3gZL1k8aFEHiNgBi2N2Pl6wV9u4Qj6/TcUqBRaxNiHrFIpOr2zGm?=
 =?us-ascii?Q?tRFAYmlDEjXZv2RIoBmLoelQkEt67avLFRO/I7DGUE7qwerp6Rj4XURqY0VF?=
 =?us-ascii?Q?ZCkea3VPt6HwHuICQBe6IHza7mTHG927YIfwQFIVcbPi4NGGvFpKUtpsfIye?=
 =?us-ascii?Q?vG0hm0u7FlsRSBQatsDrmfdPPGSShmoNMBTDS/j8/Wxb8HVzNrTz3RcceEj7?=
 =?us-ascii?Q?eCIAKH8SeyyYlKCe20xQcGDWyXJdYjN3Yp+QoeOaPuSh8Jo7pD790TaA3RA1?=
 =?us-ascii?Q?En+0zu3o0/IKIJAklR3U4WwMu2hQ1ThLX9p5JQ9d8fNt+bKrVzY9Zwq2nQNn?=
 =?us-ascii?Q?6G+0GIHdJtIuI/KjxGv1SQjlRuNdnp3TaDjcOr8U9NTNKuMdia/LzgF8iCd+?=
 =?us-ascii?Q?+DlberJf5Dw6OzatpF8Na9d8NJPiXBpyC/6GfLb4+8JqNDEodeGGSQvzt2V/?=
 =?us-ascii?Q?HU8yGbSnE7vTXZ/MZqJCafySUnlJ+TmGSZfCpOvhkgbSMZc901D3n4sH33jO?=
 =?us-ascii?Q?GA9972j+fA2dcVsVLb/+WrEqodOoQiXm3Y6BTwUDGe1tPM0+Paftp5d+va/3?=
 =?us-ascii?Q?UfYe1as2tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789005c-62e1-4b65-a00a-08deb067064c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:42:47.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZ8FE6MUSXOiQ8JleEtK8tfg3nf3Dzk8F2bg32IsLmZIHUYPWNKdE8z162gkrPL7eJbspXAhTBeuYciCqsWjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10142
X-Rspamd-Queue-Id: 437695298F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10385-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:05PM +0300, Claudiu Beznea wrote:
> Use rz_dmac_disable_hw() instead of open codding it. This unifies the

Nit: typo codding

> code and prepares it for the addition of suspend to RAM and cyclic DMA.
>
> The rz_dmac_disable_hw() from rz_dmac_chan_probe() was moved after
> vchan_init() as it initializes the channel->vc.chan.device used in
> rz_dmac_disable_hw().
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v5:
> - none
>
> Changes in v4:
> - in rz_dmac_chan_probe(): moved rz_dmac_disable_hw() after the
>   vchan_init(&channel->vc, &dmac->engine) call as this is the one which
>   initializes data structures used by the debug code from
>   rz_dmac_disable_hw(); updated the patch description to reflect this
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 1717b407ab9e..40ddf534c094 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -873,7 +873,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>  			channel->index, chstat);
>
>  		scoped_guard(spinlock_irqsave, &channel->vc.lock)
> -			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +			rz_dmac_disable_hw(channel);
>  		return;
>  	}
>
> @@ -1000,15 +1000,15 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	}
>  	rz_lmdesc_setup(channel, lmdesc);
>
> -	/* Initialize register for each channel */
> -	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> -
>  	channel->vc.desc_free = rz_dmac_virt_desc_free;
>  	vchan_init(&channel->vc, &dmac->engine);
>  	INIT_LIST_HEAD(&channel->ld_queue);
>  	INIT_LIST_HEAD(&channel->ld_free);
>  	INIT_LIST_HEAD(&channel->ld_active);
>
> +	/* Initialize register for each channel */
> +	rz_dmac_disable_hw(channel);
> +
>  	/* Request the channel interrupt. */
>  	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
>  	irq = platform_get_irq_byname(pdev, pdev_irqname);
> --
> 2.43.0
>

