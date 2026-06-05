Return-Path: <dmaengine+bounces-11192-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /5mcJSwVI2qQhwEAu9opvQ
	(envelope-from <dmaengine+bounces-11192-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:27:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D6F64A9D1
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=nxp.com header.s=selector1 header.b=L89Ujenj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11192-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11192-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4BD83002B67
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED0384CDF;
	Fri,  5 Jun 2026 18:20:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A61F30BB;
	Fri,  5 Jun 2026 18:20:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683613; cv=fail; b=juat/chkioHwbKYYW6ajXqSCwg+h+3AZSBKZzcZ3288ZGgvSUFOJwKw7WVaz2j0Q33ql7fEYncN6DAdg8n+qW/HELgYY2c87bZpvgz6jtafRyu6ufdL8wd7XBjPhijVvkxH7dUWafJ5rvpH/Pc58eucSegY4HcT8IVaftWBNQyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683613; c=relaxed/simple;
	bh=JXAj6mUoUZ/5cO9/0XgBeAWTFvGtYRQnWHSIONH+4t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UR6eAzvRiaERJHqA21+lwC7FgzUOgPWPIQKTW0G/lVX9B5WCWNKc3R8E1QnD/MolLymsiTOr8M/VT40J4KcoBxOcQhePA3asUgB0dvWqFXuaibfOy06kszruMR4okvok+uoBYutwrhDSE8Eodi2ukJQ3WQvQNN6VKSMejCooAPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L89Ujenj reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQjeKAfZuNMvAaSiZyjwZj46dr/0mK+EOi80txFTk+hfyhqYjaDHbAz+m+K6x1V8oV6rW1705j7pP+X7h2YEtGdEsisStdd7pnfSHuqyxTff26Yl53TOtnxvKptoQDZu7BKUlAmy5bxTtffXtNBwMDRDMx/CjG+Linukjkk7XiAkYbBeOeWsVWnB76VJt3YRBo9zRhzsNhlwewXZdA+t602AyUfBTECaCvJxLXPCYTiIPlcJfxNUCg9ULMoEipRPuRehjo36fBLCHFdidA9Dc9lzr01HWAnvygBMtrRSnJq9IknRkBJEEUclT2GsdEXvnwktF42/SrAFILHCsZqaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S5EO+LHhIv67pjP38JXthDtteuenvd+RPSy9DRWRM4=;
 b=ZXUAQwZ0+uOiSq8OuOmC5EYLeXv3It/of3GREK6HdPuGmcDFe4UDOKB7Jh7UFpP+cl5KmpzVCO2nABjyQeUeLN7uj0qIErB28MvzMzdcOiDoCpRV3+G5S3qTqtvuOZuS9XK1vZtUarmS1IZeoh0xD7PTroPbWDbx9JJR/+swH91QthGjAYzcV069kddbR5mSKr2si40mfJmx1RBc/hsEu4H2wGlUwNJOCsWCnLrX0g/yk/UvVovNyvTN6hwMlxHEoZ4uO1hr1hekQY62LWVp4AJL1WFj1fppfwXGJIbY1lE4JUJxMPn5pj1MgZuFod/PtbVBTRGzXt00kx1ZRuzF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S5EO+LHhIv67pjP38JXthDtteuenvd+RPSy9DRWRM4=;
 b=L89UjenjubuUO8lCk3msUIfhkQBbq65DbL1SvM7lAdcSSG2G9eBJ9lwWruJY1+Xl2/nVRAGWCaVtyz8pyTE/CnHEhnhWoqZTfI/Wf6tfdSvDn9RMpWPHhp1Uo2ZSx+NfWjjJ3H9+tmYRd9zYo5TMGw14gNeZ7ZXv+p1b8gCM7dul7ttvHNN/rrUTFS8wNGozczdC7zPqmS63epxmOLzhIUwR1e2CU4MclY2DB07sba6cKlUjUht+dMqA/OVCs4HTFjo7vfJHPdlHrxVxABJy2dPURyVlbVOveMrFgcDlwylHMhPQyVon10qTzEIH0puvAGoiOs0VU8Bmiz+DullKtQ==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB11534.eurprd04.prod.outlook.com (2603:10a6:10:5df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:20:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:20:08 +0000
Date: Fri, 5 Jun 2026 14:20:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: vkoul@kernel.org, linux-kernel@vger.kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v1] include: Remove unused dma-iop32x.h
Message-ID: <aiMTUMM4p_07XoQR@lizhi-Precision-Tower-5810>
References: <20260605073952.840988-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605073952.840988-1-costa.shul@redhat.com>
X-ClientProxiedBy: SN7PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:806:f3::7) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB11534:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b8f21e-8a1c-45ee-e0ac-08dec32f11bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2IYrLtO4wFbr424szmqvLFxELY7c3UivZjm/sMii7PcuowgRTkf2J2bdJfxrpjteG/8J6Mqi8jEOfizSuQ6ZVQUzPsGPKcbuskrpvj/AOujzeI82Ztn10N0CWBZnj3OjUJtqqgTVe5y5AN8TCD7qxozVjohCi8DW8F2A1tO4D5rB6+XCSOSVUx2t9YIMz5xeub1RL5lFnX0bF22wiOYbaw80RKanFqlJFqH1AOpa++18HM12XMna2zUEFEBUIZS7MXwkC8XT10MqQr+nwAM2giCdenPaWatbXF+CRHAijZff2XVUWpP8f37xa4HEYnWD6PpctA8SDhCYYo/j0jva0jB8FGL9njuLY9Bk+bWv1dFb/RDW2zCm9V3/QGZGElx7nhf6ZsVu9+w4J/afXtEKTlMszqMda6ShFC3XoduV9iyCHEcMOzh1j7YCrHp96Y0ovVVCmMk/rEl2nea6NKs9MwAdfAZYsMNEEoT11hBhlCj2kfMN1r3kuH6crOVYcqhQDKvP5jy99gk63iqdv1790j5FnijdDAVFd9D4Z0LSYrM6ajv/q/crQHXzUBulXw5SGmqbqJ7Jjzlmlx6d1ktkwucs+QG4nI4SQoRQnyiiLWn3/ZAFb0A3AL52Q9f6GUaTNvI4cWsa/Fbl9/ZohzsHCMJ9UH1ll26JLKPHMasqLafv7JgaPdy+NxU6aeCixlv9c5XBOqA3Z2inIafKUMF8ds5dcdWzu8njOAQbn1JmBtBLIFkQLtu3XDuWPA7RExNA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?nrWlQuECjbTFJGWdr8VVecogN5UArKx5HhD2ik/0PLFjThRR6t2BjIFSwf?=
 =?iso-8859-1?Q?UWuXOCfm8qjHiUUCKJg33ARWVTen43TInE9W76laFyxg2pAyJv9fjuOain?=
 =?iso-8859-1?Q?GLwlmGAswdFxltq+1gzChT2t9RQ6E9SHVQkfsk2t8eCqRxVHMWFtiOU7NO?=
 =?iso-8859-1?Q?HhFb6yHvXSm3Prj7LNo2uibemiCam2ctmlctbuBvaxUsF0liPQg2GWLi4Z?=
 =?iso-8859-1?Q?lO7zTeAAgIdOWFLPJ9aN+PUxE9yV54Cf9LdzgLC/BBEyCfJbs7c+dW1lVS?=
 =?iso-8859-1?Q?v2hz5pG1GjA/90/mYkKO3pKgGnxxeaND3xcwi8dlvseSCyIDF0evNKd5yZ?=
 =?iso-8859-1?Q?0EWKv8VPR/moWU36dWx7+pHk6zaCaMQT3voEs+mOJtcqdc2N37R0ISAEI1?=
 =?iso-8859-1?Q?+MaboR0BqodyRQmeF8TEWiAArrIpR0up3XRIHXoA3khl+aZrUNHc0HvMhN?=
 =?iso-8859-1?Q?cth7WONY0GcPZKC7K7VsIwh/0IiIsD2SDqyqt6eVzrcCCORbjKlLIesupq?=
 =?iso-8859-1?Q?ozvJrR0AQ5xWnpB+Mxk52R/vZK33BJkOhhCwIM5Oc0SFlfrPhGZHUCpxem?=
 =?iso-8859-1?Q?vFaal97+ke0RKedD9sL4kt0Vtd/i7yDZY1jTVni1s1VsYALY9e5m8y3bZ/?=
 =?iso-8859-1?Q?UuStfVSN0HTF8651A48v9XuZPSxgClFGSUEK7ElEsQ1GQ16zhuVpYA9sDL?=
 =?iso-8859-1?Q?DzM1kZpuaSFdLJkv5nDz844gpNzQIghffBA4qIT24huowLBMCcatV7bmG1?=
 =?iso-8859-1?Q?ZD/NTV2CX5nyMedJHMl2fTKMpHkLJEMyEp/SbTjxGd+k+kfg7clPGcKME4?=
 =?iso-8859-1?Q?680w8IgCj6x1ie77lN87gq3uo4FwV04ewDToLvA5UMUHGmIPXE+62DiIrA?=
 =?iso-8859-1?Q?lnLyM5LXEAq4kaFKTHCBPV6rf0gE/0ipwfeOXkAM4cuj8i7Qh/4D0kV9Mk?=
 =?iso-8859-1?Q?iLeCifFvVqvLE9O6vqyiZLDzh29KCaA3bqeX5lTVu68N8hHkB9C0tSizhv?=
 =?iso-8859-1?Q?r8fvGl5/AjXUbICyK8S50lpb5la+wSv8uz+eKGJxhlfeO6ypYDa0hqjWsE?=
 =?iso-8859-1?Q?PRylaBZwT+QodDCXL/Wr/j7BzOO1vdZxW+6XiDk9AbczcZrdFVk1mXiNvJ?=
 =?iso-8859-1?Q?u4nKyETaUtRu6EsOORNq9zmpSy9POnNb5a3cDfF7+jlPrUBDsmp0JBgdT8?=
 =?iso-8859-1?Q?H8SaOJyVLl5O5BxOhXQSixIPG547sdMVJzOcRO4xYwx4UmeF/cR5LEHJqA?=
 =?iso-8859-1?Q?JIaBTHgY1uOUmPXwdUwqeHlTQG8HMNDiB8fpVlqXMvNuZhPGE9sQBl6tsx?=
 =?iso-8859-1?Q?VnCmQ6ux+C1DA4c4BsuUHuh5GOvry0HjUXUoHOHc+Uky0dc5SoUZiJqd3m?=
 =?iso-8859-1?Q?inzL+cNmO5LHqqvEY07UVTBbwDCB9MWoL4AWLzb12T2w0Kan+kGbyIlyi4?=
 =?iso-8859-1?Q?X+TLsxiBv8ShPkwv9ulh3dZunLnyqF1lIsIoTRX+XoPHikpbkP+fOAUyDj?=
 =?iso-8859-1?Q?kBO5XwGH1/QzwaNdlCOTggGb5wDv0oIZWoibK+7P+R61453LkZxD0XvZjY?=
 =?iso-8859-1?Q?xuFf7Oc7IgAwCEKrfkrrISVIRfy1yIxFgTDadZ6teh5BcKldSEWk0DR+X0?=
 =?iso-8859-1?Q?yu74ylxBZV9WvwWE7n5CcXOY+R50qqnGmZtvSTKg7YQJpuU87ocpuDll6y?=
 =?iso-8859-1?Q?80SwunCnMmkgkmzQ6m5Xyxl0lVzHGgCg8CWs9SUPjh0uY1NeQjrbnEX3mC?=
 =?iso-8859-1?Q?6lUHQvLk1y2tk30XLCbC1PiQM4Visv03lDQZvUtlILeXac?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b8f21e-8a1c-45ee-e0ac-08dec32f11bb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:20:07.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+6eExB4rVlCzJS28CGFtWjSdaxxl9LLT4u4DqaGkgMpWIgMAxtxRF8dxEB0BrYOGflYTMy0jf6eApD9slznWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11534
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11192-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:costa.shul@redhat.com,m:vkoul@kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lizhi-Precision-Tower-5810:mid,nxp.com:from_mime,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3D6F64A9D1

