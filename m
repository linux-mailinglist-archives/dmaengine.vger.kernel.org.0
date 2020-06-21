Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764A202D71
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFUWcZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 18:32:25 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:8105
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgFUWcZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Jun 2020 18:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhRVYaq5N5wouL1ybivqlkl4DxpSOF03W/RSKcAe/F9o/tIRTRUDvhA9UQtLTZEL4kQavEKYFA8ebkKJEQq2O+oQy9cH/26vHQA2jEZDHugcQDP2z17w2nwTOB1RqiK1txu30QLvuEKmjgdXewB1ebjA9uvFU2KfvyzpwKbnVtlIjK4GcmlTeM/zvJMkqXDwBt/TNZqhOAJK09qo0JAsZi+mLIlKLojnDcQEy5F2cKv7j/OKDOYhGrOK8pdGL5KGhj4xqBROFXCr07lFw4ahdImAu3a64U85WBeflk5xFV7hISdY8HAg+KM9ZmIGTo/fqglTdFujtP3v/1GtDw15uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNqxjqCZyARJL1fL/feIU5z7rx/+jDQll/inQrkpOfM=;
 b=HbPcusEVxfRCYLxEhOLkBno4pXB0eXfivmKMBYO3EDxTqscITrQagvLKusO5N329Gbke8Dmqnr9q6m9kf02tX2X/iG5UAz9FsuKxNEv16xL4UXedDPYfExKYgn6/ltwibUnA9uKzXEZG+/EZjcHWYrCsDcHXmzuXx63JMYp8BQPoXD0bs4DTo3kA3D68quQbDtt+KQjhXTCAFFDfv4tkv4TI88sGDRPUUiY9vf+524Bjv6srkLUEDmQGqbdk5cKcqNXNRvqM+JxTIxttBQetMC8qdAUaGEEmY82PQ8NlvMfWZWRjdztNkL8DavoFmfZb/4j1BtY0Hq+rb8lsG0qrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.46) smtp.rcpttodomain=gmail.com smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNqxjqCZyARJL1fL/feIU5z7rx/+jDQll/inQrkpOfM=;
 b=FrKak7qMWGPUxzCHl0s3O55hZCVxKIUcRS2Jxrz1AvjKhqDN5tbiiYcbfigD/uyBaDixiSuW0Uq24l8eUhKUQ8qE3afxQh8/uPUIn9ysMrgxun+i3zXrC3v6aOdYw0EEI6fAF+A+aHopWurEuywt70pjOODIk9Xa9cLVgq7tbtE=
Received: from AM6PR0502CA0046.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::23) by VI1PR06MB3967.eurprd06.prod.outlook.com
 (2603:10a6:802:63::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sun, 21 Jun
 2020 22:32:21 +0000
Received: from AM5EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::65) by AM6PR0502CA0046.outlook.office365.com
 (2603:10a6:20b:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Sun, 21 Jun 2020 22:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT019.mail.protection.outlook.com (10.152.8.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3109.22 via Frontend Transport; Sun, 21 Jun 2020 22:32:21 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 22 Jun
 2020 00:32:15 +0200
Received: from cwe-513-vol689.cern.ch (2001:1458:d00:7::100:1c8) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 22 Jun 2020 00:32:17 +0200
Date:   Mon, 22 Jun 2020 00:32:15 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200621223215.xsbjqlhg6m2gz5im@cwe-513-vol689.cern.ch>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <CAFLxGvyaqOsrtD5_Re8_T6BXEaV64vFO2e_2eafrHEr7id_ubg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFLxGvyaqOsrtD5_Re8_T6BXEaV64vFO2e_2eafrHEr7id_ubg@mail.gmail.com>
X-Originating-IP: [2001:1458:d00:7::100:1c8]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx13.cern.ch;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(39860400002)(346002)(46966005)(5660300002)(4744005)(1076003)(8676002)(2906002)(70586007)(54906003)(70206006)(316002)(55016002)(86362001)(83380400001)(4326008)(7696005)(44832011)(186003)(426003)(82740400003)(16526019)(6916009)(47076004)(26005)(356005)(478600001)(336012)(7636003)(82310400002)(8936002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be5c7f13-5af0-45dd-d8c3-08d81632f68d
X-MS-TrafficTypeDiagnostic: VI1PR06MB3967:
X-Microsoft-Antispam-PRVS: <VI1PR06MB3967B942D6034DEE9D570247EF960@VI1PR06MB3967.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04410E544A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CU0oXPxcWcpLQjepkwYDkdbTSasUCYA9WMGLg8kK/jgpnNNljY6P3rbdI8DqUfHiVHk2ozJZTWUKQ4AnFHAbsjxrG3v8LZdrzW+sSYN7r42xCvna9y//rlkDVKqMUl2+rCqL2bEFaU8cwntOZQFQfozgQ/kp+IMFsMpG5R6IxauAuP/svoEj9AbN+lPNadtjeBN85TD5C+acR1SeFJGMOYuIcP3i/xfQTNak2oS53Zt2GnslqoaKJiMOxLlFlUpdB72tn6HTi1TCkFykzN+jaFV/Zwu+GfcO0tBNj1fCF9ZcgDQLfF2cSbr11wBir52cmHv/2yj2TY3KJSd9ROgE+LkJ+uMPH+rvvOAZcE+egdsTwb5/9n0zI37vcsAIrAVyF3W4+v5wisbTb9Ss/Vsz6Q==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2020 22:32:21.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5c7f13-5af0-45dd-d8c3-08d81632f68d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3967
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jun 21, 2020 at 10:45:04PM +0200, Richard Weinberger wrote:
>On Sun, Jun 21, 2020 at 10:37 PM Federico Vaga <federico.vaga@cern.ch> wrote:
>> >Federico, what use case do you have in mind?
>>
>> Userspace drivers
>
>Is using vfio an option?

I do not know the subsystem. Could be, thanks for the suggestion I will have
a look.

>-- 
>Thanks,
>//richard
