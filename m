Return-Path: <dmaengine+bounces-8289-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF27D25C92
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0CA5300AFCF
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F173BC4CB;
	Thu, 15 Jan 2026 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OWz2h9vS"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0322C11CA;
	Thu, 15 Jan 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495062; cv=fail; b=PduZtLPWFVh8tbaQdKjObMzM9iVOVf58+j8YB4huL6pRKHHAf10ZAOtEtDmGWyKycz4ypCW28yItfI4up+x7X3T9K7CzUjSdgpDc1ZADTPKVlr6+9tdG++dMOmY1qmRhRFMSMySSXWFhzfX/1+A1V/G4WioJpCTnptQS3f0/LAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495062; c=relaxed/simple;
	bh=f/h01hgE2P0ZLHM44a9UeQmrxTjF5m8NbZVkvEzBrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQUV4mgAxFYW6NxrKgnAKOKTOgMyTTede2K/G0JYFGOZB2f4F6lIHE3c41NgcTofHqHafwdPO512ReVwefgdWP+VL/g+cfEhAsDU3hhM4NWyGQyjynKdzeFf9SkUL9URYYqxhXLZWbvsvZ/Bg4lA6UiaFl0F1Q+XRnpzGVBKZko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OWz2h9vS; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiulbaYrgmRiYccmodJzPxbrjGV+Rsu4lXzoI0EqIVhT6c8yrK5VrJtHXAYgzOng4IFC8/uJvGh3vwmrAnmsJp61P3PDvUJpejAm0xAS3uCFTWLx9orI1qK/Hlorf8UE+CM97eQzZSDzGbQ7wNH63WwHZh359IbZIRaPEDfk5HuePEfQ4eYW5MBPWsxFDtfz0b5DdicS157gnLvBsMh8tZNdaefRxqtIZaPx+Bvw+tvktmmKKY3uPpVzH/4jFKR3HM6y6vEa0vU35FIOYtBqH/sekPSJjY6XHqW/YCLtC3XFLIifoW5df3yafVisRyRDVxGJR6BVnFj4ooHBLAsM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lLT2DF1d0jRI8uuZRrn+IPls1+M5hhDt1qoYH7oiR8=;
 b=gCWlVUYElZEP2ewOv1WzQJKusC/0otNcOcQUBn7leusYL8RJGjsTYG45m8hQME6z0O6igslwAtEbwjHX/oRyLTp/Z1dkgdD7biCSZuq8fKWgqfpqDkyqSbI9B3L5nvJo84FitloLzLEokg1HIdYDDCEASNI2A5Pm3CyT+Otqgsyst98UuHELwPgapWbFoe8lhqXe9wUVv5zMQNwdmVgzgp3TUzdFph7sZh1lvGg2ztPWXM8qFthDuSTptGvg4ErDR1HoRi4hkoaQj9BaAcQ4ck7UHYwo2yrlOWoBBYL9qMgzBKUsTn9DbZdLVEYav6iHQaigU7+AeFmnXTJfVfEenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lLT2DF1d0jRI8uuZRrn+IPls1+M5hhDt1qoYH7oiR8=;
 b=OWz2h9vSawf+O0wRYH8WY1/EC7SLx6ADBsvZ3T2vYGFuSq3ZC8cm+HdtR6FqSDP3uM+vd48FJJPAWRwymVGpqvKHgmoSDQsQIttR95GIkH8Elc8ep6p+KbIcw5j4+WibQ2VwDUqg7PzSFf/G2QbpyB59Edbg94Z98AmJbq+KDs+wreDGeSdKWJlzYyATyRFSMtEB8RCq4VrNC+2iGz5lVKnBqMx9hQ3tDm/YHxCZDe2vNlee4ev/XHRR4+KHVNaqHYKw0zEHyNQ+U/3TCe9bYERQV/ttfCvdxQIyREdY16CReinb9shwP87DD2KPEuwj9iOGMw2ZAObzw11fj3yHsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by AM0PR04MB11931.eurprd04.prod.outlook.com (2603:10a6:20b:6fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 16:37:37 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:37:36 +0000
Date: Thu, 15 Jan 2026 11:37:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109120354.306048-3-devendra.verma@amd.com>
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|AM0PR04MB11931:EE_
X-MS-Office365-Filtering-Correlation-Id: 2affa7bb-fc49-4b41-95a2-08de5454638c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoXC0Pi9i3OvDmtmloCBr1LrmJqv8JtNGXc46Y+fsseYVX9DPFEs7FaFbvY0?=
 =?us-ascii?Q?EbGhhi+ZNo5Kb6n7bWtRDsngQQc9H744VQl2BW9YpPiqiuUmaSsyRi9gv5ne?=
 =?us-ascii?Q?2NQY1gN/4Y3gwAw+Y5yGOU54BTeUdRy3lgXuPPAnz97mpu/W9I1Pz8dOXdN1?=
 =?us-ascii?Q?bme4FQW7wShWv2wEJqU26itq7AXDlS6etLGQmu5WDllgQrqhxhbpIivZlHk3?=
 =?us-ascii?Q?FKacxiYvoNL3kVWnZqPhG+I8eTukzW+7uMU1BQ1gUEicyiLq5HVhsSpzdi6U?=
 =?us-ascii?Q?OWzhokTvJaZTkvjCx4BaVtVM+vOMpqRGlCdUu7GvpqkqP/RoxEKdMNC21cBs?=
 =?us-ascii?Q?ANO8XFq1mswRz0toQYYQ5bEbb70XFyMIAi2RxEdUZWR1VARW0hH761I16P0O?=
 =?us-ascii?Q?Z4DC556ktCsjswKOToH+PTZpa80LEXzwVEHcavQ42OM9AavKeIXgbBNGM0dB?=
 =?us-ascii?Q?5/nzEbXTifFE9cglLi9q2CTCBnsodL12lla0HIY3a8W4W/UNuK2oNkaWb7Z4?=
 =?us-ascii?Q?QQSmY4bVxNi9uBhhD2eh3UIsOzRESBe5fYS0K4Ry6kxP9Gr8h5DfBgYBbRNz?=
 =?us-ascii?Q?Fl7jNOOCQIsMtsD8H46xnpi0H+G5RzcCRemkmvxBJHQWzlTUvYiWBWwkG8Tr?=
 =?us-ascii?Q?8Mdp2BMhK7PogTh+gD2eMs9HtuUg390jBib/ToYZdJOZAY0yWW6uI5Xo16B/?=
 =?us-ascii?Q?f4iU2GvlLcmkIjyMxaoV08qxYHqSHglTXxqH4VMFGqtiKsPvwZzd9mOymq12?=
 =?us-ascii?Q?ZU4F3R/+vOqEYrxRL68piTEPB8rrKc1Nk+KqjONoF6e3yDf5XwWmpCvrL3P/?=
 =?us-ascii?Q?iTZrScUGcOrmU2D2hvLSTfWN3hucJ1ksEAVYxvR0IrsLBnahFXUtYaxk8bqR?=
 =?us-ascii?Q?v+663qLT0hjBAI9EPozbZhjhooFgh9TH58S9+xFnMYNdmyuFO4RK3oenORDB?=
 =?us-ascii?Q?XjIEfm2uSBhMqme0RREq4BjUowpCHngl3+rIwKvqT8itlMZA6eSlvt3jfUqe?=
 =?us-ascii?Q?4CvFgT5JJsJHGfHRgEyvzAkbYOZfV7KYIYWSo75li8KJXrkmK9UICR9WQ2Lh?=
 =?us-ascii?Q?VFEMULhJR9A2H7ylgA/K66aROaAvPFhcQq6TZWjtHHEC7FbxyffXV0AKigwy?=
 =?us-ascii?Q?XfPc0UB6RyjRExcmsMop1CWumfftmhuulzPd6gq10eHXfjHU+9iAB9F9KMu0?=
 =?us-ascii?Q?xUgDpqiRuSNpFlHZZAsn0NjET+JiEaN+j1v/K1kgvzFIM42WN+QPETi0jHb7?=
 =?us-ascii?Q?8kSHTEuCZnmY50jK3iB1RNjQVXPOegR7djyZbC8lmxllThUHaXwwr7ZC/sF0?=
 =?us-ascii?Q?fPbxPs/NmY/5UVF/PwmzdyVUpYWk6jKLberY9D758NlmtO6eWMlsvDO95zrk?=
 =?us-ascii?Q?UG7RwItEM9p1StNfMYGJZvsg6pjWHidVgWYCq9bT9n6ZoMWe78FQN3yljDD8?=
 =?us-ascii?Q?3jg1cBSXHxBQHeUQGDamfMwrlwWWmJsYKC2l5eiWgtiNASI22OC8/q51Qdja?=
 =?us-ascii?Q?hoT/JocGM/o0UxFU+vV0ts1E+Y7ZX2HBgOVzdWDjlZ+wT0O4bAExWNfIjeR8?=
 =?us-ascii?Q?wIjp7m8wEMiOyb7H1KNc5blUIyrogwdYYIgbT4CJBnR4qFYu0LErddQipAVs?=
 =?us-ascii?Q?XTxtzaJetDKuA57nCZdxqHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JuWuDeeh8bOyaN4b/pCfTwM7cqX0kCDNiO6VnXeTEHqlRqB0egw/F9ih63y?=
 =?us-ascii?Q?1AdW/E1MuSMb9/yA2KIn6FX4ZFGRylzRy9kYm7ois6en5FKAFyM5b9lHbPtY?=
 =?us-ascii?Q?oqIdLTK8rLvBpT700rVb7V9Cym9eN7CftnWONTY0YYKoHZ0+bsGzx+PMxchf?=
 =?us-ascii?Q?jRuQMCpsEyJBy2PH8igCrR1Db026eQcQUwrsemajslm/YmBe88MKO2drRstd?=
 =?us-ascii?Q?i/El8usO8t/7kL1h524PCZIBx1DJBZ7AS4pGwek4Gvvl3VAlHVpm9Ok/Mj4/?=
 =?us-ascii?Q?Rkczz+JUEAetgOSoWsYmASysf7dJlUhnN+76wY2nbCXXFgnFH3/vNK+ae7aC?=
 =?us-ascii?Q?zOPTMOxrJ80JyYAvRnNyy/hT1BmEZ1LtIN43DYlMFz0NL2Hsb/P0ciw7Fq4a?=
 =?us-ascii?Q?CaTyfW5AsTDXm+szUjrhaJVo/nLY3mTTOmY+L5Te8BFE9INwyyeKqmII+KD5?=
 =?us-ascii?Q?IqFV9P0+ZguuNSSwqGPQcHQ4utIcaoO+CgedwTYwGCD5mQ04/W1o45yP+5NE?=
 =?us-ascii?Q?7h306PmK2NcetR5XEWUh3w94Ctvo1SRtaCZ2gZhFPBKkZTtoaap9iCjkSm9N?=
 =?us-ascii?Q?+hcBN2MDJKlsVpXniDBe1/Db94RBlJGPpoYoZUcTA3ZzpjrWHkyAOY27ZTsq?=
 =?us-ascii?Q?o34rRT4KYQ83kjz0I0r/V5NW+2DCLgz8dTRha6G9g+ed74ww5xf7JM8Pi61W?=
 =?us-ascii?Q?MFSPKBxhS4fDgB+xO75hjkER2gpbpe5pyJ3tKKnSaFc5NkRrkoQpl/NNQeTu?=
 =?us-ascii?Q?RDy6PNyZIrjyZ4pyeKGSwiBkwdFPO4q2BpBqRLi0/DaVwLG4gfWzNDQWCGvg?=
 =?us-ascii?Q?utuWRJlvKaC6+Or5OEGYXTiRbBRsOf+o2rXr7aA6QePRKMaMR5SwIea/9VGz?=
 =?us-ascii?Q?a1I+mdtTkx6Xel7WpVw/L2oTcnIVFQw5nPHngTwd81sgnh8r5fxt/AkpNWW8?=
 =?us-ascii?Q?WXsH1qr4c7bkYsW0Axc7qBz/EuuvZ6vGlSJKkq19RgFNP5gPpcjMEax+I/Fw?=
 =?us-ascii?Q?IZaThtwQI4iK4dJQVPiFVPoz1qdbU2WqevNdcBPZrqNOS2LLlNrCIw50JWAc?=
 =?us-ascii?Q?owCodoCSdU1okg0sOpQWvZ1RUSCmOegDRJxO+rvGRj23puQwO3oobnRxz4nY?=
 =?us-ascii?Q?KUXXXaz2Xy2t2SaHqFSlVUVIlaymf5iGNoM8qbDExrhxiRL457uRKbJyytnx?=
 =?us-ascii?Q?4SSBE52n27WhyO89g08ByvGvsPXo9idEmlmZ/m9/N7iWMIKDaR4rxM2X/VGl?=
 =?us-ascii?Q?Um6LJTcjh0/xEfbGuVxi/o4U7PXRPhnlMO9Q2wWWduM8Ral3fb32KrTZ/OMv?=
 =?us-ascii?Q?97Z3qgtnq1zcI+DEFfVtVat+7a20qftE1gT/YcnraSTcST5C6F5Fi3P890Ln?=
 =?us-ascii?Q?/jGzCv6WtJPX5qY2qqSi+989nsoK+ZEcswqIrVd4AD94o/BjxsxJSwLeM4XQ?=
 =?us-ascii?Q?Oxkhc1G4zzFj3+SIvzxyp2AdftYtf/GRTmBV5r5D1rWByHOSRrH94aQpK8GZ?=
 =?us-ascii?Q?E/gA/GFF5r0P781luN6sdZsCy7Byz89h58JaY82udLmAQA+OiCoPumswJg9b?=
 =?us-ascii?Q?lHpfNR+N0y9ARw76lkiqnAh9hqh2JKjavIVaf8OHiRsRWfAH9FGyDzdVColp?=
 =?us-ascii?Q?XFGAKUUGvbfP9Wwpy106ZG/EtYhGg+2Z+0JHt/n64ve+qGo1//rl2+fPtdK7?=
 =?us-ascii?Q?VfYM+QeFN4NbEQwaRWlrR0ZcwJUTMfkOmnh6QqJAD6H25WN/y61w83Sh2lFf?=
 =?us-ascii?Q?Znf3/G55yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2affa7bb-fc49-4b41-95a2-08de5454638c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:37:35.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTc1XFGhPfsGFZm+AmVwEQrGydiHgGkj3ZW8SS90awX3tEjEu4myTzzfDVAEP6OAj5ZQQOpg8O7EokwfkwVS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11931

On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - For the AMD (Xilinx) only, when a valid physical base address of
>   the device side DDR is not configured, then the IP can still be
>   used in non-LL mode. For all the channels DMA transactions will

If DDR have not configured, where DATA send to in device side by non-LL
mode.

>   be using the non-LL mode only. This, the default non-LL mode,
>   is not applicable for Synopsys IP with the current code addition.
>
> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>   and if user wants to use non-LL mode then user can do so via
>   configuring the peripheral_config param of dma_slave_config.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v8
>   Cosmetic change related to comment and code.
>
> Changes in v7
>   No change
>
> Changes in v6
>   Gave definition to bits used for channel configuration.
>   Removed the comment related to doorbell.
>
> Changes in v5
>   Variable name 'nollp' changed to 'non_ll'.
>   In the dw_edma_device_config() WARN_ON replaced with dev_err().
>   Comments follow the 80-column guideline.
>
> Changes in v4
>   No change
>
> Changes in v3
>   No change
>
> Changes in v2
>   Reverted the function return type to u64 for
>   dw_edma_get_phys_addr().
>
> Changes in v1
>   Changed the function return type for dw_edma_get_phys_addr().
>   Corrected the typo raised in review.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 42 +++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 46 ++++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61 ++++++++++++++++++++++++++++++++++-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +

edma-v0-core.c have not update, if don't support, at least need return
failure at dw_edma_device_config() when backend is eDMA.

>  include/linux/dma/edma.h              |  1 +
>  6 files changed, 132 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b43255f..d37112b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int non_ll = 0;
> +
> +	if (config->peripheral_config &&
> +	    config->peripheral_size != sizeof(int)) {
> +		dev_err(dchan->device->dev,
> +			"config param peripheral size mismatch\n");
> +		return -EINVAL;
> +	}
>
>  	memcpy(&chan->config, config, sizeof(*config));
> +
> +	/*
> +	 * When there is no valid LLP base address available then the default
> +	 * DMA ops will use the non-LL mode.
> +	 *
> +	 * Cases where LL mode is enabled and client wants to use the non-LL
> +	 * mode then also client can do so via providing the peripheral_config
> +	 * param.
> +	 */
> +	if (config->peripheral_config)
> +		non_ll = *(int *)config->peripheral_config;
> +
> +	chan->non_ll = false;
> +	if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> +		chan->non_ll = true;
> +
>  	chan->configured = true;
>
>  	return 0;
> @@ -353,7 +377,7 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
>  	enum dma_transfer_direction dir = xfer->direction;
>  	struct scatterlist *sg = NULL;
> -	struct dw_edma_chunk *chunk;
> +	struct dw_edma_chunk *chunk = NULL;
>  	struct dw_edma_burst *burst;
>  	struct dw_edma_desc *desc;
>  	u64 src_addr, dst_addr;
> @@ -419,9 +443,11 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  	if (unlikely(!desc))
>  		goto err_alloc;
>
> -	chunk = dw_edma_alloc_chunk(desc);
> -	if (unlikely(!chunk))
> -		goto err_alloc;
> +	if (!chan->non_ll) {
> +		chunk = dw_edma_alloc_chunk(desc);
> +		if (unlikely(!chunk))
> +			goto err_alloc;
> +	}

non_ll is the same as ll_max = 1. (or 2, there are link back entry).

If you set ll_max = 1, needn't change this code.

>
>  	if (xfer->type == EDMA_XFER_INTERLEAVED) {
>  		src_addr = xfer->xfer.il->src_start;
> @@ -450,7 +476,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
>
> -		if (chunk->bursts_alloc == chan->ll_max) {
> +		/*
> +		 * For non-LL mode, only a single burst can be handled
> +		 * in a single chunk unlike LL mode where multiple bursts
> +		 * can be configured in a single chunk.
> +		 */
> +		if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
> +		    chan->non_ll) {
>  			chunk = dw_edma_alloc_chunk(desc);
>  			if (unlikely(!chunk))
>  				goto err_alloc;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9..c8e3d19 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -86,6 +86,7 @@ struct dw_edma_chan {
>  	u8				configured;
>
>  	struct dma_slave_config		config;
> +	bool				non_ll;
>  };
>
>  struct dw_edma_irq {
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2efd149..277ca50 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -298,6 +298,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->devmem_phys_off = off;
>  }
>
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata,
> +				 enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->devmem_phys_off;
> +	return pci_bus_address(pdev, bar);
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -307,6 +316,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
> +	bool non_ll = false;
>
>  	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
>  	if (!vsec_data)
> @@ -331,21 +341,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
>  		/*
>  		 * There is no valid address found for the LL memory
> -		 * space on the device side.
> +		 * space on the device side. In the absence of LL base
> +		 * address use the non-LL mode or simple mode supported by
> +		 * the HDMA IP.
>  		 */
> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> -			return -ENOMEM;
> +		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
> +			non_ll = true;
>
>  		/*
>  		 * Configure the channel LL and data blocks if number of
>  		 * channels enabled in VSEC capability are more than the
>  		 * channels configured in xilinx_mdb_data.
>  		 */
> -		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> -					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> -					       DW_PCIE_XILINX_MDB_LL_SIZE,
> -					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> -					       DW_PCIE_XILINX_MDB_DT_SIZE);
> +		if (!non_ll)
> +			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +						       DW_PCIE_XILINX_LL_OFF_GAP,
> +						       DW_PCIE_XILINX_LL_SIZE,
> +						       DW_PCIE_XILINX_DT_OFF_GAP,
> +						       DW_PCIE_XILINX_DT_SIZE);
>  	}
>
>  	/* Mapping PCI BAR regions */
> @@ -393,6 +406,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->mf = vsec_data->mf;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
> +	chip->non_ll = non_ll;
>
>  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> @@ -401,7 +415,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>
> -	for (i = 0; i < chip->ll_wr_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> @@ -412,7 +426,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);

