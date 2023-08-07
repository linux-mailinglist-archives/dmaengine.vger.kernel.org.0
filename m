Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2857719B5
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjHGFxT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjHGFxB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:53:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2B1736;
        Sun,  6 Aug 2023 22:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogokvdz9FyeHnHomvLl6xbxMgi/LExbEILquMWCC5iEIfuYb2nAEzuTWQsArWyBVG3do3g+ztHbqJeLWqf9tSjvPksTmLoQ9tmWR+dWqboaGldcBADJY6WJl+TL8qiDhjBFSf3DXVdnHZdNZLX3YI73j9cZbYA5rgke3ZOOknL8vt9PavkH+kkBfwBttrFMPBG2v/PBHMqVCpVXg7AF5/2+ePBDavA6aez9S7kSXd20rPHKvLoiaAlwPEEgcA40IN89WhvHo92GLv+5sQDR2N7D19gV5dSxE+b6G+EoLeYeOVKZLjGDLFF+fcF/kOPpDr03czZIpfv2zoCjoYke42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIExSt6D/p0GQ4YgybFuMZp4GJRUC4R6qvzrhQd9fz4=;
 b=doADOnHUAouD5wIyU1jD+CCoqjh9OnouFK1QCeMthYI2ch4ievz44IhLG/I9oEWSSNMtUzAnVmmUPUrxC9HWNzbfYg5heGFftdehxEwtbauKWk/u9UzBWeBqnA6F17sfRcLEWEe/dxfUL3D0anqO4N93NCAkGWeqFhFlKIU/mxXGo3NqxVhQZGZUVUxmHM2gTFdFV/hpBiBIecDeQh2s6M7JiaZZnjmAkqtzk55Szc1JOd2IEJKsvpmnbtmpdoMzTKT6AZvTELcz24vu9MhWn/x2Kn0UJBGtCQfTNDT24LPaEZqjsQH1Glce+cRvqr9nIHAk2rcCl6hjY2uaIKvkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIExSt6D/p0GQ4YgybFuMZp4GJRUC4R6qvzrhQd9fz4=;
 b=pu1UOFZe67P72OgKB2wywSd5Sucq82LqNR00ZvtbiHntNSD+0L3+UkaqFa3RZrcrEow1s5kfrbYnQGHKE+xjln8f6ANzXjva2QEk1ou+bXtA80eVf7xnoFguV1+Jwt4JFYZlzZvtfPIC7RZJckdziiGeX69ES0Be9iC0IWMD1Wc=
Received: from SJ0PR13CA0208.namprd13.prod.outlook.com (2603:10b6:a03:2c3::33)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:52:47 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f2) by SJ0PR13CA0208.outlook.office365.com
 (2603:10b6:a03:2c3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 22:52:45 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:41 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 06/10] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
Date:   Mon, 7 Aug 2023 11:21:45 +0530
Message-ID: <1691387509-2113129-7-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6391a4c5-f507-419e-3489-08db970a8868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRZ70rxG5ykNrlUoUOA3Z5oBplZXBBWeDjdgot0YugGUruGf2Ns4QPf7eo9HMGNJqrsicLUPaZM4TzHdKohQK1MblnnyvtXCWymLqiRZF333t9NOErZYKMfUpOcUZ196tKfgEhswcP0G5jUjDjNQKeFvsEUSF0cJ7Tv6pLWH8ynrLyIty6nCDGpEXuYSnlvp52K20Gr+tmihuUKXUDwCczSTU1dWGq7jB9c1PLz7akKOjE0rG3elYSEKoaQEDEIUtVMIJFO8GfGHrcely5afrsNnEtCBRPIT+g7VfsT6Mb/0pfDj2dB611NK2BJPYJFQ3oOZs9LHRTxQ7+XaiU2mdC9yVUFQYwklYhTyeiXZiRpzYkzR8lpleF30zBihsURU8goSntkLZVx7lhKF9S3sWivU6G6tSVx7gp4POnALjw2tqaq/6QJ30fZS6oF8rL7wSdCvYPE5I8UE61squzu0aEI1arTy5HNcAx6LlyehNBSH53VK3RE7EUxGTb7QkDL5nFU2HQExMqtb5uQjephykZT0Hh07G1dJ6ZfLaumRhbJ/EUB6KED/6FaIuJJdXn+9sBVpEwyxmwxiKkuPD9LXFxOdCoksh4A6ZArAM0kvL3IS0aO4Ppbg69ubnuXdBXUJ9+KT+9aFsuDcOoStyyEfqd43XRvbxcrwPdHerTRr/MuCNL9hbcF3DdC/W2afPxRypdfBtMeSoADyAODjoHAGjOfINJwqgYwrpBbIjpXkJNEu50qa4A14wnBKHC5/cu/PHwa2bHmMlDWUUlj80a4+nwjQTEhRi2kLx68QS9VFmlji0CVy5uK5SEBcf7elSy+p
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(82310400008)(451199021)(186006)(1800799003)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(41300700001)(336012)(478600001)(40460700003)(8676002)(8936002)(26005)(7416002)(426003)(2616005)(5660300002)(47076005)(83380400001)(2906002)(36756003)(54906003)(110136005)(36860700001)(316002)(356005)(966005)(70206006)(70586007)(921005)(81166007)(4326008)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:49.5180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6391a4c5-f507-419e-3489-08db970a8868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Schedule tasklet with high priority to ensure that callback processing
is prioritized. It improves throughput for netdev dma clients.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- New patch in this series. Just a note that dmaengine series
  was earlier sent as separate series[1] and now it's merged
  with axiethernet series[2].
  [1]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com
  [2]: https://lore.kernel.org/all/20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com
- Switch to amd.com email address.
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3b721da827e0..6c1c63a38f70 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1850,7 +1850,7 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	tasklet_hi_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1

