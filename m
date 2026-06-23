Return-Path: <dmaengine+bounces-11755-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFeGLAmVOmrnAggAu9opvQ
	(envelope-from <dmaengine+bounces-11755-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:15:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAADD6B7C8C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=MEpsB0Mw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11755-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11755-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE75301A905
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4F381B02;
	Tue, 23 Jun 2026 14:15:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011011.outbound.protection.outlook.com [40.107.130.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FF37EFFF;
	Tue, 23 Jun 2026 14:15:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224106; cv=fail; b=lKRO9DCSKuA11urM6WbIQB461eirv9JJSPz/IqIQ/n//+FTrqABm8In3wYmbt1JHPKByvaSoUrXB4hLsM/HRT5bIoVt/evFqVAYpwEc72ohR94GONhNGbg4MvgzW4NQDmo1gPmsuwyfgRdPgql2U+Bqlo/HmCDKCZywaZ8d53mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224106; c=relaxed/simple;
	bh=Au9pCRq3c2GSRGVFpiB5aXvF/t1AXnY8TzE7Se7PNp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndfHJXHK7kffHzj6mrcl6TpLnqxO/goQouo2RDw7i3mZiXRaAoyifd8lrTInC2nPm6GWVG9ySg+ALVLiGcyJ3mRcx6ersixDmiUaL5l6B2JYngDIWby9vCIK5PO/6YQMTerSutffz/pPNPsRGWFbmikUBxh2XpsE9FPZwPu/uj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MEpsB0Mw reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJDbIgo/NQBwl+zmFTw280P/XFFCWuK4ZF5nYPo5hNwoDXwgvQT3UHqrzeUkprAfFZGH6a4FmCw6SoIv5lJqatLjAk7GnPMuQIUS6VRLnegHzh/F1lhZfPj2IHtl4p3ymiiLRCWn9Rhf+YuQC+93/dhF8vgM/NbxiWREegRYCcmVfwxtzPuFHMp6ZgtpS48sWvkc7he0sWTKi3Ujv+4bgxgRa2/GpUv12nRGR1IbXxPJxNrVqsaE78JaHDZ1ZXviUGGV7anF643DLbnQ68JemHz6zBn0O+yH3lOK38kPfBlv+3tqbpuJ7U5fPBDawBqiEPIICvRKdTgbUL6vjcXhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNpQqih9qpgGxXy+Y7DWGAoF4eDiToi2Zf6WBBOeGa0=;
 b=pFY4KI2L3wtKhlLr8YshJJi3JYznPijvaLZ1DA0ANvksJPXpN5GkRoe1NRrpX5QeqpRq1CPR2T+XZLxeHNvzpOu3mTsr0x8ex2fwM2MImRRptogh1vuH3UZAoFp/l8f3HxDT36ntoalikU6SOaTY5FW6O5dPR29oH84luIssmUDfgfTjxgQl1+4H+IYah1uIYi+HoGqh/QzOrrbM+tv7SPNxddGQxjX56/7UsAZTw5dR2CRS72uyOA3UorwjgPIAziUWbY6yPJXwjzPfsI81xBiu0DgjhOoONFvLuYcatPB8JhcM4qtoW4Or5U0aIjPSl/O23giVwNxwEoGWbCXtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNpQqih9qpgGxXy+Y7DWGAoF4eDiToi2Zf6WBBOeGa0=;
 b=MEpsB0MwSjmqHWBIO1aFMl8YmUGPuBHqJSo7y9ZQiyGVNbPtNk1Ki9C3NbyTuRNIQ35+9IO2KHhOPa91SgHfEe1PwAQ8zthZCRDgJK6fQ/qSS/IV0v7oHeW6XcfpWJavu3bGaFtWsFFQXJdWw/gFKo84IqE1AJXZHenuw1cabA3jizoaLKANjd5ZTsVpPvIstA6RH6R9Fs9uZ6g3+qMDW1GZNVV8qNbtmm9Qe26COZZ1BsxVmQpv/X554PYrNT6UVibse5YeF9DHAlbi4kOvojsTS++/erog9vU6BBeyhmOCcwFC44yDQWXHYJNOpgOp14SeFvBP9OfLyfK/jYK/lQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10472.eurprd04.prod.outlook.com (2603:10a6:102:414::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 14:15:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 14:14:59 +0000
Date: Tue, 23 Jun 2026 09:14:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajqU2Izs07cItJ2y@SMW015318>
References: <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
 <ajpfmQ6JID5rHLMF@ashevche-desk.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpfmQ6JID5rHLMF@ashevche-desk.local>
X-ClientProxiedBy: PH7PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:510:325::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10472:EE_
X-MS-Office365-Filtering-Correlation-Id: 259b396d-e2cd-4335-ecc5-08ded131ced0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|19092799006|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BJtlqVQL+e+iWJZHyMpBCju05lnBHDgMyfO4+EbBLF9zwkA1NSv0eE5W5H1xhU0g/f2Kb2GToMkIUvJsbv9sc5ncRLTZ3Oeh4bJ3VqmgbEglLdSCr6xlMmijKDaL/o6ANGoo4WtGZZme2ViwZ3mXRY1g2t0H/LLAAF/k1jmN4EZDb7sQ2h5rbkmXDVADHZtKNRBPK4pYDJm3qIPeelZv7UdXFGxwsMOHYCyFhzegbdHYGm+TncKV4P0y58ji176AYyXvc4F/ByOdFMXDr4OIF2J9hfcT8jECTZQpJ87pAckj4tKYEA6BTBHN3Nn+dMPKIgF8IlnB/L33V24N4suMXquo1gUBaDH7RtdoHHL8MCshCIflcXSjESNbnulRvO32SCkl++O2EivXtpaPANswrAsrFMvFkZ6T0bdqK0PLhyhOgv5Y/Id5S03dW/dBtPppDf2l7ceM9vmG6ewSSrjKxknD8T9fjTzmtTKJUkYdIcbHc9R/Wu1E3ldO/I1gtt8JYzt6i5Ulktd7ymyshzq6ya10Y/XZuKTXfRSXjEZCOs4IzmCj7ELA7MW098Qt0pqxgRmjKo9rmqnKJQa0jg2M6SfoWhWnrS/8qpuAndRRJZkDdYNOEEnRXr/lxHP6R2J0kSfR3VwJtRwgADBEdYolVGdfW5OMal7PwoOoFPbmh08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(19092799006)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5ekuNt4MMdnYxQfaIusEwP6gkDeXJ3vq8ZyKeUYv4oiiNaMcNX0biYxaou?=
 =?iso-8859-1?Q?knS10pVUSiLmbKB57hKV/bVoP8HQ7NjXDCQcA5ivBZ3IiY3JIFbTu6cux6?=
 =?iso-8859-1?Q?fztFVx91P3x52dcehpcXflr9EKNVV1dD45vBMRwL1GjysrE4QiMLax++IG?=
 =?iso-8859-1?Q?oZwRpaHNlYBOhjYNDmNPTG0CmuPCtA2wt57yMraYkbif4vslhXQqE1sMmC?=
 =?iso-8859-1?Q?pxNwET297SAIGz75XsuQ1MIP469gxXeLflvXHKeFmiGYcyib1fjL7ObgvW?=
 =?iso-8859-1?Q?cByFL+xvO6OCL1bAokf9amw+wFu9sgtrui+MtA7aH92SlJ+GD5XQEbPh4o?=
 =?iso-8859-1?Q?mZgnzxciNH9vvuXzpUBCvzY31Xt2wdNs0UadvfHZ8MEuMmfbllWlR+qNbC?=
 =?iso-8859-1?Q?t8FfjJTx2Ip+jGJf0MGJQM5sZTnl2yLIr6rOHwH2rWidkMY2xmSnJKL9J6?=
 =?iso-8859-1?Q?OyDLXvRll064qcJ0sy8SSpW6ZV8XzHjY0sFFgyMHAXErVX1qjVwsjaqS7P?=
 =?iso-8859-1?Q?1B0HJDMPLKeGEgkMYDyncR1zZ3iYx0onMx485kEQLzVsoWsvHtFv+FIDyI?=
 =?iso-8859-1?Q?jd3CZRQdpIAQoydGqVog/UhrDbtqmJnoHRPUnGgn6PWMiaUZrlPNJlteDW?=
 =?iso-8859-1?Q?7TLNXL17tEsWAcr1dSft7bWJ1bCoAprp+TIvHt6M0YqqzMa+yze1c9Ujwn?=
 =?iso-8859-1?Q?6ShaDoDhN+gPyoQxeo1nZUrfQQSyMJcqlzzghjaaGNLUik8owt+/pisi5b?=
 =?iso-8859-1?Q?vvY0tFvGkrC8URqzkONu+jcI8S6Mum/lr4DxN7VfF9UURgKr5vPOIqOFAx?=
 =?iso-8859-1?Q?KwueLvSEqEjIsjIFOnGss/LYgREOqsDlme4WKMU0kfY6rnaQbraL7nGi5e?=
 =?iso-8859-1?Q?K9Bnj5GOgvJF4nbxpEUgGrKTjutgp5t1caXMZFOV+IkhpFzZnjDcVT4l+D?=
 =?iso-8859-1?Q?qeLRpc8rqUsddFJSSWWM45sEX3ZEzy3lImimgZYrtgrPkLIaki7fQBdErc?=
 =?iso-8859-1?Q?GrqV6ocoenZ4CxuCS/v3vTbHqlNYU2lrBnAHvYcgQkfq3ZWt8A/qzxYfKM?=
 =?iso-8859-1?Q?hRVDjMRg5JFRgnLyy4xcgdRP1xFWjQvTtf294/Uad0zCKv48nwNWkxSvi+?=
 =?iso-8859-1?Q?4MvngLpm0gfbnzysjRvCOTPWefGHClFqqR9KbHW0qgaUvzBLnkUr1BzH+2?=
 =?iso-8859-1?Q?/XdPxjXGSNIzo2A5VBS/coUCqq7ThPPgkWs4PVZlRXHmku65+CUSDtEXJw?=
 =?iso-8859-1?Q?EZAVPvP4kgvImh2bjQTrP2l6vQwCutC3ZoVraepOIhPMllX5XZjBmFZPEA?=
 =?iso-8859-1?Q?2fY3IIONZ7MaKD2G3Tp6YzqgMVmERW3FAslf+WryghitbB9SsJlFAn+D42?=
 =?iso-8859-1?Q?Tq4yoKEkSGdU/I36r0XBk8T0N8rgXr3xJL1o+IuDE8pltHf3hwzX1I2DM9?=
 =?iso-8859-1?Q?b4fep6p8ZPBCWK7A7aqo0XakUznttMls1mlWQqsIpGw6i3mpW9FzNKuZVD?=
 =?iso-8859-1?Q?0vPWa627kXwfnN3kHFOWpXyfIn7N37YpOo5fCWG5XwzGO5rX24rZuks5tc?=
 =?iso-8859-1?Q?6MLa2j5gURC//+E4ErKH6PJa739sC+iY3nwqjEHsJoCzvsxCXnTAzttlkT?=
 =?iso-8859-1?Q?S3RduqKmJNXxZGOTJ0We3FUQpFLd7X7hlIz91+WLt7Ad2coj90447wVV/E?=
 =?iso-8859-1?Q?zXk8jch615fL1hFo/4EDg8HasjXct54rUlgTThE95CT7g9/9OS4WCWfvoU?=
 =?iso-8859-1?Q?d0j0kVbFtRAU0iKCbMGy3KOLCAkR8qCbEaQt9bTdB8ruoG4FcwKq7jga8j?=
 =?iso-8859-1?Q?OOaxCX7H19qNftV4RyYDkCG8n5InB8j+dAixa3yF+j6fOGOE5crG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b396d-e2cd-4335-ecc5-08ded131ced0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:14:59.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3J8XLYNyRKPnuE6ntgpPx/7+dR8aH5hsOoZf372spliXLH/1GhnOKcQi4tPMscuAo0br0Xkm9DYQNPchdUwZj4X49LnwADr1MXJ/4kxXgYiyVl4z9K/tGmZSinF9x+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10472
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11755-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@intel.com,m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,analog.com,vger.kernel.org,kernel.org,metafoo.de,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,aka.ms:url,oss.nxp.com:from_mime,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAADD6B7C8C

On Tue, Jun 23, 2026 at 01:27:37PM +0300, Andy Shevchenko wrote:
> [You don't often get email from andriy.shevchenko@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
>
> ...
>
> > > If support 4Byte, it native supportted any N*4Byte.
> > >
> > > So needn't bit mask to indicate all support bytes.
> >
> > > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > > >
> > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > >
> > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > >
> > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > there... The code seems to use the dma bus width to match against PCM
> > > > formats supported and filter only the ones we can support (per dma cap).
> > >
> > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > if cap is two byte, it should support 16, 32, 64
> > > if cap is 4 byte,  it only support 32 and 64.
> >
> > Well, Now I see your point but not exactly. Because we do have
> >
> > DMA_SLAVE_BUSWIDTH_3_BYTES
> >
> > and it might be used by the pcm_dmaengine code,
> >
> > There are also some controllers that set it. But it looks like all that
> > set it also set 1byte.
>
> But this might be not true for all HW in the world. In previous reply I made
> a comparison with MMIO accesses where not all HW that needs 1-byte read can
> cope with that. If there is some proof that this is the case when 1-byte
> DMA bus implies 3-bytes (or other odd number), I would like to see it.

Looks like it indicates how many data transfer by one dma burst, not
indicate real hardware bus/address width.

let me think more.

Frank

>
> > So your suggestion might still hold and work but I'm not too convinced
> > that having the array complicates things that bad when compared with the
> > risk of breaking existing code.
>
> > > Needn't mask each bit.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

