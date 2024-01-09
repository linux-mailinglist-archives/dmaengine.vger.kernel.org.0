Return-Path: <dmaengine+bounces-708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54B828A2D
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CDC1C21064
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F739FFA;
	Tue,  9 Jan 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MOeb1UvY"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6138DEF
	for <dmaengine@vger.kernel.org>; Tue,  9 Jan 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFIOlN1MTG04xzYRZYm4kKaUBAdeccyvuBSeAfZOwjFkTLhhp68yYbOUoTj50N4UWMK8MNjh1CFCZVL7YQThgRxwbUbFbcKL3liyB/UIdJSjOeaVd/Ub67qCDlTg49aSC/gFVo3NT3czIw4wgYEzGqDCXyGwoIbIpPY0lsgteiPL/+mFsET6PsoUXnpoTlZOPt/DAMPgZkK0ZC61V2juQtjXDfWiHW6AHka1vmQWtZx+anSzGJUpyje/kmqh08TLDolCfpMVAASdwGcZgWw3+x6ztQNDamn6+DK5XINQDIHJ2kIYHYbXl4p1gQZkK/pl2yjlajvYJ+DlUhl6R4FYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7yknC9k8gcUmMc43APOxjj833hEQJxA9E/JA1cxk/U=;
 b=FqMkgw8fqOOL+UuXMzdBj7dyfm6a9LzihvuLe1V0T3SA3EiXfw4umQQd+sY1vL//3Omd/HjOCYndCkOzo8GCgET3ng8AiIaGqv1DZh9iqBKgjZTP7AbxyOzmYWbhOi6k0caEXU4sJWmaF0eESWevjK6ByWmaaQjVJULqCnqdphe9TMJGM+TWCWqNeiyTN3QYw+JzSUfEdOaXLMd5tJ8+jsBECPCI0N+OpEZvYhI1sPMPY3EAsfEKI4h2leJuq2HSRnflhA3rUEND9XyRC+VRor2RRnmCJNJkKOqWMP9ibOrIgKFWR9Ki3RA88L9IXml9fmNWr+PKUfnwDj1ysd+pPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ess.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7yknC9k8gcUmMc43APOxjj833hEQJxA9E/JA1cxk/U=;
 b=MOeb1UvYJz/JZy9h2DUfK4BQB4aU6ZTTumMBFmFn2Xa+dM+i6+iCj5iaIYlN5FQo2UBYPZ232ep8fBQztb0Ue42g3VaUmbLd+/kldlQb8ASoM3A6Ix7xs1tL7TfgFc0eE4n76yXk7K7PlMJUHSMQpoOxr2Hk2d7amdcgnVwBmnM=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 16:42:16 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::ee) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 16:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 16:42:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 10:42:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 10:42:14 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 10:42:13 -0600
Message-ID: <05ff03b7-ed7c-f923-3c44-9c9d60760cbd@amd.com>
Date: Tue, 9 Jan 2024 08:42:13 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: XDMA dmaengine driver implementation
Content-Language: en-US
To: Hinko Kocevar <Hinko.Kocevar@ess.eu>, "brian.xu@amd.com"
	<brian.xu@amd.com>, "raj.kumar.rampelli@amd.com" <raj.kumar.rampelli@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <166301ea776347cf994b8e8ae4362352@ess.eu>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <166301ea776347cf994b8e8ae4362352@ess.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d761d6f-f1ba-48fb-77a4-08dc1131ef84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuFSxt21cLw1AKf8uM3JHxILsJY1kTtJlOguXPyXSa6djkZK8jmaRRo/PL1nRLsqFz6WLdxQIBZc+dXaC/lPIzDsXhYcNfF8Xsu7MVjqaJe2e5/5fZKqUm8ycf9XJfEL9NNjtSB42OKDw7KdRVT2Hzv9UcmhXntmK0/xnw/NZK1phwxXDmi/vo2op/1bXHpMa5ICMOhQWd0yrBbyFHRBHBstmSSAJsShaw8XV0IMiBD7W+hUN3WirJsktAtZmUVR4bvdN7bqdIYPi+STkLXtcmYfPU4t6FlPyJ6Rq44P9O2hGXS+McBzAFy2563qpZ1K3hb530LoReDBl+Ae++f09HOl/HEafrZsTKVrTQifMacAukjYIxHiMPL4L9M2nIChYWTnR8yvMDa8+SUZpFY+1bkEm3un8/ur93bFS3T/37yqZkjvsQ9mOgeTtJBmI/zJkxvIoI2PefsFvZxfAbVyZoXC4nMKxOASWcJ+4WUxNOLYJewvLsawswpqueVT6mm++4uxOvGPsnrw8iderocqtfJCNKYfWvDZ7tyP0AKkBxFtZqUTrBzifD6ZkkuMS2Sz6sjXE4InP7vosfcXvB4f9nl5Rw/fNSjHx3REujbLPPM8Pr84AJjVYgIdjSEsywWmqWkXCqnIpboUzNWHZAzDyvEoyKt/rtW7AtP2OR6lJdutMmjEfbnyPbRs5O8uqJUUACL3jDl5YUj7jSPOkh4AgfA+WLL11MG8Yxd+KWaut4RkinK+2W5apek4I71EE4geroKkPfmkmdZsTFi/3lJdLEuAZ5ZBcK6rdoK8cAae6+o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(26005)(426003)(66574015)(53546011)(336012)(2616005)(36860700001)(82740400003)(3480700007)(47076005)(8936002)(8676002)(4326008)(5660300002)(44832011)(2906002)(6636002)(966005)(478600001)(110136005)(316002)(16576012)(70206006)(41300700001)(70586007)(31696002)(356005)(81166007)(36756003)(86362001)(40480700001)(40460700003)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 16:42:14.8804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d761d6f-f1ba-48fb-77a4-08dc1131ef84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

Hi Hinko,

mgb4 driver which uses XDMA in mainline kernel. Please see: 
https://github.com/torvalds/linux/blob/master/drivers/media/pci/mgb4/mgb4_core.c#L437

Thanks,

Lizhi

On 1/9/24 03:30, Hinko Kocevar wrote:
> Hi,
>
> here at ESS we are using https://github.com/Xilinx/dma_ip_drivers/tree/master/XDMA/linux-kernel kernel driver today with the micro TCA based data acquisition cards such as https://innovation.desy.de/technologies/microtca/boards/damc_fmc2zup/index_eng.html and https://www.struck.de/sis8300.html. The diver seems to be functioning just fine and it provides all the necessary software interfaces we desire.
>
> Looking at the https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/ I noticed that there is a lot of effort in getting the XDMA dmaengine accepted into mainline kernel. As far as I understand one would need to develop an additional driver that utilizes the XDMA dmaengine driver.
>
> Is there a reference implementation of a driver that uses XDMA dmaengine that is similar to the on in dma_ip_drivers github repo?
>
> Thank you in advance!
> //hinko
>
>
>
>
>
> Hinko Kocevar
>
> Beam Diagnostics Engineer
> European Spallation Source ERIC
> Odarslövsvägen 113, SE-224 84 Lund, Sweden
> E-mail: hinko.kocevar@ess.eu
>

