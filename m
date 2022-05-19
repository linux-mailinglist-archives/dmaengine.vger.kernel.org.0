Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E452CC00
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiESGeo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 02:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiESGen (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 02:34:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4333894;
        Wed, 18 May 2022 23:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INpn85gSrM7VD+8kpsd9yT/fLJVWVd1yx+U0MdlWn8t+laK3Gkppqv6gv3J7ccagemVWfXja9RpsZQyy1YqxeEGzt0kkyHpufTONb3NRiLfw20MgM6So6+zdfEkQ77q11+N23fTpeQzTB6eBucODbgMPxlaQCxqTTaMTFfu8siWolvE9+e+BiuRn6mHLr0023ywxsOcL9j58rkfHS2Z88HXYdUljACL/V2loKJqbJoCEFC5GoKjVZHqJE/If10PRNdmPwQrAon/VLetdV6M1f03YkftMpcUkjn7jkfy0njPF+i+ZVTs/aAQERtRMX34PVjgvK65j6Dpj63Ja2NLfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTMYkEFEl3NsYS6cA97X6zCjSdA3ULJwg+zsCLtyQfA=;
 b=ii+CQo2w8mDWCmmaACItEwma4NSiW8rAa4l1HFYACa7MfS4niQxYW6iZgNqvsbffHcW448gK0ovEIIZMnPTaqUWmwbMcNvYF7jXFK+8LG7wM/koOpVXYsmmWXYlcb9vd269NYxIKbo9Z0jg9u/d1yDMZxPI8QraaUXcY1YzeLAPJQ26YRGbXXEwHrbgpT220YBZuy8fCYMvdPH05hB2GFueCBiZlC/QuXK0ElLQNWpwNvhK2oKAQ0frkpic5zMzcLld3BvGCLy4/7j5u/pmqu91IzpBPbUUZIIJSVqg1hoFhNst7BygwicuCQsYwXbtYcMz8Bsy8EnNhlyHcJWhFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTMYkEFEl3NsYS6cA97X6zCjSdA3ULJwg+zsCLtyQfA=;
 b=Cf4p2ZIkN90erzSO2FfCaPG5SHuJ2g8G2s7ag/MmBL30RjprW8fFX9Aub2vsusB6yn1yOM0jvGBfX25Km9f+U2zjbeN5IV3BroIzpjNM+wtu9W3WtNSAwW9vgIUUEtUOLEwuI2PlN+ObIPIxVNQKgaD9Sqg6nOnOMl3v+ZkCphs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYAPR06MB2285.apcprd06.prod.outlook.com (2603:1096:404:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 19 May 2022 06:34:38 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.019; Thu, 19 May 2022
 06:34:38 +0000
Message-ID: <d8c8bd7b-f1ac-8dae-9b86-02dc68002aa4@vivo.com>
Date:   Thu, 19 May 2022 14:34:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] dmaengine: ste_dma40: Remove unneeded ERROR and NULL
 check in ste_dma40
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-4-wanjiabing@vivo.com>
 <02e9ba1a-852b-b2b9-209e-4c819f86dc34@linaro.org>
From:   Jiabing Wan <wanjiabing@vivo.com>
Organization: vivo
In-Reply-To: <02e9ba1a-852b-b2b9-209e-4c819f86dc34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32392963-0f9d-46ed-8709-08da3961a598
X-MS-TrafficTypeDiagnostic: TYAPR06MB2285:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB2285D16BE23CEDDCF71DB34DABD09@TYAPR06MB2285.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elzByHvfYtKztnRZkRAAHdEqAMwVxcO4fv40sXCHVHIVkPT6S579ooigqceFsrH/nNzmElhIobnh1YeS0TSrEBCKsxOzHH5hMXzqNYH7it2ip+DF1LCbn8MskA2iChGwdSLquVJPBxfjCrQmDO0fcI0BpncijzgdIo9oUncOBPDip/x/ORswl4aXMK7uZ62OU/XJvmoh0+Z9S8/wICRgFBPUjWGy8S10JzoOiU2k2aTkCOIZ+rH8bmExwgzNmYkNcJVYbePFB+wWanY0XrnaV25l42OaiRME5+NlECsL42rplkf7AkpgFulta5IMhkEay/6pdWf2tFDZY1tCbmL8HgAuVHi3g1LIwjEXYuKSUVwd26ulKI7zQDrA5g4subMayqbq2uAdAFQyaecpigxZJuw6s800l+aj1E4/g0twLTYMBNAADSmrJj3N3aAnwqXrVf0sHkCU1z1KZy9xhHF0Elr7v1bniNNZ+4oY/niMsrAgqxxottvu0kxpHem+XG6PHQcoKOPbD6UOprm5Db8Gwjw/Pwj5+sq3UCejEdbZp/YN/0bsBNFwYG7tXmmAnEiexLz1ZXys/nkynGm+z35lN0B2PweOpTYafP13wjdvR2SmypnUrVJ1PNmIVRRfCBUNAa8VOjULBpd839M4qnz59X5rKFFpSDEMHXj6teU5ttrferjTNnlO2t+XCtYuBmAGodi03PaxTqrE2vCdIhq+c7ShDAS18jhObFwWz859dFrUsWKufTS9qZDVqW8sGGa2OToW5FqZGnIu5ssOIux7ORm+9GCDoWoC+6Iqg1H4eHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(49246003)(38100700002)(2906002)(6666004)(66556008)(66476007)(8676002)(66946007)(508600001)(6486002)(8936002)(5660300002)(38350700002)(83380400001)(2616005)(36916002)(316002)(36756003)(110136005)(53546011)(31686004)(6506007)(52116002)(31696002)(6512007)(186003)(86362001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHI2M3VCMjJqWURLa1VCUEpMK3NpNGlld014b0RUbmtaNmsvZjlEL0p3bVd0?=
 =?utf-8?B?dkRtZmVqNVVBMUtSNDM0YTlkRnV6bkMvTFpXYmtRcWUySHY1MUovT2lxZG9p?=
 =?utf-8?B?Y0FPNVd0L05IL1Y5RE0wVHpqZU9WZVZqbHR4QWN6MjNZOS9ENTI2VEd6N3pP?=
 =?utf-8?B?QlErbnRTVUpDeGVEaUVIb0puL0pHVG1ZMUxQbzUwdEprSGxkWGNid1VhNkl6?=
 =?utf-8?B?L2JQNU1oZzVncE1yNVVsc3ZmVUJhUzdKRlVoOTZ1NjJxSURNVGN6Y2s4MU9Y?=
 =?utf-8?B?TzNKUHk4Tnp6bDVQa3BMc2VNQlJ4V2JUM0ZiL3YrbGIwWDlQTDVyRHFpbVU1?=
 =?utf-8?B?TXVPb3BrVTNtT3p2VzNmemJuWnVORGhZekRQNXFvVjYwcFRzWUhqci95TlhW?=
 =?utf-8?B?dTluNVUwbXNvMXVVQlFvZmI4Z01xZlZLUWZaRFJHeXFHT0J4RmFUSlkwY2dt?=
 =?utf-8?B?Si9hNVZFTzJzZDRsbUw4SFhyN2dNVTRuRVAxMkJ4QzZDM3lTYUd2VFZMOEJn?=
 =?utf-8?B?SUQyS2xER1pMV25vQ3pwNmJ6d1RlYjViZXdwdjROanBBcVdlSEI5UXhEWXJ6?=
 =?utf-8?B?bnpBdUpDcnFFNHlEOEd0QWQ0a2k1T3U2Mko1UVBGNTlhZzYvNFp0TllsNUdV?=
 =?utf-8?B?RkNwV3NKK2JkSzltam1QYkJUMTRsZU01R3ZvM0htSzhhamZqV21vUFg5ZFcv?=
 =?utf-8?B?Z0Vyd0IyVmhtU2QxNVcxS2RjWFhSK2tSNHJzay9uMlIrNFFjQ1Iwank1Zkhx?=
 =?utf-8?B?YytBcHdiUlp0VThoeDM3NGVVYzAyUjVzb3RMSFVYMTJKdDBFWkJPcWY4Y216?=
 =?utf-8?B?R3Fqc2NVZnpJVnJxMXBOY3FlQVVtUXV3TUxqb3lybjVGcWZ3UW1DSXlGQnU4?=
 =?utf-8?B?RWVpOGExaVpRMDNNdDZxWHVrZjUvU1l4UTVETUFLZ3ZPeUZ6eFZKcUtDZmsv?=
 =?utf-8?B?YTZVQ1liV2s0NitIY2crRks1b1JuMkJ0Y0REbStldGRrV0lMRnNlNVI1R0x1?=
 =?utf-8?B?V3ZBR200VitHNSt6dERLSEZSQ2JHWGhhUUt5VnNNckZOV2s0aC9JSnRxV0JM?=
 =?utf-8?B?UW5pa01TTDZwOHFmSVg3Zk12dHIwRTk2Zm9FamFhczhGZFhTdS9BME9JUUo5?=
 =?utf-8?B?YWtESnV2OEhTN3J6dTR6REQ0Q1Fjdkk0d0NpdVowNktQWDJaeVUvUDVPNGox?=
 =?utf-8?B?dmJNbUZ1T1lidVRmY1NoUVBlcklpc1dRSHNSaGlIa01LeTRGdmk5ckllUHZa?=
 =?utf-8?B?UkhLKy9mQ21iYmlZOWZiUFRGcXo2NldJd1A1TmFheUY1NzZYVUZkSDY5RHZt?=
 =?utf-8?B?Z2FnYUhSNm52Rm9kSnF4RlJrUGJoTUhpdGp2LzA0dWhWZFVEY1dCT1hOQ2Rs?=
 =?utf-8?B?MStQcTF6YXdBdDI1Rkc4MjZVRFlkUEVZQWdSa3B5NDZsRW8zT0RwM2dydmpB?=
 =?utf-8?B?UFRLTi9kWUExRDROZEc1bmRhZS9YRnZuT2pyUzRyTTBSa0VXdDZlWjlhMDNP?=
 =?utf-8?B?SzlpZExYc2NWczc4UXBYRG9NZjhVRGtMbHJqQTVQV2QyRk5xaGZoQmVlV3VZ?=
 =?utf-8?B?RW04TkRLNDBWVlY1NFpwZUlXbzFlazRQeUJpWEo5cE1aQ2E0SkxsYm9IUHln?=
 =?utf-8?B?dHB2QjR2QWVkb2Y2UDdPckhJQWhOUGFhZGloV2RUdDZQRXI0TFBrUGNLSGdQ?=
 =?utf-8?B?TkMrTDlUMkNWUTdBbU1lWk1SY0Vkbi9UTnZJSHYrakNZbGRzT00za0czQlo0?=
 =?utf-8?B?eXdlcG10ME1ZUlFhYWlUY3FCOU5PWGZHSk8wb1dMcG5tUjU2MUpIbEZRZ290?=
 =?utf-8?B?cmxYZmlRa3B3eE1GTnNmVDVETThjbkpUTXNaempXSFZYRUJ1TnR1OTUzaGRU?=
 =?utf-8?B?aTFzeUxKMkJ6c3EyVGZLam5LSVFsbDhmREROZ0N5dFNCYjhFUHR5Q015ZTBv?=
 =?utf-8?B?bE9iNVRRdlJ3Wlk4dDY0ejR5djJqbm5QVVQyY0h3MkhERDJpSTMzeGtZZ3BP?=
 =?utf-8?B?dmJYSWFGR3hEemd3d2E0Z0JwMndGZnZBM1dpbjlLZEN4NzdLTG1uWWpRWUtt?=
 =?utf-8?B?NmpYR2dXMnZ0ejZmNVRvL0swaVQ0R2VlWHpYTGVtNU9sVUQ4NUpSUzhQQ3FO?=
 =?utf-8?B?SGlkVUdYV0N0ZFFwcnJMdkFWY1NWeGFZNlBvT2tGdmNnQ0NxajY0MmRzSWtH?=
 =?utf-8?B?VnREU1NIRmdPVkpSTXFPSjdleThJQlpERHpmNVdxNFpEZHZmbThhRFR6RnNr?=
 =?utf-8?B?cURIbm1kMFJLM2tPR1JJR3IxVFIySmF2OEFqT3kvWFowVkVDamFVVjdWVmtM?=
 =?utf-8?B?eWVPZW9OanVQajlISXd0TG1PNEt3ZkI5Y1lCZjExWjVVekppZFNIQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32392963-0f9d-46ed-8709-08da3961a598
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 06:34:38.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88+F7ow2vNKalB+h2lcideMsx/j5KOZWR2s++8B43qpfKi7VkrbWdTqsOM2tfaav9OjGOSh29kCbx+XOjv5ThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2285
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2022/5/18 15:15, Krzysztof Kozlowski wrote:
> On 16/05/2022 10:41, Wan Jiabing wrote:
>> clk_put() already checks ERROR by using IS_ERR.
>> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
>> Remove unneeded NULL check for clk_ret and ERROR check for clk.
>>
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>   drivers/dma/ste_dma40.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
>> index e1827393143f..7d1bf4ae4495 100644
>> --- a/drivers/dma/ste_dma40.c
>> +++ b/drivers/dma/ste_dma40.c
>> @@ -3119,7 +3119,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
>>   	clk = clk_get(&pdev->dev, NULL);
>>   	if (IS_ERR(clk)) {
>>   		d40_err(&pdev->dev, "No matching clock found\n");
>> -		goto check_prepare_enabled;
>> +		goto disable_unprepare;
> This should be rather return PTR_ERR. No need to jump to labels which
> are not relevant (even if harmless) for this case. It's a confusing code.
OK, I'll fix it.
>>   	}
>>   
>>   	clk_ret = clk_prepare_enable(clk);
>> @@ -3305,12 +3305,10 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
>>   	iounmap(virtbase);
>>    release_region:
>>   	release_mem_region(res->start, resource_size(res));
>> - check_prepare_enabled:
>> -	if (!clk_ret)
>>    disable_unprepare:
>> -		clk_disable_unprepare(clk);
>> -	if (!IS_ERR(clk))
>> -		clk_put(clk);

So this IS_ERR(clk) is also better than WARN_ON_ONCE(IS_ERR(clk)) in 
clk_put().

IS_ERR(clk) before  clk_put(clk) is needed for avoiding the unexpected warning.

>> +	clk_disable_unprepare(clk);
>> +	clk_put(clk);
>> +
>>   	return NULL;
>>   }
>>   
Thanks,
Wan Jiabing

