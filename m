Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68BB3FB332
	for <lists+dmaengine@lfdr.de>; Mon, 30 Aug 2021 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhH3JiY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Aug 2021 05:38:24 -0400
Received: from mail-bn1nam07on2069.outbound.protection.outlook.com ([40.107.212.69]:10657
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235839AbhH3JiV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Aug 2021 05:38:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANryIouSyn9kcN8DRjEYdkXfJY+WfTP+okktUO1rg4BAX+UsGlazYcDGwThA22pcpqJ/x7p1TGKtHIHq8Eu/SKwVcMh3KVTN9aVkDBQ0YSgFahau0fNCtDyLiGykGVz+7eVytBcjNaoR4V3bT/Zie0xHoWv52DBelbHDKE5pJxARiGw39Ut1FB3fp1KD3QLO7SilVFwafQ+1b+BJDDdQAsafMiqd9XUPYVmHNK6EFgtLcpL6ZLryYj22pC56c53wjmg+LREAXqvnNkXWOZVEj1jYuFwjrkWqwATP8Wzgm1D31LoHFbj+TTQShRu5uKeqvCYcEHhqzGGdkPK3z4/dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grzgjKM00vgz83vYDKMdbVU+EN9O8y0EHhQGjbrKRUo=;
 b=fmLPpcRUIPjXgpoSXdXQvxLkKDSKlHzw8LWRj/6QSDUtMqTH+QrwPzFfESjgA5okInVJEhNHpzK2BmQ/QKUj4x2Eq49gTqvkrxHQZ426nhWMYeMEqd0sOdrJMu0IUZlmwAeceHlaGgnytOnYvoSk/Fv3R/nqUmwn8NKPMRGiPe8SjWik6RU2LqAMoupisx4NYmEB1XhrDJNJp00yQTK8UsCq5Ens4xzVYKRk1/19DNbHFQ4eXo23meio+mVwBvp+NOkluzK8wHWd/OrQktvW1a9tfHFCBBrfbijUdz61AloWFeQshfTWzj4pgZnDWn9XkhEW30MYPv9QQ8ZoSKWqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grzgjKM00vgz83vYDKMdbVU+EN9O8y0EHhQGjbrKRUo=;
 b=PuLzDDUI/EnlHBxmDNkiVTSPNCFxVBjPi94zFuwFFX4pJK9qBbZ4DI6+cH91uGkAEXgNiU4VqzGn2WBuB6V1UnH/egFxjNxdN9Msl4u/TLfaG8ZIQjccvVXL5QlRalHvSwiQru6x3gEs2GupMKOzn4bgsta6cnZiSEEromfr+Br8FdcYEnbVVYh0w0OnlHgxrH4m1MyPlQMVrFTz+4NgiFELFKq9wdtR2kN5oBDnhL5o9hxmI7xfXyCdGexej7ys1SqpolIYQPrqkIIgG5qObzkUFNNv3IeZPUdikuoGEdph2FrvogEc76cxbIi8PyJoK1GlERep+eP1+XWwH2zgOA==
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by SN6PR12MB2848.namprd12.prod.outlook.com (2603:10b6:805:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 09:37:26 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::97) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 09:37:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 09:37:25 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:23 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/3] dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
Date:   Mon, 30 Aug 2021 15:07:00 +0530
Message-ID: <1630316221-9728-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
References: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a692182-9e1c-4d65-c34e-08d96b99c760
X-MS-TrafficTypeDiagnostic: SN6PR12MB2848:
X-Microsoft-Antispam-PRVS: <SN6PR12MB284877BAE23F930226F1783BA7CB9@SN6PR12MB2848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+JsdvKTd/fpzJKAwccBGOlIjHAKrXrceR/luB9ZSz/GYIWRdmbDaWU3npzZ48lCsmh4oqrI4zmCwPfaeDwQYb5F8ZJwd2P22D1axT/HbQC6unZTpgMbCQ5DGo1HvPvJBdf+2u8aNTqKAnnkLOYHs35C3FElD1QSvj/GU4NUDH5AGfof+VjHrbOlDUkeYE9KMdRB7OALajqQ6cO0wI86sguU76sJ1RpJNRWxzyjbRS+z4CDYbB+yFvpEIt+SDtr2ELP7/gSfQBTIGTZwwaXEpg/zURBjSsZF3sfDtMM3UEwWFIhTpcWjYBX2t43Ehg5EjSEbRxqul+ukamV2TophLYgBskcObLy7+nat7MFAlxMJuv3ls8eSXiRJO/urNHCfcxTCrQHswZBKbD/e64pC+e98BrlIZap9HfG+P8q1FpFyvwGvJKOtmqCy/YG5oIS7cZQHyYloFpszRs0+OoU87WlD4OHXaYqg7QFatX5aRllAiJTRvadwjO+COBsm0VzJuLGAh8N1cWC38agh1fLvclqoQLmI4VShhVtGl1yrxU9gOiJINJZAqjGi26p8mC5gXCXjWe/QExDy9uCBEjjpPr8ZGU74gYE9VM2rmOj40xzyjptF/Il6AnVvoVGIIwrqQV2sd6e9zGGkBZAIfX+YvVZ1ptJuBZjlZzq7hqqaHqdxEUNjaDyJdTkFTvOuGUzxbJb5wN0q1lEk96iN+8TScg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(186003)(478600001)(8936002)(8676002)(356005)(7636003)(5660300002)(426003)(336012)(26005)(36756003)(6666004)(82740400003)(4744005)(2616005)(86362001)(4326008)(36906005)(82310400003)(47076005)(2906002)(54906003)(107886003)(7696005)(110136005)(70586007)(70206006)(36860700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 09:37:26.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a692182-9e1c-4d65-c34e-08d96b99c760
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Trivial change to add description for 'adma_get_burst_config' in chip
data structure.

Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index caf200e..03f9776 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -73,6 +73,7 @@ struct tegra_adma;
 
 /*
  * struct tegra_adma_chip_data - Tegra chip specific data
+ * @adma_get_burst_config: Function callback used to set DMA burst size.
  * @global_reg_offset: Register offset of DMA global register.
  * @global_int_clear: Register offset of DMA global interrupt clear.
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
-- 
2.7.4

