Return-Path: <dmaengine+bounces-11583-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EI2hOAYJM2rn8gUAu9opvQ
	(envelope-from <dmaengine+bounces-11583-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 22:52:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1269C6D8
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 22:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=F85c1I6k;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11583-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11583-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18CA303CC09
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309E390231;
	Wed, 17 Jun 2026 20:52:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172935CBCB;
	Wed, 17 Jun 2026 20:52:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729540; cv=fail; b=L82I6Pdza0PpSyUe7Ppke+OT28f3TZLiWynEr8WOE7P04ymvBt6fwfk05F9prncFj2xTu1h7+Y5cqYzEzbyI8VoI7RuIZ3My1xxv8UmnIn4yl5cZ7rKaFif8wO5z8C/03NViOuGQC6+I/md1WP1E0iKXQO2glCKhDkCxQJlPtfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729540; c=relaxed/simple;
	bh=big3Q0MWIFsdUWuBJ/U04kjuCwCXOMMyL94x/CnA4QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NwsQ/yGqVhHxwHzJEWFGWiwmpGG0SuTln/V/VsRHfT6bkJ3c7+LrlNqyONy/2qMLihRlR6expd+2KvrKKh+peV9VhntOJJ4CmJQ7kcWKB/vsafQ7rHMDKXCJbrQd6l3SxtIVXes0zRbSDbcqVg2nch3scce+4kYtDO2KnGP3cXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F85c1I6k; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDyU+TkjD8TjFdmCEeOJ5hHXaUvK0vb6QVQduqgQVgzBN8BzwbOpTZlqDyyHWwMLLKeFMyXc2FwIODMgdolbQq4ieYWxOPSW7r927Ust80y04aHmx14VzTL9JNUx78ukYewPGOS+tysb6iJ+wlWRofaEgR7gJBplmZyQGWDJuaQPZ6p43fiGiLMB2jFDa2fPSgYTJE1h3Mvtp61Z4anc+n/Y7iWpdf7OBXSV8INERSubNVFp8cI3BnzZ6UK2Xbys5stpWQinBjCOspAHe+F+U/eLqpcJqRCZuG7JML17/acCZMFsH5s5GrQcbepJENJD0Nf59Z4IBa0kk6TfDdOWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCuLeNyFBRotQu1FGzsEGrk2GR4ypK9AM9dcg+e3EyQ=;
 b=Y1qcg+t21tmK64NbGKr133qZZPiQAZyPNTIqbhqdzqc3RWFRFT9frLU2xSZgu3SM0k0NW1MRf7TjbtRGWKGKLj/tFwsaNtNIS1MVIjvoYWjdDtDkEtXMIr35XcwO+Y6Xid2eDKQPm4ZH3RKBA0FOxTbx9i8hblYAfC9pQFpVywEQbyL+MG1mpkjj/+VR7qwl5PnVfAgdrX12yHdw2YT1eJXUbmHyuj9CgjV9m0N0IoAmJkHlmMAJ68td6LOKwJkLNHvkmzc4Vb0lzYaFGnCYPB5t0olJIJCyyIkxZ3vf2A9D69Y23u3zRILEt48C3qY63+zw3EhNVHz4eLkmRQ0jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCuLeNyFBRotQu1FGzsEGrk2GR4ypK9AM9dcg+e3EyQ=;
 b=F85c1I6kkYKOhrmOKMeoLctsc3dVLb7w+aOBivIIaz0AC7u0Lq1Nz9rE1SDmbwJrhRjcopib1Zvh4UDISupwRAQ65hCJ57ZdHzHsm9fgeQZrNRRYhBL88KBSoMdRXOmTwaKP3ucsnefUZkkeWy7vLg5CcaLpgOPhV7h8kDie4BIADXUAl5wWIZyPHiC45ic/ARdGRkczi+Ku2ZwyOFJ93MFVyFHoqm/EKwLWRineT5+CssR/cmBOtLJR6CbKh0xHptM2rO/3C1TEMweB714BPz6hqBf60mn3dvzJyfMuTVvT6V1GKIlHemfBXFBTFUXBinQXR2Qjco3KzbZ3GzQdeA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11402.eurprd04.prod.outlook.com (2603:10a6:150:295::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 20:52:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 20:52:15 +0000
Date: Wed, 17 Jun 2026 16:52:09 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: acpi: Free resource list at
 appropriate time
Message-ID: <ajMI-QgrEREC6OTD@lizhi-Precision-Tower-5810>
References: <20260617091421.2649071-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617091421.2649071-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11402:EE_
X-MS-Office365-Filtering-Correlation-Id: f0783bd0-89b1-4033-9af0-08deccb2500b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YMymNkBSxdDFayR7AzJtxFUON63+vQ/GBwRkJyy+xTOYIDSLgcU9LZuSNory+aJT86OIPGogNFOIrUBAV5Wi+g0nIzynSrRoonIfivbpXE4bLhboe7M+mX6/pMO2j327fW/Z7Ye4XtaWnQpVSsUFP3XNEQ8pvOiUNfKzacWUs6zwGNqWg1blFYYnDwWxyj1AqDHDfM8GVPRiZiU92JzEIFOu7GOAg6eIiEYjf4WW2BYKBoqgZRjuR8krQLVZYwAmhyJP3rmya0Pn+iQB/UoWrguhl/lGIAOzgiTjmkvwGk2wI376Ve9r9jPBd+jYLLQ6OPwDLbTSUsRC2E+58aBR29Lo3vtjRD/dtfWOq6UTo8dQaQspeASJABLARFMhs+Ngp4CciZYtjSeG/3q3+fm8LtB3DkBaABVL4wgvOA3TJ/cc4xwptYFVm4Pso6Vorcd8iH0yVryx/F2VfAAD/gJo8mJEnHaBODSznHHu7Jd4Jy0CyDpFSEXvP30DBkTi8vpI/Jko/VPlKFVxE6JUiMQzGQNkKFE9HOX0NhoCZuCaHuVOEiJoKSvo4fh+3zg2yoJtHkjvVMuwC8eJZe8p4oRsS21Fhkzp+5Hf6oCe+4ejEkCz1L0V93MU+ch4qRcRYmJy8ySS/fwTop6inJdc7i9g6Wfo8HaEhMCL6d0lHCIiTjpAkiXHh3f8/O80DWbCnMo0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPCie99rh0+qlbTfcnnUjQ2uC9DAYWYvbpCN6Z76ds2G3sUKWJUcWduVMLub?=
 =?us-ascii?Q?uaRddHKGGju7SxZqkJkKzWYAnLZOG5aYIRlEu2dySYLgilNQi+4KWUQ82ZbI?=
 =?us-ascii?Q?kXwiqAg2E2A7WS0De0dQjRt0QfXUmyd1mEUqINnSxfLOwpz8Q+BquSyTzBpx?=
 =?us-ascii?Q?FymLGsbnSpR+5UNala2LwpPXOzfuaZGgcfvvu4M02fQ84n/ii7jM/1+KMUmT?=
 =?us-ascii?Q?jgrKXrc4sVeirMPnWzcGoHXPYmXFObHzHnDmUsIyf7B+RWwnvmbCR5rJCqtY?=
 =?us-ascii?Q?RDLIkjoIE7noOykaHk6VzlCRDrkno8A/x5D7VTC930QNaAEKiRodhXTv0jN1?=
 =?us-ascii?Q?2yD+NdMFWiulp/K8vRk7aaChjyF9K/brfn1zlTq9oPj5IREi7LzM7FjHdj5Q?=
 =?us-ascii?Q?kGLNcCTtxMPbgv/JWg1EOyfsTwgaT0wwuDsyGSbM0XdKFYSPfNuwOiT4v4Da?=
 =?us-ascii?Q?hexiL3Z342Q/1unDowPHzhG/GC0TPXtaEeQNKYfxaAVYACzvt3bwF2hMxIUy?=
 =?us-ascii?Q?nOyh1LaYz/ee/D+cOoQ668c0ZixZm277Ms2wc0+gmPNVR9KScVQgCl4IPWOO?=
 =?us-ascii?Q?mwshP4x47ZNcClQzvFtu652+ifUjl+B6JY/aH+1aWW2lCQWvZ6C9wicN03ZL?=
 =?us-ascii?Q?Ea1AbCQ13o296lNsN0ZZFY/fUasoRwjz0XhWv4kCmiJQamMLris24rjYxQgL?=
 =?us-ascii?Q?7QHAqVigEsFkAMn8Un21kO+c84OrTuXWqMQwH2hmphzg1Z7wftcwwVuUoY8h?=
 =?us-ascii?Q?uWUydRv81Wql2He3w3ipFhC4QJIAN3+lUd24yi5FLXPByk4O8HtNLdbGqJZa?=
 =?us-ascii?Q?4s643GM3Ta+ir+KWB1fO1ogx5h5Ve4l92qvG1tA4yYdXXesjsqVz8cXYYSGo?=
 =?us-ascii?Q?Y8uWkyWrmStEqAno9nGCHnsAlwd+iCxrZnOI33xL0UhkC3R9swntU5bglX8D?=
 =?us-ascii?Q?djL0yJrPpOqYR9qT8QEqp5z9C0wBQmGdfPZ7YNgESe/2GB67y8FsZJGaRmgd?=
 =?us-ascii?Q?wcmJeRFBbiyUh0rjpQ8/rLmeVrzy8JPwPG/WuUBWSsm7vbEIXgJI7dwIWZEA?=
 =?us-ascii?Q?XG7BJQ2BHkytFVGxe/dmo7+IK5MRQ4x/VQpEgKS5VrG2sIIv1JsaKSMQ6JI5?=
 =?us-ascii?Q?dpcnz1MIbUUsXiIrGJ0rXEZHXhYvvkGmUP/gkYMWrA4OLWv8XfS8VJxeU65L?=
 =?us-ascii?Q?ZcD/+xtwU2b802lDFZWriTEbBkfyPVGsxCCLeXrDIj+/I72jZ+b5hDBjcHtS?=
 =?us-ascii?Q?yo+CyaZa8yHL41nIZu9rNHiW//LFKXMocNe4EhSkjRRQRrWED37cbA7WmtDT?=
 =?us-ascii?Q?vGsSkqR4n6GR8qCaToP3V43vMb9xuys/kfTH9HcqaVBASb35TJaaEqy7regf?=
 =?us-ascii?Q?J9ttstsaK0u1Ux4YETEw5i5XgwvwjdKF/ir3WJkjjH+siZLc/Vl5+VPe7vMd?=
 =?us-ascii?Q?+DAbLRuJ4st3WGojjN9nQhV7FL//II0Y8f3iq5V3jKgeWD5i4L+WyXfm0ijj?=
 =?us-ascii?Q?2OFLJNMJPef1676QoL3FKJ38C7WRlaVMMaR/cLwFwjZZQ1wr9C39DFS2sWXz?=
 =?us-ascii?Q?sHgA+RjMc0bJWYYiuxHAXdPP8CJPrwIt5SVOOn6HrF6pFJj3OHnA1uAGMvM4?=
 =?us-ascii?Q?dQ0zHAYRq2R6lSDn4f3qejgRbPQsxQQw0+ys7ObDT/Ojs7SIMCWft1vLLAIk?=
 =?us-ascii?Q?7AxEaToQkN/YiAaUtDSpWzI0C5tx8kVPVXa6n4BA3nkLeiNIKQ7X/mQnAlw+?=
 =?us-ascii?Q?GY9HAVf5YRBS/gIkOcKeT+oH2sTF1oAdTsntFf/aS8mY5PXfJ5tc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0783bd0-89b1-4033-9af0-08deccb2500b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 20:52:15.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+SdE30Rxayi6SljyEWR3CK8cq2cLM7517P6n4QDeHvGMERxzrccHtreWOhErM5UUV8P4HI+dQxiLUlsnniezxTBx7tu2wZ97ZFvdLqsjTWoJCOTAWOnkspk1atpMPpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11402
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11583-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DF1269C6D8

On Wed, Jun 17, 2026 at 11:14:21AM +0200, Andy Shevchenko wrote:
> In one case we don't free resources when formally should, and
> in the other we do unneeded "double free" (emptying an empty
> list).
>
> Both are not critical issues at all, they just make code robust
> against any possible future changes in the flow.

what are you talking about, can use straight forward words.

You just move acpi_dev_free_resource_list() after check return value
of acpi_dev_get_resources().

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/acpi-dma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
> index be73021ecbd6..b053a7f96f85 100644
> --- a/drivers/dma/acpi-dma.c
> +++ b/drivers/dma/acpi-dma.c
> @@ -55,7 +55,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
>
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> -	if (ret <= 0)
> +	if (ret < 0)
>  		return 0;

Dose this change related with this patch?

Frank
>
>  	list_for_each_entry(rentry, &resource_list, node) {
> @@ -370,10 +370,11 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_resources(adev, &resource_list,
>  				     acpi_dma_parse_fixed_dma, &pdata);
> -	acpi_dev_free_resource_list(&resource_list);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>
> +	acpi_dev_free_resource_list(&resource_list);
> +
>  	if (dma_spec->slave_id < 0 || dma_spec->chan_id < 0)
>  		return ERR_PTR(-ENODEV);
>
> --
> 2.50.1
>

