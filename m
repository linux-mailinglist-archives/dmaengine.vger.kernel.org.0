Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9D46BDD3F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 00:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCPX5o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 19:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCPX5n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 19:57:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30BCE2747;
        Thu, 16 Mar 2023 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679011062; x=1710547062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=adWxWmD8aatnjV92GJXS+ijGM4SC2E3CtJ8BknN+Xnw=;
  b=TVacS7YkUlhtNQfuoLsL7Jc+Xt/dvJ47do3XdoxIEMR5H/V7JhTnhKSh
   yvftSXK3wG/ITc91uiq7qRg32Qh0psiS+stiZE/CNlr8BjbCtfKdczLBX
   Mz90yTC/2JK1vp8HgYgslyIkNpX2PMAiA1qv6FxEpifV59TCN5sIaC8hV
   jSe2w0iguc22T7Vc+Hm0FSrAGO2VV01gPeMoxeBZo7DZrAF8W4YCIZlOr
   BU7SgYJnMwkFhCPceidm1H5xWIGbnRZJ8HrQQGoXVA9kVTGpRsdqYwh+0
   o8gdrk2ExqamMcod7AEN1TPyfBReV4aZqgwiXCV/+Ih7u6kxwsYvcKbYx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339682496"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="339682496"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 16:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="925946689"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="925946689"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2023 16:57:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 16:57:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 16:57:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 16:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLiYQCFdwfdQO+o6416I8DbIhCOKFVYiwSmAVAI44/vcrC8gPgBc7xgNRZatG8weDqMxyrg0cdnIDzZsc3ek6P5TzWpH7igIXPAa0ip7Fy9u/4yQgOEIktTSCWSToEtSyibf5huyReleQjdB+s8mB0NheelheHuK4Pw86vlmEjNKy7roMPLULgaklAWhisENK6IhkLr9DVfLtwrYlAOVvziXQSI4hqU/gTYRdrUiiSqJnxeFjwfnOBM502vltmjkhGAM0geuKHC3ksncJCjbpDOQwV0EK2pvd75Q3JdGcSq9mcZttw8wPwvx3NsEBY6TCcTCi8417DPcOSRLwgi6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgHRZfpZftKbIm7Nwd6bjdhjxGJxYYtvmSZ08tLWb24=;
 b=KXJUbxcNSPAQw6lJOHinChEaYiRPe5O5wpIf+1uG+fQf23T0FOXvsWsrH3jMTy4F3QbJWKLzwahZroko4qV6/fAxD9XlY471Gd2JjnTeukooHisRjOtpcBdMsCEfGwg3j001dBBZHLc1B7l30AGesz6M6vi+31iGvuwwovlymeV3LGttxjBckmg0qaPtSuG5y4E1X3wXizza7JeQrXYWU0fyQ/k8Hr/vPfA8vCgQOsTOelgFmkBE7n+ITaPJX05VqDgQQcm6kr5YEzHTCJKMBuQb/cGS4bYbI+WFftRilCGG4St0cIhWnYdyM5SKPQlr+cRFNo7cKRYofhhhy5DjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB8231.namprd11.prod.outlook.com (2603:10b6:8:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 23:57:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 23:57:33 +0000
Message-ID: <43c53ae9-6cc7-0fa7-584a-7720569179cf@intel.com>
Date:   Thu, 16 Mar 2023 16:57:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-32-gregkh@linuxfoundation.org>
 <76db3d98-2d09-54de-ab46-0ec9d743e05d@intel.com> <ZBLsYNXXCBkb8QlO@kroah.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ZBLsYNXXCBkb8QlO@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f0265a-cc5c-44af-b670-08db267a35c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee34/lhFg+fYU0CsMTtPIe6pwLMKFX2c473e19WKPDrrtg0t0Dri5QFsgw2od2qqAlypdBceRWgQvhttduD8bEuKGB7WVQ5I6rWLsJ5zdm3n48fZSCqBPAdQE83auxV7UAlmSnXYm2eTubg4vcsps5MhQtquGDUr8Yytc7egABVWCramEbqlosrDzJb2Ip1A7EgybpEia01jB5iXz338YQXGzj7dAK2V8WEfoNmt9Yt1e/at3Uc4RhVCwcllq6KRjcf8DNKBUchintm645usvfHoKkrPE7uXWQwpkz6aWQCGBN3/9HWRMC4wrEfmxobUm8gZheKMUQRmaeEjpX6PVe8gBOmzcz+1ROpYwguvz0YI2wOfzyhKB/2TBgdnSHkylCBRVOjHF1TlEJG3mUic0YL3I0YtG8NCXYRf/M2inHkCFQyXhS9VxponDCPqqrXLVB+mjqNHs9qqFQBp82M4E3/NqyLEKiZDPFilxP6imAskb2Z9i0A1KfwQh9lPGKaunQwzB7jz9yHAS8PKbtpP5/rgEDB/e4ve+GbuZANqxxiNzYzJUFfq3e4akVvECKDjc5EjIaOsS2m50/IGmMZX7CrNVUg1PK2xAE0vgc9yMOv+OQradU8LthAKioO3JR0CvGyp4nwYuFqb/EAb/DcaVl0VXNIYLYX09ugh7mMKwzx0dKQifmBdx7izFRhXi1Q9+5QpV4y80Upk7+NVLN/xP79xM6+ScQYBbZin0HaTYVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(86362001)(31696002)(82960400001)(38100700002)(4326008)(36756003)(44832011)(2906002)(41300700001)(8936002)(5660300002)(6916009)(2616005)(26005)(53546011)(6506007)(6512007)(186003)(83380400001)(54906003)(316002)(66476007)(8676002)(66556008)(6486002)(478600001)(66946007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9xRzBFbHA3OVlvaDZ3YU9mZ0xLM1VzV0R1WnpLQU90NEI3YW5td1hFcW9J?=
 =?utf-8?B?cmFOKzJaZmdPc2xHdnJ0UVcyMDhyNWFobkpodTV3cGtkREZ5VWdKMmd5YlVQ?=
 =?utf-8?B?K25OempHaHFPQ1Y2Qi8zRm9xNGZtWFNxbUJIeld2eVNLZVZlalNBOWRLVFdp?=
 =?utf-8?B?a040eWNsTktBWHBYK2IwVUpGSzBZQkdyaU1peGpHd2hvWUlHV3BSRnJaNGVw?=
 =?utf-8?B?UFg4QjBiMURibmtRSHlGNHhib29xdjdjdm53cklabjAwaUtHeVpjemJIM2hP?=
 =?utf-8?B?eUNTWk4yNVY2R0xRVS9MNzBHQmpadnF0NjY1cEttV3ZWUmlON0Mvb3FTQTlD?=
 =?utf-8?B?VEFteXp1bzdWSW9aK094TmpZcENQWmVYM2g2dlBoNEhGUnM1Yks2V2R1Vk9z?=
 =?utf-8?B?V3QwcnNxUTh6WldCNWw2SC9IVjRMM2NYWWo2VWI2UVN0Tm5Cc1ZncTRhaTkr?=
 =?utf-8?B?ZTVqRU8wOGI0SG5IUEdPREdMZnMzR2lNeXBSTTJ3dDMyeFJlTnZWamp1VzZC?=
 =?utf-8?B?R254STR3RUQxTy9HcUFwK0ZYN1dXbVlHTHA4OEx3ZEFlbGtPelBCelNiaWFK?=
 =?utf-8?B?NVF2SzNLcW5KNU83UzBXWGV1aTJvNUgwbnBLVTVmUlVIdm9BR2p1dXIvczdK?=
 =?utf-8?B?UHUzTlVNRjRtWDltRldMWXBtVTRIWmJ6b2pLUTdMZEdSYzJjaFhUeWpYQ0tn?=
 =?utf-8?B?MGt6dzNJbFM1TGtkMnduR3dLYjVudVNIVXdaVWhPWmZkbkFYajFNZk5pOVBP?=
 =?utf-8?B?YU92MVRoblNmeWg2cFNRRzdKOGVma1N2eE5ZMmk5RDNlM0FDUmFrS2dOc3V0?=
 =?utf-8?B?Y3lpNW93RzVUbmNwZ2Q5TTkvSEx1MjNiT1Bta2cxVDJjdkVXZkJBR2R2M0hM?=
 =?utf-8?B?VHlpaGlpVE4rME84cUdhS0szQnpoMWtXeWM4WFlGT3lqTHFJRUFwVEhtWnF2?=
 =?utf-8?B?V0hYdUdoNXZ2M2V1V0NVUFFYSU5NYzJyRWxkT0wvUEpxOEhvVXFhL3NWZUNk?=
 =?utf-8?B?NlViVWkxMkxwNlkzZ2k2cmh1enBDOXF6WktreVprMWY5SlZCbnN0bmZscEpG?=
 =?utf-8?B?ODhXbDJIc0hPZ2lFeHlUNGFDbmlJVXFXMEVCMDVrT1hrWDhzbmhNNXA4Si9C?=
 =?utf-8?B?VlFPNFdHR3lRYW5MOWtoanRKMWFrQ1pCVG0zLzNMY3MyUFo0MGppZlZySUo5?=
 =?utf-8?B?NzV4MUg0S1VPM0xjcHEvWThmZ2lDTzEwblEyQ05QSVJ2L2EyN0FlNXNHVnhL?=
 =?utf-8?B?dDlndkU1OEYyNUppdGd3S1RlZUZsSnZMTmw0YU00ZmJ4bml4ZDBhS091L0U2?=
 =?utf-8?B?c24xb0VJNkxaSG9oTHpUcWlQZGVxMlBuVTJBL1BmQ0hBckJuYys5VEsvSzhZ?=
 =?utf-8?B?Vk9ldEZhZjVkQU9GSU4vZHdRbmdjdFlYZ1dvVG9ONEhUUXR4VnBvUEp2WTFJ?=
 =?utf-8?B?RnJCR1ZJQ2dpSjUwc081K3g4d0xHdWtwZ1hlVzN1VXBHVGhsbTQ2NnRGWkxl?=
 =?utf-8?B?LzJZM2JTTlV0d3AyVkdtZW1yRnJ2WVJWc1hSVE8yVEhHZG1LdERudEtDa2Q2?=
 =?utf-8?B?MTRsM3BDaGcrTGNCUk9nbmFrSUd5SlR3ZVcrKzJKcm9KN1VsbHpmOXpTWlpP?=
 =?utf-8?B?TE9SZnNsaE9helVENFJ5dnN2N0ZIL2tRaUZoUlJuQmtJSlRWOWV4NFlqLzlv?=
 =?utf-8?B?ZHBQdmdwb3plM1Zla2luN1ViRFZ5dXpsZCtWcTArM1hBYlBuV0ROakNLL3FO?=
 =?utf-8?B?c2RSZUdIUjlPNEhHNWdUTjI4VU1ONHNIWVhNRGs0L2haZy9SYkc4bjl3UVdm?=
 =?utf-8?B?MUxDTllSTk14NlkyeVpDWnh3Qm9CWDBTSml1R3luWldBa1RDeGU4bEV4N1FX?=
 =?utf-8?B?TTRURDdrS3ZTK1dZNVZxbGFKYiszMjIweURMS3BoOHhGME5RSlArRkljK05q?=
 =?utf-8?B?QTJXNlVqeE84K1RNQklGelJJMkN6ajdHNUJ6NkxMbTJlNTJDTUxSQjNkKzNL?=
 =?utf-8?B?UkpldEg3YnE2TXZOaTlwSE1uVVd2UXdJV3BWMHhCajBzTXdyYldZdjFTeFd5?=
 =?utf-8?B?ZHFnZFg2eDFsZzRKT2lyNnU2VEpGaHdoSXArNlVlYTZTTmd3VFBLaHB4aVlL?=
 =?utf-8?B?YnpCdXVsUGZTRnZFa1BCN1k5L0Jyejdhdk1zbGZrcHgra0xCZDRsYmV2dC8x?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f0265a-cc5c-44af-b670-08db267a35c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 23:57:33.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2p4uW5WVO9QS7++J4M8RksjEpKtoILDnOlub7tG/JDUmuxOr7IZo+VK4BGo2dShG7HUx8NOGgyjWinBENlBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8231
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Greg,

On 3/16/23 03:16, Greg Kroah-Hartman wrote:
> On Mon, Mar 13, 2023 at 12:07:27PM -0700, Fenghua Yu wrote:
>> Hi, Greg,
>>
>> On 3/13/23 11:29, Greg Kroah-Hartman wrote:
>>> In the functions unbind_store() and bind_store(), a struct bus_type *
>>> should be a const one, as the driver core bus functions used by this
>>> variable are expecting the pointer to be constant, and these functions
>>> do not modify the pointer at all.
>>>
>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Vinod Koul <vkoul@kernel.org>
>>> Cc: dmaengine@vger.kernel.org
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>> Note, this is a patch that is a prepatory cleanup as part of a larger
>>> series of patches that is working on resolving some old driver core
>>> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
>>> its own, but I'd prefer if I could take it through my driver-core tree
>>> so that the driver core changes can be taken through there for 6.4-rc1.
>>>
>>>    drivers/dma/idxd/compat.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
>>> index 3df21615f888..5fd38d1b9d28 100644
>>> --- a/drivers/dma/idxd/compat.c
>>> +++ b/drivers/dma/idxd/compat.c
>>> @@ -16,7 +16,7 @@ extern void device_driver_detach(struct device *dev);
>>>    static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
>>>    {
>>> -	struct bus_type *bus = drv->bus;
>>> +	const struct bus_type *bus = drv->bus;
>>>    	struct device *dev;
>>>    	int rc = -ENODEV;
>>> @@ -32,7 +32,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
>>>    static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
>>>    {
>>> -	struct bus_type *bus = drv->bus;
>>> +	const struct bus_type *bus = drv->bus;
>>>    	struct device *dev;
>>>    	struct device_driver *alt_drv = NULL;
>>>    	int rc = -ENODEV;
>>
>> After applying this patch, warning is reported:
>>
>> drivers/dma/idxd/compat.c: In function ‘bind_store’:
>> drivers/dma/idxd/compat.c:47:47: warning: passing argument 2 of
>> ‘driver_find’ discards ‘const’ qualifier from pointer target type
>> [-Wdiscarded-qualifiers]
>>     47 |                 alt_drv = driver_find("idxd", bus);
>>        |                                               ^~~
>> In file included from ./include/linux/device.h:32,
>>                   from drivers/dma/idxd/compat.c:6:
>> ./include/linux/device/driver.h:129:59: note: expected ‘struct bus_type *’
>> but argument is of type ‘const struct bus_type *’
>>    129 |                                          struct bus_type *bus);
>>        |                                          ~~~~~~~~~~~~~~~~~^~~
>>
>> Should the "bus" parameter in driver_find() definition be changed to const
>> as well to avoid the warning?
> 
> Oops, yes, it needs an earlier patch in this series, sorry, I didn't
> call that out properly in the notes section of the patch.
> 
> So I can just take this through my tree if that's ok.

Sure.

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
