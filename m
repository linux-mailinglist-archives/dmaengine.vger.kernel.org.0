Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1FE497F20
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jan 2022 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiAXMSN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jan 2022 07:18:13 -0500
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:21582
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238021AbiAXMSM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jan 2022 07:18:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKeRHf3PK1e7zr8fc7M1oR1mZp6FrKiGtCnIj/791UgVZvsbqKQPFM4T9a24J2vTkADuZD2gpD1tO/fooug4cFxd7A52ZD8kJ9LeTIT8aMqJ8T5hAZ71TBmkDsWVjRp1vu8zstBH6N9uWTUvYXn1hjta13kKDxgtYQWZP3xkcEkTmbBkjnQw1aXm3tFUL6Uec65WefbbVPN0ObfKhXp8HMSrKT24Dnmk1+oS8eOFY8umJ0hPO4aOSjvIgWRsc6VvevGAFPsfR+Vzgm3brU/WDbCWFEVXV6SgFEtRgcORJUhs7/uFOhd8qP6JBPNY/O91qvKPfTWemnyGLQUfEuKdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJmNi2jwNhrfVx8DjXWJHvlMRh+x2RfKfEz9Zi7MrPY=;
 b=UPIR4MeTt8IuaS8gmgNwFutelcjmYGYfXVmwJ8TB3pL1qcNVizaFtLSYRghOdjAP+Jl3CMkp//Yi+RdGXT0J4NbPFrF9hQLcBp0NSn2sYE/eGPLGbjQ3NijltnRgKeV/jhUqwKhKtRLD+8IHBqA/qn30Vl/gWsHGp3LeSXyB+EVqbbPB9mnN9zatp6R+l9z9x38YUxHOoy8O6tPg4tEtM0F4a7tp5xfcJh3/8CKWFp38fR/SFAjwPyPZyxHnJiiDADf+GJDx/5goYQvyGm5AkKtWmIjQsMutvXTsMAg6tPfJQHxNKGsRJ6x9nGvreNlyCUEhwUnnyJYkLu4ysGQNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJmNi2jwNhrfVx8DjXWJHvlMRh+x2RfKfEz9Zi7MrPY=;
 b=dN5jDjOiUwcOhhfGw2zfS9LGPp4NtIR5yzBdHUGhCCYpuYPbCv/HywekI1S9sBQZ7oxDRWW92gfEMQU/Ggrqp0Zk+/9WJWcelv4i09x7Pri9Grpp8Oo1B8lXRWt48w0JevxnxKtzzk0BGSjc+NHBnP0FWAHOLdaXnweLkTCUpuM=
