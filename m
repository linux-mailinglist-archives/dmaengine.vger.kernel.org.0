Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44E136923
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAJIs2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 03:48:28 -0500
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:37793
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727164AbgAJIs2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 03:48:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcmwc4kOdqWHYVCXWe3CVWGWZ8pAu+DnNis0kkdmuZ5mhhhgX6ChmKGDbUESAcKA1xSAFp8JYx5FsPJiYvK3DmCgaZ+7QeHbqbBegOXgyr3vZw5LBZtWPQ3iIOryVDFi3uUDNjGTEePl3waCa2B+FwjD1U33CEXFIoftk5QOW23bmomaShgESiGyLtL+HXvPJcmLIrxJFw6I3BTr6Kt89MSIcol3e7phzWsbmhSJNouhc7ArEKH83rqoEDoxJ4JMHh2DEvfyXl4XHJ2GKu2L8IvlT4Vh3oXfLhDVjQjed+saSfJn7F8hZB5pkekDbrGZ+mY9bwa0kxa867zQ2/pxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuuPUTfWmZ+dbKri9hg78PRUUPVjFwTaW9PN5PIcZnc=;
 b=gTWevHPg947YJZReiWq5+77OYZsMWVfFNpna6FWrojtw81v67JUxMW5zqK36sEnjXveYPPKEdJp93iwRJHuTc+yVFP9Y/5ST3BEUZejSHxz6g7qRSZuNAZ4oYybYYbP7YVhr3WEmewuoFQhm871xpJOmSRtleG2N57JjwVegKVn1Wt1oG6Nf60GMGapTqPDklSf/1UqbL7zOw+lmD7fahNteF1VeDahjawAYWJqcijpzpmj7MhNReo1IUPN/KQNBJOE6zfVvf1wt5XC2W5qtRxPOKhwo1uP5S9jj7oaEqUg/L0KGpJx7b+of7hGeDtFraiOErHeXNEFvVQ7vNWCP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wolfvision.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuuPUTfWmZ+dbKri9hg78PRUUPVjFwTaW9PN5PIcZnc=;
 b=SCT6zbDQ6WYIM3lz218aHw2RfQKWeKdDDNAlD7DSR+nsCIjcAFHUjCuy0ahdWwfhM2uo2Fm5VyZh4jYGWWXIhuyu6k9WBsn3VdB+KYaGyGT79LxZTHO8L2hnJyQkdKDN3TT67oGBJRyjlwaZqFg3Mqxmqk6+LwIYhScSgCxCmLI=
