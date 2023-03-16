Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161E6BD820
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCPS0E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPS0D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 14:26:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8534F79
        for <dmaengine@vger.kernel.org>; Thu, 16 Mar 2023 11:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXRaTj7XR9OTI3IRja6hOaaQGcIl8Yq8l5e2ZdQFflx1EdoGH7VBKdz+MVncFVJZ7mw1Wkw/UDsZEQLbR4zICriPOw440iH3o+KXXy3dY2NDIW797SwPC6K7bFCnxXwjsgLNAXtzKInpaWCxq3FbRy9TkYPbfUfIW+/SMOGwYnnXuLrv/Li1qqLfZOYdFer3xCj9AOC7+9Nu0T+85N8X+rplQ8wTuLvh2fK9y/xLS8X2oeqtq+y4Ki57lKBGBgixHa7Rm7oHd/NOzRmFOg2utBX8+m3a/oxGq9LZJQc0RcYGLq68wZajux8bWHaLJiMf0Y1b1aIgGpjogn5X7fB8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNCHjbUmVH3uDN5DNipHLQ/+b5yyBzVBV+YanlJU9P8=;
 b=YmXbBSuxsih1avLUCDvAnti3Zopw69sbcClij+eYdka05l3IFbKG7gYP/M0syqjD8QMVBItpmw0ktB+o5vsr+6UeYZl5eJLqfG/JlzZ+Ju1bwl8xkx+FNCfIO4GfdcyTeO+a4K6dmz02+NmAVpYkZwFoF1xF1ocNw8MIRU8yrFIDHIOIEfpDb4lMVIYF2zwSRt/+jh5diyy38Y8BShw10GPz4BPjzwAW626QdflWCDBsoLJw4uhmlHU7lLTY6mhHrRv2hQSRfVqhNftQ/s4lf8zNAGieFbgCGEYO20Ci9Sed0+/FVHqh+jgoY941UVBftVRDjYIcREvpi/r82IU3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNCHjbUmVH3uDN5DNipHLQ/+b5yyBzVBV+YanlJU9P8=;
 b=aV133yOeqenWfvueAiLoWqW8JOwERSN8vuGkQPcJd8Zo5eb1PHLip1M11d5TcVVpqXH59qR3p5hg7Hjlve+7EzpIWv6HS0Icpo9DytrDm3JB+ANMlUzyDweWSDOQmGXM65AV4GO+2gg19lf1V6Rj4tx3lBxmDcbYRQG4psy25ig=
Received: from BN9PR03CA0128.namprd03.prod.outlook.com (2603:10b6:408:fe::13)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 18:25:59 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::5e) by BN9PR03CA0128.outlook.office365.com
 (2603:10b6:408:fe::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31 via Frontend
 Transport; Thu, 16 Mar 2023 18:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.18 via Frontend Transport; Thu, 16 Mar 2023 18:25:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 13:25:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 13:25:57 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 16 Mar 2023 13:25:57 -0500
Message-ID: <f6a0051f-acec-f661-55cb-8b2504bef79e@amd.com>
Date:   Thu, 16 Mar 2023 11:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: XDMA crashes on zero-length sg entries
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <dmaengine@vger.kernel.org>
References: <529849b0-2ba9-85bf-c57f-0abe93cfdc42@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <529849b0-2ba9-85bf-c57f-0abe93cfdc42@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 21359972-eeee-4caa-d3cb-08db264be3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWXcc8V3QnfxFhd7n7cnjzDWj1VbT0/++4CgdPoe9COUWhuyx0vaoiWLZo7cJ4o8gVXea43m51n098vfXYZx5VqZ6OAj6ZKhtjFDwXXj6Ri5JfhmWt77f5ebodrL4FOMro/Z8KVJEEbeIdBDKzRLqXks0As+Yphpq+5oaOh+BTn60K8j5auKWOFuOJqLmwjIhIHU9vjmCoJny7wsRvDzxzs9dJUqLHuzT4IA/8g7D50npgFooWUEq5RwW+s+7Ku8vQ4iVNgS9nAoQR7TwP9XY4wPA8mLEOVPc91/88/6nK6h9V3ycWT+zFpPNnarQN0WWpikXa+LDYp8tqUFu6nOoHksq4wqMKta4Naol9Eg3yBYgTTk50e/TtYRwF6NTXa2XttgK9K+g5nTbpEbXQgxvdhxfa/g4n5gZN1JJ0PA1XP6jUN4j5I8Pc2/NKa6zo7FQJKsgIZhu3y9z1+UC3Dh9zAggh8C1TuyOpwxlH6opPsywWqRumimfb+5eASUcjdRMwr6QkAQ1y7lS3KTkoMx02fbW2AbMnWpouGP9r2+LdVkG5a3kNL1IOeWmvdoRSySzIiYEAbf2xpCQFEBK8QGWoy2CKoABozKsgF2mypc7pDNlZ7Rtztt6bpHd4IyO6SzGLfx/VI/kHugAK/1+6IwDPL4EKfMt+xXs5L1hSs1jHMYY7sJXX7g7eH/CZ/JQwXPbleYw3NVTH160AzrsYaFY8+BEJO191rBLhw4n7gETZcrm4Pr/J8A+SWor909fXsx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(31686004)(41300700001)(8936002)(8676002)(44832011)(70586007)(5660300002)(70206006)(16576012)(478600001)(316002)(110136005)(53546011)(966005)(40460700003)(26005)(36756003)(186003)(40480700001)(336012)(2616005)(426003)(47076005)(36860700001)(81166007)(82740400003)(82310400005)(86362001)(31696002)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 18:25:58.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21359972-eeee-4caa-d3cb-08db264be3a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Martin,

Based on the dmaengine document

https://kernel.org/doc/html/v6.3-rc2/driver-api/dmaengine/client.html

The sg_len used for dmaengine_prep_slave_sg should be returned by 
dma_map_sg.

This implies there should not be zero segment for the first sg_len segments.

I think that is why we need to provide 'sg_len' for 
dmaengine_prep_slave_sg().

With 'sg_len', we do not need to worry about zero length sg in the 
driver callback.


Thanks,

Lizhi

On 3/16/23 10:03, Martin Tůma wrote:
> Hi,
> The Xilinx XDMA driver crashes when the scatterlist provided to
> xdma_prep_device_sg() contains an empty entry, i.e. sg_dma_len()
> returns zero. As I do get such sgl from v4l2 I suppose that this
> is a valid scenario and not a bug in our parent mgb4 driver. Also
> the documentation for sg_dma_len() suggests that there may be
> zero-length entries.
>
> The following trivial patch fixes the crash:
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 462109c61653..cd5fcd911c50 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -487,6 +487,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct 
> scatterlist *sgl,
>         for_each_sg(sgl, sg, sg_len, i) {
>                 addr = sg_dma_address(sg);
>                 rest = sg_dma_len(sg);
> +               if (!rest)
> +                       break;
>
>                 do {
>                         len = min_t(u32, rest, XDMA_DESC_BLEN_MAX);
>
> M.
