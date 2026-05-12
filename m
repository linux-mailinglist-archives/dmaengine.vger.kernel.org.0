Return-Path: <dmaengine+bounces-10393-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKAABB2jA2oW8gEAu9opvQ
	(envelope-from <dmaengine+bounces-10393-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 00:01:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB452AB11
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 00:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2FCF30A84A7
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88E3988FF;
	Tue, 12 May 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VeFAo55W"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181E33B6D5;
	Tue, 12 May 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778623246; cv=fail; b=VIhwpY+2zvyBsOU8Z5vo7U2Pt8lhx+x06Zfk5HGrFWXJrmh+eRY2KKmxgI766tc0iPbFBZFZCOyA0oC07mXVoub4rOoCwFQqdAyc11sosFZVc/HVrHmaxz/tMxefmAeSfGg1Y6e9yM96rm0njDxmkx6laqw8v2Ox3CY2hmwr7l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778623246; c=relaxed/simple;
	bh=lfKisa/SO60KZ87lDl95o3ETxUyQd22jBJ+e9rNGvfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqYr4/1kvwq2sWtl2pErMqDmnTfTZPUSqQJwoYyrO5i0KDEhKuEijC8/ZdC4qxKpl+4PnmcBMdw7b4GxDuGvu4dXtxwiSuhUh0KuhgLt550B2czMW1HMbYb14ePhPUtm+RwvloM9NhMsjUmQiXIUDteBSA2Ngz1jeiUA/3FJesU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VeFAo55W; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzXel49ZG5myNcAa8JzmrFRvop3w+L0RUxR8IJ2q0U61hIDDUzphyEKzjIZW4crJzj8tf6wWzIlLuURqCK0sZY3+Hl3tyBviBfQrac9W0ZCv5/Pe6azJ/iQ18Fc/VhGJDo0cMcVAlbsHn60Beirh5DG0DH6MqAsV35Z3wFLCTLuLGdUNucA2a356o1m+5DZP5KOlHWaWwe9QuM8GUoAxEEt/5Rm2LOvSbGcYLF+e+QyXHEizW1YySuguH8sLsqvNawEuGtioj7ERB8agi8knfMJruZ7SggZivYiENqRJUcfdd7t5uQFWCN7FeqEz4+MR33DrEj1wUmz+YnByZ+mCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiYH9iZeCbcQXQu8J6r8Fh0JdymvSNbiskz6Ca/kuOo=;
 b=GesS0Z9R9OdSY0DtHyWNz/0nLqqa8vt0x6oEB2Tx850l+uZ3tAyLCKVqcVarsuoSl/dA9bXYVyYzK60Z06kPQe1EkglEOxF9lUa4vUzygZGydz+YXPzu9zhKIkkrckMamoblWZjYEFqb3b2Dg9Vx1UoVCK3OWy8hc/o6Po04sZKhebfQuojLc3BnQS0qkPnyjA8olndJtgauscTxw2tv5MBaWulTQgXqXifDCuwC3bB61dF5ieYJ9Y2kDAla7fZ2WnNFOHZtapVP/+PQSahFsL6q1KHtRAWC+UtLXNoSWpgl+Mo7CDuleG50hlr57Zcx8grFfPpNZIKHSZJvooRXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiYH9iZeCbcQXQu8J6r8Fh0JdymvSNbiskz6Ca/kuOo=;
 b=VeFAo55WUnce8rmXXGdB0zb29r5Qjo2rakAcjcBPK1nEakRXvvSXrkrlhzMdWXsBwIoPegIk+uAgcUdOzVaCPvMXO/NwF3t19T+NWBZVMfKw7zZ67QIGocnGXGpFLOspFj8TycrH8Iw6HzraZnr0sc+QbnllqUaGZGhgdirAeoQod9GEu8hRY4lAp+cpwYCbTLt/2VuDYSCaKhWityYZOLyoDHjAeL/hOihLyM1Inmh912p8h4R15TYvs86NoSR2dOyOGkqDqOsZ2KO2s5ragRq+LKZ/3sx3XNE7LzvoXV2x1ZauyvPjR8E0R51kj3imn5gSQJ/pbVkKkCu4tqIGeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMDPR04MB11553.eurprd04.prod.outlook.com (2603:10a6:20b:719::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:00:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 22:00:42 +0000
Date: Tue, 12 May 2026 18:00:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 12/17] dmaengine: sh: rz-dmac: Add cyclic DMA support
Message-ID: <agOjABHHVacS6ow4@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMDPR04MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: 373cb774-97b9-44f9-921d-08deb071e912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EhnKDuFoA58DBcL5K7//iPu1ejrO2zK7JA7Q3sckFZQSB0Xx0dtjIEIqUT8Hur51fRWsYGN/j69WEk33KvUefcEvEANjRCdlWmADFQW64Pv1PFIEjZFe4C0xWLbXPhwt1C7ZUJbK8XcOUcVI8W7is1ZKHV/MrC9SStqP7bLndfY4/jPsQwJsCiUmX2c+A/X2X7Cq4BOETock3ed21VffPckBu9KLzY99nuhkmBanAclVUdaMnda77+wKSF9pmB5EBKbcVsw4vNq5XpT2QQVqhvLJHaVMTO1Q75JgGdUF1d2GWy6aFl02TgtESVI9LfxYrmnplvEN5+5mS2MjHBVidWBPYjW3HHiDojga7qihwxA3ggH0Pcrt3Kme9sSvEwjJ0YpuK/GbA5ZWK4zwT3aUGZCsdLzV0OElYjRatpO1yyFaepiD+2MhOks+NEugYR6bkRzb4Xv+DQ+7/V8me4VEGE7E8XTS/oUjde5UxrHv77wZxGF+cQouSfKWx86pcY/aBDRBe/ddXKKBZI91q7FhAEJ8vJdc+HAMeA2Vd3++p62yk2/P4Dof3zqOMF9qcCFY+1JZQr173ZnlCR2PpOisAuJqykXNXM/0E2fMdVnKa8BqUv5x+FglqVDTr2lF0a3XzDwWKeUvVkVP1qvDRbHRt7uoo+ks4EZFKlObyH2eSpcvvGruK6/dYHqyMtXqpMooxor40Sqj3lfvQtrtNMNOeyMTQeCwciia9q8icAfWp4Y7IHEjyqKvLWCHrLw9Okyv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VRrZN4HdTO2ZnZtPAm/RVeJPWuE1I/D989zer7kLQf7X65JKfu4sFlSXjD1?=
 =?us-ascii?Q?OC3gnGhpC0neSKeYy32rExAgTOYIgDg8ez5FaQhw0jYMLcM13SczkUgSR/wj?=
 =?us-ascii?Q?iua+u1HYKHe9bjhU5hob91VAY6ovknqAHxQWGx5a6KjG+p5zNQqwntfBfjDu?=
 =?us-ascii?Q?dXXRDNMhCr0HDwdZazxnfM+D7i7BxUidrSObJs7Q/hYG0ZmgOAv7xsWRtjQ4?=
 =?us-ascii?Q?S6QrODZC3RPsYjCmmrhwihDxEOhYOqTEnv8XZ+b89BIFlObdVKRs3FfLb7YH?=
 =?us-ascii?Q?zsJBkLpXyBWp3KXKgm+6gT3b8GBbuT3uU29as3AuYtcx3JkoFHKz+KB7/ZPE?=
 =?us-ascii?Q?ji7tvZs55Cb+fRnyHFI/482lpLICA2crHn0W/vgL3oQwPdvFoh4qLiaJb4L6?=
 =?us-ascii?Q?xIm4RMboQ8vkkcUWZ0ay1HpFgPMzvCCIgDDi4rIQiyiHdi2dN8EBfAuwhmqb?=
 =?us-ascii?Q?qWCDmhJ3sbwqypkG6ddluqrRytlN4/mC0yBDH3DA7PtWbrqjCpex9fT909mB?=
 =?us-ascii?Q?CmT3gpUygIStlro4TV9TcLYEvLjRsBZWIgtqE6gUgNzIwqXmNt3kYkUrO7Nc?=
 =?us-ascii?Q?ZcjCsRLIcaPOm3Rm4f1FYyeQgTdBKU/gv4MWPwh8dI5tP4mX059imQ0Cob1/?=
 =?us-ascii?Q?Se83vA5BSYLcjEfKTqRPN0KVe4i4Ip5oQ46eDGBaLvOvVSbWTYQk99e1wref?=
 =?us-ascii?Q?h/vyBcfE5QKSLOWoR0iWJZHhWRBbqUxBnqWfNh8Bnz8Cze5Fd6vWqI+bLUBm?=
 =?us-ascii?Q?RdOquy+ZTWm+vg/06Wf8uT0m291PGJrs9P9GRJ/DPPrXTZao0ZB9PVAoNKKL?=
 =?us-ascii?Q?dN2OJEdvDIGx+PM3bjYaJNYZup1KOyIEX8mqYmoMHPMoRRrcTpvPq61OoG/0?=
 =?us-ascii?Q?fm8mBExx0rClluCeaQwuE7G+wLokLrGGumGil674KNIlRDSYQaWF0KKp3zYe?=
 =?us-ascii?Q?mvWTEnyd4vtyNrxpjBZ+YHtM/wIu1/GuJvLPdPUhCOZ+mY1teVRaSWaAFgIK?=
 =?us-ascii?Q?y4if83gu3bBD2GYQruPccOj+/9tKqfU8LvVpCX+5PD9oc/8ZVNuESeVDOBIt?=
 =?us-ascii?Q?fvwUqcOeKP34MLHpEzfFpRLiiNoEvofGFHPcfED1gppfzKkqED1nRoh5MluK?=
 =?us-ascii?Q?6MBrIFCgVuiqouQuP033ZHl5bc1an2sXmGYtBMLoZfDXREJc8w1auw4d9Kdt?=
 =?us-ascii?Q?T96xROq/53DesbcCOscoARuzhraO5qKMb8ESqixbeZ6r3nLpW17aJbQyqDwU?=
 =?us-ascii?Q?NJ3+vAKFTfUIB7W2pcF55LOB3uiFcrZh5/OWgokNeimGAIbG/zsxXo6GW6Mz?=
 =?us-ascii?Q?xaei5VhodLqU62y9uk5QcOVcfsgxd7FEpv64yxya7phHpTOIw7FSf4hE/1G9?=
 =?us-ascii?Q?Rel+RZo8MWQIIfvNdgMkytKCoVdQZPuK7x8HgX491qKwcSwD+KydphlPelAq?=
 =?us-ascii?Q?zheYy6UvKAtg62K+kuI8QoG0R1piuWrI7rSM4mw8nVNYbPdkP5wLuvz4AL1i?=
 =?us-ascii?Q?nygzqcNHL6dqs6Z7IchpsSTbV3tvnXBemgyaDoT+09iQiyuRAJgG4d1Usiql?=
 =?us-ascii?Q?k42rtvpfde29E5ECgmxuD/EkZdzIxHI0d/FXtMARC5K0QzwV+zQG28RBcT7X?=
 =?us-ascii?Q?PAL6NZpSVmJfHZgU5kgveCZ1q+I7IjPhH5gZxWXlylsd6SLPbsCfSA1tAn1X?=
 =?us-ascii?Q?fcHzhuiOny4l95hapNSwFw3CMD+rY7MMruy60fC4qNLG/We+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373cb774-97b9-44f9-921d-08deb071e912
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:00:42.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb9PMFNh11COn+zwkd7kDG9q+gIzawWXXhxJnIQjIRZ4lrc5UHT3HO4MBR8aOfEltpEVfDQALQK6nIsiwaXFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11553
X-Rspamd-Queue-Id: 5BAB452AB11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10393-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:13PM +0300, Claudiu Beznea wrote:
> Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
> introduced to mark cyclic channels and is set during the DMA prepare
> callback. The IRQ handler checks this status bit and calls
> vchan_cyclic_callback() accordingly.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - none
>
> Changes in v4:
> - drop the nxla update logic in rz_dmac_lmdesc_recycle() as this is
>   not needed for any kind of transfers
> - drop the update of channel->status = 0 from rz_dmac_free_chan_resources()
>   and rz_dmac_terminate_all() as this was moved in patch 09/17
>
> Changes in v3:
> - updated rz_dmac_lmdesc_recycle() to restore the lmdesc->nxla
> - in rz_dmac_prepare_descs_for_cyclic() update directly the
>   desc->start_lmdesc with the descriptor pointer insted of the
>   descriptor address
> - used rz_dmac_lmdesc_addr() to compute the descritor address
> - set channel->status = 0 in rz_dmac_free_chan_resources()
> - in rz_dmac_prep_dma_cyclic() check for invalid periods or buffer len
>   and limit the critical area protected by spinlock
> - set channel->status = 0 in rz_dmac_terminate_all()
> - updated rz_dmac_calculate_residue_bytes_in_vd() to use
>   rz_dmac_lmdesc_addr()
> - dropped goto in rz_dmac_irq_handler_thread() as it is not needed
>   anymore; dropped also the local variable desc
>
> Changes in v2:
> - none
>
>  drivers/dma/sh/rz-dmac.c | 136 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 130 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 2de519b581b6..d6ad070be705 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -35,6 +35,7 @@
>  enum  rz_dmac_prep_type {
>  	RZ_DMAC_DESC_MEMCPY,
>  	RZ_DMAC_DESC_SLAVE_SG,
> +	RZ_DMAC_DESC_CYCLIC,
>  };
>
>  struct rz_lmdesc {
> @@ -67,9 +68,11 @@ struct rz_dmac_desc {
>  /**
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
> + * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
> +	RZ_DMAC_CHAN_STATUS_CYCLIC,

suggest add new field bool iscycle in rz_dmac_chan.

>  };
>
>  struct rz_dmac_chan {
> @@ -191,6 +194,7 @@ struct rz_dmac {
>
>  /* LINK MODE DESCRIPTOR */
>  #define HEADER_LV			BIT(0)
> +#define HEADER_WBD			BIT(2)
>
>  #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
>  #define RZ_DMAC_MAX_CHANNELS		16
> @@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  	channel->chctrl = 0;
>  }
>
...
>
> +static struct dma_async_tx_descriptor *
> +rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +			size_t buf_len, size_t period_len,
> +			enum dma_transfer_direction direction,
> +			unsigned long flags)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac_desc *desc;
> +	size_t periods;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	if (!period_len || !buf_len)
> +		return NULL;
> +
> +	periods = buf_len / period_len;
> +	if (!periods || periods > DMAC_NR_LMDESC)
> +		return NULL;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
> +			return NULL;
> +
> +		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);

sugest use dma_pool manage desc, so ld_free can be removed.

Frank

