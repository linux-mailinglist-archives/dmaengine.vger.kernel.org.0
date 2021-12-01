Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADF464FEC
	for <lists+dmaengine@lfdr.de>; Wed,  1 Dec 2021 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245422AbhLAOjX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Dec 2021 09:39:23 -0500
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:18913
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350175AbhLAOhE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 1 Dec 2021 09:37:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Llo+atfo/HEdJv3ri84wmHXmc/oAnaCAqEx1iYDvn3Wvv6VpdTH20gZNotpJofh9BqXpuuFLW/QTP8Qw3IMtCQNKfYtIy1GlQ67BI4LrO6lnfja4yiRLCxgk9Ond/QRAEONVEVXaSQkz/5i5JtS3UvUyAuHyUqGEDEGu1kxdohPiBWWsYLT/tJb2v2evlbHMaLMObH7iWs22B4geEpx5KFqtf52hZAu0rwYLdzKVtuobKdUtdSo8tselpQD2RM1mLc59AwNvkAalEjDGMxma5FOG0/GUX/vKmhr6fBA8iETGrnVdA9rnji0dJh7G3iZm+vyxMQa77f8EAHCXqCWggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2cfqhSRthtpsRi4Y9dvGSC2VlMrz8APW1MOwFvC96E=;
 b=I1sUR6m8JLdjxfK4X9lWi0x7PsuuJIHUJEjaYUJFw923ynEjU5AxCTQZpn69iEASJjJyLry1aQz43QngVzlBEQeHGEBx/RHav/gk6EtWt36xSQEPMrJK2E0uTnnW6aTqDD06XCH7rckMgRAr5pNDgojZgdoXBqSRyhjKduAbIfBUrXWBnALgLy1ez5s+lrQsZ3K/s0l45VWZOVkkRzOg9eLr6i1ltDCzzOYWRNV7QewyMT84yF154hqNAuTu5XQLlGla9m086IVKQSPBdbLg1W/3yXono5ZmOhCYHnKDHsNRY9+1Udy5MdovT/WKGoHdyW8sNpOAMrjiCjGpN+ovqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2cfqhSRthtpsRi4Y9dvGSC2VlMrz8APW1MOwFvC96E=;
 b=EtChK5BJ674Bu8HTrFjBqABYZ3KDn42gj/T3G55yp3Roc0zy6gpFStW0ANuHm2UyG6dJwPgEWgrm5C4C7rCZrX2tmMcRqcUiKVGw6jmS5lUzkDa53vpqc5x3GcyNXvL+F0gPWqT5mTOUp8jR6SFIZ1DmV9ff2USZjiPJMldjg31UZBx+2mfNt/KplumnsbvQxo78lVo1VQ/Y8XpuU/Zd7NXzHGU5198VbyOTRZwf9JM5MON3Pj+WXuqo3etvn/3OE0mV6oVZvkbSWx4iWt5Y/hbvS6JmRdqNVBC54VN6Pcal692TXqiEdW/KDQRupVQNOlIwSpkIfrANcc9oOlgc8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 14:33:41 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%4]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 14:33:41 +0000
