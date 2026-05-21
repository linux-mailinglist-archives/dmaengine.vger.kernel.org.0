Return-Path: <dmaengine+bounces-10693-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJqjE245D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10693-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:57:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE125A9B79
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E05E323EA4E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48937AA83;
	Thu, 21 May 2026 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="We08MXBO"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3B379996;
	Thu, 21 May 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379621; cv=fail; b=kkCFR6MQAMRg9wouScki+GqZJkJVBCuEk9tCjdn06LiAWHfysydYGsysDzoe8ex/mIQlobsye6uDYeawwI4chCgRlMwUNL4TArvmFYN+k3nusmq6xgHuTI3pqaghxL8oPgYihN7U93u/WiUpphjwygvkkZUnLkgfk8PWOgCtTS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379621; c=relaxed/simple;
	bh=CZUCTc1ig9pomjWibpg+gqLc3eAl1VuKi1KMDHu6jRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K4WhLNBBYGOSua8FYTAVd9c4uWjpUWezk4U8q2TwESisgr5Czv6G7CjyO9LWU87wE/ddwsR2xuz9yIb3GR7wHJ4lgB/Fkgqqvs18hCgaOEqE+xalS154Rk3PSZ+IfwGCHzMzmS0kWZbRMrfdVahl2noLIhC3mLjnyFn+xpcqTeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=We08MXBO; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtxV60dNHrh3ymtYHM7xjlOJnbhsCEdymgB7AesiJ4ckRbt14qzEjtWXTDSHXWkcaBR5Dq4WdP0YxO/rnvu+coCzpmWw2vSnvMjq3DX5uwoJ+SczDs23bUk9Y9V539yUQ9EeohnPFOSJVYDaw8g9Y1O5TSb0FicA6j9X/mxneQVBO3RX6gIwiCu24yETU/9pvZsPf3MZwue3RX2iBCvrcoWYzn19X7tKauqDsSkIotFr9YOaRGHae2i3l47CXEZrmdgduEDPjs/r8/cYIGdRT7ALBQB8OEPcqeRc6nUu2FIcMprOCvkDL2znklXFVx3Icize4siX/cuDRUcKnXJohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5FdZbHeytJ7wQ7pQx8R1deMWmX/FzVsWIqmWT2dI7Y=;
 b=JLzzRi/CC/HeqgKVXa6i2Im1/+hJ7HK9SZ1gOKKDvwcdJWoB3OOlcAH2GE2uww4XhM1z2qO9JPNF5iAy0JzpRLDO4Hdbukn4G7ubgoz31zzpLx52ODvTLjeoPIspfxyrtaktmA/o7QNNODuJoEvS/jlUu9JJvqQXZRUWOteIEdtPZqToGrz8+HS11bH5gyTiBnIkp9FEh9NAjADmGmQDqL0Lbbqjw98iBeO3R7rDhSSKeBFLOwN340hrd26NMPU9lnMA5OJ8VQRAARKqkUwjENkJGvGviEgJLTh2s9LkryfDuWEmlq5rsasOxxOdIGJ2yDRuPTbFCuGHe+TDFvjieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5FdZbHeytJ7wQ7pQx8R1deMWmX/FzVsWIqmWT2dI7Y=;
 b=We08MXBOEqiD1vM/KZE+IdkZ4a/k5W2iwYGYXiqfYinNgdpJvn7LluhgESsrbAE5VeA84zcMnsF60WtwzHevpKsZyb0Zqgzbl2C3eHP/D+59WXUV1btfIyCcNCTdmLC6OVixGH0txAHWvmEREUQe4pf/OcQx6MWVX7VGpSNEShaEoadEApzailDt6gyUt6He9wyHjA5qiZvZ5+b/+z0QuFy+Z2yvn7vAlxsbyitF99wPYJB9URcB3VaYKP0KdgR4b6QZbNl0zgsM0jc87RWQuVTYJwBDR2RoME/whSCBarjmJeiOBgCEbmC+pQx9jx+Y0j+2LLKc5PHx2ZsTrdvqYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:06:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:06:56 +0000
