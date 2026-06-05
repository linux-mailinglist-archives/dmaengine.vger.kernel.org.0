Return-Path: <dmaengine+bounces-11191-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q+grOVcVI2qahwEAu9opvQ
	(envelope-from <dmaengine+bounces-11191-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:28:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96C64A9E3
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:28:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=TowAr7k8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11191-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11191-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6AE4307BF0F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48066363C63;
	Fri,  5 Jun 2026 18:18:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD65464D;
	Fri,  5 Jun 2026 18:18:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683516; cv=fail; b=PsBUCHX+hZFivJ3/+CnEbx1w/VmgJHJBOd/+Wmr0nvs1dNGTr5oQATQCJUHV616trVJprVBuwQNMbcQKQSsycXN6Buq8Gd1DUM1OTOIDTLZh1h3qZanRzI3DpK8Wy6E6tWGgG3FMSTSogaJVVQORC4LEPHmSQ9nNqD9SmGFYc9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683516; c=relaxed/simple;
	bh=8ChIDkIeTaCEDWRBMo1gGymy8opRGb53Fsw8h05CzLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K3ZD4wi0AueMcJRAOkP8f3GcNuXQ+iHZX7bLXiq/eOW15FMUHHteddmDIipRk3LZxSFX2VqjrGfpHjTx2+GynJblqU+ytWCewK+AANr1Zj08+ARUPXKhunz/ih0I+n7VlMmcPBfIaeDXTQ1rrVl5wIDh0s5w9jY58XPgwSrMfd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TowAr7k8; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mhd+QcxKNDpJGnLHO9yoMMTpYl6xish4UGj+wubuc4DXnvndPDHJWSdpqUMD1My9lpNYNPUlhRGTSTjYQt1L/t3l/6f7uJvzE+6Gnd7rLzkddE+tR9n1MfatxS6yB0PTANwR8CiSluymsQt9CCWVLSwg1a8daccmnWxbpzPsLHyPVx6U1IvBxefCRLduMEzHZO/lKpohB8x5UUSoilpDC8wWu21/S2vJS8CP/eahIy8jRFTGNvVINYutiqdtuSou2cembvLlYI7HHau+lUfLs+vZslpZo0yjBN+aHa0gzoDonWFQWhq/2efMBYBOn0jQRk0+hDfONUPGnysOMSlXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PwpHd25vN1UrT3kYzzMOBfClnTJVl6ssAi8pI7TP2U=;
 b=DAgb8xywwTCurUO4L0gKnO8yLkrM0sdeNsEZb+J2xY4f+R9sNvIyAJBKy5fcR3nJW4CaMtNYoJWI/XXYeWHTnm8T6Bbe0YtYXYeeZN2UClYT3UH1PrD238fxByPD44CjxB/uv1oKiwyzYDVf5LHZJKE2INxgrUwQU16VMmWtSORWlGrIIU9ICTHduzU/O9qKRdRc52MUyJF5giaSaIpZirlnXEmhKuV7k8Mwx/XL0vfJV13RtzGLMCJt/lzkPcImjw/VLzDVdO0sL2f/784CrmMMyQySjjV9OQ8pq6LpvRK1AskG7TX2QCInMuxkEpoBmViY/L9jrhoJ2uESAr8/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PwpHd25vN1UrT3kYzzMOBfClnTJVl6ssAi8pI7TP2U=;
 b=TowAr7k82SdVa2KrYp2nWkl9A1MU8dKtSonoOuK0kbYzhVbfa0u8fxM48OlmQvqaBNADWkKdTIQH9rE4ABC4UOqxY1F/07LML9UmUYn7tip7VMZFI44RFLKugUtk+8oN+fPuC8N25KZbWEtmNy5XT7afPI0FOAZLfom0joQDxPA7+E+tviBvsA6a09cLqvUuK9grHeegnP5sokQl2Sz8o+f9E9LrK4gwpPYd90NwOZWrgloFe9gLXAEj+8bvjbHjDwLum4+vsLAGCJgUryBUNRr4iawebQuH+WcvmUY2VlPgcJPCCQsut/7wk7bAccrJkV5YgV3p3zJJCtIVHjsUJg==
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DU4PR04MB11031.eurprd04.prod.outlook.com (2603:10a6:10:592::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:18:31 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:18:31 +0000
Date: Fri, 5 Jun 2026 14:18:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v2] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Message-ID: <aiMS8D3j8hTgA9Dd@lizhi-Precision-Tower-5810>
References: <20260605112829.679697-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605112829.679697-1-devendra.verma@amd.com>
X-ClientProxiedBy: PH7P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::22) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DU4PR04MB11031:EE_
X-MS-Office365-Filtering-Correlation-Id: 900729ee-2d07-45a5-0617-08dec32ed934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xUFX0YoqAk4qlB97ngES0gcYzf4MB90HmH0uFounkH5R/DY1dl+W4agIM4GPp/OcGeNJLo6aPAjOs57tjQovLrxp/63sXhGFFn0dCzdXEcU/WpnurYoC1GDEIA4ztQWO21HPpgKPjLZKDkVLu1VbYjN3Y1/IYv2hdlba52u3ZWE4vJLFrXXpv9TWV1fba3rBkOINOGTDRjB8VX7Vh/BYbByCrLBJrcuu82UF56uXpxMH7uPGlj1DuBI1+rCvSRESuJOSkqrHBun5zT0rej3MNZN8Me46xDN4bw0Uv3CGtnq3vX1hMMbPoJl2x8Foo5palL8+bc4MtuKc4gpkbqVm1RP7HgyyN6g/ipoBa7E7nhcRIugf8oyawhJds1yViWcgIG2DPgURrhPr4S1WEBxMBU+H0u5FQv5AbymZ9WM2ZW8O2AdIZoOuUPqKAsqId432NPxhXyrss506P9LPmfl7Y1POe9c+5uPf5k39A/Psf6AkgoFEgng4B9QnOzMOV3zcUCtzjeKcC43X7J3SkTY81ZmbrwSyH5BNwH99+0Bj9MYnfHqMvqjHLJQsrRDAWX0CxtOgC0SNeHdAJHwGvdbKyrGiD1Slo6CWDW8XZuAEXtnIWxYVBBkq7Fwg9uWiBGYWJfIhFw092Xa5XVBVelzRYw4M5yrT0wCHRt7qCPv/MCJ64ZIMeU6NwxyYVfZClf2XW2NC74xXxS/xY8QenozP3f1DFBUs3oyRLnGdqOPub5vBmQ1T/YdnoWJWE6HW4N+k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAq2AM0bXDKGqaSkTBj8KecKUZflro+o75ex4k/B6pOn7UdSGMH49c4H2yX+?=
 =?us-ascii?Q?avN6E3K2xE5K6nI2F0YuWzGSGoZJz82yHpbclOtyVZ9lloo8z4/XYTvgPcfW?=
 =?us-ascii?Q?3vR37Cr/xqA7XqB8J8JBfnenGxpsppYanv1iftIOamiOQvEAuLFoZVflZhst?=
 =?us-ascii?Q?pe5shL3k/2/LkzlCgfKYHrKBxBQq3KZLIfL/yo+wfuTWn6+ZZ62svCuYwBcV?=
 =?us-ascii?Q?DE7GBvd5ieyApuIpWg/SYhmwCfd2Dvnnx8MkteKN3XHAzrSpsgzdDXiOWAl5?=
 =?us-ascii?Q?N69vjrpVjIBJqZSUTMjjmHjrG5dniUzeY2ZsSY4FhainC0ubF5uxstuYDa1V?=
 =?us-ascii?Q?z8Va/jT1F5kCFeyCYK4ob02mqWJAOnOejmsScV+F/TN/Vaa752H2AZ/Rz1+L?=
 =?us-ascii?Q?v+6SzWmKIQFkQ6WjufcS3j4W0sxSEMnsbt938Ux3uYgrHPhy5JDZlbW37xOb?=
 =?us-ascii?Q?/abmh3u8Ii6dhcMb8AY4PYdaEPpsulkyeDmljIw2mkB/MtQD92DYnAhaJVYp?=
 =?us-ascii?Q?MP5NyJfKUVcUz0tzejHryRm2qF/Goxgg+bIe1c+Xfhzd+c9pFIS3qdifbSUq?=
 =?us-ascii?Q?NNeyzXw/F04X1pI+FPxqDGoeRRa/EuTysG7NMXEhaIpmfYgURsSA0L+MMPg5?=
 =?us-ascii?Q?I1eN9bWhxkomBRhKqyoPgyVgDMe4KGf+IRU63X7wzSmXm4dzBr3TyZPtMe75?=
 =?us-ascii?Q?YbrEhn0URp+v9hXbtvJGANJO72EwL3GkDq5Xupv8T6u1pd2sFj+hua5hgxDU?=
 =?us-ascii?Q?6l0xbUbO8hLNDEHQVizFFIToFWcd+pxQ7385JUPFvLr7nee8sy9jd6vQVy0e?=
 =?us-ascii?Q?TwxaRw64XI546Uk2t5MHbrdfFF9t2EJisfa1PSj7jPdjQlVtkaZSNVyoiDDV?=
 =?us-ascii?Q?tpaBBv2jlKYm1QccMs6mqE+YjldhoL6JXdmns/EvREruQY5f1rrtuS66TkWr?=
 =?us-ascii?Q?lcgh4e6igAVK6fGLO3TAsY/PTeT2f7SAFeSbj5dv7eA8FzXFr1bCCE8QwMVN?=
 =?us-ascii?Q?wl7Q93GxYJh+RX4/9jZVad4BtMxljFZnXP/FNdReelVPcJHhBxyUTVE5xMLs?=
 =?us-ascii?Q?iLweciRdceAKHoB0R36nI8dQigHtxKHKLnTcUtKGYXn4cKo2F+TTJv5Wu5xD?=
 =?us-ascii?Q?7WqtYEwU7vUOhWj56wTPbT1gFbhT36jdJgVxlboisuR6YalOmjHEruBxnS/5?=
 =?us-ascii?Q?ocLoa42F+1+XfmPlsuM53+fpDhY7AG0Y2p16pfw8iLAqLDJNbaDJG0dwK0PB?=
 =?us-ascii?Q?2ywCma3LlKj/GhTH8VsdxEiyelDE0OGKtZTQzTnzLjk580gsxYW1Dl81U9Ov?=
 =?us-ascii?Q?8N8yN//J1HNVBsyDWCMkgbZ9pku+XyyjYsA3XPBbV9dRKyp1gaJr1RRu2ogi?=
 =?us-ascii?Q?gcDMhNwhZw8pcuFfBdk5AOFctwqtAnkrYMUaDFBlr7f3D1OfCyIeCW2qAnM5?=
 =?us-ascii?Q?5Eivt4LuYeZFE41OBMX3hqdBon6wZ3HDm9wABbYUIz16QIHbG5Vt/qbE3Qku?=
 =?us-ascii?Q?jZGYy9YJ2tuaDpzC8bR8ulrLtu1g3wn26OwEx5xP8k6xnZ4NQh/GW1+AWgts?=
 =?us-ascii?Q?9nXSnTpidprPoR7SXN1nOsZiUEM3nH+wczHWsRyupPJ6hiRdWAUrrymHyTbj?=
 =?us-ascii?Q?9TGvM8+BJNVuQ0ojvuTrO0xnEuMC1BdGya7J6isPUQcl1sIyqvP+re4JFVag?=
 =?us-ascii?Q?PF3CeR+TXmyQksG575n9Z+kZO0Md+vGiLe9BSnib5dvg21hfaVYNy3P7y7s7?=
 =?us-ascii?Q?iY95lp9chQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900729ee-2d07-45a5-0617-08dec32ed934
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:18:31.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlKhYk0OhWzBKeoRNiYVsPU70/8+OZ4UHBjW9zCkcCX4WNiXrXeIcNIGaBtv1Sk+H/Pqr10sFmEeIN5sMWlwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11191-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lizhi-Precision-Tower-5810:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B96C64A9E3

On Fri, Jun 05, 2026 at 04:58:29PM +0530, Devendra K Verma wrote:
> From: Devendra K Verma <devverma@amd.com>
>
> Add Device ID for AMD (Xilinx) CPM6 DMA IP. This IP enables
> 64 Read and 64 Write Channels.
>
> Adding the relevant dw_edma_pcie_data to use 8 Read and 8 Write
> channels for initial commit.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Change in v1:
>   o changed the pointer assignment to intended pointer for clarity.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..2082d0021a8d 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -27,6 +27,7 @@
>
>  /* AMD MDB (Xilinx) specific defines */
>  #define PCI_DEVICE_ID_XILINX_B054		0xb054
> +#define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> @@ -125,6 +126,19 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  	.rd_ch_cnt			= 8,
>  };
>
> +static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= SZ_4K,	/*  4 Kbytes */
> +	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> +
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 8,
> +	.rd_ch_cnt			= 8,
> +};
> +
>  static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
>  					   enum pci_barno bar, off_t start_off,
>  					   off_t ll_off_gap, size_t ll_size,
> @@ -547,6 +561,8 @@ static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
>  	  (kernel_ulong_t)&xilinx_mdb_data },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> +	  .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.43.0
>

