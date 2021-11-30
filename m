Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DC462FC1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Nov 2021 10:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhK3Jhs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Nov 2021 04:37:48 -0500
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:36221
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235138AbhK3Jhr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Nov 2021 04:37:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btLFCAcZaJWyIIdUCN6hsP7kK0N7PQllZBthwG4JNhadO4NLnGgCqt1A5SKwl4QfamZEDezy4BF4oKoF14KOYcl51D7lhtLmdstIwFanOfn5YZjZaPGctPMbwRBHUh1qLTCZz9egOQWh00WC4ABtWv7dyzgLOpWBzPf6wtM7TwjFwolvtfH+LuWBmn7RcIks4AIFaW+18/29h2A2yxCNLWJRHQ00UqC6Fbbm3jmLKB1wSEOdJk5NXriPS3MSBFLm0mJEF8vNBxYEt28t6/aheV0yewkH85cUQcthZaPrq7MPnI4yHgxlzH2I3Sj5W5/2r5Mr1HeQBheGK8TsNYtS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLeBZ+QofRGkaUZp9AXa9sssoe2YI/ywgbgX2YZZ9JE=;
 b=GLvZVYw3LTZCGwXX1J3Ork1OhoHlGNm9OifORYbfmnZ/VzvDw0sincVrS/gEpUs75WqcCKUk6F7PmLKj+GlrCzXlMpLyUzuz9GMMHNtmaHo4J41msbRZAUUNBEMk47aS69o6shlw6YeB9YlF7bkhW+l+zh3FsWRiGB2wr90d1caC/thTgeu2Qgka/ZUGNCJBIJclNgmHCqBW7jcmSd53gJKtrWSMaW22ds+8GNnmWdEDRseFaQdrulWCZy1MrbIgrikG4pCODmVhPmKh5Fs0HBvN7Qx0EtS5udMTVHSmh9W2ZwFwSR2ZyXjcIQmvL4hBN3b8nwu+kHITB8LNcY2REw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLeBZ+QofRGkaUZp9AXa9sssoe2YI/ywgbgX2YZZ9JE=;
 b=W/9CKQUk9OzfaSBGRiB2QXJ7lLCHj98YCV76ybEfwAEDsmnlo5frbhhI/pr/4Y2bJVH1H4VAGphuqodix1CZ1+vfy2MdWI/dbGywFN5zfL4C03qv82x+KqBk/l6fbsXiqmv9//+7sPitmNSQD037akIEAHrngCccDHr0SMbM6gms0B6gb3nwKCuMnxoVZ3Chs2+wBjA12qBnaep1wGa6SZafjcTm6shRKsMSdQyMI90k3kjj7X5L+Vpuu51RjHNqijSibmjSyAtObt1jTj9Tffky8od/l6ZPLrCadeO6Th/Kr5UuLrQm2qCHm/RkVheFe80dh1yZOdcLIe3kBZ2BZQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW5PR12MB5571.namprd12.prod.outlook.com (2603:10b6:303:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 30 Nov
 2021 09:34:27 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:34:27 +0000
