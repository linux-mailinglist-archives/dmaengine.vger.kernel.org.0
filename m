Return-Path: <dmaengine+bounces-9681-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFNsCHaWxWmq/gQAu9opvQ
	(envelope-from <dmaengine+bounces-9681-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 21:26:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B766033B69A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF94D303EEAF
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 20:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98B39E17D;
	Thu, 26 Mar 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DI5/d31d"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F430E82E;
	Thu, 26 Mar 2026 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556778; cv=fail; b=o5egCA89dEMlXUkfFl60R6Xc5p98jsSyNO1puyi+SK1Is7PU0u/I/E0d8d0q1oSp3XlfIvKcSDX8WTrwFN9hQS3ajpXIp9/mb5cSxXAl5CeMmC3FeZ+TL/+gCBC71YlZ/p/wdcdz9xNFEFC8/feqqNll9rKXNZUF63yJSlCfctY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556778; c=relaxed/simple;
	bh=jXREtua2jwzZvuoz6v/rB0PvZye2t3jyW9005/+pe0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1qNOFanxpKPLldUmhezallkayrVuL/F/CXIVOVQ8mA4KLVzDodHiaIWGHFfsCFkN9IwE2CGtIJHa0fFw9YRpOzLeeVFC8fiyODTFCIGfqOV2d0w1u4oqgiSdsUdLZ9zXIPwv4FbXlak1SySwtEvWKkzZ8sXqZOqhUMOz3lSsAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DI5/d31d; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwy5jJklUThz4W4+pFNsoskCE7rKp5HtUQqQ92g0KnL5X2DHtv32WWqEfjuTVfcaYl7vNMn8Alpd7NwTMH7KUFcKgWK9PVBXbt99VhFrwxQYBaktIhMGoH5CBFjYg4pebzbAchP2HQTfKNswkDhGNoU7NOoXw1oL1WlqcPf8gsg+qFrezE2IzsqSLTKm4Vr1Ele8aq/yGJGAMJk51zOoowC3r1ndq6fsUjl2dM+zL3/4HABV7yGkuUE5nd8F8L8I6omcPg0t0HQRhsUNbCITg/2/D5FAgS9p9TTOTrq3v340Tdit50zsAELjihQ+SoM8qmKE9xHg4BlikHg4xM+qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfPwqhqYegYcF5pREENsWhUKovVmegV0mHDomNGhRvM=;
 b=UsyrX5qvTSiv2ebxZAiW2n2BbXab5Not+YJhJPrNyniZvzZd1qOg/4ZFRit4lFeau67Hcq8PRqXUiSLnVBdvHekNIPf3bATeEpuReBtXY4ROGeGlgGIiksLHUXLiCGyk5A5tiimZIlAImTjPf3Lz1vp+fn0cLpcMVBJBQCLgMSN++wAuH7UPHLsg7+poHfH/kWXuXoADx+enYuvRNWzJ4SY/ucVsfv/yAenycUlNmFZAS+U90R2FeIvcbSdRsaMH5VfuqaMP9Pi2+XctUEImS5prccV1YAKYhrlAq3smeItUY8lFktbpjb631vuVndOi423RKZKpWj11DfF3Uqv18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfPwqhqYegYcF5pREENsWhUKovVmegV0mHDomNGhRvM=;
 b=DI5/d31dKa/LO/vm3LF2r0dQrRxZKbW+ZH3luoSBVvs+cAyaJhwYvkLpW9DO7Kp7GXiMymS6EKtQAPsF4FJ2o0EAfilRmyA9JDflslp9nPpGF3bBrW8xF/mxISAdF2PcGuRkd3VxAVYPUiTV2m6zKeqfHlg3eVcg8G2yQoVOnhzNuNearaLa+KHQmYRK9ljXFubrjgn8eQuO72n8g46lMko2R9dq542gIyv9VD11mYUsyAafZsFgtMmw+B4VLc1o4WLQXBV8IK1y3hPWQ8/mVlsKBknEbxADjwmYuqAvJnfUDi7FZeaSMWowCBhLtAoV3+afd64uEpFQobJc6IbMVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 20:26:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 20:26:12 +0000
Date: Thu, 26 Mar 2026 16:26:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/10] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <acWWW6r5gZ2nGerQ@lizhi-Precision-Tower-5810>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
 <20260326110948.68908-9-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326110948.68908-9-akhilrajeev@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf4444a-1fd6-4874-c8a0-08de8b75ebf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|1800799024|376014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bJ7dVFgjyygYRe2dGavpbKaV82TUYcNTytYQsVrfOKtGoYa7LAtFupqWu03T+mPuxB0T8BM1XJLdt8SeNoXsEYFIYhknimkEJVWBf5YwDEmfwRQYyuScHUby+LxdzUiXDj8Fjmb9aiG2Tet7BOTUu4o38MV0F/qJHRc6j6vgqSPfwsxcBO+Xgx+yeTqu70WwVp8RqKyDgicNB2n0ws6bfF5fM9Q5O+5FhiTN6z0DiGktqqZwtlWzIKeMG548XhKcEzC/w+SmCmgxcW4ujvUPJzsnzWOUnH+VfMYufbGGqHcCTB1W69a6rMJoyiwdvwlVkrFN/H133anbzDZF++P8mm7ZIcw5c7WIVwf4HYcgl2gzMFkJWfSEADSx58XBFt4FvdmMWz7pxyLB9Cfi4MnFWqGAMl3FrO0J+dRHNAnqb+/ny+x08LnVNJFrs5+wcVMzWgSTjxhKZrWNx9D19XNvOgKxDzh2mcSKB1CErYRQaY9LusW9rrNb6dxo8hYbUnTOwzrgCT/79EggecNhbpDOKWgQk95WSQxKp6myzsGck4NgDVSB/bTekX5Sp1qWxGX9HgzPbCgOJBdcjSRayYhQgQg73qtrb3+CUwYYJSrbleS9KBG6PHLBcKpcAM37aDhBbAPCn7JeY8oU0kdFrtiDkVJ4tCulmy0UvjG4SeeMbA8Fb1plFsZm1kwEzt3Xg3jx4oygXEP3UtjzKnKqcBIDD1w23YmKp1ZroBWAZyQbABBsfFa1Y/3xXR2IXtRcghYbKASn45zlIKb+ahK8+s+7qxNWdxGi+m0XmeqXbe3GUsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Avf+hQGD7ALxVBgC8kkzruLRXAQboslaVFgni9WJbD+m7UZ6gCyZlreUEZDV?=
 =?us-ascii?Q?A11xmf3NMUa7UwXgaILPmRgbapAHWL/Xel1rypFPOpcV5rM2C1eL9Qsu3ShX?=
 =?us-ascii?Q?AAlTF6ekyY7xUeGdgGreuvWBp1Ih+NmdP/rwqjRSASCrYUdOBYO34ucK/0lh?=
 =?us-ascii?Q?sKLxmYesRwDv9r55jdHWTQN7K0u6j0B/L//w2jqINiO++W2hdKqilwfyX68T?=
 =?us-ascii?Q?UQOrpXt4wnLjhDcLVbHEwDZD6+BRWddRslcG3W055rkSGZQqa3H4X04VDhqM?=
 =?us-ascii?Q?+4ddJEoruD5IfznBfuywQKXa/j3+vteTnUEEQqYh6OTI60rJBq5Qj+B3eOKF?=
 =?us-ascii?Q?fi77z2+ai10vC76UsNFysXLApN1KB/63MCfapSYDMC9LktjbxgoqVqCk6dpn?=
 =?us-ascii?Q?Pq9FW5c8Ibbd23rYApbbB72ModrqURx6BLzUCyPlhFSAjJIYtNb3tFXcufKD?=
 =?us-ascii?Q?EWIFw8Qux61qt16T/7TSWXQSWkbGgtgCLOQI7jslnEfBTdWropJMIy++P24z?=
 =?us-ascii?Q?YmehcrILPd2eIIJjQuEOzD3Sl4N9PxcY5gDXiYwKe3MIjY3vvgmnh0iaVTGp?=
 =?us-ascii?Q?dRP5z+OK+1wwBUOf7H3KamJgBo06BEwN2ki6W5L6b0m1Ig/KUMWM1/6rQ/j9?=
 =?us-ascii?Q?J/rtfEO9TLO5nqFvV4+E4RO7JvEz2zu/MQt/yex8cjkcHqqcq7n7r13HcXFZ?=
 =?us-ascii?Q?+TGd4RhR/AWJ65+gYvpYZahLHJUq3oi8ibTBmLkFMfRPpscXcQF7QSTGAP+t?=
 =?us-ascii?Q?OEuWPaPxdPl1qDTU95mq2Lf1Wd6a81H9pJO1SUIzcAT55KhFLhjLVfuJyWrr?=
 =?us-ascii?Q?TMQbflxn83nLzXHawe0w4+0kasMNc/AuUxhVzDllC3IzAzXHwQhSuRfldZ4p?=
 =?us-ascii?Q?bTaj90fIUTXfN+PKD5B3zxrjpXCViNqQ/MWuLwuLLPIrYLRTKRsZNzovkt3Z?=
 =?us-ascii?Q?mjUowYlMyIubQN1Qs6cLfF+pvgnJ+nK2tPWYi/gW070P0YZTPZS/enQh9Gj/?=
 =?us-ascii?Q?yNUhGabNMyUe+HXGg0mObSdI0sf94+JQFb8drGmPhBldZBtxK/1DYKDvXozd?=
 =?us-ascii?Q?O2SwjlLgAH9DKlcv8AJvmPSeANAQOrq0EqJPRAzk0CHYMj9j2wRu+1M4Kb8X?=
 =?us-ascii?Q?44JtHuM3hsghUmADM11HawKrP3ZM7fbMTjzPT3fj/J4YtTMWjs0IpYxpxG8M?=
 =?us-ascii?Q?XOJK88mEl67easrq8BtrNBbk+45KBvTWjIzYxUADc+v1bm84C8GTtuIDuYFU?=
 =?us-ascii?Q?Zcd/JsTiXT7bm/lUntUZpk9NKRhTqDoAj2vhYPwfaUao9sj3erWJ2jk4ajsy?=
 =?us-ascii?Q?bi3eFFRgvoJqxR8oER3b0zKNY3Eo1VKsNqK3OHJRSs6xRusza9xcgSRf8GsR?=
 =?us-ascii?Q?Jv6WmUaEYswvu4rjm7TXfUALuUswDV+iEXNdwS52tQiXDH0cgaP7lO3UTdHs?=
 =?us-ascii?Q?NweY5QZDGrgXZRAAwcnXGOq2ITA3+A21NLrFO4najGzKSsur4WcR/mPW/Vc8?=
 =?us-ascii?Q?MHuOWHq0tf51hInvpDYnTd/tINKslRjz7VizkdkZ0I7H46FE9srBw7qOrGjz?=
 =?us-ascii?Q?IgCqGAPKjQjo2vMjb6RwW8W6s7gLjt66T2AqIInUdELe6CajjNmhg9TVXPIa?=
 =?us-ascii?Q?3Re3bhwcipP/CjIFR6/tbioEeQYI+95rw/m+oZDMsOS0xcX46d7aXLT+0Hwq?=
 =?us-ascii?Q?UpC8KiAYsj6MDUHordd6Vn08BSX7Jk1Q44IjWgwgPulgvYLtV0xIiBd4E8/s?=
 =?us-ascii?Q?FWBX2IiQNg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf4444a-1fd6-4874-c8a0-08de8b75ebf6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:26:12.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eBve5plZ3UruErZavVsHFU9Q47fBrkssoF8ogoGmLWCZnm0uLmPP4kn4O31CeRvJnpzRnK+CKM/bTr9j7M9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9681-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: B766033B69A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 04:39:45PM +0530, Akhil R wrote:
> Use 'iommu-map', when provided, to get the stream ID to be programmed
> for each channel. Iterate over the channels registered and configure
> each channel device separately using of_dma_configure_id() to allow
> it to use a separate IOMMU domain for the transfer. But do this
> in a second loop since the first loop populates the DMA device channels
> list and async_device_register() registers the channels. Both are
> prerequisites for using the channel device in the next loop.
>
> Channels will continue to use the same global stream ID if the
> 'iommu-map' property is not present in the device tree.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
...
> @@ -1490,6 +1496,41 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	/*
> +	 * Configure stream ID for each channel from the channels registered
> +	 * above. This is done in a separate iteration to ensure that only
> +	 * the channels available and registered for the DMA device are used.
> +	 */
> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> +		chdev = &chan->dev->device;
> +		tdc = to_tegra_dma_chan(chan);
> +
> +		if (use_iommu_map) {
> +			chdev->bus = pdev->dev.bus;
> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
> +
> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
> +						  true, &tdc->id);
> +			if (ret) {
> +				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
> +					tdc->id, ret);
> +				return ret;

This is in probe funciton

	return dev_err_probe();

Frank

