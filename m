Return-Path: <dmaengine+bounces-11898-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3qUB/AoRGpJpwoAu9opvQ
	(envelope-from <dmaengine+bounces-11898-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 22:37:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F86E7E20
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 22:37:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="rtc5pA/E";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11898-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11898-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 104B830036C1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98C47AF4B;
	Tue, 30 Jun 2026 20:37:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836719C553;
	Tue, 30 Jun 2026 20:36:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851821; cv=fail; b=Xza0ROmduBhMaDxDlx7nT0vTSwXbmnmURfQcWUy12N+YIAosKxsd99TcwfWf8G7LEGpzSh5Z8VAQMudgUaK9uL0+MruEoVfNJec2sRKq02jh/ANEw5TFVWIv3YFDa8ZrGFxYRkRdtxx72ApUwFB3U8ssauouVhVr3ZBGI6x3iGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851821; c=relaxed/simple;
	bh=IioQaNk21fejaozWPpsoLaJyIrkhRMl61rI/2CUKN00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hBLycsZ/gXjvSj64F3kW2zvFg/OMU4ecDh7GAiCB27xCIlkyHbPdjcGzXOgP8131EiK5g4oi3GaeKjwlKK/28swtLpaqus0sVQCJQ2b7jcdE9YB9Lx3dhmSxpIuLW2lpPaHol7fRlIudzJS7Ej4V2rWhS7GTCHd/L2yT4TVz+vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rtc5pA/E; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFg6uQYPCjTaJJ1gvuWE/ARSuvl1nLwJnJiCzZSnWgrLJy3rYpffiKz2mvCt4gAYhVK8bSR34V0ZQOlGoJ1tux72ST8hMTPxdZipPo0WfyH4aWhyU1HNZzzr4P9ZEikfoS1CwmkEuh4/IeLJoZUCtl2FbOxLvBzinEyPRzbUWc25uZRjJXkkn9b/QUOrL3muYTEgqBbetZ/KnFw/ktWMqu+1jZ57f9Y4/TOi49R60fMogioQZeLF9DGApK8oas0b1SEplpQvW5aWiO4akvx+Otcv7GnB9ITMP+z2WFM6JzwXVAFXjfdaOkr+NJhHSfJPQPisybe8Af9yrX6TM+ekLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p642iH4XFbq2YhtahYWH2CRAmzAsdaDOkdnCZXv+mA=;
 b=YjE3LYYh2YwCZez/jDZkUbHBDu4bM7WPOh2Br5Z9LFueawmZegKIz3Gvo8MW7WOHWgyluNkLduUf1uiXSY74LnuOEUDryzrG0429ICzJJgvUEicvD5NuhfTASofUzJEllKR/ySt1EU59OrZdASK3yjHadrReunSlLPJXM9CxOMIIatIDAoJcp3ZjmXkn60TVS9q7Oge3oTehdLglp1mFcR7ml5B7JX5mB0mWM8d/cZ+LJHNaJ1D8emKLyAc2Nlv8xXdYTTSNDhR8R9ZZUhLrEzYzy7M36xzTwDZpNxEU7ajm0gjWJax4Bw8GfAdSBPt6XoOyV+MLatlDmkQ9pwPyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p642iH4XFbq2YhtahYWH2CRAmzAsdaDOkdnCZXv+mA=;
 b=rtc5pA/Etnyd5t75g1mdYu5SXzF1HQOnhXm+r90k7/UOgO/5SbaNHHeersKHCjLPuvSHO2uN2lptxbaRzn4MEpNBYpVXyaFngErGtIj6l6hRsMeuNvxgiefSQPPzvFkfBu1zzRg/Pq5mnsCHsJPPeUaqExYEikIbl/CAVtobr7aAG2EFBX+2WxWlgWmpr/1snWnMseh8PQ+ZhNq+5Ac9a28X29T2Mp+VivRGX9MFaoaE5K3lmUjdI4xPg6Bngqf4RkVX1oC3+2Xwi/+9s0kPB4l+0A+s1aDnm8iBp3ZN43nmfcwTQPBtCjWt6UPNBxr9CstX0hVNkPrNBTXzOC5naA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 20:36:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 30 Jun 2026
 20:36:56 +0000
Date: Tue, 30 Jun 2026 15:36:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	imx@lists.linux.dev, dmaengine@vger.kernel.org
Subject: Re: [PATCH] fsl-edma: tracing: no ptr dereference during log output
Message-ID: <akQo37WXqkar_cgM@SMW015318>
References: <20260630200022.1826420-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630200022.1826420-1-martin@kaiser.cx>
X-ClientProxiedBy: PH3PEPF0000409C.namprd05.prod.outlook.com
 (2603:10b6:518:1::48) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: bb95b0ae-4a48-4969-a509-08ded6e7535b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|23010399003|1800799024|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ib5te/u5oVwytpXqxDwYL4kAzZop9AH1xuw062uPG0cV4UKcvXuF7y/qEhXTQUBrMswuB8xJSiIWumjp66kBADp+sQvPjWWSC/8qpu08Ey5KzX5BML3WXs2zvGfR77EMSNfduvHHi/tw7ZkZDrzHMeZu0Z+qPdXeizDZ/S9FCZGJ+3y6rxOWgBWf/Tzh/7H8Y8D7JjjoG3ariMfyM9IMtia/gJvSRnEMtuhUJ7yG/qUprJJ/NATmiP08pE2W1c88sekpR9e/vOSqiqUfytazj2m1j3COputxiwD9WobwTPl0/nqrw/pwyM/ScVjyOaX4HZR+/bb1jTYAQouk1++JMq80UCpPiBFvF+N4Bdoi4+zc/27Tu371WS4KN/pnF5cChJLsfx5+gysMzfHzj46mGLWBD+BlNHpT0OYW5zfopHmajAtgXPLDpixCivrowDht7vanIRXLxmVz3Iz7MEt0c78HA1hmxQyycseVKokcIc0H7zL5FWnDaFMgItQKktrLotkzfmQzUyest9otOSH4Pklchgd9cn05Z+gWGBm+8iFuHVYWGZE3ZoMd4Vn8+IoDsS1e9F4qBle/mJtvdi+wzOH3yT8EtmaAGwKvsa6SbDERS99aMvBysd3pp650EBD4TD+FeZcgcnqFqODNSc3GQnGZvktz7II1oT622N7qfXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43zXnHAKeaZPss8TY3z+jAKHciZ5JrjJWRc1vx/axGmP6Xx73eJNMA31hq3C?=
 =?us-ascii?Q?8JOdcnYdtpgwgPfrCirN722mAgQRZu4FEtAE5Wg9L4x3gZuNHVYfr8a8lrsQ?=
 =?us-ascii?Q?AML00wmKUdIym42sDAZRss6KC9bEQBPrEeun8X0ui/ziNkaaY/v88T0Eskck?=
 =?us-ascii?Q?G65+YIwYmpYXEotYo4OAJvir2CyHpyuHdAwcrdDgBFObnTWrl3W4X4a0U6YX?=
 =?us-ascii?Q?DlbeHIymT1Zhm9Ezw0ZJ5XCBZKXA+O3eDWGY3PKLC6UqYe2vg6HOnocCt2eG?=
 =?us-ascii?Q?TmRiwk5EFJ8wIF99T+vjeup8Oqt0+swO/tXR42vJXKQkoe6zfYe2kkMjVT5c?=
 =?us-ascii?Q?RVvfFRWqXNQ2dYp00XlZPiziWmoHi7r5cXmDKX/BE0/UJklZRiMkfRwhgf0G?=
 =?us-ascii?Q?MXwHfvuBziq7ZZWPW5mNdsFdzIwegdkTRQc8hhDdrzNkjdu2eVtSV0jpy1++?=
 =?us-ascii?Q?T6iLFRCCe9sZ4Zryv+RtGe7vqAOqHpCTEOVH7kEitRoXLH6aWp7ST8QTVMmJ?=
 =?us-ascii?Q?G0ArktAzlVYfHs6holYHI9UqFe40+5AreOCOLAwhOzDc/IRI1D+kOYV+w8IP?=
 =?us-ascii?Q?ILeippLHOsvZ8poOtG81HXaLEgGJN2Jd0N0WyHk+PPvKAFBCY0gVPp60oZM+?=
 =?us-ascii?Q?SSn+rgJDTAxfdPq5VnheH5lRT3rHkyabFZ+PkBwW9ik6XyIXW+X1/a+GKGjX?=
 =?us-ascii?Q?bC8DPE6E+Ack7OqA9Un+lj31nN4iAOZyRnSyxZ5nYEKZfIYBS52HnLcwWF0o?=
 =?us-ascii?Q?UEs6YeVNp2eFaeofSxzL0zchQYhNqMS/n8/n8cOIqOKW8ow9jFRWupDVseMh?=
 =?us-ascii?Q?dEW+4VYpPPhEg8X+LkGNdgXscWVAHm72pMiXRJ6EoU5FE7Kb5gZL42yHMvYK?=
 =?us-ascii?Q?RfkWcagJBWkbdHGXG7QlTh7B9HcD8STkWNaTl/mENGNCn3e1b4X9ILSfDRwH?=
 =?us-ascii?Q?0P2sR15amDLBlFnhDqgZmlX+ogruw4yvVMjzAvMDu5wLawoGisy0DQN776w1?=
 =?us-ascii?Q?jMLH1kzSjJki/PWR+XiQTBGjlkFfC7O62cskewfva4i7pg6yPMk6BvGG1mBh?=
 =?us-ascii?Q?nO9B8GicpUiRVuJT3i0KEdW3oKmCEZI8j+QBv2QVSZoHn/f8bdeLbcT/Mvjd?=
 =?us-ascii?Q?uxxNUNHtG+mnd+6DyPEofbvyROLn1xyoHISBxTWNeDCSRuX+cjoC/SdwBQYJ?=
 =?us-ascii?Q?JcL/8Q5flyGH/ymNxQkAErD0K4MDX2vQb1siOlbZYh4HxeqCeRg7olrA/7sv?=
 =?us-ascii?Q?pe7P3ZaRTA7W0seVSm4z+vM9+VtZ0PtlYmB97/wnsl7JFTt3cYJBBFK4aCwk?=
 =?us-ascii?Q?VFhe29o1JqUV6U3yg/CK2bsTCRMkFMlPS414hnpCsH1qBAW2cYpq4Xq4YK08?=
 =?us-ascii?Q?RxLZmnR8Xi5xaqsfgq/EGGXwVRVg/aYqUM549SkHyvhC4tycpiVD0fDntO4h?=
 =?us-ascii?Q?iB0lMGkRyGa0aYEXCL7LPy9QxY6HWyU6TJSWmjuC7QiClu/MCt9EgA3prx3Q?=
 =?us-ascii?Q?oEWJDh9o8ixE7ffVH0Wr9g7BOwEG6YqrsQbzMmfompwY8VmAg/R0vCAB6IYB?=
 =?us-ascii?Q?fi48VZQGifyQN7IQIHrd7t/ihajx1r7GrA+34tUWEU/SPAjxHhIyqIJ1WWRC?=
 =?us-ascii?Q?FTliyB5cE9f5Kk3v9O++RzDJSbXJJYwWf7E5Z4+wHnGJf3LTT0h4r06pcwAn?=
 =?us-ascii?Q?pxlroXLVQRApsfZMYHxSkE+3GEDbmUvhKxXVKlp+01QGlP0q95k6kJ7NK8zw?=
 =?us-ascii?Q?RL5REW8SY50m5B4ID8gwphl9vfQNY3xf5hibUIUbbT3en6BOtwhu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb95b0ae-4a48-4969-a509-08ded6e7535b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 20:36:56.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsqyUZjq/GAOo0wZH0jgKhJ/nobNZZRbr6cLuPpL9lodoUfYQh24yMsULKrlIk1pMNjY0EvkD+U2wFro6CuOZZAOx4iju7Slt+2+m/tqq0HgOwGA1tCqq1yO2Z3AMkwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11898-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin@kaiser.cx,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,kaiser.cx:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 802F86E7E20

On Tue, Jun 30, 2026 at 10:00:11PM +0200, Martin Kaiser wrote:

subject need a tag to identify subsystem

dmaengine: fsl-edma: tracing: remove ptr dereference during log output

>
> The fsl edma events store a pointer to a struct fsl_edma_engine in the
> ringbuffer and dereference it when a log entry is printed. At this time,
> the pointer may no longer be valid.
>
> Event injection can be used to trigger a crash:
>
> $ cd /sys/kernel/tracing
> $ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
> $ cat trace
>
> The log output needs only edma->membase. Add a membase field at the end
> of the event and use the new field for log output. Keep the existing
> fields for backward compatibility.

thanks you for your fix.

Frank
>
> Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/dma/fsl-edma-trace.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
> index d3541301a247..45d964a3726d 100644
> --- a/drivers/dma/fsl-edma-trace.h
> +++ b/drivers/dma/fsl-edma-trace.h
> @@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
>                 __field(struct fsl_edma_engine *, edma)
>                 __field(void __iomem *, addr)
>                 __field(u32, value)
> +               __field(void __iomem *, membase)
>         ),
>         TP_fast_assign(
>                 __entry->edma = edma;
>                 __entry->addr = addr;
>                 __entry->value = value;
> +               __entry->membase = edma->membase;
>         ),
>         TP_printk("offset %08x: value %08x",
> -               (u32)(__entry->addr - __entry->edma->membase), __entry->value)
> +               (u32)(__entry->addr - __entry->membase), __entry->value)
>  );
>
>  DEFINE_EVENT(edma_log_io, edma_readl,
> --
> 2.43.7
>
>

