Return-Path: <dmaengine+bounces-9742-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG6uFQe+ymkb/wUAu9opvQ
	(envelope-from <dmaengine+bounces-9742-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:16:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF335F9F1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AABD03016ED9
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B427A462;
	Mon, 30 Mar 2026 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mrShxHze"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812F40DFAC;
	Mon, 30 Mar 2026 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894559; cv=fail; b=AeZUvJxNZNbp8iM6kZs8EfvYyRECtHWSfzvECF8WaoLcrQnmD3Nr0F2Tx1wXFvKiD214GwNMu2g0kEMgi3AhAzgUOnE6M4ydJsere9UsBTSXyMwHP+FJKETvSjbMOE3swqUwetoamPL/MoZ0lFHo1mPCuGJefZVLeUzXmsHnJNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894559; c=relaxed/simple;
	bh=jaq9kji22owkZVxIX9EuMGFmPsykA3jCvEYVuytOlR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=scu3apGl71xuGSrC1IV4I8TFQSm7uHp9z6YjTSqGpiqA1GJ7wvs8kiSr5P7Eno6Gh7HMH//p/qt8kG6w/EoyWmA9uqP/UqmxeUABu4lfTRf5HfU3tddql5AuXbmJt15rOq9f4FwYx6+/ST7HCENPCm88cvL+Knaa/kU558dt98o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mrShxHze; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIcASkkbNECPakJPKdSTok8r2KL4yTBWrU/KYvqagijceEwoccfmLXMwdd/1XoovMNu6/Gi6eegyshxmlhs1kFfgHLJxMrBhC9IVtoclrbaCWt1j9XhF4Fv+dKJUO5dKOzoIAPwAGGmlSXYHyV3fiwoFDmoHMVBFMJk6Xp8QLH4mpBJx+SQzyaI7mJ+1Q7yHxRpudVvKIg+LkcY1k2dexMM+G1Ad8griDxr/C/v/00EenzYTpMB6kHKhP4CxsZ+q5ef2QNWgPlKakn61u4LLXZCSJRHUwn3cpSnx/ulyZauGD1a4jhxXWcaGtPz0KCnvoinzygcULUYTm+RuIe0Nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk+kUs/cUqRHZgGnSGcG/JOIYkdL728dnCI3/zM1wvY=;
 b=Sd02wFnem8gYANZM/Io56jCZ3hHtCCGLzY8uc16kysvDOi7NwUUPDHbBghWrgt7dkrVKpsD3/rzDmfF13doqaLt383VuEXG3/JNFPMw0dQUhaNpRWJyBO87+oMtXdeLr4fHkKXcXVL5OZtFGf7dY/ibT6BjTE4F9Ze79bc7rZOT66IbMvUBBk9kDlmTMaxZ4bHX/aGdKSoVFaoeHHhsPBMY6cpUXR2gWlsCEp3JlsCDp5EbwkK5lYnP6c3Ey7Zqj4jhSDtKKIH82p8RuwRggVh5Kg3gzkibQ8dinkCxFZqca9F5Vy58LRYkDE8BKYgxgP9NX9W4CSFEOOHKJWdCnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk+kUs/cUqRHZgGnSGcG/JOIYkdL728dnCI3/zM1wvY=;
 b=mrShxHzeNtUFVe2TYjbI0fM6LRba1cAnfKvNy/3v8PXsenBfd6O3jGRRWrXlxG391mJMrpmhmYvhmD2C7ebbFzpfGJVGvjHm882PY2vdMTybLaR5HwQuXOlKc/q29xn8yFsLo5nEhSYnIyRzrOuf/iY7fX3JgQmv8yQDGy9qmxzh6e483kKJq1vEPVmHe2rhjeM4bTzJvRxHusiCiqI4fFlZe1XnoXA3XK5KiulDRdYrcltLJUZsrtLmJLc3NBtDGDUnklMEC0S0U9Rgp0Y2NcEwWV/ElO/huNLTXFHIDHApkIVtKUkxxst1oToUND5IfT2j4OsLHPlmkbCGsy0RGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 18:15:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 18:15:53 +0000
Date: Mon, 30 Mar 2026 14:15:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, jonathanh@nvidia.com, krzk+dt@kernel.org,
	ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
	robh@kernel.org, thierry.reding@gmail.com, vkoul@kernel.org
Subject: Re: [PATCH v5 08/10] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <acq9z3-lqBHY78v3@lizhi-Precision-Tower-5810>
References: <acqpHJM3eilwyMMy@lizhi-Precision-Tower-5810>
 <20260330180240.29906-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330180240.29906-1-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH0PR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:510:f::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd5a049-5d86-4145-7e4b-08de8e8860c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|366016|1800799024|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K703G3Yw3VO3I2Wb+UjBkj1Q/YD5LXz4pPSR3iCz539mYoyNobBL5b/tbx824TlE++cmFlYLTK81GS+Pev4z+yVzhuc7/V7oIVXTI981/VTWN3iJXrAaTK75rpEebF6dy4ElBcNgdLOx0FNWT14yjnuJpSAxEBeubSeveDXXVN9Qu0GmGm3/AvmAUmJO5wS3cXU27M3rL9EL4qD2buBDpAb5qVxaGoSVAVNy7s4xSoIMxD3LYJAZkBN1TX2xHvpRDuo0NeocZTh4pEhbrYoi8QjZpO/a6yD5kLTuSU3cnPPqMCMLgpzoKV+U5nFWa+Zrc5zuyl+uoGWVlCWaAG5mf7bHLshpGnoLwrU4JvqLLpKSRYnjTuIGHaiA8P7RTi7QdsiSf4bheEbbYJS2Qh3N6caO8ox0cmiOKzt40SmdlQXgL1h4KpNZjycOOmD1u8JdMM8Zlu8P4yfIYm3zuBnq2aw/22yO1dTcgOw60c5qEYURxYDjmvM3JquKefGhO4LIDH/eohZMzh/JcLhVq93YjhyHIjf4OS2KKNGI/rUNEBOXC0lFBkH1QtcKybee3iEY3BsC4SF7OOkw29oDX70+xesTx3apBlTAVwai8bQlHo/8oz7DHOym1Dp3dIFeTqkVgdFlS0rZk1LWN+dQkQdA+vzmKh6nMeMz8snd6Gbxl15S7uZy3veKizB/tiw3r/8oejOr9cUltRfxYu/jatYByfmW+4/Hw2hzHFYXxuFqf1NmvUCQ1X48WdsctIftE6XrAlfYrO54/LvaSA9NQm96nIUugSOZOavnuk0e7fYwosg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OypbsaTHOpfKzQj16Ix+8Jr9TnC/LM5FgXMScuOJyqQXz7wikwe1aqO2MGqN?=
 =?us-ascii?Q?wlm0pZosC/xhZUjHbOamDAuMspIN1RXzsMwkBpPG+oWLM3uadrgR4JRwRLka?=
 =?us-ascii?Q?MJdi7yDfU9ZWNvEWFCUwPSOTzOJKa3IWVbHOat6JJtFwErvIINYsQdV2kdQX?=
 =?us-ascii?Q?k66cWFYp9LOcAYf0mYVZmRbg+ZMHcTrFQMTp5kKiQ2JkBUOcFsQUZdjiJfFf?=
 =?us-ascii?Q?izIglHYdzsqDseoV2Ok/9JcE3dyjnQAYY2hgqWbNmWwJII6iKpLdDEsBA+QK?=
 =?us-ascii?Q?juVUgu+Fda5hC8+3FnXa7cFncM7xTEDRCLqkl8LO8D8WwsKeCHxIl6r+80OI?=
 =?us-ascii?Q?2m4cRQgCmU/rf3Oh4Qb27mfMai4GoCCYNTX01Omrq6LNsVCsqKiAMqlRD+BR?=
 =?us-ascii?Q?24ujmQ0NyQZ7zMWXwa7gfRMbRdxbE+PhCIqwEL9n/JII0tis603pum4T5tpm?=
 =?us-ascii?Q?ke6U98SRlxzQaHZxJjkSLPKrGM80CKPjqeORG4+JlBby/Mdvm3KvVn8tgAXZ?=
 =?us-ascii?Q?p08m0++ueH3ySq18o5rEPJ8s7PG1ArJoVCr6Or7TnqLwGKThfs4jmWR7Kgn5?=
 =?us-ascii?Q?W/i7utmYZzVwQes1/igyN4wOVRULgfB8jK6xLld1iS21al3LwNBlIyc4e8ex?=
 =?us-ascii?Q?eUDxnnIGTLOBURoJmuU53UYnqtMpPXfcfVs6r6oYFEaDTVJBjSydK7tMZQ3+?=
 =?us-ascii?Q?N6CVzxitH2Lx0/E2B9+RADCadgEFxFmzjqIx9SVWZG6Sspgce1qJYRE10l4U?=
 =?us-ascii?Q?BLJSbcArCTnUvFo8gV4zgP0zKLdIgokK6kimkPRya0jrGpMrv91H8OZqTqrK?=
 =?us-ascii?Q?VE6J9OV6XZroZTTLYRSiP9GvfyRhH/7EHWkUhOLP9OEMLLoMjU/edOIqm9sV?=
 =?us-ascii?Q?Hr4Cc+zhvEzLOsbUzSC7qclgmaE7BwUY8fp/ace7Z3svSjVi760/Qgt3bQP4?=
 =?us-ascii?Q?Oq+mO2Sy0Tz4vq/98oJf8Emmq+CqtW8AwyFWyKQxQ/Nl7Rjy/0gBQEvlCJ2t?=
 =?us-ascii?Q?3MBE6KczondpX7s8xhgBIFTBg0T9jgXcnMCpxz1XfWrpVgxmWYWQvQTADoxL?=
 =?us-ascii?Q?ABaHX+nMnfkencG/4FewqlCith7Ny3AyIpOxLgTMbjOa//icyF5l99exTihH?=
 =?us-ascii?Q?3H90M3hIxTgPjy/y6jgcRuEyHQrhTngZQY3ZjeGA+Y5VUKD32fBcE35yWyea?=
 =?us-ascii?Q?T+3/g+ZS84hfz+f3xhGHwxnIl8sdajYTgX0QdHFP4k1BdWsYESdMz1DfHG/z?=
 =?us-ascii?Q?xdGP54Ke0olaBdSwVFj/9WRmW0K70VPsogxaxlbIOxUz4C3phEDSwrKv2VkS?=
 =?us-ascii?Q?hD4vetib5DVS9sNxLKOTgkOJAmSVpyozCBKY1KQw8wPH+QyX79s07JVB13Z5?=
 =?us-ascii?Q?zCwoPoSXTDgXLDpqmxR74+b/NwRg5POKChHJonZRNdtNEibQ+3HXKNJDhYJN?=
 =?us-ascii?Q?vt+e7prJ+JNqzODghvY88YpeC9S1t3TeS+dxQzA4/TRreK5cBx5n7CLmQ2sf?=
 =?us-ascii?Q?nJA/TPaEBwrsxUmApl6kqutHg1AVmPNkeTKe2xh/qkKpMmfIfOBJXPNAMwGz?=
 =?us-ascii?Q?vYAx/Yi/BpIS5znah4nrQAfrk3SqQhoUMIgLUpKLq8Xp7ccb8jbTloUUnN4A?=
 =?us-ascii?Q?WoWY+8ahf6zqagx+uxjDpiHuWP6Ulx2CE15mJBS/Bc6gOMEMNVBswong6wst?=
 =?us-ascii?Q?DXpuRsRDonru5z10+EogJRitg31bSqjZeb4bLs0yRzgcR0CZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd5a049-5d86-4145-7e4b-08de8e8860c0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:15:52.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApCkqUGB1/+wYc7FpAWAVZD124MGroxX2+8KmupGsRSUcAhsbOWbtAXtigaRlMs6QsA5GxPSqluioWgfn0hUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9742-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEBF335F9F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:32:40PM +0530, Akhil R wrote:
> On Mon, 30 Mar 2026 12:47:24 -0400, Frank Li wrote:
> > On Mon, Mar 30, 2026 at 08:14:54PM +0530, Akhil R wrote:
> >> Use 'iommu-map', when provided, to get the stream ID to be programmed
> >> for each channel. Iterate over the channels registered and configure
> >> each channel device separately using of_dma_configure_id() to allow
> >> it to use a separate IOMMU domain for the transfer. However, do this
> >> in a second loop since the first loop populates the DMA device channels
> >> list and async_device_register() registers the channels. Both are
> >> prerequisites for using the channel device in the next loop.
> >>
> >> Channels will continue to use the same global stream ID if the
> >> 'iommu-map' property is not present in the device tree.
> >>
> >> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> >> ---
> > ...
> >>
> >> +	/*
> >> +	 * Configure stream ID for each channel from the channels registered
> >> +	 * above. This is done in a separate iteration to ensure that only
> >> +	 * the channels available and registered for the DMA device are used.
> >> +	 */
> >> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> >> +		chdev = &chan->dev->device;
> >> +		tdc = to_tegra_dma_chan(chan);
> >> +
> >> +		if (use_iommu_map) {
> >> +			chdev->bus = pdev->dev.bus;
> >> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
> >> +
> >> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
> >> +						  true, &tdc->id);
> >> +			if (ret)
> >> +				return dev_err_probe(chdev, ret,
> >> +					   "Failed to configure IOMMU for channel %d", tdc->id);
> >> +
> >> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
> >> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
> >> +					tdc->id);
> >> +				return -EINVAL;
> >
> > Can you check similar problem before post patch, here also can use
> > 	return dev_err_probe()
>
> I did notice that, but I thought dev_err_probe is to handle -EPROBE_DEFER
> and we do not use it when we return a fixed value. It returns -EINVAL here
> directly.

even that, still can use return dev_err_probe(chddev, -EINVAL, ...) to
short your code.

Frank

>
> Best Regards,
> Akhil

