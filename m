Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F969EDA5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 04:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjBVDwD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 22:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjBVDwC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 22:52:02 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3940231E00;
        Tue, 21 Feb 2023 19:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABzH+s1EL4FkCZ71O1kSznfDcwm4SFxVSvePD+Eh7MAAPbOw3iWgwH95f1oCscgSudRwo/hj7scQxy/PVvbNxtrp+5q8dBmBDFD+j2J+BOQDSxBW0EYPfJCJGM9Q9qoqGV1AXTcln4Iy/S4qldWMoL74C97cNF2fsQWDTaBNj5doaDCgyFFM7uSS9SLlQtChGoYl/lJ8fnCCk83HEjzmX+ikMu1tV1hxqot3SaWAHTaeMOMlip16A58t0EIzS1Nf0ZLDKkYXaRPes+YaAw/zqOhh0a3GESzEVKC4qn/Qu9/B4yS+76/65tyad/03YjUCtwYgoxfC94R5DnGIYWwSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVRl6TtgOunY9KBtpnGGPkSPXKsvO0IN7+KVMe5kWtc=;
 b=BS83S2xAWm9MlrMQ2jux91p//flmZTMXBKxwh0MsWbUesrXv7YRepgEq9wrNvVzFhGRW7TqKcRRph+E7aLHxosYvKAUdzqN3qlxsPL2tHOHRkt8v22TLxTnDw+PXaz8oTSu6SbN6H/uezJVfa33XBsLxP6ZHKblEBIKp3M/6oiogDq2y+Dh67lP5Zle6ErP7krXqPUtmlpuPZvdtCn10ImNkBpLrMwPSKCWHB2/la3L5joUyPw6dxBD8H6lhhLzfi0JlQVygFLUWyJ4VOtLVtAh3pMdBB4vKlrmHxc05SYDuHJvaVB52KltgXkqidaEPXaRg1u0x9b91g8PpH1OiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVRl6TtgOunY9KBtpnGGPkSPXKsvO0IN7+KVMe5kWtc=;
 b=ZXzWNyfjOKIrFgV7skyH+E73+/AlJdXa9+Wu9mKjlwhGf+v3PXB2V/tkTu0GnOwFjs7Ff+U8yvvU0a69+2GHcPx6t147XWixc5+mo/ZTttROarYaVC/tV9ph1pmylwZ/TUXR96RxjghHbcDewjEgWWxXo7/+o50+cUUcT8ZPHdc=
