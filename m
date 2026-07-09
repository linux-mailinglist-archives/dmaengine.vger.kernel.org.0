Return-Path: <dmaengine+bounces-12231-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dgXyMcO2T2qsnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12231-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:57:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC76732893
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=aR9RW7kg;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12231-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12231-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F95317BF8B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8675C336EE9;
	Thu,  9 Jul 2026 14:34:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5632B134;
	Thu,  9 Jul 2026 14:34:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607654; cv=fail; b=JDuSnA+S1+URDYalNnXK5bH7r2B7emn2Nyj1wulzTOZADd/C0wZSbnE8upajAcT4nItMo+IhdchBl313Rtblt1vru5QY6W7lMZWTV17LNGjWZUHuV1e+V7zF7kZLLRsU9gEr/nupBKCgTYZCCkRL34tOUMD968ngwVFRnQLFXTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607654; c=relaxed/simple;
	bh=gCzl3W/fed9R3vxGkXTznyXJ1ejTut89/UfDrIAyigI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BQ5D4sUMMZ7i14Xqeg6HSdSn0jnRa3/S6CqlY1H/LFixucZYEjWKb+h3z52KdCz+DrVx6bPZqst5VGQkAqDH4Hqmb3apFDaw+2VTi3SJK0J4T8mTfcGrESG8okWUTwDisMXv2Ur6aFRNlbNu8BdXvacFGs0I8N4w0mlQiv8TRgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aR9RW7kg; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su2xPYDd41jEUYY8eUimQyKDb3bVl7SunTAHa7a3WRU57g2h/aXd3WLUCqIfhfkvvWXZwWTiLDZ56N4fr+yXrj1waHQHF4tI/x5AFCf8adQy1V+ARio/Gb9CHC1tgHhG+JqIypMZrOpQ0ep/zLLugxdTPvDNi8gUsTdINj6YmGZjVcP1/e1QeBTOBjYpayIBEl2Dmv4G20KISHw4+nsQc4XxbCUIDwIrpDU8pFaT0mzj5Ukv8Nq+KplVcOZzrixeMa4Hx1BLJtnZ1Yf4LnlV4k6LFZoA0B8KMPqJGZGf3/ytpSO6mV6rWAPPzABJyvoNMHcD1ygkOYtdFo7aO/nMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW00tJNIshy0xy5+FQFD3GiaAM5NcjsuhlRNaGxQr/A=;
 b=sJoluXDt52Z2hkcuZOh1f22xK+QSlbe3YJLT7VSzEMM7MPkdlCh7Oq2nGcuyoIHqUBcnG0spNK+CHmC75FCReOGQjccit0NBa/NQFWJvO7NfhvxoN2CyZAkEAK2D+m7aw8k7k5B93cYLjlMcgUck9wl2C7XhdCbBN+TWdR46POIemNAUopmru4y+1ymecIEEBryOJY9HL8fTB0rs0smBvYskpZeUnVvpMSy/1EfQbYgBlADaES0pLGJ1yKL0oMxufcgKpTC8HDnESx5SbEcIegUCSXwjefWYSRKfhMeFbmvJPzpBVyO/edSJW2gclUpTkpRe30hexWeFkM1FWgIemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW00tJNIshy0xy5+FQFD3GiaAM5NcjsuhlRNaGxQr/A=;
 b=aR9RW7kgWnGYMnkas0VpFw2qKfG7mFRZ71lQ7mY59Bk2AAAKFEE3HEj5Nb5rhds+WsCdOvMWKuV+qewzmd8QN7DisEhhVP+ZbDyym7nGG71Jah2Tske0SvDKLSVotjpSMUvLq9nYaQZ4Pp6cxlqkc97lJAymhvagoSllQsjkrub3m6GeBf1XkrQ7G/0zOSa+kzSTQFBGQRhXOFUxZ6D7MmnPMKrPDtVl66MBXqgSN6fUbX9K5cgQ3xSl7GOngOzI+lzaQbumvIln5aQK+1FgR6TXzyMQ9p0UHcaj2I/+hPjoh9Vwc696xZNZZQ0OTNzKxDd2yUtxSWxd4HwIYja34A==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:34:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 14:34:08 +0000
