Return-Path: <dmaengine+bounces-1874-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE148A8A80
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E39B25E29
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BA172795;
	Wed, 17 Apr 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2O8FN2Vw"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FC146D59;
	Wed, 17 Apr 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376394; cv=fail; b=G3489IU+VOcr196DDG5QG2C1SWyrb6K9KAkqkFQYMZ5lPZ/GI8mB5l0cf/E3/alWOOpimboJW33HBudp9m3SFlYBuleTYm1u46nOoUBBpzWDNjKbSJijS+/llDlcHzgcd8NbMPo78+SRhxquZW17GXr1uKa9cnsas4wEqjKle78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376394; c=relaxed/simple;
	bh=E+lyF8yLTBhKhjLkXvlSXV4+okeRYafj7CUdUCHc2eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R/+tu6oFJpdTxU9pjSA8eT/dw+i9zB4P4pQdlQ9nuUFBtzYpN1SMQsR8KkcbOnhOtlu/F/nOVhgoDhkAXFE0evA/RJw434U3WCjoRg3fnjPpyX4aBvBVhRn2qlrQM1elljMM7Vx3jZ/AgsJmFwXuzs+3AoJ+jV5U4ZKZW3DkiME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2O8FN2Vw; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIzxlGMcpNxjXbaqZ8usqO38ZkM3KEO54rJ5zZ88TqP+NYjNe5nhvAySnhAuwmocaxtU95TPzUaHcL6tz3izj8AM46bOJVRtFkwBB/1/mzoeAsaS/RtAaNxGxqTByrAN+WDZ8U81i6MKMhiJUk1KJwBKBl5tviJ4TkJFF0MJ/55Oua7DjcOXjp7r5h++WmS2RRjITg3vNFWPyvUq9Miu1GFOCM7EKUURgwvpw1H/mEmpeEVvsWEmb4fcE/wb1OI5nc4CaqsBPEaJaxsxxQzXs4b5h5e296ZjbebFC+yEhi1LsbXy5b1ELbavD9hHprnfhAKmGg0OGhR90KsZW+iNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu77fXP7A+PsaTLoly9l9VuRpHOnkNGJ1rOcKtmzIUM=;
 b=E9q/RzOSL+YM2OGcf/+tMW0NKEX/qex7c3NJLATi6jAbWmVqkePZWQJynHUafTZN7iURXvkd3itjp10bxxo9ZYgBMGtA2abbds9CLQuICQNUjXJejF4JXxuv/Ppi4q9+uUOB6Cb19m6kWBvf0sNrEvNmbadSuxINHEgn9cZBWl3N4PzTnA9GCEkcULaWz4sIYrI25vkXXA5BbgZurdXXRGiR6eg1Eqa6bqxtkoDmcRyTey7pc1eCqvGOfF0XAOZxAz5TbY9VnBnhIa2MMDWsp8q6l5YSXG3Jp14+BvwhbJMJTKfjW0VQCvUVqKH4YIXlp2CeiDfXrHHA23BBD4cHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu77fXP7A+PsaTLoly9l9VuRpHOnkNGJ1rOcKtmzIUM=;
 b=2O8FN2VwkoH0SbzmdYYbJlpam6eSomzear+nrV2c03ED2WmkG6cDXqXhn8r2aELrTrpVIlp2iGkXNayTSXErK3sRfITGgGGVu2GVEDhdA/cTgGLsXDzCDuwbsq1QIYR4xt7lpEeVps5oRc4FxQE5vSG2q3+rMFV5Ycaz40d4jDk=
