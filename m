Return-Path: <dmaengine+bounces-7737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA0CC577F
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 00:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471A1305A830
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EC340260;
	Tue, 16 Dec 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ulqoi2be"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6633FE20;
	Tue, 16 Dec 2025 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927598; cv=fail; b=RFlm7rO9cXHvroId4mt2Pw/cuz4QEi3crqSPKnaet3Pop8gKva4PSlQEC0TfFay0FI2TyX1EZr08jhqC6iZE/T9f5UGEXtBgdjtxtUo9s6nwlW7wfiwjHR3jZVWsInJ6rIqoQur6gojPYhgWQA/OV13olNEI4gTX/BeorjpMUc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927598; c=relaxed/simple;
	bh=I7aLAWP6u6RyFO/Mns+70u+SW5u4yvbMBuzQdIAe4Ic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KToMMNcueBa1czj+Z0A52ZIUoz2W79Ke6ru1XFup8nY745nGoRxb9VhNyaJjLI3tEAhxpdBvnkrWOP524crExZ0SnKrnvyzzyzYRw93E4PnkMeYFnsUFsMvXemMh0wW3Vm2orjE3SrG0epZujFfPePSLA8wUb9WDd+oGNY33DeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ulqoi2be; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5NvljLkG1tqeD1zIN2iB4LbMDCNdCg5Sp6E6TnAzrUYVVwmcj27s73LTZnnMldDrWZPFIkgcV9fd+O9yfnV059HyjrlQTuy1AaApIP+7p3PlEfjmkLFuTUfJA3xDEDHp1zXkJGj9f8QHOyNNvbgnQdfXEib+6KocAiYTU0rRL9BGTlXHoCNLE4x+g38KuNRCiatqC30cZ9QVFB/0IPjUr9hKUlsv0Xi6naxkbtX2DAmiV900LLg4774pQ7ZfpS5wTHVeYdUXSCOVTjENyTyAGRqUtSF9pppFoYP/d1egunCo5fKshBdJOZ7mxQiDmsblObHurjQBPL5Xich9poFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq1hVNVkNrypRHhkD4xOnwKP04I3wRJsw+aT4YZexDE=;
 b=BWr0dY4NQNks6SIUVpj443ydfrAV19sUFR9Y6mvwezU5vm9axTt5mFoA9pw8iu3rfHLfvch2FOXpczJVFFU8vrHY7QuInkdd7/eIJcxFfwf+jLHqmZhKpl2TqbWb2Iy6GPaEqobfups9N3zDLw6/DhEYJlP/hT4KKtvLFyDhyJqH/aAjyN6MPd7FBdNFaIrThUtMGjfk+X7J3QAndd+zNl8qMEpghk7qGL9DPTuxckk/mx5Jp1k1w2OY2DzTEeC+QSfwSC3zrB4jcOfOU8R83IB6b0Q4XzMxq4E1AmY78CA0ymOpWlwRayC+mYB+yZ9gr03Ch3ff3xpnV6Hi9Tu7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq1hVNVkNrypRHhkD4xOnwKP04I3wRJsw+aT4YZexDE=;
 b=Ulqoi2beJTSmiFkCswSW496sy1pbZgvONU3ZeQy9x5LxkqTCg++YH6mb6OzLJ+mW3ScP+LE9x3nMrcYlExH6nVYBbDO7nYtJMaMzYEOKGTAS8M/v3VkxkzUqo6eZM+A1JJ+x+eiexzEtMVJcu98XDZ63f5fyvFyoLTle18hqZCHUtnrEZrH1kG3OPNQvJtEFzllXrgFI8rpsyROBmuZqI5o400r6lFULPgwmjKD2yDek0r6OkMzS/3xHLZzR5yKqISbcuQkCP73y0F+et/8kTMQzUTQv/qheVykFgo7FEZ47dBb67um4lWINCbmsOJBfy/MgVbxk3Y5KjkstLw0ozw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by DS7PR03MB5637.namprd03.prod.outlook.com (2603:10b6:5:2ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 23:26:35 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 23:26:35 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v4 3/3] dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus width
