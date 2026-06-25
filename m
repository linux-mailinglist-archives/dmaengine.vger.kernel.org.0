Return-Path: <dmaengine+bounces-11791-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9xTF1pQPWqp1AgAu9opvQ
	(envelope-from <dmaengine+bounces-11791-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:59:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1B6C73D7
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gm74hV4a;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11791-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11791-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D5A305CADA
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B42349CDD;
	Thu, 25 Jun 2026 15:57:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB30246774;
	Thu, 25 Jun 2026 15:57:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403022; cv=fail; b=qCNviaSiWWyq+qjFXi2P4OicTQ3OjW7JEZ4y2bKl6xYWRmEpALORTdu5OcJQJCQIaDNow2DZuX2aSORq3XsuSPsHIMO9e6TmmOGgUZOlc/N/lJM4O67/jvl8XcHDkNQk0A4dvOKS4FH2ez7j+tzYTkj+uoBxNdRlZW0G90+bD1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403022; c=relaxed/simple;
	bh=sVXR4YCdvOe6YEiUJNYsSTE62SKavkXMMNOvFR60VuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mgdarSZDnRsMb/+QghNs3j39gr1x31auQmhqA+VRokjqqs/PaxjhtN7u3KsVktHtGaJFEJucVGOEJFcLmYJkAythb+YkmR2zFriSRFPZGqT8GBpNy0LQyINss75+AzmpqOcWa7MPjrt7mvIuruBaVIbmqK5QsDltgulC+GSZZGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gm74hV4a; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaeZ/XeW5qvt62orLwlik9TnR38w2JczaFLoU+POO4/wxCbYKScmdNyAwAC+kp9o8pTQ+X1n2al7XpUSL+dzSjQsAL5iewS2UlUnpcKe2jl5uuLJ7CbJ4f8hc0U771MfppfoUigrT+kgGGTMt34XWs0Mivpy1O7cLXOcDiMsUmHPRdr+nb9ojtpqRY5Xj6SS6Mf3CVWDi/oUno6XgyeqGSHqwzIFOrgsV83kjtNwgCq+W2ffcLhrtICWDneOjCbL3zJRX97GaODKaxW3LR2FVat0jM2RschAk3HhCylxdkJIViePSiredUCJEOl5tDWbPpXQuFso7mOI98F0642EgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNuoA9JBtXP6Ofapsk3IHsbdAaIPrrlBgrn/LFWmPrM=;
 b=FnooHcnDpb4ROuuPUcRm5kdKGalSysxyVnmiWkZBvhkRho4CP+MMQ40HKz8Wnx/Ligub2FAJvtTSQM/XOHZkPQWc8rOm2dhESyfNpsL46LvG4RLe6Mzg6RKSt393BYiYoWCDSHPJjtupE1V7x+wHbFqUZHCx8dbz1OlbwSwIh4dYLrEJO41vkW3963hvwhdNH2op6CADpv64DGYVGuRR+p3SJKSJKF3MTI4clO3hlhcQYYxLn3Dn5GFyV7ZNiQLfa2zSYxAMGA1+TwqgPdCT7o3+10FvZ6u4ThTkJKkm1wYWHqE6iduFmWVpAmwzdN8xY7O3jsrdGYdTQ1a1HK+xow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNuoA9JBtXP6Ofapsk3IHsbdAaIPrrlBgrn/LFWmPrM=;
 b=gm74hV4amCuV4RrBaor8S4/+b+O3JtUe9oeDn18Px90PZsfhZbvl3bgcjfqaMxJ+ZXNxhLn92NEyBHxR1RDP2iLk2xz3tTG05/E4OTjG0RDwqOQhYnfXLvlKmcxNFLvKwtTNDlIi+axB9Od3U1WmE4dq/g4Pz7aVF2/+kW+l/XbBNWTVZoJN+soRbknd1ZqYebNTqjAmN1P5vVJeincLed4AGNoXLthT6x01WzfPKb+D7MuqCag4RJ90QT8SKwUKR4dWo1FPzxF+DoQtuhMOhpeE9l7dB4bNURjieY6TXeY7LV1HCW72Y0FAM+oolYVdXyy9O/cZlOT/nsIZtOFisA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10782.eurprd04.prod.outlook.com (2603:10a6:800:25d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 15:56:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:56:51 +0000
Date: Thu, 25 Jun 2026 11:56:43 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <aj1PuyaxAHOILiwg@lizhi-Precision-Tower-5810>
References: <20260623112647.3379581-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623112647.3379581-1-devendra.verma@amd.com>
X-ClientProxiedBy: PH8P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10782:EE_
X-MS-Office365-Filtering-Correlation-Id: 01591956-2b1f-4d7b-cd18-08ded2d25f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YOZMaFFLCRYZc971sU+A25TZ3ALbFGlwczmWvBocXrgcaVQZg1RZLHDZYdPpJ6Bmy277W15tykQ84T57R53uTcg83Lr1zHxPqxXVMt8hzzdOHJo0s4ynvhbtjKXGT2TiLVdtJ1wcDBdE+nQSdtgFii2Vhh3fm+I4rMFmCbC7M1OAHR/bXDyEX+nwWFSCsrb6q9hdlbn9R860KpFbd/2rcJfBlAGCBrJ1b/83eO1XMh3xiQjXnH6d19cdfgeO8iwZP2W0UJOptXJkSVby399wkwqdaTypz43nk+OUxmI8bBMcEfVp7PHMrAgl6pr3fA2v66IE0c5m+hzwvNrWwXIubu3tGxdka49T//WLISmLNQaAEbwHxZtdhMlkwMGSdHT9nSWHkWZJb/0OZ2YgkzR/cDllgPoSE5g/nH+cw7Z+QZ6zUL92dMMszzGw0gxNa2O6SXbIRa6HIG8o37shc9u+Ld2QdhYvSrzvOegq6iOlTRMx/D1COQzaDqx1Ij1UMufjAQR7y6nVn1h0PJX442YJcUgTU2pVmRWGlIoW52rfhdrChIbvXKatr3i2wfidklrY6NAdaIiCrrgtcmErP2ISr+xWtH1hq4yBxzT1GUC+dfgD8hFau9xEVzOHDEJdyAeRfIBGLWP9H1aszrgwoSRest0eJMd6pd+lAA6ogv5IYas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W4xyW0Hu0Ca6t3f9mZrh7S/aOSPtRxGOkCAYcqAvTX8+n5nMqGCk17Ls0Iib?=
 =?us-ascii?Q?ehYXCsWG3vvxYOW5gRkP7R42tRc30Wona7bvSbf1Nhr9L9OGk5yzd3bDbDqo?=
 =?us-ascii?Q?orbq+Pq/Ya5IJLFtcB5eCg94zGUYGLrOLuc+l4yaNWwZbkioj1ZycTBJFk46?=
 =?us-ascii?Q?d9Fpsxi/G7Dc3LMH7fnbZk0817pKE19fPtjfgENq5wugZXmfjRLFeB/LPLcs?=
 =?us-ascii?Q?gNQ1KnqKmD/q5lpv0zEAL+wiMESnWSsxn/ExratGjC+P2kqBbKhNyRGZBA2j?=
 =?us-ascii?Q?791kIKwcftds4/z0Ir2Ccqye1Zl8opdV7yYqhusNIhNwhkOBVNU8gcXCXoAN?=
 =?us-ascii?Q?avUTU5rtv+lqAgBa2u8LmKgVBgZkxRSM7aH9oT8X2tcRjbqq1Kka48LdycfT?=
 =?us-ascii?Q?DfV/4vUMqFFLuN90G4e3pZqke4cKXteZWJcnVId7GFVNik3eMW1sui5r3hJN?=
 =?us-ascii?Q?suRFs08WtA3ag1G3PrODgifC8FZUuUYwupl3ofmXKDfm+nrgeTtVPjg4lFKq?=
 =?us-ascii?Q?VVusnkyaAfRsWqamOc8bnF9QkUxR+lE4mZj8wbuiwCxzIKHYO4Ay62hbFkNz?=
 =?us-ascii?Q?49hnBuRGgC+UIVnRkw6SOoQwnav5FRwr/AEmKu8g3N3u4UvXBKWEbNaH03tN?=
 =?us-ascii?Q?WTLtOp6BVRhoCnO2tLrEv1YhbRx5UFES6Xg+G0ONtpXXb7f0EbvU6DYuNGPX?=
 =?us-ascii?Q?FfTfFPVwoUbvaFUWQkBXP2nDD4AN7e650IKuISd8YZmuoqQuZsdl6/emfLtS?=
 =?us-ascii?Q?KXxDReppRBdiT9gXW6aWQsHd7wUK+PMF+D58hk8jtsspBt9JrPKwru4Hc9M/?=
 =?us-ascii?Q?zPdX98sB8YgW7x8efchf7pielIlEIgdSkyhYFCM10aqUVUWEnMyQnj4wC98S?=
 =?us-ascii?Q?AXC0wf3gijXMbI/Uhe0o50fJS2j+FET2zY8FLf+WZKmrQ3BIzXUCtxQkO/Bx?=
 =?us-ascii?Q?+Y97X6zVzUc9B/PuOOhw4Msnj2iWvdwVMbZHh0o9TAX9G1KZQNNTllXO+ssn?=
 =?us-ascii?Q?mhIxmblitRn8iIdC1N7+50kXJUBvTv6L+AXcjMhXB/Rhk7rMVWZW9ay+tv9S?=
 =?us-ascii?Q?8DGqiWj1z8M8qIAunIWCPRVJ6D+30RJ+dL8sIYjuSIWuxNepYvUSb0yXDk4O?=
 =?us-ascii?Q?hcoNgmwnZd81QTZ5v0mfOLZsINSRv8L8EkptfQ4idLYa/cgMlYKXK+6oTFyW?=
 =?us-ascii?Q?X56YG6gQ01jhRoVGYI8t5NxnOEV/0p4Iach8jzlYtEjAk5rqH6lGtE7+CXOX?=
 =?us-ascii?Q?0Bl4KaGBatm9n+6qjdXHL+pzYra2PRiiikKeNfcOb0puRyjtFx3zrVpvviP3?=
 =?us-ascii?Q?rxcQrQMXM0cyjxKR6n7Ak23152NgUHrprAwKi6llSWy1ZJDO8IyX42fVqvX0?=
 =?us-ascii?Q?i8qjIgkPOOhFqWYXjvkNbaV7hfId4xmSb2WZpFK2LC+b51T/Rz/nwKxwDFZ0?=
 =?us-ascii?Q?HytOf5yRhr8heJhnCYOFV/kyru8F9mlPJKLuW1yyFuB4KpMvQS/U7/YOkR6U?=
 =?us-ascii?Q?J3nzBZyTHuR6APbs9n/La5D+tW22skrsVUWb2ZIn2+sL9vm0VZtU74+QGkIh?=
 =?us-ascii?Q?poUwLwK0h2cvGNeAfFQ0JRldSVgviY+YTAd3VkDLny57SUQna9un8u4ZWP9w?=
 =?us-ascii?Q?tjF6k/zGK3atit5f31MTxK8VujhAYuRq4kz+hJOejCdJGSP9Xc4z6qx/xCZH?=
 =?us-ascii?Q?r95V6mSsZvXETWbt1o5apo1G7NaSJRI/+0rbAEOLRR20ewChDyLOQdaj3lCW?=
 =?us-ascii?Q?dx/FYpKWjvir/W9QcJMel2AK8dZIz+BV6FvqT4JQkwjestV+aJwj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01591956-2b1f-4d7b-cd18-08ded2d25f04
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:56:51.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ja6l6pX2RoCFQucRVdW4P6X6E6TSQ4lOCLnw1cc3FUcCOdEHsbKMt5ekBVyOcCqjadpoXOkCZvHKHMNlt6J3R0kfoMZOyM919pDvnLsCzR6N65yL9uv+UGljkNRy3vH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10782
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11791-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFB1B6C73D7

On Tue, Jun 23, 2026 at 04:56:47PM +0530, Devendra K Verma wrote:
> As per 'Designware Cores PCI Express Controller Databook',
> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> channels. Current controller driver supports up to 8 read and
> write channels only. In order to utilize all the channels the
> controller driver need to have the channel related structs
> and variables as per the number of channels supported by IP.
> Following changes are made to enable 64 Read / 64 Write
> channel support:
>
>  o Defined HDMA specific macros to reflect the channel count.
>  o The count of ll_regions and dt_regions in dw_edma_chip and
>    dw_edma_pcie_data shall be in accordance to number of read
>    and write channels.
>  o In dw_edma_probe() configure the channels as per the channels
>    of the IP used.
>  o Changed mask types to u64 for higher channel counts.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
...
>
> @@ -118,7 +129,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	unsigned long total, pos, val;
>  	irqreturn_t ret = IRQ_NONE;
>  	struct dw_edma_chan *chan;
> -	unsigned long off, mask;
> +	unsigned long off;
> +	u64 mask;
>
>  	if (dir == EDMA_DIR_WRITE) {
>  		total = dw->wr_ch_cnt;
> @@ -130,7 +142,11 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  		mask = dw_irq->rd_mask;
>  	}
>
> -	for_each_set_bit(pos, &mask, total) {
> +	while (mask) {

can you use  DECLARE_BITMAP(status_mask, 64); and keep original for_each_set_bit()
ref:

https://lore.kernel.org/dmaengine/aj1JrufD1vIZH06s@lizhi-Precision-Tower-5810/T/#u

Frank


