Return-Path: <dmaengine+bounces-10381-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLe4Aq+IA2pN7AEAu9opvQ
	(envelope-from <dmaengine+bounces-10381-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:08:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CF528F52
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C1BF303989D
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1633A9DB1;
	Tue, 12 May 2026 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IaBemLAf"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F02EB5A6;
	Tue, 12 May 2026 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616491; cv=fail; b=HV2hDHZL3fEcPZwJO9+O2gewFlmPlyYHGYtY6N8ANFIopgJt0PzkUX3q6kcPAng6nXXtCJaSRzbBPaPIQH3y42l0V9r9AtQKdb5imsZM9kTcJOi3UIUfuopy17o/ZtmppAe5icOduT9LIrNmagda3oB/LKGBnVSFNi4hrzVDSO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616491; c=relaxed/simple;
	bh=FR/ux/39XbCrUff5Ou2oLIyMmJ8Lt+jPi/n049H75JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFlbkcRT6xrMvzF+iBIQe6B7EnziNmpKK/6MAdhOuo5i1/DJFshz3/67eemruyf96LOpIgcn762He7qNJBEhYk4KVPTXZ11tNb6RPBpZsXJ5mvzaF5arLw/vhnul3KiN8M/acNHVIADZ0P4pHy0+kn6y8T9qYSa+C0hfnPLXcOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IaBemLAf; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzsMqITRlrpGX98oB294Mn4ePn0tlsx2ZJ/1hzZKWXqXN1e7d8NzdjZ4tE544QTB5qBJKD8im4di0fKJukXebCXMukg/BJOH5v/NCG7S8GcHluhEdCh5DKS+Wp5xSG+/q6AEZfoPaQVIlOGroLKg7WQmRQFxzHJQK71PTT4OiUsVy9P4qRxnDNwXHNPB/s+53z1wE71a+/40PIAFqejCitKAkh8pXpRxKRr2CBOlkdFEB/tk9gUBlVy3DcaaHkluFWH/fqsuKV66gTTXha6W/87OxPI5otvo5+UAB1dQMoyXXcXawd3cX2OBCuQ2UOAXYCpay4d89baB5ATgTgDIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO476s24IvCeg15EBwApzet8WtlspJRBVC1lByQi53U=;
 b=pDgtMBT4V+HPlpN1jQERvJkPCM6xCSyLP5CRqrxQ0qLMvoxSoOao8mdpaGI7OuxjWHvM98VTzXB/XgGwl7KIA+vVLK4oYOCzhnS2ry0VajbudfGZerentHqbusLA0Gl2YAiTiELt7LfPxuSw78IH7hTvXJ1UZ00/f8xGe4LEOmPRT7KePfEN2+VR5g0BxFANSmvpcCuJ0LE+BbpJybv3i1tJlrgJhpfDyzy5idHQV5Uhjf9ZvetbDa/+bIabIhFE6CvBEaYsOvoKxxj+NQE+eg+NyxRvxh8TtmXylVqW/TyHB5NilNa4v6ckeLMt63f7qjwLzU/EWLsD4gytRUg/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO476s24IvCeg15EBwApzet8WtlspJRBVC1lByQi53U=;
 b=IaBemLAfr/x10Fdol0UF9qMrrxLS4b4UknC03OP2faP+lt3fh+9eYimjamI4Qx7Zae7wKtt4Er0zb4T4mIsV5P4f2eNKG7ojPUhr2FRX9BqCuzLlJ5I9Z3D+KVxFtcYUWBjp+epHTnyaCOFqNMaKObafhzMWC6yuxKDaAumY9cG6KyauHk/SpY3+oeWC80fGAVv1AV7R7ZMlWlndo3Sictw5yyZH8/N5HbIvcFJODjBaawtehcGOl+jl/bj8F7QqjPH3MNB7afysDKGkOCMo3CwcGJjKMOLjPCYGygffti7NmxnbGRwqZGty9Ocqz9E6unBoFq/gPBNZ9hazngiEwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8165.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 20:08:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 20:08:06 +0000
Date: Tue, 12 May 2026 16:07:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sheetal <sheetal@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Sameer Pujar <spujar@nvidia.com>, Mohan Kumar <mkumard@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] dmaengine: tegra210-adma: Add error logging on
 failure paths
