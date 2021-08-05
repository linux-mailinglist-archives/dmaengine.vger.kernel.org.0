Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF133E159E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Aug 2021 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhHENZ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Aug 2021 09:25:57 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:36785
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240827AbhHENZ4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Aug 2021 09:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg45NYsABc5TFECDz306Ps6ONxazKoEYTdYBKCzIUEtP7gy9SwEXeg1M7bEwrRHuI1xmiXwHCeigXe+K2wGGPukSn3osdgXGFJUEfBAnMTWZLVEO23UZHPtNiOViyyp+cEniHGcIJxEC8590NMRlVbqFMfuN45+qWvr9gJ3EVod/gVGsI+jTTqq2xsoxpMnIV88kg1ob+w/yNWpX7E/IKIdaVTEzbFJR6btd/7rALDddteG0vQWq1Wuwk2hJX+jLu0VEV/ODJPn3c6R8VPLggfFueshUpiOJz2kVqSTNXRi/fIZcElIEuK5CLmeU6YjemIlyBpQgP3h2p6VA+tYmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jL/IdsbyvG0Awt7x1x9A50YjsG0gh7CjdlXpxqi1YY=;
 b=eZu89bdy+gUUkQZS0XYBqJ4B2PaXD4Qq48JzmdaGzP6+lB3bWbvtJQSKWOFnzwriG/v1HHwwr5bNr0rlel37Y80C7O/aErqyo5+w59QjVYuT8h6/8X5p06l3Pqe+DKq3Fsn0ZD+xVPtouZLqQc3JKeq/owckY0LbDL4bHu/rSTYjCBx7gfdGHkhpBsW6OgUCShUplxa2E5E5JYVQdwHgWMu/a9tSuenvCR9GyKVw+Xwq4BgXOh+acO+AqPkrvGX0lYzM+MMuhb0L4J2rlSo/BSiDi12gV7vfbuJNin7YlK5Bg3RPLq74VakkKjFRr1sby5GVKe9jsxIp2/kA3donYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jL/IdsbyvG0Awt7x1x9A50YjsG0gh7CjdlXpxqi1YY=;
 b=lxS20EXhNzci1WMrGIivJsKBXSLWBGlbZw/psPN8IhUfwTcIMLnvYAs8MDMGUOvvWIBmaOY2nmS5u35GQ2HVWl+HU7Sn+Saji5zSV7C8Zt+DA6wziz6t2/+5fR7amtoepAqoc3nceB7PNpeMxZI1BRrYUmRqJ39ssM0NybSqhLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16; Thu, 5 Aug 2021 13:25:39 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::d1b7:9fe6:834d:5984]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::d1b7:9fe6:834d:5984%3]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 13:25:39 +0000
