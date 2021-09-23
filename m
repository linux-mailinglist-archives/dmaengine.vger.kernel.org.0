Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60039415F5F
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhIWNWI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 09:22:08 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:49281
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234515AbhIWNWI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 09:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDPSqK6+LenjmIzQgjBcsXrDxnr6vzTEs/OqG0/kvQfuwPFK8ZNvN/6jDI3JbPPFU7lNyGDgnxettiMYT19lDaIsHLhrX5eybjIw9fm3GS/qK6kDFasjnwvL4l/1Nhp7mSOHH/EJLIQEXXk0CYtxbM8d+S+TUTtz24EPZz5YV5SMEHZhxkeI99NpHcvv+mNU21RUIRHdHUysCHFo4kpXo7exBCWd2T+Knf0Hl3yPr0snKTsNEztY39jSKAuzNf63o7P4Mq6pD+WWyDLdZVzyVBJPz9pYSBzQJJiBkVfdK4ygHQnFRv4t0mE7XfQXaE/jd5VgOknXAanj6Kt2Wr/orA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EQwCTEH+trJTGmzOfvwWnxfQ9oUCLOmZZQdPx3edWJM=;
 b=S8O4RqmoPOFH1ujdPCk+hK3Dolv29nq+SF5MGywzDfnr38Z0oe0sL0EO+IAssU9HjA9Jk0+oD3d6MQeBAOx/dwB0EZrZ/oRUxXC3zfqy5QTvlgC8Mmm9w9Ij7kBsETzau1JJtABnXNh6pgAuVJp60A2tOH+wpIqO65idigw0H3JgNmvX4JsKBYstNDe59VEXb8BHRWllrfAwiLsJfqG8Y3xSDwmvU43TrsemftXpPeFJtVSIB72+yFGiLZgajXRI2VrLNHyHkNbSk5fEv5vBEz1shbFPfgLebWoURQof5eDhsIxsNfIjX1VPeFhKn9ipKVfoxMky/PMgzkFLYU/+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQwCTEH+trJTGmzOfvwWnxfQ9oUCLOmZZQdPx3edWJM=;
 b=XXHhmhnu1Di/oX8Cgk8/8pz8CApSap3NtrSE0rYsCZpSllRBIMxSL7oePHkcFHrlAEzINpx5hBdqzGHA1cjbZo/RHkV6jWrsFPcP00XXgNHZKDZ+pqY8aNOzQtjpvcXwqVLgu9Xa7OLFnk0e0LHEKy+xWzOqMaFIwwJ6kHPXm++A2TLr7hkP8ArsjAznk+adey4kzwr9bf9fds8M15p27IoaIE6Niw8rvVFPXCZNG/JcUBneVq7p5x+T6VX56Mdhyy1cls70e+yYQNfEcnBJSDie6LjVdtycV2q8kYFdiKSBgbJVtb8RZKcmZ/PuKgzcpzzM3TOpJTvBmMtpnIxnZA==
