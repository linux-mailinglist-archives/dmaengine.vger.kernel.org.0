Return-Path: <dmaengine+bounces-11174-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZrazH+fiIWrjQAEAu9opvQ
	(envelope-from <dmaengine+bounces-11174-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:41:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF96436E5
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:41:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=aF1SkpX1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11174-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11174-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84FB63053547
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9414C77BF;
	Thu,  4 Jun 2026 20:37:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95F4C6F17;
	Thu,  4 Jun 2026 20:37:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605447; cv=fail; b=f82AE9VhYLYrVODufPO4akagQiGEJSsTY5fMt3kt7jiEHr1v/bqRnPRVC8rVXPTpwuKxUnZ4bnx1qcXbIkWwJEXk+WS0/TztDQ57xHIehx8EEVo+mgfJQgU/iKibOUegvmqqd4YYp8+EcvXeihQ9z6N3fQRK54sfd0wOhlUa9rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605447; c=relaxed/simple;
	bh=frYqhqWWjpzeEOx1DOx/M4sZW8EdrDjovMmqBNwxw3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNqhv92zUFmtbBFGokKrnS/C6UDdZGgKrpenu/3gDaNb6PUnTJI5W7f24SiK/vBXPESOlo1bpVGSZjnzg3OJb6dTS67h2v3MZwoH0pq1tvDXPq8JXAVSKjBbSt/ja6RsYc/RO/tA5fRt2KfC6aqxUUuwODMoyBkFOsPEcL+dEIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aF1SkpX1; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLO9Gxz7/9QdMMAUiAuqmklN0ICi1DmLvI/yku5969wxOWtjqDjtQ9hJU/H/ztmcW95eHDUIkSgs1RdsAXRMLq13/034EQsPng9FeFjB/LLNi97aWLNkTRgemMlizqFqjsV6wM+SecskWIopTIyQpEVf/xTsSd2WnMZmuB28ULCxz+qSbHDMmFafAbIl8bgYHBfKwNN8gpS+FmKncU9bLlNDbVRq0ADm6uM0Tn6IJXODZKuwF8cwTokrZtx7jUI1Xj8NOkR//XkNcViv+N6rEmqNHoCP1OiXpfnuMMLX3bnUpY9v6Tz6aJ3dTAWwmjsgJI2qRWKJcXE7JXh1M3iN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MkE0kgX7LXHkWv8a126lqvtUs5mnSJPUPUhGDgdc+g=;
 b=dnE95ymhuaUGNki5sGLD+xuc50+AAHVt4OuxByih2Nz1cRx37PsPhm4FnxjAdJoprb70ncYrPOWwwjh8E5tKeKM/n0SXUjj4/GD17A/JryhMg0sK4BiTb+tjz37jjSL2Dm84HtymJqdqJLO3NschisF+frlD8dpgQhLkXd5H/hM02+DWRhP9c0x9WZPhv67EbBfSC1kQFRb8pvxu3ZfrKzs1XhXSoaadJWXKbF7BDvYwb8maobShrr7OdAJl2qNPNe0vKCuDPDNfkekJMCAy5Mwovcn56PR8YnBjJGHtLDWoKMdbpYrmHg9GjxSK92p5KQwW3x4EAZYpZjfylzFVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MkE0kgX7LXHkWv8a126lqvtUs5mnSJPUPUhGDgdc+g=;
 b=aF1SkpX1uez+Psl8le9HCw4Ly1lnIHSr5tdHQ/mRo+noJPksiCRjzmHy0xE3gMU81kgDE5RaJNf6CjJDw+QQCzWRCs/Y8Zw9zCyUGx/2zEa/aoxO6uOYX7YVF+Elw1iX+BaUqSrS2Tj2ctpx5bc+K2xC3nebqLfaPAMf07oNuDSkIsPqIeHRY/Cd5tcikue3Py/4CVwY065/GKbqHyVzUvz5WnMuhgysBfUGCacm3UpbRjKTCuU6nrKfvhFhielv2GGmRSh6lwMjUxfyoz0kTXaT0Fs3SKNAAPhE7ZhBTaBxuWZbKHPCpdMeJ+xd24iz5Ayw2nqyOAp9eFki1KypAQ==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB12066.eurprd04.prod.outlook.com (2603:10a6:150:304::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:37:23 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:37:23 +0000
Date: Thu, 4 Jun 2026 16:37:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/12] dmaengine: dw-edma-pcie: Add platform ops to
 match data
Message-ID: <aiHh_G0EobQNI-k8@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-9-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB12066:EE_
X-MS-Office365-Filtering-Correlation-Id: 366f4a1c-03a8-42a4-95e5-08dec2791514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|3023799007|22082099003|4143699003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	kXozB5TuEidYec/BOecw63e286JJVCk4yh+Lr07V04L3+6SWg37/miv3uXofc1cAItavuU9clgZgGMbckRZVDkMGi8DQoSDic/97Rasrv4GmT6wr+1bmewE89nN4QPJ2lqpHbKOy9PIpNsGonI3PcnDx1QmIMrMvdY2S0jra8TcdhsIZ5TxzX6PmyVRa9rrgsxsEy7+jX2bqn/QoQikynLge4/nIKuDDW1j8ch6VmHifjYH1akBhRy8ZOeeVJkSVUPbH0lGaUpeT9dLDJWSd29pjCQWwFqqMvt5GuWRriGXGoZ75A+FfB53/C5q2ujdTSOrl2TRLy8Rr7moVZlHHH+gjrxosA9DSicyVsqtAMjknPde8tC07M48AMyoam51MzIhcs4VwBUdIrgUq+TB8/ZPI+RUJYPCEEH1jeJRP6dR7Lq/4uOOcN1QUG9itqJJvIY1DDq4+4yHYD8aw4dhTpnaV72R9X7XKCmv5fKFcgb4rgpV3Mo4IUlLH0hxr20QnrWQNU7wOGMPYcA/C3GkeFwkzt1MgW42fniIKNYwXz8RPIfZDOq3JIbWiGjijyvVl7kXehVQC1OlMZ8WEN4+Tj1akHnDxSQa3AAwOrwk2yu8h2yd69jfjhJHNRfHelPw1dGH2Fv7OSJQxj8DbIQburh0TKFe6QPAr6ASiNK4dEGpPHCn9UkiPk7wTqGqSpyO9zYcGwCow7gd0cTdL7E+IE1hdqlNEph1EXRCwUukD2DaSi6deZhXUHaMBwiDDirwY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(3023799007)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+gDzniX1CgUREl5R/BB/HypX9TfKOqU7yQOx5bwBMrvVQR/6SJR8dxKtyfTn?=
 =?us-ascii?Q?MmvMJQJWXmZoGyovvDxqnr4413y8yH4kM12aDsrOIlnSWWtBa11NYiw1DYWd?=
 =?us-ascii?Q?IOFJ1AJszCgbL9KMLFCao5zTEGhFslu9KYNLkJeQFQ3HdafRJLSq7GT4HOxa?=
 =?us-ascii?Q?+BvuvlAME8YVd5AnPsXxtiKMmO25NjbCbjnyeDoH989ogmz5SDBx+1xGN1p5?=
 =?us-ascii?Q?+jzKyLPnUgXTBI8eYkJdf8iohfN0ycplelFKLpCE/1oEnpb1A1C67DlF6Zh+?=
 =?us-ascii?Q?XhpVC6juXmjYS80nP6wVChQaR0l8087ajCiW2l56v974F3MYjak2r79ka3iJ?=
 =?us-ascii?Q?vlUbAUZd51BwOzWoNPMBtcps5o4hTMWYWJwklEmQbplrAoGoTqPuY8elSWRc?=
 =?us-ascii?Q?FwI2hcxMAGfhqJeEsGwpHyPByyhxic+rQDduVsrIKTu5aaDBSjWyNreCYuH/?=
 =?us-ascii?Q?olJC/ROD0HBeV/qhW83G+SQuVK4GSTWEUhnOOHCGVV85TwhWOA1x2XVGQJp4?=
 =?us-ascii?Q?Y+PVM0KDlx+V3QwL1Hb6JrVSyDx2zSmu9eJf9AITrKz8nXU0PQu2OMKVkgHv?=
 =?us-ascii?Q?1GIoQds762pK546biN9DGQ8UGVdHVbMoiyXp9srbuPBkvh2WsKt/PE9lWk33?=
 =?us-ascii?Q?IkRWdDsRcCfsLC9g80d73iB9UjyqtxV6AuopBtTLgHi6mdEiB9f3q47EKI26?=
 =?us-ascii?Q?DvVqaXTFcf0U59gh9c8Lgr1GFUqYm5ADnJ+/qsf0QQt6u7G9so/UXCFKX3sI?=
 =?us-ascii?Q?Sr8Kpq9kfdS+TKnqr7miyEXE2OjcYnIZoWrHde4tAmMe9MA3brtXBTQgz1la?=
 =?us-ascii?Q?T7UlCJtulCNQJ1VG4R21fzzD2ZBBtDstvvSv4rePhNchZx87UFyL/BI68wDw?=
 =?us-ascii?Q?oBTmnZ+M7xM29sIxcx+XQ3LkHvSrBvdEejgfKiQuNgSapDMTFo4LcXO24Li0?=
 =?us-ascii?Q?2dnxZHRTCsxyQztf2oceM+cgp2odJncrPLQbGMmaVrc9OdrwLLeVCw7tzACN?=
 =?us-ascii?Q?g+s7s7xfWUoGnUZG0tjPFclAoU2AgVylgSI4mnFNFPY/3zIRlEaPfIuZ+0dP?=
 =?us-ascii?Q?5niBjkr6RlhjpBtFYovbR80DxyqyImo0U3J9VP4OKWa1Jy0yf24+o1VOP4O7?=
 =?us-ascii?Q?bWAUWeNJCHzxc6mLVa/mvoF1XOpk+63DiRqutISZrYcQpTle8LccDmNeF6Bn?=
 =?us-ascii?Q?Z2qqRSkWz0Ydo824VdvH1x2UA40hm5E3hX2M42ee8XRahFBNPpLzzAEcpuqj?=
 =?us-ascii?Q?xnpriJwm0XRsj8jq1DsavWmUcrZv6+ZL6Tx9z55rdhzyCxK5u2Dk1HKEv4dD?=
 =?us-ascii?Q?N6b21sjnoNnOr67bHsnunxqqvFGwRkIO2gTmyTBr26s6Bs6vnQIZM8LJOM15?=
 =?us-ascii?Q?lU2SvbBEPTAU5+uk1x9VAOXAzqdH/GuWP6PBdCRN87bbo9AtZhr8/+Qgr8dU?=
 =?us-ascii?Q?hGNhyB9qngWN3PKH8g0So68CaAmNnWHvtl+1L9zaDviPm6X4GAzQw/6eudFK?=
 =?us-ascii?Q?er+UvkdOxkRxVAmnJ7NUJJL9WwuvdZSWRQtT8IO+E+bLnNbfIjmzNuojA1eB?=
 =?us-ascii?Q?VwS/ojiebYAKd5xVIiEzgL2vpbQz0jtCnX0AQvZCcZ2CzLH/pWQuR2oxVjr2?=
 =?us-ascii?Q?RQBZih9oR5FfavspaYiyZCe+SOjPbjPit/UOOndhkFStionBhU1u6ey+lsWo?=
 =?us-ascii?Q?K5vpmrsG19L5/U37nELyl3uOLdNRd2WDqCIyqFmexJJ+y5lS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f4a1c-03a8-42a4-95e5-08dec2791514
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:37:23.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JYDasB8aBb6uC6qv6N4SZLx0eXQlrp96aG+l1WyA6oAt2CkhtDm5EqPAs1zPzP/iv0K2SsjcBfxdcn+5YSvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11174-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lizhi-Precision-Tower-5810:mid,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,valinux.co.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15BF96436E5

On Mon, May 25, 2026 at 03:24:16PM +0900, Koichiro Den wrote:
> Move the platform ops pointer into match data. Existing EDDA/MDB matches
> keep using dw_edma_pcie_plat_ops.
>
> No functional changes intended.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - New patch. The original commit
>     "dmaengine: dw-edma-pcie: Add raw slave address ops" is dropped
>     per Frank's suggestion. DW_EDMA_PCIE_F_RAW_SLAVE_ADDR is no
>     longer needed.
>
>  drivers/dma/dw-edma/dw-edma-pcie.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 9aed1005854d..1d63b07723f9 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -77,6 +77,7 @@ struct dw_edma_pcie_data {
>
>  struct dw_edma_pcie_match_data {
>  	const struct dw_edma_pcie_data *data;
> +	const struct dw_edma_plat_ops *plat_ops;
>  	/*
>  	 * Mandatory callback. It may leave @pdata unchanged when the static
>  	 * template already describes the device.
> @@ -383,7 +384,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
>
>  	/* Let device-specific discovery override the static template data. */
> -	if (!match->parse_caps)
> +	if (!match->parse_caps || !match->plat_ops)
>  		return -EINVAL;
>
>  	err = match->parse_caps(pdev, dma_data);
> @@ -435,7 +436,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->mf = dma_data->mf;
>  	chip->default_irq_mode = match->default_irq_mode;
>  	chip->nr_irqs = nr_irqs;
> -	chip->ops = &dw_edma_pcie_plat_ops;
> +	chip->ops = match->plat_ops;
>  	chip->cfg_non_ll = dma_data->cfg_non_ll;
>
>  	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
> @@ -577,11 +578,13 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>
>  static const struct dw_edma_pcie_match_data snps_edda_match_data = {
>  	.data = &snps_edda_data,
> +	.plat_ops = &dw_edma_pcie_plat_ops,
>  	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
>  };
>
>  static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
>  	.data = &xilinx_mdb_data,
> +	.plat_ops = &dw_edma_pcie_plat_ops,
>  	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
>  	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
>  };
> --
> 2.51.0
>

