Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8EB14DB0B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgA3Myq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 07:54:46 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:16582
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbgA3Myp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jan 2020 07:54:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSc2J0OZq1eH4o07babSHq9r1hnSZEoPh31UHCoi1+4FzzOxIg7Zdyusp94pLeK4kT59EheQeaZPnWqvPtAUEMancqH4z0P7qmxzG1fyBavW5lVWyKAhPmz106A721KOSp3CsuqixkAK8CKxH/USH3el7kgk79LGmD/2th+yKFDYRJ88mXJcec2wSVO3jfiqXNxKTiSyVIubd9zn8LoYEunuU691cqf8AbIgharC+8VUHxNU3wYL/J5K2SUJpv2d2xjF4BarR5zdIDOHMvCsT+/Xz4fu4qn+1YqQTF8nsZbZXwwO8NHptzI/RHmUCzoRgdEzKji3n87/vKbflkWU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJSMS+NLJIeszLfKL3SmPUfLLD/5iNiwQeDHJQIxpu4=;
 b=FgegFda8MMSE3Uz0wvmCUrcVkBTs4JP1jYe64bD3Mv5rH0p0KCBT9mhzeKd6aEzYRkaO3oDzH8ql/A47V3kuwL9yrXvIVTHJ5l5qa1IljdfrMLYG3jstYVmYy5UJbN6KNP516HO97HRIV52ktwm1CK3o1c6GhUKV8DD8CT1u6650jxoJgVJaisA7Js0FtkhkRwGj1Atr7+X6Vrzgapr8OrbLlBsDY/ZHxUAQIZEFVOORRY1aW99plWuN4gUA+1a4aXTjlMMjzOZkazLzxu5cpZ3qsObUrbcZbAqVWHTITZDzQVr7Nvvl4BqOz4edyGlQco7zdVtSuB2mC2/yRnbBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xhdpunnaia40.localdomain; dmarc=none action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJSMS+NLJIeszLfKL3SmPUfLLD/5iNiwQeDHJQIxpu4=;
 b=C6d/mbcjTdIT0/d+UtX9t7tw+jGy30MKXP40lKEmrckyZSQDgCg80ZqyayCv9PvRF17EaAgkZWkM+BHokLpF7hRMF7TDndvwKxOVJb3lL6zbrAK/OpTcbxSVP+5QQRXys/ubxjROvMZxyHCNtOOh8vEYBrshakacopcLzbfpmr4=
Received: from BYAPR02CA0067.namprd02.prod.outlook.com (2603:10b6:a03:54::44)
 by SN6PR02MB3983.namprd02.prod.outlook.com (2603:10b6:805:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23; Thu, 30 Jan
 2020 12:54:41 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BYAPR02CA0067.outlook.office365.com
 (2603:10b6:a03:54::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 12:54:41 +0000
Authentication-Results: spf=none (sender IP is 149.199.60.83)
 smtp.mailfrom=xhdpunnaia40.localdomain; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: None (protection.outlook.com: xhdpunnaia40.localdomain does not
 designate permitted sender hosts)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Thu, 30 Jan 2020 12:54:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9LD-0004Lj-7O; Thu, 30 Jan 2020 04:54:39 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9L7-0000i2-G9; Thu, 30 Jan 2020 04:54:33 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00UCsWmW005663;
        Thu, 30 Jan 2020 04:54:32 -0800
Received: from [10.140.184.180] (helo=xhdpunnaia40.localdomain)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9L5-0000hf-Sy; Thu, 30 Jan 2020 04:54:32 -0800
Received: by xhdpunnaia40.localdomain (Postfix, from userid 13245)
        id 17E6AFF8A7; Thu, 30 Jan 2020 18:24:31 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 0/2] dmaengine: xilinx_dma: In dma channel probe fix node order dependency
Date:   Thu, 30 Jan 2020 18:24:23 +0530
Message-Id: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--2.382-7.0-31-1
X-imss-scan-details: No--2.382-7.0-31-1;No--2.382-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(428003)(249900001)(189003)(199004)(316002)(42186006)(356004)(6666004)(70586007)(36756003)(70206006)(2616005)(5660300002)(26005)(2906002)(498600001)(336012)(42882007)(8676002)(107886003)(6266002)(4744005)(82310400001)(81156014)(8936002)(81166006)(450100002)(4326008)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB3983;H:xsj-pvapsmtpgw01;FPR:;SPF:None;LANG:en;PTR:unknown-60-83.xilinx.com;MX:0;A:0;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ee8bc1-48ff-476c-6ce8-08d7a5839244
X-MS-TrafficTypeDiagnostic: SN6PR02MB3983:
X-Microsoft-Antispam-PRVS: <SN6PR02MB398374063500E00037E32E1DD5040@SN6PR02MB3983.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02981BE340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kThNGl4H7rqbjh8fuAQ1+dY55qI1ReA5I0aO1DJB0R6O8BRSJYLWZYMUJX0+ZGJA5oScSqf5RfKHMy77KGZD2ioCHSKA+ETjfU8B6Waqgr4pskqNRZsnidgl/T7yFWyfrIMhrqwH5l1tCUH0iyqsxmXzJ3nB1hzZOQHlmrmHOsKfj/7sEngoQFsT3CNt2DvdczmIZHkEESyF12RYR+2EzZviyYDH+RlfasNrksJ4unGK94iKaRd9EIVeyN6PKEy1AGGJ4sQXT4DVkgSQ+0oJIhqUxKVYPJuqp7VvZfleizXPKlbBD/dn3X/bbeUbHqJrEjQCr3S+XmBC0mS+swE5qDxSQqKQO9r2XkPYOexpyMZTAQOJLqH6lay99Uv+UKB/fi6xQ3p/vUJVxAKwtIjAXnW+xA0fgwWhHoKvfXadDB9/mDPLeHqKUJ7C1AC9sCCahvorNKNHOtMUwJjeBJLANCODraGnRK+F1mKl/dBmB53yJuobj1hA2V7op0i4xD+Jfg00ZCTMQ4SSqHIGGv8sBQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 12:54:40.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ee8bc1-48ff-476c-6ce8-08d7a5839244
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB3983
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In overlay application[1] we noticed that channel DT nodes are inverted and
as a sideffect of this behaviour the axidmatest client fails.

In general driver should not assume specific DT probe order. So to fix this
failure remove channel node ordering restriction from the xilinx dma driver.

[1]: https://github.com/raspberrypi/linux/issues/2416

Radhey Shyam Pandey (2):
  dmaengine: xilinx_dma: Extend dma_config structure to store max
    channel count
  dmaengine: xilinx_dma: In dma channel probe fix node order dependency

 drivers/dma/xilinx/xilinx_dma.c | 48 +++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.7.4