Received: from DM3PR11CA0009.namprd11.prod.outlook.com (2603:10b6:0:54::19) by
 DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Thu, 23 Sep 2021 13:20:36 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::ea) by DM3PR11CA0009.outlook.office365.com
 (2603:10b6:0:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 13:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 13:20:35 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 13:20:35 +0000
Received: from [10.26.49.14] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 13:20:32 +0000
Subject: Re: [PATCH v6 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1631887887-18967-3-git-send-email-akhilrajeev@nvidia.com>
 <fe8b4d60-0051-a11a-50e5-c188a9e9b346@nvidia.com>
 <BN9PR12MB5273F667288F7DEE99BA275DC0A29@BN9PR12MB5273.namprd12.prod.outlook.com>
 <5a3de015-a0d1-4440-12d0-06297ac7f9d0@nvidia.com>
 <BN9PR12MB52731FB8F424A7E92EB8694AC0A39@BN9PR12MB5273.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bd4036f2-2ec2-1301-0956-42626ad3e12e@nvidia.com>
Date:   Thu, 23 Sep 2021 14:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB52731FB8F424A7E92EB8694AC0A39@BN9PR12MB5273.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f3d5cd-2e60-44c8-c3b0-08d97e94edbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4185:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41855CF11C6005B6DF03299ED9A39@DM6PR12MB4185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wkuf+z9RTDmH+t/YHxTFM6iKPG6m1D1n04pHnuUgnswlsBdUfERvpwRsexM+VM2JGslVq18rsQwrFZiyNKrXGDx7cmndeC7LCuQBfrsow3TlB5MPkT1KX5I/d1z2Kck+l2arViE5pM7pb9zaJ0XEdZu1jOA81EXrwjLqhIhVwd7v6y1BmOIrr7j5IyAKDy5Z/D9OS3NikceNJQtlm9mnUY2/x1Yi+XLtpGH+OTFsz0V3mw8VK735kbsu3+E8ruDZS5wp+vfqIZ4ACPbKWkl1OTFDoImh+RpKHyeiKn33ZhYzRE9Ir8Ml/PPpcCc5HBsvj6eMZGvqCPkf5Ha8ssvEE7ugFBC+Px0njpaY8nzkf0O78SwKL6wbE+ulk+QRHekBbtJKw/fA1GXOYeVAYDyNd9JDEvrzgrteo2c+aH5iAzTr9BNFUctiOYaxqsGDMqzv7YtCb8eePeDIpEUZ0IbgldOPgGEpay3rPjXDDLclnblFFzile623/JnnqvQh40wViwPHlQr9SEx2JIAUpjFr6D9f1iN3dLsdMi3CCBOnJShoYANNR5wOAWYvq5hHBJnfh512e8NnXewFnwNkBDyGE59rXr7q7bc0QQ/nRu1k8sdz1JMEX1KFHxfHiN/0BXWNxlWdegku7wmqONv4gHP2mc0EQMrILmuReVlVQvx58rx0z8KrMn4KPQWtGltlJwnPrZwveIqUGi6NgCi722ZuQSkEeXlAGtqJzltLuPHZa1U=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(4326008)(54906003)(36906005)(16576012)(8936002)(53546011)(8676002)(316002)(82310400003)(36756003)(426003)(37006003)(86362001)(186003)(31696002)(356005)(31686004)(336012)(6862004)(2906002)(6636002)(107886003)(508600001)(47076005)(5660300002)(7636003)(70206006)(70586007)(36860700001)(26005)(16526019)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 13:20:35.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f3d5cd-2e60-44c8-c3b0-08d97e94edbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/09/2021 13:51, Akhil R wrote:
>> On 22/09/2021 15:46, Akhil R wrote:
>>>
>>>> On 17/09/2021 15:11, Akhil R wrote:
>>>>> +static int tegra_dma_slave_config(struct dma_chan *dc,
>>>>> +				  struct dma_slave_config *sconfig) {
>>>>> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>>>> +
>>>>> +	if (tdc->dma_desc) {
>>>>> +		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
>>>>> +		return -EBUSY;
>>>>> +	}
>>>>> +
>>>>> +	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
>>>>> +	if (tdc->slave_id == -1)
>>>>> +		tdc->slave_id = sconfig->slave_id;
>>>>> +
>>>>> +	tdc->config_init = true;
>>>>> +	return 0;
>>>>> +}
>>>>
>>>> So you have a function to reserve a slave ID, but you don't check
>>>> here if it is already reserved.
>>> slave-id is reserved considering the direction as well.
>>> 'direction' is available only during prep_slave_sg function, I guess.
>>
>> Sorry I don't understand what you mean by that.
> I mean, it would not be possible to check if the sid is in use without knowing
> if the direction is MEM_TO_DEV or DEV_TO_MEM. The bitmask to check the
> sid reservation is separate for MEM_TO_DEV and DEV_TO_MEM.
> To get the direction parameter, we would need to wait till dma_prep_slave_sg
> is called, I guess. I saw in the documentation that the 'direction' element in
> dma_slave_config struct is deprecated and should use the value passed to
> dma_prep_slave_sg().

Do we even need to worry about slave_id here? Typically the slave_id is 
coming from device-tree and so is handled by tegra_dma_of_xlate(). I 
would drop this unless there is an actual use-case we need to support 
that uses this.

Jon

-- 
nvpublic