Date: Wed, 17 Dec 2025 07:26:18 +0800
Message-ID: <bce96511426a3c63d32530e359c7d966a7321679.1765845252.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1765845252.git.khairul.anuar.romli@altera.com>
References: <cover.1765845252.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|DS7PR03MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1d56d7-711f-4dcf-0a5c-08de3cfa8d9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0D9LP5KYHSa4VuVa9N8G5WMBQT/7fPyN7nzZYimGy26lim1YOF+eEQBay8i?=
 =?us-ascii?Q?K5PNfbAwED2eHBoVxhVCEYH8l8vBitlaDSGlek43ByFvsmdPvleNpjRy//ie?=
 =?us-ascii?Q?EcYwt3sD+FIa7O/lR8W/EQg1uUZiUcosKLwndgh+qzIIgQ8ieIy3VoFoz7AR?=
 =?us-ascii?Q?nIxdX47KIzWKKHhKrv/vm+QxrTfqArg7r7GWzqoZMX6eq/pBqxPibifHb8E+?=
 =?us-ascii?Q?Q4po+kKdWWzRQbI6GnT05H/myIERDTrWvdUx5+LVMV9EEz+vCPz3k1THZo7S?=
 =?us-ascii?Q?2auQH13M5iCLCyLahybI16Sjjrz5NNqjSLjXd+sN0Pb8ph/0wqKYXjTM0zt/?=
 =?us-ascii?Q?aNv/YYzwBYDf1SkMAJtwfo2T9U2/bAVNbg+EB5mKgM4Q9onK8PwPii0/1ks0?=
 =?us-ascii?Q?K68L7xx3IXt3Laghb0H1B8aEWBlWhB1abMwYIyZUho73339nx5rlNpGT0rEL?=
 =?us-ascii?Q?4fLprfqUeKNYOx8f8k8GXGujgMnbnQe8aIrj6tygKqaRCiNku09NPQmK5/R/?=
 =?us-ascii?Q?AwQq5FrmrCQheG8fMSnlBKLbvmPSs1jdMWZCoDqXXwHnf+ebwLRdOgxVNiMl?=
 =?us-ascii?Q?qyq5+Ku0MDXF8oBHfoODIUYgobeFRgu2kQnBVItBTBBSSNeYtVJVE+9OGQ4k?=
 =?us-ascii?Q?YvyrMWff4pfXecieTyh+Fsyp9LpTlJEhWrnzMUP/HwRsaE6vki+xj7eCTZcD?=
 =?us-ascii?Q?byuHDCA7Q/CRTcPM/5gcfHvGpGoLCb1Njit4ZnsLZCDt+/gjTSKRUIgOWHSn?=
 =?us-ascii?Q?D5iJkc5dCErW9+zFQ8k2/W7zMR32IESv6E4oUT6P32ZaL2qBPKvV8HqqEasf?=
 =?us-ascii?Q?j3Pl1yRGKqTsHL1fxq1VdWUr9Nt6QwiWEc6hEF04US0PLl5Fsvf4/iiFZdcn?=
 =?us-ascii?Q?JqZin23g82G6pAPphsjJuN1VCmVzgRcDqynQ5zZ6raIfMVba2k7hQrFeQNud?=
 =?us-ascii?Q?ITKVMWLQ4qf1a3RX01cZjL0IJ2mYf/UTlmOeTth63FSXzaGwZlAmj9Pl/sxf?=
 =?us-ascii?Q?1FaobrnZLeG5eosOGMpMM/G6dcb0ghIfSd+rP9U9bK3KuCy67KoCsmdPgHAA?=
 =?us-ascii?Q?2zIHcJDXxvzNqgdtjuj4eYQLTrX72gyiDA4O6NKzYVNAg8oxyVvycFUAP0Pr?=
 =?us-ascii?Q?uujbkWBqLekLOQVy0xIMWXcvpCXeY+QPhn5wakphyItmCTZu/3Eg9v15yRmX?=
 =?us-ascii?Q?oweJ1vLKOOdYSO8cdnANT5bvUqZCGed59gFl7VoUJPh93FFS0Mjc5LXRldIK?=
 =?us-ascii?Q?SFy5mrNQIuGGNPAgf2rVe10BRDmeU6ku72ezo9cm352FprCbCxVn8WLpGVOM?=
 =?us-ascii?Q?OXgMW9deS4yZ3N7MA7w2dTZm+aFnC6VLEwa9a6y6eIxq+uWFw1+20NGz9eGl?=
 =?us-ascii?Q?vtf7+fqzWCSc/z3Zxzk/cQmxOwKTbUzggz7bTqwbDzU26VpI4VjKVjbxOdOM?=
 =?us-ascii?Q?ciF8y+HFkzZqgXL5YRDdOjaaO8IiWLAQVt7iOxjpQp1m3/fygktC3xiuuJec?=
 =?us-ascii?Q?MV4CopYRGDrlKPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LECrhMEQ2IndsRXctIOkDGOnVaAa53qYEf+80IxDAHFiUsrWbKbpRIZ+0+D?=
 =?us-ascii?Q?efHxLz845nJq8+ERJLpQdAGtKdr25yn9g8v6HvAhzYYH5F2cWkp+lJDNvTsx?=
 =?us-ascii?Q?LiMVBxHOLvdkSFnFaRbW96uqMOb96IspmTNDFGL1K+ASbPP6UfOzQ9Ihd+Lk?=
 =?us-ascii?Q?9Xi8p7oD0ZOCsk7IH0hPv1AK9dyQU02wwfvs1kxmw4AMWusWOYp6kJ8dg/zS?=
 =?us-ascii?Q?GxFlehOxRgG2KvaFoLDZnewlLFdqp0DQMu3xj/q2ZaZLTdyasBhrM2x/O75K?=
 =?us-ascii?Q?saFzB9bNV3NQlpWaHe7MVbUIEmsfRgEfbY5TurstDT6yV1T99tkc2Muuz0AP?=
 =?us-ascii?Q?xMjmtCmDJhF1wusxMhQjYGgvp5T2Xb8kZrOgg0hWpYM3hczZ4YO0wCmKKIVa?=
 =?us-ascii?Q?B8ZFAMkqyDx5oXKH+GsrH8BdwJkQsTrf4LX9NBPjqq3PC9XvfssHfTZm8n2r?=
 =?us-ascii?Q?J/I0Dhfsvhk3fBkuARvxG+7xpl5gBJL4D8QXDma3gjbKiA7G/7sQNpqn7vXd?=
 =?us-ascii?Q?BY7LiG2GMdiGCoCE5O+tKnSEnWmdUMRTpl/TWBpC8vnQ6bOlLsHNwLMTvA0O?=
 =?us-ascii?Q?mopz6Gdz0O+iusGui0vXZQ+5AUy4q+I8AF5p/VnIXuafK5D2M7IchLKLW5/r?=
 =?us-ascii?Q?l/RGf8VE5ED9/ZQpVgA8ZxVPEcl7dHZltF9151xj5XncpMTwPVR5nM7cb79E?=
 =?us-ascii?Q?NinQHLrOWWFrIbfw4f/Cv4y4Jqci5IlYKL0ca4wFPlFRVWB9/koWcZ9XnauJ?=
 =?us-ascii?Q?0BkxtJR1l5dfaDJ6kSBCdxIeitQZwbpAwqnMdUsmTEqlZZuH+uu4j5awykc2?=
 =?us-ascii?Q?WZAUL9EKKocrptOu+MOKirTwfOTMhZq2SRywxMrmjvRG8ZLkckapwBIWbhqS?=
 =?us-ascii?Q?SP+VsxqLcLaKxE+w65NY5n1CIpF0LTJUDgWWn5/JZsGVpBP5f31mULU/38gI?=
 =?us-ascii?Q?fi3xkOmuJH2uA6gmK7qE4enrACHzd4QiENc2GK4TjXtVTIcUaLBeJex5koQ2?=
 =?us-ascii?Q?3F6fDJfgs/HXQejIx0pyq7w9gzSRU8s6n/U1rv5ZNG5t8VpW9AthtF891taT?=
 =?us-ascii?Q?nIDDchA+yEP6mJNaGByV5u38rgeVvhvs3ZaJVBp6DHC1gQ8vsJAAK/t+i/my?=
 =?us-ascii?Q?+iHa6U0qPnFMfnupbemA6+SFRwxwjx1kBROMAzCOW6XRY3DyfBBbUz8WJMQH?=
 =?us-ascii?Q?0aDRuZdN0euzArJKaBXsBDL7mKZYogKP+KU+sPmDqQSyZUk+H8AUOXFGq4pP?=
 =?us-ascii?Q?xXxym3joBQo/cYEwdNanMaYdSDE+uFCcuyjVFhfy7yiK/z1Yq3iUM51Tq1GM?=
 =?us-ascii?Q?NQMYT0Jsoq/5qSB8eFafNDuGK9DBQGArwoOLjuaX0OgKY5yPe0ISoZKFlVmF?=
 =?us-ascii?Q?Fh6q740zh9RHQDjGsTHpY749PbYUSBz73Jx36mt7v3pyXLQ65g72ckglm0TL?=
 =?us-ascii?Q?/xvv0dRnilKsodganEajguCSjtumyZyvY1KUMQcxxu7U/k2f8AtTJg7Yb3M7?=
 =?us-ascii?Q?CPNTP2LrhBjAE4n34P3tATJk48mG8jxTNzU7NjTJHzlb0oAWzaFt85CTyZ1d?=
 =?us-ascii?Q?4DkA3gSrGIFyXjh0RmCEBk/tu0ugx92hD0jurANRTzrhVtSxvrV3lhDbaT3P?=
 =?us-ascii?Q?bZcpbxxnDVQ+a1IrACgL09Tt4znrOsMNFb9SOWO+UDww+GyR03FI94ZC224V?=
 =?us-ascii?Q?F4U0pQhR3G7dlmBjS21gbxn5HVIco5Mf8CXDNpb9krWewLx5+KVsI7tZgc/1?=
 =?us-ascii?Q?TDEFjfOWS/HV65KsFzXbSBYd9boNd64=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1d56d7-711f-4dcf-0a5c-08de3cfa8d9c
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 23:26:35.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHlPmT9b5HI16UjjoBiy6TYgx6I292xDKWEcrvC1l8Qf+ELcHxJfl0nUnsF/W5owldXckGxvZO4+lLOmAh6I6EZQF8TyeiYpk73FfFa4XoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5637

