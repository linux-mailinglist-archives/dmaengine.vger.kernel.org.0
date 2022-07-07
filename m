Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E456A671
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiGGO7C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiGGO6Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 10:58:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B7564F0;
        Thu,  7 Jul 2022 07:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8JoHqyH/4wN4bsl9KR8t2Iph8KdqvOi4LG+sH7MSXnU0ZaBy2BsU5ZoDEsbA9Y30cjtSQHffYhAxXWqrEsgdNL/euNO9cYwT0J6CzNsMAGwhAbgissQC+EsiWJC5RXisgrewwUtU/6BS5HjRzGZElH8K+6RuBTt0nBscPeTcIAr8QYVJtdghqhMs0Y2HbAfrBzeJH452cGpeb0ucQpDmeDJr0QTiukk07mJ2D7vA5J5ZExQhzFFSaXHGvYyHsrrZDt3oAKM0SiOFZA1jwVwI3/n/MEe8RYE3x11HzXu7wBlTaPIEQfqru0H+EFTSvKkOrQ/MpV32FM4k0uOZPB6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksKAQuV2Ap3SOQbtAa7geciJy15Si/B42n/BPU0MkOM=;
 b=OUQtPJRf7UCEC/OB8TLRSVTSMW0RzhGyiU1JlJFrtY1xaeeOPFFZ9A7fs0qbNdhvC3tcJu582sNqjmh6gxgmR+PcT2ezk/fnA/ME0qQ2mAKiEyEhWCiP7d7rTg2ttRQ4+ooI+ljGypVu8JNYq+9mTEt+UL3TjlRExV+gMtZfbZ6Kb0wbFnEVYZtcZSQ5OH76CsUeDqkHhckOebslw05C3sDfhpH+Qo/D569Nb1iopO9aL7Vh4O2Vu+y872qD2mbp8u3JEDVKHdoYSlZOy5K/bASAHx1Wd76qYr/Ekk9WaZRkrhpmSa67wCXwsj27SeFaH4gqCry1U43r3CkucBjPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksKAQuV2Ap3SOQbtAa7geciJy15Si/B42n/BPU0MkOM=;
 b=Rh6eM9IINixvwFG5j8tu00TpioozU8mjQtxtnlzDJclYpPtU/Pn92Tm71MkWcLmvH7b2FU5myEYnXCZK5aZwXSZmipIfi24Nj+ffN55Nkrcn1ChRAuM8ZJ7Vd00/TfVJXKc5WJQSyvUrXm7eEjGbQPMniJXd7iF/2KtIQoukuAruG2gWlWhVujUlQXO9P08xMdejN4O/Jo9E3ZIE24fWbyVZkms3xXUWQRP8HOSIKAVzMWRm9rySPwFdeynMMA4F5UX33meqMj3u3N2deBB5Xfl4W1I+2Mm4vpzFjy0/K6S15U2Ob/Fk7elhm7C4q7l6OW97N940EPJcGL8RheLnYA==
Received: from DS7PR06CA0032.namprd06.prod.outlook.com (2603:10b6:8:54::17) by
 MWHPR12MB1711.namprd12.prod.outlook.com (2603:10b6:300:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:57:54 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::a9) by DS7PR06CA0032.outlook.office365.com
 (2603:10b6:8:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 7 Jul 2022 14:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 14:57:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 14:57:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 07:57:52 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 07:57:49 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 1/3] dt-bindings: dmaengine: Add compatible for Tegra234
Date:   Thu, 7 Jul 2022 20:27:27 +0530
Message-ID: <20220707145729.41876-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707145729.41876-1-akhilrajeev@nvidia.com>
References: <20220707145729.41876-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac39e963-6ab2-445b-366a-08da602911fc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1711:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTj25w1HQhYFjjFv7qdSMzrTDgAtLhVpNV6IK8O+ihMnjWMMJX7dAcB0qjifu3FaR0rwS3CZpgVRH8800vLPffNA1P7OpgcbI5ciQlk5hCKOsqRGxSKdNu8Gy2Ko9YrUUrMuf/oLpvQvUuIRm4q9GNn7T52a54LOWcTsrcHSbpw5MxcW5tW/0LltgiA6OlQxnPGPrKjcVj0unz5yJB+GnOWKMPp9OSj/iL63YIniZVmG2eR01E9TKHgnagaxaD06KQpjxOE3uBSmaG1dtJQMyO+pz5dIIGQBizPFySb8VIivXtJmQhiM/3r+Snfsr3BNjTFW9iUzxklmAAFY9n+CIkTxLVoB+OVQgz/zGR+OkQdnvQYBoBIqyI4mNkh4KM3No1iqVoSvxVXynUhPQ1NSQDNhhR6Bpw4kgeplbV7zDkf8jb5wt1w43SfVfzwS6wAi1i33uEQ2O8wG1fgjbTThJ4mseDlcTLJmi1A+ADBZj3mfLs3L9/ATtv+Ifuj9tlpsn8u3IVkDce/xbhrBM3V7Rw1jTwtP53lw39TQtlhXyX2eqdMYYyILnaiLuHusSnZNAFP/+Jz0UT5g0zewybs1mKVkfCOgCmwPhsxQfWv75vL12/gOOhi0e92CN9m3mA2o+xy9mXp7nYbc9ly8fm4BQJbyeeDxGbvRQ50jyX4Prjsh4w1+e+YazUReWrSj3h7G/IJj7PHAEopkz9iWCUSvfQWtytKNWmyBPIrkU5oZMFFDYlyUyCMnEwy+KG1xETXF+JpcX2KymTAOPmtckjQISRt0yTEZqSWyjTKltdMzDIpq+N9NcVwcEqN0n66VnQDXVeQyi/M0rMyE0MzKiNSRvteI2veGSvXu4J8CrI98Aw9FaJxfJR6XsmmZhkUx01q15iAhWWnIX9sZQgSArhlEgelree6hk4sQCrKA6c54F14=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(110136005)(81166007)(70586007)(70206006)(86362001)(478600001)(36756003)(426003)(6666004)(336012)(47076005)(356005)(921005)(7696005)(41300700001)(107886003)(8676002)(316002)(4326008)(186003)(2616005)(1076003)(26005)(82310400005)(2906002)(40480700001)(5660300002)(8936002)(4744005)(40460700003)(82740400003)(36860700001)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:57:53.6763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac39e963-6ab2-445b-366a-08da602911fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1711
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible string used by GPCDMA controller for Tegra234.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 9dd1476d1849..81f3badbc8ec 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -23,6 +23,7 @@ properties:
     oneOf:
       - const: nvidia,tegra186-gpcdma
       - items:
+          - const: nvidia,tegra234-gpcdma
           - const: nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
 
-- 
2.17.1

