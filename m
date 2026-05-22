Return-Path: <dmaengine+bounces-10721-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLmrCYMYEGoITgYAu9opvQ
	(envelope-from <dmaengine+bounces-10721-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:49:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152F5B0B86
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 453DF3018423
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B53A3834;
	Fri, 22 May 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HNeEnmg5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021106.outbound.protection.outlook.com [40.107.74.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA08346777
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439743; cv=fail; b=DSwUW92Sp4jsX+6GunRMTeqGaLJYxhXnGEI1Q9M5XCicP3OpKhb3sqIP5HeluK83ReqskQopahF6vNqM3WGSdwLL3If+rytBoZyIeVg8mDyGsncGq3Yesm5X76DT9/KuZHbehweEBGg+7bFUzQuQWiT0xEBLDgG0G3FVgxI8a/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439743; c=relaxed/simple;
	bh=rG6R5m3LNFOa+RLbnl4naWwbL7SfhWBUpewEykulS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DrA8Oq5Z9hHOIuEzPkC/XVey2D5bzJtt6aGgj0xEn4gf2fmWoQEMhcIGZMm41AA0nI+kYSId65UFFlmQmrKbid8tnzLdRxFJrf3LgY+NKjsdeq9Qq3LkWqWm8NuKRUG7V3ewoh51MBTgYAf5Q5luMGOR+TMzgUCaU4P6IJksdIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HNeEnmg5 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuuer6NA2QB/dqjT5OuKyda6I2s7k/tFvqtsxtqBZ6LElEVGEIFXeu4kluoBHqiDkJHaJCz50WIq2x6Wai8yqNz5kUKdAoyMf0L/yypT/E/qiKywpFyRqqW6RClQXPbtotrz9OZJX1/jpz8QgZr6poCY2gGgErkJ0I58ZahDcBVQvArcOmVGRDQvbIOqa2aKVMuOiYddxjblcuniRIUSow0BSDc2N2zAnddY36PONCepQXHz3cdIcTd/itT4nHXpxqisru4SVGvhT87kH2iwpOhbUyOzPn8lCPpICi6N7kIi9YhHoxDQu+Nu3XHkb8EWrXFGZwpSgp/FeEH/dK18GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRqpOCbaZxf/wbF7AwZYG2cmyDppWqwIw2WB6XvyMmU=;
 b=nx67pJ9nZZxi7BZVU/Oeu2LO4r26iTTV75irFK+X3pRUYgUkD54BMSG/Iwh0FjIY3VG5PeqXrUJH3dHxA2jnMh8ossbsbOWUTwNtX9Z8OZFbF5eroxGWdgaAG1dBIMc3PyxXdbi03G99KeyPTqGlzRwOabgrigNyUWPk8xgbdVUL8qO9HzffGJ8tCViGW88FtBGn62BpoFG9ws/feGeCHBj9VAeJjwg5aPJfym9Xzd0DG1Lree4C0DTOq/bXWkeAeWwQGk9h8QBI855EbgsWnB2kNsxmVFjVxHeAgkdrqX9yKV6GA8l5IQ2WjtQf2Il3ZnDcU3STCx/9ZDinf2jd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqpOCbaZxf/wbF7AwZYG2cmyDppWqwIw2WB6XvyMmU=;
 b=HNeEnmg5pLXBTBy/FNd0vulL6KlTvgdcuhq/73KMfpL85bHv6d41fsQLf4+q9eNwele2Ug6fN41atlIQMONlV3gQf30WoFtYIsKSNne2VWpUB9FlMBKGFgANZLZjNVAUYlyrRO84QCLNj6nKf722AIDDGFf81CVOYQnzliMo00c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3272.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:48:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 08:48:58 +0000
Date: Fri, 22 May 2026 17:48:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH 2/4] dmaengine: dw-edma-pcie: Reject devices without
 driver data
Message-ID: <a6gnzihfbl6ai4f3xzykx3ppidkihzicofp7flyh27lgsjepom@p5mjzhy7atq6>
References: <20260521142153.2957432-3-den@valinux.co.jp>
 <20260521151504.69BA61F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521151504.69BA61F00A3D@smtp.kernel.org>
X-ClientProxiedBy: TY4PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3272:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e842e32-c422-48cc-d1ec-08deb7def6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|18002099003|22082099003|56012099003|5023799004|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	flelqY7MuqN7dh4kcMNJ4WcxLZ8iJmupFLOzBHJKFYRAwIE5a63WiJEduaedZ8JSHf4pphdYS6dqSGhrKEhATKmCJQqKRQhnQwC8epPf3DiokhAoeRQR5zKXY9IbCCCG8ykVREEhlK3hcF0jAinFvELCaAX9ttI7dkc7XQL2CmjevUav22n52mkHgSyv/E8uYBRqIpcTxFsMEkdJs4KZP9Amz2wZ6Wb8bQjfYcwb7b0Vc5cU2YIqc1ym+kImxWGaBtZRWm2Bh74mFYSA/vNkCxdyVYFGgl2TklFyawLFVMP2VLzZcRfpV5xwNtaM813ZhobaV9L6Sqsu0eVGBUD5apqwbMbIjKYeQsUOOf0vLPcX91FbVcXocByU8W74xcGam/2V0ztNlyVaTwU5W2kzbYEx8vO2Kt9On1Mv2tycncWrIwBfZbXGR5J+3PmhDgr6OAzUFylALWEVXigYp8gWqczmpIcqckcL8/gQmLVQs6Ddku+xUHLPHU4QVzOYoeQgkdYrIP0B7uGBK1HmQa09+x1NhlvFJwHUcTpoDo4Ov3QnCaFew4Itd22SRctW4nZcl/3Ctc6tD3pA57qr63/SZa+yqvHawNKKw6aWAyYnnm11dx2zT16MhYDMrZtdnWp55l7iQmvaFBk2uNBcWcrhsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(5023799004)(6133799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?TvRovMc48cW+Lq/Cj89E34znFxj6ixYXus+RqtYMg0Ez2U0oFGD8Wti3ru?=
 =?iso-8859-1?Q?hLnoHqJ/+Bb07Apclq6CVq0OEA/m6kVoH15p64mCVJB8SxCYLM9cAlUX1u?=
 =?iso-8859-1?Q?9FlmmPBzvu9hq7ZtczoA5dD0PeB7auuyTHTxg0sp9ePvxff6MVpKPtUv2K?=
 =?iso-8859-1?Q?guvRVTB/ifNNv/KXWNm5hNc0xGudvPXfQh8duahD/tP2q8POpiXjSzJyfQ?=
 =?iso-8859-1?Q?Hk47STbMbqD7m6gfJdrbxJRrcgWedVHYBehnzoPaixLM9njKVxNOPT6vRl?=
 =?iso-8859-1?Q?nAsMENBt4WzGW+PbwtOk/ut5qtvfpUL0byiHmXvMLTL+cgQGHMhXabX3eX?=
 =?iso-8859-1?Q?x5sYUMzCok+YheXC1bzot0Y8OLc2KWAyLg4mwadbjy3v+kfRHaNDPqfcm8?=
 =?iso-8859-1?Q?oJy4itIuZViBp4ATCbcQDe47Z8pIc8LhleBsUyBKakDstlKDHShNUAQcEt?=
 =?iso-8859-1?Q?f2UBs/CC06YlkmCzD3BK6f3aEUoh3hCBL4nPo0t5fHyafv4KAABpa02Yxe?=
 =?iso-8859-1?Q?B2bkUy2yESkQ1UNyYx+szmYgIYSNSR+jKuWJDszu3jPuFoZ/22AMe2nwim?=
 =?iso-8859-1?Q?VTc5xlHU7Dqnare5aT29QDVuld6EeXUMYvRdpTreJA/fYVhoaSLd05+d7z?=
 =?iso-8859-1?Q?hPZYgpJS4kcKjFpnRsbFTmuyKckSZGFtwbDz0W2DiRAamXP+KKYUMBdYAx?=
 =?iso-8859-1?Q?WvewPCjCndZHV3L2PglYjHGMFk9R+TJYIAiOD4+bkj0f5pXfoxFmVROp/g?=
 =?iso-8859-1?Q?aSFr0kZwHIKlbZI3Aq11/l2Uuf9KHc7FZUMFyMZPbs30uwZ9RnaDIMcD8B?=
 =?iso-8859-1?Q?Sx9EhRje29gy1Jze+bXySvkmwhFF1a4yF23nUTDFr6KeifEPQAirGkO6zL?=
 =?iso-8859-1?Q?bLffKBC1vh8UESE9m4NKVoAiMipRbtRsTtM/dSzaSbIVMcYxw6k6cNywIV?=
 =?iso-8859-1?Q?G9JpgvcyCaX8+3KVECZBoDFn6cI/sFFkGIYqwHBAZm0xPLpHxsOe8l6S4A?=
 =?iso-8859-1?Q?lKcV+sl4FdyTrwdTC36v/+BbXiNASUzjVyNu2Kr+J6is4vjnvfl7JX/opf?=
 =?iso-8859-1?Q?oE5yWwLZ+tym7iluzBqUt+5nVJlveTs3TntANPLknx9i3awYzGnnd94IF3?=
 =?iso-8859-1?Q?8FhJaDkJ+FpCT4ssqtMKsS+FSf3U1gSq1/v1sNjhiUCJqvxiP1kbgnDa78?=
 =?iso-8859-1?Q?mUEWYz11+mBfSTaU4xwtDAeTu5DELD+OFwVnKyqjj8polnSBVAOBBkcWeE?=
 =?iso-8859-1?Q?d0Rb5Nz6rkuVI/bg2iYhSscLt23Ude57ymLBf9Q4mqVCE+SUGvkpEfgr0T?=
 =?iso-8859-1?Q?pW6ge2FxG460PZ5sdK+RzEprfpomZAl7a6Q5XemTp6ESKafRIWNG85738f?=
 =?iso-8859-1?Q?rjws2x1Lu1Rle+bxKsdAS9ZGQhFxcSD3v0DkNtaiLMMiUhaGT/aTBLZiOZ?=
 =?iso-8859-1?Q?itA2uT8ZS8ON1zvK5ClmhvWYJ+9ADZCPPIEV7ItjHoKy25y3nKN4uBfK2Z?=
 =?iso-8859-1?Q?hzyF0UHotaxmqAdCrNYmpUC1ot3Mnu6fl62D7j/Q/A0Lz8KiBr+dTwk7UA?=
 =?iso-8859-1?Q?bmFkNDnElcf8mlnOUXS0a7cGfTFpLFJQ8/dKOSL/KT29EgTgEHCcu/zoAQ?=
 =?iso-8859-1?Q?ZYeC19ykvKDnS7i9yhKbsa5edy+O5y6JS6Sj5rjHKknlJFFNAoZWZmANLK?=
 =?iso-8859-1?Q?f7RGQyhwhJwfenXfMcCuaTAHVdV6hfzH8Z2aP6pt1zrsaoDG8No7zvDBLj?=
 =?iso-8859-1?Q?ktt+wmZ9kIzZdgqNlbFVd93hKazJRkJWRr0KNrzIfGqQ0uu8j/nvBidnlu?=
 =?iso-8859-1?Q?5Diz9WjINRNqQh4NPDu4fxXtIcutZudhwEyagCH77l6gZwaPDQeh?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e842e32-c422-48cc-d1ec-08deb7def6bf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:48:58.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOc8wip0iZ2Rt7iHi3gqYFvtDPDPAmiSWnUs7sM4Z5X8l9RbwYUUUqrlzc5QG4RrtvTU9yl55ItXKlIxXFHvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3272
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10721-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9152F5B0B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:15:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Mixing goto-based error handling with scope-based cleanup (__free) in the same function.

This should be gone after dropping patch 1.

See:
https://lore.kernel.org/dmaengine/xcrbweipase44isv6lfrgqos4mrfhc7o3v4f3lzlovekvsubim@yoz4kfxhka33/

> 
> Pre-existing issues:
> - [High] Missing bounds check for the hardware-provided BAR index when accessing the `pcim_iomap_table()` array.

I do not think the exact OOB concern (See (A) below) is correct since commit
f09d3937d400 ("PCI: Fix wrong length of devres array") (v6.15+). But I agree
that the VSEC-provided BAR fields might be worth validating against
PCI_STD_NUM_BARS.

> --
> 
> commit 451669b3f83e6d7ef131e591fd15b9e144ab9005
> Author: Koichiro Den <den@valinux.co.jp>
> Subject: dmaengine: dw-edma-pcie: Reject devices without driver data
> 
> This commit adds a check to reject devices without driver data during
> dw_edma_pcie_probe. This prevents a NULL pointer dereference when a device
> bound dynamically via sysfs matches the driver without that data.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 87c31d01fb102..c2024fa824e03 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -314,6 +314,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	int i, mask;
> >  	bool non_ll = false;
> >  
> > +	if (!pdata)
> > +		return -ENODEV;
> > +
> >  	struct dw_edma_pcie_data *vsec_data __free(kfree) =
> >  		kmalloc_obj(*vsec_data);
> 
> [Severity: Medium]
> The kernel's cleanup subsystem guidelines state that goto-based error
> handling and scope-based cleanup should not be mixed in the same function.
> 
> Since dw_edma_pcie_probe() uses goto-based cleanup labels on failure paths
> like goto err_free_irq_vectors, could mixing them with the __free attribute
> here lead to confusing ownership semantics or resource tracking bugs?
> 
> Would it be better to either convert all cleanups in this function to
> scope-based guards, or avoid using the __free attribute entirely?
> 
> [ ... ]
> 
> >  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> >  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> >  
> >  	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> 
> [Severity: High]
> This is a pre-existing issue, but does this code properly validate the
> hardware-provided BAR index before using it as an array index?
> 
> The value for vsec_data->rg.bar is extracted from the PCIe VSEC
> capabilities, which can yield values up to 7. However,
> pcim_iomap_table(pdev) returns a pointer to an array of size
> PCI_STD_NUM_BARS, which is 6.
  ^^^^^^^^^^^^^^^^
          '--- (A)
> 
> If a misconfigured or malicious device provides a BAR index of 6 or 7,
> could accessing this array result in an out-of-bounds memory read and
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^
                                                      '--- (A)

Best regards,
Koichiro

> crash the kernel when the resulting invalid pointer is dereferenced?
> 
> >  	if (!chip->reg_base) {
> >  		err = -ENOMEM;
> >  		goto err_free_irq_vectors;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260521142153.2957432-1-den@valinux.co.jp?part=2

