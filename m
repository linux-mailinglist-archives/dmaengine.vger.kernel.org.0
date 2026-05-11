Return-Path: <dmaengine+bounces-10332-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RgvcMb9IAmo1qAEAu9opvQ
	(envelope-from <dmaengine+bounces-10332-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 23:23:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F21516430
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 23:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F5643036E97
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0754D8D8C;
	Mon, 11 May 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TWlaz1b8"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF632AADC;
	Mon, 11 May 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534582; cv=fail; b=mnNd0xzAr1Elw58ut/dH7IUzpbsXmQSKjSuOrQsADwH9m/22ih1zwMXbcjD87xO4f5cL1kZjQz6r1NXpjkMHKesC2/Lx6KSoEMKtY9ENZIdsRONimmDahyVrSRb3SlkrmIUQuAGX8pcIswZVx0E5ja/HL28iD2rrYiRYwQqnjwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534582; c=relaxed/simple;
	bh=XcOp2i1kMZ9Z8SO//sUmdbqXzIQMSkagmbTff+qaXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HNsVo/uGaebfRSd0aKdSG3jkdlQdrs0WMDwg4w589GTc9R2QGvpWHRw/q6T2aOEispcwDhr73e1+OfYanf6sDCCUZY3QarWZeY6eg3u1CIV6EpwF7oZ6qS/e4+99Ut+nsRXcd2EL4t190RJMcaavQ/18gHsD6ZT6wKVXUWuzhgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TWlaz1b8; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGL1NpqmnTO7eo3Hc5Pw9SdaKKHQq8f4zi+id5ZyKRX2+R5Fz6rNeQ/ruyLqEmsvr2DadYBPmedNisMsSQLNRyHP1LyqbRbQO1V9BehQvHdJXgXj89p4G1L+0ojN55h6kpuxJqN18yxRO9TgxRj3sU1EMgmRYoxJZymZq+zgpQrEiaRua9+o7nDTz0chzYKQZ5X5mt17AUTFSJJVBZuNpbY1/Tjef0yu3IZr9B1RPsGRRNFh53JhqkEPzOkJjd/ZQYnOc2MQ8lON2tvI3iC58MPe+tkkuKXc7rGA5w2Mdoi6wU42XncBcf5Bm2Oc1CqcYGmDX2xjnLl08/f6NKYa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSnNfvPeG7v19WghwKI/nHDynI545h4dmlgrVTT5jfY=;
 b=jsAcOlUKRwva2/PXODVc4SX4QdzsPglgm2J5+6u1KPcG0PV3xEHNht9Z0AWlvAxz3kVzbAK+YM6qSLRGBGva0pq/dtNf9YZNIe6NXAQ2XGCZoY9Ov+4QP2rIqapOnRYfuseKuBC/VxVWj0bfmg0p9b+V4MKfJ9nHj5X7yASb8q3lpt1s+DLym5oL69eckmijB5R5UGByhmLejHn3LD1qgELBh8vAtxpmst640yJ4qshr/yrxlomia0ooBNE371XmnbXe9qBcaCx0z0dcA8IZTUnapW68E5zsD4yMGN6gwGh/ZibX/NAOz9e/FJLSpuHuW8n1G/PZuZsR6JECDPFZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSnNfvPeG7v19WghwKI/nHDynI545h4dmlgrVTT5jfY=;
 b=TWlaz1b8uXMw2bYxSqfHMCP5G885UrwZOq38l8POcImxJ0OIiRaqB1jj7X0vX5OOu38j7FTE5RxcQjiXpzIYiJq/1tU48OqF0JBNkBYo6DWTQb87M9XW6dT1Uyf6oKF69T04Ro2LCBj/QhNqISClDWWsfsQFjdbZhD4hQQgAhQkRMm09gOSlG8XXS3aEi7jg8QUsfML25jsA1eA9Z4CZrgghESUiFEeDfaCfrUeSQPLbKX4seUsNy2y68/X9a9GUVe2kHgoPgFhSUiDN488xGcmWn3QPQRZJuWBzBkTaNiFGuGCGUtOZjz05BD3j/ZlEB3OWUdJK3zINWsE+/ftG2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:22:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:22:55 +0000
Date: Mon, 11 May 2026 17:22:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 03/23] dmaengine: sdxi: Add PCI initialization
Message-ID: <agJIqejHX15_CeKl@lizhi-Precision-Tower-5810>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
 <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
