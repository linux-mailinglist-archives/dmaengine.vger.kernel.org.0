Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1598C748977
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGEQsI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjGEQrw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 12:47:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D90170B;
        Wed,  5 Jul 2023 09:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+CzJtlLz0VKzoQWRpjC/WluA3yPswmKNzASb+X85g9+y533UREf5EGTNTO+oXa42yFhK3W6CJbPQlYf0MV6K4XtgxHiNhxA6CtIhbb0XVrhCavLxDV6n3bP/ZVUSrprNFfatS/zgSafN9dXtpRQFF5TT53EouaCJFEdkXa0dHunoKZdkI7IX2EWDpP0+sSdijEb6Eoh0I9YiEixBYrbl3aGJHcRFIRXGVW1kyjU/Rw3qHD7hxjLlX5Bdcm+k7hJRcefJBja52s9RURhD4KucRvWkzgdI1/Ikx+brjxVrWAam7fMh/a+k1wx7hxLiUYnS+fjb6tu0YEbToJMTQL+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGfkzxfPNU6avRXGK7jgIEDBm4eutux+3IW3nPv8euI=;
 b=iwTPYykyf5EQnlKAwj6M/j5C1vgZonua7OGaLjkUHcykCYB8kyZIEdZ/gb7LckFQhaXxsFoDOCi6/NvayjR1U/EPSMOuLSmdKiTvkjsRJ7oa0H/6EgI13yUL86kPLlTQgvmt7NOE/RlSst6iut2nxkn5sqBwFk1p87qJQgNSa9+1aSgGsB8JH9MLWnRWJ+PGGvI5+IU51yfghrubg3Cm1g4FyQkkqU5OwTII2sP1JCdAy3CcGkmx8mC+HyANHryiwx7zBj3HUSBV8IknhGzFKZuWhcTuohGio+/DOdWlKVIE26uucznRiO4/OCXb8ScWOQ5tlSC19K8V08MtKosK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vivo.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGfkzxfPNU6avRXGK7jgIEDBm4eutux+3IW3nPv8euI=;
 b=widd3xUUddXLXi/KBMs1IwsQv28SdbkUS8psErRGgbVSodhcLga015egmUyTawAWU7e4mC6jhbjbXER5fsKOHMoB9S6ZjcaFLB3KLzcUPJGVKGdVSMRCUY8j56U3EGKY0xaZEF9lGrI6QitNWLri5i+BpuTcCGjOPmFn75SptJY=
Received: from BN9PR03CA0845.namprd03.prod.outlook.com (2603:10b6:408:13d::10)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 16:47:42 +0000
Received: from BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::ee) by BN9PR03CA0845.outlook.office365.com
 (2603:10b6:408:13d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 16:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT070.mail.protection.outlook.com (10.13.177.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 16:47:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 11:47:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 11:47:42 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 5 Jul 2023 11:47:41 -0500
Message-ID: <8b5c6d42-c1a8-81a3-5947-7a720501ef15@amd.com>
Date:   Wed, 5 Jul 2023 09:47:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] drivers: xilinx: Fix Judgment of the return value of
 the devm_ioremap_resource function
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Brian Xu <brian.xu@amd.com>,
        "Raj Kumar Rampelli" <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        "open list:XILINX XDMA DRIVER" <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
References: <20230704120458.11125-1-duminjie@vivo.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230704120458.11125-1-duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT070:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 62643fde-a727-4b76-4278-08db7d778d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sB7Ao4byAcUGOMnYXNSlNl/0virgSJ142mBUxZbmmJhktCOEolhnJn066gJRLnxjalmgZbEbGPxOLDXtAnxIzbtQZYzUlGi+OB2BoCrQrF0/OqOB0ZqIxC9KKCQsG3+qUjGQP5Ts2CEIuwYZM4Mw2WBmnwhbFecXDgxeFdUdyuCQcaTyHyi3OUddRkctwVRKSfiVu2Ko+MvaH0Az1xy/5eC5s+fXsZYK4uwktW7XkQJ3fwhqKRPuVfJrIOiLZ/oq8bUbNPOGTnU+o+8VY19TjFoEFXolODEG7+8DGnZh2rBAmghc164psxp8Ljg5ajg6UwGoT7+NEzynPuaYBvDzpLMfdIMvzFbBg8X9jsSF/Om55YyyCcZ/zwW2hQ0+m+h1xX2j/E0wKvmOdezbTp6+meCbpUfNT/QDZcUWmCGYBPSpg/2b4YQxV1uRKIhTzBVCoHjbZUjagf7D16SX01yIoVMJQh/30QmDpdWDBk4WUjgXBjVL9M0g1iTitTg6p504Lyrj34Rj+b1NXol+hx9E6R+m/55OVOurRUEXAO+7AhtLgGeW3OCN2ILuI7b6FsWmi/nLO7IW1eDz+PQvyfbvAsQsvysQnVv/5SvUxwqdqSPHbpVdO6r8UkulZK6GJti+36utTYNOUwe94AEReMOfkHA4KKkDrCxLS4WvBQ05hpTtkTol1czcdgQJokp5KRfjzGmqiH2grtEaStVxZDUrdd3iaxi9BeI1WIky+s0VVol2+yKW9J+M5NahEAeDi6mR1bzsgnBYbw7fbtEzMfHzxx2FOa+LryEEE7xS4dWV6ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(70206006)(4326008)(356005)(70586007)(82740400003)(2616005)(81166007)(40480700001)(186003)(86362001)(16576012)(36756003)(966005)(31696002)(26005)(110136005)(478600001)(53546011)(82310400005)(40460700003)(36860700001)(8676002)(8936002)(4744005)(44832011)(5660300002)(31686004)(2906002)(47076005)(41300700001)(316002)(83380400001)(426003)(336012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 16:47:42.5550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62643fde-a727-4b76-4278-08db7d778d28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Minjie,

There was a patch created for this. Please see

https://lore.kernel.org/all/20230217062652.172480-1-yangyingliang@huawei.com/


Thanks,

Lizhi

On 7/4/23 05:04, Minjie Du wrote:
> IS_ERR() fix devm_ioremap_resource function return judge.
> Could you help check it out?
> Thank you!
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   drivers/dma/xilinx/xdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 93ee298d5..ad5ff6335 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -892,7 +892,7 @@ static int xdma_probe(struct platform_device *pdev)
>   	}
>   
>   	reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!reg_base) {
> +	if (IS_ERR(reg_base)) {
>   		xdma_err(xdev, "ioremap failed");
>   		goto failed;
>   	}
