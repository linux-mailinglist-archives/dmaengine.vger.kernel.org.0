Return-Path: <dmaengine+bounces-11000-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNbANMxJGGpoiggAu9opvQ
	(envelope-from <dmaengine+bounces-11000-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:57:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47D5F331A
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E9C3237220
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8126738C;
	Thu, 28 May 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="M5OPtD0O"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011039.outbound.protection.outlook.com [52.101.125.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996E243387;
	Thu, 28 May 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976046; cv=fail; b=pB4J/50PxdWtZRGWogl+W/y0h2TmqGO61PECQPH/5ecEbc+0IaoIt5/AzEuRbN0Ty8x5c/XbYSH4XF2o+fbn0u0ONns5zr6dP2/9y3coAW0pZ6kTCg+7Xk4VqY/EfIDFjfV3f2twfXuKvoLzQxK/nsREh9LkdliWYMhKM+NqVac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976046; c=relaxed/simple;
	bh=VMtXCuJE/g3BHWAHvTQgeaw2gYTxvvefff7h2x2NDqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NpOaeru3yB4YA8Yi6qJf5+iGlRXlSqFMHLt5s5Gwankk0YM5eQuEsMU3kZ81Sw4qsLxNEyc++Ep/c6DnTz8eo29VmwFMBvNcWj5sbueWyYVvThF4IIL1E5wGCe5RnUM6hVFs5DjNzEi5GBT0bmJE0HMTpOKrWVLJ+XskxNhXQC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=M5OPtD0O; arc=fail smtp.client-ip=52.101.125.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+Yoi8naM5lP4/NIxabvt7pIEE2+ELcmWfQVtuNMXysyBquXXTz5l7dmWNIdNCmGFaTWtuOIU+J5a8OAZe0K5kweVttyZMQPT5v007/QXTpgGSMYBozonQGZkOR2ZGkeKNDjpWYDfFUo14t5S38Me0YIL32uKTddwFBy+VVj1H/5HwxwgihTpkfZ/3musqPG9dUadn47Qoeg4Qg9Rnuw8mbHfD60a5XXba4tuKbjQtjF9MMH4Tjtqs59xTgUC/QZYAK9digFkctHvv7toIrTocVjBpoAZcAnbFk9xDpngPjIhBTfQNWKEANVYU4A5Ci9nY0dV/2nEjRb6PgJsedDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlIB3huKNocNohWU0gGFLH/C9lNF07cwGIbneJX01Kg=;
 b=Ba11tW3FH+PDmhzomvk4cuRz/9SlVWt+yGfqx9CztQO7KyRYFAVx+VCA/4sz20fdgjHTGCU9kaqK6Fa+dfd3JLQw/QPYmCT+0EjvIuc4CnqtcdZhmyMrINpHy/HNd0hi/nyfl+JYP3KvothFxHZNC6m30WeDY/1+Zg1A6Oz+3F3rWoUaUB4rXXesj2p1Rvq7Ce2O/WdTlp3MRnetTyPuZXjC3bLDv4MlEzB2xZkoiOrNBK86oEfU6YG7tuggdPY1mxCxP4TRyW3S+fumG6otGTTHzNDyTeEq9yrTRoAS1mcEuTsRk2sExNLRPFQd1RdjAwcCMGPB+H26HzfPkpNBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlIB3huKNocNohWU0gGFLH/C9lNF07cwGIbneJX01Kg=;
 b=M5OPtD0OGzNwnbCbxzz3N6VmCzfAYdtLg2rD07SvU63Wdwtg538jWzSULLqSePUlfugNq+s5AIOVji8gpnOuxzGRnodD54klI7XNohiw79R8rO4cuZS9iHwqq9sshs50EHtaeWSJKAZygAcTbBs7R0mKJm35JTI24yD58gaIaXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:47:22 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:47:22 +0000
Date: Thu, 28 May 2026 15:47:08 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
	claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 05/18] dmaengine: sh: rz-dmac: Add helper to compute
 the lmdesc address
Message-ID: <ahhHXI7-jLNSXTa1@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-6-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-6-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 620cddc9-a0a6-49e8-b256-08debcbfa4c8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xiSNdazqdE5vC3jB4VlPfTbb0jCrqXUeqQqyia76fPx67PxljSWmmbyPdar2jzI9ZGUfAKgkODi8eXel7qq+Xyhn+nWqkpr+2wjLDPpIuZ/NiNijgAV0LvcrMF78BCt14DUTxiHnHCus8p3ZuqbfvXKzeaLNmNGJcx4jDpF+lQ5wZ7a4g/N1n64Rs+IrdkqwGf+qOYB1I+C+17ZSwZ9Yrpb86FpZRUqeNRRuCC57Qlyb9pZpbyvynGdmAfFvxznlxQzXEabtB5GEWVktwH0S+ibZx6nPfShI1o3e5ZfBoZY5yf8d3zEz6H4NgIrod+1N9GJffGuI91bBXU559Qsupn2k5jPbkFTGVOmo3jm3yQr7eHANFQCSDS7YMPLDqw9rt/LCTbXyqaNl0EGjz4Q6h2HVEYmz7PFzPLY4xTwbR0XyiVqpEJ+0jcir8zsKRemBoNzaJSlLdURRi9EBNRUG6w2zHDnT1MJ7gmGHKMg3RwGdBEAyLC3yXupQCa6ZwiHphkx6Ok+KDyeJIyyzrDZ30hdsSAnQWczXC7UoUKT062vBgV9HWWASDYSSX5emWb8YA3QbFAcCvNTJtbxHGlGllEsfWYMI696xYfzyaiSmpfAmYVQRfzEQCbD70wKGpRw0ZlGPaN3W10jcRpo2oFls9XcjJt4glhPDfi0Xfmy9TI004yxJ1ZoW38F13EKW3eAp4MwPFhajD24EKgeR5zQUxICr6ougw7pUPdhljh4afEfteYC6K9dSWczfRuz5slEe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWipAYAhdSSOgyZyMYk8klsBtGKiZtGKJSAeP899iYdiNywccd1nGeHGY1rS?=
 =?us-ascii?Q?QsfMJBHGyo1tzHfZDvE3fwDntmF6HcDT0HgsmIJFGv2lQEKK4P093gbcBWsd?=
 =?us-ascii?Q?9k2ouh6fil7hilIHBNZkoLQAjN/KJ9ePBgJDfQDlfP7YipMLVVr3aynm81ZN?=
 =?us-ascii?Q?2a3LU1yyLjVx9as3GiCQgQ5knSt6kt8iDsUDuxPXe6kGqVhRBrYfD5SoHpHW?=
 =?us-ascii?Q?LfzK5pqIPYYPnhGaYLZZc0p0GJWZg2itNb2G2RqLrTpRG0Jl1DbwWSX3ir4C?=
 =?us-ascii?Q?L58WlpgFUkktQtdv+/YGkLZ+UmbiD3DEpzax9+39x8+52tRzPPPgn7yC+CEa?=
 =?us-ascii?Q?TWKOXPx4ZBim48wekyconkvznxFf0HW451eXRnkIFMeLLCmFSUw3J+NN2yrG?=
 =?us-ascii?Q?ZoMcbK7HFjsfC8tZiaafBhhCvmFfkWGh8NC7hJCsP1s23XtErWAUFGtgZrNH?=
 =?us-ascii?Q?magjvI1FgCp7v+Hjd+PCbNm7+Psym5+nCC2ZvaAujxSow4Gi0jzQrqhxMcYe?=
 =?us-ascii?Q?wUsmTx37iia6NKfOnlFT4moUUnWO3Mzcw1DkQ7bxrEFvKImpI58ixd/YTR8F?=
 =?us-ascii?Q?aiVJ/yERwOh0VzsiVayNVsaUz03QdAJMhgi46UCC5vsCnWlKyF5w/ZNj8Gxx?=
 =?us-ascii?Q?d9nuS0FMx0IIV+scyVtuXYpLkTs+1SlET3Vb92rcZsGYaTm5IJ1K8eeZHbNC?=
 =?us-ascii?Q?zphRk9U439bxGObc+IXp6GnoXXwvcBjyYj0v4RW8Fv5oi4zX7VMdG77kSWQa?=
 =?us-ascii?Q?DY1hcmwuLfG3CETjGvKiq/VKlX4xoW15u/P++5WRhNloqD0i/4ifFwq9pbKM?=
 =?us-ascii?Q?MKynC8/xN5O/eyzfTld+J4RBiyhXqCAG4+3CUQ3riwRiOImxkCLuUChMSGai?=
 =?us-ascii?Q?YmImv4lhiyZkbaBMQE3sOzYesKhxEPIj8xFa7Ou2/OJg1cv/htRq9k6zNC+M?=
 =?us-ascii?Q?D5onxM67llTcEbvYnzqyQWI4lcFgrIAEtovXCkAZHDLmz6bqv/hRYsvxTpoU?=
 =?us-ascii?Q?997ZTLqdQJvGqEq5AWqeujtQhRcWez06BUmEBkPQpqzhZKpCWhepNv6VqtCd?=
 =?us-ascii?Q?lW38/zulLu7aVkDdu1FNkeqftrcxDYNwetX3OF6WODhS71SLp133QxNyTXwt?=
 =?us-ascii?Q?Y4UsIiU30uSiDFk0Hs6BEioaXb4o8hTgyvqW0i1m2XbGXGPgOZZb7qsISWQH?=
 =?us-ascii?Q?fx0pqInXv1yzWZWXAKUENcXcLJumlUYlAp44PO7ZGnZJUItZ5H4PshRdjDO5?=
 =?us-ascii?Q?HC8mJbA/awM93iIf7D/DT8c3K/CG0ZCIl25hMNgg2qurxJ72AsPr0szqGHN2?=
 =?us-ascii?Q?u6Kpe7CvwBrlgvJtlcIOP2OEKcDDon311/+0TDWx3QbAfuDmd+6OKC00Dkux?=
 =?us-ascii?Q?zKfl6rXB20fqujrfibml0+2y9lQoPflEjp5oNOEr7bOf0wccX6ZpBfC/XQWi?=
 =?us-ascii?Q?5w8BuchvGiIs5Cr4CfxkdFSHkgs0Jjyyhh3nd20dSz4qEv+++U6FUuNnlw6e?=
 =?us-ascii?Q?BasoOhTbTY6U5VkAkeI1wa10xe+YnWSASDpywYNlBPJfnqdeGM/hfutwnh6v?=
 =?us-ascii?Q?FQXG/qfoD9oYj7nK7sIC5ZX7eJF92epFV/6xE+Y6npeF52VLwfm6XEJFxoFK?=
 =?us-ascii?Q?cQgN5SbLwawvfkcOz5ed4sEFF2KRZKbjEEFhi68aBcFgNgFAZ6Rs6wYpy2SA?=
 =?us-ascii?Q?f9dGLp9+6brxQhhd1m9+0Lldi6aNKAhhxj3jGRNgaPuhfh/vMFgfd8WqjE9d?=
 =?us-ascii?Q?FRC8uiZFSejcFqz8aDG/+zwNOVUxmGkb2Wa+1922emZt/EpFyv6+?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620cddc9-a0a6-49e8-b256-08debcbfa4c8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:47:22.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn3aSV8Jp3bwqoP5qKGsBx7UbTHcSsw8U3TEPj7l5DtGwOHNjc+DaTIMgB3Ut7/CebWfLV0zn9dGizjvv/fGrOK7cifTqRm6bX7xueGfJstmwQK01uIjNXtZaOmZbDEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11000-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org,nxp.com];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bp.renesas.com:dkim,renesas.com:email,nxp.com:email]
X-Rspamd-Queue-Id: 3D47D5F331A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:46:57AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add a the rz_dmac_lmdesc_addr() helper function to compute the lmdesc
> address, to make the code easier to understand. The helper will be used in
> subsequent patches.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated patch description
> - collected tags
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 40ddf534c094..c48858b68dee 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -259,6 +259,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
>   * Descriptors preparation
>   */
>  
> +static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmdesc *lmdesc)
> +{
> +	return channel->lmdesc.base_dma +
> +	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
> +}
> +
>  static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
>  {
>  	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> @@ -284,9 +290,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  
>  	rz_dmac_lmdesc_recycle(channel);
>  
> -	nxla = channel->lmdesc.base_dma +
> -		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
> -					     channel->lmdesc.base));
> +	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
>  
>  	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
>  	if (!(chstat & CHSTAT_EN)) {
> -- 
> 2.43.0
> 

