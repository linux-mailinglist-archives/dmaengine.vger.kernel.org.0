Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206906A77D5
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 00:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCAXkj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 18:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCAXkc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 18:40:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E456792
        for <dmaengine@vger.kernel.org>; Wed,  1 Mar 2023 15:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714002; x=1709250002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQMbcOOczaimldzv0bgP1g0ikzQhDBIVGPrxh2EkH/o=;
  b=FjncwQkmaSuW5m2fMYezyZDslyqwrSdmqto4ETlDttXN6c+dnddaGgPE
   NOrPYRKxYZKEBD6GC0ESnrocK/TP/5ULuTZbGYdWI/qWtCFiNhbU+L1b2
   309Vt9kvrv6MpqYYnHxBa8xX9lQs/BXr4vGa8Bf/PTX8tIHnPax6U0qpS
   YgWnJupCcsGv+Y17ure6bCqhZQfxxt6unH+KqqSxiwBcRPIZLTFCkdwbB
   R23GWboXwnWg8JsLvyWTH0O17qKRCu2xoBRrfnniS3xG+j56GQRl6EoVX
   dp6T3GooJQOxv/d+/m8E+57v3tiK2SMtbTOYVhansxPsTV6O74I2JYZph
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333282721"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="333282721"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784557786"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784557786"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 01 Mar 2023 15:39:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 15:39:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 15:39:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 15:39:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ5R5Ss33nrP+UtgyP15ov4hQ8wY9IMFVKBvs5cmDAQdXQZD3aEoctadP4tBnnIso8dPhkoLbM/GYqBpTM0vM96GKSQQAyMyvW0XmWd8csv7V4m/ZvzeKSaWIh2w7NQH8ChQ8cUBuJzhcLzAVo0RCDeYfsz2kchG7SGhHVBepV61KAzmIfkG94OTCzCCxPJ8LanX/dFygUBWog02XUV+GNNZ4vKYanlGDEyIOMgVxro1CXcstDGZ+x3gLLgencH3MnOt+CtFY6WD2wcooMeGgx6qNp+qP3XJtLOZnEJiFNhvQL4bVLv7LF9SzqiFWYcqNETMOQqKfqNcSlss3qA7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VYHiSI+fnpVDRUQ0LtVb5bZzNb69PcFBdseJiJ2Yso=;
 b=V0oCNLqnLxLgpWLnnUqXyEsgiVeB+w4Rxdto8+uDV8r9o6hsq5bxGqjiLltj9/7jE1y5Z/z9VjB5VwwlenzbqGq9Ik5y/BhNe+uJc3F3UCVCl7+enxJYRu9i+phOuGS9lLrCpAXFxZP96kUO6Dj51k8N2zblmPfiya6a8mZOuAVfTwFJqEjx3HJ9yvhqhEaByXDOXcOF3Ni7wdcNjaTIvHoZ3wXePFDfr0jv1JaNR9UEkWc0B+/G6TPW2R49P8zfnX3GwfkMWrQlunag+/sI/wXbCJyICak7KGjGle4IN4MAtilA7cnGkMbKx0RGhTruEpnHPwUteFpgo7TD/joryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 23:39:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::726b:a43a:2100:7171]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::726b:a43a:2100:7171%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 23:39:53 +0000
