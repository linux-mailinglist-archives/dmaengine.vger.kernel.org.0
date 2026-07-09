Return-Path: <dmaengine+bounces-12180-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8E6wNiqrT2rHmQIAu9opvQ
	(envelope-from <dmaengine+bounces-12180-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:07:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8963731FD4
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=ILXVx4+h;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12180-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12180-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ECD230F8B1C
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561641C317;
	Thu,  9 Jul 2026 13:59:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E3416CEB;
	Thu,  9 Jul 2026 13:59:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605554; cv=fail; b=eBNWN4I+MaFPvJMbGWDWXilmh81F0687J0F2ghAzE+y0p56ZoNo7ylhpc8F6ArxDexXWEkVqgEpiHyXB4bYiS55//2INTEj8AgU7PFNlsKTdDFnbqP6SVUB/CM1ZhFTTIFvDPGFQpTvbSjzjae5TDoC1xljnZ+OTzdvTWj3QUCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605554; c=relaxed/simple;
	bh=MBg2lHEI6G0ylalMjaLwymqa9oAGin3pdRQYMpRXu38=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MVWD19mqQQ2o8XkDDQTjWTOIAR+rCAO0ahv/bBApsaqXSLzA7kvTJBVW0/m1qybum+isF6zw9b3jo+J6NBg6beEotpAmrMRQbatTDGJtD3h4CCjpAAVvnMB7mQUVedfe7OkrEnhhj8NzCg6nQbUt1qfUkK4fScjLoGE+a3TIVNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ILXVx4+h; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifb/3cTpOKpweRJ2AASLT/5/Nw2HPjtcxkkb5aJXdcW00hY0fGBjKcxJZDhEoEo8Ehe4qQtzwlMBZH8gF5Hj/BI2hXNr+7oHY5pAuWh8t/QpRRAoVglhEaSwgJJQ7uWht8iXK9SXnWkuPQgIT9bLcAjgcooGlf9FTKiMhQ8h9q0FDxY2b5hOINdXVFnIZRkPeEcsu0O1yUWyCvjtgE3WB6WZ2dzCPKd5O6U5C9ph1p43G8Kt24kyIFkng+C4+TwP5IZutW3xKUt/QgHFVhcC3qBOeXdZ1sc1kw/ERSHv+nwzRBxNSHsmXjVxiwb4ZeRspmwjks2Ur0XCLzEQCtZtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOzwOcQbvakUVf8rVMR1KArGq4nCtlU53/DRC0r1R/g=;
 b=MQu051oXLJbGXwwE/tzxe2j/puHA2bpNwr7+23zcCic8F13NnPFYSlCdfqheeqVHDj/qCUmi++b8FOe3fd60lorBHjf936ZaWdtW99LM7Vkw8FsrduaYfW9OryDNcTNQw+2IxiCfHSUbO1+f723qjYjwYc2jmEgCsKGTE8OUqYYC1i9tg6+rPPCrOiYzBe964+nkZwGct70cr66b8Aq0onvE3+tuAF2dvivSHP5dU63solZVh/l87z65tGhkJQxahB1fqFAUqvB1VmLfNTzNdXytovv+jO0S0G9rZaeOzH7WdJmQof7ATV2eNIIWqukvg4tInRzAa4E2N0tO4nncRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOzwOcQbvakUVf8rVMR1KArGq4nCtlU53/DRC0r1R/g=;
 b=ILXVx4+hd517/hcQPFiqr4A/Qx+2GjH2ZibTDLuTh5GCh6kA4Ri8oAAnZAbVdXDV/NoUm6Lx/MxOamU6dxS8E1r8iMiAmcno9k0NaLuPIF2VCkIo9bkom08GDo3shVWcljZea5/MM4rgrNyaNIuWMLCYhT81N8lkvYC0A441YyEkbxShJHK5PFO9IK7GR71erQJ5pszLjClOvuFCvXIOLSI5zj5Hh3oB9lN44akIi0/g/c+3f8tp4oWmdJZ9WC8EY2SIOY2X/TSjDv3xHb/r7Sg3lwLHYRWdmp+GGJ6tij7tLsBXdR0ZNuJPVIYO5qMG2TaifWbrcld6lyKzshVCQA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS/LOONGSON1 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:MEDIATEK DMA DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:MEDIATEK DMA DRIVER),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-riscv@lists.infradead.org (open list:SIFIVE DRIVERS),
	linux-renesas-soc@vger.kernel.org (open list:ARM/RISC-V/RENESAS ARCHITECTURE),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:STM32 DMA DRIVERS),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 00/26] dmaengine: Remove redundant error messages on IRQ request failure
