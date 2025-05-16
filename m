Return-Path: <dmaengine+bounces-5183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2EAB9521
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 06:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96B04E7C5A
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 04:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629322DFBE;
	Fri, 16 May 2025 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fzFuKhqq"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010065.outbound.protection.outlook.com [52.101.51.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9622DA06;
	Fri, 16 May 2025 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368388; cv=fail; b=ZkX4UUaGMZHRu1B7twv9pmug7nY2xE+Uv6a4O/KKKnTpP0IdieJGgtbZvHM/TSyw+mksjttf7t3ZL/uKVn1m9Mqx4GiOtOSzWRy2jGu+vN9m8TpCFC24lAcID/uyZrTdTN/fn20SCY9CtzCUWr9raWUkEmhPQEk6b0aZ1xUOWDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368388; c=relaxed/simple;
	bh=RuEF4tjVrKCTD8Mft/crP/uGQoMNQtf7QqTsRqhycZw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nWRLS4+ICfpeSCanWzwXj0lhHfoiOBR/ST8VUFCKBHY2Ebb9Ks5HqVm7UkSJIBA3JPeNUOX/DhJNZnovAV+sDtr3Ku16LA2l6VuDUtV5Mgpfww+38oOjjlDrwryMVu+ciSYlWQ9EyAzG8HGX60LhzvFTv5vLsJytjyvmvxyKFp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fzFuKhqq; arc=fail smtp.client-ip=52.101.51.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1Iq4MrBiE5Xxz7vD9IcUF6bgzWVOzPpyUgqE7GVZdAatuptV55TJaNZjuEcF32ejJxiOXW//1Ckik6QtOtircdt3FBFOnEWFNjTlRaDO2OCFwKKwC0OK/Ye01vvsuHVI6wys4Zc/EqRbFZdmjc91ajIeB3PtPt0+6546ekPRhdxpMBl8S/GAxwXXV4uTUVrf6uyi/j2IXr74fjiGyfJXw2oN9UNKcBxDRVG4EF6iJhs5Dg6Rv98QttOMBat0pU7WRWCRTJrtafgtA96jPzeXwWAdxV0p+1ILBcOgEpdH2zDm4e+TQm1+EiZ/zad1Vc4yaAtMLOKU7AUWmkHJAEYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+k/XAoe8RkWctY647ryLpm6d5y6SN0OKt1EJqdJyMM=;
 b=k1olk1fuWLo90VhD8gHE6fM2NHanSV9cllmgzPNgogudiiFr/8QJQHwIbldZUvR2GCU5IB14FAfAEzfL7VhqeT5ha0eHdrRkOa4PCIublue5WLFbDlbmDLkbgBPZp0MuEGfsfJ1GfV2S2yqr+PWcMGTnQpf9PaHhkLGfwP3RCLtxX71KawODH4omWpLD1rOXFGgAeEhpuH4zDlrUAteRqN+68tnMA+5Xx6fxeFCjL9RJ3zeCZkz3k02xZGCZ/bgC7zLLJDFr4kR1yoOue1FcPGzJkI2xgNya7zMW4bCV8w95y+IJiK00lbZAU7OHhNbRXFHE8514+KF/SqkDXYbCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+k/XAoe8RkWctY647ryLpm6d5y6SN0OKt1EJqdJyMM=;
 b=fzFuKhqqxEsOq7eLG/WI4cuFb+5P799KNxT/JiJWpLz6z/YLug/q60xikGWsBtHdro6LOhp7rcObyBP0MPGwwcFBOjRiFU/b03suFQO/0/NNvdzXvsNPNuXHwYt3P2/5hTUzKylfHlU7i1Y3xfAtTiU3/G6U9G/jmF/QptdJ+p5Sl4kpUKOBEkXpfu/7dTH/uHgtGdfN4vC/AX+JaRPLparx7puM/GWV/R6Gr0s6fdgprgDGViWV9W7wvQFsF5if4M5bTNrZPul4iodmdgdfxeYWqzaXBXCBvnuk93ai/M8urpfDAV7HLBcsK9c66vUt6r2h0vz5LXs10/Uxcjv/uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SJ2PR03MB7093.namprd03.prod.outlook.com (2603:10b6:a03:4fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 04:06:23 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:06:23 +0000
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
Subject: [PATCH 0/4] agilex5: Update agilex5 device tree and device tree bindings
Date: Fri, 16 May 2025 12:05:44 +0800
Message-ID: <cover.1747367749.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SJ2PR03MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 371c5b44-50c0-4882-255c-08dd942f0586
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8FxewK3Dy9ZNAvF9pTiUk5NVlaJDPU+Lu1mcoXY7i4EBFTYCzU0+nAVAu4Bz?=
 =?us-ascii?Q?QPSB9QN63yBfq+0UgMZwUL8tBa/KAkqAFJv52dbj9q93SSFpILFe9dbNy/Z3?=
 =?us-ascii?Q?OS4k+gefZsPSEk9vN+w2RrqfZRcphwVdNl6PsKiyjKiENRx2dq+LH0b8Zulp?=
 =?us-ascii?Q?VpECkFDATZCH/S3AdEk99z/VQ2vZ4EoIbcryYJb7kJF8GYuiv0pJPLNWHSmn?=
 =?us-ascii?Q?/AlSz0Gai+SVzuELOMpsKX61I9b7OQmIugwqZW3yNu/BF4jhW13JotjBFFvB?=
 =?us-ascii?Q?0U/FiNTpqZHLhUo9vmA+xXH+yg1r9GsPqKgQwXPmBxlib9PjDzIVm0/lVa50?=
 =?us-ascii?Q?u2K8ulouLVp6iJZKU1LrmrpgYNoTRxl5Wk/N2VQduxBNf7cXkqc3c7vXj2CM?=
 =?us-ascii?Q?EfnemrhamgZj1LFW6WLsl3vqSPKFhX4/0E8YomSCSSreFUtLQBIjHPeRqPDq?=
 =?us-ascii?Q?UIs4MeMTEr6yOgk7tMoJOAdnKfVTIvXPXlP4J4QMq054dgsd4K1Wl7uY1flX?=
 =?us-ascii?Q?FokVB+a4R0hU9x4+SEy+qf3KRZB/1BbEXJiEu2NAZY+FXRZgnOTsxzVLXJpr?=
 =?us-ascii?Q?AOYgNhTbIdaJGWMgdnte/n+tB/XDMWMHPhLCkOp+x4fKBTr7Ui86DTPFbSxu?=
 =?us-ascii?Q?ta30h7fiwFyBIwn9AdN+AfImAjUzaugRIeZKMoCl8+7C1Ir4R1ynKvy6hlnq?=
 =?us-ascii?Q?xLgDFjBJZ2ookuc+5b/CXBT99HUmnN/TclZxVJuwTjaD7HzT0B8Oa6LD2Ehl?=
 =?us-ascii?Q?AyRgfKv7RBpXb9GZV2x+ucvYbcaFYeARzmJxLdsmKrfd3Cl5/BVsfBwkoz9E?=
 =?us-ascii?Q?/EJtHVu5JjcNmeAMInXaaoAloMSO9sDJHJbB4j8gctF+2DFcdD3TUlx9CL2n?=
 =?us-ascii?Q?QmS6ldxBezkpVzJ/D30QfzniL8w2QKBdo/Tbpo3f9nUMDhZzj415JyLn6pEP?=
 =?us-ascii?Q?5RxVs5RUQFu2ThiV9SZzg/nGEplUM5S8wUg8X6anKgR24z2000c3hVxZvdKW?=
 =?us-ascii?Q?44kwHI/BctQQKqzsFQ1NtFnrZAsx+OQ8B8NVacN1rtaeW7JoYD8gy/Buhv/X?=
 =?us-ascii?Q?bAJqfO7ObK6dt5oFcvYDjuES6yYEjSDTHoAhL5KXfl8foLfPJXB06waX4zdw?=
 =?us-ascii?Q?8u5rhVkhImQz6wTSMU0EOgnfUq1ncr2gHyC/A2Nz6xFLgock7MWk1KbwqHQE?=
 =?us-ascii?Q?JG+otDf/sUWOIy+unvQauvrIrVfy/h7BS6i4kQb/YCMVm5Dxlt/n2wpovGHZ?=
 =?us-ascii?Q?YoqWnXW+w/6wr8Eqj9LpnHhgFer9fynlP9wKgL6UK0SP/XmPk9GZ5W3Fc8hi?=
 =?us-ascii?Q?u1ozM5WDGgi0r09/iv3LQQp5yQJqiop7homKtJD7GBYDbFlU+hx7YLHAN22D?=
 =?us-ascii?Q?qg4Fk36Hv/1HfC9TUA5mtgPR+7H6leht5QPpFtizvyGk4H6MOJ4XIh25Pg0T?=
 =?us-ascii?Q?XtyD+/Cftbo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?libIxUKhNlMf7KbgW7PK+Wnos2QLy+YQ41FvnwVhlsfIOgSJXNB6La/YSwm4?=
 =?us-ascii?Q?61VAlu7ScN562elUBYrInuBYbGSZuISY50F/qHY63mKn/JxEGucGMwZvQQD2?=
 =?us-ascii?Q?0JRrqxQN/yPH8gIZM1E8kj1/E2T8f4UoA4m+vPAP/PIqBFtMUDbDcxnraHPH?=
 =?us-ascii?Q?8UwW7EY623sBLeA4A0MFyLOEIoVO9/ye0fINuM7Ds/nwQg2F78J1geP2hTvR?=
 =?us-ascii?Q?tDmp1tH7+tYBpuI9u2WsUBIK49P9nc4Ssq7emua8/D5oi/woS3fRyXQYyRGN?=
 =?us-ascii?Q?cFy/DWfy7QgSPwPAf6y3lycCdYOm0yL2o3rGEZE8VcFs2VEWL3QcZtUy5ioi?=
 =?us-ascii?Q?WacrrLMe6/H8o0xZ6fe5uuIjfP7Xo+Z5wqybYMy6+p3FGwbKEC9EwW7RgWXi?=
 =?us-ascii?Q?CPzZszfaMEdwT8I+/o3WdYxbV7Ncnssy8ZwLbA4KcZnI+XOizE2KoIZo5wMy?=
 =?us-ascii?Q?7mCtvB8fiJKE6v6EKYetJ8kRmS0/lzyswQyrW3v7Nl5oKJm/QVKmYhXlpsW7?=
 =?us-ascii?Q?aBTaPpnN+f5468q6r64gzsuwAd/noJzZIngP3FFwnafS47coMQKa8idAuqef?=
 =?us-ascii?Q?eyBhBm/aRvvSot9mxy6Wz19N+ePhGI35heeitzUnaybRccSYicIE/UOxUakS?=
 =?us-ascii?Q?coWIKN/wnoDvRUf6s4ozPbPUr7sMz2z3ba8L1HQn7HF7TMDjPojeLqC42sBf?=
 =?us-ascii?Q?gBq+DRKhxXBRpYJcK1qNBZRcqed6+AT980TXe9U/x/MgCQDdPTG6XWlQvZFt?=
 =?us-ascii?Q?8Emiq7cxUILyfac78YVNUBliBPDqBDQCsJbut86Co08q2gFFrzr+r7qi3dcx?=
 =?us-ascii?Q?e0M1qlbOCNpT7gzJojDpbKMdXrpn629gKXAY3PS/bU4nuqqRPbAJ2cYreFHN?=
 =?us-ascii?Q?oK4qXLtoboHpwaXpOZYv1yHcsO3+cUkV3zklmPpjdIezNnPaR6SWx4agRRV5?=
 =?us-ascii?Q?8D6UsN4Lp3cQumVuBCrlswOVi/et84O2tTL4ggezgTiH7XiMs0B8zIS1HkU5?=
 =?us-ascii?Q?rOWnmFUl4WC/NhKVZocHyvlpSFvYRBX0XlnS8WE2KK5ADoBE+ptEc87lMLN3?=
 =?us-ascii?Q?rh4st36Eh9LIkB6j6Igjze28OJotQ2qHYa01X8KDkRHk1A4sQtRY7f1kPE/q?=
 =?us-ascii?Q?pg0p22ltGGWHdZmJE1RO5yIb/Yda+XOG/68mK58zxlT8gvtqOCbuq8iPbL+k?=
 =?us-ascii?Q?jAGmnoh2gOHwJIvOYaFTTXHQtXWYbOESR4ark4HvJi7VMYVAIl+0pu5uyTwA?=
 =?us-ascii?Q?IbP1R6ONWOGApBxti3LgzJCzxRgtPxCzYfnOEbk3yeGO64m5xgyby+gmc5QS?=
 =?us-ascii?Q?RVda2elaym/JY/euBTNM/zNgdA3lkUFb9YCH5ZYVFFhvLWdNudXyTNtgeP/r?=
 =?us-ascii?Q?CmXV+ModxWY5PS9cXCcW3o2N7cd2pkBW1tmFdwGn2LT+yGgnbmbeb73vNMex?=
 =?us-ascii?Q?ipajkSrPzDuUDLYZjoMAUhnkwOudX9tE5gl4kaLoL8nC+U2DKk/tvmqgq7dL?=
 =?us-ascii?Q?1W5NYYcXnPM442+V2cidnUe9/pB3817FGgFThTYtf3UooFtpmeC4lXg6MhFZ?=
 =?us-ascii?Q?0RSuYTnJdKPZrbKRWt63zHETMO7aoloRn7VtnGWciX935Fm49XPwHE7BotSB?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371c5b44-50c0-4882-255c-08dd942f0586
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:06:23.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FrDp5bXrlHH1GZc9BHFOT5tJX6nasNCA9plns/WhN3GDXu/cehHX+r4IYbfPG4snIoZJBNVULj3OaZJqRpL0ayu0MLmgGZiZl+pThtn32U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7093

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patch set is to update Agilex5 device tree and the related device
tree bindings.
Altera Agilex5 address bus only supports up to 40 bits. This patch set
adds support for a new property that is used to configure the
dma-bit-mask if its present in the device tree.


This patch set includes the following changes:
-Add property for dw-axi-dmac that configures the dma-bit-mask to the
required bits.
-Update cdns nand dt binding with iommus and dma-coherent as an optional
property.
-Update Agilex5 dtsi and dts.
-Add implementation to set dma bit-mask to value configured in dma
bit-mask quirk if present.

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


