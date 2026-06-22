Return-Path: <dmaengine+bounces-11715-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3DqAM/SOGqSigcAu9opvQ
	(envelope-from <dmaengine+bounces-11715-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 08:14:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAACD6ACE86
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 08:14:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=valinux.co.jp header.s=selector1 header.b=dXg9DxuJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11715-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11715-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=valinux.co.jp (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 503F3300231A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5E23BCED;
	Mon, 22 Jun 2026 06:14:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021072.outbound.protection.outlook.com [40.107.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855D35DA5D
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 06:14:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108874; cv=fail; b=H3SGRJWBccLgjYja3tnWJao73lXff9P5u5AamRm4UpTkH8CUQj1C1gIoY2lnt3cOeaVQK+H+x4FM0zAu56PCbB/Tyw70xY4mSPqKYOh0lJ1IyYAEOeBJU6+mkl+AHQt2h2Fp5HLerypirc7oJorxL+Pyv8vAifS27FcBcKkVhVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108874; c=relaxed/simple;
	bh=mP8gTxcgt4t60ocoswEuP9mwtlp03VAYPmx1KKMUG/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hie7M3PXCGhqO49meWeFrMdJ2A2mDfd0YP9OXZPy1dYvOfBuF8/iTszUMlqe0QjNY7PEPyoCXZl9FQObO92CZTX77OnrMUbznLyyn4VgA92RvDdcDh1vY9W5Zwhji2iXIpGmJ/arWa/DxfoUTUIzhpqdcJw9gC8gbcJay4wDZ88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dXg9DxuJ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6pFRCpACGaxDLo6V9lbFYmNVIJo5jfemFJokepteDkx74pnVEU4h5DGVCf6PV6VgJZURTEx+PZ9iKc7gfLd93+UBtm9Z9Lv10Dq/y40EnrWrf3BEflxlT8BG4zKAZ4pCqnLl8S1sAOqH2MzY4DTfs8nvH9i93/G0Qtemxvqrzm9Ls/bCPprSefM8IWgL7AwMgn3huXEJWmjV6RW3UCmVXGfR6bCUBIPEKGX/cUBsDeU7WjR1QrLu6Wo6gDQXaNmv+YvIEfRGOUBtucZsrZM8p2MlzW33zB0eCplsjmUKHUfDriAxXAbeshkgRneLdzCQxusB/mXWp5m52bGI5Ryyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cNyVjRTgvI3m4enVWrrClrtlR9VwLkJB+S5KKZP5+M=;
 b=ywxpnRq3uxzB1rnNsk9AHiHsqz2F7QuWXQIZh5aCAVYPEOGRKc2WLG5K/8ur1C0JUMFOVSf88OoJsmIafN0xIO+p05+CiZ5sxTOQ5vSrMCsmMK1fwOYKbA91We4oddi+KkzIghXJhwK/DnM4egCm+Sz89BJzKNXLhrCjRhntR+iNvtTQaxJndhXsX3GhzsznhvLT2QGC1oKzrW09t0WXoujRv5E0NhYjv4u05DVUX5xGuD5/QwP8kG5hbIydAA4BeSV0shgGNWtM7fQuUPox90OOCDUoN5Znej1pBCY6x2JnZQU9R9fBQzb6c5b+93DWXiCExSB+EBE0ixzBBWQ9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cNyVjRTgvI3m4enVWrrClrtlR9VwLkJB+S5KKZP5+M=;
 b=dXg9DxuJb/V+7pATsbbfFnhBHK4Tryro2MbTLCBhtlA6tTiaqFqW9uuEX5GWJMzy+PgtHixH9WzjbH+6bIkA+EbqRKWwArndbMSGbisgWlUh7qJ2wOaA7aqHfSGOa7ekEg3h81PUzMvTnGUNWS/3kLJttziYnFJjQfprAv4BFbk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3342.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:14:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:14:28 +0000
Date: Mon, 22 Jun 2026 15:14:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v3 05/13] dmaengine: dw-edma: Add partial channel
 ownership mode
Message-ID: <ghjc2vshv6xiuxkweo6sedbm4nrxdrmz7fsz54hki4riyq73cg@d2aai5sakulr>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-6-den@valinux.co.jp>
 <20260620171603.DA6211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620171603.DA6211F000E9@smtp.kernel.org>
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b712ebc-f0c1-4a89-9354-08ded025840b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|6133799003|18002099003|22082099003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	e10jVbWRlpniDmQn6YlyxxIYD0nw+JkVaEEc8Cgkn/2lbGtej+s0jyCUVX9Sqb7zi9m76JsDMDPR7zgBb7VYlRFijYXAamTQTYJeAHjV/i6Uk6Clh1umCpqDeKTjIWQHuA+qJRzSJv1LB42EBu9CrHxuACVvs5p38DSzK3i+GrU8R4iJ8ULHHi7uXadI5I7Hqds3Ex0o8nSXgSmH8r7mnjO5Sl2IlTGQ6+zhyDp9bMaMrlVC3lyrmGz+lxfaxbcbVId8wZIAq+g/Db/mVNZvS4bSgNf7EfnejUxe5lf4JsL9+g7IpGKggnLTggdPmcbk519mLirgSy7GMX0iEHsZ0c2f1xpfy2sKs+2wL2hC3zbWNk1GxpFpYoBNI8aupadu1CDBuf5cpIxFI3akB1B6LN23YFTfIs2IcPqc6c5ZgryGPqA2K9PB7FfYAhvwf+wQ8BER3g2O8S33h7prR59gYmkfiNLlbNsDEdHDpHUzP+IXOEjn1qBzOpDj4HPqEWglZobbCCeir4TPnPYX9ZhLb1QsPFwiwqpQUrzIN/XZROLOq4xtcNcn5hsgnxrJbwiI1/RM2hsfgwhguKUTPSAnFC95oEvlVnWE1tRqRdgJ0Bg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uIz9FW+2WQF2SbGX3vaCVQX319qZyz7TqwupaZ9p3VkxOJwLRaYF9RQqvZ?=
 =?iso-8859-1?Q?Es/FXsQjTRIxm2NpweXwvOb0Pr5P9fr99iWwcKC6+plqVun8N8ADb/MraW?=
 =?iso-8859-1?Q?XiR8JPZANrI3xZTfjIoVDh5fDdoiNeHgmI95/2ETyAmSNPi6ax+C+Ez/CR?=
 =?iso-8859-1?Q?08Nmy+GoVu1XiyNGESZYC6SUdm+By+xMSQjerK/M3Pumd+z0ybWnltXg9k?=
 =?iso-8859-1?Q?hmPQDa9+j+NF8narhT1BZWgD5yBTPn8tcSfCCgz/AxWXeaci835VdAU5iC?=
 =?iso-8859-1?Q?kxpfg+sQ/aL6kB9RIEisWnTza7hf0w5S5mCUcLowDvsmyecHYW5+39qqUo?=
 =?iso-8859-1?Q?4ekQDWRt8P9UqVTfhsLkrOSZgXtsHU/JC8LsuNwKp3krH/Ljhb5S8QdhRc?=
 =?iso-8859-1?Q?zuNH7ScSq358DQSnICH86oNHyopaKZBisyxGF6pVs7ELh4rbPd4k8g5ftR?=
 =?iso-8859-1?Q?RkvXciEz/yCPBdlRniAS4e2Et/jVh1m8semunte38my7rgMr2iZ5FStq/q?=
 =?iso-8859-1?Q?cU3dEf0+bORxNoCUC1TNVIR8H+C1aqMy+yW7C1qW556lrQmhWo7N0clNJb?=
 =?iso-8859-1?Q?V5WU/8bHQ5y4tp7Psw5mWh6M0wJUA2B6SwaNSU+Bn6b52fbUq4eWX7TSal?=
 =?iso-8859-1?Q?Mjjap2vdJU2BPyiGrlzfWHhsPsuBFN6hjQ5uCILt0SF0+baeQfp+luK3RC?=
 =?iso-8859-1?Q?4O3qGPVbJ+hhSNUq+a9q7OpqgvJqb7Ow6XCUGs1YE0weBnHPZMTn7OxrM0?=
 =?iso-8859-1?Q?cIcs7GLeRY1TOQT6kcbwmCbWb8/cwxWVpyGpmD9QDQNGU08xR3O39+sUhS?=
 =?iso-8859-1?Q?9mOZmhIPAW4Zl8eNlWLvTyIILk68MbITTAiY5xxP0KoJSvfhVDyDvJRzNG?=
 =?iso-8859-1?Q?baLR6dbK2zlU2l83NV2fdWjIj1hdFP/IbPZmDa6AFlWC3HZ0rsNOzidWuk?=
 =?iso-8859-1?Q?FNj9cxHzPVR/mXliW2s5Jtgw4gID78bf5LVKp27Sl1qCRHOos4CtJFj+TD?=
 =?iso-8859-1?Q?JrQoHdR2ZIsTW0wv+/3pzuiZbSiiknFAEVDl9wR5DI/KHSNgHAZX4uSYdE?=
 =?iso-8859-1?Q?fnJV4ApSElE16bGFb3R6WSs0V+cmc//GGARJTha1ZD8ZsGfnvYBHb16mAa?=
 =?iso-8859-1?Q?Jim2c41KcXBuemz0/KM8hIUSE4dAH32da44G9XDYdfY0GtqsZHoOXr1O5k?=
 =?iso-8859-1?Q?ezFgnYV8OmlFG9cz54NNzlTM58QvGdYUbEG9t0kECcdlIzVNrJQpsBaJo1?=
 =?iso-8859-1?Q?T3PVizsnpbQeIvADjp8krE5lWG79+HhA66sK5QgNeYfnerefQX28MB/4wH?=
 =?iso-8859-1?Q?EzBzPe5A7kaOo4QwHj2lvFwzOgpMulhTvJwKfUUQvHrzHouEgRwSM0nrm7?=
 =?iso-8859-1?Q?A51G13aM07mBe7zwYf2z4dTaBswIOLmvca9ddUJRXp1CLvdzSq/4p80fDj?=
 =?iso-8859-1?Q?eaHylgiDdMknlCkiHn028+x6UccmFlwzcS9zSRvLU/Y7qpRhlMDOu/EFwQ?=
 =?iso-8859-1?Q?0lvM+C1zAu3cZr3fSOejj58oO65HaK1SwPMsmohQeIf27BdEcJxZqOyrM2?=
 =?iso-8859-1?Q?Or1nEPDGg5TIUnBdOkdqpaVrnG0nusfM2gCJTFcVZ+DpaWnbhsqZCCKZwb?=
 =?iso-8859-1?Q?Yf7QMOYXQ22yKKdEjw/OjWTQaErGsOPfa6+xrMsL1A1ujmt2I9tu3ItGG+?=
 =?iso-8859-1?Q?DIVo+Nevp3NuAqw15uyggXqK5tw2dbFWxb6fUESqPm+yKBpQ2QqYhiMO9Z?=
 =?iso-8859-1?Q?6xJ/XJuQbxpztfrvkbYkRgVZD5mTSDUt6k6oKZym9Ra7xXUQ9K7j0uIEJL?=
 =?iso-8859-1?Q?yARVOhevc/ngDZATFptT+JS7MtpzRQEbISTOefWopQhsqh1GFphl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b712ebc-f0c1-4a89-9354-08ded025840b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:14:28.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUnv2uysBYowmNLEQqn8lduD7SR8jfBafkoLhGnFWt+SIHV22H3s27ynVKdrB6EfR+yVOfM/poM7ZgHAjqkwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3342
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11715-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,d2aai5sakulr:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAACD6ACE86

On Sat, Jun 20, 2026 at 05:16:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] In partial ownership mode, `dw_edma_probe()` skips the global core reset but fails to quiesce the DMA channels it owns, exposing the driver to fatal race conditions if the hardware is active from a prior state.

The exact probe-time race described below does not look quite right to me, but
there is a real initialization-order issue here, which I previously mentioned in
another series. In short, my conclusion is that this is more of a pre-existing
issue. More below.

> 
> Pre-existing issues:
> - [High] Teardown order in `dw_edma_remove()` disables hardware and frees IRQs before unregistering the DMA device.

I described two possible approaches ((a) or (b)) here:
https://lore.kernel.org/dmaengine/pmxfqgsjposbv6zehrgitqwvbxppc7cfht4xsxw4l2lcjkojkw@ycqyo72w24ji/

> --
> 
> commit b3810423aa75ab232c8bec54552ca8cb72acd420
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Add partial channel ownership mode
> 
> This commit adds a partial ownership flag to allow a dw-edma instance to
> represent a subset of a controller shared with another OS instance. It skips
> the initial core reset during probe and uses a limited quiesce path during
> remove, while enforcing ownership granularity for shared registers.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c782eaa12021e..d87791205837b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
> > @@ -1128,8 +1156,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
> >  		 dev_name(chip->dev));
> >  
> > -	/* Disable eDMA, only to establish the ideal initial conditions */
> > -	dw_edma_core_off(dw);
> > +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> > +		/* Disable eDMA only when this instance owns the controller. */
> > +		dw_edma_core_off(dw);
> > +	}
> 
> [Severity: High]
> If the instance is in partial ownership mode, could the hardware be
> active from a prior state (e.g. kexec or an endpoint driver)?
> 
> By skipping the global core reset without calling dw_edma_core_quiesce()
> in its place, the hardware remains active. The driver requests IRQs via
> dw_edma_irq_request() just below this, before calling
> dw_edma_channel_setup().

