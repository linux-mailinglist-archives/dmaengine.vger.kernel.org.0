Return-Path: <dmaengine+bounces-11563-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yi0VN9Z6MWqtkQUAu9opvQ
	(envelope-from <dmaengine+bounces-11563-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 18:33:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B7692341
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 18:33:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=UdzyfRaA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11563-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11563-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A6AC309F14C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C046AF14;
	Tue, 16 Jun 2026 16:26:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74793A8746;
	Tue, 16 Jun 2026 16:26:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627172; cv=fail; b=JDSIXvxe5qGmEahbijkiZRP/KPg9V1riVs8PH0Kx0FZCeieQGynONsUh5Tzca55Y+C0hNvwP6XwZphu7vrsrg+k+tucQEPdEFEaiLzdR+HoKfXs2P7pkIIf6KQFxMqKFzs1WWaw55bjOM8+XzTDRaIiQwynVTL297v/DfScNfdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627172; c=relaxed/simple;
	bh=U1B/iaXTUffAw5jqoX+hBVspdEhhqbGHPgNkKbnKNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KuSpJPL1eF4wjxz8fgTk3UdKOd8qJiaICUzjXlqjPzt0PJleHtGIjfVuBE874nOnfhXyI0XwagKyklVeZfZwvnMi/Xcx5VqXYIhPVPzJcgak+NCNCWIv7EcY4P/S35x7H5cwlKwvbNmBaonARtmp097/187ahaTx3u2xx1a9NoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UdzyfRaA reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFkmhcFQTf3P4gj0CMSjDKQo2FV6chwjZidT4Hw7+rwWXA88HoRRcXteJjWE14A1xe5d4nlMd4ZVVraU0LrYLqGXiNPjKw9d3rpwoT5o+o93JCFkvUlwrXrVSOpP9aS672McdbZyAV9TnsS8k/YeIwJJJr2BbDGGR2oufpXvlAYiNg/m8MPKy7WYdBqdWUZ2LcazNR2ENK21GE16GoBVEcQQQrrHm3JKDfYMB84/sNKZLs462nOFGplroM+jRuVh62ij6KokOK/SpyzO0oDZfA5ljD/LtbPs9p8P2kUzkpUNXBdkIO4SL5SJSwA8JP0QqGu8sa4MmTp+qRQjNgrScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HegdkIP32/KRhxAvMCwrdxGHhYdCfH/ecEOBihjGfR4=;
 b=RXbesdYyx3hbmrZZTKqAE7eJggFNiD+e21bsieMmBK8xXWyJw/7NyH58s32wkpwwqMqsFSCgJ7P1U0j+etZq+I4Mtc4zSRgUHkZefHuW6az6BGlW4bDABCJlBqSgMMvo66KX+qvl/2VS8GWSd1riYnIKkxcAKr3EjkgZB/Wnb0y95c/ovdND3F7Tnruyd3E1ueDBFMsJnRjOS8citQ0yzqkUkzh/T4gwfsEpfw3t1eMR4k8nBi1TanpYCjEzdy/l4nUKFLsyH2bnRuyprs8uoIhMZli5IKYvSCPccwe3T4W4Qcn23lkXgVNhPx7uQC0ET3zbVyxNWwmtqOZKYpRM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HegdkIP32/KRhxAvMCwrdxGHhYdCfH/ecEOBihjGfR4=;
 b=UdzyfRaArWNF/Kocogja6neG6FpHmCzDE1MBc7OBFSigOmkbeKUqq+QwmM5sufpC6QvSLcOqJGnJzG1PuzvYN5M7CP7bPzQPjdnbicIsuNC76Z+/20s/k2fJFwy6nUtqEqmQQc3RQFo8yAaayCOk7TzuOD+u3YlUQ5rnKEe3KsaCQbuSYZ3rXzFgdojUJ06jBq9Emg0UgAt5Z39fwIVewpImdTtLBtmRrMdKgGK/OcL9g2q51AYyavsNwYL9fGIiWRNY7weUrtY2sERzWb0zLT0yoR2ewO1IRVWcIgaMH+Rn8A2c1r0LoCskp05PcFRUu2efxnTvwevU/t8osA6zRw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9282.eurprd04.prod.outlook.com (2603:10a6:10:36e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:26:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 16:26:06 +0000
Date: Tue, 16 Jun 2026 11:25:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 3/3] iio: buffer-dmaengine: Use dma_slave_caps width
 accessors
Message-ID: <ajF5Fko3bWehuvYg@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-3-da23a8dcb756@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-3-da23a8dcb756@analog.com>
X-ClientProxiedBy: SA9PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:806:27::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: e695ead5-3688-41c7-b367-08decbc3f78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8cC0lbcMgZCjS0qGdm+xXzXbsGHJK5ZL7X9tqSy4rsUlT4jFsPKXgm83H/ZM38wNWQ60j4+oBwoDGVKL9EhNcKBmRDkNg6u1UBW3nxM1Ha0aSd3NL5UGPN5dX6NipCqAINcGsMkla6k5i3XPEhhb4450bkManrzQfOel+E+jj+K1PVoAlckw/W1ZB6RmO2uDIYSMfjAvBS4KzqBA7nmIyYO/KqSEaZnUsxcXgGZZIbXAfPnfaEmwnFasmCosCnB7qriARkXxJ42XdC+xfNL75OEdhj20nKIEXMOL/TfSSWaCIbloUPhT0G2XSlWtNKQZZjXBhNfPTfBPPVJZ4631TOOWWmNfkAAtsaRRDq5M5CyW1xwUClmarpeIbIcHokZyBKCYuj/g0vzZs+hoIYaXygF9pNZkUwcFWYCcnaEzMw9ubOZQK/6EAUsft462PP/Pjp7Z/HiYrSddr8TLJBzXwmDyTUGPNIvqdXIRYtPyllW7dtHs7DrAJhbv5bC5dmGipkJgR18xo393NM0snZND/knw6U0DjkUbkwCiqZTCqXT6CU0vOBPnCsXzVksL7NjTDfG8Ix9voKoGpEh9kNYn2vxTzbYrdk+Cmux5fVxcdxGyqa7XL0Oz3ZWlvUyfs1qE4h/7pNrRaztGn8jwBFccnDkzz0wYdQm83nQR2YcdojIj2rLqINnpRanI2tPS2omF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?35rj45m1ww7dtPY77P4L9c9hQN4dAQGgMZvN6zKGiPKh81SsKoJA0FeHrQ?=
 =?iso-8859-1?Q?KS3ynKyrZHn2+zWuXFMi+zSHEydLv9KEKtxTW6DoDrvPH33ffmbyferxSi?=
 =?iso-8859-1?Q?AGGHGu6wuEI6eec77XiBmXnK6j7ANPFgASasYZOPI3csXJ2q26y5Qd4RQX?=
 =?iso-8859-1?Q?ed3ZYSzrHNv0f5oWLMiQN0h0GK0yiQMfb7a8rtNQguBNZWzg2vbWswAMF4?=
 =?iso-8859-1?Q?BnWp4o6LhzFk0yqQnVbBG51uLvoDwBDseel/ITwmmlFGWTUdRaITX5Vz6t?=
 =?iso-8859-1?Q?EBnSIawLfWUTLuu/xwgSApj1Wq3C91YMhPsNZ+tWl2RUdZ9YUq3rfaFfSc?=
 =?iso-8859-1?Q?kQTi4+tO1zdfnvG5BaEBon02s5OSD/YdNUqWol02UO5y14WKQTA3kZrCE0?=
 =?iso-8859-1?Q?dIoyWselAHqy4cPna+OCUf/kqMnLKwYt4k/Q7pmdAzXFH/bVgZ/4xKdD+q?=
 =?iso-8859-1?Q?hYklrIeADq68wa3s40JpY45j4HCGVDgtY+QH1Q8YTsI7leg482tuzi+YZq?=
 =?iso-8859-1?Q?XV6fNnr5e9NW4rwCwR6vft/U7cbLPtt731mn/FhkqKzCATbcU9K93WZlr2?=
 =?iso-8859-1?Q?WJtB/xUI+zIjzSsjzXSHxRa9JxwRxuhRZp6xE+KtO8fwWL9X3sdMjVJAWa?=
 =?iso-8859-1?Q?2K6WT04NDQESWr9cWjfuQ6sKCusFfbZzwX8uxpDQqw0eWqMAmZDIXhopJf?=
 =?iso-8859-1?Q?UQ6r20MyeMQnv/+fH7EzgMbvIoFVrv5ke7j8vNlC1bv9dnK12EI0zviesN?=
 =?iso-8859-1?Q?qM0tceWO+sO7DxALH1vCrNEyYS+nJZBFkK+F3g4zVXawAA1K2ab8jGk6lS?=
 =?iso-8859-1?Q?Gkgo7cwFspQHsdnBf27LX/F50bazHv/adLQArOQmJSUdP/tionYhcQoC1J?=
 =?iso-8859-1?Q?yme1QQKmbHhmfdEIwN25ALhcf+FPfw4gSKjLWWlNn89m7Z+kQNk+66FYUn?=
 =?iso-8859-1?Q?KdyXhb2GNEB2iQRW/2jJr6Ds+1aAjAPqKF+ghfOOOze6vpQhUQjGOLNuV5?=
 =?iso-8859-1?Q?72mTwN/pOMeamvA2VPPT+Tc8i/4b1k+CjbW3RvhCwCB4dni1jKkggYN8E1?=
 =?iso-8859-1?Q?66R05GgFtZrkBT1M4Ik4usRqIGPboRO0CBTKqTBYgTJTtdpCO2UNyhihD3?=
 =?iso-8859-1?Q?RTQSQlNrfAVHzp8GhBPqAY/zpqtWtnjo/dUjkEY0yWmNbD5kc9e4m9om7N?=
 =?iso-8859-1?Q?fupNdH1nHFIDF5nFavFDtmFYdy+KlP//WTj+m4rlP1/od9i6Q6Xg8rpwWZ?=
 =?iso-8859-1?Q?djXBwoTO7SZpD9wtD7EFZW2a94HOS0nvA96NLISP6rZQoxlCDi2vyTYIUm?=
 =?iso-8859-1?Q?gGml1MszkSoEQNLiARd+mYFIpGzUJlv199ZzJmMDNE6r13X+OwjZu63XXT?=
 =?iso-8859-1?Q?bqDDpK+PEDyvy1E9QrfpU6ATwjg5nhP990CF5YU2iHBX/UKPsR6QCfcBPK?=
 =?iso-8859-1?Q?eA6hM38tRk2au+WI8vWOvGvEK18YDVW1G2e+G6TmihFhIvNIcgYturX1O6?=
 =?iso-8859-1?Q?/1Z6U+OPYlmtlIhC9uHKYM/17h/7xZ8ROj4idrBLxxWWe2Wjle8LXLDBzt?=
 =?iso-8859-1?Q?biPDxiZI4r1zxY3+PxmXNk+/efX0SZbKwDsBveyfB+oT/xUO/aPtaDxMRg?=
 =?iso-8859-1?Q?bA7FW/WE7o6cBbmxiD+17rNp70rWWuj6h6nwLrsvDDtiQvN9BnLdcYRqhf?=
 =?iso-8859-1?Q?bTprtDk/GweICEFFvaSnkkk02leELlL2BJ+QxHxXZSc8IjlAhGfAnhcsHr?=
 =?iso-8859-1?Q?u2seDu03vqKn3ZV69kUfjCyBZ81IjI3BKKkllwtwD2LefkYaBEYtoUacUd?=
 =?iso-8859-1?Q?ygS+CLgKwh/XttGpTQza9NfAtxTu+MfS34SH/yKqVg5ufu4A/P72?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e695ead5-3688-41c7-b367-08decbc3f78e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 16:26:06.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocTseWTdnWwfGqCixCbKzuUZfVjNI5stG91mRLlRGpbUhoINUIqqnzaCJFAIgf6NIWwVxu/2xyALjiHFtnjAKUuiIjaCq6ehIhi18+4hHQNiNqjKm1svXvCjaRozt3k0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11563-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,nxp.com:email,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D9B7692341

On Tue, Jun 16, 2026 at 04:40:54PM +0100, Nuno Sá via B4 Relay wrote:
>
> Query the minimum supported source and destination widths through the
> new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
> decoding the raw u32 width mask. This keeps the buffer working with DMA
> controllers that advertise their address widths via the new bitmap
> representation.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 98acce909854..855e3662cd3d 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -229,14 +229,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
>                 return ERR_PTR(-ENOMEM);
>
>         /* Needs to be aligned to the maximum of the minimums */
> -       if (caps.src_addr_widths)
> -               src_width = __ffs(caps.src_addr_widths);
> -       else
> -               src_width = 1;
> -       if (caps.dst_addr_widths)
> -               dest_width = __ffs(caps.dst_addr_widths);
> -       else
> -               dest_width = 1;
> +       src_width = dma_slave_caps_get_src_width_min(&caps);
> +       if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +               src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +       dest_width = dma_slave_caps_get_dst_width_min(&caps);
> +       if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +               dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +
>         width = max(src_width, dest_width);
>
>         INIT_LIST_HEAD(&dmaengine_buffer->active);
>
> --
> 2.54.0
>
>

