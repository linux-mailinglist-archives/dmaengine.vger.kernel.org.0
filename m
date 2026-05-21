Return-Path: <dmaengine+bounces-10675-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAHEOgs1D2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10675-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:38:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207085A96C9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 148B832BAC9E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A162D9EE7;
	Thu, 21 May 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OceG096B"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4723BCEE;
	Thu, 21 May 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376191; cv=fail; b=DpTbaXfd12qLpPcHTbBnwyg9juKuxmvylietYRfCVUh2rJoeOj9FaC9acjHMGsjC+NBVcw5mhisWVSq2tK900fFmwVMLOv+LAgXYbZVawqK1ZB41YBLz0mINznxpyyY2dBLbwRXciVMh33PwnPqX3JQ/fdQ1eVRncndDT5Yc4YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376191; c=relaxed/simple;
	bh=bQr3Qs1oEPWgB07BAPKj+P223LzCyaVeE5m7PxiyJMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ByP+EMTlK97mB2M/Bjfmq2TVDcZrltiZi0Lhp/PkQBi1FsMB8gBHdhIpciSmXi8tG1xwk8D2pbn/gRJEQCFJ7xtuCBZbLfmrBsEeMiO+MqyFbI0sOkmAZYKdNyIPiH4biS8qyDbcFncw2dYoYXOY8VDm0i9QWKgwGqct7PmFweI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OceG096B reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDdtpOaZ0iQp0SF1oLSnTiK+GW4bITXCeHeIAzI1Pze8+Yqw28+7KGXqooiTPDDTtTdQG+h/GyJdsna78E9ny/dqGK4UZc+HgBzjVH4rk1utHz7K3TcWyE1oGOb8V3yJjwzUfpg1+bI/bMqRMov/cSthO1j0CnM1rsRgEj8rDlGpcWmWTBHSS3CyqaYGHG1e0ur/LkLqVIU87cC7oMJOPflQ1bRLYTiwW7NG1ftBIGaghQxviEHPe+SG4CwO+uDwQlXDyNa+UBlo/9S8goHBBVR6ZU0f8yzHD6asJaamR5JlEzQuEQ591iwii2xHFMtvEh/Wcu/5B1WJsmzktcHPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXBrKTMmbXho+gwjVaUsAooKcV+iR0mxplU6oeZOXaE=;
 b=P6hfvfzRrzAtC49MoakyqKSnx3or3anSpzXxWFmZDXSltDBfL6gwH76kG6URFU5+CGEOoxZUmPAwhJ/6Z4ykakGiobJO4P5ZeZFXrNEcdSvsoG1G7DtAAZ322AsaKI03mzleOuJ7weNEcNdnHlqIyL8MUuw+p4VcP0/oaMAC7VJ1nm5FtH4+xaLvn3TJmakxgx3+jAI0ILMtCGMJaolRUVkjS1hnzVCANpWmJcYvgPHtSRCV0vulMjZhp9TlOk9o5Rlld5w9TjVaO2X0A7XqA29VC/OixAXGhqz4+ObB3h39nWsaXR8m8ditBRQOlzz1nvl8BDoW4TmStGKVudNDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXBrKTMmbXho+gwjVaUsAooKcV+iR0mxplU6oeZOXaE=;
 b=OceG096BENdBMqS9+RYdzY3FD9p7Yzcax1oMIdLRNs/gnLaY1wIxV9w7UDrGGvQP6f/qFpVI83ygKXuhuTeHmRrM++1FaC7HDT/sryCo3tmA9lJlwI7i9NZu+wmequmD83v4HDXxByF6cVIOgC+oOJtpfcLgNHChp50nWcF5tcxDp/J2q/XMo1BTu5cTh7nGpv/gLJ08UgzJXwQfrIpskv5M6p6LOcln8qFXzL+H3ipjnukZKvZD6PwRAKXW2lQBO80Qm9rKgZPg6vm7BvtJUXNIB4bzd9cGwRe6a+WZKZoBbAhHTFXhs3G0/gUULO31A0wupPHbZKjZAfZ7NM2Jcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:09:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:09:46 +0000
Date: Thu, 21 May 2026 11:09:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
	vkoul@kernel.org
