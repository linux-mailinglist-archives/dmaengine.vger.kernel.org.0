Return-Path: <dmaengine+bounces-10327-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA1oKUo8AmrmpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10327-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:30:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D67515E1A
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE980301F335
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D8737FF71;
	Mon, 11 May 2026 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/adC3U9"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0B2FE071;
	Mon, 11 May 2026 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531210; cv=fail; b=TlSnHkq5Agzl1/smsoKe+TfnHUZrqIJg0AcNJ7xO4PlIAG5k2xAl2julY1eTkT7hkNdnJmoPbW4aYTrCluRacA078d7hzDarrdXRb2rJ+WKE7kNSJLT00oWH2FyP1KvRs8r3PV6himvnQB9w2YhiN0brfhcpNuaaqrdS6Iep4Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531210; c=relaxed/simple;
	bh=Y809EALqfDAH8unSH8/BoxxXPD0PWyy2zrJUk4Ezd3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fIJkIPSTAy0SY/4MDm3RM3TlbQWp8AkGB6d8gARpQgKQ2Sq4CDeIijyr/TVdxvnpM5ZbZFF6Tv+8kYkQqc4/DbKE9LXpyK0Ub18uu/Zx6eq3g1PWhpexRZCQg7skS/C07iFzrjBuKvYKWf79udhbk5H7MNDr5luxTY7f5t6w6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/adC3U9; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOk3rjdBxSeCzRvDwj11dRirEU5ufjzhH3mA4GfrQVH9Gfnq7y49Nju5GscqdgxXPgMyHzK35+HloG1AyVAuOoap04vaLcrajL41zvvyFNQxqixEZCaqpKIhW89ncyFJ+5YRrnn59SOXzbNbrDfR5jduooXfxbK8FPWMaxjV0Jifw2Wm34skdK8gd7r2fvwDqZGzyZrkJpzI9F5GzUlCz+QovaSyQtn7+j82isffoKB83ka4p1uYRh6KEwucYXPeKMUCydAVU2GNxUHyZHvS12SN8Z+sc39ePy2HSRzHWy7NN/GtYPiYpOkPKLoe3TsjRvxZxtHMXR+2cR84Uo+Zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWBG1FYAm9wupyoVOaf4dsU9RXnyzmg9J4CDfJVfXEs=;
 b=GCkbqhC+m4F3Dy3oERzARTOw8MNZqYLkbRl6f+O1LFzwYtxnu5CwZ0nLrYFqZq1uFeBxEG8zGE4CyJcsNOjsC5uOHGj/AZCGT0wbTiBEFnrCPN4kpdLMaaLPNN0xW6BFN/Ip4vV/lbra+V+GueXX2D1ab4dEEs5oreNLp6OkOtPJXmBT+Y+bZ4t+ENUWrWvEZIPsISf30OybIIfTHtVQfMadvm4WGkis4EmiQX13xOQ8Q9v+nQbdev+zt3lmC60nAXeEISvhhftJH2baaMujxSd06gDuQcGZsVGWOLgp9x765oyeYxzJZWJcPDp6fsUZdomVBXuDlrmPhtuNKuWB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWBG1FYAm9wupyoVOaf4dsU9RXnyzmg9J4CDfJVfXEs=;
 b=T/adC3U9KMRPHE6eCQ1xGDU/g/J5bW43Fs916EjBcc+52RweM8UOe3LdJSVuLny719BJxcjKpcFoyZAqVhoO19lR/NWnOM8gR+mfk5VdMoi0E3E3Ry0BiX1WrbE8uDVF7YH+6Lttn1PBYA58hPmQzx8zedWInyT8qDD4pu4HVlBNv+1GQ/OzvAy9p86WLF++rECDNNrzPwKhH2WNGr0ZHbKSYPprac6yNWw3whnQ1G+3RCTclpE8nwD/nuMwg5rS4p03bpNHfwTq1ySoaooqFlHZuQJgo+eok/zi8rXAMY1VeeZKneLihozBwy9aFFyMG7UHpNmYNqrAd8ofPY29tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10174.eurprd04.prod.outlook.com (2603:10a6:800:243::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:26:44 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:26:44 +0000
Date: Mon, 11 May 2026 16:26:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sheetal <sheetal@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: tegra210-adma: Add error logging on
 failure paths
Message-ID: <agI7fdAJFfLUzXoq@lizhi-Precision-Tower-5810>
References: <20260511092458.1299793-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511092458.1299793-1-sheetal@nvidia.com>
X-ClientProxiedBy: SA1PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10174:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aae0cd-44a4-44b3-be23-08deaf9b9e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|18002099003|22082099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bPfxJXc8rQf2cJuUc1pF6cEZWVihi4OkSlQ8l+ZZwE9+6RNMUrOjuIl1Tuj0ICxoMWRkVUOBHNgFeti2Umnri+UfLBpenRF/w3WsMRZ5Cw6jh6K0dZnCfMeABk9DoJctILV7HdtPOXMyy8ivZzJR+M+2T70uma9VvKX+4Kisejkyk9SAcSwLzMuAFUwAajp+jgTL6lXmqzlKH9KFCaOd1ImI35V1fPHAkrnPPa2shKCfeKAcHx00ns1z+aVB+5frJLfRA8OmD9zJ8moc7oedseKuyYI6k0MznHs49XESxVmMwKGlzxHWf/7yRhwbjFbPZE599kL5dsboRXrEai1S8wOly24ivFgiNI9D+VtnKNgjTBFkBLRgB0kl8QPndpcrOAc+9E23hWPb4/dWtbxrUpHp8z/2Em41J0XcRpqA8CsPXrBVtKWXRtY6Sk8wI9icFd0zJjR4WCg+qPu0Wt0Q3eEMU0lzgDAUKoxeKhni85cerQ9qTo+mtE0ZQMrsSMVEOA9RW/Kw1j9zhomEjSSJtZ0ZRobXw0kadgGjXysnMKbQd8abwMDpA3tv8Ng1jxN7cE1+q6kPL3rkwrt1Faiba/8NqvabOBvhmzKnOjARr6RVUST6Q3KiAI4fJRMKCS+0AUESQtGC+UZ14/x+c1XqQBBRHfxuZ+YbfytjvXwSldDYwscr/ywco7DUjiDH7KXXdvcvJLHXAXfPl7HQcuGQxzAXPj1rIuOW/QB5VGE6teFaDydIxZJWrPvqpBQEDAWi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(18002099003)(22082099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qAfPWIRU2C+Eu8zTNvTId1ENIkpCa5PRPeDsS8sHst+jofQiZ7MXOBXLBIM8?=
 =?us-ascii?Q?JTJXAON7CVRhyPkKb8TGW1fJyFb9j7Ve4rvt5SPjERVbDXNh71i95fywWwSj?=
 =?us-ascii?Q?SRR4/pRyeqrKHXkQiHgFS/VjZNq9gyKAnrcR2Tb54iiBVcDElBYXxC3sUFSA?=
 =?us-ascii?Q?IZvDqb5B3bSgfcyY4q/shuwVIvC4j5072xz0mvf4/yoFB8RK6PvaQiIGvBPn?=
 =?us-ascii?Q?gRgDFsOLubqUz6i+J1DYuK1odQ6u19z8jvqgMVR8NOjH79zd3flZcPxU/7gZ?=
 =?us-ascii?Q?Sn687Fskxbq4Qr26xw5Iu4ouWW2ZOoaZz2QvwJ7//bttr3V59teAvC4XGQAg?=
 =?us-ascii?Q?CBDM1S+71BZpGlwE++J4sO1l05NzqZakyKTB35V5qr8LY1cOLw9EBWTB406Y?=
 =?us-ascii?Q?8QXOOglpSU6ZVmyx8VyZnm47pBNiJhw8TQd0wbM/rDzjz2YtZn4ROKp5NKO2?=
 =?us-ascii?Q?5Gw8x2oCLatXF+XsEjUTwQNuYYFQ/ff7ZN9A5i4zSYmvI5WuZF+1Q6dQjEgY?=
 =?us-ascii?Q?toitUjz1vi96C9Tx4u0CbXqIF7/bgPPeAQM/4Y689uTbDKxI2sUnKxg7vZxk?=
 =?us-ascii?Q?no5jFJKBJISdxdDAX7ey63pWCknesznFlKasz8R/Sv/q8BiYOGeo+0RxTS4a?=
 =?us-ascii?Q?5ApsY/pn96Nv09c37LwMVpvXLHkbYvBhAs42POuSdwrS6xnV+CdDd1zeuhNp?=
 =?us-ascii?Q?E5tu5HGvuBZ2ClyRSVU65txjJU2mRYBygee/g9w1EF9ZQA8Com+gZKFxO8Lj?=
 =?us-ascii?Q?nGcEk7p1K4+SUWsY9pH+7w+iDnOU2qb+Eq138O07bScuAsyljx1YDIN11rqq?=
 =?us-ascii?Q?L1WlFbq44mgaQuzj+bDHxOvYKHugWx6j7DOUpMRZHGHYr3DZeK0tI4ixpabb?=
 =?us-ascii?Q?Nrob6eSQQMMgf+cjhf0BckbwycyS8KnbhLAAnmmBxk6UaPmSlOuB0mUCvyXm?=
 =?us-ascii?Q?IUYJqTjv6vEoHYmgnzFO6vKyCHoxDjm5uJ72/m3w+xL/ukMPtePrNwBjilRt?=
 =?us-ascii?Q?Pid1y/1RS4N+/zt7fBH50UWAIA+E6WiRZFEsyu5wEZrX7zG6WjeXhhuiensd?=
 =?us-ascii?Q?V4VbT64X0wZgUEhk/aflALYWF5uCRgXuzk4oNE+1pOo4GO9jPgagYxSHWPLX?=
 =?us-ascii?Q?G1fpS+i6fycavRHoD2hudq4df77mc8Z6zbPjiELu5b64r+iWORVKxXsr0RPw?=
 =?us-ascii?Q?uvkvGlhH4gdBmOIaMpVBQh2YjcvoKTFFXthCfdUfIZdfb6fAs1NlXVAef7W4?=
 =?us-ascii?Q?EHQ3aMdGNwiCP0LhfD8IpKBQZfCvT7qXQGPifBEqNoVt6h6W2B02CQix9D1F?=
 =?us-ascii?Q?eWfxwbaPSxaNgdpg82i5xUA31FrdzuGOaJWBtTA1YaIYh6scoU13LohnICNy?=
 =?us-ascii?Q?kiZ18j4CcNxlvCFAGWQJuSa1YC3gVi29JMFUlUrGyQ9XxVYhADL6SjpTnKmt?=
 =?us-ascii?Q?LapcyaxMSepIQpn3PvnNmR1x2utZYRG7Nnc20I0XeHJbJNr1pO0mxoTUGRvS?=
 =?us-ascii?Q?g9tDrxy9lcDWpUaCC+T7AUmGsotosRl9ENp2uzvO20ZPDulG/dqq0j0ZwNPb?=
 =?us-ascii?Q?Bbhdx8Ieamzh2W7Y7IVjTng0UXreksv5LD3fQLbAauBiVrfx55Y5FP9YgMGA?=
 =?us-ascii?Q?399/inOw5LTx0T4ewMofYK7OqB/eaG/2eKKTQFiI5GhFlz9S8aNtQ0HfNyYl?=
 =?us-ascii?Q?EjDMc2VPavQgaeaMDYS8Vc700slnFM/coG7H4FfdcT6ddBK6t26TJ5fQa0Cz?=
 =?us-ascii?Q?NBuf+YTtqw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aae0cd-44a4-44b3-be23-08deaf9b9e1e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:26:44.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buI6djAwotjsV362Q/gqDh2PS75t6Z0Y6qpZby8gtkgD5zce/clf0hZNZUHcUWvtqvftWDT+FhUjzWkeGWdFhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10174
X-Rspamd-Queue-Id: 19D67515E1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10327-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 09:24:58AM +0000, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
>
> Use return dev_err_probe() pattern consistently in the probe function,
> and dev_err in non-probe functions. Also convert existing dev_err calls
> in probe to dev_err_probe for consistency.

The whole patch looks good. Only missed description in commit message,

1. use dmaenginem_async_device_register()
2. use devm_pm_runtime_enable()
3. add tegra_adma_irq_dispose()

above 3 works to cleanup error label in probe function.

Frank

>
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---
> Changes in v5:
> - Use ACQUIRE() for runtime PM active handling and devm_pm_runtime_enable()
> - Use dmaenginem_async_device_register() and direct dev_err_probe() returns
> - Use managed IRQ mapping cleanup to remove probe unwind labels
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