Message-ID: <f1f6e3b9-a1cb-cebe-d173-a42cec7febd1@intel.com>
Date:   Wed, 1 Mar 2023 15:39:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <dmaengine@vger.kernel.org>, Tony Zhu <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com> <Y7RpuqbTAM11wVQG@lucifer>
 <Y7r/BjWEP2q64TGy@infradead.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <Y7r/BjWEP2q64TGy@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe3ef2d-a8af-4e88-7e84-08db1aae41d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIL99ogjHscR08sm01Se/ga3PLX7xXF7MGIhCs7XDTL1YihemldRyHDqpBnovwuvK205+1cvvG/v7DjgsPkaf8aiU2JrxFC9UTOXZZks94ACkS1o4q3n7hEMnnzFxB4UxzAc14rWsEtdoJPoXL8XBEdWvs5z6IBxfzIvK+tNQs7/ARZ6CBLRdZB79DIWE0m5N7QEWM8ofOpe5c8YKpb4wFgie9Ys4eiDzZlFOBGjGJBxncDy3hYyRsJG+NA1gitg8r2MtzynSAjIeoHFMuY5H/OzWRc3W9CnwuZiDdDc5YXrVKCW67+cP43n8S3tNrGo99gvTcpvPjWN5IneJszv6sW4FReOTAPoWb/Zfm1hYwrKZA593IBv546cK9kT4ok4CkMwuYx960ubz0Xo16LyJWeWHaZqrOA096N9nNf4c5rgSyfRrbjM/wDCmT/asSR2XdFS1R2j1vhoLlEiQjShkGgXEw5HMaiPmZ3e51sN5r5eP8t16Ny+OxljSaKgcLql73ywT1Nwoctm3ZcaejLnF9rxiTquW75mL4AEXa5tF9pM50xSeDFGUVx0R8bI0iTAuUCRtoXlETtoGDh9FNRagwkKAJxrLYQAbRi25+24hzbgUavmq9IXYPq6eTvoFvEWR5P6pYkoO+d790UPTP28FTWiNvoxn+RK5NTqmZ8nL/l292bloQD6hzmd/qDrYKCIWWboZIJ9PtZQvY6OqeQBDbEdxBjeaFZThu3/TxfwRoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(36756003)(31686004)(478600001)(5660300002)(186003)(26005)(6506007)(38100700002)(6512007)(53546011)(83380400001)(8936002)(6486002)(2906002)(54906003)(110136005)(44832011)(86362001)(41300700001)(316002)(31696002)(2616005)(66556008)(82960400001)(8676002)(66476007)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNpVXg0djdtSmt6eG1QeG5VZXVQM3gxSzZKMExFQlMrRUU0WnhxN3lTSzll?=
 =?utf-8?B?eFZuK0hqUFgzNXcvUGpibHV6WC9EUWlxMDNjYk40bkF6QVd3K0Z4YWRpdnc4?=
 =?utf-8?B?anVSSDNibGhvM25OVkJyRlJKRjNVejU1OVB4ZTNPY3ZlZlkrWWQ3czFDa1R4?=
 =?utf-8?B?VWp4eFdPQ3AxK1FydjIrZUgrWVBoWTFpeWVWUlV3MGovc2RZWkUrV0t5Vjgw?=
 =?utf-8?B?UitoUm85WXkzM1VqN3prWVkySDBwZENYQW1ubVRPN0o0eFYrMGdCOWRiS3Jy?=
 =?utf-8?B?SGRrVmdGazcrSjdmQUNTWUUyT0MyVE9UWDNUcE52eWtjUUdzSTZSOWFpRlZo?=
 =?utf-8?B?UTl0Z3ZTcVN5ZjIvbmdrbEREaDFsLzFBR2RqTDg4VDRGOG1BSXUyT2hvQzFk?=
 =?utf-8?B?bUw0U0pPaHRCV2JpbjNGMGFUOXk1ak1FNHIyMitxeWFncUZQSTV1MnIvOVF3?=
 =?utf-8?B?WkJPdnA0S3FsaitJMFAyRXU3ZkdwOVBORFl5cHY3a1ZCK2tIcWRSczhQMm9w?=
 =?utf-8?B?clN3cWJpenkrc2VVZm9VM3NXRVU1SE5lQ1dQQWE0YnJaQkEwZERxSmwvd3pR?=
 =?utf-8?B?cEp3RGJuM0Nwc3VXTWU5b2Z4aFV2aTZIenhud2YvTE1LNG5UQ2RlMzBlZHpS?=
 =?utf-8?B?cWxHdlh6dW9nVWZCd1dlV0tDa0FDekE1cS9MK25acGxMT3F5cHJMOW5mNW03?=
 =?utf-8?B?NmFIUHl4L2VZUlBaSGVBdDc0K3QwOEFmbWF0ZlFFZG80dS9iM0JUNEJqc0pl?=
 =?utf-8?B?NFJ6UjRLam13cVVJaTdqYmc1US83NFhEZndUK1dNZXQ5elNHei9pZ1ZvVy9P?=
 =?utf-8?B?cjRwTlllb0tEZ1pSU1NoUWx1bi9jbE1DRHg4Nnd2U2REYXp1YWNPOWhUbVg2?=
 =?utf-8?B?cnhBSDhzTWthR1RzUFZTZEhSNHU4eVl4b1hHYmFTalR2RG9oTWY1dXAveU9u?=
 =?utf-8?B?ekIwRGJpNFlWVG9aUVFPOWQvL1doU01oK0ZNbXVSR3VZeHJVdkVTRUprVFk0?=
 =?utf-8?B?MVZpam9VL1hJSVlwd0w1bitjaTVjYU4rS0NGYUJpOEdHVTRZQUtXRWYzUTdX?=
 =?utf-8?B?ck4vVU5ja2kxRWJUZXg5amwyOXlrOGw4SFQxenZnSHE1c1I4KzF5eUl4TE9P?=
 =?utf-8?B?TEdMNGJoUTRJREc0bkNSNVVXS0ZTZHBjbVNsZ1dtd1lDaFpIMG9BdkppRUV5?=
 =?utf-8?B?ZE01UGJGWktlUzJlNEZHVjM1c2pqMjNUVUhKS2FvK1hPa2tNWUlxbmtQa2RT?=
 =?utf-8?B?MzhiOWJzN0IrU0lQTEZ6UWlkR3BNdmlZbStZb2xxZTEzWldyN3VwbG5JeFcz?=
 =?utf-8?B?YmtKazZ5MDZBTVNtWCtkdUJOQXJvdHdlVmUyZXRnQk5CZVBmZFJ2cmFZYzVr?=
 =?utf-8?B?Zk93R3VqVUZ5Y1ZmRDNQTE5HU05SalRUTC8rMGozcEs3UmdZdWpQYTdzZXlC?=
 =?utf-8?B?S3YyV3ZoU2NlQUhMWlpWTzFoRlo5TzJMRDcvY3dUZVNjSWdDdGx3Rk12S1ZR?=
 =?utf-8?B?dkVHbWl1YU1Vdy90Sms4ZiswaUpjR01UcVA4ZFRhcThTODJKUnNKTFJwNFhT?=
 =?utf-8?B?OTd3SWtGZVgvbnFNYW5FWnRqNHdvL0c4Vk9vd0FsYU1Xdmc3YVlHalVBMjdM?=
 =?utf-8?B?NzNKSkltOG94NmtTUU85S0ovSVJ2RVFWK1k2dnFYdHBFMHJEaGM3bnB4RCtH?=
 =?utf-8?B?b0xlUTRBUEN0SzAwTlhMTzVVTWhLb1kyUDA0TC9PNlMvL2orR0FMa2YvNjZT?=
 =?utf-8?B?MXNOZGwzWDRUNlBFM2ZYblNlTVV5R1lpZTRTTGxiREI5RlVYZzIremRyMVJ0?=
 =?utf-8?B?VVdJR2k5L3RmWEtZbHJqY2RTVE9hMDdITEdHTHdYV2FzRmc1ZmFWZ2drMy8y?=
 =?utf-8?B?WjJ2TXlMUGIwa2FtWnBoeVRmVmx0V01sMmtLVmhobDg3dy9vU0o1NU8zZjcy?=
 =?utf-8?B?RHFtaCs1c0FJYnZWSFN2L21ERGJRczFETUtYQ2JlQndzTlVFWHp1aDY3MVNu?=
 =?utf-8?B?UWt0RVNGZWk1bms0VnB4ckYyYVlwbDN6a0hBWEowc3NKVlBwV2JjdHE1RXVs?=
 =?utf-8?B?SndqRWhQanh0UlpCNEhKSnl3b2dZTk5zdE0vZWtSK1RlUk9wWUxNSHFhaVA3?=
 =?utf-8?Q?E1HN5jlaHnydqlBlI6rH3q6tv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe3ef2d-a8af-4e88-7e84-08db1aae41d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 23:39:53.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKlgog1s+ngflLW0L9UvVHHLN8E70UGzLKNIn5GD+2wgCmOjkNuRVMLcipNAD5wZUcskD10o8aY+JVSHdhV6Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Christoph,

