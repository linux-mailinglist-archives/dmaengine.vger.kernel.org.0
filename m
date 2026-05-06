Return-Path: <dmaengine+bounces-10240-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CExsAxmQ+2m/cgMAu9opvQ
	(envelope-from <dmaengine+bounces-10240-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:01:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386B4DF940
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5208730156CA
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B670809;
	Wed,  6 May 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cIiZHTYP"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925F1EA84;
	Wed,  6 May 2026 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094100; cv=fail; b=KsdrgjbFRCBU5nqX96GEQ9bSQiT6kXLJzgF5am+CG+tmO+6DFNIuYgS2+pW3ugBwF4RgwsLNiQLLmpuA4mQTICWrMsSLQBZi1mpUlgjBcuV0x6fR9egSZkTppVqxEOXa6Hb2ueSXFSCMXn+G7knQAZZEs+K5KM+OH3QAHCoqHho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094100; c=relaxed/simple;
	bh=vyBowa4Ph9NeDlXe+Y/edGXyRPIXq6NZBT27/SjxKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCePAmNP9fR/Wk4wM1Aj/ZQD5nAaSk9/MafMBtb+4iSWXyLqL4Rj+uw6EN59P0hJD2LyWv3GLd083Ruqcg9Z0gDTvUDvS63HhoRmCLp0YGWsPz1HEEusNtK/mwrzDCzLHevXxQNijR5ppJDY9s5ClWG5PX/A4iamXUnngKdasRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cIiZHTYP; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqSKmPnzkqhJ3ct781M3SIvH1rQ8Wpewdet00Tz9UXGOh9xJ2sdjcNIFPH9n8Bx9viBrKo5kgbLtlcNyDMvDHK+VJudE2R++OH2ord1fcPm96lCYOylaLuotxFW+MxHL6FW4p6G7OT5PAfBHri7qaInzL4WsQ6XVm4SDkfw0VDBrP8XNUBggrUtUz/YKRX7E27PG+kcBCacu49+PzkQnSxNkzy1/P1bKFGyV1a0DsmPNsNdx4ktcxaxqShq3flBi+gJKDsnp+PhsBGCKPAw4pVfRwvrIOpDw9tVOWyqpFoaw9zsYGfbHOApyQbRtTrni34hBhCxFNDX/I7ohH2Vutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1pOBI0ZjotIA/WiQL9zRgZKeT5kWqMuxd20UXqTfBk=;
 b=O7Gj+978C/HzhNssoYJ/l0FLxDKkUlQP0HLKBW+ebaQzR+w1u66AZv+ovveLiUX2PjuClcmOqRM6xZ5OICDMDzzZzW0XqcyHwrdXMT77Op4VVoI7Rg5UNTvyxbdW4llF/9ZBplpTafMVmPlvwR2pD9W9kN4YW0VFslw72atyulx87jWIwHIB3AnjndugitJO1wNYymMtr5UnSarfOUdlKoeS+bxNZFrWmHj5viRMxBmZTKBn8InLFncgWujmDxTVWTR5dXmjjSPBu+Z3nD7F4MeTLgSjZqLsQFT6LP7REVxb2JGXmMCk5ey7xyDJxCv7KyUI1MwGFFgvDe/UOccllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1pOBI0ZjotIA/WiQL9zRgZKeT5kWqMuxd20UXqTfBk=;
 b=cIiZHTYPwbl267ISfmlLRbX1zwaIf9ZYD/b5r/n0tTn9j3swmT7LIp+LzEg2dU17awXZUtL0LVGj9UkzT8VWfc4f340SSHQYEznpVdlPntQalNkyGMtJXJbL5nWwTZqtanxlJC2YZGiCV6pLHn/Mwd9RmBV1t5Cr//LL4PSDhmrYxioRae5DF1/NSam3GM3Mh50XJZhrQCuGnnjTRNCyB0f0t7TopDG4DOqauYfUP6tHv0XlwNsyZyWo4iF1r3wyeG4veGmz/Tppa+sbod6pn0PKFgWPU9402VGJF45SdeRguCL0HjoPaN+rw8O13Lb91b2G4Ch8ttHpZ79QvDNSxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DU7PR04MB11235.eurprd04.prod.outlook.com (2603:10a6:10:5b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 19:01:32 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:01:32 +0000
Date: Wed, 6 May 2026 15:01:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Move MODULE_DEVICE_TABLE next to the table
 itself
Message-ID: <afuQBciGxFTOUgUO@lizhi-Precision-Tower-5810>
References: <20260505102932.190219-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505102932.190219-2-krzysztof.kozlowski@oss.qualcomm.com>
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DU7PR04MB11235:EE_
X-MS-Office365-Filtering-Correlation-Id: cc53b415-ef19-4e55-6004-08deaba1e2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	j1x/HNj4MSLEG6nEskR7f/4p50IS+XXpWGVR95VlelPidOCcVhk4ZR4cOfdqUc6Yz+0HunmoopbSXRFj5Kd+cBdRWm0OGvGA2umf3UFeAeMe1ND4idfb4vkguZe697iN+v/Om1OSvNJHh4DV0sCQEYYZka0vkw4+O2ntdU0BBZcxvYTBcc3nn+lHSs5uXryUbos79ZajbiQX3sSPlEEhz7i0CbdWhkPQQ4xLm6vVU6DoWvxMj0u8XG+r4Oozc+cRWrYr/BPfzkXdOtSB2PS5XDZMoozIF9w9p6MUD/CV7V0hTGV5k/uOhQjrdBxLSHK2B3PEe/8mayuV1CYc1RBDlLJlO2CkSpFZD4aC2chIIbDj/N6PH8yWLd1Ogqeu+5t/YqsI3AeO8mgqPAKqtXGjF1cLiCPpV7jkTRfIjqIbiwx8rdYDZMsseY1fMM8Xwx9+j6iUIsYnYmxZOhocnCWevf/I0fp6Qp3HN93+9E6qnckEvREwzqURA7P39WywvTB8gKoRrCDxATN+iLk9Kv3T+azRMpdi8Pvao/4k51irZBcL9zjwYKxGU+Lcr8iEVRlWMjF1JzfH4chsULgOAyqfhnqASjOc+ZK1Bg/CmLGPDO52MB4tG+zKeAqUVcIIF5R9LJ7HAGDYWRe1cn7QcvatnNeb6PJ2VtHGd4mqDDHPQXxksd+qTxz0M+6cD2vXaaYE+XIcK+SjP9kDxkXnyowEHOlKDwRFPxE6La+tNTp3Vw8bnh6foO5/v1z4Jsx5vb5n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GWjsLF2LmLLveNB9vCZSGMPX24LOh09pe1X9WlupFrm8Hr01XMGUjDsGDpn?=
 =?us-ascii?Q?L/YWbvKqHueo1rpxeT0/2qr/jUd/2VH5Fx495DhEJhcJzTreEotqTf5KJkVn?=
 =?us-ascii?Q?U6c8XFzrpG/HREhtgY15xKBrnLapovgCkptiobsKxN5bB4u43d1mC+XpSkYE?=
 =?us-ascii?Q?LkOdYGBGmKQ1Jf6hksMBDEIdQYmPbHzZFlHsQuzilESWHmCeDCLEpOYH6uk6?=
 =?us-ascii?Q?W1QCpaYDcWsDNBmmPfjFt26nA7QLFwg41tYPVVkabFAs6BZkhMBDQOtyQRbe?=
 =?us-ascii?Q?v8WpQQDo7S+CU9EFpptEatygSBuKFnytntMqTgh4Pnkr4pp/uEnNhujPXEl+?=
 =?us-ascii?Q?aEXogaAz2iQ6ZfEC/cfJhLBLHcMhsWqKoTZOkcbw2HW4Yx1/xFIK6LrrWW+t?=
 =?us-ascii?Q?1HiB51F0FTjP7wsdApFWfEvFPlbcFn2dkI7yUuTbTR8HcgH7gCIhjoCfY+u0?=
 =?us-ascii?Q?M/5URNkbEH2L1K9mZVlnXrZMN3v5pI7cQ28kMA8f3+ooofKNpXxjYRDNWSMW?=
 =?us-ascii?Q?5kyrmT8BPgKp1oMHkPDfqXL3RXAY6+gvnLxAHSGm+TZWptCZ3pKrcJsMXtka?=
 =?us-ascii?Q?tIZFyqtNljpL/8fUHLUIrAu5ifbHZ9fFw+xR1aICRILEa5V1O7vCviRngjTA?=
 =?us-ascii?Q?Lep/GBLn4or+7COIi9aoc6qNzpMvPh0T0ZZru+V6EO2VZZ7Ljifgj5fMzanp?=
 =?us-ascii?Q?6K9Rzhmfe/JGI65hZiexhTkMxTFf3MG8fWpiT3n89ocHCwn7G5D45q062mSD?=
 =?us-ascii?Q?g+vUGJud+aCP+oio7zziKOY3a2FBkSxQsL0hEK6fpjQM97XQ8XmIsA8bV+MA?=
 =?us-ascii?Q?UffRwkFhpbGm3FrA2cKNfMnQKbW+adIYAuTh9kBB3wY2McAlfRDt2BuvAFlP?=
 =?us-ascii?Q?NjhmPYk1s+44gR7CCK7Z8fTl8HQao3A557nvGYPNc4xMGW+0CEHDjK3TSjgT?=
 =?us-ascii?Q?VRNuMD05YIZ/nbUS9N+qjxsWg1U5nc1afGJa3WOW4+DqfG2pNo7wJHogpPHA?=
 =?us-ascii?Q?bMzd9UGyNy+0TNhjfv0RB7RWpJYHiiV6Z32HfEv7en2cXHQeSvhY4Ys/ayPy?=
 =?us-ascii?Q?tosrg7ltEa+cBVqBbzONebPaD6xqEr5avuhUpRlKjqsc7lewWPl1mtTwwYJN?=
 =?us-ascii?Q?ydG73UTvrKrBn+pvw0cfwROtLRQg3dqsz17vsbDI794IzV9Gsox0wMmQ8k6Q?=
 =?us-ascii?Q?gtOTCU1CPOR1aCrhlapIGPUDkiBSCGY8LpoyoVgYf+z6RyfA0vC107jmpitV?=
 =?us-ascii?Q?eoxLKUHr3qJUIGfq0GSL1qdNRZ6o1Qsst29j1NIIM4eEYwNR6PztIkrfrB+/?=
 =?us-ascii?Q?RQkwECNcNt/bbGJ4gMioJ3VNDrSVwsMhNC8P0hlYeDiHonbuHsts5TKv5WDa?=
 =?us-ascii?Q?vn/rL48797dnres39awWTDkBj3+n8RsaKHdA6II/uQYo0qEyRbA3zV7bGOwF?=
 =?us-ascii?Q?iwxIYh8cBas1iBlPJriBLn/5MyjZgC+1Fv2DuRgJYiRIyi5ob7Hcc9/xoNNV?=
 =?us-ascii?Q?KbxMD7zo8TTOpPccDGnx+QdVSRFH/QWfU3oHDwgeA8XtrYnksL6hgBaHYaIQ?=
 =?us-ascii?Q?He5qXRjCqCfq2rDq7pLRCBUvwsKTGZJHORLNcUxw3QMyR+6wDS/ePXKwmkSe?=
 =?us-ascii?Q?ZkK3xethcyOz1VMwNvD2/Xk9/CX0NtMLMHyeSdL2oI8Sr3aJCL2ysyH/vEay?=
 =?us-ascii?Q?ONZmHrPMxDbIxQw0adLByci8pBY6fSPeR/GFTc7OfG+lqNjd1UWS/mMp52FG?=
 =?us-ascii?Q?VCCEbb6sGg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc53b415-ef19-4e55-6004-08deaba1e2e9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 19:01:31.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dsWxexPCcLooTLJShs9kbLiz3b2WzKhsKULNQzaGAzYIJrm89w2ziU4VyUVEN8mNiDDxHTpHGwKRyUth4/fPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11235
X-Rspamd-Queue-Id: 6386B4DF940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10240-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hisilicon.com:email,qualcomm.com:email]

