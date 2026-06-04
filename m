Return-Path: <dmaengine+bounces-11172-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tMVHBTnhIWqeQAEAu9opvQ
	(envelope-from <dmaengine+bounces-11172-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:34:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8E64362A
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:34:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=ClKevTvB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11172-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11172-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42D6303FDF1
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D413DBD70;
	Thu,  4 Jun 2026 20:29:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F283BFAE1;
	Thu,  4 Jun 2026 20:29:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604954; cv=fail; b=DIXHJhOneyfRG3R4OC4DCho9kSl+gytmuj2RkdaKvGyR4qLuHv9JQHLMleEiN0j2urRSMudcWdSZjpLSUpul7UEvevYbrnR9wW1nmyF9+B06mriwKLG/1laIdOi/bbvM69Z88Q9Ifp0Mw2Mumvo/v9rfHnDB0VS0iSStX8pYYxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604954; c=relaxed/simple;
	bh=3Waz7jCWHPn9cxbaQAkIVaBDwtTWdckP8k+vsQW/0U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPTILOWq14o+Y+2J5XRCEMjARyUEJtiKOUl2vNc6ySwq7fA1BdbnMqCSV6nAvZvbDCiIpUUKCHvyCvRcgnb3yU/t1OLLJxLuuf5c6PVEnDzmcb0WfTEyDyc+Fo2/1yHCoT9PUYSDYOOVoGFhcicPJtpLsPTEgX4aPJOtKfSBrLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ClKevTvB; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji9C63wmJRrxJ3+MIRfuXd0At4xoVOhAzbWJyi8T2Sm7WN9RjDv3Z9RSKN/LVlcVF8Y6LPWLMARJAIWX/6NRJp0Ikr4t5WY13jTPDnJDgHszTLrecBYNqOq+IRunCc5Zwm0QmSwY78cdQ+sKSNZVbmTTEWYvOnztgtQ34ThInc2AYjiqtbxB0a/xJbaHttfCfVMH4uj/f7tFIthJ2u+1sdNBtYuMnaPEVDuMSz7VeUFYD1X2k3NETm4q7yMUYG8BhOAr1OnVwMTv9Qo5AxG/HsrjYf+Bh0oqR3QbB/D3euiDosH1RMH8U4uUvHiwN7O4we2fD3XKxy3qT3oaLib8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP1t8dLLXXUsqcpKakR0+Uo3up6CtbWyN7DslR1ApV0=;
 b=WQUWC0Kk+qrv08vtzg7j7lVsQ3/QkkDH9ceOZi79bJeIzY+Vuk7flWYvUh8uzRPbuuAfvkJ13MY14XWHznN4HQLzvn/0ou6FMti1dVj9UtAvKGGtzNZHK66I4RdGQzqp+7MuxZJjwQwxpwL318hCfot/xSUNyGUaVGJR9NSmnwMWE4GgD71YKr3s8pFjGTftK16/1q84iXhvOJYuGns/LWDUSlsNSJxmu1zXfDg+Mcn9tOlvxBF869cMmOjnMSNxQ3XMpuJfzi8CI+dFOAekG8SaID5eSGpHw3neuqEoiVKE3jN6eUYZk5dLNIx5opcMjRTzVvjbZESgvNkoLbUX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP1t8dLLXXUsqcpKakR0+Uo3up6CtbWyN7DslR1ApV0=;
 b=ClKevTvBaBUobgw0jaQ0Q2tsp0qhvbxPcSclpij1O+y0P5Iz9GB6dT1G4CtkD5Fal94rLCgYckhKBTw0vxsCTb3sZrUzkQf5dEz61GUyvVV8gQSjFQl3V33Xp9abKESVaoWCfJhV1nttTXPJzHnDNnnGrcrBC8pYB5jEl0NSH1cDrDinQZRvGaCdvtU1KnWOlFWTxdsced0Rc/VTI1IcNVtGzoskMi8rWqHFF3NnFZ6PEKTLXo7wpIWYl5AM4UP/h0ELTu51BFbXMmfroWnK1OuAb+JjdTONp5V7QkXG5l0OK9MmtINzBqgNxTdUAvGxlwtn/WsB2T3VLJU6Bhffyw==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10797.eurprd04.prod.outlook.com (2603:10a6:150:20d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:29:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:29:06 +0000
Date: Thu, 4 Jun 2026 16:28:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] dmaengine: dw-edma-pcie: Add capability match
 data
Message-ID: <aiHgC6yf5KWGXFsT@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-6-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0167.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10797:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d6cef8-b4af-449a-0ab3-08dec277ece4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|3023799007|22082099003|4143699003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	v7XnwJV79DcbK/RHKvf3VEZcKXCTIkfXnkGkmfZ/yphFxqhQE+Lwt/eiy2PTzv5p0JzX0ZFjCsOxVJkmgm3go/CVDFxLoDPkDoqDrqTcQ7IDH0V20xtT0k3y1q5S5LaDh75w8CLjZ20txjfPyPmV9poEemmHoupn+ONpEYDhhd9MwsQwTkotFJ6PMq9YTzwlz4RFL4y2MeicyV0DGx34kbcPucP/3hZlE/0VqsdG8E1B5ZcPEfk8snCHmkiygy+IvjgXCBqG2kleA4y7SIkk58hhUxFE/gI8K2beSiGcf+SnQVSyKhDPladuqXEow/Bh0PC6dvzT51/M5Gk3uI0QRIeU4Lzit5lvUA4bP17iYvPLcA1XggjnTE7NiUMjvm4JdHy1Ebs+xtf60EWEhCq97zVJdiL9QHgu3QiM8qHtPKTpXi6WUOuiGSAgW8K9au9meWHLHe0twR31wGpxpDv+H7u8I92NWuxCbzkZ6n8m/JwFuZK/lL9wlZa0kJynbGCCu4zohShzbovmWU6As3aZ/2qfNfkaxBNMWe01uDvAUCZpl1XFclG3EWMie45lNvLoXJgV4lmL3CbfN8GaJIMZUEixpenyseBvMck7PwPNczDaR6E2nzC7B001nIcfHhNKMiTn6gyv8x0t5hGkXbeCzaGHdw6UNjz8baXNzc2Rxq7PRGymWIKWFVYySy02HlOx0wO/RPWAUkAU7J8ZMhaLE8jZCcXqLQGB7W5h248r1vfUyt/IA0S903O6x9AO4vxY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(3023799007)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArwsHUGgsE0VSmc+bpMYWLftdMIUNUqcnKRQjql9Y0mGgmL59TWv42pA2A+N?=
 =?us-ascii?Q?HUy5qcavOceEgKl0LCVfLuDogBocXxfXeGrMIAmRN3459Bn2xTZlc/nBaHaw?=
 =?us-ascii?Q?q/IULQ3sKW0jLdBExb8UbSPo3CAKTSLcMRxP4x8MoQWkS5/rdc5dUyH/0ks1?=
 =?us-ascii?Q?B8S2mRFMh5tCmbxVweqAQKPxnQtvD8BPm5U4AkRbHdDnEoxRGDR/ygOXX1TE?=
 =?us-ascii?Q?wdaA+r+HcJjTSmzLaAMy7YfAImW151I7DEJObK6WCE7aQG40R+NAD8Tqc1OZ?=
 =?us-ascii?Q?8hbxNn1gIFi7J+pERQTwt4jTdAn041azg9I8twhE40G3cSrK1z8jCesw31pG?=
 =?us-ascii?Q?k8n8SQWCH2Q/6FOaq7gmT+t3OAZRlH9zTHDldU5TZ6N7bolYoj3LgksNZyxF?=
 =?us-ascii?Q?GL6scNA4/OVLj8j57/DUHjiHUIJNhgovd7+ztRUm0rirgUifnIoXJGln8i74?=
 =?us-ascii?Q?ioZIQlNJYPRDXMOWmk89hn9sNRC+OSB8XnXvVUXO9vRxZVj7fqknVTRSZq+4?=
 =?us-ascii?Q?09jsYkKGi8J1fsFnIECeBp2TIWZ1oJedgDRkJWRaxphZKQwI8j24PGLMvL1H?=
 =?us-ascii?Q?Mr9g1iVNsv0TAWQwzQId6VVhQASqeH8ylSXKjmDHLYkuEaIsNYI1ZQ9SIxoB?=
 =?us-ascii?Q?1nMntK3kBx2eDvN+PHznVLa2qwbUqQfTso9eo0u3xx/3GehFHOnRDdWn42IB?=
 =?us-ascii?Q?VPMt/ft/R7VVJzRCQqBdj06CkMY53eihd8+o1/D8lDLZWu6icU1dQ1e8bbhE?=
 =?us-ascii?Q?5HDLOtxIavO6pWoqQKqzkZw/YTYEomltBM8ns553dEn9YBajsF+4K816Letk?=
 =?us-ascii?Q?Pi3Qc1sX7v7VEiZ7waUXp8hVbWAUywTR+Pc85jQIgNJaQhETxR7FslDoxpL6?=
 =?us-ascii?Q?EkEMyu2zo8RrvEZPkcscKDiT4s/fm1EuoeyGv6nj/Qa2kLBUnB93GhfaQMGQ?=
 =?us-ascii?Q?+dMBpbqK1fd9pNXBV2VuOt6YLEalI1qH6HKJsiTaZQ+NuhYsZy+uMLUB5rBk?=
 =?us-ascii?Q?+xjmNZDKvJNVYbD88LM3pouNmDNMqc/ssdtobc7F3aK+QTBjomcRZIu1CxtF?=
 =?us-ascii?Q?4E7yXGuVrarGrPsahhmFuZGNar66aECxbH8Lmz6Sea6E8ktCXZIb72b+Je4Z?=
 =?us-ascii?Q?wkThgfRxl18IoRTL+Hy+6DI0QzVw2KAp+4wAhiW2fHHWZuCZkvix8qF0hfdf?=
 =?us-ascii?Q?Eb2Z556Jxl1nJ5A3Qp3r/syHQVbzjv+8ZFeN1yzRKbLq995ImkY8YFOHl4No?=
 =?us-ascii?Q?6ynVZyGFE2oTOe8Yrc8NoTYev5rU4ajUEOHJ88LAwv/WPhCHzzZc9FtIAa/Z?=
 =?us-ascii?Q?V8MEEFnm8KPNISFqSpp+xEQhIWc8Yq9uF5nTMvWnk18ySnF/FkcMCODmpaze?=
 =?us-ascii?Q?GhwpoQkKDv2RreC7Zz56NJWquXXMAwpDmcyZQ4DjoenS/9NSKydAyPleMkPw?=
 =?us-ascii?Q?qGffENaB6di8wxDB+/GHH79lTUdvWigimKxPgM3PHK2OSa0PuowV0tfAcO0Q?=
 =?us-ascii?Q?JvCjcnRVwid98N3KHOjFkxadfzyBTZSqXUThZ1CdTmv2/9l0ltE/eXpcEgAF?=
 =?us-ascii?Q?bA75Fcl0rQpvHaZo4rfA1Zba8Sn4dDP4NiuY2fmSWL2AblslBrkF60Mw/FML?=
 =?us-ascii?Q?m+05zxLDLF9KY5ZQrcZxYWO/33FKxYq8XfdXjYCJNOdgc/RMpF+S5TICU4gJ?=
 =?us-ascii?Q?t9jJm/dnnI2JolDM535+y/OjDr+u/ZwYNpoWIMxQ5VAGY8UcUtxBRMaGYtKb?=
 =?us-ascii?Q?Lrz2kWoXDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d6cef8-b4af-449a-0ab3-08dec277ece4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:29:06.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBp6g6D1qw7pKGI8Q2E1P9+vhtbvC2aEc1JOtPTrOoEDSZbXONhPURYRASP+a6sVmEVEQ7ZSKnUurwyvrryCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10797
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11172-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lizhi-Precision-Tower-5810:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63B8E64362A

On Mon, May 25, 2026 at 03:24:13PM +0900, Koichiro Den wrote:
> Move device-specific capability parsing behind per-device match data.
>
> The existing probe path mixes two decisions: which static template a PCI
> ID uses, and which device-specific capability parser adjusts that
> template. Split those decisions so device-specific discovery can be
> added through match data instead of adding more vendor checks to
> dw_edma_pcie_probe().
>
> No functional change is intended for the existing Synopsys EDDA and
> AMD/Xilinx MDB matches. They still copy the same static template data and
> run the same capability parsing logic before BAR mapping. The MDB entry
> also keeps using endpoint memory physical addresses for descriptor
> windows through a new match-data flag.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - Keep non-LL mode in dw_edma_pcie_data instead of a separate
>     parse_caps() output parameter.
>   - While at here, use a named .driver_data initializer for the Xilinx MDB ID
>     entry, per Frank's suggestion.
>
>  drivers/dma/dw-edma/dw-edma-pcie.c | 127 +++++++++++++++++++----------
>  1 file changed, 85 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index e92ff5dc6f67..5a6f5af358d0 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -75,6 +75,19 @@ struct dw_edma_pcie_data {
>  	bool				cfg_non_ll;
>  };
>
> +struct dw_edma_pcie_match_data {
> +	const struct dw_edma_pcie_data *data;
> +	/*
> +	 * Mandatory callback. It may leave @pdata unchanged when the static
> +	 * template already describes the device.
> +	 */
> +	int (*parse_caps)(struct pci_dev *pdev,
> +			  struct dw_edma_pcie_data *pdata);
> +	unsigned long flags;
> +};
> +
> +#define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
> +
>  static const struct dw_edma_pcie_data snps_edda_data = {
>  	/* eDMA registers location */
>  	.rg.bar				= BAR_0,
> @@ -296,19 +309,61 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->devmem_phys_off = off;
>  }
>
> +static int
> +dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata)
> +{
> +	dw_edma_pcie_get_synopsys_dma_data(pdev, pdata);
> +
> +	return 0;
> +}
> +
> +static int
> +dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
> +			       struct dw_edma_pcie_data *pdata)
> +{
> +	dw_edma_pcie_get_xilinx_dma_data(pdev, pdata);
> +
> +	/*
> +	 * There is no valid address found for the LL memory space on the
> +	 * device side. In the absence of LL base address use the non-LL mode or
> +	 * simple mode supported by the HDMA IP.
> +	 */
> +	if (pdata->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR) {
> +		pdata->cfg_non_ll = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Configure the channel LL and data blocks if number of channels
> +	 * enabled in VSEC capability are more than the channels configured in
> +	 * xilinx_mdb_data.
> +	 */
> +	dw_edma_set_chan_region_offset(pdata, BAR_2, 0,
> +				       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> +				       DW_PCIE_XILINX_MDB_LL_SIZE,
> +				       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> +				       DW_PCIE_XILINX_MDB_DT_SIZE);
> +
> +	return 0;
> +}
> +
>  static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 const struct dw_edma_pcie_match_data *match,
>  				 struct dw_edma_pcie_data *pdata,
>  				 enum pci_barno bar)
>  {
> -	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +	if (match->flags & DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF)
>  		return pdata->devmem_phys_off;
> +
>  	return pci_bus_address(pdev, bar);
>  }
>
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> -	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> +	const struct dw_edma_pcie_match_data *match = (void *)pid->driver_data;
> +	const struct dw_edma_pcie_data *pdata = match->data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
> @@ -328,36 +383,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
>
> -	/*
> -	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
> -	 * for the DMA, if one exists, then reconfigures it.
> -	 */
> -	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> -
> -	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> -		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> -
> -		/*
> -		 * There is no valid address found for the LL memory
> -		 * space on the device side. In the absence of LL base
> -		 * address use the non-LL mode or simple mode supported by
> -		 * the HDMA IP.
> -		 */
> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> -			vsec_data->cfg_non_ll = true;
> -
> -		/*
> -		 * Configure the channel LL and data blocks if number of
> -		 * channels enabled in VSEC capability are more than the
> -		 * channels configured in xilinx_mdb_data.
> -		 */
> -		if (!vsec_data->cfg_non_ll)
> -			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
> -	}
> +	/* Let device-specific discovery override the static template data. */
> +	if (!match->parse_caps)
> +		return -EINVAL;
> +
> +	err = match->parse_caps(pdev, vsec_data);
> +	if (err)
> +		return err;
>
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
> @@ -424,8 +456,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> -							 ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> +							 vsec_data, ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -434,8 +466,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> -							 dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> +							 vsec_data, dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> @@ -451,8 +483,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> -							 ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> +							 vsec_data, ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -461,8 +493,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> -							 dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> +							 vsec_data, dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> @@ -543,10 +575,21 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>  	pci_free_irq_vectors(pdev);
>  }
>
> +static const struct dw_edma_pcie_match_data snps_edda_match_data = {
> +	.data = &snps_edda_data,
> +	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
> +};
> +
> +static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
> +	.data = &xilinx_mdb_data,
> +	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
> +	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
> +};
> +
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> -	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_match_data) },
>  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> -	  (kernel_ulong_t)&xilinx_mdb_data },
> +	  .driver_data = (kernel_ulong_t)&xilinx_mdb_match_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.51.0
>

