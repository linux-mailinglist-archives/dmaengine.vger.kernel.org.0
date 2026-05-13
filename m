Return-Path: <dmaengine+bounces-10423-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFxPHK+QBGoVLgIAu9opvQ
	(envelope-from <dmaengine+bounces-10423-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:54:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23295535883
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48DFF3004903
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7635F5F3;
	Wed, 13 May 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFvWiCrm"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7030675C;
	Wed, 13 May 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683997; cv=fail; b=XCq21mC5mmdrn3AcczaVbn8UtgFhQwUMmkNngvMbK7GSPVkZLYP/981eCAi4PEZYpA43v5ToJRf1VWkMkZfaAk4cwrtz77m5hP5nQwxkCf57yoozVqVkY1WZW0KxbxQsm8WbA9QiiOlDds5IyiFLoEum8q2u/7AaLcfkMOHPISs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683997; c=relaxed/simple;
	bh=qTYRBqQs4MB6VjS16YPR4vTIYKtzg0BRJ4TzfzaJQZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dcNQsYGhejubTJa3TC2prM6n4wRQm7Cfewe8RvI7RLQtyTjL/GbEG/99t38WtlLT9rBpUtGyYsGlEWz5yQHYi5JCERFlZJt8mzVWIYS6O00ptthtEBcwmfZPeb3c9Y5ALcGLMH8BCFOvj5TPU7QPFntJSfocraTyhuqwfHh50Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IFvWiCrm; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwrg8ZFzcs6NLbMCwZCPEiRjZDigdabxzE7IkDVZpl7zcWhhdXD0yaCzdD5OK4PJYrm1OF7IWaBF44xsNSs9jxERlLVlrUOkdn9U8kPnSw882JY7kf9cDmAqKGep1hjU81JTgwAdlqv02xUxIN7gZ87he+r5yEA0QyrdGj6h1zpNNHa7mdzCRbgRbPnNuw1J6BqZ6vJgjUIPmLVVdqJoQ1Re6E8t0f9hq1PT9s0nxP/Me7BesebKJ8a83cRnXv4vGQ9X9C7qpbBgkwA76wuMQuJV8pTdTuDccv9B9RdxQ+CXyVrFgUc+WLtYIGieQyFttZy/3HvZNOrfWQE5jbLANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2oeirSPKnbyTasByJNjNZuxFOKvXvr5spYWCyewjVg=;
 b=WRaXeyaEQJfXEaQjXv3evLV2nJuBuzGq/e568C5zGUG+2xg2PAjRnNdBZdMp1MEPSSCQyAOFhI3NC0OtLMoPCKLYovIl6as5PUKZPsS4/0ZZsdJUeENkGLIBpOOyW/wdULHoVzj+zqMNhzel5pHYW2hHvfJFgiseqkwd2w57tjTBM8DlfFJ01G5tZ19UBCT3jILE3LZmV7mmjPUqqo7ZZK1XAyqhVzbHpVmQMHkZpDcTjf6DgBoRf9VBc3s0PM2PPsQyf4m2WzttJ2U6j8OImL459xgf5dbUs3m6mfaJsQqjLWAnIC9AhvelNQtbBnrHHm8jWkuPfuDJRAdvffUc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2oeirSPKnbyTasByJNjNZuxFOKvXvr5spYWCyewjVg=;
 b=IFvWiCrmJsThBhzuXVL9/AfePr6tQiwC8BD/r3FjQ8i51UENh9W3Wpoty9v6Y5aced3JcvZH5CsBhCLIwMlH5cQpFmiSzZ+z8pQCiHXdPB3rFhGxpIjj+SC7nXFE0CfPnQJHcmG6iHcWMoUMmxf1j25bKQvMrXitvz+cJotPWNNCEjD+koBb8a7PWTNDEA37ZT9fCMRKik83dQH8Rw8d9U6h6ClamfpoyxKRboKr1tPCsw9anUDymuH7banBQM7HtDeUaghzOkcgX2NKaVblItRr1Hq4WCiYXwQwqKlxw6vNpAhFJokGdADVMk+lbTfc6G1pvwFr0l86Jfcj1w9JZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10558.eurprd04.prod.outlook.com (2603:10a6:150:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:53:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:53:12 +0000
Date: Wed, 13 May 2026 10:53:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dmaengine: fsl-edma: use
 devm_clk_get_optional_enabled() for DMA engine clock
Message-ID: <agSQUugI25nFT0Wt@lizhi-Precision-Tower-5810>
References: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
 <20260513-b4-b4-edma-runtime-opt-v5-2-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-2-1e595bfb8423@nxp.com>
X-ClientProxiedBy: SN7PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:806:120::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10558:EE_
X-MS-Office365-Filtering-Correlation-Id: e10037b4-aca6-42c9-817c-08deb0ff5aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	0C5KKCsrtCocoTbH8qrG2sMQZEG4x7RerU/kdU/0EfZc2qVsW0DrNZKCGpwxKj5Ltve/HzfSd0qxbtnpgpLyBsJgzynq9mxz+25lJWRclIdcZSNt5OWYZs+LdkxckkYKliGe1aU8zYAMx7oslIO3tbcNFY4OlvHhkNjmmy1RhiXweVX4CcseiS+9LMzr2KjxEQvYq1Uthvobn4ULmWTwYBrVeZgI4b1LOsZo3azRh7ZbO/H8ogqWAVvCUnOWwd/HosUm/pkdnx3Qv8NG/wJjqVhZDFbyJqXKTSsG4bndqH5W4fRCq9EhOe4YXovnbX10fSjwY6U4cuQZGXV+nHN/Nmj/2cNqQYHO/XhWLZ05oiMLKfydeNbovOUG3cLhR0G+EG4LzZRzqiQiJVUmR9AcwmF/EctZeo+k/iHi9/vr0YSNzzVWQkpzVfY89qN+lq8STU8jBeAAEzZw0THpIX64uoWArHeE9TA6y+SD3a3+l+EvM3MfQWhX5SUo43ziWioxwrdGQqAPerQV4Z43LKO5Iitq2ktr89JUSohLavSZGMomm+1t0F7b4QUjBnc7dfz1ZjEVO2/LA9yUMDa8ZHFPRZnTV622Gm+cv3ZhttYyxYC2kVlTpe5xfT4RYBlfSQKP4dQ3BNaLx0aDDcHSBDVXrEYf6bhFyDNZv3fqcf5wu953b00QYgp6dEx+ki/Gwo4ybkwHFI3uL+DF1IjdhvjpfQSihW1sDbGU/qWFeM/Y/d8qDb0vpl4MVhlrbBZPibh4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DX1B4yEqddN8ow1cyXAsEEcqKd1HpdX7/ulPJeUB8tK7gPeezuuQriZ2nM3?=
 =?us-ascii?Q?3qv4xH5QgM2pZGpH6d+erCnn2gch0C0HL5+fwGJziGT6gB3zyyB+lze4aNgf?=
 =?us-ascii?Q?nZOJdHkajeH6KBk1VUsEP+7MTcO+xlrTM7BoxoufvVaw8lCu3eCgEbvPXqwK?=
 =?us-ascii?Q?CEqqxORY+N3SbZQJf5lcFX6xAUbRGVyNpjItm0DQgPusv45ULhpbo5gAe6PT?=
 =?us-ascii?Q?2JgwYsVrd+S1R0BKslRmHGO1TA9UNdyamigQBtL7zhVji0E78+lM2Z8cd29S?=
 =?us-ascii?Q?BlVmxvuw1Poo19oOYHsLVuAkZ4g5Sb/mmmfjVVbEf6/V/pPKc49RU8B3G+Lo?=
 =?us-ascii?Q?1flyH3LsGtblOLs5mPQ3PyOkZdCaaBTVrr8/jR+WwbmsI0QX8labJFU2z8G0?=
 =?us-ascii?Q?In1uuZGYZqC8OyCjK+RbeZRN63PqkJrHd6u/Nqh1TzlaUfway0xuDQFx9HGF?=
 =?us-ascii?Q?1FBhliUsLkgGyH+uGpe/dQbtTQpb5YtILVmb1tk34PAsqCRyr4D9Lvemgi08?=
 =?us-ascii?Q?J7J5epM862j+GeMeBUuaddVwQ3Om3hBxDnaXJpdUI1fhwMdsgFzpJxwgKBqi?=
 =?us-ascii?Q?5bNdM05n57urQ1JqXu3p3hInD04DBhQoHCUdGoy/6T0dHe+ZZ1uOSSN3Yk1I?=
 =?us-ascii?Q?EUCgD+FLbyr2JsvuhdGHI66AIoqMQWw625rB9uxCxPUUkrNWVRIkUav70IAY?=
 =?us-ascii?Q?jSpeuMO959yxc8UOGBP4zmn5ESdFs5Np9wpYXv5bTVFUHPpehtL+locQuNXD?=
 =?us-ascii?Q?oqXRlWz0x3tH0tCSAxqiUUJ8/MylJImc4p/3McsHk6czkk3p5dJ95sakqXHl?=
 =?us-ascii?Q?ze5hcPkoKxqWH/LnsEKFEp1q0QK1gPk4vJEnhX/XBKH51ckEuAsb3owF4C0g?=
 =?us-ascii?Q?oMZgAGd8gU2yigi7ah6rPOExdnTmzL72D6bJ8IVppiPjICtvMqIj+ycXMuYJ?=
 =?us-ascii?Q?gGb71FpRWqDJWDE8S7DaBLaV8sAuOXzKsxP6EHRNbNvgieFK2CCzF68Nad0s?=
 =?us-ascii?Q?uw3sB0pSPdtZDvMDuawzvHoqM8gMtHoQt/easmugH81luhFxcd7SPyEVju9A?=
 =?us-ascii?Q?UNkWan2HsLaMpWK4O1kY6o/ghsvaztHlqg7ESI5BtNv4lbVB+8b9X9yS7XuH?=
 =?us-ascii?Q?PmSfIpfPZL3NENgNMHWDcIVOKzHuWiGqmZNukgsyqoi95ZNX6WbB7DOx62DN?=
 =?us-ascii?Q?8OR7MsBZ29BegoDq/QTYnZYD26ij7lymdd5NY+xYRIhmsa8FGPFz8hpsb1TW?=
 =?us-ascii?Q?VcAnwYCR5o1MPsBR4+6dWBorA/ETwkEz2AeLIPm5X6aFcdozQ05ywnsnh0OR?=
 =?us-ascii?Q?DWTPfij/0ZXjufSvI4P6wm/gY7erUQEZ3sKJMhWrOCz6ALjKPpKE2FYnORva?=
 =?us-ascii?Q?8n+DRsmWX7hWOo0J1hNCflk/qAFEGx543gHKmwTcTa2A+gRSm/+ua9ffGlCM?=
 =?us-ascii?Q?yY5KMu/YhaOCSjKdxYyyBjUVD49RmFnfAHTK1+dYMtXNXw7ZVnmLnC0Ns+Tz?=
 =?us-ascii?Q?9LXlNEYedLuDM5/AZmV+QWNxFS24XC5hxhxuOWvm4kXzVHnopUbwCunfdqZp?=
 =?us-ascii?Q?3gQW428qUdOiWnurtjlmt/M4k/9VaI+cgCkaEJol11g4pd4jxlUHPHN4FPFM?=
 =?us-ascii?Q?t+a7aPfPB1l9AGxHACq5THwCDyMiKVRxszibdD3Sg47vWcoSM3Ki9qlZx4CY?=
 =?us-ascii?Q?d7a7/mD4t42hu31UhGoGTN+Lv5EbVLjsxLKcWqyXN9d0pV8s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10037b4-aca6-42c9-817c-08deb0ff5aa0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:53:11.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UghjJMlR9T7Pvp82PDq8X1FJ5pdayA+Lb3MQKlA9OjkyewpUIIvS++CCb7iFiJN1NsVM6sxDMY15Ig9bzLSJ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10558
X-Rspamd-Queue-Id: 23295535883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10423-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:23:48PM +0800, Joy Zou wrote:
> The eDMA engine clock is optional and not present on all platforms.
> Replace devm_clk_get_enabled() with devm_clk_get_optional_enabled()
> and remove FSL_EDMA_DRV_HAS_DMACLK flag to simplify clock handling.
>
> Prepare to add channel runtime pm support.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.h |  1 -
>  drivers/dma/fsl-edma-main.c   | 22 ++++++++++------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index f4354b586746d64faf375cc9ce04e15a7b6d86ab..54128b3f45cb399e1c11d9f86d64adce5c65c102 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -204,7 +204,6 @@ struct fsl_edma_desc {
>  	struct fsl_edma_sw_tcd		tcd[];
>  };
>
> -#define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
>  #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
>  #define FSL_EDMA_DRV_CONFIG32		BIT(2)
>  #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 87f575d6ccafff455d47f8c794a503abf97e2af1..ecd14967bfbc07d373a74790e87f9aa36b60e6c9 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -554,7 +554,7 @@ static struct fsl_edma_drvdata imx7ulp_data = {
>  	.dmamuxs = 1,
>  	.chreg_off = EDMA_TCD,
>  	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
> -	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
> +	.flags = FSL_EDMA_DRV_CONFIG32,
>  	.setup_irq = fsl_edma2_irq_init,
>  };
>
> @@ -567,7 +567,7 @@ static struct fsl_edma_drvdata imx8qm_data = {
>  };
>
>  static struct fsl_edma_drvdata imx8ulp_data = {
> -	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
> +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA3,
>  	.chreg_space_sz = 0x10000,
>  	.chreg_off = 0x10000,
>  	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
> @@ -576,14 +576,14 @@ static struct fsl_edma_drvdata imx8ulp_data = {
>  };
>
>  static struct fsl_edma_drvdata imx93_data3 = {
> -	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
> +	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
>  	.chreg_space_sz = 0x10000,
>  	.chreg_off = 0x10000,
>  	.setup_irq = fsl_edma3_irq_init,
>  };
>
>  static struct fsl_edma_drvdata imx93_data4 = {
> -	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4
> +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA4
>  		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
>  	.chreg_space_sz = 0x8000,
>  	.chreg_off = 0x10000,
> @@ -593,7 +593,7 @@ static struct fsl_edma_drvdata imx93_data4 = {
>  };
>
>  static struct fsl_edma_drvdata imx95_data5 = {
> -	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
> +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA4 |
>  		 FSL_EDMA_DRV_TCD64 | FSL_EDMA_DRV_ERRIRQ_SHARE,
>  	.chreg_space_sz = 0x8000,
>  	.chreg_off = 0x10000,
> @@ -733,13 +733,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		regs = &fsl_edma->regs;
>  	}
>
> -	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
> -		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
> -		if (IS_ERR(fsl_edma->dmaclk))
> -			return dev_err_probe(&pdev->dev,
> -					     PTR_ERR(fsl_edma->dmaclk),
> -					     "Missing DMA block clock.\n");
> -	}
> +	fsl_edma->dmaclk = devm_clk_get_optional_enabled(&pdev->dev, "dma");
> +	if (IS_ERR(fsl_edma->dmaclk))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(fsl_edma->dmaclk),
> +				     "Failed to get/enable DMA clock.\n");
>
>  	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
>
>
> --
> 2.37.1
>

