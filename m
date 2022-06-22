Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D22554F12
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359315AbiFVPYs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiFVPYr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 11:24:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7FC39162;
        Wed, 22 Jun 2022 08:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td/NRUi+WDgP5vELiSPFF59fZC0WaSe/0bo4Ggez9dNERtpcMjuwY0Ou+b46OaH2aBe1iNCwpiaBhGf7BaGpZjKJpjm2CAMLSmq4jNVdEJ5W9O0uM78TzIMXOrlCqEdd2VRT+0naAiRaCayAhTtu/9Vjl4eI1GOwMORH83ucrohhYLwWcKgesZVR1f3OILRqidFA5jHZsQWZY+7kZVbn9FMIcnQy/VcyJZtZKAOE+BYDzzKSzwh1/fPXv2hbcH1j5N+YSToF1wTWMrkyp+iDpjcc4K4FPWDvwdUj3jwjopEBIDJHYyHCCtLybEu3Dzg8/A9b/eKpbvsabmnPZW0m9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LKsKe5502MI1CuMmStvKIr18PECnIO5uXHnsVaq1IU=;
 b=VneFFHSooj6S/Gq0OP9LD3fFxvmBV2eQcMon9HgPHtitelZffV2T7Hpz2v15CTVQMa1UDEWMcnqYfVN+mJSKHCZDFmEDiRmTWnmrOkW7F692E/ZI97nUZdHoM/3onguwJ1kzhwWE9BqFeytplXi8o8egLVYOCCfjnMhr4Pvt3P0sYkmY8LElEHY4SOkMg1Os9vBgVOYh/Oln7C8T24u1xhXQ7Kefm961AEA0f9OMqvNV11p70LX3d2QPE1V5uHBlVlx8IySe2M8O0D63U0j/7gEtJcC/SAX2n5KEQKTW0oCXjmRJIOqqy/djgXRMdR1mRVBIatOyapUF33fjX2LExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alumnos.upm.es smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LKsKe5502MI1CuMmStvKIr18PECnIO5uXHnsVaq1IU=;
 b=dzq+On/LVt0QMcnZFXEsPT04r+54k+5D1SD9x7p5PqD42bpog522IuLYbeaCKokchWHJOrGqUPWJd9mi1oeJjaDnkSBAdUvgaV+05I5Q/Pt/0fWHfH9wocM0uiJoPjAutSErVTgsjFW95DrrXJIr0ewgAk4CX+gXxs62XxOeHHs=
Received: from MWHPR14CA0050.namprd14.prod.outlook.com (2603:10b6:300:81::12)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 15:24:40 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::f8) by MWHPR14CA0050.outlook.office365.com
 (2603:10b6:300:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 15:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 15:24:39 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 10:24:37 -0500
Message-ID: <687fcc3e-5ccc-78ce-fae3-98afe3dc5341@amd.com>
Date:   Wed, 22 Jun 2022 17:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
Content-Language: en-US
To:     Adrian Larumbe <adrianml@alumnos.upm.es>,
        Vinod Koul <vkoul@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, <michal.simek@xilinx.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220606074733.622616-1-hch@lst.de> <Yp4/JW4P12s4siRz@matsya>
 <20220606195455.qmq3yu6mc6g4rmm2@sobremesa> <Yp7OFYFp7oyjyKx1@matsya>
 <20220622145021.r42vlkmokd3eqmqe@sobremesa>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220622145021.r42vlkmokd3eqmqe@sobremesa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733783c0-ea99-437f-6464-08da54635344
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB28150EF88B46458441072E8F88B29@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGazGveU3uA9DCqm4mJxC9IePMEAdVhXgMJXfPNaIJTLYDVbctVHQXaFFKgtm797X9I3D4lD/oV7cLJiAqrw21jR3G455a++XjWUtJ5UG744x4qvp6YHec613rs67qJUwn4I93zNpEtwh8/oF06Bx2XHTzLzaDdG0cuM/nbr5E/NSm/5eFdCm/DJrbbHZ2PByP5DnDyrsPMQDLJpeuiEsdDxoqmyxgbVDWl+7uR8DHQIkcLnKhkdi44iUcXQRSHvsbe3mxbq1GbHz8rqsIPLOReGc/MIGA+qyP/aoj6FIeuk0kVTUy2imhbR2FAHyeINc3vJidD9LeWl98AL2EJVdXaanO/RBcmcmjSHVlOq4gGaaRHMyR9+jXL+O1JbmBNL/Wq5sbBp740863PNM9Qwce0AFXXSHfGe6aZw9Oh+IdYaSYi6CT/Wr40N6a5wVc3mvZfCEIpBx40FHB6x01aR6terMa0Y2n4OHJU9zBo3YRpqiuAjCzrRTyLduUJX8o5tZ7R4vGiwbdimBATRJOVtQC9xTQhMwgl6EiVL+OXlK6IeqPdhZDYCYfp6aFgsWdm4YSgtW3//FCHD/QJN0hmUq2OTx9tf/izaUYb0MyXJxTSdmTjCKpx/fSE9ZmTKHOjW9qxIN6SHWQs9XXA1XtXnGlQhwCYS99LwEe6dkrdHxweAfGtKQJTnOG96sQBeAQoVgQMR/2yD+v1bX4nH929ipcf2LRKztVHn8fY0EfKYoJkyN3TrLYNLerqtSmFLI63PPlmIqR5Y1OWcKdCj4yucPGH1UE8aeu/LI1g7jpRzfJL9axj8FKbp/B35T4NpLjtrit/fAwwlWrI+hG/46KlgKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(31696002)(478600001)(54906003)(41300700001)(26005)(53546011)(82310400005)(110136005)(31686004)(16576012)(316002)(8676002)(8936002)(40460700003)(36756003)(36860700001)(2906002)(4326008)(426003)(70586007)(356005)(82740400003)(186003)(336012)(16526019)(83380400001)(40480700001)(81166007)(47076005)(44832011)(86362001)(2616005)(5660300002)(70206006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:24:39.9958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733783c0-ea99-437f-6464-08da54635344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/22/22 16:50, Adrian Larumbe wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On 07.06.2022 09:33, Vinod Koul wrote:
>> There are no clients in mainline which call this API. There is a driver
>> which implements this API, but no users...
>>
>> $ git grep dmaengine_prep_dma_memcpy_sg
>> include/linux/dmaengine.h:static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(
> 
> This is true, when I sent this I thought my at the time employer had already
> upstreamed their driver changes which make this of this API call, but apparently
> it never happened after I left.
> 
> In this wise, this change series should probably go away altogether, even if
> that means it leaves that driver feature unutilised.

We also don't have a need for it. Driver which was using it is no longer used 
that's why not a problem to remove it.

That's why
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
