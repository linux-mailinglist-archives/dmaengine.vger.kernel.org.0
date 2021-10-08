Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC542630A
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhJHDe5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:34:57 -0400
Received: from mail-eopbgr1310093.outbound.protection.outlook.com ([40.107.131.93]:54058
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJHDex (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKZZLPwqUN2onv166381LVPwF4R4iH6aSr21ETste+5ttQG7iLyf9rWsnxctxg6fbvuSM7jcg8G0x9BA9Ja+lqJqvUjfmC+P3pR1j5kO8m+kCd1MTNUu+g4Fl9COTB5JuFSf74QaDZ0+OXNZ2NRfRopr3NV46S7SN5S8C1R80UVoBrCTXbSqmOSRTYuyIsPljkq/2lWmgPLdOT15med61hKWUoHZXdWdrQNBlSp7D7YN4V0Z5rKnJacbKd5WDQgcN5Oo4bddIchwu6gHT26gTumxcp2bxn6xppV7Y3SRZZfdz+ndIzvwHWKjQ9NNkwDm5zEBRbjVchUajHrVjHqbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvhIDhdBJHDnNYk4XPU+b7EwUpmk4gey0acCTXNlf40=;
 b=WSxsMMx/Qm9Bp2VK4yCN+PUWMS7QiZygcxuPsftTzH12NkA+zmYHepBDRa3PPJGn25cqR5VOT2HR/DpfJXJvu9rUAkYYEY0zb2XvGncfH8QI41M62x5JwZrouwUPoKO1O5gYX1fyD1jNOWQWzRwzSBpRdm7iaKvHE+E3BRWo3tobypi42jPoCnUdc4ZwC5YEnW89qZyDv97ytIfDb/yMtU4qFmi1yTDk+kAOKYwtO1HZzMPYpUmTnqkM5bIQuzLV/CI/DcYou0Cz/3hSUDrcuQX8XBBpkR25nVmD2TGdmsqVinuPh9+qSPwG/h3X8bHVCAfPxju8xRbAafm1XkpShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvhIDhdBJHDnNYk4XPU+b7EwUpmk4gey0acCTXNlf40=;
 b=n6DOztohONrLm7/kXE7e66gguPMw8YQSIWIjMXowpSwSj470G9D+1pZgPPDQpkIIptC2gmmEx6bAdBWnyc/lvva2eovLLu4iYoppgcJZKImpHEAwbMXklF/qpqWo5vfZIhAe4eh4Uomfb6qZ6kCoxKH8FqsogsJxHCFwHlu4J2U=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3385.apcprd06.prod.outlook.com (2603:1096:100:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:32:56 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:32:56 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V3 3/7] dma: hisi_dma: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:30 -0700
Message-Id: <1633663733-47199-5-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:32:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab4b2c8-de68-48f0-e7e0-08d98a0c517a
X-MS-TrafficTypeDiagnostic: SL2PR06MB3385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3385B00C08B817D7EF253845BDB29@SL2PR06MB3385.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biwPgfypLK4zWmgr1YZal9V480EjH3/vNJcWq9JG6cUe+xsBr10BlClUww7AH+nJVUa3AL6ztWqKEpHzBFa7VsnDyo/c4vv0CHm7i92OxvUuhmtT92WHSeFiT6nCuakl2DHxztMk5YxkSpc2PJiWxwHWuik7swRM7mUZaUvdchuVZtJrQ4nIlZPRxAfnMX40DsM3Xwtn4COs3pOem9zXUsVBCAfzMrfsvZP0kM4SlFhJLAwY26AnJZ5hBJDxmJ46G+8P43J9Y4kzM7otl37hjbQ5e2y8TlHUXZoJn73Tnxk5I2Jg4/ADisCbE9ydMf83OHA/CI0GlFU+m7BKDJXB3doMHVSzMbgJvDJW3Mj1xX3pxKfJu3CxP0nXOJoDfgsKo2IiL3smbkYentgs1r0b1iZ9dt1EkvpnEkSYay82ZC9vk8L/VHtk1yvbMRvj1yRTNd3PGa4C5kPCCWSJK9kCt8mcluMazBZhIXHmOH8B+FW0NBRuc3ikVe1LO5hBIgPoTfm8Vp/KY59abDG1FJP/xOYNDRwM+P4ePLfZ96KN52M/Higc4Q0nTl4aYZAiSOr9qm5JsP5D1EzYa/JjBUldrlnxM5SHhhP8CGkNDDdD9RRdWtWvS3bNJLcQNKHtBOtC83OfxkqBCss698S4NZtfP2Il0OGc6PKu8iSn+/ehT7vAYqdgftnrDHnxj7c9v3dqfl/N5duTqA5kWw+9cQXoog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(4744005)(2906002)(4326008)(38100700002)(52116002)(36756003)(38350700002)(66946007)(66476007)(66556008)(6506007)(8676002)(186003)(508600001)(86362001)(6486002)(110136005)(107886003)(2616005)(8936002)(83380400001)(956004)(316002)(921005)(5660300002)(6512007)(26005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJuoADK/fOeN47XkbmEual1xN7109qOwoD+GRGxKlUlaXX4t3AoKPLcNAgZM?=
 =?us-ascii?Q?JWp0FMxINpoP25fzLXMS4BTrGPwO4dM649BkMgbt9ar1QmjHZCia1uU3mVTg?=
 =?us-ascii?Q?IPwKsRz6SWqtb8LX22Ogt06YoPElkUOE08JjXhVBko3mBHnYPHfnjKg3u0ZY?=
 =?us-ascii?Q?k+mNHVKOz/dO1d71z2k3MVXH6EKQEglyxh8TPNfU9y/f1ZjmjznEqAI5oRiX?=
 =?us-ascii?Q?AVB4T9WBjR14LzeOghr3VUjKtSonqQrC28RkU5vVViU/tlaAWqFCsPYEiwI4?=
 =?us-ascii?Q?2ZNbKJjctlS6+MxcDjX345aiNyZDujcAeliSnD3EwNMY4U3U1urQkmvM69Ib?=
 =?us-ascii?Q?zaGoUCN5AN6YWESzraygVeLQ3XvLPBfas6moCbZcTCetB6MBoLNJF0l5L4GO?=
 =?us-ascii?Q?EEF+rMUXLWttn/hX8k286ZQIiNro6Cjf66qMVzwJUauLHmzNE+kPgGdtssav?=
 =?us-ascii?Q?6wLMIIFMJVlXz5LwMe5WTkVcmtubE7Dit1iP6EuYW4bYlmQADXVBbk4P9f65?=
 =?us-ascii?Q?JUEAErMcA02bo82dTQh8R+vLSLb2e+j0cY9JxueM5Ejcj70qnlfCKClIzfF4?=
 =?us-ascii?Q?/XQwb2we/vC2rOotHjvTlfUu36b8OP1ZO8IwVanlH0qOIVpKyFEevaveQfVC?=
 =?us-ascii?Q?2nWdwb+ElDzfVxy49RE89GEg5jI7Eg7GtZZ3ucAUpv4dmZQGjXgBKgnDzACJ?=
 =?us-ascii?Q?eoz8arunmP4WyqpVgTlxemSk+reMdSyg8P4ftM6QvVaYS67WFmkSZgNIUvMy?=
 =?us-ascii?Q?q4IRmQPO4+bLtR28QjFcQyUYvtRyNLBcRHbFhuWIba0GcAH/YIBxQCtFSLtT?=
 =?us-ascii?Q?Z2vztE4U7dXyuMYlVclQiTNLjuPoHBPFPEmwm8vNOKoVi3etdzBsLyRwEWH+?=
 =?us-ascii?Q?mWhB+mh5h0RB+7ie0CF0uov63UgOewtFtpwF/o101p+AVBvw584o6yVwSMcC?=
 =?us-ascii?Q?bGrP088pCAWnMjPaTRI3m0cGqK0Az3b4T1AV+Iovl8JQQxEKVNso2ZI42K45?=
 =?us-ascii?Q?Jg64jxLLnE1DmFxw6pEwZXSV4PJqqUUFlLxsx9jTQ/CDs+4lzs4is1abi8KM?=
 =?us-ascii?Q?uDFZ72PEWevfdZGg1U/Z4rxBD3nQ7HXI5N4zQPQpqqxALGMyrsGXXEukmYfp?=
 =?us-ascii?Q?2G1+QXtf+MAu8hmf6rVikiW/b7nZ43MWobPqLDPaJgH+AKVBChM+zZXVy+La?=
 =?us-ascii?Q?1DlCMJzmaMtj/CeK1WqNeuVka3tIUYuWGtQA12Z4cWjZbF5AXys18fTpf9KO?=
 =?us-ascii?Q?YoDDqAMMU/7pCPaVTF6xA7tsy9M5UFTbnqcroJ2ZWErGEz4Txmi84iCojCqs?=
 =?us-ascii?Q?tzGlMNarJexn5OnYSfvdPTBJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab4b2c8-de68-48f0-e7e0-08d98a0c517a
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:32:56.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYbziVER229BmH6ulHbx76dinRTB2OinWLsjcKlBKIFnRnK3l98vsL9Ld3e+DxQnOxHJpAFiNCcx80dFsVy3dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3385
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

pci_set_dma_mask()/pci_set_consistent_dma_mask() should be
replaced with dma_set_mask()/dma_set_coherent_mask(), 
and use dma_set_mask_and_coherent() for both.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/dma/hisi_dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index a259ee0..b86f856
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -524,11 +524,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
-
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret)
 		return ret;
 
-- 
2.7.4

