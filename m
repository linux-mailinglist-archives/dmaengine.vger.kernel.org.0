Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053D79B608
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 02:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjIKWi2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Sep 2023 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbjIKTZq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Sep 2023 15:25:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6810D;
        Mon, 11 Sep 2023 12:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D67BpoU+eBHxV1gJr2uHgpNMS6h7tDcp4pF4JajrprxIX/aPm10sAdw/VJtc4UDezI0x7lmd17Y1nq0CG3x9djOggDBOJedvUHimdl8WS+H/lyaDsfugSvAWXoFXhijsAY/gWOtVXh8pV/FHy6cO8/k/NBBmf5eC5ZnewTHxkgYiuQK8sXD4M/gJGESqUzu68ncbzlGn+YTBF1NKsY7qdB5Uzf773/TayERo0yBYjrd2F8MUuB436sy6lShOKfk0/U882r23X3klO8SvPTlUIxJIIpxZ3aE2zWtzu0sHSRoB7rvs2S0iMv9nMDdr4xJxup/7cLoIRrAKVP9WBQ4iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nihn8RGe6nEhpTkGzgmZ4KKgFBThZzxYJySDzvUqwuc=;
 b=T9KP2udDLzeLOHii32n5RfjtJZSesxm9Y7XE3btrpo2mhGtze6pE/DUZJDyWmuwWzD+pWOS7T8gTh5NIsQYibgZLa5MrQNkNMpk3g/Xw2pXY9XOu3j8ibOzV2lPTgdBNxxO2zEmTtRXYlh/H19W7P6lYM1eX+MuzHH//Ov+SqmNW32HScRl8TkKz+k5EqBGX/xneNq1ZLX/+Kj/mrJBIOVfqL5PuOcyJkxN/CGQhRTDkPlM5F1M44F89B4QsRx+moZwNdvsWJBuq6UmMC3dbtkJ9zNnN6t5Xic7uf3/iYGQouiYYwCrBPHxsc54qFNACV+xzpD3plqpbjRrdFYqFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nihn8RGe6nEhpTkGzgmZ4KKgFBThZzxYJySDzvUqwuc=;
 b=FchRcglM/E8Ezj3QbSk/sdjmS5JrtxSeATPsG+K1vC18YV5Jmk1mfi6I60LJ0vO3XABYsJNmu3yJ77FmLVvWukFd6l5PqmEHB9lRTo/49SIM5yi/ZB2A3mMC5an3yuIt4+CPJg/9ovGNwEKdZPydD4SG50hCYgAMVGITElLazLs=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 19:25:38 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::8e) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 19:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 19:25:38 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:25:35 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <robh@kernel.org>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 0/3] Add support for AMD AE4DMA controller driver
Date:   Mon, 11 Sep 2023 14:25:21 -0500
Message-ID: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 974a33db-ff20-46c3-a7ae-08dbb2fce12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p28ffX7KrDdoW/wvs8qyhHRbONUatoOGCjWj5kuLGjVs+rTp1D7iLk7KauYTin+Q6FTi1zK6NoBhOsIpgb+JOMXM2+457WoWfmhX3cpRWWV4eIZ17MwwSGpgdZgHHitwdcYSRuLy6RALNzN7igPY+vRBJIZJqhI7TOQCSfu9l5A707zogDZuObpUnK4sQYhztUtPfaudFm2UH0EyBHQOFltmvC8CReTsgCXpsTAFGRc0Mornb1N16JitZmpfqwn1BW+lZtzdx4PKy59xiZGWD06Cx+/g9IHX5gQnsH0Ip4f86He21CoCbxL+ajzmFPMzU+lfqHTY8prpw/RdPYvzgZ7K+DUe1yk38eLyrQJDRYfBX0LO4NS8S5cJPcW/19S6m/B/7Iv4GzYgtOALW57ufh5AQGHqhGQNkjLvhEqTKifjXvTwrd5MUtB3khy+0P8e2p+3cmfCKau4RN2Ayhr+EKc0vqwkUfW4wnPVyiXWGrnBswI5jjt2L+6iiEApAuHETi5FNVlub4LhiV93AkEdxsg9kxFYP2+VqzGscyv8IOhy5YGl8dDKOOavKA4kuh91xYT7DNGKwbKYw6xE+2NRBn7nTpZG8q5n9b10VOeA59z9s1xYzBVkoOrqjioR5oPgs/GcafvBYqQHb7IueYEMjK2I+DH3bTNAzGnjJNVQwY6qpyzqGW03rGNNpwb3+QHvIszAgzdNdzVngA0tscqs+b2G1cuLi78YEsbE59agu9yKoeQvPojgBTlh4UEPgx2hnZG0meGiAB+smnqvi6xTLSkGa6PUfoEZmayyfzkFl2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(81166007)(356005)(7696005)(6666004)(41300700001)(70586007)(40460700003)(36756003)(86362001)(2616005)(82740400003)(36860700001)(47076005)(40480700001)(426003)(336012)(2906002)(478600001)(8676002)(8936002)(5660300002)(316002)(4326008)(16526019)(54906003)(70206006)(6916009)(26005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:25:38.1422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974a33db-ff20-46c3-a7ae-08dbb2fce12c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch series add support for AMD AE4DMA controller which
performs high bandwidth memory-to-memory and IO copy operation,
performs DMA transfer through queue based descriptor management.

The AE4DMA controller allows for configuration of the number of
queues per controller, with a range from 1 to 16. This configuration
can be conveniently adjusted using the driver's "max_hw_q" parameter.

The AMD Processor features multiple ae4dma device instances,
with each controller supporting a maximum of 16 DMA queues.

Sanjay R Mehta (3):
  dmaengine: ae4dma: Initial ae4dma controller driver with multi channel
  dmaengine: ae4dma: register AE4DMA controller as a DMA resource
  dmaengine: ae4dma: Add debugfs entries for AE4DMA

 MAINTAINERS                           |   6 +
 drivers/dma/Kconfig                   |   2 +
 drivers/dma/Makefile                  |   1 +
 drivers/dma/ae4dma/Kconfig            |  13 ++
 drivers/dma/ae4dma/Makefile           |  10 +
 drivers/dma/ae4dma/ae4dma-debugfs.c   |  98 ++++++++
 drivers/dma/ae4dma/ae4dma-dev.c       | 353 ++++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma-dmaengine.c | 425 ++++++++++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma-pci.c       | 247 ++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma.h           | 374 ++++++++++++++++++++++++++++++
 10 files changed, 1529 insertions(+)
 create mode 100644 drivers/dma/ae4dma/Kconfig
 create mode 100644 drivers/dma/ae4dma/Makefile
 create mode 100644 drivers/dma/ae4dma/ae4dma-debugfs.c
 create mode 100644 drivers/dma/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma-dmaengine.c
 create mode 100644 drivers/dma/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/ae4dma/ae4dma.h

-- 
2.7.4

