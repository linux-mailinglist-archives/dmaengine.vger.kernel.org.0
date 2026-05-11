Return-Path: <dmaengine+bounces-10325-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFacBswtAmq/ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10325-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:28:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713755151E2
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36FF13080FB7
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05A4C042A;
	Mon, 11 May 2026 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYrjJ8A0"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CE4C9019;
	Mon, 11 May 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527227; cv=fail; b=BWXu8fQAboPQDfA+/iBfPUu4JKTQsE1pTJymQw4yzsc6Yaj7ahOHovwnarwU+MHDfa7Zlgx/IUoxFMPW0CNaQENN5cY+US4nqTYI5/QI+Vfjg1ZD1FEz/D6H6Ek89M2DNXC9CCmA3OH6HuYr9hzIkyPdmSuqsgYcpbzNyRfPYf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527227; c=relaxed/simple;
	bh=ehKebAFLRXgsgbbKlMPfl3p2ztZptwuxJf1t9B+dr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DjmXE5kaXytHkkDYJV9oyIG2VbPnxY0cxIENsl94HegdRrF06+rG6RP7RZyJ7d3ex5D9m27i76M0yrgS3prLnILamGv4wAuyhFVXheVUTF5gVCEC7n0A/8U/aabZUZpMVyQKeJmWAfo0fsYCNXp6klK3v5BhzSkW/l3b2BIS1tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYrjJ8A0 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTVVLJjFu5AEqR0b+PtO+XcxQvBVZFIa/qE4BI7Qhg2bhSzARz5SdOIEMxJUO9B/Jg2dE2XLewnvRoNdlOtcGVe7Rp/DmF3ZVHDne6PnOWYjbpwkWUu7jh6mHjsc/hEhbOBbUeP1bBIxedjdZKH24zJVnOW2wkQBAkQKDgiUselySFg9HCwjmz465m3kHZhC2CMNvwSaKyOYW2oViIXBV3fSdt2ex6gusZWTm8E+/QlpQFP88aDp+ljQkzVroRc/GFJx5JKJps8oIKmNaABQ3borJ6+itsEzsqoaa6HNgeSYRrbpN+eE1id4U+mDvGeh7VUG2ziDGmSnr9q2wAE6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vouzTT7UESXK0+OEVbdHfpEguUJx+QeybXrVWcccPMA=;
 b=tEJxbGYZAEwXNwLypVZxRnclDa56UV8LKOYu9lrqhssOgUz7txTHYAj4IZn39ZYjJIPeTvriOmw8TsLm79i5teUQmoGaoIQv8RKTCUSx+exEg2QuawpITWzVu2fiaYI/jowp6UOIGl6Z5+6wh3T5GCm3rZoF3UxJWNLBsPQVFkbojZeou6c03GeZhiFX2kCPwwKX5xnkvFWpNZZ1y36Ervj41GedAXkh4sJkzvhDulNAK1OxnB+vlRHXevzYmGQyQQfuC780F5Zy38DiYAiFMAXCqg0TFDzIrnsM5SBDOtUeK3OkniL7KL+t1r9Aq6qxFY/1qgwBogX9DPN3ArhqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vouzTT7UESXK0+OEVbdHfpEguUJx+QeybXrVWcccPMA=;
 b=BYrjJ8A07BgMKVKmQ43PCNcC4zL1c2pWq7Z9SE3ETIR8e+MQyWc6Onv7SwSa0Qwuvhpbe4Nv244ckkOrJngFBuRz7uZW6HHMNni7Kyj7oI5FKU2ytBHh0iLs0xUYOENqD6KDi0Rg3p1sQx8IUuAgg6FZ9V5toumUM6MOXErGx7T0SBpP+WtJw6AF64f0t2PjOT4uKHjiOKaNrR4CApusowbHDFQDRSrpXSndTcONBhLwgbeJcJGUdbla/u7B7tUrvR/trjl0VslWksyKz1bNxXqBcF9Jtj5dq2Moj9NY4PFBKfWC01wfmvJrBt+31wtyphRzi1q8Ip3hfC2P5fZdpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9898.eurprd04.prod.outlook.com (2603:10a6:10:4d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 19:20:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:20:22 +0000
Date: Mon, 11 May 2026 15:20:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <agIr7wqV3jIFp-dC@lizhi-Precision-Tower-5810>
References: <20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com>
 <20260511-fsl-edma-dyn-sg-v3-2-98a181775dae@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511-fsl-edma-dyn-sg-v3-2-98a181775dae@bootlin.com>
X-ClientProxiedBy: PH7PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:510:325::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c08b482-7252-416b-01c5-08deaf9258c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2dTYObj1JTyY1zp4R6DzUGcYJ/i/rAS7/WFOUgjOTf8ZwnJ8lSR4Uw1SAoxC1Unv0RwIYBU9O2BSBvrejS7SxF0WseLru2iM+vYK58EQyGKmT5Q+bvfz3P7eaPHE9kJPuIG63dcdUby1swwyxErKfPmWAalvAcpbW3GntmIBb2LeZ9t2geHwFtNm6z9YY5D9ZN6IoZSVkip7A/jAtL3Y86wzPnMRb4DICpJR/pNywMLsrTtLFj0TBzzZsdtY1101Qnpl3FfsBl3m6MkhyLNVUcZERYqXmtPBIX6QgJJ3Oh2HRaibgkGS1N7dOxkk6jkeojXDI/kzW3fWaKM1fZsIoFZ+ePfyomTMYFqxM8xCwgonQc2N4I07bouS9FyOlVmxls6zGPHXeeugjE0O02iV8Ykf2xzNgP+3aDGYlNsuQXD3vOki7KskX7OkuP4Y7X906lltQTwwKPZurYTJfu/D03Zjh7Dm20VcNlOtDgt279fM4bqhTkJDOd6GDHO1WGbLkIGD1XcmC2MpCIJ0PuybR+IsRYTH6zWGBFHvDz8v10c/Hyz2B/J9cCV0K5IunBM175EfUcYMvuLbqzcXpXOcfKb18Fo6esjKGSKN7+DwIV3uPufGMrXqbrA2OgSYb5eoN22yXFrf5KNP5c4eSk2MIz4RnPidl9tgJDqVdT87lVZwGJOtn7hQ8iTIpb4ZzESAfGSjFj8BdwrZI5tH+K6gSN+jpk0oybqPzL2FAQhxexVbYWnTShMwuY71WqGO/urn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?h1oK0m1sUKLcXKjG6oDZCYLI5rtd0aNcraDXiMRNBte+2OPzw760ZU7Avs?=
 =?iso-8859-1?Q?1QqxOL+XHCzX4ECzrSoFjdLFzk3DtVTPvPS1Nlh6+QeUN+nPcLCNrNKdPz?=
 =?iso-8859-1?Q?EYHaKXIQnrIHJm5TEaLK4qTePNgbxAQyseZd67mwBeO95w9Pz3L8V6IJyD?=
 =?iso-8859-1?Q?yK2wO+YM2IqnQOW7bitr/TX/DNFQ7ZnBLg17dCMCG3lm4LS1mn1q/jkjCO?=
 =?iso-8859-1?Q?a3jfdCrQfABuDQv7CjtRBJVMtYNTokhWkXueUVJvJainqA6LLKrcpu1AQ5?=
 =?iso-8859-1?Q?hY+vpE9dfSTasqoRR1nnR42kU8MSSnG8CjwS+EFFdThiqHC/ImFI2kxDiT?=
 =?iso-8859-1?Q?42bie+fB+c2/Dg6leWC+N1RZvltOrY6bjtCPmlyy5c0d3exm+TMKx92Xs8?=
 =?iso-8859-1?Q?MltQxA1dst1eBhmiFs9lG0YoxFiFfsfTbS72gtRptAOoWQI4qUCtRfqnIS?=
 =?iso-8859-1?Q?nFuK1kMwJpuYpm2HZqMI8nJRBcxLXvA95mIcQzGMyF+E4TmXd9T+oZ/Alj?=
 =?iso-8859-1?Q?0/uS6si6K2FsPjvlAHWLJeNftugcQlaGqaRfb8VWH6BwwUTJvlzEGRHv8i?=
 =?iso-8859-1?Q?4y+V3ACqwmJQDTC5n5H2/5Q6SKZw7w5MBUEDAF1+1mFwK74vrZhq2ncJL5?=
 =?iso-8859-1?Q?COjHYrnSv0pANUm+nezygThAPb3Qh8Tq9b3ACDo3pQE0x9EEWZMSNvk6V4?=
 =?iso-8859-1?Q?fDYXwRcm7ObnLV77J6uPM4Af9fLqPDvfKPCuzWABtTZ3BLVoIVjygKr6em?=
 =?iso-8859-1?Q?7WbLtCsYBdkHBJYtZeF31u71YGTV+4Azpez7p2i7tSxYskk+Sauvfr+A8p?=
 =?iso-8859-1?Q?BvUEX0vlVx/GAmFx13/IuqhF+jpD5ZnT3MJXklm+utFzk12Su9fKa2wQ6f?=
 =?iso-8859-1?Q?nOyUia/t54SOVnJ03i6X5F1QxYNzSnwKb7fMHKMJ/qPtvVE725aoYm1cTV?=
 =?iso-8859-1?Q?7sE1boUlUdSmE6alRAfrOaalHA0BM6sS+RygdlpSTmrhon8WClt5P8/Vhc?=
 =?iso-8859-1?Q?UR9LuNEB3N16UOdUPbaevbB1joqzjxsjmGyXh3B3Nd8c36qIx0qeHWPTbY?=
 =?iso-8859-1?Q?jmP2R5Hd3Jp2FGzrXWLzE0e0YUhw9Aj6wV7/baT5W2+ZV2+zOSaAqMVe3y?=
 =?iso-8859-1?Q?w7iYw3Lq2yPx/4zH4K8AqxSu58FfrkaLmllYEdiLXmvQiH10wEefY1W2d7?=
 =?iso-8859-1?Q?Pyy63Q1VxRIDB8YuDdZCI0K8fQHfQ0qg1tL6DfB6uu8MPOiURfX4b2OH2f?=
 =?iso-8859-1?Q?tlyEub9eGoiLr3FQ9W0QovVmxCdf5lnZCLm2Y5WAll3UO/sEm7FHUMvHum?=
 =?iso-8859-1?Q?+kwIZE+bHmNZRy2EzNhzyOP3LkQzrRd7pwAymipfCUAOJuzvlM/AGZkgqD?=
 =?iso-8859-1?Q?wmWzosb26vAC4TOKy65Bg3nWcV1NHyZx5Gf1RosgLX9ix3GriqNGdj5HNU?=
 =?iso-8859-1?Q?JaGJ5rTpinWRe89ODnTHUVCiM2wqDkNHCRNQLP0VUxPrsPr6iPmzJqTqcZ?=
 =?iso-8859-1?Q?x1hRomtO9lB0HWjcKUcWSeRpeiusmQni10BhmzT3QQcPi9IRpINKO2J+d+?=
 =?iso-8859-1?Q?2a2UT1YskkpxtzXFeP37cVcmjnlnUlHnZ3MBTOIyPLn/lnAaPL0k/9YjWl?=
 =?iso-8859-1?Q?Fa5/qq+qkW7IDq13l38xK0UftIsdq3TC+zqtAPJzt2Egg/nSApBUqYRH+3?=
 =?iso-8859-1?Q?PPfqbqHq3ud0KKjtp/XZea0qUzdgvLOCUVou4FfXXBNVOGtY+b3huUkPQd?=
 =?iso-8859-1?Q?2kGiwoDHdByQmhvGAgBoTfxAgrMT5j3MxeZUiy6qoRXV0PN6DDofyuAeP1?=
 =?iso-8859-1?Q?sRa+YzrB7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c08b482-7252-416b-01c5-08deaf9258c4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:20:22.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvWqqo11AySsYipPCnIj3FSDFQSCMaKvi9NEaSiGbg9hGTT01kHv3VbmykJzaEXIMYU2FvyRdpatV7+xJ6mUTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9898
X-Rspamd-Queue-Id: 713755151E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10325-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:57:20PM +0200, Benoît Monin wrote:
> Implement dynamic linking of scatter/gather transfers to enable
> chaining multiple DMA descriptors without stopping the channel.
> This avoids waiting for the channel to go idle if there is another
> transaction already issued.
>
> Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> submitted descriptor to the first TCD of a new descriptor by setting
> the scatter/gather address and the E_SG flag, and keeping the channel
> active by clearing the DREQ bit.
>
> Linking is done when the transaction is submitted by fsl_edma_tx_submit().
> To do so, the .tx_submit() callback is overridden for non-cyclic
> transactions prepared by fsl_edma_prep_peripheral_dma_vec() and
> fsl_edma_prep_slave_sg(). This ensures that transactions are linked
> in the order they are submitted.
>
> Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
> transfer is already in progress, allowing seamless chaining of descriptors.
>
> Modify the transfer completion handler to check the DONE flag in the
> channel CSR before marking the transfer complete. Since this flag is
> only available on SoC with the split registers layout, we only link
> transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.
>
> Add trace event for scatter/gather linking operations.
>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---
>  drivers/dma/fsl-edma-common.c | 90 +++++++++++++++++++++++++++++++++++++++----
>  drivers/dma/fsl-edma-trace.h  |  5 +++
>  2 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index c10190164926..b83d1b91dca2 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  		list_del(&fsl_chan->edesc->vdesc.node);
>  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
>  		fsl_chan->edesc = NULL;
> -		fsl_chan->status = DMA_COMPLETE;
> +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> +			fsl_chan->status = DMA_COMPLETE;

Does fsl_edma_desc_residue() needs to update?

> +		}
>  	} else {
>  		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
>  	}
> @@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
> +{
> +	u32 flags = fsl_edma_drvflags(fsl_chan);
> +	struct fsl_edma_hw_tcd *last_tcd;
> +	struct fsl_edma_desc *prev_desc;
> +	struct virt_dma_desc *vdesc;
> +	u16 csr;
> +
> +	lockdep_assert_held(&fsl_chan->vchan.lock);
> +
> +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> +		return;
> +
> +	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> +					struct virt_dma_desc, node);
> +	if (!vdesc)
> +		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> +						struct virt_dma_desc, node);
> +	if (!vdesc)
> +		return;

Suppose you only check submit queue,

issue transfer will move submit queue to issue queue.

Frank
> --
> 2.54.0
>

