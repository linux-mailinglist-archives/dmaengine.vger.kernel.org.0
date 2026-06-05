Return-Path: <dmaengine+bounces-11194-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t+WxKbcWI2oXiAEAu9opvQ
	(envelope-from <dmaengine+bounces-11194-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:34:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C064AA60
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=T4K+xjlJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11194-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11194-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11ACB301879A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8936EA93;
	Fri,  5 Jun 2026 18:34:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECC3AC0CB;
	Fri,  5 Jun 2026 18:34:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684452; cv=fail; b=j6L2bP3WE5+tFaiY4RJTtg3p50XzS0QCoRqPC6+inntKcP5Ys/ZUvMwb6cIHsWcm1+JxOX2A8B94//x6H5HQwpfvXL5uvR6I1mZS6OSDOA3Vor8YRvEPs19mCyIJxHYbyyafNrFXduMnoiKw9sKhc7MoEPVjnAROuzY/+ViVi/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684452; c=relaxed/simple;
	bh=5+IVzVkfiZPdWphZTdnlAHzoKuf49cSzZMaGiXG381c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/1Sx/6Wg6RojCA/IyJjWMamv3SIWPwAH0HOFTrhJp4RBsbGN540EPsEXaVrSaahZA5T5t0XO6MgB5zA/i4XErMQ69eO2VhtJyhLwU4sYh/yl3tE0c4by6FVwruBSi/UrRB0iElR3uvCCqA0x9q1z4XYv3QmDAMrrWXrPHhGNpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T4K+xjlJ; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5/l+d0+20SakBCDjMMov8oiIdanlrwMO8lIF//zDohc2JCO//u8yWpm7BnbLJbFpkLZLVQHsdmgwub8EjS+tDIqBPEkpnfDSFzGJcanFEEq9I2yenLxeugcmwo7sX1eZxtrm2LtcfwoqXFFT1lWsPJCC7NZ+RamjwNreQs97We2pUKmCi9u1ocpi2VupYnMmv/BA5JUXFjFUQqfIbXKcMtuNs3HEcxkgROxnMx9fW2k6TmDcOVe5fK7ayboJokIHGI6rz5+ueS2wOtNk4DyJSbMpnZBtNBtMwDkGJDuapk0ERiIugzI/E2sAH3WD9GZ9QNUvyN4Hcwk3y9kaUlsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOyR+wfwUklacILNo2EQAOfOdkTlAsTtELiM/OaL9IU=;
 b=CHuN29Tgyeq04SaCrEgXYIiwXSpSVsFI+Nhw3+fR0Hh46Qu+pUMr/k9J579jWvFIADCbszM8loYXJjb9WX4J+lZMjGynRescZaIC7cnDIfqybfDWFt9cOkOmN8LPe9vq/kpgAXRklOorGDffqjeP7Zl/ASXwMHPcEH/MMK0RNwZmLXtO8GKVODaIk6Zz6bNrlhPykN6eS3939ATF/PwiEoe14jiEiwfvKOBy5pRFU7NxnfYQOwTZlWJwJGJIQFrpZ+XQfv30eRikz3I7mdAsAWCKSgmGg0ovDytqj9G114xZTToa2AADtZ8JNf0KSid5FreyS52vgSkkrxsNweKjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOyR+wfwUklacILNo2EQAOfOdkTlAsTtELiM/OaL9IU=;
 b=T4K+xjlJ2kiJ0O5246eostbHo+BLwXlXuG55wOMkEEvhcEsRSVw0YJ8PSRNYNTeUz/71/dXyiJD/ZKcvQlULdsChs1914N2CxLmWRMbVESr+A1uhUvfPkYCBlQ1y4LFm+SPvU4I2Ej5boYnH0eZTEHd3driU9pTIT/pZMuYR1y45u7Fihll+oCYmsr+Ex4N97AbijvJN9tu97RhKAVEZ1K72FlCNPG+Wd2sdjM+1OEy0JSfOyAnAx3NEKRgoaSckA+LcZ1U67SWboDgk8CTysIyeMxsm2imswDHjoKzeO2RNJ8IklQ6hG0XTjtw/ny/85iBUuOtznEURb9I10fK+Rg==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:34:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:34:08 +0000
Date: Fri, 5 Jun 2026 14:34:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <aiMWmI8QMddHUzL5@lizhi-Precision-Tower-5810>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <24a5wo2ncgf7d43mxbv6pacvqkzmiuo4bvuyygfeyoq4lbdt25@kqw4cx7xzrfu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24a5wo2ncgf7d43mxbv6pacvqkzmiuo4bvuyygfeyoq4lbdt25@kqw4cx7xzrfu>
X-ClientProxiedBy: SN7P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9337a204-410d-46c2-2cda-08dec3310765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	6HF1AmZsuio0lGMcBH4Pwq1Ib9kQ971WRZOiDEa0GcY2yi3d3QjjvGwilMX70YWMTPjK4yH33xxKhtyxrnQbggeG6+ldku8EEHlbiIs/e7zbvBtgzex53ptE+j0WdeVOB439XWvQq5A4d2LXZ4CcE7SNWRZJxq9nB42nkE9Cm6qV/FbyDJulF36MPJDianepkcRyi+y3MW3SwN6dCI3ky9YRUYlEmNnmS1WUYoXIK+jvrAthUC/GcpWTKsXdRGjffYe5tI45MSluBowkKvZekmYBVqzu+xC4DVS2Vn7AURLP9qEXtUbB+Ek2+BQiZG505YXRW3X9w6BtnpPgx5CPtjW9QaHxdOcuLh2tUp1iirY6x+2bVmlJpClfYPfHLof4irP5uktMiucfKW9zceQRd+zTQAEQx+wPF4TNpyXpcwQcJGyEzMMCD1FcEtxJ3iaOM851+ojHvWGe11LJ7+DaSeuwFXxZgkxPPxRaS+tnbZ5kwdbHTbEjmgO3ZzCCGigud+CofTKXkIZZTzRqIb4JR3qCjBTPu43ulOVeomJFIj0kZazW7iGUSDVWUc2S3QI14hEFpgWXBbuMSYtlDeLfQ0NOR6B96Pxq6x1b7wTMMYSo7WVIGgpqakvubQLmCcACBcyasv4bscJCHFtOZaFx6vgLeyPuuCkV9douzMqJkRtKOeuLFFzbUetivVDC23OVYjd2KRYQVTuwr2Em1LvCIOI8SHRXA1cNnLZA1zSCvJ1Fsvj/ZfaaeBS2h8a3stmb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jo8TTzvPnvtoZfRP0Yd/nXnUCE0oNFl1+DpzPgsNKY+0GfhsuKJKA5l4Gyj1?=
 =?us-ascii?Q?Ms6UQH/eXbQBfqI1rFHJ4u+dlWHzr+QAW047ylsxAKNrmJpSjjwvZDJRclC8?=
 =?us-ascii?Q?54ollmleNz+7ex8qCCLKkhPdu/33QTOd6e45mZVMlezSm2qCYenx5XS6bFr0?=
 =?us-ascii?Q?b73zyC4mCfZq0L8yt1dB07MgZvkSKOAI2vHPyP93whmNzWasT/gXxhB3o2g5?=
 =?us-ascii?Q?0YJwxIbtdGWx6Fvxa0wj0UWnLGb8+VH3VLp/eCwLb1zxnqyjr0sx8qV17XqX?=
 =?us-ascii?Q?vezvNolSCJPuYQWPMOfCXeUAzSqBh++4Jfj7yUE5ClDKWgBKs65h78e1K8x9?=
 =?us-ascii?Q?gXxiR8OGwZWsqX2AYNNCRGV8lmMgjKzgon0Xt464kW8c1K4E5vA7XMgP6WSP?=
 =?us-ascii?Q?ZbNevDy7JWEFoA+nfQCFoWAXdoWxRlIzANrRSYu6LbiUKyxEBBsuOLEF1UV2?=
 =?us-ascii?Q?tF5GxaHD4dssai+z0rPPez4VFnYoSKoP6QKZTz61rUD03PTHmB1lKxx+JfTD?=
 =?us-ascii?Q?USWt00YOuVcYrAda1VmT464xLT/xlD83AHemV/frWVyxDX6ePWv16Tc+7yqJ?=
 =?us-ascii?Q?NxnBi4QkbPZMi8UOqEV5zvIJH8k9jytMe1h7pFj45cAYTdsFBGb+FSINRJ0q?=
 =?us-ascii?Q?kkoEasRGmsiE2/hmcCZVO4rCYZkFC0/2a1A6GGZH2WO0xqbtFX5GTUBGGRbs?=
 =?us-ascii?Q?9WMrbWqVTp6LpivSGacSrc7KM1PQr78mdHM8rh8rBnCgAbkeoN2TVRjEQ38X?=
 =?us-ascii?Q?vyuxyZyiusvRlnRcrtN7z2REonMbnuMJw0zh3ROBZZ9VQEwaanTqVJTREc+I?=
 =?us-ascii?Q?BXT2o/ElmYqR39ykTt1AUwSKPq4m4Hk9kTTPAP4AV9+DV+fNHsnJJnwOZ9SR?=
 =?us-ascii?Q?Lp+L2vF7/deOYc2OXz8JNjerYVGNMXTa28SOMvzPDmKjlqxVk8+vsg3b3MI9?=
 =?us-ascii?Q?W2WY+1igfvliyisINQKcSzoopzwCUovbdHQdVHI5gxbNCsHeSs1aRtRod5bV?=
 =?us-ascii?Q?zxdumm4Wrteb0wr8OEqR9mmxIMe1DF53H5wJxSE2MigBB5IjYyEK7iol8GvP?=
 =?us-ascii?Q?zr4gGIgdzC4pZIRJEWtU+pu2IlYhrot9gKvoULrbfaIs8xC24vllIZrrIi54?=
 =?us-ascii?Q?wWtTtImDz0mdWaKpqPn8Jvx6/y0/JZMvDQKqWJYxOT7ICtKIQX0OyJTL/p+S?=
 =?us-ascii?Q?OI8StD9SaYQHRSyuPiBOdyClhwE9yj2cbF/pehfwqQTlE66NKu9r3VIxDuTs?=
 =?us-ascii?Q?qVQhkufWngpjbhq59NbQZMam9+wAEXpNyJIo/dFKpGB+EzDLOik2TeeCgDih?=
 =?us-ascii?Q?LyKfcfPcDdyAPEEu2xDEKoPwLplPsvoWskSe/FhDpwjjHsX4L+au/h5QUhQt?=
 =?us-ascii?Q?HuD0wLXp4O1BHmKC17M1zUWNfheOj4d0M9FoTtpna6afMUdTFaQ75nhcm8Bp?=
 =?us-ascii?Q?77GEs1NfkRXjIeqWajTAZc3mqc/O/RDRUd6iMxOk/qgt+Xfy9qC4i/p/DjaT?=
 =?us-ascii?Q?zKjWgxwb6jWKHHxyjk74ME65bILiGkW6z4FPu0BDEqs6QnF4eK/OR5+AGRT/?=
 =?us-ascii?Q?vALGlu15di4YcJhPHjqRDuzlsCzzGnfTHaSco+GxlyUaTx6WKW++ltNGmXyn?=
 =?us-ascii?Q?/FyE0zLgcxm8In0JAB/DWb1Cy0mdb6jFEUrHtwJexiTYd7hFHqH3cCg+M9jn?=
 =?us-ascii?Q?6y3PsorLUjaWUOm0DjDjxdnO0jGTFHYvSl1HM9qAdnaBG84mqXIhATeQXHm4?=
 =?us-ascii?Q?mTbVw5VjGQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9337a204-410d-46c2-2cda-08dec3310765
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:34:07.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y82bXGFhvTo4YEcncTIwjwKzFfUxhRV37+eNTorbTGsiXUPJyLY6mnmP+w29s8KRV/1t68aHjruoxqhk1QYYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11194-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dlemoal@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 426C064AA60

On Thu, Jun 04, 2026 at 04:08:06PM +0900, Koichiro Den wrote:
> On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:
> > Patch depend on
> > https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t
> >
> > Only test eDMA, have not tested HDMA.
>
> Hi Frank,
>
> I expect this series may be revisited in the near future, since the first
> dependency series reached v7 and looks close to landing.
>
> With the latest versions of the two dependencies:
>   - [PATCH v7 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
>     https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
>   - [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and simple code
>     https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/
>
> I tested this RFT series with the HDMA engine on a SpacemiT K3.
> The test results are below, using the same format as your results:
>
>   Baseline, before applying the three series (v7 + v2 + this RFT)
>
>     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8567, BW=33.5MiB/s (35.1MB/s)
>     Rnd read ,     4KB, QD=32, 1 job :  IOPS=55.5k, BW=217MiB/s (227MB/s)
>     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=83.0k, BW=324MiB/s (340MB/s)
>     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3817, BW=477MiB/s (500MB/s)
>     Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1346MiB/s (1411MB/s)
>     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
>     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1515, BW=758MiB/s (794MB/s)
>     Rnd read ,   512KB, QD=32, 1 job :  IOPS=2795, BW=1399MiB/s (1467MB/s)
>     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2795, BW=1404MiB/s (1472MB/s)
>     Rnd write,     4KB, QD=1 , 1 job :  IOPS=9035, BW=35.3MiB/s (37.0MB/s)
>     Rnd write,     4KB, QD=32, 1 job :  IOPS=38.3k, BW=149MiB/s (157MB/s)
>     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=41.8k, BW=163MiB/s (171MB/s)
>     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3969, BW=496MiB/s (520MB/s)
>     Rnd write,   128KB, QD=32, 1 job :  IOPS=8260, BW=1033MiB/s (1083MB/s)
>     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8295, BW=1038MiB/s (1089MB/s)
>     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4609, BW=576MiB/s (604MB/s)
>     Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1345MiB/s (1410MB/s)
>     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1524, BW=762MiB/s (799MB/s)
>     Seq read ,   512KB, QD=32, 1 job :  IOPS=2799, BW=1401MiB/s (1469MB/s)
>     Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
>     Seq write,   128KB, QD=1 , 1 job :  IOPS=3722, BW=465MiB/s (488MB/s)
>     Seq write,   128KB, QD=32, 1 job :  IOPS=8246, BW=1031MiB/s (1081MB/s)
>     Seq write,   512KB, QD=1 , 1 job :  IOPS=1283, BW=642MiB/s (673MB/s)
>     Seq write,   512KB, QD=32, 1 job :  IOPS=2072, BW=1038MiB/s (1088MB/s)
>     Seq write,     1MB, QD=32, 1 job :  IOPS=1037, BW=1040MiB/s (1091MB/s)
>     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1540, BW=768MiB/s (805MB/s)
>      IOPS=1549, BW=768MiB/s (805MB/s)
>
>   After your three series (v7 + v2 + this)
>
>     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=7216, BW=28.2MiB/s (29.6MB/s)
>     Rnd read ,     4KB, QD=32, 1 job :  IOPS=61.1k, BW=239MiB/s (250MB/s)
>     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=75.3k, BW=294MiB/s (309MB/s)
>     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=4711, BW=589MiB/s (618MB/s)
>     Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
>     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
>     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1497, BW=749MiB/s (785MB/s)
>     Rnd read ,   512KB, QD=32, 1 job :  IOPS=2802, BW=1403MiB/s (1471MB/s)
>     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2798, BW=1405MiB/s (1474MB/s)
>     Rnd write,     4KB, QD=1 , 1 job :  IOPS=7411, BW=29.0MiB/s (30.4MB/s)
>     Rnd write,     4KB, QD=32, 1 job :  IOPS=39.3k, BW=153MiB/s (161MB/s)
>     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=42.9k, BW=167MiB/s (176MB/s)
>     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3736, BW=467MiB/s (490MB/s)
>     Rnd write,   128KB, QD=32, 1 job :  IOPS=8302, BW=1038MiB/s (1089MB/s)
>     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8314, BW=1041MiB/s (1091MB/s)
>     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4092, BW=512MiB/s (536MB/s)
>     Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
>     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1474, BW=737MiB/s (773MB/s)
>     Seq read ,   512KB, QD=32, 1 job :  IOPS=2794, BW=1399MiB/s (1467MB/s)
>     Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
>     Seq write,   128KB, QD=1 , 1 job :  IOPS=4135, BW=517MiB/s (542MB/s)
>     Seq write,   128KB, QD=32, 1 job :  IOPS=8307, BW=1039MiB/s (1089MB/s)
>     Seq write,   512KB, QD=1 , 1 job :  IOPS=1259, BW=630MiB/s (660MB/s)
>     Seq write,   512KB, QD=32, 1 job :  IOPS=2073, BW=1038MiB/s (1089MB/s)
>     Seq write,     1MB, QD=32, 1 job :  IOPS=1034, BW=1038MiB/s (1088MB/s)
>     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1531, BW=763MiB/s (801MB/s)
>      IOPS=1540, BW=765MiB/s (802MB/s)
>
> On this HDMA setup, I did not observe a clear performance difference from
> applying the three series alone. Still, I like the overall direction.
>
>
> P.S.
> Separately, as a follow-up experiment, I also prototyped an extra series on top
> of your three series that allows us to make use of HDMA watermark interrupts.
> With that series, in particular for the high queue-depth cases, the results
> improved noticeably on this platform. I haven't posted that series yet though.

Thanks for test it. I am monitor above recondition patch set.

Frank
>
>   After your three series (v7 + v2 + this) + use of HDMA watermark interrupts
>
>     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8016, BW=31.3MiB/s (32.8MB/s)
>     Rnd read ,     4KB, QD=32, 1 job :  IOPS=63.4k, BW=248MiB/s (260MB/s)
>     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=92.7k, BW=362MiB/s (380MB/s)
>     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3530, BW=441MiB/s (463MB/s)
>     Rnd read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1500MiB/s (1573MB/s)
>     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=12.4k, BW=1555MiB/s (1631MB/s)
>     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1541, BW=771MiB/s (808MB/s)
>     Rnd read ,   512KB, QD=32, 1 job :  IOPS=3116, BW=1560MiB/s (1636MB/s)
>     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=3099, BW=1556MiB/s (1632MB/s)
>     Rnd write,     4KB, QD=1 , 1 job :  IOPS=8748, BW=34.2MiB/s (35.8MB/s)
>     Rnd write,     4KB, QD=32, 1 job :  IOPS=57.6k, BW=225MiB/s (236MB/s)
>     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=80.3k, BW=314MiB/s (329MB/s)
>     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3878, BW=485MiB/s (508MB/s)
>     Rnd write,   128KB, QD=32, 1 job :  IOPS=9798, BW=1225MiB/s (1285MB/s)
>     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=9970, BW=1248MiB/s (1308MB/s)
>     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4516, BW=565MiB/s (592MB/s)
>     Seq read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1497MiB/s (1570MB/s)
>     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1571, BW=786MiB/s (824MB/s)
>     Seq read ,   512KB, QD=32, 1 job :  IOPS=3073, BW=1538MiB/s (1613MB/s)
>     Seq read ,     1MB, QD=32, 1 job :  IOPS=1573, BW=1576MiB/s (1653MB/s)
>     Seq write,   128KB, QD=1 , 1 job :  IOPS=3977, BW=497MiB/s (521MB/s)
>     Seq write,   128KB, QD=32, 1 job :  IOPS=9806, BW=1226MiB/s (1286MB/s)
>     Seq write,   512KB, QD=1 , 1 job :  IOPS=1404, BW=702MiB/s (736MB/s)
>     Seq write,   512KB, QD=32, 1 job :  IOPS=2496, BW=1250MiB/s (1310MB/s)
>     Seq write,     1MB, QD=32, 1 job :  IOPS=1252, BW=1256MiB/s (1317MB/s)
>     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1682, BW=836MiB/s (877MB/s)
>      IOPS=1688, BW=838MiB/s (879MB/s)
>
> Best regards,
> Koichiro
>
> > Corn case have not tested, such as pause/resume transfer.
> >
> > Before
> >
> >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> >   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> >   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> >   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> >   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> >   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> >   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> >   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> >   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> >   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> >   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> >   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> >    IOPS=266, BW=135MiB/s (141MB/s)
> >
> > After
> >
> >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
> >   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
> >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
> >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
> >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
> >   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
> >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
> >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
> >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
> >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
> >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
> >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
> >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
> >   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
> >   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
> >   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
> >   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
> >   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
> >   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
> >   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
> >   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
> >   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
> >   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
> >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
> >  IOPS=299, BW=149MiB/s (156MB/s)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Frank Li (5):
> >       dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get completed link entry pos
> >       dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
> >       dmaengine: dw-edma: Make DMA link list work as a circular buffer
> >       dmaengine: dw-edma: Dynamitc append new request during dmaengine running
> >       dmaengine: dw-edma: Add trace support
> >
> >  drivers/dma/dw-edma/Makefile          |   3 +
> >  drivers/dma/dw-edma/dw-edma-core.c    | 215 ++++++++++++++++++++++++----------
> >  drivers/dma/dw-edma/dw-edma-core.h    |  42 ++++++-
> >  drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
> >  drivers/dma/dw-edma/dw-edma-trace.h   | 150 ++++++++++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c |  39 +++++-
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c |  17 +++
> >  7 files changed, 409 insertions(+), 61 deletions(-)
> > ---
> > base-commit: 020f6d8442f35105660a29d0d236d3f8650c8142
> > change-id: 20251212-edma_dymatic-a57843ff0dfe
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
> >

