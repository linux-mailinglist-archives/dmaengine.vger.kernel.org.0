Return-Path: <dmaengine+bounces-9880-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHKXDept0GlP7gYAu9opvQ
	(envelope-from <dmaengine+bounces-9880-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 03:48:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A4399852
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 03:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2849A3007A6C
	for <lists+dmaengine@lfdr.de>; Sat,  4 Apr 2026 01:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9822FF22;
	Sat,  4 Apr 2026 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TkWdhdd2"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA620C477;
	Sat,  4 Apr 2026 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775267300; cv=fail; b=gc5cYPjJBxOdQpSl1MvqUqbm3GOpvA5/buvSb2/cLtN3S9ww4f+w9sSzhuk9P7x/AC9q3wHtUm/FM/Fvo7fKLeBsIvmkhNOkhPDoTDd6WQaVs4i56+Xy6TFoALZT1vqTBJOdu+fA9wgzCf80kn4H6mTdczPejfDUrdFpQxHU2sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775267300; c=relaxed/simple;
	bh=yXRExEd1YRN5DE3pjPtrQ6fSCCLye/17JhVlVgGWlRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TYRVn2zxnt8GsozTEXdprFFZTk0Z8oCX7T+huGQxLAKnWb5YYvgUOH1aOrej41Mkm3aLNiSkP5jhq6wwcpJUNQTZCX2XQu5wNqZTafPBi2eBdeVTJktdFdw0WbEj/qYytz6/r9wciii7pkmgzRJE5cUfoXgsYQJQO3qudHUzjlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TkWdhdd2; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d89le0hk019RrXonngH9jFCocNGBuH57pk+VrNdQyCPX/k1uVKKus9fsbCv09uLEJqHsNJzzuHHXuKCjGT1roY4e31iLELPFTfUd88oGtY9S6kL7nq8jkqj/XiPN3fIDTqM1UtfvRGeEWddO1acHAhDCpQSpWW9wHZX4NWCtUg8KbxFITyohc1muRihwE7kUioYlqheF/1SE9Vy7Xgrb/6UwhDa9oA162cO1g6HE+883KIxgjDFGvR4ZrcRfdEYkanixKZVIKTjw5OEnra5NxDzFKOaiZxfPF3oKL9FeCkiEPoxdNub//WIK/WLv0qexxIliDPgnCARsE+sCZmbLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+mO5iw6wYqcgVixkrtgP2mEMi421OGu7TJehhKBMEc=;
 b=fWKDeTqLr9Dpmzm10TZ5b1CzEzwv6DU3FBUnRnqwBRs1mmuhYqjnEnlzD6t1ZX3h8buYwFSJvtlg+7SqU6vOVUFkDMMqspZ4gOeapjlvHUfYT3BjfK7m6NvoWRnesjNOcAZrTv4MRfCdeYg/ZaMYdHghLYZ/JfNWYqKno5kotq+BSYi/9Oyily07CznStcdeBk+JUyOFb1GlWgXrYpOE0vcPJO+dbmvWDfsetASUp/pHHrHgZNRPQ1MBENBr8jsVmAZAY1F2wIKSZK3qJ01KCSuzbsG9NQhZ464JF1wnn9fz0QwvSj6FrAXU1Kr7fz7jGmeOIYnK5FDz3a81dpjJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+mO5iw6wYqcgVixkrtgP2mEMi421OGu7TJehhKBMEc=;
 b=TkWdhdd2fN/ANZ3lV/JZ7ThCvkR9072NnMiZzQ2YUsPEnVX7bzDOpU3QDoitvtNYBdEBTxDM7h4GLpc61myQM2Ki2Ys746EpA1jXfLv/3not8inIQFy3DUQRv0i3sYujLXkMLYX0XVs20urSA1LNOB0cdkM2cPdI7xbTlQ3Ux+xfJm6GXOr2GSVB9odc1BfTtGXr/D7eNlLymTuPkzF5jj3JV9dnmXthrjYdZWvSbUEJb9SznhLOG3HDbDbiUM5OPvU9lz1pJuNgRR3H5LkyF0zpRP1KM0zkEE94iDrUcicutZBXYna1VBrk0OksiiKZWybKTyIsMx9DkrC/92YXJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sat, 4 Apr
 2026 01:48:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Sat, 4 Apr 2026
 01:48:15 +0000
Date: Fri, 3 Apr 2026 21:48:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Refine spba bus searching in probe
Message-ID: <adBt1_ZlBeRBn2Qo@lizhi-Precision-Tower-5810>
References: <20260403083313.1172292-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403083313.1172292-1-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 388f0c51-b3ed-4f3f-e385-08de91ec3ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2tp3ochuRNAcgz/JfI6Ryc/mR8Esz2ZCy7w3rmvRgxOt2efZK6kuVIZgT7qhFRnxImV3GSityx5XcU2mZ8g49rPTi6M6XetQuUgGXWXURy7QMLggZW5TdLmPPf88u7A7feHLIpWlOUbynmifXjqrzai1hH9jDHRODw9T/c2Yf3kC64h3st2qSnm+nYCDzzXckqgNiRQWVfmm/kgJEuhsEMGHvgNgFWHTxuyQ1qiyEJmPYkOVhjNK7wPILajw6M4uVCBY4FWO0j2XD52aBc6chLqCBkrn0V3KZ0TrPZbhfjWV8y7iUvoMzQo6auPwpnBB9W9qAVaZKDoTQ13HtTNzh96d/OkG280ZB9gxaJFd1Jh5hWG7WEmH5P7nmkb9aAcFtnxUQlSZ4YFJ8IDEqappTzD8tbZWFi+Z0Va5Q0NlSD0wk93rtaF6xeuIDTPenono/UfDQlf8W4MyFjjnW4aYPDDT0RfuihE5ajg53klpDcs9p8Of4a/TRSAK5X6uVfVLNyEOee6gM1rjTu6a2JUZOpaeKtOUbdPTmdWdwNkOF48mP5hNH/rRph5vpHpoKJhOPgCK4ygONPiFeGpzylMqrpaGoBOxQqgWCG/PJP3KDFmoZgyY3+grtK8NLx6M0H09Ny1TdQtr4BUX0vPHkYcZod8daK5ns7V/f5PTFE7A2ah6W2eXtyxBVUjmoAZpmtLqKX9hVM/hGqpEz8jH4MWEtMp9KH9O/pyF6e155ig5hOUcvUzBhkzqiVjysc9jwCrCSFYtvyI2CIDHJUg3grm7VtYyQnbV02Es1PzQeL8sa9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nvgMff3oRXmCCLIAwM7Fprim0zbEsUjxcu+7zPs3j5aYVmaZgMINor3YuI9a?=
 =?us-ascii?Q?GhPQluKxU1xTbfNhH0iYY/kVfB5BDtz95/OS6eRHZpKfKo8dHdsk9AO6jBPz?=
 =?us-ascii?Q?gjq4dTdtS8+c2qCmhEjxyH3lrAGI0SZD8tiwYNHnWPoYyLkQf/rJUKPP77ZX?=
 =?us-ascii?Q?7NVgU7qdaObIUxH2d2U//U+01ImhLgNGbucP60BnoyYH7JZ44eGAWVSCO964?=
 =?us-ascii?Q?59jL4eQFu5LKp3zQc2650Of3GzlpO34jvCBNP5gbHQPj2wv+firqoEDr8/nJ?=
 =?us-ascii?Q?Hl4yh2DDg5HjRkFBVr3dBP/d4Fwpuw2AiKal7/CDJv9eWegKimqQoq1afKgb?=
 =?us-ascii?Q?oxF2ccQBmDx/MXCGfi+0/L1mGDlKmdZ18cAeaUo8c9EBuswTSR9e9OX8w1Ge?=
 =?us-ascii?Q?abir1QqrqLDp6RDBI4CtcVn4555g/uCgPivIA5mVPVizqNL345BvvgxSHycU?=
 =?us-ascii?Q?ZMXP7b4t+662+u0J5z3RZSuAo3XGwvTvHrOzqUNlykGxxgLEw/NHg2OHx6bN?=
 =?us-ascii?Q?n/1fx1rbtxc1VOx31R7ccX//3hInpTqHWLxNF5QnUZY2sAukY3E+lmSAM853?=
 =?us-ascii?Q?9gFjktLreBvOAbmdSRUDYI/h5De6Gzv74KcmWXLSmEwN6TjwiyeqhPC+aEgO?=
 =?us-ascii?Q?6u10oh5+zETEr/LVfXoJFch2KyRWbDBgFSfWKwOSGoUUCzETkhCdINiLPK3+?=
 =?us-ascii?Q?0t9Mb9hXq+ep74V8WS8BPX6+hhyrLNkO8ccQ10oDL8/99yJLCFisVCGnrWZ7?=
 =?us-ascii?Q?thRM677Xqxl/JfMlvrEizRsPAB+VVPJPMeqZi/V4zFAHfAQtcKmQhSJso64+?=
 =?us-ascii?Q?nxJZhGiUzxXfjsMaID2We3pg8WOqd7y6R73aMxIWPKQjApFraCV5UH1dW6hp?=
 =?us-ascii?Q?wqIZZNoyHmTEQTdCMUO62AzWprc4ta9YIEv98uHUCyNYAq8gcgC797Pu2YXo?=
 =?us-ascii?Q?T6cNAJ8SGvfx1onKlDd/5hFPq5n/ZWoT7ojQMmHN+wrB/Cav4vB/LLv4gfdp?=
 =?us-ascii?Q?ow5O7qHjQqYYqO0iA37K8LRlQfjVrkZEZXSPbUdGhSERA9RjzdXFq2UfJeMJ?=
 =?us-ascii?Q?uqTyhKiwQZ8iur+LKGNnwIbCTxY1ME8YJ62J8v3H7/AKKFS7Oz5kNkdfaFZ/?=
 =?us-ascii?Q?mckXTJhINS1ulqyFGgaE8d3x2L1TMffdl8Ig5mnG11FNWJ9PwVH/bOhcDpkg?=
 =?us-ascii?Q?2jAz1b1Qa9ATJmOK8laWk1E8wDv4h5OzKexvnVow+cx89KMmluFCLAHLkyiK?=
 =?us-ascii?Q?I9LQOJxMbZ2WfyhPRsRfRZWocYCFykjNLwlC9/Kb5N+HViy4t4mSoSnFhZ9b?=
 =?us-ascii?Q?L7GFUHu6DqUeWJoLIH74zDrNN27PXnn6kjEsL4ygbQtN7VKt1L8gz+rAYLRW?=
 =?us-ascii?Q?XOanHHg6171HsP1ggjJPRNtOwgP3GDmJMFb1PDAq2T5d57ngFyS2eiDfuk/M?=
 =?us-ascii?Q?ZF/hKpDT4wdCqdT9g3QnRfF52/f5VRsgZ0LjZFw/bGGMDmRm6ScHrm+oh1jt?=
 =?us-ascii?Q?hOWabjj5TIv1nhn9/jxSWtFcLtuzml+AU5uM/A67tqwWducxnMyMAwScfWhX?=
 =?us-ascii?Q?3giJCCgA1I5y730nIGf9iZKIUl6m7/mVdiLDYXUjTVmlsQeSU110d8qo4UOO?=
 =?us-ascii?Q?n8Zvs3qiTc4Oi0gH6vtJPA+J91XRgS83zcmHfJ6aII4muycCNFaLj0MAIzWZ?=
 =?us-ascii?Q?pvFvtfmHT6LtyuzUG6DGXLFLC5TQkFFmnfbNOGsK3s2lTTuT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388f0c51-b3ed-4f3f-e385-08de91ec3ca7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 01:48:15.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIAZjTC9tI60XW6loV840rakEMjQzXnb0UT/TlDT7vAoiiZ9hOeSFpfy9SO02VXAAl2kgZlRZ3kXcKL8UknCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9880-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B4A4399852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:33:13PM +0800, Shengjiu Wang wrote:
> There are multi spba-busses for i.MX8M* platforms, if only search for
> the first spba-bus in DT, the found spba-bus may not the real bus of
> audio devices, which cause issue for sdma p2p case, as the sdma p2p
> script presently does not deal with the transactions involving two devices
> connected to the AIPS bus.

It is bug fixes. add fixes tags.

>
> Search the SDMA parent node first, which should be the AIPS bus, then
> search the child node whose compatible string is spba-bus under that AIPS
> bus for the above multi spba-busses case.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3d527883776b..be2fb87b7a89 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2364,13 +2364,16 @@ static int sdma_probe(struct platform_device *pdev)
>  			return dev_err_probe(&pdev->dev, ret,
>  					     "failed to register controller\n");
>
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> +		struct device_node *sdma_parent_np = of_get_parent(np);

use cleanup struct device_node *__free(device_node) * ...

You can change spba_bus in another patch also.

Frank
> +
> +		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
>  		ret = of_address_to_resource(spba_bus, 0, &spba_res);
>  		if (!ret) {
>  			sdma->spba_start_addr = spba_res.start;
>  			sdma->spba_end_addr = spba_res.end;
>  		}
>  		of_node_put(spba_bus);
> +		of_node_put(sdma_parent_np);
>  	}
>
>  	/*
> --
> 2.34.1
>

