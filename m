Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F962A5E71
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 08:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbgKDHAd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 02:00:33 -0500
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:34809
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgKDHAd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Nov 2020 02:00:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH8EBOg4hx8yvoh7O2XzBx6riaqZHzBu9QOOiqkd0IzuWKf6c2E53Wo+BzJaZNIsDTmVj7sogQvCF0uah/VLrmta0bPJdjJF6KN9AD7RM/PuoX+lr/MJnd7dn0EY6p9X97/7g2lGiU7uTS5wozM1cNHcTjJh8cEhkjEzqOmhGScNFwN9h3OIqswqGzauIJtlCbXLg2oD7PRu+ZwpzPvQqPoifMPTQxEP24XjWWoz8H3R1VI4WET7huzeYxZGNHOcJPie2InRCKEnJlRrkL75svaKZb3m7V9vNp9LmaQaaNOo7WEO1s+zrPa3jmyh3jRMEuZPxboqXbGg0mH0JxPWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu9Wk46+rET4axEFjrOW6LY/gawpQLLq46qYCiVrySs=;
 b=W8I+sAYo+Dg3+BR0KiQTlhjH2IQTrG30zREMzlniomAmS8appGSSUxh5nCnkCP+GYKB0FhZEzNZ+6U81M0F5HDoCcRG68ucZ4PxtnYenqqbfJAD0j11yI3zGQeSR6xn+qNyGyLeWE9W0yEclIkRi5taQnuyTJhRrl+txU6yUDPd2CTqZrb5sqQ27DEoYmJYam66/jVIEFnHztuXUuOqm3dTMY4U9H+GNjrzJXdbMPxAcXPwYVBYm+biZvbSCx1AQf3pe5YDbOqlauijY4Bg3EY74lkS/6m1JyG2A+7KTT5V78F/tmL5YPNAf2nMDzHgDH+n4cTwUs7nsQEgyF3rX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu9Wk46+rET4axEFjrOW6LY/gawpQLLq46qYCiVrySs=;
 b=cjNh14eok4zO22R8+AIXu9xAkPMl4Xqgn51OnBnORODAlbNXcF38fJ5VuTS3/CX2UTheUWTE0m5iKpcjRoad9sgDV8g17mA34+jFPlCm0xtIPjIk1CaHu+fLedPurI2jzSxGIE7eGJfIRY9Lg4MnACloMJKTIgigYyVhhEusRco=
Received: from CY4PR16CA0015.namprd16.prod.outlook.com (2603:10b6:903:102::25)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 07:00:29 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:102:cafe::5f) by CY4PR16CA0015.outlook.office365.com
 (2603:10b6:903:102::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 4 Nov 2020 07:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.15 via Frontend Transport; Wed, 4 Nov 2020 07:00:28 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 23:00:10 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 3 Nov 2020 23:00:10 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=53824 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kaCm8-0002G7-TW; Tue, 03 Nov 2020 23:00:09 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 0C4A912142C; Wed,  4 Nov 2020 12:30:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 0/3] dmaengine: xilinx_dma: mcdma fixes
Date:   Wed, 4 Nov 2020 12:30:03 +0530
Message-ID: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da5ae850-6ae6-46fc-3be4-08d8808f503d
X-MS-TrafficTypeDiagnostic: BY5PR02MB6786:
X-Microsoft-Antispam-PRVS: <BY5PR02MB67861ED736D7F1B1C3068827C7EF0@BY5PR02MB6786.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTJAPRLePfupb9xoZBz16p7K6WPWwLJ5lvcXUFOyoWKGhGszOKgtT3/9pimZiYIxHog16zlvH40GJoowIaYQefKpfcPa2V+OwAGTqU084XsP/DnSzOZuZAifZWHyTHe+0wVUycMQCz1cWyZrEKo7D0xS43ZDv8Q5oXv0gKMXQI2dcy25uJ/VXiu2gMsI14KGLbrx0PRQilUeD9hByrIAUhZzBCfDD2UXS44T/BUxtj/PAfvOh3vzpCTmYE6DDQjKwFfGHmf/gEIYMpINn455yjfuPVwe97YbHJlwhc+agd0P4myhH7fyVPsUeyKnRBtyqIJZeEjYyg+QTCI0ESDgMloQY4sJeRRz3TSVLw9rr9bp1ZbKS6kDY3xClvgE7wskC3yihvEs0jJj0WTkizF77cnTQD67cig0aGZsp6MqUUpZUmQU7RqCa3P+l0KVPBrO
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(46966005)(5660300002)(2616005)(6266002)(186003)(110136005)(7636003)(426003)(54906003)(8676002)(4326008)(478600001)(316002)(36906005)(2906002)(8936002)(336012)(356005)(36756003)(42186006)(47076004)(26005)(70586007)(4744005)(70206006)(82740400003)(107886003)(6666004)(82310400003)(83380400001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 07:00:28.7154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5ae850-6ae6-46fc-3be4-08d8808f503d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset fixes usage of mcdma tx segment and SG capability.
It also make use of readl_poll_timeout_atomic variant.

Marc Ferland (1):
  dmaengine: xilinx_dma: use readl_poll_timeout_atomic variant

Matthew Murrian (2):
  dmaengine: xilinx_dma: Fix usage of xilinx_aximcdma_tx_segment
  dmaengine: xilinx_dma: Fix SG capability check for MCDMA

 drivers/dma/xilinx/xilinx_dma.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

-- 
2.7.4

