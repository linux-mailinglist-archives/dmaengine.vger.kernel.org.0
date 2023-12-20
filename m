Return-Path: <dmaengine+bounces-590-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1881A708
	for <lists+dmaengine@lfdr.de>; Wed, 20 Dec 2023 19:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A691F242F9
	for <lists+dmaengine@lfdr.de>; Wed, 20 Dec 2023 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701E482D7;
	Wed, 20 Dec 2023 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ncq/DNPn"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B3482D9;
	Wed, 20 Dec 2023 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqRXdzqW1SGvMzJ8v/DhqkvCeZ3fyCOBeNm1aLk9HkhH8cKiT2MMWQDFNy/9hxiM6eIYZN5H2i5vDe/ObL29uUIjgQ+/Al9fgyOrlXab2Y7bacwXvMoIpvL2jqk4t9E5lzuaR2iMOF9hx3Z0h9ESxOdSl2ZzQp3TDMg7HMD6IEn2hCIYuGPkgbjSV5zL2gB/KaiQQVBFj9Hh7/TtRq/QrMH9+dJLmLe3JiRWEEnzTdzZRsndbKlMnzW8S49BAc4DIz5jlydBr1rCRfGpwP7iGTMhQbJ7diYPW9FkhvGIjouOaLXofBZz62rleIy6gC8MKhnaQTkgBx3AC4DUwnG0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z/3P1WI0N1ZVdKTpq8DVHvmGZpPGYSRY7pNKD4wqVc=;
 b=ii8J0e8xXs+JA7nGqzkYo3GTZDE+PHi4oqTaJfaWk4MEatE7PYSa0RDqbNrZeagUTcvUo3lya0k2s0AVt8Q5lD7eresZTRX9+V0a1+iDmyDBqOpfsFZHKwfNvmI1eW7o8eJq8J1fiPryPBaFL2V45qhhkkz16Ym8CpH32roRDXwaxHy9KcsqSBvAPIhtIVm4dbTtmoPNswgcD5C9XerUuK8bJxFwpIidemwBxfIAIVhrgdDAHoCp3+Qk5EaB8Emjx0L5QcZtgy4xQV1OKcG0pTSqpDhbXOhfO9KeGG2JRM5d2obL8wMxaFYItKEkg7QZ8iGJUvVIio5Awojljz86oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alatek.krakow.pl smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z/3P1WI0N1ZVdKTpq8DVHvmGZpPGYSRY7pNKD4wqVc=;
 b=ncq/DNPnCAtUP4DS+o+NPoXrjqzXaVFhNZqK2eSbwOaIeTSMNumgjXkJchF7YHcsIdbyiTP4OavHYTe2RR3+DYi6SCbhNQQZD9OXMBcunuvIpeXmpTS2jvNYfBHebg8bFkVgbckJ2roWYr5Hnlc5BJq4J6cxxY9UPne5joza9TY=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 18:50:55 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::48) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Wed, 20 Dec 2023 18:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Wed, 20 Dec 2023 18:50:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 12:50:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 12:50:53 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 20 Dec 2023 12:50:53 -0600
Message-ID: <bce801b2-b2a1-8014-a84d-87a18460cd1b@amd.com>
Date: Wed, 20 Dec 2023 10:50:48 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/8] Miscellaneous xdma driver enhancements
Content-Language: en-US
To: Jan Kuliga <jankul@alatek.krakow.pl>, <brian.xu@amd.com>,
	<raj.kumar.rampelli@amd.com>, <vkoul@kernel.org>, <michal.simek@amd.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<miquel.raynal@bootlin.com>
