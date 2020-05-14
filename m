Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8051D26E0
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2020 07:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgENF46 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 May 2020 01:56:58 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:2913
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgENF46 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 May 2020 01:56:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc7Z+JtgQG+srkbT/vYkRONrDEVFCagISS1QfBgKQ18NZIJll9c1Kj0yUTa637vRJhJZbmGfLRqZwu5vsie2x9YcmZVWHIv7PNUuJAyOEh2AJmTgzIkKp9kNrGrhdaKrRB0vvWIGwroPki7iXSc77OOPTFFgzXrRe/QzOmpk3o/Bln/JusW9SsnvhoBsrMlFNHvAgy+4z0txGannFDqb0zkB9bqPvAdX/xplfIeMIlNrug2CgbZo654uDHITzpf3+D+U1ZedrkiaBD4Zui+C96MwCkdgbqZoyE5UZLvj5Vvq6Pp3l+pGnq6VXSMxIRdO137KzFDPpgzXz8jsYYkiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExiM82G4LR3sSVEa2NMOQhnezsDWnbtwARHkdPyoUT0=;
 b=LDT77BC7I9sxyTzwaW+6KLA6l+C/5SARojwaCMHrNG0gU/XopZ7vDTeEqQNYX19C9RzufLL9gKly3lqTI00lyvxmyQN9w5Z6+vnM2Dk7GUxYYJHaiIaP14l3o69yB3qe9p5i36ijt/MIhphKTGA/r7oo/TL+G7rXikKLD6XnV78p3PyGNuzaGLApSJHsPIzzxjap1AAT2YbihT6Ld1VI/zyy0qq2f+C8Cu0yCryXqoVKqiJDYA7zC1YRy3fhc3/cyrwlEbUl3oG2MSb7KboYiLSsr2f/WaoEW7SnZ6mfWAt3nw2FTIKW7fNvbRGcgmBqvlSIQFeisplsOAdN1yuF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExiM82G4LR3sSVEa2NMOQhnezsDWnbtwARHkdPyoUT0=;
 b=AQ0zxAVf3y0Ds23mMLUyJg3S9zAr0iW59lkPR9pMNXjbXh/a6HXVHVk7iggxtqdpNhP2WgDewmy8VJD9uFnaBew67cdTlathfQNDCZZO3QnZ/FYejn9ZfDhzAFuCZAbkPbF/c4h6oD73j6g3jwr2U2zbyfHHbwL3htI24sbH04Q=
Received: from MN2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:208:fc::39)
 by DM5PR02MB3387.namprd02.prod.outlook.com (2603:10b6:4:6a::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 05:56:54 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::66) by MN2PR02CA0026.outlook.office365.com
 (2603:10b6:208:fc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Thu, 14 May 2020 05:56:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Thu, 14 May 2020 05:56:53
 +0000
Received: from [149.199.38.66] (port=41557 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jZ6rC-0007zj-PF; Wed, 13 May 2020 22:56:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jZ6rV-00082p-91; Wed, 13 May 2020 22:56:53 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04E5uoM4032610;
        Wed, 13 May 2020 22:56:50 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jZ6rS-00082J-2u; Wed, 13 May 2020 22:56:50 -0700
Subject: Re: [PATCH v4 6/6] arm64: dts: zynqmp: Add DPDMA node
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
 <20200513165943.25120-7-laurent.pinchart@ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4221cfb8-2193-afb5-dd1f-f0f3ac315ff4@xilinx.com>
Date:   Thu, 14 May 2020 07:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513165943.25120-7-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(376002)(346002)(46966005)(54906003)(8676002)(336012)(186003)(8936002)(26005)(426003)(2616005)(44832011)(6666004)(4326008)(31686004)(2906002)(70206006)(9786002)(82740400003)(36756003)(81166007)(478600001)(5660300002)(356005)(31696002)(47076004)(70586007)(82310400002)(316002)(42866002)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1927a87-0f9a-4713-9839-08d7f7cb9a65
X-MS-TrafficTypeDiagnostic: DM5PR02MB3387:
X-Microsoft-Antispam-PRVS: <DM5PR02MB33877D8E19C749CC63DA4EF8C6BC0@DM5PR02MB3387.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DS0lOGAgS8mdTVCLWYuOpGLbORodqP5CPVoAnDaTZU1/hIowlUtfEYApmz2wuNq26SZkg8NYd/1w6TkEBa53oWo4LFHhSp94Z3WX6VEQ+4z4rnyumhtUpjrlv6Vebpsj2YcULB/RCRSNUmGHalz7aLeaolU66dIxSRm7tT0eSqYbmpPWeOzR60w3sIcnetuqpYmzCBODww1VgdLypMlek4s5JSycxM+1viVDu5Z3O7rnW/s+1gSHUEQoEdPA91jFg4GbVToMLYM9gC0uSSB+E/J2c9DZ8a7z3zCMRE+bojLdZS6WbgJVM4NKwOsKimvNKesBgd+DSocQEbQGqcp1mFogICekpqcbUXYs8U1vJRYs4c//d4Lz5Ro4UYrRMRuEtSSt2tMw5N2xnxhgR5N4yKBMMAh17EtuSAYYe2lW1BHz0Q/Vvc9QhvbDm2pGzKI4LXvg52W3v/wGkt6hA4Prpp8MyQT0naLva/SZU6lUkZkfodM6a9b3JPBbx2y2CEZK9Oo8Eh7ICY0FU26Rw8QkVYgmdvD7psKSZxck+bg8EChECTlCONJIRBsM7Skf2g6s
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:56:53.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1927a87-0f9a-4713-9839-08d7f7cb9a65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3387
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13. 05. 20 18:59, Laurent Pinchart wrote:
> Add a DT node for the DisplayPort DMA engine (DPDMA).
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 ++++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 10 ++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 9868ca15dfc5..32c4914738d9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -57,6 +57,10 @@ &cpu0 {
>  	clocks = <&zynqmp_clk ACPU>;
>  };
>  
> +&dpdma {
> +	clocks = <&zynqmp_clk DPDMA_REF>;
> +};
> +
>  &fpd_dma_chan1 {
>  	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 26d926eb1431..2e284eb8d3c1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -246,6 +246,16 @@ pmu@9000 {
>  			};
>  		};
>  
> +		dpdma: dma-controller@fd4c0000 {
> +			compatible = "xlnx,zynqmp-dpdma";
> +			status = "disabled";
> +			reg = <0x0 0xfd4c0000 0x0 0x1000>;
> +			interrupts = <0 122 4>;
> +			interrupt-parent = <&gic>;
> +			clock-names = "axi_clk";
> +			#dma-cells = <1>;
> +		};
> +
>  		/* GDMA */
>  		fpd_dma_chan1: dma@fd500000 {
>  			status = "disabled";
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Feel free to take it with this series. Or let me know if you want me to
take it via my soc tree.

Thanks,
Michal
