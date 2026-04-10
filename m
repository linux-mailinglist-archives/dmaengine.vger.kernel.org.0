Return-Path: <dmaengine+bounces-9949-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE20MsZn2Gm1cwgAu9opvQ
	(envelope-from <dmaengine+bounces-9949-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:00:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1F3D1A1A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C31C13017050
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97250261B9B;
	Fri, 10 Apr 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FS/sW0qB"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73A4C81;
	Fri, 10 Apr 2026 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790018; cv=fail; b=JdTzp2qRanUZvr1BPtewPuOPvJiXb+qFH3D/sjKJ16mLdkYFYuh7fJo4KhVOJDNTFXKMdrhrkM1k5zbl+Cu5etvXZqBprjh+bADCfQnpUlfwja2hxvbRd147WV5amhdfD6eZgj2DSztOfxfy0rO163KZ8Wqpn27BniCzjz3qE7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790018; c=relaxed/simple;
	bh=n2Y4JAlg1LldYYZjH3wG89/50U5vIOjmTKn17s4Rz3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZSFkbY9FoSdMTWUH0sRak0i2L5scN3gexYUu1sOE8ERFbBxSnSlzevQZ1mik2ZubgfFoObbPA4NsPytWSBipxWZAr9NkZfEsA5RP3OqnLbKpPFodiea2XsoM5ShXLxc/pwE50MPIpSYkJSm1oFqCez3j9Z0tIfTykz30iHCh6Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FS/sW0qB reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhdVue4LbO8+Eg68Lj1/4JASMDOzgpGFr0s0W3kqYgd9P5KmPDek7zU1efxF4zxTqEoRrJ0g53lVDsjPdUwH/oUJ2lnotcPFwD+oDq0ei2O1wGpZ1vnrKkK36hdImX/wXY6EfMO4F0tOw4+se7KJRXW6GffV7MydIVQhYi7bOWtZXf5rHRvvkcKMJMfAB9xZQy29UutiOmLWzTfaMj7pLz5mIQ6jprum0kqLDaogJZ+00ojRgVNZdRd7T7SR3imvl5bwTYMydzQEKYZd7IITh2jWLhvXYtB3ipKrjQC9Lpt0Jf+fBlDqEsU3HjJZslBbmsnxsS5EQHKG129EgcVOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6yzQB0av6KEOWmgnqV7yiTVgbaCz0AXO8Q6oK2ZxS0=;
 b=St20v0He2XDLjG2seDPFlV8tkzJCY0ioYpIOB5gM1cSMf6ZbuAvNsstG00dXTnxzISuOfQ4ZR9sdMAbeDJvx2LP+Y3XwBYrz6n2j4zz3KLxZt1xksxrk6KnPHJ1rJ0qLcVyulwBKIy0Y7sGbfXP41tYNI+VfrGNc3vjNTjPoTNjpJKlvT3hNyfSCgzbQvIxogcvly6bKwa4Mzc6CaPy0py6+bdNnp4xXl36tmpJ9AfXqHUDLKVHfj6S774uvfy4DbJ/TC60m1H6WuJ1XhZaEy7aAwKn39RjGQGEZKf0wOvPE7GZoIwDbaYc6T+AxE2YsaLZqfNnmlfV5AvwXXRnsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6yzQB0av6KEOWmgnqV7yiTVgbaCz0AXO8Q6oK2ZxS0=;
 b=FS/sW0qBNpxA272CNNrOY3duCbwQD/M2OYEe49O0xQqDOCktbbGyt98zzETXeA+DAX995QouaeWCLtd4StUDPQSdY3LsuqCmPdXfKmAm+6N1CqSP1zzebDuZ/AI5kGqhR3jA565IuTIWq8YvCvXRkA1SjOxayw0ndx3R7dXGSWk4rwOXnZxHDWX45/+n0yD1ZBJKNs1lpVEpFlto4VycBSGB6GVFKxWuORCmTAMh3dsKsBxsnm87Vg/OoHm7QmE6t0A656sWiePKJRnv7sHdAXTuzkXUP4D/yoKKZkBkAcsGQGoIKHHsyyhOZyO4xz7ac7s/UqAeTtP3f9LTkIdCMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 03:00:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 03:00:12 +0000
Date: Thu, 9 Apr 2026 23:00:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v3 1/4] dmaengine: Fix possible use after free
Message-ID: <adhntuZPo60q3ImT@lizhi-Precision-Tower-5810>
References: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
 <20260408-dma-dmac-handle-vunmap-v3-1-2456ad292154@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408-dma-dmac-handle-vunmap-v3-1-2456ad292154@analog.com>
