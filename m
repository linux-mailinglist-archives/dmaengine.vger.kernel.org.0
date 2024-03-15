Return-Path: <dmaengine+bounces-1385-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA387C7AF
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 03:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4404128298C
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C06749A;
	Fri, 15 Mar 2024 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RsOq1h3A"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2050.outbound.protection.outlook.com [40.92.23.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA7D26B;
	Fri, 15 Mar 2024 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470997; cv=fail; b=paBbkpSZtUFZ2GIN6IG2ajy1y1DsUcAfg60MHue4EILx2sp+NsNplZSKvG4yqdODX3h3xfUda1aHEXnJXgQhdLQdQZ+f0pUiSc0WJ+h7/dMiZ2YufVhGWZOr4kfmtYIDorWmmJ/O4hGxFfZaWwCbnGF9Q/D34gHBfaVOlgpQS5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470997; c=relaxed/simple;
	bh=iiaHXj6XSmVYIAgAs9qMY0SKGfntnjuTB60IzE/QxcU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=elRBTCrk+XRI/SC8Nqyp3qcLhl7Gpj2/79bVFr+vz5JIyFeuD7KtcQnkrHQxg9BoNatkgLiWdVpb0VBOsziw+B0tvQVIRgKvi3KQSsSgsxMqa/z2+6eLTKZQSNsmdkr8YWiGTaWv1K0/esNqfikG/FJyjDkxrlUO8tVwQFJDvcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RsOq1h3A; arc=fail smtp.client-ip=40.92.23.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRU+2tIuSaLzg0BTyYHIzDiTSELPBMsbS3uJQSGHl9ejlR6W5XDzPTNv3vY8vR6srX6covw+EpIQdUe+4ILt0cCQgh+Z5DAlZ8839E82FvERevlzw+zP1/teoUG7BTHv/2dPxAO0mPC1xuJDbuIScK2pPITGyPNklhwKNWDZcV3kOiR7s3qQBnBXUscblyIMoMpUqDH0dbiXRI125MYQKi3VFopFF7ctB5xenS1ng7ls1r4KgDFM6t44faOxIRwgpkNwn+HVq32HqTTtBKcxiKEBTFHIyjpJv4+WBlEGSW9QhrCdfOW/vloG9OlAfI0bZYjegQiKGGPkf8e52aXIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++HTRglb8IQZ4xqZes0LCL+1/McAGNYpNXaCnt7+Z1A=;
 b=ZU7El86EPAoB0Ntn+jzoUcxTQjJvi4HXsdkyx8ea1z/dFIwqsB1pBABM1mNovfuYdWRslVnZyBduV0KckWPtUlv42UMcRcCwb5/Sc9w23pueKz5WGqGhQPskHKEVA3CP7UF3PaXYYmOZZWGjiYRYw5Z2C17gm52xooM1fAsWUfUi8W0nj3BOYf11Vu/78f0EnX0WWXtTtS6OkLVlVid07MF7Z3+iMvyXhNnvAH5C7B8Cn1nETPKhuxw5wo8cqGpQjuiKpPmBzPIX9E/4N/3M79dXfZ67W1yKhsgyjqLV0UeWibFOqehgCY6Asdgi/gS4HeOAk9LdcxUC/rJTI9ceSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++HTRglb8IQZ4xqZes0LCL+1/McAGNYpNXaCnt7+Z1A=;
 b=RsOq1h3A7Aq4IvPi0Kh0Mtiw4U/v9leMcgRJcVa2gS7sboiwN976BvQzI3B69ni8NUE3gUEuxjnTZHrFj0XwnOH7h9ejo3KUXdiM0mq2KelGI2WxfKxKf9btU6sJXn3gl6R+tLxEH/8CuigC8LqYDG7i0ec3geBP2Rhq+hvmCJ3ENhuvMFpwfxX87uzZPsNLPRrjic4ETfPt1K+wLstoqsYv0ANdE+CRbTlkGnVtm4DQji8uzkwAfTqOr29IIMVbxS+o954sr0sq4CreFvb/fVgsR5N19yXHhCW02oEAAKVHW5ix6555a+xME64Pkf70YZNhZN2oJZ8PUPapp/+PYg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB6264.namprd20.prod.outlook.com (2603:10b6:8:ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 02:49:52 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 02:49:52 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/4]  riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Fri, 15 Mar 2024 10:49:18 +0800
Message-ID:
 <IA1PR20MB4953E7BB0B270157C8D1DDACBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RMTaEUju1Hd/8fZly8umHH9+L0ArM0byaDcpbBNYi4c=]