On Tue, May 05, 2026 at 12:29:33PM +0200, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
>
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/hisi_dma.c | 2 +-
>  drivers/dma/pch_dma.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 32a0e95c6a20..28bf818f9aa6 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -1037,6 +1037,7 @@ static const struct pci_device_id hisi_dma_pci_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa122) },
>  	{ 0, }
>  };
> +MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
>
>  static struct pci_driver hisi_dma_pci_driver = {
>  	.name		= "hisi_dma",
> @@ -1050,4 +1051,3 @@ MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
>  MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
>  MODULE_DESCRIPTION("HiSilicon Kunpeng DMA controller driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
> diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> index e9fbfd5a3d51..bf805f1024f6 100644
> --- a/drivers/dma/pch_dma.c
> +++ b/drivers/dma/pch_dma.c
> @@ -970,6 +970,7 @@ static const struct pci_device_id pch_dma_id_table[] = {
>  	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
>  	{ 0, },
>  };
> +MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
>
>  static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
>
> @@ -987,4 +988,3 @@ MODULE_DESCRIPTION("Intel EG20T PCH / LAPIS Semicon ML7213/ML7223/ML7831 IOH "
>  		   "DMA controller driver");
>  MODULE_AUTHOR("Yong Wang <yong.y.wang@intel.com>");
>  MODULE_LICENSE("GPL v2");
> -MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
> --
> 2.51.0
>

