Return-Path: <dmaengine+bounces-11644-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SYOcA0ptNWpZwAYAu9opvQ
	(envelope-from <dmaengine+bounces-11644-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 18:24:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC06A7092
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 18:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=T70NI01l;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11644-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11644-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9E003008D20
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2E3890F1;
	Fri, 19 Jun 2026 16:23:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D12C0296;
	Fri, 19 Jun 2026 16:23:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886189; cv=fail; b=fV0qKLb37cqWW9LLtfFWEeJCmKzhiTpqEXEXauHQ3mIlyOnxWhA+qrgWbf7fkV7gooT8LA57TzMQJaND/mCTQUphngR/t3RpRIW3FanU7x1WTM6VL8EfNpivC3msbkFst1758U8cgoqB1ZwFLBfqTgFM5nqtFUaLMPkps/xwYAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886189; c=relaxed/simple;
	bh=tNJFFHXlg3DsSOI+ipTA1VVwOTMBl4L+3ua+Jdi5Q4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DUT0iSx0hvysyuJYllM9wCidRlhLO5wjulrJf/z9wBK/1InMJhjeWsf8myTLNiTtrBIPhdU5MhYDrl5TcgOn+NQA+IuymCiNHDkZtni0dGtDTLpSobTijgeKXTSKq5NL7w9uFE2ex8sXeOPXcf0vnDDTikt464B91/eAoHQdz1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T70NI01l reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8shHcClg5+R671oC50ORmzznRq/1m5kSKona/MFtuVK/Pea4m4ee3rPABFaJRHV8dbZVAEV8tETSwYzuYJKgW7dQ/XliQhjmG0U8WILj8aS1OyWgEEnfQ9dj5xYcxkPpNH14Hcn5hqwwmBrUniTOfAUv/GQydJCXaHWu5VrnGezowMe6t+H1DGeW8clZ1yP9Ft4xgUNWejzWMwO+HxU422L1pnPWBmKTrfNJ/xw8Au5voZou0QsCgq8eS9pYbPBivFx6I0RsqAGzcWNjZOjjre6WsjPfJqgB1mD9YyWR71rnSWHMMaAQdoG7pxj7U48xr2AXfVdWvUOhggIRcmZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyEXtkulEBG3RiyB3zT4WoH2tXU9ehVl3KXL+YUZOjE=;
 b=Kex9aaGU5MujCODgSGoNpd0rMucQZygeQxuVCxOoTbJdS2dT8ANhvIKVzQlMSiG6R3nJ+R//SBpwCzR/rIf7mcIftddcjN/aBjL8JfUsGUol5cmTxIzjwwiR3Z86WsIwsBZnvco60VVOlLo5bR7VEEV1WgEouolpN63X7MHP0efJWOB/O0AhK4cM1GDEQc5loIEmS6Sxzq/xVEPbdYjJrg8Vo7WUzWjE/kdA34PUfPgNwfi26BWHdb/UNJ8Rx9C5pVy7KPtTi7VrXODLWoIEiEk9ZPe80cSTGPDkmKuqE+I527HG/Rdl4Uqs2xR51LFcJz2gMlzNpKX8WQ5NttgWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyEXtkulEBG3RiyB3zT4WoH2tXU9ehVl3KXL+YUZOjE=;
 b=T70NI01lzXrhLUOhl4qtdGt5gpTKoE833zFtwko7KIjZKZcuCU0Fwbh6GmYVxum2ScHag1DN8XGXSUjvFdg7/kj6SVipVnPInQgkktJSRbHYFgBm9x4MTK0PxWR8ZBqg092g2QDCzcEJVxr17/UUDVzhNbg2qamPTVN3FYO2wCVogxHpy0xqzhzpA9+Uyq9bAEUBfUFfRxXJSDO6zOh+jJ3PcaQ5XVw/Ce0/ZUHWs9gKr8c8Ep5XvuB9JJ/Zk0nmf38YIFSJzEoMdCB/m35yF8a/mf+tJjwd/cg1daSgDcefjmttCofdqJElj/tDJRvq2+uMzWwx7KGUrOjUs6LtFw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 16:23:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 16:23:03 +0000
Date: Fri, 19 Jun 2026 11:22:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajVs3jwoxq7Jhop1@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQkupPzv8-GdEjv@nsa>
X-ClientProxiedBy: PH8P220CA0051.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd41d56-59a7-48d0-b357-08dece1f09a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|7416014|6133799003|13003099007|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Q/wW6UIxdtxf5sVa53Ydnb0mWcDSdx36NT4cFf7VkDjZkr+pKeMuWIHW9jkeuS3lWn3B22fPBSEBqA4OnJL7Kq/yfpgyc/rdGDcsTlp58SaP3iSrMSbMVYiOVTO5a/iy3MdSSMi93XMUpLjhbYFqY8E1/WT2gUJKhVsPGB6uUOUQc7nqX+Pw1FI2Z5QC3WjiAzg2+lgvyfE1E/ExlBIZ91tkGLZ3SpQPHkpciuaXKLiWY6sv1dK3cSyeFdqLqCJAWxNC2Pg8a4CxpSp97vDBZH2we1l3yqBhGeLmNDSqzJf9CYmDouC3itQLoT879p0zYudGAYd9PEibQr1dKmWAtH+uMCXFBq1O74lRHf+Buhr+F/Dmb50st9tOqb3i9uJ974eKnv7nVl8LYF5Usb78O1fHYPdeWfeIds9Vj9mcwX+DKV+x+iHo8G/gspOgjPFvpSKwfUN9I1CAO+XRayem9wh8tTbI+yterz/OoG3nJub3nmtvrw7iocDHSlbWntXWB88L3Cyf1IjlM0dALs9MxWo2R0gcXtUcYlKDLOsoV4YK7VDBUxyIbHtI9xqeAylS3ea2J3rva42gRwZRzZPG+pRT15P1zoG69k8oABOgudma2lwLK4FQVVFHpNbNuUPH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?nYbWX1dC41Ove5UTZi5qh3iz2ip1UnYmtcifkvjPWpTrGGf1R8YnR1n78p?=
 =?iso-8859-1?Q?98uWSIZiRC/h3Kpe3qxK84C49R7NA6HIlwMFQX84fMXZMCP7oN++bT7bMe?=
 =?iso-8859-1?Q?tZeG0IslfeCB+0FutA7C4BQkFfXFCz/SzhNZxVZLbL29rWJDsOSZfZuzf9?=
 =?iso-8859-1?Q?4eVf9Ha4ga+PYJ4+PODo/Bt1+3Q/MQw+NBn+cTKZBS8QNa68mpHzTn36qQ?=
 =?iso-8859-1?Q?R+OodxhmMUil/Ul81ARWVFXEdc1ufhDmKDFK0TiXTjXa7bh3crjYDCRAQ/?=
 =?iso-8859-1?Q?0pRsnJJk4oy8QW5fgKkm6zYQT2HWb/iiEjqxNdFVY4eo2er/PlunTa1ShB?=
 =?iso-8859-1?Q?lWLlyVBV7w5jq+0vwpy1eK5MW2V+tEWCoGgQdGuQNxmCidPvCkv+6PAkcy?=
 =?iso-8859-1?Q?y0ZAY2M/c+iQuBQoK9TJN+qIOS1NNz66iOIyF2qeaCW/ZBmU2hlN26a80f?=
 =?iso-8859-1?Q?Y1Aq5kaB17kXEPNLzgpjt3Hkp5e3g8MeCwuOZ051xEvexoXrSWWU2iIgDX?=
 =?iso-8859-1?Q?+x25xWtkxrtHlRi7iXHw6y2bZHdiJXWhNDweB8hwyToyEXioSZxU4KxRF8?=
 =?iso-8859-1?Q?Z3uNx/LtQ9ZgtCaYTP/xUcfO42KYdmdaKJJ0mo2Ri2a5gMb2MI9+/f3rcB?=
 =?iso-8859-1?Q?l+Q9sZlIFlzsuM7XwSlG4KXhcpgJAoSTR4ixv27OD1JAzp6/APWO+kTloK?=
 =?iso-8859-1?Q?J2Z1z/IEoJzxAdwVO+OXL9fO07Uivh9cijiqTc8llGep+/2T31GuTa6LNA?=
 =?iso-8859-1?Q?KQXxNT9fp5YsXykS8Wy6gJZC/LBzGJcYc7T+ewmXAIoG/nge+KSXNfp2NV?=
 =?iso-8859-1?Q?kcVT6QLlEvdL4T5jEes2wqU0F1HZXrXPOrTKzfmo8XUMlN7w0Q5IoZ++54?=
 =?iso-8859-1?Q?HqacWk0WKMf+Y4Sva4G6zRX3S8I/bplj0a/8CoXTduCGlyvl5xLrVOu0bj?=
 =?iso-8859-1?Q?8wHNWp1MN+zYey0dtt7iH9X27DVK0vB4Ep1XmgCaNa7o4o+mFj9oWAePRj?=
 =?iso-8859-1?Q?EAMsWxjFMNTOy8vPFR91BrcN0pc2X7CiaLK8RBfAsltcgkPqgJK8BLs9No?=
 =?iso-8859-1?Q?yXtYXZ4GgS6axvlz6ZyceX4YUIkCxYG7Gs6qZO+BlFSV1vt/sQd8IPEv/6?=
 =?iso-8859-1?Q?5APDuxbZ/iKWSmL239QpMWY2/9WccGuOGuroW/2mlQuld/HM/Xy0BMqsNi?=
 =?iso-8859-1?Q?74woTGejVLbmof6SNRKdhoWkXsgqkgVvAkckQfsJgpzqdh3C485nN7Ms2E?=
 =?iso-8859-1?Q?9bwOqiUNsN2WrIX4wfew+xr/RA52QdZpyr56AQHTKE35Syxz68vs8SOJ9g?=
 =?iso-8859-1?Q?oZsTVO37L5HAIbzy95nfN7MBk0/UM1gL3w71sk7UxsQ22gNHVu7HYmTbvv?=
 =?iso-8859-1?Q?YFgwGHsX6TsnbKiPQhFbvX2psCxptiV/k4QJgnO6Nc3o+4++bxQaUHap0j?=
 =?iso-8859-1?Q?T7z1qi0M00KQt4/SJ/wbfZqu6GzXUGZk4dZcutnF6LeG7xEJgrjapMUiht?=
 =?iso-8859-1?Q?RJDzvG23CzTjY/MMcbVDG54vJTQytX3XLK0rfPyy0DspZ0zhVfqXWFWp8u?=
 =?iso-8859-1?Q?B0lDkIgJnz0Gztb6v608mSk5APuNRywAcEAOxl8JsENrSpLOOMDy2EDBrD?=
 =?iso-8859-1?Q?EYI+1/7/JhbnmuLcxfIbki8dMLGMvga/rUYJSbGIPL0804dMJ0/KTJ1btI?=
 =?iso-8859-1?Q?hyylzVUp/O3RIAyLO5vyoA8YhJpQpVZ1unnTVfMYOQ4L07J8/O++SYUEYA?=
 =?iso-8859-1?Q?tPQN6IkBLHPGXyYuzTC+cG4gD3KlId9o4dZKM/gqkiMXxBO4GwVEWcCZpq?=
 =?iso-8859-1?Q?I1Jsoi+mNdqMDfb/pzybUColjo8VztEJ1jsRitvhM3OC68RHPr0u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd41d56-59a7-48d0-b357-08dece1f09a6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 16:23:03.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGtYVS3sdQdIdnC+B7NQB9sAY6mg+Qog48OlMj28dC7HB8vV9nu1xDF7DYAdKtw7RYUMV0cWCaMeSsG9RxMKsBKx/BS7WAvTOezdUwft7gASl/jQL6hj46H/AcXO23Zb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11644-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SMW015318:mid,aka.ms:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59BC06A7092

On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > From: Nuno Sá <nuno.sa@analog.com>
> > >
> > > Advertise the source and destination bus widths through the new
> > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > BIT() mask. This moves the driver onto the representation that can
> > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > be removed once all users are converted.
> > >
> > > While at it, give the channel width members their proper
> > > enum dma_slave_buswidth type.
> > >
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > index d47ff27e1408..19c258d511ca 100644
> > > --- a/drivers/dma/dma-axi-dmac.c
> > > +++ b/drivers/dma/dma-axi-dmac.c
> > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > >         struct list_head active_descs;
> > >         enum dma_transfer_direction direction;
> > >
> > > -       unsigned int src_width;
> > > -       unsigned int dest_width;
> > > +       enum dma_slave_buswidth src_width;
> > > +       enum dma_slave_buswidth dest_width;
> > >         unsigned int src_type;
> > >         unsigned int dest_type;
> > >
> > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > >         dma_dev->dev = &pdev->dev;
> > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > +       if (ret)
> > > +               return ret;
> > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > +       if (ret)
> > > +               return ret;
> >
> >
> > This patch is okay.  I think most system only set one width once, do we
> > really need pass down arrary.
>
> I think so. See:
>
> https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
>
> And likely there are more. To fully support all widths I'm not seeing
> any other obvious way.

I need more time to understand why need src_addr_width, which looks like
address alignmenet requirment.

If it is address alginment requirement, only need lowest one, like suport
byte, must be support other alignments.

if it is total address space, which should be controller by dma-ranges.

Frank

>
> - Nuno Sá
> >
> > Frank
> >
> > >         dma_dev->directions = BIT(dmac->chan.direction);
> > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > >
> > > --
> > > 2.54.0
> > >
> > >

