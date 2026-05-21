Return-Path: <dmaengine+bounces-10674-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDOBFv4qD2q3HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10674-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:55:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000A5A8BAF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A20B3077E33
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD92D9EE7;
	Thu, 21 May 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mjv0MDt3"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65D478F3A;
	Thu, 21 May 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376130; cv=fail; b=ETFnwq1AQ5XfLFVsPm9f9z9xPSX8LOmn0uaI0jxVDhbSRWENDmZOAHrb8B8H1gGnf/hTjWwA5STnleBmQNh1m0giA+JcROAf/oZcYnjRvEIqORe0PG/ffBg1fOpmfvunomGSz0r1ZepHgi2ofOPt2tG8+hiv3s2gCaoEV4t9quM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376130; c=relaxed/simple;
	bh=J9Fq/D8hv1sE4Ufb5d8s/n24/xJZUWCMFbK0siqO2DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eb/0P43F7KAg/mA4LyAgst8qYYqdJRdwHxwurZxZmt7Sf72S9RAzWSzVfgJO2FBItNy0tcbP3BTuJNicF0l216FV1UwjPnEKC4c75ID5tn4eifQs+wlfHYHZf2VrJYRlca8sWz+Q/CUB+LVKC/o7b9RU4PTIsjLm84cl2/VOmuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mjv0MDt3 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvpmKWpVeHORKAD+Lx3nBZceIhC2ai8vc/76vMNip/8TKVw1ZUJnHBCOep8pEgsfeuvEQmUmQYRNRPKy0rHYMM8vfnwW2QfaooyjRpAwaqLkcRRysRgomaE6USmX7NzTnVzfqA7+3INbzc4O3chfHxsEi6KjeX3oy3dhG85iqtoEZdSRiuG8K6ygGmiGjxL6HvOcyHGFZu6YUHJduQ775U7LsRsG3JYK3bOOnbZHUyRVtXoQ8wdLT6B9V5GNVk1PAlHc38OY6DglcxivDP6DIsaCHrSTbgSEeMYutTzyjaIebIUFoaZ0r8dloHM/thfEdbzqcgu8oSl2gW6rgeJiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gWgCqgkKN5WZHBcODY6PQcAFTruPuJT/uVbDRz5P+Q=;
 b=DlucsHw2VDWgqEspePKvWBV42+VZ1Co5P0Hoh3ISbe/O0gHpwkfYgDqU9BopAv8+60rE4o4MihgXEXn//9EngRw1K8dnotXd27nUAJPKf9jqA4lR7zyyxaA2ZF1h+pju7QkH+xcQtkdC1QmFlggREGucxbPuYF+xSDT46e4GDuwCVkAUW8UVynJr9TMa0cgxiVf7yG9B/H6fd8tAU1h2lYwzeASyPtei3cuH26jz44psUTCqO42P3SZ40dv26HaeiV+0ek8quqZbWjZHXml9YJw/031TZurepLN2j8Gia0xWfxAtYM91ypr9iKBIw6BrnpyYzXv34WyO3d3kU/epqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gWgCqgkKN5WZHBcODY6PQcAFTruPuJT/uVbDRz5P+Q=;
 b=Mjv0MDt3+P9/f8vt6Na5P+321eLHzvwTQdotu+VCFPud8UhFqQiF0geoZJwQfvKo21aYUlaZlDhlc8WXpxjOe1MfvGELLVGrqNP2NZNqGD1/PnI/089zzcQ6TS1DvxVFF8NwGxOHbcK476qgXRIrmgkgYoix8OptosFqDQ4WFsyVrYEfGp/jC6BV27gEeKluszhKV9nVkUwXrX6qsXDjrmHGxXc8PyKn6veuWdLvhUUL801hInB7a+bqGxY1HQJYgmERFcUrRh2S8zwmJsPwDK5TC18tzmupMtB6GluKkaYnpdHfsW9ltlmDLRtISkADBHIJ69QYc/gNs+417bAgvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:08:43 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:08:43 +0000
