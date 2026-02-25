Return-Path: <dmaengine+bounces-9086-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBQhBesjn2mPZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9086-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:31:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6619AB1B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53D1330AB6B7
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F83DA7EB;
	Wed, 25 Feb 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q6kENdkW"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35F3E8C50;
	Wed, 25 Feb 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036364; cv=fail; b=UptDlNeY5nwVOYWRPKFQkOEBO0YiHzen700n3HljnUSMT3tXebDfTtw4Tz4oAMr0GLQyxDi/HHovTNDCkrXf98WR3t1uYFN8sQ3SVNLWMhtK/wvbnLpRLwwz3D4oBaujhIdVMoMPATWG9J5Icg95N6WgWFdjUmnDsrWxYDpdDcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036364; c=relaxed/simple;
	bh=5/5GBwNPW+2Hsd0Mcos+OweyT6gTvXpTI11D9+sWloE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F37QUpu/kqZKma2Z1IwZf82vEFRwU7H/FfIQ2mdg+KG0VpfXaq2fCCsp6ac3gmeHdZAVI2nlggOmZrjKPWq1MFmfcviesQlwQlNuQrkS6OTUb5W8C6/jQ46wqVUi8aspEfkgufWc5E9eUNgzDj9sHDXWxAEMxUjIYkLLxE6vnXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q6kENdkW; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahRB4jsN3I//az6uwtlJ8FsRViVLbOYK28tv+UlpSiMqdWoXmblSLH940icLzi5zqhdbZZE9EfEDiJgz320rb5jj/GuDiXPbp0ZKZvJCOEpt+6ajLq9Hj7lO+JkDMSpbMR2wIOMf4ecRkEouHG1UgHXQ6XFQyrwP/LT3Awe/tw005KSRKw1cFwdzAOYreCUdtwn+0SHVohX6PDjceOeXQ1ZwHsO7EFHjmrU4X0nYH6Yy4Ucex3cJcPAllyQWKxNP0F9RBOo/pCXFZzkKNKAhMQRpVQgqYx2rwxMyRTyQ6BlnO1mNoJQThwGaHsOt1Qx4xuFcS6P3bhF3YZ7C/CY/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQGougBlHC40AOygKkykCbEGzV3uFcHS3WhiwwN9aCM=;
 b=rrcL+XuZrsbQUIEHuHf5dksMLdyIre+tWcf+fphJCbrLKyx7KwiRqazDe2HO8EN2Imeo0rvHEsNh0rea5+AsHCmWE7VTUzxTJeRUrac0JDEc4O3d3kNpzEDuhKu+DxL07DOQrdeS0gZ/CF0x9EB+rfq9fiDwXwKMoHvhwIYMsKg1aulnkJvwTIvLKCpGwQ7DiOD9tJiibjPyIA5tzgCYh80rlHmNiPNJg69Wwq5HGRAKEaKEHqA0OZjtIA3qxoEEdLkttG/vL2THx5Hkq9Yi3HxgQSme9jP2XMJv1gjylWH0NKEh6JtcemRMng8DzVvr4K4W50uFMolGF+8TFy8L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQGougBlHC40AOygKkykCbEGzV3uFcHS3WhiwwN9aCM=;
 b=Q6kENdkWEufkhOijcGbftEU1k5Y083dTl62LBLI4AoirDqQctgsrmKcnI8VhsjiMD33EEvRRNzhNQGfmGRpdGsLvQnYzuhOovQH0mpTn+tTTYnA81Q50BcMEVCViI72S+DcNWmdFVXqqv8AzxqVUDKPBbDiINSNUMgUtLP7krQMVT5ow/Bvp4q26yAk1oYr7yG3XcoDWmJUYKlJ/VdWroVA9G1gMjU5CHtn1Z/0bEnyWO4W6UmwqLBMS+4dAEf+LgaIDnYYACmIOn2Cyv493C8q6QNH0cjaY5a2pRU0PPuYRgEnByyWmtsbMmTZsLXToI4YEW+9mB10BoMpdkdEofA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:19:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:19:13 +0000
Date: Wed, 25 Feb 2026 11:19:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under
 spinlock
