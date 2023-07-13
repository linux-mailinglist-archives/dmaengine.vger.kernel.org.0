Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1C751585
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jul 2023 02:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjGMAvt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 20:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGMAvt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 20:51:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA111FFD;
        Wed, 12 Jul 2023 17:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBGG3U/QgILx1XdOIet2Tr6evBqywx5bJ3riyCd7CUX2jQrOX6t/5siFs6Qz8keiJv2g3XuahjWXbmey/Iihu27a0oL3kY3cXzg+sfIwII9WPi4BfiyGiyQAWJXEdwfgbZHLS/a3YVaFgs+DnGGjg3mwo5LRPriVH5QFPfrKr/kRqBoteI2ZCwdvlwBSFkWQSzOX4In55W6sGb4etYkRuaBmn8eTdEqthIbZh2thhtAZCfpmgUjXqju7zkrovu/WJdN4eQBpawpd71O1Y0R3twzJhZyZLP2FaJ24dX1CjAUhfopqE4PrZMMiqY1pypNAnb1+z64C88uEua2yetKtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2hGIyQkVI6OTJZyYDTiWf/3/BMbpR1ld98IqaPCv4E=;
 b=UmV9EC9KKf6bcuDMbabSTi4t6MtjyY3dmowN610NjKOjRbBIFhlGJLfNj0mDU7Pe2FxlzYWpIcwehhbAf991XPE7dOVHHt9F/IA69E2S+Ikmv2GNJsH1NhvvK+0GiTgFzD2oDAGqiCWyRmqgMoPeJaXAHyS1XN2759a29qgTg19JDXs6U/8t/TpFhMC/05x7Yxucu1oed7CRpowBi46oyBGk+1Yy3E9iMIqEFEoOqxsNOfMJfaS/DuWYz5mJPBiQTUwzLmdkxKh8qljRPuxe7eiX0daU/YjR4C0eM56btOEq957b2yEye59vscxrq/L5qbAIiH2q3bM7/WFxgsRm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2hGIyQkVI6OTJZyYDTiWf/3/BMbpR1ld98IqaPCv4E=;
 b=H6Kxl9gqavaOAMN724zd+4msd5/8/XtnLWrOVTfUJl6DURchc7XcHC+k0GwhezKSNwY6x05wFUKs3PSBJJjvlZ48jJfIJtI2TkDFPCVWNR3zNwA2Mz2nBUeMVrowlfXu0Qx8wBErWFLQsb3V9vvk2v8pPhPC7vy60RnyUQprwig=
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 00:51:44 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::f0) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Thu, 13 Jul 2023 00:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 00:51:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 19:51:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 17:51:43 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 19:51:42 -0500
Message-ID: <c64f5cb7-4750-512d-f105-dff6ec03de12@amd.com>
Date:   Wed, 12 Jul 2023 17:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH V2 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA
 driver
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Nishad Saraf <nishads@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>
References: <1689179104-58089-1-git-send-email-lizhi.hou@amd.com>
 <1689179104-58089-2-git-send-email-lizhi.hou@amd.com>
 <5955d0ec-cd3a-5ad3-2c28-4ae819d1366d@infradead.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <5955d0ec-cd3a-5ad3-2c28-4ae819d1366d@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 02efce64-82b8-45a8-a0c6-08db833b5427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18cywMvPZJa4N4BPnHckThA1Mk6K3vk4+Dd3c6n21YSuUXoVqm6fPw2H4ic0lTfE5KF83T80p7OtqiNEo1MkB+057WkNaL/pgbyDykRfK509MtgW9Tks4Q+7KN4NTF2C6GXFRxkkO8+38pYzwdFwxM8ZJJWQWhVwtI95QeJaWHanbVAUhAn08GZ4TyEsHD1CFhnnXgtbWrkxLALz4Y8Ap4wrsVTW+c2lZDbBhxZbiy5Ut0/oOAhktDwjuOylP5LAqSgi3gPMv1JuTF2eBexvbYbqbiyqobKpwY4JghnCBAjjeIo0J1DU/znI2jwR87Zcy5ism5Yi2sq9gMf6xjuyVlYJPJ9A+S7H1CUgToLZ4x1oIMiijm3kYe0qcijciq9JkrmBnvzM/X4jQEFPTwrYyIaXJ7NM2t2pShhKotxGLo2XpxAtkGWeZ+za6iKjB50zj10OdIfRy+hy3T8z9l7aA3IxrnAXJiwc5dc69E5XxPDja37gkPYV5QY5oLbq0zcU0GaxARTdSfgPTwksTPTci65EGgwjnCkVHLyF6pY/qMj444Zk8NeP7xAB/0RMoCi4i56rgtgBfA+vg/znHQC+4dmdjSIwJmTl8UdJmL7Ekg9n4VeVT21vSxnnita7vOUYxVl1zEVBt8YGJ4c3EwX5dUJFJkhuJ9pprvSXkrpKEfZStgxPu4soujJ5THrYjA8uwhSSTDXEQnBTNj84D5oLIX1w/nWI88QvRE8Z46xBBYN4UkZMjdNLd+alaJVPJuuBgCiAjMIm+DgWFQmqBc+h7i51EcotqH4S6VLX4z6zKQOsyidbVfSHKj1Qu7fcOrtw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(31686004)(478600001)(54906003)(110136005)(40460700003)(47076005)(36860700001)(2616005)(426003)(36756003)(31696002)(40480700001)(86362001)(4744005)(70206006)(2906002)(82310400005)(70586007)(186003)(26005)(53546011)(336012)(356005)(82740400003)(81166007)(41300700001)(16576012)(44832011)(8676002)(316002)(4326008)(8936002)(5660300002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 00:51:44.0936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02efce64-82b8-45a8-a0c6-08db833b5427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/12/23 14:19, Randy Dunlap wrote:
> Hi--
>
> On 7/12/23 09:25, Lizhi Hou wrote:
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 644c188d6a11..89b26e68988a 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -85,6 +85,19 @@ config AMCC_PPC440SPE_ADMA
>>   	help
>>   	  Enable support for the AMCC PPC440SPe RAID engines.
>>   
>> +config AMD_QDMA
>> +	tristate "AMD Queue-based DMA"
>> +	depends on HAS_IOMEM
>> +	select DMA_ENGINE
>> +	select DMA_VIRTUAL_CHANNELS
>> +	select REGMAP_MMIO
>> +	help
>> +	  Enable support for the AMD Queue-based DMA subsystem.The primary
> Need a space...                                  DMA subsystem. The primary

Oh, ok. I will fix it.


Thanks,

Lizhi

>
>> +	  mechanism to transfer data using the QDMA is for the QDMA engine to
>> +	  operate on instructions (descriptors) provided by the host operating
>> +	  system. Using the descriptors, the QDMA can move data in both the Host
>> +	  to Card (H2C) direction, or the Card to Host (C2H) direction.