On 1/8/23 09:36, Christoph Hellwig wrote:
> Exporting access_remote_vm just seems like a horrible idea.
> 
> If a driver needs to access a different VM from a completion path
> in some thread or workqueue (which I assume this does, if not please
> explain the use case), it should use kthread_use_mm to associate the
> mm struct and then just use all the normal uaccess helpers.

To trigger fault by IDXD device, user app frees the fault_addr pages.
After kthread_use_mm(), the IDXD driver cannot directly call
copy_to_user() to copy data to fault_addr because
the pages are freed by the app. If the IDXD driver
tries to copy to the app's fault_addr, it needs to get all the pages,
kmap, copy_to_user_page() etc, basically majority of the 
__access_remote_vm() code. Without exporting access_remote_vm(),
the driver has to re-implement the function for the copy to work
in IDXD driver.

Maybe a simple exported IOMMU wrapper in iommu-sva.c can help here?
CONFIG_IOMMU_SVA is bool and needs to be set for Event Log to work.
So the wrapper is exported and can be called the IDXD driver or any
driver that is on top of IOMMU SVA.

No need to export access_remote_vm() any more.

Plus with this wrapper, no need to export iommu_sva_find()
(in an earlier patch). So the code will be more clean and concise.

Is this OK for you?

struct mm_struct
*iommu_access_remote_vm(ioasid_t pasid, unsigned long addr,
			void *buf, int len, unsigned int gup_flags, int *copied)
{
	struct mm_struct *mm;

	mm = iommu_sva_find(pasid);
	if (!IS_ERR_OR_NULL(mm)) {
		/* A reference on @mm has been held. */
		*copied = access_remote_vm(mm, addr, buf, len, gup_flags);
	}

	return mm;
}
EXPORT_SYMBOL_GPL(iommu_access_remote_vm);

Thanks.

-Fenghua
