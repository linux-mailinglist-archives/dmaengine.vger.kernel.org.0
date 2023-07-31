Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F876A4E3
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGaXdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 19:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGaXde (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 19:33:34 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D31AD;
        Mon, 31 Jul 2023 16:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5PMQ7KEbJDYnQf+J7U/uFwcKYBNtiGjivVEc/ZbyMjKr9OD2CC+dzYzm9lg988z8IsdON+ZsK97gCxybrHrGUWJMP8Tpye/thekqfgC4bmF41JLry6yYzMnm04xd204fDbHoTkxBMCKo3YEmu4vh9gPw+k0hbfsWSxPjbD6aNjsEe1BPvQM0dG2iJQx0ImGdGGn/XJxYJtFCIlubqD/zjRzF/33gg3pZg5g06nyWIJA159/wxcyXv+pjV8VctyQtxuYTdsHkf25+Q05D4Gq0wAFFdOjcRabKLJZp6BMo802OWjRt1tiB8k8PfsVOa4+piqqWYrUcSeUsShpJ2nkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00ut3Ve806cVSbiC5dWkGa4Es61yiODNHY/PLp2FdoI=;
 b=FYof+fsUuPhU+FsUtVgbdXFEIiZkLGpEr/6N5615wcy1sl0oH+6KqzolX/GANtpIMMOXIKnnY+POliRbqHkvYk8BMjdxIjdP4hl+cu/z4sZf/0SXrMpWc+IdDJGeUa93eBO4+HW1HuXDd6zAxsy+kUfeiZUjT6A/7ZQy7lzYESblznqJDsf3iycWaVNV4mMaJSF+f4Ko8rLiEiqjKmq+7lVtxOB+Ad0omelDJFTK0+pqwK9on3YAmzwsXOETNFnakkcQ0XYYJc/2dIBB+bhI1PndPXuiDiryiQYbz2+NwreTyAlp2zcN9lc0pNGF2EhP8TS5xan/qFq2YGGtaKzAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00ut3Ve806cVSbiC5dWkGa4Es61yiODNHY/PLp2FdoI=;
 b=thw6IquCwA4gPx0L+dTRKySbg6gozASgdNOO7P4sUBYcEtMvuWz2xa2sArtNlKG0441AC2tNdtrhowfm3QY0PIEqIuLLoCBsvKfFtZyh/tz88VW7/D8B1FwOfONKiHegk7H2t5sAIjH2655NAR4Au4sDqk/zSG7Yu5xpIrwPKJQ=
Received: from CY5PR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:1c::34)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 23:33:30 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::c4) by CY5PR10CA0015.outlook.office365.com
 (2603:10b6:930:1c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 23:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Mon, 31 Jul 2023 23:33:29 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 18:33:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 16:33:28 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 18:33:27 -0500
Message-ID: <cc9e8a35-3914-96e8-6de6-80f492064a86@amd.com>
Date:   Mon, 31 Jul 2023 16:33:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] dmaengine: xilinx: xdma: Fix interrupt vector setting
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        "Sonal Santan" <sonal.santan@amd.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <stable@vger.kernel.org>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
 <20230731101442.792514-2-miquel.raynal@bootlin.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230731101442.792514-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: ab485e12-1509-4100-94fd-08db921e8b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewGLmgx2tihCIzg+j+DNtDWHeUoTNvVbeGNeBNXxna9xmkGMnPSYpkJeI53eTMiMB52GPNzaVjgfvrvDnWqKdG2E4hhYTvOyDFCSVVhMEaoV2P+u/6qZIq6fOODprVnnpPc7J2oNC33a06uZgxCD9lPI3gYux1xUt3mALTb9k6WkGuMuHT6W+l9S9X5Mf75vszoRDjMh9MevYLm8MFxdrKXYaELE+HA64z7DCSpcGzQOTy/lFE9m3Br2WEgnAp+UkY4Z2puQ1RVZ8bgM5Qp6oMv76UvLsUNU2okYRXg/Mi+EoV+NOaxLIyLVrqFgrywvrsc4FBU1aW8flPY3pvw3stu2+ooeqNk27HBkS0cr+gghKOssNUHHIrtI3FT7rWwCnMqNuKl5BVFAR0vw0rxU97ri2FqRhln4S0EoDq9+S0etlabqcVC8BrlZ6CPK+AXidF+X6v+lu4CcSNT8DM0sgaFgFm+FLsjiT+j7Ed7Nmjudw90GkecPAZHtnWUfiqg1WXE9/t8AMQhX+/BCOC0aFxeQj+fgEPqoxBZtW/H0uh5bFXCDknYxSmlV9AGLXVe6JH1UxeLXkEig01q9bByC/3C5fhwNbifjdEVjQreRy7u5GglPtLvciRh44AMVw9Y+tp/DZ1loZQWDgEjiMacEo9WcaZJ8d0uIwSqiXhZA/41NusxHlQxus3yFDjrhlm4orAvIq4bbBgoA3H6tRgwF6aOgWxj7ZgyqHlVLjVRz6a+dzAUHHTgk+8IY//TUOGxq8ACXLc1QGS+ZJ24wdQLdet793Ej2jDOuajITPxh701u/HWExas7oxUbsj12P8Zqw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(44832011)(47076005)(36860700001)(36756003)(53546011)(40480700001)(2616005)(40460700003)(26005)(83380400001)(336012)(186003)(426003)(70586007)(70206006)(41300700001)(81166007)(356005)(54906003)(82740400003)(110136005)(31696002)(86362001)(316002)(16576012)(4326008)(5660300002)(8936002)(8676002)(31686004)(2906002)(478600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:33:29.0211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab485e12-1509-4100-94fd-08db921e8b91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/31/23 03:14, Miquel Raynal wrote:
> A couple of hardware registers need to be set to reflect which
> interrupts have been allocated to the device. Each register is 32-bit
> wide and can receive four 8-bit values. If we provide any other interrupt
> number than four, the irq_num variable will never be 0 within the while
> check and the while block will loop forever.
>
> There is an easy way to prevent this: just break the for loop
> when we reach "irq_num == 0", which anyway means all interrupts have
> been processed.
>
> Cc: stable@vger.kernel.org
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/dma/xilinx/xdma.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 93ee298d52b8..359123526dd0 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -668,6 +668,8 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
>   			val |= irq_start << shift;
>   			irq_start++;
>   			irq_num--;
> +			if (!irq_num)
> +				break;

Thanks for fixing this.

Acked-by: Lizhi Hou <lizhi.hou@amd.com>


Lizhi

>   		}
>   
>   		/* write IRQ register */
