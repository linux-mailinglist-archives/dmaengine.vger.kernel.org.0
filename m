Return-Path: <dmaengine+bounces-5190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84999ABB457
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 07:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BFF1896349
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 05:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52C1EB9FA;
	Mon, 19 May 2025 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="u7dCyse3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BF4B1E79;
	Mon, 19 May 2025 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631424; cv=fail; b=Qva3x9GZCAb5Jm9orHonTUhZlxSWIfAx1oOxaY5tvc7NlYMTxKceTnkBQgNDUeWptD3E158a0HR4i6dd5R8YnmifC02gn8l5B1lDrBvpmqBXoUmzdENsAQ06NNknkfD2VpcRpCsnEJ6oNwZuGa98N+AHpBDa6RysNrTm95U4p5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631424; c=relaxed/simple;
	bh=wv6OsOCI0XnXhqjenqsyviEKK4/hPQ0D948Iy+uCupo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iXoFocto0DtCulqH9pOpCjxCwvRFuex7mFkqRou7XAKZZ825TAjiVA/jAmsuiUU0GK4Gb6NJLvF92HphlgxqHlMvQJMNOFMEsSEwUwG//S00F7kFWr+2TUfHYexVV9YBKP9HHuifoO+VDeO+5+Ij2eT3p8ADoM1pJ/ird+FUW9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=u7dCyse3; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXjjsLvfWwrcSpiLGZqsbrsLOnx20CDIXkmkz17iWKZMHz0+jDe3cdBfbRGK0bja5PG3lk/ODr0HdGKOgBmCJmkTduetFJMykB71EKtl7e7Usssfe7Ero3ygX1fq53z8FT5yzTFvIr9pwxU0DmNvFXrz3PZ23hVgQIjRT6q8kl6CiFn2UTLYlbHJbrZROCbPkzh6GRR+IP+8Gi+Yj31vSau+EtBmUpl6cr+ZfC3cFV0mOZ8PBxg56LhLvOKC0mB20SUkBe8dN1gMuxTdfcXw5DpBPvX/w10iqR2J5lU7MLNOKJ/BfoCvt4LMJ++fSrPANG1jWmtTwaFunwv/Ghsi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCZ44Tdg4kypCJj+yGUFCyiLUd8kKTYPnoqnCjP4cpk=;
 b=Mtzr6HLlr186hA9AEDTIyN7fyOV9hiHY72+SHktEq/FjZhCfr6izL5dIxxEWN3y6fIjRlGqgGQsnryXlcjWu96TqMsXpyj4X4LUylPyVckTmw56xt/1Mohx7m0YS48Q4cNoUkLH3sPu+R+dDLJueTtcDW1mrdVplWeU0ueh3HbMHChMa6pAEOu0JPXbVyznIv30KHTWYpc8Jriy3wtGAK7aB8z86xxP+4AaQGJrbsFgtr0tIK7Z2KZvLvmZGXNTxUsYxHP2siCWTUDAYgkhAR3IDm6QKBcPRafpA1aPf1PRu6n+bu4GPwuNKle2Sd9PRftXaC5YYO3dlvgaEwGIfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCZ44Tdg4kypCJj+yGUFCyiLUd8kKTYPnoqnCjP4cpk=;
 b=u7dCyse3i4jeGqV+C9SyS134eh+oCP41BrOrkb9EB6hq4ye2hDPPYJoAdSRwbjwhdoOL24hMKLv28CDp0nPU2M3l1kCb/GdinoZokLOGO8eP0dGHeriE3fbAD+KObcDbWHxmmBDAPBoD3pmqRDgfDNfeV9cfqY+G4dFBA25G7xO48/knGR2q8BKv7gl4Yz8MN8wdMHrmcMYOB/QMQqzXQR1LNNRv2S/OEXYX/LHEhQU941EzK9NclY+7cO9PvfpAmGBg01AiDcMXMf7/RxXX+8YBidJrtaErnvz09UrQpWwMP0jTi8+bfMBmcbiMbIsr1uMQS2BC0DaFPrSwSAP0gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8060.namprd03.prod.outlook.com (2603:10b6:610:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:10:19 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:10:18 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH v2 0/4] agilex5: Update agilex5 device tree and device tree bindings