Subject: Re: [PATCH v13 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Akhil R <akhilrajeev@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
 <1637573292-13214-2-git-send-email-akhilrajeev@nvidia.com>
 <YaOo/FHKQBAa93hd@robh.at.kernel.org>
 <BN9PR12MB527335B55F187C2A1864FDCEC0669@BN9PR12MB5273.namprd12.prod.outlook.com>
 <c9379e5f-232f-7d9e-68c4-1aa5cc15b74a@nvidia.com>
Message-ID: <ad8e88ba-f105-adb5-007e-2458440b9717@nvidia.com>
Date:   Wed, 1 Dec 2021 14:33:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c9379e5f-232f-7d9e-68c4-1aa5cc15b74a@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0054.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::43) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by VI1P194CA0054.EURP194.PROD.OUTLOOK.COM (2603:10a6:803:3c::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 14:33:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698d57ff-5b69-413c-2f97-08d9b4d791e9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427AB0F05FAD458F08AB4ADD9689@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQc51JUtvJvyOdt8uI1+TZYi2PARJD3DyZwi2HUW++rO0sb63HlSb8sSaaq/+uoaeQu8q13YT2XUySrOc/b0ebAM3HZdEm5mf0blR41Nv/oaHMC5hPITqDaFUJa6OEr23Rfxuehr1QFvhrcz9RHhqZYxsXEf0fD7JifIZxPUE/0ApmOh1UrV805iRC7nIvrsdXQr/UA9TPBJh7TSHDbchW+sjKYdLKszfYPVYBH7Ao9BDYpFEqdFpVE73SXCaYnsc1aPJbRKGi1oFibO9e6fZI3tFVh/38te2leSx6cAstxyNVjVTXMu0xc/lC9rWIK6gOFxGByrVLJXa/JpuRTHa2OmA0hICZHsB4c3Xta51p2VvrVaHnlVoJlDnh3SIGRWVwHqWxJ+vijBmJ2Z+6JXJWYOsMe5+XT0wUUaUwkpcCPYmymCFmxcmK/XmDfC19y+Iv4zLoFyEAcxiKk+fF5PQgK02oXf8dQGwNaXoFUlLrZQ7kXbdIM9MQPGomAYEYe3cCl/8L5JGykuv/REohUWcKCModaSUMI/iCTXrQtcwPOX16MrrwWjTmAE1+nP2HETE6qd17sr5ZEx0ngY2DyxRa2r1Rdg5ui1iWoNRF+RoqrTyG8Y8BYgVB0FXGV27pd4ogeCp8pI0ppQUjNLFC2RVDFTX3TFX78JimA76TlDIQM0BGiNFVjdSJVcM2Sas/+p2lMpCd/+NsUrcFBOzjpqfVCsZdKumNS41cxQZep4h8SXUDKmMka6IeU37sG3fPSm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(316002)(36756003)(31696002)(66946007)(16576012)(53546011)(55236004)(6486002)(4326008)(66556008)(86362001)(66476007)(2616005)(5660300002)(8676002)(83380400001)(956004)(26005)(38100700002)(2906002)(8936002)(508600001)(110136005)(186003)(6666004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVEwMHpuU3FQcHkxVnVuTHFSREUzREQvb1RMWXdhQnVVZGJWU2lvczZFZVhO?=
 =?utf-8?B?U0xZanp6UG9hWVlHaEdvVk5rUlQrLzJCUXl6Q0QyNkludXR5MG1wSG8yQXls?=
 =?utf-8?B?ckxObkIrTWNDNmJUS1U4YUcydGVCZS9rTllOYTBqa2dLTUw4U1FSaWFqR1ZQ?=
 =?utf-8?B?ckRZeldORHFIMlhwSmdKN3R4SWNzZDJkRUd5YTlHdVJrbGVwbGJkQnVDaWV4?=
 =?utf-8?B?MlVuUWRabkpDdk9aQlA2VXNQbWd3N25CVWtOdkZnd0VuLzMrWGZiNHdnYmVS?=
 =?utf-8?B?YVJsdXkrMWd0RXZEVEdlK2h4VzgyT3pHQlRQaHYyaHcwZlJFeFpxbWpkYVlB?=
 =?utf-8?B?QjIvV2RwUlFSQmFoR1NuWm1lSDBFSHRpamVpZDh2M0tQNlh6RXcwVzVJUitw?=
 =?utf-8?B?UEpkblpHZndYV1ovMGpaYlhsSVRROVA0MFFzRXduTHpCNnYyZ043akZrOFNY?=
 =?utf-8?B?N1ZrLzZmRU5Gc2E3Mm9LRHFPMk0wTlp5QzJNcUY1Z1RRM2l0N0JvajgrM1JW?=
 =?utf-8?B?T0N6TkR1SUxiNmkzd0dBQzZlZGd6aWJ3cDN0c2dweUtsWkdhQzRDVzJVaFlY?=
 =?utf-8?B?aEJ6NkVxL3ZBbTZ4NHZrR3ZsVUVsN2dPN3QvNjAyclR3Q1VoQkJxQjBXQ2VN?=
 =?utf-8?B?YTdCS2Mrc25hT3hoNGhlV3V2ZkoyNG9yWUh0WGhnMFJNZHE0ZzBHWHdRWGVL?=
 =?utf-8?B?ckVVWGIwT3k2YVZmYzFFNmxvOHZLMkhublFMb2hnTGsyTFJGekFYUkVlSnJB?=
 =?utf-8?B?cmtjdWRKMzZSUkp5aEJESzVVYmhZSWduRzRDRGlVbGJLcVRNVkw3QVpZOE0x?=
 =?utf-8?B?eStUMkZxWGdPUWs1eXVtdFlJMThPeGhCVG5mZDQ5bDFrd05xK2EybVNSNlI1?=
 =?utf-8?B?WUxTd2tLeEMyTlFDcndiN2J2bWorZ24zNTlqY05VRkZXeHdUWS9HL0k3c1g4?=
 =?utf-8?B?ZHZKWXlhaXJaSFhNK05PcWJHWEVhRzdLRkRuSUVYaFhkeWVtc1oxanhPN3dj?=
 =?utf-8?B?YjdCdXErWGhIbERRcGZtWUMvNTJWeXdoVU5HWm9ldVdXT1ZFOUxNL205UHB6?=
 =?utf-8?B?UzhXWFU0ZVRGR3p5bWZDVjdCR2tNR09kNzNxdGxsNTZlRERUYzMzZmNuUFNT?=
 =?utf-8?B?Qk95RUVuZEtPcWRXNnRQWkoxd3ozNXlNcDEvNGJtMklkbXQwVS92cEYrY3FH?=
 =?utf-8?B?ejZqaitFWUdEblhkYjdRTzZhVkJNcWFPclBobkFHV01CR2tzdFZDNkZGbzBM?=
 =?utf-8?B?Tml2K0FqTDlzQUVFbWxUNGxwakFzVjRCOTlacExBZHpDbWRYT1BIMDJuNjRq?=
 =?utf-8?B?Um1SSjlpSVBqRU1RUExoWTRZaFZYNmdJNjVraXlKZDh3RlBVZEc5aklURElX?=
 =?utf-8?B?SEhLeXd6S2lRZlFWMHczejVsWS9yVHlhZnV1Z242cWhIc2NUSVdDOGtTNHhN?=
 =?utf-8?B?b25sYmsrRkNLOUhUOEJZSWIxN25YbWdNR0lyZG1wWjZtbnZ2TVBFR0w0cGRK?=
 =?utf-8?B?OFB6ekRTRTZYRG9BeVhoMytvM0FkcEswS2FORmtuQVZqQ0FES0VCZmZ5U29R?=
 =?utf-8?B?T09xV1VVd25DMHVpc3lhczNBMlZyMThFVUxhVmhBL294d3FSejg1SEk1TVha?=
 =?utf-8?B?RXBsa1VENjVDRjhGcDJVeVBmWVdGM2I4Zjdmay94Szl2dGRFOU1lMUZmWnBV?=
 =?utf-8?B?N1oyWW45MERqYmpNUTZ3QzZTN2tmZDE5UzFSMHVjR2hzdjdFZkRrYWRHWnVH?=
 =?utf-8?B?T1RuRTFiTU9iNDVnZGdZbC9BZTlaZW0rVVB5K2FqMXlrZmF6SlBaU3dzSXdR?=
 =?utf-8?B?a3VHSXI2R3poU0ExTnQxc3QrWG1EQmZOcHFxZ3Qxa09VRGtuQS83UXRZOWdR?=
 =?utf-8?B?cnZQY2lURHNEaEhTOGkra3grK0FHMWMzMjlmbnMrMFRyci9ZWnR6NFJJM2hS?=
 =?utf-8?B?NDNwQWRuMFBUR0dndlNmYUVNK3dqa3Nid1FHYUdiYzlGZjlnL2x6eDU0dUVT?=
 =?utf-8?B?dmV6U0JmVDBiOWVHaXFzQUN3SWd2QVErRG1CM2JxMkhBcFdjRlEzQmZQRFpG?=
 =?utf-8?B?Vk1Db09pcXR0eVF1YVc1L1VVQ2pYTDhWbnV3SFg2TlNvNVNSVFIvdzdzV1hq?=
 =?utf-8?B?T0VUM3JZM2ZVMm1QUW12NTJyUnRyRWoxaGNObFZFM3lQaUdvTndINCtRQkdV?=
 =?utf-8?Q?XZWPK2BIqeel4xzeKbQHrek=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698d57ff-5b69-413c-2f97-08d9b4d791e9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 14:33:41.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibu+uaYPisUVpi3DZtoHg5zvOc6pGvUeeJzXwoV2BS8n11tqmoTxCzNuzSx1/EdvV1vSWUL8tCXF9viunB+eyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/11/2021 09:34, Jon Hunter wrote:

...

>>>> +title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
>>>> +
>>>> +description: |
>>>> +  The Tegra General Purpose Central (GPC) DMA controller is used for
>>>> +faster
>>>> +  data transfers between memory to memory, memory to device and
>>>> +device to
>>>> +  memory.
>>>> +
>>>> +maintainers:
>>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>>> +  - Rajesh Gumasta <rgumasta@nvidia.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: "dma-controller.yaml#"
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - const: nvidia,tegra186-gpcdma
>>>> +      - items:
>>>> +         - const: nvidia,tegra186-gpcdma
>>>> +         - const: nvidia,tegra194-gpcdma
>>>
>>> Still not how 'compatible' works nor what I wrote out for you.
>> I thought '186' and '194' got interchanged in your previous comment 
>> because it is 194
>> which is the superset of 186 and have got more features than 186.
>> Or probably I did not understand the idea correctly yet. 
> 
> Hi Rob, this is the way around that we want it. Tegra194 is backward 
> compatible with Tegra186. The above does align with what you mentioned 
> before, so I am also not clear what the issue is with the above?


Now I think I understand. It is the order of the 'items' here that is 
key. So what we want is ...

   compatible:
     oneOf:
       - const: nvidia,tegra186-gpcdma
       - items:
          - const: nvidia,tegra194-gpcdma
          - const: nvidia,tegra186-gpcdma

At least this makes the dt_binding_check happy :-)

Jon

-- 
nvpublic
