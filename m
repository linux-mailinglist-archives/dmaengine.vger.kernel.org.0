Return-Path: <dmaengine+bounces-737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3E830D91
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jan 2024 20:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CE288290
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jan 2024 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA724B30;
	Wed, 17 Jan 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yD/6Silt"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3924B2D;
	Wed, 17 Jan 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521541; cv=fail; b=cZfNK7n2GiteWvi53MvhqAfJTKhZuFxjPzSOBdPSv4FJ7QseCc14vPuM/V2u0cqNy5o7VjAXWnrIGYVVlO0RFdMxR1/VXwAQI8WBO83hV1Fmjed7ldpST/H6NWaJ6/Cn7yHgP0n3LelG0Mm3fn04wraaHScwzaZV899RE94l90o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521541; c=relaxed/simple;
	bh=RfbO2zgOi3zurFs8gvxsG10lqIy/6HLNeTrvlAcPwlU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:CC:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=aZJXQ9MUk/iaLMA/3vIh3eOAWHYF6HLvofq1GyJ741NueBlqKY2mPQgjjIdaCzdgUMD2l0+/gE6l2pal3Ln5vJQnuumnvkJCp3HOI91so7HUTQ3W7HuIX0lpfF62+poo4OhVJ779hBCnVv0T2CnAbhMySQwE4PSEwr62UY/FYBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yD/6Silt; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrWngBDYrVcSNgLSqsLtsR0kVnuNW6VFicFhBlyAi+6rE3mIlQYx0SviHjFP72tptg68vIY98lnZk/AqEuW6YI4Xd7JuU59U3UTwOHANMVhLX4YyDng0/hV4IOctOIp5Tqdj8IXNuzVk74ouDPTjNAe/d2We3TtHUI32DRd8gZYfKzWGCpNk2J+y0VVGzMBm1UUwS1GmWnW6zhCqFU7aONyAQi0q0iC9X89THNWRfjNjKBNv+RYd/SrCLycGuCbKk8dNrOtqpKuFujky0DxWsHN23/7GUNVFjQpuXTAmpGixADAn77peK38fjfQ1r9jCJ1eVg8+NhsmiU0HvyAi5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A+2IhGyTSFUKJd2e9WQhCAdSXCGI0L1ePC6sq0huvk=;
 b=LnMX9jafX0FzXC57UDgYTafVb8gnaZPvL9JYuKRtWddLjJrY/IDa53Tqpf0RUglaH1j3eIAi+l4YwgWAQgvepHqyX67AcrHFMuIVQS4IPs1Lu54NOG/60p6Q3e8sWhMwWZVfa7QqbnOgOgg/M6mI1mdiL2SwymHg2HNGc4/bld/QigBrpw7eCrOObynxKtygJTcDAdXOkyZGoUdgRrpvOPdNa7ONo1qhVCF7D0UglSsHapGKz+o5pUYX7JE5rXGEVoDWdR21mV+0pDOdsMOWZhUfNfizoO8jS0D8Mx50OtNYZXgpof2hcFUyM48QSdUOYxy3i13On2wezASbHq2ScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ramonaoptics.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A+2IhGyTSFUKJd2e9WQhCAdSXCGI0L1ePC6sq0huvk=;
 b=yD/6SiltCVvFeXV69p3kpa/pcQ7WjEcEe/w0ar90sOFL5rxgbvdM/DPOttpvdLdTHl4spMz3NZI52KJ+bsbanWCYzfhjSzkknDiSy1BnGPVl7z5EtbdvUvMtr8zlh6mNJTQUCcuedEMcbdfpeexLKLoOcz+cSPXjDXoCzJNAxiU=
