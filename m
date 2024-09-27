Return-Path: <dmaengine+bounces-3229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1B9889FD
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2024 20:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00531F21738
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2024 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5346175D20;
	Fri, 27 Sep 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VNijlHmK"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9E524B0;
	Fri, 27 Sep 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461136; cv=fail; b=R5W0Wj255LBux3P+6eRzKj2aYZmLiCNNharXMfFMdHN4RuhloSPs5l7lFJUr/Bj1KJVQPMN2N+e/SQR/AOFAL6ks6r1/QFo/vqw5lyIrx/yAkBTvykBtFsXrpi7o5XUyq3iFXedkz/DzDLJWjY4i4swneEw89FAI36x8HD9qGsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461136; c=relaxed/simple;
	bh=6xHC91vMAxtzVPlKo6A1EbUsWOJEC2awGZ8rX8wxhW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SrtX2t9SdjJhPxkLVleFbkQZtWFLLLy6ZaQqDGqBMy6JVip96QvMkkOSRgUIylpQZZFefbG0lDym9ugcGHZvIxpfVM0U8oQnhM7p/lgTBCkhRHjS6RlnwKWst+iUj47fEloh54ZMNkcKS5q4s2Qp9ZCTSD5U1D9HZ23RDwA8zp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VNijlHmK; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7KsDtg0AAcqHfFFMjGaHmArArbxpGtb2MVxLb8fkFqxJ275+u7AWE6K6JKyJblde6wr5VswV72V7D/l+0l9Ilh/ifK5U5/4On/t92yEKQq2pOofIyjBeSDg7ufMY9e9aHSsM6W/AEQvZNISeSmgjKA5XHu0xCtV99r+ycgxua5QuOZ4ZiSqdQqgQeQ0YPTbzYXDy79bUyLkL+wRPsCgReiJrILCN53PyDyAWp+BOk1E7VAKkgR0cIaGgNQeltVEYml0S0HLCmCwH8OQRIVbEdgCCLjThhnIHcsxHXy5tVTyqs1oQHfkEnn66HSgyYroP1a34AmHpMQpxUHj+VFefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tTV7WPbt4ERRCnOUoEMVrk1cjYJxzVOC5/ZHSynFFE=;
 b=vD0+XeKo6XpjfpdmwGiNZ35MZiTwGiiRj/A5gQAl8NVKXmAa7doSiTv0sR2hbG4PzYdTBWGU7SENm6YyAhFjImFNqSoXrLYkJZ2kNrKSJbaH8CvT8HU9S7n4i4/zVMeH8wcO1ukDhXaHLInmzUuv9rVkrVRDsoh3CCmUUsl3vfCSxnAvS3X9F4zbfnpU1RyPBJVHUD5gU98SvI/YyHV7GOfdF8qjC61aoOnLSG6nO5c9CJCMv5BI3XBNtBlQdisHhccyxpPfTptLFuntTH5AgW4WRqeiMNiYHVL2wOVx+22QFJRYiCOOnpgBpPscwDR4BDX0mtkEdhA9izUAjBiaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tTV7WPbt4ERRCnOUoEMVrk1cjYJxzVOC5/ZHSynFFE=;
 b=VNijlHmKMw9RW1B3pVMpa7o7LcOw9bKGZBlt6kqmr7446/EN2SZN0kG/vp1iJFP2lOVayWHxTuJVt9irQcyQEsiZOVZWbo10da8+I/8QP5zthupQPKFlPb4+dO23XL8ECfMwL5FwIM/sL1BGCcMOWSm53gEORo9QQNKaEgfEasM=