X-ClientProxiedBy: SA1P222CA0135.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e2c95b-beab-415a-48f0-08de96ad4837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	G7kEUFp2SOijI4do3+xiyh6w9l31kbUK/jDSUQUKycVA/TYcMpi6PerwUYwS0vhyIt3GBeih2aOHth1fr+WbVQpuL8kxhwtAe4FlUIrEUeQXUgqyaYBDb9Xh11sW3M43tm8IDjgszOGs9xwt6iCpKqKlAwsVWnBePQ5H4KGpwJnvAtl0/8Vab7ZApoC2bAlcsCe+GXg/kuxL7VbfxLBPHI7cdDTcRZq74lmJjew5JbeTuPSx1PtzjgS0KWPrWwiC5TJGbSGD3NK9L1TJJDOJ8CI5ZOk8b2Ozhi3JGPFxrJx4TqhUSDw+EqJamdssViybfD9hS2rAXc+ojsAZNfRYD/cOT0ZUrYo8jYbzQnZe/AgRUKjatsgIIU3xP5kmx6vWaTXYcI5x8zaZe9ocE13n64PMI34PrG/vkz9zxSXcvtQ/cy7qJXPxQ+FNHeiof+Wd4r8mXO1VAUctGP51dH7Ka+AXYVRAqoz+eA1y+HEW7mz0PTXECnbkQ5EQZU3GjT6WnT0xs0Of4PghxncjCaTqEEM2HGrbfiE/cPMcvExiv/91LQlCgSRhdpf5ll6tVdzDYt64De95D2D4kBNT1odLOWUz3cl9CBfLeVP260yLQ9X9bBLnichS37bZG5l61fYxDntKBZAuVz68lgL1NHZ2sNVcK0VSShYQQfBMtKcfYBKhfhixXsO/6ljeG46LEAVsvSuJvPCljE9wDQayWi56eJoZkI9lblVaMTHIAJH6/ZN2G/XRzpHgma/ej5VImubUZ0NC+UzqXkZCwW9EFi1UCqgk7WdJhiEN7f9onkWwqQ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?vbryq1bzxC1wcEt56tHC/9u8ba7Ln6L039hW+EXs5C9Yl4abaspjxAonlU?=
 =?iso-8859-1?Q?SxUWbOdmyjgn5m4OtrfqxQLj/mBXaSDj049QIuq3qujKxeJ7UTHW9wQL80?=
 =?iso-8859-1?Q?XV8NY0Oe3OHQCyCAehtoz1SK/yd8IGt15JTDqwkH9RdVt6byV6c+v6zqNQ?=
 =?iso-8859-1?Q?WcrhUCE+ZKKXhFAd2KCywThq72e2pflSCLo1bd2oit28NsBzLEiU2YqDJb?=
 =?iso-8859-1?Q?OzfFUDXb0gycDVvhJftaWLjI+25/NobPOrGepHKZvsr1q3MFPLwZC1Et5T?=
 =?iso-8859-1?Q?I/8lLva7vI7r+0zHfa/HDxwKkwVAxTN1nJEES2sqlItoBUJEbRSVjTIN3f?=
 =?iso-8859-1?Q?2CkCU5CsMw3YATyeEvpgiPC34IjOUl4oS78gFQdk/rCk1rR5bAs4RgK/9L?=
 =?iso-8859-1?Q?9d3PeSKKuOh44joWLoingfTbxntPpQp9lzoiX0C4VwjwXITVvIGnbtYQRo?=
 =?iso-8859-1?Q?xyDxNWCQtiVyRjCziUT/sViQxYojWK9JK1GIz4RJoa2ADxjQUACxQm1LMc?=
 =?iso-8859-1?Q?qPAGia4Lb9BxXcmGr01wa7NSXImLdUee/xZ1nZH8+6potno+0mXm0IEgY7?=
 =?iso-8859-1?Q?bAHio2Kly2f0ncX4SxE7xYup+TANscgzVEJnDj3QJ6LVH2BhTlhiOnkDYo?=
 =?iso-8859-1?Q?VwEHpXd/8mcnuH20KmmCAtObiImFX6SUKXetDiLRT/ax9fXyaZqnhpvGNr?=
 =?iso-8859-1?Q?RtsCMciris0MBHZca95en6rR/CY1q9Z90B1GFa8bg4ccLX4J61fB6ruH0h?=
 =?iso-8859-1?Q?k5mFcJUm2avHTQZWFje5I15hAXhy6VcosAT73t47aqUrt3j/UzwUoxgoPv?=
 =?iso-8859-1?Q?rduZlyWR65seRUOENxx+AZI6M13gbv6ssZRVN4bSCAgWOiBW6nT7E58VdY?=
 =?iso-8859-1?Q?dYYBUP+gE0jChSXaL2dLP9xSfRENOKjX1ZB9nm9UR1bU2mDTr+PR6uEbxU?=
 =?iso-8859-1?Q?yGO89I5tNnUd0SRNp5rnIZwo26UMd3JAh2fLf8B0RN3IZgchFjZwUaStxh?=
 =?iso-8859-1?Q?wvBVK9XgzjxNZHe9zYbd4NZG1a6UWWHuk8soL22rwol66urcGF+O3/RamJ?=
 =?iso-8859-1?Q?P7SzkNPua/+CHxex/XXBgpJ4fcLltU5JppukS7rfYl6VTgDS9eSP3TcpV4?=
 =?iso-8859-1?Q?BM9j7Bxq5l/UfbTw6TVoFiYSkPX4p2z1hN+OdlBXBd7J5gjFKqZwmdLb5D?=
 =?iso-8859-1?Q?wj8lu9+7vfITD3Eru5ZVTPNUav7N0oxtx2XoTu0bi9z9pvCtTyu0+CPfxH?=
 =?iso-8859-1?Q?VIJXZxNX7XM4QNn0j/Cx56L8mtqagSV1/4Gszsy5ZXx9euzlq6oALBbpF+?=
 =?iso-8859-1?Q?GJ4hirluaFBKy6org/ZaT5E9DYUrc9YinX838B7TICCXSd/oH1inECzCo0?=
 =?iso-8859-1?Q?o8tRrRrWX/YDUXPJeP46n5FyoPYQswn+IlfwRYnCfKzumxmwNAVolOXe4n?=
 =?iso-8859-1?Q?9jFb+yRPVB8D4J8GfPwpnax9wPneP0/CFJAxAJontlEPWbTq/IEDR7dSrT?=
 =?iso-8859-1?Q?4stiyYW/4hsqbcPt0HPr7cMthmlwkvtAHY/RFoxSW0cvCnp6ZoK6QTcLbq?=
 =?iso-8859-1?Q?wHAQOiZ2l3Rc6ivwFVM/96E4METbB7blsdJmvtjyb7hyukNkEjsyWqyZia?=
 =?iso-8859-1?Q?I5uVlBAtpQ96pahaqZ1ALdFbmN1iWyKoZxZz42dwi4Q/RaTm+lLkjxng+A?=
 =?iso-8859-1?Q?5kCiFevxK9IL966e7X26sHdpP4LdnoL9bo41E/cE6O4ZhK3ILAKFGZ3ic2?=
 =?iso-8859-1?Q?akGOth5SUc9I4dx6oKw1di4QMwXEpcn16DpsP6BEB5mgnW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e2c95b-beab-415a-48f0-08de96ad4837
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 03:00:12.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEpKM87Yli2lZFz9/aaQEy3nFcm88W6rDPu76z1hSoag68bPba9sPgTd4Qjo/BdTe/K8ETHgoEe9Vl8/oGu/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9949-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47D1F3D1A1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:42:40PM +0100, Nuno Sá wrote:
> In dma_release_channel(), we first called dma_chan_put() and then

