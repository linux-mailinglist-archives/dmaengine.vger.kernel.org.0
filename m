Return-Path: <dmaengine+bounces-11646-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bFanK22SNWqM0AYAu9opvQ
	(envelope-from <dmaengine+bounces-11646-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 21:03:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 787CD6A771E
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 21:03:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=LfTcJ7ca;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11646-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11646-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A8630590AC
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FF23372C;
	Fri, 19 Jun 2026 19:03:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400127081A;
	Fri, 19 Jun 2026 19:03:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895785; cv=fail; b=MYcX7LvBR/i2q/puKxQMlBM5l4SaraMo8B3kImEesIobS4QV66mcMcYh9/Y4cDfikJrasQqShKVTort2JwN2gclCxjjZB46z0sj/tnnhUvCkqL68J+u1il+lWPV/JzSYpyqFeMCQALRuJHifR877ckLo6CAayOvQKHPZUkiyqFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895785; c=relaxed/simple;
	bh=mtiJ6iaNXYTinRRuY8LFe+Wjt0pEdBw+rok74qHxlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ulBS9q1yT21aQ822gbFCiFN2IzCL7mhQmzPmWOWmVOVLLpSdRlCZZpNw/BqoLEv9C8ZGLv8vrBIfuqi8KoddkW/dnCEUynXlJmeEV5NZnxRT4YALILzzYOIWzRIUyj3lUyMGZSOtYuvHML/JYawAUoAlHAbUYNIXK4LKJjnAo3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LfTcJ7ca reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7C6qk68vK9IucTTEvzZZkWQTFZyl5cWIagIjUbhUZ4iQkVFO940k/kK5egm3P42SgDX8A3Fny+7pveP1bSS2YrybP94kenarGBIltwhnD0w/qLLaQtax1R62qXY7JohMcd+lnogok0Kep5h0Fq9TbbUKehNeb7j/cxh4RaKeg9fLpJLVROO2zfMqKGAa6zTYWIKSk15hSIwECf9oQ4tEY/Bv3kHpWJEzAut5yoF1052iW8vKNlUdIQLZTxax9D/fCyyrwiYtrnIETwSad1UaA4bXk9zlbmpOkSYe4zHEwgQey1KCb4VbG8f7fibLBqioDZOEcSN2i/UyTOnVnNmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPm86jUUcvEy9ee+X7qV3bllxyPgUORB5VCaxRgM7AM=;
 b=l6wwMFUmcKkPwO91ohpeHv1A9QoSIk6IJ1EaPW4VyGseuGGqVQPKKraaUhMuRcXNPDTe+ytm2la59/vtH6dJ7xxcDDpca14/3SGAOjH5ckh903mOc1cFbVoIy8RwoNmf/q3VA/uUntzdNdaPSgL2iTAopJMp6rS2xHoRPnZGqWyOIeqaUrie9/hIT5vwlAopQXGlJM8DulUEBiStDpKxNAZNzxJA393scDEa7PUmKUuyoD+RaqN7pKo1TTLbfapXp0solta31ecu0jno9Nzoe0oSm0j4Z6y1AWE7U/0C55FdTZHTIYxK98Vl4dGub6zN1lCUR7Tl0aXM1CGHqbkskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPm86jUUcvEy9ee+X7qV3bllxyPgUORB5VCaxRgM7AM=;
 b=LfTcJ7cavg1UEl8Zv2AEIihGVNEXiDeP+2SgO4NWfFA6xe8qiJAms5HSbRgkzWPKLghdElmR1w7fE+nBZVOfEUjZpRVEUJYhU/FPgLVBmeb/k4pJEPVL7wEvjlwPaN3JZiR6GgTtpA7tfTnjINjS0cQbAWVPn1K+ppdAJ7UYBZxnfOXjz4qKU3qU6JYkFBwrGzHOIHyc3yfIoCF/TaVJBIC/P9zhXzdnKeE1+DNYPLAEHdK2OCZVZhpZaF4kHb2sQoYgUScBGnVvcD4Epka/Bw4HZfD26sZETPyD5QTUxxtWM1A/gRUt/U5lqrLSfeksivhCJkX+aRViNLyMgvYlww==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB9521.eurprd04.prod.outlook.com (2603:10a6:10:2f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 19:03:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 19:03:00 +0000
Date: Fri, 19 Jun 2026 15:02:53 -0400
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
Message-ID: <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajVs3jwoxq7Jhop1@SMW015318>
X-ClientProxiedBy: SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: ac55d3df-40ab-4bc9-551b-08dece3561bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|23010399003|366016|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	L7ZUDQ0Kf9p+KYw39pRSR11BIfGP4NCH3BKpNtBL62yqs/OoFQDoQxWzL0VT4JQwX3fIOXLWF5atOqhZ+crfVXLvoE00ExAI8+4u3mJ3wKCQXVZ2WF//dxYHUvhZgw4b2FF4RjpsRu5NviuAwe276PF53P9lo4m6DjnuoFXt3XLqg5gOl7h0ebFyjAPE2u8lBCAboEhTDkHCuo7TmASSsdToe4qQxcnglAl6pKsC8apHoqya/ExiRZoXygJPYwOn5gTMsF+mxFn6ByRQ9eVyOFlwC7Vt7CI/lDLA2DJYz02ZmmFNOKf1Cy9+Q7zfRyiBoAOsgeMEhM94Nds0ldcC8gzHXG+7hmnl9E9UQ9/Tr9DyHn1mzEaWNzNgvlJxmnvFoIlCVvPDKKSEtcbdaHQtNIjC6l0Rsu4/95oUfvcBhs5sK+F32xmWO2VntL+dwJRsiT2GhKVcEJsMi2F2iFQobA8+32txSrLvbh+BKAWVKBOTRmFWeDCcu+80PiPPtzG/yEEaU4YeOyfZIsAu+9ksfXkkx7FdeS4+Q8UsfQ8iFuNob6PDbtG139Thumyz2qfD49da2X3wD+MEzMcWpqwDKiBBf4ki+LTXjUS+30unlCOHYfLrsIWrGh5IhN5GDq9G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(23010399003)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?vIOVEM7yDzKPI7lMDuafomkHh778fnc7k9acTgqoxX2OOOIhq+mUsS8ovA?=
 =?iso-8859-1?Q?uqZ/AEMqJRt2nl/0Uz5w6GEGCU9841T1AtkCuQU+XPrv8l9hp2htnfNOQ9?=
 =?iso-8859-1?Q?3KJHvWIw0jXxIcVqligLyl8ziRqzGtef59IxX2ivBnBRotr2EAeAJsPvPO?=
 =?iso-8859-1?Q?/fhLjQE2+c6hvkeA6sgKD0hcoyJi80oA4qCvOxZydGMO8p9V0Cyrw61hU9?=
 =?iso-8859-1?Q?jIRaj8yvAWWFGD+yqiykUSK/M6jgfT2O71Wy3BeklLaPfoxpQnx+CnFgdo?=
 =?iso-8859-1?Q?BGLV8L5Nr+7bKpUnyig08XjLW6DtZi1uafQbG5hmu8jT6ywAeAaxZ7WOBZ?=
 =?iso-8859-1?Q?2Cynu/O4VGa5acQWwBr/90awSG/jYykO0KYx6FjByFH4VGmRTbj48sJj4h?=
 =?iso-8859-1?Q?MlJP9ymwyaqsPnKYvocTzsKCHZTig7zkWpH7qXogZJ168xDxunlSgSazA9?=
 =?iso-8859-1?Q?bsosetlzGk3Mpszi0UcS55Svr3CBpHJCAefwBho/x180wKZmk9yUqyS5Nn?=
 =?iso-8859-1?Q?BeQQG9wvN5ewKqb4Kvdv5As0AC36MD5wfgRH/9Wk5Sw48ekpmxHiz0mfr5?=
 =?iso-8859-1?Q?vDKLTDU53FjkwD/H3AFHIYKXD+6CoSSj3b+/DuzQwc5Ypz8J7d2AJDcRCH?=
 =?iso-8859-1?Q?FcEfDbeEZOj8D7COK2i/gTxeAk5epywQQkmI0hn1UCWTfDYf7XSf5ZFzAd?=
 =?iso-8859-1?Q?vz3JgkW2lHfXBkQwNJ5wqywuv3yTqWB5Q1Mkn5Bizhtf6hF4L04YkqoqgU?=
 =?iso-8859-1?Q?wXfnGU2FjmDlfNfmRMZa2tH5w+3XH4J6txnPqT45w8eRkHNCa/mhWPdMA4?=
 =?iso-8859-1?Q?96ytK1C7fRU0PNCiseXk3dv5qxBCpqX+VLkC1Vn92SRLM+P33y35deZh+e?=
 =?iso-8859-1?Q?bGIRmrjxC9a6NAEud/4qhyDge+qG+sn8OOizodKdHocqbuFs/2jl0B7oIN?=
 =?iso-8859-1?Q?vfy8jzok8n5bFN9Nb5tlan+pgUrenlKjA5OHfmO/iKzTGwEFdvPuHkeSZB?=
 =?iso-8859-1?Q?Z18zAAQcD1YPZwbMuu1SArVLC3rUmvwCVzYmlMaETayb0MEpht2cYrvY5u?=
 =?iso-8859-1?Q?7yki4yYCeB4M7iMUWBEb+0bQ5kuAbpr6HttfDzJxbVQEifBUgNsfO0pW+V?=
 =?iso-8859-1?Q?r71H43kVqkfVlkyfxK7Sr6hBzy6GXD5bMdwWqcfo+xG4T7W1D55oVge622?=
 =?iso-8859-1?Q?4YLZoX/O104KLSWUTzZRHmtge8ZImH0zzzyir9054lOax1ywZjyRUZHL3y?=
 =?iso-8859-1?Q?uq+N0Vb1jXEwhIrolAJkE2uJdIKWRNTK1YQ0xdwNxdFklcJG9nN5TL/YGk?=
 =?iso-8859-1?Q?iJZlmFQbbmF9ws3KIdcvrVfb1VAWNR5GuQFzQlDfIyVzV0Ut8AGNXAaTOG?=
 =?iso-8859-1?Q?eAMHqNe+cfOl7HgmXeniSdLuPf7A+raU1LUI0xUUT/h/S1e2CgX3Q2vf4V?=
 =?iso-8859-1?Q?bxDCPFFV9QksurAjfis3Moz2PIhPMRuCJBpzftBLwjO9elPPsxxrk62iyJ?=
 =?iso-8859-1?Q?kDYV86SrKGoN7YHeDwdMP7mQ5hBZizgcRZLWdN6uZSaGYMdHfKYp4BXgzw?=
 =?iso-8859-1?Q?K5F1Seni8vlqmkfQcH4qbSbL1rN1ndeqczcWOLWlyZZnRqT+LtwmYDdGLR?=
 =?iso-8859-1?Q?+b7NN8J0LpaGmI/CT2upihtGL/LFByuMxUGP23jyj+GnYYGvmz2Y/qPjqz?=
 =?iso-8859-1?Q?OTB1n/l9GxhvhwFY7u5LGrBHEjEI+iDXSbaSmYba4QDpeHHxONVhkaJEkh?=
 =?iso-8859-1?Q?rlOvCB3S/+u5CMQwJYavmjZaKILYrDwZzQr/uV1XrT3+TKld0Lq15Nyu14?=
 =?iso-8859-1?Q?3iqbQSJKJEhRqfUXFmN8H+Z/DbqHOF+Q9r6d9FRb1G0Z7uRMKN3x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac55d3df-40ab-4bc9-551b-08dece3561bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 19:03:00.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTUAWw74GIcA7cKLRUSyrVIUpGErhywjiuaq8smXHVy5tB/2l2vihb65CA1Ilj+27gmtxJ6lL/2eBY4Bb0iQELyxuMlnEPWOTYsTCzfAWoFTL+ez7+640g6D2hTooFcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9521
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11646-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aka.ms:url,bootlin.com:url,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 787CD6A771E

On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > >
> > > > Advertise the source and destination bus widths through the new
> > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > BIT() mask. This moves the driver onto the representation that can
> > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > be removed once all users are converted.
> > > >
> > > > While at it, give the channel width members their proper
> > > > enum dma_slave_buswidth type.
> > > >
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > index d47ff27e1408..19c258d511ca 100644
> > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > >         struct list_head active_descs;
> > > >         enum dma_transfer_direction direction;
> > > >
> > > > -       unsigned int src_width;
> > > > -       unsigned int dest_width;
> > > > +       enum dma_slave_buswidth src_width;
> > > > +       enum dma_slave_buswidth dest_width;
> > > >         unsigned int src_type;
> > > >         unsigned int dest_type;
> > > >
> > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > >         dma_dev->dev = &pdev->dev;
> > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > +       if (ret)
> > > > +               return ret;
> > >
> > >
> > > This patch is okay.  I think most system only set one width once, do we
> > > really need pass down arrary.
> >
> > I think so. See:
> >
> > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> >
> > And likely there are more. To fully support all widths I'm not seeing
> > any other obvious way.
>
> I need more time to understand why need src_addr_width, which looks like
> address alignmenet requirment.
>
> If it is address alginment requirement, only need lowest one, like suport
> byte, must be support other alignments.
>
> if it is total address space, which should be controller by dma-ranges.

I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
(I think src/dsk_bus_width is more reasonable). because the name is the
same as dma_slave_cfg, it is easy to cause confuse.

So far, still have not seen user case, which more than 8byte for cap.

Add it should only set min value should be enougth, if update only user
sound/core/pcm_dmaegine.c

Frank

>
> Frank
>
> >
> > - Nuno Sá
> > >
> > > Frank
> > >
> > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > >
> > > > --
> > > > 2.54.0
> > > >
> > > >

