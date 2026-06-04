Return-Path: <dmaengine+bounces-11173-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Q+VAM/iIWrfQAEAu9opvQ
	(envelope-from <dmaengine+bounces-11173-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:40:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4DC6436D9
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=edj79Gy4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11173-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11173-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951233006144
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B1396D03;
	Thu,  4 Jun 2026 20:36:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79216366DB9;
	Thu,  4 Jun 2026 20:35:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605360; cv=fail; b=g2+J5NBi37c0ziCWIvP7OLi9UUz4If+DCDZ2+2Ok7xCtsTjlQtJm2qIB46qPyV92jR9NLdO4HF2f9bVdkBTvf7HT+TApckWXfQo1uk93UOE8jvgH/UWB+UVpMSAssx4Ocd6rahlOZm/S14JVGhrsY13UUDsoP1eOYVdDWwwy+gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605360; c=relaxed/simple;
	bh=RfjfaQbb4o+FOs/mYMGc+y8I/0/ZtpEUzeIrLU1dZrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FOAkbvKYNtDJzrHCCLadgRjecZhRO2bwm4djrCOUqsw2c5huMd/GVfYWlzcCc2MxKuCgDn+tAzEwunYj4BjrYtn5CK0xtW2TZdP7VUghe9ACZuuiaqcURFC3fwCdSBXzAzka6BvaSM5mmOl+7tHp+UzfVnh0GiIpYdxCPfsgM48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=edj79Gy4; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYECrDqVVtxjS1P4URlBPbRpoE3TUsoMQf3jebYe54mTLwmFkim4Zu500SORWfhPQcFKrdYXNW5J38JwTDjBOzUO9bXfqDPR9CaUd3IaVX3G2vVeeIGwAqa29KsM0sPx85DwdPOrTVGYfhAWCYVoKe6qSxVUuimkcvLeOi2H4aQS1TRCNg3it7kq4y6HAfEbzyOcuhKm7/b2xGWvx/Qc/OgwvA3nm2yC3Kec1sOHBVzA8LX26m7Zr84DOJOI4irzSP7b3Eo302IEUL0gh9rrv16ZYFBh/DlokR75S56ZXpAG+sEBBg6njEo+FdeINnYBfe/LMvzJft7EswM3n4ritg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIG8YpDeLF0zvDGG4GP9ZSIs9RQyRSnTwxKflc5tMmw=;
 b=BcYv/4VhJ8mbFEm7PnFok5Kh6TUXwzH6sWd6CabI3NXofx2zZzSBVCYu/oAeuy6ABDA6Ki8jmV2/cWaGFyl2oEIrCIHcgXQszhShm4r0cOdCR0msaJtnXTQhiPwGJAEWkJZt7qFcJFqa7WfZacsfS2gblgf1JhMwOujN4aaxAo7sM8lZ8zvRxCQCsEee/W3K9OWJU3zuNGpIsg0sRZymYrVs/gBCGPdXfgXfKjfVdUyp0KlkGZHWDeUkL4CnqRju3ld9sP7PhXFM0AiPAhSlnuRjQhIQ+iHJ4XGiwX9TfJhriv+3tpczKKIDuOWGJi+f7e9BD9a5V1nfNqEhCcBSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIG8YpDeLF0zvDGG4GP9ZSIs9RQyRSnTwxKflc5tMmw=;
 b=edj79Gy4Kf/KkAHqTmla2weIsgoCYXGh7sfHitiS3flVy4C19c7EVj/2VLHnOLdfDVihmikrRRmDa7YdUAYSPbcAYC/vxqi+1HrZClXM1V1aD5Xd7zVnRAYFsuzeHSSUgEbmClONNcNi1NZn+pyPJEagxFk66HuQyWP0V65gNcug9j+UglfTc/In0UVPR9EqhbWwxgVJ5R/8F5zgvlq5M4VnsBVcyaTmovweZDEJ8IiRoxMQ3FK4OSYapnFngG8GLXoq58eYwkKHgSBeQR727oS2qcgMxdTMQqXvLZ+XDyQXqrzjFhdc7XgTsbUy+y42CWRdfpas/LLxh8bnRAm7Gg==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB12066.eurprd04.prod.outlook.com (2603:10a6:150:304::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:35:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:35:53 +0000
Date: Thu, 4 Jun 2026 16:35:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] dmaengine: dw-edma-pcie: Rename vsec_data to
 dma_data
Message-ID: <aiHho-N3u7MmB5uq@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-7-den@valinux.co.jp>
X-ClientProxiedBy: SN7PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:806:125::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB12066:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f6dc64-5881-475a-b59d-08dec278df6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|6133799003|3023799007|22082099003|4143699003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	6SyI7OmapHeiaR50n+OPwJuxuvCQmWPOe5wklOA5T4urSxa/flxJ+iTn897mHpPglboTnvywApxDdVtrSBCJuxpiE8Baqhl9XMBPdoyuaPl8HGGI1qrL9cA9Qnc8Ddut/uPidb8k4LiLccU+C+yqguKxrpvb8PRV+8LJIYi42ycIr9w/1XvmBsrIkzr+ZEIaRMyPeZZ3iunK6gcjz4exGnCdGVubZqUOPcDo1eCU5l82qEzfiaMWAaPLyDFjriOcbRUSpcX2U/dnid5ANpl2rDIuPq3sVqGATukpwf5csz44aRODKzDa/nsT4eQWPFlDRV7VYso8XVtqX0tE0QGC3ypQ+HStueGTM4WPuNP4G7stHkbOpqbIZWlR4Srz4nU6RviMMGqLQN7X2JBmDxA7scwFXqb8yIGyCS0ocSHaI/rmMTrUrB+J7N2y0S5+X6KxR1vvY2SPt6hQCBfnMf0XLCPJ1eEwucPf8Y6sTjpLkI7dQFEPZi1TvnVRhlxh8LPWbAw9DDg2cN2N3YJ9DY+GtaI2SblaXe70S2QtJy8NwhQOxWaPCnBZ0Zk+F0AtDdERZYOUYI3iDXh6NWun1pTFjV0dMV8O3VUzX1JXYJDOuZZatc3/MtoHHv3CKojPRLYYmx9avBSrbtunjoLz0owYNBuI0DX9C6+rjGUSfGiy4imoC+It2Rzxk/lJNfSYNyciEGXrFFHkRlS/+wgVxCa8Cdn3EweEatbKiXl/hxRzDK9H2590+ckkPhIx/t6i92DG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(6133799003)(3023799007)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kc7gYDdefH97/lbo5CHRJkOhGcrkG8VDUHbHdZIvoD7PEJ5Pf5wZ0777cjx?=
 =?us-ascii?Q?rIzAYAhQBKl3Q0cgjPainpXGbHUq7Qp8OnxFGxZjmWTa9JDTKHj7bg9xbiGk?=
 =?us-ascii?Q?ZeFvTV78CuzydlMkJFEg0hzRaM7wYkzZ1Cj5E81kyMIiIavdkgsLGEe2bi1Q?=
 =?us-ascii?Q?sfcejgecxGaT+dHhP0SFjPv343k5qQg/vNLwLRmlTjLieSzBddIBf9r5VJuS?=
 =?us-ascii?Q?sshRYSO9LS+nrQVvgnyLzRmbVQHLhrXnsgYOnqQbcmRRnaniJDZYCLIVtn0v?=
 =?us-ascii?Q?zM8bUICJ3vToxZlBiGVmlqO1MbEH+qiL/qSIkZ/DDSGLt6aAvSQrBljFuUJW?=
 =?us-ascii?Q?UVJ5dh/W3Z0Y6NGvcl5k1sBN1LCg9dxam04gOBSSqK2wiLZMfx+MGwc0kRXs?=
 =?us-ascii?Q?UhXtLMEn7HECPTgWqGIdLD7RvkxD2e34sbK6fMvInwCdNcSFNziDEQ1j98HP?=
 =?us-ascii?Q?wPIdnPFpJ+GPqejmBlOxEJ9V26xX4VskdfmGpKVaO+39d9k9rygERV0qG835?=
 =?us-ascii?Q?g7H619osoOIxiu+AHoE/WerlKTowcWDjbDMQ3CtgEzR6GXX3RpdAGDfutYtA?=
 =?us-ascii?Q?31JM4BkrZYuA/frdqm0InvP5oIIKtJGu2sKn+0VZNvCFSJfhVkhgKx9XRCHx?=
 =?us-ascii?Q?l8t5cVMe/+/tXoUtWIT5cYacTnf5XPsNC6zswOYa59mVgEYgA57s2dL/wIZe?=
 =?us-ascii?Q?tYG4j7pTUBntF88ol1cqAqrMdxMvQpo39MLI9QTtN0ORXN8GFfaAXqoOZ542?=
 =?us-ascii?Q?fjZFK8d5jFika6vQIWZFnhvasgswbdhfRPzj6g816U5+6/uoecb+6jK/L+vH?=
 =?us-ascii?Q?u02GTCZ/osUYIPQs0+5oKC+DxFLZVPiCdWES9g7o8ETpl0FmC4ZZiDK48qs0?=
 =?us-ascii?Q?5I7AYHTlMB80zDbEYE1HiaLWvAxyD0mvZbw/iVzB9N5jwE1cC0SX9g8s4ZDA?=
 =?us-ascii?Q?pDX5CjSfT6niZUlLdAZhLV3EVWbEdwIJdzN1bgmPa0i7wnJKZLSm+ib8EDEd?=
 =?us-ascii?Q?cNoKLlpn/lKwrpAC0SAGj0d7p9qYDmbqICdIEVE+dh237Br5kDZEEOqiVqZN?=
 =?us-ascii?Q?g+pAVlG+gwbcuh324JRVUoaII8JeZxEniTSztRilLGueYnLXF6rcDOHzhLa5?=
 =?us-ascii?Q?cllxBPKG+PX4FhjIyhmb1cJ0zbcK0SdynMu2lPRsj7k2JM7H77I2g6N0L61M?=
 =?us-ascii?Q?pRUmv26WxZBuei/GGJRbHc84gTwJBs/GBURLQ48w1VlASbs5Ld7vabPllQmj?=
 =?us-ascii?Q?fJp6xjTr+SPIaFuGW/jWY+W6GOYcq7jdJE7nBBV9+Ypi29gui1tHqeQih3wi?=
 =?us-ascii?Q?8MBfgHEo3fi4wEScSRmt0HamG0tMZn8zS+Xr079dggnJkAqpoQVcSCT01uXI?=
 =?us-ascii?Q?TZsQ3tqcgPqgU0J0fYfAXX/Qcd2DKb7dPHPuh21heHS12zoYpclo4q9GeylG?=
 =?us-ascii?Q?fXbSwDwbLqem2XBvI6ceC53QVosl7KZWavKerEf9+CXHMDUC4UyydynQvz4t?=
 =?us-ascii?Q?r0CfO0SCs7gXIIIWUS2e5QL7M8kDtK4WEG3yOd361XXRyTyiZvOgKsOD1P+3?=
 =?us-ascii?Q?PpBkbK82LA3R7XQBIYYl3HwqNovKgDxcxmfEpkMxXMduZRSqjMbwUN4mqoh6?=
 =?us-ascii?Q?E0wCLLxrWWXHCqJ/hVQgC9rbla170NavcTgByo89q6FOFCMFhODEETih1ywC?=
 =?us-ascii?Q?2tfI4heHIGmtZOQc4oW0B6wWP8c5kn3qFM8lerRsKkrqVSn2sFYwx3OYmMOE?=
 =?us-ascii?Q?uVSJ9Aa9UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f6dc64-5881-475a-b59d-08dec278df6d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:35:53.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1QhmLDURiB1KIorKqDYk946AOcPZ/2tEKFcvJWlIB2ZBbmG13iMMyEroKFAR6gMn/3X3hhUEL3jzet9c5Nvfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11173-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lizhi-Precision-Tower-5810:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,nxp.com:dkim,nxp.com:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4DC6436D9

On Mon, May 25, 2026 at 03:24:14PM +0900, Koichiro Den wrote:
> dw_edma_pcie_probe() now obtains DMA layout data through device-specific
> capability callbacks, not only from PCIe Vendor-Specific Extended
> Capabilities. Rename the local data copy from vsec_data to dma_data
> before adding endpoint DMA BAR metadata discovery, which does not rely
> on VSEC.
>
> No functional change intended.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - Fix the commit title as Frank pointed out.
>
>  drivers/dma/dw-edma/dw-edma-pcie.c | 76 +++++++++++++++---------------
>  1 file changed, 37 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 5a6f5af358d0..c7362f1bf80c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -369,11 +369,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	int err, nr_irqs;
>  	int i, mask;
>
> -	struct dw_edma_pcie_data *vsec_data __free(kfree) =
> -		kmalloc_obj(*vsec_data);
> -	if (!vsec_data)
> -		return -ENOMEM;
> -
>  	/* Enable PCI device */
>  	err = pcim_enable_device(pdev);
>  	if (err) {
> @@ -381,25 +376,28 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return err;
>  	}
>
> -	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> +	struct dw_edma_pcie_data *dma_data __free(kfree) =
> +		kmemdup(pdata, sizeof(*dma_data), GFP_KERNEL);
> +	if (!dma_data)
> +		return -ENOMEM;
>

This is straigh forward patch, you move this block after pcim_enable_device();
I suggest keep original place for easily review.

Reviewed-by: Frank Li <Frank.Li@nxp.com>


>  	/* Let device-specific discovery override the static template data. */
>  	if (!match->parse_caps)
>  		return -EINVAL;
>
> -	err = match->parse_caps(pdev, vsec_data);
> +	err = match->parse_caps(pdev, dma_data);
>  	if (err)
>  		return err;
>
>  	/* Mapping PCI BAR regions */
> -	mask = BIT(vsec_data->rg.bar);
> -	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
> -		mask |= BIT(vsec_data->ll_wr[i].bar);
> -		mask |= BIT(vsec_data->dt_wr[i].bar);
> +	mask = BIT(dma_data->rg.bar);
> +	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
> +		mask |= BIT(dma_data->ll_wr[i].bar);
> +		mask |= BIT(dma_data->dt_wr[i].bar);
>  	}
> -	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
> -		mask |= BIT(vsec_data->ll_rd[i].bar);
> -		mask |= BIT(vsec_data->dt_rd[i].bar);
> +	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
> +		mask |= BIT(dma_data->ll_rd[i].bar);
> +		mask |= BIT(dma_data->dt_rd[i].bar);
>  	}
>  	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
>  	if (err) {
> @@ -422,7 +420,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
>
>  	/* IRQs allocation */
> -	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
> +	nr_irqs = pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
>  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
>  	if (nr_irqs < 1) {
>  		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
> @@ -433,23 +431,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Data structure initialization */
>  	chip->dev = dev;
>
> -	chip->mf = vsec_data->mf;
> +	chip->mf = dma_data->mf;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
> -	chip->cfg_non_ll = vsec_data->cfg_non_ll;
> +	chip->cfg_non_ll = dma_data->cfg_non_ll;
>
> -	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> -	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> +	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
> +	chip->ll_rd_cnt = dma_data->rd_ch_cnt;
>
> -	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> +	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>
> -	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> -		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> -		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
> +		struct dw_edma_block *ll_block = &dma_data->ll_wr[i];
> +		struct dw_edma_block *dt_block = &dma_data->dt_wr[i];
>
>  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
>  		if (!ll_region->vaddr.io)
> @@ -457,7 +455,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  		ll_region->vaddr.io += ll_block->off;
>  		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 vsec_data, ll_block->bar);
> +							 dma_data, ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -467,16 +465,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  		dt_region->vaddr.io += dt_block->off;
>  		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 vsec_data, dt_block->bar);
> +							 dma_data, dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
>
> -	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt && !dma_data->cfg_non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> -		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> -		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
> +		struct dw_edma_block *ll_block = &dma_data->ll_rd[i];
> +		struct dw_edma_block *dt_block = &dma_data->dt_rd[i];
>
>  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
>  		if (!ll_region->vaddr.io)
> @@ -484,7 +482,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  		ll_region->vaddr.io += ll_block->off;
>  		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 vsec_data, ll_block->bar);
> +							 dma_data, ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -494,7 +492,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  		dt_region->vaddr.io += dt_block->off;
>  		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 vsec_data, dt_block->bar);
> +							 dma_data, dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> @@ -512,31 +510,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
>
>  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
> -		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
> +		dma_data->rg.bar, dma_data->rg.off, dma_data->rg.sz,
>  		chip->reg_base);
>
>
>  	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data->ll_wr[i].bar,
> -			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
> +			i, dma_data->ll_wr[i].bar,
> +			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
>  			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
>
>  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data->dt_wr[i].bar,
> -			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
> +			i, dma_data->dt_wr[i].bar,
> +			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
>  			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
>  	}
>
>  	for (i = 0; i < chip->ll_rd_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data->ll_rd[i].bar,
> -			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
> +			i, dma_data->ll_rd[i].bar,
> +			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
>  			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
>
>  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data->dt_rd[i].bar,
> -			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
> +			i, dma_data->dt_rd[i].bar,
> +			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
>  			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
>  	}
>
> --
> 2.51.0
>

