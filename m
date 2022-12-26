Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA9D656088
	for <lists+dmaengine@lfdr.de>; Mon, 26 Dec 2022 07:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiLZGwY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Dec 2022 01:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZGwV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Dec 2022 01:52:21 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C510DA;
        Sun, 25 Dec 2022 22:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bsqjzg8zh51mbnzzncVArilLaaqye5tG2DFJyxbSyHaXEHK8SMt+if+XKriabJmWfL5FBHr97fsHxoQiTylH4L4GWMD2wN4Io9hx8XsX1tMZgQYMNz3/nF4Volkbmi8z+4YRYA7ytefsKfu9/2Se49I5jTGui+uU0QQC3qQsPL7Ck7LSOujyeV/2X3MILqJY056O+qBDd20LDABchr6OWE/4CeqSiYfWVJvzDZ4ybThz9hUyiQnJdp9TpsRAK62xay2krfzwhwX3pW+A/IXT4PVitT0xUmNXNSheN7eMnU1HJaJyAZ9YsomTKg2mkKbqNe5zdTIHpxoYkX4HcUFrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd7T+mqnPRrhTZ7DvPkEYrArLtV+CdFkbxNcE/iBysM=;
 b=Kab0m+IWBFHReKEQsNwZyRj2f9kzlCOZd5yooNYHk+UjW9QB1utUMVwFYfpWK8pBtLq9C1pMxCjAciOMIEkPOF89M1rY5QxmYJaKk6WfSa3Rc3bOH+oLPWPqnpQYefB+o+akWz7yEmV7ClpN0Hmrsfeh7Bw+PCbFKgEgScwJ+KhexqsPZBeou4k7jlk4tpANwpFycTedZrwZ9CznpM/bqUFuR8VEQzUfHz8Cap5cEdOwfvrpb2CPOg8HZ1e7myWzn7IvAoh0HwBnA+j451opYsZGvUd2XJpkqNaGtUp7j+IzJ64krc58/4mI5i6XdvM0CR3TW3+ZN9ZJRpfcXIH+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd7T+mqnPRrhTZ7DvPkEYrArLtV+CdFkbxNcE/iBysM=;
 b=LilMSUKgJWZja5xtUb+ZLTBc1qWJkpcDm+0GhMI6CHBaary8Y4SUJLHuavg/IOVNTX2jW/N6YZ92n3qASrRWKXYVOMZtyQym6ZQ8abg1s/iv2K/bLdfdaRh6GJCjbSiG9uug/kESwC4oqfWHoTDY/xCnhfNFepRwLSwq94d5k74dcmtxhivAhcJ7sqKebwr65ZuBmxH6vFcoekHd4zkOx2jyViwG81lV2C/dhEeYJU0E0eGoLdD95GiUCJSBPYHyIqA4DWVKbHBwK9v9KvIy/5wp18Sc6YJ1XOV6nfgDVQlhc1AsbuJzUBnf652rD7gOKNYXxE5jT914+Hh4qz1gDA==
Received: from BN8PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:94::28)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 06:52:17 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::a5) by BN8PR03CA0015.outlook.office365.com
 (2603:10b6:408:94::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Mon, 26 Dec 2022 06:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16 via Frontend Transport; Mon, 26 Dec 2022 06:52:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 25 Dec
 2022 22:52:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 25 Dec
 2022 22:52:00 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 25 Dec 2022 22:51:58 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable-commits@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] dmaengine: tegra210-adma: fix global intr clear
Date:   Mon, 26 Dec 2022 12:21:53 +0530
Message-ID: <20221226065153.5558-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: efef74a9-76e3-4dc0-b871-08dae70db9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udVEwpHvG+FrhepBOwsJb/zl8A6Skc8Tokchp8NWfpk0rvyBFKnD2hlCDZNHKHU/rcAzi52FN3U8Q7gae6VCTV7rQ4t5P+HKnDXpn2w2dqODDPHaqYtpzAytQXKRlWBaa2Ii42qLQP2fRg0TH5taHQceY0tjtTDQrclOcb3GtTB0Y2h27Ib5CLgSe8D844cBa3YGf72E7g1aKL+gqPfDsE4WjAmoPmmjg5bY4kkJhyH2e7lpXVJJ7BmsKmTpMHfUMFAhz/+9hidbzfmpfi/nIN6Z6+6oN08Wz23ffQWtCZUPK05I05axlUJ11G7JDzS/6Iop3A3xbPLZLC3idVmpKkucpE1gqdvZbWzwNQCVI22re4uuBXXrVqbjCNIlejhW0/yH9w7KupbJXxyPdD6TWGa6IDQdCv2VJryqFkmVC+U52PV4KYlzplmfkz9+CZRpiXF7U3VlEWUCYPTkkU0jUTfHP1GTkIJQU3njWzTSZFf6VRmEnGfh757Hio1iOwW5V6jlwWdebw/xZv7MKzZwxXN5XwIplv6Y/TsdLrdWcr6eguXbhO5OvkN6smuBDwfroI3cnoATnQ8SfdvZPz1vpZ+1P6e9niB8h9vo96Pz7bl7gDVJVUZ6rxBI6u6diiAKHPgjXb0SNNSq47cHxyDlnJyFfodN2/0eu3SirIOrqK3T53CX8qodaoDgPG+mvUWsC9sUGwZONKeWKWOYyNREbA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(8936002)(8676002)(70586007)(70206006)(41300700001)(4326008)(316002)(54906003)(110136005)(186003)(26005)(107886003)(6666004)(478600001)(82310400005)(356005)(7696005)(40480700001)(2616005)(47076005)(1076003)(426003)(336012)(36756003)(83380400001)(7636003)(4744005)(5660300002)(82740400003)(40460700003)(86362001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 06:52:16.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efef74a9-76e3-4dc0-b871-08dae70db9d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current global interrupt clear programming register offset
was not correct. Fix the programming with right offset

fixes: 'commit ded1f3db4cd6
	("dmaengine: tegra210-adma: prepare for supporting newer Tegra chips")'

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index ae39b52012b2..487f8fb411b5 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -221,7 +221,9 @@ static int tegra_adma_init(struct tegra_adma *tdma)
 	int ret;
 
 	/* Clear any interrupts */
-	tdma_write(tdma, tdma->cdata->global_int_clear, 0x1);
+	tdma_write(tdma,
+		   tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear,
+		   0x1);
 
 	/* Assert soft reset */
 	tdma_write(tdma, ADMA_GLOBAL_SOFT_RESET, 0x1);
-- 
2.17.1