Received: from CH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:32::29)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 27 Sep
 2024 18:18:51 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::80) by CH0PR07CA0024.outlook.office365.com
 (2603:10b6:610:32::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Fri, 27 Sep 2024 18:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 18:18:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 13:18:49 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 13:18:48 -0500
Message-ID: <420b4788-a054-ce74-29c9-eb8f1b7aa173@amd.com>
Date: Fri, 27 Sep 2024 11:18:48 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V12 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: <nishad.saraf@amd.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nishad Saraf <nishads@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1713462643-11781-1-git-send-email-lizhi.hou@amd.com>
 <1713462643-11781-2-git-send-email-lizhi.hou@amd.com>
 <CAMuHMdXVoTx8K+Vppt07s06OE6R=4BxoBbgtp1WWkCi8DwqgSA@mail.gmail.com>
 <e2a37bb6-3353-1c2f-3841-d63748756df1@amd.com>
 <CAMuHMdVChqbMLN2vdc4iZ7iZ8+dz07k4pVOM_SfZarHWV93JqQ@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAMuHMdVChqbMLN2vdc4iZ7iZ8+dz07k4pVOM_SfZarHWV93JqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cff71b-bc43-4a6a-addf-08dcdf20d636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkhTZnBqMjVvMHlyNEJ4Y0luZmErTlhEd0lmY3VPcTVJaVpTbmEwVUVlZ25n?=
 =?utf-8?B?ZWNrMmJ3ZkJocG5IV0VRYWhXK21qanNteVIyaG12UVdFMklPVU4xMTlHUGx3?=
 =?utf-8?B?VkkvNStmZnRqUldTLzdsYWRlYm9GVmlkc05GQVc0cWszOEF3eDVRcVNWTzR0?=
 =?utf-8?B?dzhVVXY2T2M5Wi82M3NJWnJybDl2K1Zac3FzWGZLei96c3YvVEVsenV4aTlO?=
 =?utf-8?B?T2lOVnJLTlM2ckV6ZmdVd1lQak5IWXJlY09DSGJUaWlsa1FkZUh0TXkvc0dh?=
 =?utf-8?B?c0FWU3ZUcVdBWEZ2bXozV0JpdGdtaU9tN09KN2ZhYXhCVHJNVWJLN3ROeTAw?=
 =?utf-8?B?WDRVbEFNZU9xZ3QzSC84Rm1GSEo2STBEaW9QNXhPWGlWZ1lqQzlTeFNFczVC?=
 =?utf-8?B?L0ZmdS8vMlRkNW5HMHhMNGJLbENCV2phOXB3L25DNWZZOEJqaTJDamR6aUov?=
 =?utf-8?B?Q3Vkck45S1hwbHlOUnZnOENwblBZMm1FVStVU3h5bmVkNlY3NUN0MEJkMnU3?=
 =?utf-8?B?MGpick1WaHpyaDRRZlFmOTRmMmRhMlpJK1F1M2g1SDFEanRtSUl6TjdkaHFD?=
 =?utf-8?B?OHJrQ3F1eVVBWFYvUWVlWFA3QWltL3hrUEpJV3daM3hyMnRtUlhQYkRCSXZR?=
 =?utf-8?B?T1NMSHB5Szl1OENHY1d1QWtpY1JvaFhCTkN4VnpBa0R1U0tOZ0dKck1PdHRB?=
 =?utf-8?B?aG1rZVBvN0hMcXVQWVB6bVR3Y1JqZFpQeFlzNXFKV25VVFVhWTVUTkpDaUNI?=
 =?utf-8?B?d0RBaVFCcC9ZRTV4V0ppbUdqT2I1SGhLWDNRN1E0Z0VPM3hqbTlxNmNxYkpN?=
 =?utf-8?B?WDROZ0tNZHZxMVJDU1g5Smh6TUc0ZThocjRaVy84QTJzczMzKzJaSnlUM0Ur?=
 =?utf-8?B?b1NGaENZbS83WHFkVDhOWkUwb3JveGNnUXcxUzFoYjdvbzdHMnNNb1M3VktI?=
 =?utf-8?B?TUZ1V0pGL3JqRHc5aWcwU1Azc0ZKUGs3OXpwbGxxU1laVUtPYU15N3FrK1Mw?=
 =?utf-8?B?bGZ5bVJJUGphNlM3SnNYSjdRbGU5d1h5czhqMFpXSk96YW1IUU9WOXBGTmFR?=
 =?utf-8?B?dHdhdWFxK3BDUTd2NDd6dDVGR2V2b0c4MjBXblIxS3NsM1hkK3B0OUVkTFpr?=
 =?utf-8?B?NVhxN3YvZzMvYjVCaG0zK1NHaHVpc2dXeUxaL2ZTem11KzkydUdJOEJPWENU?=
 =?utf-8?B?TFlUNE9PK2ZrYzA0c0ZGcFF5b2JpbkRpcmo0dDROM3VZL3grazNNYUQ4L3lE?=
 =?utf-8?B?YmJIbnBtbUtXN3Q0RjJ5aWduZmlEVHBvdUM4dWdUcjVaY3hhOEJGWkFOanVT?=
 =?utf-8?B?Ni93L0hhWFdXVEpncjRvWWxiZGRjVElaZjZobysvNVhxWTZpNE9hSHJwZWFl?=
 =?utf-8?B?dDJpbGVBYitVRjlGK2F3Um5Dclkxdy9wTEovUFAzRm9yWXBiWlFFMHVDMWRM?=
 =?utf-8?B?bFV1b1FjaEgyK01ZKzhobGRYNVpYVXJCUSt3RW5CeXl3VVZ3YWMvOVYyWVY2?=
 =?utf-8?B?UGZ5QjQ1ZFYxeGJFMG1samZPVk42YitaQzBkZWwzMnRkdDh6ZEhxa1VvbGlO?=
 =?utf-8?B?L0FFQXduR3A2eVI1Z2c1NjJCTVlpM0tsWUZ3T25CQzNxUlR4VTNOb21vZlR0?=
 =?utf-8?B?MUJ2aUFUZlJIVjJsQ3d1MDBJYlgxY0h5WkdhYjhlYWNTM3lEUjlUQzB4MjJV?=
 =?utf-8?B?VllLZHdlQUVQR0lSUWpDcUlsbTRha1U3ZElQcElPOVIwT0hlcTFzemdQWjJ2?=
 =?utf-8?B?WTlyckpLQm5oSkpJcEtuNzdBVStVTXMwUHUvWjVMdHBHMkNxd3llbmdMTHU0?=
 =?utf-8?B?UDF2U0VyV2sxcWNpamdFZW9idGNiZW8vMXY4d01wcjhsZXFHUk1sNWc1Rkts?=
 =?utf-8?B?ZytHVDlGMGM3WThVakZIeTNJNStGak9ZdFlaNjZEcWNsRXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 18:18:50.4841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cff71b-bc43-4a6a-addf-08dcdf20d636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

Hi Geert,


On 9/27/24 02:01, Geert Uytterhoeven wrote:
> Hi Lizhi,
>
> On Tue, Sep 3, 2024 at 6:50 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> On 9/3/24 02:20, Geert Uytterhoeven wrote:
>>> On Thu, Apr 18, 2024 at 7:51 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>>> From: Nishad Saraf <nishads@amd.com>
>>>>
>>>> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
>>>> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
>>>> Accelerator devices.
>>>>       https://www.xilinx.com/applications/data-center/v70.html
>>>>
>>>> The QDMA subsystem is used in conjunction with the PCI Express IP block
>>>> to provide high performance data transfer between host memory and the
>>>> card's DMA subsystem.
>>>>
>>>>               +-------+       +-------+       +-----------+
>>>>      PCIe     |       |       |       |       |           |
>>>>      Tx/Rx    |       |       |       |  AXI  |           |
>>>>    <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>>>>               |       |       |       |       |           |
>>>>               +-------+       +-------+       +-----------+
>>>>
>>>> The primary mechanism to transfer data using the QDMA is for the QDMA
>>>> engine to operate on instructions (descriptors) provided by the host
>>>> operating system. Using the descriptors, the QDMA can move data in both
>>>> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
>>>> The QDMA provides a per-queue basis option whether DMA traffic goes
>>>> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
>>>>
>>>> The hardware detail is provided by
>>>>       https://docs.xilinx.com/r/en-US/pg302-qdma
>>>>
>>>> Implements dmaengine APIs to support MM DMA transfers.
>>>> - probe the available DMA channels
>>>> - use dma_slave_map for channel lookup
>>>> - use virtual channel to manage dmaengine tx descriptors
>>>> - implement device_prep_slave_sg callback to handle host scatter gather
>>>>     list
>>>>
>>>> Signed-off-by: Nishad Saraf <nishads@amd.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> Thanks for your patch, which is now commit 73d5fc92a11cacb7
>>> ("dmaengine: amd: qdma: Add AMD QDMA driver") in dmaengine/next.
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/Kconfig
>>>> @@ -0,0 +1,14 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +config AMD_QDMA
>>>> +       tristate "AMD Queue-based DMA"
>>>> +       depends on HAS_IOMEM
>>> Any other subsystem or platform dependencies, to prevent asking the
>>> user about this driver when configuring a kernel for a system which
>>> cannot possibly have this hardware?
>>> E.g. depends on PCI, or can this be used with other transports than PCIe?
>> No, this driver does not have other dependencies. It can be used with
>> other transports.
>>
>> It is similar with dmaengine/xilinx/xdma
> OK.
>
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/qdma/qdma-comm-regs.c
>>>> +static struct platform_driver amd_qdma_driver = {
>>>> +       .driver         = {
>>>> +               .name = "amd-qdma",
>>> Which code is responsible for creating "amd-qdma" platform devices?
> I still would like to receive an answer to this question?
> Thanks!

Sorry, I missed this question.

The driver of device which uses qdma IP will create amd-qdma platform 
device. E.g. for our FPGA device:

https://github.com/houlz0507/XRT-1/blob/qdma_v2_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/qdma.c#L614


Thanks,

Lizhi

>
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

