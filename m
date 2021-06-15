Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF553A7D05
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOLWZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 07:22:25 -0400
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:56832
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229977AbhFOLWY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 07:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbNdmo/Q7hEAx5tlfIf9l/2KcWBJezn6VmvlwfnApPwJ4pjL2HGNz/snt6Ss1WnwPJx4lx7gQLsXVICPj0z4w6RGcKYVRKjkgmtjWXyNiIBnulD/Oc6kctqVyhLnfv6mh2E7+2ty4AfboPVY37J/3PeH4c/t3vymPazCb5Afgt42sbjzysGvx6/EUq/5Ci1MfI4y6uwGiis94/Gkoc2Qdv+6qvZ80JpGxOBBJc60+5KfVl5gHP1ss7W82XrtDlT7QZMwJMLdEQV74IrvM0+GAvWIhtPOPhzhNsxkUooDFq9t6uaDDdgmV85CSYaMRZlvF3VUq5fRHQw4OBzNaGWr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYwQUWXi40uow0wML1RLkszlOmih/q6epGEXze/kyvQ=;
 b=k6iYLLE36mNCTMos2OI+GtYQngcnA2hyawqsNRjhzrb5k4BDiz/+00XUecq4zVWrfhFV2wdwaFezKJxFoEZdwlUtvwsDuCJckqefF08+tcpKVoLxckNp6naURX4yCwaAndQJT8x7XEuMCP1busshiJAvMjZ0cIwLuOuQM/jPrOXGGhqRcv5oBFtYVgILkYogsApZZrnaukg+kL1GtcjKZo6PrwloChODq0VWrCMJGroCK1I7Pn2EoUxLT9q7Eu0HpJnVnxbaAcpjRsm9GlBOJ3Q+dTVdMWvM9/7fud0tXqBF8/NqTG3YAZh7tL6PsLRb4HXIzAPHPJw/+rhTfyk5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYwQUWXi40uow0wML1RLkszlOmih/q6epGEXze/kyvQ=;
 b=RSvurscFYegO1yesvyURWAXoNOSXWdx6VeEE2PMbQailH3S0ajDfuOu8+7dyJQi48qEEMhi2ux0lTj+pjE++4N5oxiWt4uoylhJiMHemFPR/QozNcrC9qBvGy5WmoHbQKD9YyjH83/PVZs5g5CERGyqKH7A1H9rb3KxCTKauyqQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 11:20:18 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:20:18 +0000
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
Date:   Tue, 15 Jun 2021 16:50:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YL+rUBGUJoFLS902@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 11:20:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f04e159-92de-49ac-aff7-08d92fef8e69
X-MS-TrafficTypeDiagnostic: DM4PR12MB5392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB539201CC34530414D2D46A51E5309@DM4PR12MB5392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4+SR4qz0IrryVwdUfeuuhGsbbCbQRKbj5gk2KDDHbqkWzDnwtC28vR6vRmkDSGIixk5wCgTuP2D/9HOeuKfC5AjquFNh9nUlztMl21s7JmaD3Rfw1aBuxJbxCGYzL7T4h1pLP2znTcbs6s70EsH0LqLxWjQ5+OjtH9wq2p6cyIc/+A3uRzOX9uC7AOeJlJDpeBK22D5O7noCupb4ZR9+p33M93o3O/ugOirQnhq2WjkwfF3xO8OYgcBZpODetfh2eOfOvw9kP+njTQ4jJ8zVHu4zZEXS/8LPMCRe7sTtyQVRAjgMrQm50E095M8mqLneQCgaN5Sc7XRiNTItx0cRrwWYIJJJBdazHJ91hq5kQcbaq4nWbZBkTOJr2TSGaIu9+qDYVEJhn/eay6c+HipLmxgcxE0FCkWrtavDJEIvUaDGmNGvAhvUficQcwmgm1KuPLwzxE5cvab4uuFOgWwV8ghONmzLdSVPaEHarR45shflRji/mEMTpe9/yatRTSULRTGSK1fCvh3vOV78fNZDiHvi24PV41Kwt+fcALRokQW5n4Wyw6ThUepor7MnWa+Vn2rAYSh/58jOAwvjvJ4zBSvt+z7/aXur7ZC5RIDJrjyyzkmJt1sXzm7vOShfK4Z+8cBo8pB/7KG2902pgPKEuf9xdZIs3LWr8WjRgTr6nlF+snWkX1YrHDhHbFN8RlS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(6486002)(31696002)(478600001)(8936002)(53546011)(38100700002)(83380400001)(26005)(5660300002)(6666004)(36756003)(31686004)(956004)(2616005)(4326008)(66556008)(6636002)(316002)(66476007)(16576012)(186003)(2906002)(110136005)(8676002)(16526019)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG51V0xETFpHYS9vZmFLcHJsb0t4N1FOcGpnUlBFZWJhYUl3QzZOM3JyWlJv?=
 =?utf-8?B?d3lRc0VNZGlGY1RGcktLekpGeCt4RHJLRzNzSkNDZlg5Y1dscmtWVnY4eGlj?=
 =?utf-8?B?ejloNWllZytiQWJvTjVuWFRkdUFWa0xCb3Baa1lkSkdZanI5V3BBZng3dENi?=
 =?utf-8?B?UFZGMXpDMFdXVnphVDMvTkVYbTNFRm1xNk9lU0dJbThtamZyc3J5bW85eS9u?=
 =?utf-8?B?WkJrQ2VmUDN4TUlORjlNSHppKzJ3RlA5SVJSQXFkaFhMN0YvQ05TRDAwQkQ5?=
 =?utf-8?B?aW1wM3loYTZ2dW1TYW9JTTBFeFNGQUc1VEJGVDJ1MFJUT2Rnc3VIMWU5OS93?=
 =?utf-8?B?cGY0dmRlVGpWdDlwWHdkN3I3MWxhTlNkNHVPZFl5Qllqc05pWE5iRGUwMmE5?=
 =?utf-8?B?NUgyUC8xaERyM1pHem1aY0JsUWhpVlk0bjRWR0lUUWh1dXVoWm9EZE1taUkx?=
 =?utf-8?B?NTVsQ1dxSlBTL0FjckRUZFRHY3IwZ0FYb0lhQXZ1SWR5WmFka2oyTGxmQzRU?=
 =?utf-8?B?clFWa0lBKzVlNm1jZWx2eVhvZjRaS29zckNScGZNK0Jja0pLVDU1M3dQYUto?=
 =?utf-8?B?QjcweUk1SDk3YkxKbFJaV2d3ZktnTjRZMnJpWkppWGlpbHJzTFZQa00yanhC?=
 =?utf-8?B?My84YkV1aXRiQkZySGgvdVZLbFVRa2YyZGwraWRnOHJDbUkrekRSTkprNEV3?=
 =?utf-8?B?WC9TVnB1N0pLM1J2WUx0emY0MlBzNW43V1ZpOXJQMGNoZFRJa1dTd0RpQk5K?=
 =?utf-8?B?MTVVNHVzUUM3QjJKZmVKd3QxbTg1Vi9zeERHTnZaN0VxVVpTTkU4elpvTmc5?=
 =?utf-8?B?Y0dWMTFobStPWDZEMTIzN0NyMVNaZXJGRGdPMWRUM3dYZWttNy9ZelN3Nm03?=
 =?utf-8?B?M3BycmlTR3JrVVI5WnJaQzhaUG5pME4reWpCRXNsVmJSSktUUDB3Rjh3YzJJ?=
 =?utf-8?B?MEJaaXVQdjA1alBzQjl4dCtSRDRYZ3I2Mzk0OGEvSEoxU09RZHdpTU9JaWxB?=
 =?utf-8?B?WGQyUFZQdE1FRG1VN01zcXdBR3MxRFdWdGh0NUJzQ0FSRFRyTXlFTzZFY29D?=
 =?utf-8?B?WDFVVXAxQkhscFUranpDeHVkK0lMdzJCRGJseEpVaVZKWjAwMnJSQkZBMm16?=
 =?utf-8?B?QVI4d2xiVkxNRUJoRGhZNTIwdkRUeStiS2JyS0NLN0ZWTDB2SXNIVzVPRzE5?=
 =?utf-8?B?QTdxTDdZYkM0K0o5bGQ2Rzkxd0phaWY4cWVaai9meVJQRlZHWGRrNXliRmxq?=
 =?utf-8?B?bU9BdXRtYi94OEV2TWt1eVdWVWMvNnVXZ2NmNDBxMTJpR2lVVXp3b25SSnlx?=
 =?utf-8?B?OG5QVExQd05nTWtYK0t4UmJmOTR1UDlRRHczbmloS3RrWlZMSDIvOC9wdlFT?=
 =?utf-8?B?SHE1aDBteXlrNWJIMTR6QWE3YXhyZ0tWcGlQazhMZDl2bWFMMFFNaDhHM2JM?=
 =?utf-8?B?b2R4V3BzUlIvcEUwZFdLenhmU0V5YmFpVzFjU0xrUzhyLy95ajNldHpKUzE4?=
 =?utf-8?B?KzlnaDdndVk5Z3M1Ung5UUsyamdRV1NNb1g1cXZGYUxNa0ZXdXU4V2k0eXQ4?=
 =?utf-8?B?L3hRUGl1MEZZMTBiUVl0WmtpRklJU3E3QWRXSzlZeThsRHMrQVd3SFcvQUta?=
 =?utf-8?B?ZTdKT0VaMThmeDg1cElHa3NHaFhtQ1c1TDZDTkxMOVFZbGJ2YTlBREE5bVBZ?=
 =?utf-8?B?QThJcER4Yy9VbEFneE1tYVRpOWFoUnFoQXRRczU3TUE3R0UvZFAvQWZiNHdL?=
 =?utf-8?Q?bsi7aknaB768QjONqtU99x1xWbl4dRJgSZFR/4s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f04e159-92de-49ac-aff7-08d92fef8e69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:20:18.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gc4xMfvyEo14WZBs5+yvx9k7RTKqb5Z86LaAQUiLaKN4Ksr3b6cNnoHgU0FtO7bRN5DQ8t0z1m+TIHHiw54ZzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/8/2021 11:09 PM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 02-06-21, 12:22, Sanjay R Mehta wrote:
> 
>> +static int pt_core_execute_cmd(struct ptdma_desc *desc, struct pt_cmd_queue *cmd_q)
>> +{
>> +     bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
>> +     u8 *q_desc = (u8 *)&cmd_q->qbase[cmd_q->qidx];
>> +     u8 *dp = (u8 *)desc;
> 
> this case seems unnecessary?
> 
>> +int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
>> +                          struct pt_passthru_engine *pt_engine)
> 
> Pls align this to preceding open brace, checkpatch with --strict would
> warn you about this
> 
>> +static irqreturn_t pt_core_irq_handler(int irq, void *data)
>> +{
>> +     struct pt_device *pt = data;
>> +     struct pt_cmd_queue *cmd_q = &pt->cmd_q;
>> +     u32 status;
>> +
>> +     pt_core_disable_queue_interrupts(pt);
>> +
>> +     status = ioread32(cmd_q->reg_interrupt_status);
>> +     if (status) {
>> +             cmd_q->int_status = status;
>> +             cmd_q->q_status = ioread32(cmd_q->reg_status);
>> +             cmd_q->q_int_status = ioread32(cmd_q->reg_int_status);
>> +
>> +             /* On error, only save the first error value */
>> +             if ((status & INT_ERROR) && !cmd_q->cmd_error)
>> +                     cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
>> +
>> +             /* Acknowledge the interrupt */
>> +             iowrite32(status, cmd_q->reg_interrupt_status);
>> +     }
>> +
>> +     pt_core_enable_queue_interrupts(pt);
>> +
>> +     return IRQ_HANDLED;
> 
> should you always return IRQ_HANDLED, that sounds apt for the if loop
> but not for the non loop case
> 
>> +int pt_core_init(struct pt_device *pt)
>> +{
>> +     char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
>> +     struct pt_cmd_queue *cmd_q = &pt->cmd_q;
>> +     u32 dma_addr_lo, dma_addr_hi;
>> +     struct device *dev = pt->dev;
>> +     struct dma_pool *dma_pool;
>> +     int ret;
>> +
>> +     /* Allocate a dma pool for the queue */
>> +     snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
>> +
>> +     dma_pool = dma_pool_create(dma_pool_name, dev,
>> +                                PT_DMAPOOL_MAX_SIZE,
>> +                                PT_DMAPOOL_ALIGN, 0);
>> +     if (!dma_pool) {
>> +             dev_err(dev, "unable to allocate dma pool\n");
> 
> This is superfluous, allocator would warn on failure
> 
>> +static struct pt_device *pt_alloc_struct(struct device *dev)
>> +{
>> +     struct pt_device *pt;
>> +
>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
>> +
>> +     if (!pt)
>> +             return NULL;
>> +     pt->dev = dev;
>> +     pt->ord = atomic_inc_return(&pt_ordinal);
> 
> What is the use of this number?
> 

There are eight similar instances of this DMA engine on AMD SOC.
It is to differentiate each of these instances.

- Sanjay
