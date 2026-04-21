Return-Path: <dmaengine+bounces-10071-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E9wOv3i5mmr1gEAu9opvQ
	(envelope-from <dmaengine+bounces-10071-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 04:37:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A26435897
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E0623004D35
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E02279336;
	Tue, 21 Apr 2026 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="al4HFSjt"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885231A683D;
	Tue, 21 Apr 2026 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739062; cv=fail; b=Dz7bLWpDrgAp6qNdWPagb0tLlQtDQDKsk+iCHMPVn1CXGXSEpdvgmW0yvs/ZGvBV2pjLERO6Tib/xGxEtmrmiaa0rhtDWDa99FeEogMW23uZD6gHkTf8xgeJGaOkjAuXPa3ZrqYO5Gj4O9dIc8j6QH+PmG+o3tV8CjvtsWogLns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739062; c=relaxed/simple;
	bh=3HBSQv4dAeCeUNqtektO+jtIPV5n666Q5sjsTayw30Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4wCByqcXmkdP4Qk1mGkoR2JvwHla6KrRDa4CXhYyaIlxnGTJMAqj35c3RrDSzJlvkeB47TIn0RfiZDaEmnX2vP97C88IWzf5LMVAaLGV9yKuGmtJq+lTJjgD3BnA+hpbzByk+qJRidDlzTqmpwsCnLJM4Nw5Yp+kicN5CMXVsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=al4HFSjt; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tobJDayG3CTxnTOU+Eub5bpYIU5HSlbauijit23Q849DtuuI0EWdRZ91uM2QrCtqLWoNbqiCtQPPjq2DwIQyAwibsJugbTIoit00FlPZdqtchLbbVAD/P3tb2Lbne0ykLhSKsv1ynh6RPJbCpt6X0J40eYOTQhgU1kItY9u1oSljoiAGXOrgaYy5dV7Rm5X76FuDRR2VGuD3LTMuTmhaPIr4BuSwU4L/jx7pCLRi+IKiLuzp46UyfgltjHBTTSCwg+r2iPmDQdeWtlC+1lsl822VwYyVxivg8/VvFg8s3M0yA9xgCugDj1zFR8OtSg9VaLWVzA/087JoWMZefNIIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T94o6yvizssNqyzMVomKgnvKUCLFVEGKhpjCYTMASJI=;
 b=tPR6H3w2KhgIOEt8CrFpz+byFbzqTyOGlpbDBdARcEnI5qUMdgZdxePb+xtj4Mk30M2pQAeNGmKIrwBxItcVoW63y5PMmw6uAeR7N4l/iRTlA2kVzERGK52MIV7l1+7e+kuRvy4rCDgjie2Y7yVgFV0rDhc81/NXT3W/qzdZpB+hUunCDU5+Npq20cmAtFHcQnrNSh5+hWgIc+yUV7Yaj0cWrkfp6tKw+uJ6FVx57IWz+zY3xPiMOi33XZM8v++Y8Xx2BPQTn3nwB1RIEUubj/XfXCmHxAJ2fHVif0DlsqhB1qQAstyRjdQBIP3D742yAiNKaXPf/c6XRLFBLxOghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T94o6yvizssNqyzMVomKgnvKUCLFVEGKhpjCYTMASJI=;
 b=al4HFSjt6hq3TrU3LBqGl2CdDxDJVc5oz5htRBt7ThfPjsoVN5J38UOEzH12j2tc3PbNWzKl1OmEO1rTcHIGrtjSCR/JX9S4N1JwwrG9+QOvAQebF4ziAuJ82EdU+6qKTi0R/IiubXpN9c/ev7AggK+9loOg9uZZgqaO1yYWh5l9zY4kjN4cyb1LaZqWP5OfjBE/BRM5qPf2anDcqvqX2SYv9oXVT6WHIXFINo2yu61CBCKMBarF9HEFC5cdvNepZ2CPDTc2YtqKKCs2IZHw6WOheAUrTeOueVHfrfSMZ7hcYnq++UkiNxJcBKrZUz2ArZGYFLMcMvhg5ZRip7H3PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9497.eurprd04.prod.outlook.com (2603:10a6:10:373::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 02:37:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 02:37:36 +0000
Date: Mon, 20 Apr 2026 22:37:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] dmaengine: imx-sdma: Fix SPBA bus detection on
 multi-SPBA platforms
Message-ID: <aebi6W2215meIQsI@lizhi-Precision-Tower-5810>
References: <20260420100854.2095549-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420100854.2095549-1-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SA0PR11CA0197.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::22) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d4c334-a059-493e-5595-08de9f4ef2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+04c2x5nIgOLQ9fWXxLqxzHk64Am0IiFZuEtDG7tRZlcD300UIHfhZpIQyrv2JldFClpZ4uN0v6ZU/nTh0bm1NA/DIX7ykEysqXho2vjXWB41KBYFtcRzwLeotHkuK4ZSPCqbXxq/utSpVr9bafCXJAyVaw5Ua+I80fBojUt/hlRjE4Kp3Jqy3PMVSPFI3BqNoPmhv2O7B52WuBA5op+NHvZXc9AkBdKv3fLeGcgx9oTnqEo4IixdcLOvws+vtI0q5Z5Vw5ZR8AsJRuoEC1oLjZGxm1uGn/8yn9NTAtt8TCsuiHNTl1twKjftg/cbsUixRPjXn/DSRZJ7ne5DhNGkxUJEmaZldE7uSoSq58oYZCMUF2otcDTcE8Y3stD4I65BGCQw2BZXxjDhrdg3pSWqVyKq4Tx5b6mT/w+L/lLGOW5zicyZeycIyxEMlwqZIHr/YRI6gjcxOaLMYAyiyYGNR6A3KyutCcOmq8NaYOx+v3th7rJslI2XwwTwdFv1umvfxEYFUiimEQwTpxs7AMeJ17IKG22dJ420tjxo50+mN4GOil6cGhuidLwWsUjfUa7uzxkxQeHiICGFFCT+gfHJasI/S+DCD+gyj3YDKgt5qvbXcZSnhrEEq+rzvZuZuMVcOXFQrjR9H9aI56vDXvso19ntBsnGpuLiW19lDQi/v7jg6jFbgKGyQl9a8yKG41klIEbuP3IxpaKUNQTt9qqWrOZ+bj3vXWjuKMlnQ4Q+ExuwC2rJTYeN5g2pOHlIdANwlXgyqtowSBYPY7mr0CyLfxWpSFbZsGYLJ9FUbMQ2KY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZUX2CVeUjLvdVGuT0vAYMBSlePMuok48sG7NhNaKFbpQkh+KQrvOV7gTLxX?=
 =?us-ascii?Q?d70IskGQsNzofE0F06p4i6bPcm6YkLj3tg2inSw8NMOrisn1HBj3IyboNXS/?=
 =?us-ascii?Q?t7cnRirn5Q78NGO9L+fLBd5r+Koq21Eoz9JKCDwcS9bGGtN86G7oOSouZacN?=
 =?us-ascii?Q?cbfvDEY5GKmNudivAJ1rJWhO4I6QUJ+jKkFpqw32CB2VE1Q3iiFfHe2aWSwx?=
 =?us-ascii?Q?0syNl/KdCT1IfazvVrOcK0n/JBBq7WkzVK8O8cxj/e4AEKVc4NvHmCwvDW5Y?=
 =?us-ascii?Q?4y1q5zhSdJcMHxLlQqlupxu6NxIwlg82aGmcGN+V30VGfuLueyYUBuzOjIUE?=
 =?us-ascii?Q?NhsR5dkCRQVZbcijjbUIMNm/D4ak0w+fw/dSIUAemjoIxBf4u9GxS75muaCb?=
 =?us-ascii?Q?/jFM686G00g03DLjf3nHiCrgu/RTlhA+0HZQ4Az9Z2MktTr+9xbRzn/p5fK3?=
 =?us-ascii?Q?GWGpcgB5jqGR+UT/e5KNbWuNAzau0UPHNvNKgqGGTeC3XsBYZ0BCamnGYpVU?=
 =?us-ascii?Q?ReUfbwFr5EyVTjMif8yPOYY+zj+iDSS1CtqaZZ//5X1HUiR1gTCxdCV6Baj2?=
 =?us-ascii?Q?mw5qU5TMX9yphrSL3xkJOHhEYoNH5Ln+PHnSgQJbxL/gM2cw2QPiaUNvdf4M?=
 =?us-ascii?Q?ck0u5bNEmfuto9SWzQqoFaHtqY8DlWr8mhOLAxmAWKFfgq5noZ3JJn3sC6qd?=
 =?us-ascii?Q?vgZVAeB4v1CPsh/WGREKxSu6/Nz2oeGU5LJVr3y0hMuZFNzgCNYXLDKUYuKM?=
 =?us-ascii?Q?HPUSMHiuCCZ81nwiGaACGBc6TV6O0Bw+55kpFo/nzbAEfQvAar5KItKGW8z4?=
 =?us-ascii?Q?OMn4nR+UxkzgKVund0/PVvD2Cumg9ZHK9Uy5R3oHlXj4WR4ZSIGi+Z+GxeMU?=
 =?us-ascii?Q?bv0dm3rzrvFWVwlYytkNCZJkgoi5l+bjEDOTsNrJrPbFi0TjaI0ZdlEjKPcp?=
 =?us-ascii?Q?yN+/gN8Cveoh/xQP6+sN9FfN+CnQO3u8OPDa5XRaSVXy850mTHOPKNNvJVUN?=
 =?us-ascii?Q?8XINkQ33EaH1xv0dDrutMVYRHHii6WAjcDy8J4koX51pGTyjLaZsyGsXZGWt?=
 =?us-ascii?Q?oQ3nDlr/ZWszIVZhRRC0fiGo9TVzVIYLV1DYaDirRz+Q0I4HFP9dHxxUEIC/?=
 =?us-ascii?Q?iRmqMyOocaBpaQE6T/Q2QAg2LtUnRdsj58oZs6joLgVaeQI6FtvWqWR6TDap?=
 =?us-ascii?Q?6jXRTRcUjmdC80BSuY6cfMCTRpFrCjCs8h7kVsVZgJSy7oqHKkjhYv5sqshV?=
 =?us-ascii?Q?qxOQBRwOjQj/J7JuLUDB25mbi5RhDVNtJ7DPiXYrIAep12BkRFXZRVOWJt64?=
 =?us-ascii?Q?LDONQXwhw29Q9EYP0rG3RaSQpRlODq0ogYjSi2uLU+ZfNUExp1iEsnsRaDOS?=
 =?us-ascii?Q?/oelXr9JbAmOjf1HuLEAvJk0eyhxN6DoIoPHdhhkFgwXivKcXzeEPFDTFKrp?=
 =?us-ascii?Q?CVPajryf9E2lq/GlV8FLRYf7z7vYKhHlxSGcQiFPfhydy5+q6hjbAbA7fEt6?=
 =?us-ascii?Q?63RYJXKQSCkp6s4JlUM1IH11uWIliJa110b+dcDuoWG5mFec6KGsr+VIrs+0?=
 =?us-ascii?Q?3zCYia/Za2vb+WwAblASkuhA8t9G0nUCpbrrMBONAHBKTcPBnGzsHC0FT327?=
 =?us-ascii?Q?pnph6aWITdpo+noUHti1ls7V/HFHbLvdV8rbPYL08c2C1S6FwM9bBorFyXQ2?=
 =?us-ascii?Q?NRyLzzztmzbR63bQ7XP4lsWMx7LY9vstORdCE41vGPtaBS6yprpjZrXvt9s3?=
 =?us-ascii?Q?oiECu0lxgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d4c334-a059-493e-5595-08de9f4ef2c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 02:37:36.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w34rFRjTLgXb85XyIGUptAPUOEzkGy6WeKo3P/f59NuwrjFcj/LaHo8s6Y7pL+g3gWypHZ8egBMYwgZi09iX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9497
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-10071-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6A26435897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 06:08:54PM +0800, Shengjiu Wang wrote:
> i.MX8M platforms have multiple SPBA buses under different AIPS buses.
> The current code searches the entire device tree and returns the first
> SPBA bus found, which may not be under the same AIPS bus as the SDMA
> controller.
>
> This breaks SDMA P2P transfers because the SDMA script needs to know
> if peripherals are on SPBA or AIPS to configure watermark levels
> correctly. Using the wrong SPBA bus causes DMA timeouts and transfer
> failures.
>
> Fix by searching for the SPBA bus under the SDMA's parent node (AIPS)
> first, then falling back to a global search for backward compatibility.
>
> Example device tree showing the issue:
>   aips1 {
>     spba1 { sai@...; };      /* Correct SPBA for sdma1 */
>     sdma1@...;
>   };
>   aips2 {
>     spba2 { uart@...; };     /* Wrong SPBA - found first by old code */
>   };
>
> Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> changs in v3:
> - add fallback to a global search for backward compatibility, which is
>   to address comments from sashiko.dev
> - update commit subject and commit message
> - add comments in code.
> - add Cc stable tag
> - Don't add Frank's RB on v2 as there are several other changes.
>
> changes in v2:
> - add fixes tag
> - use __free(device_node) for auto release.
>
>  drivers/dma/imx-sdma.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3d527883776b..592705af2319 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2364,7 +2364,18 @@ static int sdma_probe(struct platform_device *pdev)
>  			return dev_err_probe(&pdev->dev, ret,
>  					     "failed to register controller\n");
>
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> +		/*
> +		 * On i.MX8M platforms with multiple SPBA buses, we need to find
> +		 * the SPBA bus that's under the same AIPS bus as this SDMA controller.
> +		 * First check the SDMA's parent (AIPS bus) for a child SPBA bus.
> +		 * If not found, fall back to searching the entire device tree for
> +		 * backward compatibility with older platforms.
> +		 */
> +		struct device_node *sdma_parent_np __free(device_node) = of_get_parent(np);
> +
> +		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
> +		if (!spba_bus)
> +			spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
>  		ret = of_address_to_resource(spba_bus, 0, &spba_res);
>  		if (!ret) {
>  			sdma->spba_start_addr = spba_res.start;
> --
> 2.34.1
>

