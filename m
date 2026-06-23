Return-Path: <dmaengine+bounces-11736-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1JFGBdD3OWoMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-11736-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 05:04:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E87966B3ADB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 05:04:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=B3UmzbiK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11736-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11736-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E45DB30091C9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 03:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C5261B9C;
	Tue, 23 Jun 2026 03:04:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021142.outbound.protection.outlook.com [40.107.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54785231830;
	Tue, 23 Jun 2026 03:04:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183881; cv=fail; b=g7cWMoFNAr6rYYObKjwSO2SjgPYw/1jQQLsVisUtb40/DP4triTcpH9QsPOZX3gDkaGi9uzBZFdVJ8jyVgAfidh9lDqG+MrhiYLP1oJGkn50edO7kqoZbllDlmeSZ2JcmbaFykX+1GpzXJ/Qf3Alb4GiWdoeB4Nc9PqE8nY9Agg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183881; c=relaxed/simple;
	bh=eNaGITdrko/UuhJpPww46o21BbpSx8LpMgLSBJFCyR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnvI1FatsK3eWNw7/IjaoDYPVK9btS0Vqvg9O0iahtLRP5+yeaBdQJ2qEyaRAZ93vPMCNwi7VIPKVoF9kTwOLjHMcEm+bRtDR4Zi/YbxIMho97QGXhPlxONITXMUJHliT6YJi0AxOHyiIbwmZfeSbtzXicT6VRenE7YiuKVp/AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=B3UmzbiK; arc=fail smtp.client-ip=40.107.74.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMxW+ZOhlqLCz/yv6rqwZaQSjy+QyYPkM+4iqzHK8H/F7JfpXS+AShBq8HJHFKhz5URcl4xTqy6i53PyaVFjLywZjDNfU0vXr1383yiqIjg00lusG15wpDJZQqTwoMQEntO8hGP2Snx6IZ21SLDq1lD+hbQgpCxCcDs5EndwMZptzusjPjFrRBwEKp4+CN2NXPemJOnlQtd6/QFrKQWvXJjyUEBqgN/iWr+KVYgl3toVzxIe0Pelffun+wiz2KCOad6ve+fAQQ+oMxzVTXndaQuCcU6j80AlA+Dzb+D2GdEuReQ0b4/CCvmj0UYMq0wb6skJx7I40n6ku+PkhuDQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVfVTFOcC1P5dArougu0LbyOnQ052bwWBWopgM9BBgA=;
 b=MMTgH0eRvQE9Vu6thj9qW0PNY4mjOk8IDp6+67LPE46QH72UU5EzFy0N9VUCgbzAXI8wcmnZr3IWrHtNFV6BDTlR7Bgbki5H0lHb5YnROn/z6KjuleANKZAT/JJbsT9QWGY5wiOnCYvvVXp0het+8hKqjG+e1j1qyDTOrcaYVn+EJU5jHSOnuVFjVSUsvtNxhbWplr8W3dZFp/QB4aiBxVq80K8db11NuiraGaNnvbZTU7mcOZqOe8Hku1Fnfc9rai3ZydqchyucRu3vVZkmv5l8xo62vuR6NPOl/0liVS4OApP+/GY4238w0rQ74jgt8GODg/Rj7ddN+2brKMkMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVfVTFOcC1P5dArougu0LbyOnQ052bwWBWopgM9BBgA=;
 b=B3UmzbiKUVGIDkd73FSPAFrvGKv2WdwH/NZyaDit2lNBXr7TLhScSuzcTJuwSis2ZPuRrD/HKu+SP1fMqK+47QMHCyWMdBcUSMsefBILVw9pFp34ouYbj5CkLMUjXndAl+h3ASBPEVeBlPQVKgrvihkf0mqAN5Zj2fmkm3tzHIY=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2156.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:173::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 03:04:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:04:35 +0000
Date: Tue, 23 Jun 2026 12:04:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] dmaengine: dw-edma: Add partial channel
 ownership mode
Message-ID: <nw3yvxfymbcnvk64jlg5impkhhjzu4zincf5i3fdes3uperout@q2opmrp37pgy>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-6-den@valinux.co.jp>
 <ajlb3oa8OZc2OWYK@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlb3oa8OZc2OWYK@SMW015318>