This change need do prepare patch, which only change pci_bus_address() to
dw_edma_get_phys_addr().

>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -421,12 +436,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
>
> -	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> @@ -437,7 +453,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -446,7 +463,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4..a5d12bc 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
>  		readl(chunk->ll_region.vaddr.io);
>  }
>
> -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
>
> +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma *dw = chan->dw;
> +	struct dw_edma_burst *child;
> +	u32 val;
> +
> +	list_for_each_entry(child, &chunk->burst->list, list) {

why need iterated list, it doesn't support ll. Need wait for irq to start
next one.

Frank

> +		SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
> +
> +		/* Source address */
> +		SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> +			  lower_32_bits(child->sar));
> +		SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> +			  upper_32_bits(child->sar));
> +
> +		/* Destination address */
> +		SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> +			  lower_32_bits(child->dar));
> +		SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> +			  upper_32_bits(child->dar));
> +
> +		/* Transfer size */
> +		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
> +
> +		/* Interrupt setup */
> +		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> +				HDMA_V0_STOP_INT_MASK |
> +				HDMA_V0_ABORT_INT_MASK |
> +				HDMA_V0_LOCAL_STOP_INT_EN |
> +				HDMA_V0_LOCAL_ABORT_INT_EN;
> +
> +		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> +			val |= HDMA_V0_REMOTE_STOP_INT_EN |
> +			       HDMA_V0_REMOTE_ABORT_INT_EN;
> +		}
> +
> +		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> +
> +		/* Channel control setup */
> +		val = GET_CH_32(dw, chan->dir, chan->id, control1);
> +		val &= ~HDMA_V0_LINKLIST_EN;
> +		SET_CH_32(dw, chan->dir, chan->id, control1, val);
> +
> +		SET_CH_32(dw, chan->dir, chan->id, doorbell,
> +			  HDMA_V0_DOORBELL_START);
> +	}
> +}
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +
> +	if (chan->non_ll)
> +		dw_hdma_v0_core_non_ll_start(chunk);
> +	else
> +		dw_hdma_v0_core_ll_start(chunk, first);
> +}
> +
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index eab5fd7..7759ba9 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>
>  #define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_CH_EN				BIT(0)
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747..78ce31b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -99,6 +99,7 @@ struct dw_edma_chip {
>  	enum dw_edma_map_format	mf;
>
>  	struct dw_edma		*dw;
> +	bool			non_ll;
>  };
>
>  /* Export to the platform drivers */
> --
> 1.8.3.1
>