On Fri, Jun 05, 2026 at 10:39:46AM +0300, Costa Shulyupin wrote:
> The IOP32X platform was removed in commit b91a69d162aa
> ("ARM: iop32x: remove the platform") and its DMA driver in
> commit cd0ab43ec91a ("dmaengine: remove iop-adma driver").
> No file includes this header.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---

Thank you to do cleanup.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  include/linux/platform_data/dma-iop32x.h | 110 -----------------------
>  1 file changed, 110 deletions(-)
>  delete mode 100644 include/linux/platform_data/dma-iop32x.h
>
> diff --git a/include/linux/platform_data/dma-iop32x.h b/include/linux/platform_data/dma-iop32x.h
> deleted file mode 100644
> index ac83cff89549..000000000000
> --- a/include/linux/platform_data/dma-iop32x.h
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright © 2006, Intel Corporation.
> - */
> -#ifndef IOP_ADMA_H
> -#define IOP_ADMA_H
> -#include <linux/types.h>
> -#include <linux/dmaengine.h>
> -#include <linux/interrupt.h>
> -
> -#define IOP_ADMA_SLOT_SIZE 32
> -#define IOP_ADMA_THRESHOLD 4
> -#ifdef DEBUG
> -#define IOP_PARANOIA 1
> -#else
> -#define IOP_PARANOIA 0
> -#endif
> -#define iop_paranoia(x) BUG_ON(IOP_PARANOIA && (x))
> -
> -#define DMA0_ID 0
> -#define DMA1_ID 1
> -#define AAU_ID 2
> -
> -/**
> - * struct iop_adma_device - internal representation of an ADMA device
> - * @pdev: Platform device
> - * @id: HW ADMA Device selector
> - * @dma_desc_pool: base of DMA descriptor region (DMA address)
> - * @dma_desc_pool_virt: base of DMA descriptor region (CPU address)
> - * @common: embedded struct dma_device
> - */
> -struct iop_adma_device {
> -	struct platform_device *pdev;
> -	int id;
> -	dma_addr_t dma_desc_pool;
> -	void *dma_desc_pool_virt;
> -	struct dma_device common;
> -};
> -
> -/**
> - * struct iop_adma_chan - internal representation of an ADMA device
> - * @pending: allows batching of hardware operations
> - * @lock: serializes enqueue/dequeue operations to the slot pool
> - * @mmr_base: memory mapped register base
> - * @chain: device chain view of the descriptors
> - * @device: parent device
> - * @common: common dmaengine channel object members
> - * @last_used: place holder for allocation to continue from where it left off
> - * @all_slots: complete domain of slots usable by the channel
> - * @slots_allocated: records the actual size of the descriptor slot pool
> - * @irq_tasklet: bottom half where iop_adma_slot_cleanup runs
> - */
> -struct iop_adma_chan {
> -	int pending;
> -	spinlock_t lock; /* protects the descriptor slot pool */
> -	void __iomem *mmr_base;
> -	struct list_head chain;
> -	struct iop_adma_device *device;
> -	struct dma_chan common;
> -	struct iop_adma_desc_slot *last_used;
> -	struct list_head all_slots;
> -	int slots_allocated;
> -	struct tasklet_struct irq_tasklet;
> -};
> -
> -/**
> - * struct iop_adma_desc_slot - IOP-ADMA software descriptor
> - * @slot_node: node on the iop_adma_chan.all_slots list
> - * @chain_node: node on the op_adma_chan.chain list
> - * @hw_desc: virtual address of the hardware descriptor chain
> - * @phys: hardware address of the hardware descriptor chain
> - * @group_head: first operation in a transaction
> - * @slot_cnt: total slots used in an transaction (group of operations)
> - * @slots_per_op: number of slots per operation
> - * @idx: pool index
> - * @tx_list: list of descriptors that are associated with one operation
> - * @async_tx: support for the async_tx api
> - * @group_list: list of slots that make up a multi-descriptor transaction
> - *	for example transfer lengths larger than the supported hw max
> - * @xor_check_result: result of zero sum
> - * @crc32_result: result crc calculation
> - */
> -struct iop_adma_desc_slot {
> -	struct list_head slot_node;
> -	struct list_head chain_node;
> -	void *hw_desc;
> -	struct iop_adma_desc_slot *group_head;
> -	u16 slot_cnt;
> -	u16 slots_per_op;
> -	u16 idx;
> -	struct list_head tx_list;
> -	struct dma_async_tx_descriptor async_tx;
> -	union {
> -		u32 *xor_check_result;
> -		u32 *crc32_result;
> -		u32 *pq_check_result;
> -	};
> -};
> -
> -struct iop_adma_platform_data {
> -	int hw_id;
> -	dma_cap_mask_t cap_mask;
> -	size_t pool_size;
> -};
> -
> -#define to_iop_sw_desc(addr_hw_desc) \
> -	container_of(addr_hw_desc, struct iop_adma_desc_slot, hw_desc)
> -#define iop_hw_desc_slot_idx(hw_desc, idx) \
> -	( (void *) (((unsigned long) hw_desc) + ((idx) << 5)) )
> -#endif
> --
> 2.53.0
>

