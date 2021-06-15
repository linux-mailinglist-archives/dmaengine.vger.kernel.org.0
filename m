Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30223A7CFF
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFOLUm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 07:20:42 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:28064
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229983AbhFOLUl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 07:20:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoDr8YqZlam8oqm02acF8zsOBAXE/lbGRwE0lmltmabq6sz1OMD/ZyU20TsVzQgk0exX0OM5htgF1PaDIpwP4UP6S07WYUreVqK8uHhOl14MNyrLv5wxnhoxh7RLEuyVlcah7vJtAhmG2gsMP24RGH1LRWrhlgZGNIYtJ8t1pbfaf6ES4FJHBcTdUtF0AZWJfFFNATeXuowHQVgHQ+WtxBK9mxvL08e7t4k5ku512A+qRyIMBLKScHaXbbJCp719n2eG6ult8T9yTBq9vCMlcpB8x/EhfnmTQxVhxgCoO5tu1cxHJ0lnaLXG1DgRumsyPxtcdV59eAqx/3jLg9uPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0VwNc6ZJlU8UoTH8cFwCe+AZom8pq+JtSO3MhIfIxw=;
 b=j+TGh/eZ5frTl0kN5rUIYX3O//Pwy/QtrqKSupfz3Cy40+yw26QkpAGNpbz7C+ovN+8MhhqmxMlqBfIkxijnSJTSPy8QQRjG0+M3snt5Dw+lVeLdurI6OQaglcO0eIIpeSK4pNc5H04pEoOgT51UK+ejPguOIa37D6mfiF+tL0YN3G1tFHt4x1fG5Cj/uWn7nDXyPk4jkPQXHiksXsw7CfDGECVfdL/pTPionE/ANk6K7luh01Yw9FzPDpG8qe6aE9oxXH70WxDqEl+O4uKSQYc1Kwe38Mmw1W566elPzL7TRghGBfGmbs+IpsCxucu1VXl2PrEfxqfl2tgBcEuSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0VwNc6ZJlU8UoTH8cFwCe+AZom8pq+JtSO3MhIfIxw=;
 b=k5hmHQnRJq8WyNXhuKRCHgimTOJjXpn+xtWDfN7iz4/5TtIYCcRsudLTWGYfUnu1YLKm8iewSPQ7Q0qP9oQmx0Vzn8gcZqz0pDPyGbpyd415Z7XShnqCWpfWY/e/N9k+7pZ0/k8/Q9mQK1ehAN/WPkBcURZdqBylyMdFMQKdpec=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 11:18:35 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:18:35 +0000