X-ClientProxiedBy: SA0PR11CA0172.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a9a917-c4c5-43bd-47b8-08deafa377cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|56012099003|22082099003|38350700014|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	/A8Iv/BHWrHbdg0B7/LU3s4DgaSqueFPTaMkZT9YHmLqjf2b1dqVHmhOO0IJSv6KxrD3aR58epfDxNrBJfmlWPhYyvyu1k7VqMyTWLseIvnV0bSOHsW7EVBkaieGlDsgkXmnBliT9K2+AWMeS5hQdUb5g0+vQejY9V5M0icgKpCvbAB6hBOmpIxYggDzocVlrQ6PiLkQZMGY+wlVvKjHDjpJUj4OH0w4mUSRHyjkUzJeAJFZ2yVRizUTGTxibdeAoDfRh1OsSxXAwLjA/eZtG+Q9O0m2WR1EuQU6nnOLQtvQmchTcAb2P1IKT4M9XjRapDxUV6zll0AoIGvMU6pEy+0Wrh0R5RMkQT9DO/E1PPzNZLq9DIytwdlMvoaAOkRpA6dhTqVeOL+yLjt+6dha0pyPeTKmLbVdpQhiHkvYl62/xV+xUMgKnJv35RFz/Ln5yPTub2/AafWmWb6kM1RmyEqjdG9ZYXwfPdEtyR9I/TdS3Iq+mXPpLZq2Me5qcRBUmowU+sPoDv9X7s8SAWI6xQdwQmJAq++XgzUCGTKSRAmyEqTh1dhxgKFnzCAHdzUKS1KEWmVqz+BWFIs/6Vm7iDe7hs8GWhqIh39EOlqdxV8fse2L9iWAccgwYxhT1OrLbRxjQIrIzXr2wViCnL5aTEn6CZqvXQKtxr11qYFjv7yaa5nEEV8IbrJ7nTvDy0bn0mfQ+96repmHDAG+jDmrQpgCLEAgGZ8euXHWNzb0UR0t5MnGCLOiB1RRrx/Gdd7x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(38350700014)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEEeEflQR/Jz/XReSCXHnLekPkhoHMlhkl0X3Wg3Rz8aMg8K/XuF2iDpNAhR?=
 =?us-ascii?Q?CyJsqIaBfdPfycYjXJbtI83bj31Ojhh5j9zp9vNWw4p4Poz7R7h9cnvsC7+h?=
 =?us-ascii?Q?MZlN3RtMuUK23qZqPHe10hZqau+q1eCVFonAswt6y7aGpQrn2r5o0rAJzLlc?=
 =?us-ascii?Q?Cio/WzCZvsrzcVrTnquEPjMzHUFx47939XfXgn6PbfUlmlQceyvwnti4lmO9?=
 =?us-ascii?Q?vJPzt65cQcoXQki1wf9ASDTnXB8UlrjZaewxjwl3yncxwy+qN1wF9FreBWo5?=
 =?us-ascii?Q?6gepLR+AtmqpEJpXdtbhqUZfz1P+7q8arfnwe41BT9dMUigHq8qrK9L9oMRG?=
 =?us-ascii?Q?m/ZAjEiRvlOoDrtzIsvIJAV9eykcEHiktBoMqnqagPKC2C8Zvx14YnKcWUGH?=
 =?us-ascii?Q?TLkSwY7Ga0Ohi6iYEUmLrExZ6h8fKhO7jNsMfrx+9PxEuVx9zCoW1G47UwLm?=
 =?us-ascii?Q?tVupxqgQQul9q6gtAImKlNANoJmMPrjoP5WtyL//UJhDzDiH42/s9SQ5WA6D?=
 =?us-ascii?Q?TKZjC6Hrt6RGNtCqLNkUNroQj1gxE1p0ItE3wyIwLFWVo+ZsTZazJcmQoVtB?=
 =?us-ascii?Q?SRmBHDWo1+H+y+Aw1j84NGT9Qw5rQCYHGlbLQ7SfUVd9pUGD8IqeNYoyqsos?=
 =?us-ascii?Q?8z4hU2KXuYiRFEJcRkV08ntkgjp2XB50bvBryizfpoUdN+XbKGfjHOIS5nWA?=
 =?us-ascii?Q?P9mbUdgquBEgEpOCE589kcO8wLS7QWAHTjF1RqTsnIPIM2FTvYZkdJFdPcqK?=
 =?us-ascii?Q?4zzG+KSA/s/iv6dJiUW1XY+F/H2I4MY2frwGyq61PLe6mznSEjXglxxjuHKK?=
 =?us-ascii?Q?v/P9LUdWVS+N3u1MQEjgN0gGUxm+JyDr6It48JBCHFaikZP++tfvDa1wKS9J?=
 =?us-ascii?Q?EO5vUACa8yHgsJ59vpPYy9YLZGtqxK8JI/mAChcr0tmGpc7Gkxl7y9kgZ7+U?=
 =?us-ascii?Q?cDa4FhbgeUP5KVWkQLcl8H5uqTw3MsvlK9PPuWyO12duvojviTXYufMAGCb+?=
 =?us-ascii?Q?vDJANQc4HyGFwFWHRf9wHDpRH8TFBQarC8Qlbuqk9CSKZv4nHgvaxAKVEsRy?=
 =?us-ascii?Q?U9a3ldZ9Idy63fkatMIKVAZmyctT0ZJ1wgj1NeWikM/2vDKZhghpzzsjehZZ?=
 =?us-ascii?Q?skXwYzRaig6ZtkzIENMOMX01bqQTACdorWTyiQhp2JeTnONeUNkyGRcmwus1?=
 =?us-ascii?Q?fp7XSl0r/a2EifoZfa3kcPcO1xz1pJft5Hv/a2FssxXIeiVqSRfoJmno/ja2?=
 =?us-ascii?Q?cjMAlCrTI8MsQDMdmDcFh9AIm+V1LC6K21B4xqY/3RjcfyY6aqRuA7Jjr7nR?=
 =?us-ascii?Q?fGtjNZ9Qk+H2PQuNwAnoslfYKZPkzOC25o+Rdb2DtuhRweszGfO06cZCLHK1?=
 =?us-ascii?Q?b9LeFhbSjRpwFnagn/lw+yI4XkH22BZmcyPI7CpLsyD8Gl8lxgJiyKkqC5VI?=
 =?us-ascii?Q?IIOQoJ0tu/6978fQQ65v/rkFoKBFL9AnZsuxs439wA8bt2AKbuCWvrPx30Hk?=
 =?us-ascii?Q?ugKymKt/gjPB4zQ2nxq0Sshkx8BVhlagCgg/QSny3hoKzIS2ExkwdDK1hCOK?=
 =?us-ascii?Q?TumzwcHFKyPn+lwWS7Y1akis7h3/9lY7S6Ut5MgdMOeUwfk6fphOubDeDDa8?=
 =?us-ascii?Q?c/7JiPQ1R1jNVtRA/iXWTjLjMNiY6bejsvJABMz6QQ4Y4Bh30p77kcJmCg80?=
 =?us-ascii?Q?QsoRc/htrS9DPuDNXUVh+HjZebJLvFpAx5UP/xirePkJ2Ml6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a9a917-c4c5-43bd-47b8-08deafa377cc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:22:55.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd4Cnk4M1UqI+w0uzvbOHzGeXCZGmd/uzIZVcO22lW6+kTGtW92e48WyvbfPzNaTFM0IsNGkoJnSCMPg6AKWzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383
