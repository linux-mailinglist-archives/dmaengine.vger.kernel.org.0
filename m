Return-Path: <dmaengine+bounces-9262-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IOkIgP7qGnVzwAAu9opvQ
	(envelope-from <dmaengine+bounces-9262-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 04:39:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6D520A9D4
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 04:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41FE83049169
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB523BCFD;
	Thu,  5 Mar 2026 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hXr60fMk"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123B221540;
	Thu,  5 Mar 2026 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681778; cv=fail; b=NHOA8SuZa8JfM5CB9Vr+3xJC0U7nT/BuX91iX1LZiOht975qj2QbVgfdtGwEY9TpV3tdhnb0a3uIMbvOsS3TYUN9Zmf/gwF82p3PTyVyQviorv8wI6UospBWv4tsjZsMOc4UzcVwvIuGvdzvGBx5P6hX9f3yaabB9T7GODlHtEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681778; c=relaxed/simple;
	bh=83qLfESSAynFnOGtgr7D97zU5LELXuRM0GKbwisK72Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rFvX7Dx/DEdrFLi5ZQCzR2Eqzg+4vbOG1K5rrDtC8tEXrCzoQLssfNTgeKggmklxzOBuGLPXztTAqym0cna0/HNFtAutZj1rWV77IjzUpfKnM9dxKmKr0KNL0XhZGTYAUXJmLK1omqOexNhV+dTErWbYHaAp3DzULKZyoKZ/lwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hXr60fMk reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ehq3eIwb+1r924YCLzPVlvxYP3llLpzVN2cWAXrGILJGXAXAfOP2RXIu+E6+VKMWLHWRYVX66YBbOv81bealb/E7snp2qEUq0NMi3VtdfLwbo2ooFfvSZn3KnQP6XjcaOpOk2pd/rY1ET5PwEtNg3of+DXeuiDqT/C+SAoahO6dVp+n8unKXdfgWXsP+iozglb46umcZKopXbsNBtHqV/3jwqsgf7o5K+yen2N7HCbdM+yNV53e4RT5OBEJi0qnE0iwWCJx6eFcwCPU3kIiB06m7YtJJt4on0gdr1n7VRwi/yxEHAFpPVdFo3u00Dgl7dbf9o4MylN1qTXfs8hTpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/Vbm4zZe9E6f23MiuzdOf2dJBXosmrsewapTogQgVE=;
 b=tDnsjPir3jVMuQSbC7LzMn6izKJBk6XXHFGf2UwTeCY51kuwJCeo3kRkE/Zyuhd1K7EYy0e6Wb+cX9CB8FdEa9aC+VA93IiZ0neb8JSjBOAdGpW6qW04HPVw4wbCQdpsnH3VZTWv/csDRNcJmES0ERb65QX6xxiQO8SaojACrwyyFoNx7OLFRarxzX0mLXzFs01R3F3+iKAMC/zWHNthaGBzauIcHGiV1W0uBjTpqPzqMeMl0rCvn5DBKm3VJL5V0a87DlIP+5Ee9KGJSnsYp6kJc42KFlD7YPP7p4ccAiLSygpzOTDwYBM17Eeu+Rh1Kr7UMOSJw+ERDmnHX9PUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Vbm4zZe9E6f23MiuzdOf2dJBXosmrsewapTogQgVE=;
 b=hXr60fMk4QRGqZ6DDWT/xUCD27Gz1OoMVP5QD5SsXFO82KDHIYcM6yzfhzjdqsL2VnCt+tq2sptLrOb0WtRLAW0CcoPRu4VABPHAe4zgKtgXVG9IgJ1r6sKLa5wd7uafyqZGZw+Tmhgi3LXCIrEr9INBgjYP0WH3xskPcCy6NKe7g9jj6WQ2ttenn4iTY4i3hykuqBHqxUDRzkrVYCwohwrzPhZ0npw+fvW0Zg6IFSUWaCSGMAxzCovm7edMx+Q31C8nNbIjHjAD6KuAq+5s5Z+l08aO9yoe5u80/S4DhPOZbzNdfurer2nN3F9NQbaHRodNNw/TrObWHzj5kBXztA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8541.eurprd04.prod.outlook.com (2603:10a6:102:214::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:36:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 03:36:14 +0000
Date: Wed, 4 Mar 2026 22:36:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/4] dmaengine: ioatdma: make sysfs attributes const
Message-ID: <aaj6JtGjAszUlmRu@lizhi-Precision-Tower-5810>
References: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
 <20260304-sysfs-const-ioat-v2-4-b9b82651219b@weissschuh.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304-sysfs-const-ioat-v2-4-b9b82651219b@weissschuh.net>
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b70932-e179-4408-9a0c-08de7a685a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	ggRN20hq9UrmE2CZzF8hX+pziuJyI5VXCQJZfGxWU06rBxYFRCBbP93pCLlvkv8tc3DpEWEz3NLT9lpcInszCUHKPqJVeXMwAGmF5zSldMh2//tCfVI0PVGmet9I9cuaixbjn65wuiB6WQ6AS29n1bGseXp6PTzkRzVV3s3BGfTsrSmo39q9fmlJ+WZRw99RSfQH8+9aW1jcimUfXmA+rNgoUsKRdfEuiFX19ZSl/sahpkNNoVdAFTwnR5RBBUTCKKKCysexkZVdMVVCRvxChkGdmNEK3RSij4xOhQfH8g6X5ug8H2QffOTOjz8xjsTCPMbRvtjdW4Zpq6P/PNju1H5VIoNJxejh/jXwgkdcE5ssQgpCLf2zEJBxTucp93xJFk9G99fAI0v+cjP3KDavYPzrHpfl9C9NMhE0WcRr5K72hHt1Zb0f8sGzqHKWzcjxT7ssa9sbG+XAJbzcZPQw08I1xA6lDpQHyw0ippPs+XXfUhvGEPCOEWz20MXHyMWWHv5rdeml/gt/911D0YV4LD0CBqxJc6YFwfg7Rtpq+wPA2bWUXefYPs2RyvnYGolMP2Q0gXVjvigJ5pFTauZnFLnyqHCy74xIHdclN+scvXEcPpGhUMB2C4dSCklApbvX+3buYw78xpxejbhn8qsjx52mbCts+pj6HBlhyHJzStjsixgIaSY75dGuNyXumDNBIhFoQm3sZjQTfnbgxVeHiV4svUqcw/mAKBJqMhnpTngpJpwVPRNJKwlhGyutAKl54XgEBBokWaVtY+yebfHSgcjzv1Lr3KrJn1zphc+jceo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4GnhDJnprXtNw7gFKZ72l+r052ctlRV59sHnmlFiLZ+v7NSqGpxSssT04U?=
 =?iso-8859-1?Q?lOCYNq6RnwlGTxJM81n5DWQf6HPMRWCC0YYCKs7cBtxlL24lzq13mzlM6g?=
 =?iso-8859-1?Q?1o5/jmCX1XopvxB7LoDnQ08axEhaZtPUYzLop6RPKPpLOB/1O6H1oJghGN?=
 =?iso-8859-1?Q?2VcEAyeBCIQaSI4vJWS3yVrbIEw3yfqhSyxZc04wIpyv08YVmlSeDOglho?=
 =?iso-8859-1?Q?QK3zDv9s5klPPmcFzHmsDVNXcdx/kJYWevV3xPF26KXgH+xflrKCNUoP9O?=
 =?iso-8859-1?Q?E/DDdBy4izfh+XJ/D2Y6ygahwFYIdMmxQHAgVl3d5g8F6JszY3GDbZqind?=
 =?iso-8859-1?Q?5KOhuOnlKULvt9bMfYTgS/TkTnUZMxTwhPhd3+a7kmYjGzG48Kb7QyjDBS?=
 =?iso-8859-1?Q?FzDC0h9IUkJH27G1+/FmCixy8JU2XNDeVFHVpp99kq0qP6yOylfJIdHwEv?=
 =?iso-8859-1?Q?l84xP+kvdv5mGy9nljW6P9iQTpspjLGNshAqf9j6BZ/x5xEf4CowDDQE07?=
 =?iso-8859-1?Q?N0jxS42ZgRqlXT7V8sv6cYeceHhaX25BrNY3qpC8qyqYRrMZrp5sZpNYDq?=
 =?iso-8859-1?Q?DvQcAxnTf2TOY7NrUyhLOhTpFrcGsaDKbeX6Qv4YWRTf/6Kkog7iKX5ftX?=
 =?iso-8859-1?Q?iKRM6uHf2LD6FXYekJ1uMsTLrDIGUwpHwOHt+adMRbjCHz+ZoYHP+IasrF?=
 =?iso-8859-1?Q?SDZmCNvU+cGr0vV7eOCiGIU1NzgNf0G8s32gYqFHBA25KEWV0OYSLy7Ghp?=
 =?iso-8859-1?Q?LtzGXPaiJ1ZycW1s1X/DWPpFr5VXIzu1La5dhs2SREddyi4umMB6qEEP3F?=
 =?iso-8859-1?Q?/U3n+O4QZ/R66gE/MXVHLoe8sNzKRFdUbuH0WmHnIkzIp3MiWfPLiyvYRU?=
 =?iso-8859-1?Q?AAVANrfgxic+9Hn7A8Pr8NtDn9uhMEyd4TdNs3cE/AOi2Oz1cwqlxW64Fh?=
 =?iso-8859-1?Q?GQT8VtaqdqAJbVvFLCUbZNUYkxZ6UJCZHNtoZSIkjn/Fzqpk7RFq4KD7Pt?=
 =?iso-8859-1?Q?L6Ibb8j8YDKw2M/QecSnSbd35D2uxm4GrhcJf60iBjLRSzFUWY9g7tKdoI?=
 =?iso-8859-1?Q?I789+g3LnnAOZvU0Lxu4Ouo0qk5zlGij5yumaW57R/gdPbhrmcph9ECJzW?=
 =?iso-8859-1?Q?SoxjY6rUspP7rEz2Kdg3qiCRFcdQVhbMKMtLQjeBih26JO1iVfZq8+vyUu?=
 =?iso-8859-1?Q?VpNtib1fG/6cAbr0rjFlRyxrjPWVKrzOGSmBeCKVPH7kV+epNeUIhEA1pe?=
 =?iso-8859-1?Q?iajfXIKbNzfmCmNifayaP5dTFL0b4Zz1xz2Ee1dJHzaiyHLPOkRxlFHma4?=
 =?iso-8859-1?Q?OX486RUiMdbwEUSH+5nzA2CJC4mbbvp5vN5+i5VKfZqpdh0elCB3TOOBCq?=
 =?iso-8859-1?Q?aqQRIMYVKVV9sX/o49DIjKdDnMVJRnKPO3jRdj4PdUgBcYPRxJVuWte8Ec?=
 =?iso-8859-1?Q?8uj9dqfUAnph/wwJQM42NTQC1XD4/R+K10avpybYZH6Mfj242+mSPsnnWS?=
 =?iso-8859-1?Q?WnMq8ksjqisDcG0sr9T98comn9KcqKGtQ77vFZ/pLnYoP46zVNyfTBvvUf?=
 =?iso-8859-1?Q?m4QUi97hYlwhwZWNC4LgoCu67FiG9SdQ+xP4Vhem/oIQwIKtoKmqmPdymJ?=
 =?iso-8859-1?Q?LRVXAnNyro9G6LOFj9IQwqfV9mtDV0YPpqFeE8jhTrtU/m40MQo+U3qOKa?=
 =?iso-8859-1?Q?2aHD5rBoaM58tPc9qNl+v5OafVqC6t0Z2VUUM4A7B9eBSsazk9F+WkmDUT?=
 =?iso-8859-1?Q?X9Z7yenaNy4A+ewFgk1cp2RmILIpl2M/dCotj5Cifd38Yb0bYzeHLWpweT?=
 =?iso-8859-1?Q?jJ0djPpMKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b70932-e179-4408-9a0c-08de7a685a1b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:36:14.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdaVf4QRLrQMR6B1DMaof1W8kLCJ4ivnO7q5ygBG3qKi8px5Z/AiElKPOwrRtJ6PMBzOrSCsASr4Gv768JQGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8541
X-Rspamd-Queue-Id: 0A6D520A9D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9262-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.283];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,weissschuh.net:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:44:40PM +0100, Thomas Weiﬂschuh wrote:
> The ioat_sysfs_entry structures are never modified, mark them as
> read-only.

