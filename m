Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC8248ECE
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRTiB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 15:38:01 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:55776
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbgHRTh7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Aug 2020 15:37:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8ABJGgIMaIeLWFgt3yVi4zISOdL323jfbEKhpbAm7+Q/j4mFxlFZevm9ZWhSema7bBMRBk8GAwkDzzITKuN8qngcCoC+Jwmkp+Qe2HOc1Hw7LHvdLo+PtLT6q1EBJbseSJxQSJJt/2ykf1HSL015+TyHG2Szhdt0VYR331lRa1x+0r07fvsXgLarC63ylrpl/CP7OOHGdp28hVgzaXtqvWWluNb1y8ewOYU9jgDxdtWwdKDYLGeu1/tB99I7IDw4H9sla1DENFonO6tzWNG0OnSIhEWcNKKP3cQ+n1tr4YCEwQIYFDW9b4Hqo0SKYjh68jlIWYkhTiy+X8Uwm7KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/daKEy1JLkdMaDCC1eNdHpopr/+oxb3RRiE/VKxHV4=;
 b=NcJxo2PsoGSCLKGmSRyeiPzYy0B2UM4ZvrnZ7Qr+iZVxoVmTaPdNWacNPbwsjeuQUGyLmFnEXhFFcaWEVgc5s2nHl8UBYKPCLih3Z3Mg+X4MVCmjAJYaRSSlkoTTBow0Pi69iQEFihiy4xwGoKp0nBcjDzCdPXOcR0g4OaddCuDCdqy9A7UFVeE8bN664g72EMvA9Imvcr7HVoQiCB+LYxiwB00zghl182HZxFxFrpTsSf4rpQ9xqrFRb3cyrQdLlyEnQyMVz2ekbJAP9nctSHPDQnuGIOE/tfvJVDahjMlL/PjYgQWPhPe+1bMfh46FRWDXUDMCU7cAUxkPAiA/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/daKEy1JLkdMaDCC1eNdHpopr/+oxb3RRiE/VKxHV4=;
 b=YgFhT4kfuBxTSJR9udILe9en80AJOW8zvFl830po4mintimb9nmBfRBIUmYLrTrIol3GGn9lmCVUFRURIMDxk7JKXfRMM/mhvupT41cYVxDqI5sNNR6o+7jIWGV6alsxW5x/VsbbhZSFp8B/Rz4tYl6jzBNFOUjuPrFf4uxM8q4=
Received: from SN4PR0501CA0009.namprd05.prod.outlook.com
 (2603:10b6:803:40::22) by BN7PR02MB5155.namprd02.prod.outlook.com
 (2603:10b6:408:22::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 18 Aug
 2020 19:37:56 +0000
Received: from SN1NAM02FT0054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::31) by SN4PR0501CA0009.outlook.office365.com
 (2603:10b6:803:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend
 Transport; Tue, 18 Aug 2020 19:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT0054.mail.protection.outlook.com (10.97.4.242) with Microsoft SMTP
 Server id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 19:37:56
 +0000
Received: from [149.199.38.66] (port=37951 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1k87QP-0004DA-QM; Tue, 18 Aug 2020 12:37:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1k87Qh-00084v-VZ; Tue, 18 Aug 2020 12:37:56 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07IJbmO8007868;
        Tue, 18 Aug 2020 12:37:48 -0700
Received: from [172.19.2.244] (helo=xsjhyunkubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1k87Qa-00084D-6P; Tue, 18 Aug 2020 12:37:48 -0700
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
        id 193662C69E9; Tue, 18 Aug 2020 12:32:32 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:32:32 -0700
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] dmaengine: xilinx: dpdma: Make symbol
 'dpdma_debugfs_reqs' static
Message-ID: <20200818193231.GA13699@xilinx.com>
References: <20200818112217.43816-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818112217.43816-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20164a27-cfab-4d02-3cb0-08d843ae34d3
X-MS-TrafficTypeDiagnostic: BN7PR02MB5155:
X-Microsoft-Antispam-PRVS: <BN7PR02MB51552BD6F8D1253EC98A9A5FD65C0@BN7PR02MB5155.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAMlFW2YwLd7eQP89UXe5YluqAOa3sEOj8ZoR6m665eNGI+vtxV1OJeNrCunqnLYjSkghLwp9wsiG9uoE81esJEjl5fyd3vMIzWnklZhicHsIAUtsgYPiyvy0QV4pS5Wg1Tt+1xb82V1a7oBhU6UMrqbZJOno1bAyXPFGpozV3/7fX01Rg9AtX2XKKR2yqMxqe/12XrHdSSExaLvAfz8Viium7SD6U9WxmbPgNBVI3QXMpPFiGDTPn0GIJLbQ7ONFvLzPCb65vFR3R3Oh/HNWGdkVa9sKF0T+S4YjObDmdXP2zU+3KfUdh3vVPGhkIJJ1LFdMn6bSbeWRVk6OcudvUcCOwZWZ+3pmnvitIitI0FeU0awC+A4M5jSjj/NEcopBtlau/4P7RjjjqnQml+d0Q==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(346002)(396003)(39850400004)(376002)(46966005)(70206006)(26005)(4326008)(2906002)(44832011)(36756003)(478600001)(8936002)(2616005)(54906003)(1076003)(426003)(81166007)(82740400003)(8676002)(316002)(42186006)(6266002)(336012)(6916009)(70586007)(33656002)(5660300002)(47076004)(83380400001)(82310400002)(186003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 19:37:56.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20164a27-cfab-4d02-3cb0-08d843ae34d3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5155
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Wei,

Thanks for the patch.

On Tue, Aug 18, 2020 at 04:22:17AM -0700, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/dma/xilinx/xilinx_dpdma.c:349:37: warning:
>  symbol 'dpdma_debugfs_reqs' was not declared. Should it be static?
> 
> This variable is not used outside of xilinx_dpdma.c, so this commit
> marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1d220435cab3 ("dmaengine: xilinx: dpdma: Add debugfs support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Hyun Kwon <hyun.kwon@xilinx.com>

Thanks,
-hyun

> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 7db70d226e89..81ed1e482878 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -346,7 +346,7 @@ static int xilinx_dpdma_debugfs_desc_done_irq_write(char *args)
>  }
>  
>  /* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
> -struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
> +static struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
>  	{
>  		.name = "DESCRIPTOR_DONE_INTR",
>  		.tc = DPDMA_TC_INTR_DONE,
> 
