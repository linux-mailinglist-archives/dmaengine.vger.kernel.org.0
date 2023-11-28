Return-Path: <dmaengine+bounces-275-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD787FB275
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240EA2817CB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E012B68;
	Tue, 28 Nov 2023 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5ae8C4O"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B92D4D;
	Mon, 27 Nov 2023 23:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYfLJPVd0gEzBlh4/3G219lYaLh8DdoWmdpYs/SeU8cSfuIEU6+OLB+NlBQF7E7UH6kaZjrqU+mAI4oasa+v2lkpHcwZBuVjWOR1zg79XK01lwT/1V7Jjj9OyKJscELWcqd8nZ4htPcIEw3eevexWd5ZzjhljWbzKKr2F0y1zAKdISuqp6JtENV/OIfyx35yaDuTCIb3GXNyGRkUPhOnSjVj0YQRR9UdLaB8fEe8US9x603DyrBU1cjCAdG01vJvSxZTUY5ZC/cPV2J9f9TohXiCZAM+9vtQcGpmOttCmhMUQ6bWtxW7VrbuK5TXdzZWIexA4htlDg/RL+5FBpUG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygWkM9lBTvadhaknAAHh75XDG2IxLWDdmnNiagWQ8nU=;
 b=Hny3qB80LuVLDXxT0FK4Lvt1xneaM+jocR42VgEdWB005pI4jfj2+ylixe6du6Rkw+Zqu5L75u/hvsv98fHbhOTveYK3R7dDjaANPd6EKK1CR5M2WwSJQjG7yvKGy02kqPjJ2rgQfYg3qNzgEoIyX6+y82fLnnvR47pxIVb2kNBvvzDv3NL7xiXnVH6FQT20AgoxP3B8tfCbtHTnSp+JmOzKxITT+FJkhgdIqNCWgvRfdZqjXycYQhLLyhkRwTi5TOuX0WOU66I5vxqgaYjhJEQRIfB0um39r4B6g77x8P4ebQMUV8llKuVQ7bUvy/WYYxVVUWKBuFEq+83YXrVzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygWkM9lBTvadhaknAAHh75XDG2IxLWDdmnNiagWQ8nU=;
 b=t5ae8C4OSmFPlMq+YGOuRSK/mriHDsb6zWqgDL/eWlJQyPBM9zhuR+90jXI0TCdp3AGbdJBT4snshy1oM2+LerRYobo5RwxDfRWn+WjhyHM4UhBBCyjSvxcVxYDZL35+fB+tTIJ8dE8nVuIhlEB1kQHfhyBWITqYC8haGTEG4OA4ygLE0MBFwgdNqyY3bJeiyaDpNIxmzeh0V1KXPuGAnJ5ObFqid8a/mORRMfWVa3oklKByPnYCyVeUJaEDnXGNMyHllD43To69E2x60lE/94oeGJaEZbQ32ATxOFxbcO+Ygo7SbiEg2K7/9SEC3i8QKHy9PnhQpwDDI3LYwhcFjA==
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 07:16:36 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::8a) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 28 Nov 2023 07:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.1 via Frontend Transport; Tue, 28 Nov 2023 07:16:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 23:16:30 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Nov 2023 23:16:29 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 23:16:26 -0800
From: Mohan Kumar <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohan Kumar
	<mkumard@nvidia.com>
Subject: [RESEND PATCH V2 1/2] dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
Date: Tue, 28 Nov 2023 12:46:14 +0530
Message-ID: <20231128071615.31447-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231128071615.31447-1-mkumard@nvidia.com>
References: <20231128071615.31447-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd30e5f-1b92-4681-3189-08dbefe1f508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HFYxJRfIegtHtg6guf+aLiALWvRl6Bpr/WeZgXj60TPtcQ8Iz9+u/jYLMkXBqOd33H/WlgYwDgcaHhIO72H7lwDC5p9K9sLYu07bqp5oxgl6sX0vXaxm46Q03noMM5XRgaHAau3fqfKyvZkBmMWGyskNbcTsJGxBnBR8PegMQVX81iKGbOmuV6qweJJQABxFoC9Ae0PCcL1E4bOQoxFtF7bcC3zZS0aQR+MndsJmp7esH2DYQsPJbV5SVXgcEeN3Ut2hOTZ8qM2sfaXu5SjiCLKFSZtDc6MZf14Vwsi4TeeAzI9/E87b260z/UPDbGdUeOzD6I2MUPqpcYW18t4/ZoSOad1j1uHSYkFUxbE/olQFdsxrupWwAFeakSvvsBoq/jA0shXdNgnbGHXbWD2AP5moa7knuc+5kiyVa+tpsqsUq545wFhVFCU5B57GzvkvXgpi1XeIoMcNHZChGQWlvumba6KBvkeQHoLAWTzjDxG8uVYf15JgbDFM+zjFpWZZibPQxfEuK1O/kYNbphDzrKteoFt41dhw77lOxDhJJ6mmp48UwEBiGmaIgInejrQzLHoZ2oFUKXkie0pD2FYz3qql/PCZ5UJHBkOlZUZJBekID8AqiBF9/CUwRT1dwJHFE8iQ54sqFbd965MkKKqXUJUyD54A63U5s1iDS8fFlN4lfofwaNvmQ9ZRK5WcdWatTkMcCkEkvdPrfk8928RL2x6AlP+LQ0eUIajttH2E0svUDNrwBemwyJgU64DQzHT/
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(356005)(40460700003)(36756003)(7636003)(478600001)(316002)(54906003)(70206006)(70586007)(26005)(1076003)(110136005)(426003)(336012)(7696005)(2616005)(6666004)(107886003)(5660300002)(4326008)(4744005)(2906002)(8676002)(8936002)(41300700001)(36860700001)(40480700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 07:16:35.9910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd30e5f-1b92-4681-3189-08dbefe1f508
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330

Add dma-channel-mask binding doc support to nvidia,tegra210-adma
to reserve the adma channel usage

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index 4003dbe94940..877147e95ecc 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -53,6 +53,9 @@ properties:
       ADMA_CHn_CTRL register.
     const: 1
 
+  dma-channel-mask:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.17.1