Add device tree compatible string support for the Altera Agilex5 AXI DMA
controller.

Use common get "dma-ranges" property and calculate the actual number of
addressable bits (bus width) for the DMA engine. This calculated value is
then used to set the coherent mask via 'dma_set_mask_and_coherent()',
allowing the driver to correctly handle devices with bus widths less than
64 bits. Initialize the addressable bits default to 64 if 'dma-ranges' is
not specified or cannot be parsed.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v4:
	- Simplify the code to use common code to get dma ranges.
	- Narrow the code changes on hw_init.
Changes in v3:
	- Refactor the code to align with dma controller device node move
	  to 1 level down.
Changes in v2:
	- Add driver implementation to set the DMA BIT MAST to 40 based on
	  dma-ranges defined in DT.
	- Add glue for driver and DT.
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 16 +++++++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..ac67c18a05c0 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -264,14 +265,25 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
 {
+	const struct bus_dma_region *map = NULL;
+	unsigned int addressable_bits = 64;
 	int ret;
+	u64 max_bus;
 	u32 i;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
-	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+
+	ret = of_dma_get_range(chip->dev->of_node, &map);
+	if (!ret) {
+		max_bus = map->dma_start + map->size - 1;
+		addressable_bits = fls64(max_bus);
+	}
+
+	dev_dbg(chip->dev, "Addressable bus width: %u\n", addressable_bits);
+	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(addressable_bits));
 	if (ret)
 		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
@@ -1669,6 +1681,8 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "starfive,jh8100-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_RESETS,
+	}, {
+		.compatible = "altr,agilex5-axi-dma"
 	},
 	{}
 };
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..f9f7ff3f2226 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -143,6 +143,7 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 	return vc_to_axi_dma_chan(to_virt_chan(dchan));
 }
 
+int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map);
 
 #define COMMON_REG_LEN		0x100
 #define CHAN_REG_LEN		0x100
-- 
2.43.7