Received: from PH8PR20CA0007.namprd20.prod.outlook.com (2603:10b6:510:23c::9)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 19:58:56 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::d0) by PH8PR20CA0007.outlook.office365.com
 (2603:10b6:510:23c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 19:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 19:58:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 13:58:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 13:58:54 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 17 Jan 2024 13:58:54 -0600
Message-ID: <1cd7b8ef-a450-974e-cb7a-c4928b726d7d@amd.com>
Date: Wed, 17 Jan 2024 11:58:54 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH V7 0/2] AMD QDMA driver
Content-Language: en-US
To: Mark Harfouche <mark@ramonaoptics.com>
CC: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1701277940-25645-1-git-send-email-lizhi.hou@amd.com>
 <CAHespK8FOpW6OkEfCSFZaGvJU2z5QmbBAXcZiQCvTfpTk4-Rtg@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAHespK8FOpW6OkEfCSFZaGvJU2z5QmbBAXcZiQCvTfpTk4-Rtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5d2629-442e-427d-67b7-08dc1796bc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjaS1RzBBr40rpptUQUtMtvBguPujBGuSOUiT5dJqDj3M10/kluihby7gL9JkkRsf9FxnnRewRoMePhTaP+gNs/eaE/scLyu9z4shK46VdwZ9fPTb1SR5T8o9ktu00X+5Zd0EpEeA3UVlKFyEiIep2wZtPGaAD7o3elVh7An+1Am0hMB4MBbqXiWOgKCXBEJx+hNw7UvJz74/Rqp65mmIV5/O1kcyOEAb+iIQk+mCkSesOmTx91lVkLeN9i1YnkdRk5npH292vIcRQH40HTVX7nQ/6bmMlOuYkTEFFLHrDXTPCLH7u8gp0XKA6ejwC4NaXrNng6uIcNoaAE0mfjNtj++yQhLZ7c9XzPOsNLY9476UtFZtZouPKJRA7Zyy1rrib5htH/jOFyxg+ozj6Pji79BmZWCKusfp/5it0pt/4zwYEU/YAb7ty+WWf80PD42VmwbK9t2X34HpAP63OXtpBOs70PFkMI0sTicrgwmxWPJaiAww2E7JZMHhVo4EtWMbpB2Gp4cSqRgnKgGSNqp6eBUiFFeCksIb6BofYWv4nruWRhPaIWbLahMW4b09zgCWzIKEuFuErwDHUfKJRAINla1Nxxq2tiSZ/hrpFTVemiGnN0ltfHX2bKJM8lU428kBWzCXNwSmUwnOyPHiCPNO65zmMzpFbjhxxffnaNJUjwm+WhKojxue1Ih/hItHfrH88QSlHwieCUlETIMC7OYvstrBByINxhIspvEcAkSHZr/aVIhRA8QJ0fqQB8RKPksqg6glMQfjTwcK54phGy9uy64017oIfA3gqNm2HJiu/1Zfjfc1C1ugOAOy4Zs0Kj+7PHcmSRM1GHWcTyxj2s8zQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(70586007)(44832011)(70206006)(6916009)(81166007)(40480700001)(316002)(8936002)(40460700003)(16576012)(54906003)(82740400003)(8676002)(4326008)(36756003)(47076005)(36860700001)(2906002)(31686004)(5660300002)(356005)(86362001)(83380400001)(41300700001)(426003)(336012)(26005)(966005)(31696002)(53546011)(2616005)(478600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:58:55.5977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5d2629-442e-427d-67b7-08dc1796bc9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

Hi Mark,


The QDMA driver has been restructured for upstreaming. And the first 
QDMA patchset supports only AXI4-MM DMA transfers (mentioned in cover 
letter). Directly comparing code with QDMA git repo will not work well.

After QDMA driver patchset is merged, I believe you may submit a fix 
patch to dmaengine for any issue you encounter. We will review your 
patch and verify it with our hardware.


I do not work on the QDMA git repo or forum. I am not the right person 
for questions about QDMA git repo.


Hopefully, this helps.


Thanks,

Lizhi

On 1/14/24 09:54, Mark Harfouche wrote:
> On Wed, Nov 29, 2023 at 12:13 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>
>
>     Comparing to AMD/Xilinx XDMA subsystem,
>     https://lore.kernel.org/lkml/Y+XeKt5yPr1nGGaq@matsya/
>     the QDMA subsystem is a queue based, configurable scatter-gather DMA
>     implementation which provides thousands of queues, support for
>     multiple
>     physical/virtual functions with single-root I/O virtualization
>     (SR-IOV),
>     and advanced interrupt support. In this mode the IP provides
>     AXI4-MM and
>     AXI4-Stream user interfaces which may be configured on a per-queue
>     basis.
>     [...]
>     This patch series is to provide the platform driver for AMD QDMA
>     subsystem
>     to support AXI4-MM DMA transfers. More functions, such as AXI4-Stream
>     and SR-IOV, will be supported by future patches.
>
>
> Hello,
>
> My name is Mark Harfouche and I've been following the kernel mailing 
> for some time. I'm sorry if this message is coming months after the 
> initial post. Please let me know if there is a more appropriate venue 
> for this kind of message.
>
> Since 2018 we use QDMA, and continue to build the driver ourselves 
> (with some patches).
> I am really excited to see QDMA mature and become part of the linux 
> kernel.
>
> I wanted to share my experience with the QDMA driver and how I (and 
> other users) feel of how they react to feedback.
>
> Early in its development, the QDMA code base was constantly changing, 
> often breaking the userland code that we were writing to interface 
> with it.
> Beyond this, during our testing, we found it was full of unsafe usage 
> of string operations (for example, sprintf being used in the kernel 
> code without checking the validity of inputs).
> The most breaking changes often included the insertion of variables in 
> enum definitions in the netlink interface (which does not seem 
> included in this original set of patches).
>
> The community of users (beyond just me) has tried in many cases to 
> communicate small compatibility issues between kernel versions, and 
> suggested in many cases fixes in the form of small patches. All of 
> which were met with utter silence. Numerous examples on 
> https://github.com/Xilinx/dma_ip_drivers/pulls
> Some examples of breaking changes to enums (the interface between the 
> kernel code and the userland applications using netlink) can be found 
> between 2020 and today by looking at diffs in the qdma_nl.h (again 
> this file seems absent from the patches) 
> https://github.com/Xilinx/dma_ip_drivers/compare/2020.2...master#diff-4497b037af6c3a4f9ac917e639b58a1fa155feb4b62b7fe66741a42ed74cdfd6
>
> While I understand that in 2018-2022 the driver was not considered 
> stable, I am wondering what kind of mechanism for user feedback will 
> be available now that these patches are being submitted to the linux 
> kernel. Will the community be able to submit patches that resolve the 
> issues we find? Is AMD/Xilinx willing to stand behind their API moving 
> forward?
>
> Thank you for your time,
>
> Mark
>
> PS. I may have posted on various Xilinx/AMD/Github forums. My handle 
> there is often mark_ramona or hmaarrfk