Date: Thu,  9 Jul 2026 21:58:04 +0800
Message-Id: <20260709135846.97972-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcd5df5-2006-45b2-e3ad-08deddc23b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|23010399003|18002099003|56012099006|11063799006|921020|38350700014|6133799003|41080700001;
X-Microsoft-Antispam-Message-Info:
	ilQVOiP7mW7zZkAoqwuF2SKeDCbTeIa3bwZhFZd06A4lanF5GgK8UN7cbORqHeiP14zEYw9/NW76TdHeBMOc7KbLxxmmfmATu2VDParzQXIXMzMXur2IUUwnLzCYVKUEvRfD/0CJ+zFFpTYJE93U2d0FeTh3KQcuNKf5BxfqlbCvfYqmUXz+AOeyn38JXFZC7PrkLKB+egLQj91PO9OMUnNY1Gzj84m/yGLU0/9FnFlMgXlkbMAzXAm+hM4e1XgeCab7CGd53dKMjKnmmHGNw8UrYM9FO6aKXIKY2q29ho7kb0aYVtUIcsGugR3fUF4wUwkihncpz3QPv4cR0vL3MkfuFs1mLbYH/hsCRAT9AMA4CZ3L5LVe2TsGsa766jdCq0X4q7VSAGmlZPrvenwnaxlvsDWjSVVGjpdrw45K0poDJlTIStOrNnErmAKpl73YR2R/ZkkPRg412Vv39G/A6gLqnVQEBWnLfphRF9N2Wgez0+VWyYHbSEtjZ8mbrs0/3fJR4wlJLoBbnMwdwh28P9JM7hti2S5IqKdD/o9HKJ53TAd5A13GB8VcRqsM17IjSZj6Or1SRgPZ3LirVQtXDAZiNER003nTXPbqinsi2zZ/aEtc2HB2jU6Lt8ZuBPlPwcX0pTaldkSZ5nI0VutpjIhgiBm7vEFc313IFJUe9dE9nEQEW93myFpY1xEn2dlIEcpRD2bgx8itZiRE5VsGO/q6xNgKETBWpeROfVaSgrKG0tRKubGd4u+1xtrpimYpnDDnTfFE1+wWHHDPvJIevA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(921020)(38350700014)(6133799003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aw2kElSYYd+5jSr9MQ4IQOlIvGiXaQs2AlEPZnyMee/6bxyQ6Bxm0qGzHWk3?=
 =?us-ascii?Q?w5/jh3NdyHInHO8TPJQTAbLOCSL3HjSiOdyIEjVTeTeCLPfetBjfZxwXB2az?=
 =?us-ascii?Q?ObBet0x/i2YJyjydcB7Lcj5MYIwvSQgWIcL9lGY0aZrPaa4VK3fqDXkPUBzA?=
 =?us-ascii?Q?1TRmfRAho+lgCJ0er9cQtAUf52wh4r0pfGBQg/NqNX4gE+LYXAaSe91zw0FQ?=
 =?us-ascii?Q?+RYHXs8LW4X5CjYdWaVflhBul/xFvxNQugSkXk2wa2hXRhAbwJCfShpZ/Zjr?=
 =?us-ascii?Q?rDpF5qXavGUwpTep1yHmFWIaHpDQsdgRZEC2yIkPGcN6qmVKDtUni64TgCIj?=
 =?us-ascii?Q?AeCqTZcyZHPkHcaJB9lAHVdArL7KdpZkv4SIQYaxiBiK9pMpEeKulkQNvRW9?=
 =?us-ascii?Q?Cf9PZxhJYfZeIcX2aFc+bXADKI16KoQX3B+n9ORZVYJii4HqpfJULSixMsgi?=
 =?us-ascii?Q?AO3BW3CiEMvis1l1pPsaRz+pSYzSIYVpbmHZxbXmO01g9WXhfI1WjPkzUq5X?=
 =?us-ascii?Q?zhkeEQ05p6spp5r9SQI14dJdIv6AF0Dv/XpEU0+I8uukKBqzJDkKvTX7hR3o?=
 =?us-ascii?Q?1HaHEXAw9iUN22fkTIH8u0O0iivPghm9nquCr4x0nrAIGsfnChOzwqSPaJil?=
 =?us-ascii?Q?4dl2nIqwZfngezJeG3HKa9aBCV9KAFsISu5F/MvszAzfXd45p2jeCCThUPCe?=
 =?us-ascii?Q?vl0qJdzDcbG53wCFBi+FzOxU/stt7z607rpArCMtJh/M8JC5IrZVqZ8genlZ?=
 =?us-ascii?Q?pJyQNe6oCbONHs/4jZGOm22KDRpBTFdSP6RXyRS/5dc1kpto8zkd01asDDBu?=
 =?us-ascii?Q?8UsfmFaYKpYdYm6x+F2c5I0kwKNJqE7loUs1pwhBZwrSqsZM8fQU2ahKmDj8?=
 =?us-ascii?Q?V3YapXNNgq3s138UX5/yb/70WF2dNbt+CQ7AJLy1Qxc0oozjGm1E3UaDPFt/?=
 =?us-ascii?Q?jUvJRG0z2i/ZTJs8UbyDVAXePoneMjeDD8W4XN1j4anp407g5aAAIIXOpET/?=
 =?us-ascii?Q?2cis2Hfg254tMIZSszLDXAASdQbwdm+YnhAc7iZcZd9VRm6DTLzbRM5JgVZm?=
 =?us-ascii?Q?tjkZy3ovddq+qlFW6zuSGGRC8DveVVAKZOtDYXdE1pK9ScJBnR5f9RVZkP69?=
 =?us-ascii?Q?atkAKNvBNwBxzudzn36PCG03zHeTMIidr5VSgMZNb6anc7K0GaH/KNXfcCNi?=
 =?us-ascii?Q?bmT7y68bOB7jC+NFpSTaEP5//vHNQGEVId0WxcA67GAqMbIRDyjLFbU8Ms03?=
 =?us-ascii?Q?kXLs7JikTd41baBZcbO3O5+aHOUJfIX3LwPF9wgkjptzyUn1/YumhVfSMfDY?=
 =?us-ascii?Q?0ftSyMJ/BKRknCHsZqb/o0HnzFSAD8y5BKHbzlUeDNqo1r5xpyWjCF3cTPAO?=
 =?us-ascii?Q?3pkF1ShrUdkiXjHpYLS4CdtxqrVud8aOrsdkPwHrEFJDDAoPgqXvJWm8yqEx?=
 =?us-ascii?Q?+vMQALUiSGDODJGOAWEFmBS32LCB1XTTPxdCUAC3QVqRax68soeDXI4nCb+o?=
 =?us-ascii?Q?8KU1f39RquunVbZ7FWcbuPLwFXpBJmMIXw3mgnd/G6bxmocb7B3l+XXvBUUU?=
 =?us-ascii?Q?PToBGu6oZM3YxxEjZKJvb3pn0xBA20vAJ+6h3H6xWksylUn2pEl9zkdm6oBQ?=
 =?us-ascii?Q?wcWSbvhF2ceC7gma/xigQuZWMfaZGYiDwOLOMY/VOaA3Nnerqhfc3UIcaCZ2?=
 =?us-ascii?Q?JpAZSlwbtgnZM26wwPGCD4LcCVcikKOaZn/dSk7bcvytVUUXz1G2xVVMgstk?=
 =?us-ascii?Q?GgXAqzLAQA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcd5df5-2006-45b2-e3ad-08deddc23b56
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:02.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9BqxFm1rEhzm30o8qIar/kq5DJdfww5Oa5Osi004Zw8gdJxEtscjggn3n0/0DvfT5S2bUBf0/yii4ALFUu00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12180-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:keguang.zhang@gmail.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:afaerber@suse.de,m:mani@kernel.org,m:daniel@zonque.org,m:haojian.zhuang@gmail.com,m:robert.jarzmik@free.fr,m:pjw@kernel.org,m:samuel.holland@sifive.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:orsonzhai@gmail.com,m:baolin.wang@linux.alibaba.com,m:zhang.lyra@gmail.com,m:patrice.chotard@foss.st.com,m:amelie.delaunay@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:ldewangan@nvidia.com,m:jonathanh@nvidia.com,m:thierry.reding@kernel.org,m:vigneshr@ti.com,m:hayashi.kunihiko@socionext.com,m:mhiramat@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:andersson@kernel.org,m:panchuang@vivo.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:claudiu.beznea.uj@bp.renesas.com,m:biju.das.jz@bp.
 renesas.com,m:cosmin-gabriel.tanislav.xa@renesas.com,m:john.madieu.xa@bp.renesas.com,m:thomasandreatta2000@gmail.com,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-actions@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-renesas-soc@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:linux-tegra@vger.kernel.org,m:keguangzhang@gmail.com,m:matthiasbgg@gmail.com,m:haojianzhuang@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:zhanglyra@gmail.com,m:mcoquelinstm32@gmail.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,gmail.com,mediatek.com,collabora.com,suse.de,zonque.org,free.fr,sifive.com,glider.be,linux.alibaba.com,foss.st.com,nvidia.com,ti.com,socionext.com,oss.qualcomm.com,iscas.ac.cn,vivo.com,quicinc.com,bp.renesas.com,renesas.com,lists.linux.dev,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vivo.com:from_mime,vivo.com:dkim,vivo.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8963731FD4

Commit 55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10 ("genirq/devres: Add
error handling in devm_request_*_irq()") added automatic error logging
to devm_request_threaded_irq() and devm_request_any_context_irq() via
the new devm_request_result() helper. The helper prints device name,
IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this automatic
logging.

This series removes the now-redundant dev_err() and dev_err_probe() calls
in dmaengine drivers that follow these devm_request_*_irq() functions,
as the core now provides more detailed diagnostic information on failure.

Pan Chuang (26):
  dmaengine: fsl-edma-main: Remove redundant dev_err()/dev_err_probe()
  dmaengine: fsl-qdma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: loongson-loongson1-apb-dma: Remove redundant
    dev_err()/dev_err_probe()
  dmaengine: mediatek-mtk-cqdma: Remove redundant
    dev_err()/dev_err_probe()
  dmaengine: mediatek-mtk-hsdma: Remove redundant
    dev_err()/dev_err_probe()
  dmaengine: mmp_pdma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: moxart-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: owl-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: pxa_dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: qcom-gpi: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sf-pdma-sf-pdma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sh-rcar-dmac: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sh-rz-dmac: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sh-shdmac: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sh-usb-dmac: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sprd-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: st_fdma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: stm32-stm32-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: stm32-stm32-dma3: Remove redundant
    dev_err()/dev_err_probe()
  dmaengine: stm32-stm32-mdma: Remove redundant
    dev_err()/dev_err_probe()
  dmaengine: sun4i-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: sun6i-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: tegra20-apb-dma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: ti-edma: Remove redundant dev_err()/dev_err_probe()
  dmaengine: uniphier-xdmac: Remove redundant dev_err()/dev_err_probe()
  dmaengine: xgene-dma: Remove redundant dev_err()/dev_err_probe()

 drivers/dma/fsl-edma-main.c              | 23 +++++++----------------
 drivers/dma/fsl-qdma.c                   |  4 +---
 drivers/dma/loongson/loongson1-apb-dma.c |  4 +---
 drivers/dma/mediatek/mtk-cqdma.c         |  5 +----
 drivers/dma/mediatek/mtk-hsdma.c         |  5 +----
 drivers/dma/mmp_pdma.c                   |  4 +---
 drivers/dma/moxart-dma.c                 |  4 +---
 drivers/dma/owl-dma.c                    |  4 +---
 drivers/dma/pxa_dma.c                    |  6 +-----
 drivers/dma/qcom/gpi.c                   |  5 +----
 drivers/dma/sf-pdma/sf-pdma.c            |  8 ++------
 drivers/dma/sh/rcar-dmac.c               |  5 +----
 drivers/dma/sh/rz-dmac.c                 |  8 +-------
 drivers/dma/sh/shdmac.c                  |  6 +-----
 drivers/dma/sh/usb-dmac.c                |  5 +----
 drivers/dma/sprd-dma.c                   |  4 +---
 drivers/dma/st_fdma.c                    |  4 +---
 drivers/dma/stm32/stm32-dma.c            |  6 +-----
 drivers/dma/stm32/stm32-dma3.c           |  5 +----
 drivers/dma/stm32/stm32-mdma.c           |  4 +---
 drivers/dma/sun4i-dma.c                  |  2 +-
 drivers/dma/sun6i-dma.c                  |  4 +---
 drivers/dma/tegra20-apb-dma.c            |  6 +-----
 drivers/dma/ti/edma.c                    |  8 ++------
 drivers/dma/uniphier-xdmac.c             |  4 +---
 drivers/dma/xgene-dma.c                  |  5 +----
 26 files changed, 34 insertions(+), 114 deletions(-)

-- 
2.34.1