Message-ID: <aZ8g-VKbzkfA5Jam@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-3-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-3-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b245dc-5e29-4b9f-aa47-08de74899d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	vxs0n+AerSod0wAyn3YThM/RF8AtTcQpeyPdNbjncVfmv7uWokt/TP5vnPX78dxf56uOMGxhoEJp4DhXmMDNDXWHd2ya+mmSu2DdmswY9uxoek0FRZ8wLHB7Y0BPIaewRVmtda4VqgT907oIBB9PyoEB1rwmVWXFe0i+fkImwuacOedYxi2For1ymwWY/VLHVKHP6OhhSMKK0CcMa0fG/RyY7a8IshXByAJ6Wi1wzRPcwvay1twbU3MIX8PIXCJnkmSdIpWOI42daphVuPU9R9SPxEQTcnLqnYFX15V+vHuu9lIbaDUd5YHQYhjAJCFHmdyQQpVkIWOr0GvaagVMz6n1D06HZhARs6HojUrUOez5ysJitDyATVmy79nS5kT+Q1uzCYIeTdQDPC7iSX0ZzselCzev+SZBFr9P/mbeFRStjKger1OXYV6ud9ThfZl/riHpAW3QCG0hwDJbNHb0KOPqt6p7+urAIeBshwYck88sLJ1mlb34s36+N2jgP93ZirYSchg/F2KLSQXI7t9A3BhpUpC9iBAiTzf3whSsf6RxfzM5CIjs5KR8TLbMybBp8cZCZMfeDrUNCki95SoU8Fc746DXQoJnzl6GZ8ij5GAn/0Ifi8do8lVm/1F3zXHBDuhjx9RtSpvEKHPzEO0Gyhpo699Fvk/twoC171sEdN6mgITSYLvVhZmz9XbuHHw7G2jxOAI4dDZzHinec2c5EeYsp+erax5AcHi0YMBjKOGq1aH8PJjJU11417A9BVrSBAwizNuLrTeNiIpyZQuu/wqHfwmkxeFqUqdPXtmtDG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zuz0VVFM+aRm8BkrC9lG0uCFj+MZadyny25PCv4emmtlDQ+ISWdSlx4LfFT7?=
 =?us-ascii?Q?Sh6hFiOg/fYt5W2RGYJgBDsu2wh0/tgg1vkKNxUuY5Gi4hTEBLarQlseq1E1?=
 =?us-ascii?Q?G8mAWLs08f+IDY8wj/FCT/eAmzQ/08vk1T4XxQNwqQlN9eOU5mNjJLGf5a8S?=
 =?us-ascii?Q?aN4OSXgFznMd1i9CUTuJGXiLP9jKFXcPv/0hFYFouiBnrKYb/EG1DKPSIOQU?=
 =?us-ascii?Q?O6d3W2YzLqWDuorrjSY46gpptBEZ6LdDHteao0i3BxC+YEyWTPDxsPESkhxU?=
 =?us-ascii?Q?NI39Rc77u4zqqYZZXFIKPSalPMP8c8gcx0Qxh82ifLSNpFkfYndqj4vmm731?=
 =?us-ascii?Q?7GMA4FRqfAJQbNcaUEyE2t6UQYEOex+RVsKy63jRJ1WLPmsqNG0ygN1vA+y/?=
 =?us-ascii?Q?T81Ec0+J3BKWnUy6RU0v7TuJAbx08UCnu9jRoBcJcO3ICiSrPPyXSqOd5IYT?=
 =?us-ascii?Q?IU0spjtwakn+i6NFgXJigOL9K+z22vv1FxH5NCz2okQBBegoTe9A7dK+mAh8?=
 =?us-ascii?Q?FqPWCu9LVwFCu9+kSF9pi0+XuQtzTQXVcHvoRFhpEhfjpMII80/NVa74UQur?=
 =?us-ascii?Q?pJ+WBKmbFhxFVe/5Ibybz8Rx5NRH3Z8QCuAFiJ3dNs76O6r6k3o6iigEPXDy?=
 =?us-ascii?Q?PPGuZHDoZO//RDYRiqPXGzPqTvSSOj1jjpDE0tpF8N/HqOPLP/x4aVOc+Py8?=
 =?us-ascii?Q?XXm453pAMSw5+fiUuF58HMLAmk70NxSihsPEsS5NihoyhD7MF34BntW2lPrd?=
 =?us-ascii?Q?4TXeDKt6bz4C8WC/YCIt7/MYkKdTbBajrocziFK0JysB7OSyzkC9Fy69v9zk?=
 =?us-ascii?Q?aBTpoKJbj0JyFvO6lybeZMoBz9yWZzDLkflkMYSwpOKSepNLNtUBxZfe9pPT?=
 =?us-ascii?Q?JAOUUMyQ7zhr4YRI/pXMo+ih3VkAyUmoPTJ3pzuwa8pxscih9rvXGBfB2aYc?=
 =?us-ascii?Q?60bP4qz61gIC0NWqMHtc0yXKoRiF+BRd3VbpbL5Z31nKhAo9J6pnTLG3SwOb?=
 =?us-ascii?Q?83wMK2qZmCIzeALuq67C/TlBpC5+us6RtLu6LYxUvYRKMT9HSgwwjVk9/2A1?=
 =?us-ascii?Q?GY6rrOJdVBdx1ZHH84+X2bod/exPEGWL2shygY4HN6n+gX3YQJaw0qOcBznv?=
 =?us-ascii?Q?FgeqoI4VqNBZ12sPx4ADGEhQZb4BETMMOXNr90/vDQrZCeMwVrCmz2yCPAGK?=
 =?us-ascii?Q?uFy4mNfZJcw2eTn/3KK5jbh1hDiYWBhVVCJ0US2HMlf9Noy+VdvD9OFGMb+U?=
 =?us-ascii?Q?02g24Kst9UTkEA6Zd3JCf8sMNJoQzGqmSzwGdn5z9xAh5SPgKphBEO7GEBp/?=
 =?us-ascii?Q?T3vxhK7kIK4hu8YLVM/QFulYQZMLfXQl7mj+qnfdHIGoqstKjFIc7wM30zd0?=
 =?us-ascii?Q?QNGIr7T9IoTpAjbHk6Af7O6lFYbwLBgHLXPSi/fCmHwXZs1h7OW9GAigtF4K?=
 =?us-ascii?Q?e17UYZwxDQNEQmwJLahG1ecnacthFUxAfR2MgvtB8pW1ea3qaViqXZbq7biP?=
 =?us-ascii?Q?oT09vQ5ybHCo6Y9Oquq8yfmn8Y9cQl0PRtn1KQg2xoy2l2zAY67o8CSGUN48?=
 =?us-ascii?Q?aI9bY6fbVKmXLHBHxuPnhDquv0bacE7XoOWESGPASEbUhYttna36GQvtl2+K?=
 =?us-ascii?Q?xDUBksHToEzDqS270oQXI3C5HiaGA/eqWCGtoqS+YlxEmDSfEMowehVnMpQH?=
 =?us-ascii?Q?G1kbk1sfoT5dG2ZDy4TBH2ODJ7OcxT1mWco98uiQDN3UBRt/KHnxkszXYR/T?=
 =?us-ascii?Q?Yk7hdemfZg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b245dc-5e29-4b9f-aa47-08de74899d3a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:19:13.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjpOVscDL3KvpglsFMFSU2lOb+iTwoTrCMVNyI7PrJTLAD5jcdmEQ26yenPsMlef8jElszG6XzLCABTcMHfbkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9086-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19C6619AB1B
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:24PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
> CHCTRL register. To avoid concurrency issues when configuring
> functionalities exposed by this registers, take the virtual channel lock.
> All other CHCTRL updates were already protected by the same lock.
>
> Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
> accessing CHCTRL registers but this does not ensure race-free access.
> Remove the local IRQ disable/enable code as well.
>
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v8:
> - none
>
> Changes in v7:
> - collected tags
>
> Changes in v6:
> - update patch title and description
> - in rz_dmac_irq_handle_channel() lock only around the
>   updates for the error path and continued using the vc lock
>   as this is the error path and the channel will anyway be
>   stopped; this avoids updating the code with another lock
>   as it was suggested in the review process of v5 and the code
>   remain simpler for a fix, w/o any impact on performance
>
> Changes in v5:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 36f5fc80a17a..c0f1e77996bd 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -304,13 +304,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> -	unsigned long flags;
>
>  	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
>
> -	local_irq_save(flags);
>  	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> -	local_irq_restore(flags);
>  }
>
>  static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
> @@ -574,8 +571,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
>  	unsigned int i;
>  	LIST_HEAD(head);
>
> -	rz_dmac_disable_hw(channel);
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> +	rz_dmac_disable_hw(channel);
>  	for (i = 0; i < DMAC_NR_LMDESC; i++)
>  		lmdesc[i].header = 0;
>
> @@ -706,7 +703,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>  	if (chstat & CHSTAT_ER) {
>  		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
>  			channel->index, chstat);
> -		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +
> +		scoped_guard(spinlock_irqsave, &channel->vc.lock)
> +			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
>  		goto done;
>  	}
>
> --
> 2.43.0
>

