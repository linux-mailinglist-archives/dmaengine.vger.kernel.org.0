Return-Path: <dmaengine+bounces-1272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4958729AB
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 22:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4181F22CB6
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5112BEAA;
	Tue,  5 Mar 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PcsRHUsp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AF26AD0;
	Tue,  5 Mar 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675302; cv=fail; b=OPa/m5vBS73LNd4j9pZ/7eQ6YcDKqCEjg4fzEO9UzfxF5D6hWBw7u4E/mKPsztanowAyxv0yWC3lFMP3N6TQmk2pzeIozw4z0gYAES0kRhT4n/VHAhgsEwzyfbHzxOVBIdOky8mXdf6Wi0U9hLfvLHqPcmITgM13K15j8vxA3oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675302; c=relaxed/simple;
	bh=DO9ZLdqayctvaNxtNtR9FRhIZP7oIx5arMfW/38SeM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kb10uT9wGhFe+/eLBZJkELRTcyfvb9vAcP0WlWkh0IKNDOa5WhrFScvBeWtPrurhoDhA37OOeNgBwGKtBYaZxJNr5Gj6zWTkwxMo6hrTmGO9joMHZpLZmG/sWE7rMcAcz5xR2ClVs/G/O9HqteW6bCnF4zsF1UzhRWPcyWjPWIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PcsRHUsp; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5VfubOj45/hKFlfRB2UNQwHZ895Ow9/2e0tRIrIN+oVJCerzCrSxS6wBUThc9Vb4H9DT8QEvCCvZeE6qXbDJysm1OoJAJcRP9drWcvMFfXDBot2Q/XoKULd95aE4etxUPHQ1S45jn0Q0DhCLp3m+pyrfZZDJYE7dPeQl5lO677reMsPbYzPXJLB+qZh+VUfmPywOKAIgKIaHJquAGNavTOR6dzb/KYT7sWZ6G1zScI8Ts16egQLtBDIszk+UEWY2KXZO/JOTGmHSNsKVDIr02OU/EUAsmSTZj7R+kTEuecoimP2V1BmdfdrqZaBDAuwYSg/dWt8UBkSV5K20ass/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzM3nAdTQKFAluqMpiiJUVW+52Ir4cHXnRsw3fgXWz0=;
 b=hym1rGOgyu4ZkR7Tp17lZV1fs6ZUMMxVr5PCbzOwxXH1ganGrlS3D5GFtLTP4sFj39jvClzTQqCo1Rq9MJg0pG4zSQKJjog7keTiPWNgjhzWwXTYh4KuROMhv1jUsuDCMf6UM/Ku0dbzGa/ezzcNxdxkaKxiWzl3BJrOajPNmh1O7McyWcy1mITJXI5mYjuT8RTh+2FwiiXV8c9N45SokX4bHu1lToOTKttSCujpZKjg7ESQl+l7er42RHg4jF3TW2qZ3BbzN32+Rt8h5So0zoZ6g/v4Qi7vrfh2tj184BPMO7tRMEOzIYDLI5Koxlgn+weik01TeYHCENV4OX20rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gigaio.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzM3nAdTQKFAluqMpiiJUVW+52Ir4cHXnRsw3fgXWz0=;
 b=PcsRHUspAatUbOhC0Yqz8gQP1rEFKsBEHINTm4itWZHLTUSJrXSzbrfL1d1t53Sp3XeHcesHyGlHu/ti08rfYUnMyiVsfF9N90V91Pwq/EHQ7E+2kCHr4RYCxyjbdTbl42kXUCXyQaf3FagxO+u+3y9RuHib77wQYD545hl5ZZI=
Received: from MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 21:48:11 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::49) by MN2PR14CA0026.outlook.office365.com
 (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 21:48:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 15:48:10 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 15:48:10 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 15:48:10 -0600
Message-ID: <b3200804-b00f-b0dc-f6eb-28e87e8aa157@amd.com>
Date: Tue, 5 Mar 2024 13:48:09 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 1/2] dmaengine: amd: Add empty Kconfig and Makefile for
 AMD drivers
Content-Language: en-US
To: Tadeusz Struk <tstruk@gigaio.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nishads@amd.com>, <sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1709053709-33742-1-git-send-email-lizhi.hou@amd.com>
 <1709053709-33742-2-git-send-email-lizhi.hou@amd.com>
 <1a2f36bd-4913-401a-84cd-c3f77725fbaf@gigaio.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1a2f36bd-4913-401a-84cd-c3f77725fbaf@gigaio.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1440c4-e15b-4566-fcef-08dc3d5df3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6dXuZ4AysRiFgPuTzW1zq1vHsd0nGaZ7dIOu1QffwefL2vr6Ynoc+LLFE4tiX/PMDIBa9PYiBe1dHX4KUAVAGwqh0uVJp6cjrq4FTAu8tPUXDFVDu1XYIG4LpJgMF5Qjv8Ac/VVt4OlnLVxgVoIDaMBZhWxcXA6OJTljvlOlUtUYRYyjTTjrGIW1LEE14Ixvwgy7hNZQvy2KhjNnlkplp/U5XtndZ7LFuCP/HDIURVULS3Vz+CcduJ9WZZMbYraETdpz0hXQ3IgRENqUe7FwrPM3B/eEiY8tuu9AKuxXdIpt2GHT+zrL+5/H+D+KwdaMTqEhypi9qHe8kbr7xwDOZxX/FqjxbiKn71tX1NSAOR2dBsHOwvKxkhjlBWYhnjjnMWc2BqeCPpa7iJ+0W1h3WgvZ6Q4JP1KNv+HyCrWHfL11TZNUaXS3SmTxYGVnJTS+F21o+wzRuy0LS4iD8XPVlXc/cLn4InqrvEONKLLgBnpHYcts/oJ1w6TFlOPv5wpV+6wfRSl6dCw5uiKsMd2cGbknqKQraJ5eW8S+oJ9mF9qbcPSxwVp2T0BXjDD5e5UmC3IhAAZSEbo2GeNU32bBsGjBJb9T/+Qq8iq3AwFcdlq51Pzz0TIMBDAFFxoK0x0zJBh03rHA9TNHxq0C4LhWdbiOCAvH3eUIcl8jWLt31EQ5duK2/PkbCaAlGUVJjciHnnYeNDNkKPvfUtuByz4yPbsTfqT5ZiSUOFu7qw13MGIVmJu/IDv2wAaniQLcwD2N
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 21:48:11.3274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1440c4-e15b-4566-fcef-08dc3d5df3f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895


On 3/5/24 01:16, Tadeusz Struk wrote:
> On 2/27/24 18:08, Lizhi Hou wrote:
>> Add amd/ for AMD dmaengine drivers. Create empty Kconfig and Makefile
>> underneath.
>>
>> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>
>> ---
>>   drivers/dma/Kconfig      | 2 ++
>>   drivers/dma/Makefile     | 1 +
>>   drivers/dma/amd/Kconfig  | 1 +
>>   drivers/dma/amd/Makefile | 4 ++++
>>   4 files changed, 8 insertions(+)
>>   create mode 100644 drivers/dma/amd/Kconfig
>>   create mode 100644 drivers/dma/amd/Makefile
>
> Hi Lizhi,
> I think you may want to change the order of the patches.
> Adding the Kconfig and Makefile changes in the first patch,
> and the code itself in the second patch will hurt git bisect.
> Just swap them around.

This patch was introduced for another AMD driver ae4dma patchset.

It looks ae4dma plan has changed.

I am going to merge this 2 patches into 1 patch.


Thanks,

Lizhi

> -- 
> Regards,
> Tadeusz