Subject: Re: [PATCH v11 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
 <1627900375-80812-4-git-send-email-Sanju.Mehta@amd.com>
 <YQvYeorB7BniIdm2@kroah.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <9d109c82-4c73-6e8e-ee8d-c6287495dc92@amd.com>
Date:   Thu, 5 Aug 2021 18:55:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQvYeorB7BniIdm2@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.44.125] (165.204.157.251) by MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 13:25:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf649b8-81e7-4015-c6b1-08d95814846b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB543191ECE1FDE6B45098FFB4E5F29@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vxk7gZPSXFCnWWOlyaJyHpTwAZc84SOccOfEuW+l4Grhh7kALgqlp/1xUE9KJjY8WJn6D5JZp1yIj+eboBv/yqROOaN9vTcwqIwfDdtiXB71wkySbFGPc5x3Hq1YO7Ntwq3E8fNn1dgrpM3pwhw5p9nghck4xhT+Go2QxZOAG0LEr6pQWfz085k8jeIEb6YaccDhNnxhZCU1SbkC7wRutTVBHSZ0PuQyPHJH3Iwdv9iQcnHCj76B+2LS9JqpPeHHhAcqMapi11+ySfcDf4qV6zSNr5bTzzYZl0IbpkzsnjreduAc87qHSH0K5kmsvAvUEgIIYYeKOS+46bcx8Bfpr5o3Gzql6BvygWh6yvmKtId+scDfJoAFBUO+WwmnctFhyFU55w82HtyMn2JGispES45I3qCt/SSgSbkPn9CjM3nyxJPHubpL094J5VScJrs1XweQDIFGigsUy9b52s1Yidh7AmN+ve4H9zzxlGLRM8o6Cqbomc0s8dnR2NDFouhxxVaBzI9smX1Obv5GgHJ+0YlK0E/OJGIhpnag8+vk+1U8ZvyZAF+3tsPKEzc0gazrafWpp2OcDJoHlLcbNX0lW4U0aCvDtvibCE3nfSmQV2vyZK0G0jNeU0vacdkzd7WduKjc6EpPaesex3kaPA8+59xW2JzCUQrbSSpUHjDr9izTUFt08BIgtxpXS4lhJcJQFujBcrhP7iLxonfah0XLu1QRmz9kRUMAJR7uBcGUSp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66946007)(4744005)(6666004)(66556008)(66476007)(956004)(31686004)(2616005)(110136005)(5660300002)(478600001)(36756003)(38100700002)(4326008)(8676002)(53546011)(8936002)(6486002)(26005)(6636002)(2906002)(31696002)(186003)(316002)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhmeVRoWGVsUWtTd1F1RlppNzVscXhPWDFmUUczd2M4Tld6MGRuQ05MbTh5?=
 =?utf-8?B?NG5qQ0NDZEJ6WkEreG92QkhqaTlvN0VTa0Q1UVAxVTlicXRPYkNJS3lITU9I?=
 =?utf-8?B?RnArQ2d6MGVqRk1Xb2hYNDIwZjBQMFYzTGZUeUFhNW1QZU16NWJwbTkxUmpu?=
 =?utf-8?B?UGV1dmY1ZWo5T1d1YjVDK2F6THA3cFkrd3dBZHN6WDlyNTZRaURpdlhoV3Va?=
 =?utf-8?B?ZS81TnFzcGhOZ3FtdjNwdjM1YWZmUDJlam95ZDlIeWlGd1FqYXRoWG5XL2k2?=
 =?utf-8?B?dnVlcm1ET1Bab0pXYi9KMko5bDQ1OU9hakpBWFhWcDcvRmZnS0o4YzFTdmda?=
 =?utf-8?B?TGN4VzNLanBsOFNoZkkxMHZBTWwyejFaWXRMbmRZRHkvRytTR0xUL0ViVXdB?=
 =?utf-8?B?Ync3eUtOVlNOVjJhdzJSRVFXaHI3RVRIY3VqRVFaMnQwQTVoM3lBTTEwb25K?=
 =?utf-8?B?d3pFUGFkMFg3L21MMGlhSUlBOTJtN2d2V0RuZzlTc1ZGa2tLZkZiWThIVGVy?=
 =?utf-8?B?dVBrRHBnZVQ1cG5DWUltWkRGYUllN3IvN1U0aytIUnE3dDZJbFZmbDhKa0ww?=
 =?utf-8?B?YkFITDJXQTFjZEFhclFiVll2MzZCM1FUMnVEcHN5MFZJeldUY0Z6d1k5Wk9U?=
 =?utf-8?B?dENFU1I2bmp4clRNME9wSVFhRjRCQWZxeTlNU0h5aDJ1TWxzM0xRbk8wSktm?=
 =?utf-8?B?VVpmSCtyYWZyQWRscmhib1FQeEhwRzZGZUtsemlxaUN1eHVzZGc5Z1NOZi9Y?=
 =?utf-8?B?QldmbUZYUWNEK1J1SktER2cvMm1PM2xVN2Y4YWdKTlhHUzNDYVVXbzNxOUZy?=
 =?utf-8?B?TW5ad1lpaEs4a3JUSHRZejZ6Nm5XQjFnL1lCYnF5RHVwR3h5bFRic1lOVWpE?=
 =?utf-8?B?STFFTnlBWGp4NlB1dUFSUG01OTRMekVRM2JNaEFvZWYxV2Z0dzkvbnE1U2o3?=
 =?utf-8?B?TlBCckc2bzA1R3liSWk3Z0pwc1BMcWR5dlZzNS9SOWg4bVlodUlvbnBzYUZ1?=
 =?utf-8?B?eStyODludXU3a2FJdHhlakpUR2NQaGk0Sk1wOTRtVFpMUkw3V0ZjODQ2QUU1?=
 =?utf-8?B?N3FKTEFMNjJQZ2Y5MHk2a2M2QkJqcm0zMllLTi9TU1hDZE9VaHlsZnRBREdK?=
 =?utf-8?B?QVY0Nm83YXlseEMvMU1rdURRL3NZeGV2RmlUUm1sa0g5eGlOUkVlR2RRMGdl?=
 =?utf-8?B?aTFSOEx6RWhUaWpmUTZZdmxnUTA0ZE9xWVRwbGI0alNUZ3RQRDBOSm91dFZu?=
 =?utf-8?B?YUZzcGcwVXVNcmJkeUkybmJzYWJzWVJMNXZIOFZWU01Ndis5NFZZclpHMTBh?=
 =?utf-8?B?VkRZWjZBRm5FNWlyekYwK2ljSCtCMTVZekE4VUEzU3RLN3ArSWdoZDN2VTkx?=
 =?utf-8?B?MGJTc3FmbTVlY3JXVytXQVpSL2hLNVI3ZXdETXhsTE5IZHFKamhFN09CY3FX?=
 =?utf-8?B?Q2hzMXpCam9VSFFoNFQ1b0VXaGROMllIeFdldy9NdWRDVlRVcUhHYk4rdVh3?=
 =?utf-8?B?S0NVd3Z4Q1hNdjNsRVBrblhMUE8zSmtmeW84TnVZSXNXVUVMZlFaTG5McUVY?=
 =?utf-8?B?dk5uajRnZDdyQVhkSlp2UUlNU1hGaklhUk8wdXc5TG5wS29WR2cwVHF6Ukhq?=
 =?utf-8?B?aG5nOWZKTlljNGJEZ0hPOEttKzd5cVdKMzE0ZXhZYlRvNDludFE2a2FPVGdM?=
 =?utf-8?B?Y1dVNHNnS3l3LzlVUDhwSU1CZVBKYnRmN0R3SEFSa2xSbzBqWmEreTBFdEtu?=
 =?utf-8?Q?Vuf0orrbTqT8DgINVpQd3HEOLvRfkg0bmXndUf9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf649b8-81e7-4015-c6b1-08d95814846b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 13:25:39.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZafPKNQN7AwZeiJVQIH6lZOLjsVtAYHY965W55eI1XyT/l9nKAmkBEbEWKGcKnoT3xCPsh+rE90Gh7IlcWI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/5/2021 5:54 PM, Greg KH wrote:
> [CAUTION: External Email]
> 
> On Mon, Aug 02, 2021 at 05:32:55AM -0500, Sanjay R Mehta wrote:
>> +void ptdma_debugfs_setup(struct pt_device *pt)
>> +{
>> +     struct pt_cmd_queue *cmd_q;
>> +     char name[MAX_NAME_LEN + 1];
>> +     struct dentry *debugfs_q_instance;
>> +
>> +     if (!debugfs_initialized())
>> +             return;
>> +
>> +     debugfs_create_file("info", 0400, pt->dma_dev.dbg_dev_root, pt,
>> +                         &pt_debugfs_info_fops);
>> +
>> +     debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
>> +                         &pt_debugfs_stats_fops);
>> +
>> +     cmd_q = &pt->cmd_q;
>> +
>> +     snprintf(name, MAX_NAME_LEN - 1, "q");
> 
> You are calling snprintf() to format a string to be "q"?  Why?  You can
> just do:
> 
>> +
>> +     debugfs_q_instance =
>> +             debugfs_create_dir(name, pt->dma_dev.dbg_dev_root);
> 
> debugfs_create_dir("q", pt->....)
> 
> here instead.
> 

Thanks Greg. Will make this change.

> thanks,
> 
> greg k-h
> 