Subject: Re: [PATCH v9 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-4-git-send-email-Sanju.Mehta@amd.com>
 <YMDLvnCyfo8+StpW@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <9d326966-a759-5ccf-e488-e66d2119eda7@amd.com>
Date:   Tue, 15 Jun 2021 16:48:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMDLvnCyfo8+StpW@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 11:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64198a18-8b30-4862-1df3-08d92fef50cc
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5462EA811D1308DC9F9B7EBCE5309@DM8PR12MB5462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0D0fzwG4yjnaE0BVvz1yOZMg7u4H3aBTEcKaQYQyyu4A+H2gPcTuaKimLo3kX0kOISnuUOlotEkFlt/kbWCzdihJUfTUtbG1Lde80qQ5JHnn2WzbWAb5Z9AAh/KnE5Lz/VBzMMo4uZAeetYt66Ap/MlsfnyJMGPX7k6IrzLdrcSQQOUTw4UBpJATcXJulNpKtoY+Ulh4tYRUQFRmrsT1xIYw5+GSzTW9UzUr2PZjMzHO2Hxwsz2l5tK2LXCiizMwdUsetd9iMaCidmDxOy4l2NWWiLncCAOH6qbF2MLXceH3K4MBYllnMIxxzmc1uUFCYz+8u09acFb/rXT4b4vzYtGVPms8D9arX4xAPbgnj1OKkzdyemid3vpMBsigS7DcJ6vnExF5WYt5K54SZ0gBgQafqMTw0ENj+vTDl0ohtWJyKgvlWdOdrX3f6QYIU0oPNFkWcYM3WIJZ5lk3AQ1WXzyFwCTwtnGxnftkeX4/K5o2jt+whv3RhhH2i8oUrjwz/Xa9f/sZsGeX+xF5ddYn3KVivwqJm34EGLkqLYLpaKq93hKCFCItxwClZFWthKlZim08pr9AiuClmYSUDWMctUAcvQ/X96H9Yp0rAtbZU2lfZzEYnKWuHpH/0iw8Gx9rZKeMsFOUpISA0zJu7IBeqEEz5LSoNmU5qqCXix4vaHt+cnLKJp/ccs8etr/BTs7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(6636002)(16576012)(66556008)(316002)(2616005)(956004)(66946007)(66476007)(6486002)(5660300002)(38100700002)(36756003)(8676002)(186003)(4326008)(31686004)(4744005)(53546011)(83380400001)(16526019)(8936002)(26005)(6666004)(31696002)(2906002)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJiZ3BJRGMrOEt5c3VjSUh5Zmk3dERhNG1tcE1zWCt3MEJZaWZYTUVFTFRO?=
 =?utf-8?B?M1RnS3hsc09lTjJVM2tPcjJxVlYyRlBody9wMzdXUU5SMFZld2h6N0dkN0wy?=
 =?utf-8?B?WGhjZ0cweW9Zdko2MGlTd1lsS3N2ZUViOUhGVWR4N01wTTgrN09TQ0cxYnlD?=
 =?utf-8?B?N3hZb05Ld2tQNWgza0VXMHpNc1dvQVQrS3VUYXJsVHpBUFFDZnMxN0dJbVJo?=
 =?utf-8?B?SEJnVmZyWVFORVVCZWQ0SjZDbGpWdmtwRytsOE1SOTdqTlJKNWg1em1yWEdI?=
 =?utf-8?B?M2wzemVyR21kcFc0T1FRQVB3S1lwdjNKR01ab2NpRW1rOHdOTDJYUjgwdWYr?=
 =?utf-8?B?RXdBRjJNOUlxME1waDZIV1l0a0lyRVBOY0xsK3NGQ20zRGdTVnBsckp3eEJU?=
 =?utf-8?B?U3l1bkE3b3h6eVpkeVprOUl5MTVzMjhBYjVvR1dOQ0k3NWNMWUJNdDZ3RDAw?=
 =?utf-8?B?T1RwcTFOUDhmSHRKZVBTeWhMYUlnSkw4WEdWVHBDbUZFS2MrOUxTdUpvMnIx?=
 =?utf-8?B?a2Q3b0NGYjE4RnkwTjlYM0FKRXFmUURBWVJ2eEdFdExiMHRsS0VsRlE4VC9t?=
 =?utf-8?B?UjA4OXFGMTZJcTZBSHlRNms2M0JSaVZpdzNoUkVBelRvUmxQYTRxNENya1NT?=
 =?utf-8?B?NE1XYUg4azZxdnlrN0FKVUJ2RGZ1YWJ5U0htRGxRQXI1aklQbUZ6VG9HYzd6?=
 =?utf-8?B?QTBQSFU3S0V4OWNMOVB3UnJJRGxSc2MxMTNVeTBlTTd3eXAyRnN1MHdtZmlx?=
 =?utf-8?B?akQ3aE9DMW1xWlUxSzhhcWpZSEY4VDNTZkpPZFVld3h2UEsxVkg2cExoOU9N?=
 =?utf-8?B?K0J5NEJ2U1ZMbTFJeS9sbVpkS001YkdMbFF1Nnl1VUFLeFBEbEFYK0dRWUtI?=
 =?utf-8?B?TTRZUHNDMlR4Q013bVVCb2NodFQ0azh0dC9ySUhuVXVMKys4OFlwcHJzVjdS?=
 =?utf-8?B?bnorVlp6blBaRlYxSTNKUGdVanVEVmY1Rk1VTWZKNm5mVjM3aG4ycnU1Rzdl?=
 =?utf-8?B?UUdRL1JtVUUvek92MWE5SmpwdnFRKzlDYm9rbi84RmZzV3h1N0IzZjI4cGZW?=
 =?utf-8?B?SFBQc1MzaHpUTE8xYU9rdXZDM2lVcVdCd2ZJbCtCNVcyYTl1ekF4anorckVq?=
 =?utf-8?B?Z0hMRzRzRy9MTlRITzdsdzk0d1EyRkRVUFQrK1lXOC96Tzk1b1V4OVlqU0Y1?=
 =?utf-8?B?RGN6RDhlc0d3NFVsSXNZOHdRcWVEL2ltdDB6bDd2azlFRWZ0WngwTlhQeDhz?=
 =?utf-8?B?eFpjbFROZmxLVEg2T1dFNkRKM2pKVnFLSjFRZEVUUWVpZmE5bFBCN05VQk1t?=
 =?utf-8?B?TzRkUkNpOGFZN2F4WlFvVFRTOHIxdG5kcG1sNmtmRzY0b053SkVTT2FROGxk?=
 =?utf-8?B?SlJYM29IVXpmN1lsYWpVUUpnTG1MRVlsZ1FJdU9wZkk2NGhPWmtWY3Zlanlt?=
 =?utf-8?B?KzBmS0hGMjJ6bytZU0lWRGFSY0l4bCtlZEU3Q2Z5NHR0TEJoN0tPdStDL29P?=
 =?utf-8?B?aHRSUDBPbFZxUGdtcWZyQ0NmMzBlclU5S0pwZGpMWEo1TGFjSndwUXR5M3pB?=
 =?utf-8?B?K1BIMzFEU05pV0c4aTlWTng1SlRSVHNVZUlVc2Ixa254Z0phZEJJUE56TWh6?=
 =?utf-8?B?RWlsOVlwMGpIVE5lMHRyNjBIT3hqQ252Z1pBMnVPb1FZdDlTQXF4R3daMFp5?=
 =?utf-8?B?VlVnand1VXpVN0pEM1FOWlRhOXJ4dFRZaGcwb01MZWJhckJMRnJ5WVlHN2Jy?=
 =?utf-8?Q?btIQ7mOIgVvI4qxqn6VoJv0f/ZnSOGegBiJiaLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64198a18-8b30-4862-1df3-08d92fef50cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:18:35.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZxmleUxXx/ARdUdyJycPBsbsP7F8F5iCSSd0t8WejtrYBOpfoejynn/5v6RcrCl3SKgcJpXyFYXfOc4cFAKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/9/2021 7:40 PM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 02-06-21, 12:22, Sanjay R Mehta wrote:
> 
>> +/* DebugFS helpers */
>> +#define      MAX_NAME_LEN    20
>> +#define      RI_VERSION_NUM  0x0000003F
>> +
>> +#define      RI_NUM_VQM      0x00078000
>> +#define      RI_NVQM_SHIFT   15
>> +
>> +static DEFINE_MUTEX(pt_debugfs_lock);
> 
> unused?
> 
>> +
>> +static int pt_debugfs_info_show(struct seq_file *s, void *p)
>> +{
>> +     struct pt_device *pt = s->private;
>> +     unsigned int regval;
>> +
>> +     if (!pt)
>> +             return 0;
> 
> better return an error code?
> 
>> +
>> +     seq_printf(s, "Device name: %s\n", pt->name);
>> +     seq_printf(s, "   # Queues: %d\n", 1);
>> +     seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
>> +
>> +     regval = ioread32(pt->io_regs + CMD_PT_VERSION);
> 
> how do you ensure your device is not sleeping or you can access iomem
> safely?
> 

This device will never go to sleep state as this DMA device is part of AMD server SOC.
Hence PM support is not implemented.

- Sanjay
