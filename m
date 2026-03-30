Return-Path: <dmaengine+bounces-9739-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iORXBNOpymmx+gUAu9opvQ
	(envelope-from <dmaengine+bounces-9739-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:50:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8035F0EA
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32C053010485
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954C3DB630;
	Mon, 30 Mar 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FUPBEdkO"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D237647F;
	Mon, 30 Mar 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889256; cv=fail; b=Rcq/pz1666exBJKncAnt5hDrFQMWYl+gYxAWU+mNgM4b4/AxIKjS4e+1a6CttJYMtlBY1/AfywgYM95cOXER8trWKennwJA4vgMtsIFEkSkDSmrXpK8OkDOQdcNEykmSI9sgK6a5CTaG7O13aJza0eSuuWxoeYoUTtpSXZsMP4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889256; c=relaxed/simple;
	bh=77vqseVpA1OAIpS5Elk6D55MmIH/8/gfoyJNQgO+fp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TaQS00TVVy68gDOytS8cibBvX6RXAm0s9dW04dGyujn3NSJ8BsQw0fIeeX4JL09MvrwN9u7tfHZhH/6cO3lzX4VTo0aqatwdhEDJij/fulFisx3rqnLvngXncsAVUFUuGoM7Xl4TPLXPsC/KAbxFQKvri+DyLlz2ZwbtsGoaT98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FUPBEdkO; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFHikb7SjeQG8Op4NPL8N4WV5f3MAnQGWLBlLDYqNxmkS0G/FbHT1uVEUTYcvYHIIJwNhUr50/AwdJpmgQaQh1UoBdhK5tr1bAvrHVSAXM/DibiZBX1nC2uokXd4SYbTMPLz3IAkz3JOdZTyxB3OqenOwnHWnnYlrE6BH1gfAZXkiVvAgcc91oey7nXvN9AgLfQAFPjnJ44qUHSNQB3h0QTMhrf5S27pq5lEYpIFiwunEVgwI+1k344OJx2NL6/K3N+6ZyNcj99qWgxg/IE8f44o2VOBH7ilVH8m8yWupfp34VlXoOb/pofiUarz8PamP5vKGbL8hzIX4kW2QGPSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Sre1gEFavN0Npq7X5ehowCZQf/5Du75p03kx1hQ9Co=;
 b=uRb4eWN9jx8mulv2+0L1A6XNpM3mU3ynAAVodFg4Y2HL2VQnCoDkNL7zzb17DrnvLE2kkL4Ta6rj+qNs0P301R4G0cuqYQrVOSRzscYKmg/Zj0EOcUbcEcCezMAR9G73sPM10vADY0H7IEF7RETjRnzJvGrB6myRMll1Ve1C4Sele/dUDajiJx8B06bD/5oC7RWKA10lcG59acEKyGhd73hrbXMKUqKEtZidFlUSRqdA4gziDRDDjPMQYoODuT89VH2LFz6aR4+kY5fdvZtqqkMBvxWDLxLWqnLVDwSwti7vEcNy8K++ElNB7snKZEiL2Fj7Ob8kWSCTH/0eksMdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Sre1gEFavN0Npq7X5ehowCZQf/5Du75p03kx1hQ9Co=;
 b=FUPBEdkOZkh3kEVuwoh3GrozPerhAm1T6T/kS8ZaiPMj+2wC4Uto9L9AbzUlqAJcPn1hTi44YAoiSH7aObHGd5oAi8Ilz6LwkvVFHBfU4lGuWN3GPzZXV8ap6t9TrErF70GZ7KPoKR7FEZ684aL96/xdJGa3X7tO6FbvPs54SULTq6hIfmqBdxPQknUlHnr37+b5de3aIJe0mHxpyD41Svj17T6xGsQgdPFZAaSnAFrPQMupM6DoVU6xPt20PcfF92F6AWMIYlqT8+maLiSXx4JAcRjeYNe8wQKiBGsyv9KsVBk3AhrAGcPqv23K0FzFb7z6tm0lJSrz7RA82LwaUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 16:47:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 16:47:32 +0000
Date: Mon, 30 Mar 2026 12:47:24 -0400
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
Subject: Re: [PATCH v5 08/10] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <acqpHJM3eilwyMMy@lizhi-Precision-Tower-5810>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
 <20260330144456.13551-9-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330144456.13551-9-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH7P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: d917f5d6-bb45-4daa-90bb-08de8e7c095a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	0Kf+e/2O11YTFEgmNkFPb9YfQeeQt5QM6ik10Jl+h8oVTCId6Oq3JELs5mBh2rYGPdUfxKauJekmxVuct+oFnaF8ivEcCraPnEKCtH4w+XO35ggT1GHdVAxzyFM99NBMZKC97UQerQ3729a6k42G+IhPpNkogwCqcTmMcav9CS7J1tD7CygH4XM39l2holzIRWh7/jvFWK828mgCyW7gnK3ji0fdU+Pb8pPk6VKAwWOFDv1QDXjYLjBKHljRS62owEErlBPPeb7FRNqOKhENOTIznCFDyUfPQE1JrlSRq2N3wfMniNpzcYmCqmqh3cq/LbYl2cQ4YTTZCd/GVINXZw2obrH8NKUyxKURVg56+algwoSJbKHKEjHkPvfaCGVW6Nay+htxfOgm/41AuUomrdhXEpC6fUsWx4A2P2KKAb8I7vNufQ5QrUhWQMcfG8HISfdFWrjNMvfbbvUQhkP9cSSoWnaKgPBlxw7QHmHKhHxCxgYw5QYRWh8iwcaDnVTvUnOlW57jAStKzF4RaOGCrLep6EvEz8Wn2FSMV1C5UcIZ7VQf5BeNtXTLGgSSTQlwy1c/Ab4HG4anulGIY2LW63/v76Odcblo+D0sE2bBwvaTRZ5D6mjvYGBCxwvNuRgHIpJes6X5qU5KjBC5rsGrz2qyFqH5IK1zzMnRyqsqVDQLv5pfV3LtZSymb4ndHhnMVGTvwbZCrsqZV3GzoM9zBaFofxpmExZhLMMJI37B9fORJmpWxLSUIqOjDYTT/h77YZL2JDBCuTF02f7PChBObs4btcGVIkXV+Z+RsI4T+Rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8k/XRs0ZStqJB5A9PbnCpI0ProAlcNw0VrEpQmEaSnZEuiRfznGwGaew2gx?=
 =?us-ascii?Q?Kt2Pue6Q4W8slf4DRa24sOEX/N22/68n1/PUQ/nPTR18gpW6+M1DLwmlwwZM?=
 =?us-ascii?Q?0e4deUkPJfhllFfWW5Vs3v5iIGIA2a237N1xFVqoPtyaQzsRBspLBL6AnHn8?=
 =?us-ascii?Q?twq1b2D8Vez7ZpFWVg/sZOWWX1MMBMOMCiA0a3AcyLn0hQ2tDc5A4zpVgozd?=
 =?us-ascii?Q?Pns+Ov8WyFAOid+/8JiT7UZimxL7sAkazP8xQL3pMuQh4TPaNgnCwFE5URli?=
 =?us-ascii?Q?7JrgaLkUXZtLIZyhTyc3OrJqCtlhSRpfC3hWDjM1JvjBXlx4SinK5qOAPQLf?=
 =?us-ascii?Q?pN/lbnHsHrt6gIohA4EGZbnCYScekLDwoEwFblfIMkFJPURruNwDUpe0ckbD?=
 =?us-ascii?Q?aW6mo7ruCNcf2KkFg6Ub4EMEM16HofChZ4vRPASvN9ESEL5xIHAnxngyrHxw?=
 =?us-ascii?Q?2WJo8SM6MRws+arfkKkr/U5R0vgrdR0EdniE8a3kyDKDmfmuP7uyHB7lgLkJ?=
 =?us-ascii?Q?UYwzQ1sze6ilvo17cG/PP6VQB7mKVruB4wpbqQ1DrQqAo6+PgWLThFzN397Z?=
 =?us-ascii?Q?oHaew+yBHCvyFC0oVgBa3c58DvflhmFcLicjx6nq5Qlaj41mUHqcrC+YLMFX?=
 =?us-ascii?Q?LMx5NbzlAoS7J1lbm1teKAMP/A9MAoMsrZHxuRiXS9owsZd7Q4WfuIcVhXWn?=
 =?us-ascii?Q?NgDbhpdxrn+FFbXvFF4hi1LzZIAeI/77dOsexkQWeTlKds+03DpVWhleeQLi?=
 =?us-ascii?Q?RodWqeykaNANBbqmMJlwgyWYCkDZcN7CMgyO+9UiV1SPSEW3TCQLyp/tUyQO?=
 =?us-ascii?Q?1lUwdrMUaYT8xQPDxnxxe3KeMaSO3D7tbS3qrzTjRN6qqUMCUDEvAzZ7db/5?=
 =?us-ascii?Q?G/DnlBmk93X9SuDJO+Rym9zf2cJkKN5Ab/HKo0iDYpuY3oXrnoC6H8iBhSp6?=
 =?us-ascii?Q?aljH7V+OUyVOGUnMjwxE/fEjrQ7356u31io3SAdl1x1/Ffp/NKlFew6U9tQg?=
 =?us-ascii?Q?+BQbtkMLQ3uf5q7TxO8UwXyeUkdKWgjfqa8MEPFRPOLs+Gu3I6VMcRm/olg0?=
 =?us-ascii?Q?cDuPuthxDTzyeIwb7gJNZDfrr04gDXY3/a5LETyZnACTbYSS9/B6iGt3atVu?=
 =?us-ascii?Q?i998recuRQ3LxKZvxIhLheAV3ENFp2LfnmtGWmPbFkBkwug2b/uBuEVY1Gpi?=
 =?us-ascii?Q?aOhdTWckTBjaao9wCTODnJazaNx0KViXz8mmoPnPNbXrg1/IPvUVL6oL7JIT?=
 =?us-ascii?Q?jllxXVuQAK/CFdyy3j/HW+A0Da6oBdQx0s9T8EpdtGLxFAYScd5nb2oJxqU1?=
 =?us-ascii?Q?XXn/ED4OAKvJqlpHZZnVCHMxT4cXuKl63GGhYViHkf5iEns1nf0GRa2PiuLO?=
 =?us-ascii?Q?n+pnwSxOaseMkkFt9VRM+2XRaT6yqxvzXLCaT5sZ7CqZuCHil7JjnruxOc63?=
 =?us-ascii?Q?JSoDW9f1J4v3cQSMUpnPIIi6tGX7/7VTMZ+q8K+xpFbsxKiGirYpU1K5VbwC?=
 =?us-ascii?Q?BLOva+JNarZys5/GFh8KmuhgBBYBdK+yJgqwXWg/XYSGHmb9U/8GOjKnldib?=
 =?us-ascii?Q?uJtTFLVUpt4oaoVFmxAkNpQo82fg+ONmJpBxoQqC57k84WyjmZitAaizv2ku?=
 =?us-ascii?Q?hwQ7m+q/91/ZlCYuIyvcaYDLaV/0PYkH4nzw0VG9MdPeS8+7toUKnFaEnQmT?=
 =?us-ascii?Q?ECPgZkBXtGzjIPHkvjQ+00Ci7LjixMgOJmCjLLj+E72KsM9XAAcP8Mm6jA0P?=
 =?us-ascii?Q?/nYMzl5DEw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d917f5d6-bb45-4daa-90bb-08de8e7c095a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:47:31.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyCH92/G3PwX3nbiRHqD8DVERmkgk/J6+gEvYOUtor+QzgJOcOLeC21SixcYQKZa5PwgOgOH+HLkZOcXFZeXow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9739-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A3F8035F0EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 08:14:54PM +0530, Akhil R wrote:
> Use 'iommu-map', when provided, to get the stream ID to be programmed
> for each channel. Iterate over the channels registered and configure
> each channel device separately using of_dma_configure_id() to allow
> it to use a separate IOMMU domain for the transfer. However, do this
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
> +			if (ret)
> +				return dev_err_probe(chdev, ret,
> +					   "Failed to configure IOMMU for channel %d", tdc->id);
> +
> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
> +					tdc->id);
> +				return -EINVAL;

Can you check similar problem before post patch, here also can use
	return dev_err_probe()

Frank
> +			}
> +
> +			chan->dev->chan_dma_dev = true;
> +		}
> +
> +		/* program stream-id for this channel */
> +		tegra_dma_program_sid(tdc, stream_id);
> +		tdc->stream_id = stream_id;
> +	}
> +
>  	ret = devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
>  					      tegra_dma_of_xlate, tdma);
>  	if (ret < 0) {
> --
> 2.50.1
>

