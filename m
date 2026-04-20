Return-Path: <dmaengine+bounces-10028-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EHHHizF5WkGoAEAu9opvQ
	(envelope-from <dmaengine+bounces-10028-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:18:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F144271DD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8123038144
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291493815D2;
	Mon, 20 Apr 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yn0Ps4DF"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57D381B04;
	Mon, 20 Apr 2026 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665644; cv=fail; b=W8I4H01XEoly1RNNlIJpnLb/upGGcKmwG6Qv7ztpqWhE32x7nVQvwJLSgri5d5RlcGtgjvvNBaQ8DkR3iD5F5KN44khxLUp1JVV71bHi0xGQlH1jySL4B5v0FBEXjG1a2huyJE9KwklUkRYHk6O7w5s+4yeSsH7JgZcuZseYxoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665644; c=relaxed/simple;
	bh=HKaj4yAHDV2BwjRaImtX2btqmm3KFXaXqok84kV71yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqRTDOTIvBU6FIR4UiD5kYMV/26kYAmsFSsPvdwEodSjuTxLzn7/VOWVPVUHR4wGW+uBI06sv8R0wL4gFgD5T70ueX64C870IRoc3MiG2HhTP37uUcQYcqGZC0vbyzZBk8cmmUCroPTusweokNR50GPvF1sMcGFgJOZ6yJSOjzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yn0Ps4DF; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVV6/PuLx1ot1TaLpFHSoZq0SIYcWKKtC81mTMMiCZW0IIRsv2Qqm4GRJcds1iaOT+yjgmCdamhl9NpMV710uEvu4RFETp7us+RGvue5AuAcwHxUG/Eg+a8ZtTH/EzFgYcvP8wMi384hkMgMgbnaNPCjvTlHzYbKrVvSrQ+RLCf7xxAdvqX4dx6ciYojeDsmqjA95bjulzw9j/bGrze4UoDQVHpPa/jLkdbM3112papf3gEjwEyEok7k0iMjSlgOKBVi67sKm0BCXdLfNNazl4jKUCX0Xg7a4ObwqJmOhvq360GoeezyTWb7NrWYUpPathJefTxGOR9GQJE6yl8cPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx996Mz1uWp1syR8Rw8iuDODn+PEmStYYBL+mMsP6p4=;
 b=yRX0hlYS60qtBAKcqYJZ0MWObMQka0xw49NvAJQJ3flobbTkZzGAM++rf6wNORQhqUfAIFFD8ucR8JDpjuM9JRphQeXQg34Wt6Qu506S5H72eHl5x3/ttaGZhxf5S9YtwHI+JOya7n1RjGDpf9UP6sGH0n4Y83hM/IPtsi9q8VKSjP7H6/8DgNaAdqaM3pku8WVh3O0OLkS5phCF+Qmq3zemIhBRVW259/H6+rbWkidBfeT53tl4VWP49q09jPxNupoFEHmb5XUoPSOvNTdgsKW+Tvl8g1knA7kVAHy0QbM/6olRo0SeErjA0YO7aAnD0DgBzzyQJ9VVDYE9BY0+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx996Mz1uWp1syR8Rw8iuDODn+PEmStYYBL+mMsP6p4=;
 b=Yn0Ps4DFtZUlNd4U0qLQgtjr8qGMyWp6eSXiYlufCiOUqQJTsOgymS032wHspPAjuxqkK9zmapkmKGpZR6KJjKN0hxGpxzoynIEaWnfkaJLmIuDY08E19eCsN/iDN1HZnM/LhdCm9oZWK5GpOvDxYPVJ+AX+tbHr2obDhhRgHYAsLJaXNibgxEgAIUqNKXqS6O4AKB12+Hay7aFFGuJniV9+/kAncul/XSW7fqJ9pc2myP2yJ92peBMv28LbZAcnhNbq85rw5gFg5Ija18GVLpLpFY3fphiC8DjgZEfggxJnO/FpNXpACfms39LHjXnl7tdlGeGGflZHeyA6m9wbpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7467.eurprd04.prod.outlook.com (2603:10a6:102:80::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Mon, 20 Apr
 2026 06:13:57 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 06:13:56 +0000
Date: Mon, 20 Apr 2026 02:13:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
Message-ID: <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
References: <20260415032753.6006-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415032753.6006-1-rosenp@gmail.com>
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 69558810-1aff-4aa0-a5be-08de9ea4013a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	SNDe/HZaLJpHk+OxOWZHBwpP0R1V8TXnAOw5OfNEEE/tGtRzxvMOzR2YEYkBoYp0S4az6C9SmHkfiV/9BTeec0OyDGbpx+vtIP6ce0TSl1KTUi4Jnv1m1OyqYBsqvyt/RQW8JEGqKu4krAtYFh13dKNXG0pe+4DDc8JV7egerb0xWJ0zzayGBEqcq5weGr8FSJ4ZYFHJx53QYIuqLoyLRcuKO0QDGwovpYyxalCTtnfILoTqcXprYfc01bxWBHry/JYwUzPd6e/L9NqJ+7ZHm7V4sRrGmdgTJWyNx9u1W9KFQgVelEmHTJNBB5VDh05/VlY4B3c48Hzc+KZ2+B6BVCKt0cDreW54w3PZb5BqwWyLozG0wGAol7B8gzXw6FOaw2IooTXI97od8d3B5sTqTWFu4m+kXf/g/l5hdF+DFMy6UzgQWFFYIddvhe2ajfdzfgLdh0SkIfGWAxcPE7VFB//nshBdmQU28wJwDW18tb1owX0pya1Xxg9A2uu87tMgBgdYtOwX5jDFe1QBIbyP6tQXmrX2Q1yZjlFFLrnH8D1bcwq6hF4I90+3X18vvOq9l6A1vmRYJIdahr3WZ2OUeMTq97i6yaRsvV0yc9+h5099hyNkc7Q3JZpoSRPZknPLq1PmL1sVUyCcgMQMeS9Gl/SAiPYMl4tWPYsBIr67jt8xXCStNEHXqvf/u0+it4kktaLfoUBd2xWhTDmUoleQU0zB6eBY30OIyses3lpSEUXIWTQtghfzZ34gBA7KFTFH1ZFEbSEBP1sh5F9YHGyh89e0kGJlmXqQRVXNWFq23Y8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ih2fzQ9yfJoEFyVEP7gU9G+cHnEb1j9owQa6TDvkDVjqbzmK+FMB/r38HTAn?=
 =?us-ascii?Q?tpxuPQ6HVjjsXGFoqBX8oQNAA2Fi73oDfGjhkgmoRXst81doHtC0Ud8nGi0j?=
 =?us-ascii?Q?boGLfG6FimQmbuMk9owgvwVy749npxnv73E7s5/zCBay4rnF/TaQJtSor1d2?=
 =?us-ascii?Q?KtEQODcBb3DPwShas9cKGchKxLwyDq4INDecoY2cax9g6PWguxcQFb0ygag/?=
 =?us-ascii?Q?W70z1wQ8bSJCe6PkkDzkONN2jk1b+KMNVHkbHsluwgG2vsCro83yhTbXbK6A?=
 =?us-ascii?Q?zSviiTmtVAcoaVqT+Uo/CC1wMAznbnWR4b0Saaus14zrSFrqHSjiZ7godPS4?=
 =?us-ascii?Q?y14CFJJXZtDf/6DLL8rmmIVuafpf9U82ZHI7kbM9DvU+WkF03i1dcuRqs70Z?=
 =?us-ascii?Q?hcB5jdiLDJ4A9b5vrgn0KDa1QiqFrYUgCz2iZiIgLPvemxICDXCvzCP8Bsi/?=
 =?us-ascii?Q?Km+BGUd4C1PlxWKYcHolMBODikFY/FAKr7JLy9ERvdKFYYsKTdlAoCTBXzL+?=
 =?us-ascii?Q?6ETzy6LXWGvdmjRbrLQV8tPfWmlAChWyz0QzjAEyXKEl2oCGFpChetEa1GHJ?=
 =?us-ascii?Q?Ahq+jiT+0x8SZi3MbOhJSu5s09CPAkMEokaNelXMM0tt8DLpT5Qk7a0Zo9dp?=
 =?us-ascii?Q?3v645KkyGgJWqewhZYtOvI5cLx/XzvLHWxxyZAjotNbxdGNy421Z09huPP/y?=
 =?us-ascii?Q?S3hHN0tgk9WEjVtEvagZtbEC6QG3ehuDfh4o1dXQNnCvv89vq7gmmKmANQIT?=
 =?us-ascii?Q?28jAUMTqhVHoUu8IMvfmHMsLdmSWT4V4ejuVk6gVLhySDZZZzn5zfCaCM/Xg?=
 =?us-ascii?Q?WnakjZf+rpXpXsChUzzu+o/IRALFBJXURg1HVHabORqXXtRQEJggUIZDiBtD?=
 =?us-ascii?Q?/EtsVPoXQ25q0p/s8Sw1qTvgPfRFTaQHJzb09X+eAcfTzur+7EeHtAy/Azzo?=
 =?us-ascii?Q?G/jK0kRABTejC2SHXR7C3IITym4duq4b9QDkx1o5qhtW7obyOrU8xPZs647P?=
 =?us-ascii?Q?+0typ8gGwfmKeyBBpnkBNCN7ij9lEhOyW7qA1lBpycaz+ZHZQWzZQYJ+TjTP?=
 =?us-ascii?Q?eYWJqldqHF3c6fDOHCTmzLHXPc6NPotcPqGfi6ELNYGhACvZ2VXc4GhiGmtf?=
 =?us-ascii?Q?g1Yvavi03jLd+V8lTtVI8VqWKdOk8YAU+uP8eFoMTVcQdElNEfTXxdIKVC/4?=
 =?us-ascii?Q?JjSlQwq/Q/Dw/LCCrH8D2g9a89Q5U0cFMvtBFfmeUnd6kuThEkXg0WILtNb/?=
 =?us-ascii?Q?5vh9XAf2MR0Z28t2XEfJ8oZH94Dn5e3N8sFAcAn4yDZXSyicJ/CdIYNVHgXg?=
 =?us-ascii?Q?0FjWLcaW3/sDgxLWjNpihMfzIa2d8U9XRQ5gTiIhPO1v6P9r3mTFo2+D8MnQ?=
 =?us-ascii?Q?YnbLddFD9LJezO02WmcBw3HVI7ZRqBBM1LAlJmpnI21H5hXDkObwDHT35edD?=
 =?us-ascii?Q?Jnsn0dLigOhN/kAzSxFiI0I8fCSrIv8HMbr1b6XPRls9NEJCke5OwF704nq0?=
 =?us-ascii?Q?wf8j07/goHAiJ8Y2vYL0cwr3IaxikM41rRFwN2tuXEsApu/Zfxb2sN46Ic4x?=
 =?us-ascii?Q?s/vhZfRB7I4f1EJnj+aWrlvLWFkNWvEFh1BAwptiRH8+NeO/LnjzZMdPGuml?=
 =?us-ascii?Q?YyRXmzzMCYX8fmNGEq/9wGDwCMV6h2q6jAAZrE0V2jU5rloiVTIXcezaPaAD?=
 =?us-ascii?Q?QXxa6huld/cwRk5DykAyglbb+X6k+nU6COBFnrgqiLwsPwPK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69558810-1aff-4aa0-a5be-08de9ea4013a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:13:56.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrExOAut17FpETJ6UOni3E0vVGz9yHLaSrEYy5EtiqVRpUA/jBWmjtPUT67tWY2OPf0PLaX8kNNyP7Xos9vEsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7467
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10028-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D3F144271DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject

dmaengine: hsu: use kzalloc_flex() to simplify code

On Tue, Apr 14, 2026 at 08:27:53PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
%s/this struct/struct hsu_dma_sg and struct hsu_dma.

Frank
>
> Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> this single usage.
>
> Add __counted_by to get extra runtime analysis.
>
> Apply the exact same treatment to struct hsu_dma and devm_kzalloc().
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v4: move back counting variable assignment, as requested.
>  v3: update description.
>  v2: address review comments.
>  drivers/dma/hsu/hsu.c | 43 +++++++++++--------------------------------
>  drivers/dma/hsu/hsu.h |  4 ++--
>  2 files changed, 13 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
> index f62d60d7bc6b..b1dd4fd1109b 100644
> --- a/drivers/dma/hsu/hsu.c
> +++ b/drivers/dma/hsu/hsu.c
> @@ -241,28 +241,10 @@ int hsu_dma_do_irq(struct hsu_dma_chip *chip, unsigned short nr, u32 status)
>  }
>  EXPORT_SYMBOL_GPL(hsu_dma_do_irq);
>
> -static struct hsu_dma_desc *hsu_dma_alloc_desc(unsigned int nents)
> -{
> -	struct hsu_dma_desc *desc;
> -
> -	desc = kzalloc_obj(*desc, GFP_NOWAIT);
> -	if (!desc)
> -		return NULL;
> -
> -	desc->sg = kzalloc_objs(*desc->sg, nents, GFP_NOWAIT);
> -	if (!desc->sg) {
> -		kfree(desc);
> -		return NULL;
> -	}
> -
> -	return desc;
> -}
> -
>  static void hsu_dma_desc_free(struct virt_dma_desc *vdesc)
>  {
>  	struct hsu_dma_desc *desc = to_hsu_dma_desc(vdesc);
>
> -	kfree(desc->sg);
>  	kfree(desc);
>  }
>
> @@ -276,10 +258,15 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
>  	struct scatterlist *sg;
>  	unsigned int i;
>
> -	desc = hsu_dma_alloc_desc(sg_len);
> +	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
>  	if (!desc)
>  		return NULL;
>
> +	desc->nents = sg_len;
> +	desc->direction = direction;
> +	/* desc->active = 0 by kzalloc */
> +	desc->status = DMA_IN_PROGRESS;
> +
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		desc->sg[i].addr = sg_dma_address(sg);
>  		desc->sg[i].len = sg_dma_len(sg);
> @@ -287,11 +274,6 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
>  		desc->length += sg_dma_len(sg);
>  	}
>
> -	desc->nents = sg_len;
> -	desc->direction = direction;
> -	/* desc->active = 0 by kzalloc */
> -	desc->status = DMA_IN_PROGRESS;
> -
>  	return vchan_tx_prep(&hsuc->vchan, &desc->vdesc, flags);
>  }
>
> @@ -428,22 +410,19 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
>  {
>  	struct hsu_dma *hsu;
>  	void __iomem *addr = chip->regs + chip->offset;
> +	unsigned short nr_channels;
>  	unsigned short i;
>  	int ret;
>
> -	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> +	/* Calculate nr_channels from the IO space length */
> +	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
> +	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
>  	if (!hsu)
>  		return -ENOMEM;
>
>  	chip->hsu = hsu;
>
> -	/* Calculate nr_channels from the IO space length */
> -	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
> -
> -	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
> -				 sizeof(*hsu->chan), GFP_KERNEL);
> -	if (!hsu->chan)
> -		return -ENOMEM;
> +	hsu->nr_channels = nr_channels;
>
>  	INIT_LIST_HEAD(&hsu->dma.channels);
>  	for (i = 0; i < hsu->nr_channels; i++) {
> diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
> index 3bca577b98a1..f6ca1014bccf 100644
> --- a/drivers/dma/hsu/hsu.h
> +++ b/drivers/dma/hsu/hsu.h
> @@ -71,11 +71,11 @@ struct hsu_dma_sg {
>  struct hsu_dma_desc {
>  	struct virt_dma_desc vdesc;
>  	enum dma_transfer_direction direction;
> -	struct hsu_dma_sg *sg;
>  	unsigned int nents;
>  	size_t length;
>  	unsigned int active;
>  	enum dma_status status;
> +	struct hsu_dma_sg sg[] __counted_by(nents);
>  };
>
>  static inline struct hsu_dma_desc *to_hsu_dma_desc(struct virt_dma_desc *vdesc)
> @@ -115,8 +115,8 @@ struct hsu_dma {
>  	struct dma_device		dma;
>
>  	/* channels */
> -	struct hsu_dma_chan		*chan;
>  	unsigned short			nr_channels;
> +	struct hsu_dma_chan		chan[] __counted_by(nr_channels);
>  };
>
>  static inline struct hsu_dma *to_hsu_dma(struct dma_device *ddev)
> --
> 2.53.0
>