Avoid use words "we ..." and wrap at 75 char

> checked chan->device->privatecnt for possibly clearing DMA_PRIVATE.
> However, dma_chan_put() will call dma_device_put() which could,
> potentially (if the DMA provider is already gone for example),
> release the last reference of the device and hence freeing
> the it.

In dma_release_channel(), check chan->device->privatecnt after call
dma_chan_put(). However, dma_chan_put() call dma_device_put() which could
release the last reference of the device if the DMA provider is already
gone and hence free it.

Fixes it by moving dma_chan_put() after the check.

Frank
>
> Fix it, by doing the check before calling dma_chan_put().
>
> Fixes: 0f571515c332 ("dmaengine: Add privatecnt to revert DMA_PRIVATE property")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dmaengine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 405bd2fbb4a3..9049171df857 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -905,11 +905,12 @@ void dma_release_channel(struct dma_chan *chan)
>  	mutex_lock(&dma_list_mutex);
>  	WARN_ONCE(chan->client_count != 1,
>  		  "chan reference count %d != 1\n", chan->client_count);
> -	dma_chan_put(chan);
>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
>  	if (--chan->device->privatecnt == 0)
>  		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
>
> +	dma_chan_put(chan);
> +
>  	if (chan->slave) {
>  		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>  		sysfs_remove_link(&chan->slave->kobj, chan->name);
>
> --
> 2.53.0
>

