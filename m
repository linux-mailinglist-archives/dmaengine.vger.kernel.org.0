Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C147A8345
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 15:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjITN0C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjITN0C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 09:26:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F998AD;
        Wed, 20 Sep 2023 06:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP/ATOHH0RkxCBaEEblcwmRAKfHY9S7LRoU+Nqz7epIDlaO4BAR/eEE/yks1P83D9azS+Mmrmy+lSdb8aLpjRt5X9pMR+W8YDQ46uETMlG2RW7zD7JEUYp1XFRrpISSpcNZoPpr78noEHmGJvQywjdEsM2MptWFieYDQnbMN4FJ31RVtmSoPX4RB/taEdNXmupugra/3sxXA3MOA2Qf7+Wtkc/nI5s0ql3QfZtY9qpJFz3WGWldqetRbJBWeUsrmbtCC4uUThqALCO62hlysGOOf5Ph7ij2UDVbHejy98XST2cSdiLt/FTqiBqPhjOHld7DMOZh2uOxV/OkDSaiPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V84ez/FFiN6j/1RgKWOJXrSgFyRJen187JlXY2o5GXw=;
 b=SUL5h3d90tw2xQ4vr3IZIA11Youg2oN48JCjOefr5TaOUktgdgc02orzLB6QGaj1uR70tNO6lwp2fkh3TW8SAsi1oUd8ty/SjQ2qevlutNSqiuorrsE7XFHtneTjxfpRKJX/XCjb9Zr8K6XvN0YJU/SbfwdQvVTNed1PNJmsF5JbVkqM4wQVV2qTFNCYTaQxMsA3rh6n/+1ow+EWQiTpNF8bnn7qMx2ZmOqzpzftUNuBLJCqaBb/UnIojkyOiUiW1i6Ron3VXcvYKnw2xq3jJ8P8ss9mwAU6fNEBqQkb0c+0FtRI4cQ/u7HsT+wAZbbfdER1ZDGG0fGH7dZRFzyvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V84ez/FFiN6j/1RgKWOJXrSgFyRJen187JlXY2o5GXw=;
 b=0n7PK7413lFktSnBP048ZuXrzrA0XX2rGmSeL99GAU39zOTRdqhUl5rSvk58HnxwlqNH9yu3UJGZ+ZFr9dyZMmHVMpZzxl3e5W/I/WOhtNf3Hbb6m0TWwqvDw4ASMpu11hTvl4eRK8B9lwXf0lTiJj6lxVW2uU11AikOqLmb4IU=
Received: from CYZPR14CA0022.namprd14.prod.outlook.com (2603:10b6:930:8f::19)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 13:25:47 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:8f:cafe::b3) by CYZPR14CA0022.outlook.office365.com
 (2603:10b6:930:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 13:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 13:25:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 08:25:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 08:25:39 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 08:25:34 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <m.tretter@pengutronix.de>,
        <peter@korsgaard.com>, <peter.ujfalusi@gmail.com>,
        <harini.katakam@amd.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width required property
Date:   Wed, 20 Sep 2023 18:55:26 +0530
Message-ID: <1695216326-3841352-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: d284ef34-b782-4b4e-8d1e-08dbb9dd19af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg0lzg7MhSttXqWodEM3SE6atXhLY5NdLxj+Tn455DVwCsH6foIWu1bDppJ4xlFI4zqzHhUX4/DMFSWOycyHguu+k1ERmOXcHlkdE+8dN97FHNmU8neCUEvusKHMn32KLKIZdG1msN40b8PTAkWRtzj/gnH+2r6jnNpX0J29eh2rOM3ugLRz7Rj4ZXWyyA4wp063WwutHST/fQM8kC8fZ2QBm8RIQt733aHOhLr6OSrkdVIPQDYdYlo17B1SlhZFZT65tNYMk4FHlUuAb4WtK0XQjgpHHrY3boiZqWWQs5OcUGYHT6g9xirCFLPi7LTxbSq158n2T7xSJKJh++HR23CBBqgaLKnCLjznBReewW3CyW6K2MSBb55jVntx/XhwbeL5W20wrKpanSagI7iMcGmrWvVfK8zEBthFjLlK5jnDuiDoT5psSh8s/qokHMh1WKjXlZePRzvvoqQ+cKd+Lu9zeDnd1ZJw+rWez7c5vEhFsEkUR9PeC/au+dxdL3yAa+7+m/6dvXMzgSErqWB/2LSSYQfDpAmdlalcbeB07+GN1g/Ejl0kCs7Ed7GjSNQQ3Y+SGfyC7R1gpDRQ5iZkdmpG81koiewwQh6uPNbUJFeLcJwiAjEAh5o85XGeCzH0VLCHnYILoBsk8BBW6zqdwcNUJs8sqqV9ad+ryovFzbD2Dr2OE5aIiH+taXBiSI7rWTZ5AnvUJNu0OA7GH9zAAJ7UscP5oUl1zVPpdZnkwOwmlvJaxtMt/gi4fZIjB6r0KUEn+WocqoSKk9YciZQ6SKUqrWHqfqbjFRrdGZroByk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(426003)(336012)(26005)(2616005)(8936002)(5660300002)(4326008)(41300700001)(8676002)(82740400003)(356005)(36860700001)(47076005)(6666004)(478600001)(81166007)(70586007)(70206006)(6636002)(316002)(40480700001)(54906003)(110136005)(36756003)(86362001)(2906002)(40460700003)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:25:47.1809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d284ef34-b782-4b4e-8d1e-08dbb9dd19af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
X-Spam-Status: No, score=-1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

xlnx,bus-width is a required property. In yaml conversion somehow
it got missed out. Bring it back and mention it in required list.
Also add Harini and myself to the maintainer list.

Fixes: 5a04982df8da ("dt-bindings: dmaengine: zynqmp_dma: convert to yaml")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
---
Changes for v2:
- Add acked/review-by tag.
- Fix git am failure on latest kernel.
---
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index 23ada8f87526..769ce23aaac2 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -13,6 +13,8 @@ description: |
 
 maintainers:
   - Michael Tretter <m.tretter@pengutronix.de>
+  - Harini Katakam <harini.katakam@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 allOf:
   - $ref: ../dma-controller.yaml#
@@ -65,6 +67,7 @@ required:
   - interrupts
   - clocks
   - clock-names
+  - xlnx,bus-width
 
 additionalProperties: false
 
-- 
2.34.1