X-Rspamd-Queue-Id: 36F21516430
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10332-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:16:15PM -0500, Nathan Lynch wrote:
> Add enough code to bind a SDXI device via the class code and map its
> control registers and doorbell region. All device resources are
> managed with devres at this point, so there is no explicit teardown
> path.
>
> While the SDXI specification includes a PCIe binding, the standard is
> intended to be independent of the underlying I/O interconnect. So the
> driver confines PCI-specific code to pci.c, and the rest (such as
> device.c, introduced here) is bus-agnostic. Hence there is some
> indirection: during probe, the bus code registers any matched device
> with the generic SDXI core, supplying the device and a sdxi_bus_ops
> vector. After the core associates a new sdxi_dev with the device,
> bus-specific initialization proceeds via the sdxi_bus_ops->init()
> callback.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/Kconfig       |  2 ++
>  drivers/dma/Makefile      |  1 +
>  drivers/dma/sdxi/Kconfig  |  8 +++++
>  drivers/dma/sdxi/Makefile |  6 ++++
>  drivers/dma/sdxi/device.c | 26 +++++++++++++++
>  drivers/dma/sdxi/pci.c    | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/sdxi.h   | 38 ++++++++++++++++++++++
>  7 files changed, 164 insertions(+)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ae6a682c9f76..3d89284e7cf8 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -762,6 +762,8 @@ source "drivers/dma/lgm/Kconfig"
>
>  source "drivers/dma/loongson/Kconfig"
>
> +source "drivers/dma/sdxi/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 14aa086629d5..371927615c4a 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_SDXI) += sdxi/
>
>  obj-y += amd/
>  obj-y += loongson/
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> new file mode 100644
> index 000000000000..a568284cd583
> --- /dev/null
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -0,0 +1,8 @@
> +config SDXI
> +	tristate "SDXI support"
> +	select DMA_ENGINE
> +	help
> +	  Enable support for Smart Data Accelerator Interface (SDXI)
> +	  Platform Data Mover devices. SDXI is a vendor-neutral
> +	  standard for a memory-to-memory data mover and acceleration
> +	  interface.
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> new file mode 100644
> index 000000000000..f84b87d53e27
> --- /dev/null
> +++ b/drivers/dma/sdxi/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SDXI) += sdxi.o
> +
> +sdxi-objs += device.o
> +
> +sdxi-$(CONFIG_PCI_MSI) += pci.o
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> new file mode 100644
> index 000000000000..b718ce04afa0
> --- /dev/null
> +++ b/drivers/dma/sdxi/device.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI hardware device driver
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +
> +#include "sdxi.h"
> +
> +int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
> +{
> +	struct sdxi_dev *sdxi;
> +
> +	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
> +	if (!sdxi)
> +		return -ENOMEM;
> +
> +	sdxi->dev = dev;
> +	sdxi->bus_ops = ops;
> +	dev_set_drvdata(dev, sdxi);
> +
> +	return sdxi->bus_ops->init(sdxi);
> +}
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> index 000000000000..9ac94d6f8b96
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI PCI device code
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iomap.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "sdxi.h"
> +
> +enum sdxi_mmio_bars {
> +	SDXI_PCI_BAR_CTL_REGS = 0,
> +	SDXI_PCI_BAR_DOORBELL = 2,
> +};
> +
> +static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
> +{
> +	return to_pci_dev(sdxi->dev);
> +}
> +
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable device\n");
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
> +	sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
> +					    KBUILD_MODNAME);
> +	if (IS_ERR(sdxi->ctrl_regs))
> +		return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
> +				     "failed to map control registers\n");
> +
> +	sdxi->dbs = pcim_iomap_region(pdev, SDXI_PCI_BAR_DOORBELL,
> +				      KBUILD_MODNAME);
> +	if (IS_ERR(sdxi->dbs))
> +		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
> +				     "failed to map doorbell region\n");
> +
> +	pci_set_master(pdev);
> +	return 0;
> +}
> +
> +static const struct sdxi_bus_ops sdxi_pci_ops = {
> +	.init = sdxi_pci_init,
> +};
> +
> +static int sdxi_pci_probe(struct pci_dev *pdev,
> +			  const struct pci_device_id *id)
> +{
> +	return sdxi_register(&pdev->dev, &sdxi_pci_ops);
> +}
> +
> +static const struct pci_device_id sdxi_id_table[] = {
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, sdxi_id_table);
> +
> +static struct pci_driver sdxi_driver = {
> +	.name = "sdxi",
> +	.id_table = sdxi_id_table,
> +	.probe = sdxi_pci_probe,
> +	.sriov_configure = pci_sriov_configure_simple,
> +};
> +
> +MODULE_AUTHOR("Wei Huang");
> +MODULE_AUTHOR("Nathan Lynch");
> +MODULE_DESCRIPTION("SDXI PCIe interface driver");
> +MODULE_LICENSE("GPL");
> +module_pci_driver(sdxi_driver);
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> new file mode 100644
> index 000000000000..d4c61ca2f875
> --- /dev/null
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SDXI device driver header
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef DMA_SDXI_H
> +#define DMA_SDXI_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/types.h>
> +
> +struct sdxi_dev;
> +
> +/**
> + * struct sdxi_bus_ops - Bus-specific methods for SDXI devices.
> + */
> +struct sdxi_bus_ops {
> +	/**
> +	 * @init: Map control registers and doorbell region, allocate
> +	 *        IRQ ranges. Invoked before bus-agnostic SDXI
> +	 *        function initialization.
> +	 */
> +	int (*init)(struct sdxi_dev *sdxi);
> +};
> +
> +struct sdxi_dev {
> +	struct device *dev;
> +	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
> +	void __iomem *dbs;		/* virt addr of doorbells */
> +
> +	const struct sdxi_bus_ops *bus_ops;
> +};
> +
> +int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
> +
> +#endif /* DMA_SDXI_H */
>
> --
> 2.54.0
>

