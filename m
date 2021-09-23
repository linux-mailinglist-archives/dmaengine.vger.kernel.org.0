Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03CB415E3D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbhIWMX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 08:23:57 -0400
Received: from mail-bn1nam07on2041.outbound.protection.outlook.com ([40.107.212.41]:11907
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240828AbhIWMX4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 08:23:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfCqHldMNjJ9pqexNes7IPXudBonWjcydaOWkvETVeG/gIcdF9TGZBOIds7M528l4TPKpksLmMbqcL2AUNhJsCss+7hBvVYyj1pHxryc6/mgi6CZl8vwhwu3v0FwDlnVzt69ZMZUgDXZRwvZwgqYmYs4L0u3h6roACr0P77lrciM7vOUpnXwqHl04gnzPSUiG06Dg6IwXntMYGNpqAsUyQcGyxJP7M09PiC2Uus/kwt5fwgZ8+C2jZTxwLcQBbANMIXIKhQm8nMbBpn6wcDVnJ2pPaFr5Kap41c0E5Jl7x8/+CYt5aiRAUC6mGiJSdZoIx30dviHufjGXJFd6z//fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QF/mJ0bEu7MHVcc0GAhgdQqYbS1a1DpiP94GlTfEvXk=;
 b=gKtbs+cx+a+oO+F/Sc/4lcI3Y3QLZPP+F82IQlqn84TxL1IY98QsoDYSHLR8oJiGlDplPmRrXPW5dAgBSKBnnJMyQEmcq8sVLT2Nic7fSI8D8DTudnCbIPmYm0S5Q3IxQK73wnTJ3yOawZpcU2YUPuHXJXlvwY/IkegR7mASrM3gLzMlrkKK9OEWefVRYp15OPH7vyVWDsLhAM0bqiBIGnU2BfHyhPTBqS2nlMfN8ODwnlPWkgQZi75LWEqz81ykqZeOc8JngIc8JMq5p++Vyl1sf14I3E/NcGLH7PfhyDdz3l6yRTuxziUIysC3chMsW8TJjcx8Z9tJ1e8saCGGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF/mJ0bEu7MHVcc0GAhgdQqYbS1a1DpiP94GlTfEvXk=;
 b=pE2P0NNoh9O5imHVUTozmQQFVrszoOx/j46pr0oBio+38j5w6HyMkyJNoUQb7/WW6Cp0/ib0iXgA+oNPAz15HB2goe/yP8f4xVM1pugWhHtO9rqCNVIjKa9HPsUi23/7YLtJyJbX8M/wxWlluRy3tgGn5FjrlWDxflYVVffp2RdewH4LcIPiascNoEl5P7FzJgDulkekMLk2DG7sKnZNWMH2MkZesRnJKS2GWCUrmylivLn6Yy05V5vfOwSrrCSiPBDHqjpAjsC8caZstIEMdGV6cGYQAECBy0pkG6Bq5VtDbOnGYjZnfyJnS0RIZSEaHbG8LqWLB99Qfd7iOprzKw==
Received: from DM3PR12CA0115.namprd12.prod.outlook.com (2603:10b6:0:51::11) by
 CH2PR12MB3750.namprd12.prod.outlook.com (2603:10b6:610:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 23 Sep 2021 12:22:23 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::11) by DM3PR12CA0115.outlook.office365.com
 (2603:10b6:0:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 12:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 12:22:23 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 05:22:22 -0700
Received: from [10.26.49.14] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 12:22:19 +0000
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5a3de015-a0d1-4440-12d0-06297ac7f9d0@nvidia.com>
Date:   Thu, 23 Sep 2021 13:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB5273F667288F7DEE99BA275DC0A29@BN9PR12MB5273.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531cbc02-0978-4f5c-5cec-08d97e8ccc00
X-MS-TrafficTypeDiagnostic: CH2PR12MB3750:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3750789B209CB812438F8A06D9A39@CH2PR12MB3750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKlOQR/V1huVsE9fPJMoTGofHhtR9IU4bwIHmk8P5v0xOLNioq+oBMhloQhm6zeR7oWHM+djw697x5P1h50/+5HABADgKFrD4DNPWZE7cCsfen4GdUjH1lMwVvYacHd6dBKs8lD/0w/+cMzgjZdinqQ96gC4q8m7WLOxXzb+WPIoJ3+HbPdlh1wU8PgtJW/NP3XoEFtPdwhrKJl4XfIrNbEoVq5Wpil0/lsgTSEGrZ9OVpHbjtS2T7gZWdOaBEQ51PlgntM3+srWtoKPGFRUn5ITzSuHQqmeO6MKS/DpzUdjwbk2s2hn5dlrcth4y+6u68Biwzd/KBKn4YR1ozSW8bT/Q/nxFCD7qONOxzXT+5rejn2NkB8UdIfmW9/i8NkXUPKS2PuQ9gaA2s0wXOjt9gGCd9MFkwv6H4AKGShaTFRYK5vmfCpcT9K/t7hoWGNED35XUwj2h4SHK7aNfEYCN+vUi8nq4UwylSCiNG3Pn17CjnPvQEZchcjebKmHRBXBerJQCXoSFeypMtByJ1dlmZO2vYijUuN8Tlow1MxTUKMhrqg7aAEk/PGlJ6CW1YUrUIHYYiLmTX1PX2E/MELQattGJpHqihWJLOKa2ic1lkhoZgdNF0KQmgxItTI+hVQl586BazDFPsj7KtNwyAY89A1L7sZzbNoFBvdLTwYXDEafK6yl/PO+vEIRBXbup7e9500UCI+F/+efvowb7jUEWC94H2lTlniI/QJYrtdOqMY=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(2616005)(356005)(7636003)(31696002)(508600001)(31686004)(336012)(8676002)(36860700001)(2906002)(107886003)(26005)(16526019)(53546011)(426003)(8936002)(86362001)(5660300002)(4744005)(16576012)(54906003)(47076005)(6666004)(36756003)(83380400001)(6636002)(82310400003)(37006003)(70206006)(6862004)(70586007)(316002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 12:22:23.1613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531cbc02-0978-4f5c-5cec-08d97e8ccc00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 22/09/2021 15:46, Akhil R wrote:
> 
>> On 17/09/2021 15:11, Akhil R wrote:
>>> +static int tegra_dma_slave_config(struct dma_chan *dc,
>>> +				  struct dma_slave_config *sconfig) {
>>> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> +
>>> +	if (tdc->dma_desc) {
>>> +		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
>>> +		return -EBUSY;
>>> +	}
>>> +
>>> +	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
>>> +	if (tdc->slave_id == -1)
>>> +		tdc->slave_id = sconfig->slave_id;
>>> +
>>> +	tdc->config_init = true;
>>> +	return 0;
>>> +}
>>
>> So you have a function to reserve a slave ID, but you don't check here if it is
>> already reserved.
> slave-id is reserved considering the direction as well.
> 'direction' is available only during prep_slave_sg function, I guess.

Sorry I don't understand what you mean by that.

Jon

-- 
nvpublic
