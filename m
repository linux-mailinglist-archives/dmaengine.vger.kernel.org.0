Return-Path: <dmaengine+bounces-9190-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBltCjX8pWnvIgAAu9opvQ
	(envelope-from <dmaengine+bounces-9190-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 22:08:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EE1E1C5B
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A8D3527D12
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F94DB554;
	Mon,  2 Mar 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="niSiZhzD"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9E48096E;
	Mon,  2 Mar 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483477; cv=fail; b=A9oIxycPRiVBfp+TmTAc9PysGCVkCqtZUnftvPO418jaQBJ0j5AZBmnA+ShldXJ6WYd6jICTI5HiEM7n5kP6d40Q4DeKGuyVhxzBbNblu2CN7biajlYrp4nyK5bNhxbR8tGtF6KrlU/ufMX+jibMvKsJlaFohs6ar1MDLDYkWO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483477; c=relaxed/simple;
	bh=9+lKF3n+4kc6YDpJulmx4FIDP/8Fb9CHzks00EBDJzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cCocpSwz08RSbUdSMw+b6WDFaRS8MBCIis+mhWP2pfbolGje0l5NbLRuhGeeUm11vHWeBCuKTY1ueAgdmFC5MlNrozpGrwZRcEPrix4TlJPo2+jXNf5l9a3aR7O9jCmgs1/Wyiw801Q8/InAvFpRXsFd4V7vP4EW6SSkn77HabE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=niSiZhzD; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCCYiwD6QjSMhay90kGcuPzyPX1vhHr9AT81q9PKoWbSGoTCc2x+5sSegkuwBurCKlmaeKaaxrR8m8iXLgHeQv5bV5ZkeyTu5cqkpvPVtMyqhhYXjYxp6ap3z4MliXvwMD7iQAu/nwuUiGKBmXBx/GFPlVGI3K2/6VnaYmB+yJxgdio8/FnfyEHz4T+pPd4JmtFFuTThKeTSxYOToiibd2prf1NDGXHEZFgc10JrXFIanbSA4pi6sXcG4II1HUzwGTYubEUd7mUqEAK1/LEV0tMIdkTiYjW9ZHJQYJtPGd0F+rHI9uhJIdqEZcvYrfl7dHEsq8sDtBTZ/CaJKaEKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH+sq+ysQDgrR7YmfIIsAgLozUY0AHt7djc2aichzx4=;
 b=qwYicrTXEz5aur6UBvvs30iXCK1wzT801OS80Blbci6OIezH+NxjFkt9YEnJmGDwhBrQqrl0CMfCDrY95AHY6qJJADlcfRaKuGH7Py/TpDQF4Una9WU/npwndnzrwfMfwHdykaCKHjfsf6wJmTP07r2Fh286CICFKGsvflLCmxGhp1DY1GKQDwVLz5xno8Mkec4r1MJ2oadEvAF24AKYU5Ud/c9c65LNMbcYIJBMliGj8d0zxrHFAeJO+cjLsrY2e2iK07+TVL6k1xzXsHIPrjbtieP4cBo0r/xNc+Ms0xvK+jNRchybFeE3fJ/e6jEsu6uw5WuWclkIk/Rp1JmfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH+sq+ysQDgrR7YmfIIsAgLozUY0AHt7djc2aichzx4=;
 b=niSiZhzDsCQSiFdnV/BjgiIGArg1oRFiNfoM/viN7pymMpYafSKVNaaTB+UHkDBp5uFUHqUv/BELcLim/RnNo6h6jQGJNmDuJamopoDKXnI/QMR5JiaxYHMOtLkCvKCnZpZBvRTZ5mGo8c7rob8hHuUvJFJP6La8sucj+Qna+BkJ8KOq0IElD62yCuUqy+Xenvsyu5+zensEfOg4qXL+/E/de9aH7GQHrVJullbQfnmI1Y7m+k4J2YC6UUAezoNT5HTlpa7eyEDr5s0TmR3Ijxrspdlz25cfoB8PLp/fAnifiFaKGBqHzVi6byyJPWgoOlHpjFBQ2MDxnLrXJGjggQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7905.eurprd04.prod.outlook.com (2603:10a6:20b:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:31:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:31:13 +0000
Date: Mon, 2 Mar 2026 15:31:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make
 reset optional
Message-ID: <aaXziOMaW6hWCbsx@lizhi-Precision-Tower-5810>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
 <20260302123239.68441-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302123239.68441-3-akhilrajeev@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a262284-9ff6-4fc9-48be-08de789aa57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	5vstJEdxhq43Qvh865spEIkOQ6FyRRavJtwcaHqJGO9dWsm3TiEvaYH8ckrtuK4Ao0V3B4+9X4Gp/5JBcKMp6trH46LWhgzXC/xsYwESX29+RSjWoCum8XVlvJCQNPTh/6s4nfORLJsNErR+RGvfCAOtIJ23nwuVhuI3RnE6AtdKBv2dRLQ/U7wVmhKEHeGcDQ8y1c5rRT+xyHrDHEbTxJhcV6CNhuAvoBI2NLlh8sFh+9bFsGmwiFGxpbNlEQNrbkVIJcG02YDoSjUOeIeVLpU8Y7w8rsbM1IdxZQM1hc87fCrDt6hNtmTUFvuM/kO5ya7HJGYxDHO35wUk8gh+WH70KQRjMpuxveKoShaiA7VwlbRH3q9qYNXokRj8TGzTqT7yFafA00Y+39lT9aarEWKjGQN/LY8u/ptKF2hmFd24nlJh6X6jzMa+p8lyXoUwrKQZpy0g8zenymCS45zxqZzUDYFj/W0xxwGAT3digTF1iBnsbgLuMpcbcSXNfbUzs4AleV/Lb3oTVpdBb//wzWzQcHkJjb8ueIr2INL0eVygqsR7OI/TDSU19CkV3SAMY4/bLXmLxpYbbWqpkUfSIyHXB+uvPx80o+lfKl92Dy2Dq0aL5e9H1DtzWw+0bVTAU+xDi1JAJZF9twwH+kaMCEDO0EMpZuNeZ9biefSzivWzk7w86qaD/7e5qlvIN5ns24JWUY3vsnYSwogOMguVfxqcQWp3/hmSmvYdTkeEsDpXELnXPiWdvOqexMF28wHXaVU7bnJoZ4UBNtDs3V9stZDpDdBzD0wP4+YemcIyrqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+j/F+VDbkOKOItkjmUJyQBw6Pm7E1otInqOyBddTdQAPfSYIWfU7qMqhhP3?=
 =?us-ascii?Q?bnmlupfzrvAt6wTjAqayPvke87vA0fMwALL7OneY3HR5nWBwhq+7TdT6Mxhi?=
 =?us-ascii?Q?k77OtMzPBSHoAG+jEO+xSvyl1Duj7sjfNWAwvM24zL6xtZQUhdZuWtHXUCJ2?=
 =?us-ascii?Q?efaGcBTN+Uja1tIAWMHZEsMIwHGG3Crjuv+eM6usL0Keb8YemSscz1K/yVVf?=
 =?us-ascii?Q?XBIpGbqxGWTmxKWkVqP4B0LiPFLfxubuMnFZ9x/+gZBbMlB+AgzHgT6v3qla?=
 =?us-ascii?Q?joCTCz2etR4xdLCaFk3nkew81bwavG5DI/xgDQd83NoNqKmZixGERRVh0VQP?=
 =?us-ascii?Q?HtdVtzSB19EVZMuCW+62pKToD55crlX0e9oVv4PquPqUNG+Aoi+WApkNz5HE?=
 =?us-ascii?Q?oEdmyTMZOHS9/EjBdPUmIC38GZEFBD/awLSw+DSxs2/9VmK3ld3ohjqWyGdo?=
 =?us-ascii?Q?K2m9mr2UhdRIwLYdlKfBhdpBjjTbeRsrDeyrBVGZXgHeuD89/Ir9abjy2f2L?=
 =?us-ascii?Q?XGgjGvODgTypJFppvZpSI8kjtnqayK/Q1zCAAaR9/ZMbVaAP92CvOOwOLA8O?=
 =?us-ascii?Q?n4BcgdYk9Bh5khKCte0hy71eNXR/1QnD5oTurEerBmYiMgWA2d7ZDyuZBd2c?=
 =?us-ascii?Q?P3axeHmFRUCUI9atWwnOTvc5xoTMSpYo6ONbCAStI2W1sk1q10Ct5eucTPXd?=
 =?us-ascii?Q?nFbXfeUcE/jp6S/zLKX/BZSMDjxroOCRkojXzUVMnNX+tGaMhbVcwVwpHw8t?=
 =?us-ascii?Q?s/yl8pOprk7+z71rZmD6PJcuNW4EHCfv3uU3ymu2O0HmcbzdIVj/+UzEztT6?=
 =?us-ascii?Q?zstGD9hn0om2BebH9S0CqkkVQHPqxYwuuGh7B7goGE1Sl1+ptsO1c8+cpOoT?=
 =?us-ascii?Q?pLbWzizfutpFiHCnk80HzvrUzjIb67pispG2evM7BHijQxCfcT0TqbNa4KDI?=
 =?us-ascii?Q?zkNmLnHxXpPEfsXbKLnIXX2tYyMo6dxtoDMwg6A30lADoFg2TI3efvxgznOv?=
 =?us-ascii?Q?NNC+zr0TapFy5BZ+rJQI5qXOpSUCX1wRw9+5fVfpb+tiTK7pwE7Lgb45AUtE?=
 =?us-ascii?Q?BUbjAVKLMiURZA/Fem33eXcZvgq8txVU9HJct1izpUEEUBxhjpVyASO69f1L?=
 =?us-ascii?Q?SyfOPgIUYFqX5b7ixTAIV9cNPWUxk2u86yWV2vEFiin5Yr/uQnxY9a1mmodo?=
 =?us-ascii?Q?lA/DgP9CzK4NwWh+mTIBg7g9uklpd47AouCQ4jsqV2dW8JyMoA7ApxjE3AjU?=
 =?us-ascii?Q?811xyxiaJbKMAirDUtaS4nMdhFmzw7zlrgcyGkFZOc5G6EdYa7VbLW+znH8E?=
 =?us-ascii?Q?C2iLbz7CyNAsBSuAid35h2vjDU7S5Z1yOym6telv72rtj8P9jQUhH9QjoVYL?=
 =?us-ascii?Q?zSko26AqdQ0YE70Jp4JD33y0iaNiYJT7I+ex+aTNj/CtgcQ8b6ZoKU+7QWzN?=
 =?us-ascii?Q?TOzlwpxVN7Blbopa1IkTOIknKM1yo+ORAr89I0UJ9p3bTp4r2bqZCgEdn2/L?=
 =?us-ascii?Q?d2w0o0npQ8D84YsdULrRYlHRGupkpRo7fKZepYmyLsaJUAdQ11fMUAb3aLD7?=
 =?us-ascii?Q?lPlQOcQecluEo9GE8VVmKIeOzAHhSyb8KovQs3+mulh8Zoy4uxj1dSh+ctn2?=
 =?us-ascii?Q?ZaBTXGiGPzWZZfH6l07qAmjT/u5UC1DyMEiNXPci5kfL4oyYxqG1ZgXbk+LQ?=
 =?us-ascii?Q?iqPa6yPOEH6t56KZEUe5w94msR4W0tx1xtmrqmrMMpe0b+lIavTZIIoKGFza?=
 =?us-ascii?Q?NacygM8sVA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a262284-9ff6-4fc9-48be-08de789aa57a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:31:13.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPmtS1NZG4L31bUYH12C86dtcKJwZz5ktw0FhMysIvY+r4H4yxHPnK8U3kEDjRac9/piC+M4uX0CtjqTpjLLEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7905
X-Rspamd-Queue-Id: 7E8EE1E1C5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9190-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:02:32PM +0530, Akhil R wrote:
> In Tegra264, GPCDMA reset control is not exposed to Linux and is handled
> by the boot firmware.
>
> Although reset was not exposed in Tegra234 as well, the firmware supported
> a dummy reset which just returns success on reset without doing an actual
> reset. This is also not supported in Tegra264 BPMP. Therefore mark 'reset'
> and 'reset-names' properties as required only for devices prior to
> Tegra264.
>
> This also necessitates that the Tegra264 compatible to be standalone and
> cannot have the fallback compatible of Tegra186. Since there is no
> functional impact, we keep reset as required for Tegra234 to avoid
> breaking the ABI.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index 1e7b5ddd4658..34c9b41aecfc 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -16,16 +16,13 @@ maintainers:
>    - Rajesh Gumasta <rgumasta@nvidia.com>
>    - Akhil R <akhilrajeev@nvidia.com>
>
> -allOf:
> -  - $ref: dma-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> +      - const: nvidia,tegra264-gpcdma
>        - const: nvidia,tegra186-gpcdma

use enum

         - enum:
             - nvidia,tegra186-gpcdma
             - nvidia,tegra264-gpcdma

>        - items:
>            - enum:
> -              - nvidia,tegra264-gpcdma
>                - nvidia,tegra234-gpcdma
>                - nvidia,tegra194-gpcdma
>            - const: nvidia,tegra186-gpcdma
> @@ -65,12 +62,25 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - resets
> -  - reset-names
>    - "#dma-cells"
>    - iommus
>    - dma-channel-mask
>
> +allOf:
> +  - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra186-gpcdma
> +              - nvidia,tegra194-gpcdma
> +              - nvidia,tegra234-gpcdma

nvidia,tegra234-gpcdma must have fallback nvidia,tegra186-gpcdma, so
needn't nvidia,tegra234-gpcdma here.

Frank

> +    then:
> +      required:
> +        - resets
> +        - reset-names
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.50.1
>

