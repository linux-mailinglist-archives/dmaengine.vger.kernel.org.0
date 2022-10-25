Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3385560C592
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJYHmb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJYHm2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 03:42:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B69127901;
        Tue, 25 Oct 2022 00:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYktDNYVlUF/COfAIZBJ8kLTvWdYACdJWCxm6bZfdWM30gjiGaEv4tKLWec0l7OVPpXeWMAHG6vaAHrkOGRLyxjbPrYBqoS4Z+O7DvPbRUGQN3aysEIdyl5jhLxTmzHhpFAjyY3jAFZzfEh1phUjThtQtEtOwWMz5oNtqAQZJ6ZuT7CUOeeHBcIaPnJ4ZtP6PVoRofT2CjHb7u8UZP1urmql0K+GOryNCLI7jrWCZdfwsoC8ss/2GbFtpY+Z+qHpk3VaGHytxq8N/kthPFjQe/Jo2hqt5zrFCqXeSwUN/Pn6G4fXBQ5F9aYJIRxnulRe9xwmwachHGgOkPs/4/CxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJCIA+aTbs2XYs9UgJ1lrwVwpSZlXedex54CWRcVcaQ=;
 b=dbettoBKm8b150rfHs4y6/oQQj5+D5EmtgGWwE3377n0mr3cIhp93ku+FiMv3DUBnzxGV3VlrQimGZ4R2BOC8Ybl19YoZlYpGh9C4JOGoBxN8xeusTFctNYOjRe0cWfi9F9RnACUH6oDLLaeM4EmNhlrG1Az1HThHUJarSztlNYq0iVXIoG/JsryQTdTJvh652Oq4mGdGvo3N5esH6cTpjKUny21CR+tCUfMKUfVPo5B5Kmb4jLvp9NnU+T8EhZSym4O6k0U2zpLuqvxacXDuDY/KgGL8AxaoMi2YdxZf6a+2k3l/Obp1KIS2SgAuelh9KPZcBYCP39xdDz/c4JQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJCIA+aTbs2XYs9UgJ1lrwVwpSZlXedex54CWRcVcaQ=;
 b=p5IiQ8QAeB03bNpbQvi3CGhv33/1LVH/lrJbiTubIC5nwsrPOgdUYhkbJj/hfNkGzEPEwkpq+RQfL65YIs4cehCUVdWGAdqOY5CIAoBQOHyT7DWx3vzm2ZYls0dogwlPZFhr1x8NwVG2amc1ZCytkEHy0Z+XKR91ks8fvzLTBMw=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 SN4PR0201MB8711.namprd02.prod.outlook.com (2603:10b6:806:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 07:42:25 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::cd) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 25 Oct 2022 07:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:42:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 00:42:23 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Tue, 25 Oct 2022 00:42:23 -0700
Envelope-to: git@amd.com,
 radhey.shyam.pandey@amd.com,
 marex@denx.de,
 vkoul@kernel.org,
 lars@metafoo.de,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.3] (port=50954 helo=xhdvnc103.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1onEZq-000Gti-Vu; Tue, 25 Oct 2022 00:42:23 -0700
Received: by xhdvnc103.xilinx.com (Postfix, from userid 13245)
        id 3145F10550D; Tue, 25 Oct 2022 13:12:22 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <lars@metafoo.de>, <marex@denx.de>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 0/2] dmaengine: xilinx_dma: minor documentation updates
Date:   Tue, 25 Oct 2022 13:12:15 +0530
Message-ID: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT007:EE_|SN4PR0201MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1fd62f-a285-410e-4f68-08dab65c7547
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLyit1GHpDSS3UTxPGl9SZQ+l61tD4t5xL8tkdR0fZ3tAMJXUlf8MPOEhF6JNk7EB0qsXCzQ2R31kERyYrs9SiBWg/sL/ulSjavqV90VmsalQMSQXRILDytyHgJgZ0dGF1LuimvPpZpf7C+RK3vsLpirf/3MSxgIOzGa1jack1ADzsrxT2niOhzPyFRXfVjgjEbibLWcgvUYrEfmUKnoGsKZabQ/OpZbHHhzD6ReStY0Q/kyPsYNmQ7KfQz+k9WsxcED9dwtEBkFfNnP3I4bAwc3HFM4rwHuYQTCksq96k8eNamdy32mm5/5ihxdLTYGhBADDUiN6CwR8iXerlVWuW34RSfduoyryMLEV1qLGdiCwJEFN5IB3lvmCL7O5+/QvL/NAvFhmICQkCTtFxn1QvvIoCtbMAS+tm88t+YUspBZ0lsQUIASPeafJ6MOQ1T9YKf0qP530y1noaH0UJPnfBuYmhvkU/l/bZoaOsKmQYAJOCHScX9i+hxxsSSQQPSNValEtyecAmFqjk6k1XrzpXUf+W/zfPkdBs7fh3cSpiBdDeiMh3232X0m10S2/pLXAKFHPCHnNQoqJWSbTP3JVsd0ZelmmquI15rQzwnf8U0P7TlS0UVEBJgbh8J7qBiCrBHYfI6PdZJlZIuwqH2t2DJ7/VcTH3RyZ7tuyIt0ebcOr8Hg2o9RVc035vo31Y9mxdFDrnhcXDrWxiC+N2j8AnQ29zrM8rEZtvMvGvN1GpZUI59LoO9GQnlCh7+tXMqx4A9J7+iVSwnQ8tum8UJWVhJdMYnV96gLdH/E/mMzjnk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(508600001)(6916009)(4326008)(40480700001)(316002)(8676002)(70206006)(42186006)(54906003)(70586007)(2906002)(6666004)(47076005)(336012)(36756003)(42882007)(6266002)(26005)(2616005)(8936002)(83380400001)(356005)(41300700001)(7636003)(82740400003)(82310400005)(83170400001)(36860700001)(5660300002)(186003)(40460700003)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:42:24.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1fd62f-a285-410e-4f68-08dab65c7547
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8711
X-Spam-Status: No, score=0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series add missing kernel documentation for 
xilinx_dma_device_config() and also fix return doc
for xilinx_dma_child_probe().

Radhey Shyam Pandey (2):
  dmaengine: xilinx_dma: fix xilinx_dma_child_probe() return
    documentation
  dmaengine: xilinx_dma : add xilinx_dma_device_config() return
    documentation

 drivers/dma/xilinx/xilinx_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

