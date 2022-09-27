Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE32B5ECAA2
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiI0RTC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiI0RTC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 13:19:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB551D138F;
        Tue, 27 Sep 2022 10:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1DDS1qTyp+Ts/YP5BwXMffdjRGbpLQNkVilH+xyTOp+DV+RSwkdeP1FqLUuJzQ1CY/V39WCZR3rUkuM/qUDLXXYPnGWoGkiiAtXPSXieM3y2qFHzFolqp1d/ZWyRfPkyQZIyJ3UPvLXWi7cGqfLyUcfPisrwqzeIT4fqwXZ2yOBA+K6hx7SVLPG0HL9wRMTvnyYF6Q2BqbToKZFsQixgirxZtuqm7xEl3qUaivcNdTAdD/IxzKCzBI4GzOWXofzBZLD925ks9lNNDzX+PudVcmqhDrzYMUkoCEEwn4A0ZZKpJ9fL6l99ZjQH5PNO+njbowUeiv4Rge0Q2nsPrLH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spHejvDSPcDrFsODqYU4Uzgcd+H45C69VfAMv2I9nRk=;
 b=AC0vyJ+qdPHpP2gLsQ9d6Rb3jMFVkIoV1RpyLGl373dGkH3CEFwatohQC4qyvuKkYdFu3ZnUlYAoeN18Hy24KoU6wdJp0fw56jgu0XyYVruW0kznAqkInWAk1FC+n6r2UaaE37dHS7rX+JGe9NIxPSns18Rk4S2aLWoWoLRLpFTspb0l74xqJyri4QeBF9hKuU60XT18CzYX7FD8hsJi7ETz8r+65X/m1ZvftPC2OJjfqAepvOv56mdJIFEIugZ4edwtUJxF1qb0Ge5yqdwifGDunw+xbEiiuMWxDxiHRjD7NnublIPslKnLamI4RPcXFizVTjUKvpi9wCQA8LGQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spHejvDSPcDrFsODqYU4Uzgcd+H45C69VfAMv2I9nRk=;
 b=erHJh/5LDACMYxnV+FNzSIfhhgDzB5COuBH8dPnQnB3UFt+WyhzuHx5SGNwK/dQlp/RpE6/ezo4flZVXmFemATwLhBOWOzkQQvOzvchU+sf7f76GAKf/vI4jaeAstZQlNfirehYlWYTZq3TRm1NNK6f7NQypWjJuxQjCXgRmky8=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 17:18:58 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::bc) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15 via Frontend
 Transport; Tue, 27 Sep 2022 17:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 17:18:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:18:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:18:55 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 12:18:55 -0500
Message-ID: <5f77987e-49bc-e035-19e0-52c25f4adc7e@amd.com>
Date:   Tue, 27 Sep 2022 10:18:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
References: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
 <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
 <a2b5c35d-ced2-ff83-c550-4bbf29973b80@gpxsee.org>
 <64388266-1707-ee20-c3ab-edb67ada68dc@amd.com>
 <c0430eb7-d607-acfd-201a-db56db982309@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <c0430eb7-d607-acfd-201a-db56db982309@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0a9180-cad9-4413-b1ba-08daa0ac5c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVnGIhznrSF1MwFFYtMU7YvopMgzxY4a8zaGa8QSYvjelhLHtQbgNQqK6Hu1TRyYIz5+4SxzicuL2PSdfvLdHFRjfUSeLM0OKlB9EtjrnVAHeuLDCjq3rpsMVWuah7+P4JBfrXeAM1UMfo781d6neFRwj3x5cSd2Pg4kY/dXoZMezEeZ7r5ieRfYTOFbRRo4O+lCp6Bgki7rvEg+tn7doM9C+MAG/ai1f/9OMKgL0IuqxR98m1EMPREj/pJs4CNP/q89grM9Qy5YZYGJ8okcM7ePV+SRjLXcus4rssHWUc7ADtP8z07vUm3z/p1gyuH6A7LFaHKG0tU7k2B7d0WnSaYfCGOAuwfn5OLxQdACpFH4jM4RlGdtil8iUjG8ea8S1morW6+8a4MNS6VOm7qqU0NgQL0h1vqc4skcnBKbMIBEbM6An/XNSDmBchq3U2G9PAUcgPQicU6Kwy63cY0Q5CsQCVLhNuB3A8ke0/ZtlqtPFzo0/G83qlqd4b35LPDrBJddFyXMNwoq/lOJS97Cf/0BRaMlhza+QobhIyvAe0ncqdgVqSsPZIEpd6lyNqbRyO21d0tR6dsUDBl5EZzqvzNwZV/pPsxv8yOuYGgfsPpfonFhVGgpnprBtzcH61Xh/8kTKNCEx4XmaZDXPC1ddgrKCPPzxY2mFm6W9GR+TGk+NrkVOoEA4Ojemy92TqrEBMfEbvUobKLASE6NY1ICRKYCCB4t5pbtphHb9cf+BscXGrUtUvtVrKLH1neHGJgKlQSJb4YhiBjPmZPLfhmObBNKsK31Dl1As9ic/7/xSpfGTQ8djcQZ68gqB6UxYuZxlYKtfGgrunpMtso2TteMyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(82740400003)(426003)(70206006)(8936002)(70586007)(83380400001)(16576012)(41300700001)(82310400005)(478600001)(5660300002)(26005)(36756003)(44832011)(40480700001)(186003)(356005)(336012)(110136005)(66574015)(54906003)(31686004)(86362001)(2616005)(81166007)(53546011)(8676002)(4326008)(316002)(40460700003)(31696002)(47076005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:18:56.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0a9180-cad9-4413-b1ba-08daa0ac5c6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/27/22 09:46, Martin Tůma wrote:
> On 27. 09. 22 18:28, Lizhi Hou wrote:
>
>> Okay, I got the point. How about changing request/remove APIs to 
>> enable/disable APIs as below
>>
>>       xdma_enable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index, u32 *irq)
>>
>>              user_irq_index: user logic interrupt wire index. (XDMA 
>> driver determines how system IRQs are mapped to DMA channels and user 
>> logic wires)
>>
>>              irq: IRQ number returned for registering interrupt 
>> handler (request_irq()) or passing to existing platform driver.
>>
>>      xdma_disable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index)
>>
>> Does this make sense to you?
>>
>
> I think even the "irq" parameter in the enable function is surplus as 
> the parent driver (the driver of the actual PCIe card) knows* what PCI 
> irq he has to allocate without XDMA providing the number.
>
> xdma_enable_user_irq(struct platform_device *pdev, u32 user_irq_index);
> xdma_disable_user_irq(struct platform_device *pdev, u32 user_irq_index);
>
> should be all that is needed.
>
> M.
>
> * something like:
> pci_irq_vector((pdev), PCI_BAR_ID) + NUM_C2H_CHANNELS + NUM_H2C_CHANNELS
> can be used from the PCIe driver

How does parent driver know the first few vectors will be assigned to 
DMA channel?  Parent diver should not assume the first 
(NUM_C2H_CHANNELS+NUM_H2C_CHANNELS) are for DMA channel.

Parent driver passes the system IRQ range  to XDMA driver, and only XDMA 
driver knows what IRQs are used by DMA channel and what IRQs are mapped 
to user logic wires. I would keep the "u32 *irq" argument.


Thanks,

Lizhi