Date: Thu, 9 Jul 2026 09:33:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/26] dmaengine: fsl-edma-main: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <ak-xVi5t3u2ajnMj@SMW015318>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-2-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709135846.97972-2-panchuang@vivo.com>
X-ClientProxiedBy: PH8PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 831a35d7-60a7-42e3-bc38-08deddc72250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Adlij8mcjwkpxP7jKgjDEDp8cqGiVX0j9i+8/4pBPacNJ23+7J149DjgmUw6WzGR6DuqVHpimHmV3qRGVZQP2dI+gfyiwc+0gQdkOhLpFNbk0JVlY5UKaLbVn0pmvIfegN7nwxVExv7iM7tca1L3mckgs6Qmh2lMH6YR+AXr+MAvn6+mZQ2WxrxnmSQwTjg1VQeRva0XD1IHjrxkHceMPHEQ1dz2VpBh5OsoMT2SvcWOFpN29BCaglS/WW9DxaYRnT8BHbAUdbVHqDoOET7JGk0GDqOrQcITxaW2Oyuz89N8ZcJCakCzqFPqLUbsS5GXyFsuDKgkgaS1Zx9pXr/0f/LKATF1pimxY5xB/fEMPddbMOpAt6Xs7l1h9bwDrfUXOvuo0aZWx6dpuGRAFtHybNxqIKvdyeFcGA5eJMYp1VLNf5rzV5jmc9oOx5snRWhkhMgbmoGJQOhaKdBt7/9rEJTk6mnhq/pS2NNfF90ZNbnpVdRVzCLmqQ6tHwcWXmuD6H1PJd+lMviExlpF38RYp9yr79s1fOG+QMJYsaZNiMPRTd9cQH2TjmRvNPE5qxOi0yz19M91eJhex2BZG0W1BCJLxwZpQXTzI2xdSqQc7EfSkTWUVExpYsa7MWUyQ9Ak0Uvt04waZLkDGH7cWf8DqNgUWGCZE4eKcXRQAO/eogo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+MaEv21Uq16C0ffIhlJmunAqnoJpeQUGYRiSoO067+XYeSAg2rShLXTlksVR?=
 =?us-ascii?Q?Kch/7TT+Ep0KJoH6F92SwODrmduHK7j8d3njecX5IjkM/PnHneUbvP0yva57?=
 =?us-ascii?Q?NEnTU14P/kBxZe87BUJ6YQRLko/Ztx9IcuCeYpxzeypPpEck7u+ONkCyXOeK?=
 =?us-ascii?Q?raTgDOxqUvXywI6QXg6QR8aJkC7IlXANjNmjktfeCdK671rGtnbhytpflMYR?=
 =?us-ascii?Q?F4f0VV72Y5jU6ujaiUsdwmCDQtb8ECuqQ9hIdt+OTaS2EkIdKMWWNab3Lz6q?=
 =?us-ascii?Q?KBhPNxhho9ERYxdckcQxgktGvqGH3Re0t2siRnESDq4tFI6TURzkxWeMq6oj?=
 =?us-ascii?Q?0GK9/0uOyi7XLZInpzRGfcDTcH4hnK+FtLgApyusRvC7E7tV2FusLAC+tApX?=
 =?us-ascii?Q?be8ozq7qHIY4UWWHHwTYY194LEGv7QBnX6W46q52nOPTV6NZU+uGKwzVy5ZQ?=
 =?us-ascii?Q?5M2NFqL1rUQ3HG4oK0osvnyv8Lksrrnmms4Z6SuAW/oC7U+HnJeSIm97jgAR?=
 =?us-ascii?Q?aBz9h5qcvg+wghVoc5B18JIB4FzivUl0vBu+vkvz998oWb0AMZ6A/Jb5KfKu?=
 =?us-ascii?Q?IZRV5KF/oYMkRcWgpMEWETBLXWIQwsXEZ/BY8XszidZGI5sqWsXnUF23/8sR?=
 =?us-ascii?Q?3Aod7ifTf0LcTx1SEla8kc1ezTKVgM7lMRiVH3X9TMDQOudmhABS2eLwZ3JT?=
 =?us-ascii?Q?xoZGxusB6lQcjjNNKuIgGq171r7iCjY8kExUgN+n8Mx8pqpP6wr6mBHjzXM0?=
 =?us-ascii?Q?/5xwH95gQYfXh1CdbRr4vMlN26FWkVt/i8JZJ0aX4UaimCPwVHMUiYueM8Oj?=
 =?us-ascii?Q?r+pfEsSdnATvH4EOy1Y4THkCZs6wWyLimgzyAmgT5ckEuTv2OAoxqQYcQSWA?=
 =?us-ascii?Q?If0TpOJzll0FQDyjl7R5ajd4C7awtDp4ZJF5G3tPXVyLAIvO0lNyOc398HDr?=
 =?us-ascii?Q?VGS2c/0nlZog5eSKCOnRHNwCzKjAzD5lG3HV6XV1QPhNp4ba7DIToasE6UBi?=
 =?us-ascii?Q?Ybs6ozDqdujKiHhHPSsWW9wCGTRosXW5fUhTo9/JK18XJ6Awhbf7u7XOUGlc?=
 =?us-ascii?Q?7WQtI8mrJ+IYjB9cWsuLLLCg4v8z2/cz+b+Z3hR+A/wv2V23/7zw7asGi7Op?=
 =?us-ascii?Q?AfmyLtMuNFvXUTYluDDc1F7Grg10siRhFCWQMjTjLcPJ+RYTm+4PtYc9r5aW?=
 =?us-ascii?Q?Uoc6Oul4Y+g1lJFQ3V1XHQIWLnW2l5R7+EknKPZvSBCsi6wQcHh/mqw1TcZh?=
 =?us-ascii?Q?d4UUmuCznrlgWKT6bPsg0X9FJyMLAcZdVIsSK+dG35Ps9KMWKzHq9eGg/fX9?=
 =?us-ascii?Q?zxoE/o2tZ8rTbeso7ne7srAw6Yaxb6KMtB7DNa7O3XvOQBiEsmL0f//4Cl0r?=
 =?us-ascii?Q?FfEWxbZMA628L66OHoBZK+eB1XgjdJ7NKqg89GgZPxwGy1LPNxdQhoW2xUTM?=
 =?us-ascii?Q?ihzih3u8oNNoJ5DXV8c5BdfhovzqW985bLCWYDf2meyRusFOu4DP0nbl7s2V?=
 =?us-ascii?Q?ddA/Jcm/TQYz6GLmTAnX3nXe2vErBXkCl2oWFeawW0TWgmXmpyRKLdTYBdAP?=
 =?us-ascii?Q?XtOgKuL+WH5iJcyAslr+HNwMeH6M0efSsMzLQmspjMgnK6Wn6xr3XWzTaWEG?=
 =?us-ascii?Q?vL7fePKNN80yvd5D0dVN4CWP1qs5o4eLiIpRFJpDZbw9mjGE8kiwJwvhN5s1?=
 =?us-ascii?Q?lGNfjDZZ0ie8FzvTie2mwyaDyrPa51SnysdbWIPPqRoC5hbLFKLiZN2+rO2k?=
 =?us-ascii?Q?sc8oA6cnlJYFN2Q7x5YR/s/KgG5FxO4BMR56KmKSHFPvIeuuHCVB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831a35d7-60a7-42e3-bc38-08deddc72250
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:34:08.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0p220NOHUJjFtXrE9pZcGZ9TfSVTr3P17t/qPmS8pYU5CBoqKWflaA9iCvZdqhNqsu6zFs9S/6LD+hSGtsIO2jf0G6/4uwKDuNhz/unxQGWeCd7WmVV7LvOp+nr4jD7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12231-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,vivo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BC76732893

