Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231D495EB6
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbiAUL7I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 06:59:08 -0500
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:16736
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233354AbiAUL7F (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Jan 2022 06:59:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFcsZgXjyPmbrUGGiZ/avbkJBfC2RVjnDA8/0RB/qYm+nHae37eVji3ENhLiYqE9v9V9ZVGKAwayhKcYZWD1Vodb4V/aM/26oJ3K6nrrfG6OBTJ3cpbzORMTomjtjhatj/OxqmE8H2BOswmG33fWqywWRn8r2SB0fhXQ8sc4QDSjEuHuM+cTjCSux53uFY1dx+bG8bQYJi2ceUGejkkXOR1dUQ7xnUukMHkdsendwvSSwajkMjiDpBixxDMrLE+owAycqQ36AgCMSV7lAHQJ5XvlCqeClWuQiw2dWY301k5xr40mmgrzvpmQA1VHxybdQPlo6O9zJJvxVlOOBjkgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBjb+blPw4ISSR/uQ6quvqNe4X4/tkJQvPhiZkDKgxs=;
 b=UrwPZHGeDxDq1pl0m+m7Gol3lJjPSPmbH2JF0uOM+jVnwrTvKVAlyXifASs8rTxmRCwdHbVQCXxqck9zCfr0Iz8Uio91H9UoGXkJrf3Fw5WSxFMLYp8RwH4DrRP2tFB3XTH1nMzKoq7R5A200GwaPABPQD761W/FgQ+pOkYU7zbCMzHV9pqfGLzgR4bwoUNwxJxgGMV5tebOj/yT4z0iDWyhgQvsv4LbejOuflIYl6JmEEopVcnoU5kfITulzsfb9Gtsz23DuMhq5fLZE/qGCknOrx+etUvdNHZ8M6LP1NS5kwm8lLrgpOl640jKZfHDBtU2h29l+EMijZ5UNL9OEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBjb+blPw4ISSR/uQ6quvqNe4X4/tkJQvPhiZkDKgxs=;
 b=KlNXQLzSkIFib+jH+6vWOyc5QoDuIGypj7rngVYh0wwMAuhKXmAbqLIOM4+HJHnApEKuuzxSgrDuv76ptUOAGjcuuplzk4XS3kUqTzlIMsiWC6mqs8MDQqY8CAtU+MSykHV6SeNYr8SsEtNKh1AbMKyKqB6hMUpLANnu+m63b+w=
Received: from SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17)
 by MWHPR02MB3358.namprd02.prod.outlook.com (2603:10b6:301:66::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 11:59:00 +0000
Received: from SN1NAM02FT0013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::23) by SN6PR08CA0004.outlook.office365.com
 (2603:10b6:805:66::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 11:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0013.mail.protection.outlook.com (10.97.4.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Fri, 21 Jan 2022 11:58:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 21 Jan 2022 03:58:59 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 21 Jan 2022 03:58:59 -0800
Envelope-to: m.tretter@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org,
 robh+dt@kernel.org,
 kernel@pengutronix.de
Received: from [10.254.241.49] (port=51468)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nAsZH-000C6B-27; Fri, 21 Jan 2022 03:58:59 -0800
Message-ID: <b3754a86-9c1f-f2ce-cc75-d8638010aa94@xilinx.com>
Date:   Fri, 21 Jan 2022 12:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] dt-bindings: dmaengine: zynqmp_dma: Convert binding
 to YAML
Content-Language: en-US
To:     Michael Tretter <m.tretter@pengutronix.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <kernel@pengutronix.de>
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220112151541.1328732-1-m.tretter@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aca7254-e31e-49f1-20cf-08d9dcd5692f
X-MS-TrafficTypeDiagnostic: MWHPR02MB3358:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB3358C796D7C6425C99D11C76C65B9@MWHPR02MB3358.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bfp+vtSxjDrkx1IfGo1Ud+7fxXPQt36Q7NucZoscr6lJZx1sb4svEi1bp7payJl9BuD3V+R94C5L9qYXR8Iy0Ek5rJ84lvBPd6Z5FxRQzUCOPGSYGvKR2j0j7984M1sMZUJ4XmXRAC5FiJDWR5PlP8XU3RrBY2RTxVWH719RrNIwia4dEkIm7X+raqT0l19sEMJfwblEf+azbKYrKnKqJkwEeIW+hXBMYzLxy1L+ttsMI1U9YW0gAkfVoaSA4Ku94XhoznPW4a/hHOm/C4T1j6bwbeg9QUEuVB1x2HMo4lhh5XpvKlxaPgwVoexI48LrOeuzfuIcT2NZdDgcs+JQAThm4zxdvH3FvIaRo5Vuatniiv/k1Oe/t6TM2cO6UVlKWiSqyX8PaK/HKwVn2vXaL1KYx4VNnwj7z3v3iS0xD36Vk2r+00ukIn46t1MtjI1gt0MehmfbLI11QgZ+PijkdcDwgorevVlD72FkME6MKpijJal8vRQ5iRumjie9C3jPmXoX3grNvTp+b4OHNH9ivBg2Xq42gXcLcTF60gY8LSwtfsbZPyE7zLDzfPmXpMsY7jF46RhSqO07YMPCoAH/PWsZ0sT6rZ/psUFrzoEbe5ZZjY0uXel7tgZ72zPoQ5a797KneDIQBUnky2sqT1ClwI+p+mg3Jc0q2vkcuBi/LgGgtj7B0UlZqmiyW0R3t8zKKRiRrp4j0iDg0+Bt+boDT6DV9hd3OJrQfpDZVVNOwc7lfKit01VtNcdKR4KoJ5CVeqoz1Iloleq5xGMDrqRaXqr652zlWstFaDbW9+mh18Bc5dgB4wSESCc8pxEIPRkP7mLy9z2aC+NHRO/CqKNGg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(110136005)(8936002)(70206006)(316002)(70586007)(356005)(54906003)(44832011)(26005)(426003)(186003)(336012)(508600001)(36860700001)(36756003)(31696002)(966005)(5660300002)(4326008)(6666004)(31686004)(7636003)(2616005)(47076005)(83380400001)(82310400004)(9786002)(2906002)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:58:59.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aca7254-e31e-49f1-20cf-08d9dcd5692f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3358
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/12/22 16:15, Michael Tretter wrote:
> Hi,
> 
> This series converts the ZynqMP dma engine dt bindings to yaml and fixes the
> ZynqMP device tree following the stricter yaml bindings.
> 
> The series is based on https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt to
> avoid conflicts when applying the patches to the zynqmp/dt tree.
> 
> Patch 1 converts the binding to yaml, Patches 2 and 3 cleanup the dma engine
> nodes in the zynqmp.dtsi that is included by actual board device trees.
> 
> Michael
> 
> Michael Tretter (3):
>    dt-bindings: dmaengine: zynqmp_dma: convert to yaml
>    arm64: zynqmp: Add missing #dma-cells property
>    arm64: zynqmp: Rename dma to dma-controller
> 
>   .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 85 +++++++++++++++++++
>   .../bindings/dma/xilinx/zynqmp_dma.txt        | 26 ------
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 48 +++++++----
>   3 files changed, 117 insertions(+), 42 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
>   delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> 

Rob/Vinod:
Not sure how you want to split it but feel free to take 2/3 and 3/3 via your 
tree with my ack.

Acked-by: Michal Simek <michal.simek@xilinx.com>

If you want to take just 1/3 I will take the rest via my soc tree.

Thanks,
Michal

