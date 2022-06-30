Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EA56188E
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiF3Kus (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiF3Kus (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 06:50:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07533E31;
        Thu, 30 Jun 2022 03:50:46 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=K7dCTGSBbruNOWFm2kPjE1VOBlTYYd6UCMAody4fGKGQaypbrlE4WDbHCkLxKZhO29YdYjpAAB9OAgd+zkF2PJQh77pUzC+c/hQUhrswAPkcsg9yoz3HYgs9rEBZm0fIXbGSZyvheqfui4nU/wVreZMshvIwb4lX67SZhavB1vrlIU3bAuTUabqEPftBzIsJBlTK3ZHwd+Y5cqi6R0rXI/95mtkqmhAR6vb2ACDrTFcj1ScZb1PyZNSNtEv8JoUJxo7NrkMX+Mtt2jEPbRA8X6RONEm4Rc7FdldBAzJ1VH++swAD7mV5v6MFOrVuozTmKaP2chCL1rQMuiaWPkEVlg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRQr73HNY9Z7s87x0fhNVzmIzd6lcW6bvIyFy8qkZc4=;
 b=GIoi1FY+ptcPecSmZKjlLGLGiTwC3dNbTrb6hF1U9B/21qQGatGFjuZkPAZqU+cL0gP7QIA6Ynf2qKGGIP1NgMZ7OJALXFszVeyy+y3vFgcihssv9CG9A1/+1IlPEI2Hq+uisjBH6V+Bxnt5dN10olbDvt4tEfLOm/lLlHgVX7h4R8WvJ4w+raxr4d3kD+noRLiLWvOnzfZkrcohZ7P9BjWrsEbFrXGwFW8hwaFeElLx+UB68Y6go7iEV+YTFlIKUlluKTsQMlq8ev1BATk8+YA60NKTaaGm+vsPVdara63xKo9PBICnVHGztzr0qqJsDCjrFeTm4jIHH8h3lULztA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRQr73HNY9Z7s87x0fhNVzmIzd6lcW6bvIyFy8qkZc4=;
 b=MXve5KhWwy5JHe9MVhJWsCJiUcpFjXA5bMDWkkZIP1TXkOpjaAmqHICWPq3m2ZEcBcH4mm2HmSMrduc0PfCnd5HPyb98J7wQ121QpYaHBD4YykvE/Zuht+dmTRvbBKIiVcHRTBcHUPCooabhLApA3Zk+r8FdONc0lxN+9iCNvuo=
Received: from AS8PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:20b:311::35)
 by VI1PR08MB3566.eurprd08.prod.outlook.com (2603:10a6:803:81::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 30 Jun
 2022 10:50:42 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::e4) by AS8PR05CA0030.outlook.office365.com
 (2603:10a6:20b:311::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 10:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 10:50:42 +0000
Received: ("Tessian outbound 879f4da7a6e9:v121"); Thu, 30 Jun 2022 10:50:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a461c9bc2633158
X-CR-MTA-TID: 64aa7808
Received: from 39c1b9dfb25d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5C1D236B-821A-41F1-8F1A-A82CC0DC238E.1;
        Thu, 30 Jun 2022 10:50:35 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 39c1b9dfb25d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 30 Jun 2022 10:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhDNbOJ+0C5d/xEJBAnmDJLD20GpGWPlUsYu7eWWm0fzL5g6ufI5q++xpNIUsTyeaE1LRjL3plQFkHcQF+EvYfP5ERWkh0j4otfNH3JPohB9OTWIMruG1Vz0jTnagyM2eaJu9v0Ri94OPRbW5Sn1xoF8HMlqR80bljcJ3CcQb/TX8GfLQ65ewFy/l5DGeAE/Na0D90Q9NYqIvLWq2eXmCPHr8154CXAyCuZbmG9WzXh554+WBVwBwqlCwPbba8DnU/8jAA+vYZ08JzFqyAkmVA+VYVh7j3t8omr1Akgv5LXssdxYdSlWZz6rMT305k87UyX7qqCl3OFp4cinx4RhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRQr73HNY9Z7s87x0fhNVzmIzd6lcW6bvIyFy8qkZc4=;
 b=ItZ94hAGWU2ednwkXHbKSHxAsi/U09QWAfmu0PKNxGJZE50pkJ8jLHg1ZoT44YPWSiBWDIluCGzAC8y6FSkSvqCdKo90jkvQ00dlvkEVLFf8WpFKhhzO8JfGoBS7salenVYVPtNejZj6kKZM2Ri8/4Ak4VHdvoNGu/kjaINcsuhZVJXFtk24/Oo51v7jHFQpGt6u2ZP2hzr1Subd09EwsBkfyGxKuNAGNJnDmxgN3gxTlBWG5t3YOfBb0II80GagtZroroZ2a0nBm24FZwJoH4F52Bhn95rXkMLCTP/VlEiNzZxn+vrSnB2Fob2VgPX9fC2HIm4Lz0vtMd6SAy3zLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRQr73HNY9Z7s87x0fhNVzmIzd6lcW6bvIyFy8qkZc4=;
 b=MXve5KhWwy5JHe9MVhJWsCJiUcpFjXA5bMDWkkZIP1TXkOpjaAmqHICWPq3m2ZEcBcH4mm2HmSMrduc0PfCnd5HPyb98J7wQ121QpYaHBD4YykvE/Zuht+dmTRvbBKIiVcHRTBcHUPCooabhLApA3Zk+r8FdONc0lxN+9iCNvuo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by VE1PR08MB4640.eurprd08.prod.outlook.com (2603:10a6:802:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 10:50:30 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::9c34:3490:468c:c0c9]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::9c34:3490:468c:c0c9%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 10:50:30 +0000
Message-ID: <6bf895d1-5df7-d4a0-db50-a8d2c83eba3e@arm.com>
Date:   Thu, 30 Jun 2022 16:20:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: pl330: Set DMA_INTERRUPT capability and add
 related callback
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com
References: <20220629093003.19440-1-vivek.gautam@arm.com>
 <Yrwt8QzEFM6W0xrc@matsya>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
In-Reply-To: <Yrwt8QzEFM6W0xrc@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PAXPR08MB7247.eurprd08.prod.outlook.com
 (2603:10a6:102:212::7)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1b2b2019-692e-4ccb-31fb-08da5a8660d2
X-MS-TrafficTypeDiagnostic: VE1PR08MB4640:EE_|VE1EUR03FT061:EE_|VI1PR08MB3566:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9jNbR3YqXeCBT6wrjs5cD6ssULZCQCMJ249yS5yaCG0s5kSJJvsIDbJ1w1V6ZFmvUlAczZtxXJPKFOnEooSv9CZiSWCl93iJsxrXWHehCWvR7zjQ3t21m87kcBY+kEbcPB3lw9L8Qcm7coTOMgv2hZNz/Od8MnEnzRK/oXhYWqYqYTEeTRy9RPRfuCeYzVHBm60N1fWzhxmWTqC+Riay2TdETsy0+e5xS7L5vKBtnZtOPPdvvWTh3LnsQml9GfzuKA+Z024XH0NKOpsUfZLdjId2A3vhNlUrlu71+LWF0Gu+BcwKtRAz7+inuOGkqZuV2msT4+CXIYGoExcOZarraQAxA7QXhLSjVfPjiJOjQdeNQ+Md5JaLP3RBwBicbKYlJ81jdWH6yqhNlqoRp1HnB+iNgqIfI1Dn4HpxIpgP8XfYTjZrmKgsmhlIMJucfMEMHD8LcM3pj51rwTcDxQ62sq9HJDiJFuLZg0JCHKp4K5GDkHDu3JyNV3JUEnZMtHJ/jjZX2aDgQAyZr8f3aUuT6tif1Fhp78zq6KTcY5Jn7dIdBxJW0DidFb+9lNkhnIDHLzH1EQsZLQt9eWUC7e4HFQUvopntv+bfLnn+IQDhFNa9+bahJ4+eEQ6nmZRVjG9gozsQSubLtfc448PeXS1UjeaaWS+O4xMmCOwC136XAl0kO3f4rdehrEoSjsJlPOHeoP4rxflVzUhvuOr2u+QMUzXnNpCKdHciHKaQAyMORNo6BBWzl+qy/S29FxM1+7B/CGImEdY1eCoBSXuVQMxgmnR2MCpCDSDbB3iw4QemhkdgZX19JJ+HadW8MWmQAAN8b63VbxHWOSn2EuvMFbN4fy8fOOHTFQlmM5/rymrdW9s=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6666004)(6512007)(31696002)(8676002)(36756003)(86362001)(26005)(53546011)(83380400001)(66476007)(6506007)(4744005)(8936002)(4326008)(5660300002)(478600001)(6486002)(66556008)(66946007)(186003)(316002)(31686004)(6916009)(2616005)(41300700001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4640
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 24576e8b-3dd5-4937-f30d-08da5a865979
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSn4RxYJBMM2CbsgxRkRFfQbLHVM592bTxg96Q4+iyffvEH4C1PpH8HefvIyAWYgSmhnAxl7SGp31ZlLYzeDwxbwuMyaD9mvJawknLVzj3NJlxqrnWYf5fTBFbXj7si5j5lW5j820LDRjmqn3fMMfYg9zL5/YKhXIQaRperJvFzWeKN4e49DgLsdPH6u6YufvvfDZ/KTG7YeHpuHNnEXOfBup9tNTQ23P52B2VIxxeaW7RVC4i45ymTOyM4Fk/Gh1ZWkAzz8CovW5YLY426mLeZ1V1Se17pzBhnghI3FIjK15atWYn0IbNtXKKy3HuZvcv/lV/VyodjPkcGg+A8Miss7wNjOVXWE6R5gfi/b7FAvd3b8udU5e6wmhmEOO859BVPZhx0UV6qHWVe4FGin4VvuVpJUZjwG9ZPDeHXUWML16uVmqenPXqpn96ayrDtqdLoobG72GDtrAzn6Vmsy83en8YfbSROyZVRo9iOr0BHKd2L2CvokYwwZvE6M5PnzKkHIFioiTFHQJmyjHqJZqsAt9x3nq4zecwXjG3o92fPRe9jiBbOJFjUkbEnJ8GDVi21u0ajrwjzo+MJUfgA8lZEaGpVEl9wpwx/Dh/XmK/IDeH7oLiX1uEQZiKd1opA88PvCtQYoo7JHs4UrVDaywhqQ53Gp4p2DYBUSQzH5J7uZiYm/Ls+oFk4Z9TmkUwynid1eZ9V1j6ZR2BeqXUTY3dEs5c5n3BS18DuZPEHlIMvULA7w298lkmtkuyhXjH285QybMX0xJ6CnKkNw05DzNCuIBvLvpYATY9+iiFFgXzqj2Xj9xPLPlsnhoLsCZ9exxhOPjcqfTs5VNhc8YlM20+DDirvQUsAhC5VvYcBRMr4=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(40470700004)(36840700001)(46966006)(6486002)(86362001)(40460700003)(6512007)(26005)(83380400001)(70206006)(53546011)(82740400003)(8676002)(8936002)(5660300002)(81166007)(316002)(356005)(4326008)(36756003)(4744005)(2906002)(478600001)(31696002)(186003)(450100002)(82310400005)(31686004)(47076005)(336012)(36860700001)(2616005)(6862004)(40480700001)(41300700001)(6666004)(6506007)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 10:50:42.1445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2b2019-692e-4ccb-31fb-08da5a8660d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3566
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,


On 6/29/22 16:18, Vinod Koul wrote:
> On 29-06-22, 15:00, Vivek Gautam wrote:
>> With the verification for DMA_INTERRUPT capability added to the dmatest
>> module, the dmatest fails to start for various channels of pl330 dma
>> controller. So, set the DMA_INTERRUPT capability and add the required
>> callback method to set the transaction descriptor flags.
>
> Are you sire you want that? See 646728dff254 in linux-next

Thanks for pointing to this. My bad that I missed to notice this patch
in lkml.
My patch can be dropped. Sorry for the noise.

Best regards
Vivek

[snip]
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