On Thu, Jul 09, 2026 at 09:58:05PM +0800, Pan Chuang wrote:
> The devm_request_irq() now automatically logs detailed error messages on
> failure. This eliminates the need for driver-specific dev_err() and
> dev_err_probe() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a..0881f4f36b3f 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -357,24 +357,18 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
>  	if (fsl_edma->txirq == fsl_edma->errirq) {
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
>  				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
> +		if (ret)
>  			return ret;
> -		}
>  	} else {
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
>  				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
> +		if (ret)
>  			return ret;
> -		}
>
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
>  				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
> +		if (ret)
>  			return ret;
> -		}
>  	}
>
>  	return 0;
> @@ -418,7 +412,7 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_handler_shared,
>  				       0, errirq_name, fsl_edma);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, ret, "Can't register eDMA err IRQ.\n");
> +			return ret;
>  	}
>
>  	return 0;
> @@ -445,24 +439,21 @@ static int fsl_edma3_or_irq_init(struct platform_device *pdev,
>  			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
>  			       fsl_edma);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -			       "Can't register eDMA tx0_15 IRQ.\n");
> +		return ret;
>
>  	if (fsl_edma->n_chans > 16) {
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
>  				       fsl_edma3_tx_16_31_handler, 0,
>  				       "eDMA tx16_31", fsl_edma);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, ret,
> -					"Can't register eDMA tx16_31 IRQ.\n");
> +			return ret;
>  	}
>
>  	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
>  			       fsl_edma3_or_err_handler, 0, "eDMA err",
>  			       fsl_edma);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "Can't register eDMA err IRQ.\n");
> +		return ret;
>
>  	return 0;
>  }
> --
> 2.34.1
>
>

