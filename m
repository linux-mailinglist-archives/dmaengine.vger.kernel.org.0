Return-Path: <dmaengine+bounces-9254-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIObOSyUqGkLvwAAu9opvQ
	(envelope-from <dmaengine+bounces-9254-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 21:21:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0732078E3
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 21:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585AB30DAC5D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3447369995;
	Wed,  4 Mar 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MktYkdtX"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0734CFCF;
	Wed,  4 Mar 2026 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655473; cv=fail; b=p9pE7yeSI3DveSKYkcyxwL44rWUexejxOKHuXqsYtrgPbB5XG5grI93+m/Xm+a3Q4BfbcG+n+4IjDmNBruuaGZnf34qYAbpFm6n+xEYjnMt9jDJ3+t7XAiGW3QjS5IaVtiF410CDpJJdLt53kUlqEt93/jnsHin6E94pvCvaP0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655473; c=relaxed/simple;
	bh=mjLu1ND2X0YNw0vBZhuzBxYaahwagiQA/TYhVY0BefE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ABnOPzzS3OhDNXJBVvTHqIR2M5pcWKoujOwMd4mkNR6EgftpsI+fjJR1jRAZ3/Rw6iQKV6K1U5hTM1QudT0jfi8VNhqTlwKa39CTY4RVPn4wPqxiMaCms5HdCRZ9JRnJnNQR3Tomyl5FyCn5+X6MPXxH49+1WTH/6p8WYs+GjdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MktYkdtX; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFkhJtkVd1JY+sGItYW1AXbDYbJx+uCd+0p4RNJXfCVXtAnjhfenYBisAfEh2Xw2+jgfOL4zW7q023pRLwDNmyIojYykx4waiLcpqrClYCT01DXrWHDjvl9hOd2sHObFtXV/f5ClWV2cZ99ODVqzT/TLQEbbSDzDlB955wqF5hxVcT04UsiaFLer8gfD12FoQjPHqyxrpww74XsIL8WXEHSjtZ8+19MkZHu5zdVnVYe4KvfdPW9/fqxji1yNIQFqJ3o4zntSriu6l+o7TFRvG1eLoR854ccom2unBeGU93iSThHfLL3B11HrArDXMOuKGl4ChVlskdAHYYzaVD22Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnNpOzL4Phsy4nXYHzDJl33lizmaJyo8Qe9LF07Uz9s=;
 b=d23tucPANYMj+qRzZlyccRWRj81uAsuRsqEnrfHO7kYtkDxkaTW5xeE+QyDft6VKSi6TJf5d2qn8BJwEMcL0ikVJhM77hruXCctAuAgHDXVcBN0r/pVlB3S+D+8htHOGksuYDyIv1BDBT0REVR+fMWrWSpat0K/UKWxW8CQ5spkpC6YxHoxLuhRDb1BdoDXiweVijJcTaz41SdOj7OsfdhMvlYeQs6UkNFZ7QbsBCnR5xFissRbttLvpUoh/cwoisU12o6v31mzlxXq7WvbLS80C8pC01bDsgUIQD/2tqVGr82v3Erq5F7ix/NRXXh6V/Co9mPaivLLmelJsBpNnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnNpOzL4Phsy4nXYHzDJl33lizmaJyo8Qe9LF07Uz9s=;
 b=MktYkdtXy/G3ADw5cBdWpFFCwnqf9RK3MbDpJE7lu2P5GSFaY8bHm5lsXs+/1RkFs1oxhOan0Egt2u7GZASBiF/Fdp8gfCdy/8qFkT1vdCn4TKPqalU+ljI+2kNkUs3/bLUB0N3Vtgqii5f+gFYaZqoQsWcAqoMjbopsZ5VghgOCHb2vSXID3etuw7HyWdGKhW/ZFPrCUtV6MN0ShhiXImbA7aFF+JwMaepq3cPOhblufjsN1fFqxJDVh3gUIe9R3Trj8+HkX2MOI0LOf1WFKd1JeYsM09KSNAL84tRqh+/4q3aQBhP+vg3j5TKYsCMM+9jePpqJluLp0txZ6mDBWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 20:17:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 20:17:49 +0000
Date: Wed, 4 Mar 2026 15:17:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, git@amd.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: dma: xlnx,axi-dma: Convert to DT schema
Message-ID: <aaiTZmfvV6DmWl9o@lizhi-Precision-Tower-5810>
References: <20260304182646.3190500-1-abin.joseph@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304182646.3190500-1-abin.joseph@amd.com>
X-ClientProxiedBy: SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 209d7a86-2dda-4070-79fe-08de7a2b1af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	iJb0KF4t1rKwJzKBe/zivqXfGF2b4It6UUf/JyxTZ5RQ+Xc/bP+/lpoLOc971p0iWQ3ARqRHf/a2cq8jEgrQ0znsF5K4h2vVymNJmhH6JDQHj4oUAZBg93eNDgvcpB4+DvqkKbiThlu+ZSspPT1sRGDESkbyR0PjUKvpypN5ve0XPrqnZ6T3RT++TQOpa791rlLlMq5P+mnerq9nYbaloADrBBBuw0JWRib8hzCfgtKqWqUBVN3oQemK5lcu/ANOsQgbKfFP01IrXAEsI5dPwPQpWQAMMId35lCcKU37l4lvKP7gCaDcMQZf9HxwJKaf+Rg+pBMQAdiXTrP5e0XBW9bCWw6Ovfmit4IfOeSHFuOzHyM09RWs1B6J9Fq6/H1LLlavCtvLHNglty8cb133gftYVywAfMkoIa5RZcvqtAXGQeDUA4xzXsdwGMvMjyjbwgajygqnpIqCJjnLsQDf0pTC40nvmdmu9l9G6L2HCrpeOh+trQrRbPEjIJvkVybWcuASS4bI06yHCALF1ls4x3MsJ19vdiqyXk8qU/C5kQnPc5Jty7h7vjtGoqkLrVn/in4AL/EAeyEEgCcuJ9boGIwMtGCWh4lbvmbyBBwFDf5r7s5daWMLm4Or+Ec97GsGwPC/pdzn5B0l9PpMJth9/itdyoqC42wybHswr1IDaGQGUJXOeJMd9k/+sdzWpZ6pEEtCC4r27U7KtjQpqMpcagbZt0Dyx0kg0vgSF/UwY9oubSLnbwOyA5JFzzGqc9V1ENxBTQ+BPUWC9SDe9RIplR7Q9iPpLuwlgK0Uq/4p8gU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5KiPmgctLUF1Cn+yOgi38G5ZQKxiPzCcyZVlo849VDgsdZMU4GpLD5GqMBV?=
 =?us-ascii?Q?b4z0Z0ZIPpyPQ8gQAfbyhH/fBz37+CQFLgu0XDUgSCdvpkhA71m+He248Igd?=
 =?us-ascii?Q?BmwLVTfWPMPYhXNRQ0+AeJzsV6tWode3+XNKC9u9LWkYyY31fa65Yk5/Uk1o?=
 =?us-ascii?Q?JBfhp6y6kkL3FAw3VJcATiT2j0zpxCr+WTvLVUWhtjb02ZJHutHVUj+rOYDd?=
 =?us-ascii?Q?EEFNN2IS2Q/yrJ6YN/3RcK+UyRNaY+fPzyYGS+HwkYGx6VuWlClz1L7US2dp?=
 =?us-ascii?Q?vhC/bueLCHnoEOUMxPxYHSxKYrNAZnF2u3EoeKn7CDXlETyG/UbfXyrX4f6d?=
 =?us-ascii?Q?2WylC8jax2NM57q6ZXDS6QuCgqczE4Bq5gOwE+BlyNfg9sLdRj27rFOYziQa?=
 =?us-ascii?Q?lHhdiuYB34nv1R5dUgjdy6BJOhwN2EM3HB0xNDdZLP4YM8by8P2/st/kBPdB?=
 =?us-ascii?Q?sSM9YU9RWCxwVl9tP8ddxez+knf/b+UzFHSME374gBH0wP5AdB/YBTxc4h8X?=
 =?us-ascii?Q?0t+jzdMxhctb5I5XXmdPWPf6XrFGSMgWaiBsrN/515vaKKU9rXJQqBPFNltr?=
 =?us-ascii?Q?8Um2wsIJBqJM8A+EPlc62gYG2Cuk2NzUH8gdbaA1Q+QistmZvavFa5qoQHqj?=
 =?us-ascii?Q?TNw25h9A3OURugTmpErSVWlWA6+i4fRCT51X6o/1SkNoxAkM97PV7K9zgxWf?=
 =?us-ascii?Q?dHBy3tw5tXil9zWhTOMHivIQ6D8DDJpt4UEYzp04HysYbuMfx7nsZFpmppDq?=
 =?us-ascii?Q?PpDxPFE8eQ2WjZCGpGYtoUCBj26qleQ3IjZjFljhmPwFSHCRFeFc2s6CPpBG?=
 =?us-ascii?Q?83fTE6qI0prGseMk1cVUoCDebHqiu7t2LXoJ6QEQsXzzK/7oe61tiEB5kAYw?=
 =?us-ascii?Q?W4/aPxkGxxeZVDuj07ndkIlpr8RGcgDMMUP94RzM7y/oYZFCTOw8LdB6t6Ru?=
 =?us-ascii?Q?KAfno1Ke6StOifLLtXymBdQbFSfI6E2KnSqOcrgveHrJTcO53qX+A2mIo80D?=
 =?us-ascii?Q?UMoMJcqKf6mGzkMhmYatTBIzt1Co456zT8vyTE5159zOqIzsULA5iuqP7ft0?=
 =?us-ascii?Q?5I1cQ0Fx8CTMoLprKPhTH+OBFeopDVoehDFT6spnt3IC5q3T9orjVjZdcHUU?=
 =?us-ascii?Q?p8lSk6JoeUiZmDNBYMuXb2AGEgr1Zf/Ksgt2NHwrpF9RmOv3RfN5gKdySvqI?=
 =?us-ascii?Q?hfiehBrDJ/B5ogHbl8xkzCQGUBWQgIXpPgHDSmIq2QUovMjwG5n50/WHIgxw?=
 =?us-ascii?Q?TX8zBT06J4DTdI+V52JPw9AZdGeWWK3vg0RhpMyneomq12m5NmYQ1XZTSY8a?=
 =?us-ascii?Q?3LZbb/2RrVczU6k/JkuDw5AC2O2IM7fOjWJXWRjdf71MkTNNJRUkKoikQN5G?=
 =?us-ascii?Q?/I8p0gcApEPgNlcvTf+xTvMidadE9Z0s0k3+12OCk/n/VWWtbWANHbkjr7+F?=
 =?us-ascii?Q?4GJFXOaCbstEQ38zuabAc9DiooOUTnIwajVSSof280XzP50QBEIMsIDOrzZQ?=
 =?us-ascii?Q?PnPz0v1wMiskFylaqSVEUUATKL88j3W6Q4U5SatnHlrD96beZN8vB1RFrJe8?=
 =?us-ascii?Q?OW57rZqvPBmQUl2QdcThkHan+KaGzbtBj2lgngUh3x38bMhvcS3Jujt1xDGN?=
 =?us-ascii?Q?hmn6Niw1IoX364/r+CHHkOD/CmixagZdIhhX9mLFkWRqxxmfKiQL/FgB9EVf?=
 =?us-ascii?Q?cc7WZlnhpsyvXHG4TYhSgCsgTjADMQV0InAszDRxkeuZl4OxvFcVO7iRiMXD?=
 =?us-ascii?Q?qDx5hFJwjA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209d7a86-2dda-4070-79fe-08de7a2b1af0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:17:49.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jiryr0PppSmZjHNOyz3cKzZ5UWsnfMrXMmiK+pH9BGzfUxMW9guQ5Lc5HiVCpldiwO/d7bHUBn1wSs69bNx2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
X-Rspamd-Queue-Id: 4C0732078E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9254-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,amd.com:email,2.98.207.48:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:56:46PM +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA.
> No changes to existing binding description.
>
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>
...
> +
> +maintainers:
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> +  - Abin Joseph <abin.joseph@amd.com>
> +
> +description: |

I remember rob suggest use > instead of | to keep paragraph.

> +  Xilinx AXI VDMA engine, it does transfers between memory and video devices.
> +  It can be configured to have one channel or two channels. If configured
> +  as two channels, one is to transmit to the video device and another is
> +  to receive from the video device.
...
> +
> +required:
> +  - "#dma-cells"
> +  - reg
> +  - xlnx,addrwidth
> +  - dma-ranges
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false

Use unevaluatedProperties: false because ref to dma-controller.yaml
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    dma-controller@40030000 {
> +        compatible = "xlnx,axi-vdma-1.00.a";

reg should second one.

> +        #dma-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x40030000 0x10000>;
> +        dma-ranges = <0x0 0x0 0x40000000>;
> +        xlnx,num-fstores = <8>;
> +        xlnx,flush-fsync;
> +        xlnx,addrwidth = <32>;

vendor property should be last, after clock-names.

Frank
> +        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
> +        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
> +                      "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
> +                      "s_axis_s2mm_aclk";
> +
...
> --
> 2.43.0
>