Subject: Re: [PATCH v13 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c9379e5f-232f-7d9e-68c4-1aa5cc15b74a@nvidia.com>
Date:   Tue, 30 Nov 2021 09:34:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <BN9PR12MB527335B55F187C2A1864FDCEC0669@BN9PR12MB5273.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0124.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by AM0PR02CA0124.eurprd02.prod.outlook.com (2603:10a6:20b:28c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 09:34:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42dfa238-db2c-402f-7a1b-08d9b3e49a6b
X-MS-TrafficTypeDiagnostic: MW5PR12MB5571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR12MB55713427A2D9D05FE3AF4AAAD9679@MW5PR12MB5571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbhSs4nRgaSAa+k8Gw/ygdLuvTxXgKYT+Awpu/MsNwR0+TaG+PgAIuX7kNNJQ0AoiFgyQWMlZBs3qDA0Zd+Gbl5ChcNG12CR7n7sTE4E7ZY8oODLI0tbX53x88hObUZNqqlrsATB1GhMsQ+Ei9zDu8kE+gMnQtfDuNjd9zk2XEvb3fZbdRM7WePTIdLqvV3Ia7fFPtDk3sD6cbWGsBhY71k8GNDqrqgxaHXHyc6pkjPjxjzju+97JtunVHjLwtjQfxcdVIha0y1IBj3Uex3drdH0Cdmqj6/O0RlTNK5tKMXThTtHaDiHqtPn7aUb9H9yyr1dNz9i6gNVluMoUXSkuIrNZ4NaqDbb7o1RqG7PFxDQgdgnWueO3s+DmRpeXLhW/LECj7JNIBp1neYyIRZP/VOWFBuYxNXEoQ/X3mEHuTl8tBR6LR1VHSd4rcThl3fZNIldoAoVl6ZrfpKHei63zWS+KoOCnqEaqWxxs0i0IHwOlyk/x02KcP+FXRaFFcI6QqjajRMd7vWPylWL3L0mNh/CelGa/lB4VgcAH7j6KgS3I7FmMGqiIUC4TK/VIRwB336Kw8ZA4KhwuIjNnN7gzlhxV7/+74ldxyM/rwDvhssG9UvuPYP/FYZb+n7nHwI6wvbXKNymimb+TfM8YW4DIh+/slP7bJM4ufCx1RRmNvhLZYrQkRn6kCVyrvGzKv/a9dDF14vuJOIbPOYkTvljqFGm6HUFVbm0nzbnJt6c8FAg2wDopEXewIxx7mPNhvoVR/4zJLDDI2Mw6B/4dOWMhSxqMAnWdLj2LtJlPPwfHJczySqb2ol2aWBzKaecxSKJIelDNWK0eqrcUj7KhqEn92G0X2Q7MHoSrDvrkMyTfR3voHD0By8XYJ0UV6HYrefS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(4326008)(36756003)(2906002)(8676002)(53546011)(8936002)(966005)(6666004)(26005)(110136005)(31686004)(54906003)(186003)(38100700002)(16576012)(66476007)(5660300002)(31696002)(66946007)(316002)(66556008)(55236004)(6486002)(2616005)(956004)(45080400002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U28zTUMzaUhqYVlRUVY1VWl6ays5M095MjlsZUlMamxHRE40TjZuTkx3bXg3?=
 =?utf-8?B?VzBoMGFRWnp3eTM0Qkc3ZHlqSnVrUkVlc2NTS1E0UHg5VDZRNkx4V2xlOFA0?=
 =?utf-8?B?Q0xSSDc4OWJVU2VwY3ZtcHJZUnJMMkxmbkU0MUZBZGNyZ3pFMHpoWmZScnk0?=
 =?utf-8?B?OU9CQ1lwVXN2bVl2Z0NWMnFiTVZRNWNyMFdDWFA2RWJkQWxFU3dhRjRmODJz?=
 =?utf-8?B?OFI1MklmTTJYb0xsd292RjBOS1FCeGJrZm5LanNVQk9taE5LVnNCNVpYZGFk?=
 =?utf-8?B?RFpTVXRDZlU4d0VNYktUSlM1aHMwb1FqbjJqV2sxeXpySXp1OE9rUDRhTDNj?=
 =?utf-8?B?dm9MZjh1b3JKQ0NtWVVqWkFzVktRWjBlV2h2aFBKb0kyT2dscTEzZm9xSFpE?=
 =?utf-8?B?N2lrczk3WDR0aHZMRk9CbllNT3pQbmdRV3NCVjNzVlE2a2o4eGdEVmRvQkk1?=
 =?utf-8?B?aTh6a1krVFNVME9KWDVTWk8vT3VOMkJXK2FDcVhlS2EzYzA1WUhweVJXQ2Fx?=
 =?utf-8?B?MkxXaGtZTFg5VUQrWFNtek5YTDFZQXJLUnpGN1dSMFZDWTBsKzlMSVNsZFlK?=
 =?utf-8?B?SlNKRHduQ0dSbFNHY0M1OWVwZVRBa2J2ZndVblpnWFRRd1cvcWtoZlhBNVZE?=
 =?utf-8?B?NXBwRXBhUExFNXJGQkZBM2o4QkIrQzlTamYrWmhodDM1aWlXRG1nN2d3WURW?=
 =?utf-8?B?aTZ0ZS9zd2ZzYUIyVHpNbHVCT0dtYnBWU1kwa3RsWXo5cmVRVHdPUng1RjAz?=
 =?utf-8?B?NGt2UC95anNQNW9pSmZXZ0xESC9JZjI3S2QrYjExWHlESWpJODFscXpHRS9S?=
 =?utf-8?B?c00rTFRVSEZITm5TZmRMckh6Z1gxUzVwRHd6Z2dNVUJpMkQrcTQvd3czaVhS?=
 =?utf-8?B?eEQyQm44MWU0TmVUSmJZaCt0Mm1iM2hlbHdNTTZsV3VjellHQjAzUGdrQ1pl?=
 =?utf-8?B?ZEZpenoxNjhDMk4rcU1XMytPYU01elR2M3VPZW1rN0JnZncwZkdod1B6MDNy?=
 =?utf-8?B?VDJ2YzFNZjVhWWlTOWswZGxPd1FmQTg4Y0h6Rk1xZU9OemFvOWJINE5ua3ln?=
 =?utf-8?B?ZElyZzRzRjlRUjZrVXdGcG91ZjFvRUduQTFtSVBsbzRvU245b2xuRWVRdFVo?=
 =?utf-8?B?empoZi9UaVRla2ZKK0o0NVlSdUphSjdLUnJvdnIxd245SW1zaUwrcWt6QXRV?=
 =?utf-8?B?Z3kwTHE4UGt0ZklZaFlSR1VRenFMTGJQcXE4aENjREhvVytqS0pwaEdEejB6?=
 =?utf-8?B?NlRJUDNjL3hBNjc2WkE3bExNck9CM1hOcXNDNjFsanhxZkZqemdGZmZaYW9W?=
 =?utf-8?B?cURSUXYya0FvNzFhUGZPVE1lbHNJY0ZVMk50UThIcGsxdVFCaUJ2NWZOY0Vv?=
 =?utf-8?B?OEJBT0d1NkhCV0JSUjRPN09PNkVUTnJwM3VEaThrTy9XRi9kTktsZ25LZlhz?=
 =?utf-8?B?OTJFTFZMV0hKQ0R6SkF1OHM5V0ZjbGx0ckMzcVVnRk04b3NPTlBxU08vTitw?=
 =?utf-8?B?Wk9kUHVEa1lrRzZVbVRtUVZuV0VUVjRacHNkdXpWQUFHVXVmQ1kzWU1nNmo1?=
 =?utf-8?B?NzBaMmFhVUVkdXFLWDJWYWJ1NUovd3Y0RzEvb21hMSswRGpnZVBncEh4aUlj?=
 =?utf-8?B?K1lma1l4TXFBcEFKMlhGQ0xIakI4aXBsSE5mSDBYR1o4eVlvb1pUUmd0QTg4?=
 =?utf-8?B?b3lWdDdBaW1JODdsS1h1OFZ1N05VYXVwc2ZMVEp4aGJVbVRUZzlESmpOMEVz?=
 =?utf-8?Q?BFpYFO0ECI1cWStgqpptH820E8l/rPMoq4h8QQ1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dfa238-db2c-402f-7a1b-08d9b3e49a6b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:34:27.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnnm3k2TI3yc4lKQrsu0NvEGlUjeT1IzofYu8cTw3SHecAMOa1P3Id7szwXvxSQ8gPQDv/jwfeQX7kE9brNp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5571
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 29/11/2021 05:01, Akhil R wrote:
>> On Mon, Nov 22, 2021 at 02:58:09PM +0530, Akhil R wrote:
>>> Add DT binding document for Nvidia Tegra GPCDMA controller.
>>>
>>> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 111
>> +++++++++++++++++++++
>>>   1 file changed, 111 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>> b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>> new file mode 100644
>>> index 0000000..3a5a70d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya
>>> +++ ml
>>> @@ -0,0 +1,111 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fdma%2Fnvidia%2Ctegra186-gpc-dma.yaml%23&amp;data=04%7C01%7Cjonathanh%40nvidia.com%7Cd1e0c14ac72b4c24976908d9b2f53fb1%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637737588681303734%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=6qMb%2B0Lr3PMMvh5WrdTUEXC76qYo5rJKnG8DisYI5js%3D&amp;reserved=0
>>> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cjonathanh%40nvidia.com%7Cd1e0c14ac72b4c24976908d9b2f53fb1%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637737588681303734%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TktMUBi4U%2B%2B58D%2FJqGY4v9B78cYVMZeXP6pLM1CkGe0%3D&amp;reserved=0
>>> +
>>> +title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
>>> +
>>> +description: |
>>> +  The Tegra General Purpose Central (GPC) DMA controller is used for
>>> +faster
>>> +  data transfers between memory to memory, memory to device and
>>> +device to
>>> +  memory.
>>> +
>>> +maintainers:
>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>> +  - Rajesh Gumasta <rgumasta@nvidia.com>
>>> +
>>> +allOf:
>>> +  - $ref: "dma-controller.yaml#"
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: nvidia,tegra186-gpcdma
>>> +      - items:
>>> +         - const: nvidia,tegra186-gpcdma
>>> +         - const: nvidia,tegra194-gpcdma
>>
>> Still not how 'compatible' works nor what I wrote out for you.
> I thought '186' and '194' got interchanged in your previous comment because it is 194
> which is the superset of 186 and have got more features than 186.
> Or probably I did not understand the idea correctly yet.


Hi Rob, this is the way around that we want it. Tegra194 is backward 
compatible with Tegra186. The above does align with what you mentioned 
before, so I am also not clear what the issue is with the above?

Jon

-- 
nvpublic