Subject: Re: [PATCH v6 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single()
 to simplify code
Message-ID: <ag8gM8GHnBxeHamT@lizhi-Precision-Tower-5810>
References: <20260520-dma_prep_config-v6-8-06e49b7acb38@nxp.com>
 <20260521020814.53ACC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521020814.53ACC1F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH7PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:510:33d::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU0PR04MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd8bb7e-c975-4e0e-8b8d-08deb74afea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|11063799006|18002099003|56012099003|5023799004|6133799003|22082099003|38350700014|4143699003;
X-Microsoft-Antispam-Message-Info:
	K/KsGA4mxIGpDqNMK7HfpIRDwqeNhnqNTko4W2nJe4a/o6U3Ed5HTV6bZQzhI+q7PD1TUvWxWt4RuX5s10fJnoYME8+IK3QQPIaUMW/4E5dcaW73MgDkQ2USD9LYQq7dEp5J83z97hdcghdDtF6c59dab+AkOviUgP7v8dWTAS+/XWpAGNiTexlfp3Sq0nCXAzfd4pFWhvq/LpGsG6+PngXbr5qxDNMj4txaSw14N0YZi6ZS37OGr9CKiTHniq9SvYz1HyEIqBW4/D8+Ua2bOR92nTsjgzmyRc4W2bfwyVDbhZlDX2viqFBE6TcvUMgQZ/3oF2VtfrWZzB5oJIk6BGS+5Es8L5wu4iEwZ7+S4ulw0JHVVa2pKKGdxFr4mjp3r0Kx27VpeIjXhRaZ9kdnVagjWgIk4rjCbJ1Rv4sD4h3wwuistO1AcMunLnCdjjtFpP76l50ngLg/u3XDn+qXMWMiOWYJQHWWNqnYuJUtDtKtcxjkPVbyASr124WT/05fgZrF7SbH3toum7HD02HHbeI5zpG5BobNa45NtJ/vi4OnKtgdtQq1EEYkII0HQMck8VXwMMMk3cQPEcZJjzIPQMX5U8fTTzvM7amuEgMZKevEXqJ3I348Y7TM3g9S1HdMmU1AjTwl6zw0yL9bxH/CPx6NxAGERHqxKoJ7ZWrGyz8y9kDg3IpVmrneDBl1gnOC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(11063799006)(18002099003)(56012099003)(5023799004)(6133799003)(22082099003)(38350700014)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RZwLLeLPUxhWRDGkSqI5dRoFXjJVoZLO5J3dOBnupizJJO4GcAYKGcccie?=
 =?iso-8859-1?Q?zBWuKe1vJD8tP+Xd6ODCO3cgG+cdjd0xskpX7ZWZtnmAEdb9uRCOGpH4MR?=
 =?iso-8859-1?Q?p+A2rfRh5Gl+a6NMwi6dFn/BosStXs9PNemAzyt1Q8N9Ew7X6WJ4lQ7u5C?=
 =?iso-8859-1?Q?y0qeye6/eeJT9TUO3DqmyK4yEY8XvlMwnWeo4c679oPz0gfZ9Cv9RGfgHe?=
 =?iso-8859-1?Q?W4thO8ErYPq4h0JcTgKVvFVPStfjjUYhSZGPvMnxKBIqxiUJvR2FNkC71D?=
 =?iso-8859-1?Q?5NFkzP2mE3IqZwTaHzZJpR/4spp8Fb5jcOWD6j+ZcHvAtbfGU+kZmUkO7/?=
 =?iso-8859-1?Q?P7h4GJgZzQYJLpeRgPVkD7ICsSdkEjn70jXqrxOw5c2xhDSSLDyLR0oHzX?=
 =?iso-8859-1?Q?rdW99XtkpBa0J+jgBBk8BKnw3YLTP5OTkFbkYnPEbS6/ZzZF2M8ilkmCrK?=
 =?iso-8859-1?Q?2bOVLbEGFimuGH9FjZrUJuJuPpidtlI4eJTvGryZqpDYwbZlUJee1TP2sQ?=
 =?iso-8859-1?Q?rVHrlXP8pG4RnBullBtfVeye5jHYqvYbYXAsNIlGZEseq5BAf0nisYkMrg?=
 =?iso-8859-1?Q?6MYw3HE9WA+kKeNvdYnN2zF4N5WX+DCtQ6whKJQvN9HJOH5fyka0RtGFQ2?=
 =?iso-8859-1?Q?Fgc8sAYAdmFKslikuzC2FoiI9zl5L6a2e7IjK15g6oPVorseewgvS7yxlC?=
 =?iso-8859-1?Q?YQs8SaF9/y76DNMJEndQG517tTDMfGbSmzkuQz4iYdODhieMtppW5DM3py?=
 =?iso-8859-1?Q?Omvfel7ilBk0pGnoNjC/Ch1Hd0UyCQl1NtOf2i5fWTxhSoLNPP+tNec6t/?=
 =?iso-8859-1?Q?CSuOrqknYU8EWPKsNPUFxFucnfNz6giakuOZswCysCL4v4TC4XoPFC960m?=
 =?iso-8859-1?Q?N+KVanGFrCZlz/lxlRVhtHmLsa2LyYNnGL5bbk33ombKzdhG1+RUKNXJon?=
 =?iso-8859-1?Q?QJV0rlr/S/Ho9MuFYoon0ivYQb62fGbgCGnDad6VlPcVleT16ucCyJWTjo?=
 =?iso-8859-1?Q?bNotaDzGpgQsITpwjdkMWq/TmNVd+RylPCJZ0U2Gj9BOkQL0svk5wyeEe5?=
 =?iso-8859-1?Q?VUVEhHGwr9Z4pxpoNPPU0D3/53ZHJ7m83xGSkqGINHPDfxcp8mSqArMBzq?=
 =?iso-8859-1?Q?KT2bIDY1jQ+wRIw5Kgll1okTWTq5t6+QlEWQT1W92TSeXDj+tiH1NDiVbD?=
 =?iso-8859-1?Q?VSIUUk9DyHh4V4G1wEneNwkdLsB5aji9HUlTcgWfp2rTNV98tK1OprSW+X?=
 =?iso-8859-1?Q?sNoiGKUEk983zcoKCBQAEoT883ZEyjx+myXqGsmh4AhqQ6ykETP9+9BooZ?=
 =?iso-8859-1?Q?oT75meXlvkenJMPcArb1yY5OgpsnTuxNND5/PwqWGz6h5AiKJ3SpmGHqZS?=
 =?iso-8859-1?Q?guJ0sPObT+MtB2FYocrstHoGm1p2KC3La+k9TOIAUG9TtWDIJhcpmUREpu?=
 =?iso-8859-1?Q?TMBjZVQe2OoOYEC4k0O9pksPFYg81JbCsuchS/bUHZfI4HpMTMytt+enFr?=
 =?iso-8859-1?Q?w2gbyqn3DqNEN9D24z7TmIuHOSWXoHsmSido01wbd/MRc54nSI6cYbtrlG?=
 =?iso-8859-1?Q?dP520DBCuPH9kJ7fW5WRoq6/bRPrh8ANrnOj1P0Z2UXugCW9xyvkN4pAcZ?=
 =?iso-8859-1?Q?uEKf7QH8bZ4i3ZsL81JMqJFHsHKHbHaoAAOE4+QI89NtLcHlz557M3np2s?=
 =?iso-8859-1?Q?n5gjXxtvt/Uo9+TWxtg+kjqrgNovX1o6wor1uwMNFca57BWYpM7eTeNF/z?=
 =?iso-8859-1?Q?9VifwLfTN1nwz1lO6fjrwgsKr9SGovBCBa4Cpu01DEnJj7TaLOwzq19vf2?=
 =?iso-8859-1?Q?Gtu3W9ir2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd8bb7e-c975-4e0e-8b8d-08deb74afea0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:09:46.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgULgcdUxJqDn6oGSh1/ZmW4M2qVtEbzo36rkYU25w7KDb8Uqfz2TEOfkI/KJ5waScaVFuDWK1Wgm7Kmxnvx0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10675-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 207085A96C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:08:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The DMA workqueue is destroyed before pending DMA transfers are explicitly terminated, which can lead to a Use-After-Free if a DMA callback executes late.
> --
>
> commit 01fd36b3138418658a89651874d85c30619199e8
> Author: Frank Li <Frank.Li@nxp.com>
>
> PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
>
> This commit replaces dmaengine_slave_config() and dmaengine_prep_slave_single()
> with a single call to dmaengine_prep_config_single() in the EDMA read and write
> paths. The change aims to simplify the code without introducing any functional
> differences.
>
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 7f5326925ed54..c3e3b58fb86cd 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> [ ... ]
> > @@ -506,12 +496,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
> >  	config.direction = DMA_DEV_TO_MEM;
> >  	config.src_addr = buf_info->host_addr;
> >
> > -	ret = dmaengine_slave_config(chan, &config);
> > -	if (ret) {
> > -		dev_err(dev, "Failed to configure DMA channel\n");
> > -		goto err_unlock;
> > -	}
> > -
> >  	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> >  				  DMA_FROM_DEVICE);
> >  	ret = dma_mapping_error(dma_dev, dst_addr);
> > @@ -520,9 +504,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
> >  		goto err_unlock;
> >  	}
> >
> > -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> > -					   DMA_DEV_TO_MEM,
> > -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> > +	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> > +					    DMA_DEV_TO_MEM,
> > +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> > +					    &config);
>
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem with how these
> asynchronous DMA transfers are cleaned up.

This is not this patch problem.

Frank

>
> In pci_epf_mhi_dma_deinit(), the DMA workqueue is destroyed before pending DMA
> transfers are explicitly terminated:
>
> static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
> {
> 	destroy_workqueue(epf_mhi->dma_wq);
> 	dma_release_channel(epf_mhi->dma_chan_tx);
> 	dma_release_channel(epf_mhi->dma_chan_rx);
> 	...
> }
>
> Does this sequence lead to a use-after-free if a DMA callback executes late?
>
> If a transfer is physically still running in the DMA engine hardware when the
> deinitialization begins, destroy_workqueue() will flush existing queued work
> but cannot stop the hardware itself.
>
> If the hardware completes the transfer a moment later, the DMA engine
> interrupt will fire and invoke pci_epf_mhi_dma_async_callback(), which
> blindly calls queue_work(epf_mhi->dma_wq, ...).
>
> Should dmaengine_terminate_sync() be called to abort pending asynchronous
> DMA transfers on all active channels before destroying the workqueue?
>
> >  	if (!desc) {
> >  		dev_err(dev, "Failed to prepare DMA\n");
> >  		ret = -EIO;
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com?part=8