X-ClientProxiedBy: TYCP286CA0186.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240315024919.515354-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 6009b91b-2f06-4f6e-763a-08dc449a96b1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1p3BB7+yLoIzjclHsEdezOXCQAnm5EO+v8V4kWR7ojj5Op8bhxeV/kjbFrTJDsx7oBkYQtS1/7BdBlYq0F6dOQo0zvOu5ypBuSSOYjcY/PrFI0UCTcnIl7CO8pA4850q32rQzW6SxH7pQaKz/w9thzhSjm0R42N/lsrZE/GJnVrT4xjY2jSYGgCDhDk9lwKyhRrw680Yp5ontKP+i6xTPPcOVC9u/oIzxrbsWgdNfNLGRuYcpXoElF1etXc5AFCKgD30OS1tmGsE5utK9G9KK/6Jbn9cXEwz1W5zkeDzbbzmZJGS1gPnNaBtx6B5VB1TnhNe/aMts2ykXmszyLbyoJNaoU1/byQtcqnDq3oWVlQsZGWAw0QJ9sZXKccvYl3Gpy5jsq2RVVW11mlxHZDp25UMU3gLVN/hKoAgFXbRwQRLy0aTeEFrWAeF9rNRVHvwhQRz05ePPzFIlDNwDd4jdR1KJ1ZWTH2LYuLdYCOoQjsBZAL/JZfApwp4ZmQwEb3507QqPbIdyY+cvxmeoKhN6nwGyhigQFZ1801njhc+4f2kFkljbsHs8jOHl65tPR7lgRQVEwCDlCkEUAW6XB0HWxgXriPpEdFYq3/gN2qqcPCkspS/88WK0UAroAhu9T0oqS9/hB7i8cA3+jJMjXOdofVK9BHasYXm2Rwy6qfDzoEDZH6n8M+1junn6VeXbfFH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GXAYvrNrAQMZVa2YMcBzeEVKmqTlE5L1LJ6g9UMbsfpErUE27re9TsgEax7N?=
 =?us-ascii?Q?KNT5vK0RFAMAL05N/M9U6wuXoq2NDGUcxaSUiy0hVAXynORbYhtCs0V/9B1W?=
 =?us-ascii?Q?mn6EPAq9OLBqUlXeTWXacMIvCyOVOUdp2PVst6Q4qNNH25MBcaAruPbWFf3c?=
 =?us-ascii?Q?0UrlZE+mq9mSahcJQvfQIP5ZhIq2rRgUds1EnaVGW1KOcJ3V1OmzYw4v1gRd?=
 =?us-ascii?Q?lKydGf6XHU4PriFBNd2VTPBsPWeP9p+LkG5N0c+/tgyF0V3gt8F+o6x1XJy2?=
 =?us-ascii?Q?OdMwj8KvaWgZkrsruEFctjzSv3SEX1yPecK6xj96e3992nMYMs0Xwu7UaMgz?=
 =?us-ascii?Q?bULIEAu2QxC5zYK5Ir+gDpuWUEq5nINC1rU4DwyB+vmCn2WBvuKltgQ+84aJ?=
 =?us-ascii?Q?cj/h2NloQSj6fLmbbUQqNXI2mxdGyLOBkVB4A/8WhaUB5RGhXSrTRWf158Il?=
 =?us-ascii?Q?r/uNVjxqTLYrxaP78A4msCnaKhKQZufM6xKZD82+VvTRIvbqqIL8ZbsZxUBV?=
 =?us-ascii?Q?uoY+k3SHJv/B0dxgEootTCAFIcXHUy83IWQWLbgrtUjcIfq4NU2J774gkg86?=
 =?us-ascii?Q?EPe1ZjDvqB5ZyKTzK2UkwVhDXSaR52qkTvsvYcrovnKU5AKVSPuqQpdiCX6W?=
 =?us-ascii?Q?woC9XKDl0kC3gaCAw8Ti9Fn+MK5mFSC9p/61Mfd5YmBac35pY8x0gHS8uDGw?=
 =?us-ascii?Q?ik0DPFMsuxfvr+gKicHMBFkesM76DEMLCPgSHtdWciNOtKyUdjBUuhhfxUiE?=
 =?us-ascii?Q?Cgg+DV8CTpxhD25x+9dRm9VB6/y8y/ivna5OX6iHEa1aBq43jKVCLzm53DyN?=
 =?us-ascii?Q?AYayPpIPZu04MfKMrQZIMXdxXvXJikZLaZFN0NMaRAcfTrzeU1eOZzlFVWQ+?=
 =?us-ascii?Q?nHYoxA+HSdZsVQygoncJjqhHtKyS8J8X1LqE698L8L/boDt1KK1vtfp6qaAM?=
 =?us-ascii?Q?XAzxYncKLcCFsMFPaNeDZMYiAHowRh19XqNPD1uHEbK815GqfpU7284D+y/G?=
 =?us-ascii?Q?w6ZXEyCiHMVcoDDUJuAWb58Sa0IBTEzHj4L70kLPDi4tbKXvE5QIbaSWx5c7?=
 =?us-ascii?Q?43ur4Bof8gNMwWYXJycMKOv9vHxMKwtS3gXLVuF1nxHCOIIQDQ87z05SWhtJ?=
 =?us-ascii?Q?KSa5GMKNNCZcwGrXFNRVuxcU+Ka6Si5id2BVXlSa5k/Z3pU5Rz6csi5ZvR9k?=
 =?us-ascii?Q?wyU5y3x5+cYqm8zw7oESD4P8XMTaayy1Ry13lDY23LYdCH590wNVr+7ZtGdv?=
 =?us-ascii?Q?FV+DLOYYC/V6P/lAVVEQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6009b91b-2f06-4f6e-763a-08dc449a96b1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 02:49:52.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB6264

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

The patch include the following patch:
http://lore.kernel.org/linux-riscv/PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com/

Changed from v2:
1. add reg property of dmamux node in the binding of patch 2

Changed from v1:
1. fix wrong title of patch 2.

Inochi Amaoto (4):
  dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
  dt-bindings: soc: sophgo: Add top misc controller of CV18XX/SG200X
    series SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  44 ++++
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  |  49 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 232 ++++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          |  55 +++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 +++
 7 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.44.0