Date: Thu, 21 May 2026 12:06:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] dmaengine: dw-edma-pcie: Add capability match data
Message-ID: <ag8tmGfsYbWVi6NC@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-6-den@valinux.co.jp>
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f123a18-abac-4283-ace3-08deb752fae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|11063799006|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1aoU/a/raaWMWlPl+A8N6lL/O9gvNzb0ROqpG1YsgZ2OEOuAYn/0SmGl1gpoeGkFdLVRaHDTX3Yze5NvRC7nBIFcsXt8dy3ZFzh84eiwHaE+Dc+fui9kDggwQk8Gd86JYU0wZ71NWBAeOAWny1zdwvVXvttq+M24upFbkPBSHR7tacOS4V4eK94HEZ/iKCwDhRm0+JQygBzwMvv0fpHvP8YH0b0kjci2yrsdNkIGkYO4+D8uSpGrgJ4D1/c2m/fRCavfQxFDf/J6nefsu8eK9HZ75PHV+m9UgVwgUmQw5NgtvFIfDXN9GkBUYIy0Gmp1vsHmCsk7j4SuQOfWL2f9tcs0KHDEgMDvr+4IrBMEp7HA6D940DgXtfdSIfEJ+nLf1aHGGou36glyipW/5PbJlrsApyckryj8u7xWPGi1Cd0Wi/hpY3ux/F/YQWaAA8En8m0BCA/MYOMPtEZB42OtpCYBnwUucZS8RV5IvB6QZ0E5IB6L7s1p6//6qPTsyKdfJW6a8r5L+Qe6IGkJ0BLdGiJEHTUqMaLbkK4SYAkaToh6iwVAYqJvVQTynwLcsLwDx5qFAYafcaln0xbu6M2xInofyiZspQ8eUvk0y4AJSbI5j9GguHH/jJAVx7fBxsT2yj28AiKnYyJU+6b8GT9xHK/U9Vk+obUUVZA9xQMAs3l1TKHFZUdQtvR4raZPp2R6WHItr2P/2y7/7Amd/M/KmXoj8RY0dJiRghFCfTF5U5x+sBAAhtZie3b1V2JkjZe8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhEy35siypzfwdQs7Gkt17U93NOf/SsHzuK+4MoQ059PA5Dg7t1Ubz2s1Gf2?=
 =?us-ascii?Q?wCJUfTIUZP1pABAU6d4B0XaFPyz7JErGLRON2YFgDAfVYTrALY+8T01sQeDd?=
 =?us-ascii?Q?iUrIpfMK0zxToOAMaHIuFmo3j2Z8au4uM04ldR3+d7HkLofqwPHbup1Q/7Md?=
 =?us-ascii?Q?vAHftqjm0AFJXzfLTQqRCfLSgVIWybZN1Gykm+HyeQ8PVffJLiiavLjRnnJp?=
 =?us-ascii?Q?qSJx1Mqz+BWLnDonqHjRVj16lzXPDtd+e+KIkbBFVVX2ZYa2oJw4n7Moev+W?=
 =?us-ascii?Q?CmjhknM91NvybbL5R3EH/6qIGT5wOG3apzuMPxQOws0ktq1IY2IuoF4SvE1b?=
 =?us-ascii?Q?VXk57cTf2G9ZCoB0DmvtxD8Nihe4hzS4TuD5zimjX2UMf9eMwm9x5lKT3h8K?=
 =?us-ascii?Q?V/l1aQgz9eAWQ3R9g+4gzpqNhofV1X0nheKECCgB0TppMcvoDbs7X5KJ0bqI?=
 =?us-ascii?Q?jUo3D4l00OaVCy+rI5WUA9QzzI0+OItskJzEKdNdO/WSjK6QpIza6PU+SLnb?=
 =?us-ascii?Q?ut9F4IjVo22yg78ZB7AJcZsdkc7AVM09YPu3dA9XsPZ0HtClerJAZYZoJYZK?=
 =?us-ascii?Q?ysRUd0tO2JXidtQJC61epDd9MdRZncxuJOU+47d6xypM50QOe3hmzpzcZwhQ?=
 =?us-ascii?Q?gvGPfkEDrXF53ZpfYtyv1cjMP53eVOeMGtOZmcBbTgoyxy3D3/pwYSiisMSW?=
 =?us-ascii?Q?ocTmpNapOg1psyVXddmP062tiSy+nMLlmj7b4dCE61GveG6ljAZazR/FgJqx?=
 =?us-ascii?Q?S7GhTBFXRC5swLMK/0UhjPE+O/j4ady/WEYIMrYD/4beBSOjye4PopnXGCAy?=
 =?us-ascii?Q?F3uFC1S2lFNHpMBGQOwlVo0m37OIxucbZk3HtulwLybFijbJts1WRDHE5oFy?=
 =?us-ascii?Q?LZfHbitO9RS9IogQ6X/WdZE91PnHbNQUcPr/hRH4wdBk1gXb7VBss086QzyK?=
 =?us-ascii?Q?8RCW/qOe15x5r6F5tTA1rrmqSIPZUhRoqTIm99EebwqCRUKqpA7u1cpjADWl?=
 =?us-ascii?Q?4yhhl9AfG1dzKy3xI/BhDa7vB2Mtqd/SnBJWQQVIEznQ1nuHwlnNiHvFwh1p?=
 =?us-ascii?Q?lg8VbVJU7eVVKdRDv6j5sN0gabb9WUleFV96Pvve0P/seY0TjTf1PTO1XI3N?=
 =?us-ascii?Q?g6kK88ckdgt1qm1xrqynKARjwiaUbGjfB+4F7qHlPZDR+KA2eSv8sV3sJqwH?=
 =?us-ascii?Q?il7PHmJuzyx8D9aUk+3CN5AXVlbA+93+pkbgqFJNmbT1HwQdDhsOBZ7tDq9u?=
 =?us-ascii?Q?gRGB9uR0hvFln5o7ezaYUDw0/C/vmji9J4BcpH4jba4DUqqDDOJQlSrAfayr?=
 =?us-ascii?Q?YjI6mEJPQn4shAn+42wIcKFBqDElKLvzfYmSwq+PCxk45UhMZODhzXApECvB?=
 =?us-ascii?Q?stZ444Lo832mOymovbQAgH4hVi4ohUnxi68s5J6x6K4+rTmjN3xQBKq3p3si?=
 =?us-ascii?Q?6xq4ethj5deY5tBdwmxBUqBCsFiSyd3yE7QGJ96gOP4ph2zepMc7F7857deX?=
 =?us-ascii?Q?XmDbU7WR0nMyr/SRL9VESdHYsei2uoTo/GqYRs+fcw2PF838gzwD/mfSkLEH?=
 =?us-ascii?Q?gPFumYS8yRpWufve0SmLfsmZdoZ0TAzKLLHPrjYC2Kq1D6xb89Uukhjn64mp?=
 =?us-ascii?Q?01tReTQiZcTgOKNeokSuQclvRD4OI7Cwb2fvKhrVjo+Z/2pWzg3jJpMfikq+?=
 =?us-ascii?Q?epsfD2tqXS9FghGAOlbla5Gaag4uUMwWtnjCeC8yhvsz9aSqcMJi1jnybg+o?=
 =?us-ascii?Q?rQ6aShE1gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f123a18-abac-4283-ace3-08deb752fae9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:06:55.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTap9GqqLPHfZwA1WqEPLWXGvk1J5U8dmnCiRY+/skrg8soeKMckm8wv42n+/yVdXPLKc6n1P4C0cBHTtkbW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10693-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Queue-Id: 8BE125A9B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:08PM +0900, Koichiro Den wrote:
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
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 127 +++++++++++++++++++----------
>  1 file changed, 85 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..043a7f73bf79 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -74,6 +74,19 @@ struct dw_edma_pcie_data {
>  	u64				devmem_phys_off;
>  };
>
> +struct dw_edma_pcie_match_data {
> +	const struct dw_edma_pcie_data *data;
> +	/*
> +	 * Mandatory callback. It may leave @pdata unchanged when the static
> +	 * template already describes the device.
> +	 */
> +	int (*parse_caps)(struct pci_dev *pdev,
> +			  struct dw_edma_pcie_data *pdata, bool *non_ll);

Needn't non_ll here. This information should be already save into
dw_edma_chip::cfg_no_ll

> +	unsigned long flags;
> +};
...
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
> +	  (kernel_ulong_t)&xilinx_mdb_match_data },

On going thread
https://lore.kernel.org/linux-i3c/afmEo54iWgk54M3Y@monoceros/

.driver_data = (kernel_ulong_t)&xilinx_mdb_data;

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.51.0
>