Message-ID: <agOInxpOCTgX7dwi@lizhi-Precision-Tower-5810>
References: <20260512092508.1406119-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512092508.1406119-1-sheetal@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:806:126::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 923d793d-93a4-470f-6e2f-08deb0622e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WdxN3ugetvoROTzeKryIofZy19qb8/ovm2dXlJJiXG2WZ8D/gGMGUaLexS5gila2P9h5t0cxZr68Xee1RJDC4+ZIuHv2U2MZ/VEAPXU7Vcf4lsXpcVbZYvEcUL+47DvOOmQoFrEURHHnYlDbtlNREdtK3Gwvekhia8FKx0kjCL2BgaE88QDHIF3nk6nY9zQod2CXJGUTOG70VpovlH5Vt+v54F+DszgNuvu0pkbyiFBVH7LKTZTZAPxD6F5ilo9GJQoS1pW6sna6JP4sGm/cZKb6xHSUhnrIphc1mkFV085IBwxLfsgQyu2TmegX0cM+/jIzsnf+0vLqeWiIGn4UnsNz9VDv9/6VlKUg+Ox/5Iw0nybYE+MogGY1gE6EFzNKqKa7aSK3i29TjLuDoL2so2oZzk+C9xwnPQFdyHA/NOsIqBjlB1jBUSK+y9u1woICCggGEgBXxgHLIB45uzxdzDznh8yidJaawLEfJQWEvLh3vm/S5Vu/d2Po2cDdO8e+6vUnHc9aQT5N/dnl7d7kuQHEns3jU+vxemCTdmj6cgR0PHS59dX3DBb9/Jn4zt6GsIKqlwYAY/jByQpjkPrVzUc1WeQj/8suLyXpjJ8JsiI79418Umx7elWIaO9PXafXqsHMk2h26PwuZxz03exg/vfb4gcTuI+Gh+EnBctSQvJkSSE/BJSZFjm7rZ0rj2prSXBKvatWh+sM0nwcUMT6wSNcnB2BQ0uwanC6VRtEhHStTiUn9/oL+UtnFQfXCeHW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(56012099003)(11063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pfrsnsZ2sX3fQnQrhHqguAVhScK2GYweVycuYFt7L1BfRQkdC6X7vNj6gz0X?=
 =?us-ascii?Q?Ac0dWRb4ER8ImDNTK4QSLQ4qkVsJCnFEMEdYSpkNEoxJGYVEG9VjpT4cuMXX?=
 =?us-ascii?Q?ddQufGlGd/gCw4s07Z9fZQ0qDo3PYuYZ3uWPJhY5rnTuTn+yzwVEPNJe7sDj?=
 =?us-ascii?Q?ayvTRz0NilL1Fgevoze9/EL4JVv3TA7KOipfnnxIHqRRYV9DH36r4j5b/n4a?=
 =?us-ascii?Q?fIoe+WOwo3DPwrF2vpMq0YCJqpEMc5oV3wEFSl8m+0u9PEUYkTX2hyPnnprb?=
 =?us-ascii?Q?wLbzed5jBe1/onZ7xNnd5scK/BB6GbOWf1qXfDU+hXgWHICcDL2Mpvz/aAuk?=
 =?us-ascii?Q?7vq7C3GBPY5gnopjLo+b8ypalfHks63oPxUu9PBJTjAcCBSaBRMhgZt6i4po?=
 =?us-ascii?Q?3Ig76vE1tQHlrNanTfl7anOYzMUU23GKIWNqAv8FLH8yx/VwQf/YmcltU9D1?=
 =?us-ascii?Q?o1fLHhfZxBpo8dQa6/mtcHyzPM/26gksXCkWOlNtRW7DBIM6haxNao22e6tf?=
 =?us-ascii?Q?LVQ6UWvA0uuLotuygTEps0pQ7hBcaJ1YDBdwyeHcz/wtb4UYOct81tphOqrV?=
 =?us-ascii?Q?byjSzaK/ITze5M/EDf2HhxKVbeuI6qTRFHXU+QmHntdZz/akU+SoBPnKOUsy?=
 =?us-ascii?Q?WRFdBlU8vuTpaiUVj7cwwt4bhL1IY8NWyoPA0IIsLP/fJDj1LcVDS8tBk7q7?=
 =?us-ascii?Q?UK+fDBQDIBntLIN8pFWWIUiBud6ws0CcJ9hhrLZs+x8WIkiGRoNQ9IYU3bi6?=
 =?us-ascii?Q?77Zr5yg2WgHZBvWRZN9uzXwH9H5simDlTydVGhH3xZyowdErVs26Wf7/IU0s?=
 =?us-ascii?Q?zQf/LLqoQjpqKXO2jDNitUBlbEo10KXjgokzdi17q8x2+4XkRokN8pbunPyi?=
 =?us-ascii?Q?rMnuIr3MLlCFGUwOXad0EotBG4ixA5hYIOdNQ8Q6WtyzU36muZpKTRM/4jyT?=
 =?us-ascii?Q?ngMuWYZZTDG7nlRBhxpA4RTqyziVOKU0alKsIFCxRiQ2uFPzIcu5HRYdjxEP?=
 =?us-ascii?Q?EecjVHDggb41R0R8LFiE1aw7Hgl/X74k2qLYZ4r/ZyNId64Pjo6CiNuzD+pq?=
 =?us-ascii?Q?CNTcZkCVjZp29/4PVEZ9zhFDeV4tPfkD7E24YR8iXJEw2hH1SBU5qVERkjK9?=
 =?us-ascii?Q?rKQ6jAish3J408qj8O2nfZZEZRQBZm21g3dDP9KZ1AIY4Pm66SuY/2HuCecj?=
 =?us-ascii?Q?xFvgzZfaJRfe1YxlS5QuxW3ESqj35N4j9Q+AJ+XsU5CpFW6VTEtggOAcbvLZ?=
 =?us-ascii?Q?6AU0ryQcQI8Ml9W3q2+i9KM37flTL4OrZndKWAhFeNx3SkJ0icjCmOmLjgBe?=
 =?us-ascii?Q?q1HysOSmRpXFhVFtwAO4fChQudXLOBc6ugoaoA6roYnAHv38Ar7n1SLIDM1j?=
 =?us-ascii?Q?ce1+/axdBkmLNRal6ODPK5KaHwEAP78PVSO2ssEjskLdNMBt9yT9kTd/cj0l?=
 =?us-ascii?Q?2AKmoyIVLow4oI6r4AihjCgWBeMj9aluAp19TXeXFh+msDXUA8aldR7Dqxys?=
 =?us-ascii?Q?aDGEmq+SLwjAFHdDTA5W5Zz+Ativys6FxR/HSH18x2W2LWjJJro/qfEIyROn?=
 =?us-ascii?Q?FNnL5Z0vtulm5LezYMbunUnS1QxcmT9M12BJJpcuooCoDB+Ih3xeNIory8X9?=
 =?us-ascii?Q?hVCPRI5JhhifVIiU1cmTgaZl1mVRqhMu0tkF3O3aK7TmYyLwQZXKVjUdMtYM?=
 =?us-ascii?Q?bR9W77UYjbw3WAeMAF/PF1NtPhoPj0eZpnZSw4SPSA6QyScaOYf2AixKNeWT?=
 =?us-ascii?Q?5FhU78LPCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923d793d-93a4-470f-6e2f-08deb0622e0d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:08:06.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xYKk3ivuGpoTon4bwE3NQaY8eX63OJmBZuiToCuvNzpGzgyE3weuA0AP0Hx947GY6/Wu+AfJyqIs9LOeElZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8165
X-Rspamd-Queue-Id: 6B8CF528F52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10381-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:25:08AM +0000, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
>
> Use return dev_err_probe() pattern consistently in the probe function,
> and dev_err in non-probe functions. Also convert existing dev_err calls
> in probe to dev_err_probe for consistency.
>
> As part of the probe-path cleanup, use dmaenginem_async_device_register()
> and devm_pm_runtime_enable(), and add tegra_adma_irq_dispose() for managed
> IRQ mapping cleanup. These managed helpers remove the probe error unwind
> labels while keeping the remove path minimal.
>
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
> - Document managed DMA registration, runtime PM enablement, and IRQ cleanup
>   in the commit message.
>
>  drivers/dma/tegra210-adma.c | 123 ++++++++++++++++++++++++--------------------
>  1 file changed, 68 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e..6987bf6ec648 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -335,8 +335,16 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
>  	struct tegra_adma *tdma = tdc->tdma;
>  	unsigned int sreq_index = tdc->sreq_index;
>
> -	if (tdc->sreq_reserved)
> -		return tdc->sreq_dir == direction ? 0 : -EINVAL;
> +	if (tdc->sreq_reserved) {
> +		if (tdc->sreq_dir != direction) {
> +			dev_err(tdma->dev,
> +				"DMA request direction mismatch: reserved=%s, requested=%s\n",
> +				dmaengine_get_direction_text(tdc->sreq_dir),
> +				dmaengine_get_direction_text(direction));
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
>
>  	if (sreq_index > tdma->cdata->ch_req_max) {
>  		dev_err(tdma->dev, "invalid DMA request\n");
> @@ -665,8 +673,11 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>  	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
>  	unsigned int burst_size, adma_dir, fifo_size_shift;
>
> -	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
> +	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
> +		dev_err(tdc2dev(tdc), "invalid DMA periods %zu (max %u)\n",
> +			desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
>  		return -EINVAL;
> +	}
>
>  	switch (direction) {
>  	case DMA_MEM_TO_DEV:
> @@ -1020,6 +1031,17 @@ static const struct of_device_id tegra_adma_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_adma_of_match);
>
> +static void tegra_adma_irq_dispose(void *data)
> +{
> +	struct tegra_adma *tdma = data;
> +	int i;
> +
> +	for (i = 0; i < tdma->nr_channels; ++i) {
> +		if (tdma->channels[i].irq > 0)
> +			irq_dispose_mapping(tdma->channels[i].irq);
> +	}
> +}
> +
>  static int tegra_adma_probe(struct platform_device *pdev)
>  {
>  	const struct tegra_adma_chip_data *cdata;
> @@ -1029,8 +1051,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>
>  	cdata = of_device_get_match_data(&pdev->dev);
>  	if (!cdata) {
> -		dev_err(&pdev->dev, "device match data not found\n");
> -		return -ENODEV;
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "device match data not found\n");
>  	}
>
>  	tdma = devm_kzalloc(&pdev->dev,
> @@ -1056,7 +1078,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  			unsigned int ch_base_offset;
>
>  			if (res_page->start < res_base->start)
> -				return -EINVAL;
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "invalid page/global resource order\n");
>  			page_offset = res_page->start - res_base->start;
>  			ch_base_offset = cdata->ch_base_offset;
>  			if (!ch_base_offset)
> @@ -1064,7 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>
>  			page_no = div_u64(page_offset, ch_base_offset);
>  			if (!page_no || page_no > INT_MAX)
> -				return -EINVAL;
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "invalid page number %llu\n",
> +						     (unsigned long long)page_no);
>
>  			tdma->ch_page_no = page_no - 1;
>  			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> @@ -1079,7 +1104,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  			if (IS_ERR(tdma->base_addr))
>  				return PTR_ERR(tdma->base_addr);
>  		} else {
> -			return -ENODEV;
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "failed to get memory resource\n");
>  		}
>
>  		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
> @@ -1087,8 +1113,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>
>  	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
>  	if (IS_ERR(tdma->ahub_clk)) {
> -		dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
> -		return PTR_ERR(tdma->ahub_clk);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->ahub_clk),
> +				     "failed to get ahub clock\n");
>  	}
>
>  	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
> @@ -1104,11 +1130,18 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  					 (u32 *)tdma->dma_chan_mask,
>  					 BITS_TO_U32(tdma->nr_channels));
>  	if (ret < 0 && (ret != -EINVAL)) {
> -		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "dma-channel-mask is not complete.\n");
>  	}
>
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, tegra_adma_irq_dispose,
> +				       tdma);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to add IRQ cleanup action\n");
> +
>  	for (i = 0; i < tdma->nr_channels; i++) {
>  		struct tegra_adma_chan *tdc = &tdma->channels[i];
>
> @@ -1127,26 +1160,33 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  					cdata->global_ch_config_base + (4 * i);
>  		}
>
> -		tdc->irq = of_irq_get(pdev->dev.of_node, i);
> -		if (tdc->irq <= 0) {
> -			ret = tdc->irq ?: -ENXIO;
> -			goto irq_dispose;
> -		}
> +		ret = of_irq_get(pdev->dev.of_node, i);
> +		if (ret <= 0)
> +			return dev_err_probe(&pdev->dev, ret ?: -ENXIO,
> +					     "failed to get IRQ for channel %d\n", i);
> +		tdc->irq = ret;
>
>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>  		tdc->vc.desc_free = tegra_adma_desc_free;
>  		tdc->tdma = tdma;
>  	}
>
> -	pm_runtime_enable(&pdev->dev);
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to enable runtime PM\n");
> +
> +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&pdev->dev);
>
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
>  	if (ret < 0)
> -		goto rpm_disable;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "runtime PM resume failed\n");
>
>  	ret = tegra_adma_init(tdma);
>  	if (ret)
> -		goto rpm_put;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to initialize ADMA\n");
>
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
> @@ -1170,53 +1210,26 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	tdma->dma_dev.device_pause = tegra_adma_pause;
>  	tdma->dma_dev.device_resume = tegra_adma_resume;
>
> -	ret = dma_async_device_register(&tdma->dma_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
> -		goto rpm_put;
> -	}
> +	ret = dmaenginem_async_device_register(&tdma->dma_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "ADMA registration failed\n");
>
>  	ret = of_dma_controller_register(pdev->dev.of_node,
>  					 tegra_dma_of_xlate, tdma);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
> -		goto dma_remove;
> -	}
> -
> -	pm_runtime_put(&pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "ADMA OF registration failed\n");
>
>  	dev_info(&pdev->dev, "Tegra210 ADMA driver registered %d channels\n",
>  		 tdma->nr_channels);
>
>  	return 0;
> -
> -dma_remove:
> -	dma_async_device_unregister(&tdma->dma_dev);
> -rpm_put:
> -	pm_runtime_put_sync(&pdev->dev);
> -rpm_disable:
> -	pm_runtime_disable(&pdev->dev);
> -irq_dispose:
> -	while (--i >= 0)
> -		irq_dispose_mapping(tdma->channels[i].irq);
> -
> -	return ret;
>  }
>
>  static void tegra_adma_remove(struct platform_device *pdev)
>  {
> -	struct tegra_adma *tdma = platform_get_drvdata(pdev);
> -	int i;
> -
>  	of_dma_controller_free(pdev->dev.of_node);
> -	dma_async_device_unregister(&tdma->dma_dev);
> -
> -	for (i = 0; i < tdma->nr_channels; ++i) {
> -		if (tdma->channels[i].irq)
> -			irq_dispose_mapping(tdma->channels[i].irq);
> -	}
> -
> -	pm_runtime_disable(&pdev->dev);
>  }
>
>  static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
> --
> 2.17.1