Date: Thu, 21 May 2026 11:08:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, dmaengine@vger.kernel.org, Frank.Li@kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v6 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Message-ID: <ag8f9pTKDi4wPtL3@lizhi-Precision-Tower-5810>
References: <20260520-dma_prep_config-v6-7-06e49b7acb38@nxp.com>
 <20260521013956.816211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521013956.816211F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU0PR04MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: c308c559-7d95-4903-f66e-08deb74ad972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|3023799007|11063799006|18002099003|56012099003|6133799003|22082099003|38350700014|4143699003;
X-Microsoft-Antispam-Message-Info:
	/j9p1QpbnauyqOv78vJsKX17XoZLh4NMZf5ru/IT4wBbA1eow/1lbMexrdT/nm4EzjUmT/Jicaq9dZAoGjTH+O584WDdp2g46LS4uZmd+mM1CQzwjK7rfAWrGjpRUcnvyIPTRQRgPkk7i2oC7HTlt6CsKn15+hJyQez7EQ0KlxSFwHiVI79g/HpK0akI+oFdm7Xd0d//+M+pvb39n610UO3wOrdPMu8NXppmEvf+XoL6tcZlFnW8oMZX7q7KPrdI/D6mnli4UKVcUMBjxzDXRDacdThB/PYeNHUc+N9f1nkKZGFvkMGygPZtS4OqpGsz7NKDcEpkcbwle0jKWjYU9TrTVyrzP7wZj08A7n1kR708L6xKRqNlNeS6ALHsJB5PuUtIIjRlAzZRnkZjhjR0dRe2uQcIIK08CGXslqiPtp/nCqp0pzkbXjJQPjw1oAqY65nG9U6ndeChyoP3nVwDX1/O8crc/nArBuOAwWYNQmT0YIsiF48mEocoe7pL6xSMTN+zkUl78cg/mAjAQrxjKJDW+gxlPplDl0IoD1lXey1h6zS3Q6gDOe6f7bHzU81QSkr0p0WSdbhqW4hRjT3jNE49nIeVjgriHdLPMITcvwHt7zZ8QGSYyMZ+kEcVfD0myeC1P97URJnO3zb/e8PYK2XO/VjJKShsxe4Ua5k1JgH5w0ug2kU/YLKuqS6HSQ3H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(3023799007)(11063799006)(18002099003)(56012099003)(6133799003)(22082099003)(38350700014)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Wuddnl8OWrv8KU3nXe7VeTP/8/cSPWhwapSmnJKWsqDA7+yAtJAM5mO6HP?=
 =?iso-8859-1?Q?DzEFBrxxhsqm2sUEp/AyjoJbyysT02z0XWLANvb2i4CaFRUmrCvjLux4sx?=
 =?iso-8859-1?Q?vs867Sqig4fyM95giWsEED3qlMDvYdeyr4CXse9Hpq+jU3vO8Prpcf2mwZ?=
 =?iso-8859-1?Q?k52pE6SKf/2HdgLYdaCWIyS1lTLZaL/O2R4upcjuBBvNpAMt/WP3e59U06?=
 =?iso-8859-1?Q?k3z80VcUVBmI/t9eb4VHtPgzmU4nQA/1vcH4mRdvYY3IYkx0BIVUSoALc5?=
 =?iso-8859-1?Q?tpdBtXUUc6nD5QlSnuJ7Wy4Lo36qU8YzYijKskotlJN4j68Py7O7pb2N/W?=
 =?iso-8859-1?Q?twuV/DaA7S72B/ho2suUnvumn1X+mg2paaWKfftc1upT08llQnpM/7RK+H?=
 =?iso-8859-1?Q?fDEGKzxjPyA47TKv40TKQKI/+dMPPw4X1LvAUdBPProuf3ddbt+pisagoQ?=
 =?iso-8859-1?Q?NFB/FNtVBnMmNgIW0P8No0G1blSDyouo4z/yqQVdY09cRYk0s3Jr9MV+Ka?=
 =?iso-8859-1?Q?YhadQr1LlkYjVIhvGV6NgktTFsXFzBXEAo/hwFXQ9w6TkS3PprE56j+pr4?=
 =?iso-8859-1?Q?90k95EEu2GUlmI8799mXn5X4CXJhTMEVvv6b8Rz2Vxo6KzHYwtpTKl0IBM?=
 =?iso-8859-1?Q?CGWzYRF53uHFPcCxbKJ/MzYkDZF80ZjX2vSJZv3kbt+8c9RFTMP7RDHIAL?=
 =?iso-8859-1?Q?X0dWeU7umZhTRhWpMW88/+35zsvxv8GQXj7oz7cwqcJX1mSyalhXSxnVow?=
 =?iso-8859-1?Q?kN2bIPlrOgwgg//tMGngpdK3UIgiGnrzrDjZm69bTmuwLaQFQSBPvDDPqZ?=
 =?iso-8859-1?Q?XKYFEOAFjXPIOFDSpXJBOIlTFz0XI9RyMlocAP4+HNIYQc0XedJNeXL/cH?=
 =?iso-8859-1?Q?WjtpLUUho2jLacXcmXU+6etAcyr19qAIs+lenHP+GrKYt9vy0AGgUZq1Vk?=
 =?iso-8859-1?Q?w/A8dcWdiO3kkvDWTdtfHuWEgBQzB6YZSJ5+rh10cYvioJVHtBhRjRVN1Q?=
 =?iso-8859-1?Q?6o0Kuh9CLHKLgCHR/ROLtnFXzAFifC42BoewL8JjXfzC7WHxcsroM2E/pS?=
 =?iso-8859-1?Q?+/oVyFMzFyMxy2VA7bvXcIiXoTHDmxG3oi5ejpe/nAxNQ1ngJm9wZVHVqv?=
 =?iso-8859-1?Q?1jKAbHTF6rikdxlZheIYLm1TXmoxPj12N87qKeO5d840kxD9J0ufwjU+I5?=
 =?iso-8859-1?Q?ZBfBEN+I2pQV6wPmcfZCHg6eriPoOmeNr6Mh4bksLGKWip8is8A3Q6F6EP?=
 =?iso-8859-1?Q?IA+C3jXFVlNs2A3QX3FLWNYMP57fsLIdXr3cH9Ob8j9aPuxs5juvfuCIMD?=
 =?iso-8859-1?Q?dPFc93MSMSYWIn9MWY1wP9EgVUIsRFvY9V+Yh2ItAZSZkUUdE1da0saY5c?=
 =?iso-8859-1?Q?OQ330BIlXCeFo8qUBharfnzmiv5DeOkKFIa6P6y6MhU9vFQrc6P7Z5xAb7?=
 =?iso-8859-1?Q?Nb7qjlyqJgDwD38cSGwLGoZyfZfGbligtU3elxRKL+itN0jtSmnDaTvZdb?=
 =?iso-8859-1?Q?0kUDGuCcQDaiDWYYT0jH3T6K7jom38EuyWAmscjgVLA3Ikvwn9T4wPHiB0?=
 =?iso-8859-1?Q?BfgpjZWxiJO3215XD/OgBeHIMVXJ+/NvWmT5gNHUK1MQ7WW17tvpyP9b4h?=
 =?iso-8859-1?Q?0xs/qyHCHOqpEHZVdOs4x079HNjaqiaP53WpL9NXL4+T2I3oyRMyoXJ7hp?=
 =?iso-8859-1?Q?d5P5tLmw/KesequkWfvppcfWShIVU0ouGFoVDV0bXqhwgEciFff9TNZhNr?=
 =?iso-8859-1?Q?2e4MG5qdpQgRNF0mNPd2wZJEphluocrItTtRaqUqzIz37dWqx/iQ/a+1tA?=
 =?iso-8859-1?Q?IPEpgHC0Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c308c559-7d95-4903-f66e-08deb74ad972
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:08:43.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDDdu/QYJ+vmQ3l0RRGQR1IoZWWgtVe2renygY7omVBJCO3v9tDV76raK3yU9KpsPYBQlka0Whc0jASB6e31Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10674-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,nxp.com:email]
X-Rspamd-Queue-Id: 1000A5A8BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:39:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Removing the mutex introduces a cascading teardown failure and use-after-free where a single DMA timeout forcefully terminates all concurrent transfers on the shared channel.
> - [High] Massive CPU wastage and starvation due to un-serialized concurrent busy-waiting on the DMA channel.
> - [Low] Unused mutex fields and their initialization/teardown code were left behind in the structure and lifecycle functions.
> --
>
> commit 9bda24c8bcaef3ff0459f6035b72408052dec87b
> Author: Frank Li <Frank.Li@nxp.com>
>
> nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
>
> This commit replaces dmaengine_slave_config() and dmaengine_prep_slave_single()
> with dmaengine_prep_config_single_safe(), combining the configuration and
> preparation into a single call. It also removes the mutex locks under the
> assumption that atomic configuration makes them unnecessary.
>
> > diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> > index 2afe8f4d0e461..f917d6ec278b7 100644
> > --- a/drivers/nvme/target/pci-epf.c
> > +++ b/drivers/nvme/target/pci-epf.c
> > @@ -368,18 +368,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
> >  	struct dma_chan *chan;
> >  	dma_cookie_t cookie;
> >  	dma_addr_t dma_addr;
> > -	struct mutex *lock;
> >  	int ret;
> >
> >  	switch (dir) {
> >  	case DMA_FROM_DEVICE:
> > -		lock = &nvme_epf->dma_rx_lock;
> >  		chan = nvme_epf->dma_rx_chan;
> >  		sconf.direction = DMA_DEV_TO_MEM;
> >  		sconf.src_addr = seg->pci_addr;
> >  		break;
> >  	case DMA_TO_DEVICE:
> > -		lock = &nvme_epf->dma_tx_lock;
>
> [Severity: Low]
> Are the dma_tx_lock and dma_rx_lock fields still needed in struct nvmet_pci_epf?
>
> Since the locks are no longer used here, it seems the field declarations
> and their initialization/teardown code might have been left behind.

yes, let me remove at next version.

>
> >  		chan = nvme_epf->dma_tx_chan;
> >  		sconf.direction = DMA_MEM_TO_DEV;
> >  		sconf.dst_addr = seg->pci_addr;
>
> [ ... ]
>
> > @@ -388,22 +385,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
> >  		return -EINVAL;
> >  	}
> >
> > -	mutex_lock(lock);
> > -
>
> [Severity: High]
> Does removing the mutex introduce concurrent busy-waiting on the shared DMA
> channel?
>
> dma_sync_wait() internally uses a cpu_relax() loop to busy-wait for hardware
> completion. Before this patch, the mutex ensured only one thread actively
> polled the hardware at a time, while other concurrent workers slept efficiently
> on mutex_lock().
>
> By removing the mutex, it appears multiple worker threads could concurrently
> enter dma_sync_wait() on the same channel, unnecessarily consuming 100% of
> multiple CPU cores and potentially causing CPU exhaustion.

exitting problem. some edma improvement patch is on going.

>
> [Severity: High]
> Can removing the mutex also lead to a cascading teardown failure and
> use-after-free?
>
> Because the mutex was removed, multiple worker threads can concurrently submit
> and wait on the shared dma_tx_chan or dma_rx_chan. If one transfer times out
> in dma_sync_wait(), the error path calls dmaengine_terminate_sync(chan).
>
> It looks like this would forcefully abort the shared channel, destroying all
> other active and pending descriptors belonging to concurrent NVMe commands.
>
> Also, if Thread A calls dmaengine_terminate_sync(chan) while Thread B is
> between dmaengine_prep_config_single_safe() and dmaengine_submit():

This is another problem.

Frank

>
> Thread B:
> 	desc = dmaengine_prep_config_single_safe(...)
> 	// Thread A calls dmaengine_terminate_sync() here
> 	cookie = dmaengine_submit(desc);
>
> Could Thread B's descriptor be freed by the termination, resulting in a
> use-after-free when Thread B attempts to submit it?
>
> >  	dma_dev = dmaengine_get_dma_device(chan);
> >  	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> >  	ret = dma_mapping_error(dma_dev, dma_addr);
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com?part=7

