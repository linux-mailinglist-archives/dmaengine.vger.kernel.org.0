Return-Path: <dmaengine+bounces-9101-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEj3OPpUn2nXaAQAu9opvQ
	(envelope-from <dmaengine+bounces-9101-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:00:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B419D01B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5888E300D470
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722502BD00C;
	Wed, 25 Feb 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QooNQ8k6"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50624503F;
	Wed, 25 Feb 2026 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049655; cv=fail; b=pHWenRLZMUqgqYqs7CTBMlnpktmRZLAqGpzYCBt3IJMrvroI3W5g2sJ7LJJMJK6mgt9BKr5WS00M2bRClwYqRRO1TCM0CxPWA2Tw6zgsGOJ3a/tlfKdjPnI1zl1xOgeFULOfYY7CSkS31HnDVn4tUOxvz+zsE9m/pHxeqCi7OA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049655; c=relaxed/simple;
	bh=gPB67Fa34LlURK1eO8rhfmZR+d0mWkCs7aAm1X98TaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGjdAViHKAE1uIlRkXSv0rEPSAHEM+W5Exb1qdt7tGpTOOqvhq6dlykt8F0oYIYziiC/AcB7TzX3onoH3mAAgViAA8eP38+t0mb+T3VQaMKKjgwT1w/ymWkgkHPEqdtMlBTeMgCZzeUz2zBfXRku1zBdMk6Qo+J3wpCazjaWDus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QooNQ8k6; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY15or6izmDLHv/tLTlp2rvuXS8BXco6vCxee3iOhWm2LEePVYYk5Q9V9jNeiso+UW0cSc9FUmb52V1cQL2iKKWUVtHjz+sXv4f6aSNp3Id6i2T7MzzvfycUgf2m9ANZUM3gySUbg2RtjX4F+ak7Q2wQKmBkyGCmyV4JA9E+GwKKFEQs1QyLvlqLCnwRYY02PWi4bd2kaQekPeIRwqSUPMlVHZy5sImRRKn1vv3qbdOBiScChPMQt+bOZzalAq+gQSWZJ3eT5B0qrPU+7bkcuDVpdC3LcRRWbMe1jKWZJhZ3eOk2y5NQ7jpt/Nt1OcE2FhouDsPlGFE89plsPOikmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mor4RWGi4OKk5eJWckl4ZdtT7D/0KKELyjwzYkpLAv4=;
 b=AvYci5rB59pcFsJ/LjgxbKlijPffNbfIWBWiHDbXIJT+7OTHR4gN4GrrYqeinFBAFXkl/Vzh0vuE5SPZfen22HHyi+W28Vf8tnk213cKmYnImzaBLCofN146tv0LGw1OmA2l8nzcQWfaxrc5ol4c0RITSHMnfw+tm7YmpDZQ5w6at9Qxqrsg4RwUbN8J3jwzH1rTI17RNFt+zAJfT39Jcudg4MdvvQXt7uIPe2HdiaG4YblxkZgPdAQK4BPJj0D4vABu8EwlKAqgjVuXQKHFL5fhRpRkkqNsdvlEMs/l2jLc9DaItJePEf2l103Z4S4L8MDffnmxkMGmPKznbWv2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mor4RWGi4OKk5eJWckl4ZdtT7D/0KKELyjwzYkpLAv4=;
 b=QooNQ8k6m2XQk4xdIoTEkHtZ8GpMu6rVbnvy4KoSFmGjUJiNWhwqi5hCT9EaZoxI8VeINfPX/M1UothkciKl6t6d8S7QsVWAlYqvh3u8XAqkUCwIB6EYmBAUGzMM9NrN3MS1r95fftgrP9VA/wfVjJP7jtMTYTNc3CG2HGkM2lT1hdnE+ZSuWXkGC/JiO7sRfF0Cj5zqA6WqR2R4uc+qaKW83mwHbxWWK/q+5XImZDqN5X4Cw5H36k6NMwGpISyDcCIf9T2n2KV/KKnKcAXycMaEBzFpMr5MVSjrxI8VBlNoqdEShhD2WaP49hTq0hlUhsUjU0PeIMvYpxhClwdUCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7752.eurprd04.prod.outlook.com (2603:10a6:20b:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 20:00:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:00:49 +0000
Date: Wed, 25 Feb 2026 15:00:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
Message-ID: <aZ9U6OWaCtQD1zw5@lizhi-Precision-Tower-5810>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
 <408551399f089d10e2ebc2c0add5ba58d659a1b9.1771989596.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408551399f089d10e2ebc2c0add5ba58d659a1b9.1771989596.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: PH7P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfb670a-661b-4ed1-665b-08de74a89247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	+9knHsqGZQ2yjNxlkCJykiiXRQPl+1OIPvBrqftoJu2zjDLWEZL2k6nb7OMiAYSA7c53dsbW19gZg4W72biLd1mExxsRpx3L82grmrAvjB4tGbegQy1aVMEd8LqQgllCn8vfPfhMcka+yUBEFlxWkyA5WfV899Id0Rk/c7NYhmC91tX560uRGrQzU22opXpGGrEgJjce64n6lQGddfSMzce4cM7YkwZ2AbFYD3ZMm6AI0mZ3L8DaAJ/TSjHlWdYe0+YHnTOololY5HkeQTS6NM012xMt6xQWkbOm7oDvJXbvVEZ7HWpYMG/G0t7i58/uTmUJmoKnsbrdis/nM1Qjdnt6WlqZqpJcKRnFvqAxg/SqhtAeI9Hyynfa3PZ/sXfnVFN11iF4ApZNu5ql8FpNbvTYs6vb6fwhf0gRp9Hl/lHmBONvzMmlyvfVgMp/ywKprvH0bkKIYPk5JEnel96Ti2xlU7Hc2FAXX0e/2qrwelvXUWdS6x1GuWVbYFeJ3uJVXcXR8AT7XlwT7Nc0J3OQxmuLQvh3/4UXDBJNlx4w3q0LjWbaRRoX6WABurQ9w7dGiIkjbGGgb63Mzi2FnVwh88du65NWxMbbpdfbvSIOnIsdksThLNDNqE+KoLsWpyKFcVEApOFkPW1OiN9KYJjRga90hH219j/6gIywxVEDGpr1h+RpC0aWzhMXaoh/ul1LlR50FFfE8yMpVYi6l95yflscCO3wVyS5ugtJkIIXtzzqAAe91AKAZPKb/KXic+L5tpFEWVHVFnja6Ukq0BQP+bMcmnr9je2En2Bivy822xA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IK6SFWGImit5PoQYdgpQCDFX2ajTbJ7d3pyVWYdJjcPFnOLVQlgQImFkIBQo?=
 =?us-ascii?Q?143ZJhTZ9IOGV7e/Q5FwzMkf0MwUyNzQLc/aW66pzCtmXPmA0VjEWPEy2lhG?=
 =?us-ascii?Q?QTXhfGji8b9kN7m5MyPcRiWUi+vO98GEgBVNL+J3m5jkax4FNiNugVbJKP4v?=
 =?us-ascii?Q?gD/Hf4/4uJzAdJ/GGiGrdUpOFbE77RID+XcjMtN5Zd+eJ+xVrqObFg163e81?=
 =?us-ascii?Q?QdX73vfgQrJtQar0AWrfWthJy66nW2u1JIJsbdEz0bPXYQs4dRlepNAY728Q?=
 =?us-ascii?Q?1wlLk+A3R/TwTfxnZlQTFlukwpnZl3awiieU/ZZTDI+g+eF4cqFyx2sQmR6I?=
 =?us-ascii?Q?NI9ud3qMBe/Wq/3rZ7DiFLex7OeYDnMEF4oCeUiEcXMNTjfy9g5EBb7WKJYY?=
 =?us-ascii?Q?P0/BkYPVqrmcDgeawctJqn5SCEovlJiSNqmPJG9fjRReAU34k7OjMD8aDGAU?=
 =?us-ascii?Q?YzA7wIB6wkvzEuDDhJdF8RH6Xw84ba+VTnMmnwt/e/TBwtfHPPTWBfHZF7em?=
 =?us-ascii?Q?ScTxBEcTDLG/bgFaGEKWWvzavch1JGe9QNKSaSNIkiGyaae4kISptyadAp3w?=
 =?us-ascii?Q?YivjyS6IVDu7U2j7P9tExjouMIOdJXCO5EX1YhunvftJs4du93Eh5hB+5V5d?=
 =?us-ascii?Q?G5Ul9i0kqX3v3mgLBYqn1+ReSfmpLnR4SjmGnYmiDA2HU+2sg1+Nzl+wKt+f?=
 =?us-ascii?Q?HYcm3acbnr8bDvomyOm6CM3dL//teTHPLV3l9vAmi0ExML8sBL0/lypiDmE7?=
 =?us-ascii?Q?7cv2A5p8G8u2/7fe7zNUOmREujaq5Rp0lE4tF/96cw/itTrdY6AKGYU4V/M7?=
 =?us-ascii?Q?Eprsdwj1x22MgKc/7Rlk91eMhoR2bP1EwliLxDJ6uyA0a5hUrFfAbXGi0qjh?=
 =?us-ascii?Q?/Gqx7g0yXoFu+qbzMD3Y4WWDGxAswSkbGkaaf9+PJtya/gsYvMxpTtw+2QIe?=
 =?us-ascii?Q?Iffsf2Srl6+FemTIJXYFGesWCV8FeytviZd/P+TRvdpImvAmi/PLLM1c2zbJ?=
 =?us-ascii?Q?hpKT4SSMI1Eo10F33Sgcult62EPlM6b8ef5i2PBB3a4elZVmjp+RTflxq1MZ?=
 =?us-ascii?Q?N/ppoedOX62Zuug6AhduULKx9z2jHQg1fFm5QiFLxzksTe5u7MMlupEpqYtp?=
 =?us-ascii?Q?Qux4CgKNRPogJ/CkCmRXcSFPxgS3HzRcPDwPW6Ad5z1gvLF0deMK5C+x/4sX?=
 =?us-ascii?Q?O+y1GL2/WEoMQzJoX/DZikzGj9OWuhAmexNGaiAAnKZ47YwphHWVewakKvVW?=
 =?us-ascii?Q?EHTzsK2pzXGpPVWd7t+AoJ0nJTttIUXh6ojglIksPtcGgwDNT3UKYZMwHDDZ?=
 =?us-ascii?Q?6nBrgiyxaht4TngIwoTaWSpaVbFAVVw6NLUV/LX3v6bMG6J1d5eSFOZ5c4Oa?=
 =?us-ascii?Q?PkqcgdIfBZdwqOPOLnUhLWvh+JFaKrKTkIx/K+WrpL7SYxPYCYskM1zbtet9?=
 =?us-ascii?Q?XxKKb8Lbkjjl/HofjIEXil9wTGgE+vqr1JH09xJ6Z87KFKlFp94d/BzzcY6q?=
 =?us-ascii?Q?QiAxWTpfpFRA7LmwtR+/1xsdaFMBJh2SYR0uGvHM3tnAV5Om1uwgt0s2k91I?=
 =?us-ascii?Q?9TYwuQABiJ2VUH+3hjgkeG9qXjotASn/JQQN4cM0/BWNkPGp+tQW4Qydc1Uj?=
 =?us-ascii?Q?dNoXqHoB4JKcZz1ewmc0Q3+ZYfNZ3hEhyidU3qwS7O7KB6xEZEGwNsPN/Bzz?=
 =?us-ascii?Q?xqIf+s6T4KVKh25hc6FI4XclvWdWnERwtLJQR4IOpKHuPujlDjHsJhMyiUi6?=
 =?us-ascii?Q?Oz0Jxg7TOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfb670a-661b-4ed1-665b-08de74a89247
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:00:49.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/43Ox1FVeU04zzdWKMrZkie1hbajuE44noeLg71C0S71wZLM3uMHF9JmfGogjRQhdHkwC7AlX83ZDxTAMUiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7752
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9101-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 812B419D01B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:41:11PM +0800, Binbin Zhou wrote:
> This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
>
> It is a chain multi-channel controller that enables data transfers from
> memory to memory, device to memory, and memory to device, as well as
> channel prioritization configurable through the channel configuration
> registers.
>
> In addition, there are slight differences between Loongson-2K0300 and
> Loongson-2K3000, such as channel register offsets and the number of
> channels.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  MAINTAINERS                                  |   1 +
>  drivers/dma/loongson/Kconfig                 |  10 +
>  drivers/dma/loongson/Makefile                |   1 +
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 729 +++++++++++++++++++
>  4 files changed, 741 insertions(+)
>  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aea29c28d865..af9fbb3b43e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14954,6 +14954,7 @@ L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> +F:	drivers/dma/loongson/loongson2-apb-cmc-dma.c
>  F:	drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> index 9dbdaef5a59f..4278fbbe8096 100644
> --- a/drivers/dma/loongson/Kconfig
> +++ b/drivers/dma/loongson/Kconfig
> @@ -12,6 +12,16 @@ config LOONGSON1_APB_DMA
>  	  This selects support for the APB DMA controller in Loongson1 SoCs,
>  	  which is required by Loongson1 NAND and audio support.
>
> +config LOONGSON2_APB_CMC_DMA
> +	tristate "Loongson2 Chain Multi-Channel DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the Loongson Chain Multi-Channel DMA controller driver.
> +	  It is discovered on the Loongson-2K chip (Loongson-2K0300/Loongson-2K3000),
> +	  which has 4/8 channels internally, enabling bidirectional data transfer
> +	  between devices and memory.
> +
>  config LOONGSON2_APB_DMA
>  	tristate "Loongson2 APB DMA support"
>  	select DMA_ENGINE
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
> index 6cdd08065e92..9abe75b91e17 100644
> --- a/drivers/dma/loongson/Makefile
> +++ b/drivers/dma/loongson/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) += loongson2-apb-cmc-dma.o
>  obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> new file mode 100644
> index 000000000000..6aa064cb5da4
> --- /dev/null
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -0,0 +1,729 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Looongson-2 Chain Multi-Channel DMA Controller driver
> + *
> + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_dma.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +#define LOONGSON2_CMCDMA_ISR		0x0	/* DMA Interrupt Status Register */
> +#define LOONGSON2_CMCDMA_IFCR		0x4	/* DMA Interrupt Flag Clear Register */
> +#define LOONGSON2_CMCDMA_CCR		0x8	/* DMA Channel Configuration Register */
> +#define LOONGSON2_CMCDMA_CNDTR		0xc	/* DMA Channel Transmit Count Register */
> +#define LOONGSON2_CMCDMA_CPAR		0x10	/* DMA Channel Peripheral Address Register */
> +#define LOONGSON2_CMCDMA_CMAR		0x14	/* DMA Channel Memory Address Register */
> +
> +/* Bitfields of DMA interrupt status register */
> +#define LOONGSON2_CMCDMA_TCI		BIT(1) /* Transfer Complete Interrupt */
> +#define LOONGSON2_CMCDMA_HTI		BIT(2) /* Half Transfer Interrupt */
> +#define LOONGSON2_CMCDMA_TEI		BIT(3) /* Transfer Error Interrupt */
> +
> +#define LOONGSON2_CMCDMA_MASKI		\
> +	(LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CMCDMA_TEI)
> +
> +/* Bitfields of DMA channel x Configuration Register */
> +#define LOONGSON2_CMCDMA_CCR_EN		BIT(0) /* Stream Enable */
> +#define LOONGSON2_CMCDMA_CCR_TCIE	BIT(1) /* Transfer Complete Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_HTIE	BIT(2) /* Half Transfer Complete Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_TEIE	BIT(3) /* Transfer Error Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_DIR	BIT(4) /* Data Transfer Direction */
> +#define LOONGSON2_CMCDMA_CCR_CIRC	BIT(5) /* Circular mode */
> +#define LOONGSON2_CMCDMA_CCR_PINC	BIT(6) /* Peripheral increment mode */
> +#define LOONGSON2_CMCDMA_CCR_MINC	BIT(7) /* Memory increment mode */
> +#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK	GENMASK(9, 8)
> +#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK	GENMASK(11, 10)
> +#define LOONGSON2_CMCDMA_CCR_PL_MASK	GENMASK(13, 12)
> +#define LOONGSON2_CMCDMA_CCR_M2M	BIT(14)
> +
> +#define LOONGSON2_CMCDMA_CCR_CFG_MASK	\
> +	(LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LOONGSON2_CMCDMA_CCR_PL_MASK)
> +
> +#define LOONGSON2_CMCDMA_CCR_IRQ_MASK	\
> +	(LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LOONGSON2_CMCDMA_CCR_TEIE)
> +
> +#define LOONGSON2_CMCDMA_STREAM_MASK	\
> +	(LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_MASK)
> +
> +#define LOONGSON2_CMCDMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> +					 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> +					 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
> +
> +#define LOONSON2_CMCDMA_MAX_DATA_ITEMS	SZ_64K
> +
> +struct loongson2_cmc_dma_chan_reg {
> +	u32 ccr;
> +	u32 cndtr;
> +	u32 cpar;
> +	u32 cmar;
> +};
> +
> +struct loongson2_cmc_dma_sg_req {
> +	u32 len;
> +	struct loongson2_cmc_dma_chan_reg chan_reg;
> +};
> +
> +struct loongson2_cmc_dma_desc {
> +	struct virt_dma_desc vdesc;
> +	bool cyclic;
> +	u32 num_sgs;
> +	struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_sgs);
> +};
> +
> +struct loongson2_cmc_dma_chan {
> +	struct virt_dma_chan vchan;
> +	struct dma_slave_config	dma_sconfig;
> +	struct loongson2_cmc_dma_desc *desc;
> +	u32 id;
> +	u32 irq;
> +	u32 next_sg;
> +	struct loongson2_cmc_dma_chan_reg chan_reg;
> +};
> +
> +struct loongson2_cmc_dma_config {
> +	u32 max_channels;
> +	u32 chan_reg_offset;
> +};
> +
> +struct loongson2_cmc_dma_dev {
> +	struct dma_device ddev;
> +	struct clk *dma_clk;
> +	void __iomem *base;
> +	u32 nr_channels;
> +	u32 chan_reg_offset;
> +	struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channels);
> +};
> +
> +static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_config = {
> +	.max_channels = 8,
> +	.chan_reg_offset = 0x14,
> +};
> +
> +static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_config = {
> +	.max_channels = 4,
> +	.chan_reg_offset = 0x18,
> +};
> +
> +static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	return container_of(lchan->vchan.chan.device, struct loongson2_cmc_dma_dev, ddev);
> +}
> +
> +static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct loongson2_cmc_dma_chan, vchan.chan);
> +}
> +
> +static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc *vdesc)
> +{
> +	return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
> +}
> +
> +static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	return &lchan->vchan.chan.dev->device;
> +}
> +
> +static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id)
> +{
> +	return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
> +}
> +
> +static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id, u32 val)
> +{
> +	writel(val, lddev->base + (reg + lddev->chan_reg_offset * id));
> +}
> +
> +static int loongson2_cmc_dma_get_width(enum dma_slave_buswidth width)
> +{
> +	switch (width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		return ffs(width) - 1;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int loongson2_cmc_dma_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +
> +	memcpy(&lchan->dma_sconfig, config, sizeof(*config));
> +
> +	return 0;
> +}
> +
> +static void loongson2_cmc_dma_irq_clear(struct loongson2_cmc_dma_chan *lchan, u32 flags)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 ifcr;
> +
> +	ifcr = flags << (4 * lchan->id);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_IFCR, 0, ifcr);
> +}
> +
> +static void loongson2_cmc_dma_stop(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 ccr;
> +
> +	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> +	ccr &= ~(LOONGSON2_CMCDMA_CCR_IRQ_MASK | LOONGSON2_CMCDMA_CCR_EN);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, ccr);
> +
> +	loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_MASKI);
> +}
> +
> +static int loongson2_cmc_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +
> +	LIST_HEAD(head);
> +
> +	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
> +		if (lchan->desc) {
> +			vchan_terminate_vdesc(&lchan->desc->vdesc);
> +			loongson2_cmc_dma_stop(lchan);
> +			lchan->desc = NULL;
> +		}
> +		vchan_get_all_descriptors(&lchan->vchan, &head);
> +	}
> +
> +	vchan_dma_desc_free_list(&lchan->vchan, &head);
> +
> +	return 0;
> +}
> +
> +static void loongson2_cmc_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +
> +	vchan_synchronize(&lchan->vchan);
> +}
> +
> +static void loongson2_cmc_dma_start_transfer(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	struct loongson2_cmc_dma_sg_req *sg_req;
> +	struct loongson2_cmc_dma_chan_reg *reg;
> +	struct virt_dma_desc *vdesc;
> +
> +	loongson2_cmc_dma_stop(lchan);
> +
> +	if (!lchan->desc) {
> +		vdesc = vchan_next_desc(&lchan->vchan);
> +		if (!vdesc)
> +			return;
> +
> +		list_del(&vdesc->node);
> +		lchan->desc = to_lmdma_desc(vdesc);
> +		lchan->next_sg = 0;
> +	}
> +
> +	if (lchan->next_sg == lchan->desc->num_sgs)
> +		lchan->next_sg = 0;
> +
> +	sg_req = &lchan->desc->sg_req[lchan->next_sg];
> +	reg = &sg_req->chan_reg;
> +
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, reg->ccr);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id, reg->cndtr);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CPAR, lchan->id, reg->cpar);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, lchan->id, reg->cmar);
> +
> +	lchan->next_sg++;
> +
> +	/* Start DMA */
> +	reg->ccr |= LOONGSON2_CMCDMA_CCR_EN;
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, reg->ccr);
> +}
> +
> +static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	struct loongson2_cmc_dma_sg_req *sg_req;
> +	u32 ccr, id = lchan->id;
> +
> +	if (lchan->next_sg == lchan->desc->num_sgs)
> +		lchan->next_sg = 0;
> +
> +	/* Stop to update mem addr */
> +	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, id);
> +	ccr &= ~LOONGSON2_CMCDMA_CCR_EN;
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> +
> +	sg_req = &lchan->desc->sg_req[lchan->next_sg];
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req->chan_reg.cmar);
> +
> +	/* Start transition */
> +	ccr |= LOONGSON2_CMCDMA_CCR_EN;
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> +}
> +
> +static void loongson2_cmc_dma_handle_chan_done(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	if (!lchan->desc)
> +		return;
> +
> +	if (lchan->desc->cyclic) {
> +		vchan_cyclic_callback(&lchan->desc->vdesc);
> +		/* LOONGSON2_CMCDMA_CCR_CIRC mode don't need update register */
> +		if (lchan->desc->num_sgs == 1)
> +			return;
> +		loongson2_cmc_dma_configure_next_sg(lchan);
> +		lchan->next_sg++;
> +	} else {
> +		if (lchan->next_sg == lchan->desc->num_sgs) {
> +			vchan_cookie_complete(&lchan->desc->vdesc);
> +			lchan->desc = NULL;
> +		}
> +		loongson2_cmc_dma_start_transfer(lchan);
> +	}
> +}
> +
> +static irqreturn_t loongson2_cmc_dma_chan_irq(int irq, void *devid)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = devid;
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	struct device *dev = chan2dev(lchan);
> +	u32 ists, status, ccr;
> +
> +	scoped_guard(spinlock, &lchan->vchan.lock) {
> +		ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> +		ists = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_ISR, 0);
> +		status = (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_MASKI;
> +
> +		loongson2_cmc_dma_irq_clear(lchan, status);
> +
> +		if (status & LOONGSON2_CMCDMA_TCI) {
> +			loongson2_cmc_dma_handle_chan_done(lchan);
> +			status &= ~LOONGSON2_CMCDMA_TCI;
> +		}
> +
> +		if (status & LOONGSON2_CMCDMA_HTI)
> +			status &= ~LOONGSON2_CMCDMA_HTI;
> +
> +		if (status & LOONGSON2_CMCDMA_TEI) {
> +			dev_err(dev, "DMA Transform Error.\n");
> +			if (!(ccr & LOONGSON2_CMCDMA_CCR_EN))
> +				dev_err(dev, "Channel disabled by HW.\n");
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +
> +	guard(spinlock_irqsave)(&lchan->vchan.lock);
> +
> +	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
> +		dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->vchan);
> +		loongson2_cmc_dma_start_transfer(lchan);
> +	}
> +}
> +
> +static int loongson2_cmc_dma_set_xfer_param(struct loongson2_cmc_dma_chan *lchan,
> +					    enum dma_transfer_direction direction,
> +					    enum dma_slave_buswidth *buswidth, u32 buf_len)
> +{
> +	struct dma_slave_config	sconfig = lchan->dma_sconfig;
> +	struct device *dev = chan2dev(lchan);
> +	int dev_width;
> +	u32 ccr;
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		dev_width = loongson2_cmc_dma_get_width(sconfig.dst_addr_width);
> +		if (dev_width < 0) {
> +			dev_err(dev, "DMA_MEM_TO_DEV bus width not supported\n");
> +			return dev_width;
> +		}
> +		lchan->chan_reg.cpar = sconfig.dst_addr;
> +		ccr = LOONGSON2_CMCDMA_CCR_DIR;
> +		*buswidth = sconfig.dst_addr_width;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		dev_width = loongson2_cmc_dma_get_width(sconfig.src_addr_width);
> +		if (dev_width < 0) {
> +			dev_err(dev, "DMA_DEV_TO_MEM bus width not supported\n");
> +			return dev_width;
> +		}
> +		lchan->chan_reg.cpar = sconfig.src_addr;
> +		ccr = LOONGSON2_CMCDMA_CCR_MINC;
> +		*buswidth = sconfig.src_addr_width;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ccr |= FIELD_PREP(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, dev_width) |
> +	       FIELD_PREP(LOONGSON2_CMCDMA_CCR_MSIZE_MASK, dev_width);
> +
> +	/* Set DMA control register */
> +	lchan->chan_reg.ccr &= ~(LOONGSON2_CMCDMA_CCR_PSIZE_MASK | LOONGSON2_CMCDMA_CCR_MSIZE_MASK);
> +	lchan->chan_reg.ccr |= ccr;
> +
> +	return 0;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl, u32 sg_len,
> +				enum dma_transfer_direction direction,
> +				unsigned long flags, void *context)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct loongson2_cmc_dma_desc *desc;
> +	enum dma_slave_buswidth buswidth;
> +	struct scatterlist *sg;
> +	u32 num_items, i;
> +	int ret;
> +
> +	desc = kzalloc_flex(*desc, sg_req, sg_len, GFP_NOWAIT);
> +	if (!desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, sg_dma_len(sg));
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		num_items = DIV_ROUND_UP(sg_dma_len(sg), buswidth);
> +		if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> +			dev_err(chan2dev(lchan), "Number of items not supported\n");
> +			kfree(desc);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		desc->sg_req[i].len = sg_dma_len(sg);
> +		desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
> +		desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
> +		desc->sg_req[i].chan_reg.cmar = sg_dma_address(sg);
> +		desc->sg_req[i].chan_reg.cndtr = num_items;
> +	}
> +
> +	desc->num_sgs = sg_len;
> +	desc->cyclic = false;
> +
> +	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +				  size_t period_len, enum dma_transfer_direction direction,
> +				  unsigned long flags)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct loongson2_cmc_dma_desc *desc;
> +	enum dma_slave_buswidth buswidth;
> +	u32 num_periods, num_items, i;
> +	int ret;
> +
> +	if (unlikely(buf_len % period_len))
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, period_len);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	num_items = DIV_ROUND_UP(period_len, buswidth);
> +	if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> +		dev_err(chan2dev(lchan), "Number of items not supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* Enable Circular mode */
> +	if (buf_len == period_len)
> +		lchan->chan_reg.ccr |= LOONGSON2_CMCDMA_CCR_CIRC;
> +
> +	num_periods = DIV_ROUND_UP(buf_len, period_len);
> +	desc = kzalloc_flex(*desc, sg_req, num_periods, GFP_NOWAIT);
> +	if (!desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < num_periods; i++) {
> +		desc->sg_req[i].len = period_len;
> +		desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
> +		desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
> +		desc->sg_req[i].chan_reg.cmar = buf_addr;
> +		desc->sg_req[i].chan_reg.cndtr = num_items;
> +		buf_addr += period_len;
> +	}
> +
> +	desc->num_sgs = num_periods;
> +	desc->cyclic = true;
> +
> +	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lchan,
> +					     struct loongson2_cmc_dma_desc *desc, u32 next_sg)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 residue, width, ndtr, ccr, i;
> +
> +	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> +	width = FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
> +
> +	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
> +	residue = ndtr << width;
> +
> +	if (lchan->desc->cyclic && next_sg == 0)
> +		return residue;
> +
> +	for (i = next_sg; i < desc->num_sgs; i++)
> +		residue += desc->sg_req[i].len;
> +
> +	return residue;
> +}
> +
> +static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> +						   struct dma_tx_state *state)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct virt_dma_desc *vdesc;
> +	enum dma_status status;
> +
> +	status = dma_cookie_status(chan, cookie, state);
> +	if (status == DMA_COMPLETE || !state)
> +		return status;
> +
> +	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
> +		vdesc = vchan_find_desc(&lchan->vchan, cookie);
> +		if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
> +			state->residue = loongson2_cmc_dma_desc_residue(lchan, lchan->desc,
> +									lchan->next_sg);
> +		else if (vdesc)
> +			state->residue = loongson2_cmc_dma_desc_residue(lchan,
> +									to_lmdma_desc(vdesc), 0);
> +	}
> +
> +	return status;
> +}
> +
> +static void loongson2_cmc_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	vchan_free_chan_resources(to_virt_chan(chan));
> +}
> +
> +static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vdesc)
> +{
> +	kfree(to_lmdma_desc(vdesc));
> +}
> +
> +static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan, void *param)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct acpi_dma_spec *dma_spec = param;
> +
> +	memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
> +	lchan->chan_reg.ccr = dma_spec->chan_id & LOONGSON2_CMCDMA_STREAM_MASK;
> +
> +	return true;
> +}
> +
> +static int loongson2_cmc_dma_acpi_controller_register(struct loongson2_cmc_dma_dev *lddev)
> +{
> +	struct device *dev = lddev->ddev.dev;
> +	struct acpi_dma_filter_info *info;
> +
> +	if (!is_acpi_node(dev_fwnode(dev)))
> +		return 0;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	dma_cap_zero(info->dma_cap);
> +	info->dma_cap = lddev->ddev.cap_mask;
> +	info->filter_fn = loongson2_cmc_dma_acpi_filter;
> +
> +	return devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
> +}
> +
> +static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_phandle_args *dma_spec,
> +						   struct of_dma *ofdma)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = ofdma->of_dma_data;
> +	struct device *dev = lddev->ddev.dev;
> +	struct loongson2_cmc_dma_chan *lchan;
> +	struct dma_chan *chan;
> +
> +	if (dma_spec->args_count < 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (dma_spec->args[0] >= lddev->nr_channels) {
> +		dev_err(dev, "Invalid channel id.\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	lchan = &lddev->chan[dma_spec->args[0]];
> +	chan = dma_get_slave_channel(&lchan->vchan.chan);
> +	if (!chan) {
> +		dev_err(dev, "No more channels available.\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
> +	lchan->chan_reg.ccr = dma_spec->args[1] & LOONGSON2_CMCDMA_STREAM_MASK;
> +
> +	return chan;
> +}
> +
> +static int loongson2_cmc_dma_of_controller_register(struct loongson2_cmc_dma_dev *lddev)
> +{
> +	struct device *dev = lddev->ddev.dev;
> +
> +	if (!is_of_node(dev_fwnode(dev)))
> +		return 0;
> +
> +	return of_dma_controller_register(dev->of_node, loongson2_cmc_dma_of_xlate, lddev);
> +}
> +
> +static int loongson2_cmc_dma_probe(struct platform_device *pdev)
> +{
> +	const struct loongson2_cmc_dma_config *config;
> +	struct loongson2_cmc_dma_chan *lchan;
> +	struct loongson2_cmc_dma_dev *lddev;
> +	struct device *dev = &pdev->dev;
> +	struct dma_device *ddev;
> +	u32 nr_chans, i;
> +	int ret;
> +
> +	config = (const struct loongson2_cmc_dma_config *)device_get_match_data(dev);
> +	if (!config)
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32(dev, "dma-channels", &nr_chans);
> +	if (ret || nr_chans > config->max_channels) {
> +		dev_err(dev, "missing or invalid dma-channels property\n");
> +		nr_chans = config->max_channels;
> +	}
> +
> +	lddev = devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), GFP_KERNEL);
> +	if (!lddev)
> +		return -ENOMEM;
> +
> +	lddev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lddev->base))
> +		return PTR_ERR(lddev->base);
> +
> +	platform_set_drvdata(pdev, lddev);
> +	lddev->nr_channels = nr_chans;
> +	lddev->chan_reg_offset = config->chan_reg_offset;
> +
> +	lddev->dma_clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(lddev->dma_clk))
> +		return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Failed to get dma clock\n");
> +
> +	ddev = &lddev->ddev;
> +	ddev->dev = dev;
> +
> +	dma_cap_zero(ddev->cap_mask);
> +	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> +
> +	ddev->device_free_chan_resources = loongson2_cmc_dma_free_chan_resources;
> +	ddev->device_config = loongson2_cmc_dma_slave_config;
> +	ddev->device_prep_slave_sg = loongson2_cmc_dma_prep_slave_sg;
> +	ddev->device_prep_dma_cyclic = loongson2_cmc_dma_prep_dma_cyclic;
> +	ddev->device_issue_pending = loongson2_cmc_dma_issue_pending;
> +	ddev->device_synchronize = loongson2_cmc_dma_synchronize;
> +	ddev->device_tx_status = loongson2_cmc_dma_tx_status;
> +	ddev->device_terminate_all = loongson2_cmc_dma_terminate_all;
> +
> +	ddev->src_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
> +	ddev->dst_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
> +	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	INIT_LIST_HEAD(&ddev->channels);
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		lchan = &lddev->chan[i];
> +
> +		lchan->id = i;
> +		lchan->vchan.desc_free = loongson2_cmc_dma_desc_free;
> +		vchan_init(&lchan->vchan, ddev);
> +	}
> +
> +	ret = dmaenginem_async_device_register(ddev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register DMA engine device.\n");
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		lchan = &lddev->chan[i];
> +
> +		lchan->irq = platform_get_irq(pdev, i);
> +		if (lchan->irq < 0)
> +			return lchan->irq;
> +
> +		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> +				       dev_name(chan2dev(lchan)), lchan);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = loongson2_cmc_dma_acpi_controller_register(lddev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register dma controller with ACPI.\n");
> +
> +	ret = loongson2_cmc_dma_of_controller_register(lddev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register dma controller with FDT.\n");
> +
> +	dev_info(dev, "Loongson-2 Multi-Channel DMA Controller registered successfully.\n");
> +
> +	return 0;
> +}
> +
> +static void loongson2_cmc_dma_remove(struct platform_device *pdev)
> +{
> +	of_dma_controller_free(pdev->dev.of_node);
> +}
> +
> +static const struct of_device_id loongson2_cmc_dma_of_match[] = {
> +	{ .compatible = "loongson,ls2k0300-dma", .data = &ls2k0300_cmc_dma_config },
> +	{ .compatible = "loongson,ls2k3000-dma", .data = &ls2k3000_cmc_dma_config },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
> +
> +static const struct acpi_device_id loongson2_cmc_dma_acpi_match[] = {
> +	{ "LOON0014", .driver_data = (kernel_ulong_t)&ls2k3000_cmc_dma_config },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
> +
> +static struct platform_driver loongson2_cmc_dma_driver = {
> +	.driver = {
> +		.name = "loongson2-apb-cmc-dma",
> +		.of_match_table = loongson2_cmc_dma_of_match,
> +		.acpi_match_table = loongson2_cmc_dma_acpi_match,
> +	},
> +	.probe = loongson2_cmc_dma_probe,
> +	.remove = loongson2_cmc_dma_remove,
> +};
> +module_platform_driver(loongson2_cmc_dma_driver);
> +
> +MODULE_DESCRIPTION("Looongson-2 Chain Multi-Channel DMA Controller driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> --
> 2.52.0
>

