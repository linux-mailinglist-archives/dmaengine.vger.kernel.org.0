Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CCF497F22
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jan 2022 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiAXMSY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jan 2022 07:18:24 -0500
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:33056
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238021AbiAXMSX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jan 2022 07:18:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NciyY9eEwb6HZYJfbOfeNo7bPRZUq2cb+0ldUlRj7Tj3N8SgMkc/slBcG0z1qTlg0MIFZN8IhYec8qOqil7ApQNs2MY9y2uxsnOrFQNA83URut0oblqicpJOhuRwRfdy7usKCZOZT+xdaGZaxB4XuAKU/SluQH3/0exzgvV6jBAZ6Q7hIJUyzoStgZwVCZHBwJwEW5LqPpw1BCMM9c4E6gP9IjS4Xuye5nRqNS7M3O0p/ytJs2rDyzhURE8tbXZ1fH6b2hIeLiylCBLiS4Sx2mS04OR38o47RpRuLnHvZGhN75uFxYpaEMWXqlqJCrF73tWWDNEdF9ZS5cs5VdY+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evPuH7fCdF9bY6udSe1ME4RqG7+n/XavYFvIXNnk19c=;
 b=aDc7pkWV3E2mj0IbqIlVOFL3x/boabnMs6V5E21xIanYod4KEhkxktZBhlLeAODqpWvHQxDorc0wkMMRWGl3n9922TLNUOVdgXb/JY+5+yGcVKA1Lia1SY9l4r0Xx1UGpRiMJe6NOLrzBYzrGHbI94eoiNQijhj98mVpvi1VrhXOjFgcZaFl0ki/JTIHYmDWbDDYKZqjVrTEotvlNzDKvV+oEMmJtobqX7ecOjxV84l1KOFPGZh/z4F7EXZGy2CbrzStomkgKM9VxE6S5DHfYamSLyMxvFtgpfMtdIM9yZu0an/S+1onjo96DSN2aG3L005dhrpwa9ukvR6l4FESiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evPuH7fCdF9bY6udSe1ME4RqG7+n/XavYFvIXNnk19c=;
 b=D60apjGc1YZeUcuY4MvZbw/Ine299QgnfE8F5sLXaIFLQX5N6kS8b6gQjCy928t6h06RN5mVHPv3d6l4ykPJVbuMyqQv9ZqY2vL/2ObDPclb8FLHkTEWB9uJsZ0AOTPHBWwbnglf0ZpoDzcyOxMjfhbgf2M4vH0MDpMZCP5wAJ8=
Received: from SA0PR11CA0060.namprd11.prod.outlook.com (2603:10b6:806:d0::35)
 by SN4PR0201MB8837.namprd02.prod.outlook.com (2603:10b6:806:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 12:18:20 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d0:cafe::72) by SA0PR11CA0060.outlook.office365.com
 (2603:10b6:806:d0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Mon, 24 Jan 2022 12:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Mon, 24 Jan 2022 12:18:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 24 Jan 2022 04:18:19 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 24 Jan 2022 04:18:19 -0800
Envelope-to: m.tretter@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org,
 robh+dt@kernel.org,
 kernel@pengutronix.de
Received: from [10.254.241.49] (port=59912)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nByIc-000FwE-Nv; Mon, 24 Jan 2022 04:18:19 -0800
Message-ID: <1ec5717e-114e-8694-4ba9-43f0407a7288@xilinx.com>
Date:   Mon, 24 Jan 2022 13:18:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] arm64: zynqmp: Rename dma to dma-controller
Content-Language: en-US
To:     Michael Tretter <m.tretter@pengutronix.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <kernel@pengutronix.de>
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
 <20220112151541.1328732-4-m.tretter@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220112151541.1328732-4-m.tretter@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6218a30-9fb5-4a5c-93ad-08d9df339bff