Received: from CY4PR02CA0036.namprd02.prod.outlook.com (2603:10b6:903:117::22)
 by BN6PR02MB2355.namprd02.prod.outlook.com (2603:10b6:404:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11; Fri, 10 Jan
 2020 08:48:25 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR02CA0036.outlook.office365.com
 (2603:10b6:903:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Fri, 10 Jan 2020 08:48:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wolfvision.net; dkim=none (message not signed)
 header.d=none;wolfvision.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Fri, 10 Jan 2020 08:48:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ippxw-0001Zo-Eq; Fri, 10 Jan 2020 00:48:24 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ippxr-0001DN-Au; Fri, 10 Jan 2020 00:48:19 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00A8mIi6014248;
        Fri, 10 Jan 2020 00:48:18 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ippxq-0001D4-5D; Fri, 10 Jan 2020 00:48:18 -0800
Subject: Re: [PATCH] dmaengine: zynqmp_dma: fix burst length configuration
To:     Matthias Fend <matthias.fend@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        vkoul@kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>
References: <20200110082607.25353-1-matthias.fend@wolfvision.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <137545d8-466d-e2f6-1e3e-8879dcee423d@xilinx.com>
Date:   Fri, 10 Jan 2020 09:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110082607.25353-1-matthias.fend@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(426003)(336012)(186003)(31686004)(478600001)(81156014)(2616005)(26005)(70586007)(8676002)(44832011)(70206006)(4326008)(36756003)(81166006)(8936002)(9786002)(5660300002)(107886003)(54906003)(316002)(356004)(31696002)(6666004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2355;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea40be5-16f4-4a00-49b6-08d795a9dae6
X-MS-TrafficTypeDiagnostic: BN6PR02MB2355:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2355D805B17FB5B977C9411FC6380@BN6PR02MB2355.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02788FF38E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEkP89caZXCns8EF83ee31fbjBppeF8Q/PAzJG8kdNc/4jR+/8lYZVO4YMclai+7mJjmVwkQcB455nI9v0F2NjgtSAEohx9ZQK6cxYc5fEVV4EGSGPXuFh4qIFsaKuxtX8tix9Ehi9Bhv1Sdq4UqmfL8lbLFMmY0a7CfLObgllMZTR+hs9GK9snFQ3nbNrAyXLsS8jfbVQsBtgWH8dPaP//eNWc8gRMh00Ll2EK9BMVtG4k+qdHt/NMQLH2L5MuoM99Iwu2oBXwsq1eDzf/+eYu2+x79cfhx3kINXw5ITj1Lr6f0ksTCiqdUbQ94B/CSJcIPcIY19Mz+7C/cmqBu+1hzEFlkZi6oTTux/K3dTUMgf1F25lqYY6AxA6WsNBsaAeFFQuQx4RTZVoWc/auOJ7bWDk4u4GS4p2V+6NyLC/WJ3C770fn617n8M2VinXqj
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 08:48:24.9020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea40be5-16f4-4a00-49b6-08d795a9dae6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2355
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

+Radhey and Harini

On 10. 01. 20 9:26, Matthias Fend wrote:
> Since the dma engine expects the burst length register content as
> power of 2 value, the burst length needs to be converted first.
> Additionally add a burst length range check to avoid corrupting unrelated
> register bits.
> 
> Signed-off-by: Matthias Fend <matthias.fend@wolfvision.net>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 9c845c07b107..aa4de6c6688a 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -123,10 +123,12 @@
>  /* Max transfer size per descriptor */
>  #define ZYNQMP_DMA_MAX_TRANS_LEN	0x40000000
>  
> +/* Max burst lengths */
> +#define ZYNQMP_DMA_MAX_DST_BURST_LEN    16
> +#define ZYNQMP_DMA_MAX_SRC_BURST_LEN    16
> +
>  /* Reset values for data attributes */
>  #define ZYNQMP_DMA_AXCACHE_VAL		0xF
> -#define ZYNQMP_DMA_ARLEN_RST_VAL	0xF
> -#define ZYNQMP_DMA_AWLEN_RST_VAL	0xF
>  
>  #define ZYNQMP_DMA_SRC_ISSUE_RST_VAL	0x1F
>  
> @@ -534,17 +536,19 @@ static void zynqmp_dma_handle_ovfl_int(struct zynqmp_dma_chan *chan, u32 status)
>  
>  static void zynqmp_dma_config(struct zynqmp_dma_chan *chan)
>  {
> -	u32 val;
> +	u32 val, burst_val;
>  
>  	val = readl(chan->regs + ZYNQMP_DMA_CTRL0);
>  	val |= ZYNQMP_DMA_POINT_TYPE_SG;
>  	writel(val, chan->regs + ZYNQMP_DMA_CTRL0);
>  
>  	val = readl(chan->regs + ZYNQMP_DMA_DATA_ATTR);
> +	burst_val = __ilog2_u32(chan->src_burst_len);
>  	val = (val & ~ZYNQMP_DMA_ARLEN) |
> -		(chan->src_burst_len << ZYNQMP_DMA_ARLEN_OFST);
> +		(burst_val << ZYNQMP_DMA_ARLEN_OFST);
> +	burst_val = __ilog2_u32(chan->dst_burst_len);
>  	val = (val & ~ZYNQMP_DMA_AWLEN) |
> -		(chan->dst_burst_len << ZYNQMP_DMA_AWLEN_OFST);
> +		(burst_val << ZYNQMP_DMA_AWLEN_OFST);
>  	writel(val, chan->regs + ZYNQMP_DMA_DATA_ATTR);
>  }
>  
> @@ -560,8 +564,10 @@ static int zynqmp_dma_device_config(struct dma_chan *dchan,
>  {
>  	struct zynqmp_dma_chan *chan = to_chan(dchan);
>  
> -	chan->src_burst_len = config->src_maxburst;
> -	chan->dst_burst_len = config->dst_maxburst;
> +	chan->src_burst_len = clamp(config->src_maxburst, 1U,
> +		(u32) ZYNQMP_DMA_MAX_SRC_BURST_LEN);
> +	chan->dst_burst_len = clamp(config->dst_maxburst, 1U,
> +		(u32) ZYNQMP_DMA_MAX_DST_BURST_LEN);
>  
>  	return 0;
>  }
> @@ -887,8 +893,8 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>  		return PTR_ERR(chan->regs);
>  
>  	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
> -	chan->dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
> -	chan->src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
> +	chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
> +	chan->src_burst_len = ZYNQMP_DMA_MAX_SRC_BURST_LEN;
>  	err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "missing xlnx,bus-width property\n");
> 

M

