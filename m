Return-Path: <dmaengine+bounces-11180-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBuOBWc4ImrnTwEAu9opvQ
	(envelope-from <dmaengine+bounces-11180-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:45:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C3644BBA
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:45:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=puh4Xeeo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11180-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11180-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0149D300E25C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 02:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0BE1C84A6;
	Fri,  5 Jun 2026 02:42:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021123.outbound.protection.outlook.com [52.101.125.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD133B38AF;
	Fri,  5 Jun 2026 02:42:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627366; cv=fail; b=BlL7XFmTzmdNqgJaOkTvxezXN56ULFTGeoWCUpY1KJY5lcFbegA/LcajadC/Z4HMgyi1F85obQJ2fhIKKwQGnWanHMvWsUvtgHItVI9+r7SBmPkYXJqVFixcj+FIlNqU8JPXR8mNNgMCjvd9hy9fNUiohH0tGbgJvzFUCnUKRGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627366; c=relaxed/simple;
	bh=uvRmIwgT+6xmd6zpNo79y9o1TmZw4kfSNAmviHFOV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AU+ibEeuOxw9e18N5pu1K6wiDVMbfHxmsVK9qMGZ3sCmic7IMuF2nwr+qfpiQ+NtbaFrbwTUg5AUBufWUzIKczOzHdgVY9RPlLGxaWEi+fhiyx6fLFhZzfoZv4wIwyUi+N2yFPgkgRNIMAeG48HDcjffJyvkG7genvNL0kWU3fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=puh4Xeeo; arc=fail smtp.client-ip=52.101.125.123
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVAnwA7cuIfuRcBe6gg+G1T6V5K+cYmGUaLKJ9Q9UMdgzovQKqcIhW3ooOWdNGtsV5699nr3sWT11oNZcXanAMHmhzLxBB51v91+NdGeJqNiTs2+3rJgbhJQpZ4tbKs48LhHuFb3XlhnYKHkD+H2OiY6p+Vipjk2l9h96ZoAdxxp84qAr8KyrDmtuYe0tt7IAcpxbgPRpOnWCo+nAyk16IMD/UPNrD1yGf9Pe8RtL+u0hfvwduxX3GiBYLt2/oVsO4ccb36X1+sY2R2j9wgGcMLmEBMgIagtruEeul2MttLUfO2jXajLCmMhuvs2t8hOBFjCIo7g/GP4h9lY/rSVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIW/Usc2pUakzT7jOOdcBiI/Wa8Ll+yF8wgF485b8DY=;
 b=ogwhv3bWQWVYuoWh2BKAeBQByYTjHurtHQTCKalUV5YfcW8LWG1W1JbNE1ZB3d20T1Ltry3fmWosnQECjWMRMKRT7tiCDzZqBRRnT04iYv2q7XjGBZ6yGB+8wc70981VRPBPMbFS3DhW3Fiq2Z9MVHgUIYBQdJDzJ1QeeDS9ClZrdgHmmRjEc+BW7TqN8YoDQy0kmq9qNleVRs8bcPpUli/b3y02lB+lTpX/MvsLXC/LsGWB5N0sH/JYNBA6gZAnvNH+uTdMpIl7A+K3wr7kk6noyoYVdbJywewiKtWHz2rBo+KgtNDHY4d2oENyasRvPNytFWFKPcwfFpXgQXE/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIW/Usc2pUakzT7jOOdcBiI/Wa8Ll+yF8wgF485b8DY=;
 b=puh4XeeoCSTdF8T/UFjer225wcmGd6zX7HSPDydFLRMW0U3VKETcIdPXpHPEAd7b7/LvFbEs+rGCHOnXk75CxXbsGmB9/qHBbLlvUxLk6HWvh7GIoAFEXIBpZpg0B2xoUVTLYmQRfGuZiwlH5I3LnP3PLO2un/WZh1dCCfXlp/k=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB6154.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 02:42:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:42:36 +0000
Date: Fri, 5 Jun 2026 11:42:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] dmaengine: dw-edma-pcie: Rename vsec_data to
 dma_data
Message-ID: <vgaxp7oalzxjopinwe6oyirujzeahiczanyazj625psep775y4@kwvhjgbyagdw>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-7-den@valinux.co.jp>
 <aiHho-N3u7MmB5uq@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiHho-N3u7MmB5uq@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 093cdbf1-1eed-48c2-ff83-08dec2ac1a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|3023799007|4143699003|56012099006|6133799003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	jUwT65tOw3aIYDNnY6A+4FOaQisZIikrVz9955mtDIRJN/4ASKV7rZ/aDbo4jMHEISRD6je+PE9+2GdbTSXcI8dYFU4ZDAFiDAlLJxDoK5RS9FmlTIsAIfaHRfN2ta0Vu/pFsA8a55tILNJnVoCE1J617sw4H7d34/MLHDkqR+QsSrV4nsOvUrFJGKZ/LBP6qnIomkaXhCI6uyxdAAAyVQtNqRXkwBN2c9ucOpOg7MNCndjcqHSVdNvjzFKDMC5MEk59ji2COAT2lEvf9EPiKI2VPIJLohiGHXQ0TUwpgM2gAnrcQBomghrTWF7xDneHuG4xOqg1s6yIzVsfKF4PedStQkZVS6m8HpxF1yCqirX5QaHvNTCXXcqKWS4d9eWqkBw6NFeArzsoLd9gnbV1agqgHLpy/KspQdK2xvqYKqXzaViEWec7KRgj6wOXzLAUq4SVrxfzg6H8+LJYwfq8jlAhab6i8NtHJfvGHdIQ84eO4T/BwEIz08pNIzLdH7cTCIXCJfg2jN/BcIAJ/FYQllIzp4MFf2ZgVqWpuSlOsYEjYYeYGPJHgpsoCMDpD/OE3uoLD3UY+rFRdP2PSj+WciYHNCZF5nTvub0h7bo78/rfdzKtQhS9tZ7KWYRyktQQtkpZaykho7jdYX/x1I07HpAB2RY7jJnrctsBK/0zGIP+bSvqSThCtXPZhpMCUq+fQhtmbcfSvXknkKzALxvggdVY40k7a5sW3OVUtqdEtDadJ/de0moDQVrRHeQQ9xep
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(3023799007)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w46rxaEuedxp1XJdwuGayMDR4GlLbMLS34Hu6vUommVzcs7+yaM00y7Q0XyM?=
 =?us-ascii?Q?40LK/BWnR/XHnVXLVftB53MS5dR6wO/MO/CRukXee68UiMp8w4/E75dYF5qa?=
 =?us-ascii?Q?Q2SGyN3Qk/qX8YLkLXH6sbnzq87GAnvUZS3PKuJqbllgSqH2OPV259FWnbz+?=
 =?us-ascii?Q?Ff0Bzp5X2BS/hSuasw1GGPZFVyrbfwJTfMhbbic+U0+mJrw/x04Ld/Kl/HC5?=
 =?us-ascii?Q?BS9Re/MURSc6XQn11j1HdEAfHz7K1OQOK11gYhL2Nos9igVL/bVdNBv7Qlcb?=
 =?us-ascii?Q?poZ6dbYmS1BXP9QN3Sq4ASHOZ8qa3UvJBn+UjdPMJ3qJvyEoKj1Xzi59JuMn?=
 =?us-ascii?Q?q9TNvPVVVoZyaEHzGJWBe1JNVEiNbV8XpmeRm+yrldFPTIwzgra0nAocRNn6?=
 =?us-ascii?Q?sYYXsJf9jRTrXN0fPsp00QnxAu8KMFoyQyGFS9RdySYbK87zoTLTDQgUyKuC?=
 =?us-ascii?Q?rOEI3PWTx7sS3qJ2OqO3ZPdUPrs4HqYnFH/WE/ay+twCW07w0GGHQ3S9+YuX?=
 =?us-ascii?Q?Cqeg+IHdwBfgIcmX5ezoikfXUPhVY53xyWYB6P8qv+oM+Ls5I2JYb6kOoZlT?=
 =?us-ascii?Q?TCLhn+SMVNSsc3h5BIlwmug6QAAKphUrdjeah6u0r0Tszx/p82EAumF6dnaD?=
 =?us-ascii?Q?vHgCrVpR5NYtA95OQ1xXdTEPw2b6kwsqJ26wRRqjyUoKcykxXTbS5Tk/ttfz?=
 =?us-ascii?Q?KAK9Uou2ldOIsPXj8U3eqP1n2+JqceVTTXx/FFY+Cts3EeJILvh610smmX8G?=
 =?us-ascii?Q?ylJhObvIrSWgFqQ9O0GlQr/0ngJxqN925RlkW7CM+zQfP6Cj4p9bdF0B/qXR?=
 =?us-ascii?Q?XZkCoYenFe5ww3l/NyaLrEFWIPOLcuOO/EYgnscwymXJ4tFEFxWlHJmKvOIg?=
 =?us-ascii?Q?cNqn+WClWtvCOYKGTCD7yO5L/bJMj/7DIiQyq0iniLlMY1G/4GWg7rphcA3T?=
 =?us-ascii?Q?fJQ0/uR6pPw7DAZUSqrHqTFJdwJpxNPGo8TIIX8/CFNIVbXMcVrJNhgfW25u?=
 =?us-ascii?Q?dXw8T0J2BggZMHz4ak9I5UjXZyWVQjpPfr1uVf0JeP6UZC4aEzsidi7nsD2+?=
 =?us-ascii?Q?EWJEwi5l7S6UDf9L/HflM9B5eCtwJmYtMonpMNruo9jfNkNv1ADWyhOcSjy3?=
 =?us-ascii?Q?LbQF8vIjgULbrAtln1pF7ptFx1/I8dnsPaoNeQeFyulBEeaQvtM4yQxbUW65?=
 =?us-ascii?Q?4gQa/JXUvSzTgYxp/wOmtPZXpk7GVMM15yF4Y+zEwzq48yC/373vrzktmSmF?=
 =?us-ascii?Q?mVqTsEz0Fo9kEsF9vcUEqbzNZDwqWimCdPxo7uXjyLVNj4hPpxde20kxYU+c?=
 =?us-ascii?Q?AUY/UIgtFjptOsYt88WLfthZ5JN25KbU59DWYG7UxQsFcEbtYBjRVcRasIN8?=
 =?us-ascii?Q?GI9QDlyqjSrPILP0IY9nP5ISHSlS6yWXPQAjsYpl7BrK+e2k0osujiBfZ2Te?=
 =?us-ascii?Q?h3aXwSKAfLukrwCFLwW35YLvIaIU8U3/rOXpDHMKbrXaU7X/n9UI/URnNYoc?=
 =?us-ascii?Q?uUDmRoZ/s47zzz778k7Docb98gZZKia078p2m9Ze9HM2oTRLVeXnYbgnZK6K?=
 =?us-ascii?Q?fHdGI/5GVfKU9/MtLPKUwIgG+zZpaX3SAaecToxbtcd3H4iq1FjEBUSwtXhZ?=
 =?us-ascii?Q?L2lESY0V2ncbbXVlNS+9OzjM9/vvqZGk1q2UkdnVCoQdNApcaXNa1n8pD6ij?=
 =?us-ascii?Q?BkE0YyoF8BBSrJOEVR158inQuPSHWI7Wwf2UajAIx9IbekiT5dAGDBOTSdBm?=
 =?us-ascii?Q?sBa8xLIEJ7E1B9129NS9Ic621WHo5pxOSd7m2jiodUc5coaFq3LZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 093cdbf1-1eed-48c2-ff83-08dec2ac1a06
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:42:36.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEXS1z5jn8OkxSoUSaXJGNCGCh9yUwqOMySGdZwLijitExLTjG/WlkOLIkPJ4N2CYS62/1Jf0VsmQmUZ7fNmdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6154
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11180-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:from_mime,valinux.co.jp:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A6C3644BBA

On Thu, Jun 04, 2026 at 04:35:47PM -0400, Frank Li wrote:
> On Mon, May 25, 2026 at 03:24:14PM +0900, Koichiro Den wrote:
> > dw_edma_pcie_probe() now obtains DMA layout data through device-specific
> > capability callbacks, not only from PCIe Vendor-Specific Extended
> > Capabilities. Rename the local data copy from vsec_data to dma_data
> > before adding endpoint DMA BAR metadata discovery, which does not rely
> > on VSEC.
> >
> > No functional change intended.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >   - Fix the commit title as Frank pointed out.
> >
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 76 +++++++++++++++---------------
> >  1 file changed, 37 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 5a6f5af358d0..c7362f1bf80c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -369,11 +369,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	int err, nr_irqs;
> >  	int i, mask;
> >
> > -	struct dw_edma_pcie_data *vsec_data __free(kfree) =
> > -		kmalloc_obj(*vsec_data);
> > -	if (!vsec_data)
> > -		return -ENOMEM;
> > -
> >  	/* Enable PCI device */
> >  	err = pcim_enable_device(pdev);
> >  	if (err) {
> > @@ -381,25 +376,28 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		return err;
> >  	}
> >
> > -	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> > +	struct dw_edma_pcie_data *dma_data __free(kfree) =
> > +		kmemdup(pdata, sizeof(*dma_data), GFP_KERNEL);
> > +	if (!dma_data)
> > +		return -ENOMEM;
> >
> 
> This is straigh forward patch, you move this block after pcim_enable_device();
> I suggest keep original place for easily review.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Agreed. (I placed it there to keep the copy close to the old memcpy point.)
I will move it back.

Thanks for the review,
Koichiro

> 
> 
> >  	/* Let device-specific discovery override the static template data. */
> >  	if (!match->parse_caps)
> >  		return -EINVAL;
> >
> > -	err = match->parse_caps(pdev, vsec_data);
> > +	err = match->parse_caps(pdev, dma_data);
> >  	if (err)
> >  		return err;
> >
> >  	/* Mapping PCI BAR regions */
> > -	mask = BIT(vsec_data->rg.bar);
> > -	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
> > -		mask |= BIT(vsec_data->ll_wr[i].bar);
> > -		mask |= BIT(vsec_data->dt_wr[i].bar);
> > +	mask = BIT(dma_data->rg.bar);
> > +	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
> > +		mask |= BIT(dma_data->ll_wr[i].bar);
> > +		mask |= BIT(dma_data->dt_wr[i].bar);
> >  	}
> > -	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
> > -		mask |= BIT(vsec_data->ll_rd[i].bar);
> > -		mask |= BIT(vsec_data->dt_rd[i].bar);
> > +	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
> > +		mask |= BIT(dma_data->ll_rd[i].bar);
> > +		mask |= BIT(dma_data->dt_rd[i].bar);
> >  	}
> >  	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
> >  	if (err) {
> > @@ -422,7 +420,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		return -ENOMEM;
> >
> >  	/* IRQs allocation */
> > -	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
> > +	nr_irqs = pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
> >  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
> >  	if (nr_irqs < 1) {
> >  		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
> > @@ -433,23 +431,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	/* Data structure initialization */
> >  	chip->dev = dev;
> >
> > -	chip->mf = vsec_data->mf;
> > +	chip->mf = dma_data->mf;
> >  	chip->nr_irqs = nr_irqs;
> >  	chip->ops = &dw_edma_pcie_plat_ops;
> > -	chip->cfg_non_ll = vsec_data->cfg_non_ll;
> > +	chip->cfg_non_ll = dma_data->cfg_non_ll;
> >
> > -	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> > -	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> > +	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
> > +	chip->ll_rd_cnt = dma_data->rd_ch_cnt;
> >
> > -	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> > +	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
> >  	if (!chip->reg_base)
> >  		return -ENOMEM;
> >
> > -	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
> > +	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
> >  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> >  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> > -		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> > -		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
> > +		struct dw_edma_block *ll_block = &dma_data->ll_wr[i];
> > +		struct dw_edma_block *dt_block = &dma_data->dt_wr[i];
> >
> >  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> >  		if (!ll_region->vaddr.io)
> > @@ -457,7 +455,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >
> >  		ll_region->vaddr.io += ll_block->off;
> >  		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> > -							 vsec_data, ll_block->bar);
> > +							 dma_data, ll_block->bar);
> >  		ll_region->paddr += ll_block->off;
> >  		ll_region->sz = ll_block->sz;
> >
> > @@ -467,16 +465,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >
> >  		dt_region->vaddr.io += dt_block->off;
> >  		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> > -							 vsec_data, dt_block->bar);
> > +							 dma_data, dt_block->bar);
> >  		dt_region->paddr += dt_block->off;
> >  		dt_region->sz = dt_block->sz;
> >  	}
> >
> > -	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
> > +	for (i = 0; i < chip->ll_rd_cnt && !dma_data->cfg_non_ll; i++) {
> >  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> >  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> > -		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> > -		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
> > +		struct dw_edma_block *ll_block = &dma_data->ll_rd[i];
> > +		struct dw_edma_block *dt_block = &dma_data->dt_rd[i];
> >
> >  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> >  		if (!ll_region->vaddr.io)
> > @@ -484,7 +482,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >
> >  		ll_region->vaddr.io += ll_block->off;
> >  		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> > -							 vsec_data, ll_block->bar);
> > +							 dma_data, ll_block->bar);
> >  		ll_region->paddr += ll_block->off;
> >  		ll_region->sz = ll_block->sz;
> >
> > @@ -494,7 +492,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >
> >  		dt_region->vaddr.io += dt_block->off;
> >  		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> > -							 vsec_data, dt_block->bar);
> > +							 dma_data, dt_block->bar);
> >  		dt_region->paddr += dt_block->off;
> >  		dt_region->sz = dt_block->sz;
> >  	}
> > @@ -512,31 +510,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
> >
> >  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
> > -		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
> > +		dma_data->rg.bar, dma_data->rg.off, dma_data->rg.sz,
> >  		chip->reg_base);
> >
> >
> >  	for (i = 0; i < chip->ll_wr_cnt; i++) {
> >  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > -			i, vsec_data->ll_wr[i].bar,
> > -			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
> > +			i, dma_data->ll_wr[i].bar,
> > +			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
> >  			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
> >
> >  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > -			i, vsec_data->dt_wr[i].bar,
> > -			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
> > +			i, dma_data->dt_wr[i].bar,
> > +			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
> >  			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
> >  	}
> >
> >  	for (i = 0; i < chip->ll_rd_cnt; i++) {
> >  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > -			i, vsec_data->ll_rd[i].bar,
> > -			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
> > +			i, dma_data->ll_rd[i].bar,
> > +			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
> >  			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
> >
> >  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > -			i, vsec_data->dt_rd[i].bar,
> > -			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
> > +			i, dma_data->dt_rd[i].bar,
> > +			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
> >  			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
> >  	}
> >
> > --
> > 2.51.0
> >