X-MS-TrafficTypeDiagnostic: SN4PR0201MB8837:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB88379AD789A944B8691BF814C65E9@SN4PR0201MB8837.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCj9DI4SCxFzKOTjU0+8bF4l6/THsGXOfKaP0EWyGJLuBGQo6cyx0vbsKWQaF7TOy3wfsJfEf58IVoTRTPp8OOPO60kU2Z7fohuo9NyXIKot//UhG60fSnaWgoKv69jb4Gmr05DdgbufxlI68zC64u2kroxz/JzSHfC8EqM0eRrI9toRP9jjRBzPDk6axdWehQ0QpDRuqG+KKS+vDjL2255hkKdj77q8TWtEPaJb3EDYQu3Zv8FV4U+AJ4CtsvCSMMnlVHlsiOUMptsIe/oYir1NDyAmwC0icKou6RqZDCi1QC2RcuTDPYC6dZdcIrr9/4urN7imRIoonkfDfdxUZuwqKokIOycOME4/VNzZuMpKZk6uCCskeMeZBig0wTNKl8pGt9JHmeMgTkXmGRhYbWjFiuR9ULufW4MeD+JE0874qndONElzh0m788+jadsYEAqUkBp1A6l2NLJw32yqFkWxpxaL5kuzyCjg9HGznvCZBiXydWybXH3hd1Sgi+RY/AuI/1qwFhMslRQT1QGSAoYhxD1OKiSvo8VQCRdjl5EclDBG0knB8dxgkGoSe/vemqNkl5k0qVIRngqUt9AH/N6poKlBDQht+cLvNFzz+u34SU7rPb+LMv2ln+0VsdJXHX3OVzFPcHYFEijIctnVJEVi3qEM27Gybgn9dmEvjk80xkKSk9zXIxNTifrVP1xzV/1qWlonR0zl5BXmVSZTSpAjebpEUSxYXh+SeuL5AGWDLuw9HdEJ/C2p5Bwz4xEo
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(31696002)(2616005)(47076005)(70586007)(53546011)(9786002)(36756003)(426003)(6666004)(31686004)(336012)(70206006)(4326008)(7636003)(356005)(5660300002)(82310400004)(316002)(508600001)(110136005)(8676002)(54906003)(26005)(83380400001)(44832011)(8936002)(2906002)(186003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 12:18:20.2398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6218a30-9fb5-4a5c-93ad-08d9df339bff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8837
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/12/22 16:15, Michael Tretter wrote:
> The ZynqMP dma engines are actually dma-controllers as specified by the
> device tree binding. Rename the device tree nodes accordingly.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 32 +++++++++++++-------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 6d96b6b99f84..3e15391e5b37 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -254,7 +254,7 @@ pmu@9000 {
>   		};
>   
>   		/* GDMA */
> -		fpd_dma_chan1: dma@fd500000 {
> +		fpd_dma_chan1: dma-controller@fd500000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd500000 0x0 0x1000>;
> @@ -267,7 +267,7 @@ fpd_dma_chan1: dma@fd500000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan2: dma@fd510000 {
> +		fpd_dma_chan2: dma-controller@fd510000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd510000 0x0 0x1000>;
> @@ -280,7 +280,7 @@ fpd_dma_chan2: dma@fd510000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan3: dma@fd520000 {
> +		fpd_dma_chan3: dma-controller@fd520000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd520000 0x0 0x1000>;
> @@ -293,7 +293,7 @@ fpd_dma_chan3: dma@fd520000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan4: dma@fd530000 {
> +		fpd_dma_chan4: dma-controller@fd530000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd530000 0x0 0x1000>;
> @@ -306,7 +306,7 @@ fpd_dma_chan4: dma@fd530000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan5: dma@fd540000 {
> +		fpd_dma_chan5: dma-controller@fd540000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd540000 0x0 0x1000>;
> @@ -319,7 +319,7 @@ fpd_dma_chan5: dma@fd540000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan6: dma@fd550000 {
> +		fpd_dma_chan6: dma-controller@fd550000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd550000 0x0 0x1000>;
> @@ -332,7 +332,7 @@ fpd_dma_chan6: dma@fd550000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan7: dma@fd560000 {
> +		fpd_dma_chan7: dma-controller@fd560000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd560000 0x0 0x1000>;
> @@ -345,7 +345,7 @@ fpd_dma_chan7: dma@fd560000 {
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> -		fpd_dma_chan8: dma@fd570000 {
> +		fpd_dma_chan8: dma-controller@fd570000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd570000 0x0 0x1000>;
> @@ -375,7 +375,7 @@ gic: interrupt-controller@f9010000 {
>   		 * These dma channels, Users should ensure that these dma
>   		 * Channels are allowed for non secure access.
>   		 */
> -		lpd_dma_chan1: dma@ffa80000 {
> +		lpd_dma_chan1: dma-controller@ffa80000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffa80000 0x0 0x1000>;
> @@ -388,7 +388,7 @@ lpd_dma_chan1: dma@ffa80000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan2: dma@ffa90000 {
> +		lpd_dma_chan2: dma-controller@ffa90000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffa90000 0x0 0x1000>;
> @@ -401,7 +401,7 @@ lpd_dma_chan2: dma@ffa90000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan3: dma@ffaa0000 {
> +		lpd_dma_chan3: dma-controller@ffaa0000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffaa0000 0x0 0x1000>;
> @@ -414,7 +414,7 @@ lpd_dma_chan3: dma@ffaa0000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan4: dma@ffab0000 {
> +		lpd_dma_chan4: dma-controller@ffab0000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffab0000 0x0 0x1000>;
> @@ -427,7 +427,7 @@ lpd_dma_chan4: dma@ffab0000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan5: dma@ffac0000 {
> +		lpd_dma_chan5: dma-controller@ffac0000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffac0000 0x0 0x1000>;
> @@ -440,7 +440,7 @@ lpd_dma_chan5: dma@ffac0000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan6: dma@ffad0000 {
> +		lpd_dma_chan6: dma-controller@ffad0000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffad0000 0x0 0x1000>;
> @@ -453,7 +453,7 @@ lpd_dma_chan6: dma@ffad0000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan7: dma@ffae0000 {
> +		lpd_dma_chan7: dma-controller@ffae0000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffae0000 0x0 0x1000>;
> @@ -466,7 +466,7 @@ lpd_dma_chan7: dma@ffae0000 {
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> -		lpd_dma_chan8: dma@ffaf0000 {
> +		lpd_dma_chan8: dma-controller@ffaf0000 {
>   			status = "disabled";
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffaf0000 0x0 0x1000>;

Applied.
M