X-ClientProxiedBy: TYCPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2408c57f-1869-4659-049a-08ded0d42809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|22082099003|18002099003|3023799007|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	g+sxGZsGbWR5aCiqRzC6IpUPFE+7xXiLgh4ILCixvze7qhBZBvb4kVLhhP/wCJTVTKVxuIKVGKOZdfbVAg/lXb7za1eePqlP3h9G7d3Q/AVq/NOYonQFG4AF2WYeTMCZJPhlDvo54dsZZX4qVsNfUmtdOoEfHG7LZEz0BGQiu7NIEMWbGOOEgyTjkSyVvNcFxLFO/KQaWerS+0ZCh+3QV4asm0dV0IX5xqLxE9NRZch6Rylhg5PiXZbjEn1UYaY00OanLszwxJOMXrvjdh9X9Xrxqr1CTBcDEV5GRd7AgopiRaI/JMX+79+X8hpXsTx1fSmggZ66m+nOS8VnAVy9NHDYfn8DyAmaIMLAW9+OdHbT8tEsEo95RbhnvX5yTQxCjHhfA4dT3SxpOtHPDEvwG/6jKfzo2nkkHPAv9hoz8jyjjxnJkejt8eFsyRntHPCHVnRHhEeqJb7VcJJ5rZKeMUw8H0mCHuihGAJJ5ACsRHU2KkRwmblYcQnvVNcJK0YpeekkLt/3DByJfbI3a0GTCWAVtaYk/AAeqC19Tk4idafYfN8QTShLmvhsPAdmDBI23hcQlIJ9Yrkh/q+gXLaUirIlHB4qrswuayaBeqUPobroKs6R/bCutuamRTBHMuoV7dhQmJREelS6wJw1xDP/k4/5vXoVm9N7GBaC3oOQWL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCNhL1RyL7ZsKXI96IsCvwvXZWGzm2nOFdUJbWHRJbwp4yL+IKVMGgmhXHJ8?=
 =?us-ascii?Q?jxi5cUKepCxXhxCha2BlCyM/OQYdJzJmKWfZIYiRWAa87+RYFuYt1VJiaEi/?=
 =?us-ascii?Q?hCptxsknnXfjJ4xxW7cpCrT+z6G09C6scgvs6ma7QQX4/GYn+YxA1B0WtGEY?=
 =?us-ascii?Q?qkEU0eyGlbL1nNC4YpqWlRG5Run2ccvskcSvH4hwiTkr16JnCSO0mQLOkJbk?=
 =?us-ascii?Q?3oI8iM34s0KzkAO8wotFY4ymdXJELYdsrmZ+gQUiX4VB0KAGWbxGRlsT3SkS?=
 =?us-ascii?Q?U4xcObywPh053YHupQtkLfyNGlOqfMbxD4Gy4md+R92F4cHJfRALrVWW3d/s?=
 =?us-ascii?Q?HRaSXSjkiClkeXbkAr6GgCKg7eiCinjkM6/G5vI36Uq6yJM86JsV8bcuiNjY?=
 =?us-ascii?Q?Qj62GVakQaBBeo6l9cRGg56TKfkHdZACtsznA5w6jAKWx3p/8+qx+6tJNDDy?=
 =?us-ascii?Q?HfdVIXWgyBb4vjK9iF83RKEJJCMQKAm/ZOsDlbBu9bdj6a4NybImxgK5feSy?=
 =?us-ascii?Q?2H5UYcWLgXoSGAO308O200MYJBECg+xQ66j0fBGvpGCAtAnWaRJWix9UQ1ux?=
 =?us-ascii?Q?2/Gn+YtZOQGRlF+pg3/fK4d49CNtzmmqjyCh/Z+sPvfQCvPOTqUrhEsn2vmF?=
 =?us-ascii?Q?gNAVpu98MHTdrBd1NdspW7pySMxozd4rOxqrZsTPXOi8JTiO/cAbA3vRXhhM?=
 =?us-ascii?Q?RIs0B9Vfd+9kqIB+2S+Iry3MQbJ3BXnZpa3DGmG808LSAZKJLa3Vi7VWTsaJ?=
 =?us-ascii?Q?cooAnEwBciXHJlu+sPRPnR437jNDfh7Tm5l6GkX4UBwbKy7wpwSQX5M+KHX8?=
 =?us-ascii?Q?HXYh3T/bspa52mB2sQFeS7+NSXgq64/lH5BAwGRwnTBQ8M0uDOCcKyU+Npfj?=
 =?us-ascii?Q?TEonvdCtqpjhsvKz4E+U1T/WypjeB6vTUgFPEoVRawOPemYWu29G5Gm4chry?=
 =?us-ascii?Q?zsXcWWQ+z+LwlQSVhJ2wqjz9akNeuDY7zAnrkBZjckUe0TLmJzYJRiD/+4zt?=
 =?us-ascii?Q?88Z6da6o4flcZSEI4Xbz1DdPmjBTUR/j74jINYmJiVEzqCrydMJptILIEY/X?=
 =?us-ascii?Q?mo0lWHSy8/o0FT3SOw3aQLSZLT3Mzu+eDgIHXpej/JE8O031l7s/CYYwbUJC?=
 =?us-ascii?Q?WsDLa+RhiC+Sz82lmKeZpN4x7K446sjkrh/nUa7uD1I68m11iTYBy1JhTegm?=
 =?us-ascii?Q?ki5VSrjF2Xh1aTfy3BzjAE3y2d08kjKIYN620jZIt0yPSs8WSlBXTDr4US1l?=
 =?us-ascii?Q?ozwfrQpsHPYzPSRaWeCMpHoTlY8/2402TbIK/Gngg9fmF3DcfDlQRDf1/d8L?=
 =?us-ascii?Q?mkT8GYs0TbmPuff6S5EPRgCU3tm+9BXeCqq5gX6xldICwII+7impHZ0S0vL/?=
 =?us-ascii?Q?6wat1/q3GA0cKvNdQKSpyzHx/GdAjM2CaOIfeetMC6TYMXdtTx659QeRHTjk?=
 =?us-ascii?Q?7rU/H5BQfwEIhiwoSU0WtyLZbQdUhUCwq5kRZwE8fRo0uq2JSMqqv3YRLxBN?=
 =?us-ascii?Q?k6Kom1e59SUY+s9k9+pc20KP39R7Tko8CL7FvDDksxHIVESwhzkB7ZEL5A54?=
 =?us-ascii?Q?oPBi/svjpipQEUqPSCaaNWJCwKQkMjDOJm7Rg3pNNjJ0081a3E+rwj50liMi?=
 =?us-ascii?Q?jMC28NodZftd07rumwU7m6IzirdosZTdj4KbmsjLqr6IByk0S0H76XZBHKAn?=
 =?us-ascii?Q?BZrDU37FbulhUAwIpszF/BlfqgKko9xTqFeFwUndKJp+KMQAP3qMo7Yfcqr0?=
 =?us-ascii?Q?3J3ux9+K2S5J3SxihS+c1LT0ww7PsZruJVHbShJFOWgMXKNd8cJR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2408c57f-1869-4659-049a-08ded0d42809
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:04:35.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzVB6+yqokYVYBe5wt3LGdOLff9ctL/FQPi0/UThkbE9a4DC4Wn3481nWpk5OTuo+1in9Dn7lPY/L1GLo64flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2156
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11736-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[q2opmrp37pgy:mid,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E87966B3ADB

On Mon, Jun 22, 2026 at 10:59:26AM -0500, Frank Li wrote:
> On Sun, Jun 21, 2026 at 02:00:32AM +0900, Koichiro Den wrote:
> > A DesignWare eDMA instance may represent only a subset of a controller
> 
> s/a subset of a controller/a subset of channels

Will fix.

> 
> > that is also initialized by another OS instance, such as an
> > endpoint-side OS. Add a partial ownership flag for instances that must
> > preserve controller-wide state owned by that peer.
> >
> > In partial ownership mode, dw-edma skips the initial core reset in
> > probe() and uses the limited quiesce path in remove() instead of the
> > full core-off path. The flag also makes the driver validate the
> > ownership granularity required by each register layout before
> > registering channels.
> >
> > For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, the driver programs
> > per-direction registers, such as DMA_{WRITE,READ}_INT_MASK_OFF and
> > DMA_{WRITE,READ}_INT_CLEAR_OFF. These register layouts have at most
> > EDMA_MAX_{WR,RD}_CH channels per direction, so the capped hardware
> > channel count still represents the whole direction. A partial instance
> > can therefore expose write or read channels only if it owns every
> > channel in that direction; otherwise two OS instances could update the
> > same direction-wide registers without a shared locking protocol.
> >
> > In contrast, HDMA native uses per-channel registers, so it can be shared
> > at channel granularity.
> 
> Not "shared", each channel can be owned by local or remote indepently?

Right, that wording is misleading. Will fix.

> 
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v3:
> >   - Allow partial ownership for HDMA native, which has per-channel
> >     registers.
> >   - Quiesce represented resources on remove; v2 only skipped core_off(),
> >     which could leave those channels or directions running.
> >   - Revise the commit message.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c | 52 ++++++++++++++++++++++++------
> >  include/linux/dma/edma.h           |  7 ++++
> >  2 files changed, 49 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c782eaa12021..d87791205837 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
[snip]
> > @@ -1105,13 +1121,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >
> >  	raw_spin_lock_init(&dw->lock);
> >
> > -	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> > -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > +	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> > +			     EDMA_MAX_WR_CH);
> > +	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> > +			     EDMA_MAX_RD_CH);
> >
> > -	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> > -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > +	if ((chip->flags & DW_EDMA_CHIP_PARTIAL) &&
> > +	    (chip->mf == EDMA_MF_EDMA_UNROLL ||
> > +	     chip->mf == EDMA_MF_HDMA_COMPAT)) {
> > +		/*
> > +		 * Direction-wide registers are shared by all channels in that
> > +		 * direction, so a direction must have a single owner.
> > +		 */
> > +		if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
> > +		    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
> > +			return -EOPNOTSUPP;
> > +	}
> 
> move this check logic to helper function.

Sure, I will do so.

Thanks for the review,
Koichiro

> 
> Frank
> > +
> > +	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> > +	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
> >
> >  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> >  		return -EINVAL;
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
> >
> >  	/* Request IRQs */
> >  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
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
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 0ba8a1143fb2..3c730c88f0ab 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -55,9 +55,16 @@ enum dw_edma_map_format {
> >  /**
> >   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
> >   * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> > + * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
> > + *				owned by this driver. Controller-wide state
> > + *				must be preserved, and layouts with shared
> > + *				direction-wide registers must only be shared at
> > + *				direction granularity. Layouts with per-channel
> > + *				registers may be shared at channel granularity.
> >   */
> >  enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> > +	DW_EDMA_CHIP_PARTIAL	= BIT(1),
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