Received: from DM6PR07CA0043.namprd07.prod.outlook.com (2603:10b6:5:74::20) by
 PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 03:51:58 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::48) by DM6PR07CA0043.outlook.office365.com
 (2603:10b6:5:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 03:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Wed, 22 Feb 2023 03:51:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 21:51:57 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Feb 2023 21:51:56 -0600
Message-ID: <6da2e72c-661c-e4de-f563-e06f045414ae@amd.com>
Date:   Tue, 21 Feb 2023 19:51:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH V12 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
 <1675969514-3137-2-git-send-email-lizhi.hou@amd.com>
 <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
 <0f1aafa2-7495-163b-523a-f634bacc4b1f@gpxsee.org>
 <CAMuHMdUVkbPf1a8cW+zY1HwD83tm_m0L7Ufy=GO-RQB-AF_15A@mail.gmail.com>
 <aeb43671-57fd-654a-8e8d-d14ebb7f4083@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <aeb43671-57fd-654a-8e8d-d14ebb7f4083@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 71accfcb-c39f-4f64-20b8-08db1488256e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUhp3Q6lo4aOZ0kP0wu1+KP6Gi8gX6uHZ8Rs7S3eHZcGuTqQfSjH3QDpfZjyIGAcwYjks4OhSWRwxv+LK9eVuysEv7C68zyj2jTp4c1wmM+yzNoPTTJtoeemXNwZWf5FkqT6zzq8a7gie8zhT3JnzDuIOqsS8meReONdN+qWA1pesNtsxemr0Rk6w7O7uu+r8P7AcTp1gRofrgvweeLdYGHgr+/qRR63NGqgwoOP3+Vjm8BlREaQa/tPd3svqz0vCwu9Yklo9wuz3qCwMPgD/7Xk/QAW3mFFn02xiAg5pE3DzLjEKDvnpN16ZSvS0IQEonWqdKt9fbgrZ71mZTd57TSHvHQRzzghVtY2V1cdaEBx0eJ/aR2nXsKLdBJCGIke8/QKcQ+WZaAxE/6Q7WQ8aAXA2/75e4yIu9MDlnP2/3A1yqIlo3Ql9yU+TrcXJvXGDE8otOrNtNAkYcHNEAIwB+vh7QpyV0E1sZLx+tIEn0ZvUbb8gs7quCY2u4wGYGzkxIJTfhOtYfaH0V7R9iLo39wRQWzc6pu+XLVCmr/LZmE9dp2f33gQHxSjKrui0LEOpE9FfQS29i/IBsBxobaQnW0NaechnzP6W/7PQUrKM8Iuq2xyzDnvvUIocTplQgNh2enE1XoMRSnwgbZjdqnTZzq0s+SW4HUeEVEVzg7yukplDfvtczKiQPNnIpAsuV1T6L8vIHRAE01wgl53Cvr++igwKXNOCvRD91QTXYIPSk6cRNKkDCkzmw5Kih64gsYGawiAAJ8SJqKVu9RJPckoe4yxz0bvfFEMke+EmFdu5n0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(966005)(26005)(186003)(31686004)(4326008)(70586007)(40480700001)(8676002)(70206006)(5660300002)(8936002)(2616005)(53546011)(36756003)(336012)(426003)(66574015)(47076005)(478600001)(40460700003)(16576012)(356005)(41300700001)(54906003)(316002)(110136005)(44832011)(31696002)(86362001)(82740400003)(82310400005)(2906002)(81166007)(36860700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 03:51:57.8201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71accfcb-c39f-4f64-20b8-08db1488256e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/21/23 13:46, Martin Tůma wrote:
> On 21. 02. 23 22:06, Geert Uytterhoeven wrote:
>> Hi Martin,
>>
>> On Tue, Feb 21, 2023 at 9:45 PM Martin Tůma <tumic@gpxsee.org> wrote:
>>> On 21. 02. 23 14:25, Geert Uytterhoeven wrote:
>>>> No platform dependencies at all, while this is a platform driver that
>>>> relies on some other not-yet-existing driver creating an "xdma"
>>>> platform device?
>>>
>>> There is at least one "already-existing" driver based on this driver
>>> that is waiting in the v4l2 queue for xdma - our MGB4 driver:
>>> https://patchwork.kernel.org/project/linux-media/patch/20230207150119.5542-2-tumic@gpxsee.org/ 
>>>
>>
>> Thanks for the link!
>>
>> As VIDEO_MGB4 selects XILINX_XDMA, perhaps XILINX_XDMA
>> can be made invisible, unless compile-testing?
>>
>>      config XILINX_XDMA
>>          tristate "Xilinx DMA/Bridge Subsystem DMA Engine" if 
>> COMPILE_TEST
>>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>
> Hi,
> I think that the XDMA driver will always be used by a superior PCIe 
> card driver like in our case (mgb4) and using it separately makes no 
> sense/is not possible, so disabling it until some of the superior 
> drivers selects it makes sense for me. But what about out-of-the-tree 
> modules based on xdma? Making the module "invisible" will make compile 
> them much harder I guess? And there will be proprietary drivers based 
> on xdma, see Xilinx XRT: 
> https://github.com/houlz0507/XRT-1/tree/xdma_v4_usage
>
> The xdma authors from Xilinx will definitely give you a more 
> authoritative answer. I'm just a "random" user of the xdma module. 
> Originally our mgb4 driver was based on our own xdma sub-driver (in 
> turn based on some old "test" driver from Xilinx) which I was glad we 
> could abandon when this xdma driver has appeared. I helped the xdma 
> module to become usable for PCIe cards like our v4l2 grabber, but the 
> original intents of the xdma driver are unknown to me. If it is XRT, 
> than Xilinx will probably like the module to stay visible.
>
> M.
>
There are PCIe devices which use the XDMA IP and would use this xdma 
driver. Out of tree drivers for Xilinx/AMD Alveo devices can switch to 
this in kernel xdma driver.


Thanks,

Lizhi