Date: Mon, 19 May 2025 13:09:37 +0800
Message-ID: <cover.1747630638.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d041630-3327-4519-1b5d-08dd96937296
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PGlpQTTS3/T6SVJm6gBATsp9YiejIM/tQDQWnyHfhkmYbEKrvIC83dWtbiQ?=
 =?us-ascii?Q?gdEH92eotmkdKr2vZhiJZ+4qOTtofqU2y0N/lGT4WvudcmTI4MD44z5oMgqr?=
 =?us-ascii?Q?KTx0bcXNde5SXmLFpvS5MtnBzPC/FnA53lYCVkrRcI7uzQxK5WHHBqlu4sMN?=
 =?us-ascii?Q?4VFevEPwGT5Be4Ge8UaL3D4HkWSKv3uHDkbBS8TDzq+rjr+3CDPeTiQMVlhC?=
 =?us-ascii?Q?GZsycUApGkJEDZR7ZP9KRuLxh+hS/BVpsAvhxD2IjH2d8EmGNJohI6qwbd/p?=
 =?us-ascii?Q?bMD5XMle5DSxnFgE13oidQcPIM94r/QeQ28UOODMY23+6UMtISv+P1SUJuQI?=
 =?us-ascii?Q?WVklQTWKdIFgtzA+b+/ZgAjYXSVo5TbbpwJf3CqJ2Tx+UUtkUFGvrH3TICa0?=
 =?us-ascii?Q?kHv6pffTzKQthwzQmuG9nLFCKZC97is2ukzqwogdMX8bHGmS4QigPQTkPwft?=
 =?us-ascii?Q?YEPkuHyoyKK34zHbDyG5afB4EYueptY3rHOf4hbBxrpKFtlVEqw4q6Oyr8Po?=
 =?us-ascii?Q?mAoJR1RO/KJk5l+t9tE+Kqu6TL39eJ/Jzp/Urlp4Wi6bcJsbh9MPfXCAB4GQ?=
 =?us-ascii?Q?POa2bmF+oqvU0VepGZibGbukn7qFH9wZgVFs/0xGAOYgaInpoxlZRZM8JXMf?=
 =?us-ascii?Q?h7Ka/ZFyuoOzpcrOe1Qi2TaZx2+C+nbt/12tCLFbjKECOTFk7YJ66M8QKDGG?=
 =?us-ascii?Q?SkvE+P7ZPzdXJ6tB5F4iE1T0wBa3JeoOUKkRTv1V8H7wSrPAuFA/Rz2/Y3AQ?=
 =?us-ascii?Q?ZQBeyFHeI/b9NRfy0X0kmg+hze5KMXX6jexBAU//xPBdVmCdIZX4sEfwE5a/?=
 =?us-ascii?Q?cTeTjUnzMKykTbar4UJEuMGff/xQKpfRzG+kHGxErOi4Ro1wj1g4j2JVJ5zD?=
 =?us-ascii?Q?0se3KHjYv/FXIy2p1rmZsg0lv29HLmZzATpeqnwsSKibCJuxuYKhGoTssmp3?=
 =?us-ascii?Q?ih7Aq3nIDqMdc0vXp5BUv3fNbbtHUTU4GcB9FMwu6/MnTcgnWt94SosDZFC9?=
 =?us-ascii?Q?iXpW8Mw0UKYxsj19RCFelmiRQ0hQj4uu80mFCUYT9AwvnW0vDmYJeiwaeuMo?=
 =?us-ascii?Q?Ytaz36oEQCWo4FT4tFusyNRgtBcM6lA74jq6mQoBAonm8Xdh4zrhj2N0Grxs?=
 =?us-ascii?Q?KzB50b2WsTjXrqWHV2RTC9jQpj3m0Uafd3yv2lSXrS38Si21UlVj7lzaZHmI?=
 =?us-ascii?Q?RRjDrbs9py0BrK8nUqjzTqKkr3CAYBkuhgd0ZK+NMiVFlWlsM5lvgwEttWMg?=
 =?us-ascii?Q?DsDwhzqGY6WgrtHDL+yMA0BZGYFCtT2Dn+IOi8Q1N+zx+UIIuHwiMN/B5Kg+?=
 =?us-ascii?Q?IOqB4+FIDJ7wdzQv7ujto5vLyhuXeBBJzmef9M2sZ2FA/EDnA1dusyhkpycq?=
 =?us-ascii?Q?XgXcT0IgaokhxBlr80L4PTlxafThesFexFyLw3+NY7p/EKxBsmdyfL/6zRxN?=
 =?us-ascii?Q?XfmJ/Qlf2Hk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?To7NqCjLH2ympUK8dh/CcSlldvqq9sQ8YgO/SajnQDiCyShV+OEUGrq/9GPt?=
 =?us-ascii?Q?9r6HPrHYDq9tmTwSoral5FJawFPVTvxLd5Pr/eIbIZoAbswmIpUPctvxP448?=
 =?us-ascii?Q?Bf+JAEX4pRnj/gFXMJOz7Q4vuAcaP29399/vjoCQOUAQzY41KihJdwqD5fJ2?=
 =?us-ascii?Q?UAJGMELvQwjDMU5vNpMBdy3LIHdbYnsBiK2/LONvv4/Maad1kntEGjrwFzJF?=
 =?us-ascii?Q?dvr//DjVGSddeAMbQeaCHo9HuSsxi8ezvGuwHk+PUWFwL5F7Gw7mm3i9H//1?=
 =?us-ascii?Q?h1TPf4RA/anxiH2C1m9l9FP0WQ2ExknwEm7dkIhn/kBO2zWH7T/3B57gnXSq?=
 =?us-ascii?Q?kuOx0EbTlRI3zYYABkqAA1+FRa+jVvxPE2mMP0kPGouUE/hantWrSADp92hN?=
 =?us-ascii?Q?ANDezk6t4zFMb2MSyL8TvKSTK1dvMYFo5apwRPT8vnw96ELjvYCwpiXd5gb+?=
 =?us-ascii?Q?l7WAfdlizMbgxTiG4rANP6Gt5tBN6cV7C3QmXeUN3IoxaVTwAGVBCg0lvWJh?=
 =?us-ascii?Q?FJXXo69hiwP5Ji9UUdNdq02WxqblBt5lRvM3RQ19WEqAnN6btzlIMxsQ59yX?=
 =?us-ascii?Q?uupJqr7kemV14El7xGncagx8/68LfhHokMMvMvzHZntEvLzjFuK2EigrozmO?=
 =?us-ascii?Q?ZBU9z3WkG4tDFIHY3kfgY23fDfJzkCbUu6LMIhr2yC1qV2emm3g+vLGr3Ztt?=
 =?us-ascii?Q?eXUDg0fSqDkmO71vrUQgPRDNTqCKSm5miW9GG/JTyUzsbsPGTkkO/1fN25yx?=
 =?us-ascii?Q?lvbGlchbY5c7QPDvyxQpCA1Hr4XgL8Pq+7r5rU+zBH018M4OUwFYXb99DvpW?=
 =?us-ascii?Q?9VxZ/iKubw7cJN0ifLUDQtK88fShpxdWAqH3XXAqeut1ma/gfVQOZKbdn8W0?=
 =?us-ascii?Q?P0icLkZJapuawJ1WeSS1ANSVtuuEhg2v0Ry7E8Vw46Wgf/Tg1mqPqPKcXvGE?=
 =?us-ascii?Q?7xK09YpEtiXxJJLBCkAdcY67dhfz9feQwEFrGliQCt1vLLn6N70bfLTvPu6S?=
 =?us-ascii?Q?Y0+qB8KtH7jebCOCJO3F/CZdui/WW/R0Ha3izj8WyArDgEIvgjF8ymxttrHD?=
 =?us-ascii?Q?/edJ9smP2/2lCozh/qUhqfhMZAHRiUvJSBTpAsBhaGDKI1DoDU8hCoC5KZib?=
 =?us-ascii?Q?RiSWkp8f8ZZdG2eqitGSMoqiNXzMaSL/JCORWm6IvcGncKwsSGst8US7NMGt?=
 =?us-ascii?Q?gJLOG8d97YkUf/Fi7ThOwYjd3ztUxcUoNEOs4J0eVfMbjZQPh1GI/jri5zNs?=
 =?us-ascii?Q?9mbdeUdj3i40DnVb+a4JnjMX+3kei36aN1fpzocqBx/p0xhfpCs/BeC+URrG?=
 =?us-ascii?Q?pNAEeLwlCmw0z4Bize2S80tHZh7YIwHe0RJhT5G4GKRR1OlWPimTiE43UCmv?=
 =?us-ascii?Q?49qvEvcQyJc6yoZtfFh9UsGth2RpuY6hclvnAY4XM5HqurS2bqOF7qsQxwZm?=
 =?us-ascii?Q?9MZINfyYXtvJmqADRDEMLc80jmu1CcmM7Z1kmfaTaQ1tym7JGSy61PCA6RTk?=
 =?us-ascii?Q?LSGvmNhQugeHHDJ4rUsBfeEBuUgHo0CDzQSuY7vX/XLCtR9LZdZIj4QxFJQv?=
 =?us-ascii?Q?ROyvoWKoRGTM7eMCI+3yORm2gOhFOforgH3A5SND/r8paXo9zhC9WvfSn21R?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d041630-3327-4519-1b5d-08dd96937296
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:10:18.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CszuP+NpSdvY2m6tCNIMgaWW7zHuvVPBUOjrLOH5cjrRZ4R1lAJcr9RwO32DEL8/sOcfTbH3QvW/AVTsh+pEiw0tDrZgL3sQHiOA4hRzL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8060

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patch set is to update Agilex5 device tree and the related device
tree bindings.
Altera Agilex5 address bus only supports up to 40 bits. This patch set
adds support for a new property that is used to configure the
dma-bit-mask if its present in the device tree

This patch set includes the following changes:
-Add property for dw-axi-dmac that configures the dma-bit-mask to the
required bits.
-Update cdns nand dt binding with iommus and dma-coherent as an optional
property.
-Update Agilex5 dtsi and dts.
-Add implementation to set dma bit-mask to value configured in dma
bit-mask quirk if present.

v2:
-Fixed build errors and warnings in dw-axi-dmac.

Adrian Ng Ho Yin (4):
  dt-bindings: dma: snps,dw-axi-dmac: Add iommus dma-coherent and dma
    bit-mask quirk
  dt-bindings: mtd: cadence: Add iommus and dma-coherent properties
  arm64: dts: socfpga: agilex5: Update Agilex5 DTSI and DTS
  dma: dw-axi-dmac: Add support for dma-bit-mask property

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 13 +++++++++++
 .../devicetree/bindings/mtd/cdns,hp-nfc.yaml  |  5 +++++
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 22 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  4 ++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 14 ++++++++++--
 5 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.49.GIT