Nit: if there are chance to respin it, s/read-only/const/

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/ioat/sysfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index da616365fef5..e796ddb5383f 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -32,7 +32,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>
>  }
> -static struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> +static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
>
>  static ssize_t version_show(struct dma_chan *c, char *page)
>  {
> @@ -42,15 +42,15 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	return sprintf(page, "%d.%d\n",
>  		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
> -static struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
> +static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>
>  static ssize_t
>  ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
>  {
> -	struct ioat_sysfs_entry *entry;
> +	const struct ioat_sysfs_entry *entry;
>  	struct ioatdma_chan *ioat_chan;
>
> -	entry = container_of(attr, struct ioat_sysfs_entry, attr);
> +	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
>  	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
>
>  	if (!entry->show)
> @@ -62,10 +62,10 @@ static ssize_t
>  ioat_attr_store(struct kobject *kobj, struct attribute *attr,
>  const char *page, size_t count)
>  {
> -	struct ioat_sysfs_entry *entry;
> +	const struct ioat_sysfs_entry *entry;
>  	struct ioatdma_chan *ioat_chan;
>
> -	entry = container_of(attr, struct ioat_sysfs_entry, attr);
> +	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
>  	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
>
>  	if (!entry->store)
> @@ -120,7 +120,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
>
>  	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
>  }
> -static struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
> +static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
>
>  static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  {
> @@ -129,7 +129,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  	/* ...taken outside the lock, no need to be precise */
>  	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
>  }
> -static struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
> +static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
>
>  static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
>  {
> @@ -154,9 +154,9 @@ size_t count)
>  	return count;
>  }
>
> -static struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
> +static const struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
>
> -static struct attribute *ioat_attrs[] = {
> +static const struct attribute *const ioat_attrs[] = {
>  	&ring_size_attr.attr,
>  	&ring_active_attr.attr,
>  	&ioat_cap_attr.attr,
>
> --
> 2.53.0
>

