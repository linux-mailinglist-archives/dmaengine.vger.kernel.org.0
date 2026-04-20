Return-Path: <dmaengine+bounces-10029-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIpPHXLG5WlIoAEAu9opvQ
	(envelope-from <dmaengine+bounces-10029-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:23:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5A4272F0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE2DF3011060
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82D37FF67;
	Mon, 20 Apr 2026 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ilxP+CbC"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3962EC54C;
	Mon, 20 Apr 2026 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776666221; cv=fail; b=thuoDVjrKfTtMI4iRgpCV40e61VVhCNcDoeCoq5NhjIF+naS7YAQAddAGxrmsIS6NUsBCmTcdRArlfmSZfuGjOmeaSmPaNeUAkQ/Utf21ERkQWheUKC+oZneFt4pjKyvnFvaylpM8d+5ljrXsNNW1yA3JF6fn0WaTznuy2q6hGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776666221; c=relaxed/simple;
	bh=mWQ5S3V7diViVgKtBG6xBKaGWYaVl1yGgAj94dcLRv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Riq20oEQlmoZl2BUpTV5js+zw56zzK+1TKF4XJkskTpnM9kY71FiTkUgfRv2GOeENu9j1xNoljvO36/uQk9rrSq7qlo2j+MV5eSK2qvAQjQLqbnLQ87Ohhwu6KMbHwTPHL8J5/CJBHqA8619f+mOIuwLV04QfnJPYmTlaWTXe14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ilxP+CbC; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOY1giGP55wkFlPwZZ0CLlkVhfmZ8j0fXo/qS8K9tUmIDVxFJoFyqEJa8LtdPg+vgomwZrmpnI2fQrLjLThBRR0YM0+lhsaZiiIYaVY+u3wBEk22KwdFMq+9Sf+WLdy5d0XNdaY5ptktaA9q4Nk2QtDfTq3SKU9aFL+4O8FSAp8gOE/pWD2efDBfeN+sTNIXUA1yzJDateC3U+XMfwIOEVwaohi3JW1egKwdX9nf+P74+eQpGzsd0gKf2rFkquK1YlZOVJhSs3TaTVhfDk+K1MIlr4fw6ZWYJgyfweMOsXxiKN7t4iDNNwih1PW4XpRZR8uhMrbDideZDTHo/aDjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iwKeuPctQmsPgJeHSm55z+ttlDmNgASg3R0Rt4rR+Y=;
 b=cMkyY8z4V0h47xnjEzr+MhL+eOA9Mua7BjVpMy/HqqSObsUA/G6XoZeOyv7cDxQq7Jp/r/bDc/wGy+F4TZnyxf60iGJiM2De1FXbIWcHz6LOFyDjXTDyWWgQnEMGJybCgZL9J+RAAlu12ewHUw2dQy3KAClT8OlJd0h6clHir/xPGbyLi4idD2Srs2ohXrlz1zPEyarLXDu8gz2sOuUezMqqH1IjGZ9ZyQUXDAS0IubegrgmDuWKVQQLsVjaktzeRxF2Asd/qli457IxpZemrO8+McxTluu+bouxDy4cNIqrHjp28ryjqKnLPpIsesE+M8uNjvAqO1A9PBsYC6Ua3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iwKeuPctQmsPgJeHSm55z+ttlDmNgASg3R0Rt4rR+Y=;
 b=ilxP+CbCd0uiWtUb4DkdgQF8E0U7US1S2eF/FXEWlyRR5LOIrxxuYO8RlMcs3xwfZmrazqdea0hJPyR9DPH5drRyfj2GSQs/7myDQPJk8zpbpOk4yZ0yTFpJa6+h6aksQaU9yRE1czdz5b+0riwItCqmsr+sR5wfsHmXXqJ8kLG9t7dQayPzpiPjCPyBSctZMiccq18+0ln2SJ5CEAADn4O2OYEdt1AmDG7G+nIJGVHB3t36wVlkPjGBkReNlNthxF35kQsU527VKezIGBSV10OO3EYdOgZz0hlEw46wvf3ezvmVzX78yJiuy8zPLKL6BNO2ENdOUL8tvemcMLcX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7371.eurprd04.prod.outlook.com (2603:10a6:102:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 20 Apr
 2026 06:23:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 06:23:36 +0000
Date: Mon, 20 Apr 2026 02:23:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: Fix refcount leak in channel register
 error path
Message-ID: <aeXGZIrLhqj5hWG8@lizhi-Precision-Tower-5810>
References: <20260413135857.2898676-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413135857.2898676-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: PA7P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 780f0daf-33a2-408f-2b05-08de9ea55a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ue3KOleWXZSCe1nehiSYOsk0KJ3333u0dIaZP/suYR6to7sKpmFdAP6rBmZb1lP55Zhb4NTi9sdC7gezaJnYedM52vsWKWoGd3odu0m9znjHNSmHXsGPg76gDdhwrkPFxmTfNZxH1XaNs5RE5Q304/UejGzxuboEdnbp7pvjrjzXoGtWBUkQPUTnyWhOxZGB0K34ymZ6H3BfiCZfBRKcJ3uq02W9BgnnSWG3Q7kEVinfqS69/JAddsSX64PaFHm1ha5AxqgHoeO9r1InKvbStjA6FOxFkUMNHQ1zc6OOIi+ebmmmDLOWFX2dQEWj54TL4Ajc7Tru+I77SgvwMbWHV7MtTd4i041V88LmjSnX6j3FSVrh9o1qzYX4idnwHgv2EJSNJcB45R8H8hzzKg29BwvLmZICIiPUPVVZq+a8mRY3l6Xd6UbUec8OBBok/Lp6fY8gqwIf+Otmk+LowOrwvtncMVWxNeXkGQA2CFtzlPNx5T31TJRnTaMexWBYy2fqvE4/2CKGhavyul5Ag+VfS2xDZcjYuiXrj8IWhTsUxpqgnTbXBBW/xIL+RHWPCqJLLDizHg4FZF7BBoglE+HQi+2RBF6WVWvfRidIpxqn2aSpNI3geN9KXeAT55EshYYcfjA4TxULnGLGPouMPs+nkSa5APoSh8hGDuwsss3r3Xer3K+ouYLGEgVS5TP1vNYw3mVWBNqWEPW5HH6b+8Nu6nL6+zMtdIRneCNqcP6J+A3mR0gfS/1yJeZue5Z1D/XKPbviiBQwYC0Yl3kBCf+XuYoBdaAJNR1zRWT937cOjZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5j3xYfW/bjTXZSaFrwNsApIHiKP/KVeQ1KsL137Zy323eNkCvohM2mMBatp?=
 =?us-ascii?Q?2Ggv1hCScASHjCj39Ra/sCfWtprGN+oegT8WuX1hpt2+kgBYu2Evgb00WqqN?=
 =?us-ascii?Q?r3FwjHix3/7yDGErvmc+3uoXkV5u5/CKdLgHAddbZNuS1eLgEpre76pC2m8V?=
 =?us-ascii?Q?6S16tNvd+4L+NjuZ+Mz3s04IhVgJUqt5dHcJ0X1SKguuVDyWwzh9yxI4MX6c?=
 =?us-ascii?Q?HJUxne8KRTVUo4Tx8VMsHTwi5hxYkNyf2DCfsG9XZk9sQwOuP0qJIzTCBG8r?=
 =?us-ascii?Q?MCerjGPRO8XZrIl7LGzge2NgIZIv4zXwpTPKB/QQuU5hUpTOwRUzsFh3REdB?=
 =?us-ascii?Q?ZDonxSJ2+SDkX/JAdDEoG7WQ7H9INC/q7EtcGBeUt1I0szQ3TE7tEX23BmMa?=
 =?us-ascii?Q?En9r0LG+x8fAYdXImct41VXFKjaxUkBH85RoOGn5kHp9wvKcSHc0qtRDWDKi?=
 =?us-ascii?Q?ncdto6N0nC5BOgUpfwecD18rlMjR2Cjo82cmdnLuyRN7a+38tkCN7MblA3nt?=
 =?us-ascii?Q?tOaP47vvOP0jrgEPSHD5En4IJas2LUJcfbOPTrKZEWIK/r6Nf7iT6suGmvkA?=
 =?us-ascii?Q?ZO70B/Q/JPQnbrAbnylsTomSukygyaS9ZeR7YLmukBhj9W64BWmTyYbSuYLT?=
 =?us-ascii?Q?WjRuhE3VUd4cTf2UlkQ0N6mGi8t9/YhSWUuitm2k1GQuoSJd596/NR76K0Ba?=
 =?us-ascii?Q?DCwY1NOK8ZLrt/QAorPd4d2mxqzN+1P4srQwATFcexUbFAn4NxR9fcI1EJav?=
 =?us-ascii?Q?WpMycCSSXnB9EQqIEjWqD+aThvRRWSOZq0fH8bZ3/d4EMB+vg7/fh/Wzql4m?=
 =?us-ascii?Q?XPeKAqywY72KsfyQrYlEtwoN73o8QIMX8N7Mcx4MpIZSTNe16bFCQ2uueg0P?=
 =?us-ascii?Q?RrWWhsEa01PVjDmUxSlGaqT6pW9ZLWLG9KuW8xpyGQw3HorNOnZ+sMhV+Rm+?=
 =?us-ascii?Q?PvDxKFG0qaMxQ9GA4Jzr+weH1y9BHpGhP18EFp5pBY4JPHbcH8gAvB+Mrm0J?=
 =?us-ascii?Q?wfbb0UE3fjAWgV0qr8iFxdqcmtqPLrkU0l1OffdizHo0re8VhtcLjpFtep/m?=
 =?us-ascii?Q?ag9LW7OaQfrnpwuNuaSQBOSlRT/GRXC/YJcDjgG4ZXDSbHcqYQ+6NGHPCaMz?=
 =?us-ascii?Q?sinrFqBy226arrOYizrJo/GQfgfpXHyx71pLyoh1s7btZ399rcWhGbJSQ0Dt?=
 =?us-ascii?Q?176pDjrxYHo2dt84S7wQIxKuJS7j2UpVh5EhhKGIRYI3vppqqu1SIqBiYBIR?=
 =?us-ascii?Q?3x29ossLlt1vE5MMTQXC3YNZlvCFAUyYlGE9buY9RY5AUa8gKhrPH+TaPwfg?=
 =?us-ascii?Q?eyxuJvuWI9XbFW+KGkCnwg+CJdhApFWPvooqbm3deVV5pyvKUhUOuipsr/Jw?=
 =?us-ascii?Q?vmZKWtxlHbcC0G+ZGMfxnYQou99AzkFP2ieXBdBgvPqubCkNBe/CROvmloeP?=
 =?us-ascii?Q?QcyZlrMJEhfp7UHtDnjjafDDlb+cSO0MrRpX5JGYpRlD9syDUs301VBm454A?=
 =?us-ascii?Q?K+aroN3pLRascLmO7hBAoDQWqP5Ij/wVSmJoJDrnHGaq5b71+Yv2QEKAn33R?=
 =?us-ascii?Q?4Ig6E6UoisA6lDWQzpQh6FBbM2VHgQJR3jUmAdAl+OVbxSyH4piwHYb6Xmrt?=
 =?us-ascii?Q?9LnwpKuvXBqNSHmLyGywDAy5jtZhLxqgQ9Ol2pFwRQnKIMD11ki+bnNym2IZ?=
 =?us-ascii?Q?l6u02wcnSYjhCWc+aCKL/UV4TK8srbHgIz7y/0gEqJ54cOzb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780f0daf-33a2-408f-2b05-08de9ea55a8e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:23:36.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0grpKjX+uly14IL6Lnyw2Q32FJlqEW/MnanHgP851zDqxoI2rZJKHRqP4kDggFm2D5GYvPbDD08rn26N8LwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7371
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10029-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: E9E5A4272F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:58:57PM +0800, Guangshuo Li wrote:
> After device_register(), the lifetime of the embedded struct device is
> expected to be managed through the device core reference counting.
>
> In __dma_async_device_channel_register(), if device_register() fails,
> the error path frees chan->dev directly instead of releasing the device
> reference with put_device(). This bypasses the normal device lifetime
> rules and may leave the reference count of the embedded struct device
> unbalanced, resulting in a refcount leak.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.

I think it is meanless, no one reproduce this. Provide tools link if open
source. Or you descript how problem happen.

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index ca13cd39330b..6bb1212ae0e1 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1111,8 +1111,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>
>   err_out_ida:
>  	ida_free(&device->chan_ida, chan->chan_id);
> +	put_device(&chan->dev->device);
> +	chan->dev = NULL;
> +	goto err_free_local;

avoid err path goto again

Frank

>   err_free_dev:
>  	kfree(chan->dev);
> +	chan->dev = NULL;
>   err_free_local:
>  	free_percpu(chan->local);
>  	chan->local = NULL;
> --
> 2.43.0
>