No one can start new transfers on the delegated channels in the window between
request_irq() and dw_edma_channel_setup(). On the RC side, the DMA engine device
has not been registered yet, and the EP-local instance does not submit transfers
on delegated channels.

However, inside dw_edma_channel_setup(), the channel is currently made visible
to the IRQ handler before the virt-dma state is initialized:

  (1) set irq->wr_mask/rd_mask
  (2) initialize the vchan state

So if stale hardware status is already present, for example after kexec or an
unclean handoff from a previous kernel, an interrupt could observe the channel
as visible to the IRQ handler before the virt-dma state is ready.

I previously described the safer ordering here:
https://lore.kernel.org/dmaengine/kjslqii4bs3g4pi22mxh72hxnlm7nkesdd3va6zi5fhmjamerw@j7lbrlq5oszd/
"(1-a) -> (2-a) -> (1-b) -> (2-b)".

I believe the same idea can apply here.

The kexec case itself is still broader than this small ordering fix. If a
previous kernel leaves an active transfer behind and the new kernel probes the
same partial-owned instance again, skipping dw_edma_core_off() means the new
kernel intentionally does not reset the whole DMA controller. That can be
dangerous, but it sounds like a broader handoff/teardown issue rather than
something this series should fully solve.

Best regards,
Koichiro

