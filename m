Return-Path: <dmaengine+bounces-11561-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4/11BaB6MWqWkQUAu9opvQ
	(envelope-from <dmaengine+bounces-11561-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 18:32:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731646922E3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 18:32:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=D226Db+Y;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11561-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11561-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C46831EDB09
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3221843E4BA;
	Tue, 16 Jun 2026 16:20:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860646AF02;
	Tue, 16 Jun 2026 16:20:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626807; cv=fail; b=ez83v6JXr/nl8SJCHayWgY8nGtiqLclE5YK639yRy0wcWMoTqJIF9E7wyr2Zphcw6dNh+X9p6g90N80jm25NfwQhit7uZSm4fJE4c/LKaTzsHOa3kzV4pdZv9oRr2QMjZveHDT030JNKtdTxsHJoXiRp2sZaU+/XgdePuMrODEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626807; c=relaxed/simple;
	bh=0tPVsU1mWz9wSmMUc82YdrO1HTQND1o57hQQsAs+9dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kxjQ1Im5CvJkxSmbnhxWDQdNKccdKo6WbSbS7EblCnWnoaLtS3SAOQX8Nz75WX4QZ0mk23U0z7PNx4rMu+YbrlL4WL3k8TEawpO3qh3Z7u4A0FhhRmoP1z2HuX0JDwn7qEMgPfCBOd/Ajym/DMKjdypCT6TNAeD3JRifT34UzJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=D226Db+Y reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIA3cau9Vl1wX0bgpRO4d++C+D9lkF0X8DGkoKOFrISSIrGr2QMBFtfn7RD+4frJAWWY+e6uP3fdqke92n5NUDfy6m7+dT4eZXb5+1a552J41XYFCm9Gi2O3IIzWJ5oNoksLC/wX8pAr+4cO1ZBf0jQPXf6i4VXoBhtx64PCrXO5Ud4ytTzKnavf8vTSpXf2m/SvLRZAV+8tuPbZuDlwzrwQqKUlKnainEaepA3WTxsGE96wZ+LlkSnBfk21z10YqVOSzkpy3KwjrcdvgpuhOiVBMOdhbvlEXe9sysl5pJEV1SIZAVqrP36nyDICgBBOJDa/jl50qoqLMIy1Ivd0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jL8SScgggZZDP8fe2pvH0oxteJaNYGAZGn22FZFSU4=;
 b=d38O2iDPXzMJYqoPqY4mu5RR7t1OTdUkzx6A8+/noU/WMnwIIcvP77VBDMnmFv1a2tRq7Qtn2R6gtON9ZuT5ram4l3i+vPMyKkGBz0+7Fg+2NbmDhc7Q/C1g47e5XfkiFPeK6NAkss8ojI5C5fWbF9w4re9rXXUrB42UX5dTuGQJCr4Grb17m82AsYMJC27qG8DLwFDuiiB1KstNYfawU6WFzNJlHPu6wr7FoVjoxxL+uMcLulBLxzmZkSbK1Ts9Ns+Ae//qJPD3juUQmABisqmHkljqeNUZPJVv6GL78O6LXjirr99TQexHukLjbNYKJRx4kKDrdNxXJ/iBXxoTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jL8SScgggZZDP8fe2pvH0oxteJaNYGAZGn22FZFSU4=;
 b=D226Db+YSaHm3Cvi89bO4ttjuQreIiIC+I3Vid9Ljbm9Bb4RlWAtYb8y2vm7W9i+Zy4BBkh+jfoNhumEs5zkCLX1Wvyi21i4e3pQMdro9C7fxMkSxcB5WSXLd5PJFVhjac6ud42cI+mCz4FYZAGVCc8Ju1a+bnp4+LenGAhMgk+9JTeazFQHHIaiU/LWVbv2T6J6iRTs0ErHJKGe3RQdfYVG+lQ4IV+fL8biZ2FzD5cyqmEDnPVANx1fWu59K3TkRC4oHRpdnfFU1bO4fVo2ik+hH3fbN3vSZ779B2IoLgGkO58E42nqQfx1mCKYPdS54xePp9S6o+NVQ/d1HgmULQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10773.eurprd04.prod.outlook.com (2603:10a6:150:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:20:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 16:20:01 +0000
Date: Tue, 16 Jun 2026 11:19:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 1/3] dmaengine: Support address bus widths of 32
 bytes and above
Message-ID: <ajF3p3Vu_pOx9z_V@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
X-ClientProxiedBy: PH8PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:510:2da::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10773:EE_
X-MS-Office365-Filtering-Correlation-Id: c913b59c-ec09-4bd9-21ab-08decbc31d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	iOSatcJ6P10gR4Mc4bYfI+P01G/ZGitK7ad4EClAgLc0aWouaC7W24iepyDE4z9SyfdGGHccGuBDOtFcZEeaoC6LC72KHYUTD8LTpGpHIWExqu56gehbk3SFZKhP7KOtux8hdwS0JfcAaSLHSko8PriHi3A8y9dp/rAwijZXMnFxlarIPy5BdIqhxWnR/v3Oqr9nZB7IpD+NfEZEukUr7vNlfXgrVIh4+msFJ2GYeXPMmyPNcEJCwUKbnj1c10BWWZ7M4adgTeDK5G9VOpJeJy+eJz715pmq3nEe0spjAFNu5Y7R1VsuCVCcv3JR6htJCCzBtOIXlLl9tLkyNCiJK0EGyN1uuF5cvVpqe6OYwf11A+QS0FJEvEqihL7/m+QAliqbOd2j6Q8vYZKHBwfThmkLU1wYjhzRPf9UjEFE3amjJORJXcy9x3yPHUKD+QsHPn9n0GDf6feNbRmkftOONTeODFvD9hfIpGNcxgAcO6W3MvRdDlqnWuK+zSODbSy0feH2Be03XmkqOh0pr58uSG5hml+VXgcDHMyGzt0c1WfRlJJs0NZF29O1BN4z56LevPqiuAbMVbhN8xcdCIS15odEbnRb1O8HWW2j+oCLH5VyKqIDfc+VgGlF2uv7egKbVSx9kLuVgnjBWKVfZ/aABYYkF+P5PXzNHRP1w/wCnGb25ZNtHL5gTAT30yCFP4Du
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Eyu5QWhuAW3rzXdV2Fv+Fhy4dAXMoTZece7kKxgX3Lc5WX31RSF8eHddDW?=
 =?iso-8859-1?Q?/hd8Om1DWtWWMU5mfwQZNNjHEcQLuaXd+b93PFMKI4nLKW3xtGcIlgu9pk?=
 =?iso-8859-1?Q?BmTYZPGGeKzHPSIrPAd0/sXPHGIBxy5/aNHHPkW4ITg+KrjwZ01HNyOU+N?=
 =?iso-8859-1?Q?60TOdBkBFAG8xumYUUMbngPewmTz87JDAPEBjZzoV5r94DQ6t47nnz97k+?=
 =?iso-8859-1?Q?3FXC1rX1VSqitIMtlTFp/vwYetv8j6fs5nMCsvbEEIEWP5MfaxWoD4fboo?=
 =?iso-8859-1?Q?40jCfCryPdB/y0lZEGnSRadrYka61EMMYp9k9kzGk8kqa0RfkdJ4jK9zS0?=
 =?iso-8859-1?Q?EFAXlNp2FdD8wNYEwxDwV2ntyTOqTce0tZiauC1aW72Jpv58c2rKH3nkyK?=
 =?iso-8859-1?Q?G90MS67KkiwKEgKVB2SbFQy9NWFpZg1sDGkq2GMeCkzhxiLfWKgJQZcnCZ?=
 =?iso-8859-1?Q?O/HnmzQsfl6UCMcHO4L8BNwuXWF+YP7PJ4Hik9mTSLLu4+vSOtr1Hk4M1a?=
 =?iso-8859-1?Q?96XTjS8POBUBHVwdJeiz6gYjMNDcLgAkO6bvnKuaQ1jLM3uSc2I09xOVW6?=
 =?iso-8859-1?Q?4+qiHo8dWMnSvcKAsyTGxfc015wul2Q//sJVN5Gc8VHXQtia784Yuoz25U?=
 =?iso-8859-1?Q?b/l8NzncFfVc6d1CUh6H/3I7mkkPhR5iZiPG/hAixBZjzA60xTTFBBkHHX?=
 =?iso-8859-1?Q?mAX7M0+eot1Zr04XsnA+7/+hGnvY1yOkeLIPqemvF0I5q6aeOmFqQaExbC?=
 =?iso-8859-1?Q?19bK1TPtwmYAKY7PRPIiWzMC9up9CqgKk9mNJ9nS7dUwE8hnP+z0HRH37w?=
 =?iso-8859-1?Q?94QA01i+cda8nDkqHs6My9ukTV1GtlP+lx0G/spbCjhF3FADetA5BF6eY0?=
 =?iso-8859-1?Q?VtgSAwVGC15Js/T09JM9YQEAbKUk9qHIfG6z1c4UN/YMRakfbbpSTYVGAw?=
 =?iso-8859-1?Q?lAXoLOgyYxpCqoNJJ1UzY6u/KqyUm54VkqY7Bu4TXNOND5MTVZyQLZGYtz?=
 =?iso-8859-1?Q?ypaXTubYn0j50wzvvmSOne3PtiHHBK/X5TjN4ev9i54NVGTt8JHwifROeJ?=
 =?iso-8859-1?Q?Jy+f0u9SbFDlUwr3l5QJ/A5ukX0+P7BnrHa9jdd1ksZy2WS4cBkTQ0lznQ?=
 =?iso-8859-1?Q?txW4wbziMykmw8/Rgg9G16QINY+uKW9vxodzea/+ZKVMWM9sTCb+y1GFfc?=
 =?iso-8859-1?Q?O8tcZ2noYxZI2TCJVz4gLfq9SKa0suAfr76PPAsnUVrjRkbqlg7VljpoM2?=
 =?iso-8859-1?Q?JE/XVSt6YMiO0hPaE6PNZ64DQZMNSfmuZyJUCcCgcqZBm1rGlyQ7MLzuYg?=
 =?iso-8859-1?Q?gZnEOSjPitz5oDhTBGQ3lpebz62rqN77mXGRaoseAQOnKwZX38jQiL5WB2?=
 =?iso-8859-1?Q?tsbnpfvhuhrOBY1nE4rF4p02LVXaHE3j7FrdxkjYVgNSI2KpESW6JbIb18?=
 =?iso-8859-1?Q?qat2QYhkFwL6O+699Nef7w31XVgcM2JixUD654Fp0A103p/N2WkDAoGq5e?=
 =?iso-8859-1?Q?v3UlObrcatdoSiwQ8Nt1on/wWVHzYE8Tb1QHGUA0c3HVdS2f5xWPgGOEfB?=
 =?iso-8859-1?Q?SH1fVY0V4I7g10tnVfkc6KzR6QTJvjYwcroDCFE3gQQpA6JClVcGzD23wA?=
 =?iso-8859-1?Q?d6GHaBK21cOv6eJb9/ek4qMbUyofhB4ii0U8owimGZrSEITcD0ktjJNPAq?=
 =?iso-8859-1?Q?Xr21Hxbrhr1Su5IZbfhM0DuMMgAPDkDZNPW0GUcgH6NkgI+zRSQcCRKvW2?=
 =?iso-8859-1?Q?njyw8ZeTXJ32fvcmiUphLysXOnnmhittV3jaVBjMzOEJJ0pyMoiYlxAMC/?=
 =?iso-8859-1?Q?eeKvITTh23fEjVaNb+hkT3bExOKGbnXyOSUQXLgzJ85ZDZgJOEzd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c913b59c-ec09-4bd9-21ab-08decbc31d63
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 16:20:00.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trX9Oe+EP7H2N4QEImB+8Bqdd8iZ1X89qo1cmKRJZ8AaP0+VgwrFpaktDC4C2FPGdEC2LX4Faa/zWbzJKSTLkW1JhcjCYF/kEn6Kli3rBpkP/BOobRHEHC1OA9DUG1a0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10773
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11561-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aka.ms:url,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 731646922E3

On Tue, Jun 16, 2026 at 04:40:52PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> The src_addr_widths and dst_addr_widths capability masks encode each
> supported width as a bit whose position equals the corresponding
> enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
> bit 4). As these masks are plain u32, widths of 32 bytes and above
> (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> be represented at all.

This is problem, which should be fixed.

>
> Introduce bitmap-based masks that span the full enum range. To allow
> controllers and consumers to be converted incrementally, the legacy
> u32 fields are kept alongside the new bitmaps: producers populate the
> bitmap (mirroring the low 32 bits back into the legacy field) and
> dma_get_slave_caps() folds a legacy-only producer's u32 into the
> returned bitmap.
>
> Add dma_set_{src,dst}_addr_mask() for producers and
> dma_slave_caps_get_{src,dst}_width_min() for consumers so that, once
> every user is converted, the legacy u32 fields can be dropped and the
> bitmaps renamed without further churn.

Good mirgration plan.

Frank

