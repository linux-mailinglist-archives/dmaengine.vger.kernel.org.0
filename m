Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC6C4CC069
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiCCO4N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 09:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiCCO4M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 09:56:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0F18FADD;
        Thu,  3 Mar 2022 06:55:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doZVqo+nCaeTKfjTi/6vdgrXPMC4L4U8ov1gnC4UlbNd4xlOUVf/9MqoB0vQcyKU1BqCl//9Pwfzi5nHzLeUW1g39JHWvaqeGSymrvJF6RrQll6ldYd3bx4pk+dkjpi993U3V/dUkR2SZxwHXBa9Cr8awXEXCPjN/VEb+d2X5CnZ1K5/qZe97tOA1ccowBKeR7oNKbsa+7qjAGlXjp2Ig6kpUkQ2D6/ROkMxX2UkSD/eN2kpFTk0Zr7kCYs9adugVHI/T0SYIGsSiAaNpotJqgOM+V8QTcBz0L0sd7kdU+jGWwMYNJxrgVqgfNfot3NjLruHzyWD4q6W0pQV/sy4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/itJvflECKPNouWThjtQDNZVhSmt6SAukBS16RTvYOU=;
 b=UnvzX05iPCek8csPyBlLTkCemARxE85965EkCTyiWGXkl8+b/HNH/Ykv59P44sk50UDfnU1CCZS0GZg86iD3d3w6awSPjboS+flnQRki3cPyebaFuz7I+iBeXEbEN5Ocv01eeyVJ2rPF8oethR6HG9Apfs9JWqBAitCUFZ3nb2BiWBFMoa9mjZvClbse6YDJ6QJB/P1A8haYpKfSgTCN9lgS5FswAsX6OwkYCKVtkPOPI6Wpj4ESsspnMKMrjXnRw8vmpmK09UsDbP6UWrsRtHngrDLPyvky6RN7oiCr2o+eB3+VTwWgQQ7wKGrtvf/0+d1P+XQPFiufnlAEkO64uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vivo.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/itJvflECKPNouWThjtQDNZVhSmt6SAukBS16RTvYOU=;
 b=RlltnfIGWiYPZNJMia3F4mQ/dJurK1SBGgmFVpaxFGIdctfqikvNEsYM9TpwNSmqGZlZbK9JLHe2Qm8qezzfG+SC5mEHjCwqy5M4NTvNYKfkxx/iLQ1gU15xO6pQ7SS9YzWasHyNcG1ZZRw/fKh4BGEzGwJltLTVC5YjceUftlQ=
Received: from SA0PR11CA0133.namprd11.prod.outlook.com (2603:10b6:806:131::18)
 by DM5PR02MB3226.namprd02.prod.outlook.com (2603:10b6:4:6c::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 14:55:25 +0000
Received: from SN1NAM02FT0012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:131:cafe::7f) by SA0PR11CA0133.outlook.office365.com
 (2603:10b6:806:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 14:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0012.mail.protection.outlook.com (10.97.4.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 14:55:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 3 Mar 2022 06:55:23 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 3 Mar 2022 06:55:23 -0800
Envelope-to: hanyihao@vivo.com,
 laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 kernel@vivo.com
Received: from [10.254.241.50] (port=42106)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nPmrT-000BNn-75; Thu, 03 Mar 2022 06:55:23 -0800
Message-ID: <96c87e2d-e32b-92c4-7788-4981cb1af7f5@xilinx.com>
Date:   Thu, 3 Mar 2022 15:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dmaengine: xilinx_dpdma: fix platform_get_irq.cocci
 warning
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel@vivo.com>
References: <20220303130350.3929-1-hanyihao@vivo.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220303130350.3929-1-hanyihao@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df4b0990-b828-4c4d-ca43-08d9fd25d8f3
X-MS-TrafficTypeDiagnostic: DM5PR02MB3226:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB3226B777EE899BB3AA4BD0E0C6049@DM5PR02MB3226.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awhHOx3ZzWZkHgZS/Yb8Us7O1/Pvy4XCkHYA6OQaPhcj00zKQwDneUFg/WpMRGLktDrTRdU5ToMz3/Eq1RkBsALB+2UlA1IJ65ZZggFRTVjkSoyzy80DJLclyPgSezJz7f1jbKz10miGw2rt1iW9M7BIeMV5iP+Z/oyVUsJ+nCD/9Xjyx0b7VVqQ5NqvAITj/oN3Z0QRyqlXni213xIxix65HPVSdM9kINJ+xdyUrerXZ4FfPEDlxDGAtkRL+bQLZarDLHN7Su7n/MshxvdGCO/vTSVz3Sof0QRU83+STukhOw1SvCcBbvmIFm3M/DU5tJuH6c6Pm3K1Goxn9q78F3cbpv85f8Xrpk7x01hLDwD3znfKqIqzYJc3b7pG6w69l/K+laLFx7kTIi+wxqGxwh/61JcQDQqDtVUO9OC7uFeIVGbD0qqkYBVu/HFlcNEUwwdBrHDzUCrOcvpoShnJv5QcdilZFSOtU/3mE0EEWZkGwRNo2rG0MhjpRMTy0Cwz+5nXIAFB4dgWblX473jNvuIi3RT+qRaCMKVQOtJohSQw1Q1hXqLYqcRiF/eqrQisjQkZdjQZdXy09u7yw5MhIdylTHexjbk/Tnv7qC8z5wRTt5QKPRPh3RexdbcwOQ8Kkm8qHCTl160gR6YogR0Lq95cPlgikaU55BVyeEmwPGavVi/ALJDoZe8QyzUA1rRJfZvmdJoX0Z+Hf0oVuarc/aAyMwrHVeN1Qu4ZY1A+2DdObx3CPvp7f0Sye2Ttz7sP
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(36860700001)(2906002)(7636003)(53546011)(47076005)(336012)(426003)(83380400001)(2616005)(82310400004)(26005)(186003)(31686004)(36756003)(8936002)(508600001)(9786002)(4326008)(110136005)(31696002)(40460700003)(316002)(8676002)(70206006)(70586007)(44832011)(5660300002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:55:24.4327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4b0990-b828-4c4d-ca43-08d9fd25d8f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3226
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/3/22 14:03, Yihao Han wrote:
> Remove dev_err() messages after platform_get_irq*() failures.
> platform_get_irq() already prints an error.
> 
> Generated by: scripts/coccinelle/api/platform_get_irq.cocci
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>   drivers/dma/xilinx/xilinx_dpdma.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b0f4948b00a5..f708808d73ba 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1652,10 +1652,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>   	dpdma_hw_init(xdev);
>   
>   	xdev->irq = platform_get_irq(pdev, 0);
> -	if (xdev->irq < 0) {
> -		dev_err(xdev->dev, "failed to get platform irq\n");
> +	if (xdev->irq < 0)
>   		return xdev->irq;
> -	}
>   
>   	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
>   			  dev_name(xdev->dev), xdev);


Make sense.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