> 
> If a pending interrupt fires during this window, the handler will invoke
> dw_edma_done_interrupt(), which locks and dereferences uninitialized
> vchan structures:
> 
> dw_edma_interrupt_write()
>   dw_edma_done_interrupt()
>     spin_lock_irqsave(&chan->vc.lock, flags)
>     vchan_next_desc()
> 
> Since vchan_init() has not been called yet during dw_edma_channel_setup(),
> does this sequence lead to a kernel panic or NULL pointer dereference?
> 
> >  
> >  	/* Request IRQs */
> >  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> [ ... ]
> > @@ -1173,8 +1203,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  	if (!dw)
> >  		return -ENODEV;
> >  
> > -	/* Disable eDMA */
> > -	dw_edma_core_off(dw);
> > +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> > +		dw_edma_core_quiesce(dw);
> > +	else
> > +		dw_edma_core_off(dw);
> >  
> >  	/* Free irqs */
> >  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> >  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> >  	dw_edma_emul_irq_free(dw);
> >  
> >  	/* Deregister eDMA device */
> >  	dma_async_device_unregister(&dw->dma);
> 
> [Severity: High]
> This is a pre-existing issue, but does the teardown order in
> dw_edma_remove() expose the driver to a race condition?
> 
> The hardware is disabled or quiesced and the IRQs are freed before
> dma_async_device_unregister() is called. By leaving the dmaengine device
> registered during this teardown, clients can still issue new transfers via
> vchan_issue_pending().
> 
> This would invoke dw_edma_v0_core_start(), writing to registers of a
> disabled DMA engine, potentially racing with dw_edma_core_quiesce().
> Additionally, transfers submitted after free_irq() will hang indefinitely
> since completion interrupts are no longer available.
> 
> Should dma_async_device_unregister() be called before tearing down the
> underlying hardware and interrupts?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260620170040.3756043-1-den@valinux.co.jp?part=5