Received: from DM6PR07CA0072.namprd07.prod.outlook.com (2603:10b6:5:74::49) by
 CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 17:53:07 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::eb) by DM6PR07CA0072.outlook.office365.com
 (2603:10b6:5:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Wed, 17 Apr 2024 17:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 17:53:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 12:53:06 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 17 Apr 2024 12:53:05 -0500
Message-ID: <14402251-5731-1e52-e787-734d3eb3c801@amd.com>
Date: Wed, 17 Apr 2024 10:53:05 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V10 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nishad Saraf
	<nishads@amd.com>, <nishad.saraf@amd.com>, <sonal.santan@amd.com>,
	<max.zhen@amd.com>
References: <1709675352-19564-1-git-send-email-lizhi.hou@amd.com>
 <1709675352-19564-2-git-send-email-lizhi.hou@amd.com>
 <ZhKd7CHXHB7FadY0@matsya> <aa6a63c0-7cce-1f49-4ae5-3e5d93f98fe5@amd.com>
 <ZiAA3C4wXaAHcJ1E@matsya>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ZiAA3C4wXaAHcJ1E@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 825d2b68-81b3-44e4-35e8-08dc5f073d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rH6cXMXD3JxXTM4t+j1yvADfaCAcGDh+X6QPrYeTcRSc2CrvuCB4LbWJZuF8vF9Q//Hl+THKUSSEsgF8HmyeK5rg4wrTPCAaH4Gq2IBfRa1tFUUsZmW9YO14LipxyF3LgNyoLoukgVBtm3lV6iRz9WERZhopyo2jv/G6BPpB2fnX8JRzL7GulTF5LRr2GokyHnzRB/DNUQVTtmM2vzAWCRwF63AkPxzPlUPieYHwyfCyvEjdXJe3PYxDCmhzfliZ256i9I8tMRtOc3obdW0wB5aGYJeiBJfu7/O7avfY4TAzSvazju2IkXqoFuHucarGAOIgoEh5TVZqY742FAMXEtwxqvPH8Dr6ixkixTbbc2pYqZUmWY2rhnVjzcGGEmt1QZ2r0yh97CWN0p2tRWOmjr/GOsU40InR+ooL1VbmFfVXZjwPsCyAgCJGfHyuvAvjrlkYp8V2gosX4PSfOdu1vSfNzQEWQ6Ghsv92KmxFai/olYORwa6H16HIM+0t0RTqHHlHNy9PqewhI+6GREoTXu6CiRF0QY52H+Nz8wt+w9JJ7JtO8h7E3YfdayDKsVT839vhbmKoztaD6tGNH9s/1AX7Ib7+Gz0CPd3ohvXG1BTKOU7mNnrq/gTS4lj0g8QiA9Zv/aAWnsIIFQf5xb6AuLDCYjUfzSc1sgV4NmSmx0w1M3KIU2IZwX4USOLF/97/b8cXW1xxtRyKOyb+ieKM4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:53:07.2753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d2b68-81b3-44e4-35e8-08dc5f073d13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484


On 4/17/24 10:03, Vinod Koul wrote:
> On 08-04-24, 11:06, Lizhi Hou wrote:
>
>>>> +static void *qdma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>>>> +				   size_t *payload_len, size_t *max_len)
>>>> +{
>>>> +	struct qdma_mm_vdesc *vdesc;
>>>> +
>>>> +	vdesc = container_of(tx, typeof(*vdesc), vdesc.tx);
>>>> +	if (payload_len)
>>>> +		*payload_len = sizeof(vdesc->dev_addr);
>>>> +	if (max_len)
>>>> +		*max_len = sizeof(vdesc->dev_addr);
>>>> +
>>>> +	return &vdesc->dev_addr;
>>> Can you describe what metadata is being used here for?
>> The metadata is the device address the dma request will transfer
>>
>> data to / from.  Please see the example usage here:
>>
>> https://github.com/houlz0507/XRT-1/blob/qdma_v1_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/qdma.c#L311
>>
>> Before dmaengine_submit(), it specifies the device address.
> Hmmm, why is the vaddr passed like this, why not use slave_config for
> this
>
This is because the hardware is capable to process multiple vdesc at one 
kick off.

For example, there are two pending vdesc: vd1 and vd2. If there is 
enough free

space in hardware queue, the vd1 and vd2 can be put in queue, and do one 
kick off

to transfer both vd1 and vd2.

The destination device address of vd1 and vd2 could be any valid device 
address.

desc_metadata_ptr seems helpful for the per vdesc destination device 
address.


If using slave_config, it needs to call dmaengine_slave_config() and

dmaengine_prep_slave_sg() with a lock protection. Is this what you would 
recommend?


Thanks,

Lizhi