Received: from DM5PR15CA0041.namprd15.prod.outlook.com (2603:10b6:4:4b::27) by
 BL3PR02MB7955.namprd02.prod.outlook.com (2603:10b6:208:356::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 12:18:10 +0000
Received: from DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::87) by DM5PR15CA0041.outlook.office365.com
 (2603:10b6:4:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Mon, 24 Jan 2022 12:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT064.mail.protection.outlook.com (10.13.4.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Mon, 24 Jan 2022 12:18:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 24 Jan 2022 04:18:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 24 Jan 2022 04:18:09 -0800
Envelope-to: m.tretter@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org,
 robh+dt@kernel.org,
 kernel@pengutronix.de
Received: from [10.254.241.49] (port=59896)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nByIS-000FvZ-MV; Mon, 24 Jan 2022 04:18:09 -0800
Message-ID: <31b2312c-ce95-a1c3-6d52-710a28af2741@xilinx.com>
Date:   Mon, 24 Jan 2022 13:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] arm64: zynqmp: Add missing #dma-cells property
Content-Language: en-US
To:     Michael Tretter <m.tretter@pengutronix.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <kernel@pengutronix.de>
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
 <20220112151541.1328732-3-m.tretter@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220112151541.1328732-3-m.tretter@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e353dee6-289e-445a-6654-08d9df3395c7
X-MS-TrafficTypeDiagnostic: BL3PR02MB7955:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB7955D1AA0D3F2036F45123BFC65E9@BL3PR02MB7955.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukdB9UdRiBxSy3FB2f6lIC756c9ay6BPu2wqpu0izJAgYWCd7L+bjjwuJo7DeZEiw6Dhp/xK9ZKi+tCuWkrCF3AsXvyyLMaHgIM6upz1wGXAlG+ZA9h0xCpnzw5BjbGWXjz6LHxiqB1vtN944pMdIwmzr6LFuAVkggxnMdb4d4+IeT25fxuBBbLPCp4bFBS2cxt99O0GApjOG6dI0CPs3PTsMx1dDmoRInYvDdHY1rzdZVbHS/Mnz+ETkod0kw3JRSAZ6w1jkmWKOhKyHVMfn5IguLQVppRVyBOpN6Ry0Zm6Uo08nUEQtFr9KBQgCFyAWKomyo0kIGEVVJnlTw8Ju+vRckRoM4D+jlu+OQzBCBpWUD6rlZYlmlNIhbz/LOy/vRtnQ0eNFG4Lm1sTbGAXXk4awD9YkW2wCk6VCiRIBGcObDZ/0vQxktmLPtTh8bVT47sY70INsXi4pEZAYtKw1oZh5pmGfXhkCjer0JmoRxZ3EZSd0FF3LvpsdhRQLY0DPjYRG76LEAoy7yaB2H8N92Om3ia2BUVhBbQFW8fBC+A7/dQrE3EEhKZSzhETDBgjplQTYZ6oG5/BM3tJklvxR8YnCEf6LQ5VjZiJks5ggGst1i+f9VPXnL2UwiPwMG5xGjjglrCUGc/UpMFc0TgMtdFyFhgMoTjXNdGpGNGojegnS9TFd9oX3ycAyV0a5qA4wk551xH75gsgU7reqx0JoR5ZUju1TxIg7GycVzMtkz1hr6fAeOj2a53jCBwoIW7rTtSgU+DXkwPtx3MIRGCJMw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7636003)(336012)(36860700001)(2906002)(508600001)(5660300002)(6666004)(186003)(53546011)(9786002)(70586007)(2616005)(356005)(44832011)(426003)(82310400004)(26005)(83380400001)(316002)(4326008)(31686004)(54906003)(110136005)(8676002)(8936002)(47076005)(31696002)(36756003)(70206006)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 12:18:09.7897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e353dee6-289e-445a-6654-08d9df3395c7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7955
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/12/22 16:15, Michael Tretter wrote:
> Requesting the dma controllers fails if #dma-cells is not defined. Add
> the missing property.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 493719f71fb5..6d96b6b99f84 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -261,6 +261,7 @@ fpd_dma_chan1: dma@fd500000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 124 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14e8>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -273,6 +274,7 @@ fpd_dma_chan2: dma@fd510000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 125 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14e9>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -285,6 +287,7 @@ fpd_dma_chan3: dma@fd520000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 126 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14ea>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -297,6 +300,7 @@ fpd_dma_chan4: dma@fd530000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 127 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14eb>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -309,6 +313,7 @@ fpd_dma_chan5: dma@fd540000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 128 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14ec>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -321,6 +326,7 @@ fpd_dma_chan6: dma@fd550000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 129 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14ed>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -333,6 +339,7 @@ fpd_dma_chan7: dma@fd560000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 130 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14ee>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -345,6 +352,7 @@ fpd_dma_chan8: dma@fd570000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 131 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
>   			iommus = <&smmu 0x14ef>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
> @@ -374,6 +382,7 @@ lpd_dma_chan1: dma@ffa80000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 77 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x868>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -386,6 +395,7 @@ lpd_dma_chan2: dma@ffa90000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 78 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x869>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -398,6 +408,7 @@ lpd_dma_chan3: dma@ffaa0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 79 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x86a>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -410,6 +421,7 @@ lpd_dma_chan4: dma@ffab0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 80 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x86b>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -422,6 +434,7 @@ lpd_dma_chan5: dma@ffac0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 81 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x86c>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -434,6 +447,7 @@ lpd_dma_chan6: dma@ffad0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 82 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x86d>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -446,6 +460,7 @@ lpd_dma_chan7: dma@ffae0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 83 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x86e>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
> @@ -458,6 +473,7 @@ lpd_dma_chan8: dma@ffaf0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 84 4>;
>   			clock-names = "clk_main", "clk_apb";
> +			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
>   			iommus = <&smmu 0x86f>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;

Applied.
M
