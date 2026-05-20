Return-Path: <dmaengine+bounces-10576-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLqHF/IrDmrz7gUAu9opvQ
	(envelope-from <dmaengine+bounces-10576-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 23:47:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B759B4BC
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 23:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5461030D119C
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F633ADB3;
	Wed, 20 May 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y8uROxpY"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9A36BCD7;
	Wed, 20 May 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313575; cv=fail; b=ZhPGEyRe+gp81lAYuNJVr9A5H/3i6aUkcbOvtpbhV1NxFXhupMWKWAVaFgQhSc7Dfwh72UdoTIR0wEqIVox9XPHHfLAZ+K5WRBolodu5zazGccfrffcUMfCeQCKGVKEjN9WlJaBSMkfLz79i3sEnAxZgyzKogJE4xclu0WmHthY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313575; c=relaxed/simple;
	bh=Y2TDwG+OHGu4qZ8qRARJBRFEhlwoY6Uyhi5BbbknsTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZuqQHQdBJ4xcn4+ZEpqe3r4R1HaigmWhhmQlS8ktEiZK8X9Q/5c69OaPbfHKDxB0BkUBUgLpLAyTUa4qG6Y60SNFrg8C0tcNd5+8l4UKKD6L1OKVbkI+W7IQS3uhuriwh9DdEhYsoDPphoXPDlMbwfThlTkoy0U6QD5909d5Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y8uROxpY; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7y+HasmcfSl7OxIRqVKQ5Z3ES7JqgdEKXV8pyuxC6IfhlDdbSeBANdRkMDiO6IuI8aKfw3D4m/DjgnXEqEqstn3+GouDoSALA3jcl3M6ynZT1Slz26H8nzVuO9CFy5Tzj53iKmeIxPZ/NfayXilUWVBW8pEEPE04zTVNM9uKGOnjbTBzvg8rf0fnbx+OoMvoxbDg7FF0vcxYKTBWfECemjKhHqwQfA3koqkyGcaQn9M2zOkpx+eI0iLwoiMD1yu3r1y8oKhISTT8QgJhUEf5wgDCVjXAJkybimdNgBRQot1xAypMpGx0EgSdfz7e2kF4HDhdajbcKStgcZuTmle3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FYQD5BHrEcOvpgZ3OI7q3Nb1MYOTlgFHhKEiv7xujg=;
 b=U/wEj3XCXFshFMewta7mEP2YZAzpQjwCwaPhn29RtHl0kQFL1KzKLHRpX6sPfAxAS48Hxl+7tlL+9AllF2w9T8HDbVMSA9W+dsnSLgEOAf32gntyZbHVSYtd7kaRL/GqpahrfdzfLmA3CCkFG3IYJaKkl849C1FVVzIMTQ5gd1cOb0JxL5mkFbmm96eUgPXCgD4fnJ0A1GSQYn+T1PTDDqegpY8UzoMia3jlBI09L9E3U4nLZ1T9JVfiJ0S4i0lOHeNzu/t6LaF+hu5BRdASjNW+Q8S3YUToLt4Oy0VZYfW66TveTF4TasCr4CSFEVJJE/HGTJGwPtYHYBaexwG2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FYQD5BHrEcOvpgZ3OI7q3Nb1MYOTlgFHhKEiv7xujg=;
 b=Y8uROxpYf5KRomyaJUO2b7MJQDXaWeqZgXK4pbYsaY0rjco5kvz+sWlXJy1DLx2f4Cb5Z8Nr4IqBPJsI27QriAFxueQhXw4CQGhys3JEYa7JpqGp0C3XrP4vLyDhY7qRhGzfVFgvhfj2pjeJd8S7SlZE5aGeQ6FA2WFf1wQhL8dFF0RR2A1qxQHHDfXTm27Z33WQv79IPVelW2YiGIskk6vcSH5LvzUmvnWLHTQvSHSsazBmD72kR+yklFYTHZfHmSe8qgmhXbJhIB/USiVu/wlly6Nmi+AlQuTVrVhz6s5IdFbdvGj6yRKVlAzNRh/CV/2+b4vs2XfyKDIMMawO5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 20 May
 2026 21:46:10 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 21:46:10 +0000
Date: Wed, 20 May 2026 17:46:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dmaengine: dead empty checks in mpc512x and rz-dmac descriptor
 pickup?
Message-ID: <ag4rmx2584rYPLv2@lizhi-Precision-Tower-5810>
References: <20260519190442.2382986-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519190442.2382986-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: PH7P220CA0059.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ad7e6a-66c2-49ac-b64d-08deb6b9349a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|11063799006|18002099003|22082099003|5023799004|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	TISQQZPozV0xseFmqVUeAah9H3HCCFGQuTKeZTfFClmYrQJaekR4QOLAyFRPLjjqhU7Jq7JsmKRpt0pHxYme4CFCA43MWCjs4YoSjc/RA7GtVFBRP8mUGK+BLwwK2GdtAQO7ASxsEK0IHyEzzYWY/Tpp+9JhvR5EKsdA5O+F+c1z325sM8kGFew62dhLnAf7YdLx4QBW+H+1KifbeJVJObNHIRFQbgTnpmxnvBOxgRTMR8tI9I6oAaZcvW5Qw8Z0nk5Ov+NA6sMhUQRkh8G3WZhxdns35DWZytV49ZAg/g9tPJIE4Vb+2Zz7kH+TQjzeL+HlqKsdjBseS12+oQb1Qn94TasUWW4sJUy6P5lPSVisf7Vf0be+DGgQc+MEaa5DsQzav0+EjXRQa0VwMDM006gX2FJDreld0f+3O8M0ohAsB/FSYStSYguGb6bzC1IVquaqAPc3JbC99gXhf1Pwqm8uKoewNZNTpH344NWSgpWoM/NlFwK/xQazZS1sf/8d6FyHb+/tcuxxp6ywLIugVH+3rD2KFdHF4yojxc1KzANck2FFSHg0FGlTFnp8Gpn1JwM1Of+Ys1r5r6vqXJCibFUDup+7ztG2mUNfba8G/liYYMtfsJk0wqoxboxaz/r1Rvepl8skFrMNB0JubIoaktqGZSiFlIHXgwt1pnzO1FX2xXdMRiPfHtiLZbrb9V2e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(11063799006)(18002099003)(22082099003)(5023799004)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7PmcDn7Nvfhs3L8dQSVbvzNrfO7qUR1chgjUcbohCZS5Fqf+l78b+Fhl6RVy?=
 =?us-ascii?Q?ifiKZstyT8icD0e9z1666GXrVlDxCdUgL1yIJO+J1l+pQavamDMTZZjmNuZo?=
 =?us-ascii?Q?qd9q453Rij8jrbzxP7lCTkhQBcfj2sbbHBpOGqDbnEqiyf7HUou1v555FJOZ?=
 =?us-ascii?Q?1e5XE/B6+FZ2o+vqnWcdgWskg8hiKHVo6QhG3mIQs/qEK6Xtc8M6ZUgji4xA?=
 =?us-ascii?Q?e66MYSfUy4+C6v/dSbcsNsnhu6e7AcRPeoCVJi8EOfAMo8K8eS3KDlPuMuie?=
 =?us-ascii?Q?ec79xsJOISr4rutjklgHkb8RfAoIiaw3n5BEWmBfS24uS3ddlWOoib4NAplF?=
 =?us-ascii?Q?zV+E9jAjdilh7i8+jgWtbBjCORRP2N/xT6NkNmLVFlxAQ7DDFE5Ev+mIgWc0?=
 =?us-ascii?Q?o4w5olS+K+zliQ6q/1adZSCxHHJDqvc6q7Ucsq7fz+8h5kL9IkErxoEZz65O?=
 =?us-ascii?Q?7gqGxsS/RKPLDW+wWRQv8vQ28ZYdB6L+C82JqkYYeHwaFc6fMpx24kNDgMjR?=
 =?us-ascii?Q?pl7Wzm04yIGHECi7OJgqgIOtPrWTLtB5kJcJX81lBKU0lEgVNJ0N+JRyJLNJ?=
 =?us-ascii?Q?lGLkzgnWyJYTrFnu31CyrAD8JWe4Miua1bYxPKIDzQCugP8gGvUELIVkxKlB?=
 =?us-ascii?Q?vrEZ8rE4/s0NW4f4IdzBh+xA4Q1xh8VEnL+gGDdpAExDiCOKwJprxN89CLO3?=
 =?us-ascii?Q?TTC3nQZxsfgRqeqHBm3RCODdw2sX6cbrIIj/Q5kIOLSLepBD/nDQ0ukZ1DJ9?=
 =?us-ascii?Q?80r42pHqqexciGVPY5TAx//E8qbDXdrOHqiQaRC+24TQ6dqqFjkxmG2baCbF?=
 =?us-ascii?Q?1VPNxi7Fg0HBpzYMWZDmRKOmTA/l3TiGbwm14iZqae8SRch5/WqIMiC37id9?=
 =?us-ascii?Q?D00KqSG8ujNFcHzNW0ReL43znBxXpBp7K0MpLUt3T14onimwx9l6+HlXroEf?=
 =?us-ascii?Q?gJqeUeRx/lUFDr6U+3bsbBPi4Dl+Y8Ecr66LBpC+Ax/aV1SLkdFhjIOVrEoW?=
 =?us-ascii?Q?IaXzCVrSyLZ2eO6zZUVEvYl9fHX6kvzpMg14yt0sDj/H1DrmZDwNBb1chE2l?=
 =?us-ascii?Q?zTX0pUBEuMctjpbF0EUpPvA0Gg6GMOw/Eui+5NXAiZ5C51GMvdq/bdW+Kl6U?=
 =?us-ascii?Q?2VgHs9ZK7j6Gpmha049X7wHCgO71xS6W1/41L1/+QifnI89z9LC8dGbmMbDQ?=
 =?us-ascii?Q?8FzaAd6zzdTRpnrrCOQXlHflqIidqpXI46eS/Fd9gOjUhv6RBevC9XwJOSV8?=
 =?us-ascii?Q?JJSahr/Puz8rd+wWHL507vuqAi0TlGHViRy0MMuh5/xhjWOPj+m9vHIfDaXc?=
 =?us-ascii?Q?VcKQZ1AHtjdLlWbStHa2jK5BiaTlcRJsFSTKEAXtISxhY63vaJ0gQG6xG5ww?=
 =?us-ascii?Q?bIP7fRGLFKGPQCQl7NlDOWff/bRSRwgzlx/iEMGCl9N7ku5q08WXDvLQ3gcl?=
 =?us-ascii?Q?+U60MoEdqw52zlaYS5t02XJRPEERZw7IqqJXpSzH2LUbKqmggANwjhq+UYdO?=
 =?us-ascii?Q?0XC976Eh5zaV00Gm3+LyDZiYqkdK/kQeuwSsifIzixmyKhFTg/UzdRRHprYn?=
 =?us-ascii?Q?ZOwj7tEKKw9jDUljWSFF4QYljIgmMS87i3urmRKSJH3cjyn7X99Ym/Jmbm3Z?=
 =?us-ascii?Q?dP1bwmFclS/sCrLj4yvdnO5jnQbu0Bo8whYQ0QkZAsvqEJcptDv3yRiIX5ra?=
 =?us-ascii?Q?7ewH9z3KyEVDb5zgRNJMT/StLvlLf0h7QaZp9E9kvr08zPXS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ad7e6a-66c2-49ac-b64d-08deb6b9349a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:46:10.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNq/yfbU8N9L4fxs9eRw6GuUYsjBtulXjHMrdDKXIazxt4gpSWd1+xsE27Vk5QVPiltie6xEGW0CKii8x5IIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8979
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10576-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 1E2B759B4BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:04:42AM +0800, Maoyi Xie wrote:
> Hi all,
>
> While auditing list_first_entry callsites, I noticed two places in
> drivers/dma where the developer wrote a NULL check for an empty
> list case but used the unsafe API. The check is dead code. I
> would appreciate it if you could take a look and let me know
> whether these are worth fixing.
>
> Site 1, drivers/dma/mpc512x_dma.c mpc_dma_prep_slave_sg()
> (linux-7.1-rc1, around line 709):
>
>     mdesc = list_first_entry(&mchan->free,
>                                     struct mpc_dma_desc, node);
>     if (!mdesc) {
>             spin_unlock_irqrestore(&mchan->lock, iflags);
>             mpc_dma_process_completed(mdma);
>             return NULL;
>     }
>
>     list_del(&mdesc->node);
>
> list_first_entry() returns container_of(&mchan->free, struct
> mpc_dma_desc, node) when the free list is empty, never NULL. The
> recovery path (drop lock, scan completed list, return NULL) is
> dead code. With an empty free list, the fall through pointer
> aliases &mchan->free. The subsequent list_del() then corrupts
> the head's next and prev links.
>
> Site 2, drivers/dma/sh/rz-dmac.c rz_dmac_chan_get_residue()
> (linux-7.1-rc1, around line 726):
>
>     current_desc = list_first_entry(&channel->ld_active,
>                                     struct rz_dmac_desc, node);
>     if (!current_desc)
>             return 0;
>
> Same shape. ld_active can be empty while a residue query races
> with descriptor completion. The `return 0` shortcut never runs,
> and current_desc is then dereferenced for status processing.
>
> A candidate fix in both cases is a one liner. Switch the API to
> list_first_entry_or_null so the existing NULL guard runs as the
> author intended.
>
> Similar dead empty checks after list_first_entry have been
> cleaned up in the same shape, for example commit fbb8bc408027
> (net: qed: Remove redundant NULL checks after list_first_entry),
> commit c708d3fad421 (crypto: atmel: use list_first_entry_or_null
> to simplify find_dev) and commit 10379171f346 (ksmbd: use
> list_first_entry_or_null for opinfo_get_list). The qed commit
> message describes the exact shape we observe here. These two
> sites appear to be missed by those cleanups.
>
> If this is intentional or already known for either site, please
> disregard. Otherwise I am happy to send a [PATCH] series or to
> leave the fix to you.

Thank check this. Please submit PATCH to fix it.

Frank

>
> Thanks,
> Maoyi Xie
> https://maoyixie.com/

