Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8F4A7464
	for <lists+dmaengine@lfdr.de>; Wed,  2 Feb 2022 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiBBPPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 10:15:06 -0500
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:35385
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229983AbiBBPPG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Feb 2022 10:15:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egs1PijzgiHwSJLN9SDkIpcU80vklO30PplLTlpSqVDvoqqs3nzxdssHxaeWG01MBc9G848BkXGxQL1DsHmWy92Xdw8ugspW3bMI5YFems7jMNP5erliJ+nsKBF7M7QZSGifoZ7VeGjUVFgjdsCfqO+s/pLSpSTUm2BtqsLZjak1g1lBJ1wIWyhymt/218k77SyBYAmVC4KRf8F7TUjTfMJciotYoEvhM9rzcXG/9i4Y5GqhB7vepSCqePgUwQVJJ3tmP3GlVW4Z/T4JUDhW7c6kePHSakjc+sro699siSDqUMn1YwKCSJnOi4mMNas6HD6jPw1iTRnKo6GQk47LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KVEKMi4gULdcbU4Yi94U1vl7gKpmMotf6MY5zJZoqo=;
 b=buC4dSqQSeCxt3XhxgpOj6mlkiqS8/T6kKLtwLGeNFCf6Dwp6+kCzHnUR3HHGb4U+LyS/jjJEu9Bvrn4rahZN6WIVuPyxZd+DlCgRMKWsFdvOxyxOLACGUxIe6xwXl8p7tAGNOBajanniJXnbiNH8uCIPTY4oLxgB6aWs3M8s50dohlXT2YQ4fooUPKdC2xqGKTrkvDi8jVbU7w6MWu6W6no9Cis0shTKkmzbQFASYHHNXxKDzq/ELPP3LCvwmd2jR44kJCd+xzTbTOyh6vV4mYJmvTSkLa6pxJX9XfbHaBgVMujcMAQASGUfxksnlP0fUPo03+vPbSewm2G9MJ52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KVEKMi4gULdcbU4Yi94U1vl7gKpmMotf6MY5zJZoqo=;
 b=g0CJ4U5eiiFZRBVF0eQYAe2iWznff/jwCz/z5+sTU0sgxpXUjujSCjS8HISAds16AMuvQkjzl3g6KtFq8+WIyeONSUKkmBxE83uFyXEnoz5fUaFF1lJhpi+3iV8d0Fl1XKAX/x/ySSTJqY9l+W2V3PJhCBzJyMJdx71NVTl3c1c=
Received: from BN8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:60::39)
 by DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Wed, 2 Feb 2022 15:15:04 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::65) by BN8PR12CA0026.outlook.office365.com
 (2603:10b6:408:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Wed, 2 Feb 2022 15:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 15:15:03 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 09:15:00 -0600
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 0/2] Added few improvement and fixes.
Date:   Wed, 2 Feb 2022 09:14:38 -0600
Message-ID: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ef0fb8-8cf7-4582-953d-08d9e65eca06
X-MS-TrafficTypeDiagnostic: DM5PR12MB1531:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1531F8900953F7C8377F08B4E5279@DM5PR12MB1531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tH/sDOTQkqbcC1zh40DBWqq7cQ/F4s7q+dLPPMGM/pzNEZxKxnAK6t4uNtIgwfGSQmDxBfim4qGDuUjs9o73wiQgiVRJoR/jMcI1jl6FmoAiqVfcfdIM8kIl63A+D7GKWlnsX9xL6cfIOAoRKNhDIDL5KIEIK8mKTY+kQapAa/v8VsxlmfPo/EY0UflvNXtEifesr/YOa3t67J6SGRAfErTiTEQ+EOecPKdSFdm3/N/1cLqq1n0n3UoQs34SbkYW3z/cX4T18kDW0zlKaWvRVYSkJLdgfZrc+27cV0YWGDAdLE1P6e+3vGh0OtOTwE5gjs+yFscgzb+1dNxgHOCvs+W8nul/zBAgfXMZuTyHfzbQ7V6FVLmkuD2CVJQQIfR4ZwsIb/5bh49zBtqVNfa8Nje5AD+JRvNMzsXSnYS/TUXsWD+IFSXwkgbnomojC12o8Hjsnu6VkWWdJErXDIfGK/lsX1T/jUBc8KS9FNTEEh28cpuWt6KsYGKGw2IyAPdR5PTzrFRjxSjTLHGQ3UX2FEbwzy324NbCMu2lUxdBdQaMpm5EuCJupTaqJsv/fh05sYaQ3Jf1emBHSzacfzRGU/2nmuBWQWwKi1EEk1mahyoIKMZanPJ93Sv1mnED46Hb/A+glUETFnGCCFLdlJrRC87ESK0oKiPgxsUc05I+ss7kI7bkGzL6nGJXLuu6w1cI8mvioP8CQNHyfnb3hrp4yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(8936002)(86362001)(2616005)(70206006)(5660300002)(356005)(2906002)(6666004)(83380400001)(16526019)(4744005)(81166007)(26005)(82310400004)(7696005)(70586007)(426003)(40460700003)(4326008)(336012)(8676002)(36860700001)(36756003)(47076005)(316002)(6916009)(54906003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:15:03.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ef0fb8-8cf7-4582-953d-08d9e65eca06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch series fixes a concurrency issue with DMA transfer and
descriptor handling with a graceful exit.

Sanjay R Mehta (2):
  dmaengine: ptdma: fix concurrency issue with multiple dma transfer
  dmaengine: ptdma: handle the cases based on DMA is complete

 drivers/dma/ptdma/ptdma-dmaengine.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.7.4