References: <20231218113904.9071-1-jankul@alatek.krakow.pl>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231218113904.9071-1-jankul@alatek.krakow.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: a554635b-cfe2-414e-26ec-08dc018c98db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYmSD2VfjrLxXlWfxTDkGwFUP4COVdWjZ0IrQQg9U/fhj9JePD1gdV5bqnYS+qYtwkrjwuCvFvDlndc5XQW6QnhouypOLgbFtq8ZqTbMFz2C6omuacv+i5/RQU9zGu9ihNu9FOeL/AOY/ODl32OwyQBcSfheVuLz6YPgHidNS4cvP6eFPih9sn40me5ncMAerbO9LblJrQP7uRmLglcdVwpdVU0zNTZtCkJNvK6czT6sHJOxXdwnExw3irulvDJG+mx/vOBVQsXUFZCdFiozK5XaC8I0RJqYWmqe8vQAgfcL4mvtlQYSIFXH5RWYr9/79v0oRcmv3vduYAPbU4AM8oT6rakhzNDpB9rLn17iZuOT7HbRFfovnC8bqwRXTcGe/XlsqNtN5qKkxfvdHN3I/qwjlpJRFPaIzG1+bhLeHARxBomSLlAUbuqE/8KSlmwRYfgkGBbKbogILbTnwqZtp/JaU9GOcOT00AiuRqsn3gCDxL0mPIJIxU7+oT19Y17tQ37TPFPtCIycsBhU26bTNcJF+L9j5eMSQd4PynGJrbPEmeVp8O7Z/8J6SYYzPkv4hkH2t9tk3Xkn1cgOYyqX4XP4UyRK5ZcsT7mfUPiF/0aBS3GsGAIiLAKEBWKqD6HoCjjmfHTYZJQ0RTtf9ynW88T1evsBxET1ceuAvao+R20xg4aSa86+Vr8Ra/fMc3A41N3roII5KwOfQY3HW8DBTO6SCRtHSA0DHI+8O5YOJFInrp28V5PKEA43VpvN3V67x0doTZ8BOspjFVLyfYWqqhDJ6VG37gEkggfjysXwbw8A5W/yTzQ6+0sc0npLQIgM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(336012)(2616005)(26005)(70586007)(36860700001)(8936002)(53546011)(6666004)(5660300002)(83380400001)(44832011)(8676002)(966005)(478600001)(41300700001)(316002)(70206006)(110136005)(16576012)(2906002)(31696002)(86362001)(82740400003)(81166007)(356005)(47076005)(36756003)(40480700001)(31686004)(66899024)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 18:50:54.9909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a554635b-cfe2-414e-26ec-08dc018c98db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945

Verified this patch series with our device (sg interface)


Thanks,

Lizhi

On 12/18/23 03:39, Jan Kuliga wrote:
> Hi,
>
> This patchset introduces a couple of xdma driver enhancements. The most
> important change is the introduction of interleaved DMA transfers
> feature, which is a big deal, as it allows DMAEngine clients to express
> DMA transfers in an arbitrary way. This is extremely useful in FPGA
> environments, where in one FPGA system there may be a need to do DMA both
> to/from FIFO at a fixed address and to/from a (non)contiguous RAM.
>
> It is a another reroll of my previous patch series [1], but it is heavily
> modified one as it is based on Miquel's patchset [2]. We agreed on doing
> it that way, as both our patchsets touched the very same piece of code.
> The discussion took place under [2] thread.
>
> I tested it with XDMA v4.1 (Rev.20) IP core, with both sg and
> interleaved DMA transfers.
>
> Jan
>
> Changes since v1:
> [PATCH 1/5]:
> Complete a terminated descriptor with dma_cookie_complete()
> Don't reinitialize temporary list head in xdma_terminate_all()
> [PATCH 4/5]:
> Fix incorrect text wrapping
>
> Changes since v2:
> [PATCH 1/5]:
> DO NOT schedule callback from within xdma_terminate_all()
>
> Changes since v3:
> Base patchset on Miquel's [2] series
> Reorganize commits` structure
> Introduce interleaved DMA transfers feature
> Implement transfer error reporting
>
> Changes since v4:
> Get rid of duplicated line of code
> Fix various coding style issues
>
> [1]:
> https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alatek.krakow.pl/T/#t
>
> [2]:
> https://lore.kernel.org/dmaengine/20231130111315.729430-1-miquel.raynal@bootlin.com/T/#t
>
> ---
> Jan Kuliga (8):
>    dmaengine: xilinx: xdma: Get rid of unused code
>    dmaengine: xilinx: xdma: Add necessary macro definitions
>    dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
>    dmaengine: xilinx: xdma: Rework xdma_terminate_all()
>    dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
>    dmaengine: xilinx: xdma: Add transfer error reporting
>    dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA
>      transfers
>    dmaengine: xilinx: xdma: Implement interleaved DMA transfers
>
>   drivers/dma/xilinx/xdma-regs.h |  30 ++--
>   drivers/dma/xilinx/xdma.c      | 283 +++++++++++++++++++++++----------
>   2 files changed, 210 insertions(+), 103 deletions(-)
>

